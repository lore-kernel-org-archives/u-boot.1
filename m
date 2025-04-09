Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99524C36002
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 21:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A895983950;
	Wed,  9 Apr 2025 23:03:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="M/oqQw2y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A498283950; Wed,  9 Apr 2025 23:03:31 +0200 (CEST)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C63878394F
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 23:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-85e751cffbeso14236939f.0
 for <u-boot@lists.denx.de>; Wed, 09 Apr 2025 14:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744232607; x=1744837407; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rcbTQWIY7/uYgoVfvjZE1j4HdEQOlJgIekzYW5jlM8o=;
 b=M/oqQw2yQXIb9IHiVDhZ+/HoKj7KelzU8TfXc3gGKvLvQWRoJh8x6CTgEerrH6mWMs
 19baxVYnHhbLLmY+4ve8/trvPCucwHYMBuc7GryvMG8dPMTScBewoaJDn45m2fMBTcRU
 APfDoDA34Tl3rq7/go+O7tahbJvYrecy19g7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744232607; x=1744837407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rcbTQWIY7/uYgoVfvjZE1j4HdEQOlJgIekzYW5jlM8o=;
 b=YLl2ZUgoW2sM31UBkw1cjfTGIm+Z4hZk90H+tXtxzKjVXs1yP/q6a0wNSKCxYaBaOq
 g0rBVEg2bHvSaHX3b3s/wEAxL60Lwc00gfkVPOV56kZa3lChIezvpQu6Knu5AMEqWT4d
 wp/6sjQ5JJMOmaekUYPm5wLbHPCf05RtQxOwsjqS4gzcmR19gSVbRav9Tv4QjlGqAMYl
 vnf0xMvAgdRV+nyvfppBx/Jw92rgbpA0JvnlFIMqKONXK/8OCbZQ8am/idsnj1//f9QU
 vphhgugQe/NlrIE8wimSpwjqfAzvSWgyU5U7IA12wjAMVsuT0OzF9Jw2BX4Hkrb99N3E
 zg5Q==
X-Gm-Message-State: AOJu0YwMJh51hZ0+8rDQbkQD+3H6oH4TU/iHAYJmc8Mfso5I48LsBY8+
 ZUv2V5oXOI0JgI54yZa0ja6LXDCekVkpjq9AeuFrTC+pI87xSoemYrEBibbcmvx+q5yXQH0rR9U
 =
X-Gm-Gg: ASbGncsb9QLIGckJopv2ev+8gSftntM0y7hewBFzxJE10XHRxdnNtgWSpuM9aQgOR7S
 0nnHJkfhW+ssecYCpkDeeNz5KUBOORiqahMqAb30UrLqDmMG6feykG886mlLiWzQk/786/4Dmr0
 rVOCK3UViJBcdlOuyOE+mH86wmrQxZ77Z63mzqu1x3q9QTOHzCVE64G/ByI0unMuIfguA+lbd7P
 Tuo7cCnTp/kMj9/ek2sOzugcmUVqNqxkf6p/JWr1/c56KduSszuhlZwj1VJIaRoJTtSgLS4C7vb
 GJNZ/Sy5TVKG6GmsSJ7undx1bB7SVq9RC+GS1i2WgXejMaM7lq5kM2SkaU0BSqKOFkOJvT6Duf4
 cJw==
X-Google-Smtp-Source: AGHT+IEXAJNRhkrFzuwqOKYawwRrMkJQQm0BnhnzII2moDSCdaVNU3lwWFTY2BZNYUzUfD8B9UbvXg==
X-Received: by 2002:a05:6602:27d6:b0:85b:577b:37da with SMTP id
 ca18e2360f4ac-8616edee91bmr29653939f.9.1744232606899; 
 Wed, 09 Apr 2025 14:03:26 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505cf8243sm419259173.21.2025.04.09.14.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 14:03:26 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <simon.glass@canonical.com>,
 Jixiong Hu <Jixiong.Hu@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Richard Weinberger <richard@nod.at>, Tom Rini <trini@konsulko.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Majewski?= <l.majewski@samsung.com>
Subject: [PATCH] RFC: ext4: Add a few overflow checks in the writing code
Date: Wed,  9 Apr 2025 15:02:37 -0600
Message-ID: <20250409210245.540952-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
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

Note: This is a trial to help figure out the best way to deal with these
sorts of things. Feedback welcome.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
---

 fs/ext4/ext4_write.c | 24 ++++++++++++++++++++----
 include/ext_common.h |  3 +--
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index d109ed6e90d..ebb1dad4fc9 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -108,8 +108,15 @@ int ext4fs_get_bgdtable(void)
 {
 	int status;
 	struct ext_filesystem *fs = get_fs();
-	int gdsize_total = ROUND(fs->no_blkgrp * fs->gdsize, fs->blksz);
+	size_t alloc_size;
+	int gdsize_total;
+
+	if (__builtin_mul_overflow(fs->no_blkgrp, fs->gdsize, &alloc_size))
+		return -1;
+	gdsize_total = ROUND(alloc_size, fs->blksz);
 	fs->no_blk_pergdt = gdsize_total / fs->blksz;
+	if (!fs->no_blk_pergdt)
+		return -1;
 
 	/* allocate memory for gdtable */
 	fs->gdtable = zalloc(gdsize_total);
@@ -117,7 +124,7 @@ int ext4fs_get_bgdtable(void)
 		return -ENOMEM;
 	/* read the group descriptor table */
 	status = ext4fs_devread((lbaint_t)fs->gdtable_blkno * fs->sect_perblk,
-				0, fs->blksz * fs->no_blk_pergdt, fs->gdtable);
+				0, gdsize_total, fs->gdtable);
 	if (status == 0)
 		goto fail;
 
@@ -599,10 +606,17 @@ int ext4fs_init(void)
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
@@ -629,7 +643,9 @@ int ext4fs_init(void)
 	}
 
 	/* load all the available bitmap block of the partition */
-	fs->blk_bmaps = zalloc(fs->no_blkgrp * sizeof(char *));
+	if (__builtin_mul_overflow(fs->no_blkgrp, sizeof(char *), &alloc_size))
+		goto fail;
+	fs->blk_bmaps = zalloc(alloc_size);
 	if (!fs->blk_bmaps)
 		goto fail;
 	for (i = 0; i < fs->no_blkgrp; i++) {
@@ -649,7 +665,7 @@ int ext4fs_init(void)
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

base-commit: ea9e72801c4c3e3542afe40f89e7e0822cabfcf8
branch: sec
