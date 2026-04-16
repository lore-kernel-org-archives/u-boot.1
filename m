Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0553F8A146
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 09:40:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E4AC8426E;
	Thu, 16 Apr 2026 11:40:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="L8kq6JSG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDAF784277; Thu, 16 Apr 2026 11:40:12 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D05718424E
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c7358a7a8d1so5455977a12.3
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776332408; x=1776937208; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4PiDJZ8rojDndBMF+PjZLnqp9kCEYhALbd0T8EnB4Nc=;
 b=L8kq6JSGZQPgCPDE/gSKIkTrDOiwZLLulH/WWtUs2LGGq5oR/XDnqWu0wfMt8WP3TA
 KSB3TnmJ7H9RJMziAoDqSr6GxubTOHaC9GoXsPnVGn9V0nL4Kk6AQYIHAb5pXcH8pa1K
 Hn0pz4IA96Q++1lB9AreISajBOX48n+g/NXd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776332408; x=1776937208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4PiDJZ8rojDndBMF+PjZLnqp9kCEYhALbd0T8EnB4Nc=;
 b=keFUSGsBTbq/lfneouAkqCOIH/aQvPZ0va3C3io1h+IhP22D7vFEPvFFReXnrXrQ+5
 73+YBwCLj1buJ+nExU6QYLVni2FPDPbHgtztaO0d/no0CK7IGwIiG7o2YQ5uVZ00X8HB
 /9dpPPIbhtn5VT1tAO1YpISk7m+Iuk63AFPsOsTpsNcDSy5W5b0KUi0b0/6BxYP8QPKR
 MvX6dmkLOOdNqTo5+cIHNIgXnuw2HXz0eg22Pu08z5Z6MJfO7MyvZ16buIHYlsmPQqO8
 pByxXVEJeQNcx/rE3fF7I3631gfRALGO4T3ilrZZiAkJs4w05PTJtJLGg9ShItnG1LQ4
 jrTw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/18rbnbYj7oAMigc3ScZqaOSl12M94dwFZOSZ4eLq2HqONbnfxxHsY6WstU63hQ7ldCh074Sw=@lists.denx.de
X-Gm-Message-State: AOJu0Yx/Zwn6GbG4aD2qDwI02026MhALJ9yN3q2XZooyRAXLW8SHQciV
 GDafZkZHG9AI5Ng2JQ/xCR0rdRULSKwxBqSTkAv+uWZs/3EyZuWCvcuYKzRzeH3Q/bE=
X-Gm-Gg: AeBDies50/ZAexJ+oqBD/T1vTsHxVhHiJHO6pU8VtC94SaCkO+tNfs8mSWqrNlBut2f
 7CXQNnSZgcoBGAdTk1SmqQDt2JI7m8x7kJPQ6hjpFAr8Pa3FqTJtbj3U6QT/Jtq/bPWg25F3pZd
 R+G5KQbMYgns9L8uRYkn516F7ev1f5xejJeqTxEJgERnDmIqTKp5aMBerAG+fqBk4IaNfc4iDGe
 /Aj8ckIHqdWHCzfFCjJGsSmrbTwCI9QmPmtgftVTV5qqVvKZeRjXL+UXQeldhfGDuaT9ciWlo32
 /yu5yxaxUA0rEDWeBICXOuWQidePWEGWkVmOSW9qrKtj9SYOk5XbddVSxXCykt0DLrvcjjnjKL8
 QipqsKTqjVSIW65rILOgdHQxIw1ejEpLkrgVey5Z3lfp1g335+uUjCooKC3qS0J0yvj0+dcM7ff
 zIGp0+dMA9g76KlmYGi4SYpsMQaDDCQ7K1C8ou5oavtaTXaoj0OTnY4rrLbo9+aOkLuUwkR00Np
 P4Tw+H9x0PyFw==
X-Received: by 2002:a05:6a21:c2ce:20b0:39f:2dd0:65bf with SMTP id
 adf61e73a8af0-39fe3f3fb8cmr20232051637.28.1776332408253; 
 Thu, 16 Apr 2026 02:40:08 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1329195-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [114.145.5.195])
 by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-c79581a2fc2sm4423568a12.21.2026.04.16.02.40.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 02:40:07 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v5 5/8] virtio: mmio: Allow instantiation via platform data
Date: Thu, 16 Apr 2026 18:39:24 +0900
Message-ID: <20260416093927.602613-6-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260416093927.602613-1-daniel@thingy.jp>
References: <20260416093927.602613-1-daniel@thingy.jp>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Reviewed-by: Angelo Dureghello <angelo@kernel-space.org>
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

