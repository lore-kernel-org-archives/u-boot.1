Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A687EE14C3
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E66286A0A;
	Wed,  6 Sep 2023 23:30:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="B0siJKuK";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EvBrI68P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C85A6869C3; Wed,  6 Sep 2023 23:30:47 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5465E866DA
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RgwXP225fz9tTZ;
 Wed,  6 Sep 2023 23:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWVzM+GSHxjH3k37Usn5OeUFomBCI4xn/MfWn3ivtDo=;
 b=B0siJKuKsyVXVCk2R/p8+uT8K8xqRCouXdnHyhNaCCKcU36RUN5YYlWb80w/wtERcIrIM8
 VnZ/X49prBENGvmPAATGHccuMWNcOpW2G/51fp5NW/3njuT90e9MosSTE/4OI5FfK39q7T
 ERNjhM1QO64uVFEh+g0U99U/KU+yo7pQ6rGFR8bgiS8NdR4WuMVwKJTJTppfBx8ONR+N2+
 6wTZAIxMtroyYURotn6nk8+cx8E2Zp2f2K/UagJ7mTC+j6IO2kJ/o/GqCr7S9rUg2JRqYs
 s/dXiD8gVW7RLUMrtWv3odI9uavnTCg4S5FqSdJD5TS4oYmkvB+odr805NzPaQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWVzM+GSHxjH3k37Usn5OeUFomBCI4xn/MfWn3ivtDo=;
 b=EvBrI68PwFsDiikHKRnQBDAPlYA78SB6NF6JxvgywwEQBhDADGUmvZkj2T2wVT480prGqd
 qQbS099cbGE+Iod6i9FkE+jH4kWOZqsoy3Snuc5mAaPvB9pvG8xl5v8sV9Cz4Vzi8k1kuL
 UlPBT745fC3Pp5OVvny5SjcmZGwuGDZKKoGYqfQfj+oIKWekISUThnxOA8SYI0ERwZHDe/
 d3e8kAokQJeMtNFkqrhh8oNa8rjJna+Bk/d1Lat2o6K9dt0WUBP7+fjVizWwV8mYAW3qQQ
 mzAgUmdy4i6k9CL+gLjYsN3KpLLffYaAFsvGwquA/287g51xgQv1YaCktAKNAA==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 08/35] common: hash: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:48 +0200
Message-Id: <20230906213015.203437-9-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: e5fb415aab765d62b7a
X-MBO-RS-META: rd77kzwc8gsmx9i66mzb6gfx9juw3cwk
X-Rspamd-Queue-Id: 4RgwXP225fz9tTZ
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
 common/hash.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/common/hash.c b/common/hash.c
index 159179e7f21..e837c56d443 100644
--- a/common/hash.c
+++ b/common/hash.c
@@ -36,12 +36,6 @@
 #include <u-boot/sha512.h>
 #include <u-boot/md5.h>
 
-#if !defined(USE_HOSTCC) && defined(CONFIG_NEEDS_MANUAL_RELOC)
-DECLARE_GLOBAL_DATA_PTR;
-#endif
-
-static void reloc_update(void);
-
 static int __maybe_unused hash_init_sha1(struct hash_algo *algo, void **ctxp)
 {
 	sha1_context *ctx = malloc(sizeof(sha1_context));
@@ -333,31 +327,10 @@ static struct hash_algo hash_algo[] = {
 #define multi_hash()	0
 #endif
 
-static void reloc_update(void)
-{
-#if !defined(USE_HOSTCC) && defined(CONFIG_NEEDS_MANUAL_RELOC)
-	int i;
-	static bool done;
-
-	if (!done) {
-		done = true;
-		for (i = 0; i < ARRAY_SIZE(hash_algo); i++) {
-			hash_algo[i].name += gd->reloc_off;
-			hash_algo[i].hash_func_ws += gd->reloc_off;
-			hash_algo[i].hash_init += gd->reloc_off;
-			hash_algo[i].hash_update += gd->reloc_off;
-			hash_algo[i].hash_finish += gd->reloc_off;
-		}
-	}
-#endif
-}
-
 int hash_lookup_algo(const char *algo_name, struct hash_algo **algop)
 {
 	int i;
 
-	reloc_update();
-
 	for (i = 0; i < ARRAY_SIZE(hash_algo); i++) {
 		if (!strcmp(algo_name, hash_algo[i].name)) {
 			*algop = &hash_algo[i];
@@ -374,8 +347,6 @@ int hash_progressive_lookup_algo(const char *algo_name,
 {
 	int i;
 
-	reloc_update();
-
 	for (i = 0; i < ARRAY_SIZE(hash_algo); i++) {
 		if (!strcmp(algo_name, hash_algo[i].name)) {
 			if (hash_algo[i].hash_init) {
-- 
2.40.1

