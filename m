Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802A4D3C934
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 01:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAE8F891FE;
	Mon, 21 Oct 2024 03:31:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="ebynizZs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 189B8891E7; Mon, 21 Oct 2024 03:31:42 +0200 (CEST)
Received: from mail-m15579.qiye.163.com (mail-m15579.qiye.163.com
 [101.71.155.79])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7713B88F8E
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 03:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
DKIM-Signature: a=rsa-sha256;
 b=ebynizZsfxdPQ+q/Gpx+puKKR1UqrrPGKzyuLVx6oFXGN2M9VshUrTmxQ3feH6zt/il6xAOOT1lD4J7ySNmeESdK/W2DeSEBxFhaMRJct0AskSMfJmPbkIrW98PP9Qqvys/KO2VP4d7jArUxn/u3JfpgtLeFg9pAraa5ANu+qII=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=W9xhg6p5nCBxipzjytxAuO88lAyfUk3X20N8HJz4v+s=;
 h=date:mime-version:subject:message-id:from;
Received: from yk?rock-chips.com
 (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with SMTP id EF0435201B7;
 Mon, 21 Oct 2024 09:31:23 +0800 (CST)
Message-ID: <47c6150a-05bd-46d4-b627-6446701acb81@rock-chips.com>
Date: Mon, 21 Oct 2024 09:31:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH 3/3] board: rockchip: Add Hardkernel ODROID-M1S
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20241003194101.328231-1-jonas@kwiboo.se>
 <20241003194101.328231-4-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20241003194101.328231-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQkgaSlZITkoYSBpIQktKThlWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a92acb34db503afkunmef0435201b7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSI6Lio4ETIYOSg0KU9RTwMV
 NkwKCg9VSlVKTElCT0xPSUNOQklIVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFDS0NLNwY+
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


On 2024/10/4 03:40, Jonas Karlman wrote:
> The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
> RK3566 SoC. It features e.g. 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-card,
> GbE LAN, HDMI 2.0, M.2 NVMe and USB 2.0/3.0.
>
> Features tested on a ODROID-M1S 8GB rev1.0 20230906:
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
>   arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi |  3 +
>   arch/arm/mach-rockchip/rk3568/Kconfig      |  6 ++
>   board/hardkernel/odroid_m1s/Kconfig        | 12 +++
>   board/hardkernel/odroid_m1s/MAINTAINERS    |  6 ++
>   configs/odroid-m1s-rk3566_defconfig        | 93 ++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst            |  1 +
>   6 files changed, 121 insertions(+)
>   create mode 100644 arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
>   create mode 100644 board/hardkernel/odroid_m1s/Kconfig
>   create mode 100644 board/hardkernel/odroid_m1s/MAINTAINERS
>   create mode 100644 configs/odroid-m1s-rk3566_defconfig
>
> diff --git a/arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi b/arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
> new file mode 100644
> index 000000000000..6e8307e3bdf6
> --- /dev/null
> +++ b/arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
> @@ -0,0 +1,3 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +
> +#include "rk356x-u-boot.dtsi"
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index bdbca2fa9d90..5aa71d558cc0 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -22,6 +22,11 @@ config TARGET_ODROID_M1_RK3568
>   	help
>   	  Hardkernel ODROID-M1 single board computer with a RK3568B2 SoC.
>   
> +config TARGET_ODROID_M1S_RK3566
> +	bool "ODROID-M1S"
> +	help
> +	  Hardkernel ODROID-M1S single board computer with a RK3566 SoC.
> +
>   config TARGET_PINENOTE_RK3566
>   	bool "Pinenote"
>   	help
> @@ -68,6 +73,7 @@ config TEXT_BASE
>   source "board/rockchip/evb_rk3568/Kconfig"
>   source "board/anbernic/rgxx3_rk3566/Kconfig"
>   source "board/hardkernel/odroid_m1/Kconfig"
> +source "board/hardkernel/odroid_m1s/Kconfig"
>   source "board/pine64/pinenote-rk3566/Kconfig"
>   source "board/pine64/quartz64_rk3566/Kconfig"
>   source "board/powkiddy/x55/Kconfig"
> diff --git a/board/hardkernel/odroid_m1s/Kconfig b/board/hardkernel/odroid_m1s/Kconfig
> new file mode 100644
> index 000000000000..5e0d2ca6d08b
> --- /dev/null
> +++ b/board/hardkernel/odroid_m1s/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_ODROID_M1S_RK3566
> +
> +config SYS_BOARD
> +	default "odroid_m1s"
> +
> +config SYS_VENDOR
> +	default "hardkernel"
> +
> +config SYS_CONFIG_NAME
> +	default "odroid_m1"
> +
> +endif
> diff --git a/board/hardkernel/odroid_m1s/MAINTAINERS b/board/hardkernel/odroid_m1s/MAINTAINERS
> new file mode 100644
> index 000000000000..0c8d11249bff
> --- /dev/null
> +++ b/board/hardkernel/odroid_m1s/MAINTAINERS
> @@ -0,0 +1,6 @@
> +ODROID-M1S
> +M:	Jonas Karlman <jonas@kwiboo.se>
> +S:	Maintained
> +F:	board/hardkernel/odroid_m1s/
> +F:	configs/odroid-m1s-rk3566_defconfig
> +F:	arch/arm/dts/rk3566-odroid-m1s-u-boot.dtsi
> diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-rk3566_defconfig
> new file mode 100644
> index 000000000000..21f4fcb9d7be
> --- /dev/null
> +++ b/configs/odroid-m1s-rk3566_defconfig
> @@ -0,0 +1,93 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3566-odroid-m1s"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_ODROID_M1S_RK3566=y
> +CONFIG_DEBUG_UART_BASE=0xFE660000
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
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3566-odroid-m1s.dtb"
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
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
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
> index 438a6a98261c..43a62e8c3a71 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -98,6 +98,7 @@ List of mainline supported Rockchip boards:
>   
>   * rk3566
>        - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
> +     - Hardkernel ODROID-M1S (odroid-m1s-rk3566)
>        - Pine64 PineNote (pinenote-rk3566)
>        - Pine64 PineTab2 (pinetab2-rk3566)
>        - Pine64 Quartz64-A Board (quartz64-a-rk3566)
