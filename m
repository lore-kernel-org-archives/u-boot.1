Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A29C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 08:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 791AD8763A;
	Sun, 29 Oct 2023 09:28:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=kernel-space.org header.i=@kernel-space.org header.b="VWawXbRj";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="K3Ui5KyQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F400C87668; Sun, 29 Oct 2023 09:28:17 +0100 (CET)
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F26875B9
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 09:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=kernel-space.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=angelo@kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
 by kernel-space.org (OpenSMTPD) with ESMTP id 197fc349;
 Sun, 29 Oct 2023 08:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; s=s1; bh=sY
 0oh84vOIygfktNQt5FxbKH0+M=; b=VWawXbRj+rCExE4c0AT0E2XKL23sLDQaGc
 JqhTmjj6+uz/9/IZsGvxQh/zk95yiEN9BA7K929B9fFa4A0zkf/y8H5rkjzoP/6Z
 dxmLhTo2rCaAoNaLJGFKpK06b60wfEupP/bzDpg6fqV8a+XXCA3MdT9uiI3zwg5C
 cOFiBhEbg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=
 message-id:date:mime-version:subject:to:cc:references:from
 :in-reply-to:content-type:content-transfer-encoding; q=dns; s=s1; b=
 P4kQmuqUmj5/lqxqBcK2LGyWlx71LwEQorx8qNo+a1TeIO5f0X6baWC1yWGWC309
 j7r+vmsyiOXsTYEKh1uTrSda2K5UeVH4o91AaUaLEA1vxyu4731fy2VpJRmiSEFx
 cKT70X//cs6bmwj0+1quWNIYc+sbWr/Fzf0Wsb+tZ0I=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
 s=s1; t=1698568102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YCA0WV9lzUpev3F2IuU/3Swmf9Yp0L7j5ngy4+LDvUg=;
 b=K3Ui5KyQO8fz1PIWt5h6KPO8jpiLnwPtgxlh7x0z5AIFAJBPMwmTVlzzZLVo/4O5hEeZNZ
 G6lMRVgewPm+rqEzAjXa6mgSfGvTz8aaedKxRv2QOGJcwN1xUVMtM6YaOmH4oL5JQXJwgR
 b0FsGkFdyq/G3hw8nCMZtYKUd/xXB5g=
Received: from [192.168.0.2] (host-87-9-235-250.retail.telecomitalia.it
 [87.9.235.250])
 by kernel-space.org (OpenSMTPD) with ESMTPSA id af6d2294
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Sun, 29 Oct 2023 08:28:22 +0000 (UTC)
Message-ID: <68e7a3ab-7383-7e03-d6e1-dca7d527c0f3@kernel-space.org>
Date: Sun, 29 Oct 2023 09:27:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH] Kconfig: Remove all default n/no options
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>
References: <e3bb5522913c8a917feb7d6309a693f7ee5dbe25.1698218728.git.michal.simek@amd.com>
From: Angelo Dureghello <angelo@kernel-space.org>
Content-Language: en-US
In-Reply-To: <e3bb5522913c8a917feb7d6309a693f7ee5dbe25.1698218728.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Michal,

thanks, built all m68k stuff, no issues.
Also tested on stmark2, all is ok.

Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>

On 25/10/23 9:25 AM, Michal Simek wrote:
> Similar change was done by commit b4c2c151b14b ("Kconfig: Remove all
> default n/no options") and again sync is required.
> 
> default n/no doesn't need to be specified. It is default option anyway.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-imx/mxs/Kconfig      | 2 --
>   arch/arm/mach-rockchip/Kconfig     | 1 -
>   arch/arm/mach-snapdragon/Kconfig   | 1 -
>   arch/arm/mach-sunxi/Kconfig        | 1 -
>   arch/arm/mach-tegra/Kconfig        | 1 -
>   arch/m68k/Kconfig                  | 1 -
>   arch/riscv/Kconfig                 | 1 -
>   board/asus/grouper/Kconfig         | 2 --
>   board/asus/transformer-t30/Kconfig | 1 -
>   board/keymile/Kconfig              | 3 ---
>   board/lg/x3-t30/Kconfig            | 2 --
>   cmd/Kconfig                        | 3 ---
>   drivers/crypto/fsl/Kconfig         | 1 -
>   drivers/memory/Kconfig             | 1 -
>   drivers/misc/Kconfig               | 1 -
>   drivers/mtd/nand/raw/Kconfig       | 1 -
>   drivers/mtd/spi/Kconfig            | 1 -
>   drivers/sm/Kconfig                 | 1 -
>   drivers/spi/Kconfig                | 1 -
>   drivers/usb/host/Kconfig           | 2 --
>   fs/ubifs/Kconfig                   | 1 -
>   21 files changed, 29 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mxs/Kconfig b/arch/arm/mach-imx/mxs/Kconfig
> index ccce6a78caa2..d2e4205c5ce5 100644
> --- a/arch/arm/mach-imx/mxs/Kconfig
> +++ b/arch/arm/mach-imx/mxs/Kconfig
> @@ -54,7 +54,6 @@ config SYS_SOC
>   
>   config SPL_MXS_PMU_MINIMAL_VDD5V_CURRENT
>   	bool "Force minimal current draw from VDD5V by MX28 PMU"
> -	default n
>   	help
>   	  After setting this option, the current drawn from VDD5V
>   	  by the PMU is reduced to zero - the DCDC_BATT is used as
> @@ -62,7 +61,6 @@ config SPL_MXS_PMU_MINIMAL_VDD5V_CURRENT
>   
>   config SPL_MXS_PMU_DISABLE_BATT_CHARGE
>   	bool "Disable Battery Charging in MX28 PMU"
> -	default n
>   
>   config SPL_MXS_PMU_ENABLE_4P2_LINEAR_REGULATOR
>   	bool "Enable the 4P2 linear regulator in MX28 PMU"
> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
> index c43c185c17c5..a6c69c300d00 100644
> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -450,7 +450,6 @@ config ROCKCHIP_BOOT_MODE_REG
>   config ROCKCHIP_RK8XX_DISABLE_BOOT_ON_POWERON
>   	bool "Disable device boot on power plug-in"
>   	depends on PMIC_RK8XX
> -	default n
>   	---help---
>   	  Say Y here to prevent the device from booting up because of a plug-in
>   	  event. When set, the device will boot briefly to determine why it was
> diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
> index 0e073045be54..2fc1521e2d30 100644
> --- a/arch/arm/mach-snapdragon/Kconfig
> +++ b/arch/arm/mach-snapdragon/Kconfig
> @@ -14,7 +14,6 @@ config SPL_SYS_MALLOC_F_LEN
>   
>   config SDM845
>   	bool "Qualcomm Snapdragon 845 SoC"
> -	default n
>   	select LINUX_KERNEL_IMAGE_HEADER
>   
>   config LNX_KRNL_IMG_TEXT_OFFSET_BASE
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index 40ca7d7b3a99..a10e4c06b6a3 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -811,7 +811,6 @@ config AXP_GPIO
>   config AXP_DISABLE_BOOT_ON_POWERON
>   	bool "Disable device boot on power plug-in"
>   	depends on AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER
> -	default n
>   	---help---
>   	  Say Y here to prevent the device from booting up because of a plug-in
>   	  event. When set, the device will boot into the SPL briefly to
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 464bd0798f62..0e94b84fe657 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -18,7 +18,6 @@ config TEGRA_CLKRST
>   config TEGRA_CRYPTO
>   	bool "Tegra AES128 crypto module"
>   	select AES
> -	default n
>   
>   config TEGRA_GP_PADCTRL
>   	bool
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 587edd50d7e8..b288c65e7fd1 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -200,7 +200,6 @@ source "board/sysam/stmark2/Kconfig"
>   
>   config M68K_QEMU
>   	bool "Build with workarounds for incomplete QEMU emulation"
> -	default n
>   	help
>   	  QEMU 8.x currently does not implement RAMBAR accesses and
>   	  DMA timers. Enable this option for U-Boot CI purposes only
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e291456530bd..8fc81fb284cd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -68,7 +68,6 @@ config SPL_SYS_DCACHE_OFF
>   config SPL_ZERO_MEM_BEFORE_USE
>   	bool "Zero memory before use"
>   	depends on SPL
> -	default n
>   	help
>   	  Zero stack/GD/malloc area in SPL before using them, this is needed for
>   	  Sifive core devices that uses L2 cache to store SPL.
> diff --git a/board/asus/grouper/Kconfig b/board/asus/grouper/Kconfig
> index 912c6c5fbae8..47d9bae94682 100644
> --- a/board/asus/grouper/Kconfig
> +++ b/board/asus/grouper/Kconfig
> @@ -12,11 +12,9 @@ config SYS_CONFIG_NAME
>   config GROUPER_TPS65911
>   	bool "Enable support TI TPS65911 PMIC"
>   	select CMD_POWEROFF
> -	default n
>   
>   config GROUPER_MAX77663
>   	bool "Enable support MAXIM MAX77663 PMIC"
>   	select CMD_POWEROFF
> -	default n
>   
>   endif
> diff --git a/board/asus/transformer-t30/Kconfig b/board/asus/transformer-t30/Kconfig
> index 3c36f4ada206..accc999c435c 100644
> --- a/board/asus/transformer-t30/Kconfig
> +++ b/board/asus/transformer-t30/Kconfig
> @@ -14,7 +14,6 @@ config TRANSFORMER_SPI_BOOT
>   	select TEGRA20_SLINK
>   	select DM_SPI_FLASH
>   	select SPI_FLASH_WINBOND
> -	default n
>   	help
>   	  Tegra 3 based Transformers with Windows RT have core
>   	  boot sequence (BCT and EBT) on separate SPI FLASH
> diff --git a/board/keymile/Kconfig b/board/keymile/Kconfig
> index c6576aa6523a..f7e9b74f5782 100644
> --- a/board/keymile/Kconfig
> +++ b/board/keymile/Kconfig
> @@ -125,7 +125,6 @@ config SYS_IVM_EEPROM_PAGE_LEN
>   config PG_WCOM_UBOOT_UPDATE_SUPPORTED
>   	bool "Enable U-Boot Field Fail-Safe Update Functionality"
>   	select EVENT
> -	default n
>   	help
>   	  Indicates that field fail-safe u-boot update is supported.
>   	  This functionality works only for designs that are booting
> @@ -133,7 +132,6 @@ config PG_WCOM_UBOOT_UPDATE_SUPPORTED
>   
>   config PG_WCOM_UBOOT_BOOTPACKAGE
>   	bool "U-Boot Is Part Of Factory Boot-Package Image"
> -	default n
>   	help
>   	  Indicates that u-boot will be a part of the factory programmed
>   	  boot-package image.
> @@ -149,7 +147,6 @@ config PG_WCOM_UBOOT_UPDATE_TEXT_BASE
>   
>   config PG_WCOM_UBOOT_UPDATE
>   	bool "U-Boot Is Part Of Factory Boot-Package Image"
> -	default n
>   	help
>   	  Indicates that u-boot will be a part of the embedded software and
>   	  programmed at field.
> diff --git a/board/lg/x3-t30/Kconfig b/board/lg/x3-t30/Kconfig
> index 20ea4f5f3243..53d776019d65 100644
> --- a/board/lg/x3-t30/Kconfig
> +++ b/board/lg/x3-t30/Kconfig
> @@ -11,14 +11,12 @@ config SYS_CONFIG_NAME
>   
>   config DEVICE_P880
>   	bool "Enable support for LG Optimus 4X HD"
> -	default n
>   	help
>   	  LG Optimus 4X HD derives from x3 board but has slight
>   	  differences.
>   
>   config DEVICE_P895
>   	bool "Enable support for LG Optimus Vu"
> -	default n
>   	help
>   	  LG Optimus Vu derives from x3 board but has slight
>   	  differences.
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 205df2f1fb65..60aed2c307ca 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -246,7 +246,6 @@ config CMD_BOOTM_PRE_LOAD
>          bool "enable pre-load on bootm"
>          depends on CMD_BOOTM
>          depends on IMAGE_PRE_LOAD
> -       default n
>          help
>            Enable support of stage pre-load for the bootm command.
>   	 This stage allow to check or modify the image provided
> @@ -2360,7 +2359,6 @@ config CMD_VIDCONSOLE
>   config CMD_SELECT_FONT
>   	bool "select font size"
>   	depends on VIDEO
> -	default n
>   	help
>   	  Enabling this will provide 'font' command.
>   	  Allows font selection at runtime.
> @@ -2880,7 +2878,6 @@ config CMD_UBIFS
>   config MMC_SPEED_MODE_SET
>   	bool "set speed mode using mmc command"
>   	depends on CMD_MMC
> -	default n
>   	help
>   	  Enable setting speed mode using mmc rescan and mmc dev commands.
>   	  The speed mode is provided as the last argument in these commands
> diff --git a/drivers/crypto/fsl/Kconfig b/drivers/crypto/fsl/Kconfig
> index 91a51cc5fe77..eaad19633f1d 100644
> --- a/drivers/crypto/fsl/Kconfig
> +++ b/drivers/crypto/fsl/Kconfig
> @@ -77,7 +77,6 @@ endif
>   config FSL_DCP_RNG
>   	bool "Enable Random Number Generator support"
>   	depends on DM_RNG
> -	default n
>   	help
>   	  Enable support for the hardware based random number generator
>   	  module of the DCP. It uses the True Random Number Generator (TRNG)
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 22cb9d637c5e..d10edd277467 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -61,7 +61,6 @@ config TI_GPMC
>   if TI_GPMC
>   config TI_GPMC_DEBUG
>   	bool "Debug Texas Instruments GPMC timings"
> -	default n
>   	help
>   	  Enable this to print GPMC timings before and after the GPMC registers
>   	  are programmed. This should not be left enabled on production systems.
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index fccd9b89b81b..97057de8bf92 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -375,7 +375,6 @@ config SPL_MXC_OCOTP
>   config NPCM_OTP
>   	bool "Nnvoton NPCM BMC On-Chip OTP Memory Support"
>   	depends on (ARM && ARCH_NPCM)
> -	default n
>   	help
>   	  Support NPCM BMC OTP memory (fuse).
>   	  To compile this driver as a module, choose M here: the module
> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
> index 72547f00fbec..a13e6f59cbd2 100644
> --- a/drivers/mtd/nand/raw/Kconfig
> +++ b/drivers/mtd/nand/raw/Kconfig
> @@ -614,7 +614,6 @@ config ROCKCHIP_NAND
>   config ROCKCHIP_NAND_SKIP_BBTSCAN
>   	bool "Skip the automatic BBT scan with Rockchip NAND controllers"
>   	depends on ROCKCHIP_NAND
> -	default n
>   	help
>   	  Skip the automatic BBT scan with the NAND_SKIP_BBTSCAN
>   	  option when data content is not in MTD format or
> diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
> index a9617c6c58c1..76c424d75e9e 100644
> --- a/drivers/mtd/spi/Kconfig
> +++ b/drivers/mtd/spi/Kconfig
> @@ -107,7 +107,6 @@ config SPI_FLASH_SMART_HWCAPS
>   
>   config SPI_NOR_BOOT_SOFT_RESET_EXT_INVERT
>   	bool "Command extension type is INVERT for Software Reset on boot"
> -	default n
>   	help
>   	 Because of SFDP information can not be get before boot.
>   	 So define command extension type is INVERT when Software Reset on boot only.
> diff --git a/drivers/sm/Kconfig b/drivers/sm/Kconfig
> index f0987275d265..926af2863308 100644
> --- a/drivers/sm/Kconfig
> +++ b/drivers/sm/Kconfig
> @@ -4,6 +4,5 @@ config SM
>   config MESON_SM
>   	bool "Amlogic Secure Monitor driver"
>   	select SM
> -	default n
>   	help
>   	  Say y here to enable the Amlogic secure monitor driver.
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 854b8b88daff..d1867c28758a 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -451,7 +451,6 @@ config SANDBOX_SPI_MAX_CS
>   config SPI_ASPEED_SMC
>   	bool "ASPEED SPI flash controller driver"
>   	depends on DM_SPI && SPI_MEM
> -	default n
>   	help
>   	  Enable ASPEED SPI flash controller driver for AST2500
>   	  and AST2600 SoCs.
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 1a883babf4c2..b501ea514bca 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -231,7 +231,6 @@ config USB_EHCI_MXS
>   config USB_EHCI_NPCM
>   	bool "Support for Nuvoton NPCM on-chip EHCI USB controller"
>   	depends on ARCH_NPCM
> -	default n
>   	---help---
>   	  Enables support for the on-chip EHCI controller on
>   	  Nuvoton NPCM chips.
> @@ -368,7 +367,6 @@ config USB_OHCI_DA8XX
>   config USB_OHCI_NPCM
>   	bool "Support for Nuvoton NPCM on-chip OHCI USB controller"
>   	depends on ARCH_NPCM
> -	default n
>   	---help---
>   	  Enables support for the on-chip OHCI controller on
>   	  Nuvoton NPCM chips.
> diff --git a/fs/ubifs/Kconfig b/fs/ubifs/Kconfig
> index 949b28841194..690e77ef8dcf 100644
> --- a/fs/ubifs/Kconfig
> +++ b/fs/ubifs/Kconfig
> @@ -8,7 +8,6 @@ config UBIFS_SILENCE_MSG
>   config UBIFS_SILENCE_DEBUG_DUMP
>   	bool "UBIFS silence debug dumps"
>   	default y if UBIFS_SILENCE_MSG
> -	default n
>   	help
>   	  Make the debug dumps from UBIFS stop printing.
>   	  This decreases size of U-Boot binary.

-- 
Angelo Dureghello
w: www.kernel-space.org
e: angelo@kernel-space.org
