Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A08CC87FC9
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 17:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD10C88950;
	Thu, 29 Aug 2024 19:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l9O2b9ZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8591488C1C; Thu, 29 Aug 2024 19:00:41 +0200 (CEST)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A03F8887A
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 19:00:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x836.google.com with SMTP id
 d75a77b69052e-44febbc323fso4744831cf.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724950838; x=1725555638; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qc+atB1SHVfkbh2f6ATJCE6U39dF8/Ll7STCrO+tWEM=;
 b=l9O2b9ZOOOpfY/el8d0GhshyOFBU647LV5lwneJPKsq/YpJJ+iqodgTJeGgM+csHJ9
 lNjmze6an5DC6iv8j/V9RZimDgnz0wAwOaKYgHUiX+z+eQURmZ0F74bZOtnjh8m0PZmv
 t83naj/DK2OOUAq251afqg5aSyW1QBIYeqjZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724950838; x=1725555638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qc+atB1SHVfkbh2f6ATJCE6U39dF8/Ll7STCrO+tWEM=;
 b=nX8OzsNIu9mJPzioYee/F+GS+TYOGqREtAd7vH8GRH32hfTHtvPo/feKFV2Ta5hQdg
 vTUVCwu5TzsTjNUFHjAi9RLeFShMcOvf3UEWmgxSFMyQpUQWcwLqdoKcXs3D9HbxFRwY
 BRbwEOlCp5fL+K+PrpcXXGrkrH4RE+bPHb5Wv27OMpUJteaI5AT9EqTgVvqY/MUQk07e
 xIb+iNfcQ3Mh0BNefyhlq+6txsI4bkCpeHXWzjukiJ903ZhhU9YyCubLHw4jFFX5tLKo
 aCVeOD6BYAXk3omKL/1iB0WWh/l2FUFgPEwpyr9xs0EG9EuaUW7nttBGpUR3hwaG4dQ5
 gyEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH/EYcynHg028wKWUElNUEV+6dbTYTt9QmBf/srKJC6HG7HJO7G4ZUZpIopIEkjJsBCZ5CP3Q=@lists.denx.de
X-Gm-Message-State: AOJu0YyiF0IrvGLb9r7HsHuytTFbobPBzhCOoEzMsh4VGLjBXIuyi0c2
 TiHIUUMoFGE7SdmhEdERcFuFX72SJJ+uNAOsK5Nd/3VAz/KdSYWATwVFulqIRiM=
X-Google-Smtp-Source: AGHT+IESFqB+oOADN4t0W1dVWyp7oJWX4fIAhY4D2YUr5u+xLRC/eS6rmDNJOUKq0xw4xNAEPgfIBQ==
X-Received: by 2002:a05:622a:5586:b0:454:f2e5:9202 with SMTP id
 d75a77b69052e-4567f4f7e16mr39837591cf.7.1724950837344; 
 Thu, 29 Aug 2024 10:00:37 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45682cd8ecasm6427691cf.47.2024.08.29.10.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 10:00:36 -0700 (PDT)
Date: Thu, 29 Aug 2024 11:00:33 -0600
From: Tom Rini <trini@konsulko.com>
To: "Gaskell, Oliver" <Oliver.Gaskell@analog.com>
Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 "Bimpikas, Vasileios" <Vasileios.Bimpikas@analog.com>,
 "Agarwal, Utsav" <Utsav.Agarwal@analog.com>,
 "Artamonovs, Arturs" <Arturs.Artamonovs@analog.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Linux Factory <adsp-linux@analog.com>, Trevor Woerner <twoerner@gmail.com>
Subject: Re: [PATCH 00/20] arm: Initial support for Analog Devices SC5xx boards
Message-ID: <20240829170033.GH2479150@bill-the-cat>
References: <20240828-sc5xx-upstreaming-patches-v1-0-44d9adfdf327@analog.com>
 <20240829145143.GA2479150@bill-the-cat>
 <SN7PR03MB72754C566D3532701567AC38E1962@SN7PR03MB7275.namprd03.prod.outlook.com>
 <20240829151649.GD2479150@bill-the-cat>
 <SN7PR03MB7275A514335195C93FF8D328E1962@SN7PR03MB7275.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7SbYkuKm+GV+/mtj"
Content-Disposition: inline
In-Reply-To: <SN7PR03MB7275A514335195C93FF8D328E1962@SN7PR03MB7275.namprd03.prod.outlook.com>
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


--7SbYkuKm+GV+/mtj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 03:50:56PM +0000, Gaskell, Oliver wrote:
>=20
>=20
> > -----Original Message-----
> > From: Tom Rini <trini@konsulko.com>
> > Sent: Thursday, August 29, 2024 4:18 PM
> > To: Gaskell, Oliver <Oliver.Gaskell@analog.com>
> > Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>; Greg Malysa
> > <greg.malysa@timesys.com>; Ian Roberts <ian.roberts@timesys.com>;
> > Bimpikas, Vasileios <Vasileios.Bimpikas@analog.com>; Agarwal, Utsav
> > <Utsav.Agarwal@analog.com>; Artamonovs, Arturs
> > <Arturs.Artamonovs@analog.com>; Rayagonda Kokatanur
> > <rayagonda.kokatanur@broadcom.com>; u-boot@lists.denx.de; Linux Factory
> > <adsp-linux@analog.com>; Trevor Woerner <twoerner@gmail.com>
> > Subject: Re: [PATCH 00/20] arm: Initial support for Analog Devices SC5xx
> > boards
> >=20
> > [External]
> >=20
> > On Thu, Aug 29, 2024 at 03:06:31PM +0000, Gaskell, Oliver wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Tom Rini <trini@konsulko.com>
> > > > Sent: Thursday, August 29, 2024 3:52 PM
> > > > To: Gaskell, Oliver <Oliver.Gaskell@analog.com>
> > > > Cc: Nathan Barrett-Morrison <nathan.morrison@timesys.com>; Greg Mal=
ysa
> > > > <greg.malysa@timesys.com>; Ian Roberts <ian.roberts@timesys.com>;
> > > > Bimpikas, Vasileios <Vasileios.Bimpikas@analog.com>; Agarwal, Utsav
> > > > <Utsav.Agarwal@analog.com>; Artamonovs, Arturs
> > > > <Arturs.Artamonovs@analog.com>; Rayagonda Kokatanur
> > > > <rayagonda.kokatanur@broadcom.com>; u-boot@lists.denx.de; Linux
> > Factory
> > > > <adsp-linux@analog.com>; Trevor Woerner <twoerner@gmail.com>
> > > > Subject: Re: [PATCH 00/20] arm: Initial support for Analog Devices
> > SC5xx
> > > > boards
> > > >
> > > > [External]
> > > >
> > > > On Wed, Aug 28, 2024 at 11:02:08AM +0100, Oliver Gaskell via B4 Rel=
ay
> > > > wrote:
> > > > > ADSP-SC5xx is a series of ARM-based DSPs.
> > > > > This comprises the armv7 based SC57x, SC58x and SC594 series, and
> > the
> > > > > armv8 based SC598.
> > > > >
> > > > > This patch series includes configurations, init code, and minimal
> > DTs
> > > > > to enable Analog Devices' evaluation boards for these SoCs to boot
> > > > > through SPL and into U-Boot Proper, as well as devicetree schemas
> > for
> > > > > the added DTs.
> > > > >
> > > > > This patch series depends on ("arm: Add Analog Devices SC5xx Mach=
ine
> > > > > Type") (https://lists.denx.de/pipermail/u-boot/2024-
> > April/552043.html)
> > > >
> > > > Since that series has been merged since early May, what is this ser=
ies
> > > > based on top of? It should be based on top of current (or close eno=
ugh
> > > > to not matter) -next. Also, has everything been passed through
> > > > checkpatch.pl and the results looked at? Thanks.
> > >
> > > I made it on top of -rc1, just tested and I think it applies cleanly
> > > to -rc3 and next. Wasn't sure on the policy re. patch series
> > dependencies
> > > so just wanted to be 100% sure that was clear.
> > >
> > > It has been run through checkpatch, there's a few warnings that I thi=
nk
> > > are OK. Only warning I missed is about the Co-developed-by tags not
> > > having matching Signed-off-by tags - if this is an issue I can make a=
 v2
> > > that fixes this.
> >=20
> > OK, thanks for elaborating. I forget, what is the plan to upstream these
> > dts files?
>=20
> We're currently in the process of upstreaming support for a single
> platform (SC598) to Linux, and others will likely follow, so we'd like to
> have the minimal device trees in this patch series in U-Boot for now so
> it's possible to boot the boards from source. As and when the devicetrees
> are in Linux, we will remove them and enable OF_UPSTREAM for the relevant
> boards.

OK, thanks.

--=20
Tom

--7SbYkuKm+GV+/mtj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbQqTEACgkQFHw5/5Y0
tyzFbAv/UbslZrgSvYGWpP8ask7hJK1tBmk5yMtrHLGpb4G5xck/Kz8N3Jlob5Bh
wDkgxeOIhu0B0HTdKsjIButpbFGr1Ua65r+pEanQjsS3f1GBmJIBmcjSHNGV78o/
EdZWDwUttQLDcK37yqFroSOxFDnUropIOlbhhdU2N9qZE83q3W7kg0y05C+jBx3y
sFKfFR1n1I1Y4Zax1D0Rs/giH0+DVKDsq+3HdPVgBRxcs9vDvAGIJI5ZExnGCKo1
3dsWwqZvvXHU7siEyGdN4VdcU9885aiwyxICepatV7G4AIavi2OH3UQZGzOf5X5p
2UmoMTNr+nvlAYIl9nAzhi3oINgAJuYwGNmCrJq9hPX4tR1TsgNgE9GNniRsfr55
P1pvbOcCaT7bTrYCRws9YG4Jkecak5r/TlT/Z6CegRk8SVJr9J+2+sOonh7wfA5Y
1LlTaVHn4HFEEjkAypZqwcQQISR2tRY7uq/WPLkfrW3GPpT70Us+DSF/Moyh4AHF
azMfpIxm
=cN+C
-----END PGP SIGNATURE-----

--7SbYkuKm+GV+/mtj--
