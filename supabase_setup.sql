-- Supabase Table Setup for BotForge AI Agency
-- Run this query in your Supabase SQL Editor:

CREATE TABLE IF NOT EXISTS public.bot_orders (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    client_name TEXT NOT NULL,
    business_name TEXT NOT NULL,
    phone TEXT NOT NULL,
    package_name TEXT NOT NULL,
    price TEXT,
    notes TEXT,
    status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'contacted', 'completed', 'cancelled'))
);

-- Enable Row Level Security (RLS)
ALTER TABLE public.bot_orders ENABLE ROW LEVEL SECURITY;

-- Allow public anonymous inserts (so your storefront visitors can submit orders)
CREATE POLICY "Allow anonymous orders insertion" 
ON public.bot_orders 
FOR INSERT 
TO anon 
WITH CHECK (true);

-- Allow authenticated users (you) to view all orders
CREATE POLICY "Allow authenticated read" 
ON public.bot_orders 
FOR SELECT 
TO authenticated 
USING (true);
