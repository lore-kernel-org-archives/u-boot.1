Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E3D606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 05:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PywS5/bY;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U/70zjZb
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B034606FD;
	Wed, 28 Oct 2026 05:51:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QCU12NQZ2wdM; Wed, 28 Oct 2026 05:51:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9F01A6070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793166670;
	b=YgzwKnqUFf9l8rfllZiqJXI2/CM36fLyXD98STqYOz8/3038JB6g1udpfniCfwEMGSCl
	 69Nejzj+EBGL9DCyswc0t0gjd2S7EW2PcynKBlaK7s4BVW7gWNqsr9W9nJ9X8WNEAd0QV
	 Mjb4kYiHQU7OJc5Mfl0o1mX2pzxrqSR9TNvJuX/JJtZOoZiM1hEgrRVmlptg18MDD3t8b
	 GeRDN1plAx0i7jcMC8QlIv/UrwV5w3rfUdhDm5OTlwHuPa/txYAzWhhxjvmsKib9tfnZb
	 qKL956VQtEs2NO3wULL52ZcrAOliZz2yLoeE4liginNpXZrGGF0BSnhH1uGW2TDIu0Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793166670;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=7WflYm9xHsz9buV6uiMkbPkQmxcB+CcC1RfU5Y2E9iM=;
	b=NrjVSQpQ0f7qJpKmBnI+xKWklBLbgSjyh5g9RaSSlRJh1riQfAzZ5g3vs2STEqwzr5mU
	 RKQQGqLbJNU9i+13A4ST6iHSWiZAx+SVw88zG/rvZi3hFsoXjrhy59VzckS/g7z85H05D
	 V/ZPgHkiDlapCdXygIAY3olznngWdti7KMjQaDtcwcUZBNANJXWTpbWAMeCPsfjn2NOmW
	 fc0r5j83077GVR3geJH2lFwP6HzuAY2gQgd7Uvm01ICsHPZ/VHNYr+G5Xkm7nGFxd4dV9
	 OUDEGycDkmJiAMrpmc/UG6xiIQpQMGRCTKZtyJaY+eUnA8TfNYsAqRs2o4q/Gkccj9Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="U/70zjZb";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793166670;
	bh=7WflYm9xHsz9buV6uiMkbPkQmxcB+CcC1RfU5Y2E9iM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PywS5/bYlHtzm/GAhKSDejsxuXEph5yus5CgYC8iu2WwUg7zZ4jyYiqxz5gRDnR70
	 BxzX+iv/wUgxgxfIZGoLQ6AAgKVoNIyr2PXeK0/cE1q8KJ1ihwPf/kyQOZmfV7/s9J
	 vhfCDkDeD06osPDSCBebYF8AEOHav2xx/3VYzZ/lvR9BY6pwTpirEEdiTeXF5CS9jt
	 6Wk8FELc0DqUMuphqhED/bGSoDoAluTDCgLuihLtSfYnMle1f2c/xNiU7+1W/n+Xrd
	 mfs/ucFYnxmTV7xc0RaM32IOSowHksQnOB0d0ugNL7CbkuG5XZTUxxKPSchGSz9Pus
	 iU3j5PBQYp/LA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9F01A6070C;
	Wed, 28 Oct 2026 05:51:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E9603473
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CF4856070C
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i7gnaT9fxV35 for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 05:51:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org EE5B1606FD
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793166668;
 b=illZsAG8KL/LyRLMlD4IVBfJ4/Hg6uy38dBQIzPrM8ZTWjb43gkx+lKgEMzvYAbxBclB
 BFYIGv9DLfXHbVMUrUWmvA6aazkzK5Huf3qDLdTovqZSlgtMc1XXdJumxGLUfORS9kUoh
 Isd/qkjmCEYkv3ym20zO623fj4PQUM9WB5mpRBpJBF7qyh6KTnd4PiwZ9zCHiar0kAm9y
 3q1pfHPtSLfj+oSrK/wkinSjTAhTdqcTjMn8mQ2zwmLCLUYawdj7uY0bKOcs3/Hk1uGDu
 0HbHPsdQWH4xHsYbhOHkX1TTs+E5NU/FhdIeq+Mx4ICGsQT54IGNB1/FTIrEdPYZGAw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793166668;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=7WflYm9xHsz9buV6uiMkbPkQmxcB+CcC1RfU5Y2E9iM=;
 b=Q9lgDQzATQbhNnftPKQQucBaK+Dt3YcYUTn8ck1VUgihYJBTu2VOfHbDrQZTp+MzXOFt
 pBZgtI8RQte6nP29NaQFfXyM+p4AhznPbA+/s9gTg5xJ6p0r0LuVKHrFs9XCVgkcstueF
 wWksybkNgU4q8zQsnbE2/C17mULAy3bw1enNxE4T1b9yaPrGJUBFrONW2+d8sl+MNXavt
 /r2foitMfF1b6lpkYiNq7RkVdVHtSZ1760Y5JmgNrLy2RkjGIfwMnqApR0+gCTCTeHpsI
 0dxgPsjJR5K6e3ZhWSYv61GLQTka4F0Ub1wOAjzABfqXWvHtndNThl8Tu68U7mPxzfg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b="U/70zjZb"; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=U/70zjZb
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EE5B1606FD
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 05:51:07 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so243293f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 22:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793166665; x=1793771465;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7WflYm9xHsz9buV6uiMkbPkQmxcB+CcC1RfU5Y2E9iM=;
 b=U/70zjZbyr/R+wAIdoNzib4WtI3OFecVFDEUo5nJzCU34lT2Ae7oRuBXb3AUHt+D8v
 WXJL4JM8RbqZSkHa8B8jwXplJETrdW5MPfaezdJYel9fNgZEthPIwBX8IaUE1w3PX+LA
 Qm8PUvWk2Fqsj/dZ/bP5+E9C/jopmtFtutvAtE9SMT9bfUA6Ns8qp71cGmOyxpX5Rmqv
 ChTgi8pLJ9GegkClM9ZI24oPsr0TPJec0KBiUkkWcYHZ8U1IJaEIiqEUNE7zWMlv4PZu
 uueyCWPoQ26//RoEpJb6runS4OoSBpADSXRMkAsWbOZzcBQniDk243xCkIfu+0HsJQSs
 fLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793166665; x=1793771465;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7WflYm9xHsz9buV6uiMkbPkQmxcB+CcC1RfU5Y2E9iM=;
 b=hhPEyj7qItpIP3mhRG7pQFg8dZONVTlXtb9dRldaQmTCyEkxeXJ4a3W13LD+QEEHdA
 XdI6Et535NTgipmnLGWfT1dLqQefdWCz7jodTqIji7127/CBjWekkriwikxUIwrZBLzP
 SReKFaqSKkciS10WTFtnRUvIulkCgxuq9z5dBd0n6NaYDXt/AWhEVyqDZUKQ84vgdC5s
 3sjY/i/9d7KDyN25zMzj5cjQ5ilMplps6wWeDR5VSlB6JctwY+/5SEw2Ee4Eb6tK3pn8
 uW9BPheqZdDyk24oi8mz8s5ZtatPoauW347CNgaDjOcBdJvv3et56q8w32pdGHN7FIKZ
 gWjA==
X-Gm-Message-State: AFq9FYK1wF+4m4usCn1KkvYxQWvpLdZJ8ajDIEovQWqV3eh7ooOUrwdx
 0syakcusZ08ryWSewxrKjp8A5Usc5LnsQsBLOfaVSvPMjRrfKjDahX8sKJE6noAt6u0=
X-Gm-Gg: AYBFou3rlTvmf6eZ3f3wPfzbRM3hbD7p5V66ti+LgVWAxL7ZOaJKbsCJNTZ1YaK1tSE
 H0BSFgsaQUpHPVFJkFnGc8yhbW3G0U3KGhC7yQ7ap4XkLdbDJUFYzBmvRQCxBTb7cdgnshsPLtk
 p9zEPw2BLxibJ+ytU3mAY2mNNCSNq9XUqI6WcOQGDpENRZBbYqdDMq/5N4LfiNboTfQr0BXXmT8
 WlN5g5nrbRNOMnx9/B1+MS9JHn4LDdp14zLuKSkGwk7dsoMP6rKo2DQKQcaByZOmi7hxSOPqxKG
 3ip9Ig46/2QzL3XeyX8vtxZU90zya2Q+QTTvf+9wjNnmj2RmuOTEMv7xo98UuTZwKKbn0kVDIOF
 irhHM4ZScCnr7c2jzYyaxg8AWV26QE2yjIbI1iVH6DZoPyh++AcjGHOS2l4bD+NmGIlch5gsEbB
 nmp6GWvu4am+O3I2gPHEoE3aCtpKREAAFrr5xJ1B1Zo6s/78t+TFMygnznGiZhHQrQ4BMLgIVQ/
 9T7wIXrUA17Q+O5fq4cE8tk1dmdc5PmRasCyRmB2SOh7UivDcc6GMte78kZoTD76DRVuNtwScV8
 3GiEja22WQ98Il4Aro6/D/fB8bSrElZt6ow6jGMWuxe48enK/Qi3
X-Received: by 2002:a05:6000:4715:b0:48d:f383:2356 with SMTP id
 ffacd0b85a97d-48e5d5d16afmr2977237f8f.53.1793166665541; 
 Tue, 27 Oct 2026 22:51:05 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb958sm26620479f8f.21.2026.10.27.22.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 22:51:04 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/6] fs: ext4: refuse to write with an unsupported block
 group layout
Date: Wed, 28 Oct 2026 05:51:03 +0000
Message-ID: <207132f4-2374-41a8-b626-ff37980f5cb3@gmail.com>
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

ext4fs_init() divides by s_blocks_per_group from the superblock to
count the block groups, so a value of zero crashes the write path at
once. The bitmap code of the write path also assumes one bitmap
block's worth of blocks per group: ext4fs_set_block_bmap() and
ext4fs_reset_block_bmap() find the bits of group n at n * blocksize
bytes into its bitmap, and ext4fs_get_new_blk_no() numbers the blocks
of group n from n * blocksize * 8. With any other s_blocks_per_group
the groups after the first are indexed outside their bitmap buffers.
s_inodes_per_group likewise cannot exceed the bits of one bitmap block.

mke2fs uses that layout unless it is told otherwise; it lowers
s_blocks_per_group for 64 KiB blocks, with -g, or when many inodes are
asked for. Check the layout at the start of ext4fs_init(), before the
journal is replayed, and refuse to write to a filesystem of more than
one group laid out any other way, instead of dividing by zero or
indexing outside the bitmap buffers. A filesystem of a single group
is still written to, as before.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Use printf() rather than log_err(), as the rest of the driver does

 fs/ext4/ext4_write.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 2fba2197c19..5f185387030 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -605,11 +605,30 @@ int ext4fs_init(void)
 	int i;
 	uint32_t real_free_blocks = 0;
 	struct ext_filesystem *fs = get_fs();
+	struct ext2_sblock *sblock = &ext4fs_root->sblock;
+	uint32_t blk_per_grp = le32_to_cpu(sblock->blocks_per_group);
+	uint32_t inode_per_grp = le32_to_cpu(sblock->inodes_per_group);
 
 	/* populate fs */
 	fs->blksz = EXT2_BLOCK_SIZE(ext4fs_root);
 	fs->sect_perblk = fs->blksz >> fs->dev_desc->log2blksz;
 
+	/*
+	 * The bitmap code finds the bitmap bits of group n at n * blocksize
+	 * bytes, so every group must hold one bitmap block's worth of
+	 * blocks, unless there is only one group. Check this before the
+	 * journal is replayed, so that nothing is written to a filesystem
+	 * that is refused.
+	 */
+	if (!blk_per_grp || blk_per_grp > fs->blksz * 8 ||
+	    (blk_per_grp != fs->blksz * 8 &&
+	     le32_to_cpu(sblock->total_blocks) -
+	     le32_to_cpu(sblock->first_data_block) > blk_per_grp) ||
+	    !inode_per_grp || inode_per_grp > fs->blksz * 8) {
+		printf("Unsupported block group layout, not writing\n");
+		return -EINVAL;
+	}
+
 	/* get the superblock */
 	fs->sb = zalloc(SUPERBLOCK_SIZE);
 	if (!fs->sb)
