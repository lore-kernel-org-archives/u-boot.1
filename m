Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5F3E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:19:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7B8187100;
	Mon,  2 Oct 2023 03:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eZfsIQ+e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F80870EA; Mon,  2 Oct 2023 03:14:00 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40B328709C
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:13:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-3ae5ee80c0dso4487109b6e.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209234; x=1696814034; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v0w+6qq8nGPiSZ61SwLEiqEkdG1esVt3wAEafXcxkIY=;
 b=eZfsIQ+efpQOyT9kSfKHVHNQeT8xrF/GodBw1uEqx37xp7D/Z/mrXg+x7LeqdnmwjV
 aw6GirqkDAZDAhUg0l8qRp4cswto3vTYhjZUlMJSY1hRfDU7w7og8eWxSDUY0Ln6oq0m
 suW9H9L2sf8+eoN2eu55MbfcZkZyiKGZg1O2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209234; x=1696814034;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v0w+6qq8nGPiSZ61SwLEiqEkdG1esVt3wAEafXcxkIY=;
 b=oQyQw+etjrHw2SEx+ZGD1JTNLS6vXY3lljRweAwswhSe5SGd0SGUBRvxKCJs0D/I5F
 c6Ss4cmATGEcCV7yZcI1w9pvBJqwT2Rr5bVmRX03NxHm8RDXju1NRMYvrxMPfhArwc8g
 44T/LIY351nPfLbnRUtd1BQUCjsEJZyK3Q3hJAv/fqvEQZckahSwvC50ER/cDoM5Z/lZ
 VwCfft9kJ51zs8s1n6WK1qMC17GnfTqlNlWu8mr+8SQCEDKHpCtmdH2n1Ia8asNtlaG2
 IctGNbzCOJHDlARC0BLxJMzBdnDyJME2OxJtzp59rLvBPggBbYWsGgl9oR3cEB8ur29l
 Vg5w==
X-Gm-Message-State: AOJu0YxQoUuIraYQh9532UaNPqBepT3e4Cc2vYHH1/RaPhLVUGQOdzo2
 hrdaaGboNtMR34rbI7DBlleBdzme4aANDqrkyY8=
X-Google-Smtp-Source: AGHT+IHLy92YibtY1NJ77+yay9+GWLkXJijDOQoqyy0vBXx+fOYNTjhhgWRmaSkygo4i+O9aa6TWVg==
X-Received: by 2002:a05:6808:1413:b0:3ae:13fd:fa93 with SMTP id
 w19-20020a056808141300b003ae13fdfa93mr13267895oiv.15.1696209234643; 
 Sun, 01 Oct 2023 18:13:54 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:13:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 01/36] cli: Move simple readline into a function
Date: Sun,  1 Oct 2023 19:13:05 -0600
Message-ID: <20231002011349.461284-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

Move this code into its own function since it is a separate
implementation from the full version.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/cli_readline.c | 79 +++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index e83743e90c92..9a7c268719da 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -440,41 +440,22 @@ int cli_readline(const char *const prompt)
 	return cli_readline_into_buffer(prompt, console_buffer, 0);
 }
 
-
-int cli_readline_into_buffer(const char *const prompt, char *buffer,
-			     int timeout)
+/**
+ * cread_line_simple() - Simple (small) command-line reader
+ *
+ * This supports only basic editing, with no cursor movement
+ *
+ * @prompt: Prompt to display
+ * @p: Text buffer to edit
+ * Return: length of text buffer, or -1 if input was cannncelled (Ctrl-C)
+ */
+static int cread_line_simple(const char *const prompt, char *p)
 {
-	char *p = buffer;
-#ifdef CONFIG_CMDLINE_EDITING
-	unsigned int len = CONFIG_SYS_CBSIZE;
-	int rc;
-	static int initted;
-
-	/*
-	 * History uses a global array which is not
-	 * writable until after relocation to RAM.
-	 * Revert to non-history version if still
-	 * running from flash.
-	 */
-	if (gd->flags & GD_FLG_RELOC) {
-		if (!initted) {
-			hist_init();
-			initted = 1;
-		}
-
-		if (prompt)
-			puts(prompt);
-
-		rc = cread_line(prompt, p, &len, timeout);
-		return rc < 0 ? rc : len;
-
-	} else {
-#endif	/* CONFIG_CMDLINE_EDITING */
 	char *p_buf = p;
-	int	n = 0;				/* buffer index		*/
-	int	plen = 0;			/* prompt length	*/
-	int	col;				/* output column cnt	*/
-	char	c;
+	int n = 0;		/* buffer index */
+	int plen = 0;		/* prompt length */
+	int col;		/* output column cnt */
+	char c;
 
 	/* print prompt */
 	if (prompt) {
@@ -567,6 +548,38 @@ int cli_readline_into_buffer(const char *const prompt, char *buffer,
 			}
 		}
 	}
+}
+
+int cli_readline_into_buffer(const char *const prompt, char *buffer,
+			     int timeout)
+{
+	char *p = buffer;
+#ifdef CONFIG_CMDLINE_EDITING
+	unsigned int len = CONFIG_SYS_CBSIZE;
+	int rc;
+	static int initted;
+
+	/*
+	 * History uses a global array which is not
+	 * writable until after relocation to RAM.
+	 * Revert to non-history version if still
+	 * running from flash.
+	 */
+	if (gd->flags & GD_FLG_RELOC) {
+		if (!initted) {
+			hist_init();
+			initted = 1;
+		}
+
+		if (prompt)
+			puts(prompt);
+
+		rc = cread_line(prompt, p, &len, timeout);
+		return rc < 0 ? rc : len;
+
+	} else {
+#endif	/* CONFIG_CMDLINE_EDITING */
+		return cread_line_simple(prompt, p);
 #ifdef CONFIG_CMDLINE_EDITING
 	}
 #endif
-- 
2.42.0.582.g8ccd20d70d-goog

