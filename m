Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA55AC02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:45:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9D1980FB0;
	Sun, 26 Jan 2025 19:44:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Rb+oQR+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D23B980FCC; Sun, 26 Jan 2025 19:44:16 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 891C680F53
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3ce4b009465so9075075ab.0
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917052; x=1738521852; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hIrVsCB7mXxDlermy7FN3OPQufTw7Fp4e05ClINPbg=;
 b=Rb+oQR+t6bsrSMmqf/tUuepAxctX2M4cm5z4sr4I8ktdprbmKyZJbVclIr4QK2+dgx
 icruSqA/UJ6mbSBgslIVZVgG9YDDekv+8cVRmNX107HucCmyV6wwzLUfGLJyPhwNQnE/
 WkQqJbc8Dghg2ULjE/eIM3/Y553TV9GA1nYcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917052; x=1738521852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4hIrVsCB7mXxDlermy7FN3OPQufTw7Fp4e05ClINPbg=;
 b=hBr8WNzpv08IsCIHR9BzdkQSlhYZOcrpCeaEMecZbW80lt+H/H29WJAcWZ6Ynzy3r8
 F6DYxBm+6ydQYMYKXu45LEIXrBtiv4qQkr3OX47PwSGJ21k/d5MJVXreXEoUIXXHkQai
 rxi/W9SIKaLtWD0poBrhs61F8axyjNSd/Q72+uiDnrUlE5cnAGbftDpeZE78K4Q4X/7u
 PmTPu6wCg80Tgf579lbVF1Lmg1Lv8RfdKXqY3k2ZT05o69/RlnPtaAXR9E2hUHuziNQw
 exnvwubw1fYMHWYZZ3CUUEgqsJdB6cWJbpjAqKA6cOEdBQ7iHt6Ibv2VRaTw4cMic+vI
 yNMA==
X-Gm-Message-State: AOJu0YwN69B8DpL/DQQqDwE/CzrSBa5dzpXJwkuDrHHieLQNu/QhmucS
 O3FNTetqcYwVKqK/qJTKRaxABq39seWBik8J0QK/zMnXZ3N4OhcEGFXXtC5jC0JdITdPMKp9e64
 =
X-Gm-Gg: ASbGncvUnUvy0pSUTm0zhoyGPlmZGuAYeis5zb40bUAUL4AXMiV0l8sOniu/Oz54h6O
 5fFQ794rY1V7c/WD9fb/6DK41nrxk/tsqjlbxP18B6PvXVdiuYqNhTtrZJwg9TF6ytP2YtlM4Ka
 DLoUhpnjp3n1/+n3lm5U1bG9Doe/wVZemND7SSz3A+MAMSyScrDiDAuGTTaYNbT1CRCzXyuFoO8
 TSnmv54F5T632imFvUc9hpq2j50ApI5ANHQ11/ju9hN42EaTZVwuo9qeAL/hAWCxYWl9UKX7STF
 lS3aBaHfdVXsIcWkI9T99Xc00aF7awwhroD6xWKb4A==
X-Google-Smtp-Source: AGHT+IG9f+QEKa/dE46Sko/EGRoPcQzLfYI/roO9Nb8J0WSPSFzNbdCTjASvhbuEUdojlYydy9BZlQ==
X-Received: by 2002:a05:6e02:1d8b:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3cf74493955mr310305205ab.19.1737917051936; 
 Sun, 26 Jan 2025 10:44:11 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 12/19] lib: Mark lz4 as relocation code
Date: Sun, 26 Jan 2025 11:43:22 -0700
Message-ID: <20250126184333.4058848-13-sjg@chromium.org>
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

Mark the lz4 decompression code as needed by relocation. This is used to
decompress the next-phase image.

Drop the 'safe' versions from SPL as they are not needed. Change the
static array to a local one, to avoid a crash errors when trying to
access the data from relocated code. Make this conditional to avoid a
code-size increase when SPL_RELOC is not used/

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/lz4.c         | 37 ++++++++++++++++++++++++++-----------
 lib/lz4_wrapper.c |  2 +-
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/lib/lz4.c b/lib/lz4.c
index 63955a0b178..c718659c590 100644
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
@@ -111,6 +112,17 @@ typedef enum { decode_full_block = 0, partial_decode = 1 } earlyEnd_directive;
 #define assert(condition) ((void)0)
 #endif
 
+/*
+ * spl_reloc needs all necessary data to be set up within its code, since the
+ * code is relocated at runtime. Unfortunately this increase code-size slightly
+ * so only do it if spl_reloc is enabled
+ */
+#if CONFIG_IS_ENABLED(RELOC_LOADER)
+#define STATIC
+#else
+#define STATIC static
+#endif
+
 /*
  * LZ4_decompress_generic() :
  * This generic decompression function covers all use cases.
@@ -118,7 +130,7 @@ typedef enum { decode_full_block = 0, partial_decode = 1 } earlyEnd_directive;
  * Note that it is important for performance that this function really get inlined,
  * in order to remove useless branches during compilation optimization.
  */
-static FORCE_INLINE int LZ4_decompress_generic(
+__rcode static FORCE_INLINE int LZ4_decompress_generic(
 	 const char * const src,
 	 char * const dst,
 	 int srcSize,
@@ -141,6 +153,8 @@ static FORCE_INLINE int LZ4_decompress_generic(
 	 const size_t dictSize
 	 )
 {
+	STATIC const unsigned int inc32table[8] = {0, 1, 2, 1, 0, 4, 4, 4};
+	STATIC const int dec64table[8] = {0, 0, 0, -1, -4, 1, 2, 3};
 	const BYTE *ip = (const BYTE *) src;
 	const BYTE * const iend = ip + srcSize;
 
@@ -149,8 +163,6 @@ static FORCE_INLINE int LZ4_decompress_generic(
 	BYTE *cpy;
 
 	const BYTE * const dictEnd = (const BYTE *)dictStart + dictSize;
-	static const unsigned int inc32table[8] = {0, 1, 2, 1, 0, 4, 4, 4};
-	static const int dec64table[8] = {0, 0, 0, -1, -4, 1, 2, 3};
 
 	const int safeDecode = (endOnInput == endOnInputSize);
 	const int checkOffset = ((safeDecode) && (dictSize < (int)(64 * KB)));
@@ -514,8 +526,9 @@ _output_error:
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
@@ -523,11 +536,13 @@ int LZ4_decompress_safe(const char *source, char *dest,
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

