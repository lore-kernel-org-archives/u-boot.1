Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DC1C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:33:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C43A787B6C;
	Thu, 26 Oct 2023 20:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="R8/cAOYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FB0487B51; Thu, 26 Oct 2023 20:31:54 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAB9A87B5E
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-773ac11de71so90340085a.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345109; x=1698949909; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6t/9xFA2pg3tAQN0ki3KsAg11bZGx0qBfZdby1hHC9M=;
 b=R8/cAOYyfY/3gcHIWq3ozphe+qlJSWsLdroTZzKuMa68RwbkF2sAG/nplerZg57BWD
 1+KuEr/Al6RCMCCRbaUiIJs/t7ywCt0CAZZOylRyks679InhizixbC4uNdIybpcGvWvF
 jUhOGneuNDLNJ2xwWtY8q54YZGJcCZkE3WNxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345109; x=1698949909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6t/9xFA2pg3tAQN0ki3KsAg11bZGx0qBfZdby1hHC9M=;
 b=f8hT8tFlgiorE4qxg8Ki7/53UP2iffpxXPPRoyf+wfYH2/oDS8Wq6e/Jr/whMErRk2
 L/c2bpZyLCrdLC3V/sFmTXZkeM3f6Nrff0nDAigs55FdqaaddL9B4VrV4UqpwNiz2use
 z0YMvU44xdybqDS15aIfsr6TY92u8zvQV1IkTV/uRrBowv4s08/eVaOaDwSZ/QdRxULE
 5EmHZYTP79/WTtO1f4DmFr7Crkcc14siAKGO3qFNl5xtpGBP/eYeQzY5oqLDekqvt6YW
 Tpae+3i0ev0i85zvk3ucelZVUtaLEuNubqJ2n/C9egm8hCqaIkKUg/Xz/TmRTUUB2j5E
 nJWQ==
X-Gm-Message-State: AOJu0YxTfle+R5PlbBK/dj3pfZXL+xZoSa+i7HC7Kl50e5687mInZ9t8
 SMqF/hRzMLJtSD3cjxVNHw+T3w3XdzZ/f55ColSgtQ==
X-Google-Smtp-Source: AGHT+IHq5CiadLWei/rGpDKuyWNcBCYzXa+2M18VLgZh35lavkj0k0+DhYt9j4stkQlSEvr4k3pULw==
X-Received: by 2002:a05:620a:472c:b0:76c:da86:3169 with SMTP id
 bs44-20020a05620a472c00b0076cda863169mr126452qkb.40.1698345109405; 
 Thu, 26 Oct 2023 11:31:49 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.48
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v5 11/30] cli_simple: Rework this support slightly
Date: Thu, 26 Oct 2023 14:31:19 -0400
Message-Id: <20231026183138.636948-11-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

