Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0D1FD9E1E
	for <u-boot@archiver.kernel.org>; Thu, 26 Feb 2026 23:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6C8B83E61;
	Fri, 27 Feb 2026 00:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N7hSui8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3216A83E63; Fri, 27 Feb 2026 00:41:19 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B4E283D1A
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 00:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d1872504cbso1446144a34.0
 for <u-boot@lists.denx.de>; Thu, 26 Feb 2026 15:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772149275; x=1772754075; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=geBLoK1uHQilY5Otus2VYGzBoRaEnnAvsMKd2z6feps=;
 b=N7hSui8v6l97SjKBIYj4lEju3nkIXQN7kMOXNxtQXlG9tPckOXDPKqXX0M2/J2yBB2
 hIdBjjk1C0WHrFf0pdfnnwochyRt57S7duJ7GPMce6xnsBTp+baUMvlBP137BlSlKbZv
 8SYr9N0z36hap0Wf5U726ZD6xJIdh17jhNEKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772149275; x=1772754075;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=geBLoK1uHQilY5Otus2VYGzBoRaEnnAvsMKd2z6feps=;
 b=LylPoxVbnJAG2jRtOdVUoBwil1q+XqWSgiRng0RvS5HSo+6WHhkVt5K+Wp93ctjyon
 y4GQMcID+6vIlXzcFydgQEUdcv3jUpKxuh5YWLwgAzvI0FdmNHdxQ6HYKQifzo/17QKK
 jUw2hj3L7/3B+jAxC9jvr9jVrIMD7clhTGqEO8IO/soU9mo7P9WOPvTCTMM81aiqKvyU
 icHgk3YgbsWg2f9fyywvbpTLpfF2fougLQT1viKPHvdd/iY6u9hkN1vibpFko3knrhm1
 Rq60GsoZS3FUz8LNBRu1MTSVyQc2eLozDxijK2uWXOGa+KdwxEyM/krvyYlM//J9yXGU
 /Rzg==
X-Gm-Message-State: AOJu0YxHqocP4mNpaDCyYn44tjG17pDUu0+sxL7jGtKdI/GKyLsybswl
 um3VpfLHI+JSDNyixIUysKL0XnQdjmP8RYk8IGJl92ShRqo0g6fJo8hQv2j0maGyyzY=
X-Gm-Gg: ATEYQzwlZ5RbjndtVRHbC/O51NLN3sbDikdtiLMmHT8xvhTs5y1+uKZxQS7NsgeDaHh
 S7pUioI2L3hwJmrp51Ut5xEcvpEp2P4KdoRgRRwfI/VfVMyC5gmrBNfcN24LlcRhHvFxGH79rcw
 cFioXs4Azf2vcaNOf35ElumeHO7Yh2K85OAyHjJLyk00xNT2OxexvQNYYANKd+KXtB8iEVvSjD5
 CLsiBeZs7Gh0OF+cBnLaZ7kiBIp0N0YXoJso+O+kGl+Da/7Py5lv3Rn4qG/4kwEUyVxYS1eL9Bz
 CnMXyT9facLDp/tz0fC70YpEXrq93lVSKn2r39RID+NgxIopMrepXkLPd0nnU/ybyhRtUlw6dtu
 Dd/eMa1lRwnorcaFdtHudXyuIzy/Lfw+xhpb64vE5/NnGA3Ir5e0a96yYV4sOM3MXGJ89iq3Hdp
 2bjLP8KPOA5HIMyOOKGWYmn1VIcL4QbMMr9v4k8Zalgie57ZUM+kwPcsfK0eieNm6iQckaJuJAK
 DsAucegqzqK8yrHkAb6h3K2XiPBkD+YlC5MTYOyjy/G20kO7l0=
X-Received: by 2002:a05:6830:3986:b0:7c7:48b7:640a with SMTP id
 46e09a7af769-7d5856d877bmr2760856a34.7.1772149275197; 
 Thu, 26 Feb 2026 15:41:15 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d586653f6asm3037472a34.19.2026.02.26.15.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 15:41:14 -0800 (PST)
Date: Thu, 26 Feb 2026 17:41:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] kconfig: fix buffer overflow in
 conf_get_default_confname()
Message-ID: <20260226234112.GN1593142@bill-the-cat>
References: <20260226210513.58593-1-ant.v.moryakov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1EqOIOXbyCe4ctpF"
Content-Disposition: inline
In-Reply-To: <20260226210513.58593-1-ant.v.moryakov@gmail.com>
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


--1EqOIOXbyCe4ctpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 12:05:13AM +0300, Anton Moryakov wrote:

> Use snprintf() instead of sprintf() when building the full config path
> to prevent potential buffer overflow.
>=20
> The function previously used sprintf() to concatenate SRCTREE environment
> variable with the expanded config name into a fixed-size buffer
> fullname[PATH_MAX+1]. Since getenv() can return arbitrarily long strings,
> this could lead to writing beyond the buffer boundary (CWE-120).
>=20
> Changes:
> - Replace sprintf() with snprintf() with proper size checking
> - Add validation of snprintf() return value to detect truncation
> - Emit conf_warning() if the resulting path exceeds PATH_MAX
> - Return the unprefixed name as fallback on error, preserving behavior
>=20
> This fixes the static analyzer warning:
>   confdata.c:119: buffer overflow via getenv() tainted input
>=20
> Reported-by: static analyzer Svace
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> ---
>  scripts/kconfig/confdata.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

In this case I think we would be better served by resyncing with the
linux kernel which has:
commit b6f7e9f7050b9f8e5fe60d86e05c0740295a54bf
Author: Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon May 27 23:37:22 2019 +0900

    kconfig: require the argument of --defconfig

And removes this particular code.

--=20
Tom

--1EqOIOXbyCe4ctpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaDaGAAKCRAr4qD1Cr/k
CmTXAPwLq6snvM+25cTCRwGDNJ2fxc1yFFELr97pWMMC5S52TQEA/ZvSVXlL6oZi
Exog8J5j7t+fvLrQEoNGnBeOmoUIjgs=
=5hXr
-----END PGP SIGNATURE-----

--1EqOIOXbyCe4ctpF--
