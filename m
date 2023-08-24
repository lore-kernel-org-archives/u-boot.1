Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F16C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 15:14:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3C3786776;
	Thu, 24 Aug 2023 17:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S3Igrsa6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3100A86776; Thu, 24 Aug 2023 17:14:41 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7495586751
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 17:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d77f869dccfso842424276.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 08:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692890077; x=1693494877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=puBGZAYIh4IElRXV2wBQGpKXC4zvg16Mh5aV3dMBTCU=;
 b=S3Igrsa6hDINmKKu6+hyPI84qrx27dBTh1o8wTWp2txlhZcGGpOR9GvECzy36+fvfl
 ePRE6acGWBEAsCqEkerkmMD5sicuBpcFcqylJRlYYN46eNMB4w+zOSzDJgVBl6jHHq5k
 0x9Xk9Rjuco4gxDT+VRzFYmmmzBDvyujPzFXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692890077; x=1693494877;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=puBGZAYIh4IElRXV2wBQGpKXC4zvg16Mh5aV3dMBTCU=;
 b=RMGwQEdhXgpL/ZvoDe9ETfYopPwU5GDLpIS6SReucEIhFODpWPekcAlv450nsN5FrL
 lu9z3Qt1HCZZzoZG/LZiQJAloN0zk4lZB+0s+EXgEwkuvxcfnJZEMYLimOmpDpq7DYIm
 ut4Ycv0UTvZ0jFlYAH5Pe9YpV0u4x+sPMFU8zFzkzsTFREj714VP0xAlZepFAEF8A4OR
 J1icravjKwRKTvpdJ0ye9vzGKvRb2GmNV5xrV7sokP8hyMqDTtL4x75i3Cvx3HjZJ9uZ
 meWmUJM1JV06Fpr4f1PfF6CizkrCTqglrmBlN9aQV2iSEZL9xsPnK2WSVn8BAfxZLoRe
 pbAw==
X-Gm-Message-State: AOJu0YzrI172MS/8hSSz9SXCWKOtaaB4mJD3AYX91nNnOQwlKKI2yn3E
 aAQ00S9TtqXuyawvjJUnfEwjvA==
X-Google-Smtp-Source: AGHT+IGarZhgeUe98K5yeL0BOwJ4KpGuobOBLrm8j5hZZ5RvnZ7rJPRcyNzicuFejjYZm4HaLoPkLQ==
X-Received: by 2002:a25:aad3:0:b0:d71:ed11:d9f5 with SMTP id
 t77-20020a25aad3000000b00d71ed11d9f5mr16883200ybi.57.1692890077238; 
 Thu, 24 Aug 2023 08:14:37 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a25f503000000b00d77bd2fe760sm866475ybe.27.2023.08.24.08.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 08:14:36 -0700 (PDT)
Date: Thu, 24 Aug 2023 11:14:34 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Simon Glass <sjg@google.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH V5 11/17] arm: mach-k3: am625_init: Convert
 rtc_erratumi2327_init to static
Message-ID: <20230824151434.GX3953269@bill-the-cat>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-12-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uApkwhh3SsXqEO68"
Content-Disposition: inline
In-Reply-To: <20230824031101.3460411-12-nm@ti.com>
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


--uApkwhh3SsXqEO68
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:10:55PM -0500, Nishanth Menon wrote:

> The erratum is called locally, make it static, drop the #ifdeffery since
> it will only be called in R5 build and mark it potentially unused to
> stop compiler screaming at us.
>=20
> While at this, drop the redundant return for a void function.
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--uApkwhh3SsXqEO68
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnc9oACgkQFHw5/5Y0
tyw59Qv/Qgsxg2MTWfaxMRuFLWY1C1LGdxb3Bex0wPuKrwsZ6LF7VOCyqWw3ESt1
Oa2qjVgQTGY0InyKKB9+WUoloWCYL2xYcl+3MqYHUruBnoRAZTsO6tlnG2DyAthE
cor2iaQusRLDODSr4AgsO/qFgL0UJQE9mXFYQ4yESuOZ4RhwfYhQI6JWtUfalZQH
Bx8xmJpqn24Qt6gOVaj0zWFvQW1LN0c12PSHAwpoXn8eQTTPZ/3hwTkvduMvOlir
2hT8Cca/mR24TtPaLndD9msRrsc8KlE0hCQwir8oPI3q2xLxoQKnIo6ugTzCHU4v
xFzxd84Q5tI2xpb6ncp2N4kc2O8m6KT0Cpne9ZPoynF8HAE40vNZtFMojZn5ajUA
ZNGVM/sdiSx6NlJJxkULEMUG9yjqw5Uhgd21aPgM59/xzouR2AFwjyrFX1m/iYp8
8g86tOGYalP7Oh5d9wM8FZPoBs+jICyU93YyxFQYhkHrdJ0xyAtZtEh2u9fkXtyx
+ZxAf5B6
=8UNq
-----END PGP SIGNATURE-----

--uApkwhh3SsXqEO68--
