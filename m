Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A6D2C48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 13:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E5C98802C;
	Wed, 21 Feb 2024 14:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OxUhNqxu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C149E88036; Wed, 21 Feb 2024 14:10:10 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 562CB88026
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 14:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-60822b444c9so25238027b3.2
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 05:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708521005; x=1709125805; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FgPuT12AV9rCHGfYFra1ftN9KRaq6FpeWTqT8LYNnuQ=;
 b=OxUhNqxuYj2lly3sED3q8kCyPXdkA+QX7ky9hnRfQXpr3IiHrb/9u3r0Hxv4X8BCL3
 JgkUNKuD+l4mkKjs2rj9C5xo+W9GqbBbUKMSq0ZQuJAzNPhxqfQJ7SBaBy6Cl5c6f2wT
 jUs5OWdklE+9V2Szbx2N4GGowPWojJ2A16mXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708521005; x=1709125805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FgPuT12AV9rCHGfYFra1ftN9KRaq6FpeWTqT8LYNnuQ=;
 b=rfg5UwTZE+RzNwYnQ767+iUc2Zl7eRaeNAAGGku7+31Keuu9SfUV2wbPKUViXH0X+p
 mbYXpT6/drEyhaKr6kNbxC9NQ/JNwl5Y6VcfoK8vtmv56Ryhiv8R+VT33aEvd/cUUJ2c
 sCp9pIChCYIAWilvKxkoWS9MXilCoDYfnJKAviEG7Q5hxVRLralLVQixGf3tEQsAn+c4
 T/hhgGH/NJKlKFLKDLucojMedHja6Bjr6R/9z13j/sycSXxSpiqkywQqiuyPOdFi6CCp
 ylwickWoa5zJve1ZTcYDG+7Ppto+0exJo7Echjy+CS9VZhgVKNONi/BtMFgz3Wy51jmY
 JcSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgrJ8OgLstWOv5bRVV0KV8rV7vZPxRPGRNytH2CSNeZFddfKKazrsKQi2S+G6jKZZViiHn8QUjlX8ChDOkh/eKBLaGOg==
X-Gm-Message-State: AOJu0Yz60XZ/SUb1oMrNM07zoNH4JxpaaxsCUv3VEPNvCODD9mJlcPBR
 Nj6auTYwiz4IjfRBtel1G8Wq3k582eHv6oCHGxZpaoVOaXb4FrdHrhbj1NQr5o8=
X-Google-Smtp-Source: AGHT+IG0BVYxB6efYV041NHWdSLHJU+if6CpcdvMBenDAwbRCwgiNq4g1OFlu5yJmSbWZeEsPdWstQ==
X-Received: by 2002:a81:8341:0:b0:5ff:796e:481f with SMTP id
 t62-20020a818341000000b005ff796e481fmr17458661ywf.11.1708521005504; 
 Wed, 21 Feb 2024 05:10:05 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 l39-20020a81ad27000000b00607b9efdf49sm2576537ywh.2.2024.02.21.05.10.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 05:10:05 -0800 (PST)
Date: Wed, 21 Feb 2024 08:10:02 -0500
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "francesco@dolcini.it" <francesco@dolcini.it>,
 "clamor95@gmail.com" <clamor95@gmail.com>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "sbabic@denx.de" <sbabic@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "treding@nvidia.com" <treding@nvidia.com>
Subject: Re: [PATCH v1 5/7] toradex: common: Add sysinfo driver
Message-ID: <20240221131002.GT3040305@bill-the-cat>
References: <20240220182926.101161-1-francesco@dolcini.it>
 <20240220182926.101161-6-francesco@dolcini.it>
 <CAPVz0n1oQZR5muRGHFm66hY6jEA8cSVUdJG0t2WTqV=oC6DiEA@mail.gmail.com>
 <bf6806f9ca2444bcbf634cad379e9f34f7aa581c.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VkF+dos3vlzvqAXI"
Content-Disposition: inline
In-Reply-To: <bf6806f9ca2444bcbf634cad379e9f34f7aa581c.camel@toradex.com>
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


--VkF+dos3vlzvqAXI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 07:51:35PM +0000, Marcel Ziswiler wrote:
> On Tue, 2024-02-20 at 21:14 +0200, Svyatoslav Ryhel wrote:
> > =D0=B2=D1=82, 20 =D0=BB=D1=8E=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 20:29 =
Francesco Dolcini <francesco@dolcini.it> =D0=BF=D0=B8=D1=88=D0=B5:
> > >=20
> > > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > >=20
> > > This commit introduces support for the Toradex sysinfo driver in U-Bo=
ot,
> > > which uses information from Toradex config block to print correct
> > > board model.
> > > In case the Toradex config block is not present sysinfo prints the mo=
del
> > > of the board provided by device tree removing per board specific prin=
ts.
> > >=20
> > > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > > =C2=A0arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi=C2=A0=C2=A0=C2=A0 |=
=C2=A0 6 +++
> > > =C2=A0arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi=C2=A0 |=C2=A0 6 +++
> > > =C2=A0.../dts/imx6dl-colibri-eval-v3-u-boot.dtsi=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 ++
> > > =C2=A0arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 ++
> > > =C2=A0.../dts/imx6ull-colibri-eval-v3-u-boot.dtsi=C2=A0=C2=A0 |=C2=A0=
 4 ++
> > > =C2=A0.../arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi |=C2=A0 4 ++
> > > =C2=A0.../dts/imx8mm-verdin-wifi-dev-u-boot.dtsi=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 ++
> > > =C2=A0.../dts/imx8mp-verdin-wifi-dev-u-boot.dtsi=C2=A0=C2=A0=C2=A0 |=
=C2=A0 4 ++
> > > =C2=A0.../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi=C2=A0 |=C2=A0 4 ++
> > > =C2=A0arch/arm/dts/tegra124-apalis-u-boot.dtsi=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 12 +++++
> > > =C2=A0arch/arm/dts/tegra20-colibri-u-boot.dtsi=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 12 +++++
> > > =C2=A0arch/arm/dts/tegra30-apalis-u-boot.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 12 +++++
> > > =C2=A0arch/arm/dts/tegra30-colibri-u-boot.dtsi=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 12 +++++
> > > =C2=A0.../arm/dts/vf610-colibri-eval-v3-u-boot.dtsi |=C2=A0 4 ++
> > > =C2=A0board/toradex/common/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
> > > =C2=A0board/toradex/common/tdx-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 50 ++++++++++++++++---
> > > =C2=A016 files changed, 136 insertions(+), 7 deletions(-)
> > > =C2=A0create mode 100644 arch/arm/dts/tegra124-apalis-u-boot.dtsi
> > > =C2=A0create mode 100644 arch/arm/dts/tegra20-colibri-u-boot.dtsi
> > > =C2=A0create mode 100644 arch/arm/dts/tegra30-apalis-u-boot.dtsi
> > > =C2=A0create mode 100644 arch/arm/dts/tegra30-colibri-u-boot.dtsi
> > >=20
> >=20
> > Greetings! Thank you for contribution but may you at split patches
> > according to SoC vendor at least? For imx, tegra and ti since it
> > would be hard to both review and pick them to correct custodian
> > trees.
>=20
> I would assume for those urgent fixes to go through Tom directly to maste=
r. Thanks!

So this is a series we need for v2024.04 then?

--=20
Tom

--VkF+dos3vlzvqAXI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXV9icACgkQFHw5/5Y0
tyytdgwAtwK+aPrq44T3X2xwYTGcIVSEdOabRmsxBrjO5ThsWkdra1Ayon3ezrmV
aMvSeqdfbk/Jk/WzXyvv1/9l1MeBiruoI1KQaTiEaO8gZ/g3Xs10emGQjzOB3gs2
NHB1auEAxMpsuGRjX7VryfJwfwA9UHBg2EzH8eW1oNdgCu9cQ6n06OYxetSMXzj0
K6BpEvY3EvysrL6duhypT/qVg9I/Iq3vbQZxThBcBXAEImb/r1f0n32A0QBWwOx0
J2QPwS+CQr5uD4Xu75EOXo+D7ywWZoneI155mQXd370zBUDbYWMutcLn5+M8pp0g
tmIdzQ6Up+0vwM+hXAAEJTwgROKDX8zBwmXLR8+aRwhw5+AECl/KfDchpCtzH7PY
4f7UQx8xfy0Um7DZkr73KlplrwgSzH4ZXA1XAlS0GGwfkxFz/sWNPV9MLQmLp88l
xW3C/O9JYmtusF6a2NAvWvkJdk49DEN1iQ+6qascrM/YyFQ5iPH8SllJA0cHahXP
3bvUgUFX
=mE38
-----END PGP SIGNATURE-----

--VkF+dos3vlzvqAXI--
