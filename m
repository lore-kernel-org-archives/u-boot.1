Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2C2CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:11:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC05C86BEB;
	Tue, 19 Sep 2023 20:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cx2s83ni";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85B0F86BF4; Tue, 19 Sep 2023 20:09:41 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7032086BE0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-34fcd361e91so11384555ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146978; x=1695751778; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7LdKA2csN3FcC5y/FnocdywoBE1OK6+Tc8xJZD/w6/U=;
 b=Cx2s83niDo+cUfYEQK+M04r79cb0jshunAnRrkMD692xkXkS8XD/ooHYS4SQ0QUihJ
 Rqv8rrUcIF3LKda5p/RRw71yhV+hbuQOxSeQB02/MWdeEKt/SFrVF1+Cqc8J+K6l4WJU
 HFudycttojtYDb5oiolLKYnL/0FMgdhOe/G3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146978; x=1695751778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7LdKA2csN3FcC5y/FnocdywoBE1OK6+Tc8xJZD/w6/U=;
 b=s7+VXFDdl/oEjG2hH6a4zxuUYMvpgjLvi/UKC6z24QepCmo/KWjHyFZLa0+9G/0F4+
 jpQAmqU5o6pPAJPtNkBgzzRXQUK9hYmoq1xZjDtPB96tJTVSOKQNZCzQ0Aiy6JTwD9Ih
 ZibpXPJMkqiO2l6A2eyFVSAWawor0dY7kj4B/O0UcnLDIGxoa8jtnjAMr++B10qYtbKy
 r2E2gDVhkq+cVwJFU250Pr3KnODKGChpXuMsuH7lC8QBb+wr1w5uHiZ+7nIoyS2v/hxM
 6HFnS7cdPiG+tXHkx9cFeavUfY4/m3SgzLjKn8+fpOWtsTmlBw2Eh7SonYfrQK3OIY7D
 mppQ==
X-Gm-Message-State: AOJu0YynlyyHwnUAnrxHLgVDw90QNNs/8dWLjvY44ZGz2G1gQ2C/Y6Nn
 iAiw+2F7f4Q26vLXgsgvpzcqIc508BBBXG5IV8Q=
X-Google-Smtp-Source: AGHT+IHqFaq6iIgMMHEpzDUfKBOuk9nh9iwVqSzhdukxKRecpG2wfSGT1HT1NSoSbSrRBO1DLMvmOQ==
X-Received: by 2002:a92:c246:0:b0:34f:1de2:150a with SMTP id
 k6-20020a92c246000000b0034f1de2150amr619398ilo.9.1695146978106; 
 Tue, 19 Sep 2023 11:09:38 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 13/36] cli: Add a function to set up a new cread
Date: Tue, 19 Sep 2023 12:08:43 -0600
Message-ID: <20230919180918.2904313-14-sjg@chromium.org>
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

Create a init function so that it is easy to use command-line reading.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/cli_readline.c | 24 +++++++++++++++---------
 include/cli.h         | 17 ++++++++++++++++-
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 23913a857a9..06b8d465044 100644
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
index ad3cb4499fe..e183d561369 100644
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
2.42.0.459.ge4e396fd5e-goog

