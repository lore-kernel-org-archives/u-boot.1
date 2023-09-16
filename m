Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8897C2BA2B
	for <u-boot@archiver.kernel.org>; Sat, 16 Sep 2023 22:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EF578585E;
	Sun, 17 Sep 2023 00:51:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="o77CVpC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA3648585E; Sun, 17 Sep 2023 00:51:57 +0200 (CEST)
Received: from s.wrqvwxzv.outbound-mail.sendgrid.net
 (s.wrqvwxzv.outbound-mail.sendgrid.net [149.72.154.232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69F118556F
 for <u-boot@lists.denx.de>; Sun, 17 Sep 2023 00:51:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=mime-version:subject:references:from:in-reply-to:to:cc:content-type:
 content-transfer-encoding:cc:content-type:from:subject:to;
 s=s1; bh=g6aUicTojbH1Amwgbt1CPBFTisdNRc42Jyzz7el+xEg=;
 b=o77CVpC3CGP99m+fY78p2KpHU8bktAPTOlszQ0TkLvpBIkpXlgEtQNFQs5/vtqC9tHXU
 6PNfZVfvfMrcaycJ0GcfBeEdlIat6K7vfadh8mBEzVlKxbXYNi5W/uEu3iaYjGVSEbXe2d
 QgYH3+XdpJWyx05B9OjAdkKjuI6nY1PDJhCsoEHJQp2re3M/g3B5xtinDoQwbb3C30JQf6
 XMIS4CRTKBlE25SsSI5z5KfJ1Rkhiu6B2hRGTSj76SXzzye5lOb8sGE2e2lz11A3reJauT
 tkCLqCNoa0ql1RewSu/XsuYA91JU7mb+dlzD8J04Y2PLalvu7hEoCgSUX0X5LfDw==
Received: by filterdrecv-d7bbbc8bf-jd6t6 with SMTP id
 filterdrecv-d7bbbc8bf-jd6t6-1-65063189-11
 2023-09-16 22:51:53.896684201 +0000 UTC m=+121223.450778399
Received: from [192.168.1.50] (unknown) by geopod-ismtpd-0 (SG) with ESMTP
 id E4M_i7FVR42dhmkguYTCzA Sat, 16 Sep 2023 22:51:53.596 +0000 (UTC)
Message-ID: <dfcd6379-0efe-d335-d971-40302b291901@kwiboo.se>
Date: Sat, 16 Sep 2023 22:51:54 +0000 (UTC)
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3] board: rockchip: Add Bananapi R2Pro Board
Content-Language: en-US
References: <20230820160004.44880-1-linux@fw-web.de>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230820160004.44880-1-linux@fw-web.de>
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h9COyRGcZcbDZiOzP?=
 =?us-ascii?Q?ZXEmsnGq8e+DUxI1gxAPN4umGqgRSJthuXu7Nxr?=
 =?us-ascii?Q?uOBtvNEM38I2LLRXIYBwyJ57xNzLyxyq7+A1w5a?=
 =?us-ascii?Q?0OyJ12e8XGWiCJorbDBqptuxsiiJ1ftguWJcCBn?=
 =?us-ascii?Q?XJNFZCUUFm7dJYFBYmAu7PN1UtpP5FU8BU46bs?=
To: Frank Wunderlich <linux@fw-web.de>
Cc: Frank Wunderlich <frank-w@public-files.de>, Simon Glass
 <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, Kever Yang
 <kever.yang@rock-chips.com>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Type: text/plain; charset=us-ascii
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

Hi Frank,

On 2023-08-20 18:00, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add Bananapi R2 Pro board.
> 
> Till now evb dts could be used, but iodomain is different
> (evb has 1v8 on vccio2 and vccio4 which are 3v3 on r2pro)
> and with iodomain driver this can cause hardware fault.
> 
> Devicetree in mainline-Linux:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v3:
> - disable gmac0 as switch-driver is not yet ready to attach to the mac
> v2:
> - drop switch-node for now as u-boot driver works differently to linux
> ---
>  arch/arm/dts/Makefile                     |   3 +-
>  arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi |  23 +
>  arch/arm/dts/rk3568-bpi-r2pro.dts         | 549 ++++++++++++++++++++++
>  configs/bpi-r2pro-rk3568_defconfig        | 101 ++++
>  4 files changed, 675 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
>  create mode 100644 arch/arm/dts/rk3568-bpi-r2pro.dts
>  create mode 100644 configs/bpi-r2pro-rk3568_defconfig
> 
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index bd518064f35f..767bf9db39fb 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -182,7 +182,8 @@ dtb-$(CONFIG_ROCKCHIP_RK3568) += \
>  	rk3568-nanopi-r5s.dtb \
>  	rk3568-odroid-m1.dtb \
>  	rk3568-radxa-e25.dtb \
> -	rk3568-rock-3a.dtb
> +	rk3568-rock-3a.dtb \
> +	rk3568-bpi-r2pro.dtb
>  
>  dtb-$(CONFIG_ROCKCHIP_RK3588) += \
>  	rk3588-edgeble-neu6a-io.dtb \
> diff --git a/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi b/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
> new file mode 100644
> index 000000000000..382a52a28b10
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-bpi-r2pro-u-boot.dtsi
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2021 Rockchip Electronics Co., Ltd
> + */
> +
> +#include "rk356x-u-boot.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = &uart2;
> +		u-boot,spl-boot-order = "same-as-spl", &sdmmc0, &sdhci;

This is the default order in rk356x-u-boot.dtsi and can be dropped.

> +	};
> +};
> +
> +&sdmmc0 {
> +	status = "okay";

sdmmc0 is already enabled in rk3568-bpi-r2pro.dts

> +};
> +
> +&uart2 {
> +	clock-frequency = <24000000>;
> +	bootph-pre-ram;
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/rk3568-bpi-r2pro.dts b/arch/arm/dts/rk3568-bpi-r2pro.dts
> new file mode 100644
> index 000000000000..e4fcbb8a1174
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-bpi-r2pro.dts

Should be a 1:1 copy from kernel.

[...]

> diff --git a/configs/bpi-r2pro-rk3568_defconfig b/configs/bpi-r2pro-rk3568_defconfig
> new file mode 100644
> index 000000000000..e8936261eab3
> --- /dev/null
> +++ b/configs/bpi-r2pro-rk3568_defconfig
> @@ -0,0 +1,101 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_TEXT_BASE=0x00a00000
> +CONFIG_SPL_LIBCOMMON_SUPPORT=y
> +CONFIG_SPL_LIBGENERIC_SUPPORT=y
> +CONFIG_NR_DRAM_BANKS=2
> +CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> +CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc00000
> +CONFIG_DEFAULT_DEVICE_TREE="rk3568-bpi-r2pro"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_ROCKCHIP_COMMON_BOARD=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_SPL_STACK_R_ADDR=0x600000
> +CONFIG_SPL_STACK=0x400000
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +#CONFIG_OF_SYSTEM_SETUP=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-bpi-r2pro"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +CONFIG_SPL_PAD_TO=0x7f8000
> +CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> +CONFIG_SPL_BSS_START_ADDR=0x4000000
> +CONFIG_SPL_BSS_MAX_SIZE=0x4000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> +CONFIG_SPL_STACK_R=y
> +CONFIG_SPL_ATF=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_NET=n
> +CONFIG_OF_SPL_REMOVE_PROPS="pinctrl-0 pinctrl-names clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_ROCKCHIP_GPIO_V2=y

This Kconfig option does not exits.

> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_MISC=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_DW=y
> +CONFIG_MMC_DW_ROCKCHIP=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_ETH_DESIGNWARE=y
> +CONFIG_GMAC_ROCKCHIP=y

Please drop CONFIG_ETH_DESIGNWARE and CONFIG_GMAC_ROCKCHIP.

The following series that add GMAC support for RK3568 and RK3588 will
use DWC_ETH_QOS and DWC_ETH_QOS_ROCKCHIP Kconfig options.

rockchip: Add GMAC support for RK3568 and RK3588
https://patchwork.ozlabs.org/project/uboot/cover/20230807000817.1701012-1-jonas@kwiboo.se/

> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_REGULATOR_PWM=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_BAUDRATE=1500000
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_PSCI=y
> +CONFIG_ERRNO_STR=y
> +CONFIG_SYS_PROMPT="BPI-R2PRO> "
> +CONFIG_CMD_SYSBOOT=y
> +CONFIG_CMD_BOOTDEV=y
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_CMD_EFICONFIG=n
> +CONFIG_EFI_LOADER=n
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_XHCI_DWC3=y

This should not be enabled for rk3568, USB_DWC3_GENERIC provide usb
support.

> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_UHCI_HCD=y
> +CONFIG_USB_DWC2=y

There should not be any need to enable this driver on rk3568.

> +CONFIG_USB_DWC3=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_CMD_USB=y
> +CONFIG_AHCI=y
> +CONFIG_DWC_AHCI=y
> +CONFIG_SCSI=y
> +CONFIG_DM_SCSI=y
> +CONFIG_CMD_SCSI=y

Please run moveconfig.py to clean up and re-order the defconfig.

Regards,
Jonas
