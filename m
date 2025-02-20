Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2058C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE8D806FE;
	Thu, 20 Feb 2025 14:18:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="gpFRPwkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8E14801BE; Thu, 20 Feb 2025 14:18:38 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 479EF8007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:18:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51KDIXOv008161
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 07:18:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1740057513;
 bh=UcEYQ0cblftCWF27+18rgT7YZCTS2GLjVbZDeVewlPU=;
 h=From:To:CC:Subject:Date;
 b=gpFRPwkmkRg+b+El1qO6CWP3ezgwVOEyltQM/upnlH8gpyCExxlVLHkLY20/Qft/a
 oFDXTvWiYEcZlXebZTNPdc8XBiuKQTGrkLw1dYFyTaB6n0RNdtOw5OH7gHFqj9MuNA
 ifn+ph+bOdH7B7fqVAF3d3h2szSXeZynqOkJjjN4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51KDIXDt078327;
 Thu, 20 Feb 2025 07:18:33 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Feb 2025 07:18:33 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Feb 2025 07:18:32 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.142])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51KDITV0109007;
 Thu, 20 Feb 2025 07:18:30 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2] dma: ti: k3-udma: Avoid Memory leak issues during dma
 memcpy
Date: Thu, 20 Feb 2025 18:48:27 +0530
Message-ID: <20250220131827.1559137-1-p-mantena@ti.com>
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
v2: Add missing descriptor allocation for UDMA setup as well.

 drivers/dma/ti/k3-udma.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 3013c4741d0..723265ab2e5 100644
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
@@ -1349,6 +1350,7 @@ static int udma_setup_resources(struct udma_dev *ud)
 	struct ti_sci_resource_desc *rm_desc;
 	struct ti_sci_resource *rm_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	size_t desc_size;
 
 	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
 					   sizeof(unsigned long), GFP_KERNEL);
@@ -1366,9 +1368,11 @@ static int udma_setup_resources(struct udma_dev *ud)
 	ud->rflows = devm_kcalloc(dev, ud->rflow_cnt, sizeof(*ud->rflows),
 				  GFP_KERNEL);
 
+	desc_size = cppi5_trdesc_calc_size(K3_UDMA_MAX_TR, sizeof(struct cppi5_tr_type15_t));
+	ud->bc_desc = devm_kzalloc(dev, ALIGN(desc_size, ARCH_DMA_MINALIGN), GFP_KERNEL);
 	if (!ud->tchan_map || !ud->rchan_map || !ud->rflow_map ||
 	    !ud->rflow_map_reserved || !ud->tchans || !ud->rchans ||
-	    !ud->rflows)
+	    !ud->rflows || !ud->bc_desc)
 		return -ENOMEM;
 
 	/*
@@ -1444,6 +1448,7 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 	struct ti_sci_resource_desc *rm_desc;
 	struct ti_sci_resource *rm_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	size_t desc_size;
 
 	ud->bchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->bchan_cnt),
 					   sizeof(unsigned long), GFP_KERNEL);
@@ -1460,9 +1465,12 @@ static int bcdma_setup_resources(struct udma_dev *ud)
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
@@ -1718,8 +1726,7 @@ static int *udma_prep_dma_memcpy(struct udma_chan *uc, dma_addr_t dest,
 	int num_tr;
 	size_t tr_size = sizeof(struct cppi5_tr_type15_t);
 	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
-	unsigned long dummy;
-	void *tr_desc;
+	void *tr_desc = uc->ud->bc_desc;
 	size_t desc_size;
 
 	if (len < SZ_64K) {
@@ -1748,9 +1755,6 @@ static int *udma_prep_dma_memcpy(struct udma_chan *uc, dma_addr_t dest,
 	}
 
 	desc_size = cppi5_trdesc_calc_size(num_tr, tr_size);
-	tr_desc = dma_alloc_coherent(desc_size, &dummy);
-	if (!tr_desc)
-		return NULL;
 	memset(tr_desc, 0, desc_size);
 
 	cppi5_trdesc_init(tr_desc, num_tr, tr_size, 0, 0);
-- 
2.34.1

