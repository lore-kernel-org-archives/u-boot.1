Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE56C43602
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 20:26:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BD38486A;
	Sun,  5 Jul 2026 22:26:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GX7GJ7GF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75A51848BF; Sun,  5 Jul 2026 22:26:45 +0200 (CEST)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5865D846F8
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 22:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-6a18e363d52so1916287eaf.0
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 13:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783283202; x=1783888002; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=klE2x2XzaIhKmWEONFuHSoM/1+52qVuo/TNIOwbF0DQ=;
 b=GX7GJ7GFuwkIzjMOAUaiqAwoCvveQAIkqStnULZR7BjGivH32JWrTkmDw0y/4l9Bpt
 62Q6In0rU5EnTDZpBW02h304C6BMoNp/KWFgYBGi3KjlDUvgi9SmJfpCdb+xHZaG/uyp
 Oi5dc1jsecMwPP5k3UkhUkGUkKn0gxLERRtFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783283202; x=1783888002;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=klE2x2XzaIhKmWEONFuHSoM/1+52qVuo/TNIOwbF0DQ=;
 b=eopFl9A/iPRA6aHOrdtyFvMNx+j3sU6I9Nb/NuZBHYCMDyhBhzrGz9CC3ncQWOnnZ3
 qkL8PaSpaZeFdCpfIrr02B0cA5fhefU3uKobUBQlDP2mtxmTbLelUdTK8ZgzwiihV8h0
 hNbrbBZuiM15JxImV0yX9xCPDjniyzveJh2rJ9jTkZeMGruBI/Z90hlRXA7c3qr1PXSA
 ropX0PVNL0cGSvJhkdBvf2EX9c757E7C2u3pSJO+/RcPxxXjrBPCCRkJ15x8xLOI3Q6A
 xz8n7O5RsjTVYfkqCvgajSU1sAJVBtRDRJULOB9Gm4cX2kK8a5OM5MymUb3tAI6B5mTz
 Mcuw==
X-Gm-Message-State: AOJu0YyoDJUeyT4W9vVDq/7wD48ccpwako/yRXkheYcil0GjQY9kKb9N
 3yqAjIwDa+JPwfOuzOLPZf4o9NJ7LsD6D/QqJ7KxWK4XhLTwHoTbaAr+I1EQJGZrLrc=
X-Gm-Gg: AfdE7cmZLuoq9BOcAvh/zIz5mXFntuVexa2wTPRo/YK2oixk0Z+cneKgxMCDDZjFBgU
 SZL7QwwS5A26invGYLEWay/M+PuSdMeIezdoA9zp5K4y8BFsR5LtHI72N7p7QsAsuIy6FtrL09I
 WdgkYvw+tHNBdWXg7DGM/it2Ut8imrHr+k6M/H/QSgG6Ch/OP5rBP63r6u8fukzE3wRrIukDFR5
 rwGNen1/dXn5cUdFk2yL/FTe2PiQani3KrjYzfNKGqM6p48MDNzKbZh2aPHWyWt5geHJtS1imh8
 CF3nUEgQwFnn93ZkpNYuBPXBfYltP8uw09MuqS+w5VvcgSAKAyM4EVLJ1J06uSEkKYbMatEEnT5
 qlAjig75rNV9/xGS724XDHpaFV4/LpgGnomq/DK2lVR4qV9XC0NPPv1lRZF0eiPaJ+COe4n2fj4
 kbuKn4wFBTmLHPyO3VBfKcWSwxTygF4PJHVxNrJ/+EXGEgVC0BlVcP495hXIocnDjhiPx0ULcFx
 Z/vWveG36+mDUhS+nCHa3qhQGNhnYU5OekeKw==
X-Received: by 2002:a05:6820:4ded:b0:69e:89f8:9640 with SMTP id
 006d021491bc7-6a32f65d920mr3458912eaf.18.1783283202116; 
 Sun, 05 Jul 2026 13:26:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a30ff8e0a0sm7817628eaf.3.2026.07.05.13.26.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 13:26:41 -0700 (PDT)
Date: Sun, 5 Jul 2026 14:26:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 02/11] doc: Remove the patman documentation
Message-ID: <20260705202639.GQ749385@bill-the-cat>
References: <20260705193251.2190705-1-sjg@chromium.org>
 <20260705193251.2190705-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4UHT2aB9tRq4qnqA"
Content-Disposition: inline
In-Reply-To: <20260705193251.2190705-3-sjg@chromium.org>
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


--4UHT2aB9tRq4qnqA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 05, 2026 at 01:32:13PM -0600, Simon Glass wrote:

> The full patman manual now lives with the standalone patch-manager
> package, making the 1000-line copy in the tree redundant.
>=20
> Remove the in-tree manual, its README and the doc/develop/patman.rst
> toctree page.
>=20
> The sending-patches guide already introduces patman, so point it at the
> patch-manager package instead of the now-dead ':doc:' cross-reference
> and, with the manual gone, add a couple of lines on how the tool works.
> Point the SPI howto at that guide too, rather than repeating the install
> details.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--4UHT2aB9tRq4qnqA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakq9/gAKCRAr4qD1Cr/k
CmTNAP91JLZ4JTvk85x9RFZD1i6dakJZiKXvbQYlP6wcPDaB8QD+PJIJqCsmp4Kh
UM0JLfqe8kdwMKyC4yOnGVhFgj/BWA4=
=02Xd
-----END PGP SIGNATURE-----

--4UHT2aB9tRq4qnqA--
