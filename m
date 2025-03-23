Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8BA1C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 11:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E15981E1F;
	Sun, 23 Mar 2025 12:57:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nc4J9gDi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A151781E3E; Sun, 23 Mar 2025 12:57:00 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6867581E13
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 12:56:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-399744f74e9so2058563f8f.1
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742731018; x=1743335818; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V35iV3c3lKQkTkxuIRQcJ5vWnxhrfUSIEivioihC/DY=;
 b=Nc4J9gDieb5fOIfkbS1RloFEfzYGnE4Jhc5HZAEGSWUudiw4KKI5F8IVdfD3i/uV+M
 ufQ3kR1Xk4kE37S8mJTBRiBvRgjnMIZQAmPPeJ+DiEdyhMR07Kx+j91sPux36e+lYTKN
 P1K9+ivW0tJr/xF3UvlMrMIGZOfoQQqYbZVJ6sPJ2sIhwdn5KUVFe6retOwUHMVGJjm6
 TglM6HDvel2eauAJSujW8GB48S0am0qqKIEZ9NlTeejv75Y30B66a8uS/4fskwIse/hs
 3V3jBy10faZixyJYUqdbmqkzvBDPwAv/x/t6YCj3cZozRBccP2RyOTXQ8Gs09oTzmG6Y
 OEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742731018; x=1743335818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V35iV3c3lKQkTkxuIRQcJ5vWnxhrfUSIEivioihC/DY=;
 b=QHwswDI6yaRoxCMkc5dQEFI4QWEAryWEDKq4Q+tku0QOhQMdgcD91sbizQBHZrq0tv
 QNRvkwSL5GCI3BjPcrP/h+yqJ04QdyJu2N4eBtxNpNW2MHCX9XLcIrZFfr2+gnnda38y
 hz8odLugG2DEViYO7vDmnic7XLaWSZzZOGt1VxXYE/I5UEZ5wdzyO2JtLQ0aBi65AGjB
 2QzwMFfjBl9VwfMhh1R3tsFjeVgVSzSUBuHYcCUWtguCNOPRHwI3sez7qBrZPOOnV7Ze
 chBxYm/KCc8aOiccq/fVp7XV1PU+87k5yAIeSp5v7ZY1FnXybT2Spop7O/GPaw8JL+Va
 S3EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB5j5+t+QsJAJ9+kCJ2eZBf7cQZu2KZCD7FtzcdXvF0VaCJKw5varLn8kwRzLsHmpMYgiorRE=@lists.denx.de
X-Gm-Message-State: AOJu0YwRhrnXn+pmjYZGV6lT9rzCFwf/o/f2QbcAQPcvOV66P6Pf9S/B
 o1WU9cE2BV2PW3Y6afiMWItlP63d8StmjUP5tPeRZC0mRuNJ99X+
X-Gm-Gg: ASbGncs/31+RPNZGehtY/I74p/Zmx/TPMRgZD3nMiJNJLZ6cM8tqj0rS8ghUj8QH2Dw
 9cbNZb0KOIgc97VOW/ep7KlNSp3riz5nm906xiHlgLPkcTyvXp91ac59tjaQ+i/Td7re+OLDK/r
 5BnKP9gMhouThlmpbK84ytVgGIAJbUzjpaoqF3kwSyc2wq3t9cNSg5JnVKjihfTT1+MPPT6Nm6c
 MGRLPQLOITYmvXF8bV6F9LcoytoYD39Swobe7nFlhypKyKhV0b1wbySG+7X7ktHLWofLDDVsyPN
 +2gVR1iPOI93CNqgIy/LIrM2owBYOPJuvpaoKTVGIK1d+RJuM7VT6t2BFSVlwaMgGwc/o9xuwl8
 t1cPUcQjTxEioujfNfjTP
X-Google-Smtp-Source: AGHT+IE42pznfgQ27+ZfECpbHFU1j1Tn/gZ/yQ+XMupuODbQN7fxybOFGPQt4wS+NjKcoFY3dqyFAA==
X-Received: by 2002:a5d:64a5:0:b0:391:31f2:b99e with SMTP id
 ffacd0b85a97d-3997f900bd7mr8476098f8f.2.1742731017482; 
 Sun, 23 Mar 2025 04:56:57 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f556afsm133751295e9.19.2025.03.23.04.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 04:56:57 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 01/34] sunxi: clock: H6: drop usage of struct sunxi_ccm_reg
Date: Sun, 23 Mar 2025 12:56:55 +0100
Message-ID: <4995090.31r3eYUQgx@jernej-laptop>
In-Reply-To: <20250323113544.7933-2-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-2-andre.przywara@arm.com>
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

Hi Andre!

Dne nedelja, 23. marec 2025 ob 12:35:11 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> U-Boot drivers often revert to using C structures for modelling hardware
> register frames. This creates some problems:
> - A "struct" is a C language construct to group several variables
>   together. The details of the layout of this struct are partly subject
>   to the compiler's discretion (padding and alignment).
> - The "packed" attribute would force a certain layout, but we are not
>   using it.
> - The actual source of information from the data sheet is the register
>   offset. Here we create an artificial struct, carefully tuning the
>   layout (with a lot of reserved members) to match that offset. To help
>   with correctness, we put the desired information as a *comment*,
>   though this is purely for the human reader, and has no effect on the
>   generated layout. This sounds all very backwards.
> - Using a struct suggests we can assign a pointer and then access the
>   register content via the members. But this is not the case, instead
>   every MMIO register access must go through specific accessor functions,
>   to meet the ordering and access size guarantees the hardware requires.
> - We share those structs in code shared across multiple SoC families,
>   though most SoCs define their own version of the struct. Members must
>   match in their name, across every SoC, otherwise compilation will fail.
>   We work around this with even more #ifdefs in the shared code.
> - Some SoCs have an *almost* identical layout, but differ in a few
>   registers. This requires hard to maintain #ifdef's in the struct
>   definition.
> - Some of the register frames are huge: the H6 CCU device defines 127
>   registers. We use 15 of them. Still the whole frame would need to be
>   described, which is very tedious, but for no reason.
> - Adding a new SoC often forces people to decide whether to share an
>   existing struct, or to create a new copy. For some cases (say like 80%
>   similarity) this works out badly either way.
>=20
> The Linux kernel heavily frowns upon those register structs, and instead
> uses a much simpler solution: #define REG_NAME	<offset>
> This easily maps to the actual information from the data sheet, and can
> much simpler be shared across multiple SoCs, as it allows to have all
> SoC versions visible, so we can use C "if" statements instead of #ifdef's.
> Also it requires to just define the registers we need, and we can use
> alternative locations for some registers much more easily.
>=20
> Drop the usage of "struct sunxi_ccm_reg" in the H6 SPL clock code, by
> defining the respective register names and their offsets, then adding
> them to the base pointer.
> We cannot drop the struct definition quite yet, as it's also used in
> other drivers, still.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../include/asm/arch-sunxi/clock_sun50i_h6.h  | 12 +++++
>  arch/arm/mach-sunxi/clock_sun50i_h6.c         | 52 +++++++++----------
>  2 files changed, 36 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm=
/include/asm/arch-sunxi/clock_sun50i_h6.h
> index 76dd33c9477..a485e00f1f3 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
> @@ -13,6 +13,18 @@
>  #include <linux/bitops.h>
>  #endif
> =20
> +#define CCU_H6_PLL1_CFG			0x000
> +#define CCU_H6_PLL5_CFG			0x010
> +#define CCU_H6_PLL6_CFG			0x020
> +#define CCU_H6_CPU_AXI_CFG		0x500
> +#define CCU_H6_PSI_AHB1_AHB2_CFG	0x510
> +#define CCU_H6_AHB3_CFG			0x51c
> +#define CCU_H6_APB1_CFG			0x520
> +#define CCU_H6_APB2_CFG			0x524
> +#define CCU_H6_MBUS_CFG			0x540
> +#define CCU_H6_UART_GATE_RESET		0x90c
> +#define CCU_H6_I2C_GATE_RESET		0x91c

I appreciate this work very much and thanks for doing it! However, I
have just one more request - PLL1, PLL5, PLL6 and similar names are
relics of very old Allwinner SoC drivers. IMO it would be better to follow
names from user manual. This would lower confusion what are they to
uninitiated people.

Best regards.
Jernej

> +
>  struct sunxi_ccm_reg {
>  	u32 pll1_cfg;		/* 0x000 pll1 (cpux) control */
>  	u8 reserved_0x004[12];
> diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/=
clock_sun50i_h6.c
> index b424a7893ea..482d9e0c695 100644
> --- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
> +++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
> @@ -6,8 +6,7 @@
>  #ifdef CONFIG_XPL_BUILD
>  void clock_init_safe(void)
>  {
> -	struct sunxi_ccm_reg *const ccm =3D
> -		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
> +	void *const ccm =3D (void *)SUNXI_CCM_BASE;
>  	struct sunxi_prcm_reg *const prcm =3D
>  		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
> =20
> @@ -32,60 +31,59 @@ void clock_init_safe(void)
> =20
>  	clock_set_pll1(408000000);
> =20
> -	writel(CCM_PLL6_DEFAULT, &ccm->pll6_cfg);
> -	while (!(readl(&ccm->pll6_cfg) & CCM_PLL6_LOCK))
> +	writel(CCM_PLL6_DEFAULT, ccm + CCU_H6_PLL6_CFG);
> +	while (!(readl(ccm + CCU_H6_PLL6_CFG) & CCM_PLL6_LOCK))
>  		;
> =20
> -	clrsetbits_le32(&ccm->cpu_axi_cfg, CCM_CPU_AXI_APB_MASK | CCM_CPU_AXI_A=
XI_MASK,
> +	clrsetbits_le32(ccm + CCU_H6_CPU_AXI_CFG,
> +			CCM_CPU_AXI_APB_MASK | CCM_CPU_AXI_AXI_MASK,
>  			CCM_CPU_AXI_DEFAULT_FACTORS);
> =20
> -	writel(CCM_PSI_AHB1_AHB2_DEFAULT, &ccm->psi_ahb1_ahb2_cfg);
> +	writel(CCM_PSI_AHB1_AHB2_DEFAULT, ccm + CCU_H6_PSI_AHB1_AHB2_CFG);
>  #ifdef CCM_AHB3_DEFAULT
> -	writel(CCM_AHB3_DEFAULT, &ccm->ahb3_cfg);
> +	writel(CCM_AHB3_DEFAULT, ccm + CCU_H6_AHB3_CFG);
>  #endif
> -	writel(CCM_APB1_DEFAULT, &ccm->apb1_cfg);
> +	writel(CCM_APB1_DEFAULT, ccm + CCU_H6_APB1_CFG);
> =20
>  	/*
>  	 * The mux and factor are set, but the clock will be enabled in
>  	 * DRAM initialization code.
>  	 */
> -	writel(MBUS_CLK_SRC_PLL6X2 | MBUS_CLK_M(3), &ccm->mbus_cfg);
> +	writel(MBUS_CLK_SRC_PLL6X2 | MBUS_CLK_M(3), ccm + CCU_H6_MBUS_CFG);
>  }
> =20
>  void clock_init_uart(void)
>  {
> -	struct sunxi_ccm_reg *const ccm =3D
> -		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
> +	void *const ccm =3D (void *)SUNXI_CCM_BASE;
> =20
>  	/* uart clock source is apb2 */
>  	writel(APB2_CLK_SRC_OSC24M|
>  	       APB2_CLK_RATE_N_1|
>  	       APB2_CLK_RATE_M(1),
> -	       &ccm->apb2_cfg);
> +	       ccm + CCU_H6_APB2_CFG);
> =20
>  	/* open the clock for uart */
> -	setbits_le32(&ccm->uart_gate_reset,
> +	setbits_le32(ccm + CCU_H6_UART_GATE_RESET,
>  		     1 << (CONFIG_CONS_INDEX - 1));
> =20
>  	/* deassert uart reset */
> -	setbits_le32(&ccm->uart_gate_reset,
> +	setbits_le32(ccm + CCU_H6_UART_GATE_RESET,
>  		     1 << (RESET_SHIFT + CONFIG_CONS_INDEX - 1));
>  }
> =20
>  void clock_set_pll1(unsigned int clk)
>  {
> -	struct sunxi_ccm_reg * const ccm =3D
> -		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
> +	void *const ccm =3D (void *)SUNXI_CCM_BASE;
>  	u32 val;
> =20
>  	/* Do not support clocks < 288MHz as they need factor P */
>  	if (clk < 288000000) clk =3D 288000000;
> =20
>  	/* Switch to 24MHz clock while changing PLL1 */
> -	val =3D readl(&ccm->cpu_axi_cfg);
> +	val =3D readl(ccm + CCU_H6_CPU_AXI_CFG);
>  	val &=3D ~CCM_CPU_AXI_MUX_MASK;
>  	val |=3D CCM_CPU_AXI_MUX_OSC24M;
> -	writel(val, &ccm->cpu_axi_cfg);
> +	writel(val, ccm + CCU_H6_CPU_AXI_CFG);
> =20
>  	/* clk =3D 24*n/p, p is ignored if clock is >288MHz */
>  	val =3D CCM_PLL1_CTRL_EN | CCM_PLL1_LOCK_EN | CCM_PLL1_CLOCK_TIME_2;
> @@ -94,20 +92,19 @@ void clock_set_pll1(unsigned int clk)
>  	       val |=3D CCM_PLL1_OUT_EN;
>  	if (IS_ENABLED(CONFIG_SUNXI_GEN_NCAT2))
>  	       val |=3D CCM_PLL1_OUT_EN | CCM_PLL1_LDO_EN;
> -	writel(val, &ccm->pll1_cfg);
> -	while (!(readl(&ccm->pll1_cfg) & CCM_PLL1_LOCK)) {}
> +	writel(val, ccm + CCU_H6_PLL1_CFG);
> +	while (!(readl(ccm + CCU_H6_PLL1_CFG) & CCM_PLL1_LOCK)) {}
> =20
>  	/* Switch CPU to PLL1 */
> -	val =3D readl(&ccm->cpu_axi_cfg);
> +	val =3D readl(ccm + CCU_H6_CPU_AXI_CFG);
>  	val &=3D ~CCM_CPU_AXI_MUX_MASK;
>  	val |=3D CCM_CPU_AXI_MUX_PLL_CPUX;
> -	writel(val, &ccm->cpu_axi_cfg);
> +	writel(val, ccm + CCU_H6_CPU_AXI_CFG);
>  }
> =20
>  int clock_twi_onoff(int port, int state)
>  {
> -	struct sunxi_ccm_reg *const ccm =3D
> -		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
> +	void *const ccm =3D (void *)SUNXI_CCM_BASE;
>  	struct sunxi_prcm_reg *const prcm =3D
>  		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
>  	u32 value, *ptr;
> @@ -120,7 +117,7 @@ int clock_twi_onoff(int port, int state)
>  		ptr =3D &prcm->twi_gate_reset;
>  	} else {
>  		shift =3D port;
> -		ptr =3D &ccm->twi_gate_reset;
> +		ptr =3D ccm + CCU_H6_I2C_GATE_RESET;
>  	}
> =20
>  	/* set the apb clock gate and reset for twi */
> @@ -136,9 +133,8 @@ int clock_twi_onoff(int port, int state)
>  /* PLL_PERIPH0 clock, used by the MMC driver */
>  unsigned int clock_get_pll6(void)
>  {
> -	struct sunxi_ccm_reg *const ccm =3D
> -		(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
> -	uint32_t rval =3D readl(&ccm->pll6_cfg);
> +	void *const ccm =3D (void *)SUNXI_CCM_BASE;
> +	uint32_t rval =3D readl(ccm + CCU_H6_PLL6_CFG);
>  	int n =3D ((rval & CCM_PLL6_CTRL_N_MASK) >> CCM_PLL6_CTRL_N_SHIFT) + 1;
>  	int div2 =3D ((rval & CCM_PLL6_CTRL_DIV2_MASK) >>
>  		    CCM_PLL6_CTRL_DIV2_SHIFT) + 1;
>=20




