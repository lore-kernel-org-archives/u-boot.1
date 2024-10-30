Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85260D6B6DD
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 22:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C63E48924F;
	Wed, 30 Oct 2024 23:23:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D3289259; Wed, 30 Oct 2024 23:23:08 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2650088C8F
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 23:23:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip3t1730326946tuyhwfq
X-QQ-Originating-IP: WNA0q7b90XkC2uql+hkQ9cMQfDell0SUQlASBs6UpSU=
Received: from [IPV6:240f:10b:7440:1:888b:2835 ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 31 Oct 2024 06:22:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8487258684284603474
Message-ID: <C69FC67529AFD2FD+b0c7fa4d-e4a2-4117-a320-bc8b1a313afa@radxa.com>
Date: Thu, 31 Oct 2024 07:22:22 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] rockchip: add support for Radxa ROCK 5A with SPI
 NOR flash module
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 eugen.hristev@collabora.com, jonas@kwiboo.se, sumit.garg@linaro.org
References: <20240824223343.98577-1-naoki@radxa.com>
 <20240824223343.98577-2-naoki@radxa.com>
 <A486B5CC87D82BA9+a72f088c-d1ac-442a-86d5-9e1611492000@radxa.com>
 <9cbadcce-3e12-45ba-95f3-a35e29f4dd88@cherry.de>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <9cbadcce-3e12-45ba-95f3-a35e29f4dd88@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MDPfhejMR4aIXkz5sNwqNWIe85NnxQohDPxg+5Ypb1UZrVSCj9qIrj81
 Qxr+C4V8znWePxvj/NjhrbIGc22GtrwDrsWnUAozoLAOHzxFMJPKRqzkrO4PjfAeQoZxMr+
 Tq0Ha3KWbi5gCse1zN5HVrA7ibj8pPibIrSWl3Orcdy9rATLUNPs8KUohUk+FqISZ8nvpBm
 2M8Xby0rwUe+6mY7/oXPIOdC4jZxF8igV6tmbphdlBX7n7WE2iXiZBm/XxB3fMW6myaEjLO
 yq1PWV3JDHj3hqFvAPritKWG0NJyDraKbiUtMaGPSRZQOWIQue6W9enJLZ/HONeh4jVJxfx
 T358sjVssA1rFwny2ZOx1xGHBN8m2aME0FxhZMxxusVUlIKQXEZdvmZy0NAPIjgtW00EVXq
 ZMOnQkjRgMh/AyYO7La6jupluf7a8agvFY8BUiuChmNMWgbwnZWAvn9EjlWZbwWnB/ap3G6
 wEoe5c5+cPWeU4HkCdwP99CuVyUZKjhgC6MPvIdbailqEyQza8ydV4QT+QjQNH7G2HIzcAd
 glvYbSEtPiXh3czDoEtTmRe0nTZ2khcltqZTkfHHqBfPGAjifouhn/6eaftLiipNH/F0JCi
 TVG4QZ3h8R5J/rruBsP5NmeSiYt3ZxfzsqIVco+AEHMU2TsQg6cml2F3IMyNgDiqXF3IjY5
 jfllemP1Nbrw5+6Dk7JZx/akSgiGQmWD9BR9TD3EXwB78fpen4SqFXOJ6um4AD1vzCR3oye
 3u9zgqnWbNVCiwjT4efg1GePcstE00x0wV6TOiGery8oEyv+10hCRxfk0BNDY4W6YW+7Gzz
 FAUOC1kUJsQIteQDwlfgNm4LHm2wHa7DGtd2jEQuNt3J1t+1nQmxpli7Ffu49VXIbm7S9N3
 HWsxbkKv2OSeOxuL/OxIhCrKPcxsQnuKXrENG/LN38b/1j/Dme5myeCwlH8nPH5M25KgdwY
 cJK85wIlGnTrnMZAlIirw0MwR
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0
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

On 10/30/24 19:39, Quentin Schulz wrote:
> Hi Naoki,
> 
> On 10/30/24 4:09 AM, FUKAUMI Naoki wrote:
>> Hi,
>>
>> could you review this patch, anyone?
>>
>> Best regards,
>>
>> -- 
>> FUKAUMI Naoki
>> Radxa Computer (Shenzhen) Co., Ltd.
>>
>> On 8/25/24 07:33, FUKAUMI Naoki wrote:
>>> on Radxa ROCK 5A, sdhci(eMMC) and fspim0(SPI NOR flash) share pins
>>> (i.e. eMMC and SPI NOR flash are exclusive), new defconfig and dts
>>> specifically for SPI NOR flash is required.
>>>
>>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>>> ---
>>> Changes in v2
>>> - fix subject
>>> ---
>>>   arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi | 24 ++++++
>>>   arch/arm/dts/rk3588s-rock-5a-spi.dts         |  4 +
>>>   board/radxa/rock5a-rk3588s/MAINTAINERS       |  5 +-
>>>   configs/rock5a-spi-rk3588s_defconfig         | 83 ++++++++++++++++++++
>>>   4 files changed, 113 insertions(+), 3 deletions(-)
>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5a-spi.dts
>>>   create mode 100644 configs/rock5a-spi-rk3588s_defconfig
>>>
>>> diff --git a/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi b/arch/arm/ 
>>> dts/rk3588s-rock-5a-spi-u-boot.dtsi
>>> new file mode 100644
>>> index 00000000000..5cd131d3cb1
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
>>> @@ -0,0 +1,24 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2023 Collabora Ltd.
>>> + */
>>> +
>>> +#include "rk3588s-u-boot.dtsi"
>>> +
>>> +&fspim0_pins {
>>> +    bootph-pre-ram;
>>> +    bootph-some-ram;
>>> +};
>>> +
>>> +&sdhci {
>>> +    status = "disabled";
>>> +};
>>> +
>>> +&sfc {
>>> +    status = "okay";
>>> +
>>> +    flash@0 {
>>> +        bootph-pre-ram;
>>> +        bootph-some-ram;
>>> +    };
>>> +};
> 
> I assume the board can only be fitted with an SPI NOR or an eMMC and not 
> both at the same time? If that's the case, then the status = disabled 
> and status = okay should be in the dts. I assume we want this to be in 
> the Linux kernel first too, either as a separate DTS or with a DTSO (not 
> sure what they will want).

maybe it's time to update this patch.

https://patchwork.kernel.org/project/linux-rockchip/patch/20230913064505.77393-2-naoki@radxa.com/

rock-5a-base.dtsi (common part)
rock-5a.dts (same as current one)
rock-5a-spi-dts

>>> diff --git a/arch/arm/dts/rk3588s-rock-5a-spi.dts b/arch/arm/dts/ 
>>> rk3588s-rock-5a-spi.dts
>>> new file mode 100644
>>> index 00000000000..780e90d041b
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3588s-rock-5a-spi.dts
>>> @@ -0,0 +1,4 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +
>>> +/dts-v1/;
>>> +#include "rk3588s-rock-5a.dts"
>>> diff --git a/board/radxa/rock5a-rk3588s/MAINTAINERS b/board/radxa/ 
>>> rock5a-rk3588s/MAINTAINERS
>>> index a569efa74e3..06ebc9829f4 100644
>>> --- a/board/radxa/rock5a-rk3588s/MAINTAINERS
>>> +++ b/board/radxa/rock5a-rk3588s/MAINTAINERS
>>> @@ -4,6 +4,5 @@ R:    Jonas Karlman <jonas@kwiboo.se>
>>>   S:    Maintained
>>>   F:    board/radxa/rock5a-rk3588s
>>>   F:    include/configs/rock5a-rk3588s.h
>>> -F:    configs/rock5a-rk3588s_defconfig
>>> -F:    arch/arm/dts/rk3588s-rock-5a.dts
>>> -F:    arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
>>> +F:    configs/rock5a*
>>> +F:    arch/arm/dts/rk3588s-rock-5a*
>>> diff --git a/configs/rock5a-spi-rk3588s_defconfig b/configs/rock5a- 
>>> spi-rk3588s_defconfig
>>> new file mode 100644
>>> index 00000000000..297278c7a06
>>> --- /dev/null
>>> +++ b/configs/rock5a-spi-rk3588s_defconfig
> 
> If Radxa starts having many such options, maybe it won't make a lot of 
> sense to duplicate configs but rather have config fragments to change 
> the default DT and add a few symbols that differ from the base (I assume 
> we may have something similar needed for rock 5b+ compared to rock5b for 
> example?

I'm thinking doing same for ROCK 5C...

https://github.com/RadxaNaoki/u-boot/commits/rock-5c/

> Keeping all configs in sync for essentially same board with small 
> differences may be difficult, maybe using config fragments will help?

any "config fragments" doc/example?

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

>>> @@ -0,0 +1,83 @@
>>> +CONFIG_ARM=y
>>> +CONFIG_SKIP_LOWLEVEL_INIT=y
>>> +CONFIG_COUNTER_FREQUENCY=24000000
>>> +CONFIG_ARCH_ROCKCHIP=y
>>> +CONFIG_SF_DEFAULT_SPEED=24000000
>>> +CONFIG_SF_DEFAULT_MODE=0x2000
>>> +CONFIG_DEFAULT_DEVICE_TREE="rk3588s-rock-5a-spi"
>>> +CONFIG_ROCKCHIP_RK3588=y
>>> +CONFIG_ROCKCHIP_SPI_IMAGE=y
>>> +CONFIG_SPL_SERIAL=y
>>> +CONFIG_TARGET_ROCK5A_RK3588=y
>>> +CONFIG_DEBUG_UART_BASE=0xFEB50000
>>> +CONFIG_DEBUG_UART_CLOCK=24000000
>>> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>> +CONFIG_SPL_SPI=y
>>> +CONFIG_SYS_LOAD_ADDR=0xc00800
>>> +CONFIG_DEBUG_UART=y
>>> +CONFIG_FIT=y
>>> +CONFIG_FIT_VERBOSE=y
>>> +CONFIG_SPL_FIT_SIGNATURE=y
>>> +CONFIG_SPL_LOAD_FIT=y
>>> +CONFIG_LEGACY_IMAGE_FORMAT=y
>>> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5a.dtb"
>>> +# CONFIG_DISPLAY_CPUINFO is not set
>>> +CONFIG_DISPLAY_BOARDINFO_LATE=y
>>> +CONFIG_SPL_MAX_SIZE=0x40000
>>> +CONFIG_SPL_PAD_TO=0x7f8000
>>> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
>>> +CONFIG_SPL_SPI_LOAD=y
>>> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
>>> +CONFIG_SPL_ATF=y
>>> +CONFIG_CMD_GPIO=y
>>> +CONFIG_CMD_GPT=y
>>> +CONFIG_CMD_I2C=y
>>> +CONFIG_CMD_MMC=y
>>> +CONFIG_CMD_USB=y
>>> +# CONFIG_CMD_SETEXPR is not set
>>> +CONFIG_CMD_REGULATOR=y
>>> +# CONFIG_SPL_DOS_PARTITION is not set
>>> +CONFIG_SPL_OF_CONTROL=y
>>> +CONFIG_OF_LIVE=y
>>> +# CONFIG_OF_UPSTREAM is not set
>>> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned- 
>>> clocks assigned-clock-rates assigned-clock-parents"
>>> +CONFIG_SPL_DM_SEQ_ALIAS=y
>>> +CONFIG_SPL_REGMAP=y
>>> +CONFIG_SPL_SYSCON=y
>>> +CONFIG_SPL_CLK=y
>>> +CONFIG_ROCKCHIP_GPIO=y
>>> +CONFIG_SYS_I2C_ROCKCHIP=y
>>> +CONFIG_MISC=y
>>> +CONFIG_SUPPORT_EMMC_RPMB=y
>>> +CONFIG_MMC_DW=y
>>> +CONFIG_MMC_DW_ROCKCHIP=y
>>> +CONFIG_MMC_SDHCI=y
>>> +CONFIG_MMC_SDHCI_SDMA=y
>>> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> 
> I assume out of the MMC_DW_ROCKCHIP and MMC_SDHCI_ROCKCHIP drivers, one 
> isn't needed anymore as it's the one for the eMMC and the other for the 
> SD card?
> 
> Cheers,
> Quentin
> 
