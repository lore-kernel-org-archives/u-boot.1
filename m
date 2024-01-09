Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E2EC4706C
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 19:54:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE978877F4;
	Tue,  9 Jan 2024 20:54:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F2f7AlVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42004877F4; Tue,  9 Jan 2024 20:54:07 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B382586D2E
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 20:54:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-783182d4a09so307364385a.2
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 11:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704830043; x=1705434843; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YRDUTHYubhlO+PZvleKv9R1y5DxLqCTyIEopKTO2SMk=;
 b=F2f7AlVO4zxo4LpNUnuWr+dKWgbZWZvOqfBm6a54C0JZwSqi94Ze9kZfrajjua2RnT
 erkN0I/49lBA+2n8oKt/qosk/fuRlOQjQ3GfYYK0JU5PRt0j1CrHxxCqv33HnQgZwWdd
 Cf78Us/ro7uYI8M5dYXZ+cl5uOVrqlnbhrvdg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704830043; x=1705434843;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YRDUTHYubhlO+PZvleKv9R1y5DxLqCTyIEopKTO2SMk=;
 b=bJa1rP3pD3Yv6zDrZ1K3rEvnb4OFdqPWvyHO8soCuw3lfUQ4cOPqbXERbMLnN7KY6v
 ZNIybglXHjrb7dLpUKFk/wAHgycg2uMYYubK1375hdxDqBzZe9SoashACUZmTMaxaG79
 2QRNO6FcpqwNFre5DMDkXY1yK+vwi8vFa7WUhJOJGbIiGApOWw0dGy5bKHIQEQtNTuJo
 PzcRZRxQc/s6mZ9/ze5m6+6VJeJ7eecgscjoTJIJAU3ldLwsEiWk1nrTjphkB00eZOox
 yGjP7ikZZ6wifKniUPQNY7XFxXvyDO/lhABwB7HbHF5Ctop7gLRteI24xqHhi0Hrr3TL
 p2GQ==
X-Gm-Message-State: AOJu0Ywfevh0nVAq+03JNdEoXRhcyb0PRp9V+CAz2iD2U2ppqBae25pY
 OljcRNhBP8wx3ddCAAL3dzsoxRsbB/O+hA==
X-Google-Smtp-Source: AGHT+IGmw6a17Qlura9cWt2Gn3A1FS1gl2kUpJ5rOb9QB1g4jkFn5PnDokazAkTy+6kb67EbEeGmjw==
X-Received: by 2002:a05:620a:c82:b0:783:3388:cd46 with SMTP id
 q2-20020a05620a0c8200b007833388cd46mr399102qki.82.1704830042892; 
 Tue, 09 Jan 2024 11:54:02 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 ow7-20020a05620a820700b007815e176d44sm1050994qkn.64.2024.01.09.11.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 11:54:02 -0800 (PST)
Date: Tue, 9 Jan 2024 14:54:00 -0500
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, michael@amarulasolutions.com,
 dario.binacchi@amarulasolutions.com, afd@ti.com, vigneshr@ti.com,
 praneeth@ti.com, srk@ti.com, r-gunasekaran@ti.com, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH 4/4] configs: am64x_evm_a53_defconfig: Enable NAND
Message-ID: <20240109195400.GY1610741@bill-the-cat>
References: <20240109122605.51951-1-rogerq@kernel.org>
 <20240109122605.51951-5-rogerq@kernel.org>
 <20240109191859.ljtnotdn4voabwko@animate>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KoVR45ZwVCllstTD"
Content-Disposition: inline
In-Reply-To: <20240109191859.ljtnotdn4voabwko@animate>
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


--KoVR45ZwVCllstTD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 01:18:59PM -0600, Nishanth Menon wrote:
> On 14:26-20240109, Roger Quadros wrote:
> > Enables configuration required for NAND in SPL and u-boot.
> >=20
> > Enable MTD Driver model and MTD + UBI command line utilities.
> >=20
> > Add mtdids/mtdparts for NAND as it is required for u-boot's
> > MTD subsystem commands to recognize NAND partitions.
> >=20
> > Add u-boot partition location.
> >=20
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > ---
> >  configs/am64x_evm_a53_defconfig | 32 ++++++++++++++++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >=20
> > diff --git a/configs/am64x_evm_a53_defconfig b/configs/am64x_evm_a53_de=
fconfig
> > index 05e35a8db6..e22153a958 100644
> > --- a/configs/am64x_evm_a53_defconfig
> > +++ b/configs/am64x_evm_a53_defconfig
> > @@ -66,10 +66,15 @@ CONFIG_CMD_DFU=3Dy
> >  CONFIG_CMD_GPT=3Dy
> >  CONFIG_CMD_I2C=3Dy
> >  CONFIG_CMD_MMC=3Dy
> > +CONFIG_CMD_MTD=3Dy
> >  CONFIG_CMD_USB=3Dy
> >  CONFIG_CMD_TIME=3Dy
> >  CONFIG_CMD_PMIC=3Dy
> >  CONFIG_CMD_REGULATOR=3Dy
> > +CONFIG_CMD_MTDPARTS=3Dy
> > +CONFIG_MTDIDS_DEFAULT=3D"nand0=3Domap2-nand.0"
> > +CONFIG_MTDPARTS_DEFAULT=3D"mtdparts=3Domap2-nand.0:2m(NAND.tiboot3),2m=
(NAND.tispl),2m(NAND.tiboot3.backup),4m(NAND.u-boot),256k(NAND.u-boot-env),=
256k(NAND.u-boot-env.backup),-(NAND.file-system)"
>=20
> Why not handle this as device tree partitions?

I honestly forget what the preferred way of defining and passing NAND
partition information is these days. It might even be the funny case
that passing as cmdline args is "best" rather than fixed-partitions
binding?

--=20
Tom

--KoVR45ZwVCllstTD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWdpFgACgkQFHw5/5Y0
tyzmqAv/fbfjuxiq4xdwLlntsN1G0kP2L51X3ahmlxEM4xkkPokrSpxsyFEhItMI
IHuWkKWCD+s5JWqBVTJFpj1iBOMPqXr+y3P6zJ5QxQ1WjXczlIO/utXkVZKADtOg
ue2qSwc9B9iyh6kaOtR+v7GxHqR3Hj3rCyVVjatlgY80Esn9PSLcav/3JSPXm5Z8
gNUve6DUIE9tEyVIXZ3Z/vyhvzDrGktPrMkciD++gIxMKX2T1aPqopA3bZusBUGk
lflto2wDnf8T+8ZbhNfbXjVLXnPN4yWkch1kv/sW4eZQP7HvzDVZ2Pjksp9Ti6PE
pqndCHBNnewrVryoeIaqe9uirApwE0UP8YW0qR3OOK79HVUxyDHItlnQI9a3efZB
gTFW7jlxx2Blo6GaaXUqZTPWbjWeKxMk/x+y251K04WAJOD8N7j30kX6BNP7mY8e
ljDFZNIUO2c7aYdKXfSg4zWq9X+vPZPdbLXtsdpuAxxe/r9uPCYY+sJyG4cyeL3I
JzulKNXv
=Yqnb
-----END PGP SIGNATURE-----

--KoVR45ZwVCllstTD--
