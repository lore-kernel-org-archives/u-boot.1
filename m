Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66418FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 14:33:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45A7580433;
	Thu, 30 Apr 2026 16:33:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ArF07a1K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26074803C6; Thu, 30 Apr 2026 16:33:34 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 016B280433
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 16:33:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso535789a34.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777559610; x=1778164410; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4Er3H5d6P7qgVF59QvMxTBjDAsg4gdZFergMqym91jE=;
 b=ArF07a1KPi0yMtiHJWFoP62VHkllT8eqoxsrIKZ0ijl0/ONSxBHPtnvJWQ78tfss2R
 RMCV49FfP9dx8vOK1peuTYENYOs/KBXNGddndQUb9X3L1plY7PQ3vmWN3lTRwcBL8ALy
 qnJXZkQk8JgoF3jjtplZncrpAdCrV8SpHP+40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777559610; x=1778164410;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4Er3H5d6P7qgVF59QvMxTBjDAsg4gdZFergMqym91jE=;
 b=nLYg3WzxFDYadtHHF+vWDc4xUF+J0Nif95N+IZoy4mhOs5NAlB2hE3s1Y28c20UKt2
 fA2KBnA0O1alJ6aHKrSdAASDJ39uix3QXwPCftcIKeJg0XYqGYsjGYTSPBWMdiWxb9MF
 LWtke4c/JCI/7U5TrlcigeG3oAf4ct1pDomX9Pru3nBBX2C8dA0O7lcxBW9MPBt25pfs
 nVxsYDcUDo7CF4obweCEQIBAj3Vs9nWAtCq09tg3oFDaovaNylrsTG1/qYC+PhUO/HCL
 n60asV/eF9e4PC9+4xSdHRsql/yTX7aEB04B55pA/alhsl+v8o7uGrrVCZUIuAjbuH3A
 HQVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9joDIKjCYfYyLZh7ulaSAkH16jjCf5VpANpGZoOSpCfTVktihIuCgqZrjLhqT1DMbq/mcWWX4=@lists.denx.de
X-Gm-Message-State: AOJu0YwYoTurbyfAETL4GZb8xPz0AxBuHMvZV2EsS1Mn3qt8Gfis8QqE
 QPC+e5cnOtW/y/EwusiFWfNKbAHU5RpzV2U7Ef9d+QkhtCUQ3W7ZWdRItuVC/BbzXXc=
X-Gm-Gg: AeBDietzxc/TsjX+Rg2khPnetDJwgdd4TX0/SPXma1pINJgQPbMPqFlslSX3KAl8NzK
 mVeNOlJDH0kbjgimdNhqj4IDOHHoIIBkEfVM/Ywqk/rZrmr7eK7Vw0YeEmf9+d3wiVQBftPDtKy
 L78LNY8Fs9/U1NQtTW5BwoMtHbXBuyuWYmCopZwfhAnRxuBO5A/1rEn4kUmEvrJfjBzbnI9Xwfw
 jQyAZ4460UsqpTuMKBLs2Alsb3/3e+j+KZiaALAThDaoHid4RHeDaqzGYWPwLTUxiJ5oirkTvzl
 oXxQm2Zk50R62AfPvMWFzX2CH3KIHR7hZh1sIdvaQwyE4IqoSJY8RpIjCSmgT0ocD2I1+kuqw+K
 l1NLGDOFm9G55V+//svno6j/2EHKPfA3od0QofXO7AjSTVfu/KUeQ/qRPFrRqNWKDuKHh85oqgc
 rzVUIbc0pgacvaHW9wzcKVPvBBuMRUoolFp81+Ilu8qLZdq09B4se53o7vQR6f0fW7fY2ZjNicW
 qqocUPNEKqC5AXMxRx5SIrG+CGp0RVkXaQNFYEtoqdzS6g4Mkbw+eSotFnpsg==
X-Received: by 2002:a05:6830:6008:b0:7de:44a5:51ea with SMTP id
 46e09a7af769-7deba07072emr1759942a34.6.1777559610488; 
 Thu, 30 Apr 2026 07:33:30 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decac26313sm15740a34.14.2026.04.30.07.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 07:33:29 -0700 (PDT)
Date: Thu, 30 Apr 2026 08:33:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Yao Zi <me@ziyao.cc>, Conor Dooley <conor@kernel.org>,
 Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de,
 uboot@riscstar.com, u-boot-spacemit@groups.io,
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org
Subject: Re: [PATCH 04/16] dts: k1: import pinctrl dts file from upstream
 folder
Message-ID: <20260430143326.GA1614990@bill-the-cat>
References: <20260422143112.1329478-1-raymondmaoca@gmail.com>
 <20260422143112.1329478-5-raymondmaoca@gmail.com>
 <20260429-glare-anybody-16c98d01184e@spud> <afKvzj0yoJ85-5VI@pie>
 <6562F314-D379-42C4-8371-0184E48B8592@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rIvcGXLcDd4D8miE"
Content-Disposition: inline
In-Reply-To: <6562F314-D379-42C4-8371-0184E48B8592@gmx.de>
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


--rIvcGXLcDd4D8miE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 07:21:58AM +0200, Heinrich Schuchardt wrote:
> Am 30. April 2026 03:26:38 MESZ schrieb Yao Zi <me@ziyao.cc>:
> >On Wed, Apr 29, 2026 at 08:48:39PM +0100, Conor Dooley wrote:
> >> On Wed, Apr 22, 2026 at 10:31:00AM -0400, Raymond Mao wrote:
> >> > From: Raymond Mao <raymond.mao@riscstar.com>
> >> >=20
> >> > Import k1-pinctrl.dtsi from upstream folder.
> >>=20
> >> Why doesn't the platform just use the upstream dts directly?
> >
> >AFAIK, U-Boot's reset driver for SpacemiT K1 predates land of the
> >kernel side driver, and follows a complete different (and to me,
> >broken since it combines completely unrelated MMIO regions) ABI.
>=20
> Shouldn't we first correct the reset drivers and switch to the upstream k=
ernel device-tree before adding anything new? - This would reduce future re=
work.

Exactly. That's a condition of bringing stuff in to U-Boot before it's
accepted to the kernel. It *must* be updated once the kernel folks have
provided feedback, we do not diverge.

--=20
Tom

--rIvcGXLcDd4D8miE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCafNoMwAKCRAr4qD1Cr/k
ClEXAPwKLs7R7X3R+k5NNRzG2p1ZEnyiD6bXcZMXdShFTidn2wD/UmjXo71fAXvs
tUvU45rw6Q7jO4boaoVcW1crgKhzUgY=
=fTAs
-----END PGP SIGNATURE-----

--rIvcGXLcDd4D8miE--
