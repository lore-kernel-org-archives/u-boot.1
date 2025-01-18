Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D3EC02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 07:36:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C71880657;
	Sat, 18 Jan 2025 08:36:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hkPRqZn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CCD8073D; Sat, 18 Jan 2025 08:36:00 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D48EB8063E
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 08:35:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa69107179cso558948966b.0
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 23:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737185757; x=1737790557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFfb2CIQrD6kRllvfHb30BWuDXJjoWaAWKkp8pJqplw=;
 b=hkPRqZn+0o+sVbPgbxZpfHAo/U+17whVfrgpILKlc/mWzGrSSFfRr1IEJUUWC+Lt39
 O9dGXrdkkyTCX9bZoOHCPNfSwaCuJF6w2Or3iyn3RFpCDf25lNozFgucUy5Vr7WulQaF
 JAcwZgG2O8EaYOvDpHtTlI5TN3Siuya6oDpWZaQPwCXQF5acqwoVef7xZFwEp8pvp3cx
 V1TSN/xXJTvWKXa4sCD0iApKDU03sGiyvyt0OMxS13GcVUpPAdWYqdlnvUXZqz5PLWeQ
 5ctUeazdc7xLQIInciMFNjJtM2xTVI+uSncblB/YYJjHED3jkUONavoAmwAVjfroe+PJ
 onSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737185757; x=1737790557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFfb2CIQrD6kRllvfHb30BWuDXJjoWaAWKkp8pJqplw=;
 b=SHxE2olv8QdEALm4DbaqJYk9XeFCJk7U0rIMrmm33nrVUIjN2Arg6Ay4yv+ksLMPwh
 /n48Vdyn5WV5Oj/MqLtz3/050tbz3mTviTl7kl4tfNawcDWUgfSnd9ogK4sbbVcKw28Q
 G3CZdgp0fLjwxTFxS7dEkwfiyQpekVwP1f/8nkQQyNdh6mI0njYV19FVT+r34Cgbal8t
 hv5EImrNheXenpr2V9ikIzAZrdWGXZvA4pmW6gE6vGMWh1hisRJztaC1eNO8nn4KvaL6
 St/ObjLn214sIgP3EdjPRcwDNL0xRuR3usqHFe+2kjKCb1VTw9zFp/nMw5uZpXQQvH4T
 hcaw==
X-Gm-Message-State: AOJu0Yx78dxes0GwseLy9s1Rd86W/xeMWQx7z6h3ScXKCSndyqgG2ylU
 HTK2ZqG0K9yFmocTz6hTW5OC3/1UTqMhSdbfEH1XfLtZId2OA2CqDF74KA==
X-Gm-Gg: ASbGnctPmwC5NQ3XRwe1Iu9IHEQPE+V81ZgrrkodTHPQriX/mrG+JVu5x/hXvsxAXGz
 xX0M/YAZggmpVKoe1nWBrfxEqpqkNzVpWYy6T84dMdqFh0SuNKgDqTopLFNayy4atHx/enlOW5d
 tJqIlh7Xs9sjtixApTRmAEqqHdFX5UpiM3K2CD8iehuTAlrPfRH2Uf+g5FgxxCBIYwsR/xDuwso
 AyNsZTPsOYQyFbh4w6xi5r7gIjOH1xMOvTAn0ZfZivQ5Ef+RQghTzoUGM4sR+a+WYfOuYAlvXSB
 glzqvKFR1lCfanE=
X-Google-Smtp-Source: AGHT+IGocHI3aTR2ZUrqN6A39kJbV5BtWG2r+W2W9tkbuAxTKyroUlAvk2cRFU0bmvaceagqW988GA==
X-Received: by 2002:a17:907:930b:b0:aab:c78c:a705 with SMTP id
 a640c23a62f3a-ab38b3d4253mr517302966b.52.1737185757129; 
 Fri, 17 Jan 2025 23:35:57 -0800 (PST)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384c61276sm296788166b.13.2025.01.17.23.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 23:35:56 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Tom Rini <trini@konsulko.com>, Cody Eksal <masterr3c0rd@epochal.quest>,
 Simon Glass <sjg@chromium.org>, linux-sunxi@lists.linux.dev,
 Parthiban <parthiban@linumiz.com>
Subject: Re: [PATCH 8/8] sunxi: add support for the Allwinner A100/A133 SoC
Date: Sat, 18 Jan 2025 08:35:55 +0100
Message-ID: <1989237.PYKUYFuaPT@jernej-laptop>
In-Reply-To: <20250117014537.22513-9-andre.przywara@arm.com>
References: <20250117014537.22513-1-andre.przywara@arm.com>
 <20250117014537.22513-9-andre.przywara@arm.com>
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

Dne petek, 17. januar 2025 ob 02:45:37 Srednjeevropski standardni =C4=8Das =
je Andre Przywara napisal(a):
> The Allwinner A100 SoC has been around for a while, mostly on cheap
> tablets, but didn't generate much interest in the community so far.
> There were some efforts by two Allwinner employees in 2020, which led
> to basic upstream Linux support for that SoC, although this momentum
> dried up pretty quickly, leaving a lot of peripherals unsupported.
>=20
> The A100 was silently replaced with the seemingly identical Allwinner
> A133, which is reportedly a better bin of the A100. So far we assume
> that both are compatible from a software perspective. There are some
> more devices with the A133 out there now, so people are working on
> filling the gaps, and adding U-Boot (and TF-A) support.
>=20
> Based on the just added pinctrl, clock and DRAM support, this adds the
> missing bits, mostly addresses and values for the SPL.
>=20
> The A133 seems to be an predecessor to the H6, so we can share a lot of
> code with that (and the H616 code), and just need to adjust some details.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Pretty standard stuff, just one remark below.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

> ---
>  arch/arm/cpu/armv8/fel_utils.S                    |  2 +-
>  arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h |  7 +++++++
>  arch/arm/mach-sunxi/Kconfig                       | 11 +++++++++--
>  arch/arm/mach-sunxi/board.c                       |  4 ++++
>  arch/arm/mach-sunxi/clock_sun50i_h6.c             |  3 ++-
>  arch/arm/mach-sunxi/cpu_info.c                    |  2 ++
>  board/sunxi/board.c                               |  8 ++++++--
>  common/spl/Kconfig                                |  6 +++---
>  8 files changed, 34 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm/cpu/armv8/fel_utils.S b/arch/arm/cpu/armv8/fel_util=
s.S
> index 939869b9ffa..c9f3990226e 100644
> --- a/arch/arm/cpu/armv8/fel_utils.S
> +++ b/arch/arm/cpu/armv8/fel_utils.S
> @@ -41,7 +41,7 @@ ENTRY(return_to_fel)
>  	str	w2, [x1]
> =20
>  	ldr	w0, =3D0xfa50392f		// CPU hotplug magic
> -#ifdef CONFIG_MACH_SUN50I_H616
> +#if defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_A133)
>  	ldr	w2, =3D(SUNXI_R_CPUCFG_BASE + 0x1c0)
>  	str	w0, [x2], #0x4
>  #elif CONFIG_MACH_SUN50I_H6
> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm=
/include/asm/arch-sunxi/clock_sun50i_h6.h
> index 76dd33c9477..6c1d36836dd 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
> @@ -285,6 +285,13 @@ struct sunxi_ccm_reg {
>  #define CCM_PLL6_DEFAULT		0xe8216300
>  #define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002
>  #define CCM_APB1_DEFAULT		0x03000102
> +
> +#elif CONFIG_MACH_SUN50I_A133				/* A133 */
> +
> +#define CCM_PLL6_DEFAULT		0xb8003100
> +#define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002
> +#define CCM_AHB3_DEFAULT		0x03000002
> +#define CCM_APB1_DEFAULT		0x03000102
>  #endif
> =20
>  /* apb2 bit field */
> diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
> index ccf0c9a403e..b203244eb95 100644
> --- a/arch/arm/mach-sunxi/Kconfig
> +++ b/arch/arm/mach-sunxi/Kconfig
> @@ -300,6 +300,7 @@ config SUNXI_SRAM_ADDRESS
>  config SUNXI_RVBAR_ADDRESS
>  	hex
>  	depends on ARM64
> +	default 0x08100040 if MACH_SUN50I_A133
>  	default 0x09010040 if SUN50I_GEN_H6
>  	default 0x017000a0
>  	---help---
> @@ -326,8 +327,8 @@ config SUNXI_RVBAR_ALTERNATIVE
>  config SUNXI_BL31_BASE
>  	hex
>  	default 0x00044000 if MACH_SUN50I || MACH_SUN50I_H5
> -	default 0x00104000 if MACH_SUN50I_H6
>  	default 0x40000000 if MACH_SUN50I_H616
> +	default 0x00104000 if SUN50I_GEN_H6
>  	default 0x0
>  	help
>  	  Address where BL31 (TF-A) is loaded, or zero if BL31 is not used.
> @@ -409,7 +410,7 @@ config MACH_SUNXI_H3_H5
>  # TODO: try out A80's 8GiB DRAM space
>  config SUNXI_DRAM_MAX_SIZE
>  	hex
> -	default 0x100000000 if MACH_SUN50I_H616
> +	default 0x100000000 if MACH_SUN50I_H616 || MACH_SUN50I_A133
>  	default 0xC0000000 if MACH_SUN50I || MACH_SUN50I_H5 || MACH_SUN50I_H6
>  	default 0x80000000
> =20
> @@ -606,6 +607,10 @@ config MACH_SUN50I_H616
> =20
>  config MACH_SUN50I_A133
>  	bool "sun50i (Allwinner A133)"
> +	select ARM64
> +	select DRAM_SUN50I_A133
> +	select SUN50I_GEN_H6
> +	imply OF_UPSTREAM
> =20
>  endchoice
> =20
> @@ -894,6 +899,7 @@ config SYS_CLK_FREQ
>  	default 888000000 if MACH_SUN50I_H6
>  	default 1008000000 if MACH_SUN50I_H616
>  	default 1008000000 if MACH_SUN8I_R528
> +	default 1008000000 if MACH_SUN50I_A133

Since 1008000000 looks like being default for most supported SoCs, why not
make it default in last line? Upcomming A523 will have it too and it would
allow to make diff smaller.

Best regards,
Jernej

> =20
>  config SYS_CONFIG_NAME
>  	default "suniv" if MACH_SUNIV
> @@ -907,6 +913,7 @@ config SYS_CONFIG_NAME
>  	default "sun50i" if MACH_SUN50I
>  	default "sun50i" if MACH_SUN50I_H6
>  	default "sun50i" if MACH_SUN50I_H616
> +	default "sun50i" if MACH_SUN50I_A133
> =20
>  config SYS_BOARD
>  	default "sunxi"
> diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
> index 701899ee4b2..264dd6a7460 100644
> --- a/arch/arm/mach-sunxi/board.c
> +++ b/arch/arm/mach-sunxi/board.c
> @@ -134,6 +134,10 @@ static int gpio_init(void)
>  	sunxi_gpio_set_cfgpin(SUNXI_GPH(0), SUN50I_H616_GPH_UART0);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPH(1), SUN50I_H616_GPH_UART0);
>  	sunxi_gpio_set_pull(SUNXI_GPH(1), SUNXI_GPIO_PULL_UP);
> +#elif CONFIG_CONS_INDEX =3D=3D 1 && defined(CONFIG_MACH_SUN50I_A133)
> +	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN50I_H616_GPH_UART0);
> +	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN50I_H616_GPH_UART0);
> +	sunxi_gpio_set_pull(SUNXI_GPB(10), SUNXI_GPIO_PULL_UP);
>  #elif CONFIG_CONS_INDEX =3D=3D 1 && defined(CONFIG_MACH_SUN8I_A83T)
>  	sunxi_gpio_set_cfgpin(SUNXI_GPB(9), SUN8I_A83T_GPB_UART0);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPB(10), SUN8I_A83T_GPB_UART0);
> diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/=
clock_sun50i_h6.c
> index b424a7893ea..9797dca1e1d 100644
> --- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
> +++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
> @@ -90,7 +90,8 @@ void clock_set_pll1(unsigned int clk)
>  	/* clk =3D 24*n/p, p is ignored if clock is >288MHz */
>  	val =3D CCM_PLL1_CTRL_EN | CCM_PLL1_LOCK_EN | CCM_PLL1_CLOCK_TIME_2;
>  	val |=3D CCM_PLL1_CTRL_N(clk / 24000000);
> -	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616))
> +	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
> +	    IS_ENABLED(CONFIG_MACH_SUN50I_A133))
>  	       val |=3D CCM_PLL1_OUT_EN;
>  	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
>  	       val |=3D CCM_PLL1_OUT_EN | CCM_PLL1_LDO_EN;
> diff --git a/arch/arm/mach-sunxi/cpu_info.c b/arch/arm/mach-sunxi/cpu_inf=
o.c
> index 310dca06e57..3f4735d4717 100644
> --- a/arch/arm/mach-sunxi/cpu_info.c
> +++ b/arch/arm/mach-sunxi/cpu_info.c
> @@ -104,6 +104,8 @@ int print_cpuinfo(void)
>  	puts("CPU:   Allwinner H6 (SUN50I)\n");
>  #elif defined CONFIG_MACH_SUN50I_H616
>  	puts("CPU:   Allwinner H616 (SUN50I)\n");
> +#elif defined CONFIG_MACH_SUN50I_A133
> +	puts("CPU:   Allwinner A133 (SUN50I)\n");
>  #else
>  #warning Please update cpu_info.c with correct CPU information
>  	puts("CPU:   SUNXI Family\n");
> diff --git a/board/sunxi/board.c b/board/sunxi/board.c
> index a4a84d652d8..7ed1f96a4fb 100644
> --- a/board/sunxi/board.c
> +++ b/board/sunxi/board.c
> @@ -113,10 +113,14 @@ void i2c_init_board(void)
>  	clock_twi_onoff(5, 1);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPL(8), SUN50I_GPL_R_TWI);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPL(9), SUN50I_GPL_R_TWI);
> -#elif CONFIG_MACH_SUN50I_H616
> +#elif defined(CONFIG_MACH_SUN50I_H616)
>  	clock_twi_onoff(5, 1);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN50I_H616_GPL_R_TWI);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN50I_H616_GPL_R_TWI);
> +#elif CONFIG_MACH_SUN50I_A133
> +	clock_twi_onoff(5, 1);
> +	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN50I_GPL_R_TWI);
> +	sunxi_gpio_set_cfgpin(SUNXI_GPL(1), SUN50I_GPL_R_TWI);
>  #else
>  	clock_twi_onoff(5, 1);
>  	sunxi_gpio_set_cfgpin(SUNXI_GPL(0), SUN8I_H3_GPL_R_TWI);
> @@ -434,7 +438,7 @@ static void mmc_pinmux_setup(int sdc)
>  			sunxi_gpio_set_pull(pin, SUNXI_GPIO_PULL_UP);
>  			sunxi_gpio_set_drv(pin, 2);
>  		}
> -#elif defined(CONFIG_MACH_SUN50I_H616)
> +#elif defined(CONFIG_MACH_SUN50I_H616) || defined(CONFIG_MACH_SUN50I_A13=
3)
>  		/* SDC2: PC0-PC1, PC5-PC6, PC8-PC11, PC13-PC16 */
>  		for (pin =3D SUNXI_GPC(0); pin <=3D SUNXI_GPC(16); pin++) {
>  			if (pin > SUNXI_GPC(1) && pin < SUNXI_GPC(5))
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index 4e56d9909c8..ce075a58193 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -81,8 +81,8 @@ config SPL_MAX_SIZE
>  	default 0xec00 if OMAP34XX
>  	default 0x10000 if ARCH_MX6 && !MX6_OCRAM_256KB
>  	default 0x7fa0 if SUNXI_SRAM_ADDRESS =3D 0x10000
> -	default 0x7fa0 if SUNXI_SRAM_ADDRESS =3D 0x20000 && !MACH_SUN50I_H616
> -	default 0xbfa0 if MACH_SUN50I_H616
> +	default 0xbfa0 if MACH_SUN50I_H616 || MACH_SUN50I_A133
> +	default 0x7fa0 if SUNXI_SRAM_ADDRESS =3D 0x20000
>  	default 0x7000 if RCAR_GEN3
>  	default 0x5fa0 if SUNXI_SRAM_ADDRESS =3D 0x0
>  	default 0x10000 if ASPEED_AST2600
> @@ -397,7 +397,7 @@ config SPL_STACK
>  	default 0x91ffb8 if ARCH_MX6 && !MX6_OCRAM_256KB
>  	default 0x118000 if MACH_SUN50I_H6
>  	default 0x52a00 if MACH_SUN50I_H616
> -	default 0x40000 if MACH_SUN8I_R528
> +	default 0x40000 if MACH_SUN8I_R528 || MACH_SUN50I_A133
>  	default 0x54000 if MACH_SUN50I || MACH_SUN50I_H5
>  	default 0x18000 if MACH_SUN9I
>  	default 0x8000 if ARCH_SUNXI
>=20




