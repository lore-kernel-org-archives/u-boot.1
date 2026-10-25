Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099CA60A2609
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GOzTaI6g;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JnUFgRxL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CF4F240C50;
	Sun, 25 Oct 2026 13:04:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oW9MR0AGsri8; Sun, 25 Oct 2026 13:04:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D4747407E4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792933474;
	b=gUk8dcCfh2RlEYmK63N6myK5sspA5m4WIEW9DKQfz/OCdRsyANoXO+WUTBuKTAkFPLNk
	 FtbU0ABanT3tLwFjUWecoCWgcRKswfHENuYAZ0vMtWFSQu9TckkbaSn4HkntU5XBSF8fx
	 +UbpjG1c78TY3GbZjsLFMr9w/UEKAe+bBVSqb03/MhE3b5z4DFLlIH94XtPw06ve79SPo
	 Wx3E8v03DNPYL/IoxGAgfffgOf3y47PYVAG2/O6bm8qnvJe0zFJs/BBYvKsJGHm7OZJJE
	 CCVJOgXKpUcmkgG+sg/GonXDKlFNmpoA0oe5Ks6hBeBYrOO8PY/eam8n6xvqtQTZYEg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792933474;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=JBMpNZjZWaqq5YfKpZsQYpgcsNmUrxo64Xe4NKJhYSU=;
	b=E7H6X24gSjC//PgizRTQ6e++uYOLhZR6kMb4viGmefVZL0Zb4JGi/603HZUKg6kwy71k
	 rXfQc1O9hAdHcCAkPcX7Mc2IFOrsvQHp77fxznpKmHH0iryxiPJiPNHYLZBerWYsG3IJ0
	 jV50GpKUI0KwMOLu1tXfFGVXnY82iVLvlS+/H8+q0219A4sj8TkCNeAEmVuyDXc0zRo99
	 2uYWC8MojNX0HeVIQxCSMLJ7FYE9CoAVzEAFqic8IC7CMomg9ol6LbVf9tEeZjVwJrkU3
	 Bf/XBE+Y7j6/s5uE1ZjKYMQvSq9qcUZgljesfnKWO0zz6T5Y8e6dcQ3GtEqtawmiOaA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792933474;
	bh=JBMpNZjZWaqq5YfKpZsQYpgcsNmUrxo64Xe4NKJhYSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GOzTaI6gTPpJumR2OMZiLye6KzBJewiJeCaFYr5rybbVU4uqo5BEHX5/xOQc0VfuT
	 YZ+YKjUMi3t5bR3wzY3/pZ8uB6sfPi0BQjmVK4FuAfcaFM2df3tipeyqpNIu2Ybmcj
	 x5uJRPEJ7ON9boa3AcwuhR1fUmaPEEexg8y2eaRkYuMMjwODVvQTjf3WInSmwGc9rv
	 ufOdOnyuywp72aa/xEZIsdRF+uc5uksA9fukyxNvaVtVuVEZeIQUYsDywDCRZmt3Fi
	 qYVyXrn6hP67sRd6BlTbKPlDiZn6h/TuMo8n8JugsWczIHm/5oRw5is69iodpZeapL
	 7JaLBGDiwNkkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4747407E4;
	Sun, 25 Oct 2026 13:04:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B247356
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 112FB80E35
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d61w_rgjew_W for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 13:04:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D26CA811AB
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792933471;
 b=Ws7v46Vz6guAafpu4kfilONP+30Xd2DjaxMGFzgkW2ffMe79gLgdxx/zAYSHmthuP3ES
 MPTfCbV/jAu0aeklwSJGjmprAG6QhJmWSCn1VUsuZ2cRNSmc6yKlOr8hLHbQRF6D0MxrI
 pSH32sUCvYz0DDeZoNnRH7EulPx5z52uVlxaX+OQySjLnDsp0rOkVzDxEFHy01beGAWBQ
 ExWbCBtw1nmWN6JPaS4ReNOOUlL8mTMuP4RLpK0exiCMOCei3gkxsqrzHfMHJfoUal5/p
 MgtAeK/qQ15vzK3WZf4p7PYgI6kzZm+7wA629LjmsoIunQDygudDz3S36C/nrIgyeIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792933471;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=JBMpNZjZWaqq5YfKpZsQYpgcsNmUrxo64Xe4NKJhYSU=;
 b=QOiOygQNYap/2+bUmTUdr2DOsvY9pvim/5aWBpRe5BQsviZuUCQuT+grvFrvf3Kym4eD
 tyuog8GW6wEDlH3dCUAfzNJUv+B1oPCVvBrfCqUCQP58yqwQyb03QLJGL8EUnwBJ6nHPP
 hYb4O+2X5DFHenY62JGcGjxNUlEhJXa5IZpUOs3c3glUAFV+oQZ38V2IEC8V1I+2Gkndf
 3xCmo7W6m0NlhPROoHhrLFA861bxNbcRD4FMw/KBYEy4meF7JIqEVgJslw8IzL4882T/T
 H4UUfc4ZOL6oXcAprojAK6rBjSpgGjKVeBb4HDyyjQD4YW7wBcYDuxJCXDHY8BCZ+nQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JnUFgRxL; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=JnUFgRxL
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D26CA811AB
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:30 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso13869165e9.1
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 06:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792933468; x=1793538268;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JBMpNZjZWaqq5YfKpZsQYpgcsNmUrxo64Xe4NKJhYSU=;
 b=JnUFgRxLK+9p4YNBFtY8VMRHWTGfSKUiXkzSrpoc1AZ1VNZDOWG1DZIF4JB7uAEZ/B
 QSVYWI6//TazYl96ZMIGwdbF8Efj4kfJAlfnXT2qcmNESf16QLd93Hotg38jP2m4/2lM
 cLs2YKCjkx77kGmapSVkrvVG4MvSjnhqEjKAkqrC+uh81aKTS0jcLzC1Pc/ByHPQDkcM
 EJxrV1gRld/yQyoDb07Ibh/iEGooVo/sSFlDs23C7XGE1KaBaIDSs3HtgIneWTiAElU6
 OKQG3V96hV9Xr72hRLDpV9+S54ri/G4BNdWA3XvWx4sW2GhrSGT8tdcxIHgrJqGs39oK
 Redg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792933468; x=1793538268;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JBMpNZjZWaqq5YfKpZsQYpgcsNmUrxo64Xe4NKJhYSU=;
 b=BpomJvjjTgQIx6byJYga4bjtSdrZesGkEiQcaqYrmVzL/3XOghf4X2rjU7bqmCrfdJ
 QYkZcxziAqL/R/G6V9KD9WN4eX3bDP7sjeR6hi6pjaR4+2gcMIvrPXY1I+VKIo+Nople
 moBPUmBvsZeZWi5tbO6QqaDBgTYMTsuBOIZFsf3qsNwYDhiCzRev7E5elojHftFH82Z7
 0lONEypnfiRT/9YfotubAjy8yFxR0cJE06+hmTmPp+QoIOT9U4PQgPo9xF9dj6W6oPyP
 B1/KsKvzLeE3FqLQuR5kTLR6RMmucKzC4WPet28kRiEgZUtPSfxIdBo5MIgmUEUefCWI
 rQmA==
X-Gm-Message-State: AFq9FYIjoDJJhN2Yty9AC85iXg6vzsnjQ1D4TAs5LsZCuUUwOnhwuZUT
 X0AqzcqSNjOvAKlQnrVhX1UHPy6TuEyJWgRhhaenZflKpLm7MwBeBt21tmvCpgG93sePBw==
X-Gm-Gg: AYBFou2EsktPIMzAPdyWehRYtEtJvo0OXH8h6w57vaGnyxn51/ai3En5BlkkGJ0IZRa
 6pVKm5f6LszyYoqjHnIXUrMAVX0agFvavT2ToqcYdw8Y9MNVgbnEsV5n/jYsWuc9sEt6Ocb5hHv
 iZ3uwtO489htB+Xx6nMtJZRnMKWsCh/UtZDNtWsmlLVh524COJRH+BFq93zb+/DVtI5g/P7xfsi
 /nJF0Ht7qDtUCI8IQ5DYtIdI6kJgqAi3Wn8UIXvcuawcW3ezrwwQMy6XgmKzUR1/CcH2fkcAV+A
 Cf/Z5UTE6L29sVRGFsFeIkaPTyuGFIvvwLbrxDlLdx14FT9+XKbepR7ml39/GtIMtce2iV/ZUY6
 1uSum3IgSAuLangI90IbnCYZHGLBj/wH0NFWWxVpzOkknn9bOO6zwE6S3eHWRC3ElZcarxlB6LX
 UfF3pVlrErmqoANgsKbexeLJ7pD6dF4BkLiD18UJ9XUrinv2/lvlZFcJ8a/kHxVnfDKLHQOZkwG
 gyK6OXFARtOMRYzCKPK+lDsa336vUHt99TxYsZF7OLTyomUi/4cvG+lDw==
X-Received: by 2002:a05:600d:18:b0:4a4:f48e:78fa with SMTP id
 5b1f17b1804b1-4a4f48e7b2cmr31907665e9.12.1792933467902; 
 Sun, 25 Oct 2026 06:04:27 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359f4f20dsm88262705e9.0.2026.10.25.06.04.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 06:04:27 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH RESEND 4/6] fs: ext4: check block numbers before releasing them
Date: Sun, 25 Oct 2026 13:04:26 +0000
Message-ID: <f4179b61-421a-48c1-9d1c-2774214544ef@gmail.com>
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
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

Add ext4fs_blk_to_group(), which computes the block group as
ext4fs_get_new_blk_no() does, but only for a block inside the
filesystem, and use it wherever the delete path computes the block
group of a block. Make the delete_*_indirect_block() helpers return an
error, so that ext4fs_delete_file() stops rather than releasing blocks
of a corrupt inode; their out-of-memory, read and journal errors,
which used to be ignored, now stop the delete as well.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 fs/ext4/ext4_write.c | 137 ++++++++++++++++++++++++-------------------
 1 file changed, 78 insertions(+), 59 deletions(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 4e8fa434409..dc37ae1448d 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -140,32 +140,62 @@ fail:
 	return -1;
 }
 
-static void delete_single_indirect_block(struct ext2_inode *inode)
+/**
+ * ext4fs_blk_to_group() - get the block group of a block to be released
+ *
+ * The block numbers come from the inode being deleted and from its indirect
+ * blocks, so check that they are inside the filesystem before they are used
+ * to index the block bitmaps and group descriptors. The group is computed
+ * as ext4fs_get_new_blk_no() does.
+ *
+ * @fs:		filesystem
+ * @blknr:	block number
+ * Return:	block group of @blknr, or -EINVAL if it is outside the filesystem
+ */
+static int ext4fs_blk_to_group(struct ext_filesystem *fs, uint64_t blknr)
+{
+	uint32_t blk_per_grp = le32_to_cpu(ext4fs_root->sblock.blocks_per_group);
+	uint32_t bg_idx;
+
+	if (blknr <= le32_to_cpu(ext4fs_root->sblock.first_data_block) ||
+	    blknr >= le32_to_cpu(ext4fs_root->sblock.total_blocks))
+		goto err;
+
+	/* blknr is below total_blocks, so it fits in 32 bits */
+	bg_idx = (uint32_t)blknr / blk_per_grp;
+	if (fs->blksz == 1024 && !((uint32_t)blknr % blk_per_grp))
+		bg_idx--;
+	if (bg_idx >= fs->no_blkgrp)
+		goto err;
+
+	return bg_idx;
+err:
+	printf("Invalid block number %llu\n", (unsigned long long)blknr);
+	return -EINVAL;
+}
+
+static int delete_single_indirect_block(struct ext2_inode *inode)
 {
 	struct ext2_block_group *bgd = NULL;
 	static int prev_bg_bmap_idx = -1;
 	uint32_t blknr;
-	int remainder;
 	int bg_idx;
 	int status;
-	uint32_t blk_per_grp = le32_to_cpu(ext4fs_root->sblock.blocks_per_group);
+	int ret = -1;
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
-		}
+		bg_idx = ext4fs_blk_to_group(fs, blknr);
+		if (bg_idx < 0)
+			goto fail;
 		ext4fs_reset_block_bmap(blknr, fs->blk_bmaps[bg_idx], bg_idx);
 		/* get  block group descriptor table */
 		bgd = ext4fs_get_group_descriptor(fs, bg_idx);
@@ -184,19 +214,21 @@ static void delete_single_indirect_block(struct ext2_inode *inode)
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
+	int ret = -1;
 	__le32 *di_buffer = NULL;
 	void *dib_start_addr = NULL;
 	struct ext2_block_group *bgd = NULL;
@@ -204,7 +236,7 @@ static void delete_double_indirect_block(struct ext2_inode *inode)
 	char *journal_buffer = zalloc(fs->blksz);
 	if (!journal_buffer) {
 		printf("No memory\n");
-		return;
+		return -ENOMEM;
 	}
 
 	if (inode->b.blocks.double_indir_block != 0) {
@@ -222,12 +254,9 @@ static void delete_double_indirect_block(struct ext2_inode *inode)
 				break;
 
 			debug("DICB releasing %u\n", *di_buffer);
-			bg_idx = le32_to_cpu(*di_buffer) / blk_per_grp;
-			if (fs->blksz == 1024) {
-				remainder = le32_to_cpu(*di_buffer) % blk_per_grp;
-				if (!remainder)
-					bg_idx--;
-			}
+			bg_idx = ext4fs_blk_to_group(fs, le32_to_cpu(*di_buffer));
+			if (bg_idx < 0)
+				goto fail;
 			/* get  block group descriptor table */
 			bgd = ext4fs_get_group_descriptor(fs, bg_idx);
 			ext4fs_reset_block_bmap(le32_to_cpu(*di_buffer),
@@ -255,12 +284,9 @@ static void delete_double_indirect_block(struct ext2_inode *inode)
 
 		/* removing the parent double indirect block */
 		blknr = le32_to_cpu(inode->b.blocks.double_indir_block);
-		bg_idx = blknr / blk_per_grp;
-		if (fs->blksz == 1024) {
-			remainder = blknr % blk_per_grp;
-			if (!remainder)
-				bg_idx--;
-		}
+		bg_idx = ext4fs_blk_to_group(fs, blknr);
+		if (bg_idx < 0)
+			goto fail;
 		/* get  block group descriptor table */
 		bgd = ext4fs_get_group_descriptor(fs, bg_idx);
 		ext4fs_reset_block_bmap(blknr, fs->blk_bmaps[bg_idx], bg_idx);
@@ -280,20 +306,22 @@ static void delete_double_indirect_block(struct ext2_inode *inode)
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
+	int ret = -1;
 	__le32 *tigp_buffer = NULL;
 	void *tib_start_addr = NULL;
 	__le32 *tip_buffer = NULL;
@@ -303,7 +331,7 @@ static void delete_triple_indirect_block(struct ext2_inode *inode)
 	char *journal_buffer = zalloc(fs->blksz);
 	if (!journal_buffer) {
 		printf("No memory\n");
-		return;
+		return -ENOMEM;
 	}
 
 	if (inode->b.blocks.triple_indir_block != 0) {
@@ -331,12 +359,10 @@ static void delete_triple_indirect_block(struct ext2_inode *inode)
 			for (j = 0; j < fs->blksz / sizeof(int); j++) {
 				if (le32_to_cpu(*tip_buffer) == 0)
 					break;
-				bg_idx = le32_to_cpu(*tip_buffer) / blk_per_grp;
-				if (fs->blksz == 1024) {
-					remainder = le32_to_cpu(*tip_buffer) % blk_per_grp;
-					if (!remainder)
-						bg_idx--;
-				}
+				bg_idx = ext4fs_blk_to_group(fs,
+							     le32_to_cpu(*tip_buffer));
+				if (bg_idx < 0)
+					goto fail;
 
 				ext4fs_reset_block_bmap(le32_to_cpu(*tip_buffer),
 							fs->blk_bmaps[bg_idx],
@@ -373,12 +399,9 @@ static void delete_triple_indirect_block(struct ext2_inode *inode)
 			 * removing the grand parent blocks
 			 * which is connected to inode
 			 */
-			bg_idx = le32_to_cpu(*tigp_buffer) / blk_per_grp;
-			if (fs->blksz == 1024) {
-				remainder = le32_to_cpu(*tigp_buffer) % blk_per_grp;
-				if (!remainder)
-					bg_idx--;
-			}
+			bg_idx = ext4fs_blk_to_group(fs, le32_to_cpu(*tigp_buffer));
+			if (bg_idx < 0)
+				goto fail;
 			ext4fs_reset_block_bmap(le32_to_cpu(*tigp_buffer),
 						fs->blk_bmaps[bg_idx], bg_idx);
 
@@ -408,12 +431,9 @@ static void delete_triple_indirect_block(struct ext2_inode *inode)
 
 		/* removing the grand parent triple indirect block */
 		blknr = le32_to_cpu(inode->b.blocks.triple_indir_block);
-		bg_idx = blknr / blk_per_grp;
-		if (fs->blksz == 1024) {
-			remainder = blknr % blk_per_grp;
-			if (!remainder)
-				bg_idx--;
-		}
+		bg_idx = ext4fs_blk_to_group(fs, blknr);
+		if (bg_idx < 0)
+			goto fail;
 		ext4fs_reset_block_bmap(blknr, fs->blk_bmaps[bg_idx], bg_idx);
 		/* get  block group descriptor table */
 		bgd = ext4fs_get_group_descriptor(fs, bg_idx);
@@ -433,10 +453,13 @@ static void delete_triple_indirect_block(struct ext2_inode *inode)
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
@@ -444,7 +467,6 @@ static int ext4fs_delete_file(int inodeno)
 	struct ext2_inode inode;
 	short status;
 	int i;
-	int remainder;
 	long int blknr;
 	int bg_idx;
 	int ibmap_idx;
@@ -456,7 +478,6 @@ static int ext4fs_delete_file(int inodeno)
 	unsigned int inodes_per_block;
 	uint32_t blkno;
 	unsigned int blkoff;
-	uint32_t blk_per_grp = le32_to_cpu(ext4fs_root->sblock.blocks_per_group);
 	uint32_t inode_per_grp = le32_to_cpu(ext4fs_root->sblock.inodes_per_group);
 	struct ext2_inode *inode_buffer = NULL;
 	struct ext2_block_group *bgd = NULL;
@@ -489,9 +510,10 @@ static int ext4fs_delete_file(int inodeno)
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
@@ -501,12 +523,9 @@ static int ext4fs_delete_file(int inodeno)
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
