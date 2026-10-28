Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C13606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=dxpG7WoX;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aSYKPmv+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7673F80EF1;
	Wed, 28 Oct 2026 05:51:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FLmxYnsBfFun; Wed, 28 Oct 2026 05:51:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6F17F80EBE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166682;
	b=beuCPTw5BZB8TgR2NClsVJ5kz3i10VN0qbQUhrIVKxicCHo9+0LhjCfFotmbtsI65u/h
	 JS7yvkuPiDfUYrLkxOZ5RQ4LWhW2dBfDIktX4kD73ZINvs0rrcnY8QZIEeRBrH8FXScQh
	 i8tLZVoSeQcRVfwJiND8CDFQ2pCoKe4QA8nYoBfzQwWxyJWrZJG1JwaNiB/y54lQKOmJY
	 bmcMA6FpmCsndWQvFz3NTwt7iDDs1u1uFv4aJg5V1z+M/2ZE+EAVx2dYzkRVtQ/xPHQAU
	 S5uEvo/fKw9L/mGETfrdapinWGSKdNZbiRQdNMkXmnPI2s/ksBcqmNJFDJp3kuHe8eg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166682;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JuIwbqYMC0vF9s9gn81/ETrlE+Oa1ZmFbMOqHHg6RLg=;
	b=jWFekkaFs+7qPN4ytpL/UfPUejTjtcQftyoh7f5Cu2nwlrK28xuQr34CbTGDKNWRckIb
	 eNIR35Sx0uS+Lt/F+in+TswJ0tz/j1eLhbNHf4xrHF0i5cJXO1gDhYr42uXA4n+NnVnRv
	 5LxvYNtZ21khPzi2EFaFFwsE9eCLIJEYHzuhbnlfg6v7eOmb/j27ssXlXE1E6JZ6Jb/Rw
	 uwcl/lzCwX6PH2wEUHjizT11KME395yhiARfnYmQ9sbkcvoHfePICm2tjjmlwnwhzcQiG
	 MAbvLpnY61R2KTdRzurhz3TvxJqqu+hKeRXmtiqANqUzjsVb29U12kM+tU1nFpaD5eA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166682;
	bh=JuIwbqYMC0vF9s9gn81/ETrlE+Oa1ZmFbMOqHHg6RLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dxpG7WoXQ/RIvtA2kTlVw6deihwE0SWWA/iHT7ki7i2jt3bwPL3KTJpNCOyrjoNGc
	 zNKNeQvizi8Ev6lIJLJfjXn848pB2Urh3norNuFQm0lIbVIgctnktAKjxqYU+OB4jY
	 9ngl3AG7//X2KkQYo0DGm2+1I2dymrJyVE7LTAppsTEZhUxXryaD9MCWz6PN/lx9+U
	 3NAY/dmiVhALERV7e4S8vgAxMeom883nAym9KqhFH1bEI3SwezevRbt9geQwgkhW89
	 zNwrr2UBDeMAhI6e5TeHVAuBc3+joJjiGVG5X64XGalkUdzS4cE5dvyG7ZKhLUVhuu
	 G8+7Eamn+thDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F17F80EBE;
	Wed, 28 Oct 2026 05:51:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D3FEB2E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C5E2640580
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BWrXOTYsK2W5 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B86D440581
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166679;
 b=PKsZjvDBrE8CvAHKOYv/At2bJvE8WmzvQeCQcktviWEkK8YHM1zt6wqY1oP0Zs1qdTGj
 pSfFEVFZt58Fhfp7HfFpZxmZwkkUy6IFpGRkkMXqXHZxRtVQ1UMvVQ4NDrhXkGGdVtLBG
 C2RpyciWGOdv2SVA9rmaw/FnzfyP9YVSVPy7QtjjEOu19ZUgNXppNRC0xertCJ/W4B4KI
 QkBo7or0tzIHSoS12S3aUWYvwRoeaqs1FC6v50vPwemKugJL5QxirfIpt1h0rU/F4A+Je
 73fLfOnYqDDxsnnFb4HK+p9Gl00yRX4SGDaaR8Zt+RUSXqEI2n3vM0b5Db2fQUfOPeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166679;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=JuIwbqYMC0vF9s9gn81/ETrlE+Oa1ZmFbMOqHHg6RLg=;
 b=TkuQ5Uvbym6HLgSLEeY5R+LHp+bcCTjaMJk58PmfP0SZN26Cs+Acra4QbGlc0NKkvYQP
 iBu+GhmCsTlzb5Hsjr0cdPl2civtaOzZOFte5fvbv60vwue0Xa5V5stLx0IZzjZvPMzFr
 nI26w3khEF1te6womGNfB+SwaizgR2wuJ6PSCOWKzQ8O3/3HdqwkeHcgCtLpBR0lxMWQd
 Y6yQLbjOridelvCGMpZAw0FSclZPp1kdsoLFVWdyqPJ+3xejLKS+vAlpqt0zFSfx1SJ22
 naFXLD7aNCWGWdFZb06I+TOhYJ9QcQxdmMR0hLS7RTzgbXb9GlghF0TVjnA9QLNjVZQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=aSYKPmv+; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=aSYKPmv+
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B86D440581
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:18 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a60f9474c4so6515875e9.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166677; x=1793771477;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JuIwbqYMC0vF9s9gn81/ETrlE+Oa1ZmFbMOqHHg6RLg=;
 b=aSYKPmv+U6EXIg9z6tVVsyIA2rdcR57Kq1YzQ9LU25KeiurDKsWvst8IKUaBH+Ih7i
 C1k5fZI+01iuI8a02p4IWcdr7jiq0bs88zFwsy85XgoCuRi963Wl9BPDIqQrEQYGl3tT
 38uXyaYwMWn/Ttj0m9wP/QlXA5EeiLp3pMUMVnEIYLNubtiMKA4lash0qYQmR71tunRs
 i8oCNBY+Y9TprKZbrc0VEDakgbZpanhnvUHWPdVOg7j0vhKRNFXJNckzaQqDmMPaegQk
 aL69LrDjpBpZXuJ/F2SX0EYjn95KESThWwDVSPVyt11jEU7Dk2dIKQ5T5Xhs5M775tKI
 +ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166677; x=1793771477;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JuIwbqYMC0vF9s9gn81/ETrlE+Oa1ZmFbMOqHHg6RLg=;
 b=ir+s4I2imrnyteMzyMLFNOum5IYglrLQVhhZO8DUbMpewt7hrZcH28KCBKPgzJ4FwL
 xXpYkNvmuwL2mj+Tj2FyzK5PDhlEka+gDOasdsevELcrFZ8Groh1NiC6RfMQUwX/W60f
 CdvPr+wjgARG/bnkCztk6IEI2Aj0MIcEC7EC1WpJSoJp5pnR+P7wFEBd+YPKw1KrqpEV
 BkA/PJGtUYqLBf+UAJtHQJmPt0LH9kTCrZrlFjqP7yShFyWxtOaeGe/QBMoDa4a4h7is
 0j+j7/OVAo8oD7Abv4pR25sEH2BgtEBWJ/s7EJ37dql0BvKpTRpP1izxArDERBgWkbdi
 x8fw==
X-Gm-Message-State: AFq9FYL/Ea/pt8RNft2/dBScVaXG+BSrj9Np6pvRfGQQ0A+9RSGj1jFk
 gpz0aZGygckRfsEXk81sT7kqcNGbq67FbsuiXUBiPEUutY4bc10SHqRrSirJoTZpfy0=
X-Gm-Gg: AYBFou3SvGlw3TLBf5TEQWCsu/nYFZQVdTwQoy7jTm6jXYPQpwwDtESiHa5nV76AvMo
 N8dl2WqXjE/FHCp+JRXVf8YP4rTsHT/h7s7vKLvEvOAVrLutoGhX6IIX1kC3tvHpUf9pZybFdTk
 hgs9YfKUw/FnsPrrVY7luqyM+o/IINZzTFWX20SA3K5gvZ9Fgpq1dI+p07UWM81p9rCnV8P17Oa
 blGyAdfDkb+GgAZbLSfHODmAdbZU59MrwWjCkvs4YrqAflwP7mEe9CA1uEa74mVz5LHxriF0NHz
 X8/lp6dSj8pdx4xTUKZizy5X9+GLKKu+HacaWx33jiSoyvYgS+N8dkD4P071gfU+0g5J5kwtBYB
 eDrSKVpDKsU5d74WSVw9HAFq8GSQxOv5ip6887b/zwtS0A7Y4kJvebt4QXlbPHquFk7jDEm0p29
 9xW25Bq6agd1jl4sotsg5I7Tkl3rCDFoYVG5jx23vb3y0L6XbjpDit/L4athPUKWxB6zqRazRiT
 9s1rPDoftjLhY8vdQqqLrzT2ZroAftXzAFLSBxH1sSnczRi3nssioSCGXdZKHTeegdBlVnAawRg
 ZsMzzXrKR6LZgPuOLxnG0804p5mwzK0=
X-Received: by 2002:a05:600c:8b05:b0:4a1:fa21:fd90 with SMTP id
 5b1f17b1804b1-4a965ec95ebmr23088035e9.9.1793166676510; 
 Tue, 27 Oct 2026 22:51:16 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a96989ab11sm10046445e9.1.2026.10.27.22.51.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:16 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/6] fs: ext4: fix the block group of an inode in the write
 path
Date: Wed, 28 Oct 2026 05:51:14 +0000
Message-ID: <cc9d77b8-f1b3-414b-aa4f-8350a649566f@gmail.com>
In-Reply-To: <78892543-03de-412e-831f-de840765be59@gmail.com>
References: <78892543-03de-412e-831f-de840765be59@gmail.com>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

From: Ana Bobillo <anabobillo3@gmail.com>

Inode numbers start at 1, so the block group of inode n is
(n - 1) / s_inodes_per_group, as ext4fs_read_inode() computes it. The
write path computes n / s_inodes_per_group instead, in
ext4fs_delete_file(), for the new and the parent inode in
ext4fs_write(), and in ext4fs_get_new_inode_no(). For the last inode
of a group this gives the next group: ext4fs_delete_file() then clears
a bit in the byte before that group's inode bitmap and zeroes an inode
in the wrong inode table, and for the last group of the filesystem
the index is past the end of fs->inode_bmaps[] and the group
descriptor table.

Add ext4fs_inode_to_group(), next to ext4fs_blk_to_group(), which
computes the group that way, and use it in all four places. The inode
numbers given to ext4fs_delete_file() and taken as the parent inode
come from directory entries on disk, so it also checks the inode as
Linux ext4_valid_inum() does: one past the inode count or the last
block group, or a reserved inode other than the root, such as the
journal's, is reported and refused rather than having its blocks
released and its inode zeroed.

When ext4fs_get_new_inode_no() finds no free inode after the last one
it allocated, it goes on past the last group's inode bitmap. Make it
stop at the inode count instead.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v2:
- Add ext4fs_inode_to_group() and use it for every inode bitmap index,
  so a bad parent inode is now reported too
- Reject reserved inodes other than the root, as ext4_valid_inum() does

 fs/ext4/ext4_common.c | 49 +++++++++++++++++++++++++++++++++++++++----
 fs/ext4/ext4_common.h |  1 +
 fs/ext4/ext4_write.c  | 17 ++++++++++-----
 3 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 650597873f8..273e6628b8d 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -998,6 +998,41 @@ err:
 	return -EINVAL;
 }
 
+/**
+ * ext4fs_inode_to_group() - get the block group of an inode
+ *
+ * The inode number may come from disk, so check it before it is used to
+ * index the inode bitmaps and group descriptors: as Linux ext4_valid_inum()
+ * does, it must be the root or a non-reserved inode within the inode count,
+ * and its block group must be inside the filesystem.
+ *
+ * @fs:		filesystem
+ * @inodeno:	inode number
+ * Return:	block group of @inodeno, or -EINVAL if it is not a valid inode
+ */
+int ext4fs_inode_to_group(struct ext_filesystem *fs, int inodeno)
+{
+	struct ext2_sblock *sblock = &ext4fs_root->sblock;
+	uint32_t first_ino = EXT2_GOOD_OLD_FIRST_INO;
+	uint32_t group;
+
+	if (le32_to_cpu(sblock->revision_level) != EXT2_GOOD_OLD_REV)
+		first_ino = le32_to_cpu(sblock->first_inode);
+	if (inodeno != EXT2_ROOT_INO &&
+	    (inodeno < 1 || (uint32_t)inodeno < first_ino ||
+	     (uint32_t)inodeno > le32_to_cpu(sblock->total_inodes)))
+		goto err;
+
+	group = (inodeno - 1) / le32_to_cpu(sblock->inodes_per_group);
+	if (group >= fs->no_blkgrp)
+		goto err;
+
+	return group;
+err:
+	printf("Invalid inode number %d\n", inodeno);
+	return -EINVAL;
+}
+
 uint32_t ext4fs_get_new_blk_no(void)
 {
 	short i;
@@ -1131,7 +1166,7 @@ int ext4fs_get_new_inode_no(void)
 {
 	short i;
 	short status;
-	unsigned int ibmap_idx;
+	int ibmap_idx;
 	static int prev_inode_bitmap_index = -1;
 	unsigned int inodes_per_grp = le32_to_cpu(ext4fs_root->sblock.inodes_per_group);
 	struct ext_filesystem *fs = get_fs();
@@ -1191,8 +1226,14 @@ int ext4fs_get_new_inode_no(void)
 	} else {
 restart:
 		fs->curr_inode_no++;
-		/* get the blockbitmap index respective to blockno */
-		ibmap_idx = fs->curr_inode_no / inodes_per_grp;
+		/* no free inode left after the last one allocated */
+		if (fs->curr_inode_no >
+		    le32_to_cpu(ext4fs_root->sblock.total_inodes))
+			goto fail;
+		/* get the inode bitmap index respective to inode no */
+		ibmap_idx = ext4fs_inode_to_group(fs, fs->curr_inode_no);
+		if (ibmap_idx < 0)
+			goto fail;
 		struct ext2_block_group *bgd =
 			ext4fs_get_group_descriptor(fs, ibmap_idx);
 		uint16_t bg_flags = ext4fs_bg_get_flags(bgd);
@@ -1210,7 +1251,7 @@ restart:
 		if (ext4fs_set_inode_bmap(fs->curr_inode_no,
 					  fs->inode_bmaps[ibmap_idx],
 					  ibmap_idx) != 0) {
-			debug("going for restart for the block no %d %u\n",
+			debug("going for restart for the block no %d %d\n",
 			      fs->curr_inode_no, ibmap_idx);
 			goto restart;
 		}
diff --git a/fs/ext4/ext4_common.h b/fs/ext4/ext4_common.h
index eecc11d9995..eda04b5b3a3 100644
--- a/fs/ext4/ext4_common.h
+++ b/fs/ext4/ext4_common.h
@@ -64,6 +64,7 @@ uint16_t ext4fs_checksum_update(unsigned int i);
 int ext4fs_get_parent_inode_num(const char *dirname, char *dname, int flags);
 int ext4fs_update_parent_dentry(char *filename, int file_type);
 int ext4fs_blk_to_group(struct ext_filesystem *fs, uint64_t blknr);
+int ext4fs_inode_to_group(struct ext_filesystem *fs, int inodeno);
 uint32_t ext4fs_get_new_blk_no(void);
 int ext4fs_get_new_inode_no(void);
 void ext4fs_reset_block_bmap(long int blockno, unsigned char *buffer,
diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index ea7843775b3..0cbbdc6c934 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -473,6 +473,9 @@ static int ext4fs_delete_file(int inodeno)
 	char *journal_buffer = zalloc(fs->blksz);
 	if (!journal_buffer)
 		return -ENOMEM;
+	ibmap_idx = ext4fs_inode_to_group(fs, inodeno);
+	if (ibmap_idx < 0)
+		goto fail;
 	status = ext4fs_read_inode(ext4fs_root, inodeno, &inode);
 	if (status == 0)
 		goto fail;
@@ -539,7 +542,6 @@ static int ext4fs_delete_file(int inodeno)
 	/* release inode */
 	/* from the inode no to blockno */
 	inodes_per_block = fs->blksz / fs->inodesz;
-	ibmap_idx = inodeno / inode_per_grp;
 
 	/* get the block no */
 	inodeno--;
@@ -892,7 +894,8 @@ int ext4fs_write(const char *fname, const char *buffer,
 	long int blkoff;
 	struct ext2_sblock *sblock = &(ext4fs_root->sblock);
 	unsigned int inodes_per_block;
-	unsigned int ibmap_idx;
+	int ibmap_idx;
+	int parent_ibmap_idx;
 	struct ext2_block_group *bgd = NULL;
 	struct ext_filesystem *fs = get_fs();
 	ALLOC_CACHE_ALIGN_BUFFER(char, filename, 256);
@@ -929,6 +932,9 @@ int ext4fs_write(const char *fname, const char *buffer,
 	parent_inodeno = ext4fs_get_parent_inode_num(fname, filename, F_FILE);
 	if (parent_inodeno == -1)
 		goto fail;
+	parent_ibmap_idx = ext4fs_inode_to_group(fs, parent_inodeno);
+	if (parent_ibmap_idx < 0)
+		goto fail;
 	if (ext4fs_iget(parent_inodeno, g_parent_inode))
 		goto fail;
 	/* do not mess up a directory using hash trees */
@@ -1020,7 +1026,9 @@ int ext4fs_write(const char *fname, const char *buffer,
 	temp_ptr = zalloc(fs->blksz);
 	if (!temp_ptr)
 		goto fail;
-	ibmap_idx = inodeno / le32_to_cpu(ext4fs_root->sblock.inodes_per_group);
+	ibmap_idx = ext4fs_inode_to_group(fs, inodeno);
+	if (ibmap_idx < 0)
+		goto fail;
 	inodeno--;
 	bgd = ext4fs_get_group_descriptor(fs, ibmap_idx);
 	itable_blkno = ext4fs_bg_get_inode_table_id(bgd, fs) +
@@ -1041,9 +1049,8 @@ int ext4fs_write(const char *fname, const char *buffer,
 		/* FIXME: Deallocate data blocks */
 		goto fail;
 	}
-	ibmap_idx = parent_inodeno / le32_to_cpu(ext4fs_root->sblock.inodes_per_group);
 	parent_inodeno--;
-	bgd = ext4fs_get_group_descriptor(fs, ibmap_idx);
+	bgd = ext4fs_get_group_descriptor(fs, parent_ibmap_idx);
 	parent_itable_blkno = ext4fs_bg_get_inode_table_id(bgd, fs) +
 	    (parent_inodeno %
 	     le32_to_cpu(sblock->inodes_per_group)) / inodes_per_block;
