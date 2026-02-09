Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56572E81BC9
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 14:04:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D08839A5;
	Mon,  9 Feb 2026 15:04:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tMfSCeyh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51408839D5; Mon,  9 Feb 2026 15:04:02 +0100 (CET)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B25F38341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 15:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7cfd0f349c4so2702597a34.1
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 06:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770645838; x=1771250638; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=w8JLmVxXffwBoZqNQoIH5NH5DIg8Lc1CXD7sIQ78cDM=;
 b=tMfSCeyhuXsmu/1amEW80e2PTOMRS/ckfYLevbngkO9ef7JDr4hAe8lw03CMmBV87I
 QuWcfvlxK7qyS/cEbYEF41G5pnkoyoh1lbz4Gg1mk746koxIqTylKAakJp5fJVq0ukMI
 YfLluxGU/m6ExQg/pW71DlZLMhPZ6NKBuU6yE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770645838; x=1771250638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w8JLmVxXffwBoZqNQoIH5NH5DIg8Lc1CXD7sIQ78cDM=;
 b=HzeOQ5mqBi8FxcdFnrC1+EV/DBI7G4FUD06KsQiKuCQdVwjNDjPgEjfl07xgL97JWG
 /NEI+4sASkxC9wYi8dvdvqCMz+4t1jE6hY/XvMR+RbjURdsBx2FPyYgcX/6Og1lCMZXM
 wE6ocUO50jAtPrjnZjpLOErLwQxNmML1j0o97QShflF8m/9+jw0RwU08+9AVeckRxUdg
 ys1IqChMD7GYm7sHGOpWWanOGjRl0P6FVhTZcT9BU6tpb30BLkjolltRexhiblhdKokK
 LI1JjrVJoQfYNTBtDZGiiLKB3yD5LXSLzsNi7JhxhUYdCz7ZxvOBMoYSKNrSeWKT/ouc
 ql4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8nnMcWH+9E5GLo7fZPy82YT9zNnewyIFrPaRBS78zlW1rH1Jn3NQ87mWfn/zjtLFImjNN7J0=@lists.denx.de
X-Gm-Message-State: AOJu0YxRF+oY2IuiOkUIMjmtCz93SkZQ0p0eddyjRzA37hSHWVdMORTO
 mWDOEypXuMW7WiryHA5B9eUc1RZr3ig/JDntz41hjrW1VsLuvlJO9Zberj3getZ4Hbk=
X-Gm-Gg: AZuq6aJhWildJxS0Iz1kwcUxy0zMLfZ7f9K9JacRRhfbhb9stnu+Ri20SaJPLZxeHC0
 2OA3EOfHjFTUwdhLRyrB1f9C9vQ/JwM+RKm9CjlusdFFWK8jyNCUv71UG+No3sKNXMBuIhlffb6
 +HxoXxW2+2oZ0B/+WQvHartuB/b7zvlTwmLTvaJRsgpCKcEmr/X/9TauyeJYAwrgNWqy7RZcyNE
 dlhSjEwX/Z8E1MtC6f6q21q6Hhn8Wppd+2Kx/5pAntK/Ck/OcVCrX3FtYg/DBXf/Zw3HU7GaS4A
 djgwBLJ0jvK9An65xup1c1JIVSkpGe3Noc7YEtnSzym1x//osFKPpybd4ZuHquMixVH2ekiFutP
 miH1dCrAeGrxM9wc4iQ11fCkC2ob2P61yLunnp9cYydSHyrGPA3UXPUu/ipdUfZ9zvWfiYZsREl
 4xiDN2VYQ9nyCuqf3sCM8Wn+VRDgaAA+hGck/fbjBCKEvqZippFdRWHAJMb06JVkIyFclCqDJaJ
 b7DP7Qbk06W3Q7xxW0jCft/1yIi2L1+O3mUM0A=
X-Received: by 2002:a05:6830:3155:b0:7cf:dd34:8e1f with SMTP id
 46e09a7af769-7d4644861acmr7407432a34.18.1770645838341; 
 Mon, 09 Feb 2026 06:03:58 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d464785f68sm7229286a34.16.2026.02.09.06.03.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 06:03:57 -0800 (PST)
Date: Mon, 9 Feb 2026 08:03:54 -0600
From: Tom Rini <trini@konsulko.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, "Ross, Fedor" <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <frank.li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Alice Guo <alice.guo@nxp.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjEgMTAv?=
 =?utf-8?Q?12=5D_dts=3A_upstream?= =?utf-8?Q?=3A?= arm64: freescale: Sync
 i.MX952 device tree from Linux
Message-ID: <20260209140354.GD2603314@bill-the-cat>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-10-2103d0222a0b@nxp.com>
 <20260205153850.GK2603314@bill-the-cat>
 <PAXPR04MB964411EF269E12B1B7F20689E265A@PAXPR04MB9644.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zCBscR9UVLPQ5hvh"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB964411EF269E12B1B7F20689E265A@PAXPR04MB9644.eurprd04.prod.outlook.com>
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


--zCBscR9UVLPQ5hvh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 09, 2026 at 10:34:24AM +0000, Alice Guo (OSS) wrote:
> > -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Tom Rini <trini@konsulko.com>
> > =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2026=E5=B9=B42=E6=9C=885=E6=97=A5=
 23:39
> > =E6=94=B6=E4=BB=B6=E4=BA=BA: Alice Guo (OSS) <alice.guo@oss.nxp.com>
> > =E6=8A=84=E9=80=81: dl-uboot-imx <uboot-imx@nxp.com>; u-boot@lists.denx=
=2Ede; Stefano
> > Babic <sbabic@nabladev.com>; Fabio Estevam <festevam@gmail.com>; Peng
> > Fan <peng.fan@nxp.com>; Ye Li <ye.li@nxp.com>; Jindong Yue
> > <jindong.yue@nxp.com>; Jacky Bai <ping.bai@nxp.com>; Marek Vasut
> > <marek.vasut+renesas@mailbox.org>; Rasmus Villemoes <ravi@prevas.dk>;
> > Ross, Fedor <fedor.ross@ifm.com>; Jo=C3=A3o Paulo Gon=C3=A7alves
> > <joao.goncalves@toradex.com>; Patrice Chotard
> > <patrice.chotard@foss.st.com>; Valentin Caron <valentin.caron@foss.st.c=
om>;
> > Vinh Nguyen <vinh.nguyen.xz@renesas.com>; Sam Protsenko
> > <semen.protsenko@linaro.org>; Ranjani Vaidyanathan
> > <ranjani.vaidyanathan@nxp.com>; Ji Luo <ji.luo@nxp.com>; Frank Li
> > <frank.li@nxp.com>; Sumit Garg <sumit.garg@oss.qualcomm.com>; Adam
> > Ford <aford173@gmail.com>; Frieder Schrempf
> > <frieder.schrempf@kontron.de>; David Zang <davidzangcs@gmail.com>;
> > Andrew Goodbody <andrew.goodbody@linaro.org>; Sumit Garg
> > <sumit.garg@kernel.org>; Marek Vasut <marex@nabladev.com>; Joseph Guo
> > <qijian.guo@nxp.com>; tharvey@gateworks.com; Alice Guo
> > <alice.guo@nxp.com>
> > =E4=B8=BB=E9=A2=98: Re: [PATCH v1 10/12] dts: upstream: arm64: freescal=
e: Sync i.MX952
> > device tree from Linux
> >=20
> > On Thu, Feb 05, 2026 at 09:55:16PM +0800, alice.guo@oss.nxp.com wrote:
> >=20
> > > From: Alice Guo <alice.guo@nxp.com>
> > >
> > > Sync i.MX952 device tree files from linux-next next-20260202:
> > > - Add imx952.dtsi for SoC
> > > - Add imx952-evk.dts for i.MX952 EVK board
> > > - Add imx952-*.h headers for clock, pinctrl and power
> > >
> > > Imported from linux-next commit 193579fe0138 ("Add linux-next specific
> > > ifiles for 20260202")
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > ---
> > >  dts/upstream/src/arm64/freescale/imx952-clock.h   |  215 ++++
> > >  dts/upstream/src/arm64/freescale/imx952-evk.dts   |  596 ++++++++++
> > >  dts/upstream/src/arm64/freescale/imx952-pinfunc.h |  867
> > ++++++++++++++
> > >  dts/upstream/src/arm64/freescale/imx952-power.h   |   44 +
> > >  dts/upstream/src/arm64/freescale/imx952.dtsi      | 1266
> > +++++++++++++++++++++
> > >  5 files changed, 2988 insertions(+)
> >=20
> > This needs to be done (as a series of, if needed) tools/update-subtree.=
sh
> > cherry-pick operations. That gives the right commit message format that
> > shows these are changes from upstream.
> >=20
> > --
> > Tom
>=20
> Hi Tom,
>=20
> Thank you for the review. These i.MX952 files are not yet available in th=
e devicetree-rebasing repository, so I cannot use the standard workflow: ./=
tools/update-subtree.sh pick dts <devicetree-rebasing-commit-id>
>=20
> Should I wait for the devicetree-rebasing sync?

Yes, or not use OF_UPSTREAM until the device tree are in an upstream
kernel tag.

--=20
Tom

--zCBscR9UVLPQ5hvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYnpRwAKCRAr4qD1Cr/k
ChLGAP49XX5820v/7FW+XBkUEKlBUAucjibfp4AkjhVjA+BI8QEAkyPkgFt6oLdA
3zPULzqkTUqyoPzIswDS5cGxfKtjqA8=
=AGxN
-----END PGP SIGNATURE-----

--zCBscR9UVLPQ5hvh--
