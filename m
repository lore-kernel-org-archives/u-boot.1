Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C55C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 15:25:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCFB487C61;
	Wed, 24 Jan 2024 16:25:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kh0tfCSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C0587C96; Wed, 24 Jan 2024 16:24:59 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3B5387C60
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 16:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6002317a427so25404087b3.2
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 07:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706109896; x=1706714696; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7r9vl0ghhiLEA4QZOaINrIvJHoFfDkXVstXNU+wfAWc=;
 b=Kh0tfCSs1Jaunt4fnbqDSAQJFl4fEJyvpLnR4U5FqRjMR82D73tarakyw7CQ2iN2OA
 +KKnod3V2+0tMylvu3JJDGq0ZHPndAVnLcydtAulzKmgTqygtpoXkA6hQ4qkh0U5YOrV
 TrmAXlGUmxcqjrTuQ8nDUGATMCqJfkND7Artg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706109896; x=1706714696;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7r9vl0ghhiLEA4QZOaINrIvJHoFfDkXVstXNU+wfAWc=;
 b=QeoKlByvqmmefZER1FwBI/GT85DIR/pkWN/cwmZvondwVqn6bCILujG/v3Rr2ehliZ
 l0MNOL7n6B/LXEhiMFeZNwd72h1trTRksAlUyrI52iiWs2jJd/hEpik8ZSuvd+z4O8rY
 WDOZX+tnrQAWkAjA1Jx89Vj0s5UnRz6RC1xtHGCXkHINKTQO6fsFKuz+haSr9A+VaIGZ
 k7DVpFs4BEUcpphNfHvbfOiltlJxH4Dlr6HUXVefWJidt9Xld7EyZGgspiN9c9CPOWsB
 xqKa/6RbZ9gTgxbgEVqvgI7XpfoJ/gzn+QQxtPrnZdoF4+yQ/IX0BZXVEYcZqIqV/62y
 M3zQ==
X-Gm-Message-State: AOJu0Yzjr2oqwWlcuTDhSTIIlH0c/fVF+EELDm05d826BuIapmElr7sz
 0yOzy3Xuf3vQWMgHnTJgs9vKJYXvaiz+i9taY4ebgdmPYKZfQa6HtN8Zpg2T62tdBIwVYrtvzBI
 W
X-Google-Smtp-Source: AGHT+IG85Z5abjsKyiuA+tVRNCmsJqJ4kax485hh0QvF4FPAvakSxMKp1WttULFEBB5wro6iaJZbdg==
X-Received: by 2002:a0d:fac2:0:b0:5ff:9554:96bf with SMTP id
 k185-20020a0dfac2000000b005ff955496bfmr944982ywf.48.1706109896341; 
 Wed, 24 Jan 2024 07:24:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 n3-20020a819c43000000b005ffd1bf706fsm2586041ywa.96.2024.01.24.07.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 07:24:55 -0800 (PST)
Date: Wed, 24 Jan 2024 10:24:54 -0500
From: Tom Rini <trini@konsulko.com>
To: Enrico Leto <enrico.leto@siemens.com>
Cc: u-boot@lists.denx.de, alexander.sverdlin@siemens.com
Subject: Re: [PATCH v6 0/7] board: siemens: clean up subfolders
Message-ID: <20240124152454.GE3652023@bill-the-cat>
References: <20240124144355.2040380-1-enrico.leto@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GHM4rqyei06NResb"
Content-Disposition: inline
In-Reply-To: <20240124144355.2040380-1-enrico.leto@siemens.com>
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


--GHM4rqyei06NResb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 03:43:48PM +0100, Enrico Leto wrote:

>     The common folder was initialially created for the common parts of
>     the products based on draco-am355x board family. We have the
>     product lines 'pxm2', 'rut' and the base line unfortunately named
>     'draco'! Adding the new capricorn-imx8 board family, the files
>     were enhanced without cleanup.
>=20
>     Simplify first EEPROM probe and access that implements both i2c
>     with & without driver model. Use abstraction functions for this.
>    =20
>     Move all am355x specifics to a new file 'board_am335x'.
>    =20
>     Clean-up includes, config checks, maintainer.
>=20
> Signed-off-by: Enrico Leto <enrico.leto@siemens.com>

Thanks, this is indeed building for me as well and I'll apply it soon.

In terms of future work, many of the siemens platforms need to migrate
to using DM_I2C, and should also move from using OF_EMBED to using
OF_SEPARATE if possible.

--=20
Tom

--GHM4rqyei06NResb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWxK8IACgkQFHw5/5Y0
tywFowwAtudcM4PsTj4dqAziSvHwU0EyEMxmzXohtdaFM4EfNc77VPr4AjrABjhO
T8iz1iM5lHUjjPo7/f4FogyM2jvLBZ1b/ygbrZILU2NB6GLB263/mJWvxwX2FRgb
oKS+Zo6JAa+cJhY4iyiTCYRY3Gri7Q5Ni1CrfdCbck8VORs8yBzwn7c36w7dh8cP
YTsTGa9skIszIRmVAMHzhNh2LMWa2YL6cT8bsoqEnUDXpia90nkxKawRnMLJfFgq
G2G4s7EBjCseTljyXF8zg8zI+01UoqsRstsTBvxHdM8NtQ66GlGKhwaIyfERyOBn
rv1TLU0oOiaiVBWTjaN2AQn77kdYyMtHpb5ss69HgYEnNye+znmTwKnxq0TptGIZ
HI9LGSNAguk0tWipYbWOF4F3CVhjnSXmGy6oc6K0xgPeXqluh8E3OUkdkwRwhQ6e
wZBS9wNCiTZ8Ze2fGJ33YhCgn9YzS4CpRcdB3NV49W7rvG8cfRMRQmLycx1V0Cgd
7IzR5RnZ
=jojO
-----END PGP SIGNATURE-----

--GHM4rqyei06NResb--
