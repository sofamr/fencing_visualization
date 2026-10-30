# Fencing Visualization

This project analyzes and visualizes international fencing competition results using the Kaggle dataset: [Fencing-Points-MF](https://www.kaggle.com/datasets/foillee/fencing-points).

## Purpose
- Clean and normalize the raw fencing dataset into structured relational tables using SQLite.
- Enable efficient multi-table joins between fencers, competitions, and scores.
- Analyze and visualize historical performance trends of elite fencers over time with Python, Pandas, and Seaborn.

---

## File Structure

```text
fencing_visualization/
├── data.csv        # Raw dataset from Kaggle (Fencing-Points-MF)
├── fencing.db      # SQLite database containing staging and normalized tables
├── main.ipynb      # Jupyter Notebook for data queries and visualizations
├── query.sql       # SQL schemas and migration queries to populate tables
└── Readme.md       # Project documentation
```

---

## Database Structure

The database `fencing.db` consists of a staging table (`main_db`) and three normalized entity tables (`fencers`, `comp`, `points`):

### 1. `main_db`
Raw staging table imported directly from `data.csv`.

| Column | Type | Description |
| :--- | :--- | :--- |
| `fie_ID` | `TEXT` | FIE unique identification number for each fencer |
| `fencer_name` | `TEXT` | Full name of the fencer |
| `age` | `TEXT` | Fencer age at the time of the event |
| `dob` | `TEXT` | Fencer date of birth (`YYYY-MM-DD`) |
| `nationality` | `TEXT` | Country representation (3-letter code) |
| `rank` | `TEXT` | World rank at the time of the event |
| `host_city` | `TEXT` | Host city of the competition |
| `event_type` | `TEXT` | Competition category (e.g., World Cup, Grand Prix) |
| `points_earned` | `TEXT` | World ranking points earned at the event |
| `date` | `TEXT` | Event date (`YYYY-MM-DD`) |

---

### 2. `fencers`
Stores fencer profiles and demographic details.

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | `PRIMARY KEY` | Auto-incrementing identifier |
| `fie_ID` | `INTEGER` | | FIE unique fencer license ID |
| `name` | `TEXT` | `NOT NULL` | Fencer full name |
| `dob` | `DATE` | `NOT NULL` | Date of birth |
| `nationality` | `TEXT` | `NOT NULL` | Country represented |
| `rank` | `INTEGER` | `NOT NULL` | World ranking |

---

### 3. `comp`
Stores competition event metadata.

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | `PRIMARY KEY` | Auto-incrementing competition ID |
| `event_type` | `TEXT` | `NOT NULL` | Type of event (e.g., World Cup, Grand Prix) |
| `comp_date` | `DATE` | `NOT NULL` | Date of competition |
| `host_city` | `TEXT` | `NOT NULL` | Host city |

---

### 4. `points`
Junction table tracking points earned by a fencer in a given competition.

| Column | Type | Constraints | Description |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | `PRIMARY KEY` | Auto-incrementing result record ID |
| `fie_ID` | `INTEGER` | `NOT NULL` | Fencer's FIE ID |
| `comp_id` | `INTEGER` | `NOT NULL` | Reference to `comp.id` |
| `points_earned` | `FLOAT` | `NOT NULL` | Points earned in this competition |

---

## Setup & Requirements

### 1. Prerequisites
Ensure Python 3.10+ and SQLite3 are installed.

### 2. Install Python Dependencies
```bash
pip install pandas seaborn matplotlib ipykernel
```

---

## Usage

### 1. Database Creation & Population
The database is built and populated by executing the queries in `query.sql` :

```bash
sqlite3 fencing.db < query.sql
```

### 2. Querying & Visualization
Open `main.ipynb` in Jupyter Notebook or VS Code to run queries and render charts.

Example query used to extract points progression for a specific fencer and season:
```sql
SELECT
    c.comp_date,
    p.points_earned
FROM comp c
JOIN points p ON c.id = p.comp_id
WHERE c.comp_date LIKE '2012%' 
  AND p.fie_ID = (
      SELECT fie_ID FROM fencers WHERE name = 'MASSIALAS Alexander' LIMIT 1
  );
```

Using Seaborn to visualize performance:
```python
import matplotlib.pyplot as plt
import seaborn as sns

plt.figure(figsize=(10, 5))
ax = sns.lineplot(data=alexander_points_df, x='comp_date', y='points_earned')
ax.set_title("MASSIALAS Alexander's Points in 2012")
ax.set_xlabel('Dates')
ax.set_ylabel('Points Earned')
plt.show()
``