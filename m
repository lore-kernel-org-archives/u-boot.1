Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645F2C38150
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 06:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6083886A8;
	Wed, 10 Jul 2024 08:26:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1720592779;
	bh=L913Ly8+DIN9H4jgYivcoEUJpb6tJcpqldNE9D6vB9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tbfFwBZcDcsDe1MMBK06etZtQ/vB6py//UlPAUuHud3+IZU3lm78BRZtn5dAdqIGq
	 UVMbH9y0r77QZ9f00IgA+N4pngr7GRtc4gKDeZSzZef9QNS9t7gjD4MUq10QpMzG/g
	 hEjcfcsokTA6fP59x6B96vIOeDCXRIxjLKyXCpsG37Qnwh1bWGy/FbCgo5NYnpTISz
	 /KY3cr8oTtE9yl+e0iTd6747rsllZdgx/xf7ao9EVftyc7Lc9fxRukpJToYoQ2bHsU
	 mG+HhRCtzhpzO1+sMismZBJz1MP64bybFf+HQrcjatAZxL9uV+DzEciA9Opypm4Zmd
	 LmoRFpwwONnzw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8270B886EB; Wed, 10 Jul 2024 08:26:18 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D45388680
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 08:26:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4WJntb6WfLz9sqK;
 Wed, 10 Jul 2024 08:26:15 +0200 (CEST)
Message-ID: <1866ab7f-eee5-4ae9-b679-70f0d431499f@denx.de>
Date: Wed, 10 Jul 2024 08:26:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] arm: mvebu: Enable bootstd and other modernization for
 Synology DS414 (Armada XP) board
Content-Language: en-US
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>, Phil Sutter <phil@nwl.cc>
Cc: Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20240708043904.5100-1-mibodhi@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20240708043904.5100-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 7/8/24 06:39, Tony Dinh wrote:
> - Switch to standard boot (in include/configs/ds414.h and
> configs/ds414_defconfig)
> - Implement board_late_init() to ensure successful enumeration
> of USB3 devices
> - Remove unnecessary checkboard()
> - Updated IDENT_STRING to indicate this u-boot supports both Synology
> DS414 and DS214+ boards
> - Add SYS_THUMB_BUILD to reduce binary size
> - Add NET_RANDOM_ETHADDR
> - Add CONFIG_LBA48 and CONFIG_SYS_64BIT_LBA to support >2TB HDD/SDD
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

@Phil, is this ready to be merged from your point of view as well?

Thanks,
Stefan

> ---
> 
> Changes in v3:
> - Restore misc_init_r() to support booting legacy FW.
> - Correct scripting error in EXTRA_ENV_SETTINGS_LEGACY in
> /include/configs/ds414.h
> - Remove CONFIG_PHY_ANEG_TIMEOUT from /include/configs/ds414.h. This symbol
> has been moved to Kconfig.
> 
> Changes in v2:
> - Define EXTRA_ENV_SETTINGS_LEGACY to restore default envs support for
> booting legacy FW.
> 
>   board/Synology/ds414/ds414.c | 14 ++++----
>   configs/ds414_defconfig      | 19 +++++------
>   include/configs/ds414.h      | 65 +++++++++++++++++++++++++-----------
>   3 files changed, 61 insertions(+), 37 deletions(-)
> 
> diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.c
> index 8db810ad3e..1a4cea87e1 100644
> --- a/board/Synology/ds414/ds414.c
> +++ b/board/Synology/ds414/ds414.c
> @@ -180,6 +180,13 @@ int board_init(void)
>   	return 0;
>   }
>   
> +int board_late_init(void)
> +{
> +	/* Do late init to ensure successful enumeration of XHCI devices */
> +	pci_init();
> +	return 0;
> +}
> +
>   int misc_init_r(void)
>   {
>   	if (!env_get("ethaddr")) {
> @@ -188,10 +195,3 @@ int misc_init_r(void)
>   	}
>   	return 0;
>   }
> -
> -int checkboard(void)
> -{
> -	puts("Board: DS414\n");
> -
> -	return 0;
> -}
> diff --git a/configs/ds414_defconfig b/configs/ds414_defconfig
> index 18c741d4f2..6391c43474 100644
> --- a/configs/ds414_defconfig
> +++ b/configs/ds414_defconfig
> @@ -1,5 +1,6 @@
>   CONFIG_ARM=y
>   CONFIG_ARCH_CPU_INIT=y
> +CONFIG_SYS_THUMB_BUILD=y
>   CONFIG_ARCH_MVEBU=y
>   CONFIG_SUPPORT_PASSING_ATAGS=y
>   CONFIG_CMDLINE_TAG=y
> @@ -25,44 +26,41 @@ CONFIG_SPL_BSS_MAX_SIZE=0x4000
>   CONFIG_SPL=y
>   CONFIG_DEBUG_UART_BASE=0xf1012000
>   CONFIG_DEBUG_UART_CLOCK=250000000
> +CONFIG_IDENT_STRING="\nSynology DS214+/DS414 2/4-Bay Diskstation"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_PCI=y
>   CONFIG_DEBUG_UART=y
> +CONFIG_BOOTSTD_FULL=y
>   CONFIG_BOOTDELAY=3
>   CONFIG_USE_BOOTARGS=y
> -CONFIG_BOOTARGS="console=ttyS0,115200 ip=off initrd=0x8000040,8M root=/dev/md0 rw syno_hw_version=DS414r1 ihd_num=4 netif_num=2 flash_size=8 SataLedSpecial=1 HddHotplug=1"
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="sf probe; sf read ${loadaddr} 0xd0000 0x2d0000; sf read ${ramdisk_addr_r} 0x3a0000 0x430000; bootm ${loadaddr} ${ramdisk_addr_r}"
>   # CONFIG_DISPLAY_BOARDINFO is not set
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_BOARD_LATE_INIT=y
>   CONFIG_MISC_INIT_R=y
>   CONFIG_SPL_MAX_SIZE=0x1bfd0
>   CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>   CONFIG_SPL_I2C=y
> +CONFIG_SYS_PROMPT="DS414> "
>   CONFIG_SYS_MAXARGS=32
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_PCI=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
> -# CONFIG_CMD_SETEXPR is not set
> -CONFIG_CMD_DHCP=y
>   CONFIG_CMD_TFTPPUT=y
> -CONFIG_CMD_MII=y
> -CONFIG_CMD_PING=y
>   CONFIG_CMD_TIME=y
> -CONFIG_CMD_EXT2=y
> -CONFIG_CMD_FAT=y
>   CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_CMD_UBI=y
> -CONFIG_ISO_PARTITION=y
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_SPI_MAX_HZ=50000000
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_ARP_TIMEOUT=200
>   CONFIG_NET_RETRY_COUNT=50
> +CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SPL_OF_TRANSLATE=y
> +CONFIG_LBA48=y
> +CONFIG_SYS_64BIT_LBA=y
>   CONFIG_DM_I2C=y
>   CONFIG_SYS_I2C_MVTWSI=y
>   # CONFIG_MMC is not set
> @@ -84,4 +82,3 @@ CONFIG_USB_XHCI_HCD=y
>   # CONFIG_USB_XHCI_MVEBU is not set
>   CONFIG_USB_XHCI_PCI=y
>   CONFIG_USB_EHCI_HCD=y
> -CONFIG_USB_STORAGE=y
> diff --git a/include/configs/ds414.h b/include/configs/ds414.h
> index 6fbcec0898..9525657558 100644
> --- a/include/configs/ds414.h
> +++ b/include/configs/ds414.h
> @@ -1,5 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
>   /*
> + * Copyright (C) 2024 Tony Dinh <mibodhi@gmail.com>
>    * Copyright (C) 2014 Stefan Roese <sr@denx.de>
>    */
>   
> @@ -16,15 +17,8 @@
>    * U-Boot into it.
>    */
>   
> -/* I2C */
>   #define CFG_I2C_MVTWSI_BASE0		MVEBU_TWSI_BASE
>   
> -/*
> - * mv-common.h should be defined after CMD configs since it used them
> - * to enable certain macros
> - */
> -#include "mv-common.h"
> -
>   /*
>    * Memory layout while starting into the bin_hdr via the
>    * BootROM:
> @@ -38,21 +32,54 @@
>    * L2 cache thus cannot be used.
>    */
>   
> -/* SPL */
> -/* Defines for SPL */
> +/* Keep device tree and initrd in lower memory so the kernel can access them */
> +#define RELOCATION_LIMITS_ENV_SETTINGS  \
> +	"fdt_high=0x10000000\0"         \
> +	"initrd_high=0x10000000\0"
>   
> -/* Default Environment */
> +/*
> + * mv-common.h should be defined after CMD configs since it used them
> + * to enable certain macros
> + */
> +#include "mv-common.h"
> +
> +#ifndef CONFIG_SPL_BUILD
>   
> -#define CFG_EXTRA_ENV_SETTINGS				\
> -	"initrd_high=0xffffffff\0"				\
> -	"ramdisk_addr_r=0x8000000\0"				\
> -	"usb0Mode=host\0usb1Mode=host\0usb2Mode=device\0"	\
> -	"ethmtu=1500\0eth1mtu=1500\0"				\
> -	"update_uboot=sf probe; dhcp; "				\
> -		"mw.b ${loadaddr} 0x0 0xd0000; "		\
> -		"tftpboot ${loadaddr} u-boot-with-spl.kwb; "	\
> +#define KERNEL_ADDR_R	__stringify(0x1000000)
> +#define FDT_ADDR_R	__stringify(0x2000000)
> +#define RAMDISK_ADDR_R	__stringify(0x2200000)
> +#define SCRIPT_ADDR_R	__stringify(0x1800000)
> +#define PXEFILE_ADDR_R	__stringify(0x1900000)
> +
> +#define EXTRA_ENV_SETTINGS_LEGACY \
> +	"bootargs_legacy=console=ttyS0,115200 ip=off initrd=0x8000040,8M " \
> +		"root=/dev/md0 rw syno_hw_version=DS414r1 ihd_num=4 netif_num=2 " \
> +		"flash_size=8 SataLedSpecial=1 HddHotplug=1\0" \
> +	"bootcmd_legacy=sf probe; sf read ${loadaddr} 0xd0000 0x2d0000; " \
> +		"sf read ${ramdisk_addr_r} 0x3a0000 0x430000; " \
> +		"setenv bootargs $bootargs_legacy; " \
> +		"bootm ${loadaddr} ${ramdisk_addr_r}\0"	\
> +	"usb0Mode=host\0usb1Mode=host\0usb2Mode=device\0" \
> +	"ethmtu=1500\0eth1mtu=1500\0" \
> +	"update_uboot=sf probe; dhcp; "	\
> +		"mw.b ${loadaddr} 0x0 0xd0000; " \
> +		"tftpboot ${loadaddr} u-boot-with-spl.kwb; " \
>   		"sf update ${loadaddr} 0x0 0xd0000\0"
>   
> -/* increase autoneg timeout, my NIC sucks */
> +#define LOAD_ADDRESS_ENV_SETTINGS \
> +	"kernel_addr_r=" KERNEL_ADDR_R "\0" \
> +	"fdt_addr_r=" FDT_ADDR_R "\0" \
> +	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
> +	"scriptaddr=" SCRIPT_ADDR_R "\0" \
> +	"pxefile_addr_r=" PXEFILE_ADDR_R "\0"
> +
> +#define CFG_EXTRA_ENV_SETTINGS \
> +	RELOCATION_LIMITS_ENV_SETTINGS \
> +	LOAD_ADDRESS_ENV_SETTINGS \
> +	EXTRA_ENV_SETTINGS_LEGACY \
> +	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
> +	"console=ttyS0,115200\0"
> +
> +#endif /* CONFIG_SPL_BUILD */
>   
>   #endif /* _CONFIG_SYNOLOGY_DS414_H */

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
