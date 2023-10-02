Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2B5E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F422C87143;
	Mon,  2 Oct 2023 03:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RWv2+9//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D4DB87100; Mon,  2 Oct 2023 03:14:06 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E79E986D5E
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:13:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79f95439795so56189339f.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209237; x=1696814037; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zI5jJ39lOYx5g7LlLMh4JrBUdULx+HosjT0+JAuMN+8=;
 b=RWv2+9//4JLutTCVNlt9rRbz5ek0ZC+3Z2MLmAo5T8EOAvk1YqHmwjtzraCzlqqY/Y
 UL2x9KKWECZkToo6qyuaIpHZiR8HuybG0tsZG+lMakhlAQlD0vZ8wZnR9pHYPINnRiBo
 w7qnaD7W/2HXrrRZacwXVJQCUBHvmkIWSdAyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209237; x=1696814037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zI5jJ39lOYx5g7LlLMh4JrBUdULx+HosjT0+JAuMN+8=;
 b=jlBkYEEkXAAhAiPlWBpTDnW8Vxq63m8FjPoeYy7GyTKeEuyEBUcj30gNWeRZsqMJO5
 mgeooLk02mH6w+jv4ovXw3b9dle2SmVKBoVhF2YTMOPGuCo1n3f2c0dFPwQkUcpHyWhU
 ZQ6CVV66A5MejutT2fkQlFUBeQy5okapqObap+JG7ddqgwK/2ZVDWixN7WpWHpO/expD
 NoAW6dXm6p4pOP7wEbHnV6sjyihfoP9fJNVSOFgYnZjhof3iYTpcLwWc3tpIe8knSbXF
 t4EJ430IxxmmewF4HtyqCLRARLJyOWbtdz1a25cGvHM8fB4sj3zoMW8wrSXtxnzqZKSi
 Cnhw==
X-Gm-Message-State: AOJu0Yx97rNCzYX6x53/R7DY15E7xE4upnZvpZ1pfJ+b7I+/tjNO/cO1
 mLGxnuaWf/n/HxCo79CLQTRYjFYV/r9hHesplv8=
X-Google-Smtp-Source: AGHT+IEPfGd7vMdCEOS4Ig3bShlcHr80C7WswiMNeTnAyv1j3F+Akue/mzcGdKbxsoLNzTNGtsbdMA==
X-Received: by 2002:a05:6602:2763:b0:791:ad01:3f3e with SMTP id
 l3-20020a056602276300b00791ad013f3emr8030662ioe.0.1696209237454; 
 Sun, 01 Oct 2023 18:13:57 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:13:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 05/36] cli: Implement delete-word in cread_line()
Date: Sun,  1 Oct 2023 19:13:09 -0600
Message-ID: <20231002011349.461284-6-sjg@chromium.org>
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

The Ctrl-W option is implemented in the cread_line_simple() but not in
the full version. This seems odd, so add an implementation.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 common/cli_readline.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/common/cli_readline.c b/common/cli_readline.c
index 458e927e4922..687e239bfa77 100644
--- a/common/cli_readline.c
+++ b/common/cli_readline.c
@@ -89,6 +89,14 @@ static char hist_lines[HIST_MAX][HIST_SIZE + 1];	/* Save room for NULL */
 
 #define add_idx_minus_one() ((hist_add_idx == 0) ? hist_max : hist_add_idx-1)
 
+static void getcmd_putchars(int count, int ch)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		getcmd_putch(ch);
+}
+
 static void hist_init(void)
 {
 	int i;
@@ -337,6 +345,29 @@ static int cread_line(const char *const prompt, char *buf, unsigned int *len,
 		case CTL_CH('o'):
 			insert = !insert;
 			break;
+		case CTL_CH('w'):
+			if (num) {
+				uint base;
+
+				for (base = num - 1;
+				     base >= 0 && buf[base] == ' ';)
+					base--;
+				for (; base > 0 && buf[base - 1] != ' ';)
+					base--;
+
+				/* now delete chars from base to num */
+				wlen = num - base;
+				eol_num -= wlen;
+				memmove(&buf[base], &buf[num],
+					eol_num - base + 1);
+				num = base;
+				getcmd_putchars(wlen, CTL_BACKSPACE);
+				puts(buf + base);
+				getcmd_putchars(wlen, ' ');
+				getcmd_putchars(wlen + eol_num - num,
+						CTL_BACKSPACE);
+			}
+			break;
 		case CTL_CH('x'):
 		case CTL_CH('u'):
 			BEGINNING_OF_LINE();
-- 
2.42.0.582.g8ccd20d70d-goog

