Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1547ACD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:34:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 489BF84878;
	Fri, 15 May 2026 22:33:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CU35wTly";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 361F684878; Fri, 15 May 2026 22:33:53 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D344E8486A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso131931a34.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778877229; x=1779482029; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=07LfXONg6/MQ3wTNpVGBCPIKxhnZ2Ou0k5o4gtzyG0s=;
 b=CU35wTlyCJpiSLKfGBcbAS5/FlC+901CHu5cNkMfUSHKZPVbBMb5hib/NGM2HguHdW
 +2RF7PBv3XZkfEBylY73u33pg2CiJ792qk+FeMTlUMGX3agzSG5Z5KN/igYDktCsbcHG
 8ijVNKCSSWgenaAPaXj6MM/H2DOworiQL/658=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778877229; x=1779482029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=07LfXONg6/MQ3wTNpVGBCPIKxhnZ2Ou0k5o4gtzyG0s=;
 b=G82Rb9zs3+0q2ATqrPZFYCIklqIwASYwKTHsjosJ80Lw2fJr0C2ZWW/TfBSMpXFv6E
 nCtkp4ghLZQSAayBOQWp/Q5qOTeV0mwKJzxZkDVLgw9yazciOPLz3370zNY/7EHUefSP
 rc3OrGH1jo7oVeK8PftI1muOQnQDx4tlg/66Xu62D8/0S0Y20QXY0DMGHKEbhS/blUmj
 FH+QvONfMk3Dd+4v72OZuQTacSujA+k2QatElHOTcSZ4MwcsFK7fVVbx4fKaEVau+GJm
 m3a80mOjA9XSWv2skpPWNjBSuXeUXK1093KuTFTmCQmWx84eelDkxUs09JKlPwrBrZ8k
 BnOQ==
X-Gm-Message-State: AOJu0YxFVT+V5OTu+O3DBFLyZZ44okkuDd54qhLzQxYfOm4BBFMn5PQ0
 Lj+SJnH25JlyGbbPFztY8mYnMBrjm94dayoEkGmqIn90WjG3i0oO6LWKtVlxtpnbT9FPLNTiWIk
 /zm14AQ==
X-Gm-Gg: Acq92OGjI1TJF9TGYAbCDjOJ3WviTeH5DoYUC45SBFGQOegFz6owjhyUcM9Am7+kk4B
 mG3eM0IKuj0Njj/715QNYFPJcjYtoFlc8ypJNxRwQhwzBqpCtPIYzIMbltmcfySqwVpxzwrFegB
 WKDI6W0IqhZF9c1+JmmKFM4tQIscmTkblxgA7uo40KBmay0tMzW1zIIHYBe+4rH0jdgCyB7+2l4
 i7Otae1Mwd/ZflarvC79n33VKU/A5YSGpoutagvm5QR49CoZKIYUObnIQJhDZbmtyt47wtf2XP1
 nqokYO16hLeGLI1I4Lc2ouXEr2CI8t6KWgx0OKWLsJ1564i2EAP9JY2jJHDmNQ6LThosFdWKaQS
 dzFbD7XO2i122ra1Vvu2AZ2KgimOSrHLC5jA4xf82mWS2cNOxi7F83+On1AS3KALUITw0KPK/q7
 wznzj2IT5854qaSQ9rnQ==
X-Received: by 2002:a05:6830:2117:b0:7d7:da05:f2d2 with SMTP id
 46e09a7af769-7e4f2b3dfc9mr4072943a34.16.1778877229634; 
 Fri, 15 May 2026 13:33:49 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2414906a34.12.2026.05.15.13.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:33:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 09/11] cmd: nvedit: Use getopt() in env grep
Date: Fri, 15 May 2026 14:33:00 -0600
Message-ID: <20260515203311.2555651-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515203311.2555651-1-sjg@chromium.org>
References: <20260515203311.2555651-1-sjg@chromium.org>
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
index 636bddee1be..8561c408992 100644
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
+			&res, 0, gs.nonopts, &gs.args[gs.index]);
 
 	if (len > 0) {
 		puts(res);
-- 
2.43.0

