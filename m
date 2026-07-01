Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1F7C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500BC84C15;
	Wed,  1 Jul 2026 19:16:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BBvdnGgR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3BF984BC8; Wed,  1 Jul 2026 19:16:02 +0200 (CEST)
Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch
 [109.224.244.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A494084C39
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:15:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rv@rasmusvillemoes.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rasmusvillemoes.dk;
 s=protonmail; t=1782926158; x=1783185358;
 bh=/7wnba7YKo773+mhnQlo3owmVbrikTaNQraEZPRUGFY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=BBvdnGgRSkLk1lUqkDdtBqo9+oShjU1ghwlwfr7Lj/eWratB8t7fpRveIb4U0cLUo
 U1mwPMXjmYq2oaqYpi/vkyltzmFlFt+NpIrNi18023tybz3OKh6TvyhWsDy8oVCkgc
 S8mxmSEmDUYfrN/g1t5SSiIFQgWn5Axq/lvJVE/rGmZqa2EPrtmm7PLt2fknnQlMed
 UnWndstQkfNHWqtzrp8Kvl3QLSwpqPaOGcgkPlLstWVplVdBhjHNuuthYMi5NamHYL
 SnE3mmaARSuCpCSHDMwa5uoOmVKF2s/+uZpw/iABp12/ps5443abVwm7WaQCgUjaLc
 XriKk9AUwc2NA==
X-Pm-Submission-Id: 4gr69T0V1Cz1DFT8
From: Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Casey Connolly <casey.connolly@linaro.org>,
 Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH 8/8] cmd: config: allow simple filtering of output
Date: Wed,  1 Jul 2026 19:15:35 +0200
Message-ID: <20260701171535.906272-9-rv@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
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

Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
---
 cmd/config.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/cmd/config.c b/cmd/config.c
index f0d2033c61f..3a6da55b0ef 100644
--- a/cmd/config.c
+++ b/cmd/config.c
@@ -29,7 +29,23 @@ static int do_config(struct cmd_tbl *cmdtp, int flag, int argc,
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
@@ -38,7 +54,10 @@ free:
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
2.54.0

