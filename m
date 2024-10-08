Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D4BCEF173
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 13:41:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9DAB88DB6;
	Tue,  8 Oct 2024 15:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XJMxxM68";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ED2D88E78; Tue,  8 Oct 2024 15:41:38 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00DA888CC8
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 15:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7093997dffdso1652600a34.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 06:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728394895; x=1728999695; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AfL5+Ow3lMuIKqphaaTtvzr1PKxiPmJybXHOtj1zETs=;
 b=XJMxxM68EUGoJ/wwShpH5BbaOnpPp6k9fEXJ9E+r1PRf9EY1d8FwP/jBbUZqtTCNT8
 O6e9KQ9aGydZt+N8OSqPACnCaG8Da0GLyiytb/2YvK+lpcm2jI/0HBWvYIv6bv/uX1x2
 F3P54FcLpEVSMyEMnnskKyy2+XWKCncovL6Jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728394895; x=1728999695;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AfL5+Ow3lMuIKqphaaTtvzr1PKxiPmJybXHOtj1zETs=;
 b=MFBqEuv9TZzsKKZ6x6HMFRvX2g/Yxd59KgsioRQxBuxwCxz5WeOQoxRIKl6yFwiLRr
 2VTzsbvzeNBbSk9LuZC1HlE4jOGkqaJ3ufASZ52XjDeUCri3JB53TedvdBM1WtJrvj6M
 qaVg1OXiPJgGQIqTdcGfUFq2bAqU8pS0xzsSQOC2stjNSjErT3Bdc3aX+rfF5D7V/aZ6
 V+xawfRuCggLkX5xQU7F0Nq259AYsNQ0utIiOdAIJ4Wj5lYYRRRFlS7ltrzH8lv0Q8Mn
 fmbiU+ayRLDo/PO+s6//rBGoEM2fCpy7RkKJLdK+VpopKELJZVxQqjt+KKvaydWP0K5I
 90vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmzgi4l42iTgiEq85wkOIAL5A/WnW5ymXXumwztGKogKh/POPOSg4/CmeMUkksrkDh9mtErjo=@lists.denx.de
X-Gm-Message-State: AOJu0YyfD+JvmfA77VHneQtt1nA1kOW3OTG4UKjDNevukHFhOI/C5Vq1
 T6CpQP4mfVLc7KWx36MZxaMPk+OmBSrefMNvOHgTF9Ohex8Nu/EpEP7SCzV5Cpk=
X-Google-Smtp-Source: AGHT+IGbmabKOkEv+E8sAwxRuStSFcd8nTzWac4xEMnvaZ7Dzjm7b9zCnHe+8iZAU2Zw8s1VxUEJfg==
X-Received: by 2002:a05:6358:7e86:b0:1b5:fa68:4208 with SMTP id
 e5c5f4694b2df-1c2b83b3761mr583164855d.28.1728394894703; 
 Tue, 08 Oct 2024 06:41:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae756611b5sm355532385a.77.2024.10.08.06.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 06:41:34 -0700 (PDT)
Date: Tue, 8 Oct 2024 07:41:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: Marek Vasut <marex@denx.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sbabic@denx.de" <sbabic@denx.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>,
 "Ross, Fedor" <fedor.ross@ifm.com>, Ye Li <ye.li@nxp.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI configurable
Message-ID: <20241008134130.GB14210@bill-the-cat>
References: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
 <20241006212332.GQ4737@bill-the-cat>
 <f2f2ff63-e186-4065-8e75-7e0064d16037@denx.de>
 <20241006225032.GS4737@bill-the-cat>
 <PAXPR04MB8459A51F5CCFC565F8E395FF887D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20241007141730.GT4737@bill-the-cat>
 <PAXPR04MB8459AC6BFC8402C2607A5817887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DyVzsZjKuvQtlVKb"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459AC6BFC8402C2607A5817887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--DyVzsZjKuvQtlVKb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 08, 2024 at 08:54:38AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI
> > configurable
> >=20
> > On Mon, Oct 07, 2024 at 11:46:03AM +0000, Peng Fan wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Tom Rini <trini@konsulko.com>
> > > > Sent: Monday, October 7, 2024 6:51 AM
> > > > To: Marek Vasut <marex@denx.de>
> > > > Cc: Alice Guo (OSS) <alice.guo@oss.nxp.com>; u-
> > boot@lists.denx.de;
> > > > sbabic@denx.de; festevam@gmail.com; dl-uboot-imx <uboot-
> > > > imx@nxp.com>; Peng Fan <peng.fan@nxp.com>; Ross, Fedor
> > > > <fedor.ross@ifm.com>; Ye Li <ye.li@nxp.com>;
> > seanga2@gmail.com;
> > > > Alice Guo <alice.guo@nxp.com>
> > > > Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI
> > configurable
> > > >
> > > > On Mon, Oct 07, 2024 at 12:28:44AM +0200, Marek Vasut wrote:
> > > > > On 10/6/24 11:23 PM, Tom Rini wrote:
> > > > > > On Sun, Oct 06, 2024 at 07:31:16AM +0800,
> > > > alice.guo@oss.nxp.com wrote:
> > > > > >
> > > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > > >
> > > > > > > Make CONFIG_IMX8_ROMAPI could be configured in
> > defconfig.
> > > > > > >
> > > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > > > > > Reviewed-by: Ye Li <ye.li@nxp.com>
> > > > > > > ---
> > > > > > >   arch/arm/mach-imx/Kconfig | 3 ++-
> > > > > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-
> > > > imx/Kconfig
> > > > > > > index 134e42028c..9d3aafd2f8 100644
> > > > > > > --- a/arch/arm/mach-imx/Kconfig
> > > > > > > +++ b/arch/arm/mach-imx/Kconfig
> > > > > > > @@ -179,7 +179,8 @@ config DDRMC_VF610_CALIBRATION
> > > > > > >   	  the ddrmc_cr_setting on relevant board file.
> > > > > > >   config IMX8_ROMAPI
> > > > > > > -	def_bool y
> > > > > > > +	bool "Enable i.MX ROMAPI"
> > > > > > > +	default y
> > > > > > >   	depends on IMX8MN || IMX8MP || IMX8ULP ||
> > IMX9
> > > > > >
> > > > > > Since there's no help here, is this truly configurable, or is
> > > > > > this something that should be select'd based on the SoC and
> > > > presumably
> > > > > > some of the newer IMX9 parts cannot use this?
> > > > > I can imagine the MX95 calls into this custom ELE firmware stuff
> > > > > instead of ROMAPI ?
> > > >
> > > > Alright. Perhaps this should be depending on the above and
> > > > !main-ELE- symbol instead.
> > >
> > > Nope. To i.MX93, ELE and ROMAPI are both valid. There is case that
> > > ROMAPI needs to be false while ELE is still true.
> >=20
> > Alright, but where is the choice made? As in, can a normal i.MX93
> > board use one or the other, or will it depend on specific SoCs in the
> > family?
> > And is disabling this option even valid on the i.MX8 families?
>=20
> Sorry, my last statement was wrong. This is only to disable ROMAPI for
> i.MX95. Downstream only has below:
> ./configs/imx95_19x19_evk_lvds_defconfig:222:CONFIG_IMX8_ROMAPI=3Dn
> ./configs/imx95_19x19_verdin_android_trusty_defconfig:221:CONFIG_IMX8_ROM=
API=3Dn
> ./configs/imx95_15x15_evk_android_dual_defconfig:217:CONFIG_IMX8_ROMAPI=
=3Dn
> ./configs/imx95_19x19_evk_defconfig:222:CONFIG_IMX8_ROMAPI=3Dn
> ./configs/imx95_19x19_evk_android_uuu_defconfig:222:CONFIG_IMX8_ROMAPI=3Dn
> ./configs/imx95_19x19_verdin_fspi_defconfig:226:CONFIG_IMX8_ROMAPI=3Dn
> ./configs/imx95_19x19_evk_android_dual_defconfig:222:CONFIG_IMX8_ROMAPI=
=3Dn
> ./configs/imx95_15x15_evk_defconfig:217:CONFIG_IMX8_ROMAPI=3Dn
> ./configs/imx95_15x15_evk_android_uuu_defconfig:217:CONFIG_IMX8_ROMAPI=3Dn
> ./configs/imx95_19x19_evk_android_trusty_secure_unlock_dual_defconfig:222=
:CONFIG_IMX8_ROMAPI=3Dn
> ./configs/imx95_19x19_verdin_android_uuu_defconfig:221:CONFIG_IMX8_ROMAPI=
=3Dn
> ./configs/imx95_15x15_evk_lvds_defconfig:218:CONFIG_IMX8_ROMAPI=3Dn
> ./configs/imx95_19x19_verdin_android_trusty_dual_defconfig:221:CONFIG_IMX=
8_ROMAPI=3Dn
> ./configs/imx95_19x19_verdin_defconfig:221:CONFIG_IMX8_ROMAPI=3Dn
> ./configs/imx95_15x15_evk_android_trusty_dual_defconfig:217:CONFIG_IMX8_R=
OMAPI=3Dn
> ./configs/imx95_15x15_evk_android_defconfig:217:CONFIG_IMX8_ROMAPI=3Dn
> ./configs/imx95_19x19_evk_android_rpmsg_defconfig:222:CONFIG_IMX8_ROMAPI=
=3Dn
> ./configs/imx95_19x19_evk_android_trusty_defconfig:222:CONFIG_IMX8_ROMAPI=
=3Dn
> ./configs/imx95_19x19_evk_fspi_defconfig:227:CONFIG_IMX8_ROMAPI=3Dn
> ./configs/imx95_19x19_evk_android_defconfig:222:CONFIG_IMX8_ROMAPI=3Dn
> ./configs/imx95_19x19_evk_android_trusty_dual_defconfig:222:CONFIG_IMX8_R=
OMAPI=3Dn
> ./configs/imx95_19x19_verdin_android_defconfig:221:CONFIG_IMX8_ROMAPI=3Dn

So it sounds like this is not something to be prompted for and must be
selected / def_bool'd appropriately.

--=20
Tom

--DyVzsZjKuvQtlVKb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcFNocACgkQFHw5/5Y0
tyzTewv+JzbLay16AgFEtP4A8OJ7QXEJUKFjXNOmQH4p/NZIjEIvQVdwPStFHqPL
tzgIYe9j/DSyb7pyCzaRw90+mHX8ZMngl8Bg5cW89kszso6XvSv+Q0T+XY79tvwJ
I4PeUDVnwn/o0jmnsWuhwIIbyJ7HIRCxp+eY7ODYpOTJSYDTm1E6STLdBh9zSr7B
PNU9YMr/wWCe3lr+dOVHBdRL9usxGi5SLwxNfvA3YbqQBrBrZWc2kg+2V4jWopAR
+iAB7Kx5sMXXIIZdk7Y2OSarK6N2AecsCY8parXqwhnn3HbkO3PZOcpsB0h+3y3Q
5VngP0BuHCdDuB4bo/p+DWBIi93MgFR0JdHit4TjKggN+wDqb7FPlKPeO+Ewy2tB
BWPesKhW2rOa/SUu3Dgg60s+BvD0/reoHAUFRCt/ioXaNMnEA3oqWqfaCkpDyfJt
H+clLXgiWEQS4uacWWYPvmbTCEXhEvDzw7Zsc5PgUakkPeqsloRka88RLh9qQctH
1Wtb99li
=75Hc
-----END PGP SIGNATURE-----

--DyVzsZjKuvQtlVKb--
