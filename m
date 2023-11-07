Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CB9C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 12:53:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3924687076;
	Tue,  7 Nov 2023 13:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vHO31/AJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0FFED8711D; Tue,  7 Nov 2023 13:53:05 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC36887076
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 13:53:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32f87b1c725so3909261f8f.3
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 04:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699361581; x=1699966381; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L23muOCsaZqPTdTTdN0oP8cRRGurhzulq7RZc4cSZGU=;
 b=vHO31/AJImP63OHzRqzjX082EHmtPzz+DtzpEASFMmi/+KrYcWiYR6QwuIxj+Lzu3P
 82JFEFOwfdSZyTNgD1Ed8WwFMSOEC6NWdK/kQ61SJyoEHX1RR6/BpA8sq4E5zJBdBNTP
 Zcs1lz3PKUacVTWpS/IEKRTPTfqjMFqOjCL8bBbC2SL+N6uGxvWDoTx0z5PEoGl9CRfv
 +Mo8A4UEioGjX3LPKMvS2rQi+6a+8tjYd+FupLiWTQEauOSPwiRKGynC27NL/LTBKxyv
 NGoJo38uWb7zNS3QhqBj5EaQNxj8NXO3lqIrwXtcg3EioGgjILafSq7dPesTr48ub55n
 cQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699361581; x=1699966381;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L23muOCsaZqPTdTTdN0oP8cRRGurhzulq7RZc4cSZGU=;
 b=vmdVLYg9E0AXkWPsTtB0GInu5fGOLqrPGLhf7AXyKu6+sXlGoeA1Gl5kxST1AaFHvB
 39jcoMsZL5TQP+Lw/x67fK7e3jj8qaQhlSLW29zloR7kO2kk2jnhh+6M2n7TuWcfuXeA
 QktnAI8EvlD+4S1bdCxsS3zEO+Q1AjSMLOHDfkRKZBqe4Nh6sa9MkfRUPCkRErFxf5Lg
 AKn4OfM7xlaM2wlADlAedDM+toauKh/LjffjyDFGHQFxkl8J4FIRQzfLpkOstD8DdsLV
 s+S9B1EM+7Z0CMYgNbzTA1b6zdtmc5esRRWt3opoFtpU5YZ29SzytHfjxhq6BdfboN5m
 rk8w==
X-Gm-Message-State: AOJu0Yze/aJtxsWVZRyw1KTzLiSDq8laPOkoL9fjFM+pk3n6GS/Hzuaj
 obr0u4hufsSTlONQN4ZazpqJfQ==
X-Google-Smtp-Source: AGHT+IHnTD6ur3rp0wRHDL+iOYTVNeUPTKGmXwUGfjGFqc7xpcxgwiOw4F6+955RovViLZo+5DCMfA==
X-Received: by 2002:a05:6000:1849:b0:32f:7ae6:64a7 with SMTP id
 c9-20020a056000184900b0032f7ae664a7mr25734135wri.55.1699361581347; 
 Tue, 07 Nov 2023 04:53:01 -0800 (PST)
Received: from [192.168.1.7] (host-92-25-138-185.as13285.net. [92.25.138.185])
 by smtp.gmail.com with ESMTPSA id
 b18-20020a5d6352000000b0032f933556b8sm2300409wrw.7.2023.11.07.04.53.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 04:53:00 -0800 (PST)
Message-ID: <796d3b72-10c1-4305-b9ec-c1baa9e1024e@linaro.org>
Date: Tue, 7 Nov 2023 12:53:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] clk/qcom: fix rcg divider value
To: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Perkov <luka.perkov@sartura.hr>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
References: <20231107-b4-qcom-clk-v4-0-82bbaf1a796d@linaro.org>
 <20231107-b4-qcom-clk-v4-7-82bbaf1a796d@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20231107-b4-qcom-clk-v4-7-82bbaf1a796d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 07/11/2023 12:41, Caleb Connolly wrote:
> The RCG divider field takes a value of (2*h - 1) where h is the divisor.
> This allows fractional dividers to be supported by calculating them at
> compile time using a macro.
> 
> However, the clk_rcg_set_rate_mnd() function was also performing the
> calculation. Clean this all up and consistently use the F() macro to
> calculate these at compile time and properly support fractional divisors.
> 
> Additionally, improve clk_bcr_update() to timeout with a warning rather
> than hanging the board, and make the freq_tbl struct and helpers common
> so that they can be reused by future platforms.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Forgot to pick up Sumit's R-b here.
> ---
>  drivers/clk/qcom/clock-apq8016.c |  2 +-
>  drivers/clk/qcom/clock-apq8096.c |  2 +-
>  drivers/clk/qcom/clock-qcom.c    | 64 +++++++++++++++++++++++++++++-----------
>  drivers/clk/qcom/clock-qcom.h    | 11 +++++++
>  drivers/clk/qcom/clock-qcs404.c  | 16 +++++-----
>  drivers/clk/qcom/clock-sdm845.c  | 26 ----------------
>  6 files changed, 67 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index 498e8ef6780d..c0ce570edc79 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -78,7 +78,7 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
>  /* SDHCI */
>  static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
>  {
> -	int div = 8; /* 100MHz default */
> +	int div = 15; /* 100MHz default */
>  
>  	if (rate == 200000000)
>  		div = 4;
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index 367c0f06ae20..cf1a347309a5 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -65,7 +65,7 @@ static struct vote_clk gcc_blsp2_ahb_clk = {
>  
>  static int clk_init_sdc(struct msm_clk_priv *priv, uint rate)
>  {
> -	int div = 3;
> +	int div = 5;
>  
>  	clk_enable_cbc(priv->base + SDCC2_AHB_CBCR);
>  	clk_rcg_set_rate_mnd(priv->base, &sdc_regs, div, 0, 0,
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index fc478554f982..7c683e519226 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -19,6 +19,8 @@
>  #include <dm/lists.h>
>  #include <errno.h>
>  #include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/delay.h>
>  #include <linux/bitops.h>
>  #include <reset-uclass.h>
>  
> @@ -68,30 +70,42 @@ void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk)
>  /* Update clock command via CMD_RCGR */
>  void clk_bcr_update(phys_addr_t apps_cmd_rcgr)
>  {
> +	u32 count;
>  	setbits_le32(apps_cmd_rcgr, APPS_CMD_RCGR_UPDATE);
>  
>  	/* Wait for frequency to be updated. */
> -	while (readl(apps_cmd_rcgr) & APPS_CMD_RCGR_UPDATE)
> -		;
> +	for (count = 0; count < 50000; count++) {
> +		if (!(readl(apps_cmd_rcgr) & APPS_CMD_RCGR_UPDATE))
> +			break;
> +		udelay(1);
> +	}
> +	WARN(count == 50000, "WARNING: RCG @ %#llx [%#010x] stuck at off\n",
> +	     apps_cmd_rcgr, readl(apps_cmd_rcgr));
>  }
>  
> -#define CFG_MODE_DUAL_EDGE (0x2 << 12) /* Counter mode */
> +#define CFG_SRC_DIV_MASK	0b11111
> +#define CFG_SRC_SEL_SHIFT	8
> +#define CFG_SRC_SEL_MASK	(0x7 << CFG_SRC_SEL_SHIFT)
> +#define CFG_MODE_SHIFT		12
> +#define CFG_MODE_MASK		(0x3 << CFG_MODE_SHIFT)
> +#define CFG_MODE_DUAL_EDGE	(0x2 << CFG_MODE_SHIFT)
> +#define CFG_HW_CLK_CTRL_MASK	BIT(20)
>  
> -#define CFG_MASK 0x3FFF
> -
> -#define CFG_DIVIDER_MASK 0x1F
> -
> -/* root set rate for clocks with half integer and MND divider */
> +/*
> + * root set rate for clocks with half integer and MND divider
> + * div should be pre-calculated ((div * 2) - 1)
> + */
>  void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>  			  int div, int m, int n, int source, u8 mnd_width)
>  {
>  	u32 cfg;
>  	/* M value for MND divider. */
>  	u32 m_val = m;
> +	u32 n_minus_m = n - m;
>  	/* NOT(N-M) value for MND divider. */
> -	u32 n_val = ~((n) - (m)) * !!(n);
> +	u32 n_val = ~n_minus_m * !!(n);
>  	/* NOT 2D value for MND divider. */
> -	u32 d_val = ~(n);
> +	u32 d_val = ~(clamp_t(u32, n, m, n_minus_m));
>  	u32 mask = BIT(mnd_width) - 1;
>  
>  	debug("m %#x n %#x d %#x div %#x mask %#x\n", m_val, n_val, d_val, div, mask);
> @@ -103,15 +117,13 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>  
>  	/* setup src select and divider */
>  	cfg  = readl(base + regs->cfg_rcgr);
> -	cfg &= ~CFG_MASK;
> -	cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
> +	cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK);
> +	cfg |= source & CFG_SRC_SEL_MASK; /* Select clock source */
>  
> -	/* Set the divider; HW permits fraction dividers (+0.5), but
> -	   for simplicity, we will support integers only */
>  	if (div)
> -		cfg |= (2 * div - 1) & CFG_DIVIDER_MASK;
> +		cfg |= div & CFG_SRC_DIV_MASK;
>  
> -	if (n_val)
> +	if (n && n != m)
>  		cfg |= CFG_MODE_DUAL_EDGE;
>  
>  	writel(cfg, base + regs->cfg_rcgr); /* Write new clock configuration */
> @@ -128,7 +140,7 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>  
>  	/* setup src select and divider */
>  	cfg  = readl(base + regs->cfg_rcgr);
> -	cfg &= ~CFG_MASK;
> +	cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK);
>  	cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
>  
>  	/*
> @@ -136,7 +148,7 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>  	 * for simplicity, we will support integers only
>  	 */
>  	if (div)
> -		cfg |= (2 * div - 1) & CFG_DIVIDER_MASK;
> +		cfg |= (2 * div - 1) & CFG_SRC_DIV_MASK;
>  
>  	writel(cfg, base + regs->cfg_rcgr); /* Write new clock configuration */
>  
> @@ -144,6 +156,22 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>  	clk_bcr_update(base + regs->cmd_rcgr);
>  }
>  
> +const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
> +{
> +	if (!f)
> +		return NULL;
> +
> +	if (!f->freq)
> +		return f;
> +
> +	for (; f->freq; f++)
> +		if (rate <= f->freq)
> +			return f;
> +
> +	/* Default to our fastest rate */
> +	return f - 1;
> +}
> +
>  static int msm_clk_probe(struct udevice *dev)
>  {
>  	struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 24a32cb9666d..01088c19015a 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -32,6 +32,16 @@ struct bcr_regs {
>  	uintptr_t D;
>  };
>  
> +struct freq_tbl {
> +	uint freq;
> +	uint src;
> +	u8 pre_div;
> +	u16 m;
> +	u16 n;
> +};
> +
> +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
> +
>  struct gate_clk {
>  	uintptr_t reg;
>  	u32 en_val;
> @@ -71,6 +81,7 @@ void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
>  void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
>  void clk_enable_cbc(phys_addr_t cbcr);
>  void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
> +const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate);
>  void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>  			  int div, int m, int n, int source, u8 mnd_width);
>  void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
> diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> index f234ab5d6541..f5b352803927 100644
> --- a/drivers/clk/qcom/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -203,7 +203,7 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>  		break;
>  	case GCC_SDCC1_APPS_CLK:
>  		/* SDCC1: 200MHz */
> -		clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 4, 0, 0,
> +		clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 7, 0, 0,
>  				     CFG_CLK_SRC_GPLL0, 8);
>  		clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>  		clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
> @@ -213,16 +213,16 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>  		break;
>  	case GCC_ETH_RGMII_CLK:
>  		if (rate == 250000000)
> -			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 0, 0,
> +			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 0, 0,
>  					     CFG_CLK_SRC_GPLL1, 8);
>  		else if (rate == 125000000)
> -			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 4, 0, 0,
> +			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 7, 0, 0,
>  					     CFG_CLK_SRC_GPLL1, 8);
>  		else if (rate == 50000000)
> -			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 10, 0, 0,
> +			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 19, 0, 0,
>  					     CFG_CLK_SRC_GPLL1, 8);
>  		else if (rate == 5000000)
> -			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 1, 50,
> +			clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 1, 50,
>  					     CFG_CLK_SRC_GPLL1, 8);
>  		break;
>  	default:
> @@ -239,7 +239,7 @@ static int qcs404_clk_enable(struct clk *clk)
>  	switch (clk->id) {
>  	case GCC_USB30_MASTER_CLK:
>  		clk_enable_cbc(priv->base + USB30_MASTER_CBCR);
> -		clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 4, 0, 0,
> +		clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 7, 0, 0,
>  				     CFG_CLK_SRC_GPLL0, 8);
>  		break;
>  	case GCC_SYS_NOC_USB3_CLK:
> @@ -261,14 +261,14 @@ static int qcs404_clk_enable(struct clk *clk)
>  		/* SPEED_1000: freq -> 250MHz */
>  		clk_enable_cbc(priv->base + ETH_PTP_CBCR);
>  		clk_enable_gpll0(priv->base, &gpll1_vote_clk);
> -		clk_rcg_set_rate_mnd(priv->base, &emac_ptp_regs, 2, 0, 0,
> +		clk_rcg_set_rate_mnd(priv->base, &emac_ptp_regs, 3, 0, 0,
>  				     CFG_CLK_SRC_GPLL1, 8);
>  		break;
>  	case GCC_ETH_RGMII_CLK:
>  		/* SPEED_1000: freq -> 250MHz */
>  		clk_enable_cbc(priv->base + ETH_RGMII_CBCR);
>  		clk_enable_gpll0(priv->base, &gpll1_vote_clk);
> -		clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 0, 0,
> +		clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 0, 0,
>  				     CFG_CLK_SRC_GPLL1, 8);
>  		break;
>  	case GCC_ETH_SLAVE_AHB_CLK:
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index 6af1f38302d2..36ffee79d966 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -27,16 +27,6 @@
>  #define SE9_UART_APPS_N		0x18154
>  #define SE9_UART_APPS_D		0x18158
>  
> -#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
> -
> -struct freq_tbl {
> -	uint freq;
> -	uint src;
> -	u8 pre_div;
> -	u16 m;
> -	u16 n;
> -};
> -
>  static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
>  	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
>  	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
> @@ -64,22 +54,6 @@ static const struct bcr_regs uart2_regs = {
>  	.D = SE9_UART_APPS_D,
>  };
>  
> -const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
> -{
> -	if (!f)
> -		return NULL;
> -
> -	if (!f->freq)
> -		return f;
> -
> -	for (; f->freq; f++)
> -		if (rate <= f->freq)
> -			return f;
> -
> -	/* Default to our fastest rate */
> -	return f - 1;
> -}
> -
>  static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
>  {
>  	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> 

-- 
// Caleb (they/them)
