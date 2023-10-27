Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDA2C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 11:46:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94BDD870AC;
	Fri, 27 Oct 2023 13:46:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WmnFYKky";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1B2A86F85; Fri, 27 Oct 2023 13:46:19 +0200 (CEST)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com
 [IPv6:2607:f8b0:4864:20::92d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70ADB870AC
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 13:46:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x92d.google.com with SMTP id
 a1e0cc1a2514c-7b64810aebdso804298241.2
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698407176; x=1699011976; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zfniduPPKV/XNu+NJgNEa86UbaLlu9xHqtRxWeF2Q0s=;
 b=WmnFYKkyRSEbfF9JgwZ7EID3oCVw4MS7B7fVPvvNyEfDAv9IQjiBtjYZSvRTPWoar/
 2rOr6S8PScDQ1fRCNUInYvGwFMSd1rFZTxJap5rrDtkqigLgJgdyYYvtmZyBq7D6T4kY
 O+PztcEo6uWUkMhRiWbuaMPLHEg2ABzah6od7jaqCcuuNpWHjm75MmJqRnUcmjh/GBsx
 l1K0ny6L1uOESodXDt0naJOv4NbjEhDepzYY6pA1pjXta+Eqb4vr2bH7dBS/Xjf04TD0
 qOol2LQ0WqVUm8Sq9YSqbj7n+V6YM4CwlUL/ffdLM0rWoNhwWkE06KsAMuGdfqmpw+SE
 nIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698407176; x=1699011976;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zfniduPPKV/XNu+NJgNEa86UbaLlu9xHqtRxWeF2Q0s=;
 b=Xd0tq6Jc0Hka3Tcz/EM29huJ++I518I6HE+SNtHR+Fhoyn/zPPQ+kQmW76du/r27qQ
 jAB6Hs50+JzNW9BfmnkYpU6uAY4csYyndyay2S+YV7RZblShvUdn7qHJSP+2InYrO3BS
 GwQevzWsJaNM/vyTf6DUDHe4liisa6T1kHi83GCNCHXS1D9vVjkcIIV2u3LJm6NXlG66
 J8khCdESyp4f3ZreVjbFeCPyVnaoPQIC7/5/pzzbVM06zlyAm9ikR4BrOqPX0a0rm1JP
 Kv4IoTASt8H6AwlY2WHpIqn8QuJGL4LYAAayD3fjm13dpD3OTg7P5ilLjFLbP8vKyxWV
 eW6w==
X-Gm-Message-State: AOJu0YxRnj8Hb0VGHQpX8zgLQdd/tW0n1pPK+qd2uQomzpsXZEbckzgL
 yicANeVhTXEv/l+fo+fXjXmVIBZjeCMKnnuKYO0+3w==
X-Google-Smtp-Source: AGHT+IFhXxpwCcCgdV8ZF4elnlAhyFDhqzraZVzTbdln5V7K7FE/uR73EShYmmYkWgCr/hnIGa/li+fcbL8l2i2yOAU=
X-Received: by 2002:a67:e15a:0:b0:457:c650:b810 with SMTP id
 o26-20020a67e15a000000b00457c650b810mr2461254vsl.8.1698407176058; Fri, 27 Oct
 2023 04:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
 <20231024-b4-qcom-clk-v1-7-9d96359b9a82@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v1-7-9d96359b9a82@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 27 Oct 2023 17:16:04 +0530
Message-ID: <CAFA6WYMkXnfGJZRe+RimSUZKb-daKBx+TG66YuvHSqo-pwwHKw@mail.gmail.com>
Subject: Re: [PATCH 7/8] clk/qcom: add mnd_width to clk_rcg_set_rate_mnd()
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Luka Kovacic <luka.kovacic@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>,
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

On Wed, 25 Oct 2023 at 01:55, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> This property is needed on some platforms to ensure that only the
> relevant bits are set in the M/N/D registers.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/clk/qcom/clock-apq8016.c |  4 ++--
>  drivers/clk/qcom/clock-apq8096.c |  4 ++--
>  drivers/clk/qcom/clock-qcom.c    | 11 +++++++----
>  drivers/clk/qcom/clock-qcom.h    |  2 +-
>  drivers/clk/qcom/clock-qcs404.c  | 20 ++++++++++----------
>  drivers/clk/qcom/clock-sdm845.c  |  3 +--
>  6 files changed, 23 insertions(+), 21 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index f74f7a0f5ad9..5eba18739cfb 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -61,7 +61,7 @@ static int clk_init_sdc(struct qcom_cc_priv *priv, int slot, uint rate)
>         clk_enable_cbc(priv->base + SDCC_AHB_CBCR(slot));
>         /* 800Mhz/div, gpll0 */
>         clk_rcg_set_rate_mnd(priv->base, &sdc_regs[slot], div, 0, 0,
> -                            CFG_CLK_SRC_GPLL0);
> +                            CFG_CLK_SRC_GPLL0, 8);
>         clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>         clk_enable_cbc(priv->base + SDCC_APPS_CBCR(slot));
>
> @@ -84,7 +84,7 @@ static int clk_init_uart(struct qcom_cc_priv *priv)
>
>         /* 7372800 uart block clock @ GPLL0 */
>         clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 1, 144, 15625,
> -                            CFG_CLK_SRC_GPLL0);
> +                            CFG_CLK_SRC_GPLL0, 8);
>
>         /* Vote for gpll0 clock */
>         clk_enable_gpll0(priv->base, &gpll0_vote_clk);
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index 1efb6e2313a5..48cac08eed67 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -48,7 +48,7 @@ static int clk_init_sdc(struct qcom_cc_priv *priv, uint rate)
>
>         clk_enable_cbc(priv->base + SDCC2_AHB_CBCR);
>         clk_rcg_set_rate_mnd(priv->base, &sdc_regs, div, 0, 0,
> -                            CFG_CLK_SRC_GPLL0);
> +                            CFG_CLK_SRC_GPLL0, 8);
>         clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>         clk_enable_cbc(priv->base + SDCC2_APPS_CBCR);
>
> @@ -70,7 +70,7 @@ static int clk_init_uart(struct qcom_cc_priv *priv)
>
>         /* 7372800 uart block clock @ GPLL0 */
>         clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 1, 192, 15625,
> -                            CFG_CLK_SRC_GPLL0);
> +                            CFG_CLK_SRC_GPLL0, 8);
>
>         /* Vote for gpll0 clock */
>         clk_enable_gpll0(priv->base, &gpll0_vote_clk);
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index a9602d0c9ca6..7a6157bf123f 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -83,7 +83,7 @@ void clk_bcr_update(phys_addr_t apps_cmd_rcgr)
>
>  /* root set rate for clocks with half integer and MND divider */
>  void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
> -                         int div, int m, int n, int source)
> +                         int div, int m, int n, int source, u8 mnd_width)
>  {
>         u32 cfg;
>         /* M value for MND divider. */
> @@ -92,11 +92,14 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>         u32 n_val = ~((n) - (m)) * !!(n);
>         /* NOT 2D value for MND divider. */
>         u32 d_val = ~(n);
> +       u32 mask = BIT(mnd_width) - 1;
> +
> +       debug("m %#x n %#x d %#x div %#x mask %#x\n", m_val, n_val, d_val, div, mask);
>
>         /* Program MND values */
> -       writel(m_val, base + regs->M);
> -       writel(n_val, base + regs->N);
> -       writel(d_val, base + regs->D);
> +       setbits_le32(base + regs->M, m_val & mask);
> +       setbits_le32(base + regs->N, n_val & mask);
> +       setbits_le32(base + regs->D, d_val & mask);
>
>         /* setup src select and divider */
>         cfg  = readl(base + regs->cfg_rcgr);
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index 4c5959b60038..6fa88fb40af8 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -70,7 +70,7 @@ void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
>  void clk_enable_cbc(phys_addr_t cbcr);
>  void clk_enable_vote_clk(phys_addr_t base, const struct vote_clk *vclk);
>  void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
> -                         int div, int m, int n, int source);
> +                         int div, int m, int n, int source, u8 mnd_width);
>  void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>                       int source);
>
> diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> index ce83ec741278..d10992ee58bf 100644
> --- a/drivers/clk/qcom/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -113,7 +113,7 @@ static const struct bcr_regs blsp1_qup4_i2c_apps_regs = {
>         /* mnd_width = 0 */
>  };
>
> -ulong msm_set_rate(struct clk *clk, ulong rate)
> +static ulong qcs404_set_rate(struct clk *clk, ulong rate)
>  {
>         struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
>
> @@ -121,7 +121,7 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
>         case GCC_BLSP1_UART2_APPS_CLK:
>                 /* UART: 115200 */
>                 clk_rcg_set_rate_mnd(priv->base, &uart2_regs, 0, 12, 125,
> -                                    CFG_CLK_SRC_CXO);
> +                                    CFG_CLK_SRC_CXO, 8);
>                 clk_enable_cbc(priv->base + BLSP1_UART2_APPS_CBCR);
>                 break;
>         case GCC_BLSP1_AHB_CLK:
> @@ -130,7 +130,7 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
>         case GCC_SDCC1_APPS_CLK:
>                 /* SDCC1: 200MHz */
>                 clk_rcg_set_rate_mnd(priv->base, &sdc_regs, 4, 0, 0,
> -                                    CFG_CLK_SRC_GPLL0);
> +                                    CFG_CLK_SRC_GPLL0, 8);
>                 clk_enable_gpll0(priv->base, &gpll0_vote_clk);
>                 clk_enable_cbc(priv->base + SDCC_APPS_CBCR(1));
>                 break;
> @@ -140,16 +140,16 @@ ulong msm_set_rate(struct clk *clk, ulong rate)
>         case GCC_ETH_RGMII_CLK:
>                 if (rate == 250000000)
>                         clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 0, 0,
> -                                            CFG_CLK_SRC_GPLL1);
> +                                            CFG_CLK_SRC_GPLL1, 8);
>                 else if (rate == 125000000)
>                         clk_rcg_set_rate_mnd(priv->base, &emac_regs, 4, 0, 0,
> -                                            CFG_CLK_SRC_GPLL1);
> +                                            CFG_CLK_SRC_GPLL1, 8);
>                 else if (rate == 50000000)
>                         clk_rcg_set_rate_mnd(priv->base, &emac_regs, 10, 0, 0,
> -                                            CFG_CLK_SRC_GPLL1);
> +                                            CFG_CLK_SRC_GPLL1, 8);
>                 else if (rate == 5000000)
>                         clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 1, 50,
> -                                            CFG_CLK_SRC_GPLL1);
> +                                            CFG_CLK_SRC_GPLL1, 8);
>                 break;
>         default:
>                 return 0;
> @@ -166,7 +166,7 @@ static int qcs404_enable(struct clk *clk)
>         case GCC_USB30_MASTER_CLK:
>                 clk_enable_cbc(priv->base + USB30_MASTER_CBCR);
>                 clk_rcg_set_rate_mnd(priv->base, &usb30_master_regs, 4, 0, 0,
> -                                    CFG_CLK_SRC_GPLL0);
> +                                    CFG_CLK_SRC_GPLL0, 8);
>                 break;
>         case GCC_SYS_NOC_USB3_CLK:
>                 clk_enable_cbc(priv->base + SYS_NOC_USB3_CBCR);
> @@ -188,14 +188,14 @@ static int qcs404_enable(struct clk *clk)
>                 clk_enable_cbc(priv->base + ETH_PTP_CBCR);
>                 clk_enable_gpll0(priv->base, &gpll1_vote_clk);
>                 clk_rcg_set_rate_mnd(priv->base, &emac_ptp_regs, 2, 0, 0,
> -                                    CFG_CLK_SRC_GPLL1);
> +                                    CFG_CLK_SRC_GPLL1, 8);
>                 break;
>         case GCC_ETH_RGMII_CLK:
>                 /* SPEED_1000: freq -> 250MHz */
>                 clk_enable_cbc(priv->base + ETH_RGMII_CBCR);
>                 clk_enable_gpll0(priv->base, &gpll1_vote_clk);
>                 clk_rcg_set_rate_mnd(priv->base, &emac_regs, 2, 0, 0,
> -                                    CFG_CLK_SRC_GPLL1);
> +                                    CFG_CLK_SRC_GPLL1, 8);
>                 break;
>         case GCC_ETH_SLAVE_AHB_CLK:
>                 clk_enable_cbc(priv->base + ETH_SLAVE_AHB_CBCR);
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index 7b614f9661f0..9345d5293f1e 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -82,8 +82,7 @@ static ulong sdm845_set_rate(struct clk *clk, ulong rate)
>         case GCC_QUPV3_WRAP1_S1_CLK: /* UART9 */
>                 freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
>                 clk_rcg_set_rate_mnd(priv->base, &uart2_regs,
> -                                    freq->pre_div, freq->m, freq->n, freq->src);
> -
> +                                    freq->pre_div, freq->m, freq->n, freq->src, 16);
>                 return freq->freq;
>         default:
>                 return 0;
>
> --
> 2.42.0
>
