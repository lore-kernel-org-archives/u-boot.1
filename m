Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04ABEA7944
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 20:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EB2A8341A;
	Wed,  4 Feb 2026 21:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=egym.com header.i=@egym.com header.b="Dx1R3fuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EF5F838FA; Wed,  4 Feb 2026 21:16:43 +0100 (CET)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEC3183015
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 21:16:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=egym.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cibil.pankiras@egym.com
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-38320cd563aso2454821fa.0
 for <u-boot@lists.denx.de>; Wed, 04 Feb 2026 12:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770236200; cv=none;
 d=google.com; s=arc-20240605;
 b=GzbvceR4YOcfrWkGcnaYQ3dK03Pg+vhPKcEvkaUJ1ymHQDrwgN7NZqPuIb/EmQW3hX
 c3kuk2Qz/jLIfzrRdrO+7OCO/jSlyoftbEC4zjhCTzaSq6JA1Bwh86Elt+QqN2wX9Q1z
 GB4mc5F/VscnqKVczX2chBPKZS+yC3PEgBQYEW/Ikp1lgYL6p/oqruZ2pxyflCy/lHxv
 nKNdBai0a/UCel2T/R01LdY0SnZiRNWnWkYExexQGo7nqu8l3GSCO4WlJfkGCwI95pr1
 8eKXzmA1NnSKx25L+VJzDIX9zmhqnST/T2CR1nYf0vd/2po7zuTqg+JpAFptgRwqaXCF
 cO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JaoF50wHC6XFBh72XEP6hcVqG2Y/YxT+9qzFJpTUVto=;
 fh=UQenoWJnLNqD8Cz/aExWb2ljUTCi6ycQPlJtKqjXBFI=;
 b=G/fWZdzZMBfEHxiko82izke4nv+ESQqN1luj9HXTw2hptbVjaieiJxWktZnr9y7IW4
 aSc7a9xt1fnXEvMN3bd/ajNYyHIgA5X104zWzUe36ZJjPXogIumxbaDtwqGf6evlZWGm
 Vcgs8aHktk2lzE+8HheknYqo5kpc10dn/0CHQYAnd/synmMFm+Chc+AWdfH8bz4Kz8pu
 CfNIQGARMq9RHOdYerHUEqa0OpruSPcuJcT7rK3h667OxjtMfpkf1p2nnqDtSiX40fbO
 RWFi8ufhWvRn2pmx5HBPXlYw+T4dE1k8WWHxmLyvLwz8yjIh6n+j/vNUaZI4Rhn3YrDo
 mDtw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=egym.com; s=egymcom; t=1770236200; x=1770841000; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaoF50wHC6XFBh72XEP6hcVqG2Y/YxT+9qzFJpTUVto=;
 b=Dx1R3fuXeEbHPoZKXUd4DOyVc7KBIXfTFLn00BtaoJlQRm8+Zk28G3xkMu3kL3uirE
 5Dp+tMKn7rHYX69VD77s7sBu4HOq9WepWmaFnRkRiDrdvYvxmnyk9RYfDQoWPk8S4xmQ
 u/QuD/bMVgRct8sXpqRla+05R0QgaW3Vlrw4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770236200; x=1770841000;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JaoF50wHC6XFBh72XEP6hcVqG2Y/YxT+9qzFJpTUVto=;
 b=IMlyLc9E84CLF1pH8CPjP4IPgc6vnDs9UjG/YAgtGhEgVFiVtMsBZ/r3iSQho1lCU0
 /AlZyRlOGQscyEa7LR48aoenmMUHhSvPPLR8NYLwZ7Cnc6vHeSzWXObXh7dAW9ORdkOz
 Tu9JRws7CiA+gw/A6f+8bwVEmUBUBLKacDxkXSvofppc8nzKC4fFB2OZGawoyzB3L+4o
 QsweKGdg4/vsuEqcERW9pSN4JfmMQ/Ib58PScITe9fhEWidSbDIv+OZgz6MpBckTIhAT
 MFcsWa9SBHMX7HyXiI2M3QrBztqTg1tLnzuGapisTTP/K5F0Gsq7CUy5US2lP+8w/w7j
 LPjQ==
X-Gm-Message-State: AOJu0YxhWDrrt1F78+ig2ViMybpx969+QMq7SCbOCiX+gHppKpsOmCmc
 ojMLHw/dv5qYfItFjU4X1JC6wI+eYvhKQ9PoZYrQIacwgjefQjtfVEcxNpR1TtTng32jrJaXBFE
 6ha7OuqEkkV5ezWSaXZYSOB7+8Pb4taG7rUCC9COGg2ROP7DsC9bq1YReaYvA/cd8ZO/cV8z9wE
 4AHV5ypjjOJjLgHxoKBdn/EQ==
X-Gm-Gg: AZuq6aIPd+rGROvkmLb11AA8RSMvDyyUkkpFwohkJtRrMQic/LjyampYSFY7t+dRTXj
 5KU2tV2uZi/6rYAJqAUoE3rS+6JL8EvYhNW4AVwsV8nAWxNZ9KQTKPgXc5Qh1kRUimmWSUMmXmE
 COXlG5g8y37xLXoqQsbUYHVYWU9lIZi4SUCjUlnH6uud6aEClh3KQ+3ZXK+W7vALUhcY1kmZCT2
 98qHKFqMDYBuUp/KDzth0K/bAQIlRK9psWmHtYGDzPciNUNJBTKxPMFUNWqF7i+SvMVuh0ujKIj
 BuHA2QZzYi6nOEkfPucCHNGDdPXGDcGYYpXiFofJvsDbl5QDSVTaTsRRh+Z6hgfKC3y8ZwtmLPa
 1co64KGtk0w4S
X-Received: by 2002:a05:651c:220f:b0:386:1ce2:119c with SMTP id
 38308e7fff4ca-38691d5b0efmr16381471fa.27.1770236199978; Wed, 04 Feb 2026
 12:16:39 -0800 (PST)
MIME-Version: 1.0
References: <20260129151509.548538-1-cibil.pankiras@egym.com>
 <c7dea041-832b-4dbd-9d5d-c823b29672ce@suse.com>
In-Reply-To: <c7dea041-832b-4dbd-9d5d-c823b29672ce@suse.com>
From: Cibil Pankiras <cibil.pankiras@egym.com>
Date: Wed, 4 Feb 2026 21:16:29 +0100
X-Gm-Features: AZwV_QgacV0qtvBiSpWGQJTe1o9ixyB_-4Cy36nvTuZZ32qXXKW2Nl8lYkViIo4
Message-ID: <CAK3EG+mxL+fTq3SafpNdMwgP0D4TOk5AhWHuQO+tTYXoBdMonA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: bcm283x: Fix GPIO pull state register values for
 BCM2711
To: Matthias Brugger <mbrugger@suse.com>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Tom Rini <trini@konsulko.com>
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

On Wed, Feb 4, 2026 at 6:34=E2=80=AFPM Matthias Brugger <mbrugger@suse.com>=
 wrote:
>
>
>
> On 29/01/2026 16:15, Cibil Pankiras wrote:
> > BCM2711 has different pull-up/down register values compared to BCM2835
> >
> > - BCM2835: NONE=3D0, DOWN=3D1, UP=3D2
> > - BCM2711: NONE=3D0, UP=3D1, DOWN=3D2
> >
> > This patch fixes the pull state register values for BCM2711.
> >
> > Fixes: 2c39d975f87c ("pinctrl: bcm283x: Add GPIO pull-up/down control f=
or BCM2835 and BCM2711")
> > Signed-off-by: Cibil Pankiras <cibil.pankiras@egym.com>
> > ---
> >   drivers/pinctrl/broadcom/pinctrl-bcm283x.c | 20 +++++++++++++++++---
> >   1 file changed, 17 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c b/drivers/pinct=
rl/broadcom/pinctrl-bcm283x.c
> > index 4ecc8bac645a..33638515b5db 100644
> > --- a/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> > +++ b/drivers/pinctrl/broadcom/pinctrl-bcm283x.c
> > @@ -30,6 +30,11 @@ struct bcm283x_pinctrl_priv {
> >
> >   #define MAX_PINS_PER_BANK 16
> >
> > +/* pull states for BCM2711 */
> > +#define BCM2711_PULL_NONE 0
> > +#define BCM2711_PULL_UP   1
> > +#define BCM2711_PULL_DOWN 2
> > +
> >   static void bcm2835_gpio_set_func_id(struct udevice *dev, unsigned in=
t gpio,
> >                                    int func)
> >   {
> > @@ -84,7 +89,7 @@ static void bcm2835_gpio_set_pull(struct udevice *dev=
, unsigned int gpio, int pu
> >    * bcm2711_gpio_set_pull: Set GPIO pull-up/down resistor for BCM2711
> >    * @dev: the pinctrl device
> >    * @gpio: the GPIO pin number
> > - * @pull: pull setting (BCM2835_PUD_OFF, BCM2835_PUD_DOWN, BCM2835_PUD=
_UP)
> > + * @pull: pull setting (BCM2711_PULL_NONE, BCM2711_PULL_DOWN, BCM2711_=
PULL_UP)
>
> Why call it BCM2711_PULL_x instead of BCM2711_PUD_x?
I referenced the kernel, but it would make more sense to name it
BCM2711_PUD_x, just like BCM2835_PUD_x. I will rename it and send v2.

>
> >    */
> >   static void bcm2711_gpio_set_pull(struct udevice *dev, unsigned int g=
pio, int pull)
> >   {
> > @@ -108,10 +113,19 @@ static void bcm2711_gpio_set_pull(struct udevice =
*dev, unsigned int gpio, int pu
> >
> >   static void bcm283x_gpio_set_pull(struct udevice *dev, unsigned int g=
pio, int pull)
> >   {
> > -     if (device_is_compatible(dev, "brcm,bcm2835-gpio"))
> > +     if (device_is_compatible(dev, "brcm,bcm2835-gpio")) {
> >               bcm2835_gpio_set_pull(dev, gpio, pull);
> > -     else
> > +     } else {
> > +             /* BCM2711's pull values differ from BCM2835 */
> > +             if (pull =3D=3D BCM2835_PUD_UP)
> > +                     pull =3D BCM2711_PULL_UP;
> > +             else if (pull =3D=3D BCM2835_PUD_DOWN)
> > +                     pull =3D BCM2711_PULL_DOWN;
> > +             else
> > +                     pull =3D BCM2711_PULL_NONE;
> > +
>
> That code should go into bcm2711_gpio_set_pull().
I will make the change and send v2.

Warm Regards,
Cibil

--=20
EGYM SE, Einsteinstra=C3=9Fe 172, 81677 M=C3=BCnchen
Gesch=C3=A4ftsf=C3=BChrende Direktoren:=20
Patrick Meininger, Philipp Roesch-Schlanderer, Florian Sauter
Gerichtsstand=20
M=C3=BCnchen | Amtsgericht M=C3=BCnchen HRB 303509=C2=A0|=C2=A0USt.-Id. DE2=
75313632
