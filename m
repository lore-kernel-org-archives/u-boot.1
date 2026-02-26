Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93092FD9E25
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFA9B83FB6;
	Fri, 27 Feb 2026 00:51:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B8Dw75JY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59A3883FA6; Fri, 27 Feb 2026 00:51:10 +0100 (CET)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F93D83F5D
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7d19bfe1190so798193a34.1
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772149866; x=1772754666; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=buJmrMuzlBiFojFbtxImLq4ewYgBXYMuLR9sk92vGFE=;
 b=B8Dw75JY8OTPIcPfqUZVqVGNzROFIgeixU3T/KtqRZ4j89ekdefVJGGd1R6is9YtzD
 AeUsOUHloVfjJf/s2fYyGvWyQqOAhfSAyUDxMipIT16RKFq322Xu/aoovpq9x4KT2d2Q
 x9CasScepoFyChrOVyij+VmOAkTrG0l5yQeFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149866; x=1772754666;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=buJmrMuzlBiFojFbtxImLq4ewYgBXYMuLR9sk92vGFE=;
 b=NNX+9tLcNB9QroXTFNeDaGK7ZSLKiaqX8z5GWWW8ATYXn4vG9VJuQJerdUGPvzMLEq
 F1kE7ENo2grt8buSYsAmFqEj2TKMfHJNvgADj0/TN2CAzCTq0TC5FONFntmlY7BKnjpt
 jBXoJD2wBEYE++ldsVUZFMXjPYR+KlNqF0vyabx/KtpXBYdBocGniqjxJrMdGeY9qH+n
 TuhVO7YnAd1byr5Bqr/pAjVSfOWGNRlJbCExqfKMj2K6qQJtIu/ALGft20mrnSuo20Gt
 y2CiFHplaPKOjqYsqzcxGIWuyn67j7NmKxrwrYvV98vxkm5kdb6sOw4TtpzcVR6xtDGd
 t8uQ==
X-Gm-Message-State: AOJu0YztUy62IqiKh9WxyO5yLUhzJgAoD2kuh3VnMy6XWD8v33f/tAy1
 CqYhnzz1fsfsq5Yn+0a0rwA9kMqSn/6E5uQUkzgxX9xgBaMUCIxicAROpG6EGxIl1Zc=
X-Gm-Gg: ATEYQzw8rhk/1x3PjcgwZtrbmYVZ0Q0gIS9iqBPuUuTf5iCuYZXiCJwCaVKRjHDguVL
 cHj9eZR53rRmtxsKgRWGfvLXG7xsojy8uyG+bg6w0D8I7aP/eVE5oabGhCf80SWlwt3U6l28UDh
 bNttvVA+SIieUzueuP5cCQH501QQHiNlE8YH5/z4WlNAMTB7huiKEFUOxJtSW1uTrq11DciIlwy
 bSmvyEuUmmlQy578V+AkJjQNI437zCPOOIGt4brvcuvYrLW+AjKdRFyEQAJ81JKL379JDEiza6b
 KlTgt8YBr0Ah9XVada2sLQfF69v3rCWDlIA7GaXBWjpz7L5//eFSSU86M3ezA+gh41Stb3UB/h8
 CgnZH83s3/WaA4T5Kql6BVLF5C4PhZIi0kPWHurm6PcHI4VTz9hiW3SQT2jeugGXGuu4zBS/C0I
 FXZ2IOGnTzCTVPx4bAtdLpaihmOq/pMVGo//84aZp8Bf+i1N8KxrloJOwBtty1cNb0erl2Fofgj
 8VCFrbvDIIOwdlifGuFWhV/AdcGIyvFrYnWHEwjH+ebmTgkA0I=
X-Received: by 2002:a05:6830:4489:b0:7cf:d1ed:f9ff with SMTP id
 46e09a7af769-7d591bf91a2mr819187a34.34.1772149866157; 
 Thu, 26 Feb 2026 15:51:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58666e5c6sm2985045a34.25.2026.02.26.15.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:51:05 -0800 (PST)
Date: Thu, 26 Feb 2026 17:51:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <simon.glass@canonical.com>, Alice Guo <alice.guo@nxp.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bryan Brattlof <bb@ti.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, Moteen Shah <m-shah@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Yannic Moog <y.moog@phytec.de>
Subject: Re: [RFC PATCH 00/16] binman: test: Organise test files into
 subdirectories
Message-ID: <20260226235102.GO1593142@bill-the-cat>
References: <20260226234802.345968-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wIAt3NozYXHD0qb/"
Content-Disposition: inline
In-Reply-To: <20260226234802.345968-1-sjg@chromium.org>
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


--wIAt3NozYXHD0qb/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 04:47:40PM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> There are about 350 numbered .dts test files in tools/binman/test/ and
> we sometimes have trouble with numbers being reused.
>=20
> As an alternative approach, this series moves the files into thematic
> subdirectories, without the numeric prefixes. This means it's no-longer
> possible to simply type a three-digit number to get the right file, but
> the names are shorter so it is still easy enough.
>=20
> The subdirectories chosen are: blob, capsule, cbfs, cros, entry, fdt,
> fip, fit, mkimage, pack, security, symbols, vendor, x86, and xpl.

This seems much more maintainable, thank you.

--=20
Tom

--wIAt3NozYXHD0qb/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaDcZgAKCRAr4qD1Cr/k
ClfPAP49JvMl3PFag0e9lXub4mDxG+T+mpmkWCwMGLFx+Y1WvAD9Fmep52Dp23O+
4S46agb5FctC322Z6D8lkWti+NNIuQQ=
=5Nd5
-----END PGP SIGNATURE-----

--wIAt3NozYXHD0qb/--
