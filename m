Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BC2E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 15:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2906C801A9;
	Thu, 12 Dec 2024 16:55:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ELJjwDRQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D37C801DA; Thu, 12 Dec 2024 16:55:10 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09928800D2
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 16:55:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4679eacf25cso2968191cf.3
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 07:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734018907; x=1734623707; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8C1CFdZ8HHaF8FlJ3xJbHLbkml9f3pQxoyqvhad4wx0=;
 b=ELJjwDRQdFBtXzJGHPHSBSYCjIkENBTu/J2n1tKDlppfehCDqUn07pt21MN0Ga2Fzt
 YL8UWxFs0edOry/1IGz/70trs+zqOSfwCQID/taOq4UMCpCFeCauc/2KSTc0/oGANQFE
 zy7fLCLrBu7ak5Lx1pfK3/G0coZclIxXI5/Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734018907; x=1734623707;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8C1CFdZ8HHaF8FlJ3xJbHLbkml9f3pQxoyqvhad4wx0=;
 b=MbvXJosuPZVLwOXoyPbhEcfytqJf1rveqkPoULppfSjJAvwBAr9BfFnLT//RvF5igV
 17eW/PVUxRyW26lkIP5IHBIbi+hSsKzidtNggz0SRdYd23kYwn4cedeIa5EcqVtdcfe9
 Dw+1StK0x0NHw0AzA4VpKYTBLtgkCIAPRdfcucTDogOpFWKoI+Z8G5nvhENUaelyD6te
 zQis8MUvAooBNtDhJtpoyUnMpTl8a1MtwNxDuU8MFrHkh28dYh+/jfx4uVFJgpSL7Pe2
 A9g0NC1y3GY5IITnRx9cCosvOGEG3GhDwnhwxGBStc3knUNia0S7MN0Hz33lTND/2pbR
 mW3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0ktFlAjGoOg0iE83aZIdyc9K1PO511+fErd7ceg8whSldHhsC/rd964iSlepTAK6jIMNtZ5E=@lists.denx.de
X-Gm-Message-State: AOJu0YxH62KPUH6WRBYeYxr4LRhzotsPP/ryA8cgt0pm4/aiadxaIkoG
 363IXdrqQ+TvPmTFC//TUp6bV7C1CZca0xz2s7ym2Rlh5RGaHsBOnHzd20ckq2g=
X-Gm-Gg: ASbGncsT28xy8c1dLxdn2+UctAYRniMPtT3YtNDMxPy8Z2mEYEqQ7LRHP2ggsBFBJxq
 8TgoQYsq12LfIcrF5/XPV+lBPJcGPOBkng9U6SPPFhG4Z7tEZrdX4u4rwXsz3ezyiGqsegBjlMo
 0ipm3Apqq7tuEev6lmtOa/2XkQCFoOFFXHWA2EgzLssbf+vsQsVv1Kg8zmMhvT/qH6DGVDs5YGP
 NrhaSOKpdAoH4JfyjXefTpiiu8dkgZxSjrHMuwmTcDWyRybR6ynRiDk
X-Google-Smtp-Source: AGHT+IGhYh7hrvQZaYQqJeQUZQ9Iolos/VpvwtHui+vrESthahoznCYKUGyrtejzxrkaURASWnDlyw==
X-Received: by 2002:a05:622a:15c8:b0:467:613d:9b0 with SMTP id
 d75a77b69052e-467a165be3fmr13282701cf.50.1734018906874; 
 Thu, 12 Dec 2024 07:55:06 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4674feaaab4sm58647331cf.18.2024.12.12.07.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 07:55:06 -0800 (PST)
Date: Thu, 12 Dec 2024 09:55:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/2] Tegra: fix clock init
Message-ID: <20241212155503.GE1505244@bill-the-cat>
References: <20241212100646.5646-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qrhN25cFejIdzo2q"
Content-Disposition: inline
In-Reply-To: <20241212100646.5646-1-clamor95@gmail.com>
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


--qrhN25cFejIdzo2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:06:44PM +0200, Svyatoslav Ryhel wrote:

> This should fix https://lore.kernel.org/all/20241201164810.GT3600562@bill=
-the-cat/T/#m2b62b471fd37e4c9725c98547e2a919cf11db5e5
>=20
> ---
> Changes from v1
> - added partially support PLL clocks commit
> ---
>=20
> Svyatoslav Ryhel (2):
>   driver: clk: tegra: partially support PLL clocks
>   driver: clk: tegra: init basic clocks on probe
>=20
>  drivers/clk/tegra/tegra-car-clk.c | 52 +++++++++++++++++++++++++------
>  1 file changed, 42 insertions(+), 10 deletions(-)

Thanks. Do you want to send me a PR for these, or should I apply them
directly in a bit after time for further review / testing?

--=20
Tom

--qrhN25cFejIdzo2q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdbB1cACgkQFHw5/5Y0
tyzX5AwAjWlgllu+bTPVpb5q34Ir8ZpcIcVxrH1JNVrT33fm+alZPB82iaQRjLFe
tGCSKSS24xLa1OcElxO1/+Zy5dgQ4cYtM0+rUk+2d7eLQlBGh3FxHn2O3Zgg0pin
C1It449tpNrAskgRjJHpoOhcM8g3IBOe3cwtLXjixMXdj1wVyJHlfpZ7MTucSLcj
ZSfoZByDul/gHukmf38pYkplmv1mhuoTQ5M637kwSn6W3RFCasnu0U8n/LTYF8Nk
0elNHxQAN98GSefiNfEUrFZiHdBFd9lAgH3CSIJ81VTJMaW5V7ww1A2wX/+x+Orl
Jatv071O+pUW5GgLuVpgGt7Khccr5MSsblITf7KVEiNl4wFgkU9TBX5YdqxEOou7
tMhlZKUbMlOvTQrB3U9wf8NaRokWXboOOgScozVvXWq/WnkalI4SIGOoo6mFUHcN
4vKu5y056noCmcPeGUCueBTlEp0ArmuUbjzosU0nB0ONsKA5NN6uo89ADYgN1SR/
n1FooZsH
=RO17
-----END PGP SIGNATURE-----

--qrhN25cFejIdzo2q--
