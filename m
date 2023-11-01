Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81988C0018A
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 14:47:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC69487596;
	Wed,  1 Nov 2023 15:47:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qZH+5zlL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6950C87595; Wed,  1 Nov 2023 15:47:23 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F179F87596
 for <U-Boot@lists.denx.de>; Wed,  1 Nov 2023 15:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7fb84f6ceso64126467b3.1
 for <U-Boot@lists.denx.de>; Wed, 01 Nov 2023 07:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698850036; x=1699454836; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1W2202ackWowfCHV3nOKDT3x0ZY8uhL2YCegmwSMsnE=;
 b=qZH+5zlL3HTTMNzYN1JGbkAirwYttET7v7Qqe4cyUybxR4Xuu8ouwZmY29OD6c7bVh
 jq3zrrh8QUJNaIg4KAeFHHl37xNiOoheXdxL2m18zsOocYK3sgTNlXroKrSY+eXF7eKb
 MA46iRhVNgZuxfhbbsgafS4G86Vc2JlbuZTyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698850036; x=1699454836;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1W2202ackWowfCHV3nOKDT3x0ZY8uhL2YCegmwSMsnE=;
 b=fWMzPYpEMr+IjmaoD/p1oqLAeI2nWLA0lsXnIorOAByM9RhY9mnhSNl12uFsImL2gH
 4Q+9VSYq9xtm9u8YrvM4TokbmQc9r9eYlOQf8wYEb5JJsgU2AbbiiiOyO4TjN2B/OT5K
 L8NPpqU3JTnu1lArnq9Z+huk/xXM5vi2EEAvgSRoqpyM7TKKOmGqPM95SXCvOKsYI9TJ
 pca+UTeGOXNt3JaQPoDOG12FMCTyN9IhLpgLpC4Pe3fRKy6ep9Dq4iuWJ+yUUQIeqIe1
 Ohc2tcjBvO/9vOAAmN7bj+6GWsygQYE876/rZYKXSyN8Sv0aulRil9SrN7JrZnA9cjG6
 q5FQ==
X-Gm-Message-State: AOJu0YzgL3romlO8RXliJcJtdDnTFvUjK+0eT8nDQMXLifAHDIN1KzbJ
 U0ir2Blkf3j89xwjbVpqro3mKg==
X-Google-Smtp-Source: AGHT+IGIqssc8M9cnYKrEOQazSCROhOXpYYLjm4BrjqioSuUz51TwNf8XRoSXY9Cpb+JWoiu/PNG5Q==
X-Received: by 2002:a81:4c0d:0:b0:5a7:b797:d1e4 with SMTP id
 z13-20020a814c0d000000b005a7b797d1e4mr14648723ywa.21.1698850036540; 
 Wed, 01 Nov 2023 07:47:16 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 y24-20020a37e318000000b00767d6ec578csm1487982qki.20.2023.11.01.07.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 07:47:16 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:47:14 -0400
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: U-Boot Mailing List <U-Boot@lists.denx.de>, marex@denx.de,
 sean.anderson@seco.com, Bin Meng <bmeng@tinylab.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peng Fan <peng.fan@nxp.com>, Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [GIT PULL] Please pull u-boot-mmc master
Message-ID: <20231101144714.GB496310@bill-the-cat>
References: <CGME20231101075631epcas1p319becae866c164fd73339181486f8f35@epcas1p3.samsung.com>
 <3ba8e520-989d-4243-b542-b9fb27868332@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zTnrkcHXT7w+YyAS"
Content-Disposition: inline
In-Reply-To: <3ba8e520-989d-4243-b542-b9fb27868332@samsung.com>
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


--zTnrkcHXT7w+YyAS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 01, 2023 at 04:56:30PM +0900, Jaehoon Chung wrote:

> Dear Tom,
>=20
> Please pull u-boot-mmc master into u-boot master branch.
> If there is any problem, let me know, plz.=20
>=20
> Best Regards,
> Jaehoon Chung
>=20
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/18386
>=20
> The following changes since commit 62fc66b6d228d628c3f672c736aa57e4174ac7=
83:
>=20
>   Merge branch '2023-10-31-platform-updates' (2023-10-31 13:08:10 -0400)
>=20
> are available in the Git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-mmc.git master
>=20
> for you to fetch changes up to b5f403936d037e0bc08e78b8af64adf53da13b90:
>=20
>   cmd: mmc: Add mmc reg read command for reading card registers (2023-11-=
01 10:09:21 +0900)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--zTnrkcHXT7w+YyAS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVCZOcACgkQFHw5/5Y0
tyzDpQv+OYoV6CnA65C+JZlO1alWHFW8tfKpEiSZcl1vvOekU6U016iHPrFeE+mg
LEEoCOTpN+4uQMR8Dg60/Nrlzxqtr75eir+SuJYZmDIC4FyoMiiCwarHMCvv3nXg
sScDgwwFNIHbaDqu/njhIFrHhBubzp20HCOmvBB9VTX+kWcuE3fFibeDiU39JIuR
EADTfAo+xNuFFZ0MzFW/2JrCje0xL5+Vvz5RdQ9wbO8vIcR9jhdQcx1pr2kdeOnJ
AeThHpy+0SpZgpLGqWc7nuZ2pZxQjeuiF+rYeTq5s8gAFBkZSlOqbFcUeYJmxBoo
nXDfol0L7QGFfFKuw5urIB50EQzg3h+vZaC2BDnujSIbR0O/WTxL/Bjr5RI2DKa7
NAecOeR7TpdP/s5Ba6PvUcDFgc7Ee0DGgew7hgz0zgmNuMrm2nrYNt23brqZp/0q
2qo+onwflhHGgXxNoW9VilfLBbJ4DknjfE+SjUWC8VD1zJ8f/GNot3I279PntxCm
oZTgGrS4
=x+jH
-----END PGP SIGNATURE-----

--zTnrkcHXT7w+YyAS--
