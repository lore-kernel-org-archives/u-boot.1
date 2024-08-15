Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD89FC52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 727D088BB6;
	Thu, 15 Aug 2024 22:34:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bnRWV3ig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB54688C50; Thu, 15 Aug 2024 22:34:11 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DD3888C6E
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2d3da6d3f22so410820a91.0
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754047; x=1724358847; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1NPe1xlUHZETDFYId8MT+bt+P7uMfsr2RYvjbj0mJXE=;
 b=bnRWV3igvXmfySsH2OwngS04lMX5Eb35LYWO1yaw0sT5UtL9RbmKV4gbuFqLFd3vLn
 gSDG2YiYnKm6LwlSY4vz6l+bmPurk8mvjd9/5rZ3Xe8iVmtIQ4n3pICSF8cC3l/xkWal
 os0jhYU/VAbOiUBHIq8pvX2xNK3zGcCru4uXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754047; x=1724358847;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1NPe1xlUHZETDFYId8MT+bt+P7uMfsr2RYvjbj0mJXE=;
 b=TCCNKoFJtcADpLiOcFLw6Zocq6IWo8Lk4W9PuXMzFYAwlcuNKu6XD/UCaJZmPvgwe4
 B6nLzPo9cauih8j1HNaDDkpCFe2SeczJHiivcChJb+ScZtXIDU6FVJlek/Rh/CSiEg+7
 FCiuAE0eO3MekMOnS7If2Bovddedu4W1Sf3OlylRjKDZ/n40Op6WuuUhH+BxJ49ZBOzX
 t0wgwI9TAsNDDNnVjSFWhYJ53i3S+ETtsznLG4TqawgZnv40Rce479QIyBWnapvs8+al
 gtlb9Z9MHwFMxyhXXyKAKqcnmPiAuqFwDTuhsq2LTHIjF3eELvrJ7Eq0D6k57Xc9F3nf
 3ePg==
X-Gm-Message-State: AOJu0YyFVznzWONj6z4h94jlrjc1sMemgSY2Fe6MvEvMiTKtRTBEnaVP
 JyG8ZGHoLsJAy+bnitnvG7nr4azWIrigd14XPfLUm8uO8IFuMS8185uWp9iYISKSyw9JgOw2h6Q
 MdIw9RmJZqYocDLUPkmay7JrMSxjMTeFJMLTH
X-Google-Smtp-Source: AGHT+IH1Gtg+F6C2qzOS9STrQ2/DRcYDIbNucjlN0CW2yIGRxWqHrt/GmStRHQdwvUySKjr5HYCPySoKruCtb9I3XW8=
X-Received: by 2002:a17:90b:b07:b0:2d3:dcc1:f98f with SMTP id
 98e67ed59e1d1-2d3dffb5360mr1025760a91.10.1723754046853; Thu, 15 Aug 2024
 13:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-15-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-15-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:33:55 +0100
Message-ID: <CAFLszTjMwpW-MRWfJrOja2JGMcTtjYzLqH68hum=yDsXjc6PQQ@mail.gmail.com>
Subject: Re: [PATCH v2 14/32] lmb: introduce a function to add memory to the
 lmb memory map
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
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

On Wed, 14 Aug 2024 at 12:01, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Introduce a function lmb_add_memory() to add available memory to the
> LMB memory map. Call this function during board init once the LMB data
> structures have been initialised.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Call the lmb_add_memory() from lmb_init() instead of
>   lmb_mem_regions_init().
>
>
>  include/lmb.h | 10 ++++++++++
>  lib/lmb.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

But this should not be weak.

> diff --git a/include/lmb.h b/include/lmb.h
> index f6b2a81546..a82ea63d6c 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -63,6 +63,16 @@ struct lmb {
>   */
>  int lmb_init(void);
>
> +/**
> + * lmb_add_memory() - Add memory range for LMB allocations
> + *
> + * Add the entire available memory range to the pool of memory that
> + * can be used by the LMB module for allocations.
> + *
> + * Return: None
> + */
> +void lmb_add_memory(void);
> +
>  long lmb_add(phys_addr_t base, phys_size_t size);
>  long lmb_reserve(phys_addr_t base, phys_size_t size);
>  /**
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 3ccee26a46..f35a94c41b 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -225,6 +225,46 @@ static void lmb_reserve_common(void *fdt_blob)
>                 efi_lmb_reserve();
>  }
>
> +/**
> + * lmb_add_memory() - Add memory range for LMB allocations
> + *
> + * Add the entire available memory range to the pool of memory that
> + * can be used by the LMB module for allocations.
> + *
> + * This can be overridden for specific boards/architectures.
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
>  static long lmb_resize_regions(struct alist *lmb_rgn_lst,
>                                unsigned long idx_start,
>                                phys_addr_t base, phys_size_t size)
> @@ -674,5 +714,7 @@ int lmb_init(void)
>                 return ret;
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
