Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E73F2C4332F
	for <u-boot@archiver.kernel.org>; Sun, 29 Oct 2023 06:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5D1687740;
	Sun, 29 Oct 2023 07:38:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=marcan.st header.i=@marcan.st header.b="ir13GisZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D44A8763A; Sun, 29 Oct 2023 07:38:52 +0100 (CET)
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7249A8769C
 for <u-boot@lists.denx.de>; Sun, 29 Oct 2023 07:38:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=marcan.st
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marcan@marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: sendonly@marcansoft.com)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 0640F4268B;
 Sun, 29 Oct 2023 06:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
 t=1698561528; bh=ppe6Yz6eRH+7A2U81PZqJ6AYVRQhDWwxRmqdPM5NSoE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=ir13GisZhJfTavqDCoF76XgmTswkQBpkE38IkRGLmQ78zzo9nYCHfYTwKi8WVfwKp
 P/tTt/orR7g3T3JPfZm4CnDfZA6zA34eyrv1B4kXf0qZP3mN75EGgjsBW1rBFQ5G/f
 FyXa0rwfaMxK6otp4DsQSZvCAbLn6VS4CZL/FUvKzj9pR7TGinKu+T7u29vdrdGWys
 P+Te1KsOUwQ5qkCzbZMtq+zXYaaGiGZJWEQDcPYSW+Xoy5qwx+sNfv3VnnRp5E4b/o
 HnijC5ub53ofHHiHXdbDctn6JLqfg+LxUtPljDWaiBKLHlYOiDZQPSYS8CqTEOFqWY
 XgGV0hkCknhoQ==
From: Hector Martin <marcan@marcan.st>
Date: Sun, 29 Oct 2023 15:37:44 +0900
Subject: [PATCH v2 7/8] usb: xhci: Fix DMA address calculation in queue_trb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231029-usb-fixes-1-v2-7-623533f6316e@marcan.st>
References: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
In-Reply-To: <20231029-usb-fixes-1-v2-0-623533f6316e@marcan.st>
To: Bin Meng <bmeng.cn@gmail.com>, Marek Vasut <marex@denx.de>
Cc: Mark Kettenis <kettenis@openbsd.org>, Neal Gompa <neal@gompa.dev>, 
 u-boot@lists.denx.de, asahi@lists.linux.dev, 
 Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1110; i=marcan@marcan.st;
 h=from:subject:message-id; bh=ppe6Yz6eRH+7A2U81PZqJ6AYVRQhDWwxRmqdPM5NSoE=;
 b=owGbwMvMwCEm+yP4NEe/cRLjabUkhlTbv4/TjN75K2/cPC9hz6Ivxet3HtlgELbxgJnK4td5d
 pv2fdm/qqOUhUGMg0FWTJGl8UTvqW7P6efUVVOmw8xhZQIZwsDFKQATWV/MyHB8JxePZlC6XshP
 df9vK4JexLXFSml3sH6rN7H9/mpxaDIjw3lG9iIxl/1X98SEfc1P4pzxbCPXy8mfjpee5ryW8K3
 +BQcA
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

We need to get the DMA address before incrementing the pointer, as that
might move us onto another segment.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/usb/host/xhci-ring.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index ae0ab5744df0..b60661fe05e7 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -202,6 +202,7 @@ static dma_addr_t queue_trb(struct xhci_ctrl *ctrl, struct xhci_ring *ring,
 			    bool more_trbs_coming, unsigned int *trb_fields)
 {
 	struct xhci_generic_trb *trb;
+	dma_addr_t addr;
 	int i;
 
 	trb = &ring->enqueue->generic;
@@ -211,9 +212,11 @@ static dma_addr_t queue_trb(struct xhci_ctrl *ctrl, struct xhci_ring *ring,
 
 	xhci_flush_cache((uintptr_t)trb, sizeof(struct xhci_generic_trb));
 
+	addr = xhci_trb_virt_to_dma(ring->enq_seg, (union xhci_trb *)trb);
+
 	inc_enq(ctrl, ring, more_trbs_coming);
 
-	return xhci_trb_virt_to_dma(ring->enq_seg, (union xhci_trb *)trb);
+	return addr;
 }
 
 /**

-- 
2.41.0

