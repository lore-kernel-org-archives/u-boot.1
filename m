Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C48C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 16:24:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA4388883;
	Mon, 22 Apr 2024 18:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qoe1CPGr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9E4188886; Mon, 22 Apr 2024 18:24:24 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863D28880F
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 18:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78edc3e80e6so330287285a.2
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 09:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713803061; x=1714407861; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=frW1UdW4LqYTZ8sjDN9GMyr94hTkJrvYr3oe7i3mUT0=;
 b=Qoe1CPGrT7BZ4g6m+Wt1CCbq8ssSOxC+YpSwJzALOh5wnV5cHSajZXCy7AEyab8oOA
 VH+LS9FSNWj1LbHrcRZQiJcB9J8FxVcfNFYsaxOf6VkipfGGE2RwpV2UR2fL1tyaDSC/
 hD4meKZZKEOBavDQSZTNRiI7iu4m+tKrojSj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713803061; x=1714407861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frW1UdW4LqYTZ8sjDN9GMyr94hTkJrvYr3oe7i3mUT0=;
 b=Hi2elpJXJ/SucDhGHcLSC6GTn8A6zVgMgVowA2MFS4Ws+ZXMxucB69VWy9x8TzrmX0
 Lah4pXHdKqGXIW8ZHvf9Rv1p0PebBoDr6j67hpVyOlA8wMC3oh5SerFCQWYZkEd3t5sg
 ErRTpb4yXoM0vAcwAsZqHiIe2jXZJE2s3AT3cxPd2vJWZqqWpKrHeaSsw+vQyM9mr1BM
 atNdyJ6+gHKaHjcy1V8OwCq2e2hhU/lGLa5MCIR6glV02frWC52VwusZ3rogoP7B6C2Y
 OX0q5GLidizBG3KMRNPvcb+EeOZ4xjTdongoijP41wsY7yN+ARsa+ekes/hpABXogAQu
 OaRg==
X-Gm-Message-State: AOJu0YwfKab+4cgn2rF5z3/mruCUKpQ6BuCdOWnVGpETFcbv2PrwdWUb
 mHBN+lINtYa9uFuWsa6zMwbKhz+VUb+swnY5S4odtabGF+Eoyk8BgXoTzUDVeAQ=
X-Google-Smtp-Source: AGHT+IGdYm1H/vD2u7JVUZyUrkLLvWDMxWTOnNOw8f1I0i9CF3wn9mMlgvXIOHz6MZ6oefR7kACjcw==
X-Received: by 2002:a05:620a:28d5:b0:790:7da0:4b7f with SMTP id
 l21-20020a05620a28d500b007907da04b7fmr1538640qkp.32.1713803061334; 
 Mon, 22 Apr 2024 09:24:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a05620a110800b0078d76c1178esm4440323qkk.119.2024.04.22.09.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 09:24:20 -0700 (PDT)
Date: Mon, 22 Apr 2024 10:24:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Please pull u-boot-tegra staging
Message-ID: <20240422162418.GU1054907@bill-the-cat>
References: <20240422121502.213680-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PFjK5IZPHqiXnWjs"
Content-Disposition: inline
In-Reply-To: <20240422121502.213680-1-clamor95@gmail.com>
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


--PFjK5IZPHqiXnWjs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 03:15:02PM +0300, Svyatoslav Ryhel wrote:

> Dear Tom,
>=20
> The following changes since commit 1dd659fd626204bb6a6b4f330c27b11a7823bb=
b0:
>=20
>   Merge tag 'video-20240421' of https://source.denx.de/u-boot/custodians/=
u-boot-video (2024-04-21 08:54:20 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
>=20
> for you to fetch changes up to 6898cc823413ff01661e7db74ad764da58b682d9:
>=20
>   board: tegra30: switch to button cmd (2024-04-22 12:17:21 +0300)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--PFjK5IZPHqiXnWjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYmjysACgkQFHw5/5Y0
tyxtXQv7BcUPq205uYnq059DTO2EtRgnidDqJ3z3k/b7Ho/7YN3Ii93i9e36+NCx
sttiDyzWEv9tsBAMJFb2/DdSXdKsOXD5OzoBqbns6jToJgkbmYpdn+lGa4MFr2yw
CdDMFryXkRCX5nU5I0cmqSd4pYAtJXLMg+575wfLuBL6HmnoB+YffeHkIzpvhez/
PltKQ7g16xhM8wHXCgW6yzFQuclFiMLzm9JADFnboZGUY54KytthCfmmB8EDufTz
3vtYil9QghQDETSargszCmQtLhWA3HiwqGzVJ5kHPDnQxzm5T7HsNMOjSta1vTmq
HJYr7kSzNRjhbmJDqyMKvDuEwwBoPFRTOd8/LUWfikvSEop4v6AXlP/289l+9Hbe
PgjmwZ32S9WOVJsFcrBYJkBd9IU7Khk+mM52y14pIK5pucPeOze0OhP2aWExa2/5
QMeiz1nKc/JMzA0LYv4XxAsRoAyo886A5Isl3D7avlHExxO5e395O6Zy+fI/s8kg
gi6LrLyd
=QOoc
-----END PGP SIGNATURE-----

--PFjK5IZPHqiXnWjs--
