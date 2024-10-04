Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59104CFA77A
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 13:21:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D266A88C44;
	Fri,  4 Oct 2024 15:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pHtZyI5r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6138388970; Fri,  4 Oct 2024 15:21:17 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 087C988966
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 15:21:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 494DLCoa105414;
 Fri, 4 Oct 2024 08:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728048072;
 bh=dbGnyITLWPLp/zKjWmLlkhreZ2m4VtFgD6Pr3jEWeSc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=pHtZyI5ryWnMcwXvBTwZxPSF1lYjXyxnSPwvhAMmPAP8IW75IrJhU7ytOEPqigqXE
 oBC9GCFvJ/9CAvwyWNOiftTc7UYmG6zHUR+ZrG5BkdjR5Cf26P/dfDhRhcANml7RD6
 NQqhHl+NC6/HT52RxdZRJPWr/5FzB26PFqrhkDS4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 494DLCh4107618
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 4 Oct 2024 08:21:12 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Oct 2024 08:21:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Oct 2024 08:21:12 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.227.197])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 494DKx3f061378;
 Fri, 4 Oct 2024 08:21:10 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>, <vaishnav.a@ti.com>, <s-k6@ti.com>
Subject: [PATCH 3/4] dma: ti: k3-udma: Move udma_probe() below all APIs
Date: Fri, 4 Oct 2024 18:50:56 +0530
Message-ID: <20241004132057.1449909-4-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004132057.1449909-1-p-mantena@ti.com>
References: <20241004132057.1449909-1-p-mantena@ti.com>
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

The udma_probe() function was placed above many important APIs
related to bcdma, pktdma, which restricts these APIs to be accessed
during probe. So, move udma_probe() below all of them.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 drivers/dma/ti/k3-udma.c | 270 +++++++++++++++++++--------------------
 1 file changed, 135 insertions(+), 135 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index e23d09e6b8..0543f5f4c8 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1700,141 +1700,6 @@ static int setup_resources(struct udma_dev *ud)
 	return ch_count;
 }
 
-static int udma_probe(struct udevice *dev)
-{
-	struct dma_dev_priv *uc_priv = dev_get_uclass_priv(dev);
-	struct udma_dev *ud = dev_get_priv(dev);
-	int i, ret;
-	struct udevice *tmp;
-	struct udevice *tisci_dev = NULL;
-	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
-	ofnode navss_ofnode = ofnode_get_parent(dev_ofnode(dev));
-
-	ud->match_data = (void *)dev_get_driver_data(dev);
-	ret = udma_get_mmrs(dev);
-	if (ret)
-		return ret;
-
-	ud->psil_base = ud->match_data->psil_base;
-
-	ret = uclass_get_device_by_phandle(UCLASS_FIRMWARE, dev,
-					   "ti,sci", &tisci_dev);
-	if (ret) {
-		debug("Failed to get TISCI phandle (%d)\n", ret);
-		tisci_rm->tisci = NULL;
-		return -EINVAL;
-	}
-	tisci_rm->tisci = (struct ti_sci_handle *)
-			  (ti_sci_get_handle_from_sysfw(tisci_dev));
-
-	tisci_rm->tisci_dev_id = -1;
-	ret = dev_read_u32(dev, "ti,sci-dev-id", &tisci_rm->tisci_dev_id);
-	if (ret) {
-		dev_err(dev, "ti,sci-dev-id read failure %d\n", ret);
-		return ret;
-	}
-
-	tisci_rm->tisci_navss_dev_id = -1;
-	ret = ofnode_read_u32(navss_ofnode, "ti,sci-dev-id",
-			      &tisci_rm->tisci_navss_dev_id);
-	if (ret) {
-		dev_err(dev, "navss sci-dev-id read failure %d\n", ret);
-		return ret;
-	}
-
-	tisci_rm->tisci_udmap_ops = &tisci_rm->tisci->ops.rm_udmap_ops;
-	tisci_rm->tisci_psil_ops = &tisci_rm->tisci->ops.rm_psil_ops;
-
-	if (ud->match_data->type == DMA_TYPE_UDMA) {
-		ret = uclass_get_device_by_phandle(UCLASS_MISC, dev,
-						   "ti,ringacc", &tmp);
-		ud->ringacc = dev_get_priv(tmp);
-	} else {
-		struct k3_ringacc_init_data ring_init_data;
-
-		ring_init_data.tisci = ud->tisci_rm.tisci;
-		ring_init_data.tisci_dev_id = ud->tisci_rm.tisci_dev_id;
-		if (ud->match_data->type == DMA_TYPE_BCDMA) {
-			ring_init_data.num_rings = ud->bchan_cnt +
-						   ud->tchan_cnt +
-						   ud->rchan_cnt;
-		} else {
-			ring_init_data.num_rings = ud->rflow_cnt +
-						   ud->tflow_cnt;
-		}
-
-		ud->ringacc = k3_ringacc_dmarings_init(dev, &ring_init_data);
-	}
-	if (IS_ERR(ud->ringacc))
-		return PTR_ERR(ud->ringacc);
-
-	ud->dev = dev;
-	ret = setup_resources(ud);
-	if (ret < 0)
-		return ret;
-
-	ud->ch_count = ret;
-
-	for (i = 0; i < ud->bchan_cnt; i++) {
-		struct udma_bchan *bchan = &ud->bchans[i];
-
-		bchan->id = i;
-		bchan->reg_rt = ud->mmrs[MMR_BCHANRT] + i * 0x1000;
-	}
-
-	for (i = 0; i < ud->tchan_cnt; i++) {
-		struct udma_tchan *tchan = &ud->tchans[i];
-
-		tchan->id = i;
-		tchan->reg_chan = ud->mmrs[MMR_TCHAN] + UDMA_CH_100(i);
-		tchan->reg_rt = ud->mmrs[MMR_TCHANRT] + UDMA_CH_1000(i);
-	}
-
-	for (i = 0; i < ud->rchan_cnt; i++) {
-		struct udma_rchan *rchan = &ud->rchans[i];
-
-		rchan->id = i;
-		rchan->reg_chan = ud->mmrs[MMR_RCHAN] + UDMA_CH_100(i);
-		rchan->reg_rt = ud->mmrs[MMR_RCHANRT] + UDMA_CH_1000(i);
-	}
-
-	for (i = 0; i < ud->rflow_cnt; i++) {
-		struct udma_rflow *rflow = &ud->rflows[i];
-
-		rflow->id = i;
-		rflow->reg_rflow = ud->mmrs[MMR_RFLOW] + UDMA_CH_40(i);
-	}
-
-	for (i = 0; i < ud->ch_count; i++) {
-		struct udma_chan *uc = &ud->channels[i];
-
-		uc->ud = ud;
-		uc->id = i;
-		uc->config.remote_thread_id = -1;
-		uc->bchan = NULL;
-		uc->tchan = NULL;
-		uc->rchan = NULL;
-		uc->config.mapped_channel_id = -1;
-		uc->config.default_flow_id = -1;
-		uc->config.dir = DMA_MEM_TO_MEM;
-		sprintf(uc->name, "UDMA chan%d\n", i);
-		if (!i)
-			uc->in_use = true;
-	}
-
-	pr_debug("%s(rev: 0x%08x) CAP0-3: 0x%08x, 0x%08x, 0x%08x, 0x%08x\n",
-		 dev->name,
-		 udma_read(ud->mmrs[MMR_GCFG], 0),
-		 udma_read(ud->mmrs[MMR_GCFG], 0x20),
-		 udma_read(ud->mmrs[MMR_GCFG], 0x24),
-		 udma_read(ud->mmrs[MMR_GCFG], 0x28),
-		 udma_read(ud->mmrs[MMR_GCFG], 0x2c));
-
-	uc_priv->supported = DMA_SUPPORTS_MEM_TO_MEM | DMA_SUPPORTS_MEM_TO_DEV;
-
-	return 0;
-}
-
 static int udma_push_to_ring(struct k3_nav_ring *ring, void *elem)
 {
 	u64 addr = 0;
@@ -2717,6 +2582,141 @@ static int udma_get_cfg(struct dma *dma, u32 id, void **data)
 	return -EINVAL;
 }
 
+static int udma_probe(struct udevice *dev)
+{
+	struct dma_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct udma_dev *ud = dev_get_priv(dev);
+	int i, ret;
+	struct udevice *tmp;
+	struct udevice *tisci_dev = NULL;
+	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
+	ofnode navss_ofnode = ofnode_get_parent(dev_ofnode(dev));
+
+	ud->match_data = (void *)dev_get_driver_data(dev);
+	ret = udma_get_mmrs(dev);
+	if (ret)
+		return ret;
+
+	ud->psil_base = ud->match_data->psil_base;
+
+	ret = uclass_get_device_by_phandle(UCLASS_FIRMWARE, dev,
+					   "ti,sci", &tisci_dev);
+	if (ret) {
+		debug("Failed to get TISCI phandle (%d)\n", ret);
+		tisci_rm->tisci = NULL;
+		return -EINVAL;
+	}
+	tisci_rm->tisci = (struct ti_sci_handle *)
+			  (ti_sci_get_handle_from_sysfw(tisci_dev));
+
+	tisci_rm->tisci_dev_id = -1;
+	ret = dev_read_u32(dev, "ti,sci-dev-id", &tisci_rm->tisci_dev_id);
+	if (ret) {
+		dev_err(dev, "ti,sci-dev-id read failure %d\n", ret);
+		return ret;
+	}
+
+	tisci_rm->tisci_navss_dev_id = -1;
+	ret = ofnode_read_u32(navss_ofnode, "ti,sci-dev-id",
+			      &tisci_rm->tisci_navss_dev_id);
+	if (ret) {
+		dev_err(dev, "navss sci-dev-id read failure %d\n", ret);
+		return ret;
+	}
+
+	tisci_rm->tisci_udmap_ops = &tisci_rm->tisci->ops.rm_udmap_ops;
+	tisci_rm->tisci_psil_ops = &tisci_rm->tisci->ops.rm_psil_ops;
+
+	if (ud->match_data->type == DMA_TYPE_UDMA) {
+		ret = uclass_get_device_by_phandle(UCLASS_MISC, dev,
+						   "ti,ringacc", &tmp);
+		ud->ringacc = dev_get_priv(tmp);
+	} else {
+		struct k3_ringacc_init_data ring_init_data;
+
+		ring_init_data.tisci = ud->tisci_rm.tisci;
+		ring_init_data.tisci_dev_id = ud->tisci_rm.tisci_dev_id;
+		if (ud->match_data->type == DMA_TYPE_BCDMA) {
+			ring_init_data.num_rings = ud->bchan_cnt +
+						   ud->tchan_cnt +
+						   ud->rchan_cnt;
+		} else {
+			ring_init_data.num_rings = ud->rflow_cnt +
+						   ud->tflow_cnt;
+		}
+
+		ud->ringacc = k3_ringacc_dmarings_init(dev, &ring_init_data);
+	}
+	if (IS_ERR(ud->ringacc))
+		return PTR_ERR(ud->ringacc);
+
+	ud->dev = dev;
+	ret = setup_resources(ud);
+	if (ret < 0)
+		return ret;
+
+	ud->ch_count = ret;
+
+	for (i = 0; i < ud->bchan_cnt; i++) {
+		struct udma_bchan *bchan = &ud->bchans[i];
+
+		bchan->id = i;
+		bchan->reg_rt = ud->mmrs[MMR_BCHANRT] + i * 0x1000;
+	}
+
+	for (i = 0; i < ud->tchan_cnt; i++) {
+		struct udma_tchan *tchan = &ud->tchans[i];
+
+		tchan->id = i;
+		tchan->reg_chan = ud->mmrs[MMR_TCHAN] + UDMA_CH_100(i);
+		tchan->reg_rt = ud->mmrs[MMR_TCHANRT] + UDMA_CH_1000(i);
+	}
+
+	for (i = 0; i < ud->rchan_cnt; i++) {
+		struct udma_rchan *rchan = &ud->rchans[i];
+
+		rchan->id = i;
+		rchan->reg_chan = ud->mmrs[MMR_RCHAN] + UDMA_CH_100(i);
+		rchan->reg_rt = ud->mmrs[MMR_RCHANRT] + UDMA_CH_1000(i);
+	}
+
+	for (i = 0; i < ud->rflow_cnt; i++) {
+		struct udma_rflow *rflow = &ud->rflows[i];
+
+		rflow->id = i;
+		rflow->reg_rflow = ud->mmrs[MMR_RFLOW] + UDMA_CH_40(i);
+	}
+
+	for (i = 0; i < ud->ch_count; i++) {
+		struct udma_chan *uc = &ud->channels[i];
+
+		uc->ud = ud;
+		uc->id = i;
+		uc->config.remote_thread_id = -1;
+		uc->bchan = NULL;
+		uc->tchan = NULL;
+		uc->rchan = NULL;
+		uc->config.mapped_channel_id = -1;
+		uc->config.default_flow_id = -1;
+		uc->config.dir = DMA_MEM_TO_MEM;
+		sprintf(uc->name, "UDMA chan%d\n", i);
+		if (!i)
+			uc->in_use = true;
+	}
+
+	pr_debug("%s(rev: 0x%08x) CAP0-3: 0x%08x, 0x%08x, 0x%08x, 0x%08x\n",
+		 dev->name,
+		 udma_read(ud->mmrs[MMR_GCFG], 0),
+		 udma_read(ud->mmrs[MMR_GCFG], 0x20),
+		 udma_read(ud->mmrs[MMR_GCFG], 0x24),
+		 udma_read(ud->mmrs[MMR_GCFG], 0x28),
+		 udma_read(ud->mmrs[MMR_GCFG], 0x2c));
+
+	uc_priv->supported = DMA_SUPPORTS_MEM_TO_MEM | DMA_SUPPORTS_MEM_TO_DEV;
+
+	return 0;
+}
+
 static const struct dma_ops udma_ops = {
 	.transfer	= udma_transfer,
 	.of_xlate	= udma_of_xlate,
-- 
2.34.1

