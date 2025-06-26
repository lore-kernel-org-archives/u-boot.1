Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B704C77B7F
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 06:17:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7438C82D21;
	Thu, 26 Jun 2025 08:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1750918659;
	bh=Vp9os7f0LFYzAcjS/lSClJW9V7i8RCKkuS+7SUFwPaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=l3VUha+F4KCA1jTwpB8A4GEaTCgQoOP3BFNBCIj7SLfnd59rgcHktSmw6EpvqBowf
	 n3vSvRQkAIwFHhI6KH7Gy5gcpFH3RJLRBL1H7Vp+DsNdZkv6O7mQ0kK8iRcDOdSpRJ
	 k58iwPlqixB4ID7VIrpOiltcEazUpP6DeqQjTizX7YLwXfGXw/W6MRHwBMsIPa2GHP
	 /oTCKWKgu12yG8AAq/4lKhCLcC3QeyeAAh1TW62uyFHLDhwA7oWLEn2ITrjTmI+N7J
	 NYIwkz/OaJXrU+TtCRzOxDbG9+qT4vrv6JWXhtKybhBrgm5y/xbKWVihFk2Y0gH+SN
	 BOnyOcJC/rD3w==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2961982D83; Thu, 26 Jun 2025 08:17:38 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75D7A82AA4
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 08:17:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lukma@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="FoWZ0dLq"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9A07210397285; 
 Thu, 26 Jun 2025 08:17:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1750918653; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=Vp9os7f0LFYzAcjS/lSClJW9V7i8RCKkuS+7SUFwPaE=;
 b=FoWZ0dLqOuA+sMujlKcGwwnP0pTetTSpIVKY+2PDZnfb88aECXzIXHwd4v5ioY7V9teLkU
 +w6dxGmiR+q4jUQa4yH/OI922yzpiIHpEBp5roaCGqp8k2pE7jSRzzq2RKmJtPH/sUm7Fj
 fHU/IUOpBfpnfaMSdhQEm6EY6P/tEJgVF61nG67vYcrVTSXr0IzK+yJaLe4swd+2ao0nqf
 9UuoqWhhX9mxzHyxr56o5N5DVx7aJylkRRAFruvevQJDaRJ43TP2VvmLgyoH1P1+udXBNO
 SCVGnAmm9UKr/CV+SHgyRiLyKIZMcpjBKBGv6Vmtkp2QEFullESeEioJlEPBzQ==
Date: Thu, 26 Jun 2025 08:17:25 +0200
From: Lukasz Majewski <lukma@denx.de>
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 albert.aribaud@3adev.fr, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] dts: Add u-boot specific 'fsl,mux_mask' property to
 iomuxc for vf610
Message-ID: <20250626081725.45b947a3@wsk>
In-Reply-To: <20250625205255.GU4003484@bill-the-cat>
References: <20250624204700.972663-1-lukma@denx.de>
 <20250624204700.972663-2-lukma@denx.de>
 <20250624210116.GL4003484@bill-the-cat>
 <20250625083637.1d286cec@wsk>
 <20250625141424.GN4003484@bill-the-cat>
 <20250625-stylishly-expiring-c37b5a0a52fb@spud>
 <20250625163742.GR4003484@bill-the-cat>
 <20250625223250.43470703@wsk>
 <20250625205255.GU4003484@bill-the-cat>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/IM=r=4.DuNUJozLzEwRCZk4";
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

--Sig_/IM=r=4.DuNUJozLzEwRCZk4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tom,

> On Wed, Jun 25, 2025 at 10:32:50PM +0200, Lukasz Majewski wrote:
> > Hi Tom,
> >  =20
> > > On Wed, Jun 25, 2025 at 05:28:56PM +0100, Conor Dooley wrote: =20
> > > > On Wed, Jun 25, 2025 at 08:14:24AM -0600, Tom Rini wrote:   =20
> > > > > On Wed, Jun 25, 2025 at 08:36:37AM +0200, Lukasz Majewski
> > > > > wrote:   =20
> > > > > > Hi Tom,
> > > > > >    =20
> > > > > > > On Tue, Jun 24, 2025 at 10:47:00PM +0200, Lukasz Majewski
> > > > > > > wrote:  =20
> > > > > > > > The commit e8a9521e649f
> > > > > > > > ("vf500/vf610: synchronise device trees with linux")
> > > > > > > > has synchronized U-Boot's DTS with v5.19 Linux kernel.
> > > > > > > > It turned out that in Linux's upstream iomuxc node
> > > > > > > > description the fsl,mux_mask' was missing, so the
> > > > > > > > U-Boot's pinctrl driver for NXP's Vybrid SoC was not
> > > > > > > > working properly.
> > > > > > > >=20
> > > > > > > > As by default the mux mask was set to 0, the vf610 based
> > > > > > > > boards (like BK4) were bricked, due to misconfiguration
> > > > > > > > of gpio at early boot stage.
> > > > > > > >=20
> > > > > > > > The fix for all vf610 based boards is to introduce
> > > > > > > > vfxxx-u-boot.dtsi file with 'fsl,mux_mask' property
> > > > > > > > provided and include it in boards' specific U-Boot
> > > > > > > > adjustment files (like vf610-bk4r1-u-boot.dtsi).
> > > > > > > >=20
> > > > > > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > > > > > ---
> > > > > > > >  arch/arm/dts/vf610-bk4r1-u-boot.dtsi | 2 ++
> > > > > > > >  arch/arm/dts/vfxxx-u-boot.dtsi       | 9 +++++++++
> > > > > > > >  2 files changed, 11 insertions(+)
> > > > > > > >  create mode 100644 arch/arm/dts/vfxxx-u-boot.dtsi     =20
> > > > > > >=20
> > > > > > > It looks like this is still missing upstream, so what's
> > > > > > > the status on that?    =20
> > > > > >=20
> > > > > > It looks like in Linux the mux_mask is hardcoded (for Vybrid
> > > > > > vf610):
> > > > > > https://elixir.bootlin.com/linux/v6.16-rc3/source/drivers/pinct=
rl/freescale/pinctrl-vf610.c#L321
> > > > > >=20
> > > > > > In u-boot other SoCs use it as well, but with different
> > > > > > values:
> > > > > > - arch/arm/dts/imxrt1050.dtsi -> 0x7
> > > > > > - arch/arm/dts/imx8ulp-evk-u-boot.dtsi -> 0xf00
> > > > > >=20
> > > > > > In the imx8ulp case above - it is already set in
> > > > > > *-u-boot.dtsi specific file, so I've followed this
> > > > > > approach.   =20
> > > > >=20
> > > > > Someone should unify upstream to one approach or another I
> > > > > would think. Or find a good explanation as to why it's not
> > > > > unified, and then we should follow.   =20
> > > >=20
> > > > If these values are per-SoC, which they appear to be given these
> > > > look like 3 different devices, I don't see a reason for these
> > > > to be accepted "upstream".   =20
> > >=20
> > > OK, yes. But it should either be "hard code a thing" or "get the
> > > property" not maybe-one-maybe-the-other? That was what I was
> > > trying to make as my point.
> > >  =20
> >=20
> > Agreed.
> >=20
> > Then some decision shall be made if:
> >=20
> > 1. We keep the fsl,mux-mask as *-u-boot.dtsi specific
> >=20
> > 2. Modify the pinctrl driver for Vybrid
> > (drivers/pinctrl/nxp/pinctrl-imx-mmio.c) and maybe add mux_mask
> > field to:
> > https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pinctrl/nxp/=
pinctrl-imx.h?ref_type=3Dheads#L26
> >=20
> > 3. Try to upstream (to Linux) the property. That would require
> > rewriting kernel pinctrl driver for vf610 to parse "fsl,mux_mask"
> > property.
> >=20
> > As Conor pointed out - the approach from 3. is not feasible.
> >=20
> > Then we shall decide if 1. or 2. shall be implemented.
> >=20
> > Approach from 1. doesn't require any driver's modification. Approach
> > from 2. would introduce the extra field and some code modification
> > to:
> > https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pinctrl/nxp/=
pinctrl-imx.c?ref_type=3Dheads
> > and
> > https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pinctrl/nxp/=
pinctrl-imx-mmio.c?ref_type=3Dheads
> >=20
> > I would personally opt for 1. =20
>=20
> Well, my question is wouldn't option 2 bring us closer to how this
> works in Linux?
>=20

Yes, it should.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/IM=r=4.DuNUJozLzEwRCZk4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmhc5fUACgkQAR8vZIA0
zr0rQQgAy7de29upWC9r33YH/wdmYTKVaH/Xzav7Byx1MLO1N9dDbyMc4mVx9tdo
h/af4a3o0RIRQZmUby42AkMirjjghldSDSukrVMUqN5fXf6ZXivEJJ3IQGjm2peY
Fi1NMkv9dYsUzwT0iStm3SNm0odcl6CU6wpQqsoe6Kr2NThWdJlHHyW+PjbRsimw
96zZZHx+Va7FFTmPhaUYKVn6Y6+ILKGsK4/L+1djuI5uyM3bixvtz111KebKcek4
aJ4BoXufaBHXxEFKCKJDwIMnQG2dKxI1JXO2HRklqjhliKUEX64NO7PZJ9fyyhko
l48r0S0+h9GGrSNzzEOZ15iplYiyEQ==
=TgU+
-----END PGP SIGNATURE-----

--Sig_/IM=r=4.DuNUJozLzEwRCZk4--
