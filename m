Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A54DC61DCB
	for <u-boot@archiver.kernel.org>; Sat, 29 Aug 2026 19:21:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC00F4075D;
	Sat, 29 Aug 2026 19:21:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xtHGcAGTv-x9; Sat, 29 Aug 2026 19:21:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788031305;
	bh=GJJNk1jrKwo0AAiWmLxpYUmVbD/G8JU6YGnXdRmlOg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=THjy6nlBasMxgqk85uKqALm2bjPYVnKZZ3h2Zc5o5CLiSF/bSejseaofyA3oWUMW2
	 f4md/4ZGZkYbyjF1f4KQ5Ktqw++Ie39DKrdscFRQkDYqisyPCh2ClBx4BwXTtzz/NA
	 dOG1XrMi0yW2R2UaCL66UQC/UKBg+3rZQr5i1xIjgfJ1wjLtnOng5x5kZTGquFsOaY
	 jEaW2UBz/2vtpSq7E3EWFXztz4Xbf4OC3b5pld7fWtdovnlfGKXkV92vw6uxGwv4n3
	 J49fyGcCbkZXIejj8ECvRPbM3sbc3Z82OON336M29SJJhFzoXaawQWxxc7G9imN7T+
	 7JwsuwYVH8CbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6BFDE40735;
	Sat, 29 Aug 2026 19:21:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 59E13127
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4922960629
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mmye2HbCcZkv for <u-boot@lists.u-boot-project.org>;
 Sat, 29 Aug 2026 19:21:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com;
 envelope-from=visitorckw@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=KTz8Ur1k
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4061B60632
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 19:21:42 +0000 (UTC)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so2113222a91.1
 for <u-boot@lists.u-boot-project.org>; Sat, 29 Aug 2026 12:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788031302; x=1788636102;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GJJNk1jrKwo0AAiWmLxpYUmVbD/G8JU6YGnXdRmlOg8=;
 b=KTz8Ur1kBVQGyO9gaB7wWIxu4Rhh77/HP2RC0Cl+Wqm+hhK7z6hdM4Xwe52BsHq6jq
 UQa7HjqYUwmY52tnqrVGLKfCm3DNOUCGUJ0ujxU5n3EIVH/0upvMVl1chBoR2BqshL/U
 XqmpMGRFPBTIMsU0gHFL+Tyzgj3mb7NPYWRumdNS08RFLmcjWab8AWGu4wdADikWqobq
 Qf4XZI3gpV+NGV1q/1EYslXDxYXOieXHUD7H/9EpFORDwXPqOePMrKJeSUX8hrL5j+cN
 YmtYGQv+F4FDX7PfWyuHFgwSq4j7TDe6WVpJ/moFOU7TO7uhdIF3DJxiXWqnGh46dfs8
 Qbtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788031302; x=1788636102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GJJNk1jrKwo0AAiWmLxpYUmVbD/G8JU6YGnXdRmlOg8=;
 b=pdhNl6kGp9838RZGGkxt2mv8acIaAP4rTFMLxIw8mPlWpBINyvjMA2+ENeEoak8TSl
 vnU6mjtm2UXsd3a04PLs0u6My9+HZcuSS5WcKG3QoD3jkIxCe7JrPe1aar1BjtvBbgq9
 ECxUklvJIktO+VYqDfdbnXxMKxqSoX1UlOHgMl5tXfiONL99Rd6fUJLR9LTa/Gh91jEm
 Di9+vH70GcreFbtuHDt8NcLMz12vv0IWsFrEd4z5kGEb4F2OWHBoO6R4YGNyrYb7rZmK
 paxOTWLm/fyMaVRHnSD4BU2ywA3+Q7ya5slh0yTbOIDmAdp/RWgaM88YLKDMidV+61NT
 FM1A==
X-Forwarded-Encrypted: i=1;
 AKwUvByx8buTt4BwToiIpSQUF+oJLYK0vTzg92fVDdN8LiSw/R+k9AWLH+vsoK2dWG6CuTeWEOZaht8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l1JWxGW/F6gs6dUPaxX3MHP0dlBDfbI3KB3IIuPoZszTzWP7rU
 gK+P4KglZjm0HUy3uJkG96SLjT9AZ4vRWipKXqK+oreGCKGuZnvQyRg0
X-Gm-Gg: AYBFou2fWsrsxrXIr5WjXgYtuccHge9vUmMlreYSd+A2f0edBwPz0OK8tp92MYwLyH1
 EDWBQyt7kPinF0uO4xTUjYVqWN7vxhPQAYBC9uawrlYgRicw65qc8Vivv8XeIS/qmDSmvEAQq2e
 n2uaX+yET1HbsdGrBPNCPauAqA3m/iFw0YmW2e1keNTZVLHhiXkbqsH3rVIYpfJ32owWTpdvQfL
 JiuTl+8Ce5aRozvW5alOG92W+7l0931dT7jjg9meRcT51EeHMQAHatEBKo8AZGUj8VtApX8NqdG
 xWyNKT3svMAE7Neqy7NFERnHXpSSFUmPZ+E/rl92sS9CgyUs1gwKRqBH0cyC3d+1nkWbZlNsBvS
 tYQinIMUT6/ZB4aCRAR9iwZAf2DUxbU73d+GUPSG3sY7bNH9HL38r96iOqd4Yu+oMgTHPQXn8+I
 aJHO8cEo66ckd1Fp8VzXE7lu1TWUDVg/aw6J2akLOW8bfBEdkwRUe/fwSnYFtHfjaf4UX2s4Esq
 3Qu3KMapeItXyFotJjUMnUdCwxY1GXR9dtlYZMv4kdLSJvukxHVbTXNr70243Vc1A==
X-Received: by 2002:a17:90b:3c83:b0:398:9bd5:490b with SMTP id
 98e67ed59e1d1-3989bd54c84mr12129635a91.18.1788031301979; 
 Sat, 29 Aug 2026 12:21:41 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (184.247.229.35.bc.googleusercontent.com. [35.229.247.184])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea7fa9sm12837034a91.4.2026.08.29.12.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 29 Aug 2026 12:21:41 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, tuomas.tynkkynen@iki.fi, bmeng.cn@gmail.com,
 sjg@chromium.org, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.u-boot-project.org, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v2 3/6] virtio: 9p: Add 9P transport driver
Date: Sat, 29 Aug 2026 19:21:16 +0000
Message-ID: <20260829192119.2658328-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
In-Reply-To: <20260829192119.2658328-1-visitorckw@gmail.com>
References: <20260829192119.2658328-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add virtio transport driver for the 9P filesystem.

This driver binds to the virtio-9p device exposed by the hypervisor and
registers as a DM UCLASS_9P device. It implements the transmit and
receive routines.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
Changes in v2:
- Drop D-cache flush and invalidate operations.
- Propagate error code returned by virtqueue_add().
- Add get_timer() timeout handling for virtqueue_get_buf().
- Verify received length is at least sizeof(struct p9_header).
- Bind driver to UCLASS_9P with dm_p9_ops.
- Negotiate VIRTIO_9P_MOUNT_TAG feature in .bind.
- Read mount tag from virtio config space during probe.
- Add .remove callback with virtio_reset().
- Add DM_FLAG_ACTIVE_DMA to driver flags.
---
 drivers/virtio/Kconfig         |   7 ++
 drivers/virtio/Makefile        |   1 +
 drivers/virtio/virtio-uclass.c |   1 +
 drivers/virtio/virtio_9p.c     | 119 +++++++++++++++++++++++++++++++++
 include/virtio.h               |  12 +++-
 5 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 drivers/virtio/virtio_9p.c

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 512ac376f18..55b44428026 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -77,4 +77,11 @@ config VIRTIO_RNG
 	help
 	  This is the virtual random number generator driver. It can be used
 	  with QEMU based targets.
+
+config VIRTIO_9P
+	bool "virtio 9P transport driver"
+	depends on VIRTIO && NET_9P
+	help
+	  This enables the 9P transport driver over virtio.
+	  It can be used with QEMU based targets.
 endmenu
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 4c63a6c6904..6e7bcfc8eaa 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_VIRTIO_SANDBOX) += virtio_sandbox.o
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio_blk.o
 obj-$(CONFIG_VIRTIO_RNG) += virtio_rng.o
+obj-$(CONFIG_VIRTIO_9P) += virtio_9p.o
diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index a871a1439d4..c163b2fd7d5 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -30,6 +30,7 @@ static const char *const virtio_drv_name[VIRTIO_ID_MAX_NUM] = {
 	[VIRTIO_ID_NET]		= VIRTIO_NET_DRV_NAME,
 	[VIRTIO_ID_BLOCK]	= VIRTIO_BLK_DRV_NAME,
 	[VIRTIO_ID_RNG]		= VIRTIO_RNG_DRV_NAME,
+	[VIRTIO_ID_9P]		= VIRTIO_9P_DRV_NAME,
 };
 
 int virtio_get_config(struct udevice *vdev, unsigned int offset,
diff --git a/drivers/virtio/virtio_9p.c b/drivers/virtio/virtio_9p.c
new file mode 100644
index 00000000000..070af662d43
--- /dev/null
+++ b/drivers/virtio/virtio_9p.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#define LOG_CATEGORY UCLASS_VIRTIO
+
+#include <9p.h>
+#include <dm.h>
+#include <time.h>
+#include <virtio.h>
+#include <virtio_ring.h>
+#include <virtio_types.h>
+#include <linux/errno.h>
+
+#define VIRTIO_9P_TIMEOUT_MS 5000
+
+struct virtio_9p_priv {
+	struct virtqueue *vq;
+	char mount_tag[32];
+};
+
+static const u32 feature[] = {
+	VIRTIO_9P_MOUNT_TAG,
+};
+
+static int virtio_9p_request(struct udevice *dev, void *tx, int tx_len, void *rx, int rx_len)
+{
+	struct virtio_9p_priv *priv = dev_get_priv(dev);
+	struct virtio_sg sg[2];
+	struct virtio_sg *sgs[2];
+	int len, ret;
+	ulong start;
+
+	sg[0].addr = tx;
+	sg[0].length = tx_len;
+	sgs[0] = &sg[0];
+
+	sg[1].addr = rx;
+	sg[1].length = rx_len;
+	sgs[1] = &sg[1];
+
+	ret = virtqueue_add(priv->vq, sgs, 1, 1);
+	if (ret)
+		return ret;
+
+	virtqueue_kick(priv->vq);
+
+	start = get_timer(0);
+	while (!virtqueue_get_buf(priv->vq, &len)) {
+		if (get_timer(start) > VIRTIO_9P_TIMEOUT_MS)
+			return -ETIMEDOUT;
+	}
+
+	if (len < (int)sizeof(struct p9_header))
+		return -EIO;
+
+	return 0;
+}
+
+static const char *virtio_9p_get_mount_tag(struct udevice *dev)
+{
+	struct virtio_9p_priv *priv = dev_get_priv(dev);
+
+	return priv->mount_tag;
+}
+
+static const struct dm_p9_ops virtio_9p_ops = {
+	.request = virtio_9p_request,
+	.get_mount_tag = virtio_9p_get_mount_tag,
+};
+
+static int virtio_9p_bind(struct udevice *dev)
+{
+	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(dev->parent);
+
+	virtio_driver_features_init(uc_priv, feature, ARRAY_SIZE(feature), NULL, 0);
+	return 0;
+}
+
+static int virtio_9p_probe(struct udevice *dev)
+{
+	struct virtio_9p_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = virtio_find_vqs(dev, 1, &priv->vq);
+	if (ret)
+		return ret;
+
+	if (virtio_has_feature(dev, VIRTIO_9P_MOUNT_TAG)) {
+		u16 tag_len;
+
+		virtio_cread(dev, struct virtio_9p_config, tag_len, &tag_len);
+		if (tag_len > 0 && tag_len < sizeof(priv->mount_tag)) {
+			virtio_cread_bytes(dev, offsetof(struct virtio_9p_config, tag),
+					   priv->mount_tag, tag_len);
+			priv->mount_tag[tag_len] = '\0';
+			log_debug("virtio-9p: mount_tag=%s\n", priv->mount_tag);
+		}
+	}
+
+	return 0;
+}
+
+static int virtio_9p_remove(struct udevice *dev)
+{
+	return virtio_reset(dev);
+}
+
+U_BOOT_DRIVER(virtio_9p) = {
+	.name       = VIRTIO_9P_DRV_NAME,
+	.id         = UCLASS_9P,
+	.ops        = &virtio_9p_ops,
+	.bind       = virtio_9p_bind,
+	.probe      = virtio_9p_probe,
+	.remove     = virtio_9p_remove,
+	.priv_auto  = sizeof(struct virtio_9p_priv),
+	.flags      = DM_FLAG_ACTIVE_DMA,
+};
diff --git a/include/virtio.h b/include/virtio.h
index 3edf023463d..b981eead5d7 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -31,11 +31,21 @@
 #define VIRTIO_ID_NET		1 /* virtio net */
 #define VIRTIO_ID_BLOCK		2 /* virtio block */
 #define VIRTIO_ID_RNG		4 /* virtio rng */
-#define VIRTIO_ID_MAX_NUM	5
+#define VIRTIO_ID_9P		9 /* virtio 9p */
+#define VIRTIO_ID_MAX_NUM	10
 
 #define VIRTIO_NET_DRV_NAME	"virtio-net"
 #define VIRTIO_BLK_DRV_NAME	"virtio-blk"
 #define VIRTIO_RNG_DRV_NAME	"virtio-rng"
+#define VIRTIO_9P_DRV_NAME	"virtio-9p"
+
+/* Feature bits for virtio 9P */
+#define VIRTIO_9P_MOUNT_TAG	0
+
+struct virtio_9p_config {
+	__virtio16 tag_len;
+	u8 tag[];
+} __packed;
 
 /* Status byte for guest to report progress, and synchronize features */
 
-- 
2.55.0.897.gb25b4bd76c-goog

