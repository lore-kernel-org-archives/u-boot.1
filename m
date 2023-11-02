Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE33BC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 07:55:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F50987671;
	Thu,  2 Nov 2023 08:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zEe+zd/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C9808761A; Thu,  2 Nov 2023 08:55:28 +0100 (CET)
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com
 [IPv6:2607:f8b0:4864:20::930])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 243F687688
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 08:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-7b5f28da928so248318241.0
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 00:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698911708; x=1699516508; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nYOCw552mSGMchcwdvPUHFxbOQvnywjw+dPuuyhghPM=;
 b=zEe+zd/mzArgSRt1ETFn2Ap/DMWXTboC5RN5WPGcZzeB6uv5Z30sQm5q33g12Yax8F
 Wz+O0o621o5MhjU2c5McoOnT/K397Uxo2oEn97riP2BGJyWbZRFN17lbldJpW1LbNJ5u
 kp/GXHoHV2PKMpgLpw01M1CmsNZ+zIc2U1PqT2wFtl45HVYQG3buojWImTwqIp9iBPCy
 fTjXzHzFH8y1jlKVu2nkv3scN14E3eaN/9uk+bk9wa+MX3GPTcmjCZQrrI74tO9M2oKs
 xatVAnxjUgoXzdblko7tmzNxE8eShzu8pGEZb+49vUgtuEhlHnivLNdcaq5osJs7GB7Q
 iusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698911708; x=1699516508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nYOCw552mSGMchcwdvPUHFxbOQvnywjw+dPuuyhghPM=;
 b=LQ0u84JP2zYwIVITx/+WxWgG0u4X4b4f9YsJ4Ex+TXo/h2tzix5oftsVKEKjBhjH8s
 FUpNRBxcvRs24GVOgz4TOQDWG13bV5bwK2hdup9livBuOTHQtU1m2x1dqshMYRyGaUrz
 HVnrdCSW1nmSHO6oT1ngdFe9U5M7BCbmZ+CH+R/Syjvtsrj9H1AlfOltFTJTZIKKgKLf
 HfIYzpgR60gx/RlnJPis89+wADeiKWLPyRgvgy4ugEntDi1jeHPSyzhCeABUfWk0O0sx
 STSixlCV4qtfZATokNEJBviQmb7HzSYVHec+jhfB6zyKNprbe0noKxZ6odc4Ti2EB7dp
 YkJA==
X-Gm-Message-State: AOJu0Yy6JzLqJQ1/wcPgIeX3xy1OI/OOu2vuMrBi29xVqvBkx7dz1t06
 FiEz/sDcvOwMNO9opkRXFdApMTj3za4qWyGuU2GUvQ==
X-Google-Smtp-Source: AGHT+IEqWYYtot6llZah731MCYZqWxDXGX3q+0pLRl2TGblIlQnu7kFdwcq0gfsmqMnEnKM0bDF+679r6KexHYyQfY4=
X-Received: by 2002:a67:c112:0:b0:457:c933:a228 with SMTP id
 d18-20020a67c112000000b00457c933a228mr13406185vsj.26.1698911707807; Thu, 02
 Nov 2023 00:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20231024-b4-qcom-clk-v2-0-6572bc2be690@linaro.org>
 <20231024-b4-qcom-clk-v2-3-6572bc2be690@linaro.org>
In-Reply-To: <20231024-b4-qcom-clk-v2-3-6572bc2be690@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 2 Nov 2023 13:24:54 +0530
Message-ID: <CAFA6WYOrNDVZqZD2FJREpk+T2iosKxAeueiKnhN0kOstkuUr2Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] clk/qcom: handle resets and clocks in one device
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Robert Marko <robert.marko@sartura.hr>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Luka Perkov <luka.perkov@sartura.hr>, Dzmitry Sankouski <dsankouski@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, u-boot@lists.denx.de, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
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
> From: Konrad Dybcio <konrad.dybcio@linaro.org>
>
> Qualcomm's clock controller blocks actually do much more than it
> says on the tin.. They provide clocks, resets and power domains.
> Currently, U-Boot requires one to spawn 2 separate devices for
> controlling clocks and resets, both spanning the same register space.
> Refactor the code to make it work with just a single DT node, making
> it compatible with upstream Linux bindings and dropping the dedicated
> reset driver in favour of including it in the clock driver.
>
> Heavily inspired by Renesas code for a similar hw block.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> [caleb: moved drivers to clk/qcom, added reset driver and adjusted bind
> logic. Imported qcom,gcc-ipq4019.h from Linux]
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/Kconfig                                   |   1 +
>  arch/arm/dts/qcom-ipq4019.dtsi                     |  14 +-
>  arch/arm/dts/qcs404-evb.dts                        |  19 +-
>  drivers/clk/qcom/clock-apq8016.c                   |  17 ++
>  drivers/clk/qcom/clock-apq8096.c                   |  16 ++
>  drivers/clk/qcom/clock-ipq4019.c                   |  96 +++++++++-
>  drivers/clk/qcom/clock-qcom.c                      | 119 +++++++++++--
>  drivers/clk/qcom/clock-qcom.h                      |  22 ++-
>  drivers/clk/qcom/clock-qcs404.c                    |  50 +++++-
>  drivers/clk/qcom/clock-sdm845.c                    |  42 +++++
>  drivers/reset/Kconfig                              |   7 -
>  drivers/reset/Makefile                             |   1 -
>  drivers/reset/reset-qcom.c                         | 195 ---------------------
>  .../{qcom,ipq4019-gcc.h => qcom,gcc-ipq4019.h}     |  73 ++++++++
>  include/dt-bindings/reset/qcom,ipq4019-reset.h     |  92 ----------
>  15 files changed, 422 insertions(+), 342 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 5aaf7e5e32af..faccfaf720a8 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1067,6 +1067,7 @@ config ARCH_SNAPDRAGON
>         select DM
>         select DM_GPIO
>         select DM_SERIAL
> +       select DM_RESET
>         select GPIO_EXTRA_HEADER
>         select MSM_SMEM
>         select OF_CONTROL
> diff --git a/arch/arm/dts/qcom-ipq4019.dtsi b/arch/arm/dts/qcom-ipq4019.dtsi
> index 0850ae56e9a8..f9489e42ea2c 100644
> --- a/arch/arm/dts/qcom-ipq4019.dtsi
> +++ b/arch/arm/dts/qcom-ipq4019.dtsi
> @@ -66,14 +66,6 @@
>                         status = "disabled";
>                 };
>
> -               reset: gcc-reset@1800000 {
> -                       compatible = "qcom,gcc-reset-ipq4019";
> -                       reg = <0x1800000 0x60000>;
> -                       #clock-cells = <1>;
> -                       #reset-cells = <1>;
> -                       bootph-all;
> -               };
> -
>                 soc_gpios: pinctrl@1000000 {
>                         compatible = "qcom,ipq4019-pinctrl";
>                         reg = <0x1000000 0x300000>;
> @@ -136,7 +128,7 @@
>                         #phy-cells = <0>;
>                         reg = <0x9a000 0x800>;
>                         reg-names = "phy_base";
> -                       resets = <&reset USB3_UNIPHY_PHY_ARES>;
> +                       resets = <&gcc USB3_UNIPHY_PHY_ARES>;
>                         reset-names = "por_rst";
>                         status = "disabled";
>                 };
> @@ -146,7 +138,7 @@
>                         #phy-cells = <0>;
>                         reg = <0xa6000 0x40>;
>                         reg-names = "phy_base";
> -                       resets = <&reset USB3_HSPHY_POR_ARES>, <&reset USB3_HSPHY_S_ARES>;
> +                       resets = <&gcc USB3_HSPHY_POR_ARES>, <&gcc USB3_HSPHY_S_ARES>;
>                         reset-names = "por_rst", "srif_rst";
>                         status = "disabled";
>                 };
> @@ -179,7 +171,7 @@
>                         #phy-cells = <0>;
>                         reg = <0xa8000 0x40>;
>                         reg-names = "phy_base";
> -                       resets = <&reset USB2_HSPHY_POR_ARES>, <&reset USB2_HSPHY_S_ARES>;
> +                       resets = <&gcc USB2_HSPHY_POR_ARES>, <&gcc USB2_HSPHY_S_ARES>;
>                         reset-names = "por_rst", "srif_rst";
>                         status = "disabled";
>                 };
> diff --git a/arch/arm/dts/qcs404-evb.dts b/arch/arm/dts/qcs404-evb.dts
> index 8d7893c11695..84224a8a3d39 100644
> --- a/arch/arm/dts/qcs404-evb.dts
> +++ b/arch/arm/dts/qcs404-evb.dts
> @@ -208,11 +208,6 @@
>                         #address-cells = <0x1>;
>                         #size-cells = <0x0>;
>                         #clock-cells = <1>;
> -               };
> -
> -               reset: gcc-reset@1800000 {
> -                       compatible = "qcom,gcc-reset-qcs404";
> -                       reg = <0x1800000 0x80000>;
>                         #reset-cells = <1>;
>                 };
>
> @@ -245,8 +240,8 @@
>                         clocks = <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
>                                  <&gcc GCC_USB3_PHY_PIPE_CLK>;
>                         clock-names = "ahb", "pipe";
> -                       resets = <&reset GCC_USB3_PHY_BCR>,
> -                                <&reset GCC_USB3PHY_PHY_BCR>;
> +                       resets = <&gcc GCC_USB3_PHY_BCR>,
> +                                <&gcc GCC_USB3PHY_PHY_BCR>;
>                         reset-names = "com", "phy";
>                 };
>
> @@ -257,8 +252,8 @@
>                         clocks = <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
>                                  <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
>                         clock-names = "ahb", "sleep";
> -                       resets = <&reset GCC_USB_HS_PHY_CFG_AHB_BCR>,
> -                                <&reset GCC_USB2A_PHY_BCR>;
> +                       resets = <&gcc GCC_USB_HS_PHY_CFG_AHB_BCR>,
> +                                <&gcc GCC_USB2A_PHY_BCR>;
>                         reset-names = "phy", "por";
>                 };
>
> @@ -269,8 +264,8 @@
>                         clocks = <&gcc GCC_USB_HS_PHY_CFG_AHB_CLK>,
>                                  <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
>                         clock-names = "ahb", "sleep";
> -                       resets = <&reset GCC_QUSB2_PHY_BCR>,
> -                                <&reset GCC_USB2_HS_PHY_ONLY_BCR>;
> +                       resets = <&gcc GCC_QUSB2_PHY_BCR>,
> +                                <&gcc GCC_USB2_HS_PHY_ONLY_BCR>;
>                         reset-names = "phy", "por";
>                 };
>
> @@ -335,7 +330,7 @@
>                                  <&gcc GCC_ETH_PTP_CLK>,
>                                  <&gcc GCC_ETH_RGMII_CLK>;
>
> -                       resets = <&reset GCC_EMAC_BCR>;
> +                       resets = <&gcc GCC_EMAC_BCR>;
>                         reset-names = "emac";
>
>                         snps,tso;
> diff --git a/drivers/clk/qcom/clock-apq8016.c b/drivers/clk/qcom/clock-apq8016.c
> index 90f2a93d9ed5..3bddbd275906 100644
> --- a/drivers/clk/qcom/clock-apq8016.c
> +++ b/drivers/clk/qcom/clock-apq8016.c
> @@ -13,6 +13,7 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> +
>  #include "clock-qcom.h"
>
>  /* GPLL0 clock control registers */
> @@ -116,3 +117,19 @@ int msm_enable(struct clk *clk)
>  {
>         return 0;
>  }
> +
> +static const struct udevice_id gcc_apq8016_of_match[] = {
> +       {
> +               .compatible = "qcom,gcc-apq8016",
> +               /* TODO: add reset map */
> +       },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(gcc_apq8016) = {
> +       .name           = "gcc_apq8016",
> +       .id             = UCLASS_NOP,
> +       .of_match       = gcc_apq8016_of_match,
> +       .bind           = qcom_cc_bind,
> +       .flags          = DM_FLAG_PRE_RELOC,
> +};
> diff --git a/drivers/clk/qcom/clock-apq8096.c b/drivers/clk/qcom/clock-apq8096.c
> index d5388c69aefe..64b8cdf4c54b 100644
> --- a/drivers/clk/qcom/clock-apq8096.c
> +++ b/drivers/clk/qcom/clock-apq8096.c
> @@ -99,3 +99,19 @@ int msm_enable(struct clk *clk)
>  {
>         return 0;
>  }
> +
> +static const struct udevice_id gcc_apq8096_of_match[] = {
> +       {
> +               .compatible = "qcom,gcc-apq8096",
> +               /* TODO: add reset map */
> +       },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(gcc_apq8096) = {
> +       .name           = "gcc_apq8096",
> +       .id             = UCLASS_NOP,
> +       .of_match       = gcc_apq8096_of_match,
> +       .bind           = qcom_cc_bind,
> +       .flags          = DM_FLAG_PRE_RELOC,
> +};
> diff --git a/drivers/clk/qcom/clock-ipq4019.c b/drivers/clk/qcom/clock-ipq4019.c
> index 04c99964df15..db869f874219 100644
> --- a/drivers/clk/qcom/clock-ipq4019.c
> +++ b/drivers/clk/qcom/clock-ipq4019.c
> @@ -12,7 +12,7 @@
>  #include <common.h>
>  #include <dm.h>
>  #include <errno.h>
> -#include <dt-bindings/clock/qcom,ipq4019-gcc.h>
> +#include <dt-bindings/clock/qcom,gcc-ipq4019.h>
>
>  #include "clock-qcom.h"
>
> @@ -49,3 +49,97 @@ int msm_enable(struct clk *clk)
>         }
>  }
>
> +static const struct qcom_reset_map gcc_ipq4019_resets[] = {
> +       [WIFI0_CPU_INIT_RESET] = { 0x1f008, 5 },
> +       [WIFI0_RADIO_SRIF_RESET] = { 0x1f008, 4 },
> +       [WIFI0_RADIO_WARM_RESET] = { 0x1f008, 3 },
> +       [WIFI0_RADIO_COLD_RESET] = { 0x1f008, 2 },
> +       [WIFI0_CORE_WARM_RESET] = { 0x1f008, 1 },
> +       [WIFI0_CORE_COLD_RESET] = { 0x1f008, 0 },
> +       [WIFI1_CPU_INIT_RESET] = { 0x20008, 5 },
> +       [WIFI1_RADIO_SRIF_RESET] = { 0x20008, 4 },
> +       [WIFI1_RADIO_WARM_RESET] = { 0x20008, 3 },
> +       [WIFI1_RADIO_COLD_RESET] = { 0x20008, 2 },
> +       [WIFI1_CORE_WARM_RESET] = { 0x20008, 1 },
> +       [WIFI1_CORE_COLD_RESET] = { 0x20008, 0 },
> +       [USB3_UNIPHY_PHY_ARES] = { 0x1e038, 5 },
> +       [USB3_HSPHY_POR_ARES] = { 0x1e038, 4 },
> +       [USB3_HSPHY_S_ARES] = { 0x1e038, 2 },
> +       [USB2_HSPHY_POR_ARES] = { 0x1e01c, 4 },
> +       [USB2_HSPHY_S_ARES] = { 0x1e01c, 2 },
> +       [PCIE_PHY_AHB_ARES] = { 0x1d010, 11 },
> +       [PCIE_AHB_ARES] = { 0x1d010, 10 },
> +       [PCIE_PWR_ARES] = { 0x1d010, 9 },
> +       [PCIE_PIPE_STICKY_ARES] = { 0x1d010, 8 },
> +       [PCIE_AXI_M_STICKY_ARES] = { 0x1d010, 7 },
> +       [PCIE_PHY_ARES] = { 0x1d010, 6 },
> +       [PCIE_PARF_XPU_ARES] = { 0x1d010, 5 },
> +       [PCIE_AXI_S_XPU_ARES] = { 0x1d010, 4 },
> +       [PCIE_AXI_M_VMIDMT_ARES] = { 0x1d010, 3 },
> +       [PCIE_PIPE_ARES] = { 0x1d010, 2 },
> +       [PCIE_AXI_S_ARES] = { 0x1d010, 1 },
> +       [PCIE_AXI_M_ARES] = { 0x1d010, 0 },
> +       [ESS_RESET] = { 0x12008, 0},
> +       [GCC_BLSP1_BCR] = {0x01000, 0},
> +       [GCC_BLSP1_QUP1_BCR] = {0x02000, 0},
> +       [GCC_BLSP1_UART1_BCR] = {0x02038, 0},
> +       [GCC_BLSP1_QUP2_BCR] = {0x03008, 0},
> +       [GCC_BLSP1_UART2_BCR] = {0x03028, 0},
> +       [GCC_BIMC_BCR] = {0x04000, 0},
> +       [GCC_TLMM_BCR] = {0x05000, 0},
> +       [GCC_IMEM_BCR] = {0x0E000, 0},
> +       [GCC_ESS_BCR] = {0x12008, 0},
> +       [GCC_PRNG_BCR] = {0x13000, 0},
> +       [GCC_BOOT_ROM_BCR] = {0x13008, 0},
> +       [GCC_CRYPTO_BCR] = {0x16000, 0},
> +       [GCC_SDCC1_BCR] = {0x18000, 0},
> +       [GCC_SEC_CTRL_BCR] = {0x1A000, 0},
> +       [GCC_AUDIO_BCR] = {0x1B008, 0},
> +       [GCC_QPIC_BCR] = {0x1C000, 0},
> +       [GCC_PCIE_BCR] = {0x1D000, 0},
> +       [GCC_USB2_BCR] = {0x1E008, 0},
> +       [GCC_USB2_PHY_BCR] = {0x1E018, 0},
> +       [GCC_USB3_BCR] = {0x1E024, 0},
> +       [GCC_USB3_PHY_BCR] = {0x1E034, 0},
> +       [GCC_SYSTEM_NOC_BCR] = {0x21000, 0},
> +       [GCC_PCNOC_BCR] = {0x2102C, 0},
> +       [GCC_DCD_BCR] = {0x21038, 0},
> +       [GCC_SNOC_BUS_TIMEOUT0_BCR] = {0x21064, 0},
> +       [GCC_SNOC_BUS_TIMEOUT1_BCR] = {0x2106C, 0},
> +       [GCC_SNOC_BUS_TIMEOUT2_BCR] = {0x21074, 0},
> +       [GCC_SNOC_BUS_TIMEOUT3_BCR] = {0x2107C, 0},
> +       [GCC_PCNOC_BUS_TIMEOUT0_BCR] = {0x21084, 0},
> +       [GCC_PCNOC_BUS_TIMEOUT1_BCR] = {0x2108C, 0},
> +       [GCC_PCNOC_BUS_TIMEOUT2_BCR] = {0x21094, 0},
> +       [GCC_PCNOC_BUS_TIMEOUT3_BCR] = {0x2109C, 0},
> +       [GCC_PCNOC_BUS_TIMEOUT4_BCR] = {0x210A4, 0},
> +       [GCC_PCNOC_BUS_TIMEOUT5_BCR] = {0x210AC, 0},
> +       [GCC_PCNOC_BUS_TIMEOUT6_BCR] = {0x210B4, 0},
> +       [GCC_PCNOC_BUS_TIMEOUT7_BCR] = {0x210BC, 0},
> +       [GCC_PCNOC_BUS_TIMEOUT8_BCR] = {0x210C4, 0},
> +       [GCC_PCNOC_BUS_TIMEOUT9_BCR] = {0x210CC, 0},
> +       [GCC_TCSR_BCR] = {0x22000, 0},
> +       [GCC_MPM_BCR] = {0x24000, 0},
> +       [GCC_SPDM_BCR] = {0x25000, 0},
> +};
> +
> +static struct msm_clk_data ipq4019_data = {
> +       .resets = gcc_ipq4019_resets,
> +       .num_resets = ARRAY_SIZE(gcc_ipq4019_resets),
> +};
> +
> +static const struct udevice_id gcc_ipq4019_of_match[] = {
> +       {
> +               .compatible = "qcom,gcc-ipq4019",
> +               .data = (ulong)&ipq4019_data,
> +       },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(gcc_ipq4019) = {
> +       .name           = "gcc_ipq4019",
> +       .id             = UCLASS_NOP,
> +       .of_match       = gcc_ipq4019_of_match,
> +       .bind           = qcom_cc_bind,
> +       .flags          = DM_FLAG_PRE_RELOC,
> +};
> diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
> index 5914616fba5d..a661837e4e11 100644
> --- a/drivers/clk/qcom/clock-qcom.c
> +++ b/drivers/clk/qcom/clock-qcom.c
> @@ -1,8 +1,13 @@
> -// SPDX-License-Identifier: BSD-3-Clause
> +// SPDX-License-Identifier: BSD-3-Clause AND GPL-2.0
>  /*
> - * Clock drivers for Qualcomm APQ8016, APQ8096
> + * Clock and reset drivers for Qualcomm platforms Global Clock
> + * Controller (GCC).
>   *
>   * (C) Copyright 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
> + * (C) Copyright 2020 Sartura Ltd. (reset driver)
> + *     Author: Robert Marko <robert.marko@sartura.hr>
> + * (C) Copyright 2022 Linaro Ltd. (reset driver)
> + *     Author: Sumit Garg <sumit.garg@linaro.org>
>   *
>   * Based on Little Kernel driver, simplified
>   */
> @@ -10,9 +15,13 @@
>  #include <common.h>
>  #include <clk-uclass.h>
>  #include <dm.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> +#include <reset-uclass.h>
> +
>  #include "clock-qcom.h"
>
>  /* CBCR register fields */
> @@ -137,12 +146,15 @@ void clk_rcg_set_rate(phys_addr_t base, const struct bcr_regs *regs, int div,
>
>  static int msm_clk_probe(struct udevice *dev)
>  {
> +       struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(dev);
>         struct msm_clk_priv *priv = dev_get_priv(dev);
>
>         priv->base = dev_read_addr(dev);
>         if (priv->base == FDT_ADDR_T_NONE)
>                 return -EINVAL;
>
> +       priv->data = data;
> +
>         return 0;
>  }
>
> @@ -161,22 +173,97 @@ static struct clk_ops msm_clk_ops = {
>         .enable = msm_clk_enable,
>  };
>
> -static const struct udevice_id msm_clk_ids[] = {
> -       { .compatible = "qcom,gcc-msm8916" },
> -       { .compatible = "qcom,gcc-apq8016" },
> -       { .compatible = "qcom,gcc-msm8996" },
> -       { .compatible = "qcom,gcc-apq8096" },
> -       { .compatible = "qcom,gcc-ipq4019" },
> -       { .compatible = "qcom,gcc-sdm845" },
> -       { .compatible = "qcom,gcc-qcs404" },
> -       { }
> -};
> -
> -U_BOOT_DRIVER(clk_msm) = {
> -       .name           = "clk_msm",
> +U_BOOT_DRIVER(qcom_clk) = {
> +       .name           = "qcom_clk",
>         .id             = UCLASS_CLK,
> -       .of_match       = msm_clk_ids,
>         .ops            = &msm_clk_ops,
>         .priv_auto      = sizeof(struct msm_clk_priv),
>         .probe          = msm_clk_probe,
>  };
> +
> +int qcom_cc_bind(struct udevice *parent)
> +{
> +       struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(parent);
> +       struct udevice *clkdev, *rstdev;
> +       struct driver *drv;
> +       int ret;
> +
> +       /* Get a handle to the common clk handler */
> +       drv = lists_driver_lookup_name("qcom_clk");
> +       if (!drv)
> +               return -ENOENT;
> +
> +       /* Register the clock controller */
> +       ret = device_bind_with_driver_data(parent, drv, "qcom_clk", (ulong)data,
> +                                          dev_ofnode(parent), &clkdev);
> +       if (ret)
> +               return ret;
> +
> +       /* Bail out early if resets are not specified for this platform */
> +       if (!data->resets)
> +               return ret;
> +
> +       /* Get a handle to the common reset handler */
> +       drv = lists_driver_lookup_name("qcom_reset");
> +       if (!drv)
> +               return -ENOENT;
> +
> +       /* Register the reset controller */
> +       ret = device_bind_with_driver_data(parent, drv, "qcom_reset", (ulong)data,
> +                                          dev_ofnode(parent), &rstdev);
> +       if (ret)
> +               device_unbind(clkdev);
> +
> +       return ret;
> +}
> +
> +static int qcom_reset_set(struct reset_ctl *rst, bool assert)
> +{
> +       struct msm_clk_data *data = (struct msm_clk_data *)dev_get_driver_data(rst->dev);
> +       void __iomem *base = dev_get_priv(rst->dev);
> +       const struct qcom_reset_map *map;
> +       u32 value;
> +
> +       map = &data->resets[rst->id];
> +
> +       value = readl(base + map->reg);
> +
> +       if (assert)
> +               value |= BIT(map->bit);
> +       else
> +               value &= ~BIT(map->bit);
> +
> +       writel(value, base + map->reg);
> +
> +       return 0;
> +}
> +
> +static int qcom_reset_assert(struct reset_ctl *rst)
> +{
> +       return qcom_reset_set(rst, true);
> +}
> +
> +static int qcom_reset_deassert(struct reset_ctl *rst)
> +{
> +       return qcom_reset_set(rst, false);
> +}
> +
> +static const struct reset_ops qcom_reset_ops = {
> +       .rst_assert = qcom_reset_assert,
> +       .rst_deassert = qcom_reset_deassert,
> +};
> +
> +static int qcom_reset_probe(struct udevice *dev)
> +{
> +       /* Set our priv pointer to the base address */
> +       dev_set_priv(dev, (void *)dev_read_addr(dev));
> +
> +       return 0;
> +}
> +
> +U_BOOT_DRIVER(qcom_reset) = {
> +       .name = "qcom_reset",
> +       .id = UCLASS_RESET,
> +       .ops = &qcom_reset_ops,
> +       .probe = qcom_reset_probe,
> +};
> diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
> index c90bbefa5881..a9f895c2422e 100644
> --- a/drivers/clk/qcom/clock-qcom.h
> +++ b/drivers/clk/qcom/clock-qcom.h
> @@ -1,11 +1,9 @@
>  /* SPDX-License-Identifier: GPL-2.0+ */
>  /*
> - * Qualcomm APQ8016, APQ8096, SDM845
> - *
>   * (C) Copyright 2017 Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
>   */
> -#ifndef _CLOCK_SNAPDRAGON_H
> -#define _CLOCK_SNAPDRAGON_H
> +#ifndef _CLOCK_QCOM_H
> +#define _CLOCK_QCOM_H
>
>  #define CFG_CLK_SRC_CXO   (0 << 8)
>  #define CFG_CLK_SRC_GPLL0 (1 << 8)
> @@ -32,10 +30,22 @@ struct bcr_regs {
>         uintptr_t D;
>  };
>
> -struct msm_clk_priv {
> -       phys_addr_t base;
> +struct qcom_reset_map {
> +       unsigned int reg;
> +       u8 bit;
>  };
>
> +struct msm_clk_data {
> +       const struct qcom_reset_map     *resets;
> +       unsigned long                   num_resets;
> +};
> +
> +struct msm_clk_priv {
> +       phys_addr_t             base;
> +       struct msm_clk_data     *data;
> +};
> +
> +int qcom_cc_bind(struct udevice *parent);
>  void clk_enable_gpll0(phys_addr_t base, const struct pll_vote_clk *gpll0);
>  void clk_bcr_update(phys_addr_t apps_cmd_rgcr);
>  void clk_enable_cbc(phys_addr_t cbcr);
> diff --git a/drivers/clk/qcom/clock-qcs404.c b/drivers/clk/qcom/clock-qcs404.c
> index 80218af73ef6..10ac3609be42 100644
> --- a/drivers/clk/qcom/clock-qcs404.c
> +++ b/drivers/clk/qcom/clock-qcs404.c
> @@ -11,9 +11,10 @@
>  #include <errno.h>
>  #include <asm/io.h>
>  #include <linux/bitops.h>
> +#include <dt-bindings/clock/qcom,gcc-qcs404.h>
> +
>  #include "clock-qcom.h"
>
> -#include <dt-bindings/clock/qcom,gcc-qcs404.h>
>
>  /* GPLL0 clock control registers */
>  #define GPLL0_STATUS_ACTIVE BIT(31)
> @@ -235,3 +236,50 @@ int msm_enable(struct clk *clk)
>
>         return 0;
>  }
> +
> +static const struct qcom_reset_map qcs404_gcc_resets[] = {
> +       [GCC_GENI_IR_BCR] = { 0x0F000 },
> +       [GCC_CDSP_RESTART] = { 0x18000 },
> +       [GCC_USB_HS_BCR] = { 0x41000 },
> +       [GCC_USB2_HS_PHY_ONLY_BCR] = { 0x41034 },
> +       [GCC_QUSB2_PHY_BCR] = { 0x4103c },
> +       [GCC_USB_HS_PHY_CFG_AHB_BCR] = { 0x0000c, 1 },
> +       [GCC_USB2A_PHY_BCR] = { 0x0000c, 0 },
> +       [GCC_USB3_PHY_BCR] = { 0x39004 },
> +       [GCC_USB_30_BCR] = { 0x39000 },
> +       [GCC_USB3PHY_PHY_BCR] = { 0x39008 },
> +       [GCC_PCIE_0_BCR] = { 0x3e000 },
> +       [GCC_PCIE_0_PHY_BCR] = { 0x3e004 },
> +       [GCC_PCIE_0_LINK_DOWN_BCR] = { 0x3e038 },
> +       [GCC_PCIEPHY_0_PHY_BCR] = { 0x3e03c },
> +       [GCC_PCIE_0_AXI_MASTER_STICKY_ARES] = { 0x3e040, 6},
> +       [GCC_PCIE_0_AHB_ARES] = { 0x3e040, 5 },
> +       [GCC_PCIE_0_AXI_SLAVE_ARES] = { 0x3e040, 4 },
> +       [GCC_PCIE_0_AXI_MASTER_ARES] = { 0x3e040, 3 },
> +       [GCC_PCIE_0_CORE_STICKY_ARES] = { 0x3e040, 2 },
> +       [GCC_PCIE_0_SLEEP_ARES] = { 0x3e040, 1 },
> +       [GCC_PCIE_0_PIPE_ARES] = { 0x3e040, 0 },
> +       [GCC_EMAC_BCR] = { 0x4e000 },
> +       [GCC_WDSP_RESTART] = {0x19000},
> +};
> +
> +static const struct msm_clk_data qcs404_gcc_data = {
> +       .resets = qcs404_gcc_resets,
> +       .num_resets = ARRAY_SIZE(qcs404_gcc_resets),
> +};
> +
> +static const struct udevice_id gcc_qcs404_of_match[] = {
> +       {
> +               .compatible = "qcom,gcc-qcs404",
> +               .data = (ulong)&qcs404_gcc_data
> +       },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(gcc_qcs404) = {
> +       .name           = "gcc_qcs404",
> +       .id             = UCLASS_NOP,
> +       .of_match       = gcc_qcs404_of_match,
> +       .bind           = qcom_cc_bind,
> +       .flags          = DM_FLAG_PRE_RELOC,
> +};
> diff --git a/drivers/clk/qcom/clock-sdm845.c b/drivers/clk/qcom/clock-sdm845.c
> index 95a057b82986..a7a43f69b9b3 100644
> --- a/drivers/clk/qcom/clock-sdm845.c
> +++ b/drivers/clk/qcom/clock-sdm845.c
> @@ -15,6 +15,7 @@
>  #include <asm/io.h>
>  #include <linux/bitops.h>
>  #include <dt-bindings/clock/qcom,gcc-sdm845.h>
> +
>  #include "clock-qcom.h"
>
>  #define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
> @@ -96,3 +97,44 @@ int msm_enable(struct clk *clk)
>  {
>         return 0;
>  }
> +
> +static const struct qcom_reset_map sdm845_gcc_resets[] = {
> +       [GCC_QUPV3_WRAPPER_0_BCR] = { 0x17000 },
> +       [GCC_QUPV3_WRAPPER_1_BCR] = { 0x18000 },
> +       [GCC_QUSB2PHY_PRIM_BCR] = { 0x12000 },
> +       [GCC_QUSB2PHY_SEC_BCR] = { 0x12004 },
> +       [GCC_SDCC2_BCR] = { 0x14000 },
> +       [GCC_SDCC4_BCR] = { 0x16000 },
> +       [GCC_UFS_CARD_BCR] = { 0x75000 },
> +       [GCC_UFS_PHY_BCR] = { 0x77000 },
> +       [GCC_USB30_PRIM_BCR] = { 0xf000 },
> +       [GCC_USB30_SEC_BCR] = { 0x10000 },
> +       [GCC_USB3_PHY_PRIM_BCR] = { 0x50000 },
> +       [GCC_USB3PHY_PHY_PRIM_BCR] = { 0x50004 },
> +       [GCC_USB3_DP_PHY_PRIM_BCR] = { 0x50008 },
> +       [GCC_USB3_PHY_SEC_BCR] = { 0x5000c },
> +       [GCC_USB3PHY_PHY_SEC_BCR] = { 0x50010 },
> +       [GCC_USB3_DP_PHY_SEC_BCR] = { 0x50014 },
> +       [GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0x6a000 },
> +};
> +
> +static const struct msm_clk_data qcs404_gcc_data = {
> +       .resets = sdm845_gcc_resets,
> +       .num_resets = ARRAY_SIZE(sdm845_gcc_resets),
> +};
> +
> +static const struct udevice_id gcc_sdm845_of_match[] = {
> +       {
> +               .compatible = "qcom,gcc-sdm845",
> +               .data = (ulong)&qcs404_gcc_data,
> +       },
> +       { }
> +};
> +
> +U_BOOT_DRIVER(gcc_sdm845) = {
> +       .name           = "gcc_sdm845",
> +       .id             = UCLASS_NOP,
> +       .of_match       = gcc_sdm845_of_match,
> +       .bind           = qcom_cc_bind,
> +       .flags          = DM_FLAG_PRE_RELOC,
> +};
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 73bbd3069258..88e04d93f2a0 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -156,13 +156,6 @@ config RESET_IMX7
>         help
>           Support for reset controller on i.MX7/8 SoCs.
>
> -config RESET_QCOM
> -       bool "Reset driver for Qualcomm SoCs"
> -       depends on DM_RESET && (ARCH_SNAPDRAGON || ARCH_IPQ40XX)
> -       default y
> -       help
> -         Support for reset controller on Qualcomm SoCs.
> -
>  config RESET_SIFIVE
>         bool "Reset Driver for SiFive SoC's"
>         depends on DM_RESET && CLK_SIFIVE_PRCI && (TARGET_SIFIVE_UNLEASHED || TARGET_SIFIVE_UNMATCHED)
> diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
> index e2239a250a3a..7b0066f80188 100644
> --- a/drivers/reset/Makefile
> +++ b/drivers/reset/Makefile
> @@ -24,7 +24,6 @@ obj-$(CONFIG_RESET_MTMIPS) += reset-mtmips.o
>  obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
>  obj-$(CONFIG_RESET_HISILICON) += reset-hisilicon.o
>  obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
> -obj-$(CONFIG_RESET_QCOM) += reset-qcom.o
>  obj-$(CONFIG_RESET_SIFIVE) += reset-sifive.o
>  obj-$(CONFIG_RESET_SYSCON) += reset-syscon.o
>  obj-$(CONFIG_RESET_RASPBERRYPI) += reset-raspberrypi.o
> diff --git a/drivers/reset/reset-qcom.c b/drivers/reset/reset-qcom.c
> deleted file mode 100644
> index 94315e76d545..000000000000
> --- a/drivers/reset/reset-qcom.c
> +++ /dev/null
> @@ -1,195 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2020 Sartura Ltd.
> - * Copyright (c) 2022 Linaro Ltd.
> - *
> - * Author: Robert Marko <robert.marko@sartura.hr>
> - *         Sumit Garg <sumit.garg@linaro.org>
> - *
> - * Based on Linux driver
> - */
> -
> -#include <asm/io.h>
> -#include <common.h>
> -#include <dm.h>
> -#include <reset-uclass.h>
> -#include <linux/bitops.h>
> -#include <malloc.h>
> -
> -struct qcom_reset_priv {
> -       phys_addr_t base;
> -};
> -
> -struct qcom_reset_map {
> -       unsigned int reg;
> -       u8 bit;
> -};
> -
> -#ifdef CONFIG_ARCH_IPQ40XX
> -#include <dt-bindings/reset/qcom,ipq4019-reset.h>
> -static const struct qcom_reset_map gcc_qcom_resets[] = {
> -       [WIFI0_CPU_INIT_RESET] = { 0x1f008, 5 },
> -       [WIFI0_RADIO_SRIF_RESET] = { 0x1f008, 4 },
> -       [WIFI0_RADIO_WARM_RESET] = { 0x1f008, 3 },
> -       [WIFI0_RADIO_COLD_RESET] = { 0x1f008, 2 },
> -       [WIFI0_CORE_WARM_RESET] = { 0x1f008, 1 },
> -       [WIFI0_CORE_COLD_RESET] = { 0x1f008, 0 },
> -       [WIFI1_CPU_INIT_RESET] = { 0x20008, 5 },
> -       [WIFI1_RADIO_SRIF_RESET] = { 0x20008, 4 },
> -       [WIFI1_RADIO_WARM_RESET] = { 0x20008, 3 },
> -       [WIFI1_RADIO_COLD_RESET] = { 0x20008, 2 },
> -       [WIFI1_CORE_WARM_RESET] = { 0x20008, 1 },
> -       [WIFI1_CORE_COLD_RESET] = { 0x20008, 0 },
> -       [USB3_UNIPHY_PHY_ARES] = { 0x1e038, 5 },
> -       [USB3_HSPHY_POR_ARES] = { 0x1e038, 4 },
> -       [USB3_HSPHY_S_ARES] = { 0x1e038, 2 },
> -       [USB2_HSPHY_POR_ARES] = { 0x1e01c, 4 },
> -       [USB2_HSPHY_S_ARES] = { 0x1e01c, 2 },
> -       [PCIE_PHY_AHB_ARES] = { 0x1d010, 11 },
> -       [PCIE_AHB_ARES] = { 0x1d010, 10 },
> -       [PCIE_PWR_ARES] = { 0x1d010, 9 },
> -       [PCIE_PIPE_STICKY_ARES] = { 0x1d010, 8 },
> -       [PCIE_AXI_M_STICKY_ARES] = { 0x1d010, 7 },
> -       [PCIE_PHY_ARES] = { 0x1d010, 6 },
> -       [PCIE_PARF_XPU_ARES] = { 0x1d010, 5 },
> -       [PCIE_AXI_S_XPU_ARES] = { 0x1d010, 4 },
> -       [PCIE_AXI_M_VMIDMT_ARES] = { 0x1d010, 3 },
> -       [PCIE_PIPE_ARES] = { 0x1d010, 2 },
> -       [PCIE_AXI_S_ARES] = { 0x1d010, 1 },
> -       [PCIE_AXI_M_ARES] = { 0x1d010, 0 },
> -       [ESS_RESET] = { 0x12008, 0},
> -       [GCC_BLSP1_BCR] = {0x01000, 0},
> -       [GCC_BLSP1_QUP1_BCR] = {0x02000, 0},
> -       [GCC_BLSP1_UART1_BCR] = {0x02038, 0},
> -       [GCC_BLSP1_QUP2_BCR] = {0x03008, 0},
> -       [GCC_BLSP1_UART2_BCR] = {0x03028, 0},
> -       [GCC_BIMC_BCR] = {0x04000, 0},
> -       [GCC_TLMM_BCR] = {0x05000, 0},
> -       [GCC_IMEM_BCR] = {0x0E000, 0},
> -       [GCC_ESS_BCR] = {0x12008, 0},
> -       [GCC_PRNG_BCR] = {0x13000, 0},
> -       [GCC_BOOT_ROM_BCR] = {0x13008, 0},
> -       [GCC_CRYPTO_BCR] = {0x16000, 0},
> -       [GCC_SDCC1_BCR] = {0x18000, 0},
> -       [GCC_SEC_CTRL_BCR] = {0x1A000, 0},
> -       [GCC_AUDIO_BCR] = {0x1B008, 0},
> -       [GCC_QPIC_BCR] = {0x1C000, 0},
> -       [GCC_PCIE_BCR] = {0x1D000, 0},
> -       [GCC_USB2_BCR] = {0x1E008, 0},
> -       [GCC_USB2_PHY_BCR] = {0x1E018, 0},
> -       [GCC_USB3_BCR] = {0x1E024, 0},
> -       [GCC_USB3_PHY_BCR] = {0x1E034, 0},
> -       [GCC_SYSTEM_NOC_BCR] = {0x21000, 0},
> -       [GCC_PCNOC_BCR] = {0x2102C, 0},
> -       [GCC_DCD_BCR] = {0x21038, 0},
> -       [GCC_SNOC_BUS_TIMEOUT0_BCR] = {0x21064, 0},
> -       [GCC_SNOC_BUS_TIMEOUT1_BCR] = {0x2106C, 0},
> -       [GCC_SNOC_BUS_TIMEOUT2_BCR] = {0x21074, 0},
> -       [GCC_SNOC_BUS_TIMEOUT3_BCR] = {0x2107C, 0},
> -       [GCC_PCNOC_BUS_TIMEOUT0_BCR] = {0x21084, 0},
> -       [GCC_PCNOC_BUS_TIMEOUT1_BCR] = {0x2108C, 0},
> -       [GCC_PCNOC_BUS_TIMEOUT2_BCR] = {0x21094, 0},
> -       [GCC_PCNOC_BUS_TIMEOUT3_BCR] = {0x2109C, 0},
> -       [GCC_PCNOC_BUS_TIMEOUT4_BCR] = {0x210A4, 0},
> -       [GCC_PCNOC_BUS_TIMEOUT5_BCR] = {0x210AC, 0},
> -       [GCC_PCNOC_BUS_TIMEOUT6_BCR] = {0x210B4, 0},
> -       [GCC_PCNOC_BUS_TIMEOUT7_BCR] = {0x210BC, 0},
> -       [GCC_PCNOC_BUS_TIMEOUT8_BCR] = {0x210C4, 0},
> -       [GCC_PCNOC_BUS_TIMEOUT9_BCR] = {0x210CC, 0},
> -       [GCC_TCSR_BCR] = {0x22000, 0},
> -       [GCC_MPM_BCR] = {0x24000, 0},
> -       [GCC_SPDM_BCR] = {0x25000, 0},
> -};
> -#endif
> -
> -#ifdef CONFIG_TARGET_QCS404EVB
> -#include <dt-bindings/clock/qcom,gcc-qcs404.h>
> -static const struct qcom_reset_map gcc_qcom_resets[] = {
> -       [GCC_GENI_IR_BCR] = { 0x0F000 },
> -       [GCC_CDSP_RESTART] = { 0x18000 },
> -       [GCC_USB_HS_BCR] = { 0x41000 },
> -       [GCC_USB2_HS_PHY_ONLY_BCR] = { 0x41034 },
> -       [GCC_QUSB2_PHY_BCR] = { 0x4103c },
> -       [GCC_USB_HS_PHY_CFG_AHB_BCR] = { 0x0000c, 1 },
> -       [GCC_USB2A_PHY_BCR] = { 0x0000c, 0 },
> -       [GCC_USB3_PHY_BCR] = { 0x39004 },
> -       [GCC_USB_30_BCR] = { 0x39000 },
> -       [GCC_USB3PHY_PHY_BCR] = { 0x39008 },
> -       [GCC_PCIE_0_BCR] = { 0x3e000 },
> -       [GCC_PCIE_0_PHY_BCR] = { 0x3e004 },
> -       [GCC_PCIE_0_LINK_DOWN_BCR] = { 0x3e038 },
> -       [GCC_PCIEPHY_0_PHY_BCR] = { 0x3e03c },
> -       [GCC_PCIE_0_AXI_MASTER_STICKY_ARES] = { 0x3e040, 6},
> -       [GCC_PCIE_0_AHB_ARES] = { 0x3e040, 5 },
> -       [GCC_PCIE_0_AXI_SLAVE_ARES] = { 0x3e040, 4 },
> -       [GCC_PCIE_0_AXI_MASTER_ARES] = { 0x3e040, 3 },
> -       [GCC_PCIE_0_CORE_STICKY_ARES] = { 0x3e040, 2 },
> -       [GCC_PCIE_0_SLEEP_ARES] = { 0x3e040, 1 },
> -       [GCC_PCIE_0_PIPE_ARES] = { 0x3e040, 0 },
> -       [GCC_EMAC_BCR] = { 0x4e000 },
> -       [GCC_WDSP_RESTART] = {0x19000},
> -};
> -#endif
> -
> -static int qcom_reset_assert(struct reset_ctl *rst)
> -{
> -       struct qcom_reset_priv *priv = dev_get_priv(rst->dev);
> -       const struct qcom_reset_map *reset_map = gcc_qcom_resets;
> -       const struct qcom_reset_map *map;
> -       u32 value;
> -
> -       map = &reset_map[rst->id];
> -
> -       value = readl(priv->base + map->reg);
> -       value |= BIT(map->bit);
> -       writel(value, priv->base + map->reg);
> -
> -       return 0;
> -}
> -
> -static int qcom_reset_deassert(struct reset_ctl *rst)
> -{
> -       struct qcom_reset_priv *priv = dev_get_priv(rst->dev);
> -       const struct qcom_reset_map *reset_map = gcc_qcom_resets;
> -       const struct qcom_reset_map *map;
> -       u32 value;
> -
> -       map = &reset_map[rst->id];
> -
> -       value = readl(priv->base + map->reg);
> -       value &= ~BIT(map->bit);
> -       writel(value, priv->base + map->reg);
> -
> -       return 0;
> -}
> -
> -static const struct reset_ops qcom_reset_ops = {
> -       .rst_assert = qcom_reset_assert,
> -       .rst_deassert = qcom_reset_deassert,
> -};
> -
> -static const struct udevice_id qcom_reset_ids[] = {
> -       { .compatible = "qcom,gcc-reset-ipq4019" },
> -       { .compatible = "qcom,gcc-reset-qcs404" },
> -       { }
> -};
> -
> -static int qcom_reset_probe(struct udevice *dev)
> -{
> -       struct qcom_reset_priv *priv = dev_get_priv(dev);
> -
> -       priv->base = dev_read_addr(dev);
> -       if (priv->base == FDT_ADDR_T_NONE)
> -               return -EINVAL;
> -
> -       return 0;
> -}
> -
> -U_BOOT_DRIVER(qcom_reset) = {
> -       .name = "qcom_reset",
> -       .id = UCLASS_RESET,
> -       .of_match = qcom_reset_ids,
> -       .ops = &qcom_reset_ops,
> -       .probe = qcom_reset_probe,
> -       .priv_auto = sizeof(struct qcom_reset_priv),
> -};
> diff --git a/include/dt-bindings/clock/qcom,ipq4019-gcc.h b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
> similarity index 58%
> rename from include/dt-bindings/clock/qcom,ipq4019-gcc.h
> rename to include/dt-bindings/clock/qcom,gcc-ipq4019.h
> index 7130e222e41c..7e8a7be6dcda 100644
> --- a/include/dt-bindings/clock/qcom,ipq4019-gcc.h
> +++ b/include/dt-bindings/clock/qcom,gcc-ipq4019.h
> @@ -93,4 +93,77 @@
>  #define GCC_APSS_CPU_PLLDIV_CLK                                74
>  #define GCC_PCNOC_AHB_CLK_SRC                          75
>
> +#define WIFI0_CPU_INIT_RESET                           0
> +#define WIFI0_RADIO_SRIF_RESET                         1
> +#define WIFI0_RADIO_WARM_RESET                         2
> +#define WIFI0_RADIO_COLD_RESET                         3
> +#define WIFI0_CORE_WARM_RESET                          4
> +#define WIFI0_CORE_COLD_RESET                          5
> +#define WIFI1_CPU_INIT_RESET                           6
> +#define WIFI1_RADIO_SRIF_RESET                         7
> +#define WIFI1_RADIO_WARM_RESET                         8
> +#define WIFI1_RADIO_COLD_RESET                         9
> +#define WIFI1_CORE_WARM_RESET                          10
> +#define WIFI1_CORE_COLD_RESET                          11
> +#define USB3_UNIPHY_PHY_ARES                           12
> +#define USB3_HSPHY_POR_ARES                            13
> +#define USB3_HSPHY_S_ARES                              14
> +#define USB2_HSPHY_POR_ARES                            15
> +#define USB2_HSPHY_S_ARES                              16
> +#define PCIE_PHY_AHB_ARES                              17
> +#define PCIE_AHB_ARES                                  18
> +#define PCIE_PWR_ARES                                  19
> +#define PCIE_PIPE_STICKY_ARES                          20
> +#define PCIE_AXI_M_STICKY_ARES                         21
> +#define PCIE_PHY_ARES                                  22
> +#define PCIE_PARF_XPU_ARES                             23
> +#define PCIE_AXI_S_XPU_ARES                            24
> +#define PCIE_AXI_M_VMIDMT_ARES                         25
> +#define PCIE_PIPE_ARES                                 26
> +#define PCIE_AXI_S_ARES                                        27
> +#define PCIE_AXI_M_ARES                                        28
> +#define ESS_RESET                                      29
> +#define GCC_BLSP1_BCR                                  30
> +#define GCC_BLSP1_QUP1_BCR                             31
> +#define GCC_BLSP1_UART1_BCR                            32
> +#define GCC_BLSP1_QUP2_BCR                             33
> +#define GCC_BLSP1_UART2_BCR                            34
> +#define GCC_BIMC_BCR                                   35
> +#define GCC_TLMM_BCR                                   36
> +#define GCC_IMEM_BCR                                   37
> +#define GCC_ESS_BCR                                    38
> +#define GCC_PRNG_BCR                                   39
> +#define GCC_BOOT_ROM_BCR                               40
> +#define GCC_CRYPTO_BCR                                 41
> +#define GCC_SDCC1_BCR                                  42
> +#define GCC_SEC_CTRL_BCR                               43
> +#define GCC_AUDIO_BCR                                  44
> +#define GCC_QPIC_BCR                                   45
> +#define GCC_PCIE_BCR                                   46
> +#define GCC_USB2_BCR                                   47
> +#define GCC_USB2_PHY_BCR                               48
> +#define GCC_USB3_BCR                                   49
> +#define GCC_USB3_PHY_BCR                               50
> +#define GCC_SYSTEM_NOC_BCR                             51
> +#define GCC_PCNOC_BCR                                  52
> +#define GCC_DCD_BCR                                    53
> +#define GCC_SNOC_BUS_TIMEOUT0_BCR                      54
> +#define GCC_SNOC_BUS_TIMEOUT1_BCR                      55
> +#define GCC_SNOC_BUS_TIMEOUT2_BCR                      56
> +#define GCC_SNOC_BUS_TIMEOUT3_BCR                      57
> +#define GCC_PCNOC_BUS_TIMEOUT0_BCR                     58
> +#define GCC_PCNOC_BUS_TIMEOUT1_BCR                     59
> +#define GCC_PCNOC_BUS_TIMEOUT2_BCR                     60
> +#define GCC_PCNOC_BUS_TIMEOUT3_BCR                     61
> +#define GCC_PCNOC_BUS_TIMEOUT4_BCR                     62
> +#define GCC_PCNOC_BUS_TIMEOUT5_BCR                     63
> +#define GCC_PCNOC_BUS_TIMEOUT6_BCR                     64
> +#define GCC_PCNOC_BUS_TIMEOUT7_BCR                     65
> +#define GCC_PCNOC_BUS_TIMEOUT8_BCR                     66
> +#define GCC_PCNOC_BUS_TIMEOUT9_BCR                     67
> +#define GCC_TCSR_BCR                                   68
> +#define GCC_QDSS_BCR                                   69
> +#define GCC_MPM_BCR                                    70
> +#define GCC_SPDM_BCR                                   71
> +
>  #endif
> diff --git a/include/dt-bindings/reset/qcom,ipq4019-reset.h b/include/dt-bindings/reset/qcom,ipq4019-reset.h
> deleted file mode 100644
> index ed047d7402df..000000000000
> --- a/include/dt-bindings/reset/qcom,ipq4019-reset.h
> +++ /dev/null
> @@ -1,92 +0,0 @@
> -/* Copyright (c) 2015 The Linux Foundation. All rights reserved.
> - *
> - * Permission to use, copy, modify, and/or distribute this software for any
> - * purpose with or without fee is hereby granted, provided that the above
> - * copyright notice and this permission notice appear in all copies.
> - *
> - * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
> - * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> - * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
> - * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
> - * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> - * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
> - * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> - *
> - */
> -#ifndef __QCOM_RESET_IPQ4019_H__
> -#define __QCOM_RESET_IPQ4019_H__
> -
> -#define WIFI0_CPU_INIT_RESET                           0
> -#define WIFI0_RADIO_SRIF_RESET                         1
> -#define WIFI0_RADIO_WARM_RESET                         2
> -#define WIFI0_RADIO_COLD_RESET                         3
> -#define WIFI0_CORE_WARM_RESET                          4
> -#define WIFI0_CORE_COLD_RESET                          5
> -#define WIFI1_CPU_INIT_RESET                           6
> -#define WIFI1_RADIO_SRIF_RESET                         7
> -#define WIFI1_RADIO_WARM_RESET                         8
> -#define WIFI1_RADIO_COLD_RESET                         9
> -#define WIFI1_CORE_WARM_RESET                          10
> -#define WIFI1_CORE_COLD_RESET                          11
> -#define USB3_UNIPHY_PHY_ARES                           12
> -#define USB3_HSPHY_POR_ARES                            13
> -#define USB3_HSPHY_S_ARES                              14
> -#define USB2_HSPHY_POR_ARES                            15
> -#define USB2_HSPHY_S_ARES                              16
> -#define PCIE_PHY_AHB_ARES                              17
> -#define PCIE_AHB_ARES                                  18
> -#define PCIE_PWR_ARES                                  19
> -#define PCIE_PIPE_STICKY_ARES                          20
> -#define PCIE_AXI_M_STICKY_ARES                         21
> -#define PCIE_PHY_ARES                                  22
> -#define PCIE_PARF_XPU_ARES                             23
> -#define PCIE_AXI_S_XPU_ARES                            24
> -#define PCIE_AXI_M_VMIDMT_ARES                         25
> -#define PCIE_PIPE_ARES                                 26
> -#define PCIE_AXI_S_ARES                                        27
> -#define PCIE_AXI_M_ARES                                        28
> -#define ESS_RESET                                      29
> -#define GCC_BLSP1_BCR                                  30
> -#define GCC_BLSP1_QUP1_BCR                             31
> -#define GCC_BLSP1_UART1_BCR                            32
> -#define GCC_BLSP1_QUP2_BCR                             33
> -#define GCC_BLSP1_UART2_BCR                            34
> -#define GCC_BIMC_BCR                                   35
> -#define GCC_TLMM_BCR                                   36
> -#define GCC_IMEM_BCR                                   37
> -#define GCC_ESS_BCR                                    38
> -#define GCC_PRNG_BCR                                   39
> -#define GCC_BOOT_ROM_BCR                               40
> -#define GCC_CRYPTO_BCR                                 41
> -#define GCC_SDCC1_BCR                                  42
> -#define GCC_SEC_CTRL_BCR                               43
> -#define GCC_AUDIO_BCR                                  44
> -#define GCC_QPIC_BCR                                   45
> -#define GCC_PCIE_BCR                                   46
> -#define GCC_USB2_BCR                                   47
> -#define GCC_USB2_PHY_BCR                               48
> -#define GCC_USB3_BCR                                   49
> -#define GCC_USB3_PHY_BCR                               50
> -#define GCC_SYSTEM_NOC_BCR                             51
> -#define GCC_PCNOC_BCR                                  52
> -#define GCC_DCD_BCR                                    53
> -#define GCC_SNOC_BUS_TIMEOUT0_BCR                      54
> -#define GCC_SNOC_BUS_TIMEOUT1_BCR                      55
> -#define GCC_SNOC_BUS_TIMEOUT2_BCR                      56
> -#define GCC_SNOC_BUS_TIMEOUT3_BCR                      57
> -#define GCC_PCNOC_BUS_TIMEOUT0_BCR                     58
> -#define GCC_PCNOC_BUS_TIMEOUT1_BCR                     59
> -#define GCC_PCNOC_BUS_TIMEOUT2_BCR                     60
> -#define GCC_PCNOC_BUS_TIMEOUT3_BCR                     61
> -#define GCC_PCNOC_BUS_TIMEOUT4_BCR                     62
> -#define GCC_PCNOC_BUS_TIMEOUT5_BCR                     63
> -#define GCC_PCNOC_BUS_TIMEOUT6_BCR                     64
> -#define GCC_PCNOC_BUS_TIMEOUT7_BCR                     65
> -#define GCC_PCNOC_BUS_TIMEOUT8_BCR                     66
> -#define GCC_PCNOC_BUS_TIMEOUT9_BCR                     67
> -#define GCC_TCSR_BCR                                   68
> -#define GCC_QDSS_BCR                                   69
> -#define GCC_MPM_BCR                                    70
> -#define GCC_SPDM_BCR                                   71
> -
> -#endif
>
> --
> 2.42.0
>
