Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD18C25B4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 02:50:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 524E788427;
	Wed,  8 May 2024 04:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="IhBnel2l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD4888427; Wed,  8 May 2024 04:50:03 +0200 (CEST)
Received: from mail-m15567.qiye.163.com (mail-m15567.qiye.163.com
 [101.71.155.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B225E88426
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 04:50:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=IhBnel2legHYRYQtvmpk7L3Mm09zLfNg5sdUjvo1Qwxf1FDBpkXybIdN1lsBvx66M9iaNo8mRFEZLtYznC62sNumxf4o3Mq4MWRH7aUSJVoXtCVY97AmXb45TbqmbUQNLfRIgdi2ET2bzlm2LwvZmdGqZvrdy9fsI1d8A9ypiO4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
 bh=oqoVzEDeWbeF5p6yOfwqVTZZ5VRISAhCv1Y0hQUh3BI=;
 h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.77] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 49A619001F1;
 Wed,  8 May 2024 10:49:45 +0800 (CST)
Message-ID: <12541a5d-827c-492a-b08e-8e388a68239a@rock-chips.com>
Date: Wed, 8 May 2024 10:49:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] board: rockchip: add Powkiddy X55
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: jagan@edgeble.ai, jonas@kwiboo.se, trini@konsulko.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240502214057.1092773-1-macroalpha82@gmail.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240502214057.1092773-1-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkNDGVYZGBlCSUNLHUtOGEJVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
 tLWQY+
X-HM-Tid: 0a8f561b5fdf03a9kunm49a619001f1
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBg6NBw*CzMCSQgqAx4oMkI4
 SAtPFEhVSlVKTEpOSkhNTkNNSEhDVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0tPSTcG
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


On 2024/5/3 05:40, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
>
> The Powkiddy X55 is a Rockchip RK3566 based handheld gaming device.
> UART, ADC, eMMC, and SDMMC are tested to work in U-Boot and this
> successfully boots mainline Linux.
>
> Kernel commit:
> e99adc97e21a ("arm64: dts: rockchip: Add Powkiddy X55")
>
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>
> Changes since V2:
>   - Refactored to use the upstream device tree from Linux.
>   - Removed logic for handling the adc button and instead simply try to
>     boot from sdmmc0 as a valid target first.
>
> ---
>   arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi |  9 +++
>   arch/arm/mach-rockchip/rk3568/Kconfig        |  6 ++
>   board/powkiddy/x55/Kconfig                   | 15 +++++
>   board/powkiddy/x55/MAINTAINERS               |  7 +++
>   board/powkiddy/x55/Makefile                  |  6 ++
>   board/powkiddy/x55/x55.c                     | 39 +++++++++++++
>   configs/powkiddy-x55-rk3566_defconfig        | 59 ++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst              |  1 +
>   include/configs/powkiddy-x55-rk3566.h        | 12 ++++
>   9 files changed, 154 insertions(+)
>   create mode 100644 arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi
>   create mode 100644 board/powkiddy/x55/Kconfig
>   create mode 100644 board/powkiddy/x55/MAINTAINERS
>   create mode 100644 board/powkiddy/x55/Makefile
>   create mode 100644 board/powkiddy/x55/x55.c
>   create mode 100644 configs/powkiddy-x55-rk3566_defconfig
>   create mode 100644 include/configs/powkiddy-x55-rk3566.h
>
> diff --git a/arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi b/arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi
> new file mode 100644
> index 0000000000..c440201ec7
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		u-boot,spl-boot-order = &sdmmc0, &sdmmc1, &sdhci;
> +	};
> +};
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index af537d912a..014ebf9f0b 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -22,6 +22,11 @@ config TARGET_ODROID_M1_RK3568
>   	help
>   	  Hardkernel ODROID-M1 single board computer with a RK3568B2 SoC.
>   
> +config TARGET_POWKIDDY_X55_RK3566
> +	bool "Powkiddy X55"
> +	help
> +	  Powkiddy X55 handheld gaming console with an RK3566 SoC.
> +
>   config TARGET_QUARTZ64_RK3566
>   	bool "Pine64 Quartz64"
>   	help
> @@ -48,5 +53,6 @@ source "board/rockchip/evb_rk3568/Kconfig"
>   source "board/anbernic/rgxx3_rk3566/Kconfig"
>   source "board/hardkernel/odroid_m1/Kconfig"
>   source "board/pine64/quartz64_rk3566/Kconfig"
> +source "board/powkiddy/x55/Kconfig"
>   
>   endif
> diff --git a/board/powkiddy/x55/Kconfig b/board/powkiddy/x55/Kconfig
> new file mode 100644
> index 0000000000..a7b3ed4d0d
> --- /dev/null
> +++ b/board/powkiddy/x55/Kconfig
> @@ -0,0 +1,15 @@
> +if TARGET_POWKIDDY_X55_RK3566
> +
> +config SYS_BOARD
> +	default "x55"
> +
> +config SYS_VENDOR
> +	default "powkiddy"
> +
> +config SYS_CONFIG_NAME
> +	default "powkiddy-x55-rk3566"
> +
> +config BOARD_SPECIFIC_OPTIONS
> +	def_bool y
> +
> +endif
> diff --git a/board/powkiddy/x55/MAINTAINERS b/board/powkiddy/x55/MAINTAINERS
> new file mode 100644
> index 0000000000..01ae8da19d
> --- /dev/null
> +++ b/board/powkiddy/x55/MAINTAINERS
> @@ -0,0 +1,7 @@
> +X55
> +M:	Chris Morgan <macromorgan@hotmail.com>
> +S:	Maintained
> +F:	board/powkiddy/x55
> +F:	include/configs/powkiddy-x55-rk3566.h
> +F:	configs/powkiddy-x55-rk3566_defconfig
> +F:	arch/arm/dts/rk3566-powkiddy-x55-u-boot.dtsi
> diff --git a/board/powkiddy/x55/Makefile b/board/powkiddy/x55/Makefile
> new file mode 100644
> index 0000000000..55c8c16aa1
> --- /dev/null
> +++ b/board/powkiddy/x55/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier:     GPL-2.0+
> +#
> +# Copyright (c) 2023 Chris Morgan <macromorgan@hotmail.com>
> +#
> +
> +obj-y += x55.o
> diff --git a/board/powkiddy/x55/x55.c b/board/powkiddy/x55/x55.c
> new file mode 100644
> index 0000000000..b2703e6382
> --- /dev/null
> +++ b/board/powkiddy/x55/x55.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2023 Chris Morgan <macromorgan@hotmail.com>
> + */
> +
> +#include <asm/io.h>
> +
> +#define GPIO4_BASE		0xfe770000
> +#define GPIO_SWPORT_DR_L	0x0000
> +#define GPIO_SWPORT_DDR_L	0x0008
> +#define GPIO_B4			BIT(12)
> +#define GPIO_B5			BIT(13)
> +#define GPIO_B6			BIT(14)
> +
> +#define GPIO_WRITEMASK(bits)	((bits) << 16)
> +
> +/*
> + * Start LED very early so user knows device is on. Set color
> + * to red.
> + */
> +void spl_board_init(void)
> +{
> +	/* Set GPIO4_B4, GPIO4_B5, and GPIO4_B6 to output. */
> +	writel(GPIO_WRITEMASK(GPIO_B6 | GPIO_B5 | GPIO_B4) | \
> +	       (GPIO_B6 | GPIO_B5 | GPIO_B4),
> +	       (GPIO4_BASE + GPIO_SWPORT_DDR_L));
> +	/* Set GPIO4_B5 and GPIO4_B6 to 0 and GPIO4_B4 to 1. */
> +	writel(GPIO_WRITEMASK(GPIO_B6 | GPIO_B5 | GPIO_B4) | GPIO_B4,
> +	       (GPIO4_BASE + GPIO_SWPORT_DR_L));
> +}
> +
> +int rk_board_late_init(void)
> +{
> +	/* Turn off red LED and turn on orange LED. */
> +	writel(GPIO_WRITEMASK(GPIO_B6 | GPIO_B5 | GPIO_B4) | GPIO_B6,
> +	       (GPIO4_BASE + GPIO_SWPORT_DR_L));
> +
> +	return 0;
> +}
> diff --git a/configs/powkiddy-x55-rk3566_defconfig b/configs/powkiddy-x55-rk3566_defconfig
> new file mode 100644
> index 0000000000..db996fd570
> --- /dev/null
> +++ b/configs/powkiddy-x55-rk3566_defconfig
> @@ -0,0 +1,59 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-powkiddy-x55"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-powkiddy-x55.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_UPSTREAM=y

This option already enabled by ROCKCHIP_RK3568, pls remove it here.


Thanks,

- Kever

> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 9a726e9cde..924a8d0886 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -104,6 +104,7 @@ List of mainline supported Rockchip boards:
>        - Pine64 SOQuartz on Blade (soquartz-blade-rk3566)
>        - Pine64 SOQuartz on CM4-IO (soquartz-cm4-rk3566)
>        - Pine64 SOQuartz on Model A (soquartz-model-a-rk3566)
> +     - Powkiddy X55 (powkiddy-x55-rk3566)
>        - Radxa CM3 IO Board (radxa-cm3-io-rk3566)
>   
>   * rk3568
> diff --git a/include/configs/powkiddy-x55-rk3566.h b/include/configs/powkiddy-x55-rk3566.h
> new file mode 100644
> index 0000000000..4b25c6a877
> --- /dev/null
> +++ b/include/configs/powkiddy-x55-rk3566.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __POWKIDDY_X55_RK3566_H
> +#define __POWKIDDY_X55_RK3566_H
> +
> +#include <configs/rk3568_common.h>
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +			"stdout=serial,vidconsole\0" \
> +			"stderr=serial,vidconsole\0"
> +
> +#endif
