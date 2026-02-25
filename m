Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40111FD3769
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 15:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C091E84010;
	Wed, 25 Feb 2026 16:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KTC+46Zk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC821840B0; Wed, 25 Feb 2026 16:09:33 +0100 (CET)
Received: from mail-oi1-x236.google.com (unknown [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33FB783FF8
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 16:08:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-463a0e14abfso4977014b6e.2
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772032067; x=1772636867; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3MHjm1cKl1YIMOFLLffL0EUY4LSsnFMd0Js/bOkfGhk=;
 b=KTC+46Zk5orschWySn8lpFNnAnqBC3yWCY6WJ1NFxQ7AAFK8cQ6ZAr9wdIRH+VzXr0
 RtdGDJfNjU5Uz1zWM0HtVyYPWl5EYaFWz3tDQwpERQTOS088cfjk0geiLUDt0UEWfhTG
 7Zpjg1Xch5/elsPhST6VbIaGGLL9BVqXGf0zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772032067; x=1772636867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3MHjm1cKl1YIMOFLLffL0EUY4LSsnFMd0Js/bOkfGhk=;
 b=pZ2vVq+/FPVpRXq9WP6tYZjcaHoC3rr4nt5p7PgJWDkVoFKDI1OktCm96S59HfKC9p
 lrlgzTc9fgUX8IrsFVKuLd4bIgW9z6cP1LUEFzKi9k/sa2Ld5UqJjX1AKsdJido3P9XR
 OatDz7Jm+Rw9ikfleJjVZRKNFfifytxA2k9kumW8R1B44epv1uBCs/ypKTrJ/pumH8Tz
 WNq2GwuPVhbHonN30qQuf/LT8eivksO9G6Kt18DGP1KCsx5Tis3eFfNOO+jAzFV6qeun
 Etxx3DSJdFKGyZfBEOB62wRZuy8EU/ZTEc10Sqfb4Vv1NN8mv2ffYlIg6asO3hcPz5H7
 5v/g==
X-Gm-Message-State: AOJu0Yxz1cG3qFCLJHcq0rJ4G98LYdtwENPfCf1FFYmufboSeg7M+jEn
 6AEP20AMlcA8LFji2OmuKcQTYkZuYyIJ1kGiHArojJzWD7Fo+/d9j2EIJ58mMrIDu+t0mmv9Jr6
 hFlJUOOA=
X-Gm-Gg: ATEYQzxH6I3bk3ci3y7B5c5PeHGkvyptHWnPNOERzG5z8JQfIDKG94AjckHqUqr/l/h
 Ji4sV0kNRuVWoGxh8mgvI48X0X0ZnmhemJrgzmAI/1OmaZOv8XHaaDglrfbcUa+DEQlgxUYjJd2
 wNGUXEfLByZgws7CSeInbLBz6DUGOuEOZaZAvC5kGqmr3FG3236ZanrrI13pZIdyA5EapC3BVWL
 j7fqedwa6lCTJW7sLoXyRdnFU249MbU/eoIdk0/xRKJw6YeyKCahwoyCcATDxK0QQ8SqPtb3ZnW
 PqXpuLwle9WVIw4OnMNwV+B0n5Mvn1TgauivxEyzMBXhW4E74+QFnfB1L4boGRHTeN51R1TohXE
 C9gEx7G5pjlojkUHCyMs0SbMLkJBqKGIXJiJJ5pd6dtQ/zEJVFH0tjYRDFNmCKd0TvZUVv/kjEQ
 vElUMVB9YeUbqzCed/x8ZC0CqngcKqhKGjTkb2jC53SMF09tRFvSmO9R7qxhvvZwJibfExJ/bo3
 c940SOjZQRgMUeWZkrIJ9EfYY88oVvGhYLEPZyPEOM0dV5EGEc=
X-Received: by 2002:a05:6808:c176:b0:45e:a76f:2f43 with SMTP id
 5614622812f47-4644612e3f9mr9087445b6e.1.1772032065096; 
 Wed, 25 Feb 2026 07:07:45 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf9f489sm12478385a34.7.2026.02.25.07.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 07:07:44 -0800 (PST)
Date: Wed, 25 Feb 2026 09:07:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] tools/atmelimage: add const qualifier to fix compiler
 warning
Message-ID: <20260225150742.GH1593142@bill-the-cat>
References: <b040fc218c68db39b51c9f8d7b180ddfc332d4e6.1772031799.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2+R0t5ZRvZa9j/OH"
Content-Disposition: inline
In-Reply-To: <b040fc218c68db39b51c9f8d7b180ddfc332d4e6.1772031799.git.daniel@makrotopia.org>
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


--2+R0t5ZRvZa9j/OH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 03:03:57PM +0000, Daniel Golle wrote:

> tools/atmelimage.c: In function =E2=80=98atmel_find_pmecc_parameter_in_to=
ken=E2=80=99:
> tools/atmelimage.c:64:31: error: assignment discards =E2=80=98const=E2=80=
=99 qualifier from pointer target type [-Werror=3Ddiscarded-qualifiers]
> 64 |                         param =3D strstr(token, "=3D");
>    |                               ^
> cc1: all warnings being treated as errors
>=20
> Add 'const' qualifier to variable 'param' to prevent build failing
> due to -Werror.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  tools/atmelimage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/atmelimage.c b/tools/atmelimage.c
> index 6a2d9d8feab..770f7a0de4e 100644
> --- a/tools/atmelimage.c
> +++ b/tools/atmelimage.c
> @@ -55,7 +55,7 @@ static const char * const configs[] =3D {
>  static int atmel_find_pmecc_parameter_in_token(const char *token)
>  {
>  	size_t pos;
> -	char *param;
> +	const char *param;
> =20
>  	debug("token: '%s'\n", token);
> =20

How / where are you triggering this problem? This is part of mkimage and
built on CI every time (and on macOS and Windows, in Azure). Thanks!

--=20
Tom

--2+R0t5ZRvZa9j/OH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaZ8QPgAKCRAr4qD1Cr/k
CvnTAP4iO0Nr1RMA/qTe1ATFuVupWe2pCLRjQUqOX1LYmwALwQEA3cW+uEhxDnw/
mMnXf/WqqP7jI+f1p7t0WQGPYhhvTAs=
=dwjU
-----END PGP SIGNATURE-----

--2+R0t5ZRvZa9j/OH--
