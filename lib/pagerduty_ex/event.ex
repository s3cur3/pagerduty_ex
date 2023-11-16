defmodule PagerDutyEx.Event do
  @derive Jason.Encoder
  defstruct routing_key: nil,
            # Required: "Integration Key" listed on the Events API V2 integration's detail page
            # Required: Supported values are "trigger", "acknowledge", and "resolve"
            event_action: nil,
            # Deduplication key for correlating triggers and resolves
            dedup_key: nil,
            # The event details. See the Event.Payload struct below.
            payload: nil,
            # List of images to include
            images: [],
            # List of links to include
            links: []
end

defmodule PagerDutyEx.Event.Payload do
  @derive Jason.Encoder
  @enforce_keys [:summary, :source, :severity]
  defstruct summary: nil,
            # A brief text summary of the event
            # Hostname or FQDN
            source: nil,
            # Supported values: "critical", "error", "warning", or "info"
            severity: nil,
            # The time at which the event was generated, e.g. 2015-07-17T08:42:58.315+0000
            timestamp: nil,
            # Component that is responsible for the event, e.g. "mysql" or "eth0"
            component: nil,
            # Logical grouping of components of a service, e.g. "app-stack"
            group: nil,
            # The class/type of the event, e.g. "ping failure" or "cpu load"
            class: nil,
            # Additional details about the event
            custom_details: nil
end
