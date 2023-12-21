Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF96EC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 20:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 172938743A;
	Thu, 21 Dec 2023 21:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QC+UB49O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AD408743A; Thu, 21 Dec 2023 21:01:04 +0100 (CET)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D582386D38
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 21:01:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4b6d12cafbfso289184e0c.1
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 12:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703188860; x=1703793660; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=84JErm83zl9g/9fmcWFAYNEbJZOq8ifEMN98EBx7+po=;
 b=QC+UB49Obl/SyGIYpTyM2StXAHyTUe+oYw71WkqLwK7H6Pt4sR5V9h3NEZaypVkXy2
 MBFyxdWWKoWo9T2dMrfJAw4XGMqNVre8ItULbOIrXoBKOvM1SPzBcFb3a7Bj7ggU6UeE
 HSKLsdGjvxsDhV0fNnxCjMXZLOfWOaDmh5ZCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703188860; x=1703793660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84JErm83zl9g/9fmcWFAYNEbJZOq8ifEMN98EBx7+po=;
 b=KKQkTc6DJx/w88NLal+gURqsnGtNzBGdwBet0Y2AfCasFHF32bGhAtBup767PEklmv
 GJc7VZ9acg66z15E+qHDPtNQU4Hn41JK2la3faOa07DO65823VWkEj6CzsMtH2gbo5rP
 hNEwC1sSPBDSYSUgjiIjjLKcpu5HtkaOJBxrrfvPx5mPLxmj7DoaFsS7IzhSyuMIJJ/J
 sWeH3rGeOvOk53PW/TCnHRlC0VyTJcXjbJRRGQEeZ2zKS8Dfm5JD57LpWUyf96pKLaud
 94jJE7GopO2wE4zXA10F5zh0HY0ZLDsxx5anQRm3qovx7rwznlCitsk60lPReqjrX/sc
 vIdg==
X-Gm-Message-State: AOJu0YwEz8vGeyxxNV6EVNHn9b11VDcRR2IoV6QVtzZMwe9z9oq9s0Wd
 9TeCoacj/EPHfTMwbeNFyDyAn/1wtWxgsQ==
X-Google-Smtp-Source: AGHT+IHBewXdJqtQX5P7lrj7+wIRPadD0noX92gwvfequSbIMhYelAIOIOISkc2n7HcvFBkcElhD/g==
X-Received: by 2002:a1f:ee4d:0:b0:4b6:f0f7:1b53 with SMTP id
 m74-20020a1fee4d000000b004b6f0f71b53mr118309vkh.15.1703188860539; 
 Thu, 21 Dec 2023 12:01:00 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-550c-6b1c-99f9-93ae.res6.spectrum.com.
 [2603:6081:7b00:6400:550c:6b1c:99f9:93ae])
 by smtp.gmail.com with ESMTPSA id
 q26-20020ae9e41a000000b007810de6a161sm867993qkc.55.2023.12.21.12.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 12:00:58 -0800 (PST)
Date: Thu, 21 Dec 2023 15:00:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Bryan Brattlof <bb@ti.com>
Cc: UBoot Mailing List <u-boot@lists.denx.de>,
 Vignesh Raghavendra <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 00/26] sync am65x device tree with Linux v6.7-rc1
Message-ID: <20231221200056.GM2513409@bill-the-cat>
References: <20231221174412.210807-1-bb@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fMuXOFMRLatB3CQz"
Content-Disposition: inline
In-Reply-To: <20231221174412.210807-1-bb@ti.com>
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


--fMuXOFMRLatB3CQz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 11:43:46AM -0600, Bryan Brattlof wrote:

> Hello Everyone!
>=20
> This series gets the am65x booting again along with syncing the device
> tree files with v6.7-rc1 Linux.
>=20
> The bulk of these patches unify the WKUP SPL board file with the arm64
> files to make future syncs from Linux much easier. In the end the DTBs
> should look a lot like what the DTBs look like for the am64x which
> is fairly similar to the am65x.
>=20
> For those interested in what UART boot looks like:
>    https://paste.sr.ht/~bryanb/7df8a645dc548912cd806abd5ecab967ef3287bc
>=20
> Thanks for reviewing and happy holidays
> ~Bryan

For the series,
Tested-by: Tom Rini <trini@konsulko.com>

Nishanth, does this path work for you?

--=20
Tom

--fMuXOFMRLatB3CQz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWEmXUACgkQFHw5/5Y0
tyxJuwv/WcP4Yw2t/QTokZb+D0A2VuC4zuKvG2klRa3x7/2nvh1YM1vXxsPRw904
uKLHDTP7qGQXwljUJHfjBU2U/xurlgUtPTavaHc/RrvuMQ0ns5fhfy9lQAEXv1lX
mLI/rNBQrhGs3lr0q54Eyp0csWOkIQgbiv5vi0bU8TjzYzMskycoW4mun+3rsUdH
poGTO0sLO4KtqOfrpktb7f8A5Y5F11/07uR+RHBIAwHOpDu+BbacaCu9n4BplVWX
uS3fm2BZU4Ga5G1sUU6o93/QhUwZ6ujGMFK+81WYOMJ86yaUDStCHxm2jtnGOGMS
miQd1b5ohIDJkh2jzhl2JzmPG5SIChlaFOYnFinknMIacyESFka7RnGsiU4WcMPc
n71FlC/mU2ReiOnOM2p/P9i2JD4KJ/7LYqqLk7ZdFhF9hFALhCBBf+oS293Sejsz
BgANnSWQxDxj2B0qNcHXGl+U4z1zmUO9EcpMho5BCRyxNx4vV6YEgsZoh7X0xCMe
ubUH0+XG
=QI+S
-----END PGP SIGNATURE-----

--fMuXOFMRLatB3CQz--
