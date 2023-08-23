Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FEFC3DA66
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 17:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE0248645F;
	Wed, 23 Aug 2023 19:50:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ug2Fiw7j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 034CA8645E; Wed, 23 Aug 2023 19:50:18 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE6578647B
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 19:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d62bdd1a97dso5789814276.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 10:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692813014; x=1693417814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GBGVvlBiqFuooJJeETkSAXBy52/3hgXt8dJgpMlgYWo=;
 b=ug2Fiw7jXMr4mNSanwKPoC5MT0EvJWQz/VFuCIrG3eFV4iBaHPfWki9eqo0vJEE7qa
 q361FPa2pwRJSescQEJwb3CvcJOtEJ71FYcTdbsTX64Nw6cBJ8rBQ7i8xz8eZ8nyjDbX
 cyfqVUnMlQkUVg79pfkaV693lWFDHXjcJ2leI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692813014; x=1693417814;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBGVvlBiqFuooJJeETkSAXBy52/3hgXt8dJgpMlgYWo=;
 b=JAkBzJoUG0wqSwJOLM0gTJ4tjxr7riiu4RSzGAg5T3OR2rTn1V9CqNja+v+M8zP+gC
 LpCXItL5TsE761cJA9lchKjgJlBUYg1KoI7dI9tDJ9HMyzk5iH8v0JLLnfLu4gpnGUpU
 FMxF0zlLyX51EV3Ig20z4sohk61zZrNKAHx/ba1XDghGirIhnSc4uE+MHYdNkNG64RP2
 9WKtgMZ6tBPM4uuSjIOhmxVF2XMwg8x6R5Pl41jY8k7oLM2vXN3Kg4PmXbeJBQM3AsGb
 jL0eZcG3RPLrEVYE0vk4IzFhCi3lGERNu+ap2V15tyAW3D1PtfV4qL5fIXAY0sgCPWwb
 NWzA==
X-Gm-Message-State: AOJu0YzGXp3jJ0cbdIb3OD4BFJN8zx6qZgDxnmR2VNxz9CvgS9hIhNkw
 FEfDQKfTuFX80d8qiP9YQY+cK3ufVU+BaVS+vOcQyw==
X-Google-Smtp-Source: AGHT+IGnRNjP2S0uHtZoER7M1auV4ECVZ/JjR7r2sV411ydzivtl7IDkdZjtxMpwdQyRcn1bdIX8LQ==
X-Received: by 2002:a25:ac19:0:b0:d0b:fe82:8b99 with SMTP id
 w25-20020a25ac19000000b00d0bfe828b99mr13061917ybi.44.1692813014589; 
 Wed, 23 Aug 2023 10:50:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 203-20020a2501d4000000b00d4fc4132653sm2941303ybb.11.2023.08.23.10.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 10:50:14 -0700 (PDT)
Date: Wed, 23 Aug 2023 13:50:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] mmc: spl: select SPL_BLK for SPL_DM_MMC
Message-ID: <20230823175012.GW3953269@bill-the-cat>
References: <20230823154547.10711-1-oleksandr.suvorov@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZHjQjpk99e0E+rUW"
Content-Disposition: inline
In-Reply-To: <20230823154547.10711-1-oleksandr.suvorov@foundries.io>
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


--ZHjQjpk99e0E+rUW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 06:45:45PM +0300, Oleksandr Suvorov wrote:

> mmc_bind() in mmc-uclass.c calls blk_create_devicef() which is
> defined in blk-uclass.c, so SPL_BLK is required by SPL_DM_MMC.
> Implicitly select SPL_BLK for SPL_DM_MMC.
>=20
> Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--ZHjQjpk99e0E+rUW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmRtQACgkQFHw5/5Y0
tyyrkwv8CNmA9sqhfzM5xzr0pspIyGR1RyrWvn6GnDQ+iLX+qXzYVgtV9TScEr89
Jj7kRhVRAA/caxB6nvIGBaQS2p/0XsDiFY4TYlIRI2Sw/WSHgZM8zdrzsdIEpgxc
AHVsD/Eww/xaX1fwncns+q/aeWrbfI43CaVLioh80tgBL7Q0EkAHjlnYUDUwgP2v
tdfc2cw+Go58MAO4cLOjzV7+z/Ku0QiOB4/Ajmh16Qpz5z8+BSTP4wQfN4d0cp5I
KiEt13JSy40FA+lfY9EO/67sYobCGvgNF9rjalwriPxkJcMIkoWe4MgxjwF7S9QF
CCQYhvw2Czx5bibCF8mcCf1LLe1gSUA9CNRQexLmhXP6hYjFcK/sWjEbIAV0SI4R
b3rfMuGzpDLy8dfLUK7wVrWUsjeBBl1F+ppkMA3/ywJqvGcsV5Sl2DY2sX9B2jHS
dYwrMmRvIsYF7NGp/d8ZOLANe+PNb19sVtA0YTwa8ONPRev5DUlKadYQ0+mZhZCj
sgob6W07
=lXzb
-----END PGP SIGNATURE-----

--ZHjQjpk99e0E+rUW--
