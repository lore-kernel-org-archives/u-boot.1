Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62BFCCD193
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 14:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D54080107;
	Mon, 20 Oct 2025 16:17:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="juqyHO3w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47C5A831D5; Mon, 20 Oct 2025 16:17:14 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 283E3800B6
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 16:17:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7c2917b92bcso1500952a34.1
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 07:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760969831; x=1761574631; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bwpqPSPALZwQUArQQo7H00VNxB7rNwkQDqs2voEBmbM=;
 b=juqyHO3w7ERFrofZqLDzfvBlDHzIk6DOCrNukl22NjrQ5CX5hKEGnHCvchPk1eUGV3
 T/SuIVxzCF7Jm0oNTBfxItuDGsEXoNg3tSyuCqbM9YwXrnY+aaw2H5dAEJmA2q4fWXhh
 ZHEX5unKNCZLNjacwOmmq35NsFMjnhJFeSt0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760969831; x=1761574631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwpqPSPALZwQUArQQo7H00VNxB7rNwkQDqs2voEBmbM=;
 b=d2HOBHVR/wQXDkIKX5UIxbQHB0CU/WOuSJkKKzNN3LQEtkUIiDIXkJTPCx0ybnUG59
 u7Gixi+kdBnJKjWmKI4rjAosalqHuVKtrbHBdHyknbqj1DstuuYnZ7Zdj4/sMoITa4wz
 amDzut4395nb0PTAIPIRsH1YFSRleqA3lzRiHMwS4SwpoC6sv+bp411d07iEsNehSg9c
 8qWQaA3O09J1HhS7kC+kOU5T8MePpN5AXY+9qROmSzYJyMOLw0Ioa/vN4TGM6KZbl9SZ
 HWuQOrYBAqeCL8P972BygDYdrE4LQ4dbCP6mfrmwCHzHcs/Jhpgb9zW4b4dTMDLJat62
 HW+w==
X-Gm-Message-State: AOJu0YzCAp0jF1ChKEM6LRl4bcNQ3106S5nzzcHwDP95sDtq1QyKcu6Y
 lNpQlDO0LGIzBFNkfAZrWa6Lh/ZyrBEget5eI648YJL6hRE03Jv2+VR/6KQI510ewxU=
X-Gm-Gg: ASbGncuyRJa0Iw9b0I47DISsBcFGgzyfjsVKBbEtxhDoKvLnzyD3kMwsSsTFKtCEiW9
 BVvkauqmie58Mcbw5xd30WjY4NVbphoCgrDDpfGZzmd3DZcdlfaDsSKFKe6cOinMd4Yq5yVzefc
 YPs/HVWntljGxFW7eVEXDSN/TMaAmB2kNQwIU7FPpHmKhXL1ct6pcXXlvBkC/PvjJMDyyh0wNET
 FG+O7zBpctkRM/2vLDeROEflZQcI4aZnjNr9P6Kx+6+uv/vY5mbl3Ewq8vvBTv4/0HBT5BGonoe
 dD1YaSNPR7+Ig4k2v5r0cHnz/rtj8pITm6QMLrJ8Bq6qbdV0i2s2yIsfpDmHLVW3+lMM9wWgKi3
 72ZW1316hUKlvNooEelo+L2qxip4T/oBBGiNIbj3krXa5ll1MMCV+4ougkw3l9EZyzOzlpYwES0
 1q9mHFvu6QaV+UOCuQ+h924fWfahqsKsEHRv1Hjp4=
X-Google-Smtp-Source: AGHT+IFa9audOWpxmusMD/1tY9G84d4ArU/FqxPNgiOhV5RXvPlVHM2wuvJlnMprN1iRg6M4oilPLg==
X-Received: by 2002:a05:6830:60d0:20b0:7c2:82cb:dbe2 with SMTP id
 46e09a7af769-7c282cbdf28mr4003042a34.7.1760969830794; 
 Mon, 20 Oct 2025 07:17:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c2888ed660sm2643431a34.21.2025.10.20.07.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Oct 2025 07:17:10 -0700 (PDT)
Date: Mon, 20 Oct 2025 08:17:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, ronald.wahl@legrand.com,
 e@freeshell.de, Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Prasanth Babu Mantena <p-mantena@ti.com>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] Revert "spi: cadence-qspi: Remove cdns,is-dma property
 handling"
Message-ID: <20251020141707.GT6688@bill-the-cat>
References: <eed1378a51e63a58fda116f8cdf580ebd779ca7e.1760966019.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wFq7+EcTwupcu3dz"
Content-Disposition: inline
In-Reply-To: <eed1378a51e63a58fda116f8cdf580ebd779ca7e.1760966019.git.michal.simek@amd.com>
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


--wFq7+EcTwupcu3dz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 03:13:42PM +0200, Michal Simek wrote:

> This reverts commit a040578d8270ed8788d7663808ea63ce5ffd7840.
>=20
> Based on feedback other SOCs (for example Star64) are using driver in non
> DMA mode which is causing issues that's why revert this patch.
> cdns,is-dma should be removed differently.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reported-by: E Shattow <e@freeshell.de>

> ---
>=20
> Tom: Would be good if you can get this to rc1.

OK.

--=20
Tom

--wFq7+EcTwupcu3dz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPZEYwAKCRAr4qD1Cr/k
CqMJAQD27e8HNoLzv57ka1tNtXYzPRN3pV0iHI75KLPlk5WADAEA7sCGpmJlRHNK
/xChZlzSGIFnQ6GfqgwYQaq1/sWM4wg=
=kNM3
-----END PGP SIGNATURE-----

--wFq7+EcTwupcu3dz--
