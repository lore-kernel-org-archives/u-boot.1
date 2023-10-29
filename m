Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCE3C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 06:39:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9DA8755C;
	Sun, 29 Oct 2023 07:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="o829k8iC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF34B871E8; Sun, 29 Oct 2023 07:38:38 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF67D87546
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 9D1BD42699;
 Sun, 29 Oct 2023 06:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698561516; bh=GHn3v5LlOeMlC6cj+xN5ckRq+X6ZOTSSgSh4Uz7JtTw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=o829k8iCPBaIwiyYqbh5rgWzOtWWjMgBUy5IvyxF20LxZDJeaOv6oOkphIV0Y9Wms
 JO2a8bJ8B9+tzed3TqN0NywNd+wJbYnAUQZDFe38ASDep4dpWzQktdWEzMEZhWW7rZ
 sKB/CoQBaLQkv0l9jLLn91J8Q2JFVwo1zPcPSnKwIR6xNuyg5YOo2nwnMkK2Euvl2e
 ACSUrkhTgQs9dqHh9NUtxQ/RaKjodRikLVCfd5BrZt0CeXP0W/DYJqs7iSSSf/OVGA
 6ot5TSvEBUKmCCpswuAa34XHdk7xJcAd0kTpFHLBYXFQRNwWT7k7EwFaXI5TIKs5Hm
 HMMyxCw3b6zuQ==
From: Hector Martin <marcan@marcan.st>
Date: Sun, 29 Oct 2023 15:37:39 +0900
Subject: [PATCH v2 2/8] usb: xhci: Better error handling in abort_td()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-usb-fixes-1-v2-2-623533f6316e@marcan.st>
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
In-Reply-To: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3266; i=marcan@marcan.st;
 h=from:subject:message-id; bh=GHn3v5LlOeMlC6cj+xN5ckRq+X6ZOTSSgSh4Uz7JtTw=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlTbv3eZjQJCf1+yymt886ls89r7Fh+701NfZddN2bPwV
 znruwl9HaUsDGIcDLJiiiyNJ3pPdXtOP6eumjIdZg4rE8gQBi5OAZiI20aGP5xF664sWizAdp2J
 dYujXou0tb3xN8GvVovf/mBu2Lf/3ClGhpkvX75hzSjJk/+u2jLfpE4o26Bx4aQJSSV6wu98X2Q
 YMAMA
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

If the xHC has a problem with our STOP ENDPOINT command, it is likely to
return a completion directly instead of first a transfer event for the
in-progress transfer. Handle that more gracefully.

We still BUG() on the error code, but at least we don't end up timing
out on the event and ending up with unexpected event errors.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 34 ++++++++++++++++++++++------------
 include/usb/xhci.h           |  2 ++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index d0960812a47b..d21e76e0bdb6 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -466,7 +466,8 @@ union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected)
 			continue;
 
 		type = TRB_FIELD_TO_TYPE(le32_to_cpu(event->event_cmd.flags));
-		if (type == expected)
+		if (type == expected ||
+		    (expected == TRB_NONE && type != TRB_PORT_STATUS))
 			return event;
 
 		if (type == TRB_PORT_STATUS)
@@ -544,27 +545,36 @@ static void abort_td(struct usb_device *udev, int ep_index)
 	struct xhci_ctrl *ctrl = xhci_get_ctrl(udev);
 	struct xhci_ring *ring =  ctrl->devs[udev->slot_id]->eps[ep_index].ring;
 	union xhci_trb *event;
+	trb_type type;
 	u64 addr;
 	u32 field;
 
 	xhci_queue_command(ctrl, 0, udev->slot_id, ep_index, TRB_STOP_RING);
 
-	event = xhci_wait_for_event(ctrl, TRB_TRANSFER);
+	event = xhci_wait_for_event(ctrl, TRB_NONE);
 	if (!event)
 		return;
 
-	field = le32_to_cpu(event->trans_event.flags);
-	BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
-	BUG_ON(TRB_TO_EP_INDEX(field) != ep_index);
-	BUG_ON(GET_COMP_CODE(le32_to_cpu(event->trans_event.transfer_len
-		!= COMP_STOP)));
-	xhci_acknowledge_event(ctrl);
+	type = TRB_FIELD_TO_TYPE(le32_to_cpu(event->event_cmd.flags));
+	if (type == TRB_TRANSFER) {
+		field = le32_to_cpu(event->trans_event.flags);
+		BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
+		BUG_ON(TRB_TO_EP_INDEX(field) != ep_index);
+		BUG_ON(GET_COMP_CODE(le32_to_cpu(event->trans_event.transfer_len
+			!= COMP_STOP)));
+		xhci_acknowledge_event(ctrl);
 
-	event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
-	if (!event)
-		return;
+		event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
+		if (!event)
+			return;
+		type = TRB_FIELD_TO_TYPE(le32_to_cpu(event->event_cmd.flags));
 
-	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
+	} else {
+		printf("abort_td: Expected a TRB_TRANSFER TRB first\n");
+	}
+
+	BUG_ON(type != TRB_COMPLETION ||
+		TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
 		!= udev->slot_id || GET_COMP_CODE(le32_to_cpu(
 		event->event_cmd.status)) != COMP_SUCCESS);
 	xhci_acknowledge_event(ctrl);
diff --git a/include/usb/xhci.h b/include/usb/xhci.h
index 4a4ac10229ac..04d16a256bbd 100644
--- a/include/usb/xhci.h
+++ b/include/usb/xhci.h
@@ -901,6 +901,8 @@ union xhci_trb {
 
 /* TRB type IDs */
 typedef enum {
+	/* reserved, used as a software sentinel */
+	TRB_NONE = 0,
 	/* bulk, interrupt, isoc scatter/gather, and control data stage */
 	TRB_NORMAL = 1,
 	/* setup stage for control transfers */

-- 
2.41.0

