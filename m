Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC10AC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 08:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1F4863F7;
	Thu,  2 Nov 2023 09:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uhFIimoJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1995C863D3; Thu,  2 Nov 2023 09:12:13 +0100 (CET)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com
 [IPv6:2607:f8b0:4864:20::a35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3496E863F7
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 09:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-49d55b90a5aso448715e0c.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 01:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698912723; x=1699517523; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7x3knvj2jI8dYdnYxHYFRMNKVrQZ6/bhkz8jDBn/VTE=;
 b=uhFIimoJp42qvaS6vEWkq7+DZ1M1Ti5iatcxCj3AlsXZgGiUiBkpJ5SxkQBkjbVucP
 VTmgjW9caxhQdc4jcPqpLEOi09lioggKZ9WtzMGtHywSN+ILQ00Hd7oE1neM6ADf+9Jr
 XIDIMJRz+MMHpJA6J5Js4fjIfqTXw49Dbo48o1nbNOqPhig3VE5SpLhKOuYCpmh16ulv
 z3OjMbQQWC4XAwO1Sda8zi2AFlf7pbcrQlLAvkgr1FmZxw7si3s2QGFk174Cvx90ruIa
 CULggPqS2nVuhK+o2vgnXfSCFBzL573vYdg8PLtRo7XWDopHxYPfrPOX/Iuse6Xs9xF/
 zz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698912723; x=1699517523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7x3knvj2jI8dYdnYxHYFRMNKVrQZ6/bhkz8jDBn/VTE=;
 b=jkTUfugEwYASB4HgIeqqvhTwFKsJ5kJY4ahj1eZjliZ7eCTUJLC72eklb7wmnckaHI
 Arp1NgjJBMrcZesK0y1JXdPF3W2mKZm0ManUOjgBXqfw6znbCVf/csX7U6OjTgJQEBnl
 hyCH8HEvLVgojC3a0iitRTuXh2NxKwzLeYKupbYv7vZf9adCbQIQsXT6XA2ZFNBYqiUX
 oOKKwTeigBg1nI5q4GHCvM5NoKMrJ+u6SwgFTCw6eVkVODZBDBaeTDp3FbyLLbhVAJTJ
 c8nbogVQg3yMubieFcSOsBxAFQfVnesCsO00Dc7bvGL3rrF9ROjvPG9C1mNN3dTaYqh9
 3n9A==
X-Gm-Message-State: AOJu0YyuMLD3gtWDcJDYyZNmRXgWpGAcNYSmDshLXt07SN09d+4tpC7Z
 senDWzcHORghsfpHFFkJLfwoccUW2inCJ4x/JFg6Qw==
X-Google-Smtp-Source: AGHT+IGPyy3vPu68omTc1qVEGaF+rOg32FHxxMZPrx5KCS+DgrvaE5s+qnb/1gqG8PkaHsM/rx5dpZJsBLBvFZULGf4=
X-Received: by 2002:a1f:a7d7:0:b0:496:80b6:2fd1 with SMTP id
 q206-20020a1fa7d7000000b0049680b62fd1mr2708939vke.5.1698912723603; Thu, 02
 Nov 2023 01:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
 <20231024-b4-qcom-clk-v2-4-6572bc2be690@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v2-4-6572bc2be690@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 2 Nov 2023 13:41:52 +0530
Message-ID: <CAFA6WYN0x6MNRY-HDVf-WyaRa7a4=XmTvBT2x8VXd3euo6g61w@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] clk/qcom: sdm845: add register map for simple gate
 clocks
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
> Many gate clocks can be enabled with a single register write, add support
> for defining these simple gate clocks and add the ones found on SDM845.
>
> While we're here, inline clk_init_uart() into msm_set_rate().
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  .../mach-snapdragon/include/mach/sysmap-sdm845.h   |  3 +
>  drivers/clk/qcom/clock-qcom.h                      | 26 +++++++
>  drivers/clk/qcom/clock-sdm845.c                    | 87 +++++++++++++++++++---
>  3 files changed, 104 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/mach-snapdragon/include/mach/sysmap-sdm845.h b/arch/arm/mach-snapdragon/include/mach/sysmap-sdm845.h
> index 7165985bcd1e..a0010d71594e 100644
> --- a/arch/arm/mach-snapdragon/include/mach/sysmap-sdm845.h
> +++ b/arch/arm/mach-snapdragon/include/mach/sysmap-sdm845.h
> @@ -39,4 +39,7 @@
>  #define SE9_UART_APPS_N                (0x18154)
>  #define SE9_UART_APPS_D                (0x18158)
>
> +#define USB30_SEC_GDSCR                (0x10004)
> +#define USB30_PRIM_GDSCR       (0xf004)
> +

I don't see these used anywhere in this commit. Apart from that feel
free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>  #endif
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index a9f895c2422e..6d399db987b6 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -5,6 +5,8 @@
>  #ifndef _CLOCK_QCOM_H
>  #define _CLOCK_QCOM_H
>
> +#include <asm/io.h>
> +
>  #define CFG_CLK_SRC_CXO   (0 << 8)
>  #define CFG_CLK_SRC_GPLL0 (1 << 8)
>  #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
> @@ -30,6 +32,18 @@ struct bcr_regs {
>         uintptr_t D;
>  };
>
> +struct gate_clk {
> +       uintptr_t reg;
> +       u32 en_val;
> +       const char *name;
> +};
> +
> +#ifdef DEBUG
> +#define GATE_CLK(clk, reg, val) [clk] = { reg, val, #clk }
> +#else
> +#define GATE_CLK(clk, reg, val) [clk] = { reg, val, NULL }
> +#endif
> +
>  struct qcom_reset_map {
>         unsigned int reg;
>         u8 bit;
> @@ -38,6 +52,8 @@ struct qcom_reset_map {
>  struct msm_clk_data {
>         const struct qcom_reset_map     *resets;
>         unsigned long                   num_resets;
> +       const struct gate_clk           *clks;
> +       unsigned long                   num_clks;
>  };
>
>  struct msm_clk_priv {
> @@ -55,4 +71,14 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>  void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>                       int source);
>
> +static inline void qcom_gate_clk_en(const struct msm_clk_priv *priv, unsigned long id)
> +{
> +       u32 val;
> +       if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0)
> +               return;
> +
> +       val = readl(priv->base + priv->data->clks[id].reg);
> +       writel(val | priv->data->clks[id].en_val, priv->base + priv->data->clks[id].reg);
> +}
> +
>  #endif
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index a7a43f69b9b3..57124e2a661a 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -11,6 +11,7 @@
>  #include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
> +#include <linux/delay.h>
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> @@ -71,30 +72,90 @@ const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
>         return f - 1;
>  }
>
> -static int clk_init_uart(struct msm_clk_priv *priv, uint rate)
> -{
> -       const struct freq_tbl *freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
> -
> -       clk_rcg_set_rate_mnd(priv->base, &uart2_regs,
> -                                               freq->pre_div, freq->m, freq->n, freq->src);
> -
> -       return 0;
> -}
> -
>  ulong msm_set_rate(struct clk *clk, ulong rate)
>  {
>         struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +       const struct freq_tbl *freq;
>
>         switch (clk->id) {
> -       case GCC_QUPV3_WRAP1_S1_CLK: /*UART2*/
> -               return clk_init_uart(priv, rate);
> +       case GCC_QUPV3_WRAP1_S1_CLK: /* UART9 */
> +               freq = qcom_find_freq(ftbl_gcc_qupv3_wrap0_s0_clk_src, rate);
> +               clk_rcg_set_rate_mnd(priv->base, &uart2_regs,
> +                                    freq->pre_div, freq->m, freq->n, freq->src);
> +
> +               return freq->freq;
>         default:
>                 return 0;
>         }
>  }
>
> +static const struct gate_clk sdm845_clks[] = {
> +       GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK,                0x5200c, 0x00000400),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK,                0x5200c, 0x00000800),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK,                0x5200c, 0x00001000),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK,                0x5200c, 0x00002000),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK,                0x5200c, 0x00004000),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK,                0x5200c, 0x00008000),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S6_CLK,                0x5200c, 0x00010000),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK,                0x5200c, 0x00020000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK,                0x5200c, 0x00400000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK,                0x5200c, 0x00800000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK,                0x5200c, 0x02000000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK,                0x5200c, 0x04000000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK,                0x5200c, 0x08000000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S6_CLK,                0x5200c, 0x10000000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S7_CLK,                0x5200c, 0x20000000),
> +       GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK,            0x5200c, 0x00000040),
> +       GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK,            0x5200c, 0x00000080),
> +       GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK,            0x5200c, 0x00100000),
> +       GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK,            0x5200c, 0x00200000),
> +       GATE_CLK(GCC_SDCC2_AHB_CLK,                     0x14008, 0x00000001),
> +       GATE_CLK(GCC_SDCC2_APPS_CLK,                    0x14004, 0x00000001),
> +       GATE_CLK(GCC_SDCC4_AHB_CLK,                     0x16008, 0x00000001),
> +       GATE_CLK(GCC_SDCC4_APPS_CLK,                    0x16004, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_AHB_CLK,                  0x75010, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_AXI_CLK,                  0x7500c, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_CLKREF_CLK,               0x8c004, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_ICE_CORE_CLK,             0x75058, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_PHY_AUX_CLK,              0x7508c, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_0_CLK,          0x75018, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_1_CLK,          0x750a8, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_TX_SYMBOL_0_CLK,          0x75014, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_UNIPRO_CORE_CLK,          0x75054, 0x00000001),
> +       GATE_CLK(GCC_UFS_MEM_CLKREF_CLK,                0x8c000, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_AHB_CLK,                   0x77010, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_AXI_CLK,                   0x7700c, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,              0x77058, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,               0x7708c, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,           0x77018, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK,           0x770a8, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,           0x77014, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,           0x77054, 0x00000001),
> +       GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,             0x0f00c, 0x00000001),
> +       GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,          0x0f014, 0x00000001),
> +       GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,              0x0f010, 0x00000001),
> +       GATE_CLK(GCC_USB30_SEC_MASTER_CLK,              0x1000c, 0x00000001),
> +       GATE_CLK(GCC_USB30_SEC_MOCK_UTMI_CLK,           0x10014, 0x00000001),
> +       GATE_CLK(GCC_USB30_SEC_SLEEP_CLK,               0x10010, 0x00000001),
> +       GATE_CLK(GCC_USB3_PRIM_CLKREF_CLK,              0x8c008, 0x00000001),
> +       GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,             0x0f04c, 0x00000001),
> +       GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,         0x0f050, 0x00000001),
> +       GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,            0x0f054, 0x00000001),
> +       GATE_CLK(GCC_USB3_SEC_CLKREF_CLK,               0x8c028, 0x00000001),
> +       GATE_CLK(GCC_USB3_SEC_PHY_AUX_CLK,              0x1004c, 0x00000001),
> +       GATE_CLK(GCC_USB3_SEC_PHY_PIPE_CLK,             0x10054, 0x00000001),
> +       GATE_CLK(GCC_USB3_SEC_PHY_COM_AUX_CLK,          0x10050, 0x00000001),
> +       GATE_CLK(GCC_USB_PHY_CFG_AHB2PHY_CLK,           0x6a004, 0x00000001),
> +};
> +
>  int msm_enable(struct clk *clk)
>  {
> +       struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +       debug("%s: clk %s\n", __func__, sdm845_clks[clk->id].name);
> +
> +       qcom_gate_clk_en(priv, clk->id);
> +
>         return 0;
>  }
>
> @@ -121,6 +182,8 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
>  static const struct msm_clk_data qcs404_gcc_data = {
>         .resets = sdm845_gcc_resets,
>         .num_resets = ARRAY_SIZE(sdm845_gcc_resets),
> +       .clks = sdm845_clks,
> +       .num_clks = ARRAY_SIZE(sdm845_clks),
>  };
>
>  static const struct udevice_id gcc_sdm845_of_match[] = {
>
> --
> 2.42.0
>
