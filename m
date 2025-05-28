Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A914C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 00:20:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADB9C838D5;
	Wed, 28 May 2025 02:20:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="olSwPu84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84EA8838D7; Wed, 28 May 2025 02:20:02 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89358312E
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 02:19:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2d4e91512b4so1942331fac.1
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 17:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748391598; x=1748996398; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PT/6d7echEuHywiGJVtveElNaCHNkUn5P5YSGeXXVEQ=;
 b=olSwPu84OkTMFNw3LE4zafUwmJFxIEOrW7rCRXi4bO7Nox7lEktPa3BmjML4MEaepa
 iINkxmrwJJNLKGCwgB5CDC7TKEalWcnjU+4u6VNrMxW8VMZEsYt1yfSBRIfPTEwNoeOX
 8H5y+aK103M0MyQ1JJOOFip7ePkkADVSo1Sg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748391598; x=1748996398;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PT/6d7echEuHywiGJVtveElNaCHNkUn5P5YSGeXXVEQ=;
 b=UYpBJQfZIak2r862RXaq0Ub4fbHWLagqmId7n2YEYDS4DSNj7tsavB9bbvtWZ/Ezoo
 Ca2CP0AwsCJJ9sSS0AymAVK8OUivYQrVdzOvrskk5QGEYbreEUARbVvNWa8z5usyhZjD
 1t6QXobTZS6xcmdEvj29nPawmimWEk01gmCQN06MOjvZ6nieo/7et8HmlpH0NzBi5RkH
 ku631sFdO8U5Wo+YZncrNXH5aajhpPT4Q/mJRZZtSxplsiAXjulk340wsgx1BtxehbzZ
 kJqWJ949pFXRvoZw9qp5v6OrQzSC+6rrKySFNvtCVwfTS967UZTE/orC46PYYmuwrQf1
 4lqA==
X-Gm-Message-State: AOJu0Yz9RN30fvGr46N13z7axhZnmncBsDIjA8FaGwWYXHeoAqRozgy4
 XM2xrHSojQcvNOAnogxGGwH5YRf52hQHQVzlXXEEZ1ucj2qKH3+FTGL6PG9aWeoiUiM=
X-Gm-Gg: ASbGncuFmBskpYBJmFFRdUVt+P2neQpzjKfyiQ9BTWnZ0Phy1wMRLC6XPVRw81KoWur
 lvtsC1pFxmPb1IV6F42aeYwwJkX5+y1kXMLARscWljtKQGnCyevPRycPCO29LArWRRar8bUFIo/
 rxkw09c6SLRMcLW/w/mINYJNWwnzyrHpl65byePTk5YNjDhU32ob/uREfLc4Dgbz+uc5dtnSEZl
 j8rOJ0tDFzDGZj1wUpX3b+Y4o5pIFlTFovmADOaJzHLk5AwTGW8qE7V2aRwD5stmcKMxEaoSw2A
 RI2mv2vxxWasAk02SwiWolqy9Ig/y3mM1RuRSI+9P2I+sGCpNTYsEOIWGaUjVlJcLC+D8IuAahX
 auu7QxuZYU+OgxF2yd5W7Ikc=
X-Google-Smtp-Source: AGHT+IHIHuPt57pTRuSKBweZnT00wH9HXIUY8KaERaOXn7EYPJWgTFqx7uvNa/aAjAW/ciZJOxr9Og==
X-Received: by 2002:a05:6870:30d:b0:2c1:51f7:e648 with SMTP id
 586e51a60fabf-2e8620f133dmr9124081fac.35.1748391598340; 
 Tue, 27 May 2025 17:19:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e8e16bdee5sm18921fac.1.2025.05.27.17.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 17:19:57 -0700 (PDT)
Date: Tue, 27 May 2025 18:19:54 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH] makefile: fix Clang link error when
 RSA_PUBLIC_KEY_PARSER is selected
Message-ID: <20250528001954.GO100073@bill-the-cat>
References: <20250527210508.1488509-1-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eYy5ZE/eJHS5zVMC"
Content-Disposition: inline
In-Reply-To: <20250527210508.1488509-1-raymond.mao@linaro.org>
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


--eYy5ZE/eJHS5zVMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 02:05:05PM -0700, Raymond Mao wrote:

> MbedTLS bignum module needs '__udivti3' which is a 128-bit division
> function provided by the compiler runtime, typically libgcc for GCC or
> clang_rt.builtins for Clang.
> Thus 'clang_rt.builtins' library is required when building using Clang.
>=20
> Fixes: 13de8483388c ("mbedtls: add mbedtls into the build system")
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--eYy5ZE/eJHS5zVMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg2VqYACgkQFHw5/5Y0
tyxZsAv8DrEaERthmsJ2HfN9tIH6dTHOa5hnUgh50t4me7MP9HQHtCCA+Jaa9rsw
u3xWzfdl/e3kJmA3nL15dPrhSfJFzKX/HDP4DJ3ew5e4GmtrDFUAkSRwPvpHKfjU
oB0lnrZIKnISE3pnduWkaOt7jK6fz7GpnQNa9gRDKsZ/7LBxjCXHpyH0FIunwx8R
v97tEmBs+sGmDcCHUa1P6fwTJ9jtATKVGvtyQB1K3QfFV0DxCOE5ncGMCd+E7Y4H
TsXZEN4ahMrOa+bD/XPFMpPDVZXpfCroTPQaALDcSsw/X0R1MGuVCVm+t9ttCUzM
OqWnP3QJsQUkIj0Xw6bq1wDmCc0tTxQIAmyhvN1fweVY+4k5CAThOYK0Xm9sFroq
bTUPtJp5cFnjbSUM81KYc7LV3fztd1kAH+74F3VjfiNsmH5m7gwIrcNR3XzOUq+Y
g8uGWazq9IDi+CjP7Uk0ZfKoyqzrJjJc5q7lLqvIXVqYWzZQJmzNvooK4Wuom82Q
wxRyYd3x
=uzWh
-----END PGP SIGNATURE-----

--eYy5ZE/eJHS5zVMC--
