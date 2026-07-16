Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD595C44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:10:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC01884D8B;
	Thu, 16 Jul 2026 18:09:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yUUDaNiA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BBF284CF1; Thu, 16 Jul 2026 15:43:25 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF57F84CE8
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-69c82519403so873938a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209402; x=1784814202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6P8tkkSMKqKTXLfZEDNrM57YC2ELvzxYjWE5iuzg+Vc=;
 b=yUUDaNiAeGG1O2rxOJMLAh3EmVSKedGEWh1/BbjIQfvWG78vs85vEC+zNC++H9K+R2
 8hyusl9f+oYXMu3U20kQ5tgfR6g/o8PQfVQ0vUqwktJTTJLfGMbCwl42q8fVOcLYkFc+
 roqxx34u1h1DKYUX2jc6raK/c/pxrXb99sxqiE9fBClZltl3ffCxt+e8dNL40QrUgtEr
 MDw4ctJSaNnMkBVqXjQCDwywxe/Qh1Od6DEX86KnKZ5HoAwUMwLH3NJlJRnOW5OFKc5r
 wukysOr3zIBglIDTjl5x6WmYd2n0oE2yEUvwoWY9Bj3Ziy6eb4rXDtPosarocbf2ysYk
 L5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209402; x=1784814202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6P8tkkSMKqKTXLfZEDNrM57YC2ELvzxYjWE5iuzg+Vc=;
 b=WPNiA7zJD2NkMKOJyPTxZixY69uIVSDVuUP1E02nUk8QNzPm+ej9oocn2txGF2f5fh
 kXU0lhPfqx+4bhJBGq4ZFYGHgLVkSgThLdGwXSutCJdPejVw3WdQTHcgXEufK+RULWZP
 gFdxcxdo6AqwaPKvEqfpRwIuX76Vp/43pz6W90Yshbne8raJ7LqkFdgUPWGKYT0J8W4w
 oPA6d2v5ddyXgoydqY/gfd8FVf6+IdcVkNJdBmQKrbvuuIqEyXT8EjKfDmCXUJu8mrLz
 jfkGPEuvm7vUmXABcvjVxC+OnuJvRVM6PfevKXcCcUM1hU8a/FYmwwjSAk89WYkQhm3Y
 QTPg==
X-Gm-Message-State: AOJu0YxOpyBe29ocjLA3Inr9LJayPVdTFVS/VxWQrQT+Q8Xwslk7yPNH
 r4tdZlP8BZqFNGs4MICVyW8nDz1intzJa0BzdkbQsCtEkyHkCd7sa3HNBnK/O7fLq/LQcT6nNFz
 kWG4R
X-Gm-Gg: AfdE7cn3wZIHJ6vRKCEL6+GugXawPN3nnV7eYRI99ZkGWc7Uq6I3WEfVaRQUax3f2VC
 kZqsGLna8tYgp/TQGPRMKh2zWcMH8p3PAO5hambvp6Ujgvj2LkF/w8o6oazJapLoPiRyYrd7qnR
 HFF54cv5+w6N8orucpsASe6dlqokzBIYRC1RI1u2glX5Ny9CdmYat0DHOYDi6bSmTiHpudiDuYq
 v+elx/iJAsxLHnYQK3NEIZYhSWlQ5Px63EZFZLPhjleAAiiYzFofsAcR4rHn87UO32VvipcPR2N
 /aAeXbmcXABL2FUdVggqEZcEbRs5rnNjMWdUXjYBZkSBeBlau6XfbgDsG6WTAw1F9tlTSd7MO7k
 B4VdWF3tGOGTH0DDPRr3WLdg8+cEg+AJNux1H5y3HuomfRGB27wisjxpq3wyzeFjTKABTuYTIE0
 dGWizcMHJw7OVdq4gyPZIaPePCRRkIv2YpnEYdZQ==
X-Received: by 2002:a05:6402:2694:b0:699:6415:751e with SMTP id
 4fb4d7f45d1cf-69c5f130032mr5954987a12.4.1784209402092; 
 Thu, 16 Jul 2026 06:43:22 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69cd295656fsm4633217a12.29.2026.07.16.06.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:43:21 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 09/75] usb: dwc3: import from kernel v4.6
Date: Thu, 16 Jul 2026 15:41:39 +0200
Message-ID: <20260716134305.614278-10-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716134305.614278-1-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 Jul 2026 18:09:05 +0200
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

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v4.5 to v4.6.

The following files are preserved accross the import:
Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
dwc3-layerscape.c ti_usb_phy.c

Skipping unused files:
debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c

Note that this is a raw import and doesn't build.
A fixup commit at the end of the series fixes that.

List of commits: git log --oneline v4.5..v4.6
Commits imported:
9772b47a4c29 usb: dwc3: gadget: Fix suspend/resume during device mode
e6bdf8195b4a usb: dwc3: fix memory leak of dwc->regset
5c4ad318de3b usb: dwc3: core: fix PHY handling during suspend
45d49cb706e5 usb: dwc3: omap: fix up error path on probe()
adf9a3ab90eb usb: dwc3: keystone: drop dma_mask configuration
1ffb4d5cc78a usb: dwc3: pci: add ID for one more Intel Broxton platform
e901aa159dac usb: dwc3: gadget: fix endpoint renaming
ad14d4e0308a usb: dwc3: gadget: release spin lock during gadget resume
f59dcab17629 usb: dwc3: core: improve reset sequence
77966eb85e6d usb: dwc3: Validate the maximum_speed parameter
7580862b3e80 usb: dwc3: Enable SuperSpeedPlus
2c7f1bd9127a usb: dwc3: Update maximum_speed for SuperSpeedPlus
ee5cd41c9117 usb: dwc3: Update speed checks for SuperSpeedPlus
1f38f88a24c8 usb: dwc3: Update register fields for SuperSpeedPlus
c4137a9c841e usb: dwc3: DWC_usb31 controller check
3d755dcc20dd usb: dwc3: Remove impossible check for of_clk_get_parent_count() < 0

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c   | 102 +++++++++++++++++++++++++-------------
 drivers/usb/dwc3/core.h   |  11 +++-
 drivers/usb/dwc3/ep0.c    |   9 ++--
 drivers/usb/dwc3/gadget.c |  47 ++++++++++++++----
 4 files changed, 119 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index de5e01f41bc2..34277ced26bd 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -67,23 +67,9 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 static int dwc3_core_soft_reset(struct dwc3 *dwc)
 {
 	u32		reg;
+	int		retries = 1000;
 	int		ret;
 
-	/* Before Resetting PHY, put Core in Reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg |= DWC3_GCTL_CORESOFTRESET;
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
-
-	/* Assert USB3 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	reg |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
-
-	/* Assert USB2 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	reg |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-
 	usb_phy_init(dwc->usb2_phy);
 	usb_phy_init(dwc->usb3_phy);
 	ret = phy_init(dwc->usb2_generic_phy);
@@ -95,26 +81,28 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 		phy_exit(dwc->usb2_generic_phy);
 		return ret;
 	}
-	mdelay(100);
 
-	/* Clear USB3 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
-	reg &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
+	/*
+	 * We're resetting only the device side because, if we're in host mode,
+	 * XHCI driver will reset the host block. If dwc3 was configured for
+	 * host-only mode, then we can return early.
+	 */
+	if (dwc->dr_mode == USB_DR_MODE_HOST)
+		return 0;
 
-	/* Clear USB2 PHY reset */
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	reg &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
-	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+	reg |= DWC3_DCTL_CSFTRST;
+	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
-	mdelay(100);
+	do {
+		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+		if (!(reg & DWC3_DCTL_CSFTRST))
+			return 0;
 
-	/* After PHYs are stable we can take Core out of reset state */
-	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
-	reg &= ~DWC3_GCTL_CORESOFTRESET;
-	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+		udelay(1);
+	} while (--retries);
 
-	return 0;
+	return -ETIMEDOUT;
 }
 
 /**
@@ -962,10 +950,6 @@ static int dwc3_probe(struct platform_device *pdev)
 		fladj = pdata->fladj_value;
 	}
 
-	/* default to superspeed if no maximum_speed passed */
-	if (dwc->maximum_speed == USB_SPEED_UNKNOWN)
-		dwc->maximum_speed = USB_SPEED_SUPER;
-
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
@@ -1016,6 +1000,33 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	/* Check the maximum_speed parameter */
+	switch (dwc->maximum_speed) {
+	case USB_SPEED_LOW:
+	case USB_SPEED_FULL:
+	case USB_SPEED_HIGH:
+	case USB_SPEED_SUPER:
+	case USB_SPEED_SUPER_PLUS:
+		break;
+	default:
+		dev_err(dev, "invalid maximum_speed parameter %d\n",
+			dwc->maximum_speed);
+		/* fall through */
+	case USB_SPEED_UNKNOWN:
+		/* default to superspeed */
+		dwc->maximum_speed = USB_SPEED_SUPER;
+
+		/*
+		 * default to superspeed plus if we are capable.
+		 */
+		if (dwc3_is_usb31(dwc) &&
+		    (DWC3_GHWPARAMS3_SSPHY_IFC(dwc->hwparams.hwparams3) ==
+		     DWC3_GHWPARAMS3_SSPHY_IFC_GEN2))
+			dwc->maximum_speed = USB_SPEED_SUPER_PLUS;
+
+		break;
+	}
+
 	/* Adjust Frame Length */
 	dwc3_frame_length_adjustment(dwc, fladj);
 
@@ -1139,6 +1150,11 @@ static int dwc3_suspend(struct device *dev)
 	phy_exit(dwc->usb2_generic_phy);
 	phy_exit(dwc->usb3_generic_phy);
 
+	usb_phy_set_suspend(dwc->usb2_phy, 1);
+	usb_phy_set_suspend(dwc->usb3_phy, 1);
+	WARN_ON(phy_power_off(dwc->usb2_generic_phy) < 0);
+	WARN_ON(phy_power_off(dwc->usb3_generic_phy) < 0);
+
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
@@ -1152,11 +1168,21 @@ static int dwc3_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
+	usb_phy_set_suspend(dwc->usb2_phy, 0);
+	usb_phy_set_suspend(dwc->usb3_phy, 0);
+	ret = phy_power_on(dwc->usb2_generic_phy);
+	if (ret < 0)
+		return ret;
+
+	ret = phy_power_on(dwc->usb3_generic_phy);
+	if (ret < 0)
+		goto err_usb2phy_power;
+
 	usb_phy_init(dwc->usb3_phy);
 	usb_phy_init(dwc->usb2_phy);
 	ret = phy_init(dwc->usb2_generic_phy);
 	if (ret < 0)
-		return ret;
+		goto err_usb3phy_power;
 
 	ret = phy_init(dwc->usb3_generic_phy);
 	if (ret < 0)
@@ -1189,6 +1215,12 @@ static int dwc3_resume(struct device *dev)
 err_usb2phy_init:
 	phy_exit(dwc->usb2_generic_phy);
 
+err_usb3phy_power:
+	phy_power_off(dwc->usb3_generic_phy);
+
+err_usb2phy_power:
+	phy_power_off(dwc->usb2_generic_phy);
+
 	return ret;
 }
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index e4f8b90d9627..6254b2ff9080 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -223,7 +223,8 @@
 /* Global HWPARAMS3 Register */
 #define DWC3_GHWPARAMS3_SSPHY_IFC(n)		((n) & 3)
 #define DWC3_GHWPARAMS3_SSPHY_IFC_DIS		0
-#define DWC3_GHWPARAMS3_SSPHY_IFC_ENA		1
+#define DWC3_GHWPARAMS3_SSPHY_IFC_GEN1		1
+#define DWC3_GHWPARAMS3_SSPHY_IFC_GEN2		2 /* DWC_usb31 only */
 #define DWC3_GHWPARAMS3_HSPHY_IFC(n)		(((n) & (3 << 2)) >> 2)
 #define DWC3_GHWPARAMS3_HSPHY_IFC_DIS		0
 #define DWC3_GHWPARAMS3_HSPHY_IFC_UTMI		1
@@ -249,6 +250,7 @@
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
 
 #define DWC3_DCFG_SPEED_MASK	(7 << 0)
+#define DWC3_DCFG_SUPERSPEED_PLUS (5 << 0)  /* DWC_usb31 only */
 #define DWC3_DCFG_SUPERSPEED	(4 << 0)
 #define DWC3_DCFG_HIGHSPEED	(0 << 0)
 #define DWC3_DCFG_FULLSPEED2	(1 << 0)
@@ -339,6 +341,7 @@
 
 #define DWC3_DSTS_CONNECTSPD		(7 << 0)
 
+#define DWC3_DSTS_SUPERSPEED_PLUS	(5 << 0) /* DWC_usb31 only */
 #define DWC3_DSTS_SUPERSPEED		(4 << 0)
 #define DWC3_DSTS_HIGHSPEED		(0 << 0)
 #define DWC3_DSTS_FULLSPEED2		(1 << 0)
@@ -1024,6 +1027,12 @@ struct dwc3_gadget_ep_cmd_params {
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode);
 int dwc3_gadget_resize_tx_fifos(struct dwc3 *dwc);
 
+/* check whether we are on the DWC_usb31 core */
+static inline bool dwc3_is_usb31(struct dwc3 *dwc)
+{
+	return !!(dwc->revision & DWC3_REVISION_IS_DWC31);
+}
+
 #if IS_ENABLED(CONFIG_USB_DWC3_HOST) || IS_ENABLED(CONFIG_USB_DWC3_DUAL_ROLE)
 int dwc3_host_init(struct dwc3 *dwc);
 void dwc3_host_exit(struct dwc3 *dwc);
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 8d6b75c2f53b..eca2e6d8e041 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -356,7 +356,8 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 		 */
 		usb_status |= dwc->gadget.is_selfpowered;
 
-		if (dwc->speed == DWC3_DSTS_SUPERSPEED) {
+		if ((dwc->speed == DWC3_DSTS_SUPERSPEED) ||
+		    (dwc->speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 			if (reg & DWC3_DCTL_INITU1ENA)
 				usb_status |= 1 << USB_DEV_STAT_U1_ENABLED;
@@ -426,7 +427,8 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 		case USB_DEVICE_U1_ENABLE:
 			if (state != USB_STATE_CONFIGURED)
 				return -EINVAL;
-			if (dwc->speed != DWC3_DSTS_SUPERSPEED)
+			if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
+			    (dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 				return -EINVAL;
 
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
@@ -440,7 +442,8 @@ static int dwc3_ep0_handle_feature(struct dwc3 *dwc,
 		case USB_DEVICE_U2_ENABLE:
 			if (state != USB_STATE_CONFIGURED)
 				return -EINVAL;
-			if (dwc->speed != DWC3_DSTS_SUPERSPEED)
+			if ((dwc->speed != DWC3_DSTS_SUPERSPEED) &&
+			    (dwc->speed != DWC3_DSTS_SUPERSPEED_PLUS))
 				return -EINVAL;
 
 			reg = dwc3_readl(dwc->regs, DWC3_DCTL);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 2363bad45af8..8e4a1b195e9b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -463,7 +463,7 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 		| DWC3_DEPCFG_MAX_PACKET_SIZE(usb_endpoint_maxp(desc));
 
 	/* Burst size is only needed in SuperSpeed mode */
-	if (dwc->gadget.speed == USB_SPEED_SUPER) {
+	if (dwc->gadget.speed >= USB_SPEED_SUPER) {
 		u32 burst = dep->endpoint.maxburst - 1;
 
 		params.param0 |= DWC3_DEPCFG_BURST_SIZE(burst);
@@ -568,7 +568,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
 		if (!usb_endpoint_xfer_isoc(desc))
-			return 0;
+			goto out;
 
 		/* Link TRB for ISOC. The HWO bit is never reset */
 		trb_st_hw = &dep->trb_pool[0];
@@ -582,9 +582,10 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		trb_link->ctrl |= DWC3_TRB_CTRL_HWO;
 	}
 
+out:
 	switch (usb_endpoint_type(desc)) {
 	case USB_ENDPOINT_XFER_CONTROL:
-		strlcat(dep->name, "-control", sizeof(dep->name));
+		/* don't change name */
 		break;
 	case USB_ENDPOINT_XFER_ISOC:
 		strlcat(dep->name, "-isoc", sizeof(dep->name));
@@ -1441,7 +1442,8 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	reg = dwc3_readl(dwc->regs, DWC3_DSTS);
 
 	speed = reg & DWC3_DSTS_CONNECTSPD;
-	if (speed == DWC3_DSTS_SUPERSPEED) {
+	if ((speed == DWC3_DSTS_SUPERSPEED) ||
+	    (speed == DWC3_DSTS_SUPERSPEED_PLUS)) {
 		dwc3_trace(trace_dwc3_gadget, "no wakeup on SuperSpeed\n");
 		ret = -EINVAL;
 		goto out;
@@ -1666,10 +1668,16 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 		case USB_SPEED_HIGH:
 			reg |= DWC3_DSTS_HIGHSPEED;
 			break;
-		case USB_SPEED_SUPER:	/* FALLTHROUGH */
-		case USB_SPEED_UNKNOWN:	/* FALTHROUGH */
+		case USB_SPEED_SUPER_PLUS:
+			reg |= DWC3_DSTS_SUPERSPEED_PLUS;
+			break;
 		default:
-			reg |= DWC3_DSTS_SUPERSPEED;
+			dev_err(dwc->dev, "invalid dwc->maximum_speed (%d)\n",
+				dwc->maximum_speed);
+			/* fall through */
+		case USB_SPEED_SUPER:
+			reg |= DWC3_DCFG_SUPERSPEED;
+			break;
 		}
 	}
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
@@ -2340,7 +2348,8 @@ static void dwc3_update_ram_clk_sel(struct dwc3 *dwc, u32 speed)
 	 * this. Maybe it becomes part of the power saving plan.
 	 */
 
-	if (speed != DWC3_DSTS_SUPERSPEED)
+	if ((speed != DWC3_DSTS_SUPERSPEED) &&
+	    (speed != DWC3_DSTS_SUPERSPEED_PLUS))
 		return;
 
 	/*
@@ -2369,6 +2378,11 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 	dwc3_update_ram_clk_sel(dwc, speed);
 
 	switch (speed) {
+	case DWC3_DCFG_SUPERSPEED_PLUS:
+		dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
+		dwc->gadget.ep0->maxpacket = 512;
+		dwc->gadget.speed = USB_SPEED_SUPER_PLUS;
+		break;
 	case DWC3_DCFG_SUPERSPEED:
 		/*
 		 * WORKAROUND: DWC3 revisions <1.90a have an issue which
@@ -2410,8 +2424,9 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 
 	/* Enable USB2 LPM Capability */
 
-	if ((dwc->revision > DWC3_REVISION_194A)
-			&& (speed != DWC3_DCFG_SUPERSPEED)) {
+	if ((dwc->revision > DWC3_REVISION_194A) &&
+	    (speed != DWC3_DCFG_SUPERSPEED) &&
+	    (speed != DWC3_DCFG_SUPERSPEED_PLUS)) {
 		reg = dwc3_readl(dwc->regs, DWC3_DCFG);
 		reg |= DWC3_DCFG_LPM_CAP;
 		dwc3_writel(dwc->regs, DWC3_DCFG, reg);
@@ -2473,7 +2488,11 @@ static void dwc3_gadget_wakeup_interrupt(struct dwc3 *dwc)
 	 * implemented.
 	 */
 
-	dwc->gadget_driver->resume(&dwc->gadget);
+	if (dwc->gadget_driver && dwc->gadget_driver->resume) {
+		spin_unlock(&dwc->lock);
+		dwc->gadget_driver->resume(&dwc->gadget);
+		spin_lock(&dwc->lock);
+	}
 }
 
 static void dwc3_gadget_linksts_change_interrupt(struct dwc3 *dwc,
@@ -2917,6 +2936,9 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
+	if (!dwc->gadget_driver)
+		return 0;
+
 	if (dwc->pullups_connected) {
 		dwc3_gadget_disable_irq(dwc);
 		dwc3_gadget_run_stop(dwc, true, true);
@@ -2935,6 +2957,9 @@ int dwc3_gadget_resume(struct dwc3 *dwc)
 	struct dwc3_ep		*dep;
 	int			ret;
 
+	if (!dwc->gadget_driver)
+		return 0;
+
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
-- 
2.53.0

