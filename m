Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E1AC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 18:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBD2987BFD;
	Wed,  6 Mar 2024 19:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="P6zcHD9M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9647D87BFD; Wed,  6 Mar 2024 19:59:31 +0100 (CET)
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com
 [IPv6:2a00:1450:4864:20::549])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CA708785E
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 19:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3EL3oZQkKBmMEJNPSJOOZHPPHMF.DPNV-CPPUMJTUT.EFOY.EF@flex--dimorinny.bounces.google.com
Received: by mail-ed1-x549.google.com with SMTP id
 4fb4d7f45d1cf-564901924f4so24931a12.0
 for <u-boot@lists.denx.de>; Wed, 06 Mar 2024 10:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709751568; x=1710356368; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ym7hzQHK/paNdElTro3XbWneGVWU5eG2Qxyxp/0JJ9c=;
 b=P6zcHD9MF0xwFjkjQiHhhT2LZvvS+0M9ethuaAkROepuirRrO/pIEmsC6xpkPgyLq1
 qDD/Gc2vgGGrSxOilFmVCw5I5kUgnr/LG1ab54X82FvkDNpRPGzVfRgKDZHUmYq8KnIy
 PxpINoKyR6oF5i430WvN6+xExcrdZYIpI6KH/DlD2VvQTR97i8iZclsqReMe7OoxSDNE
 /aoK4Qc0LH/hvJwd99wS6agSfhWVKdLcj9tsYQgDap1zs6Xb7b7/UR3vLFoMv8vnMPEJ
 wxpxrnxwQLOGj1NivxOmh1c++fOMocMnEiK5e5WqCQKKcCe5GwsPKuDs71W0gzjFMAcQ
 cNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709751568; x=1710356368;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ym7hzQHK/paNdElTro3XbWneGVWU5eG2Qxyxp/0JJ9c=;
 b=MQ2Rc2cPyLnSZZ/2Hz65xoNXTi1+i+zRw17mxGqUDM2hBvjAcnlkaKfy7MlK1EbXF8
 uYgFnQVCEq24sZnkDUNckGkxfAOelUdjCopoa12sFAFuZDJJjK2m+p/bn76EDMBtcIvC
 lfdhMtzwpNADRekZOoYlYr6zxblcUHkTyFn4Mk3lO5W9L17+wTH0nz4hpgen7rlgJ8rQ
 1U3XKUQJcJxcHXvOuXBam4hwHybrwNHPSxWf5Th0jBa2hhBNv/82czfmMcyN6+bdXsOk
 puz9jq/DFdrG7CigtYX4oqQN9iCZaBddj9QtUFWJlCoFmC/y/YC6EdV3a0Ow301OSoFK
 wAhQ==
X-Gm-Message-State: AOJu0Yxs5RfrMIug35fAlRD2o8ErFD44h8SI6pJZNW425DfZpJWqB367
 K7ia0elaa5VA2GdbnPJXIzn92eCYFHC8X1SjQSA4b2g9Kcgq6fxroGLpCcU26Bdz61jPLFtJtvx
 67wKgWpB6RwSaR+4M5Q2KIuJ7N5sn3fr+KHbx0tm7lJOc4RmIDg2Zs7QywZ6Rx3JkyuUBZyLkdp
 Aw81x31yzCoPgVn6fnbk2Pj6qXX9E/72sNBFXcuXI5QmWuiw==
X-Google-Smtp-Source: AGHT+IGKDSxzlY5IENTAdyINy58VySQcvWgAl+DYqtPrzH2RXc3SK7qZWXcODdZkI5i671A6HFQZpQ0GU50Gmmg=
X-Received: from dimorinny0.lon.corp.google.com
 ([2a00:79e0:d:209:bf09:8cbc:464b:6c87])
 (user=dimorinny job=sendgmr) by 2002:aa7:d34b:0:b0:567:a72f:f274 with SMTP id
 m11-20020aa7d34b000000b00567a72ff274mr16268edr.1.1709751568020; Wed, 06 Mar
 2024 10:59:28 -0800 (PST)
Date: Wed,  6 Mar 2024 18:59:18 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306185921.1854109-1-dimorinny@google.com>
Subject: [PATCH 1/4] virtio: blk: introduce virtio-block erase support
From: Dmitrii Merkurev <dimorinny@google.com>
To: u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, 
 Cody Schuffelen <schuffelen@google.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ying-Chun Liu <paul.liu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Co-developed-by: Cody Schuffelen <schuffelen@google.com>
Signed-off-by: Cody Schuffelen <schuffelen@google.com>
Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
---
 drivers/virtio/virtio_blk.c | 91 +++++++++++++++++++++++++++++++------
 drivers/virtio/virtio_blk.h | 47 +++++++++++++++++++
 2 files changed, 124 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
index 9581058286..225b65c4d1 100644
--- a/drivers/virtio/virtio_blk.c
+++ b/drivers/virtio/virtio_blk.c
@@ -19,30 +19,82 @@ struct virtio_blk_priv {
 	struct virtqueue *vq;
 };
 
+static const u32 feature[] = {
+	VIRTIO_BLK_F_WRITE_ZEROES
+};
+
+static void virtio_blk_init_header_sg(struct udevice *dev, u64 sector, u32 type,
+				      struct virtio_blk_outhdr *out_hdr, struct virtio_sg *sg)
+{
+	const bool sector_is_needed = type == VIRTIO_BLK_T_IN ||
+				      type == VIRTIO_BLK_T_OUT;
+
+	out_hdr->type = cpu_to_virtio32(dev, type);
+	out_hdr->sector = cpu_to_virtio64(dev, sector_is_needed ? sector : 0);
+
+	sg->addr = out_hdr;
+	sg->length = sizeof(*out_hdr);
+}
+
+static void virtio_blk_init_write_zeroes_sg(struct udevice *dev, u64 sector, lbaint_t blkcnt,
+					    struct virtio_blk_discard_write_zeroes *wz,
+					    struct virtio_sg *sg)
+{
+	wz->sector = cpu_to_virtio64(dev, sector);
+	wz->num_sectors = cpu_to_virtio32(dev, blkcnt);
+	wz->flags = cpu_to_virtio32(dev, 0);
+
+	sg->addr = wz;
+	sg->length = sizeof(*wz);
+}
+
+static void virtio_blk_init_status_sg(u8 *status, struct virtio_sg *sg)
+{
+	sg->addr = status;
+	sg->length = sizeof(*status);
+}
+
+static void virtio_blk_init_data_sg(void *buffer, lbaint_t blkcnt, struct virtio_sg *sg)
+{
+	sg->addr = buffer;
+	sg->length = blkcnt * 512;
+}
+
 static ulong virtio_blk_do_req(struct udevice *dev, u64 sector,
 			       lbaint_t blkcnt, void *buffer, u32 type)
 {
 	struct virtio_blk_priv *priv = dev_get_priv(dev);
+	struct virtio_blk_outhdr out_hdr;
+	struct virtio_blk_discard_write_zeroes wz_hdr;
 	unsigned int num_out = 0, num_in = 0;
+	struct virtio_sg hdr_sg, wz_sg, data_sg, status_sg;
 	struct virtio_sg *sgs[3];
 	u8 status;
 	int ret;
 
-	struct virtio_blk_outhdr out_hdr = {
-		.type = cpu_to_virtio32(dev, type),
-		.sector = cpu_to_virtio64(dev, sector),
-	};
-	struct virtio_sg hdr_sg = { &out_hdr, sizeof(out_hdr) };
-	struct virtio_sg data_sg = { buffer, blkcnt * 512 };
-	struct virtio_sg status_sg = { &status, sizeof(status) };
-
+	virtio_blk_init_header_sg(dev, sector, type, &out_hdr, &hdr_sg);
 	sgs[num_out++] = &hdr_sg;
 
-	if (type & VIRTIO_BLK_T_OUT)
-		sgs[num_out++] = &data_sg;
-	else
-		sgs[num_out + num_in++] = &data_sg;
-
+	switch (type) {
+	case VIRTIO_BLK_T_IN:
+	case VIRTIO_BLK_T_OUT:
+		virtio_blk_init_data_sg(buffer, blkcnt, &data_sg);
+		if (type & VIRTIO_BLK_T_OUT)
+			sgs[num_out++] = &data_sg;
+		else
+			sgs[num_out + num_in++] = &data_sg;
+		break;
+
+	case VIRTIO_BLK_T_WRITE_ZEROES:
+		virtio_blk_init_write_zeroes_sg(dev, sector, blkcnt, &wz_hdr, &wz_sg);
+		sgs[num_out++] = &wz_sg;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	virtio_blk_init_status_sg(&status, &status_sg);
 	sgs[num_out + num_in++] = &status_sg;
 	log_debug("dev=%s, active=%d, priv=%p, priv->vq=%p\n", dev->name,
 		  device_active(dev), priv, priv->vq);
@@ -76,6 +128,15 @@ static ulong virtio_blk_write(struct udevice *dev, lbaint_t start,
 				 VIRTIO_BLK_T_OUT);
 }
 
+static ulong virtio_blk_erase(struct udevice *dev, lbaint_t start,
+			      lbaint_t blkcnt)
+{
+	if (!virtio_has_feature(dev, VIRTIO_BLK_F_WRITE_ZEROES))
+		return -EOPNOTSUPP;
+
+	return virtio_blk_do_req(dev, start, blkcnt, NULL, VIRTIO_BLK_T_WRITE_ZEROES);
+}
+
 static int virtio_blk_bind(struct udevice *dev)
 {
 	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(dev->parent);
@@ -105,7 +166,8 @@ static int virtio_blk_bind(struct udevice *dev)
 	desc->bdev = dev;
 
 	/* Indicate what driver features we support */
-	virtio_driver_features_init(uc_priv, NULL, 0, NULL, 0);
+	virtio_driver_features_init(uc_priv, feature, ARRAY_SIZE(feature),
+				    NULL, 0);
 
 	return 0;
 }
@@ -132,6 +194,7 @@ static int virtio_blk_probe(struct udevice *dev)
 static const struct blk_ops virtio_blk_ops = {
 	.read	= virtio_blk_read,
 	.write	= virtio_blk_write,
+	.erase	= virtio_blk_erase,
 };
 
 U_BOOT_DRIVER(virtio_blk) = {
diff --git a/drivers/virtio/virtio_blk.h b/drivers/virtio/virtio_blk.h
index 8d8e02fa2e..b37ba264df 100644
--- a/drivers/virtio/virtio_blk.h
+++ b/drivers/virtio/virtio_blk.h
@@ -17,6 +17,8 @@
 #define VIRTIO_BLK_F_BLK_SIZE	6	/* Block size of disk is available */
 #define VIRTIO_BLK_F_TOPOLOGY	10	/* Topology information is available */
 #define VIRTIO_BLK_F_MQ		12	/* Support more than one vq */
+#define VIRTIO_BLK_F_DISCARD	13	/* Discard is supported */
+#define VIRTIO_BLK_F_WRITE_ZEROES	14	/* Write zeroes is supported */
 
 /* Legacy feature bits */
 #ifndef VIRTIO_BLK_NO_LEGACY
@@ -65,6 +67,39 @@ struct __packed virtio_blk_config {
 
 	/* number of vqs, only available when VIRTIO_BLK_F_MQ is set */
 	__u16 num_queues;
+
+	/* the next 3 entries are guarded by VIRTIO_BLK_F_DISCARD */
+	/*
+	 * The maximum discard sectors (in 512-byte sectors) for
+	 * one segment.
+	 */
+	__u32 max_discard_sectors;
+	/*
+	 * The maximum number of discard segments in a
+	 * discard command.
+	 */
+	__u32 max_discard_seg;
+	/* Discard commands must be aligned to this number of sectors. */
+	__u32 discard_sector_alignment;
+
+	/* the next 3 entries are guarded by VIRTIO_BLK_F_WRITE_ZEROES */
+	/*
+	 * The maximum number of write zeroes sectors (in 512-byte sectors) in
+	 * one segment.
+	 */
+	__u32 max_write_zeroes_sectors;
+	/*
+	 * The maximum number of segments in a write zeroes
+	 * command.
+	 */
+	__u32 max_write_zeroes_seg;
+	/*
+	 * Set if a VIRTIO_BLK_T_WRITE_ZEROES request may result in the
+	 * deallocation of one or more of the sectors.
+	 */
+	__u8 write_zeroes_may_unmap;
+
+	__u8 unused1[3];
 };
 
 /*
@@ -93,6 +128,9 @@ struct __packed virtio_blk_config {
 /* Get device ID command */
 #define VIRTIO_BLK_T_GET_ID	8
 
+/* Write zeroes command */
+#define VIRTIO_BLK_T_WRITE_ZEROES 13
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 /* Barrier before this op */
 #define VIRTIO_BLK_T_BARRIER	0x80000000
@@ -112,6 +150,15 @@ struct virtio_blk_outhdr {
 	__virtio64 sector;
 };
 
+struct virtio_blk_discard_write_zeroes {
+	/* discard/write zeroes start sector */
+	__virtio64 sector;
+	/* number of discard/write zeroes sectors */
+	__virtio32 num_sectors;
+	/* flags for this range */
+	__virtio32 flags;
+};
+
 #ifndef VIRTIO_BLK_NO_LEGACY
 struct virtio_scsi_inhdr {
 	__virtio32 errors;
-- 
2.44.0.278.ge034bb2e1d-goog

