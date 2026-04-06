Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5459EF46C46
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 14:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0352D840BE;
	Mon,  6 Apr 2026 16:24:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="iV6LBOFa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA3C584101; Mon,  6 Apr 2026 16:24:39 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0DE48341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 16:24:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35d9c7bf9a1so3595142a91.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775485476; x=1776090276; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJpbXycl8bPDKYjuPFFq8DJKD6pPqTPnXXlDYtn5IuE=;
 b=iV6LBOFaDj31yDEWws0RYYW2oOR5LUeWIL4/qCsIzb8pRTRgPJLp2J7HLCYsOAhuDC
 rgZy0Uyke8+l1qnPSLovC/jYswWeuPkKV86qjYGA5MePVKIL2hlQ3z8K+o0OdyW47qvh
 IE57Nfoiq0T9loYZglamcf4ChA/emzJX/dtCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775485476; x=1776090276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XJpbXycl8bPDKYjuPFFq8DJKD6pPqTPnXXlDYtn5IuE=;
 b=VfXLQRPUu00OvzfBK5Tf6sXvACaIo5q+OY+H6z86mUn2XlENc6GGGHW8lxRfnp6HfX
 y1Se9y+c9+mnEzywJ8QorCwYEaH2IzKeWdUSK/VZKUUBI9tj8LmdFnP/uhKIjtDI27E6
 6VKxX/gMgd6Nl8yjpw76ThRCH/A7PE1lOizbcId/bYbFPm0IMjlrIuC3gJHc11KvJqop
 MBm0t+MA04hiHf8yrx/alL8uzYITBfYxMxGvYO686UHPLlPYBS2f9C7JYaVdBc/YgeUu
 SyFY5wO8ialaFzXwcVaDPAMUrXPBs1+UA63Qr4TDVt73Cz0XGFR1r72NO+DGgeDAmpHw
 LMFg==
X-Gm-Message-State: AOJu0YwOKasjy9bb/cWgcupwuCyKEfvBAu7oesy5alDOL1SEzMSgMXIW
 JV/gRNgIvOQ+WXcHrvqo9TdVrOj0lO6L2XSPLA+bCBJMi2B8SYAmESMwnhUDywBI4YvqSKHOz7I
 RZefH
X-Gm-Gg: AeBDiev7k3NogYK9djsyhiKcaNC10dEDsftllrnlIzGyU7HejpLgoI/tKXrHF8pcRfk
 5vblipp3ZogwavxEVujqoBBA6e/mH1ES3h21VzDnB1mUbOJMc/U3/emjWi3DpA0Iwuyfl1riOwl
 8e1GjUsiTEh2+7GUtoNt8LCbziIHLlfz6H2Ajss7QyQVCYraaR3bVywtXih2LPmDlCnhnkSrnQ4
 q7aAeXPXyUrqCvu2VtHE0mjoqz09O1bC9cSZGrootRvJl5GKaIzDijDHNNlVt+hi91aMSzGLyYd
 MXGM7KWETTZCo/7rn/nWGgzXDRxcRNNE4+QdQHsPf2x+ljGe7fefCPQYAIFg1dq6e9tuYBQuXs+
 yOOORltKudRhFDUx8XKN/tyjO6zTjvdAbgKUxRx6TQdMSSiKEw8BRonMIRmJuspZULU+HL8RLpj
 R4xK4DmkHqADaMZ7Gl/K+vPBmOc0gqOr20KnkMWGogdDd90Ywte4MCahuBdbis7saH2n0btQlWn
 9B9CdXCzrs=
X-Received: by 2002:a17:903:3586:b0:2b0:b325:748a with SMTP id
 d9443c01a7336-2b281705e9fmr135455995ad.22.1775485476059; 
 Mon, 06 Apr 2026 07:24:36 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1866070-ipxg00f01sizuokaden.shizuoka.ocn.ne.jp. [180.1.30.70])
 by smtp.googlemail.com with ESMTPSA id
 d9443c01a7336-2b27478cb4fsm156885295ad.29.2026.04.06.07.24.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 07:24:35 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: u-boot@lists.denx.de,
	Daniel Palmer <daniel@thingy.jp>
Subject: [PATCH v2 4/5] virtio: mmio: Allow instantiation via platform data
Date: Mon,  6 Apr 2026 23:24:10 +0900
Message-ID: <20260406142411.2992618-5-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260406142411.2992618-1-daniel@thingy.jp>
References: <20260406142411.2992618-1-daniel@thingy.jp>
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
index ddf873fa96fb..51ef90c768af 100644
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

