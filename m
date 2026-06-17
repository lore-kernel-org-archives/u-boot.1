Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDF8CD98E2
	for <u-boot@archiver.kernel.org>; Wed, 17 Jun 2026 13:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBBC0846B0;
	Wed, 17 Jun 2026 15:12:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="POkDA4VJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBCE384833; Wed, 17 Jun 2026 15:12:12 +0200 (CEST)
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5BC88460E
 for <u-boot@lists.denx.de>; Wed, 17 Jun 2026 15:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1781701929; x=1781961129;
 bh=/k6hUTtlSBABiPNDdPYOl76BfXhwSzU/2INY9iEEPrg=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=POkDA4VJ6H9rTe7lZAbwY717rqEI+kaMvegS0MVmYO09BQENvZjDHTLwK58UO/pkb
 XZpeyevNwAut5o4n7JHCQHHI+b5PxUdFdFMy0FcI9d8pLyj/mcLykaM6SjMg6rs4uE
 FJYiu28icddEpLAOoeOIjqOTD1GLlEels+5C78MIPGaXvBZX0iwYqWQMgGY73akb0W
 rD+aoMSSDKDCI2Xqg5u0+EJ/joc4dr25QjdHcwuZRbvJvOp92IxPgFP++ZRk5z0GzN
 ajEwYPWKqli2C9AhlX6Lx3VOge8ZTW8LNU+I1uMbD7ddxWJ6ymlLiQGwQPw3vCF2a8
 UhXpYXp9zInYw==
X-Pm-Submission-Id: 4ggPQc6b98z1DDnc
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH] Makefile.lib: remove stale migrate_xxx logic from fdtgrep
 logic
Date: Wed, 17 Jun 2026 15:12:04 +0200
Message-ID: <20260617131204.3737198-1-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Commit 6d04828b452 ("dm: Remove pre-schema tag support") removed the
definitions of these migrate_xxx variables, but left behind their use
in the fdtgrep rule, which now makes that somewhat hard to understand.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 scripts/Makefile.lib | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index d66f1ed13b1..122c8e78204 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -674,12 +674,12 @@ cmd_mkimage = $(objtree)/tools/mkimage $(MKIMAGEFLAGS_$(@F)) -d $< $@ \
 # The output is typically a much smaller device tree file.
 
 ifeq ($(CONFIG_VPL_BUILD),y)
-fdtgrep_props := -b bootph-all -b bootph-verify $(migrate_vpl)
+fdtgrep_props := -b bootph-all -b bootph-verify
 else
 ifeq ($(CONFIG_TPL_BUILD),y)
-fdtgrep_props := -b bootph-all -b bootph-pre-sram $(migrate_tpl)
+fdtgrep_props := -b bootph-all -b bootph-pre-sram
 else
-fdtgrep_props := -b bootph-all -b bootph-pre-ram $(migrate_spl)
+fdtgrep_props := -b bootph-all -b bootph-pre-ram
 endif
 endif
 
@@ -699,7 +699,6 @@ quiet_cmd_fdtgrep = FDTGREP $@
 	$(objtree)/tools/fdtgrep -r -O dtb - -o $@ \
 		-P bootph-all -P bootph-pre-ram -P bootph-pre-sram \
 		-P bootph-verify -P bootph-some-ram \
-		$(migrate_all) \
 		$(addprefix -P ,$(subst $\",,$(CONFIG_OF_SPL_REMOVE_PROPS)))
 
 # fdt_rm_props
-- 
2.54.0

