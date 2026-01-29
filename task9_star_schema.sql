-- DIMENSION TABLES
CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50)
);

CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    sub_category VARCHAR(50)
);

CREATE TABLE dim_date (
    date_id SERIAL PRIMARY KEY,
    order_date DATE,
    year INT,
    month INT,
    day INT
);

CREATE TABLE dim_region (
    region_id SERIAL PRIMARY KEY,
    country VARCHAR(50),
    region VARCHAR(50),
    state VARCHAR(50),
    city VARCHAR(50)
);

-- FACT TABLE
CREATE TABLE fact_sales (
    sales_id SERIAL PRIMARY KEY,
    customer_id INT,
    product_id INT,
    date_id INT,
    region_id INT,
    sales DECIMAL(10,2),
    quantity INT,
    profit DECIMAL(10,2)
);

-- ETL LOGIC
INSERT INTO dim_customer
SELECT DISTINCT customer_name, segment FROM raw_sales;

INSERT INTO dim_product
SELECT DISTINCT product_name, category, sub_category FROM raw_sales;

INSERT INTO dim_date
SELECT DISTINCT order_date,
EXTRACT(YEAR FROM order_date),
EXTRACT(MONTH FROM order_date),
EXTRACT(DAY FROM order_date)
FROM raw_sales;

INSERT INTO dim_region
SELECT DISTINCT country, region, state, city FROM raw_sales;