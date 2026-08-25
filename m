Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91184C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 22:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37340407BC;
	Tue, 25 Aug 2026 22:59:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wL68mKQbRHMj; Tue, 25 Aug 2026 22:59:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698755;
	bh=1AfVr4TfmYMBDjcgHulDMhyt9kNik9ED24eNDVpjWsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M5UVULL+vCNtf0s919/d2DJY/JMlv/u8K3MQ9He23lGhI9dZ7dPF4vfpZ0mq2z/vb
	 XGmrZpxPVfictVgip76G1Zptx3i+wZrqu2IbK9K9mKnwOzL6144Sp1DgRkjZ4T2azt
	 dlyAI+QuL735POzx5YnRpicaNCVeBM9XajHHKQhrGMFAU5DpNBO9lqOzDGo1rIm9QB
	 IPIdeyMfV0hc+Ux5RqWqUpz9K3hlMa+wsYrBTpSQTVDZf8AmFJDMxRM/eNmRsSuG07
	 aMmSVD2iMwBILVThZQfybijs8PmzLa8YuDaBt7AalSQLx2hueMHV517/kfhkW2ksrn
	 eu4Zv9m+EuonQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 214AB40770;
	Tue, 25 Aug 2026 22:59:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 919B2230
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:59:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 82F3960712
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:59:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s_hWgmTgw092 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 22:59:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::335; helo=mail-ot1-x335.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=F6ME9tdT
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A27CE606AE
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 22:59:13 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7f3f52143cdso295396a34.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 15:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787698752; x=1788303552;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1AfVr4TfmYMBDjcgHulDMhyt9kNik9ED24eNDVpjWsI=;
 b=F6ME9tdTp9CPgrO0CoSwFoUthjdySJm5XGrOwP61ywymvDCBjjGqVWd5UjRE067Et8
 Ote7vasLwOmxcb/njT2adC5+N/e31H6zwb+eNuK9nIvq/UOnnq0WnXZ9RTnccaulewxH
 YLjUjIvKyg5VJIqHPF17wYgwWl7U2eb2ExVbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787698752; x=1788303552;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1AfVr4TfmYMBDjcgHulDMhyt9kNik9ED24eNDVpjWsI=;
 b=kXfVpyUMIBTzRPL5r4XC5rWJoiy7BAjkvy+Nt4LnzbJcbbZ4+1QM8TJKNmwoVFbzul
 +Q+lR5PhV17mN9/3OwKMPRoefxmU8uscRnJMk/2zfyGNC4UU65BhoBugg/KlCjwzCsFo
 PMAZ+vBq4ositBCh+ReUQEPNZwy93cRrgP7U75DbzXKHrLX9Skf4xpHTz32J7M62BcLS
 uZPRcB3HNAqCuSqjXt9zw+e/At8A+eN2lNH4g3wxd4o0ztbnqWZxZU2h8jI3V1fRk9A8
 m3fO2yekQh4SSf9GGD1V1WylZvjpiweZMB2k1AlSGc4xMHylk0+HzaS+H1GnfBc9WY5+
 3bEA==
X-Gm-Message-State: AFuF++m79vtkb3Ki7F5qQXJxAAfNklahVmWWkwKdyxGLsEC0d3mLgBvO
 qrhHJDhJQ44mkUXyERSVvdezDvRWBabUt3TAm6QEoKRKmKE9eI87jXvF1sdzVElYGQWGKqwPTSZ
 isIsd1Qkff0wY
X-Gm-Gg: AR+sD13muJhB7BQPlDbjDQneGANT/8PWQ0hCBChyWBZg0eWtzG3wJBrslHIcMSC7Zn3
 syiGLpuBycZi3hbJA4HrJaZxYBRgWj40+0I14H58kW3dVuPNZ6pBV9lx71wNSZehtyMaoMZP+3x
 6QdB0N/WJbgGCwBhKDVAwngSB1moX0GENWRR74B4L56vJdLh1kxbHsCdg8D8Ly4eV1nHBrZ/BLE
 fg1TWzPKh5TBDFFuHko2zS7nApB+evHdCvOccnTAWEi64mjQ2F1gH6GQoZjQjzyj6vX4p22N2X8
 xcCQ3b+vVcMGYAxsqe7NGkoVbSLXaS2sCCDO4HGWfFYiH2fzjJQ/SZHrSZugRy/WZG0Naf5AbHx
 M0Tm0OTC2dLom6DLxXAU1g1Erzs1LAeTEN/tRObHK7ao2EEuncDCFs4IGWizWSMrbHWCGSJV4ad
 ezsUNP3Thf0m0vEVFpTu8H4ExZHGvEIV9MTY33UajIj/Os/TQvyZZ3I0lsBHOAxIfjIxyYq9pNs
 MvmuF+SV/DK4CceefMdEdS97FCam24PgJWuG5RNhxlQqRm9QgpoTHnIUpa0dCzfiMM2L1JuY5hZ
 AF8T68/j3Q==
X-Received: by 2002:a05:6830:6d0f:b0:7dc:4a43:fb5c with SMTP id
 46e09a7af769-7f4c50cefedmr2756358a34.11.1787698752361; 
 Tue, 25 Aug 2026 15:59:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c818355csm223548a34.6.2026.08.25.15.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 15:59:11 -0700 (PDT)
Date: Tue, 25 Aug 2026 16:59:08 -0600
From: Tom Rini <trini@konsulko.com>
To: AK Sharma <maskachoska@yahoo.com>
Cc: u-boot@lists.u-boot-project.org, Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v1 05/12] mtd: spi-nand: add EN75 BMT bad-block
 management support
Message-ID: <20260825225908.GG523975@bill-the-cat>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
 <20260825224330.713151-6-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HnU3B9T95HbMU6mg"
Content-Disposition: inline
In-Reply-To: <20260825224330.713151-6-maskachoska@yahoo.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--HnU3B9T95HbMU6mg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 04:12:00AM +0530, AK Sharma wrote:

> Add read support for the EcoNet/Airoha BMT/BBT (bad-block management
> table) layout used by the EN75xx vendor bootloaders, so U-Boot maps the
> SPI-NAND logical blocks the same way as the vendor firmware.
>=20
> Signed-off-by: AK Sharma <maskachoska@yahoo.com>
> ---
>  drivers/mtd/nand/spi/Kconfig    |   8 +
>  drivers/mtd/nand/spi/Makefile   |   1 +
>  drivers/mtd/nand/spi/core.c     |   9 +-
>  drivers/mtd/nand/spi/en75_bmt.c | 665 ++++++++++++++++++++++++++++++++
>  drivers/mtd/nand/spi/en75_bmt.h |  24 ++
>  5 files changed, 706 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mtd/nand/spi/en75_bmt.c
>  create mode 100644 drivers/mtd/nand/spi/en75_bmt.h
>=20
> diff --git a/drivers/mtd/nand/spi/Kconfig b/drivers/mtd/nand/spi/Kconfig
> index 1124dada..09531914 100644
> --- a/drivers/mtd/nand/spi/Kconfig
> +++ b/drivers/mtd/nand/spi/Kconfig
> @@ -6,3 +6,11 @@ menuconfig MTD_SPI_NAND
>  	select SPI_MEM
>  	help
>  	  This is the framework for the SPI NAND device drivers.
> +
> +config MTD_EN75_BMT
> +	bool "EcoNet EN75xx vendor BMT/BBT translation (read-only)"
> +	depends on MTD_SPI_NAND
> +	help
> +	  Honour the EcoNet/Airoha factory BBT and BMT so logical NAND
> +	  addresses match the bootbase and Linux. Read-only: never rewrite
> +	  the tables.
> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
> index a7a0b2cb..20aa718d 100644
> --- a/drivers/mtd/nand/spi/Makefile
> +++ b/drivers/mtd/nand/spi/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
>  spinand-objs :=3D core.o otp.o
> +spinand-objs +=3D $(if $(CONFIG_MTD_EN75_BMT),en75_bmt.o)
>  spinand-objs +=3D alliancememory.o ato.o esmt.o fmsh.o foresee.o gigadev=
ice.o macronix.o
>  spinand-objs +=3D micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>  obj-$(CONFIG_MTD_SPI_NAND) +=3D spinand.o
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 14af4264..29fdefe2 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -33,6 +33,7 @@
>  #include <linux/mtd/spinand.h>
>  #include <linux/printk.h>
>  #include <linux/delay.h>
> +#include "en75_bmt.h"
>  #endif
> =20
>  struct spinand_plat {
> @@ -1703,15 +1704,21 @@ static int spinand_probe(struct udevice *dev)
>  #ifndef __UBOOT__
>  	ret =3D mtd_device_register(mtd, NULL, 0);
>  #else
> +	ret =3D en75_bmt_attach(mtd);
> +	if (ret)
> +		goto err_spinand_cleanup;
> +
>  	ret =3D add_mtd_device(mtd);
>  #endif
>  	if (ret)
> -		goto err_spinand_cleanup;
> +		goto err_bmt_detach;
> =20
>  	plat->mtd =3D mtd;
> =20
>  	return 0;
> =20
> +err_bmt_detach:
> +	en75_bmt_detach(mtd);
>  err_spinand_cleanup:
>  	spinand_cleanup(spinand);

I am concerned about generic code path changes here, how is this handled
in the upstream kernel?

--=20
Tom

--HnU3B9T95HbMU6mg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao4ePAAKCRAr4qD1Cr/k
CvWoAPwKX3aW/Xc4JBopREWqq2ve0h+S4YUkMhupdwaJH4F9CwEAt8KtJkZtA9vE
l7sBk7UidwcevMZ9ztPv9XynY5n+HA4=
=tc/3
-----END PGP SIGNATURE-----

--HnU3B9T95HbMU6mg--
