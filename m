Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFC7C61D99
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 23:51:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3D9E87666;
	Thu, 23 Nov 2023 00:51:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1700697076;
	bh=edY9BOYGauJ1gWmLEkCvcNNfMZ1kPB7ukS40z1LWlAQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Cw0UpN7mc4e436fmKj3h8mmxQxgKb7DTSEtJCYLlXHwjol6DQ9NSX35443lLgjFvY
	 rreg0+MzmUwX5cfmUMq3Agq9xDg9yYDhXzN6QYxqFR/+T6PuIi8XWBOqm41zMFaZvx
	 XtepGD0vrqCBOrXsfSI8cJbJUi+nmij0Wj6b/qo09Kz962AO08eW4StKhmY6GEFjYH
	 jVPGwH887cSgjNdYzVTPS7Z1wDIvAF2wXeNnxZ0ewO0xDTnGqesBnGxABrpk2s3SDj
	 C2dRkzkwj09mnFzLSAyY83yjY6wAru1S2h74leBb3wH+R4DIG9g+gYv0MKLGqqeNCi
	 Q0YioJnjk5Zgw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ED13886F68;
 Thu, 23 Nov 2023 00:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1700697075;
 bh=edY9BOYGauJ1gWmLEkCvcNNfMZ1kPB7ukS40z1LWlAQ=;
 h=From:To:Cc:Subject:Date:From;
 b=P4Ha5v/f/BsbY70T2mg/gVruadqk/0dSrqlZiRJn67f6Mb0yfrowQWl1Cb1O5tuoj
 JGgS3AHiCmR3IihFvcy/r3WToJJBWYnajw3e2D7Fr68aS5pZcOi4uuQFe208moVrOF
 Owt6jYMwvP1CY4/qmDWkhLs2Bmjlu72Xft0kkHJfYIqrFaJntlUTHP7RHg+3Xetn57
 tDjK5UQqrw5jnVjRGJgmkxmXV8KIJcipM+/e1hPm8UBr3D8kNsUu3o4JyQtDINSOH6
 7VJBHgfH8ioudLjTMMwAT+p5FeQBa1DxAYc1LV/fgidAOGPXW7sHmIMDy56qjPiy59
 1K/PnMvSf5R9w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Hector Martin <marcan@marcan.st>
Subject: [PATCH] usb: xhci: Replace terrible formatting with different
 terrible formatting
Date: Thu, 23 Nov 2023 00:50:52 +0100
Message-ID: <20231122235056.78672-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

Replace one type of terrible code formatting with a different
type of terrible code formatting. No functional change.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index dabe6cf86af..be3e35102d6 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -543,9 +543,8 @@ static void reset_ep(struct usb_device *udev, int ep_index)
 	if (!event)
 		return;
 
-	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
-		!= udev->slot_id || GET_COMP_CODE(le32_to_cpu(
-		event->event_cmd.status)) != COMP_SUCCESS);
+	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags)) != udev->slot_id ||
+	       GET_COMP_CODE(le32_to_cpu(event->event_cmd.status)) != COMP_SUCCESS);
 	xhci_acknowledge_event(ctrl);
 }
 
@@ -578,8 +577,7 @@ static void abort_td(struct usb_device *udev, int ep_index)
 		field = le32_to_cpu(event->trans_event.flags);
 		BUG_ON(TRB_TO_SLOT_ID(field) != udev->slot_id);
 		BUG_ON(TRB_TO_EP_INDEX(field) != ep_index);
-		BUG_ON(GET_COMP_CODE(le32_to_cpu(event->trans_event.transfer_len
-			!= COMP_STOP)));
+		BUG_ON(GET_COMP_CODE(le32_to_cpu(event->trans_event.transfer_len != COMP_STOP)));
 		xhci_acknowledge_event(ctrl);
 
 		event = xhci_wait_for_event(ctrl, TRB_COMPLETION);
@@ -593,9 +591,8 @@ static void abort_td(struct usb_device *udev, int ep_index)
 
 	comp = GET_COMP_CODE(le32_to_cpu(event->event_cmd.status));
 	BUG_ON(type != TRB_COMPLETION ||
-		TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
-		!= udev->slot_id || (comp != COMP_SUCCESS && comp
-		!= COMP_CTX_STATE));
+		TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags)) != udev->slot_id ||
+		(comp != COMP_SUCCESS && comp != COMP_CTX_STATE));
 	xhci_acknowledge_event(ctrl);
 
 	addr = xhci_trb_virt_to_dma(ring->enq_seg,
@@ -605,9 +602,8 @@ static void abort_td(struct usb_device *udev, int ep_index)
 	if (!event)
 		return;
 
-	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
-		!= udev->slot_id || GET_COMP_CODE(le32_to_cpu(
-		event->event_cmd.status)) != COMP_SUCCESS);
+	BUG_ON(TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags)) != udev->slot_id ||
+	       GET_COMP_CODE(le32_to_cpu(event->event_cmd.status)) != COMP_SUCCESS);
 	xhci_acknowledge_event(ctrl);
 }
 
-- 
2.42.0

