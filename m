Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035F4C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 12:26:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52B0288CCE;
	Thu,  2 May 2024 14:26:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ngEL+8mP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21C1F88CA4; Thu,  2 May 2024 14:26:23 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2518B88CCE
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 14:26:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=oliver.graute@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41dc9c83e57so4787435e9.0
 for <u-boot@lists.denx.de>; Thu, 02 May 2024 05:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714652780; x=1715257580; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S8v4BGVYdqbvFvvYn3X4jkTPd1Jd5fLG/VipTkBjHGg=;
 b=ngEL+8mP2ei6r/hZNaDhFbzk9BL/FHLKtjsU0J+7Q27yaFXE2m1sb87zguED/h9liL
 NJB0ZDpiIQzHlma+nfFJInICwMz2dhjW/xsb1CjhURIuFT3kiE5mnISzLd02WxeVB+pQ
 VGNsQmMSQJGoOHy5UQ5oQYxepukX378urD7ev73mzSX68Nh5hplNlIJwAXfv1Tr2Tfgn
 ZmUB149vTWNVNZSdTCl/0WwmLrqMO9rQJLDCnAQcjLO007iGKmy3d0PMepGspS9A5qc3
 i2yB6iyWQJ11MQ6HvVhzx5WGUuGM2xScKkLqFlu2c7IkdiUOYg+YEizsfN69M9XhafVG
 /czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714652780; x=1715257580;
 h=in-reply-to:content-disposition:mime-version:references
 :mail-followup-to:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S8v4BGVYdqbvFvvYn3X4jkTPd1Jd5fLG/VipTkBjHGg=;
 b=mxiNPVF0yao5hJ0q13CdEYHSc9IaH3yJQZFS+e4ZAzachA3e6MkTgw3O1nbT8cQTBV
 r4GQ7ZABqNvxGmfcPolU/e2fv/GZIjJqVEQfDkdNiyUFxMOAtHYGrHyNz1sXLberl6Ux
 0+L190K6E4CCpTr3MXZdFh6C4oFK9iV53Z6hggzlN3HaBSq3HwFeJ8loVCidmuQdBqpP
 vCnkDs0eB5/a08MilLszU1XDUi0nWOuGjvZRLGZaWnaV1QmcnB2/kaPHWMHn2Wq3B0Xi
 +6ZBXkjAsTkkGasFIjrSTSf065nzWnwkI+JvVYqUV4x9vAFYwcdWhKVggJ0jGKAB7V1S
 2Grw==
X-Gm-Message-State: AOJu0Yx7yKmhDp0MPV+Rhh+tEiULlDObjDZ2oG3ZJwQVvZR7UGlqmtuO
 tX3xsinqpOajFzeYJ9VOMywW+F3u6cN8jNYPhMQ9BGESKjYOztEFEzEBBhSn
X-Google-Smtp-Source: AGHT+IHaDtfATyEoU2pzgJt1HtQvi5NPuxWO5JqhgDmItEMFWxzsx2FVVKhyHiQkpa3kWbRJbxew5g==
X-Received: by 2002:a05:600c:3c9e:b0:418:3ea8:46c0 with SMTP id
 bg30-20020a05600c3c9e00b004183ea846c0mr2244155wmb.13.1714652780441; 
 Thu, 02 May 2024 05:26:20 -0700 (PDT)
Received: from localhost ([217.151.144.138]) by smtp.gmail.com with ESMTPSA id
 k5-20020a05600c1c8500b0041bab13cd74sm1811366wms.17.2024.05.02.05.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 05:26:20 -0700 (PDT)
From: Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver.graute@kococonnector.com>
Date: Thu, 2 May 2024 14:15:33 +0200
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 George McCollister <george.mccollister@gmail.com>
Subject: Re: [PATCH 013/149] board: advantech: Remove <common.h> and add
 needed includes
Message-ID: <ZjOD5Yu00gDz+UnU@graute-think>
Mail-Followup-To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 George McCollister <george.mccollister@gmail.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
 <20240501024316.1767971-13-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501024316.1767971-13-trini@konsulko.com>
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

On 30/04/24, Tom Rini wrote:
> Remove <common.h> from this board vendor directory and when needed
> add missing include files directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> Cc: Oliver Graute <oliver.graute@kococonnector.com>
> Cc: George McCollister <george.mccollister@gmail.com>
> ---
>  board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c       | 1 -
>  board/advantech/imx8mp_rsb3720a1/spl.c                    | 2 +-
>  board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c     | 1 -
>  board/advantech/imx8qm_dmsse20_a1/spl.c                   | 2 +-
>  board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c     | 1 -
>  board/advantech/imx8qm_rom7720_a1/spl.c                   | 2 +-
>  board/advantech/som-db5800-som-6867/som-db5800-som-6867.c | 1 -
>  7 files changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
> index d87fe3606f6a..070933fb54b2 100644
> --- a/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
> +++ b/board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c
> @@ -4,7 +4,6 @@
>   * Copyright 2022 Linaro
>   */
>  
> -#include <common.h>
>  #include <dwc3-uboot.h>
>  #include <efi.h>
>  #include <efi_loader.h>
> diff --git a/board/advantech/imx8mp_rsb3720a1/spl.c b/board/advantech/imx8mp_rsb3720a1/spl.c
> index f4257bc993d6..1f7c1f25adcf 100644
> --- a/board/advantech/imx8mp_rsb3720a1/spl.c
> +++ b/board/advantech/imx8mp_rsb3720a1/spl.c
> @@ -4,7 +4,7 @@
>   * Copyright 2022 Linaro
>   */
>  
> -#include <common.h>
> +#include <config.h>
>  #include <command.h>
>  #include <cpu_func.h>
>  #include <errno.h>
> diff --git a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
> index 56b7bdb57c94..50b35db5f6cf 100644
> --- a/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
> +++ b/board/advantech/imx8qm_dmsse20_a1/imx8qm_dmsse20_a1.c
> @@ -4,7 +4,6 @@
>   * Copyright 2019-2023 Kococonnector GmbH
>   */
>  
> -#include <common.h>
>  #include <errno.h>
>  #include <linux/libfdt.h>
>  #include <asm/io.h>
> diff --git a/board/advantech/imx8qm_dmsse20_a1/spl.c b/board/advantech/imx8qm_dmsse20_a1/spl.c
> index e8959ede51d9..93cf07440026 100644
> --- a/board/advantech/imx8qm_dmsse20_a1/spl.c
> +++ b/board/advantech/imx8qm_dmsse20_a1/spl.c
> @@ -3,7 +3,7 @@
>   * Copyright 2017-2018 NXP
>   * Copyright 2019-2023 Kococonnector GmbH
>   */
> -#include <common.h>
> +#include <config.h>
>  #include <dm.h>
>  #include <spl.h>
>  #include <init.h>
> diff --git a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
> index 7f766a688bb5..3def182f2967 100644
> --- a/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
> +++ b/board/advantech/imx8qm_rom7720_a1/imx8qm_rom7720_a1.c
> @@ -4,7 +4,6 @@
>   * Copyright (C) 2019 Oliver Graute <oliver.graute@kococonnector.com>
>   */
>  
> -#include <common.h>
>  #include <cpu_func.h>
>  #include <env.h>
>  #include <errno.h>
> diff --git a/board/advantech/imx8qm_rom7720_a1/spl.c b/board/advantech/imx8qm_rom7720_a1/spl.c
> index d32400101fc9..5863e335a8bc 100644
> --- a/board/advantech/imx8qm_rom7720_a1/spl.c
> +++ b/board/advantech/imx8qm_rom7720_a1/spl.c
> @@ -2,7 +2,7 @@
>  /*
>   * Copyright 2017-2018 NXP
>   */
> -#include <common.h>
> +#include <config.h>
>  #include <dm.h>
>  #include <image.h>
>  #include <init.h>
> diff --git a/board/advantech/som-db5800-som-6867/som-db5800-som-6867.c b/board/advantech/som-db5800-som-6867/som-db5800-som-6867.c
> index 8499fc541fa7..9bbd5fd291aa 100644
> --- a/board/advantech/som-db5800-som-6867/som-db5800-som-6867.c
> +++ b/board/advantech/som-db5800-som-6867/som-db5800-som-6867.c
> @@ -4,7 +4,6 @@
>   * Copyright (C) 2016 George McCollister <george.mccollister@gmail.com>
>   */
>  
> -#include <common.h>
>  #include <init.h>
>  #include <asm/fsp1/fsp_support.h>
>  
> -- 
> 2.34.1
> 
Acked-by: Oliver Graute <oliver.graute@kococonnector.com>
