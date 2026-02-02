Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20798E7FDC7
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 20:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7463683F63;
	Mon,  2 Feb 2026 21:17:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jYY1xhuX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F40283F64; Mon,  2 Feb 2026 21:17:12 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5504283F59
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 21:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-45efe81556fso3300121b6e.2
 for <u-boot@lists.denx.de>; Mon, 02 Feb 2026 12:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770063429; x=1770668229; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nJXc7dE50loloIEG4z78T6H7odzkS6k1JSAcoB1hRsY=;
 b=jYY1xhuXKz8b/PlJXIhb5flziohXwTXVEfokvNjtgrfnzp4RmxEPrSq0Ax6mpnLonZ
 mPuQG8Gs+OQa5/a+UcnDKzZfQfxaP1jVpf3OJtoGGDGH7I65sPOEsAsHt7AsfzXFuTyi
 xiwXZrW8JSCJ6nXHw13wCQR682fnFi6I+GEvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770063429; x=1770668229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nJXc7dE50loloIEG4z78T6H7odzkS6k1JSAcoB1hRsY=;
 b=pvPnQxIx/3i2qQXakaVY3H7e38D4AY2FxDUjuoB5UPDrdunsRUwWjlOIQz5WiJiCeH
 JO4lJgP43xuqsVfim8hJM7bXAru4OGGc9OlPj2qkQ5KgUzIMTr6PsaHgUIuxeAZzgQPQ
 ipxP6K6XFsUTfF801/irhLGBuwD7TLSgbhUz7t0+RYjfhbgxECnM2nLD8jph+Fv6DdFQ
 xdR9hPOSPTxSbzULM/Xgh9T11yW9slonTQ3v11JKE9ilPEAZ/SDq1Y4Meat3Re8/8N6J
 OhVEKfYyJRGKSRJCiXDyPQU9kEXE1b7j0DHE1vnH9UdsFZje/r5pJ3Ajq5WhnPG0iYwW
 mAqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0AILO9OEkteBmIloH1ui/dGGx/9MXD6A/JAn2x6l5sz/7XEeIapdSDJ6dMqvMOkLEq+M4hE0=@lists.denx.de
X-Gm-Message-State: AOJu0YyS9rxtBPWoUbL8BqNU8JF4dj6GXjbZeQC1X+kb9EPI6E0PGj3j
 JWfJgERgFA7+jaObWeMUDHgOiJ+ySNKNUL7xiFWoKx607zFSaNjfbPsmzWQ0hkhFmXA=
X-Gm-Gg: AZuq6aL7lwevLg8f/zdJK38Co7IW//Z24P2G57ydg2dMIztcxXBSA2N6XnlYpgghOxN
 S6IhMtwz4VFh8huvXpUY7Q+ov1AQ9DhlnXj4PK6eooMURQJjxFBQvjIlGdLdwv1Y2CIiuBhk7rU
 SjiE1A0W+mFR7g9FQFOSC80Le3OXWvqSieF9fbDwsa/ljQu+NHZe4N5x+kYtEGAU1TVVattAh8H
 nuKHyLNH+k5MF4namN7i2Iu31fbKRK+uxdura5rNhbRsDLyUcL5+f6CScZI/guRga6mMOw4RYNN
 ABYyM5h7270gOWU6Rl8XBwBGEHXYYOlA8Nei6kE9RIqGRCqm6JktBTAG79turKPTiHJUucsxL5n
 9Xi1JCA6tJ+P5uQ39z4ZUrzYPRa53+XSE4ZIsziTMQAmLZIP28nrkd9Z6d2ZIf+Bf4xI1JDV4TY
 UYO4v0w12xopYDKYN3FX5OctWwZhgPQZzJoOVOXV9xjGDsfYKd1gHZn1uCc6w2lLAfBv17nxOUy
 +ylLmRtY/7V0WLydpLE77RXVhkJNxfQ6BvGb/A=
X-Received: by 2002:a05:6808:3084:b0:455:7fe4:b215 with SMTP id
 5614622812f47-45f34d3baedmr6513922b6e.53.1770063429060; 
 Mon, 02 Feb 2026 12:17:09 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45f08fb3887sm9944418b6e.20.2026.02.02.12.17.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 12:17:08 -0800 (PST)
Date: Mon, 2 Feb 2026 14:17:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Yang Xiwen <forbidden405@outlook.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH v3 0/6] clk: support arbitrary clk_register() sequence
Message-ID: <20260202201706.GA4073175@bill-the-cat>
References: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FgmA9ClJ/K4a+cSi"
Content-Disposition: inline
In-Reply-To: <20260120-clk-reparent-v3-0-0d43d4b362ac@outlook.com>
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


--FgmA9ClJ/K4a+cSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 03:07:17AM +0800, Yang Xiwen wrote:

> Currently, the U-Boot clk framework mandates that clock registration
> begins at the root and proceeds to children. This creates an additional
> requirement that does not exist in the Linux kernel, making the porting
> of clk drivers more difficult.
>=20
> This series handles the dependency entirely within the clk framework,
> allowing drivers the freedom to register clocks in any order.
>=20
> This is achieved by assigning the parent "lazily". The framework caches
> the parent name in the core clk struct and attempts to resolve the
> actual parent when clk consumers call clk_get_parent(). The process is
> transparent to clk consumers as long as they use standard clk framework
> APIs.
>=20
> I've run `ut dm clk*` and verified these commits do not break any
> existing test cases. It also passes the new test case.
>=20
> This feature is disabled for xPLs by default. I have not found a clean
> way to enable this separately for xPLs without introducing a repetitive
> Kconfig entry (e.g., xPL_CLK_LAZY_REPARENT), which looks very ugly.
>=20
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>

This, like some previous clk reworks, leads to run-time breakage
(failure to boot) on TI K3 and likely other platforms (I want to say
some rockchip was broken last time) as well.

--=20
Tom

--FgmA9ClJ/K4a+cSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYEGPgAKCRAr4qD1Cr/k
ChNgAP9fw5UENq+xYD6SJ2hJBOI3hJ6FFynPu21p8tqlyuZRGwD/Xb/W44P7sTjE
j/XYqogasiYod8zJG6vPswHEngMuOgY=
=RMAy
-----END PGP SIGNATURE-----

--FgmA9ClJ/K4a+cSi--
