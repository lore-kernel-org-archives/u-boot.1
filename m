Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA8EC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 09:29:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E402F88859;
	Fri,  9 Aug 2024 11:29:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="KBZfkYOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 124C388B80; Fri,  9 Aug 2024 11:29:49 +0200 (CEST)
Received: from mail-m15572.qiye.163.com (mail-m15572.qiye.163.com
 [101.71.155.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA450882E6
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 11:29:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=KBZfkYOB+lUGSH8az6nnbuvqOOlJFapyF4pvJnRROXtdIrcx/ZBWdRJnL6+NVlt8dJM9xA7W1JUmZNq3MDVSDDQJP5XhVqmm46RoKfrEN/9bWTU9QYsX5NLrTFKKE9F+PKu6BTeczt95GoOHrDA3Ey8luM1+Zn3gsXa0Lic4Yr4=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=nVP3h2wAE2rRvxJE1AqHG9CGJx63V5HGcGqlbKYs/Dk=;
 h=date:mime-version:subject:message-id:from;
Received: from [192.168.60.65] (unknown [103.29.142.67])
 by smtp.qiye.163.com (Hmail) with ESMTPA id 533C3900157;
 Fri,  9 Aug 2024 17:29:21 +0800 (CST)
Message-ID: <4bd04b41-bbc5-4857-87a7-a662cb67991f@rock-chips.com>
Date: Fri, 9 Aug 2024 17:29:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] board: rockchip: Add Radxa ROCK 5 ITX
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu
Cc: dsimic@manjaro.org, u-boot@lists.denx.de, jonas@kwiboo.se
References: <20240802210028.2919639-1-heiko@sntech.de>
 <20240802210028.2919639-5-heiko@sntech.de>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20240802210028.2919639-5-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSkwZVh9ITklLS09NTR4YQlYVFAkWGhdVEwETFh
 oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
 VKQktLWQY+
X-HM-Tid: 0a913678a72203a9kunm533c3900157
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PS46PRw6HjI2KQ41EDQcHCES
 QgwaCShVSlVKTElISkJOTE1ISktPVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpKSE1KNwY+
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


On 2024/8/3 05:00, Heiko Stuebner wrote:
> The Rock 5 ITX is board in ITX form factor using the RK358 SoC
>
> It can be powered either by 12V, ATX power-supply or PoE.
>
> Notable peripherals are the 4 SATA ports, M.2 M-Key slot, M.2 E-key slot,
> 2*2.5Gb PCIe-connected Ethernet NICs.
>
> Display options are 2*HDMI, DP via USB-c, eDP + 2*DSI via PCB connectors.
>
> USB ports are 4*USB3 + 2*USB2 on the back panel and 2-port front-panel
> connector.
>
> Schematics for the board can be found on
> - https://dl.radxa.com/rock5/5itx/radxa_rock_5_itx_X1100_schematic.pdf
> - https://dl.radxa.com/rock5/5itx/v1110/radxa_rock_5itx_v1110_schematic.pdf
>
> The naming scheme with the dashes follows Dragan's comment on the mainline
> devicetree commit:
>      "the name of this board deviates from the standard Radxa naming scheme,
>       which is something like "ROCK <number><letter>" thus, "rock-5a" is
>       fine, but it should be "rock-5-itx", simply because there's a space
>       between "5" and "ITX" in "ROCK 5 ITX"
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi |  22 ++++
>   arch/arm/mach-rockchip/rk3588/Kconfig      |  29 ++++++
>   board/radxa/rock-5-itx-rk3588/Kconfig      |  12 +++
>   board/radxa/rock-5-itx-rk3588/MAINTAINERS  |   8 ++
>   configs/rock-5-itx-rk3588_defconfig        | 111 +++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst            |   1 +
>   include/configs/rock-5-itx-rk3588.h        |  15 +++
>   7 files changed, 198 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi
>   create mode 100644 board/radxa/rock-5-itx-rk3588/Kconfig
>   create mode 100644 board/radxa/rock-5-itx-rk3588/MAINTAINERS
>   create mode 100644 configs/rock-5-itx-rk3588_defconfig
>   create mode 100644 include/configs/rock-5-itx-rk3588.h
>
> diff --git a/arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi b/arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi
> new file mode 100644
> index 00000000000..1e5c2674e49
> --- /dev/null
> +++ b/arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2023 Collabora Ltd.
> + */
> +
> +#include "rk3588-u-boot.dtsi"
> +
> +&fspim2_pins {
> +	bootph-pre-ram;
> +	bootph-some-ram;
> +};
> +
> +&sfc {
> +	flash@0 {
> +		bootph-pre-ram;
> +		bootph-some-ram;
> +	};
> +};
> +
> +&vcc3v3_mkey {
> +	regulator-always-on;
> +};
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index e751d64e1a1..0dcf2249fb4 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -185,6 +185,34 @@ config TARGET_ROCK5B_RK3588
>   	  USB PD over USB Type-C
>   	  Size: 100mm x 72mm (Pico-ITX form factor)
>   
> +config TARGET_ROCK_5_ITX_RK3588
> +	bool "Radxa ROCK-5-ITX RK3588 board"
> +	select BOARD_LATE_INIT
> +	help
> +	  Radxa ROCK-5-ITX is a Rockchip RK3588 based SBC (Single Board
> +	  Computer) by Radxa in the ITX formfactor.
> +
> +	  There are variants depending on the DRAM size : from 4G up to 32G.
> +
> +	  Specification:
> +
> +	  Rockchip Rk3588 SoC
> +	  4x ARM Cortex-A76, 4x ARM Cortex-A55
> +	  4/8/16/24/32GB memory LPDDR5
> +	  Mali G610MC4 GPU
> +	  2x MIPI CSI 2 multiple lanes connector
> +	  eMMC
> +	  uSD slot (up to 128GB)
> +	  M.2 M-key and M.2 E-key connector
> +	  4x SATA
> +	  2x USB 2.0 + 4x USB 3.0 Type-A, 2x USB 2.0 Panel, 1x USB 3.0 Type-C
> +	  2x HDMI 2.1 output, 1x HDMI input
> +	  DP via Type-C
> +	  2x DSI via PCB connector
> +	  2x 2.5 Gbps Ethernet port
> +	  Front-panel connectors for audio and case-power, -leds
> +	  Powered by either 12V, ATX power-supply or PoE
> +
>   config TARGET_SIGE7_RK3588
>   	bool "ArmSoM Sige7 RK3588 board"
>   	select BOARD_LATE_INIT
> @@ -319,6 +347,7 @@ source "board/pine64/quartzpro64-rk3588/Kconfig"
>   source "board/turing/turing-rk1-rk3588/Kconfig"
>   source "board/radxa/rock5a-rk3588s/Kconfig"
>   source "board/radxa/rock5b-rk3588/Kconfig"
> +source "board/radxa/rock-5-itx-rk3588/Kconfig"
>   source "board/rockchip/evb_rk3588/Kconfig"
>   source "board/rockchip/toybrick_rk3588/Kconfig"
>   source "board/theobroma-systems/jaguar_rk3588/Kconfig"
> diff --git a/board/radxa/rock-5-itx-rk3588/Kconfig b/board/radxa/rock-5-itx-rk3588/Kconfig
> new file mode 100644
> index 00000000000..f7a7666d531
> --- /dev/null
> +++ b/board/radxa/rock-5-itx-rk3588/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_ROCK_5_ITX_RK3588
> +
> +config SYS_BOARD
> +	default "rock-5-itx-rk3588"
> +
> +config SYS_VENDOR
> +	default "radxa"
> +
> +config SYS_CONFIG_NAME
> +	default "rock-5-itx-rk3588"
> +
> +endif
> diff --git a/board/radxa/rock-5-itx-rk3588/MAINTAINERS b/board/radxa/rock-5-itx-rk3588/MAINTAINERS
> new file mode 100644
> index 00000000000..1c4f24306a0
> --- /dev/null
> +++ b/board/radxa/rock-5-itx-rk3588/MAINTAINERS
> @@ -0,0 +1,8 @@
> +ROCK-5-ITX-RK3588
> +M:	Heiko Stuebner <heiko@sntech.de>
> +R:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	board/radxa/rock-5-itx-rk3588
> +F:	include/configs/rock-5-itx-rk3588.h
> +F:	configs/rock-5-itx-rk3588_defconfig
> +F:	arch/arm/dts/rk3588-rock-5-itx-u-boot.dtsi
> diff --git a/configs/rock-5-itx-rk3588_defconfig b/configs/rock-5-itx-rk3588_defconfig
> new file mode 100644
> index 00000000000..bb9f148692a
> --- /dev/null
> +++ b/configs/rock-5-itx-rk3588_defconfig
> @@ -0,0 +1,111 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_SPEED=24000000
> +CONFIG_SF_DEFAULT_MODE=0x2000
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588-rock-5-itx"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_ROCKCHIP_SPI_IMAGE=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_ROCK5B_RK3588=y
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SPL_SPI_FLASH_SUPPORT=y
> +CONFIG_SPL_SPI=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588-rock-5-itx.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SPI_LOAD=y
> +CONFIG_SYS_SPI_U_BOOT_OFFS=0x60000
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SYS_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_DWC_AHCI=y
> +CONFIG_SPL_CLK=y
> +# CONFIG_USB_FUNCTION_FASTBOOT is not set
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_SF_DEFAULT_BUS=5
> +CONFIG_SPI_FLASH_SFDP_SUPPORT=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_PHYLIB=y
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
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SFC=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_HOST_ETHER=y
> +CONFIG_USB_ETHER_ASIX=y
> +CONFIG_USB_ETHER_ASIX88179=y
> +CONFIG_USB_ETHER_LAN75XX=y
> +CONFIG_USB_ETHER_LAN78XX=y
> +CONFIG_USB_ETHER_MCS7830=y
> +CONFIG_USB_ETHER_RTL8152=y
> +CONFIG_USB_ETHER_SMSC95XX=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index bedc52e03e2..90416ce13aa 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -128,6 +128,7 @@ List of mainline supported Rockchip boards:
>        - Generic RK3588S/RK3588 (generic-rk3588)
>        - Indiedroid Nova (nova-rk3588s)
>        - Pine64 QuartzPro64 (quartzpro64-rk3588)
> +     - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>        - Radxa ROCK 5A (rock5a-rk3588s)
>        - Radxa ROCK 5B (rock5b-rk3588)
>        - Rockchip Toybrick TB-RK3588X (toybrick-rk3588)
> diff --git a/include/configs/rock-5-itx-rk3588.h b/include/configs/rock-5-itx-rk3588.h
> new file mode 100644
> index 00000000000..bc0f9e72bc5
> --- /dev/null
> +++ b/include/configs/rock-5-itx-rk3588.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2024 Heiko Stuebner <heiko@sntech.de>
> + */
> +
> +#ifndef __ROCK_5_ITX_RK3588_H
> +#define __ROCK_5_ITX_RK3588_H
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +		"stdout=serial,vidconsole\0" \
> +		"stderr=serial,vidconsole\0"
> +
> +#include <configs/rk3588_common.h>
> +
> +#endif /* __ROCK_5_ITX_RK3588_H */
