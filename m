Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DC4CD5BCD
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 15:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B72CF86AE8;
	Tue, 19 Sep 2023 17:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="py4DaWod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB92786908; Tue, 19 Sep 2023 17:14:52 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18B8E86AC0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 17:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-59c07cf02ebso45356327b3.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695136488; x=1695741288; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZtIk3Uk9B56/RpFiAjl46usE6rTEVOV7uLqdq/tibMw=;
 b=py4DaWodWwaOTosjy+Zn4IhTEsx3bDh4/2LNmVrbzg6tRPWe9FI3NpmdMCHZH+v+qQ
 E2nYqMKTPDv7nX4LWjlWX/dqiAe32mRP2alFzv8cpG0EVzdG1bDf3JUfzN8c3c1EWTlf
 GMScAwwu8BeB5ZQBaEvpXlTMXPlAzuY4HX3nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695136488; x=1695741288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZtIk3Uk9B56/RpFiAjl46usE6rTEVOV7uLqdq/tibMw=;
 b=nmmtLas0e8TyKngx6l6vgsK5MRd7JhH1HQto8hT5Jo7RyRNJoRrbe6D1NVfqwzk0KG
 3y0L8MmZ3XLaQEP/VmLQTzyF+dAD1G0V6C1EPBDsPZwjOrc1LN2XHQ0xVMOF7k+rkN+w
 cNKif4yLqKzedlNgWDST/CkVA+MJd9HBB6osBtKzuVTVOhbAoba2dF+s1tsxbVD9L36I
 uqWQvql8jrknGHZZifXmDYhIlcKdCHJDAVNJnV6XRu89lHXVD7B+/WTGt/bCrl4RFBXf
 L/sx8W2L+k3zDiW8Gou073GXnALAtwfaNsFkfbGrYS+TvqVZcPx8DwwUnzSoVevyVVvH
 zBNQ==
X-Gm-Message-State: AOJu0Yy0Kbkd2CK/1TCbaUnR5EXVcdYzNb4qAvfkXBz6qnhTsRw4u9ha
 q+yLzeIVYRi1fe0XU+eVO82iqO5SxONjirQSkeQMIg==
X-Google-Smtp-Source: AGHT+IG7SfLZy8riv8LL2RFcqyKPjS0+guIyU2g1fIeR/UCXalFFu6LTiygh/PaAqTiKSz2zv466hQ==
X-Received: by 2002:a0d:dbc3:0:b0:58d:7ec3:16c4 with SMTP id
 d186-20020a0ddbc3000000b0058d7ec316c4mr12089471ywe.34.1695136488071; 
 Tue, 19 Sep 2023 08:14:48 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-715d-a992-91e3-9182.res6.spectrum.com.
 [2603:6081:7b00:6400:715d:a992:91e3:9182])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a81c20f000000b0057736c436f1sm3175877ywc.141.2023.09.19.08.14.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 08:14:47 -0700 (PDT)
Date: Tue, 19 Sep 2023 11:14:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Neha Francis <n-francis@ti.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Marcel Ziswiler <marcel@ziswiler.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: Re: [PATCH 2/2] arm: dts: k3-am625: Sync with kernel v6.6-rc1
Message-ID: <20230919151445.GJ305624@bill-the-cat>
References: <20230911140256.945074-1-nm@ti.com>
 <20230911140256.945074-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kxsxzsFVVOv6Ino+"
Content-Disposition: inline
In-Reply-To: <20230911140256.945074-3-nm@ti.com>
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


--kxsxzsFVVOv6Ino+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 09:02:56AM -0500, Nishanth Menon wrote:

> Sync device tree with v6.6-rc1
>=20
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Applied to u-boot/next, thanks!

--=20
Tom

--kxsxzsFVVOv6Ino+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUJuuUACgkQFHw5/5Y0
tywIbgv/Uulxz9A3U0LcDqjP5PMkokYNuEqoO5OhU4Mak/Ew3FfhpS7gi7FetROC
XyWJ4OZTNNMoXxOQGAhLYTfJf2eoHf/kDjjZ0u3vKlUT6eBAeJsKqpYAB9T4p41c
cv55lYfYYzW9QQ5gC3dOHRaAOGF7uUPaDeRmBNOO5qkPpN9sE8QJAyS84xZor1LV
DffPrQGhAFgHbGbCcLBgQJbQEGkC+9gdPX1B/dQnsS7+jX/BZHzPl1FF4WGA4mEu
mhcV/bDem3qO/+jM75q3JLHtxCPHkUxH/qsNKOFpXGdXOwRCNQ0aznePjk9lzdOw
aRk/lggKdlusCMVQYDn031DyxmLDwZYXy35lvLpn0mQkQgGKRq1QdTQlQiqb6EZo
AdJNNxT8kv61vEZ5kPjwKNF32Qj9blbY9gv/uWfZt+Zi+ohlCaVeJCyKN3D6a/c1
RAvOccXbZJlypMpuE6nvDg2hsAA6a/8eOK05Lbnfy/u+RPkbM0P8CNjSuKE8qOIP
FbLKk8N5
=sUHA
-----END PGP SIGNATURE-----

--kxsxzsFVVOv6Ino+--
