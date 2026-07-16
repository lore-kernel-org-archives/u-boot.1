Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0336CC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C50484DF7;
	Thu, 16 Jul 2026 18:09:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f5A0bwwt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 740E784CCF; Thu, 16 Jul 2026 15:43:54 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 015E684CEB
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:43:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c1676648c1eso20139666b.0
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209431; x=1784814231; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I2JK4gBOiE45s4SdTLjKl/vX1TkwEfBMMpGYZ99U/T0=;
 b=f5A0bwwtvCaIdbTaEOFN0wFrvNTL2no6R3+HcvVLhe0/MSizapNP90wb+R5vNA9xlo
 ka45mEBPyOQB+goV8wWkn7iP3/g5MTcMjPgmmyUPsrlsWiT5+l1JYgVFhbNwyuvhkyDb
 80hiaG6qBOzeAI9i3OkgaFLTlpccinJzU/cAKWrFVmxUUt2ugdgi2RzFYkph1jWpqc92
 3V9ydp8qNmH0uUa9MSQnUhgc/pCyUf4Hr49dv7xMPM9VsPdPbHmFq57L3G5Nme/l4Gaq
 h8TF7ZQ/GZsaV5rxuXjoLcK9jNHvv+eDEDFjiT9zBp9O+KbHYjs5sqFQuZ5Gtg9GdANC
 sRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209431; x=1784814231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=I2JK4gBOiE45s4SdTLjKl/vX1TkwEfBMMpGYZ99U/T0=;
 b=UQHidmxaPHSyhWaA8aincNSamusnNA8oLP5DUGwUWfW0Ac9cmWaZs7WxpsHDGV+fYm
 cxdtnEx8fLKxcopfPEiqN+pB5eI/QcO7/+HuIuGGWfVChmgO31uqLdG71K5ma4Yq/56a
 9J/hEBJbwR46LWavbOq5QsVbCLSQh/X0MEvtiIugMTFZ5FcN+h8QgLna/jRB3VTOwKIe
 H2jNgQeKfQV8ZxeBPGiOcWtSqjue2cHSkU+fosGSMTddGynP6sZ7GYQLlxM/eSCHZF4J
 cJPBwnVq83w8T9DLCFMUYVxZg+xZ7xYdvbvrBVSMQUYETtJi/U/EqbCXasAHnAH730LA
 4p7A==
X-Gm-Message-State: AOJu0YyrNK6Lq0Fmp3Z2GDNeBNvMdyC2THg8uJrsVmLFD2kRALAyd+C5
 hBhpYkp1+AN1KAT+68xl6mr+YIJamytwMl52PYBJkjJgBXvOdZ2N/j8xQKvDeAmNPP/TzzLu4tE
 3agFC
X-Gm-Gg: AfdE7clXmA5MCkKSZFDGuK6BvHypDPum2E/Kcoan0DIKo+IG1bJJjNCesfb5MhLGr7V
 iqy6fMqrBf62D0aZdPzpmV9zYEjNtj2y4VYZK6c0A9QJ0WnFw6XmFGyYZd/xiLz6e6sWLuIhHtW
 Z2Vz2POAdXVww4WTnT4SqQNplu3Jk93s+dlkxG+wd3iftFMVqjJQy9SKzunXIEnvHW+T5j+nXLF
 wOFI1cUsgPeMDsDLwetLLnJaxhaKuFqjcCrgusscSPDlWdmzLmpCz3QEAqkHTl0CY4z+94p1YRC
 49NTpYjz0Mn0VbGkLmfIafSfcdZdm3r/9kLNmpa6xBKOYt5u9Gb9Av+VccCVTjOA68JlQ5tU10H
 TEnj3qGtiIpzJmwwEv8++igEZKi5psdB2f6ecKY05vzXejDR855j8syde/PkMLfO5sLIhe1l8eJ
 qZALr5638dQ5rcRDlTIMdW9OGvyg/ERbCOhcHFqObEvfeIDZ29
X-Received: by 2002:a17:906:6a28:b0:c15:de99:8060 with SMTP id
 a640c23a62f3a-c161de22dbemr669196866b.0.1784209431177; 
 Thu, 16 Jul 2026 06:43:51 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744e6ecsm211650566b.44.2026.07.16.06.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:43:50 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 28/75] usb: dwc3: import from kernel v5.4
Date: Thu, 16 Jul 2026 15:41:58 +0200
Message-ID: <20260716134305.614278-29-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v5.3 to v5.4.

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

List of commits: git log --oneline v5.3..v5.4
Commits imported:
d8eca64eec71 usb: dwc3: gadget: fix race when disabling ep with cancelled xfers
a7d9874c6f3f usb: dwc3: remove the call trace of USBx_GFLADJ
9bbfceea12a8 usb: dwc3: pci: prevent memory leak in dwc3_pci_probe
a51bab592fbb usb: dwc3: select CONFIG_REGMAP_MMIO
d819f6584c20 usb: dwc3: Remove dev_err() on platform_get_irq() failure
f146b40ba1f0 usb: dwc3: Switch to platform_get_irq_byname_optional()
a0a465569b45 usb: dwc3: remove generic PHY calibrate() calls
17b63704ec7c usb: dwc3: gadget: Workaround Mirosoft's BESL check
91f255a26bce usb: common: Separated decoding functions from dwc3 driver.
54fb5ba647f8 usb: dwc3: gadget: Set BESL config parameter
16fe4f304015 usb: dwc3: Separate field holding multiple properties
1cf084d161f4 usb: dwc3: meson-g12a: fix suspend resume regulator unbalanced disables
bceb418b65b9 usb: dwc3: st: Add of_dev_put() in probe function
e36721b90144 usb: dwc3: st: Add of_node_put() before return in probe function
c09b73cfac2a usb: dwc3: don't set gadget->is_otg flag
240b65dc1e89 usb: dwc3: Use clk_bulk_prepare_enable()
03bf32bbb607 usb: dwc3: Use devres to get clocks
3cd703f483d1 usb: dwc3: remove generic PHYs forwarding for XHCI device
4749e0e61241 usb: dwc3: Update soft-reset wait polling rate
b2a3974253d3 usb: dwc3: omap: squash include/linux/platform_data/dwc3-omap.h
a6e5e6794a53 usb: dwc3: Switch to use device_property_count_u32()
5b76f6a0b0f8 usb: dwc3: keystone: use devm_platform_ioremap_resource() to simplify code
58dd0bad2554 usb: dwc3: omap: use devm_platform_ioremap_resource() to simplify code
c6e4999cd930 usb: dwc3: meson-g12a: use devm_platform_ioremap_resource() to simplify code
d3523b631403 usb: dwc3: meson-g12a: use devm_platform_ioremap_resource() to simplify code
b33f37064b74 usb: Remove dev_err() usage after platform_get_irq()
41b57327b270 usb: dwc3: Switch to use device_property_count_u32()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c   |  64 +++++-----
 drivers/usb/dwc3/core.h   |   2 +
 drivers/usb/dwc3/debug.h  | 252 --------------------------------------
 drivers/usb/dwc3/gadget.c |  37 ++++--
 4 files changed, 60 insertions(+), 295 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index c9bb93a2c81e..97d6ae3c4df2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -168,7 +168,6 @@ static void __dwc3_set_mode(struct work_struct *work)
 				otg_set_vbus(dwc->usb2_phy->otg, true);
 			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
 			phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
-			phy_calibrate(dwc->usb2_generic_phy);
 		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
@@ -252,12 +251,25 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 	reg |= DWC3_DCTL_CSFTRST;
 	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
+	/*
+	 * For DWC_usb31 controller 1.90a and later, the DCTL.CSFRST bit
+	 * is cleared only after all the clocks are synchronized. This can
+	 * take a little more than 50ms. Set the polling rate at 20ms
+	 * for 10 times instead.
+	 */
+	if (dwc3_is_usb31(dwc) && dwc->revision >= DWC3_USB31_REVISION_190A)
+		retries = 10;
+
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		if (!(reg & DWC3_DCTL_CSFTRST))
 			goto done;
 
-		udelay(1);
+		if (dwc3_is_usb31(dwc) &&
+		    dwc->revision >= DWC3_USB31_REVISION_190A)
+			msleep(20);
+		else
+			udelay(1);
 	} while (--retries);
 
 	phy_exit(dwc->usb3_generic_phy);
@@ -267,11 +279,11 @@ static int dwc3_core_soft_reset(struct dwc3 *dwc)
 
 done:
 	/*
-	 * For DWC_usb31 controller, once DWC3_DCTL_CSFTRST bit is cleared,
-	 * we must wait at least 50ms before accessing the PHY domain
-	 * (synchronization delay). DWC_usb31 programming guide section 1.3.2.
+	 * For DWC_usb31 controller 1.80a and prior, once DCTL.CSFRST bit
+	 * is cleared, we must wait at least 50ms before accessing the PHY
+	 * domain (synchronization delay).
 	 */
-	if (dwc3_is_usb31(dwc))
+	if (dwc3_is_usb31(dwc) && dwc->revision <= DWC3_USB31_REVISION_180A)
 		msleep(50);
 
 	return 0;
@@ -300,8 +312,7 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 
 	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
 	dft = reg & DWC3_GFLADJ_30MHZ_MASK;
-	if (!dev_WARN_ONCE(dwc->dev, dft == dwc->fladj,
-	    "request value same as default, ignoring\n")) {
+	if (dft != dwc->fladj) {
 		reg &= ~DWC3_GFLADJ_30MHZ_MASK;
 		reg |= DWC3_GFLADJ_30MHZ_SDBND_SEL | dwc->fladj;
 		dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
@@ -686,8 +697,7 @@ static void dwc3_core_exit(struct dwc3 *dwc)
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	phy_power_off(dwc->usb2_generic_phy);
 	phy_power_off(dwc->usb3_generic_phy);
-	clk_bulk_disable(dwc->num_clks, dwc->clks);
-	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
 	reset_control_assert(dwc->reset);
 }
 
@@ -813,8 +823,7 @@ static void dwc3_set_incr_burst_type(struct dwc3 *dwc)
 	 * result = 1, means INCRx burst mode supported.
 	 * result > 1, means undefined length burst mode supported.
 	 */
-	ntype = device_property_read_u32_array(dev,
-			"snps,incr-burst-type-adjustment", NULL, 0);
+	ntype = device_property_count_u32(dev, "snps,incr-burst-type-adjustment");
 	if (ntype <= 0)
 		return;
 
@@ -1166,7 +1175,6 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 				dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
-		phy_calibrate(dwc->usb2_generic_phy);
 		break;
 	case USB_DR_MODE_OTG:
 		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
@@ -1310,8 +1318,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;
 
-	dwc->hird_threshold = hird_threshold
-		| (dwc->is_utmi_l1_suspend << 4);
+	dwc->hird_threshold = hird_threshold;
 
 	dwc->rx_thr_num_pkt_prd = rx_thr_num_pkt_prd;
 	dwc->rx_max_burst_prd = rx_max_burst_prd;
@@ -1436,7 +1443,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (dev->of_node) {
 		dwc->num_clks = ARRAY_SIZE(dwc3_core_clks);
 
-		ret = clk_bulk_get(dev, dwc->num_clks, dwc->clks);
+		ret = devm_clk_bulk_get(dev, dwc->num_clks, dwc->clks);
 		if (ret == -EPROBE_DEFER)
 			return ret;
 		/*
@@ -1449,16 +1456,12 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	ret = reset_control_deassert(dwc->reset);
 	if (ret)
-		goto put_clks;
+		return ret;
 
-	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
+	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
 	if (ret)
 		goto assert_reset;
 
-	ret = clk_bulk_enable(dwc->num_clks, dwc->clks);
-	if (ret)
-		goto unprepare_clks;
-
 	if (!dwc3_core_is_valid(dwc)) {
 		dev_err(dwc->dev, "this is not a DesignWare USB3 DRD Core\n");
 		ret = -ENODEV;
@@ -1531,13 +1534,9 @@ err1:
 	pm_runtime_disable(&pdev->dev);
 
 disable_clks:
-	clk_bulk_disable(dwc->num_clks, dwc->clks);
-unprepare_clks:
-	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
 assert_reset:
 	reset_control_assert(dwc->reset);
-put_clks:
-	clk_bulk_put(dwc->num_clks, dwc->clks);
 
 	return ret;
 }
@@ -1560,7 +1559,6 @@ static int dwc3_remove(struct platform_device *pdev)
 
 	dwc3_free_event_buffers(dwc);
 	dwc3_free_scratch_buffers(dwc);
-	clk_bulk_put(dwc->num_clks, dwc->clks);
 
 	return 0;
 }
@@ -1574,14 +1572,10 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	if (ret)
 		return ret;
 
-	ret = clk_bulk_prepare(dwc->num_clks, dwc->clks);
+	ret = clk_bulk_prepare_enable(dwc->num_clks, dwc->clks);
 	if (ret)
 		goto assert_reset;
 
-	ret = clk_bulk_enable(dwc->num_clks, dwc->clks);
-	if (ret)
-		goto unprepare_clks;
-
 	ret = dwc3_core_init(dwc);
 	if (ret)
 		goto disable_clks;
@@ -1589,9 +1583,7 @@ static int dwc3_core_init_for_resume(struct dwc3 *dwc)
 	return 0;
 
 disable_clks:
-	clk_bulk_disable(dwc->num_clks, dwc->clks);
-unprepare_clks:
-	clk_bulk_unprepare(dwc->num_clks, dwc->clks);
+	clk_bulk_disable_unprepare(dwc->num_clks, dwc->clks);
 assert_reset:
 	reset_control_assert(dwc->reset);
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 3dd783b889cb..1c8b349379af 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1137,6 +1137,8 @@ struct dwc3 {
 #define DWC3_USB31_REVISION_120A	(0x3132302a | DWC3_REVISION_IS_DWC31)
 #define DWC3_USB31_REVISION_160A	(0x3136302a | DWC3_REVISION_IS_DWC31)
 #define DWC3_USB31_REVISION_170A	(0x3137302a | DWC3_REVISION_IS_DWC31)
+#define DWC3_USB31_REVISION_180A	(0x3138302a | DWC3_REVISION_IS_DWC31)
+#define DWC3_USB31_REVISION_190A	(0x3139302a | DWC3_REVISION_IS_DWC31)
 
 	u32			version_type;
 
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index 068259fdfb0c..9baabed87d61 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -246,258 +246,6 @@ static inline const char *dwc3_gadget_event_string(char *str, size_t size,
 	return str;
 }
 
-static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *str,
-		size_t size)
-{
-	switch (t & USB_RECIP_MASK) {
-	case USB_RECIP_DEVICE:
-		snprintf(str, size, "Get Device Status(Length = %d)", l);
-		break;
-	case USB_RECIP_INTERFACE:
-		snprintf(str, size, "Get Interface Status(Intf = %d, Length = %d)",
-				i, l);
-		break;
-	case USB_RECIP_ENDPOINT:
-		snprintf(str, size, "Get Endpoint Status(ep%d%s)",
-			i & ~USB_DIR_IN,
-			i & USB_DIR_IN ? "in" : "out");
-		break;
-	}
-}
-
-static inline void dwc3_decode_set_clear_feature(__u8 t, __u8 b, __u16 v,
-		__u16 i, char *str, size_t size)
-{
-	switch (t & USB_RECIP_MASK) {
-	case USB_RECIP_DEVICE:
-		snprintf(str, size, "%s Device Feature(%s%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			({char *s;
-				switch (v) {
-				case USB_DEVICE_SELF_POWERED:
-					s = "Self Powered";
-					break;
-				case USB_DEVICE_REMOTE_WAKEUP:
-					s = "Remote Wakeup";
-					break;
-				case USB_DEVICE_TEST_MODE:
-					s = "Test Mode";
-					break;
-				case USB_DEVICE_U1_ENABLE:
-					s = "U1 Enable";
-					break;
-				case USB_DEVICE_U2_ENABLE:
-					s = "U2 Enable";
-					break;
-				case USB_DEVICE_LTM_ENABLE:
-					s = "LTM Enable";
-					break;
-				default:
-					s = "UNKNOWN";
-				} s; }),
-			v == USB_DEVICE_TEST_MODE ?
-			({ char *s;
-				switch (i) {
-				case TEST_J:
-					s = ": TEST_J";
-					break;
-				case TEST_K:
-					s = ": TEST_K";
-					break;
-				case TEST_SE0_NAK:
-					s = ": TEST_SE0_NAK";
-					break;
-				case TEST_PACKET:
-					s = ": TEST_PACKET";
-					break;
-				case TEST_FORCE_EN:
-					s = ": TEST_FORCE_EN";
-					break;
-				default:
-					s = ": UNKNOWN";
-				} s; }) : "");
-		break;
-	case USB_RECIP_INTERFACE:
-		snprintf(str, size, "%s Interface Feature(%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			v == USB_INTRF_FUNC_SUSPEND ?
-			"Function Suspend" : "UNKNOWN");
-		break;
-	case USB_RECIP_ENDPOINT:
-		snprintf(str, size, "%s Endpoint Feature(%s ep%d%s)",
-			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
-			v == USB_ENDPOINT_HALT ? "Halt" : "UNKNOWN",
-			i & ~USB_DIR_IN,
-			i & USB_DIR_IN ? "in" : "out");
-		break;
-	}
-}
-
-static inline void dwc3_decode_set_address(__u16 v, char *str, size_t size)
-{
-	snprintf(str, size, "Set Address(Addr = %02x)", v);
-}
-
-static inline void dwc3_decode_get_set_descriptor(__u8 t, __u8 b, __u16 v,
-		__u16 i, __u16 l, char *str, size_t size)
-{
-	snprintf(str, size, "%s %s Descriptor(Index = %d, Length = %d)",
-		b == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
-		({ char *s;
-			switch (v >> 8) {
-			case USB_DT_DEVICE:
-				s = "Device";
-				break;
-			case USB_DT_CONFIG:
-				s = "Configuration";
-				break;
-			case USB_DT_STRING:
-				s = "String";
-				break;
-			case USB_DT_INTERFACE:
-				s = "Interface";
-				break;
-			case USB_DT_ENDPOINT:
-				s = "Endpoint";
-				break;
-			case USB_DT_DEVICE_QUALIFIER:
-				s = "Device Qualifier";
-				break;
-			case USB_DT_OTHER_SPEED_CONFIG:
-				s = "Other Speed Config";
-				break;
-			case USB_DT_INTERFACE_POWER:
-				s = "Interface Power";
-				break;
-			case USB_DT_OTG:
-				s = "OTG";
-				break;
-			case USB_DT_DEBUG:
-				s = "Debug";
-				break;
-			case USB_DT_INTERFACE_ASSOCIATION:
-				s = "Interface Association";
-				break;
-			case USB_DT_BOS:
-				s = "BOS";
-				break;
-			case USB_DT_DEVICE_CAPABILITY:
-				s = "Device Capability";
-				break;
-			case USB_DT_PIPE_USAGE:
-				s = "Pipe Usage";
-				break;
-			case USB_DT_SS_ENDPOINT_COMP:
-				s = "SS Endpoint Companion";
-				break;
-			case USB_DT_SSP_ISOC_ENDPOINT_COMP:
-				s = "SSP Isochronous Endpoint Companion";
-				break;
-			default:
-				s = "UNKNOWN";
-				break;
-			} s; }), v & 0xff, l);
-}
-
-
-static inline void dwc3_decode_get_configuration(__u16 l, char *str,
-		size_t size)
-{
-	snprintf(str, size, "Get Configuration(Length = %d)", l);
-}
-
-static inline void dwc3_decode_set_configuration(__u8 v, char *str, size_t size)
-{
-	snprintf(str, size, "Set Configuration(Config = %d)", v);
-}
-
-static inline void dwc3_decode_get_intf(__u16 i, __u16 l, char *str,
-		size_t size)
-{
-	snprintf(str, size, "Get Interface(Intf = %d, Length = %d)", i, l);
-}
-
-static inline void dwc3_decode_set_intf(__u8 v, __u16 i, char *str, size_t size)
-{
-	snprintf(str, size, "Set Interface(Intf = %d, Alt.Setting = %d)", i, v);
-}
-
-static inline void dwc3_decode_synch_frame(__u16 i, __u16 l, char *str,
-		size_t size)
-{
-	snprintf(str, size, "Synch Frame(Endpoint = %d, Length = %d)", i, l);
-}
-
-static inline void dwc3_decode_set_sel(__u16 l, char *str, size_t size)
-{
-	snprintf(str, size, "Set SEL(Length = %d)", l);
-}
-
-static inline void dwc3_decode_set_isoch_delay(__u8 v, char *str, size_t size)
-{
-	snprintf(str, size, "Set Isochronous Delay(Delay = %d ns)", v);
-}
-
-/**
- * dwc3_decode_ctrl - returns a string represetion of ctrl request
- */
-static inline const char *dwc3_decode_ctrl(char *str, size_t size,
-		__u8 bRequestType, __u8 bRequest, __u16 wValue, __u16 wIndex,
-		__u16 wLength)
-{
-	switch (bRequest) {
-	case USB_REQ_GET_STATUS:
-		dwc3_decode_get_status(bRequestType, wIndex, wLength, str,
-				size);
-		break;
-	case USB_REQ_CLEAR_FEATURE:
-	case USB_REQ_SET_FEATURE:
-		dwc3_decode_set_clear_feature(bRequestType, bRequest, wValue,
-				wIndex, str, size);
-		break;
-	case USB_REQ_SET_ADDRESS:
-		dwc3_decode_set_address(wValue, str, size);
-		break;
-	case USB_REQ_GET_DESCRIPTOR:
-	case USB_REQ_SET_DESCRIPTOR:
-		dwc3_decode_get_set_descriptor(bRequestType, bRequest, wValue,
-				wIndex, wLength, str, size);
-		break;
-	case USB_REQ_GET_CONFIGURATION:
-		dwc3_decode_get_configuration(wLength, str, size);
-		break;
-	case USB_REQ_SET_CONFIGURATION:
-		dwc3_decode_set_configuration(wValue, str, size);
-		break;
-	case USB_REQ_GET_INTERFACE:
-		dwc3_decode_get_intf(wIndex, wLength, str, size);
-		break;
-	case USB_REQ_SET_INTERFACE:
-		dwc3_decode_set_intf(wValue, wIndex, str, size);
-		break;
-	case USB_REQ_SYNCH_FRAME:
-		dwc3_decode_synch_frame(wIndex, wLength, str, size);
-		break;
-	case USB_REQ_SET_SEL:
-		dwc3_decode_set_sel(wLength, str, size);
-		break;
-	case USB_REQ_SET_ISOCH_DELAY:
-		dwc3_decode_set_isoch_delay(wValue, str, size);
-		break;
-	default:
-		snprintf(str, size, "%02x %02x %02x %02x %02x %02x %02x %02x",
-			bRequestType, bRequest,
-			cpu_to_le16(wValue) & 0xff,
-			cpu_to_le16(wValue) >> 8,
-			cpu_to_le16(wIndex) & 0xff,
-			cpu_to_le16(wIndex) >> 8,
-			cpu_to_le16(wLength) & 0xff,
-			cpu_to_le16(wLength) >> 8);
-	}
-
-	return str;
-}
-
 /**
  * dwc3_ep_event_string - returns event name
  * @event: then event code
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 173f5329d3d9..a9aba716bf80 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -707,6 +707,12 @@ static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
 
 		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
 	}
+
+	while (!list_empty(&dep->cancelled_list)) {
+		req = next_request(&dep->cancelled_list);
+
+		dwc3_gadget_giveback(dep, req, -ESHUTDOWN);
+	}
 }
 
 /**
@@ -2078,6 +2084,26 @@ static void dwc3_gadget_config_params(struct usb_gadget *g,
 {
 	struct dwc3		*dwc = gadget_to_dwc(g);
 
+	params->besl_baseline = USB_DEFAULT_BESL_UNSPECIFIED;
+	params->besl_deep = USB_DEFAULT_BESL_UNSPECIFIED;
+
+	/* Recommended BESL */
+	if (!dwc->dis_enblslpm_quirk) {
+		/*
+		 * If the recommended BESL baseline is 0 or if the BESL deep is
+		 * less than 2, Microsoft's Windows 10 host usb stack will issue
+		 * a usb reset immediately after it receives the extended BOS
+		 * descriptor and the enumeration will fail. To maintain
+		 * compatibility with the Windows' usb stack, let's set the
+		 * recommended BESL baseline to 1 and clamp the BESL deep to be
+		 * within 2 to 15.
+		 */
+		params->besl_baseline = 1;
+		if (dwc->is_utmi_l1_suspend)
+			params->besl_deep =
+				clamp_t(u8, dwc->hird_threshold, 2, 15);
+	}
+
 	/* U1 Device exit Latency */
 	if (dwc->dis_u1_entry_quirk)
 		params->bU1devExitLat = 0;
@@ -2868,7 +2894,8 @@ static void dwc3_gadget_conndone_interrupt(struct dwc3 *dwc)
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		reg &= ~(DWC3_DCTL_HIRD_THRES_MASK | DWC3_DCTL_L1_HIBER_EN);
 
-		reg |= DWC3_DCTL_HIRD_THRES(dwc->hird_threshold);
+		reg |= DWC3_DCTL_HIRD_THRES(dwc->hird_threshold |
+					    (dwc->is_utmi_l1_suspend << 4));
 
 		/*
 		 * When dwc3 revisions >= 2.40a, LPM Erratum is enabled and
@@ -3243,14 +3270,14 @@ static int dwc3_gadget_get_irq(struct dwc3 *dwc)
 	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
 	int irq;
 
-	irq = platform_get_irq_byname(dwc3_pdev, "peripheral");
+	irq = platform_get_irq_byname_optional(dwc3_pdev, "peripheral");
 	if (irq > 0)
 		goto out;
 
 	if (irq == -EPROBE_DEFER)
 		goto out;
 
-	irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+	irq = platform_get_irq_byname_optional(dwc3_pdev, "dwc_usb3");
 	if (irq > 0)
 		goto out;
 
@@ -3261,9 +3288,6 @@ static int dwc3_gadget_get_irq(struct dwc3 *dwc)
 	if (irq > 0)
 		goto out;
 
-	if (irq != -EPROBE_DEFER)
-		dev_err(dwc->dev, "missing peripheral IRQ\n");
-
 	if (!irq)
 		irq = -EINVAL;
 
@@ -3318,7 +3342,6 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
 	dwc->gadget.sg_supported	= true;
 	dwc->gadget.name		= "dwc3-gadget";
-	dwc->gadget.is_otg		= dwc->dr_mode == USB_DR_MODE_OTG;
 	dwc->gadget.lpm_capable		= true;
 
 	/*
-- 
2.53.0

