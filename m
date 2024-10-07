Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FAECFB441
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 14:17:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6E1888EB;
	Mon,  7 Oct 2024 16:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V8PyaqaT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18B25880F4; Mon,  7 Oct 2024 16:17:39 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00A8688CD9
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 16:17:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4583083d019so31323371cf.3
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728310655; x=1728915455; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JflF58/rWKRFRrL8bN/7n/JcYNClksMbGMfsnaG4iIM=;
 b=V8PyaqaT5b0LDUCHOcMoeXO/JyaH1SonrIzrgq8+k/bB4Pv/o6k4qMF5Zkz6MymHkP
 qV69NkRvCY1RrhrwTbCNtE1Yss3fQNJyvEqxq0hjaKD/4NDGGZlhJa9TDnGNFEoKVBUJ
 UX0kbKfhTeg5HSD21viOSwEUG25QWEtuJNBm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728310655; x=1728915455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JflF58/rWKRFRrL8bN/7n/JcYNClksMbGMfsnaG4iIM=;
 b=MeLZC6fs/eUsJxJaxwxCmzpxRsm4sUFGKBsPTM6Eh8Azw1v+cTR2hWxp+YFSnuQ1Q8
 FYPMZRZ7+Q8V1DBNRowgLNZnsbEjp49kgeLreut+u/H3VEWfO2O6qZbyeZxjxbs6cHgI
 +7yueZdQgSCDfl34lFKcdFX1g+XDGnmeO21fj6DoCJFG06RoZYP9FTjhVxtSkq1Ytr7k
 yx+T5LUrA/hfvlM2spm8TH+VF706dhbwFmdSDYnxq26XftyFqxzWehCxtBPaFFWKMmZu
 ReEzJS9O/NoPXNWjJkL+2erksU6Qy5NQ7QgnRkE2Ciq5EjOWeWwiK7xZT8zxan5Vwp/N
 1PYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtJfTRbIO3bUWDmgxqTysEL39Wk7eL9J6KQ4HRs6dzpABCv9aA5YPDynQYMGTPrUCsEq25nY4=@lists.denx.de
X-Gm-Message-State: AOJu0YzZFR4R49xrGFbjfNOSz7lSXeOPsQL1hs/7Woq+XEuMkqyuGsy7
 MrLaOmCf5JLky5ahIY1X9h6A5TZxcIjTR6HCAIBKo2hIzrxDYcoWxMizRTKfE/o=
X-Google-Smtp-Source: AGHT+IGV+OHCivs4v+q1tqfkj6HQL/Uf6R20GhfgrpcVCGtbuMd+I+H8JcgshiRpJe3104+6c8gHTA==
X-Received: by 2002:a05:6214:5508:b0:6cb:6089:eb83 with SMTP id
 6a1803df08f44-6cb9a30d314mr190473596d6.28.1728310654750; 
 Mon, 07 Oct 2024 07:17:34 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba47535a2sm26148656d6.77.2024.10.07.07.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 07:17:34 -0700 (PDT)
Date: Mon, 7 Oct 2024 08:17:30 -0600
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
Message-ID: <20241007141730.GT4737@bill-the-cat>
References: <20241005233116.2781053-1-alice.guo@oss.nxp.com>
 <20241006212332.GQ4737@bill-the-cat>
 <f2f2ff63-e186-4065-8e75-7e0064d16037@denx.de>
 <20241006225032.GS4737@bill-the-cat>
 <PAXPR04MB8459A51F5CCFC565F8E395FF887D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="skTJBEAEPZOQ3gj8"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459A51F5CCFC565F8E395FF887D2@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--skTJBEAEPZOQ3gj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 11:46:03AM +0000, Peng Fan wrote:
>=20
>=20
> > -----Original Message-----
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Monday, October 7, 2024 6:51 AM
> > To: Marek Vasut <marex@denx.de>
> > Cc: Alice Guo (OSS) <alice.guo@oss.nxp.com>; u-boot@lists.denx.de;
> > sbabic@denx.de; festevam@gmail.com; dl-uboot-imx <uboot-
> > imx@nxp.com>; Peng Fan <peng.fan@nxp.com>; Ross, Fedor
> > <fedor.ross@ifm.com>; Ye Li <ye.li@nxp.com>; seanga2@gmail.com;
> > Alice Guo <alice.guo@nxp.com>
> > Subject: Re: [PATCH v1] imx: Kconfig: make IMX8_ROMAPI
> > configurable
> >=20
> > On Mon, Oct 07, 2024 at 12:28:44AM +0200, Marek Vasut wrote:
> > > On 10/6/24 11:23 PM, Tom Rini wrote:
> > > > On Sun, Oct 06, 2024 at 07:31:16AM +0800,
> > alice.guo@oss.nxp.com wrote:
> > > >
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > Make CONFIG_IMX8_ROMAPI could be configured in defconfig.
> > > > >
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > > > Reviewed-by: Ye Li <ye.li@nxp.com>
> > > > > ---
> > > > >   arch/arm/mach-imx/Kconfig | 3 ++-
> > > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-
> > imx/Kconfig
> > > > > index 134e42028c..9d3aafd2f8 100644
> > > > > --- a/arch/arm/mach-imx/Kconfig
> > > > > +++ b/arch/arm/mach-imx/Kconfig
> > > > > @@ -179,7 +179,8 @@ config DDRMC_VF610_CALIBRATION
> > > > >   	  the ddrmc_cr_setting on relevant board file.
> > > > >   config IMX8_ROMAPI
> > > > > -	def_bool y
> > > > > +	bool "Enable i.MX ROMAPI"
> > > > > +	default y
> > > > >   	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
> > > >
> > > > Since there's no help here, is this truly configurable, or is this
> > > > something that should be select'd based on the SoC and
> > presumably
> > > > some of the newer IMX9 parts cannot use this?
> > > I can imagine the MX95 calls into this custom ELE firmware stuff
> > > instead of ROMAPI ?
> >=20
> > Alright. Perhaps this should be depending on the above and !main-ELE-
> > symbol instead.
>=20
> Nope. To i.MX93, ELE and ROMAPI are both valid. There is case that
> ROMAPI needs to be false while ELE is still true.

Alright, but where is the choice made? As in, can a normal i.MX93 board
use one or the other, or will it depend on specific SoCs in the family?
And is disabling this option even valid on the i.MX8 families?

--=20
Tom

--skTJBEAEPZOQ3gj8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcD7XcACgkQFHw5/5Y0
tyxrWgwAuwFZMnR5yEpMIk6yOsTs6SrRrAqZJXM9DMLjvCSfkZfesilN/ymQxXCa
yBQFhJgZdyHr/TEw6Td0kqDUOlBAEY2/WzJLDRTSFOpFxJiGfxKS3T0Hf/X0bT2U
rytAV6F3P5huuTIYPHTpn5rxEP/wcht5OVzXxVnNL9PVkaQulx+a6L2as6Ir7RCr
HcthzMT3QJbjpu36zvGPinqz/ce2zEm8B7hIsL+EDYd54wMS7pJbXqhhXK3wJqfp
nNoL1vTDwr+qnxpRoJCVwkwzmGHpQzURFn9FeNfNEFt5LKRXION72DReG5a1XsPZ
zKFHr5twXyRPGBERyaXMYt1Zjtnj3jZpjmkXdAjxGPTBhbNzcVZGG8F9BFQgVDJx
7qjE21FWALgtFyU7UPTjpa0PRAw1+6KZF6anedH6Oxssb+Iio3AKpxTturIo4PMH
eAubN+wB4TFCb53ANLJvNmS9+JKBAzRtq11OgZpZ4Ryt0WsyQG7IcyeJVC334Tfm
dGLIhtVe
=srcw
-----END PGP SIGNATURE-----

--skTJBEAEPZOQ3gj8--
