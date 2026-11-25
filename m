Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB50606A333
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NUgW9uQZ;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=blyNFIL/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F28180C9A;
	Wed, 25 Nov 2026 12:43:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HUfCbgqAulKE; Wed, 25 Nov 2026 12:43:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CC55780BB9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795610593;
	b=B2td9s8ISXeCher3TE7GrGspZSaUZjsLv6827ccdPgwZvFNbeNel7MP/k6lqWVlnCng6
	 IJQHp89qxE2ol6MIo7R3F4Ylu8hO6TGR5FkKYh9FzHqbkoI+YCLXsnoThy2wgMg3H97BJ
	 gdrNIab1ESYJLmF4uogGr12jqkGCdWnjL96t4V7i2yn8xYUVPF5zQ4DO7umob/J5wnewM
	 6hWjxhSLpxuDSM05/Aa/6sRod2Y6B7L7lxC7Qm4xTnFLNcSYb8FmWnTFGJdjKX1vy8h8b
	 V+6fp0bL71Zrhq+ct4JWyO5yarCmsI69xdR7STJjvX1yMxpKxuDzrseWf/vdB8AKwrQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795610593;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=kCFSdxmu7q9KIabtbbDA4lCrinv5Mis0iqAn2XwVvQc=;
	b=jANs1yYrzTNYSqeisl+6PffLlbAvr+8bSmGFv+JEa4INynJMNYdoJvVcO7WoiV3K2Y0t
	 iu9cf0T3AB/UVYYxJfzSwJ5fkGpYa17H/6Z/BcHLdPLCxeT9WKUolhXkjO/OoJON5vVWY
	 2QJF/JbhPNJr9SJJJl4hYutxU+H59ziXGRF2uZHeaHqE8b/LfySbAmI/nWQAGx+QVoq8i
	 aHSulayhiDWD9o+/xWPzUaUv4CKMftJT3GhdYHpjAvoq2/XfrsvNGPzVvoW3mR22wNBoR
	 zAY4xo5rlflct/evNX/QbfMdx8pN/eXl9lh9vt28i5HcjZpE+HuQS64B/MYRX2L5guQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="blyNFIL/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795610592;
	bh=kCFSdxmu7q9KIabtbbDA4lCrinv5Mis0iqAn2XwVvQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NUgW9uQZakM+oMg6N0RzfNqaJLuuzZeR7lQnH7nCqbn5OjXhiWAhI4+6CYivNyNzW
	 v3qGtkA4bJbc4yfFZZLBb7WsNCLgSZFx46aDZVujmGW3lIZuFFPjFSuZAl4jB6vJuu
	 n8+5FonbJ+R6RsLoTndqJt/XxBzkBF59Ne5LhaNrsh43ThN/k+FPFtAzoB7xgVyGta
	 TcBVXLawxMsHoPz04jYwgPvxtmXrMp30SU+EtB04cw4NYBy/kVZDAtNVndhJX7PdDr
	 gakH1MgIHVhJI434Bv+O/aehCHYlheSQ/RyqC33YGUhc0bV3ysz5QM0hIVmEpu7u8L
	 +5Gpx9iFCAqCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC55780BB9;
	Wed, 25 Nov 2026 12:43:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id AEDD232D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9563F80C84
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FeHHDfC_wwyy for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 12:43:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 899FD80C71
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32d; helo=mail-wm1-x32d.google.com;
 envelope-from=pepe.schlehofer@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=blyNFIL/
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 899FD80C71
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 12:43:07 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4bba5e17728so5988175e9.2
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 04:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795610585; x=1796215385;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kCFSdxmu7q9KIabtbbDA4lCrinv5Mis0iqAn2XwVvQc=;
 b=blyNFIL/ON2Ay4TvZA5SdLhpp3cQ+g2Slw1YFbEzpIFx8QTMVov87K5cDqkkHVD0G3
 t7AGvGDwznNgPKi8DY4FDDDwxPaD73UUwTO1wNNfMxAkKIV+s/yP14DMP8byCctEjnd+
 NYuo3LlWHA1xiIycJreccldDXWwIdXnR2LTUwHg1RiWpR4Ds6bZjOMatCRdPclhjuXV2
 n7xyqRebpd7+v+NH/LL9HeVTQP2tZTzCskql8luTpEPlp9R0+ABXdNrqOE5ZKerU2Sp0
 yqKnek6MoHe4VYb5lhr6pFaT09BYi4ntTMzfvYLRhoizUTaSIy1qksK0zx2jv2fsAG6V
 nTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795610585; x=1796215385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kCFSdxmu7q9KIabtbbDA4lCrinv5Mis0iqAn2XwVvQc=;
 b=BzvfqKhf5FTgkQzUTA23l/X9XcXzGFXTFkYS8ONZQEhR4/5VEe0ghxqNTHXCCcFIdP
 +FwtZV6Vu/HQle+Y6TThZLQ8BQdIy5eATZkLQP3RadkPJWi9wk5dqDMmzjFDyZwX3C48
 mVW3r6ekdSCY0n1htUi0xEqyldYoTrc5ykDqt5OdU402ilA4xd6xg13/4EwqJM6k6PaQ
 G/hwtzJ4cO3CywKMctdH8rG4FngT5BowgIdPdT/WHxUg/QHKawHbPNUUxF9v2YhjcN7E
 az6KKQtBELrwUUKueboK51ewughgeakC8t27gNr/L0spd4IdtHii9NgC2WI8zADqk2w5
 Zb4g==
X-Gm-Message-State: APuU4Z9uTflZmh1aH3jAPU4/BW+Jdkkx7s+HPfYVUS9f4xXnzTEQgEt7
 i9SzECPhaSwbH9L/59WShtnbeCpFyo6g0Y6WRg3tEDG7wZN8N0cVUpYWoMcic0g9
X-Gm-Gg: AZFdTZcdrX/eGyLI2gXDdk/r0XfZCyLKQI/f7k0kRdMh6Z/KAwv7DMSfwREda5X9QBc
 OGzWqxXlmbkmug81lnd7Xk3FpeUHIooguZ2oea6ESKEEhV0z2ScV9m5esu2HEERrjbRAMEHDrbm
 P8NwMq4COyK8mlOPMRdyCSZfJTIOBzqAD3PIRASu2IJYej8actJ/kAVheXbeWhaE6vYEC0K8bfy
 dlWUmyz/D+mv/8h+QTpaTm0sUJ+4GC28jiLZ98HANX0+aKcFFiCuPkqAGgTiu9Fa2ydzgf0QVBR
 EgYTZNrjkunOq/3ORhWGpgxeJz914y99t/u9Yz9dNJes5HeusFpgedDygHpuQW9c0VIafZmL4Vs
 TvW0GhtX46UlAR1CJqSxjkaa50VtcdV127fInrITmqcM3082suYE8ISDL7D2p2xHtcYIPcslzLs
 j7JF7rIdoNdHTWxv0N1fspQeRMeNRGAuiI+DWkYeuP40nyaXxHAInC02eU2GUIFhl1hX+DudAnz
 9g/rn/gay8Y2IEwpihviLYHLf3N34SC13kNCvhea/QtutgndK/Cy3STr3GAsNVa3Ge9DhCdzXww
 gzDx3eXxWojlzpWMvBJDJ3NgZIu6hvpEi0nWfQey+wCAz0rozJwV/6LPpXFwi62x4geJ4Ly4UEb
 5v6F10/ALllQZPUdJnRvheNn3h/45f1AcB11RONCw8UZlupK/B09b46/InVMbpjUQcmH6U6X52X
 Gj8MyQWZsIC9hYe664EzWQn7vJljI8eWcWkVlCvqlf1OqfhoMWLMcjm4EGV/1jUxkmdaFiCYtUr
 UQ=
X-Received: by 2002:a05:600c:3e0e:b0:4bb:6a5a:783d with SMTP id
 5b1f17b1804b1-4bb88929c63mr328667055e9.18.1795610585031; 
 Wed, 25 Nov 2026 04:43:05 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a00-1028-8388-a84e-7575-e1e3-dbaf-96fb.ipv6.o2.cz.
 [2a00:1028:8388:a84e:7575:e1e3:dbaf:96fb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm536486045e9.2.2026.11.25.04.43.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Nov 2026 04:43:04 -0800 (PST)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Bradley Morgan <bradley.morgan@linux.dev>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/6] fs/squashfs: Avoid 64-bit divisions
Date: Wed, 25 Nov 2026 13:42:55 +0100
Message-ID: <20261125124259.95636-3-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
References: <20261125124259.95636-1-pepe.schlehofer@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 32-bit PowerPC, GCC turns '/' on u64 values into calls to
__udivdi3(), which U-Boot's private libgcc does not provide.

Use lldiv() and DIV_ROUND_UP_ULL(), as commit 92080c6ef6c7 ("fs/squashfs:
use lldiv function for math") and commit aeea67f9a033 ("fs/squashfs: use
lldiv function for math") already did for other divisions here. The
divisors are block sizes and fit into 32 bits.

Suggested-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Joao Marcos Costa <joaomarcos.costa@bootlin.com>
Cc: Richard Genoud <richard.genoud@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>
---
 fs/squashfs/sqfs.c       | 21 +++++++++++----------
 fs/squashfs/sqfs_inode.c |  5 +++--
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 0ea6dcaba1a..7b4f1310c00 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -95,7 +95,7 @@ static int sqfs_calc_n_blks(__le64 start, __le64 end, u64 *offset)
 	start_ = lldiv(le64_to_cpu(start), ctxt.cur_dev->blksz);
 	*offset = le64_to_cpu(start) - (start_ * ctxt.cur_dev->blksz);
 
-	return DIV_ROUND_UP(table_size + *offset, ctxt.cur_dev->blksz);
+	return DIV_ROUND_UP_ULL(table_size + *offset, ctxt.cur_dev->blksz);
 }
 
 /*
@@ -131,7 +131,7 @@ static int sqfs_frag_lookup(u32 inode_fragment_index,
 	n_blks = sqfs_calc_n_blks(sblk->fragment_table_start,
 				  cpu_to_le64(end), &table_offset);
 
-	start /= ctxt.cur_dev->blksz;
+	start = lldiv(start, ctxt.cur_dev->blksz);
 
 	/* Allocate a proper sized buffer to store the fragment index table */
 	if (__builtin_mul_overflow(n_blks, ctxt.cur_dev->blksz, &table_size)) {
@@ -170,7 +170,7 @@ static int sqfs_frag_lookup(u32 inode_fragment_index,
 	start_block = get_unaligned_le64(table + table_offset + block *
 					 sizeof(u64));
 
-	start = start_block / ctxt.cur_dev->blksz;
+	start = lldiv(start_block, ctxt.cur_dev->blksz);
 	n_blks = sqfs_calc_n_blks(cpu_to_le64(start_block),
 				  sblk->fragment_table_start, &table_offset);
 
@@ -792,8 +792,8 @@ static int sqfs_read_inode_table(unsigned char **inode_table, size_t *out_size)
 
 	table_size = get_unaligned_le64(&sblk->directory_table_start) -
 		get_unaligned_le64(&sblk->inode_table_start);
-	start = get_unaligned_le64(&sblk->inode_table_start) /
-		ctxt.cur_dev->blksz;
+	start = lldiv(get_unaligned_le64(&sblk->inode_table_start),
+		      ctxt.cur_dev->blksz);
 	n_blks = sqfs_calc_n_blks(sblk->inode_table_start,
 				  sblk->directory_table_start, &table_offset);
 
@@ -888,8 +888,8 @@ static int sqfs_read_directory_table(unsigned char **dir_table, u32 **pos_list)
 	/* DIRECTORY TABLE */
 	table_size = get_unaligned_le64(&sblk->fragment_table_start) -
 		get_unaligned_le64(&sblk->directory_table_start);
-	start = get_unaligned_le64(&sblk->directory_table_start) /
-		ctxt.cur_dev->blksz;
+	start = lldiv(get_unaligned_le64(&sblk->directory_table_start),
+		      ctxt.cur_dev->blksz);
 	n_blks = sqfs_calc_n_blks(sblk->directory_table_start,
 				  sblk->fragment_table_start, &table_offset);
 
@@ -1603,8 +1603,8 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 		start = lldiv(data_offset, ctxt.cur_dev->blksz);
 		table_size = SQFS_BLOCK_SIZE(finfo.blk_sizes[j]);
 		table_offset = data_offset - (start * ctxt.cur_dev->blksz);
-		n_blks = DIV_ROUND_UP(table_size + table_offset,
-				      ctxt.cur_dev->blksz);
+		n_blks = DIV_ROUND_UP_ULL(table_size + table_offset,
+					  ctxt.cur_dev->blksz);
 
 		/* Don't load any data for sparse blocks */
 		if (finfo.blk_sizes[j] == 0) {
@@ -1677,7 +1677,8 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 	start = lldiv(frag_entry.start, ctxt.cur_dev->blksz);
 	table_size = SQFS_BLOCK_SIZE(frag_entry.size);
 	table_offset = frag_entry.start - (start * ctxt.cur_dev->blksz);
-	n_blks = DIV_ROUND_UP(table_size + table_offset, ctxt.cur_dev->blksz);
+	n_blks = DIV_ROUND_UP_ULL(table_size + table_offset,
+				  ctxt.cur_dev->blksz);
 
 	if (__builtin_mul_overflow(n_blks, ctxt.cur_dev->blksz, &buf_size)) {
 		ret = -EINVAL;
diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
index 20085f8912b..d43277f06e7 100644
--- a/fs/squashfs/sqfs_inode.c
+++ b/fs/squashfs/sqfs_inode.c
@@ -7,6 +7,7 @@
 
 #include <asm/unaligned.h>
 #include <compiler.h>
+#include <div64.h>
 #include <errno.h>
 #include <stdint.h>
 #include <stdio.h>
@@ -122,9 +123,9 @@ int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size, size_t max)
 			return -EINVAL;
 
 		if (fragment == 0xFFFFFFFF)
-			blk_list_size = DIV_ROUND_UP(file_size, blk_size);
+			blk_list_size = DIV_ROUND_UP_ULL(file_size, blk_size);
 		else
-			blk_list_size = file_size / blk_size;
+			blk_list_size = lldiv(file_size, blk_size);
 
 		if (__builtin_mul_overflow(blk_list_size, (unsigned int)sizeof(u32),
 					   &blk_list_size) ||
-- 
2.54.0 (Apple Git-157)

