Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7694AD5A6FD
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 08:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E416B89663;
	Tue, 26 Nov 2024 09:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732609673;
	bh=kyGBVFwDrZyyhVSgcEaaRt/e7/Qfxhhg1ptQSMfY8ps=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=byeWCge8p8rmsGJmuRytuIsDN/aX6H+FuZFf11esx5S7iz8YhNJOSaw5ilYJFlrBJ
	 73CCbBzKh6EtJLMTPc62ZtW2wQL1umjRzdT8uNctmF6JhFbyVh/oiemlrsZWRPINFS
	 KOPnZFbzyeKmZ+4zfr6lOxhPLv49Vgl+YoXCKL/W7gOVQLU0tyI1RMvLTeuUNsjpb4
	 qPtgJQoh5K5gwtDIUdoRshcLdGV4b9RGX8f2s0E812HBaM+uM/Ss/U5UBVkP7FWIhF
	 lAlv7pAylCBTINVwTt1t1Exqo13tv00zSIgHJK/2dfZ7rLfWU7P4S2oJz8kEXun2jK
	 VEFnyzinvnVCw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C688965F; Tue, 26 Nov 2024 09:27:52 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org
 [IPv6:2001:67c:2050:101:465::107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B38C8965F
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 09:27:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4XyG0g3jvBz9t0m;
 Tue, 26 Nov 2024 09:27:47 +0100 (CET)
Message-ID: <799a6f46-b12c-404c-81d4-3c2044783603@denx.de>
Date: Tue, 26 Nov 2024 09:27:46 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] arm: kirkwood: Enable bootstd for Sheevaplug board
To: Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>
References: <20241121190228.29641-1-mibodhi@gmail.com>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20241121190228.29641-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4XyG0g3jvBz9t0m
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

On 21.11.24 20:02, Tony Dinh wrote:
> Enable bootstd for Sheevaplug board.
> Remove JFFS2 support. See JFFS2 Vulnerability[1].
> Enable LTO to keep board size within limit.
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
> Changes in v2:
> Move default envs to text-base environment
> 
>   board/Marvell/sheevaplug/sheevaplug.env | 20 ++++++++++++++++++++
>   configs/sheevaplug_defconfig            | 16 ++--------------
>   include/configs/sheevaplug.h            |  9 ---------
>   3 files changed, 22 insertions(+), 23 deletions(-)
>   create mode 100644 board/Marvell/sheevaplug/sheevaplug.env
> 
> diff --git a/board/Marvell/sheevaplug/sheevaplug.env b/board/Marvell/sheevaplug/sheevaplug.env
> new file mode 100644
> index 0000000000..bcd62dbeb7
> --- /dev/null
> +++ b/board/Marvell/sheevaplug/sheevaplug.env
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2024 Tony Dinh <mibodhi@gmail.com>
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
> diff --git a/configs/sheevaplug_defconfig b/configs/sheevaplug_defconfig
> index 9ac40b9e57..a7f6c73ecb 100644
> --- a/configs/sheevaplug_defconfig
> +++ b/configs/sheevaplug_defconfig
> @@ -16,16 +16,14 @@ CONFIG_ENV_OFFSET=0x80000
>   CONFIG_DEFAULT_DEVICE_TREE="marvell/kirkwood-sheevaplug"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_IDENT_STRING="\nMarvell-Sheevaplug"
> +CONFIG_LTO=y
>   CONFIG_HAS_BOARD_SIZE_LIMIT=y
>   CONFIG_BOARD_SIZE_LIMIT=524288
> +CONFIG_BOOTSTD_FULL=y
>   CONFIG_BOOTDELAY=3
> -CONFIG_USE_BOOTCOMMAND=y
> -CONFIG_BOOTCOMMAND="${x_bootcmd_kernel}; setenv bootargs ${x_bootargs} ${x_bootargs_root}; bootm 0x6400000;"
>   CONFIG_USE_PREBOOT=y
>   # CONFIG_DISPLAY_BOARDINFO is not set
> -CONFIG_HUSH_PARSER=y
>   CONFIG_SYS_MAXARGS=32
> -CONFIG_CMD_BOOTZ=y
>   # CONFIG_BOOTM_PLAN9 is not set
>   # CONFIG_BOOTM_RTEMS is not set
>   # CONFIG_BOOTM_VXWORKS is not set
> @@ -35,19 +33,10 @@ CONFIG_CMD_MMC=y
>   CONFIG_CMD_NAND=y
>   CONFIG_CMD_SATA=y
>   CONFIG_CMD_USB=y
> -CONFIG_CMD_DHCP=y
> -CONFIG_CMD_MII=y
> -CONFIG_CMD_PING=y
> -CONFIG_CMD_EXT2=y
> -CONFIG_CMD_EXT4=y
> -CONFIG_CMD_FAT=y
> -CONFIG_CMD_FS_GENERIC=y
> -CONFIG_CMD_JFFS2=y
>   CONFIG_CMD_MTDPARTS=y
>   CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=orion_nand:512K(uboot),512K(env),4M(kernel),-(rootfs)"
>   CONFIG_CMD_UBI=y
> -CONFIG_ISO_PARTITION=y
>   CONFIG_OF_CONTROL=y
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_IN_NAND=y
> @@ -68,6 +57,5 @@ CONFIG_DM_RTC=y
>   CONFIG_RTC_MV=y
>   CONFIG_USB=y
>   CONFIG_USB_EHCI_HCD=y
> -CONFIG_USB_STORAGE=y
>   CONFIG_LZMA=y
>   CONFIG_BZIP2=y
> diff --git a/include/configs/sheevaplug.h b/include/configs/sheevaplug.h
> index 4e0b3c663c..0a5f23e4c8 100644
> --- a/include/configs/sheevaplug.h
> +++ b/include/configs/sheevaplug.h
> @@ -12,13 +12,4 @@
>   
>   #include "mv-common.h"
>   
> -/*
> - *  Environment variables configurations
> - */
> -#define CFG_EXTRA_ENV_SETTINGS	"x_bootargs=console"	\
> -	"=ttyS0,115200 mtdparts=" CONFIG_MTDPARTS_DEFAULT	\
> -	"x_bootcmd_kernel=nand read 0x6400000 0x100000 0x400000\0" \
> -	"x_bootcmd_usb=usb start\0" \
> -	"x_bootargs_root=root=/dev/mtdblock3 rw rootfstype=jffs2\0"
> -
>   #endif /* _CONFIG_SHEEVAPLUG_H */

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

