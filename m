Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893D8C25B76
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 09:50:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D3F288653;
	Tue, 11 Jun 2024 11:50:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CaouA6v/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC3C88661; Tue, 11 Jun 2024 11:50:23 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7585C880A3
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 11:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-57c72d6d5f3so3514834a12.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 02:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718099421; x=1718704221; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3lTIOwaa6e3caKErURgR12fIziIW2lJeKbytvhEN2xI=;
 b=CaouA6v/yTPZiPxgmEciS5M4o5//nNYIHSDY9uBjnlP+dqTyNkZxUdfbcuFpeC6KKN
 v/6Cn/gkKe1InHQ5dBFYPPuJ8egxk0jXjxEGOmCm04VWFZ7IbFYN046YMxJowJx+Y54T
 DpCfINUpc1orlF6zI4hvMHdTZeaRqrMZHqGhmMhL6aUw8S1BwFOao0Oky4Fi87zC/IDy
 aKY0+8Ikh2iwf6mkaLbc+uDBMeUFqOIGRSqIIN5tO5zX7X/nmQ7+/S9n7KZvm8LKNykR
 RWzk7Wc8/y71mwlv6LP91r32s8VBc2jKxlIpda5keN5omZz+Ac5lJxJjLcQW3/1NhX6W
 1pyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718099421; x=1718704221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3lTIOwaa6e3caKErURgR12fIziIW2lJeKbytvhEN2xI=;
 b=sGqfYBu2nkd+mZX24Pu9h9BhSlECYSBKLodjMgj/lpQFKhjoZJwXFY/fZpjRpILwAP
 K5IkCu4UuLkV+wh1V2I1PuDofP/13JvXLZLZP4TjmD6WKzxIHFmAoJ3KBo65YnJlLpkU
 e0/sRoA0QoE6UAqzTFGWgT0SJmK/XrXgZsR+d3m4R3IYJtubVEFNLaHlWHP652QzsmIj
 5AMERLAkPP6DWJBccg6QYIWko+T7OJ0z0i8XYY1enwgpYGylQG+IqYAlV0Ca0qcmHsgJ
 2yIcIS6AtjGX0Pa10P+5JgXgJWy0fHP3yK1wuK6MU+pHmfnEv9VgonROMz7Stt03uRhF
 oPIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7W9GbDiB/pAyswq5RBmYs+4R3LNV4LFGOhRyrBLMNN2NrMbA5B+tW2lhxVb0n7OjtUWkmpJLHguI8iU1efTuR+rVoqQ==
X-Gm-Message-State: AOJu0YwTCsBRWBECYZhyRaCMMX6xoJTLF4+SUuDvCvKJoh83eTcfsNZI
 U4HsYT3G1vmym8BkyTFPitE9MhhVrDSwMS6iq/94BkYgoCLPQLObYjtLJbDp51bfgWtCUK/9dH+
 9tIyevwuVWhL3xAqlvDHHbFD7Eo+ZaGtm+WlbnQ==
X-Google-Smtp-Source: AGHT+IF7VA+nwoU5IG1nkK7Dcf3xzJPDbM8wDHdD3SOv5o7XDXFpvQx0Gk71ffrS2+c/c0HoSK1/UbQ3D8iCJEwDiCk=
X-Received: by 2002:a50:8e49:0:b0:57c:5cfc:3824 with SMTP id
 4fb4d7f45d1cf-57c5cfc3bccmr6905778a12.8.1718099420895; Tue, 11 Jun 2024
 02:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-10-sughosh.ganu@linaro.org>
 <5d133571-ba43-40c7-bd19-0c0a4e857034@gmx.de>
In-Reply-To: <5d133571-ba43-40c7-bd19-0c0a4e857034@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 11 Jun 2024 15:20:09 +0530
Message-ID: <CADg8p94tXGdc69xE0tW1_JXT8oYhNSkV=hPfYp12x0Fe97TUhQ@mail.gmail.com>
Subject: Re: [RFC PATCH 09/31] lmb: allow for resizing lmb regions
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>,
 u-boot@lists.denx.de
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

On Tue, 11 Jun 2024 at 14:47, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 07.06.24 20:52, Sughosh Ganu wrote:
> > Allow for resizing of LMB regions if the region attributes match. The
> > current code returns a failure status on detecting an overlapping
> > address. This worked up until now since the LMB calls were not
> > persistent and global -- the LMB memory map was specific and private
> > to a given caller of the LMB API's.
> >
> > With the change in the LMB code to make the LMB reservations
> > persistent, there needs to be a check on whether the memory region can
> > be resized, and then do it if so. To distinguish between memory that
> > cannot be resized, add a new flag, LMB_NOOVERWRITE. Reserving a region
> > of memory with this attribute would indicate that the region cannot be
> > resized.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >   include/lmb.h |   1 +
> >   lib/lmb.c     | 120 ++++++++++++++++++++++++++++++++++++++++++++------
> >   2 files changed, 107 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/lmb.h b/include/lmb.h
> > index 03bce2a50c..1d4cd255d2 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -20,6 +20,7 @@
> >   enum lmb_flags {
> >       LMB_NONE                = 0x0,
> >       LMB_NOMAP               = 0x4,
> > +     LMB_NOOVERWRITE         = 0x8,
>
> Please, add the missing description for the new value. Using the first
> available bit (0x01) would be expected.
>
> Using the BIT macro would make it clearer that these are bits of a bitmap:
>
> enum lmb_flags {
>         LMB_NONE                = BIT(0),
>         LMB_NOOVERWRITE         = BIT(1),
> };

Noted. Will change.

-sughosh

>
> Best regards
>
> Heinrich
>
>
> >   };
> >
> >   /**
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index de5a2cf23b..0a4f3d5bcd 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -260,12 +260,88 @@ void lmb_add_memory(struct bd_info *bd)
> >       }
> >   }
> >
> > +static bool lmb_region_flags_match(struct lmb_region *rgn, unsigned long r1,
> > +                                enum lmb_flags flags)
> > +{
> > +     return rgn->region[r1].flags == flags;
> > +}
> > +
> > +static long lmb_merge_overlap_regions(struct lmb_region *rgn, unsigned long i,
> > +                                   phys_addr_t base, phys_size_t size,
> > +                                   enum lmb_flags flags)
> > +{
> > +     phys_size_t rgnsize;
> > +     unsigned long rgn_cnt, idx;
> > +     phys_addr_t rgnbase, rgnend;
> > +     phys_addr_t mergebase, mergeend;
> > +
> > +     rgn_cnt = 0;
> > +     idx = i;
> > +     /*
> > +      * First thing to do is to identify how many regions does
> > +      * the requested region overlap.
> > +      * If the flags match, combine all these overlapping
> > +      * regions into a single region, and remove the merged
> > +      * regions.
> > +      */
> > +     while (idx < rgn->cnt - 1) {
> > +             rgnbase = rgn->region[idx].base;
> > +             rgnsize = rgn->region[idx].size;
> > +
> > +             if (lmb_addrs_overlap(base, size, rgnbase,
> > +                                   rgnsize)) {
> > +                     if (!lmb_region_flags_match(rgn, idx, flags))
> > +                             return -1;
> > +                     rgn_cnt++;
> > +                     idx++;
> > +             }
> > +     }
> > +
> > +     /* The merged region's base and size */
> > +     rgnbase = rgn->region[i].base;
> > +     mergebase = min(base, rgnbase);
> > +     rgnend = rgn->region[idx].base + rgn->region[idx].size;
> > +     mergeend = max(rgnend, (base + size));
> > +
> > +     rgn->region[i].base = mergebase;
> > +     rgn->region[i].size = mergeend - mergebase;
> > +
> > +     /* Now remove the merged regions */
> > +     while (--rgn_cnt)
> > +             lmb_remove_region(rgn, i + 1);
> > +
> > +     return 0;
> > +}
> > +
> > +static long lmb_resize_regions(struct lmb_region *rgn, unsigned long i,
> > +                            phys_addr_t base, phys_size_t size,
> > +                            enum lmb_flags flags)
> > +{
> > +     long ret = 0;
> > +     phys_addr_t rgnend;
> > +
> > +     if (i == rgn->cnt - 1 ||
> > +             base + size < rgn->region[i + 1].base) {
> > +             if (!lmb_region_flags_match(rgn, i, flags))
> > +                     return -1;
> > +
> > +             rgnend = rgn->region[i].base + rgn->region[i].size;
> > +             rgn->region[i].base = min(base, rgn->region[i].base);
> > +             rgnend = max(base + size, rgnend);
> > +             rgn->region[i].size = rgnend - rgn->region[i].base;
> > +     } else {
> > +             ret = lmb_merge_overlap_regions(rgn, i, base, size, flags);
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >   /* This routine called with relocation disabled. */
> >   static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> >                                phys_size_t size, enum lmb_flags flags)
> >   {
> >       unsigned long coalesced = 0;
> > -     long adjacent, i;
> > +     long ret, i;
> >
> >       if (rgn->cnt == 0) {
> >               rgn->region[0].base = base;
> > @@ -290,23 +366,32 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> >                               return -1; /* regions with new flags */
> >               }
> >
> > -             adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> > -             if (adjacent > 0) {
> > +             ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> > +             if (ret > 0) {
> >                       if (flags != rgnflags)
> >                               break;
> >                       rgn->region[i].base -= size;
> >                       rgn->region[i].size += size;
> >                       coalesced++;
> >                       break;
> > -             } else if (adjacent < 0) {
> > +             } else if (ret < 0) {
> >                       if (flags != rgnflags)
> >                               break;
> >                       rgn->region[i].size += size;
> >                       coalesced++;
> >                       break;
> >               } else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> > -                     /* regions overlap */
> > -                     return -1;
> > +                     if (flags == LMB_NONE) {
> > +                             ret = lmb_resize_regions(rgn, i, base, size,
> > +                                                      flags);
> > +                             if (ret < 0)
> > +                                     return -1;
> > +
> > +                             coalesced++;
> > +                             break;
> > +                     } else {
> > +                             return -1;
> > +                     }
> >               }
> >       }
> >
> > @@ -448,7 +533,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
> >   }
> >
> >   static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
> > -                                 phys_addr_t max_addr)
> > +                                 phys_addr_t max_addr, enum lmb_flags flags)
> >   {
> >       long i, rgn;
> >       phys_addr_t base = 0;
> > @@ -498,7 +583,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
> >   {
> >       phys_addr_t alloc;
> >
> > -     alloc = __lmb_alloc_base(size, align, max_addr);
> > +     alloc = __lmb_alloc_base(size, align, max_addr, LMB_NONE);
> >
> >       if (alloc == 0)
> >               printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
> > @@ -507,11 +592,8 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
> >       return alloc;
> >   }
> >
> > -/*
> > - * Try to allocate a specific address range: must be in defined memory but not
> > - * reserved
> > - */
> > -phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
> > +static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> > +                                 enum lmb_flags flags)
> >   {
> >       long rgn;
> >
> > @@ -526,13 +608,23 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
> >                                     lmb.memory.region[rgn].size,
> >                                     base + size - 1, 1)) {
> >                       /* ok, reserve the memory */
> > -                     if (lmb_reserve(base, size) >= 0)
> > +                     if (lmb_reserve_flags(base, size, flags) >= 0)
> >                               return base;
> >               }
> >       }
> > +
> >       return 0;
> >   }
> >
> > +/*
> > + * Try to allocate a specific address range: must be in defined memory but not
> > + * reserved
> > + */
> > +phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
> > +{
> > +     return __lmb_alloc_addr(base, size, LMB_NONE);
> > +}
> > +
> >   /* Return number of bytes from a given address that are free */
> >   phys_size_t lmb_get_free_size(phys_addr_t addr)
> >   {
>
