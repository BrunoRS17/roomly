CREATE TABLE "users" (
  "id" uuid PRIMARY KEY,
  "name" varchar(100) NOT NULL,
  "email" varchar(255) UNIQUE NOT NULL,
  "password_hash" varchar,
  "created_at" timestamptz NOT NULL DEFAULT (now()),
  "updated_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "rooms" (
  "id" uuid PRIMARY KEY,
  "name" varchar(100) NOT NULL,
  "capacity" int NOT NULL,
  "hourly_price" numeric(10,2) NOT NULL
);

CREATE TABLE "reservations" (
  "id" uuid PRIMARY KEY,
  "user_id" uuid NOT NULL,
  "room_id" uuid NOT NULL,
  "starts_at" timestamptz NOT NULL,
  "ends_at" timestamptz NOT NULL,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE INDEX "idx_reservation_user" ON "reservations" ("user_id");

CREATE INDEX "idx_reservation_room" ON "reservations" ("room_id");

CREATE INDEX "idx_reservation_room_start" ON "reservations" ("room_id", "starts_at");

ALTER TABLE "reservations" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "reservations" ADD FOREIGN KEY ("room_id") REFERENCES "rooms" ("id") DEFERRABLE INITIALLY IMMEDIATE;
