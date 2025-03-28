Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D289C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:08:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DB4C81E72;
	Fri, 28 Mar 2025 14:07:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AmIz6jYg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 514A681F95; Fri, 28 Mar 2025 14:07:40 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21FA581EC5
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-854a682d2b6so154118139f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167256; x=1743772056; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcBCcvRzIsSB+59lJQn/uQ2gmD2WffFKx8H7Ksbre50=;
 b=AmIz6jYg63eBmQFGyA7DpFu7sXtrGUJP65jPd95DltpN1sKYCFGdXAQF7U40oWRk02
 jauFRghrX1y6Xl/qf/+R9SUdZrrGdSoOoilAyOkK6hXHjuTrePiFPG2iY1xcAA2T1ZBB
 vFO2nJ2ICtvnQduhx8ffRPBes82zw7LuZsw8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167256; x=1743772056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QcBCcvRzIsSB+59lJQn/uQ2gmD2WffFKx8H7Ksbre50=;
 b=OFlZXavULXLbvcMieILVCF6O88Q+zqGJhNnJo4peLg/4maKlub+di7RrYwbxAo+tcT
 2wQnjdOQ09B1CL2zgmlVTkH+Qt5HuRAM1dgJG5mjOKThA1dk7vS2JYgHKOB7lXHrMRt+
 JuwBHj3QpzJr14ZkCInJ+SsoY2i4TWz58Ovk9xaxPyZ50f8laixr89V48sg+VQtf03pX
 PuQxU0dY+dRvQ/NO97xd+tN2Gx9OYh+gbBU4YNPNgm5JcO7O2XAfasZPk/AvtmrhUlaO
 PydjNo7yc2JVwAwL/UUzimmKUXkGHseilgoXkOpPj5aa1TNNccSL0khw8OO8M/scKE6D
 hxbQ==
X-Gm-Message-State: AOJu0Yw16rGNvS2PpFkDsVFsP8n2N6s5KqqiHqi4ICER6alxGaz6axsS
 Me649CtGJfuuZieTd76fkCyMqGVmeuX8IeFWiEJoZL6ugJV2hADZlsIVdTnF9TUQeTv2qY9j7/g
 =
X-Gm-Gg: ASbGnctuhhR6wK+sEczZqZ34bQ5aBaZz4VWhJPdltp57OAoi3e7ysLNlbBAJMdV6vhp
 QdzvYBtUcUh01a1UNU1OXLaiohbJthD5YCAzHqQFuuty2DN8BxV63eSbNaWl/PPnx+v8OLsF82a
 0CHmlx9wm3/ZtsHPJj6GXM+ZF5rUMrPG9JPJYzA6iY4CM02CXNHC6smJ2J8PBlMswQkayApF11a
 ImNeS+MHO9qHfplkwE69QwMmlKQwBdOvYn6LZ8gYj1Ll3CiCwqZZCxbpXvPEgOzvrfe8iOt34Hn
 BCF0Rtahh4b5Q/h6dSqZ8DQHxsqskcKlCu/aALFsvdqfvsjjYpYrBt0bVXzUjFIeDSfJ9jHz4Kd
 ZXe6vwg==
X-Google-Smtp-Source: AGHT+IE7kCgsV9URd3eU76KvetbU2iqsXQpCC/wDNCWs3oR7xg5AyvAmKzDiEz70k5mCZQvGmtorDw==
X-Received: by 2002:a05:6602:7286:b0:85b:41cc:f710 with SMTP id
 ca18e2360f4ac-85e821736e5mr926386239f.12.1743167255583; 
 Fri, 28 Mar 2025 06:07:35 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 09/56] console: Support a format string for stderr output
Date: Fri, 28 Mar 2025 07:05:56 -0600
Message-ID: <20250328130713.2612648-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

(no changes since v1)

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

