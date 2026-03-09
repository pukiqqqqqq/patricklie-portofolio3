/*
  # Create messages table for contact form submissions

  1. New Tables
    - `messages`
      - `id` (uuid, primary key)
      - `name` (text, required)
      - `email` (text, required)
      - `message` (text, required)
      - `is_read` (boolean, default false)
      - `created_at` (timestamp, auto-generated)
  
  2. Security
    - Enable RLS on `messages` table
    - Anyone can insert messages (public form submissions)
    - Only authenticated users can read their own messages (for future admin panel)
*/

CREATE TABLE IF NOT EXISTS messages (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  email text NOT NULL,
  message text NOT NULL,
  is_read boolean DEFAULT false,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE messages ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can insert messages"
  ON messages
  FOR INSERT
  TO anon
  WITH CHECK (true);

CREATE POLICY "Only authenticated users can read messages"
  ON messages
  FOR SELECT
  TO authenticated
  USING (true);
