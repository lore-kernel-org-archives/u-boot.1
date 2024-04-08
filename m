Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066F9C67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 20:11:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D53688118;
	Mon,  8 Apr 2024 22:11:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dAtrWAEX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD938811C; Mon,  8 Apr 2024 22:11:16 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F8A988113
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 22:11:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6962950c6bfso39091056d6.2
 for <u-boot@lists.denx.de>; Mon, 08 Apr 2024 13:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1712607072; x=1713211872; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QFF2njBl/PAeVnXdcCp/g3fjDXAdmqiHlSFDNOf9MQU=;
 b=dAtrWAEXVolWiVTuVM9G2HSyyCv5FQXADKrOIHVwRlrRHYROC7uc+kA8KIUBeB+mOK
 UqzlX7XLA3OLh0m+ZrMa0k3oAgXZdF075bQP7mvcLNbJtxRf3dUblO0IOUBjEkPI5nQo
 ECLgtRli6oP+S1/Juth60a4INrxpmYxl0awnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712607072; x=1713211872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QFF2njBl/PAeVnXdcCp/g3fjDXAdmqiHlSFDNOf9MQU=;
 b=GbleJHC3wx+41aYSkCUj+8vVfQo3nh1u4vw9z9nD7QqGw0nj8hYOlpw7gb+NcEl5qV
 LVEHsc88BpxKw/2ulPyTlpPSzxTcH4b0nF+0Ak/6h44UeeyjS1nJP1aEtvWUufU9azzO
 eDLX5A5Tb/beR3Ix+SOly268yKQvNfkKjvhcjYV2G8h8c7BeEYGH429V28+cvmnsjIaG
 LlNZZPHg4np6DM0V3iw7SwMOzoEE81avQGLrIgUbM7C4rhu/D/pwySkAoCdWUX6rFJsA
 +YrkrQdsXe1Tlcfq2rMFRgmkhsAhWYn0dGYj6IH0xCgwNPykhngFJS2ZuW4u1oOXvVus
 LgVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRhNV8gy7Xozjgq844KWU9ISw6deuCWLGPU12fl+7g3vU3k1lqLzbWKteMSq7BtkjvluAxRWPZswLXaMZPpfBcN4jAzw==
X-Gm-Message-State: AOJu0Yx3vc47s4AaFmYdc4O2nElVdBb2ZtB9wsKQph2Mseswc7Ui40zm
 zYYg0QeR1sQAuFM2tGM/Jyknc3ecwXm3/X7unsEMp/py3ag8hYhWzV6bWY6Hhoo=
X-Google-Smtp-Source: AGHT+IETy5vVuYQ3krCzKZDoMuRQdDPvOPAoRlOU9DW83bXdh/nB++EmyITJOYnYrWE50Z2xaMmL9Q==
X-Received: by 2002:a05:6214:5091:b0:696:a202:5f53 with SMTP id
 kk17-20020a056214509100b00696a2025f53mr11080771qvb.49.1712607072265; 
 Mon, 08 Apr 2024 13:11:12 -0700 (PDT)
Received: from bill-the-cat ([187.144.96.143])
 by smtp.gmail.com with ESMTPSA id
 fe4-20020a0562140b8400b00698facb19d5sm3363379qvb.106.2024.04.08.13.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 13:11:11 -0700 (PDT)
Date: Mon, 8 Apr 2024 14:11:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] doc: build: update docker image to latest
Message-ID: <20240408201107.GC6531@bill-the-cat>
References: <20240405-doc-container-img-v1-1-f1e0ec59f5d9@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ymcp8kf1n0Kx2Ov0"
Content-Disposition: inline
In-Reply-To: <20240405-doc-container-img-v1-1-f1e0ec59f5d9@baylibre.com>
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


--Ymcp8kf1n0Kx2Ov0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 08:16:19AM +0200, Mattijs Korpershoek wrote:


> commit cacc0b2678c0 ("CI: Move to latest container image") updated the
> docker container image.
>=20
> Reflect the change in the documentation.
>=20
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

I'm fine with updating this for now, so:

Reviewed-by: Tom Rini <trini@konsulko.com>

But I think longer term we/I should reword the section to be clear
that's an example syntax not a "recreate the current tag" since only I
can push that result.

--=20
Tom

--Ymcp8kf1n0Kx2Ov0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYUT1sACgkQFHw5/5Y0
tyx/Wgv/WEljJDbGSRrXwyfBc95BQGrZtxurMkTwDtu8gVHZk/G/XT2YTOoWEgSM
chb94t4NvcO+WsXULpdzmkJ7fFsI8cM1r7nZyIcz+0FMzBiBqEbUzCc8SpydVFoq
kwqGLM/UnS7M8Ei4GouCjM+FiBxeBEgymrgDSrgGCcXKcOwzBpqN6fbjuz/gqYN4
0uhonc+og3qnALU+PUUHqiSo1JoNSLwqm4qNWx4iaX2fTvvgJhCls30+GN5NUvur
LU+t0SY/FIIAOaSr+44ib+En5RQ76hW+I71jqbaEyfxl2B1C+srtM/mJ6WMjhwtB
MD+wXtOsxRRT1pVPvVaLKzFXa+7BuRr7rS4PXAkZz+opy4c8x/H9m9HeroMUgY3/
xWkxltNAXFAAq/jr4REGyiQS7zCWHeyx9bbAAXwzil5HMd1cVm7VXMijowdG6Ye8
Lc7GmCb7k0me+HxamDxlogZN3yhWgAK8RFuxB0tdeg9ZU2A41L+E/709wfzz5X7e
Y9YsMRsl
=NhOv
-----END PGP SIGNATURE-----

--Ymcp8kf1n0Kx2Ov0--
