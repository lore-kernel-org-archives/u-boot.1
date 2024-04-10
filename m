Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5716CD128A
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 11:15:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D22088199;
	Wed, 10 Apr 2024 13:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HaNPPpCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42D688815A; Wed, 10 Apr 2024 13:15:40 +0200 (CEST)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B76E881A6
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 13:15:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-479d6c6f2c0so3037255137.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 04:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712747736; x=1713352536; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IqwnEH5vxVqI9ui7SjEkI15p5t0l4u+NdCPTuKTN81Y=;
 b=HaNPPpCDnszFQrIgTMYUThFgitpdt6L84Ak3BjjsEXtUfVbz3jT1VVk3R0X+sSHdG3
 yhuqyUl2aPMK+JUCNXQB4NxoAlk9SBrQhrc+y6pA9J6puZ4WTUiLZNbBWPBxgwS1n2t/
 3pu5+Ra0uprdnbKOjMkHN17pwebtqUZAAU/WZ4As0O/g2ktg2+Y6iHLFae9Wa9eYXO+Y
 6cY3YeEs6IYPzz7KflpVuARseGCi+WXKWxQccvDTfA0WGbRUdqfBlsAYVUJe4g/pXt7d
 TcvPgyJSlXVTyhOzc68rkFl2IXamMi10Q5Bujfp7tSx8eLbyBoUWqVYyNyBQtzD0TNxy
 CVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712747736; x=1713352536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IqwnEH5vxVqI9ui7SjEkI15p5t0l4u+NdCPTuKTN81Y=;
 b=da661PxSRUdp+3xroVE6YpwNIjfmu45lDApcKdy3BAc8Pt7gw8+pCSnyuDn3bRy0sr
 zSQxQUKFJMoTBA+KpyDoPJulklHphkI/iojLW9CypA1XC8GuwZEDQB1T1IAsKpJuQJkr
 dRd8L4zr4PArVkrmotcTCP2vdtkOCFE3BQjFbKgoZvsgHGAs1cW4fkpvwdUtyZw597VA
 tzUbEonBDjZkI6Io9sXJQcYN9TeapGA80+dKaLTbwIGyifxDDNF6BBGz+Tm9DaL+xoVf
 5VX5bs/KJ/8LbUtR7pcXm5BVb+GooXycKDV6tPdiS4NtTMe71q87ERlQqhZ/jkmYsWhP
 jHVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy7MtShM0csXyp3XuWNeru3vC/AP0J06sG6OeGl5B2Q3yavDf7FdZ1FrmB2zLN/jZmHYDtkXyb8P9Pfuy+7N/AzC0/wA==
X-Gm-Message-State: AOJu0YxFMz34D0+vIDH7ulQwE8nfspaX6ayeiGZjcRlKsyqLvJZZP7no
 R6ZQnFEyrP0gg2yaaWOyRnCC66YcCjEn/THFvmzr2kkS3zypu8KeVEQ+ZCHQ9QJXi+mf/paXQLK
 Npozv9K3ebIqxfLY/U1CD8PYS6F8w6kZuPCbwLw==
X-Google-Smtp-Source: AGHT+IH6pFuKHLlEBLS9eNPUwLpqUgZ7GX3fg1EQvshnkvi2J0G+h0a0sJTZieSyKangjshZYp+NHOFVc72SJKbI1yg=
X-Received: by 2002:a05:6102:1594:b0:47a:22cb:cf27 with SMTP id
 g20-20020a056102159400b0047a22cbcf27mr1296453vsv.3.1712747735953; Wed, 10 Apr
 2024 04:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240408-b4-qcom-rbx-soc-v1-0-2db1d3658660@linaro.org>
 <20240408-b4-qcom-rbx-soc-v1-3-2db1d3658660@linaro.org>
In-Reply-To: <20240408-b4-qcom-rbx-soc-v1-3-2db1d3658660@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 10 Apr 2024 16:45:25 +0530
Message-ID: <CAFA6WYPVefrREX6oU174E+o_eji73GcB8BGgXLJN3y=1sSTZnA@mail.gmail.com>
Subject: Re: [PATCH 3/4] clk/qcom: add driver for sm8250 GCC
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, u-boot@lists.denx.de
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

Hi Caleb,

On Mon, 8 Apr 2024 at 18:37, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Add a clock driver for the SM8250 SoC. This driver can enable necessary
> clocks for UART, UFS, USB, and MMC.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig        |   8 ++
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/clock-qcom.h   |   1 +
>  drivers/clk/qcom/clock-sm8250.c | 282 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 292 insertions(+)
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 6afa62e19879..d4bd8c7e6ba6 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -62,7 +62,15 @@ config CLK_QCOM_SM6115
>           Say Y here to enable support for the Global Clock Controller
>           on the Snapdragon SM6115 SoC. This driver supports the clocks
>           and resets exposed by the GCC hardware block.
>
> +config CLK_QCOM_SM8250
> +       bool "Qualcomm SM8250 GCC"
> +       select CLK_QCOM
> +       help
> +         Say Y here to enable support for the Global Clock Controller
> +         on the Snapdragon SM8250 SoC. This driver supports the clocks
> +         and resets exposed by the GCC hardware block.
> +
>  endmenu
>
>  endif
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index d38c5a9fb849..f7fc8b9a70f5 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -9,4 +9,5 @@ obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
>  obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
>  obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>  obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
>  obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
> +obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index ec524157df2b..cc170d8e3f9e 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -9,8 +9,9 @@
>
>  #define CFG_CLK_SRC_CXO   (0 << 8)
>  #define CFG_CLK_SRC_GPLL0 (1 << 8)
>  #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
> +#define CFG_CLK_SRC_GPLL9 (2 << 8)
>  #define CFG_CLK_SRC_GPLL6 (4 << 8)
>  #define CFG_CLK_SRC_GPLL7 (3 << 8)
>  #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
>  #define CFG_CLK_SRC_MASK  (7 << 8)
> diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm8250.c
> new file mode 100644
> index 000000000000..af10fc116219
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-sm8250.c
> @@ -0,0 +1,282 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Clock drivers for Qualcomm sm8250
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + */
> +
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,gcc-sm8250.h>
> +
> +#include "clock-qcom.h"
> +
> +#define GCC_SE12_UART_RCG_REG 0x184D0
> +#define GCC_SDCC2_APPS_CLK_SRC_REG 0x1400c
> +
> +#define APCS_GPLL0_ENA_VOTE 0x79000
> +#define APCS_GPLL9_STATUS 0x1c000
> +#define APCS_GPLLX_ENA_REG 0x52018
> +
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
> +#define USB3_PRIM_PHY_AUX_CMD_RCGR 0xf064
> +
> +static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s4_clk_src[] = {
> +       F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
> +       F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
> +       F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +       F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
> +       F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
> +       F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
> +       F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
> +       F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
> +       F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
> +       F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
> +       F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
> +       F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
> +       {}
> +};
> +
> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
> +       F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +       F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +       F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
> +       F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
> +       F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
> +       F(202000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
> +       {}
> +};
> +
> +static struct pll_vote_clk gpll9_vote_clk = {
> +       .status = APCS_GPLL9_STATUS,
> +       .status_bit = BIT(31),
> +       .ena_vote = APCS_GPLLX_ENA_REG,
> +       .vote_bit = BIT(9),
> +};
> +
> +static ulong sm8250_set_rate(struct clk *clk, ulong rate)
> +{
> +       struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +       const struct freq_tbl *freq;
> +
> +       if (clk->id < priv->data->num_clks)
> +               debug("%s: %s, requested rate=%ld\n", __func__,
> +                     priv->data->clks[clk->id].name, rate);
> +
> +       switch (clk->id) {
> +       case GCC_QUPV3_WRAP1_S4_CLK: /*UART2*/
> +               freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s4_clk_src, rate);
> +               clk_rcg_set_rate_mnd(priv->base, GCC_SE12_UART_RCG_REG,
> +                                    freq->pre_div, freq->m, freq->n, freq->src,
> +                                    16);
> +
> +               return freq->freq;
> +       case GCC_SDCC2_APPS_CLK:
> +               /* Enable GPLL9 so that we can point SDCC2_APPS_CLK_SRC at it */
> +               clk_enable_gpll0(priv->base, &gpll9_vote_clk);
> +               freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
> +               printf("%s: got freq %u\n", __func__, freq->freq);
> +               WARN(freq->src != CFG_CLK_SRC_GPLL9,
> +                    "SDCC2_APPS_CLK_SRC not set to GPLL9, requested rate %lu\n",
> +                    rate);
> +               clk_rcg_set_rate_mnd(priv->base, GCC_SDCC2_APPS_CLK_SRC_REG,
> +                                    freq->pre_div, freq->m, freq->n,
> +                                    CFG_CLK_SRC_GPLL9, 8);
> +
> +               return rate;
> +       default:
> +               return 0;
> +       }
> +}
> +
> +static const struct gate_clk sm8250_clks[] = {
> +       GATE_CLK(GCC_AGGRE_UFS_CARD_AXI_CLK, 0x750cc, 0x00000001),
> +       GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK, 0x770cc, 0x00000001),
> +       GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0x0f080, 0x00000001),
> +       GATE_CLK(GCC_AGGRE_USB3_SEC_AXI_CLK, 0x10080, 0x00000001),
> +       GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0x0f07c, 0x00000001),
> +       GATE_CLK(GCC_CFG_NOC_USB3_SEC_AXI_CLK, 0x1007c, 0x00000001),
> +       GATE_CLK(GCC_QMIP_CAMERA_NRT_AHB_CLK, 0x0b018, 0x00000001),
> +       GATE_CLK(GCC_QMIP_CAMERA_RT_AHB_CLK, 0x0b01c, 0x00000001),
> +       GATE_CLK(GCC_QMIP_DISP_AHB_CLK, 0x0b020, 0x00000001),
> +       GATE_CLK(GCC_QMIP_VIDEO_CVP_AHB_CLK, 0x0b010, 0x00000001),
> +       GATE_CLK(GCC_QMIP_VIDEO_VCODEC_AHB_CLK, 0x0b014, 0x00000001),

This series has similar unused gates, resets etc. as in Neil's series.
Let me leave it upto you folks to decide if we really need untested
(without any relevant driver code) code paths to be added for Qcom
platforms.

-Sumit

> +       GATE_CLK(GCC_QUPV3_WRAP0_CORE_2X_CLK, 0x52008, 0x00000200),
> +       GATE_CLK(GCC_QUPV3_WRAP0_CORE_CLK, 0x52008, 0x00000100),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S0_CLK, 0x52008, 0x00000400),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S1_CLK, 0x52008, 0x00000800),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S2_CLK, 0x52008, 0x00001000),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S3_CLK, 0x52008, 0x00002000),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S4_CLK, 0x52008, 0x00004000),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S5_CLK, 0x52008, 0x00008000),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S6_CLK, 0x52008, 0x00010000),
> +       GATE_CLK(GCC_QUPV3_WRAP0_S7_CLK, 0x52008, 0x00020000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_CORE_2X_CLK, 0x52008, 0x00040000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_CORE_CLK, 0x52008, 0x00080000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK, 0x52008, 0x00400000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK, 0x52008, 0x00800000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK, 0x52008, 0x01000000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK, 0x52008, 0x02000000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK, 0x52008, 0x04000000),
> +       GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK, 0x52008, 0x08000000),
> +       GATE_CLK(GCC_QUPV3_WRAP2_CORE_2X_CLK, 0x52010, 0x00000008),
> +       GATE_CLK(GCC_QUPV3_WRAP2_CORE_CLK, 0x52010, 0x00000001),
> +       GATE_CLK(GCC_QUPV3_WRAP2_S0_CLK, 0x52010, 0x00000010),
> +       GATE_CLK(GCC_QUPV3_WRAP2_S1_CLK, 0x52010, 0x00000020),
> +       GATE_CLK(GCC_QUPV3_WRAP2_S2_CLK, 0x52010, 0x00000040),
> +       GATE_CLK(GCC_QUPV3_WRAP2_S3_CLK, 0x52010, 0x00000080),
> +       GATE_CLK(GCC_QUPV3_WRAP2_S4_CLK, 0x52010, 0x00000100),
> +       GATE_CLK(GCC_QUPV3_WRAP2_S5_CLK, 0x52010, 0x00000200),
> +       GATE_CLK(GCC_QUPV3_WRAP_0_M_AHB_CLK, 0x52008, 0x00000040),
> +       GATE_CLK(GCC_QUPV3_WRAP_0_S_AHB_CLK, 0x52008, 0x00000080),
> +       GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK, 0x52008, 0x00100000),
> +       GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK, 0x52008, 0x00200000),
> +       GATE_CLK(GCC_QUPV3_WRAP_2_M_AHB_CLK, 0x52010, 0x00000004),
> +       GATE_CLK(GCC_QUPV3_WRAP_2_S_AHB_CLK, 0x52010, 0x00000002),
> +       GATE_CLK(GCC_SDCC2_AHB_CLK, 0x14008, 0x00000001),
> +       GATE_CLK(GCC_SDCC2_APPS_CLK, 0x14004, 0x00000001),
> +       GATE_CLK(GCC_SDCC4_AHB_CLK, 0x16008, 0x00000001),
> +       GATE_CLK(GCC_SDCC4_APPS_CLK, 0x16004, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_AHB_CLK, 0x75018, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_AXI_CLK, 0x75010, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_ICE_CORE_CLK, 0x75064, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_PHY_AUX_CLK, 0x7509c, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_0_CLK, 0x75020, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_RX_SYMBOL_1_CLK, 0x750b8, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_TX_SYMBOL_0_CLK, 0x7501c, 0x00000001),
> +       GATE_CLK(GCC_UFS_CARD_UNIPRO_CORE_CLK, 0x7505c, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_AHB_CLK, 0x77018, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_AXI_CLK, 0x77010, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK, 0x77064, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK, 0x7709c, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK, 0x77020, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK, 0x770b8, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK, 0x7701c, 0x00000001),
> +       GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK, 0x7705c, 0x00000001),
> +       GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0x0f010, 0x00000001),
> +       GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0x0f01c, 0x00000001),
> +       GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0x0f018, 0x00000001),
> +       GATE_CLK(GCC_USB30_SEC_MASTER_CLK, 0x10010, 0x00000001),
> +       GATE_CLK(GCC_USB30_SEC_MOCK_UTMI_CLK, 0x1001c, 0x00000001),
> +       GATE_CLK(GCC_USB30_SEC_SLEEP_CLK, 0x10018, 0x00000001),
> +       GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0x0f054, 0x00000001),
> +       GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0x0f058, 0x00000001),
> +       GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK, 0x0f05c, 0x00000001),
> +       GATE_CLK(GCC_USB3_SEC_CLKREF_EN, 0x8c010, 0x00000001),
> +       GATE_CLK(GCC_USB3_SEC_PHY_AUX_CLK, 0x10054, 0x00000001),
> +       GATE_CLK(GCC_USB3_SEC_PHY_COM_AUX_CLK, 0x10058, 0x00000001),
> +       GATE_CLK(GCC_USB3_SEC_PHY_PIPE_CLK, 0x1005c, 0x00000001),
> +};
> +
> +static int sm8250_enable(struct clk *clk)
> +{
> +       struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +       if (priv->data->num_clks < clk->id) {
> +               debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +               return 0;
> +       }
> +
> +       debug("%s: clk %s\n", __func__, sm8250_clks[clk->id].name);
> +
> +       switch (clk->id) {
> +       case GCC_USB30_PRIM_MASTER_CLK:
> +               qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
> +               qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
> +               break;
> +       case GCC_USB30_SEC_MASTER_CLK:
> +               qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_AUX_CLK);
> +               qcom_gate_clk_en(priv, GCC_USB3_SEC_PHY_COM_AUX_CLK);
> +               break;
> +       }
> +
> +       qcom_gate_clk_en(priv, clk->id);
> +
> +       return 0;
> +}
> +
> +static const struct qcom_reset_map sm8250_gcc_resets[] = {
> +       [GCC_GPU_BCR] = { 0x71000 },
> +       [GCC_MMSS_BCR] = { 0xb000 },
> +       [GCC_NPU_BWMON_BCR] = { 0x73000 },
> +       [GCC_NPU_BCR] = { 0x4d000 },
> +       [GCC_PCIE_0_BCR] = { 0x6b000 },
> +       [GCC_PCIE_0_LINK_DOWN_BCR] = { 0x6c014 },
> +       [GCC_PCIE_0_NOCSR_COM_PHY_BCR] = { 0x6c020 },
> +       [GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
> +       [GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR] = { 0x6c028 },
> +       [GCC_PCIE_1_BCR] = { 0x8d000 },
> +       [GCC_PCIE_1_LINK_DOWN_BCR] = { 0x8e014 },
> +       [GCC_PCIE_1_NOCSR_COM_PHY_BCR] = { 0x8e020 },
> +       [GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
> +       [GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR] = { 0x8e000 },
> +       [GCC_PCIE_2_BCR] = { 0x6000 },
> +       [GCC_PCIE_2_LINK_DOWN_BCR] = { 0x1f014 },
> +       [GCC_PCIE_2_NOCSR_COM_PHY_BCR] = { 0x1f020 },
> +       [GCC_PCIE_2_PHY_BCR] = { 0x1f01c },
> +       [GCC_PCIE_2_PHY_NOCSR_COM_PHY_BCR] = { 0x1f028 },
> +       [GCC_PCIE_PHY_BCR] = { 0x6f000 },
> +       [GCC_PCIE_PHY_CFG_AHB_BCR] = { 0x6f00c },
> +       [GCC_PCIE_PHY_COM_BCR] = { 0x6f010 },
> +       [GCC_PDM_BCR] = { 0x33000 },
> +       [GCC_PRNG_BCR] = { 0x34000 },
> +       [GCC_QUPV3_WRAPPER_0_BCR] = { 0x17000 },
> +       [GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
> +       [GCC_QUPV3_WRAPPER_2_BCR] = { 0x1e000 },
> +       [GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
> +       [GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
> +       [GCC_SDCC2_BCR] = { 0x14000 },
> +       [GCC_SDCC4_BCR] = { 0x16000 },
> +       [GCC_TSIF_BCR] = { 0x36000 },
> +       [GCC_UFS_CARD_BCR] = { 0x75000 },
> +       [GCC_UFS_PHY_BCR] = { 0x77000 },
> +       [GCC_USB30_PRIM_BCR] = { 0xf000 },
> +       [GCC_USB30_SEC_BCR] = { 0x10000 },
> +       [GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
> +       [GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
> +       [GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
> +       [GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
> +       [GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
> +       [GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
> +       [GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
> +};
> +
> +static const struct qcom_power_map sm8250_gdscs[] = {
> +       [PCIE_0_GDSC] = { 0x6b004 },    [PCIE_1_GDSC] = { 0x8d004 },
> +       [PCIE_2_GDSC] = { 0x6004 },     [UFS_CARD_GDSC] = { 0x75004 },
> +       [UFS_PHY_GDSC] = { 0x77004 },   [USB30_PRIM_GDSC] = { 0xf004 },
> +       [USB30_SEC_GDSC] = { 0x10004 },
> +};
> +
> +static struct msm_clk_data qcs404_gcc_data = {
> +       .resets = sm8250_gcc_resets,
> +       .num_resets = ARRAY_SIZE(sm8250_gcc_resets),
> +       .clks = sm8250_clks,
> +       .num_clks = ARRAY_SIZE(sm8250_clks),
> +       .power_domains = sm8250_gdscs,
> +       .num_power_domains = ARRAY_SIZE(sm8250_gdscs),
> +
> +       .enable = sm8250_enable,
> +       .set_rate = sm8250_set_rate,
> +};
> +
> +static const struct udevice_id gcc_sm8250_of_match[] = {
> +       {
> +               .compatible = "qcom,gcc-sm8250",
> +               .data = (ulong)&qcs404_gcc_data,
> +       },
> +       {}
> +};
> +
> +U_BOOT_DRIVER(gcc_sm8250) = {
> +       .name = "gcc_sm8250",
> +       .id = UCLASS_NOP,
> +       .of_match = gcc_sm8250_of_match,
> +       .bind = qcom_cc_bind,
> +       .flags = DM_FLAG_PRE_RELOC,
> +};
>
> --
> 2.44.0
>
