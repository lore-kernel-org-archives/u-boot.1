Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8C5C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 00:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD67087174;
	Thu,  9 Nov 2023 01:36:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="qAbTx0pF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A1CB87174; Thu,  9 Nov 2023 01:36:50 +0100 (CET)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1D2787128
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 01:36:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3nClMZQkKBlEw157A166Hz77z4x.v75D-u77C41BCB.wx6G.wx@flex--dimorinny.bounces.google.com
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5afa86b8d66so3941977b3.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 16:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1699490204; x=1700095004; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0+2gOsSvU92SlvWpJf22jyvJUrFjf1wxnGfrZZXn8WA=;
 b=qAbTx0pFsLrVhgQq4vngKyOwMVufysAk9kj+rR5tDqBsIf63OC2C3Pw3Zx3driJrAr
 m7VpE9/U0SD8tG6JKzg01lYtWwldR5zL+EPg4obTKoiPaqp7qiPM5jgGl7eD9+0n2Q5f
 GS2BzXjPULGTNxF2C4BIoH0Yoc5wuecHRK/2wT6wgA4jsNvXHngNkgSH9gstL4jLE45Q
 RGqG25p5mWIi8S547q5AQT0vZ0ucD9M3rjzBqxprKshgSpKRBLMOmgYZp+amzBt9BwSc
 fCyNRPou9qDC5XHXJ9HjpfSw0qdOIpQtYrCXfSqhq8esc4jBpQnOMK1HQTCFaHluChaV
 Y4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699490204; x=1700095004;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0+2gOsSvU92SlvWpJf22jyvJUrFjf1wxnGfrZZXn8WA=;
 b=Io8ePqQ+UXot6Gh3OEi3KJiaXAGC2/fSuAOLylmF6Vp1k0oeWtKwcT7HfoxQr5eTnU
 XAPfBd+LWFpD+yTbN2dplXaRcfkb/DH9jybuJUlX3HFx345fy0CaRvn3pIlAhd8AOAPa
 Tjg8w7Wswc//pd4PfGWlXNwdINnonwiXdkMp8yxlTwnaGcaCyZurflhJ6IbBF8/Ntk15
 ZQ7feSP4wZD0+vCi3z2CIzqJEHL6Fk8cB8hbJKrE1KMJ0vTR6+SR4Fanw/4+yiabv1UZ
 86LePjA4TK30JN/55mGEVGGgI2DL0B+D4j8GBSXcxATQCu9rDQVJecLW0Z4Q9UvqIzUD
 dXvg==
X-Gm-Message-State: AOJu0Yzk3QXMvYTo/0gOUdU1luHseHU2v8LeSEI3JoRE/1V3NovrVp+U
 CtO699ot3Vx+u/Wr9XVJ4k2Vro4SWQKdd5V4uA/LzFpv7NQZswpWUq9KfGRGkGQz6vTPoo8SnsF
 p0hZeKo/4SRbR++EAHsaqm8+fd2A1lzdGPuBmc6i8r/GpNsQbmOjpvZovw+gRO+clDR8=
X-Google-Smtp-Source: AGHT+IFTu9lB/ypTtQhjiZt1XNBjUzzJu3uTkiHenODkKjPBdVGEwZK8yZ5qnPoyEoMNChQ5GMml311jvMLrB/Y=
X-Received: from dimorinny0.lon.corp.google.com
 ([2a00:79e0:d:209:a191:82a1:563a:5b26])
 (user=dimorinny job=sendgmr) by 2002:a81:4c0d:0:b0:5be:ae23:c004 with SMTP id
 z13-20020a814c0d000000b005beae23c004mr78185ywa.3.1699490204517; Wed, 08 Nov
 2023 16:36:44 -0800 (PST)
Date: Thu,  9 Nov 2023 00:36:34 +0000
In-Reply-To: <20231109003634.577152-1-dimorinny@google.com>
Mime-Version: 1.0
References: <20231109003634.577152-1-dimorinny@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109003634.577152-3-dimorinny@google.com>
Subject: [PATCH 2/2] cmd: bcb: extend BCB C API to allow read/write the fields
From: Dmitrii Merkurev <dimorinny@google.com>
To: u-boot@lists.denx.de
Cc: rammuthiah@google.com, Dmitrii Merkurev <dimorinny@google.com>, 
 Cody Schuffelen <schuffelen@google.com>, Eugeniu Rosca <erosca@de.adit-jv.com>,
 Ying-Chun Liu <paul.liu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>
Content-Type: text/plain; charset="UTF-8"
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

Currently BCB C API only allows to modify 'command' BCB field.
Extend it so that we can also read and modify all the available
BCB fields (command, status, recovery, stage).

Co-developed-by: Cody Schuffelen <schuffelen@google.com>
Signed-off-by: Cody Schuffelen <schuffelen@google.com>
Signed-off-by: Dmitrii Merkurev <dimorinny@google.com>
Cc: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Sean Anderson <sean.anderson@seco.com>
Cc: Cody Schuffelen <schuffelen@google.com>
---
 cmd/bcb.c                    | 162 +++++++++++++++++++++++------------
 drivers/fastboot/fb_common.c |  14 ++-
 include/bcb.h                |  60 ++++++++++++-
 3 files changed, 179 insertions(+), 57 deletions(-)

diff --git a/cmd/bcb.c b/cmd/bcb.c
index 5d8c232663..7a77b7f7b0 100644
--- a/cmd/bcb.c
+++ b/cmd/bcb.c
@@ -25,10 +25,18 @@ enum bcb_cmd {
 	BCB_CMD_STORE,
 };
 
-static enum uclass_id bcb_uclass_id = UCLASS_INVALID;
-static int bcb_dev = -1;
-static int bcb_part = -1;
+static const char * const fields[] = {
+	"command",
+	"status",
+	"recovery",
+	"stage"
+};
+
 static struct bootloader_message bcb __aligned(ARCH_DMA_MINALIGN) = { { 0 } };
+static struct disk_partition partition_data;
+
+static struct blk_desc *block;
+static struct disk_partition *partition = &partition_data;
 
 static int bcb_cmd_get(char *cmd)
 {
@@ -82,7 +90,7 @@ static int bcb_is_misused(int argc, char *const argv[])
 		return -1;
 	}
 
-	if (cmd != BCB_CMD_LOAD && (bcb_dev < 0 || bcb_part < 0)) {
+	if (cmd != BCB_CMD_LOAD && !block) {
 		printf("Error: Please, load BCB first!\n");
 		return -1;
 	}
@@ -94,7 +102,7 @@ err:
 	return -1;
 }
 
-static int bcb_field_get(char *name, char **fieldp, int *sizep)
+static int bcb_field_get(const char *name, char **fieldp, int *sizep)
 {
 	if (!strcmp(name, "command")) {
 		*fieldp = bcb.command;
@@ -119,16 +127,21 @@ static int bcb_field_get(char *name, char **fieldp, int *sizep)
 	return 0;
 }
 
-static int __bcb_load(const char *iface, int devnum, const char *partp)
+static void __bcb_reset(void)
+{
+	block = NULL;
+	partition = &partition_data;
+	memset(&partition_data, 0, sizeof(struct disk_partition));
+	memset(&bcb, 0, sizeof(struct bootloader_message));
+}
+
+static int __bcb_initialize(const char *iface, int devnum, const char *partp)
 {
-	struct blk_desc *desc;
-	struct disk_partition info;
-	u64 cnt;
 	char *endp;
 	int part, ret;
 
-	desc = blk_get_dev(iface, devnum);
-	if (!desc) {
+	block = blk_get_dev(iface, devnum);
+	if (!block) {
 		ret = -ENODEV;
 		goto err_read_fail;
 	}
@@ -137,7 +150,7 @@ static int __bcb_load(const char *iface, int devnum, const char *partp)
 	 * always select the first hwpart in case another
 	 * blk operation selected a different hwpart
 	 */
-	ret = blk_dselect_hwpart(desc, 0);
+	ret = blk_dselect_hwpart(block, 0);
 	if (IS_ERR_VALUE(ret)) {
 		ret = -ENODEV;
 		goto err_read_fail;
@@ -145,49 +158,63 @@ static int __bcb_load(const char *iface, int devnum, const char *partp)
 
 	part = simple_strtoul(partp, &endp, 0);
 	if (*endp == '\0') {
-		ret = part_get_info(desc, part, &info);
+		ret = part_get_info(block, part, partition);
 		if (ret)
 			goto err_read_fail;
 	} else {
-		part = part_get_info_by_name(desc, partp, &info);
+		part = part_get_info_by_name(block, partp, partition);
 		if (part < 0) {
 			ret = part;
 			goto err_read_fail;
 		}
 	}
 
-	cnt = DIV_ROUND_UP(sizeof(struct bootloader_message), info.blksz);
-	if (cnt > info.size)
+	return CMD_RET_SUCCESS;
+
+err_read_fail:
+	printf("Error: %d %d:%s read failed (%d)\n", block->uclass_id,
+	       block->devnum, partition->name, ret);
+	goto err;
+err:
+	__bcb_reset();
+	return CMD_RET_FAILURE;
+}
+
+static int __bcb_load(void)
+{
+	u64 cnt;
+	int ret;
+
+	cnt = DIV_ROUND_UP(sizeof(struct bootloader_message), partition->blksz);
+	if (cnt > partition->size)
 		goto err_too_small;
 
-	if (blk_dread(desc, info.start, cnt, &bcb) != cnt) {
+	if (blk_dread(block, partition->start, cnt, &bcb) != cnt) {
 		ret = -EIO;
 		goto err_read_fail;
 	}
 
-	bcb_uclass_id = desc->uclass_id;
-	bcb_dev = desc->devnum;
-	bcb_part = part;
-	debug("%s: Loaded from %s %d:%d\n", __func__, iface, bcb_dev, bcb_part);
+	debug("%s: Loaded from %d %d:%s\n", __func__, block->uclass_id,
+	      block->devnum, partition->name);
 
 	return CMD_RET_SUCCESS;
 err_read_fail:
-	printf("Error: %s %d:%s read failed (%d)\n", iface, devnum, partp, ret);
+	printf("Error: %d %d:%s read failed (%d)\n", block->uclass_id,
+	       block->devnum, partition->name, ret);
 	goto err;
 err_too_small:
-	printf("Error: %s %d:%s too small!", iface, devnum, partp);
+	printf("Error: %d %d:%s too small!", block->uclass_id,
+	       block->devnum, partition->name);
 	goto err;
 err:
-	bcb_uclass_id = UCLASS_INVALID;
-	bcb_dev = -1;
-	bcb_part = -1;
-
+	__bcb_reset();
 	return CMD_RET_FAILURE;
 }
 
 static int do_bcb_load(struct cmd_tbl *cmdtp, int flag, int argc,
 		       char * const argv[])
 {
+	int ret;
 	int devnum;
 	char *endp;
 	char *iface = "mcc";
@@ -204,10 +231,14 @@ static int do_bcb_load(struct cmd_tbl *cmdtp, int flag, int argc,
 		return CMD_RET_FAILURE;
 	}
 
-	return __bcb_load(iface, devnum, argv[2]);
+	ret = __bcb_initialize(iface, devnum, argv[2]);
+	if (ret != CMD_RET_SUCCESS)
+		return ret;
+
+	return __bcb_load();
 }
 
-static int __bcb_set(char *fieldp, const char *valp)
+static int __bcb_set(const char *fieldp, const char *valp)
 {
 	int size, len;
 	char *field, *str, *found, *tmp;
@@ -307,31 +338,20 @@ static int do_bcb_dump(struct cmd_tbl *cmdtp, int flag, int argc,
 
 static int __bcb_store(void)
 {
-	struct blk_desc *desc;
-	struct disk_partition info;
 	u64 cnt;
 	int ret;
 
-	desc = blk_get_devnum_by_uclass_id(bcb_uclass_id, bcb_dev);
-	if (!desc) {
-		ret = -ENODEV;
-		goto err;
-	}
-
-	ret = part_get_info(desc, bcb_part, &info);
-	if (ret)
-		goto err;
-
-	cnt = DIV_ROUND_UP(sizeof(struct bootloader_message), info.blksz);
+	cnt = DIV_ROUND_UP(sizeof(struct bootloader_message), partition->blksz);
 
-	if (blk_dwrite(desc, info.start, cnt, &bcb) != cnt) {
+	if (blk_dwrite(block, partition->start, cnt, &bcb) != cnt) {
 		ret = -EIO;
 		goto err;
 	}
 
 	return CMD_RET_SUCCESS;
 err:
-	printf("Error: %d %d:%d write failed (%d)\n", bcb_uclass_id, bcb_dev, bcb_part, ret);
+	printf("Error: %d %d:%s write failed (%d)\n", block->uclass_id,
+	       block->devnum, partition->name, ret);
 
 	return CMD_RET_FAILURE;
 }
@@ -342,23 +362,59 @@ static int do_bcb_store(struct cmd_tbl *cmdtp, int flag, int argc,
 	return __bcb_store();
 }
 
-int bcb_write_reboot_reason(const char *iface, int devnum, char *partp, const char *reasonp)
+int bcb_find_partition_and_load(const char *iface, int devnum, char *partp)
 {
 	int ret;
 
-	ret = __bcb_load(iface, devnum, partp);
-	if (ret != CMD_RET_SUCCESS)
-		return ret;
+	__bcb_reset();
 
-	ret = __bcb_set("command", reasonp);
+	ret = __bcb_initialize(iface, devnum, partp);
 	if (ret != CMD_RET_SUCCESS)
 		return ret;
 
-	ret = __bcb_store();
-	if (ret != CMD_RET_SUCCESS)
-		return ret;
+	return __bcb_load();
+}
 
-	return 0;
+int bcb_load(struct blk_desc *block_description, struct disk_partition *disk_partition)
+{
+	__bcb_reset();
+
+	block = block_description;
+	partition = disk_partition;
+
+	return __bcb_load();
+}
+
+int bcb_set(enum bcb_field field, const char *value)
+{
+	if (field > BCB_FIELD_STAGE)
+		return CMD_RET_FAILURE;
+	return __bcb_set(fields[field], value);
+}
+
+int bcb_get(enum bcb_field field, char *value_out, size_t value_size)
+{
+	int size;
+	char *field_value;
+
+	if (field > BCB_FIELD_STAGE)
+		return CMD_RET_FAILURE;
+	if (bcb_field_get(fields[field], &field_value, &size))
+		return CMD_RET_FAILURE;
+
+	strlcpy(value_out, field_value, value_size);
+
+	return CMD_RET_SUCCESS;
+}
+
+int bcb_store(void)
+{
+	return __bcb_store();
+}
+
+void bcb_reset(void)
+{
+	__bcb_reset();
 }
 
 static struct cmd_tbl cmd_bcb_sub[] = {
diff --git a/drivers/fastboot/fb_common.c b/drivers/fastboot/fb_common.c
index 2a6608b28c..3576b06772 100644
--- a/drivers/fastboot/fb_common.c
+++ b/drivers/fastboot/fb_common.c
@@ -91,6 +91,7 @@ void fastboot_okay(const char *reason, char *response)
  */
 int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 {
+	int ret;
 	static const char * const boot_cmds[] = {
 		[FASTBOOT_REBOOT_REASON_BOOTLOADER] = "bootonce-bootloader",
 		[FASTBOOT_REBOOT_REASON_FASTBOOTD] = "boot-fastboot",
@@ -105,7 +106,18 @@ int __weak fastboot_set_reboot_flag(enum fastboot_reboot_reason reason)
 	if (reason >= FASTBOOT_REBOOT_REASONS_COUNT)
 		return -EINVAL;
 
-	return bcb_write_reboot_reason("mmc", mmc_dev, "misc", boot_cmds[reason]);
+	ret = bcb_find_partition_and_load("mmc", mmc_dev, "misc");
+	if (ret)
+		goto out;
+
+	ret = bcb_set(BCB_FIELD_COMMAND, boot_cmds[reason]);
+	if (ret)
+		goto out;
+
+	ret = bcb_store();
+out:
+	bcb_reset();
+	return ret;
 }
 
 /**
diff --git a/include/bcb.h b/include/bcb.h
index a6326523c4..1941d8c28b 100644
--- a/include/bcb.h
+++ b/include/bcb.h
@@ -8,15 +8,69 @@
 #ifndef __BCB_H__
 #define __BCB_H__
 
+#include <part.h>
+
+enum bcb_field {
+	BCB_FIELD_COMMAND,
+	BCB_FIELD_STATUS,
+	BCB_FIELD_RECOVERY,
+	BCB_FIELD_STAGE
+};
+
 #if IS_ENABLED(CONFIG_CMD_BCB)
-int bcb_write_reboot_reason(const char *iface, int devnum, char *partp, const char *reasonp);
+
+int bcb_find_partition_and_load(const char *iface,
+				int devnum, char *partp);
+int bcb_load(struct blk_desc *block_description,
+	     struct disk_partition *disk_partition);
+int bcb_set(enum bcb_field field, const char *value);
+
+/**
+ * bcb_get() - get the field value.
+ * @field: field to get
+ * @value_out: buffer to copy bcb field value to
+ * @value_size: buffer size to avoid overflow in case
+ *              value_out is smaller then the field value
+ */
+int bcb_get(enum bcb_field field, char *value_out, size_t value_size);
+
+int bcb_store(void);
+void bcb_reset(void);
+
 #else
+
 #include <linux/errno.h>
-static inline int bcb_write_reboot_reason(const char *iface, int devnum,
-					  char *partp, const char *reasonp)
+
+static inline int bcb_load(struct blk_desc *block_description,
+			   struct disk_partition *disk_partition)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bcb_find_partition_and_load(const char *iface,
+					      int devnum, char *partp)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bcb_set(enum bcb_field field, const char *value)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int bcb_get(enum bcb_field field, char *value_out)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int bcb_store(void)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void bcb_reset(void)
+{
+}
 #endif
 
 #endif /* __BCB_H__ */
-- 
2.42.0.869.gea05f2083d-goog

