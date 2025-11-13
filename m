Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC83CD4F28
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 06:48:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B728783D77;
	Thu, 13 Nov 2025 07:47:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="I+0c6wTp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A36183DEE; Thu, 13 Nov 2025 07:47:33 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0247B83DBD
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
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5C9E340A17; 
 Thu, 13 Nov 2025 06:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763016449;
 bh=LTDrID5Kvw2VH6EUhlVmMYat64IXkyka8OkyMrNGm8E=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=I+0c6wTps+KcXYD7b/ejma4CuiU0UHcF4+rogRZSUP8oLPbS1FNefuSZmrC1d+WSZ
 g32nae82jXu1B+RdxEoOBtn3hyyT3dHtQGM2l8rVSx5pFoK7EVHiu3tz2CeqSx3gyD
 PmpgjFXQ4CBcmKW9pKj7VdynMpnrkcCnwGdXIFzcd4Aih3FyaGmXypGew2vhfqFmHr
 nOF5B3RoVvpRCoQkRhoSsHpvyE0XiMYpU3R3honv+UwbyOS/EpwpYEjzW/sVyScuvK
 MPCpvDbg2rc9wrbP4yaCfTZomVsOxz6UiUQsUAg8T7lms7jzc9D3U100Ztn9oIa+uC
 IZTaJyT0ISl9Wc7H2F+JqPfZ49NaUaDskPmLgt0a4yGclQTr8oY7z9EtiyUgK6cR1T
 FuPhaenULx5+eEVxE0biN7Sj4zyiJuf5HxUydhcM8JkAMyHqyfF1OVEJrL0uvsKLvh
 yXpLldilRpPh9dVtQVeLPjqDGoJKjVff//0rbr8zLcyl1eEK2Kbo0qI0aEWmQBSLKh
 HE5cgv5tU6IPjm4mIlSn6Swqs+KEivIlr0BnwPX/kZv5NrqDqMGS6F+Ct+NCdTn4oq
 ybS3UwVRaOYcHldKFrPKyS+b1xHOaihNKsacJjnxxi1GmybilIZgtwIyl8mJ9Y9UI7
 pNveieUJ3Z0q4nW4QBlvn6m0=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <simon.glass@canonical.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Claude <noreply@anthropic.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 5/6] fat: Convert fat.h to kernel-doc style
Date: Thu, 13 Nov 2025 07:46:55 +0100
Message-ID: <20251113064656.245394-6-heinrich.schuchardt@canonical.com>
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

Add kernel-doc comments to structs and public functions in fat.h so that
it is easier to understand the code.

Co-developed-by: Claude <noreply@anthropic.com>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 include/fat.h | 349 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 284 insertions(+), 65 deletions(-)

diff --git a/include/fat.h b/include/fat.h
index 3e6065f845b..f6b31b2de49 100644
--- a/include/fat.h
+++ b/include/fat.h
@@ -83,129 +83,348 @@ struct disk_partition;
 					((fatsize) != 16 ? 0xff0 : 0xfff0) : \
 					0xffffff0))
 
+/**
+ * struct boot_sector - FAT boot sector structure
+ * @ignored: bootstrap code (first 3 bytes)
+ * @system_id: name of filesystem (8 bytes)
+ * @sector_size: bytes per sector
+ * @cluster_size: sectors per cluster
+ * @reserved: number of reserved sectors
+ * @fats: number of FAT copies
+ * @dir_entries: number of root directory entries
+ * @sectors: number of sectors (for small disks)
+ * @media: media descriptor code
+ * @fat_length: sectors per FAT (for FAT12/16)
+ * @secs_track: sectors per track
+ * @heads: number of heads
+ * @hidden: number of hidden sectors
+ * @total_sect: total number of sectors (for larger disks)
+ * @fat32_length: sectors per FAT (FAT32 only)
+ * @flags: flags (bit 8: fat mirroring, low 4: active fat)
+ * @version: filesystem version (FAT32 only)
+ * @root_cluster: first cluster of root directory (FAT32 only)
+ * @info_sector: filesystem info sector (FAT32 only)
+ * @backup_boot: backup boot sector location (FAT32 only)
+ * @reserved2: unused (FAT32 only)
+ */
 struct boot_sector {
-	__u8	ignored[3];	/* Bootstrap code */
-	char	system_id[8];	/* Name of fs */
-	__u8	sector_size[2];	/* Bytes/sector */
-	__u8	cluster_size;	/* Sectors/cluster */
-	__u16	reserved;	/* Number of reserved sectors */
-	__u8	fats;		/* Number of FATs */
-	__u8	dir_entries[2];	/* Number of root directory entries */
-	__u8	sectors[2];	/* Number of sectors */
-	__u8	media;		/* Media code */
-	__u16	fat_length;	/* Sectors/FAT */
-	__u16	secs_track;	/* Sectors/track */
-	__u16	heads;		/* Number of heads */
-	__u32	hidden;		/* Number of hidden sectors */
-	__u32	total_sect;	/* Number of sectors (if sectors == 0) */
+	__u8	ignored[3];
+	char	system_id[8];
+	__u8	sector_size[2];
+	__u8	cluster_size;
+	__u16	reserved;
+	__u8	fats;
+	__u8	dir_entries[2];
+	__u8	sectors[2];
+	__u8	media;
+	__u16	fat_length;
+	__u16	secs_track;
+	__u16	heads;
+	__u32	hidden;
+	__u32	total_sect;
 
 	/* FAT32 only */
-	__u32	fat32_length;	/* Sectors/FAT */
-	__u16	flags;		/* Bit 8: fat mirroring, low 4: active fat */
-	__u8	version[2];	/* Filesystem version */
-	__u32	root_cluster;	/* First cluster in root directory */
-	__u16	info_sector;	/* Filesystem info sector */
-	__u16	backup_boot;	/* Backup boot sector */
-	__u16	reserved2[6];	/* Unused */
+	__u32	fat32_length;
+	__u16	flags;
+	__u8	version[2];
+	__u32	root_cluster;
+	__u16	info_sector;
+	__u16	backup_boot;
+	__u16	reserved2[6];
 };
 
+/**
+ * struct volume_info - FAT volume information structure
+ * @drive_number: BIOS drive number
+ * @reserved: unused field
+ * @ext_boot_sign: extended boot signature (0x29 if fields below exist)
+ * @volume_id: volume serial number (4 bytes)
+ * @volume_label: volume label (11 bytes, padded with spaces)
+ * @fs_type: filesystem type string (typically "FAT12", "FAT16", or "FAT32")
+ *
+ * This structure is part of the boot sector, located after the common fields.
+ * Boot code follows this structure, with boot signature at the end of sector.
+ */
 struct volume_info {
-	__u8 drive_number;	/* BIOS drive number */
-	__u8 reserved;		/* Unused */
-	__u8 ext_boot_sign;	/* 0x29 if fields below exist (DOS 3.3+) */
-	__u8 volume_id[4];	/* Volume ID number */
-	char volume_label[11];	/* Volume label */
-	char fs_type[8];	/* Typically FAT12, FAT16, or FAT32 */
-	/* Boot code comes next, all but 2 bytes to fill up sector */
-	/* Boot sign comes last, 2 bytes */
+	__u8 drive_number;
+	__u8 reserved;
+	__u8 ext_boot_sign;
+	__u8 volume_id[4];
+	char volume_label[11];
+	char fs_type[8];
 };
 
 /* see dir_entry::lcase: */
 #define CASE_LOWER_BASE	8	/* base (name) is lower case */
 #define CASE_LOWER_EXT	16	/* extension is lower case */
 
+/**
+ * struct nameext - 8.3 filename components
+ * @name: filename (8 bytes)
+ * @ext: extension (3 bytes)
+ */
 struct nameext {
 	char name[8];
 	char ext[3];
 };
 
+/**
+ * struct dir_entry - FAT directory entry
+ * @nameext: filename and extension (8.3 format)
+ * @attr: file attributes (ATTR_* flags)
+ * @lcase: case flags for name and extension (CASE_LOWER_* flags)
+ * @ctime_ms: creation time (milliseconds)
+ * @ctime: creation time (hours, minutes, seconds)
+ * @cdate: creation date
+ * @adate: last access date
+ * @starthi: high 16 bits of cluster number (FAT32 only)
+ * @time: modification time
+ * @date: modification date
+ * @start: low 16 bits of cluster number
+ * @size: file size in bytes
+ */
 struct dir_entry {
-	struct nameext nameext;	/* Name and extension */
-	__u8	attr;		/* Attribute bits */
-	__u8	lcase;		/* Case for name and ext (CASE_LOWER_x) */
-	__u8	ctime_ms;	/* Creation time, milliseconds */
-	__u16	ctime;		/* Creation time */
-	__u16	cdate;		/* Creation date */
-	__u16	adate;		/* Last access date */
-	__u16	starthi;	/* High 16 bits of cluster in FAT32 */
-	__u16	time,date,start;/* Time, date and first cluster */
-	__u32	size;		/* File size in bytes */
+	struct nameext nameext;
+	__u8	attr;
+	__u8	lcase;
+	__u8	ctime_ms;
+	__u16	ctime;
+	__u16	cdate;
+	__u16	adate;
+	__u16	starthi;
+	__u16	time;
+	__u16	date;
+	__u16	start;
+	__u32	size;
 };
 
+/**
+ * struct dir_slot - VFAT long filename entry
+ * @id: sequence number (bit 6 = last entry, bits 0-4 = sequence)
+ * @name0_4: characters 0-4 of long filename (UTF-16LE)
+ * @attr: must be ATTR_VFAT (0x0F)
+ * @reserved: unused field
+ * @alias_checksum: checksum of 8.3 alias for this long name
+ * @name5_10: characters 5-10 of long filename (UTF-16LE)
+ * @start: unused (always 0)
+ * @name11_12: characters 11-12 of long filename (UTF-16LE)
+ *
+ * Long filename entries precede the corresponding short entry in directory.
+ * Multiple entries may be used to store names longer than 13 characters.
+ */
 struct dir_slot {
-	__u8	id;		/* Sequence number for slot */
-	__u8	name0_4[10];	/* First 5 characters in name */
-	__u8	attr;		/* Attribute byte */
-	__u8	reserved;	/* Unused */
-	__u8	alias_checksum;/* Checksum for 8.3 alias */
-	__u8	name5_10[12];	/* 6 more characters in name */
-	__u16	start;		/* Unused */
-	__u8	name11_12[4];	/* Last 2 characters in name */
+	__u8	id;
+	__u8	name0_4[10];
+	__u8	attr;
+	__u8	reserved;
+	__u8	alias_checksum;
+	__u8	name5_10[12];
+	__u16	start;
+	__u8	name11_12[4];
 };
 
-/*
- * Private filesystem parameters
+/**
+ * struct fsdata - FAT filesystem instance data
+ * @fatbuf: buffer for reading/writing FAT (must be 32-bit aligned for FAT32)
+ * @fatsize: size of FAT in bits (12, 16, or 32)
+ * @fatlength: length of FAT in sectors
+ * @fat_sect: starting sector of the FAT
+ * @fat_dirty: flag indicating if fatbuf has been modified
+ * @rootdir_sect: starting sector of root directory
+ * @sect_size: size of sectors in bytes
+ * @clust_size: size of clusters in sectors
+ * @data_begin: sector offset of first data cluster (can be negative)
+ * @fatbufnum: currently buffered FAT sector number (init to -1)
+ * @rootdir_size: size of root directory in entries (for non-FAT32)
+ * @root_cluster: first cluster of root directory (FAT32 only)
+ * @total_sect: total number of sectors
+ * @fats: number of FAT copies
  *
- * Note: FAT buffer has to be 32 bit aligned
- * (see FAT32 accesses)
+ * This structure holds the runtime state of a mounted FAT filesystem.
+ * The fatbuf must be 32-bit aligned due to FAT32 sector access requirements.
  */
 struct fsdata {
-	__u8	*fatbuf;	/* Current FAT buffer */
-	int	fatsize;	/* Size of FAT in bits */
-	__u32	fatlength;	/* Length of FAT in sectors */
-	__u16	fat_sect;	/* Starting sector of the FAT */
-	__u8	fat_dirty;      /* Set if fatbuf has been modified */
-	__u32	rootdir_sect;	/* Start sector of root directory */
-	__u16	sect_size;	/* Size of sectors in bytes */
-	__u16	clust_size;	/* Size of clusters in sectors */
-	int	data_begin;	/* The sector of the first cluster, can be negative */
-	int	fatbufnum;	/* Used by get_fatent, init to -1 */
-	int	rootdir_size;	/* Size of root dir for non-FAT32 */
-	__u32	root_cluster;	/* First cluster of root dir for FAT32 */
-	u32	total_sect;	/* Number of sectors */
-	int	fats;		/* Number of FATs */
+	__u8	*fatbuf;
+	int	fatsize;
+	__u32	fatlength;
+	__u16	fat_sect;
+	__u8	fat_dirty;
+	__u32	rootdir_sect;
+	__u16	sect_size;
+	__u16	clust_size;
+	int	data_begin;
+	int	fatbufnum;
+	int	rootdir_size;
+	__u32	root_cluster;
+	u32	total_sect;
+	int	fats;
 };
 
 struct fat_itr;
 
+/**
+ * clust_to_sect() - convert cluster number to sector number
+ * @fsdata: filesystem instance data
+ * @clust: cluster number
+ *
+ * Return: sector number corresponding to the given cluster
+ */
 static inline u32 clust_to_sect(struct fsdata *fsdata, u32 clust)
 {
 	return fsdata->data_begin + clust * fsdata->clust_size;
 }
 
+/**
+ * sect_to_clust() - convert sector number to cluster number
+ * @fsdata: filesystem instance data
+ * @sect: sector number
+ *
+ * Return: cluster number corresponding to the given sector
+ */
 static inline u32 sect_to_clust(struct fsdata *fsdata, int sect)
 {
 	return (sect - fsdata->data_begin) / fsdata->clust_size;
 }
 
+/**
+ * file_fat_detectfs() - detect and initialize the FAT filesystem
+ *
+ * Return: 0 on success, -1 on error
+ */
 int file_fat_detectfs(void);
+
+/**
+ * fat_exists() - check if a file exists
+ * @filename: full path to file
+ *
+ * Return: 0 if file exists, -1 if not found or error
+ */
 int fat_exists(const char *filename);
+
+/**
+ * fat_size() - get the size of a file
+ * @filename: full path to file
+ * @size: pointer to store file size
+ *
+ * Return: 0 on success, -1 on error
+ */
 int fat_size(const char *filename, loff_t *size);
+
+/**
+ * file_fat_read() - read a file from FAT filesystem
+ * @filename: full path to file
+ * @buffer: buffer to read data into
+ * @maxsize: maximum number of bytes to read
+ *
+ * Return: number of bytes read, -1 on error
+ */
 int file_fat_read(const char *filename, void *buffer, int maxsize);
+
+/**
+ * fat_set_blk_dev() - set the block device and partition for FAT operations
+ * @rbdd: block device descriptor
+ * @info: partition information
+ *
+ * Return: 0 on success, -1 on error
+ */
 int fat_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info);
+
+/**
+ * fat_register_device() - register a FAT filesystem on a block device
+ * @dev_desc: block device descriptor
+ * @part_no: partition number (0 = whole device)
+ *
+ * Return: 0 on success, -1 on error
+ */
 int fat_register_device(struct blk_desc *dev_desc, int part_no);
 
+/**
+ * file_fat_write() - write to a file on FAT filesystem
+ * @filename: full path to file
+ * @buf: buffer containing data to write
+ * @offset: offset in file to start writing
+ * @len: number of bytes to write
+ * @actwrite: pointer to store actual number of bytes written
+ *
+ * Return: 0 on success, -1 on error
+ */
 int file_fat_write(const char *filename, void *buf, loff_t offset, loff_t len,
 		   loff_t *actwrite);
+
+/**
+ * fat_read_file() - read from a file on FAT filesystem
+ * @filename: full path to file
+ * @buf: buffer to read data into
+ * @offset: offset in file to start reading
+ * @len: number of bytes to read
+ * @actread: pointer to store actual number of bytes read
+ *
+ * Return: 0 on success, -1 on error
+ */
 int fat_read_file(const char *filename, void *buf, loff_t offset, loff_t len,
 		  loff_t *actread);
+
+/**
+ * fat_opendir() - open a directory for reading
+ * @filename: full path to directory
+ * @dirsp: pointer to store directory stream handle
+ *
+ * Return: 0 on success, -1 on error
+ */
 int fat_opendir(const char *filename, struct fs_dir_stream **dirsp);
+
+/**
+ * fat_readdir() - read next entry from directory
+ * @dirs: directory stream handle
+ * @dentp: pointer to store directory entry
+ *
+ * Return: 0 on success, -1 on error or end of directory
+ */
 int fat_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
+
+/**
+ * fat_closedir() - close a directory stream
+ * @dirs: directory stream handle
+ */
 void fat_closedir(struct fs_dir_stream *dirs);
+
+/**
+ * fat_unlink() - delete a file or empty directory
+ * @filename: full path to file or directory
+ *
+ * Return: 0 on success, -1 on error
+ */
 int fat_unlink(const char *filename);
+
+/**
+ * fat_rename() - rename a file or directory
+ * @old_path: current full path
+ * @new_path: new full path
+ *
+ * Return: 0 on success, -1 on error
+ */
 int fat_rename(const char *old_path, const char *new_path);
+
+/**
+ * fat_mkdir() - create a directory
+ * @dirname: full path to new directory
+ *
+ * Return: 0 on success, -1 on error
+ */
 int fat_mkdir(const char *dirname);
+
+/**
+ * fat_close() - close FAT filesystem and release resources
+ */
 void fat_close(void);
+
+/**
+ * fat_next_cluster() - get the next cluster in a chain
+ * @itr: directory iterator
+ * @nbytes: pointer to store number of bytes in cluster
+ *
+ * Return: pointer to cluster data buffer
+ */
 void *fat_next_cluster(struct fat_itr *itr, unsigned int *nbytes);
 
 /**
-- 
2.51.0

