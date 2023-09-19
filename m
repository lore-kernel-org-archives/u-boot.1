Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC37CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB9986BE3;
	Tue, 19 Sep 2023 20:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cgeEsE+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EFC086BC8; Tue, 19 Sep 2023 20:09:37 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B83D86AEB
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34fe2814b0dso7937065ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146974; x=1695751774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+kY9uY/COtSrVOINCsJuhlp2lFC98whygTdWoUUb2E=;
 b=cgeEsE+V+G2ESryRiALjWdji6HD/o9Yl8JAY4XBh95X+jcjDYLnJ6qJZwPz4/1AOT/
 L1Hd8J1NpUpspr+odtd9LY6G1EvZzpRgAFR/1J2oFqM3WNCkn6C5vlF292jfOS0rlZG0
 KjcMLcMhvSkb1fZ4dtdEPyw7okZeEciH5c8/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146974; x=1695751774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+kY9uY/COtSrVOINCsJuhlp2lFC98whygTdWoUUb2E=;
 b=GW14cioT/BgjhfRbaBj8KBQpG+/VtLG8PqScxU8P3t23k/ENt7u6lez+gRM6XVZ/x2
 +m73mjtxbDC7OfF4ZCmFC2caetUoyFp9OKx6EqIwINCabUllMvwnphkmCOZlJ5lyHM+Q
 hCFJS+B73UUlxw/kv//oZn4gXK1PXY8u2NuBT2cYsUvmmW/WjD/rFdq+OcwyjskJ6kWW
 efAq+glV6naIkRndcAyfFARBhRjHMGgHlaadmmp256xbZNO5yRLm8qKZT40xSOAgqO2J
 2NwwvCGw6Am6FkxJ2j1Lo9YWN5JAc9pHGzvUDLjsVVIMEfyTYo9muHMYmBjumesjpBh0
 91YQ==
X-Gm-Message-State: AOJu0YxMDZaG3xC7xE0o/Ivl17Ng9CkFdYZzaKTyx0K0mhrmsE2odYYp
 TtzJwU7NJDTrYlaKSSjA1FvYlUqoNbB5MoWr2vQ=
X-Google-Smtp-Source: AGHT+IH7Oe7jUeJWdHpQbQUfqCTFV1/Q8X750yRFbvZkg9PSKvfYvj6HVu9Wogy+5aLmSNu0k13mKw==
X-Received: by 2002:a05:6e02:c24:b0:34f:3be4:e327 with SMTP id
 q4-20020a056e020c2400b0034f3be4e327mr558066ilg.24.1695146973809; 
 Tue, 19 Sep 2023 11:09:33 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 07/36] cli: Convert cread_line() to use a struct for the main
 vars
Date: Tue, 19 Sep 2023 12:08:37 -0600
Message-ID: <20230919180918.2904313-8-sjg@chromium.org>
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

We want to reuse the editing code elsewhere. As a first step, move the
common variables into a struct. This will allow us to eventually put the
contents of the inner loop in a function, so it can be called from
elsewhere.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/cli_readline.c | 116 ++++++++++++++++++++++--------------------
 include/cli.h         |  14 +++++
 2 files changed, 75 insertions(+), 55 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index f863404110c..03624ca18af 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -188,27 +188,27 @@ void cread_print_hist_list(void)
 }
 
 #define BEGINNING_OF_LINE() {			\
-	while (num) {				\
+	while (cls->num) {			\
 		getcmd_putch(CTL_BACKSPACE);	\
-		num--;				\
+		cls->num--;			\
 	}					\
 }
 
 #define ERASE_TO_EOL() {				\
-	if (num < eol_num) {				\
-		printf("%*s", (int)(eol_num - num), ""); \
+	if (cls->num < cls->eol_num) {		\
+		printf("%*s", (int)(cls->eol_num - cls->num), ""); \
 		do {					\
 			getcmd_putch(CTL_BACKSPACE);	\
-		} while (--eol_num > num);		\
+		} while (--cls->eol_num > cls->num);	\
 	}						\
 }
 
-#define REFRESH_TO_EOL() {			\
-	if (num < eol_num) {			\
-		wlen = eol_num - num;		\
-		putnstr(buf + num, wlen);	\
-		num = eol_num;			\
-	}					\
+#define REFRESH_TO_EOL() {				\
+	if (cls->num < cls->eol_num) {			\
+		uint wlen = cls->eol_num - cls->num;	\
+		putnstr(buf + cls->num, wlen);		\
+		cls->num = cls->eol_num;		\
+	}						\
 }
 
 static void cread_add_char(char ichar, int insert, uint *num,
@@ -257,18 +257,18 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 		int timeout)
 {
 	struct cli_ch_state s_cch, *cch = &s_cch;
-	uint num = 0;
-	uint eol_num = 0;
-	uint wlen;
+	struct cli_line_state s_cls, *cls = &s_cls;
 	char ichar;
-	int insert = 1;
 	int init_len = strlen(buf);
 	int first = 1;
 
 	cli_ch_init(cch);
+	memset(cls, '\0', sizeof(struct cli_line_state));
+	cls->insert = true;
 
 	if (init_len)
-		cread_add_str(buf, init_len, 1, &num, &eol_num, buf, *len);
+		cread_add_str(buf, init_len, 1, &cls->num, &cls->eol_num, buf,
+			      *len);
 
 	while (1) {
 		/* Check for saved characters */
@@ -309,30 +309,33 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 			*buf = '\0';	/* discard input */
 			return -1;
 		case CTL_CH('f'):
-			if (num < eol_num) {
-				getcmd_putch(buf[num]);
-				num++;
+			if (cls->num < cls->eol_num) {
+				getcmd_putch(buf[cls->num]);
+				cls->num++;
 			}
 			break;
 		case CTL_CH('b'):
-			if (num) {
+			if (cls->num) {
 				getcmd_putch(CTL_BACKSPACE);
-				num--;
+				cls->num--;
 			}
 			break;
 		case CTL_CH('d'):
-			if (num < eol_num) {
-				wlen = eol_num - num - 1;
+			if (cls->num < cls->eol_num) {
+				uint wlen;
+
+				wlen = cls->eol_num - cls->num - 1;
 				if (wlen) {
-					memmove(&buf[num], &buf[num+1], wlen);
-					putnstr(buf + num, wlen);
+					memmove(&buf[cls->num],
+						&buf[cls->num + 1], wlen);
+					putnstr(buf + cls->num, wlen);
 				}
 
 				getcmd_putch(' ');
 				do {
 					getcmd_putch(CTL_BACKSPACE);
 				} while (wlen--);
-				eol_num--;
+				cls->eol_num--;
 			}
 			break;
 		case CTL_CH('k'):
@@ -342,28 +345,28 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 			REFRESH_TO_EOL();
 			break;
 		case CTL_CH('o'):
-			insert = !insert;
+			cls->insert = !cls->insert;
 			break;
 		case CTL_CH('w'):
-			if (num) {
-				uint base;
+			if (cls->num) {
+				uint base, wlen;
 
-				for (base = num - 1;
+				for (base = cls->num - 1;
 				     base >= 0 && buf[base] == ' ';)
 					base--;
 				for (; base > 0 && buf[base - 1] != ' ';)
 					base--;
 
-				/* now delete chars from base to num */
-				wlen = num - base;
-				eol_num -= wlen;
-				memmove(&buf[base], &buf[num],
-					eol_num - base + 1);
-				num = base;
+				/* now delete chars from base to cls->num */
+				wlen = cls->num - base;
+				cls->eol_num -= wlen;
+				memmove(&buf[base], &buf[cls->num],
+					cls->eol_num - base + 1);
+				cls->num = base;
 				getcmd_putchars(wlen, CTL_BACKSPACE);
 				puts(buf + base);
 				getcmd_putchars(wlen, ' ');
-				getcmd_putchars(wlen + eol_num - num,
+				getcmd_putchars(wlen + cls->eol_num - cls->num,
 						CTL_BACKSPACE);
 			}
 			break;
@@ -375,17 +378,20 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 		case DEL:
 		case DEL7:
 		case 8:
-			if (num) {
-				wlen = eol_num - num;
-				num--;
-				memmove(&buf[num], &buf[num+1], wlen);
+			if (cls->num) {
+				uint wlen;
+
+				wlen = cls->eol_num - cls->num;
+				cls->num--;
+				memmove(&buf[cls->num], &buf[cls->num + 1],
+					wlen);
 				getcmd_putch(CTL_BACKSPACE);
-				putnstr(buf + num, wlen);
+				putnstr(buf + cls->num, wlen);
 				getcmd_putch(' ');
 				do {
 					getcmd_putch(CTL_BACKSPACE);
 				} while (wlen--);
-				eol_num--;
+				cls->eol_num--;
 			}
 			break;
 		case CTL_CH('p'):
@@ -412,7 +418,7 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 
 			/* copy new line into place and display */
 			strcpy(buf, hline);
-			eol_num = strlen(buf);
+			cls->eol_num = strlen(buf);
 			REFRESH_TO_EOL();
 			continue;
 		}
@@ -421,30 +427,30 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 				int num2, col;
 
 				/* do not autocomplete when in the middle */
-				if (num < eol_num) {
+				if (cls->num < cls->eol_num) {
 					getcmd_cbeep();
 					break;
 				}
 
-				buf[num] = '\0';
-				col = strlen(prompt) + eol_num;
-				num2 = num;
+				buf[cls->num] = '\0';
+				col = strlen(prompt) + cls->eol_num;
+				num2 = cls->num;
 				if (cmd_auto_complete(prompt, buf, &num2, &col)) {
-					col = num2 - num;
-					num += col;
-					eol_num += col;
+					col = num2 - cls->num;
+					cls->num += col;
+					cls->eol_num += col;
 				}
 				break;
 			}
 			fallthrough;
 		default:
-			cread_add_char(ichar, insert, &num, &eol_num, buf,
-				       *len);
+			cread_add_char(ichar, cls->insert, &cls->num,
+				       &cls->eol_num, buf, *len);
 			break;
 		}
 	}
-	*len = eol_num;
-	buf[eol_num] = '\0';	/* lose the newline */
+	*len = cls->eol_num;
+	buf[cls->eol_num] = '\0';	/* lose the newline */
 
 	if (buf[0] && buf[0] != CREAD_HIST_CHAR)
 		cread_add_to_hist(buf);
diff --git a/include/cli.h b/include/cli.h
index ac09c80c784..1bc1ab8035c 100644
--- a/include/cli.h
+++ b/include/cli.h
@@ -8,6 +8,7 @@
 #define __CLI_H
 
 #include <stdbool.h>
+#include <linux/types.h>
 
 /**
  * struct cli_ch_state - state information for reading cmdline characters
@@ -24,6 +25,19 @@ struct cli_ch_state {
 	bool emitting;
 };
 
+/**
+ * struct cli_line_state - state of the line editor
+ *
+ * @num: Current cursor position, where 0 is the start
+ * @eol_num: Number of characters in the buffer
+ * @insert: true if in 'insert' mode
+ */
+struct cli_line_state {
+	uint num;
+	uint eol_num;
+	bool insert;
+};
+
 /**
  * Go into the command loop
  *
-- 
2.42.0.459.ge4e396fd5e-goog

