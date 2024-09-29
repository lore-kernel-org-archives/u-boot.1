Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DF9CF6499
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 11:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 033EB8891B;
	Sun, 29 Sep 2024 13:47:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Key25yoX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4220C88970; Sun, 29 Sep 2024 13:47:56 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CBC588770
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 13:47:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cb2f271043so38482556d6.0
 for <u-boot@lists.denx.de>; Sun, 29 Sep 2024 04:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727610473; x=1728215273; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=X/7KDbAoQF1k6zQZO9a9JEZT2AT9KGNImx73cX6Oop4=;
 b=Key25yoXj01GFEg+USDoZZykNCq7Mm2GQ0ve4giaUJOWFpS8SJODFkwXnR8xilIFlC
 av0eezUX7Yll/y7rVLTbh8HS14l9NmZSOkKuj3x71cr3IjoqCf9+okBMPGyyp6B7rB4e
 Ak+s3ZyALMBTqCo9cXcgU71lWafeNqxQ2gmEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727610473; x=1728215273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X/7KDbAoQF1k6zQZO9a9JEZT2AT9KGNImx73cX6Oop4=;
 b=LDzNjxyAfM1yPQpHMUevFMposgKNXgTKYzaQ+9JUitKgQyI87RZLecZGNw0XrOhd0v
 avUnLhSUrE3zegHpIShcWH/g5IRJ3xMgDAfZGwTAQ8LlpmfdEEkIvg9j3RgA72WKikzx
 CTy9TJCGqfT9UWgcqQiUOO9SE10qPIy7Ei2FgnIxoCy0XgMnfrLH6WH5OgdLn0MNPDbq
 M3Q0fHJrkWPfod5/e3cg/hmp0nmKktdYwMtkKaq5V6dS510gx3ncHYHnu4d0wk3+czOh
 I/Z1fYdZlD0iNbKpPGoEgZsu00xdVv2SsJJMTTNbwcyKzMnXGH7Iy3PTsW3ZTeOj6IVT
 +ahQ==
X-Gm-Message-State: AOJu0Yx1srfE8I+kHibIT8mxjCul6zDA1sGnbhKwyQObocb8w1MGlpaq
 +VF3+WhTVIhPsf0AaW86g5yLRRe6+WPh3aHxlsBKfcnc9UHLNP4E+Oh1i/Lc2cbboD2/9G7/zrp
 yNGLFoAm1zdYIVe4K58edmu7u+gyHe695gG+f
X-Google-Smtp-Source: AGHT+IHZkyH0BzioMTGvElO+4lotfBg+dbskUEwY/jDB1fvDrBMEjSovdQson1sEQfg4qwG6HIPPnWG1Cb/ux3oBky8=
X-Received: by 2002:a05:6214:4290:b0:6c3:68b0:a5ce with SMTP id
 6a1803df08f44-6cb3b6138f1mr153054786d6.27.1727610472833; Sun, 29 Sep 2024
 04:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240928200030.194546-1-sjg@chromium.org>
 <20240928200030.194546-22-sjg@chromium.org>
 <00b69273-b2dc-4a4b-be4e-5358afad9614@kwiboo.se>
In-Reply-To: <00b69273-b2dc-4a4b-be4e-5358afad9614@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 29 Sep 2024 13:47:41 +0200
Message-ID: <CAFLszTjRXbDWZsCqY+1=v9v6oWxfsOtq5s7WuMpAk2YcxMyhuA@mail.gmail.com>
Subject: Re: [PATCH v2 21/30] xpl: Rename u_boot_first_phase to
 xpl_is_first_phase()
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Manoj Sai <abbaraju.manojsai@amarulasolutions.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Nishanth Menon <nm@ti.com>, 
 Paul Kocialkowski <paulk@sys-base.io>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>, Sean Anderson <seanga2@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

Hi Jonas,

On Sat, 28 Sept 2024 at 16:23, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> Hi Simon,
>
> On 2024-09-28 22:00, Simon Glass wrote:
> > This is a better name for this function, so update it.
> >
> > Tidy up the function comment to mention VPL. Use SPL_BUILD in the SPL
> > check, for clarity.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/arm/mach-omap2/am33xx/board.c |  2 +-
> >  common/bloblist.c                  |  4 ++--
> >  common/spl/spl.c                   |  4 ++--
> >  include/spl.h                      | 16 +++++++++-------
> >  4 files changed, 14 insertions(+), 12 deletions(-)
> >
>
> [snip]
>
> > --- a/include/spl.h
> > +++ b/include/spl.h
> > @@ -34,24 +34,26 @@ struct spl_boot_device;
> >  enum boot_device;
> >
> >  /*
> > - * u_boot_first_phase() - check if this is the first U-Boot phase
> > + * xpl_is_first_phase() - check if this is the first U-Boot phase
> >   *
> > - * U-Boot has up to three phases: TPL, SPL and U-Boot proper. Depending on the
> > - * build flags we can determine whether the current build is for the first
> > + * U-Boot has up to four phases: TPL, VPL, SPL and U-Boot proper. Depending on
> > + * the build flags we can determine whether the current build is for the first
> >   * phase of U-Boot or not. If there is no SPL, then this is U-Boot proper. If
> >   * there is SPL but no TPL, the the first phase is SPL. If there is TPL, then
> > - * it is the first phase.
> > + * it is the first phase, etc.
> >   *
> > - * @returns true if this is the first phase of U-Boot
> > + * Note that VPL can never be the first phase. If it exists, it is loaded from
> > + * TPL
> >   *
> > + * Return: true if this is the first phase of U-Boot
> >   */
> > -static inline bool u_boot_first_phase(void)
> > +static inline bool xpl_is_first_phase(void)
> >  {
> >       if (IS_ENABLED(CONFIG_TPL)) {
> >               if (IS_ENABLED(CONFIG_TPL_BUILD))
> >                       return true;
> >       } else if (IS_ENABLED(CONFIG_SPL)) {
> > -             if (IS_ENABLED(CONFIG_XPL_BUILD))
> > +             if (IS_ENABLED(CONFIG_SPL_BUILD))
>
> Here is another instance where it made no sense to replace SPL with XPL
> to just later restore it back to SPL.

Thanks for taking the time to look through this!

The rename to XPL happens in 'global: Rename SPL_ to XPL_' which is an
earlier patch. That patch renames absolutely everything. If I leave
this particular one as SPL_BUILD, then there will still be occurrences
of SPL_BUILD in U-Boot. So when I later rebase this series I won't
know whether I missed something or not.

I can certainly drop the s/XPL/SPL/ change in this patch though, if
that is suitable?

Regards,
Simon
