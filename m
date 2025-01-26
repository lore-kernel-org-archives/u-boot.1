Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B42AC0218D
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC2E7810E7;
	Sun, 26 Jan 2025 19:44:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eFrIXM1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A9C7810E6; Sun, 26 Jan 2025 19:44:23 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F61A80FD4
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-844e7bc6d84so119926939f.0
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917058; x=1738521858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u4fvhy0ZB3NZd6nGhDWz9pffU2GshLJ3ZwFptFZSdUE=;
 b=eFrIXM1N13ILFfoYAQ/sOqRyDoxyiUPRqXrdjGRwXJNW9Pm16AxBnr3Ootwl05R8ED
 r2y3QZ3Z3lZ8Kh7zi5SVVDlrszA4eKihhTYrCsl1APtYMP7moYM8sE+sWflFEWsfGrFz
 EpzdTPUgxNZXE/JemGc1UIdl0bNy9xpQHaLnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917058; x=1738521858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u4fvhy0ZB3NZd6nGhDWz9pffU2GshLJ3ZwFptFZSdUE=;
 b=H/tnDZ5ZzVyclUM2xNaw0PzPni807NAeUIO4VNewthYcfKzZSYwwnJl5HvaEYgIKo2
 lJJje0g47Cl19hX7fzD7HcuKjRoFaxWIChNrBhgwi1OWmXvh5piDv7P+SE+2PqI2/ikS
 qiKkYO2hlXU8Pxvyr+zq7T0augr3xHJYvs8B148KTGak3xM1y19YBtsbyE+k6iR06Y6+
 8HSv2xGMUkW2wy+3Q3hdhzFa1TXsmC5MnysFKhIJlwTYublKoXlw8NpSWJDYhFD72CMg
 +dU2RDEFaPY8eCAvg4uIrKS6dVtGpE/qSeBX0k+OX+qjI/QrRgw1jvjfpvTLT9GdtmTI
 0GYg==
X-Gm-Message-State: AOJu0YxkdoM1VS+nZuSlNcOSEDqX5kWGIkSLwJ9VtB6D8tnUtUSCLiJm
 yPnxhgs+fxki1xD6c1eZtFdakmpmCV8NnVhQRG3nuMkO/lvs78odCusisGzOBy+Vyln80hbyYMY
 =
X-Gm-Gg: ASbGncsExjuCiwvs4z1B9nYDvomrRsYnn69y+H+gnTFt+0IK3vfaZ1qrw9rl+2eoBV7
 mJuSYZhm+/kbIAPtHngO3UrPcN8jX9szjTU4dFFr/Wjb3pFvSOEgpKjgJJBBQVLRkiuOJmq2wsd
 3oqt33V48WChNVytt/TxCu+X97O2czsSN9AagqmgzS5qnOyFgkPOQXXdBV4oabRmiZZ8MXLpldK
 YYtmU1Cjlb1p/18ceaftNMJ7cqdzIceVwUVDyg5AURX01dp5kXf66SHsT71tiwfS1Te52Rt/LGN
 iEOjk9951lXzGkt1s+WivOVmrzQeRmGaFyV3NWAKyw==
X-Google-Smtp-Source: AGHT+IG0SneFdnoXeI7JFmvxxGN0NzG4Dmx9SJ1L2a43UUVe85lbsdrYhp1LRIfYQwVyPls//7SZaQ==
X-Received: by 2002:a5e:d804:0:b0:82c:ec0f:a081 with SMTP id
 ca18e2360f4ac-8521e32b142mr780916439f.4.1737917058057; 
 Sun, 26 Jan 2025 10:44:18 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:16 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 14/19] lib: Mark gunzip as relocation code
Date: Sun, 26 Jan 2025 11:43:24 -0700
Message-ID: <20250126184333.4058848-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

Mark the gunzip code as needed by relocation. This is used to decompress
the next-phase image.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/gunzip.c       |  9 +++++----
 lib/zlib/inflate.c | 18 ++++++++++--------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/lib/gunzip.c b/lib/gunzip.c
index e71d8d00ccb..52007715bda 100644
--- a/lib/gunzip.c
+++ b/lib/gunzip.c
@@ -15,6 +15,7 @@
 #include <u-boot/crc.h>
 #include <watchdog.h>
 #include <u-boot/zlib.h>
+#include <asm/sections.h>
 
 #define HEADER0			'\x1f'
 #define HEADER1			'\x8b'
@@ -43,7 +44,7 @@ void gzfree(void *x, void *addr, unsigned nb)
 	free (addr);
 }
 
-int gzip_parse_header(const unsigned char *src, unsigned long len)
+__rcode int gzip_parse_header(const unsigned char *src, unsigned long len)
 {
 	int i, flags;
 
@@ -71,7 +72,7 @@ int gzip_parse_header(const unsigned char *src, unsigned long len)
 	return i;
 }
 
-int gunzip(void *dst, int dstlen, unsigned char *src, unsigned long *lenp)
+__rcode int gunzip(void *dst, int dstlen, unsigned char *src, unsigned long *lenp)
 {
 	int offset = gzip_parse_header(src, *lenp);
 
@@ -274,8 +275,8 @@ out:
 /*
  * Uncompress blocks compressed with zlib without headers
  */
-int zunzip(void *dst, int dstlen, unsigned char *src, unsigned long *lenp,
-						int stoponerr, int offset)
+__rcode int zunzip(void *dst, int dstlen, unsigned char *src,
+		   unsigned long *lenp, int stoponerr, int offset)
 {
 	z_stream s;
 	int err = 0;
diff --git a/lib/zlib/inflate.c b/lib/zlib/inflate.c
index f7e81fc8b2a..b4c72cc2c5c 100644
--- a/lib/zlib/inflate.c
+++ b/lib/zlib/inflate.c
@@ -2,10 +2,12 @@
  * Copyright (C) 1995-2005 Mark Adler
  * For conditions of distribution and use, see copyright notice in zlib.h
  */
+#include <asm/sections.h>
+
 local void fixedtables OF((struct inflate_state FAR *state));
 local int updatewindow OF((z_streamp strm, unsigned out));
 
-int ZEXPORT inflateReset(z_streamp strm)
+__rcode int ZEXPORT inflateReset(z_streamp strm)
 {
     struct inflate_state FAR *state;
 
@@ -30,8 +32,8 @@ int ZEXPORT inflateReset(z_streamp strm)
     return Z_OK;
 }
 
-int ZEXPORT inflateInit2_(z_streamp strm, int windowBits,
-			  int stream_size)
+__rcode int ZEXPORT inflateInit2_(z_streamp strm, int windowBits,
+				  int stream_size)
 {
     struct inflate_state FAR *state;
 
@@ -67,12 +69,12 @@ int ZEXPORT inflateInit2_(z_streamp strm, int windowBits,
     return inflateReset(strm);
 }
 
-int ZEXPORT inflateInit_(z_streamp strm, int stream_size)
+__rcode int ZEXPORT inflateInit_(z_streamp strm, int stream_size)
 {
     return inflateInit2_(strm, DEF_WBITS, stream_size);
 }
 
-local void fixedtables(struct inflate_state FAR *state)
+__rcode local void fixedtables(struct inflate_state FAR *state)
 {
     state->lencode = lenfix;
     state->lenbits = 9;
@@ -94,7 +96,7 @@ local void fixedtables(struct inflate_state FAR *state)
    output will fall in the output data, making match copies simpler and faster.
    The advantage may be dependent on the size of the processor's data caches.
  */
-local int updatewindow(z_streamp strm, unsigned out)
+__rcode local int updatewindow(z_streamp strm, unsigned int out)
 {
     struct inflate_state FAR *state;
     unsigned copy, dist;
@@ -322,7 +324,7 @@ local int updatewindow(z_streamp strm, unsigned out)
    when flush is set to Z_FINISH, inflate() cannot return Z_OK.  Instead it
    will return Z_BUF_ERROR if it has not reached the end of the stream.
  */
-int ZEXPORT inflate(z_streamp strm, int flush)
+__rcode int ZEXPORT inflate(z_streamp strm, int flush)
 {
     struct inflate_state FAR *state;
     unsigned char FAR *next;    /* next input */
@@ -924,7 +926,7 @@ int ZEXPORT inflate(z_streamp strm, int flush)
     return ret;
 }
 
-int ZEXPORT inflateEnd(z_streamp strm)
+__rcode int ZEXPORT inflateEnd(z_streamp strm)
 {
     struct inflate_state FAR *state;
     if (strm == Z_NULL || strm->state == Z_NULL || strm->zfree == (free_func)0)
-- 
2.43.0

