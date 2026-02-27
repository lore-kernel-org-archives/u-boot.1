Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DABFEFB56
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 14:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5EB783E76;
	Fri, 27 Feb 2026 15:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XSmOvfCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E1FB83E81; Fri, 27 Feb 2026 15:35:17 +0100 (CET)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B48C83CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 15:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7d596ab0917so364923a34.1
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 06:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772202913; x=1772807713; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1kh3+QB1IwVd/vmT30GKPPdea7m0KkGBAwps3orZhKI=;
 b=XSmOvfCq46vL4k08C7tUn0I6TLvns0J0kL7Be+/udonkCqCDBC35uL9Ju7lqqNQIAQ
 Di8DOcE37JKiVeLHXzWTxuJH2tkQUjMO+c3bf7qhecLMX9Yi2RTyI5H8xyzcX4kJWN6x
 Wibh6MpOYH6eykARFKgmxcyzeysB2Wok46KBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772202913; x=1772807713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1kh3+QB1IwVd/vmT30GKPPdea7m0KkGBAwps3orZhKI=;
 b=CObZr0aGDHqBJLeGki6FbIjPdlocJpXPtDLghkqv1+HJIBRVX8ZprMs3L8iSM7ZBoj
 aqMMIyTflTYYDVWJ2A9iisvVQAGQjNIDif7QjIkM/RZ+Lu8+v6wQWZoXTTJb617aZrk7
 BYBF6kxAOnmIOzc5gmg6AcSMdUVRt1TTSgo3n091qE7mDjFhY89iJJXVuII9U4wfo8rH
 WMjdXx3U6ub4LUi2AAS8iQsN5gdWx5g5Jfo8Q0nS38F0OqJt6OE57mOWz4JAUVixyPUf
 MOQ/yTxeJZZbN+ZMPG1viUkh/KLlbrQc7hILt+cWqH0QobazXYDquWoRdmWHhtvbxtRc
 yjyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMI2SwkDdmbH4AO2JIgDdjzuLcIxYd9okdPaWNGWNWw/Na9PMJzs+W/4p81Br11Eww7/MSa5c=@lists.denx.de
X-Gm-Message-State: AOJu0YwRQtqM4NzGdA8STYymTMios7/iQ3sOozrYqq1dCFt03lOWkdtQ
 jq8K/BVY27dI0sCTrl5yvT5ETUbBT5fKTr9eoAbnTRCPSpNZWshq07JUD+ViXF72vMg=
X-Gm-Gg: ATEYQzyARGrvnhZV9BcXiMZL/EID4jwCyZGuXMGmcwcdia12kYbp7Zc9SBO3N2Nu1bn
 dO099zmN/LPdEm/ONi411n9B5M44d1Ib31g9vIjci0BCVPK9rCAkDFdUfSgMm3F6b15BV+u7SK3
 TB5wqijRFYfIuaSBtLo3xZip2kI8Qr+xRBCGP27zuAeWMf+Xh8zuF49BYWOMiTG1r70Uk4uO/tt
 AB2U4OhrA/TiEmjaDzsCXMhSKO+T1b1XG+fCjGEiEl/EKJB1qmGog0nc3zTFZEv+fZeEF8EOtru
 bjDZtV2qFpdhHVIq+mysU3F9GBEE8PvCAS7hXrHQdyBiTCGsa4KWHz7AjnUUYkNp2AKE7bs8Xvs
 UOuDeAaSGQ5hyN01tzcc1C6y4K1IRBC//4v3TZWT/1LfCtxXtODDMIJQIvAFTPXzTzWjzmJ2QRF
 LMhUFHkgv9JhQs2HA5lvsQNCB9I6cbMT9XFDnQ/Eg3q4mgmfz9bnSfNKQLjcyUuYBWGlcwM882P
 fRgc52RnWWs02rddnmyEBseGqi6RNkMjlqazRJTeyjHG2K9N8s=
X-Received: by 2002:a05:6830:210b:b0:7cf:dc6a:b70 with SMTP id
 46e09a7af769-7d591ec6b8emr1837135a34.13.1772202912693; 
 Fri, 27 Feb 2026 06:35:12 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58666f30esm4316658a34.26.2026.02.27.06.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 06:35:12 -0800 (PST)
Date: Fri, 27 Feb 2026 08:35:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vigneshr@ti.com, anshuld@ti.com, d-gole@ti.com, n-francis@ti.com,
 bb@ti.com, jm@ti.com, s-k6@ti.com, afd@ti.com, u-kumar1@ti.com,
 marek.vasut+renesas@mailbox.org, a-dutta@ti.com,
 neil.armstrong@linaro.org, semen.protsenko@linaro.org,
 peng.fan@nxp.com, george.mccollister@konsulko.com,
 u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH 0/6] 64-bit PCIe for AM64, AM69, J7200, J722S and J784S4
Message-ID: <20260227143509.GQ1593142@bill-the-cat>
References: <20260227115841.333073-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="QC8go0zclq9MYqPv"
Content-Disposition: inline
In-Reply-To: <20260227115841.333073-1-s-vadapalli@ti.com>
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


--QC8go0zclq9MYqPv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 05:28:28PM +0530, Siddharth Vadapalli wrote:
> Hello,
>=20
> This series is based on commit
> 437ea9f8be5 Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab
> of the master branch of U-Boot.
>=20
> Since Linux device-tree has switched to 64-bit Address space for the
> PCIe Controllers on TI SoCs, currently, U-Boot needs to support the
> same. This series adds support for 64-bit addressing for PCIe along with
> enabling Root-Complex mode of operation for AM69 and J784S4 SoCs.

At what tag did the device trees change? Thanks.

--=20
Tom

--QC8go0zclq9MYqPv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaGrlQAKCRAr4qD1Cr/k
Cp0CAQDuirDRmJ2wii4TfxdN3RPZbXoa0gpItEieztZ8dcT8DAEArQaWVW4bdq/1
jvBqWNGpz4BkAHvmzQYzvkYZeAZlxg4=
=c1qn
-----END PGP SIGNATURE-----

--QC8go0zclq9MYqPv--
