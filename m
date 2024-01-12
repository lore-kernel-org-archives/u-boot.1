Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD778C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:46:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC19879BD;
	Fri, 12 Jan 2024 14:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cdbVA9jj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69373879FC; Fri, 12 Jan 2024 14:46:22 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CC5387A77
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5e7f0bf46a2so63262457b3.1
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705067179; x=1705671979; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LBzCtEjgwdfGBY1AycxwSiWWZwNaK1iHn8SkuP68JxI=;
 b=cdbVA9jj32+eB30SDV6vsYQbM/fNJko6o8Pj31+0xJnF3Eaby01P2ht06xJ0Wsq/zy
 0fQ5xNB3eqdSThC9RSbqkqcPMfVW3focXhUnTcPse3getE2I4Ye/uE9GAVQeq3rSDG3t
 8wUn9lS4TBLWZdgJlbZKuaa9ShJZ3zb0a8oiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705067179; x=1705671979;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBzCtEjgwdfGBY1AycxwSiWWZwNaK1iHn8SkuP68JxI=;
 b=C0tvfaGMePT60dSggsqD9UHeCUEGzAKPTaQ67rJYLLNA+kzgStY5vbivV2t3GHYLOO
 EMUtD78ZR0pzBS7+VRnr8EKqGhobEJiMTtBTd8DDLlgsIz+6v9KHkioHCCoy9jy+s+ge
 W1JCqlNjzkE9Cf/cWuNOyEMhR7sUOrpEd+zc1iGtiVyiTrfPMvNbgtxukhrQ+iRxLQG5
 jvAd4ngWvtU6a1k2GwMUnipetMZIqXK6njKwJCMh8etxOu3pFT6CKsk9OT0aYvXR3cjA
 D2Apq0dtIaJhRXmKC2SkmfNHaLhX67ekSBFp8PM0bTCQkZAYE/R/pTCLZswg839rWQR5
 KQyg==
X-Gm-Message-State: AOJu0YwA8jp+WGXvYEADE+jNDrkvNLXzPCyeiT1K+Y9KONe0sCW1c79Y
 i9GHYnwM7E2PwTUegMl9uY4uZD2NyS2Zlw==
X-Google-Smtp-Source: AGHT+IEADAhkCBMoA+1yAdNySxi5fFvaLy2umoeUX515wg0CU5ImWexy+5QBa/wSiT6JlGW1CS4BNQ==
X-Received: by 2002:a81:b382:0:b0:5fc:111d:abc2 with SMTP id
 r124-20020a81b382000000b005fc111dabc2mr619292ywh.49.1705067178898; 
 Fri, 12 Jan 2024 05:46:18 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 g201-20020a8152d2000000b005e2b2c5fa24sm1344641ywb.98.2024.01.12.05.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:46:18 -0800 (PST)
Date: Fri, 12 Jan 2024 08:46:16 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] boot: CONFIG_CEDIT must depend on CONFIG_EXPO
Message-ID: <20240112134616.GT1610741@bill-the-cat>
References: <20231216153836.81717-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wrXRF2/7+G2v/Sik"
Content-Disposition: inline
In-Reply-To: <20231216153836.81717-1-heinrich.schuchardt@canonical.com>
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


--wrXRF2/7+G2v/Sik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 04:38:36PM +0100, Heinrich Schuchardt wrote:

> Building sandbox_defconfig with
>=20
>     CONFIG_CMD_CEDIT=3Dy
>     CONFIG_EXPO=3Dn
>=20
> fails with
>=20
>     cmd/cedit.c:258:(.text.do_cedit_run+0x4c):
>     undefined reference to `expo_apply_theme
>=20
> Fix the dependencies.
>=20
> Fixes: a0874dc4ac71 ("expo: Add a configuration editor")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--wrXRF2/7+G2v/Sik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWhQqgACgkQFHw5/5Y0
tyw88gwAlDMC7Q4GO/iOPYa1znLQAGfuH43tNO3nDfJCGr/Zcjn2593JLWPpElHA
xfiakdJpRcAi6GtRnv5dokeGr6n26Yft71bJwJ5eWmo3le2jt58/tc3lXrTcWv8B
QHwPtYKl3D7UOdRkydfjz7TtX4YW7/UmAjw+GMOa9HIVu5iNMNG3Ic/KYBmbZ3OD
oiJDB4e7wPN2pTaJxu+6TkIU2DSBMsoEqCol0EeEeiAsRsuFqZD6IzPyj4hFRnTn
0KqYtxvnLyWsg8gLwz84NZ2ZK3KSD4enEv+0pYmMwRZrovUJKw30t3eDg9UwNL76
J8JwLvFTzrT0iU0LwbpRO76p5Gm+kVTBmNwlFsXSmYccU0VHBuUK1w2Y33GPPxUC
yRQC+JMdktxGKrhL4OTzUvV3Q3BICo5Km9Bh59dIoI4dEmqy9Ak87UBHFtdyjcyy
gJduBEHCWD+RoZTZKAzNuCE/MSf74jweCKfyvBG2sIz1YM3DnW5rLbKyucFrMn1c
Bin94Bww
=40DS
-----END PGP SIGNATURE-----

--wrXRF2/7+G2v/Sik--
