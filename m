Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F207C25B74
	for <u-boot@archiver.kernel.org>; Thu, 30 May 2024 09:31:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FB64886C9;
	Thu, 30 May 2024 11:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZUCW/f6w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4ADF886DF; Thu, 30 May 2024 11:31:44 +0200 (CEST)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0FFE88684
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 11:31:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eballetbo@gmail.com
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-48ba1ece7a1so220086137.1
 for <u-boot@lists.denx.de>; Thu, 30 May 2024 02:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717061501; x=1717666301; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UQqR0zFLjMu3SmWs4MUkOnt5Ryoj0No1aW4NKU8te0E=;
 b=ZUCW/f6wjIEhycgJIi5UT1B5NBvIiJPQY+hqO7w8TcRW6dR/ybQZfQxOWzG5ifoPfC
 r0KX+OjB1+po8+q9LJrELvEMWY28BnADoWWUc2VS9lTIM6QsmHudzNlp1eB3dMgzxMUO
 uY7ARTriBayCWwUX36/T7D0wifk8icvFNSMlEcwKbTN5eoEwpZ6EHen2HEsCQBPy8HVw
 ePASeCtAMuoATaDm43JumsQ3cdQ1CgnC67z2mSYtK9kfTFTXlYzHcxwFAg3Z5aJ87KFl
 MDbZzTBBdNNN/fugcCMWTMF5Ns9AHTBqUBFBnFFr/AW/jzusBC2ZoW/TRuhfFsBdeR1O
 wGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717061501; x=1717666301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UQqR0zFLjMu3SmWs4MUkOnt5Ryoj0No1aW4NKU8te0E=;
 b=i0wSn444rqGtIIYxPnyrYo4j5noCKSkeRvIVdHa4ym8wNAJB3gXh5hFIuJxKyyIl+9
 YviACbblT8mOowqScWCoraHl2yNJ4FLz2x83fIYudk8BXnwuq2n1L+l9yprivFfi1EFo
 ixwacXv90lA944a3rW9zIeMjN9IIF0LqNGKvej3eYdUOS6EvZs249GbXttwm1wRTRbzy
 MW3CQUuHo1s+0BIvwQnnqwUW3KTdP+6s59yCdKOUoLqhmznFqamR4hWaM5XqzlOd+esM
 3CuCz3eOLGB1I60JXnWE4gSL/AUnwTtiO7ZKP2LzSJdtHnB7zCbF97Ih/XWAQpUmmJeF
 rnNw==
X-Gm-Message-State: AOJu0Yx6X1waAlIjTGJ9rXDp9VDqaP9GCY2jXgeCCFfsDGNPmEhJWbvd
 ey7XcDfRSw+U5mncvdM3+AZoWxKy2J3PrzQwFUnJAPnuAly7rIKzI/0PRtv1vL9NAKpEp2xsw4g
 I0MBxe/fWhoRWguyEJWPILDySZrI=
X-Google-Smtp-Source: AGHT+IFkaDX8VaYRj4pRtlx6uLylrLUUpu9X2leOqfpILpzq6OV+6hf9sTZFKQzf+qRUnP63Fd5hy47quCZ6SDSRZ4w=
X-Received: by 2002:a05:6102:11f0:b0:48b:ad3a:4de2 with SMTP id
 ada2fe7eead31-48bae97cdb8mr1600918137.12.1717061501116; Thu, 30 May 2024
 02:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240518130622.219031-1-javier@dowhile0.org>
 <20240518130622.219031-4-javier@dowhile0.org>
In-Reply-To: <20240518130622.219031-4-javier@dowhile0.org>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Thu, 30 May 2024 11:31:30 +0200
Message-ID: <CAFqH_50ZuOB90+X7W2KC0=Bs5ZERemzdO_+g6NBMjwqOBQJXrA@mail.gmail.com>
Subject: Re: [RESEND PATCH 3/4] omap3: igep0x00: Update for DM SPL support
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: u-boot@lists.denx.de, Javier Martinez Canillas <javierm@redhat.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Michal Simek <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Javier,

Thanks for the patches.

Missatge de Javier Martinez Canillas <javier@dowhile0.org> del dia
ds., 18 de maig 2024 a les 15:06:
>
> From: Javier Martinez Canillas <javierm@redhat.com>
>
> This change is heavily based on commit e0cc7df9fdf2 ("omap3_beagle: Update
> for DM SPL support"), that did the same update for the OMAP3 Beagle board.
>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

Reviewed-by: Enric Balletbo i Serra <eballetbo@gmail.com>

> ---
>
>  arch/arm/dts/omap3-igep0020-u-boot.dtsi | 14 ++------------
>  board/isee/igep00x0/igep00x0.c          | 12 ------------
>  configs/igep00x0_defconfig              | 17 ++++++++---------
>  3 files changed, 10 insertions(+), 33 deletions(-)
>
> diff --git a/arch/arm/dts/omap3-igep0020-u-boot.dtsi b/arch/arm/dts/omap3-igep0020-u-boot.dtsi
> index 41beaf0900c3..2c03701c896a 100644
> --- a/arch/arm/dts/omap3-igep0020-u-boot.dtsi
> +++ b/arch/arm/dts/omap3-igep0020-u-boot.dtsi
> @@ -5,20 +5,10 @@
>   * (C) Copyright 2017 Derald D. Woods <woods.technical@gmail.com>
>   */
>
> +#include "omap3-u-boot.dtsi"
> +
>  / {
>         chosen {
>                 stdout-path = &uart3;
>         };
>  };
> -
> -&uart1 {
> -       reg-shift = <2>;
> -};
> -
> -&uart2 {
> -       reg-shift = <2>;
> -};
> -
> -&uart3 {
> -       reg-shift = <2>;
> -};
> diff --git a/board/isee/igep00x0/igep00x0.c b/board/isee/igep00x0/igep00x0.c
> index 8a3f290f678f..a35a7cd3b1f7 100644
> --- a/board/isee/igep00x0/igep00x0.c
> +++ b/board/isee/igep00x0/igep00x0.c
> @@ -29,18 +29,6 @@
>  #include <fdt_support.h>
>  #include "igep00x0.h"
>
> -static const struct ns16550_plat igep_serial = {
> -       .base = OMAP34XX_UART3,
> -       .reg_shift = 2,
> -       .clock = V_NS16550_CLK,
> -       .fcr = UART_FCR_DEFVAL,
> -};
> -
> -U_BOOT_DRVINFO(igep_uart) = {
> -       "ns16550_serial",
> -       &igep_serial
> -};
> -
>  /*
>   * Routine: get_board_revision
>   * Description: GPIO_28 and GPIO_129 are used to read board and revision from
> diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
> index 6df6c33e25ab..c1b873a17efb 100644
> --- a/configs/igep00x0_defconfig
> +++ b/configs/igep00x0_defconfig
> @@ -1,4 +1,6 @@
>  CONFIG_ARM=y
> +# CONFIG_SPL_USE_ARCH_MEMCPY is not set
> +# CONFIG_SPL_USE_ARCH_MEMSET is not set
>  CONFIG_ARCH_OMAP2PLUS=y
>  CONFIG_SYS_MALLOC_F_LEN=0x4000
>  CONFIG_TI_COMMON_CMD_OPTIONS=y
> @@ -40,16 +42,7 @@ CONFIG_SPL_UBI_LEB_START=2048
>  CONFIG_SPL_UBI_INFO_ADDR=0x88080000
>  CONFIG_SPL_UBI_VOL_IDS=8
>  CONFIG_SPL_UBI_LOAD_MONITOR_ID=0
> -CONFIG_SPL_UBI_LOAD_KERNEL_ID=3
> -CONFIG_SPL_UBI_LOAD_ARGS_ID=4
>  CONFIG_SPL_ONENAND_SUPPORT=y
> -CONFIG_SPL_OS_BOOT=y
> -CONFIG_SPL_PAYLOAD_ARGS_ADDR=0x84000000
> -CONFIG_SYS_NAND_SPL_KERNEL_OFFS=0x280000
> -CONFIG_SPL_FALCON_BOOT_MMCSD=y
> -CONFIG_SYS_MMCSD_RAW_MODE_KERNEL_SECTOR=0x1700
> -CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTOR=0x1500
> -CONFIG_SYS_MMCSD_RAW_MODE_ARGS_SECTORS=0x200
>  CONFIG_CMD_SPL=y
>  CONFIG_CMD_NAND=y
>  CONFIG_CMD_ONENAND=y
> @@ -59,7 +52,11 @@ CONFIG_CMD_CACHE=y
>  CONFIG_CMD_MTDPARTS=y
>  CONFIG_CMD_UBI=y
>  # CONFIG_CMD_UBIFS is not set
> +# CONFIG_SPL_EFI_PARTITION is not set
> +CONFIG_SPL_PARTITION_UUIDS=y
>  CONFIG_OF_CONTROL=y
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clocks clock-names interrupt-parent"
>  CONFIG_ENV_OVERWRITE=y
>  CONFIG_ENV_IS_IN_UBI=y
>  CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
> @@ -69,6 +66,7 @@ CONFIG_ENV_UBI_VOLUME_REDUND="config_r"
>  CONFIG_SYS_RELOC_GD_ENV_ADDR=y
>  CONFIG_VERSION_VARIABLE=y
>  # CONFIG_NET is not set
> +CONFIG_SPL_DM=y
>  CONFIG_SYS_I2C_LEGACY=y
>  CONFIG_SPL_SYS_I2C_LEGACY=y
>  CONFIG_MMC_OMAP_HS=y
> @@ -81,5 +79,6 @@ CONFIG_SYS_NAND_PAGE_SIZE=0x800
>  CONFIG_SYS_NAND_OOBSIZE=0x40
>  CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
>  CONFIG_MTD_UBI_FASTMAP=y
> +CONFIG_SPECIFY_CONSOLE_INDEX=y
>  CONFIG_CONS_INDEX=3
>  CONFIG_BCH=y
> --
> 2.45.0
>
