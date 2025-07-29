Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC27C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 13:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0732582B20;
	Tue, 29 Jul 2025 15:22:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NQQX+ey3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAABF82BA1; Tue, 29 Jul 2025 15:22:26 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C768D8129F
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 15:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4brwxV5rz1z9thl;
 Tue, 29 Jul 2025 15:22:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753795342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bo4IMk8bdH+AzeGsGNKXy1P7gV/zEgw8ZgpwEuRuGIQ=;
 b=NQQX+ey3gltRbP08MQgjXsFZWGTqz0c44ntUbuBIsWbAPa6xVUu5fFKmkAZiWIzTb40DJM
 UwxA3GN08KFr54NSMj17JEEdqsc3KuOGeTjtPKahQ5oZOXFBnsK064mvSZGU0sj5lbweyc
 nB5wqNlH2/0sOu2E9LHSynezk0tEvfU9NdH2053whQWIQyUFwXZWMSA1p8oJ0dZpv61pz/
 geVeeDW6IktVZ+Rt2wVbCQEOgxhm31BEKCClSt8iHeHQXjkwzSaB0v0BpOpSOCzBmUI+B+
 R8CFODLvEXCMKbfBuV2mwt2MmUsmLJBARVlPUYdyXd+H976nuHRkyXYLN0P3lA==
Message-ID: <958b6ade-748c-47e0-a6fb-9c707cbcf39a@mailbox.org>
Date: Tue, 29 Jul 2025 15:22:21 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: kirkwood: Enable bootstd and other modernization for
 ib62x0 board
To: Tony Dinh <mibodhi@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <20250623205943.11889-1-mibodhi@gmail.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20250623205943.11889-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0cc3cc55d7944719a25
X-MBO-RS-META: 7wxgkz4fdmq3a55frk9oi948ewyq38um
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

Applied to u-boot-marvell/master

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

