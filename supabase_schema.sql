-- Supabase PostgreSQL Schema
-- 在 Supabase SQL Editor 中执行此脚本
-- 用户表
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- 插入默认用户
INSERT INTO users (id, username, password)
VALUES (1, '默认用户', '') ON CONFLICT (id) DO NOTHING;
-- 计划表
CREATE TABLE IF NOT EXISTS todos (
    id SERIAL PRIMARY KEY,
    user_id INT DEFAULT 1,
    text VARCHAR(255) NOT NULL,
    start_time VARCHAR(10),
    end_time VARCHAR(10),
    completed BOOLEAN DEFAULT FALSE,
    created_at VARCHAR(20)
);
-- 交易表
CREATE TABLE IF NOT EXISTS transactions (
    id SERIAL PRIMARY KEY,
    user_id INT DEFAULT 1,
    type VARCHAR(10) NOT NULL CHECK (type IN ('income', 'expense')),
    category VARCHAR(50),
    description VARCHAR(255),
    amount DECIMAL(10, 2) NOT NULL,
    created_at VARCHAR(20)
);
-- 创建索引优化查询
CREATE INDEX IF NOT EXISTS idx_todos_date ON todos(created_at);
CREATE INDEX IF NOT EXISTS idx_todos_user ON todos(user_id);
CREATE INDEX IF NOT EXISTS idx_trans_date ON transactions(created_at);
CREATE INDEX IF NOT EXISTS idx_trans_user ON transactions(user_id);