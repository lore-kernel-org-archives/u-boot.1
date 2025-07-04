Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84A8C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:31:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFE4D8206E;
	Fri,  4 Jul 2025 15:31:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ldGIf94h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91A3A8277D; Fri,  4 Jul 2025 15:31:12 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66D02803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:31:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2ef60dbaefbso815989fac.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751635869; x=1752240669; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kRlvhbTi+fO0GG7iWNPR4jgp1BJIrfXieqjb6d5Y7Qg=;
 b=ldGIf94hROmGgc/8MYuZ4ymohjQxSiapBPu/TwtFoee81B5/Iwd3jt7PTZNuWZ47eQ
 yhyX8sIX2QPUM+Y/tU5SS5FC0LxKUZQoXOj3mTkjxqSOKSaHhapeRgNXQg7AhrcRImP5
 pRgEZ5w6hFnXAcMSbN7bnt9TbghfRBo5FrLdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751635869; x=1752240669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRlvhbTi+fO0GG7iWNPR4jgp1BJIrfXieqjb6d5Y7Qg=;
 b=mNw6I3H5B75MAUwdKzCMcGKl/HkMbbXw1W0v4D+byRCPGxEhvSF2zImHx+GinLpVHX
 d9iou/QpbdNakJmOryzofUUQjhFxBdUgwcNVdzYiLgItjCzHW98Tjx9ygrqwclNei1BO
 HfXFp7qys6GUC0fgfSe4LoK5eIcoAUl6B03020HlTIoEUw9ZEnVkPtgdpdofQDPDf/Cd
 pr59XVFJPdIXFqbToaH7qBcpZG1iedGuAbbXz6Zqlf0P2fcQ/y1zhQkXeT6gCkm6YOxH
 MZ8a1XS+FhZSNVeRWNFPPjv8Yp0Xs+pdMLWb3nw9aM9Mpcgf7y+QSXHZEaDUmyemtv3J
 xf/w==
X-Gm-Message-State: AOJu0Ywd49mzDmOgG2jpiXsEiylWaPvZF+H5dsprsvNZ8fRjFCXBu2sg
 SD85XebqHxRSTC+66W/WzRti4wa0rG7veukGGpNp/eRgsVyevBhJ9zo17sY2Q1hSGkI=
X-Gm-Gg: ASbGnctcFE0TZKBHdNo+x22hqc7avyrKAK+u6SOMOHKSxHKh+0+5OVsDLPmWqZg3KqT
 XcT2t3tgXYwvo7TAtpxN304ATnjdVMZNVHVUFN5ahZ6V4GMMh/bSDUNm8OiEzGYLFYP/+GI3qtZ
 Ai8U9D4xWE6MSEvCeiuMHDRgN7XYFAEDYA/rvQVxS4o5XBKWRdLIpYibTv3eD7WuAKGlzBOyngi
 //TJbvQKF+88U70XLvF8neCBXzgk68tuQ8++yHkL/rUZlg+tnQO75VpfRcc/UHDfB3Oqh7u/Lru
 X93RXvACf56IOaoD6qhk14xo5sayc3/ojtv8bFPQOiAkreBswWTYsrMWCWTjaNOwXdiS/1wgWQd
 53EMDtoTbAOvvSuw48hrx
X-Google-Smtp-Source: AGHT+IEkpDvufdgA4RH0iCcROpSHteswz0m8VEICehS/VlYxLHaTZ6cVAB+YC6sTvOe1mOBGmqmM1w==
X-Received: by 2002:a05:6871:1d6:b0:29e:65ed:5c70 with SMTP id
 586e51a60fabf-2f792013cb8mr2249060fac.30.1751635869092; 
 Fri, 04 Jul 2025 06:31:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f79020d17csm511070fac.34.2025.07.04.06.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 06:31:07 -0700 (PDT)
Date: Fri, 4 Jul 2025 07:31:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org,
 otavio@ossystems.com.br, michael@amarulasolutions.com, uboot-imx@nxp.com
Subject: Re: [PATCH] mx6sabresd: Increase CONFIG_ENV_OFFSET to fix boot
 regression
Message-ID: <20250704133105.GD6424@bill-the-cat>
References: <20250704130319.3814676-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y1QR3cb5HxX1BPlm"
Content-Disposition: inline
In-Reply-To: <20250704130319.3814676-1-festevam@gmail.com>
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


--Y1QR3cb5HxX1BPlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 10:03:19AM -0300, Fabio Estevam wrote:

> The CONFIG_ENV_OFFSET value is too low and the imx6dl sabresd board
> no longer boots.
>=20
> There have been attempts to increase CONFIG_ENV_OFFSET in the past, but
> the suggestion was to enable LTO, which worked well for some time.
>=20
> Give more room to CONFIG_ENV_OFFSET so that the board can boot again.
>=20
> Adjust the CONFIG_BOARD_SIZE_LIMIT to take this into account:
>=20
> CONFIG_BOARD_SIZE_LIMIT =3D CONFIG_BOARD_SIZE_LIMIT - 69k =3D 9779920
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  configs/mx6sabresd_defconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

If we correct the size limit for where the environment is today and
switch to CONFIG_MULTI_DTB_FIT_LZO do we fit within the limits again? We
could likely save a little space too by dropping PLAN9 and RTEMS bootm
support and seeing if we really need CONFIG_MMC_VERBOSE as well.

--=20
Tom

--Y1QR3cb5HxX1BPlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhn15IACgkQFHw5/5Y0
tyx0WQv+NeHGwF2qapeEgpQnkzeKS1MeMrSUfNwrsA/Z7HCeVdSaNxQFCcdPC7fH
sSaEDHZJHfl+URAjGgrP1KMKRsFAZdiaN/upMEOPWUcW/Oz5wJBAQdFGRdIhCmeu
v3giTiK8DFP5rpBMa58KSjDb3VApPPT2EM5LCtasOu0blqdNjZWCUbwq6aBxpiZe
Dd9FeEviP3MEbTmYbZxNYnubmARpo/Q8j6D/kgHTjnMjTeFBXI0fuHvtygZVbV5A
KNWhWMRCqe9sgzc6498ATV3dGJ7YA+HQowtGBrlD9exiqFte/lJr6dFRYJMlL10f
tvLCBObiViBTDIXaSw77ZMk2HcmFMxKuXwuxHKdwa9X6s/RNho4P7fYYGBVWsTXA
TCIJXzHfDI/IqmLrHj5wMK2ItkvFVvnTbLw7B+pvbKWLYCBxLa4PwM7kaysnjsox
5JakQU2zvXeLJYRq63XBvgNxrEybBYUqe/VmLsmcmZpicWuVqBaV817HmkM5mOht
Z68J1G4G
=5cp/
-----END PGP SIGNATURE-----

--Y1QR3cb5HxX1BPlm--
