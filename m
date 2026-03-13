Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E0E105F796
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 10:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0DF78429E;
	Fri, 13 Mar 2026 11:42:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="iVBR0tdA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11E2F842F2; Fri, 13 Mar 2026 11:42:50 +0100 (CET)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C4588420C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 11:42:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 928254E4267A
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 10:42:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 66D5B60027;
 Fri, 13 Mar 2026 10:42:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B7D2910369E9D; Fri, 13 Mar 2026 11:42:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1773398566; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=sKkoFrvi8ryqyHub0/Gb12XXcazckdBJ0c9lA3712uU=;
 b=iVBR0tdAejPYBi0CQmdzlx2UK00wZoBd/8vJ7Dd9iTUbwpdUn02BRWK3cLg+86OS3xiQN/
 gXUK4CsBffmOgQRwiwP1cm2PjZw6pza+GxOlb6Z48lSyPZ09Jkh/O+8icUwjZPFrjUcUEG
 tXMFreauTLf218GLxKydRqiS6zEFOs5goHkHtgLWwwfK8G7h8o0j7u38A8JgRjBoY7TxdW
 s9naQh47HdyvHrZaKYmiXBwZb4jLgYFYzWWIr7VR8VHOmXlz7VakUc+xFGIMsuM3+/Zqoc
 QRUnAvNNVfl4sDUF683EeoPc9j9Lmk1KwiOgzEjVAspMqa2mv0mZFTvqNr+N3A==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de,
 Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 4/7] spl: add squashfs support
Date: Fri, 13 Mar 2026 11:42:26 +0100
Message-ID: <20260313104229.1555236-5-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260313104229.1555236-1-richard.genoud@bootlin.com>
References: <20260313104229.1555236-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Implement spl_load_image_sqfs() in spl code.

This will be used in MMC to read a file from a squashfs partition.

Also, loosen squashfs read checks on file size by not failing when a
bigger size than the actual file size is requested. (Just read the file)
This is needed for FIT loading, because the length is ALIGNed.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
---
 common/spl/Makefile       |  1 +
 common/spl/spl_squashfs.c | 78 +++++++++++++++++++++++++++++++++++++++
 fs/squashfs/sqfs.c        | 12 +++---
 include/part.h            |  1 +
 include/spl.h             |  6 +++
 5 files changed, 91 insertions(+), 7 deletions(-)
 create mode 100644 common/spl/spl_squashfs.c

diff --git a/common/spl/Makefile b/common/spl/Makefile
index 4c9482bd3096..53cc45fc5b9b 100644
--- a/common/spl/Makefile
+++ b/common/spl/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_$(PHASE_)OPENSBI) += spl_opensbi.o
 obj-$(CONFIG_$(PHASE_)USB_STORAGE) += spl_usb.o
 obj-$(CONFIG_$(PHASE_)FS_FAT) += spl_fat.o
 obj-$(CONFIG_$(PHASE_)FS_EXT4) += spl_ext.o
+obj-$(CONFIG_$(PHASE_)FS_SQUASHFS) += spl_squashfs.o
 obj-$(CONFIG_$(PHASE_)LOAD_IMX_CONTAINER) += spl_imx_container.o
 obj-$(CONFIG_$(PHASE_)SATA) += spl_sata.o
 obj-$(CONFIG_$(PHASE_)NVME) += spl_nvme.o
diff --git a/common/spl/spl_squashfs.c b/common/spl/spl_squashfs.c
new file mode 100644
index 000000000000..d3b1c70bfc45
--- /dev/null
+++ b/common/spl/spl_squashfs.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2020 Paratronic
+ * Copyright (C) 2026 Bootlin
+ *
+ * Author: Richard Genoud <richard.genoud@bootlin.com>
+ *
+ */
+
+#include <env.h>
+#include <part.h>
+#include <spl.h>
+#include <spl_load.h>
+#include <squashfs.h>
+#include <errno.h>
+#include <image.h>
+
+static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
+			  ulong size, void *buf)
+{
+	struct legacy_img_hdr *header;
+	char *filename = load->priv;
+	loff_t actread;
+	int ret;
+
+	ret = sqfs_read(filename, buf, file_offset, size, &actread);
+	if (ret)
+		return ret;
+
+	if (CONFIG_IS_ENABLED(OS_BOOT)) {
+		header = (struct legacy_img_hdr *)buf;
+		if (image_get_magic(header) != FDT_MAGIC)
+			return size;
+	}
+
+	return actread;
+}
+
+int spl_load_image_sqfs(struct spl_image_info *spl_image,
+			struct spl_boot_device *bootdev,
+			struct blk_desc *block_dev, int partition,
+			const char *filename)
+{
+	int err;
+	loff_t size = 0;
+	struct spl_load_info load;
+	struct disk_partition part_info = {};
+
+	err = part_get_info(block_dev, partition, &part_info);
+	if (err) {
+		printf("spl: no partition table found\n");
+		goto end;
+	}
+
+	err = sqfs_probe(block_dev, &part_info);
+	if (err) {
+		printf("spl: sqfs probe err part_name:%s type=%s err=%d\n",
+		       part_info.name, part_info.type, err);
+		goto end;
+	}
+
+	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)) {
+		err = sqfs_size(filename, &size);
+		if (err)
+			goto end;
+	}
+
+	spl_load_init(&load, spl_fit_read, (void *)filename, 1);
+
+	err = spl_load(spl_image, bootdev, &load, size, 0);
+
+end:
+	if (err < 0)
+		printf("%s: error reading image %s, err - %d\n",
+		       __func__, filename, err);
+
+	return err;
+}
diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 9cb8b4afcddb..543db8c7e9ec 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -1490,13 +1490,11 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 		goto out;
 	}
 
-	/* If the user specifies a length, check its sanity */
-	if (len) {
-		if (len > finfo.size) {
-			ret = -EINVAL;
-			goto out;
-		}
-
+	/*
+	 * For FIT loading, the len is ALIGN, so it may exceed the actual size.
+	 * Let's just read the max.
+	 */
+	if (len && len < finfo.size) {
 		finfo.size = len;
 	} else {
 		len = finfo.size;
diff --git a/include/part.h b/include/part.h
index daebbbc2e68f..9679521825f7 100644
--- a/include/part.h
+++ b/include/part.h
@@ -461,6 +461,7 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 #ifdef CONFIG_XPL_BUILD
 # define part_print_ptr(x)	NULL
 # if defined(CONFIG_SPL_FS_EXT4) || defined(CONFIG_SPL_FS_FAT) || \
+	defined(CONFIG_SPL_FS_SQUASHFS) || \
 	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION) || \
 	defined(CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION_TYPE)
 #  define part_get_info_ptr(x)	x
diff --git a/include/spl.h b/include/spl.h
index 06dc28362d3f..5078d7525abb 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -882,6 +882,12 @@ int spl_blk_load_image(struct spl_image_info *spl_image,
 		       struct spl_boot_device *bootdev,
 		       enum uclass_id uclass_id, int devnum, int partnum);
 
+/* SPL SQUASHFS image functions */
+int spl_load_image_sqfs(struct spl_image_info *spl_image,
+			struct spl_boot_device *bootdev,
+			struct blk_desc *block_dev, int partition,
+			const char *filename);
+
 /**
  * spl_early_init() - Set up device tree and driver model in SPL if enabled
  *
