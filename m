Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF07C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 07:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7ED2088D33;
	Thu,  2 May 2024 09:29:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rU5Pp6iB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A76D688D35; Thu,  2 May 2024 09:29:19 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2CDB88C38
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 09:29:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41a1d88723bso53420025e9.0
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 00:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714634957; x=1715239757;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K/eBjDjimCT9NuottdksbwACmVNQOat+PwhWYrWpUsM=;
 b=rU5Pp6iB7ksC8iWVN/LZZ/SV3ugaxXMuj7e5zc/AMoNbFl5F//3kLbQ2vT/N6alflA
 XMUtGuD/j7Y7tRgPsJq/fBAdrwxWCB1oX3e7UT5MwpicdcsyDpxRliYsrKD0XkmajZEX
 xtUzM9c+tOeQKvne3wTUlr+CSwHqBnlBF6PnEAIlYQ6wc7nR3COevAaHdwOpxD0P5JP5
 3vemET8zdNPyoRz+WpX+6ZX4ujuZZNGPZuTDEtuvvzBhd7i22usnU8nV7b09VdximVOD
 ZQh36orppoa8W9uVeNPZ20uFwiBIK22XlPEk9eZI3uNjp0UCiv3BX/aMsVHG+L2nb+lH
 j+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714634957; x=1715239757;
 h=mime-version:message-id:date:references:in-reply-to:subject:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K/eBjDjimCT9NuottdksbwACmVNQOat+PwhWYrWpUsM=;
 b=pdCDxqUiZTAuzcQP+zHdqjWxAaWi8/iLDTKCkDoB9XKkDQrpBQSCO1WFYRP4BJEODO
 DfomfpKCSp3L0G5XsPQruZWwV/6fLFFe4tRaMNRFVpYJV8RJEKVJgVpQAfTMHxFtwxLR
 ZHNGxYuQC5kdLcF//5T2A0wim++cPKTRmd6hfpLoa+ARDvBwT+z3qKD1ZlD+TJTHb+H/
 DjAKWriIxz/7n+p4sc9MNaOjv3kP7nFkTOxgmBHxWaSosrgYyOCOcOgsBu8F+SFVZhEV
 psFYopuH9nnO8d1YXwLg8pMbjcNMAhhn6qHHvBXBw5EwK6DZ1RKa1EIPL2ZrkORP4aoH
 cdaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX06q3re8XTK+J8SMBNXokBg3FOB3zri57nzISpHFnl1jiCDVkDto9jWR9l4lm8xVaRtc/W7tcwIxcMHLabSVDv1gm74Q==
X-Gm-Message-State: AOJu0YzVezPtEBJucMJ5dZQrE0e6tj/3P/KqIwtXgGviB/gkLe3601nh
 jNdUdaCHeH08pVUX9OAm2OXv/aRHgb5zBxQEtDw+5XiQZe5ofJ4aVnO3k/j61ni4icUWqWqyc/9
 zhTM=
X-Google-Smtp-Source: AGHT+IHe/IJsyELXOkWMauufNfz0hu6fG6Ry+Uo8mxCq8Yi5q36IwtqfbDANiUVAz0pJ2Hsx+f+dQQ==
X-Received: by 2002:a05:600c:a0b:b0:41b:fbec:a53a with SMTP id
 z11-20020a05600c0a0b00b0041bfbeca53amr3075733wmp.16.1714634957066; 
 Thu, 02 May 2024 00:29:17 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 g7-20020a05600c4ec700b0041902ebc87esm932851wmq.35.2024.05.02.00.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 00:29:16 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 28/81] fastboot: Remove <common.h> and add needed includes
In-Reply-To: <20240502013138.2383421-28-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-28-trini@konsulko.com>
Date: Thu, 02 May 2024 09:29:14 +0200
Message-ID: <87r0ek4qph.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Tom,

Thank you for the patch.

On mer., mai 01, 2024 at 19:30, Tom Rini <trini@konsulko.com> wrote:

> Remove <common.h> from this driver directory and when needed
> add missing include files directly.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  drivers/fastboot/fb_command.c | 2 +-
>  drivers/fastboot/fb_common.c  | 2 +-
>  drivers/fastboot/fb_getvar.c  | 2 +-
>  drivers/fastboot/fb_mmc.c     | 1 -
>  drivers/fastboot/fb_nand.c    | 1 -
>  5 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index 01443c5d39e2..e4484d65aca5 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2016 The Android Open Source Project
>   */
>  
> -#include <common.h>
>  #include <command.h>
>  #include <console.h>
>  #include <env.h>
> @@ -13,6 +12,7 @@
>  #include <fb_nand.h>
>  #include <part.h>
>  #include <stdlib.h>
> +#include <vsprintf.h>
>  #include <linux/printk.h>
>  
>  /**
> diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
> index 3576b0677299..12ffb463deb9 100644
> --- a/drivers/fastboot/fb_common.c
> +++ b/drivers/fastboot/fb_common.c
> @@ -11,11 +11,11 @@
>   */
>  
>  #include <bcb.h>
> -#include <common.h>
>  #include <command.h>
>  #include <env.h>
>  #include <fastboot.h>
>  #include <net.h>
> +#include <vsprintf.h>
>  
>  /**
>   * fastboot_buf_addr - base address of the fastboot download buffer
> diff --git a/drivers/fastboot/fb_getvar.c b/drivers/fastboot/fb_getvar.c
> index f65519c57b47..93cbd598e024 100644
> --- a/drivers/fastboot/fb_getvar.c
> +++ b/drivers/fastboot/fb_getvar.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2016 The Android Open Source Project
>   */
>  
> -#include <common.h>
>  #include <env.h>
>  #include <fastboot.h>
>  #include <fastboot-internal.h>
> @@ -12,6 +11,7 @@
>  #include <fs.h>
>  #include <part.h>
>  #include <version.h>
> +#include <vsprintf.h>
>  #include <linux/printk.h>
>  
>  static void getvar_version(char *var_parameter, char *response);
> diff --git a/drivers/fastboot/fb_mmc.c b/drivers/fastboot/fb_mmc.c
> index 060918e49109..f11eb66761b1 100644
> --- a/drivers/fastboot/fb_mmc.c
> +++ b/drivers/fastboot/fb_mmc.c
> @@ -4,7 +4,6 @@
>   */
>  
>  #include <config.h>
> -#include <common.h>
>  #include <blk.h>
>  #include <env.h>
>  #include <fastboot.h>
> diff --git a/drivers/fastboot/fb_nand.c b/drivers/fastboot/fb_nand.c
> index bbe26ddcc9be..afc64fd52807 100644
> --- a/drivers/fastboot/fb_nand.c
> +++ b/drivers/fastboot/fb_nand.c
> @@ -5,7 +5,6 @@
>   */
>  
>  #include <config.h>
> -#include <common.h>
>  #include <blk.h>
>  
>  #include <fastboot.h>
> -- 
> 2.34.1
