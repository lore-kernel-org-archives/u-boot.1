Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C1C9CAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 08:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8436883211;
	Mon, 22 Sep 2025 10:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mGxQTS8U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1132B83390; Mon, 22 Sep 2025 10:11:31 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C487382B07
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 10:11:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3ee1221ceaaso2116666f8f.3
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 01:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758528688; x=1759133488; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FRSLKG+xOvKuMHFWKOe8oweqRF0B5KLWgGVxv37jfTE=;
 b=mGxQTS8UzHn/1mpDgEYJI/PhYpwN+5lPXF7bnbOfSYLuCHl2YsgFU5AN35xLMXmBYJ
 Kf6W1RRWnvN4Ch1Xcqmm9v/lwF1o2FhBgv3Cjrao319byp4xDVytpvZswlrPu83fHoe6
 mtiA83x7JioaPi9cZCddyPz17rUuFWKzBiOfVF1BVUZWjGIYQJ8FHGn4DLFzR7QIKMBy
 L3D5G2TrDLfo31bxtCnMQbDuC25D8rjRXEw0T1JJM6Nx83j/j5YQ/KFolZsG6eO/aRA4
 SQWncA8R3WF/ElCLuFNc8y63IvOCNQWmQcTDmS9h0RZqgsZK2opUYi8ymfvXwgnCbOeo
 yB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758528688; x=1759133488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FRSLKG+xOvKuMHFWKOe8oweqRF0B5KLWgGVxv37jfTE=;
 b=BpqZWBFytz/07qsYi6pNxenHGPXnh5vJmL+4K8lEtK5xShz0Q9LkWISPmgLISH+kQY
 rAsDlYDRnd24PxNTnSbcGUjlGdf1BS0p4pa37c9x7QzNHKqRY/zssYs5xKVj0C2Jq2y1
 GQ7H1nGVKQkKlFMre3iFwpBUQDWFwcp6G8Uw7NQfK4WD0XCGAJmw9LcfraW6UXRzP6nm
 CKeJ0nAz7hYfWwyLErZbk78Dl4DG+yIS0413dP1fUtdLoZxfr/+dDwgZ407ac364VqfH
 UkPOuZu152OpHz7KQ25qaCxXjUoHOE15U5UaXyZKMe48MgVH3bzxK0rS6v2LpLtu9U5u
 Dqbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/S9+wKAwHWNXVLZokZsG2pzStOJyXCl65922MpaTIV/XXgOz57SltzK42xlcSh7W+6KDZO7E=@lists.denx.de
X-Gm-Message-State: AOJu0Ywf5xF6M4ORQbgyMwQf9saDsw/5UARTP8yYTxJsJufhAzn368Xg
 gNRSXZPhTr9eXA78d5LtILC4z8cyHwkKOhs9qFnRJX6t0fS83sKiD0Jn4Xmgp9KZ3Ph4OkVJpdW
 xpNCCn0ZNQ405I6MAbU7omB6nnXfN328=
X-Gm-Gg: ASbGncuTfY61ggPXmlWqvxjgU0mwNzmsWAdCEeFRhyQ+O/IcdRgFfoJvEIN12Aji0zd
 TolCRw2pjncAD4/zKa/4YPrImOtt6mxYteW0kupkuJUQG5RA2yCsPvvcRM0RncAIouvwFxXo33f
 PcO+fv34l56SP4Ok7EZeRLG/5PUmLeSEkL3+JfF57ZumxyHB5k5e0w5rP2kpnwsRmbxbHemFEzz
 mHY7rTq
X-Google-Smtp-Source: AGHT+IE+qhIYJkTY6NLR/4/culgEFTjSbpv2/pOdIS2g3WsiDyAWI9ry7Gtz3WXjiGzQ2jaOTaKpha52nIjTQLkH7KQ=
X-Received: by 2002:a05:6000:22c7:b0:3ee:1357:e18f with SMTP id
 ffacd0b85a97d-3ee7bad15e4mr9969205f8f.12.1758528688003; Mon, 22 Sep 2025
 01:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250919101117.853194-1-lukma@nabladev.com>
 <CAPVz0n2VSmeyaHRn6WUfSN3uBu+7fw38Q2Wz22VWMjth8nTsPA@mail.gmail.com>
 <20250922100826.4ab1d4d8@wsk>
In-Reply-To: <20250922100826.4ab1d4d8@wsk>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 22 Sep 2025 11:11:16 +0300
X-Gm-Features: AS18NWC8T0u8Wps9_jOQqvV3NjtH9p6-p9ktRXSu9-y-LaHI-mRvMtq3ncq8j-o
Message-ID: <CAPVz0n1nmTsENcyE5=U9j6z-aJgG9RO+g+TEh2D5Zf=gw8bo-Q@mail.gmail.com>
Subject: Re: [PATCH] arm: gpio: Add set_flags callback to the Tegra gpio driver
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@nabladev.com>
Cc: Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
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

=D0=BF=D0=BD, 22 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 11:08 =C5=
=81ukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyatoslav,
>
> > =D0=BF=D1=82, 19 =D0=B2=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 13:11 =
Lukasz Majewski <lukma@nabladev.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > In some Tegra SoC (like e.g. T30) there is a possibility that one
> > > will configure at early boot state a pin as GPIO (to use it for
> > > e.g. carrier board detection). However, afterwards (i.e. in Linux)
> > > the same pin will be used as the special function one.
> > >
> > > Current Tegra gpio driver doesn't allow this, so callback for
> > > set_flags() has been defined to properly setup the GPIO when
> > > required.
> >
> > Please write the commit message in the imperative mood.
> >
> > > For now following flags are supported:
> > > - GPIOD_IS_AF (i.e. "alternate function").
> > > - GPIOD_IS_IN
> > > - GPIOD_IS_OUT
> > >
> > > In long term the tegra_gpio_set_flags() is going to replace
> > > direction_{input|output} callbacks.
> > >
> >
> > It is not a book chapter, describe what the commit does briefly.
>
> Sorry, but the commit message is a pretty nice form of the
> documentation.
>
> For example when you come back to a project, after a few years each
> extra sentence is priceless.
>
> >
> > > Signed-off-by: Lukasz Majewski <lukma@nabladev.com>
> > > ---
> > >  drivers/gpio/tegra_gpio.c | 24 ++++++++++++++++++++++++
> > >  1 file changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/gpio/tegra_gpio.c b/drivers/gpio/tegra_gpio.c
> > > index 3d1e18854f2..1e8bd051875 100644
> > > --- a/drivers/gpio/tegra_gpio.c
> > > +++ b/drivers/gpio/tegra_gpio.c
> > > @@ -258,6 +258,29 @@ static int tegra_gpio_rfree(struct udevice
> > > *dev, unsigned int offset) return 0;
> > >  }
> > >
> > > +static int tegra_gpio_set_flags(struct udevice *dev, unsigned int
> > > offset,
> > > +                               ulong flags)
> > > +{
> > > +       struct tegra_port_info *state =3D dev_get_priv(dev);
> > > +       int gpio =3D state->base_gpio + offset;
> > > +
> > > +       debug("gpio_set_flags: pin =3D %d (port %d:bit %d), flag =3D
> > > %d\n",
> > > +             gpio, GPIO_FULLPORT(gpio), GPIO_BIT(gpio), flags);
> > > +
> >
> > Have you even built this code yourself? "flags" is of type ulong, not
> > int
>
> It was compiling, but I will double check it.
>
> >
> > > +       if (flags & GPIOD_IS_AF) {
> > > +               set_config(gpio, CFG_SFIO);
> > > +               return 0;
> > > +       } else if (flags & GPIOD_IS_IN) {
> > > +               return tegra_gpio_direction_input(dev, offset);
> > > +       } else if (flags & GPIOD_IS_OUT) {
> > > +               bool value =3D flags & GPIOD_IS_OUT_ACTIVE;
> > > +
> > > +               return tegra_gpio_direction_output(dev, offset,
> > > value);
> > > +       }
> > > +
> > > +       return -EINVAL;
> > > +}
> > > +
> > >  static const struct dm_gpio_ops gpio_tegra_ops =3D {
> > >         .direction_input        =3D tegra_gpio_direction_input,
> > >         .direction_output       =3D tegra_gpio_direction_output,
> > > @@ -266,6 +289,7 @@ static const struct dm_gpio_ops gpio_tegra_ops
> > > =3D { .get_function           =3D tegra_gpio_get_function,
> > >         .xlate                  =3D tegra_gpio_xlate,
> > >         .rfree                  =3D tegra_gpio_rfree,
> > > +       .set_flags              =3D tegra_gpio_set_flags,
> >
> > If you are already touching this anyway, then touch it properly. Since
> > set_flags op is meant to remove direction ops, then remove latter too.
> >
>
> Ok.
>
> > >  };
> > >
> > >  /*
> > > --
> > > 2.39.5
> > >
> >
> > This commit causes regression on LG P990 board, backlight is located
> > on gpio i2c line and with this patch gpio i2c refuses to work
> >
> > (bootloader) Core:  114 devices, 27 uclasses, devicetree: separate
> > (bootloader) MMC:   sdhci@c8000400: 1, sdhci@c8000600: 0
> > (bootloader) Loading Environment from MMC... Reading from MMC(0)...
> > *** (bootloader) Warning - bad CRC, using default environment
> > (bootloader)
> > (bootloader) Can't get i2c-5 gpios! Error: -22
> > (bootloader) Can't get i2c-5 gpios! Error: -16
> > (bootloader) In:    serial,usbkbd,button-kbd
> > (bootloader) Out:   serial,vidconsole
> > (bootloader) Err:   serial,vidconsole
> > (bootloader) Net:   No ethernet found.
> > (bootloader)
> > (bootloader) Autoboot in 0 seconds
>
> Apparently, some flags are not yet supported - like  GPIOD_PULL_UP/DOWN
> or GPIOD_OPEN_DRAIN.
>
> Is this the one from u-boot/board/lg/star/star.c function
> star_fix_panel()?
>
> Or is it somewhere else - for example in drivers/i2c/i2c-gpio.c ?
>

I have told that it comes from i2c-gpio

> For the latter it looks like I do support all the required flags.
>
> At least on my Colibri T30 it works correctly - so extra help is
> appreciated.
>
> --
> Best regards,
>
> Lukasz Majewski
>
> --
> Nabla Software Engineering GmbH
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Geschftsfhrer : Stefano Babic
