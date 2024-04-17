Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810B7C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 07:01:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCEA488433;
	Wed, 17 Apr 2024 09:01:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UVTgXBis";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C7F888431; Wed, 17 Apr 2024 09:01:09 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DC4D88440
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 09:01:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-516d1c8dc79so6708316e87.1
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 00:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713337265; x=1713942065; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aA6wDvvJOy3LNxnqobDWShrs7DYWtGExsvxw1X6MxOU=;
 b=UVTgXBisNTJKJMFTE+mnnXOZpFcwKTU8cCXIYmbQNbQPx20gAtBc/zTpo5DZLvsnSk
 IoiHXdi1hrjrUH+sW2j3TbURXCzZjjCnwkfwGcRfxw42255c2g+hvVTwypjr94wRhFB+
 XrEZaBW88/NaTKdayCl5hKji1LU+edjx+ZnjhejIUYra9T4Egw5Im6kUI6N5KsH0GtZz
 bZI6eaD8mka4QxfQS26X7nMDH5npbwT94dJ/HVfjl384bW6EQRg/wf8T6nDGDfNTIYvH
 swedSkUHG9JoStCf2NWxVPCsmiW2RQoCxnr8qpgB6nDSfPhqVguKqlpiGHj6G1J1ld2k
 kNyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713337265; x=1713942065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aA6wDvvJOy3LNxnqobDWShrs7DYWtGExsvxw1X6MxOU=;
 b=dcReANCZ83PUu713JCDD7iRt/H912Zgt/WayrBJTqMEyy4V8IMmWSMtSgpGNLeLsTg
 Zjs7A1t9/3zGWaONnw2ShSXFfXImJAwIXkSqjFxyy0E0SWV8ItD76ysj4A2/VDhkZ0l8
 htalcgq60MomC0+qTGxmB7kJdVuRnO6kyLTbkkVYzVUPLsJqNkS9YwBkikPi+9MIod/x
 /GsPQRronoaOhQG8nrD4EjhZvYzTypCyzTiajailUNKscdEMqk/uJJp8MwuwCtVd1zIN
 kMMrYnuYqDZuiMr6WMB6j9XPHACiibiV/PVs9OW63cBl2/esVyoYuOJ9BeqIHpKCO8lG
 k+rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCPslrLVxzgDCqKzBtr+u5dj8KHjwdu4SOyw46bWi+OsMHl3EtHQ31vltmajpH1qfU3ih1cNKtAdy3OkriRpMnImOhOw==
X-Gm-Message-State: AOJu0Yzgv+J7aspm3JiuQ2Hw78Naf38OUgUdOD052plCgOwXGjz9bILm
 dkXKIqOG0aomxvKgLylX3iLPm/eEeHo3p0J2JY4kt3aVpYebogesQP2ew2KO+mK8hZ8L/cSTRwr
 Q4Ehphpjo5GVmu3QxqSRYlgPUllYSVg5cxUZhvWAxKxtzWt8TzUY=
X-Google-Smtp-Source: AGHT+IGzFqPzDbhRAsh8AS3LTDeg3OSh7++cw46C/8ynQ+8fI5gxjzgM+m7p1+PyL8bXb/UjdeThGSzYwUOj1uMCeA4=
X-Received: by 2002:a05:6512:1116:b0:513:8266:f5d7 with SMTP id
 l22-20020a056512111600b005138266f5d7mr11412064lfg.3.1713337264636; Wed, 17
 Apr 2024 00:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240327221205.1871317-1-tharvey@gateworks.com>
 <CAC_iWjKFHnnFf1iHdH2xmSDZQi2D6iNxkO6dWWMhf+X1cDd7qQ@mail.gmail.com>
 <20240408092320.086ea1f1@xps-13>
 <CAC_iWj+DwGznVGX9BK0MRfdYaf0-XpqKNOQheJzJ340cV_-jGg@mail.gmail.com>
 <20240417084842.46da2ce6@xps-13>
In-Reply-To: <20240417084842.46da2ce6@xps-13>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 17 Apr 2024 10:00:28 +0300
Message-ID: <CAC_iWjKnuJoOtC6N1vk91kwRwgA+iEVESdnxfvYRKx7GEPA3uQ@mail.gmail.com>
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

On Wed, 17 Apr 2024 at 09:48, Miquel Raynal <miquel.raynal@bootlin.com> wro=
te:
>
> Hi Ilias,
>
> ilias.apalodimas@linaro.org wrote on Wed, 17 Apr 2024 08:40:14 +0300:
>
> > Hi Miquel
> >
> > On Mon, 8 Apr 2024 at 10:23, Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
> > >
> > > Hello,
> > >
> > > ilias.apalodimas@linaro.org wrote on Thu, 28 Mar 2024 09:08:37 +0200:
> > >
> > > > Thanks Tim
> > > >
> > > > On Thu, 28 Mar 2024 at 00:12, Tim Harvey <tharvey@gateworks.com> wr=
ote:
> > > > >
> > > > > Instead of displaying what looks like an error message if a
> > > > > gpio-reset dt prop is missing for a TPM display a warning that
> > > > > having a gpio reset on a TPM should not be used for a secure prod=
uction
> > > > > device.
> > > > >
> > > > > TCG TIS spec [1] says:
> > > > > "The TPM_Init (LRESET#/SPI_RST#) signal MUST be connected to the
> > > > > platform CPU Reset signal such that it complies with the requirem=
ents
> > > > > specified in section 1.2.7 HOST Platform Reset in the PC Client
> > > > > Implementation Specification for Conventional BIOS."
> > > > >
> > > > > The reasoning is that you should not be able to toggle a GPIO and=
 reset
> > > > > the TPM without resetting the CPU as well because if an attacker =
can
> > > > > break into your OS via an OS level security flaw they can then re=
set the
> > > > > TPM via GPIO and replay the measurements required to unseal keys
> > > > > that you have otherwise protected.
> > > > >
> > > > > [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCCl=
ientTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf
> > > > >
> > > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > > ---
> > > > > v2: change the message to a warning and update commit desc/log
> > > > > ---
> > > > >  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
> > > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_sp=
i.c
> > > > > index de9cf8f21e07..c9c83f6f0fc8 100644
> > > > > --- a/drivers/tpm/tpm2_tis_spi.c
> > > > > +++ b/drivers/tpm/tpm2_tis_spi.c
> > > > > @@ -237,14 +237,14 @@ static int tpm_tis_spi_probe(struct udevice=
 *dev)
> > > > >                         /* legacy reset */
> > > > >                         ret =3D gpio_request_by_name(dev, "gpio-r=
eset", 0,
> > > > >                                                    &reset_gpio, G=
PIOD_IS_OUT);
> > > > > -                       if (ret) {
> > > > > -                               log(LOGC_NONE, LOGL_NOTICE,
> > > > > -                                   "%s: missing reset GPIO\n", _=
_func__);
> > > > > +                       if (ret)
> > > > >                                 goto init;
> > > > > -                       }
> > > > >                         log(LOGC_NONE, LOGL_NOTICE,
> > > > >                             "%s: gpio-reset is deprecated\n", __f=
unc__);
> > > > >                 }
> > > > > +               log(LOGC_NONE, LOGL_WARNING,
> > > > > +                   "%s: TPM gpio reset should not be used on sec=
ure production devices\n",
> > > > > +                   dev->name);
> > > > >                 dm_gpio_set_value(&reset_gpio, 1);
> > > > >                 mdelay(1);
> > > > >                 dm_gpio_set_value(&reset_gpio, 0);
> > >
> > > The current logic expects a reset gpio and bails out if it cannot get
> > > it with a (questionable) goto statement.
> > >
> > > You want to invert that logic, and expect no gpio, but only if there =
is
> > > one you want to warn.
> > >
> > > This is perfectly fine but the logic here must be clarified. I'd go f=
or:
> > >
> > > ret =3D gpio_request()
> > > if (ret) {
> > >         ret =3D gpio_request()
> > >         if (!ret)
> > >                 warn(deprecated)
> > > }
> > >
> > > if (!ret) {
> > >         warn(dangerous)
> > >         toggle_value()
> > > }
> > >
> > > I would ideally replace the 'if (ret)' clauses with 'if (!reset_gpio)=
'
> > > which would make the checks even clearer.
> >
> > Fair enough. But the code with the proposed change has no functional
> > problems right?
>
> No, this is functionally right, but the code is not clear like that.
>
> > If so I'll send a PR to Tom as is and rework it as suggested later
>
> Well, that's not how contribution work usually. Is there an emergency
> in getting this merged?

Not really, it's a print message. But I don't currently have time to
pick this up.
Tim, would you mind reworking it as Miquel suggested?

Thanks
/Ilias
>
> Thanks,
> Miqu=C3=A8l
