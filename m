Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69F0CD3427
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77A1984A7D;
	Thu,  7 May 2026 11:29:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q41erKuv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9769584A7B; Thu,  7 May 2026 11:29:34 +0200 (CEST)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D6D984A78
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-5a887ebb416so536318e87.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146170; x=1778750970; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BrpqxSTnd76aANoE3YXrweqLAoitqts8e9o69isoL08=;
 b=q41erKuv1rvkbUssSFc/AGEiPun9P9ytsKhE6Xeiep0/YNM4HerREfM4NiAC6EXJ8z
 oDmgrUa3oGdRVAeHAcmzVUbBsZVJwQENaaYE/OKJI8nvuNMjTE+eVkqA3M9nTb7mOHbg
 /MLCWdEhdZeja8RkggEcV4zRP4QEuq8FFob/3ISlGe72nvvY8/JC5Y6/g2Gmz6JSEYYi
 QYzyEaTeELBayaZ7IzbZ3sNGDli3iz2QEAdSR8k3iHxzRLa/oS7mwpEh1wGo+1ZeYThZ
 m85c2Tww17yzT+1NClMmEQ3uEqNXdwQCzUwWCICWDWPsf+LrHz9rWJc8J7SXon7fCia9
 23wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146170; x=1778750970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BrpqxSTnd76aANoE3YXrweqLAoitqts8e9o69isoL08=;
 b=Do40ijXLy2UHATsoShye6WGYpESV/7uUvqGBmRYHfn3At6hE1SyMj2yYbUXNdGX3sd
 wQ4wueO6QGbNxZm957McZrwZ2RVbDa+YA2evkSzbizyVZVS1gupVEMGZXdkaFM6O5V9O
 /bbbVE4FuRdUsn5crX8xFSbQ2tNM9BzCqdlyeRUXMUMFJgktgzAUJdhblyKfo7Qa8sgX
 7xQgQaHdDsarKRogzhjKLlSzpc8fqj/e4EIInDLi0kKQTEHwMWpwtYngZWyQmKzr/3JL
 2123ZzuYEkGRBAkBOIsjdv7q4h7EwqlKXFV5jWLdtSLLDFD1vdcnrSBXqYNoLFGbF3Oi
 nqAw==
X-Gm-Message-State: AOJu0YxP8OYFH6HJyGXCjO6BhraY5M0GpNZd4mt7CofIClNvnEyo2j7t
 N2JBcMJcHFa9TR9XtPOrbj7gAqV5ov0GnQsbTMsXn5AZMg1HL/NplTDYH/oghPvClZyiMD0lFnI
 zAbIGQ9qdGQ==
X-Gm-Gg: AeBDiev4YU2kw+X9VxtXiLXxOR4Sq3FmAI5hje0jRC2lStaoIsXSqyLQLrgMxHjb6IZ
 2q5TtGuiTDwrB1/vFuCTJg72dRxCDsr6r0ZwPT9ZTONRM3b5XC7T2Z67epxlX8639Lc57KNguT5
 sYNjL0vG2M/L4L8QMfCyx2Uh+Qv/6WmAWteHGRnIQPA73PObFvE1MDAqAzeyxiRsQCPwetco/8w
 YQWh/rQHtxVrCOkBwU5aH5eruMVhjisJbctrD0kLHxumIugiZ0B0pury9oIY9+LJYyx4X/g2myS
 /TG50sBHvQV/tpOHKpWnxxNXvsLXNJaYqGiH1jK0o2i+dWQYsfxAdlzhfirzvb3wzc1RJNaWDPt
 MQOxwMxqCsIttoFJCsy0iayt9j0Sfl+QRMXdVekMakbM9fP36B8AvChiXoenxl8IwkbouXrvF3S
 a7CbZUHnRmx6UqfSGYlMh0PfYEqIAE73nDvQwRcD6jl4P5ekR/2V9kK5fK3w7tPE8gpPBooaWVv
 xDQ8PS8wCcBT31zoEfUZhZGwNggEoDtHvVKZFbW+g9InwkOelS+
X-Received: by 2002:a05:6512:1044:b0:5a3:f25f:cc30 with SMTP id
 2adb3069b0e04-5a887ce68e9mr2290636e87.32.1778146169575; 
 Thu, 07 May 2026 02:29:29 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:29:28 -0700 (PDT)
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
Subject: [RFC PATCH v2 14/64] usb: dwc3: import from kernel v4.11
Date: Thu,  7 May 2026 11:27:21 +0200
Message-ID: <20260507092843.358908-15-jens.wiklander@linaro.org>
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

Sync Linux kernel dwc3 changes from v4.10 to v4.11.

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

List of commits: git log --oneline v4.10..v4.11
Commits imported:
de288e36fe33 usb: dwc3: gadget: delay unmap of bounced requests
35b2719e72d3 usb: dwc3: gadget: make to increment req->remaining in all cases
0913750f9fb6 usb: dwc3-omap: Fix missing break in dwc3_omap_set_mailbox()
1551e35ea418 usb: dwc3: gadget: Fix system suspend/resume on TI platforms
73561128eb72 usb: dwc3: Fix incorrect type for utmi mode
cf3113d893d4 usb: dwc3: gadget: properly increment dequeue pointer on ep_dequeue
7369090a9fb5 usb: dwc3: gadget: make Set Endpoint Configuration macros safe
bc46e23c3425 Merge tag 'usb-for-v4.11' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
e42a5dbb8a3d usb: dwc3: host: pass quirk-broken-port-ped property for known broken revisions
28781789051e usb: dwc3: gadget: read IN ep FIFO size from HW
692665c621bb Merge 4.10-rc5 into usb-next
ffb80fc672c3 usb: dwc3: gadget: skip Set/Clear Halt when invalid
538967983b88 usb: dwc3: ep0: Fix the possible missed request for handling delay STATUS phase
c773bb0b9264 usb: dwc3: omap: Replace the extcon API
c6267a51639b usb: dwc3: gadget: align transfers to wMaxPacketSize
905dc04ea796 usb: dwc3: gadget: allocate bounce buffer for unaligned xfers
e49d3cf4926a usb: dwc3: gadget: extract __dwc3_prepare_one_trb()
843053093f47 usb: dwc3: gadget: simplify dwc3_prepare_one_trb()
0e4018ff5d12 usb: dwc3: exynos: Remove MODULE_ALIAS()
3e27b3f66a56 usb: dwc3: exynos remove suspend clock unspecified debug message

Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
---
 drivers/usb/dwc3/core.h   |   5 +
 drivers/usb/dwc3/ep0.c    |  14 ++
 drivers/usb/dwc3/gadget.c | 287 +++++++++++++++++++++++++++++++-------
 drivers/usb/dwc3/gadget.h |  14 +-
 4 files changed, 260 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 14b760209680..2b9e4ca3c932 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -40,6 +40,7 @@
 /* Global constants */
 #define DWC3_PULL_UP_TIMEOUT	500	/* ms */
 #define DWC3_ZLP_BUF_SIZE	1024	/* size of a superspeed bulk */
+#define DWC3_BOUNCE_SIZE	1024	/* size of a superspeed bulk */
 #define DWC3_EP0_BOUNCE_SIZE	512
 #define DWC3_ENDPOINTS_NUM	32
 #define DWC3_XHCI_RESOURCES_NUM	2
@@ -724,6 +725,7 @@ struct dwc3_hwparams {
  * @epnum: endpoint number to which this request refers
  * @trb: pointer to struct dwc3_trb
  * @trb_dma: DMA address of @trb
+ * @unaligned: true for OUT endpoints with length not divisible by maxp
  * @direction: IN or OUT direction flag
  * @mapped: true when request has been dma-mapped
  * @queued: true when request has been queued to HW
@@ -740,6 +742,7 @@ struct dwc3_request {
 	struct dwc3_trb		*trb;
 	dma_addr_t		trb_dma;
 
+	unsigned		unaligned:1;
 	unsigned		direction:1;
 	unsigned		mapped:1;
 	unsigned		started:1;
@@ -857,12 +860,14 @@ struct dwc3_scratchpad_array {
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
 	struct dwc3_trb		*ep0_trb;
+	void			*bounce;
 	void			*ep0_bounce;
 	void			*zlp_buf;
 	void			*scratchbuf;
 	u8			*setup_buf;
 	dma_addr_t		ctrl_req_addr;
 	dma_addr_t		ep0_trb_addr;
+	dma_addr_t		bounce_addr;
 	dma_addr_t		ep0_bounce_addr;
 	dma_addr_t		scratch_addr;
 	struct dwc3_request	ep0_usb_req;
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 9bb1f8526f3e..e689cede9b0e 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -1123,7 +1123,21 @@ static void dwc3_ep0_xfernotready(struct dwc3 *dwc,
 		dwc->ep0state = EP0_STATUS_PHASE;
 
 		if (dwc->delayed_status) {
+			struct dwc3_ep *dep = dwc->eps[0];
+
 			WARN_ON_ONCE(event->endpoint_number != 1);
+			/*
+			 * We should handle the delay STATUS phase here if the
+			 * request for handling delay STATUS has been queued
+			 * into the list.
+			 */
+			if (!list_empty(&dep->pending_list)) {
+				dwc->delayed_status = false;
+				usb_gadget_set_state(&dwc->gadget,
+						     USB_STATE_CONFIGURED);
+				dwc3_ep0_do_control_status(dwc, event);
+			}
+
 			return;
 		}
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 204c754cc647..79e7a3480d51 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -171,6 +171,7 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 		int status)
 {
 	struct dwc3			*dwc = dep->dwc;
+	unsigned int			unmap_after_complete = false;
 
 	req->started = false;
 	list_del(&req->list);
@@ -180,11 +181,19 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	if (req->request.status == -EINPROGRESS)
 		req->request.status = status;
 
-	if (dwc->ep0_bounced && dep->number <= 1)
+	/*
+	 * NOTICE we don't want to unmap before calling ->complete() if we're
+	 * dealing with a bounced ep0 request. If we unmap it here, we would end
+	 * up overwritting the contents of req->buf and this could confuse the
+	 * gadget driver.
+	 */
+	if (dwc->ep0_bounced && dep->number <= 1) {
 		dwc->ep0_bounced = false;
-
-	usb_gadget_unmap_request_by_dev(dwc->sysdev,
-			&req->request, req->direction);
+		unmap_after_complete = true;
+	} else {
+		usb_gadget_unmap_request_by_dev(dwc->sysdev,
+				&req->request, req->direction);
+	}
 
 	trace_dwc3_gadget_giveback(req);
 
@@ -192,6 +201,10 @@ void dwc3_gadget_giveback(struct dwc3_ep *dep, struct dwc3_request *req,
 	usb_gadget_giveback_request(&dep->endpoint, &req->request);
 	spin_lock(&dwc->lock);
 
+	if (unmap_after_complete)
+		usb_gadget_unmap_request_by_dev(dwc->sysdev,
+				&req->request, req->direction);
+
 	if (dep->number > 1)
 		pm_runtime_put(dwc->dev);
 }
@@ -833,29 +846,14 @@ static void dwc3_gadget_ep_free_request(struct usb_ep *ep,
 
 static u32 dwc3_calc_trbs_left(struct dwc3_ep *dep);
 
-/**
- * dwc3_prepare_one_trb - setup one TRB from one request
- * @dep: endpoint for which this request is prepared
- * @req: dwc3_request pointer
- */
-static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
-		struct dwc3_request *req, dma_addr_t dma,
-		unsigned length, unsigned chain, unsigned node)
+static void __dwc3_prepare_one_trb(struct dwc3_ep *dep, struct dwc3_trb *trb,
+		dma_addr_t dma, unsigned length, unsigned chain, unsigned node,
+		unsigned stream_id, unsigned short_not_ok, unsigned no_interrupt)
 {
-	struct dwc3_trb		*trb;
 	struct dwc3		*dwc = dep->dwc;
 	struct usb_gadget	*gadget = &dwc->gadget;
 	enum usb_device_speed	speed = gadget->speed;
 
-	trb = &dep->trb_pool[dep->trb_enqueue];
-
-	if (!req->trb) {
-		dwc3_gadget_move_started_request(req);
-		req->trb = trb;
-		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
-		dep->queued_requests++;
-	}
-
 	dwc3_ep_inc_enq(dep);
 
 	trb->size = DWC3_TRB_SIZE_LENGTH(length);
@@ -900,11 +898,11 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 	if (usb_endpoint_dir_out(dep->endpoint.desc)) {
 		trb->ctrl |= DWC3_TRB_CTRL_CSP;
 
-		if (req->request.short_not_ok)
+		if (short_not_ok)
 			trb->ctrl |= DWC3_TRB_CTRL_ISP_IMI;
 	}
 
-	if ((!req->request.no_interrupt && !chain) ||
+	if ((!no_interrupt && !chain) ||
 			(dwc3_calc_trbs_left(dep) == 0))
 		trb->ctrl |= DWC3_TRB_CTRL_IOC;
 
@@ -912,13 +910,43 @@ static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
 		trb->ctrl |= DWC3_TRB_CTRL_CHN;
 
 	if (usb_endpoint_xfer_bulk(dep->endpoint.desc) && dep->stream_capable)
-		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(req->request.stream_id);
+		trb->ctrl |= DWC3_TRB_CTRL_SID_SOFN(stream_id);
 
 	trb->ctrl |= DWC3_TRB_CTRL_HWO;
 
 	trace_dwc3_prepare_trb(dep, trb);
 }
 
+/**
+ * dwc3_prepare_one_trb - setup one TRB from one request
+ * @dep: endpoint for which this request is prepared
+ * @req: dwc3_request pointer
+ * @chain: should this TRB be chained to the next?
+ * @node: only for isochronous endpoints. First TRB needs different type.
+ */
+static void dwc3_prepare_one_trb(struct dwc3_ep *dep,
+		struct dwc3_request *req, unsigned chain, unsigned node)
+{
+	struct dwc3_trb		*trb;
+	unsigned		length = req->request.length;
+	unsigned		stream_id = req->request.stream_id;
+	unsigned		short_not_ok = req->request.short_not_ok;
+	unsigned		no_interrupt = req->request.no_interrupt;
+	dma_addr_t		dma = req->request.dma;
+
+	trb = &dep->trb_pool[dep->trb_enqueue];
+
+	if (!req->trb) {
+		dwc3_gadget_move_started_request(req);
+		req->trb = trb;
+		req->trb_dma = dwc3_trb_dma_offset(dep, trb);
+		dep->queued_requests++;
+	}
+
+	__dwc3_prepare_one_trb(dep, trb, dma, length, chain, node,
+			stream_id, short_not_ok, no_interrupt);
+}
+
 /**
  * dwc3_ep_prev_trb() - Returns the previous TRB in the ring
  * @dep: The endpoint with the TRB ring
@@ -974,21 +1002,36 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 {
 	struct scatterlist *sg = req->sg;
 	struct scatterlist *s;
-	unsigned int	length;
-	dma_addr_t	dma;
 	int		i;
 
 	for_each_sg(sg, s, req->num_pending_sgs, i) {
+		unsigned int length = req->request.length;
+		unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
+		unsigned int rem = length % maxp;
 		unsigned chain = true;
 
-		length = sg_dma_len(s);
-		dma = sg_dma_address(s);
-
 		if (sg_is_last(s))
 			chain = false;
 
-		dwc3_prepare_one_trb(dep, req, dma, length,
-				chain, i);
+		if (rem && usb_endpoint_dir_out(dep->endpoint.desc) && !chain) {
+			struct dwc3	*dwc = dep->dwc;
+			struct dwc3_trb	*trb;
+
+			req->unaligned = true;
+
+			/* prepare normal TRB */
+			dwc3_prepare_one_trb(dep, req, true, i);
+
+			/* Now prepare one extra TRB to align transfer size */
+			trb = &dep->trb_pool[dep->trb_enqueue];
+			__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr,
+					maxp - rem, false, 0,
+					req->request.stream_id,
+					req->request.short_not_ok,
+					req->request.no_interrupt);
+		} else {
+			dwc3_prepare_one_trb(dep, req, chain, i);
+		}
 
 		if (!dwc3_calc_trbs_left(dep))
 			break;
@@ -998,14 +1041,28 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 static void dwc3_prepare_one_trb_linear(struct dwc3_ep *dep,
 		struct dwc3_request *req)
 {
-	unsigned int	length;
-	dma_addr_t	dma;
+	unsigned int length = req->request.length;
+	unsigned int maxp = usb_endpoint_maxp(dep->endpoint.desc);
+	unsigned int rem = length % maxp;
 
-	dma = req->request.dma;
-	length = req->request.length;
+	if (rem && usb_endpoint_dir_out(dep->endpoint.desc)) {
+		struct dwc3	*dwc = dep->dwc;
+		struct dwc3_trb	*trb;
+
+		req->unaligned = true;
+
+		/* prepare normal TRB */
+		dwc3_prepare_one_trb(dep, req, true, 0);
 
-	dwc3_prepare_one_trb(dep, req, dma, length,
-			false, 0);
+		/* Now prepare one extra TRB to align transfer size */
+		trb = &dep->trb_pool[dep->trb_enqueue];
+		__dwc3_prepare_one_trb(dep, trb, dwc->bounce_addr, maxp - rem,
+				false, 0, req->request.stream_id,
+				req->request.short_not_ok,
+				req->request.no_interrupt);
+	} else {
+		dwc3_prepare_one_trb(dep, req, false, 0);
+	}
 }
 
 /*
@@ -1298,6 +1355,68 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 		if (r == req) {
 			/* wait until it is processed */
 			dwc3_stop_active_transfer(dwc, dep->number, true);
+
+			/*
+			 * If request was already started, this means we had to
+			 * stop the transfer. With that we also need to ignore
+			 * all TRBs used by the request, however TRBs can only
+			 * be modified after completion of END_TRANSFER
+			 * command. So what we do here is that we wait for
+			 * END_TRANSFER completion and only after that, we jump
+			 * over TRBs by clearing HWO and incrementing dequeue
+			 * pointer.
+			 *
+			 * Note that we have 2 possible types of transfers here:
+			 *
+			 * i) Linear buffer request
+			 * ii) SG-list based request
+			 *
+			 * SG-list based requests will have r->num_pending_sgs
+			 * set to a valid number (> 0). Linear requests,
+			 * normally use a single TRB.
+			 *
+			 * For each of these two cases, if r->unaligned flag is
+			 * set, one extra TRB has been used to align transfer
+			 * size to wMaxPacketSize.
+			 *
+			 * All of these cases need to be taken into
+			 * consideration so we don't mess up our TRB ring
+			 * pointers.
+			 */
+			wait_event_lock_irq(dep->wait_end_transfer,
+					!(dep->flags & DWC3_EP_END_TRANSFER_PENDING),
+					dwc->lock);
+
+			if (!r->trb)
+				goto out1;
+
+			if (r->num_pending_sgs) {
+				struct dwc3_trb *trb;
+				int i = 0;
+
+				for (i = 0; i < r->num_pending_sgs; i++) {
+					trb = r->trb + i;
+					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+					dwc3_ep_inc_deq(dep);
+				}
+
+				if (r->unaligned) {
+					trb = r->trb + r->num_pending_sgs + 1;
+					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+					dwc3_ep_inc_deq(dep);
+				}
+			} else {
+				struct dwc3_trb *trb = r->trb;
+
+				trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+				dwc3_ep_inc_deq(dep);
+
+				if (r->unaligned) {
+					trb = r->trb + 1;
+					trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
+					dwc3_ep_inc_deq(dep);
+				}
+			}
 			goto out1;
 		}
 		dev_err(dwc->dev, "request %p was not queued to %s\n",
@@ -1308,6 +1427,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 
 out1:
 	/* giveback the request */
+	dep->queued_requests--;
 	dwc3_gadget_giveback(dep, req, -ECONNRESET);
 
 out0:
@@ -1335,6 +1455,9 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		unsigned transfer_in_flight;
 		unsigned started;
 
+		if (dep->flags & DWC3_EP_STALL)
+			return 0;
+
 		if (dep->number > 1)
 			trb = dwc3_ep_prev_trb(dep, dep->trb_enqueue);
 		else
@@ -1356,6 +1479,8 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 		else
 			dep->flags |= DWC3_EP_STALL;
 	} else {
+		if (!(dep->flags & DWC3_EP_STALL))
+			return 0;
 
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
 		if (ret)
@@ -1918,6 +2043,44 @@ static int dwc3_gadget_init_hw_endpoints(struct dwc3 *dwc,
 			dep->endpoint.ops = &dwc3_gadget_ep0_ops;
 			if (!epnum)
 				dwc->gadget.ep0 = &dep->endpoint;
+		} else if (direction) {
+			int mdwidth;
+			int size;
+			int ret;
+			int num;
+
+			mdwidth = DWC3_MDWIDTH(dwc->hwparams.hwparams0);
+			/* MDWIDTH is represented in bits, we need it in bytes */
+			mdwidth /= 8;
+
+			size = dwc3_readl(dwc->regs, DWC3_GTXFIFOSIZ(i));
+			size = DWC3_GTXFIFOSIZ_TXFDEF(size);
+
+			/* FIFO Depth is in MDWDITH bytes. Multiply */
+			size *= mdwidth;
+
+			num = size / 1024;
+			if (num == 0)
+				num = 1;
+
+			/*
+			 * FIFO sizes account an extra MDWIDTH * (num + 1) bytes for
+			 * internal overhead. We don't really know how these are used,
+			 * but documentation say it exists.
+			 */
+			size -= mdwidth * (num + 1);
+			size /= num;
+
+			usb_ep_set_maxpacket_limit(&dep->endpoint, size);
+
+			dep->endpoint.max_streams = 15;
+			dep->endpoint.ops = &dwc3_gadget_ep_ops;
+			list_add_tail(&dep->endpoint.ep_list,
+					&dwc->gadget.ep_list);
+
+			ret = dwc3_alloc_trb_pool(dep);
+			if (ret)
+				return ret;
 		} else {
 			int		ret;
 
@@ -2029,12 +2192,22 @@ static int __dwc3_cleanup_done_trbs(struct dwc3 *dwc, struct dwc3_ep *dep,
 	if (chain && (trb->ctrl & DWC3_TRB_CTRL_HWO))
 		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 
-	if ((trb->ctrl & DWC3_TRB_CTRL_HWO) && status != -ESHUTDOWN)
+	/*
+	 * If we're dealing with unaligned size OUT transfer, we will be left
+	 * with one TRB pending in the ring. We need to manually clear HWO bit
+	 * from that TRB.
+	 */
+	if (req->unaligned && (trb->ctrl & DWC3_TRB_CTRL_HWO)) {
+		trb->ctrl &= ~DWC3_TRB_CTRL_HWO;
 		return 1;
+	}
 
 	count = trb->size & DWC3_TRB_SIZE_MASK;
 	req->remaining += count;
 
+	if ((trb->ctrl & DWC3_TRB_CTRL_HWO) && status != -ESHUTDOWN)
+		return 1;
+
 	if (dep->direction) {
 		if (count) {
 			trb_status = DWC3_TRB_SIZE_TRBSTS(trb->size);
@@ -2118,6 +2291,13 @@ static int dwc3_cleanup_done_reqs(struct dwc3 *dwc, struct dwc3_ep *dep,
 					event, status, chain);
 		}
 
+		if (req->unaligned) {
+			trb = &dep->trb_pool[dep->trb_dequeue];
+			ret = __dwc3_cleanup_done_trbs(dwc, dep, req, trb,
+					event, status, false);
+			req->unaligned = false;
+		}
+
 		req->request.actual = length - req->remaining;
 
 		if ((req->request.actual < length) && req->num_pending_sgs)
@@ -3019,6 +3199,13 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 		goto err4;
 	}
 
+	dwc->bounce = dma_alloc_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE,
+			&dwc->bounce_addr, GFP_KERNEL);
+	if (!dwc->bounce) {
+		ret = -ENOMEM;
+		goto err5;
+	}
+
 	init_completion(&dwc->ep0_in_setup);
 
 	dwc->gadget.ops			= &dwc3_gadget_ops;
@@ -3049,12 +3236,6 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 	dwc->gadget.max_speed		= dwc->maximum_speed;
 
-	/*
-	 * Per databook, DWC3 needs buffer size to be aligned to MaxPacketSize
-	 * on ep out.
-	 */
-	dwc->gadget.quirk_ep_out_aligned_size = true;
-
 	/*
 	 * REVISIT: Here we should clear all pending IRQs to be
 	 * sure we're starting from a well known location.
@@ -3062,15 +3243,18 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 
 	ret = dwc3_gadget_init_endpoints(dwc);
 	if (ret)
-		goto err5;
+		goto err6;
 
 	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
 	if (ret) {
 		dev_err(dwc->dev, "failed to register udc\n");
-		goto err5;
+		goto err6;
 	}
 
 	return 0;
+err6:
+	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
+			dwc->bounce_addr);
 
 err5:
 	kfree(dwc->zlp_buf);
@@ -3103,6 +3287,8 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 	dwc3_gadget_free_endpoints(dwc);
 
+	dma_free_coherent(dwc->sysdev, DWC3_BOUNCE_SIZE, dwc->bounce,
+			dwc->bounce_addr);
 	dma_free_coherent(dwc->sysdev, DWC3_EP0_BOUNCE_SIZE,
 			dwc->ep0_bounce, dwc->ep0_bounce_addr);
 
@@ -3118,15 +3304,10 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
-	int ret;
-
 	if (!dwc->gadget_driver)
 		return 0;
 
-	ret = dwc3_gadget_run_stop(dwc, false, false);
-	if (ret < 0)
-		return ret;
-
+	dwc3_gadget_run_stop(dwc, false, false);
 	dwc3_disconnect_gadget(dwc);
 	__dwc3_gadget_stop(dwc);
 
diff --git a/drivers/usb/dwc3/gadget.h b/drivers/usb/dwc3/gadget.h
index 3129bcf74d7d..265e223ab645 100644
--- a/drivers/usb/dwc3/gadget.h
+++ b/drivers/usb/dwc3/gadget.h
@@ -28,23 +28,23 @@ struct dwc3;
 #define gadget_to_dwc(g)	(container_of(g, struct dwc3, gadget))
 
 /* DEPCFG parameter 1 */
-#define DWC3_DEPCFG_INT_NUM(n)		((n) << 0)
+#define DWC3_DEPCFG_INT_NUM(n)		(((n) & 0x1f) << 0)
 #define DWC3_DEPCFG_XFER_COMPLETE_EN	(1 << 8)
 #define DWC3_DEPCFG_XFER_IN_PROGRESS_EN	(1 << 9)
 #define DWC3_DEPCFG_XFER_NOT_READY_EN	(1 << 10)
 #define DWC3_DEPCFG_FIFO_ERROR_EN	(1 << 11)
 #define DWC3_DEPCFG_STREAM_EVENT_EN	(1 << 13)
-#define DWC3_DEPCFG_BINTERVAL_M1(n)	((n) << 16)
+#define DWC3_DEPCFG_BINTERVAL_M1(n)	(((n) & 0xff) << 16)
 #define DWC3_DEPCFG_STREAM_CAPABLE	(1 << 24)
-#define DWC3_DEPCFG_EP_NUMBER(n)	((n) << 25)
+#define DWC3_DEPCFG_EP_NUMBER(n)	(((n) & 0x1f) << 25)
 #define DWC3_DEPCFG_BULK_BASED		(1 << 30)
 #define DWC3_DEPCFG_FIFO_BASED		(1 << 31)
 
 /* DEPCFG parameter 0 */
-#define DWC3_DEPCFG_EP_TYPE(n)		((n) << 1)
-#define DWC3_DEPCFG_MAX_PACKET_SIZE(n)	((n) << 3)
-#define DWC3_DEPCFG_FIFO_NUMBER(n)	((n) << 17)
-#define DWC3_DEPCFG_BURST_SIZE(n)	((n) << 22)
+#define DWC3_DEPCFG_EP_TYPE(n)		(((n) & 0x3) << 1)
+#define DWC3_DEPCFG_MAX_PACKET_SIZE(n)	(((n) & 0x7ff) << 3)
+#define DWC3_DEPCFG_FIFO_NUMBER(n)	(((n) & 0x1f) << 17)
+#define DWC3_DEPCFG_BURST_SIZE(n)	(((n) & 0xf) << 22)
 #define DWC3_DEPCFG_DATA_SEQ_NUM(n)	((n) << 26)
 /* This applies for core versions earlier than 1.94a */
 #define DWC3_DEPCFG_IGN_SEQ_NUM		(1 << 31)
-- 
2.43.0

