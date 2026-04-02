Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC56ED6AAF5
	for <u-boot@archiver.kernel.org>; Thu,  2 Apr 2026 17:13:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D139C84020;
	Thu,  2 Apr 2026 19:13:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FfOu8m/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CB4E84056; Thu,  2 Apr 2026 19:13:03 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC8CC83F7D
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 19:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso1034244a34.0
 for <u-boot@lists.denx.de>; Thu, 02 Apr 2026 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775149979; x=1775754779; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M9oAIkWDRA4pD7XQWh0KZGeadQXyFpz7iSX9sqxwoIM=;
 b=FfOu8m/i36Ob0cWOJKSRNpGcfVDdBZ7plKRoavmloBYmdZTEMcY1um/xCw+2NkeHyG
 /xBZXsSb1eCGks9U1Isn8IcfWKai/Rja0s2zPQh/T69dGhbjq4eP9F1OYexOlkGnr7On
 EIPF9Da8+g0t51lzuZf3PMN/2BHXZ9HYCpkGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775149979; x=1775754779;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M9oAIkWDRA4pD7XQWh0KZGeadQXyFpz7iSX9sqxwoIM=;
 b=i61g4AdVyW2H06dgMO9bgrU5ZI0INMYV3LCj6y1GungVnwAWbxdyFz1oEokAhOhoCa
 /DNG9KkWGbAi9wfTCcwN6qfXBzNBGadHWuFg3OPzY3OblkzZhbvxKoYeI13jjcllovgf
 L/+biALestN5dhu4ij2if+Dc7ydRLtFCTEqsdTtsO54xiO4pkR21AASbgKvz2niOG9m9
 252TTJ6i36BMECTPf/yVpD7FZiZ/CNZw0cl5tt0vyuWupqPP70jWPRm9Upbvjit9QHZm
 B8+lH/RaQq09NC06RDjuo2I2iY183X/bH+UkKmX7Cp39srmE1OMv86U31bTK0QgPAXKM
 CbWA==
X-Gm-Message-State: AOJu0Yy5PSfcVnOwjR25gi1ekBTXva5es1MOHFuJ/MHgtwm2zqa8QZA9
 wmemVMEijEdU2FCo/MgU5K7BGluosD7v9Lg7EqiK/5nK9iFYVfFtOBbNBU+zy4oUpTk=
X-Gm-Gg: ATEYQzy2/VJijRqPNZ0hPVrF3GohomV1UwcizS6wLopDTNCoXozfCno3RYd+D5RTu21
 3/++BTtn2UrV6m8wvAx2ztHq23j/GmQjxzR1oHAAwnLsXTdfJTQpEP7EXKwos58ahKdI+CB/vp+
 DPRZq77sC3yloRLwHd0im0Vxq0hw7/wXh8Y4LC/4eeIzKHMnNV+jNH12XkHpDhhRA9JonLw7SDw
 M06rhQ+IgQeyjG7uG0Xpdes4j/tYYRa9+mXAzWWyEESfgWbd3rJFwulbCvn6oBbLj35+769tNEU
 xz1iHIbMr+YeLAaqwWc1pAr+xL3eAUBqu6n/mFbCaO+vmu0I1GALM+sKyayMowvmVnr3uG2WFzL
 WYNR7sslFJrJRuXjMXuRmuuq7Z3zeEvGP/MszehkjEFZbwAlzN/FNU26C+fGx0WfUompSWfKBdS
 WXb/oY6DzFym83b/emWM1HAl3DtSn5k36LbLY7XmQi5ICO8tUcJy82ars114enDePN3boTLoDC6
 bN6srS087cLj4caK13bK9mfsUfj45DNuzZvNUndCKx6NDNY
X-Received: by 2002:a05:6830:6a14:b0:7d7:d11d:3b38 with SMTP id
 46e09a7af769-7dbb7517ad3mr61642a34.19.1775149979358; 
 Thu, 02 Apr 2026 10:12:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dba7371b07sm2480638a34.24.2026.04.02.10.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 10:12:58 -0700 (PDT)
Date: Thu, 2 Apr 2026 11:12:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: U-boot Openlist <u-boot@lists.denx.de>,
 "Lucien . Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Sky Huang <SkyLake.Huang@mediatek.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
Subject: Re: [PATCH v1] misc: fs_loader: Add QSPI RAW partition loading support
Message-ID: <20260402171256.GA1914552@bill-the-cat>
References: <20260319100256.965-1-boon.khai.ng@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GzEh8iLGaVnHOIBx"
Content-Disposition: inline
In-Reply-To: <20260319100256.965-1-boon.khai.ng@altera.com>
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


--GzEh8iLGaVnHOIBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 06:02:56PM +0800, Boon Khai Ng wrote:

> Enhanced the generic firmware loader to support QSPI RAW partition
> loading. This would enable FPGA configuration bitstream loading
> from QSPI RAW partition to program FPGA.
>=20
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
> ---
>  drivers/misc/fs_loader.c | 111 +++++++++++++++++++++++++++++++--------
>  include/fs_loader.h      |  35 ++++++++++++
>  2 files changed, 123 insertions(+), 23 deletions(-)

Building this on sandbox gives:
drivers/misc/fs_loader.c: In function 'fs_loader_probe':
drivers/misc/fs_loader.c:310:68: error: passing argument 3 of 'spi_flash_pr=
obe_bus_cs' makes pointer from integer without a cast [-Werror=3Dint-conver=
sion]
  310 |                                                      plat->sfconfig=
=2Espeed,
      |                                                      ~~~~~~~~~~~~~~=
^~~~~~
      |                                                                    |
      |                                                                    =
u32 {aka unsigned int}
In file included from drivers/misc/fs_loader.c:22:
include/spi_flash.h:105:45: note: expected 'struct udevice **' but argument=
 is of type 'u32' {aka 'unsigned int'}
  105 |                            struct udevice **devp);
      |                            ~~~~~~~~~~~~~~~~~^~~~
drivers/misc/fs_loader.c:308:31: error: too many arguments to function 'spi=
_flash_probe_bus_cs'
  308 |                         ret =3D spi_flash_probe_bus_cs(plat->sfconf=
ig.bus,
      |                               ^~~~~~~~~~~~~~~~~~~~~~
include/spi_flash.h:104:5: note: declared here
  104 | int spi_flash_probe_bus_cs(unsigned int busnum, unsigned int cs,

Please fix, thanks.

--=20
Tom

--GzEh8iLGaVnHOIBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCac6jjwAKCRAr4qD1Cr/k
CgQAAP4pGcpeTbDeCN4ltsyxKjTyvnH1wU7Jds4CcIn6ZhcrlwD/ePluu+Pnd9U5
uhrMH4MW0DQsm4cZdUsWG21r9PoZjQg=
=0u/1
-----END PGP SIGNATURE-----

--GzEh8iLGaVnHOIBx--
