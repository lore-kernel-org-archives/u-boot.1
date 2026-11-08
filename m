Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8260A606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=zyAZX2hH;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0ItK6AO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5F5B680D2D;
	Sun,  8 Nov 2026 15:12:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id afK2lUYrYbrP; Sun,  8 Nov 2026 15:12:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7411D80C4D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794150742;
	b=ls/eU1SYypmuuu+ko8PZht8bmbLte8jcviKzdF5iduKBn8Gbhd/ql9pmZ7M9uIjOc4Pt
	 Y4aHnQzENTVuarO+VKvy4aAAhaNRBhZH0YTNW53Phi9uqFcztfSHMbmCzvCuQZGBemTus
	 p01S4Pay1Z2k5EfrdYbC/gy56ZPfGoQse2OMniLxrXKpTch/qS7IrzfWhiJGf6H7wo7Bd
	 Y2/VCIQRFoLyKrOR3cnQ86IjDfX6q5TO5dfVCKMCRYxNjK35j28pLqNs6MNA5BdD8iqWC
	 2iUOJfe0axQhG3XVnm0mDGVTffSNklFBzmGze1qmzJSUrgN4ycSo31nCg0MRE6Ct2uw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794150742;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=3QZv31X+FUhXuFZm+7IU3wY0YPb2mMbFAiXs6+sd89U=;
	b=Y2Jgh/s0ZLD0Z0ynLR7Vwdj0uVNTfq9sp9PnoOSapwMHqje+h3D6yk3CStAGH+nTBarv
	 DD/fOfAm3+SuaMJXN66ZnfG85Wb8IRwBELp6V+0DbMoPgRzpgq9Zh/cF4qiEm+oDesRvi
	 OLt0fJEVCjahdznhlgjoopH0b0tL8WSzBT/cYWP2NERCgjwO1mnXrMNoGSE3fz38yFTGf
	 hTK8r6WJ+n5U0X6sBM5CNTrWf2khlFiaZPhMXEjrfOPcOrg3kfq52emolyUsB1ExvMtjV
	 wYjVO3i6XORVxF/kgicAbSUOqneSZakGdlaSk6pF2oHBX16K+PDOtsMMcyLSBJq134w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M0ItK6AO;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794150742;
	bh=3QZv31X+FUhXuFZm+7IU3wY0YPb2mMbFAiXs6+sd89U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zyAZX2hHlg2HF+2xp3Iz3O6Eh/ECCFbsKdOUUudiCCSch5PIdAdPA6xx5WT3nzBeS
	 Ka2MvC9RXizfjUtd6lcnL2Y55XKpYO5hVOqpLfVG4Z+1SZ639dPZ8+yAgDnVkGQVmO
	 Tsa8RxobtlKGYrUYHZRKD2wbpSeUIjuhM3JLAafiazchG62mB0gY7fmycN4e315gkx
	 tJE5PzqM7x3fJm1IGuyKRIGTMmaQlW1k+zAqPPhROO3ZZMBHE4avKjF8pj1eiOPeBx
	 mya/irVDoGYCjiGnsKpgYDZxW7mypiTJktzGZ1b5ByxzT/vX4wzfCfI2mPCq5XzOzQ
	 pceMGfyznInqQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7411D80C4D;
	Sun,  8 Nov 2026 15:12:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C74C111
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7DED680C26
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SSgUCEuXWZaG for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 15:12:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 720B980C23
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=M0ItK6AO
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 720B980C23
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:19 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so783705e9.0
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 07:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794150737; x=1794755537;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3QZv31X+FUhXuFZm+7IU3wY0YPb2mMbFAiXs6+sd89U=;
 b=M0ItK6AOHdlrPCjosrL3bavWcJgna+WdMmHL7E2SDOIBeBgdbp1mYuuuBv/8SWxZK9
 rSR+eS2VN2wJq3Mu6L7XcrTBMiiXreUETvZy2FvnwpzLDOlV7px/fcIrTMCS0+JvKJ4q
 n3Vbx825VIpbmsMvjojhGpDtHRw1HvY7UC+85ykjjNam8DyMgjzEMN452XP4p1823Op6
 Q1NiZby174YPkqAjyM8P5+yhuWyFIxk1ET+tK+SQWhsSRkt3Y5XmW+gPpH92OKscs4Lp
 pJATVYkn+lg2tdaQGHcQ05xSs7z71Ihg1nixFoo4WEMxE/PxEjRIlKJBEBl84fziOfNi
 IzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794150737; x=1794755537;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3QZv31X+FUhXuFZm+7IU3wY0YPb2mMbFAiXs6+sd89U=;
 b=kRdTHeuPRpqMsJBH0vLWLCrev7rSeKakC/Va9neCUUWFuOWzFPi9ddxrp4H/xy/Ftv
 RHhgaTjn4fVzM3NIRcFXCkl955YZ1vobqyb/cfZZlj/Mt54imIWJDkEPtD9ioTCR1t8o
 Y2mRaL+uZU1H3QFtbU+skhXFzOayEFdSKO9ugaTgOgPSju8lcqvrJOSvS1lSeWjAxWZW
 gAivOPpsTte4QYasFK4/9Rj0661JHbi+iENM5UYIs5RdA1pw2DfVFgeIkFVACeX0EHLq
 /ze8E5YOxwlDLvCOqKy0RQ4PwCx5qHlB3jaNw2LONXe8fTibjx/zlxKomTMm3y7jdBlg
 sIzA==
X-Gm-Message-State: APuU4Z92jZ40/Xw21pv3mUx49FSPtvyknk7XwvrYDkgEQm6c5+CQ0jhA
 9d7VnQjzYH0KEYPNNzFPkai2iOJVJnp7xPGxYANzGJDQOmXGyThdf/q+tk6qsjGPOR0vRw==
X-Gm-Gg: AYBFou0P/LGRKt50LriX8qDVOmmvvc6ak+db5HHUzYv9BvPsmKaQJ+D44UHeS4haVRt
 3kICZvyA5MfL18ENMZ+wY4rUB9urR69aZ+qpHzMp+VMJkPHZqMl5/Yc7SrM+ED1o7alukCCvk6y
 A1bxBNq0OkwW4zbXe52wi31N/d0JRUsYdTzyzqxjgGco/dnKVHpfac/SilPfXWSJk4DY3TxcA9m
 7/3gMUcKUI93EIf9nC5T/fzi3kNo+1gDn1tiFBkTsa1eo6vjkKgMfLH4Vn30cyVG2yg7WrM4bnK
 VrN75SoLxxyZRzKN30BLb3wsxWHU+XuO8bC0sKcXhly6u37C9SWHt68Brw9JxNtAywkK/yM8lI0
 3aMNzm3mf/tZ/p8wNaW0kVSigK/9FUc2McEzKuCg5cXobHkWRxd1H0upeN6fnSfmQQuXjivZcZj
 jBY6K48/fUubfzt1q29rRldrT36ZlcavNV62l1H6bg5z0Ticnpa0gKgGkwtC5XlDSWVw40EBXr7
 q6IhWq3OJAm0Wf64Mchv5GUY/cHSo31cGX9+FO82VgokgviVaEr90IQA5GtDzhluwJz++e1b3WX
 dVxOx8XycQd1RXzZZ0GrpnlBkofVrdGD
X-Received: by 2002:a05:600c:54c8:b0:4a1:8dd1:305a with SMTP id
 5b1f17b1804b1-4b810dfa780mr56930105e9.0.1794150736798; 
 Sun, 08 Nov 2026 07:12:16 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49673b94dc1sm789418f8f.16.2026.11.08.07.12.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 07:12:16 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 4/6] fs: ext4: bound the journal entry tables
Date: Sun, 08 Nov 2026 15:12:14 +0000
Message-ID: <794fd6f4-fe81-4582-af60-0199af3df225@gmail.com>
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

A write logs each metadata block it changes in journal_ptr[] and
dirty_block_ptr[], which hold CONFIG_EXT4_MAX_JOURNAL_ENTRIES entries
each. ext4fs_log_journal() and ext4fs_put_metadata() add an entry
without checking for room, so a write that changes more blocks than
that, for example on a filesystem with many block groups whose block
bitmaps it touches, writes past the end of both tables.

Commit 29cb98d515f9 ("fs: ext4fs: Fix: Data abort in ext4fs_log_gdt()")
added a check to ext4fs_log_gdt(), but it compares the number of group
descriptor blocks with the size of the whole table, while
ext4fs_init_journal() has already used one entry for the superblock.

update_descriptor_block() also writes one tag per logged block into a
single journal block, which holds (blksz - 12) / 8 tags: 126 with 1 KiB
blocks. A larger CONFIG_EXT4_MAX_JOURNAL_ENTRIES lets it write past the
end of that block buffer.

Add ext4fs_journal_slots(), the number of entries a transaction may
use, which is the smaller of the table size and the number of tags in a
descriptor block, and check it in ext4fs_log_gdt(), counting the
entries already in use, and in ext4fs_log_journal(). Check the size of
dirty_block_ptr[] in ext4fs_put_metadata(). These return -ENOMEM, and
print their message with printf(), as the rest of the driver does. A
write that needs more entries now fails before its metadata changes
are written.

With the default of 100 entries this does not change what a write can
do: a typical ext4write logs a handful of blocks, and the limit is only
reached on filesystems with very many block groups, or by a write that
allocates blocks in very many of them.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 fs/ext4/ext4_journal.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/ext4_journal.c b/fs/ext4/ext4_journal.c
index 3a2e9f30c12..cb63addea0a 100644
--- a/fs/ext4/ext4_journal.c
+++ b/fs/ext4/ext4_journal.c
@@ -126,15 +126,38 @@ void ext4fs_free_journal(void)
 	jrnl_blk_idx = 1;
 }
 
+/**
+ * ext4fs_journal_slots() - get the number of blocks one transaction can log
+ *
+ * update_descriptor_block() writes a tag for each logged block into a single
+ * descriptor block, so a transaction can log no more blocks than there are
+ * tags in a block, nor more than journal_ptr[] holds.
+ *
+ * Return:	the number of journal_ptr[] entries that may be used
+ */
+static int ext4fs_journal_slots(void)
+{
+	struct ext_filesystem *fs = get_fs();
+	int tags = (fs->blksz - sizeof(struct journal_header_t)) /
+		   sizeof(struct ext3_journal_block_tag);
+
+	return min(tags, MAX_JOURNAL_ENTRIES);
+}
+
 int ext4fs_log_gdt(char *gd_table)
 {
 	struct ext_filesystem *fs = get_fs();
-	short i;
+	u32 i;
 	long int var = fs->gdtable_blkno;
 
-	/* Make sure there is enough journal entries */
-	if (fs->no_blk_pergdt > MAX_JOURNAL_ENTRIES) {
-		log_err("*** Not enough journal entries allocated\n");
+	/*
+	 * Make sure there are enough journal entries left:
+	 * ext4fs_init_journal() has already taken the slots for the
+	 * superblock, so count from gindex rather than from the start of the
+	 * table.
+	 */
+	if (gindex + fs->no_blk_pergdt > ext4fs_journal_slots()) {
+		printf("*** Not enough journal entries allocated\n");
 		return -ENOMEM;
 	}
 
@@ -172,6 +195,11 @@ int ext4fs_log_journal(char *journal_buffer, uint32_t blknr)
 			return 0;
 	}
 
+	if (gindex >= ext4fs_journal_slots()) {
+		printf("*** Not enough journal entries allocated\n");
+		return -ENOMEM;
+	}
+
 	journal_ptr[gindex]->buf = zalloc(fs->blksz);
 	if (!journal_ptr[gindex]->buf)
 		return -ENOMEM;
@@ -194,6 +222,10 @@ int ext4fs_put_metadata(char *metadata_buffer, uint32_t blknr)
 		printf("Invalid input arguments %s\n", __func__);
 		return -EINVAL;
 	}
+	if (gd_index >= MAX_JOURNAL_ENTRIES) {
+		printf("*** Not enough journal entries allocated\n");
+		return -ENOMEM;
+	}
 	if (dirty_block_ptr[gd_index]->buf)
 		assert(dirty_block_ptr[gd_index]->blknr == blknr);
 	else
