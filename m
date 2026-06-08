Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57DACD8C9F
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 13:01:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E2283EEF;
	Mon,  8 Jun 2026 15:00:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vl/hs8vs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09F5383FEC; Mon,  8 Jun 2026 15:00:59 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3237807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 15:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-691b0090cc5so2233851a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 06:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780923656; cv=none;
 d=google.com; s=arc-20240605;
 b=K+QbObCRFLBwVNLG+3rg5lrrcDoEriVLZbDejhLauaUWPbcKBzzBCP7RnLsU0K+5yG
 oKTlddaAor2rytqrUyR+lUVNB+MxR4N+2K8bRIe6quvVho/OgVfY0LZyKmTV9rWU+wZO
 51jApbsPHGzyG9cqUqmAjYPmbNTTaGFhuEaqnNpqVqeP/o721bri1Z06lgFyh/F7+LpO
 8Xc7Hg0zXr03DDg+nGnKEYUGUFXuRVyVGOXBwyDhQIAyuon2vncAkB4JOKFEzWXkOra+
 eNTtiQ6v1TU/zROX2MYDuFsUc9akT5lbkqlwVcaURfrMVa4y7QBf0YTQHgE9FctbIjGw
 P+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zk4ed1J+sxw2UMLadCab4Sn18/eN8W7Q80/99iK6HPA=;
 fh=qdv8+U2aCYT3icxqhtqZLncjjq3U5GyL9Y6lZeudrHY=;
 b=Hpzdy+vTWDCDDeh4i98JXsclyahl76Sh5TAtAt2+75bPQ8WDN2yAob1OxWMr2UmdGi
 XhMPgg+c9bpb8wZ0TVDpuV3Jmmjg/MD04QruK1bcqodxW/SgR9yRft6hc7Yd4dgkf/s5
 Z9eZgWNhi95vfvE45INFmf+rbiqkusVpdfLMVlPEUhwAadQm0kUUY8lLXKw8ruaU9t2H
 fdaLMUo0jhMF73X0PpWo+YKFp77PGlFZoAlKkL3XWVIuksxoxP4DcPGJDJQALu332jdW
 HwDpLd9n1ESnjuKWvBTWHSXWlj//xjEjlOBxeoNpEfVYnbmiuJ0ZoVhXPC6DQpNdsZWg
 6ITA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780923656; x=1781528456; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zk4ed1J+sxw2UMLadCab4Sn18/eN8W7Q80/99iK6HPA=;
 b=Vl/hs8vs9/TSkvvbQ7mbKFa3sLj6FcxYUHmH4a9wdABS1VVzFcUNWZ3vmP+imSBx5L
 3WlGGpeAYyRlfh29e+hGKx0X2lqI3aU3daGWeNnrLGUr9JDnXAZMKFhlwBJM6BiqNeHD
 +JdflNeK3o7OupDEnbaoEIt/wtqb5OwNiMk6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780923656; x=1781528456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zk4ed1J+sxw2UMLadCab4Sn18/eN8W7Q80/99iK6HPA=;
 b=OhU/LShgtZs5Q+w8Z2LdwXJpfmIY9VVi3XMerbQZ19X+x5Vr1hxBrWkhdanoocPIfa
 cuaWrNAvd1ry/AqaahLKGcBlU4txt4GbVTy3mgGpEXlU8ukOD7ExRq56uWrY7yo9PHlu
 rEv58c+vjOok4UiPYKzuiDM10sNVbYg4J01WkM+2mQUZCPSEToCtp1IGCYOIyzs8YUcZ
 BLvbl5EaEmalGkwfdqu2nCjEzADV4+lUbN+B2e8j8wA0ieWNIa1oVRnSHnaL3pgQ1zrf
 EcQR4AmL0t9mVR/0GEJzeZufKGalObDSwE7JJjf2lGjWWSdx+IyVDXLyFh4mNl9D1TPH
 UkSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FbIkBiaegtoKX1Qk4uc2vt0JHm1dJahVDj3hZJ0bCf5AjT7iduKQ+GpqAsrZBQLB/UjYDUmY=@lists.denx.de
X-Gm-Message-State: AOJu0YxW4mAXENrVFZc3MfxsgkTj7TzdjcRm8+2CLqJQ76Xm1tyiAeDr
 OFm08s5gWLUcianAvkeME4t6PU48phgpIZQydYu7DJfEd8AMOx+pA+MzN8gd9W3v8KH58tkAc5p
 sEJp6vTBEt8qn4sIW16EUjDmAyG0Cl0UmfkOmGsb9
X-Gm-Gg: Acq92OGG2A2eOFYRUNaFzhVw+qgn/vwZ3sX9AyVeat6cHn4DuR+f3fnjDxYkexkSsGq
 PaxzI6Hm1JybHYbDrPjPtWrPKO7Da9lGLph/9DfuZSFUdXu4hBu5bj7+ls6LT21lAl1BRh7BUGD
 2TRLn86vjiIarnTZuPYIR8A5r73rTp2QYyeJQPbnK0UcIXMsKXTyPX458prpwydKTwt/u1lWWgG
 01N8U6+7l08F7QbtAHIgxvBCH+aJPQoqFuMY2jSOb8I1GJZl6/72Im2SyQcP898UBX45lFGoCa6
 zu2dmCQAxbV7MolJ
X-Received: by 2002:a05:6402:3484:b0:691:ad86:ac51 with SMTP id
 4fb4d7f45d1cf-691ad86c033mr3125950a12.20.1780923656373; Mon, 08 Jun 2026
 06:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-6-ilias.apalodimas@linaro.org>
 <CAFLszThLAkMcDnMurD639y_Cck-n4DkW7VOC+Xzy+k+Xk_ryzw@mail.gmail.com>
 <CAC_iWjLcLMvjsjJujKSQ=GKvKZb+axQj6-1Ptc9UffBLxic6cQ@mail.gmail.com>
In-Reply-To: <CAC_iWjLcLMvjsjJujKSQ=GKvKZb+axQj6-1Ptc9UffBLxic6cQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 8 Jun 2026 07:00:44 -0600
X-Gm-Features: AVVi8CeISzoqUfi7-TDGVtUtbyAyeCgdsxoxurtKsXdhc3sPMuwUxiTR7wfQjUo
Message-ID: <CAFLszThSSU=AVafR7vWeSJ_HocefaORM_Rwd_49W0TobMAVaqw@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] common: Add an option to relocate on ram top
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, u-boot@lists.denx.de
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

Hi Ilias,

On Mon, 8 Jun 2026 at 01:44, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> [...]
>
> >
> > I'm just a bit concerned about what this changes...see below.
> >
> > > diff --git a/common/board_f.c b/common/board_f.c
> > > @@ -339,7 +344,24 @@ static int setup_ram_base(void)
> > >  static int setup_ram_config(void)
> > >  {
> > >       debug("Monitor len: %08x\n", gd->mon_len);
> > > -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> > > +
> > > +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> > > +             int i;
> > > +             phys_addr_t top;
> > > +
> > > +             gd->ram_size =3D 0;
> > > +             for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> > > +                     top =3D get_mem_top(gd->dram[i].start, gd->dram=
[i].size,
> > > +                                       ALIGN(gd->mon_len, SZ_1M),
> > > +                                       (void *)gd->fdt_blob);
> > > +                     gd->ram_top =3D max(top, gd->ram_top);
> > > +                     gd->ram_size +=3D gd->dram[i].size;
> > > +             }
> > > +             gd->ram_top =3D board_get_usable_ram_top(gd->ram_size);
> > > +     } else {
> > > +             gd->ram_top =3D gd->ram_base + get_effective_memsize();
> > > +             gd->ram_top =3D board_get_usable_ram_top(gd->mon_len);
> > > +     }
> > >       /*
> > >        * Subtract specified amount of memory to hide so that it won't
> > >        * get 'touched' at all by U-Boot. By fixing up gd->ram_size
> > > @@ -350,10 +372,9 @@ static int setup_ram_config(void)
> > >        * memory size from the SDRAM controller setup will have to
> > >        * get fixed.
> > >        */
> > > +#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> > >       gd->ram_size -=3D CONFIG_SYS_MEM_TOP_HIDE;
> > >  #endif
> > > -     gd->ram_top =3D gd->ram_base + get_effective_memsize();
> > > -     gd->ram_top =3D board_get_usable_ram_top(gd->mon_len);
> >
> > This reorders SYS_MEM_TOP_HIDE relative to the ram_top calculation in
> > the non-RELOC_ADDR_TOP path. Previously gd->ram_size was reduced first
> > and get_effective_memsize() (which reads gd->ram_size) then yielded a
> > ram_top below the hidden region.
> >
> > After this patch ram_top is computed from the full size and the
> > subtraction happens afterwards, so ram_top (and hence relocaddr) now
> > lands inside the region SYS_MEM_TOP_HIDE is meant to keep U-Boot out
> > of
> >
> > Quite a few defconfigs still set CONFIG_SYS_MEM_TOP_HIDE (e.g. odroid)
> > and look like they would regress here. Please keep the old ordering
> > for the else branch, or do the subtraction up front and feed the
> > reduced size to both branches.
>
> Yea that's true, however how that's used is weird because
> get_effective_memsize() is board specific and it doesn't always use
> ram_size.
> So perhaps we should deduct the same value from ram_top and keep the
> call last ? That way we can keep the functionality for both cases.

That makes sense to me, yes. It seems more in keeping with
board-specific functions. This is likely another area to clean up one
day...

>
> >
> > > diff --git a/common/board_f.c b/common/board_f.c
> > > @@ -339,7 +344,24 @@ static int setup_ram_base(void)
> > > +             gd->ram_top =3D board_get_usable_ram_top(gd->ram_size);
> > > +     } else {
> > > +             gd->ram_top =3D gd->ram_base + get_effective_memsize();
> > > +             gd->ram_top =3D board_get_usable_ram_top(gd->mon_len);
> > > +     }
> >
> > The total_size argument to board_get_usable_ram_top() has always been
> > gd->mon_len in tree =E2=80=94 that is what the ~40 board overrides expe=
ct
> > (they typically use it as the minimum headroom needed for the
> > relocated monitor). Passing gd->ram_size in the RELOC_ADDR_TOP path
> > silently changes the contract for any board that both overrides
> > board_get_usable_ram_top() and turns the new option on. I'd keep
> > mon_len here, or rename the parameter and check callers if this is
> > intended.
>
> That's another unclear option to me, since this function is also board
> specific. What I can do though since this is largely untested, is move
> the board_get_usable_ram_top() out of the if statements and call it
> with mon_len. In the future we can look at all the callsites and
> decide what's needed eventually.

Yes that seem safer.

>
> >
> > > diff --git a/common/board_f.c b/common/board_f.c
> > > @@ -339,7 +344,24 @@ static int setup_ram_base(void)
> > > +                     top =3D get_mem_top(gd->dram[i].start, gd->dram=
[i].size,
> > > +                                       ALIGN(gd->mon_len, SZ_1M),
> > > +                                       (void *)gd->fdt_blob);
> >
> > Perhaps a follow-up but we should be able to avoid the cast by making
> > the fdt argument const.
>
> Yea, but let's focus on the adding the functionality for now. There's
> a lot of cleanups that we can do once this is applied

Indeed!

Regards,
Simon
