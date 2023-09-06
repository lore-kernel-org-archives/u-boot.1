Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0647EE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:33:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 138F486A27;
	Wed,  6 Sep 2023 23:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JCR1Hq6O";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="KB3F6JwH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BA6A86A21; Wed,  6 Sep 2023 23:30:52 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAA908685B
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RgwXS3qQFz9sSM;
 Wed,  6 Sep 2023 23:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSqm2lhRO55fE6WjiCnWi/U79EhiM+HzqvfrxntInD4=;
 b=JCR1Hq6Om4mQR0oOPaVU3gShVe8XdqYutq0Qb9OwSrsY18BlqOa9ZQszQ8RVMSC19+H35k
 oaPaQVAMj+2pjNHvX6XzgkNMoxwXKzNP1zayKhynPt6OQKYOuQzfMlF4hKaK4Se0FbjV9B
 LP775WfYId8qSdshGb7IBS90zxNytZJWUsIMY2E9VmCQ4SqAuk58y9+mJ3e85pX3VIBNor
 kSwS3l98EXw9FSr0Nz+qZjCzIjEihz0PUM2pwY4sPZ3s8tIzAAvaJHPBqUhEjKAUNMnFDb
 jCgeBvElKzZerP6jzMnqdOd7AreineaVytLxzqaXwCF8/rTtH2KU9Hq1yRpAkQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSqm2lhRO55fE6WjiCnWi/U79EhiM+HzqvfrxntInD4=;
 b=KB3F6JwHGMYFBKbsgCGekwmH+vfTi7WCC6wo+uK65ls++ZfdC1QrRIc+CGZ2KjZmPf5dOi
 lSDgbtf7qICY0jYnsiVVdc5MfQ+HNc8HcYf2scAtpkvSDoyi3jM+37bMmdzNt7dRj+nDYa
 Aj6L3JvthVQN6iAYdZ0N3QjKljKFU8oURvWewYmJIVHWIwajreLScKvv9LbWDb1Y4VBzyx
 /+Os5VDIiwKaouZeRoBeioRN/dh/mVDwU+5jY5+ZvHkGMzUHzykegvMUdFmM9PCVwlYJaw
 FjnkmtYcZu6nMmwrVmOIzGHoUDrkrMuN68ubNNmAjNFF142BsDbTqcahT+m0GQ==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 13/35] cmd: nvedit: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:53 +0200
Message-Id: <20230906213015.203437-14-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1ef44eb8c55e8a4ff52
X-MBO-RS-META: 1b461o3jsc37j7jpp55tmyty5rcswa11
X-Rspamd-Queue-Id: 4RgwXS3qQFz9sSM
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
 cmd/nvedit.c  | 11 -----------
 env/common.c  |  1 -
 include/env.h |  8 --------
 3 files changed, 20 deletions(-)

diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 9e4ee4b0177..fe99157fd17 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -407,11 +407,7 @@ static int print_active_callback(struct env_entry *entry)
 	for (i = 0, clbkp = ll_entry_start(struct env_clbk_tbl, env_clbk);
 	     i < num_callbacks;
 	     i++, clbkp++) {
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-		if (entry->callback == clbkp->callback + gd->reloc_off)
-#else
 		if (entry->callback == clbkp->callback)
-#endif
 			break;
 	}
 
@@ -1222,13 +1218,6 @@ static struct cmd_tbl cmd_env_sub[] = {
 #endif
 };
 
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-void env_reloc(void)
-{
-	fixup_cmdtable(cmd_env_sub, ARRAY_SIZE(cmd_env_sub));
-}
-#endif
-
 static int do_env(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
 	struct cmd_tbl *cp;
diff --git a/env/common.c b/env/common.c
index 0ecdb248a08..4cf2dadc694 100644
--- a/env/common.c
+++ b/env/common.c
@@ -429,7 +429,6 @@ int env_export(env_t *env_out)
 void env_relocate(void)
 {
 #if defined(CONFIG_NEEDS_MANUAL_RELOC)
-	env_reloc();
 	env_fix_drivers();
 	env_htab.change_ok += gd->reloc_off;
 #endif
diff --git a/include/env.h b/include/env.h
index 1480efa59e3..b28886d80b9 100644
--- a/include/env.h
+++ b/include/env.h
@@ -356,14 +356,6 @@ char *env_get_default(const char *name);
 /* [re]set to the default environment */
 void env_set_default(const char *s, int flags);
 
-/**
- * env_reloc() - Relocate the 'env' sub-commands
- *
- * This is used for those unfortunate archs with crappy toolchains
- */
-void env_reloc(void);
-
-
 /**
  * env_import_fdt() - Import environment values from device tree blob
  *
-- 
2.40.1

