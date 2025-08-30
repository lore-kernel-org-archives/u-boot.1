Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83301CA0FFF
	for <u-boot@archiver.kernel.org>; Sat, 30 Aug 2025 14:28:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B088B836B2;
	Sat, 30 Aug 2025 16:28:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="Ri3Abx4l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3227837B6; Sat, 30 Aug 2025 16:28:22 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF77583542
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 16:28:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 05FD53F4A6
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 14:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1756564100;
 bh=UfJLIhk0fN0A1h8e8kOfOz4wjBTwDu0hfqGt5/iW8io=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=Ri3Abx4lKLvisvE8sWDY5yiQzBDxy2uh/SC+SMylZGr5sG6TJr/KYbbcDJ1Hhxsp2
 LRsdvaJfnbIGptg4FKbygMIGwzx4K4h0hoN/YNMbn25qgEvdRXmjTxgtBPc5OifzwN
 gDwtFZRcgaEAbIpyCC/tXOsYO+oFYY6TIfAq2umm6q6KgmupGUwAPCAewRHM1jpvFZ
 SC8hQ/vCy4GTXBiwuJlpN2t1hpkFvvsz1ieIy+R1oeRwJIs7r/EieHxQcuORY2w2W+
 yCz7BM0FyKjke/78GDgOPZmPD+/1BmV1R2cBTNRXuuN/G8NPAi6Y9gN82FyFo73Tuy
 JBpxHy5BZyfdQ==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3d1114879a4so680161f8f.0
 for <u-boot@lists.denx.de>; Sat, 30 Aug 2025 07:28:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756564099; x=1757168899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UfJLIhk0fN0A1h8e8kOfOz4wjBTwDu0hfqGt5/iW8io=;
 b=YK8g2fThYPs5OdkOUCXS9QiAs26Vd1SHHCuLEJfHUeExTODUFbVHhEsdvE+WE+Xk/l
 TtEnHO0h2IPwM0sSex1NamHh3tC0ooAN9qwUvhRWMq5YS9QkCfxRS0UGbBR6PxSrorb0
 9vagckP0GKQu5N9DkmRMEx8skXhkGnkVrOzhBbJiMwo5p8uIybc0o5DYFMBSEmidZZ23
 i0U/mw/SfEH8yr7kvGfsUgyaTSBgxW25MnaVHZzSE2TYCeOTlc5uN+JoUWWpApMW4KSH
 L8jsA76SGsTl69RkhOFfi/rE6nWzLH2mA53TMAu820TlnxHvq9zyEQCV6xygr3FLfwCa
 +eXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFoKaVA0hizfz92nkbF8H72NAMp49sl2INDpMWIHxRb653IcdZ9/KJDI8e677ZIeMUUpp8ZpQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwfZf1GSHYSmved/oV2i0zJyG9CRRGdUTrb4Mcm8v2b4inVsY68
 +TSP74g2VpK7KYt0D656LUfdd6Dp6LOcYDZqmhdk6FzAZK9s2j7aQVH/NILlOFk2oFh3uCjLQUu
 S7trR8JfWvaE9CkKxXGbceQLpaf9gK+TutqD4Ucv5Q5e1Tog+BHHQeZV7iJl7mLU8C6KW/+0=
X-Gm-Gg: ASbGncsYWaS+3H2O832mnj3MGztvCGXgrbT0frBlspL4IPQ9SSxdv/1crEuRfnqBmqf
 BNhTp5CKS/tZ5Aup4F1sCyy8XLoTd+DFMkE+2hGHt1LnixoFeD4n5WZ31sTPcQPqYGP2EMl+WAh
 NsBy1+8Qtikbk411XIBgMRZjAwKivFtjk438GcfWDPuZTIWFtZ9FzwhPhoI7kLBrWIa0H7rgeWe
 VM0iRB9YoXJRUGNMGA87llG76YfkAVIdjvBo3DtP1bRlT7XHSYx+Hlbz7Grw6Ppi9bMnnzbRvXK
 CPgxVN7+UCsR4rmhzCYjp/Zq4V+/VexQocUjeUmYxET5nFB1fNMsb4sGmJlkrSDm7x6dPCCgNNs
 4GWxu+T4JNYmRYS7XpoJaXW5nVHp15Xc=
X-Received: by 2002:a05:6000:22c7:b0:3c9:f4a3:f146 with SMTP id
 ffacd0b85a97d-3d1e0a998f2mr1452499f8f.62.1756564099467; 
 Sat, 30 Aug 2025 07:28:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeq+D8YTTuYzsZTdT79spEgwhq5Cvidd3eKpWHSpgPA9DQjxU0KWa7jEUvtLKzZDUO2CT0Tg==
X-Received: by 2002:a05:6000:22c7:b0:3c9:f4a3:f146 with SMTP id
 ffacd0b85a97d-3d1e0a998f2mr1452489f8f.62.1756564099066; 
 Sat, 30 Aug 2025 07:28:19 -0700 (PDT)
Received: from workstation5 (ip-005-147-080-091.um06.pools.vodafone-ip.de.
 [5.147.80.91]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf270fd01csm7577604f8f.12.2025.08.30.07.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Aug 2025 07:28:18 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Cody Schuffelen <schuffelen@google.com>,
 Dmitrii Merkurev <dimorinny@google.com>, Simon Glass <sjg@chromium.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] virtio: blk: support block sizes exceeding 512 bytes
Date: Sat, 30 Aug 2025 16:26:28 +0200
Message-ID: <20250830142628.99983-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.50.1
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
 drivers/virtio/virtio_blk.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 2f999fc8bbe..6286f50095a 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -12,10 +12,18 @@
 #include <virtio_types.h>
 #include <virtio.h>
 #include <virtio_ring.h>
+#include <linux/err.h>
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
@@ -71,6 +79,8 @@ static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
 	u8 status;
 	int ret;
 
+	sector <<= priv->blksz_shift;
+	blkcnt <<= priv->blksz_shift;
 	virtio_blk_init_header_sg(dev, sector, type, &out_hdr, &hdr_sg);
 	sgs[num_out++] = &hdr_sg;
 
@@ -109,7 +119,7 @@ static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
 		;
 	log_debug("done\n");
 
-	return status == VIRTIO_BLK_S_OK ? blkcnt : -EIO;
+	return status == VIRTIO_BLK_S_OK ? blkcnt >> priv->blksz_shift : -EIO;
 }
 
 static ulong virtio_blk_read(struct udevice *dev, lbaint_t start,
@@ -177,15 +187,25 @@ static int virtio_blk_probe(struct udevice *dev)
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
2.50.1

