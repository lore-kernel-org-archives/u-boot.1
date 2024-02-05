Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACFCC4828D
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:48:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0812877CB;
	Mon,  5 Feb 2024 14:48:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QzQb5eYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C32D87811; Mon,  5 Feb 2024 14:48:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8228F875E9
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 14:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4887=JP=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1707140900;
 bh=hkBsChCxsHcx5igdYwO+0KqgL2YPPNToi3XNQsTkYkk=;
 b=QzQb5eYfSgOmIwyGvYl0Ti1PKaOk0eaNdKwzr6WnxbPwangeFjceYwIkOnYWp9SLzTNvhDmEt
 XCgzDaBO22ysmYFfY8Gxu0tEsOmhkittKXW4+vpnkSZbu4ihdpSzNI7pHGJuzyoQ3Hvgtoxk02D
 O87YpJsN1oQbJICNonckUWLxIz1Q/c/hJAbr1MHAjWg6JJwlxqwZL4RkVBKVmkNkqCvBIRfgBrS
 mEA2D5iqSRoRLv7f5zn0yIBvdpOIoInw1JULzdAY4JYidmlrtP1cKQAvyvdYlIH96tUmaDUOAik
 6u7DwaoWZZnmRgfuvjZVi1escpY/ur6+TYDWNJtZkUSw==
Message-ID: <dbb4c191-b936-479b-a764-1d08a14a5735@kwiboo.se>
Date: Mon, 5 Feb 2024 14:48:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: rockchip: Add Pine64 PineTab2
Content-Language: en-US
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc: u-boot@lists.denx.de
References: <20240204173040.2293613-1-jonas@kwiboo.se>
 <c605e3eb-6c56-4a21-8505-2b416cebe484@rock-chips.com>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <c605e3eb-6c56-4a21-8505-2b416cebe484@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 65c0e723a7f28028f81d048d
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Kever,

On 2024-02-05 08:04, Kever Yang wrote:
> Hi Jonas,
> 
> On 2024/2/5 01:30, Jonas Karlman wrote:
>> The Pine64 PineTab2 is a tablet computer based on the Rockchip RK3566
>> SoC. The table features 4/8 GB LPDDR4 RAM and 64/128 GB eMMC storage.
>>
>> Features tested on a Pine64 PineTab2 8GB v2.0:
>> - SD-card boot
>> - eMMC boot
>> - SPI Flash boot
>> - USB host
>>
>> Device tree is imported from linux maintainer branch v6.9-armsoc/dts64,
>> commit 1b7e19448f8f ("arm64: dts: rockchip: Add devicetree for Pine64
>> PineTab2").
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> This patch depend on the series "rockchip: rk35xx: Sync device tree with
>> linux v6.8-rc1" [1].
>>
>> [1] https://patchwork.ozlabs.org/cover/1891669/
>> ---
>>   arch/arm/dts/Makefile                         |   2 +
>>   arch/arm/dts/rk3566-pinetab2-u-boot.dtsi      |  44 +
>>   arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi |   3 +
>>   arch/arm/dts/rk3566-pinetab2-v0.1.dts         |  28 +
> 
> Does this v0.1 version dts really needed? This seems like a test version 
> instead of release version hardware?

The initial v0.1 was sent out to community developers and v2.0 is the
production version sold, so both versions exists in the wild.

In current state they could probably share a single DT for U-Boot usage
but in future if panel support is added to U-Boot the two versions does
differ a little bit.

Was safer to just include both device trees.

Regards,
Jonas

> 
> 
> Thanks,
> 
> - Kever
> 
>>   arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi |   3 +
>>   arch/arm/dts/rk3566-pinetab2-v2.0.dts         |  48 +
>>   arch/arm/dts/rk3566-pinetab2.dtsi             | 943 ++++++++++++++++++
>>   board/pine64/quartz64_rk3566/MAINTAINERS      |  11 +
>>   configs/pinetab2-rk3566_defconfig             | 119 +++
>>   doc/board/rockchip/rockchip.rst               |   1 +
>>   10 files changed, 1202 insertions(+)
>>   create mode 100644 arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/rk3566-pinetab2-v0.1.dts
>>   create mode 100644 arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi
>>   create mode 100644 arch/arm/dts/rk3566-pinetab2-v2.0.dts
>>   create mode 100644 arch/arm/dts/rk3566-pinetab2.dtsi
>>   create mode 100644 configs/pinetab2-rk3566_defconfig
>>
>> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
>> index 50f35e3db3f0..825fa1cd368a 100644
>> --- a/arch/arm/dts/Makefile
>> +++ b/arch/arm/dts/Makefile
>> @@ -173,6 +173,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3399) += \
>>   
>>   dtb-$(CONFIG_ROCKCHIP_RK3568) += \
>>   	rk3566-anbernic-rgxx3.dtb \
>> +	rk3566-pinetab2-v0.1.dtb \
>> +	rk3566-pinetab2-v2.0.dtb \
>>   	rk3566-quartz64-a.dtb \
>>   	rk3566-quartz64-b.dtb \
>>   	rk3566-radxa-cm3-io.dtb \
>> diff --git a/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi b/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..4aa6ab1c848c
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi
>> @@ -0,0 +1,44 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +#include "rk356x-u-boot.dtsi"
>> +
>> +&fspi_dual_io_pins {
>> +	bootph-all;
>> +};
>> +
>> +&gpio0 {
>> +	bootph-all;
>> +};
>> +
>> +&i2c0 {
>> +	bootph-pre-ram;
>> +};
>> +
>> +&rk817 {
>> +	bootph-pre-ram;
>> +
>> +	regulators {
>> +		bootph-pre-ram;
>> +	};
>> +};
>> +
>> +&sdhci {
>> +	cap-mmc-highspeed;
>> +};
>> +
>> +&sdmmc_pwren_l {
>> +	bootph-all;
>> +};
>> +
>> +&sfc {
>> +	bootph-pre-ram;
>> +	u-boot,spl-sfc-no-dma;
>> +
>> +	flash@0 {
>> +		bootph-pre-ram;
>> +	};
>> +};
>> +
>> +&vcc3v3_sd {
>> +	bootph-pre-ram;
>> +};
>> diff --git a/arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi b/arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..061dc3c2c375
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3566-pinetab2-v0.1-u-boot.dtsi
>> @@ -0,0 +1,3 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +#include "rk3566-pinetab2-u-boot.dtsi"
>> diff --git a/arch/arm/dts/rk3566-pinetab2-v0.1.dts b/arch/arm/dts/rk3566-pinetab2-v0.1.dts
>> new file mode 100644
>> index 000000000000..5fe6ca5da9d3
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3566-pinetab2-v0.1.dts
>> @@ -0,0 +1,28 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/dts-v1/;
>> +
>> +#include "rk3566-pinetab2.dtsi"
>> +
>> +/ {
>> +	model = "Pine64 PineTab2 v0.1";
>> +	compatible = "pine64,pinetab2-v0.1", "pine64,pinetab2", "rockchip,rk3566";
>> +};
>> +
>> +&lcd {
>> +	reset-gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&lcd_pwren_h &lcd0_rst_l>;
>> +};
>> +
>> +&pinctrl {
>> +	lcd0 {
>> +		lcd0_rst_l: lcd0-rst-l {
>> +			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +};
>> +
>> +&sdmmc1 {
>> +	vmmc-supply = <&vcc3v3_sys>;
>> +};
>> diff --git a/arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi b/arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..061dc3c2c375
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3566-pinetab2-v2.0-u-boot.dtsi
>> @@ -0,0 +1,3 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +#include "rk3566-pinetab2-u-boot.dtsi"
>> diff --git a/arch/arm/dts/rk3566-pinetab2-v2.0.dts b/arch/arm/dts/rk3566-pinetab2-v2.0.dts
>> new file mode 100644
>> index 000000000000..9349541cbbd0
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3566-pinetab2-v2.0.dts
>> @@ -0,0 +1,48 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +/dts-v1/;
>> +
>> +#include "rk3566-pinetab2.dtsi"
>> +
>> +/ {
>> +	model = "Pine64 PineTab2 v2.0";
>> +	compatible = "pine64,pinetab2-v2.0", "pine64,pinetab2", "rockchip,rk3566";
>> +};
>> +
>> +&gpio_keys {
>> +	pinctrl-0 = <&kb_id_det>, <&hall_int_l>;
>> +
>> +	event-hall-sensor {
>> +		debounce-interval = <20>;
>> +		gpios = <&gpio0 RK_PA6 GPIO_ACTIVE_LOW>;
>> +		label = "Hall Sensor";
>> +		linux,code = <SW_LID>;
>> +		linux,input-type = <EV_SW>;
>> +		wakeup-event-action = <EV_ACT_DEASSERTED>;
>> +		wakeup-source;
>> +	};
>> +};
>> +
>> +&lcd {
>> +	reset-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_LOW>;
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&lcd_pwren_h &lcd0_rst_l>;
>> +};
>> +
>> +&pinctrl {
>> +	lcd0 {
>> +		lcd0_rst_l: lcd0-rst-l {
>> +			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +
>> +	hall {
>> +		hall_int_l: hall-int-l {
>> +			rockchip,pins = <0 RK_PA6 RK_FUNC_GPIO &pcfg_pull_none>;
>> +		};
>> +	};
>> +};
>> +
>> +&sdmmc1 {
>> +	vmmc-supply = <&vcc_sys>;
>> +};

[snip]
