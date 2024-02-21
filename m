Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7F7C48BEB
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 15:23:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF296879A2;
	Wed, 21 Feb 2024 16:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AC6WPVhz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF9C87E3E; Wed, 21 Feb 2024 16:23:51 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2FA879A2
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 16:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6088276045fso7506167b3.2
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 07:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708529027; x=1709133827; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dlPuxhZ2aCLFKqykcNM/8DF+n1T+ByiWqGDm0wauB1Q=;
 b=AC6WPVhzB81lyQ+Cr+lO+6OmR7tmRF18p9qBSN8w2NUdBf/Ak1xhKLJ7Xk/gyKP7Ky
 6qQInDVa6TFqjo4K84hc8uoUuC3M7E7IdL46NmBPuKSt+qZ76PG+2uBHEYpZD1Kcl+oe
 hdbw6GYBRhsTRB5OOj35s9zWdXK66+WxI8J5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708529027; x=1709133827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dlPuxhZ2aCLFKqykcNM/8DF+n1T+ByiWqGDm0wauB1Q=;
 b=hiktbBtOopioM/+6Ydk8UoGFgG0FzVqI5cscNmGC2gAxPJPc9xZ1Kal3gRP6YXj+0n
 WMXJc2p07nJjewQwPZURObU/qiD0vxrbZIe+jP3p4atSRpXT+6pRJwnY0oDDqTb9Lgkp
 nBa9W56eNeaspSlNU26KPoZ9+p8984Nkh8AT3QbP13OGczwxUmnzjRrt+FUMDJdiz15/
 6oxTnSQ28biaQnTptSgwgkbvPOc1UARD5175bGDqiwrQ6HUmz1k5CFAN4gnH1knji+dv
 jf6GEV0iRDOU66ooeLlQs+qjnPHzR2lF44QQVRfbEtlDQN9QPwPTG5NlTvVQnksr5Uch
 vTOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcxfRNDT1HNTnmtGdZ2DjFosEgkE5HaAb2V04F3gfsk3tzgAtgD3BtkNtd3l220wOeC2IvfDkaCbiQbtp9wyvspukgYw==
X-Gm-Message-State: AOJu0Yxomf1TOsdMGq8k9N0x/7uO/zzPZ83M0V+ZZ5oVLagPJaZ6eWKe
 /2H4nH9ctgXPYVHKofWBEsvT7gvj9U52f1+peo4O3nWzyJpC7B9JIl3spYn55nE=
X-Google-Smtp-Source: AGHT+IHxb2VTPW9Gh1R/8PAoqsEEHfUZuSzuRQfe7gTgzG7pMlx6TS2dM0vFUsyprte8QM+bj0nerw==
X-Received: by 2002:a81:9297:0:b0:607:cd29:8ae7 with SMTP id
 j145-20020a819297000000b00607cd298ae7mr19949111ywg.15.1708529027468; 
 Wed, 21 Feb 2024 07:23:47 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 w184-20020a8186c1000000b00604a0aedd92sm2603477ywf.108.2024.02.21.07.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Feb 2024 07:23:46 -0800 (PST)
Date: Wed, 21 Feb 2024 10:23:44 -0500
From: Tom Rini <trini@konsulko.com>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: "clamor95@gmail.com" <clamor95@gmail.com>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
 "francesco@dolcini.it" <francesco@dolcini.it>,
 "sbabic@denx.de" <sbabic@denx.de>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "treding@nvidia.com" <treding@nvidia.com>
Subject: Re: [PATCH v1 5/7] toradex: common: Add sysinfo driver
Message-ID: <20240221152344.GU3040305@bill-the-cat>
References: <20240220182926.101161-1-francesco@dolcini.it>
 <20240220182926.101161-6-francesco@dolcini.it>
 <CAPVz0n1oQZR5muRGHFm66hY6jEA8cSVUdJG0t2WTqV=oC6DiEA@mail.gmail.com>
 <bf6806f9ca2444bcbf634cad379e9f34f7aa581c.camel@toradex.com>
 <20240221131002.GT3040305@bill-the-cat>
 <c7d26d3a59e48582286bc889b67dacdf9e02cbdc.camel@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nf4eePQ9Dkm22+xp"
Content-Disposition: inline
In-Reply-To: <c7d26d3a59e48582286bc889b67dacdf9e02cbdc.camel@toradex.com>
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


--nf4eePQ9Dkm22+xp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 02:24:23PM +0000, Marcel Ziswiler wrote:
> Hi Tom
>=20
> On Wed, 2024-02-21 at 08:10 -0500, Tom Rini wrote:
> > On Tue, Feb 20, 2024 at 07:51:35PM +0000, Marcel Ziswiler wrote:
> > > On Tue, 2024-02-20 at 21:14 +0200, Svyatoslav Ryhel wrote:
> > > > =D0=B2=D1=82, 20 =D0=BB=D1=8E=D1=82. 2024=E2=80=AF=D1=80. =D0=BE 20=
:29 Francesco Dolcini <francesco@dolcini.it> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >=20
> > > > > From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > > >=20
> > > > > This commit introduces support for the Toradex sysinfo driver in =
U-Boot,
> > > > > which uses information from Toradex config block to print correct
> > > > > board model.
> > > > > In case the Toradex config block is not present sysinfo prints th=
e model
> > > > > of the board provided by device tree removing per board specific =
prints.
> > > > >=20
> > > > > Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> > > > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > > > ---
> > > > > =C2=A0arch/arm/dts/fsl-imx8qm-apalis-u-boot.dtsi=C2=A0=C2=A0=C2=
=A0 |=C2=A0 6 +++
> > > > > =C2=A0arch/arm/dts/fsl-imx8qxp-colibri-u-boot.dtsi=C2=A0 |=C2=A0 =
6 +++
> > > > > =C2=A0.../dts/imx6dl-colibri-eval-v3-u-boot.dtsi=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++
> > > > > =C2=A0arch/arm/dts/imx6q-apalis-eval-u-boot.dtsi=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++
> > > > > =C2=A0.../dts/imx6ull-colibri-eval-v3-u-boot.dtsi=C2=A0=C2=A0 |=
=C2=A0 4 ++
> > > > > =C2=A0.../arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi |=C2=A0 4 ++
> > > > > =C2=A0.../dts/imx8mm-verdin-wifi-dev-u-boot.dtsi=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++
> > > > > =C2=A0.../dts/imx8mp-verdin-wifi-dev-u-boot.dtsi=C2=A0=C2=A0=C2=
=A0 |=C2=A0 4 ++
> > > > > =C2=A0.../dts/k3-am625-verdin-wifi-dev-u-boot.dtsi=C2=A0 |=C2=A0 =
4 ++
> > > > > =C2=A0arch/arm/dts/tegra124-apalis-u-boot.dtsi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 12 +++++
> > > > > =C2=A0arch/arm/dts/tegra20-colibri-u-boot.dtsi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 12 +++++
> > > > > =C2=A0arch/arm/dts/tegra30-apalis-u-boot.dtsi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 12 +++++
> > > > > =C2=A0arch/arm/dts/tegra30-colibri-u-boot.dtsi=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 12 +++++
> > > > > =C2=A0.../arm/dts/vf610-colibri-eval-v3-u-boot.dtsi |=C2=A0 4 ++
> > > > > =C2=A0board/toradex/common/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 1 +
> > > > > =C2=A0board/toradex/common/tdx-common.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 50 ++++++++++++++++---
> > > > > =C2=A016 files changed, 136 insertions(+), 7 deletions(-)
> > > > > =C2=A0create mode 100644 arch/arm/dts/tegra124-apalis-u-boot.dtsi
> > > > > =C2=A0create mode 100644 arch/arm/dts/tegra20-colibri-u-boot.dtsi
> > > > > =C2=A0create mode 100644 arch/arm/dts/tegra30-apalis-u-boot.dtsi
> > > > > =C2=A0create mode 100644 arch/arm/dts/tegra30-colibri-u-boot.dtsi
> > > > >=20
> > > >=20
> > > > Greetings! Thank you for contribution but may you at split patches
> > > > according to SoC vendor at least? For imx, tegra and ti since it
> > > > would be hard to both review and pick them to correct custodian
> > > > trees.
> > >=20
> > > I would assume for those urgent fixes to go through Tom directly to m=
aster. Thanks!
> >=20
> > So this is a series we need for v2024.04 then?
>=20
> Yes, please. From the cover letter:
>=20
> > This series fixes two regressions affecting multiple Toradex boards (i.=
MX, TI and TEGRA based) and targets
> the current master, e.g. v2024.04 release.

OK, thanks. I'll wait a bit more for further feedback on the contents
themselves.

--=20
Tom

--nf4eePQ9Dkm22+xp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXWFX0ACgkQFHw5/5Y0
tyyMJQv+NmwbVUHxOvpAjR5eAwaWobGOjvgVLLj24JUOGhNQIIMeVuyYqRa5e02B
+JpfjQgf29BNPZh3VhNqtDK1lddVVOKW3mYQuo0m0oknvI2zGwDxchpTkel/wiId
sXYhc+JJp8BYcdXimqoPnbjPem6UxR2NhP4nJ0M0HCl32cC6Hx9Jvztot7TAKRgg
fTsvYUxjI4CkWgWMrAzLxqmuzXz1mbYuNy7jpJ/+6MDgSrDU0Yw57vadMd4jtU7v
x8omHiFa0+Zv9dbR7/5UnxTgr18s1cD4s8J3iOY4i0OrREqMbKBrIDMT1n+0oG5B
wo3hGBpQaR0/EPuZZ+LGQ+DUKMr3NfJtn/KgFqpAN7FEadtTum6kHEjJUv7ajn85
PFgOZQL1eTSfolXWN5cwJLGzRCr3h6/Rdw9+z3YzNvwQPcBHoxkeKIGzejWPAP60
jhn1RWpyQ7m8bpdlWUV0sg4+sZN0Lyh522UO4pTTAHeUNNxrWlnqX+mG8BZkNOun
vAY5t98a
=2Agl
-----END PGP SIGNATURE-----

--nf4eePQ9Dkm22+xp--
