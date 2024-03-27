Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19AFC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 15:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54E16880E9;
	Wed, 27 Mar 2024 16:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="NH2YpJ/w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D56F8880E0; Wed, 27 Mar 2024 16:29:06 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD7C880EB
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 16:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-51588f70d2dso8232964e87.3
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 08:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1711553343; x=1712158143; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rzs3WgIjyUN/E0qZlXgwn30M/SIc7+NLbbcpdtoHJB0=;
 b=NH2YpJ/wGpFZpwGoTLhb3/eHdy/1mqP7/QIc8N/w1vJdU70gcOA5Zgp6v305AH39uh
 HWBiYphgWpKY2JXj7sfrK8K4yBEcL9wVsHiiHyb34juc8r5Myr9T2ETHFRBVANaR1Akr
 m0l08W/bNGeGO2X+R/u6FZLlFQ5KGm4E+78yJkMjscNoRM63a5YVjIqUiYVyixu5HJKH
 GBFIYOKUgIth98d+WuFZY8NbIAjiFif7oCKd9nsfgaD5/aiPdOQC5AHJQw0TiwoNaJeM
 XP22Y+WaY0wt4uRVgKr17JbyE4de8hQMsJr4Z2BWzXpqBXSvnI50ZjEe4jPSy7kBKD/g
 eckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711553343; x=1712158143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rzs3WgIjyUN/E0qZlXgwn30M/SIc7+NLbbcpdtoHJB0=;
 b=AQu0W0gGWQL9nXfUPg3u4tqbPTeqSImyOm0U2bd9CA9oJsmuxWY/Sbj4ABVmvjxzbq
 X/jHpvXPCiFQvcR45XTEEyg2uRlUqdb1W04/2Tslf8aNAEpxt0r9dUl+YvXHKBPjxTQ7
 WOCEF6niZCljMNtjAjTgV3m1NDkzC644C/S2GLWXr1wv7RkDKufrUesMVJAuq+Rxl7EK
 tL3WBivkRAUtU3awL4rF3WfycX05R7wCfOw6DFJ6yJkzcrO1nb1P9ixeZH/GcvBz9Xai
 6KzwNoDUIMWFhT6Lk/8SZKoVEjDDKEVCoS84cugtFD5AZU661nb7FplZIXBDovopxWLu
 Xqig==
X-Gm-Message-State: AOJu0YzzYt9QPrDtUnucxF9c0dflocI1iwG3X56vR9O+ni7jLLOog5O/
 w/sCW6h9P55c9LmYmrXvchfe7/1pZ2Nzd0pHSLR/3eGveF87GpkXy80bFVKnHBLpnl7A9oWKxf0
 ny9Y5u0tH3ctHUf+BHmNAS9wW2Q/Tyc48zRDd5CRDgwZFxi6j
X-Google-Smtp-Source: AGHT+IEnNiw9CsNkMoFXBVki07+NiHKqgj2/Q7XKmHCjl0io49AoYhwqAuWOYalB1VYb8Evltw9quQOjYvyuhdM3rPA=
X-Received: by 2002:ac2:593a:0:b0:513:a39e:ae45 with SMTP id
 v26-20020ac2593a000000b00513a39eae45mr3352052lfi.62.1711553343114; Wed, 27
 Mar 2024 08:29:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240321180219.1039622-1-tharvey@gateworks.com>
 <CAC_iWjLwt9NxwOsYWwx4+w2vL3dtfJnJPH-eeApU-ODKf8tzBA@mail.gmail.com>
In-Reply-To: <CAC_iWjLwt9NxwOsYWwx4+w2vL3dtfJnJPH-eeApU-ODKf8tzBA@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 27 Mar 2024 08:28:51 -0700
Message-ID: <CAJ+vNU0aSj5RgCUxz74hg059Qtmco4HSBCiAHA_hhw+jzxo5Dw@mail.gmail.com>
Subject: Re: [PATCH] tpm: display message when using gpio-reset instead of
 when missing it
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Wed, Mar 27, 2024 at 7:44=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tim,
>
> On Thu, 21 Mar 2024 at 20:02, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > Instead of displaying what looks like an error message if a
> > gpio-reset dt prop is missing for a TPM dipslay a more
> > informative message about resetting the TPM if the gpio is found:
> >
> > before:
> > tpm_tis_spi_probe: missing reset GPIO
> >
> > after:
> > tpm@0: performing 1ms reset on gpio@30210000:12
> >
> > Note that the reset dt binding prop used in this driver is not
> > dt-compliant; it does not exist in the Linux dt-bindings documentation
> > and the reset is not done by the Linux driver.
>
> Probably for a good reason. You aren't supposed to be able to reset a
> TPM without resetting the CPUI as well no?

Hi Ilias,

Could you clarify what you know about TPM reset? We use the ATTPM20P
[1] which states in the datasheet under the reset pin: "To be
compliant with TCG requirements, this pin needs to be tied to system
reset. TPM_Init is indicated by asserting this pin."

Our boards have a resistor loading option which routes the TPM RST# to
an SoC GPIO or alternately to a POR# (hardware power on reset provided
by power supply and/or PMIC). Could you point me to where in the spec
it explains what the TPM reset should be connected to?

> That being said, printing that the TPM was reset is pointless imho.
> OTOH the existing error message at least points out a potential
> problem in the DT.
>

I'm not sure if you are NAK'ing this patch or asking me to change it.

Displaying a 'missing GPIO' message is not helpful when there is no
GPIO in the dt bindings to begin with.

Best Regards,

Tim
[1] https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Platf=
orm-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf


> Thanks
> /Ilias
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> > index de9cf8f21e07..944540f7a711 100644
> > --- a/drivers/tpm/tpm2_tis_spi.c
> > +++ b/drivers/tpm/tpm2_tis_spi.c
> > @@ -237,14 +237,14 @@ static int tpm_tis_spi_probe(struct udevice *dev)
> >                         /* legacy reset */
> >                         ret =3D gpio_request_by_name(dev, "gpio-reset",=
 0,
> >                                                    &reset_gpio, GPIOD_I=
S_OUT);
> > -                       if (ret) {
> > -                               log(LOGC_NONE, LOGL_NOTICE,
> > -                                   "%s: missing reset GPIO\n", __func_=
_);
> > +                       if (ret)
> >                                 goto init;
> > -                       }
> >                         log(LOGC_NONE, LOGL_NOTICE,
> >                             "%s: gpio-reset is deprecated\n", __func__)=
;
> >                 }
> > +               log(LOGC_NONE, LOGL_NOTICE,
> > +                   "%s: performing 1ms reset on %s:%d\n", dev->name,
> > +                   reset_gpio.dev->name, reset_gpio.offset);
> >                 dm_gpio_set_value(&reset_gpio, 1);
> >                 mdelay(1);
> >                 dm_gpio_set_value(&reset_gpio, 0);
> > --
> > 2.25.1
> >
