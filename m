Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85FB0CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 23:52:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFE4986AE9;
	Mon, 16 Oct 2023 01:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JJcnXuDv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E295986BCF; Mon, 16 Oct 2023 01:50:58 +0200 (CEST)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E00AB868AE
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 01:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ca82f015e4so751325ad.1
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 16:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697413834; x=1698018634; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h+uhty0GdC8R49rdJSut4WnZ0t+PDDOC92B5xrfeuT0=;
 b=JJcnXuDvDgMUJR2msvAFK4RvfvusrNf07/+Aai/jTQ3egXrMBRttgYDlbvOSRfkDKj
 DxBwXkZ6TBmS22CLPfpy7JExWvurYZOqx9wFfzfoZ7UdsL/YhS5B91sx2uG9i4mcYnp1
 BTBYdkKKR5TvjcP6XsvmLBb7oSJzUxTZdvwMI6AuL3Rh41scKlpzbsBRsuJFqW4q0B1e
 uyrhqmofwbWgJv7AMWc5TZdB91om5rGEuT4ynIzv+6KRWPuM56iL6qbapcOu/ENSGXP7
 vsSpfuCEKJ+uw2Z5YGdkmlmXPbLZePkZNGZ5u4qBNuKTb4mOUotQtUbfZGV8Kp9xAABU
 StUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697413834; x=1698018634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h+uhty0GdC8R49rdJSut4WnZ0t+PDDOC92B5xrfeuT0=;
 b=FzuRhpVp1RIFKXime177pK13H/gYvZUdFDh9xc98k+/FabpvfmGGhW66WZFplONjqv
 jQZ2H2ZVy7erBsgNfqCvykpLlsXPjNF4PaWKQzzKfwT7Hln/q+oL92CaH1QRlG5p1SL6
 /qCrbJ9nwLtpY1ujE1a362a8YRr6L/kX9fSFViwhORgqGBveZj+04Vdz7fGfP5omTAxv
 MnYVcTrnRNHK83IZtVouplJdFaQttVn1Yj4SPSgMi25C83zQLn35rJfAcnlWVxPayKjz
 eyfboMHh+3q3q7Yh0g08McNnmuWhrBjKDbzSrgoD1YUx+XrcZbThC1e02T5Vq7XoDqMy
 1Y+g==
X-Gm-Message-State: AOJu0YwV6gjGSV4qL0E5UCnRCD12s9RDnHq1mmvbkybav+1R69V5aXRc
 MH7QufKnLPiIdy2tIe8hkd55egnUQcsPEEB4W2w=
X-Google-Smtp-Source: AGHT+IHJYnUi8eMwN7LYzSsrWba8Xig9sGAOfn6Trcd3P6S9sFZxswEhwc7RHR9/TQedJQcn0xHI6w==
X-Received: by 2002:a17:903:41c1:b0:1c6:30d1:7214 with SMTP id
 u1-20020a17090341c100b001c630d17214mr31839834ple.55.1697413834264; 
 Sun, 15 Oct 2023 16:50:34 -0700 (PDT)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 21-20020a170902c21500b001c771740da4sm6045570pll.195.2023.10.15.16.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 16:50:33 -0700 (PDT)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v6 3/9] blk: blkmap: add ramdisk creation utility function
Date: Mon, 16 Oct 2023 08:49:01 +0900
Message-Id: <20231015234907.2362717-4-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
References: <20231015234907.2362717-1-masahisa.kojima@linaro.org>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 drivers/block/Makefile        |  3 +-
 drivers/block/blkmap.c        | 15 ----------
 drivers/block/blkmap_helper.c | 53 +++++++++++++++++++++++++++++++++++
 include/blkmap.h              | 29 +++++++++++++++++++
 4 files changed, 84 insertions(+), 16 deletions(-)
 create mode 100644 drivers/block/blkmap_helper.c

diff --git a/drivers/block/Makefile b/drivers/block/Makefile
index a161d145fd..ec0575d135 100644
--- a/drivers/block/Makefile
+++ b/drivers/block/Makefile
@@ -14,7 +14,8 @@ obj-$(CONFIG_IDE) += ide.o
 endif
 obj-$(CONFIG_SANDBOX) += sandbox.o host-uclass.o host_dev.o
 obj-$(CONFIG_$(SPL_TPL_)BLOCK_CACHE) += blkcache.o
-obj-$(CONFIG_BLKMAP) += blkmap.o
+obj-$(CONFIG_$(SPL_TPL_)BLKMAP) += blkmap.o
+obj-$(CONFIG_$(SPL_TPL_)BLKMAP) += blkmap_helper.o
 
 obj-$(CONFIG_EFI_MEDIA) += efi-media-uclass.o
 obj-$(CONFIG_EFI_MEDIA_SANDBOX) += sb_efi_media.o
diff --git a/drivers/block/blkmap.c b/drivers/block/blkmap.c
index 149a4cac3e..21201409ed 100644
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

