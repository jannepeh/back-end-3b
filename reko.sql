-- reko.sql

-- Pudota taulut, jos ne ovat jo olemassa
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

-- Luo users-taulu
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    role VARCHAR(50) NOT NULL
);

-- Luo categories-taulu
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

-- Luo items-taulu
CREATE TABLE items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT,
    seller_id INT,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (seller_id) REFERENCES users(user_id)
);

-- Luo transactions-taulu
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    buyer_id INT,
    item_id INT,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (buyer_id) REFERENCES users(user_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- Lisää alkuperäiset tiedot users-tauluun
INSERT INTO users (username, email, password_hash, role) VALUES
('seller1', 'seller1@example.com', 'hashed_password_1', 'seller'),
('buyer1', 'buyer1@example.com', 'hashed_password_2', 'buyer');

-- Lisää alkuperäiset tiedot categories-tauluun
INSERT INTO categories (name, description) VALUES
('Electronics', 'Electronic devices and accessories'),
('Furniture', 'Home and office furniture');

-- Lisää alkuperäiset tiedot items-tauluun
INSERT INTO items (title, description, price, category_id, seller_id, status) VALUES
('Used Laptop', 'A laptop in good condition', 350.00, 1, 1, 'available'),
('Office Chair', 'Comfortable chair with ergonomic design', 50.00, 2, 1, 'available');

-- Lisää alkuperäiset tiedot transactions-tauluun
INSERT INTO transactions (buyer_id, item_id, status, total_amount) VALUES
(2, 1, 'completed', 350.00);

-- Hae kaikki käyttäjät ja heidän roolinsa
SELECT username, role FROM users;

-- Hae kaikki tuotteet ja niiden myyjät
SELECT items.title, items.price, users.username AS seller
FROM items
JOIN users ON items.seller_id = users.user_id;

-- Päivitä tuotteen status myydyksi
UPDATE items
SET status = 'sold'
WHERE item_id = 1;
