Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BC3C47DD9
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 12:12:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB568803A;
	Wed, 27 Mar 2024 13:12:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NbdH3KLh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73EE9880A6; Wed, 27 Mar 2024 13:12:52 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63A638802E
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 13:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-43182c2457bso1072461cf.1
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 05:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711541569; x=1712146369; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jR3ojDtd7dcdAFmNEzyO3KmR5Ypq0UKsSPQCbJl0hRk=;
 b=NbdH3KLhmyghbmeN+mjooP9Ha1bQ/YaFbkXX8jMu91dtdF02K+8yTMrqzx3jqvwnhW
 AbfA7SnKnAPazmMTJk/7XhxzHZXjQz8hBD0c2+FfJ9nnhocpU7AzK9LfSqgYbQOehEIk
 GAEv5xAfIFDTFKSFP8GpaM2fXlSsp7FBj+/tA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711541569; x=1712146369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jR3ojDtd7dcdAFmNEzyO3KmR5Ypq0UKsSPQCbJl0hRk=;
 b=bj1bl4SDIc70GnxiDFaLmJgMr4N07WiyHMl30vUit4qmGeNn05mVMdcK1s6Yp24NhZ
 rvNCE+0HIjC07HNB9MzJ8NDtb4Nt+NBXCO+YWiNbFG3nw2rSikkURbTHNEocl6thb5z6
 gv1I5ZP4eJJkB7E7uypXpVI8Z0zotISUbNrWNHZSBoTQi+MRhAGvoyBUMoX5zRlWheQW
 qi9BjhKyawpv6/biWsXUH/jnw6ASALVsxG7kATpXQan8390PDTKstORq5u3IklkxWd4J
 wkcoHEvGiqLHEDvacdWiRVg1Sg4Pnuk158scl+5aqc24DyOWpi4LqNB9DSvdS4v/+9SK
 0RPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaFqf/sc+IA/arw0SmJRQ5Pu2fxgxIHg/btk4f/iRzt+N8fflWPSn5mYRR44qu434NQeX/bmpNRWrRsJO/a04upeysDw==
X-Gm-Message-State: AOJu0YzUfjm/gluDmsy4ETFiKISwyyvQBbbrnv2/oSU8vHT6c2hm9OiL
 njEX1c5ujixpPeuKg2hViNucgrMn7U3aagtq8fgKzht5Ng08cICSRdozTbsHb2Q=
X-Google-Smtp-Source: AGHT+IFfkO6EbCipogh8I/DC4dGMBHeJyxbcLY2Dtjz3mDYqTDYRdmH0m4rD4asdmkIgczif3qAI5w==
X-Received: by 2002:ac8:5d8b:0:b0:431:5b06:c2ae with SMTP id
 d11-20020ac85d8b000000b004315b06c2aemr6071790qtx.56.1711541569238; 
 Wed, 27 Mar 2024 05:12:49 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 j29-20020ac84c9d000000b0042ee243ca95sm4732620qtv.50.2024.03.27.05.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 05:12:48 -0700 (PDT)
Date: Wed, 27 Mar 2024 08:12:46 -0400
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de,
 xypron.glpk@gmx.de, cym@rock-chips.com, philipp.tomsich@vrull.eu,
 sjg@chromium.org, eugen.hristev@collabora.com, jonas@kwiboo.se,
 Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 1/2] rockchip: rk3588: Add support for ATAG parsing
Message-ID: <20240327121246.GH3442575@bill-the-cat>
References: <20240326204944.1572667-1-macroalpha82@gmail.com>
 <20240326204944.1572667-2-macroalpha82@gmail.com>
 <fe9eef97-5814-4d25-8357-60873d565aff@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="87/R+F6OM59gh2VM"
Content-Disposition: inline
In-Reply-To: <fe9eef97-5814-4d25-8357-60873d565aff@rock-chips.com>
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


--87/R+F6OM59gh2VM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 06:32:06PM +0800, Kever Yang wrote:
> Hi Chris,
>=20
> =A0=A0=A0 The ATAGS is used for passing parameter from bootloader to kern=
el at
> first, which has been replaced by DTB now for ARM platform.
>=20
> =A0=A0=A0 And Rockchip using ATAGs for passing parameter like dram memory
> size/board uart in different boot process like DRAM init binary/ TPL/SPL =
to
> U-Boot since 2018.
>=20
> =A0=A0=A0 And almost at the same time, Simon add bloblist for mainline U-=
Boot
> which for similar purpose.
>=20
> =A0=A0=A0 So I'm not sure if this ATAGS should be accept in mainline U-Bo=
ot or
> not, even for rockchip platform only seems some kind of regression for th=
is
> feature support.
>=20
>=20
> Hi Simon and Tom,
>=20
> =A0=A0=A0=A0 Could you help to give some suggestion for this?

This should be using bloblist, yes, as I understand it.

--=20
Tom

--87/R+F6OM59gh2VM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYEDT4ACgkQFHw5/5Y0
tyxbIQv+KIMl0EBMSZZn5wQe8MaQqWkwpuyFbQ1wImaoR8uiapRVgBjadDHMPt8D
Bw6YPHfdlfU6KisaR2RHTD7AhlOsb989jex+l5RPmEDflOXtezXdCbRRLd7oo1Mw
Hx8gTW8xyHqN3uhkFqzrsCBiFsaxMVV5LcEbHlLufvL0+x6U0N1vOfV8oewPkzMc
krSTQnp01UAPP6Vic2r/ch9wu2RRlhU5R0xstrsKx5j5Hb7lJbtDe6Zm9vL8zdsp
+nAG6toVbZr9zuSaLnVOtjLOGt4E7uS0nHb/y11P/r0C/QB5F8DCaHQU+OZaIUro
suxh5MfEOr7sqO8a33zL8tDrBjHte5aELABQaXBjDYbmx6lXWJPcQblfaNH5tIjL
wNjPMtg0nW83vwMtBpr5fmFjmna98CdI3K9pMSqhHZvP+dOrU6GLukUZIQGAwWEs
3s+RkbH3Wg7dHN7ZkJ3AUIDB/NbR+jFDTq/w2PkjKQf9NjqVsNE9wK7jDuFJicrE
0+BOG3vV
=9MFy
-----END PGP SIGNATURE-----

--87/R+F6OM59gh2VM--
