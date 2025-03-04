Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB81C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 18:03:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7804801CF;
	Tue,  4 Mar 2025 19:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V+y5BLzI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 617E5807D9; Tue,  4 Mar 2025 19:03:42 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E024D8006D
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 19:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e4930eca0d4so4279880276.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 10:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741111419; x=1741716219; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oFpL+DWs1QA06Nma/kv9+5AcK4XIsbTGH2G20VNGiQA=;
 b=V+y5BLzIhE4L+beJLUz1j1MSpt8f29Ott+gNEnpojTT8DipfLqA9xqUQJQeDPTFhws
 urMNqBAg6m5slrgES6emTW2KSzNlIdZl9GUnugSBBXlAkrf8udJk1y+gQ+AbEEnMLhJK
 Z2KizJ1EV7AdETDNWtWkWqFZBFE9vUz2xCcgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741111419; x=1741716219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oFpL+DWs1QA06Nma/kv9+5AcK4XIsbTGH2G20VNGiQA=;
 b=tIVq7a1tQ977XEr0hYL4pP0Dq1/wCLdGIR2HcLzLsMXjS7VCT+KNaFPJEnikna3BvX
 QUnbt5gkqaI2lU+xU0/YqVqZhFIvPCmPCCTuDT/h3bRBnm0OYnI08toJoBAPAi022ByQ
 VvJEZbT0Tikx4nDyYZVSrgdb3zdngEIWk3L35K5TOrnHJ24cQ6X0zgqSwv6qmvKJAIM8
 ytDU03bJZZRniBraC5L4SoBcNQvrHUb95nZKtBf/zaM1zowRNdFwfQ43L0QpE1CjfTat
 yHswQhkMM0n4EmR+/y/Zhc94EbyqqO1LrU92fVHodMkY4Hnburx0yikUnPe1mZkFzRv3
 0ijw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiOOzxAqVaVMI8ouM7eMnoTlplkNMFLvw9qHs2HoD2tRIGbuPoYYAvBwTVpoh+PqfeH3NuSb0=@lists.denx.de
X-Gm-Message-State: AOJu0YwQYBRXCMUY9DFXKhN95PRQQwU47ctMLcuioXHSEZvYYTRJfXKy
 k4uwkxmJyglv1XPgPztMfgimVQqX7IF2Pqu9A5ncH55x03mxohN/RHt5FUEHhBQ=
X-Gm-Gg: ASbGncup+RNUt4LMEon3Ze/Ju0GtU6DGUoER6mrfVUhHGj/UPSfBjb/TKj5sFwZ+Eev
 tJIneMoErTwh0+E77R4Xxx7HjzKyUqyCLPAX3NH22Thm8LxxHxKulvajSUTSi5j5Y8BLugvBjOp
 Yk4oIMlPfU5mcRgdsL1R0Iux69wn8gan6/K16LuNpn4yQlk0mdq1dHmxMwTPUKDruadXlyuqZ2S
 LUqXupifP0csVPD5TqgoxrQ1zCaN3YYwrpXzqcjnQewpjwFgwzu1E3tMpYC3v+X7yk+sPDv+ZHk
 P8QIlElsXKmdQV5g9JBt0CiiwHIxEaDD+Y77gcLNI/Y=
X-Google-Smtp-Source: AGHT+IGV8sH+XUAuyxiUXMKup92TdkY0egI76zd7XsbN+4Mg3WzHwCKqySLQt/AKSQRzMlob9IwK3w==
X-Received: by 2002:a05:6902:3410:b0:e5e:1389:cb40 with SMTP id
 3f1490d57ef6-e611e1f82d1mr167790276.13.1741111418746; 
 Tue, 04 Mar 2025 10:03:38 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e611bd1865esm121814276.5.2025.03.04.10.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 10:03:38 -0800 (PST)
Date: Tue, 4 Mar 2025 12:03:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Udit Kumar <u-kumar1@ti.com>
Cc: j-humphreys@ti.com, u-boot@lists.denx.de, nm@ti.com, afd@ti.com,
 n-francis@ti.com, vigneshr@ti.com, m-chawdhry@ti.com,
 b-padhi@ti.com, sjg@chromium.org
Subject: Re: [PATCH] configs: j784s4-am69: Enable UFS
Message-ID: <20250304180335.GG2640854@bill-the-cat>
References: <20250217081712.1866257-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R3kP9b0KMmVhpBTS"
Content-Disposition: inline
In-Reply-To: <20250217081712.1866257-1-u-kumar1@ti.com>
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


--R3kP9b0KMmVhpBTS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 01:47:12PM +0530, Udit Kumar wrote:

> J784S4 EVM board has UFS flash, So enable UFS configs
>=20
> Cc: Neha Francis <n-francis@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> ---
> Bootlogs
> https://gist.github.com/uditkumarti/828f4a7731d952f92b627f7ac46da5dd
>=20
>  configs/am69_sk_a72_defconfig    | 5 +++++
>  configs/j784s4_evm_a72_defconfig | 4 ++++
>  2 files changed, 9 insertions(+)

Please rebase on top of current next, thanks.

--=20
Tom

--R3kP9b0KMmVhpBTS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfHQHAACgkQFHw5/5Y0
tyyengv+MMezfxaF3pbwBarCYoVQUPZDFvnwvYjHXZCGIuct2Kbk9qGLiePEXzqW
ZWvF/cT6jP6Wg3OS6uXlmlLQ4y27/S6xPt/2L5h2RRMU+oe7/gpMbTMxv9Mx/nKZ
haFu5xZ1SE4yGQ4MUa8IjxO2UJIi8Vo5GT3wrp6G7ICHNRCDyd9Pzo244c+d+vHl
MXbTtyWWGb4mGpUedYiMXXNgNwuuZdMkEOOkbYgV3Yx9uWIpgoTZshp6eQrlE+vR
uXsk5zbMlH2ZtVGu1wDvndMknlhHKLflxIZtxEYPnnQnP/G20NZd/Pyj6o77msrA
o1GhB8ZISQ550neGMWdPm2AF8E5FaKgJFQge6WWaK8KhfD6tNpw7hw8+tRPExycB
endt8kzv5lKO70bOtoCki7zUAoK1JfV0DzQvLcewuyevKRVPLOC/1apAZnTv/lqh
LlUgGlxa3qdFaThuUbU7EWuORaWicv4NXnAp+nBZJ6P0Mr7cCMfftfWaXOZwEg5Z
+HZWzzwN
=T/m5
-----END PGP SIGNATURE-----

--R3kP9b0KMmVhpBTS--
