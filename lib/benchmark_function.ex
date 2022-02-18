defmodule BenchmarkFunction do
  @moduledoc """
  Documentation for `BenchmarkFunction`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> BenchmarkFunction.hello()
      :world

  """
  def run do
    provinces = [
      %{id: "203", name: "Cao Bằng"},
      %{id: "207", name: "Bắc Kạn"},
      %{id: "301", name: "Lai Châu"},
      %{id: "405", name: "Hà Tĩnh"},
      %{id: "305", name: "Hòa Bình"},
      %{id: "221", name: "Bắc Giang"},
      %{id: "302", name: "Điện Biên"},
      %{id: "201", name: "Hà Giang"},
      %{id: "605", name: "Đắk Lắk"},
      %{id: "106", name: "Bắc Ninh"},
      %{id: "303", name: "Sơn La"},
      %{id: "211", name: "Tuyên Quang"},
      %{id: "409", name: "Quảng Trị"},
      %{id: "205", name: "Lào Cai"},
      %{id: "213", name: "Yên Bái"},
      %{id: "109", name: "Hưng Yên"},
      %{id: "111", name: "Hà Nam"},
      %{id: "215", name: "Thái Nguyên"},
      %{id: "107", name: "Hải Dương"},
      %{id: "823", name: "Cà Mau"},
      %{id: "805", name: "An Giang"},
      %{id: "705", name: "Ninh Thuận"},
      %{id: "821", name: "Bạc Liêu"},
      %{id: "803", name: "Đồng Tháp"},
      %{id: "817", name: "Trà Vinh"},
      %{id: "607", name: "Lâm Đồng"},
      %{id: "715", name: "Bình Thuận"},
      %{id: "807", name: "Tiền Giang"},
      %{id: "606", name: "Đắk Nông"},
      %{id: "507", name: "Bình Định"},
      %{id: "816", name: "Hậu Giang"},
      %{id: "707", name: "Bình Phước"},
      %{id: "809", name: "Vĩnh Long"},
      %{id: "505", name: "Quảng Ngãi"},
      %{id: "819", name: "Sóc Trăng"},
      %{id: "811", name: "Bến Tre"},
      %{id: "101", name: "Hà Nội"},
      %{id: "717", name: "Bà Rịa-Vũng Tàu"},
      %{id: "701", name: "Hồ Chí Minh"},
      %{id: "225", name: "Quảng Ninh"},
      %{id: "813", name: "Kiên Giang"},
      %{id: "511", name: "Khánh Hòa"},
      %{id: "603", name: "Gia Lai"},
      %{id: "713", name: "Đồng Nai"},
      %{id: "501", name: "Đà Nẵng"},
      %{id: "711", name: "Bình Dương"},
      %{id: "709", name: "Tây Ninh"},
      %{id: "104", name: "Vĩnh Phúc"},
      %{id: "103", name: "Hải Phòng"},
      %{id: "407", name: "Quảng Bình"},
      %{id: "403", name: "Nghệ An"},
      %{id: "601", name: "Kon Tum"},
      %{id: "115", name: "Thái Bình"},
      %{id: "217", name: "Phú Thọ"},
      %{id: "113", name: "Nam Định"},
      %{id: "509", name: "Phú Yên"},
      %{id: "209", name: "Lạng Sơn"},
      %{id: "401", name: "Thanh Hóa"},
      %{id: "117", name: "Ninh Bình"},
      %{id: "801", name: "Long An"},
      %{id: "815", name: "Cần Thơ"},
      %{id: "411", name: "Thừa Thiên Huế"},
      %{id: "503", name: "Quảng Nam"}
    ]
    partners = [%{id: 5, name: "GHN"}, %{id: 16, name: "Best Inc"}, %{id: 19, name: "NJV"}]
    list = File.read!("./dump") |> :erlang.binary_to_term()
    Benchee.run(
      %{
      #   "old" => fn ->
      #     Enum.reduce(list, [], fn item, acc ->
      #       item = Map.merge(item, %{province_name: Enum.find(provinces, & &1.id == item.to_province_id).name, partner_name: Enum.find(partners, & &1.id == item.partner_id).name})
      #       province_idx = Enum.find_index(acc, & &1[:province_id] === item.to_province_id)

      #       if province_idx do
      #         province = Enum.at(acc, province_idx)
      #         district_idx = Enum.find_index(province.districts, & &1[:district_name] === item.district_name)

      #         if district_idx do
      #           district = Enum.at(province.districts, district_idx)
      #           districts = List.update_at(province.districts, district_idx, &(&1 = Map.merge(&1, %{partners: district.partners ++ [item]})))
      #           List.update_at(acc, province_idx, &(&1 = Map.merge(province, %{districts: districts})))
      #         else
      #           List.update_at(acc, province_idx, &(Map.merge(&1, %{districts: province.districts ++ [%{district_name: item.district_name, partners: [item]}]})))
      #         end
      #       else
      #         acc ++ [%{province_id: item.to_province_id, districts: [%{district_name: item.district_name, partners: [item]}]}]
      #       end
      #     end)
      #   end,
      #   "new" => fn ->
      #     Enum.reduce(list, [], fn item, acc ->
      #       item = Map.merge(item, %{province_name: Enum.find(provinces, & &1.id == item.to_province_id).name, partner_name: Enum.find(partners, & &1.id == item.partner_id).name})
      #       province_idx = Enum.find_index(acc, & &1[:province_id] === item.to_province_id)

      #       if province_idx do
      #         province = Enum.at(acc, province_idx)
      #         district_idx = Enum.find_index(province.districts, & &1[:district_name] === item.district_name)

      #         if district_idx do
      #           district = Enum.at(province.districts, district_idx)
      #           # districts = List.update_at(province.districts, district_idx, &Map.merge(&1, %{partners: district.partners ++ [item]}))
      #           new_partners = district.partners ++ [item]
      #           put_in(acc, [Access.at(province_idx), :districts, Access.at(district_idx), :partners], new_partners)
      #           # List.update_at(acc, province_idx, &Map.merge(&1, %{districts: districts}))
      #         else
      #           new_district = province.districts ++ [%{district_name: item.district_name, partners: [item]}]
      #           put_in(acc, [Access.at(province_idx), :districts], new_district)
      #           # List.update_at(acc, province_idx, &(Map.merge(&1, %{districts: province.districts ++ [%{district_name: item.district_name, partners: [item]}]})))
      #         end
      #       else
      #         acc ++ [%{province_id: item.to_province_id, districts: [%{district_name: item.district_name, partners: [item]}]}]
      #       end
      #     end)
      #   end
        "test" => fn -> Process.sleep(500) end,
      },
      time: 10,
      memory_time: 5
    )
  end
end

defmodule A do
  def test do
    provinces = [
      %{id: "203", name: "Cao Bằng"},
      %{id: "207", name: "Bắc Kạn"},
      %{id: "301", name: "Lai Châu"},
      %{id: "405", name: "Hà Tĩnh"},
      %{id: "305", name: "Hòa Bình"},
      %{id: "221", name: "Bắc Giang"},
      %{id: "302", name: "Điện Biên"},
      %{id: "201", name: "Hà Giang"},
      %{id: "605", name: "Đắk Lắk"},
      %{id: "106", name: "Bắc Ninh"},
      %{id: "303", name: "Sơn La"},
      %{id: "211", name: "Tuyên Quang"},
      %{id: "409", name: "Quảng Trị"},
      %{id: "205", name: "Lào Cai"},
      %{id: "213", name: "Yên Bái"},
      %{id: "109", name: "Hưng Yên"},
      %{id: "111", name: "Hà Nam"},
      %{id: "215", name: "Thái Nguyên"},
      %{id: "107", name: "Hải Dương"},
      %{id: "823", name: "Cà Mau"},
      %{id: "805", name: "An Giang"},
      %{id: "705", name: "Ninh Thuận"},
      %{id: "821", name: "Bạc Liêu"},
      %{id: "803", name: "Đồng Tháp"},
      %{id: "817", name: "Trà Vinh"},
      %{id: "607", name: "Lâm Đồng"},
      %{id: "715", name: "Bình Thuận"},
      %{id: "807", name: "Tiền Giang"},
      %{id: "606", name: "Đắk Nông"},
      %{id: "507", name: "Bình Định"},
      %{id: "816", name: "Hậu Giang"},
      %{id: "707", name: "Bình Phước"},
      %{id: "809", name: "Vĩnh Long"},
      %{id: "505", name: "Quảng Ngãi"},
      %{id: "819", name: "Sóc Trăng"},
      %{id: "811", name: "Bến Tre"},
      %{id: "101", name: "Hà Nội"},
      %{id: "717", name: "Bà Rịa-Vũng Tàu"},
      %{id: "701", name: "Hồ Chí Minh"},
      %{id: "225", name: "Quảng Ninh"},
      %{id: "813", name: "Kiên Giang"},
      %{id: "511", name: "Khánh Hòa"},
      %{id: "603", name: "Gia Lai"},
      %{id: "713", name: "Đồng Nai"},
      %{id: "501", name: "Đà Nẵng"},
      %{id: "711", name: "Bình Dương"},
      %{id: "709", name: "Tây Ninh"},
      %{id: "104", name: "Vĩnh Phúc"},
      %{id: "103", name: "Hải Phòng"},
      %{id: "407", name: "Quảng Bình"},
      %{id: "403", name: "Nghệ An"},
      %{id: "601", name: "Kon Tum"},
      %{id: "115", name: "Thái Bình"},
      %{id: "217", name: "Phú Thọ"},
      %{id: "113", name: "Nam Định"},
      %{id: "509", name: "Phú Yên"},
      %{id: "209", name: "Lạng Sơn"},
      %{id: "401", name: "Thanh Hóa"},
      %{id: "117", name: "Ninh Bình"},
      %{id: "801", name: "Long An"},
      %{id: "815", name: "Cần Thơ"},
      %{id: "411", name: "Thừa Thiên Huế"},
      %{id: "503", name: "Quảng Nam"}
    ]
    partners = [%{id: 5, name: "GHN"}, %{id: 16, name: "Best Inc"}, %{id: 19, name: "NJV"}]
    list = File.read!("./dump") |> :erlang.binary_to_term()

    {duration, result} = :timer.tc(fn ->
      Enum.reduce(list, [], fn item, acc ->
        item = Map.merge(item, %{province_name: Enum.find(provinces, & &1.id == item.to_province_id).name, partner_name: Enum.find(partners, & &1.id == item.partner_id).name})
        province_idx = Enum.find_index(acc, & &1[:province_id] === item.to_province_id)

        if province_idx do
          province = Enum.at(acc, province_idx)
          district_idx = Enum.find_index(province.districts, & &1[:district_name] === item.district_name)

          if district_idx do
            district = Enum.at(province.districts, district_idx)
            districts = List.update_at(province.districts, district_idx, &(&1 = Map.merge(&1, %{partners: district.partners ++ [item]})))
            List.update_at(acc, province_idx, &(&1 = Map.merge(province, %{districts: districts})))
          else
            List.update_at(acc, province_idx, &(Map.merge(&1, %{districts: province.districts ++ [%{district_name: item.district_name, partners: [item]}]})))
          end
        else
          acc ++ [%{province_id: item.to_province_id, districts: [%{district_name: item.district_name, partners: [item]}]}]
        end
      end)
    end)

    IO.inspect(duration / 1000, label: "duration")
    result
  end
end
