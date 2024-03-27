Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713CEC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 16:16:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E64CE8800C;
	Wed, 27 Mar 2024 17:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tE7x/ox8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B83E8801A; Wed, 27 Mar 2024 17:16:23 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76D0A87F95
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51381021af1so10737896e87.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 09:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711556180; x=1712160980; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oiFnUyqRvBeQhRhgTpOXfZdE5xwpnuMgbEwVsBQrhQk=;
 b=tE7x/ox8bj1oHGzZ/yueGdJXvSm6YXILKzS1rqk8a4Lz7kYBfmvn1fgKUtSVv7mxwu
 agcE6Qbm6k5/NLYDH0l0MP8iI9P/jljD+8jXiVT5/tTvbIHmFyE73O14vvPX1bO77Lsn
 R1h1T6zJ5E67n672Vfl9NzelW1YUMkWKJHnPmE0to5LKQTEUF2GdYp1SDiUy33tNdUfQ
 /95uZosOv+WPskPocxFBrjhbdPF31Q2rXUJlgaXiaWxaj2Ggn/fa886yqSnsAQWcuLlq
 VJfb1UlmmnOnQwJh2Je1ecbkfkFoTiBjiBRea//vJkdcAy4q5Rg6lMl1C7qnXi40UMAp
 JXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711556180; x=1712160980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oiFnUyqRvBeQhRhgTpOXfZdE5xwpnuMgbEwVsBQrhQk=;
 b=oJVQXC4qQ27DUGQ80pCsOKLl1UVwibfPYEjkDZFnvzNm0d2gsO2S9qZuvQn17w4l0H
 4C9nQfMv3kuAHKBBD/rrx3uffbmA8f9sAcPopMLnF034LKmrQz29gHjtOqjuxP0Q5eek
 M45aX8DSayyIQsXi3gc/EgxBitGTjEKfMfD/iNd+UTNyQzE4uOQbEgGabjW/rnXRu/XF
 N8RPZp4tiNWGT4JKYoGVeU4MQI4f8KCerj1zeiR3e0X7bMlqtoxc2nv5Vf6ZFNGtNjYk
 +66dbSxQDciiHmwVKOJUTxYZjZwFf/0Ih4+hbX/5bN6RQygL91CmySu8A6gP6t6P2N/B
 laqg==
X-Gm-Message-State: AOJu0YzQxIR6GbP2NLWdnYDfnmx7GmxMYaDobR+OU7/Ac+ImK8H/69EF
 YNL9JbBctdlBIB2X7oqeVL5kdAUsm8YoA6vhRES/+0ssrCUg6SGPciwPAE6PdrI4kdkismbi9D+
 Aqk0DlYbns0YyfulRMsTNH5JPIfkg93ktoWdOEy2qfa0aWqHgEsQ=
X-Google-Smtp-Source: AGHT+IHG7egLRgBcgLGOdbaiF5yiawNgedt1xWGYA+bwN9Q8D2xm4RN/sjqCo6n75lFQwNlkNQBGomBzZ961mYrU6Hg=
X-Received: by 2002:a2e:8010:0:b0:2d4:a20f:299f with SMTP id
 j16-20020a2e8010000000b002d4a20f299fmr484382ljg.35.1711556179621; Wed, 27 Mar
 2024 09:16:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240321180219.1039622-1-tharvey@gateworks.com>
 <CAC_iWjLwt9NxwOsYWwx4+w2vL3dtfJnJPH-eeApU-ODKf8tzBA@mail.gmail.com>
 <CAJ+vNU0aSj5RgCUxz74hg059Qtmco4HSBCiAHA_hhw+jzxo5Dw@mail.gmail.com>
In-Reply-To: <CAJ+vNU0aSj5RgCUxz74hg059Qtmco4HSBCiAHA_hhw+jzxo5Dw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Mar 2024 18:15:43 +0200
Message-ID: <CAC_iWjJ4s1ZS8X64vjV_xiOSzKf7fPBryw6eGp6tW7Vqxv2_gw@mail.gmail.com>
Subject: Re: [PATCH] tpm: display message when using gpio-reset instead of
 when missing it
To: Tim Harvey <tharvey@gateworks.com>
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

Hi Tim,

On Wed, 27 Mar 2024 at 17:29, Tim Harvey <tharvey@gateworks.com> wrote:
>
> On Wed, Mar 27, 2024 at 7:44=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Tim,
> >
> > On Thu, 21 Mar 2024 at 20:02, Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > Instead of displaying what looks like an error message if a
> > > gpio-reset dt prop is missing for a TPM dipslay a more
> > > informative message about resetting the TPM if the gpio is found:
> > >
> > > before:
> > > tpm_tis_spi_probe: missing reset GPIO
> > >
> > > after:
> > > tpm@0: performing 1ms reset on gpio@30210000:12
> > >
> > > Note that the reset dt binding prop used in this driver is not
> > > dt-compliant; it does not exist in the Linux dt-bindings documentatio=
n
> > > and the reset is not done by the Linux driver.
> >
> > Probably for a good reason. You aren't supposed to be able to reset a
> > TPM without resetting the CPUI as well no?
>
> Hi Ilias,
>
> Could you clarify what you know about TPM reset? We use the ATTPM20P
> [1] which states in the datasheet under the reset pin: "To be
> compliant with TCG requirements, this pin needs to be tied to system
> reset. TPM_Init is indicated by asserting this pin."

In short, you shouldn't be able to toggle a GPIO and reset the TPM
without resetting the CPU as well.
An attacker could boot -> log into the OS -> reset the TPM -> replay
measurements and unseal keys that he shouldn't.

>
> Our boards have a resistor loading option which routes the TPM RST# to
> an SoC GPIO or alternately to a POR# (hardware power on reset provided
> by power supply and/or PMIC). Could you point me to where in the spec
> it explains what the TPM reset should be connected to?

I am aware of the the TCG TIS spec [0] which says
"The TPM_Init (LRESET#/SPI_RST#) signal MUST be connected to the platform C=
PU
Reset signal such that it complies with the requirements specified in
section 1.2.7 HOST
Platform Reset in the PC Client Implementation Specification for
Conventional BIOS."
There might be other TCG specs defining this as well.

[0] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTPMInt=
erfaceSpecification_TIS__1-3_27_03212013.pdf

>
> > That being said, printing that the TPM was reset is pointless imho.
> > OTOH the existing error message at least points out a potential
> > problem in the DT.
> >
>
> I'm not sure if you are NAK'ing this patch or asking me to change it.
>
> Displaying a 'missing GPIO' message is not helpful when there is no
> GPIO in the dt bindings to begin with.

I am not NAKing it. But isn't that message more useful than printing
the TPM did a reset? At least you get a hint of something that's
missing from your DT

Thanks
/Ilias
>
> Best Regards,
>
> Tim
> [1] https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Pla=
tform-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf
>
>
> > Thanks
> > /Ilias
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > >  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> > > index de9cf8f21e07..944540f7a711 100644
> > > --- a/drivers/tpm/tpm2_tis_spi.c
> > > +++ b/drivers/tpm/tpm2_tis_spi.c
> > > @@ -237,14 +237,14 @@ static int tpm_tis_spi_probe(struct udevice *de=
v)
> > >                         /* legacy reset */
> > >                         ret =3D gpio_request_by_name(dev, "gpio-reset=
", 0,
> > >                                                    &reset_gpio, GPIOD=
_IS_OUT);
> > > -                       if (ret) {
> > > -                               log(LOGC_NONE, LOGL_NOTICE,
> > > -                                   "%s: missing reset GPIO\n", __fun=
c__);
> > > +                       if (ret)
> > >                                 goto init;
> > > -                       }
> > >                         log(LOGC_NONE, LOGL_NOTICE,
> > >                             "%s: gpio-reset is deprecated\n", __func_=
_);
> > >                 }
> > > +               log(LOGC_NONE, LOGL_NOTICE,
> > > +                   "%s: performing 1ms reset on %s:%d\n", dev->name,
> > > +                   reset_gpio.dev->name, reset_gpio.offset);
> > >                 dm_gpio_set_value(&reset_gpio, 1);
> > >                 mdelay(1);
> > >                 dm_gpio_set_value(&reset_gpio, 0);
> > > --
> > > 2.25.1
> > >
