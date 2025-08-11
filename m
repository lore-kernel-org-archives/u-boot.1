Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D00FCA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 21:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51D3C831E0;
	Mon, 11 Aug 2025 23:17:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vxcvugKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80AEE831E1; Mon, 11 Aug 2025 23:17:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B76EE831D8
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 23:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=cf87=2Y=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1754947066;
 bh=XSrzY+5f19gnmkzKsjF0QqoC+t3ikmMmfHqYZHvhYfg=;
 b=vxcvugKdWDV0lCpNEqkPu29vSgVWs1egl11tYAqW350Qnm+WlzvYXS4C7sU1ZUz8EymgEr7Rb
 ZitcAdl2P7eCxuDgyoSRXEyV9fDnnYll0Gq5pOo21jsDYsqm1ZtPv1+LfsMPXnTOIIIiyZnSNZT
 QhWI+XkUjPH63oX3evTYWZvXMGWqSpG2NxG2lFlugf2KRQZTm611VeqEYqKiqmJlYD+UhNjr/rV
 8CbABWKdXhi737rr4QyyfwM4K7SnLOXkOF6QtL+DtSntN3/7v+yLu9JgUAKAmfTZd4GIKdssuEp
 NIqy3dNwc3gsOCCyBkkVHD/G8uu8fdluClwkcUws58Jg==
X-Forward-Email-ID: 689a5dd1de615f3104e06c9e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.2.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <8dfbfa29-839b-4067-b4ba-62ee3ce60f78@kwiboo.se>
Date: Mon, 11 Aug 2025 23:17:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: rock5b-rk3588: Add support for ROCK 5B+
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250801170933.2530191-1-jonas@kwiboo.se>
 <20250801170933.2530191-3-jonas@kwiboo.se>
 <d236a958-8605-4ad7-85f5-6cc03048f8b0@cherry.de>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <d236a958-8605-4ad7-85f5-6cc03048f8b0@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Quentin,

On 8/11/2025 11:24 AM, Quentin Schulz wrote:
> Hi Jonas,
> 
> On 8/1/25 7:09 PM, Jonas Karlman wrote:
>> Include FDTs for both ROCK 5B and 5B+ in the FIT and add board selection
>> code to load the 5B+ FDT when the DRAM type is LPDDR5 and ADC channel 5
>> value is close to 4095.
>>
>>    U-Boot 2025.07 (Jul 14 2025 - 21:28:20 +0000)
>>
>>    Model: Radxa ROCK 5B+
>>    SoC:   RK3588
>>    DRAM:  8 GiB
>>
>> Features tested on a ROCK 5B+ v1.2:
>> - SD-card boot
>> - eMMC boot
>> - SPI flash boot
>> - PCIe/NVMe
>> - Ethernet
>> - USB/TCPM
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> Changes in v2:
>> - Add DRAM type check in addition to SARADC check
>> ---
>>   arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi |  3 +
>>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      |  5 ++
>>   board/radxa/rock5b-rk3588/Kconfig            |  5 ++
>>   board/radxa/rock5b-rk3588/MAINTAINERS        |  3 +-
>>   board/radxa/rock5b-rk3588/rock5b-rk3588.c    | 63 ++++++++++++++++++++
>>   configs/rock5b-rk3588_defconfig              |  1 +
>>   doc/board/rockchip/rockchip.rst              |  2 +-
>>   7 files changed, 79 insertions(+), 3 deletions(-)
>>   create mode 100644 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
>>
>> diff --git a/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
>> new file mode 100644
>> index 000000000000..c07696c83913
>> --- /dev/null
>> +++ b/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
>> @@ -0,0 +1,3 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +
>> +#include "rk3588-rock-5b-u-boot.dtsi"
>> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
>> index d51fbf51cb88..e07b549c767f 100644
>> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
>> @@ -46,6 +46,11 @@
>>   	};
>>   };
>>   
>> +&saradc {
>> +	bootph-pre-ram;
>> +	vdd-microvolts = <1800000>;
>> +};
>> +
>>   &sdhci {
>>   	cap-mmc-highspeed;
>>   	mmc-hs200-1_8v;
>> diff --git a/board/radxa/rock5b-rk3588/Kconfig b/board/radxa/rock5b-rk3588/Kconfig
>> index 41dfe2402b12..98d630117836 100644
>> --- a/board/radxa/rock5b-rk3588/Kconfig
>> +++ b/board/radxa/rock5b-rk3588/Kconfig
>> @@ -9,4 +9,9 @@ config SYS_VENDOR
>>   config SYS_CONFIG_NAME
>>   	default "rock5b-rk3588"
>>   
>> +config BOARD_SPECIFIC_OPTIONS # dummy
>> +	def_bool y
>> +	select ADC
>> +	select SPL_ADC
>> +
>>   endif
>> diff --git a/board/radxa/rock5b-rk3588/MAINTAINERS b/board/radxa/rock5b-rk3588/MAINTAINERS
>> index 4460c9971a96..c8a43769105e 100644
>> --- a/board/radxa/rock5b-rk3588/MAINTAINERS
>> +++ b/board/radxa/rock5b-rk3588/MAINTAINERS
>> @@ -5,5 +5,4 @@ S:	Maintained
>>   F:	board/radxa/rock5b-rk3588
>>   F:	include/configs/rock5b-rk3588.h
>>   F:	configs/rock5b-rk3588_defconfig
>> -F:	arch/arm/dts/rk3588-rock-5b.dts
>> -F:	arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
>> +F:	arch/arm/dts/rk3588-rock-5b*
>> diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
>> index fc2f69db2241..6bf4497ce3ae 100644
>> --- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
>> +++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
>> @@ -3,8 +3,71 @@
>>    * Copyright (c) 2023-2024 Collabora Ltd.
>>    */
>>   
>> +#include <adc.h>
>> +#include <env.h>
>>   #include <fdtdec.h>
>>   #include <fdt_support.h>
>> +#include <asm/arch-rockchip/sdram.h>
>> +#include <linux/errno.h>
>> +
>> +#define PMU1GRF_BASE		0xfd58a000
>> +#define OS_REG2_REG		0x208
>> +
> 
> I assume the register address and meaning is stable across all RK3588, 
> so maybe we should abstract that somewhere in the SoC file 
> (arch/arm/mach-rockchip/rk3588) so that the caller doesn't need to 
> specify them?

Correct, these are stable for the SoC and could be defined in soc
related header and is something I have very slowly been working on in my
optimize branch at [1] for a future series.

Right now we have some code using syscon_get_first_range() to get a base
addr from DT, and newer code that instead use a define. See e.g.
sdram_rk3588.c vs sdram_rk3576.c, getting the base from DT adds several
ms delay and something that seem pointless when we know the stable addr
at compile time.

So for now I just kept this here with the expectation that this should
be changed in a future series.

[1] https://source.denx.de/u-boot/contributors/kwiboo/u-boot/-/commit/3a11ab7fba8db133374e60edf8ab2b46195cf684

> 
>> +#define HW_ID_CHANNEL		5
>> +
>> +struct board_model {
>> +	unsigned int dram;
>> +	unsigned int low;
>> +	unsigned int high;
>> +	const char *fdtfile;
>> +};
>> +
>> +static const struct board_model board_models[] = {
>> +	{ LPDDR5, 4005, 4185, "rockchip/rk3588-rock-5b-plus.dtb" },
>> +};
>> +
>> +static const struct board_model *get_board_model(void)
>> +{
>> +	unsigned int val, dram_type;
>> +	int i, ret;
> 
> i could be an unsigned number type as well. (and it should since we're 
> using it to access items in an array)

Sure, will change in v3.

> 
>> +
>> +	dram_type = rockchip_sdram_type(PMU1GRF_BASE + OS_REG2_REG);
>> +
>> +	ret = adc_channel_single_shot("adc@fec10000", HW_ID_CHANNEL, &val);
>> +	if (ret)
>> +		return NULL;
>> +
> 
> While checking whether adc_channel_single_shot() is the right function 
> to call, I stumbled upon the call in arch/arm/mach-rockchip/boot_mode.c 
> which i believe wouldn't work for Rockchip SoCs whose DTSI uses adc@ as 
> node name instead of saradc@. That would be rk3328, rk3588, rk3576, 
> rk3528 and rv1126.

Correct, the saradc@ in boot_mode.c is typically used for "recovery" or
"maskrom" detection. However, this uses a hardcoded saradc channel that
may not necessarily be used for that purpose, especially on newer SoCs.

I suggest we do not try to change that to cover more SoCs without first
adding a way to define what channel to use for the button detection,
possible in a /config or a Kconfig option.

> 
> I guess there are different ways to fix this. We could have each SoC 
> define a constant string with the node name of the SARADC or have an 
> additional entry in /aliases for saradc in the DT? Maybe some other way 
> could be used as well, just throwing ideas :)
> 
> Unrelated to this patch though, so feel free to ignore.

As noted above, I think it is something to fix/consider but it may have
unintended consequences to blindly try and fix boot_mode.c for all RK
SoCs without having some sort of board option to specify when and how
the feature should be used.

Regards,
Jonas

> 
> Cheers,
> Quentin

