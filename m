Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C089C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 07:36:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E4CE874BD;
	Sun, 29 Oct 2023 08:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="Ece6GUJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D1F987021; Sun, 29 Oct 2023 08:36:37 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66953870BF
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 08:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 158884268B;
 Sun, 29 Oct 2023 07:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698564994; bh=0asVBE0Sq2ta+eBmg3bBMjaB8alg8GHg/qNGDGecOsM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Ece6GUJQDlTfJCiVhbtTR7lV4j2bBOYtupImVbfqZadV0z3oNquK4ClmoUMOUryD5
 7hZ3vEu38Dci+es+P5GnN2ywehBleFmcwKjM97oAZfHw4YyZ0EDif7sSOJaHFWfpqK
 cdZjak6NvG2YSk5T486CQsTlK80xn4am809TRO3AhJYODurCS8IPbFtTquPqPwGmj6
 8QiAVPU1KmLYC4ye8/ASdmYFbHZqTeZW3STW9dg3qw6HcxmRYgik7QrbtUriUsVUWG
 xFZsqUeeHYYAr2zU8XR5lSSsJflHLV7pShSUca74dnewMoXKEKg8IQgNhYvCwqi8pn
 470xtXJJ7ie7g==
From: Hector Martin <marcan@marcan.st>
Date: Sun, 29 Oct 2023 16:36:17 +0900
Subject: [PATCH 2/2] usb: xhci: Hook up timeouts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-usb-fixes-5-v1-2-54bb13001f54@marcan.st>
References: <20231029-usb-fixes-5-v1-0-54bb13001f54@marcan.st>
In-Reply-To: <20231029-usb-fixes-5-v1-0-54bb13001f54@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11216; i=marcan@marcan.st;
 h=from:subject:message-id; bh=0asVBE0Sq2ta+eBmg3bBMjaB8alg8GHg/qNGDGecOsM=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlQ77qr9wt1KG3zit0cppGurt5WIevz6lf7utLFZusrmw
 7KOP6I6SlkYxDgYZMUUWRpP9J7q9px+Tl01ZTrMHFYmkCEMXJwCMBH3fkaGpcYdcQ/qZZq/ta2J
 LFFzEQjsibJr3HZ8XsdHmZltJlKSjAyflefbK195sm2dispu8eM/l6yozWzZYNfx8Mf62a4P59v
 wAQA=
X-Developer-Key: i=marcan@marcan.st; a=openpgp;
 fpr=FC18F00317968B7BE86201CBE22A629A4C515DD5
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

Now that the USB core passes through timeout info to the host
controller, actually hook it up.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 32 ++++++++++++++++++++------------
 drivers/usb/host/xhci.c      | 23 +++++++++++++----------
 include/usb/xhci.h           | 14 ++++++++++----
 3 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index dabe6cf86af2..14c0c60e8524 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -463,11 +463,16 @@ static int event_ready(struct xhci_ctrl *ctrl)
  * @param expected	TRB type expected from Event TRB
  * Return: pointer to event trb
  */
-union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected)
+union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected,
+				    int timeout)
 {
 	trb_type type;
 	unsigned long ts = get_timer(0);
 
+	/* Fallback in case someone passes in 0 */
+	if (!timeout)
+		timeout = XHCI_TIMEOUT;
+
 	do {
 		union xhci_trb *event = ctrl->event_ring->dequeue;
 
@@ -504,7 +509,7 @@ union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected)
 				le32_to_cpu(event->generic.field[3]));
 
 		xhci_acknowledge_event(ctrl);
-	} while (get_timer(ts) < XHCI_TIMEOUT);
+	} while (get_timer(ts) < timeout);
 
 	if (expected == TRB_TRANSFER)
 		return NULL;
@@ -528,7 +533,7 @@ static void reset_ep(struct usb_device *udev, int ep_index)
 
 	printf("Resetting EP %d...\n", ep_index);
 	xhci_queue_command(ctrl, 0, udev->slot_id, ep_index, TRB_RESET_EP);
-	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	event = xhci_wait_for_event(ctrl, TRB_COMPLETION, XHCI_SYS_TIMEOUT);
 	if (!event)
 		return;
 
@@ -539,7 +544,7 @@ static void reset_ep(struct usb_device *udev, int ep_index)
 	addr = xhci_trb_virt_to_dma(ring->enq_seg,
 		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));
 	xhci_queue_command(ctrl, addr, udev->slot_id, ep_index, TRB_SET_DEQ);
-	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	event = xhci_wait_for_event(ctrl, TRB_COMPLETION, XHCI_SYS_TIMEOUT);
 	if (!event)
 		return;
 
@@ -569,7 +574,7 @@ static void abort_td(struct usb_device *udev, int ep_index)
 
 	xhci_queue_command(ctrl, 0, udev->slot_id, ep_index, TRB_STOP_RING);
 
-	event = xhci_wait_for_event(ctrl, TRB_NONE);
+	event = xhci_wait_for_event(ctrl, TRB_NONE, XHCI_SYS_TIMEOUT);
 	if (!event)
 		return;
 
@@ -582,7 +587,8 @@ static void abort_td(struct usb_device *udev, int ep_index)
 			!= COMP_STOP)));
 		xhci_acknowledge_event(ctrl);
 
-		event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+		event = xhci_wait_for_event(ctrl, TRB_COMPLETION,
+					    XHCI_SYS_TIMEOUT);
 		if (!event)
 			return;
 		type = TRB_FIELD_TO_TYPE(le32_to_cpu(event->event_cmd.flags));
@@ -601,7 +607,7 @@ static void abort_td(struct usb_device *udev, int ep_index)
 	addr = xhci_trb_virt_to_dma(ring->enq_seg,
 		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));
 	xhci_queue_command(ctrl, addr, udev->slot_id, ep_index, TRB_SET_DEQ);
-	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	event = xhci_wait_for_event(ctrl, TRB_COMPLETION, XHCI_SYS_TIMEOUT);
 	if (!event)
 		return;
 
@@ -657,10 +663,11 @@ static void record_transfer_result(struct usb_device *udev,
  * @param pipe		contains the DIR_IN or OUT , devnum
  * @param length	length of the buffer
  * @param buffer	buffer to be read/written based on the request
+ * @param timeout	timeout in milliseconds
  * Return: returns 0 if successful else -1 on failure
  */
 int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
-			int length, void *buffer)
+			int length, void *buffer, int timeout)
 {
 	int num_trbs = 0;
 	struct xhci_generic_trb *start_trb;
@@ -825,7 +832,7 @@ int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
 	giveback_first_trb(udev, ep_index, start_cycle, start_trb);
 
 again:
-	event = xhci_wait_for_event(ctrl, TRB_TRANSFER);
+	event = xhci_wait_for_event(ctrl, TRB_TRANSFER, timeout);
 	if (!event) {
 		debug("XHCI bulk transfer timed out, aborting...\n");
 		abort_td(udev, ep_index);
@@ -862,11 +869,12 @@ again:
  * @param req		request type
  * @param length	length of the buffer
  * @param buffer	buffer to be read/written based on the request
+ * @param timeout	timeout in milliseconds
  * Return: returns 0 if successful else error code on failure
  */
 int xhci_ctrl_tx(struct usb_device *udev, unsigned long pipe,
 			struct devrequest *req,	int length,
-			void *buffer)
+			void *buffer, int timeout)
 {
 	int ret;
 	int start_cycle;
@@ -1027,7 +1035,7 @@ int xhci_ctrl_tx(struct usb_device *udev, unsigned long pipe,
 
 	giveback_first_trb(udev, ep_index, start_cycle, start_trb);
 
-	event = xhci_wait_for_event(ctrl, TRB_TRANSFER);
+	event = xhci_wait_for_event(ctrl, TRB_TRANSFER, timeout);
 	if (!event)
 		goto abort;
 	field = le32_to_cpu(event->trans_event.flags);
@@ -1052,7 +1060,7 @@ int xhci_ctrl_tx(struct usb_device *udev, unsigned long pipe,
 	if (GET_COMP_CODE(le32_to_cpu(event->trans_event.transfer_len))
 			== COMP_SHORT_TX) {
 		/* Short data stage, clear up additional status stage event */
-		event = xhci_wait_for_event(ctrl, TRB_TRANSFER);
+		event = xhci_wait_for_event(ctrl, TRB_TRANSFER, XHCI_SYS_TIMEOUT);
 		if (!event)
 			goto abort;
 		BUG_ON(TRB_TO_SLOT_ID(field) != slot_id);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index a33a2460f74d..1c4afdf385f7 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -450,7 +450,7 @@ static int xhci_configure_endpoints(struct usb_device *udev, bool ctx_change)
 	xhci_flush_cache((uintptr_t)in_ctx->bytes, in_ctx->size);
 	xhci_queue_command(ctrl, in_ctx->dma, udev->slot_id, 0,
 			   ctx_change ? TRB_EVAL_CONTEXT : TRB_CONFIG_EP);
-	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	event = xhci_wait_for_event(ctrl, TRB_COMPLETION, XHCI_SYS_TIMEOUT);
 	if (!event)
 		return -ETIMEDOUT;
 
@@ -649,7 +649,7 @@ static int xhci_address_device(struct usb_device *udev, int root_portnr)
 
 	xhci_queue_command(ctrl, virt_dev->in_ctx->dma,
 			   slot_id, 0, TRB_ADDR_DEV);
-	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	event = xhci_wait_for_event(ctrl, TRB_COMPLETION, XHCI_SYS_TIMEOUT);
 	if (!event)
 		return -ETIMEDOUT;
 
@@ -727,7 +727,7 @@ static int _xhci_alloc_device(struct usb_device *udev)
 	}
 
 	xhci_queue_command(ctrl, 0, 0, 0, TRB_ENABLE_SLOT);
-	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	event = xhci_wait_for_event(ctrl, TRB_COMPLETION, XHCI_SYS_TIMEOUT);
 	if (!event)
 		return -ETIMEDOUT;
 
@@ -1125,7 +1125,7 @@ static int _xhci_submit_int_msg(struct usb_device *udev, unsigned long pipe,
 	 * (at most) one TD. A TD (comprised of sg list entries) can
 	 * take several service intervals to transmit.
 	 */
-	return xhci_bulk_tx(udev, pipe, length, buffer);
+	return xhci_bulk_tx(udev, pipe, length, buffer, XHCI_INT_TIMEOUT);
 }
 
 /**
@@ -1135,17 +1135,18 @@ static int _xhci_submit_int_msg(struct usb_device *udev, unsigned long pipe,
  * @param pipe		contains the DIR_IN or OUT , devnum
  * @param buffer	buffer to be read/written based on the request
  * @param length	length of the buffer
+ * @param timeout	timeout in milliseconds
  * Return: returns 0 if successful else -1 on failure
  */
 static int _xhci_submit_bulk_msg(struct usb_device *udev, unsigned long pipe,
-				 void *buffer, int length)
+				 void *buffer, int length, int timeout)
 {
 	if (usb_pipetype(pipe) != PIPE_BULK) {
 		printf("non-bulk pipe (type=%lu)", usb_pipetype(pipe));
 		return -EINVAL;
 	}
 
-	return xhci_bulk_tx(udev, pipe, length, buffer);
+	return xhci_bulk_tx(udev, pipe, length, buffer, timeout);
 }
 
 /**
@@ -1157,11 +1158,13 @@ static int _xhci_submit_bulk_msg(struct usb_device *udev, unsigned long pipe,
  * @param length	length of the buffer
  * @param setup		Request type
  * @param root_portnr	Root port number that this device is on
+ * @param timeout	timeout in milliseconds
  * Return: returns 0 if successful else -1 on failure
  */
 static int _xhci_submit_control_msg(struct usb_device *udev, unsigned long pipe,
 				    void *buffer, int length,
-				    struct devrequest *setup, int root_portnr)
+				    struct devrequest *setup, int root_portnr,
+				    int timeout)
 {
 	struct xhci_ctrl *ctrl = xhci_get_ctrl(udev);
 	int ret = 0;
@@ -1187,7 +1190,7 @@ static int _xhci_submit_control_msg(struct usb_device *udev, unsigned long pipe,
 		}
 	}
 
-	return xhci_ctrl_tx(udev, pipe, setup, length, buffer);
+	return xhci_ctrl_tx(udev, pipe, setup, length, buffer, timeout);
 }
 
 static int xhci_lowlevel_init(struct xhci_ctrl *ctrl)
@@ -1290,7 +1293,7 @@ static int xhci_submit_control_msg(struct udevice *dev, struct usb_device *udev,
 			hop = hop->parent;
 */
 	return _xhci_submit_control_msg(udev, pipe, buffer, length, setup,
-					root_portnr);
+					root_portnr, timeout);
 }
 
 static int xhci_submit_bulk_msg(struct udevice *dev, struct usb_device *udev,
@@ -1298,7 +1301,7 @@ static int xhci_submit_bulk_msg(struct udevice *dev, struct usb_device *udev,
 				int timeout)
 {
 	debug("%s: dev='%s', udev=%p\n", __func__, dev->name, udev);
-	return _xhci_submit_bulk_msg(udev, pipe, buffer, length);
+	return _xhci_submit_bulk_msg(udev, pipe, buffer, length, timeout);
 }
 
 static int xhci_submit_int_msg(struct udevice *dev, struct usb_device *udev,
diff --git a/include/usb/xhci.h b/include/usb/xhci.h
index 04d16a256bbd..02660803fdcf 100644
--- a/include/usb/xhci.h
+++ b/include/usb/xhci.h
@@ -27,7 +27,11 @@
 #define MAX_EP_CTX_NUM		31
 #define XHCI_ALIGNMENT		64
 /* Generic timeout for XHCI events */
-#define XHCI_TIMEOUT		5000
+#define XHCI_TIMEOUT		1000
+/* Timeout for interrupt messages */
+#define XHCI_INT_TIMEOUT	1000
+/* Timeout for system commands */
+#define XHCI_SYS_TIMEOUT	200
 /* Max number of USB devices for any host controller - limit in section 6.1 */
 #define MAX_HC_SLOTS            256
 /* Section 5.3.3 - MaxPorts */
@@ -1258,11 +1262,13 @@ void xhci_setup_addressable_virt_dev(struct xhci_ctrl *ctrl,
 void xhci_queue_command(struct xhci_ctrl *ctrl, dma_addr_t addr,
 			u32 slot_id, u32 ep_index, trb_type cmd);
 void xhci_acknowledge_event(struct xhci_ctrl *ctrl);
-union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected);
+union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected,
+				    int timeout);
 int xhci_bulk_tx(struct usb_device *udev, unsigned long pipe,
-		 int length, void *buffer);
+		 int length, void *buffer, int timeout);
 int xhci_ctrl_tx(struct usb_device *udev, unsigned long pipe,
-		 struct devrequest *req, int length, void *buffer);
+		 struct devrequest *req, int length, void *buffer,
+		 int timeout);
 int xhci_check_maxpacket(struct usb_device *udev);
 void xhci_flush_cache(uintptr_t addr, u32 type_len);
 void xhci_inval_cache(uintptr_t addr, u32 type_len);

-- 
2.41.0

