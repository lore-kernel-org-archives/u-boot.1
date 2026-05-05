Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7241CD342F
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 07:50:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93A538484C;
	Tue,  5 May 2026 09:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="i7Jvkshz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D96E846E7; Tue,  5 May 2026 09:50:08 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCECE846F4
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 09:50:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-35fb0bb27e7so3163980a91.1
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 00:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1777967403; x=1778572203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4gWkeiGX3vR/zvMgtaYupU0xxdOGGCVeMMFMNDv/2w=;
 b=i7JvkshzK4xmo6mruHTzEIBCyIrFguydDlKZuBUZkUJoStu6qwGXxZTe5nKss553zj
 Dwb93FaZYY10AdaoIqnAhDNoqEzwR+zp8gErKDHfOuKhXTRIsMIYUtfGV/xCQ9bAZSjD
 D2mqRBZRE/Bk00g8+0NHme0hQ/pxiKp3ptmBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777967403; x=1778572203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g4gWkeiGX3vR/zvMgtaYupU0xxdOGGCVeMMFMNDv/2w=;
 b=Mv341Y8JPttpzdLQ7CGT6hDagujp2HDoNpswWno+8X0viPcWUP/dj0OzF20mjYzgZ3
 +nOfCVvfuMaV31ShqXtW7pTLYyyRlhbwcv8MztHTuZox2Fq7CUdGcYbItVMIp0ZxEMzY
 ZBrb32KD/G4nRPvEt0+bMRhT5xXDY9uKYAQvP5i3qbBfo/s7wx+EyTFjpMa33xc9zA7A
 8UAfa6T5kpkbFepM79G4QqTTUaOaA2yjT3FFR12Dxki20FE357BYCVolktQlrYhh5IKi
 1NPYOAgAdV2Tp40/hPcCA9RGfJZtF/PWK4lPNNstGaOjanGWK0Qg0GyTfEfLmQLHmrxl
 CyRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+VkmLUNtxLUmQN18R4Y/IJ/1nbyHnh1BUzrgPdBv4c2fgbJv9WM2egnrTPC4L0AyJKF9neydo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxb516Z76wDZAhwuIAc6ndNsyxR2t9BObQHQQcuNNcUVyEsMyK6
 wKFY1T97Vr0YPztfKmoCmbvhDkxXNL9blPZuuP+JrPPbibvClT/PzmLxHYDub5RI+KaAjN6Sb0T
 1+OtOJ0E=
X-Gm-Gg: AeBDieuYH/j7d+wwmlMMc/uE9hpfz3Ud+ZSfv/LBdW7IMarYE4osMoqW/dY151ka8NV
 lM5QUXmILPtTm7/43Cb8g9+h8cO/dksk1FhVc/J6lYmRpKd7cRrrGNtwrEqeWEgYBjWdG4ioIP8
 UoAJS0AEYSeP1tDyLENzOqKWIEWYMMBHz84Hfv1x1tLQOPMmQEUmxHXad5dwSqqgUgREUXpggKT
 e9aTqxPMdpUgee7la/7iH3iLKVAwrGtt4d1gVDu20qsmlMCKrcWmbzC64RbgSP6qGN2krEX/OsH
 q4jfsN8IqUzozdnmKYhcajAZ5CB6vdHmifojQAoVeermC6EdN/Q8rZAt4JlmiqlvB87eUaLdKR6
 T+pkOFIXxEAadtewNoHkI80mW528C//c9R2A/IT6te99L77LlsfeL5+IojRGAW1apuhhy07Ip7n
 wDkT+92Zk2t/pxCjtfdSTvVLQKGvVxQQN6h1ZUvO35AGje3t6kymQgw3kFeKOeIjqWsdFqxz4T7
 Pc2Nq7UZ296oey4M2b8AYkg2WU=
X-Received: by 2002:a17:903:1b4d:b0:2b2:eb9d:1648 with SMTP id
 d9443c01a7336-2b9f284c1efmr119251565ad.37.1777967403415; 
 Tue, 05 May 2026 00:50:03 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1387170-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp. [153.221.239.170])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2ba038ae95csm89160495ad.46.2026.05.05.00.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 00:50:03 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: trini@konsulko.com
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com,
 sjg@chromium.org, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v6 5/8] virtio: mmio: Allow instantiation via platform data
Date: Tue,  5 May 2026 16:49:38 +0900
Message-ID: <20260505074948.2603870-6-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505074948.2603870-1-daniel@thingy.jp>
References: <20260505074948.2603870-1-daniel@thingy.jp>
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
index 62afe609ec0a..f0286bcb3b8c 100644
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
 
+	priv->base = (void __iomem *)(uintptr_t)plat->base;
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
2.53.0

