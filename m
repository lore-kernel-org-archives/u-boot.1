Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B57EC67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 13:56:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3B57875E9;
	Tue,  9 Apr 2024 15:56:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FY/g4LAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DE4A86FB2; Tue,  9 Apr 2024 15:56:01 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C9B7875E9
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 15:55:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a5200afe39eso50254966b.1
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 06:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712670957; x=1713275757; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DW+WeTC4xidkQ5rkksZLY6RINa136jY8eBkpulgtx0g=;
 b=FY/g4LALVaFaAYaIKn/NPfE+6ctQoUiv4P/yUNbowE97io6detjcfvFfTMYfbsxCoI
 XxXkqEAGckXIUlJsg59OC/WwaB9PNlFQiNyYursfeqgIk7oK9yWq2E/lkNv3Q/BYeyi/
 JMbfS9ZRt8hF6bFZjj4UNJrHZWPDXREnONcH3oRbps6t8TLmBJFu1bED14D6/dyaxrf2
 8hNJnj/wMrILXr/gEuvK4jvPUpYjM1/ytayTWaVhT+eJWOUJAUDX5F6TvSavkRvi+gfi
 30YtOzZzB5ghfX81s5fhngcYQpgJ8OnIJbkQekvcN39iaAEpf+MX1zvd/o3PVK/WN+Hz
 Cc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712670957; x=1713275757;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DW+WeTC4xidkQ5rkksZLY6RINa136jY8eBkpulgtx0g=;
 b=UoLLwBF+h/JIqVSV5EkVS4pbSV3dhRlL/nf3ymisCn4T2GVv7eD1k60WJIcqGUHh1J
 i2YcJGe6uBQ3LgR7O3qzF3xMEFJoPNswMJNyXwsUXbcbEutSGLZRjIu7NLzikI+Uu3yp
 b22Wtd9v625PkP5W9YUiNGZ48/bHv4FoEm9ygKvWswNKXHuG8mGqSLQWRzD2ILowdYP8
 TkIK7WQbU72a3Z6u9Z9aHCM1ztgn9mK9nPJLzM168refOrNfL7rB+coOMl1wZ+qwkbkk
 eD/86tr+bVSqAOYiBg67rXlPl0Xsf2R6uSddEtT3EoisgiL/1bLhSS/ZZp16ysQffoZu
 rPwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBXir58kr8KT34eV+zwvEhEEWMmpc4j58gL5Rr3cL7zbYLvaQp+usPbGnCjkyMr5qm+UgeQTc2m2rpcI6VQU8eLDinhg==
X-Gm-Message-State: AOJu0Yw1/hCTMMJD6Cbi0tNbUtRBAdhGixtH8F3DWOQGZmeQpdYRRqql
 c9alNi6Jstb0o6nk9ENbWiP7pj/ETA9TOoa+VdjsdWZYrA1YbE6oni4to81bHAxQZV7Q2mJW4K5
 j
X-Google-Smtp-Source: AGHT+IGwWLvulM5sNlmpXbFwTPaSvh+BbRkayZjMdNRc9sFqL90WBOKdbkx0A6RxMWov/Gdl7ZinlA==
X-Received: by 2002:a17:906:80d8:b0:a51:aea0:5389 with SMTP id
 a24-20020a17090680d800b00a51aea05389mr7349155ejx.60.1712670956875; 
 Tue, 09 Apr 2024 06:55:56 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 t1-20020a1709067c0100b00a46aac377e8sm5720612ejo.54.2024.04.09.06.55.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 06:55:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Apr 2024 15:55:52 +0200
Subject: [PATCH 1/2] dfu: add scsi backend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-b4-dfu-scsi-v1-1-3e1441a60376@linaro.org>
References: <20240409-b4-dfu-scsi-v1-0-3e1441a60376@linaro.org>
In-Reply-To: <20240409-b4-dfu-scsi-v1-0-3e1441a60376@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=17387;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=cs5uiG8vmgbzSr2VaolCor9ztnNHhWq1Wg/Zpy6t2xE=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFUjqXaKREtu/myXchmz0RKJ+u3e0wgQbjvEqY
 KTDhCv2Z7eJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhVI6gAKCRAFgzErGV9k
 tkBTD/0dX2EDQoz+5wpYi3f6x4xjtos/y6C++fZVgY4x5DinBTTD1mLCJ0rqTgg64NIZlAN4dTB
 ibVBGcgoYkeYbFyONW7ilVjQU8hnGs2jkH8LPWtTqCbeJ862j8FI1KUurP3pWO5GaMec7dXKfIt
 YljvROs3keHhd3EeP9xL8zxI3MJz239vWEe+7tgBMHBVrte4jVl9S3+tBCymc8WZxW8DU7ryIlb
 woV/5N+kK66WPjYHmEkbh0mVpYNi11BowFqf+teQ3ZpW+VyGjXyOUIYvU9RUCY5+p4ujkmKKNNy
 K+/No7cNGnGDBrusC3jYfprUUJdckkXLbp/BkW9+/NK+EvxA+65KuaHSN8wQsgOj+JbW8A7nTs6
 1dmCk1pXjKb2gbtpLgTIXghU2O5c/IIZ/eW84hKLWbVCnbECJLKdYSdS+3ekmCa/qzD9I+x8tKO
 Jm1Ao0d4kuwnmpnybg3P8kW6b9kCx7SV0t65tFd4a/CZA9tptV0UJanMbpOLq8MBU10kE5hj8yp
 hijJfmuZz4Cca15iIRqDpS+abuDL9rmymk+Pmmc9D6FqlN76IoNq/6UhIkpWZrjq2/Z4V934PbM
 IDC/ST1N7A6NJUvb+jQlqXBDpgfxnm/c6xFey6O05aPxYAoL3BrbuZ1G3ve3TxsNnMWsPfB1UbT
 pKsgj77GWLyMoFQ==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

This is extremely similar to the MMC backend, but there are some notable
differences.

Works with a DFU string like

    scsi 4=u-boot-bin part 11

Where "4" is the SCSI dev number (sequential LUN across all SCSI devices)
and "11" is the partition number.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/usage/dfu.rst      |  31 ++++
 drivers/dfu/Kconfig    |   7 +
 drivers/dfu/Makefile   |   1 +
 drivers/dfu/dfu.c      |   5 +-
 drivers/dfu/dfu_scsi.c | 437 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/dfu.h          |  26 +++
 6 files changed, 506 insertions(+), 1 deletion(-)

diff --git a/doc/usage/dfu.rst b/doc/usage/dfu.rst
index 8cc09c308d82..dc4f8d672f99 100644
--- a/doc/usage/dfu.rst
+++ b/doc/usage/dfu.rst
@@ -166,8 +166,38 @@ mmc
 
     Please note that this means the user will be able to execute any
     arbitrary commands just like in the u-boot's shell.
 
+scsi
+    for UFS storage::
+
+        dfu 0 scsi <dev>
+
+    each element in *dfu_alt_info* being
+
+    * <name> raw <offset> <size>     raw access to SCSI LUN
+    * <name> part <part_id>          raw access to partition
+    * <name> fat <part_id>           file in FAT partition
+    * <name> ext4 <part_id>          file in EXT4 partition
+    * <name> skip 0 0                ignore flashed data
+    * <name> script 0 0              execute commands in shell
+
+    with
+
+    size
+        is the size of the access area (hexadecimal without "0x")
+        or 0 which means whole device
+    partid
+        is the GPT or DOS partition index.
+    dev
+        is the SCSI LU (Logical Unit) index (decimal only)
+
+    A value of environment variable *dfu_alt_info* for UFS could be::
+
+        u-boot part 4;bl2 raw 0x1e 0x1d
+
+    See mmc section above for details on the skip and script types.
+
 nand
     raw slc nand device::
 
          dfu 0 nand <dev>
@@ -277,8 +307,9 @@ alternate list separated by '&' with the same format for each <alt>::
 
     mmc <dev>=<alt1>;....;<altN>
     nand <dev>=<alt1>;....;<altN>
     ram <dev>=<alt1>;....;<altN>
+    scsi <dev>=<alt1>;....;<altN>
     sf <dev>=<alt1>;....;<altN>
     mtd <dev>=<alt1>;....;<altN>
     virt <dev>=<alt1>;....;<altN>
 
diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index 0360d9da1427..158c660e6c4e 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -86,8 +86,15 @@ config DFU_VIRT
 	  This option enables using DFU to read and write to VIRTUAL device
 	  used at board level to manage specific behavior
 	  (OTP update for example).
 
+config DFU_SCSI
+	bool "SCSI flash back end for DFU"
+	help
+	  This option enables using DFU to read and write to SCSI devices
+	  used at board level to manage specific behavior
+	  (OTP update for example).
+
 config SET_DFU_ALT_INFO
 	bool "Dynamic set of DFU alternate information"
 	help
 	  This option allows to call the function set_dfu_alt_info to
diff --git a/drivers/dfu/Makefile b/drivers/dfu/Makefile
index dfbf64da6677..3b3ba0994b3a 100644
--- a/drivers/dfu/Makefile
+++ b/drivers/dfu/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_$(SPL_)DFU_NAND) += dfu_nand.o
 obj-$(CONFIG_$(SPL_)DFU_RAM) += dfu_ram.o
 obj-$(CONFIG_$(SPL_)DFU_SF) += dfu_sf.o
 obj-$(CONFIG_$(SPL_)DFU_WRITE_ALT) += dfu_alt.o
 obj-$(CONFIG_$(SPL_)DFU_VIRT) += dfu_virt.o
+obj-$(CONFIG_$(SPL_)DFU_SCSI) += dfu_scsi.o
diff --git a/drivers/dfu/dfu.c b/drivers/dfu/dfu.c
index 2adf26e2fe24..8024ad98a7dc 100644
--- a/drivers/dfu/dfu.c
+++ b/drivers/dfu/dfu.c
@@ -548,8 +548,11 @@ static int dfu_fill_entity(struct dfu_entity *dfu, char *s, int alt,
 			return -1;
 	} else if (strcmp(interface, "virt") == 0) {
 		if (dfu_fill_entity_virt(dfu, devstr, argv, argc))
 			return -1;
+	} else if (strcmp(interface, "scsi") == 0) {
+		if (dfu_fill_entity_scsi(dfu, devstr, argv, argc))
+			return -1;
 	} else {
 		printf("%s: Device %s not (yet) supported!\n",
 		       __func__,  interface);
 		return -1;
@@ -644,9 +647,9 @@ int dfu_config_entities(char *env, char *interface, char *devstr)
 
 const char *dfu_get_dev_type(enum dfu_device_type t)
 {
 	const char *const dev_t[] = {NULL, "eMMC", "OneNAND", "NAND", "RAM",
-				     "SF", "MTD", "VIRT"};
+				     "SF", "MTD", "VIRT", "SCSI"};
 	return dev_t[t];
 }
 
 const char *dfu_get_layout(enum dfu_layout l)
diff --git a/drivers/dfu/dfu_scsi.c b/drivers/dfu/dfu_scsi.c
new file mode 100644
index 000000000000..63c3bcffe769
--- /dev/null
+++ b/drivers/dfu/dfu_scsi.c
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DFU SCSI backend (based on MMC backend).
+ *
+ * Copyright (C) 2012 Samsung Electronics
+ *   author: Lukasz Majewski <l.majewski@samsung.com>
+ * Copyright (C) 2024 Linaro Ltd.
+ */
+
+#define LOG_DEBUG
+
+#include <log.h>
+#include <malloc.h>
+#include <errno.h>
+#include <div64.h>
+#include <dfu.h>
+#include <ext4fs.h>
+#include <fat.h>
+#include <scsi.h>
+#include <part.h>
+#include <command.h>
+#include <linux/printk.h>
+
+static unsigned char *dfu_file_buf;
+static u64 dfu_file_buf_len;
+static u64 dfu_file_buf_offset;
+
+#define scsi_get_blk_desc(dev) ((struct blk_desc *)dev_get_uclass_plat(dev))
+
+#define find_scsi_device(dev_num, scsi) blk_get_device(UCLASS_SCSI, dev_num, scsi)
+
+static int scsi_block_op(enum dfu_op op, struct dfu_entity *dfu, u64 offset, void *buf, long *len)
+{
+	struct udevice *scsi;
+	u32 blk_start, blk_count, n = 0;
+	int ret;
+
+	ret = find_scsi_device(dfu->data.scsi.lun, &scsi);
+	if (ret < 0) {
+		pr_err("Device SCSI %d - not found!", dfu->data.scsi.lun);
+		return -ENODEV;
+	}
+
+	/*
+	 * We must ensure that we work in lba_blk_size chunks, so ALIGN
+	 * this value.
+	 */
+	*len = ALIGN(*len, dfu->data.scsi.lba_blk_size);
+
+	blk_start = dfu->data.scsi.lba_start + (u32)lldiv(offset, dfu->data.scsi.lba_blk_size);
+	blk_count = *len / dfu->data.scsi.lba_blk_size;
+	if (blk_start + blk_count > dfu->data.scsi.lba_start + dfu->data.scsi.lba_size) {
+		puts("Request would exceed designated area!\n");
+		return -EINVAL;
+	}
+
+	debug("%s: %s dev: %d start: %d cnt: %d buf: 0x%p\n", __func__,
+	      op == DFU_OP_READ ? "scsi READ" : "scsi WRITE", dfu->data.scsi.lun, blk_start,
+	      blk_count, buf);
+	switch (op) {
+	case DFU_OP_READ:
+		n = blk_dread(scsi_get_blk_desc(scsi), blk_start, blk_count, buf);
+		break;
+	case DFU_OP_WRITE:
+		n = blk_dwrite(scsi_get_blk_desc(scsi), blk_start, blk_count, buf);
+		break;
+	default:
+		pr_err("Operation not supported\n");
+	}
+
+	if (n != blk_count) {
+		pr_err("scsi block operation failed");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int scsi_file_op(enum dfu_op op, struct dfu_entity *dfu, u64 offset, void *buf, u64 *len)
+{
+	char dev_part_str[8];
+	int ret;
+	int fstype;
+	loff_t size = 0;
+
+	switch (dfu->layout) {
+	case DFU_FS_FAT:
+		fstype = FS_TYPE_FAT;
+		break;
+	case DFU_FS_EXT4:
+		fstype = FS_TYPE_EXT;
+		break;
+	case DFU_SKIP:
+		return 0;
+	default:
+		printf("%s: Layout (%s) not (yet) supported!\n", __func__,
+		       dfu_get_layout(dfu->layout));
+		return -1;
+	}
+
+	snprintf(dev_part_str, sizeof(dev_part_str), "%d:%d", dfu->data.scsi.dev,
+		 dfu->data.scsi.part);
+
+	ret = fs_set_blk_dev("scsi", dev_part_str, fstype);
+	if (ret) {
+		puts("dfu: fs_set_blk_dev error!\n");
+		return ret;
+	}
+
+	switch (op) {
+	case DFU_OP_READ:
+		ret = fs_read(dfu->name, (size_t)buf, offset, *len, &size);
+		if (ret) {
+			puts("dfu: fs_read error!\n");
+			return ret;
+		}
+		*len = size;
+		break;
+	case DFU_OP_WRITE:
+		ret = fs_write(dfu->name, (size_t)buf, offset, *len, &size);
+		if (ret) {
+			puts("dfu: fs_write error!\n");
+			return ret;
+		}
+		break;
+	case DFU_OP_SIZE:
+		ret = fs_size(dfu->name, &size);
+		if (ret) {
+			puts("dfu: fs_size error!\n");
+			return ret;
+		}
+		*len = size;
+		break;
+	default:
+		return -1;
+	}
+
+	return ret;
+}
+
+static int scsi_file_buf_write(struct dfu_entity *dfu, u64 offset, void *buf, long *len)
+{
+	int ret = 0;
+
+	if (offset == 0) {
+		dfu_file_buf_len = 0;
+		dfu_file_buf_offset = 0;
+	}
+
+	/* Add to the current buffer. */
+	if (dfu_file_buf_len + *len > CONFIG_SYS_DFU_MAX_FILE_SIZE)
+		*len = CONFIG_SYS_DFU_MAX_FILE_SIZE - dfu_file_buf_len;
+	memcpy(dfu_file_buf + dfu_file_buf_len, buf, *len);
+	dfu_file_buf_len += *len;
+
+	if (dfu_file_buf_len == CONFIG_SYS_DFU_MAX_FILE_SIZE) {
+		ret = scsi_file_op(DFU_OP_WRITE, dfu, dfu_file_buf_offset, dfu_file_buf,
+				   &dfu_file_buf_len);
+		dfu_file_buf_offset += dfu_file_buf_len;
+		dfu_file_buf_len = 0;
+	}
+
+	return ret;
+}
+
+static int scsi_file_buf_write_finish(struct dfu_entity *dfu)
+{
+	int ret = scsi_file_op(DFU_OP_WRITE, dfu, dfu_file_buf_offset, dfu_file_buf,
+			       &dfu_file_buf_len);
+
+	/* Now that we're done */
+	dfu_file_buf_len = 0;
+	dfu_file_buf_offset = 0;
+
+	return ret;
+}
+
+int dfu_write_medium_scsi(struct dfu_entity *dfu, u64 offset, void *buf, long *len)
+{
+	int ret = -1;
+
+	switch (dfu->layout) {
+	case DFU_RAW_ADDR:
+		ret = scsi_block_op(DFU_OP_WRITE, dfu, offset, buf, len);
+		break;
+	case DFU_FS_FAT:
+	case DFU_FS_EXT4:
+		ret = scsi_file_buf_write(dfu, offset, buf, len);
+		break;
+	case DFU_SCRIPT:
+		ret = run_command_list(buf, *len, 0);
+		break;
+	case DFU_SKIP:
+		ret = 0;
+		break;
+	default:
+		printf("%s: Layout (%s) not (yet) supported!\n", __func__,
+		       dfu_get_layout(dfu->layout));
+	}
+
+	return ret;
+}
+
+int dfu_flush_medium_scsi(struct dfu_entity *dfu)
+{
+	int ret = 0;
+
+	switch (dfu->layout) {
+	case DFU_FS_FAT:
+	case DFU_FS_EXT4:
+		ret = scsi_file_buf_write_finish(dfu);
+		break;
+	case DFU_SCRIPT:
+		/* script may have changed the dfu_alt_info */
+		dfu_reinit_needed = true;
+		break;
+	case DFU_RAW_ADDR:
+	case DFU_SKIP:
+		break;
+	default:
+		printf("%s: Layout (%s) not (yet) supported!\n", __func__,
+		       dfu_get_layout(dfu->layout));
+	}
+
+	return ret;
+}
+
+int dfu_get_medium_size_scsi(struct dfu_entity *dfu, u64 *size)
+{
+	int ret;
+
+	switch (dfu->layout) {
+	case DFU_RAW_ADDR:
+		*size = dfu->data.scsi.lba_size * dfu->data.scsi.lba_blk_size;
+		return 0;
+	case DFU_FS_FAT:
+	case DFU_FS_EXT4:
+		ret = scsi_file_op(DFU_OP_SIZE, dfu, 0, NULL, size);
+		if (ret < 0)
+			return ret;
+		return 0;
+	case DFU_SCRIPT:
+	case DFU_SKIP:
+		return 0;
+	default:
+		printf("%s: Layout (%s) not (yet) supported!\n", __func__,
+		       dfu_get_layout(dfu->layout));
+		return -1;
+	}
+}
+
+static int scsi_file_buf_read(struct dfu_entity *dfu, u64 offset, void *buf, long *len)
+{
+	int ret;
+
+	if (offset == 0 || offset >= dfu_file_buf_offset + dfu_file_buf_len ||
+	    offset + *len < dfu_file_buf_offset) {
+		u64 file_len = CONFIG_SYS_DFU_MAX_FILE_SIZE;
+
+		ret = scsi_file_op(DFU_OP_READ, dfu, offset, dfu_file_buf, &file_len);
+		if (ret < 0)
+			return ret;
+		dfu_file_buf_len = file_len;
+		dfu_file_buf_offset = offset;
+	}
+	if (offset + *len > dfu_file_buf_offset + dfu_file_buf_len)
+		return -EINVAL;
+
+	/* Add to the current buffer. */
+	memcpy(buf, dfu_file_buf + offset - dfu_file_buf_offset, *len);
+
+	return 0;
+}
+
+int dfu_read_medium_scsi(struct dfu_entity *dfu, u64 offset, void *buf, long *len)
+{
+	int ret = -1;
+
+	switch (dfu->layout) {
+	case DFU_RAW_ADDR:
+		ret = scsi_block_op(DFU_OP_READ, dfu, offset, buf, len);
+		break;
+	case DFU_FS_FAT:
+	case DFU_FS_EXT4:
+		ret = scsi_file_buf_read(dfu, offset, buf, len);
+		break;
+	default:
+		printf("%s: Layout (%s) not (yet) supported!\n", __func__,
+		       dfu_get_layout(dfu->layout));
+	}
+
+	return ret;
+}
+
+void dfu_free_entity_scsi(struct dfu_entity *dfu)
+{
+	if (dfu_file_buf) {
+		free(dfu_file_buf);
+		dfu_file_buf = NULL;
+	}
+}
+
+/*
+ * @param s Parameter string containing space-separated arguments:
+ *	1st:
+ *		raw	(raw read/write)
+ *		fat	(files)
+ *		ext4	(^)
+ *		part	(partition image)
+ *	2nd and 3rd:
+ *		lba_start and lba_size, for raw write
+ *		scsi_dev and scsi_part, for filesystems and part
+ */
+int dfu_fill_entity_scsi(struct dfu_entity *dfu, char *devstr, char **argv, int argc)
+{
+	const char *entity_type;
+	ssize_t second_arg;
+	ssize_t third_arg = -1;
+	struct udevice *scsi;
+	struct blk_desc *blk_dev;
+	int ret;
+	char *s;
+
+	if (argc < 2) {
+		pr_err("Need at least one argument\n");
+		return -EINVAL;
+	}
+
+	dfu->data.scsi.lun = dectoul(devstr, &s);
+	if (*s)
+		return -EINVAL;
+
+	entity_type = argv[0];
+	/*
+	 * Base 0 means we'll accept (prefixed with 0x or 0) base 16, 8,
+	 * with default 10.
+	 */
+	second_arg = simple_strtol(argv[1], &s, 0);
+	if (*s)
+		return -EINVAL;
+	if (argc >= 3) {
+		third_arg = simple_strtoul(argv[2], &s, 0);
+		if (*s)
+			return -EINVAL;
+	}
+
+	if (scsi_scan(false)) {
+		pr_err("Couldn't init scsi device.\n");
+		return -ENODEV;
+	}
+
+	ret = find_scsi_device(dfu->data.scsi.lun, &scsi);
+	if (ret < 0) {
+		pr_err("Couldn't find scsi device no. %d.\n", dfu->data.scsi.lun);
+		return -ENODEV;
+	}
+
+	blk_dev = scsi_get_blk_desc(scsi);
+	if (!blk_dev) {
+		pr_err("Couldn't get block device for scsi device no. %d.\n", dfu->data.scsi.lun);
+		return -ENODEV;
+	}
+
+	/* if it's NOT a raw write */
+	if (strcmp(entity_type, "raw")) {
+		dfu->data.scsi.dev = (second_arg != -1) ? second_arg : dfu->data.scsi.lun;
+		dfu->data.scsi.part = third_arg;
+	}
+
+	if (!strcmp(entity_type, "raw")) {
+		dfu->layout = DFU_RAW_ADDR;
+		dfu->data.scsi.lba_start = second_arg;
+		if (third_arg < 0) {
+			pr_err("raw requires two arguments\n");
+			return -EINVAL;
+		}
+		dfu->data.scsi.lba_size = third_arg;
+		dfu->data.scsi.lba_blk_size = blk_dev->blksz;
+
+		/*
+		 * In case the size is zero (i.e. scsi raw 0x10 0),
+		 * assume the user intends to use whole device.
+		 */
+		if (third_arg == 0)
+			dfu->data.scsi.lba_size = blk_dev->lba;
+
+	} else if (!strcmp(entity_type, "part")) {
+		struct disk_partition partinfo;
+		int scsipart = second_arg;
+
+		if (third_arg >= 0) {
+			pr_err("part only accepts one argument\n");
+			return -EINVAL;
+		}
+
+		if (part_get_info(blk_dev, scsipart, &partinfo) != 0) {
+			pr_err("Couldn't find part #%d on scsi device #%d\n", scsipart,
+			       dfu->data.scsi.lun);
+			return -ENODEV;
+		}
+
+		dfu->layout = DFU_RAW_ADDR;
+		dfu->data.scsi.lba_start = partinfo.start;
+		dfu->data.scsi.lba_size = partinfo.size;
+		dfu->data.scsi.lba_blk_size = partinfo.blksz;
+	} else if (!strcmp(entity_type, "fat")) {
+		dfu->layout = DFU_FS_FAT;
+	} else if (!strcmp(entity_type, "ext4")) {
+		dfu->layout = DFU_FS_EXT4;
+	} else if (!strcmp(entity_type, "skip")) {
+		dfu->layout = DFU_SKIP;
+	} else if (!strcmp(entity_type, "script")) {
+		dfu->layout = DFU_SCRIPT;
+	} else {
+		pr_err("Memory layout (%s) not supported!\n", entity_type);
+		return -ENODEV;
+	}
+
+	dfu->dev_type = DFU_DEV_SCSI;
+	dfu->get_medium_size = dfu_get_medium_size_scsi;
+	dfu->read_medium = dfu_read_medium_scsi;
+	dfu->write_medium = dfu_write_medium_scsi;
+	dfu->flush_medium = dfu_flush_medium_scsi;
+	dfu->inited = 0;
+	dfu->free_entity = dfu_free_entity_scsi;
+
+	/* Check if file buffer is ready */
+	if (!dfu_file_buf) {
+		dfu_file_buf = memalign(CONFIG_SYS_CACHELINE_SIZE, CONFIG_SYS_DFU_MAX_FILE_SIZE);
+		if (!dfu_file_buf) {
+			pr_err("Could not memalign 0x%x bytes\n", CONFIG_SYS_DFU_MAX_FILE_SIZE);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
diff --git a/include/dfu.h b/include/dfu.h
index fa1918cd6635..d7f365a7f1ce 100644
--- a/include/dfu.h
+++ b/include/dfu.h
@@ -23,8 +23,9 @@ enum dfu_device_type {
 	DFU_DEV_RAM,
 	DFU_DEV_SF,
 	DFU_DEV_MTD,
 	DFU_DEV_VIRT,
+	DFU_DEV_SCSI,
 };
 
 enum dfu_layout {
 	DFU_RAW_ADDR = 1,
@@ -98,8 +99,20 @@ struct sf_internal_data {
 struct virt_internal_data {
 	int dev_num;
 };
 
+struct scsi_internal_data {
+	int lun;
+
+	/* RAW programming */
+	unsigned int lba_start;
+	unsigned int lba_size;
+	unsigned int lba_blk_size;
+
+	/* FAT/EXT */
+	unsigned int dev; // Always 0???
+	unsigned int part;
+};
 
 #if defined(CONFIG_DFU_NAME_MAX_SIZE)
 #define DFU_NAME_SIZE			CONFIG_DFU_NAME_MAX_SIZE
 #else
@@ -126,8 +139,9 @@ struct dfu_entity {
 		struct nand_internal_data nand;
 		struct ram_internal_data ram;
 		struct sf_internal_data sf;
 		struct virt_internal_data virt;
+		struct scsi_internal_data scsi;
 	} data;
 
 	int (*get_medium_size)(struct dfu_entity *dfu, u64 *size);
 
@@ -516,8 +530,20 @@ static inline int dfu_fill_entity_virt(struct dfu_entity *dfu, char *devstr,
 	return -1;
 }
 #endif
 
+#if CONFIG_IS_ENABLED(DFU_SCSI)
+int dfu_fill_entity_scsi(struct dfu_entity *dfu, char *devstr,
+			 char **argv, int argc);
+#else
+static inline int dfu_fill_entity_scsi(struct dfu_entity *dfu, char *devstr,
+				       char **argv, int argc)
+{
+	puts("SCSI support not available!\n");
+	return -1;
+}
+#endif
+
 extern bool dfu_reinit_needed;
 
 #if CONFIG_IS_ENABLED(DFU_WRITE_ALT)
 /**

-- 
2.44.0

