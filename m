Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1443CCAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 08:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5448683211;
	Mon, 22 Sep 2025 10:08:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="LktFCNh4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A051783280; Mon, 22 Sep 2025 10:08:37 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 391A282B07
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 10:08:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukma@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A4BFF1075FB; Mon, 22 Sep 2025 10:08:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1758528514;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Ova5uffJQilkz8OdEp/QqRr2nlZ1Hy/aRg9+5DPq1qI=;
 b=LktFCNh4FA3XpgYXj2agjdi6g1Sx1VuNuSRsG1+jOJkrTUeJxsy14uCejM2YA+kQs58AQ/
 AV267IUWq5Og/40m93LOZqvJQbXdLRG43wclfJbYlgTf/58U8jc3KWOOQNpdyXpRsj9aCT
 FUl1OGmC0FCE43uRXHKjN5bvkz/WIrr8YWCfQtVSMs0CFnegxQzkeQJiAGDpAk7phYTjew
 RZZpXN5y1C3rdVj/9eVulmtSzNokh1CfKI0m9915Ln+Bw4ue/x53ZzoWwQk92I9xJmQKxb
 STMbYiWcELp71+CK2yhjh3okcrO2eT1/fHA+PA+z5usbXcGTuKkD9v6cWA1I2g==
Date: Mon, 22 Sep 2025 10:08:26 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] arm: gpio: Add set_flags callback to the Tegra gpio driver
Message-ID: <20250922100826.4ab1d4d8@wsk>
In-Reply-To: <CAPVz0n2VSmeyaHRn6WUfSN3uBu+7fw38Q2Wz22VWMjth8nTsPA@mail.gmail.com>
References: <20250919101117.853194-1-lukma@nabladev.com>
 <CAPVz0n2VSmeyaHRn6WUfSN3uBu+7fw38Q2Wz22VWMjth8nTsPA@mail.gmail.com>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
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

Hi Svyatoslav,

> =D0=BF=D1=82, 19 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:11 Lu=
kasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > In some Tegra SoC (like e.g. T30) there is a possibility that one
> > will configure at early boot state a pin as GPIO (to use it for
> > e.g. carrier board detection). However, afterwards (i.e. in Linux)
> > the same pin will be used as the special function one.
> >
> > Current Tegra gpio driver doesn't allow this, so callback for
> > set_flags() has been defined to properly setup the GPIO when
> > required. =20
>=20
> Please write the commit message in the imperative mood.
>=20
> > For now following flags are supported:
> > - GPIOD_IS_AF (i.e. "alternate function").
> > - GPIOD_IS_IN
> > - GPIOD_IS_OUT
> >
> > In long term the tegra_gpio_set_flags() is going to replace
> > direction_{input|output} callbacks.
> > =20
>=20
> It is not a book chapter, describe what the commit does briefly.

Sorry, but the commit message is a pretty nice form of the
documentation.

For example when you come back to a project, after a few years each
extra sentence is priceless.

>=20
> > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > ---
> >  drivers/gpio/tegra_gpio.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/drivers/gpio/tegra_gpio.c b/drivers/gpio/tegra_gpio.c
> > index 3d1e18854f2..1e8bd051875 100644
> > --- a/drivers/gpio/tegra_gpio.c
> > +++ b/drivers/gpio/tegra_gpio.c
> > @@ -258,6 +258,29 @@ static int tegra_gpio_rfree(struct udevice
> > *dev, unsigned int offset) return 0;
> >  }
> >
> > +static int tegra_gpio_set_flags(struct udevice *dev, unsigned int
> > offset,
> > +                               ulong flags)
> > +{
> > +       struct tegra_port_info *state =3D dev_get_priv(dev);
> > +       int gpio =3D state->base_gpio + offset;
> > +
> > +       debug("gpio_set_flags: pin =3D %d (port %d:bit %d), flag =3D
> > %d\n",
> > +             gpio, GPIO_FULLPORT(gpio), GPIO_BIT(gpio), flags);
> > + =20
>=20
> Have you even built this code yourself? "flags" is of type ulong, not
> int

It was compiling, but I will double check it.=20

>=20
> > +       if (flags & GPIOD_IS_AF) {
> > +               set_config(gpio, CFG_SFIO);
> > +               return 0;
> > +       } else if (flags & GPIOD_IS_IN) {
> > +               return tegra_gpio_direction_input(dev, offset);
> > +       } else if (flags & GPIOD_IS_OUT) {
> > +               bool value =3D flags & GPIOD_IS_OUT_ACTIVE;
> > +
> > +               return tegra_gpio_direction_output(dev, offset,
> > value);
> > +       }
> > +
> > +       return -EINVAL;
> > +}
> > +
> >  static const struct dm_gpio_ops gpio_tegra_ops =3D {
> >         .direction_input        =3D tegra_gpio_direction_input,
> >         .direction_output       =3D tegra_gpio_direction_output,
> > @@ -266,6 +289,7 @@ static const struct dm_gpio_ops gpio_tegra_ops
> > =3D { .get_function           =3D tegra_gpio_get_function,
> >         .xlate                  =3D tegra_gpio_xlate,
> >         .rfree                  =3D tegra_gpio_rfree,
> > +       .set_flags              =3D tegra_gpio_set_flags, =20
>=20
> If you are already touching this anyway, then touch it properly. Since
> set_flags op is meant to remove direction ops, then remove latter too.
>=20

Ok.

> >  };
> >
> >  /*
> > --
> > 2.39.5
> > =20
>=20
> This commit causes regression on LG P990 board, backlight is located
> on gpio i2c line and with this patch gpio i2c refuses to work
>=20
> (bootloader) Core:  114 devices, 27 uclasses, devicetree: separate
> (bootloader) MMC:   sdhci@c8000400: 1, sdhci@c8000600: 0
> (bootloader) Loading Environment from MMC... Reading from MMC(0)...
> *** (bootloader) Warning - bad CRC, using default environment
> (bootloader)
> (bootloader) Can't get i2c-5 gpios! Error: -22
> (bootloader) Can't get i2c-5 gpios! Error: -16
> (bootloader) In:    serial,usbkbd,button-kbd
> (bootloader) Out:   serial,vidconsole
> (bootloader) Err:   serial,vidconsole
> (bootloader) Net:   No ethernet found.
> (bootloader)
> (bootloader) Autoboot in 0 seconds

Apparently, some flags are not yet supported - like  GPIOD_PULL_UP/DOWN
or GPIOD_OPEN_DRAIN.

Is this the one from u-boot/board/lg/star/star.c function
star_fix_panel()?

Or is it somewhere else - for example in drivers/i2c/i2c-gpio.c ?

For the latter it looks like I do support all the required flags.

At least on my Colibri T30 it works correctly - so extra help is
appreciated.

--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschftsfhrer : Stefano Babic
