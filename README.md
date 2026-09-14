# OpsInsight — IT Incident Analytics & SLA Breach Prediction

##  Project Overview

OpsInsight is an end-to-end IT incident analytics and machine learning project designed to analyze incident patterns, identify SLA breach trends, and predict incidents that are at risk of breaching their SLA.

The project combines Python, SQL, Machine Learning, and Power BI to transform raw IT incident event data into actionable operational insights.

---

##  Business Problem

IT support teams handle a large number of incidents under defined Service Level Agreements (SLAs).

The objective of this project is to:

- Analyze historical IT incident patterns
- Identify factors associated with SLA breaches
- Compare SLA performance across priorities and categories
- Predict the likelihood of an incident breaching its SLA
- Present operational insights through an interactive Power BI dashboard

---

##  Dataset

The project uses an anonymized IT Incident Log dataset containing:

- **141,712 event records**
- **24,918 unique incidents**
- 36 original attributes

The original dataset is available on Kaggle:

https://www.kaggle.com/datasets/shamiulislamshifat/it-incident-log-dataset

The raw dataset is not included in this repository.

---

##  Technology Stack

- **Python** — Data cleaning, EDA and feature engineering
- **Pandas** — Data manipulation and analysis
- **Scikit-learn** — Machine learning
- **SQL / SQLite** — Incident analytics
- **Power BI** — Interactive dashboards
- **Jupyter Notebook** — Development environment

---

##  Project Workflow

```text
Raw IT Incident Event Data
          ↓
Data Cleaning
          ↓
Exploratory Data Analysis
          ↓
Incident-Level Dataset
          ↓
       ┌───────────────┐
       ↓               ↓
   SQL Analysis     ML Model
       ↓               ↓
       └───────┬───────┘
               ↓
          Power BI
          Dashboard
