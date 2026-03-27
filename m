Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C2810ED664
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 13:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B577F83DBF;
	Fri, 27 Mar 2026 14:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernkonzept.com header.i=@kernkonzept.com header.b="Upn2YaiM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3968D83F14; Fri, 27 Mar 2026 09:20:42 +0100 (CET)
Received: from mx.kernkonzept.com (serv1.kernkonzept.com
 [IPv6:2a01:4f8:1c1c:b490::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2148D83C14
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 09:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=kernkonzept.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=christian.poetzsch@kernkonzept.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:Subject:Cc:To:From:References:In-Reply-To:
 Reply-To:Content-ID:Content-Description;
 bh=Z5cq+cuz7Y6OQMPyNZNWafMZ+GzdnDa8E/r2WIWyykY=; b=Upn2YaiMx9ny+UbXA/7YaEqpoF
 IKZg2VuUJGzje75v7rQYkHpVu9GYOplEFDUrHoyEV8bVxNP0TX6GVbAGwdMn8eyXwB7rt3hiHjeUN
 0Qtme0fxuMjV9NqUgkowf4hMt/1fkIqVio9kjDy6vpdqUva3trZpXa9XTh3fx/vKImWMtwyLqp7Ho
 d5ESonmrpJBTdKhFbWDTtGy7P0jpbhoFEY4jzhyrFBb14+cEoWNRbqCZxXpymjj7CujITA+xYBC36
 KansKUhtFQlEQEiaJ592hgT8FNyHYUecx6blbI+ZM8bpi37Z7Py2dNpniBxMshrehLrXWJjkJzHn6
 cQ4WVgqw==;
Received: from [10.22.3.169] (helo=iris.dd1.int.kernkonzept.com)
 by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.98.2)
 id 1w62Qp-00000006ciW-16M1; Fri, 27 Mar 2026 09:20:39 +0100
From: =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
To: u-boot@lists.denx.de
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Adam Lackorzynski <adam@l4re.org>
Subject: [PATCH] virtio: add support for SIZE_MAX & SEG_MAX features
Date: Fri, 27 Mar 2026 09:18:58 +0100
Message-ID: <20260327081858.311591-1-christian.poetzsch@kernkonzept.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 14:01:00 +0100
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

Some virtio implementations may forward the virtio requests directly to
the underlying hw. The hw may have some restrictions in how many and how
big the requests can be. Therefore, the corresponding virtio device will
announce this limitations with the SIZE_MAX & SEG_MAX feature.

Add support for those features. Split an io request into multiple virtio
requests if more than seg_max segments would be used. Also split a
single buffer request into multiple segments if the buffer is bigger
then size_max.

Signed-off-by: Christian Pötzsch <christian.poetzsch@kernkonzept.com>
Signed-off-by: Adam Lackorzynski <adam@l4re.org>
---
 drivers/virtio/virtio_blk.c | 110 ++++++++++++++++++++++++++++--------
 1 file changed, 88 insertions(+), 22 deletions(-)

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 3dd0cf36268..80006a49e4a 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -14,6 +14,7 @@
 #include <virtio_ring.h>
 #include <linux/log2.h>
 #include "virtio_blk.h"
+#include <malloc.h>
 
 /**
  * struct virtio_blk_priv - private data for virtio block device
@@ -23,10 +24,16 @@ struct virtio_blk_priv {
 	struct virtqueue *vq;
 	/** @blksz_shift - log2 of block size divided by 512 */
 	u32 blksz_shift;
+	/** @size_max - maximum segment size */
+	u32 size_max;
+	/** @seg_max - maximum segment count */
+	u32 seg_max;
 };
 
 static const u32 feature[] = {
 	VIRTIO_BLK_F_BLK_SIZE,
+	VIRTIO_BLK_F_SIZE_MAX,
+	VIRTIO_BLK_F_SEG_MAX,
 	VIRTIO_BLK_F_WRITE_ZEROES
 };
 
@@ -67,50 +74,69 @@ static void virtio_blk_init_data_sg(void *buffer, lbaint_t blkcnt, struct virtio
 	sg->length = blkcnt * 512;
 }
 
-static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
-			       lbaint_t blkcnt, void *buffer, u32 type)
+static ulong virtio_blk_do_single_req(struct udevice *dev, u64 sector,
+				      lbaint_t blkcnt, char *buffer, u32 type)
 {
 	struct virtio_blk_priv *priv = dev_get_priv(dev);
+	// The virtio device may have constrains on the maximum segment size.
+	// Calculate how many segments we need.
+	u32 seg_cnt = (blkcnt * 512) / priv->size_max + 1;
+	lbaint_t seg_sec_cnt = priv->size_max / 512;
 	struct virtio_blk_outhdr out_hdr;
 	struct virtio_blk_discard_write_zeroes wz_hdr;
 	unsigned int num_out = 0, num_in = 0;
-	struct virtio_sg hdr_sg, wz_sg, data_sg, status_sg;
-	struct virtio_sg *sgs[3];
+	struct virtio_sg **sgs;
 	u8 status;
 	int ret;
+	u32 i;
+
+	// +2 is header and status descriptor; seg_cnt is the number of data segments
+	// required. Needs to be dynamically allocated.
+	sgs = calloc(seg_cnt + 2, sizeof(struct virtio_sg *));
+	if (!sgs)
+		return -ENOMEM;
+
+	for (i = 0; i < seg_cnt + 2; ++i) {
+		sgs[i] = malloc(sizeof(struct virtio_sg));
+		if (!sgs[i])
+			goto err_free;
+	}
 
-	sector <<= priv->blksz_shift;
-	blkcnt <<= priv->blksz_shift;
-	virtio_blk_init_header_sg(dev, sector, type, &out_hdr, &hdr_sg);
-	sgs[num_out++] = &hdr_sg;
+	virtio_blk_init_header_sg(dev, sector, type, &out_hdr, sgs[num_out++]);
 
 	switch (type) {
 	case VIRTIO_BLK_T_IN:
-	case VIRTIO_BLK_T_OUT:
-		virtio_blk_init_data_sg(buffer, blkcnt, &data_sg);
-		if (type & VIRTIO_BLK_T_OUT)
-			sgs[num_out++] = &data_sg;
-		else
-			sgs[num_out + num_in++] = &data_sg;
+	case VIRTIO_BLK_T_OUT: {
+		i = 0;
+		while (i < blkcnt) {
+			u32 blk_per_seg = min(blkcnt - i, seg_sec_cnt);
+
+			if (type & VIRTIO_BLK_T_OUT)
+				virtio_blk_init_data_sg(buffer + i * 512, blk_per_seg,
+							sgs[num_out++]);
+			else
+				virtio_blk_init_data_sg(buffer + i * 512, blk_per_seg,
+							sgs[num_out + num_in++]);
+			i += blk_per_seg;
+		}
 		break;
-
+	}
 	case VIRTIO_BLK_T_WRITE_ZEROES:
-		virtio_blk_init_write_zeroes_sg(dev, sector, blkcnt, &wz_hdr, &wz_sg);
-		sgs[num_out++] = &wz_sg;
+		virtio_blk_init_write_zeroes_sg(dev, sector, blkcnt, &wz_hdr,
+						sgs[num_out++]);
 		break;
 
 	default:
-		return -EINVAL;
+		goto err_free;
 	}
 
-	virtio_blk_init_status_sg(&status, &status_sg);
-	sgs[num_out + num_in++] = &status_sg;
+	virtio_blk_init_status_sg(&status, sgs[num_out + num_in++]);
 	log_debug("dev=%s, active=%d, priv=%p, priv->vq=%p\n", dev->name,
 		  device_active(dev), priv, priv->vq);
 
 	ret = virtqueue_add(priv->vq, sgs, num_out, num_in);
 	if (ret)
-		return ret;
+		goto err_free;
 
 	virtqueue_kick(priv->vq);
 
@@ -119,7 +145,38 @@ static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
 		;
 	log_debug("done\n");
 
-	return status == VIRTIO_BLK_S_OK ? blkcnt >> priv->blksz_shift : -EIO;
+err_free:
+	for (i = 0; i < seg_cnt + 2; ++i)
+		free(sgs[i]);
+	free(sgs);
+
+	return status == VIRTIO_BLK_S_OK ? blkcnt : -EIO;
+}
+
+static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
+			       lbaint_t blkcnt, char *buffer, u32 type)
+{
+	struct virtio_blk_priv *priv = dev_get_priv(dev);
+	lbaint_t seg_sec_cnt = priv->size_max / 512;
+	u32 i = 0;
+	ulong ret;
+
+	sector <<= priv->blksz_shift;
+	blkcnt <<= priv->blksz_shift;
+
+	// The virtio device may have constrains on the maximum segment count. So
+	// send multiple virtio requests one after each other, if so.
+	while (i < blkcnt) {
+		u32 blk_per_sg = min(blkcnt - i, seg_sec_cnt * priv->seg_max);
+
+		ret = virtio_blk_do_single_req(dev, sector + i, blk_per_sg,
+					       buffer + i * 512, type);
+		if (!ret)
+			return ret;
+		i += blk_per_sg;
+	}
+
+	return blkcnt >> priv->blksz_shift;
 }
 
 static ulong virtio_blk_read(struct udevice *dev, lbaint_t start,
@@ -207,6 +264,15 @@ static int virtio_blk_probe(struct udevice *dev)
 	priv->blksz_shift = desc->log2blksz - 9;
 	desc->lba >>= priv->blksz_shift;
 
+	if (virtio_has_feature(dev, VIRTIO_BLK_F_SIZE_MAX))
+		virtio_cread(dev, struct virtio_blk_config, size_max, &priv->size_max);
+	else
+		priv->size_max = -1U;
+	if (virtio_has_feature(dev, VIRTIO_BLK_F_SEG_MAX))
+		virtio_cread(dev, struct virtio_blk_config, seg_max, &priv->seg_max);
+	else
+		priv->seg_max = -1U;
+
 	return 0;
 }
 
-- 
2.47.3

