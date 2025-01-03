Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE20E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 03:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D6BB800D7;
	Fri,  3 Jan 2025 04:24:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DMbU3zTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCD98007D; Fri,  3 Jan 2025 04:24:26 +0100 (CET)
Received: from mail-m32115.qiye.163.com (mail-m32115.qiye.163.com
 [220.197.32.115])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A5D08007D
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 04:24:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=rock-chips.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kever.yang@rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 791db170;
 Fri, 3 Jan 2025 11:24:16 +0800 (GMT+08:00)
Message-ID: <7c6bdb6f-e093-4572-973d-63c17059da41@rock-chips.com>
Date: Fri, 3 Jan 2025 11:24:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] board: rockchip: add Khadas Edge2 RK3588 board
To: Jacobe Zang <jacobe.zang@wesion.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, nick@khadas.com
References: <20241204-edge2-v2-1-1dc26b9209df@wesion.com>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <20241204-edge2-v2-1-1dc26b9209df@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1MGVZLGUgeGR8YTB1JSR1WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
 hVSktLVUpCS0tZBg++
X-HM-Tid: 0a942a3137b303afkunm791db170
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODI6MAw5QjIUHy1MEREOGjo1
 PglPCxRVSlVKTEhOQ0xPTU5MSE9LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
 EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0tITjcG
DKIM-Signature: a=rsa-sha256;
 b=DMbU3zTzp4WW0mS4Iq+ZEsijVsWOPKDcnV2U+IWOD1gasbxLbzs+dGWsQDkL+CQ/wywSNsYJX/GU1bRdjviI2RfMtqBlEc8NaCmWfrvtbE2KzC9enxWkLsIUNAOgebHrb6at2mcPXv44tQCD7uELKaG6CtQRFR4Ye9TYwT2BIig=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=oyIBxJaJl0kIyq4q+xdKxolLMKLnrCKHlYQxvq1Mv9c=;
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

Hi Jacobe,

On 2024/12/4 17:45, Jacobe Zang wrote:
> Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
> by Khadas.
>
> There are tree variants depending on the DRAM size : 8G and 16G.

So this is two instead of typo three, right?

I can correct it when apply if not other update is needed.

>
> Specification:
>
>      Rockchip RK3588S SoC
>      4x ARM Cortex-A76, 4x ARM Cortex-A55
>      8/16GB memory LPDDR4x
>      Mali G610MP4 GPU
>      3x MIPI CSI 4x lanes
>      2x MIPI-DSI DPHY 4x lanes
>      32/64GB eMMC
>      1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
>      1x HDMI 2.1 output, 1x DP 1.4 output
>      USB PD over USB Type-C
>
> Kernel commit:
> 04d552993522 ("arm64: dts: rockchip: Add Khadas edge2 board")
>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>

Thanks,
- Kever
> ---
> Add support for Khadas Edge2
> ---
> Changes in v2:
> - defconfig: Update defconfig made from upstream
> - Link to v1: https://lore.kernel.org/r/20241119-edge2-v1-1-b10c5d7626ca@wesion.com
> ---
>   arch/arm/mach-rockchip/rk3588/Kconfig         |  23 ++++
>   board/khadas/khadas-edge2-rk3588s/Kconfig     |  12 +++
>   board/khadas/khadas-edge2-rk3588s/MAINTAINERS |   6 ++
>   configs/khadas-edge2-rk3588s_defconfig        | 146 ++++++++++++++++++++++++++
>   doc/board/rockchip/rockchip.rst               |   1 +
>   include/configs/khadas-edge2-rk3588s.h        |  15 +++
>   6 files changed, 203 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
> index b5a0e624a53..7d817e7f1bd 100644
> --- a/arch/arm/mach-rockchip/rk3588/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3588/Kconfig
> @@ -74,6 +74,28 @@ config TARGET_JAGUAR_RK3588
>   	      - fan controller (AMC6821 emulation)
>   	    * 80-pin Mezzanine connector
>   
> +config TARGET_KHADAS_EDGE2_RK3588
> +	bool "Khadas Edge2 RK3588 board"
> +	select BOARD_LATE_INIT
> +	help
> +	  Khadas Edge2 is a Rockchip RK3588S based SBC (Single Board Computer)
> +	  by Khadas.
> +
> +	  There are tree variants depending on the DRAM size : 8G and 16G.
> +
> +	  Specification:
> +
> +	  Rockchip RK3588S SoC
> +	  4x ARM Cortex-A76, 4x ARM Cortex-A55
> +	  8/16GB memory LPDDR4x
> +	  Mali G610MP4 GPU
> +	  3x MIPI CSI 4x lanes
> +	  2x MIPI-DSI DPHY 4x lanes
> +	  32/64GB eMMC
> +	  1x USB 2.0, 1x USB 3.0, 2x USB-Type-C
> +	  1x HDMI 2.1 output, 1x DP 1.4 output
> +	  USB PD over USB Type-C
> +
>   config TARGET_NANOPCT6_RK3588
>   	bool "FriendlyElec NanoPC-T6 RK3588 board"
>   	select BOARD_LATE_INIT
> @@ -393,6 +415,7 @@ source "board/friendlyelec/nanopi-r6c-rk3588s/Kconfig"
>   source "board/friendlyelec/nanopi-r6s-rk3588s/Kconfig"
>   source "board/hardkernel/odroid_m2/Kconfig"
>   source "board/indiedroid/nova/Kconfig"
> +source "board/khadas/khadas-edge2-rk3588s/Kconfig"
>   source "board/pine64/quartzpro64-rk3588/Kconfig"
>   source "board/turing/turing-rk1-rk3588/Kconfig"
>   source "board/radxa/rock5a-rk3588s/Kconfig"
> diff --git a/board/khadas/khadas-edge2-rk3588s/Kconfig b/board/khadas/khadas-edge2-rk3588s/Kconfig
> new file mode 100644
> index 00000000000..dd7b6cd8054
> --- /dev/null
> +++ b/board/khadas/khadas-edge2-rk3588s/Kconfig
> @@ -0,0 +1,12 @@
> +if TARGET_KHADAS_EDGE2_RK3588
> +
> +config SYS_BOARD
> +	default "khadas-edge2-rk3588s"
> +
> +config SYS_VENDOR
> +	default "khadas"
> +
> +config SYS_CONFIG_NAME
> +	default "khadas-edge2-rk3588s"
> +
> +endif
> diff --git a/board/khadas/khadas-edge2-rk3588s/MAINTAINERS b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> new file mode 100644
> index 00000000000..3f16923b0f2
> --- /dev/null
> +++ b/board/khadas/khadas-edge2-rk3588s/MAINTAINERS
> @@ -0,0 +1,6 @@
> +KHADAS-EDGE2-RK3588S
> +M:	Jacobe Zang <jacobe.zang@wesion.com>
> +S:	Maintained
> +F:	configs/khadas-edge2-rk3588s_defconfig
> +F:	include/configs/khadas-edge2-rk3588s.h
> +F:	dts/upstream/src/arm64/rockchip/rk3588s-khadas-edge2.dts
> \ No newline at end of file
> diff --git a/configs/khadas-edge2-rk3588s_defconfig b/configs/khadas-edge2-rk3588s_defconfig
> new file mode 100644
> index 00000000000..bc9e8f39ec5
> --- /dev/null
> +++ b/configs/khadas-edge2-rk3588s_defconfig
> @@ -0,0 +1,146 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3588s-khadas-edge2"
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_SYS_MALLOC_F_LEN=0x80000
> +CONFIG_ROCKCHIP_RK3588=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_KHADAS_EDGE2_RK3588=y
> +CONFIG_DEBUG_UART_BASE=0xFEB50000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3588s-khadas-edge2.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_SEPARATE_BSS=y
> +CONFIG_SPL_MMC_WRITE=y
> +CONFIG_SPL_MTD_SUPPORT=y
> +CONFIG_SPL_ATF=y
> +CONFIG_SYS_PROMPT="kedge2# "
> +CONFIG_AUTOBOOT_KEYED=y
> +CONFIG_AUTOBOOT_PROMPT="Hit SPACE in %d seconds to stop autoboot\n"
> +CONFIG_AUTOBOOT_STOP_STR=" "
> +CONFIG_CMD_BOOTZ=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_SPI=y
> +CONFIG_SPL_SPI_SUPPORT=y
> +CONFIG_DM_SPI=y
> +# CONFIG_DM_SPI_FLASH=y
> +CONFIG_MMC=y
> +# CONFIG_MMC_SPI=y
> +CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_SPI=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_REGULATOR=y
> +CONFIG_CMD_TFTPPUT=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_REGMAP=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SYSCON=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_CLK=y
> +CONFIG_SPL_CLK=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
> +CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x1
> +CONFIG_FASTBOOT_BUF_ADDR=0xc00800
> +CONFIG_FASTBOOT_BUF_SIZE=0x07000000
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=0
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_I2C_MUX=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_SPL_MISC=y
> +CONFIG_ROCKCHIP_OTP=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_HS200_SUPPORT=y
> +CONFIG_MMC_HS400_SUPPORT=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_PHY_REALTEK=y
> +CONFIG_MTD=y
> +# CONFIG_NAND=y
> +# CONFIG_MTD_SPI_NAND=y
> +CONFIG_SF_DEFAULT_SPEED=80000000
> +CONFIG_SPI_FLASH_EON=y
> +CONFIG_SPI_FLASH_GIGADEVICE=y
> +CONFIG_SPI_FLASH_MACRONIX=y
> +CONFIG_SPI_FLASH_SST=y
> +CONFIG_SPI_FLASH_WINBOND=y
> +CONFIG_SPI_FLASH_XMC=y
> +CONFIG_SPI_FLASH_XTX=y
> +CONFIG_SPI_FLASH_MTD=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_GMAC_ROCKCHIP=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_USBDP=y
> +CONFIG_PINCTRL=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_TYPEC_TCPM=y
> +CONFIG_TYPEC_FUSB302=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_DM_REGULATOR_FIXED=y
> +CONFIG_DM_REGULATOR_GPIO=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_RAM=y
> +CONFIG_SPL_RAM=y
> +CONFIG_TPL_RAM=y
> +CONFIG_DM_RESET=y
> +CONFIG_SPL_DM_RESET=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_ROCKCHIP_SPI=y
> +CONFIG_ROCKCHIP_SFC=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_STORAGE=y
> +CONFIG_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="Rockchip"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x2207
> +CONFIG_USB_GADGET_PRODUCT_NUM=0x350a
> +CONFIG_USB_GADGET_DOWNLOAD=y
> +CONFIG_DISPLAY=y
> +CONFIG_USE_TINY_PRINTF=y
> +CONFIG_SPL_TINY_MEMSET=y
> +CONFIG_RSA=y
> +CONFIG_SPL_RSA=y
> +CONFIG_LZ4=y
> +CONFIG_LZMA=y
> +CONFIG_ERRNO_STR=y
> diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
> index 9bab86d2347..ea98b73d33c 100644
> --- a/doc/board/rockchip/rockchip.rst
> +++ b/doc/board/rockchip/rockchip.rst
> @@ -137,6 +137,7 @@ List of mainline supported Rockchip boards:
>        - Generic RK3588S/RK3588 (generic-rk3588)
>        - Hardkernel ODROID-M2 (odroid-m2-rk3588s)
>        - Indiedroid Nova (nova-rk3588s)
> +     - Khadas Edge2 (khadas-edge2-rk3588s)
>        - Pine64 QuartzPro64 (quartzpro64-rk3588)
>        - Radxa ROCK 5 ITX (rock-5-itx-rk3588)
>        - Radxa ROCK 5A (rock5a-rk3588s)
> diff --git a/include/configs/khadas-edge2-rk3588s.h b/include/configs/khadas-edge2-rk3588s.h
> new file mode 100644
> index 00000000000..d279cf3826a
> --- /dev/null
> +++ b/include/configs/khadas-edge2-rk3588s.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (c) 2024 Khadas Technology Co., Ltd.
> + */
> +
> +#ifndef __KHADAS_EDGE2_RK3588_H
> +#define __KHADAS_EDGE2_RK3588_H
> +
> +#include <configs/rk3588_common.h>
> +
> +#define ROCKCHIP_DEVICE_SETTINGS \
> +		"stdout=serial,vidconsole\0" \
> +		"stderr=serial,vidconsole\0"
> +
> +#endif /* __KHADAS_EDGE2_RK3588_H */
>
> ---
> base-commit: 3073246d1be682071d8b3d07d06c2484907aed60
> change-id: 20241119-edge2-18ac09a490ab
>
> Best regards,
