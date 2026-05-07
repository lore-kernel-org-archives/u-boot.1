Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F019CCD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C67584B14;
	Thu,  7 May 2026 11:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KspRCamh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B6D284A6B; Thu,  7 May 2026 11:31:21 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED0E184B3B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-59e5aa4ca41so537522e87.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146271; x=1778751071; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ss13rlwxYOSqCFv0e1X2Wl0zG9ua92uyIAoAE8TU51E=;
 b=KspRCamh23UBdxAeCzuxm3DIeaXA3ykFfbEhjyiDIgJo3wZoyfanuHkvMRwif/nYyo
 nioRDBaR2MPyxgRMSuxe4aN5Rktg1vx5lsq+YoK6Nx4iIvL9K7sCiPJgZxAD+72uF8e1
 LIKLicifLWlUwYb5mX92HbS++YFfU0sX3TTPUKkyGRBjfUg/8Ydhf/a8fg3lInk9rxw7
 ap/pD3nxTHgB8AFZOv+jZfbAWSQXC+1e2NMbu0P2OcZfFna5U/SSv9OOw+9Q148ROQPZ
 fMEcDV/9yDQQ6SSy7yv8nWB+sOGGnWnwIb4XJ5uz6uUJRslr/coFhSgwtb1RugmdA+AG
 3Log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146271; x=1778751071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ss13rlwxYOSqCFv0e1X2Wl0zG9ua92uyIAoAE8TU51E=;
 b=WASdUeSIiGrqF6tqa2WsILZSwdBrCEhD/pPLxctGVJY2KnxJiz3cLy18Js1FrwjvVJ
 rQF32jF/h7mp96KWQcPWvTF8CxH6I/KQ3tBl9tsuOzKIQUsnQdG+qFMZmnOwKwIMWK7u
 cyzZ2Ug/VAbVRTn7HevEh6w5iFKGv1yQCIpkVAlZh8Lqw63zp25dx5X8/Zy3K0BBf+rx
 9YwdeC81mXrMm6w1SOBXk0hOih667FSizG0FNoLYR67zzdP6lbPdPuT3PkM0culd6Pzb
 ZMPd/5WmWGe47BkVZdUzueh3/FLfg1tsCwB0j2tWIeyPyhwZ/Ik6ivCLMQBAk9WDIGUu
 HSag==
X-Gm-Message-State: AOJu0YxXuBbgCWZ5na+bGjqpayuECFTFXzVbVaptSS//cHOnKhEEc402
 izreWNkyqvZf7hzfV0ptODFhci7CLUUczy6utSgWiW9ejrSmi1NE8tCHBtOgeyeEf/y5XMedLhP
 7R6UKL7pZzA==
X-Gm-Gg: AeBDievs2tSAJWM76ir8Z6OtFgr4A66a28jdZWMbsEDWFUCbQDH7gMLXxq/cV/541Ys
 O1RQ9OvccgTuaCtv4ItCP8nLjEtNAP9gvKJrXxdMoXPO4Om7Dk5qvWB0qxBPvmy4HN8et272qc6
 bDmEqCpCGfs/6riG4Bs4iCvdje3h0zGC4QqlQlIi30gJxVMwMN/X5ucDJij5MY7y62W8CRApvXN
 3RVkIBnfd8/92EbjvOaF4+YixRPGrKAfR0Xnnh7HSg2awT4/e3dHijPkbTh9xB/pLL6xQc+vNqL
 Vt2Z6XfGNf1kNVfIlx9Q3QgzRyeeyV/VNs/u4/Qp3G/kwK+gCModpu8V/MHJs5QWL3N3uhp2uX3
 vEcrBjespL4OIkFHnE9EgdoAEXQSfIYOKMr7V39vPZRWyD+EHJpB4XK23XWzIjSAaqj70Zv6zca
 q29jKMucLJosTB2qvIqFTWVuxTB9Y4yhh49tnmocn32wvjhEXXLvWYeI+VhyQrswYtNx+xBZEzs
 Hogb/qJI5e2RBmdng3xtHTBc+2PQSmxHObzCc/bbw==
X-Received: by 2002:ac2:4c4b:0:b0:5a8:97d7:8c45 with SMTP id
 2adb3069b0e04-5a897d78e18mr889722e87.36.1778146271110; 
 Thu, 07 May 2026 02:31:11 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:31:08 -0700 (PDT)
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
Subject: [RFC PATCH v2 50/64] usb: dwc3: import from kernel v6.6
Date: Thu,  7 May 2026 11:27:57 +0200
Message-ID: <20260507092843.358908-51-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v6.5 to v6.6.

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

List of commits: git log --oneline v6.5..v6.6
Commits imported:
8bea147dfdf8 usb: dwc3: Soft reset phy on probe for host
ac2224a467b4 Merge tag 'mips_6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
592d7a4663d2 usb: dwc3: exynos: Add support for Exynos850 variant
8d1de0ebce71 usb: dwc3: remove unnecessary platform_set_drvdata()
1fa206bb764f usb: dwc3: meson-g12a: do post init to fix broken usb after resumption
bbb9e06d2c64 Merge 6.5-rc6 into usb-next
fb57f829beef usb: dwc3: dwc3-octeon: Verify clock divider
d9216d3ef538 usb: dwc3: dwc3-octeon: Add SPDX header and copyright
540264746d83 usb: dwc3: dwc3-octeon: Dump control register on clock init failure
dc0092ce24dc usb: dwc3: dwc3-octeon: Move node parsing into driver probe
c61101631cdc usb: dwc3: dwc3-octeon: Avoid half-initialized controller state
23f87bcac649 usb: dwc3: dwc3-octeon: Pass dwc3_octeon to setup functions
417840663ab8 usb: dwc3: dwc3-octeon: Use _ULL bitfields defines
976f82e8aa3c usb: dwc3: dwc3-octeon: Convert to glue driver
98a9e32bdf25 Merge 6.5-rc4 into usb-next
3609699c32aa usb: dwc3-am62: Rename private data
484468fb0f7d usb: Explicitly include correct DT includes

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c      | 39 ++++++++++++++-
 drivers/usb/dwc3/dwc3-am62.c | 96 ++++++++++++++++++------------------
 2 files changed, 85 insertions(+), 50 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9c6bf054f15d..343d2570189f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -279,9 +279,46 @@ int dwc3_core_soft_reset(struct dwc3 *dwc)
 	 * XHCI driver will reset the host block. If dwc3 was configured for
 	 * host-only mode or current role is host, then we can return early.
 	 */
-	if (dwc->dr_mode == USB_DR_MODE_HOST || dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
+	if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST)
 		return 0;
 
+	/*
+	 * If the dr_mode is host and the dwc->current_dr_role is not the
+	 * corresponding DWC3_GCTL_PRTCAP_HOST, then the dwc3_core_init_mode
+	 * isn't executed yet. Ensure the phy is ready before the controller
+	 * updates the GCTL.PRTCAPDIR or other settings by soft-resetting
+	 * the phy.
+	 *
+	 * Note: GUSB3PIPECTL[n] and GUSB2PHYCFG[n] are port settings where n
+	 * is port index. If this is a multiport host, then we need to reset
+	 * all active ports.
+	 */
+	if (dwc->dr_mode == USB_DR_MODE_HOST) {
+		u32 usb3_port;
+		u32 usb2_port;
+
+		usb3_port = dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
+		usb3_port |= DWC3_GUSB3PIPECTL_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
+
+		usb2_port = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		usb2_port |= DWC3_GUSB2PHYCFG_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
+
+		/* Small delay for phy reset assertion */
+		usleep_range(1000, 2000);
+
+		usb3_port &= ~DWC3_GUSB3PIPECTL_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), usb3_port);
+
+		usb2_port &= ~DWC3_GUSB2PHYCFG_PHYSOFTRST;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), usb2_port);
+
+		/* Wait for clock synchronization */
+		msleep(50);
+		return 0;
+	}
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	reg |= DWC3_DCTL_CSFTRST;
 	reg &= ~DWC3_DCTL_RUN_STOP;
diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
index 1755f2f848c5..90a587bc29b7 100644
--- a/drivers/usb/dwc3/dwc3-am62.c
+++ b/drivers/usb/dwc3/dwc3-am62.c
@@ -102,7 +102,7 @@
 
 #define DWC3_AM62_AUTOSUSPEND_DELAY	100
 
-struct dwc3_data {
+struct dwc3_am62 {
 	struct device *dev;
 	void __iomem *usbss;
 	struct clk *usb2_refclk;
@@ -129,19 +129,19 @@ static const int dwc3_ti_rate_table[] = {	/* in KHZ */
 	52000,
 };
 
-static inline u32 dwc3_ti_readl(struct dwc3_data *data, u32 offset)
+static inline u32 dwc3_ti_readl(struct dwc3_am62 *am62, u32 offset)
 {
-	return readl((data->usbss) + offset);
+	return readl((am62->usbss) + offset);
 }
 
-static inline void dwc3_ti_writel(struct dwc3_data *data, u32 offset, u32 value)
+static inline void dwc3_ti_writel(struct dwc3_am62 *am62, u32 offset, u32 value)
 {
-	writel(value, (data->usbss) + offset);
+	writel(value, (am62->usbss) + offset);
 }
 
-static int phy_syscon_pll_refclk(struct dwc3_data *data)
+static int phy_syscon_pll_refclk(struct dwc3_am62 *am62)
 {
-	struct device *dev = data->dev;
+	struct device *dev = am62->dev;
 	struct device_node *node = dev->of_node;
 	struct of_phandle_args args;
 	struct regmap *syscon;
@@ -153,16 +153,16 @@ static int phy_syscon_pll_refclk(struct dwc3_data *data)
 		return PTR_ERR(syscon);
 	}
 
-	data->syscon = syscon;
+	am62->syscon = syscon;
 
 	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-phy-pll-refclk", 1,
 					       0, &args);
 	if (ret)
 		return ret;
 
-	data->offset = args.args[0];
+	am62->offset = args.args[0];
 
-	ret = regmap_update_bits(data->syscon, data->offset, PHY_PLL_REFCLK_MASK, data->rate_code);
+	ret = regmap_update_bits(am62->syscon, am62->offset, PHY_PLL_REFCLK_MASK, am62->rate_code);
 	if (ret) {
 		dev_err(dev, "failed to set phy pll reference clock rate\n");
 		return ret;
@@ -175,32 +175,32 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
-	struct dwc3_data *data;
+	struct dwc3_am62 *am62;
 	int i, ret;
 	unsigned long rate;
 	u32 reg;
 
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
+	am62 = devm_kzalloc(dev, sizeof(*am62), GFP_KERNEL);
+	if (!am62)
 		return -ENOMEM;
 
-	data->dev = dev;
-	platform_set_drvdata(pdev, data);
+	am62->dev = dev;
+	platform_set_drvdata(pdev, am62);
 
-	data->usbss = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(data->usbss)) {
+	am62->usbss = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(am62->usbss)) {
 		dev_err(dev, "can't map IOMEM resource\n");
-		return PTR_ERR(data->usbss);
+		return PTR_ERR(am62->usbss);
 	}
 
-	data->usb2_refclk = devm_clk_get(dev, "ref");
-	if (IS_ERR(data->usb2_refclk)) {
+	am62->usb2_refclk = devm_clk_get(dev, "ref");
+	if (IS_ERR(am62->usb2_refclk)) {
 		dev_err(dev, "can't get usb2_refclk\n");
-		return PTR_ERR(data->usb2_refclk);
+		return PTR_ERR(am62->usb2_refclk);
 	}
 
 	/* Calculate the rate code */
-	rate = clk_get_rate(data->usb2_refclk);
+	rate = clk_get_rate(am62->usb2_refclk);
 	rate /= 1000;	// To KHz
 	for (i = 0; i < ARRAY_SIZE(dwc3_ti_rate_table); i++) {
 		if (dwc3_ti_rate_table[i] == rate)
@@ -212,20 +212,20 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	data->rate_code = i;
+	am62->rate_code = i;
 
 	/* Read the syscon property and set the rate code */
-	ret = phy_syscon_pll_refclk(data);
+	ret = phy_syscon_pll_refclk(am62);
 	if (ret)
 		return ret;
 
 	/* VBUS divider select */
-	data->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
-	reg = dwc3_ti_readl(data, USBSS_PHY_CONFIG);
-	if (data->vbus_divider)
+	am62->vbus_divider = device_property_read_bool(dev, "ti,vbus-divider");
+	reg = dwc3_ti_readl(am62, USBSS_PHY_CONFIG);
+	if (am62->vbus_divider)
 		reg |= 1 << USBSS_PHY_VBUS_SEL_SHIFT;
 
-	dwc3_ti_writel(data, USBSS_PHY_CONFIG, reg);
+	dwc3_ti_writel(am62, USBSS_PHY_CONFIG, reg);
 
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
@@ -233,7 +233,7 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	 * Don't ignore its dependencies with its children
 	 */
 	pm_suspend_ignore_children(dev, false);
-	clk_prepare_enable(data->usb2_refclk);
+	clk_prepare_enable(am62->usb2_refclk);
 	pm_runtime_get_noresume(dev);
 
 	ret = of_platform_populate(node, NULL, NULL, dev);
@@ -243,9 +243,9 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	}
 
 	/* Set mode valid bit to indicate role is valid */
-	reg = dwc3_ti_readl(data, USBSS_MODE_CONTROL);
+	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
 	reg |= USBSS_MODE_VALID;
-	dwc3_ti_writel(data, USBSS_MODE_CONTROL, reg);
+	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
 
 	/* Device has capability to wakeup system from sleep */
 	device_set_wakeup_capable(dev, true);
@@ -261,7 +261,7 @@ static int dwc3_ti_probe(struct platform_device *pdev)
 	return 0;
 
 err_pm_disable:
-	clk_disable_unprepare(data->usb2_refclk);
+	clk_disable_unprepare(am62->usb2_refclk);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
 	return ret;
@@ -278,36 +278,34 @@ static int dwc3_ti_remove_core(struct device *dev, void *c)
 static void dwc3_ti_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct dwc3_data *data = platform_get_drvdata(pdev);
+	struct dwc3_am62 *am62 = platform_get_drvdata(pdev);
 	u32 reg;
 
 	device_for_each_child(dev, NULL, dwc3_ti_remove_core);
 
 	/* Clear mode valid bit */
-	reg = dwc3_ti_readl(data, USBSS_MODE_CONTROL);
+	reg = dwc3_ti_readl(am62, USBSS_MODE_CONTROL);
 	reg &= ~USBSS_MODE_VALID;
-	dwc3_ti_writel(data, USBSS_MODE_CONTROL, reg);
+	dwc3_ti_writel(am62, USBSS_MODE_CONTROL, reg);
 
 	pm_runtime_put_sync(dev);
-	clk_disable_unprepare(data->usb2_refclk);
+	clk_disable_unprepare(am62->usb2_refclk);
 	pm_runtime_disable(dev);
 	pm_runtime_set_suspended(dev);
-
-	platform_set_drvdata(pdev, NULL);
 }
 
 #ifdef CONFIG_PM
 static int dwc3_ti_suspend_common(struct device *dev)
 {
-	struct dwc3_data *data = dev_get_drvdata(dev);
+	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
 	u32 reg, current_prtcap_dir;
 
 	if (device_may_wakeup(dev)) {
-		reg = dwc3_ti_readl(data, USBSS_CORE_STAT);
+		reg = dwc3_ti_readl(am62, USBSS_CORE_STAT);
 		current_prtcap_dir = (reg & USBSS_CORE_OPERATIONAL_MODE_MASK)
 				     >> USBSS_CORE_OPERATIONAL_MODE_SHIFT;
 		/* Set wakeup config enable bits */
-		reg = dwc3_ti_readl(data, USBSS_WAKEUP_CONFIG);
+		reg = dwc3_ti_readl(am62, USBSS_WAKEUP_CONFIG);
 		if (current_prtcap_dir == DWC3_GCTL_PRTCAP_HOST) {
 			reg = USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
 		} else {
@@ -317,30 +315,30 @@ static int dwc3_ti_suspend_common(struct device *dev)
 			 * and in U2/L3 state else it causes spurious wake-up.
 			 */
 		}
-		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, reg);
+		dwc3_ti_writel(am62, USBSS_WAKEUP_CONFIG, reg);
 		/* clear wakeup status so we know what caused the wake up */
-		dwc3_ti_writel(data, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
+		dwc3_ti_writel(am62, USBSS_WAKEUP_STAT, USBSS_WAKEUP_STAT_CLR);
 	}
 
-	clk_disable_unprepare(data->usb2_refclk);
+	clk_disable_unprepare(am62->usb2_refclk);
 
 	return 0;
 }
 
 static int dwc3_ti_resume_common(struct device *dev)
 {
-	struct dwc3_data *data = dev_get_drvdata(dev);
+	struct dwc3_am62 *am62 = dev_get_drvdata(dev);
 	u32 reg;
 
-	clk_prepare_enable(data->usb2_refclk);
+	clk_prepare_enable(am62->usb2_refclk);
 
 	if (device_may_wakeup(dev)) {
 		/* Clear wakeup config enable bits */
-		dwc3_ti_writel(data, USBSS_WAKEUP_CONFIG, USBSS_WAKEUP_CFG_NONE);
+		dwc3_ti_writel(am62, USBSS_WAKEUP_CONFIG, USBSS_WAKEUP_CFG_NONE);
 	}
 
-	reg = dwc3_ti_readl(data, USBSS_WAKEUP_STAT);
-	data->wakeup_stat = reg;
+	reg = dwc3_ti_readl(am62, USBSS_WAKEUP_STAT);
+	am62->wakeup_stat = reg;
 
 	return 0;
 }
-- 
2.43.0

