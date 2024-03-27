Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A2AC47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 18:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEABD880AC;
	Wed, 27 Mar 2024 19:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="BaUmLYOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC4E0880B5; Wed, 27 Mar 2024 19:47:26 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55B78880A3
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 19:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5688eaf1165so196271a12.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 11:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1711565243; x=1712170043; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2CREkClos/ol7GKUT1vAo3Np5CU3N7BOhUtgOWsyrA=;
 b=BaUmLYOBfgtcPsGpuqzGNrGt/A/l6OsDM2XnLSAUsarD1yOFd0WIzsUsQ98lQQkw1D
 DI8ovNPYqvrNQ+vSOMkenF505l0yuerMOzQdbzkzWYTYrSIAQ+BEfG632+WrLaY6map4
 xdvbcead+2UYX5dZgD0Dpwg6+MXKJm6rblf0zzAlFBuhR1zD915GFn4gVSSPQOJnINs+
 DxQ+6P5SrR0e+dpl7xbSbFVpU2kfkFHM2aWDRz65BG7nHpqCKEHT+FngHbjoNuk573Iy
 X2/yzrQOt8YqEghWcxlgU9mGqBdOHh8I9uyJ+EREHFLcCHZ3nmLbs9DYdSjsMVjCiRc3
 JDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711565243; x=1712170043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F2CREkClos/ol7GKUT1vAo3Np5CU3N7BOhUtgOWsyrA=;
 b=g3mSuabdYZHJtOkSMQWaT+pCHXVPCG4Vz4pMQh5vZSAWsv66tpvc0H3FilU+iu7voJ
 r4zqsy1YHiIV4j2vL2CAjW4Uvau6F4Yo232Ty3Np2DCb0wz8ss19cw6Pw2YhKYMWenTL
 t924TNfl82OFV3452/p3WKV1/bMvuJodX37pGfjen56b4DnprPhJC/lSFCvIpdxRomtu
 lu8tNVkvg2jWsvTlRsNQlKBH0gKJq5nMcCQvvZCuriBKyR0mpFTEzG1mBfWEYQeso3DN
 LwmDRQwXWdPGc0s+1smmEc/OtMVuRgnsUbdPzg7hpR47yp3drw648iHJKdvscrLvuiT2
 ALPw==
X-Gm-Message-State: AOJu0YwbzZK1XTum57vFdZGLgyhU0aYdx6npj2RjQ5v/NyU4b3mw6uWD
 fNVI59oyfe+yG7FgXY8YsWSrjVutHIgJDGxjpoUJM5SmjwiTvG6p4xf2peS8y5MG4c+JP2Qmx+W
 cQpOwd3NGFkT3HNj6UifLYqnJEP+HImNGkPbI6A==
X-Google-Smtp-Source: AGHT+IFeiEZsN73Bdwh2XuXcRkAEG1428t/b8wolwQW90y3A1ffzGCLmBPJEWhX9UIbv0GjZNqeTkXGg1DruMMc/uuQ=
X-Received: by 2002:a17:906:48d0:b0:a47:4293:947f with SMTP id
 d16-20020a17090648d000b00a474293947fmr235440ejt.8.1711565243567; Wed, 27 Mar
 2024 11:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240321180219.1039622-1-tharvey@gateworks.com>
 <CAC_iWjLwt9NxwOsYWwx4+w2vL3dtfJnJPH-eeApU-ODKf8tzBA@mail.gmail.com>
 <CAJ+vNU0aSj5RgCUxz74hg059Qtmco4HSBCiAHA_hhw+jzxo5Dw@mail.gmail.com>
 <CAC_iWjJ4s1ZS8X64vjV_xiOSzKf7fPBryw6eGp6tW7Vqxv2_gw@mail.gmail.com>
 <CAJ+vNU1m=joe0mAC2ss-QmBN17Jht4d+fpba4iM0tTScy0Zngg@mail.gmail.com>
 <CAC_iWjL6CtZ5WgASepcUZOXnF=G4uDTeVq3WnOkz+jDL+cLZzw@mail.gmail.com>
 <CAC_iWjJCAj0sv3mdzje4ivn4Ob=tyW38K03GD=mj8_FOvK35AQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJCAj0sv3mdzje4ivn4Ob=tyW38K03GD=mj8_FOvK35AQ@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 27 Mar 2024 11:47:11 -0700
Message-ID: <CAJ+vNU2v03MQXBysVxrUQwKeQH4KJjwkHXtmT3g=2f+++jsP5A@mail.gmail.com>
Subject: Re: [PATCH] tpm: display message when using gpio-reset instead of
 when missing it
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: u-boot@lists.denx.de, Samuel Lee <slee@gateworks.com>
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

On Wed, Mar 27, 2024 at 10:26=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > >
> > > missing an invalid property?
> > >
> > > I deal with users all the time that think things like that are
> > > 'errors' and contact tech support. In this case its not an error
> > > because there is no gpio reset in the official dt-bindings for the tp=
m
> > > and its generally considered bad form to add non official properties.
> > >
> > > And from what your explaining we shouldn't have a GPIO connected to
> > > the TPM so perhaps we should remove the reset completely and perhaps
> > > even spit out a warning if present:
> > > ignore Invalid DT property gpio reset to conform with the TCG specifi=
cation
> >
> > We should, but those changes predate me being appointed as a TPM
> > maintainer. If I had to guess, I would say that was added for TPM that
> > are connected on an external SPI bus (e.g the RPI).
> > So what about not printing the error message, keeping the code so we
> > won't break 'test' devices, and print a warning message like "This
> > shouldn't be used on secure production devices"?
>
> Unless we can get a list of the devices that *currently* use it. If
> they aren't that many I am fine getting rid of the reset overall (and
> I can test it on the RPI4)
>

Adding Miquel who authored commit a174f0001f592 ("tpm2: tis_spi: add
the possibility to reset the chip with a gpio"):
On some designs, the reset line could not be connected to the SoC reset
line, in this case, request the GPIO and ensure the chip gets reset.

Adding Jorge who athoried commit cc5afabc9d329 ("drivers: tpm2: update
reset gpio semantics"):
Use the more generic reset-gpios property name.

I looked through all dts in U-Boot matching 'tpm' as well as Linux to
see who's using it:
Adding Adam who has a 'reset-gpios' in
arch/arm/dts/imx8mp-beacon-kit.dts (and somehow snuck it in upstream
as well)
Adding Rasmus who has a suspicious 'regulatot-tpm0-rst' (but no gpio
reset in tpm) in arch/arm/dts/imx8mm-cl-iot-gate-ied-tpm0.dtso

As there is at least one board that clearly uses a gpio reset for the
TPM in the tpm node I think we leave the tpm reset support, eliminate
the warning if its missing and print a message like "Warning: TPM gpio
reset should not be used on secure production device"

I'll send a v2 of my patch for review

Best Regards,

Tim
[1] https://patchwork.ozlabs.org/project/uboot/patch/20240321180219.1039622=
-1-tharvey@gateworks.com/

> Cheers
> /Ilias
> >
> > Regards
> > /Ilias
> > >
> > > Best regards,
> > >
> > > Tim
> > >
> > > >
> > > > Thanks
> > > > /Ilias
> > > > >
> > > > > Best Regards,
> > > > >
> > > > > Tim
> > > > > [1] https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Tru=
sted-Platform-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.p=
df
> > > > >
> > > > >
> > > > > > Thanks
> > > > > > /Ilias
> > > > > > >
> > > > > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > > > > ---
> > > > > > >  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
> > > > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_ti=
s_spi.c
> > > > > > > index de9cf8f21e07..944540f7a711 100644
> > > > > > > --- a/drivers/tpm/tpm2_tis_spi.c
> > > > > > > +++ b/drivers/tpm/tpm2_tis_spi.c
> > > > > > > @@ -237,14 +237,14 @@ static int tpm_tis_spi_probe(struct ude=
vice *dev)
> > > > > > >                         /* legacy reset */
> > > > > > >                         ret =3D gpio_request_by_name(dev, "gp=
io-reset", 0,
> > > > > > >                                                    &reset_gpi=
o, GPIOD_IS_OUT);
> > > > > > > -                       if (ret) {
> > > > > > > -                               log(LOGC_NONE, LOGL_NOTICE,
> > > > > > > -                                   "%s: missing reset GPIO\n=
", __func__);
> > > > > > > +                       if (ret)
> > > > > > >                                 goto init;
> > > > > > > -                       }
> > > > > > >                         log(LOGC_NONE, LOGL_NOTICE,
> > > > > > >                             "%s: gpio-reset is deprecated\n",=
 __func__);
> > > > > > >                 }
> > > > > > > +               log(LOGC_NONE, LOGL_NOTICE,
> > > > > > > +                   "%s: performing 1ms reset on %s:%d\n", de=
v->name,
> > > > > > > +                   reset_gpio.dev->name, reset_gpio.offset);
> > > > > > >                 dm_gpio_set_value(&reset_gpio, 1);
> > > > > > >                 mdelay(1);
> > > > > > >                 dm_gpio_set_value(&reset_gpio, 0);
> > > > > > > --
> > > > > > > 2.25.1
> > > > > > >
