Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461E1C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 21:44:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCA288070C;
	Thu, 27 Mar 2025 22:44:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W3jFtFsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D546E80ECC; Thu, 27 Mar 2025 22:43:58 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4F2D806FC
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 22:43:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-39127512371so915976f8f.0
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 14:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743111836; x=1743716636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cev1h5zWPn8O3YGwwOJS0uoWqT2s8ZiKeMyS4YSkEqw=;
 b=W3jFtFsjzrroKjXfEDa/U9ZLvLZYtVZClQ8BTJNPVoaT4dyq3V6dsJspxiHcTdj0Mp
 EHJFhbK0K34k/cp1JfaARewAvzM1MGE0U7ykz3xoqXKBc2O1KrUjLXdyNuwQPcTcfrud
 EDp3biSMyo5J/HEq9bhcE9DIyRt/tywjcDvu8HgU1deBrdhKHdo0CBrD+6twnAeSFmca
 StELaOn4q9vQZCe8LhdAToEcaAeVi4HcgP1RWtH9Gonlkt0W+e1RfOU3iR9wsVw4+IZr
 dh3mxyZBvGHNTeppZ2atVJVinpSm6/DBXCfIB+vKV7Lbt1eD/Rh1PTjc8yUqUELfA4w5
 XY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743111836; x=1743716636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cev1h5zWPn8O3YGwwOJS0uoWqT2s8ZiKeMyS4YSkEqw=;
 b=d9C++uL4Q1uT0zTFYkzoDJkZaFW+UyxX65TF6VJKy2QagsBN0zCfFHy8BqIrt2mtGG
 6M4QhAJsDdxO3CmuCiLy7h5naFddOjFZgVXUu6PUgDlIUH2VEZRyZF0hYobPMzU9KjB4
 Tb+4rBxGJV8d5u1mIECBacTz0nmMlmRVGFOA2+8REGuKnbxTNf4atteexdDB/W7gi73c
 VcB0XyVFbw5KQElBdESMng+l9nMWclBTLavKxBg7IEam3pTbHVgWLezwHyhaoWnSWPvF
 mfsh2J/JJTGLPffHnhASf9Oq21ktxyAupCuVDPjCjEvVz4Bsg6V5k7IYPU+T7IR1WBJb
 GP4A==
X-Gm-Message-State: AOJu0YzzPA8281q0PzMXoq38vM7oUToUY9WUl3VlyIuY561VgvlWQfKL
 J58CVIzDubbogm4837k5xX18S/TtrygNvGu/bYdeh0i0HvaK9cExfUoDmw==
X-Gm-Gg: ASbGncsucxQrVGUJSQFW9mDhYx+TnrOJkXixpQgPapP722HecjfZ5ZiWPR0w9sOhED1
 oJ2023lI5IvkJGQMa/uPsBa61ZAMLuulmRYfKbsXLdtbpUg6bZEWw9fZhfCr11Bwo/x84XQYk32
 gPE04s84Ym/Zii+4kWgJtDnYbG5krI5jehUO8ke4P9bPuOYWcRz8iczDrypYol9GzMCec5T5lUa
 cbs4g4CBmF5NmXk5TMKAjngaahI/FHgdtyW0Qk+fqzu2dhgt3GRUwmZGa3nyagX4a9+wewB+RMN
 ICybFr/zD0ikzlJ0ck+7G2n2UwS/20N+zDdSw6kWpFEs4iwDxFdpXtQawvnKrFz+gBWYCzYz4vx
 3sYgHHyzuIpCDEaUNNFMS
X-Google-Smtp-Source: AGHT+IFaNdszCoMZj8jqW19YSWSH2PETw+Q8/TrV7NdwqP8xcBJnwsloiU66eKnil0Jl8p7SqjJvUw==
X-Received: by 2002:a05:6000:1a8d:b0:390:e1c5:fe2 with SMTP id
 ffacd0b85a97d-39ad177b8f8mr5466252f8f.38.1743111835994; 
 Thu, 27 Mar 2025 14:43:55 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4181sm640512f8f.83.2025.03.27.14.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Mar 2025 14:43:55 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] sunxi: h616: defconfigs: enable eMMC
Date: Thu, 27 Mar 2025 22:43:54 +0100
Message-ID: <2772843.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20250327212102.26893-1-andre.przywara@arm.com>
References: <20250327212102.26893-1-andre.przywara@arm.com>
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

Dne =C4=8Detrtek, 27. marec 2025 ob 22:21:02 Srednjeevropski standardni =C4=
=8Das je Andre Przywara napisal(a):
> Now that eMMC is working properly on H616 devices, it became apparent
> that some boards were missing the right defconfig bits to enable eMMC
> access.
>=20
> Add the eMMC device number to the Tanix TX1 and the X96 Mate defconfig,
> also the eMMC boot option to the TX1. Oddly enough the X96 Mate had
> just this bit already.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Expected consequence of the fix :)

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  configs/tanix_tx1_defconfig | 2 ++
>  configs/x96_mate_defconfig  | 1 +
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/configs/tanix_tx1_defconfig b/configs/tanix_tx1_defconfig
> index 28cf9513c30..00e34dc5ad9 100644
> --- a/configs/tanix_tx1_defconfig
> +++ b/configs/tanix_tx1_defconfig
> @@ -14,11 +14,13 @@ CONFIG_MACH_SUN50I_H616=3Dy
>  CONFIG_SUNXI_DRAM_H616_LPDDR3=3Dy
>  CONFIG_R_I2C_ENABLE=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
> +CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_SPL_I2C=3Dy
>  CONFIG_SPL_SYS_I2C_LEGACY=3Dy
>  CONFIG_SYS_I2C_MVTWSI=3Dy
>  CONFIG_SYS_I2C_SLAVE=3D0x7f
>  CONFIG_SYS_I2C_SPEED=3D400000
> +CONFIG_SUPPORT_EMMC_BOOT=3Dy
>  CONFIG_AXP313_POWER=3Dy
>  CONFIG_AXP_DCDC3_VOLT=3D1200
>  CONFIG_USB_EHCI_HCD=3Dy
> diff --git a/configs/x96_mate_defconfig b/configs/x96_mate_defconfig
> index bd9b611d6f5..c0628370df9 100644
> --- a/configs/x96_mate_defconfig
> +++ b/configs/x96_mate_defconfig
> @@ -11,6 +11,7 @@ CONFIG_DRAM_SUNXI_TPR11=3D0xffffdddd
>  CONFIG_DRAM_SUNXI_TPR12=3D0xfedf7557
>  CONFIG_MACH_SUN50I_H616=3Dy
>  CONFIG_SUNXI_DRAM_H616_DDR3_1333=3Dy
> +CONFIG_MMC_SUNXI_SLOT_EXTRA=3D2
>  CONFIG_R_I2C_ENABLE=3Dy
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_I2C=3Dy
>=20




