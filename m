Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 599C0E7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8FD78034E;
	Wed, 11 Dec 2024 16:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="W0qsLssZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45F1080377; Wed, 11 Dec 2024 16:54:33 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DEB48034E
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-467631f3ae3so22619611cf.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733932469; x=1734537269; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pHxwBP/pxtDfSIfdqslget5SziwHLcq6QG0sU/QXFVE=;
 b=W0qsLssZJLa2YdvkbU8p3n0OjA8IGRGF4lNV46BJGe7typDJguNEFpOKlGmaZE4/Zl
 xMzSFsYe6madA85xdlQfSA/nm8Hx3CJ0F7Nno0wjrCB1r6LrQnIFQ04RLhQVoGuufeQ6
 YsWMJ36vstIVfQ6CU5DiMgZ4jMofRja9v1VEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932469; x=1734537269;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHxwBP/pxtDfSIfdqslget5SziwHLcq6QG0sU/QXFVE=;
 b=myb4RA1iCRnFzan0J1OqlLynTCg0ohqOKAQ5uJMFHZu6ORNNNMZoMkaLQJA5rHc6yg
 SHWv3eXsasBkpDX2PgVAT6GPSJ6tBUJrcA5v7yvs3LvUZ20UVegMFUBiYsMcdpJpRrfZ
 gtH3FiQ/KtF7w/1DdA/TsPSect80rp+K+zRfVqnRwwoOCffn37FbCjXUnpOG6iHxsvR3
 16p304i2VUl+RtdCzt0Rl44b5L4QSQx2qboXWpszTDbxO7JM6uUO51c+oBmV3a5E3EyP
 YK547m67BS0RcpaBpV3V3Ue3Oth7ehFJowoIhp4+aubUc9Sz35DgAHFURG9REKhGJ6rQ
 6LKQ==
X-Gm-Message-State: AOJu0YxqVgb+t+3beU7ve6zXDrtHwFwU8Zpb2XL8D9AZNvztNhb35UTF
 KX/yh4v+15DJHqJvjUFC7UtbhNWXILtPFAi1fOA2KDWI5Kew368vOSiAqwlDL6k=
X-Gm-Gg: ASbGncuNnnEMsP5j+AugGE/64eDnKK1X6PT7o00z9X2ipFCrEiFN1IswD0g/3jMwOGb
 QrYWbpQHjh7IWQjrYrYojMNjEjkXQgPvhDmqpQJJL3Hwl8clNxFqHLUi4BdxS6eUP1Y7xgEM31U
 KyqEe2s20hl4YiBW6sGjnBrsOCwPE6ri72wBNuvgw8mFhy0qIk30NwZkyERPNYC3Udh5Ra6pw4x
 Gcvkief93+JrbO1EwirVPq0ShhGk/27gwdwH547GCE5vW1keXUBuQ==
X-Google-Smtp-Source: AGHT+IHwrSETUJKQfr5jrNmtVysStFiMbwKfprGGJ2D/Rmyb9B5znBXuSGrN6KYqvv/74yG8vDEPJQ==
X-Received: by 2002:ac8:580c:0:b0:467:7725:8b69 with SMTP id
 d75a77b69052e-467953f4303mr4376431cf.40.1733932469035; 
 Wed, 11 Dec 2024 07:54:29 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4677a1b963fsm17970741cf.10.2024.12.11.07.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 07:54:28 -0800 (PST)
Date: Wed, 11 Dec 2024 09:54:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] test/py: Always use the current dir as the source tree
Message-ID: <20241211155425.GF2457179@bill-the-cat>
References: <20241211131858.520639-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LjIyN0FOsbxzZI2w"
Content-Disposition: inline
In-Reply-To: <20241211131858.520639-1-sjg@chromium.org>
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


--LjIyN0FOsbxzZI2w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 06:18:58AM -0700, Simon Glass wrote:

> The logic in get_details() retrieves the default source directory from
> the Labgrid settings. This is convenient for interactive use, since it
> allows pytests to be run from any directory and still find the source
> tree.
>=20
> However, it is not actually correct.
>=20
> Gitlab sets the current directory to the source tree and expects that to
> be used. At present it is ignored. The result is that Gitlab builds
> whatever happens to be in the default source directory, ignoring the
> tree it is supposed to be building.
>=20
> Fix this by using the directory of the source tree, always. This is
> obtained by looking at the grandparent of the conftest.py file.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reported-by: Tom Rini <trini@konsulko.com>
> Fixes: bf89a8f1fc2 ("test: Introduce the concept of a role")

Ah good, thanks.

Tested-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--LjIyN0FOsbxzZI2w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdZtaoACgkQFHw5/5Y0
tyzRfAwAqMgSx8BmwCqbTsMDVvjdLqUN23JIimFTuF6pqc263aBw2d/GgE8W42/L
yX1q9IlV1Vwd/0lvX5UnfbtuKpV2L5J7NBaJb/61BSzz30O///9hyFHK0lTLrswA
vkz0/pwR68/6SLY5j7Uo5QEyQGpBOFLfMMGt0rJIlUyaIxI+ADxpx0yEHYjPliB4
YgqJivp7ZXWLtNoWNDP/XX0AGXG71yAe1BWv1G7+I6t5Waw7h6ZFiDpMXCwdfOaA
qv4FL29qtP7Dtpcajo75pR3vmzFGIYWMfcZE5FzqJrLCOj7iXfB4/EIilbtbG1Up
g7RFyhgGJ2cgGwU6Jo/v8N6eIgun5bY8AdNNU7AY6PlH/RXb77WeqNekwi5pTltT
4FNaAz6n/QRX65/wGMTfYfmxDvPW7PPBanoiCSNRp2qq+C5ZGv+Taqpa6P0gSIkQ
2QcAoF7jpRq4HkUn3rA3lvWFd9cZQgCgwp6l/V9+CIrbsjtGcSIIhpRTvfvL+sj6
p9GNnLVw
=lJXa
-----END PGP SIGNATURE-----

--LjIyN0FOsbxzZI2w--
