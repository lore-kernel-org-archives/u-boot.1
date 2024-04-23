Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81265C4345F
	for <u-boot@archiver.kernel.org>; Tue, 23 Apr 2024 21:22:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8491A88C29;
	Tue, 23 Apr 2024 23:22:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DN9feu8I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8DBD88C28; Tue, 23 Apr 2024 23:22:35 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD9788C2C
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 23:22:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-78edc49861aso434064385a.3
 for <u-boot@lists.denx.de>; Tue, 23 Apr 2024 14:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713907352; x=1714512152; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b8owBueeXa40sNRj4+rHYmffdL7abNllXkoXd/SNmrw=;
 b=DN9feu8IDtlHF1svy1GVX6/D1JEaMagqzwrGouA3Wsn6GseybvVW5x0lQjbmimK7Va
 6Fazq0GRVyt+4lLeHHI/G6xgUjy6DTV0oNizB9G1zLd8EY4y+MVZgj6vCg8gmQiUYeX0
 hqSuz4Eh2zzvH2X9ngfLocaSnLawu9WpWNd4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713907352; x=1714512152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8owBueeXa40sNRj4+rHYmffdL7abNllXkoXd/SNmrw=;
 b=P3lHoW3rMBEnaGBIEn7Gnb2X0elcIkq+rkS4JjP0ztEPYUEHSnsZYJV/Lqa92ryUZj
 FMqSJG9DAO+ADlZDHNoQPciWla+FhIZPRrq1oRP7tTbZslGi/U5rK+uOQEFPDyzwdhDv
 9idtBl7a5AfNJP9gOv4gjL6bYDOAkkXFPUSXKfHi48M1NQk0rvPLSLwo8nYtUKD1vAEU
 +gdiMRHeFH4oyP04QoayN6+bn1d4g5F+b7CNCPfCFLeIyHGxR0nd+mwAW7Rts9t8TKp6
 sic/Mr7Bz/WNpkBpbn4bZ19LvJLjtsXyiAqbOzRjWHiW9fQdyL8foLwrUujCSNr7AEUn
 odPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOf0n8/9pf+EM9FPdSTdw5rKNYkownMcFos5Sq+waEU9AY1LwjGRqQh5S79f73LEYPc0Rp0579WgajxJRtYxgsp6h/Sw==
X-Gm-Message-State: AOJu0Yx+VLio3QGMObO35d1tmvUrodX2AuOyMPEHIN6aErLAstvoFTwB
 1l4eujhUkYftdgeSpTD851g8aUgeEeBPO0KNlWKcAQ68wpfeHvhVL90+GQ/DGeo=
X-Google-Smtp-Source: AGHT+IGMt0z7PJML0tl2isCC3WudwKCJ+cOBVQNWzkDHECSjIbAkRidnk1w1Mr7B/eYOK3xgBuqCCw==
X-Received: by 2002:a05:620a:7f5:b0:78f:1aa0:2ca8 with SMTP id
 k21-20020a05620a07f500b0078f1aa02ca8mr780167qkk.16.1713907352562; 
 Tue, 23 Apr 2024 14:22:32 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 t4-20020a05620a004400b0078d5af15c4csm5594446qkt.38.2024.04.23.14.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 14:22:31 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:22:29 -0600
From: Tom Rini <trini@konsulko.com>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Sumit Garg <sumit.garg@linaro.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PULL] Please pull qcom/qcom-main
Message-ID: <20240423212229.GZ1054907@bill-the-cat>
References: <20240423134951.2380045-1-caleb.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="si43HQQc/oGc5w39"
Content-Disposition: inline
In-Reply-To: <20240423134951.2380045-1-caleb.connolly@linaro.org>
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


--si43HQQc/oGc5w39
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 03:46:19PM +0200, Caleb Connolly wrote:

> Overshot the -rc1 deadline, but I hope these can still make in for 2024.0=
7.
>=20
> Support is added for 5 new Qualcomm SoCs:
>=20
> * QCM2290 and SM6115 are low and mid range SoCs used on the RB1 and RB2
>   respectively. SM6115 is also used in some mid-range smartphones/tablets.
>   Initial support includes buttons and USB (host and gadget).
> * SM8250 is a flagship SoC from 2020 used on the RB5, as well as many fla=
gship
>   smartphones. The board can boot to a U-Boot prompt, but is missing regu=
lators
>   necessary for USB support.
> * SM8550, and SM8650 are flagship mobile SoCs from 2023 and 2024
>   respectively. Found on many high end smartphones.
>=20
> In addition:
>=20
> * Support is added for the Schneider HMIBSC board.
> * mach-snapdragon switches to OF_UPSTREAM
> * IPQ40xx gets several regressions fixed and some overall cleanup.
> * The MSM serial driver gains the ability to generate the bit-clock
>   automatically, no longer relying on a custom DT property.
> * The Qualcomm SMMU driver gets a generic compatible (so per-SoC compatib=
les
>   don't need to be added).
> * Support for the GENI I2C controller is added.
> * The qcom SPMI driver has SPMI v5 support fixed, and v7 support added.
> * The qcom sdhci driver gets some fixes for SDCC v5 support.
> * SDM845 gains sdcard support
> * Support is added for the Synopsys eUSB2 PHY driver (used on SM8550 and =
SM8650)
> * SYS_INIT_SP_BSS_OFFSET is set to 1.5M to give us more space for FDTs.
> * RB2 gets a work-around to fix the USB dr_mode property before booting L=
inux.
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--si43HQQc/oGc5w39
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYoJpEACgkQFHw5/5Y0
tyy4WQv/TRvtgOC5hmTOxaIeCrBRtd0blFBRxzBZFCbcB0VOxEW3SM6SNuOwaQ6m
pQr+TE07ud4itAQc7CFd8MTwn+gMhGXgASG6I0fEetMTTkrr3xcntktfKt079Qrn
WHrjhxrHApGMxoyuPS1TyoCwphSXhCJ+APHrmkaKUMO4jqWa0+pfqTLn+PZGgGBH
7VacLzmi6JBRy6Xh9g1gOB8m0eqYsLn518mnuG/96PdbH9lwygEE7C94Dv1XUyDk
iTzk1xwtB8OvFP0KOTucAr5BMRZOmh3SXE03vF2pufFjXEghEgPsPFMAE2/ycvto
hacp8Uz6Wro2fQY3E2MT1Vt29yaGfUtDqDLwvIFkFsZjE7liCwcr/br6S0Bl/M3K
SQd2KhNKsKuLxOAAMQvKTNzPvn2bXFdjIYBwuQavMmPkNr+RuZLKYUGKxfN4fsqI
FEfq+D3+0loM2gqitggKOe3rUuQwa+gJ+a56gJCyhs4GvsNGHfFExJCGgZnYo/w/
KF2gbBTo
=S/vL
-----END PGP SIGNATURE-----

--si43HQQc/oGc5w39--
