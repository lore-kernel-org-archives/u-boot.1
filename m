Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDE3CEDDA4
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 14:58:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 073A988EDD;
	Wed,  9 Oct 2024 16:57:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="D/7L461Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBA9688EDD; Wed,  9 Oct 2024 16:57:27 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBE9F88F45
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 16:57:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 499EvMrJ069730;
 Wed, 9 Oct 2024 09:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728485842;
 bh=x2vMDQndkuXzWy74bUINaO1eA6BpWCH75JC057dbiaI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=D/7L461ZZuNg/00MK0sot6oe39ybOwScZSTkjvSDYeFyNRgOXY9JCL+Egd0ETo0nj
 rNr1uODWyczev3vuc3hTeSwZDnPucv2JuBU6+hQDePAWskly3hR9rOfNKsehcfhaaO
 KAIwyKN3ygEdV/n/l7ibEXsasdWEAMeAaa0ZUQUo=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 499EvM43053047;
 Wed, 9 Oct 2024 09:57:22 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 9
 Oct 2024 09:57:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 9 Oct 2024 09:57:22 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.197])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 499Ev5cg008396;
 Wed, 9 Oct 2024 09:57:20 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2 4/4] dma: ti: k3-udma: Move DMA channel[0] allocation to
 probe and add udma_remove()
Date: Wed, 9 Oct 2024 20:27:03 +0530
Message-ID: <20241009145703.1970034-5-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009145703.1970034-1-p-mantena@ti.com>
References: <20241009145703.1970034-1-p-mantena@ti.com>
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

From: Santhosh Kumar K <s-k6@ti.com>

Currently, the allocation of DMA channel[0] for memcpy is happening
in udma_transfer() for every transfer, which leads to a huge overhead
for each transfer, especially in case of nand page reads. So, move this
allocation to udma_probe(), as a result, the allocation is done once
during probe.

Introduce udma_remove() for the cleanup of allocated channel during
probe.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 drivers/dma/ti/k3-udma.c | 63 ++++++++++++++++++++++++----------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 0543f5f4c8..dac4023ccf 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2190,37 +2190,12 @@ static int udma_transfer(struct udevice *dev, int direction,
 	/* Channel0 is reserved for memcpy */
 	struct udma_chan *uc = &ud->channels[0];
 	dma_addr_t paddr = 0;
-	int ret;
-
-	switch (ud->match_data->type) {
-	case DMA_TYPE_UDMA:
-		ret = udma_alloc_chan_resources(uc);
-		break;
-	case DMA_TYPE_BCDMA:
-		ret = bcdma_alloc_chan_resources(uc);
-		break;
-	default:
-		return -EINVAL;
-	};
-	if (ret)
-		return ret;
 
 	udma_prep_dma_memcpy(uc, dst, src, len);
 	udma_start(uc);
 	udma_poll_completion(uc, &paddr);
 	udma_stop(uc);
 
-	switch (ud->match_data->type) {
-	case DMA_TYPE_UDMA:
-		udma_free_chan_resources(uc);
-		break;
-	case DMA_TYPE_BCDMA:
-		bcdma_free_bchan_resources(uc);
-		break;
-	default:
-		return -EINVAL;
-	};
-
 	return 0;
 }
 
@@ -2590,6 +2565,7 @@ static int udma_probe(struct udevice *dev)
 	struct udevice *tmp;
 	struct udevice *tisci_dev = NULL;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	struct udma_chan *uc;
 	ofnode navss_ofnode = ofnode_get_parent(dev_ofnode(dev));
 
 	ud->match_data = (void *)dev_get_driver_data(dev);
@@ -2714,6 +2690,41 @@ static int udma_probe(struct udevice *dev)
 
 	uc_priv->supported = DMA_SUPPORTS_MEM_TO_MEM | DMA_SUPPORTS_MEM_TO_DEV;
 
+	uc = &ud->channels[0];
+	ret = 0;
+	switch (ud->match_data->type) {
+	case DMA_TYPE_UDMA:
+		ret = udma_alloc_chan_resources(uc);
+		break;
+	case DMA_TYPE_BCDMA:
+		ret = bcdma_alloc_chan_resources(uc);
+		break;
+	default:
+		break; /* Do nothing in any other case */
+	};
+
+	if (ret)
+		dev_err(dev, " Channel 0 allocation failure %d\n", ret);
+
+	return ret;
+}
+
+static int udma_remove(struct udevice *dev)
+{
+	struct udma_dev *ud = dev_get_priv(dev);
+	struct udma_chan *uc = &ud->channels[0];
+
+	switch (ud->match_data->type) {
+	case DMA_TYPE_UDMA:
+		udma_free_chan_resources(uc);
+		break;
+	case DMA_TYPE_BCDMA:
+		bcdma_free_bchan_resources(uc);
+		break;
+	default:
+		break;
+	};
+
 	return 0;
 }
 
@@ -2855,5 +2866,7 @@ U_BOOT_DRIVER(ti_edma3) = {
 	.of_match = udma_ids,
 	.ops	= &udma_ops,
 	.probe	= udma_probe,
+	.remove = udma_remove,
 	.priv_auto	= sizeof(struct udma_dev),
+	.flags  = DM_FLAG_OS_PREPARE,
 };
-- 
2.34.1

