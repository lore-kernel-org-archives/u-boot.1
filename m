Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE4BCD4F25
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 17:37:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9750D836AC;
	Tue, 12 May 2026 19:37:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pBBoijZl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B12EE838BB; Tue, 12 May 2026 19:37:10 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2BEC8341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 19:37:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso65635345e9.1
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778607428; x=1779212228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YUFfTVnu1jI7he9F6ikRzcaMbvnkj6ojyItrG0mbID8=;
 b=pBBoijZlj6DRMG+aWIA8kBuRhUnbckg4Lv80IGNODTNIdEKBCvHI19Qwuy4TStLJPd
 2IRq7GC2EqAApBssTY1Yj10I/Dy+psSQ3NdcS2FbuxAw8h13R1SWvBJhqRuSpJ86csQi
 oCQdCmmCe6SVoaEYooel9MQlGw3pbLe2+YutUqqM9j17aQjVguz0RW8uZZkuz1Q/n0SZ
 737nRg8xjmFliKzD3op+2XwK0nzXn5abntF0rg1W+NOQBejPqvY8SSDVsINkPSvQ2DFg
 Mfbt8Q17bKAvQVvaofEEeQdeTkC9CnujdvL/utow+PKjWEAqiWbZE66JBgOK75oxmlIU
 vnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778607428; x=1779212228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YUFfTVnu1jI7he9F6ikRzcaMbvnkj6ojyItrG0mbID8=;
 b=TOuW13j3wsuKQC5rPoZBBLd71+oDnI8k6TZot/wKu8nAEnZQfO41coxGOKqSdSuW56
 uzAgfuYxIISVWRshMhlk9YOnxlKAOcaFsLGoOhKb6LUWP0pzBSW28H+MEZSSk4+SzXse
 Ei5z9D4Y0HKHLHCbQGAjPlJsCsfys0CofNwVeFfCJB7mgha8hXn8X2/Y8dcSuireFUJa
 W2Y9czLniaawYpuCUpuVMuta2dgwz3/oPbqdqT2lAycWVoSWoBD2XhxNBZXzmIvSEQNF
 F/sT3WqOUPBOV+r1rEQBvlRb9W1BXt3PtV6AFgbitL3z3/dYpabLTlcOe/aLxsIX/Mw1
 dHrw==
X-Gm-Message-State: AOJu0YzPbniA5OsqPLFxugNaP5FNbYeoX2Tbn80B4Ecg0gk0mXjPayYv
 1uY6vCI/b0mft8uQ9CVUpPFd4MwgsfJszl6cx/PmgGGAW23ypO4d0SzoWgQHKQ==
X-Gm-Gg: Acq92OGdqnf0BFno5Z4+YPiZ9kFo7/byXiiporHMGN8ZmHC6Av0oYDDq6E1X5zGnvJK
 7J6JeTmZcBMXo5YlHJ6eUKXsb/n9GUnJsGUjR+Emp+KK4xRR6ZeYnSwmdf8D+Z7MS25N7ZKf2Zo
 YHAE1Lj7Sb006788aVqqjo4WFENX+qkVtHUw6JkHqR0OIUKgeSkiJAdiJjzHF+qnSnnWHyJ5U6t
 p9yJLc3yAzxZXBz3OhPN/M8y7jKel77SvzUJY+UAWfgfEn+3PKoDZ2u14kaOFq6Ebp83aM0cXDL
 nzMdUtc0zGVeHDJAvMpbDYnTLoTG1sOtP76XGWZXYELmIsJA+F+B4+YWEUrGRqIlrYYSENIaKec
 AOIHT+O+XKh6M5gTOGUYt5S6ktS6xXhddjZQX+jdPK1AknZ9A+MRD2oCdfGg+fZ52lFXQWMcE4G
 esUcSzSAXmpecqJlQ4WggeU3XRzAGlKelFxvpj6plW+ai4+0Zt1xc497dh+EmlWf9XFiQ8oIPB4
 9Thvn8OLjHspI30Ag==
X-Received: by 2002:a05:600c:3b99:b0:486:faa8:9e4 with SMTP id
 5b1f17b1804b1-48e906c4525mr56038705e9.12.1778607427994; 
 Tue, 12 May 2026 10:37:07 -0700 (PDT)
Received: from jernej-laptop.localnet (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d16bbdsm10829585e9.1.2026.05.12.10.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 10:37:07 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Chen-Yu Tsai <wens@kernel.org>,
 Paul Kocialkowski <contact@paulk.fr>, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/5] sunxi: spl: spi: Clean up SPI0 pinmux setting
Date: Tue, 12 May 2026 19:37:06 +0200
Message-ID: <hxKgmanzT_ibK5FkulnCYg@gmail.com>
In-Reply-To: <20260511213713.15943-3-andre.przywara@arm.com>
References: <20260511213713.15943-1-andre.przywara@arm.com>
 <20260511213713.15943-3-andre.przywara@arm.com>
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

Dne ponedeljek, 11. maj 2026 ob 23:37:10 Srednjeevropski poletni =C4=8Das j=
e Andre Przywara napisal(a):
> The function to set the pinmux for the Port C SPI0 pins was looking more
> like a logic puzzle from a magazine than something that readers could
> understand and extend.
>=20
> Replace the convoluted pinmux setup, grouped by pin, with a simple array
> of the four pins involved, and just initialise this array at build time,
> based on the selected SoC.
>=20
> This makes it easy to see which pins are needed, and even easier to exten=
d.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm/mach-sunxi/spl_spi_sunxi.c | 43 ++++++++++++-----------------
>  1 file changed, 18 insertions(+), 25 deletions(-)
>=20
> diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/sp=
l_spi_sunxi.c
> index 5f72e809952..905a7db2a77 100644
> --- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
> +++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
> @@ -105,35 +105,28 @@
> =20
>  /*
>   * Allwinner A10/A20 SoCs were using pins PC0,PC1,PC2,PC23 for booting
> - * from SPI Flash, everything else is using pins PC0,PC1,PC2,PC3.
> - * The H6 uses PC0, PC2, PC3, PC5, the H616 PC0, PC2, PC3, PC4.
> + * from SPI Flash, later SoCs are using pins PC0,PC1,PC2,PC3.
> + * Newer SoCs are all over the place.
>   */
>  static void spi0_pinmux_setup(unsigned int pin_function)
>  {
> -	/* All chips use PC2. And all chips use PC0, except R528/T113 */
> -	if (!IS_ENABLED(CONFIG_MACH_SUN8I_R528))
> -		sunxi_gpio_set_cfgpin(SUNXI_GPC(0), pin_function);
> -
> -	sunxi_gpio_set_cfgpin(SUNXI_GPC(2), pin_function);
> +	const u16 spi0_pc_pins[4] =3D {
> +#if IS_ENABLED(CONFIG_MACH_SUN8I_R528)
> +		SUNXI_GPC(2), SUNXI_GPC(3), SUNXI_GPC(4), SUNXI_GPC(5)
> +#elif IS_ENABLED(CONFIG_MACH_SUN50I_H616)
> +		SUNXI_GPC(0), SUNXI_GPC(2), SUNXI_GPC(3), SUNXI_GPC(4)
> +#elif IS_ENABLED(CONFIG_MACH_SUN50I_H6)
> +		SUNXI_GPC(0), SUNXI_GPC(2), SUNXI_GPC(3), SUNXI_GPC(5)
> +#elif IS_ENABLED(CONFIG_MACH_SUN4I) || IS_ENABLED(CONFIG_MACH_SUN5I) || \

Are you sure about CONFIG_MACH_SUN5I? It seems to me that it should fall to=
 PC3 pin.
Also A13 datasheet confirms it.

Best regards,
Jernej

> +      IS_ENABLED(CONFIG_MACH_SUN7I) || IS_ENABLED(CONFIG_MACH_SUN8I_R40)
> +		SUNXI_GPC(0), SUNXI_GPC(1), SUNXI_GPC(2), SUNXI_GPC(23)
> +#else
> +		SUNXI_GPC(0), SUNXI_GPC(1), SUNXI_GPC(2), SUNXI_GPC(3)
> +#endif
> +	};
> =20
> -	/* All chips except H6/H616/R528/T113 use PC1. */
> -	if (!IS_ENABLED(CONFIG_SUN50I_GEN_H6) &&
> -	    !IS_ENABLED(CONFIG_MACH_SUN8I_R528))
> -		sunxi_gpio_set_cfgpin(SUNXI_GPC(1), pin_function);
> -
> -	if (IS_ENABLED(CONFIG_MACH_SUN50I_H6) ||
> -	    IS_ENABLED(CONFIG_MACH_SUN8I_R528))
> -		sunxi_gpio_set_cfgpin(SUNXI_GPC(5), pin_function);
> -	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
> -	    IS_ENABLED(CONFIG_MACH_SUN8I_R528))
> -		sunxi_gpio_set_cfgpin(SUNXI_GPC(4), pin_function);
> -
> -	/* Older generations use PC23 for CS, newer ones use PC3. */
> -	if (IS_ENABLED(CONFIG_MACH_SUN4I) || IS_ENABLED(CONFIG_MACH_SUN7I) ||
> -	    IS_ENABLED(CONFIG_MACH_SUN8I_R40))
> -		sunxi_gpio_set_cfgpin(SUNXI_GPC(23), pin_function);
> -	else
> -		sunxi_gpio_set_cfgpin(SUNXI_GPC(3), pin_function);
> +	for (int i =3D 0; i < 4; i++)
> +		sunxi_gpio_set_cfgpin(spi0_pc_pins[i], pin_function);
>  }
> =20
>  static bool is_sun6i_gen_spi(void)
>=20




