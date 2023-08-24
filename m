Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BF2C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 19:57:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF3EB869A0;
	Thu, 24 Aug 2023 21:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Q0AHiZMA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82CBC8698F; Thu, 24 Aug 2023 21:56:09 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA6028693C
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7927182dfe3so7912039f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692906963; x=1693511763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iITq00gyZgyvK9+0usZuOMlfeluXF0Its76jK9x78zs=;
 b=Q0AHiZMAA1RYjxADAdCBRxYrBqNDk8W1MTOMnfYCWxJ8nAaAlHS2YXs5NaXQZaReKR
 eBOY5eCCiXIKy0ET02tzp3VY/D3qjPKd6MyPoMX5TKG8I6kf5pa9oGjlyGif4vu9NzcJ
 fJCLVU7M5d2m5TjlXeJStEOyXD98Y2a8xqud8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692906963; x=1693511763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iITq00gyZgyvK9+0usZuOMlfeluXF0Its76jK9x78zs=;
 b=HsVAkTLq5EYwIRCiBIx6m88oUPTIqhltSDZ68lAYi7HvmgjPVLo4mgaK0SsGIJyj3M
 bsjFF639CPWWRQ5JdvWC7saVVx7ve03eEKxT7GMNrmCNpIHMh7mKETTkEOUQwo5Nw4tq
 8eXTRw6H11ybc6cpKPgOYYa0UJwsYU+EmmIHtixLW/PB87sotogzRyuZ/EVnY+KO3nEC
 o6ordOtT1PIXMBLHVSrt/rkSP8kbhSzhCo+Q7Q+G3XvKqiwA7lhfLwWPjpjG93iYvxWA
 KHHcrp2yRyhcldO7U3E2NctdTS/9kjMHnxaui1jwSPVs3bx5SgGnaqEuofE3g4/2DdWB
 3qUQ==
X-Gm-Message-State: AOJu0YwMeVHTT9WqUuLiT3FLQxp2sJTp8zD1MoDtNCHBue7hi9ml6R9a
 Mu60KEb5sJu2srKryAzpofid+B70TQj6LPfAirs=
X-Google-Smtp-Source: AGHT+IGXO6pyusrqB5Q2rv+uDagYInAI5S2RZx45+f6dZlfzA601bC6cHFzUGA6zNAqBSIFAno+IJQ==
X-Received: by 2002:a5e:c70a:0:b0:791:3172:711c with SMTP id
 f10-20020a5ec70a000000b007913172711cmr6552230iop.21.1692906963222; 
 Thu, 24 Aug 2023 12:56:03 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b22-20020a6be716000000b007925328d6ddsm12734ioh.20.2023.08.24.12.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:56:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 04/23] part: efi: Use desc instead of dev_desc
Date: Thu, 24 Aug 2023 13:55:27 -0600
Message-ID: <20230824195553.1685996-5-sjg@chromium.org>
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
is now a different thing, with driver model. Update the efi code to
just use 'desc'.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 disk/part_efi.c | 228 ++++++++++++++++++++++++------------------------
 1 file changed, 112 insertions(+), 116 deletions(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index 80a44dc9f072..4ac21868d088 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -51,12 +51,12 @@ static inline u32 efi_crc32(const void *buf, u32 len)
 
 static int pmbr_part_valid(struct partition *part);
 static int is_pmbr_valid(legacy_mbr * mbr);
-static int is_gpt_valid(struct blk_desc *dev_desc, u64 lba,
-				gpt_header *pgpt_head, gpt_entry **pgpt_pte);
-static gpt_entry *alloc_read_gpt_entries(struct blk_desc *dev_desc,
+static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
+			gpt_entry **pgpt_pte);
+static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
 					 gpt_header *pgpt_head);
 static int is_pte_valid(gpt_entry * pte);
-static int find_valid_gpt(struct blk_desc *dev_desc, gpt_header *gpt_head,
+static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
 			  gpt_entry **pgpt_pte);
 
 static char *print_efiname(gpt_entry *pte)
@@ -195,14 +195,14 @@ static void prepare_backup_gpt_header(gpt_header *gpt_h)
  * UUID is displayed as 32 hexadecimal digits, in 5 groups,
  * separated by hyphens, in the form 8-4-4-4-12 for a total of 36 characters
  */
-int get_disk_guid(struct blk_desc * dev_desc, char *guid)
+int get_disk_guid(struct blk_desc *desc, char *guid)
 {
-	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, dev_desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
 	gpt_entry *gpt_pte = NULL;
 	unsigned char *guid_bin;
 
 	/* This function validates AND fills in the GPT header and PTE */
-	if (find_valid_gpt(dev_desc, gpt_head, &gpt_pte) != 1)
+	if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
 		return -EINVAL;
 
 	guid_bin = gpt_head->disk_guid.b;
@@ -213,15 +213,15 @@ int get_disk_guid(struct blk_desc * dev_desc, char *guid)
 	return 0;
 }
 
-void part_print_efi(struct blk_desc *dev_desc)
+void part_print_efi(struct blk_desc *desc)
 {
-	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, dev_desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
 	gpt_entry *gpt_pte = NULL;
 	int i = 0;
 	unsigned char *uuid;
 
 	/* This function validates AND fills in the GPT header and PTE */
-	if (find_valid_gpt(dev_desc, gpt_head, &gpt_pte) != 1)
+	if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
 		return;
 
 	debug("%s: gpt-entry at %p\n", __func__, gpt_pte);
@@ -255,10 +255,10 @@ void part_print_efi(struct blk_desc *dev_desc)
 	return;
 }
 
-int part_get_info_efi(struct blk_desc *dev_desc, int part,
+int part_get_info_efi(struct blk_desc *desc, int part,
 		      struct disk_partition *info)
 {
-	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, dev_desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
 	gpt_entry *gpt_pte = NULL;
 
 	/* "part" argument must be at least 1 */
@@ -268,7 +268,7 @@ int part_get_info_efi(struct blk_desc *dev_desc, int part,
 	}
 
 	/* This function validates AND fills in the GPT header and PTE */
-	if (find_valid_gpt(dev_desc, gpt_head, &gpt_pte) != 1)
+	if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
 		return -EINVAL;
 
 	if (part > le32_to_cpu(gpt_head->num_partition_entries) ||
@@ -283,7 +283,7 @@ int part_get_info_efi(struct blk_desc *dev_desc, int part,
 	/* The ending LBA is inclusive, to calculate size, add 1 to it */
 	info->size = (lbaint_t)le64_to_cpu(gpt_pte[part - 1].ending_lba) + 1
 		     - info->start;
-	info->blksz = dev_desc->blksz;
+	info->blksz = desc->blksz;
 
 	snprintf((char *)info->name, sizeof(info->name), "%s",
 		 print_efiname(&gpt_pte[part - 1]));
@@ -306,12 +306,12 @@ int part_get_info_efi(struct blk_desc *dev_desc, int part,
 	return 0;
 }
 
-static int part_test_efi(struct blk_desc *dev_desc)
+static int part_test_efi(struct blk_desc *desc)
 {
-	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, legacymbr, 1, dev_desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, legacymbr, 1, desc->blksz);
 
 	/* Read legacy MBR from block 0 and validate it */
-	if ((blk_dread(dev_desc, 0, 1, (ulong *)legacymbr) != 1)
+	if ((blk_dread(desc, 0, 1, (ulong *)legacymbr) != 1)
 		|| (is_pmbr_valid(legacymbr) != 1)) {
 		return -1;
 	}
@@ -320,23 +320,23 @@ static int part_test_efi(struct blk_desc *dev_desc)
 
 /**
  * set_protective_mbr(): Set the EFI protective MBR
- * @param dev_desc - block device descriptor
+ * @param desc - block device descriptor
  *
  * Return: - zero on success, otherwise error
  */
-static int set_protective_mbr(struct blk_desc *dev_desc)
+static int set_protective_mbr(struct blk_desc *desc)
 {
 	/* Setup the Protective MBR */
-	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, p_mbr, 1, dev_desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, p_mbr, 1, desc->blksz);
 	if (p_mbr == NULL) {
 		log_debug("calloc failed!\n");
 		return -ENOMEM;
 	}
 
 	/* Read MBR to backup boot code if it exists */
-	if (blk_dread(dev_desc, 0, 1, p_mbr) != 1) {
+	if (blk_dread(desc, 0, 1, p_mbr) != 1) {
 		log_debug("** Can't read from device %d **\n",
-			  dev_desc->devnum);
+			  desc->devnum);
 		return -EIO;
 	}
 
@@ -348,27 +348,26 @@ static int set_protective_mbr(struct blk_desc *dev_desc)
 	p_mbr->signature = MSDOS_MBR_SIGNATURE;
 	p_mbr->partition_record[0].sys_ind = EFI_PMBR_OSTYPE_EFI_GPT;
 	p_mbr->partition_record[0].start_sect = 1;
-	p_mbr->partition_record[0].nr_sects = (u32) dev_desc->lba - 1;
+	p_mbr->partition_record[0].nr_sects = (u32)desc->lba - 1;
 
 	/* Write MBR sector to the MMC device */
-	if (blk_dwrite(dev_desc, 0, 1, p_mbr) != 1) {
-		log_debug("** Can't write to device %d **\n", dev_desc->devnum);
+	if (blk_dwrite(desc, 0, 1, p_mbr) != 1) {
+		log_debug("** Can't write to device %d **\n", desc->devnum);
 		return -EIO;
 	}
 
 	return 0;
 }
 
-int write_gpt_table(struct blk_desc *dev_desc,
-		gpt_header *gpt_h, gpt_entry *gpt_e)
+int write_gpt_table(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry *gpt_e)
 {
 	const int pte_blk_cnt = BLOCK_CNT((gpt_h->num_partition_entries
-					   * sizeof(gpt_entry)), dev_desc);
+					   * sizeof(gpt_entry)), desc);
 	u32 calc_crc32;
 
-	debug("max lba: %x\n", (u32) dev_desc->lba);
+	debug("max lba: %x\n", (u32)desc->lba);
 	/* Setup the Protective MBR */
-	if (set_protective_mbr(dev_desc) < 0)
+	if (set_protective_mbr(desc) < 0)
 		goto err;
 
 	/* Generate CRC for the Primary GPT Header */
@@ -382,20 +381,20 @@ int write_gpt_table(struct blk_desc *dev_desc,
 	gpt_h->header_crc32 = cpu_to_le32(calc_crc32);
 
 	/* Write the First GPT to the block right after the Legacy MBR */
-	if (blk_dwrite(dev_desc, 1, 1, gpt_h) != 1)
+	if (blk_dwrite(desc, 1, 1, gpt_h) != 1)
 		goto err;
 
-	if (blk_dwrite(dev_desc, le64_to_cpu(gpt_h->partition_entry_lba),
+	if (blk_dwrite(desc, le64_to_cpu(gpt_h->partition_entry_lba),
 		       pte_blk_cnt, gpt_e) != pte_blk_cnt)
 		goto err;
 
 	prepare_backup_gpt_header(gpt_h);
 
-	if (blk_dwrite(dev_desc, (lbaint_t)le64_to_cpu(gpt_h->last_usable_lba)
+	if (blk_dwrite(desc, (lbaint_t)le64_to_cpu(gpt_h->last_usable_lba)
 		       + 1, pte_blk_cnt, gpt_e) != pte_blk_cnt)
 		goto err;
 
-	if (blk_dwrite(dev_desc, (lbaint_t)le64_to_cpu(gpt_h->my_lba), 1,
+	if (blk_dwrite(desc, (lbaint_t)le64_to_cpu(gpt_h->my_lba), 1,
 		       gpt_h) != 1)
 		goto err;
 
@@ -403,11 +402,11 @@ int write_gpt_table(struct blk_desc *dev_desc,
 	return 0;
 
  err:
-	log_debug("** Can't write to device %d **\n", dev_desc->devnum);
+	log_debug("** Can't write to device %d **\n", desc->devnum);
 	return -EIO;
 }
 
-int gpt_fill_pte(struct blk_desc *dev_desc,
+int gpt_fill_pte(struct blk_desc *desc,
 		 gpt_header *gpt_h, gpt_entry *gpt_e,
 		 struct disk_partition *partitions, int parts)
 {
@@ -430,7 +429,7 @@ int gpt_fill_pte(struct blk_desc *dev_desc,
 	size_t pte_start = gpt_h->partition_entry_lba;
 	size_t pte_end = pte_start +
 		gpt_h->num_partition_entries * gpt_h->sizeof_partition_entry /
-		dev_desc->blksz;
+		desc->blksz;
 
 	for (i = 0; i < parts; i++) {
 		/* partition starting lba */
@@ -527,7 +526,7 @@ int gpt_fill_pte(struct blk_desc *dev_desc,
 	return 0;
 }
 
-static uint32_t partition_entries_offset(struct blk_desc *dev_desc)
+static uint32_t partition_entries_offset(struct blk_desc *desc)
 {
 	uint32_t offset_blks = 2;
 	uint32_t __maybe_unused offset_bytes;
@@ -543,8 +542,8 @@ static uint32_t partition_entries_offset(struct blk_desc *dev_desc)
 	 * CONFIG_EFI_PARTITION_ENTRIES_OFF.
 	 */
 	offset_bytes =
-		PAD_TO_BLOCKSIZE(CONFIG_EFI_PARTITION_ENTRIES_OFF, dev_desc);
-	offset_blks = offset_bytes / dev_desc->blksz;
+		PAD_TO_BLOCKSIZE(CONFIG_EFI_PARTITION_ENTRIES_OFF, desc);
+	offset_blks = offset_bytes / desc->blksz;
 #endif
 
 #if defined(CONFIG_OF_CONTROL)
@@ -556,8 +555,8 @@ static uint32_t partition_entries_offset(struct blk_desc *dev_desc)
 	config_offset = ofnode_conf_read_int(
 		"u-boot,efi-partition-entries-offset", -EINVAL);
 	if (config_offset != -EINVAL) {
-		offset_bytes = PAD_TO_BLOCKSIZE(config_offset, dev_desc);
-		offset_blks = offset_bytes / dev_desc->blksz;
+		offset_bytes = PAD_TO_BLOCKSIZE(config_offset, desc);
+		offset_blks = offset_bytes / desc->blksz;
 	}
 #endif
 
@@ -573,17 +572,17 @@ static uint32_t partition_entries_offset(struct blk_desc *dev_desc)
 	return offset_blks;
 }
 
-int gpt_fill_header(struct blk_desc *dev_desc, gpt_header *gpt_h,
-		char *str_guid, int parts_count)
+int gpt_fill_header(struct blk_desc *desc, gpt_header *gpt_h, char *str_guid,
+		    int parts_count)
 {
 	gpt_h->signature = cpu_to_le64(GPT_HEADER_SIGNATURE_UBOOT);
 	gpt_h->revision = cpu_to_le32(GPT_HEADER_REVISION_V1);
 	gpt_h->header_size = cpu_to_le32(sizeof(gpt_header));
 	gpt_h->my_lba = cpu_to_le64(1);
-	gpt_h->alternate_lba = cpu_to_le64(dev_desc->lba - 1);
-	gpt_h->last_usable_lba = cpu_to_le64(dev_desc->lba - 34);
+	gpt_h->alternate_lba = cpu_to_le64(desc->lba - 1);
+	gpt_h->last_usable_lba = cpu_to_le64(desc->lba - 34);
 	gpt_h->partition_entry_lba =
-		cpu_to_le64(partition_entries_offset(dev_desc));
+		cpu_to_le64(partition_entries_offset(desc));
 	gpt_h->first_usable_lba =
 		cpu_to_le64(le64_to_cpu(gpt_h->partition_entry_lba) + 32);
 	gpt_h->num_partition_entries = cpu_to_le32(GPT_ENTRY_NUMBERS);
@@ -597,14 +596,14 @@ int gpt_fill_header(struct blk_desc *dev_desc, gpt_header *gpt_h,
 	return 0;
 }
 
-int gpt_restore(struct blk_desc *dev_desc, char *str_disk_guid,
+int gpt_restore(struct blk_desc *desc, char *str_disk_guid,
 		struct disk_partition *partitions, int parts_count)
 {
 	gpt_header *gpt_h;
 	gpt_entry *gpt_e;
 	int ret, size;
 
-	size = PAD_TO_BLOCKSIZE(sizeof(gpt_header), dev_desc);
+	size = PAD_TO_BLOCKSIZE(sizeof(gpt_header), desc);
 	gpt_h = malloc_cache_aligned(size);
 	if (gpt_h == NULL) {
 		log_debug("calloc failed!\n");
@@ -613,7 +612,7 @@ int gpt_restore(struct blk_desc *dev_desc, char *str_disk_guid,
 	memset(gpt_h, 0, size);
 
 	size = PAD_TO_BLOCKSIZE(GPT_ENTRY_NUMBERS * sizeof(gpt_entry),
-				dev_desc);
+				desc);
 	gpt_e = malloc_cache_aligned(size);
 	if (gpt_e == NULL) {
 		log_debug("calloc failed!\n");
@@ -623,17 +622,17 @@ int gpt_restore(struct blk_desc *dev_desc, char *str_disk_guid,
 	memset(gpt_e, 0, size);
 
 	/* Generate Primary GPT header (LBA1) */
-	ret = gpt_fill_header(dev_desc, gpt_h, str_disk_guid, parts_count);
+	ret = gpt_fill_header(desc, gpt_h, str_disk_guid, parts_count);
 	if (ret)
 		goto err;
 
 	/* Generate partition entries */
-	ret = gpt_fill_pte(dev_desc, gpt_h, gpt_e, partitions, parts_count);
+	ret = gpt_fill_pte(desc, gpt_h, gpt_e, partitions, parts_count);
 	if (ret)
 		goto err;
 
 	/* Write GPT partition table */
-	ret = write_gpt_table(dev_desc, gpt_h, gpt_e);
+	ret = write_gpt_table(desc, gpt_h, gpt_e);
 
 err:
 	free(gpt_e);
@@ -664,14 +663,14 @@ static void gpt_convert_efi_name_to_char(char *s, void *es, int n)
 	}
 }
 
-int gpt_verify_headers(struct blk_desc *dev_desc, gpt_header *gpt_head,
+int gpt_verify_headers(struct blk_desc *desc, gpt_header *gpt_head,
 		       gpt_entry **gpt_pte)
 {
 	/*
 	 * This function validates AND
 	 * fills in the GPT header and PTE
 	 */
-	if (is_gpt_valid(dev_desc,
+	if (is_gpt_valid(desc,
 			 GPT_PRIMARY_PARTITION_TABLE_LBA,
 			 gpt_head, gpt_pte) != 1) {
 		log_debug("Invalid GPT\n");
@@ -684,12 +683,12 @@ int gpt_verify_headers(struct blk_desc *dev_desc, gpt_header *gpt_head,
 	/*
 	 * Check that the alternate_lba entry points to the last LBA
 	 */
-	if (le64_to_cpu(gpt_head->alternate_lba) != (dev_desc->lba - 1)) {
+	if (le64_to_cpu(gpt_head->alternate_lba) != (desc->lba - 1)) {
 		log_debug("Misplaced Backup GPT\n");
 		return -1;
 	}
 
-	if (is_gpt_valid(dev_desc, (dev_desc->lba - 1),
+	if (is_gpt_valid(desc, (desc->lba - 1),
 			 gpt_head, gpt_pte) != 1) {
 		log_debug("Invalid Backup GPT\n");
 		return -1;
@@ -698,7 +697,7 @@ int gpt_verify_headers(struct blk_desc *dev_desc, gpt_header *gpt_head,
 	return 0;
 }
 
-static void restore_primary_gpt_header(gpt_header *gpt_h, struct blk_desc *dev_desc)
+static void restore_primary_gpt_header(gpt_header *gpt_h, struct blk_desc *desc)
 {
 	u32 calc_crc32;
 	u64 val;
@@ -707,7 +706,7 @@ static void restore_primary_gpt_header(gpt_header *gpt_h, struct blk_desc *dev_d
 	val = le64_to_cpu(gpt_h->my_lba);
 	gpt_h->my_lba = gpt_h->alternate_lba;
 	gpt_h->alternate_lba = cpu_to_le64(val);
-	gpt_h->partition_entry_lba = cpu_to_le64(partition_entries_offset(dev_desc));
+	gpt_h->partition_entry_lba = cpu_to_le64(partition_entries_offset(desc));
 
 	gpt_h->header_crc32 = 0;
 
@@ -716,22 +715,22 @@ static void restore_primary_gpt_header(gpt_header *gpt_h, struct blk_desc *dev_d
 	gpt_h->header_crc32 = cpu_to_le32(calc_crc32);
 }
 
-static int write_one_gpt_table(struct blk_desc *dev_desc,
-			       gpt_header *gpt_h, gpt_entry *gpt_e)
+static int write_one_gpt_table(struct blk_desc *desc, gpt_header *gpt_h,
+			       gpt_entry *gpt_e)
 {
 	const int pte_blk_cnt = BLOCK_CNT((gpt_h->num_partition_entries
-					   * sizeof(gpt_entry)), dev_desc);
+					   * sizeof(gpt_entry)), desc);
 	lbaint_t start;
 	int ret = 0;
 
 	start = le64_to_cpu(gpt_h->my_lba);
-	if (blk_dwrite(dev_desc, start, 1, gpt_h) != 1) {
+	if (blk_dwrite(desc, start, 1, gpt_h) != 1) {
 		ret = -1;
 		goto out;
 	}
 
 	start = le64_to_cpu(gpt_h->partition_entry_lba);
-	if (blk_dwrite(dev_desc, start, pte_blk_cnt, gpt_e) != pte_blk_cnt) {
+	if (blk_dwrite(desc, start, pte_blk_cnt, gpt_e) != pte_blk_cnt) {
 		ret = -1;
 		goto out;
 	}
@@ -740,17 +739,17 @@ static int write_one_gpt_table(struct blk_desc *dev_desc,
 	return ret;
 }
 
-int gpt_repair_headers(struct blk_desc *dev_desc)
+int gpt_repair_headers(struct blk_desc *desc)
 {
-	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_h1, 1, dev_desc->blksz);
-	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_h2, 1, dev_desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_h1, 1, desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_h2, 1, desc->blksz);
 	gpt_entry *gpt_e1 = NULL, *gpt_e2 = NULL;
 	int is_gpt1_valid, is_gpt2_valid;
 	int ret = -1;
 
-	is_gpt1_valid = is_gpt_valid(dev_desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
+	is_gpt1_valid = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA,
 				     gpt_h1, &gpt_e1);
-	is_gpt2_valid = is_gpt_valid(dev_desc, dev_desc->lba - 1,
+	is_gpt2_valid = is_gpt_valid(desc, desc->lba - 1,
 				     gpt_h2, &gpt_e2);
 
 	if (is_gpt1_valid && is_gpt2_valid) {
@@ -760,13 +759,13 @@ int gpt_repair_headers(struct blk_desc *dev_desc)
 
 	if (is_gpt1_valid && !is_gpt2_valid) {
 		prepare_backup_gpt_header(gpt_h1);
-		ret = write_one_gpt_table(dev_desc, gpt_h1, gpt_e1);
+		ret = write_one_gpt_table(desc, gpt_h1, gpt_e1);
 		goto out;
 	}
 
 	if (!is_gpt1_valid && is_gpt2_valid) {
-		restore_primary_gpt_header(gpt_h2, dev_desc);
-		ret = write_one_gpt_table(dev_desc, gpt_h2, gpt_e2);
+		restore_primary_gpt_header(gpt_h2, desc);
+		ret = write_one_gpt_table(desc, gpt_h2, gpt_e2);
 		goto out;
 	}
 
@@ -784,7 +783,7 @@ int gpt_repair_headers(struct blk_desc *dev_desc)
 	return ret;
 }
 
-int gpt_verify_partitions(struct blk_desc *dev_desc,
+int gpt_verify_partitions(struct blk_desc *desc,
 			  struct disk_partition *partitions, int parts,
 			  gpt_header *gpt_head, gpt_entry **gpt_pte)
 {
@@ -793,7 +792,7 @@ int gpt_verify_partitions(struct blk_desc *dev_desc,
 	gpt_entry *gpt_e;
 	int ret, i;
 
-	ret = gpt_verify_headers(dev_desc, gpt_head, gpt_pte);
+	ret = gpt_verify_headers(desc, gpt_head, gpt_pte);
 	if (ret)
 		return ret;
 
@@ -862,28 +861,27 @@ int gpt_verify_partitions(struct blk_desc *dev_desc,
 	return 0;
 }
 
-int is_valid_gpt_buf(struct blk_desc *dev_desc, void *buf)
+int is_valid_gpt_buf(struct blk_desc *desc, void *buf)
 {
 	gpt_header *gpt_h;
 	gpt_entry *gpt_e;
 
 	/* determine start of GPT Header in the buffer */
-	gpt_h = buf + (GPT_PRIMARY_PARTITION_TABLE_LBA *
-		       dev_desc->blksz);
+	gpt_h = buf + (GPT_PRIMARY_PARTITION_TABLE_LBA * desc->blksz);
 	if (validate_gpt_header(gpt_h, GPT_PRIMARY_PARTITION_TABLE_LBA,
-				dev_desc->lba))
+				desc->lba))
 		return -1;
 
 	/* determine start of GPT Entries in the buffer */
 	gpt_e = buf + (le64_to_cpu(gpt_h->partition_entry_lba) *
-		       dev_desc->blksz);
+		       desc->blksz);
 	if (validate_gpt_entries(gpt_h, gpt_e))
 		return -1;
 
 	return 0;
 }
 
-int write_mbr_and_gpt_partitions(struct blk_desc *dev_desc, void *buf)
+int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
 {
 	gpt_header *gpt_h;
 	gpt_entry *gpt_e;
@@ -891,24 +889,22 @@ int write_mbr_and_gpt_partitions(struct blk_desc *dev_desc, void *buf)
 	lbaint_t lba;
 	int cnt;
 
-	if (is_valid_gpt_buf(dev_desc, buf))
+	if (is_valid_gpt_buf(desc, buf))
 		return -1;
 
 	/* determine start of GPT Header in the buffer */
-	gpt_h = buf + (GPT_PRIMARY_PARTITION_TABLE_LBA *
-		       dev_desc->blksz);
+	gpt_h = buf + (GPT_PRIMARY_PARTITION_TABLE_LBA * desc->blksz);
 
 	/* determine start of GPT Entries in the buffer */
-	gpt_e = buf + (le64_to_cpu(gpt_h->partition_entry_lba) *
-		       dev_desc->blksz);
+	gpt_e = buf + (le64_to_cpu(gpt_h->partition_entry_lba) * desc->blksz);
 	gpt_e_blk_cnt = BLOCK_CNT((le32_to_cpu(gpt_h->num_partition_entries) *
 				   le32_to_cpu(gpt_h->sizeof_partition_entry)),
-				  dev_desc);
+				  desc);
 
 	/* write MBR */
 	lba = 0;	/* MBR is always at 0 */
 	cnt = 1;	/* MBR (1 block) */
-	if (blk_dwrite(dev_desc, lba, cnt, buf) != cnt) {
+	if (blk_dwrite(desc, lba, cnt, buf) != cnt) {
 		log_debug("failed writing '%s' (%d blks at 0x" LBAF ")\n",
 			  "MBR", cnt, lba);
 		return 1;
@@ -917,7 +913,7 @@ int write_mbr_and_gpt_partitions(struct blk_desc *dev_desc, void *buf)
 	/* write Primary GPT */
 	lba = GPT_PRIMARY_PARTITION_TABLE_LBA;
 	cnt = 1;	/* GPT Header (1 block) */
-	if (blk_dwrite(dev_desc, lba, cnt, gpt_h) != cnt) {
+	if (blk_dwrite(desc, lba, cnt, gpt_h) != cnt) {
 		log_debug("failed writing '%s' (%d blks at 0x" LBAF ")\n",
 			  "Primary GPT Header", cnt, lba);
 		return 1;
@@ -925,7 +921,7 @@ int write_mbr_and_gpt_partitions(struct blk_desc *dev_desc, void *buf)
 
 	lba = le64_to_cpu(gpt_h->partition_entry_lba);
 	cnt = gpt_e_blk_cnt;
-	if (blk_dwrite(dev_desc, lba, cnt, gpt_e) != cnt) {
+	if (blk_dwrite(desc, lba, cnt, gpt_e) != cnt) {
 		log_debug("failed writing '%s' (%d blks at 0x" LBAF ")\n",
 			  "Primary GPT Entries", cnt, lba);
 		return 1;
@@ -936,7 +932,7 @@ int write_mbr_and_gpt_partitions(struct blk_desc *dev_desc, void *buf)
 	/* write Backup GPT */
 	lba = le64_to_cpu(gpt_h->partition_entry_lba);
 	cnt = gpt_e_blk_cnt;
-	if (blk_dwrite(dev_desc, lba, cnt, gpt_e) != cnt) {
+	if (blk_dwrite(desc, lba, cnt, gpt_e) != cnt) {
 		log_debug("failed writing '%s' (%d blks at 0x" LBAF ")\n",
 			  "Backup GPT Entries", cnt, lba);
 		return 1;
@@ -944,14 +940,14 @@ int write_mbr_and_gpt_partitions(struct blk_desc *dev_desc, void *buf)
 
 	lba = le64_to_cpu(gpt_h->my_lba);
 	cnt = 1;	/* GPT Header (1 block) */
-	if (blk_dwrite(dev_desc, lba, cnt, gpt_h) != cnt) {
+	if (blk_dwrite(desc, lba, cnt, gpt_h) != cnt) {
 		log_debug("failed writing '%s' (%d blks at 0x" LBAF ")\n",
 			  "Backup GPT Header", cnt, lba);
 		return 1;
 	}
 
 	/* Update the partition table entries*/
-	part_init(dev_desc);
+	part_init(desc);
 
 	return 0;
 }
@@ -1008,25 +1004,25 @@ static int is_pmbr_valid(legacy_mbr * mbr)
  * Description: returns 1 if valid,  0 on error, 2 if ignored header
  * If valid, returns pointers to PTEs.
  */
-static int is_gpt_valid(struct blk_desc *dev_desc, u64 lba,
-			gpt_header *pgpt_head, gpt_entry **pgpt_pte)
+static int is_gpt_valid(struct blk_desc *desc, u64 lba, gpt_header *pgpt_head,
+			gpt_entry **pgpt_pte)
 {
 	/* Confirm valid arguments prior to allocation. */
-	if (!dev_desc || !pgpt_head) {
+	if (!desc || !pgpt_head) {
 		log_debug("Invalid Argument(s)\n");
 		return 0;
 	}
 
-	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, mbr, 1, dev_desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(legacy_mbr, mbr, 1, desc->blksz);
 
 	/* Read MBR Header from device */
-	if (blk_dread(dev_desc, 0, 1, (ulong *)mbr) != 1) {
+	if (blk_dread(desc, 0, 1, (ulong *)mbr) != 1) {
 		log_debug("Can't read MBR header\n");
 		return 0;
 	}
 
 	/* Read GPT Header from device */
-	if (blk_dread(dev_desc, (lbaint_t)lba, 1, pgpt_head) != 1) {
+	if (blk_dread(desc, (lbaint_t)lba, 1, pgpt_head) != 1) {
 		log_debug("Can't read GPT header\n");
 		return 0;
 	}
@@ -1037,23 +1033,23 @@ static int is_gpt_valid(struct blk_desc *dev_desc, u64 lba,
 		return 2;
 	}
 
-	if (validate_gpt_header(pgpt_head, (lbaint_t)lba, dev_desc->lba))
+	if (validate_gpt_header(pgpt_head, (lbaint_t)lba, desc->lba))
 		return 0;
 
-	if (dev_desc->sig_type == SIG_TYPE_NONE) {
+	if (desc->sig_type == SIG_TYPE_NONE) {
 		efi_guid_t empty = {};
 		if (memcmp(&pgpt_head->disk_guid, &empty, sizeof(empty))) {
-			dev_desc->sig_type = SIG_TYPE_GUID;
-			memcpy(&dev_desc->guid_sig, &pgpt_head->disk_guid,
-			      sizeof(empty));
+			desc->sig_type = SIG_TYPE_GUID;
+			memcpy(&desc->guid_sig, &pgpt_head->disk_guid,
+			       sizeof(empty));
 		} else if (mbr->unique_mbr_signature != 0) {
-			dev_desc->sig_type = SIG_TYPE_MBR;
-			dev_desc->mbr_sig = mbr->unique_mbr_signature;
+			desc->sig_type = SIG_TYPE_MBR;
+			desc->mbr_sig = mbr->unique_mbr_signature;
 		}
 	}
 
 	/* Read and allocate Partition Table Entries */
-	*pgpt_pte = alloc_read_gpt_entries(dev_desc, pgpt_head);
+	*pgpt_pte = alloc_read_gpt_entries(desc, pgpt_head);
 	if (!*pgpt_pte)
 		return 0;
 
@@ -1075,20 +1071,20 @@ static int is_gpt_valid(struct blk_desc *dev_desc, u64 lba,
  * Description: returns 1 if found a valid gpt,  0 on error.
  * If valid, returns pointers to PTEs.
  */
-static int find_valid_gpt(struct blk_desc *dev_desc, gpt_header *gpt_head,
+static int find_valid_gpt(struct blk_desc *desc, gpt_header *gpt_head,
 			  gpt_entry **pgpt_pte)
 {
 	int r;
 
-	r = is_gpt_valid(dev_desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_head,
+	r = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_head,
 			 pgpt_pte);
 
 	if (r != 1) {
 		if (r != 2)
 			log_debug("Invalid GPT\n");
 
-		if (is_gpt_valid(dev_desc, (dev_desc->lba - 1), gpt_head,
-				 pgpt_pte) != 1) {
+		if (is_gpt_valid(desc, desc->lba - 1, gpt_head, pgpt_pte)
+		    != 1) {
 			log_debug("Invalid Backup GPT\n");
 			return 0;
 		}
@@ -1100,21 +1096,21 @@ static int find_valid_gpt(struct blk_desc *dev_desc, gpt_header *gpt_head,
 
 /**
  * alloc_read_gpt_entries(): reads partition entries from disk
- * @dev_desc
+ * @desc
  * @gpt - GPT header
  *
  * Description: Returns ptes on success,  NULL on error.
  * Allocates space for PTEs based on information found in @gpt.
  * Notes: remember to free pte when you're done!
  */
-static gpt_entry *alloc_read_gpt_entries(struct blk_desc *dev_desc,
+static gpt_entry *alloc_read_gpt_entries(struct blk_desc *desc,
 					 gpt_header *pgpt_head)
 {
 	size_t count = 0, blk_cnt;
 	lbaint_t blk;
 	gpt_entry *pte = NULL;
 
-	if (!dev_desc || !pgpt_head) {
+	if (!desc || !pgpt_head) {
 		log_debug("Invalid Argument(s)\n");
 		return NULL;
 	}
@@ -1130,7 +1126,7 @@ static gpt_entry *alloc_read_gpt_entries(struct blk_desc *dev_desc,
 	/* Allocate memory for PTE, remember to FREE */
 	if (count != 0) {
 		pte = memalign(ARCH_DMA_MINALIGN,
-			       PAD_TO_BLOCKSIZE(count, dev_desc));
+			       PAD_TO_BLOCKSIZE(count, desc));
 	}
 
 	if (count == 0 || pte == NULL) {
@@ -1141,8 +1137,8 @@ static gpt_entry *alloc_read_gpt_entries(struct blk_desc *dev_desc,
 
 	/* Read GPT Entries from device */
 	blk = le64_to_cpu(pgpt_head->partition_entry_lba);
-	blk_cnt = BLOCK_CNT(count, dev_desc);
-	if (blk_dread(dev_desc, blk, (lbaint_t)blk_cnt, pte) != blk_cnt) {
+	blk_cnt = BLOCK_CNT(count, desc);
+	if (blk_dread(desc, blk, (lbaint_t)blk_cnt, pte) != blk_cnt) {
 		log_debug("Can't read GPT Entries\n");
 		free(pte);
 		return NULL;
-- 
2.42.0.rc1.204.g551eb34607-goog

