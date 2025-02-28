-- Fact Table (Sales Transactions)
CREATE TABLE fact_sales (
    sales_id SERIAL PRIMARY KEY,
    date_id INT REFERENCES dim_date(date_id),
    product_id INT REFERENCES dim_product(product_id),
    customer_id INT REFERENCES dim_customer(customer_id),
    store_id INT REFERENCES dim_store(store_id),
    quantity_sold INT,
    total_sales DECIMAL(10,2)
);

-- Dimension Tables
CREATE TABLE dim_date (
    date_id SERIAL PRIMARY KEY,
    date DATE UNIQUE,
    year INT,
    quarter INT,
    month INT,
    day INT
);

CREATE TABLE dim_product (
    product_id SERIAL PRIMARY KEY,
    product_name TEXT,
    category TEXT,
    price DECIMAL(10,2)
);

CREATE TABLE dim_customer (
    customer_id SERIAL PRIMARY KEY,
    customer_name TEXT,
    city TEXT,
    state TEXT,
    country TEXT
);

CREATE TABLE dim_store (
    store_id SERIAL PRIMARY KEY,
    store_name TEXT,
    location TEXT
);

-- Sample Query (Joining Fact & Dimension Tables)
SELECT 
    d.year, d.month, p.category, SUM(f.total_sales) AS total_revenue
FROM fact_sales f
JOIN dim_date d ON f.date_id = d.date_id
JOIN dim_product p ON f.product_id = p.product_id
GROUP BY d.year, d.month, p.category
ORDER BY d.year, d.month, total_revenue DESC;

-- In PostgreSQL, the keyword REFERENCES is used in a foreign key constraint 
-- to define a relationship between two tables. 
-- It ensures referential integrity, meaning that a value in a column 
-- must match a value in the referenced table's primary key.