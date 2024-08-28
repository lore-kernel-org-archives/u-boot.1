Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42146C54746
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 01:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E58A88BC2;
	Wed, 28 Aug 2024 03:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RG585U/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B757F88B6A; Wed, 28 Aug 2024 03:45:55 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F18688B31
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 03:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-829e3fbcb87so104244439f.0
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 18:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1724809552; x=1725414352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4c0lYY7lflfvAWBfHq0G+QNbnHLtNNqw2NZPiOzAjo=;
 b=RG585U/rBp+vLJHmaYHoxILaJkpSC6fjiMJbzWwdw0sop8YWtca5Y4QOhjxkdON5Q7
 oNi0F+gJKvuQtlx0zQZAozX0hxpAEU6Bg6aXjsjsyX7b/RcwH73TiLHJgebRopua/xzB
 7Av0Phs/xNI0mT0LsD8seZ6i9YfFq7h9Nwe9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724809552; x=1725414352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e4c0lYY7lflfvAWBfHq0G+QNbnHLtNNqw2NZPiOzAjo=;
 b=Xin5heR+MzKybYJEq6VNxSEZqA4R0VoRXVhtiSqSgPdpgPbaoIwF8MhqU7mgDlhXPK
 rgpnvW00MM7cwtfLfv8UyExxCyJrvi9/mTTlwpgg6WtAA27ZyrmYOXrP3d9mqdd2G3j2
 kYWbaAw3HDRiLveXV5T+6vovde6rLxsthsRW1t0GBz2HqH7sXX1RQzIQr0FHSPms0UEN
 1hAyyQh3JwTZNyLFwN9QBlEyWKmGdTNIvZqh5q/ILf2DwF/VXbkRnrpssT54LKfRrk2R
 Kt1yKHLM2U+S9cvzLAzq861UoFoXHe/NS2yt0j23OJ2SoyDpOwu/+hN8JslPrBKleGUM
 Qnkw==
X-Gm-Message-State: AOJu0Yygh2xAioZd0ly/02V0gzTHvXg3LGmPcPh8pw47PM6MEt2UH6Nc
 x0DIYC2RSZKbbyCoIQHyT+nhQJfbyf2sF7n69JNrug532SepvpKmQh9mFO+n2RmYT9/xnLHqqgk
 =
X-Google-Smtp-Source: AGHT+IEmVL8WqLhXTUY3P0ZTCAOiOo+qHuTwXP1w107JPMPInFWE6qVhaKzvKryUKBNfg06ZzMQ91g==
X-Received: by 2002:a05:6602:1655:b0:7f6:2d58:8d6a with SMTP id
 ca18e2360f4ac-8278731c7ecmr1558744239f.7.1724809551679; 
 Tue, 27 Aug 2024 18:45:51 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ce70f5ca7csm2898342173.63.2024.08.27.18.45.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 18:45:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/18] tiny-printf: Correct return values
Date: Tue, 27 Aug 2024 19:45:24 -0600
Message-Id: <20240828014538.3322013-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828014538.3322013-1-sjg@chromium.org>
References: <20240828014538.3322013-1-sjg@chromium.org>
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
2.34.1

