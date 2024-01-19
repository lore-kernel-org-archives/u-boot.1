Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385CAC47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6080087D43;
	Fri, 19 Jan 2024 17:09:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wxgms3wN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5B8D87D46; Fri, 19 Jan 2024 17:09:22 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA28087D43
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5f0629e67f4so9643807b3.3
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680559; x=1706285359; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=f6Ly+01pfYg1IV8+20wbs3kB2dvvtW1UCrlvHtQ6qdU=;
 b=Wxgms3wNrKnmgRHgc+dHARItY7cbxA/DGTj4ejySojyWtLo9eAw7F7yh5bpOGO+hUr
 DcehZFQ62QKjT/CglVJT2ItXHbUqVLvTHMVM07iuS+TjqpZVOkD4UhoEnIyshsOUOS2f
 MfHCeZhZQPSv5xJm+APGR3nyD/t/QLqEbpve0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680559; x=1706285359;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f6Ly+01pfYg1IV8+20wbs3kB2dvvtW1UCrlvHtQ6qdU=;
 b=QiQuCXX9qXLSJdDybx3ogxyFeta0aoHkUkuFxFzkQY3zqY07vB/aZlyiLpu3LTo/Zq
 m1N6j94rklgR5ZxMQhWbz6c1L1MLKDuTsH1+5Ox6R2LkYRwUA8yzziqp+ebb698cxP5s
 i2m+g85vvxrh5edCcPACcg+yGVJFXC1fbMUWuuQnKUaGS2MeWxNJauUueXa4o5uLbBHH
 5Gx/WE/3gqseJLWkFup+WeSBY0TMdzQRaRcJyEKDgZdJZpUG/2em2QfgNTTJs1Rc+/E+
 jdmVrlnduJYpaY1Dy4WSra2RkC81MMChhmiM6mTu/iJdgbV19+vcNHU20IyxTaWXAMfh
 14vg==
X-Gm-Message-State: AOJu0YyACWurmOb7LPCraQrRpmngH7t6zky088mKyn9lRnZzBCZo8PCp
 /K4m8GEYN4vVqRhAq407ItqsRpf0GCbS7ZjE2C4HBgfKo78JMNMWS0R6y7Vz5Bo=
X-Google-Smtp-Source: AGHT+IEXZ+4o0Qx/U9OG4usQA4UfnN9+9QWB98DguPoTLA2cxupJvhks61jMtjwskGIMihEG4DoA4Q==
X-Received: by 2002:a0d:d910:0:b0:5f0:cbce:669f with SMTP id
 b16-20020a0dd910000000b005f0cbce669fmr102608ywe.22.1705680559682; 
 Fri, 19 Jan 2024 08:09:19 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 l85-20020a815758000000b005ff821bfdd3sm1561457ywb.27.2024.01.19.08.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:19 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:17 -0500
From: Tom Rini <trini@konsulko.com>
To: Anthony Loiseau <anthony@loiseau.fr>
Cc: u-boot@lists.denx.de, Anthony Loiseau <anthony.loiseau@allcircuits.com>
Subject: Re: [PATCH 1/1] get_maintainer.pl: slightly modify penguin_chief
Message-ID: <20240119160917.GY12635@bill-the-cat>
References: <20240111165127.12882-1-anthony@loiseau.fr>
 <20240111165127.12882-2-anthony@loiseau.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IZ6KjKraFF+dY67Z"
Content-Disposition: inline
In-Reply-To: <20240111165127.12882-2-anthony@loiseau.fr>
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


--IZ6KjKraFF+dY67Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 11, 2024 at 05:51:27PM +0100, Anthony Loiseau wrote:

> From: Anthony Loiseau <anthony.loiseau@allcircuits.com>
>=20
> Penguin chiefs are actually stripped out from get_maintainer results unle=
ss
> --git-chief-penguins is provided, which appends them to all results inste=
ad.
>=20
> This is a issue for U-Boot since Tom Rini (penguin chief) is also maintai=
ner
> of some sub-trees ("ARM", "ARM TI" and "THE REST").
>=20
> Hopefully, this match is performed case-senditive over name and email,
> therefore upper-casing Tom Rini last name workarounds the issue.
>=20
> Important note: This also fixes "THE REST" catch all section resulting
> in Tom Rini listed as (maintainer:THE REST) for all files. Hope there is =
not
> too much developers scripting their patch email header from get_maintaine=
r.pl
> output, otherwise Tom Rini may be flooded.
>=20
> Cc: Tom Rini <trini@konsulko.com>
> Signed-off-by: Anthony Loiseau <anthony.loiseau@allcircuits.com>

Applied to u-boot/master, thanks!

--=20
Tom

--IZ6KjKraFF+dY67Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnq0ACgkQFHw5/5Y0
tyyLtAwAsoV3JeUDNQ8R2vhHvFRctPXN6qLR5M0sgDrpOlBGXGg8oHN3W/DXsnZJ
dQv5J9+MIMat72ndyvEMG0d4dYDuS5sS+YvmGEQnf9CHT+EpufwxWzwXbZG2cOa0
OQk1n8DJedzlgiaTSoM/GX2cqJ98QSJFPHINl3PBLY9JSRmT7QX8+mWV3Gw6eFhm
GT60oGTW3t+AVzid8+s0nOK+qRhsuvuhRj7QDxFAJA+wF8vcjVP5d5FUTq4JCHWD
GhZNWJkvacTdLztL9wMDjG2Vh825NPWsrmHabWE4wlkxvPqANein8ynArrCpoC44
ur0rpoSREG4rvxT6AefVfw54Xi/eMr0oIEGggRTjHM2Z2XV3tuvnbWDX+1kP16mO
dM9mib1naKvogylcaejjmzK6lPG9B+uoi+UUaoeTgHH85hsr9x2q/b+fdlLf72ZX
zYztrM56PZvczOjm1uehYuOokffgMI9bwWFPHy99hp8NY9tEEszI2Y2qWn+OMfMp
6Gl0YUhL
=AU4v
-----END PGP SIGNATURE-----

--IZ6KjKraFF+dY67Z--
