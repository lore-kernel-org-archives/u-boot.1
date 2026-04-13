Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E7F5EBFD21
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 496B9841D7;
	Mon, 13 Apr 2026 11:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="dytH0SdH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 464748419C; Mon, 13 Apr 2026 11:23:11 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08D93841CD
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-35da9692ec3so3989843a91.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 02:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776072187; x=1776676987; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkfdQl5o/95RN5trxCmFHCvaQaWp54iAYT6nSL+SCRg=;
 b=dytH0SdHyugleUR07CgvdNm0CpRqjSX9LHykqdLZ/TVdqgD9NXUUZpCV67ErxwvJkB
 Nnpkq3kBb5ika0eBaOyreB4SNF5Extk6w+10nRLK7+Ei0VVwV++rECjU3idQGpT/uQmb
 WCoqM7/T+e57ASsyN3EbMqbYHUN52OOlL6bow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776072187; x=1776676987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rkfdQl5o/95RN5trxCmFHCvaQaWp54iAYT6nSL+SCRg=;
 b=lEzDEUK2A2hJX3sUmzw1OWnXatRiKLVXszmI/attlXojAKFu/lJ9bbgexsNicXytUd
 vdZAsETMJ/4olCXD6LR8zCTqrLGkxrV5/q+kTrQQ3hlW8FEvkKqFWktBWpuP96A6wjaW
 h8IvMzk8kV73sE64D76KjQTR4/O3LBoEiPcWIYX8DaFxPz4MontEdI7x7HmvRra1OQXG
 HtR3sG4JJ4JQ051VLmKdwCIkdmzTwpdwaWTmzhZHb3tVpJRAlDGvGerj0L0rNkRElTs0
 QxqZ1uEOCyXzoXl+yOtFNylh/PffAwQ8iy19Ms/ZDRrL6zDOVknKnBcGUHy6kTrfNrNS
 JjRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nU3sN0+kNn1YbXhiXvzKyNzeKdJRMY2A+MtOFPkvq3QVQneiROqiEpO5iYmJ3SLI5rel0+eY=@lists.denx.de
X-Gm-Message-State: AOJu0YwXLSHz31Zq3AOFw61Q2p+7dN2rdESUVin/BuaEq/fhnnVqp03N
 L8nL46e4rlcem+z9wP3QUqhJwsLF+JEN1NUfftIZ+iYUIW4WLPzimSBra9xb15oQcdc=
X-Gm-Gg: AeBDiev3EkvyBVr2fwlDYPi/379YUs8SwuqmJjTxDfQUo4Qyj53o1I9K2snJnoNzRMA
 icSNWIrCOHmzIvBBAcPbRyGK/ROct+EcPgWWcgUNEC3MXvDguns2aA9XyBCJYDJJ8h7DlS+f14j
 x4T2fjbfloImzX77jwluvJaSWKMv+hlwimMLxdhaIdhSGvo9J7sun4+YdkCA9K2n/HeSfYRk07q
 LTPzxJAWnlwwN0SYUfSN+k5b+Y9x748JQVy/OVJ9Cwcd5aY4RLc6jrqqq8PIprt9XEAlN/UcmEH
 He7/z3fZo7h6HZxsqpPZJ1g5AUV/QxjPpB9knE/7z5ZxbY3nBHdFK0OrwIYysFhazvorfuInAZq
 I7fXZQYet/wpELcSO4V/AO20j5FrzYai35QWjTYVgt3NnEwWlBlya7pcKSBYIl3EuLhXBrSzJfS
 SWcSGZx3YhWW7BYA==
X-Received: by 2002:a17:90b:5625:b0:359:f43d:4a6e with SMTP id
 98e67ed59e1d1-35e424548aamr14816401a91.0.1776072187530; 
 Mon, 13 Apr 2026 02:23:07 -0700 (PDT)
Received: from kinako ([2400:2200:776:9b18:a191:7a74:9fd8:591b])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-35fb617725esm1055930a91.1.2026.04.13.02.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 02:23:07 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v4 3/6] virtio: mmio: Allow instantiation via platform data
Date: Mon, 13 Apr 2026 18:22:37 +0900
Message-ID: <20260413092240.3719260-4-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413092240.3719260-1-daniel@thingy.jp>
References: <20260413092240.3719260-1-daniel@thingy.jp>
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

The m68k QEMU virt machine doesn't use devicetree, yet, so
allow it to create virtio-mmio instances via platform data.

Signed-off-by: Daniel Palmer <daniel@thingy.jp>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 drivers/virtio/virtio_mmio.c | 27 ++++++++++++++++++---------
 include/virtio_mmio.h        | 12 ++++++++++++
 2 files changed, 30 insertions(+), 9 deletions(-)
 create mode 100644 include/virtio_mmio.h

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 1cd737aca249..28b46ab66238 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -12,6 +12,7 @@
 #include <virtio_types.h>
 #include <virtio.h>
 #include <virtio_ring.h>
+#include <virtio_mmio.h>
 #include <linux/bug.h>
 #include <linux/compat.h>
 #include <linux/err.h>
@@ -335,21 +336,28 @@ static int virtio_mmio_notify(struct udevice *udev, struct virtqueue *vq)
 
 static int virtio_mmio_of_to_plat(struct udevice *udev)
 {
-	struct virtio_mmio_priv *priv = dev_get_priv(udev);
+	struct virtio_mmio_plat *plat = dev_get_plat(udev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(udev);
 
-	priv->base = (void __iomem *)(ulong)dev_read_addr(udev);
-	if (priv->base == (void __iomem *)FDT_ADDR_T_NONE)
+	if (addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
+	plat->base = addr;
+
 	return 0;
 }
 
 static int virtio_mmio_probe(struct udevice *udev)
 {
+	struct virtio_mmio_plat *plat = dev_get_plat(udev);
 	struct virtio_mmio_priv *priv = dev_get_priv(udev);
 	struct virtio_dev_priv *uc_priv = dev_get_uclass_priv(udev);
 	u32 magic;
 
+	priv->base = (void __iomem *)plat->base;
+
 	/* Check magic value */
 	magic = readl(priv->base + VIRTIO_MMIO_MAGIC_VALUE);
 	if (magic != ('v' | 'i' << 8 | 'r' << 16 | 't' << 24)) {
@@ -405,11 +413,12 @@ static const struct udevice_id virtio_mmio_ids[] = {
 };
 
 U_BOOT_DRIVER(virtio_mmio) = {
-	.name	= "virtio-mmio",
-	.id	= UCLASS_VIRTIO,
-	.of_match = virtio_mmio_ids,
-	.ops	= &virtio_mmio_ops,
-	.probe	= virtio_mmio_probe,
+	.name       = "virtio-mmio",
+	.id         = UCLASS_VIRTIO,
+	.of_match   = virtio_mmio_ids,
+	.ops        = &virtio_mmio_ops,
+	.probe      = virtio_mmio_probe,
 	.of_to_plat = virtio_mmio_of_to_plat,
-	.priv_auto	= sizeof(struct virtio_mmio_priv),
+	.priv_auto  = sizeof(struct virtio_mmio_priv),
+	.plat_auto  = sizeof(struct virtio_mmio_plat),
 };
diff --git a/include/virtio_mmio.h b/include/virtio_mmio.h
new file mode 100644
index 000000000000..8c072826db55
--- /dev/null
+++ b/include/virtio_mmio.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __VIRTIO_MMIO_H__
+#define __VIRTIO_MMIO_H__
+
+#include <linux/types.h>
+
+struct virtio_mmio_plat {
+	phys_addr_t base;
+};
+
+#endif /* __VIRTIO_MMIO_H__ */
-- 
2.51.0

