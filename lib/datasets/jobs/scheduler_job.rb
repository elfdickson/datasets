require "datasets/job"
require "datasets/managed_safe_run"

module Datasets
  class SchedulerJob < Job
    @queue = :scheduling

    def initialize(profile)
      @profile = profile
    end

    def perform
      ManagedSafeRun.new(profile).execute
    end

    def serialize
      [profile.to_s]
    end

    def self.deserialize(profile)
      new(profile.to_sym)
    end

    private
    attr_accessor :profile
  end
end
