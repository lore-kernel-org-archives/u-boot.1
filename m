Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3466AE77188
	for <u-boot@archiver.kernel.org>; Wed,  8 Jan 2025 16:57:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63E73800DF;
	Wed,  8 Jan 2025 17:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k4WV3a+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 008378036B; Wed,  8 Jan 2025 17:57:52 +0100 (CET)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B36A58006D
 for <u-boot@lists.denx.de>; Wed,  8 Jan 2025 17:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b6e5ee6ac7so224185a.0
 for <u-boot@lists.denx.de>; Wed, 08 Jan 2025 08:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736355468; x=1736960268; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VPI2XRQRb0ORBA4v/I7pPxMESyM873YGMyAAAyIJikQ=;
 b=k4WV3a+5t/yjXcoufTwut2R0UXpj9sU75hzn6LOq/Hx3ZceQbNI7AgxWmYsX2OCTrx
 TVBaRScGhK72toGGzVJJmLnajA8X+soHpUUizcg2Q/imuY/CVd/yIC4VeR2X/gyqKbgn
 nlTyDTMf1A0gudnArfazf1sVFVnPNae4VTj+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736355468; x=1736960268;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPI2XRQRb0ORBA4v/I7pPxMESyM873YGMyAAAyIJikQ=;
 b=aNs4vvy2r46WMJyS5liPL2VyGPAKvjzWBGQhG3AWMqYGMilS/9ItfRIvJV5VmPvv0E
 uFmreRcE1f/GKZuRUHhZQqOWvpXXO0xQYLAo8OW1JJP6j9wRx4sUW403M2d+Lp/yTwKE
 BrQS0i1/FfC6MGvKSNx0oBMSHBXXnIz3lfnarVFqkZdLalwL3iDGm6vfsl31n3xX2sUs
 SF6gcSTIYcN7QTNj2RAYF7GQk2OIQhVHm0rd25YJXKUROVnOuH41GGHrcc7a8VKt1pCI
 s8SPcM8hEKjbT5JpHqbvFsPMyh1d9hMZ/VxQq2NEkJ9tRz5p5Nr2EN8OeeNFqqzDhGQj
 OrKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG0kqTipOHCEttwjk9niasPDUh7Kz8qiGDSNXmQO/elriTGOprXMidIFX8j8au7aiFl1ZnDgA=@lists.denx.de
X-Gm-Message-State: AOJu0YxIzsSPnc/ZQsvV1ESJJnFVg/t+i4pw+HzzFfetyWuYVRUrMwPn
 2xKsOMLYpaSg7KMcck3uXipcDknpAXDufmKlqgiZR2gPcGp2O8wxIQWSU9TYhms=
X-Gm-Gg: ASbGncsYSgeOI3nY5jTpE4Kjv5lmJRWNkOKCrVeWm5MIFcxuUDalEWjvfZIemJyHnRL
 DhAL3xE4MjZj7GwB9TCc1pbwdWznRopdy2mSZW3AjQ5SuZsDnMOSrkd7nq7+mjURqj328jAdXQc
 lRVGDY7SPmPRG/IJu5y+0pTrX1Ve63vfBxGd+K4L77P+Xkj5YKQvxkJSSu0naK93ZLE3iTShlay
 JbhBuLf7nfy3EeUdX6VwlbfMrqPVNjnkMW/hiiMVKpMDIedo7OyH9s=
X-Google-Smtp-Source: AGHT+IGkETAtVf+UVdGWLr6lKHmbX6eiOE1vRdq0le89v4MomULp+oVXQQMBXOzPMI7HK3eXURilzA==
X-Received: by 2002:a05:620a:2552:b0:7b6:c673:7427 with SMTP id
 af79cd13be357-7bcd97b87d4mr444951385a.59.1736355468576; 
 Wed, 08 Jan 2025 08:57:48 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2bc18dsm1691165485a.22.2025.01.08.08.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 08:57:47 -0800 (PST)
Date: Wed, 8 Jan 2025 10:57:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: "Andrew F . Davis" <afd@ti.com>, Hong Guan <hguan@ti.com>,
 Paul Kocialkowski <contact@paulk.fr>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [RFC PATCH] am335x* defconfig: Increase u-boot partition in
 mtdparts
Message-ID: <20250108165744.GJ3476@bill-the-cat>
References: <20250107225055.592941-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1c0GpNVQcj4nWB7h"
Content-Disposition: inline
In-Reply-To: <20250107225055.592941-1-jm@ti.com>
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


--1c0GpNVQcj4nWB7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2025 at 04:50:55PM -0600, Judith Mendez wrote:

> From: Hong Guan <hguan@ti.com>
>=20
> Fix u-boot NAND partition in MTDPARTS_DEFAULT since the size
> of u-boot image has grown beyond 1MB and no longer fits in 1MB
> NAND partition, thus we are failing to flash and boot via GPMC
> NAND.
>=20
> Increase the size of NAND.u-boot to 2MB since the size of
> u-boot.img is currently 1.4M.
>=20
> Signed-off-by: Hong Guan <hguan@ti.com>
> [Judith: extend fix to HS defconfigs and add commit msg]
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
> This patch is marked RFC to understand if solution is acceptable
> since changing partition sizes will not be backwards compatible
> solution.
>=20
> One other solution was too try to reduce the size of u-boot proper,
> but removing features (boot modes.. etc) did not seem to get the
> size of u-boot proper to 1MB with a usable u-boot proper.

So the big problem here is that we have more space being taken up by
device trees than U-Boot itself. A quick mkimage -l and adding things up
shows that we have 851936 bytes of device trees. You should look at
switching to MULTI_DTB_FIT and enabling some compression, along with
possibly LTO of U-Boot itself.

--=20
Tom

--1c0GpNVQcj4nWB7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd+roUACgkQFHw5/5Y0
tyzUZAwAsDVpWgW14Pl/3mBEx2vu17gN93igxPLXT7qp9WYhJHd5esYlnUSaukdn
BjVfHJ611gbyDzgtRP2abiNHIu53XqfebcDTp+ovbKKiSsD3mMw577WgJFE45ag6
QF/3IJOs3JPggJyo0eIxLtpkZLLJUz3yu/pF4qJidx1t4wnG6mVPCVIem+7nWSGP
XhQ75l8jqf8L9DZAqrEuh+5oKEgvqUhXaP/TMzMoM8L4TVSsCAz/TTa9VWqG1TEB
6kRE8x0Y7/5o1h3Mt13vhEWx1bFGeGIU5nJmCCuizyIsHn44W+JQQVD2IXqS2ile
TKXIpbTW+Bsfor8IuskUW0yMTHlaSLL026T4y2kNQSkfbscRU3dfNf5Pu4pQ/HD0
r/DrF8J4RBoPvcnHaui6wzzfh5gn+r0iPTN2usPfZVheO2zMPOHGJZtC35UIIYZB
7eXmriHX1FF14+oqFtHPJbrO4rd6Kersb45lsi97wMM/fxGY0P5/MSg2hw7/umuk
fdaZD59h
=ulct
-----END PGP SIGNATURE-----

--1c0GpNVQcj4nWB7h--
