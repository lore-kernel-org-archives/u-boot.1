Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68361C282DE
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 19:15:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A14A381A02;
	Thu, 13 Mar 2025 20:14:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1741893277;
	bh=HEc/xkdC26uUtnVXjZxIPqPfTceUN5mXmSNcNHzAQb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lxCHvqTs2YwHWIIOJGPMyYvjABnE8tFp4BD5SdrR4xsL9RBEHrCvAqIE01MMe/nVI
	 FQ/ZXW615uyZRzYj6Rr/loIdXXMkrHwq3OIYXDkEoUfbDZKJA1cAPmDOSaWRv1R9M1
	 Y/htDJDgDcfoOZWrGcoLv5GcCj/bg7bwmSJq+aXt+hO/VR4vLpG42XWPuXF1jBPVMA
	 Ha1sD7J0v4mpUhOjworv2y1Eb/SAT4CgRHQX0zqMjqLyLEZKnYLpo1CibDY2CV+K5s
	 a+9ciW/2VE7ypsud+D0pQNVkUzkUCAFk4pMuT0vvqSJaVy3xakOoETQKVG54vAKxEr
	 35qTspefDE4zw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E50808175D; Thu, 13 Mar 2025 20:14:27 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC6B881A0F
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 20:14:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="EvJ7hkIx"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D33E6103D43BD; Thu, 13 Mar 2025 20:14:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1741893260; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=HEc/xkdC26uUtnVXjZxIPqPfTceUN5mXmSNcNHzAQb0=;
 b=EvJ7hkIxRwed0VPfrEsJIBGFzOL6+ZIxZPzgtttoFVRye5C+m0EetK7dh2IVcDPV4BhyH0
 /eB8CS9mIpkaI89r6640ePt+y2ZpxYyqdUW+e/NPjwWmabhnAc3xqokeNfsWTqnUXOwHix
 qrSKqqGoApdpI1tUWh+1Sw8D2MGZTdGdTitz5lW/EmgZKzPvKUhSWloQHZOuFNRWYXhSLV
 uESGd8XkGNHE/Ld2XpflQm2cN83We14EI7ENTgc2we+UleNgiKzUpS+QZ9taV5L0+GYHoc
 0FDWo4BZWUHuPnd8aoK2DsB3BfFGjRyCtDNe08ywjZux6ChxbC7FdIHT1jJyMg==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Baruch Siach <baruch@tkos.co.il>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nam Cao <namcao@linutronix.de>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/11] fs: exfat: Fix conversion overflow errors
Date: Thu, 13 Mar 2025 20:13:24 +0100
Message-ID: <20250313191348.170054-9-marex@denx.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313191348.170054-1-marex@denx.de>
References: <20250313191348.170054-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Fix the following conversion overflow errors. The UTF8-to-UTF16
conversion is done through 32bit wchar_t, but U-Boot codebase is
built with -fshort-wchar which limits wchar_t to 16bit. Replace
the built-in wchar_t with u32 to assure the intermediate type is
32bit.

"
fs/exfat/utf.c: In function ‘utf8_to_wchar’:
fs/exfat/utf.c:165:23: warning: overflow in conversion from ‘int’ to ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short unsigned int)*input << 18 & 1835008’ to ‘0’ [-Woverflow]
  165 |                 *wc = ((wchar_t) input[0] & 0x07) << 18;
      |                       ^
fs/exfat/utf.c:170:23: warning: overflow in conversion from ‘int’ to ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short unsigned int)*input << 24 & 50331648’ to ‘0’ [-Woverflow]
  170 |                 *wc = ((wchar_t) input[0] & 0x03) << 24;
      |                       ^
fs/exfat/utf.c:175:23: warning: overflow in conversion from ‘int’ to ‘wchar_t’ {aka ‘short unsigned int’} changes value from ‘(int)(short unsigned int)*input << 30 & 1073741824’ to ‘0’ [-Woverflow]
  175 |                 *wc = ((wchar_t) input[0] & 0x01) << 30;
      |                       ^
"

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Baruch Siach <baruch@tkos.co.il>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Hiago De Franco <hiago.franco@toradex.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Rework the patch, replace wchar_t with u32
---
 fs/exfat/utf.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/exfat/utf.c b/fs/exfat/utf.c
index b1d09e76478..8a28e7621ca 100644
--- a/fs/exfat/utf.c
+++ b/fs/exfat/utf.c
@@ -23,7 +23,7 @@
 #include "exfat.h"
 #include <errno.h>
 
-static char* wchar_to_utf8(char* output, wchar_t wc, size_t outsize)
+static char* wchar_to_utf8(char* output, u32 wc, size_t outsize)
 {
 	if (wc <= 0x7f)
 	{
@@ -82,14 +82,14 @@ static char* wchar_to_utf8(char* output, wchar_t wc, size_t outsize)
 	return output;
 }
 
-static const le16_t* utf16_to_wchar(const le16_t* input, wchar_t* wc,
+static const le16_t* utf16_to_wchar(const le16_t* input, u32* wc,
 		size_t insize)
 {
 	if ((le16_to_cpu(input[0]) & 0xfc00) == 0xd800)
 	{
 		if (insize < 2 || (le16_to_cpu(input[1]) & 0xfc00) != 0xdc00)
 			return NULL;
-		*wc = ((wchar_t) (le16_to_cpu(input[0]) & 0x3ff) << 10);
+		*wc = ((u32) (le16_to_cpu(input[0]) & 0x3ff) << 10);
 		*wc |= (le16_to_cpu(input[1]) & 0x3ff);
 		*wc += 0x10000;
 		return input + 2;
@@ -108,7 +108,7 @@ int exfat_utf16_to_utf8(char* output, const le16_t* input, size_t outsize,
 	const le16_t* iend = input + insize;
 	char* optr = output;
 	const char* oend = output + outsize;
-	wchar_t wc;
+	u32 wc;
 
 	while (iptr < iend)
 	{
@@ -136,7 +136,7 @@ int exfat_utf16_to_utf8(char* output, const le16_t* input, size_t outsize,
 	return 0;
 }
 
-static const char* utf8_to_wchar(const char* input, wchar_t* wc,
+static const char* utf8_to_wchar(const char* input, u32* wc,
 		size_t insize)
 {
 	size_t size;
@@ -147,32 +147,32 @@ static const char* utf8_to_wchar(const char* input, wchar_t* wc,
 
 	if ((input[0] & 0x80) == 0)
 	{
-		*wc = (wchar_t) input[0];
+		*wc = (u32) input[0];
 		return input + 1;
 	}
 	else if ((input[0] & 0xe0) == 0xc0)
 	{
-		*wc = ((wchar_t) input[0] & 0x1f) << 6;
+		*wc = ((u32) input[0] & 0x1f) << 6;
 		size = 2;
 	}
 	else if ((input[0] & 0xf0) == 0xe0)
 	{
-		*wc = ((wchar_t) input[0] & 0x0f) << 12;
+		*wc = ((u32) input[0] & 0x0f) << 12;
 		size = 3;
 	}
 	else if ((input[0] & 0xf8) == 0xf0)
 	{
-		*wc = ((wchar_t) input[0] & 0x07) << 18;
+		*wc = ((u32) input[0] & 0x07) << 18;
 		size = 4;
 	}
 	else if ((input[0] & 0xfc) == 0xf8)
 	{
-		*wc = ((wchar_t) input[0] & 0x03) << 24;
+		*wc = ((u32) input[0] & 0x03) << 24;
 		size = 5;
 	}
 	else if ((input[0] & 0xfe) == 0xfc)
 	{
-		*wc = ((wchar_t) input[0] & 0x01) << 30;
+		*wc = ((u32) input[0] & 0x01) << 30;
 		size = 6;
 	}
 	else
@@ -192,7 +192,7 @@ static const char* utf8_to_wchar(const char* input, wchar_t* wc,
 	return input + size;
 }
 
-static le16_t* wchar_to_utf16(le16_t* output, wchar_t wc, size_t outsize)
+static le16_t* wchar_to_utf16(le16_t* output, u32 wc, size_t outsize)
 {
 	if (wc <= 0xffff) /* if character is from BMP */
 	{
@@ -216,7 +216,7 @@ int exfat_utf8_to_utf16(le16_t* output, const char* input, size_t outsize,
 	const char* iend = input + insize;
 	le16_t* optr = output;
 	const le16_t* oend = output + outsize;
-	wchar_t wc;
+	u32 wc;
 
 	while (iptr < iend)
 	{
-- 
2.47.2

