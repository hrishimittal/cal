require 'date'

def print_calendar
	t = Time.now
	calendar = current_month(t)
	calendar += day_titles

	first_dow = first_day_of_week_for_month(t)

	weeks = [Array.new(7, "  ")]
	last_day = last_day_of_month(t.year, t.month)
	
	weeks = calculate_week_rows(last_day, weeks, first_dow)

	weeks.each do |w| 
		calendar += "\n"
		calendar += w.join " "
	end

	calendar
end


def calculate_week_rows(last_day, weeks, day_of_week)
	weekindex = 0

	for i in 1..last_day
		i = " #{i}" if i.to_s.length == 1

		weeks[weekindex][day_of_week] = i
		day_of_week = (day_of_week + 1) % 7
		if day_of_week == 0
			weekindex += 1
			weeks << []
		end
	end

	weeks
end

def first_day_of_week_for_month(time)
	current_year = time.year
	current_month = time.month
	Date.civil(current_year, current_month).wday
end


def current_month(t)
	month_title = t.strftime "%B %Y"
	((20 - month_title.length)/2).times {|i| month_title = " #{month_title}" }
	month_title
end

def day_titles
	"\n" + ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"].join(" ")
end

def last_day_of_month(year, month)
	Date.civil(year, month, -1).day
end

puts print_calendar
