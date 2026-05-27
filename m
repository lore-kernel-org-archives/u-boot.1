Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E69CD5BD2
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 00:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61169848AA;
	Wed, 27 May 2026 02:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Wm5k7kdE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7484E848EB; Wed, 27 May 2026 02:09:31 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD795848E3
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 02:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-479d593a0c3so9316789b6e.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 17:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779840567; x=1780445367; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4EiSmAGlgI16hJuZzsD0YRnrTfArh6lmwuDOMDw3jzE=;
 b=Wm5k7kdEsQ0WkjWqrXFzLTFZN8CDZGx/ozbuRBWItUm6mrq1/Gfd9hnM9VBUR9V8e1
 5gHkjw989Iqua7lTlZYdbdHxPIIifaYxp2S+NL0g7UegeQ7XG6s2uzOlgyxIMpm6GMSH
 T+gDV6+t6hijaexQISv35Wsvusm3QnxZ2F3IA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779840567; x=1780445367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4EiSmAGlgI16hJuZzsD0YRnrTfArh6lmwuDOMDw3jzE=;
 b=oXDUIPOI1UpFCBes2tjaToWueA6mYnBu3VtXxtxDDwopY66O9lbr1QPFMCRdvdE2qS
 +PRhuB2ORSwj4MM/ZOtQnfEmt7GVzGFzTufriTUn1AvYTP4jK/dglz0buqT1l+k/6F8G
 Py1PK61CprIlgHRy20sV9HLU9Fmxve3bdzmp9hLPDf6/YPzsaxzvIoRePlzxNzvsxuF6
 z1pg32bp9VWXrhgONY/ADPQeHFm6/fcFGKZb9uwS1krXO73HBdF8Cjo6hgphQYuzn6eF
 ihwLoz0FtViuJjKg7Yi8tW2dfCa0eg/lyX0zj6NAA5vdqhZtTvC3r9WKueGpqeV3O9Ws
 78Mg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+7y9NQgAGX0hMKQ516yacwWO8ai4Qfb9+U9TKA7XE6CHLVawUf2NU6IJKpIR4wGO1OzdWHCo=@lists.denx.de
X-Gm-Message-State: AOJu0YyEPTz+lXDAaNun1WOlhjEuK9qtCB9mrd85uMAo9pNnkrzpgjZo
 wk3GDhSt8A12EevvEHCPMR45SyMX5b3HFA36lpPL+aezYgFQ54x2YECepm3dAs6tEbQ=
X-Gm-Gg: Acq92OEKkcv0+Vq8do1mFC+5FqTBdL2/kAYzZnZBEJd8/Db5r7c2bZQX37mUkz8ku5Z
 E0bOAmPVOsE4xj7P/OcWxhy95n1s1IGwISTQnerb6zIyn6ySjsiRQFgsjxSmRto3z8hxothZTUr
 F2vd2bONwJmE62siRo2yKdSExIh0hHn8fEzjMQAIoY8LQkiPsqjYpDqK/X7NcULry3gtIz+y4N4
 xPlpZcoH4RoyNKrLazLbDXDL7MEQRJiVQQ/QQErfqpIQLIZ9+le+lNhoxfwqYN4qoSBRUwW1T/L
 60NQ6DTrx32k/WABzY/p+UajTrAqy/0opanAmRe1LDPbWJAl3lbjpifELg72fH25lqYpwuJptdW
 EQIjZyX2eU43naaLFw9jazcOQ2tStMDGdtagbcYgU4obDFSyNY3K3kJQIpqv6f57GM1KVP5A4Xs
 9X+mzM+rEx027iYseI9bQ9ST7FyowGcZU3xo2+/GQi+Ht7r4UQwTLESP3LD4IRQIC2bco6WyXXr
 yZfiuAb8PULNVXVX/sL528+hX+h1GOrrV11NC1QodIbIum+wbd3yFbU
X-Received: by 2002:a05:6808:1783:b0:467:16e4:d2aa with SMTP id
 5614622812f47-4852da149efmr11837075b6e.9.1779840567464; 
 Tue, 26 May 2026 17:09:27 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60667af4csm10424515a34.27.2026.05.26.17.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 17:09:26 -0700 (PDT)
Date: Tue, 26 May 2026 18:09:24 -0600
From: Tom Rini <trini@konsulko.com>
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org,
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, afd@ti.com,
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCHv8 0/3] various memory related fixups
Message-ID: <20260527000924.GA4051518@bill-the-cat>
References: <20260513204943.736142-1-rs@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GXx2uYXVhw61ou0a"
Content-Disposition: inline
In-Reply-To: <20260513204943.736142-1-rs@ti.com>
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


--GXx2uYXVhw61ou0a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 03:49:40PM -0500, rs@ti.com wrote:

> From: Randolph Sapp <rs@ti.com>
>=20
> Nitpicks and fixes from the discovery thread on adding PocketBeagle2 supp=
ort
> [1]. This does a lot of general setup required for the device, but these
> modifications themselves aren't device specific. For those specifically
> interested in PocketBeagle2 support and don't care about these details, my
> development branch is public [2].
>=20
> That first patch may provoke some opinions, but honestly if that warning =
was
> still present I wouldn't have spent a week poking holes in both the EFI a=
nd LMB
> allocations systems. Please let me know if there is a specific usecase th=
at it
> breaks though.
>=20
> [1] https://lore.kernel.org/all/DHHC66BBMD27.YHGIH43C6XBK@ti.com/
> [2] https://github.com/StaticRocket/u-boot/tree/feature/pocketbeagle2

This leads to test failures now (that either need to be fixed or
updated):
https://source.denx.de/u-boot/u-boot/-/jobs/1464028 and please see
https://docs.u-boot.org/en/latest/develop/ci_testing.html as well for
starting CI, however you might want to run the tests locally first.
Thanks.

--=20
Tom

--GXx2uYXVhw61ou0a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahY2MQAKCRAr4qD1Cr/k
CieLAP9ljqztOxFbdPX8s2nrzz9QBeaNRaYv6ETdzEr5Sue/wwD/f2RSlrhbxMrD
H2CoD9k31hfesPHvWYxKymuZAXPVzwg=
=+jQu
-----END PGP SIGNATURE-----

--GXx2uYXVhw61ou0a--
