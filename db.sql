use foodapp;
SET SQL_SAFE_UPDATES = 0;
-- Create table for User
CREATE TABLE User (
    UserId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15)
);
-- Create table for Address
CREATE TABLE Address (
    AddId INT PRIMARY KEY AUTO_INCREMENT,
    UserId INT NOT NULL,
    DefaultAddress BOOLEAN,
    City VARCHAR(100),
    AddressDetail TEXT,
    Coordinate VARCHAR(100),
    FOREIGN KEY (UserId) REFERENCES User(UserId)
);
-- Create table for Order
CREATE TABLE `Order` (
    OrderId INT PRIMARY KEY AUTO_INCREMENT,
    AddressId INT NOT NULL,
    Status VARCHAR(50),
    FOREIGN KEY (AddressId) REFERENCES Address(AddId)
);
-- Create table for Item
CREATE TABLE Item (
    ItemId INT PRIMARY KEY AUTO_INCREMENT,
    RestaurantId INT NOT NULL,
    Name VARCHAR(100),
    Price DECIMAL(10, 2),
    Photo TEXT,
    FoodDetail TEXT,
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId)
);
-- Create table for ItemCategory
CREATE TABLE ItemCategory (
    ItemCategoryId INT PRIMARY KEY AUTO_INCREMENT,
    ItemId INT NOT NULL,
    CategoryId INT NOT NULL,
    FOREIGN KEY (ItemId) REFERENCES Item(ItemId),
    FOREIGN KEY (CategoryId) REFERENCES Category(CategoryId)
);
-- Create table for Category
CREATE TABLE Category (
    CategoryId INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(100)
);
-- Create table for Restaurant
CREATE TABLE Restaurant (
    RestaurantId INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Photo TEXT,
    MinPurchase DECIMAL(10, 2),
    City VARCHAR(100),
    Address TEXT,
    Coordinate VARCHAR(100)
);
-- Create table for DeliveryFee
CREATE TABLE DeliveryFee (
    FeeId INT PRIMARY KEY AUTO_INCREMENT,
    RestaurantId INT NOT NULL,
    Price DECIMAL(10, 2),
    TenderArea BOOLEAN,
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId)
);
-- Create table for WorkingTime
CREATE TABLE WorkingTime (
    WorkingTimeId INT PRIMARY KEY AUTO_INCREMENT,
    RestaurantId INT NOT NULL,
    Day VARCHAR(20),
    OpenAt TIME,
    CloseAt TIME,
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId)
);
-- Create table for OrderDetail
CREATE TABLE OrderDetail (
    OrderDetailId INT PRIMARY KEY AUTO_INCREMENT,
    Price DECIMAL(10, 2),
    Count INT,
    OrderId INT NOT NULL,
    ItemId INT NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES `Order`(OrderId),
    FOREIGN KEY (ItemId) REFERENCES Item(ItemId)
);
-- Create table for Feedback
CREATE TABLE Feedback (
    FeedbackId INT PRIMARY KEY AUTO_INCREMENT,
    OrderDetailId INT NOT NULL,
    Rate DECIMAL(2, 1),
    Description TEXT,
    FOREIGN KEY (OrderDetailId) REFERENCES OrderDetail(OrderDetailId)
);
-- Create table for ShoppingCart
CREATE TABLE ShoppingCart (
    CartId INT PRIMARY KEY AUTO_INCREMENT,
    UserId INT NOT NULL,
    ItemId INT NOT NULL,
    Date DATETIME,
    Count INT,
    FOREIGN KEY (UserId) REFERENCES User(UserId),
    FOREIGN KEY (ItemId) REFERENCES Item(ItemId)
);
-- Insert data into User
INSERT INTO User (Name, Phone) VALUES
('Ali', '12345'),
('Sara', '54321'),
('Reza', '98765'),
('Mina', '67890'),
('Hassan', '11111');
-- Insert data into Address
INSERT INTO Address (UserId, DefaultAddress, City, AddressDetail, Coordinate) VALUES
(1, TRUE, 'Shiraz', 'Street A, Block B', '29.6, 52.5'),
(2, FALSE, 'Tehran', 'Street C, Block D', '35.7, 51.4'),
(3, TRUE, 'Mashhad', 'Street E, Block F', '36.3, 59.6'),
(4, FALSE, 'Isfahan', 'Street G, Block H', '32.6, 51.7'),
(5, TRUE, 'Tabriz', 'Street I, Block J', '38.1, 46.2');
-- Insert data into Order
INSERT INTO `Order` (AddressId, Status) VALUES
(1, 'Done'),
(2, 'Pending'),
(3, 'In Progress'),
(4, 'Delivered'),
(5, 'Cancelled');
-- Insert data into Restaurant
INSERT INTO Restaurant (Name, Photo, MinPurchase, City, Address, Coordinate) VALUES
('Pizza Palace', 'photo1.jpg', 100, 'Shiraz', 'Street A', '29.6, 52.5'),
('Burger House', 'photo2.jpg', 200, 'Tehran', 'Street B', '35.7, 51.4'),
('Sushi World', 'photo3.jpg', 300, 'Mashhad', 'Street C', '36.3, 59.6'),
('Pasta Corner', 'photo4.jpg', 150, 'Isfahan', 'Street D', '32.6, 51.7'),
('Dessert Haven', 'photo5.jpg', 120, 'Tabriz', 'Street E', '38.1, 46.2');
-- Insert data into Item
INSERT INTO Item (RestaurantId, Name, Price, Photo, FoodDetail) VALUES
(1, 'Margherita Pizza', 150.00, 'pizza1.jpg', 'Cheese and Tomato'),
(2, 'Beef Burger', 200.00, 'burger1.jpg', 'Juicy beef patty'),
(3, 'Salmon Sushi', 300.00, 'sushi1.jpg', 'Fresh salmon rolls'),
(4, 'Alfredo Pasta', 180.00, 'pasta1.jpg', 'Creamy sauce'),
(5, 'Chocolate Cake', 120.00, 'dessert1.jpg', 'Rich chocolate flavor');
-- Insert data into ItemCategory
INSERT INTO ItemCategory (ItemId, CategoryId) VALUES
(7, 1),
(8, 2),
(9, 3),
(10, 4),
(11, 5);
-- Insert data into Category
INSERT INTO Category (CategoryName) VALUES
('Pizza'),
('Burger'),
('Sushi'),
('Pasta'),
('Dessert');
-- Insert data into DeliveryFee
INSERT INTO DeliveryFee (RestaurantId, Price, TenderArea) VALUES
(1, 50.00, TRUE),
(2, 60.00, FALSE),
(3, 70.00, TRUE),
(4, 40.00, FALSE),
(5, 30.00, TRUE);
-- Insert data into WorkingTime
INSERT INTO WorkingTime (RestaurantId, Day, OpenAt, CloseAt) VALUES
(1, 'Monday', '10:00:00', '22:00:00'),
(2, 'Tuesday', '09:00:00', '21:00:00'),
(3, 'Wednesday', '11:00:00', '23:00:00'),
(4, 'Thursday', '10:00:00', '22:00:00'),
(5, 'Friday', '08:00:00', '20:00:00');
-- Insert data into OrderDetail
INSERT INTO OrderDetail (Price, Count, OrderId, ItemId) VALUES
(150.00, 2, 1, 7),
(200.00, 1, 2, 8),
(300.00, 3, 3, 9),
(180.00, 1, 4, 10),
(120.00, 5, 5, 11);
-- Insert data into Feedback
INSERT INTO Feedback (OrderDetailId, Rate, Description) VALUES
(11, 5.0, 'Excellent taste!'),
(12, 4.5, 'Very good.'),
(13, 4.0, 'Fresh and tasty.'),
(14, 3.5, 'Average taste.'),
(15, 5.0, 'Amazing dessert!');
-- Insert data into ShoppingCart
INSERT INTO ShoppingCart (UserId, ItemId, Date, Count) VALUES
(1, 8, '2025-01-04 10:00:00', 1),
(2, 9, '2025-01-04 11:00:00', 2),
(3, 10, '2025-01-04 12:00:00', 3),
(4, 11, '2025-01-04 13:00:00', 4);

-- ------------------------------------------------------------------
ALTER TABLE `User`
ADD COLUMN `Password` VARCHAR(255) NOT NULL DEFAULT 'tempPassword';

UPDATE user
SET `Password` = '1234'
WHERE `Password` = 'tempPassword';

-- -------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE AddRestaurant(
    IN rName VARCHAR(100),
    IN rPhoto TEXT,
    IN rMinPurchase DECIMAL(10, 2),
    IN rCity VARCHAR(100),
    IN rAddress TEXT,
    IN rCoordinate VARCHAR(100)
)
BEGIN
    INSERT INTO Restaurant (Name, Photo, MinPurchase, City, Address, Coordinate, IsDeleted)
    VALUES (rName, rPhoto, rMinPurchase, rCity, rAddress, rCoordinate, 0);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE DeleteRestaurant(
    IN restaurantId INT
)
BEGIN
    -- Soft delete the restaurant
    UPDATE Restaurant
    SET IsDeleted = 1
    WHERE restaurant.RestaurantId = restaurantId;

    -- Optional: Return confirmation message
    SELECT CONCAT('Restaurant with ID ', restaurantId, ' has been soft-deleted.') AS Message;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE RestoreRestaurant(
    IN restaurantId INT
)
BEGIN
    -- Restore the restaurant
    UPDATE Restaurant
    SET IsDeleted = 0
    WHERE restaurant.RestaurantId = restaurantId;

    -- Optional: Return confirmation message
    SELECT CONCAT('Restaurant with ID ', restaurantId, ' has been restored.') AS Message;
END //

DELIMITER ;



call AddRestaurant('restaurant1','restaurant1',9,'shiraz','restaurant1address','110.998');

DELIMITER //

CREATE PROCEDURE ViewTableData(
    IN tableName VARCHAR(50)
)
BEGIN
    SET @query = CONCAT('SELECT * FROM ', tableName);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE EditRecord(
    IN tableName VARCHAR(50),
    IN columnName VARCHAR(50),
    IN newValue VARCHAR(255),
    IN keyColumn VARCHAR(50),
    IN keyValue VARCHAR(50)
)
BEGIN
    -- Add single quotes around the keyValue
    SET @query = CONCAT('UPDATE ', tableName, 
                        ' SET ', columnName, ' = "', newValue, '"',
                        ' WHERE ', keyColumn, ' = "', keyValue, '"');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE DeleteRecord(
    IN tableName VARCHAR(50),
    IN keyColumn VARCHAR(50),
    IN keyValue VARCHAR(50)
)
BEGIN
    -- Wrap the keyValue in single quotes to treat it as a string
    SET @query = CONCAT('DELETE FROM ', tableName, ' WHERE ', keyColumn, ' = "', keyValue, '"');
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- -----------------------------------------

DELIMITER //

CREATE PROCEDURE UpdateRestaurant(
    IN rName VARCHAR(100),    -- Name of the restaurant to identify the row
    IN columnName VARCHAR(100), -- Name of the column to update
    IN newValue VARCHAR(255)    -- New value for the specified column
)
BEGIN
    -- Build the dynamic SQL query
    SET @query = CONCAT(
        'UPDATE Restaurant SET ', columnName, ' = "', newValue, '" WHERE Name = "', rName, '"'
    );
    
    -- Prepare and execute the dynamic query
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddMenuItem(
    IN rId INT,
    IN itemName VARCHAR(100),
    IN itemPrice DECIMAL(10,2),
    IN itemPhoto TEXT,
    IN itemFoodDetail TEXT
)
BEGIN
    INSERT INTO Item (RestaurantId, Name, Price, Photo, FoodDetail)
    VALUES (rId, itemName, itemPrice, itemPhoto, itemFoodDetail);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateMenuItem(
    IN itemId INT,              -- The ID of the menu item to update
    IN columnName VARCHAR(100), -- The column to update
    IN newValue VARCHAR(255)    -- The new value for the column
)
BEGIN
    -- Build the dynamic SQL query
    SET @query = CONCAT(
        'UPDATE Item SET ', columnName, ' = "', newValue, '" WHERE ItemId = ', itemId
    );

    -- Prepare and execute the dynamic query
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE DeleteMenuItem(
    IN itemId INT
)
BEGIN
    -- Perform a soft delete by setting IsDeleted = 1
    UPDATE Item
    SET IsDeleted = 1
    WHERE item.ItemId = itemId;

    -- Optional: Return confirmation message
    SELECT CONCAT('Item with ID ', itemId, ' has been soft-deleted.') AS Message;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE RestoreMenuItem(
    IN itemId INT
)
BEGIN
    UPDATE Item
    SET IsDeleted = 0
    WHERE item.ItemId = itemId;

    SELECT CONCAT('Item with ID ', itemId, ' has been restored.') AS Message;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddAddress(
    IN uId INT,
    IN isDefault BOOLEAN,
    IN city VARCHAR(100),
    IN addressDetail TEXT,
    IN coordinate VARCHAR(100)
)
BEGIN
    INSERT INTO Address (UserId, DefaultAddress, City, AddressDetail, Coordinate)
    VALUES (uId, isDefault, city, addressDetail, coordinate);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddToCart(
    IN uId INT,
    IN iId INT,
    IN quantity INT
)
BEGIN
    INSERT INTO ShoppingCart (UserId, ItemId, Date, Count)
    VALUES (uId, iId, NOW(), quantity);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE RemoveFromCart(
    IN cartId INT
)
BEGIN
    DELETE FROM ShoppingCart WHERE shoppingcart.cartid = cartId;
END //

DELIMITER ;

-- -------------------------------------------------------------------
DELIMITER //

CREATE PROCEDURE SignUpUser(
    IN userName VARCHAR(100),
    IN userPhone VARCHAR(15),
    IN userPassword VARCHAR(255),
    IN userRole ENUM('User', 'Admin', 'Manager')
)
BEGIN
    -- Check if Name or Phone already exists
    IF EXISTS (SELECT 1 FROM User WHERE Name = userName OR Phone = userPhone) THEN
        -- Return error if user already exists
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'User with the same Name or Phone already exists.';
    ELSE
        -- Insert the new user with hashed password and default IsDeleted value (0)
        INSERT INTO User (Name, Phone, Password, Role, IsDeleted)
        VALUES (userName, userPhone, SHA2(userPassword, 256), userRole, 0);
    END IF;
END //

DELIMITER ;

-- -------------------------------------------------------------------

ALTER TABLE Item
ADD COLUMN IsDeleted BOOLEAN NOT NULL DEFAULT 0;


DELIMITER //

CREATE PROCEDURE GetUserOrderHistory(
    IN uId INT
)
BEGIN
    SELECT 
        o.OrderId,
        o.Status AS OrderStatus,
        od.Price AS ItemPrice,
        od.Count AS Quantity,
        i.Name AS ItemName,
        i.IsDeleted AS IsItemDeleted
    FROM `Order` o
    JOIN OrderDetail od ON o.OrderId = od.OrderId
    JOIN Item i ON od.ItemId = i.ItemId
    JOIN Address a ON o.AddressId = a.AddId
    WHERE a.UserId = uId;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetRestaurantOrders(
    IN restaurantId INT
)
BEGIN
    SELECT 
        o.OrderId,
        o.Status AS OrderStatus,
        od.Price AS ItemPrice,
        od.Count AS Quantity,
        i.Name AS ItemName,
        f.Rate AS ReviewRating,
        f.Description AS ReviewComment,
        i.IsDeleted AS IsItemDeleted
    FROM `Order` o
    JOIN OrderDetail od ON o.OrderId = od.OrderId
    JOIN Item i ON od.ItemId = i.ItemId
    LEFT JOIN Feedback f ON od.OrderDetailId = f.OrderDetailId
    WHERE i.RestaurantId = restaurantId;
END //

DELIMITER ;

ALTER TABLE User
ADD COLUMN Role ENUM('User', 'Admin', 'Manager') NOT NULL DEFAULT 'User';


CREATE TABLE RestaurantManager (
    ManagerId INT PRIMARY KEY AUTO_INCREMENT,
    UserId INT NOT NULL,
    RestaurantId INT NOT NULL,
    FOREIGN KEY (UserId) REFERENCES User(UserId),
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant(RestaurantId)
);

DELIMITER //

CREATE PROCEDURE AddUser(
    IN uName VARCHAR(100),
    IN uPhone VARCHAR(15),
    IN uPassword VARCHAR(255),
    IN uRole ENUM('User', 'Admin', 'Manager')
)
BEGIN
    -- Check if the phone number already exists
    IF EXISTS (SELECT 1 FROM User WHERE Phone = uPhone) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Phone number already exists.';
    ELSE
        -- Insert the new user
        INSERT INTO User (Name, Phone, Password, Role, IsDeleted)
        VALUES (uName, uPhone, SHA2(uPassword, 256), uRole, 0);
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddRestaurantManager(
    IN managerId INT,
    IN restaurantId INT
)
BEGIN
	-- Assign the manager to the restaurant
	INSERT INTO RestaurantManager (UserId, RestaurantId)
	VALUES (managerId, restaurantId);
    
	update user set user.role = 'Manager' where user.userID = managerId;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UserLogin(
    IN userName VARCHAR(100),
    IN userPassword VARCHAR(255)
)
BEGIN
    SELECT UserId, Name, Role, IsDeleted
    FROM User
    WHERE Name = userName 
      AND Password = SHA2(userPassword, 256);
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE GetRestaurantManagers()
BEGIN
    SELECT 
        u.UserId, 
        u.Name AS ManagerName, 
        r.Name AS RestaurantName
    FROM User u
    JOIN RestaurantManager rm ON u.UserId = rm.UserId
    JOIN Restaurant r ON rm.RestaurantId = r.RestaurantId
    WHERE u.Role = 'Manager';
END //

DELIMITER ;

call AddRestaurantmanager(2,2);

DELIMITER //

CREATE PROCEDURE RemoveManagerRole(
    IN userId INT
)
BEGIN
    -- Step 1: Check if the user is a manager
    IF EXISTS (SELECT 1 FROM User WHERE UserId = userId AND Role = 'Manager') THEN
        -- Step 2: Remove the user from the RestaurantManager table
        DELETE FROM RestaurantManager WHERE restaurantmanager.UserId = userId;

        -- Step 3: Update the user's role to 'User'
        UPDATE User
        SET Role = 'User'
        WHERE user.UserId = userId;

        -- Optional: Return confirmation message
        SELECT CONCAT('User with ID ', userId, ' has been removed as manager and set to default User role.') AS Message;
    ELSE
        -- Return an error message if the user is not a manager
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'The specified user is not a manager.';
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetAllUsers()
BEGIN
    SELECT UserId, Name, Phone, Role, IsDeleted
    FROM User;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE GetAllItems()
BEGIN
    SELECT ItemId, RestaurantId, Name, Price, Photo, FoodDetail, IsDeleted
    FROM Item;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE GetAllRestaurants()
BEGIN
    SELECT * FROM Restaurant;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE GetAllOrders()
BEGIN
    SELECT o.OrderId, o.Status, a.City AS DeliveryCity, a.AddressDetail AS DeliveryAddress
    FROM `Order` o
    JOIN Address a ON o.AddressId = a.AddId;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE GetAllFeedback()
BEGIN
    SELECT 
        f.FeedbackId, 
        f.OrderDetailId, 
        f.Rate, 
        f.Description, 
        od.Price AS ItemPrice, 
        od.Count AS Quantity
    FROM Feedback f
    JOIN OrderDetail od ON f.OrderDetailId = od.OrderDetailId;
END //

DELIMITER ;
DELIMITER //

CREATE PROCEDURE GetAllOrderDetails()
BEGIN
    SELECT 
        od.OrderDetailId, 
        od.OrderId, 
        od.ItemId, 
        od.Price, 
        od.Count, 
        i.Name AS ItemName, 
        i.IsDeleted AS IsItemDeleted
    FROM OrderDetail od
    JOIN Item i ON od.ItemId = i.ItemId;
END //

DELIMITER ;

ALTER TABLE User
ADD COLUMN IsDeleted BOOLEAN NOT NULL DEFAULT 0;

DELIMITER //

CREATE PROCEDURE DeleteUser(
    IN userId INT
)
BEGIN
    -- Soft delete the user
    UPDATE User
    SET IsDeleted = 1
    WHERE user.UserId = userId;

    -- Optional: Return a confirmation message
    SELECT CONCAT('User with ID ', userId, ' has been soft-deleted.') AS Message;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE RestoreUser(
    IN userId INT
)
BEGIN
    -- Restore the user
    UPDATE User
    SET IsDeleted = 0
    WHERE user.UserId = userId;

    -- Optional: Return a confirmation message
    SELECT CONCAT('User with ID ', userId, ' has been restored.') AS Message;
END //

DELIMITER ;

ALTER TABLE Restaurant
ADD COLUMN IsDeleted BOOLEAN NOT NULL DEFAULT 0;


DELIMITER //

CREATE PROCEDURE GetUserById(IN userId INT)
BEGIN
    SELECT UserId, Name, Phone
    FROM User
    WHERE user.UserId = userId;
END //

DELIMITER ;

-- ------------------------------------- check this out
drop procedure GetOrderHistory;
call NewOrder(1);

DELIMITER //

CREATE PROCEDURE AddOrderDetail(
    IN orderId INT,
    IN itemId INT,
    IN quantity INT
)
BEGIN
    DECLARE itemPrice DECIMAL(10, 2);
    DECLARE totalPrice DECIMAL(10, 2);

    -- Fetch the price of the item from the Item table
    SELECT Price INTO itemPrice
    FROM Item
    WHERE item.ItemId = itemId;

    -- Calculate the total price based on quantity
    SET totalPrice = itemPrice * quantity;

    -- Insert the item into the OrderDetails table with the calculated price
    INSERT INTO OrderDetail (OrderId, ItemId, Count, Price)
    VALUES (orderId, itemId, quantity, totalPrice);
END //

DELIMITER ;
call AddOrderDetail(7,8,2);
ALTER TABLE Feedback
ADD CONSTRAINT chk_rate CHECK (Rate BETWEEN 1 AND 5);

DELIMITER //

CREATE PROCEDURE getItemsByRestaurantId(
    IN p_RestaurantId INT
)
BEGIN
    SELECT 
        ItemId,
        Name,
        Price,
        Photo,
        FoodDetail
    FROM 
        Item
    WHERE 
        item.RestaurantId = p_RestaurantId
        AND IsDeleted = 0; -- Only fetch non-deleted items
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetRestaurantWorkingTime(
    IN p_RestaurantId INT
)
BEGIN
    SELECT 
        w.WorkingTimeId,
        w.Day,
        w.OpenAt,
        w.CloseAt
    FROM 
        WorkingTime w
    INNER JOIN 
        Restaurant r ON w.RestaurantId = r.RestaurantId
    WHERE 
        w.RestaurantId = p_RestaurantId
        AND r.IsDeleted = 0; -- Only fetch working times for non-deleted restaurants
END //

DELIMITER ;


-- --------------------------------------------here
drop procedure if exists AuthenticateUser;

DELIMITER //

CREATE PROCEDURE SetDefaultAddress(
    IN p_UserId INT,
    IN p_AddId INT
)
BEGIN
    -- Reset all addresses for the user to not be default
    UPDATE Address
    SET DefaultAddress = 0
    WHERE address.UserId = p_UserId;

    -- Set the specified address as the default
    UPDATE Address
    SET DefaultAddress = 1
    WHERE address.AddId = p_AddId AND address.UserId = p_UserId;
END //

DELIMITER ;
call setdefaultaddress(1,1);


update `order` set `order`.status = 'Not Approved' where `order`.orderID = 3 or `order`.orderID = 4 or `order`.orderID = 6;
-- Alter the Order table to restrict Status to specific values
ALTER TABLE `Order`
MODIFY COLUMN Status ENUM('Not Approved', 'Reject', 'Pending', 'Done', 'Cancelled') NOT NULL DEFAULT 'Not Approved';

Drop procedure HandleOrder;
DELIMITER //

CREATE PROCEDURE setOrderStatus(
    IN orderId INT,
    IN newStatus ENUM('Not Approved', 'Reject', 'Pending', 'Done', 'Cancelled')
)
BEGIN
    UPDATE `Order`
    SET Status = newStatus
    WHERE `Order`.OrderId = orderId;
END //

DELIMITER ;

drop procedure neworder;
DELIMITER //

CREATE PROCEDURE NewOrder(
    IN aId INT
)
BEGIN
    INSERT INTO `Order` (AddressId, Status)
    VALUES (aId, 'Not Approved');
END //

DELIMITER ;

call setOrderStatus(7,'Done');

DELIMITER //

CREATE PROCEDURE GetPendingOrdersByRestaurantId(
    IN rId INT
)
BEGIN
    SELECT DISTINCT o.OrderId, o.AddressId, o.Status
    FROM `Order` o
    INNER JOIN OrderDetail od ON o.OrderId = od.OrderId
    INNER JOIN Item i ON od.ItemId = i.ItemId
    WHERE i.RestaurantId = rId AND o.Status = 'Pending';
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetRestaurantsByManager(
    IN userId INT
)
BEGIN
    SELECT 
        r.RestaurantId,
        r.Name,
        r.Photo,
        r.MinPurchase,
        r.City,
        r.Address,
        r.Coordinate,
        r.IsDeleted
    FROM 
        RestaurantManager rm
    INNER JOIN 
        Restaurant r ON rm.RestaurantId = r.RestaurantId
    WHERE 
        rm.UserId = userId AND r.IsDeleted = 0; -- Exclude soft-deleted restaurants
END //

DELIMITER ;

-- ------------------------------------------------------------here 
DELIMITER //

CREATE PROCEDURE EditWorkingTime(
    IN restaurantId INT,
    IN dayName VARCHAR(20),
    IN newOpenAt TIME,
    IN newCloseAt TIME
)
BEGIN
    -- Update the working time for the specific day and restaurant
    UPDATE WorkingTime
    SET 
        workingtime.OpenAt = newOpenAt,
        workingtime.CloseAt = newCloseAt
    WHERE 
        workingtime.RestaurantId = restaurantId AND workingtime.Day = dayName;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddDeliveryFee(
    IN restaurantId INT,
    IN price DECIMAL(10, 2),
    IN tenderArea BOOLEAN
)
BEGIN
    INSERT INTO DeliveryFee (RestaurantId, Price, TenderArea)
    VALUES (restaurantId, price, tenderArea);
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE EditDeliveryFee(
    IN feeId INT,
    IN columnName VARCHAR(50),
    IN newValue VARCHAR(255)
)
BEGIN
    -- Build the dynamic SQL query
    SET @query = CONCAT('UPDATE DeliveryFee SET ', columnName, ' = "', newValue, '" WHERE FeeId = ', feeId);
    
    -- Prepare and execute the dynamic query
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE DeleteDeliveryFee(
    IN feeId INT
)
BEGIN
    DELETE FROM DeliveryFee
    WHERE deliveryfee.FeeId = feeId;
END //

DELIMITER ;
