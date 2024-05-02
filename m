Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC47FC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 07:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A20A88CE6;
	Thu,  2 May 2024 09:28:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z1ORbAzs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A83A488C38; Thu,  2 May 2024 09:28:09 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A098E88D29
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 09:28:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-34d9c9f2cf0so1839455f8f.3
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 00:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714634887; x=1715239687;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/H4NYfY4zyOhd75u4cstdGl7EAVnSFFaQq9R31bPKU4=;
 b=Z1ORbAzsMeVfmLVvi5C5eUS/a9CluLDnaG3j7Ns85geky4KBmIadaNedG3SFyLS9Uq
 BwkuWd8WiUPGQ3PwM3ZShg2M/oOnlGCs6RvfWV/pocym18FQEVOSy0RFBLMkjPovuYHW
 GFSKMQE0Ldz2C09+CQm5eNXJUdEdzrei6a+Me5Cwveyq9afyR/BQm+9g4FZ8iOWoXptM
 uUXRZQ1SOp7Ogj41fyiPM822yptSZFwrFuq67pQiu6dBMvsnMaS7oKrUI9vFZ4+Hyc2g
 /fxcQsC41eQM52bcKFETGMZ7w14RBwv+wHiyDIgT2yyAWaDf5iHUOaTCxelR0ENJa6yd
 WgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714634887; x=1715239687;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/H4NYfY4zyOhd75u4cstdGl7EAVnSFFaQq9R31bPKU4=;
 b=FNvKFqQGNEWHd1oAB0WDxolsQDW+ImFlgXMHvuTqc2ubyHE3qPw5ym5tI/Y5X8u4q5
 XQdsliQVh0pW7Sz4g52xV1UvVzu2cXjC0D0kEXmE4Qw5YTtedQilIARnHALpM08zPgzs
 Q/mH49Mwj+tC0A83O7qiwcDSP1lYKCjo6BunP8Cu9+IrLMmiEb6kite0hhYccPNb5l6V
 NUht1n7CHdAItJST6cpv39ZhoP7MJVyj9R2V81rNbBjKywmDmo4gHIoM0cdNR9jyZNBv
 jND0PwM/aA00WrSOHY5zm2ySiB4iiT3IPZsXT6bJnQ2+UFzMMqCN/PSOIfxup2xU6M11
 28Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7HVjqH9GHWbd5nHvaZVobelTN282d4vaxEjgaxwe21dEtl8ET6s/9tjNNe0ZLozqlGmC9EhtO1Wv913tQk4x7CQgHpg==
X-Gm-Message-State: AOJu0Ywjz3Iv4kcKzxM3swqFKLaOoYE7QqTL6JtvqiEeJb/aFDiK7eBD
 APTYEJmiKMbJxLVmnLbjTw+MAahXgK6EJPTrsRBKcjuJ/Njx4h6Ymwl/pBTr+8ab5M2DLjaKul3
 uRAA=
X-Google-Smtp-Source: AGHT+IF8EYkM2nO0iYOt1iDiP0f+ocOXhL5wVSQHK8jFFtSubrFK5lEMBK3vtH6KrUoIzZSvnIQ50w==
X-Received: by 2002:a05:6000:1109:b0:34d:b9d2:4dfb with SMTP id
 z9-20020a056000110900b0034db9d24dfbmr4024459wrw.48.1714634886990; 
 Thu, 02 May 2024 00:28:06 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 dd3-20020a0560001e8300b0034c9f060a14sm534236wrb.11.2024.05.02.00.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 00:28:06 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 25/81] dfu: Remove <common.h> and add needed includes
In-Reply-To: <20240502013138.2383421-25-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-25-trini@konsulko.com>
Date: Thu, 02 May 2024 09:28:03 +0200
Message-ID: <87ttjg4qrg.fsf@baylibre.com>
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

Since this is quite a big series, I'm assuming you will pick it up
yourself.

If it's expected of me to pick this up through u-boot-dfu, let me know.

> ---
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>  drivers/dfu/dfu.c      | 1 -
>  drivers/dfu/dfu_alt.c  | 1 -
>  drivers/dfu/dfu_mmc.c  | 1 -
>  drivers/dfu/dfu_mtd.c  | 1 -
>  drivers/dfu/dfu_nand.c | 1 -
>  drivers/dfu/dfu_ram.c  | 1 -
>  drivers/dfu/dfu_sf.c   | 1 -
>  drivers/dfu/dfu_virt.c | 1 -
>  8 files changed, 8 deletions(-)
>
> diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
> index 2adf26e2fe24..540d48fab77d 100644
> --- a/drivers/dfu/dfu.c
> +++ b/drivers/dfu/dfu.c
> @@ -6,7 +6,6 @@
>   * author: Lukasz Majewski <l.majewski@samsung.com>
>   */
>  
> -#include <common.h>
>  #include <env.h>
>  #include <errno.h>
>  #include <log.h>
> diff --git a/drivers/dfu/dfu_alt.c b/drivers/dfu/dfu_alt.c
> index ece3d2236f3d..e9132936a90b 100644
> --- a/drivers/dfu/dfu_alt.c
> +++ b/drivers/dfu/dfu_alt.c
> @@ -4,7 +4,6 @@
>   * Lukasz Majewski <l.majewski@majess.pl>
>   */
>  
> -#include <common.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <errno.h>
> diff --git a/drivers/dfu/dfu_mmc.c b/drivers/dfu/dfu_mmc.c
> index 12c54e90ef71..cfa6334e4397 100644
> --- a/drivers/dfu/dfu_mmc.c
> +++ b/drivers/dfu/dfu_mmc.c
> @@ -6,7 +6,6 @@
>   * author: Lukasz Majewski <l.majewski@samsung.com>
>   */
>  
> -#include <common.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <errno.h>
> diff --git a/drivers/dfu/dfu_mtd.c b/drivers/dfu/dfu_mtd.c
> index 485586989c8a..c36ac09189f3 100644
> --- a/drivers/dfu/dfu_mtd.c
> +++ b/drivers/dfu/dfu_mtd.c
> @@ -7,7 +7,6 @@
>   * Based on dfu_nand.c
>   */
>  
> -#include <common.h>
>  #include <dfu.h>
>  #include <mtd.h>
>  #include <linux/err.h>
> diff --git a/drivers/dfu/dfu_nand.c b/drivers/dfu/dfu_nand.c
> index 08e8cf5cdb37..940cfefc986c 100644
> --- a/drivers/dfu/dfu_nand.c
> +++ b/drivers/dfu/dfu_nand.c
> @@ -9,7 +9,6 @@
>   * author: Lukasz Majewski <l.majewski@samsung.com>
>   */
>  
> -#include <common.h>
>  #include <log.h>
>  #include <malloc.h>
>  #include <errno.h>
> diff --git a/drivers/dfu/dfu_ram.c b/drivers/dfu/dfu_ram.c
> index c4f4bd2e482f..043acbf022fc 100644
> --- a/drivers/dfu/dfu_ram.c
> +++ b/drivers/dfu/dfu_ram.c
> @@ -8,7 +8,6 @@
>   * author: Lukasz Majewski <l.majewski@samsung.com>
>   */
>  
> -#include <common.h>
>  #include <malloc.h>
>  #include <mapmem.h>
>  #include <errno.h>
> diff --git a/drivers/dfu/dfu_sf.c b/drivers/dfu/dfu_sf.c
> index 2dae15937064..7c1c0f9e2dc7 100644
> --- a/drivers/dfu/dfu_sf.c
> +++ b/drivers/dfu/dfu_sf.c
> @@ -3,7 +3,6 @@
>   * Copyright (c) 2014, NVIDIA CORPORATION. All rights reserved.
>   */
>  
> -#include <common.h>
>  #include <malloc.h>
>  #include <errno.h>
>  #include <div64.h>
> diff --git a/drivers/dfu/dfu_virt.c b/drivers/dfu/dfu_virt.c
> index 29f7a08f6728..2c31445af12a 100644
> --- a/drivers/dfu/dfu_virt.c
> +++ b/drivers/dfu/dfu_virt.c
> @@ -2,7 +2,6 @@
>  /*
>   * Copyright (C) 2019, STMicroelectronics - All Rights Reserved
>   */
> -#include <common.h>
>  #include <dfu.h>
>  #include <errno.h>
>  #include <log.h>
> -- 
> 2.34.1
