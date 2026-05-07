Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F1FCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B431B84A56;
	Thu,  7 May 2026 11:29:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IQrnJmSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4950384A5F; Thu,  7 May 2026 11:29:14 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0806584A3E
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5a860667fabso521036e87.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146142; x=1778750942; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vDdz++zoEc8GcldYzs2ypiVK7Kt89CugwMOwm1Z9Pmc=;
 b=IQrnJmSgfIEk1wM+kkNv3jfJU7VLIUSDGrTYQq3kx4ZRoIMlACN+lcyc5sHe/hEbl2
 wtmYODR5ZmyrLlsiUh8oAkI7r4BHUVtEsRfMS4x5jaCZdZx+GHk3HrHsFlTW/10fpDOJ
 r5KsREwoZb0j5ECjVA7Q1kfhHxfWXrTDrwHYxEDoc58R4XvqaJZhmnVC2BqNRY/X6YVX
 ikiCnlcsFRjf93UDHeSnuoqGK8eyvyJORqzmcx/I7ld2XPRKd8jgS6x7tnBF1TnM7bS1
 u1un9HxHY3zLu4cwmQO0alVZnD8MxwkYoTFUOth9tFvzdCuEyFphg+J1Jr7KXiukjxl4
 BCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146142; x=1778750942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vDdz++zoEc8GcldYzs2ypiVK7Kt89CugwMOwm1Z9Pmc=;
 b=qBB+qRFz6kjmeU7+r2GGGHpn+jLWYSixvNZEA2/3CnYi+9WQQUkrLjADcQpVGdU166
 hsuODMbEZCrwpw4AeR+KqauozYZXfcH61UpohhKV5oelbYzOUka0BN8pqJjoPP1WGLeN
 QzlKfOZLH+dVJi3Jos8TAkMf2tWTnJb9wpS9iYPx4ckHNU2dH4ke+7Pb5AD2T3MvgAP0
 pk16EkiWupFMGs0naWgV3+fWQcQTq2aUx5qhMGRKAEr6n/5ESxyV/hm6a6Hz+gTemm9Q
 v+5UV4Fz1tNfVenR3gMxD+ONcx6ekBY6auUfmpA4MmeHNThaHw50X0sHHK/pn5Wtyyyy
 qrug==
X-Gm-Message-State: AOJu0Yy6KPbSL4/HZt20Y29pvO8gR/pUalXNBw/D7l9e0DGvnoNO1px4
 WHqnwCfo+QJAclViszhZHMQjstB9FshRz7ls9/MiJ07K5TlCIPOSaoFEAus25dZYfPhLMVtysf2
 tNCGnZsJDDQ==
X-Gm-Gg: AeBDiesoalyIY0JoB++jieWCF09uPs+PPa+Usk3CyRVSx13cgjvo7wvO37cwgWmmp3z
 0BIaGMogQgmncST7zFEyiYYwl9eBf2doVB3t+66iiAD7ULIZ7lT4hlIt+SsHa4IjIeIL6syICKg
 y46iw0Apx7pbSXElQaA1CjhQVavL5N5+GbtjTN2y0D44x8I3AWjNky7/W57UY/YL+oj2tA/QTJU
 Q1LxlK5SD/sVSvrRqwJgAGXAznnmLA+Wkn7gaeTMEREQEwK6WtxsOIDnrut2hU4k71+NxkZ8hKa
 MCkKI8PkIH0oy0KZn/bEhHkM5+jxdGbeU4/Hr+abgZVXG+UkY4ifoJ4gCfPmxXkXugTv6ZHYE54
 VJ8FUpiiWy3wvtHI67HwfmRUmSM0CKnof9ZH27IQufpMFE4EIWm+HB2BIKckRQy19u3gY2b1vdB
 4EzrW0zGT20buGhjedffnpb/tdGCDofTYfhRLvjAEFXsJiNyzRgQz941dKkkWHCOX5QjHJF1fSZ
 DrA9GoR5NA4kzLuzkdboEoI9Jb+OJFDvFG3k3i/gVhEbEf/XF6a
X-Received: by 2002:a05:6512:1153:b0:5a2:864a:bebb with SMTP id
 2adb3069b0e04-5a887cdeeb9mr2805125e87.20.1778146142139; 
 Thu, 07 May 2026 02:29:02 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:01 -0700 (PDT)
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
Subject: [RFC PATCH v2 05/64] usb: dwc3: import from kernel v4.2
Date: Thu,  7 May 2026 11:27:12 +0200
Message-ID: <20260507092843.358908-6-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.1 to v4.2.

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

List of commits: git log --oneline v4.1..v4.2
Commits imported:
aebda6187181 usb: dwc3: Reset the transfer resource index on SET_INTERFACE
43cacb03aabe usb: dwc3: core: avoid NULL pointer dereference
50641056d833 usb: dwc3: Use ASCII space in Kconfig
19915e623458 Merge 4.1-rc7 into usb-next
e152813ff5fe Merge tag 'usb-for-v4.2' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
e18b7975c885 usb: dwc3: gadget: don't clear EP_BUSY too early
76e838c9f776 usb: dwc3: gadget: return error if command sent to DEPCMD register fails
891b1dc02295 usb: dwc3: gadget: return error if command sent to DGCMD register fails
909eacd748b3 Merge 4.1-rc4 into usb-next
88bc9d194ff6 usb: dwc3: add ULPI interface support
a89d977cc04c usb: dwc3: pci: add quirk for Baytrails
3e10a2ce98d1 usb: dwc3: add hsphy_interface property
45bb7de213d8 usb: dwc3: setup phys earlier
c5cc74e8c12b usb: dwc3: soft reset to it's own function
2917e7181589 usb: dwc3: cache hwparams earlier
6c89cce0476f usb: dwc3: store driver data earlier
f699b94789a6 usb: dwc3: ULPI or UTMI+ select
b5699eeee68f usb: dwc3: USB2 PHY register access bits

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c          | 110 ++++++++++++++++++++++++-------
 drivers/usb/dwc3/core.h          |  26 ++++++++
 drivers/usb/dwc3/ep0.c           |   4 ++
 drivers/usb/dwc3/gadget.c        |  10 ++-
 drivers/usb/dwc3/platform_data.h |   2 +
 5 files changed, 126 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 2bbab3d86fff..ff5773c66b84 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -116,6 +116,33 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	return 0;
 }
 
+/**
+ * dwc3_soft_reset - Issue soft reset
+ * @dwc: Pointer to our controller context structure
+ */
+static int dwc3_soft_reset(struct dwc3 *dwc)
+{
+	unsigned long timeout;
+	u32 reg;
+
+	timeout = jiffies + msecs_to_jiffies(500);
+	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
+	do {
+		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
+		if (!(reg & DWC3_DCTL_CSFTRST))
+			break;
+
+		if (time_after(jiffies, timeout)) {
+			dev_err(dwc->dev, "Reset Timed Out\n");
+			return -ETIMEDOUT;
+		}
+
+		cpu_relax();
+	} while (true);
+
+	return 0;
+}
+
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
  * @dwc: Pointer to our controller context structure
@@ -367,10 +394,15 @@ static void dwc3_cache_hwparams(struct dwc3 *dwc)
 /**
  * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
  * @dwc: Pointer to our controller context structure
+ *
+ * Returns 0 on success. The USB PHY interfaces are configured but not
+ * initialized. The PHY interfaces and the PHYs get initialized together with
+ * the core in dwc3_core_init.
  */
-static void dwc3_phy_setup(struct dwc3 *dwc)
+static int dwc3_phy_setup(struct dwc3 *dwc)
 {
 	u32 reg;
+	int ret;
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 
@@ -409,10 +441,43 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 
 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
 
-	mdelay(100);
-
 	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 
+	/* Select the HS PHY interface */
+	switch (DWC3_GHWPARAMS3_HSPHY_IFC(dwc->hwparams.hwparams3)) {
+	case DWC3_GHWPARAMS3_HSPHY_IFC_UTMI_ULPI:
+		if (dwc->hsphy_interface &&
+				!strncmp(dwc->hsphy_interface, "utmi", 4)) {
+			reg &= ~DWC3_GUSB2PHYCFG_ULPI_UTMI;
+			break;
+		} else if (dwc->hsphy_interface &&
+				!strncmp(dwc->hsphy_interface, "ulpi", 4)) {
+			reg |= DWC3_GUSB2PHYCFG_ULPI_UTMI;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		} else {
+			dev_warn(dwc->dev, "HSPHY Interface not defined\n");
+
+			/* Relying on default value. */
+			if (!(reg & DWC3_GUSB2PHYCFG_ULPI_UTMI))
+				break;
+		}
+		/* FALLTHROUGH */
+	case DWC3_GHWPARAMS3_HSPHY_IFC_ULPI:
+		/* Making sure the interface and PHY are operational */
+		ret = dwc3_soft_reset(dwc);
+		if (ret)
+			return ret;
+
+		udelay(1);
+
+		ret = dwc3_ulpi_init(dwc);
+		if (ret)
+			return ret;
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
+
 	/*
 	 * Above 1.94a, it is recommended to set DWC3_GUSB2PHYCFG_SUSPHY to
 	 * '0' during coreConsultant configuration. So default value will
@@ -427,7 +492,7 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
 
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
 
-	mdelay(100);
+	return 0;
 }
 
 /**
@@ -438,7 +503,6 @@ static void dwc3_phy_setup(struct dwc3 *dwc)
  */
 static int dwc3_core_init(struct dwc3 *dwc)
 {
-	unsigned long		timeout;
 	u32			hwparams4 = dwc->hwparams.hwparams4;
 	u32			reg;
 	int			ret;
@@ -466,21 +530,9 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	}
 
 	/* issue device SoftReset too */
-	timeout = jiffies + msecs_to_jiffies(500);
-	dwc3_writel(dwc->regs, DWC3_DCTL, DWC3_DCTL_CSFTRST);
-	do {
-		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
-		if (!(reg & DWC3_DCTL_CSFTRST))
-			break;
-
-		if (time_after(jiffies, timeout)) {
-			dev_err(dwc->dev, "Reset Timed Out\n");
-			ret = -ETIMEDOUT;
-			goto err0;
-		}
-
-		cpu_relax();
-	} while (true);
+	ret = dwc3_soft_reset(dwc);
+	if (ret)
+		goto err0;
 
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
@@ -555,8 +607,6 @@ static int dwc3_core_init(struct dwc3 *dwc)
 
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 
-	dwc3_phy_setup(dwc);
-
 	ret = dwc3_alloc_scratch_buffers(dwc);
 	if (ret)
 		goto err1;
@@ -836,6 +886,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,tx_de_emphasis_quirk");
 		of_property_read_u8(node, "snps,tx_de_emphasis",
 				&tx_de_emphasis);
+		of_property_read_string(node, "snps,hsphy_interface",
+					&dwc->hsphy_interface);
 	} else if (pdata) {
 		dwc->maximum_speed = pdata->maximum_speed;
 		dwc->has_lpm_erratum = pdata->has_lpm_erratum;
@@ -863,6 +915,8 @@ static int dwc3_probe(struct platform_device *pdev)
 		dwc->tx_de_emphasis_quirk = pdata->tx_de_emphasis_quirk;
 		if (pdata->tx_de_emphasis)
 			tx_de_emphasis = pdata->tx_de_emphasis;
+
+		dwc->hsphy_interface = pdata->hsphy_interface;
 	}
 
 	/* default to superspeed if no maximum_speed passed */
@@ -875,12 +929,18 @@ static int dwc3_probe(struct platform_device *pdev)
 	dwc->hird_threshold = hird_threshold
 		| (dwc->is_utmi_l1_suspend << 4);
 
+	platform_set_drvdata(pdev, dwc);
+	dwc3_cache_hwparams(dwc);
+
+	ret = dwc3_phy_setup(dwc);
+	if (ret)
+		goto err0;
+
 	ret = dwc3_core_get_phy(dwc);
 	if (ret)
 		goto err0;
 
 	spin_lock_init(&dwc->lock);
-	platform_set_drvdata(pdev, dwc);
 
 	if (!dev->dma_mask) {
 		dev->dma_mask = dev->parent->dma_mask;
@@ -892,8 +952,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	pm_runtime_get_sync(dev);
 	pm_runtime_forbid(dev);
 
-	dwc3_cache_hwparams(dwc);
-
 	ret = dwc3_alloc_event_buffers(dwc, DWC3_EVENT_BUFFERS_SIZE);
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
@@ -964,6 +1022,7 @@ err2:
 
 err1:
 	dwc3_free_event_buffers(dwc);
+	dwc3_ulpi_exit(dwc);
 
 err0:
 	/*
@@ -999,6 +1058,7 @@ static int dwc3_remove(struct platform_device *pdev)
 	phy_power_off(dwc->usb3_generic_phy);
 
 	dwc3_core_exit(dwc);
+	dwc3_ulpi_exit(dwc);
 
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index c0eafa6fd403..044778884585 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -30,6 +30,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
+#include <linux/ulpi/interface.h>
 
 #include <linux/phy/phy.h>
 
@@ -173,6 +174,15 @@
 /* Global USB2 PHY Configuration Register */
 #define DWC3_GUSB2PHYCFG_PHYSOFTRST	(1 << 31)
 #define DWC3_GUSB2PHYCFG_SUSPHY		(1 << 6)
+#define DWC3_GUSB2PHYCFG_ULPI_UTMI	(1 << 4)
+
+/* Global USB2 PHY Vendor Control Register */
+#define DWC3_GUSB2PHYACC_NEWREGREQ	(1 << 25)
+#define DWC3_GUSB2PHYACC_BUSY		(1 << 23)
+#define DWC3_GUSB2PHYACC_WRITE		(1 << 22)
+#define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
+#define DWC3_GUSB2PHYACC_EXTEND_ADDR(n)	(n << 8)
+#define DWC3_GUSB2PHYACC_DATA(n)	(n & 0xff)
 
 /* Global USB3 PIPE Control Register */
 #define DWC3_GUSB3PIPECTL_PHYSOFTRST	(1 << 31)
@@ -652,6 +662,7 @@ struct dwc3_scratchpad_array {
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
+ * @ulpi: pointer to ulpi interface
  * @dcfg: saved contents of DCFG register
  * @gctl: saved contents of GCTL register
  * @isoch_delay: wValue from Set Isochronous Delay request;
@@ -673,6 +684,7 @@ struct dwc3_scratchpad_array {
  * @test_mode_nr: test feature selector
  * @lpm_nyet_threshold: LPM NYET response threshold
  * @hird_threshold: HIRD threshold
+ * @hsphy_interface: "utmi" or "ulpi"
  * @delayed_status: true when gadget driver asks for delayed status
  * @ep0_bounced: true when we used bounce buffer
  * @ep0_expect_in: true when we expect a DATA IN transfer
@@ -739,6 +751,8 @@ struct dwc3 {
 	struct phy		*usb2_generic_phy;
 	struct phy		*usb3_generic_phy;
 
+	struct ulpi		*ulpi;
+
 	void __iomem		*regs;
 	size_t			regs_size;
 
@@ -800,6 +814,8 @@ struct dwc3 {
 	u8			lpm_nyet_threshold;
 	u8			hird_threshold;
 
+	const char		*hsphy_interface;
+
 	unsigned		delayed_status:1;
 	unsigned		ep0_bounced:1;
 	unsigned		ep0_expect_in:1;
@@ -1035,4 +1051,14 @@ static inline int dwc3_gadget_resume(struct dwc3 *dwc)
 }
 #endif /* !IS_ENABLED(CONFIG_USB_DWC3_HOST) */
 
+#if IS_ENABLED(CONFIG_USB_DWC3_ULPI)
+int dwc3_ulpi_init(struct dwc3 *dwc);
+void dwc3_ulpi_exit(struct dwc3 *dwc);
+#else
+static inline int dwc3_ulpi_init(struct dwc3 *dwc)
+{ return 0; }
+static inline void dwc3_ulpi_exit(struct dwc3 *dwc)
+{ }
+#endif
+
 #endif /* __DRIVERS_USB_DWC3_CORE_H */
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 2ef3c8d6a9db..69e769c35cf5 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -727,6 +727,10 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_ISOCH_DELAY");
 		ret = dwc3_ep0_set_isoch_delay(dwc, ctrl);
 		break;
+	case USB_REQ_SET_INTERFACE:
+		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_INTERFACE");
+		dwc->start_config_issued = false;
+		/* Fall through */
 	default:
 		dwc3_trace(trace_dwc3_ep0, "Forwarding to gadget driver");
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 8946c32047e9..333a7c0078fc 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -291,6 +291,8 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 			dwc3_trace(trace_dwc3_gadget,
 					"Command Complete --> %d",
 					DWC3_DGCMD_STATUS(reg));
+			if (DWC3_DGCMD_STATUS(reg))
+				return -EINVAL;
 			return 0;
 		}
 
@@ -328,6 +330,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3 *dwc, unsigned ep,
 			dwc3_trace(trace_dwc3_gadget,
 					"Command Complete --> %d",
 					DWC3_DEPCMD_STATUS(reg));
+			if (DWC3_DEPCMD_STATUS(reg))
+				return -EINVAL;
 			return 0;
 		}
 
@@ -1902,12 +1906,16 @@ static void dwc3_endpoint_transfer_complete(struct dwc3 *dwc,
 {
 	unsigned		status = 0;
 	int			clean_busy;
+	u32			is_xfer_complete;
+
+	is_xfer_complete = (event->endpoint_event == DWC3_DEPEVT_XFERCOMPLETE);
 
 	if (event->status & DEPEVT_STATUS_BUSERR)
 		status = -ECONNRESET;
 
 	clean_busy = dwc3_cleanup_done_reqs(dwc, dep, event, status);
-	if (clean_busy)
+	if (clean_busy && (is_xfer_complete ||
+				usb_endpoint_xfer_isoc(dep->endpoint.desc)))
 		dep->flags &= ~DWC3_EP_BUSY;
 
 	/*
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index a2bd464be828..d3614ecbb9ca 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -45,4 +45,6 @@ struct dwc3_platform_data {
 
 	unsigned tx_de_emphasis_quirk:1;
 	unsigned tx_de_emphasis:2;
+
+	const char *hsphy_interface;
 };
-- 
2.43.0

