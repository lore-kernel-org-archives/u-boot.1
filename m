Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BD5D3C934
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 01:32:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 781A68923A;
	Mon, 21 Oct 2024 03:32:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="cy66xhAE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E4308923A; Mon, 21 Oct 2024 03:32:20 +0200 (CEST)
Received: from mail-m49239.qiye.163.com (mail-m49239.qiye.163.com
 [45.254.49.239])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BB8688F8E
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 03:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=cy66xhAE1T+zRAV2zAX2ONLuVahwrqqCONpo9qLyWPy6dfYFWT8Y5VOCtPWoxi8ONblrBl0hpMx40Ziz9svLUeJurxP53r0J4T2+v0dmJV/iD1HS87hlatk46xs49JRNfHyywbxxuyFhZjW5EVPP+o7Kv9XFEe8yM4B05p0ZJrg=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=eAGvIMpwnux/2WPnjsjeCtLKP6YdwB9SkjQKohjixPU=;
 h=date:mime-version:subject:message-id:from;
Received: from yk?rock-chips.com
 (gy-adaptive-ssl-proxy-1-entmail-virt204.gy.ntes [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with SMTP id 2B41352015F;
 Mon, 21 Oct 2024 09:32:06 +0800 (CST)
Message-ID: <0667cedd-59e6-46c3-b81e-aa5de39a3c96@rock-chips.com>
Date: Mon, 21 Oct 2024 09:32:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 2/2] board: rockchip: Add Hardkernel ODROID-M2
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241003195941.340519-1-jonas@kwiboo.se>
 <20241003195941.340519-3-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20241003195941.340519-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkwaQ1ZMTxhOGUsZGEgfSx9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92acb3f69f03afkunm2b41352015f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nyo6Egw4FTIfEygfKU9NThRR
 DhxPCUNVSlVKTElCT0xPSElDQkJOVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFCS0lINwY+
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


On 2024/10/4 03:59, Jonas Karlman wrote:
> The Hardkernel ODROID-M2 is a single-board computer based on Rockchip
> RK3588S2 SoC. It features e.g. 8/16 GB LPDDR5 RAM, 64 GB eMMC, SD-card,
> GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0/Type-C.
>
> Features tested on a ODROID-M2 16GB rev1.0 20240611:
> - SD-card boot
> - eMMC boot
> - Ethernet
> - PCIe/NVMe
> - USB gadget
> - USB host
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
>   arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi |  3 +
>   arch/arm/mach-rockchip/rk3588/Kconfig      |  7 ++
>   board/hardkernel/odroid_m2/Kconfig         | 12 +++
>   board/hardkernel/odroid_m2/MAINTAINERS     |  7 ++
>   configs/odroid-m2-rk3588s_defconfig        | 96 ++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst            |  1 +
>   include/configs/odroid_m2.h                | 11 +++
>   7 files changed, 137 insertions(+)
>   create mode 100644 arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi
>   create mode 100644 board/hardkernel/odroid_m2/Kconfig
>   create mode 100644 board/hardkernel/odroid_m2/MAINTAINERS
>   create mode 100644 configs/odroid-m2-rk3588s_defconfig
>   create mode 100644 include/configs/odroid_m2.h
>
> diff --git a/arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi b/arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi
> new file mode 100644
> index 000000000000..853ed58cfe58
> --- /dev/null
> +++ b/arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk3588s-u-boot.dtsi"
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index a76a470cc981..6f28a3133255 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -134,6 +134,12 @@ config TARGET_NOVA_RK3588
>   	  includes socket for eMMC storage, an SDMMC slot, and a 40-pin
>   	  GPIO header for expansion.
>   
> +config TARGET_ODROID_M2_RK3588S
> +	bool "Hardkernel ODROID-M2"
> +	select BOARD_LATE_INIT
> +	help
> +	  Hardkernel ODROID-M2 single board computer with a RK3588S2 SoC.
> +
>   config TARGET_RK3588_NEU6
>   	bool "Edgeble Neural Compute Module 6(Neu6) SoM"
>   	select BOARD_LATE_INIT
> @@ -366,6 +372,7 @@ source "board/friendlyelec/cm3588-nas-rk3588/Kconfig"
>   source "board/friendlyelec/nanopc-t6-rk3588/Kconfig"
>   source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
>   source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
> +source "board/hardkernel/odroid_m2/Kconfig"
>   source "board/indiedroid/nova/Kconfig"
>   source "board/pine64/quartzpro64-rk3588/Kconfig"
>   source "board/turing/turing-rk1-rk3588/Kconfig"
> diff --git a/board/hardkernel/odroid_m2/Kconfig b/board/hardkernel/odroid_m2/Kconfig
> new file mode 100644
> index 000000000000..b537459c879d
> --- /dev/null
> +++ b/board/hardkernel/odroid_m2/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_ODROID_M2_RK3588S
> +
> +config SYS_BOARD
> +	default "odroid_m2"
> +
> +config SYS_VENDOR
> +	default "hardkernel"
> +
> +config SYS_CONFIG_NAME
> +	default "odroid_m2"
> +
> +endif
> diff --git a/board/hardkernel/odroid_m2/MAINTAINERS b/board/hardkernel/odroid_m2/MAINTAINERS
> new file mode 100644
> index 000000000000..13c0a8ba5b7a
> --- /dev/null
> +++ b/board/hardkernel/odroid_m2/MAINTAINERS
> @@ -0,0 +1,7 @@
> +ODROID-M2
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	board/hardkernel/odroid_m2/
> +F:	include/configs/odroid_m2.h
> +F:	configs/odroid-m2-rk3588s_defconfig
> +F:	arch/arm/dts/rk3588s-odroid-m2-u-boot.dtsi
> diff --git a/configs/odroid-m2-rk3588s_defconfig b/configs/odroid-m2-rk3588s_defconfig
> new file mode 100644
> index 000000000000..d612ef394c47
> --- /dev/null
> +++ b/configs/odroid-m2-rk3588s_defconfig
> @@ -0,0 +1,96 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-odroid-m2"
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_ODROID_M2_RK3588S=y
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-odroid-m2.dtb"
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
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_ROCKUSB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_INI=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_CRAMFS=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_IS_IN_MMC=y
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
> +CONFIG_PHY_REALTEK=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
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
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_USB_FUNCTION_ROCKUSB=y
> +CONFIG_FS_CRAMFS=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 43a62e8c3a71..571bcf494065 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -134,6 +134,7 @@ List of mainline supported Rockchip boards:
>        - FriendlyElec NanoPi R6C (nanopi-r6c-rk3588s)
>        - FriendlyElec NanoPi R6S (nanopi-r6s-rk3588s)
>        - Generic RK3588S/RK3588 (generic-rk3588)
> +     - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
>        - Indiedroid Nova (nova-rk3588s)
>        - Pine64 QuartzPro64 (quartzpro64-rk3588)
>        - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
> diff --git a/include/configs/odroid_m2.h b/include/configs/odroid_m2.h
> new file mode 100644
> index 000000000000..c5ed42cd2e72
> --- /dev/null
> +++ b/include/configs/odroid_m2.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +
> +#ifndef __ODROID_M2_H
> +#define __ODROID_M2_H
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +	"cramfsaddr=0x0c000000\0"
> +
> +#include <configs/rk3588_common.h>
> +
> +#endif
