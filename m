Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F541C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 20:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E69C980AE5;
	Wed, 29 Jan 2025 21:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bGZRGoRV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0C3880B9A; Wed, 29 Jan 2025 21:01:41 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE60807E0
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 21:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6ef047e9bso115653385a.1
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 12:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738180898; x=1738785698; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rDsBAwSeAdl7x92to7JxJIy+u1I9xSl2Z3TL74ze3/4=;
 b=bGZRGoRViD14ymqX7xqf71d1HVFfcfXUAmFYeJuT56qNvpj2x04S/a75n80eWbCCaV
 mqerpa8fOiAVHL+tFg/ivhPUCmtqCM6TcBkHTBvwFw+L0FkpdM3xVSmUYQ5+0TU5/Ytb
 LZGie18PPriCOHKIfW3uNUlROtMrtdMv/Hyxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738180898; x=1738785698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rDsBAwSeAdl7x92to7JxJIy+u1I9xSl2Z3TL74ze3/4=;
 b=AGSqnbbv1iuTHbzdKKkH+q0SO5qzV49erwKb/vbHfOzRIMpUlB3PhodKZRTxfeRT8P
 pmaoIuuB3OLckBnkvpDz2W/6nNaC6dHVKskNwpH9vhXmkc9SEqkZ9USTWZ8/F/OAvxiH
 vtMuxHctB8Dd1CVvFwhsQ4/wLvZhOqh0i5+I7XYiTz0rQQKnubBuQeZKclvGS6LT7Csj
 mRpGzgeTLpwweaKCdy6Tjr+QHFEW/YM3eKt0ndod6KCfAfiiXk1P5dRlksmhoJsJYSS/
 LnSH2wn8uJnYXttpjhEqRtC7E/sY+fQYKJqWo8otCFMkKeq05tQynAdMvl0hI1QYSai5
 Qfpw==
X-Gm-Message-State: AOJu0Yy3I7jBKFrNCcSDn/YoGRkUJ3Kqr/Nu+XO/DaVKVaeidRSFpPwX
 gWr1bVIdoHa+6lezy7j9hs6ZWVOrcx05TPMlNMeN/thJHdIV7oewIAi0rJtXLq8=
X-Gm-Gg: ASbGnct6r4IVUHSszFysuTJvWxLuxu11fdpSn1Uibj/v21xraWxdYVnCIA7aV0tspbi
 TT3EhzIB4VT7hQ7cLFLNfFwXsST+ppnIrO25+NJN6NhAkMVEsXcz7CBfTmQQTQ6slBCzxj2PdiQ
 Q9aDTN5TCsJjX9eCE1Xi3MvmzDJDMuto0eJIvGnxrXVgbo4ZPQhmfz9fqbFy65IE5b3qmmQcaow
 ercnsNaqxy1x5kRyHrTMvex+MM0x+eHEQjS1hge5g3oFHbjLxoeeD3epn4KdAvSbOHyd5yyNIIx
 gv4sNqWeeoR/280=
X-Google-Smtp-Source: AGHT+IGB11AqB6Q1kY0D61WYf7zb59xoQ0uhykqFYnC/ZP7FlVzI46a08H8dA2ntSVrJU8vqHZG05Q==
X-Received: by 2002:a05:620a:2995:b0:7b6:d312:c5c6 with SMTP id
 af79cd13be357-7c0097a0729mr92068285a.9.1738180898314; 
 Wed, 29 Jan 2025 12:01:38 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9aeedc68sm663748285a.74.2025.01.29.12.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2025 12:01:37 -0800 (PST)
Date: Wed, 29 Jan 2025 14:01:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Hironori KIKUCHI <kikuchan98@gmail.com>
Cc: u-boot@lists.denx.de, Jagan Teki <jagan@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Dominik Wernberger <dominik.wernberger@gmx.de>,
 Custom IDEAS <vanbaren@cideas.com>, Software Engineering <wd@denx.de>
Subject: Re: [PATCH 0/2] spi: soft_spi: Add support for SPI_3WIRE
Message-ID: <20250129200133.GA2165390@bill-the-cat>
References: <20250107092544.1798497-1-kikuchan98@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hSoB3axSJ6dVldwm"
Content-Disposition: inline
In-Reply-To: <20250107092544.1798497-1-kikuchan98@gmail.com>
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


--hSoB3axSJ6dVldwm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2025 at 06:25:38PM +0900, Hironori KIKUCHI wrote:

> Add support for SPI_3WIRE on soft_spi driver.
>=20
> Hironori KIKUCHI (2):
>   spi: spi-uclass: Fix dm_spi_claim_bus()
>   spi: soft_spi: Add support for SPI_3WIRE
>=20
>  drivers/spi/soft_spi.c   | 19 ++++++++++++++++---
>  drivers/spi/spi-uclass.c |  2 +-
>  2 files changed, 17 insertions(+), 4 deletions(-)

This unfortunately breaks the existing tests:
https://source.denx.de/u-boot/u-boot/-/jobs/1008400

--=20
Tom

--hSoB3axSJ6dVldwm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeaiRkACgkQFHw5/5Y0
tyyxeAwAs2menew900oSxsuwkZ/OHHI4ROMVlznzFhG9tEjBeP+bW7KUuaceM4in
oB9iRx0Wfv7AiwPX9P3/wmiPC5onWKetw/x3myCR9Hv7hdA9S8GVwCzMtQpexM3t
qYWAHdhXLbH2HATQLUo//5ItAAi+LeK9WIifWg67nRXc6N5uxr/9LIfd50I6yzEs
MY0mOi6Y8b91+hXN8q6RrT8NCfCFvdFN/lsYak0RaushDVwLVnT7ie4ehhofeqdN
DJvNXZvdgzetbnFXSXKxOY+yt0WwIxpPi6BiSSPL5rMHcwQfRF6QbZn5R+H/SM01
rMQn+3Ek4oS0OnYHBFFf5dYZsvNz99C1hfhvXPdieFRfil6B4zdyEd3QGeadGJ7J
zXVTO0dt+H7EiPqCLAo+khY+mbNQFY3S3T8izse3CSU+lOtKzNIXzfv0pcX2SQxS
GbrlrGws4HkENdUEqSGxjh6p1ys+s1NvGibup5cKrquHL8l8rQQBsajRkzNe2N2H
h13QNp7X
=nBL6
-----END PGP SIGNATURE-----

--hSoB3axSJ6dVldwm--
