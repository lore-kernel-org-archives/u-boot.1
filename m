Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93344C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 05:52:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E197687572;
	Sat, 21 Oct 2023 07:52:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H6iBD609";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 971F38758B; Sat, 21 Oct 2023 07:52:17 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A740387477
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 07:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4084f682d31so11154455e9.2
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 22:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697867533; x=1698472333; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVwceQB+qnZEN4kSYJbjQLVDt4vupsiAhwrV9/H49AA=;
 b=H6iBD609PNN+NJ6ZiHkCOix/yxhtruNl/gD9XO5wwa2pxg4+Z5t2EL41SnLG6ETzi5
 nC6JrDE8skJw4qz8elpKYJNz7eH3w3eKgyQeJe7BDltJK+C5TJYwt9Y5SXRc98AJMvXC
 iqAR1Xk4nOem9RTRf2Ji2d34bkcWrg6vbbrMkTuPCykeurrd2OOUp1Flrb0SyT6Bff+f
 Jx+yK7WqAvtFZtm3df+BwkEPtSGrGa1UUVXIKKvO9/wljJzwdrffUThCgKvKgxNlVaJi
 lMitHTaEwAdw2fOmjgNYyrFigoRT5I4QR6mNqCC9/FDS0JQg7kmXVhP0jdpO5SRYfKL2
 8eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697867533; x=1698472333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVwceQB+qnZEN4kSYJbjQLVDt4vupsiAhwrV9/H49AA=;
 b=t/QKQO2t0ZG16xioYQOgfKFrSzY6NMymZbE3rmgcA+8vH+KBZW2BjDG1dxy3JhXPa2
 yxpCYxL3sVbj6IRUX+ZcW+kR6uFzjjVbzp8jxdRlguVNl26FfE/IourrACSJio0sq0JI
 7YIz5oVnkv5zQEiUbLL2lAJ6TX9a7ySjgBfghnshsrEgE9nH9cbDMftiZXgUStiNeHSi
 Ca2T7/S4J0ZWF7o/3yonze3/59qw7bqMkzfXatQTPjI9q8amVvzb7aBMdyn8YEMyqjPv
 BgpsvWpSI2fL0fWQBptJ33Jclp+CmiUOPYBKxuwYI0OdjviBsZt6ZqOkzbVxEDFzP8Yn
 1hcw==
X-Gm-Message-State: AOJu0Yw8hr9TnIM1Gyx7plHgBMvajlzn786r+t64ZhbgiJx+t0hHjGms
 tMS/UTrDXzqGn+/JZJa51Ao=
X-Google-Smtp-Source: AGHT+IGgTVFlxhDBMTfUM/lzNVMF8Oo55P7F9tUTTDJmesMB+cbRTrluZQ9CG8P8IDu4PKh1QP6SzQ==
X-Received: by 2002:a05:600c:3c8d:b0:405:37bb:d942 with SMTP id
 bg13-20020a05600c3c8d00b0040537bbd942mr2865297wmb.4.1697867532873; 
 Fri, 20 Oct 2023 22:52:12 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net.
 [82.149.12.148]) by smtp.gmail.com with ESMTPSA id
 b14-20020a05600c4e0e00b0040607da271asm8519092wmq.31.2023.10.20.22.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:52:12 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Gunjan Gupta <viraniac@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/4] sunxi: DRAM: H6: const-ify DRAM function parameters
Date: Sat, 21 Oct 2023 07:52:11 +0200
Message-ID: <4839641.GXAFRqVoOG@archlinux>
In-Reply-To: <20231021011025.568-3-andre.przywara@arm.com>
References: <20231021011025.568-1-andre.przywara@arm.com>
 <20231021011025.568-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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

On Saturday, October 21, 2023 3:10:23 AM CEST Andre Przywara wrote:
> There are quite some functions in the Allwinner H6 DRAM "driver", some
> of them actually change the parameters in the structure passed to them,
> but many are actually not.
> 
> To increase the optimisation potential for the code, mark those functions
> that just read members of the passed dram_para struct as "const".
> Use the opportunity to avoid the forward declarations by moving the
> mctl_core_init() function.
> 
> This in itself does not decrease the code size, but lays the groundwork
> for future changes doing so.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../include/asm/arch-sunxi/dram_sun50i_h6.h   |  6 +--
>  arch/arm/mach-sunxi/dram_sun50i_h6.c          | 48 +++++++++----------
>  .../mach-sunxi/dram_timings/h6_ddr3_1333.c    |  2 +-
>  arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c  |  2 +-
>  4 files changed, 27 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
> b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h index
> be02655cdd5..a7c6435220f 100644
> --- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
> +++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
> @@ -313,8 +313,8 @@ check_member(sunxi_mctl_phy_reg, dx[3].reserved_0xf0,
> 0xaf0); */
>  #define RD_LINES_PER_BYTE_LANE	(BITS_PER_BYTE + 6)
>  struct dram_para {
> -	u32 clk;
> -	enum sunxi_dram_type type;
> +	const u32 clk;
> +	const enum sunxi_dram_type type;
>  	u8 cols;
>  	u8 rows;
>  	u8 ranks;
> @@ -331,6 +331,6 @@ static inline int ns_to_t(int nanoseconds)
>  	return DIV_ROUND_UP(ctrl_freq * nanoseconds, 1000);
>  }
> 
> -void mctl_set_timing_params(struct dram_para *para);
> +void mctl_set_timing_params(const struct dram_para *para);
> 
>  #endif /* _SUNXI_DRAM_SUN50I_H6_H */
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> b/arch/arm/mach-sunxi/dram_sun50i_h6.c index 43a2d19f084..1187f1960a0
> 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> @@ -36,25 +36,6 @@
>   * similar PHY is ZynqMP.
>   */
> 
> -static void mctl_sys_init(struct dram_para *para);
> -static void mctl_com_init(struct dram_para *para);
> -static bool mctl_channel_init(struct dram_para *para);
> -
> -static bool mctl_core_init(struct dram_para *para)
> -{
> -	mctl_sys_init(para);
> -	mctl_com_init(para);
> -	switch (para->type) {
> -	case SUNXI_DRAM_TYPE_LPDDR3:
> -	case SUNXI_DRAM_TYPE_DDR3:
> -		mctl_set_timing_params(para);
> -		break;
> -	default:
> -		panic("Unsupported DRAM type!");
> -	};
> -	return mctl_channel_init(para);
> -}
> -
>  /* PHY initialisation */
>  static void mctl_phy_pir_init(u32 val)
>  {
> @@ -152,7 +133,7 @@ static void mctl_set_master_priority(void)
>  	MBUS_CONF(HDCP2,  true,    HIGH, 2,  100,   64,   32);
>  }
> 
> -static void mctl_sys_init(struct dram_para *para)
> +static void mctl_sys_init(u32 clk_rate)
>  {
>  	struct sunxi_ccm_reg * const ccm =
>  			(struct sunxi_ccm_reg *)SUNXI_CCM_BASE;
> @@ -173,7 +154,7 @@ static void mctl_sys_init(struct dram_para *para)
> 
>  	/* Set PLL5 rate to doubled DRAM clock rate */
>  	writel(CCM_PLL5_CTRL_EN | CCM_PLL5_LOCK_EN |
> -	       CCM_PLL5_CTRL_N(para->clk * 2 / 24), &ccm->pll5_cfg);
> +	       CCM_PLL5_CTRL_N(clk_rate * 2 / 24), &ccm->pll5_cfg);
>  	mctl_await_completion(&ccm->pll5_cfg, CCM_PLL5_LOCK, 
CCM_PLL5_LOCK);
> 
>  	/* Configure DRAM mod clock */
> @@ -198,7 +179,7 @@ static void mctl_sys_init(struct dram_para *para)
>  	writel(0x8000, &mctl_ctl->unk_0x00c);
>  }
> 
> -static void mctl_set_addrmap(struct dram_para *para)
> +static void mctl_set_addrmap(const struct dram_para *para)
>  {
>  	struct sunxi_mctl_ctl_reg * const mctl_ctl =
>  			(struct sunxi_mctl_ctl_reg 
*)SUNXI_DRAM_CTL0_BASE;
> @@ -284,7 +265,7 @@ static void mctl_set_addrmap(struct dram_para *para)
>  	mctl_ctl->addrmap[8] = 0x3F3F;
>  }
> 
> -static void mctl_com_init(struct dram_para *para)
> +static void mctl_com_init(const struct dram_para *para)
>  {
>  	struct sunxi_mctl_com_reg * const mctl_com =
>  			(struct sunxi_mctl_com_reg 
*)SUNXI_DRAM_COM_BASE;
> @@ -354,7 +335,7 @@ static void mctl_com_init(struct dram_para *para)
>  	}
>  }
> 
> -static void mctl_bit_delay_set(struct dram_para *para)
> +static void mctl_bit_delay_set(const struct dram_para *para)
>  {
>  	struct sunxi_mctl_phy_reg * const mctl_phy =
>  			(struct sunxi_mctl_phy_reg 
*)SUNXI_DRAM_PHY0_BASE;
> @@ -413,7 +394,7 @@ static void mctl_bit_delay_set(struct dram_para *para)
>  	}
>  }
> 
> -static bool mctl_channel_init(struct dram_para *para)
> +static bool mctl_channel_init(const struct dram_para *para)
>  {
>  	struct sunxi_mctl_com_reg * const mctl_com =
>  			(struct sunxi_mctl_com_reg 
*)SUNXI_DRAM_COM_BASE;
> @@ -563,6 +544,21 @@ static bool mctl_channel_init(struct dram_para *para)
>  	return true;
>  }
> 
> +static bool mctl_core_init(const struct dram_para *para)
> +{
> +	mctl_sys_init(para->clk);
> +	mctl_com_init(para);
> +	switch (para->type) {
> +	case SUNXI_DRAM_TYPE_LPDDR3:
> +	case SUNXI_DRAM_TYPE_DDR3:
> +		mctl_set_timing_params(para);
> +		break;
> +	default:
> +		panic("Unsupported DRAM type!");
> +	};
> +	return mctl_channel_init(para);
> +}
> +
>  static void mctl_auto_detect_rank_width(struct dram_para *para)
>  {
>  	/* this is minimum size that it's supported */
> @@ -637,7 +633,7 @@ static void mctl_auto_detect_dram_size(struct dram_para
> *para) }
>  }
> 
> -unsigned long mctl_calc_size(struct dram_para *para)
> +unsigned long mctl_calc_size(const struct dram_para *para)
>  {
>  	u8 width = para->bus_full_width ? 4 : 2;
> 
> diff --git a/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
> b/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c index
> 2136ca3a4cb..6dde6e78717 100644
> --- a/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
> +++ b/arch/arm/mach-sunxi/dram_timings/h6_ddr3_1333.c
> @@ -38,7 +38,7 @@ static u32 mr_ddr3[7] = {
>  };
> 
>  /* TODO: flexible timing */
> -void mctl_set_timing_params(struct dram_para *para)
> +void mctl_set_timing_params(const struct dram_para *para)
>  {
>  	struct sunxi_mctl_ctl_reg * const mctl_ctl =
>  			(struct sunxi_mctl_ctl_reg 
*)SUNXI_DRAM_CTL0_BASE;
> diff --git a/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
> b/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c index
> 10008601134..2a95484322c 100644
> --- a/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
> +++ b/arch/arm/mach-sunxi/dram_timings/h6_lpddr3.c
> @@ -17,7 +17,7 @@ static u32 mr_lpddr3[12] = {
>  };
> 
>  /* TODO: flexible timing */
> -void mctl_set_timing_params(struct dram_para *para)
> +void mctl_set_timing_params(const struct dram_para *para)
>  {
>  	struct sunxi_mctl_ctl_reg * const mctl_ctl =
>  			(struct sunxi_mctl_ctl_reg 
*)SUNXI_DRAM_CTL0_BASE;




