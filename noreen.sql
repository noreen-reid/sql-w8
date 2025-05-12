-- Library Management System Database Design
-- Author:Noreen Filgona
-- Description: This SQL script creates a relational database 
-- for managing books, members, borrow records, and staff.

-- Drop existing tables if they exist (for reset)
DROP TABLE IF EXISTS Borrow;
DROP TABLE IF EXISTS Book_Author;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Members;
DROP TABLE IF EXISTS Staff;

-- Table: Staff
-- One-to-One relationship with Members (example use)
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    hire_date DATE NOT NULL
);

-- Table: Members
-- People who can borrow books
CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    join_date DATE NOT NULL
);

-- Table: Authors
-- Books can have many authors

CREATE TABLE Authors (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

-- Table: Books
-- Many-to-Many with Authors via Book_Author

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    published_year YEAR,
    copies_available INT DEFAULT 1
);

-- Table: Book_Author
-- Many-to-Many relationship between Books and Authors

CREATE TABLE Book_Author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id),
    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
);

-- Table: Borrow
-- Tracks borrow records (Many-to-Many with Members and Books)

CREATE TABLE Borrow (
    borrow_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    borrow_date DATE NOT NULL,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- Insert sample members
INSERT INTO Members (first_name, last_name, email, join_date) VALUES
('John', 'Doe', 'john.doe@example.com', '2023-01-01'),
('Jane', 'Smith', 'jane.smith@example.com', '2023-02-15'),
('Michael', 'Johnson', 'michael.johnson@example.com', '2023-03-10'),
('Emily', 'Davis', 'emily.davis@example.com', '2023-04-20'),
('William', 'Brown', 'william.brown@example.com', '2023-05-05');

-- Insert sample borrow records for the members (books borrowed by members)
-- Assuming books with IDs 1, 2, and 3 already exist in the Books table

INSERT INTO Borrow (member_id, book_id, borrow_date, return_date) VALUES
(1, 1, '2023-05-01', '2023-05-15'),  -- John borrows Book 1 and returns it on 2023-05-15
(2, 2, '2023-05-05', '2023-05-20'),  -- Jane borrows Book 2 and returns it on 2023-05-20
(3, 3, '2023-05-10', NULL),          -- Michael borrows Book 3 (not yet returned)
(4, 1, '2023-05-12', '2023-05-18'),  -- Emily borrows Book 1 and returns it on 2023-05-18
(5, 2, '2023-05-15', NULL);          -- William borrows Book 2 (not yet returned)

-- Verify the Members table
SELECT * FROM Members;

-- Verify the Borrow table
SELECT * FROM Borrow;
