Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B76EC77B7F
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 12:15:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E6CC82C2F;
	Tue, 24 Jun 2025 14:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750767347;
	bh=X7cGq2avU+1CEq8bC0wP/IzUm5oUgAIfL7+wiv/K5O4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iDsZP/HNYkgA5B6t3VaAOf6FfF0V/6es3xN6XG8GR1/ZFp+T/CqMtgaBPnDKREuXX
	 SdWT3BByvzxyqgT3C+N0OSTTxGDqz0WuCGQnPJZj6seTrhUwxQyco8cdZkyQgSwnwq
	 zCBYoxwVXYnJFJMzFiaI+2TfxMZa7Nwl1q9bF+fW8JSCjcEKQr9QT15JoPsSnqsS2N
	 nxxCMHbiS4si2n7HnjW1ZjDyB2aer+xJGP7ZTnfFoJ7xwtcrfFNveVEc+yY+lc0oZz
	 UKTV6M3ffHZP1NCYCDqKb6VR/tsD4x9Xgo15QhzGNBh9nQiZ6xkY5Ojtltx1+igx+G
	 L+UBWEyLAkElw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C6582B18; Tue, 24 Jun 2025 14:15:45 +0200 (CEST)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 849D782C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 14:15:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4bRP6j2J0nz9scX;
 Tue, 24 Jun 2025 14:15:41 +0200 (CEST)
Message-ID: <8e14f66c-31d5-4f95-b75e-1d719961e1f9@denx.de>
Date: Tue, 24 Jun 2025 14:15:40 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: kirkwood: Enable bootstd and other modernization for
 ib62x0 board
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250623205943.11889-1-mibodhi@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20250623205943.11889-1-mibodhi@gmail.com>
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

On 23.06.25 22:59, Tony Dinh wrote:
> Enable bootstd.
> Update defconfigs to the latest u-boot requirements.
> Enable SYS_THUMB_BUILD and LTO and to reduce binary size.
> Enable NET_RANDOM_ETHADDR.
> Disable JFFS2 support.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   configs/ib62x0_defconfig | 16 ++++------------
>   include/configs/ib62x0.h | 28 ++++++++++++++++++++++------
>   2 files changed, 26 insertions(+), 18 deletions(-)
> 
> diff --git a/configs/ib62x0_defconfig b/configs/ib62x0_defconfig
> index 1beb5837bb4..0c14ac06e92 100644
> --- a/configs/ib62x0_defconfig
> +++ b/configs/ib62x0_defconfig
> @@ -2,48 +2,41 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_SYS_DCACHE_OFF=y
>   CONFIG_ARCH_CPU_INIT=y
> +CONFIG_SYS_THUMB_BUILD=y
>   CONFIG_ARCH_KIRKWOOD=y
>   CONFIG_SYS_KWD_CONFIG="board/raidsonic/ib62x0/kwbimage.cfg"
>   CONFIG_TEXT_BASE=0x600000
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xc8012000
>   CONFIG_TARGET_IB62X0=y
>   CONFIG_ENV_SIZE=0x20000
>   CONFIG_ENV_OFFSET=0xE0000
>   CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-ib62x0"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_IDENT_STRING=" RaidSonic ICY BOX IB-NAS62x0"
> +CONFIG_LTO=y
> +CONFIG_BOOTSTD_FULL=y
>   CONFIG_BOOTDELAY=3
> -CONFIG_USE_BOOTCOMMAND=y
>   CONFIG_BOOTCOMMAND="setenv bootargs ${console} ${mtdparts} ${bootargs_root}; ubi part root; ubifsmount ubi:rootfs; ubifsload 0x800000 ${kernel}; ubifsload 0x700000 ${fdt}; ubifsumount; fdt addr 0x700000; fdt resize; fdt chosen; bootz 0x800000 - 0x700000"
>   CONFIG_USE_PREBOOT=y
>   CONFIG_SYS_PBSIZE=1051
>   # CONFIG_DISPLAY_BOARDINFO is not set
> -CONFIG_HUSH_PARSER=y
>   CONFIG_SYS_PROMPT="ib62x0 => "
>   CONFIG_SYS_MAXARGS=32
> -CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_IDE=y
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
>   CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:0xe0000@0x0(uboot),0x20000@0xe0000(uboot_env),-@0x100000(root)"
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
> @@ -58,6 +51,5 @@ CONFIG_MVGBE=y
>   CONFIG_MII=y
>   CONFIG_USB=y
>   CONFIG_USB_EHCI_HCD=y
> -CONFIG_USB_STORAGE=y
>   CONFIG_LZMA=y
>   CONFIG_BZIP2=y
> diff --git a/include/configs/ib62x0.h b/include/configs/ib62x0.h
> index e1b62f78b21..01ab6edb05f 100644
> --- a/include/configs/ib62x0.h
> +++ b/include/configs/ib62x0.h
> @@ -1,5 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
>   /*
> + * Copyright (C) 2025 Tony Dinh <mibodhi@gmail.com>
>    * Copyright (C) 2011-2012
>    * Gerald Kerma <dreagle@doukki.net>
>    * Luka Perkov <luka@openwrt.org>
> @@ -11,19 +12,34 @@
>   #include "mv-common.h"
>   
>   /*
> - * Environment variables configuration
> - */
> -
> -/*
> - * Default environment variables
> + * mv-common.h should be defined after CMD configs since it used them
> + * to enable certain macros
>    */
> +#include "mv-common.h"
>   
> -#define CFG_EXTRA_ENV_SETTINGS \
> +#define EXTRA_ENV_SETTINGS_LEGACY \
>   	"console=console=ttyS0,115200\0"				\
>   	"kernel=/boot/zImage\0"						\
>   	"fdt=/boot/ib62x0.dtb\0"					\
>   	"bootargs_root=ubi.mtd=2 root=ubi0:rootfs rootfstype=ubifs rw\0"
>   
> +#define KERNEL_ADDR_R	__stringify(0x800000)
> +#define FDT_ADDR_R	__stringify(0x2c00000)
> +#define RAMDISK_ADDR_R	__stringify(0x01100000)
> +#define SCRIPT_ADDR_R	__stringify(0x200000)
> +
> +#define LOAD_ADDRESS_ENV_SETTINGS \
> +	"kernel_addr_r=" KERNEL_ADDR_R "\0" \
> +	"fdt_addr_r=" FDT_ADDR_R "\0" \
> +	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
> +	"scriptaddr=" SCRIPT_ADDR_R "\0"
> +
> +#define CFG_EXTRA_ENV_SETTINGS \
> +	EXTRA_ENV_SETTINGS_LEGACY \
> +	LOAD_ADDRESS_ENV_SETTINGS \
> +	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
> +	"mtdparts=" CONFIG_MTDPARTS_DEFAULT "\0"
> +
>   /*
>    * SATA driver configuration
>    */

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

