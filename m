Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93B1BC52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 14:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B5A88DDF;
	Wed, 21 Aug 2024 16:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O01wNHA2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D61988D9B; Wed, 21 Aug 2024 16:00:06 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B20C88717
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 16:00:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6bf8a662467so24048076d6.3
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724248803; x=1724853603; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1lKGERITs16Lx9/EW7vVK0WfLT+oFUSYJ4yItpoXr+g=;
 b=O01wNHA2758P23Cq8K+v27gGocY+1ahznMBSx4QieMdeu9Vhhg4jqOXLS7z/4bBZ51
 H8o/7TcfbuK4vud3xLC440wAEIp5CUxRrMKhLeRO0+a4z9xu1NJZkFu3pHosmCGJ6r5Y
 LAw2BxZvr3ejeO5E8fnB0Q5qpHjh8rHbiJEBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724248803; x=1724853603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1lKGERITs16Lx9/EW7vVK0WfLT+oFUSYJ4yItpoXr+g=;
 b=D9tZei3fxbssGqybmm5G1+G1G1mWKZP4Ofc+/7ZXDNHJXUFFrKdLx9/U3kFxlRBrvB
 Ipoq8j+Qf/SMJZGlaIFBt0xXEMvOhsK2xnrEyzqsA6ZrCEvlEYUAl44OyLq1NdVJmA1W
 5TuGvFSEW/A9NnA6uSZ76JbG/DIPqxOkTZw8yt8NyxkGMMcqCdtFVC5K7w6JAv2YPjRP
 z9kYEOhMLtN8M/pwSXAqDQgiZ2WQ0j/2sH+u7QN+hpLsLXc7+nPyzlkMiCoEmHW2ZKB3
 RXyL20KXg+1ekl5Bz3UhJs8kHqbzFQRtQxM480pFmTKlNbngU4SlxBJE8zEPsh3GMJKG
 VHwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTVhRw+euRiTDbnzsmsLKGUwL0n5lPXsUGxV+IoFIuWU8vF/GGVRd6/fCZJPAx59hz3kuINMM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz05sakRANl1UGLDaL55n9jmJh08doWRrfXaD7QgDCZyQh9D5ax
 0vpNpKQC2CRpE0EfmVa1W8qTqC/aXvhlt72sxxuhjMyYrETIE5aXNxj71e06jCE7VB5XHgI0sHS
 mJfw26lyT/Hc2cGrK3beC0k9fjFkQS73qWu1H
X-Google-Smtp-Source: AGHT+IGW1n5z/KG76lSgD0gwBO2/HcOAsS9XoFPl470dMaplPAG2nnzOdwSVFaem/2NiHWxn6y53QbvbXEvgDr224to=
X-Received: by 2002:a05:6214:451d:b0:6bf:8c1b:54a6 with SMTP id
 6a1803df08f44-6c155e12a3emr31280716d6.50.1724248803112; Wed, 21 Aug 2024
 07:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
 <20240821-b4-rb3gen2-v2-1-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-1-49b07633f3a8@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 21 Aug 2024 07:59:52 -0600
Message-ID: <CAFLszTjjS8m2DsNp0nMEknM0ggu4QEET81iSyYFGDYWCwVjf2w@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] clk/qcom: add initial clock driver for sc7280
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
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

On Wed, 21 Aug 2024 at 07:42, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> We don't actually need any clocks to get UFS up and running, resets are
> useful though.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/clk/qcom/Kconfig        |   8 +++
>  drivers/clk/qcom/Makefile       |   1 +
>  drivers/clk/qcom/clock-qcom.h   |   1 +
>  drivers/clk/qcom/clock-sc7280.c | 132 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 142 insertions(+)
>
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index 45d63c6d6dbf..0d2c0ac225c5 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -85,7 +85,15 @@ config CLK_QCOM_SM8650
>           Say Y here to enable support for the Global Clock Controller
>           on the Snapdragon SM8650 SoC. This driver supports the clocks
>           and resets exposed by the GCC hardware block.
>
> +config CLK_QCOM_SC7280
> +       bool "Qualcomm SC7280 GCC"
> +       select CLK_QCOM
> +       help
> +         Say Y here to enable support for the Global Clock Controller
> +         on the Snapdragon SC7280 SoC. This driver supports the clocks
> +         and resets exposed by the GCC hardware block.
> +
>  endmenu
>
>  endif
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index dec20e4b5943..e223c131ee4d 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -8,8 +8,9 @@ obj-$(CONFIG_CLK_QCOM_APQ8016) += clock-apq8016.o
>  obj-$(CONFIG_CLK_QCOM_APQ8096) += clock-apq8096.o
>  obj-$(CONFIG_CLK_QCOM_IPQ4019) += clock-ipq4019.o
>  obj-$(CONFIG_CLK_QCOM_QCM2290) += clock-qcm2290.o
>  obj-$(CONFIG_CLK_QCOM_QCS404) += clock-qcs404.o
> +obj-$(CONFIG_CLK_QCOM_SC7280) += clock-sc7280.o
>  obj-$(CONFIG_CLK_QCOM_SM6115) += clock-sm6115.o
>  obj-$(CONFIG_CLK_QCOM_SM8250) += clock-sm8250.o
>  obj-$(CONFIG_CLK_QCOM_SM8550) += clock-sm8550.o
>  obj-$(CONFIG_CLK_QCOM_SM8650) += clock-sm8650.o
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index f6445c8f566f..7aa6ca59aad5 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -10,8 +10,9 @@
>  #define CFG_CLK_SRC_CXO   (0 << 8)
>  #define CFG_CLK_SRC_GPLL0 (1 << 8)
>  #define CFG_CLK_SRC_GPLL0_AUX2 (2 << 8)
>  #define CFG_CLK_SRC_GPLL9 (2 << 8)
> +#define CFG_CLK_SRC_GPLL0_ODD (3 << 8)
>  #define CFG_CLK_SRC_GPLL6 (4 << 8)
>  #define CFG_CLK_SRC_GPLL7 (3 << 8)
>  #define CFG_CLK_SRC_GPLL4 (5 << 8)
>  #define CFG_CLK_SRC_GPLL0_EVEN (6 << 8)
> diff --git a/drivers/clk/qcom/clock-sc7280.c b/drivers/clk/qcom/clock-sc7280.c
> new file mode 100644
> index 000000000000..5d343f120519
> --- /dev/null
> +++ b/drivers/clk/qcom/clock-sc7280.c
> @@ -0,0 +1,132 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock drivers for Qualcomm sc7280
> + *
> + * (C) Copyright 2024 Linaro Ltd.
> + */
> +
> +#include <linux/types.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <linux/delay.h>
> +#include <asm/io.h>
> +#include <linux/bug.h>
> +#include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,gcc-sc7280.h>
> +
> +#include "clock-qcom.h"
> +
> +#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
> +#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
> +
> +static ulong sc7280_set_rate(struct clk *clk, ulong rate)
> +{
> +       struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +       if (clk->id < priv->data->num_clks)
> +               debug("%s: %s, requested rate=%ld\n", __func__, priv->data->clks[clk->id].name, rate);
> +
> +       switch (clk->id) {
> +       case GCC_USB30_PRIM_MOCK_UTMI_CLK:
> +               WARN(rate != 19200000, "Unexpected rate for USB30_PRIM_MOCK_UTMI_CLK: %lu\n", rate);
> +               clk_rcg_set_rate(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
> +               return rate;
> +       case GCC_USB30_PRIM_MASTER_CLK:
> +               WARN(rate != 200000000, "Unexpected rate for USB30_PRIM_MASTER_CLK: %lu\n", rate);
> +               clk_rcg_set_rate_mnd(priv->base, USB30_PRIM_MASTER_CLK_CMD_RCGR,
> +                                    1, 0, 0, CFG_CLK_SRC_GPLL0_ODD, 8);
> +               clk_rcg_set_rate(priv->base, 0xf064, 0, 0);
> +               return rate;
> +       default:
> +               return 0;
> +       }
> +}
> +
> +static const struct gate_clk sc7280_clks[] = {
> +       GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK, 0xf07c, 1),
> +       GATE_CLK(GCC_USB30_PRIM_MASTER_CLK, 0xf010, 1),
> +       GATE_CLK(GCC_AGGRE_USB3_PRIM_AXI_CLK, 0xf080, 1),
> +       GATE_CLK(GCC_USB30_PRIM_SLEEP_CLK, 0xf018, 1),
> +       GATE_CLK(GCC_USB30_PRIM_MOCK_UTMI_CLK, 0xf01c, 1),
> +       GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK, 0xf054, 1),
> +       GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK, 0xf058, 1),
> +};
> +
> +static int sc7280_enable(struct clk *clk)
> +{
> +       struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> +
> +       if (priv->data->num_clks < clk->id) {
> +               debug("%s: unknown clk id %lu\n", __func__, clk->id);
> +               return 0;
> +       }
> +
> +       debug("%s: clk %ld: %s\n", __func__, clk->id, sc7280_clks[clk->id].name);
> +
> +       switch (clk->id) {
> +       case GCC_AGGRE_USB3_PRIM_AXI_CLK:
> +               qcom_gate_clk_en(priv, GCC_USB30_PRIM_MASTER_CLK);
> +               fallthrough;
> +       case GCC_USB30_PRIM_MASTER_CLK:
> +               qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_AUX_CLK);
> +               qcom_gate_clk_en(priv, GCC_USB3_PRIM_PHY_COM_AUX_CLK);
> +               break;
> +       }
> +
> +       qcom_gate_clk_en(priv, clk->id);
> +
> +       return 0;
> +}
> +
> +static const struct qcom_reset_map sc7280_gcc_resets[] = {
> +       [GCC_PCIE_0_BCR] = { 0x6b000 },
> +       [GCC_PCIE_0_PHY_BCR] = { 0x6c01c },
> +       [GCC_PCIE_1_BCR] = { 0x8d000 },
> +       [GCC_PCIE_1_PHY_BCR] = { 0x8e01c },
> +       [GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
> +       [GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
> +       [GCC_SDCC1_BCR] = { 0x75000 },
> +       [GCC_SDCC2_BCR] = { 0x14000 },
> +       [GCC_SDCC4_BCR] = { 0x16000 },
> +       [GCC_UFS_PHY_BCR] = { 0x77000 },
> +       [GCC_USB30_PRIM_BCR] = { 0xf000 },
> +       [GCC_USB30_SEC_BCR] = { 0x9e000 },
> +       [GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
> +       [GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
> +       [GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
> +       [GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
> +};
> +
> +static const struct qcom_power_map sc7280_gdscs[] = {
> +       [GCC_UFS_PHY_GDSC] = { 0x77004 },
> +       [GCC_USB30_PRIM_GDSC] = { 0xf004 },
> +};
> +
> +static struct msm_clk_data qcs404_gcc_data = {
> +       .resets = sc7280_gcc_resets,
> +       .num_resets = ARRAY_SIZE(sc7280_gcc_resets),
> +       .clks = sc7280_clks,
> +       .num_clks = ARRAY_SIZE(sc7280_clks),
> +
> +       .power_domains = sc7280_gdscs,
> +       .num_power_domains = ARRAY_SIZE(sc7280_gdscs),
> +
> +       .enable = sc7280_enable,
> +       .set_rate = sc7280_set_rate,
> +};
> +
> +static const struct udevice_id gcc_sc7280_of_match[] = {
> +       {
> +               .compatible = "qcom,gcc-sc7280",
> +               .data = (ulong)&qcs404_gcc_data,
> +       },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(gcc_sc7280) = {
> +       .name           = "gcc_sc7280",
> +       .id             = UCLASS_NOP,
> +       .of_match       = gcc_sc7280_of_match,
> +       .bind           = qcom_cc_bind,
> +       .flags          = DM_FLAG_PRE_RELOC | DM_FLAG_DEFAULT_PD_CTRL_OFF,
> +};

This should use driver model, with a UCLASS_CLK and UCLASS_RESET

Regards,
Simon
