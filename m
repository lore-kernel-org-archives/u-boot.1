Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3143FC2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:24:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C4A687B77;
	Tue,  9 Jul 2024 11:24:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o9u+pPjQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31F9A884FF; Tue,  9 Jul 2024 11:24:08 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FC5E87919
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:24:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-42122ac2f38so29695505e9.1
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720517044; x=1721121844;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=wDKzIUGEdfzzPUNj/lZY9jNYI1IxOuR8ZHw4ZragRy4=;
 b=o9u+pPjQK1LvI6I7TO2EUxwLAxz1UitmRO3wJ+LAcUSyfNHQzD6ZdQxGOPywa7pXcj
 yc4s9Sc1sMszNkV8yeCdnFppz1jI9TgzddHWjRHkQxc1SokhbLkcV5LjvnhVaJcMT6Cq
 5T4POYYMSxndexv6kQzN+e4JWik4G+JO3W7r6HbRc6j35QLCYn1w9oewLXTPa78RQGc+
 xY1PJQWqbawNtIIVy0aiUf5McyAF0aPYlaKd+SKVoXA8W1dhfmnFxVQx/OcsQaHQ09mD
 j61Q9TQxScvXoXaUmr2TAhAGM00xKzcHcyrEIAYtowet/z/Hb6p/qIM2ca/FvD/GMCzo
 MHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517044; x=1721121844;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wDKzIUGEdfzzPUNj/lZY9jNYI1IxOuR8ZHw4ZragRy4=;
 b=ZCQpZ870R9U7wNvnXS1mpekcoYjwOd2tosDPmwi0HL4SfKxDCPCwJOsJai0DcdxyzQ
 aIeRmU9VCHIqgoY9dTn9kliaX9Zf6KrOqYEz/FOTF2bEBf4kCX/HTij5bgK4yglLpbw1
 WEmHzIBuMQN9niJ+4ptlOW38QKq74M5GrIsMO3cSTC3f62WqUdxjYTWWgRv0wn3XUEKM
 ClGwCa3SbZSIUV0+bOwn1mPWBBk6urc2Mm6oyGf6GxYqURW/rcPani6IDV2BhsibwxAW
 DoZSBivwB8qh/4O6L4y1tUc9zkMOsXNAj8vOgWAXoP9sI+daJB9T+2evwvtd6Oagy5/6
 W2Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVftEbTYAzGNSeQmpSyELqp2159s4bQCY1QuyH73YjZ8boGsRgPx02emBEE69isM+IREUMzwZ62Ttcso5ltqMxHoYW0zA==
X-Gm-Message-State: AOJu0Yz0pDu3xfO3M0gJeWrMsaIIvNczG2R6g5/syC9qHKvx3UGq3qEy
 W1u/qdyVIHeUBYh8Rt7Zz6bxL9+AxRHEhe6jKur/H/NIV4R3FZQAVoOOiBPYrIA=
X-Google-Smtp-Source: AGHT+IH0mWywMowRksHt+iUN5klktGmSSDZl1yIFDdoJTRkA+tbU4WAhbcLLR4K9mqhkyCwyhvNMjg==
X-Received: by 2002:a05:600c:4341:b0:426:676a:c4d1 with SMTP id
 5b1f17b1804b1-426722d4a36mr13961945e9.8.1720517044224; 
 Tue, 09 Jul 2024 02:24:04 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f6f20c0sm32013305e9.20.2024.07.09.02.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:24:03 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Caleb Connolly
 <caleb.connolly@linaro.org>, Fabio Estevam <festevam@gmail.com>, Fabrice
 Gasnier <fabrice.gasnier@foss.st.com>, Jonas Karlman <jonas@kwiboo.se>,
 Mathieu Othacehe <othacehe@gnu.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Nishanth Menon <nm@ti.com>, Nobuhiro Iwamatsu
 <iwamatsu@nigauri.org>, Sean Anderson <seanga2@gmail.com>, Simon Glass
 <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>, Tim Harvey
 <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, Xavier Drudis
 Ferran <xdrudis@tinet.cat>, u-boot-qcom@groups.io
Subject: Re: [PATCH v2 2/3] phy: rcar: Split init and set_mode operations
In-Reply-To: <20240617173740.80822-2-marek.vasut+renesas@mailbox.org>
References: <20240617173740.80822-1-marek.vasut+renesas@mailbox.org>
 <20240617173740.80822-2-marek.vasut+renesas@mailbox.org>
Date: Tue, 09 Jul 2024 11:24:01 +0200
Message-ID: <87plrmj4um.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Marek,

Thank you for the patch.

On lun., juin 17, 2024 at 19:36, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> The current init operation also sets the PHY into USB host mode.
> Split the mode configuration into set_mode callback instead and
> implement support for device and OTG modes as well.
>
> The OTG mode performs auto-detection and selects either host or
> device mode. In case the OTG mode is configured, submode field
> can be used to select full PHY (re)initialization or only mode
> auto-detection. The full (re)initialization is only necessary
> once, on start up.
>
> Since the OTG mode may enable IRQ generation in the PHY, disable
> that IRQ generation in the exit callback again.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Mathieu Othacehe <othacehe@gnu.org>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Xavier Drudis Ferran <xdrudis@tinet.cat>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.denx.de
> ---
> V2: No change
> ---
>  drivers/phy/phy-rcar-gen3.c | 90 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 85 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/phy/phy-rcar-gen3.c b/drivers/phy/phy-rcar-gen3.c
> index 7c292cae0e2..b278f995f37 100644
> --- a/drivers/phy/phy-rcar-gen3.c
> +++ b/drivers/phy/phy-rcar-gen3.c
> @@ -8,6 +8,7 @@
>  #include <clk.h>
>  #include <div64.h>
>  #include <dm.h>
> +#include <dm/device_compat.h>
>  #include <fdtdec.h>
>  #include <generic-phy.h>
>  #include <malloc.h>
> @@ -31,8 +32,13 @@
>  #define USB2_LINECTRL1		0x610
>  #define USB2_ADPCTRL		0x630
>  
> +/* INT_ENABLE */
> +#define USB2_INT_ENABLE_UCOM_INTEN	BIT(3)
> +#define USB2_INT_ENABLE_USBH_INTB_EN	BIT(2)
> +#define USB2_INT_ENABLE_USBH_INTA_EN	BIT(1)
> +
>  /* USBCTR */
> -#define USB2_USBCTR_PLL_RST	BIT(1)
> +#define USB2_USBCTR_PLL_RST		BIT(1)
>  
>  /* SPD_RSM_TIMSET */
>  #define USB2_SPD_RSM_TIMSET_INIT	0x014e029b
> @@ -43,11 +49,23 @@
>  /* COMMCTRL */
>  #define USB2_COMMCTRL_OTG_PERI		BIT(31)	/* 1 = Peripheral mode */
>  
> +/* OBINTSTA and OBINTEN */
> +#define USB2_OBINT_SESSVLDCHG		BIT(12)
> +#define USB2_OBINT_IDDIGCHG		BIT(11)
> +
> +/* VBCTRL */
> +#define USB2_VBCTRL_DRVVBUSSEL		BIT(8)
> +
>  /* LINECTRL1 */
> +#define USB2_LINECTRL1_DPRPD_EN		BIT(19)
>  #define USB2_LINECTRL1_DP_RPD		BIT(18)
> +#define USB2_LINECTRL1_DMRPD_EN		BIT(17)
>  #define USB2_LINECTRL1_DM_RPD		BIT(16)
>  
>  /* ADPCTRL */
> +#define USB2_ADPCTRL_OTGSESSVLD		BIT(20)
> +#define USB2_ADPCTRL_IDDIG		BIT(19)
> +#define USB2_ADPCTRL_IDPULLUP		BIT(5)	/* 1 = ID sampling is enabled */
>  #define USB2_ADPCTRL_DRVVBUS		BIT(4)
>  
>  struct rcar_gen3_phy {
> @@ -65,12 +83,14 @@ static int rcar_gen3_phy_phy_init(struct phy *phy)
>  	writel(USB2_SPD_RSM_TIMSET_INIT, priv->regs + USB2_SPD_RSM_TIMSET);
>  	writel(USB2_OC_TIMSET_INIT, priv->regs + USB2_OC_TIMSET);
>  
> -	setbits_le32(priv->regs + USB2_LINECTRL1,
> -		     USB2_LINECTRL1_DP_RPD | USB2_LINECTRL1_DM_RPD);
> +	return 0;
> +}
>  
> -	clrbits_le32(priv->regs + USB2_COMMCTRL, USB2_COMMCTRL_OTG_PERI);
> +static int rcar_gen3_phy_phy_exit(struct phy *phy)
> +{
> +	struct rcar_gen3_phy *priv = dev_get_priv(phy->dev);
>  
> -	setbits_le32(priv->regs + USB2_ADPCTRL, USB2_ADPCTRL_DRVVBUS);
> +	writel(0, priv->regs + USB2_INT_ENABLE);
>  
>  	return 0;
>  }
> @@ -102,10 +122,70 @@ static int rcar_gen3_phy_phy_power_off(struct phy *phy)
>  	return regulator_set_enable(priv->vbus_supply, false);
>  }
>  
> +static int rcar_gen3_phy_phy_set_mode(struct phy *phy, enum phy_mode mode,
> +				      int submode)
> +{
> +	const u32 adpdevmask = USB2_ADPCTRL_IDDIG | USB2_ADPCTRL_OTGSESSVLD;
> +	struct rcar_gen3_phy *priv = dev_get_priv(phy->dev);
> +	u32 adpctrl;
> +
> +	if (mode == PHY_MODE_USB_OTG) {
> +		if (submode) {
> +			/* OTG submode is used as initialization indicator */
> +			writel(USB2_INT_ENABLE_UCOM_INTEN |
> +			       USB2_INT_ENABLE_USBH_INTB_EN |
> +			       USB2_INT_ENABLE_USBH_INTA_EN,
> +			       priv->regs + USB2_INT_ENABLE);
> +			setbits_le32(priv->regs + USB2_VBCTRL,
> +				     USB2_VBCTRL_DRVVBUSSEL);
> +			writel(USB2_OBINT_SESSVLDCHG | USB2_OBINT_IDDIGCHG,
> +			       priv->regs + USB2_OBINTSTA);
> +			setbits_le32(priv->regs + USB2_OBINTEN,
> +				     USB2_OBINT_SESSVLDCHG |
> +				     USB2_OBINT_IDDIGCHG);
> +			setbits_le32(priv->regs + USB2_ADPCTRL,
> +				     USB2_ADPCTRL_IDPULLUP);
> +			clrsetbits_le32(priv->regs + USB2_LINECTRL1,
> +					USB2_LINECTRL1_DP_RPD |
> +					USB2_LINECTRL1_DM_RPD |
> +					USB2_LINECTRL1_DPRPD_EN |
> +					USB2_LINECTRL1_DMRPD_EN,
> +					USB2_LINECTRL1_DPRPD_EN |
> +					USB2_LINECTRL1_DMRPD_EN);
> +		}
> +
> +		adpctrl = readl(priv->regs + USB2_ADPCTRL);
> +		if ((adpctrl & adpdevmask) == adpdevmask)
> +			mode = PHY_MODE_USB_DEVICE;
> +		else
> +			mode = PHY_MODE_USB_HOST;
> +	}
> +
> +	if (mode == PHY_MODE_USB_HOST) {
> +		clrbits_le32(priv->regs + USB2_COMMCTRL, USB2_COMMCTRL_OTG_PERI);
> +		setbits_le32(priv->regs + USB2_LINECTRL1,
> +			     USB2_LINECTRL1_DP_RPD | USB2_LINECTRL1_DM_RPD);
> +		setbits_le32(priv->regs + USB2_ADPCTRL, USB2_ADPCTRL_DRVVBUS);
> +	} else if (mode == PHY_MODE_USB_DEVICE) {
> +		setbits_le32(priv->regs + USB2_COMMCTRL, USB2_COMMCTRL_OTG_PERI);
> +		clrsetbits_le32(priv->regs + USB2_LINECTRL1,
> +				USB2_LINECTRL1_DP_RPD | USB2_LINECTRL1_DM_RPD,
> +				USB2_LINECTRL1_DM_RPD);
> +		clrbits_le32(priv->regs + USB2_ADPCTRL, USB2_ADPCTRL_DRVVBUS);
> +	} else {
> +		dev_err(phy->dev, "Unknown mode %d\n", mode);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct phy_ops rcar_gen3_phy_phy_ops = {
>  	.init		= rcar_gen3_phy_phy_init,
> +	.exit		= rcar_gen3_phy_phy_exit,
>  	.power_on	= rcar_gen3_phy_phy_power_on,
>  	.power_off	= rcar_gen3_phy_phy_power_off,
> +	.set_mode	= rcar_gen3_phy_phy_set_mode,
>  };
>  
>  static int rcar_gen3_phy_probe(struct udevice *dev)
> -- 
> 2.43.0
