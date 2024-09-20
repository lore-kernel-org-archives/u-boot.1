Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D8CCF58E2
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C60B893D7;
	Fri, 20 Sep 2024 09:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OiljHBC0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4EF8893CF; Fri, 20 Sep 2024 09:25:06 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 859C1893AB
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cbc38a997so10629565e9.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726817104; x=1727421904; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yVuC+btv1ynKm1nlD+gPhEXMetVG6avPIPo7AET1HKw=;
 b=OiljHBC063mdWSycI3f3cvOZEK9iKA3YPXQX7TOopgcpY09dpd1OIxWNmqCWPn4OwD
 KbUbWfkWXYiE0HdTigjxZyIR0567wceRSSRvJtGUbOM9Y3j1sLr2fMvP5IeXIDV4tAof
 imbGWkadbLIXI4LHzYtETQ0JvaRryGnghsWjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817104; x=1727421904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yVuC+btv1ynKm1nlD+gPhEXMetVG6avPIPo7AET1HKw=;
 b=P8mtjR3e8GjyKCiEM7tizuhBtciEH3WI5c26s+tMc+CJLe4KtQWGGmtAD08cnXvbJb
 q7fH2GJbh4zfEVJnLwWsZc91hmXNfEROQq3jF/ZUWlW5/NgkZC9hjoYrmSNRtIT8n+pU
 INbm8dhxPIVO923BRzwfsUdWAXW8tR6YjD3b/Z2C529ckHwQJf0wG4kkmnoIjS/2cFI/
 5roWiWlvtI0Wd+I5g07A+BaY+QEw5D28XWSm7PUZ0vShaWhoPRsgGN68bqPIJF++yCDK
 bhlUXVtDQfVwdEGTirupANnSopQ458bpF0NgTawzWM/2vvh55lmm40KZcSN6VYBtiYto
 pw8g==
X-Gm-Message-State: AOJu0YxD2uDDDpD61InnyrxNMY0UNgMVWBwxs7fc5yer72PuOxkT6Ccc
 sRga5hXM4+/F4WkuI0j0Jb6CW/h6VNfdobbXqOyaSKFJco8GgfQ8GVc7nwghTFO5tCV6BiUDNmS
 J1mI/
X-Google-Smtp-Source: AGHT+IGPvM0nuposlWiyZNrqFkl02koD/TYGZUlFDVzRnMxEi3ZCI/p4IdQlm+tSoNXGGQ1EaJJ/XQ==
X-Received: by 2002:a05:600c:524f:b0:42c:b697:a62c with SMTP id
 5b1f17b1804b1-42e74406528mr35462155e9.5.1726817103661; 
 Fri, 20 Sep 2024 00:25:03 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7540e32fsm41504535e9.9.2024.09.20.00.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 00:25:03 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 05/18] tiny-printf: Correct return values
Date: Fri, 20 Sep 2024 09:24:29 +0200
Message-ID: <20240920072444.134997-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920072444.134997-1-sjg@chromium.org>
References: <20240920072444.134997-1-sjg@chromium.org>
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

The sprintf() etc. functions are supposed to return the length of the
string written, but do not. Fix this by checking the amount of buffer
space used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/tiny-printf.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/lib/tiny-printf.c b/lib/tiny-printf.c
index 9a70c6095b3..64dee779c4a 100644
--- a/lib/tiny-printf.c
+++ b/lib/tiny-printf.c
@@ -365,16 +365,15 @@ int sprintf(char *buf, const char *fmt, ...)
 {
 	struct printf_info info;
 	va_list va;
-	int ret;
 
 	va_start(va, fmt);
 	info.outstr = buf;
 	info.putc = putc_outstr;
-	ret = _vprintf(&info, fmt, va);
+	_vprintf(&info, fmt, va);
 	va_end(va);
 	*info.outstr = '\0';
 
-	return ret;
+	return info.outstr - buf;
 }
 
 #if CONFIG_IS_ENABLED(LOG)
@@ -382,14 +381,13 @@ int sprintf(char *buf, const char *fmt, ...)
 int vsnprintf(char *buf, size_t size, const char *fmt, va_list va)
 {
 	struct printf_info info;
-	int ret;
 
 	info.outstr = buf;
 	info.putc = putc_outstr;
-	ret = _vprintf(&info, fmt, va);
+	_vprintf(&info, fmt, va);
 	*info.outstr = '\0';
 
-	return ret;
+	return info.outstr - buf;
 }
 #endif
 
@@ -398,16 +396,15 @@ int snprintf(char *buf, size_t size, const char *fmt, ...)
 {
 	struct printf_info info;
 	va_list va;
-	int ret;
 
 	va_start(va, fmt);
 	info.outstr = buf;
 	info.putc = putc_outstr;
-	ret = _vprintf(&info, fmt, va);
+	_vprintf(&info, fmt, va);
 	va_end(va);
 	*info.outstr = '\0';
 
-	return ret;
+	return info.outstr - buf;
 }
 
 void print_grouped_ull(unsigned long long int_val, int digits)
-- 
2.43.0

