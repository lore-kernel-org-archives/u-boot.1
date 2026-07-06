Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CA2C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 21:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 281AF849D2;
	Mon,  6 Jul 2026 23:55:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h/hnT8lu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A593D84997; Mon,  6 Jul 2026 23:55:14 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6627E801A9
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 23:55:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c9c80265bd7so2007872a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 14:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783374911; x=1783979711; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mGfJFPvpHOlcqBjkELyD/HqaSenV7dz9usPffjehtbo=;
 b=h/hnT8lufyGsPJ/VNu/cqUFUn2qwux+nga9etalfZnVMjok8yt3wvguG6l+4ePepyp
 NuLolCG/jJ5UflyEVSmfqJa9tM3q1lfeyHDp0v25cVLPplNgCSUOULycnfYZHcwDUk28
 5GloQ+Qdfqg0Dv16bdZSs251jGqfJ9OkaMqNs3DZRwfKFxcnOFL24MS2K0lRtRyBQ6jn
 RL8xbHwvIbcU1FDZ+JvUNE3mcYzTZBRXmW6M2JOzLJOKWRNkxAXiBAyL7Sll4lRBQ8ZQ
 tPBkwn6BKIsTJ6JNyEivopsC9TA4x6PTpCb024czVvPa3GHaAPVc42UcRs16iARcNWIr
 v0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374911; x=1783979711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mGfJFPvpHOlcqBjkELyD/HqaSenV7dz9usPffjehtbo=;
 b=EnLHkezT2PJqF5eX2GqMJDHEbX3W+R5Eze4KPsnF8f7IXGHlQScshSWGaUhbT4l4Gl
 wT0H2rEn/2p8PQ3cQkp4Jt9BxThWSlBHK03nf0d33IP7SxXF1GdOu3RryR5R0EpTPUQ8
 qYNRBICeRH96gt4GeWVm75fNX92U7ZG0hbvBLeqMX5hady4v4RRGe29obo8Xu5ruul6V
 wS74qmcHH2TBAR0wfLeantQ2aLBFkpW4maMw0BFp7Lr5298n5Oo7nTKT3bZmoRs87Q1P
 1TccnYe6neY/YS8vkeZhubHplKjQPqX13ju7QC9Vk3bfVQcThWAVCTjN+OHGVrralr8t
 ZY+g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5/3uwnR4qpmCfiqFHGu0dwgzIRxEvX6QiAAcosPTwI5r5X4BWB+1LxMl9WUjdVh5inoCFcaQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxMAGrHKz7N+ttVgF+F8DQ3tmK+mprAdoYjnLBEcKeFWh7goVFq
 9kdGugUFbwgp2IWMrs27POnl4ILSF2Xl8QpWRjgoPZbU50rlQ4Bbtuvy
X-Gm-Gg: AfdE7cm+0RosmaQlRGjkzd0PmHIyEkZPreoHAAiZ6I01LMgRHDY7QKl7/r0melyngjG
 twWasKjnyPdHdcQ6oVQTUTgSha+6XFgP3NMjyEBjyfEJp8HMIBflc6r3CmVMim0wZrVfhCSz4Ir
 +5/LvcYlS4RTQ6la25qZTNRabP3uagE7ZdzdnyrCXI0AgmtuEx8SEIPB/2mJCyfJtetJlNWpCqL
 qq3acOsVCjPfGpuqnJmaBoXxyepEmt146XVFsrwOGtyRF6++dVhZRxqdxLGmJ4zbsz3UDLga3az
 VV0Zng7wW7OpH95omh1goFCDdik7EITpGWt9ym4p9SnGbzYkQZSuSRzqmAPMGxr5EAxM/X3+mC8
 LQkksEZuTL+WnnSLMrnqjR1oG7uf4cT/HRh8BPIC9rKlhQHsZPdzBEE6az/hUHLBpGE7ltBL950
 YtLmOeI3OACt/bW9EX5j87DL483pjDFZ/wxvnXloMiFl6EEPNbCtmEUdlYqJ2wLDTp1W5mqHho4
 KfAtiSVNrhY2pyB/eTYN/k=
X-Received: by 2002:a05:6a20:d10f:b0:3bf:ab02:439e with SMTP id
 adf61e73a8af0-3c08ede1377mr2972489637.27.1783374910650; 
 Mon, 06 Jul 2026 14:55:10 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com
 (32.237.80.34.bc.googleusercontent.com. [34.80.237.32])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56d64sm650864eec.17.2026.07.06.14.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:55:10 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: trini@konsulko.com, bmeng.cn@gmail.com, joe.hershberger@ni.com,
 rfried.dev@gmail.com, jerome.forissier@arm.com
Cc: jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, marscheng@google.com,
 u-boot@lists.denx.de, Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 3/4] virtio: 9p: Add 9P transport driver
Date: Mon,  6 Jul 2026 21:54:45 +0000
Message-ID: <20260706215446.4068820-4-visitorckw@gmail.com>
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
In-Reply-To: <20260706215446.4068820-1-visitorckw@gmail.com>
References: <20260706215446.4068820-1-visitorckw@gmail.com>
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

Add virtio transport driver for the 9P filesystem.

This driver binds to the virtio-9p device exposed by the hypervisor and
registers the transport operations with the 9P client framework. It
implements the transmit and receive routines.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/virtio/Kconfig         |  7 ++++
 drivers/virtio/Makefile        |  1 +
 drivers/virtio/virtio-uclass.c |  1 +
 drivers/virtio/virtio_9p.c     | 75 ++++++++++++++++++++++++++++++++++
 include/virtio.h               |  4 +-
 5 files changed, 87 insertions(+), 1 deletion(-)
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
index 00000000000..e37c9c37c4b
--- /dev/null
+++ b/drivers/virtio/virtio_9p.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026, Kuan-Wei Chiu <visitorckw@gmail.com>
+ */
+
+#include <9p.h>
+#include <dm.h>
+#include <cpu_func.h>
+#include <virtio.h>
+#include <virtio_ring.h>
+#include <virtio_types.h>
+#include <asm/cache.h>
+
+struct virtio_9p_priv {
+	struct virtqueue *vq;
+	struct p9_client client;
+};
+
+static int virtio_9p_request(struct p9_client *c, void *tx, int tx_len, void *rx, int rx_len)
+{
+	struct virtio_9p_priv *priv = c->priv;
+	struct virtio_sg sg[2];
+	struct virtio_sg *sgs[2];
+	int len;
+
+	sg[0].addr = tx;
+	sg[0].length = tx_len;
+	sgs[0] = &sg[0];
+
+	sg[1].addr = rx;
+	sg[1].length = rx_len;
+	sgs[1] = &sg[1];
+
+	flush_dcache_range((ulong)tx, ALIGN((ulong)tx + tx_len, ARCH_DMA_MINALIGN));
+	flush_dcache_range((ulong)rx, ALIGN((ulong)rx + rx_len, ARCH_DMA_MINALIGN));
+
+	if (virtqueue_add(priv->vq, sgs, 1, 1))
+		return -EIO;
+
+	virtqueue_kick(priv->vq);
+
+	while (!virtqueue_get_buf(priv->vq, &len))
+		;
+
+	invalidate_dcache_range((ulong)rx, ALIGN((ulong)rx + rx_len, ARCH_DMA_MINALIGN));
+
+	return 0;
+}
+
+static const struct p9_trans_ops virtio_9p_ops = {
+	.request = virtio_9p_request,
+};
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
+	priv->client.ops = &virtio_9p_ops;
+	priv->client.priv = priv;
+	p9_register_client(&priv->client);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(virtio_9p) = {
+	.name       = VIRTIO_9P_DRV_NAME,
+	.id         = UCLASS_MISC,
+	.probe      = virtio_9p_probe,
+	.priv_auto  = sizeof(struct virtio_9p_priv),
+};
diff --git a/include/virtio.h b/include/virtio.h
index 3edf023463d..7b3f466220f 100644
--- a/include/virtio.h
+++ b/include/virtio.h
@@ -31,11 +31,13 @@
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
 
 /* Status byte for guest to report progress, and synchronize features */
 
-- 
2.55.0.rc2.803.g1fd1e6609c-goog

