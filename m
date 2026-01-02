Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72015FA374F
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 15:08:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E35A78424E;
	Fri,  2 Jan 2026 16:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="THYJQOjD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8816B84255; Fri,  2 Jan 2026 16:08:53 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0229383A3D
 for <u-boot@lists.denx.de>; Fri,  2 Jan 2026 16:08:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-459993ff4fcso2148819b6e.1
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 07:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767366530; x=1767971330; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vJaET/OkSW2AaZprVTLQIIaexjR4KIibpwnJfpbWer4=;
 b=THYJQOjDjyYNHB/n6tlmAchyyQs3iWe6dteb1z22Uu5y5VHGKrZGBhdcgythPKH5Yk
 Hhtap1/NCcZbwlnLvobVWu0MPf2ReLqsq60N04FBdDbOXJuMyvtbpL/0wczKnrWB8lo0
 +XI0Uh/e6gN5oGmu34a29RDIP7kkkJNh3LG8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767366530; x=1767971330;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJaET/OkSW2AaZprVTLQIIaexjR4KIibpwnJfpbWer4=;
 b=awYHBRM00eLGg6s1Yl4jdLtkI1XrSU7/YftNUKMQWBMyDJbGqC58HaiWV199YmlJZG
 WTHo+6dExBKdGGUZj+iDkDCg5mowt88sc47K/O43Lmuhx/1rPnQ4JHuc4UKO6M4QIEfK
 LWdpZMJCEYfWov5Sb7mfOZlcqUpnHVKwgif1xGY07xFzywhRC86Og+hWQZUUwiKVw4CV
 1BiG32vCsLshdWXCujBmks1H+0rVqJ7kqyoPmd1DXUrASB6DuahxEzWvpTRg4PjFZzW4
 kshA721DFYQ7pNDV4XQhs8u1190+Zk3Y8419ojaR3EY1wXvHojWT8TVX1AIZ3+5xXeAt
 jroQ==
X-Gm-Message-State: AOJu0YxBry2W7H6ChO99h90o7IrQSHplBoNUnpTONTs3WausXYI4+m5I
 9Hhsgd2R7MZ+7F4tnWXkSfC6KeIfCe6EidxjE+6FC0d9LBuwcJtjYof//m4OM4Aoz3E=
X-Gm-Gg: AY/fxX6MTdErR3JToQVwHE56YKgSwZ4WPxTGenNTB88w+aE8LgRrKHJK92aJHsA0e87
 UMPdwY9RQ9uqbl8MlJu36C6hgaf/VGigdPR9OW47/w6wk0fJQhuNlAFEiaAhQEN3YBiX8xGTaPD
 0IF7Zxr5Kn8QuJa4U3T6J/yut41bLVYAZhUn8WE8InAj5NOd11C+1L2dAM4n0gs2EA6ZoU2TAUH
 McrsrJ/AWQZQOVBb+TIvPs+crmp8NcEHeuAb01w8biOvu9eIvibFtHGPHnF2LwEt8yW8TDWbcTM
 ZaDpfqOxcb8/1w1f1oSPRYjV7lbTO4nzTFKYtXtzNNxFkKxnFkKUifzQCRPfmD5JVP7+IWoqhDw
 pCY/FMdgE+vKsFWtFTbHcln28w+FaAT5VLhQyM2d6ubYqf9zhUacFPhZWs0p0xTxS2t1KF9fDIx
 X1W1PQBmnKstq1bTZLKRN2Jzy/aRxztK89ei0CNThkI9X0T2RsTD92I8Z6aOfKeYR0qgbXKMe5Z
 ju3r2u2eRd+qJVIY3AQE9cafvTKsf+AkavoRGw=
X-Google-Smtp-Source: AGHT+IEn83LxxozEXVGuKWvnueHzw7CuamDnhk3N5MUQ0IfQ04qY2rMxb6ubM99alzc2vuUwpeE7OA==
X-Received: by 2002:a05:6808:1485:b0:450:dce4:8e with SMTP id
 5614622812f47-457b1fdcb77mr17454088b6e.37.1767366529619; 
 Fri, 02 Jan 2026 07:08:49 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3ba4416sm19242657b6e.1.2026.01.02.07.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 07:08:49 -0800 (PST)
Date: Fri, 2 Jan 2026 09:08:46 -0600
From: Tom Rini <trini@konsulko.com>
To: j.ne@posteo.net
Cc: u-boot@lists.denx.de, Svyatoslav Ryhel <clamor95@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Peter Geis <pgwipeout@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH next] board: amediatech: Add X96Q support
Message-ID: <20260102150846.GD6124@bill-the-cat>
References: <20251231-x96q-v1-1-316d703b8f03@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ZJD73//wcVL4shxq"
Content-Disposition: inline
In-Reply-To: <20251231-x96q-v1-1-316d703b8f03@posteo.net>
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


--ZJD73//wcVL4shxq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 08:45:03PM +0100, J. Neusch=E4fer via B4 Relay wrot=
e:

> From: "J. Neusch=E4fer" <j.ne@posteo.net>
>=20
> The X96Q is a set-top box with an H313 SoC, AXP305 PMIC, 1 or 2 GiB RAM,
> 8 or 16 GiB eMMC flash, 2x USB A, Micro-SD, HDMI, Ethernet, audio/video
> output, and infrared input.
>=20
>   https://x96mini.com/products/x96q-tv-box-android-10-set-top-box
>=20
> This commit adds a defconfig and some documentation. The devicetree is
> already in dts/upstream.
>=20
> The CONFIG_DRAM_SUNXI_* settings are chosen such that the register
> values in the DRAM PHY's MMIO space are as close as possible to those
> observed when booting with the preinstalled vendor U-Boot.
>=20
> ---
> Signed-off-by: J. Neusch=E4fer <j.ne@posteo.net>
> ---
>  configs/x96q_defconfig         | 46 ++++++++++++++++++++++++++++++++++

This needs to come from "make savedefconfig" and:
[snip]
> +CONFIG_SUNXI_DRAM_H616_DDR3_1333=3Dy    # DDR3 is correct, but vendor ub=
oot mentions 600 MHz DRAM CLK
[snip]
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D60   # os =3D 0, uboot not de=
tected
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D61   # e59f002c e5810000 f57f=
f04f f57ff06f (4a0000cc)
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D62   # a9431e66 a9442668 a945=
2e6a a946366c (4a0002cc)
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D64   # 52800000 91008081 7940=
0025 34000080 (4a0006cc)
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D96   # 340007c0 f9401673 eb13=
02ff 54000760 (4a006acc)
> +#CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=3D112  # f9003fe0 f94047e0 6b1c=
001f 54fffcc0 (4a0162cc)

If this information is useful, it needs to be preserved in the docs.

--=20
Tom

--ZJD73//wcVL4shxq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaVffewAKCRAr4qD1Cr/k
CqztAQCG95YS3zB55cnq/jSUBJRaaeppw6pqhWdiBB6jiSTSpgEA8Rmg22q7OyT0
UnObucy5nrZ51DlttOxiE4d0aftZzgY=
=kd2a
-----END PGP SIGNATURE-----

--ZJD73//wcVL4shxq--
