Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2DEC7EE2A
	for <u-boot@archiver.kernel.org>; Wed, 25 Jun 2025 14:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE08382CFA;
	Wed, 25 Jun 2025 16:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Td8GarIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F3682D21; Wed, 25 Jun 2025 16:14:35 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 115A2803CC
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 16:14:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-73a5c41a71aso997647a34.0
 for <u-boot@lists.denx.de>; Wed, 25 Jun 2025 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750860868; x=1751465668; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8S70gbs434yYISvjyv2NCLotNxQan/ib6dzg/Kts6Q0=;
 b=Td8GarIKHhF2pSWC5xWL5DwYrz+U8AcsxojGUgBigwaKfo01eSRO0GGPTh3ln9yz13
 ttWL5LZSQpu8DhssOTbtcbO00RnDEL/LNxfuAEnqQo2fyFp0iMR8yaDEFY6JUKITZQXM
 qyNR0mNOim8ubkQ8VUougCmgYol4Wx7B0mZHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750860868; x=1751465668;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8S70gbs434yYISvjyv2NCLotNxQan/ib6dzg/Kts6Q0=;
 b=A1qqqqKC+himsoJrORnckDHMtrkhI4ufJJOZMfBEi8kL5nq1iiW+EsmxQwgiFDyTbL
 fmUlLvoJUwOqpBh/tuenB2MDXZBajFTf8U+0eMkb6kJq5D5t3mORii34fi4TsEetG2Z5
 xHfRdXNi615TNJ+0vM3QbNlhWzeOD84WwkYcNHTE1K0XB8O++YIGHggovTh1pf+iHr62
 ZY2rcv/XWIVUGHtmFadyHNf5w3/lLbJAh+mw25MmuPgivLT4cq3A16tcVKBsoa5h8HvN
 dJoDPbxn0EQfBMJ3fKIjcmyHXLsKEDrB9i2Agkiy9rV+2JioHGrDp42gzjruKP3uTse+
 aVOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNNUeYZvuIh2TVfQUzHJYRDoKc3wND67WYdj2cWsR+FIfFwqGecG5EIDEmiW00ngUTfEuO23U=@lists.denx.de
X-Gm-Message-State: AOJu0YzqJaLgjPDCok2pH6qo1Oid2GdY45gyFRax4tWht+fat8FbPJwx
 FT9H1xYm2igAdZXiHW2tSqriWwYdSBs0qg+qWJcbeCjvgSzHU1YA9OVhzdbVHLpkNjc=
X-Gm-Gg: ASbGncvabvHHbeJQZGlAEWVCvV6jIGo8dDZUhevcwic2Do0xLrx4NKCvIyVfysNwv08
 E7FOX2LZEqL27gaXqjym1WmTfKrbMoWhGz93zIzBs4LAfsB/0E3I9EEyg6gFSsez9zHewfTz8Gi
 wmc25PxFLWnhuI62c3TzH2G5jD9V3fp0MXLoYBYmYoDcP96zlxM3oJL8/z5fGN1QcV4y7hlf+gp
 XCdaVYi7I0qj1Bpe8k24KmJxmQ4+W5EDicTFM7WW3cSXXWW8ReALFAmZo3vZI41ukHRfJgZJ6s4
 yQqMmNCq3esucESSRiSBWFtSAk+FMjibrPqs0enhcHFSq34cq0Egv6jtfbV2inPvjCKQTbZ1Ygw
 W0B2KVARdpIbV3JQWPQLAuZQ=
X-Google-Smtp-Source: AGHT+IEP4vYECBPouAxhBKmWmxmuwrbwJg3dYSyFvrdnlheJvAz24AEIlur/i03ukX0f1LN7kziOIA==
X-Received: by 2002:a05:6830:211b:b0:72b:9506:8db1 with SMTP id
 46e09a7af769-73adc48301fmr1968503a34.4.1750860867670; 
 Wed, 25 Jun 2025 07:14:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73a90cbf6b7sm2244096a34.59.2025.06.25.07.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 07:14:26 -0700 (PDT)
Date: Wed, 25 Jun 2025 08:14:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Lukasz Majewski <lukma@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 uboot-imx@nxp.com, albert.aribaud@3adev.fr, u-boot@lists.denx.de
Subject: Re: [PATCH 2/2] dts: Add u-boot specific 'fsl,mux_mask' property to
 iomuxc for vf610
Message-ID: <20250625141424.GN4003484@bill-the-cat>
References: <20250624204700.972663-1-lukma@denx.de>
 <20250624204700.972663-2-lukma@denx.de>
 <20250624210116.GL4003484@bill-the-cat>
 <20250625083637.1d286cec@wsk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SV8498Zrm3Ld2nbU"
Content-Disposition: inline
In-Reply-To: <20250625083637.1d286cec@wsk>
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


--SV8498Zrm3Ld2nbU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 08:36:37AM +0200, Lukasz Majewski wrote:
> Hi Tom,
>=20
> > On Tue, Jun 24, 2025 at 10:47:00PM +0200, Lukasz Majewski wrote:
> >=20
> > > The commit e8a9521e649f
> > > ("vf500/vf610: synchronise device trees with linux")
> > > has synchronized U-Boot's DTS with v5.19 Linux kernel.
> > > It turned out that in Linux's upstream iomuxc node description the
> > > fsl,mux_mask' was missing, so the U-Boot's pinctrl driver for NXP's
> > > Vybrid SoC was not working properly.
> > >=20
> > > As by default the mux mask was set to 0, the vf610 based boards
> > > (like BK4) were bricked, due to misconfiguration of gpio at early
> > > boot stage.
> > >=20
> > > The fix for all vf610 based boards is to introduce
> > > vfxxx-u-boot.dtsi file with 'fsl,mux_mask' property provided and
> > > include it in boards' specific U-Boot adjustment files (like
> > > vf610-bk4r1-u-boot.dtsi).
> > >=20
> > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > ---
> > >  arch/arm/dts/vf610-bk4r1-u-boot.dtsi | 2 ++
> > >  arch/arm/dts/vfxxx-u-boot.dtsi       | 9 +++++++++
> > >  2 files changed, 11 insertions(+)
> > >  create mode 100644 arch/arm/dts/vfxxx-u-boot.dtsi =20
> >=20
> > It looks like this is still missing upstream, so what's the status on
> > that?=20
>=20
> It looks like in Linux the mux_mask is hardcoded (for Vybrid vf610):
> https://elixir.bootlin.com/linux/v6.16-rc3/source/drivers/pinctrl/freesca=
le/pinctrl-vf610.c#L321
>=20
> In u-boot other SoCs use it as well, but with different values:
> - arch/arm/dts/imxrt1050.dtsi -> 0x7
> - arch/arm/dts/imx8ulp-evk-u-boot.dtsi -> 0xf00
>=20
> In the imx8ulp case above - it is already set in *-u-boot.dtsi specific
> file, so I've followed this approach.

Someone should unify upstream to one approach or another I would think.
Or find a good explanation as to why it's not unified, and then we
should follow.

I'm not nak'ing this patch but I am noting a problem that needs to be
addressed.

--=20
Tom

--SV8498Zrm3Ld2nbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhcBDwACgkQFHw5/5Y0
tywAbwv+IRqzbLvnURqdHpfcs2H2VZ9lItby1bXYDWXj6GMpPzROYpsLcvIFEtCH
fN1iNcgulVj6HUwIWH47THeXhqwpxoNgq4/1e+zd5ombEE3SOriM1iAiXrf7ezcX
xmPBdf02S6SfP8n/FGOOhQrM+rcaX8B8TWVJGsHz2klfWvbqdvRo5liOE6qnk2Ap
tjHEOK0T7WKHf+hxV0e9Fn52WnSUat6V/7OJaJ0X0dlMr9hfuln5ySNzBAZ7QyLG
DDyoSz6rksSXuHH3B6Mk3cKTMFz0ssKcSEHc8jsU24254K2x64J41h25PLIbvuSe
TzwnXwGu53yeqxZWGwcw7LCjXGB1tThj+I9sP02BEF0mRB5wzunM6+gvTkLoLeGq
bgeezIN1opXsQkSpjK/y9JqKJsA16u1t62RbIHq+d7BKrEOxuNGDrEP/bQLYm1+c
ojWQ8Pe88Oz3RXyMoA0IJGQ/T4gvh2diALa6+LL1PDZDBflAWvJGJeZy3CH50NsW
nsBDmOdO
=I0bf
-----END PGP SIGNATURE-----

--SV8498Zrm3Ld2nbU--
