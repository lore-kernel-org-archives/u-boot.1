Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BBAE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:21:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFB5B8713C;
	Mon,  2 Oct 2023 03:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bgtykZg8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 266F0870D5; Mon,  2 Oct 2023 03:14:12 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9AF870FA
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-79fc3d32a2fso415737239f.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209240; x=1696814040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YkCWmutKIr94qgt2+k7eAHKiHIlaUWcHz7vAKA8XtCk=;
 b=bgtykZg8hEq3LXxi723LvzHvhzhHkJ3hqUnBPLnjbT2pW9zGa9GSgpen7ZkLpMmCyt
 k+TPxsJ18qFwzoFATHDHbgMntWiX97CEiRMSggdVUuIrKhVzptskxoVRo4nSDsE/nHvY
 IkimQM3+Dn52lemQEgXzm8sUDitmX/mBVC1d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209240; x=1696814040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YkCWmutKIr94qgt2+k7eAHKiHIlaUWcHz7vAKA8XtCk=;
 b=VxGIEDfukdi24mXRRjeGRMx6MIQlrBb5gytqJxcn8QNUObCbIFzPELb7cwBeaDbre1
 52Xpo76t+BJCZymOp3qcflFwcf+pY0zwYWZKQPOXuhrZMFUDJ5ghhy5Mn6oqb3dKri56
 7kIXivxtyjoz5PcKZlJTuE8ZPx0buxMvXp+IXmjWKLsuBl162DBDMGtTzzcwKdedaj+b
 4+WBViRp/BdbmaG9WBKhcdTpRAH3oz/euFb2welJ5QPyRYxpUXXSM9/wSUkwR5bGP+H3
 Bzv/NBq1v8nD7kzQdBmXZn4d2yZRJIy2NaMCuhmhWaci5HJ8zxDsjy1bMNMqJjuCLhv3
 KjZg==
X-Gm-Message-State: AOJu0YyLG8BDVfqNltNY7TN+o3P20tvBDG4BjCJ+Mac7Ffj2fDsmx4KQ
 PEKLsCdmhvxsgu8ZAbQlD2mEFsZIojZvQTo4aD8=
X-Google-Smtp-Source: AGHT+IHVw29pUvOh4LnPEuaPcdgut5VthEkvdIFKdLlyTjKH5PVn+WGZrekhUQF7K7mj4JNhl1oHPA==
X-Received: by 2002:a6b:dc10:0:b0:794:e96f:b87d with SMTP id
 s16-20020a6bdc10000000b00794e96fb87dmr10255131ioc.0.1696209240640; 
 Sun, 01 Oct 2023 18:14:00 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/36] cli: Create a function to process characters
Date: Sun,  1 Oct 2023 19:13:13 -0600
Message-ID: <20231002011349.461284-10-sjg@chromium.org>
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

Move most of the inner loop from cread_line() into a new function. This
will allow using it from other code.

This involves adding a few more members to the state struct.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/cli_readline.c | 108 ++++++++++++++++++++++++------------------
 include/cli.h         |  15 ++++++
 2 files changed, 78 insertions(+), 45 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index f5d1cb034338..62d419bb36a7 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -253,52 +253,17 @@ static void cread_add_str(char *str, int strsize, int insert,
 	}
 }
 
-static int cread_line(const char *const prompt, char *buf, unsigned int *len,
-		int timeout)
+int cread_line_process_ch(struct cli_line_state *cls, char ichar)
 {
-	struct cli_ch_state s_cch, *cch = &s_cch;
-	struct cli_line_state s_cls, *cls = &s_cls;
-	char ichar;
-	int init_len = strlen(buf);
-	int first = 1;
-
-	cli_ch_init(cch);
-	memset(cls, '\0', sizeof(struct cli_line_state));
-	cls->insert = true;
-
-	if (init_len)
-		cread_add_str(buf, init_len, 1, &cls->num, &cls->eol_num, buf,
-			      *len);
-
-	while (1) {
-		/* Check for saved characters */
-		ichar = cli_ch_process(cch, 0);
-
-		if (!ichar) {
-			if (bootretry_tstc_timeout())
-				return -2;	/* timed out */
-			if (first && timeout) {
-				u64 etime = endtick(timeout);
-
-				while (!tstc()) {	/* while no incoming data */
-					if (get_ticks() >= etime)
-						return -2;	/* timed out */
-					schedule();
-				}
-				first = 0;
-			}
-
-			ichar = getcmd_getch();
-			ichar = cli_ch_process(cch, ichar);
-		}
+	char *buf = cls->buf;
 
 	/* ichar=0x0 when error occurs in U-Boot getc */
 	if (!ichar)
-		continue;
+		return -EAGAIN;
 
 	if (ichar == '\n') {
 		putc('\n');
-		break;
+		return 0;
 	}
 
 	switch (ichar) {
@@ -307,7 +272,7 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 		break;
 	case CTL_CH('c'):	/* ^C - break */
 		*buf = '\0';	/* discard input */
-		return -1;
+		return -EINTR;
 	case CTL_CH('f'):
 		if (cls->num < cls->eol_num) {
 			getcmd_putch(buf[cls->num]);
@@ -405,7 +370,7 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 
 		if (!hline) {
 			getcmd_cbeep();
-			continue;
+			break;
 		}
 
 		/* nuke the current line */
@@ -419,7 +384,7 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 		strcpy(buf, hline);
 		cls->eol_num = strlen(buf);
 		REFRESH_TO_EOL();
-		continue;
+		break;
 	}
 	case '\t':
 		if (IS_ENABLED(CONFIG_AUTO_COMPLETE)) {
@@ -432,9 +397,9 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 			}
 
 			buf[cls->num] = '\0';
-			col = strlen(prompt) + cls->eol_num;
+			col = strlen(cls->prompt) + cls->eol_num;
 			num2 = cls->num;
-			if (cmd_auto_complete(prompt, buf, &num2, &col)) {
+			if (cmd_auto_complete(cls->prompt, buf, &num2, &col)) {
 				col = num2 - cls->num;
 				cls->num += col;
 				cls->eol_num += col;
@@ -444,9 +409,62 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 		fallthrough;
 	default:
 		cread_add_char(ichar, cls->insert, &cls->num, &cls->eol_num,
-			       buf, *len);
+			       buf, cls->len);
 		break;
 	}
+
+	return -EAGAIN;
+}
+
+static int cread_line(const char *const prompt, char *buf, unsigned int *len,
+		      int timeout)
+{
+	struct cli_ch_state s_cch, *cch = &s_cch;
+	struct cli_line_state s_cls, *cls = &s_cls;
+	char ichar;
+	int init_len = strlen(buf);
+	int first = 1;
+
+	cli_ch_init(cch);
+	memset(cls, '\0', sizeof(struct cli_line_state));
+	cls->insert = true;
+	cls->len = *len;
+	cls->prompt = prompt;
+	cls->buf = buf;
+
+	if (init_len)
+		cread_add_str(buf, init_len, 1, &cls->num, &cls->eol_num, buf,
+			      *len);
+
+	while (1) {
+		int ret;
+
+		/* Check for saved characters */
+		ichar = cli_ch_process(cch, 0);
+
+		if (!ichar) {
+			if (bootretry_tstc_timeout())
+				return -2;	/* timed out */
+			if (first && timeout) {
+				u64 etime = endtick(timeout);
+
+				while (!tstc()) {	/* while no incoming data */
+					if (get_ticks() >= etime)
+						return -2;	/* timed out */
+					schedule();
+				}
+				first = 0;
+			}
+
+			ichar = getcmd_getch();
+			ichar = cli_ch_process(cch, ichar);
+		}
+
+		ret = cread_line_process_ch(cls, ichar);
+		if (ret == -EINTR)
+			return -1;
+		else if (!ret)
+			break;
 	}
 	*len = cls->eol_num;
 	buf[cls->eol_num] = '\0';	/* lose the newline */
diff --git a/include/cli.h b/include/cli.h
index 1bc1ab8035c8..bbc532764355 100644
--- a/include/cli.h
+++ b/include/cli.h
@@ -31,11 +31,16 @@ struct cli_ch_state {
  * @num: Current cursor position, where 0 is the start
  * @eol_num: Number of characters in the buffer
  * @insert: true if in 'insert' mode
+ * @buf: Buffer containing line
+ * @prompt: Prompt for the line
  */
 struct cli_line_state {
 	uint num;
 	uint eol_num;
+	uint len;
 	bool insert;
+	char *buf;
+	const char *prompt;
 };
 
 /**
@@ -243,6 +248,16 @@ void cli_ch_init(struct cli_ch_state *cch);
  */
 int cli_ch_process(struct cli_ch_state *cch, int ichar);
 
+/**
+ * cread_line_process_ch() - Process a character for line input
+ *
+ * @cls: CLI line state
+ * @ichar: Character to process
+ * Return: 0 if input is complete, with line in cls->buf, -EINTR if input was
+ * cancelled with Ctrl-C, -EAGAIN if more characters are needed
+ */
+int cread_line_process_ch(struct cli_line_state *cls, char ichar);
+
 /** cread_print_hist_list() - Print the command-line history list */
 void cread_print_hist_list(void);
 
-- 
2.42.0.582.g8ccd20d70d-goog

