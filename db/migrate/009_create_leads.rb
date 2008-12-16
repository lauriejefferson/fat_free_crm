class CreateLeads < ActiveRecord::Migration
  def self.up
    create_table :leads, :force => true do |t|
      t.string      :uuid,   :limit => 36
      t.references  :user
      t.references  :campaign
      t.integer     :assigned_to
      t.string      :salutation,  :limit => 16
      t.string      :first_name,  :limit => 64, :null => false, :default => ""
      t.string      :last_name,   :limit => 64, :null => false, :default => ""
      t.string      :access,      :limit => 8, :default => "Private"
      t.string      :company,     :limit => 64
      t.string      :title,       :limit => 64
      t.string      :source,      :limit => 32
      t.string      :status,      :limit => 32
      t.integer     :rating
      t.string      :referred_by, :limit => 64
      t.string      :website,     :limit => 64
      t.string      :email,       :limit => 64
      t.string      :phone,       :limit => 32
      t.string      :mobile,      :limit => 32
      t.string      :fax,         :limit => 32
      t.string      :address
      t.boolean     :do_not_call, :null => false, :default => false
      t.text        :notes
      t.datetime    :deleted_at
      t.timestamps
    end

    add_index :leads, [ :user_id, :last_name, :deleted_at ], :unique => true
    add_index :leads, :uuid
    ActiveRecord::Base.connection.execute("CREATE TRIGGER leads_uuid BEFORE INSERT ON leads FOR EACH ROW SET NEW.uuid = UUID()");
  end

  def self.down
    drop_table :leads
  end
end
