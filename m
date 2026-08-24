Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9162C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 84D2C605F9;
	Mon, 24 Aug 2026 16:44:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SM7mg3MygL4H; Mon, 24 Aug 2026 16:44:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787589848;
	bh=ZfeOrQCHiy9VtwIVY+Z+Nl3jTLbRGZzPcndtj9CPfk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rM7cLQ7t01H1sileSMr98SLp5/ASZllVMEF6l9cNEXuxm+0m1Gv8M5aX980re7bUr
	 EEjr4g7XOKbglSz+8/EFCrWDq2Twtioq80/vFgYAQmv3gfp7Swpm3U3RWF8KUXMOjZ
	 fpVmgreCP/J87Hbta//h3tO6KzBG5xvHn//2GcE/+q3tL77gOJ1FoXmsMDYtyq6gKu
	 Wku3CfFAZI74dXFIwHsvOh5RNLSMSpvKhIfMkV0grDycz4s9fAlLfao7b+I5DfM0XM
	 WL7/DGE1WnffbUeJ5+4W/TwgAYPG2SQQ7wd0v0hQ9hvrhwtBgweKVpeRc45UzcID3E
	 dyOUwxV2Gzrzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 87F9060614;
	Mon, 24 Aug 2026 16:44:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id F0A07386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D788F80845
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bl1Dp6TJyPlL for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 15:28:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=PxmVA+Xu
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78AC1807B8
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 15:28:07 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c1f1f5631f8so34342966b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787585286; x=1788190086;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZfeOrQCHiy9VtwIVY+Z+Nl3jTLbRGZzPcndtj9CPfk0=;
 b=PxmVA+Xu2LFw6sTvEdfaDJO61R/B8D1yJAOJBj2dLMDjifqUDYSh/DCTRAuVwEQ+2+
 k49b4nNfQdRR9UWWNaLDIv8w6p0bQbW4VLprcZsvKAnAHtSci0xGSSVjzLnkArzkcsXv
 n2h2oS9jhyKr63YZgqM1t+K0iKmQsbcM1SjE4e2ssCb5bfshTsA95VbNf+bqvlFbVsKr
 jAyOHbe5PzurEleUcHhcTfeF6M8LtGVE1z0SPUJdeSUed2z2LolssH4iYbrj0/BaySxd
 mdeVphLJwHlgB+anfTtr3zAAaMuSKE3dGP6HLqO72vMzetJKnVOihhRSnJLcB9Xbl0vd
 PAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585286; x=1788190086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZfeOrQCHiy9VtwIVY+Z+Nl3jTLbRGZzPcndtj9CPfk0=;
 b=V0M+pDc+b+tBs72avBPGcJZ3nJBk6eh4ia3EIN9+xahS0Z/HW4qIPNGPrZD0ZBx6Ad
 Ny1gtrvohm/V5QY7AJw83FYSUR0qPATJvr0QfgjlGhNx63Xwm2mIJloz3/ivmz5KecKV
 nXcRjhUzIkVAM1D8wbTECEojqqADXIpVjK/8HTiltBw+JZbnTabStrdWca40CmrE23Ew
 EFG+ox2uhiGET1EYgyWq7huqhznCKfBTAuCFvsEE1Tfn9Q6wSh1BXh3+E2jxEYmolcqk
 6EQ5+J4jJamaLW+T2B7fSz1n2lOdsZMr7WZr7hBXJZi26l7PwgUJlfCj0VtnYXi4/Xfk
 afQw==
X-Gm-Message-State: AFuF++lZlxxbTYAEGI7sBo8WU1grwAE44xK+YXRLwrQ30HmFr67A8LPN
 fQCQahqUCk4JYIqvQPZq9ESISJQ7SwJu5hMcci5uj/q2qPX3XjJAWF93NffqPa3NbfRJnffN0uU
 phZBq
X-Gm-Gg: AR+sD13ieJ5+8X45KM2V638oDJGmHACDXph3scQ/1Rp1clt5duJh1Ah1oXdN864xcin
 DQMhIJ2hHc4OjLL0rPl+27HYe+6SOoEXsfa5sdDCt4kXXpXxOTLKz1NsfyQbT7qd074w6EOcRwS
 7cNHMkRWI0nAT4T7mgsM3etUZBUrjXgdDKWsJtU7NbBudmDOSTk0ZtASFL54EOe8gUxDgW5usOW
 4rKuAlV9LgZ6qjL1NZ7v45ri3jGAfIEaNBzXbyJHZGe/Lasz0Yh+qkkZi5JygZWfmTVy5Q5YEg5
 ZzPr0r6XWMCwfxfQNPRMg1lRJYe6IcLV31aCt9RXkU9VQLvKODVjQ276g9ddMqCpoeJP1uhO+J+
 m7DynJqavA9yyfCXwV2mm4YBtx1h+Cu4UzimnVeTpvENl0BLZ1zvopP/CnnIQdC/uxiF2SueEq+
 EjXj5ajw0VBnYUe9rRrE9+y8qTixUsfXr74wTn1BaXHv72Y+JMfjk6K5Ru/PTCIKK//Rd2hmw7/
 OxulLhBNzKzxu13kvkFEZ0uSB/dhUep
X-Received: by 2002:a17:907:a089:b0:c15:de99:8060 with SMTP id
 a640c23a62f3a-c2469f96e84mr1542696866b.0.1787585285800; 
 Mon, 24 Aug 2026 08:28:05 -0700 (PDT)
Received: from monster (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa1dsm1247744766b.56.2026.08.24.08.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:28:05 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.u-boot-project.org
Cc: marek.vasut@mailbox.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 michal.simek@amd.com, lukma@denx.de, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: [PATCH v7 05/63] usb: dwc3: import from kernel v4.1
Date: Mon, 24 Aug 2026 17:26:36 +0200
Message-ID: <20260824152734.159794-6-anders.roxell@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.0 to v4.1.

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

List of commits: git log --oneline v4.0..v4.1
Commits imported:
459e210c4fd0 usb: dwc3: gadget: Fix incorrect DEPCMD and DGCMD status macros
eac68e8f979b usb: dwc3: make LPM configurable in DT
8f2c9544aba6 usb: dwc3: gadget: drop unnecessary loop when cleaning up TRBs
3da1f6ee3563 usb: dwc3: core: only reset res->start in case of error

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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

