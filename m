Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA9BC3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 16:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D65A9880D8;
	Thu,  1 Aug 2024 18:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qnfFkdX0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9597B886DF; Thu,  1 Aug 2024 18:19:34 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 806D78641A
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 18:19:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-595856e2336so3816448a12.1
 for <u-boot@lists.denx.de>; Thu, 01 Aug 2024 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722529172; x=1723133972; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TRJ0YQr+JVGSQfukWaH//CVnYxSGR7N6wGkCnxJRzUQ=;
 b=qnfFkdX0A3hp8gYjMY/so6x82vTPAq5ltekzG7ULzpw+OqdGgXguPo8pfeUj5bubrj
 CWmfDBCF0uER+73ZfigzdPWrCQv6B1MUrh8GQ0AKY4h0Z8y8GcmYQMy/77eaXxFXYoMQ
 5CCmSMVHE0rnbsSezvP4jwvO92blQYu8NBeXagsiv3RZ9VcEMLaY1JAWTYEkQy1tJaRs
 HA+t+FPhlJCnylOLuWyOSVxJI+xdKrONNgGq/69nIOj8ses7HFSVOM9c70kB7YZfDjAh
 +B1kcjNjtZwsfbchYkyH54VLC1MQTn4rpjieyL6SzM7ZjiAnVbzlsZiBGJRNpSVsNNG+
 BtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722529172; x=1723133972;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRJ0YQr+JVGSQfukWaH//CVnYxSGR7N6wGkCnxJRzUQ=;
 b=KnBA7D+9sp12bCV49uBO3RuAGMq4m5TThvPLz5dS3J/EzSByEwC76p+aDqnMQUKSuk
 AnAOSWDjK5s2E7nsj4E3oAvqp/aoyCCQJLlfmNNDQLX6ENKuCmycKYw/ZCN03WKKXFWy
 8SnsCHjlLAABH3grok7Gd0C1s4vxG25cR197kmR7GpjuV0UmbXXfVI0Av/VH53/rh+xk
 nsIXAwrH54O8PQY2i9RkwVkSbuVgLFfgF1eBIc09ZOtEVRkUYU/y/GSu3hbhcCAtcfeA
 9RzyUUoDU/OVl7ZvMNNfBDnRb+SmbqvVjVl7j1KDN0Jb+ou1MiqLx6RKUxI+mREipgBf
 w5+Q==
X-Gm-Message-State: AOJu0YwMQ2OTd0jBC32/oUMqHk/bPaAoUu1fTOs1uDPAUUfMcXZFJnXd
 L7VmcSyoeRhwVdNU/F4gV4FJMOExNLZieaG1YilcHCWogLMI+6tbHU8EzQ1gqoZ8VTxEydsOoAs
 pK3ISPvAFCKl5nhJpJ1RtshPByE9thfaE6XWgY5qu4PRhd3/sxtQ=
X-Google-Smtp-Source: AGHT+IEyEph4AO5TchMThtkB8RPvxjVF7gpPF0WOnTutTerLAQPYDwh7hzd/CFiwKlTRsf0lrVhvvuHqkWFIQom3RV8=
X-Received: by 2002:a05:6402:34c9:b0:584:21eb:7688 with SMTP id
 4fb4d7f45d1cf-5b77da8ea08mr1607740a12.14.1722529171795; Thu, 01 Aug 2024
 09:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240730144035.3992996-1-sjg@chromium.org>
 <20240730144035.3992996-3-sjg@chromium.org>
 <CADg8p94BuoZzqhjE8eioS8TOHP=iyEK6LkBsTys78hLTf54x_g@mail.gmail.com>
 <CAFLszTgOPQouuUB2mPL2z-S=3=swuah9uppJu1vtFzLS4RE1wQ@mail.gmail.com>
In-Reply-To: <CAFLszTgOPQouuUB2mPL2z-S=3=swuah9uppJu1vtFzLS4RE1wQ@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Thu, 1 Aug 2024 21:49:20 +0530
Message-ID: <CADg8p96G==TRZkwN5axp9pjZR9AQeDPhD9aYaffvcJAbKUhNWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] lmb: Tighten up the code in lmb_add_region_flags()
To: Simon Glass <sjg@chromium.org>
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

On Thu, 1 Aug 2024 at 21:42, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Thu, 1 Aug 2024 at 08:58, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > On Tue, 30 Jul 2024 at 20:10, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > This function has more special cases than it needs. Simplify it to
> > > reduce code size and complexity.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >  lib/lmb.c | 57 +++++++++++++++++++------------------------------------
> > >  1 file changed, 19 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/lib/lmb.c b/lib/lmb.c
> > > index c11ce308c5b..83b060a2f4d 100644
> > > --- a/lib/lmb.c
> > > +++ b/lib/lmb.c
> > > @@ -396,14 +396,6 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
> > >         if (alist_err(lmb_rgn_lst))
> > >                 return -1;
> > >
> > > -       if (alist_empty(lmb_rgn_lst)) {
> > > -               rgn[0].base = base;
> > > -               rgn[0].size = size;
> > > -               rgn[0].flags = flags;
> > > -               lmb_rgn_lst->count = 1;
> > > -               return 0;
> > > -       }
> > > -
> > >         /* First try and coalesce this LMB with another. */
> > >         for (i = 0; i < lmb_rgn_lst->count; i++) {
> > >                 phys_addr_t rgnbase = rgn[i].base;
> > > @@ -448,50 +440,39 @@ static long lmb_add_region_flags(struct alist *lmb_rgn_lst, phys_addr_t base,
> > >                 }
> > >         }
> > >
> > > -       if (i < lmb_rgn_lst->count - 1 &&
> > > -           rgn[i].flags == rgn[i + 1].flags) {
> > > -               if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
> > > -                       lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
> > > -                       coalesced++;
> > > -               } else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
> > > -                       /* fix overlapping area */
> > > -                       lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
> > > -                       coalesced++;
> > > +       if (lmb_rgn_lst->count && i < lmb_rgn_lst->count - 1) {
> > > +               rgn = lmb_rgn_lst->data;
> > > +               if (rgn[i].flags == rgn[i + 1].flags) {
> > > +                       if (lmb_regions_adjacent(lmb_rgn_lst, i, i + 1)) {
> > > +                               lmb_coalesce_regions(lmb_rgn_lst, i, i + 1);
> > > +                               coalesced++;
> > > +                       } else if (lmb_regions_overlap(lmb_rgn_lst, i, i + 1)) {
> > > +                               /* fix overlapping area */
> > > +                               lmb_fix_over_lap_regions(lmb_rgn_lst, i, i + 1);
> > > +                               coalesced++;
> > > +                       }
> > >                 }
> > >         }
> > >
> > >         if (coalesced)
> > >                 return coalesced;
> > >
> > > -       if (alist_full(lmb_rgn_lst)) {
> > > -               if (!alist_expand_by(lmb_rgn_lst, lmb_rgn_lst->alloc * 2))
> > > -                       return -1;
> > > -               else
> > > -                       rgn = lmb_rgn_lst->data;
> > > -       }
> > > +       if (!alist_add_placeholder(lmb_rgn_lst))
> > > +               return -1;
> > > +       rgn = lmb_rgn_lst->data;
> >
> > I think the above should have a check for alist_full(), and then add
> > to the list if full. Else we simply go on adding to the list on every
> > new node that gets added.
>
> At this point in the function, we know that we are adding a new entry.
> We could have an anlist_insert() perhaps?
>
> >
> > >
> > >         /* Couldn't coalesce the LMB, so add it to the sorted table. */
> > >         for (i = lmb_rgn_lst->count - 1; i >= 0; i--) {
> > > -               if (base < rgn[i].base) {
> > > -                       rgn[i + 1].base = rgn[i].base;
> > > -                       rgn[i + 1].size = rgn[i].size;
> > > -                       rgn[i + 1].flags = rgn[i].flags;
> > > +               if (i && base < rgn[i - 1].base) {
> > > +                       rgn[i] = rgn[i - 1];
> > >                 } else {
> > > -                       rgn[i + 1].base = base;
> > > -                       rgn[i + 1].size = size;
> > > -                       rgn[i + 1].flags = flags;
> > > +                       rgn[i].base = base;
> > > +                       rgn[i].size = size;
> > > +                       rgn[i].flags = flags;
> > >                         break;
> > >                 }
> > >         }
> >
> > With the logic that you put above, should the loop not have 'i'
> > initialised to lmb_rgn_lst-count? I mean
> >
> > for (i = lmb_rgn_lst->count; i >= 0; i--)
> >
> > Else we are overwriting one region?
>
> It starts by doing the assignment rgn[count - 1 + 1] = rgn[count - 1],
> which I believe is correct?

That was the earlier logic, but now this is being replaced by

 +               if (i && base < rgn[i - 1].base) {
 +                       rgn[i] = rgn[i - 1];

Which means 'i' should be initialised to lmb_rgn_cnt->count? If you
see the patch, the for loop initialisation is not being changed.

-sughosh

>
> > >
> > > -       if (base < rgn[0].base) {
> > > -               rgn[0].base = base;
> > > -               rgn[0].size = size;
> > > -               rgn[0].flags = flags;
> > > -       }
> > > -
> > > -       lmb_rgn_lst->count++;
> > > -
> > >         return 0;
> > >  }
> > >
> > > --
> > > 2.34.1
> > >
>
> Regards,
> SImon
