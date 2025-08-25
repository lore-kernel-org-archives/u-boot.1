Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EFDCA0FE7
	for <u-boot@archiver.kernel.org>; Mon, 25 Aug 2025 13:34:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC5A82FC7;
	Mon, 25 Aug 2025 15:33:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HbW6pCLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 431148304A; Mon, 25 Aug 2025 15:33:54 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF7E683020
 for <u-boot@lists.denx.de>; Mon, 25 Aug 2025 15:33:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57PDXocG822065;
 Mon, 25 Aug 2025 08:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756128830;
 bh=N7GHabbMNkbgWNHufcEC35dNi8hXTX9Qy3w7HEt3ZZY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=HbW6pCLcJ6sIVpQpVdF5bsFqWylE1MgvkPc+sUMJN3o3iz/AKOOPbMMOiqcFus5QA
 l4bdEDFhXEUMC8gAhF7R6oEQqD4LpP8omXe+iMtOs8PLINZHJB52PyFMS4h9BRXcO2
 9apz8o6qIgU17ivah+BCCDB7O46yfc3a2BiP2/QI=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57PDXoQt1208371
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 25 Aug 2025 08:33:50 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 25
 Aug 2025 08:33:49 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 25 Aug 2025 08:33:49 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57PDXmj53681995;
 Mon, 25 Aug 2025 08:33:49 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <u-kumar1@ti.com>
Subject: [PATCH v1 1/2] dma: ti: k3-udma: fix dma_addr_t typecasts
Date: Mon, 25 Aug 2025 19:02:31 +0530
Message-ID: <20250825133233.2475300-2-anshuld@ti.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825133233.2475300-1-anshuld@ti.com>
References: <20250825133233.2475300-1-anshuld@ti.com>
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

With the change to dma_addr_t from u32 to u64 for the R5 SPL, the
existing typecasts from void* to int or vice-versa cause the compiler to
throw a "cast from pointer to integer of different size".

Therefore this patch changes the casts to a uintptr_t which is
guaranteed to hold any pointer value, thus supressing the compiler
warning.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 drivers/dma/ti/k3-udma.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
 
-- 
2.50.1

