Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1771C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:56:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEABC869A1;
	Thu, 24 Aug 2023 21:56:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hg0tqVAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 906288687F; Thu, 24 Aug 2023 21:56:06 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFE9586923
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7926755c052so6657839f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906961; x=1693511761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fShvFn5+Fm1MG7mNRrvoPPOegAanqQaDLh16FdqP7EQ=;
 b=hg0tqVAKV2BXmHGwWSKudrt/7Hou4LWzNm2yRu6mpyUO42Uvqlq4a++5N2ZowSRxiI
 L+LlsQNfHmSRHZ4ITEHxIOC/wjfDfuGrsYWHBMQ/e0Eisd4qsVwge77K0pYG/jZyUst9
 jGdq8BnwIeuS4EvRLq3n5VEYKpwAlqYYW795c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906961; x=1693511761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fShvFn5+Fm1MG7mNRrvoPPOegAanqQaDLh16FdqP7EQ=;
 b=ai/4DRWTp+hjfG3xGCL63kCAT+1mwPwpWk5H+wg7aiGJAV2S1GPb46GCk0+8pd7m14
 Me0XvZaFi0UnXo7tfB0qOrYPnunL7Rg9LQpWEmQiPeBC/7idoFyEWVQGyEV+GoWkDXfh
 Ns2XgWSKKtU9dZN/cy7qkTpUfNwtn9YocVG35Cgs2/oPAjb6SmdAMVA2GaCdpS2iEEg5
 8aHg60FU7qQw74oDEellQ6axCG+JDik9brlu4OC8zfTst7AU6IkHNfH/uVD8P9WeB2xF
 1TtpJxMQbND5WdXvD7j5KVlroV29lo6dIJrfu5htrhRkmyEQaOfkhWy8sCTyx6wbF2SR
 CEEA==
X-Gm-Message-State: AOJu0YwuHunOmxFBXQd7iEf1eEvhBcviPrwGW1iOHSJTrIJ28pGD/OCm
 3G7ge/AxnVGQ7RZR0QzLlj8xHN+UG+MXO6NPcrM=
X-Google-Smtp-Source: AGHT+IH6aGkgfEf7y0iKswD4Yv9n07Lp3fzDvKjkuY/0HtF1VqYCEzMWyqeea25qtdOp/JK8MJc9mw==
X-Received: by 2002:a6b:dd14:0:b0:780:bf50:32ce with SMTP id
 f20-20020a6bdd14000000b00780bf5032cemr7001343ioc.19.1692906961214; 
 Thu, 24 Aug 2023 12:56:01 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 01/23] part: Use desc instead of dev_desc
Date: Thu, 24 Aug 2023 13:55:24 -0600
Message-ID: <20230824195553.1685996-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195553.1685996-1-sjg@chromium.org>
References: <20230824195553.1685996-1-sjg@chromium.org>
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

The dev_ prefix is a hangover from the pre-driver model days. The device
is now a different thing, with driver model. Update the partition code to
just use 'desc', as is done with driver model.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Rebase on -next

 disk/part.c    | 178 ++++++++++++++++++++++++-------------------------
 include/part.h | 125 +++++++++++++++++-----------------
 2 files changed, 147 insertions(+), 156 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index eec02f58988d..8035dcb8a429 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -42,25 +42,25 @@ static struct part_driver *part_driver_get_type(int part_type)
 	return NULL;
 }
 
-static struct part_driver *part_driver_lookup_type(struct blk_desc *dev_desc)
+static struct part_driver *part_driver_lookup_type(struct blk_desc *desc)
 {
 	struct part_driver *drv =
 		ll_entry_start(struct part_driver, part_driver);
 	const int n_ents = ll_entry_count(struct part_driver, part_driver);
 	struct part_driver *entry;
 
-	if (dev_desc->part_type == PART_TYPE_UNKNOWN) {
+	if (desc->part_type == PART_TYPE_UNKNOWN) {
 		for (entry = drv; entry != drv + n_ents; entry++) {
 			int ret;
 
-			ret = entry->test(dev_desc);
+			ret = entry->test(desc);
 			if (!ret) {
-				dev_desc->part_type = entry->part_type;
+				desc->part_type = entry->part_type;
 				return entry;
 			}
 		}
 	} else {
-		return part_driver_get_type(dev_desc->part_type);
+		return part_driver_get_type(desc->part_type);
 	}
 
 	/* Not found */
@@ -85,25 +85,25 @@ int part_get_type_by_name(const char *name)
 
 static struct blk_desc *get_dev_hwpart(const char *ifname, int dev, int hwpart)
 {
-	struct blk_desc *dev_desc;
+	struct blk_desc *desc;
 	int ret;
 
 	if (!blk_enabled())
 		return NULL;
-	dev_desc = blk_get_devnum_by_uclass_idname(ifname, dev);
-	if (!dev_desc) {
+	desc = blk_get_devnum_by_uclass_idname(ifname, dev);
+	if (!desc) {
 		debug("%s: No device for iface '%s', dev %d\n", __func__,
 		      ifname, dev);
 		return NULL;
 	}
-	ret = blk_dselect_hwpart(dev_desc, hwpart);
+	ret = blk_dselect_hwpart(desc, hwpart);
 	if (ret) {
 		debug("%s: Failed to select h/w partition: err-%d\n", __func__,
 		      ret);
 		return NULL;
 	}
 
-	return dev_desc;
+	return desc;
 }
 
 struct blk_desc *blk_get_dev(const char *ifname, int dev)
@@ -140,29 +140,24 @@ static lba512_t lba512_muldiv(lba512_t block_count, lba512_t mul_by,
 	return bc_quot * mul_by + ((bc_rem * mul_by) >> right_shift);
 }
 
-void dev_print(struct blk_desc *dev_desc)
+void dev_print(struct blk_desc *desc)
 {
 	lba512_t lba512; /* number of blocks if 512bytes block size */
 
-	if (dev_desc->type == DEV_TYPE_UNKNOWN) {
+	if (desc->type == DEV_TYPE_UNKNOWN) {
 		puts ("not available\n");
 		return;
 	}
 
-	switch (dev_desc->uclass_id) {
+	switch (desc->uclass_id) {
 	case UCLASS_SCSI:
-		printf ("(%d:%d) Vendor: %s Prod.: %s Rev: %s\n",
-			dev_desc->target,dev_desc->lun,
-			dev_desc->vendor,
-			dev_desc->product,
-			dev_desc->revision);
+		printf("(%d:%d) Vendor: %s Prod.: %s Rev: %s\n", desc->target,
+		       desc->lun, desc->vendor, desc->product, desc->revision);
 		break;
 	case UCLASS_IDE:
 	case UCLASS_AHCI:
-		printf ("Model: %s Firm: %s Ser#: %s\n",
-			dev_desc->vendor,
-			dev_desc->revision,
-			dev_desc->product);
+		printf("Model: %s Firm: %s Ser#: %s\n", desc->vendor,
+		       desc->revision, desc->product);
 		break;
 	case UCLASS_MMC:
 	case UCLASS_USB:
@@ -171,27 +166,27 @@ void dev_print(struct blk_desc *dev_desc)
 	case UCLASS_HOST:
 	case UCLASS_BLKMAP:
 		printf ("Vendor: %s Rev: %s Prod: %s\n",
-			dev_desc->vendor,
-			dev_desc->revision,
-			dev_desc->product);
+			desc->vendor,
+			desc->revision,
+			desc->product);
 		break;
 	case UCLASS_VIRTIO:
-		printf("%s VirtIO Block Device\n", dev_desc->vendor);
+		printf("%s VirtIO Block Device\n", desc->vendor);
 		break;
 	case UCLASS_EFI_MEDIA:
-		printf("EFI media Block Device %d\n", dev_desc->devnum);
+		printf("EFI media Block Device %d\n", desc->devnum);
 		break;
 	case UCLASS_INVALID:
 		puts("device type unknown\n");
 		return;
 	default:
-		printf("Unhandled device type: %i\n", dev_desc->uclass_id);
+		printf("Unhandled device type: %i\n", desc->uclass_id);
 		return;
 	}
 	puts ("            Type: ");
-	if (dev_desc->removable)
+	if (desc->removable)
 		puts ("Removable ");
-	switch (dev_desc->type & 0x1F) {
+	switch (desc->type & 0x1F) {
 	case DEV_TYPE_HARDDISK:
 		puts ("Hard Disk");
 		break;
@@ -205,17 +200,17 @@ void dev_print(struct blk_desc *dev_desc)
 		puts ("Tape");
 		break;
 	default:
-		printf ("# %02X #", dev_desc->type & 0x1F);
+		printf("# %02X #", desc->type & 0x1F);
 		break;
 	}
 	puts ("\n");
-	if (dev_desc->lba > 0L && dev_desc->blksz > 0L) {
+	if (desc->lba > 0L && desc->blksz > 0L) {
 		ulong mb, mb_quot, mb_rem, gb, gb_quot, gb_rem;
 		lbaint_t lba;
 
-		lba = dev_desc->lba;
+		lba = desc->lba;
 
-		lba512 = (lba * (dev_desc->blksz/512));
+		lba512 = lba * (desc->blksz / 512);
 		/* round to 1 digit */
 		/* 2048 = (1024 * 1024) / 512 MB */
 		mb = lba512_muldiv(lba512, 10, 11);
@@ -227,7 +222,7 @@ void dev_print(struct blk_desc *dev_desc)
 		gb_quot	= gb / 10;
 		gb_rem	= gb - (10 * gb_quot);
 #ifdef CONFIG_LBA48
-		if (dev_desc->lba48)
+		if (desc->lba48)
 			printf ("            Supports 48-bit addressing\n");
 #endif
 #if defined(CONFIG_SYS_64BIT_LBA)
@@ -235,42 +230,42 @@ void dev_print(struct blk_desc *dev_desc)
 			mb_quot, mb_rem,
 			gb_quot, gb_rem,
 			lba,
-			dev_desc->blksz);
+			desc->blksz);
 #else
 		printf ("            Capacity: %lu.%lu MB = %lu.%lu GB (%lu x %lu)\n",
 			mb_quot, mb_rem,
 			gb_quot, gb_rem,
 			(ulong)lba,
-			dev_desc->blksz);
+			desc->blksz);
 #endif
 	} else {
 		puts ("            Capacity: not available\n");
 	}
 }
 
-void part_init(struct blk_desc *dev_desc)
+void part_init(struct blk_desc *desc)
 {
 	struct part_driver *drv =
 		ll_entry_start(struct part_driver, part_driver);
 	const int n_ents = ll_entry_count(struct part_driver, part_driver);
 	struct part_driver *entry;
 
-	blkcache_invalidate(dev_desc->uclass_id, dev_desc->devnum);
+	blkcache_invalidate(desc->uclass_id, desc->devnum);
 
-	dev_desc->part_type = PART_TYPE_UNKNOWN;
+	desc->part_type = PART_TYPE_UNKNOWN;
 	for (entry = drv; entry != drv + n_ents; entry++) {
 		int ret;
 
-		ret = entry->test(dev_desc);
+		ret = entry->test(desc);
 		debug("%s: try '%s': ret=%d\n", __func__, entry->name, ret);
 		if (!ret) {
-			dev_desc->part_type = entry->part_type;
+			desc->part_type = entry->part_type;
 			break;
 		}
 	}
 }
 
-static void print_part_header(const char *type, struct blk_desc *dev_desc)
+static void print_part_header(const char *type, struct blk_desc *desc)
 {
 #if CONFIG_IS_ENABLED(MAC_PARTITION) || \
 	CONFIG_IS_ENABLED(DOS_PARTITION) || \
@@ -278,7 +273,7 @@ static void print_part_header(const char *type, struct blk_desc *dev_desc)
 	CONFIG_IS_ENABLED(AMIGA_PARTITION) || \
 	CONFIG_IS_ENABLED(EFI_PARTITION)
 	puts ("\nPartition Map for ");
-	switch (dev_desc->uclass_id) {
+	switch (desc->uclass_id) {
 	case UCLASS_IDE:
 		puts ("IDE");
 		break;
@@ -314,28 +309,28 @@ static void print_part_header(const char *type, struct blk_desc *dev_desc)
 		break;
 	}
 	printf (" device %d  --   Partition Type: %s\n\n",
-			dev_desc->devnum, type);
+			desc->devnum, type);
 #endif /* any CONFIG_..._PARTITION */
 }
 
-void part_print(struct blk_desc *dev_desc)
+void part_print(struct blk_desc *desc)
 {
 	struct part_driver *drv;
 
-	drv = part_driver_lookup_type(dev_desc);
+	drv = part_driver_lookup_type(desc);
 	if (!drv) {
 		printf("## Unknown partition table type %x\n",
-		       dev_desc->part_type);
+		       desc->part_type);
 		return;
 	}
 
 	PRINTF("## Testing for valid %s partition ##\n", drv->name);
-	print_part_header(drv->name, dev_desc);
+	print_part_header(drv->name, desc);
 	if (drv->print)
-		drv->print(dev_desc);
+		drv->print(desc);
 }
 
-int part_get_info_by_type(struct blk_desc *dev_desc, int part, int part_type,
+int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
 			  struct disk_partition *info)
 {
 	struct part_driver *drv;
@@ -350,14 +345,14 @@ int part_get_info_by_type(struct blk_desc *dev_desc, int part, int part_type,
 #endif
 
 		if (part_type == PART_TYPE_UNKNOWN) {
-			drv = part_driver_lookup_type(dev_desc);
+			drv = part_driver_lookup_type(desc);
 		} else {
 			drv = part_driver_get_type(part_type);
 		}
 
 		if (!drv) {
 			debug("## Unknown partition table type %x\n",
-			      dev_desc->part_type);
+			      desc->part_type);
 			return -EPROTONOSUPPORT;
 		}
 		if (!drv->get_info) {
@@ -365,7 +360,7 @@ int part_get_info_by_type(struct blk_desc *dev_desc, int part, int part_type,
 			       drv->name);
 			return -ENOSYS;
 		}
-		if (drv->get_info(dev_desc, part, info) == 0) {
+		if (drv->get_info(desc, part, info) == 0) {
 			PRINTF("## Valid %s partition found ##\n", drv->name);
 			return 0;
 		}
@@ -374,18 +369,18 @@ int part_get_info_by_type(struct blk_desc *dev_desc, int part, int part_type,
 	return -ENOENT;
 }
 
-int part_get_info(struct blk_desc *dev_desc, int part,
+int part_get_info(struct blk_desc *desc, int part,
 		  struct disk_partition *info)
 {
-	return part_get_info_by_type(dev_desc, part, PART_TYPE_UNKNOWN, info);
+	return part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info);
 }
 
-int part_get_info_whole_disk(struct blk_desc *dev_desc,
+int part_get_info_whole_disk(struct blk_desc *desc,
 			     struct disk_partition *info)
 {
 	info->start = 0;
-	info->size = dev_desc->lba;
-	info->blksz = dev_desc->blksz;
+	info->size = desc->lba;
+	info->blksz = desc->blksz;
 	info->bootable = 0;
 	strcpy((char *)info->type, BOOT_PART_TYPE);
 	strcpy((char *)info->name, "Whole Disk");
@@ -400,7 +395,7 @@ int part_get_info_whole_disk(struct blk_desc *dev_desc,
 }
 
 int blk_get_device_by_str(const char *ifname, const char *dev_hwpart_str,
-			  struct blk_desc **dev_desc)
+			  struct blk_desc **desc)
 {
 	char *ep;
 	char *dup_str = NULL;
@@ -436,8 +431,8 @@ int blk_get_device_by_str(const char *ifname, const char *dev_hwpart_str,
 		}
 	}
 
-	*dev_desc = get_dev_hwpart(ifname, dev, hwpart);
-	if (!(*dev_desc) || ((*dev_desc)->type == DEV_TYPE_UNKNOWN)) {
+	*desc = get_dev_hwpart(ifname, dev, hwpart);
+	if (!(*desc) || ((*desc)->type == DEV_TYPE_UNKNOWN)) {
 		debug("** Bad device %s %s **\n", ifname, dev_hwpart_str);
 		dev = -ENODEV;
 		goto cleanup;
@@ -449,8 +444,8 @@ int blk_get_device_by_str(const char *ifname, const char *dev_hwpart_str,
 		 * Always should be done, otherwise hw partition 0 will return
 		 * stale data after displaying a non-zero hw partition.
 		 */
-		if ((*dev_desc)->uclass_id == UCLASS_MMC)
-			part_init(*dev_desc);
+		if ((*desc)->uclass_id == UCLASS_MMC)
+			part_init(*desc);
 	}
 
 cleanup:
@@ -461,7 +456,7 @@ cleanup:
 #define PART_UNSPECIFIED -2
 #define PART_AUTO -1
 int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
-			     struct blk_desc **dev_desc,
+			     struct blk_desc **desc,
 			     struct disk_partition *info, int allow_whole_dev)
 {
 	int ret;
@@ -474,7 +469,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 	int part;
 	struct disk_partition tmpinfo;
 
-	*dev_desc = NULL;
+	*desc = NULL;
 	memset(info, 0, sizeof(*info));
 
 #if IS_ENABLED(CONFIG_SANDBOX) || IS_ENABLED(CONFIG_SEMIHOSTING)
@@ -533,7 +528,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 	}
 
 	/* Look up the device */
-	dev = blk_get_device_by_str(ifname, dev_str, dev_desc);
+	dev = blk_get_device_by_str(ifname, dev_str, desc);
 	if (dev < 0) {
 		printf("** Bad device specification %s %s **\n",
 		       ifname, dev_str);
@@ -565,9 +560,8 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 	 * No partition table on device,
 	 * or user requested partition 0 (entire device).
 	 */
-	if (((*dev_desc)->part_type == PART_TYPE_UNKNOWN) ||
-	    (part == 0)) {
-		if (!(*dev_desc)->lba) {
+	if (((*desc)->part_type == PART_TYPE_UNKNOWN) || !part) {
+		if (!(*desc)->lba) {
 			printf("** Bad device size - %s %s **\n", ifname,
 			       dev_str);
 			ret = -EINVAL;
@@ -586,9 +580,9 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 			goto cleanup;
 		}
 
-		(*dev_desc)->log2blksz = LOG2((*dev_desc)->blksz);
+		(*desc)->log2blksz = LOG2((*desc)->blksz);
 
-		part_get_info_whole_disk(*dev_desc, info);
+		part_get_info_whole_disk(*desc, info);
 
 		ret = 0;
 		goto cleanup;
@@ -606,7 +600,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 	 * other than "auto", use that partition number directly.
 	 */
 	if (part != PART_AUTO) {
-		ret = part_get_info(*dev_desc, part, info);
+		ret = part_get_info(*desc, part, info);
 		if (ret) {
 			printf("** Invalid partition %d **\n", part);
 			goto cleanup;
@@ -618,7 +612,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 		 */
 		part = 0;
 		for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
-			ret = part_get_info(*dev_desc, p, info);
+			ret = part_get_info(*desc, p, info);
 			if (ret)
 				continue;
 
@@ -662,7 +656,7 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
 		goto cleanup;
 	}
 
-	(*dev_desc)->log2blksz = LOG2((*dev_desc)->blksz);
+	(*desc)->log2blksz = LOG2((*desc)->blksz);
 
 	ret = part;
 	goto cleanup;
@@ -672,14 +666,14 @@ cleanup:
 	return ret;
 }
 
-int part_get_info_by_name(struct blk_desc *dev_desc, const char *name,
+int part_get_info_by_name(struct blk_desc *desc, const char *name,
 			  struct disk_partition *info)
 {
 	struct part_driver *part_drv;
 	int ret;
 	int i;
 
-	part_drv = part_driver_lookup_type(dev_desc);
+	part_drv = part_driver_lookup_type(desc);
 	if (!part_drv)
 		return -1;
 
@@ -690,7 +684,7 @@ int part_get_info_by_name(struct blk_desc *dev_desc, const char *name,
 	}
 
 	for (i = 1; i < part_drv->max_entries; i++) {
-		ret = part_drv->get_info(dev_desc, i, info);
+		ret = part_drv->get_info(desc, i, info);
 		if (ret != 0) {
 			/* no more entries in table */
 			break;
@@ -710,18 +704,18 @@ int part_get_info_by_name(struct blk_desc *dev_desc, const char *name,
  * Parse a device number and partition name string in the form of
  * "devicenum.hwpartnum#partition_name", for example "0.1#misc". devicenum and
  * hwpartnum are both optional, defaulting to 0. If the partition is found,
- * sets dev_desc and part_info accordingly with the information of the
+ * sets desc and part_info accordingly with the information of the
  * partition with the given partition_name.
  *
  * @param[in] dev_iface Device interface
  * @param[in] dev_part_str Input string argument, like "0.1#misc"
- * @param[out] dev_desc Place to store the device description pointer
+ * @param[out] desc Place to store the device description pointer
  * @param[out] part_info Place to store the partition information
  * Return: 0 on success, or a negative on error
  */
 static int part_get_info_by_dev_and_name(const char *dev_iface,
 					 const char *dev_part_str,
-					 struct blk_desc **dev_desc,
+					 struct blk_desc **desc,
 					 struct disk_partition *part_info)
 {
 	char *dup_str = NULL;
@@ -743,11 +737,11 @@ static int part_get_info_by_dev_and_name(const char *dev_iface,
 		return -EINVAL;
 	}
 
-	ret = blk_get_device_by_str(dev_iface, dev_str, dev_desc);
+	ret = blk_get_device_by_str(dev_iface, dev_str, desc);
 	if (ret < 0)
 		goto cleanup;
 
-	ret = part_get_info_by_name(*dev_desc, part_str, part_info);
+	ret = part_get_info_by_name(*desc, part_str, part_info);
 	if (ret < 0)
 		printf("Could not find \"%s\" partition\n", part_str);
 
@@ -758,35 +752,35 @@ cleanup:
 
 int part_get_info_by_dev_and_name_or_num(const char *dev_iface,
 					 const char *dev_part_str,
-					 struct blk_desc **dev_desc,
+					 struct blk_desc **desc,
 					 struct disk_partition *part_info,
 					 int allow_whole_dev)
 {
 	int ret;
 
 	/* Split the part_name if passed as "$dev_num#part_name". */
-	ret = part_get_info_by_dev_and_name(dev_iface, dev_part_str,
-					    dev_desc, part_info);
+	ret = part_get_info_by_dev_and_name(dev_iface, dev_part_str, desc,
+					    part_info);
 	if (ret >= 0)
 		return ret;
 	/*
 	 * Couldn't lookup by name, try looking up the partition description
 	 * directly.
 	 */
-	ret = blk_get_device_part_str(dev_iface, dev_part_str,
-				      dev_desc, part_info, allow_whole_dev);
+	ret = blk_get_device_part_str(dev_iface, dev_part_str, desc, part_info,
+				      allow_whole_dev);
 	if (ret < 0)
 		printf("Couldn't find partition %s %s\n",
 		       dev_iface, dev_part_str);
 	return ret;
 }
 
-void part_set_generic_name(const struct blk_desc *dev_desc,
-	int part_num, char *name)
+void part_set_generic_name(const struct blk_desc *desc, int part_num,
+			   char *name)
 {
 	char *devtype;
 
-	switch (dev_desc->uclass_id) {
+	switch (desc->uclass_id) {
 	case UCLASS_IDE:
 	case UCLASS_AHCI:
 		devtype = "hd";
@@ -805,7 +799,7 @@ void part_set_generic_name(const struct blk_desc *dev_desc,
 		break;
 	}
 
-	sprintf(name, "%s%c%d", devtype, 'a' + dev_desc->devnum, part_num);
+	sprintf(name, "%s%c%d", devtype, 'a' + desc->devnum, part_num);
 }
 
 int part_get_bootable(struct blk_desc *desc)
diff --git a/include/part.h b/include/part.h
index be1447687777..3a6be75421dd 100644
--- a/include/part.h
+++ b/include/part.h
@@ -113,7 +113,7 @@ struct blk_desc *mg_disk_get_dev(int dev);
  * contained with the interface's data structure. There is no global
  * numbering for block devices, so the interface name must be provided.
  *
- * @dev_desc:	Block device descriptor
+ * @desc:	Block device descriptor
  * @part:	Partition number to read
  * @part_type:	Partition driver to use, or PART_TYPE_UNKNOWN to automatically
  *		choose a driver
@@ -121,24 +121,24 @@ struct blk_desc *mg_disk_get_dev(int dev);
  *
  * Return: 0 on success, negative errno on failure
  */
-int part_get_info_by_type(struct blk_desc *dev_desc, int part, int part_type,
+int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
 			  struct disk_partition *info);
-int part_get_info(struct blk_desc *dev_desc, int part,
+int part_get_info(struct blk_desc *desc, int part,
 		  struct disk_partition *info);
 /**
  * part_get_info_whole_disk() - get partition info for the special case of
  * a partition occupying the entire disk.
  *
- * @dev_desc:	block device descriptor
+ * @desc:	block device descriptor
  * @info:	returned partition information
  * Return:	0 on success
  */
-int part_get_info_whole_disk(struct blk_desc *dev_desc,
+int part_get_info_whole_disk(struct blk_desc *desc,
 			     struct disk_partition *info);
 
-void part_print(struct blk_desc *dev_desc);
-void part_init(struct blk_desc *dev_desc);
-void dev_print(struct blk_desc *dev_desc);
+void part_print(struct blk_desc *desc);
+void part_init(struct blk_desc *desc);
+void dev_print(struct blk_desc *desc);
 
 /**
  * blk_get_device_by_str() - Get a block device given its interface/hw partition
@@ -162,11 +162,11 @@ void dev_print(struct blk_desc *dev_desc);
  *		containing the device number (e.g. "2") or the device number
  *		and hardware partition number (e.g. "2.4") for devices that
  *		support it (currently only MMC).
- * @dev_desc:	Returns a pointer to the block device on success
+ * @desc:	Returns a pointer to the block device on success
  * Return: block device number (local to the interface), or -1 on error
  */
 int blk_get_device_by_str(const char *ifname, const char *dev_str,
-			  struct blk_desc **dev_desc);
+			  struct blk_desc **desc);
 
 /**
  * blk_get_device_part_str() - Get a block device and partition
@@ -196,7 +196,7 @@ int blk_get_device_by_str(const char *ifname, const char *dev_str,
  *
  * @ifname:		Interface name (e.g. "ide", "scsi")
  * @dev_part_str:	Device and partition string
- * @dev_desc:		Returns a pointer to the block device on success
+ * @desc:		Returns a pointer to the block device on success
  * @info:		Returns partition information
  * @allow_whole_dev:	true to allow the user to select partition 0
  *			(which means the whole device), false to require a valid
@@ -205,22 +205,22 @@ int blk_get_device_by_str(const char *ifname, const char *dev_str,
  *
  */
 int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
-			    struct blk_desc **dev_desc,
+			    struct blk_desc **desc,
 			    struct disk_partition *info, int allow_whole_dev);
 
 /**
  * part_get_info_by_name() - Search for a partition by name
  *                           among all available registered partitions
  *
- * @dev_desc:	block device descriptor
+ * @desc:	block device descriptor
  * @name:	the specified table entry name
  * @info:	returns the disk partition info
  *
  * Return: the partition number on match (starting on 1), -1 on no match,
  * otherwise error
  */
-int part_get_info_by_name(struct blk_desc *dev_desc,
-			      const char *name, struct disk_partition *info);
+int part_get_info_by_name(struct blk_desc *desc, const char *name,
+			  struct disk_partition *info);
 
 /**
  * part_get_info_by_dev_and_name_or_num() - Get partition info from dev number
@@ -232,11 +232,11 @@ int part_get_info_by_name(struct blk_desc *dev_desc,
  * (like "device_num#partition_name") or a device number plus a partition number
  * separated by a ":". For example both "0#misc" and "0:1" can be valid
  * partition descriptions for a given interface. If the partition is found, sets
- * dev_desc and part_info accordingly with the information of the partition.
+ * desc and part_info accordingly with the information of the partition.
  *
  * @dev_iface:		Device interface
  * @dev_part_str:	Input partition description, like "0#misc" or "0:1"
- * @dev_desc:		Place to store the device description pointer
+ * @desc:		Place to store the device description pointer
  * @part_info:		Place to store the partition information
  * @allow_whole_dev:	true to allow the user to select partition 0
  *			(which means the whole device), false to require a valid
@@ -245,7 +245,7 @@ int part_get_info_by_name(struct blk_desc *dev_desc,
  */
 int part_get_info_by_dev_and_name_or_num(const char *dev_iface,
 					 const char *dev_part_str,
-					 struct blk_desc **dev_desc,
+					 struct blk_desc **desc,
 					 struct disk_partition *part_info,
 					 int allow_whole_dev);
 
@@ -256,12 +256,12 @@ int part_get_info_by_dev_and_name_or_num(const char *dev_iface,
  * (DOS, ISO). Generates partition name out of the device type and partition
  * number.
  *
- * @dev_desc:	pointer to the block device
+ * @desc:	pointer to the block device
  * @part_num:	partition number for which the name is generated
  * @name:	buffer where the name is written
  */
-void part_set_generic_name(const struct blk_desc *dev_desc,
-	int part_num, char *name);
+void part_set_generic_name(const struct blk_desc *desc, int part_num,
+			   char *name);
 
 extern const struct block_drvr block_drvr[];
 #else
@@ -269,26 +269,25 @@ static inline struct blk_desc *blk_get_dev(const char *ifname, int dev)
 { return NULL; }
 static inline struct blk_desc *mg_disk_get_dev(int dev) { return NULL; }
 
-static inline int part_get_info(struct blk_desc *dev_desc, int part,
+static inline int part_get_info(struct blk_desc *desc, int part,
 				struct disk_partition *info) { return -1; }
-static inline int part_get_info_whole_disk(struct blk_desc *dev_desc,
+static inline int part_get_info_whole_disk(struct blk_desc *desc,
 					   struct disk_partition *info)
 { return -1; }
-static inline void part_print(struct blk_desc *dev_desc) {}
-static inline void part_init(struct blk_desc *dev_desc) {}
-static inline void dev_print(struct blk_desc *dev_desc) {}
+static inline void part_print(struct blk_desc *desc) {}
+static inline void part_init(struct blk_desc *desc) {}
+static inline void dev_print(struct blk_desc *desc) {}
 static inline int blk_get_device_by_str(const char *ifname, const char *dev_str,
-					struct blk_desc **dev_desc)
+					struct blk_desc **desc)
 { return -1; }
 static inline int blk_get_device_part_str(const char *ifname,
 					  const char *dev_part_str,
-					  struct blk_desc **dev_desc,
+					  struct blk_desc **desc,
 					  struct disk_partition *info,
 					  int allow_whole_dev)
-{ *dev_desc = NULL; return -1; }
+{ *desc = NULL; return -1; }
 
-static inline int part_get_info_by_name(struct blk_desc *dev_desc,
-					const char *name,
+static inline int part_get_info_by_name(struct blk_desc *desc, const char *name,
 					struct disk_partition *info)
 {
 	return -ENOENT;
@@ -297,11 +296,11 @@ static inline int part_get_info_by_name(struct blk_desc *dev_desc,
 static inline int
 part_get_info_by_dev_and_name_or_num(const char *dev_iface,
 				     const char *dev_part_str,
-				     struct blk_desc **dev_desc,
+				     struct blk_desc **desc,
 				     struct disk_partition *part_info,
 				     int allow_whole_dev)
 {
-	*dev_desc = NULL;
+	*desc = NULL;
 	return -ENOSYS;
 }
 #endif
@@ -382,29 +381,29 @@ struct part_driver {
 	/**
 	 * @get_info:		Get information about a partition
 	 *
-	 * @get_info.dev_desc:	Block device descriptor
+	 * @get_info.desc:	Block device descriptor
 	 * @get_info.part:	Partition number (1 = first)
 	 * @get_info.info:	Returns partition information
 	 */
-	int (*get_info)(struct blk_desc *dev_desc, int part,
+	int (*get_info)(struct blk_desc *desc, int part,
 			struct disk_partition *info);
 
 	/**
 	 * @print:		Print partition information
 	 *
-	 * @print.dev_desc:	Block device descriptor
+	 * @print.desc:	Block device descriptor
 	 */
-	void (*print)(struct blk_desc *dev_desc);
+	void (*print)(struct blk_desc *desc);
 
 	/**
 	 * @test:		Test if a device contains this partition type
 	 *
-	 * @test.dev_desc:	Block device descriptor
+	 * @test.desc:		Block device descriptor
 	 * @test.Return:
 	 * 0 if the block device appears to contain this partition type,
 	 * -ve if not
 	 */
-	int (*test)(struct blk_desc *dev_desc);
+	int (*test)(struct blk_desc *desc);
 };
 
 /* Declare a new U-Boot partition 'driver' */
@@ -418,19 +417,18 @@ struct part_driver {
 /**
  * write_gpt_table() - Write the GUID Partition Table to disk
  *
- * @dev_desc:	block device descriptor
+ * @desc:	block device descriptor
  * @gpt_h:	pointer to GPT header representation
  * @gpt_e:	pointer to GPT partition table entries
  *
  * Return:	zero on success, otherwise error
  */
-int write_gpt_table(struct blk_desc *dev_desc,
-		  gpt_header *gpt_h, gpt_entry *gpt_e);
+int write_gpt_table(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry *gpt_e);
 
 /**
  * gpt_fill_pte() - Fill the GPT partition table entry
  *
- * @dev_desc:	block device descriptor
+ * @desc:	block device descriptor
  * @gpt_h:	GPT header representation
  * @gpt_e:	GPT partition table entries
  * @partitions:	list of partitions
@@ -438,55 +436,54 @@ int write_gpt_table(struct blk_desc *dev_desc,
  *
  * Return:	zero on success
  */
-int gpt_fill_pte(struct blk_desc *dev_desc,
-		 gpt_header *gpt_h, gpt_entry *gpt_e,
+int gpt_fill_pte(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry *gpt_e,
 		 struct disk_partition *partitions, int parts);
 
 /**
  * gpt_fill_header() - Fill the GPT header
  *
- * @dev_desc:		block device descriptor
+ * @desc:		block device descriptor
  * @gpt_h:		GPT header representation
  * @str_guid:		disk guid string representation
  * @parts_count:	number of partitions
  *
  * Return:		error on str_guid conversion error
  */
-int gpt_fill_header(struct blk_desc *dev_desc, gpt_header *gpt_h,
-		char *str_guid, int parts_count);
+int gpt_fill_header(struct blk_desc *desc, gpt_header *gpt_h, char *str_guid,
+		    int parts_count);
 
 /**
  * gpt_restore() - Restore GPT partition table
  *
- * @dev_desc:		block device descriptor
+ * @desc:		block device descriptor
  * @str_disk_guid:	disk GUID
  * @partitions:		list of partitions
  * @parts_count:	number of partitions
  *
  * Return:		0 on success
  */
-int gpt_restore(struct blk_desc *dev_desc, char *str_disk_guid,
+int gpt_restore(struct blk_desc *desc, char *str_disk_guid,
 		struct disk_partition *partitions, const int parts_count);
 
 /**
  * is_valid_gpt_buf() - Ensure that the Primary GPT information is valid
  *
- * @dev_desc:	block device descriptor
+ * @desc:	block device descriptor
  * @buf:	buffer which contains the MBR and Primary GPT info
  *
  * Return:	0 on success, otherwise error
  */
-int is_valid_gpt_buf(struct blk_desc *dev_desc, void *buf);
+int is_valid_gpt_buf(struct blk_desc *desc, void *buf);
 
 /**
  * write_mbr_and_gpt_partitions() - write MBR, Primary GPT and Backup GPT
  *
- * @dev_desc:	block device descriptor
+ * @desc:	block device descriptor
  * @buf:	buffer which contains the MBR and Primary GPT info
  *
  * Return:	0 on success, otherwise error
  */
-int write_mbr_and_gpt_partitions(struct blk_desc *dev_desc, void *buf);
+int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf);
 
 /**
  * gpt_verify_headers() - Read and check CRC32 of the GPT's header
@@ -494,24 +491,24 @@ int write_mbr_and_gpt_partitions(struct blk_desc *dev_desc, void *buf);
  *
  * As a side effect if sets gpt_head and gpt_pte so they point to GPT data.
  *
- * @dev_desc:	block device descriptor
+ * @desc:	block device descriptor
  * @gpt_head:	pointer to GPT header data read from medium
  * @gpt_pte:	pointer to GPT partition table enties read from medium
  *
  * Return:	0 on success, otherwise error
  */
-int gpt_verify_headers(struct blk_desc *dev_desc, gpt_header *gpt_head,
+int gpt_verify_headers(struct blk_desc *desc, gpt_header *gpt_head,
 		       gpt_entry **gpt_pte);
 
 /**
  * gpt_repair_headers() - Function to repair the GPT's header
  *                        and partition table entries (PTE)
  *
- * @dev_desc:	block device descriptor
+ * @desc:	block device descriptor
  *
  * Return:	0 on success, otherwise error
  */
-int gpt_repair_headers(struct blk_desc *dev_desc);
+int gpt_repair_headers(struct blk_desc *desc);
 
 /**
  * gpt_verify_partitions() - Function to check if partitions' name, start and
@@ -521,7 +518,7 @@ int gpt_repair_headers(struct blk_desc *dev_desc);
  * provided in '$partitions' environment variable. Specificially, name, start
  * and size of the partition is checked.
  *
- * @dev_desc:	block device descriptor
+ * @desc:	block device descriptor
  * @partitions:	partition data read from '$partitions' env variable
  * @parts:	number of partitions read from '$partitions' env variable
  * @gpt_head:	pointer to GPT header data read from medium
@@ -529,7 +526,7 @@ int gpt_repair_headers(struct blk_desc *dev_desc);
  *
  * Return:	0 on success, otherwise error
  */
-int gpt_verify_partitions(struct blk_desc *dev_desc,
+int gpt_verify_partitions(struct blk_desc *desc,
 			  struct disk_partition *partitions, int parts,
 			  gpt_header *gpt_head, gpt_entry **gpt_pte);
 
@@ -540,12 +537,12 @@ int gpt_verify_partitions(struct blk_desc *dev_desc,
  * This function reads the GUID string from a block device whose descriptor
  * is provided.
  *
- * @dev_desc:	block device descriptor
+ * @desc:	block device descriptor
  * @guid:	pre-allocated string in which to return the GUID
  *
  * Return:	0 on success, otherwise error
  */
-int get_disk_guid(struct blk_desc *dev_desc, char *guid);
+int get_disk_guid(struct blk_desc *desc, char *guid);
 
 #endif
 
@@ -562,12 +559,12 @@ int is_valid_dos_buf(void *buf);
 /**
  * write_mbr_sector() - write DOS MBR
  *
- * @dev_desc:	block device descriptor
+ * @desc:	block device descriptor
  * @buf:	buffer which contains the MBR
  *
  * Return:	0 on success, otherwise error
  */
-int write_mbr_sector(struct blk_desc *dev_desc, void *buf);
+int write_mbr_sector(struct blk_desc *desc, void *buf);
 
 int write_mbr_partitions(struct blk_desc *dev,
 		struct disk_partition *p, int count, unsigned int disksig);
-- 
2.42.0.rc1.204.g551eb34607-goog

