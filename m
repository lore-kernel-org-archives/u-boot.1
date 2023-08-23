Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA3BEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 16:18:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 737F0864AD;
	Wed, 23 Aug 2023 18:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VZNT7yYG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BBAA86422; Wed, 23 Aug 2023 18:18:16 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 251B18648B
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:18:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-58c5642701fso62815077b3.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692807493; x=1693412293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=m8MfMIeqw9gv0japBCxf56trQfF3BsGdEEWnxZJskoQ=;
 b=VZNT7yYGFZxIK7tyOAdxi90IMke0i2bSfR3UCxwgP9zl7GsfN/Cnm0bpP2x/P1ZG1u
 XrLYVzecQ7/BzlXVYuuxR+J0D1+FMqqh48V9YrLoPRhZnEMe42y0DRaX/GU/0JeIleGX
 Be2oZaCnHRpmx4Qbk8uL/z5ru8TIeOTY61VUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692807493; x=1693412293;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m8MfMIeqw9gv0japBCxf56trQfF3BsGdEEWnxZJskoQ=;
 b=ev9JqdsO/kd2+6/YDoSqHPDao78XkwHAZVFd+YJPkqO3zZJJhhRDg+/H6xzwmpVND6
 QlAfcibG5OI5TtUw3hIOolvNduOQ3/L9rqqD3OqsKv8MOeN6NKO5y4S40kML+a4u8RuF
 BLp5XhOhRHmwflHIVEg/UFH3FuHE5736kNchh8VKdE5GSN0LwvV85s4hFhYPXwLm1kVk
 NorAkOluPQRaOiy9KW4zK2VN8P5THQuIB9ODjIz/3A4/1qS92JTvEDF6ovlN0j+jy1Sj
 dZn7LpkuYPTKeXhyEfQoECmCMi3zu4ULlledji9zD8r/v/Kxd0In/ooCIFu6QNAPNc19
 bVfA==
X-Gm-Message-State: AOJu0YxHsTnb5n+6orRoVkiDAbUIBG02xwqYbUEs1QGuPPlbIppkAqM4
 t476VpHSBMiukgKv6ZFQOs3xoGb48ByoreRpA3yJYw==
X-Google-Smtp-Source: AGHT+IEfBSFgKzJKccEJRQ5G606lN0BWLUdCefrmYN92KLzv7p7o/S/KkZZ6ICPAqwXc1aW77Xd8og==
X-Received: by 2002:a0d:c246:0:b0:56c:f68f:d824 with SMTP id
 e67-20020a0dc246000000b0056cf68fd824mr15054945ywd.45.1692807492846; 
 Wed, 23 Aug 2023 09:18:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 i194-20020a816dcb000000b0057042405e2csm3426603ywc.71.2023.08.23.09.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 09:18:12 -0700 (PDT)
Date: Wed, 23 Aug 2023 12:18:10 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Neha Francis <n-francis@ti.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Nishanth Menon <nm@ti.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Config fragments
Message-ID: <20230823161810.GN3953269@bill-the-cat>
References: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
 <40e50527-0408-da17-9d33-194f9b71366f@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="BcT2TrY6UssDfWHP"
Content-Disposition: inline
In-Reply-To: <40e50527-0408-da17-9d33-194f9b71366f@canonical.com>
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


--BcT2TrY6UssDfWHP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 05:57:13PM +0200, Heinrich Schuchardt wrote:
> On 23.08.23 17:30, Simon Glass wrote:
> > Hi,
> >=20
> > Up until 2023.04 it has been possible to build all the defconfigs but
> > with 2023.07 that changed. Tom mentioned this to me recently.
>=20
> Could you, please, explain why there are defconfig that can't be built. T=
he
> CI should have thrown an error in this case.
>=20
> Why don't we delete defconfigs that don't build?

What Simon is noting is that all of the defconfigs in configs/ are a
subset of all of the valid configurations of boards.

> > Up until 2023.04 we can enumerate all the board configs that can be
> > built. We can build any of them using a single name and a single
> > defconfig. The boards.cfg file which buildman creates contains a full
> > list of things that can be built.
> >=20
> >  From 2023.07 this changes and we now have random .config files
> > sprinkled about the place. I say random because they are not connected
> > to anything. For example, here is
> > board/ti/am62x/MAINTAINERS:
> >=20
> > AM62x BOARD
> > M: Dave Gerlach <d-gerlach@ti.com>
> > M: Tom Rini <trini@konsulko.com>
> > S: Maintained
> > F: board/ti/am62x/
> > F: include/configs/am62x_evm.h
> > F: configs/am62x_evm_r5_defconfig
> > F: configs/am62x_evm_a53_defconfig
> >=20
> > BEAGLEPLAY BOARD
> > M:     Nishanth Menon <nm@ti.com>
> > M:     Robert Nelson <robertcnelson@gmail.com>
> > M:     Tom Rini <trini@konsulko.com>
> > S:     Maintained
> > N:     beagleplay
> >=20
> > In most cases the MAINTAINERS file tells us about each board and until
> > [1] I had assumed that was the case. With that patch reverted, these
> > are the only 'orphaned' MAINTAINERS entries (buildman
> > --maintainer-check):
> >=20
> > WARNING: orphaned defconfig in board/armltd/vexpress64/MAINTAINERS
> > ending at line 8
> > WARNING: orphaned defconfig in board/google/veyron/MAINTAINERS ending a=
t line 44
> > WARNING: orphaned defconfig in
> > board/mikrotik/crs3xx-98dx3236/MAINTAINERS ending at line 7
> > WARNING: orphaned defconfig in board/st/common/MAINTAINERS ending at li=
ne 6
> > WARNING: orphaned defconfig in board/ti/am62x/MAINTAINERS ending at lin=
e 15
>=20
> Why should we care about the maintainer status when building a defconfig?

We care, for the currently disabled CI check, that all boards have a
listed maintainer.  This is disabled as it was broken by commit
e8da1da82f1e ("buildman: Handle the MAINTAINERS 'N' tag") but only
recently noticed.

--=20
Tom

--BcT2TrY6UssDfWHP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmMT8ACgkQFHw5/5Y0
tywjlwv/dH4DfRxzVvh593iZp5p6yPoPnHBJorJChnj0767M65UMHIZ2ghYTzK9/
O3eDHrDL1D8OED6KAyVo8xeN4OQ+lnsCf8dac1phL5SCCr5b5puYo0GGs+KXO18i
Gt8pVZ4UoMTzczoW3OvUgQEgIMBL2kkNNxC8tfzEnSeSOrfcpAYtEYzLibN9CBy9
LRmZVnaW4TTtrdEUKS6QT0U1Xd0RRGB1GgrSbwE7vG+mqoFoZaVkgOfpE9Deqe5y
XW8jiQ9Agp//mnjmqG3jmbR+FmyeWOd2ABCA6uIICGv75UF8MfubhRDEazbYWa4O
OCqZ8YN4BmZie+EEZgMvtog6fb3QNs9MExH9/KpqpAgjhDTxzaq1G9+hLZNvhn1z
dOFNY+kiLbMi2epU2WbWBk70UrCsgKtkWfZmZWVDwl9PRuRvbvV14pLVNcnPXxkt
/oT8weF0ZxPN1Deua+KJfCNMAvdrUmQBCqf8QM75DBNl3WK+BzeE31SbnOEzeBSi
dXAkAmmz
=UfaE
-----END PGP SIGNATURE-----

--BcT2TrY6UssDfWHP--
