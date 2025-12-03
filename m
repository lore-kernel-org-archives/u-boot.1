Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ABBED12D65
	for <u-boot@archiver.kernel.org>; Wed,  3 Dec 2025 14:04:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADDC383F2D;
	Wed,  3 Dec 2025 15:04:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="omNVM+lk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB11483F82; Wed,  3 Dec 2025 15:04:11 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DA983F24
 for <u-boot@lists.denx.de>; Wed,  3 Dec 2025 15:04:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7c6d13986f8so869668a34.0
 for <u-boot@lists.denx.de>; Wed, 03 Dec 2025 06:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764770648; x=1765375448; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RnmS62iScLoLbimFdiihVU7eKwjuSpuyOAsa1izr1rc=;
 b=omNVM+lk0TM78kAemQfJrL8d0TtoEQvEN86A8aJpU92nTV7x8QRkavdkw3So6mZPZ1
 NZGcnhpneecSHiZFCRd/T6EhPl6p0w+4YeIcX5FaHocyj0fUIrdRvSCVGJ4xkRpWtfGl
 EmMMrMix1xSohmRr6cqTEsBOPcoA5hWg8wAkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764770648; x=1765375448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RnmS62iScLoLbimFdiihVU7eKwjuSpuyOAsa1izr1rc=;
 b=t+FtRbBzWQlfmOdXbw1IwaBXzG8+LzGIX9RtzgzEbgencyKAsH2eXHIa80k5NfukR2
 IqZbUrHxXpOaVZyYoG5NbNWImCx+PRKp+S9L/G/szLsxnvPeTul2lhoWM+l7JhNRk2ML
 OSJvJnCey9Fv/EjD352WwCGgpAztD9JFdHZj2n2SwOVxxzYBtdKohSrgwV8oA8h9yIUU
 dJI9MBmZqI37f0CIgoXS1eiBkk4cx9Ukvi8SdkiSseaLAHIKIuHoOyePcr7srcYzvmCC
 qzYY5nR5cGSQFF3CuG53I8pmoCu6vxjswWAlJdKuvYuikDHN2SiDYlHP+Y9tTioLmOa2
 tQRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/6MTgL28t2Yj6Xnh6J0GSx2+44Sm8+T7B0LwcWukQ4LLbZy3LfchTZM96HnyUt8xU57ojKa4=@lists.denx.de
X-Gm-Message-State: AOJu0YyBs+I3i2n3amzc/bSbwvC0LFKsDmIVbGYx68CenbNMVD5CyrIn
 KTFur8BSVeRVNBQiOox4Oh080+YaTQatT6ZMf7y+AHxCz2qgzblVenQsRvKkO4CwG5f0Etz5YHK
 BAuV7fhU=
X-Gm-Gg: ASbGncvxW9uqc7JFrMvMVIJ7W6SqA4AoJ4wj8UyveYN+jMn4ZDONovxWEJE5aBqSVVx
 FRswRr/3RelzVIokMa63ueB0rLZzNR+HM/APiSanC/paz5T2Rau+zkYDqWhRZ7C1puTjn3vclU7
 oTOK3ZgR72gI7TXr3Q0dQ9MMkWx8WKPUmf3FqZLkYF8q7wr+N5aM8QcVOd6r+B+1qYOkB7OjLty
 nbtxZccmL9ScFVunYr4k/BEu12g1YRgaFvrZ8RKxDr4hJHpk3fqDuoy6gkKKsQXbCwPV8VCP7QT
 epYnlXzaPBycWoHbstX46NKF9slKHJ3vCloXG4Fyye7mcmvy3cHqezcnVQEWb3rJ3H503BH00os
 C3DL9RRiy3oXo/5j7qDEPRmP2xb+8TAt3aLVn0wbaMR+iUOO3PeBXwLkdsACSxS/5IFc7wgvjMb
 3pmnu534vDXE4zjneJ+BfOO7FHg6ESqL/ZKPL49fvChxg69IpcNg==
X-Google-Smtp-Source: AGHT+IH106if6imVqnGt1fI2Is417UXDBDlPQZpxU69nveGrb6ApjKO/YJPOY4PA0Rse3pLlBA0kzw==
X-Received: by 2002:a05:6830:2b0f:b0:7c7:1a6:6a09 with SMTP id
 46e09a7af769-7c94dc8085amr1628016a34.17.1764770648370; 
 Wed, 03 Dec 2025 06:04:08 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c90f5ffad8sm8823698a34.12.2025.12.03.06.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 06:04:07 -0800 (PST)
Date: Wed, 3 Dec 2025 08:04:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: Re: [PATCH RFC 0/4] fit: print conf node compatibles + use property
 string constants
Message-ID: <20251203140404.GO303283@bill-the-cat>
References: <20250409-fit-compat-v1-0-56df89ef486a@cherry.de>
 <53b69ecc-0fa4-47e2-8a79-111b4b3a6b18@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z2RPWVKu4Wxsn8Cm"
Content-Disposition: inline
In-Reply-To: <53b69ecc-0fa4-47e2-8a79-111b4b3a6b18@cherry.de>
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


--Z2RPWVKu4Wxsn8Cm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2025 at 01:21:35PM +0100, Quentin Schulz wrote:
> Hi all,
>=20
> On 4/9/25 5:10 PM, Quentin Schulz wrote:
> > This does a bit of "cleanup" by reusing constants for some FIT
> > properties instead of having the same string in multiple places.
> >=20
> > Additionally, this adds a new constant for the compatible property in
> > FIT configuration nodes[1] which is useful for FIT images with multiple
> > FIT configuration nodes to support multiple devices in the same blob.
> > U-Boot will try to figure out which node to select based on that
> > compatible[2].
> >=20
> > However, if this property is missing (and the first blob in the fdt
> > property of the configuration node is uncompressed), the compatible from
> > the root node of the associated kernel FDT will be used for the
> > autoselection mechanism. For now, I only print the property if it
> > exists, but maybe it'd make sense to expose the fallback one if it's
> > missing, hence the RFC state for this series.
> >=20
>=20
> Any feedback on this series?
>=20
> It doesn't apply cleanly anymore but the conflict resolution is
> straightforward.

I probably marked it as RFC in patchwork. So, how about v1 non-RFC
rebased on top of next? Thanks!

--=20
Tom

--Z2RPWVKu4Wxsn8Cm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTBDUAAKCRAr4qD1Cr/k
CmYtAQCapbCF45p6s+vXS7PKIERSEtvr2FWI3dHal+moMdfqCwEA3fYumNVRxPjB
F6DhFGfMDIOFXRR/T02iBpSKOzR/0Qw=
=B/zf
-----END PGP SIGNATURE-----

--Z2RPWVKu4Wxsn8Cm--
