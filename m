Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30706C4167B
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 11:08:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 510A38754B;
	Wed,  8 Nov 2023 12:08:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nDapdNSp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CCFF8755B; Wed,  8 Nov 2023 12:08:08 +0100 (CET)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F08588752D
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 12:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc921a4632so56514485ad.1
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 03:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699441674; x=1700046474; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IW6UuW0tl+AFM9nTW8wKwyaIsXdRioIs6zkSPzK/8Ik=;
 b=nDapdNSp06iLuNQa0m73zvzwiAEEmahc+hFseoCkjorzbAZ828obDrrUyLeDceKfiW
 Zb01duP3QLdZCglS5vpmjLd8KcJQSA2C83YGji8A4Mi2jX5o2Tkjf0BB7i84NjvJfUsa
 AHdDd6omVgBVK/9aHCDt1dn0qWqPlzzgZ97NVyNUp8aXI4HDL6aW4yisUK9nYq8yOVcr
 FuayAI+S6Af0xpgZP7tTsmw5Jw2qMrYlzyFbikHH3UseT7STUz9GbFbNs6USwEFcLe1W
 oPYshJWI3MlW50zv6MC/IKnA2WHSJWb4hjb3NON5JOg1hBW2DJHXfeYJjie1NB2USBcM
 4wKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699441674; x=1700046474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IW6UuW0tl+AFM9nTW8wKwyaIsXdRioIs6zkSPzK/8Ik=;
 b=eEeUDBN2ShywDA5f061bSlpazNCWhh95lVZlpAcy1qcjcG/VQbvhyrtfmCpxKBwmeA
 TrrJOptxSLQI27BMcSVuxmHiT3tNFat0K7GziqcVtnZX4Cp8GaOWqTT5XZ7i1Az2caOT
 sjvdR61O/Fvn7ntHZxv4EF9U/nOLWpN+piN5mSCuoLa8gaETXj8/MWMwKLBtSAW8eIYr
 a1jq7o9oI2SRpVL53MGXaYL9oi6e1MIje0vx7Hwixb8J6ccc1Uft8fncLirzR1WldCyL
 0iU9linu3fr2DzMusptciRZVqS9v52FJOJulKxj+12idhWK4l/ylaA7JxF2cxrWHqu3z
 usDQ==
X-Gm-Message-State: AOJu0YwLOQVfIhIQOaLWUvK/ffPCNmvxEMTeLjMdFGgqdYW7Pn0HH9v9
 EILye5KwmSV1LTuYZvOP6wsNEFGU9KtL/JIzPQ8=
X-Google-Smtp-Source: AGHT+IE6lhvYLv3+Fu/yvYtFyneEkTLxChmpuJkEKYcvDQu5e3eHIPiy7MZq3NcoWWip9M343cIRHg==
X-Received: by 2002:a17:903:2a84:b0:1cc:617e:9c25 with SMTP id
 lv4-20020a1709032a8400b001cc617e9c25mr2076768plb.53.1699441673969; 
 Wed, 08 Nov 2023 03:07:53 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 kx14-20020a170902f94e00b001c6187f2875sm1486269plb.225.2023.11.08.03.07.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 03:07:53 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Masahisa Kojima <masahisa.kojima@linaro.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH v11 3/9] blk: blkmap: add ramdisk creation utility function
Date: Wed,  8 Nov 2023 20:06:30 +0900
Message-Id: <20231108110637.3691441-4-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
References: <20231108110637.3691441-1-masahisa.kojima@linaro.org>
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
index 0000000000..bfba14110d
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
+int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
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
index af54583c7d..30dc84a7da 100644
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
+int blkmap_create_ramdisk(const char *label, ulong image_addr, ulong image_size,
+			  struct udevice **devp);
+
 #endif	/* _BLKMAP_H */
-- 
2.34.1

