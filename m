Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 832E0EE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:31:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21FB6869D8;
	Wed,  6 Sep 2023 23:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="QLn7icYa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="LliUidQb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F57866DA; Wed,  6 Sep 2023 23:30:45 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAA7386989
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RgwXK5n3qz9sjR;
 Wed,  6 Sep 2023 23:30:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLaIZRVGFRstbCQoBIaZ/4jmwcIOVT/0a+Kh8h+jo0w=;
 b=QLn7icYa52C6+Di3fs+gM2lSZL/z8AW1LIBjeKXVDw20slVNROlq7cHWacMZQQ7+vHp2ei
 KWvID5kRCnq0Mx9kj/lHW13QOK4BntrAwctDvZ+kPG+sP5w2ZUszW0WrInUk4QGzPdR1iO
 LEwN6mogxCSE0s1L0V+s7ZY9L/ZB6QW0ayU83+jP2mUyT5MHbiwvG0U6lVE41HTtMUzgak
 0V1AfQRTIEJUmtiZC5x6NCybHWZKNeIsFeIXnhMtxLNBqW8sxnSJt+CuZ+bbKUj/nWi2Rj
 QeG1e/PfoGjlO5NVvAJ0o6hRf8X7n1tSA249yVkiVzP7s++D/l/2BL6nm6sJew==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLaIZRVGFRstbCQoBIaZ/4jmwcIOVT/0a+Kh8h+jo0w=;
 b=LliUidQbl+7sEGoTiK3sY2Qd5+IotvaS7wiokXEKtWCfH974dbMK8IR9UjFm6y5I9VWope
 8o0tu8f5KVtiPFJU0kCgXCNWqxqDKhYLrRL9VwqvPWaXTz39TJA6ETGrqENICKuouUOZ1U
 9Ab7seWsdofLkXKj2EfpqlOQH3lA1PcYJmScF0ol5WlUf56/rHXFxWAiGitTIwKdJUfK3J
 Rs03URSjJbfbJ60SY5cywi0nLiLgkb9oWSl5JWD0HObhF8kUbxYGWTtTD+wo6wyj5EgKHj
 5v4kULpHztD+KkC2jo3DOe5cKomPrs3WPwydm7lvIuFvCq6pv1lh6SufcgPOtA==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 03/35] command: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:43 +0200
Message-Id: <20230906213015.203437-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 199a557ad373a44325c
X-MBO-RS-META: d1i4xqb5zren47q3mi118jtsbt4x6aab
X-Rspamd-Queue-Id: 4RgwXK5n3qz9sjR
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
 include/command.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/include/command.h b/include/command.h
index c4e3170967d..ae7bb4a30b0 100644
--- a/include/command.h
+++ b/include/command.h
@@ -318,24 +318,6 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 # define _CMD_HELP(x)
 #endif
 
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-#define U_BOOT_SUBCMDS_RELOC(_cmdname)					\
-	static void _cmdname##_subcmds_reloc(void)			\
-	{								\
-		static int relocated;					\
-									\
-		if (relocated)						\
-			return;						\
-									\
-		fixup_cmdtable(_cmdname##_subcmds,			\
-			       ARRAY_SIZE(_cmdname##_subcmds));		\
-		relocated = 1;						\
-	}
-#else
-#define U_BOOT_SUBCMDS_RELOC(_cmdname)					\
-	static void _cmdname##_subcmds_reloc(void) { }
-#endif
-
 #define U_BOOT_SUBCMDS_DO_CMD(_cmdname)					\
 	static int do_##_cmdname(struct cmd_tbl *cmdtp, int flag,	\
 				 int argc, char *const argv[],		\
@@ -343,8 +325,6 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 	{								\
 		struct cmd_tbl *subcmd;					\
 									\
-		_cmdname##_subcmds_reloc();				\
-									\
 		/* We need at least the cmd and subcmd names. */	\
 		if (argc < 2 || argc > CONFIG_SYS_MAXARGS)		\
 			return CMD_RET_USAGE;				\
@@ -379,7 +359,6 @@ int cmd_source_script(ulong addr, const char *fit_uname, const char *confname);
 
 #define U_BOOT_SUBCMDS(_cmdname, ...)					\
 	static struct cmd_tbl _cmdname##_subcmds[] = { __VA_ARGS__ };	\
-	U_BOOT_SUBCMDS_RELOC(_cmdname)					\
 	U_BOOT_SUBCMDS_DO_CMD(_cmdname)					\
 	U_BOOT_SUBCMDS_COMPLETE(_cmdname)
 
-- 
2.40.1

