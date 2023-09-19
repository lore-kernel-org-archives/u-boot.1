Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA78DCE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:09:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55AFC86BA6;
	Tue, 19 Sep 2023 20:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hQFXgZ0V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D98C86BB0; Tue, 19 Sep 2023 20:09:31 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C2E686AB9
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79536bc669dso208889039f.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146968; x=1695751768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YcHzAcTsCh3LXaqSCfKDydvjsbQiHo8CEfn96XW2eg4=;
 b=hQFXgZ0VQmCCcnimHVTfYOkP2r/eqKZAwG5pqUJXfjfUuA9NTuD/nsxbrFgBl9SbW4
 E0gOptP+2xicZvVpI2g6jW0+ZTc/bFCi6oCeV8j1WYni8k0OmcVBFzy0193DzWpC5M5Y
 3uJ1maXL3aXZokk+ZdnIs6hWn4ZJJZjkIaDKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146968; x=1695751768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YcHzAcTsCh3LXaqSCfKDydvjsbQiHo8CEfn96XW2eg4=;
 b=AsgSstd4991y4sRHnhVqLJaulEDqFKYX0+o/F6qtA6m373AL2CCP+cWH4Bax9ySCDG
 YEfOKb+bWKqX3XTPMePDCT92akt7R8EYpov9Zk1q4H9xJMoO3L6vpFkmbFIUP5kpiGpZ
 MPG+9nDKflvEks1txUf2WVZnllFxTsX5fF4F2wzbk3hW069kctkFhN+nxizFNPkn6MdJ
 Sh7bBZYP6qEnUkBw1WCZC/472bpqn+QiPfYXu5V6RlhL737avqgIBNb1lqU3TsbcZQRz
 xdyMrIkJDz3jAOTXhBeNdChGovuelNVhohiojyv/anAtjVazmX/vko55szVioj6nHfwT
 d/XA==
X-Gm-Message-State: AOJu0YxMhviVxO0xOVJ+AFJbeVyGlGfRpnDOyjdvTbedezOdhJBX81Ks
 N0cMkLM08myAFwA4OHHEBeiMygoQAtYt2FosLWg=
X-Google-Smtp-Source: AGHT+IGtnJ/7I1Rv8q4C2QLbJcqXo6xMZvFdZ20sLlLRVoHTFfw9eJv6bhQ2TN25bsaEd+DmO7xZcA==
X-Received: by 2002:a05:6e02:2195:b0:34d:ed6f:f841 with SMTP id
 j21-20020a056e02219500b0034ded6ff841mr794838ila.11.1695146968206; 
 Tue, 19 Sep 2023 11:09:28 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 01/36] cli: Move simple readline into a function
Date: Tue, 19 Sep 2023 12:08:31 -0600
Message-ID: <20230919180918.2904313-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230919180918.2904313-1-sjg@chromium.org>
References: <20230919180918.2904313-1-sjg@chromium.org>
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

 common/cli_readline.c | 79 +++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index e83743e90c9..9a7c268719d 100644
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
2.42.0.459.ge4e396fd5e-goog

