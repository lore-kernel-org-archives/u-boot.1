Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D86BCCD193
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 21:08:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 479A583303;
	Wed, 15 Oct 2025 23:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OWF7L62P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C648C833F6; Wed, 15 Oct 2025 23:08:19 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A193E8323A
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 23:08:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-43f8116a130so36462b6e.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 14:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760562496; x=1761167296; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+/dX+qlF0IifWoy+Odq8JJ9ALbdzR4g11K0YAeUeHuU=;
 b=OWF7L62P9txocQ07dfQiZtav1y7C25Pk8YTWRkoFyf22K7egZrqPqWFhFiaFVgOVS+
 8+DgYyf5iF8pUcJJUZ5ziMfvEGnhHUzrEm32SrxZXNRCa29wepz/jESz1TT/lEh53QNO
 kVSrR7BZbYgA8lCxX0dJAmKRd5o1bH/jwg5l8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760562496; x=1761167296;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/dX+qlF0IifWoy+Odq8JJ9ALbdzR4g11K0YAeUeHuU=;
 b=K3Lx9gdS0HrU34CkzBvM1mVouUtIJG37L9icWgREcGf95odqiru3FErpfDKSKC2slW
 JXx4q+BiVatrSB0ajC+xqBB2FTnlxVVcCcFaZVvmgQbNMQ7GsIKxOfGeszl3TiPbGVb/
 AxGzCu8M//WpOVFtUuOdnwCqS2O4tW8mO8NojhJJmX1Rzxv0g1bD74uakU8DSd38cUqj
 o/UNNZ6TfnnhY4ZyXOMO27jE3L8O4g1WX4AFk+FobnMKqLjjm5KEKqoDnZowLErrfPmQ
 bGIFSdEGVjnNsaBjSjpWFpYG14jeNJvFLP4BrYIyiSt0EjBnmp8RWa+TG/Se7NwLA62Z
 9H9g==
X-Gm-Message-State: AOJu0YzRQlS/tstNKH3rljUR+cA3PpfszMmyD+bddcHKOkCP1ea6icqv
 qeByWumNnpExSaXASNd8hHu4p4TSMWGRSG4r/SF3L2QMJTngVHKd3pW6+vX7o43W/G1HhgmA4Rv
 uibjjMPY=
X-Gm-Gg: ASbGncvAG8cTd5Fl32sLbq7pZL65D6MHpOLFkkhNfm0W+Ek/C80xPsxPFiydp8+WbKk
 i+lRn7NLYrvxeUwkalH3y6kfTmGyQNHWY3bWsGNgghWSXetGZNfSFK4Y6KKfkYMzKpa70xZmcc4
 sI1AEteptKEvV9s0h0fAfHeNKW7CDwefTa/gniETMrcBUQaaNNpZ4XJC0Hdxl8L2CDdwz7zDrRn
 iaokC0FKfOlfnKdWsnsKFa4C3D5YP7008yScNUcWFi5I7rdHZE0dBRTY7dmG2xpskbEExP0QsdM
 0HpfZStT1V1mWhLi/9uyMC06NQnFGu6fy9sY7sf+QUbfRTanxeYFE154tuLGbvHmHvlw+Exp9EQ
 EK56Y13krPFutp+36rPaxxHpRZeSwlE/1U0Kfne0owcMicsGINaOMo1XKj5eunBaxj20LGkP/Yo
 UPribzFO3HPxuyywg+PRmMJL75Usqz9rrKI/vW4Zs=
X-Google-Smtp-Source: AGHT+IGi2pKkJZ2nNlJP18zyY9Gr4G8bHxzPIsxYJRKhLZfui+JNy0DdMLl//7XyaYp0tQdA+hbgrA==
X-Received: by 2002:a05:6808:200f:b0:438:3b96:7cf9 with SMTP id
 5614622812f47-4417b2fa9bdmr13723428b6e.15.1760562496298; 
 Wed, 15 Oct 2025 14:08:16 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c0f911af78sm5689229a34.29.2025.10.15.14.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 14:08:15 -0700 (PDT)
Date: Wed, 15 Oct 2025 15:08:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] gpio: search gpio-line-names property in
 dm_gpio_lookup_name
Message-ID: <20251015210812.GA748494@bill-the-cat>
References: <20251007102637.792524-1-ravi@prevas.dk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1eHUrsFhGkIHrLCn"
Content-Disposition: inline
In-Reply-To: <20251007102637.792524-1-ravi@prevas.dk>
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


--1eHUrsFhGkIHrLCn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 07, 2025 at 12:26:37PM +0200, Rasmus Villemoes wrote:

> In scripts as well as interactively, it's much nicer to be able to
> refer to GPIOs via their names defined in the device tree property
> "gpio-line-names", instead of the rather opaque names derived from the
> bank name with a _xx suffix. E.g.
>=20
>   gpio read factory_reset FACTORY_RESET
>   if test $factory_reset =3D 1 ; then ...
>=20
> versus
>=20
>   gpio read factory_reset gpio@481ac000_16
>   if test $factory_reset =3D 1 ; then ...
>=20
> This is also consistent with the move on the linux/userspace side towards
> using line names instead of legacy chip+offset or the even more legacy
> global gpio numbering in sysfs.
>=20
> As this seems to only add about ~50 bytes of code to U-Boot proper,
> and dm_gpio_lookup_name() most often ends up being GC'ed for SPL, so
> adds no overhead there, adding yet another config knob (or two, if it
> also needed an SPL variant) for this does not seem warranted.
>=20
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>

On a few platforms we now get a failure to build:
       arm:  +   work_92105
+(work_92105) arm-linux-gnueabi-ld: drivers/gpio/gpio-uclass.o: in function=
 `dev_read_stringlist_search':
+(work_92105) include/dm/read.h:1078:(.text.dm_gpio_lookup_name+0x8c): unde=
fined reference to `ofnode_stringlist_search'
+(work_92105) make[1]: *** [Makefile:2029: u-boot] Error 1
+(work_92105) make: *** [Makefile:198: sub-make] Error 2

--=20
Tom

--1eHUrsFhGkIHrLCn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPANOQAKCRAr4qD1Cr/k
CiHjAP44TDPRrLKHoS7sh/NGWhnJA9UJBNTbuIOmIYnlxVql/AD9F+pIvuuvbQf+
CU0ZRs14uk8D1NDBeZEIyAYscA6AzQU=
=Qrb+
-----END PGP SIGNATURE-----

--1eHUrsFhGkIHrLCn--
