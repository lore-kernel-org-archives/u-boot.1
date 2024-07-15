Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFF5C3DA4B
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 17:58:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CF8C87E95;
	Mon, 15 Jul 2024 19:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r3GTwC2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 838FE87E95; Mon, 15 Jul 2024 19:58:43 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6540687E13
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 19:58:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5c7b6c6a581so2146374eaf.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721066319; x=1721671119; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TTz08DVHhn4OQECxY7DHm1KeRxs/ohu0TAZPgAGFgaY=;
 b=r3GTwC2haVj1UbQdHfD02OenZagk8N6Di/nNHFnIO7ifcx1GsoYwTB/9ImocMvfDmW
 RQwwNNh1ARmZBQOEmzH3qHPphO5nC3SEeqpV/3B+fXlRJ7oHVF06RP0NDMHt4OqjiZvr
 //KGEJgQ7nMofDZyXWI3DWhIF0sYJ2MrkysMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721066319; x=1721671119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TTz08DVHhn4OQECxY7DHm1KeRxs/ohu0TAZPgAGFgaY=;
 b=c4ZK51P5e3pNNsoR5PzNR73EqNj5blu2rdZesFgKViijD8l6ADGdbtnj9/CTH1lcMw
 K5sQl+Z98PS2saTCp37W9FlcAdjzoWOze2JVR7CQLRojATML3CkZk06NhkUcsTNSOcj4
 TpUwK/NTOETQvfWxytxSHFGWU/Ig5MdoBCTAYb6Yh8UWStDXZAVyYddXdFDPoq37Qa04
 1tsrdi9HEQByVVyuOhUDsHJgHlwy5R6oTu/oc+XF639cvXzHsH3HAgVEv6Moo+/MI2VT
 Ns+xK4VzipvGrdgYDFUI/VaB4H/pUv/RdhwbVm9uquro0h0CdWjanIvNq5bw0oR7Ctrk
 Y+8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsx1+4WD/1jtciEjAI9wfLyYkwG7GlTqPYRcld9Pbf2Zngo1/4pczpeDHxmS7AvSCyt4NBMBGGXO3rkVgVlEaLLL7K8g==
X-Gm-Message-State: AOJu0Yzyu5IMoTTsG6WtqQVornwKvzaFJwaNl46xlg0UIjKyZURAgKYq
 ZzWV+ExZRpIenXlDvrQdOGj40EwN3KMLP6S20jhTyCyuU/iw4e04fedvkIWj938=
X-Google-Smtp-Source: AGHT+IFTILCmjYMwTo8LjIY13FQsYRZqGbtJsl7a/DteVWWCTbrhqvIIAOJQEMyyH6METMs/+Aqfdg==
X-Received: by 2002:a05:6820:151e:b0:5cc:64e5:d002 with SMTP id
 006d021491bc7-5d25617e2a6mr443760eaf.8.1721066316981; 
 Mon, 15 Jul 2024 10:58:36 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ce74ee4b4fsm865876eaf.5.2024.07.15.10.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 10:58:36 -0700 (PDT)
Date: Mon, 15 Jul 2024 11:58:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
Subject: Re: [RFC PATCH v2 13/48] lmb: make LMB memory map persistent and
 global
Message-ID: <20240715175833.GL38804@bill-the-cat>
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-14-sughosh.ganu@linaro.org>
 <CAFLszTjPtFX60ZvJtcG=3z-waRpQMYad9-bsVPUsP0MmHkJ7jA@mail.gmail.com>
 <CADg8p96u23yVvksHqGnVsNKqcQd=VpHsM4utktujzUqpwv3Ggg@mail.gmail.com>
 <CAFLszThVsbLLLDnCyhObLbj=zMjXnzX8ncOxT8TfPkOi05GOPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rQfBNffVLIkMjojR"
Content-Disposition: inline
In-Reply-To: <CAFLszThVsbLLLDnCyhObLbj=zMjXnzX8ncOxT8TfPkOi05GOPw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--rQfBNffVLIkMjojR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 12:39:35PM +0100, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Mon, 15 Jul 2024 at 10:48, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > hi Simon,
> >
> > On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> w=
rote:
> > > >
> > > > The current LMB API's for allocating and reserving memory use a
> > > > per-caller based memory view. Memory allocated by a caller can then=
 be
> > > > overwritten by another caller. Make these allocations and reservati=
ons
> > > > persistent using the alloced list data structure.
> > > >
> > > > Two alloced lists are declared -- one for the available(free) memor=
y,
> > > > and one for the used memory. Once full, the list can then be extend=
ed
> > > > at runtime.
> > > >
> > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > ---
> > > > Changes since V1:
> > > > * Use alloced list structure for the available and reserved memory
> > > >   lists instead of static arrays.
> > > > * Corresponding changes in the code made as a result of the above
> > > >   change.
> > > > * Rename the reserved memory list as 'used'.
> > > >
> > > >  include/lmb.h |  77 +++--------
> > > >  lib/lmb.c     | 346 ++++++++++++++++++++++++++++++----------------=
----
> > > >  2 files changed, 224 insertions(+), 199 deletions(-)
> > > >
> > > > diff --git a/include/lmb.h b/include/lmb.h
> > > > index 99fcf5781f..27cdb18c37 100644
> > > > --- a/include/lmb.h
> > > > +++ b/include/lmb.h
> > > > @@ -24,78 +24,18 @@ enum lmb_flags {
> > > >  };
> > > >
> > > >  /**
> > > > - * struct lmb_property - Description of one region.
> > > > + * struct lmb_region - Description of one region.
> > > >   *
> > > >   * @base:      Base address of the region.
> > > >   * @size:      Size of the region
> > > >   * @flags:     memory region attributes
> > > >   */
> > > > -struct lmb_property {
> > > > +struct lmb_region {
> > > >         phys_addr_t base;
> > > >         phys_size_t size;
> > > >         enum lmb_flags flags;
> > > >  };
> > > >
> > > > -/*
> > > > - * For regions size management, see LMB configuration in KConfig
> > > > - * all the #if test are done with CONFIG_LMB_USE_MAX_REGIONS (bool=
ean)
> > > > - *
> > > > - * case 1. CONFIG_LMB_USE_MAX_REGIONS is defined (legacy mode)
> > > > - *         =3D> CONFIG_LMB_MAX_REGIONS is used to configure the re=
gion size,
> > > > - *         directly in the array lmb_region.region[], with the same
> > > > - *         configuration for memory and reserved regions.
> > > > - *
> > > > - * case 2. CONFIG_LMB_USE_MAX_REGIONS is not defined, the size of =
each
> > > > - *         region is configurated *independently* with
> > > > - *         =3D> CONFIG_LMB_MEMORY_REGIONS: struct lmb.memory_regio=
ns
> > > > - *         =3D> CONFIG_LMB_RESERVED_REGIONS: struct lmb.reserved_r=
egions
> > > > - *         lmb_region.region is only a pointer to the correct buff=
er,
> > > > - *         initialized in lmb_init(). This configuration is useful=
 to manage
> > > > - *         more reserved memory regions with CONFIG_LMB_RESERVED_R=
EGIONS.
> > > > - */
> > > > -
> > > > -/**
> > > > - * struct lmb_region - Description of a set of region.
> > > > - *
> > > > - * @cnt: Number of regions.
> > > > - * @max: Size of the region array, max value of cnt.
> > > > - * @region: Array of the region properties
> > > > - */
> > > > -struct lmb_region {
> > > > -       unsigned long cnt;
> > > > -       unsigned long max;
> > > > -#if IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> > > > -       struct lmb_property region[CONFIG_LMB_MAX_REGIONS];
> > > > -#else
> > > > -       struct lmb_property *region;
> > > > -#endif
> > > > -};
> > > > -
> > > > -/**
> > > > - * struct lmb - Logical memory block handle.
> > > > - *
> > > > - * Clients provide storage for Logical memory block (lmb) handles.
> > > > - * The content of the structure is managed by the lmb library.
> > > > - * A lmb struct is  initialized by lmb_init() functions.
> > > > - * The lmb struct is passed to all other lmb APIs.
> > > > - *
> > > > - * @memory: Description of memory regions.
> > > > - * @reserved: Description of reserved regions.
> > > > - * @memory_regions: Array of the memory regions (statically alloca=
ted)
> > > > - * @reserved_regions: Array of the reserved regions (statically al=
located)
> > > > - */
> > > > -struct lmb {
> > > > -       struct lmb_region memory;
> > > > -       struct lmb_region reserved;
> > > > -#if !IS_ENABLED(CONFIG_LMB_USE_MAX_REGIONS)
> > > > -       struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGION=
S];
> > > > -       struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_RE=
GIONS];
> > > > -#endif
> > > > -};
> > > > -
> > > > -void lmb_init_and_reserve(struct bd_info *bd, void *fdt_blob);
> > > > -void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
> > > > -                               void *fdt_blob);
> > > >  long lmb_add(phys_addr_t base, phys_size_t size);
> > > >  long lmb_reserve(phys_addr_t base, phys_size_t size);
> > > >  /**
> > > > @@ -134,6 +74,19 @@ void board_lmb_reserve(void);
> > > >  void arch_lmb_reserve(void);
> > > >  void arch_lmb_reserve_generic(ulong sp, ulong end, ulong align);
> > > >
> > > > +/**
> > > > + * lmb_mem_regions_init() - Initialise the LMB memory
> > > > + *
> > > > + * Initialise the LMB subsystem related data structures. There are=
 two
> > > > + * alloced lists that are initialised, one for the free memory, an=
d one
> > > > + * for the used memory.
> > > > + *
> > > > + * Initialise the two lists as part of board init.
> > > > + *
> > > > + * Return: 0 if OK, -ve on failure.
> > > > + */
> > > > +int lmb_mem_regions_init(void);
> > > > +
> > > >  #endif /* __KERNEL__ */
> > > >
> > > >  #endif /* _LINUX_LMB_H */
> > > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > > index 80945e3cae..a46bc8a7a3 100644
> > > > --- a/lib/lmb.c
> > > > +++ b/lib/lmb.c
> > > > @@ -6,6 +6,7 @@
> > > >   * Copyright (C) 2001 Peter Bergner.
> > > >   */
> > > >
> > > > +#include <alist.h>
> > > >  #include <efi_loader.h>
> > > >  #include <image.h>
> > > >  #include <mapmem.h>
> > > > @@ -15,24 +16,30 @@
> > > >
> > > >  #include <asm/global_data.h>
> > > >  #include <asm/sections.h>
> > > > +#include <linux/kernel.h>
> > > >
> > > >  DECLARE_GLOBAL_DATA_PTR;
> > > >
> > > >  #define LMB_ALLOC_ANYWHERE     0
> > > > +#define LMB_ALIST_INITIAL_SIZE 4
> > > >
> > > > -static void lmb_dump_region(struct lmb_region *rgn, char *name)
> > > > +struct alist lmb_free_mem;
> > > > +struct alist lmb_used_mem;
> > >
> > > I think these should be in a struct, e.g. struct lmb, allocated with
> > > malloc() and pointed to by gd->lmb so we can avoid making the tests
> > > destructive, and allow use of lmb in SPL.
> >
> > Can you elaborate on the point of allowing use of lmb in SPL. Why
> > would the current design not work in SPL ? I tested this on the
> > sandbox SPL variant, and the two lists do get initialised as part of
> > the SPL initialisation routine. Is there some corner-case that I am
> > not considering ?
>=20
> Just that some boards don't have their BSS available until later on in
> SPL. In general we try to avoid local variables with driver model...I
> think lmb should be the same, particularly as there it is fairly cheap
> to allocate a struct with malloc().

We also have limited malloc space, in those cases. But, yes, we likely
need LMB available to use earlier in the SPL case now than we did
before, so malloc is likely better, as Simon suggests.

> > Also, regarding putting the lmb structure pointer as part of gd, iirc
> > Tom had a different opinion on this. Tom, can you please chime in here
> > ?
>=20
> or you could point to the discussion?

It was in reply to the last posting of this series.

While there's a strong implication that tests in post/ (as it is short
for 'power on self test') need to be non-destructive, that's not the
case for test/ code.

So my thoughts are:
- Since there's only one list for real use, calls are cleaner if we
  aren't passing a pointer to the one and only thing everyone could use.
- I don't think we have a test case that's hindered by not doing this,
  only "now boot normally" may be harder/hindered.
- Taking things out of gd is usually good?

At the end of the day, if this is a big sticking point with the new
scheme, no, OK, we can go back to gd->lmb. I don't think we need it, but
I can't convince myself Everyone Else Is Wrong about it either.

--=20
Tom

--rQfBNffVLIkMjojR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaVY0YACgkQFHw5/5Y0
tyw5kwv/Q/Yrv+onzR4blR3282uXS9CPheQ3qhwK7MLsjyd4jQxm/44CFE+GQfe0
NbHeYc29kYY8o0I+m5TNeEZ+jXsT2BOy8zWG46MfUnB9rKuWS4oyAFwwQr6Bu3bC
cx4Esj8nKaROeeA1IN9ghbOvlduY+HWwZ5h3XdgJo5MAHUIF3W6KMCqHxKXb1PWH
IYsXl4HJ+dbCnafl7zLFIZMhIqmrqoMC84jKmb4Hy1EAg4FhIBJ7Ez7iuf49vEAs
khmZF6LCcDtV1FiWsPEH6+f2fWkwbualHY/5EkM/SmfFuniZPTqUsjs9K0G7G3HL
PvVSiQJSd3vVvJwE1gTErVw/DOAwWYMICEpDG6H/KJyT/lBLFdFtsxafrMYjfI02
JcgIrJiJsfduoMVMWzSams2VhD0Q2+nD2TbE3EiF10xs+Xc/FUr0f1qFaiy6giyH
koHi6BlfbXSzTqzT1wRrjR+jgDRM+tvcHbP4giE1Vt+P4yx2ZR+OnrqS/qTlqKHM
iGrCKk6g
=3iyD
-----END PGP SIGNATURE-----

--rQfBNffVLIkMjojR--
