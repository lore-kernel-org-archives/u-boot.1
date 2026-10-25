Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB2F606A31D
	for <u-boot@archiver.kernel.org>; Sun, 25 Oct 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=MHKpUND7;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=o9yNbkT4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A15F60F40;
	Sun, 25 Oct 2026 13:04:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J1J6rXzqBjpN; Sun, 25 Oct 2026 13:04:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 427D560F3A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792933467;
	b=JsL5UjFrocwk4KqnWVGfeTdSSXFy2eodR+p3VQXyRj+f0HtreVuN9XXWubxvkZ8xyfSH
	 gVU42GGDeb/M9PQ/siKmHagEEyv+EgbUc5IjCdMK9UGG9EO9mJni976aGX/NOl1LME8UO
	 u4kMn9+eLtmvNnnOo9ErCRz/pGn5r0VYOfk2ZeNjyiuTD0xaFlIqPK0jmcx9z/hKhxMD9
	 dZyptCSI4kxBL6I3Qk4UQrpKwo0NxYdUuslmvD/eBr450mxg3uNrU00gI9VTU+pQtyY16
	 iCprwqwIgiMoEc8e7eZmdi5HZeZBAuFXwHWsWG8R2QejQQp0nFQKqxEh4s9YZaUOhAQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792933467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=IcCcDYOpw0/XLk62ZCpw3j3rj3eF7tJvxBq406dwhqw=;
	b=HVPY4lk4RL9dhNNo7+jWGUw8dFkzhMvZOoyyNXIaBcm8EnXPp/GPtvABC7ALLGxofoYp
	 XCRR9mouZ0c5nQTqYS5iq2YLplijaPpp8B4zHciYe0U2Zk7iLUKXLQ22zN5Bo3Oa7SBg+
	 8FVdkaU5ikHscn03hV8f46AP87Vo3U57SBmGTcPF9XJcv/P2Tc13cL5UArI/x7OvlO/JV
	 40FY43Q8yDqh8ZG59jDuQNpfPISZGq4Sk6Za2WPzn/7UMdqCNlVqf8hGa5CPVWOz8KV89
	 p5tX7At2oQogH+4d6KfiNqb3c9rS2mCrqhFas06V5TUTsNAw9sW2Gnkxkg2unendJmg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792933467;
	bh=IcCcDYOpw0/XLk62ZCpw3j3rj3eF7tJvxBq406dwhqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MHKpUND7ZxWVqNVEeMn198IjDMTtjd3U9gkxHtiL1+vFPBVR1vK4WMdwf3bl3moyk
	 6FrPNVOYfkcZSA11ZTQre1NB1BzMzbZu+bHgZ9fY+vQfKcBQ0QUr0EQfCX7xkqe9d7
	 lcCG3LnOI2+3USKCFNP2uUpJKOFEKe0uGAy9r84gtebff6MSSsYAJgi/X2smTJIVYC
	 bFjZKxdkgVWaeJn8SGnJDGewzQ3t40/rnbqsXDKYKd10mb7xKdRfkUpCcryNJiHinM
	 P4vH9f8OuX//jozdmnS2SB+nl+YlZbmJH/yEBCmktYvPO619bT2cbDuSwbv+XoI/Km
	 KzrjdqlHiv+9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 427D560F3A;
	Sun, 25 Oct 2026 13:04:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id F2131D33
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E401140848
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P8STMFSWFkBu for <u-boot@lists.u-boot-project.org>;
 Sun, 25 Oct 2026 13:04:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0A3FB407E4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792933465;
 b=Db2V/zLeROduc2/rgtCWTsAa6aFBrRF3kgMKG1PM9APb32KIfGh6wPk0zESaZ/sgATL4
 rrVBZBOienY91CIFqGVR7i8BUm1ZyEQPcuueCRCGGoeET9h9x3dc+eAUEX6cAT9yylhm1
 d7LIPmngVPJ9zettJytVuEryRY5kSD+0F2lewXFfBIa8046N3+EbLWU6Wou2Hxfk2Z3pc
 szyfhZrlq24Nd/HNDXShgUp5xNHctnk3EbUhAysRuZSklM1TnSMH0bqjQCV+NmBW8rdqr
 u1K4ljfrmCuPKAbO3ZD1lnTWVz0Eyz2sC13Q7EZe+BUqiwxosPNJM/+x1fWatboTAFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792933465;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:In-Reply-To:References;
 bh=IcCcDYOpw0/XLk62ZCpw3j3rj3eF7tJvxBq406dwhqw=;
 b=l3u9sG30cQt2MZiUzUFWStpJDLqar9grgw/oJtytL3OMZnGKOWJnpSGd0B4TT/bOaImv
 UDxJIINYkgN7n41JCyibGucY9vAqtygGnMLLta2c+huKuhgcq+CIYyOoKWgfLEUtx5fKC
 LFiiEmW/yKChtF9aLf+YOvHD2M6vWgTCrNvwbdICN28SAlqqz1+2BLW7YRP6cLyt9nU12
 BFzMI8te6I26gIUJzGAge4204hUGjrlT/bgfEReI1/IEVJELLMD0ivCd/hPI7I2Wt4gYy
 65KDPz6Hy/LVJwGsKHuq8EcWU3qxxKtrdF00EymDgHLjB8QMHhM+ec29ejpF8uKd0YQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=o9yNbkT4; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::42d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=o9yNbkT4
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A3FB407E4
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 13:04:24 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48dfc0421d9so1856228f8f.1
 for <u-boot@lists.u-boot-project.org>; Sun, 25 Oct 2026 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792933463; x=1793538263;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IcCcDYOpw0/XLk62ZCpw3j3rj3eF7tJvxBq406dwhqw=;
 b=o9yNbkT4MAbuWBok1ZgldOaFuygQkcz1HuwVf6qeODhf/HTCvwdnreKgvUJZsDw1c6
 5AIKweptfKY6UI0f4nlcQMMcOFQYAQGz1rr0txLLO1Qce3BwE0ISH1fvQE1CimlYoP3v
 oWmucRsFuG3YDzd6TCs1xZ3YVe1692nI4AjNahmq9ImMvGg9pErlC1PLebLdEZ7VttQw
 BCzEuMJK2x/oln73aKnw48awWccnuBOuwpQsMgv+7yaRU0IRElPEtO7qIVOKbozuS/Cs
 TIlaZna4YPBTsEBmUZIeD1R2rLHuqC949JT4QbJ5AMQhLv+NL6WTvFeg9cxjS+0eY62A
 9aOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792933463; x=1793538263;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IcCcDYOpw0/XLk62ZCpw3j3rj3eF7tJvxBq406dwhqw=;
 b=dkNVeW3ndYTwUdRxGGGhxmT/FZt3qxivXhCdRlfKQawXWk8R0pp6krIaBxGBjD1Jda
 zraa3jHCTM4QRA6vQHImZtpu9m4qUcfsxhmNRW7bdTBzqEeDvCurOVF6HY8D8mOvc/QQ
 i+h3TGOxGcaqOQLoTjBBoKKT7ypc4q6spTSLwSyPd2xkPaaZvfKgD8srh+naHAAihLOR
 dnO+8VHvMrRlA6GGahQ8IqXCuaHA5nK0vG4f7w47/Z4OIkuJrjAfDfX/4+xec50smvbs
 obW4t5Q3euQ/+6NvNl10InzVdp27u8Bu8aasdU3IZAcrbOf1FIoBjgF2SCUwza19zKit
 yEbQ==
X-Gm-Message-State: AFq9FYLz8dMEABFUxuwlVDn4dN+3lmB6+TAI7Bh8/BXccWQad8aWbVQb
 B3GhvZer/jsucHnI2pW/7zldZUryPdvn932FuKBrJJ+BMyEvLuPllHCT
X-Gm-Gg: AYBFou30vHmGkNNcOeaLZ6iHH1En7LPg/MGmvQnN9a3MLBrUTh3w6UJwzS6uZEkeHdh
 KaiEZDZuIpB+n9QOEufT1rNm3LDGk5sMQ7HeOMHrqaTDNR3kJ3b/OHWvqPXO3vfGQv0NGpETSLb
 N7qIZBPrZZqlZRDay4ic7l4lJ7JxvEFTstbv1JVu7jGn9LonDToh4EMAMzygzumObSpm6Coj89R
 hBnQvJGZE0rS3633ekYiorzV9PdhoZRMpO6hZ+QDhhzYJKTC/7dSq0sOyqL0NFQ1kNKqBOmdZLz
 HKW4YVT8jcEfzYriMbB+G1/7uP2LYkIoq2fPGX0AQUE/tuJSDYpUfp4mycRrSnk+xPWfF5GVxm2
 rg6zL/1KgsAbQTRlDdMbtx1joBjB24wmnKVhgf9QSwiZr1TkLSmjho6RFbwtJLdSRrA+XhNtxvZ
 6AXa5vnQ9c7hToeFO7Y222D76vv5+yUQQnHada9201JgAubbtyIGjpttxxMySZF1yIFQjXpTalJ
 wRudm5uTSqeOtHiU+qZAL+1TjEMvp2NifNj3iVXAnGQzmbhiL1T+xkcMaai6ZfaJkKtSGP5SBMl
 45Y=
X-Received: by 2002:a05:6000:2990:20b0:48e:2bf4:e7f1 with SMTP id
 ffacd0b85a97d-48e3eb924c5mr4758500f8f.39.1792933462580; 
 Sun, 25 Oct 2026 06:04:22 -0700 (PDT)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb99esm9767839f8f.23.2026.10.25.06.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Oct 2026 06:04:22 -0700 (PDT)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH RESEND 3/6] fs: ext4: refuse to write with an unsupported
 block group layout
Date: Sun, 25 Oct 2026 13:04:21 +0000
Message-ID: <cf14a3b1-2f94-4546-a7d1-541838c13582@gmail.com>
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
---
 fs/ext4/ext4_write.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 2fba2197c19..4e8fa434409 100644
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
+		log_err("Unsupported block group layout, not writing\n");
+		return -EINVAL;
+	}
+
 	/* get the superblock */
 	fs->sb = zalloc(SUPERBLOCK_SIZE);
 	if (!fs->sb)
