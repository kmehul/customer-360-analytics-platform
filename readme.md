# The 360° E-Commerce Analytics Platform

## 1. Project Scope

This project aims to build an end-to-end data platform for a growing e-commerce company to address a key business challenge. Currently, the company's data is siloed across multiple systems:
* Sales and customer information are in a PostgreSQL database.
* Website clickstream data and product reviews are stored in a MongoDB database.
* The business scenario includes a real-time stream of new orders, which the project will **simulate using Apache Kafka**.

This separation makes it impossible to get a complete view of the business or to answer critical questions that link customer behavior to sales outcomes. The mission of this project is to unify this data into a "single source of truth," enabling comprehensive analytics and business intelligence.

## 2. Tech Stack

The following technologies are used to build the platform, each serving a specific role in the data's lifecycle.

| Category                | Technology                    | Role in the Project                                                                                                                              |
| :---------------------- | :---------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------- |
| **Data Sources** | PostgreSQL & MongoDB          | Provide both structured relational data (e.g., user accounts, product info) and semi-structured NoSQL data (e.g., event logs, reviews).        |
| **Real-Time Streaming** | Apache Kafka                  | Simulates and ingests a real-time stream of data (e.g., clicks, orders), showcasing the ability to handle modern, high-velocity data. |
| **Orchestration** | Apache Airflow                | Acts as the "brain" of the project, scheduling and managing all data pipelines from ingestion to transformation.                          |
| **Cloud Platform** | Microsoft Azure               | The foundational cloud environment where all services and data will reside.                                                                 |
| **Data Lake Storage** | Azure Data Lake Storage (ADLS)| Serves as the central landing zone for all raw data from PostgreSQL, MongoDB, and Kafka before it is processed.                        |
| **Data Processing** | Azure Databricks (PySpark)    | The engine for running large-scale data transformations. It reads from ADLS, cleans and aggregates the data, and loads it into Snowflake.    |
| **Data Modeling** | SqlDBM                        | A browser-based tool used to design and document the schema for the data warehouse.                                                       |
| **Cloud Data Warehouse**| Snowflake                     | The final destination for the clean, structured, and analysis-ready data.                                                               |
| **BI & Visualization** | Tableau                       | The tool used to connect to Snowflake and build insightful dashboards for business users.                                                 |

## 3. Potential Workflow

The project is designed as a journey for the data, moving through five distinct stages from its raw state to its final, analytics-ready form.

1.  **Stage 1: Data Sources**
    * The platform taps into three distinct, simulated sources: PostgreSQL for structured data, MongoDB for semi-structured data, and a Kafka stream for new order events.

2.  **Stage 2: Ingestion & Raw Storage**
    * Apache Airflow orchestrates the data movement, landing all raw data into Azure Data Lake Storage (ADLS).

3.  **Stage 3: Transformation & Processing**
    * Airflow triggers jobs in Azure Databricks, which use PySpark to clean, join, and aggregate the raw data into a processed state.

4.  **Stage 4: Data Warehousing & Modeling**
    * The transformed data is loaded into fact and dimension tables inside Snowflake, our cloud data warehouse, which becomes the ultimate source of truth.

5.  **Stage 5: Business Intelligence**
    * Tableau connects directly to Snowflake to build dashboards and visualize the data.

## 4. Architecture

<img src="Diagrams/architecture_diagram.svg">


The architecture is composed of six key layers, moving data from generation to insight.

* **1. Data Generation:** The process begins by creating realistic mock data to simulate the e-commerce environment.
* **2. Local Sources:** The generated data is housed in local containers representing the company's operational systems: PostgreSQL for relational data, MongoDB for semi-structured data like reviews, and Kafka for streaming order data.
* **3. Orchestration:** Apache Airflow serves as the central command center, orchestrating the entire data pipeline by scheduling and triggering tasks, from extraction at the source to loading jobs in the cloud.
* **4. Cloud Ingestion & Processing:** This is the core transformation engine. Raw data is ingested into Azure Data Lake. From there, Azure Databricks uses PySpark to clean, join, and enrich the data. This layer also integrates with Azure Cognitive Services for AI-powered features like sentiment analysis.
* **5. Data Warehouse:** The processed data is loaded into Snowflake, a highly scalable cloud data warehouse. This serves as the single source of truth for all analytics.
* **6. Business Intelligence:** Finally, Tableau connects to Snowflake, allowing business users to build interactive dashboards, explore the data, and uncover actionable insights.


## 5. Dimensional Details

The analytics layer of the project is built on a **star schema** data model, which is optimized for business intelligence and reporting.

<img src="Diagrams/star_dimensional_model.png">

As the diagram illustrates, the model features a central fact table, `fct_sales`, which contains the quantitative measures of business events (e.g., `sale_amount`, `quantity`). This fact table is linked via foreign keys to three descriptive dimension tables:
* **`dim_customer`:** Contains all customer attributes. It is designed as a Slowly Changing Dimension (SCD Type 2) to track the history of customer data changes.
* **`dim_product`:** Contains all product details.
* **`dim_date`:** A pre-populated calendar table that allows for easy and efficient time-based analysis.