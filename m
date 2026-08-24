Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243E2C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91B1280E24;
	Mon, 24 Aug 2026 16:46:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Hrbt8r2wvk7E; Mon, 24 Aug 2026 16:46:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589909;
	bh=8hKOHLjQYw6SSk3eHqSe8KLczL5iiwsi1dTbjAbKap8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZBT2eHyrOqCxrxZvG/M7OmMJGeM9XP9KavWUd6vuix9R2togyRMQsMCNHQ4CAzUr8
	 qYtDiXC6KhVZMnvksi7Z2ag6Hfw6jTNXOzLu57cpmM7MTcbjK/tzkzDburKZ4x2vj/
	 hZtWA8g2k1GDviAPG3WeGUKgWkrVBA02HbbekRPfnCn/m924WrTQgJrKVvrI/xRZct
	 pl27weegMBq756lDV3t3FnZlxKE/5Nwv7IQX+eY9jWBlJU+TRDDrj3OPhhLZMW3FMd
	 gKc4SoW5Pb0sPe483IwKxyHexV/CAQDpjcmlQWcMreNczItJKscxpJ/CInL9+dTIlb
	 QwtTxUjUuEH3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DD89C80EB4;
	Mon, 24 Aug 2026 16:45:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id A711D386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8D36C808A9
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uluxO3dUsDiW for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:31:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=bM8+UUlP
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F537808C1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:31:58 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c20e4487bdaso29581666b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585517; x=1788190317;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8hKOHLjQYw6SSk3eHqSe8KLczL5iiwsi1dTbjAbKap8=;
 b=bM8+UUlPgYEtIwnDDe1NFO4tw7aDNnrxZeY1nYUMKeO59eHBEtSsx/8axSbQv2qD9F
 ayr3aFB1Y7EZu9iPkSjY32RQFNDVAhH8qsop7iaoDzabOawyR/AYiTidieCVTM/iXExk
 0xiKaRxzEgi24cCvpN9ulNy9s50ADLfGr5AlZKPuPlLbEAxLUHnRwATBROhkEvZOEf1e
 KJY8RIWBzHCU477DIHCyN9huJqOksuJBALhGG8xW6Pf+/mtVQV5Em6JyVNSl6+5Ypi0M
 +MCM3GYh/HZxvkRkE6mf2jAoI2hFYKy4RHLxWCQy1orFBfBxko2iA8HNbuuj+W4W8Bj3
 zhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585517; x=1788190317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8hKOHLjQYw6SSk3eHqSe8KLczL5iiwsi1dTbjAbKap8=;
 b=W0YUvb/SpuVM/L0nFfTF8WGRV2ZSN45tBRKP6/l3Wtont/jaN9+Rrs6NJaNHb1SUn5
 lDfP5oFg6myVBlPSKHLCJYyDyGXwwjRN8SuYuJML1c+AtrdpSL4bfoCEei4iXhRdlHID
 +HrRvRte8dI4MHEfVZsp1MOjW8Wikg/A9oY5OX71N/v1JuwFY+XtnIiusdOXyzslb4ry
 evLY63u7VTxkjsIk7NHW8ecJu0ClY2eZHpzmG2nyIpgWSRXzk6JGPZdMlHHld5umF+DC
 PaYClntyKcYRyNqV48qOLareaLizdWUaQXvrJY5xtAMt84V6enaRbSEj6DK5o7LIQiOr
 YC4w==
X-Gm-Message-State: AFuF++mxrDvw6K/ksbzjc4mrVyxAVQXD7iVvkYzbqEPXXDh/BLOTdMt9
 0WtjY+o9EBuJRq72dOmZlKIHTR2lc6yewdqvDg5cOR7fzzYj1n7dvOPEH8m/hX6zKU2XApJU/HE
 oa76O
X-Gm-Gg: AR+sD11QvTwG8SMBzLOvEM7uCaGEozkHwwW16kZzYM5BzMADJXyLOBo3NPL+F4W7+6b
 Yz+65HMSHuL2XNNM0HFBVa16dKz1yO/5cG82G824CDu17z4nffZ/aaIJo0NL6+bCqAzjJZo1j0q
 Fc+eeR5HPAXiap1DOPJw2wzaT7+obBOCvtRelIo+8FHsEGJbYOu7GZoZuXDuBMp6+EAg4lnUxQo
 rp+GkdfPBtRKn0qpAE0KaAAvEe4EFfIzlIiSd5q56HjU/GLnnBCHI1TTEI8/zGPWwit00piQAd7
 Sv+pzoZHluwk6Uroh3SqQmQ5L0OICWFhIVA8+xdYSl9IkQHa7pRm9bFr6DcwCfebuxLUd06l9hD
 uOlYNpYCbF//3w+wRRDiQcngGSmzYvDiPA060rleQnMnoXEWHNj7Bp+xm8SBwcJbDGGE01cY6fi
 9okHYvq2K/oip8vzqlLd898eLAd+R0JQ5j3HB5GYrtG0nhB5oZhld1sEjPlBzx8mLgQ9ypFIPvy
 ybCA66ytUVCygjlovyZ0g==
X-Received: by 2002:a17:907:cd0e:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c246a63d6b3mr1730003966b.4.1787585516659; 
 Mon, 24 Aug 2026 08:31:56 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b208sm1233541266b.10.2026.08.24.08.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:31:55 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 51/63] usb: dwc3: import from kernel v6.6
Date: Mon, 24 Aug 2026 17:27:22 +0200
Message-ID: <20260824152734.159794-52-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824152734.159794-1-anders.roxell@linaro.org>
References: <20260824152734.159794-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 24 Aug 2026 16:43:55 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jens Wiklander <jens.wiklander@linaro.org>

Sync Linux kernel dwc3 changes from v6.5 to v6.6.

The following files are preserved across the import:
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
8d1de0ebce71 usb: dwc3: remove unnecessary platform_set_drvdata()
3609699c32aa usb: dwc3-am62: Rename private data

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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
2.53.0

