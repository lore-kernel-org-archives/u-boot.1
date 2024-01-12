Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E70C4725D
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:21:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5397F87937;
	Fri, 12 Jan 2024 14:21:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DbZzQduL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AFE9879F0; Fri, 12 Jan 2024 14:21:37 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A874487937
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:21:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5ebca94cf74so66239717b3.0
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705065693; x=1705670493; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2WOJssxcYz/PuGmi1ZkeJFfufsL0vtx5CDqAP6wKO1k=;
 b=DbZzQduL1ejtx5/1Km2tZWpy9kpIuO9DtHBYDhJqfPBJeetCL8t12cDM4nHEn6dDu1
 TovJ48Jm8Weq2P549emwQgzCXS5WWndSWNtpCJkZJmmWQA7E05sITGtirs6RzyLoCmKk
 QU9y/0sq+DlqlGARqP477eJxGyK7JpcdEZTUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705065693; x=1705670493;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2WOJssxcYz/PuGmi1ZkeJFfufsL0vtx5CDqAP6wKO1k=;
 b=YZ8od14wUd1mOgf7O0KkRq96TkwYiQZCkKv7OfVdfk+HHmy7EiYwtLWUdxOLm1OG9s
 2kVydwmuLepTFeOvHe9cnHNr92+02DuZ1cRK1nmxJKADY8SK2kJcrrSaB96/e1zbowMx
 X7m2+XwUGmNVHOxZQjQb8C4wA5iHjX61SZs78g3ULOWTgMtk2OGTYRQ+HBS6MS6fUCfe
 N6FDyV4OtV1zUJdLjotFa6l67YuoVFOcN6OY2nSOBwRcZWIpvEVXBqHDEqN5/VWic01e
 N+8FN89BKPYrY6IKQgZMaw8A5Fz4T4tlkV8e1eBJg8hD86BXK+r3r9mFtHIZ7guBT+hJ
 /Zyw==
X-Gm-Message-State: AOJu0YwgGJPfHmv7w/dfmPVkdJD5YVZNtZXYPQKOvYHDSBtzQJm8XRiz
 exxlapKw7X/p8sKZI79Kl4dsEc3BGZxb7A==
X-Google-Smtp-Source: AGHT+IFHgs1jivxRDwOQhm1rHlKLVWsFtcRWgdMEUHQ7Ed4wuXd38YaQuV01vJfrJiXIxX1pSMTBBg==
X-Received: by 2002:a25:ab94:0:b0:dbe:a3b0:6e49 with SMTP id
 v20-20020a25ab94000000b00dbea3b06e49mr607890ybi.38.1705065693391; 
 Fri, 12 Jan 2024 05:21:33 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 d34-20020a253622000000b00dbdb03e146bsm1201330yba.51.2024.01.12.05.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:21:32 -0800 (PST)
Date: Fri, 12 Jan 2024 08:21:31 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, robertcnelson@gmail.com,
 marex@denx.de, n-francis@ti.com, praneeth@ti.com,
 s-vadapalli@ti.com, r-gunasekaran@ti.com, srk@ti.com,
 vigneshr@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH 4/5] arm: dts: k3-j721e-beagleboneai64: Fix USB operation
Message-ID: <20240112132131.GN1610741@bill-the-cat>
References: <20240112124951.238098-1-rogerq@kernel.org>
 <20240112124951.238098-5-rogerq@kernel.org>
 <20240112130233.bflterluncjoyrhy@treadmill>
 <8f5d151c-aebb-41d9-b638-83c60e740d15@kernel.org>
 <20240112131450.tpn454pfzlqlteed@urology>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ATeyE13DEcIBWrmS"
Content-Disposition: inline
In-Reply-To: <20240112131450.tpn454pfzlqlteed@urology>
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


--ATeyE13DEcIBWrmS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 07:14:50AM -0600, Nishanth Menon wrote:
> On 15:06-20240112, Roger Quadros wrote:
> >=20
> >=20
> > On 12/01/2024 15:02, Nishanth Menon wrote:
> > > On 14:49-20240112, Roger Quadros wrote:
> > >> Without correct SERDES MUX and Lane control settings
> > >> USB0 will be broken. Set the MUX and Lane control devices
> > >> to be auto probed so they are configured correctly.
> > >>
> > >> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > >> ---
> > >>  arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >>
> > >> diff --git a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi b/arch=
/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> > >> index f83caf7998..017a5a722e 100644
> > >> --- a/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> > >> +++ b/arch/arm/dts/k3-j721e-beagleboneai64-u-boot.dtsi
> > >> @@ -165,6 +165,7 @@
> > >> =20
> > >>  &serdes_ln_ctrl {
> > >>  	bootph-all;
> > >> +	u-boot,mux-autoprobe;
> > >>  };
> > >> =20
> > >>  &serdes2_usb_link {
> > >> @@ -173,6 +174,7 @@
> > >> =20
> > >>  &usb_serdes_mux {
> > >>  	bootph-all;
> > >> +	u-boot,mux-autoprobe;
> > >>  };
> > >> =20
> > >>  &serdes_wiz2 {

OK, so both of these are compatible =3D "mmio-mux", is the problem they
aren't probed in time or something else?

> > >> --=20
> > >> 2.34.1
> > >>
> > >=20
> > > Is this a u-boot thing? or a driver limitation?
> > >=20
> >=20
> > u-boot specific. We just want the mux driver to probe
> > and apply the settings.
> >=20
> > from drivers/mux/mux-uclass.c
> >=20
> > int dm_mux_init(void)
> > {
> >         struct uclass *uc;
> >         struct udevice *dev;
> >         int ret;
> >=20
> >         ret =3D uclass_get(UCLASS_MUX, &uc);
> >         if (ret < 0) {
> >                 log_debug("unable to get MUX uclass\n");
> >                 return ret;
> >         }
> >         uclass_foreach_dev(dev, uc) {
> >                 if (dev_read_bool(dev, "u-boot,mux-autoprobe")) {
> >                         ret =3D device_probe(dev);
> >                         if (ret)
> >                                 log_debug("unable to probe device %s\n",
> >                                           dev->name);
> >                 }
> >         }
> >=20
> >         return 0;
> > }
> >=20
> >=20
>=20
> Uggh.. We need to see eventually how to get rid of this.
> This makes
> https://lore.kernel.org/u-boot/20240110103547.719757-1-sumit.garg@linaro.=
org/#t
> harder now?

No, it should be fine, Sumit's series handles -u-boot.dtsi files.

--=20
Tom

--ATeyE13DEcIBWrmS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhPNcACgkQFHw5/5Y0
tyzZPwwAirJcMBdmduXbaLloS+zltBOrf+bmFXcm4vET4lDz+bwEeP2ZZ7lj8zVO
JF6vQcTMVdQxDWXnKUK881PHQG4KZs5tQ7KsPkhyD3stuhvVutZdmAU5KcyNhNKW
LvntJXt19GK9312hXwcITbN3xUyCPaO6fsLWRrKtGyEFtHdJTKkq4noYeCAfIKDL
r5KSBCgZekAczMaLh0+ylDakQRQtP5/6RaEv8pObjkl67O4HExt6AZlw9LyVWu45
iaffBif8NPAXK6GynpkIhitWOkm7dW7pdRBVJciNWdhSVa7GVrMlbUs109QCshdU
NZglKPU1OyOwdzlb9BbxU29F6apbncktiAeFhcq96poIHzMn9EzVVUUUmE3KZCVl
LAXrfYQXZ2TRq/JkCCFZm//kBapSaTEhWQRk2iI0/I/prge4FcibG7WizyokNDkY
yqUBe00kxe1oFGifjgxI0YNU5HCMMZHnDULdv5SroElMBZ13pmSjAEpAH5rHtYYS
VZ2HPuEa
=AFbi
-----END PGP SIGNATURE-----

--ATeyE13DEcIBWrmS--
