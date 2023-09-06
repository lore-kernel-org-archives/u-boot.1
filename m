Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F035BEE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C55286A02;
	Wed,  6 Sep 2023 23:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EnNnFE/c";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wUQqn5wI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5384869E5; Wed,  6 Sep 2023 23:30:47 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5B8A869BB
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RgwXN4XWvz9sW6;
 Wed,  6 Sep 2023 23:30:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVvD6obeEthv5Sf3MLjm/PMVWHLhH5TaAKpyLR8v/hQ=;
 b=EnNnFE/c66IxPxoaTDpPpZQIh8EtTd6GTJcBqeC7W3pwVFnPNPttIpdMIT4EQxhL9/Lg2N
 1N+QeBxydCRkxEZxAm+Cr20tF2ttS6CtLeLmOmcrY0FiIuNIDf3EEMn/wctCONrEJJBfxO
 blbiEoHhtWeaJwWYw+XawNa3hd4ceLNYNmN3sZkRnO0/nLZQbhYu+GCaUQPDnVT2AJ6vwk
 xd7Re5i5XlyIc60RJtSGWTaW73ONaqddpK61oFlmCwYmRKhbbnT+HJsMewLrBkYVpaXePw
 M6kdSHrNmFV52/8ZvoNEOyr/JZ8Z2OrBOGUMszHrhG/ZAWGQoXv20hUgLa+n+A==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVvD6obeEthv5Sf3MLjm/PMVWHLhH5TaAKpyLR8v/hQ=;
 b=wUQqn5wIWmbKREW+1nTW/fTCxdMbTmLv861UjBjMQAXhD3Z1S+JGB8DVUCu6znSZk2Uftp
 BfRfAEeRKA+xbZKJ17Ex45y1Qgw1l645HAVfNPpBGSe8XfX9xN17xQFkh+ylokygnvVaDP
 JrmKdFWSutHBy6SyrfaMD2vFSEnqlvaB1Q8jZxUrekwba3kKHB9/nYGAUG3tIBKsnARY4D
 seJPI2wHzjxfOuYDLtVFtW2be94mBPp6WHUNtauzKD/41Z2+Hrb7zm3SRKyCz5c7ItZ0pH
 hEgVAjyWl4ffuGQezejqJ8EPmbbF7mX8/xdDnS/6mB6Mgwph9UjcBpsA9hgSPw==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 07/35] common: event: Remove unused NEEDS_MANUAL_RELOC code
 bits
Date: Wed,  6 Sep 2023 23:29:47 +0200
Message-Id: <20230906213015.203437-8-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 618dfdeaffa6654cc28
X-MBO-RS-META: mgewjy7k1oowtax1pbfxyr9h53nbsp64
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
 common/board_r.c |  3 ---
 common/event.c   | 14 --------------
 include/event.h  | 10 ----------
 3 files changed, 27 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 630c104a985..e30963339cf 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -590,9 +590,6 @@ static init_fnc_t init_sequence_r[] = {
 	 */
 #endif
 	initr_reloc_global_data,
-#if IS_ENABLED(CONFIG_NEEDS_MANUAL_RELOC) && CONFIG_IS_ENABLED(EVENT)
-	event_manual_reloc,
-#endif
 #if defined(CONFIG_SYS_INIT_RAM_LOCK) && defined(CONFIG_E500)
 	initr_unlock_ram_in_cache,
 #endif
diff --git a/common/event.c b/common/event.c
index d11b37a1d80..3080d9ed754 100644
--- a/common/event.c
+++ b/common/event.c
@@ -168,20 +168,6 @@ void event_show_spy_list(void)
 	}
 }
 
-#if IS_ENABLED(CONFIG_NEEDS_MANUAL_RELOC)
-int event_manual_reloc(void)
-{
-	struct evspy_info *spy, *end;
-
-	spy = ll_entry_start(struct evspy_info, evspy_info);
-	end = ll_entry_end(struct evspy_info, evspy_info);
-	for (; spy < end; spy++)
-		MANUAL_RELOC(spy->func);
-
-	return 0;
-}
-#endif
-
 #if CONFIG_IS_ENABLED(EVENT_DYNAMIC)
 static void spy_free(struct event_spy *spy)
 {
diff --git a/include/event.h b/include/event.h
index 311df878c4a..be4cefd6ae8 100644
--- a/include/event.h
+++ b/include/event.h
@@ -328,16 +328,6 @@ int event_register(const char *id, enum event_t type, event_handler_t func,
 /** event_show_spy_list( - Show a list of event spies */
 void event_show_spy_list(void);
 
-/**
- * event_manual_reloc() - Relocate event handler pointers
- *
- * Relocate event handler pointers for all static event spies. It is called
- * during the generic board init sequence, after relocation.
- *
- * Return: 0 if OK
- */
-int event_manual_reloc(void);
-
 /**
  * event_type_name() - Get the name of an event type
  *
-- 
2.40.1

