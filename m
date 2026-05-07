Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883A5CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:31:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E3E84A8E;
	Thu,  7 May 2026 11:29:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lxrVlXDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8DBE84A17; Thu,  7 May 2026 11:29:42 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1F7A84A7B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5a860667fabso521556e87.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146175; x=1778750975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jS/SllfmTaIblcuVWtKnhxrxuILJS7maGolHIWZMfjI=;
 b=lxrVlXDLznPAIOFAySmzLXI47/qJMKqRrLPj1Da2HFbb2QAbWM+VO+0qQ7j/h3jtRn
 WskCEWOmxyCrkewxrtl8gOhIh5SspUrJvh/4N/IrMkLfnLGcH2vYut1QILbOGB0vZD/W
 wNBV0wCeLQwXWg9KDHB1LZF877ehEH1ZLVf1B2TUBS8dZeTeO4r8nzsh3V51fCbAUYMp
 iNjZDzs4wpUU36+YHEhuJOxvPll8UVtV9hEAeGIIUuoctJ9NE/6XsT6Y9OHaLhk/B+2M
 vP2HeXV3e71lBdAbmIzVcutOe3gExBbVZIp5ZAd+KVK0zY5vY7jsVcWzOtEHZAwZ+W0U
 TVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146175; x=1778750975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jS/SllfmTaIblcuVWtKnhxrxuILJS7maGolHIWZMfjI=;
 b=Ov1YLDxVpd+56zxcBeOi0Ttg3tm6DyjC9nRQFD2/+T0jO9xZwyem5MEFR11Za2mn66
 zFcT/Xfm6hzHKKf+gxmpwnox4TSA4noSAWekNs1BhpGcLmm/i+4XY3jP+cp+PxublL8e
 6l5UlEVBZmyeAhBX4I1K7ydtvEMACvQL8cBdJI6+Q4IvA84/AsucxLIpG5bT5zh3vWSc
 72UNYrmaEqb1FQX0rkv0vysz0i/JS9NTm7PTn+sIMMFSAdNJ79pICP2KrLDXYk49uG+I
 lYLZeNr2XIcVw9yNxNCGCP6nDlAFk83t0+qYQtSUV0rd892GFLP2G7hXZjB6SmooZ3GP
 EW6A==
X-Gm-Message-State: AOJu0Yww1dFdwNnJAHPkeGX6R4Kmduu/eP3j75oBXLARfeb0Hk5jWZ4h
 EHrkKG2rSVBAaRQ3/BjUr8j6hcA70cLHcMmJjS8awEQzafljW/gnCIOWLtxs5pO5b1gdt85K+uK
 8oCwD8n7D8g==
X-Gm-Gg: AeBDieumjutVjgR+mYbcijiEZ0Kj6QP1htMGf6Dsr9OnApoMwilnHZi3132uNEPjcCX
 GPd1Y/59VFeSdnB5Pe9Lagksp8yiLx93I9q7rJXI9IjQuUsLryXUkSuZfnpULuW7QZ1LiofoOG5
 pL3Joq8EPtMTTtdJNvpw5aiYhxp8HFHhoG1an88vCEWAhvaA8110KmPczu4BV0IPT+JHkAGUWtc
 irOKuYhPU0UZJrou7xxu8s+rXspSywLT9N3Er5ZEfZIZIlJ2uUlsKkdh/kLSuf8AB50ffqotod7
 uRyLzk+1E/hLKImWHg8aE7vvWMrlGMd5guFTsdvTUdrpMlLfTf6uUOsiykmXbmjricAzJQpHnyW
 I//M8os8bt5K2cIN6+lXQd4rfEcnZQItpfc2Zd4XokKWBBOzJAh4N4vjcsK6JR7aUPbzq6/SKDv
 O+3kYMuhZmP50AnvqUWuNHdyfFQiKE1w5Jv6ZdLS5kEudtFYYee6l4fCwBhnhCksfEbxocihpSw
 VtB06hxLEvE+5ANNBoMkD0CnUQi6a+bmoUVx6b6Fg==
X-Received: by 2002:a05:6512:234f:b0:5a3:d375:f587 with SMTP id
 2adb3069b0e04-5a887ceb2e9mr2851263e87.35.1778146175088; 
 Thu, 07 May 2026 02:29:35 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:33 -0700 (PDT)
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
Subject: [RFC PATCH v2 16/64] usb: dwc3: import from kernel v4.13
Date: Thu,  7 May 2026 11:27:23 +0200
Message-ID: <20260507092843.358908-17-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.12 to v4.13.

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

List of commits: git log --oneline v4.12..v4.13
Commits imported:
40d829fb2ec6 usb: dwc3: gadget: Correct ISOC DATA PIDs for short packets
4a71fcb8ac5f usb: dwc3: gadget: only unmap requests from DMA if mapped
ee249b455494 usb: dwc3: omap: remove IRQ_NOAUTOEN used with shared irq
541768b08a40 usb: dwc3: core: Call dwc3_core_get_phy() before initializing phys
408c9861c697 Merge tag 'pm-4.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
362f6729cbb1 Merge tag 'usb-4.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
de3ef1eb1cd0 PM / core: Drop run_wake flag from struct dev_pm_info
24040a58379e Merge tag 'usb-for-v4.13' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-testing
ece7af5f787e usb: dwc3: exynos: Handle return value of clk_prepare_enable
46b780d46bcc usb: dwc3: gadget: increase readability of dwc3_gadget_init_endpoints()
958d1a4c40dd usb: dwc3: core: program PHY for proper DRD modes
f54edb539c11 usb: dwc3: core: initialize ULPI before trying to get the PHY
e0082698b689 usb: dwc3: ulpi: conditionally resume ULPI PHY
9b0a1f95c4b4 usb: dwc3: ep0: make sure wValue is 0 on GetStatus()
7d8d0639565f usb: dwc3: gadget: implement ->udc_set_speed()
94116f8126de ACPI: Switch to use generic guid_t in acpi_evaluate_dsm()
af32423a2d86 usb: dwc3: trace: decode ctrl request
3587f36a125f usb: dwc3: debug: remove static char buffer from dwc3_decode_event()
e42f09b85f20 usb: dwc3: trace: rely on __string() and __assign_str()
dfc5e80578f2 usb: dwc3: gadget: slight cleanup to dwc3_process_event_entry()
436841d53dd7 usb: dwc3: debugfs: slightly improve output of trb_ring
bfad65ee9be2 usb: dwc3: update documentation
04fb365c453e usb: dwc3: replace %p with %pK
6acf116c9558 Merge 4.12-rc2 into usb-next
65db7a0c9816 usb: dwc3: add disable u2mac linestate check quirk
cdb55b39fab8 usb: dwc3: gadget: lazily map requests for DMA
202adafe5a6e usb: dwc3: gadget: don't WARN about lack of TRBs

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c   |  57 +++++--
 drivers/usb/dwc3/core.h   |  48 +++---
 drivers/usb/dwc3/debug.h  | 247 ++++++++++++++++++++++++++-
 drivers/usb/dwc3/ep0.c    |   8 +-
 drivers/usb/dwc3/gadget.c | 340 +++++++++++++++++++++++---------------
 drivers/usb/dwc3/gadget.h |  22 ++-
 6 files changed, 549 insertions(+), 173 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 455d89a1cd6d..03474d3575ab 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -151,11 +151,24 @@ static void __dwc3_set_mode(struct work_struct *work)
 	switch (dwc->desired_dr_role) {
 	case DWC3_GCTL_PRTCAP_HOST:
 		ret = dwc3_host_init(dwc);
-		if (ret)
+		if (ret) {
 			dev_err(dwc->dev, "failed to initialize host\n");
+		} else {
+			if (dwc->usb2_phy)
+				otg_set_vbus(dwc->usb2_phy->otg, true);
+			if (dwc->usb2_generic_phy)
+				phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
+
+		}
 		break;
 	case DWC3_GCTL_PRTCAP_DEVICE:
 		dwc3_event_buffers_setup(dwc);
+
+		if (dwc->usb2_phy)
+			otg_set_vbus(dwc->usb2_phy->otg, false);
+		if (dwc->usb2_generic_phy)
+			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
+
 		ret = dwc3_gadget_init(dwc);
 		if (ret)
 			dev_err(dwc->dev, "failed to initialize peripheral\n");
@@ -721,6 +734,8 @@ static void dwc3_core_setup_global_control(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 }
 
+static int dwc3_core_get_phy(struct dwc3 *dwc);
+
 /**
  * dwc3_core_init - Low-level initialization of DWC3 Core
  * @dwc: Pointer to our controller context structure
@@ -751,6 +766,10 @@ static int dwc3_core_init(struct dwc3 *dwc)
 			dwc->maximum_speed = USB_SPEED_HIGH;
 	}
 
+	ret = dwc3_core_get_phy(dwc);
+	if (ret)
+		goto err0;
+
 	ret = dwc3_core_soft_reset(dwc);
 	if (ret)
 		goto err0;
@@ -796,13 +815,19 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_GUCTL2, reg);
 	}
 
-	/*
-	 * Enable hardware control of sending remote wakeup in HS when
-	 * the device is in the L1 state.
-	 */
-	if (dwc->revision >= DWC3_REVISION_290A) {
+	if (dwc->revision >= DWC3_REVISION_250A) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUCTL1);
-		reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
+
+		/*
+		 * Enable hardware control of sending remote wakeup
+		 * in HS when the device is in the L1 state.
+		 */
+		if (dwc->revision >= DWC3_REVISION_290A)
+			reg |= DWC3_GUCTL1_DEV_L1_EXIT_BY_HW;
+
+		if (dwc->dis_tx_ipgap_linecheck_quirk)
+			reg |= DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS;
+
 		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
 	}
 
@@ -903,6 +928,12 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+
+		if (dwc->usb2_phy)
+			otg_set_vbus(dwc->usb2_phy->otg, false);
+		if (dwc->usb2_generic_phy)
+			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_DEVICE);
+
 		ret = dwc3_gadget_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
@@ -912,6 +943,12 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		break;
 	case USB_DR_MODE_HOST:
 		dwc3_set_prtcap(dwc, DWC3_GCTL_PRTCAP_HOST);
+
+		if (dwc->usb2_phy)
+			otg_set_vbus(dwc->usb2_phy->otg, true);
+		if (dwc->usb2_generic_phy)
+			phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
+
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
@@ -1023,6 +1060,8 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-u2-freeclk-exists-quirk");
 	dwc->dis_del_phy_power_chg_quirk = device_property_read_bool(dev,
 				"snps,dis-del-phy-power-chg-quirk");
+	dwc->dis_tx_ipgap_linecheck_quirk = device_property_read_bool(dev,
+				"snps,dis-tx-ipgap-linecheck-quirk");
 
 	dwc->tx_de_emphasis_quirk = device_property_read_bool(dev,
 				"snps,tx_de_emphasis_quirk");
@@ -1148,10 +1187,6 @@ static int dwc3_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dwc);
 	dwc3_cache_hwparams(dwc);
 
-	ret = dwc3_core_get_phy(dwc);
-	if (ret)
-		goto err0;
-
 	spin_lock_init(&dwc->lock);
 
 	pm_runtime_set_active(dev);
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 981c77f5628e..ea910acb4bb0 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1,4 +1,4 @@
-/**
+/*
  * core.h - DesignWare USB3 DRD Core Header
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
@@ -204,6 +204,7 @@
 #define DWC3_GCTL_DSBLCLKGTNG		BIT(0)
 
 /* Global User Control 1 Register */
+#define DWC3_GUCTL1_TX_IPGAP_LINECHECK_DIS	BIT(28)
 #define DWC3_GUCTL1_DEV_L1_EXIT_BY_HW	BIT(24)
 
 /* Global USB2 PHY Configuration Register */
@@ -522,7 +523,6 @@ struct dwc3_event_buffer {
  * @trb_pool_dma: dma address of @trb_pool
  * @trb_enqueue: enqueue 'pointer' into TRB array
  * @trb_dequeue: dequeue 'pointer' into TRB array
- * @desc: usb_endpoint_descriptor pointer
  * @dwc: pointer to DWC controller
  * @saved_state: ep state saved during hibernation
  * @flags: endpoint flags (wedged, stalled, ...)
@@ -664,7 +664,7 @@ enum dwc3_link_state {
  * @bpl: DW0-3
  * @bph: DW4-7
  * @size: DW8-B
- * @trl: DWC-F
+ * @ctrl: DWC-F
  */
 struct dwc3_trb {
 	u32		bpl;
@@ -674,16 +674,16 @@ struct dwc3_trb {
 } __packed;
 
 /**
- * dwc3_hwparams - copy of HWPARAMS registers
- * @hwparams0 - GHWPARAMS0
- * @hwparams1 - GHWPARAMS1
- * @hwparams2 - GHWPARAMS2
- * @hwparams3 - GHWPARAMS3
- * @hwparams4 - GHWPARAMS4
- * @hwparams5 - GHWPARAMS5
- * @hwparams6 - GHWPARAMS6
- * @hwparams7 - GHWPARAMS7
- * @hwparams8 - GHWPARAMS8
+ * struct dwc3_hwparams - copy of HWPARAMS registers
+ * @hwparams0: GHWPARAMS0
+ * @hwparams1: GHWPARAMS1
+ * @hwparams2: GHWPARAMS2
+ * @hwparams3: GHWPARAMS3
+ * @hwparams4: GHWPARAMS4
+ * @hwparams5: GHWPARAMS5
+ * @hwparams6: GHWPARAMS6
+ * @hwparams7: GHWPARAMS7
+ * @hwparams8: GHWPARAMS8
  */
 struct dwc3_hwparams {
 	u32	hwparams0;
@@ -730,7 +730,8 @@ struct dwc3_hwparams {
  * @unaligned: true for OUT endpoints with length not divisible by maxp
  * @direction: IN or OUT direction flag
  * @mapped: true when request has been dma-mapped
- * @queued: true when request has been queued to HW
+ * @started: request is started
+ * @zero: wants a ZLP
  */
 struct dwc3_request {
 	struct usb_request	request;
@@ -761,17 +762,23 @@ struct dwc3_scratchpad_array {
 
 /**
  * struct dwc3 - representation of our controller
- * @drd_work - workqueue used for role swapping
+ * @drd_work: workqueue used for role swapping
  * @ep0_trb: trb which is used for the ctrl_req
+ * @bounce: address of bounce buffer
+ * @scratchbuf: address of scratch buffer
  * @setup_buf: used while precessing STD USB requests
- * @ep0_trb: dma address of ep0_trb
+ * @ep0_trb_addr: dma address of @ep0_trb
+ * @bounce_addr: dma address of @bounce
  * @ep0_usb_req: dummy req used while handling STD USB requests
  * @scratch_addr: dma address of scratchbuf
  * @ep0_in_setup: one control transfer is completed and enter setup phase
  * @lock: for synchronizing
  * @dev: pointer to our struct device
+ * @sysdev: pointer to the DMA-capable device
  * @xhci: pointer to our xHCI child
- * @event_buffer_list: a list of event buffers
+ * @xhci_resources: struct resources for our @xhci child
+ * @ev_buf: struct dwc3_event_buffer pointer
+ * @eps: endpoint array
  * @gadget: device side representation of the peripheral controller
  * @gadget_driver: pointer to the gadget driver
  * @regs: base address for our registers
@@ -795,8 +802,6 @@ struct dwc3_scratchpad_array {
  * @usb2_generic_phy: pointer to USB2 PHY
  * @usb3_generic_phy: pointer to USB3 PHY
  * @ulpi: pointer to ulpi interface
- * @dcfg: saved contents of DCFG register
- * @gctl: saved contents of GCTL register
  * @isoch_delay: wValue from Set Isochronous Delay request;
  * @u2sel: parameter from Set SEL request.
  * @u2pel: parameter from Set SEL request.
@@ -830,7 +835,6 @@ struct dwc3_scratchpad_array {
  * @pending_events: true when we have pending IRQs to be handled
  * @pullups_connected: true when Run/Stop bit is set
  * @setup_packet_pending: true when there's a Setup Packet in FIFO. Workaround
- * @start_config_issued: true when StartConfig command has been issued
  * @three_stage_setup: set if we perform a three phase setup
  * @usb3_lpm_capable: set if hadrware supports Link Power Management
  * @disable_scramble_quirk: set if we enable the disable scramble quirk
@@ -845,11 +849,14 @@ struct dwc3_scratchpad_array {
  * @dis_u2_susphy_quirk: set if we disable usb2 suspend phy
  * @dis_enblslpm_quirk: set if we clear enblslpm in GUSB2PHYCFG,
  *                      disabling the suspend signal to the PHY.
+ * @dis_rxdet_inp3_quirk: set if we disable Rx.Detect in P3
  * @dis_u2_freeclk_exists_quirk : set if we clear u2_freeclk_exists
  *			in GUSB2PHYCFG, specify that USB2 PHY doesn't
  *			provide a free-running PHY clock.
  * @dis_del_phy_power_chg_quirk: set if we disable delay phy power
  *			change quirk.
+ * @dis_tx_ipgap_linecheck_quirk: set if we disable u2mac linestate
+ *			check during HS transmit.
  * @tx_de_emphasis_quirk: set if we enable Tx de-emphasis quirk
  * @tx_de_emphasis: Tx de-emphasis value
  * 	0	- -6dB de-emphasis
@@ -1004,6 +1011,7 @@ struct dwc3 {
 	unsigned		dis_rxdet_inp3_quirk:1;
 	unsigned		dis_u2_freeclk_exists_quirk:1;
 	unsigned		dis_del_phy_power_chg_quirk:1;
+	unsigned		dis_tx_ipgap_linecheck_quirk:1;
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index cb2d8d3f7f3d..5e9c070ec874 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -173,9 +173,8 @@ static inline const char *dwc3_ep0_state_string(enum dwc3_ep0_state state)
  * @event: the event code
  */
 static inline const char *
-dwc3_gadget_event_string(const struct dwc3_event_devt *event)
+dwc3_gadget_event_string(char *str, const struct dwc3_event_devt *event)
 {
-	static char str[256];
 	enum dwc3_link_state state = event->event_info & DWC3_LINK_STATE_MASK;
 
 	switch (event->type) {
@@ -223,15 +222,249 @@ dwc3_gadget_event_string(const struct dwc3_event_devt *event)
 	return str;
 }
 
+static inline void dwc3_decode_get_status(__u8 t, __u16 i, __u16 l, char *str)
+{
+	switch (t & USB_RECIP_MASK) {
+	case USB_RECIP_INTERFACE:
+		sprintf(str, "Get Interface Status(Intf = %d, Length = %d)",
+			i, l);
+		break;
+	case USB_RECIP_ENDPOINT:
+		sprintf(str, "Get Endpoint Status(ep%d%s)",
+			i & ~USB_DIR_IN,
+			i & USB_DIR_IN ? "in" : "out");
+		break;
+	}
+}
+
+static inline void dwc3_decode_set_clear_feature(__u8 t, __u8 b, __u16 v,
+						 __u16 i, char *str)
+{
+	switch (t & USB_RECIP_MASK) {
+	case USB_RECIP_DEVICE:
+		sprintf(str, "%s Device Feature(%s%s)",
+			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
+			({char *s;
+				switch (v) {
+				case USB_DEVICE_SELF_POWERED:
+					s = "Self Powered";
+					break;
+				case USB_DEVICE_REMOTE_WAKEUP:
+					s = "Remote Wakeup";
+					break;
+				case USB_DEVICE_TEST_MODE:
+					s = "Test Mode";
+					break;
+				default:
+					s = "UNKNOWN";
+				} s; }),
+			v == USB_DEVICE_TEST_MODE ?
+			({ char *s;
+				switch (i) {
+				case TEST_J:
+					s = ": TEST_J";
+					break;
+				case TEST_K:
+					s = ": TEST_K";
+					break;
+				case TEST_SE0_NAK:
+					s = ": TEST_SE0_NAK";
+					break;
+				case TEST_PACKET:
+					s = ": TEST_PACKET";
+					break;
+				case TEST_FORCE_EN:
+					s = ": TEST_FORCE_EN";
+					break;
+				default:
+					s = ": UNKNOWN";
+				} s; }) : "");
+		break;
+	case USB_RECIP_INTERFACE:
+		sprintf(str, "%s Interface Feature(%s)",
+			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
+			v == USB_INTRF_FUNC_SUSPEND ?
+			"Function Suspend" : "UNKNOWN");
+		break;
+	case USB_RECIP_ENDPOINT:
+		sprintf(str, "%s Endpoint Feature(%s ep%d%s)",
+			b == USB_REQ_CLEAR_FEATURE ? "Clear" : "Set",
+			v == USB_ENDPOINT_HALT ? "Halt" : "UNKNOWN",
+			i & ~USB_DIR_IN,
+			i & USB_DIR_IN ? "in" : "out");
+		break;
+	}
+}
+
+static inline void dwc3_decode_set_address(__u16 v, char *str)
+{
+	sprintf(str, "Set Address(Addr = %02x)", v);
+}
+
+static inline void dwc3_decode_get_set_descriptor(__u8 t, __u8 b, __u16 v,
+						  __u16 i, __u16 l, char *str)
+{
+	sprintf(str, "%s %s Descriptor(Index = %d, Length = %d)",
+		b == USB_REQ_GET_DESCRIPTOR ? "Get" : "Set",
+		({ char *s;
+			switch (v >> 8) {
+			case USB_DT_DEVICE:
+				s = "Device";
+				break;
+			case USB_DT_CONFIG:
+				s = "Configuration";
+				break;
+			case USB_DT_STRING:
+				s = "String";
+				break;
+			case USB_DT_INTERFACE:
+				s = "Interface";
+				break;
+			case USB_DT_ENDPOINT:
+				s = "Endpoint";
+				break;
+			case USB_DT_DEVICE_QUALIFIER:
+				s = "Device Qualifier";
+				break;
+			case USB_DT_OTHER_SPEED_CONFIG:
+				s = "Other Speed Config";
+				break;
+			case USB_DT_INTERFACE_POWER:
+				s = "Interface Power";
+				break;
+			case USB_DT_OTG:
+				s = "OTG";
+				break;
+			case USB_DT_DEBUG:
+				s = "Debug";
+				break;
+			case USB_DT_INTERFACE_ASSOCIATION:
+				s = "Interface Association";
+				break;
+			case USB_DT_BOS:
+				s = "BOS";
+				break;
+			case USB_DT_DEVICE_CAPABILITY:
+				s = "Device Capability";
+				break;
+			case USB_DT_PIPE_USAGE:
+				s = "Pipe Usage";
+				break;
+			case USB_DT_SS_ENDPOINT_COMP:
+				s = "SS Endpoint Companion";
+				break;
+			case USB_DT_SSP_ISOC_ENDPOINT_COMP:
+				s = "SSP Isochronous Endpoint Companion";
+				break;
+			default:
+				s = "UNKNOWN";
+				break;
+			} s; }), v & 0xff, l);
+}
+
+
+static inline void dwc3_decode_get_configuration(__u16 l, char *str)
+{
+	sprintf(str, "Get Configuration(Length = %d)", l);
+}
+
+static inline void dwc3_decode_set_configuration(__u8 v, char *str)
+{
+	sprintf(str, "Set Configuration(Config = %d)", v);
+}
+
+static inline void dwc3_decode_get_intf(__u16 i, __u16 l, char *str)
+{
+	sprintf(str, "Get Interface(Intf = %d, Length = %d)", i, l);
+}
+
+static inline void dwc3_decode_set_intf(__u8 v, __u16 i, char *str)
+{
+	sprintf(str, "Set Interface(Intf = %d, Alt.Setting = %d)", i, v);
+}
+
+static inline void dwc3_decode_synch_frame(__u16 i, __u16 l, char *str)
+{
+	sprintf(str, "Synch Frame(Endpoint = %d, Length = %d)", i, l);
+}
+
+static inline void dwc3_decode_set_sel(__u16 l, char *str)
+{
+	sprintf(str, "Set SEL(Length = %d)", l);
+}
+
+static inline void dwc3_decode_set_isoch_delay(__u8 v, char *str)
+{
+	sprintf(str, "Set Isochronous Delay(Delay = %d ns)", v);
+}
+
+/**
+ * dwc3_decode_ctrl - returns a string represetion of ctrl request
+ */
+static inline const char *dwc3_decode_ctrl(char *str, __u8 bRequestType,
+		__u8 bRequest, __u16 wValue, __u16 wIndex, __u16 wLength)
+{
+	switch (bRequest) {
+	case USB_REQ_GET_STATUS:
+		dwc3_decode_get_status(bRequestType, wIndex, wLength, str);
+		break;
+	case USB_REQ_CLEAR_FEATURE:
+	case USB_REQ_SET_FEATURE:
+		dwc3_decode_set_clear_feature(bRequestType, bRequest, wValue,
+					      wIndex, str);
+		break;
+	case USB_REQ_SET_ADDRESS:
+		dwc3_decode_set_address(wValue, str);
+		break;
+	case USB_REQ_GET_DESCRIPTOR:
+	case USB_REQ_SET_DESCRIPTOR:
+		dwc3_decode_get_set_descriptor(bRequestType, bRequest, wValue,
+					       wIndex, wLength, str);
+		break;
+	case USB_REQ_GET_CONFIGURATION:
+		dwc3_decode_get_configuration(wLength, str);
+		break;
+	case USB_REQ_SET_CONFIGURATION:
+		dwc3_decode_set_configuration(wValue, str);
+		break;
+	case USB_REQ_GET_INTERFACE:
+		dwc3_decode_get_intf(wIndex, wLength, str);
+		break;
+	case USB_REQ_SET_INTERFACE:
+		dwc3_decode_set_intf(wValue, wIndex, str);
+		break;
+	case USB_REQ_SYNCH_FRAME:
+		dwc3_decode_synch_frame(wIndex, wLength, str);
+		break;
+	case USB_REQ_SET_SEL:
+		dwc3_decode_set_sel(wLength, str);
+		break;
+	case USB_REQ_SET_ISOCH_DELAY:
+		dwc3_decode_set_isoch_delay(wValue, str);
+		break;
+	default:
+		sprintf(str, "%02x %02x %02x %02x %02x %02x %02x %02x",
+			bRequestType, bRequest,
+			cpu_to_le16(wValue) & 0xff,
+			cpu_to_le16(wValue) >> 8,
+			cpu_to_le16(wIndex) & 0xff,
+			cpu_to_le16(wIndex) >> 8,
+			cpu_to_le16(wLength) & 0xff,
+			cpu_to_le16(wLength) >> 8);
+	}
+
+	return str;
+}
+
 /**
  * dwc3_ep_event_string - returns event name
  * @event: then event code
  */
 static inline const char *
-dwc3_ep_event_string(const struct dwc3_event_depevt *event, u32 ep0state)
+dwc3_ep_event_string(char *str, const struct dwc3_event_depevt *event,
+		     u32 ep0state)
 {
 	u8 epnum = event->endpoint_number;
-	static char str[256];
 	size_t len;
 	int status;
 	int ret;
@@ -332,14 +565,14 @@ static inline const char *dwc3_gadget_event_type_string(u8 event)
 	}
 }
 
-static inline const char *dwc3_decode_event(u32 event, u32 ep0state)
+static inline const char *dwc3_decode_event(char *str, u32 event, u32 ep0state)
 {
 	const union dwc3_event evt = (union dwc3_event) event;
 
 	if (evt.type.is_devspec)
-		return dwc3_gadget_event_string(&evt.devt);
+		return dwc3_gadget_event_string(str, &evt.devt);
 	else
-		return dwc3_ep_event_string(&evt.depevt, ep0state);
+		return dwc3_ep_event_string(str, &evt.depevt, ep0state);
 }
 
 static inline const char *dwc3_ep_cmd_status_string(int status)
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index a78c78e7a8c3..827e376bfa97 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1,4 +1,4 @@
-/**
+/*
  * ep0.c - DesignWare USB3 DRD Controller Endpoint 0 Handling
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
@@ -319,10 +319,16 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 {
 	struct dwc3_ep		*dep;
 	u32			recip;
+	u32			value;
 	u32			reg;
 	u16			usb_status = 0;
 	__le16			*response_pkt;
 
+	/* We don't support PTM_STATUS */
+	value = le16_to_cpu(ctrl->wValue);
+	if (value != 0)
+		return -EINVAL;
+
 	recip = ctrl->bRequestType & USB_RECIP_MASK;
 	switch (recip) {
 	case USB_RECIP_DEVICE:
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index aea9a5b948b4..f064f1549333 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1,4 +1,4 @@
-/**
+/*
  * gadget.c - DesignWare USB3 DRD Controller Gadget Framework Link
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
@@ -36,13 +36,12 @@
 #include "io.h"
 
 /**
- * dwc3_gadget_set_test_mode - Enables USB2 Test Modes
+ * dwc3_gadget_set_test_mode - enables usb2 test modes
  * @dwc: pointer to our context structure
  * @mode: the mode to set (J, K SE0 NAK, Force Enable)
  *
- * Caller should take care of locking. This function will
- * return 0 on success or -EINVAL if wrong Test Selector
- * is passed
+ * Caller should take care of locking. This function will return 0 on
+ * success or -EINVAL if wrong Test Selector is passed.
  */
 int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode)
 {
@@ -69,7 +68,7 @@ int dwc3_gadget_set_test_mode(struct dwc3 *dwc, int mode)
 }
 
 /**
- * dwc3_gadget_get_link_state - Gets current state of USB Link
+ * dwc3_gadget_get_link_state - gets current state of usb link
  * @dwc: pointer to our context structure
  *
  * Caller should take care of locking. This function will
@@ -85,7 +84,7 @@ int dwc3_gadget_get_link_state(struct dwc3 *dwc)
 }
 
 /**
- * dwc3_gadget_set_link_state - Sets USB Link to a particular State
+ * dwc3_gadget_set_link_state - sets usb link to a particular state
  * @dwc: pointer to our context structure
  * @state: the state to put link into
  *
@@ -143,8 +142,8 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state)
 }
 
 /**
- * dwc3_ep_inc_trb() - Increment a TRB index.
- * @index - Pointer to the TRB index to increment.
+ * dwc3_ep_inc_trb - increment a trb index.
+ * @index: Pointer to the TRB index to increment.
  *
  * The index should never point to the link TRB. After incrementing,
  * if it is point to the link TRB, wrap around to the beginning. The
@@ -157,16 +156,34 @@ static void dwc3_ep_inc_trb(u8 *index)
 		*index = 0;
 }
 
+/**
+ * dwc3_ep_inc_enq - increment endpoint's enqueue pointer
+ * @dep: The endpoint whose enqueue pointer we're incrementing
+ */
 static void dwc3_ep_inc_enq(struct dwc3_ep *dep)
 {
 	dwc3_ep_inc_trb(&dep->trb_enqueue);
 }
 
+/**
+ * dwc3_ep_inc_deq - increment endpoint's dequeue pointer
+ * @dep: The endpoint whose enqueue pointer we're incrementing
+ */
 static void dwc3_ep_inc_deq(struct dwc3_ep *dep)
 {
 	dwc3_ep_inc_trb(&dep->trb_dequeue);
 }
 
+/**
+ * dwc3_gadget_giveback - call struct usb_request's ->complete callback
+ * @dep: The endpoint to whom the request belongs to
+ * @req: The request we're giving back
+ * @status: completion code for the request
+ *
+ * Must be called with controller's lock held and interrupts disabled. This
+ * function will unmap @req and call its ->complete() callback to notify upper
+ * layers that it has completed.
+ */
 void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status)
 {
@@ -174,14 +191,16 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 
 	req->started = false;
 	list_del(&req->list);
-	req->trb = NULL;
 	req->remaining = 0;
 
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
 
-	usb_gadget_unmap_request_by_dev(dwc->sysdev,
-					&req->request, req->direction);
+	if (req->trb)
+		usb_gadget_unmap_request_by_dev(dwc->sysdev,
+						&req->request, req->direction);
+
+	req->trb = NULL;
 
 	trace_dwc3_gadget_giveback(req);
 
@@ -193,6 +212,15 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		pm_runtime_put(dwc->dev);
 }
 
+/**
+ * dwc3_send_gadget_generic_command - issue a generic command for the controller
+ * @dwc: pointer to the controller context
+ * @cmd: the command to be issued
+ * @param: command parameter
+ *
+ * Caller should take care of locking. Issue @cmd with a given @param to @dwc
+ * and wait for its completion.
+ */
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 {
 	u32		timeout = 500;
@@ -225,6 +253,15 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 
 static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
 
+/**
+ * dwc3_send_gadget_ep_cmd - issue an endpoint command
+ * @dep: the endpoint to which the command is going to be issued
+ * @cmd: the command to be issued
+ * @params: parameters to the command
+ *
+ * Caller should handle locking. This function will issue @cmd with given
+ * @params to @dep and wait for its completion.
+ */
 int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 		struct dwc3_gadget_ep_cmd_params *params)
 {
@@ -422,36 +459,38 @@ static void dwc3_free_trb_pool(struct dwc3_ep *dep)
 static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3_ep *dep);
 
 /**
- * dwc3_gadget_start_config - Configure EP resources
+ * dwc3_gadget_start_config - configure ep resources
  * @dwc: pointer to our controller context structure
  * @dep: endpoint that is being enabled
  *
- * The assignment of transfer resources cannot perfectly follow the
- * data book due to the fact that the controller driver does not have
- * all knowledge of the configuration in advance. It is given this
- * information piecemeal by the composite gadget framework after every
- * SET_CONFIGURATION and SET_INTERFACE. Trying to follow the databook
- * programming model in this scenario can cause errors. For two
- * reasons:
+ * Issue a %DWC3_DEPCMD_DEPSTARTCFG command to @dep. After the command's
+ * completion, it will set Transfer Resource for all available endpoints.
+ *
+ * The assignment of transfer resources cannot perfectly follow the data book
+ * due to the fact that the controller driver does not have all knowledge of the
+ * configuration in advance. It is given this information piecemeal by the
+ * composite gadget framework after every SET_CONFIGURATION and
+ * SET_INTERFACE. Trying to follow the databook programming model in this
+ * scenario can cause errors. For two reasons:
  *
- * 1) The databook says to do DEPSTARTCFG for every SET_CONFIGURATION
- * and SET_INTERFACE (8.1.5). This is incorrect in the scenario of
- * multiple interfaces.
+ * 1) The databook says to do %DWC3_DEPCMD_DEPSTARTCFG for every
+ * %USB_REQ_SET_CONFIGURATION and %USB_REQ_SET_INTERFACE (8.1.5). This is
+ * incorrect in the scenario of multiple interfaces.
  *
- * 2) The databook does not mention doing more DEPXFERCFG for new
+ * 2) The databook does not mention doing more %DWC3_DEPCMD_DEPXFERCFG for new
  * endpoint on alt setting (8.1.6).
  *
  * The following simplified method is used instead:
  *
- * All hardware endpoints can be assigned a transfer resource and this
- * setting will stay persistent until either a core reset or
- * hibernation. So whenever we do a DEPSTARTCFG(0) we can go ahead and
- * do DEPXFERCFG for every hardware endpoint as well. We are
+ * All hardware endpoints can be assigned a transfer resource and this setting
+ * will stay persistent until either a core reset or hibernation. So whenever we
+ * do a %DWC3_DEPCMD_DEPSTARTCFG(0) we can go ahead and do
+ * %DWC3_DEPCMD_DEPXFERCFG for every hardware endpoint as well. We are
  * guaranteed that there are as many transfer resources as endpoints.
  *
- * This function is called for each endpoint when it is being enabled
- * but is triggered only when called for EP0-out, which always happens
- * first, and which should only happen in one of the above conditions.
+ * This function is called for each endpoint when it is being enabled but is
+ * triggered only when called for EP0-out, which always happens first, and which
+ * should only happen in one of the above conditions.
  */
 static int dwc3_gadget_start_config(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
@@ -569,11 +608,13 @@ static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3_ep *dep)
 }
 
 /**
- * __dwc3_gadget_ep_enable - Initializes a HW endpoint
+ * __dwc3_gadget_ep_enable - initializes a hw endpoint
  * @dep: endpoint to be initialized
- * @desc: USB Endpoint Descriptor
+ * @modify: if true, modify existing endpoint configuration
+ * @restore: if true, restore endpoint configuration from scratch buffer
  *
- * Caller should take care of locking
+ * Caller should take care of locking. Execute all necessary commands to
+ * initialize a HW endpoint so it can be used by a gadget driver.
  */
 static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		bool modify, bool restore)
@@ -685,11 +726,13 @@ static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep)
 }
 
 /**
- * __dwc3_gadget_ep_disable - Disables a HW endpoint
+ * __dwc3_gadget_ep_disable - disables a hw endpoint
  * @dep: the endpoint to disable
  *
- * This function also removes requests which are currently processed ny the
- * hardware and those which are not yet scheduled.
+ * This function undoes what __dwc3_gadget_ep_enable did and also removes
+ * requests which are currently being processed by the hardware and those which
+ * are not yet scheduled.
+ *
  * Caller should take care of locking.
  */
 static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
@@ -853,9 +896,40 @@ static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
 		if (!node) {
 			trb->ctrl = DWC3_TRBCTL_ISOCHRONOUS_FIRST;
 
+			/*
+			 * USB Specification 2.0 Section 5.9.2 states that: "If
+			 * there is only a single transaction in the microframe,
+			 * only a DATA0 data packet PID is used.  If there are
+			 * two transactions per microframe, DATA1 is used for
+			 * the first transaction data packet and DATA0 is used
+			 * for the second transaction data packet.  If there are
+			 * three transactions per microframe, DATA2 is used for
+			 * the first transaction data packet, DATA1 is used for
+			 * the second, and DATA0 is used for the third."
+			 *
+			 * IOW, we should satisfy the following cases:
+			 *
+			 * 1) length <= maxpacket
+			 *	- DATA0
+			 *
+			 * 2) maxpacket < length <= (2 * maxpacket)
+			 *	- DATA1, DATA0
+			 *
+			 * 3) (2 * maxpacket) < length <= (3 * maxpacket)
+			 *	- DATA2, DATA1, DATA0
+			 */
 			if (speed == USB_SPEED_HIGH) {
 				struct usb_ep *ep = &dep->endpoint;
-				trb->size |= DWC3_TRB_SIZE_PCM1(ep->mult - 1);
+				unsigned int mult = ep->mult - 1;
+				unsigned int maxp = usb_endpoint_maxp(ep->desc);
+
+				if (length <= (2 * maxp))
+					mult--;
+
+				if (length <= maxp)
+					mult--;
+
+				trb->size |= DWC3_TRB_SIZE_PCM1(mult);
 			}
 		} else {
 			trb->ctrl = DWC3_TRBCTL_ISOCHRONOUS;
@@ -932,7 +1006,7 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 }
 
 /**
- * dwc3_ep_prev_trb() - Returns the previous TRB in the ring
+ * dwc3_ep_prev_trb - returns the previous TRB in the ring
  * @dep: The endpoint with the TRB ring
  * @index: The index of the current TRB in the ring
  *
@@ -953,7 +1027,6 @@ static struct dwc3_trb *dwc3_ep_prev_trb(struct dwc3_ep *dep, u8 index)
 static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 {
 	struct dwc3_trb		*tmp;
-	struct dwc3		*dwc = dep->dwc;
 	u8			trbs_left;
 
 	/*
@@ -965,8 +1038,7 @@ static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep)
 	 */
 	if (dep->trb_enqueue == dep->trb_dequeue) {
 		tmp = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
-		if (dev_WARN_ONCE(dwc->dev, tmp->ctrl & DWC3_TRB_CTRL_HWO,
-				  "%s No TRBS left\n", dep->name))
+		if (tmp->ctrl & DWC3_TRB_CTRL_HWO)
 			return 0;
 
 		return DWC3_TRB_NUM - 1;
@@ -1101,6 +1173,17 @@ static void dwc3_prepare_trbs(struct dwc3_ep *dep)
 	}
 
 	list_for_each_entry_safe(req, n, &dep->pending_list, list) {
+		struct dwc3	*dwc = dep->dwc;
+		int		ret;
+
+		ret = usb_gadget_map_request_by_dev(dwc->sysdev, &req->request,
+						    dep->direction);
+		if (ret)
+			return;
+
+		req->sg			= req->request.sg;
+		req->num_pending_sgs	= req->request.num_mapped_sgs;
+
 		if (req->num_pending_sgs > 0)
 			dwc3_prepare_one_trb_sg(dep, req);
 		else
@@ -1207,7 +1290,7 @@ static void dwc3_gadget_start_isoc(struct dwc3 *dwc,
 static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 {
 	struct dwc3		*dwc = dep->dwc;
-	int			ret;
+	int			ret = 0;
 
 	if (!dep->endpoint.desc) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
@@ -1215,12 +1298,9 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 		return -ESHUTDOWN;
 	}
 
-	if (WARN(req->dep != dep, "request %p belongs to '%s'\n",
-				&req->request, req->dep->name)) {
-		dev_err(dwc->dev, "%s: request %p belongs to '%s'\n",
-				dep->name, &req->request, req->dep->name);
+	if (WARN(req->dep != dep, "request %pK belongs to '%s'\n",
+				&req->request, req->dep->name))
 		return -EINVAL;
-	}
 
 	pm_runtime_get(dwc->dev);
 
@@ -1231,14 +1311,6 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 
 	trace_dwc3_ep_queue(req);
 
-	ret = usb_gadget_map_request_by_dev(dwc->sysdev, &req->request,
-					    dep->direction);
-	if (ret)
-		return ret;
-
-	req->sg			= req->request.sg;
-	req->num_pending_sgs	= req->request.num_mapped_sgs;
-
 	list_add_tail(&req->list, &dep->pending_list);
 
 	/*
@@ -1396,7 +1468,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			}
 			goto out1;
 		}
-		dev_err(dwc->dev, "request %p was not queued to %s\n",
+		dev_err(dwc->dev, "request %pK was not queued to %s\n",
 				request, ep->name);
 		ret = -EINVAL;
 		goto out0;
@@ -1741,8 +1813,8 @@ static irqreturn_t dwc3_interrupt(int irq, void *_dwc);
 static irqreturn_t dwc3_thread_interrupt(int irq, void *_dwc);
 
 /**
- * dwc3_gadget_setup_nump - Calculate and initialize NUMP field of DCFG
- * dwc: pointer to our context structure
+ * dwc3_gadget_setup_nump - calculate and initialize NUMP field of %DWC3_DCFG
+ * @dwc: pointer to our context structure
  *
  * The following looks like complex but it's actually very simple. In order to
  * calculate the number of packets we can burst at once on OUT transfers, we're
@@ -1798,49 +1870,6 @@ static int __dwc3_gadget_start(struct dwc3 *dwc)
 		dwc3_writel(dwc->regs, DWC3_DEV_IMOD(0), 0);
 	}
 
-	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
-	reg &= ~(DWC3_DCFG_SPEED_MASK);
-
-	/**
-	 * WORKAROUND: DWC3 revision < 2.20a have an issue
-	 * which would cause metastability state on Run/Stop
-	 * bit if we try to force the IP to USB2-only mode.
-	 *
-	 * Because of that, we cannot configure the IP to any
-	 * speed other than the SuperSpeed
-	 *
-	 * Refers to:
-	 *
-	 * STAR#9000525659: Clock Domain Crossing on DCTL in
-	 * USB 2.0 Mode
-	 */
-	if (dwc->revision < DWC3_REVISION_220A) {
-		reg |= DWC3_DCFG_SUPERSPEED;
-	} else {
-		switch (dwc->maximum_speed) {
-		case USB_SPEED_LOW:
-			reg |= DWC3_DCFG_LOWSPEED;
-			break;
-		case USB_SPEED_FULL:
-			reg |= DWC3_DCFG_FULLSPEED;
-			break;
-		case USB_SPEED_HIGH:
-			reg |= DWC3_DCFG_HIGHSPEED;
-			break;
-		case USB_SPEED_SUPER_PLUS:
-			reg |= DWC3_DCFG_SUPERSPEED_PLUS;
-			break;
-		default:
-			dev_err(dwc->dev, "invalid dwc->maximum_speed (%d)\n",
-				dwc->maximum_speed);
-			/* fall through */
-		case USB_SPEED_SUPER:
-			reg |= DWC3_DCFG_SUPERSPEED;
-			break;
-		}
-	}
-	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
-
 	/*
 	 * We are telling dwc3 that we want to use DCFG.NUMP as ACK TP's NUMP
 	 * field instead of letting dwc3 itself calculate that automatically.
@@ -1972,6 +2001,63 @@ out:
 	return 0;
 }
 
+static void dwc3_gadget_set_speed(struct usb_gadget *g,
+				  enum usb_device_speed speed)
+{
+	struct dwc3		*dwc = gadget_to_dwc(g);
+	unsigned long		flags;
+	u32			reg;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
+	reg &= ~(DWC3_DCFG_SPEED_MASK);
+
+	/*
+	 * WORKAROUND: DWC3 revision < 2.20a have an issue
+	 * which would cause metastability state on Run/Stop
+	 * bit if we try to force the IP to USB2-only mode.
+	 *
+	 * Because of that, we cannot configure the IP to any
+	 * speed other than the SuperSpeed
+	 *
+	 * Refers to:
+	 *
+	 * STAR#9000525659: Clock Domain Crossing on DCTL in
+	 * USB 2.0 Mode
+	 */
+	if (dwc->revision < DWC3_REVISION_220A) {
+		reg |= DWC3_DCFG_SUPERSPEED;
+	} else {
+		switch (speed) {
+		case USB_SPEED_LOW:
+			reg |= DWC3_DCFG_LOWSPEED;
+			break;
+		case USB_SPEED_FULL:
+			reg |= DWC3_DCFG_FULLSPEED;
+			break;
+		case USB_SPEED_HIGH:
+			reg |= DWC3_DCFG_HIGHSPEED;
+			break;
+		case USB_SPEED_SUPER:
+			reg |= DWC3_DCFG_SUPERSPEED;
+			break;
+		case USB_SPEED_SUPER_PLUS:
+			reg |= DWC3_DCFG_SUPERSPEED_PLUS;
+			break;
+		default:
+			dev_err(dwc->dev, "invalid speed (%d)\n", speed);
+
+			if (dwc->revision & DWC3_REVISION_IS_DWC31)
+				reg |= DWC3_DCFG_SUPERSPEED_PLUS;
+			else
+				reg |= DWC3_DCFG_SUPERSPEED;
+		}
+	}
+	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.get_frame		= dwc3_gadget_get_frame,
 	.wakeup			= dwc3_gadget_wakeup,
@@ -1979,19 +2065,21 @@ static const struct usb_gadget_ops dwc3_gadget_ops = {
 	.pullup			= dwc3_gadget_pullup,
 	.udc_start		= dwc3_gadget_start,
 	.udc_stop		= dwc3_gadget_stop,
+	.udc_set_speed		= dwc3_gadget_set_speed,
 };
 
 /* -------------------------------------------------------------------------- */
 
-static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 num)
+static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 total)
 {
 	struct dwc3_ep			*dep;
 	u8				epnum;
 
 	INIT_LIST_HEAD(&dwc->gadget.ep_list);
 
-	for (epnum = 0; epnum < num; epnum++) {
+	for (epnum = 0; epnum < total; epnum++) {
 		bool			direction = epnum & 1;
+		u8			num = epnum >> 1;
 
 		dep = kzalloc(sizeof(*dep), GFP_KERNEL);
 		if (!dep)
@@ -2003,7 +2091,7 @@ static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 num)
 		dep->regs = dwc->regs + DWC3_DEP_BASE(epnum);
 		dwc->eps[epnum] = dep;
 
-		snprintf(dep->name, sizeof(dep->name), "ep%d%s", epnum >> 1,
+		snprintf(dep->name, sizeof(dep->name), "ep%u%s", num,
 				direction ? "in" : "out");
 
 		dep->endpoint.name = dep->name;
@@ -2015,39 +2103,39 @@ static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 num)
 
 		spin_lock_init(&dep->lock);
 
-		if (epnum == 0 || epnum == 1) {
+		if (num == 0) {
 			usb_ep_set_maxpacket_limit(&dep->endpoint, 512);
 			dep->endpoint.maxburst = 1;
 			dep->endpoint.ops = &dwc3_gadget_ep0_ops;
-			if (!epnum)
+			if (!direction)
 				dwc->gadget.ep0 = &dep->endpoint;
 		} else if (direction) {
 			int mdwidth;
+			int kbytes;
 			int size;
 			int ret;
-			int num;
 
 			mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
 			/* MDWIDTH is represented in bits, we need it in bytes */
 			mdwidth /= 8;
 
-			size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(epnum >> 1));
+			size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(num));
 			size = DWC3_GTXFIFOSIZ_TXFDEF(size);
 
 			/* FIFO Depth is in MDWDITH bytes. Multiply */
 			size *= mdwidth;
 
-			num = size / 1024;
-			if (num == 0)
-				num = 1;
+			kbytes = size / 1024;
+			if (kbytes == 0)
+				kbytes = 1;
 
 			/*
-			 * FIFO sizes account an extra MDWIDTH * (num + 1) bytes for
+			 * FIFO sizes account an extra MDWIDTH * (kbytes + 1) bytes for
 			 * internal overhead. We don't really know how these are used,
 			 * but documentation say it exists.
 			 */
-			size -= mdwidth * (num + 1);
-			size /= num;
+			size -= mdwidth * (kbytes + 1);
+			size /= kbytes;
 
 			usb_ep_set_maxpacket_limit(&dep->endpoint, size);
 
@@ -2073,7 +2161,7 @@ static int dwc3_gadget_init_endpoints(struct dwc3 *dwc, u8 num)
 				return ret;
 		}
 
-		if (epnum == 0 || epnum == 1) {
+		if (num == 0) {
 			dep->endpoint.caps.type_control = true;
 		} else {
 			dep->endpoint.caps.type_iso = true;
@@ -2871,7 +2959,7 @@ static void dwc3_gadget_hibernation_interrupt(struct dwc3 *dwc,
 {
 	unsigned int is_ss = evtinfo & BIT(4);
 
-	/**
+	/*
 	 * WORKAROUND: DWC3 revison 2.20a with hibernation support
 	 * have a known issue which can cause USB CV TD.9.23 to fail
 	 * randomly.
@@ -2943,20 +3031,12 @@ static void dwc3_process_event_entry(struct dwc3 *dwc,
 {
 	trace_dwc3_event(event->raw, dwc);
 
-	/* Endpoint IRQ, handle it and return early */
-	if (event->type.is_devspec == 0) {
-		/* depevt */
-		return dwc3_endpoint_interrupt(dwc, &event->depevt);
-	}
-
-	switch (event->type.type) {
-	case DWC3_EVENT_TYPE_DEV:
+	if (!event->type.is_devspec)
+		dwc3_endpoint_interrupt(dwc, &event->depevt);
+	else if (event->type.type == DWC3_EVENT_TYPE_DEV)
 		dwc3_gadget_interrupt(dwc, &event->devt);
-		break;
-	/* REVISIT what to do with Carkit and I2C events ? */
-	default:
+	else
 		dev_err(dwc->dev, "UNKNOWN IRQ type %d\n", event->raw);
-	}
 }
 
 static irqreturn_t dwc3_process_event_buf(struct dwc3_event_buffer *evt)
@@ -3110,7 +3190,7 @@ out:
 }
 
 /**
- * dwc3_gadget_init - Initializes gadget related registers
+ * dwc3_gadget_init - initializes gadget related registers
  * @dwc: pointer to our controller context structure
  *
  * Returns 0 on success otherwise negative errno.
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index e4602d0e515b..4a3227543255 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -1,4 +1,4 @@
-/**
+/*
  * gadget.h - DesignWare USB3 DRD Gadget Header
  *
  * Copyright (C) 2010-2011 Texas Instruments Incorporated - http://www.ti.com
@@ -60,11 +60,25 @@ struct dwc3;
 
 #define to_dwc3_request(r)	(container_of(r, struct dwc3_request, request))
 
+/**
+ * next_request - gets the next request on the given list
+ * @list: the request list to operate on
+ *
+ * Caller should take care of locking. This function return %NULL or the first
+ * request available on @list.
+ */
 static inline struct dwc3_request *next_request(struct list_head *list)
 {
 	return list_first_entry_or_null(list, struct dwc3_request, list);
 }
 
+/**
+ * dwc3_gadget_move_started_request - move @req to the started_list
+ * @req: the request to be moved
+ *
+ * Caller should take care of locking. This function will move @req from its
+ * current list to the endpoint's started_list.
+ */
 static inline void dwc3_gadget_move_started_request(struct dwc3_request *req)
 {
 	struct dwc3_ep		*dep = req->dep;
@@ -87,10 +101,10 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol);
 
 /**
  * dwc3_gadget_ep_get_transfer_index - Gets transfer index from HW
- * @dwc: DesignWare USB3 Pointer
- * @number: DWC endpoint number
+ * @dep: dwc3 endpoint
  *
- * Caller should take care of locking
+ * Caller should take care of locking. Returns the transfer resource
+ * index for a given endpoint.
  */
 static inline u32 dwc3_gadget_ep_get_transfer_index(struct dwc3_ep *dep)
 {
-- 
2.43.0

