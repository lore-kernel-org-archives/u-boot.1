Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A53C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 13:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 953D08871A;
	Mon,  8 Jul 2024 15:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="e25bFFOl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE30F88748; Mon,  8 Jul 2024 15:33:54 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B68FF886F9
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 15:33:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7036daa0704so526734a34.3
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720445631; x=1721050431; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=R+WdjNAE5++ztkdUgRmfcOQxjB79UrGD1048sjT9oWA=;
 b=e25bFFOlNHin2pgHxXBLJ1UI20grKDQCgzBbLX9Gml4gvI60GKxEbUi0/Q2SOI3ug3
 Ifa9AGNIWYCBcs6Pt1mI0uISm+8TwwMuACq+RU7992s+wVK6bvhRyA9pt5SSwhUuzk24
 +Dy98MjUeJ1YPSXBV2tzPnG1tZ/mlI60ensok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720445631; x=1721050431;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+WdjNAE5++ztkdUgRmfcOQxjB79UrGD1048sjT9oWA=;
 b=P6Vd6rvfnkkVqVgrgrfSZf7okElaDUD1Y3adc4e5GnVFC+dNQKjqjQtzLrGmwNSSw0
 MmbhyjTxc91LD0A3rl5Uu3JBq4IVqEkRzOEhjqsA1Lxk3R1TtdE43JCOSGRd05Ea7kcb
 EE+qMLWP2nLQed7v8HXnMcpoYQ/q299OVDvNrn+vq2HVrdZD/sOU0PgjCWS2J5WfBHTJ
 ufv4tbAak+mFVcB4E3DF3YDg8mBR3BhQtYQUOtXIwAL1NN/hgHq9ZHilZ70zx6fRI76a
 Nz6Bul4ALs6/LwrJHc3CSPe/oMyUcaqLcK/pfLJrXydc497XRd8hI8hxQvP2ECn5ehwL
 NSNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5XYC8zVdEz6OZjMFSxeTvy349g/DJCVLC4/AbQm/ZpmY5fQVBBSMO75m4CwGkVkkrpOp3l3KVlrSZ2q9yxj9DLDn5dQ==
X-Gm-Message-State: AOJu0Yzg9d6ImaR6K3YVrg/gbboyGYIOP5+Zco3mO1FdKkcRF5Usxrkb
 P2T3ZjGZitL5YGBRRQvLXm2ISRG1OlfO3JJCH3YEjHAF5eeThepMWGSGSgescLY=
X-Google-Smtp-Source: AGHT+IHJFRYtKUE3VSs+4DN4Lt7gZsJ85e37zoK3CmcDpkvhlUGdIO8UcP8KNIawJ8qr84u9yJrT6A==
X-Received: by 2002:a05:6830:13:b0:703:59b7:d16e with SMTP id
 46e09a7af769-70359b7d33emr10055148a34.5.1720445631415; 
 Mon, 08 Jul 2024 06:33:51 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7ab19efsm3849166a34.25.2024.07.08.06.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 06:33:50 -0700 (PDT)
Date: Mon, 8 Jul 2024 07:33:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>
Cc: Bryan Brattlof <bb@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com,
 praneeth@ti.com, u-kumar1@ti.com, m-chawdhry@ti.com
Subject: Re: [PATCH] configs: am62x_evm_a53_defconfig: Remove
 CONFIG_SYS_BOOTM_LEN
Message-ID: <20240708133348.GZ38804@bill-the-cat>
References: <20240708-remove-bootm-len-v1-1-2a537061426c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qwl5G8Rv6TI/zEPh"
Content-Disposition: inline
In-Reply-To: <20240708-remove-bootm-len-v1-1-2a537061426c@ti.com>
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


--qwl5G8Rv6TI/zEPh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 05:20:40PM +0530, Kamlesh Gurudasani wrote:

> Increase the maximum size of the buffer that is used to decompress
> the OS image in to.
>=20
> If image size is greater than the buffer, boot
> will fail with following error,
> "Error: inflate() returned -5"
> "gzip compressed: uncompress error -1"
>=20
> Default limit for ARM64 platforms is 0x4000000, remove
> CONFIG_SYS_BOOTM_LEN=3D0x8000000, so that it follows default limit.
>=20
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
>  configs/am62x_evm_a53_defconfig | 1 -
>  1 file changed, 1 deletion(-)

Please check and correct all of the TI K3 platforms. We have at least
this from a quick grep on am6*:
configs/am62x_beagleplay_a53_defconfig:CONFIG_SYS_BOOTM_LEN=3D0x800000
configs/am62x_evm_a53_defconfig:CONFIG_SYS_BOOTM_LEN=3D0x800000
configs/am65x_evm_r5_defconfig:CONFIG_SYS_BOOTM_LEN=3D0x4000000
configs/am65x_evm_r5_usbdfu_defconfig:CONFIG_SYS_BOOTM_LEN=3D0x4000000
configs/am65x_evm_r5_usbmsc_defconfig:CONFIG_SYS_BOOTM_LEN=3D0x4000000

(And so are those larger values on the R5 core actually needed?)

--=20
Tom

--qwl5G8Rv6TI/zEPh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaL6rkACgkQFHw5/5Y0
tyx0Nwv9Gqst+T4YVDHViSHOn7ml4ZlmTY/XAYd6E+ChDpyAHAIuRYHKpO1K0N7w
Gxs8NUEQJl8jkgkKpDiYaV6Jb9P9/oPKxUYbKhP3oK4mBToNaIHhKl9vlmGVK30H
tgO4ZNIoSQUSKQXZM05/fnGadrZwoYQcCa4EuvRI71ot1JIHnxu/Mb5VjJxX3zFL
k4Mz3cU/OrrdBADv0c5yqhEk6Sb9GHdKKdlItm+RzPcHpqA+bPrLXm0+2s32DKrp
Tc5D5C/xP03vNXT3heXCZiFbfJ9muDG9Xg+uVT8ExAfoDzgCkKEOoiSOFx+isaEZ
bWvOD+j7hxypw7mQAMfC/D0fH7VnvF4H0aGzp7GYhL8S/CN271ZVJ91EeD5Q997B
YCbahy4iwcbOh0k6fvmI3Npimyzy5d9y+u38v9zh55Z2Bapim0a59SpzINqQHNAi
wO5x/Cxr/gZKY1GpiB7vu/DQwU5JggMAt+22bg2MfRzYxIUSMxF8WSnBaKzm1wdN
4qabalSo
=fQ2n
-----END PGP SIGNATURE-----

--qwl5G8Rv6TI/zEPh--
