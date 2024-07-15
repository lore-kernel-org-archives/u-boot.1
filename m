Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9CCC3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 19:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E87487B84;
	Mon, 15 Jul 2024 21:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IUfmUbI+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2778D8752A; Mon, 15 Jul 2024 21:32:22 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E986C87B84
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 21:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6b5dc36b895so28498536d6.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 12:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721071938; x=1721676738; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ulXvMtYMp6oP+PBCiFJzl4QtEyzHXvXAyBYkmHZSavs=;
 b=IUfmUbI+nVcLoTMZLxVZ13lqgRONwYqWhe6GgatlzvMfuw3RMqT6thaSyIUapx192h
 i7QmK6M+bx7fg/aQD99O2VCvl9zplJG8iFezvM/OteGV14/Z4SuBCG7O1VoSNoJWtm2u
 9xrzw0YT+H4GuZ7N0ZTv9gLJGSRB9pz591nZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721071938; x=1721676738;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ulXvMtYMp6oP+PBCiFJzl4QtEyzHXvXAyBYkmHZSavs=;
 b=srDH8zgwDM9ZMh/rK1G/Qo/E2xMVc3Ijto+0geootkHeA28bTj4M0BI+HW9MUeTjPZ
 zj34P0SbRmEI7cuWhPOZEVPk3OdZ+QMfkj5COpY+9GmfdTPqmh/JJauo8/9qhIXcPfYu
 lwB8wbnkIE3jcEg0/6mbwpb6fhMuDK37zs9q/HW0WMwda/+rwp+y5z7KWr169q/HVnGV
 Rdpfxy3W2uEECUPbuC2aZ4xLcIMGnSYBPGEVmoDHAA7up7t2KR24raU3fwFszPpP5V1n
 iQhRCNLzCiHIk8fvocL1AOs2O6xIlKjVDTsHcAYBb2+eDRUXf7LfY7sX5Yyl/OYzbTdw
 qFJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdx9jgltWQRHwvLIuXiAF2v6wymLqNL9afMpUmd+AIGH0GQKp8YaLQubKHJO0ZIV7Bjwwy59AyVDeSemF6WWNsFp183g==
X-Gm-Message-State: AOJu0Yy1RDZg+2Vw8R2OS22ZhJ1XCnIMHOC84xTpwYvmG9jSJfe3xKmm
 dKyx/qWQsdZwH37KbH0xqLSn+FPaUj07KId2mzwjQWPPuM0obYfYgq2u5MNZ2yyI0heFhulSZuL
 ZcwszMexFfTLLYDQjj6pKQC4mjv+qFGW7HtqW
X-Google-Smtp-Source: AGHT+IGaZrcIsx0c75STtPWuAW8pYGb8n4ePBHKjO9bLUEtiAazt3cQVu0Pd/ojacNNAsHvA3YDTVPOQKDua166d7rs=
X-Received: by 2002:a05:6214:c65:b0:6b5:2b33:5445 with SMTP id
 6a1803df08f44-6b77f4ca4b3mr1907136d6.25.1721071937756; Mon, 15 Jul 2024
 12:32:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-14-sughosh.ganu@linaro.org>
 <CAFLszTjPtFX60ZvJtcG=3z-waRpQMYad9-bsVPUsP0MmHkJ7jA@mail.gmail.com>
 <CADg8p96u23yVvksHqGnVsNKqcQd=VpHsM4utktujzUqpwv3Ggg@mail.gmail.com>
 <CAFLszThVsbLLLDnCyhObLbj=zMjXnzX8ncOxT8TfPkOi05GOPw@mail.gmail.com>
 <20240715175833.GL38804@bill-the-cat>
In-Reply-To: <20240715175833.GL38804@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 15 Jul 2024 20:32:06 +0100
Message-ID: <CAFLszTifWESeT0DVmnvZcsThTR4NtVx5sH=jcAh1UfFSauOs6g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/48] lmb: make LMB memory map persistent and
 global
To: Tom Rini <trini@konsulko.com>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
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

Hi,

On Mon, 15 Jul 2024 at 18:58, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jul 15, 2024 at 12:39:35PM +0100, Simon Glass wrote:
> > Hi Sughosh,
> >
> > On Mon, 15 Jul 2024 at 10:48, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > hi Simon,
> > >
> > > On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > The current LMB API's for allocating and reserving memory use a
> > > > > per-caller based memory view. Memory allocated by a caller can then be
> > > > > overwritten by another caller. Make these allocations and reservations
> > > > > persistent using the alloced list data structure.
> > > > >
> > > > > Two alloced lists are declared -- one for the available(free) memory,
> > > > > and one for the used memory. Once full, the list can then be extended
> > > > > at runtime.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since V1:
> > > > > * Use alloced list structure for the available and reserved memory
> > > > >   lists instead of static arrays.
> > > > > * Corresponding changes in the code made as a result of the above
> > > > >   change.
> > > > > * Rename the reserved memory list as 'used'.
> > > > >
> > > > >  include/lmb.h |  77 +++--------
> > > > >  lib/lmb.c     | 346 ++++++++++++++++++++++++++++++--------------------
> > > > >  2 files changed, 224 insertions(+), 199 deletions(-)
> > > > >
> > > > > diff --git a/include/lmb.h b/include/lmb.h
> > > > > index 99fcf5781f..27cdb18c37 100644
> > > > > --- a/include/lmb.h
> > > > > +++ b/include/lmb.h
> > > > > @@ -24,78 +24,18 @@ enum lmb_flags {
> > > > >  };
> > > > >
> > > > >  /**
> > > > > - * struct lmb_property - Description of one region.
> > > > > + * struct lmb_region - Description of one region.
> > > > >   *
> > > > >   * @base:      Base address of the region.
> > > > >   * @size:      Size of the region
> > > > >   * @flags:     memory region attributes
> > > > >   */
> > > > > -struct lmb_property {
> > > > > +struct lmb_region {
> > > > >         phys_addr_t base;
> > > > >         phys_size_t size;
> > > > >         enum lmb_flags flags;
> > > > >  };
> > > > >
> > > > > -/*
> > > > > - * For regions size management, see LMB configuration in KConfig
> > > > > - * all the #if test are done with CONFIG_LMB_USE_MAX_REGIONS (boolean)
> > > > > - *
> > > > > - * case 1. CONFIG_LMB_USE_MAX_REGIONS is defined (legacy mode)
> > > > > - *         => CONFIG_LMB_MAX_REGIONS is used to configure the region size,
> > > > > - *         directly in the array lmb_region.region[], with the same
> > > > > - *         configuration for memory and reserved regions.
> > > > > - *
> > > > > - * case 2. CONFIG_LMB_USE_MAX_REGIONS is not defined, the size of each
> > > > > - *         region is configurated *independently* with
> > > > > - *         => CONFIG_LMB_MEMORY_REGIONS: struct lmb.memory_regions
> > > > > - *         => CONFIG_LMB_RESERVED_REGIONS: struct lmb.reserved_regions
> > > > > - *         lmb_region.region is only a pointer to the correct buffer,
> > > > > - *         initialized in lmb_init(). This configuration is useful to manage
> > > > > - *         more reserved memory regions with CONFIG_LMB_RESERVED_REGIONS.
> > > > > - */
> > > > > -
> > > > > -/**
> > > > > - * struct lmb_region - Description of a set of region.
> > > > > - *
> > > > > - * @cnt: Number of regions.
> > > > > - * @max: Size of the region array, max value of cnt.
> > > > > - * @region: Array of the region properties
> > > > > - */
> > > > > -struct lmb_region {
> > > > > -       unsigned long cnt;
> > > > > -       unsigned long max;
> > > > > -#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> > > > > -       struct lmb_property region[CONFIG_LMB_MAX_REGIONS];
> > > > > -#else
> > > > > -       struct lmb_property *region;
> > > > > -#endif
> > > > > -};
> > > > > -
> > > > > -/**
> > > > > - * struct lmb - Logical memory block handle.
> > > > > - *
> > > > > - * Clients provide storage for Logical memory block (lmb) handles.
> > > > > - * The content of the structure is managed by the lmb library.
> > > > > - * A lmb struct is  initialized by lmb_init() functions.
> > > > > - * The lmb struct is passed to all other lmb APIs.
> > > > > - *
> > > > > - * @memory: Description of memory regions.
> > > > > - * @reserved: Description of reserved regions.
> > > > > - * @memory_regions: Array of the memory regions (statically allocated)
> > > > > - * @reserved_regions: Array of the reserved regions (statically allocated)
> > > > > - */
> > > > > -struct lmb {
> > > > > -       struct lmb_region memory;
> > > > > -       struct lmb_region reserved;
> > > > > -#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> > > > > -       struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
> > > > > -       struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
> > > > > -#endif
> > > > > -};
> > > > > -
> > > > > -void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
> > > > > -void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
> > > > > -                               void *fdt_blob);
> > > > >  long lmb_add(phys_addr_t base, phys_size_t size);
> > > > >  long lmb_reserve(phys_addr_t base, phys_size_t size);
> > > > >  /**
> > > > > @@ -134,6 +74,19 @@ void board_lmb_reserve(void);
> > > > >  void arch_lmb_reserve(void);
> > > > >  void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
> > > > >
> > > > > +/**
> > > > > + * lmb_mem_regions_init() - Initialise the LMB memory
> > > > > + *
> > > > > + * Initialise the LMB subsystem related data structures. There are two
> > > > > + * alloced lists that are initialised, one for the free memory, and one
> > > > > + * for the used memory.
> > > > > + *
> > > > > + * Initialise the two lists as part of board init.
> > > > > + *
> > > > > + * Return: 0 if OK, -ve on failure.
> > > > > + */
> > > > > +int lmb_mem_regions_init(void);
> > > > > +
> > > > >  #endif /* __KERNEL__ */
> > > > >
> > > > >  #endif /* _LINUX_LMB_H */
> > > > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > > > index 80945e3cae..a46bc8a7a3 100644
> > > > > --- a/lib/lmb.c
> > > > > +++ b/lib/lmb.c
> > > > > @@ -6,6 +6,7 @@
> > > > >   * Copyright (C) 2001 Peter Bergner.
> > > > >   */
> > > > >
> > > > > +#include <alist.h>
> > > > >  #include <efi_loader.h>
> > > > >  #include <image.h>
> > > > >  #include <mapmem.h>
> > > > > @@ -15,24 +16,30 @@
> > > > >
> > > > >  #include <asm/global_data.h>
> > > > >  #include <asm/sections.h>
> > > > > +#include <linux/kernel.h>
> > > > >
> > > > >  DECLARE_GLOBAL_DATA_PTR;
> > > > >
> > > > >  #define LMB_ALLOC_ANYWHERE     0
> > > > > +#define LMB_ALIST_INITIAL_SIZE 4
> > > > >
> > > > > -static void lmb_dump_region(struct lmb_region *rgn, char *name)
> > > > > +struct alist lmb_free_mem;
> > > > > +struct alist lmb_used_mem;
> > > >
> > > > I think these should be in a struct, e.g. struct lmb, allocated with
> > > > malloc() and pointed to by gd->lmb so we can avoid making the tests
> > > > destructive, and allow use of lmb in SPL.
> > >
> > > Can you elaborate on the point of allowing use of lmb in SPL. Why
> > > would the current design not work in SPL ? I tested this on the
> > > sandbox SPL variant, and the two lists do get initialised as part of
> > > the SPL initialisation routine. Is there some corner-case that I am
> > > not considering ?
> >
> > Just that some boards don't have their BSS available until later on in
> > SPL. In general we try to avoid local variables with driver model...I
> > think lmb should be the same, particularly as there it is fairly cheap
> > to allocate a struct with malloc().
>
> We also have limited malloc space, in those cases. But, yes, we likely
> need LMB available to use earlier in the SPL case now than we did
> before, so malloc is likely better, as Simon suggests.
>
> > > Also, regarding putting the lmb structure pointer as part of gd, iirc
> > > Tom had a different opinion on this. Tom, can you please chime in here
> > > ?
> >
> > or you could point to the discussion?
>
> It was in reply to the last posting of this series.
>
> While there's a strong implication that tests in post/ (as it is short
> for 'power on self test') need to be non-destructive, that's not the
> case for test/ code.
>
> So my thoughts are:
> - Since there's only one list for real use, calls are cleaner if we
>   aren't passing a pointer to the one and only thing everyone could use.
> - I don't think we have a test case that's hindered by not doing this,
>   only "now boot normally" may be harder/hindered.
> - Taking things out of gd is usually good?
>
> At the end of the day, if this is a big sticking point with the new
> scheme, no, OK, we can go back to gd->lmb. I don't think we need it, but
> I can't convince myself Everyone Else Is Wrong about it either.

I don't think we need to keep lmb as a parameter to the API. My real
interest is in putting the lmb 'state' in a struct such that it can be
swapped in/out for tests, allocated in malloc(), etc., like we do with
livetree and so on.

I will note that dropping the first parameter does not necessarily
reduce code size. Accessing a global variable is typically more
expensive than passing a parameter. But so long as the static
functions in lmb are passed the pointer, it might be a win to not pass
gd->lmb everywhere...? Anyway, it is easier for callers and since
there is (normally, except for testing) only one lmb, it makes sense
to me.

The issue of where to store the pointer is therefore a separate
one...I'd argue for gd->lmb, but since it is easy to change later, a
global var is fine for now, if that is more palatable.

Regards,
Simon
