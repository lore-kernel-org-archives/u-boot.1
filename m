Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55373C3DA42
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 15:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1BE6888FA;
	Sat, 13 Jul 2024 17:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j6zQd9Yv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7031188817; Sat, 13 Jul 2024 17:15:46 +0200 (CEST)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 164AC888F6
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 17:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fb3b7d0d3aso18494235ad.2
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720883742; x=1721488542; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QygjSNvgmYbUQH25uPQ1yZfBAj3Nktpv4skSulKcPI4=;
 b=j6zQd9YvFFKKGw4+04lXCmUW9UBwoiySdugwd7WP1gKYsKUGTIdSnN4N+R5h5neET+
 dL/6Zg7ZIY4CNyQOEGmSyJLAQ+Uqx1Oo3OTLdJeN/E4hE9zXHgAnQbH9pMEna1UTWsUG
 QXWaLGihzI644FBTBUixgO89sPQK0Ottqws0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720883742; x=1721488542;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QygjSNvgmYbUQH25uPQ1yZfBAj3Nktpv4skSulKcPI4=;
 b=XuHCJWEN161iIzCJdh/uslwwj1qUAkhzPhe+6FGfWxHTdOKykYogFNi3KrPTU+YkBP
 0Yc4YVTRqKrDmH/nnBjUfQr7gdlRdyfz1cQNAbbo3MiCQr9iTYxQW3Ge95yY22fSB9LJ
 Do9Tbpna3ggqW4Fvr5GdiSIxpCZl2mNRWh/47esO3xWOuVqt4nmbKrqlVmsCmZupo2Ag
 CiQwiy6gQoJLn69TOmZKCef/tYq/xmdHZ+YOj/pHblvIovAdFD4sBKxZqOxjiJE6hbSI
 r4XTAeX9naoeWNeh709HrukR3sqDfTTNRcy8rr5/pYGaO/ZkkPJK76G+VGlvbi3gi8yY
 jL5A==
X-Gm-Message-State: AOJu0YwCRZ/0wSmGRLn5gBnjDEU4OLQJAbA7/WfJR5DiR4+9G6R7w0NG
 wKd9q9ps3o+N6y5cllkH1C8s01IoKsW30N0VbPiggWeBrpaAeGc370ZAKhsW1gD/XNAtE9HxO89
 WUPJ6uKbhEfNSGGg5eGwGf71Z20Pd8426iQE0
X-Google-Smtp-Source: AGHT+IHS443siIF2ksXVI+YZp1C/KMGsDgDlUD0oeXPOJj2QB3VFE2gxKm/lXk0Iohk1VzjVYy/BMN63nep9yVntovY=
X-Received: by 2002:a17:90b:257:b0:2ca:d1dc:47e2 with SMTP id
 98e67ed59e1d1-2cad1dc4b8fmr3130957a91.33.1720883742513; Sat, 13 Jul 2024
 08:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-13-sughosh.ganu@linaro.org>
In-Reply-To: <20240704073544.670249-13-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 13 Jul 2024 16:15:29 +0100
Message-ID: <CAFLszTgp4GQydJY611gTOBnUk+Ce6o4vkVqNKtgcwKVzW9X6WQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/48] lmb: allow for resizing lmb regions
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

On Thu, 4 Jul 2024 at 08:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Allow for resizing of LMB regions if the region attributes match. The
> current code returns a failure status on detecting an overlapping
> address. This worked up until now since the LMB calls were not
> persistent and global -- the LMB memory map was specific and private
> to a given caller of the LMB API's.
>
> With the change in the LMB code to make the LMB reservations
> persistent, there needs to be a check on whether the memory region can
> be resized, and then do it if so. To distinguish between memory that
> cannot be resized, add a new flag, LMB_NOOVERWRITE. Reserving a region
> of memory with this attribute would indicate that the region cannot be
> resized.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Do the check for the region flags in lmb_resize_regions() and
>   lmb_merge_overlap_regions() to decide on merging the overlapping
>   regions.
>
>  include/lmb.h |   1 +
>  lib/lmb.c     | 116 ++++++++++++++++++++++++++++++++++++++++++++------
>  2 files changed, 103 insertions(+), 14 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index 069c6af2a3..99fcf5781f 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -20,6 +20,7 @@
>  enum lmb_flags {
>         LMB_NONE                = 0x0,
>         LMB_NOMAP               = 0x4,
> +       LMB_NOOVERWRITE         = 0x8,

How about LMB_PERSIST ?

These could be adjusted to use BIT()

>  };
>
>  /**
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 0d01e58a46..80945e3cae 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -230,12 +230,88 @@ void lmb_init_and_reserve_range(phys_addr_t base, phys_size_t size,
>         lmb_reserve_common(fdt_blob);
>  }
>
> +static bool lmb_region_flags_match(struct lmb_region *rgn, unsigned long r1,

At some point the index should change to an int (or uint), rather than
unsigned long. I had a series that did that, but it died.

> +                                  enum lmb_flags flags)
> +{
> +       return rgn->region[r1].flags == flags;
> +}
> +
> +static long lmb_merge_overlap_regions(struct lmb_region *rgn, unsigned long i,
> +                                     phys_addr_t base, phys_size_t size,
> +                                     enum lmb_flags flags)
> +{
> +       phys_size_t rgnsize;
> +       unsigned long rgn_cnt, idx;
> +       phys_addr_t rgnbase, rgnend;
> +       phys_addr_t mergebase, mergeend;
> +
> +       rgn_cnt = 0;
> +       idx = i;
> +       /*
> +        * First thing to do is to identify how many regions does
> +        * the requested region overlap.

how many regions the requested region overlaps

> +        * If the flags match, combine all these overlapping
> +        * regions into a single region, and remove the merged
> +        * regions.
> +        */
> +       while (idx < rgn->cnt - 1) {
> +               rgnbase = rgn->region[idx].base;
> +               rgnsize = rgn->region[idx].size;
> +
> +               if (lmb_addrs_overlap(base, size, rgnbase,
> +                                     rgnsize)) {
> +                       if (!lmb_region_flags_match(rgn, idx, flags))
> +                               return -1;
> +                       rgn_cnt++;
> +                       idx++;
> +               }
> +       }
> +
> +       /* The merged region's base and size */
> +       rgnbase = rgn->region[i].base;
> +       mergebase = min(base, rgnbase);
> +       rgnend = rgn->region[idx].base + rgn->region[idx].size;
> +       mergeend = max(rgnend, (base + size));
> +
> +       rgn->region[i].base = mergebase;
> +       rgn->region[i].size = mergeend - mergebase;
> +
> +       /* Now remove the merged regions */
> +       while (--rgn_cnt)
> +               lmb_remove_region(rgn, i + 1);
> +
> +       return 0;
> +}
> +
> +static long lmb_resize_regions(struct lmb_region *rgn, unsigned long i,
> +                              phys_addr_t base, phys_size_t size,
> +                              enum lmb_flags flags)
> +{
> +       long ret = 0;
> +       phys_addr_t rgnend;
> +
> +       if (i == rgn->cnt - 1 ||
> +               base + size < rgn->region[i + 1].base) {
> +               if (!lmb_region_flags_match(rgn, i, flags))
> +                       return -1;
> +
> +               rgnend = rgn->region[i].base + rgn->region[i].size;
> +               rgn->region[i].base = min(base, rgn->region[i].base);
> +               rgnend = max(base + size, rgnend);
> +               rgn->region[i].size = rgnend - rgn->region[i].base;
> +       } else {
> +               ret = lmb_merge_overlap_regions(rgn, i, base, size, flags);
> +       }
> +
> +       return ret;
> +}
> +
>  /* This routine called with relocation disabled. */
>  static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
>                                  phys_size_t size, enum lmb_flags flags)

This could really use a function comment

>  {
>         unsigned long coalesced = 0;
> -       long adjacent, i;
> +       long ret, i;
>
>         if (rgn->cnt == 0) {
>                 rgn->region[0].base = base;
> @@ -260,23 +336,28 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
>                                 return -1; /* regions with new flags */
>                 }
>
> -               adjacent = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> -               if (adjacent > 0) {
> +               ret = lmb_addrs_adjacent(base, size, rgnbase, rgnsize);
> +               if (ret > 0) {
>                         if (flags != rgnflags)
>                                 break;
>                         rgn->region[i].base -= size;
>                         rgn->region[i].size += size;
>                         coalesced++;
>                         break;
> -               } else if (adjacent < 0) {
> +               } else if (ret < 0) {
>                         if (flags != rgnflags)
>                                 break;
>                         rgn->region[i].size += size;
>                         coalesced++;
>                         break;
>                 } else if (lmb_addrs_overlap(base, size, rgnbase, rgnsize)) {
> -                       /* regions overlap */
> -                       return -1;
> +                       ret = lmb_resize_regions(rgn, i, base, size,
> +                                                flags);
> +                       if (ret < 0)
> +                               return -1;
> +
> +                       coalesced++;
> +                       break;
>                 }
>         }
>
> @@ -418,7 +499,7 @@ static phys_addr_t lmb_align_down(phys_addr_t addr, phys_size_t size)
>  }
>

Regards,
Simon
