Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB96C5DF87
	for <u-boot@archiver.kernel.org>; Fri, 21 Aug 2026 13:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 487D4409B1;
	Fri, 21 Aug 2026 13:12:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vDuny4S5uA1H; Fri, 21 Aug 2026 13:12:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787317927;
	bh=ievz7h6QBZFXHn2aHR3IYvRvfJl0Qx0Yu50CQh+cktU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aZ4T1VFGarhiQHhZw/zyLQyYjhpTYagbgyveourEM6ETDebd7ZVdW+GUIQaxan2HT
	 YE0lECjHeRUPZBDfPubYxIatF7fI0iPYntscjbMsuJaf/BOGhQDj10DSMC+1hPYqig
	 duXaiND2vcBxJKFWCDIC3WPm465NPevFH2QLhYmkWtekSWDlRuolYjOQ4hFZX7VIHI
	 Ma1azANx1TsjxiAvvYoVvze3TWt2qm/TNmEFXZgxWgnrI4bJDo/3RWYBd4chRsEe+w
	 OhBnsmw1x2l/m+tua92iVMD1NaDlrv77JBNkXHccMfQp6ZQns03wJGl8yp5sIBdMfe
	 l//JATuaX00og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BB8CD40556;
	Fri, 21 Aug 2026 13:12:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F2F35EA3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D928640071
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LUQjgmW4tnOH for <u-boot@lists.u-boot-project.org>;
 Fri, 21 Aug 2026 08:51:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::530; helo=mail-ed1-x530.google.com;
 envelope-from=anders.roxell@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=kHUm3oam
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1D6864006A
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 08:51:02 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-69edc72e513so135200a12.3
 for <u-boot@lists.u-boot-project.org>; Fri, 21 Aug 2026 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787302261; x=1787907061;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ievz7h6QBZFXHn2aHR3IYvRvfJl0Qx0Yu50CQh+cktU=;
 b=kHUm3oamefdLXP8R6Cmog343V2D8yHg+w4s7QDMGKrMk2nl6WO7i29Y9taTmzWtJ7n
 wW8hwznhMryolG6stqXcrKGqRMyD0Q9EnTKHQCwxMPaNGZZfcUS6mFCB3w+sVgv/IiRo
 T8odJFDjIPPca1k7AUIUvL/jdThMWK92E7UOmaJXsJy8rPZdHM0xVyzXqIdTZaFB79M8
 W3AAhuF3gYaH2VseDttlgRjbFUJeaPn20C1AHbkrIQa2ESSz8k0hXuvWcbJVDtm8tk5w
 gZPHTNWEi7AUFgZbI4CaQyLaiwudxZFqr47ToTPgEXsRTzi3iVZbs8+oyLV2oAtw9xeo
 S20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787302261; x=1787907061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ievz7h6QBZFXHn2aHR3IYvRvfJl0Qx0Yu50CQh+cktU=;
 b=jvXaSajuNwtzdMJENRRf2mY6yhvkyzRszlFi/lcinhMDL0hqVWs3dhxZLVR9oly3q/
 25vQjhz/DmVccoDeil5kSlbR/xTuANRmU0PecHxe0MjbiYc0xeDAgZhu7ba8XdOLvvrN
 D1X9EO6+yxa5rBPHRtbSnDH+MmXvkmvsONzITqG+Im/ENn6Dt97y+lW8wOfmYMWBNrIC
 ROEEdkwBuywYdU5b+WryWu00384NdNGJdBe9ahpmXCySOcePFkAINNSdw3vq2xFFZB44
 yUuFDfLdjN/6XXx74c+k2CoULpb89jBgw7dZUMAHO5DKs4xOlO0F+tbUPfuK6CG6CB8j
 6inQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpK/l0OJAaKHxM1QLcy+Nt5SNC/eQpcdfxRO0YoZAr9dYul7eKbkogo+xWZT2D6rfm1ef0mNgI=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lIy/o3YPVUMj6BrjXITnhVsiDegUkOhAwFxjwprqOr8pdcIsBW
 hIsaUfJITx0JKewDhDEuFa+4pX6HjD6UCeUJ8t5wCmh883jZBGMBcwB3gbrtxHFD048=
X-Gm-Gg: AR+sD12ai0SGRPwdASJIliLwQ+qN+Lhrkx+Z/GkBdr1t9lvYr9+PXS7w4d9VdY6M4zn
 irZRbrZ2OmCUDYnxbNHAQJYOR9icraZCe0ZXHdB1XnVtqp1RfNL2lmLL9YTkUhsau+slxdPEWzO
 VNrOEBbZ/LDpXTB7DnTraxaIV9ml7HNVISJdRZEcMEnx8YeojWhysqbpeB2y3D3z1//AaziM4CO
 nSq2ca4IYoGZ5o00RUAW1e16kAVjIwx8pO1dcxxU8ygiLXGAbU9RHWn+dSwDkEWh0TDWmV0Z8Bc
 EkRIY3xY1WpjbQHFyrN+mSYX+6fVxbuwSHuv0CvSU/VZyhq6DqrS00SZ5jRzll2Wzjocyp4qmFA
 HOod54G3NYvtM5kPxhA20Zm0jLnd7vN7VOPUTvMntLqrqmJFTMVVsJtlgwm3FN8xPXNJJWVoZZK
 abMOJ1egL+ZAeNhnW0bmGco2M4R2TBMzAqx3ZQeDLLskcbDkTIAH9htpj9kvyPuRFrkx1amKsf5
 GWehgrzvARq6MBItZWV0qvC
X-Received: by 2002:a17:907:1c26:b0:c21:8555:5f55 with SMTP id
 a640c23a62f3a-c246a65eda7mr256048866b.2.1787302260611; 
 Fri, 21 Aug 2026 01:51:00 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2458b648f9sm352411966b.28.2026.08.21.01.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 01:50:59 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Jens Wiklander <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski <lukma@denx.de>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 09/87] usb: dwc3: import from kernel v4.5
Date: Fri, 21 Aug 2026 10:46:45 +0200
Message-ID: <20260821084829.2070426-10-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821084829.2070426-1-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 21 Aug 2026 13:11:39 +0000
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

Sync Linux kernel dwc3 changes from v4.4 to v4.5.

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

List of commits: git log --oneline v4.4..v4.5
Commits imported:
c450960187f4 usb: dwc3: Fix assignment of EP transfer resources
6a4290cc28be usb: dwc3: gadget: set the OTG flag in dwc3 gadget driver.
d9261898a4b2 usb: dwc3: gadget: don't send extra ZLP
95ca961c758c usb: dwc3: gadget: pass a condition to dev_WARN_ONCE()
04c03d10e507 usb: dwc3: gadget: handle request->zero
b5d335e5ea6a usb: dwc3: ep0: fix setup_packet_pending initialization
ac7bdcc1b3ad usb: dwc3: gadget: simplify next_request() return check
acc38c4970ca usb: dwc3: ep0: purge dev_dbg() calls
1407bf13e3bf usb: dwc3: core: purge dev_dbg() calls
ec5e795cdefb usb: dwc3: gadget: purge dev_dbg() calls
bb423984c28e usb: dwc3: gadget: simplify dwc3_gadget_ep_queue()

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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
2.53.0

