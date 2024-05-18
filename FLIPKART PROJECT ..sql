CREATE DATABASE Flipkart;

USE Flipkart;


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    payment_method VARCHAR(50)
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
    );
    
CREATE TABLE Items (
    item_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    category_id INT,
    is_replaced BOOLEAN,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    item_id INT,
    quantity INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (item_id) REFERENCES Items(item_id)
);

CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    customer_id INT,
    payment_method VARCHAR(50),
    transaction_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Customers (customer_id, name, gender, payment_method) 
VALUES(1, 'Pijush Mondal', 'Male', 'Netbanking'),
(2, 'Subarna Saha', 'Male', 'Credit Card'),
(3, 'Sohom Biswas', 'Male', 'Cash'),
(4, 'Nikhil Nayan', 'Male', 'Debit Card'),
(5, 'Suraj Sarkar', 'Male', 'Netbanking'),
(6, 'Mukesh Dey', 'Male', 'Cash'),
(7, 'Priya Halder', 'Female', 'Credit Card'),
(8, 'Ronit Ray', 'Male', 'Debit Card'),
(9, 'Ashmita Sen', 'Female', 'Netbanking'),
(10, 'Shubham Das', 'Male', 'Cash');


INSERT INTO Categories (category_id, category_name) 
VALUES(1, 'Smartphones'),
(2, 'Computers'),
(3, 'Televisions'),
(4, 'Appliances'),
(5, 'Audio'),
(6, 'Gaming');


INSERT INTO Items (item_id, name, price, category_id, is_replaced) 
VALUES(101, 'Redmi 9 pro', 15000.00, 1, FALSE),
(102, 'Samsung Galaxy S20', 70000.00, 1, TRUE),
(103, 'Apple iPhone 12', 80000.00, 1, FALSE),
(104, 'Dell Inspiron Laptop', 60000.00, 2, TRUE),
(105, 'HP Pavilion Desktop', 40000.00, 2, FALSE),
(106, 'Sony Bravia 55" TV', 80000.00, 3, FALSE),
(107, 'LG Refrigerator', 50000.00, 4, FALSE),
(108, 'Whirlpool Washing Machine', 35000.00, 4, FALSE),
(109, 'Bose Noise Cancelling Headphones', 2500.00, 5, FALSE),
(110, 'Multi-tool Kit', 2200.00, 6, FALSE);


INSERT INTO Orders (order_id, customer_id, item_id, quantity, order_date) 
VALUES(1, 1, 101, 2, '2024-03-15'),
(2, 2, 102, 1, '2024-04-01'),
(3, 3, 103, 3, '2024-03-25'),
(4, 4, 104, 2, '2024-04-05'),
(5, 5, 105, 1, '2024-03-18'),
(6, 6, 106, 2, '2024-04-02'),
(7, 7, 107, 1, '2024-03-20'),
(8, 8, 108, 3, '2024-04-10'),
(9, 9, 109, 2, '2024-03-22'),
(10, 10, 110, 1, '2024-04-03');


INSERT INTO Transactions (transaction_id, customer_id, payment_method, transaction_date) 
VALUES(1, 1, 'Netbanking', '2024-03-15'),
(2, 2, 'Credit Card', '2024-04-01'),
(3, 3, 'Cash', '2024-03-25'),
(4, 4, 'Debit Card', '2024-04-05'),
(5, 5, 'Netbanking', '2024-03-18'),
(6, 6, 'Cash', '2024-04-02'),
(7, 7, 'Credit Card', '2024-03-20'),
(8, 8, 'Debit Card', '2024-04-10'),
(9, 9, 'Netbanking', '2024-03-22'),
(10, 10, 'Cash', '2024-04-03');

-- 1) List the customers who have ordered Redmi 9 pro smartphone.
SELECT DISTINCT Customers.name
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id
JOIN Items ON Orders.item_id = Items.item_id
WHERE Items.name = 'Redmi 9 pro';

-- 2) List customers who have ordered items above 10000 and display the item too.
SELECT Customers.name, Items.name AS item_name
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id
JOIN Items ON Orders.item_id = Items.item_id
WHERE Items.price > 10000;

-- 3) List the items which have been sold out more in number from October to December.
SELECT Items.name, SUM(Orders.quantity) AS total_quantity
FROM Orders
JOIN Items ON Orders.item_id = Items.item_id
WHERE Orders.order_date BETWEEN '2024-10-01' AND '2024-12-31'
GROUP BY Items.name
ORDER BY total_quantity DESC;

-- 4) List the items which have been replaced by the customers.
SELECT Items.name
FROM Items
WHERE Items.is_replaced = TRUE;

-- 5) List the items which are from 2000 to 3000 rs.
SELECT name, price
FROM Items
WHERE price BETWEEN 2000 AND 3000;

-- 6) List the items which have more than 3 categories.
SELECT Items.name
FROM Items
GROUP BY Items.name
HAVING COUNT(DISTINCT category_id) > 3;

-- 7) List the customers who have ordered the item through netbanking.
SELECT Customers.name
FROM Customers
JOIN Transactions ON Customers.customer_id = Transactions.customer_id
WHERE Transactions.payment_method = 'Netbanking';

-- 8) List the customers who have sold the mobile phone more than 1000 pieces.
SELECT Customers.name
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id
JOIN Items ON Orders.item_id = Items.item_id
WHERE Items.name LIKE '%mobile%' AND Orders.quantity > 1000;

-- 9) Count the female and male customers who have purchased ornaments.
SELECT gender, COUNT(*) AS count
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id
JOIN Items ON Orders.item_id = Items.item_id
WHERE Items.name LIKE '%ornament%'
GROUP BY gender;

-- 10) Count the female customers who have purchased the men items.
SELECT COUNT(*) AS count
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id
JOIN Items ON Orders.item_id = Items.item_id
WHERE Customers.gender = 'Female' AND Items.name LIKE '%men%';

DROP DATABASE Flipkart;

