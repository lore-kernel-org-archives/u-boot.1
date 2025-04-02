Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79DA9C36018
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 19:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C752F81E6C;
	Wed,  2 Apr 2025 21:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jqJOqSDM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE24481F0B; Wed,  2 Apr 2025 21:48:33 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 878CE8035B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 21:48:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3fec2899574so100238b6e.2
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 12:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743623310; x=1744228110; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lj4OP8Y+cKIzvrvfNRmLJ9s3evb1IcG/HTvZ9oGH8pk=;
 b=jqJOqSDMlawEn0D6W/4hDALRY+LyDlxwZyMhcW6ov2HIUoTxwYqOWyX0h6furTgep4
 SUX8EyVPgJYFKzsgc86gz88Ik+ujmJzCAaRZom2o50h7mIXUxrWg3hyWm08hh8vMXHhn
 DZbm2aB9Cwtyb0gvl41j9QK/qlhm4qLD6kP6c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743623310; x=1744228110;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lj4OP8Y+cKIzvrvfNRmLJ9s3evb1IcG/HTvZ9oGH8pk=;
 b=m5E0cqx37gVEScJTxkHX5DQ+4lawOrd3Q5yWqP1Y0P3uZOXp9fu314vLSQSML+h6vR
 HgvTb/Ig1oRze0EPS6GRbgNXNITTML5LhrTlMphK6DoAKkxWTXXzoE20UlHKHNqGUKC0
 Ex6j0VlwH0DK0EbkLmibiKeN3gEDVn70pBLXf6Mm5WlFLzCHRv6Qvh63mvLDL7zifPOJ
 8JByncO/idwBzRoNYgFfaEGqg1MOGVVqbz2bRXdT4187z6C26PYTyfzXEFQ3knZQHAtG
 NtHBjswtjPdeJBrQCN1gm8kCxU4CH7z1JyZDDe45A8luWH8rRaTOOrCo1SUw3EJ5jcsZ
 aPrw==
X-Gm-Message-State: AOJu0Yy9YaAhcpuwmk4LWVq4b8RUNLeKR3IcKCe162B/w5DExlGPy4gm
 67EbAViK8yGYpnNUaaWvKvRYs1z91Lqwhvrbl0j/f/6UO/3eGP+64sv0Wqbvc1N1PqvDsn2BxHG
 L
X-Gm-Gg: ASbGnctwmMC1x+n7KJtzip1Q70uBpw8L2pJ9RQtwlSWYtp97kDcgo41cRpUy2ThAKfu
 JlrC8FaWff3iKWAvEt0Jj3IhXlRHlLzM60O8M6/TYN8JznEqxQvvwS5mFTq7pKH0vpX6klkpQ5o
 z/dRn3sKBmkjDlCVJHifQ8sToSWxigQimz1Xrkti5PvdvXWOYrjWaOlfowJ7MtLP/zocZ2nsvdq
 rFFTSSlZrwoq0zeyPRq8qS96nq3SZIaf8wMuCGiTVS7U2Tys2M7ZKGQ1RphrT7uzBihArGJlDUF
 Z88JLo302nN9Key6ZaRfWnBrz8Feyh7ZgvbllSZJb+qH7oQGcoqeBne264v0Y26FrnRhHzxkAv9
 sYogEBQ==
X-Google-Smtp-Source: AGHT+IEbvyHu1eArl1MEEgxxaaaFEf4B3MKwWQ9eRH3984oK0aQoXDi2o/KS79VlLyIZ7T6c4JjzDQ==
X-Received: by 2002:a05:6808:1512:b0:3f9:2c91:d798 with SMTP id
 5614622812f47-4003635f54emr1821569b6e.36.1743623310293; 
 Wed, 02 Apr 2025 12:48:30 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2c86a531543sm2908893fac.24.2025.04.02.12.48.28
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 12:48:29 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:48:27 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Merged v6.14-dts to next branch
Message-ID: <20250402194827.GA5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yHnTweRSg7GPRGRz"
Content-Disposition: inline
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


--yHnTweRSg7GPRGRz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As the subject says, I've merged v6.14-dts to dts/upstream in the next
branch now.

--=20
Tom

--yHnTweRSg7GPRGRz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmftlIQACgkQFHw5/5Y0
tyyffQwAqOJxI6r/v+y9sq40fnfKGYuPl9g3xXheoXgL1lYSphwY+wqysB0YorPg
YhWYxoOxzsXdKORxtp3UmgcW0BxTkBJJ2glGsC5u5oSkfV2PgeNLZB6lC/5xdAKV
Fvq4RrIgS+VX2EnWQMTUVvgECKFeVXOvNwf9Sx77rza6/ab4nw0cZHqlLVj5sAhJ
S0MhLrnnPxDopwVxFNkcntzXomw5e0HKRJpUyj85SNMr5GwIOCDm/A+Ihta0w6JR
NajBWAt6OZ2HmoJMQpMRMvEJKbwwyBFK/oAXK4ZX0kZ9TXKlxTslddMsMhjEu97o
Bl+W8x9gVE7Ot2qA6LbCrLNBv206L55k8ZIb8DEkZLcNcXTrYKeeGfOd7T5VxhiH
MjuaByr9zaWxAt9IirJPWThqxS6hhpwdkKBnTV3qSScp+gWl5GssXwaMiPXAb99K
2rAf7KndRGHegJBJ1pjZxtEm0ncBZ+nUZGmvBn+CwSJqs4T76qZNxF0CfaFz2W+M
87LLlpmB
=uQT+
-----END PGP SIGNATURE-----

--yHnTweRSg7GPRGRz--
