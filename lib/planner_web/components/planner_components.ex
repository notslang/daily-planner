defmodule PlannerWeb.PlannerComponents do
  use Phoenix.Component

  @days_of_week [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ]

  @months_of_year [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ]

  def planner(assigns) do
    start_date = Date.utc_today() |> Date.add(1) |> Date.beginning_of_week()
    total_weeks = 1

    assigns =
      assigns
      |> assign(:start_date, start_date)
      |> assign(:total_weeks, total_weeks)

    ~H"""
    <%= for week <- 0..(@total_weeks - 1) do %>
      <.week start_date={Date.add(@start_date, week * 7)} />
    <% end %>
    """
  end

  def week(assigns) do
    start = assigns.start_date
    page_1_days = [start, Date.add(start, 1), Date.add(start, 2)]
    page_2_days = [Date.add(start, 3), Date.add(start, 4), Date.add(start, 5), Date.add(start, 6)]

    assigns =
      assigns
      |> assign(:page_1_days, page_1_days)
      |> assign(:page_2_days, page_2_days)

    ~H"""
    <.page_with_days todo={true} days={@page_1_days} />
    <.page_with_days todo={false} days={@page_2_days} />
    """
  end

  def page_with_days(assigns) do
    first_day_on_page = Enum.at(assigns.days, 0)
    last_day_on_page = Enum.at(assigns.days, -1)
    week_of_year = week_of_year(first_day_on_page)

    assigns =
      assigns
      |> assign(:week_of_year, week_of_year)
      |> assign(:month_of_year, month(first_day_on_page, last_day_on_page))
      |> assign(:date_range, range(first_day_on_page, last_day_on_page))

    ~H"""
    <.page>
      <header class="flex items-end justify-between pb-6">
        <h1 class="uppercase text-4xl"><%= @month_of_year %></h1>
        <h1 class="uppercase text-xl">Week <%= @week_of_year %> | <%= @date_range %></h1>
      </header>
      <div class="grow flex flex-row items-stretch space-x-3">
        <%= if @todo do %>
          <.todo />
        <% end %>
        <%= for day <- @days do %>
          <.day date={day} />
        <% end %>
      </div>
    </.page>
    """
  end

  slot :inner_block, required: true

  def page(assigns) do
    ~H"""
    <div class="w-screen h-screen flex flex-col">
      <%= render_slot(@inner_block) %>
    </div>
    """
  end

  slot :inner_block, required: true

  def vertical_container(assigns) do
    ~H"""
    <div class="grow basis-0 flex flex-col items-stretch">
      <h2 class="border-solid border-2 border-black mb-3 px-1">
        <%= if @title do %>
          <%= @title %>
        <% else %>
          &nbsp;
        <% end %>
      </h2>
      <div class="grow flex flex-col items-stretch border-solid border-2 border-black px-1">
        <%= render_slot(@inner_block) %>
      </div>
    </div>
    """
  end

  def day(assigns) do
    %Date{day: day} = assigns.date
    formatted_day = pad(day)
    day_of_week = Enum.at(@days_of_week, Date.day_of_week(assigns.date) - 1)

    assigns =
      assigns
      |> assign(:formatted_day, formatted_day)
      |> assign(:day_of_week, day_of_week)

    ~H"""
    <.vertical_container title={"#{@formatted_day} | #{@day_of_week}"}>
      <div class="grow h-10 pt-2">
        <h3 class="text-gray-400 text-xs"><%= motd(@date) %></h3>
      </div>

      <%= for hour <- 8..20 do %>
        <div class="grow">
          <h3 class="text-gray-400 text-xs"><%= pad(hour) %></h3>
        </div>
      <% end %>
    </.vertical_container>
    """
  end

  def todo(assigns) do
    ~H"""
    <.vertical_container title={nil}></.vertical_container>
    """
  end

  defp pad(number) do
    number |> Integer.to_string() |> String.pad_leading(2, "0")
  end

  defp week_of_year(%Date{year: year, month: month, day: day}) do
    {_year, week_of_year} = :calendar.iso_week_number({year, month, day})
    week_of_year
  end

  defp month(%Date{month: start_month}, %Date{month: end_month}) when start_month == end_month do
    Enum.at(@months_of_year, start_month - 1)
  end

  defp month(%Date{month: start_month}, %Date{month: end_month}) do
    Enum.at(@months_of_year, start_month - 1) <> " / " <> Enum.at(@months_of_year, end_month - 1)
  end

  defp range(%Date{day: start_day, month: start_month}, %Date{day: end_day, month: end_month}) do
    "#{pad(start_month)}/#{pad(start_day)} - #{pad(end_month)}/#{pad(end_day)}"
  end

  @message_of_the_day %{
    ~D[2024-08-22] => "First Day Of Session A",
    ~D[2024-08-25] => "Tuition Due",
    ~D[2024-08-27] => "ElixirConf Start",
    ~D[2024-08-28] => "Drop Deadline",
    ~D[2024-08-30] => "ElixirConf End",
    ~D[2024-09-02] => "Labor Day Observed",
    ~D[2024-09-28] => "Jordan's Birthday",
    ~D[2024-09-30] => "Registration Begins",
    ~D[2024-10-11] => "Last Day Of Session A",
    ~D[2024-10-12] => "Fall Break Start",
    ~D[2024-10-15] => "Fall Break End",
    ~D[2024-10-16] => "First Day Of Session B",
    ~D[2024-10-22] => "Drop Deadline",
    ~D[2024-11-11] => "Veterans Day Observed",
    ~D[2024-11-28] => "Thanksgiving Observed",
    ~D[2024-11-29] => "Thanksgiving Observed",
    ~D[2024-12-06] => "Last Day Of Session B"
  }

  defp motd(day), do: Map.get(@message_of_the_day, day)
end
