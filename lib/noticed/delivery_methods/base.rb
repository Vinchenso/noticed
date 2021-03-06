module Noticed
  module DeliveryMethods
    class Base < Noticed.parent_class.constantize
      extend ActiveModel::Callbacks
      define_model_callbacks :deliver

      attr_reader :notification, :options, :recipient

      def perform(notification_class:, options:, params:, recipient:, record:)
        @notification = notification_class.constantize.new(params)
        @options = options
        @recipient = recipient

        # Keep track of the database record for rendering
        @notification.record = record

        run_callbacks :deliver do
          deliver
        end
      end

      def deliver
        raise NotImplementedError, "Delivery methods must implement a deliver method"
      end
    end
  end
end
