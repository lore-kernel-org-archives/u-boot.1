Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91451C44501
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 20:38:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A2B284A6B;
	Wed,  8 Jul 2026 22:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="AcGovdr7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCEA984A3E; Wed,  8 Jul 2026 22:37:38 +0200 (CEST)
Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch
 [79.135.106.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B982684A77
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 22:37:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1783543056; x=1783802256;
 bh=2/cWC5svm7vFyu5oi7vwFlOZI13eTOB5izFfImUciA0=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=AcGovdr7YyOJByZEigGAN3mZBckhCPVYi8n8Z4NN/HIlHXcYKCvF52MBu1crfCW80
 HRR4tdfPgWTmPhI3k8sNcI+iT1VdvBm1LYPO/LofzhmBEbTvAkYFePp25UWMDE7HId
 25g2B087m6KJTv+tqbPSwuX0NP6i5tqeAPMpDsYDp+SL/2GFq9NJ25gpy7XzhMoHku
 gfPm2SU6iOBI4hwsZvYMK58Y8mDs7BqmbcuCb5nlpg9DHNF4jcUM+ktSSpytLL1eVw
 A+RuR2JmUeFlkBFFathgpNQqvzUCeAD6suQ0PV0M121r8Pfc+G3sOXYfihG1x6tXza
 Qt2bjZcAywM7w==
X-Pm-Submission-Id: 4gwVJv22W9z1DFGb
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH v2 08/10] cmd: config: allow simple filtering of output
Date: Wed,  8 Jul 2026 22:37:09 +0200
Message-ID: <20260708203711.849489-9-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
References: <20260708203711.849489-1-rv@rasmusvillemoes.dk>
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

When doing development, it can be quite useful to enable
CONFIG_CMD_CONFIG, so that one can always check whether a config knob
one has just enabled has actually made it to target.

Because sometimes, one doesn't flash the right binary, or maybe one
has just done CONFIG_FOO=y in some config fragment, but that had no
effect because one would also have to do CONFIG_BAR=y.

However, 2400+ lines of text are rather hard to read through. One
probably uses a terminal emulator with capturing enabled, but
searching back through the capture file is a little tedious, and one
easily ends up finding something that doesn't pertain to the most
recent 'config' command invocation.

So make it possible to limit the output to those lines containing a
given string. Like the search functionality in menuconfig, make it
case insensitive, because it is much more convenient to type "config
pinctrl" than "config PINCTRL".

Since enabling CONFIG_CMD_CONFIG by itself adds over 10K of data, and
that increases with every U-Boot release even if one doesn't add any
new features to one's own defconfig (because the .config grows lots of
"is not set"), I don't see any point in guarding this by some
CONFIG_CMD_CONFIG_GREP.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 cmd/config.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/cmd/config.c b/cmd/config.c
index f0d2033c61f..22115e9b1da 100644
--- a/cmd/config.c
+++ b/cmd/config.c
@@ -6,6 +6,7 @@
 #include <command.h>
 #include <gzip.h>
 #include <malloc.h>
+#include <linux/string.h>
 
 #include "config_data_gz.h"
 #include "config_data_size.h"
@@ -29,7 +30,23 @@ static int do_config(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 
 	dst[data_size] = 0;
-	puts(dst);
+	if (argc > 1) {
+		const char *s = argv[1];
+		char *b = dst, *e = dst + data_size, *n;
+
+		while (b < e) {
+			n = strchrnul(b, '\n');
+			*n = '\0';
+
+			if (strcasestr(b, s)) {
+				puts(b);
+				puts("\n");
+			}
+			b = n + 1;
+		}
+	} else {
+		puts(dst);
+	}
 
 free:
 	free(dst);
@@ -38,7 +55,10 @@ free:
 }
 
 U_BOOT_CMD(
-	config, 1, 1, do_config,
+	config, 2, 1, do_config,
 	"print .config",
-	""
+	"[str]\n"
+	"\n"
+	"When the optional argument is given, only lines containing\n"
+	"that string are printed. Matching is case-insensitive."
 );
-- 
2.55.0

