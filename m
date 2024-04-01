Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B461BCD1283
	for <u-boot@archiver.kernel.org>; Mon,  1 Apr 2024 04:46:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F4487E50;
	Mon,  1 Apr 2024 06:46:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rltBQCoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36D12882C5; Mon,  1 Apr 2024 06:46:24 +0200 (CEST)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com
 [IPv6:2607:f8b0:4864:20::e2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4146882A4
 for <u-boot@lists.denx.de>; Mon,  1 Apr 2024 06:46:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-47605f03b15so789727137.0
 for <u-boot@lists.denx.de>; Sun, 31 Mar 2024 21:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711946780; x=1712551580; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5QbVdcvd8T51wCiUSpko7TTEi70LxW8ZhPsyVDLwJGo=;
 b=rltBQCoGmld8q2Riu6y86iIkVCbsnoAU5hgXb0yY0l3O2NprcZ3IqZiPClOYtB/fI1
 vtYoUOsxK7kqYWJj0KlScGe658wtZgzAjGi09Pj7GEsC/l1YMlDY7+A4DN8l6L5aXHko
 ymkLQ6wOxB529wp8v8ARJoAjdvlfwxYDkopLfq2uddJW/FYecK2zkxvt0w45Nk4pHubv
 x5saIFPQj7AA+QAG6ZQZ0LIaOGalb4VIKX2TsMpqd/qcZ+Wr+EdpQMZqQAdc0oolJH1Y
 VY3p0gREbtCzQojIerDjCZImD20N0AltUnuCuhaDbdF/iEOTxazoDt4ciFxQ9nr0NPi7
 61yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711946780; x=1712551580;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5QbVdcvd8T51wCiUSpko7TTEi70LxW8ZhPsyVDLwJGo=;
 b=EcGyO9LjuZVMJtIZigqfmuO/SMhWU+oYi6H+CK1kblr2m6xwOx7brIqwHNoryifAuw
 PNDvBKNdbQ+5HDEgWw1SYCbowxMipXfKgYJcZ+XsMwbgUgT+PiE0PIkRZstx5U8npckY
 0lXbVFZNYeb0f8pCjWjU8e5P8Q/2IFUqogsjbJ2+e2eESBSSeF+nQSDNgkte/LauuStE
 VP45hvr5lu321gasBXcEWavf1TOp8mDJygXujCHWl2pV5kqy1n4HT7cqrER7rwdVXYhJ
 fdsqE2K6X2tE9zQSf5mpMK+S7B6cJffsQZM9U0lURi1JE6gnBaY2kqrKPlOaeI9+nnt3
 UUcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwDHzIjlvHzqXwHoQleubehwg3ixsVZsBAYbeSXRioWoJdCa5tMIj8h+HEOxL/oDvie+Zsh7xGD8jBIcJJhPlq4NfFag==
X-Gm-Message-State: AOJu0Yyo1kz5S+yuqmlrpGIQMKbEL5p7YiCkliLNCAeTKOpMF+ccf37x
 AsCPs1O6DWP1SI785661zheVnPj/UhifLUgUpgp1U9VRAjkyJd5UOmeTzRcUd/AAfHPJhANyh1p
 MvLH9/iCdLblN2miEIeSf/RZUc3x82gBwxvJ+XQ==
X-Google-Smtp-Source: AGHT+IFs5d7Z5YXxWTpSgMW0yQIY4KqVqyN35irGe5983L8aJ5yG/RQLDr15UwIPdW455NHneECuBL5Co6fGAw7mn9o=
X-Received: by 2002:a05:6102:3093:b0:476:96f0:3bad with SMTP id
 l19-20020a056102309300b0047696f03badmr5101403vsb.19.1711946780632; Sun, 31
 Mar 2024 21:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240328-b4-qcom-livetree-v5-0-4e98228b3d03@linaro.org>
 <20240328-b4-qcom-livetree-v5-3-4e98228b3d03@linaro.org>
In-Reply-To: <20240328-b4-qcom-livetree-v5-3-4e98228b3d03@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Mon, 1 Apr 2024 10:16:09 +0530
Message-ID: <CAFA6WYO=_2NQckqt11b81GPZXGE13Uw9hCkO6S+F6b3ve2nDBA@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] phy: qcom: Add SNPS femto v2 USB HS phy
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

On Thu, 28 Mar 2024 at 23:29, Caleb Connolly <caleb.connolly@linaro.org> wrote:
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
> [code cleanup, align symbol names with Linux, switch to clk/reset_bulk APIs]
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/phy/qcom/Kconfig                  |   8 ++
>  drivers/phy/qcom/Makefile                 |   1 +
>  drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 207 ++++++++++++++++++++++++++++++
>  3 files changed, 216 insertions(+)
>
> diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
> index 361dfb6e1126..b9fe608c2798 100644
> --- a/drivers/phy/qcom/Kconfig
> +++ b/drivers/phy/qcom/Kconfig
> @@ -18,8 +18,16 @@ config PHY_QCOM_QUSB2
>         help
>           Enable this to support the Super-Speed USB transceiver on various
>           Qualcomm chipsets.
>
> +config PHY_QCOM_USB_SNPS_FEMTO_V2
> +       tristate "Qualcomm SNPS FEMTO USB HS PHY v2"
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
> index f6af985666a4..5f4db4a53788 100644
> --- a/drivers/phy/qcom/Makefile
> +++ b/drivers/phy/qcom/Makefile
> @@ -1,5 +1,6 @@
>  obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
>  obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
>  obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
> +obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
>  obj-$(CONFIG_PHY_QCOM_USB_HS_28NM) += phy-qcom-usb-hs-28nm.o
>  obj-$(CONFIG_PHY_QCOM_USB_SS) += phy-qcom-usb-ss.o
> diff --git a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
> new file mode 100644
> index 000000000000..58eb01972402
> --- /dev/null
> +++ b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
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
> +#define USB2_PHY_USB_PHY_CFG0 (0x94)
> +#define UTMI_PHY_DATAPATH_CTRL_OVERRIDE_EN BIT(0)
> +#define UTMI_PHY_CMN_CTRL_OVERRIDE_EN BIT(1)
> +
> +#define USB2_PHY_USB_PHY_REFCLK_CTRL (0xa0)
> +#define REFCLK_SEL_MASK GENMASK(1, 0)
> +#define REFCLK_SEL_DEFAULT (0x2 << 0)
> +
> +struct qcom_snps_hsphy {
> +       void __iomem *base;
> +       struct clk_bulk clks;
> +       struct reset_ctl_bulk resets;
> +};
> +
> +static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
> +                                             u32 mask, u32 val)
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

It looks like you have missed addressing comments related to this API.
Again, why do we need this special handling in U-Boot? Why not just
clrsetbits_le32()?

-Sumit

> +}
> +
> +static int qcom_snps_hsphy_usb_init(struct phy *phy)
> +{
> +       struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
> +
> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_CFG0,
> +                                  UTMI_PHY_CMN_CTRL_OVERRIDE_EN,
> +                                  UTMI_PHY_CMN_CTRL_OVERRIDE_EN);
> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL5, POR,
> +                                  POR);
> +       qcom_snps_hsphy_write_mask(priv->base,
> +                                  USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0, FSEL_MASK, 0);
> +       qcom_snps_hsphy_write_mask(priv->base,
> +                                  USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
> +                                  PLLBTUNE, PLLBTUNE);
> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_REFCLK_CTRL,
> +                                  REFCLK_SEL_DEFAULT, REFCLK_SEL_MASK);
> +       qcom_snps_hsphy_write_mask(priv->base,
> +                                  USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
> +                                  VBUSVLDEXTSEL0, VBUSVLDEXTSEL0);
> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL1,
> +                                  VBUSVLDEXT0, VBUSVLDEXT0);
> +
> +       qcom_snps_hsphy_write_mask(priv->base,
> +                                  USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2,
> +                                  VREGBYPASS, VREGBYPASS);
> +
> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
> +                                  USB2_SUSPEND_N_SEL | USB2_SUSPEND_N,
> +                                  USB2_SUSPEND_N_SEL | USB2_SUSPEND_N);
> +
> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL0,
> +                                  SLEEPM, SLEEPM);
> +
> +       qcom_snps_hsphy_write_mask(
> +               priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0, SIDDQ, 0);
> +
> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL5, POR,
> +                                  0);
> +
> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
> +                                  USB2_SUSPEND_N_SEL, 0);
> +
> +       qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_CFG0,
> +                                  UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 0);
> +
> +       return 0;
> +}
> +
> +static int qcom_snps_hsphy_power_on(struct phy *phy)
> +{
> +       struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
> +       int ret;
> +
> +       clk_enable_bulk(&priv->clks);
> +
> +       ret = reset_deassert_bulk(&priv->resets);
> +       if (ret)
> +               return ret;
> +
> +       ret = qcom_snps_hsphy_usb_init(phy);
> +       if (ret)
> +               return ret;
> +
> +       return 0;
> +}
> +
> +static int qcom_snps_hsphy_power_off(struct phy *phy)
> +{
> +       struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
> +
> +       reset_assert_bulk(&priv->resets);
> +       clk_disable_bulk(&priv->clks);
> +
> +       return 0;
> +}
> +
> +static int qcom_snps_hsphy_phy_probe(struct udevice *dev)
> +{
> +       struct qcom_snps_hsphy *priv = dev_get_priv(dev);
> +       int ret;
> +
> +       priv->base = dev_read_addr_ptr(dev);
> +       if (IS_ERR(priv->base))
> +               return PTR_ERR(priv->base);
> +
> +       ret = clk_get_bulk(dev, &priv->clks);
> +       if (ret < 0 && ret != -ENOENT) {
> +               printf("%s: Failed to get clocks %d\n", __func__, ret);
> +               return ret;
> +       }
> +
> +       ret = reset_get_bulk(dev, &priv->resets);
> +       if (ret < 0) {
> +               printf("failed to get resets, ret = %d\n", ret);
> +               return ret;
> +       }
> +
> +       clk_enable_bulk(&priv->clks);
> +       reset_deassert_bulk(&priv->resets);
> +
> +       return 0;
> +}
> +
> +static struct phy_ops qcom_snps_hsphy_phy_ops = {
> +       .power_on = qcom_snps_hsphy_power_on,
> +       .power_off = qcom_snps_hsphy_power_off,
> +};
> +
> +static const struct udevice_id qcom_snps_hsphy_phy_ids[] = {
> +       { .compatible = "qcom,sm8150-usb-hs-phy" },
> +       { .compatible = "qcom,usb-snps-hs-5nm-phy" },
> +       { .compatible = "qcom,usb-snps-hs-7nm-phy" },
> +       { .compatible = "qcom,usb-snps-femto-v2-phy" },
> +       {}
> +};
> +
> +U_BOOT_DRIVER(qcom_usb_qcom_snps_hsphy) = {
> +       .name = "qcom-snps-hsphy",
> +       .id = UCLASS_PHY,
> +       .of_match = qcom_snps_hsphy_phy_ids,
> +       .ops = &qcom_snps_hsphy_phy_ops,
> +       .probe = qcom_snps_hsphy_phy_probe,
> +       .priv_auto = sizeof(struct qcom_snps_hsphy),
> +};
>
> --
> 2.44.0
>
