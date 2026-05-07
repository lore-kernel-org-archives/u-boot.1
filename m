Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D77BCD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C87584A6B;
	Thu,  7 May 2026 11:29:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hDbKIDsw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13BC084A67; Thu,  7 May 2026 11:29:24 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 679E284A20
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5a746f9c092so982189e87.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146155; x=1778750955; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r+dtdHyIi8xBX2Y6R8LAm1kS4RtjIvOlQoxbj4iqUIw=;
 b=hDbKIDsweaTfi/+USPMfynCPzd3qWweHwkeXrL063gkGzb660munpLgcxIPEOylgEd
 0/TwPOmi7IhEWrPMrKUnFb9e91X91fh44TQwGPiqHTqnR//yOuo7vWvOkKnmNoE78vuK
 6A+yRZpefGA/6P9iEb/x7Ly5yJiv6bX/t1/RG3+XQvFaDG/0pGg7teg//gx/KMQTnVEZ
 o2HQ9Ke4wv/pLuMq1aYxGlxtlyYXbllRPIVZ5AOVqgf5LFDEAr/BFRzbvCeLxM3DSpoB
 mKTJZB62QVv7EhgZHW2nrj48EtXOhFygnWHsPb35rfkchGxPW4wx4y7tcc3ik1RUWeFN
 u7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146155; x=1778750955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r+dtdHyIi8xBX2Y6R8LAm1kS4RtjIvOlQoxbj4iqUIw=;
 b=pWcZ63Uug99uJ9pV77kC6WAncF6ArNO2/oa4yHnuP7esuBllPv3I6i/jTtT7eYM+xd
 MnGYtYTKgtCR6CUZLbGtJAy7b5ya4mozmVCP0j/TGk79DQWIzMbuARC1arbWXOHA/8N7
 clePd9g8yzJpXfbucHZ7qMTJSZOeiNzUvCdez3Q8GM35n506UANbu/tdp/bkUOLkfQIg
 JSxTr+mIrjUDXRFQoA11X3GQ8h+SIl59WGsYehryU1oDiaWIuD4s8p5b8FEZwO4BpY7D
 EZchkspyPooZeZkxpWLkfUA3NT47j8nhas76NYbP4uNNpu1vSCpZUiH2vL0RzLyaEjeT
 RNsw==
X-Gm-Message-State: AOJu0YzNJrcvR61zpriaHrg/4rLVGCd/O+Vbw/OnlfGJ/PtFxujvv7et
 ZeTq8f2nro4m4uUWe6iZWeZ5/ln0vmmGcPCRkGB5+TYr6e3ObEywgAHBOFWtKDInlsKFlDzzSV8
 3nVL/lIioHw==
X-Gm-Gg: AeBDieunoNwhFZdc5yInKbfljRhLYWM8KqklFEOEVcau5YLyQ/ye2OuYDlyXoSlyxnE
 IrD87MyQP+oSAjWpT+JrPWRZY8PUFRoGNWxLAuP/b1gX/Qtw/CSrx432t0WtO9vmBZpMt5vZaSR
 Wwp2OX85X+R0Rdk6c4Wtc89SAzZrvrCg3ljUUp1SsP0MBXYQ5zcSWXHdtzaDdOn+2s8UidDkBZ2
 Sbfgt3Lnvo+g6JKmqE/QDOM6H0BabEdQC2Q3jQGbHFaduYSVQnuCqDDBZpAfYayzB7g0//7IRDd
 Ly41mAfDnVa6yQTcy+UpfeOOeG8WRG4ldwGdeU9gdIzdsTR06pd8nK9MSK//4Cbq5T6s39fgxOj
 6uMSZk96u78LZo4EZ9N8y+VXbknijrbuH/Ulvn4Ka4BtHawBtpacpIsZIqrbf7FDKwFa6etUS7T
 0SP3XzvGKbCCoN4Inqgx2vrzBcv2kqwAE+w+SDwmRL7CNlIkmiuRyogPXmEdf1W2SLz4XgEhL3+
 /zMOVHN/Ac0hXYNhGQoSL5MtIbKrrZMA8hBxsvpcA==
X-Received: by 2002:a05:6512:3d04:b0:5a4:299:285b with SMTP id
 2adb3069b0e04-5a899bb5596mr679806e87.12.1778146154573; 
 Thu, 07 May 2026 02:29:14 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:12 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/64] usb: dwc3: import from kernel v4.6
Date: Thu,  7 May 2026 11:27:16 +0200
Message-ID: <20260507092843.358908-10-jens.wiklander@linaro.org>
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
33c1f638a0fe Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
77966eb85e6d usb: dwc3: Validate the maximum_speed parameter
7580862b3e80 usb: dwc3: Enable SuperSpeedPlus
2c7f1bd9127a usb: dwc3: Update maximum_speed for SuperSpeedPlus
ee5cd41c9117 usb: dwc3: Update speed checks for SuperSpeedPlus
1f38f88a24c8 usb: dwc3: Update register fields for SuperSpeedPlus
c4137a9c841e usb: dwc3: DWC_usb31 controller check
71e41bbb4379 Merge 4.5-rc6 into usb-next
3d755dcc20dd usb: dwc3: Remove impossible check for of_clk_get_parent_count() < 0
172ad9af55d2 Merge 4.5-rc4 into usb-next

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
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
2.43.0

