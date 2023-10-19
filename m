Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B278CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:02:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3CD787446;
	Thu, 19 Oct 2023 17:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aPYIqJOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E6C787448; Thu, 19 Oct 2023 17:01:28 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A56787441
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59e88a28b98so7911057b3.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727677; x=1698332477; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6t/9xFA2pg3tAQN0ki3KsAg11bZGx0qBfZdby1hHC9M=;
 b=aPYIqJOrf0YAK3PVb1gScqkLjvfjbYtD6rSJmQILe8N7qQO3hCTIdoyNPXtbEMz3ih
 1g930XSRFC2e/go68GTV2pDvY1EvSan2fWig5irBYMUvXYS//ofMIUzXCvQP0a3HuGnd
 y4wQZmSD161xjFYHRHNtx4MVfZonwwhz6Ub6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727677; x=1698332477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6t/9xFA2pg3tAQN0ki3KsAg11bZGx0qBfZdby1hHC9M=;
 b=ah9DeBQNq3OOTGPzaLHbUnc6wGndvtEjoSi0132m0O6IqNMzFq6fIXvzjP7xu827hA
 drZqi7o0Ae3HTQItQRJQxGbN0Mvx0CmsmWeNyHUUvoUf45450hKx+3C8Kqq6SjIa+q2o
 fJ8nadaorhvjAjqqbCUFJpD4Tyni4LwRPv7F62pXx4ipZ00SlZ66j7YGhKf2iiHk14Vq
 edul+2aefTt5PBl4t9LMEfnYSS1raWau4hnd+km0codKKBiMCdcA05Cn1yJC7xPEIQyQ
 Waopjkt82iP0Pirm5zLYN7asE+6+7xrh29Jrul8cgYRxqShnKHvrVKBSllbFXw4rWWQR
 OQjQ==
X-Gm-Message-State: AOJu0YxvOvZDXIxnkrYzGCnbGwGxPtGWhJg0rVITklzWGolFwW245HKd
 SEdFKZoaKtm2z947xzUAMUJn3ChxZ9znpyQY1DZeAA==
X-Google-Smtp-Source: AGHT+IGh4GKOrz1Ty51BVC3okcy1/ZwNodqGpKAybdrCNeD6s9wkNRQk/M9/ChbGPBkJDJFK+40dwg==
X-Received: by 2002:a05:690c:f8f:b0:5a8:1767:1fef with SMTP id
 df15-20020a05690c0f8f00b005a817671fefmr1578504ywb.9.1697727676760; 
 Thu, 19 Oct 2023 08:01:16 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v4 10/24] cli_simple: Rework this support slightly
Date: Thu, 19 Oct 2023 11:00:51 -0400
Message-Id: <20231019150105.714407-10-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

The interactive portion of our non-HUSH 'simple' parser is guarded by
CONFIG_CMDLINE already.  Much of the code behind this simple parser is
also used as "input" parser, such as from menu interfaces and so forth
and not strictly command line input.  To support this, always build the
assorted cli object files, but guard the interactive portions of
cli_simple.c with a CMDLINE check.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/Makefile     |  2 +-
 common/cli_simple.c | 77 +++++++++++++++++++++++----------------------
 2 files changed, 40 insertions(+), 39 deletions(-)

diff --git a/common/Makefile b/common/Makefile
index b711dc29b65e..1495436d5d45 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -8,6 +8,7 @@ ifndef CONFIG_SPL_BUILD
 obj-y += init/
 obj-y += main.o
 obj-y += exports.o
+obj-y += cli_getch.o cli_simple.o cli_readline.o
 obj-$(CONFIG_HUSH_PARSER) += cli_hush.o
 obj-$(CONFIG_AUTOBOOT) += autoboot.o
 obj-y += version.o
@@ -38,7 +39,6 @@ obj-$(CONFIG_SPLASH_SOURCE) += splash_source.o
 obj-$(CONFIG_MENU) += menu.o
 obj-$(CONFIG_UPDATE_COMMON) += update.o
 obj-$(CONFIG_USB_KEYBOARD) += usb_kbd.o
-obj-$(CONFIG_CMDLINE) += cli_getch.o cli_readline.o cli_simple.o
 
 endif # !CONFIG_SPL_BUILD
 
diff --git a/common/cli_simple.c b/common/cli_simple.c
index e80ba488a5eb..f89ba92d1b05 100644
--- a/common/cli_simple.c
+++ b/common/cli_simple.c
@@ -22,44 +22,6 @@
 #define debug_parser(fmt, args...)		\
 	debug_cond(DEBUG_PARSER, fmt, ##args)
 
-
-int cli_simple_parse_line(char *line, char *argv[])
-{
-	int nargs = 0;
-
-	debug_parser("%s: \"%s\"\n", __func__, line);
-	while (nargs < CONFIG_SYS_MAXARGS) {
-		/* skip any white space */
-		while (isblank(*line))
-			++line;
-
-		if (*line == '\0') {	/* end of line, no more args	*/
-			argv[nargs] = NULL;
-			debug_parser("%s: nargs=%d\n", __func__, nargs);
-			return nargs;
-		}
-
-		argv[nargs++] = line;	/* begin of argument string	*/
-
-		/* find end of string */
-		while (*line && !isblank(*line))
-			++line;
-
-		if (*line == '\0') {	/* end of line, no more args	*/
-			argv[nargs] = NULL;
-			debug_parser("parse_line: nargs=%d\n", nargs);
-			return nargs;
-		}
-
-		*line++ = '\0';		/* terminate current arg	 */
-	}
-
-	printf("** Too many args (max. %d) **\n", CONFIG_SYS_MAXARGS);
-
-	debug_parser("%s: nargs=%d\n", __func__, nargs);
-	return nargs;
-}
-
 int cli_simple_process_macros(const char *input, char *output, int max_size)
 {
 	char c, prev;
@@ -172,6 +134,44 @@ int cli_simple_process_macros(const char *input, char *output, int max_size)
 	return ret;
 }
 
+#ifdef CONFIG_CMDLINE
+int cli_simple_parse_line(char *line, char *argv[])
+{
+	int nargs = 0;
+
+	debug_parser("%s: \"%s\"\n", __func__, line);
+	while (nargs < CONFIG_SYS_MAXARGS) {
+		/* skip any white space */
+		while (isblank(*line))
+			++line;
+
+		if (*line == '\0') {	/* end of line, no more args	*/
+			argv[nargs] = NULL;
+			debug_parser("%s: nargs=%d\n", __func__, nargs);
+			return nargs;
+		}
+
+		argv[nargs++] = line;	/* begin of argument string	*/
+
+		/* find end of string */
+		while (*line && !isblank(*line))
+			++line;
+
+		if (*line == '\0') {	/* end of line, no more args	*/
+			argv[nargs] = NULL;
+			debug_parser("parse_line: nargs=%d\n", nargs);
+			return nargs;
+		}
+
+		*line++ = '\0';		/* terminate current arg	 */
+	}
+
+	printf("** Too many args (max. %d) **\n", CONFIG_SYS_MAXARGS);
+
+	debug_parser("%s: nargs=%d\n", __func__, nargs);
+	return nargs;
+}
+
  /*
  * WARNING:
  *
@@ -346,3 +346,4 @@ int cli_simple_run_command_list(char *cmd, int flag)
 
 	return rcode;
 }
+#endif
-- 
2.34.1

