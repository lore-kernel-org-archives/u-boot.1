Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1854E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11C558715B;
	Mon,  2 Oct 2023 03:15:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="m3277H1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB4BE8711A; Mon,  2 Oct 2023 03:14:14 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6F5087104
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-35255c1a448so13499905ab.3
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209242; x=1696814042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ms0xnjJ2izoICBk5H1WvfghFkEB+AKY8GKRuZxg4dlU=;
 b=m3277H1Wv7Y2KhJkTDqHEgBdXrqTXD+MdWBPvIpQ4PUVts922e5W9Udb1DBDzpVNyT
 Z/iwymzhorLtn1Xn5OLYdhu2gd8PDeETYfSB+3Gm2Ty8c7igqo2qv0W+3yY5fwGsmj53
 MCI6PdlkA1WA19B5ivhPCDMwaFsp3XyUzbstk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209242; x=1696814042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ms0xnjJ2izoICBk5H1WvfghFkEB+AKY8GKRuZxg4dlU=;
 b=Clp1oGjLd8OpjR5syX/dFlEbBY4eRubdX9pjVgM4jxEhdSRgsTIzTvxebBkFJG7HSv
 Fhqzq16/IKaJfXfZ5Bh0l8WhkvBNDRssiEuHxRMYgbc+ofRuawizGRc+bDfVoYEsnbwr
 NYMjbRS+yO/tJ5kkmY7QfpXyvgxVv9uyWVKk6Zk6eQvO0pCDd4TzNftzxnilgojrZDwO
 2NZqTbNfecAn9/DJyibO7t0V+SCyjGLSCLxZ2pU4JbO9ahE8/JnkRHoEHFfLVypngvmM
 scw2tfw0EHw86N83nPHCOs9Ln33B4UrhArhpmjSlsOOLM2dGBzxEFBbF/oVWZSwLKmFZ
 6HbA==
X-Gm-Message-State: AOJu0YzySeyyeNIXOflh/76w8HHE/pPlpJZtgrnE8JSkfm9uAVwIG/R1
 zsabR9X5CaYfELxXZIgIaigQGNACKDDuP+FNw5Q=
X-Google-Smtp-Source: AGHT+IHpXpcYPZ4dvJZ+6lkeu7zXwicIK6Vk1tRRfGXStIaSPjouS63pHQVSjlS94Ii+8YNnBPF0Qw==
X-Received: by 2002:a05:6e02:b26:b0:351:47fd:e9df with SMTP id
 e6-20020a056e020b2600b0035147fde9dfmr11256783ilu.32.1696209242330; 
 Sun, 01 Oct 2023 18:14:02 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 11/36] cli: Allow history to be disabled
Date: Sun,  1 Oct 2023 19:13:15 -0600
Message-ID: <20231002011349.461284-12-sjg@chromium.org>
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

When inputting text outside the command line we don't want history to be
accessible. Add an option to control this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/cli_readline.c | 42 ++++++++++++++++++++++--------------------
 include/cli.h         |  2 ++
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index fdb84d9204f6..fa8f525d3a41 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -361,32 +361,33 @@ int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 		break;
 	case CTL_CH('p'):
 	case CTL_CH('n'):
-	{
-		char *hline;
+		if (cls->history) {
+			char *hline;
 
-		if (ichar == CTL_CH('p'))
-			hline = hist_prev();
-		else
-			hline = hist_next();
+			if (ichar == CTL_CH('p'))
+				hline = hist_prev();
+			else
+				hline = hist_next();
 
-		if (!hline) {
-			getcmd_cbeep();
-			break;
-		}
+			if (!hline) {
+				getcmd_cbeep();
+				break;
+			}
 
-		/* nuke the current line */
-		/* first, go home */
-		BEGINNING_OF_LINE();
+			/* nuke the current line */
+			/* first, go home */
+			BEGINNING_OF_LINE();
 
-		/* erase to end of line */
-		ERASE_TO_EOL();
+			/* erase to end of line */
+			ERASE_TO_EOL();
 
-		/* copy new line into place and display */
-		strcpy(buf, hline);
-		cls->eol_num = strlen(buf);
-		REFRESH_TO_EOL();
+			/* copy new line into place and display */
+			strcpy(buf, hline);
+			cls->eol_num = strlen(buf);
+			REFRESH_TO_EOL();
+			break;
+		}
 		break;
-	}
 	case '\t':
 		if (IS_ENABLED(CONFIG_AUTO_COMPLETE)) {
 			int num2, col;
@@ -438,6 +439,7 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 	cls->len = *len;
 	cls->prompt = prompt;
 	cls->buf = buf;
+	cls->history = true;
 
 	if (init_len)
 		cread_add_str(buf, init_len, 1, &cls->num, &cls->eol_num, buf,
diff --git a/include/cli.h b/include/cli.h
index bbc532764355..252bdb70ab0d 100644
--- a/include/cli.h
+++ b/include/cli.h
@@ -31,6 +31,7 @@ struct cli_ch_state {
  * @num: Current cursor position, where 0 is the start
  * @eol_num: Number of characters in the buffer
  * @insert: true if in 'insert' mode
+ * @history: true if history should be accessible
  * @buf: Buffer containing line
  * @prompt: Prompt for the line
  */
@@ -39,6 +40,7 @@ struct cli_line_state {
 	uint eol_num;
 	uint len;
 	bool insert;
+	bool history;
 	char *buf;
 	const char *prompt;
 };
-- 
2.42.0.582.g8ccd20d70d-goog

