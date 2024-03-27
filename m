Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 817B9C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 17:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E996B87F95;
	Wed, 27 Mar 2024 18:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E/AJwDKq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8E7B8808F; Wed, 27 Mar 2024 18:26:40 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E9D587F4F
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 18:26:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d700beb6beso6826581fa.2
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711560398; x=1712165198; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dbF04J4/M78c5KzNZ6kwC2EjNouVYrcFQ1amhWPe8og=;
 b=E/AJwDKqNrBcTWcgzol/U8ZFOlo3DZg3iMdiUnRRlf4Ue8ad64X+BlIBIc4S8b/BNK
 G3nqaWInczZCUEU5Xmx4cG9ZVAJcSj+lpsO8t5XpTXs5Hb90H2XQJf5uA5AuF4rogwdR
 i44x9IevHszx4k7ZbP7ANl3OBpX+ikvng0fqrLC5F2Kk4E8mZtcgjcbknj0igUAYaEEW
 fGYjlxyW8l4xgpHJzhJXC6lVBngbZtM3FNwbp4hvjhT7iwuCOcGPGmVthe1yssb8TL+E
 Rkgj0OrCu1YsWxQ5a70JP/g8m14k+buV9r/ntgXpX/e0EYHqltuN1vLy6R0cVBVf39bC
 CpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711560398; x=1712165198;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dbF04J4/M78c5KzNZ6kwC2EjNouVYrcFQ1amhWPe8og=;
 b=GqwQkaAhaZzxys4KGM0THFGQwMDHJkyDtnyi/39pdNCS7Ku+5Ciwi0gxkBZANSerWk
 lMraQScOvz9HLSYB/aKuhJU7li7ZIVIJrxGB9rRP8Yz07Sb7VIn4M3RcJNPUZs3e5bDU
 WwyymEfI3bn6lRtd94e5QyxPZ8wJVz1hTZvr8A3X/jhVFHzsOwuOiwyg3Cvp91lAaahG
 FMm93nDuwxrr+XkOI92WvMF/+bDVFSqFXQB3X9Ae+7TYWnBcpdaGK7uIzH19GQumUh8V
 bsPJnRmmn7UmGUa22/lfLD4SmXqHqjpxCbUXyh4kx4O8+bqgwr/dqhwd+ntndKHfKxnk
 cKhA==
X-Gm-Message-State: AOJu0YxR01ggGktXuBfx01OgA5V7uGngRk5xm7SDo6x3MT7dZJ62VlH9
 t3JIDvMp9BqCKuHvD+KxVPNuGakSU9JQXGFQrAZF1zv3fremYmBAXc8IYQ3nyVzGLWn2Hwz9FLa
 I/Y4SsCYKBhkBjHFxQTSfReZ8F3o7zOXwG8HOIEApMXE2dqzX
X-Google-Smtp-Source: AGHT+IEQoQA1ZleLhORnfDI9sCc1mau22B0VumFWddwjSNHzNI2KWBun7GN1onD6hDViMm9YBtJ2y5kvMDbxjMEw/tQ=
X-Received: by 2002:a2e:98d7:0:b0:2d4:7003:fc6c with SMTP id
 s23-20020a2e98d7000000b002d47003fc6cmr492461ljj.10.1711560397820; Wed, 27 Mar
 2024 10:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240321180219.1039622-1-tharvey@gateworks.com>
 <CAC_iWjLwt9NxwOsYWwx4+w2vL3dtfJnJPH-eeApU-ODKf8tzBA@mail.gmail.com>
 <CAJ+vNU0aSj5RgCUxz74hg059Qtmco4HSBCiAHA_hhw+jzxo5Dw@mail.gmail.com>
 <CAC_iWjJ4s1ZS8X64vjV_xiOSzKf7fPBryw6eGp6tW7Vqxv2_gw@mail.gmail.com>
 <CAJ+vNU1m=joe0mAC2ss-QmBN17Jht4d+fpba4iM0tTScy0Zngg@mail.gmail.com>
 <CAC_iWjL6CtZ5WgASepcUZOXnF=G4uDTeVq3WnOkz+jDL+cLZzw@mail.gmail.com>
In-Reply-To: <CAC_iWjL6CtZ5WgASepcUZOXnF=G4uDTeVq3WnOkz+jDL+cLZzw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Mar 2024 19:26:01 +0200
Message-ID: <CAC_iWjJCAj0sv3mdzje4ivn4Ob=tyW38K03GD=mj8_FOvK35AQ@mail.gmail.com>
Subject: Re: [PATCH] tpm: display message when using gpio-reset instead of
 when missing it
To: Tim Harvey <tharvey@gateworks.com>
Cc: u-boot@lists.denx.de, Samuel Lee <slee@gateworks.com>
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

[...]

> >
> > missing an invalid property?
> >
> > I deal with users all the time that think things like that are
> > 'errors' and contact tech support. In this case its not an error
> > because there is no gpio reset in the official dt-bindings for the tpm
> > and its generally considered bad form to add non official properties.
> >
> > And from what your explaining we shouldn't have a GPIO connected to
> > the TPM so perhaps we should remove the reset completely and perhaps
> > even spit out a warning if present:
> > ignore Invalid DT property gpio reset to conform with the TCG specification
>
> We should, but those changes predate me being appointed as a TPM
> maintainer. If I had to guess, I would say that was added for TPM that
> are connected on an external SPI bus (e.g the RPI).
> So what about not printing the error message, keeping the code so we
> won't break 'test' devices, and print a warning message like "This
> shouldn't be used on secure production devices"?

Unless we can get a list of the devices that *currently* use it. If
they aren't that many I am fine getting rid of the reset overall (and
I can test it on the RPI4)

Cheers
/Ilias
>
> Regards
> /Ilias
> >
> > Best regards,
> >
> > Tim
> >
> > >
> > > Thanks
> > > /Ilias
> > > >
> > > > Best Regards,
> > > >
> > > > Tim
> > > > [1] https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Platform-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf
> > > >
> > > >
> > > > > Thanks
> > > > > /Ilias
> > > > > >
> > > > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > > > ---
> > > > > >  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
> > > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> > > > > > index de9cf8f21e07..944540f7a711 100644
> > > > > > --- a/drivers/tpm/tpm2_tis_spi.c
> > > > > > +++ b/drivers/tpm/tpm2_tis_spi.c
> > > > > > @@ -237,14 +237,14 @@ static int tpm_tis_spi_probe(struct udevice *dev)
> > > > > >                         /* legacy reset */
> > > > > >                         ret = gpio_request_by_name(dev, "gpio-reset", 0,
> > > > > >                                                    &reset_gpio, GPIOD_IS_OUT);
> > > > > > -                       if (ret) {
> > > > > > -                               log(LOGC_NONE, LOGL_NOTICE,
> > > > > > -                                   "%s: missing reset GPIO\n", __func__);
> > > > > > +                       if (ret)
> > > > > >                                 goto init;
> > > > > > -                       }
> > > > > >                         log(LOGC_NONE, LOGL_NOTICE,
> > > > > >                             "%s: gpio-reset is deprecated\n", __func__);
> > > > > >                 }
> > > > > > +               log(LOGC_NONE, LOGL_NOTICE,
> > > > > > +                   "%s: performing 1ms reset on %s:%d\n", dev->name,
> > > > > > +                   reset_gpio.dev->name, reset_gpio.offset);
> > > > > >                 dm_gpio_set_value(&reset_gpio, 1);
> > > > > >                 mdelay(1);
> > > > > >                 dm_gpio_set_value(&reset_gpio, 0);
> > > > > > --
> > > > > > 2.25.1
> > > > > >
