Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B408CD5BAD
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:34:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50D2F848DF;
	Wed, 20 May 2026 01:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ax4hskfe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9148848DF; Wed, 20 May 2026 01:32:56 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86EF28488F
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-47c6f914617so1999670b6e.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233572; x=1779838372; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ueAYWbEvVH1KjbE7X/x9WdhHDES8dlfjcGT0RrmlHQ=;
 b=ax4hskfe11KIE+O/jkc51yxNpMoAb1zMpBg6/uQSmtBlsFqzg8FU8udoffdeaSitG/
 NGnQ0GSEef32hx6x4+K86Cdxt9hvpj3aZIfLHR1ilMBt11BdsK3cvaBPKfQhgLybVhpn
 hcahxH6f3Gs3iPDPIJRGWnMNh9ieD01sXo0Xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233572; x=1779838372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ueAYWbEvVH1KjbE7X/x9WdhHDES8dlfjcGT0RrmlHQ=;
 b=T4KjjrETX8dD7//2OE9dq5Zv5yi2iLfrTOzPooJPF6eL1Vfg+qkD4k8duoQvAAgW/g
 P9n3BAAWizA+sk0VPCGJnZkjsuGmvD3Hd7RUr9fqvJ5m+QxPJMuGC0kquNvltFml+Ug/
 avw71sb1cZGZ0bdXB1FLHJZV6pJV8RFtMYjA2uQecmU4cr03iw19LM0Fnuk59MhEBhlw
 +SJ9/Gc+4klXwM2fJoS4pJ13mcqnw3xjWqWxhNgNY7D+HnKOV4yY9/2btKQs3lAZhv65
 VvAwUDetl1s7MFInCrRYkDCDPHM4Pa+i39mnk3h5OMpMconga7FR1gT52qXIOyckzV81
 6a6A==
X-Gm-Message-State: AOJu0YxdWl/phdwjW47u2OQnCkzW367jiElB+r9ax+ZtD71/yguWy3up
 /JrUUJjWPvawTYJffuRSZf+z6QZ7he+SdADq9L4xf1bRGXm6ZG0sSTrpbD4LXS+x8dDFBv7zH/z
 49xd3vgy/
X-Gm-Gg: Acq92OGJo9CLxbqk5PNOoUVxkcoJOEugfSzbiQhFyaNrpSU3QHaVzTEgPAjo23c+B8j
 3CilF3zetgS8W5jlcsAx0AmyCRTzwu9x5EWQFVe3XZAX+jsnmGTuEL5nXcj6yP6KRZbK79n/nbx
 zMvXJM58gwGvruhpyqEuFbE4rXHAKF3N6M4ifkoTfZfPXjajufEmOgD1FgEzCV+aFaXh3zFFwXC
 JoVeCFV7C+V5CA89GhY80SjS/rcaMMp66fpSGOiHfAL7SBjK+TCfUUmADbQgT4gvILdW/Nr5G9y
 FdDQ/aWu4ACYIQnwLkbdV176nilU9SK1/fCnf3nti7gNnwpO+2aWtAP7MBH7GU5fGE1dV2SwcpR
 cCd8iKSHFlPNIfJkG3iX+xgolRcTkLwACuK58tYXlN52rawaG0IXDIgLdQs36UZq/96pMzNDTzQ
 U4VqXtzUCBETGJaU40HGv9TZJeCRRaG5VcM4OUIfQ=
X-Received: by 2002:a4a:e909:0:b0:696:77e2:a83 with SMTP id
 006d021491bc7-69c9bfd297cmr13828824eaf.53.1779233572521; 
 Tue, 19 May 2026 16:32:52 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [RFC PATCH v2 09/17] cmd: nvedit: Use getopt() in env grep
Date: Tue, 19 May 2026 17:31:35 -0600
Message-ID: <20260519233207.2765755-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
References: <20260519233207.2765755-1-sjg@chromium.org>
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

The nested while/switch parser walks each -prefixed argv element by
hand. The -- end-of-options marker is implemented by a case '-' arm
that does 'goto DONE' to jump out of both the inner switch and the
outer argv walker, leaving the remaining argv to be treated as
positionals by hexport_r().

getopt() handles all of that natively: grouped flags (-nb), the '--'
boundary (it returns -1 and advances past --), unknown-option errors
and option permutation so 'env grep arch -n' works the same as
'env grep -n arch'. The goto, the label, and the case '-' arm all
disappear.

Pass "envb" or "nvb" to getopt() depending on IS_ENABLED(CONFIG_REGEX)
so -e is not advertised when regex is compiled out, and guard the
case 'e' arm with the same check so it costs nothing in the regex-off
build.

Move the missing-argument check to after parsing. The existing argc < 2
check fires only when no args at all are given; the new gs.nonopts < 1
check also catches 'env grep -n' (options but no search pattern), where
the previous version would silently let hexport_r() run with an empty
pattern list.

CMD_GREPENV selects GETOPT so the parser is linked in on boards that did
not already enable it.

Tweak the var declarations to use Reverse Christmas Tree.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 cmd/Kconfig  |  1 +
 cmd/nvedit.c | 56 +++++++++++++++++++++++++---------------------------
 2 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index eb7c85c1fe9..8ba7b1e6bd1 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -721,6 +721,7 @@ config CMD_EDITENV
 
 config CMD_GREPENV
 	bool "search env"
+	select GETOPT
 	help
 	  Allow for searching environment variables
 
diff --git a/cmd/nvedit.c b/cmd/nvedit.c
index 636bddee1be..35cc0ee85bf 100644
--- a/cmd/nvedit.c
+++ b/cmd/nvedit.c
@@ -29,6 +29,7 @@
 #include <console.h>
 #include <env.h>
 #include <env_internal.h>
+#include <getopt.h>
 #include <log.h>
 #include <search.h>
 #include <errno.h>
@@ -131,45 +132,42 @@ static int do_env_print(struct cmd_tbl *cmdtp, int flag, int argc,
 static int do_env_grep(struct cmd_tbl *cmdtp, int flag,
 		       int argc, char *const argv[])
 {
-	char *res = NULL;
 	int len, grep_how, grep_what;
-
-	if (argc < 2)
-		return CMD_RET_USAGE;
+	struct getopt_state gs;
+	char *res = NULL;
+	int opt;
 
 	grep_how  = H_MATCH_SUBSTR;	/* default: substring search	*/
 	grep_what = H_MATCH_BOTH;	/* default: grep names and values */
 
-	while (--argc > 0 && **++argv == '-') {
-		char *arg = *argv;
-		while (*++arg) {
-			switch (*arg) {
-#ifdef CONFIG_REGEX
-			case 'e':		/* use regex matching */
-				grep_how  = H_MATCH_REGEX;
-				break;
-#endif
-			case 'n':		/* grep for name */
-				grep_what = H_MATCH_KEY;
-				break;
-			case 'v':		/* grep for value */
-				grep_what = H_MATCH_DATA;
-				break;
-			case 'b':		/* grep for both */
-				grep_what = H_MATCH_BOTH;
-				break;
-			case '-':
-				goto DONE;
-			default:
-				return CMD_RET_USAGE;
-			}
+	getopt_init_state(&gs, argc, argv);
+	while ((opt = getopt(&gs, IS_ENABLED(CONFIG_REGEX) ? "envb"
+							   : "nvb")) > 0) {
+		switch (opt) {
+		case 'e':		/* use regex matching */
+			if (IS_ENABLED(CONFIG_REGEX))
+				grep_how = H_MATCH_REGEX;
+			break;
+		case 'n':		/* grep for name */
+			grep_what = H_MATCH_KEY;
+			break;
+		case 'v':		/* grep for value */
+			grep_what = H_MATCH_DATA;
+			break;
+		case 'b':		/* grep for both */
+			grep_what = H_MATCH_BOTH;
+			break;
+		default:
+			return CMD_RET_USAGE;
 		}
 	}
 
-DONE:
+	if (gs.nonopts < 1)
+		return CMD_RET_USAGE;
+
 	len = hexport_r(&env_htab, '\n',
 			flag | grep_what | grep_how,
-			&res, 0, argc, argv);
+			&res, 0, gs.nonopts, &gs.argv[gs.index]);
 
 	if (len > 0) {
 		puts(res);
-- 
2.43.0

