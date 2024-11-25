Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5767BD59D71
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 21:29:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C21488937F;
	Mon, 25 Nov 2024 22:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BdKhvAYT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C202C894F0; Mon, 25 Nov 2024 22:28:54 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C3378937F
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 22:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6d849a93088so12362326d6.1
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 13:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732570131; x=1733174931; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xKzAlNgP1kNDhRuPoYsGlJwYz8dKH05UDHckFyYHirM=;
 b=BdKhvAYTK7zJ2dTushIvPLR5aVMhDA816eHgI5NBiKa6LyLzoihQAYAgV3SI+CR0Mu
 WoWeF+kUWfqOGWvvpz+MxQWjdGd4N/fkLTwhvaVqvGaK1u3YQBWGV3XKxN8rh9Tnd6Fs
 BjIdVCFY9GmYDQetOVR4XXiZCBmRc7sch0BJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732570131; x=1733174931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xKzAlNgP1kNDhRuPoYsGlJwYz8dKH05UDHckFyYHirM=;
 b=jOWm7Qtvlc29q/AkMTOvnfJF/9VXTv0wxZX86DI7zLaiFv+uBa7lAQT0hF6ExzNC8f
 ftbrjeG0tOgQ9KrI36cIT9Tenjj1VADPH65hE989oqgCUE8SvggZfOBqB3SoFIw74bYX
 dgk5fsORs4Ezy+zR72auCfU8VZ2R7PluIsutbWUyrOSl5DMqBKX1svwo6OdQ5asJA5R3
 pe6w1NwNvLBM5VhXgiWVdmW+B05fthXV5hbKrjIyd6HdevH5b+eChJpnapIuaJDaD5Js
 ty5/+J09km41Oj6q5t1gYtVG+xhrcVDj23Tp1gYzl6hmI7zDyaO3M2vayFxz+hunrRaZ
 CbAg==
X-Gm-Message-State: AOJu0YwhDh2vg2is8cOnyFtuorJ64fM1+4mNiliarXC64G8O1HzhHuO4
 VYyh0GHHkvmZEJBQGwvrM2oFPmMvZ0Y7/idIh92Hl/F2APC2Bd5xACLpArDDROo=
X-Gm-Gg: ASbGncuApXTjq5CZIEnOdOOqfbHE4Nf/Nl3Si2iF5NylUWgUJUiLwwWBL/P3Bm08jrG
 4PmifO9/R31kVY9aF2bQ2id6kN6tvQMc8gDzDMvH5iZBWnFJ39KbgPdEqSKypx0rY3DfKjB/1ZL
 YzSERD7hd81tblogN2Gniah/Wt9woFN+zW3J6wsJk6i2Wmc8oKPQp0qPGn2uh1gU35y7IuPERdw
 8NYTzwx1q5zovheTvtFDbUrq6LZK6iGeeyk5A+ENjChh2uJzg==
X-Google-Smtp-Source: AGHT+IFMRNwfIlaHKfBBaUyJQ1l4SDb99FFKzmckVufWdCj4zO5PpHlBb62E2F7pl7YCLgp+Vefedg==
X-Received: by 2002:ad4:5ca7:0:b0:6cb:ee89:9982 with SMTP id
 6a1803df08f44-6d451373828mr267258506d6.38.1732570131448; 
 Mon, 25 Nov 2024 13:28:51 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d451b4a11dsm47450666d6.102.2024.11.25.13.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 13:28:51 -0800 (PST)
Date: Mon, 25 Nov 2024 15:28:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PULL] u-boot-usb/master
Message-ID: <20241125212848.GM3600562@bill-the-cat>
References: <20241125180907.11213-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S9btvU5c7AzIM1DU"
Content-Disposition: inline
In-Reply-To: <20241125180907.11213-1-marex@denx.de>
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


--S9btvU5c7AzIM1DU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 07:09:00PM +0100, Marek Vasut wrote:

> The following changes since commit 52c0e5f8a39ef022ee5ab2dfd67661d1d34941=
c7:
>=20
>   Merge branch '2024-11-22-assorted-fixes' (2024-11-22 15:04:54 -0600)
>=20
> are available in the Git repository at:
>=20
>   git://source.denx.de/u-boot-usb.git master
>=20
> for you to fetch changes up to 57e30b09fcfc88da72c310f979b35ed99a9b277c:
>=20
>   usb: onboard-hub: Bail out if peer hub is already probed (2024-11-25 05=
:40:49 +0100)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--S9btvU5c7AzIM1DU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdE7AgACgkQFHw5/5Y0
tyzVNwwAgwQIUNEsexNPHzj8db4TUX5yLYrd8txfclBhehwczMkSbjF+pYPrUFO9
+SLvHAc+wB/1tHAp6jFKZKi7AtfiLwqlMNdsE0Diz2sEWeNYX6QFe45/rY1Bx1dZ
XtTiyTvZ9j+GPQ89lFkgzHQ73nFp4ZUXPthUepNKpzqbRgFrMHpe54/lShGpz1Lt
mWxW7qxO2IN9+ursynlbwDJw0zYEnI5Wcty2joHJtQljb0d+oY4lNL7yfLoe1eAr
YUY/IrIw0ZKsrpJPMIz6HyHMyLH61wtP3jpNZWVZopqaxhWGK1uwFXSsSnUu9AGG
ssIgXZYxmJAuf26YsplrOPvP0I27EXDya4AScI3bHSFYM8yG/pv7TcAePuyAoaXK
w4epN9Qif1ioPl8Zlfoz4N9a212uSzKheMGo2x1m3hTfBrPFuh2dTDa14rX6BIkH
TkzIzPqlNiklvPn2k+hJmgW3+sxSYv6LlQg2f9pnYH4Ga+jjmzhE8wOZSZjbQfG+
xGsa04Oh
=fXoI
-----END PGP SIGNATURE-----

--S9btvU5c7AzIM1DU--
