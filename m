Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B0EEE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2B1686A4F;
	Wed,  6 Sep 2023 23:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uHpAq8/6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wnZIMO2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43F3B869EA; Wed,  6 Sep 2023 23:30:55 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFF7B869F6
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RgwXX2pHqz9sn0;
 Wed,  6 Sep 2023 23:30:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5puB1B4KHcm6uFFPL+vOgCZk6p2Z0D+TuaNybKjiWig=;
 b=uHpAq8/6mOZOkcMU0VQh2yi5yNOk0oXKearEF+GypvhHlQNtqowgBFt68eQCAxXmT4sl5D
 EgVbuxzJDDzjJQSS+XFm8vSJO+N5gldG7WWDClFTRZ3iB2UY+DrgZ7mLDJZtKck+phxvUy
 IIvE4Pt+j5mh6VYBrrNQWP4LhpeR0lXc2Fr004vqdVUl0MdH76bn8FP2nHS8xB42JtKMHP
 po2+VoxgM7EKe8wwcc3Ukr66i+W6zKUwFvbeNpxHAecivaGLUNskN3RfCCc+hSA+y5hpkt
 T5YcKX5T/4hGULgZwx94AXujxvyVwUs7lbuX4Fo+a2pyUADVpq7PpCP/FwL2lw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5puB1B4KHcm6uFFPL+vOgCZk6p2Z0D+TuaNybKjiWig=;
 b=wnZIMO2+EwGfsvF4xJmTZ1a08oOkpxwmjWN1kRPkwpdfwn8mUJeXMf0poubw4KEP6BfBmO
 oOu5vBuBxiPBHr1Ql22XlOta+2z/boNgY0+Jkew8xlGCsruqXo9VgHGTS3HqiOC7aE37yg
 VKR5A2wXkExa37cxLyQLIx7bjCG5tqXpjq76TWQP9IdNUBlZN7fHhoXwCtRolyj1IcbseH
 s82M75ISYxQQMWQzKDBjwDpwQ6mfQDyBAxUlg9ASB02U9cT2jiUI2jWQHbTsM1kb5SSzbK
 IigUGiCT+AkHpLjBPxs65C8FZvjryKgdVH97+uoMX8/vmszUJQcS3RqTLybG2A==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 19/35] image: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:59 +0200
Message-Id: <20230906213015.203437-20-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: f89413031976f7f5925
X-MBO-RS-META: tih5m9eqizc1h6n7gc1yo5ndrm7xpqhu
X-Rspamd-Queue-Id: 4RgwXX2pHqz9sn0
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
 boot/image.c       | 10 +++++-----
 include/relocate.h | 14 --------------
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/boot/image.c b/boot/image.c
index 5c4f9b807d6..26f68d4c407 100644
--- a/boot/image.c
+++ b/boot/image.c
@@ -571,7 +571,7 @@ const char *genimg_get_cat_name(enum ih_category category, uint id)
 	entry = get_table_entry(table_info[category].table, id);
 	if (!entry)
 		return unknown_msg(category);
-	return manual_reloc(entry->lname);
+	return entry->lname;
 }
 
 /**
@@ -591,7 +591,7 @@ const char *genimg_get_cat_short_name(enum ih_category category, uint id)
 	entry = get_table_entry(table_info[category].table, id);
 	if (!entry)
 		return unknown_msg(category);
-	return manual_reloc(entry->sname);
+	return entry->sname;
 }
 
 int genimg_get_cat_count(enum ih_category category)
@@ -641,7 +641,7 @@ char *get_table_entry_name(const table_entry_t *table, char *msg, int id)
 	table = get_table_entry(table, id);
 	if (!table)
 		return msg;
-	return manual_reloc(table->lname);
+	return table->lname;
 }
 
 const char *genimg_get_os_name(uint8_t os)
@@ -676,7 +676,7 @@ static const char *genimg_get_short_name(const table_entry_t *table, int val)
 	table = get_table_entry(table, val);
 	if (!table)
 		return "unknown";
-	return manual_reloc(table->sname);
+	return table->sname;
 }
 
 const char *genimg_get_type_short_name(uint8_t type)
@@ -719,7 +719,7 @@ int get_table_entry_id(const table_entry_t *table,
 	const table_entry_t *t;
 
 	for (t = table; t->id >= 0; ++t) {
-		if (t->sname && !strcasecmp(manual_reloc(t->sname), name))
+		if (t->sname && !strcasecmp(t->sname, name))
 			return t->id;
 	}
 	debug("Invalid %s Type: %s\n", table_name, name);
diff --git a/include/relocate.h b/include/relocate.h
index 5ae1a2ed555..8ca25e1105e 100644
--- a/include/relocate.h
+++ b/include/relocate.h
@@ -39,18 +39,4 @@ int clear_bss(void);
  */
 int do_elf_reloc_fixups(void);
 
-/**
- * manual_reloc() - Manually relocate a pointer if needed
- *
- * This is a nop in almost all cases, except for the systems with a broken gcc
- * which need to manually relocate some things.
- *
- * @ptr: Pointer to relocate
- * Return: new pointer value
- */
-static inline void *manual_reloc(void *ptr)
-{
-	return ptr;
-}
-
 #endif	/* _RELOCATE_H_ */
-- 
2.40.1

