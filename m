Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E31EE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 14:41:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E177580104;
	Fri, 13 Dec 2024 15:41:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XEEaPe5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7FE6800D7; Fri, 13 Dec 2024 15:41:21 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97DEA8012C
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 15:41:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385e0e224cbso973562f8f.2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 06:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734100879; x=1734705679; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZOQi7gap6hkt1juH0WHrK9UH+fr/24km5AUGVkUs/I=;
 b=XEEaPe5uRRMdz0RKo6wEoVS9gdb1J/6fxbAQG2b/asn3uZdk60A9q1E/xyqLGe3DNn
 gmBk/XdnKzQKaVVyGjt+66U2Waqyt8trKjymIUVdQm1mL8MxVBC7g+md90nV+pGZswic
 plbSc+kXp4BnjQhjOHjgdmn8NCUEBvJY3g1Z0ia5JahYTuHNGCuzfYbwPwnhhnN53I25
 F0wJQ1WOS8YUhU3J8mx90gIxaes5/A9kYBNvu1pL3BOagNPbS7VXx0ofoTXmA4OB2nk2
 IRCQEVnYlPsry+22ZjivtfgCw05h1p5zMBVJ4iQRobXwbpuMGwjunXFd3qV8nim6PIAm
 7tRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734100879; x=1734705679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ZOQi7gap6hkt1juH0WHrK9UH+fr/24km5AUGVkUs/I=;
 b=vqrAHCzlfWzczk3VuPmRVUVwKx1wAAmEI0okRpUz7HwgDkJxJtLXK5F+paD0Q7cvy7
 0HvZ8lBaK9NAX1p/pzbFgtat5Nzo2cMDxvqonsvCiJSkBZRxIpukEaDcmM9K+Lnlau2T
 pfG48vowRFD8GFPDfnZ7mU+99+pntVkjRuM9ZiD9ouG9H39Zg6ok7Lf3C1jC1EJECdvW
 ka7gy3LBoC1UyqLkAFbIO7jHiTJe/tu+er8OSOCFbclYArKxkGJNc7ShJKSuTl2XFnvQ
 AVvanAMWXzoV5L6JBgQmFQdn4mpmh3vpO2GIaoGk+ic7tmFLAkNLLUa4DK9WMyNrXSdL
 io9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK8VMid41jkkYNmaH3XJeve4NRK64hFuOFkU4yH4w67F/ypHZI5uULrriHEtA180WdYVGTow8=@lists.denx.de
X-Gm-Message-State: AOJu0YwEn3GXnEt2TwRCiguE0knUCpXozEpO1Xxr2JzeUgY3+BY4MLK7
 DQcA+dKbOmopXpYnDADla9gzZOu7WCdts3vyu+6oY8/m9ysDUF8S3wwXK2rybZ459sa/GprodiA
 CaMBBWxHw3oVXXgKD2oZUehoa1LHsKA==
X-Gm-Gg: ASbGnctc3TarOfjsZux4CCvIjKww2+vRUuvNkbOMQy4IHXAkdXY7UNsRFWOnWlBQMMF
 9HSylSPsOQxkLyHAbtOUehy6GjEGwbiaBLNUn8hA=
X-Google-Smtp-Source: AGHT+IGoUJr0iUQBJHXON6BxAiobBisPJLJ70bBSLd0KRLsyQIWRqM5IF7egDKlPDjNst5Q8vKceNY1RjrO7Xtjcmt0=
X-Received: by 2002:a05:6000:1fae:b0:386:366d:5d03 with SMTP id
 ffacd0b85a97d-38880ad88dcmr2197996f8f.16.1734100878775; Fri, 13 Dec 2024
 06:41:18 -0800 (PST)
MIME-Version: 1.0
References: <20241212100646.5646-1-clamor95@gmail.com>
 <20241212100646.5646-2-clamor95@gmail.com>
 <22h44kvaqrm7zod7e5g7jwgn4cupll6sw62yh2lhn3vricqprm@egfbb7akgifn>
In-Reply-To: <22h44kvaqrm7zod7e5g7jwgn4cupll6sw62yh2lhn3vricqprm@egfbb7akgifn>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 13 Dec 2024 16:41:07 +0200
Message-ID: <CAPVz0n0BGO2mfre0k5H92xH5UEcY0+Up5ePDu4STAY8BOeK9GQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver: clk: tegra: partially support PLL clocks
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

=D0=BF=D1=82, 13 =D0=B3=D1=80=D1=83=D0=B4. 2024=E2=80=AF=D1=80. =D0=BE 16:3=
3 Thierry Reding <thierry.reding@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Thu, Dec 12, 2024 at 12:06:45PM +0200, Svyatoslav Ryhel wrote:
> > Return PLL id into struct clk if PLL is parsed from device
> > tree instead of throwing an error. Allow requesting PLL
> > clock rate via get_rate op.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/clk/tegra/tegra-car-clk.c | 49 ++++++++++++++++++++++++-------
> >  1 file changed, 39 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/clk/tegra/tegra-car-clk.c b/drivers/clk/tegra/tegr=
a-car-clk.c
> > index 1d61f8dc378..dd4d7791120 100644
> > --- a/drivers/clk/tegra/tegra-car-clk.c
> > +++ b/drivers/clk/tegra/tegra-car-clk.c
> > @@ -10,6 +10,9 @@
> >  #include <asm/arch/clock.h>
> >  #include <asm/arch-tegra/clk_rst.h>
> >
> > +#define TEGRA_CAR_CLK_PLL    BIT(0)
> > +#define TEGRA_CAR_CLK_PERIPH BIT(1)
> > +
> >  static int tegra_car_clk_request(struct clk *clk)
> >  {
> >       debug("%s(clk=3D%p) (dev=3D%p, id=3D%lu)\n", __func__, clk, clk->=
dev,
> > @@ -20,30 +23,50 @@ static int tegra_car_clk_request(struct clk *clk)
> >        * varies per SoC) are the peripheral clocks, which use a numberi=
ng
> >        * scheme that matches HW registers 1:1. There are other clock ID=
s
> >        * beyond this that are assigned arbitrarily by the Tegra CAR DT
> > -      * binding. Due to the implementation of this driver, it currentl=
y
> > -      * only supports the peripheral IDs.
> > +      * binding.
> >        */
> > -     if (clk->id >=3D PERIPH_ID_COUNT)
> > -             return -EINVAL;
> > +     if (!(clk->id >=3D PERIPH_ID_COUNT)) {
>
> Maybe just do clk->id < PERIPH_ID_COUNT and get rid of the negation?
> Seems a bit more straightforward.
>

Agreed.

> > +             clk->data |=3D TEGRA_CAR_CLK_PERIPH;
> > +             return 0;
> > +     }
> >
> > -     return 0;
> > +     /* If check for periph failed, then check for PLL clock id */
> > +     int id =3D clk_id_to_pll_id(clk->id);
> > +
> > +     if (clock_id_is_pll(id)) {
> > +             clk->id =3D id;
> > +             clk->data |=3D TEGRA_CAR_CLK_PLL;
> > +             return 0;
> > +     }
> > +
> > +     return -EINVAL;
> >  }
> >
> >  static ulong tegra_car_clk_get_rate(struct clk *clk)
> >  {
> > -     enum clock_id parent;
> > +     if (clk->data & TEGRA_CAR_CLK_PLL)
> > +             return clock_get_rate(clk->id);
> >
> > -     debug("%s(clk=3D%p) (dev=3D%p, id=3D%lu)\n", __func__, clk, clk->=
dev,
> > -           clk->id);
> > +     if (clk->data & TEGRA_CAR_CLK_PERIPH) {
> > +             enum clock_id parent;
> >
> > -     parent =3D clock_get_periph_parent(clk->id);
> > -     return clock_get_periph_rate(clk->id, parent);
> > +             debug("%s(clk=3D%p) (dev=3D%p, id=3D%lu)\n", __func__,
> > +                   clk, clk->dev, clk->id);
>
> Is there any specific reason why you moved the debug() call into the
> branch? It looks like it was supposed to be a simple function tracing
> message, so it would probably be useful to have for PLL clocks as well.
>

I will check if this debug can be applied to plls as well as it is. If
yes, I will move it higher. Thanks

> > +
> > +             parent =3D clock_get_periph_parent(clk->id);
> > +             return clock_get_periph_rate(clk->id, parent);
> > +     }
> > +
> > +     return -1U;
> >  }
> >
> >  static ulong tegra_car_clk_set_rate(struct clk *clk, ulong rate)
> >  {
> >       enum clock_id parent;
> >
> > +     if (clk->data & TEGRA_CAR_CLK_PLL)
> > +             return 0;
> > +
> >       debug("%s(clk=3D%p, rate=3D%lu) (dev=3D%p, id=3D%lu)\n", __func__=
, clk, rate,
> >             clk->dev, clk->id);
>
> Same here.
>
> >
> > @@ -53,6 +76,9 @@ static ulong tegra_car_clk_set_rate(struct clk *clk, =
ulong rate)
> >
> >  static int tegra_car_clk_enable(struct clk *clk)
> >  {
> > +     if (clk->data & TEGRA_CAR_CLK_PLL)
> > +             return 0;
> > +
> >       debug("%s(clk=3D%p) (dev=3D%p, id=3D%lu)\n", __func__, clk, clk->=
dev,
> >             clk->id);
>
> And here.
>
> >
> > @@ -63,6 +89,9 @@ static int tegra_car_clk_enable(struct clk *clk)
> >
> >  static int tegra_car_clk_disable(struct clk *clk)
> >  {
> > +     if (clk->data & TEGRA_CAR_CLK_PLL)
> > +             return 0;
> > +
> >       debug("%s(clk=3D%p) (dev=3D%p, id=3D%lu)\n", __func__, clk, clk->=
dev,
> >             clk->id);
> >
>
> And here, too.
>
> Thierry
