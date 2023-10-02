Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D01EE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D8C387114;
	Mon,  2 Oct 2023 03:14:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jRSamRiA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E55E3870F5; Mon,  2 Oct 2023 03:14:11 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75ABC870C5
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3ae35773a04so7891372b6e.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209240; x=1696814040; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kRB1OeqRxf6nseYX/z5+Bv2GcpWD9b+n3hHrKWxmIxo=;
 b=jRSamRiAz2g5vRU9LveW8PMNXha7L88FJL7cLi0l6gCyn4jjsO8RdaHo2mUz+VhoPt
 9A1yrKDLjxPtftSPMAUuctLjWU3FIePgr49QCwDThVQTopI2uFV9Cdrj33fk7jR4Gm7F
 1k5/AxLm5hgrQsxVoSWz37DpGIpGgNcC6M9hU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209240; x=1696814040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kRB1OeqRxf6nseYX/z5+Bv2GcpWD9b+n3hHrKWxmIxo=;
 b=AHtFR1KZReNl60R5ihFTnHbBe+b+lULrneJF/nR9Fhof3gaoH9yMliluvb6T5NVyu0
 mZuk9Yo6IqfByuWulZEM/M9h2PTU3FXHYQRjdN8uvsbzYV0DtUXpxnYl8Tz0z5eGl9GP
 aTn5MdMIuLjQshqW7PuxmTkZ9vvq/tYPpBDK0fNjHGExEkiJW5+PpNt7YdbXtaOztkNw
 6k+nbm+rimgEtkv/St+nGSY+CD5lGkU+vOGJ92rvN+QfMVGarC60t5boK6oOKkMBDgJU
 GsLSRBtC01JXYtTYRFveovXNoLohgCezFei9ngKccIFiI5YAJYJwlmVUr82LJZwFePMi
 Exeg==
X-Gm-Message-State: AOJu0Yx1MhDCXeUSPKSWhwX/eEZ6KpPhmhJ22XwslGXyOiHKRXuXnHOV
 E0zRYHWP8e2hqHHDPZyDZKPivxTS7AdSh20LeLg=
X-Google-Smtp-Source: AGHT+IHHAHTItEIGr+f8vu1kugtpYTAfoCjxnMmSQt8Zoo5Vq7HGN7caSIcAX8yZXjPNL41pOH6NTw==
X-Received: by 2002:a54:4489:0:b0:3ad:fb3a:4b6 with SMTP id
 v9-20020a544489000000b003adfb3a04b6mr10389616oiv.41.1696209239906; 
 Sun, 01 Oct 2023 18:13:59 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:13:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 08/36] cli: Unindent some code in cread_line()
Date: Sun,  1 Oct 2023 19:13:12 -0600
Message-ID: <20231002011349.461284-9-sjg@chromium.org>
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

Reduce the indentation level of this code so it is easier to review the
next patch, which moves it into a function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/cli_readline.c | 279 +++++++++++++++++++++---------------------
 1 file changed, 139 insertions(+), 140 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 03624ca18afe..f5d1cb034338 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -292,162 +292,161 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 			ichar = cli_ch_process(cch, ichar);
 		}
 
-		/* ichar=0x0 when error occurs in U-Boot getc */
-		if (!ichar)
-			continue;
-
-		if (ichar == '\n') {
-			putc('\n');
-			break;
-		}
+	/* ichar=0x0 when error occurs in U-Boot getc */
+	if (!ichar)
+		continue;
 
-		switch (ichar) {
-		case CTL_CH('a'):
-			BEGINNING_OF_LINE();
-			break;
-		case CTL_CH('c'):	/* ^C - break */
-			*buf = '\0';	/* discard input */
-			return -1;
-		case CTL_CH('f'):
-			if (cls->num < cls->eol_num) {
-				getcmd_putch(buf[cls->num]);
-				cls->num++;
-			}
-			break;
-		case CTL_CH('b'):
-			if (cls->num) {
-				getcmd_putch(CTL_BACKSPACE);
-				cls->num--;
-			}
-			break;
-		case CTL_CH('d'):
-			if (cls->num < cls->eol_num) {
-				uint wlen;
+	if (ichar == '\n') {
+		putc('\n');
+		break;
+	}
 
-				wlen = cls->eol_num - cls->num - 1;
-				if (wlen) {
-					memmove(&buf[cls->num],
-						&buf[cls->num + 1], wlen);
-					putnstr(buf + cls->num, wlen);
-				}
+	switch (ichar) {
+	case CTL_CH('a'):
+		BEGINNING_OF_LINE();
+		break;
+	case CTL_CH('c'):	/* ^C - break */
+		*buf = '\0';	/* discard input */
+		return -1;
+	case CTL_CH('f'):
+		if (cls->num < cls->eol_num) {
+			getcmd_putch(buf[cls->num]);
+			cls->num++;
+		}
+		break;
+	case CTL_CH('b'):
+		if (cls->num) {
+			getcmd_putch(CTL_BACKSPACE);
+			cls->num--;
+		}
+		break;
+	case CTL_CH('d'):
+		if (cls->num < cls->eol_num) {
+			uint wlen;
 
-				getcmd_putch(' ');
-				do {
-					getcmd_putch(CTL_BACKSPACE);
-				} while (wlen--);
-				cls->eol_num--;
-			}
-			break;
-		case CTL_CH('k'):
-			ERASE_TO_EOL();
-			break;
-		case CTL_CH('e'):
-			REFRESH_TO_EOL();
-			break;
-		case CTL_CH('o'):
-			cls->insert = !cls->insert;
-			break;
-		case CTL_CH('w'):
-			if (cls->num) {
-				uint base, wlen;
-
-				for (base = cls->num - 1;
-				     base >= 0 && buf[base] == ' ';)
-					base--;
-				for (; base > 0 && buf[base - 1] != ' ';)
-					base--;
-
-				/* now delete chars from base to cls->num */
-				wlen = cls->num - base;
-				cls->eol_num -= wlen;
-				memmove(&buf[base], &buf[cls->num],
-					cls->eol_num - base + 1);
-				cls->num = base;
-				getcmd_putchars(wlen, CTL_BACKSPACE);
-				puts(buf + base);
-				getcmd_putchars(wlen, ' ');
-				getcmd_putchars(wlen + cls->eol_num - cls->num,
-						CTL_BACKSPACE);
-			}
-			break;
-		case CTL_CH('x'):
-		case CTL_CH('u'):
-			BEGINNING_OF_LINE();
-			ERASE_TO_EOL();
-			break;
-		case DEL:
-		case DEL7:
-		case 8:
-			if (cls->num) {
-				uint wlen;
-
-				wlen = cls->eol_num - cls->num;
-				cls->num--;
+			wlen = cls->eol_num - cls->num - 1;
+			if (wlen) {
 				memmove(&buf[cls->num], &buf[cls->num + 1],
 					wlen);
-				getcmd_putch(CTL_BACKSPACE);
 				putnstr(buf + cls->num, wlen);
-				getcmd_putch(' ');
-				do {
-					getcmd_putch(CTL_BACKSPACE);
-				} while (wlen--);
-				cls->eol_num--;
 			}
-			break;
-		case CTL_CH('p'):
-		case CTL_CH('n'):
-		{
-			char *hline;
 
-			if (ichar == CTL_CH('p'))
-				hline = hist_prev();
-			else
-				hline = hist_next();
-
-			if (!hline) {
-				getcmd_cbeep();
-				continue;
-			}
+			getcmd_putch(' ');
+			do {
+				getcmd_putch(CTL_BACKSPACE);
+			} while (wlen--);
+			cls->eol_num--;
+		}
+		break;
+	case CTL_CH('k'):
+		ERASE_TO_EOL();
+		break;
+	case CTL_CH('e'):
+		REFRESH_TO_EOL();
+		break;
+	case CTL_CH('o'):
+		cls->insert = !cls->insert;
+		break;
+	case CTL_CH('w'):
+		if (cls->num) {
+			uint base, wlen;
+
+			for (base = cls->num - 1;
+			     base >= 0 && buf[base] == ' ';)
+				base--;
+			for (; base > 0 && buf[base - 1] != ' ';)
+				base--;
+
+			/* now delete chars from base to cls->num */
+			wlen = cls->num - base;
+			cls->eol_num -= wlen;
+			memmove(&buf[base], &buf[cls->num],
+				cls->eol_num - base + 1);
+			cls->num = base;
+			getcmd_putchars(wlen, CTL_BACKSPACE);
+			puts(buf + base);
+			getcmd_putchars(wlen, ' ');
+			getcmd_putchars(wlen + cls->eol_num - cls->num,
+					CTL_BACKSPACE);
+		}
+		break;
+	case CTL_CH('x'):
+	case CTL_CH('u'):
+		BEGINNING_OF_LINE();
+		ERASE_TO_EOL();
+		break;
+	case DEL:
+	case DEL7:
+	case 8:
+		if (cls->num) {
+			uint wlen;
+
+			wlen = cls->eol_num - cls->num;
+			cls->num--;
+			memmove(&buf[cls->num], &buf[cls->num + 1], wlen);
+			getcmd_putch(CTL_BACKSPACE);
+			putnstr(buf + cls->num, wlen);
+			getcmd_putch(' ');
+			do {
+				getcmd_putch(CTL_BACKSPACE);
+			} while (wlen--);
+			cls->eol_num--;
+		}
+		break;
+	case CTL_CH('p'):
+	case CTL_CH('n'):
+	{
+		char *hline;
+
+		if (ichar == CTL_CH('p'))
+			hline = hist_prev();
+		else
+			hline = hist_next();
+
+		if (!hline) {
+			getcmd_cbeep();
+			continue;
+		}
 
-			/* nuke the current line */
-			/* first, go home */
-			BEGINNING_OF_LINE();
+		/* nuke the current line */
+		/* first, go home */
+		BEGINNING_OF_LINE();
 
-			/* erase to end of line */
-			ERASE_TO_EOL();
+		/* erase to end of line */
+		ERASE_TO_EOL();
 
-			/* copy new line into place and display */
-			strcpy(buf, hline);
-			cls->eol_num = strlen(buf);
-			REFRESH_TO_EOL();
-			continue;
-		}
-		case '\t':
-			if (IS_ENABLED(CONFIG_AUTO_COMPLETE)) {
-				int num2, col;
-
-				/* do not autocomplete when in the middle */
-				if (cls->num < cls->eol_num) {
-					getcmd_cbeep();
-					break;
-				}
+		/* copy new line into place and display */
+		strcpy(buf, hline);
+		cls->eol_num = strlen(buf);
+		REFRESH_TO_EOL();
+		continue;
+	}
+	case '\t':
+		if (IS_ENABLED(CONFIG_AUTO_COMPLETE)) {
+			int num2, col;
 
-				buf[cls->num] = '\0';
-				col = strlen(prompt) + cls->eol_num;
-				num2 = cls->num;
-				if (cmd_auto_complete(prompt, buf, &num2, &col)) {
-					col = num2 - cls->num;
-					cls->num += col;
-					cls->eol_num += col;
-				}
+			/* do not autocomplete when in the middle */
+			if (cls->num < cls->eol_num) {
+				getcmd_cbeep();
 				break;
 			}
-			fallthrough;
-		default:
-			cread_add_char(ichar, cls->insert, &cls->num,
-				       &cls->eol_num, buf, *len);
+
+			buf[cls->num] = '\0';
+			col = strlen(prompt) + cls->eol_num;
+			num2 = cls->num;
+			if (cmd_auto_complete(prompt, buf, &num2, &col)) {
+				col = num2 - cls->num;
+				cls->num += col;
+				cls->eol_num += col;
+			}
 			break;
 		}
+		fallthrough;
+	default:
+		cread_add_char(ichar, cls->insert, &cls->num, &cls->eol_num,
+			       buf, *len);
+		break;
+	}
 	}
 	*len = cls->eol_num;
 	buf[cls->eol_num] = '\0';	/* lose the newline */
-- 
2.42.0.582.g8ccd20d70d-goog

