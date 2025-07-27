Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79E0C87FCC
	for <u-boot@archiver.kernel.org>; Sun, 27 Jul 2025 20:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C39182F6F;
	Sun, 27 Jul 2025 22:15:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jpD4i68B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A84782F8E; Sun, 27 Jul 2025 22:15:54 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F3F082F5E
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 22:15:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3b783ea502eso518232f8f.1
 for <u-boot@lists.denx.de>; Sun, 27 Jul 2025 13:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753647352; x=1754252152; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeJK5GRaLBnuaIJaNMR/TgDp7Y/oSysAbwbgoE2oFxc=;
 b=jpD4i68BHNquz7yG5BpkJlsw8P9B2CnJHPp5QO5q4RRWbPeUPjnHyNLmg95e0C8fmw
 5Ky/N8t6eu8qb0o8+NQkd3TfhWQlzAnjmqGzq6E8CrjUQ2o5WsvLMVXXrxz+iZ9FzgcO
 z43uaBpIv01C5ud4cUKxCkHVRYNcy3ua5gbfWeM4CwtGyD1n+afZfEkouiw/u5A/du9m
 HHtAodRzTfY01FxcnTLzfDSGR8E8BeWJE3b1Sr7iQw+PhJD15hyM9iNDg+wMV+kXojqH
 SUs+yCkf+XL1rtBYvGuMBT8Fh3iYEXLhnl3/KJ2Ll1pdpalcGh93cItMD2RyFQAMxMQo
 0HtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753647352; x=1754252152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zeJK5GRaLBnuaIJaNMR/TgDp7Y/oSysAbwbgoE2oFxc=;
 b=PdI6NTjW75LkX/EFHzUhJDI7vs8N555ZwWId8sZkbLFXUr1drEJym8b8TO9IyGw3k9
 LtUbRvjlxSuVQN5uSC705uu61hvcwI3JIBIVyECH+i81WF0idX2xfXw9IeJEPnI1o49T
 gYq3ijp1tIt3jvFbnVPKj0ePpmHF5eSl7qHyYEdWIgibiRqyqfF3svnURvW/xQHxfmH2
 KX7B+kp8NerY19JY8j0HGkZW0l7MPoTJ+K5mgeaYYMY8g0s1poNaC1cYVVdcIil/BLnq
 evKjQA1judkjXwScVm+ksLpjT8L5N0IGoKtCrflnFF4qcsg8KZP0I73UTRv9jxcSiUs+
 5wzw==
X-Gm-Message-State: AOJu0YzLwxDpClfUCgQKemml99ctm4T4yK78odQH2jnUWA4t4U7KnXwp
 wPyEV3GZuOUmVx1wE7UnnCz6oD10PplSlukxMgTlRrnsssRrO7/x6e46B8nRsw==
X-Gm-Gg: ASbGncsUMC+A1rjlpeM88uL2zx8RMH+qai8Gk+X8pqt1ifGYsjMT60uA0/ovsnG+chc
 dQR0CLdDD/QtEKY1P+VTxWSYSdX5u5OfSu8d+nbZlDwTDzSLA0fiRoxtjd2qllBdmTE59z3mOAH
 HaUs9aHJaJG0PlE1cGbZTHigsIPaPmcaNjHEgd/opb+E5VSYRaV3mAJkK1FrotQgBiBqZ50F4le
 XnADfT+OB5y9HeSj64JRG6qS4ZOtfeh4CQGu4Y1Cu/Mv9MLVHgdilFoQkMG/RCzPgNNh/v7fYZI
 Rj4StXvBcqYcfbmM0EkLA/r+ZSOzJ3uUr41bR7+7Z8GICaCiFHzJHjDmOQpHv6rTKxFsIEPS7yI
 nh3knQTIT2FpDoZcOTlx8QmC9gm1QXH8DEkRqgaI1NMGccIZ8u5rDJ7o2ziObOXDcasWfQPymw/
 HPqHqNhS08
X-Google-Smtp-Source: AGHT+IGM5og9dbblnxiB6VEviCevlY/F42ZT90c8gfTmT5u0NOxevw2SiWfq3nPkEKCImjmWQxcgtA==
X-Received: by 2002:a05:6000:40ca:b0:3b6:162a:8e08 with SMTP id
 ffacd0b85a97d-3b77123f244mr10502095f8f.12.1753647351538; 
 Sun, 27 Jul 2025 13:15:51 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4586f88ce71sm104125975e9.0.2025.07.27.13.15.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 13:15:51 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>
Cc: Mikhail Kalashnikov <iuncuim@gmail.com>, Yixun Lan <dlan@gentoo.org>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 12/20] sunxi: sun50i_h6: add A523 SPL clock setup code
Date: Sun, 27 Jul 2025 22:15:50 +0200
Message-ID: <2789576.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20250717235455.32528-13-andre.przywara@arm.com>
References: <20250717235455.32528-1-andre.przywara@arm.com>
 <20250717235455.32528-13-andre.przywara@arm.com>
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

Dne petek, 18. julij 2025 ob 01:54:47 Srednjeevropski poletni =C4=8Das je A=
ndre Przywara napisal(a):
> From: Jernej Skrabec <jernej.skrabec@gmail.com>

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

>=20
> ---
>  .../include/asm/arch-sunxi/clock_sun50i_h6.h  | 10 ++++++
>  arch/arm/mach-sunxi/clock_sun50i_h6.c         | 32 ++++++++++++++-----
>  2 files changed, 34 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm=
/include/asm/arch-sunxi/clock_sun50i_h6.h
> index 5881ab88573..699d75f37c4 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
> @@ -108,6 +108,13 @@
>  #define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002
>  #define CCM_AHB3_DEFAULT		0x03000002
>  #define CCM_APB1_DEFAULT		0x03000102
> +
> +#elif CONFIG_MACH_SUN55I_A523				/* A523 */
> +
> +#define CCM_PLL6_DEFAULT		0xe8116310	    /* 1200 MHz */
> +#define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002	    /* 200 MHz */
> +#define CCM_APB1_DEFAULT		0x03000005	    /* APB0 really */
> +#define CCM_APB2_DEFAULT		0x03000005	    /* APB1 really */
>  #endif
> =20
>  /* apb2 bit field */
> @@ -127,6 +134,7 @@
>  /* MBUS clock bit field */
>  #define MBUS_ENABLE			BIT(31)
>  #define MBUS_RESET			BIT(30)
> +#define MBUS_UPDATE			BIT(27)
>  #define MBUS_CLK_SRC_MASK		GENMASK(25, 24)
>  #define MBUS_CLK_SRC_OSCM24		(0 << 24)
>  #define MBUS_CLK_SRC_PLL6X2		(1 << 24)
> @@ -139,10 +147,12 @@
>  #define GATE_SHIFT			(0)
> =20
>  /* DRAM clock bit field */
> +#define DRAM_CLK_ENABLE			BIT(31)
>  #define DRAM_MOD_RESET			BIT(30)
>  #define DRAM_CLK_UPDATE			BIT(27)
>  #define DRAM_CLK_SRC_MASK		GENMASK(25, 24)
>  #define DRAM_CLK_SRC_PLL5		(0 << 24)
> +#define DRAM_CLK_M_MASK			(0x1f)
>  #define DRAM_CLK_M(m)			(((m)-1) << 0)
> =20
>  /* MMC clock bit field */
> diff --git a/arch/arm/mach-sunxi/clock_sun50i_h6.c b/arch/arm/mach-sunxi/=
clock_sun50i_h6.c
> index 3a4399a9c6c..80004f13a1e 100644
> --- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
> +++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
> @@ -16,15 +16,22 @@ void clock_init_safe(void)
>  	void *const ccm =3D (void *)SUNXI_CCM_BASE;
>  	void *const prcm =3D (void *)SUNXI_PRCM_BASE;
> =20
> -	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616)) {
> -		/* this seems to enable PLLs on H616 */
> +	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616))
>  		setbits_le32(prcm + CCU_PRCM_SYS_PWROFF_GATING, 0x10);
> +	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523))
> +		setbits_le32(prcm + CCU_PRCM_SYS_PWROFF_GATING, 0x200);
> +	udelay(1);
> +
> +	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
> +	    IS_ENABLED(CONFIG_MACH_SUN55I_A523))
>  		setbits_le32(prcm + CCU_PRCM_RES_CAL_CTRL, 2);
> -	}
> +	udelay(1);
> =20
>  	if (IS_ENABLED(CONFIG_MACH_SUN50I_H616) ||
> -	    IS_ENABLED(CONFIG_MACH_SUN50I_H6)) {
> +	    IS_ENABLED(CONFIG_MACH_SUN50I_H6) ||
> +	    IS_ENABLED(CONFIG_MACH_SUN55I_A523)) {
>  		clrbits_le32(prcm + CCU_PRCM_RES_CAL_CTRL, 1);
> +		udelay(1);
>  		setbits_le32(prcm + CCU_PRCM_RES_CAL_CTRL, 1);
>  	}
> =20
> @@ -41,9 +48,10 @@ void clock_init_safe(void)
>  	while (!(readl(ccm + CCU_H6_PLL6_CFG) & CCM_PLL_LOCK))
>  		;
> =20
> -	clrsetbits_le32(ccm + CCU_H6_CPU_AXI_CFG,
> -			CCM_CPU_AXI_APB_MASK | CCM_CPU_AXI_AXI_MASK,
> -			CCM_CPU_AXI_DEFAULT_FACTORS);
> +	if (!IS_ENABLED(CONFIG_MACH_SUN55I_A523))
> +		clrsetbits_le32(ccm + CCU_H6_CPU_AXI_CFG,
> +				CCM_CPU_AXI_APB_MASK | CCM_CPU_AXI_AXI_MASK,
> +				CCM_CPU_AXI_DEFAULT_FACTORS);
> =20
>  	writel(CCM_PSI_AHB1_AHB2_DEFAULT, ccm + CCU_H6_PSI_AHB1_AHB2_CFG);
>  #ifdef CCM_AHB3_DEFAULT
> @@ -55,7 +63,15 @@ void clock_init_safe(void)
>  	 * The mux and factor are set, but the clock will be enabled in
>  	 * DRAM initialization code.
>  	 */
> -	writel(MBUS_CLK_SRC_PLL6X2 | MBUS_CLK_M(3), ccm + CCU_H6_MBUS_CFG);
> +	if (IS_ENABLED(CONFIG_MACH_SUN55I_A523)) {
> +		writel(MBUS_RESET, ccm + CCU_H6_MBUS_CFG);
> +		udelay(1);
> +		writel(MBUS_UPDATE | MBUS_CLK_SRC_OSCM24 | MBUS_CLK_M(4),
> +		       ccm + CCU_H6_MBUS_CFG);
> +	} else {
> +		writel(MBUS_CLK_SRC_PLL6X2 | MBUS_CLK_M(3),
> +		       ccm + CCU_H6_MBUS_CFG);
> +	}
>  }
> =20
>  void clock_init_uart(void)
>=20




