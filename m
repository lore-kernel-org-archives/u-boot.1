Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE6CC02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 09:29:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD2E8043C;
	Tue, 18 Feb 2025 10:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GEYLN8RV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C6EA807F1; Tue, 18 Feb 2025 10:29:31 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD4680079
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 10:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51I9TP5L1518567
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 18 Feb 2025 03:29:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739870965;
 bh=iHM7qpOlDnLOOj6C4Gy4EkBPF0qm6fCA8vKfNwGo88E=;
 h=From:To:CC:Subject:Date;
 b=GEYLN8RVC/JwLNxpwxamhJ/3n2secZVq388Dc66pSP3/dntBrb9/SgmNLNdIgpQm/
 wiAT1bPZfjgcZaYcg51l/zGVSjhZieoySm+YKOW5NiQR1Y+5NEPdNf4/TPedCTDuxN
 O9MCC4ULleM1BquZvwTY8K6zS1LgyWnRi0yl/FBg=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51I9TPuY106302;
 Tue, 18 Feb 2025 03:29:25 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Feb 2025 03:29:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Feb 2025 03:29:24 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51I9TLOS039999;
 Tue, 18 Feb 2025 03:29:22 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH] dma: ti: k3-udma: Avoid Memory leak issues during dma memcpy
Date: Tue, 18 Feb 2025 14:59:19 +0530
Message-ID: <20250218092919.297869-1-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
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

During dma memcpy, bcdma descriptor gets allocated for each
transaction and not freed after completion of that transaction.
So, avoid the memory allocation for every transaction.

Add one descriptor per dma device and allocate it once in
resource setup. This descriptor can now be used for all
dma memcpy transactions optimally.

Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 drivers/dma/ti/k3-udma.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 3013c4741d0..d660e89c0f3 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -36,6 +36,7 @@
 #include "k3-psil-priv.h"
 
 #define K3_UDMA_MAX_RFLOWS 1024
+#define K3_UDMA_MAX_TR 2
 
 struct udma_chan;
 
@@ -74,7 +75,6 @@ struct udma_tchan {
 	struct k3_nav_ring *t_ring; /* Transmit ring */
 	struct k3_nav_ring *tc_ring; /* Transmit Completion ring */
 	int tflow_id; /* applicable only for PKTDMA */
-
 };
 
 #define udma_bchan udma_tchan
@@ -175,6 +175,7 @@ struct udma_dev {
 	struct udma_rflow *rflows;
 
 	struct udma_match_data *match_data;
+	void *bc_desc;
 
 	struct udma_chan *channels;
 	u32 psil_base;
@@ -1444,6 +1445,7 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 	struct ti_sci_resource_desc *rm_desc;
 	struct ti_sci_resource *rm_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	size_t desc_size;
 
 	ud->bchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->bchan_cnt),
 					   sizeof(unsigned long), GFP_KERNEL);
@@ -1460,9 +1462,12 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 	ud->rflows = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rflows),
 				  GFP_KERNEL);
 
+	desc_size = cppi5_trdesc_calc_size(K3_UDMA_MAX_TR, sizeof(struct cppi5_tr_type15_t));
+	ud->bc_desc = devm_kzalloc(dev, ALIGN(desc_size, ARCH_DMA_MINALIGN), GFP_KERNEL);
+
 	if (!ud->bchan_map || !ud->tchan_map || !ud->rchan_map ||
 	    !ud->bchans || !ud->tchans || !ud->rchans ||
-	    !ud->rflows)
+	    !ud->rflows || !ud->bc_desc)
 		return -ENOMEM;
 
 	/* Get resource ranges from tisci */
@@ -1718,8 +1723,7 @@ static int *udma_prep_dma_memcpy(struct udma_chan *uc, dma_addr_t dest,
 	int num_tr;
 	size_t tr_size = sizeof(struct cppi5_tr_type15_t);
 	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
-	unsigned long dummy;
-	void *tr_desc;
+	void *tr_desc = uc->ud->bc_desc;
 	size_t desc_size;
 
 	if (len < SZ_64K) {
@@ -1748,9 +1752,6 @@ static int *udma_prep_dma_memcpy(struct udma_chan *uc, dma_addr_t dest,
 	}
 
 	desc_size = cppi5_trdesc_calc_size(num_tr, tr_size);
-	tr_desc = dma_alloc_coherent(desc_size, &dummy);
-	if (!tr_desc)
-		return NULL;
 	memset(tr_desc, 0, desc_size);
 
 	cppi5_trdesc_init(tr_desc, num_tr, tr_size, 0, 0);
-- 
2.34.1

