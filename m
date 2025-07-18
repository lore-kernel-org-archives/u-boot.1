Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADF7C83F17
	for <u-boot@archiver.kernel.org>; Fri, 18 Jul 2025 17:56:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 06FB383616;
	Fri, 18 Jul 2025 19:56:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CWWArEwo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A388363D; Fri, 18 Jul 2025 19:56:56 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CDE883612
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 19:56:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72c27166ab3so1811092a34.1
 for <u-boot@lists.denx.de>; Fri, 18 Jul 2025 10:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752861413; x=1753466213; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=u2oR0/GkbELdrooJ9rmw/dtZz3fhqeGUKaBXvFKuHG0=;
 b=CWWArEwoEZS6Na2S1PYypbe+rbv5ulEkK6XbS6IMZBDZj0zUPlDIQEVsjt1pORNkS4
 MYy9aQBeIDJrt0IL3ksK83djrNKBoFkDFsmL2J8GF/G9CJUmE6QdC3+H77lvhvXLFnEE
 jiWPg2Kg0O5H460O0qoYx9jCmIA+gLSIOlP6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752861413; x=1753466213;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u2oR0/GkbELdrooJ9rmw/dtZz3fhqeGUKaBXvFKuHG0=;
 b=XVYFmGA4DFScL7+AeE/tjV16YlEE5nC54dngwTJUEVUmojdWwBK+LeQVz2McSj94ah
 /V6VXmXLu8MDGR4Zovw7sXCoaEYqsynUP+shsRFM+3WO+TVLZda1HPAW5FPblNcEkaYY
 Ol82AfpoU+ra5SDG0LT0EcQXoTgo7PjhYvumGG6Q2/vXwySJmJIg7ng4Et5FE4wEX3O4
 e5XVg36/X1PANpq3SagGr/Uf1761P6HaDCOtffIbDA/TZw5iFwmFB7Bbc9xtZ+V0qHsB
 GA91zT6JgOKMNPp9nUxL4KtnHfJa3lGBzlynhRmJrLqJiUcILeDZnrHxsR4zKvWtZP/f
 dCiw==
X-Gm-Message-State: AOJu0Ywi426FA9MXuBpDEUrLXmKdMitsgoE/bK125/XEq0kcdnINjVXW
 zJz2sCym7k+LG+xHfQT6+Rg50Ls5DRnV/fPQB4+WF5DvRXc1+F0NT2jfs8RMGFjJkcean+27fgb
 SHouB6Os=
X-Gm-Gg: ASbGncun2FVWQ+ahIQGhxAkWponnDqI/yT00DInqT9EyPVtOJvEDIZBVg+tzxZjA7wc
 lpYhSrRML+L3t2MoESIaUL8mnLJEYHU/I798YW9pO44VnXWo+6beiu7289aLYBFKYnmSPR//g3B
 K3Q/9MhWzlrrds1UxrtKbWXSfedtNWUUQ4wQqz0n+A9O4xbXFs6t96kA5Dg1ShvSKvlf1Shhz0/
 PRDC+NO1vw+AeWxoiyTVb0VQ0tD9QVKspnvFFwpuf4G37B82mjRzjLT0R7P9H1wy+awjSE6WxWr
 5qTcQp7P8BOINBNUeV/i4q76JJn9hdzSowl3p/p4Iy6Bd2xuW9fK4MyYnufK0b3ZjQANLD3m4ld
 4YfOlHrvHWxcsJ4XrBLgRwtO0OdMvHVcPNFj0h9s5CnxKqfKB0eTNPF0S
X-Google-Smtp-Source: AGHT+IGdyj1jm+UyLsEApfnh8cFtUq7RnMP3+js9LSEUCrOrJku86nS13yXW7g3NvTw34pZMfjPpYw==
X-Received: by 2002:a9d:3e09:0:b0:73c:d48f:6c6a with SMTP id
 46e09a7af769-73e66199eb8mr8294401a34.8.1752861412666; 
 Fri, 18 Jul 2025 10:56:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e8354df84sm770561a34.2.2025.07.18.10.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Jul 2025 10:56:51 -0700 (PDT)
Date: Fri, 18 Jul 2025 11:56:49 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, chalianis1@gmail.com
Subject: Re: [PATCH] pinctrl: gpio: sx150x: add Semtech SX150x I2C GPIO
 expander and pinctrl driver
Message-ID: <20250718175649.GX193579@bill-the-cat>
References: <20250518212524.137534-1-chalianis1@gmail.com>
 <174899275338.1527530.16332183618630503148.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g6xFh+Wm4agNnxrC"
Content-Disposition: inline
In-Reply-To: <174899275338.1527530.16332183618630503148.b4-ty@konsulko.com>
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


--g6xFh+Wm4agNnxrC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 05:19:13PM -0600, Tom Rini wrote:
> On Sun, 18 May 2025 17:25:24 -0400, chalianis1@gmail.com wrote:
>=20
> >  implement a driver to use semtech pinctrl and
> >  gpio expander, this driver is adapted from a
> >  existent linux driver that is written by
> >  Gregory Bean <gbean@codeaurora.org>.
> >=20
> >=20
>=20
> Applied to u-boot/next, thanks!
>=20
> [1/1] pinctrl: gpio: sx150x: add Semtech SX150x I2C GPIO expander and pin=
ctrl driver
>       commit: 5451504256d34dca5b810a512d3c8dec84ebb49c

I see this isn't enabled anywhere. Further, I see warnings enabling it
on sandbox. Please fix the warnings seen when enabling this on sandbox,
thanks. Will a platform be upstreamed soon which makes use of this?

--=20
Tom

--g6xFh+Wm4agNnxrC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmh6it4ACgkQFHw5/5Y0
tyy9FQv+P9lZNN4hJkONLTa0sd7IS6vYGiaLx3XFifdRk1iB83f4KzuKDHfzJ7ts
7pw4caTUoynCDo/DkLad5zn+tB6VhKf01QLPyYBP6T9PKhPZsLhbRMgpgUN8ucvh
/QJ/CbcpzYe8S3PctUomKyOHCgis3Ysh3Vq4Mu3J3FsrTHYBB7x1iwsv/QnPMzCK
Fg3ihQF6u3hLhKlRMrKXdQiZgnmPDIuyOT0GE6ZpIyR6u7ndu9bL9PHpX5h/lx1i
JbmRTrVyy/rIhVkFgjHjGqjT2W+Yb4zbGc0aGZJZDNlNgVn9Fhj7NmsY7tg1PWm3
2EInPLRX4aYUGzwNcHe2NHeuv2kFEdJxUWiRh0T7pWTrePzF3+uYLA3/573uHFDN
aAAE/6zVic15zZLc21wnWsSLwYac0NpHo6x1ihzpTSKh8x5unzdg8lKPErm2IkOU
STrsctLuIQYgxuUQEd+9qiO3YCqTaNv4eu6+dAh6u1MezA1OCcD2nLBq3ogmhPsn
Jy1O3Kx0
=EYYc
-----END PGP SIGNATURE-----

--g6xFh+Wm4agNnxrC--
