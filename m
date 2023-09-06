Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C59FEE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:31:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0954869CB;
	Wed,  6 Sep 2023 23:30:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="OzxgLioG";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VJ5X69wf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BE6A869C7; Wed,  6 Sep 2023 23:30:45 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4214B866DA
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RgwXK1T2Zz9sjR;
 Wed,  6 Sep 2023 23:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PCeuYDuu3pR8Uixzt48diTGGoGJPXCoegwRuC7kiLDE=;
 b=OzxgLioGduj7PvRi4rphqZFImEQ3qaGbXRtUxc8Ljy4qhXl2dCZIai+WXR0k1VGJTYCxA7
 d0hcNpgdKxdL69WIqw/ApGdSqd5HnydzG71nyDjRrGs1oEsPbuXH/exP25sZCz6C5c0bcS
 g7P23KL/m4+UYLXqsmc/D5U8M6x/nEqTwz/0aWx3RTRNMbAKqdoW7sIFlC+JWCok3h4D3s
 zp2O3DV2MjgDRF+v314M1LZJRUV4FOJcQBdnoYWgKjAHyiygfz48ngrn9DStduJyIFHc52
 aIZv+2AUmE0jwpk3Jy7m+Q1bwkh9YnYLU1ht9alp0u3On+0ZFGmJPKYvipB5Bg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PCeuYDuu3pR8Uixzt48diTGGoGJPXCoegwRuC7kiLDE=;
 b=VJ5X69wfxL1UlPrZ6NFpbbRYjygvDPEirFdYMwZHE4ayrrBYNib3BIPCZJTlIsK8HxlXm8
 XOsTLfrQ0tJPlV+Tb+MIjlUnrvq+Kz3DFoKjCRzsbZqXtsGtYkJ76eslf8gijTC9jLYqYB
 GmHGJpyG+QTaia6lk5JIlKdIy04tQ3RwYnY3WPAwhVY05DmGzE04MaBB0LC2sfVj1aMkBV
 t/CN78VTj6HNOS8ZM+d12snFUIpHphDs2sIIuMuxEGh0/23HY/zW5aKAbWSQrbckAixBlI
 vNDRT3iKb4d9m+o+cJlDKKdV/9R9Xey021fE4YAU357mIoG+q9quJCh++3gJhw==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 02/35] blkcache: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:42 +0200
Message-Id: <20230906213015.203437-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e493216eb3a2afd2e71
X-MBO-RS-META: e5nndxjqaipthxuadc4xk1dfpzr6azhz
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

The last user of the NEEDS_MANUAL_RELOC has been removed in commit
26af162ac8f8 ("arch: m68k: Implement relocation")
Remove now unused NEEDS_MANUAL_RELOC code.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
 cmd/blkcache.c           | 13 -------------
 common/board_r.c         |  3 ---
 drivers/block/blkcache.c | 16 ----------------
 include/blk.h            |  6 ------
 4 files changed, 38 deletions(-)

diff --git a/cmd/blkcache.c b/cmd/blkcache.c
index 47ea1ec0b93..1456654df6f 100644
--- a/cmd/blkcache.c
+++ b/cmd/blkcache.c
@@ -46,24 +46,11 @@ static struct cmd_tbl cmd_blkc_sub[] = {
 	U_BOOT_CMD_MKENT(configure, 3, 0, blkc_configure, "", ""),
 };
 
-static __maybe_unused void blkc_reloc(void)
-{
-	static int relocated;
-
-	if (!relocated) {
-		fixup_cmdtable(cmd_blkc_sub, ARRAY_SIZE(cmd_blkc_sub));
-		relocated = 1;
-	};
-}
-
 static int do_blkcache(struct cmd_tbl *cmdtp, int flag,
 		       int argc, char *const argv[])
 {
 	struct cmd_tbl *c;
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-	blkc_reloc();
-#endif
 	if (argc < 2)
 		return CMD_RET_USAGE;
 
diff --git a/common/board_r.c b/common/board_r.c
index ad9a3cf6336..697d4a5bd3d 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -657,9 +657,6 @@ static init_fnc_t init_sequence_r[] = {
 	initr_watchdog,
 #endif
 	INIT_FUNC_WATCHDOG_RESET
-#if defined(CONFIG_NEEDS_MANUAL_RELOC) && defined(CONFIG_BLOCK_CACHE)
-	blkcache_init,
-#endif
 #ifdef CONFIG_NEEDS_MANUAL_RELOC
 	initr_manual_reloc_cmdtable,
 #endif
diff --git a/drivers/block/blkcache.c b/drivers/block/blkcache.c
index f99465aa479..26bcbea4353 100644
--- a/drivers/block/blkcache.c
+++ b/drivers/block/blkcache.c
@@ -13,10 +13,6 @@
 #include <linux/ctype.h>
 #include <linux/list.h>
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-DECLARE_GLOBAL_DATA_PTR;
-#endif
-
 struct block_cache_node {
 	struct list_head lh;
 	int iftype;
@@ -34,18 +30,6 @@ static struct block_cache_stats _stats = {
 	.max_entries = 32
 };
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-int blkcache_init(void)
-{
-	struct list_head *head = &block_cache;
-
-	head->next = (uintptr_t)head->next + gd->reloc_off;
-	head->prev = (uintptr_t)head->prev + gd->reloc_off;
-
-	return 0;
-}
-#endif
-
 static struct block_cache_node *cache_find(int iftype, int devnum,
 					   lbaint_t start, lbaint_t blkcnt,
 					   unsigned long blksz)
diff --git a/include/blk.h b/include/blk.h
index b819f97c2f1..95e86e2d5d1 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -105,12 +105,6 @@ struct blk_desc {
 	(PAD_SIZE(size, blk_desc->blksz))
 
 #if CONFIG_IS_ENABLED(BLOCK_CACHE)
-
-/**
- * blkcache_init() - initialize the block cache list pointers
- */
-int blkcache_init(void);
-
 /**
  * blkcache_read() - attempt to read a set of blocks from cache
  *
-- 
2.40.1

