Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98319EE14D0
	for <u-boot@archiver.kernel.org>; Wed,  6 Sep 2023 21:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE72E869BB;
	Wed,  6 Sep 2023 23:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="az5Kz/R1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="YH8N6hZP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D2D48685B; Wed,  6 Sep 2023 23:30:46 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F95D86998
 for <u-boot@lists.denx.de>; Wed,  6 Sep 2023 23:30:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RgwXM2BDNz9sn0;
 Wed,  6 Sep 2023 23:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTb+NU404zs7rmOl2f3KMY7wAyItikJeRA+q9/XkPTo=;
 b=az5Kz/R1cAvHjK5ICz1MAmKpdY2ulzBxIP66U6xSX8tFU58Q4ftOMsS2KGY+yHRf4R8v/V
 2QJimYQLJpijJ8jxHy5MgTgQCnxbeez1a2vI22H0pwuqmrfJedvZ8Tb/J1OB/EAXfXLaB7
 Nc0Xs523+cMQLpW8eerS4E38fq2Oria9V4mWfW3IhDyfJrN0FCobmo6iFbBqvMkHnkZWea
 TTWoqPrkdl7IGx5pjE8XEgg33DY4C4JjsMz16F4CG2VxxzGR26sZczqNg8I9OFGsEwpUiS
 CccmR8p8LIEBNgLo1Dv2O9nOMhEzGYkKLWlguumgS40nNKvqZuYAee0Xhq/DmQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1694035840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTb+NU404zs7rmOl2f3KMY7wAyItikJeRA+q9/XkPTo=;
 b=YH8N6hZPtHPK/8lbNSK0KZfA1RRisEc1AsG+eObkwdQTsn8exBCrXh9ELjp1IAAqKrE1ry
 SdRUR57dBLmwdEFMoYOsXWgcAWy1xxpbrdKkHwDjJeLEYALDcWTg9m0h1KuNWV6472x4oa
 OUFNmIsMR8n8+8+rWA2JsRAqxcqamrmwzVi/G+UdlVU9IuFd4MLwxO7HBlPCrvTOISmCQ9
 Zwax8b6tzaO6/7b1Z912yI/13KhLay6aer5eqKI7UjVrjANcBMG/y3oKUA7yV38DQgd0zh
 bv3+yjGE31FnkgXL0c4XhvpSPGvkqC7owmHONIaOGogbXZKfobR6f8y/ABtx5A==
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 05/35] common: hush: Remove unused NEEDS_MANUAL_RELOC code bits
Date: Wed,  6 Sep 2023 23:29:45 +0200
Message-Id: <20230906213015.203437-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
References: <20230906213015.203437-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: crs4xt84jyr17peziuwucp6tkf5myiiw
X-MBO-RS-ID: 5c3086f80231253712d
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
 common/cli_hush.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/common/cli_hush.c b/common/cli_hush.c
index cee87249bc2..9cda97f30e3 100644
--- a/common/cli_hush.c
+++ b/common/cli_hush.c
@@ -3305,19 +3305,6 @@ int parse_file_outer(void)
 }
 
 #ifdef __U_BOOT__
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-static void u_boot_hush_reloc(void)
-{
-	unsigned long addr;
-	struct reserved_combo *r;
-
-	for (r=reserved_list; r<reserved_list+NRES; r++) {
-		addr = (ulong) (r->literal) + gd->reloc_off;
-		r->literal = (char *)addr;
-	}
-}
-#endif
-
 int u_boot_hush_start(void)
 {
 	if (top_vars == NULL) {
@@ -3327,9 +3314,6 @@ int u_boot_hush_start(void)
 		top_vars->next = NULL;
 		top_vars->flg_export = 0;
 		top_vars->flg_read_only = 1;
-#ifdef CONFIG_NEEDS_MANUAL_RELOC
-		u_boot_hush_reloc();
-#endif
 	}
 	return 0;
 }
-- 
2.40.1

