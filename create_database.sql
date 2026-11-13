CREATE DATABASE IF NOT EXISTS lib_management;
use lib_management;

CREATE TABLE members  (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15),
    enroll_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active'
);

CREATE TABLE books (
	book_id INT AUTO_INCREMENT PRIMARY KEY,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    title VARCHAR(300) NOT NULL,
    author VARCHAR(200) NOT NULL,
    publisher VARCHAR(50),
    published_year YEAR,
    category VARCHAR(50),
    INDEX index_title (title),
    INDEX index_author (author)
);

CREATE TABLE book_copies (
	copy_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT NOT NULL,
    shelf VARCHAR(50),
    status ENUM('available', 'issued', 'lost', 'damaged') NOT NULL DEFAULT 'available',
    FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE
);

CREATE TABLE transactions (
    trans_id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    copy_id INT NOT NULL,
    issue_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    return_date DATE NOT NULL,
    fine_amount DECIMAL(8, 2) NOT NULL DEFAULT 0.00,
    status ENUM('issued', 'returned', 'overdue') NOT NULL DEFAULT 'issued',
    FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE CASCADE,
    FOREIGN KEY (copy_id) REFERENCES book_copies(copy_id) ON DELETE CASCADE,
    INDEX index_due_date (due_date),
    INDEX index_status (status)
);


