Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AF5CE79A8
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 18:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFDB286BD9;
	Tue, 19 Sep 2023 20:09:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DxGk90Mr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D1C86BD5; Tue, 19 Sep 2023 20:09:38 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E986C86BD6
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:09:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34fc77a6de2so13668195ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 11:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695146974; x=1695751774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k+kEO6RAdzWe7ofAMcV5FSz/QrpZi8ELuK9KNc3o00g=;
 b=DxGk90MrDhn7rQAewMpMa/dAB4dY7kZpWb0H/yWXsckbwysQbdk2si9PgNwbhHjFvV
 Ccft5brxgQe6FUp4vG2mp0hzwr77NKUzRk1dBrZDyfJIlYAk9XYU/GyQAmZIvyhx1NRf
 y8OtT7X8J+WpicaODR/0HEkUDVfJGyxCOKwVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695146974; x=1695751774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k+kEO6RAdzWe7ofAMcV5FSz/QrpZi8ELuK9KNc3o00g=;
 b=fKyNqDRGI0ApfvAIzv2mnIXE1P/9mb2SJakabkX3Dqx3vvDaYd/3QQRhqeW/BYDtzR
 Vu0Hj3osFa7kgLhoKzljjPOyNRDiZCQWLlQA4QI0u1USbdzuQt+nltsmE7HRPheSUraQ
 iVL1KvlVZdNtWY9S5xhtEYTcMZM87a+NUTYwWnO06y6pJYAfzuG38xtIGGuSIQofp319
 xiQHEBRcL2XhgsUDgqdp9OYC/Q38fkzbfg10/U2ai4YKmV5/DzKWtIPFWBfopFyGk+LM
 XyfxagW1mpmkH3VRpOJb9Ae/LKi8JD7kaU+v/f/g7KUV5a1pR+IKOFKaSJwFInONBkJt
 alcg==
X-Gm-Message-State: AOJu0YzH4H0/LveQlY/lRDTGqUrWlU0O7g/iraRdZaRXcEihtXFL5tNC
 sVfZmxas0RI4zmbHJQa65/g0vM76eqXd5OwrjIE=
X-Google-Smtp-Source: AGHT+IHnLelJvd/BclB9ZEjbLfzVGtjCXS+kgrOlmlYwbqgXn3Ka0BCgjsREXzij0JqQNaFvHaWD+g==
X-Received: by 2002:a05:6e02:3201:b0:350:f3a7:b76a with SMTP id
 cd1-20020a056e02320100b00350f3a7b76amr588894ilb.11.1695146974510; 
 Tue, 19 Sep 2023 11:09:34 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:5337:a30a:1478:27f0])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a056e020c8900b0034e1092bccfsm3885352ile.80.2023.09.19.11.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 11:09:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH 08/36] cli: Unindent some code in cread_line()
Date: Tue, 19 Sep 2023 12:08:38 -0600
Message-ID: <20230919180918.2904313-9-sjg@chromium.org>
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

Reduce the indentation level of this code so it is easier to review the
next patch, which moves it into a function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/cli_readline.c | 279 +++++++++++++++++++++---------------------
 1 file changed, 139 insertions(+), 140 deletions(-)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 03624ca18af..f5d1cb03433 100644
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
2.42.0.459.ge4e396fd5e-goog

