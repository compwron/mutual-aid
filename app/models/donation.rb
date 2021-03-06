class Donation < ApplicationRecord
  belongs_to :person, optional: true

  has_many :matches, as: :receiver
  has_many :matches, as: :provider

  accepts_nested_attributes_for :person

  CHANNELS = ["cold call", "website", "email campaign"]

  scope :this_month, -> { where("donations.created_at >= ? AND donations.created_at <= ?",
                                Time.zone.now.beginning_of_month, Time.zone.now.end_of_month) }

  def name
    "#{created_at.strftime('%m-%d-%Y')}: #{person&.name}"
  end
end
