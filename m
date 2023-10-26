Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DE4C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 07:09:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8EE9875A4;
	Thu, 26 Oct 2023 09:09:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698304148;
	bh=wIf6uwp4aPXPcqd/89exLhYYzREMIdPf3KmHiM4t87I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lz/GJx1gDnx3HWe+ZVZUY81PO4NEjF481bqEKp+VFL2Dd8v6b0wSeSvwBSyNYFKmP
	 rnydhDg+3RbRO6X8C7YER3uv8mfwSJO8D+cf+pVIGhbO1xM7o8iGUYXXT9yoKkVmXb
	 gzIX5LyAJvACa1weZYtrSfaHiFTb/jLAUnDcpctq/mxx0KXM3Sx8B61sZdeU0FLuvz
	 poGDTOgL3FdgFmFy3035/DUGyxwEgpAvC0DZFXLoo9j/hvP8l/jhnGyxT7gk7pghGA
	 UaAtTRX3Le9USKoBDn0+F7ol+YRF3iGHAHNljTcOems3I/jB1/oAdbVFuevDOFa/v/
	 NQnWtEKsxZM5w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A7A48750E; Thu, 26 Oct 2023 09:09:02 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1E2E875A1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:09:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SGH2y43f2z9sR0;
 Thu, 26 Oct 2023 09:08:58 +0200 (CEST)
Message-ID: <f497642b-ae68-4dbc-b817-14b18a614272@denx.de>
Date: Thu, 26 Oct 2023 09:08:57 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: kirkwood: Enable bootstd for Pogo V4 board
Content-Language: en-US
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20231024231709.21861-1-mibodhi@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231024231709.21861-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4SGH2y43f2z9sR0
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

On 10/25/23 01:17, Tony Dinh wrote:
> Enable bootstd for Pogo V4 board, and remove distroboot.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   configs/pogo_v4_defconfig |  3 ++-
>   include/configs/pogo_v4.h | 35 ++---------------------------------
>   2 files changed, 4 insertions(+), 34 deletions(-)
> 
> diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
> index 2747c3c72d..ff6411d894 100644
> --- a/configs/pogo_v4_defconfig
> +++ b/configs/pogo_v4_defconfig
> @@ -17,7 +17,8 @@ CONFIG_IDENT_STRING="\nPogoplug V4"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_PCI=y
>   CONFIG_LTO=y
> -CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
>   CONFIG_BOOTSTAGE=y
>   CONFIG_SHOW_BOOT_PROGRESS=y
>   CONFIG_BOOTDELAY=10
> diff --git a/include/configs/pogo_v4.h b/include/configs/pogo_v4.h
> index 3371579023..d5003538da 100644
> --- a/include/configs/pogo_v4.h
> +++ b/include/configs/pogo_v4.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
>   /*
> - * Copyright (C) 2014-2022 Tony Dinh <mibodhi@gmail.com>
> + * Copyright (C) 2014-2023 Tony Dinh <mibodhi@gmail.com>
>    *
>    * Based on
>    * Copyright (C) 2012
> @@ -21,33 +21,6 @@
>    */
>   #include "mv-common.h"
>   
> -/* Include the common distro boot environment */
> -#ifndef CONFIG_SPL_BUILD
> -
> -#ifdef CONFIG_MMC
> -#define BOOT_TARGET_DEVICES_MMC(func) func(MMC, mmc, 0)
> -#else
> -#define BOOT_TARGET_DEVICES_MMC(func)
> -#endif
> -
> -#ifdef CONFIG_SATA
> -#define BOOT_TARGET_DEVICES_SATA(func) func(SATA, sata, 0)
> -#else
> -#define BOOT_TARGET_DEVICES_SATA(func)
> -#endif
> -
> -#ifdef CONFIG_USB_STORAGE
> -#define BOOT_TARGET_DEVICES_USB(func) func(USB, usb, 0)
> -#else
> -#define BOOT_TARGET_DEVICES_USB(func)
> -#endif
> -
> -#define BOOT_TARGET_DEVICES(func) \
> -	BOOT_TARGET_DEVICES_MMC(func) \
> -	BOOT_TARGET_DEVICES_USB(func) \
> -	BOOT_TARGET_DEVICES_SATA(func) \
> -	func(DHCP, dhcp, na)
> -
>   #define KERNEL_ADDR_R	__stringify(0x800000)
>   #define FDT_ADDR_R	__stringify(0x2c00000)
>   #define RAMDISK_ADDR_R	__stringify(0x01100000)
> @@ -59,14 +32,10 @@
>   	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
>   	"scriptaddr=" SCRIPT_ADDR_R "\0"
>   
> -#include <config_distro_bootcmd.h>
> -
>   #define CFG_EXTRA_ENV_SETTINGS \
>   	LOAD_ADDRESS_ENV_SETTINGS \
>   	"fdtfile=" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
>   	"mtdparts=" CONFIG_MTDPARTS_DEFAULT "\0" \
> -	"console=ttyS0,115200\0" \
> -	BOOTENV
> -#endif /* CONFIG_SPL_BUILD */
> +	"console=ttyS0,115200\0"
>   
>   #endif /* _CONFIG_POGO_V4_H */

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
