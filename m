Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8F7D6B6DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 22:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24D7389250;
	Wed, 30 Oct 2024 23:11:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B9AD89250; Wed, 30 Oct 2024 23:11:06 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 316F58924F
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 23:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: bizesmtpip3t1730326235ty1qn4k
X-QQ-Originating-IP: 1uj9ZmJEBffe+q4C867xDD+jU0mgiKWx4TkzFUjUNWc=
Received: from [IPV6:240f:10b:7440:1:888b:2835 ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 31 Oct 2024 06:10:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3211505039005753652
Message-ID: <6DA6EC9ED41145AD+5a14db85-052c-4923-82b8-f965c0178746@radxa.com>
Date: Thu, 31 Oct 2024 07:10:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] rockchip: add support for Radxa ROCK 5A with SPI NOR
 flash module
To: Eugen Hristev <eugen.hristev@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
Cc: jonas@kwiboo.se, sjg@chromium.org, philipp.tomsich@vrull.eu
References: <20241030060727.1116-1-naoki@radxa.com>
 <30b77026-d2d1-4823-bb73-ea915673bb78@rock-chips.com>
 <8a9d05b0-e1f0-458c-9c37-30af97ca7915@linaro.org>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <8a9d05b0-e1f0-458c-9c37-30af97ca7915@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NWXdiw9PrSJc0P1SjXQoQQMZM/VTQ0YnSNZ/5N5wodsg6ec3LTWQV5rx
 aGTgVHXtoMnOWtD3dKNuQD8zHlQFcbSRzp7zIhv3d1x1SEumWUbv3k+EInaPahHhaXK6d7W
 PLSlZYEmLtXm6vHpAANFIdfEwQR8tD/uBHuMIEVlWjOiO/y9q0OSwSf0+rrNLV3h+7ypPWK
 4r22tvKqBmSb9HDrMDV8V86l6LrCrTCyR104VO/tyc5HVaW/mLOmLEHDW+MgbmIrkKaX1FF
 t8Ik4LRkwnyq2VqdkRRzA3jqpHDvt3WiJPxlA0w3UnQ70XFobOD3i+jfxTEcN4KHxPAOvY/
 r5SDrycb9PG4toMTKR+rh91f1xd+TfT1IEQdx93t3+ARBxj9E3az6CwMA8VENKer/aZapke
 SiQzGg1mT7o8Le+LP/Na7075ifbFqsJWkBXc4kuwmZqR96FKLosz07bGIMOPo8ZBitqv8tj
 3xKPY9CjXvymztjkVvMIxl7EYHM0DemqJfrP2GV5McLs+ucVb4aMOfhhF/SIimCf1oXbivg
 KCnNqQ/glpWNsjtgJlsvf+6p03LwHPOG2TiDTuSvXr2e7t1EBfhKJodwieEgV8tdyCvPr4N
 0rmTNCIWh5gEz9zJ6nvaNBpk2HAJj5lDsRl66ETbHqasc54+rbbvIUMCBVy4sJs8Nf6riXJ
 aTDKdtYdoqWkAx8TosC1c+t1LXbhDfKjteJp1I2hF6zSKxINv3tdFDzu4aO9Nlx5R8Th/PW
 des6mRehwD0DKJfymU4WEGqlVzHWTRj1o3DfrIJc6vX4CAzCEJ3teUQh9ptbSeMtvTnWpBQ
 yLh1avOKNwuDoPMIjyh9tJgTHHO7X0FZdPxWj6McTdm6EV7o1R6dsHpCzaP3LnYNxwjPRRX
 FIG1ETxlVrdPdLDv9J5eJajaCMj7h1BmM27ozTh88eI=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

On 10/30/24 23:24, Eugen Hristev wrote:
> 
> 
> On 10/30/24 08:30, Kever Yang wrote:
>> Hi Naoki,
>>
>> On 2024/10/30 14:07, FUKAUMI Naoki wrote:
>>> on Radxa ROCK 5A, sdhci(eMMC) and fspim0(SPI NOR flash) share pins
>>> (i.e. eMMC and SPI NOR flash are exclusive), new defconfig and dts
>>> specifically for SPI NOR flash is required.
>>>
>>> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
>>> ---
>>> Changes in v3
>>> - drop first patch
>>> - fix copyright
>>> - run savedefconfig
>>> - sync with changes for LED for Radxa boards
>>> - add more SPI NOR flash chips
>>> Changes in v2
>>> - fix subject
>>> ---
>>>   arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi | 32 +++++++
>>>   arch/arm/dts/rk3588s-rock-5a-spi.dts         |  4 +
>>>   board/radxa/rock5a-rk3588s/MAINTAINERS       |  5 +-
>>>   configs/rock5a-spi-rk3588s_defconfig         | 87 ++++++++++++++++++++
>>>   4 files changed, 125 insertions(+), 3 deletions(-)
>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
>>>   create mode 100644 arch/arm/dts/rk3588s-rock-5a-spi.dts
>>>   create mode 100644 configs/rock5a-spi-rk3588s_defconfig
>>>
>>> diff --git a/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi b/arch/arm/ 
>>> dts/rk3588s-rock-5a-spi-u-boot.dtsi
>>> new file mode 100644
>>> index 00000000000..7723931d869
>>> --- /dev/null
>>> +++ b/arch/arm/dts/rk3588s-rock-5a-spi-u-boot.dtsi
>>> @@ -0,0 +1,32 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (c) 2024 Radxa Computer (Shenzhen) Co., Ltd.
>>> + */
>>> +
>>> +#include "rk3588s-u-boot.dtsi"
>>> +
>>> +/ {
>>> +    leds {
>>> +        io-led {
>>> +            default-state = "on";
>>> +        };
>>> +    };
>>> +};
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
>>> index 00000000000..d6409a12a56
>>> --- /dev/null
>>> +++ b/configs/rock5a-spi-rk3588s_defconfig
>>> @@ -0,0 +1,87 @@
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
>>> +CONFIG_SYS_LOAD_ADDR=0xc00800
>>> +CONFIG_SF_DEFAULT_BUS=5
>>> +CONFIG_DEBUG_UART_BASE=0xFEB50000
>>> +CONFIG_DEBUG_UART_CLOCK=24000000
>>> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
>>> +CONFIG_SPL_SPI=y
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
>> MMC should removed
> 
> The eMMC is disabled, but this board has an SD-Card right ?

yes, it has microSD slot. I'll remove eMMC things.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

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
>>> +CONFIG_LED=y
>>> +CONFIG_LED_GPIO=y
>>> +CONFIG_MISC=y
>>> +CONFIG_SUPPORT_EMMC_RPMB=y
>>> +CONFIG_MMC_DW=y
>>> +CONFIG_MMC_DW_ROCKCHIP=y
>>> +CONFIG_MMC_SDHCI=y
>>> +CONFIG_MMC_SDHCI_SDMA=y
>>> +CONFIG_MMC_SDHCI_ROCKCHIP=y
>>
>> MMC relate driver should removed
>>
>>
>> Thanks,
>> - Kever
>>> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
>>> +CONFIG_SPI_FLASH_GIGADEVICE=y
>>> +CONFIG_SPI_FLASH_MACRONIX=y
>>> +CONFIG_SPI_FLASH_WINBOND=y
>>> +CONFIG_SPI_FLASH_XTX=y
>>> +CONFIG_PHY_REALTEK=y
>>> +CONFIG_DWC_ETH_QOS=y
>>> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
>>> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>>> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>>> +CONFIG_PHY_ROCKCHIP_USBDP=y
>>> +CONFIG_SPL_PINCTRL=y
>>> +CONFIG_PWM_ROCKCHIP=y
>>> +CONFIG_SPL_RAM=y
>>> +CONFIG_BAUDRATE=1500000
>>> +CONFIG_DEBUG_UART_SHIFT=2
>>> +CONFIG_SYS_NS16550_MEM32=y
>>> +CONFIG_ROCKCHIP_SFC=y
>>> +CONFIG_SYSRESET=y
>>> +CONFIG_USB=y
>>> +CONFIG_USB_XHCI_HCD=y
>>> +CONFIG_USB_EHCI_HCD=y
>>> +CONFIG_USB_EHCI_GENERIC=y
>>> +CONFIG_USB_OHCI_HCD=y
>>> +CONFIG_USB_OHCI_GENERIC=y
>>> +CONFIG_USB_DWC3=y
>>> +CONFIG_USB_DWC3_GENERIC=y
>>> +CONFIG_ERRNO_STR=y
> 
> 
