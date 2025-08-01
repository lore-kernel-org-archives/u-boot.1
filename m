Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C651C87FCB
	for <u-boot@archiver.kernel.org>; Fri,  1 Aug 2025 07:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72F848380F;
	Fri,  1 Aug 2025 09:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="TjN0Uxz5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9587B838F8; Fri,  1 Aug 2025 09:53:57 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FCF583807
 for <u-boot@lists.denx.de>; Fri,  1 Aug 2025 09:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ab54=2N=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1754034833;
 bh=NTKxqDjhshEzdNbk7dAnJSq2QxD3QxvgVgf4gbTKJIo=;
 b=TjN0Uxz55JvxNsGPGYST8GTdpqlzj17nJ5miGvaQNfPGCGzdxAtZln72j4SgKzsnnQTU8CO8T
 08ZhehXo+ajrCQ2a88gekOQ6YWXmni+ynFabgYHSmPlir94GXRV4t8ZagQGU7zI83O4v4B+KF0Y
 7jKm10tCUEUONK8RcOJBZM2kri00iARNW6FO3XgZH9J4ghxLDtwXDjW/w3UXZevy8SyTLT2L60O
 L0t4YdXr+uQyrQMBIvQC4aXN/ZxeFvf4QmsTz4ABKl+GNeYVZYOA//8I+ioz9E1eSUBUAPacZ/8
 dI+WXM+uxzXOCXKTsemi9+rRRIaerKvLiNOZn2VQNRww==
X-Forward-Email-ID: 688c728c264f6a311d1d9853
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.8
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <b050a379-b223-4fa9-b55f-35a0df4fa3f1@kwiboo.se>
Date: Fri, 1 Aug 2025 09:53:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] rockchip: rock5b-rk3588: Add support for ROCK 5B+
To: FUKAUMI Naoki <naoki@radxa.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Eugen Hristev <eugen.hristev@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20250714223410.1836893-1-jonas@kwiboo.se>
 <20250714223410.1836893-5-jonas@kwiboo.se>
 <e46mypj2zn7ggff7ivef3k7ejqnc6swng6tfi2cymlipcak6fc@6n43szvkzzvf>
 <7c172335-4ad6-4503-bc40-c56301970813@kwiboo.se>
 <6541E7A84A511123+8bfb6b8b-e42a-475f-a145-8e09e54c9c49@radxa.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <6541E7A84A511123+8bfb6b8b-e42a-475f-a145-8e09e54c9c49@radxa.com>
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

Hi,

On 8/1/2025 8:28 AM, FUKAUMI Naoki wrote:
> Hi Jonas,
> 
> On 7/16/25 03:26, Jonas Karlman wrote:
>> Hi Sebastian,
>>
>> On 7/15/2025 6:48 PM, Sebastian Reichel wrote:
>>> Hello Jonas,
>>>
>>> On Mon, Jul 14, 2025 at 10:34:01PM +0000, Jonas Karlman wrote:
>>>> Include FDTs for both ROCK 5B and 5B+ in the FIT and add board
>>>> selection code to load the 5B+ FDT when the ADC channel 5 value is
>>>> close to 4095.
>>>
>>> The Rock 5B uses the same channel and starts with 0V for revision A
>>> and jumps in 0.3V steps for newer revisions. So technically a Rock
>>> 5B revision H would be detected as Rock 5B+ with this code. IDK if
>>> Radxa will ever release such a board. But I have an alternative
>>> implementation, which does the board detection via the DDR memory
>>> type (Rock 5B = LPDDR4, Rock 5B+ = LPDDR5):
>>
>> Radxa's U-Boot has following table of SARADC values, something that seem
>> to match for the board model and revisions I have access to.
>>
>> static struct variant_def variants[] = {
>> 	{"rockchip,rk3588", 300, 380, "rockchip/rk3588s-radxa-e54c.dtb"},
>> 	{"rockchip,rk3588", 980, 1060, "rockchip/rk3588-rock-5t.dtb"},
>> 	{"rockchip,rk3588", 1650, 1730, "rockchip/rk3588s-radxa-e52c.dtb"},
>> 	{"rockchip,rk3588", 2360, 2440, "rockchip/rk3588s-rock-5c.dtb"},
>> 	{"rockchip,rk3588", 3370, 3450, "rockchip/rk3588s-rock-5d.dtb"},
>> 	{"rockchip,rk3588", 4050, 4130, "rockchip/rk3588-rock-5b-plus.dtb"},
>> };
>>
>> My Radxa rk358x boards report following for SARADC ch5:
>> - ROCK 5B+ (no emmc): 4073, 1790329 uV
>> - ROCK 5B+ (with emmc): 4075, 1791208 uV
>> - ROCK 5B v1.42:  854, 375384 uV
>> - ROCK 5B v1.42: 1100, 483516 uV
>> - ROCK 5B v1.45: 1211, 532307 uV
>> - ROCK 5B v1.46: 2109, 927032 uV
>> - ROCK 5A v1.1: 682, 299780 uV
>> - ROCK 5A v1.2: 685, 301098 uV
>> - ROCK 5C v1.1: 2402, 1055824 uV
>> - ROCK 5C Lite v1.1: 2402, 1055824 uV
>> - E52C v1.2: 1692, 743736 uV
>> - E54C v1.2: 340, 149450 uV
>>
>> So Radxa's table seem to match values reported by my boards/models.
>>
>> Maybe the ROCK 5B is a little bit more flaky in reading out the ADC
>> value and matching using some different way could improve board accuracy.
> 
> SARADC_IN5 is not connected on ROCK 5B, so do not use it to identify the 
> board.

Thanks for confirming this, will use DRAM type matching in addition to
SARADC for v2.

static const struct board_model board_models[] = {
	{ LPDDR5, 4005, 4185, "rockchip/rk3588-rock-5b-plus.dtb" },
};

I am also expecting addition of 5T and ITX to the table should work.

Will run a final test and send out v2 later today.

Regards,
Jonas

> 
> Best regards,
> 
> --
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
>>>
>>> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot/-/commit/9803234dbb014a8fa4b495aa8f95bdc710d88380
>>
>> rockchip_sdram_size() and asm/arch-rockchip/sdram.h already contains
>> code and defines for these regs, so should probably be re-used instead
>> of re-inventing how the DRAM type is read from OS reg if we go with DRAM
>> type matching ;-)
>>
>>>
>>> Considering that the different memory is something Radxa explicitly
>>> promotes as board difference between 5B and 5B+ it seems like a
>>> better approach to me.
>>
>> My main concern with using DRAM type matching is that it may limit what
>> models can be supported by a single defconfig.
>>
>>> Note I only haven't send this yet, since I
>>> was waiting for the Rock 5B+ DT to land in the upstream kernel. But
>>
>> Sorry, I have not looked at your downstream tree for some time ;-)
>>
>> Btw, you can probably drop my "HACK: mkimage: fit: Keep data that should
>> be loaded into SRAM embedded" from your tree, it should not be needed
>> since long time now that PIO mode typically is used instead of DMA for
>> TF-A loading.
>>
>>> I'm totally happy for you to take care of this :)
>>
>> I can probably extend the check to include DRAM type testing for a v2,
>> should probably make board model matching as safe as it can be.
>>
>> Regards,
>> Jonas
>>
>>>
>>> Greetings,
>>>
>>> -- Sebastian
>>>
>>>>
>>>>    U-Boot 2025.07 (Jul 14 2025 - 21:28:20 +0000)
>>>>
>>>>    Model: Radxa ROCK 5B+
>>>>    SoC:   RK3588
>>>>    DRAM:  8 GiB
>>>>
>>>> Features tested on a ROCK 5B+ v1.2:
>>>> - SD-card boot
>>>> - eMMC boot
>>>> - SPI flash boot
>>>> - PCIe/NVMe
>>>> - Ethernet
>>>> - USB/TCPM
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>   arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi |  3 ++
>>>>   arch/arm/dts/rk3588-rock-5b-u-boot.dtsi      |  5 ++
>>>>   board/radxa/rock5b-rk3588/Kconfig            |  5 ++
>>>>   board/radxa/rock5b-rk3588/MAINTAINERS        |  3 +-
>>>>   board/radxa/rock5b-rk3588/rock5b-rk3588.c    | 55 ++++++++++++++++++++
>>>>   configs/rock5b-rk3588_defconfig              |  1 +
>>>>   doc/board/rockchip/rockchip.rst              |  2 +-
>>>>   7 files changed, 71 insertions(+), 3 deletions(-)
>>>>   create mode 100644 arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
>>>>
>>>> diff --git a/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
>>>> new file mode 100644
>>>> index 000000000000..c07696c83913
>>>> --- /dev/null
>>>> +++ b/arch/arm/dts/rk3588-rock-5b-plus-u-boot.dtsi
>>>> @@ -0,0 +1,3 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +
>>>> +#include "rk3588-rock-5b-u-boot.dtsi"
>>>> diff --git a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
>>>> index d51fbf51cb88..e07b549c767f 100644
>>>> --- a/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
>>>> +++ b/arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
>>>> @@ -46,6 +46,11 @@
>>>>   	};
>>>>   };
>>>>   
>>>> +&saradc {
>>>> +	bootph-pre-ram;
>>>> +	vdd-microvolts = <1800000>;
>>>> +};
>>>> +
>>>>   &sdhci {
>>>>   	cap-mmc-highspeed;
>>>>   	mmc-hs200-1_8v;
>>>> diff --git a/board/radxa/rock5b-rk3588/Kconfig b/board/radxa/rock5b-rk3588/Kconfig
>>>> index 41dfe2402b12..98d630117836 100644
>>>> --- a/board/radxa/rock5b-rk3588/Kconfig
>>>> +++ b/board/radxa/rock5b-rk3588/Kconfig
>>>> @@ -9,4 +9,9 @@ config SYS_VENDOR
>>>>   config SYS_CONFIG_NAME
>>>>   	default "rock5b-rk3588"
>>>>   
>>>> +config BOARD_SPECIFIC_OPTIONS # dummy
>>>> +	def_bool y
>>>> +	select ADC
>>>> +	select SPL_ADC
>>>> +
>>>>   endif
>>>> diff --git a/board/radxa/rock5b-rk3588/MAINTAINERS b/board/radxa/rock5b-rk3588/MAINTAINERS
>>>> index 4460c9971a96..c8a43769105e 100644
>>>> --- a/board/radxa/rock5b-rk3588/MAINTAINERS
>>>> +++ b/board/radxa/rock5b-rk3588/MAINTAINERS
>>>> @@ -5,5 +5,4 @@ S:	Maintained
>>>>   F:	board/radxa/rock5b-rk3588
>>>>   F:	include/configs/rock5b-rk3588.h
>>>>   F:	configs/rock5b-rk3588_defconfig
>>>> -F:	arch/arm/dts/rk3588-rock-5b.dts
>>>> -F:	arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
>>>> +F:	arch/arm/dts/rk3588-rock-5b*
>>>> diff --git a/board/radxa/rock5b-rk3588/rock5b-rk3588.c b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
>>>> index fc2f69db2241..1443c2c828a1 100644
>>>> --- a/board/radxa/rock5b-rk3588/rock5b-rk3588.c
>>>> +++ b/board/radxa/rock5b-rk3588/rock5b-rk3588.c
>>>> @@ -3,8 +3,63 @@
>>>>    * Copyright (c) 2023-2024 Collabora Ltd.
>>>>    */
>>>>   
>>>> +#include <adc.h>
>>>> +#include <env.h>
>>>>   #include <fdtdec.h>
>>>>   #include <fdt_support.h>
>>>> +#include <linux/errno.h>
>>>> +
>>>> +#define HW_ID_CHANNEL	5
>>>> +
>>>> +struct board_model {
>>>> +	unsigned int low;
>>>> +	unsigned int high;
>>>> +	const char *fdtfile;
>>>> +};
>>>> +
>>>> +static const struct board_model board_models[] = {
>>>> +	{ 4050, 4130, "rockchip/rk3588-rock-5b-plus.dtb" },
>>>> +};
>>>> +
>>>> +static const struct board_model *get_board_model(void)
>>>> +{
>>>> +	unsigned int val;
>>>> +	int i, ret;
>>>> +
>>>> +	ret = adc_channel_single_shot("adc@fec10000", HW_ID_CHANNEL, &val);
>>>> +	if (ret)
>>>> +		return NULL;
>>>> +
>>>> +	for (i = 0; i < ARRAY_SIZE(board_models); i++) {
>>>> +		unsigned int min = board_models[i].low;
>>>> +		unsigned int max = board_models[i].high;
>>>> +
>>>> +		if (min <= val && val <= max)
>>>> +			return &board_models[i];
>>>> +	}
>>>> +
>>>> +	return NULL;
>>>> +}
>>>> +
>>>> +int rk_board_late_init(void)
>>>> +{
>>>> +	const struct board_model *model = get_board_model();
>>>> +
>>>> +	if (model)
>>>> +		env_set("fdtfile", model->fdtfile);
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +int board_fit_config_name_match(const char *name)
>>>> +{
>>>> +	const struct board_model *model = get_board_model();
>>>> +
>>>> +	if (model && !strcmp(name, model->fdtfile))
>>>> +		return 0;
>>>> +
>>>> +	return -EINVAL;
>>>> +}
>>>>   
>>>>   #ifdef CONFIG_OF_BOARD_SETUP
>>>>   int ft_board_setup(void *blob, struct bd_info *bd)
>>>> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
>>>> index 6349e8791456..967cebc2054f 100644
>>>> --- a/configs/rock5b-rk3588_defconfig
>>>> +++ b/configs/rock5b-rk3588_defconfig
>>>> @@ -47,6 +47,7 @@ CONFIG_CMD_REGULATOR=y
>>>>   # CONFIG_SPL_DOS_PARTITION is not set
>>>>   CONFIG_SPL_OF_CONTROL=y
>>>>   CONFIG_OF_LIVE=y
>>>> +CONFIG_OF_LIST="rockchip/rk3588-rock-5b rockchip/rk3588-rock-5b-plus"
>>>>   CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
>>>>   CONFIG_SPL_DM_SEQ_ALIAS=y
>>>>   CONFIG_SPL_REGMAP=y
>>>> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
>>>> index b88299cbba23..7a1385789c20 100644
>>>> --- a/doc/board/rockchip/rockchip.rst
>>>> +++ b/doc/board/rockchip/rockchip.rst
>>>> @@ -152,7 +152,7 @@ List of mainline supported Rockchip boards:
>>>>        - Pine64 QuartzPro64 (quartzpro64-rk3588)
>>>>        - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>>>>        - Radxa ROCK 5A (rock5a-rk3588s)
>>>> -     - Radxa ROCK 5B (rock5b-rk3588)
>>>> +     - Radxa ROCK 5B/5B+ (rock5b-rk3588)
>>>>        - Radxa ROCK 5C (rock-5c-rk3588s)
>>>>        - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
>>>>        - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)
>>>> -- 
>>>> 2.49.0
>>>>
>>
>>
> 

