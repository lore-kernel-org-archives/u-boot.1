Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A777D1118A
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 17:21:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A9C839AC;
	Wed, 26 Nov 2025 18:21:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aGS/bj49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 194BA839C6; Wed, 26 Nov 2025 18:21:39 +0100 (CET)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69CFD83959
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 18:21:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-3e8f418e051so4057780fac.3
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764177695; x=1764782495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x1l4nQK1+z+7SbaKDFuolLAaZrCBnG81U3+cnw7jfVA=;
 b=aGS/bj49ll3fbVsPGO0Qwsm7xWR15RIofVzCyjCzlGy5O/zE1RpP3iSOR8PSjQ7rsa
 Wh7dyrp0NfPxkWxkSBjxEsNk6bT/oJ3FMv4ngJ/5h3ecBowCWO4NovqwA8zB1GgJs9SD
 sHRlefHCZtnVjTWt5vC7GhvSBfXyg2A0wnkKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764177695; x=1764782495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x1l4nQK1+z+7SbaKDFuolLAaZrCBnG81U3+cnw7jfVA=;
 b=gRhzkDJ1Me39uLumaKvRo5wmd/FmYiAlhxx+7PYBgV9LgHCFohDFeFD8rY04R1cKz8
 vuie+i8Gqm4LJPntQ/TY1wD8aZQISSHAHVi0lMWUCttz2lfzA7geVK3Vz6xteK6jhjWk
 nD6vovbAK/AgWzt4bC+KXr3qpLiqFvaqaecpZLxAfGyzJw7pPoL9Ugd3Z/yjqdUhgfUm
 HShdypgP6JQ+msb5DOmfkf0miXsBg45tuzrzcjIK+AEmtoMm1hUEuFwPyN2HPZukqPRA
 pToOu/rBmGQncMAdMaYQ6PIyioFp9bHLkUbJ3+IWvRP4Hh55SVaQKjZMc2HIRq/4fhQa
 mnIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbIfWymI9P0XpRD27TiGhgfb/590zRAGYOu0DVKpRDNmdhEpck1S/UrYXhlaGn5qc2YWTIO/w=@lists.denx.de
X-Gm-Message-State: AOJu0YzU7zgpK4Ac5MqpwKBO6Olam32Utc2E+djF378EqebxaRsqq2K2
 iWmjTjaxhBVZl9FljNcGwbN/hKA3KJL4rsONXlbcLQX6ROurm6fBvbTDljUNqedJFLY=
X-Gm-Gg: ASbGncveBza9hTVB9fzt/9xxhHJsCKysRAugfXnhVSimO7nHwzrAM+nr0bZ2sNmoqIx
 Jnop2+8JBEo5i2wq9y9qG7mif7LDrK+Eg3qOENOQi2Jm894PwbNLqC5agVDgeqLx/yNW8P22V3C
 9WDBjnAAtu9KUYlKwdIM46Q17hn2JOsSyLgR7P5ngepGMjlcdkykURgEa4RMhmjBA56VMymYUza
 Xn/zoiiIrP7iwrpWujd61RN2zDo2Y6P7z5IRkqlxkHiVUzWAD3N3U6Lx0WWQI6LsFMeCwwFf1av
 AQV9x73A+HfgSi06ptE1SeOJXgJ3DSB7eQ+FedBTqnMotR/BL1UFEvjSEAfYb92v9INqVuy+Yiy
 i6GOTLGETTbzbE0sBDkTeLRG+0UT9o+RB02r62OR3lufFWD/S7tDn6PSsHz+wWs5At+4U11xATp
 mQea/9P43oroudDVK/LFIzu8KmK3hK1R0dGmNlIDuLo9I4iDn0gA==
X-Google-Smtp-Source: AGHT+IF/r7tu3cR5w6aP69yGINw32MI/4ijJPqGOUpydcRuPcCrT9EngzvanbJueSosHvlyeXcjeGQ==
X-Received: by 2002:a05:6870:e310:b0:3e7:fa5f:7250 with SMTP id
 586e51a60fabf-3ecbe4f8915mr8101909fac.33.1764177695115; 
 Wed, 26 Nov 2025 09:21:35 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ec9c2c9bdesm9191023fac.4.2025.11.26.09.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 09:21:34 -0800 (PST)
Date: Wed, 26 Nov 2025 11:21:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] docker: Use GitHub-mirrored TF-A repository to avoid
 clone failures
Message-ID: <20251126172132.GT2125796@bill-the-cat>
References: <20251110133758.1644822-1-bmeng.cn@gmail.com>
 <20251126154139.GA3759421@bill-the-cat>
 <7e694c29-babc-4ddb-9de2-4cfc02844545@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="F7S+oQm0qlNAViPn"
Content-Disposition: inline
In-Reply-To: <7e694c29-babc-4ddb-9de2-4cfc02844545@linaro.org>
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


--F7S+oQm0qlNAViPn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 06:09:55PM +0100, Jerome Forissier wrote:
>=20
>=20
> On 11/26/25 16:41, Tom Rini wrote:
> > On Mon, Nov 10, 2025 at 09:37:58PM +0800, Bin Meng wrote:
> >=20
> >> GitHub Actions consistently fails to clone the upstream TF-A repo,
> >> returning the error: "The requested URL returned error: 403".
> >>
> >> To improve compatibility in building the docker image with GitHub
> >> Actions, switch to the GitHub-mirrored TF-A repository instead.
> >>
> >> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> >> ---
> >>
> >>  tools/docker/Dockerfile | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> >> index d2384219c06..201a1cdbac1 100644
> >> --- a/tools/docker/Dockerfile
> >> +++ b/tools/docker/Dockerfile
> >> @@ -243,7 +243,7 @@ RUN git clone --depth=3D1 https://github.com/OP-TE=
E/optee_os.git /tmp/optee_os \
> >> =20
> >>  # Build fiptool, bl1 and fip for fvp and qemu_arm64
> >>  RUN git clone --depth=3D1 -b mbedtls-3.6 https://github.com/ARMmbed/m=
bedtls.git /tmp/mbedtls
> >> -RUN git clone --depth=3D1 https://git.trustedfirmware.org/TF-A/truste=
d-firmware-a.git /tmp/tf-a \
> >> +RUN git clone --depth=3D1 https://github.com/ARM-software/arm-trusted=
-firmware.git /tmp/tf-a \
> >>  	-b v2.13.0 && \
> >>  	cd /tmp/tf-a/ && \
> >>  	make CROSS_COMPILE=3D/opt/gcc-${TCVER}-nolibc/aarch64-linux/bin/aarc=
h64-linux- \
> >=20
> > How consistent is this failure? I've had problems this past year
> > building various parts of the container due to AI scraper overloads but
> > never had a problem with the TF-A repository.
>=20
> FWIW,
>=20
> The OP-TEE OS CI is also running GitHub Actions, and I have seen Git clone
> failures with projects hosted on git.trustedfirmware.org on several occas=
ions
> (TF-A, Hafnium). GitHub on the other hand has been rock solid and fast (n=
ot
> surprising I suppose, since this is GitHub <-> GitHub).

That's just strange to me and sounds like a GitHub Actions problem. I'll
also just note that I had a transient github download failure this
morning :)

--=20
Tom

--F7S+oQm0qlNAViPn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaSc3GAAKCRAr4qD1Cr/k
CiwWAP9v2TR/Fag3VZC70Lu8IDMZ3rvRprqZKr439MBszpMTeAD/YkWUyxhrwf4E
oexiO3ZC8Za/Hu4QYQV9Rk6GHL3zRwU=
=hGZk
-----END PGP SIGNATURE-----

--F7S+oQm0qlNAViPn--
