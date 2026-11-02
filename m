Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90729606AB84
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hcgdxJ7y;
	dkim=pass (2048-bit key, unprotected) header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=XLB82E3F
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 537C28100D;
	Mon,  2 Nov 2026 16:20:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5h1IrEXv3Ss7; Mon,  2 Nov 2026 16:20:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6D5A681098
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793636454;
	b=JWwZwCK90NT3OYaRcxLCdNRF5nL/ANO4iXv3sJ/LTkJmUR0nQ/gWQmGp548ccmJeBP7J
	 1LmqmvuZNkDfAwfZffhoe/gqKWCDNLt3KRW2woFNKVKjmiKtMLpOAUSOHUoTEDvO+ETlT
	 nwEvxSB8IdIAB+170KoBGhlM3RQnRKTePf0eAMlVRDtBN7EbJsriLDctRJnIXPc+6qKV2
	 Q2YlF5DNImNwiX5Fp4/eykY5KsfFEbijNwAAs5T5I8HTOshJpryWRPQDF1RtiN+d9wv7T
	 xqYNIQlKStCfq/64VicZcXc5oEqlcAzsMjpKxJjXUq9ZD69sftJYCxqv5dWq4GFTV1g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793636454;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:From:
	 DKIM-Signature:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Developer-Signature:X-Developer-Key:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=tA80mPNH8Y/76Dl3oYF6uTqTVqZU6wGkboDgtM1TvlY=;
	b=pZ1vFfrjL7TZ19ePDP0L2mlqlzk7Gs8zygBs/gYJ2QuQ+EVR5gRkWCexyTz7nS7RbGPs
	 cQ4WBhGbqSrU4VNr6FTrw8a2vWPo6XmTtRNYjcroMNfwlDKfdIp9moaIgtabgj3B4v5hz
	 4+M1GNZyTlO84hHzPbJex/xxepUkFF5d8TdHRXFcPKXoZaxclSsluVkYr7uQ9lYkPLY/7
	 Gd51XG2jAHqXAy5NOGu39fZLjXvFOwZCihwEe4HLrCyTH10uDjLvuU0nUTHlZ65JY+SnO
	 8+pKnEbR2uxwj826xEL1Z42ydiMg/TdR8/B8dvhtnLc76k9RSHQj/EWDBHmKvFBSAow==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=fris.de;
	dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail header.b=XLB82E3F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793636454;
	bh=tA80mPNH8Y/76Dl3oYF6uTqTVqZU6wGkboDgtM1TvlY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hcgdxJ7ySp0xmWtNj6dp7xWxz5Ovahwxr1r2EgMZXg9MVbncz/BrhfKRpB4mPV6ob
	 dXzYWrEbHJcLtuPV2kw9STVvhxed+k5biIgrDzoLoq9byogOkXC/V/iEgSagEnNyoQ
	 05Z4WCbScBQosuZdhfbl9cs+awRZmQRMkPoogVzwm7EA4MLWoqVvm0ACg7lyV9bItR
	 Y7aBbckPxa+NifFTW4M10f6euGdqClINRfxksuXMigTgFqGaviqJEsTKla91IhBUXu
	 L1+l4Nf5WxK4Ex4sawhSTDALMFGRcOQENJf/VPyALbihj893b0L0JgFRFMqggcckPh
	 P9g7GqRpqhnpg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D5A681098;
	Mon,  2 Nov 2026 16:20:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id F0EDFD3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EE47E8100D
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UT3756B7nZQD for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 16:20:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B521881098
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=116.203.77.234
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793636452;
 b=bLZXeIadXU6+8lGkLkqBKJu4aXzsSzsUmPvmvM8ONf1xMYWkIT77owLvIR/LkyXFRR1r
 2Tzk9gk46n57I+pbaR3wpL6VRgLdSeUTBr4dVpvhoUeI0t6I9CdvPjXzUtuPjqxm0wnNh
 ts/amHpYLZgiG6cABNPnaM+7Jek4DAdp6NJoib5y9irAFV5hergMTA2PDJsfB7yZQwOgS
 hHo3t0VCzM837zx/KZ0Nn3rKZiJqps3dfs8awxChaCklRX9zhBxQHDEjjIQcnLwsneopz
 SwgblHuvQDSvq1ETahqUJjpGbwyL53luE4rWjEMo3TcjAzaMaYuf4yhsuzhq7za65BQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793636452;
 h=Received-SPF:From:DKIM-Signature:Date:Subject:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Message-Id:References:
 In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key;
 bh=tA80mPNH8Y/76Dl3oYF6uTqTVqZU6wGkboDgtM1TvlY=;
 b=W+EFpHjpN0NHIk1JG3psdXsgu6YuxiXpx6IPJ9d3zlpgPKc/YRB6uRhIPtPPyBhlpW2F
 s8qkoq4Ld9DZUTFnpzZpqEgBT0k2nak/NNs3v78zhSgAJK5YlosbWZuX4YzyKKy/ZV7ba
 oSLs6kCMaLWmxtF0JljHRUSoe1OBOptiLjWhDvJhxkOprcfSp+EkzX33OuxnesuETTnys
 Z5OhrX4pxA7Sg4PrQ6DClDk28BdGwxXuDzsU3vo3uJXUmRxWLdFXMRXFJgf26wOH4QF7X
 tbRiSm5+ukCGUewidx14D/B4Vwx9U7PTG+3NnpzwYDmqPk9E0AyXLbJ2pIuKrsKlxDA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=fris.de;
 dkim=pass header.d=fris.de header.i=@fris.de header.a=rsa-sha256 header.s=mail
 header.b=XLB82E3F; 
 arc=none smtp.remote-ip=116.203.77.234
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=116.203.77.234;
 helo=mail.fris.de; envelope-from=frieder@fris.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de
 header.a=rsa-sha256 header.s=mail header.b=XLB82E3F
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B521881098
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 16:20:50 +0000 (UTC)
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
 t=1793636448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tA80mPNH8Y/76Dl3oYF6uTqTVqZU6wGkboDgtM1TvlY=;
 b=XLB82E3F0CY+ACyOcYj/JXfVzaJ1m8e5xWe6awbBIxS9kyY+9C2chdtEkUJpAg+uiMgVH7
 YVnAiE0DoRgb/msyVsPU2ssCI/jyiqmKYne6cIY1BHkTBxhEj04GtJTwLiCxUbuRC7aghF
 8fNvSKmBJMQs0Ph7d2uUIrmfRxCfvUQDrBhV/SLG8jTNwLYB2ZWWKaygUr/7HUI+pJTl4G
 XRmptMjslwEQ4fjAv7z8auFCRdBiH3OSezCl0vEX2cfVbUaPjZagsAlJRvS8WNDmNfQt8L
 8AT1JHPbtTWK3IJfZyswKiG2MpTbGlwLJY6TcrRUobVkByw6GIMv+D6GfuJ5rw==
Date: Mon, 02 Nov 2026 17:20:19 +0100
Subject: [PATCH v2 02/12] bootstd: rauc: Fix leak of the active slot name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-main-v2-2-4537bcb19d66@kontron.de>
References: <20261102-main-v2-0-4537bcb19d66@kontron.de>
In-Reply-To: <20261102-main-v2-0-4537bcb19d66@kontron.de>
To: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Marek Vasut <marex@nabladev.com>, 
 Michal Simek <michal.simek@amd.com>, Francesco Valla <francesco@valla.it>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5558;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=e7LU3thRj3F0E037mUaWtCO+jzWkouL6Abr2CjWZ4W4=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIevFjljuf4cjpik/P7XndXzC8USv6DLzsH/mE+qbvCNSp
 Y/L9ezsKGVhEONikBVTZJHit3htaxbrI3+sOgpmDisTyBAGLk4BmAivPcN/z2s23x6xTlgm/NFY
 1GXP3X2vt7zW08/lPWQroi0TNed/JsMvpjqG/1OXJeim/7gepBeyfob6Uta1pmyc0/oubmfsDPD
 mAwA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frieder Schrempf <frieder.schrempf@kontron.de>

find_active_slot() returns a strdup() copy of the slot name, which
distro_rauc_boot() never frees, so every boot attempt leaks it. The
strdup() result is not checked either and if it fails, get_slot() passes
NULL to strcmp().

The copy is only used to look up the slot. Pass the private data to
find_active_slot() and look up the slot there, while the boot order list
is still valid, and return the slot instead of its name. This drops the
copy altogether. It also catches a BOOT_ORDER entry without a matching
slot before its BOOT_x_LEFT counter is decremented.

Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
Assisted-by: LLM
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
- Look up the slot in find_active_slot() and return it instead of a
  strdup() copy of its name (Simon)
- Update the commit message accordingly
---
 boot/bootmeth_rauc.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
index 4a3f05103eb..7273156c4dd 100644
--- a/boot/bootmeth_rauc.c
+++ b/boot/bootmeth_rauc.c
@@ -19,6 +19,7 @@
 #include <mapmem.h>
 #include <part.h>
 #include <string.h>
+#include <linux/err.h>
 #include <linux/stringify.h>
 #include <asm/cache.h>
 
@@ -318,42 +319,46 @@ static int distro_rauc_load_boot_script(struct bootflow *bflow,
 	return 0;
 }
 
-static int find_active_slot(char **slot_name, ulong *slot_tries)
+static const struct distro_rauc_slot *find_active_slot(struct distro_rauc_priv *priv,
+						       ulong *slot_tries)
 {
 	ulong tries;
 	char boot_left[BOOT_LEFT_LEN];
 	char *boot_order;
+	const struct distro_rauc_slot *slot = NULL;
 	const char **boot_order_list;
-	bool slot_found = false;
 	int ret;
 	int i;
 
 	boot_order = env_get("BOOT_ORDER");
 	if (!boot_order)
-		return log_msg_ret("env", -ENOENT);
+		return ERR_PTR(log_msg_ret("env", -ENOENT));
 	boot_order_list = str_to_list(boot_order);
-	for (i = 0; boot_order_list[i] && !slot_found; i++) {
+	for (i = 0; boot_order_list[i] && !slot; i++) {
 		sprintf(boot_left, "BOOT_%s_LEFT", boot_order_list[i]);
 		tries = env_get_ulong(boot_left, 10, ULONG_MAX);
 		if (tries == ULONG_MAX) {
 			str_free_list(boot_order_list);
-			return log_msg_ret("env", -ENOENT);
+			return ERR_PTR(log_msg_ret("env", -ENOENT));
 		}
 
 		if (tries) {
+			slot = get_slot(priv, boot_order_list[i]);
+			if (!slot) {
+				str_free_list(boot_order_list);
+				return ERR_PTR(log_msg_ret("slot", -ENOENT));
+			}
 			ret = env_set_ulong(boot_left, tries - 1);
 			if (ret) {
 				str_free_list(boot_order_list);
-				return log_msg_ret("env", ret);
+				return ERR_PTR(log_msg_ret("env", ret));
 			}
-			*slot_name = strdup(boot_order_list[i]);
 			*slot_tries = tries;
-			slot_found = true;
 		}
 	}
 	str_free_list(boot_order_list);
 
-	if (!slot_found) {
+	if (!slot) {
 		if (IS_ENABLED(CONFIG_BOOTMETH_RAUC_RESET_ALL_ZERO_TRIES)) {
 			log_warning("WARNING: No valid slot found\n");
 			log_info("INFO: Resetting all slot tries to " __stringify(CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES) "\n");
@@ -363,20 +368,20 @@ static int find_active_slot(char **slot_name, ulong *slot_tries)
 				ret = env_set_ulong(boot_left, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
 				if (ret) {
 					str_free_list(boot_order_list);
-					return log_msg_ret("env", ret);
+					return ERR_PTR(log_msg_ret("env", ret));
 				}
 			}
 			str_free_list(boot_order_list);
 			ret = env_save();
 			if (ret)
-				return log_msg_ret("env", ret);
+				return ERR_PTR(log_msg_ret("env", ret));
 			do_reset(NULL, 0, 0, NULL);
 		}
 		log_err("ERROR: No valid slot found\n");
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 	}
 
-	return 0;
+	return slot;
 }
 
 static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
@@ -386,7 +391,6 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 	const struct distro_rauc_slot *slot;
 	char *boot_order;
 	const char **boot_order_list;
-	char *active_slot;
 	ulong active_slot_tries;
 	char raucargs[64];
 	char boot_left[BOOT_LEFT_LEN];
@@ -411,20 +415,15 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 		return log_msg_ret("env", ret);
 
 	/* Find active, valid slot */
-	ret = find_active_slot(&active_slot, &active_slot_tries);
-	if (ret)
-		return log_msg_ret("env", ret);
+	slot = find_active_slot(priv, &active_slot_tries);
+	if (IS_ERR(slot))
+		return log_msg_ret("env", PTR_ERR(slot));
 
 	/* Kernel command line arguments */
-	sprintf(raucargs, "rauc.slot=%s", active_slot);
+	sprintf(raucargs, "rauc.slot=%s", slot->name);
 	ret = env_set("raucargs", raucargs);
 	if (ret)
 		return log_msg_ret("env", ret);
-
-	/* Active slot info */
-	slot = get_slot(priv, active_slot);
-	if (!slot)
-		return log_msg_ret("env", -ENOENT);
 	ret = env_set_hex("distro_bootpart", slot->boot_part);
 	if (ret)
 		return log_msg_ret("env", ret);
@@ -441,7 +440,7 @@ static int distro_rauc_boot(struct udevice *dev, struct bootflow *bflow)
 		return log_msg_ret("load", ret);
 
 	log_info("INFO: Booting slot %s, %lu of %d tries left\n",
-		 active_slot, active_slot_tries, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
+		 slot->name, active_slot_tries, CONFIG_BOOTMETH_RAUC_DEFAULT_TRIES);
 
 	log_debug("devtype: %s\n", env_get("devtype"));
 	log_debug("devnum: %s\n", env_get("devnum"));

-- 
2.56.0

