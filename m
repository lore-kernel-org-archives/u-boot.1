Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE99CA0ED1
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 15:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C58483102;
	Mon, 11 Aug 2025 17:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QPUTF6oY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D0E283118; Mon, 11 Aug 2025 17:51:12 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2516A830CA
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 17:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3b79bdc9a7dso2761506f8f.1
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 08:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754927466; x=1755532266; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AFlIpcxIhb8jIwr3aESzJkFzlO4zyyqAODuwsxdMWSQ=;
 b=QPUTF6oYsJkLD/oZ0J+2Q3GbptJmfK9KtgWVFIc904PcmiuWKMMGTvcDh6/4vZ1PQC
 1XneQIl7ohrZ8oiNg53IZZV8kwvfJ5C7UB+DEDcfm5xOnrq8gH4VbxaDgTitbnQg3eRd
 huV07xvA6KRNWUVNKOx3fqrhywU0adPqs2RLVyAFP1eOjDYynApz8/fcDMvrpPIUimWA
 2U07Bb7leId5OPflG4Nr+tMrVsauLVAQUF+Tsxikg0IQwQEyYO8e+SSDyfhFM1Q8Peo4
 FbqK+sotQFI3OyUvUVp9y25B6SYETcopmi3re6yR8yn8JxASR02L0VsoKxhjW+TQkjIN
 Cq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754927466; x=1755532266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AFlIpcxIhb8jIwr3aESzJkFzlO4zyyqAODuwsxdMWSQ=;
 b=iM7F+1Gj+uHSrzH55+HoLJuETdCLdZs4qoV+cjEpo5SoxPhhJPUBeczW1bHeL1WH/p
 iFV0kgh8bkrIFVSGO17BtXbQOePeC6JkFZDlgOeGZ7oVlW1MRRrmomNa0ybyI9Yyv8gc
 2HBRIDJPg/FEh6zFFjDHb3bK9t8+G8kNRsBqYkcQLH2f7ET2RJWGuJZzxmVa8fhVSm5G
 /XrK1SabjuLnvPFXDwjQSchwiJcPrwGPMgEkhl45pBkndb3VviDBqrrOWMXvKOjPOJ/p
 9LnZ5V9ANwqTwQwnStlY9NUXStfJ7TeYwruOdupr8HwsP9u8L0fHw8nxmHcgTMOHJek6
 x6dw==
X-Gm-Message-State: AOJu0YyiXIkWySGNnHvYeSnMavACCO+lu0ZkwDhZgv/OoeLvCBZkXef2
 aP3AgAhy6z07uXoiylCE5oyQLgM5KYHtKpS2+xbc2gFgIRZQFh3CrEkMU7NbRA==
X-Gm-Gg: ASbGncveK9VcZExWraIMCgeOKTBXgK7mGx4/G6CHbxw35aWVlIgkmz+eA8DS4ECxNNo
 8R+6MZiDhhh8YEvjR5ch/eunnf6e7qWu9fyAx+5fMnLZ08PWzxKQdiD74qkLggagajCPNhnm+ly
 gUsDrdEbeJFuJ3hnSZm8ZwrRTKWmWokudAy8YqkgreroiGwt7gpoDT4Gdr3RHSCvmk8vh3I28cq
 4Skgis/6oJmuLO3imRyqhMm+iZXhJXLU07e3tI6mI/SE4NEzVl7N3kXHFFViTcch+8FT7gmjDC0
 yNubQnXFXsC+GQAzxx/12y+Cdqfc3KJRJrDT8TcV2OvULFkLDkm2MbPneSEtiVvaFPDxcxA0xeN
 E6KB2rBeVwxTT2ICuP3Hu7D7taUxTifvBBwgxaT2++T1Y7ViBX10GSrsyENvgx/7I8t4m59jRuQ
 ==
X-Google-Smtp-Source: AGHT+IE1Z/OwXpmIyVxoQR2b0gzAwurG+djLreoBByz8GelvHh6V2irjTLWzn/EqxycJHehXewid+Q==
X-Received: by 2002:a05:6000:220c:b0:3b7:8abc:eba2 with SMTP id
 ffacd0b85a97d-3b900b4f140mr9419959f8f.20.1754927466454; 
 Mon, 11 Aug 2025 08:51:06 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e587e154sm280301455e9.27.2025.08.11.08.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:51:06 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev,
 Mikhail Kalashnikov <iuncuim@gmail.com>, Yixun Lan <dlan@gentoo.org>,
 Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 2/2] sunxi: a527: radxa/avaota: enable Ethernet
Date: Mon, 11 Aug 2025 17:51:05 +0200
Message-ID: <3294117.5fSG56mABF@jernej-laptop>
In-Reply-To: <20250801002726.8924-3-andre.przywara@arm.com>
References: <20250801002726.8924-1-andre.przywara@arm.com>
 <20250801002726.8924-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne petek, 1. avgust 2025 ob 02:27:26 Srednjeevropski poletni =C4=8Das je A=
ndre Przywara napisal(a):
> The first of the two Ethernet controllers in the Allwinner A527/T527 is
> compatible to the MAC from the previous SoCs. Consequently the recent DT
> update brought use the MAC node, using the A64 compatible string as the
> fallback, which works out of the box.
>=20
> Enable the sun8i-emac Ethernet driver in the defconfig for the Radxa and
> the Avaota boards, so that kernels and other data can be loaded via
> TFTP. Please note that only one of the Ethernet sockets will work, the
> second MAC is not compatible, and needs a new U-Boot driver. The
> X96QPro+ TV box unfortunately uses only this second EMAC, so Ethernet
> cannot be used there at the moment.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  configs/avaota-a1_defconfig       | 2 ++
>  configs/radxa-cubie-a5e_defconfig | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/configs/avaota-a1_defconfig b/configs/avaota-a1_defconfig
> index 55457edd3b3..a4582c00d5b 100644
> --- a/configs/avaota-a1_defconfig
> +++ b/configs/avaota-a1_defconfig
> @@ -22,6 +22,8 @@ CONFIG_SYS_I2C_MVTWSI=3Dy
>  CONFIG_SYS_I2C_SLAVE=3D0x7f
>  CONFIG_SYS_I2C_SPEED=3D400000
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_REGULATOR_AXP=3Dy
>  CONFIG_AXP717_POWER=3Dy
>  CONFIG_AXP_I2C_ADDRESS=3D0x35
> diff --git a/configs/radxa-cubie-a5e_defconfig b/configs/radxa-cubie-a5e_=
defconfig
> index 88019acf576..9d204ef5548 100644
> --- a/configs/radxa-cubie-a5e_defconfig
> +++ b/configs/radxa-cubie-a5e_defconfig
> @@ -22,6 +22,8 @@ CONFIG_SYS_I2C_MVTWSI=3Dy
>  CONFIG_SYS_I2C_SLAVE=3D0x7f
>  CONFIG_SYS_I2C_SPEED=3D400000
>  CONFIG_SUPPORT_EMMC_BOOT=3Dy
> +CONFIG_PHY_REALTEK=3Dy
> +CONFIG_SUN8I_EMAC=3Dy
>  CONFIG_REGULATOR_AXP=3Dy
>  CONFIG_AXP717_POWER=3Dy
>  CONFIG_AXP_DCDC2_VOLT=3D920
>=20




