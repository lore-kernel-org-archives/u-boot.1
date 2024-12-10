Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EDDE7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 22:38:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 278E880212;
	Tue, 10 Dec 2024 23:38:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="STa6Ne55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A549E80216; Tue, 10 Dec 2024 23:38:10 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB57E8020B
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 23:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so487880276.0
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 14:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733870287; x=1734475087; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nZzKRrZwRnl14IQ+Mvu3vEVwfR4U7hsukW62RX9dvQ=;
 b=STa6Ne55Xvil0MQnmkRo0qkPdCx0+nPcGt9B/q714SBXnPmC0YalKM60foXxiPo1dl
 wqBIOU7vzI1+ibY319xuelqEo25TmO7pvjHohn96hVgl/HEp79Aeztcc49ZtqYjYnzTU
 l8vLvWY5THrIOMSTIVRIzIzWv/o6KpItKJTQz4+fd4bt3uKJvb1kUKAVFWoNc49bFTMR
 f4Dh1v0e02e/WjbgXDbvaYwwsFsVHL8ws2NCldkAjZX2/WyPDEaZPRLWVMcaur1mHLYr
 79iEexIasVfYj6S/z67A04ax0lgIDJNo2NrJBDTANyiXtuMJGYw+0vzUbMKwr3hiKgvu
 QXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733870287; x=1734475087;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nZzKRrZwRnl14IQ+Mvu3vEVwfR4U7hsukW62RX9dvQ=;
 b=WXj9hmd4re6eM8SsrB1/lQ3xyzbCd/2P4ntJdW842cMkzQkidvv+NHAtH8cQKsccX0
 lYxwf5/XTUFMBpDvOAcZtZPWVwY9suBA87gawKTCQoy7zJJN9rSv/Ky8wLTYn9H/Eie2
 joXm+T9hdFBmwrnxM+Dbnk+LVAsFQLXyHGMDBsIZYJHtvJZsnczb1vrh5x6JyWTL1Vg+
 Kkw/twwYpjectRbEVOkLD1isxbZBHFMmVw+/a2rPzPfPl2dm24ItQhv0aoc4o070Zbss
 ZQhD8Jsy5XaAXzu/jDH32RtEMhtn9zcV/SNyQra3kQAuiNnY/ngH2Yu+VUxEpkFoSGM6
 SNvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZJVLIgAWyOe6eOcNASLtVDeJa54bWUDdckn7zQhnE5abbEzsUWwGFOrPAlDZOT0InBUsE/3o=@lists.denx.de
X-Gm-Message-State: AOJu0YxVh+USbV1RN4UoCDDuyu6J4wbcVnyTa4g+z8MnzEZAKhpT+JZg
 yfsACko31Ajt9k3LSjVQHYJPgH/e/q5otekcMzW3TQqCYpb/3sgIioPtnUJHY61FTeG8+fru31D
 kgJ2K+7slNXlvd+XPQWKNA73jedPnpshZyZWQRT07XM/tIM9U1/L62Q==
X-Gm-Gg: ASbGncsbZ3RA15Qu/FNr0gvRk+ax/0mVXt92PNzv210rB0ZKnQWtdenN5jtEgeTTFoF
 hK1lbUiluSDlwxXNEWg8iFNYYQxYgVRpJSvI=
X-Google-Smtp-Source: AGHT+IHANi7vvXY9sehw9DvzP14syJ+xf/vc7abSaruddItZ3gS6wfz+iBK9UEzkjuIcxofQQbLBXtBvaeqzVFGDm3I=
X-Received: by 2002:a05:6902:1142:b0:e39:8482:5d5f with SMTP id
 3f1490d57ef6-e3c8e63d3f0mr869723276.46.1733870286491; Tue, 10 Dec 2024
 14:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20241208002121.31887-1-semen.protsenko@linaro.org>
 <20241208002121.31887-6-semen.protsenko@linaro.org>
 <CAC_iWjKb1N9H3GdkZixbTmwncFj+nhjQKVtRSJdpfbnz49QTtA@mail.gmail.com>
In-Reply-To: <CAC_iWjKb1N9H3GdkZixbTmwncFj+nhjQKVtRSJdpfbnz49QTtA@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 10 Dec 2024 16:37:55 -0600
Message-ID: <CAPLW+4nPfwwTagTNq-yQnfePe+N-=pXCZfiW85KEaR1gvQ7=5A@mail.gmail.com>
Subject: Re: [PATCH 5/6] lmb: Improve kernel-doc comments
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sun, Dec 8, 2024 at 12:57=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> There was a discussion recently on whether this should be in the .h or .c
>

Thanks for reviewing this series! As for the comments -- I just
followed the U-Boot guidelines from doc/develop/codingstyle.rst:

    Non-trivial functions should have a comment which describes what
    they do. If it is an exported function, put the comment in the
    header file so the API is in one place. If it is a static function,
    put it in the C file.

Personally I don't have a strong opinion on this one. I noticed the
kernel sticks to documenting public APIs in .c files, but U-Boot does
that in headers instead. In my private projects, I usually provide
doxy comments in the header for libraries which might be shipped as a
binary plus the header file, but OTOH for firmwares and other
self-sustained stuff I stick to kernel style. But in any case, I
believe if we want change things the other way around, we should
change the documentation first, and then rework all U-Boot source code
to conform to that. That's out of scope of this patch, of course. But
I'll extend the commit message to reflect this discussion and make it
more clear.

> But I don't really mind as long as we have a common policy
>

Agreed, that's the most important thing. It's easy to move things
around when everything is clean and tidy in the first place.

> On Sun, 8 Dec 2024 at 02:21, Sam Protsenko <semen.protsenko@linaro.org> w=
rote:
> >
> > Fix warnings from kernel-doc script. Improve and unify overall style of
> > kernel-doc comments in lmb source files. Move all kernel-doc comments
> > for public functions into the header, as recommended in U-Boot
> > documentation, which also takes care of existing duplication. While at
> > it, do a bit of cosmetic cleanups as well.
> >
> > No functional change.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  include/lmb.h | 125 ++++++++++++++++++++++++++++++--------------------
> >  lib/lmb.c     |  55 ----------------------
> >  2 files changed, 74 insertions(+), 106 deletions(-)
> >
> > diff --git a/include/lmb.h b/include/lmb.h
> > index f221f0cce8f7..03d5fac6aa79 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -1,6 +1,13 @@
> >  /* SPDX-License-Identifier: GPL-2.0+ */
> > +/*
> > + * Logical memory blocks.
> > + *
> > + * Copyright (C) 2001 Peter Bergner, IBM Corp.
> > + */
> > +
> >  #ifndef _LINUX_LMB_H
> >  #define _LINUX_LMB_H
> > +
> >  #ifdef __KERNEL__
> >
> >  #include <alist.h>
> > @@ -8,21 +15,15 @@
> >  #include <asm/u-boot.h>
> >  #include <linux/bitops.h>
> >
> > -/*
> > - * Logical memory blocks.
> > - *
> > - * Copyright (C) 2001 Peter Bergner, IBM Corp.
> > - */
> > -
> > -#define LMB_ALLOC_ANYWHERE      0
> > -#define LMB_ALIST_INITIAL_SIZE  4
> > +#define LMB_ALLOC_ANYWHERE     0
> > +#define LMB_ALIST_INITIAL_SIZE 4
> >
> >  /**
> > - * enum lmb_flags - definition of memory region attributes
> > - * @LMB_NONE: no special request
> > - * @LMB_NOMAP: don't add to mmu configuration
> > - * @LMB_NOOVERWRITE: the memory region cannot be overwritten/re-reserv=
ed
> > - * @LMB_NONOTIFY: do not notify other modules of changes to this memor=
y region
> > + * enum lmb_flags - Definition of memory region attributes
> > + * @LMB_NONE: No special request
> > + * @LMB_NOMAP: Don't add to MMU configuration
> > + * @LMB_NOOVERWRITE: The memory region cannot be overwritten/re-reserv=
ed
> > + * @LMB_NONOTIFY: Do not notify other modules of changes to this memor=
y region
> >   */
> >  enum lmb_flags {
> >         LMB_NONE                =3D 0,
> > @@ -32,11 +33,10 @@ enum lmb_flags {
> >  };
> >
> >  /**
> > - * struct lmb_region - Description of one region.
> > - *
> > - * @base:      Base address of the region.
> > - * @size:      Size of the region
> > - * @flags:     memory region attributes
> > + * struct lmb_region - Description of one region
> > + * @base: Base address of the region
> > + * @size: Size of the region
> > + * @flags: Memory region attributes
> >   */
> >  struct lmb_region {
> >         phys_addr_t base;
> > @@ -46,10 +46,9 @@ struct lmb_region {
> >
> >  /**
> >   * struct lmb - The LMB structure
> > - *
> > - * @free_mem:  List of free memory regions
> > - * @used_mem:  List of used/reserved memory regions
> > - * @test:      Is structure being used for LMB tests
> > + * @free_mem: List of free memory regions
> > + * @used_mem: List of used/reserved memory regions
> > + * @test: Is structure being used for LMB tests
> >   */
> >  struct lmb {
> >         struct alist free_mem;
> > @@ -58,51 +57,77 @@ struct lmb {
> >  };
> >
> >  /**
> > - * lmb_init() - Initialise the LMB module
> > + * lmb_init() - Initialise the LMB module.
> > + *
> > + * Return: 0 on success, negative error code on failure.
> >   *
> >   * Initialise the LMB lists needed for keeping the memory map. There
> > - * are two lists, in form of alloced list data structure. One for the
> > + * are two lists, in form of allocated list data structure. One for th=
e
> >   * available memory, and one for the used memory. Initialise the two
> >   * lists as part of board init. Add memory to the available memory
> >   * list and reserve common areas by adding them to the used memory
> >   * list.
> > - *
> > - * Return: 0 on success, -ve on error
> >   */
> >  int lmb_init(void);
> >
> >  /**
> > - * lmb_add_memory() - Add memory range for LMB allocations
> > + * lmb_add_memory() - Add memory range for LMB allocations.
> >   *
> >   * Add the entire available memory range to the pool of memory that
> >   * can be used by the LMB module for allocations.
> > - *
> > - * Return: None
> >   */
> >  void lmb_add_memory(void);
> >
> >  long lmb_add(phys_addr_t base, phys_size_t size);
> > -long lmb_reserve(phys_addr_t base, phys_size_t size);
> > +
> >  /**
> > - * lmb_reserve_flags - Reserve one region with a specific flags bitfie=
ld.
> > + * lmb_reserve() - Reserve a memory region (with no special flags)
> > + * @base: Base address of the memory region
> > + * @size: Size of the memory region
> >   *
> > - * @base:      base address of the memory region
> > - * @size:      size of the memory region
> > - * @flags:     flags for the memory region
> > - * Return:     0 if OK, > 0 for coalesced region or a negative error c=
ode.
> > + * Return: 0 on success, negative error code on failure.
> > + */
> > +long lmb_reserve(phys_addr_t base, phys_size_t size);
> > +
> > +/**
> > + * lmb_reserve_flags() - Reserve one region with a specific flags bitf=
ield
> > + * @base: Base address of the memory region
> > + * @size: Size of the memory region
> > + * @flags: Flags for the memory region
> > + *
> > + * Return:
> > + * * %0                - Added successfully, or it's already added (on=
ly if LMB_NONE)
> > + * * %-EEXIST  - The region is already added, and flags !=3D LMB_NONE
> > + * * %-1       - Failure
> >   */
> >  long lmb_reserve_flags(phys_addr_t base, phys_size_t size,
> >                        enum lmb_flags flags);
> > +
> >  phys_addr_t lmb_alloc(phys_size_t size, ulong align);
> >  phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t =
max_addr);
> >  phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size);
> >  phys_size_t lmb_get_free_size(phys_addr_t addr);
> >
> > +/**
> > + * lmb_alloc_base_flags() - Allocate specified memory region with spec=
ified
> > + *                         attributes
> > + * @size: Size of the region requested
> > + * @align: Alignment of the memory region requested
> > + * @max_addr: Maximum address of the requested region
> > + * @flags: Memory region attributes to be set
> > + *
> > + * Allocate a region of memory with the attributes specified through t=
he
> > + * parameter. The max_addr parameter is used to specify the maximum ad=
dress
> > + * below which the requested region should be allocated.
> > + *
> > + * Return: Base address on success, 0 on error.
> > + */
> >  phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> >                                  phys_addr_t max_addr, uint flags);
> >
> >  /**
> > - * lmb_alloc_addr_flags() - Allocate specified memory address with spe=
cified attributes
> > + * lmb_alloc_addr_flags() - Allocate specified memory address with spe=
cified
> > + *                         attributes
> >   * @base: Base Address requested
> >   * @size: Size of the region requested
> >   * @flags: Memory region attributes to be set
> > @@ -111,20 +136,21 @@ phys_addr_t lmb_alloc_base_flags(phys_size_t size=
, ulong align,
> >   * parameter. The base parameter is used to specify the base address
> >   * of the requested region.
> >   *
> > - * Return: base address on success, 0 on error
> > + * Return: Base address on success, 0 on error.
> >   */
> >  phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> >                                  uint flags);
> >
> >  /**
> > - * lmb_is_reserved_flags() - test if address is in reserved region wit=
h flag bits set
> > + * lmb_is_reserved_flags() - Test if address is in reserved region wit=
h flag
> > + *                          bits set
> > + * @addr: Address to be tested
> > + * @flags: Bitmap with bits to be tested
> >   *
> >   * The function checks if a reserved region comprising @addr exists wh=
ich has
> >   * all flag bits set which are set in @flags.
> >   *
> > - * @addr:      address to be tested
> > - * @flags:     bitmap with bits to be tested
> > - * Return:     1 if matching reservation exists, 0 otherwise
> > + * Return: 1 if matching reservation exists, 0 otherwise.
> >   */
> >  int lmb_is_reserved_flags(phys_addr_t addr, int flags);
> >
> > @@ -134,9 +160,7 @@ int lmb_is_reserved_flags(phys_addr_t addr, int fla=
gs);
> >   * @size: Size of the region to be freed
> >   * @flags: Memory region attributes
> >   *
> > - * Free up a region of memory.
> > - *
> > - * Return: 0 if successful, -1 on failure
> > + * Return: 0 on success, negative error code on failure.
> >   */
> >  long lmb_free_flags(phys_addr_t base, phys_size_t size, uint flags);
> >
> > @@ -160,7 +184,7 @@ static inline int lmb_read_check(phys_addr_t addr, =
phys_size_t len)
> >   * io_lmb_setup() - Initialize LMB struct
> >   * @io_lmb: IO LMB to initialize
> >   *
> > - * Returns: 0 on success, negative error code on failure
> > + * Return: 0 on success, negative error code on failure.
> >   */
> >  int io_lmb_setup(struct lmb *io_lmb);
> >
> > @@ -178,12 +202,13 @@ void io_lmb_teardown(struct lmb *io_lmb);
> >   *
> >   * Add the IOVA space [base, base + size] to be managed by io_lmb.
> >   *
> > - * Returns: 0 if the region addition was successful, -1 on failure
> > + * Return: 0 on success, negative error code on failure.
> >   */
> >  long io_lmb_add(struct lmb *io_lmb, phys_addr_t base, phys_size_t size=
);
> >
> >  /**
> > - * io_lmb_alloc() - Allocate specified IO memory address with specifie=
d alignment
> > + * io_lmb_alloc() - Allocate specified IO memory address with specifie=
d
> > + *                 alignment
> >   * @io_lmb: LMB to alloc from
> >   * @size: Size of the region requested
> >   * @align: Required address and size alignment
> > @@ -191,7 +216,7 @@ long io_lmb_add(struct lmb *io_lmb, phys_addr_t bas=
e, phys_size_t size);
> >   * Allocate a region of IO memory. The base parameter is used to speci=
fy the
> >   * base address of the requested region.
> >   *
> > - * Return: base IO address on success, 0 on error
> > + * Return: Base IO address on success, 0 on error.
> >   */
> >  phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_size_t size, ulong a=
lign);
> >
> > @@ -201,9 +226,7 @@ phys_addr_t io_lmb_alloc(struct lmb *io_lmb, phys_s=
ize_t size, ulong align);
> >   * @base: Base Address of region to be freed
> >   * @size: Size of the region to be freed
> >   *
> > - * Free up a region of IOVA space.
> > - *
> > - * Return: 0 if successful, -1 on failure
> > + * Return: 0 on success, negative error code on failure.
> >   */
> >  long io_lmb_free(struct lmb *io_lmb, phys_addr_t base, phys_size_t siz=
e);
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 8c1c9b0f67c8..eee3bd37d446 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -609,14 +609,6 @@ static __maybe_unused void lmb_reserve_common_spl(=
void)
> >         }
> >  }
> >
> > -/**
> > - * lmb_add_memory() - Add memory range for LMB allocations
> > - *
> > - * Add the entire available memory range to the pool of memory that
> > - * can be used by the LMB module for allocations.
> > - *
> > - * Return: None
> > - */
> >  void lmb_add_memory(void)
> >  {
> >         int i;
> > @@ -673,16 +665,6 @@ long lmb_add(phys_addr_t base, phys_size_t size)
> >         return lmb_map_update_notify(base, size, MAP_OP_ADD, LMB_NONE);
> >  }
> >
> > -/**
> > - * lmb_free_flags() - Free up a region of memory
> > - * @base: Base Address of region to be freed
> > - * @size: Size of the region to be freed
> > - * @flags: Memory region attributes
> > - *
> > - * Free up a region of memory.
> > - *
> > - * Return: 0 if successful, negative error code on failure
> > - */
> >  long lmb_free_flags(phys_addr_t base, phys_size_t size,
> >                     uint flags)
> >  {
> > @@ -790,19 +772,6 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong=
 align, phys_addr_t max_addr)
> >         return alloc;
> >  }
> >
> > -/**
> > - * lmb_alloc_base_flags() - Allocate specified memory region with spec=
ified attributes
> > - * @size: Size of the region requested
> > - * @align: Alignment of the memory region requested
> > - * @max_addr: Maximum address of the requested region
> > - * @flags: Memory region attributes to be set
> > - *
> > - * Allocate a region of memory with the attributes specified through t=
he
> > - * parameter. The max_addr parameter is used to specify the maximum ad=
dress
> > - * below which the requested region should be allocated.
> > - *
> > - * Return: base address on success, 0 on error
> > - */
> >  phys_addr_t lmb_alloc_base_flags(phys_size_t size, ulong align,
> >                                  phys_addr_t max_addr, uint flags)
> >  {
> > @@ -851,18 +820,6 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_=
size_t size)
> >         return _lmb_alloc_addr(base, size, LMB_NONE);
> >  }
> >
> > -/**
> > - * lmb_alloc_addr_flags() - Allocate specified memory address with spe=
cified attributes
> > - * @base: Base Address requested
> > - * @size: Size of the region requested
> > - * @flags: Memory region attributes to be set
> > - *
> > - * Allocate a region of memory with the attributes specified through t=
he
> > - * parameter. The base parameter is used to specify the base address
> > - * of the requested region.
> > - *
> > - * Return: base address on success, 0 on error
> > - */
> >  phys_addr_t lmb_alloc_addr_flags(phys_addr_t base, phys_size_t size,
> >                                  uint flags)
> >  {
> > @@ -935,18 +892,6 @@ static int lmb_setup(bool test)
> >         return 0;
> >  }
> >
> > -/**
> > - * lmb_init() - Initialise the LMB module
> > - *
> > - * Initialise the LMB lists needed for keeping the memory map. There
> > - * are two lists, in form of alloced list data structure. One for the
> > - * available memory, and one for the used memory. Initialise the two
> > - * lists as part of board init. Add memory to the available memory
> > - * list and reserve common areas by adding them to the used memory
> > - * list.
> > - *
> > - * Return: 0 on success, -ve on error
> > - */
> >  int lmb_init(void)
> >  {
> >         int ret;
> > --
> > 2.39.5
> >
> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
