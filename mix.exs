defmodule PagerdutyEx.Mixfile do
  use Mix.Project

  def project do
    [
      app: :pagerduty_ex,
      version: "1.0.0",
      elixir: "~> 1.8",
      elixirc_paths: elixirc_paths(Mix.env()),
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      aliases: aliases(),
      deps: deps(),
      dialyzer: [
        # ignore_warnings: ".dialyzer_ignore.exs",
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
        flags: [:error_handling, :unknown],
        # Error out when an ignore rule is no longer useful so we can remove it
        list_unused_filters: true
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        check: :test,
        dialyzer: :dev,
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  defp package do
    [
      name: :pagerduty_ex,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["acjensen@gmail.com"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/acj/pagerduty_ex"}
    ]
  end

  defp description do
    """
    A simple client library for PagerDuty API v2.
    """
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      extra_applications: [
        :httpoison,
        :logger
      ]
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:cowboy, "~> 1.0", only: :test},
      {:dialyxir, "~> 1.2", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:httpoison, "~> 2.2"},
      {:jason, "~> 1.4"},
      {:retry, "~> 0.13"},
      {:excoveralls, "~> 0.10", only: :test},
      {:recode, "~> 0.6", only: [:dev, :test]}
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp aliases do
    [
      check: [
        "clean",
        "check.fast",
        "test --warnings-as-errors --only integration"
      ],
      "check.fast": [
        "deps.unlock --check-unused",
        "compile --warnings-as-errors",
        "test --warnings-as-errors",
        "check.quality"
      ],
      "check.quality": [
        "format --check-formatted",
        "check.circular",
        "check.dialyzer",
        "recode"
      ],
      "check.circular": "cmd MIX_ENV=dev mix xref graph --label compile-connected --fail-above 0",
      "check.dialyzer": "cmd MIX_ENV=dev mix dialyzer"
    ]
  end
end
