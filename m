Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32721C5478C
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 06:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F15887DFD;
	Tue,  5 Mar 2024 07:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JHgP0jfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F144E87F7F; Tue,  5 Mar 2024 07:49:16 +0100 (CET)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95F8C87DFD
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 07:49:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-47268928105so12679137.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 22:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709621353; x=1710226153; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w/YOzeS5ZYvSNuBE2sIVIs8ucHdKkuby+8X49Y+1B8w=;
 b=JHgP0jfNfpNnHpiTcNA5KmayWTIyf36UJDwESD076cD4ubsA5Q05yrRBBmSpAZ09OE
 k5Jn/chD1TduV81TpkPawNA5KpxfQJwnEHzxOMKxjJegIRPNVJ3PvKtPpwoJUjmn8Uzz
 OPMXi3JQuX3bvKArxaEyRo9X3ENb/lqnJjB98iLXu30uSZJp5LpsXXF7N4nOV1h69mC6
 oeN3207X8BWKDYpFUR1h2T9tUNK03NwJHq1bUofCM+lBIRcQwI0CxwQz5iyDTga26Ros
 qpr3puDDNJww+wb8DhTGDAaMhTFsFzzGJ8eWjatItf1wKZ81Zufo0yofx7x7TxY3QgbC
 lbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709621353; x=1710226153;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/YOzeS5ZYvSNuBE2sIVIs8ucHdKkuby+8X49Y+1B8w=;
 b=dMhX9k0DZbpJ3XSSVD4uiYTF2LiyGZIyb0iGsyT8SPLCQ8Qgvp920rcVMVMJxIpnVs
 RQDc8PTb4dphc98pGeGVL2GbY8PKHWw83zw65VRnEzY6+9f5d0+xgCdYaDqGAHUPQ/9y
 4uemRpb9clRL6q9UlyCtqnyxBCrK3kugur60FzFBFzVrKhYgptbDBvNojbs2aKujyS3m
 wtcZnyig0vrlm8VsiMTfvrVvLpw8NPuU2WFMJUyP20vGhYcw41nO9KP5ZmctuKTrBNOA
 GjpvXBdJesmBK6JmK5cIFI+mBkPr96m1jnYDIgiHnE+n1sICyVN7lsvRtRFWmdHbsoSj
 Lnzw==
X-Gm-Message-State: AOJu0Yx7s+xHDrQe9BEVCFGvlq4UfNHvGFD+O9x/4Rv8JUDeY+Dh6Vqw
 dnaAibQqsZLTAlKx1OzyhrDIMZ8FmoT5u8wEN08qPXrbrABgt4zGIRjQ2RQyY5dmfIGQ/jDpbHq
 oP61enXPHthUrePo7xdJYqQ4hzr3KwN2fDHOD+w==
X-Google-Smtp-Source: AGHT+IGPHm4RZxB0HWzaBCgoWW0gBlwGes0GzFtR8MkVcZKFr6ReSbxiOL6CjWm9HL6phjMRInAQ2gSI5sdi6SvDRvA=
X-Received: by 2002:a05:6102:3712:b0:472:681a:b9be with SMTP id
 s18-20020a056102371200b00472681ab9bemr1014314vst.31.1709621353260; Mon, 04
 Mar 2024 22:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20240229142043.1263690-1-volodymyr_babchuk@epam.com>
 <20240229142043.1263690-4-volodymyr_babchuk@epam.com>
In-Reply-To: <20240229142043.1263690-4-volodymyr_babchuk@epam.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Mar 2024 12:19:02 +0530
Message-ID: <CAFA6WYPxsrFA7-5ixsdXQssL0YAqH89guZbHufqE+Lcfk4Ri5g@mail.gmail.com>
Subject: Re: [PATCH 3/8] net: dw_eth_qos: add support for Qualcomm SM8150 SoC
To: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Elmar Psilog <epsi@gmx.de>, 
 Joe Hershberger <joe.hershberger@ni.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>, 
 Marek Vasut <marex@denx.de>, Ramon Fried <rfried.dev@gmail.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Yanhong Wang <yanhong.wang@starfivetech.com>
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

On Thu, 29 Feb 2024 at 19:53, Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> Add support for Qualcomm SM8150 SoC to the EQOS driver. SM8150 has two
> main differences from already supported QCS404: it has another RGMII
> configuration registers set and it does require RGMII loopback to
> be disabled.
>
> To support different variants of QCOM SoC we had to add two new fields
> to the eqos_priv struct: eqos_qcom_rgmii_regs and
> qcom_enable_loopback.
>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>
>  drivers/net/dwc_eth_qos.c      |  4 +++
>  drivers/net/dwc_eth_qos.h      |  2 ++
>  drivers/net/dwc_eth_qos_qcom.c | 47 +++++++++++++++++++++++++++-------
>  3 files changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/dwc_eth_qos.c b/drivers/net/dwc_eth_qos.c
> index 9b3bce1dc8..882b854697 100644
> --- a/drivers/net/dwc_eth_qos.c
> +++ b/drivers/net/dwc_eth_qos.c
> @@ -1700,6 +1700,10 @@ static const struct udevice_id eqos_ids[] = {
>                 .compatible = "qcom,qcs404-ethqos",
>                 .data = (ulong)&eqos_qcom_config
>         },
> +       {
> +               .compatible = "qcom,sm8150-ethqos",
> +               .data = (ulong)&eqos_qcom_config
> +       },
>  #endif
>  #if IS_ENABLED(CONFIG_DWC_ETH_QOS_STARFIVE)
>         {
> diff --git a/drivers/net/dwc_eth_qos.h b/drivers/net/dwc_eth_qos.h
> index e3222e1e17..216e1afe53 100644
> --- a/drivers/net/dwc_eth_qos.h
> +++ b/drivers/net/dwc_eth_qos.h
> @@ -255,6 +255,7 @@ struct eqos_priv {
>         struct eqos_dma_regs *dma_regs;
>         struct eqos_tegra186_regs *tegra186_regs;
>         void *eqos_qcom_rgmii_regs;
> +       struct dwmac_rgmii_regs *eqos_qcom_por;
>         struct reset_ctl reset_ctl;
>         struct gpio_desc phy_reset_gpio;
>         struct clk clk_master_bus;
> @@ -277,6 +278,7 @@ struct eqos_priv {
>         bool started;
>         bool reg_access_ok;
>         bool clk_ck_enabled;
> +       bool qcom_enable_loopback;
>         unsigned int tx_fifo_sz, rx_fifo_sz;
>         u32 reset_delays[3];
>  };
> diff --git a/drivers/net/dwc_eth_qos_qcom.c b/drivers/net/dwc_eth_qos_qcom.c
> index 8178138fc6..e9592ff686 100644
> --- a/drivers/net/dwc_eth_qos_qcom.c
> +++ b/drivers/net/dwc_eth_qos_qcom.c
> @@ -95,6 +95,15 @@ static struct dwmac_rgmii_regs emac_v2_3_0_por = {
>         .io_macro_config2 = 0x00002060
>  };
>
> +static struct dwmac_rgmii_regs emac_v2_1_0_por = {
> +       .io_macro_config = 0x40C01343,
> +       .sdcc_hc_dll_config = 0x2004642C,
> +       .sdcc_hc_ddr_config = 0x00000000,
> +       .sdcc_hc_dll_config2 = 0x00200000,
> +       .sdcc_usr_ctl = 0x00010800,
> +       .io_macro_config2 = 0x00002060
> +};
> +
>  static void ethqos_set_func_clk_en(struct dwmac_rgmii_regs *regs)
>  {
>         setbits_le32(&regs->io_macro_config, RGMII_CONFIG_FUNC_CLK_EN);
> @@ -172,6 +181,8 @@ static int ethqos_rgmii_macro_init(struct udevice *dev,
>                                    struct dwmac_rgmii_regs *regs,
>                                    unsigned long speed)
>  {
> +       struct eqos_priv *eqos = dev_get_priv(dev);
> +
>         /* Disable loopback mode */
>         clrbits_le32(&regs->io_macro_config2,
>                      RGMII_CONFIG2_TX_TO_RX_LOOPBACK_EN);
> @@ -202,7 +213,9 @@ static int ethqos_rgmii_macro_init(struct udevice *dev,
>                                 SDCC_DDR_CONFIG_PRG_RCLK_DLY, 57);
>                 setbits_le32(&regs->sdcc_hc_ddr_config, SDCC_DDR_CONFIG_PRG_DLY_EN);
>
> -               setbits_le32(&regs->io_macro_config, RGMII_CONFIG_LOOPBACK_EN);
> +               if (eqos->qcom_enable_loopback)
> +                       setbits_le32(&regs->io_macro_config,
> +                                    RGMII_CONFIG_LOOPBACK_EN);

We should explicitly clear the loopback bit for the else part too. I
suppose it can be written cleanly as below here and other places too:

        loopback = eqos->qcom_enable_loopback ? RGMII_CONFIG_LOOPBACK_EN : 0;

        clrsetbits_le32(&regs->io_macro_config,
                                RGMII_CONFIG_LOOPBACK_EN,
                                loopback);

-Sumit

>                 break;
>
>         case SPEED_100:
> @@ -233,7 +246,9 @@ static int ethqos_rgmii_macro_init(struct udevice *dev,
>                 setbits_le32(&regs->sdcc_hc_ddr_config,
>                              SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_EN);
>
> -               setbits_le32(&regs->io_macro_config, RGMII_CONFIG_LOOPBACK_EN);
> +               if (eqos->qcom_enable_loopback)
> +                       setbits_le32(&regs->io_macro_config,
> +                                    RGMII_CONFIG_LOOPBACK_EN);
>                 break;
>
>         case SPEED_10:
> @@ -265,7 +280,9 @@ static int ethqos_rgmii_macro_init(struct udevice *dev,
>                 setbits_le32(&regs->sdcc_hc_ddr_config,
>                              SDCC_DDR_CONFIG_EXT_PRG_RCLK_DLY_EN);
>
> -               setbits_le32(&regs->io_macro_config, RGMII_CONFIG_LOOPBACK_EN);
> +               if (eqos->qcom_enable_loopback)
> +                       setbits_le32(&regs->io_macro_config,
> +                                    RGMII_CONFIG_LOOPBACK_EN);
>                 break;
>
>         default:
> @@ -281,14 +298,15 @@ static int ethqos_configure(struct udevice *dev,
>                             unsigned long speed)
>  {
>         unsigned int retry = 1000;
> +       struct eqos_priv *eqos = dev_get_priv(dev);
>
>         /* Reset to POR values and enable clk */
> -       writel(emac_v2_3_0_por.io_macro_config, &regs->io_macro_config);
> -       writel(emac_v2_3_0_por.sdcc_hc_dll_config, &regs->sdcc_hc_dll_config);
> -       writel(emac_v2_3_0_por.sdcc_hc_ddr_config, &regs->sdcc_hc_ddr_config);
> -       writel(emac_v2_3_0_por.sdcc_hc_dll_config2, &regs->sdcc_hc_dll_config2);
> -       writel(emac_v2_3_0_por.sdcc_usr_ctl, &regs->sdcc_usr_ctl);
> -       writel(emac_v2_3_0_por.io_macro_config2, &regs->io_macro_config2);
> +       writel(eqos->eqos_qcom_por->io_macro_config, &regs->io_macro_config);
> +       writel(eqos->eqos_qcom_por->sdcc_hc_dll_config, &regs->sdcc_hc_dll_config);
> +       writel(eqos->eqos_qcom_por->sdcc_hc_ddr_config, &regs->sdcc_hc_ddr_config);
> +       writel(eqos->eqos_qcom_por->sdcc_hc_dll_config2, &regs->sdcc_hc_dll_config2);
> +       writel(eqos->eqos_qcom_por->sdcc_usr_ctl, &regs->sdcc_usr_ctl);
> +       writel(eqos->eqos_qcom_por->io_macro_config2, &regs->io_macro_config2);
>
>         ethqos_set_func_clk_en(regs);
>
> @@ -565,6 +583,17 @@ static int eqos_probe_resources_qcom(struct udevice *dev)
>                 return -EINVAL;
>         }
>
> +       if (device_is_compatible(dev, "qcom,qcs404-ethqos")) {
> +               eqos->eqos_qcom_por = &emac_v2_3_0_por;
> +               eqos->qcom_enable_loopback = true;
> +       } else if (device_is_compatible(dev, "qcom,sm8150-ethqos")) {
> +               eqos->eqos_qcom_por = &emac_v2_1_0_por;
> +               eqos->qcom_enable_loopback = false;
> +       } else {
> +               pr_err("Unknown QCOM ethernet device\n");
> +               return -EINVAL;
> +       }
> +
>         debug("%s: OK\n", __func__);
>         return 0;
>  }
> --
> 2.43.0
