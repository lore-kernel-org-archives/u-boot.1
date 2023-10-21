Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D35C001E0
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 05:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6BD887560;
	Sat, 21 Oct 2023 07:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D5ZuUF9N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1013287561; Sat, 21 Oct 2023 07:57:04 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFF9F8755C
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 07:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jernej.skrabec@gmail.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-32d80ae19f8so1093599f8f.2
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 22:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697867819; x=1698472619; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLoHWluxNTqQNhecIVQZ7enJASdiXV06OfFItDZhUSU=;
 b=D5ZuUF9N637AYGdbTr7T4vGycrAjdAffFf3W7Ju8Zd+QckBeHJSwN8STYhegf/Owle
 O2Oh/+flrPl7vECcbIlWGNuV5Q8PmJTSXwNRhlJmISBPgoVP7Y5PhhdxWZZOq9CblMNT
 0nLiISJkaCH71GUnBdI4W/xREHw9rr6n7iyNmKyNd/rXcWHqVhb/koQ7VGCe3muQjmJz
 o6ytt4uvRiLsExt/fkO7AVlId8vQ7IJfPluVQSQiT4XoORCOGM8mSZPIQm/7anTfm3yc
 F+uUsHO78akCYMJLTNZDnl/ejaU5gWj6XddB4kQZGFm2n1U8SAA5tuGbSh0TcMIXNgWv
 3BJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697867819; x=1698472619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLoHWluxNTqQNhecIVQZ7enJASdiXV06OfFItDZhUSU=;
 b=omKomlFIJctNtB0Gjt6k4lu4jvW7TBuEDSjfBgK+buYZo8g4xK93Q0mtisLmv4U1Bb
 0dJoIRb/nmnQ2TQB3tsvsiJ6KgH3jtLyyGEXP6xM79CDBWfmMUggQnOePuRmss7ePf5S
 Ne/06mJ0OktijULCqqGOqZ1vpQcFv4bpRo2k49vbFvSYhyYPPC/rXoIt/vOyv9ZGPfRQ
 GMXjDK3cwJwVbTA9wT7EehZiVYDN/Li/ta2eac9H7KVCtY5esMk8bn2UTxWnzKOsdkd4
 4XpdoFjamCUnl+b9PawTgXmSR7iVT1Cga0A8hm5uYNEcVrGMBfgkLGTZF6/Oqm6ookDz
 bQ4g==
X-Gm-Message-State: AOJu0Yz5fPmNKwedXN4EzU4dXPNCzkSYZWjxm+3/qs5WH4vgyyZnv1q0
 0DZQbQQ/xUQM7WEtWbGswi4=
X-Google-Smtp-Source: AGHT+IFp35cWKFABTlXDH5oya8ju34Nwf5odQ79RVPS/ORWwrtaJiHOU1JNTzEcesKYv4Wumli0Axg==
X-Received: by 2002:a05:6000:3:b0:32d:acf6:bb2e with SMTP id
 h3-20020a056000000300b0032dacf6bb2emr3285042wrx.70.1697867819040; 
 Fri, 20 Oct 2023 22:56:59 -0700 (PDT)
Received: from archlinux.localnet (82-149-12-148.dynamic.telemach.net.
 [82.149.12.148]) by smtp.gmail.com with ESMTPSA id
 c4-20020a056000104400b003142e438e8csm3023479wrx.26.2023.10.20.22.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 22:56:58 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>
Cc: Gunjan Gupta <viraniac@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/4] sunxi: DRAM: H6: split struct dram_para
Date: Sat, 21 Oct 2023 07:56:57 +0200
Message-ID: <13371449.uLZWGnKmhe@archlinux>
In-Reply-To: <20231021011025.568-4-andre.przywara@arm.com>
References: <20231021011025.568-1-andre.przywara@arm.com>
 <20231021011025.568-4-andre.przywara@arm.com>
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

On Saturday, October 21, 2023 3:10:24 AM CEST Andre Przywara wrote:
> Currently there is one DRAM parameter struct for the Allwinner H6 DRAM
> "driver". It contains many fields that are compile time constants
> (set by Kconfig variables), though there are also some fields that are
> probed and changed over the runtime of the DRAM initialisation.
> 
> Because of this mixture, the compiler cannot properly optimise the code
> for size, as it does not consider constant propagation in its full
> potential.
> 
> Help the compiler out by splitting that structure into two: one that only
> contains values known at compile time, and another one where the values
> will actually change. The former can then be declared "const", which will
> let the compiler fold its values directly into the code using it.
> To facilitate this, the definition of the struct has to become "static
> const" outside of any functions, so move that part out of
> sunxi_dram_init().
> 
> That results in code savings around 500 bytes, which helps the
> notorously tight H6 SPL to stay within it current limit.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  .../include/asm/arch-sunxi/dram_sun50i_h6.h   |  12 +-
>  arch/arm/mach-sunxi/dram_sun50i_h6.c          | 134 +++++++++---------
>  2 files changed, 77 insertions(+), 69 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
> b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h index
> a7c6435220f..058f2cabb6e 100644
> --- a/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
> +++ b/arch/arm/include/asm/arch-sunxi/dram_sun50i_h6.h
> @@ -313,17 +313,19 @@ check_member(sunxi_mctl_phy_reg, dx[3].reserved_0xf0,
> 0xaf0); */
>  #define RD_LINES_PER_BYTE_LANE	(BITS_PER_BYTE + 6)
>  struct dram_para {
> -	const u32 clk;
> -	const enum sunxi_dram_type type;
> +	u32 clk;
> +	enum sunxi_dram_type type;
> +	u8 dx_read_delays[NR_OF_BYTE_LANES][RD_LINES_PER_BYTE_LANE];
> +	u8 dx_write_delays[NR_OF_BYTE_LANES][WR_LINES_PER_BYTE_LANE];
> +};
> +
> +struct dram_config {
>  	u8 cols;
>  	u8 rows;
>  	u8 ranks;
>  	u8 bus_full_width;
> -	const u8 dx_read_delays[NR_OF_BYTE_LANES][RD_LINES_PER_BYTE_LANE];
> -	const u8 dx_write_delays[NR_OF_BYTE_LANES]
[WR_LINES_PER_BYTE_LANE];
>  };
> 
> -
>  static inline int ns_to_t(int nanoseconds)
>  {
>  	const unsigned int ctrl_freq = CONFIG_DRAM_CLK / 2;
> diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> b/arch/arm/mach-sunxi/dram_sun50i_h6.c index 1187f1960a0..8e959f4c600
> 100644
> --- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
> +++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
> @@ -179,15 +179,15 @@ static void mctl_sys_init(u32 clk_rate)
>  	writel(0x8000, &mctl_ctl->unk_0x00c);
>  }
> 
> -static void mctl_set_addrmap(const struct dram_para *para)
> +static void mctl_set_addrmap(const struct dram_config *config)
>  {
>  	struct sunxi_mctl_ctl_reg * const mctl_ctl =
>  			(struct sunxi_mctl_ctl_reg 
*)SUNXI_DRAM_CTL0_BASE;
> -	u8 cols = para->cols;
> -	u8 rows = para->rows;
> -	u8 ranks = para->ranks;
> +	u8 cols = config->cols;
> +	u8 rows = config->rows;
> +	u8 ranks = config->ranks;
> 
> -	if (!para->bus_full_width)
> +	if (!config->bus_full_width)
>  		cols -= 1;
> 
>  	/* Ranks */
> @@ -265,7 +265,8 @@ static void mctl_set_addrmap(const struct dram_para
> *para) mctl_ctl->addrmap[8] = 0x3F3F;
>  }
> 
> -static void mctl_com_init(const struct dram_para *para)
> +static void mctl_com_init(const struct dram_para *para,
> +			  const struct dram_config *config)
>  {
>  	struct sunxi_mctl_com_reg * const mctl_com =
>  			(struct sunxi_mctl_com_reg 
*)SUNXI_DRAM_COM_BASE;
> @@ -275,7 +276,7 @@ static void mctl_com_init(const struct dram_para *para)
>  			(struct sunxi_mctl_phy_reg 
*)SUNXI_DRAM_PHY0_BASE;
>  	u32 reg_val, tmp;
> 
> -	mctl_set_addrmap(para);
> +	mctl_set_addrmap(config);
> 
>  	setbits_le32(&mctl_com->cr, BIT(31));
> 
> @@ -294,12 +295,12 @@ static void mctl_com_init(const struct dram_para
> *para) clrsetbits_le32(&mctl_com->unk_0x008, 0x3f00, reg_val);
> 
>  	/* TODO: DDR4 */
> -	reg_val = MSTR_BURST_LENGTH(8) | MSTR_ACTIVE_RANKS(para->ranks);
> +	reg_val = MSTR_BURST_LENGTH(8) | MSTR_ACTIVE_RANKS(config->ranks);
>  	if (para->type == SUNXI_DRAM_TYPE_LPDDR3)
>  		reg_val |= MSTR_DEVICETYPE_LPDDR3;
>  	if (para->type == SUNXI_DRAM_TYPE_DDR3)
>  		reg_val |= MSTR_DEVICETYPE_DDR3 | MSTR_2TMODE;
> -	if (para->bus_full_width)
> +	if (config->bus_full_width)
>  		reg_val |= MSTR_BUSWIDTH_FULL;
>  	else
>  		reg_val |= MSTR_BUSWIDTH_HALF;
> @@ -311,7 +312,7 @@ static void mctl_com_init(const struct dram_para *para)
>  		reg_val = DCR_DDR3 | DCR_DDR8BANK | DCR_DDR2T;
>  	writel(reg_val | 0x400, &mctl_phy->dcr);
> 
> -	if (para->ranks == 2)
> +	if (config->ranks == 2)
>  		writel(0x0303, &mctl_ctl->odtmap);
>  	else
>  		writel(0x0201, &mctl_ctl->odtmap);
> @@ -329,7 +330,7 @@ static void mctl_com_init(const struct dram_para *para)
>  	}
>  	writel(reg_val, &mctl_ctl->odtcfg);
> 
> -	if (!para->bus_full_width) {
> +	if (!config->bus_full_width) {
>  		writel(0x0, &mctl_phy->dx[2].gcr[0]);
>  		writel(0x0, &mctl_phy->dx[3].gcr[0]);
>  	}
> @@ -394,7 +395,8 @@ static void mctl_bit_delay_set(const struct dram_para
> *para) }
>  }
> 
> -static bool mctl_channel_init(const struct dram_para *para)
> +static bool mctl_channel_init(const struct dram_para *para,
> +			      const struct dram_config *config)
>  {
>  	struct sunxi_mctl_com_reg * const mctl_com =
>  			(struct sunxi_mctl_com_reg 
*)SUNXI_DRAM_COM_BASE;
> @@ -429,14 +431,14 @@ static bool mctl_channel_init(const struct dram_para
> *para)
> 
>  	udelay(100);
> 
> -	if (para->ranks == 2)
> +	if (config->ranks == 2)
>  		setbits_le32(&mctl_phy->dtcr[1], 0x30000);
>  	else
>  		clrsetbits_le32(&mctl_phy->dtcr[1], 0x30000, 0x10000);
> 
>  	if (sunxi_dram_is_lpddr(para->type))
>  		clrbits_le32(&mctl_phy->dtcr[1], BIT(1));
> -	if (para->ranks == 2) {
> +	if (config->ranks == 2) {
>  		writel(0x00010001, &mctl_phy->rankidr);
>  		writel(0x20000, &mctl_phy->odtcr);
>  	} else {
> @@ -544,10 +546,11 @@ static bool mctl_channel_init(const struct dram_para
> *para) return true;
>  }
> 
> -static bool mctl_core_init(const struct dram_para *para)
> +static bool mctl_core_init(const struct dram_para *para,
> +			   const struct dram_config *config)
>  {
>  	mctl_sys_init(para->clk);
> -	mctl_com_init(para);
> +	mctl_com_init(para, config);
>  	switch (para->type) {
>  	case SUNXI_DRAM_TYPE_LPDDR3:
>  	case SUNXI_DRAM_TYPE_DDR3:
> @@ -556,14 +559,15 @@ static bool mctl_core_init(const struct dram_para
> *para) default:
>  		panic("Unsupported DRAM type!");
>  	};
> -	return mctl_channel_init(para);
> +	return mctl_channel_init(para, config);
>  }
> 
> -static void mctl_auto_detect_rank_width(struct dram_para *para)
> +static void mctl_auto_detect_rank_width(const struct dram_para *para,
> +					struct dram_config 
*config)
>  {
>  	/* this is minimum size that it's supported */
> -	para->cols = 8;
> -	para->rows = 13;
> +	config->cols = 8;
> +	config->rows = 13;
> 
>  	/*
>  	 * Previous versions of this driver tried to auto detect the rank
> @@ -579,68 +583,69 @@ static void mctl_auto_detect_rank_width(struct
> dram_para *para) */
> 
>  	debug("testing 32-bit width, rank = 2\n");
> -	para->bus_full_width = 1;
> -	para->ranks = 2;
> -	if (mctl_core_init(para))
> +	config->bus_full_width = 1;
> +	config->ranks = 2;
> +	if (mctl_core_init(para, config))
>  		return;
> 
>  	debug("testing 32-bit width, rank = 1\n");
> -	para->bus_full_width = 1;
> -	para->ranks = 1;
> -	if (mctl_core_init(para))
> +	config->bus_full_width = 1;
> +	config->ranks = 1;
> +	if (mctl_core_init(para, config))
>  		return;
> 
>  	debug("testing 16-bit width, rank = 2\n");
> -	para->bus_full_width = 0;
> -	para->ranks = 2;
> -	if (mctl_core_init(para))
> +	config->bus_full_width = 0;
> +	config->ranks = 2;
> +	if (mctl_core_init(para, config))
>  		return;
> 
>  	debug("testing 16-bit width, rank = 1\n");
> -	para->bus_full_width = 0;
> -	para->ranks = 1;
> -	if (mctl_core_init(para))
> +	config->bus_full_width = 0;
> +	config->ranks = 1;
> +	if (mctl_core_init(para, config))
>  		return;
> 
>  	panic("This DRAM setup is currently not supported.\n");
>  }
> 
> -static void mctl_auto_detect_dram_size(struct dram_para *para)
> +static void mctl_auto_detect_dram_size(const struct dram_para *para,
> +				       struct dram_config *config)
>  {
>  	/* TODO: non-(LP)DDR3 */
> 
>  	/* detect row address bits */
> -	para->cols = 8;
> -	para->rows = 18;
> -	mctl_core_init(para);
> +	config->cols = 8;
> +	config->rows = 18;
> +	mctl_core_init(para, config);
> 
> -	for (para->rows = 13; para->rows < 18; para->rows++) {
> +	for (config->rows = 13; config->rows < 18; config->rows++) {
>  		/* 8 banks, 8 bit per byte and 16/32 bit width */
> -		if (mctl_mem_matches((1 << (para->rows + para->cols +
> -					    4 + para-
>bus_full_width))))
> +		if (mctl_mem_matches((1 << (config->rows + config->cols +
> +					    4 + config-
>bus_full_width))))
>  			break;
>  	}
> 
>  	/* detect column address bits */
> -	para->cols = 11;
> -	mctl_core_init(para);
> +	config->cols = 11;
> +	mctl_core_init(para, config);
> 
> -	for (para->cols = 8; para->cols < 11; para->cols++) {
> +	for (config->cols = 8; config->cols < 11; config->cols++) {
>  		/* 8 bits per byte and 16/32 bit width */
> -		if (mctl_mem_matches(1 << (para->cols + 1 +
> -					   para-
>bus_full_width)))
> +		if (mctl_mem_matches(1 << (config->cols + 1 +
> +					   config-
>bus_full_width)))
>  			break;
>  	}
>  }
> 
> -unsigned long mctl_calc_size(const struct dram_para *para)
> +unsigned long mctl_calc_size(const struct dram_config *config)
>  {
> -	u8 width = para->bus_full_width ? 4 : 2;
> +	u8 width = config->bus_full_width ? 4 : 2;
> 
>  	/* TODO: non-(LP)DDR3 */
> 
>  	/* 8 banks */
> -	return (1ULL << (para->cols + para->rows + 3)) * width * para-
>ranks;
> +	return (1ULL << (config->cols + config->rows + 3)) * width *
> config->ranks; }
> 
>  #define SUN50I_H6_LPDDR3_DX_WRITE_DELAYS			\
> @@ -665,36 +670,37 @@ unsigned long mctl_calc_size(const struct dram_para
> *para) {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 },	\
>  	 {  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 }}
> 
> +static const struct dram_para para = {
> +	.clk = CONFIG_DRAM_CLK,
> +#ifdef CONFIG_SUNXI_DRAM_H6_LPDDR3
> +	.type = SUNXI_DRAM_TYPE_LPDDR3,
> +	.dx_read_delays  = SUN50I_H6_LPDDR3_DX_READ_DELAYS,
> +	.dx_write_delays = SUN50I_H6_LPDDR3_DX_WRITE_DELAYS,
> +#elif defined(CONFIG_SUNXI_DRAM_H6_DDR3_1333)
> +	.type = SUNXI_DRAM_TYPE_DDR3,
> +	.dx_read_delays  = SUN50I_H6_DDR3_DX_READ_DELAYS,
> +	.dx_write_delays = SUN50I_H6_DDR3_DX_WRITE_DELAYS,
> +#endif
> +};
> +
>  unsigned long sunxi_dram_init(void)
>  {
>  	struct sunxi_mctl_com_reg * const mctl_com =
>  			(struct sunxi_mctl_com_reg 
*)SUNXI_DRAM_COM_BASE;
>  	struct sunxi_prcm_reg *const prcm =
>  		(struct sunxi_prcm_reg *)SUNXI_PRCM_BASE;
> -	struct dram_para para = {
> -		.clk = CONFIG_DRAM_CLK,
> -#ifdef CONFIG_SUNXI_DRAM_H6_LPDDR3
> -		.type = SUNXI_DRAM_TYPE_LPDDR3,
> -		.dx_read_delays  = SUN50I_H6_LPDDR3_DX_READ_DELAYS,
> -		.dx_write_delays = SUN50I_H6_LPDDR3_DX_WRITE_DELAYS,
> -#elif defined(CONFIG_SUNXI_DRAM_H6_DDR3_1333)
> -		.type = SUNXI_DRAM_TYPE_DDR3,
> -		.dx_read_delays  = SUN50I_H6_DDR3_DX_READ_DELAYS,
> -		.dx_write_delays = SUN50I_H6_DDR3_DX_WRITE_DELAYS,
> -#endif
> -	};
> -
> +	struct dram_config config;
>  	unsigned long size;
> 
>  	setbits_le32(&prcm->res_cal_ctrl, BIT(8));
>  	clrbits_le32(&prcm->ohms240, 0x3f);
> 
> -	mctl_auto_detect_rank_width(&para);
> -	mctl_auto_detect_dram_size(&para);
> +	mctl_auto_detect_rank_width(&para, &config);
> +	mctl_auto_detect_dram_size(&para, &config);
> 
> -	mctl_core_init(&para);
> +	mctl_core_init(&para, &config);
> 
> -	size = mctl_calc_size(&para);
> +	size = mctl_calc_size(&config);
> 
>  	clrsetbits_le32(&mctl_com->cr, 0xf0, (size >> (10 + 10 + 4)) & 
0xf0);




