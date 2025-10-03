Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69375CCA471
	for <u-boot@archiver.kernel.org>; Fri,  3 Oct 2025 20:37:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2330838A5;
	Fri,  3 Oct 2025 22:37:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gRkK9+2X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 042B8838AE; Fri,  3 Oct 2025 22:37:53 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9990E838A0
 for <u-boot@lists.denx.de>; Fri,  3 Oct 2025 22:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-911afafcc20so101381039f.3
 for <u-boot@lists.denx.de>; Fri, 03 Oct 2025 13:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759523869; x=1760128669; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JgeFhKSrEunpf9WND3IFbMFYI4vUYV+uznY5xj1g4tM=;
 b=gRkK9+2XE1LTDJmXdacxQJtiVj5n2Lx9bS9fKfQBNnP3FK+xH8RUJwNDBdsUlChFPR
 wESe9iDPEO3LfhMJgWgzPGEZlTUJqNoxyDGPLK32o9bTg56lxyaE7OssV61r8o5BZ3cg
 06nV3mvN5GjvwgbjwjiHOJGlv8YkodJxj9YgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759523869; x=1760128669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JgeFhKSrEunpf9WND3IFbMFYI4vUYV+uznY5xj1g4tM=;
 b=UIu1UrLo8UcwX6JMKQBVyYX6karTfU2OEnwbooZRf17pgfkANSIZP+zKyoWum+rSN8
 SMQRKhACxnZGniBNw+St5KDKcxQobD266IEqK8YSks8T5eAXq5PJLruQ2zsUarHEufyg
 p0H84+Og18uE5ngeOKH+Xo7taIJlYMIbHZA+myR44Hvlwas5TvlZ2KfSybG8FnKjcmoZ
 k5/avowWSI+b0BOQaGsHw/XIE7+W0yrpI4L2ocj/2UeCWijEKqJOqdfNaN9JgU+yzUgx
 b4ke2tEY9IfqcLEyPZIcDsuhheHJqnVy4v1TePcu2JmqxvuL/c+bBZmi9kv7itdD4JI4
 4nVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWsX4kmY6j+QVyYoOw+tMLhXYBbRGYk08itcaNTKdKUzYUgb7us4A61FncIHBg56huwfVYMbo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxb7bPTpGlGGWam5eZStUfRRrtxs+yP8lkiH0DF5r8bI+NMLMZl
 KA1G+mg148AV9wOz57IseySZixYAcSmVWHArKaZcx9DypCWmHUtT31m5dMT/fia9lAzSQz06pcK
 4LWDY1k8=
X-Gm-Gg: ASbGncuJkzys8Ga3d5Xu04SCaeT85ClFt2dYt6aY0HKRNrinXbw5wTCrhtg8m4w6224
 sKcTLf9jWwolyXc3ghcxC64i9DeKcwAxo8PgpkMtVfmMsxpxLyxDu6AFNDgXKbK2OoF54UpRk+o
 D2CokTob3TK8JEAymKI/tSMsD6lAs3IlS+pyFXMyfYlfPfxAV4aYlqvqytmeyOxU6CPcw/wIw9S
 v7W9OhVQnfD7PrtMuGGxdjhNFzrg+L1HwCU/TrDiexj7dxQ9aCo0kYk6Wdhsu4Wgl5WFsYLHMt2
 vkHr2yv43Uyc24vHwLLN41OsUTAKd+ZA/XOlteRAIYjpcc08r9o2tjr5bEg8qk5mRPoItzXgyki
 CkKaA6KZlQ0G1JHu0qq3XGNtYoYuDrmL2eokiACgKE5+gkWEbsiiBQDAih5HopsGpNX+h6Q0tiC
 sT6NJ64X6urovJuZxqjKoH
X-Google-Smtp-Source: AGHT+IH2u1rNsbgyrZ6I0CGd0/8CBHKiqyLgNhKzO/od6TKTnYdDBv5AQErXroXMMTmK94lvSvKcWg==
X-Received: by 2002:a05:6e02:1d94:b0:420:f97:7446 with SMTP id
 e9e14a558f8ab-42e7ad9ae3emr48743055ab.22.1759523869330; 
 Fri, 03 Oct 2025 13:37:49 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42e77bc6893sm15126685ab.29.2025.10.03.13.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 13:37:48 -0700 (PDT)
Date: Fri, 3 Oct 2025 14:37:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Simon Glass <sjg@chromium.org>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Hans de Goede <hdegoede@redhat.com>, Mario Six <mario.six@gdsys.cc>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Roger Quadros <rogerq@kernel.org>, Bajjuri Praneeth <praneeth@ti.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 04/16] board: ti: Exclude cape detection from XPL builds
Message-ID: <20251003203746.GX6093@bill-the-cat>
References: <20251003-feature_sysboot_extension_board-v1-0-458b8bf85325@bootlin.com>
 <20251003-feature_sysboot_extension_board-v1-4-458b8bf85325@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tkRPPR3cKOKgKPPT"
Content-Disposition: inline
In-Reply-To: <20251003-feature_sysboot_extension_board-v1-4-458b8bf85325@bootlin.com>
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


--tkRPPR3cKOKgKPPT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 03, 2025 at 06:33:44PM +0200, Kory Maincent wrote:

> Disable cape detection functionality in XPL (eXtended Program Loader)
> images to reduce size and complexity in the early boot stage.
>=20
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  board/ti/common/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/board/ti/common/Makefile b/board/ti/common/Makefile
> index caf6b9fa8c1..ec8d314c332 100644
> --- a/board/ti/common/Makefile
> +++ b/board/ti/common/Makefile
> @@ -2,6 +2,8 @@
>  # Copyright (C) 2015-2016 Texas Instruments Incorporated - https://www.t=
i.com/
> =20
>  obj-${CONFIG_TI_I2C_BOARD_DETECT} +=3D board_detect.o
> +ifndef CONFIG_XPL_BUILD
>  obj-${CONFIG_CMD_EXTENSION} +=3D cape_detect.o
> +endif
>  obj-${CONFIG_OF_LIBFDT} +=3D fdt_ops.o
>  obj-${CONFIG_ARCH_K3} +=3D k3-ddr.o

Either here, or maybe later in the series when removing then-legacy
code, this should use one of the other non-CMD options and if needed,
instead of gating with checking for CONFIG_XPL_BUILD,
obj-$(CONFIG_$(PHASE_)FOO) will make things easier in a future where we
do need to handle extensions in some xPL phase.

--=20
Tom

--tkRPPR3cKOKgKPPT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOA0GQAKCRAr4qD1Cr/k
CsczAP0VMvZoTn0QqxD1UNBK7ov4G38bpA1f+0anW5ZM8f5aGwEA99ZDy6AicQT+
6I4JWyfAhAc35GJ5c5g5Tfi1slxVYgE=
=bK/4
-----END PGP SIGNATURE-----

--tkRPPR3cKOKgKPPT--
