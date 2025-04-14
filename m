Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AF6C369B2
	for <u-boot@archiver.kernel.org>; Mon, 14 Apr 2025 22:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98CA782905;
	Tue, 15 Apr 2025 00:59:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ScMzfACp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3404082905; Tue, 15 Apr 2025 00:59:19 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E594827A6
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 00:59:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2cc44c72959so3033199fac.0
 for <u-boot@lists.denx.de>; Mon, 14 Apr 2025 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744671555; x=1745276355; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cykt1tmm5YBw5p0+bbHFxy0zurM8XzS7m7oGYDW9mUk=;
 b=ScMzfACp/I4MxEdQDvdZe9cZSWWZNwCWmv6bNsYvQ+4PLv/XyI3v00OAhT1QR4F/5T
 7X78stTF3O9rqa4uNmMbA+WQj6xLOyIvTYcXmzI5yAf00Tm9Kz6kt4T4ySFmYL3X13ny
 B302NYDHOBWaB3dAE2S2KpI2n2nJsU3dLE594=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744671555; x=1745276355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cykt1tmm5YBw5p0+bbHFxy0zurM8XzS7m7oGYDW9mUk=;
 b=JCI9GpTRoOrTBFpqQ3XOxINjzFy6D982gQfwMhk1fdtDKk3V/TaQf4EJXcx+E06yOm
 WNErHCwASKlx7R5hu6QJ9+6NRO1C+f1BHtvFRJ+Q3Ba1y92xXdZDNWtqztuo0+nmYfsR
 L+Lmr5qLv9gnSYIq2xNEM4+Qb8NVIa984/r7TKcejevHswO8KcIPIa5vGhVC2y4aMLCJ
 If72OrPbH8xnyBz7FIbMVIyYuryECx4ABbwj1OKbZxeyKLjKllH9+KXleaNYPq/gj3Wf
 TJvNEG6YD0+2mULD/9ayqS2sFtK26tJfaxRJGJMmtlp9XXZDvt3OCrO1Xy/99sbap6rM
 P+ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6Xnx0qiTeysAOArLR1RhksOxKV4g/WvkJSbYKTR+zlw+x6Wx3Alv/2Y9J1IYhVUf3INi4SQk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9M9E5w0eWU+7LkyGBShpt/7ydkNNy9NPPmA0nNhgS2ECgL45E
 B4Bk9or6iQxKCB8Q3d9bHHAdERgNfcFhBwuIFMezuYZa9xAA8WWVIMoe1snR6iE=
X-Gm-Gg: ASbGncvsmae5WZTAXGQb7N0S29WccU1dmv9VNWmRQkKaFrySIE4DaXNlZtuVaUxGBVl
 RDBbLbvA8vSZ0Szsl7lyb28Ja5Q8nR/H5QGWYxyxHx9yFSYUKX4DR005aZdc3EfRaWSrtHiIovL
 S4KX00v9DCMqzwOcIUT+TvPQaND06wBvaubExkyKKahNW7cIxQFvmjEqJZa8XE4NJG2TWRc7USD
 VlH62RBC0zQ94jtboJVabDQZ/WGJBH2yLNtfJmTVn8P2wbP1bWmYRNi6D2M56SQtu8qfRnZy9XN
 rngY0RPM3S3x8kENIehC+kNL6UPvk8JHr82Y0/0ntQipdQdjevgPX535x/Lu7JBh9eRcpkRlFFW
 PUbg//UP/oLHZ
X-Google-Smtp-Source: AGHT+IHftVT4H1Ui+8xY/60/kecYEtNSoyXD4/FBn9Q+KMw4nLq/Mooj2By6sosJ0SkfLUM9Wvn5ew==
X-Received: by 2002:a05:6871:68a:b0:2b8:fab0:33c with SMTP id
 586e51a60fabf-2d0d5d9e2c9mr7504256fac.23.1744671554915; 
 Mon, 14 Apr 2025 15:59:14 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d096cd546esm2618664fac.39.2025.04.14.15.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Apr 2025 15:59:13 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:59:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: n-francis@ti.com, u-kumar1@ti.com, bb@ti.com, afd@ti.com,
 u-boot@lists.denx.de, upstream@lists.phytec.de, w.egorov@phytec.de
Subject: Re: [PATCH] mach-k3: common_fdt: Fix Label Issue
Message-ID: <20250414225911.GA546803@bill-the-cat>
References: <20250407060711.3160366-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="suYUxlMp5QhWbKf4"
Content-Disposition: inline
In-Reply-To: <20250407060711.3160366-1-d.schultz@phytec.de>
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


--suYUxlMp5QhWbKf4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 06, 2025 at 11:07:11PM -0700, Daniel Schultz wrote:
> Labels are not allowed before declarations. Add a semicolon after the
> label to introduce an empty statement. This will fix following error:
>=20
> arch/arm/mach-k3/common_fdt.c: In function 'fdt_fixup_reserved':
> arch/arm/mach-k3/common_fdt.c:156:2: error: a label can only be part of a=
 statement and a declaration is not a statement
>   156 |  struct fdt_memory carveout =3D {
>       |  ^~~~~~
> make[1]: *** [scripts/Makefile.build:256: arch/arm/mach-k3/common_fdt.o] =
Error 1
> make: *** [Makefile:1919: arch/arm/mach-k3] Error 2
>=20
> Fixes: 096aa229a9e ("mach-k3: common_fdt: create a reserved memory node")
>=20
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>=20
> I'm open to other suggestions! This is just the easiest way to fix this
> compile error. BTW, master is fine since 096aa229a9e is only on next.

Is this the only warning you get with Ubuntu 20.04's gcc? But I would
also rather see Udit's suggestion on how to fix it rather than adding a
';' here as that looks like a stray character rather than an intentional
but not always obvious fix. Thanks.

--=20
Tom

--suYUxlMp5QhWbKf4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf9kz8ACgkQFHw5/5Y0
tyzNRwv+PoGmP6EbNXlVOwnOjMqFwzKhw5FpL7QFwsviFcBcIXRqKJzUmKHgO8zd
nUsW9K4g5O+gtOGHBC62otSmPsLFaBHpNy+mbSI0U9iToQS9LNJluvpQXQJ0vajV
LEqtmmo0c0M3rUZPGk+G+fw1qiiW9hdbC1xZaqB0SeyzBxGjP1XSeMJKeMDqC59/
ovK5VXrNKzGOQ5R3lSfgdiLdZU2TPJB0/Ymuul3lrA38aOG3btfeM+XloEEBozFB
7rTpyZe1J7KiI37AmMNQ8ayxvu5st0aZnh965rb0moWhrZNdyOJBFhWTPRwTmLzW
wqIIJnqUPOZMzX3Aiol2iQtjQOiVzmrGO6bwisrXmFWN6eM7dM7knNSnW6eJ2enM
YSqzXeAkNDyj/GKAmgdjd9ZqLkBrPXPlIP5izQLazJHaw4Lpmdk4AbxnZYrSL6DE
rMQwgj7qXDm0jCa28Hir3wfLPbCp0AxbMwB26dqDs4ozTY7xSXGkeOf1kWpF/4oJ
jBZxOSfw
=SKWO
-----END PGP SIGNATURE-----

--suYUxlMp5QhWbKf4--
