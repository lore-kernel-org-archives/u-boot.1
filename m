Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C22C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 07:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5921386F70;
	Mon,  6 Nov 2023 08:13:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PqHOPq9e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED85E86487; Mon,  6 Nov 2023 08:13:02 +0100 (CET)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com
 [IPv6:2607:f8b0:4864:20::e34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FFBD86C31
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 08:12:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-45db0df090eso661643137.3
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 23:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699254776; x=1699859576; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hp9jOiz2i7XejeuV/+B+vbRcOthh/pNO1Mh3NlzHvtE=;
 b=PqHOPq9e9GDKOohnmHbRj6Pg7NVlAJ3sL6wwkBb26SB9ibkOwYVXafW3Y2hfTwhU0s
 Kx7dbcj/egxBkOfvmjsPyXHFMxXTc91dEsezbEi+egEucWOor3AC7TlACFltFVvK98v8
 ioPiqfUNdJ3tbV6eAyGI7DiWiwg6zTFzQEMYFVk79FdC/qQJ/AvypGVsHoTxG32a0EIY
 705HlRpG4udIeuFeU8+OeYCWehffRsDcEZPA5kRUCCvfn74Oc9mzTQILWHInmjp6XRL8
 DsCZgleqzQD9135W0pVXQsNQO040yf/aLEyC5mmpZaDcG8BmBDF1+gg8Spb5G/ju1igE
 wPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699254776; x=1699859576;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hp9jOiz2i7XejeuV/+B+vbRcOthh/pNO1Mh3NlzHvtE=;
 b=W4SUQh2XchAAPNeVq52n2QFsfSkPokunhMG+UcZ+TOw4GAhYkrFSLxZHgE5kt76Qmp
 s43wucyveoJJKwsniSYVb49yOMIKa6znDKTk5JaequctFqy8qS8yAEY3n7HJAsXf48eM
 xIfdeEEzN5joezAMbHO3RrvLLKwyS0bwNoX+78TKiXMn7g63ITyXSWbHgYsHgSt1XmJR
 816wm8i31vrhHUzuVdA1/3Y1RBqoVaDkXx7NQQ30ATVW0Tve/ordUWC3x2zNmKQBFUHf
 qnkj8OtE3bUgHyHg4OhcwJ1B97FeQ8sjkd2rOKVPled0IkiJQ3C+ZeZt2f7SwujZFa1Q
 J2HA==
X-Gm-Message-State: AOJu0Yx5h/AhORgczU2RlujBu+2RXggAKGOzEemHEbcz/cyIXAzaqiFy
 yZx2NdGzU8Nh3akdOz8puURT7lCa9lUSwiJnvfQSWw==
X-Google-Smtp-Source: AGHT+IG/o+XN9E3WgaiceKl6hsJ6D08/vXrYDGw/8InovOpMo4nhwVUo51f9l4PM57uV0jjqHwMyx/ra/+F/qZgmNQ0=
X-Received: by 2002:a67:c103:0:b0:45d:9223:9532 with SMTP id
 d3-20020a67c103000000b0045d92239532mr7544453vsj.19.1699254775709; Sun, 05 Nov
 2023 23:12:55 -0800 (PST)
MIME-Version: 1.0
References: <20231103-b4-qcom-clk-v3-0-8d2d460ece84@linaro.org>
 <20231103-b4-qcom-clk-v3-7-8d2d460ece84@linaro.org>
In-Reply-To: <20231103-b4-qcom-clk-v3-7-8d2d460ece84@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 6 Nov 2023 12:42:44 +0530
Message-ID: <CAFA6WYMKETrXc_g+i3+COx7opNa6k1hqHb0MP8n2uQPCr4Rs_Q@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] clk/qcom: fix rcg divider value
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

On Fri, 3 Nov 2023 at 21:11, Caleb Connolly <caleb.connolly@linaro.org> wrote:
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
>  drivers/clk/qcom/clock-qcom.c    | 64 +++++++++++++++++++++++++++++-----------
>  drivers/clk/qcom/clock-qcom.h    | 11 +++++++
>  drivers/clk/qcom/clock-qcs404.c  | 16 +++++-----
>  drivers/clk/qcom/clock-sdm845.c  | 26 ----------------
>  6 files changed, 67 insertions(+), 54 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

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
> @@ -103,15 +117,13 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
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
> +       if (n && n != m)
>                 cfg |= CFG_MODE_DUAL_EDGE;
>
>         writel(cfg, base + regs->cfg_rcgr); /* Write new clock configuration */
> @@ -128,7 +140,7 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>
>         /* setup src select and divider */
>         cfg  = readl(base + regs->cfg_rcgr);
> -       cfg &= ~CFG_MASK;
> +       cfg &= ~(CFG_SRC_SEL_MASK | CFG_MODE_MASK | CFG_HW_CLK_CTRL_MASK);
>         cfg |= source & CFG_CLK_SRC_MASK; /* Select clock source */
>
>         /*
> @@ -136,7 +148,7 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>          * for simplicity, we will support integers only
>          */
>         if (div)
> -               cfg |= (2 * div - 1) & CFG_DIVIDER_MASK;
> +               cfg |= (2 * div - 1) & CFG_SRC_DIV_MASK;
>
>         writel(cfg, base + regs->cfg_rcgr); /* Write new clock configuration */
>
> @@ -144,6 +156,22 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
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
> index 6af1f38302d2..36ffee79d966 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -27,16 +27,6 @@
>  #define SE9_UART_APPS_N                0x18154
>  #define SE9_UART_APPS_D                0x18158
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
> @@ -64,22 +54,6 @@ static const struct bcr_regs uart2_regs = {
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
