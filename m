Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F5BC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91F0284994;
	Mon, 29 Jun 2026 10:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LyKXX7tw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D12384942; Mon, 29 Jun 2026 10:45:44 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F195184844
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-39acf7c6d59so24632661fa.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722741; x=1783327541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aAmeahCR6TCiFHaLceKxbECVpUL6DZLL7nsGzUpM7yw=;
 b=LyKXX7twMgsso7QdoH0hhaaKYufxS6rUZY92/7uBvm7UXHtxil6jSlan9qk5CCZOL9
 7yVc97qEoqEZ5gopIHcXs1Iv+DJmO5QzWXulvU2bgnstO3oaAFLQGGSPVUNusP8FhXQa
 hGnU0fM0eVVG4mB/vRHhyUPcG1rw2Il4lUKhQFhVNfBKu/30i3UwFij6Ul1jKZ1MytuA
 oBkNd7uCO5lWYY/CDluloxU+PMinO61eVoeMnLhH1rks8gKEw94oX/kEd0v+3h8zcP2l
 e6pOMdn/2lKs9Zxy7G0fE3ALJaxLRg8ESz8v/B7WCCiSRYE5bnuKaZCrQSNucPJ0/WrJ
 tWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722741; x=1783327541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aAmeahCR6TCiFHaLceKxbECVpUL6DZLL7nsGzUpM7yw=;
 b=H3nkWxSTkSWpCZoDPxDEHp9eFrYEGtwmgQ71lsNkbDNsZE4zQL3+KZneHIdh33fjtd
 kGkl4VYMhdTv67b3Y4d4gT4RHdgLK0YYhLFnFr0+OtAKGbJh20DhvWxQ1m3Cymqf4FPn
 QPP98NmjD7WWb3GdtsXAcmPYCk8ruG/jAX0QmP0l+GJSp67LC4lrNTHrjWntL7jiG5dp
 FpY8KN1sp8nrHJvcnQrfQeVishsUkZ8RrNRoEmGFNicVDNk3qjCx1M3xpNwbbQhLVFBJ
 N30cEC6uWf52ZTAMV3Lcjz7MGq1N7GJ1B6VGHXu/WVBmon469kuj226m2SzC/r4rnNus
 Ufqg==
X-Gm-Message-State: AOJu0YwUf5jF/BVzWM82bIB94ie3EcutSXdHgGPuZzwsywOjjKgi8GI5
 LU6MkP7Le2KN3IveV0xDEKJUgzKDGIiFAL7dNw36Pg7Bs5est7ZR6uzvuydamypz3mwplHyGMZ5
 N3hUWM4g=
X-Gm-Gg: AfdE7ckbGMCpuqNdN5axXx8WOQGR5jKe6I5MJ7lVrW2CnOI//x4xlXgx92LQIcmU+Ki
 qORRRP9d/c7TzMECT/U/UbvCHhE0IkWiNx0vWHSkxGxd5/4BVTLFutq4xil9TBCqwL9quglXBSv
 qtJJXFIxDzlRRscfVOXzQNaga6dBwWYmbe0gq3cIBcJVPCuSAkiqK02EL/NowDD6asaplLhZw5t
 ujqICAqwI24FQgnxPIGut/6QBbhs5oZRtkMHyebJvzYOgrTGI0YN+r85CpdGbU804x9WsaGBAiT
 8BfwQ/71GA2rKhCe+YDBusoaKUtH2z0Mjft+X9b4s8YmSK54vApMvVYo7xo50AzUrX4c6M9FfRK
 7N99EHyjJmXIbEgJV0Elo/GjM0Ov4Z2e/i4UCmXue+ihet2sr7Vuv11TJyZH4n/EpVetKe0HeMj
 jKdj66DDXB+cCYxKGWV8Gj1F0N434nlckccAnJRjs6zxp2J0J+kIFzE58jdm3rjLJvzx4hzw3gD
 pItJFg4q+gEJJlNeD8V
X-Received: by 2002:a2e:a814:0:b0:39a:ffae:4e51 with SMTP id
 38308e7fff4ca-39affae84e9mr8187401fa.23.1782722741118; 
 Mon, 29 Jun 2026 01:45:41 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:45:39 -0700 (PDT)
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
 Jens Wiklander <jens.wiklander@linaro.org>,
 Alexey Charkov <alchark@flipper.net>
Subject: [PATCH v4 04/64] usb: dwc3: import from kernel v4.1
Date: Mon, 29 Jun 2026 10:43:40 +0200
Message-ID: <20260629084507.3254232-5-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629084507.3254232-1-jens.wiklander@linaro.org>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
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
Tested-by: Alexey Charkov <alchark@flipper.net>
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
2.43.0

