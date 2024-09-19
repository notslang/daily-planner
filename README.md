# Daily Planner

This is a tool for creating general purpose printable daily planners.

## Features

These are the features that I care about in a daily planner:

- Labels for year, quarter, month, day of month, day of the week, and week of the year.
- Space to mark important days and todos. Holidays are marked by default.
- 3-4 days per page with each day broken down by hours.
- Hackable. Fork this project to add in your own custom days, reoccurring todos, and custom styles.
- Optimized for printing
- Space in the margin for 3 hole punch to store pages in a binder

## Anti-Features

These are features that are common in mass-produced daily planners that I am intentionally avoiding:

- Blank "notes" or "reflection" pages. These are filler pages and don't belong in a planner. The only notes you should be writing in a planner are what you are doing on a given day. It is a scheduling tool with pages that you can throw away or archive as soon as you're done with the week. Record observations & reflections elsewhere.
- Non-reusable spiral binding. Most daily planners that you buy from the store cannot be refilled with new pages. They are designed to be thrown away at the end of the year. This planner is designed to be put in a reusable/refillable 3-ring binder.
- Famous quotes, motivational platitudes, writing prompts, etc. These are a waste of printer ink.

## Printing Notes

Need to add a blank side to the first sheet of paper, so the week begins on the back side of the first sheet and days Monday - Sunday are visible all at once.

This generates an HTML page designed to be printed through your browser.

Left / right margins need to be increased to fit the 3-hole punch. Margins should be:
- Top: 13mm
- Bottom: 13mm
- Left: 18mm
- Right: 18mm

Enable two-sided printing (flip on long edge).

## Local Development

To start the Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Similar Projects

- [LaTeX Yearly Planner](https://github.com/kudrykv/latex-yearly-planner) - Similar concept, but with a different layout and more extras, like space for notes and reflection pages. Also, it's a hyperlinked PDF designed for e-readers. This one is free.
- [Hyperpaper Planner](https://github.com/af/hyperpaper-planner) - Another hyperlinked PDF designed for e-readers with an excellent aesthetic. However, it's proprietary.
