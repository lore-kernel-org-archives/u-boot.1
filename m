Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB31C4167B
	for <u-boot@archiver.kernel.org>; Sat, 25 Nov 2023 22:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A731287243;
	Sat, 25 Nov 2023 23:38:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KFOCZ/rU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7056D87254; Sat, 25 Nov 2023 23:38:26 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 131848708D
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 23:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41c157bbd30so16105571cf.0
 for <u-boot@lists.denx.de>; Sat, 25 Nov 2023 14:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700951903; x=1701556703; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=esJWGIrsd/zeTNQus8B5h+10jaBPAT1LT/agV1/VdkQ=;
 b=KFOCZ/rU/vhhNer6MK0EheCJEQguYXMIGbobNuSzwmG+dyd/tzXugBY0htIWlTHrqE
 OHdoVkVsB7uEVn93a54QzpDgLU9OtkBwhN3xDOb5M4tflKOigckUJs3/Uw77p2XYCttL
 4AI9zXj6iG91h8CNAmrgtKe6gMpXZ7amxnh2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700951903; x=1701556703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=esJWGIrsd/zeTNQus8B5h+10jaBPAT1LT/agV1/VdkQ=;
 b=cJGFPiKzuFbS9UpYx//rgPMWu1afCNgHsWTzRij2Wi2XAmHy0952O0eEPFbrM3Wlqy
 XOIfZnCNJdEqw2g2Y3eV7pGsS+y3sdOlqXSVWs5HMpuEQGQhoqgSzw7LM08qk4/N/yIW
 PV2RZPD/Rm9PUcQ7rmYWIKQGsPUW+bkEwGquLx/QbGP36zehCsXnO22Cfszwj26ZT2y2
 ExLlSaOVIqikPQupbKf2N958z+4DRs4NYs9avLz2U7BsHbCbIzQv7BDQCNpi5T5pBZil
 xQLcSo1JHXr5+HdvHckdLokCPxseqQ7c0WqsgjpseFY/+O4QXLy7xhpxa6qydU0qE+Zj
 dTTg==
X-Gm-Message-State: AOJu0YzFlSdHRrHUgUV6vHg/mI5wg6HFxfIr8uyRGKTSpq+JKv985dJb
 dtT70Gat9vGvigZznsT/rac8tQ==
X-Google-Smtp-Source: AGHT+IE2/nd/gAKqULnc7x9TcVN0+YH2XWKfjEWsh2UaTKhcgoV0aOPeLyfAQ6TI+GJfau4P6Hz30w==
X-Received: by 2002:ac8:5c0e:0:b0:41c:bbd0:48c2 with SMTP id
 i14-20020ac85c0e000000b0041cbbd048c2mr7570458qti.59.1700951902862; 
 Sat, 25 Nov 2023 14:38:22 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-18aa-0515-8718-e379.res6.spectrum.com.
 [2603:6081:7b00:6400:18aa:515:8718:e379])
 by smtp.gmail.com with ESMTPSA id
 kr6-20020ac861c6000000b004180fb5c6adsm2515960qtb.25.2023.11.25.14.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Nov 2023 14:38:22 -0800 (PST)
Date: Sat, 25 Nov 2023 17:38:20 -0500
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-dfu-next-20231124
Message-ID: <20231125223820.GY2513409@bill-the-cat>
References: <87fs0vbfcx.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nd45fldyMgHhzgii"
Content-Disposition: inline
In-Reply-To: <87fs0vbfcx.fsf@baylibre.com>
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


--nd45fldyMgHhzgii
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 11:44:14AM +0100, Mattijs Korpershoek wrote:

> Hi Tom,
>=20
> Here are some developments for next including:
>=20
> - Make dfu entity name size configurable in KConfig
> - Implement start-stop for UMS (graceful shutdown via eject)
> - Improve help messages for cmd/bind
> - Improve help message for udc bind failures
>=20
> The CI job is at https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pi=
pelines/18704
>=20
> Thanks,
> Mattijs
>=20
> The following changes since commit dca7a8958f8d0dbd53072caa4353353e062d80=
ca:
>=20
>   Merge tag 'v2024.01-rc3' into next (2023-11-20 09:19:50 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu=
-next-20231124
>=20
> for you to fetch changes up to 8a0d07807abb5370fe879321c7f1d22fdda3255f:
>=20
>   usb: udc: Try to clarify an error message (2023-11-21 15:48:38 +0100)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--nd45fldyMgHhzgii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVid1wACgkQFHw5/5Y0
tyyZSAv/TBKGMz35lxyW3KvWpKdrJGolzs88d3oRw6zH91+vpyo9tXOVJykkv/cC
QpktyglTcJO+LwZTdZq04fSixPQWUraNIyym4aE8dV6RYdAusjCS54T5OCu5OLg8
gd3ONEbFHXu+dSOoCFup3Z52ntVGJHdByP2DbP85EgvZqpo75ZZlaKOoWTWvGWZz
ff5/MsDTv8WzLO3JABSZ4ITlSeh83HQJP2DAla3LCHYISUBMnHgkIbw8hi2bbqMv
fu6+ut+Mnr2lWK+VChYw3thxPjgdU4p8VyNVvQ+UqLT32HIj+6rMez37Lyld9kgv
EXE000qrG11en4xxFerBgRhMWbgALANAfCfEUMX4Mlte6xo9nmpexH5LRaHGc/J1
tHjQix3cBidobTnwPLR7bLJ4x6k+/YHKrAXLMklV2qYHEWN70wo30P0ss4923MMn
f1eawHuQ7S0qjMYDMW0xnjyyy3rcyxvcTm4OdH+2ndV0sQClzhOIISlmriNmhHkK
EadDSmGI
=ji6U
-----END PGP SIGNATURE-----

--nd45fldyMgHhzgii--
