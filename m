Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA7CC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 23:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEAC787BC7;
	Fri, 27 Oct 2023 01:17:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="JZqeDi2g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4435187BBF; Fri, 27 Oct 2023 01:17:03 +0200 (CEST)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0522875EF
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 01:16:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 7DEEB424B9;
 Thu, 26 Oct 2023 23:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698362219; bh=Br9wFmlNBg8ir+FsQ/tmMKKokWn7/PWaVri1jUGtlik=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JZqeDi2guCLSMOYwEke9WW0HxOHU6Zh/HTnV8Xr++TfVHtKm7KONMsOthsS8RncYA
 dQKFvImcCJWnfRN++ZkdJ09tUKk4Z8bEOV1MdtIfXyIkb4NJ4xEsKrKu8yAOgc3kj/
 9yMQWshvM9iOUX/OuPPchLtBvDnTj7ad4s9qKHcD64RdluU6XU1qLwXqxYVW/d/OAr
 kG3hhhmWKap90XUHn0OgDDDa8a0jXWua4mDOupmB6OcyxXpwZAKJfB8BatYx59EQhP
 5O/wEE1Z4O7c8EU+e99psTFuwOovhIIIb4hd0bIknMb0oJYQZVmMmUnNLhEBF4+lk/
 k9MyswdmQS0bg==
From: Hector Martin <marcan@marcan.st>
Date: Fri, 27 Oct 2023 08:16:45 +0900
Subject: [PATCH 2/8] usb: xhci: Better error handling in abort_td()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-usb-fixes-1-v1-2-1c879bbcd928@marcan.st>
References: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
In-Reply-To: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3276; i=marcan@marcan.st;
 h=from:subject:message-id; bh=Br9wFmlNBg8ir+FsQ/tmMKKokWn7/PWaVri1jUGtlik=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlSrzwlfs7jmVto05t4+62YgtjbcPt2oxOjH5rTJlvl5X
 a/zuF06SlkYxDgYZMUUWRpP9J7q9px+Tl01ZTrMHFYmkCEMXJwCMBGP74wMa1/afVHuTL4/T212
 L7/Cvw03Qp7MnOqYUvAze/UFppojKYwMr9vlM9bo2C8t7NufFWcosP9S1cqjnIF5Fy6FOlgE89i
 zAAA=
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

Right now we still BUG() on the error code, but at least we don't end up
timing out on the event and ending up with unexpected event errors.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 34 ++++++++++++++++++++++------------
 include/usb/xhci.h           |  2 ++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index aaf128ff9317..d08bb8e2bfba 100644
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
@@ -542,27 +543,36 @@ static void abort_td(struct usb_device *udev, int ep_index)
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

