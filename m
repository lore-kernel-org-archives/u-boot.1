Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF9BDC369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 19:06:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43B8982B19;
	Fri, 11 Apr 2025 21:06:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RHKwiF/1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E008482BC8; Fri, 11 Apr 2025 21:06:31 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 600A882AF1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 21:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-72bceb93f2fso1796668a34.0
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 12:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744398388; x=1745003188; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4NelYRLrvehtdztKZrj072Ja+2+GLmEcUUH+GwLQIV8=;
 b=RHKwiF/15Wbla/OHpBGBcqHckxcG4Ms8siGPTW3OyXe//8vL/i4esBt5j6f3rown8S
 RHfIE1yieZezT6UBWSVWjk+tze7IIYlZK5LNQA9dDxECZPw18P29+RFgeMGzCPAkAt+H
 PiLp4x5HWkB/t2YHeXfqncJzPnIRf51/SN3XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744398388; x=1745003188;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NelYRLrvehtdztKZrj072Ja+2+GLmEcUUH+GwLQIV8=;
 b=s3shQdSzfy1Dpbe1hExUTBJ6aqOdbfreITlYfDZisiN1uX3ZKZSYcA7P9bLax/FlHo
 cYgnWtsQiP/D/IHznERbnwHym8mD4EACPOHRb9By4Kk5RSxoU2/cL5CjubhCNRN4112W
 ci3h1MIdN23dySoK5BoxSUk554GMBiti737bA2vPt48GgowSWqMaKZ+p183Cifjd3P/8
 /ANLxi5ObUGEpz0usaX5otJABJ/E+wcuhItfIVX/5iiNN0/UDTmDOnPiieIm4o5VD4Dx
 a6God5+ZBTohNRHppQ/OH6yDkHRhQ3K+jBb7T5MKawv5MBg/OUpP86jcOKR3OFh3moJJ
 a67A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGAEFT8xSpq0shL/hrU359NTy1JHUD0tFSymD8tDXyGGQZSkN+xYcBnehSvXo3d+3IRD6+B1Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyYfSmzcIeiZeC16ajqp8cz0aGYItb9zwtOEBJh6eewogURsRWP
 v5ShjiR/lBMjJtZCF4gqX2rR/q7VOcsJy5MYtT6IdNPfBhtbnpnC0jlq3YnHYyl5kZ8oFPD+p4o
 PEOU=
X-Gm-Gg: ASbGncvSbM3Gor4PA0LkPdcSXQH+tW0xLslT8IkYKUlrgTNS9ZoDs9X4SvzBANn0i0W
 0fVQN1rVvDmZKFKTcQhVCJ1Z6Nvb3pjdkzRA1hrdsA0xne5VrtWBIF8w9+0JfWVNGnYdK7/oau/
 98MtxZSUn3jwbKljCiFRnRWaGbRXnJ+ZHfJtTc7fMunoSijqP/+HC1VvvphdAua5hbGgsjWAuzk
 y95xpE5zcM9h/l4pKmJ9/rU6pa2j5/cDSm68/JiOF+ygnCnlws2Xeriiz+dMKsctE8GJ9SAvG+k
 i0Q3erVucLs0eiWIPowaRdfGqIbEDX9Ss0T0l0ajmG9NHKLffA3WrAJfHHMcsLWP8EoA9EOxea4
 29JEs287UNVgH
X-Google-Smtp-Source: AGHT+IEoWPZZo76WYk7OaIFUBiqqhBgOUvMr6p49bk2H67Xammk4H7JZNDMp6Sxy8XBK4PuVBCHyXg==
X-Received: by 2002:a05:6830:8d2:b0:72c:4023:aa19 with SMTP id
 46e09a7af769-72e7c122d7cmr5512453a34.7.1744398388104; 
 Fri, 11 Apr 2025 12:06:28 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096d482desm1236579fac.48.2025.04.11.12.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 12:06:27 -0700 (PDT)
Date: Fri, 11 Apr 2025 13:06:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH] tools/make_pip: Use virtualenv when invoking pip
Message-ID: <20250411190625.GY5495@bill-the-cat>
References: <20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sc8izq7IK+VjZzA9"
Content-Disposition: inline
In-Reply-To: <20250409-ubuntu-24-04-v1-1-056728207b6c@kernel.org>
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


--sc8izq7IK+VjZzA9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 09, 2025 at 09:46:34AM +0200, Mattijs Korpershoek wrote:

> Recent Ubuntu versions (24.04+) disallow pip by default when
> installing packages. The recommended approach is to use a virtualenv
> instead.
> Because of this, "make pip" is failing on such versions.
>=20
> To prepare CI container migration to Ubuntu 24.04, use a virtualenv
> in the make_pip script.
>=20
> Note: This has been reported on [1]
>=20
> [1] https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/37
>=20
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--sc8izq7IK+VjZzA9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf5aC0ACgkQFHw5/5Y0
tyxQUgv9GDnPXBdWcRzjoKR60XlulR8CBkrlOl0gIwXiz9gVhHdHIab8IOcgIudu
08rDF0jnhDgeTkCX+Lr2zaP2ZcnN58QcoKY69sdOKCUFbx1VtQSPnc58kkQCR+00
/n1gb7lhPqjKzUGri6M33zjJXwhLx/Jd76wTTA6tX2QsE8th0YulrQTMKMZpHANv
aWYl8aCOwVsYMe5hxZ+qCjEdoQAConWM9p+Q8lAPB0ImIO8uI+Cs3Tcc2zTcmRAx
RVUZzrV0zpYSYYXLTRHO4LMgr0yp72x+pufcWbIhWr3CUvRRpGvLjmLY2HMh92dc
LbV3sbuO7zYWyT7XY6U7DR/ysbSwHiVP3GCuiEWHRURov6jN/sPDgW4JSD+chhUm
e/hN0zXEfMRCNVgB5sZ4QVaFf9v+pDzobSdDSGbBT945TocDQDVibyyMtJQvNTcX
RWelNzeokxUsBNcph8h4qALVMue9mmMZA4Qx9gFttNYzBoPmLzJ7iW2/xRfECRET
fCzVI/UW
=BzCU
-----END PGP SIGNATURE-----

--sc8izq7IK+VjZzA9--
