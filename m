Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815DAC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 08:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E570887483;
	Thu,  2 Nov 2023 09:24:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eXDqa+2Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA9B9864C3; Thu,  2 Nov 2023 09:24:36 +0100 (CET)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com
 [IPv6:2607:f8b0:4864:20::932])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D291587650
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 09:24:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-7b6e1770519so232974241.2
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698913471; x=1699518271; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZwR2LFJjInxn5ynlUibTQjLubvXA9DyAzTDpU4a/Mv8=;
 b=eXDqa+2Z/dQCUlgdagjx3s5/2dw6dkItHFmUcwyRMDleaQNVbQs1zOhK8uDFmjb5p0
 ylWtIRlvMAX+JDBYHLZSrvlw7GDyEOzh8NfSDdNggaf04qHezvaJvU0V4iAs0WCaFK2R
 WJRwnBWNT9l+DyGGai4qTNYGzXeIIRTBgcCaHHDO5MefJkBT9r/GYOIvHRCy8Eq722zu
 pEn2h8/oXqi2bi1WzvSlSC4yAoT+fJvOzXF5QDD5u8eIsn0NQIGtby2NsewT3DQLudtT
 oS9C2KLrQq0lSbwt7bQ0Xu36KUimG7T1NPCSqudyOdeTKlZtEk2nwp2Y7Gbm97ZMl0UJ
 7svA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698913471; x=1699518271;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZwR2LFJjInxn5ynlUibTQjLubvXA9DyAzTDpU4a/Mv8=;
 b=NkBSnfO3Omoisk7v8lBScaqRflujWWb8M7qiU/H6toMLLW3jRHOO0hirEk+Q4wyx2v
 ODIF+qwNV4nSTXpa6Gfv1P4DrBvmtOOxIa+DrYeoMgSdPjqsC6EmiAF1u8KAsmwK7DoC
 VzahChO3+gUnTbRNznaoSFObkV9O+O08hHlF4/gYvXi/OYy7YfiyKGY/YdUc49D6QGC3
 M9U/BUd1tQmC3quCxbKdO6QiHXuI7JekuvsdCK7FHUNsuHMF6mAhs+9/e2RL3Sr4iIFV
 7Ca0TWZRn0B6vizLF5Xoq0JeVF46UpZOGG8wBwuF8ocUF9GOIUiXTarKyNMspG8FkP2j
 +IJw==
X-Gm-Message-State: AOJu0YxyszbYNigXEg1nkx+WCeISet8TMDE+6XgF34ZukoSHK6PfLGce
 B4sE7q8IvpW2yu5kcDUkKbw+o5nXRB8ePhtCiOjgaA==
X-Google-Smtp-Source: AGHT+IEz1d0ObLIaFhuHKI41vqkUnTQ4c4uaQKhEiavu+/00oz6XmywhTzvt3y8WA2vOyl6OFvXnJgq4v+VrdFLDURM=
X-Received: by 2002:a05:6102:1b:b0:44d:42c4:f4c0 with SMTP id
 j27-20020a056102001b00b0044d42c4f4c0mr12780092vsp.3.1698913471356; Thu, 02
 Nov 2023 01:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
 <20231024-b4-qcom-clk-v2-7-6572bc2be690@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v2-7-6572bc2be690@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 2 Nov 2023 13:54:19 +0530
Message-ID: <CAFA6WYNLiLtdJ71pZWv4x11fBjhM3ztyEh_ZUyijHs0x8UEQ_A@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] clk/qcom: fix rcg divider value
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 31 Oct 2023 at 03:54, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
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
> ---
>  drivers/clk/qcom/clock-apq8016.c |  2 +-
>  drivers/clk/qcom/clock-apq8096.c |  2 +-
>  drivers/clk/qcom/clock-qcom.c    | 66 +++++++++++++++++++++++++++++-----------
>  drivers/clk/qcom/clock-qcom.h    | 11 +++++++
>  drivers/clk/qcom/clock-qcs404.c  | 16 +++++-----
>  drivers/clk/qcom/clock-sdm845.c  | 26 ----------------
>  6 files changed, 69 insertions(+), 54 deletions(-)
>

Although changes look fine to me, I will find some cycles to give them
a try on real hardware.

> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index 630619c83454..eb812934cbae 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -78,7 +78,7 @@ static struct vote_clk gcc_blsp1_ahb_clk = {
>  /* SDHCI */
>  static int clk_init_sdc(struct msm_clk_priv *priv, int slot, uint rate)
>  {
> -       int div = 8; /* 100MHz default */
> +       int div = 15; /* 100MHz default */
>
>         if (rate == 200000000)
>                 div = 4;
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index 095c1b431245..55f16c14e046 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -65,7 +65,7 @@ static struct vote_clk gcc_blsp2_ahb_clk = {
>
>  static int clk_init_sdc(struct msm_clk_priv *priv, uint rate)
>  {
> -       int div = 3;
> +       int div = 5;
>
>         clk_enable_cbc(priv->base + SDCC2_AHB_CBCR);
>         clk_rcg_set_rate_mnd(priv->base, &sdc_regs, div, 0, 0,
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index fc478554f982..58374d356942 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -12,6 +12,8 @@
>   * Based on Little Kernel driver, simplified
>   */
>
> +#define LOG_DEBUG

Only needed for debug purposes?

-Sumit

> +
>  #include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
> @@ -19,6 +21,8 @@
>  #include <dm/lists.h>
>  #include <errno.h>
>  #include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/delay.h>
>  #include <linux/bitops.h>
>  #include <reset-uclass.h>
>
> @@ -68,30 +72,42 @@ void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk)
>  /* Update clock command via CMD_RCGR */
>  void clk_bcr_update(phys_addr_t apps_cmd_rcgr)
>  {
> +       u32 count;
>         setbits_le32(apps_cmd_rcgr, APPS_CMD_RCGR_UPDATE);
>
>         /* Wait for frequency to be updated. */
> -       while (readl(apps_cmd_rcgr) & APPS_CMD_RCGR_UPDATE)
> -               ;
> +       for (count = 0; count < 50000; count++) {
> +               if (!(readl(apps_cmd_rcgr) & APPS_CMD_RCGR_UPDATE))
> +                       break;
> +               udelay(1);
> +       }
> +       WARN(count == 50000, "WARNING: RCG @ %#llx [%#010x] stuck at off\n",
> +            apps_cmd_rcgr, readl(apps_cmd_rcgr));
>  }
>
> -#define CFG_MODE_DUAL_EDGE (0x2 << 12) /* Counter mode */
> +#define CFG_SRC_DIV_MASK       0b11111
> +#define CFG_SRC_SEL_SHIFT      8
> +#define CFG_SRC_SEL_MASK       (0x7 << CFG_SRC_SEL_SHIFT)
> +#define CFG_MODE_SHIFT         12
> +#define CFG_MODE_MASK          (0x3 << CFG_MODE_SHIFT)
> +#define CFG_MODE_DUAL_EDGE     (0x2 << CFG_MODE_SHIFT)
> +#define CFG_HW_CLK_CTRL_MASK   BIT(20)
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
>                           int div, int m, int n, int source, u8 mnd_width)
>  {
>         u32 cfg;
>         /* M value for MND divider. */
>         u32 m_val = m;
> +       u32 n_minus_m = n - m;
>         /* NOT(N-M) value for MND divider. */
> -       u32 n_val = ~((n) - (m)) * !!(n);
> +       u32 n_val = ~n_minus_m * !!(n);
>         /* NOT 2D value for MND divider. */
> -       u32 d_val = ~(n);
> +       u32 d_val = ~(clamp_t(u32, n, m, n_minus_m));
>         u32 mask = BIT(mnd_width) - 1;
>
>         debug("m %#x n %#x d %#x div %#x mask %#x\n", m_val, n_val, d_val, div, mask);
> @@ -103,15 +119,13 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>
>         /* setup src select and divider */
>         cfg  = readl(base + regs->cfg_rcgr);
> -       cfg &= ~CFG_MASK;
> -       cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
> +       cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK);
> +       cfg |= source & CFG_SRC_SEL_MASK; /* Select clock source */
>
> -       /* Set the divider; HW permits fraction dividers (+0.5), but
> -          for simplicity, we will support integers only */
>         if (div)
> -               cfg |= (2 * div - 1) & CFG_DIVIDER_MASK;
> +               cfg |= div & CFG_SRC_DIV_MASK;
>
> -       if (n_val)
> +       if (n && (n != m))
>                 cfg |= CFG_MODE_DUAL_EDGE;
>
>         writel(cfg, base + regs->cfg_rcgr); /* Write new clock configuration */
> @@ -128,7 +142,7 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>
>         /* setup src select and divider */
>         cfg  = readl(base + regs->cfg_rcgr);
> -       cfg &= ~CFG_MASK;
> +       cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK);
>         cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
>
>         /*
> @@ -136,7 +150,7 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>          * for simplicity, we will support integers only
>          */
>         if (div)
> -               cfg |= (2 * div - 1) & CFG_DIVIDER_MASK;
> +               cfg |= (2 * div - 1) & CFG_SRC_DIV_MASK;
>
>         writel(cfg, base + regs->cfg_rcgr); /* Write new clock configuration */
>
> @@ -144,6 +158,22 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>         clk_bcr_update(base + regs->cmd_rcgr);
>  }
>
> +const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
> +{
> +       if (!f)
> +               return NULL;
> +
> +       if (!f->freq)
> +               return f;
> +
> +       for (; f->freq; f++)
> +               if (rate <= f->freq)
> +                       return f;
> +
> +       /* Default to our fastest rate */
> +       return f - 1;
> +}
> +
>  static int msm_clk_probe(struct udevice *dev)
>  {
>         struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 24a32cb9666d..01088c19015a 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -32,6 +32,16 @@ struct bcr_regs {
>         uintptr_t D;
>  };
>
> +struct freq_tbl {
> +       uint freq;
> +       uint src;
> +       u8 pre_div;
> +       u16 m;
> +       u16 n;
> +};
> +
> +#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
> +
>  struct gate_clk {
>         uintptr_t reg;
>         u32 en_val;
> @@ -71,6 +81,7 @@ void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
>  void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
>  void clk_enable_cbc(phys_addr_t cbcr);
>  void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
> +const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate);
>  void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>                           int div, int m, int n, int source, u8 mnd_width);
>  void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
> diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> index 921abf1f699b..429ff35e1d1a 100644
> --- a/drivers/clk/qcom/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -203,7 +203,7 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>                 break;
>         case GCC_SDCC1_APPS_CLK:
>                 /* SDCC1: 200MHz */
> -               clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 4, 0, 0,
> +               clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 7, 0, 0,
>                                      CFG_CLK_SRC_GPLL0, 8);
>                 clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>                 clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
> @@ -213,16 +213,16 @@ static ulong qcs404_clk_set_rate(struct clk *clk, ulong rate)
>                 break;
>         case GCC_ETH_RGMII_CLK:
>                 if (rate == 250000000)
> -                       clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 0, 0,
> +                       clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 0, 0,
>                                              CFG_CLK_SRC_GPLL1, 8);
>                 else if (rate == 125000000)
> -                       clk_rcg_set_rate_mnd(priv->base, &emac_regs, 4, 0, 0,
> +                       clk_rcg_set_rate_mnd(priv->base, &emac_regs, 7, 0, 0,
>                                              CFG_CLK_SRC_GPLL1, 8);
>                 else if (rate == 50000000)
> -                       clk_rcg_set_rate_mnd(priv->base, &emac_regs, 10, 0, 0,
> +                       clk_rcg_set_rate_mnd(priv->base, &emac_regs, 19, 0, 0,
>                                              CFG_CLK_SRC_GPLL1, 8);
>                 else if (rate == 5000000)
> -                       clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 1, 50,
> +                       clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 1, 50,
>                                              CFG_CLK_SRC_GPLL1, 8);
>                 break;
>         default:
> @@ -239,7 +239,7 @@ static int qcs404_clk_enable(struct clk *clk)
>         switch (clk->id) {
>         case GCC_USB30_MASTER_CLK:
>                 clk_enable_cbc(priv->base + USB30_MASTER_CBCR);
> -               clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 4, 0, 0,
> +               clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 7, 0, 0,
>                                      CFG_CLK_SRC_GPLL0, 8);
>                 break;
>         case GCC_SYS_NOC_USB3_CLK:
> @@ -261,14 +261,14 @@ static int qcs404_clk_enable(struct clk *clk)
>                 /* SPEED_1000: freq -> 250MHz */
>                 clk_enable_cbc(priv->base + ETH_PTP_CBCR);
>                 clk_enable_gpll0(priv->base, &gpll1_vote_clk);
> -               clk_rcg_set_rate_mnd(priv->base, &emac_ptp_regs, 2, 0, 0,
> +               clk_rcg_set_rate_mnd(priv->base, &emac_ptp_regs, 3, 0, 0,
>                                      CFG_CLK_SRC_GPLL1, 8);
>                 break;
>         case GCC_ETH_RGMII_CLK:
>                 /* SPEED_1000: freq -> 250MHz */
>                 clk_enable_cbc(priv->base + ETH_RGMII_CBCR);
>                 clk_enable_gpll0(priv->base, &gpll1_vote_clk);
> -               clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 0, 0,
> +               clk_rcg_set_rate_mnd(priv->base, &emac_regs, 3, 0, 0,
>                                      CFG_CLK_SRC_GPLL1, 8);
>                 break;
>         case GCC_ETH_SLAVE_AHB_CLK:
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index 9e78da482c65..07e3605cdbaf 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -30,16 +30,6 @@
>  #define USB30_SEC_GDSCR                0x10004
>  #define USB30_PRIM_GDSCR       0xf004
>
> -#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
> -
> -struct freq_tbl {
> -       uint freq;
> -       uint src;
> -       u8 pre_div;
> -       u16 m;
> -       u16 n;
> -};
> -
>  static const struct freq_tbl ftbl_gcc_qupv3_wrap0_s0_clk_src[] = {
>         F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
>         F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
> @@ -67,22 +57,6 @@ static const struct bcr_regs uart2_regs = {
>         .D = SE9_UART_APPS_D,
>  };
>
> -const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
> -{
> -       if (!f)
> -               return NULL;
> -
> -       if (!f->freq)
> -               return f;
> -
> -       for (; f->freq; f++)
> -               if (rate <= f->freq)
> -                       return f;
> -
> -       /* Default to our fastest rate */
> -       return f - 1;
> -}
> -
>  static ulong sdm845_clk_set_rate(struct clk *clk, ulong rate)
>  {
>         struct msm_clk_priv *priv = dev_get_priv(clk->dev);
>
> --
> 2.42.0
>
