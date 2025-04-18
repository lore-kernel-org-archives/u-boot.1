Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F24EC369C9
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 10:59:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B17C831C3;
	Fri, 18 Apr 2025 12:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fYEg/DaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0800A830A0; Fri, 18 Apr 2025 12:59:40 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEAD382E25
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 12:59:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-86192b64d0bso136023539f.3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744973975; x=1745578775; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Csmcg4/3KAFUUv3SRMZyfCm2ga86Aw1ZAM3uIVbe9vM=;
 b=fYEg/DaUUVcxaxbI9rCRV/byg5xmYhGNRoPTXGW95qs5cwqp0wHT9LHNai3BmiaQPm
 BqkJM6pF55cgfTvM2P/9p+Y/hSJrhHeAkH2+Rg4e8kB4jeqES8p7v4B74CxORSTrng5T
 ML55gK83JbAF4ynXHnSLjjmXKSt8IJoYZifOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744973975; x=1745578775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Csmcg4/3KAFUUv3SRMZyfCm2ga86Aw1ZAM3uIVbe9vM=;
 b=BE6xPb98thzIE5OnfwBvBfPPg3Bme+Aq7vHDJiAdec12jSrPQ4NeYUC7QjpbT+lKs4
 LY+wsZ4caUaBNMFBl02zSK0uHDw4w0rKAE+elceXp0vj56BtqhLIJAjrIzgyUQIihcCK
 vQEt9TGSsBYNhHIDCxGTFMBPVQFNcKUwvL+EM5z3A0fnpvFcYkz7e53tvphi83SEZEAj
 FJHqFuS57DCU9Zo5lbJ7DkMo+/SDBVNKmskQq2tA8+CMd8h75oSL5F2Q60/S3MIz/49A
 ROwQhRZDTiRbzRfD4dWeIpshGFzV6VR5T17m6UFxW70zLw6Tv8Q2vyOr3xlwKYHRBii0
 NKlA==
X-Gm-Message-State: AOJu0Yz0wi40CGoF/Jz1fgyy8xflXT9/JC+yWLLtFkM8JTnD9tGD86ce
 CILCzgkppzVIHWqO9jZe94jU1bLdOQDjsKJMfJgXWHEPQdw89Noj9fBGXoCnDCuyd0Pvrlwx1G8
 =
X-Gm-Gg: ASbGncsC2bDtCmCPcnceY9lmxPdQZIUArjc3yoTZy+WEw0fu6X8i3AofUDIJh6gpDm6
 NLLxcyCTqarPPww3veQtOSLYUa5zaTFmW3CcZsrjGPSLG6yGLtL4dhA4V74SQEVFmUazZ3pflap
 veL0kkykZiQSnkb8+jbtImVdV+0g6AizNPdKcuH38eqva2HihfvWa1DyIDWBZxmfk46jL99aXdM
 alsSId+0X7zmvFssHbzfu4c9XgTaT08zZDh/JmGihoUjZpMRhHYf4BhqZycrseTF2bOCiOlGhay
 Fj7ifhysjPSA3xtxWWzmEYnzNgs4kOIqb+oFHSOuGmPhKmVNGoJhvojhpYvMojXVOkuehUNKrdE
 Evw==
X-Google-Smtp-Source: AGHT+IE9sgR4Mjo9kui0ElQ+4fCdmtkT0/3v1paR9m77cgZQraHyCLrs3yW9wRFGZ/+m0KOX0278ew==
X-Received: by 2002:a05:6602:4809:b0:85b:43a3:66b2 with SMTP id
 ca18e2360f4ac-861dbe22a33mr214307539f.7.1744973975488; 
 Fri, 18 Apr 2025 03:59:35 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f6a395765esm380588173.107.2025.04.18.03.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Apr 2025 03:59:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <simon.glass@canonical.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <l.majewski@samsung.com>
Subject: [PATCH v2 3/3] ext4: Add a few overflow checks in the writing code
Date: Fri, 18 Apr 2025 04:59:15 -0600
Message-ID: <20250418105919.1645824-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250418105919.1645824-1-sjg@chromium.org>
References: <20250418105919.1645824-1-sjg@chromium.org>
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

Some memory allocations make use of data from the disk, so add some
overflow checks.

Adjust LOG2_BLOCK_SIZE() so it is easier to read.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

Changes in v2:
- Use Linux macros instead of gcc built-ins

 fs/ext4/ext4_write.c | 25 +++++++++++++++++++++----
 include/ext_common.h |  3 +--
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index d109ed6e90d..a9a53214dce 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -25,6 +25,7 @@
 #include <malloc.h>
 #include <memalign.h>
 #include <part.h>
+#include <linux/overflow.h>
 #include <linux/stat.h>
 #include <div64.h>
 #include "ext4_common.h"
@@ -108,8 +109,15 @@ int ext4fs_get_bgdtable(void)
 {
 	int status;
 	struct ext_filesystem *fs = get_fs();
-	int gdsize_total = ROUND(fs->no_blkgrp * fs->gdsize, fs->blksz);
+	size_t alloc_size;
+	int gdsize_total;
+
+	if (check_mul_overflow(fs->no_blkgrp, fs->gdsize, &alloc_size))
+		return -1;
+	gdsize_total = ROUND(alloc_size, fs->blksz);
 	fs->no_blk_pergdt = gdsize_total / fs->blksz;
+	if (!fs->no_blk_pergdt)
+		return -1;
 
 	/* allocate memory for gdtable */
 	fs->gdtable = zalloc(gdsize_total);
@@ -117,7 +125,7 @@ int ext4fs_get_bgdtable(void)
 		return -ENOMEM;
 	/* read the group descriptor table */
 	status = ext4fs_devread((lbaint_t)fs->gdtable_blkno * fs->sect_perblk,
-				0, fs->blksz * fs->no_blk_pergdt, fs->gdtable);
+				0, gdsize_total, fs->gdtable);
 	if (status == 0)
 		goto fail;
 
@@ -599,10 +607,17 @@ int ext4fs_init(void)
 	int i;
 	uint32_t real_free_blocks = 0;
 	struct ext_filesystem *fs = get_fs();
+	size_t alloc_size;
+
+	/* check for a reasonable block size, no more than 64K */
+	if (LOG2_BLOCK_SIZE(ext4fs_root) > 16)
+		goto fail;
 
 	/* populate fs */
 	fs->blksz = EXT2_BLOCK_SIZE(ext4fs_root);
 	fs->sect_perblk = fs->blksz >> fs->dev_desc->log2blksz;
+	if (!fs->sect_perblk)
+		goto fail;
 
 	/* get the superblock */
 	fs->sb = zalloc(SUPERBLOCK_SIZE);
@@ -629,7 +644,9 @@ int ext4fs_init(void)
 	}
 
 	/* load all the available bitmap block of the partition */
-	fs->blk_bmaps = zalloc(fs->no_blkgrp * sizeof(char *));
+	if (check_mul_overflow(fs->no_blkgrp, sizeof(char *), &alloc_size))
+		goto fail;
+	fs->blk_bmaps = zalloc(alloc_size);
 	if (!fs->blk_bmaps)
 		goto fail;
 	for (i = 0; i < fs->no_blkgrp; i++) {
@@ -649,7 +666,7 @@ int ext4fs_init(void)
 	}
 
 	/* load all the available inode bitmap of the partition */
-	fs->inode_bmaps = zalloc(fs->no_blkgrp * sizeof(unsigned char *));
+	fs->inode_bmaps = zalloc(alloc_size);
 	if (!fs->inode_bmaps)
 		goto fail;
 	for (i = 0; i < fs->no_blkgrp; i++) {
diff --git a/include/ext_common.h b/include/ext_common.h
index 6e17fbd2771..35d3a1844eb 100644
--- a/include/ext_common.h
+++ b/include/ext_common.h
@@ -67,8 +67,7 @@ struct cmd_tbl;
 #define EXT2_BLOCK_SIZE(data)	   (1 << LOG2_BLOCK_SIZE(data))
 
 /* Log2 size of ext2 block in bytes.  */
-#define LOG2_BLOCK_SIZE(data)	   (le32_to_cpu		   \
-				    (data->sblock.log2_block_size) \
+#define LOG2_BLOCK_SIZE(data)	(le32_to_cpu((data)->sblock.log2_block_size) \
 				    + EXT2_MIN_BLOCK_LOG_SIZE)
 
 #define EXT2_FT_DIR	2
-- 
2.43.0

base-commit: 5841e78ed6ebd31b26553003e880be378b232cd9
branch: sec2
