Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C60C7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 16:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3567282D88;
	Wed, 25 Jun 2025 18:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kqd42AKm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F55082DF2; Wed, 25 Jun 2025 18:29:08 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF4F82D83
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 18:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A4F6560053;
 Wed, 25 Jun 2025 16:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDCBC4CEEA;
 Wed, 25 Jun 2025 16:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750868940;
 bh=NPJLWPmHA8jm+KGtxlnrJA+qFvYLC8uHDPU5y7nxAho=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kqd42AKmt8b4+rj3j2+VtfxOjhXARKCV4mTJBng8p5+jM+tTD478gNxAmPGKo8wH0
 aHu4/NKrCJaHl4elkxksdoSrxWRtdCDPdTeprsoPJBWQMuWVUgR2MLeaVZqnUAGqwv
 zyDMLlQw/v7COmKbIu8CxgSl5cCnhPBJwpSNmDDZf189FyWXo9rXJb6s0+ijIWxlqQ
 bj5nbKIKoJua61jSLKMcZc3RP34w55WKWQGNfe43Xrl8pVTFmXfJecndTGsvMvFIFU
 2wWmHHywOF8678Din4WrH7Bk66kKyTYa+vRcS+zoW6uzfJpsAb9iNXpV1UtUeKpnXK
 7LCazg17hKQkA==
Date: Wed, 25 Jun 2025 17:28:56 +0100
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Lukasz Majewski <lukma@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 albert.aribaud@3adev.fr, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] dts: Add u-boot specific 'fsl,mux_mask' property to
 iomuxc for vf610
Message-ID: <20250625-stylishly-expiring-c37b5a0a52fb@spud>
References: <20250624204700.972663-1-lukma@denx.de>
 <20250624204700.972663-2-lukma@denx.de>
 <20250624210116.GL4003484@bill-the-cat>
 <20250625083637.1d286cec@wsk>
 <20250625141424.GN4003484@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xPO7eMjQYnGCKQrL"
Content-Disposition: inline
In-Reply-To: <20250625141424.GN4003484@bill-the-cat>
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


--xPO7eMjQYnGCKQrL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 08:14:24AM -0600, Tom Rini wrote:
> On Wed, Jun 25, 2025 at 08:36:37AM +0200, Lukasz Majewski wrote:
> > Hi Tom,
> >=20
> > > On Tue, Jun 24, 2025 at 10:47:00PM +0200, Lukasz Majewski wrote:
> > >=20
> > > > The commit e8a9521e649f
> > > > ("vf500/vf610: synchronise device trees with linux")
> > > > has synchronized U-Boot's DTS with v5.19 Linux kernel.
> > > > It turned out that in Linux's upstream iomuxc node description the
> > > > fsl,mux_mask' was missing, so the U-Boot's pinctrl driver for NXP's
> > > > Vybrid SoC was not working properly.
> > > >=20
> > > > As by default the mux mask was set to 0, the vf610 based boards
> > > > (like BK4) were bricked, due to misconfiguration of gpio at early
> > > > boot stage.
> > > >=20
> > > > The fix for all vf610 based boards is to introduce
> > > > vfxxx-u-boot.dtsi file with 'fsl,mux_mask' property provided and
> > > > include it in boards' specific U-Boot adjustment files (like
> > > > vf610-bk4r1-u-boot.dtsi).
> > > >=20
> > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > ---
> > > >  arch/arm/dts/vf610-bk4r1-u-boot.dtsi | 2 ++
> > > >  arch/arm/dts/vfxxx-u-boot.dtsi       | 9 +++++++++
> > > >  2 files changed, 11 insertions(+)
> > > >  create mode 100644 arch/arm/dts/vfxxx-u-boot.dtsi =20
> > >=20
> > > It looks like this is still missing upstream, so what's the status on
> > > that?=20
> >=20
> > It looks like in Linux the mux_mask is hardcoded (for Vybrid vf610):
> > https://elixir.bootlin.com/linux/v6.16-rc3/source/drivers/pinctrl/frees=
cale/pinctrl-vf610.c#L321
> >=20
> > In u-boot other SoCs use it as well, but with different values:
> > - arch/arm/dts/imxrt1050.dtsi -> 0x7
> > - arch/arm/dts/imx8ulp-evk-u-boot.dtsi -> 0xf00
> >=20
> > In the imx8ulp case above - it is already set in *-u-boot.dtsi specific
> > file, so I've followed this approach.
>=20
> Someone should unify upstream to one approach or another I would think.
> Or find a good explanation as to why it's not unified, and then we
> should follow.

If these values are per-SoC, which they appear to be given these
look like 3 different devices, I don't see a reason for these to be
accepted "upstream".

And if there're not per-SoC then please make sure the _ becomes a - in
the property name Lukasz.

> I'm not nak'ing this patch but I am noting a problem that needs to be
> addressed.

--xPO7eMjQYnGCKQrL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaFwjyAAKCRB4tDGHoIJi
0j07AQCcDZekPyzjKI7RFBx03UzTiRPqPzFhRxf2vam55oaXtAD+KQdfKIu8Wgr9
73oHnrIgl6opZorpbBkCm4xVjzIo+g4=
=90w6
-----END PGP SIGNATURE-----

--xPO7eMjQYnGCKQrL--
