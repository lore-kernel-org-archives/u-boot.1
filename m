Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41375C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 06:38:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE48587546;
	Sun, 29 Oct 2023 07:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="jciAA1Jm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B98C871E8; Sun, 29 Oct 2023 07:38:38 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C9528723E
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 2959E4268B;
 Sun, 29 Oct 2023 06:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698561514; bh=sMQh7bVawXy0WhD2dNbG6eMTmPg5iywzeluiqHfUanU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jciAA1JmdGdhP9JYRDTIjine8atkXbUEiyLvmK+no0mKAjXWmRZDi/A6qH0DcrArn
 6cy0xovmKaXF47vB5/uAA0hv9X+xOECht5/m2tZU93YnShkdCUF1mgNExDv6NgN2l0
 fwLpzd2BmYOHbXBEz2xNGUV5nAvJDlq6kiCt33M23RurTQFHcbY51vdN1YBMPtYlzy
 eom2sWhCXD3hmk9XAZUohTE9Sb9tns1F/6Dj2V8/yLn+ZMJcOAE8zc+g2xqOZxz3pS
 BMNiuCxY/aWh5n+obEjxNDRCUDmlzWqImGuFkUrv6MqsyRbZD19gpjAY9LnNB+X4gG
 d7IFtKLyo5bUA==
From: Hector Martin <marcan@marcan.st>
Date: Sun, 29 Oct 2023 15:37:38 +0900
Subject: [PATCH v2 1/8] usb: xhci: Guard all calls to xhci_wait_for_event
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-usb-fixes-1-v2-1-623533f6316e@marcan.st>
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
In-Reply-To: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3992; i=marcan@marcan.st;
 h=from:subject:message-id; bh=sMQh7bVawXy0WhD2dNbG6eMTmPg5iywzeluiqHfUanU=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlTbv3fais4depx9xPB46IEnn3QnlW3Y/e3rwoNah5+Gp
 83ZoT6/rKOUhUGMg0FWTJGl8UTvqW7P6efUVVOmw8xhZQIZwsDFKQAT8fnD8FfKSGKN8ckpq3y/
 +3IfCJtSNy/uwNTzCu5PJXout7Apps1jZFh76bjqzZ1KkcuZ/913FGN5uy1J6dKkqw1tgq+l5/N
 pP2YDAA==
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

xhci_wait_for_event returns NULL on timeout, so the caller always has to
check for that. This addresses immediate explosions in this part
of the code when timeouts happen, but not the root cause for the
timeout.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 15 +++++++++++++++
 drivers/usb/host/xhci.c      |  9 +++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index c8260cbdf94b..d0960812a47b 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -511,6 +511,9 @@ static void reset_ep(struct usb_device *udev, int ep_index)
 	printf("Resetting EP %d...\n", ep_index);
 	xhci_queue_command(ctrl, 0, udev->slot_id, ep_index, TRB_RESET_EP);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	if (!event)
+		return;
+
 	field = le32_to_cpu(event->trans_event.flags);
 	BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
 	xhci_acknowledge_event(ctrl);
@@ -519,6 +522,9 @@ static void reset_ep(struct usb_device *udev, int ep_index)
 		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));
 	xhci_queue_command(ctrl, addr, udev->slot_id, ep_index, TRB_SET_DEQ);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	if (!event)
+		return;
+
 	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
 		!= udev->slot_id || GET_COMP_CODE(le32_to_cpu(
 		event->event_cmd.status)) != COMP_SUCCESS);
@@ -544,6 +550,9 @@ static void abort_td(struct usb_device *udev, int ep_index)
 	xhci_queue_command(ctrl, 0, udev->slot_id, ep_index, TRB_STOP_RING);
 
 	event = xhci_wait_for_event(ctrl, TRB_TRANSFER);
+	if (!event)
+		return;
+
 	field = le32_to_cpu(event->trans_event.flags);
 	BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
 	BUG_ON(TRB_TO_EP_INDEX(field) != ep_index);
@@ -552,6 +561,9 @@ static void abort_td(struct usb_device *udev, int ep_index)
 	xhci_acknowledge_event(ctrl);
 
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	if (!event)
+		return;
+
 	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
 		!= udev->slot_id || GET_COMP_CODE(le32_to_cpu(
 		event->event_cmd.status)) != COMP_SUCCESS);
@@ -561,6 +573,9 @@ static void abort_td(struct usb_device *udev, int ep_index)
 		(void *)((uintptr_t)ring->enqueue | ring->cycle_state));
 	xhci_queue_command(ctrl, addr, udev->slot_id, ep_index, TRB_SET_DEQ);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	if (!event)
+		return;
+
 	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
 		!= udev->slot_id || GET_COMP_CODE(le32_to_cpu(
 		event->event_cmd.status)) != COMP_SUCCESS);
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 5cacf0769ec7..d13cbff9b372 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -451,6 +451,9 @@ static int xhci_configure_endpoints(struct usb_device *udev, bool ctx_change)
 	xhci_queue_command(ctrl, in_ctx->dma, udev->slot_id, 0,
 			   ctx_change ? TRB_EVAL_CONTEXT : TRB_CONFIG_EP);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	if (!event)
+		return -ETIMEDOUT;
+
 	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
 		!= udev->slot_id);
 
@@ -647,6 +650,9 @@ static int xhci_address_device(struct usb_device *udev, int root_portnr)
 	xhci_queue_command(ctrl, virt_dev->in_ctx->dma,
 			   slot_id, 0, TRB_ADDR_DEV);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	if (!event)
+		return -ETIMEDOUT;
+
 	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags)) != slot_id);
 
 	switch (GET_COMP_CODE(le32_to_cpu(event->event_cmd.status))) {
@@ -722,6 +728,9 @@ static int _xhci_alloc_device(struct usb_device *udev)
 
 	xhci_queue_command(ctrl, 0, 0, 0, TRB_ENABLE_SLOT);
 	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+	if (!event)
+		return -ETIMEDOUT;
+
 	BUG_ON(GET_COMP_CODE(le32_to_cpu(event->event_cmd.status))
 		!= COMP_SUCCESS);
 

-- 
2.41.0

