CREATE TABLE IF NOT EXISTS comp(
    id INTEGER PRIMARY KEY,
    event_type TEXT NOT NULL,
    comp_date DATE NOT NULL,
    host_city TEXT NOT NULL,

    FOREIGN KEY (event_type) REFERENCES main_db(event_type),
    FOREIGN KEY (comp_date) REFERENCES main_db(date),
    FOREIGN KEY (host_city) REFERENCES main_db(host_city)
);

-- INSERT INTO comp (event_type, comp_date, host_city)
-- SELECT DISTINCT event_type, date, host_city 
-- FROM main_db;

CREATE TABLE IF NOT EXISTS fencers(
    id INTEGER PRIMARY KEY,
    fie_ID INTEGER,
    name TEXT NOT NULL,
    dob DATE NOT NULL,
    nationality TEXT NOT NULL,
    rank INTEGER NOT NULL,
    
    FOREIGN KEY (fie_ID) REFERENCES main_db(fie_ID),
    FOREIGN KEY (name) REFERENCES main_db(fencer_name),
    FOREIGN KEY (dob) REFERENCES main_db(dob),
    FOREIGN KEY (nationality) REFERENCES main_db(nationality),
    FOREIGN KEY (rank) REFERENCES main_db(rank)
);

-- INSERT OR IGNORE INTO fencers (fie_ID, name, dob, nationality, rank)
-- SELECT DISTINCT fie_ID, fencer_name, dob, nationality, rank
-- FROM main_db;

CREATE TABLE IF NOT EXISTS points(
    id INTEGER PRIMARY KEY,
    fie_ID INTEGER NOT NULL,
    comp_id INTEGER NOT NULL,
    points_earned FLOAT NOT NULL,

    FOREIGN KEY (fie_ID) REFERENCES main_db(fie_ID),
    FOREIGN KEY (fie_ID) REFERENCES main_db(fie_ID),
    FOREIGN KEY (points_earned) REFERENCES main_db(points_earned)
);

-- INSERT INTO points (fie_ID, comp_id, points_earned)
-- SELECT 
--     m.fie_ID, 
--     c.id AS comp_id, 
--     m.points_earned
-- FROM main_db m
-- JOIN comp c 
--     ON m.event_type = c.event_type
--     AND m.date = c.comp_date 
--     AND m.host_city = c.host_city;