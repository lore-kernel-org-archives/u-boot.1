Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0510C27C79
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 14:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F24888845A;
	Thu, 20 Jun 2024 16:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sQskJ5Ra";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4731188537; Thu, 20 Jun 2024 16:23:44 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C424C8840F
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-25c9af0102cso487262fac.0
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 07:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718893420; x=1719498220; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UoG1wjxd3HnFQjYcPWyzBpGO7LRYWr+0ObPGsZKsEKc=;
 b=sQskJ5Ra6RA6jtum5I6MK5G9ezvQpGjDZsi6uVuXrqujqUTy2cUvYF/rIR/BqssI37
 0VSUzduQgy0tXBm5UigyfYfxAug2JyiZZceRLt2me7LrdoSXdhsZbYGfLo2kjSOtkpS/
 n5zQmoFvjN7XpFhyEzUJCXhWAQAU/MxMgtzjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718893420; x=1719498220;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UoG1wjxd3HnFQjYcPWyzBpGO7LRYWr+0ObPGsZKsEKc=;
 b=CCX3mOrQ8jTc+uvfipSJ5pgyAmcT9ZAxlZxKlSov0xVlenzhW52czgifEjbDQhhsj7
 RWnYupmlS4CkV4CuenRpIlS6o0ZT8+rmuAPa/7U25BTv/pyWJ/m58AJCXYBD+7MzktLw
 79kWgx4SMNlV34iHBcvO/U43KxbIksFk641YIWq1F54BG5SkZjJrXsNhv0G4rPjNREPr
 yUMxMcQS9Xr7GbfDEZNnECF+qw/J5m25jpZ9q6a0c3V02Gcm1D8WlmBA07K+pSqc6njp
 EkQpm60IWtZL1V/RanQyLU6aH040njQwrJPj4Bb3I/7T/FOFKNYte3UFW57/HY+AK1k3
 pEzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvFicLxRGJfYwB6Txn4tH2KkEVcNlrx5nB0AIWBvVEiqeroT7uXysOAMJ16LiTq/C5WVeNpywMZnGHeiLYY4yTH6Q4nw==
X-Gm-Message-State: AOJu0Ywhp1WcHKz/5iP/R8DZGxenzk/6wL/mrhqwvtkgtzxASDcpVViS
 GCLrAwNKRiVB/3s8oIew+rb6trM04Ct4gmKS7ULww2UycBAOv2ifnkw5jmXc8Mg=
X-Google-Smtp-Source: AGHT+IHAzeU5Z/mEW8URdWMmE/gqTEOz0gPc9y3F4bwoytlYy8OY/Ac9ZKgzVu7Jh3iQ8U65bzcmnw==
X-Received: by 2002:a05:6870:7007:b0:259:86d2:e762 with SMTP id
 586e51a60fabf-25c94901dd0mr6350580fac.5.1718893420437; 
 Thu, 20 Jun 2024 07:23:40 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-6fb5afa9f57sm2538332a34.13.2024.06.20.07.23.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 07:23:39 -0700 (PDT)
Date: Thu, 20 Jun 2024 08:23:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Simon Glass <sjg@chromium.org>, Julien Masson <jmasson@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2 0/5] bootstd: Add Android support
Message-ID: <20240620142337.GA3542727@bill-the-cat>
References: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1cYnvSe67tdmXzv/"
Content-Disposition: inline
In-Reply-To: <20240613-bootmeth-android-v2-0-397f6e66eb29@baylibre.com>
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


--1cYnvSe67tdmXzv/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 12:13:07PM +0200, Mattijs Korpershoek wrote:

> Android boot flow is a bit different than a regular Linux distro.
> Android relies on multiple partitions in order to boot.
>=20
> A typical boot flow would be:
> 1. Parse the Bootloader Control Block (BCB, misc partition)
> 2. If BCB requested bootonce-bootloader, start fastboot and wait.
> 3. If BCB requested recovery or normal android, run the following:
>    a. Get slot (A/B) from BCB
>    b. Run AVB (Android Verified Boot) on boot partitions
>    c. Load boot and vendor_boot partitions
>    d. Load device-tree, ramdisk and boot
>=20
> The AOSP documentation has more details at [1], [2], [3]
>=20
> This has been implemented via complex boot scripts such as [4].
> However, these boot script are neither very maintainable nor generic.
> Moreover, DISTRO_DEFAULTS is being deprecated [5].
>=20
> Add a generic Android bootflow implementation for bootstd.
>=20
> For this initial version, only boot image v4 is supported.
>=20
> This has been tested on sandbox using:
> $ ./test/py/test.py --bd sandbox --build -k test_ut
>=20
> This has also been tested on the AM62X SK EVM using TI's Android SDK[6]
> To test on TI board, the following (WIP) patch is needed as well:
> https://gitlab.baylibre.com/baylibre/ti/ti-u-boot/-/commit/84cceb912bccd7=
cdd7f9dd69bca0e5d987a1fd04
>=20
> [1] https://source.android.com/docs/core/architecture/bootloader
> [2] https://source.android.com/docs/core/architecture/partitions
> [3] https://source.android.com/docs/core/architecture/partitions/generic-=
boot
> [4] https://source.denx.de/u-boot/u-boot/-/blob/master/include/configs/me=
son64_android.h
> [5] https://lore.kernel.org/r/all/20230914165615.1058529-17-sjg@chromium.=
org/
> [6] https://software-dl.ti.com/processor-sdk-android/esd/AM62X/09_02_00/d=
ocs/android/Overview.html

This leads to failures in CI such as:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D FAILURES =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
___________________________ test_ut_dm_init_bootstd _______________________=
_____
test/py/tests/test_ut.py:555: in test_ut_dm_init_bootstd
    setup_android_image(u_boot_console)
test/py/tests/test_ut.py:488: in setup_android_image
    with open(boot_img, 'rb') as inf:
E   FileNotFoundError: [Errno 2] No such file or directory: '/tmp/malta64el=
/bootv4.img'
----------------------------- Captured stdout call ------------------------=
-----

--=20
Tom

--1cYnvSe67tdmXzv/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ0O2IACgkQFHw5/5Y0
tywmZwv/Tg5th7fw7a7Fr/qjj0jvfoi8JzVkeIm+wXJahx+Ps6JzbDZJPXpWuRaN
sUzG9RmL126MVX5vX0lh56hWSlsqOQ3VOAIbDgkW+zWNRUyV8TKKa8KR2zdwW6+K
V8MscUiUAWpdTTaDk+cONJw7yaJOAT+nGpDkloOPSlGFjK5ONZ41Oj7et//q0p9B
ho/6zb2BdXuWy5QMMwhTVYAmBTxJ1GZ1wyXq5ByRhex8YjGsDjCw8GKe0XXuGj0S
s1u2VFY3UFSRNEDzmezy0oHlTpWWa+N9TU2PnlIxAMDZ1iodt/nxeVAng+aKmlje
9/BYAFRLHA/hpp2ROgoaiZorH3bjFlBQ0o5oqfefmDoolP7rgNd9LiyYNEN0BQ1p
3SVH9d7e+xw1XhfOxZRYs53NFUSsOHgvKFrx2rsh1Q6pcE1DENR/jZ88ywkJdMyF
K9k2dLmdh5GfIWIX5/6s2kWqv2v1e3xsoMsfv0fL1nCf/o31sDU7kCDXfRgu39Vz
1lvc/Rix
=FRD4
-----END PGP SIGNATURE-----

--1cYnvSe67tdmXzv/--
