-- ************************************** analytics
CREATE SCHEMA IF NOT EXISTS analytics;

-- ************************************** analytics.dim_customer
CREATE TABLE IF NOT EXISTS analytics.dim_customer
(
 customer_sk integer NOT NULL,
 customer_id varchar NOT NULL,
 first_name  varchar NOT NULL,
 last_name   varchar NOT NULL,
 email       varchar NOT NULL,
 city        varchar NOT NULL,
 state       varchar NOT NULL,
 start_date  date NOT NULL,
 end_date    date NOT NULL,
 is_current  boolean NOT NULL,

 CONSTRAINT PK_1 PRIMARY KEY ( customer_sk )
);

-- ************************************** analytics.dim_date
CREATE TABLE IF NOT EXISTS analytics.dim_date
(
 date_sk         integer NOT NULL,
 full_date       date NOT NULL,
 day_of_week     varchar NOT NULL,
 day_of_month    integer NOT NULL,
 month_name      varchar NOT NULL,
 quarter_of_year integer NOT NULL,
 year            integer NOT NULL,
 is_weekend      boolean NOT NULL,

 CONSTRAINT PK_1 PRIMARY KEY ( date_sk )
);

-- ************************************** analytics.dim_product
CREATE TABLE IF NOT EXISTS analytics.dim_product
(
 product_sk   integer NOT NULL,
 product_id   varchar NOT NULL,
 product_name varchar NOT NULL,
 category     varchar NOT NULL,
 price        decimal(10,2) NOT NULL,

 CONSTRAINT PK_1 PRIMARY KEY ( product_sk )
);

-- ************************************** analytics.fct_sales
CREATE TABLE IF NOT EXISTS analytics.fct_sales
(
 date_sk         integer NOT NULL,
 customer_sk     integer NOT NULL,
 product_sk      integer NOT NULL,
 order_id        varchar NOT NULL,
 quantity        integer NOT NULL,
 sale_amount     decimal(10,2) NOT NULL,
 sentiment_score varchar NOT NULL,

 CONSTRAINT PK_1 PRIMARY KEY ( date_sk, customer_sk, product_sk ),
 CONSTRAINT FK_1 FOREIGN KEY ( customer_sk ) REFERENCES analytics.dim_customer ( customer_sk ),
 CONSTRAINT FK_2 FOREIGN KEY ( product_sk ) REFERENCES analytics.dim_product ( product_sk ),
 CONSTRAINT FK_3 FOREIGN KEY ( date_sk ) REFERENCES analytics.dim_date ( date_sk )
);

