DELIMITER $$

-- Stored Procedure to Add a New Product
CREATE PROCEDURE AddProduct(
    IN pProductName VARCHAR(100),
    IN pDescription TEXT,
    IN pPrice DECIMAL(10, 2),
    IN pStockQuantity INT
)
BEGIN
    INSERT INTO Products (ProductName, Description, Price, StockQuantity)
    VALUES (pProductName, pDescription, pPrice, pStockQuantity);
END $$

-- Stored Procedure to Place an Order
CREATE PROCEDURE PlaceOrder(
    IN pUserID INT,
    IN pStatus VARCHAR(50),
    IN pTotalAmount DECIMAL(10, 2),
    IN pPaymentMethod VARCHAR(50)
)
BEGIN
    DECLARE pOrderID INT;
    
    -- Create a new order
    INSERT INTO Orders (UserID, Status, TotalAmount)
    VALUES (pUserID, pStatus, pTotalAmount);
    
    -- Get the ID of the newly created order
    SET pOrderID = LAST_INSERT_ID();
    
    -- Record the payment information
    INSERT INTO Payment (OrderID, PaymentMethod, Amount)
    VALUES (pOrderID, pPaymentMethod, pTotalAmount);
END $$

-- Stored Procedure to Update Stock Quantity of a Product
CREATE PROCEDURE UpdateStockQuantity(
    IN pProductID INT,
    IN pQuantity INT
)
BEGIN
    UPDATE Products
    SET StockQuantity = StockQuantity - pQuantity
    WHERE ProductID = pProductID;
END $$

-- Stored Procedure to Fetch User Order History
CREATE PROCEDURE FetchUserOrderHistory(
    IN pUserID INT
)
BEGIN
    SELECT o.OrderID, o.OrderDate, o.Status, o.TotalAmount, p.PaymentMethod
    FROM Orders o
    JOIN Payment p ON o.OrderID = p.OrderID
    WHERE o.UserID = pUserID
    ORDER BY o.OrderDate DESC;
END $$

DELIMITER ;
