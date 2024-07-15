Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EC7C3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 11:40:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9596E88865;
	Mon, 15 Jul 2024 13:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BkFsU4su";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 226328886D; Mon, 15 Jul 2024 13:39:49 +0200 (CEST)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3F9F88865
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 13:39:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6b5eb69e04cso28515366d6.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 04:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721043585; x=1721648385; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iVnlku4hQ63lQIcImQHSjc/kp0tUs+1WReEZbGhEHgA=;
 b=BkFsU4suuhgUFBtZqUpH/ffYP1a9QI2JaJimMr5RbKEgBaq4ANqhaydOo8m5dKmN1J
 iR5vxZa8IrAOqPdaJMyeR4BrIGyTs0s2gFJT/xMXJFl59FRNuPTNJRGZVxrTRmwPX6+J
 y8/tBAIZPyUG4UN5E1efWOahZXqHQTW7lxLzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721043585; x=1721648385;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iVnlku4hQ63lQIcImQHSjc/kp0tUs+1WReEZbGhEHgA=;
 b=BY9qRQRmDD4qfs1/a8Xca4NTRYjR8Bv2emHXhILRuF5X7uCzf3S5sQL7NYgcFfUB+P
 VtsFEmP8pYEh9MN24kCXr9AITtp3GEcZLUdbDxtmISLIfbVVsPHALOSCIPVPAbeJlNaL
 qMRzB8a2qYCevWnfYZ14RwRWAQVCR1/JzWLYvZUEINNtQKgWT/GgtXLJtTrP7y7zrARF
 qWWjqltOzvhYSJ6FT/J/QFwMnn0u65dcpOW3R9tCksKQ5mTr05y0ovZaaIUFAxOb6fKX
 o+crvcHdVaC900WFXwJf13HWeC1p1JaQhSfplpGkf4voG1zQkvHuOWkjPl1LyWjUw9RQ
 SJzA==
X-Gm-Message-State: AOJu0YzNIp5kObRRm0AzAGxlSwV8M02W1lw2YBvNnIHZxXNo7Fxu90vT
 KQ4VG+xM+n9DSkhjqhNhNw7fhbRfSRujffX7T8dQM1C9X5HQlW6pB77aCLqC4tCulW/rNptkxAU
 /D7ghBdo89Xo6PKdzH0Bh5Jdd5xBcykQh8k2C
X-Google-Smtp-Source: AGHT+IG3d84lO6FEpeJeYNqlmkKYeSFyfupGSRdxNr67CYWU0JfgY46n7Zto0fOpnX4mNa2mQ4j45nIPVqmlxEU5lJY=
X-Received: by 2002:ad4:5b8b:0:b0:6b2:b5c1:72dc with SMTP id
 6a1803df08f44-6b61c1d93camr227051136d6.54.1721043585578; Mon, 15 Jul 2024
 04:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-14-sughosh.ganu@linaro.org>
 <CAFLszTjPtFX60ZvJtcG=3z-waRpQMYad9-bsVPUsP0MmHkJ7jA@mail.gmail.com>
 <CADg8p96u23yVvksHqGnVsNKqcQd=VpHsM4utktujzUqpwv3Ggg@mail.gmail.com>
In-Reply-To: <CADg8p96u23yVvksHqGnVsNKqcQd=VpHsM4utktujzUqpwv3Ggg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 15 Jul 2024 12:39:35 +0100
Message-ID: <CAFLszThVsbLLLDnCyhObLbj=zMjXnzX8ncOxT8TfPkOi05GOPw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/48] lmb: make LMB memory map persistent and
 global
To: Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Sughosh,

On Mon, 15 Jul 2024 at 10:48, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > The current LMB API's for allocating and reserving memory use a
> > > per-caller based memory view. Memory allocated by a caller can then be
> > > overwritten by another caller. Make these allocations and reservations
> > > persistent using the alloced list data structure.
> > >
> > > Two alloced lists are declared -- one for the available(free) memory,
> > > and one for the used memory. Once full, the list can then be extended
> > > at runtime.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > > Changes since V1:
> > > * Use alloced list structure for the available and reserved memory
> > >   lists instead of static arrays.
> > > * Corresponding changes in the code made as a result of the above
> > >   change.
> > > * Rename the reserved memory list as 'used'.
> > >
> > >  include/lmb.h |  77 +++--------
> > >  lib/lmb.c     | 346 ++++++++++++++++++++++++++++++--------------------
> > >  2 files changed, 224 insertions(+), 199 deletions(-)
> > >
> > > diff --git a/include/lmb.h b/include/lmb.h
> > > index 99fcf5781f..27cdb18c37 100644
> > > --- a/include/lmb.h
> > > +++ b/include/lmb.h
> > > @@ -24,78 +24,18 @@ enum lmb_flags {
> > >  };
> > >
> > >  /**
> > > - * struct lmb_property - Description of one region.
> > > + * struct lmb_region - Description of one region.
> > >   *
> > >   * @base:      Base address of the region.
> > >   * @size:      Size of the region
> > >   * @flags:     memory region attributes
> > >   */
> > > -struct lmb_property {
> > > +struct lmb_region {
> > >         phys_addr_t base;
> > >         phys_size_t size;
> > >         enum lmb_flags flags;
> > >  };
> > >
> > > -/*
> > > - * For regions size management, see LMB configuration in KConfig
> > > - * all the #if test are done with CONFIG_LMB_USE_MAX_REGIONS (boolean)
> > > - *
> > > - * case 1. CONFIG_LMB_USE_MAX_REGIONS is defined (legacy mode)
> > > - *         => CONFIG_LMB_MAX_REGIONS is used to configure the region size,
> > > - *         directly in the array lmb_region.region[], with the same
> > > - *         configuration for memory and reserved regions.
> > > - *
> > > - * case 2. CONFIG_LMB_USE_MAX_REGIONS is not defined, the size of each
> > > - *         region is configurated *independently* with
> > > - *         => CONFIG_LMB_MEMORY_REGIONS: struct lmb.memory_regions
> > > - *         => CONFIG_LMB_RESERVED_REGIONS: struct lmb.reserved_regions
> > > - *         lmb_region.region is only a pointer to the correct buffer,
> > > - *         initialized in lmb_init(). This configuration is useful to manage
> > > - *         more reserved memory regions with CONFIG_LMB_RESERVED_REGIONS.
> > > - */
> > > -
> > > -/**
> > > - * struct lmb_region - Description of a set of region.
> > > - *
> > > - * @cnt: Number of regions.
> > > - * @max: Size of the region array, max value of cnt.
> > > - * @region: Array of the region properties
> > > - */
> > > -struct lmb_region {
> > > -       unsigned long cnt;
> > > -       unsigned long max;
> > > -#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> > > -       struct lmb_property region[CONFIG_LMB_MAX_REGIONS];
> > > -#else
> > > -       struct lmb_property *region;
> > > -#endif
> > > -};
> > > -
> > > -/**
> > > - * struct lmb - Logical memory block handle.
> > > - *
> > > - * Clients provide storage for Logical memory block (lmb) handles.
> > > - * The content of the structure is managed by the lmb library.
> > > - * A lmb struct is  initialized by lmb_init() functions.
> > > - * The lmb struct is passed to all other lmb APIs.
> > > - *
> > > - * @memory: Description of memory regions.
> > > - * @reserved: Description of reserved regions.
> > > - * @memory_regions: Array of the memory regions (statically allocated)
> > > - * @reserved_regions: Array of the reserved regions (statically allocated)
> > > - */
> > > -struct lmb {
> > > -       struct lmb_region memory;
> > > -       struct lmb_region reserved;
> > > -#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> > > -       struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
> > > -       struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
> > > -#endif
> > > -};
> > > -
> > > -void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
> > > -void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
> > > -                               void *fdt_blob);
> > >  long lmb_add(phys_addr_t base, phys_size_t size);
> > >  long lmb_reserve(phys_addr_t base, phys_size_t size);
> > >  /**
> > > @@ -134,6 +74,19 @@ void board_lmb_reserve(void);
> > >  void arch_lmb_reserve(void);
> > >  void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
> > >
> > > +/**
> > > + * lmb_mem_regions_init() - Initialise the LMB memory
> > > + *
> > > + * Initialise the LMB subsystem related data structures. There are two
> > > + * alloced lists that are initialised, one for the free memory, and one
> > > + * for the used memory.
> > > + *
> > > + * Initialise the two lists as part of board init.
> > > + *
> > > + * Return: 0 if OK, -ve on failure.
> > > + */
> > > +int lmb_mem_regions_init(void);
> > > +
> > >  #endif /* __KERNEL__ */
> > >
> > >  #endif /* _LINUX_LMB_H */
> > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > index 80945e3cae..a46bc8a7a3 100644
> > > --- a/lib/lmb.c
> > > +++ b/lib/lmb.c
> > > @@ -6,6 +6,7 @@
> > >   * Copyright (C) 2001 Peter Bergner.
> > >   */
> > >
> > > +#include <alist.h>
> > >  #include <efi_loader.h>
> > >  #include <image.h>
> > >  #include <mapmem.h>
> > > @@ -15,24 +16,30 @@
> > >
> > >  #include <asm/global_data.h>
> > >  #include <asm/sections.h>
> > > +#include <linux/kernel.h>
> > >
> > >  DECLARE_GLOBAL_DATA_PTR;
> > >
> > >  #define LMB_ALLOC_ANYWHERE     0
> > > +#define LMB_ALIST_INITIAL_SIZE 4
> > >
> > > -static void lmb_dump_region(struct lmb_region *rgn, char *name)
> > > +struct alist lmb_free_mem;
> > > +struct alist lmb_used_mem;
> >
> > I think these should be in a struct, e.g. struct lmb, allocated with
> > malloc() and pointed to by gd->lmb so we can avoid making the tests
> > destructive, and allow use of lmb in SPL.
>
> Can you elaborate on the point of allowing use of lmb in SPL. Why
> would the current design not work in SPL ? I tested this on the
> sandbox SPL variant, and the two lists do get initialised as part of
> the SPL initialisation routine. Is there some corner-case that I am
> not considering ?

Just that some boards don't have their BSS available until later on in
SPL. In general we try to avoid local variables with driver model...I
think lmb should be the same, particularly as there it is fairly cheap
to allocate a struct with malloc().

>
> Also, regarding putting the lmb structure pointer as part of gd, iirc
> Tom had a different opinion on this. Tom, can you please chime in here
> ?

or you could point to the discussion?

>
>  > There is a
> > arch_reset_for_test() which can reset the lmb back to its original
> > state, or perhaps just swap the pointer for tests.
> >
> > I know this series is already long, but this patch seems to do quite a
> > bit. Perhaps it could be split into two?
>
> Sorry, do you mean the patch, or the series. If the later, I am going
> to split the non-rfc version which comes next into two parts. The
> first part being the lmb changes.

OK ta.

Regards,
Simon
