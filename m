Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85472C71141
	for <u-boot@archiver.kernel.org>; Sat, 14 Jun 2025 14:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E481080F0E;
	Sat, 14 Jun 2025 16:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qtr1iMze";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89D9880FA8; Sat, 14 Jun 2025 16:05:03 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5203D800C1
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 16:05:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-401f6513cb2so2314607b6e.0
 for <u-boot@lists.denx.de>; Sat, 14 Jun 2025 07:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749909900; x=1750514700; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7w+QWEOHn1V/tmaesEclyA3emNc0fwGhPDO/+M2lMoE=;
 b=Qtr1iMzepPkIB+J33a2+l6rCfra3UGl76Uxn6JJNc+ul2N+PSnr3lLY9bDsZV7UMWA
 imRTgBHKuEKb3Sh8EQpd8DxtITt5qMZKnsiYgJXbHIwqw1Ze7ZEtPca1A8EnC0iQ+Bm8
 ejcW//xflHcMzAWuGVJ7HKZy9aedFJZobqTM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749909900; x=1750514700;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7w+QWEOHn1V/tmaesEclyA3emNc0fwGhPDO/+M2lMoE=;
 b=PIgNK110cLDidLaP221HdWbPGGZT3tnTiE3lx3XlbI67AcV2Z0ZuQpXEMAvF/GmGts
 nz9uiLplrY1FrUyKBv/EuX75ZM/LAVwzvfy2l36l5ysmLU/XamZchfbrhcpPmRwfNtR5
 fUTKkw/9BTayjaXY3eW5O2AUeOoxFoC1upsEjNRpYh60wWaaN7yW+CeqcpTx1M+QHg5n
 PSkneYbjW34Knvp7hJgISfpKjYmhmiulR1k6tAdNDDNvJcSrbDzor/SNadXrTUgqfcwA
 Xy2MY7vxh7AziHyAiez0ZF/sp0tKRxtn4x2uG4geL6L2EPBluGOatr5PfmKGce6G8bn0
 76Wg==
X-Gm-Message-State: AOJu0YzZyHG+5CuqvHcw9mwraJGXQ0BAIb1xT+TQhdfQ0+tns64ZEJtV
 fWUG8wvqzitowSVe+oHALgk3aHSoKoCdF4fvir1GSSJABKHcwRdzPYX//2Q21Uka/jc=
X-Gm-Gg: ASbGncuPwkM2wEkkgTwiRtJNRvnuPZ4nNcA7GQslt3I2rqNymkpW+4WcGShxudxEKA/
 LWpknMzbmcck0KvIsuud1a+wdEBe+bSsiSYfzBVdeHB7tlBMONdHXXbsMwMxgA1+OYWYIBE5oIR
 NhJzpjCLWTEkR0zWV2bHibmqtct3zQqCh6E+ZN5/v2lOc83tkFAOaSMVbi4CWpxIDb5U7U2kFYf
 4mOLakxsYjH15jh/ieBB2lJonNLwTCFg3xdklMQsDZQWdG8V+sdaTUWHF02Le8q2BrPIEFpBDa9
 xquW8dukJVeN7CyEIbXKJpii6Aqh0lydGycfPKnbBEpKSoP1w7yf5DKLYLQOL0vTydYrk4jUUqe
 SLYT6kv7olo2urjaSxKc35Es=
X-Google-Smtp-Source: AGHT+IEgSjPBkIWR8x3Z0o5wSm4dEu5e5P13IiTsYQH3RDTEc5Weobok90kGP2mApLiz0VdV+mzqsw==
X-Received: by 2002:a05:6808:22ac:b0:3f7:d442:1986 with SMTP id
 5614622812f47-40a7b65c9b1mr2681483b6e.1.1749909899947; 
 Sat, 14 Jun 2025 07:04:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40a740b3931sm706698b6e.10.2025.06.14.07.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Jun 2025 07:04:58 -0700 (PDT)
Date: Sat, 14 Jun 2025 08:04:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, nm@ti.com,
 robertcnelson@gmail.com, ggiordano@phytec.com, wegorov@phytec.de,
 francesco.dolcini@toradex.com, jm@ti.com, n-francis@ti.com,
 bb@ti.com, vitor.soares@toradex.com, contact@paulk.fr,
 Oliver.Gaskell@analog.com, marex@denx.de, jerome.forissier@linaro.org
Subject: Re: [PATCH 1/2] Kconfig: Add default malloc size of K3 ARCH
Message-ID: <20250614140456.GE1382132@bill-the-cat>
References: <20250614093717.2479920-1-u-kumar1@ti.com>
 <20250614093717.2479920-2-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GCU9DThgRmfCGtG0"
Content-Disposition: inline
In-Reply-To: <20250614093717.2479920-2-u-kumar1@ti.com>
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


--GCU9DThgRmfCGtG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 14, 2025 at 03:07:16PM +0530, Udit Kumar wrote:

> Many boards of K3 overwrites default malloc size, instead
> of doing at almost each board level,
> Add default size at Kconfig.
>=20
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--GCU9DThgRmfCGtG0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhNgYQACgkQFHw5/5Y0
tyyWpgwAgBX07WQlbOZX6yLZIT6BrA6EZ3zlxrNGJjVEl5KcDHFMtf9cgtbujNFw
IQd16S7HPzwOLhbxkufW1Gr4QtNVu41ZVcHRML3rn8+fiOsss8B5SZqrs2ImO66b
9yxL0VxL1t5d8ZK1bXc9rxTtZf3r/2bXkNAfsl8gU5808cJM7yTbukajXMeUolwG
/2Yan/WECxOxJQvybaPPKpT02tHbXumQHMfGVTwI857ziH4H6kkeyQNuy+ltwAIf
ZrzlofRvHPf6IlTKfTOGOdVcFfTBaTC/U+ZtTPkvYM0cLuGd8lQMQKUiALeeHmZc
AtouTgr8mAXchEXip+wHsuVJk7wyMD04XbCYIqCXW74DbktAPHgc2AzKBo8XSIY6
KjzkwZBJCt5tEUXhHs1oIcIYtQFYfDIuvH0Rr05aGnUMP4MEO/gjXL4dPes3rJy1
/Nri2xT3N7B8pZHdezEeXh/UQe0IjqUWUOp/8WL7QwrjtgKr3w1AXK7ySRAMSfuO
Glm2d9i2
=umE/
-----END PGP SIGNATURE-----

--GCU9DThgRmfCGtG0--
