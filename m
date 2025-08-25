Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3FDC8303F
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 22:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53FFC828A2;
	Tue, 26 Aug 2025 00:55:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pPFkohid";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7549C82DA1; Tue, 26 Aug 2025 00:55:28 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54FDE80819
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 00:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-30cce5cb708so3365289fac.0
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756162525; x=1756767325; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3QbV/le55I/GUXtQwxHGy0BOqnsjtiASSyawbruKIpw=;
 b=pPFkohidLc8rsIAUEpaYtlCPoSApVWayjqIvkZtpfhyd3vexvDJOW6NTr5WM0Yp9ER
 9eJm0xU7MyS9OgZVUPfF/0wlXjhhnchpdc5DdhJ4W5JxrPMYpN8cydbHbonWn3kbHMvI
 Hd3EgEJNairwkPI1leyi6mdMnZd12peS4rLoc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756162525; x=1756767325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3QbV/le55I/GUXtQwxHGy0BOqnsjtiASSyawbruKIpw=;
 b=VEayWkDazP9mHVXdeLkF2/iQwukEW2RX52t0DW/yd1I4DlbLrAJs1C9vphwqo9tDsr
 E9+fDKWKMwoNVVMxHKTtx+VXMEjODJNxXuqzbiDQA0lAdadeTeLq4tq7VUposjfiDquH
 HaL6k+RZRZFvF6KmOE1rmvnhRDqWPn33n8L8J9wJseuaZpF8v30z/Qr2Yt1BWrQ+JZAv
 X/aJOXdPgXrS+ALpBsvHKd9T8Kk6NteQHYwx6/XsiAhes9X2/lduT4jMVbZN7Cyvpkfo
 G4PmW1rOCsLr5cG8HAemP1gB/h8aA2c1yd30eZ5Sn8kGBkZ0JU4o1YZ74ip0e3lteP2w
 JjyA==
X-Gm-Message-State: AOJu0Yyoeio6vuOVSjsGg8Ne3dT4WUuLwhYzPganMmXVIMbnl7c48GcV
 QPERJ5pIGPBVxY6NGIsjEVsCaAsj3qQtF+DLSeXWmKRCpMl/Q6Cu+aLsuQy0/g5HK2Y=
X-Gm-Gg: ASbGncuzCbFNNNonKq9ifaRHMQm6oKArqj4spp7HrGpnSso2bPBvNqrVywjc0jQbwv+
 lmb2FYXJXpdNg9xIy5WHPZS0/V7sENQfiG5RF+rt5xNCx73fOkFrwXpf1Go0e/K+p/Ev1OlTUGJ
 hV6yVRYMOnecasY7oppsB2vFYgMhppA9dhsvdHQvBb+iL0Q0ObK9WLyOfIhbpMd7V8Ehr/M3+9H
 iSSI8q7aN9Ls4Z29oynrUHlFi19Utmce6Es7kOxNqAFFMOJvzLfgqbhrsCcRc1bev6MuATnVTNd
 Cn6otUed6yV8MrcQ6zBGmpS2My1G9ImRPXzDsKrmTj2yw87VQ25Ek0FN/JLI/6Ycj+5YSP62pv6
 wwM44bNoGU6jnD/GwiWzYh3R0/If3IEDqX5yK45a22u3p0zyMzdSroCpa
X-Google-Smtp-Source: AGHT+IHu9pyUI9h3VtQfmAX+OPRH1fCrPlPlXXa9EGjarqq5oakLoUp8tt0kpuvZleMIn2ZziaPkOg==
X-Received: by 2002:a05:6870:6124:b0:2ff:a860:3402 with SMTP id
 586e51a60fabf-314dcbb854amr6158221fac.12.1756162525043; 
 Mon, 25 Aug 2025 15:55:25 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e11af87sm2006402a34.0.2025.08.25.15.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:55:23 -0700 (PDT)
Date: Mon, 25 Aug 2025 16:55:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
Subject: Re: [PATCH 1/7] doc: make pdfdocs: Specify texlive-xetex as a
 prerequisite
Message-ID: <20250825225521.GX124814@bill-the-cat>
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-2-adrianocarvalho.pt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nVLBVTtaP/tJ3O2X"
Content-Disposition: inline
In-Reply-To: <20250825224459.682403-2-adrianocarvalho.pt@gmail.com>
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


--nVLBVTtaP/tJ3O2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:44:44PM +0100, Adriano Carvalho wrote:
> If I don't apt install texlive-xetex, this is what I get with docker.io/t=
rini/u-boot-gitlab-ci-runner:jammy-20250714-25Jul2025:
>=20
> uboot@35c89b9ab70e:~/u-boot$ make pdfdocs
>   HOSTCC  scripts/basic/fixdep
> doc/Makefile:89: The 'xelatex' command was not found. Make sure you have =
it installed and in PATH to produce PDF output.
>   SKIP    Sphinx pdfdocs target.
>=20
> NOTE: This won't completely fix the pdfdocs target. See next commit(s).
>=20
> Signed-off-by: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
> ---
>  doc/build/documentation.rst | 2 ++
>  1 file changed, 2 insertions(+)

Please follow-up with a patch to tools/docker/Dockerfile so that we can
add pdfdocs to CI later, thanks.

--=20
Tom

--nVLBVTtaP/tJ3O2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaKzp1gAKCRAr4qD1Cr/k
Cj5ZAQDW9TO3PI7DNEZGAdAhLHXJDP0RlamSV9wZ3x8tZ8X2DQEAjmTjGLWxOcrL
2/ttei9FcL2Q4TGMq9DuMzyw70SEjAc=
=aqme
-----END PGP SIGNATURE-----

--nVLBVTtaP/tJ3O2X--
