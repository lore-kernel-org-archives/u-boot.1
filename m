Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6EBC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 16:12:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD7688646;
	Thu,  1 Aug 2024 18:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i2s+G65q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DAB988667; Thu,  1 Aug 2024 18:12:43 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01A808862F
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 18:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-70968db52d0so1481973a34.3
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722528760; x=1723133560; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BLxMrj0D1ihTq/qG5/7efSOUlc2SpI4axMu/r4gy0UI=;
 b=i2s+G65qCSatsLcyF7Lz+rQa5wdV+iExO2PpbWDSkf7jBPMaDw9VtjR2zuMz4u10Pl
 /hq/ObJy3OPgvT4Mk+Kat1Kgbqo/FWW9FONZ5a/lV4YfW2C3ITMd4wwy365gkrkjqy1Z
 PAPUE6bGsLuJnJ+kA/YofucJPFvdkc39BH8jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722528760; x=1723133560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BLxMrj0D1ihTq/qG5/7efSOUlc2SpI4axMu/r4gy0UI=;
 b=wbPDy3MLFLUjaX1zSQ1jsYpYDP27MALRrKHkyCjilCaOUdzbR4ol0uwzf6/NCZAmL+
 jRsln8QD4aK2AVWFJOWIm+y8z+mK83LkYiaUslAqzkmdW9gAwHINYcFVfIhr6psF3wr1
 nuu0ROPptOVRZgV33Xfpa1U2hy8lNcuvSv07FqP4K7GciBoyzg11sFvT3CE+YsYnUml6
 Zjj7GMF1DAQL00d9ilDbdW8PNerN1TIaZHmWH5EUBFNCLa661LpzpLYSs+3ZzVD3lNlv
 qZwIZzraHq7UvnDoTK1HtwRFGDJGB+udl5kL3+RHJPgsjo3tMSMOsWsISF6vFwYRb++Z
 8SNQ==
X-Gm-Message-State: AOJu0YzB79aLdEkIbIPEm869i9YP1cYvs/2H5zUXGsw0t5Xrf+SB/OvV
 qaHUIDl1l2fWNCe5xjuifDd/+2SXohKiYAxu+fj2rDHfzmzQ4CjeReP9VCLcPJmuFnC3v2BSxH+
 T4Taf1h/sVYqfk1Oaq1eq6vqBw5pm/BTpE2LK
X-Google-Smtp-Source: AGHT+IGsFL6ZSNe8AgN4cv496QDRvZYEa4Kw/JFDDALVrrr4C1DYaNxOKai4Nl2rgkmfPfgIwNPGIyDuatC8CG/CoeM=
X-Received: by 2002:a05:6830:2656:b0:703:6845:ed89 with SMTP id
 46e09a7af769-709ad85200bmr865904a34.5.1722528759723; Thu, 01 Aug 2024
 09:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240730144035.3992996-1-sjg@chromium.org>
 <20240730144035.3992996-3-sjg@chromium.org>
 <CADg8p94BuoZzqhjE8eioS8TOHP=iyEK6LkBsTys78hLTf54x_g@mail.gmail.com>
In-Reply-To: <CADg8p94BuoZzqhjE8eioS8TOHP=iyEK6LkBsTys78hLTf54x_g@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 10:12:28 -0600
Message-ID: <CAFLszTgOPQouuUB2mPL2z-S=3=swuah9uppJu1vtFzLS4RE1wQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] lmb: Tighten up the code in lmb_add_region_flags()
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Thu, 1 Aug 2024 at 08:58, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Tue, 30 Jul 2024 at 20:10, Simon Glass <sjg@chromium.org> wrote:
> >
> > This function has more special cases than it needs. Simplify it to
> > reduce code size and complexity.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  lib/lmb.c | 57 +++++++++++++++++++------------------------------------
> >  1 file changed, 19 insertions(+), 38 deletions(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index c11ce308c5b..83b060a2f4d 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -396,14 +396,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
> >         if (alist_err(lmb_rgn_lst))
> >                 return -1;
> >
> > -       if (alist_empty(lmb_rgn_lst)) {
> > -               rgn[0].base = base;
> > -               rgn[0].size = size;
> > -               rgn[0].flags = flags;
> > -               lmb_rgn_lst->count = 1;
> > -               return 0;
> > -       }
> > -
> >         /* First try and coalesce this LMB with another. */
> >         for (i = 0; i < lmb_rgn_lst->count; i++) {
> >                 phys_addr_t rgnbase = rgn[i].base;
> > @@ -448,50 +440,39 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
> >                 }
> >         }
> >
> > -       if (i < lmb_rgn_lst->count - 1 &&
> > -           rgn[i].flags == rgn[i + 1].flags) {
> > -               if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
> > -                       lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
> > -                       coalesced++;
> > -               } else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
> > -                       /* fix overlapping area */
> > -                       lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
> > -                       coalesced++;
> > +       if (lmb_rgn_lst->count && i < lmb_rgn_lst->count - 1) {
> > +               rgn = lmb_rgn_lst->data;
> > +               if (rgn[i].flags == rgn[i + 1].flags) {
> > +                       if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
> > +                               lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
> > +                               coalesced++;
> > +                       } else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
> > +                               /* fix overlapping area */
> > +                               lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
> > +                               coalesced++;
> > +                       }
> >                 }
> >         }
> >
> >         if (coalesced)
> >                 return coalesced;
> >
> > -       if (alist_full(lmb_rgn_lst)) {
> > -               if (!alist_expand_by(lmb_rgn_lst, lmb_rgn_lst->alloc * 2))
> > -                       return -1;
> > -               else
> > -                       rgn = lmb_rgn_lst->data;
> > -       }
> > +       if (!alist_add_placeholder(lmb_rgn_lst))
> > +               return -1;
> > +       rgn = lmb_rgn_lst->data;
>
> I think the above should have a check for alist_full(), and then add
> to the list if full. Else we simply go on adding to the list on every
> new node that gets added.

At this point in the function, we know that we are adding a new entry.
We could have an anlist_insert() perhaps?

>
> >
> >         /* Couldn't coalesce the LMB, so add it to the sorted table. */
> >         for (i = lmb_rgn_lst->count - 1; i >= 0; i--) {
> > -               if (base < rgn[i].base) {
> > -                       rgn[i + 1].base = rgn[i].base;
> > -                       rgn[i + 1].size = rgn[i].size;
> > -                       rgn[i + 1].flags = rgn[i].flags;
> > +               if (i && base < rgn[i - 1].base) {
> > +                       rgn[i] = rgn[i - 1];
> >                 } else {
> > -                       rgn[i + 1].base = base;
> > -                       rgn[i + 1].size = size;
> > -                       rgn[i + 1].flags = flags;
> > +                       rgn[i].base = base;
> > +                       rgn[i].size = size;
> > +                       rgn[i].flags = flags;
> >                         break;
> >                 }
> >         }
>
> With the logic that you put above, should the loop not have 'i'
> initialised to lmb_rgn_lst-count? I mean
>
> for (i = lmb_rgn_lst->count; i >= 0; i--)
>
> Else we are overwriting one region?

It starts by doing the assignment rgn[count - 1 + 1] = rgn[count - 1],
which I believe is correct?

> >
> > -       if (base < rgn[0].base) {
> > -               rgn[0].base = base;
> > -               rgn[0].size = size;
> > -               rgn[0].flags = flags;
> > -       }
> > -
> > -       lmb_rgn_lst->count++;
> > -
> >         return 0;
> >  }
> >
> > --
> > 2.34.1
> >

Regards,
SImon
