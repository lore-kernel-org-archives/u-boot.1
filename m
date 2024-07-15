Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6AEC3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 09:48:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7353887E2;
	Mon, 15 Jul 2024 11:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BhwbROtO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04496887FA; Mon, 15 Jul 2024 11:48:38 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EB2D883DE
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 11:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-595850e7e11so5023156a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721036914; x=1721641714; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=46hQka6IgN2K7KwU6Ldh2qMv5TCMfrchtV+kJ4F7QYk=;
 b=BhwbROtOpEYYTk6hGCFpkzazsd+ysGYoc5QJVYlsBj3I71Uex6ZUn9Kua7FHuynadl
 KU7YlEhfYSZkC/IjHqh7/+ci2zINekP/tf72Ue3I7Vy0QJ5EbdXH2oVlPs43PuHjQe5I
 PHyeHtPMjw7P1kWXgymD6jPSdK9gkUGZjpneYa9cu5EPovWw0/CNvIsBj2kd7Xt+nDwC
 crVLkJnL22vz/4vCIa0grO6n4E5LU1fxgoBPxsSxbcGSx/2RmDdMVaMJxEkPIKzvG54j
 V+5FPom3WMDxjVZm5kGexmbFUmklQQoaQX2U0pJ0EGjk08VkP7u0EtLTDyDWzncs+CkH
 z3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721036915; x=1721641715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=46hQka6IgN2K7KwU6Ldh2qMv5TCMfrchtV+kJ4F7QYk=;
 b=v+nYWAjZQCRRf5VYa/GIhpcQdNo6C3bgkSFI4TKNCdgjtt6f0c4gQKh56qq4OtYQpV
 9C783W9P8QS1kAFx1zrkmxRlqj5GAHrLQZSSZQAm0Js5Ap0e99H1lGPGENqTdQXIQ83k
 pw/jQGlZhgKSS4KPxahJjFGrWMC2k0Rs2DGkD2keHkee8/Jo6iG/e4071/Hf7V9GD+Vj
 Kz+3wsfUhKohb8Uznw8kbfhsEyRLLb5Bdfo7wdxOZuTqV4pCe5aKhPw3qt5GkkA0SvF2
 Ft806x927HljxHOidbrn86OasgEINtkwbjYOdRrzkvepc/epXg4Zcbsou7kDx2BVwESA
 xShg==
X-Gm-Message-State: AOJu0YzD7+3y7j/ClGZo6iI7DsBmjG50buoXD0pBoVzop0w7pnwYRhQL
 iwouYcbZc/N9hBA34wBhz+KU+vedNxDxE2BEE4IJXl/g3ogkaBvTFAnuaSySteIvANXbQWibiKa
 KwfePvuhKU7hy8L444cEB94nAQBcmbB/OVJ3nkw==
X-Google-Smtp-Source: AGHT+IEeYXnAWTQVY4pTm961AQoATH798HMjLvQ6jjoecyeT71llQY7ZwTdeYgGb9a/xs5b0y2eEF2sZzXds7DwXrQ0=
X-Received: by 2002:a50:8a93:0:b0:579:e7c5:1001 with SMTP id
 4fb4d7f45d1cf-594ba59fdafmr10031570a12.23.1721036914482; Mon, 15 Jul 2024
 02:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-14-sughosh.ganu@linaro.org>
 <CAFLszTjPtFX60ZvJtcG=3z-waRpQMYad9-bsVPUsP0MmHkJ7jA@mail.gmail.com>
In-Reply-To: <CAFLszTjPtFX60ZvJtcG=3z-waRpQMYad9-bsVPUsP0MmHkJ7jA@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 15 Jul 2024 15:18:23 +0530
Message-ID: <CADg8p96u23yVvksHqGnVsNKqcQd=VpHsM4utktujzUqpwv3Ggg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/48] lmb: make LMB memory map persistent and
 global
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

hi Simon,

On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > The current LMB API's for allocating and reserving memory use a
> > per-caller based memory view. Memory allocated by a caller can then be
> > overwritten by another caller. Make these allocations and reservations
> > persistent using the alloced list data structure.
> >
> > Two alloced lists are declared -- one for the available(free) memory,
> > and one for the used memory. Once full, the list can then be extended
> > at runtime.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1:
> > * Use alloced list structure for the available and reserved memory
> >   lists instead of static arrays.
> > * Corresponding changes in the code made as a result of the above
> >   change.
> > * Rename the reserved memory list as 'used'.
> >
> >  include/lmb.h |  77 +++--------
> >  lib/lmb.c     | 346 ++++++++++++++++++++++++++++++--------------------
> >  2 files changed, 224 insertions(+), 199 deletions(-)
> >
> > diff --git a/include/lmb.h b/include/lmb.h
> > index 99fcf5781f..27cdb18c37 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -24,78 +24,18 @@ enum lmb_flags {
> >  };
> >
> >  /**
> > - * struct lmb_property - Description of one region.
> > + * struct lmb_region - Description of one region.
> >   *
> >   * @base:      Base address of the region.
> >   * @size:      Size of the region
> >   * @flags:     memory region attributes
> >   */
> > -struct lmb_property {
> > +struct lmb_region {
> >         phys_addr_t base;
> >         phys_size_t size;
> >         enum lmb_flags flags;
> >  };
> >
> > -/*
> > - * For regions size management, see LMB configuration in KConfig
> > - * all the #if test are done with CONFIG_LMB_USE_MAX_REGIONS (boolean)
> > - *
> > - * case 1. CONFIG_LMB_USE_MAX_REGIONS is defined (legacy mode)
> > - *         => CONFIG_LMB_MAX_REGIONS is used to configure the region size,
> > - *         directly in the array lmb_region.region[], with the same
> > - *         configuration for memory and reserved regions.
> > - *
> > - * case 2. CONFIG_LMB_USE_MAX_REGIONS is not defined, the size of each
> > - *         region is configurated *independently* with
> > - *         => CONFIG_LMB_MEMORY_REGIONS: struct lmb.memory_regions
> > - *         => CONFIG_LMB_RESERVED_REGIONS: struct lmb.reserved_regions
> > - *         lmb_region.region is only a pointer to the correct buffer,
> > - *         initialized in lmb_init(). This configuration is useful to manage
> > - *         more reserved memory regions with CONFIG_LMB_RESERVED_REGIONS.
> > - */
> > -
> > -/**
> > - * struct lmb_region - Description of a set of region.
> > - *
> > - * @cnt: Number of regions.
> > - * @max: Size of the region array, max value of cnt.
> > - * @region: Array of the region properties
> > - */
> > -struct lmb_region {
> > -       unsigned long cnt;
> > -       unsigned long max;
> > -#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> > -       struct lmb_property region[CONFIG_LMB_MAX_REGIONS];
> > -#else
> > -       struct lmb_property *region;
> > -#endif
> > -};
> > -
> > -/**
> > - * struct lmb - Logical memory block handle.
> > - *
> > - * Clients provide storage for Logical memory block (lmb) handles.
> > - * The content of the structure is managed by the lmb library.
> > - * A lmb struct is  initialized by lmb_init() functions.
> > - * The lmb struct is passed to all other lmb APIs.
> > - *
> > - * @memory: Description of memory regions.
> > - * @reserved: Description of reserved regions.
> > - * @memory_regions: Array of the memory regions (statically allocated)
> > - * @reserved_regions: Array of the reserved regions (statically allocated)
> > - */
> > -struct lmb {
> > -       struct lmb_region memory;
> > -       struct lmb_region reserved;
> > -#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> > -       struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
> > -       struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
> > -#endif
> > -};
> > -
> > -void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
> > -void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
> > -                               void *fdt_blob);
> >  long lmb_add(phys_addr_t base, phys_size_t size);
> >  long lmb_reserve(phys_addr_t base, phys_size_t size);
> >  /**
> > @@ -134,6 +74,19 @@ void board_lmb_reserve(void);
> >  void arch_lmb_reserve(void);
> >  void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
> >
> > +/**
> > + * lmb_mem_regions_init() - Initialise the LMB memory
> > + *
> > + * Initialise the LMB subsystem related data structures. There are two
> > + * alloced lists that are initialised, one for the free memory, and one
> > + * for the used memory.
> > + *
> > + * Initialise the two lists as part of board init.
> > + *
> > + * Return: 0 if OK, -ve on failure.
> > + */
> > +int lmb_mem_regions_init(void);
> > +
> >  #endif /* __KERNEL__ */
> >
> >  #endif /* _LINUX_LMB_H */
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 80945e3cae..a46bc8a7a3 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -6,6 +6,7 @@
> >   * Copyright (C) 2001 Peter Bergner.
> >   */
> >
> > +#include <alist.h>
> >  #include <efi_loader.h>
> >  #include <image.h>
> >  #include <mapmem.h>
> > @@ -15,24 +16,30 @@
> >
> >  #include <asm/global_data.h>
> >  #include <asm/sections.h>
> > +#include <linux/kernel.h>
> >
> >  DECLARE_GLOBAL_DATA_PTR;
> >
> >  #define LMB_ALLOC_ANYWHERE     0
> > +#define LMB_ALIST_INITIAL_SIZE 4
> >
> > -static void lmb_dump_region(struct lmb_region *rgn, char *name)
> > +struct alist lmb_free_mem;
> > +struct alist lmb_used_mem;
>
> I think these should be in a struct, e.g. struct lmb, allocated with
> malloc() and pointed to by gd->lmb so we can avoid making the tests
> destructive, and allow use of lmb in SPL.

Can you elaborate on the point of allowing use of lmb in SPL. Why
would the current design not work in SPL ? I tested this on the
sandbox SPL variant, and the two lists do get initialised as part of
the SPL initialisation routine. Is there some corner-case that I am
not considering ?

Also, regarding putting the lmb structure pointer as part of gd, iirc
Tom had a different opinion on this. Tom, can you please chime in here
?

 > There is a
> arch_reset_for_test() which can reset the lmb back to its original
> state, or perhaps just swap the pointer for tests.
>
> I know this series is already long, but this patch seems to do quite a
> bit. Perhaps it could be split into two?

Sorry, do you mean the patch, or the series. If the later, I am going
to split the non-rfc version which comes next into two parts. The
first part being the lmb changes.

-sughosh

>
> Regards,
> Simon
