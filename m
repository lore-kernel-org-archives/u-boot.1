Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC34CE79A9
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F03486BCE;
	Tue, 19 Sep 2023 20:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LhVQZyqB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EE7C86BC0; Tue, 19 Sep 2023 20:09:34 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F0286BC8
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34fdc6209c6so9967135ab.3
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146971; x=1695751771; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQMDMM4HL8NoLuid2FNHrcggI9EBebqKacjVSqiohas=;
 b=LhVQZyqBNovDuVIOKUH9oZQsDjyaWk6trILiYS7d0h69t8DEyg0z4qZlfq0iEc8j7X
 XqOvAwJ0hW0c+oNMwAoAoRt0mHH84Byu7BqR7DKlT3/awb0dJ0j/++HmgKRjemRKvtIW
 jzzhprNZ4uvKnYutc0K7mNBDqbCx6R0zk/rHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146971; x=1695751771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQMDMM4HL8NoLuid2FNHrcggI9EBebqKacjVSqiohas=;
 b=YzvQWIUfAQOfmV/V2NQwpSylrIf3afyjVDOfjmwzc+LR+hj6H3oLMJQ7dRNDZ7z55D
 LpQZH9H2c9e+/BxGbG4IgBIsXcWqV+f/XZd7KsbC4GoHdWGwsvwCHDq1nz0QczWUoBmy
 OYKFy7Mx8uPyTTXG34ihxpTIjzUaCn43/tdvJIcx2bgBoWmJaiIkc17amqELosWDnZuS
 gxn4xu4egmQfcj8P2MS+T/njhVOAYvHBQo/RcvO3r17oWBYNy4mHKIqS4O55JLxtYwrk
 SDtiFagRKkhq/0L7crbrk93AzdBlu1CqNTxcFMa+G6zRcyAmJRH4CXTiKtdrzIQj81dr
 dywg==
X-Gm-Message-State: AOJu0YxzrhqOSC890g0/85jAOovGX3wQ7ldEWyEICFACnBxgbHQMSlFO
 XLca/0hrhij/SVNC6slxX58eK9hgERjIZ945tHc=
X-Google-Smtp-Source: AGHT+IFMM6jDfuj04qcZn8Zn1rU90JHAWy2Dtds1//EoijWrL/Lstd2DdKXHuzpTAxwrQCUHCWGfDg==
X-Received: by 2002:a05:6e02:1d0c:b0:350:e9c6:e765 with SMTP id
 i12-20020a056e021d0c00b00350e9c6e765mr818294ila.11.1695146970794; 
 Tue, 19 Sep 2023 11:09:30 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:30 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 04/36] cli: Drop #ifdefs for CONFIG_AUTO_COMPLETE in
 cli_readline
Date: Tue, 19 Sep 2023 12:08:34 -0600
Message-ID: <20230919180918.2904313-5-sjg@chromium.org>
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

Use a static inline and adjust the logic to avoid the need for #ifdefs in
cli_readline_into_buffer()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/cli_readline.c | 85 +++++++++++++++++++++----------------------
 include/command.h     |  6 +++
 2 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 61f9ba99068..458e927e492 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -386,27 +386,27 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 			REFRESH_TO_EOL();
 			continue;
 		}
-#ifdef CONFIG_AUTO_COMPLETE
-		case '\t': {
-			int num2, col;
+		case '\t':
+			if (IS_ENABLED(CONFIG_AUTO_COMPLETE)) {
+				int num2, col;
+
+				/* do not autocomplete when in the middle */
+				if (num < eol_num) {
+					getcmd_cbeep();
+					break;
+				}
 
-			/* do not autocomplete when in the middle */
-			if (num < eol_num) {
-				getcmd_cbeep();
+				buf[num] = '\0';
+				col = strlen(prompt) + eol_num;
+				num2 = num;
+				if (cmd_auto_complete(prompt, buf, &num2, &col)) {
+					col = num2 - num;
+					num += col;
+					eol_num += col;
+				}
 				break;
 			}
-
-			buf[num] = '\0';
-			col = strlen(prompt) + eol_num;
-			num2 = num;
-			if (cmd_auto_complete(prompt, buf, &num2, &col)) {
-				col = num2 - num;
-				num += col;
-				eol_num += col;
-			}
-			break;
-		}
-#endif
+			fallthrough;
 		default:
 			cread_add_char(ichar, insert, &num, &eol_num, buf,
 				       *len);
@@ -519,14 +519,15 @@ static int cread_line_simple(const char *const prompt, char *p)
 			continue;
 
 		default:
-			/*
-			 * Must be a normal character then
-			 */
-			if (n < CONFIG_SYS_CBSIZE-2) {
-				if (c == '\t') {	/* expand TABs */
-#ifdef CONFIG_AUTO_COMPLETE
+			/* Must be a normal character then */
+			if (n >= CONFIG_SYS_CBSIZE - 2) { /* Buffer full */
+				putc('\a');
+				break;
+			}
+			if (c == '\t') {	/* expand TABs */
+				if (IS_ENABLED(CONFIG_AUTO_COMPLETE)) {
 					/*
-					 * if auto completion triggered just
+					 * if auto-completion triggered just
 					 * continue
 					 */
 					*p = '\0';
@@ -536,26 +537,24 @@ static int cread_line_simple(const char *const prompt, char *p)
 						p = p_buf + n;	/* reset */
 						continue;
 					}
-#endif
-					puts(tab_seq + (col & 07));
-					col += 8 - (col & 07);
-				} else {
-					char __maybe_unused buf[2];
-
-					/*
-					 * Echo input using puts() to force an
-					 * LCD flush if we are using an LCD
-					 */
-					++col;
-					buf[0] = c;
-					buf[1] = '\0';
-					puts(buf);
 				}
-				*p++ = c;
-				++n;
-			} else {			/* Buffer full */
-				putc('\a');
+				puts(tab_seq + (col & 07));
+				col += 8 - (col & 07);
+			} else {
+				char __maybe_unused buf[2];
+
+				/*
+				 * Echo input using puts() to force an LCD
+				 * flush if we are using an LCD
+				 */
+				++col;
+				buf[0] = c;
+				buf[1] = '\0';
+				puts(buf);
 			}
+			*p++ = c;
+			++n;
+			break;
 		}
 	}
 }
diff --git a/include/command.h b/include/command.h
index ae7bb4a30b0..44636fbfc56 100644
--- a/include/command.h
+++ b/include/command.h
@@ -91,6 +91,12 @@ int var_complete(int argc, char *const argv[], char last_char, int maxv,
 		 char *cmdv[]);
 int cmd_auto_complete(const char *const prompt, char *buf, int *np,
 		      int *colp);
+#else
+static inline int cmd_auto_complete(const char *const prompt, char *buf,
+				    int *np, int *colp)
+{
+	return 0;
+}
 #endif
 
 /**
-- 
2.42.0.459.ge4e396fd5e-goog

