-- 47730757 Tyler Crump
-- 48747289 William Vuong 
-- 48381004 Baek Jihun
-- 47433574 Man Hei (Dominic) Yu 
-- 48403954 Fariha Rahman Prodhan 

-- Question-A
-- Table Creation (Incomplete and Erroneous - please fix the errors and complete this section)

CREATE TABLE Promotion (
	PromoID CHAR(3) PRIMARY KEY,
	PromoName VARCHAR(50) NOT NULL,
	PromoDiscount DECIMAL(4,1) NOT NULL
	);

CREATE TABLE Category (
	CategoryID CHAR(5) PRIMARY KEY,
	CategoryName VARCHAR(50) NOT NULL,
	CategoryDesc VARCHAR(200) NOT NULL
	);

CREATE TABLE Chocolate (
	ChocolateID CHAR(6) PRIMARY KEY,
	ChocolateName VARCHAR(50) NOT NULL,
	ChocolateDesc VARCHAR(200) NOT NULL,
	ChocolatePrice DECIMAL (5, 2) NOT NULL,
	ChocolateWeight INT NOT NULL,
	CategoryID CHAR(5) NOT NULL, 
    CONSTRAINT fk_chocolate_category FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
	);

CREATE TABLE Discount (
	PromotionID CHAR(3),
	ChocolateID CHAR(6),
	StartDate DATETIME NOT NULL,
	EndDate DATETIME NOT NULL,
	-- following line referenced from https://www.w3schools.com/mysql/mysql_primarykey.asp
    PRIMARY KEY (PromotionID, ChocolateID)
    );

CREATE TABLE Customer (
	CustomerID CHAR(6) PRIMARY KEY,
	CustomerName VARCHAR(70) NOT NULL,
	CustomerEmail VARCHAR(100) NOT NULL,
	CustomerPhNum VARCHAR(32) NOT NULL
	);

CREATE TABLE Review (
	ReviewID CHAR(6) PRIMARY KEY,
	ReviewRating DECIMAL (2,0) NOT NULL,
	ReviewComment VARCHAR(255) NOT NULL,
	ReviewDate DATETIME NOT NULL,
	CustomerID CHAR(6) NOT NULL,
	ChocolateID CHAR(6) NOT NULL,
    CONSTRAINT fk_review_chocolate FOREIGN KEY (ChocolateID) REFERENCES Chocolate(ChocolateID),
    CONSTRAINT fk_review_customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
	);

-- Once successfully implemented, these insert statements should work.

INSERT INTO Promotion VALUES
	('P01', "Opening Sale", 50.0);
    
INSERT INTO Category VALUES
	('CAT01', "Ecuador Single Origin", "Cocoa beans from a single Ecuadorian source");

INSERT INTO Chocolate VALUES
	('CHOC13', "Dark Chocolate Tablet", "Small, bite sized dark chocolate tablets", 17.99, 80, 'CAT01');

INSERT INTO Discount VALUES
	('P01', 'CHOC13', '2023-02-01 08:00:00', '2023-02-02 18:00:00');

INSERT INTO Customer VALUES
	('CUS145', "Jon Snow", "j.snow@notreal.com",  "90861923");

INSERT INTO Review VALUES
	('REV131', 8, "A delicious milk chocolate", '2023-02-02 13:22:54', 'CUS145','CHOC13');
    
-- Please ensure you INSERT atleast 5 records for every table and add it below

INSERT INTO Promotion VALUES
    ('P02', "Opening Sale 2", 50.0),
    ('P03', "Opening Sale 3", 50.0),
    ('P04', "Opening Sale 4", 50.0),
    ('P05', "Opening Sale 5", 50.0);
    
INSERT INTO Category VALUES
    ('CAT02', "Ecuador Double Origin", "Cocoa beans from a double Ecuadorian source"),
    ('CAT03', "Ecuador Triple Origin", "Cocoa beans from a triple Ecuadorian source"),
    ('CAT04', "Ecuador Quad Origin", "Cocoa beans from a quad Ecuadorian source"),
    ('CAT05', "Ecuador Multiple Origin", "Cocoa beans from a multiple Ecuadorian source");
    
INSERT INTO Chocolate VALUES
    ('CHOC14', "Double Dark Chocolate Tablet", "Small, bite sized dark chocolate tablets", 18.99, 80, 'CAT02'),
    ('CHOC15', "Triple Dark Chocolate Tablet", "Small, bite sized dark chocolate tablets", 20.99, 80, 'CAT03'),
    ('CHOC16', "Quad Dark Chocolate Tablet", "Small, bite sized dark chocolate tablets", 25.99, 80, 'CAT04'),
    ('CHOC17', "Multi Dark Chocolate Tablet", "Small, bite sized dark chocolate tablets", 170.99, 80, 'CAT05');
    
INSERT INTO Discount VALUES
    ('P02', 'CHOC14', '2023-03-01 08:00:00', '2023-03-02 18:00:00'),
    ('P03', 'CHOC15', '2023-05-01 08:00:00', '2023-05-02 18:00:00'),
    ('P04', 'CHOC15', '2023-06-01 08:00:00', '2023-06-02 18:00:00'),
    ('P05', 'CHOC15', '2023-07-01 08:00:00', '2023-07-02 18:00:00');
    
INSERT INTO Customer VALUES
    ('CUS146', "Jon Snow JR", "jjr.snow@notreal.com",  "90861924"),
    ('CUS147', "Jon Snow JR JR", "jjrjr.snow@notreal.com",  "90861925"),
    ('CUS148', "Jon Snow JR JR JR", "jjrjrjr.snow@notreal.com",  "90861926"),
    ('CUS149', "Jon Snow Senior", "jsr.snow@notreal.com",  "90861927");

INSERT INTO Review VALUES
	('REV132', 9, "A double delicious milk chocolate", '2023-02-02 13:22:55', 'CUS146','CHOC14'),
	('REV133', 7, "A triple delicious milk chocolate", '2023-02-02 13:22:56', 'CUS147','CHOC14'),
	('REV134', 6, "A quad delicious milk chocolate", '2023-02-02 13:22:57', 'CUS148','CHOC14'),
	('REV135', 8, "A multiple delicious milk chocolate", '2023-02-02 13:22:58', 'CUS148','CHOC15');

-- Question-B
/* Explain in simple words what each query does and make sure you comment it
 */

-- An example of an answer to a Query

/* This query prints the names of all chocolates */

SELECT ChocolateName
FROM Chocolate;

-- Query 1: A query involving a single table with one condition. Insert your answer below

/* This query prints all chocolates that have a price less than $25 */
SELECT *
FROM Chocolate
WHERE ChocolatePrice < 25;

-- Query 2: A query involving a single table with two conditions, with one of the conditions that uses a wild card operator. Insert your answer below

/* Selects all customer names that includes JR */
-- snippet referenced from https://www.w3schools.com/sql/sql_wildcards.asp
SELECT CustomerName
FROM Customer
WHERE CustomerName
LIKE "%JR%";

-- Query 3: A query involving a join between at least two tables with an order by clause. Insert your answer below

/* Displays the chocolate names for each distinct review that has a rating greater or equal to than 8,
   and sorts by the name of the chocolate in alphabetical order */
SELECT ReviewID, ReviewRating, Chocolate.ChocolateID, ChocolateName
FROM  (Review
INNER JOIN Chocolate
ON Review.ChocolateID = Chocolate.ChocolateID)
WHERE ReviewRating >= 8
ORDER BY ChocolateName ASC;

-- Query 4: A query involving a single table with an aggregate and group by function. Insert your answer below

/* Counts the number of reviews for each chocolate IF they have at least one review */
SELECT Chocolate.ChocolateName, COUNT(Review.ReviewID) AS TotalReviews 
FROM (Review INNER JOIN Chocolate ON Review.ChocolateID = Chocolate.ChocolateID) 
GROUP BY Chocolate.ChocolateName;