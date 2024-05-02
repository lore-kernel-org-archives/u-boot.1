Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BC4C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 07:26:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D5E088CE6;
	Thu,  2 May 2024 09:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YaNQXsbZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E23EC88CF6; Thu,  2 May 2024 09:26:01 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A67D788C38
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 09:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2dd7e56009cso98265131fa.3
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714634759; x=1715239559;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=xZ/q0abA8idfl3X1orUkRSzMGSHAK4GtGqo+JtoffLA=;
 b=YaNQXsbZguvPNaRBZgqOnqayfQQWdDYvMh46a9HVTspW96j2RXKXsRaqLZkA89Qxik
 FWNVypvb241St3mJ3Q32ySdrCxcYAL/XkYJXUfWTqwHLV7qopLtGqvaCeTgHU5w9S6/T
 jeTYGSJkSKE23PdvSwsZODgjJwKuM4ALoL5JaoSpbN7rb7l5rVDy4qzpF+M7dHtgkwjX
 jxVPMlRrrOHpkcTkTXVsno5gxMLggT5bIKgDCYEQQDzTcZS5HOdFREtWupXpKLXTRmJU
 zZT2BL1C4Rw0qWzyE2fd6hxeUTA+W2nuP1+gjike981MjnKFd+GzvxKIgc6oz6jHR7Rx
 49Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714634759; x=1715239559;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xZ/q0abA8idfl3X1orUkRSzMGSHAK4GtGqo+JtoffLA=;
 b=sETXoK/9Qy0oe42NhoQIEWoywupiWzPKGkcl92Lg2pyDU4JvgYlERlQwev+vJge5cH
 4yaTH1LF2cvU2hEBPOA+/LzMOdrROB+TJJ4v7SMZs7mN+rRRFsyw8uzAFNLnVZ6fWEff
 LxRASQOrQ2Ej7Wgw+BOWsT6fhOoLoV2eqg09dGmpeuyNRcvw3Dvd/bFlziA48OZedhKd
 gU0AuD0OZws49MwNPr0ue+zwMEUwZ9i55eYkkw+EHNwTV3LTS6mZaqa+Bzlb5T8vJE68
 fwfdoFvCWfRVvY/+2H7/aRN45BJuJLcfGEORmMlfBMqfo3mgt3rW5VD3kmh8tDZ1Umsp
 /C1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq2oIFHvuHhoUBRXSGtnPgHqsdkru5KBba+0vATCX4qYyAqDrsAItv5c8EOBXRt73Sq9c2UWzOf1GzIeC025FhYpKaQg==
X-Gm-Message-State: AOJu0YyTYJ9YD+cd/PTvghHAj2tM6Hm3eAGnbWUcBmQi2M1wvjz96yoJ
 VdroFbqOBbG5I+JMpwg5BekxibyfJcegZm7RcfPyWIBx/JDIo+06iKEckrNgEj0=
X-Google-Smtp-Source: AGHT+IEmfb/1lrYoTufHR0VUsP8grhW3BKt189AURy+KvlT1abEPbI/unsdxGMOOMFpiQDqglw9PyQ==
X-Received: by 2002:a2e:b53c:0:b0:2d8:408c:3f5b with SMTP id
 z28-20020a2eb53c000000b002d8408c3f5bmr738349ljm.5.1714634758959; 
 Thu, 02 May 2024 00:25:58 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 m37-20020a05600c3b2500b0041816c3049csm922663wms.11.2024.05.02.00.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 00:25:58 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Tobias Waldekranz <tobias@waldekranz.com>, Simon Glass
 <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Bin Meng <bmeng@tinylab.org>, Johan
 Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, Dan
 Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH 14/81] block: Remove <common.h> and add needed includes
In-Reply-To: <20240502013138.2383421-14-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
 <20240502013138.2383421-14-trini@konsulko.com>
Date: Thu, 02 May 2024 09:25:55 +0200
Message-ID: <87wmoc4qv0.fsf@baylibre.com>
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
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tobias Waldekranz <tobias@waldekranz.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Bin Meng <bmeng@tinylab.org>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/block/blk-uclass.c       | 1 -
>  drivers/block/blk_legacy.c       | 1 -
>  drivers/block/blkcache.c         | 1 -
>  drivers/block/blkmap.c           | 1 -
>  drivers/block/efi-media-uclass.c | 1 -
>  drivers/block/efi_blk.c          | 1 -
>  drivers/block/host-uclass.c      | 1 -
>  drivers/block/host_dev.c         | 1 -
>  drivers/block/ide.c              | 1 -
>  drivers/block/sandbox.c          | 1 -
>  drivers/block/sb_efi_media.c     | 1 -
>  11 files changed, 11 deletions(-)
>
> diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
> index 77066da352a3..512c952f4d7a 100644
> --- a/drivers/block/blk-uclass.c
> +++ b/drivers/block/blk-uclass.c
> @@ -6,7 +6,6 @@
>  
>  #define LOG_CATEGORY UCLASS_BLK
>  
> -#include <common.h>
>  #include <blk.h>
>  #include <dm.h>
>  #include <log.h>
> diff --git a/drivers/block/blk_legacy.c b/drivers/block/blk_legacy.c
> index 5bf1d0471524..f36932183d1f 100644
> --- a/drivers/block/blk_legacy.c
> +++ b/drivers/block/blk_legacy.c
> @@ -4,7 +4,6 @@
>   * Written by Simon Glass <sjg@chromium.org>
>   */
>  
> -#include <common.h>
>  #include <blk.h>
>  #include <part.h>
>  #include <linux/err.h>
> diff --git a/drivers/block/blkcache.c b/drivers/block/blkcache.c
> index 26bcbea43533..0e69160249c7 100644
> --- a/drivers/block/blkcache.c
> +++ b/drivers/block/blkcache.c
> @@ -4,7 +4,6 @@
>   * Author: Eric Nelson<eric@nelint.com>
>   *
>   */
> -#include <common.h>
>  #include <blk.h>
>  #include <log.h>
>  #include <malloc.h>
> diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
> index 21201409ed4b..34eed1380dca 100644
> --- a/drivers/block/blkmap.c
> +++ b/drivers/block/blkmap.c
> @@ -4,7 +4,6 @@
>   * Author: Tobias Waldekranz <tobias@waldekranz.com>
>   */
>  
> -#include <common.h>
>  #include <blk.h>
>  #include <blkmap.h>
>  #include <dm.h>
> diff --git a/drivers/block/efi-media-uclass.c b/drivers/block/efi-media-uclass.c
> index e012f6f2f4c4..dc5e4f59b7f3 100644
> --- a/drivers/block/efi-media-uclass.c
> +++ b/drivers/block/efi-media-uclass.c
> @@ -5,7 +5,6 @@
>   * Copyright 2021 Google LLC
>   */
>  
> -#include <common.h>
>  #include <dm.h>
>  
>  UCLASS_DRIVER(efi_media) = {
> diff --git a/drivers/block/efi_blk.c b/drivers/block/efi_blk.c
> index 917a19f60254..9766cd6f8327 100644
> --- a/drivers/block/efi_blk.c
> +++ b/drivers/block/efi_blk.c
> @@ -8,7 +8,6 @@
>   * Copyright 2021 Google LLC
>   */
>  
> -#include <common.h>
>  #include <blk.h>
>  #include <dm.h>
>  #include <efi.h>
> diff --git a/drivers/block/host-uclass.c b/drivers/block/host-uclass.c
> index b3647e3ce335..cf42bd1e07ac 100644
> --- a/drivers/block/host-uclass.c
> +++ b/drivers/block/host-uclass.c
> @@ -9,7 +9,6 @@
>  
>  #define LOG_CATEGORY UCLASS_HOST
>  
> -#include <common.h>
>  #include <blk.h>
>  #include <dm.h>
>  #include <malloc.h>
> diff --git a/drivers/block/host_dev.c b/drivers/block/host_dev.c
> index 52313435a0cb..b3ff3cd1fab9 100644
> --- a/drivers/block/host_dev.c
> +++ b/drivers/block/host_dev.c
> @@ -9,7 +9,6 @@
>  
>  #define LOG_CATEGORY UCLASS_HOST
>  
> -#include <common.h>
>  #include <blk.h>
>  #include <bootdev.h>
>  #include <dm.h>
> diff --git a/drivers/block/ide.c b/drivers/block/ide.c
> index c698f9cbd558..b16623d7a3ab 100644
> --- a/drivers/block/ide.c
> +++ b/drivers/block/ide.c
> @@ -6,7 +6,6 @@
>  
>  #define LOG_CATEGORY UCLASS_IDE
>  
> -#include <common.h>
>  #include <ata.h>
>  #include <blk.h>
>  #include <bootdev.h>
> diff --git a/drivers/block/sandbox.c b/drivers/block/sandbox.c
> index be4e02cb601a..ec34f1ad8c2e 100644
> --- a/drivers/block/sandbox.c
> +++ b/drivers/block/sandbox.c
> @@ -3,7 +3,6 @@
>   * Copyright (C) 2013 Henrik Nordstrom <henrik@henriknordstrom.net>
>   */
>  
> -#include <common.h>
>  #include <blk.h>
>  #include <dm.h>
>  #include <fdtdec.h>
> diff --git a/drivers/block/sb_efi_media.c b/drivers/block/sb_efi_media.c
> index 52af155a6001..3255db064961 100644
> --- a/drivers/block/sb_efi_media.c
> +++ b/drivers/block/sb_efi_media.c
> @@ -5,7 +5,6 @@
>   * Copyright 2021 Google LLC
>   */
>  
> -#include <common.h>
>  #include <dm.h>
>  
>  static const struct udevice_id sandbox_efi_media_ids[] = {
> -- 
> 2.34.1
