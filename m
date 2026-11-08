Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CACE606A31C
	for <u-boot@archiver.kernel.org>; Sun,  8 Nov 2026 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CDa3EOLg;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iZQZ6hjv
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CAD3C80AC5;
	Sun,  8 Nov 2026 15:12:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifVEQEOc30bU; Sun,  8 Nov 2026 15:12:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 061D980E07
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794150726;
	b=hTHJSsZN/0wsQ2yCMhpGdhgHHn1ZOC+Xz6dl4Ry6vW0McI523xbza3JJJf52oWAumo+q
	 YKowjkZesSSJA/53ZlMmGO3HtwBavDNwjrD7Q7UWYTjHH96CVJfKAsYyR5hiNDn/JBcz5
	 VMrEm9FVfITJSlg7HJzqHO1Y+28bB/YG1B+QSdneLwIazFy3wbT5sjQYFRszDVyzP6e6Q
	 Fr1zzJ6Fe/Hy+g0srVV8yKhhMINMfFMRZqe0AFXLw2DMKTAD0x3SBVyH1WL2+BOh4pWbi
	 +iGDOU1VuB1W78rL4rSQe50ykXi5RmUH4uhQD04wgINZ2K8YU4+S66Tl4Dx3PFXJfZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794150726;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=QfBJiwDdf7czJdTBXkAQTjBBYl3PDDRcio8Uahc0zUA=;
	b=BgizcfiLMT8kgFrX2IQjH6hBq5i9f/lYlcb+I3Ae3Fyng4H8nslCqITMdFz7iK7ZPZET
	 hMBy36K6PojsvOstpK83w/HNvNImL5EFDgntPJckmteYxWtwFcS63JsNLKDbh4zG9Gqh4
	 r8Le1TU9pHt9MfvXbzWSTdGIRz8HOLJk1ExEaQGwfJ+el40NkYS9uoUBXBWXwNOSl2cE6
	 uwQWHm5UnGYPzjgaPcrik8IlYIi6MTqYw06zT3j/vpFeb5J8VMRjXmwhNpJnUsRAjkqdN
	 xGFRSFI6v3AE1ZrK/1yrEdCLzesZkDungpMnajjUqkpaqg81VgR2FoCPFa/7zkxf2gg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794150726;
	bh=QfBJiwDdf7czJdTBXkAQTjBBYl3PDDRcio8Uahc0zUA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CDa3EOLgtJFhe+X8m/miPEbyAI3CVvPBg434ZorbJj3SGlZhPLdypU0srQ/KJpzju
	 L1REeoxTVgxjYVpzt3Ma0EGE5+VXWfNh0pztw/2HcJDQ7lQpfb3OemjG3AUKXMLItF
	 Le5BGaTfQKvFhHgn7YcUdHoTjqKI5DpMXzFcWZIkhZO72gu0n74T6gBr8nTRuo9doN
	 Y+A1ECejhSSTf0I1VL2msKoeuIfLkj3RkhmqtwbPmVrtW64H5FE5CMjV5+7Wp3feNy
	 IZJN/jCas0MGxM7wsCIvwGRegcZcOXTYsXRQxQMXfIF12BiNDFbsNeliAU15ZS/pbx
	 kkfQW67K11IIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 061D980E07;
	Sun,  8 Nov 2026 15:12:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0B1792AC
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 085316060A
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MGDmLC1qxCQA for <u-boot@lists.u-boot-project.org>;
 Sun,  8 Nov 2026 15:12:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0C683605E0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::42c"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=anabobillo3@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=iZQZ6hjv
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C683605E0
 for <u-boot@lists.u-boot-project.org>; Sun,  8 Nov 2026 15:12:03 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso104622f8f.2
 for <u-boot@lists.u-boot-project.org>; Sun, 08 Nov 2026 07:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794150721; x=1794755521;
 darn=lists.u-boot-project.org; 
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QfBJiwDdf7czJdTBXkAQTjBBYl3PDDRcio8Uahc0zUA=;
 b=iZQZ6hjvwsp7OBDE8M/XNJQ60RFctvtgDYbE8/MJsWqqQ8YV7gIEke/WQlvuW8+iB2
 Ia/sLZHkYVgwqmbE2ffgPlcZ3/cgiVbVsIk1IZ45L3hZbuauZMnZt14BAWRg4tNQ7O9L
 EivaPXEH/xhtwqKT5hosrPTCoaiqy8mBRediGRBB20DO5Zgs6kee4UNGdHRFr+E2Zhmp
 eaH9TCwBw7yoPU5lbOWiBmGhdUk5PA4evWPB1+JyDQHn+c7mmrbxtRN3VzdnerYPxMiz
 Jokz8pR7foNEmnqGX++L3nK8ShzwLWMU5RSx9jgciQ15yywujE9840Z+NeYun/91YtoV
 DFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794150721; x=1794755521;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QfBJiwDdf7czJdTBXkAQTjBBYl3PDDRcio8Uahc0zUA=;
 b=JkBBUMn+avajV5jPdP4ERV3h3CYPUjHJvDFDhSi/f++D/J/2Zx2f5JK0TJEZTGT4hh
 mnbt+kP+f3o8eSr2oKEi7U42mFvwGw2O3XdkdusGCEOKB/KBbCePf84+w3o8tsmGD16X
 LpUk3jCvNvIV67DasTw6N7ZOXNT37+gU9MIeiHNeNAeDI40n1qNt73tpuM5NrmK2K3wJ
 xeHaG1tbxyY+RZx/Zch30XnxX4xUw96XvnwDelQL3XzfYByi7IAx1AqL+9I36InKLIOg
 akIN5EqEABjqMnif92Hvvq+xCdkRmOkV/qE/1HX8oXpgM021H5UUlt2DoBN4YCLPUHoe
 YE6Q==
X-Gm-Message-State: APuU4Z+LMkPvwxyrYGbNMkrlPPcf+PMcr7eeT7k+zXXM4NhiAucEmKmX
 KDhXRX6dGF6Lb+4ym327fbhIjpCP8vr8+Ve3kZb+7ozL1SvMSOZbmRN0
X-Gm-Gg: AYBFou0TW0OVrjhE8PkDU4Svx0/3YfG/zBS250m+bbyLSkwk7WmGjMS4gBFE6HMeIlL
 ytUuX3yKTbP/oE6JCPMAeh1hPldMur+BnLAaCT6o7rBGTeioxDAtQg5ccPVxARm4yXehu4G+KIv
 0wwBbBAIwAN3TwFn7+DY9nO1IoFvspe3x23bbZPG6pv7nxJp9kbO8nZKU4+vJFHM5EBWWhwA43D
 HO0ttavyvNGI0q3eDz83FoeDkdF6WADQ/Csvy6nnfRejsZod8AK6mvJRGccy2lzsePtQi+D0W37
 CEbyN/AwY7giZVvFbrge+xlWZz6rJS3cg5S6SQLUgjb0TuaPS40jEVxC2z8JI0fQOlDsW0w96b7
 xWVVnfMWyXB/NtEny8sAUxw4Mwiajw3FozDE1UnS+ZIaxMuQfcObM1taynutUVzhPVXfIUwF3LH
 lg3kF2IlFZsb1hZAWL67MseSzcifLN+ywFnIxzXAtGA+NC81/V7j4Pmy5l6JdCyhVJZS4nb5uHB
 Tn0g2DomeZXs3GIqX/ZM2YByotwjb9G1tu8v0M+hn33bt5xEUKFTgIzG/j9bE+Q64nS4KR0B7lj
 meyOzC0T5BaGyNCkWloEtV/teoqsHQI=
X-Received: by 2002:a05:6000:990:b0:48d:f831:2681 with SMTP id
 ffacd0b85a97d-4958c49890dmr2965271f8f.38.1794150720295; 
 Sun, 08 Nov 2026 07:12:00 -0800 (PST)
Received: from [127.0.0.1] ([85.204.204.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596acf465sm4913362f8f.21.2026.11.08.07.11.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2026 07:11:59 -0800 (PST)
From: Ana Bobillo <anabobillo3@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org, Tony Dinh <mibodhi@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH 1/6] fs: ext4: refuse to write with an unexpected first data
 block
Date: Sun, 08 Nov 2026 15:11:58 +0000
Message-ID: <d02a2d6f-89d9-48dd-93d0-c764fdf33e14@gmail.com>
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

ext4fs_blk_to_group() computes the block group of a block from
s_first_data_block, as Linux does. The rest of the write path takes the
first data block to be block 1 with 1 KiB blocks and block 0 otherwise,
which is what mke2fs makes: ext4fs_set_block_bmap() and
ext4fs_reset_block_bmap() find the bit of a block from the block number
alone, _get_new_blk_no() numbers the blocks of a group the same way, and
ext4fs_init() reads the group descriptor table from the block after it.

With any other s_first_data_block the two disagree, and the delete path
clears the bit of a block in the bitmap of another group. With 4 KiB
blocks and a first data block of 1, for example, block 32768 is in
group 0 for ext4fs_blk_to_group(), and ext4fs_reset_block_bmap() then
reads the byte just past the end of group 0's bitmap buffer and clears
a bit of it.

Add the first data block to the layout check of ext4fs_init(), so that
the write path refuses a filesystem whose first data block is not the
one it assumes, as it refuses other layouts its bitmap code cannot
handle. Linux refuses a first data block of 0 with 1 KiB blocks too,
unless clusters are larger.

Signed-off-by: Ana Bobillo <anabobillo3@gmail.com>
---
 fs/ext4/ext4_write.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ext4_write.c b/fs/ext4/ext4_write.c
index 0cbbdc6c934..11d9957de11 100644
--- a/fs/ext4/ext4_write.c
+++ b/fs/ext4/ext4_write.c
@@ -617,6 +617,7 @@ int ext4fs_init(void)
 	struct ext2_sblock *sblock = &ext4fs_root->sblock;
 	uint32_t blk_per_grp = le32_to_cpu(sblock->blocks_per_group);
 	uint32_t inode_per_grp = le32_to_cpu(sblock->inodes_per_group);
+	uint32_t first_data_block = le32_to_cpu(sblock->first_data_block);
 
 	/* populate fs */
 	fs->blksz = EXT2_BLOCK_SIZE(ext4fs_root);
@@ -625,14 +626,20 @@ int ext4fs_init(void)
 	/*
 	 * The bitmap code finds the bitmap bits of group n at n * blocksize
 	 * bytes, so every group must hold one bitmap block's worth of
-	 * blocks, unless there is only one group. Check this before the
+	 * blocks, unless there is only one group. It also takes the first
+	 * data block, which holds the superblock, to be block 1 with 1 KiB
+	 * blocks and block 0 otherwise, as mke2fs makes it, and so does the
+	 * write path when it finds the group descriptor table; with any
+	 * other first data block, ext4fs_blk_to_group() puts a block in
+	 * another group than the bitmap code does. Check this before the
 	 * journal is replayed, so that nothing is written to a filesystem
 	 * that is refused.
 	 */
 	if (!blk_per_grp || blk_per_grp > fs->blksz * 8 ||
 	    (blk_per_grp != fs->blksz * 8 &&
-	     le32_to_cpu(sblock->total_blocks) -
-	     le32_to_cpu(sblock->first_data_block) > blk_per_grp) ||
+	     le32_to_cpu(sblock->total_blocks) - first_data_block >
+	     blk_per_grp) ||
+	    first_data_block != (fs->blksz == EXT2_MIN_BLOCK_SIZE) ||
 	    !inode_per_grp || inode_per_grp > fs->blksz * 8) {
 		printf("Unsupported block group layout, not writing\n");
 		return -EINVAL;
