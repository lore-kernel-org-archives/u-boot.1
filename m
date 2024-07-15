Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F9CC3DA5D
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 09:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5667E87D87;
	Mon, 15 Jul 2024 11:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AYYVmiuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08B6F87C7E; Mon, 15 Jul 2024 11:27:36 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C77DC87D87
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 11:27:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ec61eeed8eso53079141fa.0
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 02:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721035652; x=1721640452; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jh8KetcihlGCpSS8ond8DYwz3gvhdtz6QCA6YNwaV/w=;
 b=AYYVmiuMX51aMklf/fbZMOIUCZUWwlABEmP/evM+BL1QATrQeyChdDSS3nBmZVL70X
 3Ru3Uon3o5gQJCDZlN6hyYAY0GnvKTJqoWlFlE6ocgSj8F5wUgd50lULqAxcjiyeQvs3
 RVxv4nUdNVJUf8a7J+9qv97042iMV8qiX/9MoF8IDrtlAXOlCi+Yk97EBkUnWB/cLH2B
 WGrnBfVh66gYtV06HZUdw17UfyCplnrPjkxAfTjQIYWJ7Ao98VIt+gIOofB5IeXYP/Wq
 rfj8i2ApWiz1snh0JlzCVUvlgQC+hh71/Hv1NNbTdhYW3L8Ob98PqMiXTa24umFpv+c3
 5nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721035652; x=1721640452;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jh8KetcihlGCpSS8ond8DYwz3gvhdtz6QCA6YNwaV/w=;
 b=xHwDQfRWwZn7tjFs9YkgaNXX1fS2JPTUved7R9uyvziO5QOe7EN5Vrn5VcAcnUbrs7
 0areM2luODI4KPRJztRlcimc94KH2tdWxM0OqsjTXBd9BdIxgMHHv3AJ0axbcZNXjAlt
 QaEBRsblXhnHHKEzSffXRtkF75LzRut18lakDLWtmDjqTIhFTZD0G7QR04zAVmvmA4m0
 EIMp6lWybsGC7aDeMrrWtuwZ/dlOyPP8LXeQ6e23+awiUict3mIM+mivWZjXby4EiD/b
 Xq5AFfDGq/hyFx86M2TUqR7xHNsIX2vV1YQnoCBSpYaewE8hQAcc7SIuXrY5Re9ACH/V
 JwQw==
X-Gm-Message-State: AOJu0YytaGnYcj+TS4HwE1e75LFm0RXbLYrJVauSAgmguXd6UkFbATHl
 nJJJcCKbXWLJUyL/DCHiO9rEqoyodaAw5jph0xgm0RqOe8ZcH6hge6J88pR/QcVd/yhwn9idWQM
 hw1G57ZCXBuyya1vznjKueHG+XwS6KZRixSVmdQ==
X-Google-Smtp-Source: AGHT+IHpg8RPQM2oibdkwF8ELoQepF59ERDwq529etxk15fhZBUv7O7n82IRNpY+5Ti5TenNifvqG9prKDcsp1OR/c0=
X-Received: by 2002:a2e:a4d8:0:b0:2ee:92ea:8d0a with SMTP id
 38308e7fff4ca-2eeb3102734mr107105901fa.23.1721035651994; Mon, 15 Jul 2024
 02:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-13-sughosh.ganu@linaro.org>
 <CAFLszTgp4GQydJY611gTOBnUk+Ce6o4vkVqNKtgcwKVzW9X6WQ@mail.gmail.com>
In-Reply-To: <CAFLszTgp4GQydJY611gTOBnUk+Ce6o4vkVqNKtgcwKVzW9X6WQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 15 Jul 2024 14:57:20 +0530
Message-ID: <CADg8p94u_CYkek8tnPGtM8JOAn4QjMh5oLKCqvhRdj0M=H8GDA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/48] lmb: allow for resizing lmb regions
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

On Sat, 13 Jul 2024 at 20:45, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
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
> > Changes since V1:
> > * Do the check for the region flags in lmb_resize_regions() and
> >   lmb_merge_overlap_regions() to decide on merging the overlapping
> >   regions.
> >
> >  include/lmb.h |   1 +
> >  lib/lmb.c     | 116 ++++++++++++++++++++++++++++++++++++++++++++------
> >  2 files changed, 103 insertions(+), 14 deletions(-)
> >
> > diff --git a/include/lmb.h b/include/lmb.h
> > index 069c6af2a3..99fcf5781f 100644
> > --- a/include/lmb.h
> > +++ b/include/lmb.h
> > @@ -20,6 +20,7 @@
> >  enum lmb_flags {
> >         LMB_NONE                = 0x0,
> >         LMB_NOMAP               = 0x4,
> > +       LMB_NOOVERWRITE         = 0x8,
>
> How about LMB_PERSIST ?

Isn't LMB_NOOVERWRITE more suitable here ? I mean this is indicating
that the said region of memory is not to be re-used/re-requested.

>
> These could be adjusted to use BIT()

I am changing these to use the BIT macro in a subsequent commit.

>
> >  };
> >
> >  /**
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index 0d01e58a46..80945e3cae 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -230,12 +230,88 @@ void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
> >         lmb_reserve_common(fdt_blob);
> >  }
> >
> > +static bool lmb_region_flags_match(struct lmb_region *rgn, unsigned long r1,
>
> At some point the index should change to an int (or uint), rather than
> unsigned long. I had a series that did that, but it died.
>
> > +                                  enum lmb_flags flags)
> > +{
> > +       return rgn->region[r1].flags == flags;
> > +}
> > +
> > +static long lmb_merge_overlap_regions(struct lmb_region *rgn, unsigned long i,
> > +                                     phys_addr_t base, phys_size_t size,
> > +                                     enum lmb_flags flags)
> > +{
> > +       phys_size_t rgnsize;
> > +       unsigned long rgn_cnt, idx;
> > +       phys_addr_t rgnbase, rgnend;
> > +       phys_addr_t mergebase, mergeend;
> > +
> > +       rgn_cnt = 0;
> > +       idx = i;
> > +       /*
> > +        * First thing to do is to identify how many regions does
> > +        * the requested region overlap.
>
> how many regions the requested region overlaps

Okay

>
> > +        * If the flags match, combine all these overlapping
> > +        * regions into a single region, and remove the merged
> > +        * regions.
> > +        */
> > +       while (idx < rgn->cnt - 1) {
> > +               rgnbase = rgn->region[idx].base;
> > +               rgnsize = rgn->region[idx].size;
> > +
> > +               if (lmb_addrs_overlap(base, size, rgnbase,
> > +                                     rgnsize)) {
> > +                       if (!lmb_region_flags_match(rgn, idx, flags))
> > +                               return -1;
> > +                       rgn_cnt++;
> > +                       idx++;
> > +               }
> > +       }
> > +
> > +       /* The merged region's base and size */
> > +       rgnbase = rgn->region[i].base;
> > +       mergebase = min(base, rgnbase);
> > +       rgnend = rgn->region[idx].base + rgn->region[idx].size;
> > +       mergeend = max(rgnend, (base + size));
> > +
> > +       rgn->region[i].base = mergebase;
> > +       rgn->region[i].size = mergeend - mergebase;
> > +
> > +       /* Now remove the merged regions */
> > +       while (--rgn_cnt)
> > +               lmb_remove_region(rgn, i + 1);
> > +
> > +       return 0;
> > +}
> > +
> > +static long lmb_resize_regions(struct lmb_region *rgn, unsigned long i,
> > +                              phys_addr_t base, phys_size_t size,
> > +                              enum lmb_flags flags)
> > +{
> > +       long ret = 0;
> > +       phys_addr_t rgnend;
> > +
> > +       if (i == rgn->cnt - 1 ||
> > +               base + size < rgn->region[i + 1].base) {
> > +               if (!lmb_region_flags_match(rgn, i, flags))
> > +                       return -1;
> > +
> > +               rgnend = rgn->region[i].base + rgn->region[i].size;
> > +               rgn->region[i].base = min(base, rgn->region[i].base);
> > +               rgnend = max(base + size, rgnend);
> > +               rgn->region[i].size = rgnend - rgn->region[i].base;
> > +       } else {
> > +               ret = lmb_merge_overlap_regions(rgn, i, base, size, flags);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> >  /* This routine called with relocation disabled. */
> >  static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> >                                  phys_size_t size, enum lmb_flags flags)
>
> This could really use a function comment

Okay

-sughosh

>
> >  {
> >         unsigned long coalesced = 0;
> > -       long adjacent, i;
> > +       long ret, i;
> >
> >         if (rgn->cnt == 0) {
> >                 rgn->region[0].base = base;
> > @@ -260,23 +336,28 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> >                                 return -1; /* regions with new flags */
> >                 }
> >
> > -               adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> > -               if (adjacent > 0) {
> > +               ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> > +               if (ret > 0) {
> >                         if (flags != rgnflags)
> >                                 break;
> >                         rgn->region[i].base -= size;
> >                         rgn->region[i].size += size;
> >                         coalesced++;
> >                         break;
> > -               } else if (adjacent < 0) {
> > +               } else if (ret < 0) {
> >                         if (flags != rgnflags)
> >                                 break;
> >                         rgn->region[i].size += size;
> >                         coalesced++;
> >                         break;
> >                 } else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> > -                       /* regions overlap */
> > -                       return -1;
> > +                       ret = lmb_resize_regions(rgn, i, base, size,
> > +                                                flags);
> > +                       if (ret < 0)
> > +                               return -1;
> > +
> > +                       coalesced++;
> > +                       break;
> >                 }
> >         }
> >
> > @@ -418,7 +499,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
> >  }
> >
>
> Regards,
> Simon
