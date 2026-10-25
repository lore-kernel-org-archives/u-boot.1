Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC960A262D
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zTsi3DST;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D4MTftd6
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 479FF40620;
	Sun, 25 Oct 2026 13:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2a6ihNzs5gUk; Sun, 25 Oct 2026 13:04:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7444A40649
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792933455;
	b=Rh9K9e0TWLQc/zvjgHhFU7s1uD2KCUq3eBHJrDSWHiEmXJaZl32NmNiczSnWr5WF08KM
	 bWCJOydXSTwaUXY4h2tRlVI5EVcA6EcTcN38VKNZqYQwAHBjzbdGm4bG40dfEAl7aMKLi
	 LSUX1lVhpoXrZByl/lqdezB9wov2B75Bhx+GjnwYD4H1xNtGjDJuvuqzkBV9hlJNe1U09
	 lnxS0hQ9wN/Qff4FBS4Fow9htvu2H6lzqPiWKik0o9F3PywkeJJxnwOPHd3KTxXODh7oI
	 qjaLwt31YeahDPZS99w1FRZ9Ki/fHlivFP3KuyU+xcCEKnKiHd1a0n5navOQ8Sadf8A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792933455;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=UnGEYSDN7za9i+EwxnaP05/Qt197HFPs6MQBlrSWAJ8=;
	b=ZxV9wXSHAD29dGQUuDYOB6rEbjchqXgcATWWWnwucoB4C8pO78gUi4MC1gGFflT5MS8Z
	 0oAUSO3U2ThHwjqN5T4ZHnwnG8/fBXT6VAA3cBlnhOX2VcUjBXPMlgZaA1238sAACvDVP
	 yryAbHRQ9i+iKDvj8ymLc8XV2y5WjTVgAmkQv7y9B/VbiAKEqnIj8eI2koQNBwkhCMiuE
	 h8X/moi66ke5i+7bB0dAfHwjiCIshwMh3BcK8++1A7gZNknJYcHT8CuLQTH+b++S0D2S9
	 6buZ8pq1I58Iat1rhqSx230OmJxkptjSi3dQrmuh8VirsrjenRaicz+VELqpx3YieVA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=D4MTftd6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792933455;
	bh=UnGEYSDN7za9i+EwxnaP05/Qt197HFPs6MQBlrSWAJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zTsi3DSTx+MVazg1N/gI3USXsfu5fw2nEBthI/+vGXk1PUEQqyoc94gR232HqtqRK
	 B7aGwOvmhupWvvLo+NBXGilQE6trHMUDJpr2Q5+xbqxT9qv1ckIB4bQG+756EFZdFA
	 TDPNL92gKzxjKBf/0ILdhM9wOHfCOi+mZ62ya8ZFSI1nkWewV2FYaADI/aSoDHeVK9
	 wZhRYADH6OmVjfbJiPdNVI9FpwVFdRHtGphu8KTj32p2ZJ1mTW8aam/00KgnXlixkn
	 rDydUzuYHTlmFNkFzeOi1drVDI3qFQp6EHQENvKtMJZb+75fEEhgjImpCFkVcKenkI
	 a1psTxA8SG+Nw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7444A40649;
	Sun, 25 Oct 2026 13:04:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 096AF356
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 071CB40611
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2YRlWpGQgG19 for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 13:04:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0428C4060E
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792933453;
 b=SNEDA/0QVBt2GX4D9VzYBTmqhjG665dwG7Sb+VBrXBYxn19MGJwDwfwI/0msB9ncEqDH
 R0QlG0wcA2Uyc4Us3Xxs8ieQ3jBzuDON30lDlyAOKOlHfWfSQUVRpAtHcS2zZNL7EEvdG
 GPqU+4qzq98JLU+Gic/IIud2WUUkXduuy1nGwzKgnwimb1W5zhu0incBdC+LW/qa+WqES
 6RyDS9wEiihwQUVbzINMstOnxCl9l/ySnj/Pdkz844Fw0UGBx4jSexmFAjGZ/I7fn9eNl
 uqYP/qmP00Yw1hlNc//IKYpIb+JfufK5s4tq1kW5HTR+jzu0Kx5zgCWQpIHNWgtMa8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792933453;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=UnGEYSDN7za9i+EwxnaP05/Qt197HFPs6MQBlrSWAJ8=;
 b=SRWEaP8tALUXKXQ6HT3a2zFQO6yfpKZlYbE1VhWE3prypyYDaa3ARyX970wiuo+kPbG2
 YhG3m3X48U+QL1A1DU1snBgZ6HTRpXshd+qr5Tr58sj/D46UU0W9WDN2ZiIGbbl0o3OaX
 Zv+kdl6Y3502HvGB+KMOLKbBLPlgK0ptqGE3TfGfL0hXe78gjHexBXbpJnQJnakfb3ilu
 ZFWkKg4bNwRDun6tXpKYgGnw7+XLMFrdTfGBpgai3KNA6GMdMAO4MSC9iIDiLLFrvm4Ny
 8PnsjnyODLx6g/0ETYIxQpnPp3Qs0SWgWja/f66fYsURAYxjcT8dgSO2MiPzzq34UtQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=D4MTftd6; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::332"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::332; helo=mail-wm1-x332.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=D4MTftd6
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0428C4060E
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:12 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso8719875e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 06:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792933450; x=1793538250;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UnGEYSDN7za9i+EwxnaP05/Qt197HFPs6MQBlrSWAJ8=;
 b=D4MTftd68/uXAwk4QpZp1Yf6iWaaD97nl3u8hYEx/K2Kw89ZEmzrKiU4nc7qfQTKh5
 fdWS202d02utX7GTBNFqq/zQiBKi48jSRD6tmVRK/AYT60c3faVNfrI/aTjgOgRm5YoV
 f/bmWDLC2TlqiiMn4WKPVuVBnIinzkDF6EV9qlv8PTGmOiWO6nz4xHXvOOuIWd6w0+Ub
 P+IBuetduAGCZxkVSnvEDnJA0T3f8iMbWlsGa4ppIMyDhVo0fiRGmG4gIcPMbZR5cnWV
 S4inBO8cblHi1OAF6+zdcUo1CjAE0kGF+LuGz+pGPgzVcTd+XB/I4/J+acPcTNEbKCrB
 eqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792933450; x=1793538250;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UnGEYSDN7za9i+EwxnaP05/Qt197HFPs6MQBlrSWAJ8=;
 b=n9rR3ABPHO18ccI5/tLlXPt5EYdgujdhU+T/igpm6iQESwKYSCdTVVCFjlSKS5Q90F
 URymczml0rUu1uWvVFBeMbtMjRZhASafIRppaogOAFAM/N5s+68/WUUxvlUVythfzoN1
 1bz7XZ+pswoj/UvSAysJZH50yB2AJ8pleOE7HHBHlUadCc1LGtjObJLEz07VRBj38Zd4
 90f6OP2Y6VwpcwJ+zU19P+pX8oTXbaQmc7/hs0W+qjUsTZ+jH+4BgC/nBatzBkWQi1Vk
 RlVnsU59NsYcxDzRZVT2qiwDxkrv/+d6h6mi17QhjdVnGhPNmLInlrLlnK744JbjM/Eg
 +Ehw==
X-Gm-Message-State: AFq9FYKldnHt6VkvmD0b+tkeLxtPy7JCS6NmT6XBHr4EzTTxxhXJhJm5
 wDVu1JBdZPQsy2t/ijq5M1+4yPR0p0LhGeMVyrcPnn5SqkEiTUU41PVk
X-Gm-Gg: AYBFou1Lbmswy1OZbtJZnV7bgzb83p564a1bb2cVs8S6bMmGF4S9p5ArhUpLOXm8OhJ
 6Ph96AZChxgaLYDVrTVs9X2fC5WzVJxb6GPaMhGNpbo5kczR+5y72o23YSW4W4DfISone8LIZCq
 GTzSc8f6N/dR83jvyfy1MdGtZUbFFGjSAdw/uMbJ8oGpnbMzkepD/2m9sVulAVHyYzRAyW66gpP
 W1FVUFRGvfVMUSkKQppoMKrJtdmyIdEGVFYaQQyAdsP4osvCJGEQ1H+HHCs7neccFcEh7z18ijg
 mJvG9Ygfd5m4eNiUvXKUsF6/whTPY5yKBFf4EAFTFEws1kSdrsIa0+BMWkt6qVSmUiOigqXYHJX
 DRhvVNwVSplv9WGSmizqLoLNcPDYowgGI9t1TH8syDTbGls45jyXXS95Z0EMBfj3T3PMdTz6tYd
 3XvOyY9OEdFTdwfHqxgbq5+a0X3PS8Xq2rw9WWLHE/Wo0r7CpX6SlTptWd8Us4HRKq3ePhjgWiS
 bAs+mn7pV33iG8DqQjJbQQIYcXQ+wtEQc+YtvpiHhOC1OiRIfYtzMu4KA==
X-Received: by 2002:a05:600c:6098:b0:4a2:fe11:9a8a with SMTP id
 5b1f17b1804b1-4a35aae5dccmr72711495e9.0.1792933450382; 
 Sun, 25 Oct 2026 06:04:10 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm120707295e9.0.2026.10.25.06.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 06:04:10 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH RESEND 1/6] fs: ext4: check extent tree nodes before walking
 them
Date: Sun, 25 Oct 2026 13:04:09 +0000
Message-ID: <78a948b6-c07e-444b-b8b7-fc1f77af514b@gmail.com>
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

ext4fs_get_extent_block() walks the extent tree of an inode using the
eh_entries, eh_max and eh_depth fields of each node as found on disk,
checking nothing but the magic number. read_allocated_block() then
scans eh_entries extents of the leaf it returns.

A node can claim more entries than it can hold: up to 4 in the
60-byte i_block area of the inode, (blocksize - 12) / 12 in a tree
block. Both loops then read past the end of the node, into the rest
of the inode or past the cache buffer. An index node can also point
back at itself or at any node of the same or a greater depth, so the
walk never ends.

Check each node as Linux __ext4_ext_check() does: eh_max is non-zero
and fits in the node, eh_entries does not exceed eh_max, the depth
drops by exactly one at each level and an index node has at least one
entry; and, as ext4_find_extent() requires, the depth is at most 5.
A node that fails is reported as an invalid extent block, the error
read_allocated_block() already returns for a bad magic number.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 fs/ext4/ext4_common.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 include/ext4fs.h      |  1 +
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4_common.c b/fs/ext4/ext4_common.c
index 9e1d574e5b1..3aab1c87233 100644
--- a/fs/ext4/ext4_common.c
+++ b/fs/ext4/ext4_common.c
@@ -1529,6 +1529,38 @@ void ext4fs_allocate_blocks(struct ext2_inode *file_inode,
 
 #endif
 
+/**
+ * ext4fs_check_extent_header() - check an extent tree node before using it
+ *
+ * Some of the checks of Linux __ext4_ext_check() and ext4_find_extent(): the
+ * node must not claim more entries than fit in it, and the depth must be at
+ * most 5 and drop by one at each level, so that a corrupt node can neither be
+ * walked past its end nor make the tree loop.
+ *
+ * @eh:		extent header of the node
+ * @max:	number of entries that fit in the node
+ * @depth:	depth this node must have, or -1 for the root in the inode
+ * Return:	0 if the node is valid, -EINVAL otherwise
+ */
+static int ext4fs_check_extent_header(struct ext4_extent_header *eh, int max,
+				      int depth)
+{
+	if (le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC)
+		return -EINVAL;
+	if (!eh->eh_max || le16_to_cpu(eh->eh_max) > max)
+		return -EINVAL;
+	if (le16_to_cpu(eh->eh_entries) > le16_to_cpu(eh->eh_max))
+		return -EINVAL;
+	if (le16_to_cpu(eh->eh_depth) > EXT4_MAX_EXTENT_DEPTH)
+		return -EINVAL;
+	if (depth >= 0 && le16_to_cpu(eh->eh_depth) != depth)
+		return -EINVAL;
+	if (eh->eh_depth && !eh->eh_entries)
+		return -EINVAL;
+
+	return 0;
+}
+
 static struct ext4_extent_header *ext4fs_get_extent_block
 	(struct ext2_data *data, struct ext_block_cache *cache,
 		struct ext4_extent_header *ext_block,
@@ -1537,16 +1569,24 @@ static struct ext4_extent_header *ext4fs_get_extent_block
 	struct ext4_extent_idx *index;
 	unsigned long long block;
 	int blksz = EXT2_BLOCK_SIZE(data);
+	/* The root node is held in the inode's 60-byte i_block area */
+	int max = (sizeof(((struct ext2_inode *)0)->b) -
+		   sizeof(struct ext4_extent_header)) /
+		  sizeof(struct ext4_extent);
+	int depth = -1;
 	int i;
 
 	while (1) {
 		index = (struct ext4_extent_idx *)(ext_block + 1);
 
-		if (le16_to_cpu(ext_block->eh_magic) != EXT4_EXT_MAGIC)
+		if (ext4fs_check_extent_header(ext_block, max, depth))
 			return NULL;
 
 		if (ext_block->eh_depth == 0)
 			return ext_block;
+		depth = le16_to_cpu(ext_block->eh_depth) - 1;
+		max = (blksz - sizeof(struct ext4_extent_header)) /
+		      sizeof(struct ext4_extent);
 		i = -1;
 		do {
 			i++;
diff --git a/include/ext4fs.h b/include/ext4fs.h
index fe3fb301ec8..19eda150cb6 100644
--- a/include/ext4fs.h
+++ b/include/ext4fs.h
@@ -35,6 +35,7 @@ struct disk_partition;
 #define EXT4_TOPDIR_FL		0x00020000 /* Top of directory hierarchies*/
 #define EXT4_EXTENTS_FL		0x00080000 /* Inode uses extents */
 #define EXT4_EXT_MAGIC			0xf30a
+#define EXT4_MAX_EXTENT_DEPTH		5
 
 #define EXT4_FEATURE_RO_COMPAT_SPARSE_SUPER  0x0001
 #define EXT4_FEATURE_RO_COMPAT_LARGE_FILE    0x0002
