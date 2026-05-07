Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783B3CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:30:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 320E084A3E;
	Thu,  7 May 2026 11:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AaESpNYh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B278E84A66; Thu,  7 May 2026 11:29:17 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF02884A20
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5a742b8b72eso566901e87.1
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146152; x=1778750952; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w/sA0Uja68+u97125kStTt81bURPn/WgcQukBRk0Mms=;
 b=AaESpNYhReSxuMirzzzoQf68nzJP0qbdNvfyWlacISRH9hfoOk1QVtRzBxY+3W3A//
 WKSFVI8+uuLDeaPBqxExmZ8NBKXaeEoF8MGu/VX944WPs9rJl8SAvKE+fjl9A1vax3bZ
 UwSQ0GdgGPsyBxU+VZN328BFhkIjX2mxzTmUQTg73yhvzxf26wXHy/WDWcIgODGk70x2
 9oFipBy7a/4KEFfGjuJJZcc8vUVpLBmHSK3oBMUyGR+540gtCZ88iItJfNh45mk3Fd+R
 62BVEq4ZX62nuNpDJz0sbg7RIqbPBHAHoVXRNExByIbPoD6NDBAWI4SXd/vHGsBSf/w0
 T1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146152; x=1778750952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w/sA0Uja68+u97125kStTt81bURPn/WgcQukBRk0Mms=;
 b=IT/Ii7wHYw9gpcCxcQKmBbku6/YYtduNp5du6yriQxMsfP5AT3vcYsD4tAPgLMH1P4
 di+T9EVJgXES1OkRIMmWdTDt+j9lRy+XrnpBvA/FrVvdGim3dHuOREv9A3nul4zOeAB4
 Hpkr4ywZpqdlohLclU66EvoVPPRFTXb4OshZRqJ2p1Xt77gZSthmXq6FadGSWUX3BAq2
 gNGFXlQBVBhKPwZCOpbfJpqsIkCxa6e4x24qdQPxKOmo3wIwh674obBk3YJ8ITQBPQl9
 kFSn71bGf2TQWZ71esP9f8JBCJLx/bPK6X/HDAXZiouQCQ3TBbt7p2a54z+3hOI37Ugy
 fxFQ==
X-Gm-Message-State: AOJu0YwyFSiW9uZ9qwKPxdb83lRpWiJjdxrl3/vkp6AMxleOh4XbJeNf
 FXoA9OivmjGWDnRC4HuMLogaDGs3ypHVZ9hF+6Daj1Lchwl+j+fOnPdpIB3aw7qdwrDnh4zDzBR
 YciPhSSckig==
X-Gm-Gg: AeBDievabeRy1yQ2awf/6brPpGdQEwAvDHRT737wp62wckaJWzWs7aqWrJ9Gy0ld7ok
 FetsusmYGRJJAgmM55VO7OXUWwaoA0+dNxfLEmkHbEKPU82GM/aECyQ0A4SQkJsxNgJraxCZLoZ
 NPLSTn143/e4uVvG+45h1tySCfYu3HrKZxd+/xnaI1zBr5v4L0HBLEko1vkWZUg1Dpy5EvIOc9O
 76f+d5qOyuH94uiZuS8IIUozqY9Zmk7JguCyLBAYMAwuym28DVf9AN88WxPs6IJJmJCp+crHsap
 Vao2V53BuF4Y99K0jAI1LkiRoentUfwnjnFug00sY63kar20FUXrE8u7k0AXaiOMRJWdsGw64M7
 b7M930NI+eIK3dyYGhP9Nbx4pVXddvHbbR2YK2UbByZ7ffhuZPzxU281FB39rPnMg1icLkcZy9Y
 bATDw+QpZVU9lzn1MWv5f3T3vNVtRhTYeycqA6O7fr9FQmqZxcXX3j9/VbjCY4Pk6Kyakrj89bV
 2mvxZlRh6uNMOzSsEgBNkT2sutowrn2PpaNVyIlkBEIFl/oIjh5
X-Received: by 2002:a05:6512:1042:b0:5a8:8869:a8e1 with SMTP id
 2adb3069b0e04-5a88869a9admr2357290e87.35.1778146150779; 
 Thu, 07 May 2026 02:29:10 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:08 -0700 (PDT)
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
Subject: [RFC PATCH v2 08/64] usb: dwc3: import from kernel v4.5
Date: Thu,  7 May 2026 11:27:15 +0200
Message-ID: <20260507092843.358908-9-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.4 to v4.5.

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

List of commits: git log --oneline v4.4..v4.5
Commits imported:
c450960187f4 usb: dwc3: Fix assignment of EP transfer resources
6a4290cc28be usb: dwc3: gadget: set the OTG flag in dwc3 gadget driver.
5072cfc40a80 usb: dwc3: of-simple: fix build warning on !PM
d9261898a4b2 usb: dwc3: gadget: don't send extra ZLP
95ca961c758c usb: dwc3: gadget: pass a condition to dev_WARN_ONCE()
46a01427e969 usb: dwc3: trace: show request flags
04c03d10e507 usb: dwc3: gadget: handle request->zero
b084662776be usb: dwc3: remove dwc3-qcom in favor of dwc3-of-simple
16adc674d0d6 usb: dwc3: add generic OF glue layer
b5d335e5ea6a usb: dwc3: ep0: fix setup_packet_pending initialization
ac7bdcc1b3ad usb: dwc3: gadget: simplify next_request() return check
acc38c4970ca usb: dwc3: ep0: purge dev_dbg() calls
1407bf13e3bf usb: dwc3: core: purge dev_dbg() calls
ec5e795cdefb usb: dwc3: gadget: purge dev_dbg() calls
bb423984c28e usb: dwc3: gadget: simplify dwc3_gadget_ep_queue()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.c   |   8 +-
 drivers/usb/dwc3/core.h   |   4 +-
 drivers/usb/dwc3/ep0.c    |  17 ++--
 drivers/usb/dwc3/gadget.c | 204 ++++++++++++++++++++++++++------------
 4 files changed, 157 insertions(+), 76 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 22b4797383cd..de5e01f41bc2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -272,7 +272,8 @@ static int dwc3_event_buffers_setup(struct dwc3 *dwc)
 
 	for (n = 0; n < dwc->num_event_buffers; n++) {
 		evt = dwc->ev_buffs[n];
-		dev_dbg(dwc->dev, "Event buf %p dma %08llx length %d\n",
+		dwc3_trace(trace_dwc3_core,
+				"Event buf %p dma %08llx length %d\n",
 				evt->buf, (unsigned long long) evt->dma,
 				evt->length);
 
@@ -608,12 +609,13 @@ static int dwc3_core_init(struct dwc3 *dwc)
 		reg |= DWC3_GCTL_GBLHIBERNATIONEN;
 		break;
 	default:
-		dev_dbg(dwc->dev, "No power optimization available\n");
+		dwc3_trace(trace_dwc3_core, "No power optimization available\n");
 	}
 
 	/* check if current dwc3 is on simulation board */
 	if (dwc->hwparams.hwparams6 & DWC3_GHWPARAMS6_EN_FPGA) {
-		dev_dbg(dwc->dev, "it is on FPGA board\n");
+		dwc3_trace(trace_dwc3_core,
+				"running on FPGA platform\n");
 		dwc->is_fpga = true;
 	}
 
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 36f1cb74588c..e4f8b90d9627 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -37,6 +37,7 @@
 #define DWC3_MSG_MAX	500
 
 /* Global constants */
+#define DWC3_ZLP_BUF_SIZE	1024	/* size of a superspeed bulk */
 #define DWC3_EP0_BOUNCE_SIZE	512
 #define DWC3_ENDPOINTS_NUM	32
 #define DWC3_XHCI_RESOURCES_NUM	2
@@ -647,6 +648,7 @@ struct dwc3_scratchpad_array {
  * @ctrl_req: usb control request which is used for ep0
  * @ep0_trb: trb which is used for the ctrl_req
  * @ep0_bounce: bounce buffer for ep0
+ * @zlp_buf: used when request->zero is set
  * @setup_buf: used while precessing STD USB requests
  * @ctrl_req_addr: dma address of ctrl_req
  * @ep0_trb: dma address of ep0_trb
@@ -734,6 +736,7 @@ struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
 	struct dwc3_trb		*ep0_trb;
 	void			*ep0_bounce;
+	void			*zlp_buf;
 	void			*scratchbuf;
 	u8			*setup_buf;
 	dma_addr_t		ctrl_req_addr;
@@ -853,7 +856,6 @@ struct dwc3 {
 	unsigned		pullups_connected:1;
 	unsigned		resize_fifos:1;
 	unsigned		setup_packet_pending:1;
-	unsigned		start_config_issued:1;
 	unsigned		three_stage_setup:1;
 	unsigned		usb3_lpm_capable:1;
 
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 5320e939e090..8d6b75c2f53b 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -555,7 +555,6 @@ static int dwc3_ep0_set_config(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	int ret;
 	u32 reg;
 
-	dwc->start_config_issued = false;
 	cfg = le16_to_cpu(ctrl->wValue);
 
 	switch (state) {
@@ -737,10 +736,6 @@ static int dwc3_ep0_std_request(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_ISOCH_DELAY");
 		ret = dwc3_ep0_set_isoch_delay(dwc, ctrl);
 		break;
-	case USB_REQ_SET_INTERFACE:
-		dwc3_trace(trace_dwc3_ep0, "USB_REQ_SET_INTERFACE");
-		dwc->start_config_issued = false;
-		/* Fall through */
 	default:
 		dwc3_trace(trace_dwc3_ep0, "Forwarding to gadget driver");
 		ret = dwc3_ep0_delegate_req(dwc, ctrl);
@@ -817,6 +812,8 @@ static void dwc3_ep0_complete_data(struct dwc3 *dwc,
 
 	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
 	if (status == DWC3_TRBSTS_SETUP_PENDING) {
+		dwc->setup_packet_pending = true;
+
 		dwc3_trace(trace_dwc3_ep0, "Setup Pending received");
 
 		if (r)
@@ -916,8 +913,10 @@ static void dwc3_ep0_complete_status(struct dwc3 *dwc,
 	}
 
 	status = DWC3_TRB_SIZE_TRBSTS(trb->size);
-	if (status == DWC3_TRBSTS_SETUP_PENDING)
+	if (status == DWC3_TRBSTS_SETUP_PENDING) {
+		dwc->setup_packet_pending = true;
 		dwc3_trace(trace_dwc3_ep0, "Setup Pending received");
+	}
 
 	dwc->ep0state = EP0_SETUP_PHASE;
 	dwc3_ep0_out_start(dwc);
@@ -971,7 +970,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 				dep->number);
 		if (ret) {
-			dev_dbg(dwc->dev, "failed to map request\n");
+			dwc3_trace(trace_dwc3_ep0, "failed to map request\n");
 			return;
 		}
 
@@ -999,7 +998,7 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = usb_gadget_map_request(&dwc->gadget, &req->request,
 				dep->number);
 		if (ret) {
-			dev_dbg(dwc->dev, "failed to map request\n");
+			dwc3_trace(trace_dwc3_ep0, "failed to map request\n");
 			return;
 		}
 
@@ -1063,8 +1062,6 @@ static void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		const struct dwc3_event_depevt *event)
 {
-	dwc->setup_packet_pending = true;
-
 	switch (event->status) {
 	case DEPEVT_STATUS_CONTROL_DATA:
 		dwc3_trace(trace_dwc3_ep0, "Control Data");
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a58376fd65fe..2363bad45af8 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -265,9 +265,6 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		usb_gadget_unmap_request(&dwc->gadget, &req->request,
 				req->direction);
 
-	dev_dbg(dwc->dev, "request %p from %s completed %d/%d ===> %d\n",
-			req, dep->name, req->request.actual,
-			req->request.length, status);
 	trace_dwc3_gadget_giveback(req);
 
 	spin_unlock(&dwc->lock);
@@ -388,24 +385,66 @@ static void dwc3_free_trb_pool(struct dwc3_ep *dep)
 	dep->trb_pool_dma = 0;
 }
 
+static int dwc3_gadget_set_xfer_resource(struct dwc3 *dwc, struct dwc3_ep *dep);
+
+/**
+ * dwc3_gadget_start_config - Configure EP resources
+ * @dwc: pointer to our controller context structure
+ * @dep: endpoint that is being enabled
+ *
+ * The assignment of transfer resources cannot perfectly follow the
+ * data book due to the fact that the controller driver does not have
+ * all knowledge of the configuration in advance. It is given this
+ * information piecemeal by the composite gadget framework after every
+ * SET_CONFIGURATION and SET_INTERFACE. Trying to follow the databook
+ * programming model in this scenario can cause errors. For two
+ * reasons:
+ *
+ * 1) The databook says to do DEPSTARTCFG for every SET_CONFIGURATION
+ * and SET_INTERFACE (8.1.5). This is incorrect in the scenario of
+ * multiple interfaces.
+ *
+ * 2) The databook does not mention doing more DEPXFERCFG for new
+ * endpoint on alt setting (8.1.6).
+ *
+ * The following simplified method is used instead:
+ *
+ * All hardware endpoints can be assigned a transfer resource and this
+ * setting will stay persistent until either a core reset or
+ * hibernation. So whenever we do a DEPSTARTCFG(0) we can go ahead and
+ * do DEPXFERCFG for every hardware endpoint as well. We are
+ * guaranteed that there are as many transfer resources as endpoints.
+ *
+ * This function is called for each endpoint when it is being enabled
+ * but is triggered only when called for EP0-out, which always happens
+ * first, and which should only happen in one of the above conditions.
+ */
 static int dwc3_gadget_start_config(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
 	struct dwc3_gadget_ep_cmd_params params;
 	u32			cmd;
+	int			i;
+	int			ret;
+
+	if (dep->number)
+		return 0;
 
 	memset(&params, 0x00, sizeof(params));
+	cmd = DWC3_DEPCMD_DEPSTARTCFG;
 
-	if (dep->number != 1) {
-		cmd = DWC3_DEPCMD_DEPSTARTCFG;
-		/* XferRscIdx == 0 for ep0 and 2 for the remaining */
-		if (dep->number > 1) {
-			if (dwc->start_config_issued)
-				return 0;
-			dwc->start_config_issued = true;
-			cmd |= DWC3_DEPCMD_PARAM(2);
-		}
+	ret = dwc3_send_gadget_ep_cmd(dwc, 0, cmd, &params);
+	if (ret)
+		return ret;
 
-		return dwc3_send_gadget_ep_cmd(dwc, 0, cmd, &params);
+	for (i = 0; i < DWC3_ENDPOINTS_NUM; i++) {
+		struct dwc3_ep *dep = dwc->eps[i];
+
+		if (!dep)
+			continue;
+
+		ret = dwc3_gadget_set_xfer_resource(dwc, dep);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
@@ -519,10 +558,6 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep,
 		struct dwc3_trb	*trb_st_hw;
 		struct dwc3_trb	*trb_link;
 
-		ret = dwc3_gadget_set_xfer_resource(dwc, dep);
-		if (ret)
-			return ret;
-
 		dep->endpoint.desc = desc;
 		dep->comp_desc = comp_desc;
 		dep->type = usb_endpoint_type(desc);
@@ -664,11 +699,10 @@ static int dwc3_gadget_ep_enable(struct usb_ep *ep,
 	dep = to_dwc3_ep(ep);
 	dwc = dep->dwc;
 
-	if (dep->flags & DWC3_EP_ENABLED) {
-		dev_WARN_ONCE(dwc->dev, true, "%s is already enabled\n",
-				dep->name);
+	if (dev_WARN_ONCE(dwc->dev, dep->flags & DWC3_EP_ENABLED,
+					"%s is already enabled\n",
+					dep->name))
 		return 0;
-	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_enable(dep, desc, ep->comp_desc, false, false);
@@ -692,11 +726,10 @@ static int dwc3_gadget_ep_disable(struct usb_ep *ep)
 	dep = to_dwc3_ep(ep);
 	dwc = dep->dwc;
 
-	if (!(dep->flags & DWC3_EP_ENABLED)) {
-		dev_WARN_ONCE(dwc->dev, true, "%s is already disabled\n",
-				dep->name);
+	if (dev_WARN_ONCE(dwc->dev, !(dep->flags & DWC3_EP_ENABLED),
+					"%s is already disabled\n",
+					dep->name))
 		return 0;
-	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
 	ret = __dwc3_gadget_ep_disable(dep);
@@ -985,8 +1018,6 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep, u16 cmd_param,
 	cmd |= DWC3_DEPCMD_PARAM(cmd_param);
 	ret = dwc3_send_gadget_ep_cmd(dwc, dep->number, cmd, &params);
 	if (ret < 0) {
-		dev_dbg(dwc->dev, "failed to send STARTTRANSFER command\n");
-
 		/*
 		 * FIXME we need to iterate over the list of requests
 		 * here and stop, unmap, free and del each of the linked
@@ -1044,6 +1075,20 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 	struct dwc3		*dwc = dep->dwc;
 	int			ret;
 
+	if (!dep->endpoint.desc) {
+		dwc3_trace(trace_dwc3_gadget,
+				"trying to queue request %p to disabled %s\n",
+				&req->request, dep->endpoint.name);
+		return -ESHUTDOWN;
+	}
+
+	if (WARN(req->dep != dep, "request %p belongs to '%s'\n",
+				&req->request, req->dep->name)) {
+		dwc3_trace(trace_dwc3_gadget, "request %p belongs to '%s'\n",
+				&req->request, req->dep->name);
+		return -EINVAL;
+	}
+
 	req->request.actual	= 0;
 	req->request.status	= -EINPROGRESS;
 	req->direction		= dep->direction;
@@ -1141,7 +1186,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 
 out:
 	if (ret && ret != -EBUSY)
-		dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
+		dwc3_trace(trace_dwc3_gadget,
+				"%s: failed to kick transfers\n",
 				dep->name);
 	if (ret == -EBUSY)
 		ret = 0;
@@ -1149,6 +1195,32 @@ out:
 	return ret;
 }
 
+static void __dwc3_gadget_ep_zlp_complete(struct usb_ep *ep,
+		struct usb_request *request)
+{
+	dwc3_gadget_ep_free_request(ep, request);
+}
+
+static int __dwc3_gadget_ep_queue_zlp(struct dwc3 *dwc, struct dwc3_ep *dep)
+{
+	struct dwc3_request		*req;
+	struct usb_request		*request;
+	struct usb_ep			*ep = &dep->endpoint;
+
+	dwc3_trace(trace_dwc3_gadget, "queueing ZLP\n");
+	request = dwc3_gadget_ep_alloc_request(ep, GFP_ATOMIC);
+	if (!request)
+		return -ENOMEM;
+
+	request->length = 0;
+	request->buf = dwc->zlp_buf;
+	request->complete = __dwc3_gadget_ep_zlp_complete;
+
+	req = to_dwc3_request(request);
+
+	return __dwc3_gadget_ep_queue(dep, req);
+}
+
 static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 	gfp_t gfp_flags)
 {
@@ -1161,22 +1233,18 @@ static int dwc3_gadget_ep_queue(struct usb_ep *ep, struct usb_request *request,
 	int				ret;
 
 	spin_lock_irqsave(&dwc->lock, flags);
-	if (!dep->endpoint.desc) {
-		dev_dbg(dwc->dev, "trying to queue request %p to disabled %s\n",
-				request, ep->name);
-		ret = -ESHUTDOWN;
-		goto out;
-	}
-
-	if (WARN(req->dep != dep, "request %p belongs to '%s'\n",
-				request, req->dep->name)) {
-		ret = -EINVAL;
-		goto out;
-	}
-
 	ret = __dwc3_gadget_ep_queue(dep, req);
 
-out:
+	/*
+	 * Okay, here's the thing, if gadget driver has requested for a ZLP by
+	 * setting request->zero, instead of doing magic, we will just queue an
+	 * extra usb_request ourselves so that it gets handled the same way as
+	 * any other request.
+	 */
+	if (ret == 0 && request->zero && request->length &&
+	    (request->length % ep->maxpacket == 0))
+		ret = __dwc3_gadget_ep_queue_zlp(dwc, dep);
+
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
 	return ret;
@@ -1246,7 +1314,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		if (!protocol && ((dep->direction && dep->flags & DWC3_EP_BUSY) ||
 				(!list_empty(&dep->req_queued) ||
 				 !list_empty(&dep->request_list)))) {
-			dev_dbg(dwc->dev, "%s: pending request, cannot halt\n",
+			dwc3_trace(trace_dwc3_gadget,
+					"%s: pending request, cannot halt\n",
 					dep->name);
 			return -EAGAIN;
 		}
@@ -1373,7 +1442,7 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 
 	speed = reg & DWC3_DSTS_CONNECTSPD;
 	if (speed == DWC3_DSTS_SUPERSPEED) {
-		dev_dbg(dwc->dev, "no wakeup on SuperSpeed\n");
+		dwc3_trace(trace_dwc3_gadget, "no wakeup on SuperSpeed\n");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1385,8 +1454,9 @@ static int dwc3_gadget_wakeup(struct usb_gadget *g)
 	case DWC3_LINK_STATE_U3:	/* in HS, means SUSPEND */
 		break;
 	default:
-		dev_dbg(dwc->dev, "can't wakeup from link state %d\n",
-				link_state);
+		dwc3_trace(trace_dwc3_gadget,
+				"can't wakeup from '%s'\n",
+				dwc3_gadget_link_string(link_state));
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1604,8 +1674,6 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	}
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 
-	dwc->start_config_issued = false;
-
 	/* Start with SuperSpeed Default */
 	dwc3_gadget_ep0_desc.wMaxPacketSize = cpu_to_le16(512);
 
@@ -1825,7 +1893,8 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 		if (count) {
 			trb_status = DWC3_TRB_SIZE_TRBSTS(trb->size);
 			if (trb_status == DWC3_TRBSTS_MISSED_ISOC) {
-				dev_dbg(dwc->dev, "incomplete IN transfer %s\n",
+				dwc3_trace(trace_dwc3_gadget,
+						"%s: incomplete IN transfer\n",
 						dep->name);
 				/*
 				 * If missed isoc occurred and there is
@@ -1887,10 +1956,9 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 
 	do {
 		req = next_request(&dep->req_queued);
-		if (!req) {
-			WARN_ON_ONCE(1);
+		if (WARN_ON_ONCE(!req))
 			return 1;
-		}
+
 		i = 0;
 		do {
 			slot = req->start_slot + i;
@@ -2004,7 +2072,8 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		dep->resource_index = 0;
 
 		if (usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
-			dev_dbg(dwc->dev, "%s is an Isochronous endpoint\n",
+			dwc3_trace(trace_dwc3_gadget,
+					"%s is an Isochronous endpoint\n",
 					dep->name);
 			return;
 		}
@@ -2031,7 +2100,8 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 			if (!ret || ret == -EBUSY)
 				return;
 
-			dev_dbg(dwc->dev, "%s: failed to kick transfers\n",
+			dwc3_trace(trace_dwc3_gadget,
+					"%s: failed to kick transfers\n",
 					dep->name);
 		}
 
@@ -2053,11 +2123,12 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		case DEPEVT_STREAMEVT_NOTFOUND:
 			/* FALLTHROUGH */
 		default:
-			dev_dbg(dwc->dev, "Couldn't find suitable stream\n");
+			dwc3_trace(trace_dwc3_gadget,
+					"unable to find suitable stream\n");
 		}
 		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
-		dev_dbg(dwc->dev, "%s FIFO Overrun\n", dep->name);
+		dwc3_trace(trace_dwc3_gadget, "%s FIFO Overrun\n", dep->name);
 		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
 		dwc3_trace(trace_dwc3_gadget, "Endpoint Command Complete");
@@ -2202,7 +2273,6 @@ static void dwc3_gadget_disconnect_interrupt(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DCTL, reg);
 
 	dwc3_disconnect_gadget(dwc);
-	dwc->start_config_issued = false;
 
 	dwc->gadget.speed = USB_SPEED_UNKNOWN;
 	dwc->setup_packet_pending = false;
@@ -2230,8 +2300,8 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 	 *
 	 * Our suggested workaround is to follow the Disconnect
 	 * Event steps here, instead, based on a setup_packet_pending
-	 * flag. Such flag gets set whenever we have a XferNotReady
-	 * event on EP0 and gets cleared on XferComplete for the
+	 * flag. Such flag gets set whenever we have a SETUP_PENDING
+	 * status for EP0 TRBs and gets cleared on XferComplete for the
 	 * same endpoint.
 	 *
 	 * Refers to:
@@ -2253,7 +2323,6 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
 
 	dwc3_stop_active_transfers(dwc);
 	dwc3_clear_stall_all_ep(dwc);
-	dwc->start_config_issued = false;
 
 	/* Reset device address to zero */
 	reg = dwc3_readl(dwc->regs, DWC3_DCFG);
@@ -2744,10 +2813,17 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err3;
 	}
 
+	dwc->zlp_buf = kzalloc(DWC3_ZLP_BUF_SIZE, GFP_KERNEL);
+	if (!dwc->zlp_buf) {
+		ret = -ENOMEM;
+		goto err4;
+	}
+
 	dwc->gadget.ops			= &dwc3_gadget_ops;
 	dwc->gadget.speed		= USB_SPEED_UNKNOWN;
 	dwc->gadget.sg_supported	= true;
 	dwc->gadget.name		= "dwc3-gadget";
+	dwc->gadget.is_otg		= dwc->dr_mode == USB_DR_MODE_OTG;
 
 	/*
 	 * FIXME We might be setting max_speed to <SUPER, however versions
@@ -2785,16 +2861,19 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 	ret = dwc3_gadget_init_endpoints(dwc);
 	if (ret)
-		goto err4;
+		goto err5;
 
 	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register udc\n");
-		goto err4;
+		goto err5;
 	}
 
 	return 0;
 
+err5:
+	kfree(dwc->zlp_buf);
+
 err4:
 	dwc3_gadget_free_endpoints(dwc);
 	dma_free_coherent(dwc->dev, DWC3_EP0_BOUNCE_SIZE,
@@ -2827,6 +2906,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
 	kfree(dwc->setup_buf);
+	kfree(dwc->zlp_buf);
 
 	dma_free_coherent(dwc->dev, sizeof(*dwc->ep0_trb),
 			dwc->ep0_trb, dwc->ep0_trb_addr);
-- 
2.43.0

