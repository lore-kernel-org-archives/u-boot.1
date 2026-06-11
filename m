Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3290CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:09:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D6383FF5;
	Thu, 11 Jun 2026 16:09:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AAeiNlnw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D3F83FF5; Thu, 11 Jun 2026 16:09:04 +0200 (CEST)
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAC6F841C2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:09:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1781186940; x=1781446140;
 bh=YkP7swaClPfbOo7Su/hY2FtxZNOOldATfXdFx2aeysw=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=AAeiNlnwJm8HtNRm7q+W/SWcUaQ94HKZb2IClidvoE65s7sjJntufc2FWtB61HDbw
 q/LQcAs0sFuGPRX3IDN+V72XKQU2rE6NBHvTwDztjHyBNuAFxdUX7aYCT94wKvN59T
 nZILvUL6a8At19tssJDmURsh9iCspfaPawD7kCSMHcXZjtEtKEZgXgsnN9fK3HAfmk
 gCbdtpOOiyXD+uJGyq9zD+fIP/FxKVXreerrDirw2tKTK65F08iLMcAtS7i9waRe2P
 3JFWvJHnTCaf+EdeblIUN7z/eogWWls20wAQeDR3AqsEJrltB0gLuemlCLfwDoeH1/
 crae0gY+YqGRA==
X-Pm-Submission-Id: 4gbkyz5zGZz1DF7L
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH] Makefile: let 'make clean' remove files created by
 DEVICE_TREE_DEBUG
Date: Thu, 11 Jun 2026 16:08:57 +0200
Message-ID: <20260611140857.1522036-1-rv@rasmusvillemoes.dk>
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

Originally, 'make DEVICE_TREE_DEBUG=1' only generated extra output on
the console. But since 6cdd7597a2f ("kbuild: Produce diff between base
DT and U-Boot augmented DT if DEVICE_TREE_DEBUG=1"), that has also
left behind lots of files that clutter the repo and are hard to get
rid of manually.

Make sure that a 'make clean' will remove those files, and add them to
.gitignore.

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 .gitignore | 3 +++
 Makefile   | 1 +
 2 files changed, 4 insertions(+)

diff --git a/.gitignore b/.gitignore
index d57d3be0291..0e09715cc60 100644
--- a/.gitignore
+++ b/.gitignore
@@ -16,6 +16,9 @@
 *.dtb
 *.dtbo
 *.dtb.S
+*.dtb.clean.dts
+*.dtb.diff
+*.dtb.full.dts
 *.elf
 *.exe
 *.fit
diff --git a/Makefile b/Makefile
index 4e5c1dd6a1c..46ecced8daa 100644
--- a/Makefile
+++ b/Makefile
@@ -2611,6 +2611,7 @@ clean: $(clean-dirs)
 		\( -name '*.[aios]' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '*.ko.*' -o -name '*.su' -o -name '*.pyc' \
 		-o -name '*.dtb' -o -name '*.dtbo' -o -name '*.dtb.S' -o -name '*.dt.yaml' \
+		-o -name '*.dtb.clean.dts' -o -name '*.dtb.full.dts' -o -name '*.dtb.diff' \
 		-o -name '*.dwo' -o -name '*.lst' \
 		-o -name '*.su' -o -name '*.mod' -o -name '*.usyms' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
-- 
2.54.0

