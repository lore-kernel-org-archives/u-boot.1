Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BBFE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 06:58:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 320D5805EA;
	Wed,  8 Jan 2025 07:58:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="J+HIQZlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 204CF8005B; Wed,  8 Jan 2025 07:58:23 +0100 (CET)
Received: from mail-m12740.qiye.163.com (mail-m12740.qiye.163.com
 [115.236.127.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E836805EA
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 07:58:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 81535871;
 Wed, 8 Jan 2025 14:58:14 +0800 (GMT+08:00)
Message-ID: <4ce26e9f-08ca-41f4-8401-e995a835cdff@rock-chips.com>
Date: Wed, 8 Jan 2025 14:58:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] rockchip: Add support for Radxa ROCK 5C
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 sumit.garg@linaro.org, jonas@kwiboo.se, eugen.hristev@linaro.org,
 quentin.schulz@cherry.de, michal.simek@amd.com, seb-dev@mail.de,
 liujianfeng1994@gmail.com, heiko@sntech.de, zhangzj@rock-chips.com,
 macromorgan@hotmail.com, dsimic@manjaro.org, pbrobinson@gmail.com,
 cfsworks@gmail.com, sebastian.reichel@collabora.com, alchark@gmail.com,
 didi.debian@cknow.org, cassel@kernel.org, boris.brezillon@collabora.com,
 cristian.ciocaltea@collabora.com, jing@jing.rocks
References: <20250104015704.1238-1-naoki@radxa.com>
 <20250104015704.1238-5-naoki@radxa.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20250104015704.1238-5-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQx8aTFZLSU4aGEweQ0wfTEhWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEtNT0
 1VSktLVUpCWQY+
X-HM-Tid: 0a9444b4e8ad03afkunm81535871
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxg6Fjo5KjIPLRcILBQQCjZI
 KRUwCyNVSlVKTEhNSEpCT0JNQkNOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDSUhMNwY+
DKIM-Signature: a=rsa-sha256;
 b=J+HIQZlfHC1tHdZCKdVucHxSOs2e5MsxrzP8IRKP15siVFnvy+KO6X8ELT6DVGtCibQr6TbMbzrKeV+73C8MhpniGsBuHTikt+0eaLmZa757ETySmkfOCcEssv/Z7DSoEfXwLYDkV8ng8qW/nkvIcalXDJE6ftoFj7+OR+ahdXo=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=SF80TfQPESzp2JNZT3V1bVFcR2XUTDFNR1b2G+U73aY=;
 h=date:mime-version:subject:message-id:from;
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


On 2025/1/4 09:57, FUKAUMI Naoki wrote:
> Radxa ROCK 5C[1] is a Rockchip RK3588S2 based single board computer.
>
> [1] https://radxa.com/products/rock5/5c
>
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Changes in v5:
> - None
> Changes in v4:
> - ROCK 5A section was removed and most of it rewritten for ROCK 5C
> - Trivial changes
> Changes in v3:
> - Fix compile error
> Changes in v2:
> - arch/arm/dts/rk3588s-rock-5-u-boot.dtsi: remove unused node
> - include/configs/rock-5-rk3588s.h: fix include order
> ---
>   arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi | 11 ++++
>   arch/arm/mach-rockchip/rk3588/Kconfig    | 21 ++++++
>   board/radxa/rock-5c-rk3588s/Kconfig      | 12 ++++
>   board/radxa/rock-5c-rk3588s/MAINTAINERS  |  7 ++
>   configs/rock-5c-rk3588s_defconfig        | 84 ++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst          |  1 +
>   include/configs/rock-5c-rk3588s.h        | 15 +++++
>   7 files changed, 151 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
>   create mode 100644 board/radxa/rock-5c-rk3588s/Kconfig
>   create mode 100644 board/radxa/rock-5c-rk3588s/MAINTAINERS
>   create mode 100644 configs/rock-5c-rk3588s_defconfig
>   create mode 100644 include/configs/rock-5c-rk3588s.h
>
> diff --git a/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
> new file mode 100644
> index 000000000000..1dc574c2f219
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2024-2025 Radxa Computer (Shenzhen) Co., Ltd.
> + */
> +
> +#include "rk3588s-u-boot.dtsi"
> +
> +&sdhci {
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +};
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index b5a0e624a532..448cfaf0d60d 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -260,6 +260,26 @@ config TARGET_ROCK_5_ITX_RK3588
>   	  Front-panel connectors for audio and case-power, -leds
>   	  Powered by either 12V, ATX power-supply or PoE
>   
> +config TARGET_ROCK_5C_RK3588S
> +	bool "Radxa ROCK 5C RK3588S2 board"
> +	select BOARD_LATE_INIT
> +	help
> +	  Radxa ROCK 5C is a Rockchip RK3588S2 based single board computer.
> +
> +	  Specification:
> +
> +	  Quad A76 and Quad A55 CPU
> +	  6 TOPS NPU
> +	  up to 32GB LPDDR4x RAM
> +	  eMMC / SPI flash connector
> +	  Micro SD Card slot
> +	  Gigabit ethernet port (supports PoE with add-on PoE HAT)
> +	  WiFi6 / BT5.4
> +	  1x USB 3.0 Type-A HOST port
> +	  1x USB 3.0 Type-A OTG port
> +	  2x USB 2.0 Type-A HOST port
> +	  1x USB Type-C 5V power port
> +
>   config TARGET_SIGE7_RK3588
>   	bool "ArmSoM Sige7 RK3588 board"
>   	select BOARD_LATE_INIT
> @@ -398,6 +418,7 @@ source "board/turing/turing-rk1-rk3588/Kconfig"
>   source "board/radxa/rock5a-rk3588s/Kconfig"
>   source "board/radxa/rock5b-rk3588/Kconfig"
>   source "board/radxa/rock-5-itx-rk3588/Kconfig"
> +source "board/radxa/rock-5c-rk3588s/Kconfig"
>   source "board/rockchip/evb_rk3588/Kconfig"
>   source "board/rockchip/toybrick_rk3588/Kconfig"
>   source "board/theobroma-systems/jaguar_rk3588/Kconfig"
> diff --git a/board/radxa/rock-5c-rk3588s/Kconfig b/board/radxa/rock-5c-rk3588s/Kconfig
> new file mode 100644
> index 000000000000..ec964bdcb934
> --- /dev/null
> +++ b/board/radxa/rock-5c-rk3588s/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_ROCK_5C_RK3588S
> +
> +config SYS_BOARD
> +	default "rock-5c-rk3588s"
> +
> +config SYS_VENDOR
> +	default "radxa"
> +
> +config SYS_CONFIG_NAME
> +	default "rock-5c-rk3588s"
> +
> +endif
> diff --git a/board/radxa/rock-5c-rk3588s/MAINTAINERS b/board/radxa/rock-5c-rk3588s/MAINTAINERS
> new file mode 100644
> index 000000000000..17183c739d67
> --- /dev/null
> +++ b/board/radxa/rock-5c-rk3588s/MAINTAINERS
> @@ -0,0 +1,7 @@
> +ROCK-5C-RK3588S
> +M:	FUKAUMI Naoki <naoki@radxa.com>
> +S:	Maintained
> +F:	arch/arm/dts/rk3588s-rock-5c-u-boot.dtsi
> +F:	board/radxa/rock-5c-rk3588s/
> +F:	configs/rock-5c-rk3588s_defconfig
> +F:	include/configs/rock-5c-rk3588s.h
> diff --git a/configs/rock-5c-rk3588s_defconfig b/configs/rock-5c-rk3588s_defconfig
> new file mode 100644
> index 000000000000..59f9f25edcb8
> --- /dev/null
> +++ b/configs/rock-5c-rk3588s_defconfig
> @@ -0,0 +1,84 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-rock-5c"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_ROCK_5C_RK3588S=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-rock-5c.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_ADC=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SCSI_AHCI=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_RTL8169=y
> +CONFIG_NVME_PCI=y
> +CONFIG_PCIE_DW_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 9bab86d23479..dbe199a13c46 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -141,6 +141,7 @@ List of mainline supported Rockchip boards:
>        - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>        - Radxa ROCK 5A (rock5a-rk3588s)
>        - Radxa ROCK 5B (rock5b-rk3588)
> +     - Radxa ROCK 5C (rock-5c-rk3588s)
>        - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
>        - Theobroma Systems RK3588-SBC Jaguar (jaguar-rk3588)
>        - Theobroma Systems SOM-RK3588-Q7 - Tiger (tiger-rk3588)
> diff --git a/include/configs/rock-5c-rk3588s.h b/include/configs/rock-5c-rk3588s.h
> new file mode 100644
> index 000000000000..0fd76c96f0ca
> --- /dev/null
> +++ b/include/configs/rock-5c-rk3588s.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2024-2025 Radxa Computer (Shenzhen) Co., Ltd.
> + */
> +
> +#ifndef __ROCK_5C_RK3588S_H
> +#define __ROCK_5C_RK3588S_H
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +		"stdout=serial,vidconsole\0" \
> +		"stderr=serial,vidconsole\0"
> +
> +#include <configs/rk3588_common.h>
> +
> +#endif /* __ROCK_5C_RK3588S_H */
