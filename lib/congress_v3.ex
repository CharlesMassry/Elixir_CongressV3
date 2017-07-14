defmodule CongressV3 do
  use HTTPoison.Base
  @base_uri "https://congress.api.sunlightfoundation.com"

  def get_bills do
    full_params = %{page: 1, per_page: 50 } |>
      CongressV3.default_params |>
      CongressV3.parameterize
    "/bills?" <> full_params |> CongressV3.get
  end

  def get_bills(params=%{page: 1, per_page: 50}) do
    full_params = params |> CongressV3.default_params |> CongressV3.parameterize
    "/bills?" <> full_params
  end

  def process_url(url) do
    @base_uri <> url
  end

  def process_response_body(body) do
    body
      |> Poison.decode!
      |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
   end

  def default_params(params) do
     params |> Map.merge(%{ api_key: "SUNLIGHT_API_KEY" |> System.get_env })
  end

  def parameterize(params_map) do
    params_map |> Enum.map_join("&", fn {key, value} -> "#{key}=#{value}" end)
  end
end
