Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9689DCA0FE6
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 10:27:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EC36868B8;
	Fri,  1 Sep 2023 12:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k4Q5N0Wi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC05386900; Fri,  1 Sep 2023 12:26:41 +0200 (CEST)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0549F868B8
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 12:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c0d5b16aacso14306085ad.1
 for <u-boot@lists.denx.de>; Fri, 01 Sep 2023 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693563996; x=1694168796; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96BtuKz6Nt+rW/pzCpyzhAIQGlcGujDJNae48u8P4dQ=;
 b=k4Q5N0WiWpYGShLOEFv7xFzwdaLxp+Ig6tThzL4+HHeNfg71H9IbMx12UHQY84R2lI
 udf9FdkQ5od5KHdqn638/GlWhErswkDAnqTAl3iEiNt1O+N3zLjHCEV7XYrK7rTcSO5Y
 JfuXSDksJOJ6RnaXsZAR4EZS7rizI7RzmWEP0loaH6h65Q2AyRCl+6LULu5+KLZFNTeV
 XpdTSwfDRGm+PsQICzmfdlWV/VLmCkihGxHwD3iy28Xycwz9AHD/Ci98nsjhAep46+pX
 KDkkCBJXzUpxjD+KxC0aS+Ix9dLUcmVNZmanNxtVF6umTwkCtE9Nr7iW24AJPR+wSgNq
 saJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693563996; x=1694168796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=96BtuKz6Nt+rW/pzCpyzhAIQGlcGujDJNae48u8P4dQ=;
 b=RzCR44YzeXmnRL/YLnK5cyRkKSYcaRPg/MvXY8LbxTIVuLXt547AslgtJHLl5AAlZV
 xWAvNoqfxMCnAaiGJs4g9sqEMWBvO4LtXE4UyEPxrVAEy/kFlRS0g0QKdn8OKQHu/QYx
 nrKjuEGiJI3tUbSJxqo5zTmDtswYOQjfFzl1ZNWOB4Pd5Qu6h2sd8TlLGbQeXGpmbfo4
 BN3uMSiWgic23FwPUYf++MLJmA4m296fDqWqKpyLudYoHorG1zveuBpnXh+XcndLPfxj
 1XTRwN9jKBLuz/HTOKFl9dK7TDQ0+7j1BjsK1ba/U9g2qgT2oz9m0f2Qsnrz3qpfYUA2
 DZKg==
X-Gm-Message-State: AOJu0YxuM8s8I38pDx7eM0tMjOgAePISf1b9p/+/iDLL7OxUOGsmXnmV
 on37H2GLAdyI9s9twNUUNgtj1JcgzSCK3zKwQ7w=
X-Google-Smtp-Source: AGHT+IGWfpAtvP34xb+jw8m0OAYfyKtQ2oXjcv6WZrdjbkHnt6kFlqfw8vVGeIu5v6BnxVOkgPl9vA==
X-Received: by 2002:a17:902:e80a:b0:1bd:d718:5833 with SMTP id
 u10-20020a170902e80a00b001bdd7185833mr2209785plg.18.1693563996068; 
 Fri, 01 Sep 2023 03:26:36 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 g15-20020a1709029f8f00b001bba3a4888bsm2691892plq.102.2023.09.01.03.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 03:26:35 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2 3/6] blk: blkmap: add ramdisk creation utility function
Date: Fri,  1 Sep 2023 19:25:39 +0900
Message-Id: <20230901102542.609239-4-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901102542.609239-1-masahisa.kojima@linaro.org>
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
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

User needs to call several functions to create the ramdisk
with blkmap.
This adds the utility function to create blkmap device and
mount the ramdisk.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/block/Makefile        |  1 +
 drivers/block/blkmap.c        | 15 ----------
 drivers/block/blkmap_helper.c | 53 +++++++++++++++++++++++++++++++++++
 include/blkmap.h              | 29 +++++++++++++++++++
 4 files changed, 83 insertions(+), 15 deletions(-)
 create mode 100644 drivers/block/blkmap_helper.c

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index a161d145fd..c3ccfc03e5 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -15,6 +15,7 @@ endif
 obj-$(CONFIG_SANDBOX) += sandbox.o host-uclass.o host_dev.o
 obj-$(CONFIG_$(SPL_TPL_)BLOCK_CACHE) += blkcache.o
 obj-$(CONFIG_BLKMAP) += blkmap.o
+obj-$(CONFIG_BLKMAP) += blkmap_helper.o
 
 obj-$(CONFIG_EFI_MEDIA) += efi-media-uclass.o
 obj-$(CONFIG_EFI_MEDIA_SANDBOX) += sb_efi_media.o
diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
index 2bb0acc20f..4e95997f61 100644
--- a/drivers/block/blkmap.c
+++ b/drivers/block/blkmap.c
@@ -66,21 +66,6 @@ struct blkmap_slice {
 	void (*destroy)(struct blkmap *bm, struct blkmap_slice *bms);
 };
 
-/**
- * struct blkmap - Block map
- *
- * Data associated with a blkmap.
- *
- * @label: Human readable name of this blkmap
- * @blk: Underlying block device
- * @slices: List of slices associated with this blkmap
- */
-struct blkmap {
-	char *label;
-	struct udevice *blk;
-	struct list_head slices;
-};
-
 static bool blkmap_slice_contains(struct blkmap_slice *bms, lbaint_t blknr)
 {
 	return (blknr >= bms->blknr) && (blknr < (bms->blknr + bms->blkcnt));
diff --git a/drivers/block/blkmap_helper.c b/drivers/block/blkmap_helper.c
new file mode 100644
index 0000000000..0f80035f57
--- /dev/null
+++ b/drivers/block/blkmap_helper.c
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * blkmap helper function
+ *
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <blk.h>
+#include <blkmap.h>
+#include <dm/device.h>
+#include <dm/device-internal.h>
+
+int blkmap_create_ramdisk(const char *label, ulong image_addr, int image_size,
+			  struct udevice **devp)
+{
+	int ret;
+	lbaint_t blknum;
+	struct blkmap *bm;
+	struct blk_desc *desc;
+	struct udevice *bm_dev;
+
+	ret = blkmap_create(label, &bm_dev);
+	if (ret) {
+		log_err("failed to create blkmap\n");
+		return ret;
+	}
+
+	bm = dev_get_plat(bm_dev);
+	desc = dev_get_uclass_plat(bm->blk);
+	blknum = image_size >> desc->log2blksz;
+	ret = blkmap_map_pmem(bm_dev, 0, blknum, image_addr);
+	if (ret) {
+		log_err("Unable to map %#llx at block %d : %d\n",
+			(unsigned long long)image_addr, 0, ret);
+		goto err;
+	}
+	log_info("Block %d+0x" LBAF " mapped to %#llx\n", 0, blknum,
+		 (unsigned long long)image_addr);
+
+	ret = device_probe(bm->blk);
+	if (ret)
+		goto err;
+
+	if (devp)
+		*devp = bm_dev;
+
+	return 0;
+
+err:
+	blkmap_destroy(bm_dev);
+
+	return ret;
+}
diff --git a/include/blkmap.h b/include/blkmap.h
index af54583c7d..0d87e6db6b 100644
--- a/include/blkmap.h
+++ b/include/blkmap.h
@@ -7,6 +7,23 @@
 #ifndef _BLKMAP_H
 #define _BLKMAP_H
 
+#include <dm/lists.h>
+
+/**
+ * struct blkmap - Block map
+ *
+ * Data associated with a blkmap.
+ *
+ * @label: Human readable name of this blkmap
+ * @blk: Underlying block device
+ * @slices: List of slices associated with this blkmap
+ */
+struct blkmap {
+	char *label;
+	struct udevice *blk;
+	struct list_head slices;
+};
+
 /**
  * blkmap_map_linear() - Map region of other block device
  *
@@ -74,4 +91,16 @@ int blkmap_create(const char *label, struct udevice **devp);
  */
 int blkmap_destroy(struct udevice *dev);
 
+/**
+ * blkmap_create_ramdisk() - Create new ramdisk with blkmap
+ *
+ * @label: Label of the new blkmap
+ * @image_addr: Target memory start address of this mapping
+ * @image_size: Target memory size of this mapping
+ * @devp: Updated with the address of the created blkmap device
+ * Returns: 0 on success, negative error code on failure
+ */
+int blkmap_create_ramdisk(const char *label, ulong image_addr, int image_size,
+			  struct udevice **devp);
+
 #endif	/* _BLKMAP_H */
-- 
2.34.1

