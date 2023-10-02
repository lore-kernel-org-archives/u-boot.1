Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C87BE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:20:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F50C8711B;
	Mon,  2 Oct 2023 03:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kEyliEX2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E53870FB; Mon,  2 Oct 2023 03:14:03 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 343D1870E3
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3528bc102adso1068735ab.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209236; x=1696814036; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5r9t/dfRBm7/j24vPYG+ageHetDnzJZcBKTKJylmdCA=;
 b=kEyliEX2P47fav+/TO1WX0KEMfdRnp2QaqYjqf+WjrJlJs6Ag3rbNmB6H4+Yu84wbr
 9o1iucmqDnoBHuak8DaxrH+wn7znRdWUAzEYPmBd6lrS6yWrFLFRcrbQnTg2jrayIRqk
 9ukHJtwdpe8TVWDlRAi4Il6N9PrZfAzS/0S9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209236; x=1696814036;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5r9t/dfRBm7/j24vPYG+ageHetDnzJZcBKTKJylmdCA=;
 b=NG/3iGfs6hPMOIutSUs0QINYzmBX3k2jwqcercrCJOrBSEbiW5r6OT0LJib44spW+c
 5U6957taQBCiCgHoG6mqX/y/03FRO1dg/t1QN7dMAeGg6l+3Pu0pifqSosHpfA+y1vJk
 myWQn6Ak6MP4AoAq7BQuK9u10fi25BVS8aE0eTxaP7AprAqqvpNcajciWUL0h+UKyhPG
 jbkzE1sILNlqa1+0Op79PG3FSIvP5Eeugc0DrnlWP8oPTVQl7+zLv+rBaa7EkmZBzZO6
 3Ci+88wnCRG45N60ihELRmwv6lfqPT+n6+sTjwc2nwfMr+ci7wlPmNRYdp3u454cJRZN
 UJfw==
X-Gm-Message-State: AOJu0YwIkpS3ttqtEi/ZpVm577rWAJEaNiEh9Pxjt19JgVHallYcJ44L
 rO5oqEwGJWRZYxAfY6kmViUkA1X78CrMKRCJcYk=
X-Google-Smtp-Source: AGHT+IERX3+k/HRs46pXoXBgsLKWZyukrwYfDJ3V9YECC83bNla2L238bTnM47fRkacPVSDDsc4/Jg==
X-Received: by 2002:a92:cd8a:0:b0:352:620b:f8b with SMTP id
 r10-20020a92cd8a000000b00352620b0f8bmr10065238ilb.9.1696209236748; 
 Sun, 01 Oct 2023 18:13:56 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.13.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:13:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 04/36] cli: Drop #ifdefs for CONFIG_AUTO_COMPLETE in
 cli_readline
Date: Sun,  1 Oct 2023 19:13:08 -0600
Message-ID: <20231002011349.461284-5-sjg@chromium.org>
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

Use a static inline and adjust the logic to avoid the need for #ifdefs in
cli_readline_into_buffer()

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/cli_readline.c | 85 +++++++++++++++++++++----------------------
 include/command.h     |  6 +++
 2 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 61f9ba99068a..458e927e4922 100644
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
index ae7bb4a30b05..44636fbfc562 100644
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
2.42.0.582.g8ccd20d70d-goog

