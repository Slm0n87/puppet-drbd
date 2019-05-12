require 'spec_helper'

describe 'drbd', type: :class do
  let(:pre_condition) { 'Service <| |>' }

  it {
    is_expected.to contain_service('drbd')
  }

  context 'service_ensure' do
    describe 'with default values' do
      it {
        is_expected.to contain_service('drbd').with(
          'name'      => 'drbd',
          'ensure'    => 'running',
          'enable'    => 'true',
          'require'   => 'Package[drbd]',
          'restart'   => 'service drbd reload'
        )
      }
    end

    describe 'with unmanaged service' do
      let(:params) { { 'drbd::service_ensure' => 'unmanaged' } }

      it {
        is_expected.to contain_service('drbd').with(
          'name'      => 'drbd',
          'require'   => 'Package[drbd]',
          'restart'   => 'service drbd reload'
        )
        is_expected.to contain_service('drbd').without(
          'enable'
        )
      }
    end
  end
end
