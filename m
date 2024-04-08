Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A777BCD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 07:23:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3CF887F6A;
	Mon,  8 Apr 2024 09:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="e1tosih9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D499E87F78; Mon,  8 Apr 2024 09:23:24 +0200 (CEST)
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net
 [217.70.183.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EF1687F50
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 09:23:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 22106FF80C;
 Mon,  8 Apr 2024 07:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
 t=1712561001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KLf6IN2uxXK1WBkQLthnjZ7a50BtPTJH1N2CgqscOn0=;
 b=e1tosih9CYQPO1Gj+bMpT5GhVofM1ZlKvNPYgsI+B4FsmL0ZUe2iW1PHDaQ7IDZ87yPnEq
 0OtTrcrBSP6tyxv6OBECW4ogcnel8Ev97i09HZRagmwNg0H7rMJfEhFwVzzWEwP14GAQHb
 oEJL86hRj27OGvlF9YXFQB9yLLycJNdlqw+PeIdb24z6LG3sOQr5G1uC0ECFY8+/6WSYKy
 0OU6Ia7LNU+YRXgEFJ1GTjuQ4JNzIYs2asBabep+JiW+f1H2cYNLiVPxjtsFwsCbeb8Dar
 USP7wPjTuRJG3rO+tWHGvekqi/Z4X75lHGTgaLA6arsPKbI2MbepqwvAgfTWdQ==
Date: Mon, 8 Apr 2024 09:23:20 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de, Jorge
 Ramirez-Ortiz <jorge@foundries.io>, Adam Ford <aford173@gmail.com>, Rasmus
 Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH v2] tpm: display warning if using gpio reset with TPM
Message-ID: <20240408092320.086ea1f1@xps-13>
In-Reply-To: <CAC_iWjKFHnnFf1iHdH2xmSDZQi2D6iNxkO6dWWMhf+X1cDd7qQ@mail.gmail.com>
References: <20240327221205.1871317-1-tharvey@gateworks.com>
 <CAC_iWjKFHnnFf1iHdH2xmSDZQi2D6iNxkO6dWWMhf+X1cDd7qQ@mail.gmail.com>
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

Hello,

ilias.apalodimas@linaro.org wrote on Thu, 28 Mar 2024 09:08:37 +0200:

> Thanks Tim
>=20
> On Thu, 28 Mar 2024 at 00:12, Tim Harvey <tharvey@gateworks.com> wrote:
> >
> > Instead of displaying what looks like an error message if a
> > gpio-reset dt prop is missing for a TPM display a warning that
> > having a gpio reset on a TPM should not be used for a secure production
> > device.
> >
> > TCG TIS spec [1] says:
> > "The TPM_Init (LRESET#/SPI_RST#) signal MUST be connected to the
> > platform CPU Reset signal such that it complies with the requirements
> > specified in section 1.2.7 HOST Platform Reset in the PC Client
> > Implementation Specification for Conventional BIOS."
> >
> > The reasoning is that you should not be able to toggle a GPIO and reset
> > the TPM without resetting the CPU as well because if an attacker can
> > break into your OS via an OS level security flaw they can then reset the
> > TPM via GPIO and replay the measurements required to unseal keys
> > that you have otherwise protected.
> >
> > [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG_PCClientTP=
MInterfaceSpecification_TIS__1-3_27_03212013.pdf
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v2: change the message to a warning and update commit desc/log
> > ---
> >  drivers/tpm/tpm2_tis_spi.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/tpm/tpm2_tis_spi.c b/drivers/tpm/tpm2_tis_spi.c
> > index de9cf8f21e07..c9c83f6f0fc8 100644
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
> >                             "%s: gpio-reset is deprecated\n", __func__);
> >                 }
> > +               log(LOGC_NONE, LOGL_WARNING,
> > +                   "%s: TPM gpio reset should not be used on secure pr=
oduction devices\n",
> > +                   dev->name);
> >                 dm_gpio_set_value(&reset_gpio, 1);
> >                 mdelay(1);
> >                 dm_gpio_set_value(&reset_gpio, 0);

The current logic expects a reset gpio and bails out if it cannot get
it with a (questionable) goto statement.

You want to invert that logic, and expect no gpio, but only if there is
one you want to warn.

This is perfectly fine but the logic here must be clarified. I'd go for:

ret =3D gpio_request()
if (ret) {
	ret =3D gpio_request()
	if (!ret)
		warn(deprecated)
}

if (!ret) {
	warn(dangerous)
	toggle_value()
}

I would ideally replace the 'if (ret)' clauses with 'if (!reset_gpio)'
which would make the checks even clearer.

Thanks,
Miqu=C3=A8l
