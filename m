Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E3EFD2D9A
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 14:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 905038400F;
	Tue, 10 Mar 2026 15:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="YTqiNuWR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A58484010; Tue, 10 Mar 2026 15:01:27 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24C7083FDE
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 15:01:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-359863611faso3926625a91.3
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 07:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1773151283; x=1773756083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjhnktMvV4h2xi4fiomyQIaVW6APY0LL/5Fn6Tn8jRU=;
 b=YTqiNuWRW9uakM58z/MIdCGVFhHAVNmYtxIGaoYYiZ3WJJ0PWN3IaR4IeyKYOfB/ZS
 DUbbnVyItq3kpMRhn2RyVxqe6MODiLr6o/rfRTXEEH0/e7uCuIiZ9SQvVfvy+Xs8v8Jr
 ky4TQb/AdRcwEKcfZCGAcMZ/gGqOZxp55Kg08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773151283; x=1773756083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DjhnktMvV4h2xi4fiomyQIaVW6APY0LL/5Fn6Tn8jRU=;
 b=TDmqllc9nYgZfMdEAJkU7hnnf5FqPWVBvCcre7Er9MUO4esbuBV0eyaO2NwSUM6RSt
 1IYYH69XYtfXtDeg43Rma0aQgPl5A48CB33dbYo19AvkaSKMfy2vlcDuFlJpez+uct+G
 /OJHbnsYSsCBOe3aYZRzuvtReH1pGEY90hTsPdC8VlQWWEix8BaDTP2CSVOA6yRHtnPk
 aoPbP6ublPpcxt59aWPN83ZRKBEc2q7YLrUmI7FdDGlcr4/28jsopdLrx/QPWy4OPR8D
 +YWTo9xcJJgp6OmpZK78hXKNiXrdeMwkSkYsVPIaAgdkIZup3SsDXDTNZEzHr/jwDMqq
 t0Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX89MNiUpw58x5AYETqRvCH8e82bOjfkSt5uDrQJ+tN8uq2C5N5GIuUeTg2+9AWWxG85p6gkpk=@lists.denx.de
X-Gm-Message-State: AOJu0YwjY2sD9QbaPFtIsVtSgylXB1mUkOEpdPiCfR1ot3ngBbxWuDBk
 PIZtoZ1JslT5YfaBSODdc8vz6xBOpYdIen36f52ul/0G/a6ZuzqevA5oaepf8s6ELYXaHwO6ent
 jOu/5
X-Gm-Gg: ATEYQzxEIdDoTn+Q1K1bGszcb0GSE5fTKLCzVEXsZtlCy86B7rx1ECIvkBDcwQCy2Uc
 uiiF4RXZ81NAneFREmvzUkqZiemfKL2BgQnMZFNtd6dzCS799nTBIR8B/L8mapcXEdKyKpG+T/z
 RZhWhaik8HojISEazUq8Beb8oPJI82WQqqr7oz52Jtac6aP1EeaeYP1NKZ0n517tbuRR4KoKaPm
 qh3dwmPuisswgizm7KGEFDzbaSm+7rGGxoCig803htFbYGkWV9I2NrEfIPHBVFb3o4Ko3TiO6oT
 BlAGEPVg/8epoF9qlKgQxis0oEgfoHFKK4VkdiWMvWahUDWJy1SoAbUiol/tHVS6sNHKytCEXev
 BNXZCs4Y4D69MktZITfVPDDfB2Fib92mbHM8jB9MATmDqsBXTA+uqDMuM6qatINouoMw7sm3aIa
 G+la0bghHAU1BFGsQgCPw75eAE6Nllw0HIS1+T64C9dG+LanfU94koliy6sGOyztAGu1QC2Afpe
 ox6462s4RgNS3lc
X-Received: by 2002:a17:90a:fc45:b0:359:9224:6c26 with SMTP id
 98e67ed59e1d1-359be238ec4mr14345206a91.3.1773151276926; 
 Tue, 10 Mar 2026 07:01:16 -0700 (PDT)
Received: from kinako.work.home.arpa
 (p1766150-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.167.218.150])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-359bc9bd61fsm7863531a91.3.2026.03.10.07.01.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 07:01:16 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: visitorckw@gmail.com,
	angelo@kernel-space.org,
	bmeng.cn@gmail.com
Cc: laurent@vivier.eu, u-boot@lists.denx.de, Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH 1/3] virtio: mmio: Allow instantiation via platform data
Date: Tue, 10 Mar 2026 22:59:38 +0900
Message-ID: <20260310135940.1756141-2-daniel@thingy.jp>
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

