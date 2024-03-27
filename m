Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEB9C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 16:49:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C8DF8801A;
	Wed, 27 Mar 2024 17:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="AkhOwpia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5520E8803F; Wed, 27 Mar 2024 17:49:17 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2005787F95
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 17:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a45f257b81fso3531666b.0
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1711558154; x=1712162954; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=706fLSqcRdQFewuvYOZn+i5CkJ/8t/BYRh5jekZJ8Qs=;
 b=AkhOwpia1n4WqDD9vIQIreYHgg54GXtVMGRmPlS4Q2z3zO6UYpHN8wETqD1r+CcK2M
 sQRvHLDekSG7G0vuz48cwyHIUN9BVpYlHq0qehdXU9yhT8WwwMepUOgo/qC2x4M1mqdj
 rirOpQkv+YG5Y3JhrEgEuxXpmxtIYjTKzvZUuK10o8EFQQHaOJV5FFcXm6B1jErJgPv+
 +qgGzkqnDWbqEQ9aDBVWxj9iICt2Y3NNcX17nYNggWAF/cs/WHzaj/WBv3ZfZDfbfmMx
 X7Rn08/KJcbNTmOwmM9891RsNwwqlX1J5E1AmBSK20BcbSMNivCAQYUn4bZkrbkmmhEj
 JUSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711558154; x=1712162954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=706fLSqcRdQFewuvYOZn+i5CkJ/8t/BYRh5jekZJ8Qs=;
 b=PufXxUw/rb3qTKPYNxj0coSM+uTYjPj1HO3+KEpxYqNfvhSp946qREvkfj21pp6fD+
 PTR0Vs8tCHIP/DjY5PzTbzq8rzmAJwoX+v3IerM+PAI3fhG5cSkSzIVvbG9xw0nKJJyc
 2XPR1Ta3J63ns/yIWdOZTSgIKjmqY4H0vKlZ4qZ/ck+OT7wCzJbBgv3WuCmorpSYBk0c
 qkJdTztqG38K4q5muO1DpaKwBTutbX91ssNqMtCnBPaYEPLsIJWmbf4BT2TRD9F0iq0j
 6sEMKJSiRXwu6z7TpfWgKC0Zr6X1sIDBYzmZFE7yp4/RchR1/nYspuHpUAAl/GcLYftZ
 suhA==
X-Gm-Message-State: AOJu0YxhnUJTTLCVlWz2AGq0o8aYdnzplkB+AgPyc1pU8R1kTKXxoy1s
 lQonPJvXFv0t0WveLTHJQPZEMkf7OKiMCsCRw/4ITJ+EPYrJE1IkfYMQHvyPU5MrkQQexG+XAyV
 bJguh3yemLPdSJQ/p8iu3ABCvRZeBS+DgxwLLDg==
X-Google-Smtp-Source: AGHT+IGkVCnt2Go10NL0N2yjH5LzY1S9xDHVFGmJKSE/IhGIkxYT4du+CrnQAms9o1NOinCGCq66ukRGDLJVm+R4jFE=
X-Received: by 2002:a17:906:dfd6:b0:a47:3775:2a41 with SMTP id
 jt22-20020a170906dfd600b00a4737752a41mr45830ejc.2.1711558154465; Wed, 27 Mar
 2024 09:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240321180219.1039622-1-tharvey@gateworks.com>
 <CAC_iWjLwt9NxwOsYWwx4+w2vL3dtfJnJPH-eeApU-ODKf8tzBA@mail.gmail.com>
 <CAJ+vNU0aSj5RgCUxz74hg059Qtmco4HSBCiAHA_hhw+jzxo5Dw@mail.gmail.com>
 <CAC_iWjJ4s1ZS8X64vjV_xiOSzKf7fPBryw6eGp6tW7Vqxv2_gw@mail.gmail.com>
In-Reply-To: <CAC_iWjJ4s1ZS8X64vjV_xiOSzKf7fPBryw6eGp6tW7Vqxv2_gw@mail.gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Wed, 27 Mar 2024 09:49:02 -0700
Message-ID: <CAJ+vNU1m=joe0mAC2ss-QmBN17Jht4d+fpba4iM0tTScy0Zngg@mail.gmail.com>
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

On Wed, Mar 27, 2024 at 9:16=E2=80=AFAM Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Tim,
>
> On Wed, 27 Mar 2024 at 17:29, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > On Wed, Mar 27, 2024 at 7:44=E2=80=AFAM Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Tim,
> > >
> > > On Thu, 21 Mar 2024 at 20:02, Tim Harvey <tharvey@gateworks.com> wrot=
e:
> > > >
> > > > Instead of displaying what looks like an error message if a
> > > > gpio-reset dt prop is missing for a TPM dipslay a more
> > > > informative message about resetting the TPM if the gpio is found:
> > > >
> > > > before:
> > > > tpm_tis_spi_probe: missing reset GPIO
> > > >
> > > > after:
> > > > tpm@0: performing 1ms reset on gpio@30210000:12
> > > >
> > > > Note that the reset dt binding prop used in this driver is not
> > > > dt-compliant; it does not exist in the Linux dt-bindings documentat=
ion
> > > > and the reset is not done by the Linux driver.
> > >
> > > Probably for a good reason. You aren't supposed to be able to reset a
> > > TPM without resetting the CPUI as well no?
> >
> > Hi Ilias,
> >
> > Could you clarify what you know about TPM reset? We use the ATTPM20P
> > [1] which states in the datasheet under the reset pin: "To be
> > compliant with TCG requirements, this pin needs to be tied to system
> > reset. TPM_Init is indicated by asserting this pin."
>
> In short, you shouldn't be able to toggle a GPIO and reset the TPM
> without resetting the CPU as well.
> An attacker could boot -> log into the OS -> reset the TPM -> replay
> measurements and unseal keys that he shouldn't.

I suppose that makes sense. So consider someone gets into your OS and
also has access to your board and electrically isolates the TPM reset
from POR# (cut the trace) then with a probe resets the TPM? At least
in that case they have to have physical presence as well so we should
connect TPM RST# to POR# to not make it easier on them.

I'm always wanting to allow GPIO access to various chip resets to deal
with issues discovered down the line that require a full chip level
reset - probably not the right thing to do in the case of a security
device!

Thanks for explaining.

I'm still learning about the TPM capabilities. If using the TPM to
store a key that is used for FDE you can use 'tpm2_unseal -c $OBJECT
-p pcr:sha1:0,1 -o fs.key' to get your key. There must be a concept of
re-sealing this object so that it can only be unsealed again with a
power cycle or something?

>
> >
> > Our boards have a resistor loading option which routes the TPM RST# to
> > an SoC GPIO or alternately to a POR# (hardware power on reset provided
> > by power supply and/or PMIC). Could you point me to where in the spec
> > it explains what the TPM reset should be connected to?
>
> I am aware of the the TCG TIS spec [0] which says
> "The TPM_Init (LRESET#/SPI_RST#) signal MUST be connected to the platform=
 CPU
> Reset signal such that it complies with the requirements specified in
> section 1.2.7 HOST
> Platform Reset in the PC Client Implementation Specification for
> Conventional BIOS."
> There might be other TCG specs defining this as well.
>
> [0] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTPMI=
nterfaceSpecification_TIS__1-3_27_03212013.pdf
>

Thanks!

> >
> > > That being said, printing that the TPM was reset is pointless imho.
> > > OTOH the existing error message at least points out a potential
> > > problem in the DT.
> > >
> >
> > I'm not sure if you are NAK'ing this patch or asking me to change it.
> >
> > Displaying a 'missing GPIO' message is not helpful when there is no
> > GPIO in the dt bindings to begin with.
>
> I am not NAKing it. But isn't that message more useful than printing
> the TPM did a reset? At least you get a hint of something that's
> missing from your DT

missing an invalid property?

I deal with users all the time that think things like that are
'errors' and contact tech support. In this case its not an error
because there is no gpio reset in the official dt-bindings for the tpm
and its generally considered bad form to add non official properties.

And from what your explaining we shouldn't have a GPIO connected to
the TPM so perhaps we should remove the reset completely and perhaps
even spit out a warning if present:
ignore Invalid DT property gpio reset to conform with the TCG specificaiton

Best regards,

Tim

>
> Thanks
> /Ilias
> >
> > Best Regards,
> >
> > Tim
> > [1] https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-P=
latform-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf
> >
> >
> > > Thanks
> > > /Ilias
> > > >
> > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > ---
> > > >  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.=
c
> > > > index de9cf8f21e07..944540f7a711 100644
> > > > --- a/drivers/tpm/tpm2_tis_spi.c
> > > > +++ b/drivers/tpm/tpm2_tis_spi.c
> > > > @@ -237,14 +237,14 @@ static int tpm_tis_spi_probe(struct udevice *=
dev)
> > > >                         /* legacy reset */
> > > >                         ret =3D gpio_request_by_name(dev, "gpio-res=
et", 0,
> > > >                                                    &reset_gpio, GPI=
OD_IS_OUT);
> > > > -                       if (ret) {
> > > > -                               log(LOGC_NONE, LOGL_NOTICE,
> > > > -                                   "%s: missing reset GPIO\n", __f=
unc__);
> > > > +                       if (ret)
> > > >                                 goto init;
> > > > -                       }
> > > >                         log(LOGC_NONE, LOGL_NOTICE,
> > > >                             "%s: gpio-reset is deprecated\n", __fun=
c__);
> > > >                 }
> > > > +               log(LOGC_NONE, LOGL_NOTICE,
> > > > +                   "%s: performing 1ms reset on %s:%d\n", dev->nam=
e,
> > > > +                   reset_gpio.dev->name, reset_gpio.offset);
> > > >                 dm_gpio_set_value(&reset_gpio, 1);
> > > >                 mdelay(1);
> > > >                 dm_gpio_set_value(&reset_gpio, 0);
> > > > --
> > > > 2.25.1
> > > >
