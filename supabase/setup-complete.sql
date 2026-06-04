-- =============================================================
-- COMPLETE DATABASE SETUP FOR SIDE BUSINESS APP
-- Run this ONCE in your NEW Supabase project's SQL Editor
-- (Dashboard > SQL Editor > New query > paste > Run)
-- This creates everything in one step. Starts with an empty
-- projects table (no sample data).
-- =============================================================

-- 1. Projects table (includes hold_date column)
CREATE TABLE IF NOT EXISTS projects (
  id BIGSERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  number TEXT NOT NULL,
  state TEXT DEFAULT 'TX',
  manager TEXT NOT NULL,
  type TEXT DEFAULT 'TFO',
  go_by TEXT DEFAULT '',
  kick_off DATE,
  qcll DATE,
  pcd DATE,
  fee NUMERIC DEFAULT 0,
  target_hours NUMERIC DEFAULT 0,
  hours_spent NUMERIC DEFAULT 0,
  hold_date DATE DEFAULT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow full access" ON projects
  FOR ALL USING (true) WITH CHECK (true);

-- Auto-update trigger for updated_at
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_projects_modtime
  BEFORE UPDATE ON projects
  FOR EACH ROW EXECUTE FUNCTION update_modified_column();

-- 2. Settings table (stores the global rate)
CREATE TABLE IF NOT EXISTS settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE settings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow full access to settings" ON settings
  FOR ALL USING (true) WITH CHECK (true);

INSERT INTO settings (key, value) VALUES ('rate', '100')
  ON CONFLICT (key) DO NOTHING;

-- =============================================================
-- OPTIONAL: If you want a couple of sample rows to start with,
-- uncomment and run the lines below. Otherwise leave them out
-- and just add projects through the app.
-- =============================================================
-- INSERT INTO projects (name, number, state, manager, type, kick_off, qcll, pcd, fee, hours_spent) VALUES
--   ('Sample Project 1', 'SB25001', 'TX', 'MJ', 'TFO', '2026-01-15', '2026-02-15', '2026-03-01', 5000, 0),
--   ('Sample Project 2', 'SB25002', 'TX', 'EM', 'Ground up', '2026-02-01', '2026-03-01', '2026-04-01', 12000, 0);
