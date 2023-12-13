Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E08C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 08:59:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE2F586D38;
	Wed, 13 Dec 2023 09:59:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X5/JVMSj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA9787698; Wed, 13 Dec 2023 09:59:23 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F246086C67
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 09:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d345b187bbso10854865ad.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 00:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702457958; x=1703062758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=De6Nmar1AxcHZqAA1ONzkaCW4m/X8QBgMVDwNbsl2yE=;
 b=X5/JVMSjPD0xCN9f5ZLsfSnRoJt/R21rlB0y52S4Vk0NInySwcUBMmnGK/C0gcOpLO
 kugZU/QgPafGAjjJWpSpvaKUqJM1h0jBx9wymr7+OS6zX3Gg8ND1tD1rWXj43YKtemMB
 h3XuC0js6CQVBoWUZyXRPh9hn6nIitMG/oSq//sMMfXJDbkxPDklqh+LRSDhsrTrj1I5
 7X7Uq9EflDaO2+w5fKte/HT4ZWq6tiZMLvz+3O8IdeI2nGMQSXAwoWjMHUsvwB5p3vS7
 trpvAK7OB2sGNS57RjNTx7Ql/2fTPRxoT6Db4uAjiNEKYLGqySshLdL1csWtKsbOPSSp
 3rjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702457958; x=1703062758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=De6Nmar1AxcHZqAA1ONzkaCW4m/X8QBgMVDwNbsl2yE=;
 b=saCyM4LNmGDJ2LIQ68KgKeOkIguTW8tlqrE9i1Cu3HdvEyCyIZoRgoaL2WVXX2YdL6
 oWRPBMbQ/wneq/GJtKEzhN7KLxmOpS8usWb1AhOak2o9s78XilUFyNrfVopVRnXIDM4u
 Rl1NucPAjGrgDu/5TkWXsKr7rt1+HiOzQnScVi8mrDmBZwUi4HZvm1kCM740et0hleDv
 oi5NczvtApfDlY2m05M/aOAun4WfsR8TDEX2xAbmVqTz6IN7e0gmETgdyuLmeG4Uwujs
 W/1lWzrGWpWogNlSaxmuvSa4it+23vvmncVLECC1h6J51G67Tj//3L6J2/zNKHUUjgeU
 mzGA==
X-Gm-Message-State: AOJu0YzRN+f2fPYEkcE4tV9EKx9X3VjaqRo58hgIRmwo2GR2BNAxlhW7
 8ixsbb7KK44wFyrL6vDv6N5qiM7yiirHmNLv88c=
X-Google-Smtp-Source: AGHT+IGvXB6Dte/0CI9PyW0sby2fubQ7906CN3TccgE/Qi0Lwl6WHSh4kz+048gKabOcOcZ91A4lRg==
X-Received: by 2002:a17:903:22c7:b0:1d0:7965:f530 with SMTP id
 y7-20020a17090322c700b001d07965f530mr7663264plg.88.1702457957834; 
 Wed, 13 Dec 2023 00:59:17 -0800 (PST)
Received: from localhost ([164.70.16.189]) by smtp.gmail.com with ESMTPSA id
 12-20020a170902c24c00b001d3485656afsm1310539plg.183.2023.12.13.00.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 00:59:17 -0800 (PST)
From: Masahisa Kojima <masahisa.kojima@linaro.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <masahisa.kojima@linaro.org>
Subject: [PATCH] efi_loader: eliminate efi_disk_obj structure
Date: Wed, 13 Dec 2023 17:57:37 +0900
Message-Id: <20231213085737.299773-1-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Current code uses struct efi_disk_obj to keep information
about block devices and partitions. As the efi handle already
has a field with the udevice, we should eliminate
struct efi_disk_obj and use an pointer to struct efi_object
for the handle.

efi_link_dev() call is moved inside of efi_disk_add_dev() function
to simplify the cleanup process in case of error.

Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 lib/efi_loader/efi_disk.c | 209 +++++++++++++++++++++-----------------
 1 file changed, 116 insertions(+), 93 deletions(-)

diff --git a/lib/efi_loader/efi_disk.c b/lib/efi_loader/efi_disk.c
index f0d76113b0..cfb7ace551 100644
--- a/lib/efi_loader/efi_disk.c
+++ b/lib/efi_loader/efi_disk.c
@@ -27,27 +27,24 @@ struct efi_system_partition efi_system_partition = {
 const efi_guid_t efi_block_io_guid = EFI_BLOCK_IO_PROTOCOL_GUID;
 const efi_guid_t efi_system_partition_guid = PARTITION_SYSTEM_GUID;
 
-/**
- * struct efi_disk_obj - EFI disk object
- *
- * @header:	EFI object header
- * @ops:	EFI disk I/O protocol interface
- * @dev_index:	device index of block device
- * @media:	block I/O media information
- * @dp:		device path to the block device
- * @part:	partition
- * @volume:	simple file system protocol of the partition
- * @dev:	associated DM device
- */
-struct efi_disk_obj {
-	struct efi_object header;
-	struct efi_block_io ops;
-	int dev_index;
-	struct efi_block_io_media media;
-	struct efi_device_path *dp;
-	unsigned int part;
-	struct efi_simple_file_system_protocol *volume;
-};
+static efi_handle_t efi_blkio_find_obj(struct efi_block_io *blkio)
+{
+	efi_handle_t handle;
+
+	list_for_each_entry(handle, &efi_obj_list, link) {
+		efi_status_t ret;
+		struct efi_handler *handler;
+
+		ret = efi_search_protocol(handle, &efi_block_io_guid, &handler);
+		if (ret != EFI_SUCCESS)
+			continue;
+
+		if (blkio == handler->protocol_interface)
+			return handle;
+	}
+
+	return NULL;
+}
 
 /**
  * efi_disk_reset() - reset block device
@@ -107,13 +104,16 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
 			u32 media_id, u64 lba, unsigned long buffer_size,
 			void *buffer, enum efi_disk_direction direction)
 {
-	struct efi_disk_obj *diskobj;
+	efi_handle_t handle;
 	int blksz;
 	int blocks;
 	unsigned long n;
 
-	diskobj = container_of(this, struct efi_disk_obj, ops);
-	blksz = diskobj->media.block_size;
+	handle = efi_blkio_find_obj(this);
+	if (!handle)
+		return EFI_INVALID_PARAMETER;
+
+	blksz = this->media->block_size;
 	blocks = buffer_size / blksz;
 
 	EFI_PRINT("blocks=%x lba=%llx blksz=%x dir=%d\n",
@@ -124,18 +124,16 @@ static efi_status_t efi_disk_rw_blocks(struct efi_block_io *this,
 		return EFI_BAD_BUFFER_SIZE;
 
 	if (CONFIG_IS_ENABLED(PARTITIONS) &&
-	    device_get_uclass_id(diskobj->header.dev) == UCLASS_PARTITION) {
+	    device_get_uclass_id(handle->dev) == UCLASS_PARTITION) {
 		if (direction == EFI_DISK_READ)
-			n = disk_blk_read(diskobj->header.dev, lba, blocks,
-					  buffer);
+			n = disk_blk_read(handle->dev, lba, blocks, buffer);
 		else
-			n = disk_blk_write(diskobj->header.dev, lba, blocks,
-					   buffer);
+			n = disk_blk_write(handle->dev, lba, blocks, buffer);
 	} else {
 		/* dev is a block device (UCLASS_BLK) */
 		struct blk_desc *desc;
 
-		desc = dev_get_uclass_plat(diskobj->header.dev);
+		desc = dev_get_uclass_plat(handle->dev);
 		if (direction == EFI_DISK_READ)
 			n = blk_dread(desc, lba, blocks, buffer);
 		else
@@ -388,6 +386,7 @@ static int efi_fs_exists(struct blk_desc *desc, int part)
  * @part:		partition
  * @disk:		pointer to receive the created handle
  * @agent_handle:	handle of the EFI block driver
+ * @dev:		pointer to udevice
  * Return:		disk object
  */
 static efi_status_t efi_disk_add_dev(
@@ -397,24 +396,33 @@ static efi_status_t efi_disk_add_dev(
 				int dev_index,
 				struct disk_partition *part_info,
 				unsigned int part,
-				struct efi_disk_obj **disk,
-				efi_handle_t agent_handle)
+				efi_handle_t *disk,
+				efi_handle_t agent_handle,
+				struct udevice *dev)
 {
-	struct efi_disk_obj *diskobj;
-	struct efi_object *handle;
+	efi_handle_t handle;
 	const efi_guid_t *esp_guid = NULL;
 	efi_status_t ret;
+	struct efi_block_io *blkio;
+	struct efi_block_io_media *media;
+	struct efi_device_path *dp = NULL;
+	struct efi_simple_file_system_protocol *volume = NULL;
 
 	/* Don't add empty devices */
 	if (!desc->lba)
 		return EFI_NOT_READY;
 
-	diskobj = calloc(1, sizeof(*diskobj));
-	if (!diskobj)
+	ret = efi_create_handle(&handle);
+	if (ret != EFI_SUCCESS)
+		return ret;
+
+	blkio = calloc(1, sizeof(*blkio));
+	media = calloc(1, sizeof(*media));
+	if (!blkio || !media)
 		return EFI_OUT_OF_RESOURCES;
 
-	/* Hook up to the device list */
-	efi_add_handle(&diskobj->header);
+	*blkio = block_io_disk_template;
+	blkio->media = media;
 
 	/* Fill in object data */
 	if (part_info) {
@@ -440,23 +448,22 @@ static efi_status_t efi_disk_add_dev(
 		 * (controller).
 		 */
 		ret = efi_protocol_open(handler, &protocol_interface, NULL,
-					&diskobj->header,
+					handle,
 					EFI_OPEN_PROTOCOL_BY_CHILD_CONTROLLER);
 		if (ret != EFI_SUCCESS) {
 			log_debug("prot open failed\n");
 			goto error;
 		}
 
-		diskobj->dp = efi_dp_append_node(dp_parent, node);
+		dp = efi_dp_append_node(dp_parent, node);
 		efi_free_pool(node);
-		diskobj->media.last_block = part_info->size - 1;
+		blkio->media->last_block = part_info->size - 1;
 		if (part_info->bootable & PART_EFI_SYSTEM_PARTITION)
 			esp_guid = &efi_system_partition_guid;
 	} else {
-		diskobj->dp = efi_dp_from_part(desc, part);
-		diskobj->media.last_block = desc->lba - 1;
+		dp = efi_dp_from_part(desc, part);
+		blkio->media->last_block = desc->lba - 1;
 	}
-	diskobj->part = part;
 
 	/*
 	 * Install the device path and the block IO protocol.
@@ -465,11 +472,10 @@ static efi_status_t efi_disk_add_dev(
 	 * already installed on an other handle and returns EFI_ALREADY_STARTED
 	 * in this case.
 	 */
-	handle = &diskobj->header;
 	ret = efi_install_multiple_protocol_interfaces(
 					&handle,
-					&efi_guid_device_path, diskobj->dp,
-					&efi_block_io_guid, &diskobj->ops,
+					&efi_guid_device_path, dp,
+					&efi_block_io_guid, blkio,
 					/*
 					 * esp_guid must be last entry as it
 					 * can be NULL. Its interface is NULL.
@@ -487,43 +493,39 @@ static efi_status_t efi_disk_add_dev(
 	 */
 	if ((part || desc->part_type == PART_TYPE_UNKNOWN) &&
 	    efi_fs_exists(desc, part)) {
-		ret = efi_create_simple_file_system(desc, part, diskobj->dp,
-						    &diskobj->volume);
+		ret = efi_create_simple_file_system(desc, part, dp, &volume);
 		if (ret != EFI_SUCCESS)
 			goto error;
 
-		ret = efi_add_protocol(&diskobj->header,
+		ret = efi_add_protocol(handle,
 				       &efi_simple_file_system_protocol_guid,
-				       diskobj->volume);
+				       volume);
 		if (ret != EFI_SUCCESS)
 			goto error;
 	}
-	diskobj->ops = block_io_disk_template;
-	diskobj->dev_index = dev_index;
 
 	/* Fill in EFI IO Media info (for read/write callbacks) */
-	diskobj->media.removable_media = desc->removable;
-	diskobj->media.media_present = 1;
+	blkio->media->removable_media = desc->removable;
+	blkio->media->media_present = 1;
 	/*
 	 * MediaID is just an arbitrary counter.
 	 * We have to change it if the medium is removed or changed.
 	 */
-	diskobj->media.media_id = 1;
-	diskobj->media.block_size = desc->blksz;
-	diskobj->media.io_align = desc->blksz;
+	blkio->media->media_id = 1;
+	blkio->media->block_size = desc->blksz;
+	blkio->media->io_align = desc->blksz;
 	if (part)
-		diskobj->media.logical_partition = 1;
-	diskobj->ops.media = &diskobj->media;
+		blkio->media->logical_partition = 1;
 	if (disk)
-		*disk = diskobj;
+		*disk = handle;
 
 	EFI_PRINT("BlockIO: part %u, present %d, logical %d, removable %d"
 		  ", last_block %llu\n",
-		  diskobj->part,
-		  diskobj->media.media_present,
-		  diskobj->media.logical_partition,
-		  diskobj->media.removable_media,
-		  diskobj->media.last_block);
+		  part,
+		  blkio->media->media_present,
+		  blkio->media->logical_partition,
+		  blkio->media->removable_media,
+		  blkio->media->last_block);
 
 	/* Store first EFI system partition */
 	if (part && efi_system_partition.uclass_id == UCLASS_INVALID) {
@@ -536,11 +538,18 @@ static efi_status_t efi_disk_add_dev(
 				  desc->devnum, part);
 		}
 	}
+
+	if (efi_link_dev(handle, dev))
+		goto error;
+
 	return EFI_SUCCESS;
 error:
-	efi_delete_handle(&diskobj->header);
-	free(diskobj->volume);
-	free(diskobj);
+	efi_delete_handle(handle);
+	efi_free_pool(dp);
+	free(blkio);
+	free(media);
+	free(volume);
+
 	return ret;
 }
 
@@ -557,7 +566,7 @@ error:
  */
 static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
 {
-	struct efi_disk_obj *disk;
+	efi_handle_t disk;
 	struct blk_desc *desc;
 	int diskid;
 	efi_status_t ret;
@@ -566,7 +575,7 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
 	diskid = desc->devnum;
 
 	ret = efi_disk_add_dev(NULL, NULL, desc,
-			       diskid, NULL, 0, &disk, agent_handle);
+			       diskid, NULL, 0, &disk, agent_handle, dev);
 	if (ret != EFI_SUCCESS) {
 		if (ret == EFI_NOT_READY) {
 			log_notice("Disk %s not ready\n", dev->name);
@@ -578,12 +587,6 @@ static int efi_disk_create_raw(struct udevice *dev, efi_handle_t agent_handle)
 
 		return ret;
 	}
-	if (efi_link_dev(&disk->header, dev)) {
-		efi_free_pool(disk->dp);
-		efi_delete_handle(&disk->header);
-
-		return -EINVAL;
-	}
 
 	return 0;
 }
@@ -609,7 +612,7 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
 	int diskid;
 	struct efi_handler *handler;
 	struct efi_device_path *dp_parent;
-	struct efi_disk_obj *disk;
+	efi_handle_t disk;
 	efi_status_t ret;
 
 	if (dev_tag_get_ptr(dev_get_parent(dev), DM_TAG_EFI, (void **)&parent))
@@ -628,17 +631,11 @@ static int efi_disk_create_part(struct udevice *dev, efi_handle_t agent_handle)
 	dp_parent = (struct efi_device_path *)handler->protocol_interface;
 
 	ret = efi_disk_add_dev(parent, dp_parent, desc, diskid,
-			       info, part, &disk, agent_handle);
+			       info, part, &disk, agent_handle, dev);
 	if (ret != EFI_SUCCESS) {
 		log_err("Adding partition for %s failed\n", dev->name);
 		return -1;
 	}
-	if (efi_link_dev(&disk->header, dev)) {
-		efi_free_pool(disk->dp);
-		efi_delete_handle(&disk->header);
-
-		return -1;
-	}
 
 	return 0;
 }
@@ -693,13 +690,34 @@ int efi_disk_probe(void *ctx, struct event *event)
 	return 0;
 }
 
+static void get_disk_resources(efi_handle_t handle, struct efi_device_path **dp,
+			       struct efi_block_io **blkio,
+			       struct efi_simple_file_system_protocol **volume)
+{
+	efi_status_t ret;
+	struct efi_handler *handler;
+
+	ret = efi_search_protocol(handle, &efi_guid_device_path, &handler);
+	if (ret == EFI_SUCCESS)
+		*dp = handler->protocol_interface;
+
+	ret = efi_search_protocol(handle, &efi_block_io_guid, &handler);
+	if (ret == EFI_SUCCESS)
+		*blkio = handler->protocol_interface;
+
+	ret = efi_search_protocol(handle, &efi_simple_file_system_protocol_guid,
+				  &handler);
+	if (ret == EFI_SUCCESS)
+		*volume = handler->protocol_interface;
+}
+
 /**
- * efi_disk_remove - delete an efi_disk object for a block device or partition
+ * efi_disk_remove - delete an efi handle for a block device or partition
  *
  * @ctx:	event context: driver binding protocol
  * @event:	EV_PM_PRE_REMOVE event
  *
- * Delete an efi_disk object which is associated with the UCLASS_BLK or
+ * Delete an efi handle which is associated with the UCLASS_BLK or
  * UCLASS_PARTITION device for which the EV_PM_PRE_REMOVE event is raised.
  *
  * Return:	0 on success, -1 otherwise
@@ -710,8 +728,10 @@ int efi_disk_remove(void *ctx, struct event *event)
 	struct udevice *dev = event->data.dm.dev;
 	efi_handle_t handle;
 	struct blk_desc *desc;
-	struct efi_disk_obj *diskobj = NULL;
 	efi_status_t ret;
+	struct efi_device_path *dp = NULL;
+	struct efi_block_io *blkio = NULL;
+	struct efi_simple_file_system_protocol *volume = NULL;
 
 	if (dev_tag_get_ptr(dev, DM_TAG_EFI, (void **)&handle))
 		return 0;
@@ -721,11 +741,11 @@ int efi_disk_remove(void *ctx, struct event *event)
 	case UCLASS_BLK:
 		desc = dev_get_uclass_plat(dev);
 		if (desc && desc->uclass_id != UCLASS_EFI_LOADER)
-			diskobj = container_of(handle, struct efi_disk_obj,
-					       header);
+			get_disk_resources(handle, &dp, &blkio, &volume);
+
 		break;
 	case UCLASS_PARTITION:
-		diskobj = container_of(handle, struct efi_disk_obj, header);
+		get_disk_resources(handle, &dp, &blkio, &volume);
 		break;
 	default:
 		return 0;
@@ -736,8 +756,11 @@ int efi_disk_remove(void *ctx, struct event *event)
 	if (ret != EFI_SUCCESS)
 		return -1;
 
-	if (diskobj)
-		efi_free_pool(diskobj->dp);
+	efi_free_pool(dp);
+	if (blkio) {
+		free(blkio->media);
+		free(blkio);
+	}
 
 	dev_tag_del(dev, DM_TAG_EFI);
 
-- 
2.34.1

