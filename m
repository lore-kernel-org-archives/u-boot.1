Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992C606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IRyWmhBu;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q9hBy5fs
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 862D56065C;
	Wed, 28 Oct 2026 05:51:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MY8wIDHqDV5Z; Wed, 28 Oct 2026 05:51:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B6FF76067D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166661;
	b=O21P4o0A6y6eCH9TpayKuZ1xV/RV7kcsj888GOUCO+wYAT2d5bW/gPuWC2VabhbArgqJ
	 b8p8pKp/oXXpRDXw1V4T9oF8g7GOZDpMcBH5Lg0gW16iD6aNL51nNpZM5Owb9xwgVSKXt
	 8d5Vcm7TbZn4duqO1eWbj4DE/Gf88R8eh3PYJDFhVtTcKmCSmmjycx9h0XJXdqEQ9rEGm
	 76L+dFCzd0Xaj9uUBF4iHMtyS1gPnpkNbMqtzw11rRXf1GZB2ML2HOW5YRmiX/ksKyBI2
	 12eatYUONZBbuI4UXYhEKm1INmoAsGRxxe6OXrf8OmoOxWKFp7+eLFkb3ljSHoJMt3A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166661;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=wBUFdJaPpUmEU0V83TV5JmBkfVSjQTxM9kM+pSzo6wk=;
	b=OsJIByyKnIgDLRakzog1RDX3dTegBMBkVQFOzQDfbb1JVfvYq94ykXhxv81MJHx3/Gj+
	 IZ5BUsyehDW58iuCzyyu/n6sT3h8Z7NlAsuxxtywPPl7NcfiCn7TCQ3X5kdyGBytj96/p
	 SVXzkxmIIbPts4sAROOqo6WcJw9Oc0wcVstSHiqEW47aJnimorA5Mhh4DzRqTJBhs98ny
	 bjMSy429MmOKP/U2eTCppVHCoAX0Zaoc7w3lV8yIGNsI5O2kMc3vE9PXiQXLaySd1w8Mj
	 u1U2cLMvxtwko7xeIDpWCnHQiZ/nCK8spg09zWaZBSogQDi4nSXsog/wGMEhQl+xqiQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166661;
	bh=wBUFdJaPpUmEU0V83TV5JmBkfVSjQTxM9kM+pSzo6wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IRyWmhBuhaak5ojwQygX5dqGQVp+9GNo7UB1hd5lhMaDHU0pPQDWFYzJkfUs/QVvt
	 jZLZ7kA+/as3hBi9FMPKRSgD51WTpV4GL1fg5wjcnMi4DAO37OlmeDGji8BHP39fu9
	 tmlT3xAq21XH2U6msEmX4+1VrV2I5sxWMGeQKquDWYB+cxUn4bJASQwRsZCtn9ZcK/
	 vHlWCk4uXQ8H52e3CFmBgDmzI2o5M+FiXkTG0ZPMUg9HBJesqzXf9JPR0yRvPI64jZ
	 AzxW73xnH7htzizEkP8uDKwmQ9BRHEgWpdHVaKlpvCzw31OT4q7+3joGSJRS+EKDse
	 u5fP+S16OS6zA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6FF76067D;
	Wed, 28 Oct 2026 05:51:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 88DFD473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7B2FF4016B
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0WCma-yZuqRx for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:50:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7EF6A4006F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166656;
 b=iu3u5MpwohzdIMcM5WgN43C9odldgr+njen+/8nOVX9rzGj3IXSNObYoN58o9t8spPJs
 lLf3/KQ34TuyHgL+Sgc9X/gtH/WCAL4umvQMgspeC2nQ/YCpYEG5csiRIiMXulw7zn3k7
 gYebiup/YcNzXTeU8EBVDiCVjv1QZ+WE9j3tw0oGHq8fMbIZVibrB7vkHXzAZz9gLcNl+
 CCSCT+/bH+khVA/evbujQAfOQwdljWam2BjgnyUk2h0F1gSKOcoRHWC26DVt7+pG99jv2
 jtrjzGUBU28Pl0SrDKplMreSWWrd8PZOMh2AvWBaaDnF76y36t5ljKRsemO3O47F9+g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166656;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=wBUFdJaPpUmEU0V83TV5JmBkfVSjQTxM9kM+pSzo6wk=;
 b=r6mBlDv25b+U+GPm3i6nSvJLnc802EZCiQpgw0tKZGqkMCswX/Niby3QBwfW5Ff/iAMe
 T28F74AJ4/XnBOgFzkQc3QhzoQ+fMZoDqRziyOwMEgtc3qs0g3lns6XGyN5PLUTb+8yg9
 IuGatfpqi/thr74uPJH7wLlsCjanDKcna4fDHFnw0G2t+b4I4FNsGbnZ4PX6ysOsYSI9c
 LwxW56gf+eBB4C5QRJzB6Rq9vdDBdm1SdUyy7eo1Amow6pni//I9oGlXMHig7hKVNRAHM
 hhSRLomh2BlQRsjIFN89yQPFqo+FILe9bP8I8U4iFzGsCswjNzQnIeqcQTcmnn+0ETA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=q9hBy5fs; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=q9hBy5fs
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7EF6A4006F
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:50:56 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso244678f8f.0
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166654; x=1793771454;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wBUFdJaPpUmEU0V83TV5JmBkfVSjQTxM9kM+pSzo6wk=;
 b=q9hBy5fsYGiwRM6b9t29LvXFdtuWYUyfI5nbugBWb1FcsXHqpdBHmAFUsd+1x7FyyB
 uOW+XVvChmJlXx2ARDwiuJLCqfhup7qYBs9cjsvs33uMVXh7vcd8DyHgGGp/nlvoQJUO
 VN2npio3yjdE8rtVo+YL2XzcC5VGl2oCTr1IQM1vssCeFFGIydaX4u1vdrBgtT3m2Hw7
 jKGWqcakBC40GhwT/cYT9Opt7xsDJPBoWWNWaEgeLGc0YBLYeHEpm1r5CFIBlOSM+Q/b
 qJL8F361BBgnhsSPXEAQTCBwzZnnibWpU14FieAIO3Nd3PO7Gl6G/VueYH5ML+YxWbPG
 P7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166654; x=1793771454;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wBUFdJaPpUmEU0V83TV5JmBkfVSjQTxM9kM+pSzo6wk=;
 b=FF1GrCTSyPNjueEhWtq7softQLefQlJ9yZT8RyYW+OSRHEHvTt+tl1NQbxYnSz4LlE
 THTlrQvxtgZvKL8x6WDoOyHkb0IAaS5SlthzYnwx5Iv46r1OdJ0dFYr7t14z6Vb0fwmD
 zFmCiAUNzjOmnqMmkDhnim4imFj8fjZ3RshxPljUlP0sXY6vJTeh2gmu2IjUxXzcwcVp
 A73gscrKbp80dMzmHzk+j8ljkXnq7wRF7sG53C5DhL9WnScWaj16m/oFtISV2/93FADi
 vlw8CFtRQdkIXHZyfWWP5STFTEKkITdMJZk59Tutdv/bYZjAt88Ezthvom7bZFyL8fTV
 BFiA==
X-Gm-Message-State: AFq9FYJ4QyNfgy9dFuztQ2PRCFeWurAhyeRVqwpbq8jc4gPkz9Junvk8
 bErVUveXEG8I0155ShqPjhYKkn26Hnlrds5E4vZim1QOTXYH4LW5Gaui
X-Gm-Gg: AYBFou1+Rgbsl9gSN7RNVM32YMDwvqskBfdSkz763TwFBceEtsLYgLOZKVbOshacS6l
 SUPmea+SI2lp+s22pChHrqkG1K+j1FlAjUpGLnEbqdHnDYHw9GRWHHqpEo/M3zFQI8vzr5/DEdw
 w/o99JWtS9RE6ytZ4XQQ6iCoAdee1DU2Fdz487pT/8GsmrO7TiSP9f1K0NyNvrZiO6JCFlSHrkm
 JXj+/okBo//GV7QrVGoAH5GEIxbSOzGUHJvSVpyqxc/2vApZVZMqxcV6aRKuKwC7+woz2hnPtp1
 odYlLvzfop66/R/tZ6vnJADdQ/OZXInTxMUR8OK+GWJgqfYco7M1e2fqq6CnUPo2KCUL2a2wTR9
 UalpCpTqrMtlFFEzLwwkZ7FVN/yTLDuy9s+b9811CGDU0gyBI2lI28Er8Gp7Hun8GzOeNCbiZOM
 OogT4sononyL2FFCUsdsxzMDzmQL2e1/ogT1asQ4X2gSwmaDxC+wP/psc7dJIB3sDSKqDzwoV09
 bRH5pDwD0hnLJhYq1iZwb9mu9x+tal8VI1jTEkJLcTkFmuFr+48hueBJ7tr2U/Gvwcd4jUio6Fx
 suX9frgRMOxI96jbRfgShVjW12haIZs=
X-Received: by 2002:a05:6000:40d9:b0:487:15a3:1cab with SMTP id
 ffacd0b85a97d-48e5d2e6940mr3469406f8f.18.1793166654162; 
 Tue, 27 Oct 2026 22:50:54 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3eb8f387sm26166853f8f.4.2026.10.27.22.50.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:50:53 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 1/6] fs: ext4: check extent tree nodes before walking them
Date: Wed, 28 Oct 2026 05:50:52 +0000
Message-ID: <25040c7a-430c-4b67-a496-6a8e90ee2e3c@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---
(no changes since v1)

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
