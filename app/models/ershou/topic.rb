require 'ipaddr'

module Ershou
  class Topic < ActiveRecord::Base

    attr_accessible :title, :content
    attr_accessible :price, :phone, :qq

    belongs_to :user
    belongs_to :node, :counter_cache => true
    has_many :comments, :dependent => :destroy

    has_many :attachments, :dependent => :destroy
    accepts_nested_attributes_for :attachments
    attr_accessible :attachments_attributes

    validates :title, :presence => true
    validates :price, :presence => true

    #validates :phone, :presence => true
    #validates :qq, :presence => true
    
    acts_as_paranoid

    state_machine :initial => :open do
      event 'open' do
        transition all => :open
      end
      event 'close' do
        transition all => :closed
      end

    end

    acts_as_readable :on => :updated_at

    #before_create do |topic|
    #  remote_ip = IPAddr.new topic.remote_ip || "0.0.0.0"
    #  Location.all.each do |location|
    #    prefix = IPAddr.new location.prefix || "0.0.0.0"
    #    if prefix.include?(remote_ip)
    #      topic.node = location.node
    #      break
    #    end
    #  end
    #end

  end
end
