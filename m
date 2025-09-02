Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CD3CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 09:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB72483A92;
	Tue,  2 Sep 2025 11:42:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="PoDDXihN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 627C983AA8; Tue,  2 Sep 2025 11:42:12 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB08A83A92
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 11:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5829g7Im2500097;
 Tue, 2 Sep 2025 04:42:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756806127;
 bh=zklyvlmf7aG2a56Ikr0AejLZt+RX4b0pSnWaV4AQ43g=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=PoDDXihNlkA+8Qcnn9E02/XTPyADD+doFfAmo4RylqIpv4xjxxD3PfYanWepgANeO
 o6s3pf4SGcUVDYT5FnczxcZkmTr5gXW2Wm6A9tb5zoqAME/xbl30z9MTAtrbYtz53L
 PJtQcdWEw6UNHkAphW13qRK71sN69bkHXdEJIxbc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5829g7jb2746194
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Tue, 2 Sep 2025 04:42:07 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 2
 Sep 2025 04:42:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 2 Sep 2025 04:42:07 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5829g6Tc3870444;
 Tue, 2 Sep 2025 04:42:06 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <u-kumar1@ti.com>, <p-mantena@ti.com>
Subject: [PATCH v2 1/2] dma: ti: k3-udma: fix dma_addr_t typecasts
Date: Tue, 2 Sep 2025 15:10:35 +0530
Message-ID: <20250902094037.2121393-2-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902094037.2121393-1-anshuld@ti.com>
References: <20250902094037.2121393-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

With the change to dma_addr_t from u32 to u64 in the next patch, the
existing typecasts from void* to int or vice-versa will cause the
compiler to throw a "cast from pointer to integer of different size".

Therefore this patch changes the casts to a uintptr_t which is
guaranteed to hold a pointer value on the given arch, thus preventing
the compiler warning when enabling DMA_ADDR_T_64BIT for the R5 SPL.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 drivers/dma/ti/k3-udma.c | 6 +++---
 drivers/usb/dwc3/ep0.c   | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 723265ab2e5..01824310995 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2327,7 +2327,7 @@ static int udma_send(struct dma *dma, void *src, size_t len, void *metadata)
 {
 	struct udma_dev *ud = dev_get_priv(dma->dev);
 	struct cppi5_host_desc_t *desc_tx;
-	dma_addr_t dma_src = (dma_addr_t)src;
+	dma_addr_t dma_src = (uintptr_t)src;
 	struct ti_udma_drv_packet_data packet_data = { 0 };
 	dma_addr_t paddr;
 	struct udma_chan *uc;
@@ -2426,7 +2426,7 @@ static int udma_receive(struct dma *dma, void **dst, void *metadata)
 
 	cppi5_desc_get_tags_ids(&desc_rx->hdr, &port_id, NULL);
 
-	*dst = (void *)buf_dma;
+	*dst = (void *)(uintptr_t)buf_dma;
 	uc->num_rx_bufs--;
 
 	return pkt_len;
@@ -2518,7 +2518,7 @@ int udma_prepare_rcv_buf(struct dma *dma, void *dst, size_t size)
 
 	desc_num = uc->desc_rx_cur % UDMA_RX_DESC_NUM;
 	desc_rx = uc->desc_rx + (desc_num * uc->config.hdesc_size);
-	dma_dst = (dma_addr_t)dst;
+	dma_dst = (uintptr_t)dst;
 
 	cppi5_hdesc_reset_hbdesc(desc_rx);
 
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 531f0b522af..c656cbe25ce 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -380,7 +380,7 @@ static int dwc3_ep0_handle_status(struct dwc3 *dwc,
 	dep = dwc->eps[0];
 	dwc->ep0_usb_req.dep = dep;
 	dwc->ep0_usb_req.request.length = sizeof(*response_pkt);
-	dwc->ep0_usb_req.request.buf = (void *)dwc->setup_buf_addr;
+	dwc->ep0_usb_req.request.buf = (void *)(uintptr_t)dwc->setup_buf_addr;
 	dwc->ep0_usb_req.request.complete = dwc3_ep0_status_cmpl;
 
 	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
@@ -662,7 +662,7 @@ static int dwc3_ep0_set_sel(struct dwc3 *dwc, struct usb_ctrlrequest *ctrl)
 	dep = dwc->eps[0];
 	dwc->ep0_usb_req.dep = dep;
 	dwc->ep0_usb_req.request.length = dep->endpoint.maxpacket;
-	dwc->ep0_usb_req.request.buf = (void *)dwc->setup_buf_addr;
+	dwc->ep0_usb_req.request.buf = (void *)(uintptr_t)dwc->setup_buf_addr;
 	dwc->ep0_usb_req.request.complete = dwc3_ep0_set_sel_cmpl;
 
 	return __dwc3_gadget_ep0_queue(dep, &dwc->ep0_usb_req);
-- 
2.50.1

