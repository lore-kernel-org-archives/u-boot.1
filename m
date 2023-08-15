Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD1EC001B0
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 10:32:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A05F386725;
	Tue, 15 Aug 2023 12:32:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="n5YhyJA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF1F98678C; Tue, 15 Aug 2023 12:32:22 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCDCF866A7
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 12:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-062-143-244-162.um16.pools.vodafone-ip.de
 [62.143.244.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0CAD13F2A2; 
 Tue, 15 Aug 2023 10:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1692095539;
 bh=mh4iAUiIe1VlqYVG2OhrnNE/v97sgWPKVxj/pF5I5UY=;
 h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
 b=n5YhyJA/KFWXkULoReIgAoSo0hOW8sa5wfnsJekAOIbkGVRvb81X1FO8bynY9jYyF
 CnWL8QOg81hlToCPLR4haiafdLbgbOui5xD0r/Aw8tgRL2Z3ANCs5uGpIJCiRS5jJN
 QD9OsyoLfRKOWBAvVPdNI9C2+mDYLMNBdUVBZw5S6rSnknycWDnEgpgeZYAsBr0jp6
 IJklhW3rV5qyRY84z36MV7OzyRsvyOIQEIC0H6CD/yw+gEQ4qeCZE7MfIjfJapSF/D
 96njiMg1sBtRUjkGopEiRwgvkMHWM2XP/9ETEGY+9xoDz696bvLWb3AiWJMpv4RYys
 3WqXX2nxyFfJw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] doc: add partition API to HTML documentation
Date: Tue, 15 Aug 2023 12:32:59 +0200
Message-Id: <20230815103259.17476-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.40.1
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

* Convert comments in part.h to Sphinx style.
* Create documentation page for the partition API.
* Add the partition API page to the API index page.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 doc/api/index.rst |   1 +
 doc/api/part.rst  |   6 ++
 include/part.h    | 210 ++++++++++++++++++++++++----------------------
 3 files changed, 119 insertions(+), 98 deletions(-)
 create mode 100644 doc/api/part.rst

diff --git a/doc/api/index.rst b/doc/api/index.rst
index a9338cfef9..3a80ae0635 100644
--- a/doc/api/index.rst
+++ b/doc/api/index.rst
@@ -15,6 +15,7 @@ U-Boot API documentation
    lmb
    logging
    nvmem
+   part
    pinctrl
    rng
    sandbox
diff --git a/doc/api/part.rst b/doc/api/part.rst
new file mode 100644
index 0000000000..d1df1d8494
--- /dev/null
+++ b/doc/api/part.rst
@@ -0,0 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Partition API
+=============
+
+.. kernel-doc:: include/part.h
diff --git a/include/part.h b/include/part.h
index edc46f8dcb..8e451bbdff 100644
--- a/include/part.h
+++ b/include/part.h
@@ -98,8 +98,8 @@ struct disk_part {
  * @ifname:	Interface name (e.g. "ide", "scsi")
  * @dev:	Device number (0 for first device on that interface, 1 for
  *		second, etc.
- * Return: pointer to the block device, or NULL if not available, or an
- *	   error occurred.
+ * Return:
+ * pointer to the block device, or NULL if not available, or an error occurred.
  */
 struct blk_desc *blk_get_dev(const char *ifname, int dev);
 
@@ -128,6 +128,10 @@ int part_get_info(struct blk_desc *dev_desc, int part,
 /**
  * part_get_info_whole_disk() - get partition info for the special case of
  * a partition occupying the entire disk.
+ *
+ * @dev_desc:	block device descriptor
+ * @info:	returned partition information
+ * Return:	0 on success
  */
 int part_get_info_whole_disk(struct blk_desc *dev_desc,
 			     struct disk_partition *info);
@@ -170,15 +174,18 @@ int blk_get_device_by_str(const char *ifname, const char *dev_str,
  * This calls blk_get_device_by_str() to look up a device. It also looks up
  * a partition and returns information about it.
  *
- * @dev_part_str is in the format:
- *	<dev>.<hw_part>:<part> where <dev> is the device number,
- *	<hw_part> is the optional hardware partition number and
- *	<part> is the partition number
+ * @dev_part_str is in the format <dev>.<hw_part>:<part> where
+ *
+ * * <dev> is the device number,
+ *
+ * * <hw_part> is the optional hardware partition number and
  *
- * If ifname is "hostfs" then this function returns the sandbox host block
+ * * <part> is the partition number.
+ *
+ * If @ifname is "hostfs", then this function returns the sandbox host block
  * device.
  *
- * If ifname is ubi, then this function returns 0, with @info set to a
+ * If @ifname is "ubi", then this function returns 0, with @info set to a
  * special UBI device.
  *
  * If @dev_part_str is NULL or empty or "-", then this function looks up
@@ -187,13 +194,13 @@ int blk_get_device_by_str(const char *ifname, const char *dev_str,
  * If the partition string is empty then the first partition is used. If the
  * partition string is "auto" then the first bootable partition is used.
  *
- * @ifname:	Interface name (e.g. "ide", "scsi")
+ * @ifname:		Interface name (e.g. "ide", "scsi")
  * @dev_part_str:	Device and partition string
- * @dev_desc:	Returns a pointer to the block device on success
- * @info:	Returns partition information
+ * @dev_desc:		Returns a pointer to the block device on success
+ * @info:		Returns partition information
  * @allow_whole_dev:	true to allow the user to select partition 0
- *		(which means the whole device), false to require a valid
- *		partition number >= 1
+ *			(which means the whole device), false to require a valid
+ *			partition number >= 1
  * Return: partition number, or -1 on error
  *
  */
@@ -205,18 +212,20 @@ int blk_get_device_part_str(const char *ifname, const char *dev_part_str,
  * part_get_info_by_name() - Search for a partition by name
  *                           among all available registered partitions
  *
- * @param dev_desc - block device descriptor
- * @param gpt_name - the specified table entry name
- * @param info - returns the disk partition info
+ * @dev_desc:	block device descriptor
+ * @name:	the specified table entry name
+ * @info:	returns the disk partition info
  *
- * Return: - the partition number on match (starting on 1), -1 on no match,
+ * Return: the partition number on match (starting on 1), -1 on no match,
  * otherwise error
  */
 int part_get_info_by_name(struct blk_desc *dev_desc,
 			      const char *name, struct disk_partition *info);
 
 /**
- * Get partition info from dev number + part name, or dev number + part number.
+ * part_get_info_by_dev_and_name_or_num() - Get partition info from dev number
+ *					    and part name, or dev number and
+ *					    part number.
  *
  * Parse a device number and partition description (either name or number)
  * in the form of device number plus partition name separated by a "#"
@@ -225,14 +234,14 @@ int part_get_info_by_name(struct blk_desc *dev_desc,
  * partition descriptions for a given interface. If the partition is found, sets
  * dev_desc and part_info accordingly with the information of the partition.
  *
- * @param[in] dev_iface	Device interface
- * @param[in] dev_part_str Input partition description, like "0#misc" or "0:1"
- * @param[out] dev_desc	Place to store the device description pointer
- * @param[out] part_info Place to store the partition information
- * @param[in] allow_whole_dev true to allow the user to select partition 0
- *		(which means the whole device), false to require a valid
- *		partition number >= 1
- * Return: the partition number on success, or negative errno on error
+ * @dev_iface:		Device interface
+ * @dev_part_str:	Input partition description, like "0#misc" or "0:1"
+ * @dev_desc:		Place to store the device description pointer
+ * @part_info:		Place to store the partition information
+ * @allow_whole_dev:	true to allow the user to select partition 0
+ *			(which means the whole device), false to require a valid
+ *			partition number >= 1
+ * Return:	the partition number on success, or negative errno on error
  */
 int part_get_info_by_dev_and_name_or_num(const char *dev_iface,
 					 const char *dev_part_str,
@@ -322,7 +331,7 @@ int part_create_block_devices(struct udevice *blk_dev);
  * @start:	Start block number to read in the partition (0=first)
  * @blkcnt:	Number of blocks to read
  * @buffer:	Destination buffer for data read
- * Returns: number of blocks read, or -ve error number (see the
+ * Return:	number of blocks read, or -ve error number (see the
  * IS_ERR_VALUE() macro
  */
 ulong disk_blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
@@ -335,7 +344,7 @@ ulong disk_blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
  * @start:	Start block number to write in the partition (0=first)
  * @blkcnt:	Number of blocks to write
  * @buffer:	Source buffer for data to write
- * Returns: number of blocks written, or -ve error number (see the
+ * Return:	number of blocks written, or -ve error number (see the
  * IS_ERR_VALUE() macro
  */
 ulong disk_blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
@@ -347,7 +356,7 @@ ulong disk_blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,
  * @dev:	Device to (partially) erase (UCLASS_PARTITION)
  * @start:	Start block number to erase in the partition (0=first)
  * @blkcnt:	Number of blocks to erase
- * Returns: number of blocks erased, or -ve error number (see the
+ * Return:	number of blocks erased, or -ve error number (see the
  * IS_ERR_VALUE() macro
  */
 ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
@@ -369,35 +378,40 @@ ulong disk_blk_erase(struct udevice *dev, lbaint_t start, lbaint_t blkcnt);
 #define part_get_info_ptr(x)	x
 #endif
 
-
+/**
+ * struct part_driver - partition driver
+ */
 struct part_driver {
+	/** @name:	partition name */
 	const char *name;
+	/** @part_type:	(MBR) partition type */
 	int part_type;
-	const int max_entries;	/* maximum number of entries to search */
-
+	/** @max_entries:	maximum number of partition table entries */
+	const int max_entries;
 	/**
-	 * get_info() - Get information about a partition
+	 * @get_info:		Get information about a partition
 	 *
-	 * @dev_desc:	Block device descriptor
-	 * @part:	Partition number (1 = first)
-	 * @info:	Returns partition information
+	 * @get_info.dev_desc:	Block device descriptor
+	 * @get_info.part:	Partition number (1 = first)
+	 * @get_info.info:	Returns partition information
 	 */
 	int (*get_info)(struct blk_desc *dev_desc, int part,
 			struct disk_partition *info);
 
 	/**
-	 * print() - Print partition information
+	 * @print:		Print partition information
 	 *
-	 * @dev_desc:	Block device descriptor
+	 * @print.dev_desc:	Block device descriptor
 	 */
 	void (*print)(struct blk_desc *dev_desc);
 
 	/**
-	 * test() - Test if a device contains this partition type
+	 * @test:		Test if a device contains this partition type
 	 *
-	 * @dev_desc:	Block device descriptor
-	 * @return 0 if the block device appears to contain this partition
-	 *	   type, -ve if not
+	 * @test.dev_desc:	Block device descriptor
+	 * @test.Return:
+	 * 0 if the block device appears to contain this partition type,
+	 * -ve if not
 	 */
 	int (*test)(struct blk_desc *dev_desc);
 };
@@ -413,52 +427,52 @@ struct part_driver {
 /**
  * write_gpt_table() - Write the GUID Partition Table to disk
  *
- * @param dev_desc - block device descriptor
- * @param gpt_h - pointer to GPT header representation
- * @param gpt_e - pointer to GPT partition table entries
+ * @dev_desc:	block device descriptor
+ * @gpt_h:	pointer to GPT header representation
+ * @gpt_e:	pointer to GPT partition table entries
  *
- * Return: - zero on success, otherwise error
+ * Return:	zero on success, otherwise error
  */
 int write_gpt_table(struct blk_desc *dev_desc,
 		  gpt_header *gpt_h, gpt_entry *gpt_e);
 
 /**
- * gpt_fill_pte(): Fill the GPT partition table entry
+ * gpt_fill_pte() - Fill the GPT partition table entry
  *
- * @param dev_desc - block device descriptor
- * @param gpt_h - GPT header representation
- * @param gpt_e - GPT partition table entries
- * @param partitions - list of partitions
- * @param parts - number of partitions
+ * @dev_desc:	block device descriptor
+ * @gpt_h:	GPT header representation
+ * @gpt_e:	GPT partition table entries
+ * @partitions:	list of partitions
+ * @parts:	number of partitions
  *
- * Return: zero on success
+ * Return:	zero on success
  */
 int gpt_fill_pte(struct blk_desc *dev_desc,
 		 gpt_header *gpt_h, gpt_entry *gpt_e,
 		 struct disk_partition *partitions, int parts);
 
 /**
- * gpt_fill_header(): Fill the GPT header
+ * gpt_fill_header() - Fill the GPT header
  *
- * @param dev_desc - block device descriptor
- * @param gpt_h - GPT header representation
- * @param str_guid - disk guid string representation
- * @param parts_count - number of partitions
+ * @dev_desc:		block device descriptor
+ * @gpt_h:		GPT header representation
+ * @str_guid:		disk guid string representation
+ * @parts_count:	number of partitions
  *
- * Return: - error on str_guid conversion error
+ * Return:		error on str_guid conversion error
  */
 int gpt_fill_header(struct blk_desc *dev_desc, gpt_header *gpt_h,
 		char *str_guid, int parts_count);
 
 /**
- * gpt_restore(): Restore GPT partition table
+ * gpt_restore() - Restore GPT partition table
  *
- * @param dev_desc - block device descriptor
- * @param str_disk_guid - disk GUID
- * @param partitions - list of partitions
- * @param parts - number of partitions
+ * @dev_desc:		block device descriptor
+ * @str_disk_guid:	disk GUID
+ * @partitions:		list of partitions
+ * @parts_count:	number of partitions
  *
- * Return: zero on success
+ * Return:		0 on success
  */
 int gpt_restore(struct blk_desc *dev_desc, char *str_disk_guid,
 		struct disk_partition *partitions, const int parts_count);
@@ -466,34 +480,34 @@ int gpt_restore(struct blk_desc *dev_desc, char *str_disk_guid,
 /**
  * is_valid_gpt_buf() - Ensure that the Primary GPT information is valid
  *
- * @param dev_desc - block device descriptor
- * @param buf - buffer which contains the MBR and Primary GPT info
+ * @dev_desc:	block device descriptor
+ * @buf:	buffer which contains the MBR and Primary GPT info
  *
- * Return: - '0' on success, otherwise error
+ * Return:	0 on success, otherwise error
  */
 int is_valid_gpt_buf(struct blk_desc *dev_desc, void *buf);
 
 /**
  * write_mbr_and_gpt_partitions() - write MBR, Primary GPT and Backup GPT
  *
- * @param dev_desc - block device descriptor
- * @param buf - buffer which contains the MBR and Primary GPT info
+ * @dev_desc:	block device descriptor
+ * @buf:	buffer which contains the MBR and Primary GPT info
  *
- * Return: - '0' on success, otherwise error
+ * Return:	0 on success, otherwise error
  */
 int write_mbr_and_gpt_partitions(struct blk_desc *dev_desc, void *buf);
 
 /**
- * gpt_verify_headers() - Function to read and CRC32 check of the GPT's header
+ * gpt_verify_headers() - Read and check CRC32 of the GPT's header
  *                        and partition table entries (PTE)
  *
  * As a side effect if sets gpt_head and gpt_pte so they point to GPT data.
  *
- * @param dev_desc - block device descriptor
- * @param gpt_head - pointer to GPT header data read from medium
- * @param gpt_pte - pointer to GPT partition table enties read from medium
+ * @dev_desc:	block device descriptor
+ * @gpt_head:	pointer to GPT header data read from medium
+ * @gpt_pte:	pointer to GPT partition table enties read from medium
  *
- * Return: - '0' on success, otherwise error
+ * Return:	0 on success, otherwise error
  */
 int gpt_verify_headers(struct blk_desc *dev_desc, gpt_header *gpt_head,
 		       gpt_entry **gpt_pte);
@@ -502,9 +516,9 @@ int gpt_verify_headers(struct blk_desc *dev_desc, gpt_header *gpt_head,
  * gpt_repair_headers() - Function to repair the GPT's header
  *                        and partition table entries (PTE)
  *
- * @param dev_desc - block device descriptor
+ * @dev_desc:	block device descriptor
  *
- * Return: - '0' on success, otherwise error
+ * Return:	0 on success, otherwise error
  */
 int gpt_repair_headers(struct blk_desc *dev_desc);
 
@@ -516,13 +530,13 @@ int gpt_repair_headers(struct blk_desc *dev_desc);
  * provided in '$partitions' environment variable. Specificially, name, start
  * and size of the partition is checked.
  *
- * @param dev_desc - block device descriptor
- * @param partitions - partition data read from '$partitions' env variable
- * @param parts - number of partitions read from '$partitions' env variable
- * @param gpt_head - pointer to GPT header data read from medium
- * @param gpt_pte - pointer to GPT partition table enties read from medium
+ * @dev_desc:	block device descriptor
+ * @partitions:	partition data read from '$partitions' env variable
+ * @parts:	number of partitions read from '$partitions' env variable
+ * @gpt_head:	pointer to GPT header data read from medium
+ * @gpt_pte:	pointer to GPT partition table enties read from medium
  *
- * Return: - '0' on success, otherwise error
+ * Return:	0 on success, otherwise error
  */
 int gpt_verify_partitions(struct blk_desc *dev_desc,
 			  struct disk_partition *partitions, int parts,
@@ -530,15 +544,15 @@ int gpt_verify_partitions(struct blk_desc *dev_desc,
 
 
 /**
- * get_disk_guid() - Function to read the GUID string from a device's GPT
+ * get_disk_guid() - Read the GUID string from a device's GPT
  *
  * This function reads the GUID string from a block device whose descriptor
  * is provided.
  *
- * @param dev_desc - block device descriptor
- * @param guid - pre-allocated string in which to return the GUID
+ * @dev_desc:	block device descriptor
+ * @guid:	pre-allocated string in which to return the GUID
  *
- * Return: - '0' on success, otherwise error
+ * Return:	0 on success, otherwise error
  */
 int get_disk_guid(struct blk_desc *dev_desc, char *guid);
 
@@ -548,19 +562,19 @@ int get_disk_guid(struct blk_desc *dev_desc, char *guid);
 /**
  * is_valid_dos_buf() - Ensure that a DOS MBR image is valid
  *
- * @param buf - buffer which contains the MBR
+ * @buf:	buffer which contains the MBR
  *
- * Return: - '0' on success, otherwise error
+ * Return:	0 on success, otherwise error
  */
 int is_valid_dos_buf(void *buf);
 
 /**
  * write_mbr_sector() - write DOS MBR
  *
- * @param dev_desc - block device descriptor
- * @param buf - buffer which contains the MBR
+ * @dev_desc:	block device descriptor
+ * @buf:	buffer which contains the MBR
  *
- * Return: - '0' on success, otherwise error
+ * Return:	0 on success, otherwise error
  */
 int write_mbr_sector(struct blk_desc *dev_desc, void *buf);
 
@@ -575,7 +589,7 @@ int layout_mbr_partitions(struct disk_partition *p, int count,
 /**
  * part_driver_get_count() - get partition driver count
  *
- * Return: - number of partition drivers
+ * Return:	number of partition drivers
  */
 static inline int part_driver_get_count(void)
 {
@@ -585,7 +599,7 @@ static inline int part_driver_get_count(void)
 /**
  * part_driver_get_first() - get first partition driver
  *
- * Return: - pointer to first partition driver on success, otherwise NULL
+ * Return:	pointer to first partition driver on success, otherwise NULL
  */
 static inline struct part_driver *part_driver_get_first(void)
 {
@@ -595,9 +609,9 @@ static inline struct part_driver *part_driver_get_first(void)
 /**
  * part_get_type_by_name() - Get partition type by name
  *
- * @name: Name of partition type to look up (not case-sensitive)
- * Returns: Corresponding partition type (PART_TYPE_...) or PART_TYPE_UNKNOWN if
- * not known
+ * @name:	Name of partition type to look up (not case-sensitive)
+ * Return:
+ * Corresponding partition type (PART\_TYPE\_...) or PART\_TYPE\_UNKNOWN
  */
 int part_get_type_by_name(const char *name);
 
-- 
2.40.1

