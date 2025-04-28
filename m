Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B3EC369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 19:05:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 518C480FDA;
	Mon, 28 Apr 2025 21:05:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ed5Nf1Ap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 887F4820FE; Mon, 28 Apr 2025 21:05:38 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07AA680F6B
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 21:05:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2d060c62b61so4620703fac.0
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 12:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745867135; x=1746471935; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iz5tHaDCtivElLxBv0r1K5Hvs5E1kpZaNW+5X33tlwo=;
 b=ed5Nf1ApzBuTxv1QeQoURQc1zdpR9g/VXbEQzoHM6HixUk3lMYmpQOjnMeYzKTICPc
 6usTeL7FP/Snd3yHTn8RanJ+rZ8ouEDXrHGi7cB4K7nb00cRLV+ReEZqDHKusCeT3ARZ
 KoVFXGlcwwtIEfMiHiRCOWDJ7KJK5qdscT/+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745867135; x=1746471935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iz5tHaDCtivElLxBv0r1K5Hvs5E1kpZaNW+5X33tlwo=;
 b=aKmvfxfD9eeSMh6N81JVxHSMWOraUafXG1QBtXJm0W60wDjb21a6qxgnVEoDyUY2vM
 4HtwZ9AI3pe/GT9W1ChRsZRhaXwyWjtKFmyZkHuVYUU8xCe/8fySvELUSTuhhy4cy3fk
 9UwajANPZkv9kxoJgwRWCaXUnApZ27dlDezT2AIIVtVKZ4mtuCNhywGJq7lrItOLsmZS
 i9lhSCqMKmcR9go215XIupsZh5uCoP/TDDqiOhPJ4+Y7ekuxPbQ+KdL70gVXsfqzeske
 XfotwlSawlGvH2omGxUTiltm7myQemZt78PvuMx1PqZMxLwRu8eX9Zpd2Rfbg3PFhR9N
 hkBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuqYbzDPg5KzsZY1ASmC0VPRJl03e1ZEDZuLv1gJIWVWVu8K8kqFxXTIE9E7Ltmno/6UtJod0=@lists.denx.de
X-Gm-Message-State: AOJu0Yys7wgrNy+ZA6L/bSz9ofC4SIAgV5Nh5N95vESGqqYcuVvWx0O5
 fxPss3QwkMhiiUibOGI7MduNAAeSN8FJPQd6YfLBYvaI4Ss53rPMa4u6iX2cDkc=
X-Gm-Gg: ASbGncvK/2r6to73QId3HsbhknOwdZRwvimRsg85C3Dquc72iyDoe2XxHGvaLFSJwFT
 VxYFL1V2NWRppkTy68esXDPfUd6EEHEdg0WgvJOF+MUulI9ZmcwF1vu32azsATKqqW5zCc1wH22
 7x2MOvb0scoBmSQY8sQ/fn8lqIA2FqIF/VH2gxj5Eu/9tURmQRd82hTFNfFUCPVqNKL0VgrYISn
 n/Lts/GF2VrxVmaTLQsGbCoy3BvO66soMcsimZohTffwwvDI7qKGliRUDgdUnOJ5JhNqetdQq9H
 VMdPrO6NQpQO06H746uxVhIjAPQKTvUCi1fGYA6QecANJy40YxBrLwqn/j4wtR7YZ+gV18rDhE0
 5WA==
X-Google-Smtp-Source: AGHT+IHn/p1YAF7unHdWhSvQ4pt+yJIK+0dkJUyk2kaAP+WvNQKGn9Ni3/g8IX/XACswbmQU9YBW9g==
X-Received: by 2002:a05:6871:4d0:b0:2c2:5639:3a4d with SMTP id
 586e51a60fabf-2d9be93a4bdmr5542427fac.38.1745867133551; 
 Mon, 28 Apr 2025 12:05:33 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d9737e77aasm2442612fac.25.2025.04.28.12.05.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 12:05:32 -0700 (PDT)
Date: Mon, 28 Apr 2025 13:05:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Subject: Re: Pull request: u-boot-sunxi/master for v2025.07
Message-ID: <20250428190530.GF5495@bill-the-cat>
References: <20250428150907.206134-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9CkmJfo5L3Qd/xge"
Content-Disposition: inline
In-Reply-To: <20250428150907.206134-1-andre.przywara@arm.com>
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


--9CkmJfo5L3Qd/xge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 04:09:07PM +0100, Andre Przywara wrote:

> Hi Tom,
>=20
> please pull the sunxi/master branch, containing changes for the second
> part of this cycle's sunxi updates.
>=20
> We have improvements to the reliability of H6 and H616 DRAM
> initialisation, hopefully avoiding those occasional size misdetections
> many people reported before.
> Also there is some modernisation of the USB PHY code, to use DT provided
> regulators and GPIOs, instead of relying on this being badly duplicated
> in Kconfig. This also happens to fix broken USB operations for older
> boards (using the A20 SoCs, for instance), which were clashing over
> grabbing some GPIOs, leading to a driver bailout.
> There is also some rework of the H6/H616 SPL clock code, to prepare it
> for being reused by the upcoming Allwinner A523 support. This drops the
> usage of C structs to model MMIO register frames, and replaces them by
> using an addition of the base address with a macro defined offset.
> Also in preparation for A523 there is one fix and one addition for the
> FEL code, to prepare for the GICv3 interrupt controller that the new SoC
> uses. And since this is a simple fix, and was ready, there is also the
> watchdog driver for that new SoC. Finally tossing in an easy fix to some
> H616 defconfig files to enable eMMC.
>=20
> I also use the opportunity to enable proper page table protection
> (observing read-only and no-execute attributes), support for which the
> arm64 port recently gained. I didn't spot any issues on my arm64 board
> tests, but it can be easily disabled or backed out again in case any
> issues arise.
>=20
> Full support for the two new SoC series (A133 and A523) we are working
> on is not quite ready yet, but might follow still a bit later if
> progress permits.
>=20
> CI passed, and boot-tested on at least one board with a H616, H6, A64,
> H3, A20, T113s.
>=20
> Thanks,
> Andre
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The following changes since commit 5a0a93a768487e55ebe50a34cc90d751bf99cc=
56:
>=20
>   Merge branch 'master' of https://source.denx.de/u-boot/custodians/u-boo=
t-riscv (2025-04-25 13:13:17 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-sunxi.git master
>=20
> for you to fetch changes up to d5837bbed841889428379ffff3cc19c9dca4cb6d:
>=20
>   sunxi: clock: H6: remove struct sunxi_prcm_reg (2025-04-28 15:03:28 +01=
00)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--9CkmJfo5L3Qd/xge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgP0XYACgkQFHw5/5Y0
tyyqmwwAmvyC03pAvAaqZzRpeEebVesdI5x0wn6tFk7CfBhZNHsdu2F8g+9OK1vK
npjs3gV/QjyPdZJTsAAlk281awIydokUNbnZPFbXKcFBZkfOD4chNm/8RJdT7ZDg
gc0R1Lw1MO5yfQBPcEmPIGdhDgWCHtdP+c21RFFnd5YWyaJzFQDv5bV+t5WWfvKX
1K6qOQGItsg3rwRKXaFnRpfKR5xv2kcomfwgWbDi2T+ktuZ8YiLUMHgCt8w2d1DL
U4+/HJGy/87FtkN12i5Wwb5pUc7jBSa/vhSGNn+kz+VunGAv/PxIMg+51jbaFHob
h6peWAa1uFlZKYpItvwG8YqQPYr7j2jyb5uF4jweIq6qlH+wnh3zLKf52v2+9fAz
z5a0m8B6RNWWiOsQtOoY5MfV8o0p+pEUHcl40Ja4W9rvoJ2mlj9ml3vxKbzPrCES
wZjpX5OF79EPltDygmWbuwb0PiEtEaesgxLm0W/WkqP0VNfPew4xkXb4rZQK9dnI
OEodPs0e
=tqNW
-----END PGP SIGNATURE-----

--9CkmJfo5L3Qd/xge--
