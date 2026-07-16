Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E2AC44511
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 16:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3023884ED6;
	Thu, 16 Jul 2026 18:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RTW9MhNR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFCA684CCF; Thu, 16 Jul 2026 15:44:56 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D04684CEE
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=anders.roxell@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c16111a9b8dso56501566b.1
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 06:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784209493; x=1784814293; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nyxesvnlruhlZuAAGBnaLaqT9H/oN3zeMmFPrPQIYLE=;
 b=RTW9MhNR6YTbOUzURAekSYtSEzQWe2WdU0+A2PG+ldLz40D4ap875B7PMdSkawYQTH
 dI2NHCXmOgZxLWDdPV6kTe3EJRHa2r8iDtSlhNd1VB3cQjwmO9aujDAQjwDyeDGDOImZ
 E9OjqEmpGL43y0ItLXyvjne2TWpOVLRXUmMyzlf0tLBfZD1loHyUu43Jxo912rCGFFC3
 8JgglwowDI+n42DuWNfSNRJaKNCQxvBWQUR+DpRWPU/kbzs3QBcdfEf9j/Y/lsGiVtaK
 JRL9V6a12m1bk/1hu3BN4JBNrXg9S+Eu+FmH1UvL6/COrW+n3gPF4pOloEhVrP9eoB7Y
 UTNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784209493; x=1784814293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nyxesvnlruhlZuAAGBnaLaqT9H/oN3zeMmFPrPQIYLE=;
 b=SS9VC2iVrNVM1VfVzKBWCHaC6fImrUav9TAeXl1E6tMURGOZLOO/74HzKF3SvmKlhw
 c6ezYHVdRowxUa+1hBsy6QsVRl0USxM7QmAfeFCUk1QWSTIAfYW3Puehr20mcN4dJfc0
 5NkQAV7+K/Qe1vqtJ4j+hndKKJR5bf+QHPXamcedp+VSC2OR2RMi+lXEQm4wxFWdmhXR
 9EdJNLCb3Idbw3/1WkPH0isYCWTn40jlCAXEaHGesWokcJ4ZUVMxqqjwcz8FyfXX6t5Q
 PdivyuzCnY9NBAEiXGYbaRdf/sSqfN1NnVY9IkVgndp9mHE4PkHoboWAlOYi+2Qr7oVP
 YbXg==
X-Gm-Message-State: AOJu0YySFl4abs3S841ueVh/lUfy+v56EYS/AebDbB5qeSBnfZbGSj8J
 oXi6aJorNV6ZlPvkEDttQO8twwPaLfgn2jI2W5uXcnG+Iqhl+8awIY5Qjc21m2FOfuFfyQTnU9V
 vfOjt
X-Gm-Gg: AfdE7ckNBZKSRIfxkUudoxyokuJHeXMFAPr1UI/EpqScbqpghUvaci+yv3LMhSagFRD
 CrJ5DOWtvJFYfEYqaf5kzNU7Zm/rlyjJOOBqPpNWKdmWuID7LUKH4y7vB2zb5hv5mHmqiP9pDUM
 Xypj7FclFnA5zYoQN7mYVciPR44dlYNdUEasOGqc4KiQTlrMG/Nw6QVd1zghDWcpHDzmttX/KJq
 9zMSq7kz5mj8EtbNaUCaChUicQaMoqkys1Q2hpcMa/KEy8ssrrCiuw33k3VNv8Dgr5TX5ovA1wJ
 9kHfn5f2uWsLoBUBe+qZqc8hsIOVK5dZWyaNai/WsYeyIuKpsRuJrBGlkUpe8Of27sUdFJMw0Ul
 t3jWcJ7ryOV9OMCzGSpXJAy494yRXAiMft4UZEO4+NnbF5m8Il0LcGdjt1D16MSnOSYFVbmtxf1
 YKDCnS896zhKjE5eKt4k6eDGS0ldiV8eEmfYJskw==
X-Received: by 2002:a17:907:7256:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c168dd4abc0mr114216366b.4.1784209492852; 
 Thu, 16 Jul 2026 06:44:52 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c168744bff3sm222731766b.46.2026.07.16.06.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:44:52 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: u-boot@lists.denx.de,
	marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org, trini@konsulko.com,
 michal.simek@amd.com, alchark@flipper.net, jerome.forissier@arm.com,
 Anders Roxell <anders.roxell@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v5 70/75] usb: gadget: ci_udc: drop code we do not use
Date: Thu, 16 Jul 2026 15:42:40 +0200
Message-ID: <20260716134305.614278-71-anders.roxell@linaro.org>
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

After the resync a big part of ci_udc.c is not used in u-boot. Remove
it.

Co-developed-by: Jerome Forissier <jerome.forissier@linaro.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Co-developed-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/usb/gadget/ci_udc.c | 470 ------------------------------------
 1 file changed, 470 deletions(-)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 4729570c5257..95efa4ae1644 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -84,62 +84,15 @@ static struct usb_endpoint_descriptor ep0_desc = {
 };
 
 static int ci_pullup(struct usb_gadget *gadget, int is_on);
-static int ci_ep_enable(struct usb_ep *ep,
-		const struct usb_endpoint_descriptor *desc);
-static int ci_ep_disable(struct usb_ep *ep);
-static int ci_ep_queue(struct usb_ep *ep,
-		struct usb_request *req, gfp_t gfp_flags);
-static int ci_ep_dequeue(struct usb_ep *ep, struct usb_request *req);
-static struct usb_request *
-ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags);
-static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *_req);
 
 static const struct usb_gadget_ops ci_udc_ops = {
 	.pullup = ci_pullup,
 };
 
-static const struct usb_ep_ops ci_ep_ops = {
-	.enable         = ci_ep_enable,
-	.disable        = ci_ep_disable,
-	.queue          = ci_ep_queue,
-	.dequeue	= ci_ep_dequeue,
-	.alloc_request  = ci_ep_alloc_request,
-	.free_request   = ci_ep_free_request,
-};
-
 __weak void ci_init_after_reset(struct ehci_ctrl *ctrl)
 {
 }
 
-/* Init values for USB endpoints. */
-static const struct usb_ep ci_ep_init[5] = {
-	[0] = {	/* EP 0 */
-		.maxpacket	= 64,
-		.name		= "ep0",
-		.ops		= &ci_ep_ops,
-	},
-	[1] = {
-		.maxpacket	= 512,
-		.name		= "ep1in-bulk",
-		.ops		= &ci_ep_ops,
-	},
-	[2] = {
-		.maxpacket	= 512,
-		.name		= "ep2out-bulk",
-		.ops		= &ci_ep_ops,
-	},
-	[3] = {
-		.maxpacket	= 512,
-		.name		= "ep3in-int",
-		.ops		= &ci_ep_ops,
-	},
-	[4] = {
-		.maxpacket	= 512,
-		.name		= "ep-",
-		.ops		= &ci_ep_ops,
-	},
-};
-
 static struct ci_drv controller = {
 	.gadget	= {
 		.name	= "ci_udc",
@@ -263,76 +216,6 @@ static void ci_invalidate_td(struct ept_queue_item *td)
 	invalidate_dcache_range(start, end);
 }
 
-static struct usb_request *
-ci_ep_alloc_request(struct usb_ep *ep, unsigned int gfp_flags)
-{
-	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
-	int num = -1;
-	struct ci_req *ci_req;
-
-	if (ci_ep->desc)
-		num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-
-	if (num == 0 && controller.ep0_req) {
-		DBG("%s: already got controller.ep0_req = %p\n", __func__, controller.ep0_req);
-		return &controller.ep0_req->req;
-	}
-
-	ci_req = calloc(1, sizeof(*ci_req));
-	if (!ci_req)
-		return NULL;
-
-	INIT_LIST_HEAD(&ci_req->queue);
-
-	if (num == 0)
-		controller.ep0_req = ci_req;
-
-	return &ci_req->req;
-}
-
-static void ci_ep_free_request(struct usb_ep *ep, struct usb_request *req)
-{
-	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
-	struct ci_req *ci_req = container_of(req, struct ci_req, req);
-	int num = -1;
-
-	if (ci_ep->desc)
-		num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-	else
-		DBG("%s: no endpoint %p descriptor\n", __func__, ci_ep);
-
-	if (num == 0) {
-		if (!controller.ep0_req)
-			return;
-		controller.ep0_req = 0;
-	}
-
-	if (ci_req->b_buf)
-		free(ci_req->b_buf);
-	free(ci_req);
-}
-
-static void request_complete(struct usb_ep *ep, struct ci_req *req, int status)
-{
-	if (req->req.status == -EINPROGRESS)
-		req->req.status = status;
-
-	DBG("%s: req %p complete: status %d, actual %u\n",
-	    ep->name, req, req->req.status, req->req.actual);
-
-	req->req.complete(ep, &req->req);
-}
-
-static void request_complete_list(struct usb_ep *ep, struct list_head *list, int status)
-{
-	struct ci_req *req, *tmp_req;
-
-	list_for_each_entry_safe(req, tmp_req, list, queue) {
-		list_del_init(&req->queue);
-		request_complete(ep, req, status);
-	}
-}
-
 static void ep_enable(int num, int in, int maxpacket)
 {
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
@@ -353,145 +236,6 @@ static void ep_enable(int num, int in, int maxpacket)
 	writel(n, &udc->epctrl[num]);
 }
 
-static int ci_ep_enable(struct usb_ep *ep,
-		const struct usb_endpoint_descriptor *desc)
-{
-	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
-	int num, in;
-	num = desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-	in = (desc->bEndpointAddress & USB_DIR_IN) != 0;
-
-	if (ci_ep->desc) {
-		DBG("%s: endpoint num %d in %d already enabled\n", __func__, num, in);
-		return -EBUSY;
-	}
-
-	ci_ep->desc = desc;
-	ep->desc = desc;
-
-	if (num) {
-		int max = get_unaligned_le16(&desc->wMaxPacketSize);
-
-		if ((max > 64) && (controller.gadget.speed == USB_SPEED_FULL))
-			max = 64;
-		if (ep->maxpacket != max) {
-			DBG("%s: from %d to %d\n", __func__,
-			    ep->maxpacket, max);
-			ep->maxpacket = max;
-		}
-	}
-	ep_enable(num, in, ep->maxpacket);
-	DBG("%s: num=%d maxpacket=%d\n", __func__, num, ep->maxpacket);
-	return 0;
-}
-
-static int ep_disable(int num, int in)
-{
-	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
-	unsigned int ep_bit, enable_bit;
-	int err;
-
-	if (in) {
-		ep_bit = EPT_TX(num);
-		enable_bit = CTRL_TXE;
-	} else {
-		ep_bit = EPT_RX(num);
-		enable_bit = CTRL_RXE;
-	}
-
-	/* clear primed buffers */
-	do {
-		writel(ep_bit, &udc->epflush);
-		err = wait_for_bit_le32(&udc->epflush, ep_bit, false, 1000, false);
-		if (err)
-			return err;
-	} while (readl(&udc->epstat) & ep_bit);
-
-	/* clear enable bit */
-	clrbits_le32(&udc->epctrl[num], enable_bit);
-
-	return 0;
-}
-
-static int ci_ep_disable(struct usb_ep *ep)
-{
-	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
-	LIST_HEAD(req_list);
-	int num, in, err;
-
-	if (!ci_ep->desc) {
-		DBG("%s: attempt to disable a not enabled yet endpoint\n", __func__);
-		err = -EBUSY;
-		goto nodesc;
-	}
-
-	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
-
-	list_splice_init(&ci_ep->queue, &req_list);
-	request_complete_list(ep, &req_list, -ESHUTDOWN);
-
-	err = ep_disable(num, in);
-	if (err)
-		return err;
-
-	ci_ep->desc = NULL;
-	err = 0;
-
-nodesc:
-	ep->desc = NULL;
-	ci_ep->req_primed = false;
-	return err;
-}
-
-static int ci_bounce(struct ci_req *ci_req, int in)
-{
-	struct usb_request *req = &ci_req->req;
-	unsigned long addr = (unsigned long)req->buf;
-	unsigned long hwaddr;
-	uint32_t aligned_used_len;
-
-	/* Input buffer address is not aligned. */
-	if (addr & (ARCH_DMA_MINALIGN - 1))
-		goto align;
-
-	/* Input buffer length is not aligned. */
-	if (req->length & (ARCH_DMA_MINALIGN - 1))
-		goto align;
-
-	/* The buffer is well aligned, only flush cache. */
-	ci_req->hw_len = req->length;
-	ci_req->hw_buf = req->buf;
-	goto flush;
-
-align:
-	if (ci_req->b_buf && req->length > ci_req->b_len) {
-		free(ci_req->b_buf);
-		ci_req->b_buf = 0;
-	}
-	if (!ci_req->b_buf) {
-		ci_req->b_len = roundup(req->length, ARCH_DMA_MINALIGN);
-		ci_req->b_buf = memalign(ARCH_DMA_MINALIGN, ci_req->b_len);
-		if (!ci_req->b_buf)
-			return -ENOMEM;
-	}
-	ci_req->hw_len = ci_req->b_len;
-	ci_req->hw_buf = ci_req->b_buf;
-
-	if (in)
-		memcpy(ci_req->hw_buf, req->buf, req->length);
-
-flush:
-	hwaddr = (unsigned long)ci_req->hw_buf;
-	if (!hwaddr)
-		return 0;
-
-	aligned_used_len = roundup(req->length, ARCH_DMA_MINALIGN);
-	flush_dcache_range(hwaddr, hwaddr + aligned_used_len);
-
-	return 0;
-}
-
 static void ci_debounce(struct ci_req *ci_req, int in)
 {
 	struct usb_request *req = &ci_req->req;
@@ -618,77 +362,6 @@ static void ci_ep_submit_next_request(struct ci_ep *ci_ep)
 	writel(bit, &udc->epprime);
 }
 
-static int ci_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
-{
-	struct ci_ep *ci_ep = container_of(_ep, struct ci_ep, ep);
-	struct ci_req *ci_req;
-
-	list_for_each_entry(ci_req, &ci_ep->queue, queue) {
-		if (&ci_req->req == _req)
-			break;
-	}
-
-	if (&ci_req->req != _req) {
-		DBG("%s: ci_req not found in the queue\n", __func__);
-		return -EINVAL;
-	}
-
-	list_del_init(&ci_req->queue);
-
-	if (ci_req->req.status == -EINPROGRESS) {
-		ci_req->req.status = -ECONNRESET;
-		if (ci_req->req.complete)
-			ci_req->req.complete(_ep, _req);
-	}
-
-	return 0;
-}
-
-static int ci_ep_queue(struct usb_ep *ep,
-		struct usb_request *req, gfp_t gfp_flags)
-{
-	struct ci_ep *ci_ep = container_of(ep, struct ci_ep, ep);
-	struct ci_req *ci_req = container_of(req, struct ci_req, req);
-	int in, ret;
-	int __maybe_unused num;
-
-	if (!ci_ep->desc) {
-		DBG("%s: ci_ep->desc == NULL, nothing to do!\n", __func__);
-		return -EINVAL;
-	}
-
-	num = ci_ep->desc->bEndpointAddress & USB_ENDPOINT_NUMBER_MASK;
-	in = (ci_ep->desc->bEndpointAddress & USB_DIR_IN) != 0;
-
-	if (!num && ci_ep->req_primed) {
-		/*
-		 * The flipping of ep0 between IN and OUT relies on
-		 * ci_ep_queue consuming the current IN/OUT setting
-		 * immediately. If this is deferred to a later point when the
-		 * req is pulled out of ci_req->queue, then the IN/OUT setting
-		 * may have been changed since the req was queued, and state
-		 * will get out of sync. This condition doesn't occur today,
-		 * but could if bugs were introduced later, and this error
-		 * check will save a lot of debugging time.
-		 */
-		printf("%s: ep0 transaction already in progress\n", __func__);
-		return -EPROTO;
-	}
-
-	ret = ci_bounce(ci_req, in);
-	if (ret)
-		return ret;
-
-	DBG("ept%d %s pre-queue req %p, buffer %p\n",
-	    num, in ? "in" : "out", ci_req, ci_req->hw_buf);
-	list_add_tail(&ci_req->queue, &ci_ep->queue);
-
-	if (!ci_ep->req_primed)
-		ci_ep_submit_next_request(ci_ep);
-
-	return 0;
-}
-
 static void flip_ep0_direction(void)
 {
 	if (ep0_desc.bEndpointAddress == USB_DIR_IN) {
@@ -1034,149 +707,6 @@ static int ci_pullup(struct usb_gadget *gadget, int is_on)
 	return 0;
 }
 
-static int ci_udc_probe(void)
-{
-	struct ept_queue_head *head;
-	int i;
-
-	const int num = 2 * NUM_ENDPOINTS;
-
-	const int eplist_min_align = 4096;
-	const int eplist_align = roundup(eplist_min_align, ARCH_DMA_MINALIGN);
-	const int eplist_raw_sz = num * sizeof(struct ept_queue_head);
-	const int eplist_sz = roundup(eplist_raw_sz, ARCH_DMA_MINALIGN);
-
-	/* The QH list must be aligned to 4096 bytes. */
-	controller.epts = memalign(eplist_align, eplist_sz);
-	if (!controller.epts)
-		return -ENOMEM;
-	memset(controller.epts, 0, eplist_sz);
-
-	controller.items_mem = memalign(ILIST_ALIGN, ILIST_SZ);
-	if (!controller.items_mem) {
-		free(controller.epts);
-		return -ENOMEM;
-	}
-	memset(controller.items_mem, 0, ILIST_SZ);
-
-	for (i = 0; i < 2 * NUM_ENDPOINTS; i++) {
-		/*
-		 * Configure QH for each endpoint. The structure of the QH list
-		 * is such that each two subsequent fields, N and N+1 where N is
-		 * even, in the QH list represent QH for one endpoint. The Nth
-		 * entry represents OUT configuration and the N+1th entry does
-		 * represent IN configuration of the endpoint.
-		 */
-		head = controller.epts + i;
-		if (i < 2)
-			head->config = CFG_MAX_PKT(EP0_MAX_PACKET_SIZE)
-				| CFG_ZLT | CFG_IOS;
-		else
-			head->config = CFG_MAX_PKT(EP_MAX_PACKET_SIZE)
-				| CFG_ZLT;
-		head->next = TERMINATE;
-		head->info = 0;
-
-		if (i & 1) {
-			ci_flush_qh(i / 2);
-			ci_flush_qtd(i / 2);
-		}
-	}
-
-	INIT_LIST_HEAD(&controller.gadget.ep_list);
-
-	/* Init EP 0 */
-	memcpy(&controller.ep[0].ep, &ci_ep_init[0], sizeof(*ci_ep_init));
-	controller.ep[0].desc = &ep0_desc;
-	INIT_LIST_HEAD(&controller.ep[0].queue);
-	controller.ep[0].req_primed = false;
-	controller.gadget.ep0 = &controller.ep[0].ep;
-	INIT_LIST_HEAD(&controller.gadget.ep0->ep_list);
-
-	/* Init EP 1..3 */
-	for (i = 1; i < 4; i++) {
-		memcpy(&controller.ep[i].ep, &ci_ep_init[i],
-		       sizeof(*ci_ep_init));
-		INIT_LIST_HEAD(&controller.ep[i].queue);
-		controller.ep[i].req_primed = false;
-		list_add_tail(&controller.ep[i].ep.ep_list,
-			      &controller.gadget.ep_list);
-	}
-
-	/* Init EP 4..n */
-	for (i = 4; i < NUM_ENDPOINTS; i++) {
-		memcpy(&controller.ep[i].ep, &ci_ep_init[4],
-		       sizeof(*ci_ep_init));
-		INIT_LIST_HEAD(&controller.ep[i].queue);
-		controller.ep[i].req_primed = false;
-		list_add_tail(&controller.ep[i].ep.ep_list,
-			      &controller.gadget.ep_list);
-	}
-
-	ci_ep_alloc_request(&controller.ep[0].ep, 0);
-	if (!controller.ep0_req) {
-		free(controller.items_mem);
-		free(controller.epts);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-int usb_gadget_register_driver(struct usb_gadget_driver *driver)
-{
-	int ret;
-
-	if (!driver)
-		return -EINVAL;
-	if (!driver->bind || !driver->setup || !driver->disconnect)
-		return -EINVAL;
-
-#if CONFIG_IS_ENABLED(DM_USB)
-	ret = usb_setup_ehci_gadget(&controller.ctrl);
-#else
-	ret = usb_lowlevel_init(0, USB_INIT_DEVICE, (void **)&controller.ctrl);
-#endif
-	if (ret)
-		return ret;
-
-	ret = ci_udc_probe();
-	if (ret) {
-		DBG("udc probe failed, returned %d\n", ret);
-		return ret;
-	}
-
-	ret = driver->bind(&controller.gadget);
-	if (ret) {
-		DBG("driver->bind() returned %d\n", ret);
-		return ret;
-	}
-	controller.driver = driver;
-
-	return 0;
-}
-
-int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
-{
-	udc_disconnect();
-
-	driver->unbind(&controller.gadget);
-	controller.driver = NULL;
-
-	ci_ep_free_request(&controller.ep[0].ep, &controller.ep0_req->req);
-	free(controller.items_mem);
-	free(controller.epts);
-
-#if CONFIG_IS_ENABLED(DM_USB)
-	usb_remove_ehci_gadget(&controller.ctrl);
-#else
-	usb_lowlevel_stop(0);
-	controller.ctrl = NULL;
-#endif
-
-	return 0;
-}
-
 bool dfu_usb_get_reset(void)
 {
 	struct ci_udc *udc = (struct ci_udc *)controller.ctrl->hcor;
-- 
2.53.0

