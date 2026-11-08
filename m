Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2BB606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XzITxu34;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nEbPIkCf
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DED8040608;
	Sun,  8 Nov 2026 15:12:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ChMP2xYild36; Sun,  8 Nov 2026 15:12:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 17744405F5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794150730;
	b=Rn6BMtW2fAq96iIGzicXloqWGBNpGfWcGQJ1E5hS49FTqu2x4tbzGwCWJJhyUY3lXxw3
	 1CbuLHdS6LafcBvVtNMerwoPOlpUoQPHPM59+zwhiMVBSauS/zq0mQvNZ0dCpdKv5vmtD
	 ZRn1H/iuW5P3zTTYFcUNmUBKlRhekL/hQEcFAAk5RfNwdr6r9TBQYzdno390IV7xvwlzA
	 Z+X0BJ8Xy+WzdwnAVuLqhl3ddYA4fw8gohD3z4oznnhkLPtqfY0zPZZKZXrVAfN908Wc0
	 AkashR9RFITofiD0jhxvIQgcWWjKYI/NASJwwShdtQ0ONeH5A6VR/bv8YXvneDjXkfA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794150730;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=c+dL0LInU9lRTdLiJfVLmN3r/SyDYwmJQJEzbMqSRr0=;
	b=aTWJKc1HXawl3L7Yr0G+MOsl0G1/Asth7Pg1KmPINEzVvkc9WqQh5HH4o+fJiNMd9xv0
	 olyN6F7a98QyhJhvC95s0hEHX3i4Znm3MqteVbXMbctv4EcJmEjaPhKe+B3sLvOQZ+xDt
	 4XXB5hJvbcmPp5frVMGnIt4/gSyIUuyVlJ02vsvD0PcztoFNXf4cv2dlQxkA8WQGpWLUv
	 0ikdZ/TKwxOchzMDlhgsf1TDQG3a/IwYcqJtcDSihOAU4x+P74ZKERf3taH8AM8fBs3C6
	 RuGJV+JhDijJQ1gNhxoHa2ybyVd4GKL+RnJZ6xAz5AM/D6rsZfHoigr30cKtKU3Relg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794150730;
	bh=c+dL0LInU9lRTdLiJfVLmN3r/SyDYwmJQJEzbMqSRr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XzITxu34DgDKTqOYFR/Q9UenZzAjMPDyY44674oiggLGmQtvcTNvRT1DFZiH3Yc9H
	 VDB0oVfgKFbnC8Th8IvXg7mqhBRwLkWqkSSnhaTrdczaLSI1OHlLRVRxLhEiohAf/z
	 igZgqZAYBXWUA2Kqmia6BWgNCAJLXAWQTUHurUew7PGTkf++9+HQdqSSpHNhpgrK1r
	 YVewR9WcUUVkyozCJWOM7O1JBhC3kG4CS6fVzyoYjx4tVCkc8A1ZsEvLZxZJF0C+EB
	 mRMt3D944sTyDOgEhcmmbJHuxSvh2TcATwSte//8M411N/l9cYPV0xRYGZ6qQYVyG0
	 rRgaZAxWMBulQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17744405F5;
	Sun,  8 Nov 2026 15:12:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C978362
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E333400A8
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f0kSS_IlJta7 for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 15:12:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 61B184005E
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32e; helo=mail-wm1-x32e.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=nEbPIkCf
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61B184005E
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:07 +0000 (UTC)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so653885e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 07:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794150726; x=1794755526;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=c+dL0LInU9lRTdLiJfVLmN3r/SyDYwmJQJEzbMqSRr0=;
 b=nEbPIkCfxTXtldDhsngdO7xqx9gSNTCnH+ejzVqN/s1N63CKhVZ43kG835ijt+tnhR
 lJSLWnIoa+3rjmbLd4L3FV2HDT/mohtBQtPZTmIqTV11WlxOVLdHm7N/n2SDHk84Lpyo
 IMdCqXVirZDxt04S6/eBnbSSrbg8fZmBmAWfxCoMS3uGnZqYyJyfpGXd8WK5ePn9h6yu
 3Dq+ZelMvXnw+Ds6oqdurIoMVOKJEOrA+kxPLLLJgx8XxSnUhSTGM07rQkFwm5TrWSJo
 0qhLMoN06RofntVbnAFq8PthFdO5lI+Vih9xMu5BywYekALGc+MjmfwqZzQqqgofw7hS
 E7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794150726; x=1794755526;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c+dL0LInU9lRTdLiJfVLmN3r/SyDYwmJQJEzbMqSRr0=;
 b=qNW1k5RaWuzc7ZaQkmCxSz9q6TBo+Fic7dnmBDojqul47jc3jTlT/uRhbfgvPKJykw
 iyTB2bL2dE4h2ghxLvIO4IAmFS06sjx64dRKR0uTDl5YUG/xM2fjf3qoNHbCnmahJgnT
 +aXLWiAlPh8wS3PHqrtZEUv7J32dxPgsf6Jdq08UskckxSzICWGLNin+/o7gdOHmh4FJ
 8n09PG5hzMvKAimmfDq0X0ByRTK0XHwePSnSlFmRhJsctniZAvMqCyGBxk3CZ28383sh
 MSti885DuyLLXEgK3ebGHUErwAvMPc6XQYMNgOYOMK92Fp0NachmF3lvk8OMy0RLB0Vd
 l7fA==
X-Gm-Message-State: APuU4Z/wuhc6g5gjPKGOC8ulryyUnOVPiO09+AIPMJA2wQg6SbP3MRa4
 EwiI5aZx+ic7i3ZjHN0ta2w0gUN6v6F8hX1J2SRaMf0+3GbLClggfWeY
X-Gm-Gg: AYBFou3juQ2GPiNw0xHEtqO4t/+bSV9/8GTEaq9p8DD4eexNZZM3dP6stMeQHh81yCQ
 is4rEc7tX632hi9/b+7Miw7w4W97RE/ACdZB7w6CFqmKYfURgCs4HIe7ju8k6seFFBwCM/W/Ogi
 AzPs5TJ1zk4P2YlD6TCnseLz3+EF1i2y37/jgSVzkofCypNCulirlyAnUrNgVrqoFZ0wrVxV7O6
 7vM+R9isTIOx92WpInKlA5iHiEJFoqJ6SST2AXp68MMcRtGAgRi4wgWfE78UTHAWzwzwwY63WhQ
 NZPJdRlni5+crwUIFJ0oZiA9EajD9gWsZC+FReKkxb3s+sZRu+I+t9YJVGK9DhgAeuYGOhrkOsi
 tZIvvYzhtwwo2Bc5DAIYh6YemlF2ggLNWG7G+qnoLWaQRDInHEnbADYHLbivBeur9KfvBOIT36i
 iIUlwGVmUgj/8A6EIiohcyy7Y8NyofuMfmgdHAPjCz8kCvyD4KgMR6WbJncBjvSa8HT4b0ONP8w
 eAM/nNNGeYbXCHbAYZlPB7oPRR/XcVo03qI341qD8ItW+xjm1clt48s3knNlDwKm6tCOccXRP5m
 GdhQqgcO4vF3jU3JJPJO8+MPft9ymls=
X-Received: by 2002:a05:600c:37c9:b0:4a3:59c9:a744 with SMTP id
 5b1f17b1804b1-4b963c6c533mr30051175e9.7.1794150725892; 
 Sun, 08 Nov 2026 07:12:05 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b7efb1547fsm289325385e9.11.2026.11.08.07.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 07:12:05 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/6] fs: ext4: use ext4fs_blk_to_group() in
 ext4fs_get_new_blk_no()
Date: Sun, 08 Nov 2026 15:12:04 +0000
Message-ID: <eb534601-abb7-4912-be31-a9ce05ec7be3@gmail.com>
In-Reply-To: <5072bec2-e2e3-405d-91eb-58fe78ea6669@gmail.com>
References: <5072bec2-e2e3-405d-91eb-58fe78ea6669@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

ext4fs_get_new_blk_no() works out the block group of the next block to
allocate with its own arithmetic, which takes the first data block to
be block 1 with 1 KiB blocks and block 0 otherwise. Now that
ext4fs_init() refuses any other first data block, ext4fs_blk_to_group()
gives the same group, so use it, and step to the first block of the next
group from the first data block too.

Running past the last group means here that the filesystem is full, not
that a block number is corrupt, so first check quietly that the block
lies inside the filesystem, as ext4fs_get_new_inode_no() does for
inodes, and stop rather than skip past a full last group. The search for
the next block then ends at the end of the filesystem rather than at the
end of the last group, so it no longer takes a block past the end when
the padding bits of the last group's bitmap are clear.

Suggested-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 fs/ext4/ext4_common.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 273e6628b8d..ccfce5c745c 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -1037,10 +1037,11 @@ uint32_t ext4fs_get_new_blk_no(void)
 {
 	short i;
 	short status;
-	int remainder;
-	unsigned int bg_idx;
+	int bg_idx;
 	static int prev_bg_bitmap_index = -1;
 	unsigned int blk_per_grp = le32_to_cpu(ext4fs_root->sblock.blocks_per_group);
+	uint32_t first_data_block =
+		le32_to_cpu(ext4fs_root->sblock.first_data_block);
 	struct ext_filesystem *fs = get_fs();
 	char *journal_buffer = zalloc(fs->blksz);
 	char *zero_buffer = zalloc(fs->blksz);
@@ -1092,28 +1093,27 @@ uint32_t ext4fs_get_new_blk_no(void)
 	} else {
 		fs->curr_blkno++;
 restart:
+		/* no free block left after the last one allocated */
+		if (fs->curr_blkno >=
+		    le32_to_cpu(ext4fs_root->sblock.total_blocks))
+			goto fail;
 		/* get the blockbitmap index respective to blockno */
-		bg_idx = fs->curr_blkno / blk_per_grp;
-		if (fs->blksz == 1024) {
-			remainder = fs->curr_blkno % blk_per_grp;
-			if (!remainder)
-				bg_idx--;
-		}
+		bg_idx = ext4fs_blk_to_group(fs, fs->curr_blkno);
+		if (bg_idx < 0)
+			goto fail;
 
 		/*
 		 * To skip completely filled block group bitmaps
 		 * Optimize the block allocation
 		 */
-		if (bg_idx >= fs->no_blkgrp)
-			goto fail;
-
 		struct ext2_block_group *bgd = NULL;
 		bgd = ext4fs_get_group_descriptor(fs, bg_idx);
 		if (ext4fs_bg_get_free_blocks(bgd, fs) == 0) {
-			debug("block group %u is full. Skipping\n", bg_idx);
-			fs->curr_blkno = (bg_idx + 1) * blk_per_grp;
-			if (fs->blksz == 1024)
-				fs->curr_blkno += 1;
+			debug("block group %d is full. Skipping\n", bg_idx);
+			if (bg_idx + 1 >= fs->no_blkgrp)
+				goto fail;
+			fs->curr_blkno = (bg_idx + 1) * blk_per_grp +
+					 first_data_block;
 			goto restart;
 		}
 
@@ -1129,7 +1129,7 @@ restart:
 
 		if (ext4fs_set_block_bmap(fs->curr_blkno, fs->blk_bmaps[bg_idx],
 				   bg_idx) != 0) {
-			debug("going for restart for the block no %ld %u\n",
+			debug("going for restart for the block no %ld %d\n",
 			      fs->curr_blkno, bg_idx);
 			fs->curr_blkno++;
 			goto restart;
