-- CREATE TABLES
CREATE TABLE common_data_types (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    description TEXT
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    age INT,
    department VARCHAR(100),
    salary DECIMAL(10, 2),
    bonus DECIMAL(10, 2),
    manager_id INT
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category_id INT,
    price DECIMAL(10, 2),
    description TEXT,
    discount DECIMAL(10, 2)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    amount DECIMAL(10, 2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    ship_date DATE,
    quantity INT,
    unit_price DECIMAL(10, 2)
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT,
    quantity INT
);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100),
    status VARCHAR(100)
);

CREATE TABLE financials (
    financial_id INT PRIMARY KEY,
    revenue DECIMAL(10, 2),
    expenses DECIMAL(10, 2)
);

CREATE TABLE quarterly_report (
    report_id INT PRIMARY KEY,
    total_sales DECIMAL(10, 2)
);

CREATE TABLE rental_history (
    rental_id INT PRIMARY KEY,
    rent_date DATE,
    return_date DATE
);

CREATE TABLE countries (
    country_id INT PRIMARY KEY,
    country_name VARCHAR(100),
    continent VARCHAR(100)
);

CREATE TABLE addresses (
    address_id INT PRIMARY KEY,
    city VARCHAR(100),
    country VARCHAR(100)
);

CREATE TABLE articles (
    article_id INT PRIMARY KEY,
    title VARCHAR(200)
);

-- INSERT DATA INTO TABLES
INSERT INTO common_data_types (id, name, description) VALUES
(1, 'Integer', 'Whole number'),
(2, 'Varchar', 'Variable length character string'),
(3, 'Text', 'Long text data');

INSERT INTO employees (employee_id, first_name, last_name, age, department, salary, bonus, manager_id) VALUES
(1, 'John', 'Doe', 28, 'HR', 50000, 5000, NULL),
(2, 'Jane', 'Smith', 35, 'IT', 60000, 6000, 1),
(3, 'Alice', 'Johnson', 32, 'HR', 45000, 4500, NULL),
(4, 'Bob', 'Brown', 29, 'Finance', 70000, 7000, 2);

INSERT INTO products (product_id, product_name, category_id, price, description, discount) VALUES
(1, 'Laptop', 1, 1500, 'High-end gaming laptop', 100),
(2, 'Mouse', 2, 20, 'Wireless mouse', 2),
(3, 'Keyboard', 2, 50, 'Mechanical keyboard', 5),
(4, 'Monitor', 3, 200, '24-inch monitor', 20);

INSERT INTO sales (sale_id, product_id, amount) VALUES
(1, 1, 1500),
(2, 2, 20),
(3, 3, 50),
(4, 4, 200);

INSERT INTO orders (order_id, customer_id, order_date, ship_date, quantity, unit_price) VALUES
(1, 1, '2023-01-10', '2023-01-15', 1, 1500),
(2, 2, '2023-02-10', NULL, 2, 20),
(3, 3, '2023-03-10', '2023-03-12', 3, 50);

INSERT INTO inventory (inventory_id, product_id, quantity) VALUES
(1, 1, 10),
(2, 2, 15),
(3, 3, 20),
(4, 4, 25);

INSERT INTO customers (customer_id, first_name, last_name, email, city, country) VALUES
(1, 'Mary', 'Smith', 'mary@example.com', 'New York', 'USA'),
(2, 'James', 'Johnson', 'james@example.com', 'Los Angeles', 'USA'),
(3, 'Patricia', 'Williams', NULL, 'Chicago', 'USA');

INSERT INTO users (user_id, first_name, last_name, email, status) VALUES
(1, 'Alice', 'Moore', 'alice@example.com', 'Active'),
(2, 'Michael', 'Taylor', NULL, 'Inactive'),
(3, 'Sarah', 'Anderson', 'sarah@example.com', 'Active');

INSERT INTO financials (financial_id, revenue, expenses) VALUES
(1, 100000, 80000),
(2, 200000, 120000);

INSERT INTO quarterly_report (report_id, total_sales) VALUES
(1, 300000),
(2, 400000);

INSERT INTO rental_history (rental_id, rent_date, return_date) VALUES
(1, '2023-01-01', '2023-01-10'),
(2, '2023-02-01', '2023-02-15');

INSERT INTO countries (country_id, country_name, continent) VALUES
(1, 'Belgium', 'Europe'),
(2, 'France', 'Europe'),
(3, 'USA', 'North America');

INSERT INTO addresses (address_id, city, country) VALUES
(1, 'Brussels', 'Belgium'),
(2, 'Paris', 'France'),
(3, 'New York', 'USA');

INSERT INTO articles (article_id, title) VALUES
(1, 'SQL Basics'),
(2, 'Advanced SQL Techniques');

-- OPTIMIZATION EXAMPLES

-- INDEX CREATION FOR FASTER SEARCH ON EMPLOYEES TABLE
CREATE INDEX idx_employees_last_name ON employees (last_name);

-- INDEX CREATION ON PRODUCTS TO IMPROVE PERFORMANCE OF QUERIES FILTERING BY category_id
CREATE INDEX idx_products_category_id ON products (category_id);

-- USING A COVERING INDEX TO OPTIMIZE QUERY PERFORMANCE
CREATE INDEX idx_orders_customer_date ON orders (customer_id, order_date);

-- QUERY OPTIMIZATION USING INDEXES
-- FETCH ORDERS WITH SPECIFIC customer_id EFFICIENTLY
SELECT order_id, order_date, quantity, unit_price 
FROM orders 
WHERE customer_id = 2;

-- OPTIMIZE AGGREGATE FUNCTIONS WITH INDEXED COLUMNS
-- CALCULATE TOTAL SALES AMOUNT EFFICIENTLY
SELECT SUM(amount) AS total_sales 
FROM sales;

-- QUERY OPTIMIZATION USING SUBQUERIES
-- FETCH EMPLOYEES IN THE 'IT' DEPARTMENT WITH SALARY ABOVE AVERAGE IN THE DEPARTMENT
SELECT e.first_name, e.last_name, e.salary 
FROM employees e 
WHERE e.department = 'IT' 
AND e.salary > (SELECT AVG(salary) 
                FROM employees 
                WHERE department = 'IT');

-- TRANSACTION EXAMPLES

-- SIMPLE TRANSACTION EXAMPLE
BEGIN TRANSACTION;

-- INSERT A NEW PRODUCT
INSERT INTO products (product_id, product_name, category_id, price, description, discount) VALUES
(5, 'Tablet', 3, 300, '10-inch tablet', 25);

-- UPDATE INVENTORY FOR THE NEW PRODUCT
INSERT INTO inventory (inventory_id, product_id, quantity) VALUES
(5, 5, 50);

COMMIT;

-- ROLLBACK TRANSACTION EXAMPLE
BEGIN TRANSACTION;

-- ATTEMPT TO UPDATE EMPLOYEE DETAILS
UPDATE employees 
SET salary = salary * 1.10 
WHERE department = 'HR';

-- SIMULATE AN ERROR CONDITION (E.G., CONSTRAINT VIOLATION)
-- UNCOMMENT THE NEXT LINE TO SIMULATE AN ERROR AND ROLLBACK
-- INSERT INTO employees (employee_id, first_name) VALUES (1, 'Duplicate ID');

ROLLBACK;

-- COMPLEX TRANSACTION EXAMPLE WITH ERROR HANDLING
BEGIN TRANSACTION;

-- INSERT A NEW CUSTOMER
INSERT INTO customers (customer_id, first_name, last_name, email, city, country) VALUES
(4, 'David', 'Miller', 'david@example.com', 'San Francisco', 'USA');

-- PLACE AN ORDER FOR THE NEW CUSTOMER
INSERT INTO orders (order_id, customer_id, order_date, ship_date, quantity, unit_price) VALUES
(4, 4, '2023-06-01', '2023-06-05', 2, 300);

-- UPDATE INVENTORY FOR THE ORDERED PRODUCT
UPDATE inventory 
SET quantity = quantity - 2 
WHERE product_id = 1;

-- CHECK FOR ERRORS AND COMMIT/ROLLBACK
IF @@ERROR <> 0 
BEGIN
    ROLLBACK;
END
ELSE 
BEGIN
    COMMIT;
END;


