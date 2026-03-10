Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DCF2FD2D91
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 14:01:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1EF8403D;
	Tue, 10 Mar 2026 15:01:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="Uy9JBnLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DABC84027; Tue, 10 Mar 2026 15:01:32 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A2284027
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-359f239ffa6so413519a91.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1773151287; x=1773756087; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=42v8cCtHLM6eQI6VV5PoI3y2AQDlR4G74DDVjpJl+eE=;
 b=Uy9JBnLSnfVXsxZ+i4LiBasNVu+cJofzBTQaVw2vzLwfgODiNPvvGxTC9hzMWAuWZL
 OVRlxfQHNcfpl0K6Ui++mq0+rbfIISEmUKAcP24/Tq+Q62EDFZJrYu/steh1bME3ZH5S
 T5iiJTqUZMXnUOoYwD7Ih0uPxp8ORDxuU1Esc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773151287; x=1773756087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=42v8cCtHLM6eQI6VV5PoI3y2AQDlR4G74DDVjpJl+eE=;
 b=EMGBsQUo+IXL290p+wmk6oevap/ARwCsbswazEpgy548zQbnOWW/huMyDJYKmNfebT
 RuAQc4mO+p3QNCJ6WPGUdn3DKRtKvPfQmoQo7HQvC9Mrs6/Fr9YD8nCHo1MT7KDZXMf+
 xSljG026/9PbtSq1TETGwztAcfIOM/xRfx1NW9zFQKHIs/yCcVSaqaP7ibLcJj4pSRDQ
 rt9UWht4nmPWTBlIT/ZOv+B5fOsdd/McctEmRmQ2m7B7/4lE0ltKn10F6RSLDLNktrui
 UK3gGt+Ub0v36Scz5S+goplvL2+OYe4OJJgcIysiUY7/MSOOJSnMCsdPFIDQxTeJHcXz
 9AWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+ly6LlRyKH8kc9EtUmo5ndH9b8GgEnQqs3xNiqAN+gM2zTm8abk76uS7cvvW6i9qCQ0YWU7s=@lists.denx.de
X-Gm-Message-State: AOJu0Yxm+Up64KGNKC6a+IaFkebsn8rQbkfu2cwUKm9HOvkk0tn1H6TH
 3f5f1T2W70g3VbeZEzRIVsFDVZDNHOmhH95ckQ6GHXcJZi+LpVaxm71ATMwMTKl8HAY=
X-Gm-Gg: ATEYQzxBCuC5ZPSDJbdrx22FPmJp19kdEErJyE/4XfJieT09nYAQ4QBN56EjluDUuqN
 ZcXVNx6NFgG9O9qcTqkchHPFNb3eDsLRWPDNd15eV03T01V4NLzQyszzmR19jvUP+XMdUqlz/Pz
 MXV5SaQUK0wgLUbXA9POcJWeyhvBt6/8SeeZ1TGZtJzG3usBqwC3bfAP5PT4XHWwaMORGoo4HuN
 78UWISfJiXJ/OwUdyUwq0FrkmdL77es0j4ZzIUZj043tJzL67PzY1sR8sl13YH8rectlqFj/0j5
 0AwtCIKutEtziTshq6DlEd1996KKBZywtfh1o0icrJOMXd60n7/lLIPjfcnAfgzCl/dvu/blWhQ
 fBmXCL2QrMOJJ5hH7Yy/YQ69mVpZdPxsWBTPQBApOkqOBm9642E5s4flAX3hpDv9a4XTSP0Im92
 U1f5aDOAHwgmd2fLN5UmSet1iU+M73WO7pPRG29cmuk12q3AFyl3cDDo+zDkZyArawQARc6bGIU
 14vOrECbaAHqfY9LJrFUajyfJI=
X-Received: by 2002:a17:90b:2d81:b0:354:c6f3:d365 with SMTP id
 98e67ed59e1d1-359be2eee81mr13789879a91.17.1773151285395; 
 Tue, 10 Mar 2026 07:01:25 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1766150-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.167.218.150])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359bc9bd61fsm7863531a91.3.2026.03.10.07.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 07:01:24 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: laurent@vivier.eu, u-boot@lists.denx.de, Daniel Palmer <daniel@0x0f.com>
Subject: [RFC PATCH 2/3] virtio: mmio: endian *fixes* *HACK*
Date: Tue, 10 Mar 2026 22:59:39 +0900
Message-ID: <20260310135940.1756141-3-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310135940.1756141-1-daniel@thingy.jp>
References: <20260310135940.1756141-1-daniel@thingy.jp>
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

From: Daniel Palmer <daniel@0x0f.com>

This is an attempt to *fix* virtio mmio on the QEMU m68k virt machine.
As far as I can tell all of the registers in the virtio mmio regions
should be little endian so after reading them they need to be converted
to big endian for the code to work on them? other parts of the code
are also doing endian conversion so I'm not sure.

Or QEMU is incorrectly giving big endian register values?
---
 drivers/virtio/virtio_mmio.c | 114 +++++++++++++++++++++--------------
 1 file changed, 68 insertions(+), 46 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 28b46ab66238..2cf85fdab4ed 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -19,6 +19,27 @@
 #include <linux/io.h>
 #include "virtio_mmio.h"
 
+static inline u32 virtio_mmio_readl(void *addr)
+{
+	return in_le32(addr);
+}
+
+static inline u16 virtio_mmio_readw(void *addr)
+{
+	return in_le16(addr);
+}
+
+static inline void virtio_mmio_writel(u32 val, void *addr)
+{
+	out_le32(addr, val);
+}
+
+static inline void virtio_mmio_writew(u32 val, void *addr)
+{
+	out_le16(addr, val);
+}
+
+
 static int virtio_mmio_get_config(struct udevice *udev, unsigned int offset,
 				  void *buf, unsigned int len)
 {
@@ -44,17 +65,17 @@ static int virtio_mmio_get_config(struct udevice *udev, unsigned int offset,
 		memcpy(buf, &b, sizeof(b));
 		break;
 	case 2:
-		w = cpu_to_le16(readw(base + offset));
+		w = cpu_to_le16(virtio_mmio_readw(base + offset));
 		memcpy(buf, &w, sizeof(w));
 		break;
 	case 4:
-		l = cpu_to_le32(readl(base + offset));
+		l = cpu_to_le32(virtio_mmio_readl(base + offset));
 		memcpy(buf, &l, sizeof(l));
 		break;
 	case 8:
-		l = cpu_to_le32(readl(base + offset));
+		l = cpu_to_le32(virtio_mmio_readl(base + offset));
 		memcpy(buf, &l, sizeof(l));
-		l = cpu_to_le32(readl(base + offset + sizeof(l)));
+		l = cpu_to_le32(virtio_mmio_readl(base + offset + sizeof(l)));
 		memcpy(buf + sizeof(l), &l, sizeof(l));
 		break;
 	default:
@@ -90,17 +111,17 @@ static int virtio_mmio_set_config(struct udevice *udev, unsigned int offset,
 		break;
 	case 2:
 		memcpy(&w, buf, sizeof(w));
-		writew(le16_to_cpu(w), base + offset);
+		virtio_mmio_writew(le16_to_cpu(w), base + offset);
 		break;
 	case 4:
 		memcpy(&l, buf, sizeof(l));
-		writel(le32_to_cpu(l), base + offset);
+		virtio_mmio_writel(le32_to_cpu(l), base + offset);
 		break;
 	case 8:
 		memcpy(&l, buf, sizeof(l));
-		writel(le32_to_cpu(l), base + offset);
+		virtio_mmio_writel(le32_to_cpu(l), base + offset);
 		memcpy(&l, buf + sizeof(l), sizeof(l));
-		writel(le32_to_cpu(l), base + offset + sizeof(l));
+		virtio_mmio_writel(le32_to_cpu(l), base + offset + sizeof(l));
 		break;
 	default:
 		WARN_ON(true);
@@ -116,7 +137,7 @@ static int virtio_mmio_generation(struct udevice *udev, u32 *counter)
 	if (priv->version == 1)
 		*counter = 0;
 	else
-		*counter = readl(priv->base + VIRTIO_MMIO_CONFIG_GENERATION);
+		*counter = virtio_mmio_readl(priv->base + VIRTIO_MMIO_CONFIG_GENERATION);
 
 	return 0;
 }
@@ -125,7 +146,7 @@ static int virtio_mmio_get_status(struct udevice *udev, u8 *status)
 {
 	struct virtio_mmio_priv *priv = dev_get_priv(udev);
 
-	*status = readl(priv->base + VIRTIO_MMIO_STATUS) & 0xff;
+	*status = virtio_mmio_readl(priv->base + VIRTIO_MMIO_STATUS) & 0xff;
 
 	return 0;
 }
@@ -137,7 +158,7 @@ static int virtio_mmio_set_status(struct udevice *udev, u8 status)
 	/* We should never be setting status to 0 */
 	WARN_ON(status == 0);
 
-	writel(status, priv->base + VIRTIO_MMIO_STATUS);
+	virtio_mmio_writel(status, priv->base + VIRTIO_MMIO_STATUS);
 
 	return 0;
 }
@@ -147,7 +168,7 @@ static int virtio_mmio_reset(struct udevice *udev)
 	struct virtio_mmio_priv *priv = dev_get_priv(udev);
 
 	/* 0 status means a reset */
-	writel(0, priv->base + VIRTIO_MMIO_STATUS);
+	virtio_mmio_writel(0, priv->base + VIRTIO_MMIO_STATUS);
 
 	return 0;
 }
@@ -156,12 +177,12 @@ static int virtio_mmio_get_features(struct udevice *udev, u64 *features)
 {
 	struct virtio_mmio_priv *priv = dev_get_priv(udev);
 
-	writel(1, priv->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
-	*features = readl(priv->base + VIRTIO_MMIO_DEVICE_FEATURES);
+	virtio_mmio_writel(1, priv->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
+	*features = virtio_mmio_readl(priv->base + VIRTIO_MMIO_DEVICE_FEATURES);
 	*features <<= 32;
 
-	writel(0, priv->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
-	*features |= readl(priv->base + VIRTIO_MMIO_DEVICE_FEATURES);
+	virtio_mmio_writel(0, priv->base + VIRTIO_MMIO_DEVICE_FEATURES_SEL);
+	*features |= virtio_mmio_readl(priv->base + VIRTIO_MMIO_DEVICE_FEATURES);
 
 	return 0;
 }
@@ -177,12 +198,12 @@ static int virtio_mmio_set_features(struct udevice *udev)
 		return -EINVAL;
 	}
 
-	writel(1, priv->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
-	writel((u32)(uc_priv->features >> 32),
+	virtio_mmio_writel(1, priv->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
+	virtio_mmio_writel((u32)(uc_priv->features >> 32),
 	       priv->base + VIRTIO_MMIO_DRIVER_FEATURES);
 
-	writel(0, priv->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
-	writel((u32)uc_priv->features,
+	virtio_mmio_writel(0, priv->base + VIRTIO_MMIO_DRIVER_FEATURES_SEL);
+	virtio_mmio_writel((u32)uc_priv->features,
 	       priv->base + VIRTIO_MMIO_DRIVER_FEATURES);
 
 	return 0;
@@ -197,16 +218,16 @@ static struct virtqueue *virtio_mmio_setup_vq(struct udevice *udev,
 	int err;
 
 	/* Select the queue we're interested in */
-	writel(index, priv->base + VIRTIO_MMIO_QUEUE_SEL);
+	virtio_mmio_writel(index, priv->base + VIRTIO_MMIO_QUEUE_SEL);
 
 	/* Queue shouldn't already be set up */
-	if (readl(priv->base + (priv->version == 1 ?
+	if (virtio_mmio_readl(priv->base + (priv->version == 1 ?
 	    VIRTIO_MMIO_QUEUE_PFN : VIRTIO_MMIO_QUEUE_READY))) {
 		err = -ENOENT;
 		goto error_available;
 	}
 
-	num = readl(priv->base + VIRTIO_MMIO_QUEUE_NUM_MAX);
+	num = virtio_mmio_readl(priv->base + VIRTIO_MMIO_QUEUE_NUM_MAX);
 	if (num == 0) {
 		err = -ENOENT;
 		goto error_new_virtqueue;
@@ -220,7 +241,7 @@ static struct virtqueue *virtio_mmio_setup_vq(struct udevice *udev,
 	}
 
 	/* Activate the queue */
-	writel(virtqueue_get_vring_size(vq),
+	virtio_mmio_writel(virtqueue_get_vring_size(vq),
 	       priv->base + VIRTIO_MMIO_QUEUE_NUM);
 	if (priv->version == 1) {
 		u64 q_pfn = virtqueue_get_desc_addr(vq) >> PAGE_SHIFT;
@@ -237,27 +258,27 @@ static struct virtqueue *virtio_mmio_setup_vq(struct udevice *udev,
 			goto error_bad_pfn;
 		}
 
-		writel(PAGE_SIZE, priv->base + VIRTIO_MMIO_QUEUE_ALIGN);
-		writel(q_pfn, priv->base + VIRTIO_MMIO_QUEUE_PFN);
+		virtio_mmio_writel(PAGE_SIZE, priv->base + VIRTIO_MMIO_QUEUE_ALIGN);
+		virtio_mmio_writel(q_pfn, priv->base + VIRTIO_MMIO_QUEUE_PFN);
 	} else {
 		u64 addr;
 
 		addr = virtqueue_get_desc_addr(vq);
-		writel((u32)addr, priv->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
-		writel((u32)(addr >> 32),
+		virtio_mmio_writel((u32)addr, priv->base + VIRTIO_MMIO_QUEUE_DESC_LOW);
+		virtio_mmio_writel((u32)(addr >> 32),
 		       priv->base + VIRTIO_MMIO_QUEUE_DESC_HIGH);
 
 		addr = virtqueue_get_avail_addr(vq);
-		writel((u32)addr, priv->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
-		writel((u32)(addr >> 32),
+		virtio_mmio_writel((u32)addr, priv->base + VIRTIO_MMIO_QUEUE_AVAIL_LOW);
+		virtio_mmio_writel((u32)(addr >> 32),
 		       priv->base + VIRTIO_MMIO_QUEUE_AVAIL_HIGH);
 
 		addr = virtqueue_get_used_addr(vq);
-		writel((u32)addr, priv->base + VIRTIO_MMIO_QUEUE_USED_LOW);
-		writel((u32)(addr >> 32),
+		virtio_mmio_writel((u32)addr, priv->base + VIRTIO_MMIO_QUEUE_USED_LOW);
+		virtio_mmio_writel((u32)(addr >> 32),
 		       priv->base + VIRTIO_MMIO_QUEUE_USED_HIGH);
 
-		writel(1, priv->base + VIRTIO_MMIO_QUEUE_READY);
+		virtio_mmio_writel(1, priv->base + VIRTIO_MMIO_QUEUE_READY);
 	}
 
 	return vq;
@@ -267,10 +288,10 @@ error_bad_pfn:
 
 error_new_virtqueue:
 	if (priv->version == 1) {
-		writel(0, priv->base + VIRTIO_MMIO_QUEUE_PFN);
+		virtio_mmio_writel(0, priv->base + VIRTIO_MMIO_QUEUE_PFN);
 	} else {
-		writel(0, priv->base + VIRTIO_MMIO_QUEUE_READY);
-		WARN_ON(readl(priv->base + VIRTIO_MMIO_QUEUE_READY));
+		virtio_mmio_writel(0, priv->base + VIRTIO_MMIO_QUEUE_READY);
+		WARN_ON(virtio_mmio_readl(priv->base + VIRTIO_MMIO_QUEUE_READY));
 	}
 
 error_available:
@@ -283,12 +304,12 @@ static void virtio_mmio_del_vq(struct virtqueue *vq)
 	unsigned int index = vq->index;
 
 	/* Select and deactivate the queue */
-	writel(index, priv->base + VIRTIO_MMIO_QUEUE_SEL);
+	virtio_mmio_writel(index, priv->base + VIRTIO_MMIO_QUEUE_SEL);
 	if (priv->version == 1) {
-		writel(0, priv->base + VIRTIO_MMIO_QUEUE_PFN);
+		virtio_mmio_writel(0, priv->base + VIRTIO_MMIO_QUEUE_PFN);
 	} else {
-		writel(0, priv->base + VIRTIO_MMIO_QUEUE_READY);
-		WARN_ON(readl(priv->base + VIRTIO_MMIO_QUEUE_READY));
+		virtio_mmio_writel(0, priv->base + VIRTIO_MMIO_QUEUE_READY);
+		WARN_ON(virtio_mmio_readl(priv->base + VIRTIO_MMIO_QUEUE_READY));
 	}
 
 	vring_del_virtqueue(vq);
@@ -329,7 +350,7 @@ static int virtio_mmio_notify(struct udevice *udev, struct virtqueue *vq)
 	 * We write the queue's selector into the notification register
 	 * to signal the other end
 	 */
-	writel(vq->index, priv->base + VIRTIO_MMIO_QUEUE_NOTIFY);
+	virtio_mmio_writel(vq->index, priv->base + VIRTIO_MMIO_QUEUE_NOTIFY);
 
 	return 0;
 }
@@ -359,14 +380,14 @@ static int virtio_mmio_probe(struct udevice *udev)
 	priv->base = (void __iomem *)plat->base;
 
 	/* Check magic value */
-	magic = readl(priv->base + VIRTIO_MMIO_MAGIC_VALUE);
+	magic = virtio_mmio_readl(priv->base + VIRTIO_MMIO_MAGIC_VALUE);
 	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
 		debug("(%s): wrong magic value 0x%08x!\n", udev->name, magic);
 		return 0;
 	}
 
 	/* Check device version */
-	priv->version = readl(priv->base + VIRTIO_MMIO_VERSION);
+	priv->version = virtio_mmio_readl(priv->base + VIRTIO_MMIO_VERSION);
 	if (priv->version < 1 || priv->version > 2) {
 		debug("(%s): version %d not supported!\n",
 		      udev->name, priv->version);
@@ -374,7 +395,7 @@ static int virtio_mmio_probe(struct udevice *udev)
 	}
 
 	/* Check device ID */
-	uc_priv->device = readl(priv->base + VIRTIO_MMIO_DEVICE_ID);
+	uc_priv->device = virtio_mmio_readl(priv->base + VIRTIO_MMIO_DEVICE_ID);
 	if (uc_priv->device == 0) {
 		/*
 		 * virtio-mmio device with an ID 0 is a (dummy) placeholder
@@ -382,10 +403,11 @@ static int virtio_mmio_probe(struct udevice *udev)
 		 */
 		return 0;
 	}
-	uc_priv->vendor = readl(priv->base + VIRTIO_MMIO_VENDOR_ID);
+	/* This is actually used as little endian locally? noice */
+	uc_priv->vendor = cpu_to_le32(virtio_mmio_readl(priv->base + VIRTIO_MMIO_VENDOR_ID));
 
 	if (priv->version == 1)
-		writel(PAGE_SIZE, priv->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
+		virtio_mmio_writel(PAGE_SIZE, priv->base + VIRTIO_MMIO_GUEST_PAGE_SIZE);
 
 	debug("(%s): device (%d) vendor (%08x) version (%d)\n", udev->name,
 	      uc_priv->device, uc_priv->vendor, priv->version);
-- 
2.51.0

