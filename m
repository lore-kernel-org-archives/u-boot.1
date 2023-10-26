Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4534EC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 23:17:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E4D6875EF;
	Fri, 27 Oct 2023 01:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="BS0kII0+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F45887BA8; Fri, 27 Oct 2023 01:17:05 +0200 (CEST)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB54F87BC4
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 01:17:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id BE260425C8;
 Thu, 26 Oct 2023 23:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698362221; bh=IHVLBVzNY6DxFhcR+6uknuISYYjlF2QTwfq85zUMDfQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BS0kII0+mj2t3tdKpqWaH6NpH1srq74kuzLadDfX6JfCL9Q/Pbp3xMTzeVd21U6+u
 MglsQawjQbCq3GAIul/XA9I/jMeu6Feuy27b+E2UJZQhzPwVaI5OIwCg8m8PgCmrka
 QShfkN0fMyPx6WydHPiViAQA78WLGCHjqXT2KFoevz2rUzE1WyE+lfTugWv/CYMLxh
 7mo+HdvSqtqebqHxFgi2U378ppDRtQpBf3bTFj2vdb8tADIUfRUjZ1zFyw5+CoNbmE
 rta765QnZMctw5cQsZz0Jh+Iqe80H60x0hxT7EsXaXwe03pqOP0Y0tn4lsyhFT/fNy
 oa22TKhTBB/+A==
From: Hector Martin <marcan@marcan.st>
Date: Fri, 27 Oct 2023 08:16:46 +0900
Subject: [PATCH 3/8] usb: xhci: Allow context state errors when halting an
 endpoint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231027-usb-fixes-1-v1-3-1c879bbcd928@marcan.st>
References: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
In-Reply-To: <20231027-usb-fixes-1-v1-0-1c879bbcd928@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de, 
 asahi@lists.linux.dev, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1562; i=marcan@marcan.st;
 h=from:subject:message-id; bh=IHVLBVzNY6DxFhcR+6uknuISYYjlF2QTwfq85zUMDfQ=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlSrz4mRHwQZ5L7al9y9Yz5p+Y0Z9ycddxfNrDAwNQif+
 XlF8st9HaUsDGIcDLJiiiyNJ3pPdXtOP6eumjIdZg4rE8gQBi5OAZhIYzkjQ5ve/7zX23h+RKcH
 NPj1f8xfezZDuMZeTzvbgWvzx6z8UkaGHbz2R57VaZYXeE4WUD7w8fq6w3/Kjy6p/aDed+r01sT
 fPAA=
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
index d08bb8e2bfba..5c2d16b58589 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -543,6 +543,7 @@ static void abort_td(struct usb_device *udev, int ep_index)
 	struct xhci_ctrl *ctrl = xhci_get_ctrl(udev);
 	struct xhci_ring *ring =  ctrl->devs[udev->slot_id]->eps[ep_index].ring;
 	union xhci_trb *event;
+	xhci_comp_code comp;
 	trb_type type;
 	u64 addr;
 	u32 field;
@@ -571,10 +572,11 @@ static void abort_td(struct usb_device *udev, int ep_index)
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

