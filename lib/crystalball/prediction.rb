# frozen_string_literal: true

module Crystalball
  # Class for Crystalball prediction results
  class Prediction
    def initialize(cases)
      @cases = cases
    end

    # When the cases are something like:
    #   ./spec/foo ./spec/foo/bar_spec.rb
    # this returns just ./spec/foo
    def compact
      sort_by(&:length).uniq { |c| c.match(/(\.\/)|(.+)\//)[0] }
    end

    def to_a
      cases
    end

    def method_missing(*args, &block)
      cases.respond_to?(*args) ? cases.public_send(*args, &block) : super
    end

    def respond_to_missing?(*args)
      cases.respond_to?(*args)
    end

    private

    attr_reader :cases
  end
end
