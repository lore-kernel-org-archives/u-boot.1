Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD2BC44500
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 17:22:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00AF0849BA;
	Mon,  6 Jul 2026 19:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F8F849BA; Mon,  6 Jul 2026 19:21:56 +0200 (CEST)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F20846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 19:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 2005)
 id 5257168BFE; Mon,  6 Jul 2026 19:21:52 +0200 (CEST)
In-Reply-To: <20260706172028.C148E68BEB@verein.lst.de>
References: <20260706172028.C148E68BEB@verein.lst.de>
Subject: [PATCH v2 3/4] nvme: Fix missing address translation for PCIe inbound
 access
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heiko Schocher <hs@nabladev.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Martin Schwan <m.schwan@phytec.de>,
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 Prashant Kamble <prashant.kamble223@gmail.com>,
 Denis Mukhin <dmukhin@ford.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 u-boot@lists.denx.de
Message-Id: <20260706172152.5257168BFE@verein.lst.de>
Date: Mon,  6 Jul 2026 19:21:52 +0200 (CEST)
From: duwe@lst.de (Torsten Duwe)
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

From: Torsten Duwe <duwe@suse.de>

U-Boot currently does not account for PCIe bridges with a non-zero
inbound access offset when talking NVMe, it only works on platforms
where this offset happens to be zero.

This patch enhances the NVMe driver with the ability to also handle
these cases. It also removes the unused function nvme_get_features().

Signed-off-by: Torsten Duwe <duwe@suse.de>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Tested-by: Peter Robinson <pbrobinson@gmail.com>
---
I tried to consistently use uintptr_t when doing arithmetic on pointers
and dma_addr_t to hold, well, DMA addresses ;)

nvme_get_features mentions it's unused; so far it causes fruitless
maintenance work and causes dead extra bytes in das U-Boot binary.
It hasn't been neccessary for 9 years; one can revive it from git
once needed.

---
 drivers/nvme/nvme.c | 71 +++++++++++++++++----------------------------
 drivers/nvme/nvme.h |  3 ++
 2 files changed, 29 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 147a104149e..54284c0242b 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -8,10 +8,10 @@
 #include <bootdev.h>
 #include <cpu_func.h>
 #include <dm.h>
-#include <errno.h>
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
+#include <phys2bus.h>
 #include <time.h>
 #include <dm/device-internal.h>
 #include <linux/compat.h>
@@ -101,6 +101,8 @@ static int nvme_setup_prps(struct nvme_dev *dev, u64 *prp2,
 			printf("Error: malloc prp_pool fail\n");
 			return -ENOMEM;
 		}
+		dev->prp_pool_dma = dev_phys_to_bus(dev->udev,
+						    (uintptr_t)dev->prp_pool);
 		dev->prp_entry_num = num_pages * (prps_per_page - 1) + 1;
 	}
 
@@ -108,8 +110,10 @@ static int nvme_setup_prps(struct nvme_dev *dev, u64 *prp2,
 	i = 0;
 	while (nprps) {
 		if ((i == (prps_per_page - 1)) && nprps > 1) {
-			*(prp_pool + i) = cpu_to_le64((ulong)prp_pool +
-					page_size);
+			dma_addr_t prp_pool_dma =
+			    dev_phys_to_bus(dev->udev, (uintptr_t)prp_pool);
+			*(prp_pool + i) = cpu_to_le64(prp_pool_dma +
+								page_size);
 			i = 0;
 			prp_pool = (u64 *)((uintptr_t)prp_pool + page_size);
 		}
@@ -117,7 +121,7 @@ static int nvme_setup_prps(struct nvme_dev *dev, u64 *prp2,
 		dma_addr += page_size;
 		nprps--;
 	}
-	*prp2 = (ulong)dev->prp_pool;
+	*prp2 = dev->prp_pool_dma;
 
 	flush_dcache_range((ulong)dev->prp_pool, (ulong)dev->prp_pool +
 			   num_pages * page_size);
@@ -258,11 +262,15 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev,
 	nvmeq->cqes = (void *)memalign(4096, NVME_CQ_ALLOCATION);
 	if (!nvmeq->cqes)
 		goto free_nvmeq;
+	nvmeq->cq_dma_addr = dev_phys_to_bus(dev->udev,
+					     (uintptr_t)nvmeq->cqes);
 	memset((void *)nvmeq->cqes, 0, NVME_CQ_SIZE(depth));
 
 	nvmeq->sq_cmds = (void *)memalign(4096, NVME_SQ_SIZE(depth));
 	if (!nvmeq->sq_cmds)
 		goto free_queue;
+	nvmeq->sq_dma_addr = dev_phys_to_bus(dev->udev,
+					     (uintptr_t)nvmeq->sq_cmds);
 	memset((void *)nvmeq->sq_cmds, 0, NVME_SQ_SIZE(depth));
 
 	nvmeq->dev = dev;
@@ -410,8 +416,8 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 
 	writel(aqa, &dev->bar->aqa);
-	nvme_writeq((ulong)nvmeq->sq_cmds, &dev->bar->asq);
-	nvme_writeq((ulong)nvmeq->cqes, &dev->bar->acq);
+	nvme_writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
+	nvme_writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
 
 	result = nvme_enable_ctrl(dev);
 	if (result)
@@ -437,7 +443,7 @@ static int nvme_alloc_cq(struct nvme_dev *dev, u16 qid,
 
 	memset(&c, 0, sizeof(c));
 	c.create_cq.opcode = nvme_admin_create_cq;
-	c.create_cq.prp1 = cpu_to_le64((ulong)nvmeq->cqes);
+	c.create_cq.prp1 = cpu_to_le64(nvmeq->cq_dma_addr);
 	c.create_cq.cqid = cpu_to_le16(qid);
 	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(flags);
@@ -454,7 +460,7 @@ static int nvme_alloc_sq(struct nvme_dev *dev, u16 qid,
 
 	memset(&c, 0, sizeof(c));
 	c.create_sq.opcode = nvme_admin_create_sq;
-	c.create_sq.prp1 = cpu_to_le64((ulong)nvmeq->sq_cmds);
+	c.create_sq.prp1 = cpu_to_le64(nvmeq->sq_dma_addr);
 	c.create_sq.sqid = cpu_to_le16(qid);
 	c.create_sq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_sq.sq_flags = cpu_to_le16(flags);
@@ -464,13 +470,13 @@ static int nvme_alloc_sq(struct nvme_dev *dev, u16 qid,
 }
 
 int nvme_identify(struct nvme_dev *dev, unsigned nsid,
-		  unsigned cns, dma_addr_t dma_addr)
+		  unsigned cns, dma_addr_t cpu_addr)
 {
 	struct nvme_command c;
 	u32 page_size = dev->page_size;
+	dma_addr_t dma_addr = dev_phys_to_bus(dev->udev, cpu_addr);
 	int offset = dma_addr & (page_size - 1);
 	int length = sizeof(struct nvme_id_ctrl);
-	dma_addr_t orig_dma_addr = dma_addr;
 	int ret;
 
 	memset(&c, 0, sizeof(c));
@@ -488,49 +494,22 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
 
 	c.identify.cns = cpu_to_le32(cns);
 
-	nvme_invalidate_cache_aligned((uintptr_t)orig_dma_addr,
+	nvme_invalidate_cache_aligned((uintptr_t)cpu_addr,
 				      sizeof(struct nvme_id_ctrl));
 
 	ret = nvme_submit_admin_cmd(dev, &c, NULL);
 	if (!ret)
-		nvme_invalidate_cache_aligned((uintptr_t)orig_dma_addr,
+		nvme_invalidate_cache_aligned((uintptr_t)cpu_addr,
 					      sizeof(struct nvme_id_ctrl));
 
 	return ret;
 }
 
-int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
-		      dma_addr_t dma_addr, u32 *result)
-{
-	struct nvme_command c;
-	int ret;
-
-	memset(&c, 0, sizeof(c));
-	c.features.opcode = nvme_admin_get_features;
-	c.features.nsid = cpu_to_le32(nsid);
-	c.features.prp1 = cpu_to_le64(dma_addr);
-	c.features.fid = cpu_to_le32(fid);
-
-	ret = nvme_submit_admin_cmd(dev, &c, result);
-
-	/*
-	 * TODO: Add some cache invalidation when a DMA buffer is involved
-	 * in the request, here and before the command gets submitted. The
-	 * buffer size varies by feature, also some features use a different
-	 * field in the command packet to hold the buffer address.
-	 * Section 5.21.1 (Set Features command) in the NVMe specification
-	 * details the buffer requirements for each feature.
-	 *
-	 * At the moment there is no user of this function.
-	 */
-
-	return ret;
-}
-
 int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
-		      dma_addr_t dma_addr, u32 *result)
+		      dma_addr_t cpu_addr, u32 *result)
 {
 	struct nvme_command c;
+	dma_addr_t dma_addr = dev_phys_to_bus(dev->udev, cpu_addr);
 
 	memset(&c, 0, sizeof(c));
 	c.features.opcode = nvme_admin_set_features;
@@ -769,7 +748,7 @@ static ulong nvme_blk_rw(struct udevice *udev, lbaint_t blknr,
 	u64 prp2;
 	u64 total_len = blkcnt << desc->log2blksz;
 	u64 temp_len = total_len;
-	uintptr_t temp_buffer = (uintptr_t)buffer;
+	uintptr_t dma_addr = dev_phys_to_bus(udev, (uintptr_t)buffer);
 
 	u64 slba = blknr;
 	u16 lbas = 1 << (dev->max_transfer_shift - ns->lba_shift);
@@ -797,19 +776,19 @@ static ulong nvme_blk_rw(struct udevice *udev, lbaint_t blknr,
 		}
 
 		if (nvme_setup_prps(dev, &prp2,
-				    lbas << ns->lba_shift, temp_buffer))
+				    lbas << ns->lba_shift, dma_addr))
 			return -EIO;
 		c.rw.slba = cpu_to_le64(slba);
 		slba += lbas;
 		c.rw.length = cpu_to_le16(lbas - 1);
-		c.rw.prp1 = cpu_to_le64(temp_buffer);
+		c.rw.prp1 = cpu_to_le64(dma_addr);
 		c.rw.prp2 = cpu_to_le64(prp2);
 		status = nvme_submit_sync_cmd(dev->queues[NVME_IO_Q],
 				&c, NULL, IO_TIMEOUT);
 		if (status)
 			break;
 		temp_len -= (u32)lbas << ns->lba_shift;
-		temp_buffer += lbas << ns->lba_shift;
+		dma_addr += lbas << ns->lba_shift;
 	}
 
 	if (read)
@@ -884,6 +863,8 @@ int nvme_init(struct udevice *udev)
 		printf("Error: %s: Out of memory!\n", udev->name);
 		goto free_queue;
 	}
+
+	ndev->prp_pool_dma = dev_phys_to_bus(udev, (uintptr_t)ndev->prp_pool);
 	ndev->prp_entry_num = MAX_PRP_POOL >> 3;
 
 	ret = nvme_setup_io_queues(ndev);
diff --git a/drivers/nvme/nvme.h b/drivers/nvme/nvme.h
index bc1d612dde4..7c6ed4d9b55 100644
--- a/drivers/nvme/nvme.h
+++ b/drivers/nvme/nvme.h
@@ -619,6 +619,7 @@ struct nvme_dev {
 	u32 page_size;
 	u8 vwc;
 	u64 *prp_pool;
+	uintptr_t prp_pool_dma;
 	u32 prp_entry_num;
 	u32 nn;
 };
@@ -637,7 +638,9 @@ enum nvme_queue_id {
 struct nvme_queue {
 	struct nvme_dev *dev;
 	struct nvme_command *sq_cmds;
+	dma_addr_t sq_dma_addr;
 	struct nvme_completion *cqes;
+	dma_addr_t cq_dma_addr;
 	u32 __iomem *q_db;
 	u16 q_depth;
 	s16 cq_vector;
-- 
2.54.0

