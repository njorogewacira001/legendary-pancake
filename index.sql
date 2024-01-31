-- Create a table for products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    StockQuantity INT
);

-- Create a table for customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);

-- Create a table for orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create a table for order details
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert sample products
INSERT INTO Products (ProductID, ProductName, Price, StockQuantity)
VALUES
    (1, 'Milk', 2.5, 100),
    (2, 'Bread', 1.0, 150),
    (3, 'Eggs', 1.8, 200);

-- Insert sample customers
INSERT INTO Customers (CustomerID, FirstName, LastName, Email)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com'),
    (2, 'Jane', 'Smith', 'jane.smith@example.com');

-- Insert sample orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate)
VALUES
    (1, 1, '2024-01-31'),
    (2, 2, '2024-01-30');

-- Insert sample order details
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, TotalPrice)
VALUES
    (1, 1, 1, 3, 7.5),
    (2, 1, 2, 2, 2.0),
    (3, 2, 3, 1, 1.8);

-- Query: Get all products
SELECT * FROM Products;

-- Query: Get all customers
SELECT * FROM Customers;

-- Query: Get all orders
SELECT * FROM Orders;

-- Query: Get order details with product information
SELECT OrderDetails.OrderID, Products.ProductName, OrderDetails.Quantity, OrderDetails.TotalPrice
FROM OrderDetails
JOIN Products ON OrderDetails.ProductID = Products.ProductID;
