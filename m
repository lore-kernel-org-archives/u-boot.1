Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467C0C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 19:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A8A6875B9;
	Sat,  9 Dec 2023 20:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UZjNngwx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB68F87645; Sat,  9 Dec 2023 20:50:38 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75461870FF
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 20:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-da7ea62e76cso3444995276.3
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 11:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702151435; x=1702756235; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gb8tVS8itBMTn9HZdQsAjHkZPAeKLWSiCRIQy4U/luw=;
 b=UZjNngwxa8d9pSnu0JZGlcDVx8wDvmk4apQOMHJiy40CBTIJt6+dCFS0j4SbPDm7op
 xTQYmHCoh0YVpcfZ3h94dBMchJDwtOAnjGuVHwBAsDeVyR9hyN+vuBXjcBvw6aZ2e/nz
 +9zGS0ZV79wikTwPIyJCtbxVZh5PdqZfRvk64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702151435; x=1702756235;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gb8tVS8itBMTn9HZdQsAjHkZPAeKLWSiCRIQy4U/luw=;
 b=YJgUMGGBwpR8W1z7vNeWU/fiTYz0XgMt1LnLAXG+rqdryY9n30l3T7NCZs9+A1MeRi
 9YZOPtElgC/3/jKrREFNphdmIK7JvSVvZ2+V7FL87F1sSrrPVF3AO2iMKibDfFYCpuUe
 XluznufXYqz805VPBuMxwJgl19O2y2Ovrc1P79Rs0l97V54zyiNTPnoYSJjv8p4pACJu
 gsCRo8UMFBs1PMyjoKqLLHSmEDLgyMgbxxuPa/fCZQu59u3avPZ0bz74nch4Nc4QLao3
 O2FiY6k95Nd8MxZKhNbZnqwuFutqny8WmutvZ6HgELspmJfTsZq+YwNy4QCfMlHZkJ54
 MxKQ==
X-Gm-Message-State: AOJu0YxiSjHbq5MVbvsLmv3seNI7FprDSM38CnTDyy2+jlgYSHehxF5Y
 EJIvJ7bRTQTC82nWRPQpduHZalchE1A87UmOq/55Mg==
X-Google-Smtp-Source: AGHT+IGA3DVbvIma0zJXI0jpVFRyu5q6IDym3PE4xLGJTu6C2wdm4vBmFeIvDuIBfgsx+7Kl89wFKg==
X-Received: by 2002:a05:6902:cc7:b0:db5:3ae2:b576 with SMTP id
 cq7-20020a0569020cc700b00db53ae2b576mr1434296ybb.52.1702151435154; 
 Sat, 09 Dec 2023 11:50:35 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a5b03ca000000b00da086d6921fsm1432310ybp.50.2023.12.09.11.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 11:50:34 -0800 (PST)
Date: Sat, 9 Dec 2023 14:50:31 -0500
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 hs@denx.de, enrico.leto@siemens.com, praneeth@ti.com, nm@ti.com,
 vigneshr@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH] mtd: nand: omap_gpmc: Fix NAND in SPL for AM335x
Message-ID: <20231209195031.GB2513409@bill-the-cat>
References: <20231125111605.47536-1-rogerq@kernel.org>
 <a6a9be90-d360-4d35-b95b-e1d628c38ce8@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JyDfffMnXv2/qMlS"
Content-Disposition: inline
In-Reply-To: <a6a9be90-d360-4d35-b95b-e1d628c38ce8@kernel.org>
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


--JyDfffMnXv2/qMlS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 08, 2023 at 10:31:54AM +0200, Roger Quadros wrote:
> On 25/11/2023 13:16, Roger Quadros wrote:
> > AM335x uses a special driver "am335x_spl_bch.c" as SPL
> > NAND loader. This driver expects 1 sector at a time ECC
> > and doesn't work well with multi-sector ECC that was implemented in
> > commit 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based cor=
rection")
> >=20
> > Switch back to 1 sector at a time read/ECC.
> >=20
> > Fixes: 04fcd2587321 ("mtd: rawnand: omap_gpmc: Fix BCH6/16 HW based cor=
rection")
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
>=20
> Azure pipeline build fails. Not because of this patch though.
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D7479&view=3D=
logs&j=3Dc6c7c3ee-a125-5e20-d856-38cb989f4743&t=3Dd274418e-7320-5c59-39b7-1=
56cfcddae0b

Er? The failure is just above the end of the page (which the link opens
to for me) and is:
+drivers/mtd/nand/raw/omap_gpmc.c:356:12: error: 'omap_calculate_ecc_bch' d=
efined but not used [-Werror=3Dunused-function]
+  356 | static int omap_calculate_ecc_bch(struct mtd_info *mtd, const u8 *=
dat,
+      |            ^~~~~~~~~~~~~~~~~~~~~~
+cc1: all warnings being treated as errors

And is this patch :)

--=20
Tom

--JyDfffMnXv2/qMlS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0xQQACgkQFHw5/5Y0
tyyFVAv9E2P20UrL/qEcSQBNsOFTJ0q/wQcTz9p6nLEegWiwm78o4YoXjN+++IDm
Jr07phvQgdpcr9OyixOiWuLWIbTlbYWS5/0+RXZbgMVUn+6NAM0Ko/Yt99GvQLT7
Pppn86CB9xfGYh8/aIPRyLFxGVRQ++ey4lRLZdFGjmlnVbg49qDPDcrbVbz2ChRj
ZTyIKcnlNa6r1DlqdopX0LTJn5eDSHcC2Nhyp3zddx2iNSSO1mkW5ABp7eWugp9G
XqfjooQ0bB1Pe91rFE6ptvMau4hCuKfVl7qvV422P7/erl38Lzia2ru6ya5Q7tWB
Icn5wk28nfM4vH9iwxYvY089pS85fwG3l7ZddtiuR6PT9PabTlNlOrT3JJHCOhqt
O3etmzRlgESDBaUdsgTZ3QG1vbZar4REVKpu7/W5buIPXox3Kff5IVJeRsYCE6uP
bG1etJe9EGJa0fwCq9xEPxUB3QnbzQ9xCixgi9BAupxXxsGkb1oDK7FTxESATbHx
hGKxJ4u4
=SxIu
-----END PGP SIGNATURE-----

--JyDfffMnXv2/qMlS--
