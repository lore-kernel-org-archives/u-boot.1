Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC1B60A2600
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 13:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=iuYW4M7U;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TZ3iDdWW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 31C9780E51;
	Sun, 25 Oct 2026 13:04:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SiTjkQ1I2Um6; Sun, 25 Oct 2026 13:04:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 643F380E86
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792933479;
	b=s8C3jlIPDXoSl01pPThQLFBEJf7VcMQNXJCgbH8TKYkGCIOqJRooPeUCO+7MftmxI+nl
	 G/QgEyFE10DPwcBPSP7+jDoy7L8Zni7RvO/8dqyiRkbAlL9XvyYcz/2f/zlJyOfGeybRy
	 jP2d7mhJtpbxiWMW9yKb9z18Wr3AVDGElBMXyf/1fTxbpgpPEouAI6yWw6ervqepeELGz
	 1wR8hCegsWyjJa2HgkSNQqj/CPWN91av/esVE+7nYx2mK7e4jHkV3BAZK6oOU1ZRDg1oQ
	 ZaTRUR8xkmcIKIYO5kVTZjKMy7qYLnZGbkODfn2k4PaKixJQSvoC1nTt8jqBSlSv5xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792933479;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=RvQexTKh1vNlYEodkuxtXEBEZ/QYzYtN8ucyIYR+1yA=;
	b=WxeaAq69gMvPhMGc9gOSKKbuRyUiP45aordnZY56X6c44A7SAMunYIg8RrILJ2nJ+Os5
	 EAKunE/fUC4H4fOUYyKh8CGrbE6rowrdPCfu0ZROftyNAm9RlMGRc1TrDMCkXqohcK/fP
	 yz6hv0+5elnKqAyQTsAzNGubtanMa2MQ0JzUurKtdYUpZUv9bn0JDEXcJBXjAkY5L2cC7
	 aJE6RXBOh2Pfhcyg5VHWoyW4i6VfummO7vGDIf9B1JkmQHIqF9Tg2aiizGbpZx9iteFRy
	 MxIbGzQsZJlKhKpLBQOWIe17gJOtO84FEVtlUYEjNZuCfQccjD1bYi8NWRvKLDSB5Ag==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792933479;
	bh=RvQexTKh1vNlYEodkuxtXEBEZ/QYzYtN8ucyIYR+1yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iuYW4M7URJobASc0i9HE9MA7smSFc6S3zJ54KoSTpsroUtQamqpLzrYe/I2P+x/8H
	 +obgh2nera3qoEub7gD8SAfWXOEAMHafzKcUezI6F9YT0s4+caA2oBfCzTPhBd/9Z8
	 E2vVIWeFp110X2r6YcxP8TML+E0z2WAZEVTqufk+1FzAotI2NsKtJIeB05tAsmKM51
	 k2nmetnM12xs5yOmCAL+70fzFWaKmKsfYFQOTo8dn94S1Yr30PODFHFQ9d7x3yWI7/
	 1H5GCP66eWMGlmvTVgB9ZPt4lt+ntIF739WEWZSGLJhbSWJqxb6L9HGK9J1fxuuiPq
	 /l6uWoFDNwaJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 643F380E86;
	Sun, 25 Oct 2026 13:04:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 421594D1
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3EBD060F30
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id spdV8MeH_tbG for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 13:04:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4D15960F3F
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792933476;
 b=kn2srebspCe9VxN6MqdkrnfSSYNkt5K63Qtrjo18sdHdugrh/kgOmEytJ4f3b504pb7d
 /8vQY6pThRxEPSJkpKxcLi/Ih89X2n7P48vCziGOU+26n2ZA/qwlOz7afaYiguSPotTcC
 nYIzWotiyO+jwVcjzpvMVXjXWcYvs54jvrpA5X4E6cGWBZHEwVRZmb8Qfzzj9yHQf+GXN
 ZqbVwVs6944kTtAdpdvVwOIOS3eGiftfDAVLYBikr4/jt99DVjtTUG/8Swq48qacI0VqI
 5I0c4RgFh6OjYZ5WOZhAFuftotGJfT+ppWxiOUhC+Kg+kpF06XTTVfRt3p9zCH06Flw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792933476;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=RvQexTKh1vNlYEodkuxtXEBEZ/QYzYtN8ucyIYR+1yA=;
 b=XTbbxYtwtBtUVqW4vPMUysAT9wdfi/niGPc6Iq3PcKRNxm/fAfygvjBlJfvgKYaG2dDd
 PsqtAKiyNCOP470MAPalm2/7hKy7CCt/Y+biBth1LWYjmMlQLUMVIYxoJY3ZlmE16ifyQ
 x3+t04jMxbpqPNilIe1dPv0Jh5lh7QSTwsfVSyw5cnGFuWgKPDtXmJPoD+zuILy2Ly0E/
 X+stjAGyyvc2g1ujaK5qk2LmA+/uUTCprgU3DKQ9LiReU23THYR2n8a4COjuaQDSqnXuk
 BPpIWiPFcxomOhLHZQ3axYikRKYmTv1vqo0IC91u5Es+uYZYa98y92GJL3ONq64SIMw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=TZ3iDdWW; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=TZ3iDdWW
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4D15960F3F
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:35 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so1264935f8f.2
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792933474; x=1793538274;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RvQexTKh1vNlYEodkuxtXEBEZ/QYzYtN8ucyIYR+1yA=;
 b=TZ3iDdWWnNE+3G//DGpr6QjkjbECxQk5P/l2FYqUl5M5UZvf5Zscm7oDP0Gqo39Huc
 Zkra3yo66YQ+fs/hRZk0BfnIIkyvmNsp+yHW5jZ7TW+LY1ANrrUzCSH11H4h8pMUmdxj
 NApilspTL2C6v68miuRRE4+rYmbnGwCmgdPoYPzaad7k5IviexzU28BdxTNRs5jCHrqt
 mX1ib0VBy783KdDAS6jLcAYbVNXOc3dvKRUL206X3H/+EvIQmdFmiXeVEujX01yDglwo
 As0BHHHNzMwF5MpSi6FSenK9AHs3KefQJHaQP1aHvVuRhNaB2qeGXZMAlc4WAfRZpy7u
 AEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792933474; x=1793538274;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RvQexTKh1vNlYEodkuxtXEBEZ/QYzYtN8ucyIYR+1yA=;
 b=dbsf8GjbQSyt4b4zgn8iwTDE2bmjrcRxrbdkMCKbbrl95Wn6uT1rBtAIIdgtjZhQyM
 bul3FOilo138lktpbr2L7rA2+4QLXrkEsZBKmkiL5G8Nbys/0UdqtCROaYT3NoxKaN5V
 nuwJD/V9Z91UaofE1DuR3Lh6ohdxSrvdIP+yQxTRs7z/kPU+wA2qZ/FLZbOGJ2I3TjGX
 CCdplv4DS/35s3TZzn9t/a1GrsoLt4C3E6cRM5CWrI82VeCX7EaHjnt9E5TBtZhiliqQ
 6LRYiKlaIkMawSp4oLOmEe06m4SmhPHYOn6xRolTgJxSIXHORfsNvgfmzm+bsI/836qH
 04Dg==
X-Gm-Message-State: AFq9FYJxz9BY967/lnQM/d/XeOW2zdBOupGCfixqAYPAUAeilr12YhhJ
 FJAlAsBtVyBQFJqtFI1W0m5r3MQYHgEjAyOc9AAuh3q4hRoXyMDPFiLF
X-Gm-Gg: AYBFou2Cyl8HyDmmt8U0G0B7M0f88VWM7d5F76228ZbGTm6r4mQwrF/ChoqRP5trTxi
 cyH+L44RJuXdnns/hF+hTRXkY/iWUTvVDnTc75ovs6ORPGgOYaNzXUXVjR4DqpGB5omcE2+AdzP
 hArxu/Hput7xX2NgR90+ACdpQ6kA/QVAdGUX+ajRe53HifVLSxlZ7C0FHArUJ0tOTTtBvzgffiJ
 IirXGFYeTkHdtwvj/kGA7zgqMtM3uSi+OAix+U3/nVLk0jRGJN5rmvk2lTAFJSWGXcWi7rtpAoi
 tzFfdstC6KK8zhkqsBERJpRAm3TthKfx5QXZRn2XynUHeR5W+3hKkzTYFC+TKiPOOCF6bOVDaO/
 YYEYFDkyhtq4Oy885T58MHWigzYeW1b0CCRlIX+HQ8wR79VEPH2gICwWUGEHk9ElCrWXyhzPC/z
 o5aCvDEbmNaYMUDUvZ3lUlygqr5SgkzbUq9v6wnPXF+LFOP+w4hHY6nlcCbj5qEPJazLZ40HLHq
 6Zzpa2EAfGeq8dsGACvJtVBHeIiR/NDDKmmnmBOJrPR7PzWIi951iAqmg==
X-Received: by 2002:a05:6000:2408:b0:48d:fbf4:895e with SMTP id
 ffacd0b85a97d-48e3eb86626mr9209566f8f.11.1792933473933; 
 Sun, 25 Oct 2026 06:04:33 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd354asm9580467f8f.43.2026.10.25.06.04.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 06:04:33 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH RESEND 5/6] fs: ext4: fix the block group of an inode in the
 write path
Date: Sun, 25 Oct 2026 13:04:31 +0000
Message-ID: <701a5402-c9c0-4bd7-b5fe-36d5747a467f@gmail.com>
In-Reply-To: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
References: <dd4dce11-8583-4124-a8de-c8680536a08b@gmail.com>
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

The inode numbers given to ext4fs_delete_file() and taken as the
parent inode come from directory entries on disk, so also check that
they fall inside the filesystem before using them.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 fs/ext4/ext4_common.c |  6 ++++--
 fs/ext4/ext4_write.c  | 16 ++++++++++++----
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index cff112fb99b..beb64794a72 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -1156,8 +1156,10 @@ int ext4fs_get_new_inode_no(void)
 	} else {
 restart:
 		fs->curr_inode_no++;
-		/* get the blockbitmap index respective to blockno */
-		ibmap_idx = fs->curr_inode_no / inodes_per_grp;
+		/* get the inode bitmap index respective to inode no */
+		ibmap_idx = (fs->curr_inode_no - 1) / inodes_per_grp;
+		if (ibmap_idx >= fs->no_blkgrp)
+			goto fail;
 		struct ext2_block_group *bgd =
 			ext4fs_get_group_descriptor(fs, ibmap_idx);
 		uint16_t bg_flags = ext4fs_bg_get_flags(bgd);
diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index dc37ae1448d..6bae559849a 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -485,6 +485,10 @@ static int ext4fs_delete_file(int inodeno)
 	char *journal_buffer = zalloc(fs->blksz);
 	if (!journal_buffer)
 		return -ENOMEM;
+	if (inodeno < 1 || (inodeno - 1) / inode_per_grp >= fs->no_blkgrp) {
+		printf("Invalid inode number %d\n", inodeno);
+		goto fail;
+	}
 	status = ext4fs_read_inode(ext4fs_root, inodeno, &inode);
 	if (status == 0)
 		goto fail;
@@ -551,7 +555,7 @@ static int ext4fs_delete_file(int inodeno)
 	/* release inode */
 	/* from the inode no to blockno */
 	inodes_per_block = fs->blksz / fs->inodesz;
-	ibmap_idx = inodeno / inode_per_grp;
+	ibmap_idx = (inodeno - 1) / inode_per_grp;
 
 	/* get the block no */
 	inodeno--;
@@ -939,7 +943,9 @@ int ext4fs_write(const char *fname, const char *buffer,
 
 	inodes_per_block = fs->blksz / fs->inodesz;
 	parent_inodeno = ext4fs_get_parent_inode_num(fname, filename, F_FILE);
-	if (parent_inodeno == -1)
+	if (parent_inodeno < 1 ||
+	    (parent_inodeno - 1) / le32_to_cpu(sblock->inodes_per_group) >=
+	    fs->no_blkgrp)
 		goto fail;
 	if (ext4fs_iget(parent_inodeno, g_parent_inode))
 		goto fail;
@@ -1032,7 +1038,8 @@ int ext4fs_write(const char *fname, const char *buffer,
 	temp_ptr = zalloc(fs->blksz);
 	if (!temp_ptr)
 		goto fail;
-	ibmap_idx = inodeno / le32_to_cpu(ext4fs_root->sblock.inodes_per_group);
+	ibmap_idx = (inodeno - 1) /
+		    le32_to_cpu(ext4fs_root->sblock.inodes_per_group);
 	inodeno--;
 	bgd = ext4fs_get_group_descriptor(fs, ibmap_idx);
 	itable_blkno = ext4fs_bg_get_inode_table_id(bgd, fs) +
@@ -1053,7 +1060,8 @@ int ext4fs_write(const char *fname, const char *buffer,
 		/* FIXME: Deallocate data blocks */
 		goto fail;
 	}
-	ibmap_idx = parent_inodeno / le32_to_cpu(ext4fs_root->sblock.inodes_per_group);
+	ibmap_idx = (parent_inodeno - 1) /
+		    le32_to_cpu(ext4fs_root->sblock.inodes_per_group);
 	parent_inodeno--;
 	bgd = ext4fs_get_group_descriptor(fs, ibmap_idx);
 	parent_itable_blkno = ext4fs_bg_get_inode_table_id(bgd, fs) +
