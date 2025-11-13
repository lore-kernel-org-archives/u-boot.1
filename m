Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98270CD4F28
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 06:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3AED83DA9;
	Thu, 13 Nov 2025 07:47:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bTAEeXvE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C8A783C54; Thu, 13 Nov 2025 07:47:29 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18FC383D4A
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
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4302340A09; 
 Thu, 13 Nov 2025 06:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763016446;
 bh=+SRTXzemg7bST03PEb6Mypeii+bJCYW8wwL/LQUg8iA=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=bTAEeXvEYYCf2UNloqJplv5+4cHRSGCl591VMQpcznj6dOxyboAPpFOsp+VfCfm3Z
 ZAUhb6KJUpZ8xF5LzS5gS/b+a+6Txj5t9U4FUJGjvtGDexDtd9ld1+Hx/xxJeSvCXp
 qDnDBW45uhENEGY3NdUf4trEYhvGNb9WUad3Is42Z5kRDdTkObeyTyEq+DBiKa2y9W
 XcRbGe5hCerhrJGSzCGQq7LwvLi4DAlU+iHNs8zucIZbQH/kiyS2FOEER78fUm7RDd
 4BvOsa4SLgyPYap2ixlDVlsw9kl6/Cym0lBTLNETazw4EKr0Jcf+eJ7c+QnGOH404D
 cI0egSNgfiuuoDSkJ/8QCorxIw7CyO0iKN8/TLFOOahG/z+jznYeixHBNnk1V0rpr5
 SlzO2dVBQ8JaBrc+Q6PyOT4vZKWoE1DGNknCm5zQBr1HTozIz025iI+dlPCr+zkhbG
 xIBIPXqJLlrTeGOaMjg2it9XpbKOE+w+rMKZwuTS+tnmGFkLrc1GK7pphFcXzHGK5S
 lxLftdx5M2C2wKxi0NrGAuvhWBszpTp00nP+cgQcHpOzLqLIU42nzj82CvyTR4CJO8
 4EoEIV7ny27rDMul8XOxlvRLYZCNzssQAX3KCTSQEnsBXltZDY1m2I0mNrymYl8/C/
 enZcCkpwrrSQmlevwe3albHk=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <simon.glass@canonical.com>,
 Gabriel Dalimonte <gabriel.dalimonte@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Claude <noreply@anthropic.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/6] fat: Create an internal header file
Date: Thu, 13 Nov 2025 07:46:51 +0100
Message-ID: <20251113064656.245394-2-heinrich.schuchardt@canonical.com>
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

As a first step towards separating fat.c from fat_write.c, create a
header file for the definitions.

Co-developed-by: Claude <noreply@anthropic.com>
Signed-off-by: Simon Glass <simon.glass@canonical.com>
Tested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 fs/fat/fat.c          |  91 +---------------------------------
 fs/fat/fat_internal.h | 112 ++++++++++++++++++++++++++++++++++++++++++
 fs/fat/fat_write.c    |   1 +
 3 files changed, 114 insertions(+), 90 deletions(-)
 create mode 100644 fs/fat/fat_internal.h

diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 89f2acbba1e..5114e97e924 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -26,9 +26,7 @@
 #include <linux/compiler.h>
 #include <linux/ctype.h>
 #include <linux/log2.h>
-
-/* maximum number of clusters for FAT12 */
-#define MAX_FAT12	0xFF4
+#include "fat_internal.h"
 
 /*
  * Convert a string to lowercase.  Converts at most 'len' characters,
@@ -46,10 +44,6 @@ static void downcase(char *str, size_t len)
 static struct blk_desc *cur_dev;
 static struct disk_partition cur_part_info;
 
-#define DOS_BOOT_MAGIC_OFFSET	0x1fe
-#define DOS_FS_TYPE_OFFSET	0x36
-#define DOS_FS32_TYPE_OFFSET	0x52
-
 static int disk_read(__u32 block, __u32 nr_blocks, void *buf)
 {
 	ulong ret;
@@ -705,89 +699,6 @@ static int get_fs_info(fsdata *mydata)
 	return 0;
 }
 
-/**
- * struct fat_itr - directory iterator, to simplify filesystem traversal
- *
- * Implements an iterator pattern to traverse directory tables,
- * transparently handling directory tables split across multiple
- * clusters, and the difference between FAT12/FAT16 root directory
- * (contiguous) and subdirectories + FAT32 root (chained).
- *
- * Rough usage
- *
- * .. code-block:: c
- *
- *     for (fat_itr_root(&itr, fsdata); fat_itr_next(&itr); ) {
- *         // to traverse down to a subdirectory pointed to by
- *         // current iterator position:
- *         fat_itr_child(&itr, &itr);
- *     }
- *
- * For a more complete example, see fat_itr_resolve().
- */
-struct fat_itr {
-	/**
-	 * @fsdata:		filesystem parameters
-	 */
-	fsdata *fsdata;
-	/**
-	 * @start_clust:	first cluster
-	 */
-	unsigned int start_clust;
-	/**
-	 * @clust:		current cluster
-	 */
-	unsigned int clust;
-	/**
-	 * @next_clust:		next cluster if remaining == 0
-	 */
-	unsigned int next_clust;
-	/**
-	 * @last_cluster:	set if last cluster of directory reached
-	 */
-	int last_cluster;
-	/**
-	 * @is_root:		is iterator at root directory
-	 */
-	int is_root;
-	/**
-	 * @remaining:		remaining directory entries in current cluster
-	 */
-	int remaining;
-	/**
-	 * @dent:		current directory entry
-	 */
-	dir_entry *dent;
-	/**
-	 * @dent_rem:		remaining entries after long name start
-	 */
-	int dent_rem;
-	/**
-	 * @dent_clust:		cluster of long name start
-	 */
-	unsigned int dent_clust;
-	/**
-	 * @dent_start:		first directory entry for long name
-	 */
-	dir_entry *dent_start;
-	/**
-	 * @l_name:		long name of current directory entry
-	 */
-	char l_name[VFAT_MAXLEN_BYTES];
-	/**
-	 * @s_name:		short 8.3 name of current directory entry
-	 */
-	char s_name[14];
-	/**
-	 * @name:		l_name if there is one, else s_name
-	 */
-	char *name;
-	/**
-	 * @block:		buffer for current cluster
-	 */
-	u8 block[MAX_CLUSTSIZE] __aligned(ARCH_DMA_MINALIGN);
-};
-
 static int fat_itr_isdir(fat_itr *itr);
 
 /**
diff --git a/fs/fat/fat_internal.h b/fs/fat/fat_internal.h
new file mode 100644
index 00000000000..0174cd611e7
--- /dev/null
+++ b/fs/fat/fat_internal.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * fat_internal.h
+ *
+ * Internal definitions and structures for FAT filesystem implementation
+ */
+
+#ifndef _FAT_INTERNAL_H_
+#define _FAT_INTERNAL_H_
+
+#include <fat.h>
+#include <linux/compiler.h>
+
+struct blk_desc;
+struct disk_partition;
+
+/* Maximum number of clusters for FAT12 */
+#define MAX_FAT12	0xFF4
+
+/* Boot sector offsets */
+#define DOS_BOOT_MAGIC_OFFSET	0x1fe
+#define DOS_FS_TYPE_OFFSET	0x36
+#define DOS_FS32_TYPE_OFFSET	0x52
+
+/**
+ * struct fat_itr - directory iterator, to simplify filesystem traversal
+ *
+ * Implements an iterator pattern to traverse directory tables,
+ * transparently handling directory tables split across multiple
+ * clusters, and the difference between FAT12/FAT16 root directory
+ * (contiguous) and subdirectories + FAT32 root (chained).
+ *
+ * Rough usage
+ *
+ * .. code-block:: c
+ *
+ *     for (fat_itr_root(&itr, fsdata); fat_itr_next(&itr); ) {
+ *         // to traverse down to a subdirectory pointed to by
+ *         // current iterator position:
+ *         fat_itr_child(&itr, &itr);
+ *     }
+ *
+ * For a more complete example, see fat_itr_resolve().
+ */
+struct fat_itr {
+	/**
+	 * @fsdata:		filesystem parameters
+	 */
+	fsdata *fsdata;
+	/**
+	 * @start_clust:	first cluster
+	 */
+	unsigned int start_clust;
+	/**
+	 * @clust:		current cluster
+	 */
+	unsigned int clust;
+	/**
+	 * @next_clust:		next cluster if remaining == 0
+	 */
+	unsigned int next_clust;
+	/**
+	 * @last_cluster:	set if last cluster of directory reached
+	 */
+	int last_cluster;
+	/**
+	 * @is_root:		is iterator at root directory
+	 */
+	int is_root;
+	/**
+	 * @remaining:		remaining directory entries in current cluster
+	 */
+	int remaining;
+	/**
+	 * @dent:		current directory entry
+	 */
+	dir_entry *dent;
+	/**
+	 * @dent_rem:		remaining entries after long name start
+	 */
+	int dent_rem;
+	/**
+	 * @dent_clust:		cluster of long name start
+	 */
+	unsigned int dent_clust;
+	/**
+	 * @dent_start:		first directory entry for long name
+	 */
+	dir_entry *dent_start;
+	/**
+	 * @l_name:		long name of current directory entry
+	 */
+	char l_name[VFAT_MAXLEN_BYTES];
+	/**
+	 * @s_name:		short 8.3 name of current directory entry
+	 */
+	char s_name[14];
+	/**
+	 * @name:		l_name if there is one, else s_name
+	 */
+	char *name;
+	/**
+	 * @block:		buffer for current cluster
+	 */
+	u8 block[MAX_CLUSTSIZE] __aligned(ARCH_DMA_MINALIGN);
+};
+
+#define TYPE_FILE 0x1
+#define TYPE_DIR  0x2
+#define TYPE_ANY  (TYPE_FILE | TYPE_DIR)
+
+#endif /* _FAT_INTERNAL_H_ */
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index 0b924541187..45a2eef712b 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -20,6 +20,7 @@
 #include <dm/uclass.h>
 #include <linux/ctype.h>
 #include <linux/math64.h>
+#include "fat_internal.h"
 #include "fat.c"
 
 static dir_entry *find_directory_entry(fat_itr *itr, char *filename);
-- 
2.51.0

