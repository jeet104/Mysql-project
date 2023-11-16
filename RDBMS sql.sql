create database restaurant_system_;
use restaurant_system_;

CREATE TABLE MenuItems (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    item_name VARCHAR(255) NOT NULL,
    description TEXT,
    price int NOT NULL,
    category VARCHAR(50),
    is_vegetarian BOOLEAN,
    is_spicy BOOLEAN,
    is_gluten_free BOOLEAN
);

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount int,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES MenuItems(item_id)
);

SELECT * from MenuItems; 

SELECT * from Customers;

SELECT * from Orders;

select * from Order_Items;

SELECT first_name, email FROM Customers;

SELECT SUM(total_amount) AS total_revenue
FROM Orders
WHERE order_date = '2023-11-08';

SELECT * FROM MenuItems WHERE is_spicy = true;

SELECT * FROM MenuItems WHERE is_spicy = false AND is_gluten_free = false;

SELECT DISTINCT c.first_name, c.last_name , o.customer_id
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id;

SELECT order_date, SUM(total_amount) AS daily_revenue
FROM Orders
GROUP BY order_date
ORDER BY order_date;

SELECT * FROM MenuItems
ORDER BY price DESC
LIMIT 5;

SELECT c.first_name, c.last_name, SUM(o.total_amount) AS total_spent
FROM Customers c
INNER JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 5;

SELECT o.order_date, m.item_name
FROM Orders o
INNER JOIN Order_Items oi ON o.order_id = oi.order_id
INNER JOIN MenuItems m ON oi.item_id = m.item_id
WHERE o.order_date = '2023-11-08';

SELECT AVG(total_amount) AS average_order_total
FROM Orders;

SELECT c.first_name, c.last_name
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

SELECT m.item_name, SUM(oi.quantity) AS total_quantity_ordered
FROM MenuItems m
LEFT JOIN Order_Items oi ON m.item_id = oi.item_id
GROUP BY m.item_id;

SELECT AVG(total_amount) AS avg_total_amount
FROM Orders
WHERE DAYOFWEEK(order_date) = 2;

SELECT m.category, SUM(oi.quantity) AS total_quantity_ordered
FROM MenuItems m
JOIN Order_Items oi ON m.item_id = oi.item_id
GROUP BY m.category
ORDER BY total_quantity_ordered DESC
LIMIT 1;

SELECT distinct c.first_name, c.last_name
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN MenuItems m ON oi.item_id = m.item_id
WHERE m.item_name = 'Paneer Tikka';

SELECT m.item_name, COUNT(oi.order_item_id) AS order_count
FROM MenuItems m
LEFT JOIN Order_Items oi ON m.item_id = oi.item_id
GROUP BY m.item_id
HAVING order_count > 5;

SELECT m.item_name, oi.quantity
FROM MenuItems m
JOIN Order_Items oi ON m.item_id = oi.item_id
JOIN Orders o ON oi.order_id = o.order_id
WHERE o.order_date >= DATE(NOW()) - INTERVAL 1 DAY;



