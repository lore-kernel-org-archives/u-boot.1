Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33312C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 13:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A34288378;
	Mon, 10 Jun 2024 15:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MsP7G8Bo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E285388545; Mon, 10 Jun 2024 15:01:17 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEC4E88262
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 15:01:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-57864327f6eso6457328a12.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 06:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718024475; x=1718629275; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Wojpn9hpy02NjeGiT3uJbNHQJShB4wJRkh+WAtemUQw=;
 b=MsP7G8BotnD0ypaoBzv3JquiT1uZHDGTwAFUgx/rnT8oMAmeWl5lHZDvtBBQ1j9Nvt
 syuoS/imwNjFVrBnVxfsCbEItCK8HDq6ac6ymgHZKMsc8l6r7PB1Y6lklVYdWdIkbR2B
 0DTp1myoxEnm9DngxU5P3YVaG/M49UhrAbFjOZoSH+oZ13ypyYWpZHQiZNckrgyQfOgY
 xmYkh2jijXBI+S23AerVgwbmrwMBGGL03nbFa9zaduoz86hB+TUHV7dKjNjIkqn5Gab2
 GrY65Y507Cw1VStHfoVWCSIl0/ZNNLY1bXmdVB4Z0jkHIIJR27YJxhQ4gyk8ohO9R4C7
 GlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718024475; x=1718629275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wojpn9hpy02NjeGiT3uJbNHQJShB4wJRkh+WAtemUQw=;
 b=M4q/Nl+YMKg9/Nkch+eClmS6zB5fXPDcCJ+9/EaIv6bnLnjFHEFGJs3/dNjuFjDR7R
 Dz/Vuhga7lkRtziADfYROQKLv7ShqGCid4hBPEmcSqL7EFUoC+7KconppgDuNSkDp04T
 OnDYRQ+9IhtKm+3JG5dCKtp0E34+qxXvBl+MVWH1bAGdrVlLuMP9kFTpgRSiIyE3t0tP
 q3Fy918ghlIAih/g58Cx3kSr17bs/7ion9VzJxd7hymJszSOEWCTpGxBbhLkZ6bpqxD+
 oXbN+bGb7bYkR9/oYa5d++djHElRD7YfnrWNpnjj192vqHrvLlSEcfUTwZ9/+dv1iKlI
 7HmQ==
X-Gm-Message-State: AOJu0YxRYvdMIWjZRubPgneMjJri3wQzamZ9kQDcKzVFtkGkOorCcXfw
 BogW+eUMkSm7TiMbuZ0c95Qt44uTZNAbV1+9VIeEwD1V5oAK2gTUohOe3KZ4PcXBpeMkl2wloqx
 CwQ0xcBOfYSe91Fn/AHXfpRtUTMrPt1lHT/E239r/UZzOE3Xm
X-Google-Smtp-Source: AGHT+IGGWi8poIksbzyeckgHTblUghdJgyWpv9QWiq324j8uyiHA+RLeGpCkZfHQaSlqCPFmXMQjlmV6qE7iG3rdIqI=
X-Received: by 2002:a50:8e48:0:b0:57c:60e5:c2d7 with SMTP id
 4fb4d7f45d1cf-57c60e5c454mr5550031a12.1.1718024474628; Mon, 10 Jun 2024
 06:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-10-sughosh.ganu@linaro.org>
 <CAC_iWjJARprGkjPQV4nVGKPWxBL+3iiSAuKcdqUNvn+hKV40XQ@mail.gmail.com>
 <CADg8p95O5FMyyLV3yZkRshrOB4nbKa4VdQwMxrSf4bB9z4e8Yg@mail.gmail.com>
 <79cb4931-469f-4065-b791-f1ba4398dfd0@gmx.de>
In-Reply-To: <79cb4931-469f-4065-b791-f1ba4398dfd0@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 10 Jun 2024 18:31:02 +0530
Message-ID: <CADg8p94FVPZdH9YH+K+DNXP-2kt=81FbMfkHR0Y55HgGa+Ot+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 09/31] lmb: allow for resizing lmb regions
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Mon, 10 Jun 2024 at 18:29, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10.06.24 14:20, Sughosh Ganu wrote:
> > hi Ilias,
> >
> > On Mon, 10 Jun 2024 at 17:34, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi Sughosh
> >>
> >>
> >> On Fri, 7 Jun 2024 at 21:54, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >>>
> >>> Allow for resizing of LMB regions if the region attributes match. The
> >>> current code returns a failure status on detecting an overlapping
> >>> address. This worked up until now since the LMB calls were not
> >>> persistent and global -- the LMB memory map was specific and private
> >>> to a given caller of the LMB API's.
> >>>
> >>> With the change in the LMB code to make the LMB reservations
> >>> persistent, there needs to be a check on whether the memory region can
> >>> be resized, and then do it if so. To distinguish between memory that
> >>> cannot be resized, add a new flag, LMB_NOOVERWRITE. Reserving a region
> >>> of memory with this attribute would indicate that the region cannot be
> >>> resized.
> >>
> >> Can you think of a memory region that needs to be protected from resizing?
> >
> > Actually, I think I could use a better term instead of 'resize'. The
> > aim of this patch is to allow re-allocation/re-reservation of the same
> > region of memory -- this will only be relevant for the LMB
> > reservations, as these are used for loading images into memory. All
> > other allocations(EFI currently) are true allocations in that these
> > should not get overwritten at all. Memory once allocated, say for
> > loading an EFI image, cannot be re-requested.
> >
> >
> >> I think we should design this a bit differently.  For example, think
> >> of someone loading a file in a memory region and then a subsystem
> >> trying to resize its reserved memory overwriting that region. Instead
> >> of this flag why don't we add
> >> - A flag that indicates whether this region can be re-used (IOW
> >> overwrites it), but only if the 'subsytem id' defined below matches
> >> - a u32 that indicates the subsystem ID that initiated the transaction
> >> -- e.g EFI, load command, U-Boot core .. etc
> >>
> >> Resizing can be enabled unconditionally in that case as long as there
> >> is enough space. The only requirement would be that the request comes
> >> from the same subsystem that reserved the memory in the beginning
> >
> > Like I mentioned above, resizing(or rather re-allocations) should only
> > be allowed for the LMB subsystem. Any other module should not be
> > returned an already allocated address. Which is why I mark any memory
> > map update coming from the EFI module as no-overwrite.
> >
> > -sughosh
> >>
> >> Thanks
> >> /Ilias
> >>
> >>>
> >>> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >>> ---
> >>>   include/lmb.h |   1 +
> >>>   lib/lmb.c     | 120 ++++++++++++++++++++++++++++++++++++++++++++------
> >>>   2 files changed, 107 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/include/lmb.h b/include/lmb.h
> >>> index 03bce2a50c..1d4cd255d2 100644
> >>> --- a/include/lmb.h
> >>> +++ b/include/lmb.h
> >>> @@ -20,6 +20,7 @@
> >>>   enum lmb_flags {
> >>>          LMB_NONE                = 0x0,
> >>>          LMB_NOMAP               = 0x4,
> >>> +       LMB_NOOVERWRITE         = 0x8,
> >>>   };
> >>>
> >>>   /**
> >>> diff --git a/lib/lmb.c b/lib/lmb.c
> >>> index de5a2cf23b..0a4f3d5bcd 100644
> >>> --- a/lib/lmb.c
> >>> +++ b/lib/lmb.c
> >>> @@ -260,12 +260,88 @@ void lmb_add_memory(struct bd_info *bd)
> >>>          }
> >>>   }
> >>>
> >>> +static bool lmb_region_flags_match(struct lmb_region *rgn, unsigned long r1,
> >>> +                                  enum lmb_flags flags)
> >>> +{
> >>> +       return rgn->region[r1].flags == flags;
> >>> +}
> >>> +
> >>> +static long lmb_merge_overlap_regions(struct lmb_region *rgn, unsigned long i,
> >>> +                                     phys_addr_t base, phys_size_t size,
> >>> +                                     enum lmb_flags flags)
> >>> +{
> >>> +       phys_size_t rgnsize;
> >>> +       unsigned long rgn_cnt, idx;
> >>> +       phys_addr_t rgnbase, rgnend;
> >>> +       phys_addr_t mergebase, mergeend;
> >>> +
> >>> +       rgn_cnt = 0;
> >>> +       idx = i;
> >>> +       /*
> >>> +        * First thing to do is to identify how many regions does
> >>> +        * the requested region overlap.
> >>> +        * If the flags match, combine all these overlapping
> >>> +        * regions into a single region, and remove the merged
> >>> +        * regions.
> >>> +        */
> >>> +       while (idx < rgn->cnt - 1) {
> >>> +               rgnbase = rgn->region[idx].base;
> >>> +               rgnsize = rgn->region[idx].size;
>
> It would be preferable to replace fixed size arrays by linked lists.
> This will allow us to eliminate CONFIG_LMB_MAX_REGIONS.
>
> EFI may create any number of non-coalescable memory regions.

Noted. I will work on this change for the next version.

-sughosh

>
> Best regards
>
> Heinrich
>
> >>> +
> >>> +               if (lmb_addrs_overlap(base, size, rgnbase,
> >>> +                                     rgnsize)) {
> >>> +                       if (!lmb_region_flags_match(rgn, idx, flags))
> >>> +                               return -1;
> >>> +                       rgn_cnt++;
> >>> +                       idx++;
> >>> +               }
> >>> +       }
> >>> +
> >>> +       /* The merged region's base and size */
> >>> +       rgnbase = rgn->region[i].base;
> >>> +       mergebase = min(base, rgnbase);
> >>> +       rgnend = rgn->region[idx].base + rgn->region[idx].size;
> >>> +       mergeend = max(rgnend, (base + size));
> >>> +
> >>> +       rgn->region[i].base = mergebase;
> >>> +       rgn->region[i].size = mergeend - mergebase;
> >>> +
> >>> +       /* Now remove the merged regions */
> >>> +       while (--rgn_cnt)
> >>> +               lmb_remove_region(rgn, i + 1);
> >>> +
> >>> +       return 0;
> >>> +}
> >>> +
> >>> +static long lmb_resize_regions(struct lmb_region *rgn, unsigned long i,
> >>> +                              phys_addr_t base, phys_size_t size,
> >>> +                              enum lmb_flags flags)
> >>> +{
> >>> +       long ret = 0;
> >>> +       phys_addr_t rgnend;
> >>> +
> >>> +       if (i == rgn->cnt - 1 ||
> >>> +               base + size < rgn->region[i + 1].base) {
> >>> +               if (!lmb_region_flags_match(rgn, i, flags))
> >>> +                       return -1;
> >>> +
> >>> +               rgnend = rgn->region[i].base + rgn->region[i].size;
> >>> +               rgn->region[i].base = min(base, rgn->region[i].base);
> >>> +               rgnend = max(base + size, rgnend);
> >>> +               rgn->region[i].size = rgnend - rgn->region[i].base;
> >>> +       } else {
> >>> +               ret = lmb_merge_overlap_regions(rgn, i, base, size, flags);
> >>> +       }
> >>> +
> >>> +       return ret;
> >>> +}
> >>> +
> >>>   /* This routine called with relocation disabled. */
> >>>   static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> >>>                                   phys_size_t size, enum lmb_flags flags)
> >>>   {
> >>>          unsigned long coalesced = 0;
> >>> -       long adjacent, i;
> >>> +       long ret, i;
> >>>
> >>>          if (rgn->cnt == 0) {
> >>>                  rgn->region[0].base = base;
> >>> @@ -290,23 +366,32 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> >>>                                  return -1; /* regions with new flags */
> >>>                  }
> >>>
> >>> -               adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> >>> -               if (adjacent > 0) {
> >>> +               ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> >>> +               if (ret > 0) {
> >>>                          if (flags != rgnflags)
> >>>                                  break;
> >>>                          rgn->region[i].base -= size;
> >>>                          rgn->region[i].size += size;
> >>>                          coalesced++;
> >>>                          break;
> >>> -               } else if (adjacent < 0) {
> >>> +               } else if (ret < 0) {
> >>>                          if (flags != rgnflags)
> >>>                                  break;
> >>>                          rgn->region[i].size += size;
> >>>                          coalesced++;
> >>>                          break;
> >>>                  } else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> >>> -                       /* regions overlap */
> >>> -                       return -1;
> >>> +                       if (flags == LMB_NONE) {
> >>> +                               ret = lmb_resize_regions(rgn, i, base, size,
> >>> +                                                        flags);
> >>> +                               if (ret < 0)
> >>> +                                       return -1;
> >>> +
> >>> +                               coalesced++;
> >>> +                               break;
> >>> +                       } else {
> >>> +                               return -1;
> >>> +                       }
> >>>                  }
> >>>          }
> >>>
> >>> @@ -448,7 +533,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
> >>>   }
> >>>
> >>>   static phys_addr_t __lmb_alloc_base(phys_size_t size, ulong align,
> >>> -                                   phys_addr_t max_addr)
> >>> +                                   phys_addr_t max_addr, enum lmb_flags flags)
> >>>   {
> >>>          long i, rgn;
> >>>          phys_addr_t base = 0;
> >>> @@ -498,7 +583,7 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
> >>>   {
> >>>          phys_addr_t alloc;
> >>>
> >>> -       alloc = __lmb_alloc_base(size, align, max_addr);
> >>> +       alloc = __lmb_alloc_base(size, align, max_addr, LMB_NONE);
> >>>
> >>>          if (alloc == 0)
> >>>                  printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
> >>> @@ -507,11 +592,8 @@ phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr)
> >>>          return alloc;
> >>>   }
> >>>
> >>> -/*
> >>> - * Try to allocate a specific address range: must be in defined memory but not
> >>> - * reserved
> >>> - */
> >>> -phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
> >>> +static phys_addr_t __lmb_alloc_addr(phys_addr_t base, phys_size_t size,
> >>> +                                   enum lmb_flags flags)
> >>>   {
> >>>          long rgn;
> >>>
> >>> @@ -526,13 +608,23 @@ phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
> >>>                                        lmb.memory.region[rgn].size,
> >>>                                        base + size - 1, 1)) {
> >>>                          /* ok, reserve the memory */
> >>> -                       if (lmb_reserve(base, size) >= 0)
> >>> +                       if (lmb_reserve_flags(base, size, flags) >= 0)
> >>>                                  return base;
> >>>                  }
> >>>          }
> >>> +
> >>>          return 0;
> >>>   }
> >>>
> >>> +/*
> >>> + * Try to allocate a specific address range: must be in defined memory but not
> >>> + * reserved
> >>> + */
> >>> +phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size)
> >>> +{
> >>> +       return __lmb_alloc_addr(base, size, LMB_NONE);
> >>> +}
> >>> +
> >>>   /* Return number of bytes from a given address that are free */
> >>>   phys_size_t lmb_get_free_size(phys_addr_t addr)
> >>>   {
> >>> --
> >>> 2.34.1
> >>>
>
