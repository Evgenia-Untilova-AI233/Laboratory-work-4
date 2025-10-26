CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE financial_data (
    finance_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    account_balance NUMERIC(10, 2),
    income NUMERIC(10, 2),
    expense NUMERIC(10, 2)
);

CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    finance_id INT REFERENCES financial_data(finance_id) ON DELETE CASCADE,
    amount NUMERIC(10, 2) CHECK (amount > 0),
    trans_type VARCHAR(10) CHECK (trans_type IN ('income', 'expense')),
    trans_date TIMESTAMP NOT NULL
);

CREATE TABLE weather_data (
    weather_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
    temperature FLOAT,
    weather_date TIMESTAMP NOT NULL
);

ALTER TABLE users
ADD CONSTRAINT chk_full_name_no_digits
CHECK (full_name !~ '[0-9]');

ALTER TABLE users
ADD CONSTRAINT chk_email_format
CHECK (email ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$');
