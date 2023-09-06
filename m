Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C618FEE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:31:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66FCC869E4;
	Wed,  6 Sep 2023 23:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kC3+5AvI";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="sime27lw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61FE886989; Wed,  6 Sep 2023 23:30:45 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE6938685B
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RgwXL4Rk9z9sjR;
 Wed,  6 Sep 2023 23:30:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/P8PJ4Cm7Yrx9Zm94kvzK1KHPTDTSv71D2rsKACg6s=;
 b=kC3+5AvI+NvFOcC6qby3V2VorilUZe3oawAvR79xUDGxbduR20Uzmai+0+8hSMgGoY2MKV
 PZnCJ+0Rfbmu+fzZZwbAyLxbxO1q9smBqo22BG0N1pcVa8Sux0EbxZEhkDmpgs+X3PYypY
 Xbgcf4BP1fLlxcXBbVtoU3f9tE5xIt06buymtaTTWoM6Jca1soEmgM0eXWcv6CE46nEZTA
 Kvje4okIuXIOB4Ouv5mc08Veda2+UCo0yzG9G8uI3v9gRGqIfdOx8nfHq19g9VBxD0b6+o
 65Uyfh8NT9UYFKvGPouAswZM+DgwDrU5prEmewY7mNYuVMNwGMxN2nVrXNb30Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z/P8PJ4Cm7Yrx9Zm94kvzK1KHPTDTSv71D2rsKACg6s=;
 b=sime27lwoSYfGn3i8HuWJ+MKunyu+0XU6N6KlsJLt8JhxqHWkDhV4UTsmyO8BxI3EJjnKM
 +pnzF2PjwLasCCcSoLSu8b9aiC6XcP+HblDLNV3mlne4OQ8ltB/nzwa5PUmmdzdODT3dDH
 oFFOXL21KgeXLI7MsD9EgM8qkpBx1ox9fqS4HFfzV7xCC/Ung78eWXqKOrdO7FTVM5qTjs
 Xv2RMkhlWgSQUycwe952ZAP01sQz6z36E4AlTZk2LXeRyaHKCFHVHoeAFHWljbO/WQ5q5g
 H+GV3QnOj5RvN/aFwRM1ia0EmXqUA4LGmySX+K26sdJna+O8m38LZbkKTxDmZQ==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 04/35] common: board_r: Remove unused NEEDS_MANUAL_RELOC code
 bits
Date: Wed,  6 Sep 2023 23:29:44 +0200
Message-Id: <20230906213015.203437-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1aybjfhakw11qanqcyuzd41tu6eto6wx
X-MBO-RS-ID: 509832c5ab493c87d5f
X-Rspamd-Queue-Id: 4RgwXL4Rk9z9sjR
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
 common/board_r.c   | 22 ----------------------
 include/relocate.h | 12 +-----------
 lib/initcall.c     | 10 ----------
 3 files changed, 1 insertion(+), 43 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 697d4a5bd3d..630c104a985 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -151,13 +151,6 @@ static int initr_reloc_global_data(void)
 	 */
 	gd->env_addr += gd->reloc_off;
 #endif
-	/*
-	 * The fdt_blob needs to be moved to new relocation address
-	 * incase of FDT blob is embedded with in image
-	 */
-	if (IS_ENABLED(CONFIG_OF_EMBED) && IS_ENABLED(CONFIG_NEEDS_MANUAL_RELOC))
-		gd->fdt_blob += gd->reloc_off;
-
 #ifdef CONFIG_EFI_LOADER
 	/*
 	 * On the ARM architecture gd is mapped to a fixed register (r9 or x18).
@@ -295,15 +288,6 @@ static int initr_announce(void)
 	return 0;
 }
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-static int initr_manual_reloc_cmdtable(void)
-{
-	fixup_cmdtable(ll_entry_start(struct cmd_tbl, cmd),
-		       ll_entry_count(struct cmd_tbl, cmd));
-	return 0;
-}
-#endif
-
 static int initr_binman(void)
 {
 	int ret;
@@ -657,9 +641,6 @@ static init_fnc_t init_sequence_r[] = {
 	initr_watchdog,
 #endif
 	INIT_FUNC_WATCHDOG_RESET
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-	initr_manual_reloc_cmdtable,
-#endif
 	arch_initr_trap,
 #if defined(CONFIG_BOARD_EARLY_INIT_R)
 	board_early_init_r,
@@ -803,9 +784,6 @@ void board_init_r(gd_t *new_gd, ulong dest_addr)
 #endif
 	gd->flags &= ~GD_FLG_LOG_READY;
 
-	if (IS_ENABLED(CONFIG_NEEDS_MANUAL_RELOC))
-		initcall_manual_reloc(init_sequence_r);
-
 	if (initcall_run_list(init_sequence_r))
 		hang();
 
diff --git a/include/relocate.h b/include/relocate.h
index 2dbfd901e4f..5ae1a2ed555 100644
--- a/include/relocate.h
+++ b/include/relocate.h
@@ -50,17 +50,7 @@ int do_elf_reloc_fixups(void);
  */
 static inline void *manual_reloc(void *ptr)
 {
-#ifndef USE_HOSTCC
-	if (IS_ENABLED(CONFIG_NEEDS_MANUAL_RELOC))
-		return ptr + gd->reloc_off;
-#endif
-		return ptr;
+	return ptr;
 }
 
-#if !defined(USE_HOSTCC) && defined(CONFIG_NEEDS_MANUAL_RELOC)
-#define MANUAL_RELOC(ptr)	(ptr) = manual_reloc(ptr)
-#else
-#define MANUAL_RELOC(ptr)	(void)(ptr)
-#endif
-
 #endif	/* _RELOCATE_H_ */
diff --git a/lib/initcall.c b/lib/initcall.c
index 480490ea239..33b7d761dc7 100644
--- a/lib/initcall.c
+++ b/lib/initcall.c
@@ -97,13 +97,3 @@ int initcall_run_list(const init_fnc_t init_sequence[])
 
 	return 0;
 }
-
-void initcall_manual_reloc(init_fnc_t init_sequence[])
-{
-	init_fnc_t *ptr;
-
-	for (ptr = init_sequence; *ptr; ptr++) {
-		if (!initcall_is_event(*ptr))
-			MANUAL_RELOC(*ptr);
-	}
-}
-- 
2.40.1

