Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265D8CD4F28
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 06:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7525783DEA;
	Thu, 13 Nov 2025 07:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="ftP0UGoS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8A9483D77; Thu, 13 Nov 2025 07:47:30 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0BF683D7A
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 07:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 08E6740A0B; 
 Thu, 13 Nov 2025 06:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763016447;
 bh=+wpt3nibEU3zb0S+Im3JJvY15sDST2PBRHoFtQMErDQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=ftP0UGoSLGC31icmMVze1yExwm2CoPLU2xtdG6+hhLZbfkxUU9G68Yv9xM7OEBS8k
 UBU/QretgELW1OZROdN346qNQ6IDlHa7fmYFtLh5reFTcNnq3TBUfsNGiF2HSbFKSt
 g0swW/LGSNhGnkYpih7JXGCANhuQjCg13dgDwRCcMzkQP5U2W3baf5XO4lR0l2yzxD
 3l99LADJ67g5umRSBiVvyRdPIBMTGdT02yNHrwzESZ6TiBTZRPEKMna/nqNy03Ucu/
 ZZyboAA1r4Ucd9InorF/DJtA4BsKJxF4M5155J6MwgZ7yghfvWF0g4ypplYgbmLMkY
 1v3KvYKBSsR2/XuKjivIZhyfF17En5F/jYGcsbN7y/iPYADv3OnuPw7n/oLObXps1A
 js4UarsiGpVL2bw4HBoUO1SDRaACswstI5UyvvIlh6El5vvejUMOSqNxs1LbP43IXZ
 aZHETRTOb+f26a9MUR1itQyYQxaRFdQ7VoxKE+AnzDQoI5es5ZudQGiKmp+GMoGu2B
 044FSwsVMWPdvZe8eUGGKLyiv7yLvQgdizPe8/N6mrngLXjnrebPzzjYHp0A4TWBi1
 r6oZ8Ss4DiKpxU0z5mKz92tz5RfLexc+Nx8EvxDOJ4UbLGvxr3QgjNRgqT3EHFlgoJ
 mmyWh42DOywoe7WcTd8Io6fk=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <simon.glass@canonical.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Claude <noreply@anthropic.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/6] fat: Separate fat.c from fat_write.c
Date: Thu, 13 Nov 2025 07:46:52 +0100
Message-ID: <20251113064656.245394-3-heinrich.schuchardt@canonical.com>
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

Currently fat_write.c includes fat.c directly, which is unusual and
makes the code harder to maintain. Use the internal header file to hold
shared functions, to avoid this.

Co-developed-by: Claude <noreply@anthropic.com>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fat/Makefile       |  2 +-
 fs/fat/fat.c          | 91 ++++++-----------------------------------
 fs/fat/fat_internal.h | 95 +++++++++++++++++++++++++++++++++++++++++--
 fs/fat/fat_write.c    |  5 ++-
 4 files changed, 108 insertions(+), 85 deletions(-)

diff --git a/fs/fat/Makefile b/fs/fat/Makefile
index 3e739044537..f3982fca4c6 100644
--- a/fs/fat/Makefile
+++ b/fs/fat/Makefile
@@ -2,4 +2,4 @@
 #
 
 obj-$(CONFIG_$(PHASE_)FS_FAT) = fat.o
-obj-$(CONFIG_$(PHASE_)FAT_WRITE) = fat_write.o
+obj-$(CONFIG_$(PHASE_)FAT_WRITE) += fat_write.o
diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 5114e97e924..0fdbd411901 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -33,7 +33,7 @@
  * 'len' may be larger than the length of 'str' if 'str' is NULL
  * terminated.
  */
-static void downcase(char *str, size_t len)
+void downcase(char *str, size_t len)
 {
 	while (*str != '\0' && len--) {
 		*str = tolower(*str);
@@ -41,10 +41,10 @@ static void downcase(char *str, size_t len)
 	}
 }
 
-static struct blk_desc *cur_dev;
-static struct disk_partition cur_part_info;
+struct blk_desc *cur_dev;
+struct disk_partition cur_part_info;
 
-static int disk_read(__u32 block, __u32 nr_blocks, void *buf)
+int disk_read(__u32 block, __u32 nr_blocks, void *buf)
 {
 	ulong ret;
 
@@ -145,8 +145,6 @@ static void get_name(dir_entry *dirent, char *s_name)
 		*s_name = DELETED_FLAG;
 }
 
-static int flush_dirty_fat_buffer(fsdata *mydata);
-
 #if !CONFIG_IS_ENABLED(FAT_WRITE)
 /* Stub for read only operation */
 int flush_dirty_fat_buffer(fsdata *mydata)
@@ -160,7 +158,7 @@ int flush_dirty_fat_buffer(fsdata *mydata)
  * Get the entry at index 'entry' in a FAT (12/16/32) table.
  * On failure 0x00 is returned.
  */
-static __u32 get_fatent(fsdata *mydata, __u32 entry)
+__u32 get_fatent(fsdata *mydata, __u32 entry)
 {
 	__u32 bufnum;
 	__u32 offset, off8;
@@ -469,7 +467,7 @@ static int slot2str(dir_slot *slotptr, char *l_name, int *idx)
 }
 
 /* Calculate short name checksum */
-static __u8 mkcksum(struct nameext *nameext)
+__u8 mkcksum(struct nameext *nameext)
 {
 	int i;
 	u8 *pos = (void *)nameext;
@@ -699,17 +697,7 @@ static int get_fs_info(fsdata *mydata)
 	return 0;
 }
 
-static int fat_itr_isdir(fat_itr *itr);
-
-/**
- * fat_itr_root() - initialize an iterator to start at the root
- * directory
- *
- * @itr: iterator to initialize
- * @fsdata: filesystem data for the partition
- * Return: 0 on success, else -errno
- */
-static int fat_itr_root(fat_itr *itr, fsdata *fsdata)
+int fat_itr_root(fat_itr *itr, fsdata *fsdata)
 {
 	if (get_fs_info(fsdata))
 		return -ENXIO;
@@ -726,24 +714,7 @@ static int fat_itr_root(fat_itr *itr, fsdata *fsdata)
 	return 0;
 }
 
-/**
- * fat_itr_child() - initialize an iterator to descend into a sub-
- * directory
- *
- * Initializes 'itr' to iterate the contents of the directory at
- * the current cursor position of 'parent'.  It is an error to
- * call this if the current cursor of 'parent' is pointing at a
- * regular file.
- *
- * Note that 'itr' and 'parent' can be the same pointer if you do
- * not need to preserve 'parent' after this call, which is useful
- * for traversing directory structure to resolve a file/directory.
- *
- * @itr: iterator to initialize
- * @parent: the iterator pointing at a directory entry in the
- *    parent directory of the directory to iterate
- */
-static void fat_itr_child(fat_itr *itr, fat_itr *parent)
+void fat_itr_child(fat_itr *itr, fat_itr *parent)
 {
 	fsdata *mydata = parent->fsdata;  /* for silly macros */
 	unsigned clustnum = START(parent->dent);
@@ -844,7 +815,7 @@ void *fat_next_cluster(fat_itr *itr, unsigned int *nbytes)
 	return itr->block;
 }
 
-static dir_entry *next_dent(fat_itr *itr)
+dir_entry *next_dent(fat_itr *itr)
 {
 	if (itr->remaining == 0) {
 		unsigned nbytes;
@@ -920,16 +891,7 @@ static dir_entry *extract_vfat_name(fat_itr *itr)
 	return dent;
 }
 
-/**
- * fat_itr_next() - step to the next entry in a directory
- *
- * Must be called once on a new iterator before the cursor is valid.
- *
- * @itr: the iterator to iterate
- * Return: boolean, 1 if success or 0 if no more entries in the
- *    current directory
- */
-static int fat_itr_next(fat_itr *itr)
+int fat_itr_next(fat_itr *itr)
 {
 	dir_entry *dent;
 
@@ -992,41 +954,12 @@ static int fat_itr_next(fat_itr *itr)
 	return 1;
 }
 
-/**
- * fat_itr_isdir() - is current cursor position pointing to a directory
- *
- * @itr: the iterator
- * Return: true if cursor is at a directory
- */
-static int fat_itr_isdir(fat_itr *itr)
+int fat_itr_isdir(fat_itr *itr)
 {
 	return !!(itr->dent->attr & ATTR_DIR);
 }
 
-/*
- * Helpers:
- */
-
-#define TYPE_FILE 0x1
-#define TYPE_DIR  0x2
-#define TYPE_ANY  (TYPE_FILE | TYPE_DIR)
-
-/**
- * fat_itr_resolve() - traverse directory structure to resolve the
- * requested path.
- *
- * Traverse directory structure to the requested path.  If the specified
- * path is to a directory, this will descend into the directory and
- * leave it iterator at the start of the directory.  If the path is to a
- * file, it will leave the iterator in the parent directory with current
- * cursor at file's entry in the directory.
- *
- * @itr: iterator initialized to root
- * @path: the requested path
- * @type: bitmask of allowable file types
- * Return: 0 on success or -errno
- */
-static int fat_itr_resolve(fat_itr *itr, const char *path, unsigned type)
+int fat_itr_resolve(fat_itr *itr, const char *path, unsigned int type)
 {
 	const char *next;
 
diff --git a/fs/fat/fat_internal.h b/fs/fat/fat_internal.h
index 0174cd611e7..10881a15569 100644
--- a/fs/fat/fat_internal.h
+++ b/fs/fat/fat_internal.h
@@ -22,6 +22,14 @@ struct disk_partition;
 #define DOS_FS_TYPE_OFFSET	0x36
 #define DOS_FS32_TYPE_OFFSET	0x52
 
+#define TYPE_FILE 0x1
+#define TYPE_DIR  0x2
+#define TYPE_ANY  (TYPE_FILE | TYPE_DIR)
+
+/* Global variables shared between fat.c and fat_write.c */
+extern struct blk_desc *cur_dev;
+extern struct disk_partition cur_part_info;
+
 /**
  * struct fat_itr - directory iterator, to simplify filesystem traversal
  *
@@ -105,8 +113,89 @@ struct fat_itr {
 	u8 block[MAX_CLUSTSIZE] __aligned(ARCH_DMA_MINALIGN);
 };
 
-#define TYPE_FILE 0x1
-#define TYPE_DIR  0x2
-#define TYPE_ANY  (TYPE_FILE | TYPE_DIR)
+/**
+ * downcase() - convert a string to lowercase
+ * @str: string to convert
+ * @len: maximum number of characters to convert
+ */
+void downcase(char *str, size_t len);
+
+/**
+ * next_dent() - get next directory entry
+ * @itr: directory iterator
+ * Return: pointer to next directory entry, or NULL if at end
+ */
+dir_entry *next_dent(fat_itr *itr);
+
+/**
+ * disk_read() - read sectors from the current FAT device
+ * @block: logical block number
+ * @nr_blocks: number of blocks to read
+ * @buf: buffer to read data into
+ * Return: number of blocks read, -1 on error
+ */
+int disk_read(__u32 block, __u32 nr_blocks, void *buf);
+
+/**
+ * flush_dirty_fat_buffer() - write fat buffer to disk if dirty
+ * @mydata: filesystem data
+ * Return: 0 on success, -1 on error
+ */
+int flush_dirty_fat_buffer(fsdata *mydata);
+
+/* Internal function declarations */
+
+/**
+ * get_fatent() - get the entry at index 'entry' in a FAT (12/16/32) table
+ * @mydata: filesystem data
+ * @entry: FAT entry index
+ * Return: FAT entry value, 0x00 on failure
+ */
+__u32 get_fatent(fsdata *mydata, __u32 entry);
+
+/**
+ * mkcksum() - calculate short name checksum
+ * @nameext: name and extension structure
+ * Return: checksum value
+ */
+__u8 mkcksum(struct nameext *nameext);
+
+/**
+ * fat_itr_root() - initialize an iterator to start at the root directory
+ * @itr: iterator to initialize
+ * @fsdata: filesystem data for the partition
+ * Return: 0 on success, else -errno
+ */
+int fat_itr_root(fat_itr *itr, fsdata *fsdata);
+
+/**
+ * fat_itr_child() - initialize an iterator to descend into a sub-directory
+ * @itr: iterator to initialize
+ * @parent: the iterator pointing at a directory entry in the parent directory
+ */
+void fat_itr_child(fat_itr *itr, fat_itr *parent);
+
+/**
+ * fat_itr_next() - step to the next entry in a directory
+ * @itr: the iterator to iterate
+ * Return: 1 if success or 0 if no more entries in the current directory
+ */
+int fat_itr_next(fat_itr *itr);
+
+/**
+ * fat_itr_isdir() - is current cursor position pointing to a directory
+ * @itr: the iterator
+ * Return: true if cursor is at a directory
+ */
+int fat_itr_isdir(fat_itr *itr);
+
+/**
+ * fat_itr_resolve() - traverse directory structure to resolve the requested path
+ * @itr: iterator initialized to root
+ * @path: the requested path
+ * @type: bitmask of allowable file types
+ * Return: 0 on success or -errno
+ */
+int fat_itr_resolve(fat_itr *itr, const char *path, uint type);
 
 #endif /* _FAT_INTERNAL_H_ */
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index 45a2eef712b..638a6223700 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -13,15 +13,16 @@
 #include <fat.h>
 #include <log.h>
 #include <malloc.h>
+#include <memalign.h>
 #include <part.h>
 #include <rand.h>
+#include <rtc.h>
 #include <asm/byteorder.h>
 #include <asm/cache.h>
 #include <dm/uclass.h>
 #include <linux/ctype.h>
 #include <linux/math64.h>
 #include "fat_internal.h"
-#include "fat.c"
 
 static dir_entry *find_directory_entry(fat_itr *itr, char *filename);
 static int new_dir_table(fat_itr *itr);
@@ -216,7 +217,7 @@ static int disk_write(__u32 block, __u32 nr_blocks, void *buf)
 /*
  * Write fat buffer into block device
  */
-static int flush_dirty_fat_buffer(fsdata *mydata)
+int flush_dirty_fat_buffer(fsdata *mydata)
 {
 	int getsize = FATBUFBLOCKS;
 	__u32 fatlength = mydata->fatlength;
-- 
2.51.0

