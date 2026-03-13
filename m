Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D796105F7A6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A51D0842FC;
	Fri, 13 Mar 2026 15:53:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LfM0o7ik";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2B6B842FC; Fri, 13 Mar 2026 15:53:17 +0100 (CET)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3972084286
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 15:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-404254ffe8aso1406074fac.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773413594; x=1774018394; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x+FdTahsHcvBlSTjItQipgPUyHJsYaYb5txmmcgFc80=;
 b=LfM0o7iktaAogcI6TXuMhIgJfxy6BNv/3qY1mC6m2EIHpf+FHE8EPQwZ2GC5cwCIqQ
 e964xyDDZuC+B95MZrmBX/Z1lN/rtnx1zEEROerDzjlHSSptk6OO9gf3bq6b2slDss+C
 PPdRN67FVqBlDxSK/raofAPXqWcKW3vmXKtSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773413594; x=1774018394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+FdTahsHcvBlSTjItQipgPUyHJsYaYb5txmmcgFc80=;
 b=rEU0TlV6LO4VoEoewtybSj9t6zWSlNN6G0UjGFLtmFW12Mg30qjEjPJDUwUphPjw2c
 WuR6SFR9Oe7rsWfLLfxruQdi/kig1WCm8KwZ96KNv2qYiwcvlEoXWllyUvawsLoFl0Xr
 x8X56Y8j0OaWAzbl4j+chuOkKF8D8M3qPPtDhWUSr/t92JHt+Sn/omQ2gtzZMpo5EDwM
 VvRUjkd7B+siS6Lm5BAYgwXBxIaTYWkXcYWimTzq29BRPlyHb45mwOMAP35iMNW7zUr8
 NujwMQW4okk+WJxUWXvvJDrFy7a3nd3vqq+I4p+BORua/+DYAnAOVJ3FKnSnsjwL3L7D
 d85w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj9RrTPE1iclMK1oasJuQUBsOSsnk17BlFG8akBCcKpt7jnbdiXrjaeJETlWmWZX26kudYJ8I=@lists.denx.de
X-Gm-Message-State: AOJu0YzaEi31iTYsEl2bUZdnEUTDZtQzdjCgLCK1rOoJSqOhSmBdMebX
 MI7teTGroUh0Nw+uSVZuTFwq/kgZe9fxA7K+XBrXhi0WtiyAuuMt6XMBdUyG3U9nV4vxE7Eewh4
 DEbwkw64=
X-Gm-Gg: ATEYQzz8ddqGNdWx2t8ODZq6E1ntaoYptfk2yl39tDtqbpAyo6Sbrd5CIzInBGNWWlg
 0WR3VomIkfv424GbLECXPc1jYRS7ImPmRY0/LgKmDQH+MokHdB4c2ELd/THEoRqcYKOmUX+D9te
 Su0ELx4SY+ze+y4GhhFkRA6e++74zTMJ4ODwREM7VyvSYxYdOKURMuc9Oaiaavy9ndKdFkxTQU2
 Np0vf7fHYnk81BmoQRAbe7qmoTVQ02fxTUJ5bbB3A9bDMY/97XzSHPfNJDUduWAUOZcNhbko/lL
 DpUNQP2Dlj7JWOXmKxMrRJ6SauBYINar6EUEmhCTxpy5A0yUnF+pBgaaiXDcdsI+/F5e7VGXNlM
 x5CVxEQF1ffAQvihKqwFoGcDBrr7436QcZx8GHdHN0tzmDx9j9N3+Jj2yyo9uqVYfd1wjMl0Fr7
 9e3eh4e2AApwG6tf3HeHc3XX1zMrLONPUD3Qigfka2OSg7Z+YJS92yEfGS7NBMr0btAM1A1M1GJ
 93qelKrIVm+5XGaEy1WJt6dHI50ncsRhNxr3/2XlitiDqpU
X-Received: by 2002:a05:6871:b13:b0:404:1ec2:562c with SMTP id
 586e51a60fabf-41798e065eemr4201192fac.6.1773413593856; 
 Fri, 13 Mar 2026 07:53:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e25f037sm8340391fac.5.2026.03.13.07.53.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:53:13 -0700 (PDT)
Date: Fri, 13 Mar 2026 08:53:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Max Merchel <max.merchel@ew.tq-group.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 u-boot@lists.denx.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] pci: imx: Properly support upstream Linux
 reset-gpios property
Message-ID: <20260313145311.GD502704@bill-the-cat>
References: <20260312192605.131132-1-krzysztof.kozlowski@oss.qualcomm.com>
 <9e8aa4e7-72ab-4b1a-b324-4c78b13b9741@ew.tq-group.com>
 <02b1e588-1feb-484e-9f3c-f6c9f0b8e00c@oss.qualcomm.com>
 <435e08f1-77fd-476a-96ad-8648ae971e81@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T/0i/r0MVQnzhAke"
Content-Disposition: inline
In-Reply-To: <435e08f1-77fd-476a-96ad-8648ae971e81@ew.tq-group.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--T/0i/r0MVQnzhAke
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 09:28:23AM +0100, Max Merchel wrote:
>=20
> On 3/13/26 09:14, Krzysztof Kozlowski wrote:
> > On 13/03/2026 09:12, Max Merchel wrote:
> > > On 3/12/26 20:26, Krzysztof Kozlowski wrote:
> > > > The driver requests explicitly "reset-gpio" property, not the one w=
ith
> > > > "gpios" suffix but upstream Linux kernel deprecated it in 2021.
> > > > Existing upstream Linux kernel DTS is being changed to "reset-gpios"
> > > > property, thus update the driver to read that one too.
> > > >=20
> > > > Note that driver is probably broken already, because it parsed GPIO=
 in
> > > > standard way respecting the flags and on top of that applied the
> > > > "reset-gpio-active-high" flag, thus "reset-gpio ACTIVE_LOW" with the
> > > > "reset-gpio-active-high" property would be double inverted.
> > > >=20
> > > > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcom=
m.com>
> > > >=20
> > > > ---
> > > >=20
> > > > 1. https://lore.kernel.org/linux-devicetree/20260312-dts-snps-reset=
-gpios-v2-12-0d5040eb4a1e@oss.qualcomm.com/
> > > > 2. See Linux kernel commit 42694f9f6407 ("dt-bindings: PCI: add snp=
s,dw-pcie.yaml")
> > > > ---
> > > >    drivers/pci/pcie_imx.c | 22 +++++++++++++++++++---
> > > >    1 file changed, 19 insertions(+), 3 deletions(-)
> > > >=20
> > > > diff --git a/drivers/pci/pcie_imx.c b/drivers/pci/pcie_imx.c
> > > > index 11c4ccbfc555..8d853ecf2c22 100644
> > > > --- a/drivers/pci/pcie_imx.c
> > > > +++ b/drivers/pci/pcie_imx.c
> > > > @@ -728,15 +728,31 @@ static int imx_pcie_dm_write_config(struct ud=
evice *dev, pci_dev_t bdf,
> > > >    static int imx_pcie_dm_probe(struct udevice *dev)
> > > >    {
> > > >    	struct imx_pcie_priv *priv =3D dev_get_priv(dev);
> > > > +	int ret;
> > > >    #if CONFIG_IS_ENABLED(DM_REGULATOR)
> > > >    	device_get_supply_regulator(dev, "vpcie-supply", &priv->vpcie);
> > > >    #endif
> > > >    	/* if PERST# valid from dt then assert it */
> > > > -	gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_gpio,
> > > > -			     GPIOD_IS_OUT);
> > > > -	priv->reset_active_high =3D dev_read_bool(dev, "reset-gpio-active=
-high");
> > > > +	ret =3D gpio_request_by_name(dev, "reset-gpio", 0, &priv->reset_g=
pio,
> > > > +				   GPIOD_IS_OUT);
> > > > +	if (!ret) {
> > > > +		/*
> > > > +		 * Legacy property, invert assert logic based on
> > > > +		 * reset-gpio-active-high. This won't work if flags are not
> > > > +		 * matching the reset-gpio-active-high.
> > > > +		 */
> > > > +		priv->reset_active_high =3D dev_read_bool(dev, "reset-gpio-activ=
e-high");
> > > A warning should also be issued when using the deprecated "reset-gpio"
> > > property.
> > >=20
> > >   =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(dev, "reset-gpio property deprecat=
ed, use
> > > reset-gpios\n");
> > >=20
> > Why? What would end user seeing this in their serial console do? The
> > deprecated property is not a mistake, it's just deprecated.
>=20
> You're right. It's not a message for the end user, but for the developers.
> Therefore, it would be better to add a debug message.

Developers should be enabling OF_UPSTREAM and so that won't have slipped
through?

--=20
Tom

--T/0i/r0MVQnzhAke
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabQk0wAKCRAr4qD1Cr/k
CorAAP4nz2WOuPJgnWCX5AusDPvllVgJY75XA9JEAfhrFWP8DAEAngFAv7ceZOc2
uMusBogoLEfFWZ3LEeKRMW2Wb5FnQgY=
=yxLO
-----END PGP SIGNATURE-----

--T/0i/r0MVQnzhAke--
