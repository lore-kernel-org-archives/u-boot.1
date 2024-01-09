Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FD4C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jan 2024 15:59:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55A5B86F1E;
	Tue,  9 Jan 2024 16:59:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="grjWI+JS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B38B87729; Tue,  9 Jan 2024 16:59:15 +0100 (CET)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28FB1807A7
 for <u-boot@lists.denx.de>; Tue,  9 Jan 2024 16:59:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-680c4475b8bso17818146d6.2
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 07:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704815952; x=1705420752; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tY9MLEpfhjvTPioLn3LuzhdylhS6Vo8eogovgF7g4oI=;
 b=grjWI+JShACoBhawinIlVhLUFFS3IoA6QmBaVpA/GnXdwVQzcRlu2FEoidaCYHty6o
 3BvNEr6OIDziHQ6dLDJ4f4KCFJWAEUpdV/ZdXErLIKcVKGxKPKUM/sEIptmVdn27bS1R
 Ac03xXE5ILTfH42gYD81fyYiUvRM9BmRs6GmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704815952; x=1705420752;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tY9MLEpfhjvTPioLn3LuzhdylhS6Vo8eogovgF7g4oI=;
 b=eOsYMwuPplulNk2xIOkcDUGYNpl+ZkLmK3kbVqJXUuFRdsWJmttVo0De6Lk65IXhRN
 cJJgnEO6Fk2zIS3rYU1OkimhTEm59Kn3aBtrr8J2Ik87+KSZUqNS+g/sdQzNqUJ7ojNx
 pKqnnlayvkXXcGR2uyWhNJH8MOu+w8qtt2mv5hhGXw/1kiC48wPsRCoE1ux+6UONyLY0
 WJovwjLuloRxxtTTlG1EoY6iIuj8SmGeHJ442H3jqgJLmRd/TJ0H9o/mATemH3a6qYYI
 PVREv7Nyk2weR5Sn13gOoV5rkTiDs8ZdJ1IP6Te/Ndyz6BatyOrnTSUYrD1afioz1wJu
 G/Wg==
X-Gm-Message-State: AOJu0YyOQRowEguNjskcyBj/YEMaC6pU07jsDufmXvCPs2sDYJo9p1ub
 L+OHVcEyTxA5+gZEH9ITRTD4Iyw73QEtbg==
X-Google-Smtp-Source: AGHT+IH1QfZNJx8yQlfmPvRl85EmPDDH4QMFLL3h9u20sjlwGV8QbosnSVgiyiXiAUTmFdBkIX72bA==
X-Received: by 2002:ad4:430f:0:b0:680:d224:702c with SMTP id
 c15-20020ad4430f000000b00680d224702cmr4862086qvs.84.1704815951834; 
 Tue, 09 Jan 2024 07:59:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 mg18-20020a056214561200b006805f614f62sm985000qvb.26.2024.01.09.07.59.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jan 2024 07:59:11 -0800 (PST)
Date: Tue, 9 Jan 2024 10:59:09 -0500
From: Tom Rini <trini@konsulko.com>
To: Minkyu Kang <mk7.kang@samsung.com>, Stefan Bosch <stefan_b@posteo.net>
Cc: u-boot@lists.denx.de, promsoft@gmail.com
Subject: Re: Please pull u-boot-samsung master
Message-ID: <20240109155909.GS1610741@bill-the-cat>
References: <CGME20240109015516epcas1p368e48c6d3e2433577bf7d0684966c45b@epcas1p3.samsung.com>
 <0a3d01da429e$e4427ec0$acc77c40$@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="trMTW6DpqWKicVYk"
Content-Disposition: inline
In-Reply-To: <0a3d01da429e$e4427ec0$acc77c40$@samsung.com>
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


--trMTW6DpqWKicVYk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 09, 2024 at 10:55:16AM +0900, Minkyu Kang wrote:

> Dear Tom,
>=20
> The following changes since commit 2f0282922b2c458eea7f85c500a948a587437b=
63:
>=20
>   Prepare v2024.01-rc4 (2023-12-04 13:46:56 -0500)
>=20
> are available in the git repository at:
>=20
>   git@source.denx.de:u-boot/custodians/u-boot-samsung.git master
>=20
> for you to fetch changes up to 5631d20e2ef1008d55569790f79672ea8cc6894b:
>=20
>   pinctrl: exynos: Convert to use livetree API for fdt access (2023-12-07
> 18:58:48 +0900)
>=20

The change:
commit 411094b8afd9553eb34efed258c64bc39b578149
Author: Stefan Bosch <stefan_b@posteo.net>
Date:   Mon Nov 27 18:26:08 2023 +0000

    common: board_f: change calculation of gd->mon_len to fix s5p4418 reloc

No longer builds for microblaze.

--=20
Tom

--trMTW6DpqWKicVYk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWdbUcACgkQFHw5/5Y0
tyyNGwwAgoGZI1LvdwQmwYJhZIqYzidYAgx97AHl29lZcn615A9aFZEtJOPGD4IK
B54WPdLSUtacO7PlxwxL6J/tbj+T6FaUH0YkSvES/fnKkgJECxsqw/MD+bVO9JeZ
6tIGZCaSsFReRvuQ31vFWOyFl+TMV4wriQndTTXiZvxvTWIdyL2GA/uV7m19Jikb
9SGDkYKYcVGf6QjRNo3q7gZqWXVKZQ7pjAWC1rh7KGKbNG6pJAhDXXsJ8CWmXfSm
1n9VowybveA7rahrj8gQzrYWFKzYmPKTRUTh6moC2t7EmFS2h/mNnCtCsYemmXy9
7KHasyLuQUoyZEhTXANk9lM7Y68NxNyS/Vxec6qlu8uc2ID1WlzX3obWUoa323wj
MScCB5XjNHtM6OaEYNixgZ2aGAgP2qJdic/cXXN4FnoyAxamG2pGXYa3xEkm5YKA
hrDpiDQJCPVxQvXXZWdm5A8zM1GLWk9zbO1D1NHG1cKL6QYUYpX6i85C99DEV3+L
DcFPPn8c
=AIu1
-----END PGP SIGNATURE-----

--trMTW6DpqWKicVYk--
