Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8100C28B30
	for <u-boot@archiver.kernel.org>; Sun, 23 Mar 2025 12:36:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3036281DCA;
	Sun, 23 Mar 2025 13:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ixUDbr7R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0F6D81DDF; Sun, 23 Mar 2025 13:36:14 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E36D380107
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 13:36:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso35034835e9.0
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 05:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742733372; x=1743338172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vluZQCg22suxtk4J5+a77FJ5djPbExqa1KlvC0fNA6U=;
 b=ixUDbr7RSujY/Xm64e2/3k1euJ3xIxdYFvhfuqq1+za66Z+Kuc/aiOnS69ZNUZ5+zg
 tJEcyodM6V9GOS+z66xkn5DsWKYrW81uPo2URE7c2d1rDCYAyh0leO8cnDvUxOBzyV7/
 naKeCDpF/tDrV6DCgM9Div55hpZJtXnT7ZAl79EhG0mPqT6jteWKNMQpYbHpHtnPygZq
 dMgzBTMVqnSlqnaqQURtVqNOI4qiyiV4ivbv0E9ixtgoNCJ5pg+g4R4e4Mxyb154g/D8
 nOCRer+Jo8LfXgrlgC4YMhp13mOBGAl478tJoWmuGdzCapYiZiBulPl8Goc78ZFdgIF/
 5SJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742733372; x=1743338172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vluZQCg22suxtk4J5+a77FJ5djPbExqa1KlvC0fNA6U=;
 b=j6MbKlt7I8cyYLOofBirwwXgSt/M/cHd6frd7z71W9pab1JElPDeo7pcsNzxeDOKGj
 JNQvFDpP70ihE5KHK821pEaVEbGMDDnOGpthqtzyo7EAI8E3Ewy/nKhZCQa+7aNnb9G2
 4nPGwJz4KReT/G3LWAkP2jATWl4YAYkwDy7d0Dpz84gBzEZHkhxjdw0PIvX2qpDJYVrv
 757VNrLfSNr9v/aSW657ZdOaWytZ2xsY9p8U1P0XvWLAfORRdjZSFgIYho/4knJwfBmh
 JLxu7iKT4b/ay37DuwtarzprMF9nPppQ/swP4t0FOsBIvEDGoqQx+jLojQFSofxNkD68
 mLrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl7lY+/wtDwJUDdo3+ALL2iL4tw2voARviiQ31MDlkBM8fefrmQpABpCU869Id0KllKxLDKVc=@lists.denx.de
X-Gm-Message-State: AOJu0YziEtFhUErfzlFM+Viv/RNYtKe/m1TTxg5rT2VYYBe5PfHOue6v
 myWas4NjTPycV/JmtvxAB3u1+wK05D9bN2axSD3zBEokrQ8lWVjR1Jhb9Q==
X-Gm-Gg: ASbGncvk9VAyMdqhVju65NRF4sIDvpBxffJvvnxDrK/ZSTfxMuBEQ2Vfu52mom5PxlN
 LOOKskJDO2UOjdkNjuQFrVkfSEYYTj6y7NVexX0ZT1jQc5MnZ4zlUi4wT0Xf5zeaNmjNVPiTFxL
 gTpD1ffD6GFvvQ+OlGdjUQD2CK8Q1fTLgG92Fs4bwBSfiUUFjA7dp5JHiVOnxyxbUuvdxO2CAA/
 +Xc0g6VDUgzZlhw9fKTWmSuLMr+51bzVZ6/1uDpyK0C0HogYtJhaagYafkHhKXHUJoro8+ciBrk
 XcAbIk7zPZU3zR9ucahphfD/u6NOD3tSmJqePAd86VjvfRj7c/F31QD0PtwyjpMCD0ZwW0rNcg8
 B/rJPSoITVf9OPJGo3MC2
X-Google-Smtp-Source: AGHT+IGzu0u9INcDCXRj6WVqL7VkKmNQtvbWOeXlmsEibdwfDTH1ozisOlERmSNr0B85bB7wARjAQA==
X-Received: by 2002:a05:6000:186b:b0:391:4684:dbdb with SMTP id
 ffacd0b85a97d-3997f9039ecmr7813444f8f.17.1742733372165; 
 Sun, 23 Mar 2025 05:36:12 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net.
 [86.58.6.171]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efc90sm7763650f8f.98.2025.03.23.05.36.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Mar 2025 05:36:11 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>
Cc: Simon Glass <sjg@chromium.org>, Mikhail Kalashnikov <iuncuim@gmail.com>,
 u-boot@lists.denx.de, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 29/34] sunxi: sun50i_h6: add A523 SPL clock setup code
Date: Sun, 23 Mar 2025 13:36:11 +0100
Message-ID: <3536548.QJadu78ljV@jernej-laptop>
In-Reply-To: <20250323113544.7933-30-andre.przywara@arm.com>
References: <20250323113544.7933-1-andre.przywara@arm.com>
 <20250323113544.7933-30-andre.przywara@arm.com>
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

Dne nedelja, 23. marec 2025 ob 12:35:39 Srednjeevropski standardni =C4=8Das=
 je Andre Przywara napisal(a):
> From: Jernej Skrabec <jernej.skrabec@gmail.com>

I'm sure you can take credit for this as it's just making definitions and
putting them in place. But I can also provide SoB if you want.

>=20
> ---
>  .../include/asm/arch-sunxi/clock_sun50i_h6.h  | 10 ++++++
>  arch/arm/mach-sunxi/clock_sun50i_h6.c         | 32 ++++++++++++++-----
>  2 files changed, 34 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h b/arch/arm=
/include/asm/arch-sunxi/clock_sun50i_h6.h
> index c95f2b39e64..d251ed49798 100644
> --- a/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
> +++ b/arch/arm/include/asm/arch-sunxi/clock_sun50i_h6.h
> @@ -101,6 +101,13 @@
>  #define CCM_PLL6_DEFAULT		0xe8216300
>  #define CCM_PSI_AHB1_AHB2_DEFAULT	0x03000002
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
> @@ -120,6 +127,7 @@
>  /* MBUS clock bit field */
>  #define MBUS_ENABLE			BIT(31)
>  #define MBUS_RESET			BIT(30)
> +#define MBUS_UPDATE			BIT(27)
>  #define MBUS_CLK_SRC_MASK		GENMASK(25, 24)
>  #define MBUS_CLK_SRC_OSCM24		(0 << 24)
>  #define MBUS_CLK_SRC_PLL6X2		(1 << 24)
> @@ -132,10 +140,12 @@
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
> index f76d1b83883..2ba144a6ac3 100644
> --- a/arch/arm/mach-sunxi/clock_sun50i_h6.c
> +++ b/arch/arm/mach-sunxi/clock_sun50i_h6.c
> @@ -14,15 +14,22 @@ void clock_init_safe(void)
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
> @@ -39,9 +46,10 @@ void clock_init_safe(void)
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
> @@ -53,7 +61,15 @@ void clock_init_safe(void)
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

While this is in BSP boot0, I don't think it's needed at all. Full reset is
done later in DRAM driver anyway.

Best regards,
Jernej

>  }
> =20
>  void clock_init_uart(void)
>=20




