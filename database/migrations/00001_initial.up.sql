BEGIN;

CREATE TABLE IF NOT EXISTS users
(
    id          UUID PRIMARY KEY         DEFAULT gen_random_uuid(),
    name        TEXT                       NOT NULL,
    email       TEXT                       NOT NULL,
    password    TEXT                       NOT NULL,
    created_by  UUID REFERENCES users (id) NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    archived_at TIMESTAMP WITH TIME ZONE
);
CREATE UNIQUE INDEX IF NOT EXISTS active_user ON users (email) WHERE archived_at IS NULL;

CREATE TABLE IF NOT EXISTS address
(
    address     TEXT                       NOT NULL,
    user_id     UUID REFERENCES users (id) NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    archived_at TIMESTAMP WITH TIME ZONE
);
CREATE UNIQUE INDEX IF NOT EXISTS unique_address ON address (user_id, address) WHERE archived_at IS NULL;

CREATE TYPE role_type AS ENUM (
    'admin',
    'sub-admin',
    'user'
);

CREATE TABLE IF NOT EXISTS user_roles
(
    user_id     UUID REFERENCES users (id) NOT NULL,
    role        role_type                  NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    archived_at TIMESTAMP WITH TIME ZONE
);
CREATE UNIQUE INDEX IF NOT EXISTS unique_role ON user_roles (user_id, role) WHERE archived_at IS NULL;

CREATE TABLE IF NOT EXISTS user_session
(
    id          UUID PRIMARY KEY         DEFAULT gen_random_uuid(),
    user_id     UUID REFERENCES users (id) NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    archived_at TIMESTAMP WITH TIME ZONE
);

CREATE TABLE IF NOT EXISTS restaurants
(
    id          UUID PRIMARY KEY         DEFAULT gen_random_uuid(),
    name        TEXT                       NOT NULL,
    address     TEXT                       NOT NULL,
    created_by  UUID REFERENCES users (id) NOT NULL,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    archived_at TIMESTAMP WITH TIME ZONE
);
CREATE UNIQUE INDEX IF NOT EXISTS unique_restaurant ON restaurants (address, name) WHERE archived_at IS NULL;

CREATE TABLE IF NOT EXISTS dishes
(
    id            UUID PRIMARY KEY         DEFAULT gen_random_uuid(),
    name          TEXT                             NOT NULL,
    price         INTEGER                          NOT NULL,
    restaurant_id UUID REFERENCES restaurants (id) NOT NULL,
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    archived_at   TIMESTAMP WITH TIME ZONE
);
CREATE UNIQUE INDEX IF NOT EXISTS unique_dish ON dishes (restaurant_id, name) WHERE archived_at IS NULL;

COMMIT;