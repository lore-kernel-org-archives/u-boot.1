Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2CEC27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 23:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 119FF8652A;
	Thu, 24 Aug 2023 01:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XyNkFqaV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2203D86528; Thu, 24 Aug 2023 01:59:23 +0200 (CEST)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2F6C864FF
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 01:59:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-d62bdd1a97dso6045945276.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UleC+hiNJ1j85IsTa3ioT+MM2fgjz70G/qjzKhsYzQY=;
 b=XyNkFqaVDmPPblgPHB72dC8j+OvN3cxVje8IOnL5RVISHn+F2gpnub0y3DuptdNs7K
 VbuPH0/k2RRRapCqL9jw/7yAdKnaiyug764BL+wWFFB1HM3dP1aTbMH1QtAtqo3bG/cd
 FU8jnGatzsHMbyvmJzjSuciXZtDkKMuYfaAFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692835156; x=1693439956;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UleC+hiNJ1j85IsTa3ioT+MM2fgjz70G/qjzKhsYzQY=;
 b=AsjKqEAwlAQ/U7apZYSLffgLhxVJbZUoMVz8wUoUvOSZJ5QHK+rqEwUenCiuOlig7K
 xoqr0NLCoYtqrpeW//b52t5WvSvgwD3b2r06h7Mk+RIYBQ4pEerfjQ7GVbPBESpYPgj6
 YS2eioY5ih53qhurAqHtQduyoe7bb5yK/EJqPzle+lND1DD4W8jw21ckz8xwN7Qx+8pn
 0uZmCPhjnlAnY3xcqzyBSuJrWQVBsJvYOIz1W54L4O2fTumYdk8Ue2vMe+rk7sHaQ+VM
 ryhjC5ZSt9mlHZWlaMbDc1rgc75gAPKyX4CxKySlcRNBSzUmKAaWol19Ad/gisa4SuyP
 XfHA==
X-Gm-Message-State: AOJu0YxepGFU6qM5Wp+KMSJHlCGf6XtbHdeBXFLbq+QYKq7+Wd9QjExS
 xcfABPOAxWNwmQrogCzWDJ3ag+uA1IN1SX/n83L/kA==
X-Google-Smtp-Source: AGHT+IF1EDVyfQuystOGcizpdhVEZYpEZFEDoq42+tY6EWzIm+xs+uNARcY8k0Pjw5cJgl24ONLc0AMT1ULERggb0xo=
X-Received: by 2002:a25:ae1b:0:b0:d71:69ff:ba74 with SMTP id
 a27-20020a25ae1b000000b00d7169ffba74mr13358109ybj.23.1692835156426; Wed, 23
 Aug 2023 16:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230823134209.1450567-1-sjg@chromium.org>
 <20230823134209.1450567-3-sjg@chromium.org>
 <f2cc3d2f-923d-6774-d411-25dace89b6a3@gmx.de>
In-Reply-To: <f2cc3d2f-923d-6774-d411-25dace89b6a3@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 23 Aug 2023 17:57:37 -0600
Message-ID: <CAPnjgZ2k7s2_pcZCW=yT65uZJQBPoPU8wYbN9Ng6dN5ebP0Bmg@mail.gmail.com>
Subject: Re: [PATCH 2/7] lmb: Tidy up structure access
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>, 
 Sjoerd Simons <sjoerd@collabora.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Wed, 23 Aug 2023 at 09:44, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 23.08.23 15:41, Simon Glass wrote:
> > In some cases it helps to define a local variable pointing to the
> > structure being accessed. This avoids lots of repeated code.
> >
> > There is no need to individually assign each struct member, so use a
> > structure assignment instead.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   lib/lmb.c | 54 +++++++++++++++++++++++++-----------------------------
> >   1 file changed, 25 insertions(+), 29 deletions(-)
> >
> > diff --git a/lib/lmb.c b/lib/lmb.c
> > index ae1969893f00..8b9a611c5216 100644
> > --- a/lib/lmb.c
> > +++ b/lib/lmb.c
> > @@ -23,20 +23,19 @@ DECLARE_GLOBAL_DATA_PTR;
> >
> >   static void lmb_dump_region(struct lmb_region *rgn, char *name)
> >   {
> > -     unsigned long long base, size, end;
> > -     enum lmb_flags flags;
> >       int i;
> >
> >       printf(" %s.cnt = 0x%lx / max = 0x%lx\n", name, rgn->cnt, rgn->max);
> >
> >       for (i = 0; i < rgn->cnt; i++) {
> > -             base = rgn->region[i].base;
> > -             size = rgn->region[i].size;
> > -             end = base + size - 1;
> > -             flags = rgn->region[i].flags;
> > +             struct lmb_property *prop = &rgn->region[i];
> > +             unsigned long long end;
> > +
> > +             end = prop->base + prop->size - 1;
> >
> >               printf(" %s[%d]\t[0x%llx-0x%llx], 0x%08llx bytes flags: %x\n",
> > -                    name, i, base, end, size, flags);
> > +                    name, i, (unsigned long long)prop->base, end,
> > +                    (unsigned long long)prop->size, prop->flags);
> >       }
> >   }
> >
> > @@ -89,11 +88,8 @@ static void lmb_remove_region(struct lmb_region *rgn, unsigned long r)
> >   {
> >       unsigned long i;
> >
> > -     for (i = r; i < rgn->cnt - 1; i++) {
> > -             rgn->region[i].base = rgn->region[i + 1].base;
> > -             rgn->region[i].size = rgn->region[i + 1].size;
> > -             rgn->region[i].flags = rgn->region[i + 1].flags;
> > -     }
> > +     for (i = r; i < rgn->cnt - 1; i++)
> > +             rgn->region[i] = rgn->region[i + 1];
> >       rgn->cnt--;
> >   }
> >
> > @@ -122,6 +118,7 @@ void lmb_init(struct lmb *lmb)
> >
> >   void arch_lmb_reserve_generic(struct lmb *lmb, ulong sp, ulong end, ulong align)
> >   {
> > +     struct bd_info *bd = gd->bd;
> >       ulong bank_end;
> >       int bank;
> >
> > @@ -135,12 +132,10 @@ void arch_lmb_reserve_generic(struct lmb *lmb, ulong sp, ulong end, ulong align)
> >       /* adjust sp by 4K to be safe */
> >       sp -= align;
> >       for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> > -             if (!gd->bd->bi_dram[bank].size ||
> > -                 sp < gd->bd->bi_dram[bank].start)
> > +             if (!bd->bi_dram[bank].size || sp < bd->bi_dram[bank].start)
> >                       continue;
> >               /* Watch out for RAM at end of address space! */
> > -             bank_end = gd->bd->bi_dram[bank].start +
> > -                     gd->bd->bi_dram[bank].size - 1;
> > +             bank_end = bd->bi_dram[bank].start + bd->bi_dram[bank].size - 1;
> >               if (sp > bank_end)
> >                       continue;
> >               if (bank_end > end)
> > @@ -244,9 +239,11 @@ static long lmb_add_region_flags(struct lmb_region *rgn, phys_addr_t base,
> >
> >       /* First try and coalesce this LMB with another. */
> >       for (i = 0; i < rgn->cnt; i++) {
> > -             phys_addr_t rgnbase = rgn->region[i].base;
> > -             phys_size_t rgnsize = rgn->region[i].size;
> > -             phys_size_t rgnflags = rgn->region[i].flags;
> > +             struct lmb_property *prop = &rgn->region[i];
>
> Why call a region prop? Can't we call it "region" or "rgn_ptr" or if you
> want to allude to the position in the array "pos"? This would avoid
> confusion.

We always have rgn so that would be hopelessly confusing.

I am using prop just because that is the struct name.

I did not invent the confusion:

struct lmb_region {
   unsigned long cnt;
   unsigned long max;
   struct lmb_property region[CONFIG_LMB_MAX_REGIONS];
};

There is a region within a region, and also:

struct lmb {
   struct lmb_region memory;
   struct lmb_region reserved;
   struct lmb_property memory_regions[CONFIG_LMB_MEMORY_REGIONS];
   struct lmb_property reserved_regions[CONFIG_LMB_RESERVED_REGIONS];
};

I did consider trying to rename one of them...but 'region' is used
extensively in the C code to mean the inner region. We could perhaps
rename the outer 'region' to an 'area'?

Regards,
Simon
