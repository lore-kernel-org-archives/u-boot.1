Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192C9CCD1BB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 16:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 794E5835B0;
	Wed, 22 Oct 2025 18:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L+UTuEBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 231A28357F; Wed, 22 Oct 2025 18:20:13 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEB4E80422
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 18:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-394587df7c4so3198169fac.2
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761150009; x=1761754809; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9ibj+5N5aDGLiE4Xi92NT9nJYeGXQYW4Sashfy9CBsk=;
 b=L+UTuEBKhVHoss5gufGwA4wZnUTbM2vwNGWwzsJ1NtrkOPmpPYTAVIla/QCP2Xypgn
 D2qnWNK6tA99WI0N/Zdp6kPZB6EbnV/tq8vvtf1iw6uo2/auEUxuYUT+C/YASbbQO3r4
 AUh+clLBqqqwena04pA1ghHvV6dwylLzvQRsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761150009; x=1761754809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ibj+5N5aDGLiE4Xi92NT9nJYeGXQYW4Sashfy9CBsk=;
 b=bMHJ0edQkrHSOeI01Y63tywZuMskT+DxvDFZzScU5GOca6S8InDcS+sArj8L8k/DOt
 kM/6IuWmDEeYHh96VAnNk/6+14Hu54pLkn59IJ/4l30bDDyEe18Sjy70tr/gYiD7ZsB2
 bnfzohKowklV5qrP9lOKprwh7JAcSTcf7mP1Bv/M5oLC3+wLSdiBJ4ralMwXkjXbygnq
 mmkskiJeG/PvYH8BpNfj/gQ4CWR+7kUbX/0EwnL6/GDV/b5yuQDlmxiT3LSJXiI+u6yA
 uuDfXtCTTisrNZT1JAOoi25aIgGxG3qPqLfvS9l4mlXIUYeCEYZFZOyLOUfB3ZkHkjeA
 nNkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5mZXKGXhacymOZGhlYUQtpiAsqwtaojrpSGjcWSNUGYZ/nGniIx5+qmjFkgOHaFnlLIg3EDs=@lists.denx.de
X-Gm-Message-State: AOJu0YyYoHoP976o+XH4OLWm4yWjwdpOCRjQGsP5CM7jGLrFE+YebGB3
 vyeqnyQnFQ6tzbytIAvOFc/83+uAeNMh3xYS1EkowpteAXg9LVfvx1KWWk4kmfcZXLI=
X-Gm-Gg: ASbGncsSyjg2R9zxPzKTJzzKD+axmMqXe8phJKTIRzHBAYe4Ec3A8MqarCK9t7peHoG
 QDrL2FOgc0Fpadx/JxuULEQeAEMUq+3KKdkx8+9gC8fkVl9LCfkUZtAHYQCfn33KOWvOeQ+wQp5
 IeLfZ0qs2TpDDEWK58S7HFD1/PlSScdbH8vnSLwl7804VKxkVVlPtAtpr7OBB0H3fPVa3UOedoB
 jK/c0oG/czKBjF8YoWepxeMd2LpR9oAnephpfAYh8Wcciko862GxEGKwp9JJG0T4TSXzKc7Xjdc
 lXB/d0CoCUy4+t164lEwUXs6EAzcxHB4hdO81uZft3PIgSns/WombvKcZoYhL5tHor4f9fnmzSU
 wP0zQzrJER+3Igmeu5YS8BhI5HrQvyqc+4/y30XCnnmCgszbHlvcdsjrWaVcG3FZqehAL371xgH
 baf65s5BwsetrmPxmAyz7MEvy2aR1WHcW24X5G56Re1mG8htsHDg==
X-Google-Smtp-Source: AGHT+IGicrU4MuzFuyJl9zXga5+7UTXunmAyDvIfUJVjxfrzHdYpcOfAAxftnO6uQLbkkoFUm7uxtQ==
X-Received: by 2002:a05:6871:6684:b0:396:3593:d1b2 with SMTP id
 586e51a60fabf-3c98cf88a98mr9163302fac.15.1761150009419; 
 Wed, 22 Oct 2025 09:20:09 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c9af31c1f3sm4072593fac.15.2025.10.22.09.20.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 09:20:08 -0700 (PDT)
Date: Wed, 22 Oct 2025 10:20:06 -0600
From: Tom Rini <trini@konsulko.com>
To: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v4 02/20] board: ti: Exclude cape detection from XPL builds
Message-ID: <20251022162006.GM6688@bill-the-cat>
References: <20251022-feature_sysboot_extension_board-v4-0-d24b5ef7b468@bootlin.com>
 <20251022-feature_sysboot_extension_board-v4-2-d24b5ef7b468@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yUolFmYp5P9YGTux"
Content-Disposition: inline
In-Reply-To: <20251022-feature_sysboot_extension_board-v4-2-d24b5ef7b468@bootlin.com>
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


--yUolFmYp5P9YGTux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 05:20:13PM +0200, Kory Maincent (TI.com) wrote:

> Disable cape detection functionality in XPL (eXtended Program Loader)
> images to reduce size and complexity in the early boot stage.

If you have to v5, just say "xPL" as it's shorthand for SPL/TPL/VPL. If
you don't, I'll try and fix it up when applying (and some for other
parts of the series).

> Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
> ---
>=20
> Changes in v2:
> - Use PHASE macro instead of XPL check.
> - Check SUPPORT_EXTENSION_SCAN instead of CONFIG_CMD_EXTENSION
> ---
>  board/ti/common/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/board/ti/common/Makefile b/board/ti/common/Makefile
> index caf6b9fa8c1..f58935b4103 100644
> --- a/board/ti/common/Makefile
> +++ b/board/ti/common/Makefile
> @@ -2,6 +2,6 @@
>  # Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.t=
i.com/
> =20
>  obj-${CONFIG_TI_I2C_BOARD_DETECT} +=3D board_detect.o
> -obj-${CONFIG_CMD_EXTENSION} +=3D cape_detect.o
> +obj-${CONFIG_$(PHASE_)SUPPORT_EXTENSION_SCAN} +=3D cape_detect.o
>  obj-${CONFIG_OF_LIBFDT} +=3D fdt_ops.o
>  obj-${CONFIG_ARCH_K3} +=3D k3-ddr.o

This is correct because if falcon mode requires cape support too,
SPL_SUPPORT_EXTENSION_SCAN can be introduced and this will work as
expected.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--yUolFmYp5P9YGTux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPkENQAKCRAr4qD1Cr/k
Ci9XAP0SkenZeWfETZ2FoVfK3Obj5/xMaOnE5etZERiNQqTGBwD+NRxJLISt8xGR
4WwhhZX6zghWl7QmdiSk/3Xxbv6vqwk=
=Op1g
-----END PGP SIGNATURE-----

--yUolFmYp5P9YGTux--
