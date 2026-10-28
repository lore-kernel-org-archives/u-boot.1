Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660B1606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j8B9f2re;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fC3bnWRB
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42D5D80E33;
	Wed, 28 Oct 2026 05:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e1oTy3CN1Zoe; Wed, 28 Oct 2026 05:51:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DC58380E2B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166678;
	b=XsE5HE0iCwB5f7fE2y216lVNY0baBNOmHx3pyxI1FkErare7fHePZc9ViNO/GInlaqOy
	 bruEE5IoXbjAikGPrDeROz1Ml4kDEAXrxMaYuK+AyIAbG2nKF0JCmxUFVcNJ4tlH562CK
	 +2P+Pv2PKGSniSe0FR0NKGHlzwxPoomIx+J6Qq3YA+LfdOEHoI3+Y7hPsRb7BGP+rTqUb
	 PgY3x2yGV7UblOdDrLb+NgrmF1msoXJVvulOghjAnpePKOFN9op6+uumnMxPwqcBKu8TK
	 AL0AxOruSbD+RkXryqE5eAnfW2f/QM/Odnuc3hSky3McJVEntEuk0DMJ2DOyvog3yJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166678;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/443A5HzecrnH3YOM2d3HJGN9KZUnGC/xrdWuWND9mc=;
	b=h+qBadA5SYcmpXSPtT2zWjBwbYKqdYLo44joQaGwqppq2xEFMPyvYtsmiYfZKBnLw0Kp
	 UaRwuwv8NpkySvpllG3EEnsVWTQmhUTJSFdhHHspsoFdwQePAdpDb8UtKZN17ODSLS3fP
	 wbdGX8yY4omNNty3TtqIEDAEgyj+Db19cW+Ju3RLb9ZMzgPjjUcYTfZ3dE/RSNK7bMTkH
	 /cA9RK6msSGYNgMqMKA9Ipkn6JmKd42fHKUJ596lyR+n8qVq3dH9jv10IJsVmRtY7m6dq
	 xW418weov0DhHbafoAyNJaKNkCxHTYu35Gbd29CAaYUHb/yzj59J1XeFakHu0K1TzJg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166678;
	bh=/443A5HzecrnH3YOM2d3HJGN9KZUnGC/xrdWuWND9mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j8B9f2re8PUfHef6JpTKc02dZWBVhApYBaeliigbExRhx65wLROgqsby0e/5oiEVh
	 hsYCv05OkVva/Z1H/vHI/DTb5mmuPPYyDthE5kcadAUvQ42Ku7sUGEgMqZztAIGya1
	 BKXPMWm1Biv6fnJmWV3jhJ5kjrVIHFOgIPCL0b4PCBsuEx6oHPH3PjWOdZxi04v4UF
	 uCpzPAsrjHGgDmJTO5X7BNv4h0vABgBOiD4Vuj1urMKYx/A0cpeJ31Zu9wXp/mKRw5
	 yS7TjWZ3nRdPJ8Nm08iUPqX/TTlL0pkqzQNI3km+snQdxwik8tBsWUZUh30E/s6arq
	 bl6ZTesyyJXlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC58380E2B;
	Wed, 28 Oct 2026 05:51:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 68CF62E5
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F02A40581
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9kbNBKY_-Yii for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 070E040580
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166673;
 b=mBdrf39rVI4vgyGLTDqJuLd/IwjysQvp2LWS8goxqXan8wONq7qAQb1A0u8F0po1GXTv
 xBaeIl5HleUGrJNU/sChZkg0PNibXXW3TKhXNdUfIEagJj1v9Qne1bwncrZdzdtCZ1Ad2
 0eR0AD6P2b36etQEfyw+CgTprESe+SkAsRHIa4EPHXoa/38+a+c5hovY0pgt4LaZWABu3
 dtI8lKWpYX9Ydnj1EjUTmWvYlKZEMjJaECmvEJ6f/CSUO/xL9vkkTvO8jKsBrV7Q4b5TG
 VRwS8Gorr53mmm7oRy0KVnG9W4wnNhIhHqG+R1ONLQENKo493Imvdonj0W5RRCwgvrA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166673;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=/443A5HzecrnH3YOM2d3HJGN9KZUnGC/xrdWuWND9mc=;
 b=fzPp1+A+mmtK2pI1vu6N1tCFVrc+/YBiaBSPZZ8Wvb7yz1IaxFpNSL/XqwbXWc3nN7Mo
 ymfV2cAfXYnXkMqCOFl0vyXIWv9dQS6t4R0p/sX9w8kXRfbBKi12AsqxSlp8pI7rWLfNw
 RZzWxBMGRXk01g+1NhCN6TWMpuM0lUEiX84eA9Zix9uKGYyY6fTxMUgyYGG/bf98SkHv8
 7Y+xM9vojdFDU3JkmF8wiHL+gypWyzTUooLGWTcDKTzYdrcaLQ/ZD5Myeh20rhpuDZBZ2
 gF+FJlvEbvPXli+EWM04E93MWEspugsWz3puepwB4G+TCaha0bJqavCYYWa7YVZyWTg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=fC3bnWRB; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::331"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::331; helo=mail-wm1-x331.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=fC3bnWRB
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 070E040580
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:12 +0000 (UTC)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so3468295e9.2
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166671; x=1793771471;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/443A5HzecrnH3YOM2d3HJGN9KZUnGC/xrdWuWND9mc=;
 b=fC3bnWRBM67Kh48cEQ9ilkZOKeDAJGM14faDc04hDmcLC6LfNPTtNyePSP0ayv3m48
 trZX2DdjhDIQeKb7UxCNjPuLMloHVIW6ixeKNIbN3zvbej3nQrXcQO1vazyQuAhQIjpU
 wolzwnCcNsTQn1pBtfqci7VH0uij3u1RzjvJfaHsXf2ttlafSadxydy1m5bAJLrSfxaH
 veZio+sD9H22zOmQtdenbveOpJ3seMa3HLJCCQG2a7NoHL3xQU/Ijoo2Be2bdt8jXFHX
 DyKjsgLT6ZA67DPgvgopIeGKNHd+FHxvBuX0P//7V+fc6NIKa3PhFqvG5SvxYGu/PLkc
 8qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166671; x=1793771471;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/443A5HzecrnH3YOM2d3HJGN9KZUnGC/xrdWuWND9mc=;
 b=NT234i1LFabCu4jEUy2pljlOLoQJZ8SvOTskWr70jsrxWNO3crWlwQgWwa29M1KYiS
 S/lhdn6WgiglNENmQgcYzcdCIPrbDnoB03WsNmUNwfxPd3bsvFy91DUFEzm0EDOxXSlU
 3wHPiFpuLLlWkqOL0zCdIa0jOR83JJIVnfNX90EEKaYuTUMWPk5OgWuVJxTtX4m5wFhC
 FdnAbAzQXMvSkbRJC+rEu96YfMmpukW+tHt7ikSdOulbo0nZiZdKqDDVeS2CpCjsniBo
 Qc3orcW7oiiNajo5jHnWXybBr9Ve7ylwMx9TrsCP4dmgsBvy2RsHm4nWGJ5WJAURdWVi
 4wUQ==
X-Gm-Message-State: AFq9FYJKy3nJKY5/ikTtDjYt4CH6u6tDZXJb1Uj+JjXAbsmfv7INj9h8
 zRboBEagrZo2CZfr+njOyHsducjzh91hTI0n4d5oJZoNu0Y7GlklGwDM
X-Gm-Gg: AYBFou2niLGNlrsZgu6rL6FHcgJFLAKBshksOfaG0F6MqEFC0VJdbcrQApZCurlYoFF
 eBqR0yQEKny1gIFZmLlQ4NyY22W2OM6ucrSXEl0br6HBn/2r5nfBM85RVPwFh9H1r5Fw3qKgIuV
 mlxcxmoOxdydZkKs9dV7MVMmPWmK/0nZPlicjUiyTer9P8a7ZXdyFeELmDNJb4zYy6CK8Q8ARhA
 8FjfR+q+jVLz4RPIgtxEQH+g5T0EvKpuCfpEovUWHVsDeh+E+yLDS+ps6Cg9XnPmzxuq0N8+3FP
 JKnqZfyZy3OdNRBppWkClXKGeU8zt7Wk+ZoP3snpVWsDTrjXFOzCBZPYDsrAcO9Dlh8P/3wFMFM
 G1punJOGVgk5qbOYxjRJ6v/RAYICZwD9s6sMRud2b2KgfTBgx8xjKiSOvDC9UXYUtzy+ADkVR1g
 qYT6aF39VZ4NjAXHxUsXS6NBB0oSp92PKErQ7Bo/97LGPAIubfD3VujTQMIHEfbtyVsDsbg5mPc
 KODJ3MHxBvjjIlc3v+uETPSVyxGxtpN0QArUZEgYBS8Bq00T7OmcButyEGlIpsGYJBWHv5O8u52
 dc2STLKTV2hJ/9m47G7V9KeO+haxTJw=
X-Received: by 2002:a05:600c:1f93:b0:4a1:6517:ccf1 with SMTP id
 5b1f17b1804b1-4a9663997dfmr19471765e9.9.1793166670794; 
 Tue, 27 Oct 2026 22:51:10 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4ba7sm26478414f8f.33.2026.10.27.22.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:10 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 4/6] fs: ext4: check block numbers before releasing them
Date: Wed, 28 Oct 2026 05:51:09 +0000
Message-ID: <ae545f37-e920-4b9b-a85a-404f41f3e58e@gmail.com>
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

When ext4fs_write() replaces an existing file, ext4fs_delete_file()
releases the file's blocks: the data blocks found by
read_allocated_block() and, for a file using indirect blocks, the
blocks listed in its indirect blocks. Each block number comes from the
inode or from an indirect block on disk and is turned into a block
group index used for fs->blk_bmaps[] and ext4fs_get_group_descriptor()
without any check. A block number past the end of the filesystem
makes ext4fs_reset_block_bmap() and ext4fs_bg_free_blocks_inc() write
outside the bitmap array and the group descriptor table.

Add ext4fs_blk_to_group(), which computes the block group of a block
as Linux ext4_get_group_no_and_offset() does, from the first data
block. As Linux does, it rejects a block that does not lie after the
first data block, which holds the superblock, and before the end of the
filesystem. Use it wherever the delete path computes the block group of
a block, in place of the open-coded division whose special case for
1 KiB blocks stood in for a first data block of 1.

Make the delete_*_indirect_block() helpers return an error, so that
ext4fs_delete_file() stops rather than releasing blocks of a corrupt
inode: -EINVAL for an invalid block number, -ENOMEM when out of
memory and -EIO when a read or the journal fails. That includes the
reads of the double and triple indirect blocks and of the blocks the
triple indirect block lists, which used to be unchecked: when one
failed, the zeroed buffer ended the walk at once, so the indirect block
was released and the blocks listed in it were leaked.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
Changes in v2:
- Move ext4fs_blk_to_group() to ext4_common.c and compute the group
  from the first data block, as Linux does, without the 1 KiB case
- Check the reads of the double and triple indirect blocks and of the
  blocks the triple indirect block lists
- Return -EIO for read and journal errors, -ENOMEM when out of memory

 fs/ext4/ext4_common.c |  35 +++++++++++++
 fs/ext4/ext4_common.h |   1 +
 fs/ext4/ext4_write.c  | 115 ++++++++++++++++++++++--------------------
 3 files changed, 97 insertions(+), 54 deletions(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index cff112fb99b..650597873f8 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -963,6 +963,41 @@ int ext4fs_filename_unlink(char *filename)
 	return -1;
 }
 
+/**
+ * ext4fs_blk_to_group() - get the block group of a block
+ *
+ * The block number may come from disk, so check that it lies after the
+ * first data block, which holds the superblock, and before the end of the
+ * filesystem, as Linux does, before it is used to index the block bitmaps
+ * and group descriptors. The group is computed as Linux
+ * ext4_get_group_no_and_offset() does.
+ *
+ * @fs:		filesystem
+ * @blknr:	block number
+ * Return:	block group of @blknr, or -EINVAL if it is not a valid block
+ */
+int ext4fs_blk_to_group(struct ext_filesystem *fs, uint64_t blknr)
+{
+	struct ext2_sblock *sblock = &ext4fs_root->sblock;
+	uint32_t first_data_block = le32_to_cpu(sblock->first_data_block);
+	uint32_t bg_idx;
+
+	if (blknr <= first_data_block ||
+	    blknr >= le32_to_cpu(sblock->total_blocks))
+		goto err;
+
+	/* blknr is below total_blocks, so it fits in 32 bits */
+	bg_idx = ((uint32_t)blknr - first_data_block) /
+		 le32_to_cpu(sblock->blocks_per_group);
+	if (bg_idx >= fs->no_blkgrp)
+		goto err;
+
+	return bg_idx;
+err:
+	printf("Invalid block number %llu\n", (unsigned long long)blknr);
+	return -EINVAL;
+}
+
 uint32_t ext4fs_get_new_blk_no(void)
 {
 	short i;
diff --git a/fs/ext4/ext4_common.h b/fs/ext4/ext4_common.h
index 346752092b0..eecc11d9995 100644
--- a/fs/ext4/ext4_common.h
+++ b/fs/ext4/ext4_common.h
@@ -63,6 +63,7 @@ uint32_t ext4fs_div_roundup(uint32_t size, uint32_t n);
 uint16_t ext4fs_checksum_update(unsigned int i);
 int ext4fs_get_parent_inode_num(const char *dirname, char *dname, int flags);
 int ext4fs_update_parent_dentry(char *filename, int file_type);
+int ext4fs_blk_to_group(struct ext_filesystem *fs, uint64_t blknr);
 uint32_t ext4fs_get_new_blk_no(void);
 int ext4fs_get_new_inode_no(void);
 void ext4fs_reset_block_bmap(long int blockno, unsigned char *buffer,
diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 5f185387030..ea7843775b3 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -140,31 +140,29 @@ fail:
 	return -1;
 }
 
-static void delete_single_indirect_block(struct ext2_inode *inode)
+static int delete_single_indirect_block(struct ext2_inode *inode)
 {
 	struct ext2_block_group *bgd = NULL;
 	static int prev_bg_bmap_idx = -1;
 	uint32_t blknr;
-	int remainder;
 	int bg_idx;
 	int status;
-	uint32_t blk_per_grp = le32_to_cpu(ext4fs_root->sblock.blocks_per_group);
+	int ret = -EIO;
 	struct ext_filesystem *fs = get_fs();
 	char *journal_buffer = zalloc(fs->blksz);
 	if (!journal_buffer) {
 		printf("No memory\n");
-		return;
+		return -ENOMEM;
 	}
 
 	/* deleting the single indirect block associated with inode */
 	if (inode->b.blocks.indir_block != 0) {
 		blknr = le32_to_cpu(inode->b.blocks.indir_block);
 		debug("SIPB releasing %u\n", blknr);
-		bg_idx = blknr / blk_per_grp;
-		if (fs->blksz == 1024) {
-			remainder = blknr % blk_per_grp;
-			if (!remainder)
-				bg_idx--;
+		bg_idx = ext4fs_blk_to_group(fs, blknr);
+		if (bg_idx < 0) {
+			ret = bg_idx;
+			goto fail;
 		}
 		ext4fs_reset_block_bmap(blknr, fs->blk_bmaps[bg_idx], bg_idx);
 		/* get  block group descriptor table */
@@ -184,19 +182,21 @@ static void delete_single_indirect_block(struct ext2_inode *inode)
 			prev_bg_bmap_idx = bg_idx;
 		}
 	}
+	ret = 0;
 fail:
 	free(journal_buffer);
+
+	return ret;
 }
 
-static void delete_double_indirect_block(struct ext2_inode *inode)
+static int delete_double_indirect_block(struct ext2_inode *inode)
 {
 	int i;
 	short status;
 	static int prev_bg_bmap_idx = -1;
 	uint32_t blknr;
-	int remainder;
 	int bg_idx;
-	uint32_t blk_per_grp = le32_to_cpu(ext4fs_root->sblock.blocks_per_group);
+	int ret = -EIO;
 	__le32 *di_buffer = NULL;
 	void *dib_start_addr = NULL;
 	struct ext2_block_group *bgd = NULL;
@@ -204,29 +204,31 @@ static void delete_double_indirect_block(struct ext2_inode *inode)
 	char *journal_buffer = zalloc(fs->blksz);
 	if (!journal_buffer) {
 		printf("No memory\n");
-		return;
+		return -ENOMEM;
 	}
 
 	if (inode->b.blocks.double_indir_block != 0) {
 		di_buffer = zalloc(fs->blksz);
 		if (!di_buffer) {
 			printf("No memory\n");
+			ret = -ENOMEM;
 			goto fail;
 		}
 		dib_start_addr = di_buffer;
 		blknr = le32_to_cpu(inode->b.blocks.double_indir_block);
 		status = ext4fs_devread((lbaint_t)blknr * fs->sect_perblk, 0,
 					fs->blksz, (char *)di_buffer);
+		if (status == 0)
+			goto fail;
 		for (i = 0; i < fs->blksz / sizeof(int); i++) {
 			if (*di_buffer == 0)
 				break;
 
 			debug("DICB releasing %u\n", *di_buffer);
-			bg_idx = le32_to_cpu(*di_buffer) / blk_per_grp;
-			if (fs->blksz == 1024) {
-				remainder = le32_to_cpu(*di_buffer) % blk_per_grp;
-				if (!remainder)
-					bg_idx--;
+			bg_idx = ext4fs_blk_to_group(fs, le32_to_cpu(*di_buffer));
+			if (bg_idx < 0) {
+				ret = bg_idx;
+				goto fail;
 			}
 			/* get  block group descriptor table */
 			bgd = ext4fs_get_group_descriptor(fs, bg_idx);
@@ -255,11 +257,10 @@ static void delete_double_indirect_block(struct ext2_inode *inode)
 
 		/* removing the parent double indirect block */
 		blknr = le32_to_cpu(inode->b.blocks.double_indir_block);
-		bg_idx = blknr / blk_per_grp;
-		if (fs->blksz == 1024) {
-			remainder = blknr % blk_per_grp;
-			if (!remainder)
-				bg_idx--;
+		bg_idx = ext4fs_blk_to_group(fs, blknr);
+		if (bg_idx < 0) {
+			ret = bg_idx;
+			goto fail;
 		}
 		/* get  block group descriptor table */
 		bgd = ext4fs_get_group_descriptor(fs, bg_idx);
@@ -280,20 +281,22 @@ static void delete_double_indirect_block(struct ext2_inode *inode)
 		}
 		debug("DIPB releasing %d\n", blknr);
 	}
+	ret = 0;
 fail:
 	free(dib_start_addr);
 	free(journal_buffer);
+
+	return ret;
 }
 
-static void delete_triple_indirect_block(struct ext2_inode *inode)
+static int delete_triple_indirect_block(struct ext2_inode *inode)
 {
 	int i, j;
 	short status;
 	static int prev_bg_bmap_idx = -1;
 	uint32_t blknr;
-	int remainder;
 	int bg_idx;
-	uint32_t blk_per_grp = le32_to_cpu(ext4fs_root->sblock.blocks_per_group);
+	int ret = -EIO;
 	__le32 *tigp_buffer = NULL;
 	void *tib_start_addr = NULL;
 	__le32 *tip_buffer = NULL;
@@ -303,39 +306,46 @@ static void delete_triple_indirect_block(struct ext2_inode *inode)
 	char *journal_buffer = zalloc(fs->blksz);
 	if (!journal_buffer) {
 		printf("No memory\n");
-		return;
+		return -ENOMEM;
 	}
 
 	if (inode->b.blocks.triple_indir_block != 0) {
 		tigp_buffer = zalloc(fs->blksz);
 		if (!tigp_buffer) {
 			printf("No memory\n");
+			ret = -ENOMEM;
 			goto fail;
 		}
 		tib_start_addr = tigp_buffer;
 		blknr = le32_to_cpu(inode->b.blocks.triple_indir_block);
 		status = ext4fs_devread((lbaint_t)blknr * fs->sect_perblk, 0,
 					fs->blksz, (char *)tigp_buffer);
+		if (status == 0)
+			goto fail;
 		for (i = 0; i < fs->blksz / sizeof(int); i++) {
 			if (*tigp_buffer == 0)
 				break;
 			debug("tigp buffer releasing %u\n", *tigp_buffer);
 
 			tip_buffer = zalloc(fs->blksz);
-			if (!tip_buffer)
+			if (!tip_buffer) {
+				ret = -ENOMEM;
 				goto fail;
+			}
 			tipb_start_addr = tip_buffer;
 			status = ext4fs_devread((lbaint_t)le32_to_cpu(*tigp_buffer) *
 						fs->sect_perblk, 0, fs->blksz,
 						(char *)tip_buffer);
+			if (status == 0)
+				goto fail;
 			for (j = 0; j < fs->blksz / sizeof(int); j++) {
 				if (le32_to_cpu(*tip_buffer) == 0)
 					break;
-				bg_idx = le32_to_cpu(*tip_buffer) / blk_per_grp;
-				if (fs->blksz == 1024) {
-					remainder = le32_to_cpu(*tip_buffer) % blk_per_grp;
-					if (!remainder)
-						bg_idx--;
+				bg_idx = ext4fs_blk_to_group(fs,
+							     le32_to_cpu(*tip_buffer));
+				if (bg_idx < 0) {
+					ret = bg_idx;
+					goto fail;
 				}
 
 				ext4fs_reset_block_bmap(le32_to_cpu(*tip_buffer),
@@ -373,11 +383,10 @@ static void delete_triple_indirect_block(struct ext2_inode *inode)
 			 * removing the grand parent blocks
 			 * which is connected to inode
 			 */
-			bg_idx = le32_to_cpu(*tigp_buffer) / blk_per_grp;
-			if (fs->blksz == 1024) {
-				remainder = le32_to_cpu(*tigp_buffer) % blk_per_grp;
-				if (!remainder)
-					bg_idx--;
+			bg_idx = ext4fs_blk_to_group(fs, le32_to_cpu(*tigp_buffer));
+			if (bg_idx < 0) {
+				ret = bg_idx;
+				goto fail;
 			}
 			ext4fs_reset_block_bmap(le32_to_cpu(*tigp_buffer),
 						fs->blk_bmaps[bg_idx], bg_idx);
@@ -408,11 +417,10 @@ static void delete_triple_indirect_block(struct ext2_inode *inode)
 
 		/* removing the grand parent triple indirect block */
 		blknr = le32_to_cpu(inode->b.blocks.triple_indir_block);
-		bg_idx = blknr / blk_per_grp;
-		if (fs->blksz == 1024) {
-			remainder = blknr % blk_per_grp;
-			if (!remainder)
-				bg_idx--;
+		bg_idx = ext4fs_blk_to_group(fs, blknr);
+		if (bg_idx < 0) {
+			ret = bg_idx;
+			goto fail;
 		}
 		ext4fs_reset_block_bmap(blknr, fs->blk_bmaps[bg_idx], bg_idx);
 		/* get  block group descriptor table */
@@ -433,10 +441,13 @@ static void delete_triple_indirect_block(struct ext2_inode *inode)
 		}
 		debug("tigp buffer itself releasing %d\n", blknr);
 	}
+	ret = 0;
 fail:
 	free(tib_start_addr);
 	free(tipb_start_addr);
 	free(journal_buffer);
+
+	return ret;
 }
 
 static int ext4fs_delete_file(int inodeno)
@@ -444,7 +455,6 @@ static int ext4fs_delete_file(int inodeno)
 	struct ext2_inode inode;
 	short status;
 	int i;
-	int remainder;
 	long int blknr;
 	int bg_idx;
 	int ibmap_idx;
@@ -456,7 +466,6 @@ static int ext4fs_delete_file(int inodeno)
 	unsigned int inodes_per_block;
 	uint32_t blkno;
 	unsigned int blkoff;
-	uint32_t blk_per_grp = le32_to_cpu(ext4fs_root->sblock.blocks_per_group);
 	uint32_t inode_per_grp = le32_to_cpu(ext4fs_root->sblock.inodes_per_group);
 	struct ext2_inode *inode_buffer = NULL;
 	struct ext2_block_group *bgd = NULL;
@@ -489,9 +498,10 @@ static int ext4fs_delete_file(int inodeno)
 				inode.b.blocks.dir_blocks;
 		debug("del: dep=%d entries=%d\n", eh->eh_depth, eh->eh_entries);
 	} else {
-		delete_single_indirect_block(&inode);
-		delete_double_indirect_block(&inode);
-		delete_triple_indirect_block(&inode);
+		if (delete_single_indirect_block(&inode) ||
+		    delete_double_indirect_block(&inode) ||
+		    delete_triple_indirect_block(&inode))
+			goto fail;
 	}
 
 	/* release data blocks */
@@ -501,12 +511,9 @@ static int ext4fs_delete_file(int inodeno)
 			continue;
 		if (blknr < 0)
 			goto fail;
-		bg_idx = blknr / blk_per_grp;
-		if (fs->blksz == 1024) {
-			remainder = blknr % blk_per_grp;
-			if (!remainder)
-				bg_idx--;
-		}
+		bg_idx = ext4fs_blk_to_group(fs, blknr);
+		if (bg_idx < 0)
+			goto fail;
 		ext4fs_reset_block_bmap(blknr, fs->blk_bmaps[bg_idx],
 					bg_idx);
 		debug("EXT4 Block releasing %ld: %d\n", blknr, bg_idx);
