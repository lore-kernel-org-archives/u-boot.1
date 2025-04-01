Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F29BC36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:30:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7FB982027;
	Tue,  1 Apr 2025 19:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Xhg1vNKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF88281FC8; Tue,  1 Apr 2025 19:30:12 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31FFA81F7E
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-301302a328bso9983350a91.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528608; x=1744133408; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sNblkeO7DtYMaQHnKmjUAZnkA06RZVRs7XxY43jhM4Q=;
 b=Xhg1vNKZU45kSLNsGGPyoVSU1554XSaOi5UnFnHmYUP/EhI+Y9O9CMT0noLtqq07SR
 lUiw0r/+gdGpItXJqHcOjVeW5qZPkaa24yRDiwKYwNAvI6L+d+8b4m57u5ReilwbghLR
 74Uv5L2Ke7G0V9T7yrhDa5OV+J46eyp6p/hTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528608; x=1744133408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sNblkeO7DtYMaQHnKmjUAZnkA06RZVRs7XxY43jhM4Q=;
 b=P5OKGoWgPvjbBo1CItAYhNF6e8uIO5sw81AYND0sEIYFWTu6e9Q+iDVww918ZGA48c
 WTf2RKy7bESUkFL6AuOiRdnov4NwaTvWtvIikZghWpbAK6k4ECFR5UyMJoO/H49PGcYX
 rMjFVyuGhMDTHZOj2Rc9wvr4h+tGhlvDZmsqpWaCnZj6nU29kscKdLxvAjtbfM4IAKsa
 +ES/fFYVjhuCZg8LnlurhBA6AbEFauL9G9U5xdIQBeEzIB8JDyYp0nItFqLPswZsE01S
 3l2uvz8GypMwgcxhd2J0ueEIu6zSoMQXOeB14EvpyLg8rGl5VQoF7Nl1EeqVroeMBmQ+
 84oA==
X-Gm-Message-State: AOJu0Yweb6sFu3qESKgEvP1F9nQVEY8cxWQDfDOkgdx6jM0zMk1ho/MJ
 WBv3kyxFghP4iGcVIyOTbQ//SZV9eVOUnaYzyEvVttF5qVjmN6fV54P9NcQ61g2GhKU0WGgMmfq
 G1A==
X-Gm-Gg: ASbGncsJxCgqfW2PwXRCH43rgSC26yn08aNiXHqwrRfdwCQoMYBQKLQth7zMqs8/7gz
 ARJ2nyOOG0W7qDeOlTM3htV5K/DveF11OUDDsN22mTskb4vFqLCoC/Nh3Xjjb6w6OySY9ybESsS
 Bcx03qigeWAAYJBvu6X/Q1YB0zRWFxPSLUcB+p6Hv3wyYRRMp3pj6QXLmAgsb9/Gr59Gw7OisSu
 AaGCK9OSV9uHrMLSoUkR4fvzmiAzNyUZe3e0OAjENKQmUku1dhswnZTdsbkEwfbfKgs/d33gWYW
 e10e35n5KivZYgPBpBAg6DSyuIYaz6DN/uiXSprdWoo=
X-Google-Smtp-Source: AGHT+IG9a/CXXQCNlp7Dz+R3nW8lC1aotZv4yw+beJTzmBlGlLIdBNkxII41Br2Be1LhdxI+hjuZmg==
X-Received: by 2002:a17:90b:2e07:b0:2ee:53b3:3f1c with SMTP id
 98e67ed59e1d1-30531f7c07cmr20260572a91.5.1743528607774; 
 Tue, 01 Apr 2025 10:30:07 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:30:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/13] console: Support a format string for stderr output
Date: Wed,  2 Apr 2025 06:29:32 +1300
Message-ID: <20250401172948.1236000-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401172948.1236000-1-sjg@chromium.org>
References: <20250401172948.1236000-1-sjg@chromium.org>
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

