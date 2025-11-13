Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F0DCD4F28
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 06:48:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5063E83DEE;
	Thu, 13 Nov 2025 07:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="IQBhnlgp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A215F83DA7; Thu, 13 Nov 2025 07:47:35 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5875283DCA
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 07:47:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id EE2FC40A18; 
 Thu, 13 Nov 2025 06:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763016450;
 bh=lElHFntk59h4WabfODOLQ8om7PTe70Ml/u44S2euOSY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=IQBhnlgpEc1bUgiLA0B/qDUaE7yG5fxdpzZ7xxRS+JopvC4QoylvUxIvf7uSqjjg4
 2I0EXVJ3zsi562p0cN0Wp3gGdZjav+xlGslfCtWRiDwPqqrt4uvo+s3g0QKyKy5hJR
 xvncuSV5wXxA0+n+TXaQKvNm8Jkot1UmbuHUUxmSjAOcUWUT7049g/JZXoKK2rdX3K
 UQ132XmYS6oztw6hM69zUUn3kU0ZCmVoSyiMjfxcN10pycF2lpcZMuwKgY91U5uJjp
 JYW2xjE6rUQt6JIu/b9JwyOUtXEcdOArg8PtbxHQKu7QhgjeTuD9QBqRoOCQT1Kftx
 3e77RFtnCCuYupJCC/9KPi8duPaVf/wpJ63eoVYxzc2ISsP65qdUqcVmKfz44aDrvf
 Yvp7UiNn09GSRPnnbBVoy2FGQvtkOGc0oanZEzT43IoBvTpJWNcpWyYH0LtpFNx/ye
 LOQRgf3/OIl9caE6Fw5t/ejg+/rmOhNj1GQnPqGNkYjCg3DsEwV/GwlDCJo1rNt93h
 t3TjHUZV2hCJ+EzQcEGTC2h7zBnzU+aoRDXj1UeKm8d4jx2Rdt8Y2vet+oiX/RkEle
 ZOUrx+SJFzLUwPL7D1N2/NOQWDGWxib8HOT4sGrGwEmMbaCLIrsm7VOlED39sFsz/d
 +MXeA/g9QEDqEgWSOpgsqUzs=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <simon.glass@canonical.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Claude <noreply@anthropic.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 6/6] fat: Use standard types for fixed-size values
Date: Thu, 13 Nov 2025 07:46:56 +0100
Message-ID: <20251113064656.245394-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113064656.245394-1-heinrich.schuchardt@canonical.com>
References: <20251113064656.245394-1-heinrich.schuchardt@canonical.com>
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

From: Simon Glass <simon.glass@canonical.com>

Convert all __u8, __u16, and __u32 types to their u8, u16, u32
equivalents throughout the FAT filesystem code.

Co-developed-by: Claude <noreply@anthropic.com>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fat/fat.c          |  48 +++++++++----------
 fs/fat/fat_internal.h |   6 +--
 fs/fat/fat_write.c    | 104 +++++++++++++++++++++---------------------
 include/fat.h         | 102 ++++++++++++++++++++---------------------
 4 files changed, 130 insertions(+), 130 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 9e439fc5879..299ee0a8e39 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -44,7 +44,7 @@ void downcase(char *str, size_t len)
 struct blk_desc *cur_dev;
 struct disk_partition cur_part_info;
 
-int disk_read(__u32 block, __u32 nr_blocks, void *buf)
+int disk_read(u32 block, u32 nr_blocks, void *buf)
 {
 	ulong ret;
 
@@ -158,11 +158,11 @@ int flush_dirty_fat_buffer(struct fsdata *mydata)
  * Get the entry at index 'entry' in a FAT (12/16/32) table.
  * On failure 0x00 is returned.
  */
-__u32 get_fatent(struct fsdata *mydata, __u32 entry)
+u32 get_fatent(struct fsdata *mydata, u32 entry)
 {
-	__u32 bufnum;
-	__u32 offset, off8;
-	__u32 ret = 0x00;
+	u32 bufnum;
+	u32 offset, off8;
+	u32 ret = 0x00;
 
 	if (CHECK_CLUST(entry, mydata->fatsize)) {
 		log_err("Invalid FAT entry: %#08x\n", entry);
@@ -193,10 +193,10 @@ __u32 get_fatent(struct fsdata *mydata, __u32 entry)
 
 	/* Read a new block of FAT entries into the cache. */
 	if (bufnum != mydata->fatbufnum) {
-		__u32 getsize = FATBUFBLOCKS;
-		__u8 *bufptr = mydata->fatbuf;
-		__u32 fatlength = mydata->fatlength;
-		__u32 startblock = bufnum * FATBUFBLOCKS;
+		u32 getsize = FATBUFBLOCKS;
+		u8 *bufptr = mydata->fatbuf;
+		u32 fatlength = mydata->fatlength;
+		u32 startblock = bufnum * FATBUFBLOCKS;
 
 		/* Cap length if fatlength is not a multiple of FATBUFBLOCKS */
 		if (startblock + getsize > fatlength)
@@ -218,10 +218,10 @@ __u32 get_fatent(struct fsdata *mydata, __u32 entry)
 	/* Get the actual entry from the table */
 	switch (mydata->fatsize) {
 	case 32:
-		ret = FAT2CPU32(((__u32 *) mydata->fatbuf)[offset]);
+		ret = FAT2CPU32(((u32 *)mydata->fatbuf)[offset]);
 		break;
 	case 16:
-		ret = FAT2CPU16(((__u16 *) mydata->fatbuf)[offset]);
+		ret = FAT2CPU16(((u16 *)mydata->fatbuf)[offset]);
 		break;
 	case 12:
 		off8 = (offset * 3) / 2;
@@ -243,9 +243,9 @@ __u32 get_fatent(struct fsdata *mydata, __u32 entry)
  * Return 0 on success, -1 otherwise.
  */
 static int
-get_cluster(struct fsdata *mydata, __u32 clustnum, __u8 *buffer, unsigned long size)
+get_cluster(struct fsdata *mydata, u32 clustnum, u8 *buffer, unsigned long size)
 {
-	__u32 startsect;
+	u32 startsect;
 	int ret;
 
 	if (clustnum > 0) {
@@ -257,7 +257,7 @@ get_cluster(struct fsdata *mydata, __u32 clustnum, __u8 *buffer, unsigned long s
 	debug("gc - clustnum: %d, startsect: %d\n", clustnum, startsect);
 
 	if ((unsigned long)buffer & (ARCH_DMA_MINALIGN - 1)) {
-		ALLOC_CACHE_ALIGN_BUFFER(__u8, tmpbuf, mydata->sect_size);
+		ALLOC_CACHE_ALIGN_BUFFER(u8, tmpbuf, mydata->sect_size);
 
 		debug("FAT: Misaligned buffer address (%p)\n", buffer);
 
@@ -273,8 +273,8 @@ get_cluster(struct fsdata *mydata, __u32 clustnum, __u8 *buffer, unsigned long s
 			size -= mydata->sect_size;
 		}
 	} else if (size >= mydata->sect_size) {
-		__u32 bytes_read;
-		__u32 sect_count = size / mydata->sect_size;
+		u32 bytes_read;
+		u32 sect_count = size / mydata->sect_size;
 
 		ret = disk_read(startsect, sect_count, buffer);
 		if (ret != sect_count) {
@@ -287,7 +287,7 @@ get_cluster(struct fsdata *mydata, __u32 clustnum, __u8 *buffer, unsigned long s
 		size -= bytes_read;
 	}
 	if (size) {
-		ALLOC_CACHE_ALIGN_BUFFER(__u8, tmpbuf, mydata->sect_size);
+		ALLOC_CACHE_ALIGN_BUFFER(u8, tmpbuf, mydata->sect_size);
 
 		ret = disk_read(startsect, 1, tmpbuf);
 		if (ret != 1) {
@@ -317,12 +317,12 @@ get_cluster(struct fsdata *mydata, __u32 clustnum, __u8 *buffer, unsigned long s
  * Return:	-1 on error, otherwise 0
  */
 static int get_contents(struct fsdata *mydata, struct dir_entry *dentptr, loff_t pos,
-			__u8 *buffer, loff_t maxsize, loff_t *gotsize)
+			u8 *buffer, loff_t maxsize, loff_t *gotsize)
 {
 	loff_t filesize = FAT2CPU32(dentptr->size);
 	unsigned int bytesperclust = mydata->clust_size * mydata->sect_size;
-	__u32 curclust = START(dentptr);
-	__u32 endclust, newclust;
+	u32 curclust = START(dentptr);
+	u32 endclust, newclust;
 	loff_t actsize;
 
 	*gotsize = 0;
@@ -358,7 +358,7 @@ static int get_contents(struct fsdata *mydata, struct dir_entry *dentptr, loff_t
 
 	/* align to beginning of next cluster if any */
 	if (pos) {
-		__u8 *tmp_buffer;
+		u8 *tmp_buffer;
 
 		actsize = min(filesize, (loff_t)bytesperclust);
 		tmp_buffer = malloc_cache_aligned(actsize);
@@ -467,12 +467,12 @@ static int slot2str(struct dir_slot *slotptr, char *l_name, int *idx)
 }
 
 /* Calculate short name checksum */
-__u8 mkcksum(struct nameext *nameext)
+u8 mkcksum(struct nameext *nameext)
 {
 	int i;
 	u8 *pos = (void *)nameext;
 
-	__u8 ret = 0;
+	u8 ret = 0;
 
 	for (i = 0; i < 11; i++)
 		ret = (((ret & 1) << 7) | ((ret & 0xfe) >> 1)) + pos[i];
@@ -553,7 +553,7 @@ static int is_bootsector_valid(const struct boot_sector *bs)
 static int
 read_bootsectandvi(struct boot_sector *bs, struct volume_info *volinfo, int *fatsize)
 {
-	__u8 *block;
+	u8 *block;
 	struct volume_info *vistart;
 	int ret = 0;
 
diff --git a/fs/fat/fat_internal.h b/fs/fat/fat_internal.h
index cefe28c8d00..7063db62a32 100644
--- a/fs/fat/fat_internal.h
+++ b/fs/fat/fat_internal.h
@@ -104,7 +104,7 @@ struct dir_entry *next_dent(struct fat_itr *itr);
  * @buf: buffer to read data into
  * Return: number of blocks read, -1 on error
  */
-int disk_read(__u32 block, __u32 nr_blocks, void *buf);
+int disk_read(u32 block, u32 nr_blocks, void *buf);
 
 /**
  * flush_dirty_fat_buffer() - write fat buffer to disk if dirty
@@ -121,14 +121,14 @@ int flush_dirty_fat_buffer(struct fsdata *mydata);
  * @entry: FAT entry index
  * Return: FAT entry value, 0x00 on failure
  */
-__u32 get_fatent(struct fsdata *mydata, __u32 entry);
+u32 get_fatent(struct fsdata *mydata, u32 entry);
 
 /**
  * mkcksum() - calculate short name checksum
  * @nameext: name and extension structure
  * Return: checksum value
  */
-__u8 mkcksum(struct nameext *nameext);
+u8 mkcksum(struct nameext *nameext);
 
 /**
  * fat_itr_root() - initialize an iterator to start at the root directory
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index f2aa3402adb..fdb837bfdae 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -194,7 +194,7 @@ out:
 }
 
 static int total_sector;
-static int disk_write(__u32 block, __u32 nr_blocks, void *buf)
+static int disk_write(u32 block, u32 nr_blocks, void *buf)
 {
 	ulong ret;
 
@@ -220,9 +220,9 @@ static int disk_write(__u32 block, __u32 nr_blocks, void *buf)
 int flush_dirty_fat_buffer(struct fsdata *mydata)
 {
 	int getsize = FATBUFBLOCKS;
-	__u32 fatlength = mydata->fatlength;
-	__u8 *bufptr = mydata->fatbuf;
-	__u32 startblock = mydata->fatbufnum * FATBUFBLOCKS;
+	u32 fatlength = mydata->fatlength;
+	u8 *bufptr = mydata->fatbuf;
+	u32 startblock = mydata->fatbufnum * FATBUFBLOCKS;
 
 	debug("debug: evicting %d, dirty: %d\n", mydata->fatbufnum,
 	      (int)mydata->fat_dirty);
@@ -397,9 +397,9 @@ static int flush_dir(struct fat_itr *itr);
 static int
 fill_dir_slot(struct fat_itr *itr, const char *l_name, const char *shortname)
 {
-	__u8 temp_dir_slot_buffer[MAX_LFN_SLOT * sizeof(struct dir_slot)];
+	u8 temp_dir_slot_buffer[MAX_LFN_SLOT * sizeof(struct dir_slot)];
 	struct dir_slot *slotptr = (struct dir_slot *)temp_dir_slot_buffer;
-	__u8 counter = 0, checksum;
+	u8 counter = 0, checksum;
 	int idx = 0, ret;
 
 	/* Get short file name checksum value */
@@ -440,10 +440,10 @@ fill_dir_slot(struct fat_itr *itr, const char *l_name, const char *shortname)
 /*
  * Set the entry at index 'entry' in a FAT (12/16/32) table.
  */
-static int set_fatent_value(struct fsdata *mydata, __u32 entry, __u32 entry_value)
+static int set_fatent_value(struct fsdata *mydata, u32 entry, u32 entry_value)
 {
-	__u32 bufnum, offset, off16;
-	__u16 val1, val2;
+	u32 bufnum, offset, off16;
+	u16 val1, val2;
 
 	switch (mydata->fatsize) {
 	case 32:
@@ -466,9 +466,9 @@ static int set_fatent_value(struct fsdata *mydata, __u32 entry, __u32 entry_valu
 	/* Read a new block of FAT entries into the cache. */
 	if (bufnum != mydata->fatbufnum) {
 		int getsize = FATBUFBLOCKS;
-		__u8 *bufptr = mydata->fatbuf;
-		__u32 fatlength = mydata->fatlength;
-		__u32 startblock = bufnum * FATBUFBLOCKS;
+		u8 *bufptr = mydata->fatbuf;
+		u32 fatlength = mydata->fatlength;
+		u32 startblock = bufnum * FATBUFBLOCKS;
 
 		/* Cap length if fatlength is not a multiple of FATBUFBLOCKS */
 		if (startblock + getsize > fatlength)
@@ -492,10 +492,10 @@ static int set_fatent_value(struct fsdata *mydata, __u32 entry, __u32 entry_valu
 	/* Set the actual entry */
 	switch (mydata->fatsize) {
 	case 32:
-		((__u32 *) mydata->fatbuf)[offset] = cpu_to_le32(entry_value);
+		((u32 *)mydata->fatbuf)[offset] = cpu_to_le32(entry_value);
 		break;
 	case 16:
-		((__u16 *) mydata->fatbuf)[offset] = cpu_to_le16(entry_value);
+		((u16 *)mydata->fatbuf)[offset] = cpu_to_le16(entry_value);
 		break;
 	case 12:
 		off16 = (offset * 3) / 4;
@@ -503,33 +503,33 @@ static int set_fatent_value(struct fsdata *mydata, __u32 entry, __u32 entry_valu
 		switch (offset & 0x3) {
 		case 0:
 			val1 = cpu_to_le16(entry_value) & 0xfff;
-			((__u16 *)mydata->fatbuf)[off16] &= ~0xfff;
-			((__u16 *)mydata->fatbuf)[off16] |= val1;
+			((u16 *)mydata->fatbuf)[off16] &= ~0xfff;
+			((u16 *)mydata->fatbuf)[off16] |= val1;
 			break;
 		case 1:
 			val1 = cpu_to_le16(entry_value) & 0xf;
 			val2 = (cpu_to_le16(entry_value) >> 4) & 0xff;
 
-			((__u16 *)mydata->fatbuf)[off16] &= ~0xf000;
-			((__u16 *)mydata->fatbuf)[off16] |= (val1 << 12);
+			((u16 *)mydata->fatbuf)[off16] &= ~0xf000;
+			((u16 *)mydata->fatbuf)[off16] |= (val1 << 12);
 
-			((__u16 *)mydata->fatbuf)[off16 + 1] &= ~0xff;
-			((__u16 *)mydata->fatbuf)[off16 + 1] |= val2;
+			((u16 *)mydata->fatbuf)[off16 + 1] &= ~0xff;
+			((u16 *)mydata->fatbuf)[off16 + 1] |= val2;
 			break;
 		case 2:
 			val1 = cpu_to_le16(entry_value) & 0xff;
 			val2 = (cpu_to_le16(entry_value) >> 8) & 0xf;
 
-			((__u16 *)mydata->fatbuf)[off16] &= ~0xff00;
-			((__u16 *)mydata->fatbuf)[off16] |= (val1 << 8);
+			((u16 *)mydata->fatbuf)[off16] &= ~0xff00;
+			((u16 *)mydata->fatbuf)[off16] |= (val1 << 8);
 
-			((__u16 *)mydata->fatbuf)[off16 + 1] &= ~0xf;
-			((__u16 *)mydata->fatbuf)[off16 + 1] |= val2;
+			((u16 *)mydata->fatbuf)[off16 + 1] &= ~0xf;
+			((u16 *)mydata->fatbuf)[off16 + 1] |= val2;
 			break;
 		case 3:
 			val1 = cpu_to_le16(entry_value) & 0xfff;
-			((__u16 *)mydata->fatbuf)[off16] &= ~0xfff0;
-			((__u16 *)mydata->fatbuf)[off16] |= (val1 << 4);
+			((u16 *)mydata->fatbuf)[off16] &= ~0xfff0;
+			((u16 *)mydata->fatbuf)[off16] |= (val1 << 4);
 			break;
 		default:
 			break;
@@ -547,9 +547,9 @@ static int set_fatent_value(struct fsdata *mydata, __u32 entry, __u32 entry_valu
  * Determine the next free cluster after 'entry' in a FAT (12/16/32) table
  * and link it to 'entry'. EOC marker is not set on returned entry.
  */
-static __u32 determine_fatent(struct fsdata *mydata, __u32 entry)
+static u32 determine_fatent(struct fsdata *mydata, u32 entry)
 {
-	__u32 next_fat, next_entry = entry + 1;
+	u32 next_fat, next_entry = entry + 1;
 
 	while (1) {
 		next_fat = get_fatent(mydata, next_entry);
@@ -585,7 +585,7 @@ set_sectors(struct fsdata *mydata, u32 startsect, u8 *buffer, u32 size)
 	debug("startsect: %d\n", startsect);
 
 	if ((unsigned long)buffer & (ARCH_DMA_MINALIGN - 1)) {
-		ALLOC_CACHE_ALIGN_BUFFER(__u8, tmpbuf, mydata->sect_size);
+		ALLOC_CACHE_ALIGN_BUFFER(u8, tmpbuf, mydata->sect_size);
 
 		debug("FAT: Misaligned buffer address (%p)\n", buffer);
 
@@ -616,7 +616,7 @@ set_sectors(struct fsdata *mydata, u32 startsect, u8 *buffer, u32 size)
 	}
 
 	if (size) {
-		ALLOC_CACHE_ALIGN_BUFFER(__u8, tmpbuf, mydata->sect_size);
+		ALLOC_CACHE_ALIGN_BUFFER(u8, tmpbuf, mydata->sect_size);
 		/* Do not leak content of stack */
 		memset(tmpbuf, 0, mydata->sect_size);
 		memcpy(tmpbuf, buffer, size);
@@ -686,12 +686,12 @@ out:
  * Read and modify data on existing and consecutive cluster blocks
  */
 static int
-get_set_cluster(struct fsdata *mydata, __u32 clustnum, loff_t pos, __u8 *buffer,
+get_set_cluster(struct fsdata *mydata, u32 clustnum, loff_t pos, u8 *buffer,
 		loff_t size, loff_t *gotsize)
 {
 	static u8 *tmpbuf_cluster;
 	unsigned int bytesperclust = mydata->clust_size * mydata->sect_size;
-	__u32 startsect;
+	u32 startsect;
 	loff_t clustcount, wsize;
 	int i, ret;
 
@@ -806,7 +806,7 @@ get_set_cluster(struct fsdata *mydata, __u32 clustnum, loff_t pos, __u8 *buffer,
  */
 static int find_empty_cluster(struct fsdata *mydata)
 {
-	__u32 fat_val, entry = 3;
+	u32 fat_val, entry = 3;
 
 	while (1) {
 		fat_val = get_fatent(mydata, entry);
@@ -864,9 +864,9 @@ static int new_dir_table(struct fat_itr *itr)
 /*
  * Set empty cluster from 'entry' to the end of a file
  */
-static int clear_fatent(struct fsdata *mydata, __u32 entry)
+static int clear_fatent(struct fsdata *mydata, u32 entry)
 {
-	__u32 fat_val;
+	u32 fat_val;
 
 	while (!CHECK_CLUST(entry, mydata->fatsize)) {
 		fat_val = get_fatent(mydata, entry);
@@ -889,7 +889,7 @@ static int clear_fatent(struct fsdata *mydata, __u32 entry)
  * Set start cluster in directory entry
  */
 static void set_start_cluster(const struct fsdata *mydata, struct dir_entry *dentptr,
-			      __u32 start_cluster)
+			      u32 start_cluster)
 {
 	if (mydata->fatsize == 32)
 		dentptr->starthi =
@@ -902,9 +902,9 @@ static void set_start_cluster(const struct fsdata *mydata, struct dir_entry *den
  * exceed the size of the block device
  * Return -1 when overflow occurs, otherwise return 0
  */
-static int check_overflow(struct fsdata *mydata, __u32 clustnum, loff_t size)
+static int check_overflow(struct fsdata *mydata, u32 clustnum, loff_t size)
 {
-	__u32 startsect, sect_num, offset;
+	u32 startsect, sect_num, offset;
 
 	if (clustnum > 0)
 		startsect = clust_to_sect(mydata, clustnum);
@@ -928,12 +928,12 @@ static int check_overflow(struct fsdata *mydata, __u32 clustnum, loff_t size)
  * or return -1 on fatal errors.
  */
 static int
-set_contents(struct fsdata *mydata, struct dir_entry *dentptr, loff_t pos, __u8 *buffer,
+set_contents(struct fsdata *mydata, struct dir_entry *dentptr, loff_t pos, u8 *buffer,
 	     loff_t maxsize, loff_t *gotsize)
 {
 	unsigned int bytesperclust = mydata->clust_size * mydata->sect_size;
-	__u32 curclust = START(dentptr);
-	__u32 endclust = 0, newclust = 0;
+	u32 curclust = START(dentptr);
+	u32 endclust = 0, newclust = 0;
 	u64 cur_pos, filesize;
 	loff_t offset, actsize, wsize;
 
@@ -1199,8 +1199,8 @@ err:
  * @attr:		file attributes
  */
 static void fill_dentry(struct fsdata *mydata, struct dir_entry *dentptr,
-			const char *shortname, __u32 start_cluster, __u32 size,
-			__u8 attr)
+			const char *shortname, u32 start_cluster, u32 size,
+			u8 attr)
 {
 	memset(dentptr, 0, sizeof(*dentptr));
 
@@ -1253,7 +1253,7 @@ static int update_parent_dir_props(struct fat_itr *dir_itr)
 
 	struct fat_itr itr;
 	struct fsdata fsdata = { .fatbuf = NULL, }, *mydata = &fsdata;
-	__u32 target_clust = dir_itr->start_clust;
+	u32 target_clust = dir_itr->start_clust;
 
 	/* Short circuit if no RTC because it only updates timestamps */
 	if (!CONFIG_IS_ENABLED(DM_RTC))
@@ -1309,8 +1309,8 @@ exit:
  * @attr:	file attributes
  * Return:	0 for success
  */
-static int create_link(struct fat_itr *itr, char *basename, __u32 clust, __u32 size,
-		       __u8 attr)
+static int create_link(struct fat_itr *itr, char *basename, u32 clust, u32 size,
+		       u8 attr)
 {
 	char shortname[SHORT_NAME_SIZE];
 	int ndent;
@@ -1878,7 +1878,7 @@ int fat_mkdir(const char *dirname)
 	else
 		set_start_cluster(mydata, &dotdent[1], itr->start_clust);
 
-	ret = set_contents(mydata, retdent, 0, (__u8 *)dotdent,
+	ret = set_contents(mydata, retdent, 0, (u8 *)dotdent,
 			   bytesperclust, &actwrite);
 	if (ret < 0) {
 		printf("Error: writing contents\n");
@@ -1886,7 +1886,7 @@ int fat_mkdir(const char *dirname)
 	}
 	/* Write twice for "." */
 	set_start_cluster(mydata, &dotdent[0], START(retdent));
-	ret = set_contents(mydata, retdent, 0, (__u8 *)dotdent,
+	ret = set_contents(mydata, retdent, 0, (u8 *)dotdent,
 			   bytesperclust, &actwrite);
 	if (ret < 0) {
 		printf("Error: writing contents\n");
@@ -1997,10 +1997,10 @@ int fat_rename(const char *old_path, const char *new_path)
 	char *old_path_copy, *old_dirname, *old_basename;
 	char *new_path_copy, *new_dirname, *new_basename;
 	char l_new_basename[VFAT_MAXLEN_BYTES];
-	__u32 old_clust;
+	u32 old_clust;
 	struct dir_entry *found_existing;
 	/* only set if found_existing != NULL */
-	__u32 new_clust;
+	u32 new_clust;
 
 	old_path_copy = strdup(old_path);
 	new_path_copy = strdup(new_path);
@@ -2094,7 +2094,7 @@ int fat_rename(const char *old_path, const char *new_path)
 	/* create/update dentry to point to old_path's data cluster */
 	if (found_existing) {
 		struct nameext new_name = new_itr->dent->nameext;
-		__u8 lcase = new_itr->dent->lcase;
+		u8 lcase = new_itr->dent->lcase;
 
 		if (is_old_dir) {
 			int n_entries = fat_dir_entries(new_itr);
@@ -2144,7 +2144,7 @@ int fat_rename(const char *old_path, const char *new_path)
 
 	/* update moved directory so the parent is new_path */
 	if (is_old_dir) {
-		__u32 clust = new_itr->start_clust;
+		u32 clust = new_itr->start_clust;
 		struct dir_entry *dent;
 
 		fat_itr_child(new_itr, new_itr);
diff --git a/include/fat.h b/include/fat.h
index f6b31b2de49..2e63160c924 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -108,29 +108,29 @@ struct disk_partition;
  * @reserved2: unused (FAT32 only)
  */
 struct boot_sector {
-	__u8	ignored[3];
+	u8	ignored[3];
 	char	system_id[8];
-	__u8	sector_size[2];
-	__u8	cluster_size;
-	__u16	reserved;
-	__u8	fats;
-	__u8	dir_entries[2];
-	__u8	sectors[2];
-	__u8	media;
-	__u16	fat_length;
-	__u16	secs_track;
-	__u16	heads;
-	__u32	hidden;
-	__u32	total_sect;
+	u8	sector_size[2];
+	u8	cluster_size;
+	u16	reserved;
+	u8	fats;
+	u8	dir_entries[2];
+	u8	sectors[2];
+	u8	media;
+	u16	fat_length;
+	u16	secs_track;
+	u16	heads;
+	u32	hidden;
+	u32	total_sect;
 
 	/* FAT32 only */
-	__u32	fat32_length;
-	__u16	flags;
-	__u8	version[2];
-	__u32	root_cluster;
-	__u16	info_sector;
-	__u16	backup_boot;
-	__u16	reserved2[6];
+	u32	fat32_length;
+	u16	flags;
+	u8	version[2];
+	u32	root_cluster;
+	u16	info_sector;
+	u16	backup_boot;
+	u16	reserved2[6];
 };
 
 /**
@@ -146,10 +146,10 @@ struct boot_sector {
  * Boot code follows this structure, with boot signature at the end of sector.
  */
 struct volume_info {
-	__u8 drive_number;
-	__u8 reserved;
-	__u8 ext_boot_sign;
-	__u8 volume_id[4];
+	u8 drive_number;
+	u8 reserved;
+	u8 ext_boot_sign;
+	u8 volume_id[4];
 	char volume_label[11];
 	char fs_type[8];
 };
@@ -185,17 +185,17 @@ struct nameext {
  */
 struct dir_entry {
 	struct nameext nameext;
-	__u8	attr;
-	__u8	lcase;
-	__u8	ctime_ms;
-	__u16	ctime;
-	__u16	cdate;
-	__u16	adate;
-	__u16	starthi;
-	__u16	time;
-	__u16	date;
-	__u16	start;
-	__u32	size;
+	u8	attr;
+	u8	lcase;
+	u8	ctime_ms;
+	u16	ctime;
+	u16	cdate;
+	u16	adate;
+	u16	starthi;
+	u16	time;
+	u16	date;
+	u16	start;
+	u32	size;
 };
 
 /**
@@ -213,14 +213,14 @@ struct dir_entry {
  * Multiple entries may be used to store names longer than 13 characters.
  */
 struct dir_slot {
-	__u8	id;
-	__u8	name0_4[10];
-	__u8	attr;
-	__u8	reserved;
-	__u8	alias_checksum;
-	__u8	name5_10[12];
-	__u16	start;
-	__u8	name11_12[4];
+	u8	id;
+	u8	name0_4[10];
+	u8	attr;
+	u8	reserved;
+	u8	alias_checksum;
+	u8	name5_10[12];
+	u16	start;
+	u8	name11_12[4];
 };
 
 /**
@@ -244,18 +244,18 @@ struct dir_slot {
  * The fatbuf must be 32-bit aligned due to FAT32 sector access requirements.
  */
 struct fsdata {
-	__u8	*fatbuf;
+	u8	*fatbuf;
 	int	fatsize;
-	__u32	fatlength;
-	__u16	fat_sect;
-	__u8	fat_dirty;
-	__u32	rootdir_sect;
-	__u16	sect_size;
-	__u16	clust_size;
+	u32	fatlength;
+	u16	fat_sect;
+	u8	fat_dirty;
+	u32	rootdir_sect;
+	u16	sect_size;
+	u16	clust_size;
 	int	data_begin;
 	int	fatbufnum;
 	int	rootdir_size;
-	__u32	root_cluster;
+	u32	root_cluster;
 	u32	total_sect;
 	int	fats;
 };
-- 
2.51.0

