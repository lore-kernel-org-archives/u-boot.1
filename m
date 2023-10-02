Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC15E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:23:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A90EC87155;
	Mon,  2 Oct 2023 03:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fUpq5rhK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBD7287116; Mon,  2 Oct 2023 03:14:16 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9747D870EB
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79fd60f40ebso59557339f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209244; x=1696814044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bld7zdrqSwYHdTRhD0N77M9IPwAIVQ4waUtS0TKtPow=;
 b=fUpq5rhKaO9E8pZDrdk9/QXT2pllisrfSfh4m2hpNL/LfTYBati/vR2+Exa8H+dYHB
 W31L6Cdv7I8UR8dNdWpcIwskJoFRY5IXMXZ8Wt4zg3SdSUQW/FNODdrp4LULE0q31OW8
 3exyXF0PZmWjl9PKiGak6NCBCXBsg+1CB2veA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209244; x=1696814044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bld7zdrqSwYHdTRhD0N77M9IPwAIVQ4waUtS0TKtPow=;
 b=s1GHVKwymjLeqACzt/HfVzoeNdXfXv63qaKr+zrHjP7/wGpIB4ONm/nHBbrPgR4asc
 r/f1sr6snt17r8eBERHxLL/e6X+bP3igxZ3fQIKfdrQrU2S/ITWeycHSVAi37eUzqwzH
 v7t6GLDv1gBgN6YjJ053jrKNoOgOmbizt3md40EziEAty3+xcsAp2JeefElC4uN3PMBF
 SqANTfeJ3p1tnFimYOsUyDfu+Jud7EB7ldWt6UwuUvbYISNcyYT+ieaLN60UsH8m9Git
 iiKzUGoa9260tOrjSM2sMdl1a5GWjO2dOaLI59l8vKyGwd46XHc2ygVPh6Xuvt2Ro6U1
 FtMw==
X-Gm-Message-State: AOJu0YxRtjAVpdX1YuNeo1eSbZ2mEA+X46l5mQ2hRaIrDii2PpZitbNr
 JHXfpHumk8yxneX/iqpHZdWgbnHm8KuPX9Pgmhk=
X-Google-Smtp-Source: AGHT+IHZEH6zV4Sb0/I5X0kTaGChFm1/YgilE+r7vkRK8AYCNvzwUKR11ThSWJm0IxNTQAghaizyRw==
X-Received: by 2002:a6b:5805:0:b0:795:d33:861f with SMTP id
 m5-20020a6b5805000000b007950d33861fmr8773611iob.6.1696209244213; 
 Sun, 01 Oct 2023 18:14:04 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 13/36] cli: Add a function to set up a new cread
Date: Sun,  1 Oct 2023 19:13:17 -0600
Message-ID: <20231002011349.461284-14-sjg@chromium.org>
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

Create a init function so that it is easy to use command-line reading.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/cli_readline.c | 24 +++++++++++++++---------
 include/cli.h         | 17 ++++++++++++++++-
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 23913a857a99..06b8d4650447 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -424,28 +424,34 @@ int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 	return -EAGAIN;
 }
 
+void cli_cread_init(struct cli_line_state *cls, char *buf, uint buf_size)
+{
+	int init_len = strlen(buf);
+
+	memset(cls, '\0', sizeof(struct cli_line_state));
+	cls->insert = true;
+	cls->buf = buf;
+	cls->len = buf_size;
+
+	if (init_len)
+		cread_add_str(buf, init_len, 0, &cls->num, &cls->eol_num, buf,
+			      buf_size);
+}
+
 static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 		      int timeout)
 {
 	struct cli_ch_state s_cch, *cch = &s_cch;
 	struct cli_line_state s_cls, *cls = &s_cls;
 	char ichar;
-	int init_len = strlen(buf);
 	int first = 1;
 
 	cli_ch_init(cch);
-	memset(cls, '\0', sizeof(struct cli_line_state));
-	cls->insert = true;
-	cls->len = *len;
+	cli_cread_init(cls, buf, *len);
 	cls->prompt = prompt;
-	cls->buf = buf;
 	cls->history = true;
 	cls->cmd_complete = true;
 
-	if (init_len)
-		cread_add_str(buf, init_len, 1, &cls->num, &cls->eol_num, buf,
-			      *len);
-
 	while (1) {
 		int ret;
 
diff --git a/include/cli.h b/include/cli.h
index ad3cb4499fe1..e183d5613697 100644
--- a/include/cli.h
+++ b/include/cli.h
@@ -32,7 +32,8 @@ struct cli_ch_state {
  * @eol_num: Number of characters in the buffer
  * @insert: true if in 'insert' mode
  * @history: true if history should be accessible
- * @cmd_complete: true if tab completion should be enabled
+ * @cmd_complete: true if tab completion should be enabled (requires @prompt to
+ *	be set)
  * @buf: Buffer containing line
  * @prompt: Prompt for the line
  */
@@ -262,6 +263,20 @@ int cli_ch_process(struct cli_ch_state *cch, int ichar);
  */
 int cread_line_process_ch(struct cli_line_state *cls, char ichar);
 
+/**
+ * cli_cread_init() - Set up a new cread struct
+ *
+ * Sets up a new cread state, with history and cmd_complete set to false
+ *
+ * After calling this, you can use cread_line_process_ch() to process characters
+ * received from the user.
+ *
+ * @cls: CLI line state
+ * @buf: Text buffer containing the initial text
+ * @buf_size: Buffer size, including nul terminator
+ */
+void cli_cread_init(struct cli_line_state *cls, char *buf, uint buf_size);
+
 /** cread_print_hist_list() - Print the command-line history list */
 void cread_print_hist_list(void);
 
-- 
2.42.0.582.g8ccd20d70d-goog

