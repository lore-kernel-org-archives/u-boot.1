Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A53C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 07:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9103C875A1;
	Thu, 26 Oct 2023 09:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1698304172;
	bh=fjEfUe8ifHRJ4THhRVJnMAjP19lpyRYw2EYusUTzBhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g9SyiPzjbrhCgAD+AfvKo3dOpilVelEwTa/qcqjVMqEveOAre1u+6WqJhjH3JsKXE
	 N7l/yiuTbRpYGYfYwyA/b1qX9wUkKV+ZwLqVx5NtXgQ4tUIHy00XQhQj2M2SbQK+sB
	 e5CmeAKjlbLs8d/ajY9hD0wpTRBfsgPKEmTJuMhfiZxqqHCLAWNArmBSaVSv77sEme
	 KfNvCH0xqjVC3ecWuHJpm6epoO93IyQ8S8GRCzG/EZx6Xmp3UplpEhpQ8PWODlNp0K
	 HuFuo4TwDi5UH28Mptkb088IqBwvfvREslwx0F8B4fFC2N5FB7afKliTkkpavrXG5q
	 eEZkKDHKZTQSQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 358318750E; Thu, 26 Oct 2023 09:09:31 +0200 (CEST)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67F2E875B7
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 09:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4SGH3W4H0xz9sR0;
 Thu, 26 Oct 2023 09:09:27 +0200 (CEST)
Message-ID: <ac4111bf-a715-4175-b743-781ae21f2973@denx.de>
Date: Thu, 26 Oct 2023 09:09:27 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] arm: kirkwood: Enable bootstd for Zyxel NSA310S board
Content-Language: en-US
To: Tony Dinh <mibodhi@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Luka Perkov <luka.perkov@sartura.hr>
References: <20231025223838.31639-1-mibodhi@gmail.com>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231025223838.31639-1-mibodhi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4SGH3W4H0xz9sR0
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

On 10/26/23 00:38, Tony Dinh wrote:
> Enable bootstd for Zyxel NSA310S board, and remove distroboot.
> 
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
> 
>   configs/nsa310s_defconfig |  3 ++-
>   include/configs/nsa310s.h | 17 ++---------------
>   2 files changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/configs/nsa310s_defconfig b/configs/nsa310s_defconfig
> index ff4895622c..038ef42e9d 100644
> --- a/configs/nsa310s_defconfig
> +++ b/configs/nsa310s_defconfig
> @@ -19,7 +19,8 @@ CONFIG_DEBUG_UART_CLOCK=166666667
>   CONFIG_IDENT_STRING="\nZyXEL NSA310S/320S 1/2-Bay Power Media Server"
>   CONFIG_SYS_LOAD_ADDR=0x800000
>   CONFIG_DEBUG_UART=y
> -CONFIG_DISTRO_DEFAULTS=y
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
>   CONFIG_BOOTDELAY=3
>   CONFIG_USE_PREBOOT=y
>   # CONFIG_DISPLAY_BOARDINFO is not set
> diff --git a/include/configs/nsa310s.h b/include/configs/nsa310s.h
> index fa029a176b..8c4d03553d 100644
> --- a/include/configs/nsa310s.h
> +++ b/include/configs/nsa310s.h
> @@ -1,6 +1,6 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
>   /*
> - * Copyright (C) 2015, 2021-2022 Tony Dinh <mibodhi@gmail.com>
> + * Copyright (C) 2015, 2021-2023 Tony Dinh <mibodhi@gmail.com>
>    * Copyright (C) 2015
>    * Gerald Kerma <dreagle@doukki.net>
>    * Luka Perkov <luka.perkov@sartura.hr>
> @@ -15,14 +15,6 @@
>    */
>   #include "mv-common.h"
>   
> -/* Include the common distro boot environment */
> -#ifndef CONFIG_SPL_BUILD
> -
> -#define BOOT_TARGET_DEVICES(func) \
> -	func(USB, usb, 0) \
> -	func(SATA, sata, 0) \
> -	func(DHCP, dhcp, na)
> -
>   #define KERNEL_ADDR_R	__stringify(0x800000)
>   #define FDT_ADDR_R	__stringify(0x2c00000)
>   #define RAMDISK_ADDR_R	__stringify(0x01100000)
> @@ -34,16 +26,11 @@
>   	"ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
>   	"scriptaddr=" SCRIPT_ADDR_R "\0"
>   
> -#include <config_distro_bootcmd.h>
> -
>   #define CFG_EXTRA_ENV_SETTINGS \
>   	"console=console=ttyS0,115200\0" \
>   	"kernel=/boot/zImage\0" \
>   	"fdt=/boot/nsa310s.dtb\0" \
>   	"bootargs_root=ubi.mtd=3 root=ubi0:rootfs rootfstype=ubifs rw\0" \
> -	LOAD_ADDRESS_ENV_SETTINGS \
> -	BOOTENV
> -
> -#endif /* CONFIG_SPL_BUILD */
> +	LOAD_ADDRESS_ENV_SETTINGS
>   
>   #endif /* _CONFIG_NSA310S_H */

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
