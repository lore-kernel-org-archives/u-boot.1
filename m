Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15DE2C02193
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 17:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82B9D80207;
	Tue,  4 Feb 2025 18:17:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t/wFjd/C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73772803B5; Tue,  4 Feb 2025 18:17:28 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41BFE80040
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 18:17:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5fc01d3faefso1595116eaf.1
 for <u-boot@lists.denx.de>; Tue, 04 Feb 2025 09:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738689445; x=1739294245; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yRtjNrfo6mEU2ucf0b32DAMg31wlAIMmcD8/1ODCNWI=;
 b=t/wFjd/CzdHlwAo+OgFFgdYvUjIBXiXxqboj7fxtN29wO9eZc2pyDuWAx2FQhwEkwP
 uGzEjttyxwUBRgMKJlS4Zaw34mi37iB+z2BdIetiVf8PUeC7qk66Ncox8/Xaqh9iOJpj
 WmT5CXGmF7HVKJ9QPXMOUnOYDoMNSr/aHE4Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738689445; x=1739294245;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yRtjNrfo6mEU2ucf0b32DAMg31wlAIMmcD8/1ODCNWI=;
 b=REWqGvpxmV7uKvZxjdma0YVwQGErv3NuSlITXbzaslyPW3F1ufaiVyi3Cw8DXfxWIX
 TwW56ugZm7ralBxaImRHDhNJe5hAZ2aEKGoDjsROi1B7aYCTN9VlcqeYZUQP5PoQvDr3
 iCQqjLhlJI10oGpTAF8c20lFGdF3USisIIzd8y6dYA7p/kf4RSAo71powhsdUkjByTe7
 ugwNAd8TjpNeDBPBkYd5JwDovvrJCRDOQs3goTv9VibiYu28rcDAKRNjUGhC+GgJaSNq
 lhHt5kFc1SpARxojIt7GH+uuWUHoGXshtel5xe9yuILadvar3uFAJUyMtFhPnkgcF/rY
 mAQw==
X-Gm-Message-State: AOJu0Yzf/cP83NjRboOKIpEuOXgrrJV6MBwzL34wUIKC8Ctr2y3ebePc
 7EBD+FF3jzTs5Dfqu04qbq2MS350O8wNhYvEiPY/1FRXKoQ1P6lRJiJSvvQm/50/GQRXLcTeue6
 pHhQ=
X-Gm-Gg: ASbGncs3R5/E1pNiO2+5kDIfBJibW9NmboqfKIDzoZMn4xu/eXhsWiCqcqFDfNSFCb/
 RyEiEnoNX5Vg+SNIg6fVnDCBD8bPOtdW623tbhevbYgJaSlUKRCsx9QsBvMcmpTyTJolz7inwCs
 t3H55J82A6CcvjK8lyJmROnrUy02zKViIQp8SAA3n/3WK4TZ8qwKWhbKmYkf+0ko6X0i5Z7tu1I
 HyYaHc2pE699/IbuLKW/hxGnPca2JfnbTOvY+hLmn+8eS27m3tVek6gBYpeqkbLPBcO6R4Hxq3j
 K0OKwweUK7/sxCg=
X-Google-Smtp-Source: AGHT+IHLmtImXVbHE4JqfqB4c6I3vTdHYjzf/pGVMKmpRthSH4KdZCdDyGN/OBccOp56k6ROwfBHwA==
X-Received: by 2002:a05:6871:7a84:b0:29e:6b6a:d6f4 with SMTP id
 586e51a60fabf-2b32f355c37mr15305539fac.37.1738689444863; 
 Tue, 04 Feb 2025 09:17:24 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b35623d2ffsm4030604fac.22.2025.02.04.09.17.23
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 09:17:23 -0800 (PST)
Date: Tue, 4 Feb 2025 11:17:21 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] CI: sifive_unleashed: Rename "spi-nor_qemu" variant to
 "spi_nor_qemu"
Message-ID: <20250204171721.GI1233568@bill-the-cat>
References: <20250131220515.3060059-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KLQ9l+rYJAGm5QhO"
Content-Disposition: inline
In-Reply-To: <20250131220515.3060059-1-trini@konsulko.com>
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


--KLQ9l+rYJAGm5QhO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 04:05:15PM -0600, Tom Rini wrote:

> Given how files are searched and parsed, we need to use the
> "spi_nor_qemu" variant name not "spi-nor_qemu".
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  .azure-pipelines.yml | 2 +-
>  .gitlab-ci.yml       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Now that I see what's going on really (and I replied in the other
patch) I'm not doing this rename.

--=20
Tom

--KLQ9l+rYJAGm5QhO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeiS5oACgkQFHw5/5Y0
tyxWAgv/fsg+HP4dLrjTARcxy1rA1PAvNox3g+Ahe1CHPSB6p/m+/kvNNs3n2zHs
AL8fN3J+N1jGcKTY02wit/B/W9F9Pzh54IDuA6rA6VzWRWyFAw9aX1levNsWoYS6
RV6Dnt5ddfijlqydJ2gdRYzbhDYUpfR2iFg6Lwpn27avGqdJaXb/Cp40BsWQjsbz
5309zyCDKzhdXabVIQgy6Q94SnIYy5fivrmE7Sv8g1oEqwnqHXS69fJvYeWOSP64
u17i5Di0S6EZWVZtOaExt7Z3rNYgH8v2fajE02gM+trpZqOnBnf9xAoBcYX0+h8s
3y8yFjuLdm+wiJzPZiZWEJDPCg4Bnr9jGmiI8zqj27xFJr2bQQgVk1QPvyVVwOhg
/yFJUBGCWCQv2U1rWKsBNM/WH+cie3Zf33TX/9fcGB4Bx+Qcf8y6oBB4ie+4+8Xf
G1coiznVv1o0DzQFYKD9nSqC6e06Tdn5jHFX7uszUgNe9HF9pNG1irSbupRjVMig
PE0Dlt3B
=fDG6
-----END PGP SIGNATURE-----

--KLQ9l+rYJAGm5QhO--
