Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C20C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:33:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 196C4885CF;
	Fri, 26 Jul 2024 01:32:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HxQQ2Hnd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F8008842C; Fri, 26 Jul 2024 01:32:46 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F2948841E
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6b79b93a4c9so753716d6.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950361; x=1722555161; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h3FCCoWDzGRswDe0GpLkwx4MxQtrGeEyJCqPCYavPEA=;
 b=HxQQ2Hndcd2BzoupALc0S06JzxwZ6gJxwawKapV3q3zwsXMw9ZSJGBJXfvaBtP8Yyc
 MjmV/fEjK/j6QxWEaIjGo/QIZJUzdOxbr4xHBphGgYLsAIvBL2Hk0KPE937SgfgYpnsc
 fNFlE0c+TL4OIQJ+kvkBOT+8VcG2+7SLeMuYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950361; x=1722555161;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h3FCCoWDzGRswDe0GpLkwx4MxQtrGeEyJCqPCYavPEA=;
 b=lxrrp9MqOchrdKnZK0qUOW7JR1H2jym1cWjCTf/zKl4OvVG7y7xo1yS5QUOaDWsZb9
 uCY4GLq9UUHzOFLOBGsuCH2Oy3Nm9sOKQXqtNZVorogQaNNtHFfvIU5mp484MakOZKAJ
 ZLRHZg4/66biVmJAs4rDpRdDDjQeNOqARiz8hmWwuil3RKg63+l8oT9zZ1oRKofdBpnx
 +ArC1sc568gjyJKGYMbm7vsaossQwYFLMRoDMCySqPHg9W//6aMlefzl9MSqr6XtSSo4
 ySJ5D/BM2Vh9DaFrcZv9vticI0S7yXezMfSXHVWV4Wtu/IRblI+TsdawQd8Moeib1bR4
 0HAQ==
X-Gm-Message-State: AOJu0YyulFrdsBcDujJWw+0Sauc/5sYiehpAX2dBspQqYNj3tCIpbBen
 RmavTRZPA9/2jTh2WwtfJTqMf4oofsfuN7Z+2DM+M8W42GnbkzbC/lQHRylWE6kbGTvjJw2kL3O
 aibDUu4NjdvdCEewSm1wFOE7P18xuj+mHPEM/EkpBpRRpJJg=
X-Google-Smtp-Source: AGHT+IH62uG5ldH5Gi7Ade0DGhQbPipZigdzE0sxXkeyM8pvy9QxxfTU1yeeWalH+iDGXNHW9GXP5GSnwClvPcEiDQI=
X-Received: by 2002:ad4:424e:0:b0:6b0:8991:a2f7 with SMTP id
 6a1803df08f44-6b99129ef92mr119963146d6.12.1721950361092; Thu, 25 Jul 2024
 16:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-23-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-23-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:30 -0600
Message-ID: <CAFLszTgriMAkLmeB18SyWKf-mGh=mbEHooKb5PyTsY2y25mrFg@mail.gmail.com>
Subject: Re: [PATCH 22/40] lmb: init: initialise the lmb data structures
 during board init
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
> The memory map maintained by the LMB module is now persistent and
> global. This memory map is being maintained through the alloced list
> structure which can be extended at runtime -- there is one list for
> the available memory, and one for the used memory. Allocate and
> initialise these lists during the board init.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: None
>
>  common/board_r.c |  4 ++++
>  common/spl/spl.c |  3 +++
>  include/lmb.h    | 11 +++++++++++
>  lib/lmb.c        | 20 ++++++++++++++++++++
>  4 files changed, 38 insertions(+)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index d4ba245ac6..eaf9b40ec0 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -22,6 +22,7 @@
>  #include <hang.h>
>  #include <image.h>
>  #include <irq_func.h>
> +#include <lmb.h>
>  #include <log.h>
>  #include <net.h>
>  #include <asm/cache.h>
> @@ -610,6 +611,9 @@ static init_fnc_t init_sequence_r[] = {
>  #ifdef CONFIG_CLOCKS
>         set_cpu_clk_info, /* Setup clock information */
>  #endif
> +#if CONFIG_IS_ENABLED(LMB)
> +       initr_lmb,
> +#endif

Can you put the if() in the function, to avoid #ifdefs here?

>  #ifdef CONFIG_EFI_LOADER
>         efi_memory_init,
>  #endif
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 7794ddccad..38ac0608bb 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -723,6 +723,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
>             IS_ENABLED(CONFIG_SPL_ATF))
>                 dram_init_banksize();
>
> +       if (IS_ENABLED(CONFIG_SPL_LMB))
> +               initr_lmb();
> +

Still unsure why this is needed. I'm also not sure how it works, since
SPL allocations will not transfer to U-Boot proper.

>         if (CONFIG_IS_ENABLED(PCI) && !(gd->flags & GD_FLG_DM_DEAD)) {
>                 ret = pci_init();
>                 if (ret)
> diff --git a/include/lmb.h b/include/lmb.h
> index 2d8f9a6b71..cc4cf9f3c8 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -37,6 +37,17 @@ struct lmb_region {
>         enum lmb_flags flags;
>  };
>
> +/**
> + * initr_lmb() - Initialise the LMB lists
> + *
> + * Initialise the LMB lists needed for keeping the memory map. There
> + * are two lists, in form of alloced list data structure. One for the
> + * available memory, and one for the used memory.
> + *
> + * Return: 0 on success, -ve on error
> + */
> +int initr_lmb(void);
> +
>  /**
>   * lmb_add_memory() - Add memory range for LMB allocations
>   *
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 5afdfc32fb..5baa5c4c52 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -783,3 +783,23 @@ int lmb_mem_regions_init(void)
>
>         return 0;
>  }
> +
> +/**
> + * initr_lmb() - Initialise the LMB lists
> + *
> + * Initialise the LMB lists needed for keeping the memory map. There
> + * are two lists, in form of alloced list data structure. One for the
> + * available memory, and one for the used memory.
> + *
> + * Return: 0 on success, -ve on error
> + */
> +int initr_lmb(void)
> +{
> +       int ret;
> +
> +       ret = lmb_mem_regions_init();
> +       if (ret)
> +               printf("Unable to initialise the LMB data structures\n");
> +
> +       return ret;
> +}
> --
> 2.34.1
>

Regards,
Simon
