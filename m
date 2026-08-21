Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD20C5DF8E
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:14:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ACC1440C70;
	Fri, 21 Aug 2026 13:14:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2JTBqXs-rvdk; Fri, 21 Aug 2026 13:14:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787318048;
	bh=8hKOHLjQYw6SSk3eHqSe8KLczL5iiwsi1dTbjAbKap8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eAoUK77uFDGNyzyIcDV4Q8c+mlD+p6uME/zhpqv9pbPvBchlCgAD0dDuExpCb5bcF
	 wGXp3v53lFzQsadaiAj013fG/MTtPWiuoG4uRUe5ziz7ZrNlQT3EUyWhyOOAHyVzD6
	 UoMa2HKqaPSKvTYV+eltQEaxC0P9Yk1uvwDz1ciYnW4HNXckGE9ao7h+f/4oySLScI
	 fPd4inRTuDJ9Df8gQJv9raLtbc4SDmA+QlRPbxIkC7Wbmkr6juW0M5B9w+ybTiiwq3
	 DckP2mO9nmaz5OuudESIzwa5PkYSBm+5bsvb1lvSLJmYRvBPpeD8l/Ql5gVJ1RIxDl
	 +iPgH6nvOR2HA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCB2F40CEE;
	Fri, 21 Aug 2026 13:14:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D584263
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7EBE7810A1
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G72bElrrDdKX for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:52:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; spf=fail smtp.mailfrom=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=i8suvDT0
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D214381000
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:52:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AC728498B; Fri, 21 Aug 2026 10:52:05 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DECB84A12
 for <u-boot@lists.denx.de>; Fri, 21 Aug 2026 10:52:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="i8suvDT0"; 
 dkim-atps=neutral
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c16111a9b8dso8230666b.1
 for <u-boot@lists.denx.de>; Fri, 21 Aug 2026 01:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302322; x=1787907122; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8hKOHLjQYw6SSk3eHqSe8KLczL5iiwsi1dTbjAbKap8=;
 b=i8suvDT0iesewd6YKiz1N5Mam5tBRj7b0tSuHIGAuWWkp9ArxjAR1ME0UfLkH3csoa
 qqnyeKODOEyyoSCTH2/2dqzsuWLACbY+H+5Ahlg/3faFjrRPM0CEstY1i9j4FXbnQIIi
 +4a+QidZU9IiLsU2hKfe4c745agSIGf3WGcDSgwTNwtyhXQieBa52CzjGq58bo3OVCTf
 TbVKj/cvIm3dN3kzEhNHHjmZotxIY7UrPvH5Tt/ngomebYzK2YDnGpS8eONbV4katks8
 b6DiU3RIjO/Q1riGc88gaGFlUWA9rc3ySejSorJwYNGWiJOt0ie2/1OjpbilagoHRoJs
 ItFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302322; x=1787907122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8hKOHLjQYw6SSk3eHqSe8KLczL5iiwsi1dTbjAbKap8=;
 b=DrvWnMM/qA4gg9fETqOEyHRvE5LhWVauJ/Rx4PIFgx7k+rVN81/buRRadSHANwFSkD
 clE2NU3XLyZd7VIDtSd0gDasyh3VYxYHwTGL6UfRC99JrkWoniH+ZHZfWL0/7NwDJi/s
 KXh+jvQJedi6zYTcXaTC1x0JMI5j69gvG8TUsniLTac6lhP3Abe6zQuJQhiJ7v9CWTQb
 kboFTLdfjk4V5cEQ7wfARSEG69iVbW2eNx/SYRY4rraxlmyXT3PKil7JRWPPTkuMigoX
 OaLMqxUt8dy84jcYn3LvfSXlq3dbzKhh6QK/hdpOtymaQdbEvR1nj4d3mk0xCR+IfngU
 nqww==
X-Gm-Message-State: AFuF++kaB4EgiWqxmHjDK8dtCfsNrI1pAyJzjfhHTakQTRpIEZ1JB9cb
 AaT0TlW9sVn9fEgWkzYu8YXKTzv/e9Um0v9ghlAgTQV1+4/67+97qPmXxOV1jhGUx6KrOCLXL8S
 cctk7
X-Gm-Gg: AR+sD13mguBjEhyk7KMvSduAb+lW8ZRSBRtJYvT+z+SXuJ8ZrsxU0X4OZC2j7WgN7di
 zB0v4pPCnj0IfkUAZ+NEhLyu35dGFCgQHDjSbe2GqAyli1ggVMecVJjS46fseDI5zD2XOYbsRP8
 SMCcMwPQ+M7h8i3M4CMdJLsJubrgwlblX/JdbyvVAeqC4DS7QF9pskv/LnuGgaoHAWxq5wE9aKL
 xONIG8KDVWaC9h7e0TgjFWJv1j34pcbFXMk838njCxMUzhJ9KFAn5DVrW1Pw/YvhiDDAvZWeG6D
 9nTQcgKIxSDtcNKj+6fmx0omlyOlekSuv73KScrIL1dAR/vnVbgaZOEdqi4529ftZMX49yra3dY
 VxGCd+GcIpsrBqqL99w2KQg7kvCphQzn0C5fTI7mU0vyKyVAf5ZURLZmLD9GQempqVAL2nZV4v3
 fd9DaEhXFsQbhqVkqmX8n/MGvL2jL6n+YMTR4uY9p7+SaJYTUXxeIS9VmN7QDhC0LqzsMk0nyEP
 tCz1M1kpC31XxD4Av4O9iUiNWZwISO4/6s=
X-Received: by 2002:a17:906:c144:b0:c1f:e0fd:1140 with SMTP id
 a640c23a62f3a-c2469f92425mr244403966b.0.1787302322474; 
 Fri, 21 Aug 2026 01:52:02 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a3ff16c16bsm5411770a12.20.2026.08.21.01.52.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:52:01 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, u-boot@lists.u-boot-project.org
Subject: [PATCH v6 51/87] usb: dwc3: import from kernel v6.6
Date: Fri, 21 Aug 2026 10:47:27 +0200
Message-ID: <20260821084829.2070426-52-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:40 +0000
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

