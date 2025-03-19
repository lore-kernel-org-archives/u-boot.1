Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A158BC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:57:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2B282027;
	Wed, 19 Mar 2025 15:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N+HVO3me";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78DD081FFC; Wed, 19 Mar 2025 15:55:47 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D5E181EC9
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso34202315e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396144; x=1743000944; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNblkeO7DtYMaQHnKmjUAZnkA06RZVRs7XxY43jhM4Q=;
 b=N+HVO3menri2wwnZxlyK+C0/IhJK17gIEX/AvI+t0ylLBccsxRJvjIxJqUwVl6xI8R
 JBlmkuFAnXi7Jr14Gq3ZbMh5SwQqza4aDzCsJZYoWc7h7fuvxIH0Rqzvbx/R2Tr27n89
 1Dz9jo6BTjnrHLtq+bjOBC8xbISHNaFrtN3L4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396144; x=1743000944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNblkeO7DtYMaQHnKmjUAZnkA06RZVRs7XxY43jhM4Q=;
 b=tVrHveJ95+jueotzBVQ2loJYjYRsP4ldxlY5eQI5By24Fg+z1EkztPD2J1IcjvMKc7
 QddhT77Mzl+mCfkBzgtLhsDJjKqyS5CnMEmlXWVTEPYlQ9T65ICk2zJXioGbnIknuMep
 QhZ+X/ZBj5nkeJ6Ne3ZrKEvFhJOz3hjXMMnhJYmOSpV8kXQXNmpH0KP6tMtBXBclV8jP
 eYBsVVPpSRsW/jyNs4um3VKfXoUs+w3oRCPZBm9eujZJ1gsZk8fa+wvtUwORA+qG5CUf
 qYtw6c7aoECVor8ktUlyZG5NzJMzWLWWrrkOpxZ+HzlRxHhPwvkXs+b3LiE3IfQ31y9D
 AQRQ==
X-Gm-Message-State: AOJu0YyGEprdx102lV3k1tT03a+Ee/yyUNAPHVHwKa1W3cGXjQbui89A
 weweBXVgIejqePV4QIbUUf7wkz5UkykXD2Izu7CD7HUDF1Ve3Bd6o/OzUAWZKjfjH6KYRKXbbjk
 =
X-Gm-Gg: ASbGncthcVhmjUDE9P70zpPFItyKlrRCfpniNhQq+m1iKVU8WjA6l/VhQg9fHW90kh/
 YXxD1NwmVKfNZrSfXTL1lrEQ29rjThI1sq+Zx1O5mY79PmJLM8sFpcirEb6oxnL9erWv46RgQJ4
 NB7Nn/TQIH/C23/S1sUUFiWUUg3KWUFl6ryRdPnhl4DO5XI2qNt2agL2wU4VXBFrDy2Ey6F7dig
 GRCRcldMqOT8kxpUa/z8tu3AYwVo9vJhwToiFa1W0kS9dSMsX6/Yi8ZDq87JO/uFrWdi9+Tc7ms
 33HmH8mKK7fdK+BSTqr+RGxG4ZLxvEQKHAmnJpBZKQ==
X-Google-Smtp-Source: AGHT+IHpt/O8MbWltUlopWd6xxXgRrXCerDotvKsxhp2U07/BDYbV1MTQGVlLUCwecbapz7Hf8w5yw==
X-Received: by 2002:a05:600c:870f:b0:43c:f00b:d581 with SMTP id
 5b1f17b1804b1-43d43880eb4mr31119775e9.29.1742396144241; 
 Wed, 19 Mar 2025 07:55:44 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/52] console: Support a format string for stderr output
Date: Wed, 19 Mar 2025 15:54:14 +0100
Message-ID: <20250319145512.2391122-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

Add a console_printf_select_stderr() function so that it is not
necessary for the caller to process the format string.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/console.c  | 18 ++++++++++++++++++
 include/console.h | 15 +++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/common/console.c b/common/console.c
index 3362a32a7a0..c6dfed6e201 100644
--- a/common/console.c
+++ b/common/console.c
@@ -359,6 +359,24 @@ void console_puts_select_stderr(bool serial_only, const char *s)
 		console_puts_select(stderr, serial_only, s);
 }
 
+int console_printf_select_stderr(bool serial_only, const char *fmt, ...)
+{
+	char buf[CONFIG_SYS_PBSIZE];
+	va_list args;
+	int ret;
+
+	va_start(args, fmt);
+
+	/* For this to work, buf must be larger than anything we ever want to
+	 * print.
+	 */
+	ret = vscnprintf(buf, sizeof(buf), fmt, args);
+	va_end(args);
+	console_puts_select_stderr(serial_only, buf);
+
+	return ret;
+}
+
 static void console_puts(int file, const char *s)
 {
 	int i;
diff --git a/include/console.h b/include/console.h
index 57fdb0834c1..8d0d7bb8a4c 100644
--- a/include/console.h
+++ b/include/console.h
@@ -169,6 +169,21 @@ int console_announce_r(void);
  */
 void console_puts_select_stderr(bool serial_only, const char *s);
 
+/**
+ * console_printf_select_stderr() - Output a formatted string to selected devs
+ *
+ * This writes to stderr only. It is useful for outputting errors. Note that it
+ * uses its own buffer, separate from the print buffer, to allow printing
+ * messages within console/stdio code
+ *
+ * @serial_only: true to output only to serial, false to output to everything
+ *	else
+ * @fmt: Printf format string, followed by format arguments
+ * Return: number of characters written
+ */
+int console_printf_select_stderr(bool serial_only, const char *fmt, ...)
+		__attribute__ ((format (__printf__, 2, 3)));
+
 /**
  * console_clear() - Clear the console
  *
-- 
2.43.0

