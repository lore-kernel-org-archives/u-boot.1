Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CABC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 05:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C84F8880A6;
	Wed, 20 Mar 2024 06:21:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kTDXUdCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2BE0869F7; Wed, 20 Mar 2024 06:21:54 +0100 (CET)
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com
 [IPv6:2607:f8b0:4864:20::e29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4335A880A6
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:21:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe29.google.com with SMTP id
 ada2fe7eead31-47679c2815aso1216761137.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710912111; x=1711516911; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Mx/aMoRW58CnsSBVr5pEmoiw/U+OvRBSvE3r9jAm+o=;
 b=kTDXUdCSoVbnsY1oFuXVArQ/NGQLypzARMiwisXRUYO59yblCBqB9mx49AOQ0uX3+n
 CkhBe5+NANxijXPcBBJ25FhNZY+6OdwxjZTT9RYiksh1NxnhSLsB8dqzt6tqSVZlIP8L
 ZcU/Ek6pKLzYelsu/TWvYrsV1D91zvRC0hp3grXJgsPTDkXxkyP59S7KygV6/L1JRANL
 JBC1gJqAO/8smkSzidP9WBBMzcGp7ftsXtmb3wwDT33LPwYAZvtriS876qsHNh/gE0CM
 /s/i6uQIpue/0b4NJQh+fl5MH15lODZVQ/oBwxcSrwCeYtxtNqgvM+Pz05EXyp03ZwOb
 M3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710912111; x=1711516911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Mx/aMoRW58CnsSBVr5pEmoiw/U+OvRBSvE3r9jAm+o=;
 b=VGx1rK/+wjjGzXA+P/x0DecYL5i45tYa/X56qV0oBLSSJ3/+AwlamGjAswUikOLIhm
 bSGHAqlE3/eaHzQKKUwrl79/569w+e/iXwOovdJEL0+jCqa8Ip8YX/D8mPLOS0jBUKEB
 r/iKO5cZu8H/CJGi3o8xjiRoxOjJgEnwfe2kaEWxwO3LvsKEB+hf/GUPWVQxnBVRKwH7
 yp9fa3Ak1WkYFVWnzUuozmEf27dlmv63iuxaY05W1bCe35RkBxaxjUBHdGhKUXvagVzQ
 1bwTWf8t8LNc+Z4cN0eWRNrIzeEukGVOyjHRMYMKbgvOWpEDaUe0rzrwcz3HdeG4KH5Z
 SNcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOK3Z9w7Yo5zbVMd/OoDdsSAPs3h+hQddUHQ749sl1PhpfxBrUK82DzqzwkgPUtxu8D5q1R8XYgvJM7S9rWXZn0nxUGg==
X-Gm-Message-State: AOJu0YxOoURdkGH+ZFjiVEMlUNwqbXhD4wuhdGI8e45Bf/zrRtVnoB2T
 J3A8QtXP1X2/Gs4dopQSlgmqLwTWh2D6pY3lYXh2raA0eYHMGySX/Hu7gMCGolpmgeGjgU+aO8w
 eADxveqjTFvAKwcVrBxbZ++J1NCzbQUEzt13efQ==
X-Google-Smtp-Source: AGHT+IFnQz3c/fBY6onnx1lv9d6vxoRJCZe0iVoXX2tGIyGexWPwznzH4mfEjeJvIZJP6X4jB0fzd2v7sRZ+ky0VDnc=
X-Received: by 2002:a05:6102:ce:b0:476:9ff0:90b0 with SMTP id
 u14-20020a05610200ce00b004769ff090b0mr970468vsp.13.1710912111065; Tue, 19 Mar
 2024 22:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-2-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-2-e1b38d9b4fa4@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2024 10:51:39 +0530
Message-ID: <CAFA6WYOF44dKAQouFN3Z8h86CuRJ9unp2m9dSA52cMvaF0UCjQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] phy: qcom: add Qualcomm QUSB2 USB PHY driver
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>
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

On Tue, 19 Mar 2024 at 17:52, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> From: Bhupesh Sharma <bhupesh.linux@gmail.com>
>
> The Snapdragon 845 and several other Qualcomm SoCs feature this
> USB high-speed phy. Add a driver for it based on the Linux driver, with
> support for the SDM845, and the QCM2290 and SM6115 SoCs which will gain
> support in U-Boot in future patches.
>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> [code cleanup, switch to clk_bulk]
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/phy/qcom/Kconfig          |   7 +
>  drivers/phy/qcom/Makefile         |   1 +
>  drivers/phy/qcom/phy-qcom-qusb2.c | 468 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 476 insertions(+)
>
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index f4ca174805a4..361dfb6e1126 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -11,8 +11,15 @@ config PHY_QCOM_IPQ4019_USB
>         depends on PHY && ARCH_IPQ40XX
>         help
>           Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
>
> +config PHY_QCOM_QUSB2
> +       tristate "Qualcomm USB QUSB2 PHY driver"
> +       depends on PHY && ARCH_SNAPDRAGON
> +       help
> +         Enable this to support the Super-Speed USB transceiver on various
> +         Qualcomm chipsets.
> +
>  config PHY_QCOM_USB_HS_28NM
>         tristate "Qualcomm 28nm High-Speed PHY"
>         depends on PHY && ARCH_SNAPDRAGON
>         help
> diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
> index 2113f178c0c7..f6af985666a4 100644
> --- a/drivers/phy/qcom/Makefile
> +++ b/drivers/phy/qcom/Makefile
> @@ -1,4 +1,5 @@
>  obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
>  obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
> +obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
>  obj-$(CONFIG_PHY_QCOM_USB_HS_28NM) += phy-qcom-usb-hs-28nm.o
>  obj-$(CONFIG_PHY_QCOM_USB_SS) += phy-qcom-usb-ss.o
> diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
> new file mode 100644
> index 000000000000..5b654403a181
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-qusb2.c
> @@ -0,0 +1,468 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Bhupesh Sharma <bhupesh.sharma@linaro.org>
> + *
> + * Based on Linux driver
> + */
> +
> +#include <dm.h>
> +#include <generic-phy.h>
> +#include <linux/bitops.h>
> +#include <asm/io.h>
> +#include <reset.h>
> +#include <clk.h>
> +#include <linux/delay.h>
> +
> +#include <dt-bindings/phy/phy-qcom-qusb2.h>
> +
> +#define QUSB2PHY_PLL 0x0
> +#define QUSB2PHY_PLL_TEST 0x04
> +#define CLK_REF_SEL BIT(7)
> +
> +#define QUSB2PHY_PLL_TUNE 0x08
> +#define QUSB2PHY_PLL_USER_CTL1 0x0c
> +#define QUSB2PHY_PLL_USER_CTL2 0x10
> +#define QUSB2PHY_PLL_AUTOPGM_CTL1 0x1c
> +#define QUSB2PHY_PLL_PWR_CTRL 0x18
> +
> +/* QUSB2PHY_PLL_STATUS register bits */
> +#define PLL_LOCKED BIT(5)
> +
> +/* QUSB2PHY_PLL_COMMON_STATUS_ONE register bits */
> +#define CORE_READY_STATUS BIT(0)
> +
> +/* QUSB2PHY_PORT_POWERDOWN register bits */
> +#define CLAMP_N_EN BIT(5)
> +#define FREEZIO_N BIT(1)
> +#define POWER_DOWN BIT(0)
> +
> +/* QUSB2PHY_PWR_CTRL1 register bits */
> +#define PWR_CTRL1_VREF_SUPPLY_TRIM BIT(5)
> +#define PWR_CTRL1_CLAMP_N_EN BIT(1)
> +
> +#define QUSB2PHY_REFCLK_ENABLE BIT(0)
> +
> +#define PHY_CLK_SCHEME_SEL BIT(0)
> +
> +/* QUSB2PHY_INTR_CTRL register bits */
> +#define DMSE_INTR_HIGH_SEL BIT(4)
> +#define DPSE_INTR_HIGH_SEL BIT(3)
> +#define CHG_DET_INTR_EN BIT(2)
> +#define DMSE_INTR_EN BIT(1)
> +#define DPSE_INTR_EN BIT(0)
> +
> +/* QUSB2PHY_PLL_CORE_INPUT_OVERRIDE register bits */
> +#define CORE_PLL_EN_FROM_RESET BIT(4)
> +#define CORE_RESET BIT(5)
> +#define CORE_RESET_MUX BIT(6)
> +
> +/* QUSB2PHY_IMP_CTRL1 register bits */
> +#define IMP_RES_OFFSET_MASK GENMASK(5, 0)
> +#define IMP_RES_OFFSET_SHIFT 0x0
> +
> +/* QUSB2PHY_PLL_BIAS_CONTROL_2 register bits */
> +#define BIAS_CTRL2_RES_OFFSET_MASK GENMASK(5, 0)
> +#define BIAS_CTRL2_RES_OFFSET_SHIFT 0x0
> +
> +/* QUSB2PHY_CHG_CONTROL_2 register bits */
> +#define CHG_CTRL2_OFFSET_MASK GENMASK(5, 4)
> +#define CHG_CTRL2_OFFSET_SHIFT 0x4
> +
> +/* QUSB2PHY_PORT_TUNE1 register bits */
> +#define HSTX_TRIM_MASK GENMASK(7, 4)
> +#define HSTX_TRIM_SHIFT 0x4
> +#define PREEMPH_WIDTH_HALF_BIT BIT(2)
> +#define PREEMPHASIS_EN_MASK GENMASK(1, 0)
> +#define PREEMPHASIS_EN_SHIFT 0x0
> +
> +/* QUSB2PHY_PORT_TUNE2 register bits */
> +#define HSDISC_TRIM_MASK GENMASK(1, 0)
> +#define HSDISC_TRIM_SHIFT 0x0
> +
> +#define QUSB2PHY_PLL_ANALOG_CONTROLS_TWO 0x04
> +#define QUSB2PHY_PLL_CLOCK_INVERTERS 0x18c
> +#define QUSB2PHY_PLL_CMODE 0x2c
> +#define QUSB2PHY_PLL_LOCK_DELAY 0x184
> +#define QUSB2PHY_PLL_DIGITAL_TIMERS_TWO 0xb4
> +#define QUSB2PHY_PLL_BIAS_CONTROL_1 0x194
> +#define QUSB2PHY_PLL_BIAS_CONTROL_2 0x198
> +#define QUSB2PHY_PWR_CTRL2 0x214
> +#define QUSB2PHY_IMP_CTRL1 0x220
> +#define QUSB2PHY_IMP_CTRL2 0x224
> +#define QUSB2PHY_CHG_CTRL2 0x23c
> +
> +struct qusb2_phy_init_tbl {
> +       unsigned int offset;
> +       unsigned int val;
> +       /*
> +        * register part of layout ?
> +        * if yes, then offset gives index in the reg-layout
> +        */
> +       int in_layout;
> +};
> +
> +struct qusb2_phy_cfg {
> +       const struct qusb2_phy_init_tbl *tbl;
> +       /* number of entries in the table */
> +       unsigned int tbl_num;
> +       /* offset to PHY_CLK_SCHEME register in TCSR map */
> +       unsigned int clk_scheme_offset;
> +
> +       /* array of registers with different offsets */
> +       const unsigned int *regs;
> +       unsigned int mask_core_ready;
> +       unsigned int disable_ctrl;
> +       unsigned int autoresume_en;
> +
> +       /* true if PHY has PLL_TEST register to select clk_scheme */
> +       bool has_pll_test;
> +
> +       /* true if TUNE1 register must be updated by fused value, else TUNE2 */
> +       bool update_tune1_with_efuse;
> +
> +       /* true if PHY has PLL_CORE_INPUT_OVERRIDE register to reset PLL */
> +       bool has_pll_override;
> +};
> +
> +/* set of registers with offsets different per-PHY */
> +enum qusb2phy_reg_layout {
> +       QUSB2PHY_PLL_CORE_INPUT_OVERRIDE,
> +       QUSB2PHY_PLL_STATUS,
> +       QUSB2PHY_PORT_TUNE1,
> +       QUSB2PHY_PORT_TUNE2,
> +       QUSB2PHY_PORT_TUNE3,
> +       QUSB2PHY_PORT_TUNE4,
> +       QUSB2PHY_PORT_TUNE5,
> +       QUSB2PHY_PORT_TEST1,
> +       QUSB2PHY_PORT_TEST2,
> +       QUSB2PHY_PORT_POWERDOWN,
> +       QUSB2PHY_INTR_CTRL,
> +};
> +
> +#define QUSB2_PHY_INIT_CFG(o, v)       \
> +       {                              \
> +               .offset = o, .val = v, \
> +       }
> +
> +#define QUSB2_PHY_INIT_CFG_L(o, v)                     \
> +       {                                              \
> +               .offset = o, .val = v, .in_layout = 1, \
> +       }
> +
> +static const struct qusb2_phy_init_tbl sm6115_init_tbl[] = {
> +       QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
> +       QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x53),
> +       QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0x81),
> +       QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0x17),
> +
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TUNE, 0x30),
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL1, 0x79),
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL2, 0x21),
> +
> +       QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TEST2, 0x14),
> +
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_AUTOPGM_CTL1, 0x9f),
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
> +};
> +
> +static const unsigned int sm6115_regs_layout[] = {
> +       [QUSB2PHY_PLL_STATUS] = 0x38,     [QUSB2PHY_PORT_TUNE1] = 0x80,
> +       [QUSB2PHY_PORT_TUNE2] = 0x84,     [QUSB2PHY_PORT_TUNE3] = 0x88,
> +       [QUSB2PHY_PORT_TUNE4] = 0x8c,     [QUSB2PHY_PORT_TUNE5] = 0x90,
> +       [QUSB2PHY_PORT_TEST1] = 0xb8,     [QUSB2PHY_PORT_TEST2] = 0x9c,
> +       [QUSB2PHY_PORT_POWERDOWN] = 0xb4, [QUSB2PHY_INTR_CTRL] = 0xbc,
> +};
> +
> +static const struct qusb2_phy_init_tbl qusb2_v2_init_tbl[] = {
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x03),
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CMODE, 0x80),
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_LOCK_DELAY, 0x0a),
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_DIGITAL_TIMERS_TWO, 0x19),
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_BIAS_CONTROL_1, 0x40),
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_BIAS_CONTROL_2, 0x20),
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_PWR_CTRL2, 0x21),
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_IMP_CTRL1, 0x0),
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_IMP_CTRL2, 0x58),
> +
> +       QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0x30),
> +       QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x29),
> +       QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0xca),
> +       QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0x04),
> +       QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE5, 0x03),
> +
> +       QUSB2_PHY_INIT_CFG(QUSB2PHY_CHG_CTRL2, 0x0),
> +};
> +
> +static const unsigned int qusb2_v2_regs_layout[] = {
> +       [QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
> +       [QUSB2PHY_PLL_STATUS] = 0x1a0,
> +       [QUSB2PHY_PORT_TUNE1] = 0x240,
> +       [QUSB2PHY_PORT_TUNE2] = 0x244,
> +       [QUSB2PHY_PORT_TUNE3] = 0x248,
> +       [QUSB2PHY_PORT_TUNE4] = 0x24c,
> +       [QUSB2PHY_PORT_TUNE5] = 0x250,
> +       [QUSB2PHY_PORT_TEST1] = 0x254,
> +       [QUSB2PHY_PORT_TEST2] = 0x258,
> +       [QUSB2PHY_PORT_POWERDOWN] = 0x210,
> +       [QUSB2PHY_INTR_CTRL] = 0x230,
> +};
> +
> +static const struct qusb2_phy_cfg sm6115_phy_cfg = {
> +       .tbl = sm6115_init_tbl,
> +       .tbl_num = ARRAY_SIZE(sm6115_init_tbl),
> +       .regs = sm6115_regs_layout,
> +
> +       .has_pll_test = true,
> +       .disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
> +       .mask_core_ready = PLL_LOCKED,
> +       .autoresume_en = BIT(3),
> +};
> +
> +static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
> +       .tbl = qusb2_v2_init_tbl,
> +       .tbl_num = ARRAY_SIZE(qusb2_v2_init_tbl),
> +       .regs = qusb2_v2_regs_layout,
> +
> +       .disable_ctrl = (PWR_CTRL1_VREF_SUPPLY_TRIM | PWR_CTRL1_CLAMP_N_EN |
> +                        POWER_DOWN),
> +       .mask_core_ready = CORE_READY_STATUS,
> +       .has_pll_override = true,
> +       .autoresume_en = BIT(0),
> +       .update_tune1_with_efuse = true,
> +};
> +
> +/**
> + * struct qusb2_phy - structure holding qusb2 phy attributes
> + *
> + * @phy: generic phy
> + * @base: iomapped memory space for qubs2 phy
> + *
> + * @cfg_ahb_clk: AHB2PHY interface clock
> + * @phy_rst: phy reset control
> + *
> + * @cfg: phy config data
> + * @has_se_clk_scheme: indicate if PHY has single-ended ref clock scheme
> + */
> +struct qusb2_phy {
> +       struct phy *phy;
> +       void __iomem *base;
> +
> +       struct clk cfg_ahb_clk;
> +       struct reset_ctl phy_rst;
> +
> +       const struct qusb2_phy_cfg *cfg;
> +       bool has_se_clk_scheme;
> +};
> +
> +static inline void qusb2_write_mask(void __iomem *base, u32 offset, u32 val,
> +                                   u32 mask)
> +{
> +       u32 reg;
> +
> +       reg = readl(base + offset);
> +       reg &= ~mask;
> +       reg |= val & mask;
> +       writel(reg, base + offset);
> +
> +       /* Ensure above write is completed */
> +       readl(base + offset);
> +}

Function unused?

> +
> +static inline void qusb2_setbits(void __iomem *base, u32 offset, u32 val)
> +{
> +       u32 reg;
> +
> +       reg = readl(base + offset);
> +       reg |= val;
> +       writel(reg, base + offset);
> +
> +       /* Ensure above write is completed */
> +       readl(base + offset);
> +}
> +
> +static inline void qusb2_clrbits(void __iomem *base, u32 offset, u32 val)
> +{
> +       u32 reg;
> +
> +       reg = readl(base + offset);
> +       reg &= ~val;
> +       writel(reg, base + offset);
> +
> +       /* Ensure above write is completed */
> +       readl(base + offset);
> +}

Any specific reason to not use setbits_le32() and clrbits_le32() her instead?

> +
> +static inline void qusb2_phy_configure(void __iomem *base,
> +                                      const unsigned int *regs,
> +                                      const struct qusb2_phy_init_tbl tbl[],
> +                                      int num)
> +{
> +       int i;
> +
> +       for (i = 0; i < num; i++) {
> +               if (tbl[i].in_layout)
> +                       writel(tbl[i].val, base + regs[tbl[i].offset]);
> +               else
> +                       writel(tbl[i].val, base + tbl[i].offset);
> +       }
> +}
> +
> +static int qusb2phy_do_reset(struct qusb2_phy *qphy)
> +{
> +       int ret;
> +
> +       ret = reset_assert(&qphy->phy_rst);
> +       if (ret)
> +               return ret;
> +
> +       udelay(10);
> +
> +       ret = reset_deassert(&qphy->phy_rst);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int qusb2phy_power_on(struct phy *phy)
> +{
> +       struct qusb2_phy *qphy = dev_get_priv(phy->dev);
> +       const struct qusb2_phy_cfg *cfg = qphy->cfg;
> +       int ret;
> +       u32 val;
> +
> +       ret = qusb2phy_do_reset(qphy);
> +       if (ret)
> +               return ret;

Do we really need to reset here? Wouldn't just
reset_deassert(&qphy->phy_rst) be sufficient here instead?

-Sumit

> +
> +       /* Disable the PHY */
> +       qusb2_setbits(qphy->base, cfg->regs[QUSB2PHY_PORT_POWERDOWN],
> +                     qphy->cfg->disable_ctrl);
> +
> +       if (cfg->has_pll_test) {
> +               /* save reset value to override reference clock scheme later */
> +               val = readl(qphy->base + QUSB2PHY_PLL_TEST);
> +       }
> +
> +       qusb2_phy_configure(qphy->base, cfg->regs, cfg->tbl, cfg->tbl_num);
> +
> +       /* Enable the PHY */
> +       qusb2_clrbits(qphy->base, cfg->regs[QUSB2PHY_PORT_POWERDOWN],
> +                     POWER_DOWN);
> +
> +       /* Required to get phy pll lock successfully */
> +       udelay(150);
> +
> +       if (cfg->has_pll_test) {
> +               val |= CLK_REF_SEL;
> +
> +               writel(val, qphy->base + QUSB2PHY_PLL_TEST);
> +
> +               /* ensure above write is through */
> +               readl(qphy->base + QUSB2PHY_PLL_TEST);
> +       }
> +
> +       /* Required to get phy pll lock successfully */
> +       udelay(100);
> +
> +       val = readb(qphy->base + cfg->regs[QUSB2PHY_PLL_STATUS]);
> +       if (!(val & cfg->mask_core_ready)) {
> +               pr_err("QUSB2PHY pll lock failed: status reg = %x\n", val);
> +               ret = -EBUSY;
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int qusb2phy_power_off(struct phy *phy)
> +{
> +       struct qusb2_phy *qphy = dev_get_priv(phy->dev);
> +
> +       /* Disable the PHY */
> +       qusb2_setbits(qphy->base, qphy->cfg->regs[QUSB2PHY_PORT_POWERDOWN],
> +                     qphy->cfg->disable_ctrl);
> +
> +       reset_assert(&qphy->phy_rst);
> +
> +       clk_disable(&qphy->cfg_ahb_clk);
> +
> +       return 0;
> +}
> +
> +static int qusb2phy_clk_init(struct udevice *dev, struct qusb2_phy *qphy)
> +{
> +       int ret;
> +
> +       /* We ignore the ref clock as we currently lack a driver for rpmcc/rpmhcc where
> +        * it usually comes from - we assume it's always on.
> +        */
> +       ret = clk_get_by_name(dev, "cfg_ahb", &qphy->cfg_ahb_clk);
> +       if (ret == -ENOSYS || ret == -ENOENT)
> +               return 0;
> +       if (ret)
> +               return ret;
> +
> +       ret = clk_enable(&qphy->cfg_ahb_clk);
> +       if (ret) {
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static int qusb2phy_probe(struct udevice *dev)
> +{
> +       struct qusb2_phy *qphy = dev_get_priv(dev);
> +       int ret;
> +
> +       qphy->base = (void __iomem *)dev_read_addr(dev);
> +       if (IS_ERR(qphy->base))
> +               return PTR_ERR(qphy->base);
> +
> +       ret = qusb2phy_clk_init(dev, qphy);
> +       if (ret) {
> +               printf("%s: Couldn't get clocks: %d\n", __func__, ret);
> +               return ret;
> +       }
> +
> +       ret = reset_get_by_index(dev, 0, &qphy->phy_rst);
> +       if (ret) {
> +               printf("%s: Couldn't get resets: %d\n", __func__, ret);
> +               return ret;
> +       }
> +
> +       qphy->cfg = (const struct qusb2_phy_cfg *)dev_get_driver_data(dev);
> +       if (!qphy->cfg) {
> +               printf("%s: Couldn't get driver data\n", __func__);
> +               return -EINVAL;
> +       }
> +
> +       debug("%s success qusb phy cfg %p\n", __func__, qphy->cfg);
> +       return 0;
> +}
> +
> +static struct phy_ops qusb2phy_ops = {
> +       .power_on = qusb2phy_power_on,
> +       .power_off = qusb2phy_power_off,
> +};
> +
> +static const struct udevice_id qusb2phy_ids[] = {
> +       { .compatible = "qcom,qusb2-phy" },
> +       { .compatible = "qcom,qcm2290-qusb2-phy",
> +         .data = (ulong)&sm6115_phy_cfg },
> +       { .compatible = "qcom,sm6115-qusb2-phy",
> +         .data = (ulong)&sm6115_phy_cfg },
> +       { .compatible = "qcom,qusb2-v2-phy", .data = (ulong)&qusb2_v2_phy_cfg },
> +       {}
> +};
> +
> +U_BOOT_DRIVER(qcom_qusb2_phy) = {
> +       .name = "qcom-qusb2-phy",
> +       .id = UCLASS_PHY,
> +       .of_match = qusb2phy_ids,
> +       .ops = &qusb2phy_ops,
> +       .probe = qusb2phy_probe,
> +       .priv_auto = sizeof(struct qusb2_phy),
> +};
>
> --
> 2.44.0
>
