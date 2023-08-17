Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C053DC41513
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 19:18:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 104E286BC9;
	Thu, 17 Aug 2023 21:18:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dz53z6Jl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B2C86BCD; Thu, 17 Aug 2023 21:18:42 +0200 (CEST)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2803686BC7
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 21:18:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-58dfe2d5b9aso2402707b3.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 12:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692299919; x=1692904719;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q02fk9J9xH2UtgBj9DVC2Fac4KebYaeHbVoxXp2sXuY=;
 b=Dz53z6JlSEDzzN584aH2E3fktL4UzBBLhR/orU0oXiCE65M5+XfV61RMxtKUeCp1ly
 pQ1XYVRaJC07/xOmn0GhAm9iUsGtmXZ/qEioWMkLxXIsExu1cx21J2HU2TsD84jtsc47
 m8lNglMaMq7gEi4X+9hxqSwCK3IXUl2tFO0nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692299919; x=1692904719;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q02fk9J9xH2UtgBj9DVC2Fac4KebYaeHbVoxXp2sXuY=;
 b=KbKEPzSXk0UJ4eTxW/TM9J0PfssK5ExVnzU0p85I9ljbhinLrXKNHmcqONXRD6gAy9
 sSTFS9THinQqcYJd9aW569f5eTwqWrEoJtHr2g7A6c/NtxaXJr/W704EuFuVQp+4DYjK
 zcE4Cq1yABkj6C6p/tzRsx0dT1nOT264DY/5/wPci//8B6CV5L6OsnMB7m1KI+9tYl0n
 bJ6f6mSnRSoDyk3n119fcf4W+Xe8GNgX/lBneSwz6BZuUTgoW1yxDpKtrYWN5usJMr7Z
 v/qcJIw8F1D1s/wxOqZfGfl2LvgS13xBQWWuKaO1beS90iXvg8wdRTQcbYT3AHSpujVy
 szPA==
X-Gm-Message-State: AOJu0YzoO8LNNedwDwLJP8+FXMFcotjXkE8Po6n1gIPvo0OoKtrLBz2w
 vwVUNjWrwQqdw3UHUYtjvjxav6Lt81e6oXwZfmTT2Q==
X-Google-Smtp-Source: AGHT+IGEaH5IB7FTABnEddTb5rTG0aKoNSCiWvfCy5ovLnfWnSJBz2MXBXa1xbaJctvmrvsmJNLmow==
X-Received: by 2002:a0d:d8ca:0:b0:583:7545:2f2e with SMTP id
 a193-20020a0dd8ca000000b0058375452f2emr4490760ywe.7.1692299918929; 
 Thu, 17 Aug 2023 12:18:38 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 a124-20020a818a82000000b005869ca8da8esm46321ywg.146.2023.08.17.12.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 12:18:38 -0700 (PDT)
Date: Thu, 17 Aug 2023 15:18:36 -0400
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: nm@ti.com, vigneshr@ti.com, srk@ti.com, r-gunasekaran@ti.com,
 s-vadapalli@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v5 0/4] arm: dts: k3-am64: Sync DT with Linux
Message-ID: <20230817191836.GA616955@bill-the-cat>
References: <20230805081440.7045-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oDhQeeqOY7PFUM2V"
Content-Disposition: inline
In-Reply-To: <20230805081440.7045-1-rogerq@kernel.org>
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


--oDhQeeqOY7PFUM2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 05, 2023 at 11:14:36AM +0300, Roger Quadros wrote:

> Hi,
>=20
> This series syncs AM64 DT files from Linux v6.5-rc1.
>=20
> Tested on AM642-EVM GP SR1.0 and AM642-SK-EVM HS-FS SR2.0.
>=20
> cheers,
> -roger
>=20
> Changelog:
>=20
> v5:
> -squash documenation change to correct patch. Update commit log.
> -add Nishanth's Reviewed/Tested by
>=20
> v4:
> -Add documentation for am642-evm and am642-sk-evm.
> -Add license to am64 svg file
> -drop mmc0 pinmux from k3-am642-r5-evm.dts
> -drop stdout-path from -r5 & -u-boot dts.
> -drop vtt-supply and vtt pinmux from memorycontroller in k3-am642-r5-evm.=
dts
> -am642-evm: move bootph-pre-ram for main_esm, mcu_esm into -r5 .dts
>=20
> v3:
> - include board DT file in -r5 DT file.
> - move including -u-boot.dtsi file at the top of -r5 DT file.
> - drop duplicate nodes
> - document why we need to delete clock/power properties from
>   main_timer0
>=20
> v2:
> - Sync with v6.5-rc1
> - Rebase on latest uboot/master
> - CPSW node cleanup
> - Timer node cleanup
>=20
>=20
> Roger Quadros (4):
>   board: ti: am64x: Recognize AM64-HSEVM
>   Revert "ARM: dts: k3-am642-sk-u-boot: add PMIC node"
>   doc: board: ti: am64: Add boot flow diagram
>   arm: dts: k3-am64: Sync DT with Linux v6.5-rc1
>=20
>  arch/arm/dts/k3-am64-main.dtsi         |  171 ++-
>  arch/arm/dts/k3-am64-mcu.dtsi          |   53 +-
>  arch/arm/dts/k3-am64-thermal.dtsi      |   33 +
>  arch/arm/dts/k3-am64.dtsi              |   22 +-
>  arch/arm/dts/k3-am642-evm-u-boot.dtsi  |   57 +-
>  arch/arm/dts/k3-am642-evm.dts          |  173 ++-
>  arch/arm/dts/k3-am642-r5-evm.dts       |  231 +---
>  arch/arm/dts/k3-am642-r5-sk.dts        |  218 +--
>  arch/arm/dts/k3-am642-sk-u-boot.dtsi   |  113 +-
>  arch/arm/dts/k3-am642-sk.dts           |  166 ++-
>  arch/arm/dts/k3-am642.dtsi             |    1 +
>  board/ti/am64x/evm.c                   |    3 +-
>  doc/board/ti/am64x_evm.rst             |  197 +++
>  doc/board/ti/img/boot_diagram_am64.svg | 1702 ++++++++++++++++++++++++
>  doc/board/ti/k3.rst                    |    1 +
>  15 files changed, 2506 insertions(+), 635 deletions(-)
>  create mode 100644 arch/arm/dts/k3-am64-thermal.dtsi
>  create mode 100644 doc/board/ti/am64x_evm.rst
>  create mode 100644 doc/board/ti/img/boot_diagram_am64.svg

For the series, applied to u-boot/next, thanks!

--=20
Tom

--oDhQeeqOY7PFUM2V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTecokACgkQFHw5/5Y0
tyxwgAv/YeZG8hhG0dwtrL07rIT/FMGjKGSoNhk4ZCftMiWT+jc50Ze11j6sBV/V
/qYibBTvTSAkLoaxrgWcEw7Rcf9XACIBM8Kr/QO2gE1Sz0/NxIdPHG8XVGSBpnd5
qhcIqidn2IfBniiTDA8M6Sux/8ja3lT6O/qSVeWmpzNa/Jr/JwGqBqMo2CoGYMef
AmktplgeEBW2bFH+3FNT+jtcZqqCIGtIPjwwKobptHIWI9iqay8d0j7S6+eviC5j
35KwIvw6M2qW9de3NrReF36lEDxI7yHocx57Fj1owv3JGGqRPMe/z5ug1Whi0PuA
n79tXGvl265ZRAgcrD38CSY3fZgmsfizZVPXS/ddKy4jr1hDMS+7UjwTa4TW3lhP
lRjoEpz9Z1HdmSCOvithUs6x8MgXqU5e2aLywVhKB/2NsCBzpe7WNm0tagkgME4h
JbGSpRvVM8j8y8MIUp30V93epzka2dvbRM7jicN7wZopr5rrpWLkx7R9W47q5QTO
MSkn54Kj
=jHJD
-----END PGP SIGNATURE-----

--oDhQeeqOY7PFUM2V--
