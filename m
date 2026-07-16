Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928DDC44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 494BC84D26;
	Thu, 16 Jul 2026 18:09:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UdWXneuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C52984CCF; Thu, 16 Jul 2026 15:43:17 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 466FD84C3F
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:43:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c166ec26696so35175266b.0
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209395; x=1784814195; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=49YRfS39czV50wWN00k6UojcArffG7OeGDXfGYSpdGc=;
 b=UdWXneuNAJYJ7ks2cOAaP75fCKy9VvelXOlX4muAwloAAAuqi+D2gDzv2eaj5mX0+K
 W60ajqqR5ZFgesIWEXQzmqgLxNn0X6bm0dYCQwk56Eg643xOTlDTLR0hvt8461FDSe4b
 tY0U8Mr0w7439tBLclf7EJM6k/Z8fGiZ3n8YalZVkfsJ9kCmATUdEl4NctN2It7RXPGZ
 s6HApcqfN9ZNTL0YzONxkRTg3waffBXp/ULdcWpBj0zfioPlRM8zMare6/tP+oipmmOP
 C80NV3cbRD+HpyMxF8wKxwVi7h8ymxHiUjpgvuJga177Ox9qnExO5tpFc5nk2It3/Vbi
 yfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209395; x=1784814195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=49YRfS39czV50wWN00k6UojcArffG7OeGDXfGYSpdGc=;
 b=P6EZmiTvzOfQFIaMOaDJc6LG+FnHL1YIWewMm8zwlcJu+Iph3tT0YJkicyDLawzXfI
 GXcVnDoPO5mjjgnxxUAlIsHhFm7Avw48wbw96SQyuIPb9dIUKMI2iyUAeCINRoO53tCm
 yMsa/E9to5JEZAooKaPB3L0EyWKX+m5pekVRlDXJva3nzIuPHKVfDyJOQks1roJ4Tbaz
 ZcQ/a+TH+gd0izOqLDqnM3WrKr6ER5laRQBUhrkK+7WvbWwSK0KMhG8sK7BXuq/ohBRZ
 xzDYNrhJqj48/Hl5S+8ab66GiS+OxfGBsA/WwfimnOOFqTnqBC3FiDYZFYCcdZxZtWHU
 vgOw==
X-Gm-Message-State: AOJu0YzJEwOz7XP9DfXI7g8SOJ3LF87mIDXRJ7l86ibtYCcBtt2KAhOw
 Anlt288JAw/cjBPSb7SIEGMTzRTh1VXz0wpk+XsQ744T7Qt2fuHaIsBb134Sh8Vlb6c8cd7MGGC
 /qRgT
X-Gm-Gg: AfdE7ckm04OzZAVbrCI6YmumkMZxT7zkpW5/W1kbCC8HImzcRij7gYJJY7W7Y3JdDqJ
 ceZWkd+5H+Uy3ll4jmNQSiS+UfseTAkJvA0rCsn6AA0lR2JW87t9pN/jt8NPdjaFrBqJNAP/Hyg
 zKMVxCdHHbkTPVIjsoYw4qrRv7a6c9y64nUeyZYc6550s19857yKPOyHRpLY81j/DAoBKb+Xm2O
 Nk1ka387x4ZBlYd+CDo3FUrPXGwva2LFUzmVAP3pagHa6YGcwODIvrjMgyKqC20NCplj+4Jemby
 vxMIeHJ3+3tGO4Ahd6ThnJ2RfvOCSJMWmOvtQ7yXESFg+oEvEfjLEz9mgPh68LoxKvijbb1Mt+4
 gMz2zykTppvsUpnnt71+rNQoesKX9dqcqnR0mADEPzbgDZRBuekF/OqCEpgEYTB/js8odyavfZU
 0eGwpmEyNm9SdogeN0wEDeSXRRj+NtFrP5378KNw==
X-Received: by 2002:a17:907:7256:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c168dd4abc0mr114052966b.4.1784209394520; 
 Thu, 16 Jul 2026 06:43:14 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1687125db5sm219607666b.12.2026.07.16.06.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:43:13 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 04/75] usb: dwc3: import from kernel v4.1
Date: Thu, 16 Jul 2026 15:41:34 +0200
Message-ID: <20260716134305.614278-5-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.0 to v4.1.

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

List of commits: git log --oneline v4.0..v4.1
Commits imported:
459e210c4fd0 usb: dwc3: gadget: Fix incorrect DEPCMD and DGCMD status macros
228321904089 usb: dwc3: dwc3-omap: correct the register macros
eac68e8f979b usb: dwc3: make LPM configurable in DT
adf9c3c85615 usb: move definition of PCI_VENDOR_ID_SYNOPSYS to linux/pci_ids.h
8f2c9544aba6 usb: dwc3: gadget: drop unnecessary loop when cleaning up TRBs
3d0184d08757 usb: dwc3: omap: call of_platform_depopulate() instead
3da1f6ee3563 usb: dwc3: core: only reset res->start in case of error

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/dwc3/core.c          | 59 ++++++++++++++++++++------------
 drivers/usb/dwc3/core.h          |  6 ++--
 drivers/usb/dwc3/gadget.c        | 37 +++++++++-----------
 drivers/usb/dwc3/platform_data.h |  1 +
 4 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9f0e209b8f6c..2bbab3d86fff 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -774,17 +774,13 @@ static int dwc3_probe(struct platform_device *pdev)
 	 * since it will be requested by the xhci-plat driver.
 	 */
 	regs = devm_ioremap_resource(dev, res);
-	if (IS_ERR(regs))
-		return PTR_ERR(regs);
+	if (IS_ERR(regs)) {
+		ret = PTR_ERR(regs);
+		goto err0;
+	}
 
 	dwc->regs	= regs;
 	dwc->regs_size	= resource_size(res);
-	/*
-	 * restore res->start back to its original value so that,
-	 * in case the probe is deferred, we don't end up getting error in
-	 * request the memory region the next time probe is called.
-	 */
-	res->start -= DWC3_GLOBALS_REGS_START;
 
 	/* default to highest possible threshold */
 	lpm_nyet_threshold = 0xff;
@@ -808,6 +804,8 @@ static int dwc3_probe(struct platform_device *pdev)
 				"snps,is-utmi-l1-suspend");
 		of_property_read_u8(node, "snps,hird-threshold",
 				&hird_threshold);
+		dwc->usb3_lpm_capable = of_property_read_bool(node,
+				"snps,usb3_lpm_capable");
 
 		dwc->needs_fifo_resize = of_property_read_bool(node,
 				"tx-fifo-resize");
@@ -848,6 +846,7 @@ static int dwc3_probe(struct platform_device *pdev)
 			hird_threshold = pdata->hird_threshold;
 
 		dwc->needs_fifo_resize = pdata->tx_fifo_resize;
+		dwc->usb3_lpm_capable = pdata->usb3_lpm_capable;
 		dwc->dr_mode = pdata->dr_mode;
 
 		dwc->disable_scramble_quirk = pdata->disable_scramble_quirk;
@@ -878,7 +877,7 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	ret = dwc3_core_get_phy(dwc);
 	if (ret)
-		return ret;
+		goto err0;
 
 	spin_lock_init(&dwc->lock);
 	platform_set_drvdata(pdev, dwc);
@@ -899,7 +898,7 @@ static int dwc3_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(dwc->dev, "failed to allocate event buffers\n");
 		ret = -ENOMEM;
-		goto err0;
+		goto err1;
 	}
 
 	if (IS_ENABLED(CONFIG_USB_DWC3_HOST))
@@ -913,65 +912,81 @@ static int dwc3_probe(struct platform_device *pdev)
 	ret = dwc3_core_init(dwc);
 	if (ret) {
 		dev_err(dev, "failed to initialize core\n");
-		goto err0;
+		goto err1;
 	}
 
 	usb_phy_set_suspend(dwc->usb2_phy, 0);
 	usb_phy_set_suspend(dwc->usb3_phy, 0);
 	ret = phy_power_on(dwc->usb2_generic_phy);
 	if (ret < 0)
-		goto err1;
+		goto err2;
 
 	ret = phy_power_on(dwc->usb3_generic_phy);
 	if (ret < 0)
-		goto err_usb2phy_power;
+		goto err3;
 
 	ret = dwc3_event_buffers_setup(dwc);
 	if (ret) {
 		dev_err(dwc->dev, "failed to setup event buffers\n");
-		goto err_usb3phy_power;
+		goto err4;
 	}
 
 	ret = dwc3_core_init_mode(dwc);
 	if (ret)
-		goto err2;
+		goto err5;
 
 	ret = dwc3_debugfs_init(dwc);
 	if (ret) {
 		dev_err(dev, "failed to initialize debugfs\n");
-		goto err3;
+		goto err6;
 	}
 
 	pm_runtime_allow(dev);
 
 	return 0;
 
-err3:
+err6:
 	dwc3_core_exit_mode(dwc);
 
-err2:
+err5:
 	dwc3_event_buffers_cleanup(dwc);
 
-err_usb3phy_power:
+err4:
 	phy_power_off(dwc->usb3_generic_phy);
 
-err_usb2phy_power:
+err3:
 	phy_power_off(dwc->usb2_generic_phy);
 
-err1:
+err2:
 	usb_phy_set_suspend(dwc->usb2_phy, 1);
 	usb_phy_set_suspend(dwc->usb3_phy, 1);
 	dwc3_core_exit(dwc);
 
-err0:
+err1:
 	dwc3_free_event_buffers(dwc);
 
+err0:
+	/*
+	 * restore res->start back to its original value so that, in case the
+	 * probe is deferred, we don't end up getting error in request the
+	 * memory region the next time probe is called.
+	 */
+	res->start -= DWC3_GLOBALS_REGS_START;
+
 	return ret;
 }
 
 static int dwc3_remove(struct platform_device *pdev)
 {
 	struct dwc3	*dwc = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	/*
+	 * restore res->start back to its original value so that, in case the
+	 * probe is deferred, we don't end up getting error in request the
+	 * memory region the next time probe is called.
+	 */
+	res->start -= DWC3_GLOBALS_REGS_START;
 
 	dwc3_debugfs_exit(dwc);
 	dwc3_core_exit_mode(dwc);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index d201910b892f..c0eafa6fd403 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -339,7 +339,7 @@
 #define DWC3_DGCMD_SET_ENDPOINT_NRDY	0x0c
 #define DWC3_DGCMD_RUN_SOC_BUS_LOOPBACK	0x10
 
-#define DWC3_DGCMD_STATUS(n)		(((n) >> 15) & 1)
+#define DWC3_DGCMD_STATUS(n)		(((n) >> 12) & 0x0F)
 #define DWC3_DGCMD_CMDACT		(1 << 10)
 #define DWC3_DGCMD_CMDIOC		(1 << 8)
 
@@ -355,7 +355,7 @@
 #define DWC3_DEPCMD_PARAM_SHIFT		16
 #define DWC3_DEPCMD_PARAM(x)		((x) << DWC3_DEPCMD_PARAM_SHIFT)
 #define DWC3_DEPCMD_GET_RSC_IDX(x)	(((x) >> DWC3_DEPCMD_PARAM_SHIFT) & 0x7f)
-#define DWC3_DEPCMD_STATUS(x)		(((x) >> 15) & 1)
+#define DWC3_DEPCMD_STATUS(x)		(((x) >> 12) & 0x0F)
 #define DWC3_DEPCMD_HIPRI_FORCERM	(1 << 11)
 #define DWC3_DEPCMD_CMDACT		(1 << 10)
 #define DWC3_DEPCMD_CMDIOC		(1 << 8)
@@ -689,6 +689,7 @@ struct dwc3_scratchpad_array {
  * @setup_packet_pending: true when there's a Setup Packet in FIFO. Workaround
  * @start_config_issued: true when StartConfig command has been issued
  * @three_stage_setup: set if we perform a three phase setup
+ * @usb3_lpm_capable: set if hadrware supports Link Power Management
  * @disable_scramble_quirk: set if we enable the disable scramble quirk
  * @u2exit_lfps_quirk: set if we enable u2exit lfps quirk
  * @u2ss_inp3_quirk: set if we enable P3 OK for U2/SS Inactive quirk
@@ -812,6 +813,7 @@ struct dwc3 {
 	unsigned		setup_packet_pending:1;
 	unsigned		start_config_issued:1;
 	unsigned		three_stage_setup:1;
+	unsigned		usb3_lpm_capable:1;
 
 	unsigned		disable_scramble_quirk:1;
 	unsigned		u2exit_lfps_quirk:1;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a03a485205c7..8946c32047e9 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1855,32 +1855,27 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	unsigned int		i;
 	int			ret;
 
+	req = next_request(&dep->req_queued);
+	if (!req) {
+		WARN_ON_ONCE(1);
+		return 1;
+	}
+	i = 0;
 	do {
-		req = next_request(&dep->req_queued);
-		if (!req) {
-			WARN_ON_ONCE(1);
-			return 1;
-		}
-		i = 0;
-		do {
-			slot = req->start_slot + i;
-			if ((slot == DWC3_TRB_NUM - 1) &&
+		slot = req->start_slot + i;
+		if ((slot == DWC3_TRB_NUM - 1) &&
 				usb_endpoint_xfer_isoc(dep->endpoint.desc))
-				slot++;
-			slot %= DWC3_TRB_NUM;
-			trb = &dep->trb_pool[slot];
-
-			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
-					event, status);
-			if (ret)
-				break;
-		}while (++i < req->request.num_mapped_sgs);
-
-		dwc3_gadget_giveback(dep, req, status);
+			slot++;
+		slot %= DWC3_TRB_NUM;
+		trb = &dep->trb_pool[slot];
 
+		ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
+				event, status);
 		if (ret)
 			break;
-	} while (1);
+	} while (++i < req->request.num_mapped_sgs);
+
+	dwc3_gadget_giveback(dep, req, status);
 
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 			list_empty(&dep->req_queued)) {
diff --git a/drivers/usb/dwc3/platform_data.h b/drivers/usb/dwc3/platform_data.h
index a3a3b6d5668c..a2bd464be828 100644
--- a/drivers/usb/dwc3/platform_data.h
+++ b/drivers/usb/dwc3/platform_data.h
@@ -24,6 +24,7 @@ struct dwc3_platform_data {
 	enum usb_device_speed maximum_speed;
 	enum usb_dr_mode dr_mode;
 	bool tx_fifo_resize;
+	bool usb3_lpm_capable;
 
 	unsigned is_utmi_l1_suspend:1;
 	u8 hird_threshold;
-- 
2.53.0

