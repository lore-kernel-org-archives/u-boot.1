Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08385606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 15:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Kb1Yx3nT;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mHPy3a4q
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D45D140648;
	Sun,  8 Nov 2026 15:12:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hqn8hSw9p3Do; Sun,  8 Nov 2026 15:12:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0D68140632
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794150748;
	b=n6d5o/gni9x932PTHdaVIlb2ewDcygkVSf/d0hRtTXOUc2bQ9P7KXSkhMrqw87wf/TTI
	 Gjiydx3P/Cc7PoiXHJRWJfCiefrTQzuiFMsEWhgtTz6nXj/Uqmdfj6cbLa/SE6JXh5bWf
	 5KJoNGZy/oO+0TyohhX+9D7aofxjSYGpep+UBXERAYVg390R/VQXdew4uGrF1Q2ICym4U
	 9iv4nahmtx8syB23gC3xYwDMQw1FGB+OBW7kABj/jdXuFP28kxqm45o5zVZyJY750EspH
	 zKaQr2i+6BkAwPROQ9tHQDhWar0nvpMtdEzRk8yQbw2suWxwBuguri7LOMDzUb4tKuA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794150748;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=BelXauLIuzYvvF2kxSisBEqTShT7O31+9uzP+GAq1ZY=;
	b=aSooN0/yxhrpjVhpfEsSPRTl468tGr8slnNByhnifwQ1sfKC/qfag+6f2nZELgy0/6vP
	 QVI7aUYtEBtFWpf//oFFOyeOM1TFNPkgqb1uldXbCh9dhyKFmROYC/A2ltiT2LJQ+mSwW
	 MwJ1hu4nj2CIY4IrHLqL5e5l6jboeWNPybPF8T0xP5rfl8ebLBAFjqiLT8fJE7UBWsc1e
	 fEK1HD4yW691R1NTXpRU0+UdKdZOmINgwsFMRBkH6HHoS8XSuYG9T8rVcRIlK+E9e8g9W
	 oisv861YkxyJpVhB1rtoFIIQfBs9IToZ6mXwnxXoLbkdupbu6Sm2qxZZ/TUiqOqQ2FQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794150748;
	bh=BelXauLIuzYvvF2kxSisBEqTShT7O31+9uzP+GAq1ZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kb1Yx3nTUxtaXMc6GnJy2Y7GQ+YoBuxKgk7WbHvg1uJzhwQ+dpjZ5s/QFLyqc+Clv
	 gOYAHL6dcNY9GU6SyTSMlFNdgGlelwLSyk4Oxv46vu7F98ALPMPxfeNkNJJXFsMToZ
	 VEUhh+B/1h7f+Y+8aPrOTJV440cZ/z03alxMrNlvDl7u+M6kZJgvsexxaisoRY48kC
	 zHrIa4lTIFfEhT3/S17NVR8LZUZcAv5bzyIsK2nZNj1g51vpeYu9JkTkciyV1f+j0k
	 94aEPhJO3Bni1iyZQWFJLl5whEToQSvTOCFIjc++LrNY5Nsy5vIeYx2bnvYiEpxUhD
	 BUMoyR8Wkx0Wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0D68140632;
	Sun,  8 Nov 2026 15:12:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A886362
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1BE7780E26
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uwmeXbSNnICS for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 15:12:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0BD8380C23
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::432"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::432; helo=mail-wr1-x432.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=mHPy3a4q
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0BD8380C23
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:25 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so65185f8f.2
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794150744; x=1794755544;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BelXauLIuzYvvF2kxSisBEqTShT7O31+9uzP+GAq1ZY=;
 b=mHPy3a4qCSTQkMjr5FqxSQUfwOYmHJjxnQMDnoitevfDktpecAHyVTRXUs8DFa5a07
 RkIIkX0o3eDC5muZih+fbSDhNY4ZBk4HSxY8bDqSaDj500kDG2Zo54LF7gyAYvn+06E0
 AV4WwZlKjvVPx1GVvqZ9piUinkRZixDDye+hzGoKzZJWYJqOl005G24BufERjtqtHBKA
 aiGSe+faWzdukzvWGop6blb6n0OJkm+0nvJ7AzBtNivfP+Vk4Bzu3g7zCDI+NWnWRl12
 3CovTheRlYDKslPPgs72XLDwvn9JrKp4kPsXHeYpbYUFhC0xphUUkR/j4qP6O50Oj3gw
 TWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794150744; x=1794755544;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BelXauLIuzYvvF2kxSisBEqTShT7O31+9uzP+GAq1ZY=;
 b=Kaio81u3D3+xm58eAIjhfMbUgGqviXLr4cZutgjpy5aCJn1I61O5oxpnopbpbVYOMu
 TjgwHjQFuL5Jlg2ooSq8N11+x0ST8aNchg2W9sMjPhb5FvSQ8XsH7KNpK49i6JC+uufs
 kGDTemXt+++aDtvnNpHS2WLHtBf8MaY5Wl4cDWLdX/jee8EuGWhtAQOIj9bJpBrC60n4
 M76qIyDr7yk2cLHTn2Z4F2n9dbxf2J7ifpaJVMsGMgEIooqnKGJiG4fUpyb0FWpu7jVS
 vhNzoMT1HBZ3nl77OZNQGLzYACOhFoZFk2Pcmrr1szpHvegflJ0vs/aeQMurk7hPW8sS
 9ZDg==
X-Gm-Message-State: APuU4Z/H4bscfFODGl1fEw4noNDi9UbvXXq/fUPAXsuYfLrwylN/arm1
 8AGn8LGeBr0y196ExzO+99r5GZuBf9bVOV6H/HWTYd4soofZ9B/FQpyGXDjVz/hny/f6Zw==
X-Gm-Gg: AYBFou0PCA/i5DHz5o8LKONJCunUhCo+wcdavUG6GvD4UN3L4Ww96hLz6epfOuNo2fv
 6msDTRKkxLi63swcmIMor/5gc2TNFcDK/23uDjxUiTtxB12wYvFpfWfJ5SZ3gZqixmE5MnQCiqd
 ZlOouvCWmzWQpH+cGV9velCy2hEM6SS2aGsb01v0FGcrFtMMrOfNMoFVHpRzLDyhTFOy3pkt+Jq
 uSAtJr7NU3HBl8aP3k+iY82gP1B/W1uGhUYxEYYih4n3LIK0adZnRIQslEwmivWfo9d223Xh8lH
 fxl+eP5TjTJZx2iAzSWRPomYjqmUqvHFBuxZgrsUC4bLii6tzq8gymCRf6JbsNNtBCoxJLy4ViL
 9ILwlMn488aUhhG2I6tc4w/tSNHho2XKVKPQ3rwE0tZeNRFneEhbST3898ZC7n1vOzIDyEXR7Yb
 cYzeKF02Dg01O1xnR4hDcgrqn4lVYV9x2JJ68kZBbZfpKCnOfSm9UaEEpF+cgWLEfUs4MObv+/T
 Qjctw8qSdbdVEjm4rbUhDc1QRuHwBPv1MWokeY6fW5mv8zDpt4Pk4ckO/AbfMrlPsqEHjbrr0Oa
 5EkvKjMQDuYWxHPV0r3MYQpa+ki31o7M
X-Received: by 2002:a05:6000:2c03:b0:48e:7470:9eb9 with SMTP id
 ffacd0b85a97d-49583fd984amr3809094f8f.43.1794150743448; 
 Sun, 08 Nov 2026 07:12:23 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597934c2bsm4685175f8f.49.2026.11.08.07.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 07:12:22 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/6] fs: ext4: stop the journal scan at the end of the log
Date: Sun, 08 Nov 2026 15:12:20 +0000
Message-ID: <1100fb7c-dfd6-4f82-be8f-5ab6b1a61371@gmail.com>
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

Before every write, ext4fs_check_journal_state() scans the journal of a
filesystem that needs recovery for the transactions to replay. It
follows the log block by block and decides what each block is from its
h_blocktype alone:

- a block of an unknown type with the current sequence number does not
  advance the scan, so the scan never ends
- the h_magic of a block is not checked, so a block that is not a
  journal block is taken as one when its type and sequence words match
- the scan is not bounded by the length of the journal, s_maxlen, nor
  stopped at a block the journal inode does not map
- a revoke block is kept with its r_count unchecked, and
  check_blknr_for_revoke() then reads r_count bytes of records from a
  copy of one block

End the log at a block without the journal magic or of an unknown
type, as Linux's jbd2 does, and at a revoke block whose r_count is
larger than the block, which jbd2's scan_revoke_records() rejects. Also
end it at a block the journal inode does not map and at the end of the
journal: the scan does not follow a log that wraps around the end of
the journal, so it now ends there instead of reading past it.

Ending the log keeps the transactions committed before the block that
ends it, which are replayed. Failing the scan instead would make
ext4fs_init() fail, and its ext4fs_deinit() would mark the journal
clean without replaying any of them.

Remove print_revoke_blks(), which has no caller and walks a revoke
block by its r_count in the same way.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 fs/ext4/ext4_journal.c | 65 +++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/ext4_journal.c b/fs/ext4/ext4_journal.c
index cb63addea0a..c2c022d6c4f 100644
--- a/fs/ext4/ext4_journal.c
+++ b/fs/ext4/ext4_journal.c
@@ -239,28 +239,6 @@ int ext4fs_put_metadata(char *metadata_buffer, uint32_t blknr)
 	return 0;
 }
 
-void print_revoke_blks(char *revk_blk)
-{
-	int offset;
-	int max;
-	long int blocknr;
-	struct journal_revoke_header_t *header;
-
-	if (revk_blk == NULL)
-		return;
-
-	header = (struct journal_revoke_header_t *) revk_blk;
-	offset = sizeof(struct journal_revoke_header_t);
-	max = be32_to_cpu(header->r_count);
-	printf("total bytes %d\n", max);
-
-	while (offset < max) {
-		blocknr = be32_to_cpu(*((__be32 *)(revk_blk + offset)));
-		printf("revoke blknr is %ld\n", blocknr);
-		offset += 4;
-	}
-}
-
 static struct revoke_blk_list *_get_node(void)
 {
 	struct revoke_blk_list *tmp_node;
@@ -430,7 +408,7 @@ void print_jrnl_status(int recovery_flag)
 
 int ext4fs_check_journal_state(int recovery_flag)
 {
-	int i;
+	unsigned int i, maxlen;
 	int DB_FOUND = NO;
 	long int blknr;
 	int transaction_state = TRANSACTION_COMPLETE;
@@ -440,6 +418,7 @@ int ext4fs_check_journal_state(int recovery_flag)
 	struct ext2_inode inode_journal;
 	struct journal_superblock_t *jsb = NULL;
 	struct journal_header_t *jdb = NULL;
+	struct journal_revoke_header_t *revoke;
 	char *p_jdb = NULL;
 	struct ext3_journal_block_tag *tag = NULL;
 	char *temp_buff = NULL;
@@ -482,14 +461,35 @@ int ext4fs_check_journal_state(int recovery_flag)
 		jsb->s_feature_compat |=
 				cpu_to_be32(JBD2_FEATURE_COMPAT_CHECKSUM);
 
+	/*
+	 * The scan does not follow a log that wraps around the end of the
+	 * journal, so it ends there. Keep the block indexes in the range
+	 * read_allocated_block() takes.
+	 */
+	maxlen = min_t(u32, be32_to_cpu(jsb->s_maxlen), INT_MAX);
 	i = be32_to_cpu(jsb->s_first);
 	while (1) {
+		if (i >= maxlen) {
+			print_jrnl_status(recovery_flag);
+			break;
+		}
+
 		blknr = read_allocated_block(&inode_journal, i, NULL);
+		if (blknr <= 0) {
+			print_jrnl_status(recovery_flag);
+			break;
+		}
 		memset(temp_buff1, '\0', fs->blksz);
 		ext4fs_devread((lbaint_t)blknr * fs->sect_perblk,
 			       0, fs->blksz, temp_buff1);
 		jdb = (struct journal_header_t *) temp_buff1;
 
+		/* A block that is not a journal block ends the log */
+		if (jdb->h_magic != cpu_to_be32(EXT3_JOURNAL_MAGIC_NUMBER)) {
+			print_jrnl_status(recovery_flag);
+			break;
+		}
+
 		if (be32_to_cpu(jdb->h_blocktype) ==
 		    EXT3_JOURNAL_DESCRIPTOR_BLOCK) {
 			if (be32_to_cpu(jdb->h_sequence) !=
@@ -547,16 +547,23 @@ int ext4fs_check_journal_state(int recovery_flag)
 				print_jrnl_status(recovery_flag);
 				break;
 			}
+			/*
+			 * check_blknr_for_revoke() walks the records up to
+			 * r_count bytes, which must lie inside the block
+			 */
+			revoke = (struct journal_revoke_header_t *)jdb;
+			if (be32_to_cpu(revoke->r_count) > fs->blksz) {
+				printf("Invalid revoke block\n");
+				print_jrnl_status(recovery_flag);
+				break;
+			}
 			if (recovery_flag == SCAN)
 				ext4fs_push_revoke_blk((char *)jdb);
 			i++;
 		} else {
-			debug("Else Case\n");
-			if (be32_to_cpu(jdb->h_sequence) !=
-			    be32_to_cpu(jsb->s_sequence)) {
-				print_jrnl_status(recovery_flag);
-				break;
-			}
+			/* An unknown block type ends the log, as for Linux */
+			print_jrnl_status(recovery_flag);
+			break;
 		}
 	}
 
