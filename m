Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE96E9B37D
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 13:00:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 464D183F2A;
	Mon,  2 Mar 2026 14:00:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0144083F2D; Mon,  2 Mar 2026 14:00:34 +0100 (CET)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9381D83F0A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 14:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=duwe@lst.de
Received: by verein.lst.de (Postfix, from userid 107)
 id BBE8068CFE; Mon,  2 Mar 2026 14:00:29 +0100 (CET)
Received: from rocky.lan (dynamic-095-114-042-014.95.114.pool.telefonica.de
 [95.114.42.14])
 by verein.lst.de (Postfix) with ESMTPSA id 9B7D668BEB;
 Mon,  2 Mar 2026 13:59:50 +0100 (CET)
Date: Mon, 2 Mar 2026 13:59:40 +0100
From: Torsten Duwe <duwe@lst.de>
To: Bin Meng <bmeng.cn@gmail.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Matthias Brugger
 <mbrugger@suse.com>, Andrea della Porta <andrea.porta@suse.com>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
Subject: [PATCH v0] Fix NVMe for non-zero bus offsets
Message-ID: <20260302135940.550e6051@rocky.lan>
Organization: LST e.V.
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; aarch64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

Hi all,

working on the RPi5 I found that the U-Boot NVMe code is lacking a significant
feature. The NVMe protocol heavily relies on device access into main memory,
in the medieval times of computing this was called "bus master DMA". The NVMe
device must generate memory addresses and read or write contents there. The
current U-Boot code does in no way account for PCIe bridges in the path that
add an offset to such "inbound accesses". Consequently, U-Boot can only boot
from NVMe on platforms where this address offset is zero.
(These are surprisingly many!)

This proposed patch uses the already existent dev_phys_to_bus(), which can
dig up the correct offset from associated DT nodes and subtract it. I have
no strong opinion on the macro naming, and whether it should silently pull
in the "dev" from the outer scope or have it better passed explicitly.

Signed-off-by: Torsten Duwe <duwe@lst.de>

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 2b14437f69c..98b9cec47d6 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -12,6 +12,7 @@
 #include <log.h>
 #include <malloc.h>
 #include <memalign.h>
+#include <phys2bus.h>
 #include <time.h>
 #include <dm/device-internal.h>
 #include <linux/compat.h>
@@ -27,6 +28,8 @@
 #define IO_TIMEOUT		30
 #define MAX_PRP_POOL		512
 
+#define BUS_ADDR(a)		dev_phys_to_bus(dev->udev, (a))
+
 static int nvme_wait_csts(struct nvme_dev *dev, u32 mask, u32 val)
 {
 	int timeout;
@@ -91,12 +100,12 @@ static int nvme_setup_prps(struct nvme_dev *dev, u64 *prp2,
 	i = 0;
 	while (nprps) {
 		if ((i == (prps_per_page - 1)) && nprps > 1) {
-			*(prp_pool + i) = cpu_to_le64((ulong)prp_pool +
-					page_size);
+			*(prp_pool + i) = cpu_to_le64(BUS_ADDR((ulong)prp_pool +
+								page_size));
 			i = 0;
 			prp_pool += page_size;
 		}
-		*(prp_pool + i++) = cpu_to_le64(dma_addr);
+		*(prp_pool + i++) = cpu_to_le64(BUS_ADDR(dma_addr));
 		dma_addr += page_size;
 		nprps--;
 	}
@@ -393,8 +406,8 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	dev->ctrl_config |= NVME_CC_IOSQES | NVME_CC_IOCQES;
 
 	writel(aqa, &dev->bar->aqa);
-	nvme_writeq((ulong)nvmeq->sq_cmds, &dev->bar->asq);
-	nvme_writeq((ulong)nvmeq->cqes, &dev->bar->acq);
+	nvme_writeq(BUS_ADDR((ulong)nvmeq->sq_cmds), &dev->bar->asq);
+	nvme_writeq(BUS_ADDR((ulong)nvmeq->cqes), &dev->bar->acq);
 
 	result = nvme_enable_ctrl(dev);
 	if (result)
@@ -420,7 +436,7 @@ static int nvme_alloc_cq(struct nvme_dev *dev, u16 qid,
 
 	memset(&c, 0, sizeof(c));
 	c.create_cq.opcode = nvme_admin_create_cq;
-	c.create_cq.prp1 = cpu_to_le64((ulong)nvmeq->cqes);
+	c.create_cq.prp1 = cpu_to_le64(BUS_ADDR((ulong)nvmeq->cqes));
 	c.create_cq.cqid = cpu_to_le16(qid);
 	c.create_cq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_cq.cq_flags = cpu_to_le16(flags);
@@ -437,7 +453,7 @@ static int nvme_alloc_sq(struct nvme_dev *dev, u16 qid,
 
 	memset(&c, 0, sizeof(c));
 	c.create_sq.opcode = nvme_admin_create_sq;
-	c.create_sq.prp1 = cpu_to_le64((ulong)nvmeq->sq_cmds);
+	c.create_sq.prp1 = cpu_to_le64(BUS_ADDR((ulong)nvmeq->sq_cmds));
 	c.create_sq.sqid = cpu_to_le16(qid);
 	c.create_sq.qsize = cpu_to_le16(nvmeq->q_depth - 1);
 	c.create_sq.sq_flags = cpu_to_le16(flags);
@@ -458,14 +474,14 @@ int nvme_identify(struct nvme_dev *dev, unsigned nsid,
 	memset(&c, 0, sizeof(c));
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.nsid = cpu_to_le32(nsid);
-	c.identify.prp1 = cpu_to_le64(dma_addr);
+	c.identify.prp1 = cpu_to_le64(BUS_ADDR(dma_addr));
 
 	length -= (page_size - offset);
 	if (length <= 0) {
 		c.identify.prp2 = 0;
 	} else {
 		dma_addr += (page_size - offset);
-		c.identify.prp2 = cpu_to_le64(dma_addr);
+		c.identify.prp2 = cpu_to_le64(BUS_ADDR(dma_addr));
 	}
 
 	c.identify.cns = cpu_to_le32(cns);
@@ -490,7 +506,7 @@ int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
 	memset(&c, 0, sizeof(c));
 	c.features.opcode = nvme_admin_get_features;
 	c.features.nsid = cpu_to_le32(nsid);
-	c.features.prp1 = cpu_to_le64(dma_addr);
+	c.features.prp1 = cpu_to_le64(BUS_ADDR(dma_addr));
 	c.features.fid = cpu_to_le32(fid);
 
 	ret = nvme_submit_admin_cmd(dev, &c, result);
@@ -516,7 +532,7 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
 
 	memset(&c, 0, sizeof(c));
 	c.features.opcode = nvme_admin_set_features;
-	c.features.prp1 = cpu_to_le64(dma_addr);
+	c.features.prp1 = cpu_to_le64(BUS_ADDR(dma_addr));
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
@@ -785,8 +805,8 @@ static ulong nvme_blk_rw(struct udevice *udev, lbaint_t blknr,
 		c.rw.slba = cpu_to_le64(slba);
 		slba += lbas;
 		c.rw.length = cpu_to_le16(lbas - 1);
-		c.rw.prp1 = cpu_to_le64(temp_buffer);
-		c.rw.prp2 = cpu_to_le64(prp2);
+		c.rw.prp1 = cpu_to_le64(BUS_ADDR(temp_buffer));
+		c.rw.prp2 = cpu_to_le64(BUS_ADDR(prp2));
 		status = nvme_submit_sync_cmd(dev->queues[NVME_IO_Q],
 				&c, NULL, IO_TIMEOUT);
 		if (status)
