Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE81C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:14:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81605885A5;
	Sat, 27 Apr 2024 16:11:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HcafwkOK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 435398827F; Sat, 27 Apr 2024 16:11:34 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E3EF88411
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-78edc3e80e6so220108885a.2
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227090; x=1714831890; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bNCk92xkdwVzqVkykxigfQbhKy5IwfYQYn66e/ci+mc=;
 b=HcafwkOK8qXpADsWlCpbi81nwa/4z1a8lXHbe5IoXJ4+HMKtYrZO4D14/Ubiw+W5HD
 hqAktdgAR8pHXzIyJGexD2pbZSiY4yVcH5jWaXc0Hp+SRlV5WXk2gy2CCbN8V5GbAIoE
 uYAmKi/MEoa6xDT3F7RGfE7VESoDn7+2mxBck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227090; x=1714831890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bNCk92xkdwVzqVkykxigfQbhKy5IwfYQYn66e/ci+mc=;
 b=evIYUN57SP13aIG1AmffAL0L67jjbURFKhYSe7ATJ3BYo6cmU6TV+VtmVQBD6HoNNt
 lXZvw3eCZDmABNNFUzebqpJRJZw3iNqJEaQv05CBHu0Z8tN5aaUs9fgBdoDqv+1nWJZ+
 co5JJtOBYlS00b9js5Lj+Wx4MUKdpHlWgK9ykYyHBP2z6WbipFMncs93/tInXCKKkrw/
 oS+Bg3uGDEjPWVS/RzFMxFhxgIq5a9kjyy0DgdxTuTWlXH8eM+/AwaUMlpnXBBkpPgTW
 M0q5lXkVmF70PeyR9UBUREO0Gy+hCQtzCQaLiFTwXzB2gQU8s6vkB2fQXIxX4n/3rFP5
 pwOg==
X-Gm-Message-State: AOJu0YwtA+Sk/+xKiVaPqfzhB3g6XD9aNvgv0SwipVfG6UB8tyNyk023
 FAcF1QKmdJg8f5bVa+luCk7PQ8V9jvzxv5N5IhTl6b4qV9nf2mD98s0vWwe5x2eIj897mV68z2L
 2snfUxw==
X-Google-Smtp-Source: AGHT+IG37XLliN+HtwQY9+Bseiymqo7gvo/wOEAzGDgmfECYcslA7gxrVFHfC3ku6uA+Mhc/cJKozA==
X-Received: by 2002:ae9:c305:0:b0:78d:7738:6889 with SMTP id
 n5-20020ae9c305000000b0078d77386889mr6085603qkg.73.1714227090178; 
 Sat, 27 Apr 2024 07:11:30 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.29
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 17/18] fs: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:11:05 -0600
Message-Id: <20240427141106.3406000-18-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Remove <common.h> from all "fs/" files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 fs/btrfs/dev.c               | 1 -
 fs/btrfs/disk-io.c           | 1 -
 fs/btrfs/volumes.c           | 2 +-
 fs/cbfs/cbfs.c               | 2 +-
 fs/cramfs/cramfs.c           | 2 +-
 fs/cramfs/uncompress.c       | 2 +-
 fs/ext4/dev.c                | 1 -
 fs/ext4/ext4_common.c        | 1 -
 fs/ext4/ext4_journal.c       | 1 -
 fs/ext4/ext4_write.c         | 1 -
 fs/ext4/ext4fs.c             | 1 -
 fs/fat/fat.c                 | 1 -
 fs/fat/fat_write.c           | 1 -
 fs/fs.c                      | 2 +-
 fs/fs_internal.c             | 1 -
 fs/jffs2/compr_zlib.c        | 2 --
 fs/jffs2/jffs2_1pass.c       | 1 -
 fs/jffs2/mergesort.c         | 1 -
 fs/sandbox/host_bootdev.c    | 1 -
 fs/sandbox/sandboxfs.c       | 2 +-
 fs/semihostingfs.c           | 2 +-
 fs/ubifs/super.c             | 1 -
 fs/ubifs/ubifs.c             | 1 -
 fs/yaffs2/yaffs_mtdif.c      | 1 -
 fs/yaffs2/yaffs_mtdif2.c     | 1 -
 fs/yaffs2/yaffs_uboot_glue.c | 1 -
 fs/zfs/dev.c                 | 1 -
 fs/zfs/zfs.c                 | 1 -
 fs/zfs/zfs_fletcher.c        | 1 -
 fs/zfs/zfs_lzjb.c            | 1 -
 fs/zfs/zfs_sha256.c          | 1 -
 include/jffs2/load_kernel.h  | 1 +
 32 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/dev.c b/fs/btrfs/dev.c
index cb3b9713a5f4..e27a032c9f69 100644
--- a/fs/btrfs/dev.c
+++ b/fs/btrfs/dev.c
@@ -5,7 +5,6 @@
  * 2017 Marek Behún, CZ.NIC, kabel@kernel.org
  */
 
-#include <common.h>
 #include <blk.h>
 #include <compiler.h>
 #include <fs_internal.h>
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 7eaa7e949604..e5bfaf461c2b 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0+
-#include <common.h>
 #include <fs_internal.h>
 #include <log.h>
 #include <uuid.h>
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7d4095d9ca88..8ec545eded7b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <stdlib.h>
-#include <common.h>
+#include <errno.h>
 #include <fs_internal.h>
 #include "ctree.h"
 #include "disk-io.h"
diff --git a/fs/cbfs/cbfs.c b/fs/cbfs/cbfs.c
index 714f4baafc9e..ad5583233bb1 100644
--- a/fs/cbfs/cbfs.c
+++ b/fs/cbfs/cbfs.c
@@ -3,10 +3,10 @@
  * Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
  */
 
-#include <common.h>
 #include <cbfs.h>
 #include <log.h>
 #include <malloc.h>
+#include <linux/errno.h>
 #include <asm/byteorder.h>
 
 /* Offset of master header from the start of a coreboot ROM */
diff --git a/fs/cramfs/cramfs.c b/fs/cramfs/cramfs.c
index abb2de34eb05..22148ff8fe27 100644
--- a/fs/cramfs/cramfs.c
+++ b/fs/cramfs/cramfs.c
@@ -24,7 +24,7 @@
  * The actual compression is based on zlib, see the other files.
  */
 
-#include <common.h>
+#include <stdio.h>
 #include <malloc.h>
 #include <asm/byteorder.h>
 #include <linux/stat.h>
diff --git a/fs/cramfs/uncompress.c b/fs/cramfs/uncompress.c
index 0d071b69f4cc..2141edf22e4a 100644
--- a/fs/cramfs/uncompress.c
+++ b/fs/cramfs/uncompress.c
@@ -20,7 +20,7 @@
  * then is used by multiple filesystems.
  */
 
-#include <common.h>
+#include <stdio.h>
 #include <cyclic.h>
 #include <malloc.h>
 #include <watchdog.h>
diff --git a/fs/ext4/dev.c b/fs/ext4/dev.c
index 168443de1ff7..3fd8980b1d69 100644
--- a/fs/ext4/dev.c
+++ b/fs/ext4/dev.c
@@ -22,7 +22,6 @@
  *		fs/ext2/dev.c file in uboot.
  */
 
-#include <common.h>
 #include <blk.h>
 #include <config.h>
 #include <fs_internal.h>
diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 2ff0dca2495e..857c15d878e4 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -18,7 +18,6 @@
  * ext4write : Based on generic ext4 protocol.
  */
 
-#include <common.h>
 #include <blk.h>
 #include <ext_common.h>
 #include <ext4fs.h>
diff --git a/fs/ext4/ext4_journal.c b/fs/ext4/ext4_journal.c
index e80f797c8dc9..02c4ac2cb931 100644
--- a/fs/ext4/ext4_journal.c
+++ b/fs/ext4/ext4_journal.c
@@ -13,7 +13,6 @@
  * Copyright 1998-2000 Red Hat, Inc --- All Rights Reserved
  */
 
-#include <common.h>
 #include <blk.h>
 #include <ext4fs.h>
 #include <log.h>
diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index d057f6b5a794..38da3923c477 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -21,7 +21,6 @@
  */
 
 
-#include <common.h>
 #include <blk.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/fs/ext4/ext4fs.c b/fs/ext4/ext4fs.c
index 33e200ffa3c5..da59cb008fce 100644
--- a/fs/ext4/ext4fs.c
+++ b/fs/ext4/ext4fs.c
@@ -20,7 +20,6 @@
  * ext4write : Based on generic ext4 protocol.
  */
 
-#include <common.h>
 #include <blk.h>
 #include <ext_common.h>
 #include <ext4fs.h>
diff --git a/fs/fat/fat.c b/fs/fat/fat.c
index 2dd9d4e72dcc..e2570e816768 100644
--- a/fs/fat/fat.c
+++ b/fs/fat/fat.c
@@ -10,7 +10,6 @@
 
 #define LOG_CATEGORY	LOGC_FS
 
-#include <common.h>
 #include <blk.h>
 #include <config.h>
 #include <exports.h>
diff --git a/fs/fat/fat_write.c b/fs/fat/fat_write.c
index c8e0fbf1a3b3..ea877ee9171b 100644
--- a/fs/fat/fat_write.c
+++ b/fs/fat/fat_write.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY LOGC_FS
 
-#include <common.h>
 #include <command.h>
 #include <config.h>
 #include <div64.h>
diff --git a/fs/fs.c b/fs/fs.c
index acf465bdd807..bed1f7242f41 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -9,7 +9,6 @@
 #include <config.h>
 #include <display_options.h>
 #include <errno.h>
-#include <common.h>
 #include <env.h>
 #include <lmb.h>
 #include <log.h>
@@ -21,6 +20,7 @@
 #include <fs.h>
 #include <sandboxfs.h>
 #include <semihostingfs.h>
+#include <time.h>
 #include <ubifs_uboot.h>
 #include <btrfs.h>
 #include <asm/global_data.h>
diff --git a/fs/fs_internal.c b/fs/fs_internal.c
index 111f91b355d1..51c1719361b1 100644
--- a/fs/fs_internal.c
+++ b/fs/fs_internal.c
@@ -7,7 +7,6 @@
 
 #define LOG_CATEGORY LOGC_CORE
 
-#include <common.h>
 #include <blk.h>
 #include <compiler.h>
 #include <log.h>
diff --git a/fs/jffs2/compr_zlib.c b/fs/jffs2/compr_zlib.c
index d306b6dc4cfe..e1e3c15e75e1 100644
--- a/fs/jffs2/compr_zlib.c
+++ b/fs/jffs2/compr_zlib.c
@@ -35,8 +35,6 @@
  *
  */
 
-#include <common.h>
-#include <config.h>
 #include <jffs2/jffs2.h>
 #include <jffs2/mini_inflate.h>
 
diff --git a/fs/jffs2/jffs2_1pass.c b/fs/jffs2/jffs2_1pass.c
index 49ba82ef9596..5b7d7f4ae881 100644
--- a/fs/jffs2/jffs2_1pass.c
+++ b/fs/jffs2/jffs2_1pass.c
@@ -111,7 +111,6 @@
  */
 
 
-#include <common.h>
 #include <config.h>
 #include <malloc.h>
 #include <div64.h>
diff --git a/fs/jffs2/mergesort.c b/fs/jffs2/mergesort.c
index fca77aa65114..495937d792db 100644
--- a/fs/jffs2/mergesort.c
+++ b/fs/jffs2/mergesort.c
@@ -7,7 +7,6 @@
  * http://www.chiark.greenend.org.uk/~sgtatham/algorithms/listsort.html
  */
 
-#include <common.h>
 #include "jffs2_private.h"
 
 int sort_list(struct b_list *list)
diff --git a/fs/sandbox/host_bootdev.c b/fs/sandbox/host_bootdev.c
index 3ef53627608a..3f74972a9f81 100644
--- a/fs/sandbox/host_bootdev.c
+++ b/fs/sandbox/host_bootdev.c
@@ -6,7 +6,6 @@
  * Written by Simon Glass <sjg@chromium.org>
  */
 
-#include <common.h>
 #include <bootdev.h>
 #include <bootflow.h>
 #include <bootmeth.h>
diff --git a/fs/sandbox/sandboxfs.c b/fs/sandbox/sandboxfs.c
index 4ae41d5b4db1..773b583fa43e 100644
--- a/fs/sandbox/sandboxfs.c
+++ b/fs/sandbox/sandboxfs.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2012, Google Inc.
  */
 
-#include <common.h>
+#include <stdio.h>
 #include <fs.h>
 #include <malloc.h>
 #include <os.h>
diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
index 3592338a6865..77e39ca407e4 100644
--- a/fs/semihostingfs.c
+++ b/fs/semihostingfs.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2012, Google Inc.
  */
 
-#include <common.h>
+#include <stdio.h>
 #include <fs.h>
 #include <malloc.h>
 #include <os.h>
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 3e7160352e6c..788f88f04952 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -29,7 +29,6 @@
 #include <linux/writeback.h>
 #else
 
-#include <common.h>
 #include <malloc.h>
 #include <memalign.h>
 #include <linux/bitops.h>
diff --git a/fs/ubifs/ubifs.c b/fs/ubifs/ubifs.c
index a509584e5d71..75de01e95f7c 100644
--- a/fs/ubifs/ubifs.c
+++ b/fs/ubifs/ubifs.c
@@ -11,7 +11,6 @@
  *          Adrian Hunter
  */
 
-#include <common.h>
 #include <env.h>
 #include <gzip.h>
 #include <log.h>
diff --git a/fs/yaffs2/yaffs_mtdif.c b/fs/yaffs2/yaffs_mtdif.c
index 50fed2d4b150..0eec22bc4a54 100644
--- a/fs/yaffs2/yaffs_mtdif.c
+++ b/fs/yaffs2/yaffs_mtdif.c
@@ -12,7 +12,6 @@
  */
 
 /* XXX U-BOOT XXX */
-#include <common.h>
 
 #include "yportenv.h"
 
diff --git a/fs/yaffs2/yaffs_mtdif2.c b/fs/yaffs2/yaffs_mtdif2.c
index 81a4d964f3e9..2bf171f99f13 100644
--- a/fs/yaffs2/yaffs_mtdif2.c
+++ b/fs/yaffs2/yaffs_mtdif2.c
@@ -14,7 +14,6 @@
 /* mtd interface for YAFFS2 */
 
 /* XXX U-BOOT XXX */
-#include <common.h>
 #include <linux/bug.h>
 #include <linux/errno.h>
 
diff --git a/fs/yaffs2/yaffs_uboot_glue.c b/fs/yaffs2/yaffs_uboot_glue.c
index 0a920561149a..deddbaac51eb 100644
--- a/fs/yaffs2/yaffs_uboot_glue.c
+++ b/fs/yaffs2/yaffs_uboot_glue.c
@@ -19,7 +19,6 @@
  * This version now uses the ydevconfig mechanism to set up partitions.
  */
 
-#include <common.h>
 #include <div64.h>
 #include <malloc.h>
 #include <linux/printk.h>
diff --git a/fs/zfs/dev.c b/fs/zfs/dev.c
index fcd9893b3ac2..722c6a86176c 100644
--- a/fs/zfs/dev.c
+++ b/fs/zfs/dev.c
@@ -8,7 +8,6 @@
  */
 
 
-#include <common.h>
 #include <config.h>
 #include <fs_internal.h>
 #include <zfs_common.h>
diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
index bfc11fa6676b..c44e7ece5dfb 100644
--- a/fs/zfs/zfs.c
+++ b/fs/zfs/zfs.c
@@ -10,7 +10,6 @@
  *	Copyright 2004	Sun Microsystems, Inc.
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <linux/stat.h>
diff --git a/fs/zfs/zfs_fletcher.c b/fs/zfs/zfs_fletcher.c
index 008a303ec796..b06c335626a4 100644
--- a/fs/zfs/zfs_fletcher.c
+++ b/fs/zfs/zfs_fletcher.c
@@ -8,7 +8,6 @@
  * Use is subject to license terms.
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <linux/stat.h>
 #include <linux/time.h>
diff --git a/fs/zfs/zfs_lzjb.c b/fs/zfs/zfs_lzjb.c
index b42d4980129f..e79c5b4278fd 100644
--- a/fs/zfs/zfs_lzjb.c
+++ b/fs/zfs/zfs_lzjb.c
@@ -8,7 +8,6 @@
  * Use is subject to license terms.
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <linux/stat.h>
 #include <linux/time.h>
diff --git a/fs/zfs/zfs_sha256.c b/fs/zfs/zfs_sha256.c
index cb5b1c06834d..602d75254ff9 100644
--- a/fs/zfs/zfs_sha256.c
+++ b/fs/zfs/zfs_sha256.c
@@ -8,7 +8,6 @@
  * Use is subject to license terms.
  */
 
-#include <common.h>
 #include <malloc.h>
 #include <linux/stat.h>
 #include <linux/time.h>
diff --git a/include/jffs2/load_kernel.h b/include/jffs2/load_kernel.h
index 9346d7ee9f1b..fa4600e84fc0 100644
--- a/include/jffs2/load_kernel.h
+++ b/include/jffs2/load_kernel.h
@@ -10,6 +10,7 @@
  *-----------------------------------------------------------------------*/
 
 #include <linux/list.h>
+#include <linux/string.h>
 
 /* mtd device types */
 #define MTD_DEV_TYPE_NOR	0x0001
-- 
2.34.1

