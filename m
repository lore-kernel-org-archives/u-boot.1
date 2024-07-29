Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B643C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 29 Jul 2024 08:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 674EF87F51;
	Mon, 29 Jul 2024 10:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wGKIATIM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0BBD88418; Mon, 29 Jul 2024 10:36:30 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C11E87F51
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 10:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5b214865fecso930788a12.1
 for <u-boot@lists.denx.de>; Mon, 29 Jul 2024 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722242188; x=1722846988; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oUWFwTR3RVEXew73l6yvqZ3Z6WmMlN/vpG06YrBWu7k=;
 b=wGKIATIMWjJUin1Z0GPuAEl3AqvsWbslit9kcJmSEO4251yzTz1qsDfrTA9ZaOcw+v
 kJdfLlrBhbP28+dcsngdgwzuapOHJdf+mJIIp/GHpzAnCSyTpeelN8Xzm0Z4j/nd/5qg
 ZjzM99vhHrciP8lIJuYbyqrPLi7hckOVodaLAReKA4NqZt7XkscR/PTzqxkuU/XZ5D0h
 t9FnaaN9T5GBOvkO/CET5T5upR8PmVE8rWk+LRpEn6iXqkj65Pl7gsJoNClGlnSfVG/B
 F7NA4qwgmaMJ5X1MENM8gAD7L76lKQOsyJYFwUh2ZuS5IT0suvBC51U0Khe6VCtLsVd9
 +oKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722242188; x=1722846988;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oUWFwTR3RVEXew73l6yvqZ3Z6WmMlN/vpG06YrBWu7k=;
 b=H6dzIcrFIwR6bioNO+GrRM/65q2KkSRgIjz9blxwDkj57pwkDP+0o8l4xv7Gi8+oRR
 0gjxkNG915pYHN9Upz+r1sYSRTgT59yY4t6xYg9pgj1XYM5wyb+qvKSQCGjmaeIBYsJ8
 i4tU2enuI8Cv5BukeQiznBEDqHhHQz3RiiauzUNNe0d0M4jERVfFjvvP5Y0ZNVFihBUK
 ve5McUSAXUSzTDRSMWJ8Ct/ysTeUMXqm2kUKQiFNLeuxBBBoYh3hCPm8f8I6qt0mX3dl
 skW5+i8VZ/dedIeGdd2zseJOspaqc7W+g7QdECBGpucBNLu8np0eugswnwCM4kP4Y8e7
 37tw==
X-Gm-Message-State: AOJu0YxNZCQaRJAC5iUHifDxuqinjrZUA/zDr2dMBer57FuFlBn5UamT
 GNMT/9eYVRzksIxsmW/+BQc7crP8ftJH4SrwUAdYlUSfMvqqpqAI90e390U3gt8OSlL8YN/5g/l
 wGoLXezuKjCiE9dnsXYpDoZX7WJKmN3lsNcnaRA==
X-Google-Smtp-Source: AGHT+IGE1nYUAsD715b7j0wNiWuKUHiU3EqzT0JxmUduSAI2UtKV6r60d/z6NSsOjgBUmnTexUEWn4Fa5GrU933XuQ4=
X-Received: by 2002:a50:d482:0:b0:5a0:d754:5ec5 with SMTP id
 4fb4d7f45d1cf-5b021d21b76mr4372565a12.26.1722242187799; Mon, 29 Jul 2024
 01:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-23-sughosh.ganu@linaro.org>
 <CAFLszTgriMAkLmeB18SyWKf-mGh=mbEHooKb5PyTsY2y25mrFg@mail.gmail.com>
In-Reply-To: <CAFLszTgriMAkLmeB18SyWKf-mGh=mbEHooKb5PyTsY2y25mrFg@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 29 Jul 2024 14:06:16 +0530
Message-ID: <CADg8p97T7p=EoXCQwaxrHais7PYCHD8mWLSE8QWY5xB6pZADYg@mail.gmail.com>
Subject: Re: [PATCH 22/40] lmb: init: initialise the lmb data structures
 during board init
To: Simon Glass <sjg@chromium.org>
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

On Fri, 26 Jul 2024 at 05:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The memory map maintained by the LMB module is now persistent and
> > global. This memory map is being maintained through the alloced list
> > structure which can be extended at runtime -- there is one list for
> > the available memory, and one for the used memory. Allocate and
> > initialise these lists during the board init.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since rfc: None
> >
> >  common/board_r.c |  4 ++++
> >  common/spl/spl.c |  3 +++
> >  include/lmb.h    | 11 +++++++++++
> >  lib/lmb.c        | 20 ++++++++++++++++++++
> >  4 files changed, 38 insertions(+)
> >
> > diff --git a/common/board_r.c b/common/board_r.c
> > index d4ba245ac6..eaf9b40ec0 100644
> > --- a/common/board_r.c
> > +++ b/common/board_r.c
> > @@ -22,6 +22,7 @@
> >  #include <hang.h>
> >  #include <image.h>
> >  #include <irq_func.h>
> > +#include <lmb.h>
> >  #include <log.h>
> >  #include <net.h>
> >  #include <asm/cache.h>
> > @@ -610,6 +611,9 @@ static init_fnc_t init_sequence_r[] = {
> >  #ifdef CONFIG_CLOCKS
> >         set_cpu_clk_info, /* Setup clock information */
> >  #endif
> > +#if CONFIG_IS_ENABLED(LMB)
> > +       initr_lmb,
> > +#endif
>
> Can you put the if() in the function, to avoid #ifdefs here?

Will do

>
> >  #ifdef CONFIG_EFI_LOADER
> >         efi_memory_init,
> >  #endif
> > diff --git a/common/spl/spl.c b/common/spl/spl.c
> > index 7794ddccad..38ac0608bb 100644
> > --- a/common/spl/spl.c
> > +++ b/common/spl/spl.c
> > @@ -723,6 +723,9 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
> >             IS_ENABLED(CONFIG_SPL_ATF))
> >                 dram_init_banksize();
> >
> > +       if (IS_ENABLED(CONFIG_SPL_LMB))
> > +               initr_lmb();
> > +
>
> Still unsure why this is needed. I'm also not sure how it works, since
> SPL allocations will not transfer to U-Boot proper.

I am not sure if I get your question right, but we initialise the LMB
lists, and add to it's available memory map, both in SPL and in U-Boot
proper. These are being initialised for SPL separately once the ram
memory has been set up, including the dram banksize values.

-sughosh

>
> >         if (CONFIG_IS_ENABLED(PCI) && !(gd->flags & GD_FLG_DM_DEAD)) {
> >                 ret = pci_init();
> >                 if (ret)
> > diff --git a/include/lmb.h b/include/lmb.h
> > index 2d8f9a6b71..cc4cf9f3c8 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -37,6 +37,17 @@ struct lmb_region {
> >         enum lmb_flags flags;
> >  };
> >
> > +/**
> > + * initr_lmb() - Initialise the LMB lists
> > + *
> > + * Initialise the LMB lists needed for keeping the memory map. There
> > + * are two lists, in form of alloced list data structure. One for the
> > + * available memory, and one for the used memory.
> > + *
> > + * Return: 0 on success, -ve on error
> > + */
> > +int initr_lmb(void);
> > +
> >  /**
> >   * lmb_add_memory() - Add memory range for LMB allocations
> >   *
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 5afdfc32fb..5baa5c4c52 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -783,3 +783,23 @@ int lmb_mem_regions_init(void)
> >
> >         return 0;
> >  }
> > +
> > +/**
> > + * initr_lmb() - Initialise the LMB lists
> > + *
> > + * Initialise the LMB lists needed for keeping the memory map. There
> > + * are two lists, in form of alloced list data structure. One for the
> > + * available memory, and one for the used memory.
> > + *
> > + * Return: 0 on success, -ve on error
> > + */
> > +int initr_lmb(void)
> > +{
> > +       int ret;
> > +
> > +       ret = lmb_mem_regions_init();
> > +       if (ret)
> > +               printf("Unable to initialise the LMB data structures\n");
> > +
> > +       return ret;
> > +}
> > --
> > 2.34.1
> >
>
> Regards,
> Simon
