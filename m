Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05661CCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 15:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F4084581;
	Thu,  9 Oct 2025 17:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="STYE7Kx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87E6A84529; Thu,  9 Oct 2025 17:11:24 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 152DC84529
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 17:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-74572fb94b3so676782a34.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 08:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760022681; x=1760627481; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9BzVjIdi7NuA1Ahf088EqHiPzvEjS3dC2QqQOW862/A=;
 b=STYE7Kx1axfMu670VfnWTE6QNGfn1XPTsfZaaWJxCv88fRyDnlc7jP2qh/XJz1iCnL
 EuYmft1BNoKY9YyghfwPtSJP9ymahCk6xqRCIlkeA/tf/CvFahoBBirZ3wQWC7lzlS4E
 b8M/00X4+Unkorv9kIs0bpSJsR78+uutW/Dak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760022681; x=1760627481;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9BzVjIdi7NuA1Ahf088EqHiPzvEjS3dC2QqQOW862/A=;
 b=QWVJkd7HGzfSLYuRF5YH/XYyPrprjWDO2sZnE6QvdmIU0UOpve8lycpIXnsb370HLI
 8apYjtKJ75/tpaNdRMCich0HZODi9WpptCq75zcoAF9Tw3DGjMaGTKahiqV//JwTbPah
 mUlNRElFthx2YoMGdK7hvyqXlCXj4fMicSqtua024rV8js+X1eMGoBlQS/KrY6rZWsUB
 SrUrmS+hsk5rJa/Fv9i5MH7dcLd5NXghwku3waJ5yZ2Fa/KNz0I7LJsZIFiMDQQfBpx2
 6zYMIJO4JnUgAFzirmXEJhcX028g6zTvnTRB6PALgqSe4qFa7UK+qR4x+LYHef6+OIwj
 RtMQ==
X-Gm-Message-State: AOJu0YwkRVvznzEWxqZJJL22crx0W7XvUBQpJ12eMn4k6I1MUWCEro1y
 3TEl32aGK/V4/CzWodcJphw+OAIm2x2R0+Bf+LM1IW04Qt946U/ESTRR2qKP3FKInB0=
X-Gm-Gg: ASbGncvZUZ1zLnn8ToVnpc8QNUdASK+Di2EBKstvREw3wfCITL+Mei97O7c15t6r9fg
 AK4LdIqvNAoxZGvgHusgFuKTUlP8WgCdUXab86wrDCi3ltYbEN1U2DFofZWbefGuW5+jhUJ7yKY
 a6GCJMHypnidMWkhdIgAXceIoeqgNcRANmWKjXv0BeaOXa/rGFY2It/ko291qAMfhK3aGzBQoy8
 kHEs23nH5WapAqwjCfk5NZEC2lMIQVWRM5ccsGrWvJWrOkhIHPpAT67alxwCdXUsjoGOTt5r/Ti
 LeeAbP8SlCbqDl03xTZQEvsASFVPSKYdShlEPY1a/VcrX4A7rrrNo1Os1jnOhAojcDCbUJVKMnU
 DraX7BZIr+1+jhBC4GFnSV63kanuIZRO2lA+cDcCgpqKRSlVo2xGgez1BC192e3gM0pi63Dl4WH
 EXOwd0Mn5l2g==
X-Google-Smtp-Source: AGHT+IEvZhHTjcltjcaUbWhdcF1a4QtBIj51Oi89TvIRNl7uw1UhVmHu/3+3z+Xsth51v2v1KC20lg==
X-Received: by 2002:a05:6808:1388:b0:43f:1c5d:8db with SMTP id
 5614622812f47-4417b2bc687mr3863331b6e.6.1760022680692; 
 Thu, 09 Oct 2025 08:11:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-64e188f3eb9sm4691365eaf.5.2025.10.09.08.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 08:11:19 -0700 (PDT)
Date: Thu, 9 Oct 2025 09:11:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@linaro.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] nand: atmel: Rework ATMEL_EBI and DM_NAND_ATMEL
 interaction
Message-ID: <20251009151117.GO298503@bill-the-cat>
References: <20250926153136.3680867-1-trini@konsulko.com>
 <e4db9bab-9de2-4810-ab19-7654be60dae5@linaro.org>
 <20251009142601.GN298503@bill-the-cat>
 <0372ee71-0b8a-449f-983e-63ef024e5ac3@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="idpMSUL8xtM0epfu"
Content-Disposition: inline
In-Reply-To: <0372ee71-0b8a-449f-983e-63ef024e5ac3@linaro.org>
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


--idpMSUL8xtM0epfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 05:58:48PM +0300, Eugen Hristev wrote:
>=20
>=20
> On 10/9/25 17:26, Tom Rini wrote:
> > On Thu, Oct 09, 2025 at 12:48:29PM +0300, Eugen Hristev wrote:
> >>
> >>
> >> On 9/26/25 18:31, Tom Rini wrote:
> >>> The way that the NAND driver under DM_NAND_ATMEL is probed is by the
> >>> dummy memory driver controlled by ATMEL_EBI. Rather than require that
> >>> for NAND to work both be enabled, make NAND select ATMEL_EBI and do n=
ot
> >>> prompt for ATMEL_EBI as it only triggers the probe for NAND.
> >>>
> >>> Signed-off-by: Tom Rini <trini@konsulko.com>
> >>> ---
> >>> Cc: Eugen Hristev <eugen.hristev@linaro.org>
> >>> Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> >>> Cc: Michael Trimarchi <michael@amarulasolutions.com>
> >>> ---
> >>>  drivers/memory/Kconfig       | 2 +-
> >>>  drivers/mtd/nand/raw/Kconfig | 1 +
> >>>  2 files changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> >>> index eaee739c6aab..591d9d9c6569 100644
> >>> --- a/drivers/memory/Kconfig
> >>> +++ b/drivers/memory/Kconfig
> >>> @@ -14,7 +14,7 @@ config MEMORY
> >>>  	  For now this uclass has no methods yet.
> >>> =20
> >>>  config ATMEL_EBI
> >>> -	bool "Support for Atmel EBI"
> >>> +	bool
> >>>  	help
> >>>  	  Driver for Atmel EBI controller. This is a dummy
> >>>  	  driver. Doesn't provide an access to EBI controller. Select
> >>> diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kcon=
fig
> >>> index aa4bb2a0595c..f083113486ed 100644
> >>> --- a/drivers/mtd/nand/raw/Kconfig
> >>> +++ b/drivers/mtd/nand/raw/Kconfig
> >>> @@ -50,6 +50,7 @@ config SYS_NAND_NO_SUBPAGE_WRITE
> >>>  config DM_NAND_ATMEL
> >>>  	bool "Support Atmel NAND controller with DM support"
> >>>  	depends on ARCH_AT91
> >>
> >> Which branch is this patch based on ?
> >> I have a conflict because this line ^^ is missing in master ("depends =
on
> >> ARCH_AT91")
> >> Is there another patch for that ?
> >=20
> > Ugh, yes, sorry, this patch depends on:
> > https://patchwork.ozlabs.org/project/uboot/patch/20250711151604.2224243=
-1-trini@konsulko.com/
> >=20
>=20
> Then maybe Dario can pick this up together with the dependency patch ?

Works for me, Dario?

--=20
Tom

--idpMSUL8xtM0epfu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOfQkgAKCRAr4qD1Cr/k
CpFKAQDXDNuPffCDPHQLjjCQFMLA2mk4LoxdmKoYbrgQZ/Y6twEA0KdYJHF/i6GX
9jDhPCFJmTluis4pydRjKo1pLzklEAk=
=5GFo
-----END PGP SIGNATURE-----

--idpMSUL8xtM0epfu--
