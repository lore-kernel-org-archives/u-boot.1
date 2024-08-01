Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4F8C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 17:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04D7D889D2;
	Thu,  1 Aug 2024 19:45:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cit7ka2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D50A88B33; Thu,  1 Aug 2024 19:45:12 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5849888297
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 19:45:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a20c529c77so150296485a.1
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 10:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722534309; x=1723139109; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=h2yUkieIvWUOicBEBF6knA1wCJfqbyXV1gfBJYt5Aww=;
 b=Cit7ka2gYbRCbrx9pzZAGBCt+BRIwl5jPTD8nDKTLh8JoyPrEMpzRqYduU0GOI7uD3
 JkLtJam4XqpSIvBcKyuxwM3gbeKP2d3bllwkiRZUPGqLJGfEvujD+M8i/Y5feCl/24uc
 pmcbo9CkI70CJOYh97PFzH4UuS8RxWzl9s2Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722534309; x=1723139109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h2yUkieIvWUOicBEBF6knA1wCJfqbyXV1gfBJYt5Aww=;
 b=OoGTprdDg+EEX3ka5dtf7Rx6CkMPTL5n72JykbL4gXt2DPWhhOAIQM9krAMH8cm6hM
 MADe7GB1UVNm0cdc5UpSt2bzPbuYRENAcfVh/XBrD3Btkp7AWQcRElOyqk9u0QPbF4mf
 du6cVdFb01C0heDWMbg92yA4c4mUP5Q/lrVa5wkmiOJwgRXwfTOZpXsdY+zgXSGF7XFV
 zr5KJtst2RMMRk/JOqsF05o4m/OEE0dkMDTE3dgVWddQYoZgYx/9DMzmp5PkD4azaCZk
 wKyrxF/5tC6H+fYV9PUwDzIho/55e4HDPTcKqfkqwy3aQqDPbVdMezoSM7MTK5b8BIVw
 LjDg==
X-Gm-Message-State: AOJu0YwYnZqAP+B4VwJndm2EGkJSp8P2XYb85NlEm1PTV1SVqet+kSlL
 EBrbRxiofIwDZi0z4datLFqXBGRsaF68XpbCu6duWY5hp4oEpL5g9hyAOB8HJtRvdHdr9L9stJh
 TaTziBpjGr8QKjcR/KRHvnkH1WphBuaJxQ1yYJ73juY9Ys3M=
X-Google-Smtp-Source: AGHT+IESEWU7uKGJUGpdvpmeUI8UyW+qyVZ0UPEOPS1ODoA4vcCb5UBIXWC24Dlk92/YU6ofUMC3oAZda44dJTMSffc=
X-Received: by 2002:a05:6214:5b05:b0:6b5:17a2:887c with SMTP id
 6a1803df08f44-6bb98379afamr13738636d6.10.1722534309010; Thu, 01 Aug 2024
 10:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240730144035.3992996-1-sjg@chromium.org>
 <20240730144035.3992996-3-sjg@chromium.org>
 <CADg8p94BuoZzqhjE8eioS8TOHP=iyEK6LkBsTys78hLTf54x_g@mail.gmail.com>
 <CAFLszTgOPQouuUB2mPL2z-S=3=swuah9uppJu1vtFzLS4RE1wQ@mail.gmail.com>
 <CADg8p96G==TRZkwN5axp9pjZR9AQeDPhD9aYaffvcJAbKUhNWQ@mail.gmail.com>
In-Reply-To: <CADg8p96G==TRZkwN5axp9pjZR9AQeDPhD9aYaffvcJAbKUhNWQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 1 Aug 2024 11:44:58 -0600
Message-ID: <CAFLszTg-T6LQpfd=WDs-P9WtF+zhFtvLBE-6pXtsYZ0VmDNh3w@mail.gmail.com>
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

On Thu, 1 Aug 2024 at 10:19, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Thu, 1 Aug 2024 at 21:42, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Thu, 1 Aug 2024 at 08:58, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > On Tue, 30 Jul 2024 at 20:10, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > This function has more special cases than it needs. Simplify it to
> > > > reduce code size and complexity.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > >  lib/lmb.c | 57 +++++++++++++++++++------------------------------------
> > > >  1 file changed, 19 insertions(+), 38 deletions(-)
> > > >
> > > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > > index c11ce308c5b..83b060a2f4d 100644
> > > > --- a/lib/lmb.c
> > > > +++ b/lib/lmb.c
> > > > @@ -396,14 +396,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
> > > >         if (alist_err(lmb_rgn_lst))
> > > >                 return -1;
> > > >
> > > > -       if (alist_empty(lmb_rgn_lst)) {
> > > > -               rgn[0].base = base;
> > > > -               rgn[0].size = size;
> > > > -               rgn[0].flags = flags;
> > > > -               lmb_rgn_lst->count = 1;
> > > > -               return 0;
> > > > -       }
> > > > -
> > > >         /* First try and coalesce this LMB with another. */
> > > >         for (i = 0; i < lmb_rgn_lst->count; i++) {
> > > >                 phys_addr_t rgnbase = rgn[i].base;
> > > > @@ -448,50 +440,39 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
> > > >                 }
> > > >         }
> > > >
> > > > -       if (i < lmb_rgn_lst->count - 1 &&
> > > > -           rgn[i].flags == rgn[i + 1].flags) {
> > > > -               if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
> > > > -                       lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
> > > > -                       coalesced++;
> > > > -               } else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
> > > > -                       /* fix overlapping area */
> > > > -                       lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
> > > > -                       coalesced++;
> > > > +       if (lmb_rgn_lst->count && i < lmb_rgn_lst->count - 1) {
> > > > +               rgn = lmb_rgn_lst->data;
> > > > +               if (rgn[i].flags == rgn[i + 1].flags) {
> > > > +                       if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
> > > > +                               lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
> > > > +                               coalesced++;
> > > > +                       } else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
> > > > +                               /* fix overlapping area */
> > > > +                               lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
> > > > +                               coalesced++;
> > > > +                       }
> > > >                 }
> > > >         }
> > > >
> > > >         if (coalesced)
> > > >                 return coalesced;
> > > >
> > > > -       if (alist_full(lmb_rgn_lst)) {
> > > > -               if (!alist_expand_by(lmb_rgn_lst, lmb_rgn_lst->alloc * 2))
> > > > -                       return -1;
> > > > -               else
> > > > -                       rgn = lmb_rgn_lst->data;
> > > > -       }
> > > > +       if (!alist_add_placeholder(lmb_rgn_lst))
> > > > +               return -1;
> > > > +       rgn = lmb_rgn_lst->data;
> > >
> > > I think the above should have a check for alist_full(), and then add
> > > to the list if full. Else we simply go on adding to the list on every
> > > new node that gets added.
> >
> > At this point in the function, we know that we are adding a new entry.
> > We could have an anlist_insert() perhaps?
> >
> > >
> > > >
> > > >         /* Couldn't coalesce the LMB, so add it to the sorted table. */
> > > >         for (i = lmb_rgn_lst->count - 1; i >= 0; i--) {
> > > > -               if (base < rgn[i].base) {
> > > > -                       rgn[i + 1].base = rgn[i].base;
> > > > -                       rgn[i + 1].size = rgn[i].size;
> > > > -                       rgn[i + 1].flags = rgn[i].flags;
> > > > +               if (i && base < rgn[i - 1].base) {
> > > > +                       rgn[i] = rgn[i - 1];
> > > >                 } else {
> > > > -                       rgn[i + 1].base = base;
> > > > -                       rgn[i + 1].size = size;
> > > > -                       rgn[i + 1].flags = flags;
> > > > +                       rgn[i].base = base;
> > > > +                       rgn[i].size = size;
> > > > +                       rgn[i].flags = flags;
> > > >                         break;
> > > >                 }
> > > >         }
> > >
> > > With the logic that you put above, should the loop not have 'i'
> > > initialised to lmb_rgn_lst-count? I mean
> > >
> > > for (i = lmb_rgn_lst->count; i >= 0; i--)
> > >
> > > Else we are overwriting one region?
> >
> > It starts by doing the assignment rgn[count - 1 + 1] = rgn[count - 1],
> > which I believe is correct?
>
> That was the earlier logic, but now this is being replaced by
>
>  +               if (i && base < rgn[i - 1].base) {
>  +                       rgn[i] = rgn[i - 1];
>
> Which means 'i' should be initialised to lmb_rgn_cnt->count? If you
> see the patch, the for loop initialisation is not being changed.

OK, well I'll let you sort that out :-)

Regards,
Simon
