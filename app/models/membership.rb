class Membership < ApplicationRecord
  belongs_to :gym
  belongs_to :client

  validates :gym_id, presence: true
  validates :client_id, presence: true
  validates :charge, presence: true
  validates :charge, numericality: { greater_than: 0 }

  # validates :client, uniqueness: { scope: :gym }

  validate :unique_membership

  def unique_membership
    Membership.all.each do |m|
      if client_id == m.client_id && gym_id == m.gym_id
        errors.add(:client_id, "Can only have one membership at one gym")
      end
    end
  end
end
