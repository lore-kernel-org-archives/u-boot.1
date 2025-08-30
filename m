Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4A2CA0FFD
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 20:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D3D8383A;
	Sat, 30 Aug 2025 22:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="PBnkgYti";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 278BD83893; Sat, 30 Aug 2025 22:40:03 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03508380E
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 22:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2C9683F7CB; 
 Sat, 30 Aug 2025 20:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756586398;
 bh=6miZlCV51ae0u7sQ4BM2sjcirAVZg7xAZVuOQ8TGjcc=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=PBnkgYtifECdBc/ZSwPV+3foOO3wGl5TwFjPZWD6Ma50xUNLOVuoo/lIPwiOygNDP
 rrXmrjiur79x3M9YSGn9ybJYiuMk8AaOGGVMa5GzSLL5CWwsyHWdg+RW3SxkX7NLx9
 tWGnRVW0YjV/KCRWsD59j33aCqQcLrSsfZBTZb/30swt75qHNKGlJjqx9JQb3jjQz3
 dSaDGrUTqJRMMV5/HWKRiXr1SCH79kRP/p226ICqG+CxKg+PeXvmoun6Z7Y/1p6nc5
 m8OgzPtk7es3r3cJhhI3d4PjIfSZsUOXv+Yup9X1uNF8YQLXHzH9YTpAi1Da/+ZPQP
 +XgF98+XlhIBQ==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Tom Rini <trini@konsulko.com>, Cody Schuffelen <schuffelen@google.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/1] virtio: blk: support block sizes exceeding 512 bytes
Date: Sat, 30 Aug 2025 22:39:54 +0200
Message-ID: <20250830203954.25775-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

QEMU allows to specify the logical block size via parameter
logical_block_size of a virtio-blk-device.

The communication channel via virtqueues remains based on 512 byte blocks
even if the logical_block_size is larger.

Consider the logical block size in the block device driver.

Reported-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	remove superfluous include linux/err.h
---
 drivers/virtio/virtio_blk.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 2f999fc8bbe..4224e3c17f4 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -12,10 +12,17 @@
 #include <virtio_types.h>
 #include <virtio.h>
 #include <virtio_ring.h>
+#include <linux/log2.h>
 #include "virtio_blk.h"
 
+/**
+ * struct virtio_blk_priv - private date for virtio block device
+ */
 struct virtio_blk_priv {
+	/** @virtqueue - virtqueue to process */
 	struct virtqueue *vq;
+	/** @blksz_shift - log2 of block size divided by 512 */
+	u32 blksz_shift;
 };
 
 static const u32 feature[] = {
@@ -71,6 +78,8 @@ static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
 	u8 status;
 	int ret;
 
+	sector <<= priv->blksz_shift;
+	blkcnt <<= priv->blksz_shift;
 	virtio_blk_init_header_sg(dev, sector, type, &out_hdr, &hdr_sg);
 	sgs[num_out++] = &hdr_sg;
 
@@ -109,7 +118,7 @@ static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
 		;
 	log_debug("done\n");
 
-	return status == VIRTIO_BLK_S_OK ? blkcnt : -EIO;
+	return status == VIRTIO_BLK_S_OK ? blkcnt >> priv->blksz_shift : -EIO;
 }
 
 static ulong virtio_blk_read(struct udevice *dev, lbaint_t start,
@@ -177,15 +186,25 @@ static int virtio_blk_probe(struct udevice *dev)
 	struct blk_desc *desc = dev_get_uclass_plat(dev);
 	u64 cap;
 	int ret;
+	u32 blk_size;
 
 	ret = virtio_find_vqs(dev, 1, &priv->vq);
 	if (ret)
 		return ret;
 
-	desc->blksz = 512;
-	desc->log2blksz = 9;
 	virtio_cread(dev, struct virtio_blk_config, capacity, &cap);
 	desc->lba = cap;
+	if (!virtio_has_feature(dev, VIRTIO_BLK_F_BLK_SIZE)) {
+		virtio_cread(dev, struct virtio_blk_config, blk_size, &blk_size);
+		desc->blksz = blk_size;
+		if (!is_power_of_2(blk_size) || desc->blksz < 512)
+			return -EIO;
+	} else {
+		desc->blksz = 512;
+	}
+	desc->log2blksz = LOG2(desc->blksz);
+	priv->blksz_shift = desc->log2blksz - 9;
+	desc->lba >>= priv->blksz_shift;
 
 	return 0;
 }
-- 
2.51.0

