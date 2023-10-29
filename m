Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C35CC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 06:40:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5233787555;
	Sun, 29 Oct 2023 07:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="wY89B0hG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AACDA87739; Sun, 29 Oct 2023 07:38:53 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CACD187258
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:38:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 7992D42699;
 Sun, 29 Oct 2023 06:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698561531; bh=FG1JkDzGbCUxaDoCxOVb1Tj7GDoWE6jnrmiEM/52LS8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=wY89B0hGZR1xkrWYRr9Qb23Gd+TOr1JSdEbNHw7tfN0gbN8mb3OCF3Nvbu8uIZXtF
 gUok9cRutjZiKltAPbbE+XZWYcAWVsS8cZZI25dZMEQYIx1YxOIh4nAFq9Mu8zhVrv
 ohiHFKlLyFZB//Zr0NMUdc2USg4A/MYb7Pm/8esLm7dUnw5f74Vn8j0mKVXzyxu8M/
 Fxc6Rw5cc2IS2vPE+yq+yxMYHCKLnSPpQ+sFLia78Rbpw6Ron0TqvD+R+Zw7Vpxfmj
 7CTqMb5t/u8gNGtcQ80CUHSe0rEZCWrFBlqmNDPv89JwJear062JJxnAQq2I6FV0GF
 SYoB1RiBYoROQ==
From: Hector Martin <marcan@marcan.st>
Date: Sun, 29 Oct 2023 15:37:45 +0900
Subject: [PATCH v2 8/8] usb: xhci: Add more debugging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-usb-fixes-1-v2-8-623533f6316e@marcan.st>
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
In-Reply-To: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3768; i=marcan@marcan.st;
 h=from:subject:message-id; bh=FG1JkDzGbCUxaDoCxOVb1Tj7GDoWE6jnrmiEM/52LS8=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlTbv09udy7h+1qVk2diYDKXSTDUMO7Rk+OTjKZe/mglo
 WNxSiW7o5SFQYyDQVZMkaXxRO+pbs/p59RVU6bDzGFlAhnCwMUpABNp2MnIMHXpSzklw/fBtjk/
 NM2rX5k9FVsy5/EKq967Kezb90TsTGFk+OdsMe38p6KVXjvjGx5/yV1Rt4rp/bKvKpGr1BfPnv0
 6jhEA
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

A bunch of miscellaneous debug messages to aid in working out USB
issues.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index b60661fe05e7..dabe6cf86af2 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -214,6 +214,9 @@ static dma_addr_t queue_trb(struct xhci_ctrl *ctrl, struct xhci_ring *ring,
 
 	addr = xhci_trb_virt_to_dma(ring->enq_seg, (union xhci_trb *)trb);
 
+	debug("trb @ %llx: %08x %08x %08x %08x\n", addr,
+	      trb_fields[0], trb_fields[1], trb_fields[2], trb_fields[3]);
+
 	inc_enq(ctrl, ring, more_trbs_coming);
 
 	return addr;
@@ -296,6 +299,8 @@ void xhci_queue_command(struct xhci_ctrl *ctrl, dma_addr_t addr, u32 slot_id,
 {
 	u32 fields[4];
 
+	debug("CMD: %llx 0x%x 0x%x %d\n", addr, slot_id, ep_index, cmd);
+
 	BUG_ON(prepare_ring(ctrl, ctrl->cmd_ring, EP_STATE_RUNNING));
 
 	fields[0] = lower_32_bits(addr);
@@ -471,8 +476,14 @@ union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected)
 
 		type = TRB_FIELD_TO_TYPE(le32_to_cpu(event->event_cmd.flags));
 		if (type == expected ||
-		    (expected == TRB_NONE && type != TRB_PORT_STATUS))
+		    (expected == TRB_NONE && type != TRB_PORT_STATUS)) {
+			debug("Event: %08x %08x %08x %08x\n",
+			      le32_to_cpu(event->generic.field[0]),
+			      le32_to_cpu(event->generic.field[1]),
+			      le32_to_cpu(event->generic.field[2]),
+			      le32_to_cpu(event->generic.field[3]));
 			return event;
+		}
 
 		if (type == TRB_PORT_STATUS)
 		/* TODO: remove this once enumeration has been reworked */
@@ -484,8 +495,9 @@ union xhci_trb *xhci_wait_for_event(struct xhci_ctrl *ctrl, trb_type expected)
 				le32_to_cpu(event->generic.field[2])) !=
 								COMP_SUCCESS);
 		else
-			printf("Unexpected XHCI event TRB, skipping... "
+			printf("Unexpected XHCI event TRB, expected %d... "
 				"(%08x %08x %08x %08x)\n",
+				expected,
 				le32_to_cpu(event->generic.field[0]),
 				le32_to_cpu(event->generic.field[1]),
 				le32_to_cpu(event->generic.field[2]),
@@ -602,10 +614,13 @@ static void abort_td(struct usb_device *udev, int ep_index)
 static void record_transfer_result(struct usb_device *udev,
 				   union xhci_trb *event, int length)
 {
+	xhci_comp_code code = GET_COMP_CODE(
+		le32_to_cpu(event->trans_event.transfer_len));
+
 	udev->act_len = min(length, length -
 		(int)EVENT_TRB_LEN(le32_to_cpu(event->trans_event.transfer_len)));
 
-	switch (GET_COMP_CODE(le32_to_cpu(event->trans_event.transfer_len))) {
+	switch (code) {
 	case COMP_SUCCESS:
 		BUG_ON(udev->act_len != length);
 		/* fallthrough */
@@ -613,16 +628,23 @@ static void record_transfer_result(struct usb_device *udev,
 		udev->status = 0;
 		break;
 	case COMP_STALL:
+		debug("Xfer STALL\n");
 		udev->status = USB_ST_STALLED;
 		break;
 	case COMP_DB_ERR:
+		debug("Xfer DB_ERR\n");
+		udev->status = USB_ST_BUF_ERR;
+		break;
 	case COMP_TRB_ERR:
+		debug("Xfer TRB_ERR\n");
 		udev->status = USB_ST_BUF_ERR;
 		break;
 	case COMP_BABBLE:
+		debug("Xfer BABBLE\n");
 		udev->status = USB_ST_BABBLE_DET;
 		break;
 	default:
+		debug("Xfer error: %d\n", code);
 		udev->status = 0x80;  /* USB_ST_TOO_LAZY_TO_MAKE_A_NEW_MACRO */
 	}
 }
@@ -1016,6 +1038,7 @@ int xhci_ctrl_tx(struct usb_device *udev, unsigned long pipe,
 	record_transfer_result(udev, event, length);
 	xhci_acknowledge_event(ctrl);
 	if (udev->status == USB_ST_STALLED) {
+		debug("EP %d stalled\n", ep_index);
 		reset_ep(udev, ep_index);
 		return -EPIPE;
 	}

-- 
2.41.0

