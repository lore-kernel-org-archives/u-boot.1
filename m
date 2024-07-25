Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3AEC3DA70
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAEB88842C;
	Fri, 26 Jul 2024 01:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dlBoYPJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91CD9884BE; Fri, 26 Jul 2024 01:32:42 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2CB7884C5
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-65f8626780aso14934597b3.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950359; x=1722555159; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MRUY/nsj+LCTxtQQ8MbKX/IVm3a4nKZ0jt5OLsea03Q=;
 b=dlBoYPJcse0zJumAJeAOz7LDU0L+eVSbssQc3YVnoENGNuufhtWPbGQWibdD4GJ5lP
 ds8TszyC/PyXoD4Abpxdew9sDGS9HP1Y76lM9SJXElViSKF9lBwaICG6/Cl8WVtJq/gf
 8XLsPUkZmhV6ZkmWLFkge1uaAJmEiIKkWgSwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950359; x=1722555159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MRUY/nsj+LCTxtQQ8MbKX/IVm3a4nKZ0jt5OLsea03Q=;
 b=Lb3hNWaEroUW3SGbT9ZFo1ZS4v/0ru8db7Cos6fiF6DE9boO++5X9GqmqY6PV/u3lY
 r2lEpZv4hW1u/m7iOczW7C+0Q77SMoYtiXF8WnY68DFOGLPyqUdvljvBpBEQ2dJD3Kqi
 Nyk7jIyTPWUUp2TJ89MzI7JAYnTJx6i9ETKdC5JMjBgK3HEyDJE4MEsFP/34inLZgT9W
 qbvFy+v+gT4Eq1zwZGlBBUK04tq7pt0FqwhLcPScTKD7th8iMwOTW/wJLQTh5NM5zPY3
 6Cb968sj/qOOnC5JDmYMlIr7SLCdn7nBrtHR8sJfKF3F8c4qi+EGlrQWUywiC3ckjhAO
 E5jA==
X-Gm-Message-State: AOJu0Yy1hKoq9ofnbEpqYhjkOqFzNEsVtycczQkvGk9KtGkZpN/A0R0q
 8nwiuydsWpu6hjizIevNvG7JnciVz4VeZhlNiMznseVo+IBnDDHhis9gZJ+F1UPEnKjw1+s+LiN
 leQp8nNhc3+a1Ig0/kctmcUqXt2XiGs0oPCGW
X-Google-Smtp-Source: AGHT+IHnutacuI+T+jLzPPCmuWRPCTGxWQcJvTu6D5YKsRemSy/YzN7U0h47Myi2fWQC0iHLGKVEUc4MOZw8GmnBnck=
X-Received: by 2002:a0d:f5c7:0:b0:64a:79f6:2f2d with SMTP id
 00721157ae682-675b9b60514mr36186687b3.31.1721950358766; Thu, 25 Jul 2024
 16:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-18-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-18-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:27 -0600
Message-ID: <CAFLszTgrxZBkOgcrq0cwtrGs7UdFsqxH9srg0rBmxLfummg9qw@mail.gmail.com>
Subject: Re: [PATCH 17/40] lmb: introduce a function to add memory to the lmb
 memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Introduce a function lmb_add_memory() to add available memory to the
> LMB memory map. Call this function during board init once the LMB data
> structures have been initialised.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: None
>
>  include/lmb.h | 12 ++++++++++++
>  lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index a308796d58..77e2a23c0d 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -40,6 +40,18 @@ struct lmb_region {
>  void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
>  void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
>                                 void *fdt_blob);
> +
> +/**
> + * lmb_add_memory() - Add memory range for LMB allocations
> + *
> + * Add the entire available memory range to the pool of memory that
> + * can be used by the LMB module for allocations.
> + *
> + * Return: None
> + *
> + */
> +void lmb_add_memory(void);
> +
>  long lmb_add(phys_addr_t base, phys_size_t size);
>  long lmb_reserve(phys_addr_t base, phys_size_t size);
>  /**
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 88352e9a25..db0874371a 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -239,6 +239,46 @@ void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob)
>         lmb_reserve_common(fdt_blob);
>  }
>
> +/**
> + * lmb_add_memory() - Add memory range for LMB allocations
> + *
> + * Add the entire available memory range to the pool of memory that
> + * can be used by the LMB module for allocations.
> + *
> + * This can be overridden for specific boards/architectures.

Why is this needed? I'm really not a fan of weak functions...it often
means we should have a proper API for it.

> + *
> + * Return: None
> + *
> + */
> +__weak void lmb_add_memory(void)
> +{
> +       int i;
> +       phys_size_t size;
> +       phys_addr_t rgn_top;
> +       u64 ram_top = gd->ram_top;
> +       struct bd_info *bd = gd->bd;
> +
> +       /* Assume a 4GB ram_top if not defined */
> +       if (!ram_top)
> +               ram_top = 0x100000000ULL;
> +
> +       for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> +               size = bd->bi_dram[i].size;
> +               if (size) {
> +                       if (bd->bi_dram[i].start > ram_top)
> +                               continue;
> +
> +                       rgn_top = bd->bi_dram[i].start +
> +                               bd->bi_dram[i].size;
> +
> +                       if (rgn_top > ram_top)
> +                               size -= rgn_top - ram_top;
> +
> +                       lmb_add(bd->bi_dram[i].start, size);
> +               }
> +       }
> +}
> +
>  /* Initialize the struct, add memory and call arch/board reserve functions */
>  void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
>                                 void *fdt_blob)
> @@ -728,5 +768,7 @@ int lmb_mem_regions_init(void)
>                 return -1;
>         }
>
> +       lmb_add_memory();
> +
>         return 0;
>  }
> --
> 2.34.1
>

Regards,
Simon
