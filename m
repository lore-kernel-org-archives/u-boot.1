Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A0AEE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FF9586A45;
	Wed,  6 Sep 2023 23:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hLiX4OX5";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="eK9a05Eb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA4A78698F; Wed,  6 Sep 2023 23:30:53 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F7ED869A0
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RgwXW0zYrz9sW6;
 Wed,  6 Sep 2023 23:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzdqsVK9ioXf36CXQi6HFn3nlnDw8S6sDg4Yen337kc=;
 b=hLiX4OX5V0ba94p9J15J/9ES+uzl8eCQY4QXg/4u7TJHdZJft90L829GWABy5e6HZmG24H
 Xc6nEYkd2i+58A/OSBCVSF/Pw9XsUbJjZhrOBEe9f68Hn6LkCF3hCJb4f4CHmtcdDou7YV
 dgCk6uuIjmxf3MzZsZtaLHERBeZnpC1a0fCLSvt8EBuG9hOjRBDdXhv8vZqdJEksmjvhTp
 yW7hO6lX2BK/0vL6wLYZMBdSJMCrs2+NEtDKspXlYGkuek14spmXz3MB/A5RlGHFckZX0z
 ak40qvIm/c1dps3nc7Jwzjmm8t+CJJS1/yGmEdcAj/sqOc8k0zNc8KsSdWYk5w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzdqsVK9ioXf36CXQi6HFn3nlnDw8S6sDg4Yen337kc=;
 b=eK9a05EbSMEbMmB9qdBB2WVpBFhbAGKM35q+GpKzxjGmX/NH87hcIWEKdW7JzeL8oIaHed
 o/m7NsNAelT+e19iLYnVG9z9TWkXkdKz9eJAmdt/HpR+slM9hqBmoA9hS33B8U5mkyJ1jT
 SVfQ7KIXSK87xy+SgXFAs7wJKYpOvy7G8i3gboEpueitP9aAbLXOWaT8BtonqKdV+a3rG9
 YdDqOQFsm1MBSIjNu1KAY6L66wZB4zD0aCroV+Ye+t/nkjogOdoAIBLsiLxojJkxwl4XsJ
 aRwkD97JffZtf5XbdUPcGGkJRutUWFiAf9tqrtVoDkwUq62Tm4RbcImMZwht0A==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 17/35] env: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:57 +0200
Message-Id: <20230906213015.203437-18-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: tw8qd1ny4h764opfh9oa7dpyehfigtbz
X-MBO-RS-ID: 8d2da5a4d31ae72a836
X-Rspamd-Queue-Id: 4RgwXW0zYrz9sW6
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
 env/callback.c | 12 ------------
 env/common.c   |  4 ----
 env/env.c      | 23 -----------------------
 include/env.h  |  5 -----
 4 files changed, 44 deletions(-)

diff --git a/env/callback.c b/env/callback.c
index 638a02b28f7..98ddba035ea 100644
--- a/env/callback.c
+++ b/env/callback.c
@@ -9,10 +9,6 @@
 #include <env_internal.h>
 #include <asm/global_data.h>
 
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-DECLARE_GLOBAL_DATA_PTR;
-#endif
-
 /*
  * Look up a callback function pointer by name
  */
@@ -71,11 +67,7 @@ void env_callback_init(struct env_entry *var_entry)
 	if (!ret && strlen(callback_name)) {
 		clbkp = find_env_callback(callback_name);
 		if (clbkp != NULL)
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-			var_entry->callback = clbkp->callback + gd->reloc_off;
-#else
 			var_entry->callback = clbkp->callback;
-#endif
 	}
 }
 
@@ -112,11 +104,7 @@ static int set_callback(const char *name, const char *value, void *priv)
 			/* assign the requested callback */
 			clbkp = find_env_callback(value);
 			if (clbkp != NULL)
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-				ep->callback = clbkp->callback + gd->reloc_off;
-#else
 				ep->callback = clbkp->callback;
-#endif
 		}
 	}
 
diff --git a/env/common.c b/env/common.c
index 4cf2dadc694..21045a7eb33 100644
--- a/env/common.c
+++ b/env/common.c
@@ -428,10 +428,6 @@ int env_export(env_t *env_out)
 
 void env_relocate(void)
 {
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-	env_fix_drivers();
-	env_htab.change_ok += gd->reloc_off;
-#endif
 	if (gd->env_valid == ENV_INVALID) {
 #if defined(CONFIG_ENV_IS_NOWHERE) || defined(CONFIG_SPL_BUILD)
 		/* Environment not changable */
diff --git a/env/env.c b/env/env.c
index 2aa52c98f8f..bae3f6482ae 100644
--- a/env/env.c
+++ b/env/env.c
@@ -14,29 +14,6 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#if defined(CONFIG_NEEDS_MANUAL_RELOC)
-void env_fix_drivers(void)
-{
-	struct env_driver *drv;
-	const int n_ents = ll_entry_count(struct env_driver, env_driver);
-	struct env_driver *entry;
-
-	drv = ll_entry_start(struct env_driver, env_driver);
-	for (entry = drv; entry != drv + n_ents; entry++) {
-		if (entry->name)
-			entry->name += gd->reloc_off;
-		if (entry->load)
-			entry->load += gd->reloc_off;
-		if (entry->save)
-			entry->save += gd->reloc_off;
-		if (entry->erase)
-			entry->erase += gd->reloc_off;
-		if (entry->init)
-			entry->init += gd->reloc_off;
-	}
-}
-#endif
-
 static struct env_driver *_env_driver_lookup(enum env_location loc)
 {
 	struct env_driver *drv;
diff --git a/include/env.h b/include/env.h
index b28886d80b9..430c4fa94a4 100644
--- a/include/env.h
+++ b/include/env.h
@@ -239,11 +239,6 @@ int eth_env_get_enetaddr(const char *name, uint8_t *enetaddr);
  */
 int eth_env_set_enetaddr(const char *name, const uint8_t *enetaddr);
 
-/**
- * env_fix_drivers() - Updates envdriver as per relocation
- */
-void env_fix_drivers(void);
-
 /**
  * env_set_default_vars() - reset variables to their default value
  *
-- 
2.40.1

