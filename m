Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CEBC4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 19:51:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FBF187632;
	Sat,  9 Dec 2023 20:51:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XIevHdty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75FB9870FF; Sat,  9 Dec 2023 20:51:07 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C628765B
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 20:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5cbcfdeaff3so30984767b3.0
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702151464; x=1702756264; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D/OeiIR+oPTMDEGG98WrzOuHC9d9oQ2/cKr1PXwdxh8=;
 b=XIevHdtyxU7/UU21lwX9mrxMmESX0x86ZJ+EImAqX90iHrebD5vDFGdvZHvXgZ7kZE
 +zP8dLXNaxxVteXYDaJlWg2slr4pnASBL5ttjLzqCfB3KkiJtTvpK8cfwuQntYiofAOl
 WDmnjd90cvKSAzDPBYKpuyDogokXyQvqUSQDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702151464; x=1702756264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/OeiIR+oPTMDEGG98WrzOuHC9d9oQ2/cKr1PXwdxh8=;
 b=BS2l5r6y2nQpR7mOSGgFvxz8CgtvoQ+dOXwFuJe52EZqF1IHfX71U1omXpQAESTyLR
 zzKMYq1hkXtkXkStx3KkLLw4EP2kHOSjxvLWYV/VCTMzxopFeu0oLZ3Xjd6cMQXxUvS8
 0WfXj1qUIEClw8pBmcTmssQKNEwNtYx60S1OB6qkpoSb9my8dHnZbvFzxhS5uM9znxKi
 HQAzESQJpkPFG3jAzdgHL5pMAR8BlBTAN5mgxTel5NAaL8lCKNSsZfcRgF2CbZfiy185
 a0aR3vnMG64U1pk7FXPkk3ITo49ejivNS1vAfVjVloql87pHDHr3gJNCSvJ8257sOjAw
 NoLw==
X-Gm-Message-State: AOJu0YziPPEe69molFwECqx3QrGP4x55bGECsBzaR8ldjWwWQAX6wE8e
 S+wFK6dV4xlFjyLBgqw0sKZ6/w==
X-Google-Smtp-Source: AGHT+IGBKoyiFhfPmN/9anqlnVNUZprVLAleUPsoxMnmw063uQHz7feGf0kTTD7Otv2KM24OemDDRA==
X-Received: by 2002:a0d:cc05:0:b0:5d9:8e2:7a44 with SMTP id
 o5-20020a0dcc05000000b005d908e27a44mr1668460ywd.33.1702151464055; 
 Sat, 09 Dec 2023 11:51:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 d62-20020a0df441000000b005d6f34893dfsm1676885ywf.135.2023.12.09.11.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 11:51:03 -0800 (PST)
Date: Sat, 9 Dec 2023 14:51:01 -0500
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 hs@denx.de, enrico.leto@siemens.com, praneeth@ti.com, nm@ti.com,
 vigneshr@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH] mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
Message-ID: <20231209195101.GC2513409@bill-the-cat>
References: <20231125111605.47536-1-rogerq@kernel.org>
 <20231126173520.GA2513409@bill-the-cat>
 <619f6788-9f00-4729-a945-1b1af0621735@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ihB1ECKMNH3oz94A"
Content-Disposition: inline
In-Reply-To: <619f6788-9f00-4729-a945-1b1af0621735@kernel.org>
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


--ihB1ECKMNH3oz94A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 04:22:42PM +0200, Roger Quadros wrote:
> Hi Tom,
>=20
> On 26/11/2023 19:35, Tom Rini wrote:
> > On Sat, Nov 25, 2023 at 01:16:05PM +0200, Roger Quadros wrote:
> >=20
> >> AM335x uses a special driver "am335x_spl_bch.c" as SPL
> >> NAND loader. This driver expects 1 sector at a time ECC
> >> and doesn't work well with multi-sector ECC that was implemented in
> >> commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based co=
rrection")
> >>
> >> Switch back to 1 sector at a time read/ECC.
> >>
> >> Fixes: 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based co=
rrection")
> >> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> >> ---
> >>  drivers/mtd/nand/raw/omap_gpmc.c | 95 ++++++++++----------------------
> >>  1 file changed, 29 insertions(+), 66 deletions(-)
> >=20
> > I'm glad to see this fixed. My question is, can we abstract this
> > slightly as I assume there's a performance hit on the newer SoCs that
> > support more than one sector at a time for ECC and I assume it's just
> > am335x and related that don't support the feature. Thanks.
> >=20
>=20
> It looks like that the ELM driver (omap_elm.c) is not yet ready for multi=
-sector setup yet.
> I will need more time to test the multi-sector implementation.

Ah, thanks.  Lets make that clearer in the commit message of the next
spin please.

--=20
Tom

--ihB1ECKMNH3oz94A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0xSUACgkQFHw5/5Y0
tyzjQwv9EZDUlwZBhBcfsyN2g2Ru0IKIiJbgJkcu6BHjV6e/p+T9UqRFmpKf6tT9
zxZ0SUIUlf+E+glIhjsuW5lLREou+Nzg7sq2cirStyjeXqGLvKd30h6GfsrZlYDy
egmlMb6snROTVMf6Ch0mrKFALwGuXSaNUYO985lY1d/7GftvJ2xBqaIvb0FW7X9j
csmui4kHBTq4CwwnBXvuBCz6kKawKRy5pB0RsCRzGuYKJ3qKJ788YEjjPtf3LIbi
wsuticMdyhEWKNd1vwYy2Cb+dRD6ZcxTYiCE65XoJ7ghA+uzQyV/GrhCZyV22s71
lwC+gA5oal33PbF47FAdqqvKyD5kvp/8gg83ettjRN9rGlpTkznl3tBgOO2S9ylD
gIBqUM6Zk1jGMFcozu8e8EukcC76stmCPwil6ME9CFcOEsarfJqrcpKirnlhl2hK
BpkJbfRwkbg6Usw9eTmsm3YFRObAz1ItHQ1tHbJo2iWlJdYp1Cka1tskQbD7CouR
lFial9mZ
=Bc4T
-----END PGP SIGNATURE-----

--ihB1ECKMNH3oz94A--
