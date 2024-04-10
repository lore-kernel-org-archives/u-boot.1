Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2802CD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 09:53:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 243198815A;
	Wed, 10 Apr 2024 11:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NAo61YpY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C5D783346; Wed, 10 Apr 2024 11:53:42 +0200 (CEST)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 351118815A
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 11:53:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-7e36fa66672so1464646241.2
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 02:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712742817; x=1713347617; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OOi3K23phqvn6zRNxniC+ujenrh54blqNlbMQw71XMs=;
 b=NAo61YpYO8SryM7rjtKN8gQn5jJusbxDR82APdzAJrALZvRBPmW+vEyB3MugzMCVDa
 6bBVBSVfo4OCqW8EOVX8s1ZTZgSZjSF5rXnwSX3mKWU8yGDV/70ofh8J2pv1WQDluFss
 kZLPefJVwi87/BI/yBxdj7I4cs8K4A/kl/yXSctpoLLV/T0zxhrdtAvileM9vXM5NZDD
 4r1WP1p0YeHy4wv+9bknvju5q75ZymKoSjFkW6bASDiY1VGcwi446d3T5UgI+SAuKNvB
 KkYdQd76nHBox6BmF+/Rk3w5FXMLAXIJSnraM7cVp8xj1Dp9osgxobBKkN/fWCpXyLB4
 8+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712742817; x=1713347617;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OOi3K23phqvn6zRNxniC+ujenrh54blqNlbMQw71XMs=;
 b=tbQVBDyNwTcfRiTGsFJlhodtTK6aqRR+gQ3NGi5NDsWn5GzTc2NNQ9Y3Snq7L+dpyp
 YqD9fucAe4FisIdQgi5VhfqW5nImWry5g+iBokuJIjPvnOrMZUpo0EtSgWXHlrRBu4dC
 TDFAIOb1oPocbkbZBV037u7FqNwun0aiwPQWI3gdf3IhyLAORMs92eSWZJvMdvuxy/x5
 OpcceI/89KWa48Rk6XLGOeZkQUGKcSVjJsfRQOOFYKClL/VY1eEOtccF27rHBi72aif5
 wNheZVfqL8sctQw52CMZF69sg27Z6fNP90Fnc/L1TpDbYlyrkcos//w49/sgzCYBh0YB
 PAig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHAQ8G9VCZxvv0vCezJz762bMDibXDFvmzR9MHa2x4nrdNcrnPYBbSqdrxguemNEyk+XJ7C0rnXr5gUVPF8eEpZ+WeMw==
X-Gm-Message-State: AOJu0YwRa4FITMQIhtWABQ2vWObpjR2NTLuFiF2kMuPXm63QnSQJzuEp
 poH05oX5TclcOJZ0WfjPGV35sENLA+A4zfYI2P8rKrhvgn9MfKhfkkNxjXH6/0+OHebAe+23vlj
 ytbPn2IbvbRZnCwVFbd4BsW9Cus/7d18Tg67DgA==
X-Google-Smtp-Source: AGHT+IGdIamLSDHGf6eNwh0NN/WG0yphYTze0+XHIWV2Xy/TPAL6V2WVl2VDFjHPaqyZm3wmPQOREuOXowg95sfOOc4=
X-Received: by 2002:a05:6102:3709:b0:47a:2662:285f with SMTP id
 s9-20020a056102370900b0047a2662285fmr909670vst.21.1712742816867; Wed, 10 Apr
 2024 02:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240404-topic-sm8x50-clock-v1-0-0c8ea7fad003@linaro.org>
 <20240404-topic-sm8x50-clock-v1-1-0c8ea7fad003@linaro.org>
 <CAFA6WYPwCMk2b-U0JA0nKEE-E_TSpaX7-60JYfsCT3TU_mzktg@mail.gmail.com>
 <1961c187-702b-4cb3-b37e-69d8b4658013@linaro.org>
 <CAFA6WYNEfXDa42OaF72pf3V4UH7AU_dxVjYeJBx7wnhRP3dyUw@mail.gmail.com>
 <f9a0f4e5-4593-4d12-8880-3ec31799eb2b@linaro.org>
In-Reply-To: <f9a0f4e5-4593-4d12-8880-3ec31799eb2b@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 10 Apr 2024 15:23:25 +0530
Message-ID: <CAFA6WYNZH-QxX1AezByqyQYsAhT4hpk76-4RQr-tW29zSnqogw@mail.gmail.com>
Subject: Re: [PATCH 1/3] clk: qcom: Add SM8550 clock driver
To: neil.armstrong@linaro.org
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
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

On Wed, 10 Apr 2024 at 15:00, <neil.armstrong@linaro.org> wrote:
>
> On 10/04/2024 11:27, Sumit Garg wrote:
> > On Wed, 10 Apr 2024 at 14:46, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>
> >> On 10/04/2024 11:13, Sumit Garg wrote:
> >>> Hi Neil,
> >>>
> >>> On Thu, 4 Apr 2024 at 22:16, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>>>
> >>>> Add the GCC and TCSRCC clock driver for the SM8550 SoC.
> >>>>
> >>>> The GCC driver uses the clk-qcom infrastructure to support GDSCs,
> >>>> Resets and gates. While the TCSRCC is a simpler clock driver which
> >>>> only supports gates.
> >>>>
> >>>> The GCC enable and set_rate callbacks contains some tweaks to
> >>>> setup clocks for Debug UART, SDCard controller and USB.
> >>>
> >>> Okay so these are the peripherals you intend to support to begin with.
> >>>
> >>>>
> >>>> The TCSRCC gates returns the XO frequency, which is used by the
> >>>> Synopsys eUSB2 driver to determine the PHY configuration.
> >>>>
> >>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >>>> ---
> >>>>    drivers/clk/qcom/Kconfig        |   8 +
> >>>>    drivers/clk/qcom/Makefile       |   1 +
> >>>>    drivers/clk/qcom/clock-sm8550.c | 335 ++++++++++++++++++++++++++++++++++++++++
> >>>>    3 files changed, 344 insertions(+)
> >>>>
> >>>> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> >>>> index 8dae635ac2c..c908a3d19c9 100644
> >>>> --- a/drivers/clk/qcom/Kconfig
> >>>> +++ b/drivers/clk/qcom/Kconfig
> >>>> @@ -47,6 +47,14 @@ config CLK_QCOM_SDM845
> >>>>             on the Snapdragon 845 SoC. This driver supports the clocks
> >>>>             and resets exposed by the GCC hardware block.
> >>>>
> >>>> +config CLK_QCOM_SM8550
> >>>> +       bool "Qualcomm SM8550 GCC"
> >>>> +       select CLK_QCOM
> >>>> +       help
> >>>> +         Say Y here to enable support for the Global Clock Controller
> >>>> +         on the Snapdragon SM8550 SoC. This driver supports the clocks
> >>>> +         and resets exposed by the GCC hardware block.
> >>>> +
> >>>>    endmenu
> >>>>
> >>>>    endif
> >>>> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> >>>> index cb179fdac58..d9ac5719f49 100644
> >>>> --- a/drivers/clk/qcom/Makefile
> >>>> +++ b/drivers/clk/qcom/Makefile
> >>>> @@ -8,3 +8,4 @@ obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
> >>>>    obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
> >>>>    obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
> >>>>    obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
> >>>> +obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
> >>>> diff --git a/drivers/clk/qcom/clock-sm8550.c b/drivers/clk/qcom/clock-sm8550.c
> >>>> new file mode 100644
> >>>> index 00000000000..c0249925cc7
> >>>> --- /dev/null
> >>>> +++ b/drivers/clk/qcom/clock-sm8550.c
> >>>> @@ -0,0 +1,335 @@
> >>>> +// SPDX-License-Identifier: BSD-3-Clause
> >>>> +/*
> >>>> + * Clock drivers for Qualcomm sm8550
> >>>> + *
> >>>> + * (C) Copyright 2024 Linaro Ltd.
> >>>> + */
> >>>> +
> >>>> +#include <clk-uclass.h>
> >>>> +#include <dm.h>
> >>>> +#include <linux/delay.h>
> >>>> +#include <errno.h>
> >>>> +#include <asm/io.h>
> >>>> +#include <linux/bug.h>
> >>>> +#include <linux/bitops.h>
> >>>> +#include <dt-bindings/clock/qcom,sm8550-gcc.h>
> >>>> +#include <dt-bindings/clock/qcom,sm8550-tcsr.h>
> >>>> +
> >>>> +#include "clock-qcom.h"
> >>>> +
> >>>> +/* On-board TCXO, TOFIX get from DT */
> >>>> +#define TCXO_RATE      38400000
> >>>> +
> >>>> +/* bi_tcxo_div2 divided after RPMh output */
> >>>> +#define TCXO_DIV2_RATE (TCXO_RATE / 2)
> >>>> +
> >>>> +static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s2_clk_src[] = {
> >>>> +       F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
> >>>> +       F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
> >>>> +       F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> >>>> +       F(29491200, CFG_CLK_SRC_GPLL0_EVEN, 1, 1536, 15625),
> >>>> +       F(32000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 75),
> >>>> +       F(48000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 25),
> >>>> +       F(51200000, CFG_CLK_SRC_GPLL0_EVEN, 1, 64, 375),
> >>>> +       F(64000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 16, 75),
> >>>> +       F(75000000, CFG_CLK_SRC_GPLL0_EVEN, 4, 0, 0),
> >>>> +       F(80000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 4, 15),
> >>>> +       F(96000000, CFG_CLK_SRC_GPLL0_EVEN, 1, 8, 25),
> >>>> +       F(100000000, CFG_CLK_SRC_GPLL0, 6, 0, 0),
> >>>> +       { }
> >>>> +};
> >>>> +
> >>>> +static const struct freq_tbl ftbl_gcc_sdcc2_apps_clk_src[] = {
> >>>> +       F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> >>>> +       F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
> >>>> +       F(37500000, CFG_CLK_SRC_GPLL0_EVEN, 8, 0, 0),
> >>>> +       F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
> >>>> +       F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
> >>>> +       /* TOFIX F(202000000, CFG_CLK_SRC_GPLL9, 4, 0, 0), */
> >>>> +       { }
> >>>> +};
> >>>> +
> >>>> +static const struct freq_tbl ftbl_gcc_usb30_prim_master_clk_src[] = {
> >>>> +       F(66666667, CFG_CLK_SRC_GPLL0_EVEN, 4.5, 0, 0),
> >>>> +       F(133333333, CFG_CLK_SRC_GPLL0, 4.5, 0, 0),
> >>>> +       F(200000000, CFG_CLK_SRC_GPLL0, 3, 0, 0),
> >>>> +       F(240000000, CFG_CLK_SRC_GPLL0, 2.5, 0, 0),
> >>>> +       { }
> >>>> +};
> >>>> +
> >>>> +static ulong sm8550_set_rate(struct clk *clk, ulong rate)
> >>>> +{
> >>>> +       struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> >>>> +       const struct freq_tbl *freq;
> >>>> +
> >>>> +       switch (clk->id) {
> >>>> +       case GCC_QUPV3_WRAP1_S7_CLK: /* UART7 */
> >>>> +               freq = qcom_find_freq(ftbl_gcc_qupv3_wrap1_s2_clk_src, rate);
> >>>> +               clk_rcg_set_rate_mnd(priv->base, 0x18898,
> >>>> +                                    freq->pre_div, freq->m, freq->n, freq->src, 16);
> >>>> +               return freq->freq;
> >>>> +       case GCC_SDCC2_APPS_CLK:
> >>>> +               freq = qcom_find_freq(ftbl_gcc_sdcc2_apps_clk_src, rate);
> >>>> +               clk_rcg_set_rate_mnd(priv->base, 0x14018,
> >>>> +                                    freq->pre_div, freq->m, freq->n, freq->src, 8);
> >>>> +               return freq->freq;
> >>>> +       case GCC_USB30_PRIM_MASTER_CLK:
> >>>> +               freq = qcom_find_freq(ftbl_gcc_usb30_prim_master_clk_src, rate);
> >>>> +               clk_rcg_set_rate_mnd(priv->base, 0x3902c,
> >>>> +                                    freq->pre_div, freq->m, freq->n, freq->src, 8);
> >>>> +               return freq->freq;
> >>>> +       case GCC_USB30_PRIM_MOCK_UTMI_CLK:
> >>>> +               clk_rcg_set_rate(priv->base, 0x39044, 0, 0);
> >>>> +               return TCXO_DIV2_RATE;
> >>>> +       case GCC_USB3_PRIM_PHY_AUX_CLK_SRC:
> >>>> +               clk_rcg_set_rate(priv->base, 0x39070, 0, 0);
> >>>> +               return TCXO_DIV2_RATE;
> >>>> +       default:
> >>>> +               return 0;
> >>>> +       }
> >>>> +}
> >>>> +
> >>>> +static const struct gate_clk sm8550_clks[] = {
> >>>> +       GATE_CLK(GCC_AGGRE_NOC_PCIE_AXI_CLK,            0x52000, BIT(12)),
> >>>> +       GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_CLK,             0x770e4, BIT(0)),
> >>>> +       GATE_CLK(GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK,      0x770e4, BIT(1)),
> >>>> +       GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK,           0x3908c, BIT(0)),
> >>>> +       GATE_CLK(GCC_CNOC_PCIE_SF_AXI_CLK,              0x52008, BIT(6)),
> >>>> +       GATE_CLK(GCC_DDRSS_GPU_AXI_CLK,                 0x71154, BIT(0)),
> >>>> +       GATE_CLK(GCC_DDRSS_PCIE_SF_QTB_CLK,             0x52000, BIT(19)),
> >>>> +       GATE_CLK(GCC_PCIE_0_AUX_CLK,                    0x52008, BIT(3)),
> >>>> +       GATE_CLK(GCC_PCIE_0_CFG_AHB_CLK,                0x52008, BIT(2)),
> >>>> +       GATE_CLK(GCC_PCIE_0_MSTR_AXI_CLK,               0x52008, BIT(1)),
> >>>> +       GATE_CLK(GCC_PCIE_0_PHY_RCHNG_CLK,              0x52000, BIT(22)),
> >>>> +       GATE_CLK(GCC_PCIE_0_PIPE_CLK,                   0x52008, BIT(4)),
> >>>> +       GATE_CLK(GCC_PCIE_0_SLV_AXI_CLK,                0x52008, BIT(0)),
> >>>> +       GATE_CLK(GCC_PCIE_0_SLV_Q2A_AXI_CLK,            0x52008, BIT(5)),
> >>>> +       GATE_CLK(GCC_PCIE_1_AUX_CLK,                    0x52000, BIT(29)),
> >>>> +       GATE_CLK(GCC_PCIE_1_CFG_AHB_CLK,                0x52000, BIT(28)),
> >>>> +       GATE_CLK(GCC_PCIE_1_MSTR_AXI_CLK,               0x52000, BIT(27)),
> >>>> +       GATE_CLK(GCC_PCIE_1_PHY_AUX_CLK,                0x52000, BIT(24)),
> >>>> +       GATE_CLK(GCC_PCIE_1_PHY_RCHNG_CLK,              0x52000, BIT(23)),
> >>>> +       GATE_CLK(GCC_PCIE_1_PIPE_CLK,                   0x52000, BIT(30)),
> >>>> +       GATE_CLK(GCC_PCIE_1_SLV_AXI_CLK,                0x52000, BIT(26)),
> >>>> +       GATE_CLK(GCC_PCIE_1_SLV_Q2A_AXI_CLK,            0x52000, BIT(25)),
> >>>> +       GATE_CLK(GCC_QUPV3_I2C_CORE_CLK,                0x52008, BIT(8)),
> >>>> +       GATE_CLK(GCC_QUPV3_I2C_S0_CLK,                  0x52008, BIT(10)),
> >>>> +       GATE_CLK(GCC_QUPV3_I2C_S1_CLK,                  0x52008, BIT(11)),
> >>>> +       GATE_CLK(GCC_QUPV3_I2C_S2_CLK,                  0x52008, BIT(12)),
> >>>> +       GATE_CLK(GCC_QUPV3_I2C_S3_CLK,                  0x52008, BIT(13)),
> >>>> +       GATE_CLK(GCC_QUPV3_I2C_S4_CLK,                  0x52008, BIT(14)),
> >>>> +       GATE_CLK(GCC_QUPV3_I2C_S5_CLK,                  0x52008, BIT(15)),
> >>>> +       GATE_CLK(GCC_QUPV3_I2C_S6_CLK,                  0x52008, BIT(16)),
> >>>> +       GATE_CLK(GCC_QUPV3_I2C_S7_CLK,                  0x52008, BIT(17)),
> >>>> +       GATE_CLK(GCC_QUPV3_I2C_S8_CLK,                  0x52010, BIT(14)),
> >>>> +       GATE_CLK(GCC_QUPV3_I2C_S9_CLK,                  0x52010, BIT(15)),
> >>>> +       GATE_CLK(GCC_QUPV3_I2C_S_AHB_CLK,               0x52008, BIT(7)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP1_CORE_2X_CLK,           0x52008, BIT(18)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP1_CORE_CLK,              0x52008, BIT(19)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S0_CLK,                0x52008, BIT(22)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S1_CLK,                0x52008, BIT(23)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S2_CLK,                0x52008, BIT(24)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S3_CLK,                0x52008, BIT(25)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S4_CLK,                0x52008, BIT(26)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S5_CLK,                0x52008, BIT(27)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S6_CLK,                0x52008, BIT(28)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP1_S7_CLK,                0x52010, BIT(16)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP2_CORE_2X_CLK,           0x52010, BIT(3)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP2_CORE_CLK,              0x52010, BIT(0)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S0_CLK,                0x52010, BIT(4)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S1_CLK,                0x52010, BIT(5)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S2_CLK,                0x52010, BIT(6)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S3_CLK,                0x52010, BIT(7)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S4_CLK,                0x52010, BIT(8)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S5_CLK,                0x52010, BIT(9)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S6_CLK,                0x52010, BIT(10)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP2_S7_CLK,                0x52010, BIT(17)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP_1_M_AHB_CLK,            0x52008, BIT(20)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP_1_S_AHB_CLK,            0x52008, BIT(21)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP_2_M_AHB_CLK,            0x52010, BIT(2)),
> >>>> +       GATE_CLK(GCC_QUPV3_WRAP_2_S_AHB_CLK,            0x52010, BIT(1)),
> >>>> +       GATE_CLK(GCC_SDCC2_AHB_CLK,                     0x14010, BIT(0)),
> >>>> +       GATE_CLK(GCC_SDCC2_APPS_CLK,                    0x14004, BIT(0)),
> >>>> +       GATE_CLK(GCC_UFS_PHY_AHB_CLK,                   0x77024, BIT(0)),
> >>>> +       GATE_CLK(GCC_UFS_PHY_AXI_CLK,                   0x77018, BIT(0)),
> >>>> +       GATE_CLK(GCC_UFS_PHY_AXI_HW_CTL_CLK,            0x77018, BIT(1)),
> >>>> +       GATE_CLK(GCC_UFS_PHY_ICE_CORE_CLK,              0x77074, BIT(0)),
> >>>> +       GATE_CLK(GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK,       0x77074, BIT(1)),
> >>>> +       GATE_CLK(GCC_UFS_PHY_PHY_AUX_CLK,               0x770b0, BIT(0)),
> >>>> +       GATE_CLK(GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK,        0x770b0, BIT(1)),
> >>>> +       GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_0_CLK,           0x7702c, BIT(0)),
> >>>> +       GATE_CLK(GCC_UFS_PHY_RX_SYMBOL_1_CLK,           0x770cc, BIT(0)),
> >>>> +       GATE_CLK(GCC_UFS_PHY_TX_SYMBOL_0_CLK,           0x77028, BIT(0)),
> >>>> +       GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_CLK,           0x77068, BIT(0)),
> >>>> +       GATE_CLK(GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK,    0x77068, BIT(1)),
> >>>> +       GATE_CLK(GCC_USB30_PRIM_MASTER_CLK,             0x39018, BIT(0)),
> >>>> +       GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK,          0x39028, BIT(0)),
> >>>> +       GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK,              0x39024, BIT(0)),
> >>>> +       GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,             0x39060, BIT(0)),
> >>>> +       GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,         0x39064, BIT(0)),
> >>>> +       GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,            0x39068, BIT(0)),
> >>>> +};
> >>>
> >>> Shouldn't this list be trimmed down to supported peripherals only?
> >>
> >> It's already the case, I also intend to support PCIe so I added the gates already,
> >> it would need some proper support in sm8550_set_rate/sm8550_enable when I'll
> >> figure out what's needed.
> >
> > Is that all you need? Do we have the Qcom PCIe driver in U-Boot to
> > start with? So please don't add unsupported code.
>
> Saying it's unsupported code is quite exagerated, not sure I'm aligned on your position.
>

Let me try to rephrase it. Can we test these GDSCs, resets and gates
without actual driver support in U-Boot?

-Sumit
