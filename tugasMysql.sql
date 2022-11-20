-- Active: 1668866724498@@127.0.0.1@3306@projects

-- TABLE archievements
CREATE TABLE achievements (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    image VARCHAR(100),
    isAktive ENUM ('aktif', 'tidak aktif'),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE topics
CREATE TABLE topics (
    id INT NOT NULL  PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    isAktive ENUM ('aktif', 'tidak aktif'),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE coupons
CREATE TABLE coupons (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)NOT NULL,
    discount INT NOT NULL,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE courses
CREATE TABLE courses (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100)NOT NULL,
    slug VARCHAR(100)NOT NULL,
    price INT NOT NULL,
    description TEXT,
    thumbnail VARCHAR(100),
    totalDuration VARCHAR(100),
    status ENUM ('aktif', 'tidak aktif'),
    totalVideo INT,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE users 
CREATE TABLE users (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)NOT NULL,
    email VARCHAR(100)NOT NULL,
    password VARCHAR (150) NOT NULL,
    role ENUM ('admin','member'),
    isAktive ENUM ('aktif', 'tidak aktif'),
    twitter VARCHAR(100),
    facebook VARCHAR(100),
    instagram VARCHAR(100),
    github VARCHAR(100),
    createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- TABLE testimonies
CREATE TABLE testimonies (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    courseId INT NOT NULL,
    userId INT NOT NULL,
    content TEXT,
    CONSTRAINT fk_testimoni1 Foreign Key (courseId) REFERENCES courses(id),
    CONSTRAINT fk_testimoni2 Foreign Key (userId) REFERENCES users(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE carts 
CREATE TABLE carts (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    courseId INT NOT NULL,
    userId INT NOT NULL,
    couponId INT NOT NULL,
    CONSTRAINT fk_cart1 Foreign Key (courseId) REFERENCES courses(id),
    CONSTRAINT fk_cart2 Foreign Key (userId) REFERENCES users(id),
    CONSTRAINT fk_cart3 Foreign Key (couponId) REFERENCES coupons(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE courseTopics
CREATE TABLE courseTopics (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    courseId INT NOT NULL,
    topicId INT NOT NULL,
    CONSTRAINT fk_courseTopic1 Foreign Key (courseId) REFERENCES courses(id),
    CONSTRAINT fk_courseTopic2 Foreign Key (topicId) REFERENCES topics(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE articles
CREATE TABLE articles (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    slug VARCHAR (100) NOT NULL,
    title VARCHAR (100) NOT NULL,
    date DATETIME,
    thumbnail VARCHAR (100),
    content TEXT,
    CONSTRAINT fk_article Foreign Key (userId) REFERENCES users(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE articleLikes
CREATE TABLE articleLikes (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    articleId INT NOT NULL,
    userId INT NOT NULL,
    CONSTRAINT fk_articleLike1 Foreign Key (articleId) REFERENCES articles(id),
    CONSTRAINT fk_articleLike2 Foreign Key (userId) REFERENCES users(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE videos
CREATE TABLE videos (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    courseId INT NOT NULL,
    title VARCHAR (100) NOT NULL,
    duration VARCHAR (100) NOT NULL,
    status ENUM ('aktif', 'tidak aktif'),
    url VARCHAR (100),
    CONSTRAINT fk_video Foreign Key (courseId) REFERENCES courses(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE wishlists
CREATE TABLE wishlists (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    courseId INT NOT NULL,
    userId INT NOT NULL,
    CONSTRAINT fk_wishlist1 Foreign Key (courseId) REFERENCES courses(id),
    CONSTRAINT fk_wishlist2 Foreign Key (userId) REFERENCES users(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE userAchievements
CREATE TABLE userAchievements (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    achiveId INT NOT NULL,
    CONSTRAINT fk_userAchievement1 Foreign Key (userId) REFERENCES users(id),
    CONSTRAINT fk_userAchievement2 Foreign Key (achiveId) REFERENCES achievements(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE viewHistories
CREATE TABLE viewHistories (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    videoId INT NOT NULL,
    isCompleted ENUM ('aktif', 'tidak aktif'),
    CONSTRAINT fk_viewHistori1 Foreign Key (userId) REFERENCES users(id),
    CONSTRAINT fk_viewHistori2 Foreign Key (videoId) REFERENCES videos(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- TABLE userCourses
CREATE TABLE userCourses (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    courseId INT NOT NULL,
    userId INT NOT NULL,
    CONSTRAINT fk_userCourse1 Foreign Key (courseId) REFERENCES courses(id),
    CONSTRAINT fk_userCourse2 Foreign Key (userId) REFERENCES users(Id)
);

-- TABLE comments
CREATE TABLE comments (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    articleId INT NOT NULL,
    userId INT NOT NULL,
    replyId INT NOT NULL,
    comment TEXT,
    CONSTRAINT fk_comment1 Foreign Key (articleId) REFERENCES articles(id),
    CONSTRAINT fk_comment2 Foreign Key (userId) REFERENCES users(id),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Menampilkan detail table/field
DESC testimonies;

-- Menampilkan table
SHOW TABLES;

-- Insert data users
INSERT INTO users (name, email, password, role, isAktive)
VALUES
("dedy irawan", "dedyy@gmail.com", "dedy990", "member", "aktif");

-- Insert data courses
INSERT INTO courses (title, slug, price, status, totalVideo)
VALUES
("kebaya merah", "mantap", 50000, "aktif", 1),
("KKn desa kenari", "lumayan", 45000, "tidak aktif", 1);

-- Menampilkan data
SELECT * FROM users;

SELECT title, price, status FROM courses;

-- join userCourses, users, courses, videos, testimonies
SELECT 
u.name, u.role, u.isAktive, c.title, c.price, c.status, v.duration, v.url, t.content
FROM usercourses AS uc
INNER JOIN users AS u ON u.id = uc.id
INNER JOIN courses AS c ON c.id = uc.id
INNER JOIN videos AS v ON v.id = c.id
INNER JOIN testimonies AS t ON t.id = u.id;

