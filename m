Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D63FC25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 10:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 690BA876FA;
	Fri, 27 Oct 2023 12:41:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vuts1EFV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC53B876FA; Fri, 27 Oct 2023 12:41:44 +0200 (CEST)
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com
 [IPv6:2607:f8b0:4864:20::e2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E60908762A
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 12:41:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2f.google.com with SMTP id
 ada2fe7eead31-457c2b6713fso1966049137.1
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 03:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698403300; x=1699008100; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=53l2sQvKKLs7uG6qFHwdNkfnY3mPnQtWse1gKKgvymk=;
 b=Vuts1EFVKypKRa8LdEmOpGAJgrNIdhIr5NOVyd5HbdUfZvhvpdMa3xHRP+hNacrLTo
 B9QFFZGUhx+Akj7AeOmc3DL/nG9JeEAUNrl5lBkciaU3+1z94FW+2JWy7aQxpAZVIxCN
 NFSnk25lQEWm9Ny1DogqJ+JG49rLVHbe5w51l9JuPS8WroyRlz6FNd3xjqg9RU3ih7GI
 X1KtXNaJtcXl9bvqBVMoa/dtDOWn3Tu87iqWhZPQJQ+iJ9jzvifZLKisNExEDGjEUkiT
 plsihwC1hO1Pza0KXxfiAOfJOJYVYc/m4r8CKs2XdqdYTpHrN9fFZkbaBuDYmaO6vOlA
 0xIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698403300; x=1699008100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=53l2sQvKKLs7uG6qFHwdNkfnY3mPnQtWse1gKKgvymk=;
 b=Bx66rZ0Al1foGlb3gYg6Eqcoc2JAx8aVsOi6vpjzaCw0senzaf6AAVospz2MT/JHWi
 vUnmfFps0lRCUwSs5g6JsVuNz/F6ektQ21y6xgY5xs087x+ift3oidAMCEUyIKs1XNXO
 WM/1SaGA/By5FVuZ1oG3AZeTRa8j7L7D9wvb0Zu2BBJwzgbzkiCbLDg8MgNckzhTnpys
 MpsbrIJNMmziNrt5mNpaYC93EbTkXesJPaL3Xo7Aa9V4TKeb3BdqkYI7lzghLQxrjNew
 6C4nKzHEBhZVasPv2x0N0fZ6HYuZxjHoGvk2mTGkQBREVPjbURgHTI+qKXdHfWxiHopi
 d1cA==
X-Gm-Message-State: AOJu0YzOWAJDl7oOPE9xsIshuh8aKZpRiWLSyS3cURmt3kK1bDBSGOvd
 4vr7At6IE0r1cSFWcN+CPEEGvj+sYHLIEFO49udyww==
X-Google-Smtp-Source: AGHT+IFs03ptmcp53q4EvFkUZ5Hpwm8CCc67N+IkGTbcOsdRTeaerBoahZwM0gX4GpAGLC1xNXmzaUsQTaS5ri9iVtQ=
X-Received: by 2002:a05:6102:5344:b0:452:6478:3e24 with SMTP id
 bq4-20020a056102534400b0045264783e24mr3458915vsb.12.1698403300442; Fri, 27
 Oct 2023 03:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v1-0-9d96359b9a82@linaro.org>
 <20231024-b4-qcom-clk-v1-5-9d96359b9a82@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v1-5-9d96359b9a82@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 27 Oct 2023 16:11:29 +0530
Message-ID: <CAFA6WYNWREZDSnbJDAWVws2CwrzWeMUszR6JRT4pZ4Q2kzUZuQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] clk/qcom: sdm845: add register map for simple gate
 clocks
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

On Wed, 25 Oct 2023 at 01:54, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Many gate clocks can be enabled with a single register write, add support
> for defining these simple gate clocks and add the ones found on SDM845.
>
> While we're here, inline clk_init_uart() into msm_set_rate().
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  .../mach-snapdragon/include/mach/sysmap-sdm845.h   |   3 +
>  drivers/clk/qcom/clock-qcom.h                      |  22 +++
>  drivers/clk/qcom/clock-sdm845.c                    | 163 +++++++++++++++++++--
>  3 files changed, 176 insertions(+), 12 deletions(-)
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
>  #endif
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index a77a94b6ea06..7b3bcf41f421 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -30,6 +30,18 @@ struct bcr_regs {
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
> @@ -38,6 +50,8 @@ struct qcom_reset_map {
>  struct qcom_cc_data {
>         const struct qcom_reset_map     *resets;
>         unsigned long                   num_resets;
> +       const struct gate_clk           *clks;
> +       unsigned long                   num_clks;
>  };
>
>  struct qcom_cc_priv {
> @@ -55,4 +69,12 @@ void clk_rcg_set_rate_mnd(phys_addr_t base, const struct bcr_regs *regs,
>  void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>                       int source);
>
> +static inline void qcom_gate_clk_en(const struct qcom_cc_priv *priv, unsigned long id)
> +{
> +       if (id >= priv->data->num_clks || priv->data->clks[id].reg == 0)
> +               return;
> +
> +       setbits_le32(priv->base + priv->data->clks[id].reg, priv->data->clks[id].en_val);
> +}
> +
>  #endif
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index eab88a40c09d..ccad73b6ff15 100644
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
> @@ -71,30 +72,166 @@ const struct freq_tbl *qcom_find_freq(const struct freq_tbl *f, uint rate)
>         return f - 1;
>  }
>
> -static int clk_init_uart(struct qcom_cc_priv *priv, uint rate)
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
>         struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
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
> +       GATE_CLK(GCC_AGGRE_NOC_PCIE_TBU_CLK,            0x90014, 0x00000001),
> +       GATE_CLK(GCC_AGGRE_UFS_CARD_AXI_CLK,            0x82028, 0x00000001),
> +       GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,             0x82024, 0x00000001),
> +       GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,           0x8201c, 0x00000001),
> +       GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK,            0x82020, 0x00000001),
> +       GATE_CLK(GCC_BOOT_ROM_AHB_CLK,                  0x52004, 0x00000400),
> +       GATE_CLK(GCC_CAMERA_AHB_CLK,                    0x0b008, 0x00000001),
> +       GATE_CLK(GCC_CAMERA_AXI_CLK,                    0x0b020, 0x00000001),
> +       GATE_CLK(GCC_CAMERA_XO_CLK,                     0x0b02c, 0x00000001),
> +       GATE_CLK(GCC_CE1_AHB_CLK,                       0x52004, 0x00000008),
> +       GATE_CLK(GCC_CE1_AXI_CLK,                       0x52004, 0x00000010),
> +       GATE_CLK(GCC_CE1_CLK,                           0x52004, 0x00000020),
> +       GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,         0x0502c, 0x00000001),
> +       GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK,          0x05030, 0x00000001),
> +       GATE_CLK(GCC_CPUSS_AHB_CLK,                     0x52004, 0x00200000),
> +       GATE_CLK(GCC_CPUSS_RBCPR_CLK,                   0x48008, 0x00000001),
> +       GATE_CLK(GCC_DDRSS_GPU_AXI_CLK,                 0x44038, 0x00000001),
> +       GATE_CLK(GCC_DISP_AHB_CLK,                      0x0b00c, 0x00000001),
> +       GATE_CLK(GCC_DISP_AXI_CLK,                      0x0b024, 0x00000001),
> +       GATE_CLK(GCC_DISP_GPLL0_CLK_SRC,                0x52004, 0x00040000),
> +       GATE_CLK(GCC_DISP_GPLL0_DIV_CLK_SRC,            0x52004, 0x00080000),
> +       GATE_CLK(GCC_DISP_XO_CLK,                       0x0b030, 0x00000001),
> +       GATE_CLK(GCC_GP1_CLK,                           0x64000, 0x00000001),
> +       GATE_CLK(GCC_GP2_CLK,                           0x65000, 0x00000001),
> +       GATE_CLK(GCC_GP3_CLK,                           0x66000, 0x00000001),
> +       GATE_CLK(GCC_GPU_CFG_AHB_CLK,                   0x71004, 0x00000001),
> +       GATE_CLK(GCC_GPU_GPLL0_CLK_SRC,                 0x52004, 0x00008000),
> +       GATE_CLK(GCC_GPU_GPLL0_DIV_CLK_SRC,             0x52004, 0x00010000),
> +       GATE_CLK(GCC_GPU_MEMNOC_GFX_CLK,                0x7100c, 0x00000001),
> +       GATE_CLK(GCC_GPU_SNOC_DVM_GFX_CLK,              0x71018, 0x00000001),
> +       GATE_CLK(GCC_MSS_AXIS2_CLK,                     0x8a008, 0x00000001),
> +       GATE_CLK(GCC_MSS_CFG_AHB_CLK,                   0x8a000, 0x00000001),
> +       GATE_CLK(GCC_MSS_GPLL0_DIV_CLK_SRC,             0x52004, 0x00020000),
> +       GATE_CLK(GCC_MSS_MFAB_AXIS_CLK,                 0x8a004, 0x00000001),
> +       GATE_CLK(GCC_MSS_Q6_MEMNOC_AXI_CLK,             0x8a154, 0x00000001),
> +       GATE_CLK(GCC_MSS_SNOC_AXI_CLK,                  0x8a150, 0x00000001),
> +       GATE_CLK(GCC_PCIE_0_AUX_CLK,                    0x5200c, 0x00000008),
> +       GATE_CLK(GCC_PCIE_0_CFG_AHB_CLK,                0x5200c, 0x00000004),
> +       GATE_CLK(GCC_PCIE_0_CLKREF_CLK,                 0x8c00c, 0x00000001),
> +       GATE_CLK(GCC_PCIE_0_MSTR_AXI_CLK,               0x5200c, 0x00000002),
> +       GATE_CLK(GCC_PCIE_0_PIPE_CLK,                   0x5200c, 0x00000010),
> +       GATE_CLK(GCC_PCIE_0_SLV_AXI_CLK,                0x5200c, 0x00000001),
> +       GATE_CLK(GCC_PCIE_0_SLV_Q2A_AXI_CLK,            0x5200c, 0x00000020),
> +       GATE_CLK(GCC_PCIE_1_AUX_CLK,                    0x52004, 0x20000000),
> +       GATE_CLK(GCC_PCIE_1_CFG_AHB_CLK,                0x52004, 0x10000000),
> +       GATE_CLK(GCC_PCIE_1_CLKREF_CLK,                 0x8c02c, 0x00000001),
> +       GATE_CLK(GCC_PCIE_1_MSTR_AXI_CLK,               0x52004, 0x08000000),
> +       GATE_CLK(GCC_PCIE_1_PIPE_CLK,                   0x52004, 0x40000000),
> +       GATE_CLK(GCC_PCIE_1_SLV_AXI_CLK,                0x52004, 0x04000000),
> +       GATE_CLK(GCC_PCIE_1_SLV_Q2A_AXI_CLK,            0x52004, 0x02000000),
> +       GATE_CLK(GCC_PCIE_PHY_AUX_CLK,                  0x6f004, 0x00000001),
> +       GATE_CLK(GCC_PCIE_PHY_REFGEN_CLK,               0x6f02c, 0x00000001),
> +       GATE_CLK(GCC_PDM2_CLK,                          0x3300c, 0x00000001),
> +       GATE_CLK(GCC_PDM_AHB_CLK,                       0x33004, 0x00000001),
> +       GATE_CLK(GCC_PDM_XO4_CLK,                       0x33008, 0x00000001),
> +       GATE_CLK(GCC_PRNG_AHB_CLK,                      0x52004, 0x00002000),
> +       GATE_CLK(GCC_QMIP_CAMERA_AHB_CLK,               0x0b014, 0x00000001),
> +       GATE_CLK(GCC_QMIP_DISP_AHB_CLK,                 0x0b018, 0x00000001),
> +       GATE_CLK(GCC_QMIP_VIDEO_AHB_CLK,                0x0b010, 0x00000001),
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
> +       GATE_CLK(GCC_SYS_NOC_CPUSS_AHB_CLK,             0x52004, 0x00000001),
> +       GATE_CLK(GCC_TSIF_AHB_CLK,                      0x36004, 0x00000001),
> +       GATE_CLK(GCC_TSIF_INACTIVITY_TIMERS_CLK,        0x3600c, 0x00000001),
> +       GATE_CLK(GCC_TSIF_REF_CLK,                      0x36008, 0x00000001),
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
> +       GATE_CLK(GCC_VIDEO_AHB_CLK,                     0x0b004, 0x00000001),
> +       GATE_CLK(GCC_VIDEO_AXI_CLK,                     0x0b01c, 0x00000001),
> +       GATE_CLK(GCC_VIDEO_XO_CLK,                      0x0b028, 0x00000001),
> +       GATE_CLK(GCC_GPU_IREF_CLK,                      0x8c010, 0x00000001),
> +       GATE_CLK(GCC_APC_VS_CLK,                        0x7a050, 0x00000001),
> +       GATE_CLK(GCC_GPU_VS_CLK,                        0x7a04c, 0x00000001),
> +       GATE_CLK(GCC_MSS_VS_CLK,                        0x7a048, 0x00000001),
> +       GATE_CLK(GCC_VDDA_VS_CLK,                       0x7a00c, 0x00000001),
> +       GATE_CLK(GCC_VDDCX_VS_CLK,                      0x7a004, 0x00000001),
> +       GATE_CLK(GCC_VDDMX_VS_CLK,                      0x7a008, 0x00000001),
> +       GATE_CLK(GCC_VS_CTRL_AHB_CLK,                   0x7a014, 0x00000001),
> +       GATE_CLK(GCC_VS_CTRL_CLK,                       0x7a010, 0x00000001),
> +       GATE_CLK(GCC_CPUSS_DVM_BUS_CLK,                 0x48190, 0x00000001),
> +};

Do we really need all these gate clocks in u-boot? IMO, we should add
the ones that would be actually used.

-Sumit

> +
>  int msm_enable(struct clk *clk)
>  {
> +       struct qcom_cc_priv *priv = dev_get_priv(clk->dev);
> +
> +       debug("%s: clk %s\n", __func__, sdm845_clks[clk->id].name);
> +
> +       qcom_gate_clk_en(priv, clk->id);
> +
>         return 0;
>  }
>
> @@ -130,6 +267,8 @@ static const struct qcom_reset_map sdm845_gcc_resets[] = {
>  static const struct qcom_cc_data qcs404_gcc_data = {
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
