Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07EAC77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 06:36:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB88982977;
	Wed, 25 Jun 2025 08:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750833405;
	bh=ik862NtcuSdSBGpkk2ODYFmoAO3xypsWfLGvKmu09Tk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qUkeKa+TuCOU0LgdPGjeGvzpKMJBFzAk4GAkkcT7j3MefaRkdSzOBYUYYRpkyxy2p
	 SEH+O8slvKuG03UTFEiusQjobhWiqLrNGGbY9hCbH1dO8xhD+XwSXMqlR5Br9VnmmX
	 9meXX0bnRZqsbsoRX/E/0LYzvvEGykOm5q8FgA/oe4XwP+T0EfW0II/Qp6mf87Qs2H
	 CDMU7qcL8hVQb4ExTMZSXoB8Q0CX+OUgM82D3vtFZswlIAQIHXFFmaqx902YzZI4IX
	 H9+HPZOLZwGTpMGIVxAsfkl0Ws7I4ttbHxILDIUUBzuAXkYkeQ1I+frcumSv5Aona5
	 FvGs0oyMxgnZA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0597803CC; Wed, 25 Jun 2025 08:36:44 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7215482977
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 08:36:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="M77vLDgE"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6EFDA1039BD04; 
 Wed, 25 Jun 2025 08:36:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1750833401; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=ik862NtcuSdSBGpkk2ODYFmoAO3xypsWfLGvKmu09Tk=;
 b=M77vLDgEugjzomZRf1VuphMfhAx1D1yBa+fyz+CqcLXv5Wo2mPg135C1yQPOur9tKVmP4l
 usPv6GFrXXktsFZtHd5pTRT2rY4I6ZVFsrolUp7UoVlRmQDPHtlFjSvQnaNpyFN5ivqjaw
 m7+/8DkW9U9TjMYAJYjFVgta8X2tLQ5E+N/t3d/uZRxIdFgHauRJHPQJay/s7Iwjayb1Ns
 g3Ziicm4gZpPYceGB8hwHVgHsXqvLfA71hI3RC4smdAK5phR6qLOkr/LpQXpGA6jlyBM57
 pOmmIQXcA/CSrjBgJ0K6qzppJwlXfKL9Y6IL8cQ1XURRJS8CFo+6x+9zZc+rTg==
Date: Wed, 25 Jun 2025 08:36:37 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 uboot-imx@nxp.com, albert.aribaud@3adev.fr, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] dts: Add u-boot specific 'fsl,mux_mask' property to
 iomuxc for vf610
Message-ID: <20250625083637.1d286cec@wsk>
In-Reply-To: <20250624210116.GL4003484@bill-the-cat>
References: <20250624204700.972663-1-lukma@denx.de>
 <20250624204700.972663-2-lukma@denx.de>
 <20250624210116.GL4003484@bill-the-cat>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lkqFA5bLL86.3lyCN4HrkLn";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Last-TLS-Session-Version: TLSv1.3
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

--Sig_/lkqFA5bLL86.3lyCN4HrkLn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tom,

> On Tue, Jun 24, 2025 at 10:47:00PM +0200, Lukasz Majewski wrote:
>=20
> > The commit e8a9521e649f
> > ("vf500/vf610: synchronise device trees with linux")
> > has synchronized U-Boot's DTS with v5.19 Linux kernel.
> > It turned out that in Linux's upstream iomuxc node description the
> > fsl,mux_mask' was missing, so the U-Boot's pinctrl driver for NXP's
> > Vybrid SoC was not working properly.
> >=20
> > As by default the mux mask was set to 0, the vf610 based boards
> > (like BK4) were bricked, due to misconfiguration of gpio at early
> > boot stage.
> >=20
> > The fix for all vf610 based boards is to introduce
> > vfxxx-u-boot.dtsi file with 'fsl,mux_mask' property provided and
> > include it in boards' specific U-Boot adjustment files (like
> > vf610-bk4r1-u-boot.dtsi).
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  arch/arm/dts/vf610-bk4r1-u-boot.dtsi | 2 ++
> >  arch/arm/dts/vfxxx-u-boot.dtsi       | 9 +++++++++
> >  2 files changed, 11 insertions(+)
> >  create mode 100644 arch/arm/dts/vfxxx-u-boot.dtsi =20
>=20
> It looks like this is still missing upstream, so what's the status on
> that?=20

It looks like in Linux the mux_mask is hardcoded (for Vybrid vf610):
https://elixir.bootlin.com/linux/v6.16-rc3/source/drivers/pinctrl/freescale=
/pinctrl-vf610.c#L321

In u-boot other SoCs use it as well, but with different values:
- arch/arm/dts/imxrt1050.dtsi -> 0x7
- arch/arm/dts/imx8ulp-evk-u-boot.dtsi -> 0xf00

In the imx8ulp case above - it is already set in *-u-boot.dtsi specific
file, so I've followed this approach.

> Thanks.
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/lkqFA5bLL86.3lyCN4HrkLn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhbmPUACgkQAR8vZIA0
zr0/Xgf8CklRwq9NP6Eip3PMQCYTnZMRQGt2yC3zyPfF44ax9pnMHKN25l09tEzZ
7IY2k9FSGeVS8rqswj35H7tdMc7rFRDNsGo//135AEc4eAJDY74Ud6v8bGhQXQ8y
PWihBjSOrb3WVS+h7tzwVgyS9agofaaM7d301fnZLXF8lZOyCG8vEI2DXY1up9J/
8+JQCnRwlCcK29sl7MoQmuO18sg9tTArAZlYrHSZKMagt0UJ3FxIw816bnlNdZk0
dXlSI0lserx4ZYZ9TCwCrFZ8qW8LrIZbiHNzWuy8Kp+9wu4h2zHnpgaY2n9AY8gB
aNCmit3Nke6VWihOz069FFcyOhztdw==
=tpoj
-----END PGP SIGNATURE-----

--Sig_/lkqFA5bLL86.3lyCN4HrkLn--
