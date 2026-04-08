Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C79310FC459
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 22:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B5A98419C;
	Thu,  9 Apr 2026 00:10:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="lDTG5uxf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A73884198; Thu,  9 Apr 2026 00:10:01 +0200 (CEST)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D35D83DC9
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 00:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82c68339cf0so165240b3a.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 15:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775686197; x=1776290997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjhnktMvV4h2xi4fiomyQIaVW6APY0LL/5Fn6Tn8jRU=;
 b=lDTG5uxfpKS3cb6/wQis6ykPY51Rn47GzkoohOOj2I9lCcNuU/P+7wKdInckG5amMT
 SwDC+VgQDgjdYtQtQEhJyNvck9pqJH/r5kWU3TnixpVDqXaqmRVOHvObfBPeLoSrp3Uj
 xFq9D/3tLWrRHdzWJpxs0qxpVQy/XFiv/I5sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775686197; x=1776290997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DjhnktMvV4h2xi4fiomyQIaVW6APY0LL/5Fn6Tn8jRU=;
 b=WeISXqeiBX1PMLL9uocnIquKTgxYLufx//+plAZEmXKGhai1T+3K9Flgp0lgkIsGHZ
 B9tIizPk51yWTdzGzngoGTUyTwzMWGrcHtUBxwG7E9CUUUz6GjsvTlVN7BJaiq2Dbahn
 H+O6/Xgs2FWz/3hmkfmM1fohoDQ+VDYYPwchGcmOdZIV489dd5e5dCqSSw5XGTeVGUpk
 Jzawvaj2MLNMFHtq3+CUL8kyobifcvudjzi0IULc0boayrXSUyJqkn9bhub8qrc8auPi
 dT39PUYLkIurehTU4czDQ2/r8vXdsesWaPWU1xQoah/g69/mgxbjeXpetPhehV3OL4v5
 MAgw==
X-Gm-Message-State: AOJu0YwJjGj/m7AFkbRksKiYwsOTBnPLkDvRF8PZcB3LPjAzWgtP9SHe
 qY5HFOpTCQpX1CcadqpUjvkyVME3W7PhdkdNjvmFEwkCriEfutDOTBzm5x15yyWI64g=
X-Gm-Gg: AeBDiesUGqK3wF5W3UKy4OMqQRVFkrs4cUsUXvKAWa2mqk/dXSJmbq6RmxAVFw0Ui/9
 +q9gAeJLFdSQI2m9T5tK5c+rUWc405x5MiAoFwBkj3XQ+eixPu3h64DajAsFNfkw2TgrTMgs9QN
 DWza+v3kgJR8+jCJw0PVUrFQFSmC4It0jcHV5fMS1ieIVyaoQnIkWDrtApQNBQP3zvpwkDkxjJK
 XJCDnBbq2HTRgz18EBum+weralOytAmalq8kzJkeDN1iYp7qZLe40ydjM3MiBi/neIFwASwj+Xr
 Ap0lWFnvDzFRInwHxFMM5ccy4v7G3SXCmsicRvFmvV9x80H2BCYEC4Yz/hGrbM+BN5ou8SmzCxO
 7Gur0YkUaeqAbBCxWmyREoMmJTN9F8tXOVLtwLwhzbxjUZf7A4iiOfi/lMXtJr5OdQgavqlL26Q
 dFaJhrjE8Wn0o4
X-Received: by 2002:a05:6a00:f86:b0:81f:5acb:55fc with SMTP id
 d2e1a72fcca58-82dd8ab8823mr849944b3a.10.1775686197594; 
 Wed, 08 Apr 2026 15:09:57 -0700 (PDT)
Received: from kinako ([2400:2200:7f0:5ee8:dac6:2cde:760c:93f])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b60199sm19877723b3a.25.2026.04.08.15.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 15:09:57 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v3 3/5] virtio: mmio: Allow instantiation via platform data
Date: Thu,  9 Apr 2026 07:09:26 +0900
Message-ID: <20260408220928.3328551-4-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260408220928.3328551-1-daniel@thingy.jp>
References: <20260408220928.3328551-1-daniel@thingy.jp>
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

