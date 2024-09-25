Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B5BC7882B
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 13:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC8C388D78;
	Wed, 25 Sep 2024 14:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FAB6fwG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 63B6588D61; Wed, 25 Sep 2024 14:58:23 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F2F888C7C
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 14:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5c876ed9c93so5728a12.2
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727269076; x=1727873876; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0T76Sd6JlFjTuIcd6K3x7cEnYN3EUA+69Z0Ltekm9/w=;
 b=FAB6fwG5BsIOfi5CQYdkPf2WhNhg/Yl0HNgFN/xQAmtOAGZlUHEZrxHZbJx4pjLRWX
 Z9s2Tyh6viVqNeaPMHTpGcAKjKo72A1LnJWnQL1RQjsb2lswci38tUFW16v3lR5gZA3P
 ln7adHSmifW0oXqwQy6V+DIAvdJsAWkb2V+LQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727269076; x=1727873876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0T76Sd6JlFjTuIcd6K3x7cEnYN3EUA+69Z0Ltekm9/w=;
 b=kZfhufqBzq/C1GX8KgkUYJSJ4Od2QHIgGO4Jjca7zibI51LiuX/oNUcSudafYQU9eN
 z55DHwaum2qyIVpFtcz6BbOwv7IUye09Cetq3xAjIQ8ErUhpQugcfQUvOPpjCaWJY9Mj
 V1hoJcRisWRS2iOqBewrSAaPL9TmPtL7uYT0quAZluJGO7FKhJYZL+r45wMFsQSCL8Mr
 t/HpdkRqSWbs/Xz5AOu+WMZ3AQCern858yZXdxWlyy5ZdX1qI4uqzKY/HyqZPwD/ZuWD
 6MYsYUtwU1jLL5qHsie9nCIPQ9HZObsISlfyNVieqE2A4OWIWtTKKPK5Dky3isVTCYyA
 z3bQ==
X-Gm-Message-State: AOJu0Yz8p4VWXWPSeSyEJxkG/M7dp75mKLtx74q+D2c5nK7b7rWvus93
 yNNjqCmKGhqG3lGgFCWoyCDibkQiQuiJ3l3fLSgoqhtyRLgOJ5viR/olV/fdNvwY7jLxRE+PA9D
 rlw==
X-Google-Smtp-Source: AGHT+IGNr4aL/pTRI0ZRIR+Dj9tJrZZhSVa4SWQMBZyI2l03N4qOS+1IweIXoqHTJAj0yXmHdjsdrQ==
X-Received: by 2002:a17:907:7e8d:b0:a8d:250a:52b2 with SMTP id
 a640c23a62f3a-a93a0341a30mr241944066b.6.1727269076483; 
 Wed, 25 Sep 2024 05:57:56 -0700 (PDT)
Received: from chromium.org ([82.132.187.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a93930f7889sm209209766b.179.2024.09.25.05.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 05:57:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 06/19] lib: Mark lz4 as relocation code
Date: Wed, 25 Sep 2024 14:55:32 +0200
Message-ID: <20240925125622.197915-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925125622.197915-1-sjg@chromium.org>
References: <20240925125622.197915-1-sjg@chromium.org>
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

Mark the lz4 decompression code as needed by relocation. This is used to
decompress the next-phase image.

Drop the 'safe' versions from SPL as they are not needed. Change the
static array to a local one, to avoid link errors when trying to access
the data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/lz4.c         | 27 +++++++++++++++------------
 lib/lz4_wrapper.c |  2 +-
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/lib/lz4.c b/lib/lz4.c
index 63955a0b178..f93d74535e4 100644
--- a/lib/lz4.c
+++ b/lib/lz4.c
@@ -33,15 +33,16 @@
 #include <linux/bug.h>
 #include <asm/unaligned.h>
 #include <u-boot/lz4.h>
+#include <asm/sections.h>
 
 #define FORCE_INLINE inline __attribute__((always_inline))
 
-static FORCE_INLINE u16 LZ4_readLE16(const void *src)
+__rcode static FORCE_INLINE u16 LZ4_readLE16(const void *src)
 {
 	return get_unaligned_le16(src);
 }
 
-static FORCE_INLINE void LZ4_copy8(void *dst, const void *src)
+__rcode static FORCE_INLINE void LZ4_copy8(void *dst, const void *src)
 {
 	put_unaligned(get_unaligned((const u64 *)src), (u64 *)dst);
 }
@@ -53,7 +54,7 @@ typedef  int32_t S32;
 typedef uint64_t U64;
 typedef uintptr_t uptrval;
 
-static FORCE_INLINE void LZ4_write32(void *memPtr, U32 value)
+__rcode static FORCE_INLINE void LZ4_write32(void *memPtr, U32 value)
 {
 	put_unaligned(value, (U32 *)memPtr);
 }
@@ -63,7 +64,7 @@ static FORCE_INLINE void LZ4_write32(void *memPtr, U32 value)
 **************************************/
 
 /* customized version of memcpy, which may overwrite up to 7 bytes beyond dstEnd */
-static void LZ4_wildCopy(void* dstPtr, const void* srcPtr, void* dstEnd)
+__rcode static void LZ4_wildCopy(void *dstPtr, const void *srcPtr, void *dstEnd)
 {
     BYTE* d = (BYTE*)dstPtr;
     const BYTE* s = (const BYTE*)srcPtr;
@@ -118,8 +119,7 @@ typedef enum { decode_full_block = 0, partial_decode = 1 } earlyEnd_directive;
  * Note that it is important for performance that this function really get inlined,
  * in order to remove useless branches during compilation optimization.
  */
-static FORCE_INLINE int LZ4_decompress_generic(
-	 const char * const src,
+__rcode static FORCE_INLINE int LZ4_decompress_generic(const char * const src,
 	 char * const dst,
 	 int srcSize,
 		/*
@@ -141,6 +141,8 @@ static FORCE_INLINE int LZ4_decompress_generic(
 	 const size_t dictSize
 	 )
 {
+	const unsigned int inc32table[8] = {0, 1, 2, 1, 0, 4, 4, 4};
+	const int dec64table[8] = {0, 0, 0, -1, -4, 1, 2, 3};
 	const BYTE *ip = (const BYTE *) src;
 	const BYTE * const iend = ip + srcSize;
 
@@ -149,8 +151,6 @@ static FORCE_INLINE int LZ4_decompress_generic(
 	BYTE *cpy;
 
 	const BYTE * const dictEnd = (const BYTE *)dictStart + dictSize;
-	static const unsigned int inc32table[8] = {0, 1, 2, 1, 0, 4, 4, 4};
-	static const int dec64table[8] = {0, 0, 0, -1, -4, 1, 2, 3};
 
 	const int safeDecode = (endOnInput == endOnInputSize);
 	const int checkOffset = ((safeDecode) && (dictSize < (int)(64 * KB)));
@@ -514,8 +514,9 @@ _output_error:
 	return (int) (-(((const char *)ip) - src)) - 1;
 }
 
-int LZ4_decompress_safe(const char *source, char *dest,
-	int compressedSize, int maxDecompressedSize)
+#ifndef CONFIG_SPL_BUILD
+__rcode int LZ4_decompress_safe(const char *source, char *dest,
+				int compressedSize, int maxDecompressedSize)
 {
 	return LZ4_decompress_generic(source, dest,
 				      compressedSize, maxDecompressedSize,
@@ -523,11 +524,13 @@ int LZ4_decompress_safe(const char *source, char *dest,
 				      noDict, (BYTE *)dest, NULL, 0);
 }
 
-int LZ4_decompress_safe_partial(const char *src, char *dst,
-	int compressedSize, int targetOutputSize, int dstCapacity)
+__rcode int LZ4_decompress_safe_partial(const char *src, char *dst,
+					int compressedSize,
+					int targetOutputSize, int dstCapacity)
 {
 	dstCapacity = min(targetOutputSize, dstCapacity);
 	return LZ4_decompress_generic(src, dst, compressedSize, dstCapacity,
 				      endOnInputSize, partial_decode,
 				      noDict, (BYTE *)dst, NULL, 0);
 }
+#endif
diff --git a/lib/lz4_wrapper.c b/lib/lz4_wrapper.c
index 4d48e7b0e8b..b1204511170 100644
--- a/lib/lz4_wrapper.c
+++ b/lib/lz4_wrapper.c
@@ -15,7 +15,7 @@
 
 #define LZ4F_BLOCKUNCOMPRESSED_FLAG 0x80000000U
 
-int ulz4fn(const void *src, size_t srcn, void *dst, size_t *dstn)
+__rcode int ulz4fn(const void *src, size_t srcn, void *dst, size_t *dstn)
 {
 	const void *end = dst + *dstn;
 	const void *in = src;
-- 
2.43.0

