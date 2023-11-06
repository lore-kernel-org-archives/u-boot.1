Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D06C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 10:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0741386BD4;
	Mon,  6 Nov 2023 11:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=infraroot.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=infraroot.at header.i=@infraroot.at header.b="sF0qpLvm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1AFA86FE8; Mon,  6 Nov 2023 11:04:59 +0100 (CET)
Received: from mail.infraroot.at (mail.infraroot.at [54.37.73.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CF8886B02
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 11:04:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=infraroot.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=goliath@infraroot.at
Received: from localtoast.corp.sigma-star.at (unknown [82.150.214.1])
 by mail.infraroot.at (Postfix) with ESMTPSA id AA5CE3EDB6;
 Mon,  6 Nov 2023 11:04:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.infraroot.at AA5CE3EDB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infraroot.at;
 s=default; t=1699265096;
 bh=Iz9fnndsqI/jW0ulcNHqdnIBPj4u2cMher46bF0ReNU=;
 h=From:To:Cc:Subject:Date:From;
 b=sF0qpLvm3U28W99k8Yr+QZIqWps+xZwFFjXR3G+N7OWvAbqIVJZFpHDHb5/l3kHs2
 +Z3nSPrOGDA72cYGEGXN6qbgSeZWEy1md4xj4EfP0U/OsDPmMkI02h8KKHrRS1bWDH
 xmSIxiiEZ6317xBwG4EOjDCawK3MZ+/qXObLwpGM=
From: David Oberhollenzer <goliath@infraroot.at>
To: u-boot@lists.denx.de, jmcosta944@gmail.com, thomas.petazzoni@bootlin.com,
 miquel.raynal@bootlin.com
Cc: David Oberhollenzer <goliath@infraroot.at>
Subject: [PATCH] fs/squashfs: remove unused declarations
Date: Mon,  6 Nov 2023 11:03:20 +0100
Message-ID: <20231106100320.58263-1-goliath@infraroot.at>
X-Mailer: git-send-email 2.41.0
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

This patch removes a number of struct and macro declaration that
were found through `git-grep` to be unused. Most of those are
related to compressor options and super block flags.

For reading a SquashFS image, we do not need the compressor options
or the flags. Those only encode settings used for packing the image,
mksquashfs uses them when appending data to an existing image. The
kernel implementation does not touch those, and we don't need them
either.

Signed-off-by: David Oberhollenzer <goliath@infraroot.at>
---
 fs/squashfs/sqfs_decompressor.h | 35 ---------------------------------
 fs/squashfs/sqfs_filesystem.h   |  2 --
 fs/squashfs/sqfs_utils.h        | 21 --------------------
 3 files changed, 58 deletions(-)

diff --git a/fs/squashfs/sqfs_decompressor.h b/fs/squashfs/sqfs_decompressor.h
index 892cfb6974..c48b74fdf5 100644
--- a/fs/squashfs/sqfs_decompressor.h
+++ b/fs/squashfs/sqfs_decompressor.h
@@ -18,41 +18,6 @@
 #define SQFS_COMP_LZ4 5
 #define SQFS_COMP_ZSTD 6
 
-/* LZMA does not support any compression options */
-
-struct squashfs_gzip_opts {
-	u32 compression_level;
-	u16 window_size;
-	u16 strategies;
-};
-
-struct squashfs_xz_opts {
-	u32 dictionary_size;
-	u32 executable_filters;
-};
-
-struct squashfs_lz4_opts {
-	u32 version;
-	u32 flags;
-};
-
-struct squashfs_zstd_opts {
-	u32 compression_level;
-};
-
-struct squashfs_lzo_opts {
-	u32 algorithm;
-	u32 level;
-};
-
-union squashfs_compression_opts {
-	struct squashfs_gzip_opts *gzip;
-	struct squashfs_xz_opts *xz;
-	struct squashfs_lz4_opts *lz4;
-	struct squashfs_zstd_opts *zstd;
-	struct squashfs_lzo_opts *lzo;
-};
-
 int sqfs_decompress(struct squashfs_ctxt *ctxt, void *dest,
 		    unsigned long *dest_len, void *source, u32 src_len);
 int sqfs_decompressor_init(struct squashfs_ctxt *ctxt);
diff --git a/fs/squashfs/sqfs_filesystem.h b/fs/squashfs/sqfs_filesystem.h
index 5440b6c0e0..be56498a5e 100644
--- a/fs/squashfs/sqfs_filesystem.h
+++ b/fs/squashfs/sqfs_filesystem.h
@@ -13,7 +13,6 @@
 #include <part.h>
 #include <stdint.h>
 
-#define SQFS_UNCOMPRESSED_DATA 0x0002
 #define SQFS_MAGIC_NUMBER 0x73717368
 /* The three first members of squashfs_dir_index make a total of 12 bytes */
 #define SQFS_DIR_INDEX_BASE_LENGTH 12
@@ -23,7 +22,6 @@
 #define SQFS_MAX_ENTRIES 512
 /* Metadata blocks start by a 2-byte length header */
 #define SQFS_HEADER_SIZE 2
-#define SQFS_LREG_INODE_MIN_SIZE 56
 #define SQFS_DIR_HEADER_SIZE 12
 #define SQFS_MISC_ENTRY_TYPE -1
 #define SQFS_EMPTY_FILE_SIZE 3
diff --git a/fs/squashfs/sqfs_utils.h b/fs/squashfs/sqfs_utils.h
index 1260abe22b..41f13e8a9e 100644
--- a/fs/squashfs/sqfs_utils.h
+++ b/fs/squashfs/sqfs_utils.h
@@ -15,11 +15,8 @@
 #define SQFS_FRAGMENT_INDEX_OFFSET(A) ((A) % SQFS_MAX_ENTRIES)
 #define SQFS_FRAGMENT_INDEX(A) ((A) / SQFS_MAX_ENTRIES)
 #define SQFS_BLOCK_SIZE(A) ((A) & GENMASK(23, 0))
-#define SQFS_CHECK_FLAG(flag, bit) (((flag) >> (bit)) & 1)
 /* Useful for both fragment and data blocks */
 #define SQFS_COMPRESSED_BLOCK(A) (!((A) & BIT(24)))
-/* SQFS_COMPRESSED_DATA strictly used with super block's 'flags' member */
-#define SQFS_COMPRESSED_DATA(A) (!((A) & 0x0002))
 #define SQFS_IS_FRAGMENTED(A) ((A) != 0xFFFFFFFF)
 /*
  * These two macros work as getters for a metada block header, retrieving the
@@ -28,22 +25,4 @@
 #define SQFS_COMPRESSED_METADATA(A) (!((A) & BIT(15)))
 #define SQFS_METADATA_SIZE(A) ((A) & GENMASK(14, 0))
 
-struct squashfs_super_block_flags {
-	/* check: unused
-	 * uncompressed_ids: not supported
-	 */
-	bool uncompressed_inodes;
-	bool uncompressed_data;
-	bool check;
-	bool uncompressed_frags;
-	bool no_frags;
-	bool always_frags;
-	bool duplicates;
-	bool exportable;
-	bool uncompressed_xattrs;
-	bool no_xattrs;
-	bool compressor_options;
-	bool uncompressed_ids;
-};
-
 #endif /* SQFS_UTILS_H  */
-- 
2.41.0

