Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFC6BC4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 06:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A3C78755B;
	Sun, 29 Oct 2023 07:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="xzGwAQIB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A9A9871E8; Sun, 29 Oct 2023 07:38:41 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70CCA8723E
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 1CBD74269A;
 Sun, 29 Oct 2023 06:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698561519; bh=+uNlvOQTliC68AiSD0644nsVxzLYR2l34Apw6zfhJVw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=xzGwAQIBPb+40EdpXEo6mGaKTKzni4qpIgyqVskGs+1F8Vs3JNhAp1sLla+8iNfez
 yBW4IZBClWsFDu/LT0NTiXSduglH76wXXCopliaUgVx6K5ANu5KNt/CLsDjTIOXFNR
 0qthENx378BKXjbVM1zyvFE8fR8FMUCYNGRTEn+pDJAZWARx/Ci+t5rsWtUA219Rri
 FEgT82JI40eiGnUOz/46fBHr199tDLDVk0QWlgB7KGBF5OSP1+zo5s2JvCEnaCdWHl
 Z91JzccL0BcLSmxesFNi1HF6KhXrAGS3mr1/fis6mppE5vOoFDgIAZjHizdEoOM0K0
 HDnRzo8obX/mQ==
From: Hector Martin <marcan@marcan.st>
Date: Sun, 29 Oct 2023 15:37:40 +0900
Subject: [PATCH v2 3/8] usb: xhci: Allow context state errors when halting
 an endpoint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-usb-fixes-1-v2-3-623533f6316e@marcan.st>
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
In-Reply-To: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=marcan@marcan.st;
 h=from:subject:message-id; bh=+uNlvOQTliC68AiSD0644nsVxzLYR2l34Apw6zfhJVw=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlTbv/eMWs2i5V6G6ypP03r3+cR9SRW2d0/qG3U+vux8v
 6vpk+iLjlIWBjEOBlkxRZbGE72nuj2nn1NXTZkOM4eVCWQIAxenAEyk7zcjw+3zu8ym+TnGruFs
 OKM8aWdsWrRW1dNdIotyg5mezGBfupqRYe+k3AMzGl6U3WRfXHlVxI/776yTct3lBS/nRRX0/Hi
 fygMA
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

There is a race where an endpoint may halt by itself while we are trying
to halt it, which results in a context state error. See xHCI 4.6.9 which
mentions this case.

This also avoids BUGging when we attempt to stop an endpoint which was
already stopped to begin with, which is probably a bug elsewhere but
not a good reason to crash.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index d21e76e0bdb6..e02a6e300c4f 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -545,6 +545,7 @@ static void abort_td(struct usb_device *udev, int ep_index)
 	struct xhci_ctrl *ctrl = xhci_get_ctrl(udev);
 	struct xhci_ring *ring =  ctrl->devs[udev->slot_id]->eps[ep_index].ring;
 	union xhci_trb *event;
+	xhci_comp_code comp;
 	trb_type type;
 	u64 addr;
 	u32 field;
@@ -573,10 +574,11 @@ static void abort_td(struct usb_device *udev, int ep_index)
 		printf("abort_td: Expected a TRB_TRANSFER TRB first\n");
 	}
 
+	comp = GET_COMP_CODE(le32_to_cpu(event->event_cmd.status));
 	BUG_ON(type != TRB_COMPLETION ||
 		TRB_TO_SLOT_ID(le32_to_cpu(event->event_cmd.flags))
-		!= udev->slot_id || GET_COMP_CODE(le32_to_cpu(
-		event->event_cmd.status)) != COMP_SUCCESS);
+		!= udev->slot_id || (comp != COMP_SUCCESS && comp
+		!= COMP_CTX_STATE));
 	xhci_acknowledge_event(ctrl);
 
 	addr = xhci_trb_virt_to_dma(ring->enq_seg,

-- 
2.41.0

