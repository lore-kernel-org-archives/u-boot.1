Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00610D116E2
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 22:45:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CE1083C40;
	Fri, 28 Nov 2025 23:45:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HQtSHazQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C1483C64; Fri, 28 Nov 2025 23:45:18 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FA8183C14
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 23:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c6d3676455so729965a34.2
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 14:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764369915; x=1764974715; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iDjoyZdoJH5pRvxZYbftfpNEFetlSgUgzksJ0R+SNFY=;
 b=HQtSHazQ2vGPgR4u8f1J4pinPg2XaDRqh51YALKk1IhfvO/77+wsHgEgAUNKAavGtD
 Z8B/Q/9b2iqdFSjtaTKo7rN7QMAmwNQHORk10jV14C9+Y9VmIxWdOVwDMM7eB979jSyV
 mgBOGw+kwT6et708F/PaeeO3EOyYUZxUGp6es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764369915; x=1764974715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iDjoyZdoJH5pRvxZYbftfpNEFetlSgUgzksJ0R+SNFY=;
 b=rzBG/biO6ANXiPTEkJqqgVaS7bf1pJcwI0/m6pvKNy0GYkc0Cv48F+oKJsq22HawjG
 q/OyOqMLuiiGy6GTQ7vgb9iQVhwumEnNQyHknTqGCkhUTqILljTFidB/dPgxPNQHZDMr
 yFDZfUpKcynFtvu+q8nBJ+aajNLtC4lCuCAxB7oyUBxZObYQzHhWzXR59Nay2MucPqad
 T3PoKVGCSNm+rj+bCT0ouMDpau1cKp+hvl0CXFr9f/HkN20MaVMskFEVBYwKUjOlxkQF
 nlMPQavU7/q75Fk5IaVSq3BhYXNkg3xLMdlOUmnsAPZjJik0v1rmyN16Uw4XwaL5S1M1
 Jexw==
X-Gm-Message-State: AOJu0YwJCjhouLdAXix4b03diSU+mVvpkLbTnOWDmSd+JUZwJNIjYE/M
 Kl96/y2HpIk01IfD0zW6Gxp3o8c57p1kOuRzb7pVf7bGCOMTXKoxTwzve7krZRaCeQM=
X-Gm-Gg: ASbGncsD1d6NdGIDKZhVJZwNsLsUtXUurL8ZbIOn70ZnLLBZ6C/lnD+ly0GUIA1THvq
 2dO7LdIMISik8ByUNcoeDsl37sFmn1CUhdOFKb1XxIgHXoXNw/btktNUCLWQwj3l2XJ2zBEcqVU
 wzzt9/dWtcH9clUmXW8rDNYcWBnabcegbvaOBi11DO1UeWDTfV66vYI7frhVvPyyoRdsOSP7t3/
 ovv+zuSEM/J1soDrdBurKL3mw5rAEj9U1fJ+ONrJO0UqVAGQR9c8mhlq9Zg3PAUI51nQfW0vXU8
 Qd1hA5/i2t2SIEM/zaaUEsRpMO6Ngc/T8x0GKLtoefbHdxVceZ+lZeoQyVxSFvrxWlYZiwFvroc
 FC0T7Mj/bPoAeBTpNmdFPxJWy6Mzuln4iGnSJRTT9NWHJEknlBbrxjFVYcpfcMb0PFCZflJ+ahv
 ljNQ7T+gu//sW/RxWJiEwhBeHBgmsmL+fnYv92q2YzDMJBfiasJA==
X-Google-Smtp-Source: AGHT+IHOpC6pn/cCwe0uVDnS9PaVFm25jryrCpCSkXyU/SPtN7SmK+LR74siiM7oQ0kGsO2Kyu1D8g==
X-Received: by 2002:a05:6830:6da5:b0:7c7:53bc:54ac with SMTP id
 46e09a7af769-7c798f9e8eamr12709876a34.13.1764369914906; 
 Fri, 28 Nov 2025 14:45:14 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c910026bacsm2086155a34.30.2025.11.28.14.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Nov 2025 14:45:14 -0800 (PST)
Date: Fri, 28 Nov 2025 16:45:12 -0600
From: Tom Rini <trini@konsulko.com>
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 2/2] clk: ti: omap4-cm: Add Kconfig symbol
Message-ID: <20251128224512.GE2125796@bill-the-cat>
References: <20251128-topic-am33-clk-regmap-dep-v2026-01-v2-0-451b4f4e7e85@baylibre.com>
 <20251128-topic-am33-clk-regmap-dep-v2026-01-v2-2-451b4f4e7e85@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CplFR9ZB6ukdVjIF"
Content-Disposition: inline
In-Reply-To: <20251128-topic-am33-clk-regmap-dep-v2026-01-v2-2-451b4f4e7e85@baylibre.com>
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


--CplFR9ZB6ukdVjIF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 09:22:19PM +0100, Markus Schneider-Pargmann (TI.com=
) wrote:

> Add a Kconfig symbol for this stub driver to avoid clock dependencies on
> an architecture symbol. Enable it by default.
>=20
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CplFR9ZB6ukdVjIF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSol+AAKCRAr4qD1Cr/k
CkhSAQCSMEgMQWS3oJtLW5HmenubDprV3HpiYTzvmYHzA6rRMgD6AiejjLUdtJGG
nTLPd1mKvsR4buFFxTWPgsBtqAU8oww=
=ppVP
-----END PGP SIGNATURE-----

--CplFR9ZB6ukdVjIF--
