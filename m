Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3430ECD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 283BC84A6D;
	Thu,  7 May 2026 11:29:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N31p92vp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7552284A72; Thu,  7 May 2026 11:29:28 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CF7784A17
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5a8721851e2so551529e87.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146163; x=1778750963; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sepqulPvbiEnrEPF/xMfszI0I7gc/Kz9qO+QrpuBfzg=;
 b=N31p92vplAzaVb64Iw+V9El02dG1MOcj5HV4+lrN2qczVbgojR1igLurHzhOnVS/XI
 +OV8RQmXtbrWzIvXo9IiL06OSayaPOe4tQibL0eqnh8IQfm4V9cFhTLGxSdS5JsEMorH
 8kuRLLXXiyidgzqgDcROJZy6AGUwK5RFwRmOAuvyBOeMDyQIDEm5mkVWkkbci6nc+cM5
 ZUovSSp46D73IU1qeroZ/pAOLoPiMrL+hB8uD1Xds34DYDXloPT8X5Yz1r8PIndRrm+1
 oKLmVFl1nuFhQvXPdP+ntEu1lM/Q0zeBFxWxb0CQfOdhWXLXwn8pY7k0NAX+XTM9WTzZ
 M2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146163; x=1778750963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sepqulPvbiEnrEPF/xMfszI0I7gc/Kz9qO+QrpuBfzg=;
 b=E8FM3Ln4nzCZh/WtWiffCmuQrvFSwP9LY//S2PC/9R+cKmx1iaiK+M6WM26SMb/As2
 ZAMVJT34Du68WY1CEdP/LukWeUMTAMqp1E6mdQiXDLEH/h6eWAKHcOcvpMgnox6TPYfE
 ETuOnf/NXmjiw77SesEWbAxs7W4ZgwGkWmUtRc767h9GxB3yFDFQ3axDEv6daqv4oPPP
 l1wOfn8N2J7/k2Glh8mxyzMQYOgi63qaAl4bnn4IORPujPrnxzV0NtxJUz1BdLvgEH4r
 IqJ1Mr4W1mRgTf84Kou198kJNWHyEdQqeJEFfA3F95HcwPOantqyt6lCfDnyNXULMRg3
 BTGQ==
X-Gm-Message-State: AOJu0YwpbF+QPgblu4J5INIpDxj/b26vbH52auLErpPb+tgdns0F2Rme
 l1WkuBQQsHdIBTlUDORbFMpDK2CW/YbQJgFttOTRZShjf8RwtY/Fgu7wZwrwpjmUTJJBxDb6jJJ
 ItLX1K0FzhA==
X-Gm-Gg: AeBDiesGnNk48hwQz3oVvZHm2XeSpWFUFm4jgwn/CgMLQu4j8lL+9gF9Walq1MOL4tW
 vsALmprRaCPFoocFjgfYu0PRiHQCocigqJL0iGGzox8t4oh3cBv9ER8TLzD4eBRPONGdknCgd4U
 ciq8PKVOtYXZjlJGE2xuEjpz6i1CamMeKdloA25y56nrW+KYMp/qhU4Wi7oQDLyr83Gf6rB8ldF
 Vrw334m7zq0lUmK5Lf3moag8nSfN3FpvKuZEb9LRm+VmLs9THVnWfZdUp/olefDtDsulMBZndQj
 TMCC3wRsgg9Kluh2cWuLNLI0VPLDarh6c8ZS0f840s/F4/6lLbqI7noKdTP5YWVowY0A3e3CJIj
 /2ajyjGaD5Gdxva/NM11UvnBrYUbCnZWmp6/7Hc6ahgk6Ivyv0tMWqD3hVYmFNd6nQM2fJJiOOV
 Pr7e0egtP12xvW2Nj0/MloxC0XTbj1EypogN2PrAua0/V2xD3bDnmNJ2DR7VxjB5QWA4xyEBMa0
 GCRlV/aeWqn06929EqpdHj7DuY6fBUlOCFB64N2Bg==
X-Received: by 2002:a05:6512:131e:b0:5a2:b51a:6a55 with SMTP id
 2adb3069b0e04-5a887ce9af4mr2976646e87.29.1778146162770; 
 Thu, 07 May 2026 02:29:22 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:21 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [RFC PATCH v2 12/64] usb: dwc3: import from kernel v4.9
Date: Thu,  7 May 2026 11:27:19 +0200
Message-ID: <20260507092843.358908-13-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Sync Linux kernel dwc3 changes from v4.8 to v4.9.

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

List of commits: git log --oneline v4.8..v4.9
Commits imported:
4accb8a1ee7d usb: dwc3: st: add missing <linux/pinctrl/consumer.h> include
9b9d7cdd0a20 usb: dwc3: Fix error handling for core init
51fbc7c06c89 usb: dwc3: Fix size used in dma_free_coherent()
d889c23ce4e3 usb: dwc3: gadget: never pre-start Isochronous endpoints
a9c3ca5fae6b usb: dwc3: gadget: properly account queued requests
81522637485d Merge tag 'usb-for-v4.9' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
b281dc630b41 usb: dwc3: of-simple: add compatible for Cavium
26c9cac402c4 usb: dwc3: of-simple: allow glues without clocks
fc9104d5d717 Merge 4.8-rc6 into usb-next
8d53e6267594 usb: dwc3: of-simple: Fix warning during unbind
5e6c88d28ccb usb: dwc3: fix Clear Stall EP command failure
d6e10bf2ba47 usb: dwc3: avoid -Wmaybe-uninitialized warning
9d6173e125d9 usb: dwc3: Fix dr_mode validation
073c47aca7b7 usb: dwc3: ulpi: make dwc3_ulpi_ops constant
e6f74849784c usb: ulpi: rename operations {read|write}_dev to simply {read|write}
b7cf1dc3414d usb: dwc3: ulpi: use new api
9b0dd49e3565 Merge 4.8-rc5 into usb-testing
594e121f2568 usb: dwc3: gadget: stop kicking if we run out of space
7ae7df4982af usb: dwc3: gadget: abolish trbs_left
06281d460fc5 usb: dwc3: Add ENDXFER command polling
512e47572f7d usb: dwc3: Add revision numbers for the USB 3.0 IP
00af62330c39 usb: dwc3: core: Move the mode setting to the right place
f652191be3f6 usb: dwc3: of-simple: add compatible for rockchip rk3399
00fe081dc3a3 usb: dwc3: add dis_del_phy_power_chg_quirk
32f2ed864dd5 usb: dwc3: make usb2 phy utmi interface configurable
16199f338939 usb: dwc3: add dis_u2_freeclk_exists_quirk
dc55c67e9c95 usb: dwc3: gadget: improve increment request->actual
f99f53f24d87 usb: dwc3: gadget: remove condition that never happens
1f512119a08c usb: dwc3: gadget: add remaining sg entries to ring
2c78c0295fd8 usb: dwc3: gadget: interrupt on ring full too
0b3e4af3c740 usb: dwc3: gadget: add sg and num_pending_sgs to dwc3_request
31162af447d7 usb: dwc3: gadget: avoid while (1) loop on completion
08a36b543803 usb: dwc3: gadget: simplify __dwc3_gadget_ep_queue()
45438a0cd9c2 usb: dwc3: gadget: simplify dwc3_ep_prev_trb()
737f1ae2556a usb: dwc3: gadget: increment dequeue pointer on completion
4bc48c974708 usb: dwc3: gadget: retire LST bit completely
1aaaa9acaea1 Merge 4.8-rc3 into usb-next
a26a142275c6 usb: remove redundant dependency on USB_SUPPORT

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c   | 127 ++++++++++++++---
 drivers/usb/dwc3/core.h   |  35 ++++-
 drivers/usb/dwc3/gadget.c | 292 +++++++++++++++-----------------------
 3 files changed, 258 insertions(+), 196 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 35d092456bec..fea446900cad 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -49,6 +49,57 @@
 
 #define DWC3_DEFAULT_AUTOSUSPEND_DELAY	5000 /* ms */
 
+/**
+ * dwc3_get_dr_mode - Validates and sets dr_mode
+ * @dwc: pointer to our context structure
+ */
+static int dwc3_get_dr_mode(struct dwc3 *dwc)
+{
+	enum usb_dr_mode mode;
+	struct device *dev = dwc->dev;
+	unsigned int hw_mode;
+
+	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
+		dwc->dr_mode = USB_DR_MODE_OTG;
+
+	mode = dwc->dr_mode;
+	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
+
+	switch (hw_mode) {
+	case DWC3_GHWPARAMS0_MODE_GADGET:
+		if (IS_ENABLED(CONFIG_USB_DWC3_HOST)) {
+			dev_err(dev,
+				"Controller does not support host mode.\n");
+			return -EINVAL;
+		}
+		mode = USB_DR_MODE_PERIPHERAL;
+		break;
+	case DWC3_GHWPARAMS0_MODE_HOST:
+		if (IS_ENABLED(CONFIG_USB_DWC3_GADGET)) {
+			dev_err(dev,
+				"Controller does not support device mode.\n");
+			return -EINVAL;
+		}
+		mode = USB_DR_MODE_HOST;
+		break;
+	default:
+		if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
+			mode = USB_DR_MODE_HOST;
+		else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET))
+			mode = USB_DR_MODE_PERIPHERAL;
+	}
+
+	if (mode != dwc->dr_mode) {
+		dev_warn(dev,
+			 "Configuration mismatch. dr_mode forced to %s\n",
+			 mode == USB_DR_MODE_HOST ? "host" : "gadget");
+
+		dwc->dr_mode = mode;
+	}
+
+	return 0;
+}
+
 void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 {
 	u32 reg;
@@ -448,6 +499,9 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_u3_susphy_quirk)
 		reg &= ~DWC3_GUSB3PIPECTL_SUSPHY;
 
+	if (dwc->dis_del_phy_power_chg_quirk)
+		reg &= ~DWC3_GUSB3PIPECTL_DEPOCHANGE;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
@@ -485,6 +539,23 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 		break;
 	}
 
+	switch (dwc->hsphy_mode) {
+	case USBPHY_INTERFACE_MODE_UTMI:
+		reg &= ~(DWC3_GUSB2PHYCFG_PHYIF_MASK |
+		       DWC3_GUSB2PHYCFG_USBTRDTIM_MASK);
+		reg |= DWC3_GUSB2PHYCFG_PHYIF(UTMI_PHYIF_8_BIT) |
+		       DWC3_GUSB2PHYCFG_USBTRDTIM(USBTRDTIM_UTMI_8_BIT);
+		break;
+	case USBPHY_INTERFACE_MODE_UTMIW:
+		reg &= ~(DWC3_GUSB2PHYCFG_PHYIF_MASK |
+		       DWC3_GUSB2PHYCFG_USBTRDTIM_MASK);
+		reg |= DWC3_GUSB2PHYCFG_PHYIF(UTMI_PHYIF_16_BIT) |
+		       DWC3_GUSB2PHYCFG_USBTRDTIM(USBTRDTIM_UTMI_16_BIT);
+		break;
+	default:
+		break;
+	}
+
 	/*
 	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
 	 * '0' during coreConsultant configuration. So default value will
@@ -500,6 +571,9 @@ static int dwc3_phy_setup(struct dwc3 *dwc)
 	if (dwc->dis_enblslpm_quirk)
 		reg &= ~DWC3_GUSB2PHYCFG_ENBLSLPM;
 
+	if (dwc->dis_u2_freeclk_exists_quirk)
+		reg &= ~DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS;
+
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
 	return 0;
@@ -666,18 +740,43 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		goto err4;
 	}
 
+	switch (dwc->dr_mode) {
+	case USB_DR_MODE_PERIPHERAL:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+		break;
+	case USB_DR_MODE_HOST:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+		break;
+	case USB_DR_MODE_OTG:
+		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+		break;
+	default:
+		dev_warn(dwc->dev, "Unsupported mode %d\n", dwc->dr_mode);
+		break;
+	}
+
+	/*
+	 * ENDXFER polling is available on version 3.10a and later of
+	 * the DWC_usb3 controller. It is NOT available in the
+	 * DWC_usb31 controller.
+	 */
+	if (!dwc3_is_usb31(dwc) && dwc->revision >= DWC3_REVISION_310A) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUCTL2);
+		reg |= DWC3_GUCTL2_RST_ACTBITLATER;
+		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
+	}
+
 	return 0;
 
 err4:
-	phy_power_off(dwc->usb2_generic_phy);
+	phy_power_off(dwc->usb3_generic_phy);
 
 err3:
-	phy_power_off(dwc->usb3_generic_phy);
+	phy_power_off(dwc->usb2_generic_phy);
 
 err2:
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
-	dwc3_core_exit(dwc);
 
 err1:
 	usb_phy_shutdown(dwc->usb2_phy);
@@ -763,7 +862,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
@@ -772,7 +870,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_HOST:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
@@ -781,7 +878,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_OTG:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
@@ -888,6 +984,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc->maximum_speed = usb_get_maximum_speed(dev);
 	dwc->dr_mode = usb_get_dr_mode(dev);
+	dwc->hsphy_mode = of_usb_get_phy_mode(dev->of_node);
 
 	dwc->has_lpm_erratum = device_property_read_bool(dev,
 				"snps,has-lpm-erratum");
@@ -924,6 +1021,10 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,dis_enblslpm_quirk");
 	dwc->dis_rxdet_inp3_quirk = device_property_read_bool(dev,
 				"snps,dis_rxdet_inp3_quirk");
+	dwc->dis_u2_freeclk_exists_quirk = device_property_read_bool(dev,
+				"snps,dis-u2-freeclk-exists-quirk");
+	dwc->dis_del_phy_power_chg_quirk = device_property_read_bool(dev,
+				"snps,dis-del-phy-power-chg-quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
@@ -972,17 +1073,9 @@ static int dwc3_probe(struct platform_device *pdev)
 		goto err2;
 	}
 
-	if (IS_ENABLED(CONFIG_USB_DWC3_HOST) &&
-			(dwc->dr_mode == USB_DR_MODE_OTG ||
-					dwc->dr_mode == USB_DR_MODE_UNKNOWN))
-		dwc->dr_mode = USB_DR_MODE_HOST;
-	else if (IS_ENABLED(CONFIG_USB_DWC3_GADGET) &&
-			(dwc->dr_mode == USB_DR_MODE_OTG ||
-					dwc->dr_mode == USB_DR_MODE_UNKNOWN))
-		dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
-
-	if (dwc->dr_mode == USB_DR_MODE_UNKNOWN)
-		dwc->dr_mode = USB_DR_MODE_OTG;
+	ret = dwc3_get_dr_mode(dwc);
+	if (ret)
+		goto err3;
 
 	ret = dwc3_alloc_scratch_buffers(dwc);
 	if (ret)
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 45d6de5107c7..6b60e42626a2 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -109,6 +109,7 @@
 #define DWC3_GPRTBIMAP_HS1	0xc184
 #define DWC3_GPRTBIMAP_FS0	0xc188
 #define DWC3_GPRTBIMAP_FS1	0xc18c
+#define DWC3_GUCTL2		0xc19c
 
 #define DWC3_VER_NUMBER		0xc1a0
 #define DWC3_VER_TYPE		0xc1a4
@@ -199,9 +200,18 @@
 
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
+#define DWC3_GUSB2PHYCFG_U2_FREECLK_EXISTS	(1 << 30)
 #define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
 #define DWC3_GUSB2PHYCFG_ULPI_UTMI	(1 << 4)
 #define DWC3_GUSB2PHYCFG_ENBLSLPM	(1 << 8)
+#define DWC3_GUSB2PHYCFG_PHYIF(n)	(n << 3)
+#define DWC3_GUSB2PHYCFG_PHYIF_MASK	DWC3_GUSB2PHYCFG_PHYIF(1)
+#define DWC3_GUSB2PHYCFG_USBTRDTIM(n)	(n << 10)
+#define DWC3_GUSB2PHYCFG_USBTRDTIM_MASK	DWC3_GUSB2PHYCFG_USBTRDTIM(0xf)
+#define USBTRDTIM_UTMI_8_BIT		9
+#define USBTRDTIM_UTMI_16_BIT		5
+#define UTMI_PHYIF_16_BIT		1
+#define UTMI_PHYIF_8_BIT		0
 
 /* Global USB2 PHY Vendor Control Register */
 #define DWC3_GUSB2PHYACC_NEWREGREQ	(1 << 25)
@@ -235,7 +245,10 @@
 #define DWC3_GEVNTSIZ_SIZE(n)		((n) & 0xffff)
 
 /* Global HWPARAMS0 Register */
-#define DWC3_GHWPARAMS0_USB3_MODE(n)	((n) & 0x3)
+#define DWC3_GHWPARAMS0_MODE(n)		((n) & 0x3)
+#define DWC3_GHWPARAMS0_MODE_GADGET	0
+#define DWC3_GHWPARAMS0_MODE_HOST	1
+#define DWC3_GHWPARAMS0_MODE_DRD	2
 #define DWC3_GHWPARAMS0_MBUS_TYPE(n)	(((n) >> 3) & 0x7)
 #define DWC3_GHWPARAMS0_SBUS_TYPE(n)	(((n) >> 6) & 0x3)
 #define DWC3_GHWPARAMS0_MDWIDTH(n)	(((n) >> 8) & 0xff)
@@ -279,6 +292,9 @@
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		(1 << 7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
 
+/* Global User Control Register 2 */
+#define DWC3_GUCTL2_RST_ACTBITLATER		(1 << 14)
+
 /* Device Configuration Register */
 #define DWC3_DCFG_DEVADDR(addr)	((addr) << 3)
 #define DWC3_DCFG_DEVADDR_MASK	DWC3_DCFG_DEVADDR(0x7f)
@@ -685,6 +701,8 @@ struct dwc3_hwparams {
  * @request: struct usb_request to be transferred
  * @list: a list_head used for request queueing
  * @dep: struct dwc3_ep owning this request
+ * @sg: pointer to first incomplete sg
+ * @num_pending_sgs: counter to pending sgs
  * @first_trb_index: index to first trb used by this request
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
@@ -697,7 +715,9 @@ struct dwc3_request {
 	struct usb_request	request;
 	struct list_head	list;
 	struct dwc3_ep		*dep;
+	struct scatterlist	*sg;
 
+	unsigned		num_pending_sgs;
 	u8			first_trb_index;
 	u8			epnum;
 	struct dwc3_trb		*trb;
@@ -743,6 +763,9 @@ struct dwc3_scratchpad_array {
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
  * @revision: revision register contents
  * @dr_mode: requested mode of operation
+ * @hsphy_mode: UTMI phy mode, one of following:
+ *		- USBPHY_INTERFACE_MODE_UTMI
+ *		- USBPHY_INTERFACE_MODE_UTMIW
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -799,6 +822,11 @@ struct dwc3_scratchpad_array {
  * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy
  * @dis_enblslpm_quirk: set if we clear enblslpm in GUSB2PHYCFG,
  *                      disabling the suspend signal to the PHY.
+ * @dis_u2_freeclk_exists_quirk : set if we clear u2_freeclk_exists
+ *			in GUSB2PHYCFG, specify that USB2 PHY doesn't
+ *			provide a free-running PHY clock.
+ * @dis_del_phy_power_chg_quirk: set if we disable delay phy power
+ *			change quirk.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  * 	0	- -6dB de-emphasis
@@ -845,6 +873,7 @@ struct dwc3 {
 	size_t			regs_size;
 
 	enum usb_dr_mode	dr_mode;
+	enum usb_phy_interface	hsphy_mode;
 
 	u32			fladj;
 	u32			irq_gadget;
@@ -880,6 +909,8 @@ struct dwc3 {
 #define DWC3_REVISION_260A	0x5533260a
 #define DWC3_REVISION_270A	0x5533270a
 #define DWC3_REVISION_280A	0x5533280a
+#define DWC3_REVISION_300A	0x5533300a
+#define DWC3_REVISION_310A	0x5533310a
 
 /*
  * NOTICE: we're using bit 31 as a "is usb 3.1" flag. This is really
@@ -942,6 +973,8 @@ struct dwc3 {
 	unsigned		dis_u2_susphy_quirk:1;
 	unsigned		dis_enblslpm_quirk:1;
 	unsigned		dis_rxdet_inp3_quirk:1;
+	unsigned		dis_u2_freeclk_exists_quirk:1;
+	unsigned		dis_del_phy_power_chg_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 122e64df2f4d..1dfa56a5f1c5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -174,15 +174,8 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status)
 {
 	struct dwc3			*dwc = dep->dwc;
-	int				i;
 
-	if (req->started) {
-		i = 0;
-		do {
-			dwc3_ep_inc_deq(dep);
-		} while(++i < req->request.num_mapped_sgs);
-		req->started = false;
-	}
+	req->started = false;
 	list_del(&req->list);
 	req->trb = NULL;
 
@@ -348,7 +341,8 @@ static int dwc3_send_clear_stall_ep_cmd(struct dwc3_ep *dep)
 	 * IN transfers due to a mishandled error condition. Synopsys
 	 * STAR 9000614252.
 	 */
-	if (dep->direction && (dwc->revision >= DWC3_REVISION_260A))
+	if (dep->direction && (dwc->revision >= DWC3_REVISION_260A) &&
+	    (dwc->gadget.speed >= USB_SPEED_SUPER))
 		cmd |= DWC3_DEPCMD_CLEARPENDIN;
 
 	memset(&params, 0, sizeof(params));
@@ -490,7 +484,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3 *dwc, struct dwc3_ep *dep,
 		params.param0 |= DWC3_DEPCFG_ACTION_INIT;
 	}
 
-	params.param1 = DWC3_DEPCFG_XFER_COMPLETE_EN;
+	if (usb_endpoint_xfer_control(desc))
+		params.param1 = DWC3_DEPCFG_XFER_COMPLETE_EN;
 
 	if (dep->number <= 1 || usb_endpoint_xfer_isoc(desc))
 		params.param1 |= DWC3_DEPCFG_XFER_NOT_READY_EN;
@@ -764,6 +759,8 @@ static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
 	kfree(req);
 }
 
+static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep);
+
 /**
  * dwc3_prepare_one_trb - setup one TRB from one request
  * @dep: endpoint for which this request is prepared
@@ -771,15 +768,13 @@ static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
  */
 static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		struct dwc3_request *req, dma_addr_t dma,
-		unsigned length, unsigned last, unsigned chain, unsigned node)
+		unsigned length, unsigned chain, unsigned node)
 {
 	struct dwc3_trb		*trb;
 
-	dwc3_trace(trace_dwc3_gadget, "%s: req %p dma %08llx length %d%s%s",
+	dwc3_trace(trace_dwc3_gadget, "%s: req %p dma %08llx length %d%s",
 			dep->name, req, (unsigned long long) dma,
-			length, last ? " last" : "",
-			chain ? " chain" : "");
-
+			length, chain ? " chain" : "");
 
 	trb = &dep->trb_pool[dep->trb_enqueue];
 
@@ -788,6 +783,7 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		req->trb = trb;
 		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
 		req->first_trb_index = dep->trb_enqueue;
+		dep->queued_requests++;
 	}
 
 	dwc3_ep_inc_enq(dep);
@@ -826,12 +822,10 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	/* always enable Continue on Short Packet */
 	trb->ctrl |= DWC3_TRB_CTRL_CSP;
 
-	if (!req->request.no_interrupt && !chain)
+	if ((!req->request.no_interrupt && !chain) ||
+			(dwc3_calc_trbs_left(dep) == 0))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC | DWC3_TRB_CTRL_ISP_IMI;
 
-	if (last && !usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		trb->ctrl |= DWC3_TRB_CTRL_LST;
-
 	if (chain)
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
 
@@ -840,8 +834,6 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
-	dep->queued_requests++;
-
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
@@ -856,12 +848,12 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
  */
 static struct dwc3_trb *dwc3_ep_prev_trb(struct dwc3_ep *dep, u8 index)
 {
-	if (!index)
-		index = DWC3_TRB_NUM - 2;
-	else
-		index = dep->trb_enqueue - 1;
+	u8 tmp = index;
+
+	if (!tmp)
+		tmp = DWC3_TRB_NUM - 1;
 
-	return &dep->trb_pool[index];
+	return &dep->trb_pool[tmp - 1];
 }
 
 static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
@@ -894,65 +886,42 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 }
 
 static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
-		struct dwc3_request *req, unsigned int trbs_left,
-		unsigned int more_coming)
+		struct dwc3_request *req)
 {
-	struct usb_request *request = &req->request;
-	struct scatterlist *sg = request->sg;
+	struct scatterlist *sg = req->sg;
 	struct scatterlist *s;
-	unsigned int	last = false;
 	unsigned int	length;
 	dma_addr_t	dma;
 	int		i;
 
-	for_each_sg(sg, s, request->num_mapped_sgs, i) {
+	for_each_sg(sg, s, req->num_pending_sgs, i) {
 		unsigned chain = true;
 
 		length = sg_dma_len(s);
 		dma = sg_dma_address(s);
 
-		if (sg_is_last(s)) {
-			if (usb_endpoint_xfer_int(dep->endpoint.desc) ||
-				!more_coming)
-				last = true;
-
-			chain = false;
-		}
-
-		if (!trbs_left--)
-			last = true;
-
-		if (last)
+		if (sg_is_last(s))
 			chain = false;
 
 		dwc3_prepare_one_trb(dep, req, dma, length,
-				last, chain, i);
+				chain, i);
 
-		if (last)
+		if (!dwc3_calc_trbs_left(dep))
 			break;
 	}
 }
 
 static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
-		struct dwc3_request *req, unsigned int trbs_left,
-		unsigned int more_coming)
+		struct dwc3_request *req)
 {
-	unsigned int	last = false;
 	unsigned int	length;
 	dma_addr_t	dma;
 
 	dma = req->request.dma;
 	length = req->request.length;
 
-	if (!trbs_left)
-		last = true;
-
-	/* Is this the last request? */
-	if (usb_endpoint_xfer_int(dep->endpoint.desc) || !more_coming)
-		last = true;
-
 	dwc3_prepare_one_trb(dep, req, dma, length,
-			last, false, 0);
+			false, 0);
 }
 
 /*
@@ -966,26 +935,19 @@ static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 {
 	struct dwc3_request	*req, *n;
-	unsigned int		more_coming;
-	u32			trbs_left;
 
 	BUILD_BUG_ON_NOT_POWER_OF_2(DWC3_TRB_NUM);
 
-	trbs_left = dwc3_calc_trbs_left(dep);
-	if (!trbs_left)
+	if (!dwc3_calc_trbs_left(dep))
 		return;
 
-	more_coming = dep->allocated_requests - dep->queued_requests;
-
 	list_for_each_entry_safe(req, n, &dep->pending_list, list) {
-		if (req->request.num_mapped_sgs > 0)
-			dwc3_prepare_one_trb_sg(dep, req, trbs_left--,
-					more_coming);
+		if (req->num_pending_sgs > 0)
+			dwc3_prepare_one_trb_sg(dep, req);
 		else
-			dwc3_prepare_one_trb_linear(dep, req, trbs_left--,
-					more_coming);
+			dwc3_prepare_one_trb_linear(dep, req);
 
-		if (!trbs_left)
+		if (!dwc3_calc_trbs_left(dep))
 			return;
 	}
 }
@@ -1101,93 +1063,37 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 
 	trace_dwc3_ep_queue(req);
 
-	/*
-	 * We only add to our list of requests now and
-	 * start consuming the list once we get XferNotReady
-	 * IRQ.
-	 *
-	 * That way, we avoid doing anything that we don't need
-	 * to do now and defer it until the point we receive a
-	 * particular token from the Host side.
-	 *
-	 * This will also avoid Host cancelling URBs due to too
-	 * many NAKs.
-	 */
 	ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 			dep->direction);
 	if (ret)
 		return ret;
 
-	list_add_tail(&req->list, &dep->pending_list);
+	req->sg			= req->request.sg;
+	req->num_pending_sgs	= req->request.num_mapped_sgs;
 
-	/*
-	 * If there are no pending requests and the endpoint isn't already
-	 * busy, we will just start the request straight away.
-	 *
-	 * This will save one IRQ (XFER_NOT_READY) and possibly make it a
-	 * little bit faster.
-	 */
-	if (!usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-			!usb_endpoint_xfer_int(dep->endpoint.desc)) {
-		ret = __dwc3_gadget_kick_transfer(dep, 0);
-		goto out;
-	}
+	list_add_tail(&req->list, &dep->pending_list);
 
 	/*
-	 * There are a few special cases:
-	 *
-	 * 1. XferNotReady with empty list of requests. We need to kick the
-	 *    transfer here in that situation, otherwise we will be NAKing
-	 *    forever. If we get XferNotReady before gadget driver has a
-	 *    chance to queue a request, we will ACK the IRQ but won't be
-	 *    able to receive the data until the next request is queued.
-	 *    The following code is handling exactly that.
+	 * NOTICE: Isochronous endpoints should NEVER be prestarted. We must
+	 * wait for a XferNotReady event so we will know what's the current
+	 * (micro-)frame number.
 	 *
+	 * Without this trick, we are very, very likely gonna get Bus Expiry
+	 * errors which will force us issue EndTransfer command.
 	 */
-	if (dep->flags & DWC3_EP_PENDING_REQUEST) {
-		/*
-		 * If xfernotready is already elapsed and it is a case
-		 * of isoc transfer, then issue END TRANSFER, so that
-		 * you can receive xfernotready again and can have
-		 * notion of current microframe.
-		 */
-		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-			if (list_empty(&dep->started_list)) {
-				dwc3_stop_active_transfer(dwc, dep->number, true);
-				dep->flags = DWC3_EP_ENABLED;
-			}
-			return 0;
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
+		if ((dep->flags & DWC3_EP_PENDING_REQUEST) &&
+				list_empty(&dep->started_list)) {
+			dwc3_stop_active_transfer(dwc, dep->number, true);
+			dep->flags = DWC3_EP_ENABLED;
 		}
-
-		ret = __dwc3_gadget_kick_transfer(dep, 0);
-		if (!ret)
-			dep->flags &= ~DWC3_EP_PENDING_REQUEST;
-
-		goto out;
-	}
-
-	/*
-	 * 2. XferInProgress on Isoc EP with an active transfer. We need to
-	 *    kick the transfer here after queuing a request, otherwise the
-	 *    core may not see the modified TRB(s).
-	 */
-	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
-			(dep->flags & DWC3_EP_BUSY) &&
-			!(dep->flags & DWC3_EP_MISSED_ISOC)) {
-		WARN_ON_ONCE(!dep->resource_index);
-		ret = __dwc3_gadget_kick_transfer(dep, dep->resource_index);
-		goto out;
+		return 0;
 	}
 
-	/*
-	 * 4. Stream Capable Bulk Endpoints. We need to start the transfer
-	 * right away, otherwise host will not know we have streams to be
-	 * handled.
-	 */
-	if (dep->stream_capable)
-		ret = __dwc3_gadget_kick_transfer(dep, 0);
+	if (!dwc3_calc_trbs_left(dep))
+		return 0;
 
-out:
+	ret = __dwc3_gadget_kick_transfer(dep, 0);
 	if (ret && ret != -EBUSY)
 		dwc3_trace(trace_dwc3_gadget,
 				"%s: failed to kick transfers",
@@ -1962,7 +1868,11 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	unsigned int		s_pkt = 0;
 	unsigned int		trb_status;
 
-	dep->queued_requests--;
+	dwc3_ep_inc_deq(dep);
+
+	if (req->trb == trb)
+		dep->queued_requests--;
+
 	trace_dwc3_complete_trb(dep, trb);
 
 	/*
@@ -1982,6 +1892,7 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		return 1;
 
 	count = trb->size & DWC3_TRB_SIZE_MASK;
+	req->request.actual += count;
 
 	if (dep->direction) {
 		if (count) {
@@ -2021,48 +1932,51 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 
 	if (s_pkt && !chain)
 		return 1;
-	if ((event->status & DEPEVT_STATUS_LST) &&
-			(trb->ctrl & (DWC3_TRB_CTRL_LST |
-				DWC3_TRB_CTRL_HWO)))
-		return 1;
+
 	if ((event->status & DEPEVT_STATUS_IOC) &&
 			(trb->ctrl & DWC3_TRB_CTRL_IOC))
 		return 1;
+
 	return 0;
 }
 
 static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		const struct dwc3_event_depevt *event, int status)
 {
-	struct dwc3_request	*req;
+	struct dwc3_request	*req, *n;
 	struct dwc3_trb		*trb;
-	unsigned int		slot;
-	unsigned int		i;
-	int			count = 0;
+	bool			ioc = false;
 	int			ret;
 
-	do {
+	list_for_each_entry_safe(req, n, &dep->started_list, list) {
+		unsigned length;
+		unsigned actual;
 		int chain;
 
-		req = next_request(&dep->started_list);
-		if (WARN_ON_ONCE(!req))
-			return 1;
-
-		chain = req->request.num_mapped_sgs > 0;
-		i = 0;
-		do {
-			slot = req->first_trb_index + i;
-			if (slot == DWC3_TRB_NUM - 1)
-				slot++;
-			slot %= DWC3_TRB_NUM;
-			trb = &dep->trb_pool[slot];
-			count += trb->size & DWC3_TRB_SIZE_MASK;
+		length = req->request.length;
+		chain = req->num_pending_sgs > 0;
+		if (chain) {
+			struct scatterlist *sg = req->sg;
+			struct scatterlist *s;
+			unsigned int pending = req->num_pending_sgs;
+			unsigned int i;
 
+			for_each_sg(sg, s, pending, i) {
+				trb = &dep->trb_pool[dep->trb_dequeue];
+
+				req->sg = sg_next(s);
+				req->num_pending_sgs--;
+
+				ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
+						event, status, chain);
+				if (ret)
+					break;
+			}
+		} else {
+			trb = &dep->trb_pool[dep->trb_dequeue];
 			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
 					event, status, chain);
-			if (ret)
-				break;
-		} while (++i < req->request.num_mapped_sgs);
+		}
 
 		/*
 		 * We assume here we will always receive the entire data block
@@ -2071,12 +1985,21 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		 * should receive and we simply bounce the request back to the
 		 * gadget driver for further processing.
 		 */
-		req->request.actual += req->request.length - count;
+		actual = length - req->request.actual;
+		req->request.actual = actual;
+
+		if (ret && chain && (actual < length) && req->num_pending_sgs)
+			return __dwc3_gadget_kick_transfer(dep, 0);
+
 		dwc3_gadget_giveback(dep, req, status);
 
-		if (ret)
+		if (ret) {
+			if ((event->status & DEPEVT_STATUS_IOC) &&
+			    (trb->ctrl & DWC3_TRB_CTRL_IOC))
+				ioc = true;
 			break;
-	} while (1);
+		}
+	}
 
 	/*
 	 * Our endpoint might get disabled by another thread during
@@ -2103,10 +2026,9 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		return 1;
 	}
 
-	if (usb_endpoint_xfer_isoc(dep->endpoint.desc))
-		if ((event->status & DEPEVT_STATUS_IOC) &&
-				(trb->ctrl & DWC3_TRB_CTRL_IOC))
-			return 0;
+	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) && ioc)
+		return 0;
+
 	return 1;
 }
 
@@ -2322,6 +2244,18 @@ static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force)
 	 *
 	 * - Issue EndTransfer WITH CMDIOC bit set
 	 * - Wait 100us
+	 *
+	 * As of IP version 3.10a of the DWC_usb3 IP, the controller
+	 * supports a mode to work around the above limitation. The
+	 * software can poll the CMDACT bit in the DEPCMD register
+	 * after issuing a EndTransfer command. This mode is enabled
+	 * by writing GUCTL2[14]. This polling is already done in the
+	 * dwc3_send_gadget_ep_cmd() function so if the mode is
+	 * enabled, the EndTransfer command will have completed upon
+	 * returning from this function and we don't need to delay for
+	 * 100us.
+	 *
+	 * This mode is NOT available on the DWC_usb31 IP.
 	 */
 
 	cmd = DWC3_DEPCMD_ENDTRANSFER;
@@ -2333,7 +2267,9 @@ static void dwc3_stop_active_transfer(struct dwc3 *dwc, u32 epnum, bool force)
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 	dep->flags &= ~DWC3_EP_BUSY;
-	udelay(100);
+
+	if (dwc3_is_usb31(dwc) || dwc->revision < DWC3_REVISION_310A)
+		udelay(100);
 }
 
 static void dwc3_stop_active_transfers(struct dwc3 *dwc)
@@ -3054,7 +2990,7 @@ err3:
 	kfree(dwc->setup_buf);
 
 err2:
-	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
 			dwc->ep0_trb, dwc->ep0_trb_addr);
 
 err1:
@@ -3079,7 +3015,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	kfree(dwc->setup_buf);
 	kfree(dwc->zlp_buf);
 
-	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
+	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb) * 2,
 			dwc->ep0_trb, dwc->ep0_trb_addr);
 
 	dma_free_coherent(dwc->dev, sizeof(*dwc->ctrl_req),
-- 
2.43.0

