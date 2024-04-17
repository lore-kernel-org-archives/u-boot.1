Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C0CC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 05:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D77CA8842B;
	Wed, 17 Apr 2024 07:40:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="juY9Vk2N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C310F8842B; Wed, 17 Apr 2024 07:40:53 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE3088346
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 07:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d895e2c6efso66570381fa.0
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 22:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713332450; x=1713937250; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6KIgNvFN1TyeCpMByiXhB8M6ToNIpe9ahCGsFQZ79uE=;
 b=juY9Vk2NHW23M38UO7GYGFO6B9gTqk8R1n+rh4eCtpvx7remkOGIxnbLOyKj8CvoOY
 IKH2i+MWlEqgYt5148bHjBpwlYi1nS8z7inmjF/petfU7hLVfaTAULtKjdtQiWQwNr3u
 dbYcLF0JQNpktg9Ph7IWI09nYob5g6JG4cCPNWdtIy+R8syoyagtEqVdTsoMqemlMbnt
 e2CfpvIIaUMa4kS0Bzw6IPZkDFF8m25pTuw1R9qyfV14eWWQisSXl2qTNZMlu5X1FDay
 fzPvF6pavOiivbKp9kJ+onLAC2GbKFFlIz4opOfHLA0Cfq71sbnn1ILnSrLyQNRJ0gqu
 /81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713332450; x=1713937250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KIgNvFN1TyeCpMByiXhB8M6ToNIpe9ahCGsFQZ79uE=;
 b=eexAXnzJ6dFm7qbwU4yVuj1I6linkbWYqs0byapqoW/6K9DNp7NBzjXwQOEiQ1NOsf
 B88A+Sf2xJJxuoEx16SWHt/yGRiMYvV7F1cBwN0xZTTNFzsl/KcaeVRzZpi8L8EXOWT7
 cBTzICIwLLt3Ww1wfUbKVLWh5IEvM52K2cNuoP58TJg+fBE4JJYY6kJPV8UyN4xESO02
 mNcQxhqoGjhZiP5ufjrR+9Y06k1f/9p45jZYViZMeQgPyZJIn3jggnmCaom8yMXbyR73
 ZiYa1Vdz3BJZ5+66HIoc6pr6RBYsJPZxOoUvgP3gwonYg/aDtcRADs1tV+b69Itd3WGo
 t+4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8e27L4xInq9TbCLFAPgjIB0g72MMS4ce6BQp3eH2SbdJP5+07mzv6CJCQI3rDdRN4IboyesNbcF0DAtEBxq3uPsY+2Q==
X-Gm-Message-State: AOJu0YyMQfneUONK1IZoGOJSm/anBh8B05qE2C456/9T22jXFpyMbLMd
 HXcHPPy934rB1yKTyDLLyMu9WUBbqaBIA2cKInTv4+2Ae8n53bdt5DTCvD4Y4laSx7uT7xZ2w74
 drCoUQSzxkoW05bWssOmETaACGyaNT94SFh/vmA==
X-Google-Smtp-Source: AGHT+IF63uj+WRDUetpFgxusdN36/VsYtm9kEZj5bWqkvvnVK6w/hpQjaumsgI7tSM+2RcR0yA8kTWJ0KbXYbSrQzaw=
X-Received: by 2002:a2e:9e08:0:b0:2d9:fbac:dbee with SMTP id
 e8-20020a2e9e08000000b002d9fbacdbeemr8424469ljk.31.1713332450557; Tue, 16 Apr
 2024 22:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240327221205.1871317-1-tharvey@gateworks.com>
 <CAC_iWjKFHnnFf1iHdH2xmSDZQi2D6iNxkO6dWWMhf+X1cDd7qQ@mail.gmail.com>
 <20240408092320.086ea1f1@xps-13>
In-Reply-To: <20240408092320.086ea1f1@xps-13>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 17 Apr 2024 08:40:14 +0300
Message-ID: <CAC_iWj+DwGznVGX9BK0MRfdYaf0-XpqKNOQheJzJ340cV_-jGg@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: display warning if using gpio reset with TPM
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
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

Hi Miquel

On Mon, 8 Apr 2024 at 10:23, Miquel Raynal <miquel.raynal@bootlin.com> wrot=
e:
>
> Hello,
>
> ilias.apalodimas@linaro.org wrote on Thu, 28 Mar 2024 09:08:37 +0200:
>
> > Thanks Tim
> >
> > On Thu, 28 Mar 2024 at 00:12, Tim Harvey <tharvey@gateworks.com> wrote:
> > >
> > > Instead of displaying what looks like an error message if a
> > > gpio-reset dt prop is missing for a TPM display a warning that
> > > having a gpio reset on a TPM should not be used for a secure producti=
on
> > > device.
> > >
> > > TCG TIS spec [1] says:
> > > "The TPM_Init (LRESET#/SPI_RST#) signal MUST be connected to the
> > > platform CPU Reset signal such that it complies with the requirements
> > > specified in section 1.2.7 HOST Platform Reset in the PC Client
> > > Implementation Specification for Conventional BIOS."
> > >
> > > The reasoning is that you should not be able to toggle a GPIO and res=
et
> > > the TPM without resetting the CPU as well because if an attacker can
> > > break into your OS via an OS level security flaw they can then reset =
the
> > > TPM via GPIO and replay the measurements required to unseal keys
> > > that you have otherwise protected.
> > >
> > > [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClient=
TPMInterfaceSpecification_TIS__1-3_27_03212013.pdf
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > ---
> > > v2: change the message to a warning and update commit desc/log
> > > ---
> > >  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> > > index de9cf8f21e07..c9c83f6f0fc8 100644
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
> > > +               log(LOGC_NONE, LOGL_WARNING,
> > > +                   "%s: TPM gpio reset should not be used on secure =
production devices\n",
> > > +                   dev->name);
> > >                 dm_gpio_set_value(&reset_gpio, 1);
> > >                 mdelay(1);
> > >                 dm_gpio_set_value(&reset_gpio, 0);
>
> The current logic expects a reset gpio and bails out if it cannot get
> it with a (questionable) goto statement.
>
> You want to invert that logic, and expect no gpio, but only if there is
> one you want to warn.
>
> This is perfectly fine but the logic here must be clarified. I'd go for:
>
> ret =3D gpio_request()
> if (ret) {
>         ret =3D gpio_request()
>         if (!ret)
>                 warn(deprecated)
> }
>
> if (!ret) {
>         warn(dangerous)
>         toggle_value()
> }
>
> I would ideally replace the 'if (ret)' clauses with 'if (!reset_gpio)'
> which would make the checks even clearer.

Fair enough. But the code with the proposed change has no functional
problems right?
If so I'll send a PR to Tom as is and rework it as suggested later

Thanks
/Ilias
>
> Thanks,
> Miqu=C3=A8l
