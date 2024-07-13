Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE77BC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:26:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C055888D2;
	Sat, 13 Jul 2024 15:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="O/LK6QN1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="hDhKj0W4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2283888EA; Sat, 13 Jul 2024 15:21:41 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B83888C8
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WLpyV6X1Hz9sdG;
 Sat, 13 Jul 2024 15:21:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kv+69jE+m5iuQOtORvKQoPxWU6SS7VGCr1rwYZ3+ywQ=;
 b=O/LK6QN1uUzqIZV55LUHrTVakoAkmdRJMldymTDOhjEsy8zEuXY2UG08966QEIxLuvOmk/
 kBiygmZcSbJdEQm7VvpnZi/GocIzIq3oDkTiGlSXVTlsWa+grGkQd0SpADE3QT3ZF6tsor
 39u2SPD4b5YaK36gpEN963BREolIp3+//S0BjPGECso1r2RG9W7/t9D2zOR/JWhyq6EXek
 IY0MH6g1Hfc3WXQGcbdJxIR1IUx/3vLEObBXnS7+81So2Gx9ArZfzvE5yjGt8HO4JQ1L9L
 iFM0wAQtSc1CTf4Odo2n+NBUETfnTuEZ7LY7LJUhGTWYEJhoRDS5zYxEsHzsIA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876897;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kv+69jE+m5iuQOtORvKQoPxWU6SS7VGCr1rwYZ3+ywQ=;
 b=hDhKj0W4c0Odvzm3QQq6mcNvZXuTnK81xeH0E/Z5dzst8rCVqyL2/sCCzwD1I9VAT+6Mjt
 2/j+MgO0lcdNvj0E94jcLeGNpzMu56gSL/sViijsG986qDsqmfUOa7W5v94vkERMZhWuOY
 zgRl8eMHUH/IoVAdfPhf44YUR+zjXfBgan1PQGi7JjCwSxZZNO+Epysylzak5HWOPTvBoE
 Q8KDj3/VLc3vm1zU6O9RLDXEQDK+R2N0kcPLiMtqnEI0EyKoREKXBhiL1aphh2K7zlqM2T
 Gu8EaqNcgoARDdP2Ih2CQiXpH/KGCzl+wmaSQrweIDGKF/xC6HCxtVwxxiRuPQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 30/45] fs: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:21 +0200
Message-ID: <20240713132021.57650-30-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8fcdfee65b7f110b0b3
X-MBO-RS-META: xns1nqd914xow94pd3rstk4hoz4wcswz
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 fs/btrfs/ctree.h                    |  1 -
 fs/btrfs/disk-io.c                  |  1 -
 fs/btrfs/kernel-shared/btrfs_tree.h |  5 -----
 fs/btrfs/volumes.c                  |  1 -
 fs/ext4/ext4_common.c               |  2 --
 fs/ext4/ext4_write.c                |  2 --
 fs/jffs2/compr_lzo.c                |  1 -
 fs/jffs2/compr_rubin.c              |  1 -
 fs/jffs2/jffs2_1pass.c              | 12 ------------
 fs/jffs2/jffs2_private.h            |  1 -
 fs/jffs2/mini_inflate.c             |  2 --
 fs/ubifs/super.c                    |  1 -
 fs/ubifs/ubifs.c                    |  1 -
 fs/yaffs2/yaffs_attribs.c           |  2 --
 fs/yaffs2/yaffs_ecc.c               |  1 -
 fs/yaffs2/yaffs_flashif.h           |  1 -
 fs/yaffs2/yaffs_flashif2.h          |  1 -
 fs/yaffs2/yaffs_guts.c              | 13 -------------
 fs/yaffs2/yaffs_guts.h              |  4 ----
 fs/yaffs2/yaffs_mtdif.c             |  4 ----
 fs/yaffs2/yaffs_mtdif2.c            |  2 --
 fs/yaffs2/yaffs_nandif.c            |  6 ------
 fs/yaffs2/yaffs_nandif.h            |  2 --
 fs/yaffs2/yaffs_osglue.h            |  3 ---
 fs/yaffs2/yaffs_summary.c           |  4 ----
 fs/yaffs2/yaffs_summary.h           |  2 --
 fs/yaffs2/yaffs_tagscompat.c        |  1 -
 fs/yaffs2/yaffs_uboot_glue.c        | 10 ----------
 fs/yaffs2/yaffs_verify.c            |  1 -
 fs/yaffs2/yaffs_yaffs2.c            |  1 -
 fs/yaffs2/yaffscfg.h                |  4 ----
 fs/yaffs2/yaffsfs.c                 |  1 -
 fs/yaffs2/yaffsfs.h                 | 10 ----------
 fs/yaffs2/ydirectenv.h              |  4 ----
 fs/yaffs2/yportenv.h                |  9 ---------
 fs/zfs/dev.c                        |  1 -
 fs/zfs/zfs.c                        | 19 -------------------
 37 files changed, 137 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 59439552a45..b7be09d5df8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -461,7 +461,6 @@ static inline u8 *btrfs_dev_extent_chunk_tree_uuid(struct btrfs_dev_extent *dev)
 	return (u8 *)((unsigned long)dev + ptr);
 }
 
-
 /* struct btrfs_extent_item */
 BTRFS_SETGET_FUNCS(extent_refs, struct btrfs_extent_item, refs, 64);
 BTRFS_SETGET_STACK_FUNCS(stack_extent_refs, struct btrfs_extent_item, refs, 64);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e5bfaf461c2..34d9d535121 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -69,7 +69,6 @@ static int check_tree_block(struct btrfs_fs_info *fs_info,
 						    btrfs_header_fsid(),
 						    BTRFS_FSID_SIZE);
 
-
 		if (fsid_match) {
 			ret = 0;
 			break;
diff --git a/fs/btrfs/kernel-shared/btrfs_tree.h b/fs/btrfs/kernel-shared/btrfs_tree.h
index d8eff0b9122..f9dc005c50b 100644
--- a/fs/btrfs/kernel-shared/btrfs_tree.h
+++ b/fs/btrfs/kernel-shared/btrfs_tree.h
@@ -115,7 +115,6 @@
 #define BTRFS_LAST_FREE_OBJECTID -256ULL
 #define BTRFS_FIRST_CHUNK_TREE_OBJECTID 256ULL
 
-
 /*
  * The device items go into the chunk tree.
  *
@@ -333,7 +332,6 @@
  */
 #define BTRFS_STRING_ITEM_KEY	253
 
-
 /* 32 bytes in various csum fields */
 #define BTRFS_CSUM_SIZE 32
 
@@ -508,7 +506,6 @@ struct btrfs_free_space_header {
 #define BTRFS_SUPER_FLAG_CHANGING_FSID	(1ULL << 35)
 #define BTRFS_SUPER_FLAG_CHANGING_FSID_V2 (1ULL << 36)
 
-
 /*
  * Items in the extent tree are used to record the objectid of the
  * owner of the block and the number of references.
@@ -523,7 +520,6 @@ struct btrfs_extent_item_v0 {
 	__le32 refs;
 } __attribute__ ((__packed__));
 
-
 #define BTRFS_EXTENT_FLAG_DATA		(1ULL << 0)
 #define BTRFS_EXTENT_FLAG_TREE_BLOCK	(1ULL << 1)
 
@@ -565,7 +561,6 @@ struct btrfs_extent_ref_v0 {
 	__le32 count;
 } __attribute__ ((__packed__));
 
-
 /* Dev extents record used space on individual devices.
  *
  * The owner field points back to the chunk allocation mapping tree that
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8ec545eded7..5726981b19c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -255,7 +255,6 @@ static int device_list_add(struct btrfs_super_block *disk_super,
 		}
 	}
 
-
 	if (found_transid > fs_devices->latest_trans) {
 		fs_devices->latest_devid = devid;
 		fs_devices->latest_trans = found_transid;
diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 857c15d878e..52152a2295a 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -1205,7 +1205,6 @@ fail:
 
 }
 
-
 static void alloc_single_indirect_block(struct ext2_inode *file_inode,
 					unsigned int *total_remaining_blocks,
 					unsigned int *no_blks_reqd)
@@ -2380,7 +2379,6 @@ int ext4fs_mount(void)
 	if (le16_to_cpu(data->sblock.magic) != EXT2_MAGIC)
 		goto fail_noerr;
 
-
 	if (le32_to_cpu(data->sblock.revision_level) == 0) {
 		fs->inodesz = 128;
 		fs->gdsize = 32;
diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 38da3923c47..a2dfff81979 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -20,7 +20,6 @@
  * ext4write : Based on generic ext4 protocol.
  */
 
-
 #include <blk.h>
 #include <log.h>
 #include <malloc.h>
@@ -746,7 +745,6 @@ void ext4fs_deinit(void)
 		fs->inode_bmaps = NULL;
 	}
 
-
 	free(fs->gdtable);
 	fs->gdtable = NULL;
 	/*
diff --git a/fs/jffs2/compr_lzo.c b/fs/jffs2/compr_lzo.c
index e648ec4fb2e..892766e12eb 100644
--- a/fs/jffs2/compr_lzo.c
+++ b/fs/jffs2/compr_lzo.c
@@ -65,7 +65,6 @@
 
 */
 
-
 #include <config.h>
 #include <linux/stddef.h>
 #include <jffs2/jffs2.h>
diff --git a/fs/jffs2/compr_rubin.c b/fs/jffs2/compr_rubin.c
index 9ff22177382..88b65845997 100644
--- a/fs/jffs2/compr_rubin.c
+++ b/fs/jffs2/compr_rubin.c
@@ -42,7 +42,6 @@
 #include <jffs2/jffs2.h>
 #include <jffs2/compr_rubin.h>
 
-
 void rubin_do_decompress(unsigned char *bits, unsigned char *in,
 			 unsigned char *page_out, __u32 destlen)
 {
diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c
index 5b7d7f4ae88..b5f74d65017 100644
--- a/fs/jffs2/jffs2_1pass.c
+++ b/fs/jffs2/jffs2_1pass.c
@@ -110,7 +110,6 @@
  * it should probably be dumped and replaced by something like jffs2reader!
  */
 
-
 #include <config.h>
 #include <malloc.h>
 #include <div64.h>
@@ -126,7 +125,6 @@
 
 #include "jffs2_private.h"
 
-
 #define	NODE_CHUNK	1024	/* size of memory allocation chunk in b_nodes */
 #define	SPIN_BLKSIZE	18	/* spin after having scanned 1<<BLKSIZE bytes */
 
@@ -135,7 +133,6 @@
 #undef	DEBUG_FRAGMENTS		/* print fragment list after scan */
 #undef	DEBUG			/* enable debugging messages */
 
-
 #ifdef  DEBUG
 # define DEBUGF(fmt,args...)	printf(fmt ,##args)
 #else
@@ -370,14 +367,12 @@ static void *get_node_mem_onenand(u32 off, void *ext_buf)
 	return ret;
 }
 
-
 static void put_fl_mem_onenand(void *buf)
 {
 	free(buf);
 }
 #endif
 
-
 #if defined(CONFIG_CMD_FLASH)
 #include <flash.h>
 
@@ -414,7 +409,6 @@ static inline void *get_node_mem_nor(u32 off, void *ext_buf)
 }
 #endif
 
-
 /*
  * Generic jffs2 raw memory and node read routines.
  *
@@ -515,7 +509,6 @@ struct mem_block {
 	struct b_node nodes[NODE_CHUNK];
 };
 
-
 static void
 free_nodes(struct b_list *list)
 {
@@ -1854,7 +1847,6 @@ jffs2_1pass_build_lists(struct part_info * part)
 	return 1;
 }
 
-
 static u32
 jffs2_1pass_fill_info(struct b_lists * pL, struct b_jffs2_info * piL)
 {
@@ -1883,7 +1875,6 @@ jffs2_1pass_fill_info(struct b_lists * pL, struct b_jffs2_info * piL)
 	return 0;
 }
 
-
 static struct b_lists *
 jffs2_get_list(struct part_info * part, const char *who)
 {
@@ -1899,7 +1890,6 @@ jffs2_get_list(struct part_info * part, const char *who)
 	return (struct b_lists *)part->jffs2_priv;
 }
 
-
 /* Print directory / file contents */
 u32
 jffs2_1pass_ls(struct part_info * part, const char *fname)
@@ -1916,7 +1906,6 @@ jffs2_1pass_ls(struct part_info * part, const char *fname)
 		return 0;
 	}
 
-
 #if 0
 	putLabeledWord("found file at inode = ", inode);
 	putLabeledWord("read_inode returns = ", ret);
@@ -1925,7 +1914,6 @@ jffs2_1pass_ls(struct part_info * part, const char *fname)
 	return ret;
 }
 
-
 /* Load a file from flash into memory. fname can be a full path */
 u32
 jffs2_1pass_load(char *dest, struct part_info * part, const char *fname)
diff --git a/fs/jffs2/jffs2_private.h b/fs/jffs2/jffs2_private.h
index 65d19a76f97..9284ab5c2c1 100644
--- a/fs/jffs2/jffs2_private.h
+++ b/fs/jffs2/jffs2_private.h
@@ -3,7 +3,6 @@
 
 #include <jffs2/jffs2.h>
 
-
 struct b_node {
 	u32 offset;
 	struct b_node *next;
diff --git a/fs/jffs2/mini_inflate.c b/fs/jffs2/mini_inflate.c
index 3072eedd8c1..12ab180d2f0 100644
--- a/fs/jffs2/mini_inflate.c
+++ b/fs/jffs2/mini_inflate.c
@@ -336,11 +336,9 @@ static void decompress_fixed(struct bitstream *stream, unsigned char *dest)
 	cramfs_memset(distance->lengths, 5, 32);
 	distance->count[5] = 32;
 
-
 	fill_code_tables(lengths);
 	fill_code_tables(distance);
 
-
 	decompress_huffman(stream, dest);
 }
 
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 788f88f0495..d8d78a2d3d6 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2452,7 +2452,6 @@ retry:
 
 EXPORT_SYMBOL(sget);
 
-
 static struct dentry *ubifs_mount(struct file_system_type *fs_type, int flags,
 			const char *name, void *data)
 {
diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index f0ea7e5c168..048730db7ff 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -110,7 +110,6 @@ static struct ubifs_compressor zstd_compr = {
 /* All UBIFS compressors */
 struct ubifs_compressor *ubifs_compressors[UBIFS_COMPR_TYPES_CNT] = {NULL};
 
-
 #ifdef __UBOOT__
 
 struct crypto_comp {
diff --git a/fs/yaffs2/yaffs_attribs.c b/fs/yaffs2/yaffs_attribs.c
index 69664268e14..81927cb9437 100644
--- a/fs/yaffs2/yaffs_attribs.c
+++ b/fs/yaffs2/yaffs_attribs.c
@@ -13,7 +13,6 @@
 
 #include "yaffs_attribs.h"
 
-
 void yaffs_load_attribs(struct yaffs_obj *obj, struct yaffs_obj_hdr *oh)
 {
 	obj->yst_uid = oh->yst_uid;
@@ -24,7 +23,6 @@ void yaffs_load_attribs(struct yaffs_obj *obj, struct yaffs_obj_hdr *oh)
 	obj->yst_rdev = oh->yst_rdev;
 }
 
-
 void yaffs_load_attribs_oh(struct yaffs_obj_hdr *oh, struct yaffs_obj *obj)
 {
 #ifdef CONFIG_YAFFS_WINCE
diff --git a/fs/yaffs2/yaffs_ecc.c b/fs/yaffs2/yaffs_ecc.c
index 9294107c150..0860a3c7843 100644
--- a/fs/yaffs2/yaffs_ecc.c
+++ b/fs/yaffs2/yaffs_ecc.c
@@ -67,7 +67,6 @@ static const unsigned char column_parity_table[] = {
 	0x69, 0x3c, 0x30, 0x65, 0x0c, 0x59, 0x55, 0x00,
 };
 
-
 /* Calculate the ECC for a 256-byte block of data */
 void yaffs_ecc_calc(const unsigned char *data, unsigned char *ecc)
 {
diff --git a/fs/yaffs2/yaffs_flashif.h b/fs/yaffs2/yaffs_flashif.h
index e6e8979ee62..886901a0ff5 100644
--- a/fs/yaffs2/yaffs_flashif.h
+++ b/fs/yaffs2/yaffs_flashif.h
@@ -16,7 +16,6 @@
 #ifndef __YAFFS_FLASH_H__
 #define __YAFFS_FLASH_H__
 
-
 #include "yaffs_guts.h"
 int yflash_EraseBlockInNAND(struct yaffs_dev *dev, int blockNumber);
 int yflash_WriteChunkToNAND(struct yaffs_dev *dev, int nand_chunk,
diff --git a/fs/yaffs2/yaffs_flashif2.h b/fs/yaffs2/yaffs_flashif2.h
index cfdbde9dc8f..c69862668b1 100644
--- a/fs/yaffs2/yaffs_flashif2.h
+++ b/fs/yaffs2/yaffs_flashif2.h
@@ -16,7 +16,6 @@
 #ifndef __YAFFS_FLASH2_H__
 #define __YAFFS_FLASH2_H__
 
-
 #include "yaffs_guts.h"
 int yflash2_EraseBlockInNAND(struct yaffs_dev *dev, int blockNumber);
 int yflash2_WriteChunkToNAND(struct yaffs_dev *dev, int nand_chunk,
diff --git a/fs/yaffs2/yaffs_guts.c b/fs/yaffs2/yaffs_guts.c
index e13a73298b4..e89d02513c1 100644
--- a/fs/yaffs2/yaffs_guts.c
+++ b/fs/yaffs2/yaffs_guts.c
@@ -41,8 +41,6 @@
 static int yaffs_wr_data_obj(struct yaffs_obj *in, int inode_chunk,
 			     const u8 *buffer, int n_bytes, int use_reserve);
 
-
-
 /* Function to calculate chunk and offset */
 
 void yaffs_addr_to_chunk(struct yaffs_dev *dev, loff_t addr,
@@ -355,7 +353,6 @@ static int yaffs_verify_chunk_written(struct yaffs_dev *dev,
 	return retval;
 }
 
-
 int yaffs_check_alloc_available(struct yaffs_dev *dev, int n_chunks)
 {
 	int reserved_chunks;
@@ -1989,7 +1986,6 @@ static struct yaffs_obj *yaffs_create_fake_dir(struct yaffs_dev *dev,
 
 }
 
-
 static void yaffs_init_tnodes_and_objs(struct yaffs_dev *dev)
 {
 	int i;
@@ -2233,8 +2229,6 @@ struct yaffs_obj *yaffs_link_obj(struct yaffs_obj *parent, const YCHAR * name,
 
 }
 
-
-
 /*---------------------- Block Management and Page Allocation -------------*/
 
 static void yaffs_deinit_blocks(struct yaffs_dev *dev)
@@ -2292,7 +2286,6 @@ static int yaffs_init_blocks(struct yaffs_dev *dev)
 	if (!dev->chunk_bits)
 		goto alloc_error;
 
-
 	memset(dev->block_info, 0, n_blocks * sizeof(struct yaffs_block_info));
 	memset(dev->chunk_bits, 0, dev->chunk_bit_stride * n_blocks);
 	return YAFFS_OK;
@@ -2302,7 +2295,6 @@ alloc_error:
 	return YAFFS_FAIL;
 }
 
-
 void yaffs_block_became_dirty(struct yaffs_dev *dev, int block_no)
 {
 	struct yaffs_block_info *bi = yaffs_get_block_info(dev, block_no);
@@ -3036,8 +3028,6 @@ static int yaffs_wr_data_obj(struct yaffs_obj *in, int inode_chunk,
 
 }
 
-
-
 static int yaffs_do_xattrib_mod(struct yaffs_obj *obj, int set,
 				const YCHAR *name, const void *value, int size,
 				int flags)
@@ -3396,7 +3386,6 @@ int yaffs_update_oh(struct yaffs_obj *in, const YCHAR *name, int force,
 		bi->has_shrink_hdr = 1;
 	}
 
-
 	return new_chunk_id;
 }
 
@@ -3804,7 +3793,6 @@ int yaffs_flush_file(struct yaffs_obj *in, int update_time, int data_sync)
 				YAFFS_OK : YAFFS_FAIL;
 }
 
-
 /* yaffs_del_file deletes the whole file data
  * and the inode associated with the file.
  * It does not delete the links associated with the file.
@@ -4306,7 +4294,6 @@ static void yaffs_empty_l_n_f(struct yaffs_dev *dev)
 	yaffs_del_dir_contents(dev->lost_n_found);
 }
 
-
 struct yaffs_obj *yaffs_find_by_name(struct yaffs_obj *directory,
 				     const YCHAR *name)
 {
diff --git a/fs/yaffs2/yaffs_guts.h b/fs/yaffs2/yaffs_guts.h
index e3558c5a6d0..f4e7f796bd1 100644
--- a/fs/yaffs2/yaffs_guts.h
+++ b/fs/yaffs2/yaffs_guts.h
@@ -64,8 +64,6 @@
 #define YAFFS_MIN_YAFFS2_CHUNK_SIZE	1024
 #define YAFFS_MIN_YAFFS2_SPARE_SIZE	32
 
-
-
 #define YAFFS_ALLOCATION_NOBJECTS	100
 #define YAFFS_ALLOCATION_NTNODES	100
 #define YAFFS_ALLOCATION_NLINKS		100
@@ -155,7 +153,6 @@ union yaffs_tags_union {
 	u8 as_bytes[8];
 };
 
-
 /* Stuff used for extended tags in YAFFS2 */
 
 enum yaffs_ecc_result {
@@ -969,5 +966,4 @@ void yaffs_oh_size_load(struct yaffs_obj_hdr *oh, loff_t fsize);
 loff_t yaffs_oh_to_size(struct yaffs_obj_hdr *oh);
 loff_t yaffs_max_file_size(struct yaffs_dev *dev);
 
-
 #endif
diff --git a/fs/yaffs2/yaffs_mtdif.c b/fs/yaffs2/yaffs_mtdif.c
index 0eec22bc4a5..d4af0a329ee 100644
--- a/fs/yaffs2/yaffs_mtdif.c
+++ b/fs/yaffs2/yaffs_mtdif.c
@@ -15,7 +15,6 @@
 
 #include "yportenv.h"
 
-
 #include "yaffs_mtdif.h"
 
 #include <linux/mtd/mtd.h>
@@ -23,7 +22,6 @@
 #include <linux/time.h>
 #include <linux/mtd/rawnand.h>
 
-
 static inline void translate_spare2oob(const struct yaffs_spare *spare, u8 *oob)
 {
 	oob[0] = spare->tb0;
@@ -57,7 +55,6 @@ static inline void translate_oob2spare(struct yaffs_spare *spare, u8 *oob)
 	nspare->eccres1 = nspare->eccres2 = 0; /* FIXME */
 }
 
-
 int nandmtd_WriteChunkToNAND(struct yaffs_dev *dev, int chunkInNAND,
 			     const u8 *data, const struct yaffs_spare *spare)
 {
@@ -148,7 +145,6 @@ int nandmtd_EraseBlockInNAND(struct yaffs_dev *dev, int blockNumber)
 
 	/* Todo finish off the ei if required */
 
-
 	retval = mtd_erase(mtd, &ei);
 
 	if (retval == 0)
diff --git a/fs/yaffs2/yaffs_mtdif2.c b/fs/yaffs2/yaffs_mtdif2.c
index 2bf171f99f1..f21f15bfbd8 100644
--- a/fs/yaffs2/yaffs_mtdif2.c
+++ b/fs/yaffs2/yaffs_mtdif2.c
@@ -32,7 +32,6 @@
 #define yaffs_dev_to_mtd(dev) ((struct mtd_info *)((dev)->driver_context))
 #define yaffs_dev_to_lc(dev) ((struct yaffs_linux_context *)((dev)->os_context))
 
-
 /* NB For use with inband tags....
  * We assume that the data buffer is of size total_bytes_per_chunk so
  * that we can also use it to load the tags.
@@ -169,7 +168,6 @@ int nandmtd2_read_chunk_tags(struct yaffs_dev *dev, int nand_chunk,
 		return YAFFS_FAIL;
 }
 
-
 int nandmtd2_MarkNANDBlockBad(struct yaffs_dev *dev, int blockNo)
 {
 	struct mtd_info *mtd = (struct mtd_info *)(dev->driver_context);
diff --git a/fs/yaffs2/yaffs_nandif.c b/fs/yaffs2/yaffs_nandif.c
index ee5a1720607..632f4275518 100644
--- a/fs/yaffs2/yaffs_nandif.c
+++ b/fs/yaffs2/yaffs_nandif.c
@@ -15,7 +15,6 @@
 #include "yaffs_guts.h"
 #include <malloc.h>
 
-
 #include "yaffs_nandif.h"
 #include "yaffs_packedtags2.h"
 
@@ -24,7 +23,6 @@
 #include "yaffs_trace.h"
 #include "yaffsfs.h"
 
-
 /* NB For use with inband tags....
  * We assume that the data buffer is of size totalBytersPerChunk so that
  * we can also use it to load the tags.
@@ -44,7 +42,6 @@ int ynandif_WriteChunkWithTagsToNAND(struct yaffs_dev *dev, int nand_chunk,
 		"nandmtd2_WriteChunkWithTagsToNAND chunk %d data %p tags %p",
 		nand_chunk, data, tags);
 
-
 	/* For yaffs2 writing there must be both data and tags.
 	 * If we're using inband tags, then the tags are stuffed into
 	 * the end of the data buffer.
@@ -152,7 +149,6 @@ int ynandif_EraseBlockInNAND(struct yaffs_dev *dev, int blockId)
 
 }
 
-
 static int ynandif_IsBlockOk(struct yaffs_dev *dev, int blockId)
 {
 	struct ynandif_Geometry *geometry = (struct ynandif_Geometry *)(dev->driver_context);
@@ -186,7 +182,6 @@ int ynandif_QueryNANDBlock(struct yaffs_dev *dev, int blockId,
 	return YAFFS_OK;
 }
 
-
 int ynandif_InitialiseNAND(struct yaffs_dev *dev)
 {
 	struct ynandif_Geometry *geometry = (struct ynandif_Geometry *)(dev->driver_context);
@@ -205,7 +200,6 @@ int ynandif_Deinitialise_flash_fn(struct yaffs_dev *dev)
 	return YAFFS_OK;
 }
 
-
 struct yaffs_dev *
 	yaffs_add_dev_from_geometry(const YCHAR *name,
 					const struct ynandif_Geometry *geometry)
diff --git a/fs/yaffs2/yaffs_nandif.h b/fs/yaffs2/yaffs_nandif.h
index e780f7f3b40..6454cea20a0 100644
--- a/fs/yaffs2/yaffs_nandif.h
+++ b/fs/yaffs2/yaffs_nandif.h
@@ -13,7 +13,6 @@
  * Note: Only YAFFS headers are LGPL, YAFFS C code is covered by GPL.
  */
 
-
 #ifndef __YNANDIF_H__
 #define __YNANDIF_H__
 
@@ -61,5 +60,4 @@ struct yaffs_dev *
 	yaffs_add_dev_from_geometry(const YCHAR *name,
 					const struct ynandif_Geometry *geometry);
 
-
 #endif
diff --git a/fs/yaffs2/yaffs_osglue.h b/fs/yaffs2/yaffs_osglue.h
index f629a4b59e8..c2bb682c92f 100644
--- a/fs/yaffs2/yaffs_osglue.h
+++ b/fs/yaffs2/yaffs_osglue.h
@@ -18,11 +18,9 @@
  * a direct interface.
  */
 
-
 #ifndef __YAFFS_OSGLUE_H__
 #define __YAFFS_OSGLUE_H__
 
-
 #include "yportenv.h"
 
 void yaffsfs_Lock(void);
@@ -37,5 +35,4 @@ void yaffsfs_free(void *ptr);
 
 void yaffsfs_OSInitialisation(void);
 
-
 #endif
diff --git a/fs/yaffs2/yaffs_summary.c b/fs/yaffs2/yaffs_summary.c
index 4f9449a8447..2efd73a0223 100644
--- a/fs/yaffs2/yaffs_summary.c
+++ b/fs/yaffs2/yaffs_summary.c
@@ -52,7 +52,6 @@ struct yaffs_summary_header {
 	unsigned sum;		/* Just add up all the bytes in the tags */
 };
 
-
 static void yaffs_summary_clear(struct yaffs_dev *dev)
 {
 	if (!dev->sum_tags)
@@ -61,7 +60,6 @@ static void yaffs_summary_clear(struct yaffs_dev *dev)
 		sizeof(struct yaffs_summary_tags));
 }
 
-
 void yaffs_summary_deinit(struct yaffs_dev *dev)
 {
 	kfree(dev->sum_tags);
@@ -168,11 +166,9 @@ static int yaffs_summary_write(struct yaffs_dev *dev, int blk)
 	} while (result == YAFFS_OK && n_bytes > 0);
 	yaffs_release_temp_buffer(dev, buffer);
 
-
 	if (result == YAFFS_OK)
 		bi->has_summary = 1;
 
-
 	return result;
 }
 
diff --git a/fs/yaffs2/yaffs_summary.h b/fs/yaffs2/yaffs_summary.h
index be141d07336..e2e027b9257 100644
--- a/fs/yaffs2/yaffs_summary.h
+++ b/fs/yaffs2/yaffs_summary.h
@@ -18,7 +18,6 @@
 
 #include "yaffs_packedtags2.h"
 
-
 int yaffs_summary_init(struct yaffs_dev *dev);
 void yaffs_summary_deinit(struct yaffs_dev *dev);
 
@@ -33,5 +32,4 @@ int yaffs_summary_read(struct yaffs_dev *dev,
 			int blk);
 void yaffs_summary_gc(struct yaffs_dev *dev, int blk);
 
-
 #endif
diff --git a/fs/yaffs2/yaffs_tagscompat.c b/fs/yaffs2/yaffs_tagscompat.c
index 9ac5896da37..1a367fe6985 100644
--- a/fs/yaffs2/yaffs_tagscompat.c
+++ b/fs/yaffs2/yaffs_tagscompat.c
@@ -19,7 +19,6 @@
 
 static void yaffs_handle_rd_data_error(struct yaffs_dev *dev, int nand_chunk);
 
-
 /********** Tags ECC calculations  *********/
 
 void yaffs_calc_ecc(const u8 *data, struct yaffs_spare *spare)
diff --git a/fs/yaffs2/yaffs_uboot_glue.c b/fs/yaffs2/yaffs_uboot_glue.c
index deddbaac51e..c52362b3eda 100644
--- a/fs/yaffs2/yaffs_uboot_glue.c
+++ b/fs/yaffs2/yaffs_uboot_glue.c
@@ -40,7 +40,6 @@
 unsigned yaffs_trace_mask = 0x0; /* Disable logging */
 static int yaffs_errno;
 
-
 void yaffs_bug_fn(const char *fn, int n)
 {
 	printf("yaffs bug at %s:%d\n", fn, n);
@@ -66,7 +65,6 @@ int yaffsfs_GetLastError(void)
 	return yaffs_errno;
 }
 
-
 int yaffsfs_GetError(void)
 {
 	return yaffs_errno;
@@ -100,7 +98,6 @@ void yaffsfs_LocalInitialisation(void)
 	/* No locking used */
 }
 
-
 static const char *yaffs_file_type_str(struct yaffs_stat *stat)
 {
 	switch (stat->st_mode & S_IFMT) {
@@ -305,7 +302,6 @@ void make_a_file(char *yaffsName, char bval, int sizeOfFile)
 
 	} while (sizeOfFile > 0);
 
-
 	yaffs_close(outh);
 }
 
@@ -341,7 +337,6 @@ void cmd_yaffs_mount(char *mp)
 			yaffsfs_GetError(), yaffs_error_str());
 }
 
-
 void cmd_yaffs_umount(char *mp)
 {
 	if (yaffs_unmount(mp) == -1)
@@ -354,13 +349,11 @@ void cmd_yaffs_write_file(char *yaffsName, char bval, int sizeOfFile)
 	make_a_file(yaffsName, bval, sizeOfFile);
 }
 
-
 void cmd_yaffs_read_file(char *fn)
 {
 	read_a_file(fn);
 }
 
-
 void cmd_yaffs_mread_file(char *fn, char *addr)
 {
 	int h;
@@ -381,7 +374,6 @@ void cmd_yaffs_mread_file(char *fn, char *addr)
 	yaffs_close(h);
 }
 
-
 void cmd_yaffs_mwrite_file(char *fn, char *addr, int size)
 {
 	int outh;
@@ -395,7 +387,6 @@ void cmd_yaffs_mwrite_file(char *fn, char *addr, int size)
 	yaffs_close(outh);
 }
 
-
 void cmd_yaffs_ls(const char *mountpt, int longlist)
 {
 	int i;
@@ -429,7 +420,6 @@ void cmd_yaffs_ls(const char *mountpt, int longlist)
 	yaffs_closedir(d);
 }
 
-
 void cmd_yaffs_mkdir(const char *dir)
 {
 	int retval = yaffs_mkdir(dir, 0);
diff --git a/fs/yaffs2/yaffs_verify.c b/fs/yaffs2/yaffs_verify.c
index 3fef28bdcb0..f10fe03bc42 100644
--- a/fs/yaffs2/yaffs_verify.c
+++ b/fs/yaffs2/yaffs_verify.c
@@ -240,7 +240,6 @@ void yaffs_verify_file(struct yaffs_obj *obj)
 	dev = obj->my_dev;
 	obj_id = obj->obj_id;
 
-
 	/* Check file size is consistent with tnode depth */
 	yaffs_addr_to_chunk(dev, obj->variant.file_variant.file_size,
 				&last_chunk, &offset_in_chunk);
diff --git a/fs/yaffs2/yaffs_yaffs2.c b/fs/yaffs2/yaffs_yaffs2.c
index 14d497eb99b..627a701a45b 100644
--- a/fs/yaffs2/yaffs_yaffs2.c
+++ b/fs/yaffs2/yaffs_yaffs2.c
@@ -592,7 +592,6 @@ static int yaffs2_rd_checkpt_objs(struct yaffs_dev *dev)
 	int done = 0;
 	LIST_HEAD(hard_list);
 
-
 	while (ok && !done) {
 		ok = (yaffs2_checkpt_rd(dev, &cp, sizeof(cp)) == sizeof(cp));
 		if (cp.struct_type != sizeof(cp)) {
diff --git a/fs/yaffs2/yaffscfg.h b/fs/yaffs2/yaffscfg.h
index 718504eeac5..4f723d6480c 100644
--- a/fs/yaffs2/yaffscfg.h
+++ b/fs/yaffs2/yaffscfg.h
@@ -18,21 +18,17 @@
  * a direct interface.
  */
 
-
 #ifndef __YAFFSCFG_H__
 #define __YAFFSCFG_H__
 
-
 #include "yportenv.h"
 
 #define YAFFSFS_N_HANDLES	100
 #define YAFFSFS_N_DSC		20
 
-
 struct yaffsfs_DeviceConfiguration {
 	const YCHAR *prefix;
 	struct yaffs_dev *dev;
 };
 
-
 #endif
diff --git a/fs/yaffs2/yaffsfs.c b/fs/yaffs2/yaffsfs.c
index d615f02d3fc..c4909af9fc5 100644
--- a/fs/yaffs2/yaffsfs.c
+++ b/fs/yaffs2/yaffsfs.c
@@ -82,7 +82,6 @@ struct yaffsfs_Handle {
 	short int useCount;
 };
 
-
 struct yaffsfs_DirSearchContxt {
 	struct yaffs_dirent de;	/* directory entry */
 	YCHAR name[NAME_MAX + 1];	/* name of directory being searched */
diff --git a/fs/yaffs2/yaffsfs.h b/fs/yaffs2/yaffsfs.h
index f2c7666625c..e14f41c63ee 100644
--- a/fs/yaffs2/yaffsfs.h
+++ b/fs/yaffs2/yaffsfs.h
@@ -18,21 +18,18 @@
  * a direct interface.
  */
 
-
 #ifndef __YAFFSFS_H__
 #define __YAFFSFS_H__
 
 #include "yaffscfg.h"
 #include "yportenv.h"
 
-
 #ifndef NAME_MAX
 #define NAME_MAX	256
 #endif
 
 #define YAFFS_MAX_FILE_SIZE (0x800000000LL - 1)
 
-
 struct yaffs_dirent {
 	long d_ino;			/* inode number */
 	off_t d_off;			/* offset to this dirent */
@@ -44,8 +41,6 @@ struct yaffs_dirent {
 
 typedef struct opaque_structure yaffs_DIR;
 
-
-
 struct yaffs_stat {
 	int		st_dev;		/* device */
 	int		st_ino;		/* inode */
@@ -69,13 +64,11 @@ struct yaffs_stat {
 #endif
 };
 
-
 struct yaffs_utimbuf {
 	unsigned long actime;
 	unsigned long modtime;
 };
 
-
 int yaffs_open(const YCHAR *path, int oflag, int mode) ;
 
 int yaffs_close(int fd) ;
@@ -108,7 +101,6 @@ int yaffs_fstat(int fd, struct yaffs_stat *buf) ;
 int yaffs_utime(const YCHAR *path, const struct yaffs_utimbuf *buf);
 int yaffs_futime(int fd, const struct yaffs_utimbuf *buf);
 
-
 int yaffs_setxattr(const char *path, const char *name,
 			const void *data, int size, int flags);
 int yaffs_lsetxattr(const char *path, const char *name,
@@ -131,7 +123,6 @@ int yaffs_listxattr(const char *path, char *list, int size);
 int yaffs_llistxattr(const char *path, char *list, int size);
 int yaffs_flistxattr(int fd, char *list, int size);
 
-
 #ifdef CONFIG_YAFFS_WINCE
 
 int yaffs_set_wince_times(int fd,
@@ -164,7 +155,6 @@ int yaffs_unmount(const YCHAR *path) ;
 int yaffs_unmount2(const YCHAR *path, int force);
 int yaffs_remount(const YCHAR *path, int force, int read_only);
 
-
 int yaffs_sync(const YCHAR *path) ;
 
 int yaffs_symlink(const YCHAR *oldpath, const YCHAR *newpath);
diff --git a/fs/yaffs2/ydirectenv.h b/fs/yaffs2/ydirectenv.h
index 790f8512f74..14b13ce2bd4 100644
--- a/fs/yaffs2/ydirectenv.h
+++ b/fs/yaffs2/ydirectenv.h
@@ -27,8 +27,6 @@
 
 void yaffs_bug_fn(const char *file_name, int line_no);
 
-
-
 #define YCHAR char
 #define YUCHAR unsigned char
 #define _Y(x) x
@@ -45,7 +43,6 @@ void yaffs_bug_fn(const char *file_name, int line_no);
 #define yaffs_strncmp(a, b, c)	strncmp(a, b, c)
 #endif
 
-
 void yaffs_qsort(void *aa, size_t n, size_t es,
 		int (*cmp)(const void *, const void *));
 
@@ -62,7 +59,6 @@ void yaffs_qsort(void *aa, size_t n, size_t es,
 		printf("yaffs: " fmt "\n", ##__VA_ARGS__); \
 } while (0)
 
-
 #define YAFFS_LOSTNFOUND_NAME		"lost+found"
 #define YAFFS_LOSTNFOUND_PREFIX		"obj"
 
diff --git a/fs/yaffs2/yportenv.h b/fs/yaffs2/yportenv.h
index 081391a1d0f..b23042948db 100644
--- a/fs/yaffs2/yportenv.h
+++ b/fs/yaffs2/yportenv.h
@@ -13,7 +13,6 @@
  * Note: Only YAFFS headers are LGPL, YAFFS C code is covered by GPL.
  */
 
-
 #ifndef __YPORTENV_H__
 #define __YPORTENV_H__
 
@@ -27,11 +26,9 @@ typedef unsigned short u16;
 typedef unsigned u32;
 #endif
 
-
 #ifdef CONFIG_YAFFS_PROVIDE_DEFS
 /* File types */
 
-
 #define DT_UNKNOWN	0
 #define DT_FIFO		1
 #define DT_CHR		2
@@ -42,7 +39,6 @@ typedef unsigned u32;
 #define DT_SOCK		12
 #define DT_WHT		14
 
-
 /*
  * Attribute flags.
  * These are or-ed together to select what has been changed.
@@ -69,13 +65,10 @@ struct iattr {
 
 #endif
 
-
-
 #if defined CONFIG_YAFFS_WINCE
 
 #include "ywinceenv.h"
 
-
 #elif defined CONFIG_YAFFS_DIRECT
 
 /* Direct interface */
@@ -215,7 +208,6 @@ struct iattr {
 #define ELOOP	40
 #endif
 
-
 /* Mode flags */
 
 #ifndef S_IFMT
@@ -258,7 +250,6 @@ struct iattr {
 #define S_ISCHR(m)	(((m) & S_IFMT) == S_IFCHR)
 #define S_ISFIFO(m)	(((m) & S_IFMT) == S_IFIFO)
 
-
 #ifndef S_IREAD
 #define S_IREAD		0000400
 #endif
diff --git a/fs/zfs/dev.c b/fs/zfs/dev.c
index 722c6a86176..0eceafab2af 100644
--- a/fs/zfs/dev.c
+++ b/fs/zfs/dev.c
@@ -7,7 +7,6 @@
  *	Sysgo AG, <www.elinos.com>, Pavel Bartusek <pba@sysgo.com>
  */
 
-
 #include <config.h>
 #include <fs_internal.h>
 #include <zfs_common.h>
diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index 9906d553fa6..410a61aa611 100644
--- a/fs/zfs/zfs.c
+++ b/fs/zfs/zfs.c
@@ -50,10 +50,8 @@ struct blk_desc *zfs_dev_desc;
 #include <zfs/dsl_dir.h>
 #include <zfs/dsl_dataset.h>
 
-
 #define	ZPOOL_PROP_BOOTFS		"bootfs"
 
-
 /*
  * For nvlist manipulation. (from nvpair.h)
  */
@@ -66,7 +64,6 @@ struct blk_desc *zfs_dev_desc;
 #define	DATA_TYPE_NVLIST	19
 #define	DATA_TYPE_NVLIST_ARRAY	20
 
-
 /*
  * Macros to get fields in a bp or DVA.
  */
@@ -120,7 +117,6 @@ struct blk_desc *zfs_dev_desc;
 	((zap_leaf_chunk_t *)(l->l_hash + ZAP_LEAF_HASH_NUMENTRIES(bs)))[idx]
 #define	ZAP_LEAF_ENTRY(l, bs, idx) (&ZAP_LEAF_CHUNK(l, bs, idx).l_entry)
 
-
 /*
  * Decompression Entry - lzjb
  */
@@ -128,8 +124,6 @@ struct blk_desc *zfs_dev_desc;
 #define	NBBY	8
 #endif
 
-
-
 typedef int zfs_decomp_func_t(void *s_start, void *d_start,
 							  uint32_t s_len, uint32_t d_len);
 typedef struct decomp_entry {
@@ -176,9 +170,6 @@ struct zfs_data {
 
 };
 
-
-
-
 static int
 zlib_decompress(void *s, void *d,
 				uint32_t slen, uint32_t dlen)
@@ -206,8 +197,6 @@ static decomp_entry_t decomp_table[ZIO_COMPRESS_FUNCTIONS] = {
 	{"gzip-9", zlib_decompress},  /* ZIO_COMPRESS_GZIP9 */
 };
 
-
-
 static int zio_read_data(blkptr_t *bp, zfs_endian_t endian,
 						 void *buf, struct zfs_data *data);
 
@@ -231,7 +220,6 @@ zfs_log2(uint64_t num)
 	return i;
 }
 
-
 /* Checksum Functions */
 static void
 zio_checksum_off(const void *buf __attribute__ ((unused)),
@@ -812,7 +800,6 @@ zap_leaf_array_get(zap_leaf_phys_t *l, zfs_endian_t endian, int blksft,
 	return ZFS_ERR_NONE;
 }
 
-
 /*
  * Given a zap_leaf_phys_t, walk thru the zap leaf chunks to get the
  * value for the property "name".
@@ -879,7 +866,6 @@ zap_leaf_lookup(zap_leaf_phys_t *l, zfs_endian_t endian,
 	return ZFS_ERR_FILE_NOT_FOUND;
 }
 
-
 /* Verify if this is a fat zap header block */
 static int
 zap_verify(zap_phys_t *zap)
@@ -1029,7 +1015,6 @@ fzap_iterate(dnode_end_t *zap_dnode, zap_phys_t *zap,
 	return 0;
 }
 
-
 /*
  * Read in the data of a zap object and find the value for a matching
  * property name.
@@ -1104,7 +1089,6 @@ zap_iterate(dnode_end_t *zap_dnode,
 	return 0;
 }
 
-
 /*
  * Get the dnode of an object number from the metadnode of an object set.
  *
@@ -1299,7 +1283,6 @@ dnode_get_path(dnode_end_t *mdn, const char *path_in, dnode_end_t *dn,
 	return err;
 }
 
-
 /*
  * Given a MOS metadnode, get the metadnode of a given filesystem name (fsname),
  * e.g. pool/rootfs, or a given object number (obj), e.g. the object number
@@ -1434,7 +1417,6 @@ dnode_get_fullpath(const char *fullpath, dnode_end_t *mdn,
 			   fsname, snapname, filename);
 	}
 
-
 	err = get_filesystem_dnode(&(data->mos), fsname, dn, data);
 
 	if (err) {
@@ -2336,7 +2318,6 @@ zfs_ls(device_t device, const char *path,
 			return err;
 		}
 
-
 		zap_iterate(&dn, iterate_zap_fs, data);
 
 		err = dnode_get(&(data->mos), headobj, DMU_OT_DSL_DATASET, &dn, data);
-- 
2.43.0

