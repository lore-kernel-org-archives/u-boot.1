Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCC5C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 21:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A6E87FCC;
	Wed, 27 Mar 2024 22:36:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PcL9CQ0l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4818B8803F; Wed, 27 Mar 2024 22:36:49 +0100 (CET)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F135B87F95
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 22:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2d68c6a4630so2377221fa.3
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711575406; x=1712180206; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WWvXCyNjfOwbkIIQBXzRQ4rOxbgOKPL+bnDm9Xi4NE8=;
 b=PcL9CQ0l1A7cUg8coXkutVGvyRRe8cKuZE/PJbVPaEIxj51nyxdTxtr/ScCcVkl/SW
 QCtO2gyW77F6DV+jxewqpOVbCUI+lNAFtKb77jlSxJYumlQ1xQcI1HSrkm07UkE+uOsq
 IwxMO6N4nrYo+pvxT2it+yJuPxq/dhGpIOHbdJheci5TCKu6tjSHXrx8zAylypoKz78J
 HK+xk+A3H7QusxGJkYTUAFl/VHPrajdv5DVVGDUEf2CiysckWVSRbwRlK3EUfYQuPrdl
 EGCWpE/W3Z3EQ/tArQtpPR4+VewZQNpFLD9CJLEkp5B+J5nSaZIiHMi0CVKRBAyDfD99
 clLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711575406; x=1712180206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WWvXCyNjfOwbkIIQBXzRQ4rOxbgOKPL+bnDm9Xi4NE8=;
 b=UZhJTOqFeDW7rZUri0Z9/8Jgywa0y5xiZyrir2JOOU6nNew04C7MF+tXH5frW90KjS
 Bye+/gVrFieoV6qoTf0I201HG3b6m3lUtq3w6FGLe+x53CefP0+hSaCG0mXbF7yvm0JE
 NYbkHV/ftrNmYyeyBdTVqCxbnMoZ/gIsW29zjuKH2D+AzJs1nT50j702kumdxZud2YSQ
 UvFA7tnoNa635tukd6EasOGU18OH4bsCEBbD0VGeW/eMFtfqa8otzckwTqkCAJjkHnTq
 kWlf/DNgBeXJqlON9btOY05+K5XM8hkGfISguHmYGmk6zwLUDCy0flV0sobNbNtjOVeZ
 wxww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlw4HFsvbmfHqYFPgBoatM4Kqy/qDDHOuudlrQ85DtYOsNuclggXiewpB+kyWfAjU6kdyXGLaj4rXS5+70aU4oXzE75Q==
X-Gm-Message-State: AOJu0Yyx7ANJkfsCcJfQFHmKOxuoBzM/7rVeZgmUR/qoJfdhidoL9z8v
 2rPASkD9sfogFLZzjuaU2M8+QgI8eBnDHaU+RAl4aD41jMmJwFVs4B4V2AGaUiMs6WXr+vRdJzG
 I+jq192N7yPQXmsXA38Jjhbt3yId2sJNNsf8KrA==
X-Google-Smtp-Source: AGHT+IGHp3DT7BC4KPwFWJTU9X4EUiOExpoNI8gp8rFKvEyBKwMiALYbxhAZnuyh1UaEoLCZNITeApNkZ/I9nOPyaIU=
X-Received: by 2002:a2e:82d5:0:b0:2d6:bb8d:d3ab with SMTP id
 n21-20020a2e82d5000000b002d6bb8dd3abmr1005306ljh.2.1711575406108; Wed, 27 Mar
 2024 14:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240321180219.1039622-1-tharvey@gateworks.com>
 <CAC_iWjLwt9NxwOsYWwx4+w2vL3dtfJnJPH-eeApU-ODKf8tzBA@mail.gmail.com>
 <CAJ+vNU0aSj5RgCUxz74hg059Qtmco4HSBCiAHA_hhw+jzxo5Dw@mail.gmail.com>
 <CAC_iWjJ4s1ZS8X64vjV_xiOSzKf7fPBryw6eGp6tW7Vqxv2_gw@mail.gmail.com>
 <CAJ+vNU1m=joe0mAC2ss-QmBN17Jht4d+fpba4iM0tTScy0Zngg@mail.gmail.com>
 <CAC_iWjL6CtZ5WgASepcUZOXnF=G4uDTeVq3WnOkz+jDL+cLZzw@mail.gmail.com>
 <CAC_iWjJCAj0sv3mdzje4ivn4Ob=tyW38K03GD=mj8_FOvK35AQ@mail.gmail.com>
 <CAJ+vNU2v03MQXBysVxrUQwKeQH4KJjwkHXtmT3g=2f+++jsP5A@mail.gmail.com>
In-Reply-To: <CAJ+vNU2v03MQXBysVxrUQwKeQH4KJjwkHXtmT3g=2f+++jsP5A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Mar 2024 23:36:09 +0200
Message-ID: <CAC_iWjJ1hBrPAom1HaHTG0m+AGnNON+XwVtS6v1z+hJk4f10zA@mail.gmail.com>
Subject: Re: [PATCH] tpm: display message when using gpio-reset instead of
 when missing it
To: Tim Harvey <tharvey@gateworks.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>, 
 Adam Ford <aford173@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 u-boot@lists.denx.de, Samuel Lee <slee@gateworks.com>
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

On Wed, 27 Mar 2024 at 20:47, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Wed, Mar 27, 2024 at 10:26=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > [...]
> >
> > > >
> > > > missing an invalid property?
> > > >
> > > > I deal with users all the time that think things like that are
> > > > 'errors' and contact tech support. In this case its not an error
> > > > because there is no gpio reset in the official dt-bindings for the =
tpm
> > > > and its generally considered bad form to add non official propertie=
s.
> > > >
> > > > And from what your explaining we shouldn't have a GPIO connected to
> > > > the TPM so perhaps we should remove the reset completely and perhap=
s
> > > > even spit out a warning if present:
> > > > ignore Invalid DT property gpio reset to conform with the TCG speci=
fication
> > >
> > > We should, but those changes predate me being appointed as a TPM
> > > maintainer. If I had to guess, I would say that was added for TPM tha=
t
> > > are connected on an external SPI bus (e.g the RPI).
> > > So what about not printing the error message, keeping the code so we
> > > won't break 'test' devices, and print a warning message like "This
> > > shouldn't be used on secure production devices"?
> >
> > Unless we can get a list of the devices that *currently* use it. If
> > they aren't that many I am fine getting rid of the reset overall (and
> > I can test it on the RPI4)
> >
>
> Adding Miquel who authored commit a174f0001f592 ("tpm2: tis_spi: add
> the possibility to reset the chip with a gpio"):
> On some designs, the reset line could not be connected to the SoC reset
> line, in this case, request the GPIO and ensure the chip gets reset.
>
> Adding Jorge who athoried commit cc5afabc9d329 ("drivers: tpm2: update
> reset gpio semantics"):
> Use the more generic reset-gpios property name.
>
> I looked through all dts in U-Boot matching 'tpm' as well as Linux to
> see who's using it:
> Adding Adam who has a 'reset-gpios' in
> arch/arm/dts/imx8mp-beacon-kit.dts (and somehow snuck it in upstream
> as well)
> Adding Rasmus who has a suspicious 'regulatot-tpm0-rst' (but no gpio
> reset in tpm) in arch/arm/dts/imx8mm-cl-iot-gate-ied-tpm0.dtso
>
> As there is at least one board that clearly uses a gpio reset for the
> TPM in the tpm node I think we leave the tpm reset support, eliminate
> the warning if its missing and print a message like "Warning: TPM gpio
> reset should not be used on secure production device"
>
> I'll send a v2 of my patch for review

Thanks. It's a bit unfortunate we ended up with broken devices, but if
we remove the GPIO reset I am pretty sure the side effect will be
having an unusable TPM after warm resets since PCRs will retain the
pre-reboot values...

/Ilias
>
> Best Regards,
>
> Tim
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20240321180219.10396=
22-1-tharvey@gateworks.com/
>
> > Cheers
> > /Ilias
> > >
> > > Regards
> > > /Ilias
> > > >
> > > > Best regards,
> > > >
> > > > Tim
> > > >
> > > > >
> > > > > Thanks
> > > > > /Ilias
> > > > > >
> > > > > > Best Regards,
> > > > > >
> > > > > > Tim
> > > > > > [1] https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-T=
rusted-Platform-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A=
.pdf
> > > > > >
> > > > > >
> > > > > > > Thanks
> > > > > > > /Ilias
> > > > > > > >
> > > > > > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > > > > > ---
> > > > > > > >  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
> > > > > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_=
tis_spi.c
> > > > > > > > index de9cf8f21e07..944540f7a711 100644
> > > > > > > > --- a/drivers/tpm/tpm2_tis_spi.c
> > > > > > > > +++ b/drivers/tpm/tpm2_tis_spi.c
> > > > > > > > @@ -237,14 +237,14 @@ static int tpm_tis_spi_probe(struct u=
device *dev)
> > > > > > > >                         /* legacy reset */
> > > > > > > >                         ret =3D gpio_request_by_name(dev, "=
gpio-reset", 0,
> > > > > > > >                                                    &reset_g=
pio, GPIOD_IS_OUT);
> > > > > > > > -                       if (ret) {
> > > > > > > > -                               log(LOGC_NONE, LOGL_NOTICE,
> > > > > > > > -                                   "%s: missing reset GPIO=
\n", __func__);
> > > > > > > > +                       if (ret)
> > > > > > > >                                 goto init;
> > > > > > > > -                       }
> > > > > > > >                         log(LOGC_NONE, LOGL_NOTICE,
> > > > > > > >                             "%s: gpio-reset is deprecated\n=
", __func__);
> > > > > > > >                 }
> > > > > > > > +               log(LOGC_NONE, LOGL_NOTICE,
> > > > > > > > +                   "%s: performing 1ms reset on %s:%d\n", =
dev->name,
> > > > > > > > +                   reset_gpio.dev->name, reset_gpio.offset=
);
> > > > > > > >                 dm_gpio_set_value(&reset_gpio, 1);
> > > > > > > >                 mdelay(1);
> > > > > > > >                 dm_gpio_set_value(&reset_gpio, 0);
> > > > > > > > --
> > > > > > > > 2.25.1
> > > > > > > >
