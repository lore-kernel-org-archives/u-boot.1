Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AB9C47072
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:05:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FA3487719;
	Fri, 22 Dec 2023 22:03:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="dsSPVyPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEFFF87768; Fri, 22 Dec 2023 22:03:39 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80C4187860
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3368b1e056eso1641942f8f.3
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279012; x=1703883812;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7TqOeFal1YGx9sWXEybwX7TlPhNIMd4dhVyF2qBxKI=;
 b=dsSPVyPmadElD4/OJrB3Gmu8ah+IJu/ZyXSBHoyzaYEQeP1jQWnkP1xrWI5EjIq44t
 IqULBrusibIfLdL15zG73dlWMSgGRRJx2ma4Ag3DOwKkrbRgqXIOHs3Va1sILQSno17n
 NMjdqhMqXgz4nAT8NLOaWIxfZVD8hFKtdUijk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279012; x=1703883812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T7TqOeFal1YGx9sWXEybwX7TlPhNIMd4dhVyF2qBxKI=;
 b=J9M2sr+f54vnsmY3vo9apcAJOMBZMst3Pbv+mb3UrpD6nmdjXzojzNPnJdGzF8vhBG
 lL+S090es6wV4RRGNzWLhaqPSfMEp9ZnaSTtqAndnOMLwLVBPQrpbdKCAB+iULOTLAP7
 0g7h7KGDl45Lm4ezdZGRcnqqfgEf1K3QlRT+ckpAT0KJBoH21cTSMor2XTpggxqKIvwS
 iMh/l9vRkNefPedguCGntYU7yg2R9dwLScgPj0WKPtJJ6HGFbWJbmrrj/2RUeQTrVoxc
 rR8LCXchgZYKhkCtGX2nLZ0kJ2DukD+eeT42zZkHcuu1xU/1p0YCB6MdFyqIbtcgj0qv
 tZvA==
X-Gm-Message-State: AOJu0YyMfn+fx1/PK/rc64gSr3FUn/IdOeQ5+YP3FYoZwMKJtTNHFF59
 osN7nWCBI8+bLIy1N3yP7+rbYVUsVpro+ECXlVl/s3BMrss=
X-Google-Smtp-Source: AGHT+IH/+WpqnkR9XhNhJix5vxwmrcnddI/4m8QgDrW1AwV3sukzGUF9FOlX1dDDJnawSK3YZEBL6Q==
X-Received: by 2002:a05:600c:3201:b0:40d:4085:a146 with SMTP id
 r1-20020a05600c320100b0040d4085a146mr1202082wmp.77.1703279012045; 
 Fri, 22 Dec 2023 13:03:32 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:31 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>, Marek Vasut <marex@denx.de>,
 Hector Palacios <hector.palacios@digi.com>
Subject: [PATCH v13 15/24] cli: add modern hush as parser for run_command*()
Date: Fri, 22 Dec 2023 22:02:35 +0100
Message-Id: <20231222210244.91830-16-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
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

Enables using, in code, modern hush as parser for run_command function family.
It also enables the command run to be used by CLI user of modern hush.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 common/cli.c               | 67 ++++++++++++++++++++++++++++----------
 common/cli_hush_upstream.c |  2 +-
 test/boot/bootflow.c       | 16 ++++++++-
 3 files changed, 66 insertions(+), 19 deletions(-)

diff --git a/common/cli.c b/common/cli.c
index b3eb512b62..a34938294e 100644
--- a/common/cli.c
+++ b/common/cli.c
@@ -25,6 +25,14 @@
 #include <linux/errno.h>
 
 #ifdef CONFIG_CMDLINE
+
+static inline bool use_hush_old(void)
+{
+	return IS_ENABLED(CONFIG_HUSH_SELECTABLE) ?
+	gd->flags & GD_FLG_HUSH_OLD_PARSER :
+	IS_ENABLED(CONFIG_HUSH_OLD_PARSER);
+}
+
 /*
  * Run a command using the selected parser.
  *
@@ -43,15 +51,30 @@ int run_command(const char *cmd, int flag)
 		return 1;
 
 	return 0;
-#elif CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
-	int hush_flags = FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP;
-
-	if (flag & CMD_FLAG_ENV)
-		hush_flags |= FLAG_CONT_ON_NEWLINE;
-	return parse_string_outer(cmd, hush_flags);
-#else /* HUSH_MODERN_PARSER */
-	/* Not yet implemented. */
-	return 1;
+#else
+	if (use_hush_old()) {
+		int hush_flags = FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP;
+
+		if (flag & CMD_FLAG_ENV)
+			hush_flags |= FLAG_CONT_ON_NEWLINE;
+		return parse_string_outer(cmd, hush_flags);
+	}
+	/*
+	 * Possible values for flags are the following:
+	 * FLAG_EXIT_FROM_LOOP: This flags ensures we exit from loop in
+	 * parse_and_run_stream() after first iteration while normal
+	 * behavior, * i.e. when called from cli_loop(), is to loop
+	 * infinitely.
+	 * FLAG_PARSE_SEMICOLON: modern Hush parses ';' and does not stop
+	 * first time it sees one. So, I think we do not need this flag.
+	 * FLAG_REPARSING: For the moment, I do not understand the goal
+	 * of this flag.
+	 * FLAG_CONT_ON_NEWLINE: This flag seems to be used to continue
+	 * parsing even when reading '\n' when coming from
+	 * run_command(). In this case, modern Hush reads until it finds
+	 * '\0'. So, I think we do not need this flag.
+	 */
+	return parse_string_outer_modern(cmd, FLAG_EXIT_FROM_LOOP);
 #endif
 }
 
@@ -67,12 +90,23 @@ int run_command_repeatable(const char *cmd, int flag)
 #ifndef CONFIG_HUSH_PARSER
 	return cli_simple_run_command(cmd, flag);
 #else
+	int ret;
+
+	if (use_hush_old()) {
+		ret = parse_string_outer(cmd,
+					 FLAG_PARSE_SEMICOLON
+					 | FLAG_EXIT_FROM_LOOP);
+	} else {
+		ret = parse_string_outer_modern(cmd,
+					      FLAG_PARSE_SEMICOLON
+					      | FLAG_EXIT_FROM_LOOP);
+	}
+
 	/*
 	 * parse_string_outer() returns 1 for failure, so clean up
 	 * its result.
 	 */
-	if (parse_string_outer(cmd,
-			       FLAG_PARSE_SEMICOLON | FLAG_EXIT_FROM_LOOP))
+	if (ret)
 		return -1;
 
 	return 0;
@@ -111,12 +145,11 @@ int run_command_list(const char *cmd, int len, int flag)
 		buff[len] = '\0';
 	}
 #ifdef CONFIG_HUSH_PARSER
-#if CONFIG_IS_ENABLED(HUSH_OLD_PARSER)
-	rcode = parse_string_outer(buff, FLAG_PARSE_SEMICOLON);
-#else /* HUSH_MODERN_PARSER */
-	/* Not yet implemented. */
-	rcode = 1;
-#endif
+	if (use_hush_old()) {
+		rcode = parse_string_outer(buff, FLAG_PARSE_SEMICOLON);
+	} else {
+		rcode = parse_string_outer_modern(buff, FLAG_PARSE_SEMICOLON);
+	}
 #else
 	/*
 	 * This function will overwrite any \n it sees with a \0, which
diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 7f6b058e6c..11870c51e8 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -8022,7 +8022,7 @@ static int parse_and_run_string(const char *s)
 }
 
 #ifdef __U_BOOT__
-int parse_string_outer(const char *cmd, int flags)
+int parse_string_outer_modern(const char *cmd, int flags)
 {
 	int ret;
 	int old_flags;
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index a9b555c779..104f49deef 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -710,7 +710,21 @@ static int bootflow_scan_menu_boot(struct unit_test_state *uts)
 	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
 
 	ut_assert_nextline("Selected: Armbian");
-	ut_assert_skip_to_line("Boot failed (err=-14)");
+
+	if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
+		/*
+		 * With old hush, despite booti failing to boot, i.e. returning
+		 * CMD_RET_FAILURE, run_command() returns 0 which leads bootflow_boot(), as
+		 * we are using bootmeth_script here, to return -EFAULT.
+		 */
+		ut_assert_skip_to_line("Boot failed (err=-14)");
+	} else if (gd->flags & GD_FLG_HUSH_MODERN_PARSER) {
+		/*
+		 * While with modern one, run_command() propagates CMD_RET_FAILURE returned
+		 * by booti, so we get 1 here.
+		 */
+		ut_assert_skip_to_line("Boot failed (err=1)");
+	}
 	ut_assertnonnull(std->cur_bootflow);
 	ut_assert_console_end();
 
-- 
2.34.1

