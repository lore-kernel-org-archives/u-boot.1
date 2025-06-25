Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F68EC77B7C
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 20:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90AF582CFA;
	Wed, 25 Jun 2025 22:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T7WiX67V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F090182D21; Wed, 25 Jun 2025 22:53:09 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78EDE82C4C
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 22:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-407a6c6a6d4so134107b6e.1
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 13:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750884779; x=1751489579; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tPZBcSJjJyoArtv1w0slFZov+l7YHFVS0EkbFKXNImA=;
 b=T7WiX67Vj2w/JKe+tlsJE61XN/y0/AvRiiLBeP0thBIemzMeIeMI/WHjA4Ro2AAdNL
 23zCy0iftO2TYAqWO6+pFVqCCXM5GLD2YK/iUZC90dAM7WfCwSHj+rcgWksPCKoEQG4f
 tx+/kk/kHxfyXKC2X16I+qSzh/z7sjSJGHdig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750884779; x=1751489579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tPZBcSJjJyoArtv1w0slFZov+l7YHFVS0EkbFKXNImA=;
 b=ZqlldWdhkNT16+Kdjx3JBIRZ0JY/YE7qT2VDsJWRolCwKRJwmZWdN1mS3Gkm0QPhsX
 iHgImgSnZOrs96Hn75HLCbCXtGh95DQRelyzrqEpGKE/Ii0iXEMQVyRKN+keCoiCJOtP
 SAd+TuQxwW7hYknlyPnxAZInNywbmE2wzku1oC5P7ephzygVkuxZh5TA71yYTEglcA+Z
 CtGbXu15GZJe2CU9K81Pygz+HDnevXMAVAl6ZlAf34UUx0Ri2C3r2dSQuVuuVdMwDClT
 KdVVh+2U9n1BLYNEvLMMf5/KC0m48yIuCsz2jIsH3cxsbHfikbwVJGUFmIHPfuN46ioC
 Qlrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy8i1t8H0vDAZ7pDeaKccUGDW4gYCraCIz/cxs49Jyk7Lcxz+b/y9jhtdYVB4WgTmXh6pZfXU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx5pFauqG43f5igpthqyRZBHj8Pal3Apf5bZPVFi4NYyjcAn7iT
 ABRJGy55IsFuCQG5AGDlL39YuUlWGWWqscpsbh+BzbsVsBSus0tw3e0zzZEgLDSCaUE=
X-Gm-Gg: ASbGncuhkXRgN8zEDH3ab2L1TQf39RdcT/o25KdX4P39OSQ2VNQQl8WLj7THXWLPqA6
 OM3M/tF7ztx6858KjoUuAB+tWjPpICu2JTuXPwOZGjm3cPJKDw161IKjiUii8ngRJnYGdafkJo8
 EGeWMu8RQyYNRKq4kXLnMUyy3b+7MndSsnZfmXyT8Nq56HDpj92dP21LHYFGcXmYE+pCMG8fSUF
 7TAVOFLLRH3mLmhuvIu43IEAfwWf+w2SXTViu8z+DVMuDJ03aUJR/3L82nTZo5ie5OpTZOmzRop
 UfQT8DXO0NNQ1fB8SNo94eI2INYXNZJRZxR0kI0IK+2QQjCtennEBY08CD+vmy5qClZkztgf1yd
 iRnvdo+kt54i4c56IFeMpQY4=
X-Google-Smtp-Source: AGHT+IFWPBGfONa2PTmDZ9MynXQScgd0qT85LLtcujtFjp/g/UF2s10U51ukFxMF6ohC6qMBb7E6RA==
X-Received: by 2002:a05:6808:2008:b0:401:e95b:3b0e with SMTP id
 5614622812f47-40b05748d62mr3556409b6e.12.1750884778998; 
 Wed, 25 Jun 2025 13:52:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6115b6d233bsm1789179eaf.16.2025.06.25.13.52.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 13:52:58 -0700 (PDT)
Date: Wed, 25 Jun 2025 14:52:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Conor Dooley <conor@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 albert.aribaud@3adev.fr, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] dts: Add u-boot specific 'fsl,mux_mask' property to
 iomuxc for vf610
Message-ID: <20250625205255.GU4003484@bill-the-cat>
References: <20250624204700.972663-1-lukma@denx.de>
 <20250624204700.972663-2-lukma@denx.de>
 <20250624210116.GL4003484@bill-the-cat>
 <20250625083637.1d286cec@wsk>
 <20250625141424.GN4003484@bill-the-cat>
 <20250625-stylishly-expiring-c37b5a0a52fb@spud>
 <20250625163742.GR4003484@bill-the-cat>
 <20250625223250.43470703@wsk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qM0iL1b2BSTo6++R"
Content-Disposition: inline
In-Reply-To: <20250625223250.43470703@wsk>
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


--qM0iL1b2BSTo6++R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 10:32:50PM +0200, Lukasz Majewski wrote:
> Hi Tom,
>=20
> > On Wed, Jun 25, 2025 at 05:28:56PM +0100, Conor Dooley wrote:
> > > On Wed, Jun 25, 2025 at 08:14:24AM -0600, Tom Rini wrote: =20
> > > > On Wed, Jun 25, 2025 at 08:36:37AM +0200, Lukasz Majewski wrote: =
=20
> > > > > Hi Tom,
> > > > >  =20
> > > > > > On Tue, Jun 24, 2025 at 10:47:00PM +0200, Lukasz Majewski
> > > > > > wrote:=20
> > > > > > > The commit e8a9521e649f
> > > > > > > ("vf500/vf610: synchronise device trees with linux")
> > > > > > > has synchronized U-Boot's DTS with v5.19 Linux kernel.
> > > > > > > It turned out that in Linux's upstream iomuxc node
> > > > > > > description the fsl,mux_mask' was missing, so the U-Boot's
> > > > > > > pinctrl driver for NXP's Vybrid SoC was not working
> > > > > > > properly.
> > > > > > >=20
> > > > > > > As by default the mux mask was set to 0, the vf610 based
> > > > > > > boards (like BK4) were bricked, due to misconfiguration of
> > > > > > > gpio at early boot stage.
> > > > > > >=20
> > > > > > > The fix for all vf610 based boards is to introduce
> > > > > > > vfxxx-u-boot.dtsi file with 'fsl,mux_mask' property
> > > > > > > provided and include it in boards' specific U-Boot
> > > > > > > adjustment files (like vf610-bk4r1-u-boot.dtsi).
> > > > > > >=20
> > > > > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > > > > ---
> > > > > > >  arch/arm/dts/vf610-bk4r1-u-boot.dtsi | 2 ++
> > > > > > >  arch/arm/dts/vfxxx-u-boot.dtsi       | 9 +++++++++
> > > > > > >  2 files changed, 11 insertions(+)
> > > > > > >  create mode 100644 arch/arm/dts/vfxxx-u-boot.dtsi   =20
> > > > > >=20
> > > > > > It looks like this is still missing upstream, so what's the
> > > > > > status on that?  =20
> > > > >=20
> > > > > It looks like in Linux the mux_mask is hardcoded (for Vybrid
> > > > > vf610):
> > > > > https://elixir.bootlin.com/linux/v6.16-rc3/source/drivers/pinctrl=
/freescale/pinctrl-vf610.c#L321
> > > > >=20
> > > > > In u-boot other SoCs use it as well, but with different values:
> > > > > - arch/arm/dts/imxrt1050.dtsi -> 0x7
> > > > > - arch/arm/dts/imx8ulp-evk-u-boot.dtsi -> 0xf00
> > > > >=20
> > > > > In the imx8ulp case above - it is already set in *-u-boot.dtsi
> > > > > specific file, so I've followed this approach. =20
> > > >=20
> > > > Someone should unify upstream to one approach or another I would
> > > > think. Or find a good explanation as to why it's not unified, and
> > > > then we should follow. =20
> > >=20
> > > If these values are per-SoC, which they appear to be given these
> > > look like 3 different devices, I don't see a reason for these to be
> > > accepted "upstream". =20
> >=20
> > OK, yes. But it should either be "hard code a thing" or "get the
> > property" not maybe-one-maybe-the-other? That was what I was trying to
> > make as my point.
> >=20
>=20
> Agreed.
>=20
> Then some decision shall be made if:
>=20
> 1. We keep the fsl,mux-mask as *-u-boot.dtsi specific
>=20
> 2. Modify the pinctrl driver for Vybrid
> (drivers/pinctrl/nxp/pinctrl-imx-mmio.c) and maybe add mux_mask field
> to:
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pinctrl/nxp/pi=
nctrl-imx.h?ref_type=3Dheads#L26
>=20
> 3. Try to upstream (to Linux) the property. That would require rewriting
> kernel pinctrl driver for vf610 to parse "fsl,mux_mask" property.
>=20
> As Conor pointed out - the approach from 3. is not feasible.
>=20
> Then we shall decide if 1. or 2. shall be implemented.
>=20
> Approach from 1. doesn't require any driver's modification. Approach
> from 2. would introduce the extra field and some code modification to:
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pinctrl/nxp/pi=
nctrl-imx.c?ref_type=3Dheads
> and
> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/pinctrl/nxp/pi=
nctrl-imx-mmio.c?ref_type=3Dheads
>=20
> I would personally opt for 1.

Well, my question is wouldn't option 2 bring us closer to how this works
in Linux?

--=20
Tom

--qM0iL1b2BSTo6++R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhcYaQACgkQFHw5/5Y0
tyxFWAv+PZdSQEyzOJue7+thFgM+IOLbV2yi0vfKt7wDoClxE5+RmaBFlBTWYtu4
0N+WWTKFYy9GnYn85yLPt6cmMyVBLx6nu6LQ+VBcFIjM5x9MXEQDC6DupjUFlqiE
JtajUriCWZuRQkI/4MCDLK/I0+lHtFTV9ib7k0DfqJFuWE31FOs4/Xyx/L/vGWa+
KF30QwUQMu+QLnWyhONlkwY6KNQwtfji0CwwK99eZpzf8RO/QgpSi99mBftcOxl4
44cla/zEU0L1CuT3uJJU5dB1SX+axgtBk/j4ai232aWJ14Qoo99J2DNnonEpTSad
x782Hz3yy8Oj/yKuSwAV6whH6XRzZAnoHdSirk5zf0bo2v2E9T0OsJlgZoDYc7ya
lnelJ9a2XLkpZKhbrgunOBLLOLbbmSV1RBdfAoF4xkDhb1NqxAS0qRkoZKX8IevR
jQhdYIcgFHjvhi/WuHd0Xa1p/nwvfcQN1o/HFzHs4UdFUROu3/4p4C6vQg9LC7eE
SQ2A5DH5
=nrBd
-----END PGP SIGNATURE-----

--qM0iL1b2BSTo6++R--
