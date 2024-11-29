Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEB7D6EBED
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 08:22:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC97B89382;
	Fri, 29 Nov 2024 09:22:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732868562;
	bh=Hrf+e098NbOcnd7aqDn/bYYkgFyGjGxucqhgwV0J8Es=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tjn85yqRHjwg45rvLZtsIWFQ4+T4HYIJLgzNQ5dxHj7l48XE7Srsg25V9ohTtU8Gg
	 Olr23SqHONeKB5jyVizJHOAeA1PWTln5FG2BjCwscPh+6bO+Bc2OErTrnfvtKnX5yw
	 TJtkewgSKE2pqB1zpF3lrtB/1j0K9f51BO6gWbw8k1FUOSRvO9EdyTLBAQm3rHgWg2
	 CSsHciJBF4UaC9yPzbWSRLFCEwAE5CqMw5kpO9auP3jFBOA8F4tdGDVrG19MIZnepe
	 2GI4Rq6MmZtCX2eI2lk8bgYYLIBV/69LDwAsTcEAQceRis7M/UJP2voTkx6zUp+mg8
	 loTBce9Tox7yQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F05B0893B3; Fri, 29 Nov 2024 09:22:41 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FE108937E
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 09:22:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Y05lK1X5zz9spG;
 Fri, 29 Nov 2024 09:22:37 +0100 (CET)
Message-ID: <c8fa63d9-65f7-4807-9aa3-d5e76a2fb5e3@denx.de>
Date: Fri, 29 Nov 2024 09:22:36 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] arm: kirkwood: Enable bootstd and other modernization for
 OpenRD boards
To: Tony Dinh <mibodhi@gmail.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20241127005716.6234-1-mibodhi@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241127005716.6234-1-mibodhi@gmail.com>
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

On 27.11.24 01:57, Tony Dinh wrote:
> Enable bootstd for OpenRD boards
> Update defconfigs to the latest u-boot requirements
> Remove JFFS2 support. See JFFS2 Vulnerability[1].
> Move default envs to text-base environment
> 
> [1] https://lore.kernel.org/u-boot/20241114233005.GN3600562@bill-the-cat/T/#m2fc25da1d2c019bc3cd8676991fdd64b8a21aa9b
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   arch/arm/mach-kirkwood/Kconfig    |  1 +
>   board/Marvell/openrd/openrd.env   | 20 ++++++++++++++++++++
>   configs/openrd_base_defconfig     | 18 +++++-------------
>   configs/openrd_client_defconfig   | 18 +++++-------------
>   configs/openrd_ultimate_defconfig | 18 +++++-------------
>   include/configs/openrd.h          | 18 ------------------
>   6 files changed, 36 insertions(+), 57 deletions(-)
>   create mode 100644 board/Marvell/openrd/openrd.env
> 
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 031d4e5ecd..6761a9cb39 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -38,6 +38,7 @@ config TARGET_OPENRD
>   	bool "Marvell OpenRD Board"
>   	select KW88F6281
>   	select SHEEVA_88SV131
> +	select KIRKWOOD_COMMON
>   
>   config TARGET_DREAMPLUG
>   	bool "DreamPlug Board"
> diff --git a/board/Marvell/openrd/openrd.env b/board/Marvell/openrd/openrd.env
> new file mode 100644
> index 0000000000..70ca704b73
> --- /dev/null
> +++ b/board/Marvell/openrd/openrd.env
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2024 Tony Dinh <mibodhi@gmail.com>
> + *
> + *  Environment variables configurations
> + */
> +
> +kernel_addr_r=0x800000
> +fdt_addr_r=0x2c00000
> +ramdisk_addr_r=0x01100000
> +scriptaddr=0x200000
> +fdtfile=CONFIG_DEFAULT_DEVICE_TREE.dtb
> +mtdparts=CONFIG_MTDPARTS_DEFAULT
> +console=ttyS0,115200
> +
> +/* Standard Boot */
> +bootcmd=
> +	bootflow scan -lb
> +failed=
> +	echo CONFIG_SYS_BOARD boot failed - please check your image
> diff --git a/configs/openrd_base_defconfig b/configs/openrd_base_defconfig
> index 708bf5eefd..1ca0b45d93 100644
> --- a/configs/openrd_base_defconfig
> +++ b/configs/openrd_base_defconfig
> @@ -4,22 +4,22 @@ CONFIG_SYS_DCACHE_OFF=y
>   CONFIG_ARCH_CPU_INIT=y
>   CONFIG_SYS_THUMB_BUILD=y
>   CONFIG_ARCH_KIRKWOOD=y
> +CONFIG_SUPPORT_PASSING_ATAGS=y
> +CONFIG_CMDLINE_TAG=y
> +CONFIG_INITRD_TAG=y
>   CONFIG_SYS_KWD_CONFIG="board/Marvell/openrd/kwbimage.cfg"
>   CONFIG_TEXT_BASE=0x600000
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
>   CONFIG_TARGET_OPENRD=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0x80000
>   CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-base"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_IDENT_STRING="\nOpenRD-Base"
> -# CONFIG_SYS_MALLOC_F is not set
>   CONFIG_HAS_BOARD_SIZE_LIMIT=y
>   CONFIG_BOARD_SIZE_LIMIT=524288
> +CONFIG_BOOTSTD_FULL=y
>   CONFIG_BOOTDELAY=3
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="${x_bootcmd_kernel}; setenv bootargs ${x_bootargs} ${x_bootargs_root}; ${x_bootcmd_usb}; bootm 0x6400000;"
>   CONFIG_USE_PREBOOT=y
>   CONFIG_LOGLEVEL=2
>   # CONFIG_DISPLAY_BOARDINFO is not set
> @@ -30,23 +30,17 @@ CONFIG_CMD_MMC=y
>   CONFIG_CMD_NAND=y
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_MII=y
> -CONFIG_CMD_PING=y
> -CONFIG_CMD_EXT2=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=nand_mtd"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=nand_mtd:0x100000@0x000000(uboot),0x400000@0x100000(uImage),0x1fb00000@0x500000(rootfs)"
>   CONFIG_CMD_UBI=y
> -CONFIG_ISO_PARTITION=y
>   CONFIG_OF_CONTROL=y
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_IN_NAND=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NETCONSOLE=y
>   CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SYS_ATA_STRIDE=4
>   CONFIG_SYS_ATA_DATA_OFFSET=0x100
>   CONFIG_SYS_ATA_REG_OFFSET=0x100
> @@ -59,7 +53,5 @@ CONFIG_MTD=y
>   CONFIG_MTD_RAW_NAND=y
>   CONFIG_MVGBE=y
>   CONFIG_MII=y
> -CONFIG_SYS_NS16550_SERIAL=y
> -CONFIG_SYS_NS16550_REG_SIZE=-4
>   CONFIG_USB=y
>   CONFIG_USB_EHCI_HCD=y
> diff --git a/configs/openrd_client_defconfig b/configs/openrd_client_defconfig
> index 82a9c77761..e0cc2e65db 100644
> --- a/configs/openrd_client_defconfig
> +++ b/configs/openrd_client_defconfig
> @@ -4,10 +4,12 @@ CONFIG_SYS_DCACHE_OFF=y
>   CONFIG_ARCH_CPU_INIT=y
>   CONFIG_SYS_THUMB_BUILD=y
>   CONFIG_ARCH_KIRKWOOD=y
> +CONFIG_SUPPORT_PASSING_ATAGS=y
> +CONFIG_CMDLINE_TAG=y
> +CONFIG_INITRD_TAG=y
>   CONFIG_SYS_KWD_CONFIG="board/Marvell/openrd/kwbimage.cfg"
>   CONFIG_TEXT_BASE=0x600000
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
>   CONFIG_TARGET_OPENRD=y
>   CONFIG_BOARD_IS_OPENRD_CLIENT=y
>   CONFIG_ENV_SIZE=0x20000
> @@ -15,12 +17,10 @@ CONFIG_ENV_OFFSET=0x80000
>   CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-client"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_IDENT_STRING="\nOpenRD-Client"
> -# CONFIG_SYS_MALLOC_F is not set
>   CONFIG_HAS_BOARD_SIZE_LIMIT=y
>   CONFIG_BOARD_SIZE_LIMIT=524288
> +CONFIG_BOOTSTD_FULL=y
>   CONFIG_BOOTDELAY=3
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="${x_bootcmd_kernel}; setenv bootargs ${x_bootargs} ${x_bootargs_root}; ${x_bootcmd_usb}; bootm 0x6400000;"
>   CONFIG_USE_PREBOOT=y
>   CONFIG_LOGLEVEL=2
>   # CONFIG_DISPLAY_BOARDINFO is not set
> @@ -31,23 +31,17 @@ CONFIG_CMD_MMC=y
>   CONFIG_CMD_NAND=y
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_MII=y
> -CONFIG_CMD_PING=y
> -CONFIG_CMD_EXT2=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=nand_mtd"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=nand_mtd:0x100000@0x000000(uboot),0x400000@0x100000(uImage),0x1fb00000@0x500000(rootfs)"
>   CONFIG_CMD_UBI=y
> -CONFIG_ISO_PARTITION=y
>   CONFIG_OF_CONTROL=y
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_IN_NAND=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NETCONSOLE=y
>   CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SYS_ATA_STRIDE=4
>   CONFIG_SYS_ATA_DATA_OFFSET=0x100
>   CONFIG_SYS_ATA_REG_OFFSET=0x100
> @@ -60,7 +54,5 @@ CONFIG_MTD=y
>   CONFIG_MTD_RAW_NAND=y
>   CONFIG_MVGBE=y
>   CONFIG_MII=y
> -CONFIG_SYS_NS16550_SERIAL=y
> -CONFIG_SYS_NS16550_REG_SIZE=-4
>   CONFIG_USB=y
>   CONFIG_USB_EHCI_HCD=y
> diff --git a/configs/openrd_ultimate_defconfig b/configs/openrd_ultimate_defconfig
> index 10b46e2ec1..a115691daa 100644
> --- a/configs/openrd_ultimate_defconfig
> +++ b/configs/openrd_ultimate_defconfig
> @@ -4,10 +4,12 @@ CONFIG_SYS_DCACHE_OFF=y
>   CONFIG_ARCH_CPU_INIT=y
>   CONFIG_SYS_THUMB_BUILD=y
>   CONFIG_ARCH_KIRKWOOD=y
> +CONFIG_SUPPORT_PASSING_ATAGS=y
> +CONFIG_CMDLINE_TAG=y
> +CONFIG_INITRD_TAG=y
>   CONFIG_SYS_KWD_CONFIG="board/Marvell/openrd/kwbimage.cfg"
>   CONFIG_TEXT_BASE=0x600000
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
>   CONFIG_TARGET_OPENRD=y
>   CONFIG_BOARD_IS_OPENRD_ULTIMATE=y
>   CONFIG_ENV_SIZE=0x20000
> @@ -15,12 +17,10 @@ CONFIG_ENV_OFFSET=0x80000
>   CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-openrd-ultimate"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_IDENT_STRING="\nOpenRD-Ultimate"
> -# CONFIG_SYS_MALLOC_F is not set
>   CONFIG_HAS_BOARD_SIZE_LIMIT=y
>   CONFIG_BOARD_SIZE_LIMIT=524288
> +CONFIG_BOOTSTD_FULL=y
>   CONFIG_BOOTDELAY=3
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="${x_bootcmd_kernel}; setenv bootargs ${x_bootargs} ${x_bootargs_root}; ${x_bootcmd_usb}; bootm 0x6400000;"
>   CONFIG_USE_PREBOOT=y
>   CONFIG_LOGLEVEL=2
>   # CONFIG_DISPLAY_BOARDINFO is not set
> @@ -31,23 +31,17 @@ CONFIG_CMD_MMC=y
>   CONFIG_CMD_NAND=y
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_MII=y
> -CONFIG_CMD_PING=y
> -CONFIG_CMD_EXT2=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=nand_mtd"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=nand_mtd:0x100000@0x000000(uboot),0x400000@0x100000(uImage),0x1fb00000@0x500000(rootfs)"
>   CONFIG_CMD_UBI=y
> -CONFIG_ISO_PARTITION=y
>   CONFIG_OF_CONTROL=y
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_IN_NAND=y
>   CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>   CONFIG_NETCONSOLE=y
>   CONFIG_SYS_FAULT_ECHO_LINK_DOWN=y
> +CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SYS_ATA_STRIDE=4
>   CONFIG_SYS_ATA_DATA_OFFSET=0x100
>   CONFIG_SYS_ATA_REG_OFFSET=0x100
> @@ -60,7 +54,5 @@ CONFIG_MTD=y
>   CONFIG_MTD_RAW_NAND=y
>   CONFIG_MVGBE=y
>   CONFIG_MII=y
> -CONFIG_SYS_NS16550_SERIAL=y
> -CONFIG_SYS_NS16550_REG_SIZE=-4
>   CONFIG_USB=y
>   CONFIG_USB_EHCI_HCD=y
> diff --git a/include/configs/openrd.h b/include/configs/openrd.h
> index 1e6b16b4e7..f91e62a2e4 100644
> --- a/include/configs/openrd.h
> +++ b/include/configs/openrd.h
> @@ -15,22 +15,4 @@
>   
>   #include "mv-common.h"
>   
> -/*
> - *  Environment variables configurations
> - */
> -/*
> - * max 4k env size is enough, but in case of nand
> - * it has to be rounded to sector size
> - */
> -
> -/*
> - * Default environment variables
> - */
> -
> -#define CFG_EXTRA_ENV_SETTINGS	"x_bootargs=console=ttyS0,115200 " \
> -	CONFIG_MTDPARTS_DEFAULT " rw ubi.mtd=2,2048\0" \
> -	"x_bootcmd_kernel=nand read 0x6400000 0x100000 0x300000\0"	\
> -	"x_bootcmd_usb=usb start\0"					\
> -	"x_bootargs_root=root=ubi0:rootfs rootfstype=ubifs\0"
> -
>   #endif /* _CONFIG_OPENRD_BASE_H */

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

