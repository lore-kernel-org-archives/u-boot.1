Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D066DC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 06:48:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6865E88422;
	Wed, 17 Apr 2024 08:48:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="GQwXoA/J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3ECD8842B; Wed, 17 Apr 2024 08:48:46 +0200 (CEST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85F9587E95
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 08:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5833F240007;
 Wed, 17 Apr 2024 06:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1713336524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZinJlc3ywYAoOO6YXnl0Tp58IDJkmxCzgPQlppFcT7o=;
 b=GQwXoA/J6SDNijLNZ7cHdCUC6tRP0EGlccNzoCxqjyUkoerwBbdWcXxmoHeugk2sMJLICl
 mqYPFlSzNXLlDeIbeptX6cA41IpjtI8/QEyzNHDWjlA0yNWV3qmwJLWAgPaPXX7RgiiZ5k
 2V7+bddSyc+F1/ZrEVJu1O94tUE0bTptcVlfbT5Hcj9+Lw2qoIyJ4L/jo9RdvkKbgTE8Xx
 bPL8pM8DelpDMuc97olK7Udn+kUqbXmYfHt4u/rk3GPDGD3/bFaFX1jl8qAx6jZ5duONfa
 htyZ7UcafNQi1n2JfWa0ohkknQyCm32nns33ren4IUhNRLNnKtUUUxgy+NdT6Q==
Date: Wed, 17 Apr 2024 08:48:42 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de, Jorge
 Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>, Rasmus
 Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2] tpm: display warning if using gpio reset with TPM
Message-ID: <20240417084842.46da2ce6@xps-13>
In-Reply-To: <CAC_iWj+DwGznVGX9BK0MRfdYaf0-XpqKNOQheJzJ340cV_-jGg@mail.gmail.com>
References: <20240327221205.1871317-1-tharvey@gateworks.com>
 <CAC_iWjKFHnnFf1iHdH2xmSDZQi2D6iNxkO6dWWMhf+X1cDd7qQ@mail.gmail.com>
 <20240408092320.086ea1f1@xps-13>
 <CAC_iWj+DwGznVGX9BK0MRfdYaf0-XpqKNOQheJzJ340cV_-jGg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
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

Hi Ilias,

ilias.apalodimas@linaro.org wrote on Wed, 17 Apr 2024 08:40:14 +0300:

> Hi Miquel
>=20
> On Mon, 8 Apr 2024 at 10:23, Miquel Raynal <miquel.raynal@bootlin.com> wr=
ote:
> >
> > Hello,
> >
> > ilias.apalodimas@linaro.org wrote on Thu, 28 Mar 2024 09:08:37 +0200:
> > =20
> > > Thanks Tim
> > >
> > > On Thu, 28 Mar 2024 at 00:12, Tim Harvey <tharvey@gateworks.com> wrot=
e: =20
> > > >
> > > > Instead of displaying what looks like an error message if a
> > > > gpio-reset dt prop is missing for a TPM display a warning that
> > > > having a gpio reset on a TPM should not be used for a secure produc=
tion
> > > > device.
> > > >
> > > > TCG TIS spec [1] says:
> > > > "The TPM_Init (LRESET#/SPI_RST#) signal MUST be connected to the
> > > > platform CPU Reset signal such that it complies with the requiremen=
ts
> > > > specified in section 1.2.7 HOST Platform Reset in the PC Client
> > > > Implementation Specification for Conventional BIOS."
> > > >
> > > > The reasoning is that you should not be able to toggle a GPIO and r=
eset
> > > > the TPM without resetting the CPU as well because if an attacker can
> > > > break into your OS via an OS level security flaw they can then rese=
t the
> > > > TPM via GPIO and replay the measurements required to unseal keys
> > > > that you have otherwise protected.
> > > >
> > > > [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClie=
ntTPMInterfaceSpecification_TIS__1-3_27_03212013.pdf
> > > >
> > > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > > ---
> > > > v2: change the message to a warning and update commit desc/log
> > > > ---
> > > >  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> > > > index de9cf8f21e07..c9c83f6f0fc8 100644
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
> > > > +               log(LOGC_NONE, LOGL_WARNING,
> > > > +                   "%s: TPM gpio reset should not be used on secur=
e production devices\n",
> > > > +                   dev->name);
> > > >                 dm_gpio_set_value(&reset_gpio, 1);
> > > >                 mdelay(1);
> > > >                 dm_gpio_set_value(&reset_gpio, 0); =20
> >
> > The current logic expects a reset gpio and bails out if it cannot get
> > it with a (questionable) goto statement.
> >
> > You want to invert that logic, and expect no gpio, but only if there is
> > one you want to warn.
> >
> > This is perfectly fine but the logic here must be clarified. I'd go for:
> >
> > ret =3D gpio_request()
> > if (ret) {
> >         ret =3D gpio_request()
> >         if (!ret)
> >                 warn(deprecated)
> > }
> >
> > if (!ret) {
> >         warn(dangerous)
> >         toggle_value()
> > }
> >
> > I would ideally replace the 'if (ret)' clauses with 'if (!reset_gpio)'
> > which would make the checks even clearer. =20
>=20
> Fair enough. But the code with the proposed change has no functional
> problems right?

No, this is functionally right, but the code is not clear like that.

> If so I'll send a PR to Tom as is and rework it as suggested later

Well, that's not how contribution work usually. Is there an emergency
in getting this merged?

Thanks,
Miqu=C3=A8l
