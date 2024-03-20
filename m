Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEDBC54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 05:37:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F948809A;
	Wed, 20 Mar 2024 06:37:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FO6hAesw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E50D87B77; Wed, 20 Mar 2024 06:37:34 +0100 (CET)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FB208809A
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:37:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-476757820ceso1143353137.1
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 22:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710913048; x=1711517848; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PcPyGBfU0JK9K19gfzixD5aH3KEFm5o3edrpj1UK4Cc=;
 b=FO6hAesw8KsQsAtYVA7EtXmDURIeZ6ErV2qI3oYeChYIL+aYHadZAthwvCDlQDMZUO
 3PspVpwR1Nrb8v368XSxLCC/uDwbSH9V+AFjf3mWYo7FzxSFAv2gNU6mC4rC5oObtmon
 bt1qIn7Elgsl5zXmBgJ0UCICDWufV0Bgi9D4BUCWY57l5+zhidLxn4bWR+BYyBC9JPrI
 8j2g2Y7Li57UKJlga04V7JQx4iKrhh2vUftoGcMNn1CczZOoD3tb9rFrIp+yD0FUy7cA
 /o6dcbS7bSbS0p7YCcmaoSl4XjimkGm39TFOndmERveWgg3eFcCy7S2axpyFPJb+dzWk
 Ilxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710913048; x=1711517848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PcPyGBfU0JK9K19gfzixD5aH3KEFm5o3edrpj1UK4Cc=;
 b=UseqkhkzEaX1BP2QVTtb0c0IqMwKL654mNyzxtNVy0hn/FAR1cGJvD6jCStOgpHZb7
 r40HtwElAqIOmufQOMz2Hgz0qpFMto1f9b9UL12aeiH0oSDHbrda7KB0/BT6MkJxnXCw
 Q+yeii6nm+pyGqU/czl4BzUkF1bbotlqMLfdqr3r4+YZWjRCd8G1X0uH/d7+rIeRf22E
 CGcZuGqhilCAHRyPpo7DUK4oKCTD+WwH5NNNtAwhdLG//d1WFCsk2i6BCwcUGNQmU3+s
 4Kp5XNrpS7cZhNV7KacO/88qyHcjqgFv0y8Lg8O6SO7kaC0H+SdiKN+rVDPGw8jRX96n
 dQ4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxOMFAtbb+tA0BftWVcLrv8lIRVVduzpTPit250oFTvpKejnbTzadk0rMHAhfu/ZnfsaxOBTkwkqYN0ozGqS9eblv0nA==
X-Gm-Message-State: AOJu0YxaUukA3SRIRCvbgzn/DPzs/aZa6kJrFfLeUWduP4QzbybPXHOW
 kIiTEsY+ELS91e38RMqgUkxWs+QBKQ6pc3Nwa/5s/0XL0FoXMhXgdcHiZIwHpsNS9lAkUDKqvm/
 CMK2LKLRc3mOTK6YktjwMaH5HF5R8dAt1zoTsag==
X-Google-Smtp-Source: AGHT+IH1+B6ZHYvE23aWwZgFBnXdUYxRJMgcT8SYkVfCNj7CIn781H3w88MJ5ssW1eZLsk4O8iF3RY2n4c/AnvxnLtY=
X-Received: by 2002:a67:fc1a:0:b0:471:e46a:2a9f with SMTP id
 o26-20020a67fc1a000000b00471e46a2a9fmr11985531vsq.33.1710913047933; Tue, 19
 Mar 2024 22:37:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
 <20240319-b4-qcom-livetree-v3-3-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-3-e1b38d9b4fa4@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Mar 2024 11:07:17 +0530
Message-ID: <CAFA6WYO1aw1HoBWy--1yh8udhfLbQ04ep3FKSKUHoMZWxjp6+Q@mail.gmail.com>
Subject: Re: [PATCH v3 03/14] phy: qcom: Add USB HS 7nm PHY driver
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
> Some Qualcomm SoCs newer than SDM845 feature a so-called "7nm phy"
> driver, notable the SM8250 SoC which will gain U-Boot support in
> upcoming patches.
>
> Introduce a driver based on the Linux driver.
>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> [code cleanup, switch to clk/reset_bulk APIs]
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/phy/qcom/Kconfig               |   8 +
>  drivers/phy/qcom/Makefile              |   1 +
>  drivers/phy/qcom/phy-qcom-usb-hs-7nm.c | 295 +++++++++++++++++++++++++++++++++
>  3 files changed, 304 insertions(+)
>
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 361dfb6e1126..3fc59dc65650 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -18,8 +18,16 @@ config PHY_QCOM_QUSB2
>         help
>           Enable this to support the Super-Speed USB transceiver on various
>           Qualcomm chipsets.
>
> +config PHY_QCOM_USB_HS_7NM
> +       tristate "Qualcomm 7nm High-Speed PHY"
> +       depends on PHY && ARCH_SNAPDRAGON
> +       help
> +         Enable this to support the Qualcomm Synopsys DesignWare Core 7nm
> +         High-Speed PHY driver. This driver supports the Hi-Speed PHY which
> +         is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
> +
>  config PHY_QCOM_USB_HS_28NM
>         tristate "Qualcomm 28nm High-Speed PHY"
>         depends on PHY && ARCH_SNAPDRAGON
>         help
> diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
> index f6af985666a4..39219ecd24aa 100644
> --- a/drivers/phy/qcom/Makefile
> +++ b/drivers/phy/qcom/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
>  obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
>  obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
> +obj-$(CONFIG_PHY_QCOM_USB_HS_7NM) += phy-qcom-usb-hs-7nm.o
>  obj-$(CONFIG_PHY_QCOM_USB_HS_28NM) += phy-qcom-usb-hs-28nm.o
>  obj-$(CONFIG_PHY_QCOM_USB_SS) += phy-qcom-usb-ss.o
> diff --git a/drivers/phy/qcom/phy-qcom-usb-hs-7nm.c b/drivers/phy/qcom/phy-qcom-usb-hs-7nm.c
> new file mode 100644
> index 000000000000..65128b45937b
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-usb-hs-7nm.c
> @@ -0,0 +1,295 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2023 Bhupesh Sharma <bhupesh.sharma@linaro.org>
> + *
> + * Based on Linux driver
> + */
> +
> +#include <clk.h>
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <dm/device_compat.h>
> +#include <dm/devres.h>
> +#include <generic-phy.h>
> +#include <malloc.h>
> +#include <reset.h>
> +
> +#include <asm/io.h>
> +#include <linux/bitops.h>
> +#include <linux/clk-provider.h>
> +#include <linux/delay.h>
> +#include <linux/iopoll.h>
> +
> +#define USB2_PHY_USB_PHY_UTMI_CTRL0 (0x3c)
> +#define SLEEPM BIT(0)
> +#define OPMODE_MASK GENMASK(4, 3)
> +#define OPMODE_NORMAL (0x00)
> +#define OPMODE_NONDRIVING BIT(3)
> +#define TERMSEL BIT(5)
> +
> +#define USB2_PHY_USB_PHY_UTMI_CTRL1 (0x40)

Drop unused macros. Check other macros too below if all of them are being used.

> +#define XCVRSEL BIT(0)
> +
> +#define USB2_PHY_USB_PHY_UTMI_CTRL5 (0x50)
> +#define POR BIT(1)
> +
> +#define USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0 (0x54)
> +#define SIDDQ BIT(2)
> +#define RETENABLEN BIT(3)
> +#define FSEL_MASK GENMASK(6, 4)
> +#define FSEL_DEFAULT (0x3 << 4)
> +
> +#define USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1 (0x58)
> +#define VBUSVLDEXTSEL0 BIT(4)
> +#define PLLBTUNE BIT(5)
> +
> +#define USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2 (0x5c)
> +#define VREGBYPASS BIT(0)
> +
> +#define USB2_PHY_USB_PHY_HS_PHY_CTRL1 (0x60)
> +#define VBUSVLDEXT0 BIT(0)
> +
> +#define USB2_PHY_USB_PHY_HS_PHY_CTRL2 (0x64)
> +#define USB2_AUTO_RESUME BIT(0)
> +#define USB2_SUSPEND_N BIT(2)
> +#define USB2_SUSPEND_N_SEL BIT(3)
> +
> +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0 (0x6c)
> +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1 (0x70)
> +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2 (0x74)
> +#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X3 (0x78)
> +#define PARAM_OVRD_MASK 0xFF
> +
> +#define USB2_PHY_USB_PHY_CFG0 (0x94)
> +#define UTMI_PHY_DATAPATH_CTRL_OVERRIDE_EN BIT(0)
> +#define UTMI_PHY_CMN_CTRL_OVERRIDE_EN BIT(1)
> +
> +#define USB2_PHY_USB_PHY_REFCLK_CTRL (0xa0)
> +#define REFCLK_SEL_MASK GENMASK(1, 0)
> +#define REFCLK_SEL_DEFAULT (0x2 << 0)
> +
> +#define HS_DISCONNECT_MASK GENMASK(2, 0)
> +#define SQUELCH_DETECTOR_MASK GENMASK(7, 5)
> +
> +#define HS_AMPLITUDE_MASK GENMASK(3, 0)
> +#define PREEMPHASIS_DURATION_MASK BIT(5)
> +#define PREEMPHASIS_AMPLITUDE_MASK GENMASK(7, 6)
> +
> +#define HS_RISE_FALL_MASK GENMASK(1, 0)
> +#define HS_CROSSOVER_VOLTAGE_MASK GENMASK(3, 2)
> +#define HS_OUTPUT_IMPEDANCE_MASK GENMASK(5, 4)
> +
> +#define LS_FS_OUTPUT_IMPEDANCE_MASK GENMASK(3, 0)
> +
> +#define SNPS_HS_NUM_VREGS ARRAY_SIZE(hs_7nm_vreg_names)
> +
> +struct override_param {
> +       s32 value;
> +       u8 reg_val;
> +};
> +
> +struct override_param_map {
> +       const char *prop_name;
> +       const struct override_param *param_table;
> +       u8 table_size;
> +       u8 reg_offset;
> +       u8 param_mask;
> +};
> +
> +struct phy_override_seq {
> +       bool need_update;
> +       u8 offset;
> +       u8 value;
> +       u8 mask;
> +};
> +
> +#define NUM_HSPHY_TUNING_PARAMS (9)
> +
> +/* struct hs_7nm_phy_cfg - per-PHY initialization config */
> +struct hs_7nm_phy_cfg {
> +       /* resets to be requested */

If you want to put these comments then a better format is to use
kernel doc style comments.

> +       struct reset_ctl *resets;
> +       int num_resets;
> +

redundant newline?

> +       struct override_param_map *map_cfg;
> +       struct phy_override_seq update_seq_cfg[NUM_HSPHY_TUNING_PARAMS];
> +};
> +
> +/**
> + * struct hs_7nm_phy_priv - snps hs phy attributes
> + */
> +struct hs_7nm_phy_priv {
> +       void __iomem *base;
> +

redundant newline, here and below?

> +       /* clocks to be requested */

Ditto.

> +       struct clk_bulk clks;
> +
> +       /* resets to be requested */
> +       struct reset_ctl_bulk resets;
> +
> +       struct hs_7nm_phy_cfg *cfg;
> +};
> +
> +static inline void hs_7nm_write_mask(void __iomem *base, u32 offset, u32 mask,
> +                                    u32 val)
> +{
> +       u32 reg;
> +
> +       reg = readl_relaxed(base + offset);
> +
> +       reg &= ~mask;
> +       reg |= val & mask;
> +       writel_relaxed(reg, base + offset);
> +
> +       /* Ensure above write is completed */
> +       readl_relaxed(base + offset);
> +}

I think it's better to reuse setbits_le32() and clrbits_le32() here too.

> +
> +static int hs_7nm_usb_init(struct phy *phy)
> +{
> +       struct hs_7nm_phy_priv *hs_7nm = dev_get_priv(phy->dev);
> +
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_CFG0,
> +                         UTMI_PHY_CMN_CTRL_OVERRIDE_EN,
> +                         UTMI_PHY_CMN_CTRL_OVERRIDE_EN);
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_UTMI_CTRL5, POR, POR);
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0,
> +                         FSEL_MASK, 0);
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
> +                         PLLBTUNE, PLLBTUNE);
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_REFCLK_CTRL,
> +                         REFCLK_SEL_DEFAULT, REFCLK_SEL_MASK);
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
> +                         VBUSVLDEXTSEL0, VBUSVLDEXTSEL0);
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL1,
> +                         VBUSVLDEXT0, VBUSVLDEXT0);
> +
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2,
> +                         VREGBYPASS, VREGBYPASS);
> +
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
> +                         USB2_SUSPEND_N_SEL | USB2_SUSPEND_N,
> +                         USB2_SUSPEND_N_SEL | USB2_SUSPEND_N);
> +
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_UTMI_CTRL0, SLEEPM,
> +                         SLEEPM);
> +
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0,
> +                         SIDDQ, 0);
> +
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_UTMI_CTRL5, POR, 0);
> +
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
> +                         USB2_SUSPEND_N_SEL, 0);
> +
> +       hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_CFG0,
> +                         UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 0);
> +
> +       return 0;
> +}
> +
> +static int hs_7nm_phy_power_on(struct phy *phy)
> +{
> +       struct hs_7nm_phy_priv *hs_7nm = dev_get_priv(phy->dev);
> +       int ret;
> +
> +       clk_enable_bulk(&hs_7nm->clks);
> +
> +       ret = reset_deassert_bulk(&hs_7nm->resets);
> +       if (ret)
> +               return ret;
> +
> +       ret = hs_7nm_usb_init(phy);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int hs_7nm_phy_power_off(struct phy *phy)
> +{
> +       struct hs_7nm_phy_priv *hs_7nm = dev_get_priv(phy->dev);
> +
> +       reset_assert_bulk(&hs_7nm->resets);
> +       clk_disable_bulk(&hs_7nm->clks);
> +
> +       return 0;
> +}
> +
> +static int hs_7nm_phy_clk_init(struct udevice *dev,
> +                              struct hs_7nm_phy_priv *hs_7nm)
> +{
> +       int ret;
> +
> +       ret = clk_get_bulk(dev, &hs_7nm->clks);
> +       /* We may have no clocks */

redundant comment?

> +       if (ret == -ENOENT) {
> +               debug("%s: no clocks\n", __func__);
> +               return 0;
> +       }
> +       if (ret < 0) {
> +               printf("%s: Failed to get clocks %d\n", __func__, ret);
> +               return ret;
> +       }

redundant error checking?

> +
> +       return 0;
> +}
> +
> +static int hs_7nm_phy_probe(struct udevice *dev)
> +{
> +       struct hs_7nm_phy_priv *hs_7nm = dev_get_priv(dev);
> +       int ret;
> +
> +       hs_7nm->base = (void __iomem *)dev_read_addr(dev);

Use dev_read_addr_ptr() instead.

> +       if (IS_ERR(hs_7nm->base))
> +               return PTR_ERR(hs_7nm->base);
> +
> +       hs_7nm->cfg = (struct hs_7nm_phy_cfg *)dev_get_driver_data(dev);
> +
> +       ret = hs_7nm_phy_clk_init(dev, hs_7nm);

I would rather make it inline to directly invoke clk_get_bulk() here.

> +       if (ret) {
> +               printf("%s: hs_7nm_phy_clk_init %d\n", __func__, ret);
> +               return ret;
> +       }
> +
> +       ret = reset_get_bulk(dev, &hs_7nm->resets);
> +       if (ret < 0) {
> +               printf("failed to get resets, ret = %d\n", ret);
> +               return ret;
> +       }
> +
> +       clk_enable_bulk(&hs_7nm->clks);
> +       reset_deassert_bulk(&hs_7nm->resets);
> +
> +       return 0;
> +}
> +
> +static struct phy_ops hs_7nm_phy_ops = {
> +       .power_on = hs_7nm_phy_power_on,
> +       .power_off = hs_7nm_phy_power_off,
> +};
> +
> +static const struct udevice_id hs_7nm_phy_ids[] = {
> +       {
> +               .compatible = "qcom,sm8150-usb-hs-phy",
> +       },
> +       {
> +               .compatible = "qcom,usb-snps-hs-5nm-phy",
> +       },
> +       {
> +               .compatible = "qcom,usb-snps-hs-7nm-phy",
> +       },
> +       {
> +               .compatible = "qcom,usb-snps-femto-v2-phy",
> +       },
> +       {}
> +};

I would rather write above as:

    static const struct udevice_id hs_7nm_phy_ids[] = {
        { .compatible = "qcom,sm8150-usb-hs-phy" },
        { .compatible = "qcom,usb-snps-hs-5nm-phy" },
        { .compatible = "qcom,usb-snps-hs-7nm-phy" },
        { .compatible = "qcom,usb-snps-femto-v2-phy" },
        { }
    };

-Sumit

> +
> +U_BOOT_DRIVER(qcom_usb_hs_7nm) = {
> +       .name = "qcom-usb-hs-7nm",
> +       .id = UCLASS_PHY,
> +       .of_match = hs_7nm_phy_ids,
> +       .ops = &hs_7nm_phy_ops,
> +       .probe = hs_7nm_phy_probe,
> +       .priv_auto = sizeof(struct hs_7nm_phy_priv),
> +};
>
> --
> 2.44.0
>
