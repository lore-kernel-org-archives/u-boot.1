Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934D7CD4F25
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 07:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17BBA846A5;
	Sat, 16 May 2026 09:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="Pw64oRrQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C0088469F; Sat, 16 May 2026 09:40:51 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF7148468A
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 09:40:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3665b67ed66so278703a91.1
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1778917247; x=1779522047; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l3vVYO8fIoypQp4FXj3YBXQPHD7ZxFuh4viqlm5RXfg=;
 b=Pw64oRrQYcfIDJbrAcbXwvyK2rseDC058kTRhxL32EFIWs/EcMEfNSmgXQ7dOcjPDw
 nJ7HNTzzKGFNPetePyRuS9HfMKH0um3sxKosItGvHahzKiXo2iDXqA1B8piMLe1WeZHn
 MCXcQv/0USpdgV7TR1B3TmJ5XkP0GIlTZT7Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778917247; x=1779522047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l3vVYO8fIoypQp4FXj3YBXQPHD7ZxFuh4viqlm5RXfg=;
 b=AFZfAY6Tw+jO7bwpvw5HsoL2hcDaUL0IgpGU9kIjItebkieTiNYJg6AfbW1ziWZ8PD
 VGUXbVBXTNsG1UblrOi93MaOKD17QXFpMowUYI/SKqigz3SANl31WeshThyQoWxHndF3
 mGkbmN3dbyEG4MhoAVV8Tgntwb9dEzaan+DYScCYEhrKbd2jmVjR7e6HtKZyhbIQLPgz
 tToFiBLLm1fPQ75lt2QkAQx3De/pzeQLQsQAiPcSQmZf/9Tm/bIeNAzIfHGQkJYhZhUV
 Og0UoZWtOuMgAmT4rB966aNTrxwnzcQrdUPXrv0xpOWWXC/kiT1Li+mJOc7z9tHiS0hm
 6ftQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8DXS6SQDOZTRLTp/A+Nbghbvy4bZRe837v+IrHlF7OCUoRvFv3jbeKWP9M7ODYAgshJ5Hm/0E=@lists.denx.de
X-Gm-Message-State: AOJu0YwkZeehDO/klf0q8kWZkG/aTp0Jrasln7I95Bcgmt2c6fsbycBM
 BWm44u/FS2ILDxp3CkLz74CmxCI9cDmO/O5pZAXD+KPy29J2UDXLVh+aPTv6xgwfcz4=
X-Gm-Gg: Acq92OEWzdZTJPG5wDarvfNdIA8Gi7NTwFxSob/gOD66U9jFy57uLm9qUxz2GWSsT2j
 Mr+LVc8UCQXMCejUqhZ6XuXKjnPikBt1cAYYk5LxhTYLQGRwD49MgrZWBg2RXrh789OJThMxM6l
 Po1M6gx1KVLlMoJCRRLK91AIBbkvy/eS+gYNmXUwq8t4TaxboUflGuFhgjbj39zY8hIXo5E6aDX
 YH9Nuq7Nirwe9H0pmpsAxtQHQUWzE0c6+UnqQlole6pVq/4dx/wnZuJvm2ySC93WD5gmVmGENcY
 kPG3d6s/nc38CziJvwUC2I2DGBWyD7erioT21zFftzURduoiwTtT6+mBuKUC1ZClGaRwahPWRVD
 UV62tjoBIiWxUGpq4IivvMhuF34wCCnQlHYCuKaNBaNje5H7eyCivFUVv96yjRcI/Ycz+X/yGDf
 9qn1jEZSg5KPSNf6vel75qhFdbZOd8k7N9HPmVEH2OwBtMElWf1FOcaVQxlAyGBaIkVsD/R71E+
 u5HpG02FgCBe7tl5d+uHSgD
X-Received: by 2002:a17:90b:3d82:b0:365:d46a:524 with SMTP id
 98e67ed59e1d1-369519c6bc4mr7443351a91.2.1778917247478; 
 Sat, 16 May 2026 00:40:47 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1620034-ipxg00d01sizuokaden.shizuoka.ocn.ne.jp. [122.29.136.34])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-369514361b6sm4702672a91.12.2026.05.16.00.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 00:40:46 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: 
Cc: Daniel Palmer <daniel@thingy.jp>, trini@konsulko.com, visitorckw@gmail.com,
 angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: [PATCH v7 6/9] virtio: mmio: Allow instantiation via platform data
Date: Sat, 16 May 2026 16:39:58 +0900
Message-ID: <20260516074016.885146-7-daniel@thingy.jp>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516074016.885146-1-daniel@thingy.jp>
References: <20260516074016.885146-1-daniel@thingy.jp>
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
index d90d8309f991..975f98cd9e5b 100644
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

