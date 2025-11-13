Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE79ECCFA18
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 06:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 096BB83DC9;
	Thu, 13 Nov 2025 07:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="p3+Xz5M9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4F2383DBD; Thu, 13 Nov 2025 07:47:33 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E688883D8B
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 07:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 0E13140A16; 
 Thu, 13 Nov 2025 06:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763016448;
 bh=O/F7sGlNiyuclHyHh3ETEYBliDLqhZqLe4f2yhiYSXA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=p3+Xz5M9ZETDTXuy8568TiwIfPHOB9SIQArv9x5klrsqV65x6rMaHTjgm1PtDHVw6
 R3skR0/Gp5393O/NOufWi7oWMk+hv0qgSUvD5DbY3mWE7LpU8cKWA37xiiqoEvVQFa
 WxiOW9V5PhnbC7metH6OrmfhaVZbWfHFKBfYmsyfCQQy7vlX5XBiqCJftuIpn5UEAA
 X4OyFRoQK9Vr6WeD1ooxBiUDnrQimhxzrU/xeTz1PXAvYXnPmnEhR0kaM2hKRA38GD
 mDpr0kC4tSEa0YuBD007GqO+nQ7myfePUW7E/ZuqjD2Si8traFyvTqDpRMCJqxLyW+
 vSjuHo2phkoz/PwF0xmriKxnjNKxT9K+sxqN+S86MGPys0QKZSRZpj+/QTKj7zA5yi
 eVr0iveX8m3ylrOwib7NengZvI7W7KO92zgRa/ORDha0hALHRWSWTlHOavq8m86ob8
 dSd/6DLRLW+KWRUB31YfxXPUMuslQZtBkkWUKDfm6V+RQK/V6S5mJ2I3Xd93ci0N95
 rWTwj4iGyYKFbXuMfiag7rgzXnmemR23rw9fSe0ym0U8O21izo4JQaRvYq9MlQqdMq
 lebS7cvPC/bvUvy/M9gylQNj9eZPzaKLx6hsxhZl29jZ/K5jc4f0IjY0NBcBQeyzNr
 nF0rJxfBeY1ztr0MMdm1LptI=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <simon.glass@canonical.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Claude <noreply@anthropic.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/6] fat: Remove typedefs in fat.h
Date: Thu, 13 Nov 2025 07:46:54 +0100
Message-ID: <20251113064656.245394-5-heinrich.schuchardt@canonical.com>
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

Convert all typedefs in fat.h to normal struct declarations.

Co-developed-by: Claude <noreply@anthropic.com>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fat/fat.c          | 108 ++++++++++++++--------------
 fs/fat/fat_internal.h |  22 +++---
 fs/fat/fat_write.c    | 159 +++++++++++++++++++++---------------------
 include/fat.h         |  28 ++++----
 4 files changed, 158 insertions(+), 159 deletions(-)

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 0fdbd411901..9e439fc5879 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -118,7 +118,7 @@ int fat_register_device(struct blk_desc *dev_desc, int part_no)
 /*
  * Extract zero terminated short name from a directory entry.
  */
-static void get_name(dir_entry *dirent, char *s_name)
+static void get_name(struct dir_entry *dirent, char *s_name)
 {
 	char *ptr;
 
@@ -147,7 +147,7 @@ static void get_name(dir_entry *dirent, char *s_name)
 
 #if !CONFIG_IS_ENABLED(FAT_WRITE)
 /* Stub for read only operation */
-int flush_dirty_fat_buffer(fsdata *mydata)
+int flush_dirty_fat_buffer(struct fsdata *mydata)
 {
 	(void)(mydata);
 	return 0;
@@ -158,7 +158,7 @@ int flush_dirty_fat_buffer(fsdata *mydata)
  * Get the entry at index 'entry' in a FAT (12/16/32) table.
  * On failure 0x00 is returned.
  */
-__u32 get_fatent(fsdata *mydata, __u32 entry)
+__u32 get_fatent(struct fsdata *mydata, __u32 entry)
 {
 	__u32 bufnum;
 	__u32 offset, off8;
@@ -243,7 +243,7 @@ __u32 get_fatent(fsdata *mydata, __u32 entry)
  * Return 0 on success, -1 otherwise.
  */
 static int
-get_cluster(fsdata *mydata, __u32 clustnum, __u8 *buffer, unsigned long size)
+get_cluster(struct fsdata *mydata, __u32 clustnum, __u8 *buffer, unsigned long size)
 {
 	__u32 startsect;
 	int ret;
@@ -316,7 +316,7 @@ get_cluster(fsdata *mydata, __u32 clustnum, __u8 *buffer, unsigned long size)
  * @gotsize:	number of bytes actually read
  * Return:	-1 on error, otherwise 0
  */
-static int get_contents(fsdata *mydata, dir_entry *dentptr, loff_t pos,
+static int get_contents(struct fsdata *mydata, struct dir_entry *dentptr, loff_t pos,
 			__u8 *buffer, loff_t maxsize, loff_t *gotsize)
 {
 	loff_t filesize = FAT2CPU32(dentptr->size);
@@ -440,7 +440,7 @@ getit:
  * starting at l_name[*idx].
  * Return 1 if terminator (zero byte) is found, 0 otherwise.
  */
-static int slot2str(dir_slot *slotptr, char *l_name, int *idx)
+static int slot2str(struct dir_slot *slotptr, char *l_name, int *idx)
 {
 	int j;
 
@@ -485,12 +485,12 @@ __u8 mkcksum(struct nameext *nameext)
  *
  * Based on fat_fill_super() from the Linux kernel's fs/fat/inode.c
  */
-static int determine_legacy_fat_bits(const boot_sector *bs)
+static int determine_legacy_fat_bits(const struct boot_sector *bs)
 {
 	u16 fat_start = bs->reserved;
 	u32 dir_start = fat_start + bs->fats * bs->fat_length;
 	u32 rootdir_sectors = get_unaligned_le16(bs->dir_entries) *
-			      sizeof(dir_entry) /
+			      sizeof(struct dir_entry) /
 			      get_unaligned_le16(bs->sector_size);
 	u32 data_start = dir_start + rootdir_sectors;
 	u16 sectors = get_unaligned_le16(bs->sectors);
@@ -516,10 +516,10 @@ static int fat_valid_media(u8 media)
  *
  * Based on fat_read_bpb() from the Linux kernel's fs/fat/inode.c
  */
-static int is_bootsector_valid(const boot_sector *bs)
+static int is_bootsector_valid(const struct boot_sector *bs)
 {
 	u16 sector_size = get_unaligned_le16(bs->sector_size);
-	u16 dir_per_block = sector_size / sizeof(dir_entry);
+	u16 dir_per_block = sector_size / sizeof(struct dir_entry);
 
 	if (!bs->reserved)
 		return 0;
@@ -551,10 +551,10 @@ static int is_bootsector_valid(const boot_sector *bs)
  * Read boot sector and volume info from a FAT filesystem
  */
 static int
-read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
+read_bootsectandvi(struct boot_sector *bs, struct volume_info *volinfo, int *fatsize)
 {
 	__u8 *block;
-	volume_info *vistart;
+	struct volume_info *vistart;
 	int ret = 0;
 
 	if (cur_dev == NULL) {
@@ -574,7 +574,7 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 		goto out_free;
 	}
 
-	memcpy(bs, block, sizeof(boot_sector));
+	memcpy(bs, block, sizeof(struct boot_sector));
 	bs->reserved = FAT2CPU16(bs->reserved);
 	bs->fat_length = FAT2CPU16(bs->fat_length);
 	bs->secs_track = FAT2CPU16(bs->secs_track);
@@ -595,23 +595,23 @@ read_bootsectandvi(boot_sector *bs, volume_info *volinfo, int *fatsize)
 		bs->root_cluster = FAT2CPU32(bs->root_cluster);
 		bs->info_sector = FAT2CPU16(bs->info_sector);
 		bs->backup_boot = FAT2CPU16(bs->backup_boot);
-		vistart = (volume_info *)(block + sizeof(boot_sector));
+		vistart = (struct volume_info *)(block + sizeof(struct boot_sector));
 		*fatsize = 32;
 	} else {
-		vistart = (volume_info *)&(bs->fat32_length);
+		vistart = (struct volume_info *)&(bs->fat32_length);
 		*fatsize = determine_legacy_fat_bits(bs);
 	}
-	memcpy(volinfo, vistart, sizeof(volume_info));
+	memcpy(volinfo, vistart, sizeof(struct volume_info));
 
 out_free:
 	free(block);
 	return ret;
 }
 
-static int get_fs_info(fsdata *mydata)
+static int get_fs_info(struct fsdata *mydata)
 {
-	boot_sector bs;
-	volume_info volinfo;
+	struct boot_sector bs;
+	struct volume_info volinfo;
 	int ret;
 
 	ret = read_bootsectandvi(&bs, &volinfo, &mydata->fatsize);
@@ -662,7 +662,7 @@ static int get_fs_info(fsdata *mydata)
 		mydata->root_cluster = bs.root_cluster;
 	} else {
 		mydata->rootdir_size = (get_unaligned_le16(bs.dir_entries) *
-					 sizeof(dir_entry)) /
+					 sizeof(struct dir_entry)) /
 					 mydata->sect_size;
 		mydata->data_begin = mydata->rootdir_sect +
 					mydata->rootdir_size -
@@ -697,7 +697,7 @@ static int get_fs_info(fsdata *mydata)
 	return 0;
 }
 
-int fat_itr_root(fat_itr *itr, fsdata *fsdata)
+int fat_itr_root(struct fat_itr *itr, struct fsdata *fsdata)
 {
 	if (get_fs_info(fsdata))
 		return -ENXIO;
@@ -714,9 +714,9 @@ int fat_itr_root(fat_itr *itr, fsdata *fsdata)
 	return 0;
 }
 
-void fat_itr_child(fat_itr *itr, fat_itr *parent)
+void fat_itr_child(struct fat_itr *itr, struct fat_itr *parent)
 {
-	fsdata *mydata = parent->fsdata;  /* for silly macros */
+	struct fsdata *mydata = parent->fsdata;  /* for silly macros */
 	unsigned clustnum = START(parent->dent);
 
 	assert(fat_itr_isdir(parent));
@@ -748,7 +748,7 @@ void fat_itr_child(fat_itr *itr, fat_itr *parent)
  * @nbytes:	number of bytes read, 0 on error
  * Return:	first directory entry, NULL on error
  */
-void *fat_next_cluster(fat_itr *itr, unsigned int *nbytes)
+void *fat_next_cluster(struct fat_itr *itr, unsigned int *nbytes)
 {
 	int ret;
 	u32 sect;
@@ -815,7 +815,7 @@ void *fat_next_cluster(fat_itr *itr, unsigned int *nbytes)
 	return itr->block;
 }
 
-dir_entry *next_dent(fat_itr *itr)
+struct dir_entry *next_dent(struct fat_itr *itr)
 {
 	if (itr->remaining == 0) {
 		unsigned nbytes;
@@ -828,7 +828,7 @@ dir_entry *next_dent(fat_itr *itr)
 			return NULL;
 		}
 
-		itr->remaining = nbytes / sizeof(dir_entry) - 1;
+		itr->remaining = nbytes / sizeof(struct dir_entry) - 1;
 		itr->dent = dent;
 	} else {
 		itr->remaining--;
@@ -842,18 +842,18 @@ dir_entry *next_dent(fat_itr *itr)
 	return itr->dent;
 }
 
-static dir_entry *extract_vfat_name(fat_itr *itr)
+static struct dir_entry *extract_vfat_name(struct fat_itr *itr)
 {
 	struct dir_entry *dent = itr->dent;
 	int seqn = itr->dent->nameext.name[0] & ~LAST_LONG_ENTRY_MASK;
-	u8 chksum, alias_checksum = ((dir_slot *)dent)->alias_checksum;
+	u8 chksum, alias_checksum = ((struct dir_slot *)dent)->alias_checksum;
 	int n = 0;
 
 	while (seqn--) {
 		char buf[13];
 		int idx = 0;
 
-		slot2str((dir_slot *)dent, buf, &idx);
+		slot2str((struct dir_slot *)dent, buf, &idx);
 
 		if (n + idx >= sizeof(itr->l_name))
 			return NULL;
@@ -891,9 +891,9 @@ static dir_entry *extract_vfat_name(fat_itr *itr)
 	return dent;
 }
 
-int fat_itr_next(fat_itr *itr)
+int fat_itr_next(struct fat_itr *itr)
 {
-	dir_entry *dent;
+	struct dir_entry *dent;
 
 	itr->name = NULL;
 
@@ -954,12 +954,12 @@ int fat_itr_next(fat_itr *itr)
 	return 1;
 }
 
-int fat_itr_isdir(fat_itr *itr)
+int fat_itr_isdir(struct fat_itr *itr)
 {
 	return !!(itr->dent->attr & ATTR_DIR);
 }
 
-int fat_itr_resolve(fat_itr *itr, const char *path, unsigned int type)
+int fat_itr_resolve(struct fat_itr *itr, const char *path, uint type)
 {
 	const char *next;
 
@@ -1039,8 +1039,8 @@ int fat_itr_resolve(fat_itr *itr, const char *path, unsigned type)
 
 int file_fat_detectfs(void)
 {
-	boot_sector bs;
-	volume_info volinfo;
+	struct boot_sector bs;
+	struct volume_info volinfo;
 	int fatsize;
 	char vol_label[12];
 
@@ -1070,11 +1070,11 @@ int file_fat_detectfs(void)
 
 int fat_exists(const char *filename)
 {
-	fsdata fsdata;
-	fat_itr *itr;
+	struct fsdata fsdata;
+	struct fat_itr *itr;
 	int ret;
 
-	itr = malloc_cache_aligned(sizeof(fat_itr));
+	itr = malloc_cache_aligned(sizeof(struct fat_itr));
 	if (!itr)
 		return 0;
 	ret = fat_itr_root(itr, &fsdata);
@@ -1112,11 +1112,11 @@ static void __maybe_unused fat2rtc(u16 date, u16 time, struct rtc_time *tm)
 
 int fat_size(const char *filename, loff_t *size)
 {
-	fsdata fsdata;
-	fat_itr *itr;
+	struct fsdata fsdata;
+	struct fat_itr *itr;
 	int ret;
 
-	itr = malloc_cache_aligned(sizeof(fat_itr));
+	itr = malloc_cache_aligned(sizeof(struct fat_itr));
 	if (!itr)
 		return -ENOMEM;
 	ret = fat_itr_root(itr, &fsdata);
@@ -1150,11 +1150,11 @@ out_free_itr:
 int fat_read_file(const char *filename, void *buf, loff_t offset, loff_t len,
 		  loff_t *actread)
 {
-	fsdata fsdata;
-	fat_itr *itr;
+	struct fsdata fsdata;
+	struct fat_itr *itr;
 	int ret;
 
-	itr = malloc_cache_aligned(sizeof(fat_itr));
+	itr = malloc_cache_aligned(sizeof(struct fat_itr));
 	if (!itr)
 		return -ENOMEM;
 	ret = fat_itr_root(itr, &fsdata);
@@ -1168,7 +1168,7 @@ int fat_read_file(const char *filename, void *buf, loff_t offset, loff_t len,
 	debug("reading %s at pos %llu\n", filename, offset);
 
 	/* For saving default max clustersize memory allocated to malloc pool */
-	dir_entry *dentptr = itr->dent;
+	struct dir_entry *dentptr = itr->dent;
 
 	ret = get_contents(&fsdata, dentptr, offset, buf, len, actread);
 
@@ -1191,16 +1191,16 @@ int file_fat_read(const char *filename, void *buffer, int maxsize)
 		return actread;
 }
 
-typedef struct {
+struct fat_dir {
 	struct fs_dir_stream parent;
 	struct fs_dirent dirent;
-	fsdata fsdata;
-	fat_itr itr;
-} fat_dir;
+	struct fsdata fsdata;
+	struct fat_itr itr;
+};
 
 int fat_opendir(const char *filename, struct fs_dir_stream **dirsp)
 {
-	fat_dir *dir;
+	struct fat_dir *dir;
 	int ret;
 
 	dir = malloc_cache_aligned(sizeof(*dir));
@@ -1228,7 +1228,7 @@ fail_free_dir:
 
 int fat_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp)
 {
-	fat_dir *dir = (fat_dir *)dirs;
+	struct fat_dir *dir = (struct fat_dir *)dirs;
 	struct fs_dirent *dent = &dir->dirent;
 
 	if (!fat_itr_next(&dir->itr))
@@ -1259,7 +1259,7 @@ int fat_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp)
 
 void fat_closedir(struct fs_dir_stream *dirs)
 {
-	fat_dir *dir = (fat_dir *)dirs;
+	struct fat_dir *dir = (struct fat_dir *)dirs;
 	free(dir->fsdata.fatbuf);
 	free(dir);
 }
@@ -1270,8 +1270,8 @@ void fat_close(void)
 
 int fat_uuid(char *uuid_str)
 {
-	boot_sector bs;
-	volume_info volinfo;
+	struct boot_sector bs;
+	struct volume_info volinfo;
 	int fatsize;
 	int ret;
 	u8 *id;
diff --git a/fs/fat/fat_internal.h b/fs/fat/fat_internal.h
index bc52d534b46..cefe28c8d00 100644
--- a/fs/fat/fat_internal.h
+++ b/fs/fat/fat_internal.h
@@ -66,17 +66,17 @@ extern struct disk_partition cur_part_info;
  * For a more complete example, see fat_itr_resolve().
  */
 struct fat_itr {
-	fsdata *fsdata;
+	struct fsdata *fsdata;
 	unsigned int start_clust;
 	unsigned int clust;
 	unsigned int next_clust;
 	int last_cluster;
 	int is_root;
 	int remaining;
-	dir_entry *dent;
+	struct dir_entry *dent;
 	int dent_rem;
 	unsigned int dent_clust;
-	dir_entry *dent_start;
+	struct dir_entry *dent_start;
 	char l_name[VFAT_MAXLEN_BYTES];
 	char s_name[14];
 	char *name;
@@ -95,7 +95,7 @@ void downcase(char *str, size_t len);
  * @itr: directory iterator
  * Return: pointer to next directory entry, or NULL if at end
  */
-dir_entry *next_dent(fat_itr *itr);
+struct dir_entry *next_dent(struct fat_itr *itr);
 
 /**
  * disk_read() - read sectors from the current FAT device
@@ -111,7 +111,7 @@ int disk_read(__u32 block, __u32 nr_blocks, void *buf);
  * @mydata: filesystem data
  * Return: 0 on success, -1 on error
  */
-int flush_dirty_fat_buffer(fsdata *mydata);
+int flush_dirty_fat_buffer(struct fsdata *mydata);
 
 /* Internal function declarations */
 
@@ -121,7 +121,7 @@ int flush_dirty_fat_buffer(fsdata *mydata);
  * @entry: FAT entry index
  * Return: FAT entry value, 0x00 on failure
  */
-__u32 get_fatent(fsdata *mydata, __u32 entry);
+__u32 get_fatent(struct fsdata *mydata, __u32 entry);
 
 /**
  * mkcksum() - calculate short name checksum
@@ -136,28 +136,28 @@ __u8 mkcksum(struct nameext *nameext);
  * @fsdata: filesystem data for the partition
  * Return: 0 on success, else -errno
  */
-int fat_itr_root(fat_itr *itr, fsdata *fsdata);
+int fat_itr_root(struct fat_itr *itr, struct fsdata *fsdata);
 
 /**
  * fat_itr_child() - initialize an iterator to descend into a sub-directory
  * @itr: iterator to initialize
  * @parent: the iterator pointing at a directory entry in the parent directory
  */
-void fat_itr_child(fat_itr *itr, fat_itr *parent);
+void fat_itr_child(struct fat_itr *itr, struct fat_itr *parent);
 
 /**
  * fat_itr_next() - step to the next entry in a directory
  * @itr: the iterator to iterate
  * Return: 1 if success or 0 if no more entries in the current directory
  */
-int fat_itr_next(fat_itr *itr);
+int fat_itr_next(struct fat_itr *itr);
 
 /**
  * fat_itr_isdir() - is current cursor position pointing to a directory
  * @itr: the iterator
  * Return: true if cursor is at a directory
  */
-int fat_itr_isdir(fat_itr *itr);
+int fat_itr_isdir(struct fat_itr *itr);
 
 /**
  * fat_itr_resolve() - traverse directory structure to resolve the requested path
@@ -166,6 +166,6 @@ int fat_itr_isdir(fat_itr *itr);
  * @type: bitmask of allowable file types
  * Return: 0 on success or -errno
  */
-int fat_itr_resolve(fat_itr *itr, const char *path, uint type);
+int fat_itr_resolve(struct fat_itr *itr, const char *path, uint type);
 
 #endif /* _FAT_INTERNAL_H_ */
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index 638a6223700..f2aa3402adb 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -24,8 +24,8 @@
 #include <linux/math64.h>
 #include "fat_internal.h"
 
-static dir_entry *find_directory_entry(fat_itr *itr, char *filename);
-static int new_dir_table(fat_itr *itr);
+static struct dir_entry *find_directory_entry(struct fat_itr *itr, char *filename);
+static int new_dir_table(struct fat_itr *itr);
 
 /* Characters that may only be used in long file names */
 static const char LONG_ONLY_CHARS[] = "+,;=[]";
@@ -77,7 +77,7 @@ static int str2fat(char *dest, char *src, int length)
  * @cluster	cluster
  * Return:	0 for success, -EIO on error
  */
-static int fat_move_to_cluster(fat_itr *itr, unsigned int cluster)
+static int fat_move_to_cluster(struct fat_itr *itr, unsigned int cluster)
 {
 	unsigned int nbytes;
 
@@ -86,8 +86,8 @@ static int fat_move_to_cluster(fat_itr *itr, unsigned int cluster)
 	itr->last_cluster = 0;
 	if (!fat_next_cluster(itr, &nbytes))
 		return -EIO;
-	itr->dent = (dir_entry *)itr->block;
-	itr->remaining = nbytes / sizeof(dir_entry) - 1;
+	itr->dent = (struct dir_entry *)itr->block;
+	itr->remaining = nbytes / sizeof(struct dir_entry) - 1;
 	return 0;
 }
 
@@ -104,7 +104,7 @@ static int fat_move_to_cluster(fat_itr *itr, unsigned int cluster)
  * @shortname:	buffer of 11 bytes to receive chosen short name and extension
  * Return:	number of directory entries needed, negative on error
  */
-static int set_name(fat_itr *itr, const char *filename, char *shortname)
+static int set_name(struct fat_itr *itr, const char *filename, char *shortname)
 {
 	char *period;
 	char *pos;
@@ -217,7 +217,7 @@ static int disk_write(__u32 block, __u32 nr_blocks, void *buf)
 /*
  * Write fat buffer into block device
  */
-int flush_dirty_fat_buffer(fsdata *mydata)
+int flush_dirty_fat_buffer(struct fsdata *mydata)
 {
 	int getsize = FATBUFBLOCKS;
 	__u32 fatlength = mydata->fatlength;
@@ -262,10 +262,10 @@ int flush_dirty_fat_buffer(fsdata *mydata)
  * @count:	number of directory entries to find
  * Return:	0 on success or negative error number
  */
-static int fat_find_empty_dentries(fat_itr *itr, int count)
+static int fat_find_empty_dentries(struct fat_itr *itr, int count)
 {
 	unsigned int cluster;
-	dir_entry *dent;
+	struct dir_entry *dent;
 	int remaining;
 	unsigned int n = 0;
 	int ret;
@@ -318,7 +318,7 @@ out:
 /*
  * Set the file name information from 'name' into 'slotptr',
  */
-static int str2slot(dir_slot *slotptr, const char *name, int *idx)
+static int str2slot(struct dir_slot *slotptr, const char *name, int *idx)
 {
 	int j, end_idx = 0;
 
@@ -384,7 +384,7 @@ name11_12:
 	return 1;
 }
 
-static int flush_dir(fat_itr *itr);
+static int flush_dir(struct fat_itr *itr);
 
 /**
  * fill_dir_slot() - fill directory entries for long name
@@ -395,10 +395,10 @@ static int flush_dir(fat_itr *itr);
  * Return:	0 for success, -errno otherwise
  */
 static int
-fill_dir_slot(fat_itr *itr, const char *l_name, const char *shortname)
+fill_dir_slot(struct fat_itr *itr, const char *l_name, const char *shortname)
 {
-	__u8 temp_dir_slot_buffer[MAX_LFN_SLOT * sizeof(dir_slot)];
-	dir_slot *slotptr = (dir_slot *)temp_dir_slot_buffer;
+	__u8 temp_dir_slot_buffer[MAX_LFN_SLOT * sizeof(struct dir_slot)];
+	struct dir_slot *slotptr = (struct dir_slot *)temp_dir_slot_buffer;
 	__u8 counter = 0, checksum;
 	int idx = 0, ret;
 
@@ -406,7 +406,7 @@ fill_dir_slot(fat_itr *itr, const char *l_name, const char *shortname)
 	checksum = mkcksum((void *)shortname);
 
 	do {
-		memset(slotptr, 0x00, sizeof(dir_slot));
+		memset(slotptr, 0x00, sizeof(struct dir_slot));
 		ret = str2slot(slotptr, l_name, &idx);
 		slotptr->id = ++counter;
 		slotptr->attr = ATTR_VFAT;
@@ -418,7 +418,7 @@ fill_dir_slot(fat_itr *itr, const char *l_name, const char *shortname)
 	slotptr->id |= LAST_LONG_ENTRY_MASK;
 
 	while (counter >= 1) {
-		memcpy(itr->dent, slotptr, sizeof(dir_slot));
+		memcpy(itr->dent, slotptr, sizeof(struct dir_slot));
 		slotptr--;
 		counter--;
 
@@ -440,7 +440,7 @@ fill_dir_slot(fat_itr *itr, const char *l_name, const char *shortname)
 /*
  * Set the entry at index 'entry' in a FAT (12/16/32) table.
  */
-static int set_fatent_value(fsdata *mydata, __u32 entry, __u32 entry_value)
+static int set_fatent_value(struct fsdata *mydata, __u32 entry, __u32 entry_value)
 {
 	__u32 bufnum, offset, off16;
 	__u16 val1, val2;
@@ -547,7 +547,7 @@ static int set_fatent_value(fsdata *mydata, __u32 entry, __u32 entry_value)
  * Determine the next free cluster after 'entry' in a FAT (12/16/32) table
  * and link it to 'entry'. EOC marker is not set on returned entry.
  */
-static __u32 determine_fatent(fsdata *mydata, __u32 entry)
+static __u32 determine_fatent(struct fsdata *mydata, __u32 entry)
 {
 	__u32 next_fat, next_entry = entry + 1;
 
@@ -578,7 +578,7 @@ static __u32 determine_fatent(fsdata *mydata, __u32 entry)
  * Return:	0 on success, -1 otherwise
  */
 static int
-set_sectors(fsdata *mydata, u32 startsect, u8 *buffer, u32 size)
+set_sectors(struct fsdata *mydata, u32 startsect, u8 *buffer, u32 size)
 {
 	int ret;
 
@@ -642,7 +642,7 @@ set_sectors(fsdata *mydata, u32 startsect, u8 *buffer, u32 size)
  * Return:	0 on success, -1 otherwise
  */
 static int
-set_cluster(fsdata *mydata, u32 clustnum, u8 *buffer, u32 size)
+set_cluster(struct fsdata *mydata, u32 clustnum, u8 *buffer, u32 size)
 {
 	return set_sectors(mydata, clust_to_sect(mydata, clustnum),
 			   buffer, size);
@@ -654,9 +654,9 @@ set_cluster(fsdata *mydata, u32 clustnum, u8 *buffer, u32 size)
  * @itr:	directory iterator
  * Return:	0 for success, -EIO on error
  */
-static int flush_dir(fat_itr *itr)
+static int flush_dir(struct fat_itr *itr)
 {
-	fsdata *mydata = itr->fsdata;
+	struct fsdata *mydata = itr->fsdata;
 	u32 startsect, sect_offset, nsects;
 	int ret;
 
@@ -686,7 +686,7 @@ out:
  * Read and modify data on existing and consecutive cluster blocks
  */
 static int
-get_set_cluster(fsdata *mydata, __u32 clustnum, loff_t pos, __u8 *buffer,
+get_set_cluster(struct fsdata *mydata, __u32 clustnum, loff_t pos, __u8 *buffer,
 		loff_t size, loff_t *gotsize)
 {
 	static u8 *tmpbuf_cluster;
@@ -804,7 +804,7 @@ get_set_cluster(fsdata *mydata, __u32 clustnum, loff_t pos, __u8 *buffer,
 /*
  * Find the first empty cluster
  */
-static int find_empty_cluster(fsdata *mydata)
+static int find_empty_cluster(struct fsdata *mydata)
 {
 	__u32 fat_val, entry = 3;
 
@@ -824,9 +824,9 @@ static int find_empty_cluster(fsdata *mydata)
  * @itr:	directory iterator
  * Return:	0 on success, -EIO otherwise
  */
-static int new_dir_table(fat_itr *itr)
+static int new_dir_table(struct fat_itr *itr)
 {
-	fsdata *mydata = itr->fsdata;
+	struct fsdata *mydata = itr->fsdata;
 	int dir_newclust = 0;
 	int dir_oldclust = itr->clust;
 	unsigned int bytesperclust = mydata->clust_size * mydata->sect_size;
@@ -854,9 +854,9 @@ static int new_dir_table(fat_itr *itr)
 	if (flush_dirty_fat_buffer(mydata) < 0)
 		return -EIO;
 
-	itr->dent = (dir_entry *)itr->block;
+	itr->dent = (struct dir_entry *)itr->block;
 	itr->last_cluster = 1;
-	itr->remaining = bytesperclust / sizeof(dir_entry) - 1;
+	itr->remaining = bytesperclust / sizeof(struct dir_entry) - 1;
 
 	return 0;
 }
@@ -864,7 +864,7 @@ static int new_dir_table(fat_itr *itr)
 /*
  * Set empty cluster from 'entry' to the end of a file
  */
-static int clear_fatent(fsdata *mydata, __u32 entry)
+static int clear_fatent(struct fsdata *mydata, __u32 entry)
 {
 	__u32 fat_val;
 
@@ -888,7 +888,7 @@ static int clear_fatent(fsdata *mydata, __u32 entry)
 /*
  * Set start cluster in directory entry
  */
-static void set_start_cluster(const fsdata *mydata, dir_entry *dentptr,
+static void set_start_cluster(const struct fsdata *mydata, struct dir_entry *dentptr,
 			      __u32 start_cluster)
 {
 	if (mydata->fatsize == 32)
@@ -902,7 +902,7 @@ static void set_start_cluster(const fsdata *mydata, dir_entry *dentptr,
  * exceed the size of the block device
  * Return -1 when overflow occurs, otherwise return 0
  */
-static int check_overflow(fsdata *mydata, __u32 clustnum, loff_t size)
+static int check_overflow(struct fsdata *mydata, __u32 clustnum, loff_t size)
 {
 	__u32 startsect, sect_num, offset;
 
@@ -928,7 +928,7 @@ static int check_overflow(fsdata *mydata, __u32 clustnum, loff_t size)
  * or return -1 on fatal errors.
  */
 static int
-set_contents(fsdata *mydata, dir_entry *dentptr, loff_t pos, __u8 *buffer,
+set_contents(struct fsdata *mydata, struct dir_entry *dentptr, loff_t pos, __u8 *buffer,
 	     loff_t maxsize, loff_t *gotsize)
 {
 	unsigned int bytesperclust = mydata->clust_size * mydata->sect_size;
@@ -1158,7 +1158,7 @@ getit:
  *
  * @dentptr:	directory entry
  */
-static void dentry_set_time(dir_entry *dentptr)
+static void dentry_set_time(struct dir_entry *dentptr)
 {
 	if (CONFIG_IS_ENABLED(DM_RTC)) {
 		struct udevice *dev;
@@ -1198,8 +1198,9 @@ err:
  * @size:		file size
  * @attr:		file attributes
  */
-static void fill_dentry(fsdata *mydata, dir_entry *dentptr,
-	const char *shortname, __u32 start_cluster, __u32 size, __u8 attr)
+static void fill_dentry(struct fsdata *mydata, struct dir_entry *dentptr,
+			const char *shortname, __u32 start_cluster, __u32 size,
+			__u8 attr)
 {
 	memset(dentptr, 0, sizeof(*dentptr));
 
@@ -1224,7 +1225,7 @@ static void fill_dentry(fsdata *mydata, dir_entry *dentptr,
  * @itr:	iterator positioned anywhere in a directory
  * @Return:	0 if the iterator is in the parent directory, -errno otherwise
  */
-static int fat_itr_parent(fat_itr *itr)
+static int fat_itr_parent(struct fat_itr *itr)
 {
 	int ret;
 
@@ -1246,19 +1247,19 @@ static int fat_itr_parent(fat_itr *itr)
  * should be updated
  * @Return:	0 for success, -errno otherwise
  */
-static int update_parent_dir_props(fat_itr *dir_itr)
+static int update_parent_dir_props(struct fat_itr *dir_itr)
 {
 	int ret = 0;
 
-	fat_itr itr;
-	fsdata fsdata = { .fatbuf = NULL, }, *mydata = &fsdata;
+	struct fat_itr itr;
+	struct fsdata fsdata = { .fatbuf = NULL, }, *mydata = &fsdata;
 	__u32 target_clust = dir_itr->start_clust;
 
 	/* Short circuit if no RTC because it only updates timestamps */
 	if (!CONFIG_IS_ENABLED(DM_RTC))
 		return ret;
 
-	/* duplicate fsdata */
+	/* duplicate struct fsdata */
 	itr = *dir_itr;
 	fsdata = *itr.fsdata;
 
@@ -1308,7 +1309,7 @@ exit:
  * @attr:	file attributes
  * Return:	0 for success
  */
-static int create_link(fat_itr *itr, char *basename, __u32 clust, __u32 size,
+static int create_link(struct fat_itr *itr, char *basename, __u32 clust, __u32 size,
 		       __u8 attr)
 {
 	char shortname[SHORT_NAME_SIZE];
@@ -1342,7 +1343,7 @@ static int create_link(fat_itr *itr, char *basename, __u32 clust, __u32 size,
  * @filename:	name of file to find
  * Return:	directory entry or NULL
  */
-static dir_entry *find_directory_entry(fat_itr *itr, char *filename)
+static struct dir_entry *find_directory_entry(struct fat_itr *itr, char *filename)
 {
 	int match = 0;
 
@@ -1473,10 +1474,10 @@ static int normalize_longname(char *l_filename, const char *filename)
 int file_fat_write_at(const char *filename, loff_t pos, void *buffer,
 		      loff_t size, loff_t *actwrite)
 {
-	dir_entry *retdent;
-	fsdata datablock = { .fatbuf = NULL, };
-	fsdata *mydata = &datablock;
-	fat_itr *itr = NULL;
+	struct dir_entry *retdent;
+	struct fsdata datablock = { .fatbuf = NULL, };
+	struct fsdata *mydata = &datablock;
+	struct fat_itr *itr = NULL;
 	int ret = -1;
 	char *filename_copy, *parent, *basename;
 	char l_filename[VFAT_MAXLEN_BYTES];
@@ -1499,7 +1500,7 @@ int file_fat_write_at(const char *filename, loff_t pos, void *buffer,
 		goto exit;
 	}
 
-	itr = malloc_cache_aligned(sizeof(fat_itr));
+	itr = malloc_cache_aligned(sizeof(struct fat_itr));
 	if (!itr) {
 		ret = -ENOMEM;
 		goto exit;
@@ -1585,21 +1586,21 @@ int file_fat_write(const char *filename, void *buffer, loff_t offset,
 	return file_fat_write_at(filename, offset, buffer, maxsize, actwrite);
 }
 
-static int fat_dir_entries(fat_itr *itr)
+static int fat_dir_entries(struct fat_itr *itr)
 {
-	fat_itr *dirs;
-	fsdata fsdata = { .fatbuf = NULL, }, *mydata = &fsdata;
+	struct fat_itr *dirs;
+	struct fsdata fsdata = { .fatbuf = NULL, }, *mydata = &fsdata;
 						/* for FATBUFSIZE */
 	int count;
 
-	dirs = malloc_cache_aligned(sizeof(fat_itr));
+	dirs = malloc_cache_aligned(sizeof(struct fat_itr));
 	if (!dirs) {
 		debug("Error: allocating memory\n");
 		count = -ENOMEM;
 		goto exit;
 	}
 
-	/* duplicate fsdata */
+	/* duplicate struct fsdata */
 	fat_itr_child(dirs, itr);
 	fsdata = *dirs->fsdata;
 
@@ -1628,7 +1629,7 @@ exit:
  * @itr:	directory iterator
  * Return:	0 for success
  */
-static int delete_single_dentry(fat_itr *itr)
+static int delete_single_dentry(struct fat_itr *itr)
 {
 	struct dir_entry *dent = itr->dent;
 
@@ -1646,7 +1647,7 @@ static int delete_single_dentry(fat_itr *itr)
  * @itr:	directory iterator
  * Return:	0 for success
  */
-static int delete_long_name(fat_itr *itr)
+static int delete_long_name(struct fat_itr *itr)
 {
 	int seqn = itr->dent->nameext.name[0] & ~LAST_LONG_ENTRY_MASK;
 
@@ -1671,7 +1672,7 @@ static int delete_long_name(fat_itr *itr)
  * @itr:	the first directory entry (if a longname) to remove
  * Return:	0 for success
  */
-static int delete_dentry_link(fat_itr *itr)
+static int delete_dentry_link(struct fat_itr *itr)
 {
 	int ret;
 
@@ -1700,10 +1701,10 @@ static int delete_dentry_link(fat_itr *itr)
  * @itr:	directory iterator
  * Return:	0 for success
  */
-static int delete_dentry_long(fat_itr *itr)
+static int delete_dentry_long(struct fat_itr *itr)
 {
-	fsdata *mydata = itr->fsdata;
-	dir_entry *dent = itr->dent;
+	struct fsdata *mydata = itr->fsdata;
+	struct dir_entry *dent = itr->dent;
 
 	/* free cluster blocks */
 	clear_fatent(mydata, START(dent));
@@ -1724,13 +1725,13 @@ static int delete_dentry_long(fat_itr *itr)
 
 int fat_unlink(const char *filename)
 {
-	fsdata fsdata = { .fatbuf = NULL, };
-	fat_itr *itr = NULL;
+	struct fsdata fsdata = { .fatbuf = NULL, };
+	struct fat_itr *itr = NULL;
 	int n_entries, ret;
 	char *filename_copy, *dirname, *basename;
 
 	filename_copy = strdup(filename);
-	itr = malloc_cache_aligned(sizeof(fat_itr));
+	itr = malloc_cache_aligned(sizeof(struct fat_itr));
 	if (!itr || !filename_copy) {
 		printf("Error: out of memory\n");
 		ret = -ENOMEM;
@@ -1789,16 +1790,16 @@ exit:
 
 int fat_mkdir(const char *dirname)
 {
-	dir_entry *retdent;
-	fsdata datablock = { .fatbuf = NULL, };
-	fsdata *mydata = &datablock;
-	fat_itr *itr = NULL;
+	struct dir_entry *retdent;
+	struct fsdata datablock = { .fatbuf = NULL, };
+	struct fsdata *mydata = &datablock;
+	struct fat_itr *itr = NULL;
 	char *dirname_copy, *parent, *basename;
 	char l_dirname[VFAT_MAXLEN_BYTES];
 	int ret = -1;
 	loff_t actwrite;
 	unsigned int bytesperclust;
-	dir_entry *dotdent = NULL;
+	struct dir_entry *dotdent = NULL;
 
 	dirname_copy = strdup(dirname);
 	if (!dirname_copy)
@@ -1816,7 +1817,7 @@ int fat_mkdir(const char *dirname)
 		goto exit;
 	}
 
-	itr = malloc_cache_aligned(sizeof(fat_itr));
+	itr = malloc_cache_aligned(sizeof(struct fat_itr));
 	if (!itr) {
 		ret = -ENOMEM;
 		goto exit;
@@ -1926,13 +1927,13 @@ exit:
  * Return:	-errno on error, 0 if path_itr does not have the directory
  * at prefix_clust as an ancestor.
  */
-static int check_path_prefix(loff_t prefix_clust, fat_itr *path_itr)
+static int check_path_prefix(loff_t prefix_clust, struct fat_itr *path_itr)
 {
-	fat_itr itr;
-	fsdata fsdata = { .fatbuf = NULL, }, *mydata = &fsdata;
+	struct fat_itr itr;
+	struct fsdata fsdata = { .fatbuf = NULL, }, *mydata = &fsdata;
 	int ret;
 
-	/* duplicate fsdata */
+	/* duplicate struct fsdata */
 	itr = *path_itr;
 	fsdata = *itr.fsdata;
 
@@ -1987,24 +1988,24 @@ exit:
  */
 int fat_rename(const char *old_path, const char *new_path)
 {
-	fat_itr *old_itr = NULL, *new_itr = NULL;
-	fsdata old_datablock = { .fatbuf = NULL, };
-	fsdata new_datablock = { .fatbuf = NULL, };
+	struct fat_itr *old_itr = NULL, *new_itr = NULL;
+	struct fsdata old_datablock = { .fatbuf = NULL, };
+	struct fsdata new_datablock = { .fatbuf = NULL, };
 	/* used for START macro */
-	fsdata *mydata = &old_datablock;
+	struct fsdata *mydata = &old_datablock;
 	int ret = -EIO, is_old_dir;
 	char *old_path_copy, *old_dirname, *old_basename;
 	char *new_path_copy, *new_dirname, *new_basename;
 	char l_new_basename[VFAT_MAXLEN_BYTES];
 	__u32 old_clust;
-	dir_entry *found_existing;
+	struct dir_entry *found_existing;
 	/* only set if found_existing != NULL */
 	__u32 new_clust;
 
 	old_path_copy = strdup(old_path);
 	new_path_copy = strdup(new_path);
-	old_itr = malloc_cache_aligned(sizeof(fat_itr));
-	new_itr = malloc_cache_aligned(sizeof(fat_itr));
+	old_itr = malloc_cache_aligned(sizeof(struct fat_itr));
+	new_itr = malloc_cache_aligned(sizeof(struct fat_itr));
 	if (!old_path_copy || !new_path_copy || !old_itr || !new_itr) {
 		log_debug("Error: out of memory\n");
 		ret = -ENOMEM;
@@ -2144,7 +2145,7 @@ int fat_rename(const char *old_path, const char *new_path)
 	/* update moved directory so the parent is new_path */
 	if (is_old_dir) {
 		__u32 clust = new_itr->start_clust;
-		dir_entry *dent;
+		struct dir_entry *dent;
 
 		fat_itr_child(new_itr, new_itr);
 		dent = find_directory_entry(new_itr, "..");
diff --git a/include/fat.h b/include/fat.h
index bdf430f7067..3e6065f845b 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -83,7 +83,7 @@ struct disk_partition;
 					((fatsize) != 16 ? 0xff0 : 0xfff0) : \
 					0xffffff0))
 
-typedef struct boot_sector {
+struct boot_sector {
 	__u8	ignored[3];	/* Bootstrap code */
 	char	system_id[8];	/* Name of fs */
 	__u8	sector_size[2];	/* Bytes/sector */
@@ -107,10 +107,9 @@ typedef struct boot_sector {
 	__u16	info_sector;	/* Filesystem info sector */
 	__u16	backup_boot;	/* Backup boot sector */
 	__u16	reserved2[6];	/* Unused */
-} boot_sector;
+};
 
-typedef struct volume_info
-{
+struct volume_info {
 	__u8 drive_number;	/* BIOS drive number */
 	__u8 reserved;		/* Unused */
 	__u8 ext_boot_sign;	/* 0x29 if fields below exist (DOS 3.3+) */
@@ -119,7 +118,7 @@ typedef struct volume_info
 	char fs_type[8];	/* Typically FAT12, FAT16, or FAT32 */
 	/* Boot code comes next, all but 2 bytes to fill up sector */
 	/* Boot sign comes last, 2 bytes */
-} volume_info;
+};
 
 /* see dir_entry::lcase: */
 #define CASE_LOWER_BASE	8	/* base (name) is lower case */
@@ -130,7 +129,7 @@ struct nameext {
 	char ext[3];
 };
 
-typedef struct dir_entry {
+struct dir_entry {
 	struct nameext nameext;	/* Name and extension */
 	__u8	attr;		/* Attribute bits */
 	__u8	lcase;		/* Case for name and ext (CASE_LOWER_x) */
@@ -141,9 +140,9 @@ typedef struct dir_entry {
 	__u16	starthi;	/* High 16 bits of cluster in FAT32 */
 	__u16	time,date,start;/* Time, date and first cluster */
 	__u32	size;		/* File size in bytes */
-} dir_entry;
+};
 
-typedef struct dir_slot {
+struct dir_slot {
 	__u8	id;		/* Sequence number for slot */
 	__u8	name0_4[10];	/* First 5 characters in name */
 	__u8	attr;		/* Attribute byte */
@@ -152,7 +151,7 @@ typedef struct dir_slot {
 	__u8	name5_10[12];	/* 6 more characters in name */
 	__u16	start;		/* Unused */
 	__u8	name11_12[4];	/* Last 2 characters in name */
-} dir_slot;
+};
 
 /*
  * Private filesystem parameters
@@ -160,7 +159,7 @@ typedef struct dir_slot {
  * Note: FAT buffer has to be 32 bit aligned
  * (see FAT32 accesses)
  */
-typedef struct {
+struct fsdata {
 	__u8	*fatbuf;	/* Current FAT buffer */
 	int	fatsize;	/* Size of FAT in bits */
 	__u32	fatlength;	/* Length of FAT in sectors */
@@ -175,17 +174,16 @@ typedef struct {
 	__u32	root_cluster;	/* First cluster of root dir for FAT32 */
 	u32	total_sect;	/* Number of sectors */
 	int	fats;		/* Number of FATs */
-} fsdata;
+};
 
 struct fat_itr;
-typedef struct fat_itr fat_itr;
 
-static inline u32 clust_to_sect(fsdata *fsdata, u32 clust)
+static inline u32 clust_to_sect(struct fsdata *fsdata, u32 clust)
 {
 	return fsdata->data_begin + clust * fsdata->clust_size;
 }
 
-static inline u32 sect_to_clust(fsdata *fsdata, int sect)
+static inline u32 sect_to_clust(struct fsdata *fsdata, int sect)
 {
 	return (sect - fsdata->data_begin) / fsdata->clust_size;
 }
@@ -208,7 +206,7 @@ int fat_unlink(const char *filename);
 int fat_rename(const char *old_path, const char *new_path);
 int fat_mkdir(const char *dirname);
 void fat_close(void);
-void *fat_next_cluster(fat_itr *itr, unsigned int *nbytes);
+void *fat_next_cluster(struct fat_itr *itr, unsigned int *nbytes);
 
 /**
  * fat_uuid() - get FAT volume ID
-- 
2.51.0

