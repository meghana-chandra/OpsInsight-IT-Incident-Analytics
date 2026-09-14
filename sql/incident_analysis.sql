import sqlite3

# Create SQLite database
conn = sqlite3.connect("opsinsight.db")
# Create an incident-level table
sql_df = incident_prediction.copy()

# Remove datetime column temporarily because SQLite will store it as text
sql_df["opened_at"] = sql_df["opened_at"].astype(str)

sql_df.to_sql(
    "incidents",
    conn,
    if_exists="replace",
    index=False
)

print("SQLite database created successfully.")
print("Table created: incidents")

query = """
SELECT
    priority,
    COUNT(*) AS total_incidents,
    SUM(CASE WHEN made_sla = 1 THEN 1 ELSE 0 END) AS sla_met,
    SUM(CASE WHEN made_sla = 0 THEN 1 ELSE 0 END) AS sla_breached,
    ROUND(
        100.0 * SUM(CASE WHEN made_sla = 0 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS breach_rate_pct
FROM incidents
GROUP BY priority
ORDER BY breach_rate_pct DESC;
"""

result = pd.read_sql_query(query, conn)

display(result)

query = """
WITH category_summary AS (
    SELECT
        category,
        COUNT(*) AS total_incidents,
        SUM(CASE WHEN made_sla = 0 THEN 1 ELSE 0 END) AS sla_breached
    FROM incidents
    GROUP BY category
)

SELECT
    category,
    total_incidents,
    sla_breached,
    ROUND(
        100.0 * sla_breached / total_incidents,
        2
    ) AS breach_rate_pct
FROM category_summary
WHERE total_incidents >= 100
ORDER BY breach_rate_pct DESC;
"""

result = pd.read_sql_query(query, conn)

display(result)

query = """
WITH category_summary AS (
    SELECT
        category,
        COUNT(*) AS total_incidents,
        SUM(CASE WHEN made_sla = 0 THEN 1 ELSE 0 END) AS sla_breached
    FROM incidents
    GROUP BY category
)

SELECT
    category,
    total_incidents,
    sla_breached,
    ROUND(
        100.0 * sla_breached / total_incidents,
        2
    ) AS breach_rate_pct,
    RANK() OVER (
        ORDER BY
            100.0 * sla_breached / total_incidents DESC
    ) AS breach_rank
FROM category_summary
WHERE total_incidents >= 100
ORDER BY breach_rank;
"""

result = pd.read_sql_query(query, conn)

display(result)

query = """
SELECT
    strftime('%Y-%m', opened_at) AS month,
    COUNT(*) AS total_incidents,
    SUM(CASE WHEN made_sla = 0 THEN 1 ELSE 0 END) AS sla_breached,
    ROUND(
        100.0 * SUM(CASE WHEN made_sla = 0 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS breach_rate_pct
FROM incidents
GROUP BY month
ORDER BY month;
"""

result = pd.read_sql_query(query, conn)

display(result)



