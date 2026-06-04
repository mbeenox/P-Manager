# Cloning the App for Your Side Business

This is a complete, independent copy of your project management app. When set up, it will be **totally separate** from your 9-5 app — different website URL, different database, no shared data. Changing one never affects the other.

## The key idea

Your app has three pieces. To clone it, you create a NEW version of each:

| Piece | Your 9-5 app | Side business app (new) |
|-------|-------------|------------------------|
| **Database** (Supabase) | existing project | **create a new project** |
| **Code** (GitHub) | `structural-projects` repo | **create a new repo** |
| **Website** (Vercel) | existing deployment | **create a new deployment** |

The files in this folder are the code. You just need new Supabase + GitHub + Vercel setups to point them at.

> **Important:** Do NOT reuse your 9-5 Supabase database. If you do, both apps would read and write the same projects. The whole point is a separate database.

---

## Step 1: New Database (Supabase)

1. Go to [supabase.com](https://supabase.com) — you can use the **same login** as before
2. Click **New Project** (this makes a second, separate project)
   - **Name**: `sidebiz-projects`
   - Set a database password, pick a region
   - Click **Create new project**, wait ~2 minutes
3. Go to **SQL Editor** → **New query**
4. Open `supabase/setup-complete.sql` from this folder, copy everything, paste it in
5. Click **Run** — this creates both tables (projects + settings) in one step. Starts empty so you add your own side-business projects.
6. Go to **Settings** → **API** and copy:
   - **Project URL**
   - **anon / public** key

---

## Step 2: New GitHub Repo

1. Go to [github.com](https://github.com) → **+** → **New repository**
   - **Name**: `sidebiz-projects`
   - Click **Create repository**
2. Click **uploading an existing file**
3. Drag in everything from this folder — make sure the `src` and `supabase` folders upload as folders (you should see `src/App.jsx`, `src/main.jsx`, `src/supabase.js`, `supabase/setup-complete.sql`)
4. Click **Commit changes**

---

## Step 3: New Vercel Deployment

1. Go to [vercel.com](https://vercel.com) → **Add New** → **Project**
2. Select your new `sidebiz-projects` repo → **Import**
3. Expand **Environment Variables** and add the two from Step 1:

   | Key | Value |
   |-----|-------|
   | `VITE_SUPABASE_URL` | Your NEW Project URL |
   | `VITE_SUPABASE_ANON_KEY` | Your NEW anon key |

4. Click **Deploy**
5. You'll get a new URL like `sidebiz-projects.vercel.app` — bookmark it separately from your 9-5 app

---

## Done

You now have two completely independent apps:
- Your 9-5 app at its original URL → its own database
- Your side business app at the new URL → its own database

Add, edit, archive, or delete projects in one and the other is untouched.

---

## Tips

- **Rename the heading**: The app shows "Structural Projects" at the top. If you want the side-business version to say something different, edit `src/App.jsx` — search for `Structural Projects` and `ACTIVE PROJECT SCHEDULE` and change those two strings, then commit.
- **Customize managers/types**: Near the top of `src/App.jsx` are the `MANAGERS` and `PROJECT_TYPES` lists — tailor them to your side business.
- **Both apps update independently**: pushing code to one repo only redeploys that repo's Vercel project.
