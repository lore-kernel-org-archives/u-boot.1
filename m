Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33737E92FCE
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 23:09:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B1BD86C98;
	Fri,  6 Oct 2023 01:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LzpP/ccb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E76C286C0C; Fri,  6 Oct 2023 01:08:48 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F5B886BA0
 for <u-boot@lists.denx.de>; Fri,  6 Oct 2023 01:08:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-351208d0d6cso6256335ab.1
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 16:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696547321; x=1697152121; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SzttcXK/PKgI20uIB1bBvYt7CYS7s1sFWwjsGhMAXJU=;
 b=LzpP/ccbJW9flf2cJkWjqcDuVcMHdL6Shp6Foo7ZdW/3dM0u+ey2hDirMblbOt8wwy
 zVzbbiAGIl2bdUsd7kS0LTQqfy5hKYe5pzCxJ72jwxwq/BFeVcK/X56LhkFKXQPfzCRu
 FllQF3hbMyW5M7I3AfOG2g/+3l8jlFFgxqETU3j1bF2o9p72byxGTa1iRuWY0t5zveKb
 96ubgsllDKTRMz4yIlTF+KUsGOp1+zeocHOOhS0XVxtrblfuPKncrSGpHbw20P2xUyPs
 Sx/oM53srMPAYenGN7dW032zp9NK5ixP0HFlgP8C4Lzs0Pv+V1OFVtCdbVevdovfbF8p
 Zbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696547321; x=1697152121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SzttcXK/PKgI20uIB1bBvYt7CYS7s1sFWwjsGhMAXJU=;
 b=kMqL+wEcRsP+6WOkxiDQEozkjmwts0c3oX5XgpzXQ77gt5Qnua4bKcje3eR3VBqO0O
 YxtazHCot5Fljp1g8+dgFe+gzKza6H6D+sJqhpaCaWz6SNOmq+QXQ1NR7WpdxroD3jAJ
 bKhLm2hVjBkgxM9sB+/rI9LRuodAIqZHnpfgBV3L12lV0bAJw7wNXhPgobJMzplAAmVr
 OKKMckFod0knjMrJD8FBdHdebIU/pJ7DNAf04HYExR21HTZlDTU3nTz98LIZp+dYWtpK
 OsVVVAZQAKYmccVffqr5zntzccgZ7rptnCRa+LNKZPtdAFgihvEPBIhMVuJPcJtx7eQ6
 kRmQ==
X-Gm-Message-State: AOJu0Yyu1X5zZwvaDjRPwnErRC9VQG/vIeZFMHfnpc90spaTrqCv+Vl+
 3fXaK+jiRSFbDcBjmeoM4xr6UkchVY2+wQ==
X-Google-Smtp-Source: AGHT+IGA7eaOc9+KBcJZkyR2uxothx9yl6YSDx3b4+FsTJSWhKSsG3LqPacAlZe+46GnVCNVg0hqDw==
X-Received: by 2002:a05:6e02:930:b0:349:851b:3e48 with SMTP id
 o16-20020a056e02093000b00349851b3e48mr5629076ilt.28.1696547321311; 
 Thu, 05 Oct 2023 16:08:41 -0700 (PDT)
Received: from celestia.nettie.lan ([2001:470:42c4:101:9b88:f219:40c8:60fc])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a922811000000b003513b7613f3sm709974ilf.3.2023.10.05.16.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 16:08:40 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Schocher <hs@denx.de>,
	Simon Glass <sjg@chromium.org>
Cc: Kyungmin Park <kmpark@infradead.org>, u-boot@lists.denx.de,
 Sam Edwards <CFSworks@gmail.com>
Subject: [RFC PATCH v2 1/4] mtd: ubi: register UBI attachments as DM devices
Date: Thu,  5 Oct 2023 17:08:28 -0600
Message-ID: <20231005230831.4032070-2-CFSworks@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231005230831.4032070-1-CFSworks@gmail.com>
References: <20231005230831.4032070-1-CFSworks@gmail.com>
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

This is in preparation for exposing static UBI volumes as block devices.

A UBI uclass and driver are introduced, and a "ubi0" virtual device
with the proper driver is created below whichever MTD device is
attached as the active UBI partition. This virtual device will soon
be the parent for the BLK devices that represent the static volumes.

Signed-off-by: Sam Edwards <CFSworks@gmail.com>
---
 cmd/ubi.c                    | 11 ++++++
 drivers/mtd/ubi/Makefile     |  1 +
 drivers/mtd/ubi/ubi-uclass.c | 74 ++++++++++++++++++++++++++++++++++++
 include/dm/uclass-id.h       |  1 +
 include/ubi_uboot.h          |  5 +++
 5 files changed, 92 insertions(+)
 create mode 100644 drivers/mtd/ubi/ubi-uclass.c

diff --git a/cmd/ubi.c b/cmd/ubi.c
index 0a6a80bdd1..314c7f60f4 100644
--- a/cmd/ubi.c
+++ b/cmd/ubi.c
@@ -560,6 +560,13 @@ static int ubi_detach(void)
 		cmd_ubifs_umount();
 #endif
 
+#ifdef CONFIG_DM_MTD
+	/*
+	 * Clean up any UBI devices in DM
+	 */
+	ubi_dm_unbind_all();
+#endif
+
 	/*
 	 * Call ubi_exit() before re-initializing the UBI subsystem
 	 */
@@ -598,6 +605,10 @@ int ubi_part(char *part_name, const char *vid_header_offset)
 		return err;
 	}
 
+#ifdef CONFIG_DM_MTD
+	ubi_dm_bind(0);
+#endif
+
 	ubi = ubi_devices[0];
 
 	return 0;
diff --git a/drivers/mtd/ubi/Makefile b/drivers/mtd/ubi/Makefile
index 30d00fbdfe..375075f75e 100644
--- a/drivers/mtd/ubi/Makefile
+++ b/drivers/mtd/ubi/Makefile
@@ -7,3 +7,4 @@ obj-y += attach.o build.o vtbl.o vmt.o upd.o kapi.o eba.o io.o wl.o crc32.o
 obj-$(CONFIG_MTD_UBI_FASTMAP) += fastmap.o
 obj-y += misc.o
 obj-y += debug.o
+obj-$(CONFIG_DM_MTD) += ubi-uclass.o
diff --git a/drivers/mtd/ubi/ubi-uclass.c b/drivers/mtd/ubi/ubi-uclass.c
new file mode 100644
index 0000000000..f8971e793e
--- /dev/null
+++ b/drivers/mtd/ubi/ubi-uclass.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * ubi-uclass.c - UBI partition and volume block device uclass driver
+ *
+ * Copyright (C) 2023 Sam Edwards <CFSworks@gmail.com>
+ */
+
+#define LOG_CATEGORY UCLASS_UBI
+
+#include <common.h>
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <ubi_uboot.h>
+
+int ubi_dm_bind(unsigned int index)
+{
+	struct udevice *dev;
+	int ret;
+	char name[16];
+	const char *name_dup;
+	struct ubi_device *ubi = ubi_devices[index];
+	const struct mtd_info *mtd = ubi->mtd;
+
+	/* MTD partitions are not in DM; navigate to the real MTD device */
+	if (mtd->parent)
+		mtd = mtd->parent;
+
+	snprintf(name, sizeof(name), "ubi%u", index);
+	name_dup = strdup(name);
+	ret = device_bind(mtd->dev, DM_DRIVER_GET(ubi), name_dup, ubi,
+			  ofnode_null(), &dev);
+	if (ret) {
+		free((void *)name_dup);
+		return ret;
+	}
+
+	device_set_name_alloced(dev);
+
+	return 0;
+}
+
+int ubi_dm_unbind_all(void)
+{
+	int ret;
+	struct uclass *uc;
+	struct udevice *dev;
+	struct udevice *next;
+
+	ret = uclass_get(UCLASS_UBI, &uc);
+	if (ret)
+		return ret;
+
+	uclass_foreach_dev_safe(dev, next, uc) {
+		ret = device_remove(dev, DM_REMOVE_NORMAL);
+		if (ret)
+			return ret;
+
+		ret = device_unbind(dev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(ubi) = {
+	.id		= UCLASS_UBI,
+	.name		= "ubi_dev",
+};
+
+UCLASS_DRIVER(ubi) = {
+	.id		= UCLASS_UBI,
+	.name		= "ubi",
+};
diff --git a/include/dm/uclass-id.h b/include/dm/uclass-id.h
index 0432c95c9e..ee11fbb38d 100644
--- a/include/dm/uclass-id.h
+++ b/include/dm/uclass-id.h
@@ -140,6 +140,7 @@ enum uclass_id {
 	UCLASS_THERMAL,		/* Thermal sensor */
 	UCLASS_TIMER,		/* Timer device */
 	UCLASS_TPM,		/* Trusted Platform Module TIS interface */
+	UCLASS_UBI,		/* Unsorted Block Images MTD partition */
 	UCLASS_UFS,		/* Universal Flash Storage */
 	UCLASS_USB,		/* USB bus */
 	UCLASS_USB_DEV_GENERIC,	/* USB generic device */
diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
index 6da348eb62..9d37848f03 100644
--- a/include/ubi_uboot.h
+++ b/include/ubi_uboot.h
@@ -52,6 +52,11 @@ extern int ubi_part(char *part_name, const char *vid_header_offset);
 extern int ubi_volume_write(char *volume, void *buf, size_t size);
 extern int ubi_volume_read(char *volume, char *buf, size_t size);
 
+#ifdef CONFIG_DM_MTD
+extern int ubi_dm_bind(unsigned int);
+extern int ubi_dm_unbind_all(void);
+#endif
+
 extern struct ubi_device *ubi_devices[];
 int cmd_ubifs_mount(char *vol_name);
 int cmd_ubifs_umount(void);
-- 
2.41.0

