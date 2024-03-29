# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :pingal_server,
  ecto_repos: [PingalServer.Repo]

# Configures the endpoint
# secret_key_base: System.get_env("SECRET_KEY_BASE"),
# "OkQT0h0zjWPbgoGvv5bowc151aR2/BrRO3NMNJnQJoh/ebB0uDg5dpD7bCU4FPUx"
config :pingal_server, PingalServer.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE") ,
  render_errors: [view: PingalServer.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PingalServer.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Guardian
# "9eZBL43E8zdb0SOn3D16s2d/V4SN0Hp7Vo14U2ALZWHbMJ2jqbNgChC8KKUFHXSc"
# secret_key: System.get_env("GUARDIAN_SECRET_KEY")
config :guardian, Guardian,
  issuer: "PingalServer",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: System.get_env("GUARDIAN_SECRET_KEY"),
  serializer: PingalServer.GuardianSerializer

config :exns, nanoservices: [

  [name: :math_service,
   address: "ipc:///tmp/math-service.sock",
   timeout: 5000,
   workers: 10,
   encoder: "json"],

  [name: :string_service,
   address: "ipc:///tmp/string-service.sock",
   timeout: 5000,
   workers: 10,
   encoder: "json"]]
