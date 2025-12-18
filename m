Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C003BD711CD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E05A0836A3;
	Fri, 19 Dec 2025 00:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YqZow5z8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01790836A3; Fri, 19 Dec 2025 00:23:09 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7A3A835FD
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-4557e6303a5so428481b6e.3
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766100184; x=1766704984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M9Sioy4HDuo4JSGte7vkXl87videLjkxxuUQdFDKCv4=;
 b=YqZow5z8pq2+wPyA/PdSHz/BwjXynPwHSmcUzA7hM0jILNc4OZqZI5bNKInlKtW0b/
 t3PFNySfxGQXhv3mjerO0ICEhBF7KxYoloWDcis+w62p4wEajnU8pYwxKr+bErw8Hwek
 VpNaUv91+cwxSYsmRDTMxsJ/VuX2vbhFow5O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100184; x=1766704984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M9Sioy4HDuo4JSGte7vkXl87videLjkxxuUQdFDKCv4=;
 b=ub1o/Vw/XHrtOTIwRKdd+VrhK1tBsswuh77TnQ3k8ghLB0Vv7tTUYEasa8n8b6F4Ta
 o5JImz3PCbLtjoeUA3OcXgp7nUBWnuQxWP9xnNyMe1tHNVvqbMCfCmzuBo1PCrF9BPBP
 +JQBzyBm4Km4YP3YbP5FKtKtmXZwhjH/pdlr/gdtuDCAdN0X9pFoAAdUJxlUDqYhqASC
 r34iHv/ObiV585FEnjyPDkmBe7lS7jdFyCT1Lk/WmKNHuJWMpfDRFQ/+Ct1W3yLtdUGZ
 z31VsH3GCB4r+yxoKZGKacAP110hHg4N6H6HPOthBx5nBNtTklEucWBGpV06yUgz/Fkm
 OxqA==
X-Gm-Message-State: AOJu0Yz5VoGzynIuib2v9qyN9dJZrbi6UBuDYPZe2Gw07D2+e/5oftdC
 eKanBdY/To+BKonfLr9tJxm1Vl8bVYiFEu8QOE6qVhJoq5mNM2x+/HAjhWCT97yT/8MGzHNBkrC
 qnV6w7wA=
X-Gm-Gg: AY/fxX7b20qaF76HatKKVobIZOoc5M5cLqkrfU1T7HGlb51S+SI3OXvMol+k0/dhAmE
 qqpOizbQmsLZMQL1cP0hvLuDkNSPr2YVPrs5394kbMPWpj3iC++6hJgYesXuoaesiG0bM1B0TaX
 D6zM91Fz0TIjX/au5MGA3pmP+IKUMJ/0n7QH5q6Ou0x/IBufKDc4+aKpM8JBvxiHffs75cBEspc
 4E7Si5OjAeeF/JZuzwd8SS2aTwQqezfq1I5ibCFNaA46ogr8yJxZx0JxRL2xZxiyKWyMhn7Jynh
 BU8vtqON5vfMAz7aXs2Kzv4F/2s6i5EZ2aT3lFLJeioerxCQanXmNxdSvnl8C1WUdv7uKRjx//M
 cczT7v7q4UU5BgIteSlFA2ynaOlaNfJO9kOqV7p/kOGcp9WdSZUbkLLXnky54nzZxzM/tPklbNr
 3yjD1O87WtTzXdDiSPOFLZ8xMeQn35/s2bEgrvRzdhRabrWEd5SCBErq2pTYn5wNI=
X-Google-Smtp-Source: AGHT+IH1bNWq40UnGTetLwgACRTTi4hcr7UwJhdKgjHjv7GSb3YT/KCkkK9JmwlboPXqnBdcM5g/hw==
X-Received: by 2002:a05:6808:bc7:b0:450:4628:e3f0 with SMTP id
 5614622812f47-457b221dec8mr661719b6e.36.1766100184324; 
 Thu, 18 Dec 2025 15:23:04 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3cc0928sm295333b6e.10.2025.12.18.15.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:23:03 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
Subject: [RFC PATCH 6/9] lzma: Update 18.06 -> 21.07
Date: Thu, 18 Dec 2025 17:10:18 -0600
Message-ID: <20251218232255.3934258-7-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218232255.3934258-1-trini@konsulko.com>
References: <20251218232255.3934258-1-trini@konsulko.com>
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

Of note, add guards around TEXT macro and LONG typedef, both are unused
in the code but cause problems on MIPS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/lzma/7zTypes.h  | 192 +++++++++++++++++++--
 lib/lzma/Compiler.h |  12 +-
 lib/lzma/LzmaDec.c  | 412 +++++++++++++++++++++++++++++++-------------
 lib/lzma/LzmaDec.h  |   4 +-
 4 files changed, 482 insertions(+), 138 deletions(-)

diff --git a/lib/lzma/7zTypes.h b/lib/lzma/7zTypes.h
index 65b3af63c751..0b1fbb637793 100644
--- a/lib/lzma/7zTypes.h
+++ b/lib/lzma/7zTypes.h
@@ -1,11 +1,13 @@
 /* 7zTypes.h -- Basic types
-2018-08-04 : Igor Pavlov : Public domain */
+2021-12-25 : Igor Pavlov : Public domain */
 
 #ifndef __7Z_TYPES_H
 #define __7Z_TYPES_H
 
 #ifdef _WIN32
 /* #include <windows.h> */
+#else
+#include <errno.h>
 #endif
 
 #include <stddef.h>
@@ -43,18 +45,118 @@ EXTERN_C_BEGIN
 typedef int SRes;
 
 
+#ifdef _MSC_VER
+  #if _MSC_VER > 1200
+    #define MY_ALIGN(n) __declspec(align(n))
+  #else
+    #define MY_ALIGN(n)
+  #endif
+#else
+  #define MY_ALIGN(n) __attribute__ ((aligned(n)))
+#endif
+
+
 #ifdef _WIN32
 
 /* typedef DWORD WRes; */
 typedef unsigned WRes;
 #define MY_SRes_HRESULT_FROM_WRes(x) HRESULT_FROM_WIN32(x)
 
-#else
+// #define MY_HRES_ERROR__INTERNAL_ERROR  MY_SRes_HRESULT_FROM_WRes(ERROR_INTERNAL_ERROR)
+
+#else // _WIN32
 
+// #define ENV_HAVE_LSTAT
 typedef int WRes;
-#define MY__FACILITY_WIN32 7
-#define MY__FACILITY__WRes MY__FACILITY_WIN32
-#define MY_SRes_HRESULT_FROM_WRes(x) ((HRESULT)(x) <= 0 ? ((HRESULT)(x)) : ((HRESULT) (((x) & 0x0000FFFF) | (MY__FACILITY__WRes << 16) | 0x80000000)))
+
+// (FACILITY_ERRNO = 0x800) is 7zip's FACILITY constant to represent (errno) errors in HRESULT
+#define MY__FACILITY_ERRNO  0x800
+#define MY__FACILITY_WIN32  7
+#define MY__FACILITY__WRes  MY__FACILITY_ERRNO
+
+#define MY_HRESULT_FROM_errno_CONST_ERROR(x) ((HRESULT)( \
+          ( (HRESULT)(x) & 0x0000FFFF) \
+          | (MY__FACILITY__WRes << 16)  \
+          | (HRESULT)0x80000000 ))
+
+#define MY_SRes_HRESULT_FROM_WRes(x) \
+  ((HRESULT)(x) <= 0 ? ((HRESULT)(x)) : MY_HRESULT_FROM_errno_CONST_ERROR(x))
+
+// we call macro HRESULT_FROM_WIN32 for system errors (WRes) that are (errno)
+#define HRESULT_FROM_WIN32(x) MY_SRes_HRESULT_FROM_WRes(x)
+
+/*
+#define ERROR_FILE_NOT_FOUND             2L
+#define ERROR_ACCESS_DENIED              5L
+#define ERROR_NO_MORE_FILES              18L
+#define ERROR_LOCK_VIOLATION             33L
+#define ERROR_FILE_EXISTS                80L
+#define ERROR_DISK_FULL                  112L
+#define ERROR_NEGATIVE_SEEK              131L
+#define ERROR_ALREADY_EXISTS             183L
+#define ERROR_DIRECTORY                  267L
+#define ERROR_TOO_MANY_POSTS             298L
+
+#define ERROR_INTERNAL_ERROR             1359L
+#define ERROR_INVALID_REPARSE_DATA       4392L
+#define ERROR_REPARSE_TAG_INVALID        4393L
+#define ERROR_REPARSE_TAG_MISMATCH       4394L
+*/
+
+// we use errno equivalents for some WIN32 errors:
+
+#define ERROR_INVALID_PARAMETER     EINVAL
+#define ERROR_INVALID_FUNCTION      EINVAL
+#define ERROR_ALREADY_EXISTS        EEXIST
+#define ERROR_FILE_EXISTS           EEXIST
+#define ERROR_PATH_NOT_FOUND        ENOENT
+#define ERROR_FILE_NOT_FOUND        ENOENT
+#define ERROR_DISK_FULL             ENOSPC
+// #define ERROR_INVALID_HANDLE        EBADF
+
+// we use FACILITY_WIN32 for errors that has no errno equivalent
+// Too many posts were made to a semaphore.
+#define ERROR_TOO_MANY_POSTS        ((HRESULT)0x8007012AL)
+#define ERROR_INVALID_REPARSE_DATA  ((HRESULT)0x80071128L)
+#define ERROR_REPARSE_TAG_INVALID   ((HRESULT)0x80071129L)
+
+// if (MY__FACILITY__WRes != FACILITY_WIN32),
+// we use FACILITY_WIN32 for COM errors:
+#define E_OUTOFMEMORY               ((HRESULT)0x8007000EL)
+#define E_INVALIDARG                ((HRESULT)0x80070057L)
+#define MY__E_ERROR_NEGATIVE_SEEK   ((HRESULT)0x80070083L)
+
+/*
+// we can use FACILITY_ERRNO for some COM errors, that have errno equivalents:
+#define E_OUTOFMEMORY             MY_HRESULT_FROM_errno_CONST_ERROR(ENOMEM)
+#define E_INVALIDARG              MY_HRESULT_FROM_errno_CONST_ERROR(EINVAL)
+#define MY__E_ERROR_NEGATIVE_SEEK MY_HRESULT_FROM_errno_CONST_ERROR(EINVAL)
+*/
+
+// gcc / clang : (sizeof(long) == sizeof(void*)) in 32/64 bits
+typedef          long INT_PTR;
+typedef unsigned long UINT_PTR;
+
+#ifndef __UBOOT__
+#define TEXT(quote) quote
+#endif
+
+#define FILE_ATTRIBUTE_READONLY       0x0001
+#define FILE_ATTRIBUTE_HIDDEN         0x0002
+#define FILE_ATTRIBUTE_SYSTEM         0x0004
+#define FILE_ATTRIBUTE_DIRECTORY      0x0010
+#define FILE_ATTRIBUTE_ARCHIVE        0x0020
+#define FILE_ATTRIBUTE_DEVICE         0x0040
+#define FILE_ATTRIBUTE_NORMAL         0x0080
+#define FILE_ATTRIBUTE_TEMPORARY      0x0100
+#define FILE_ATTRIBUTE_SPARSE_FILE    0x0200
+#define FILE_ATTRIBUTE_REPARSE_POINT  0x0400
+#define FILE_ATTRIBUTE_COMPRESSED     0x0800
+#define FILE_ATTRIBUTE_OFFLINE        0x1000
+#define FILE_ATTRIBUTE_NOT_CONTENT_INDEXED 0x2000
+#define FILE_ATTRIBUTE_ENCRYPTED      0x4000
+
+#define FILE_ATTRIBUTE_UNIX_EXTENSION 0x8000   /* trick for Unix */
 
 #endif
 
@@ -63,6 +165,10 @@ typedef int WRes;
 #define RINOK(x) { int __result__ = (x); if (__result__ != 0) return __result__; }
 #endif
 
+#ifndef RINOK_WRes
+#define RINOK_WRes(x) { WRes __result__ = (x); if (__result__ != 0) return __result__; }
+#endif
+
 typedef unsigned char Byte;
 typedef short Int16;
 typedef unsigned short UInt16;
@@ -75,6 +181,42 @@ typedef int Int32;
 typedef unsigned int UInt32;
 #endif
 
+
+#ifndef _WIN32
+
+typedef int INT;
+typedef Int32 INT32;
+typedef unsigned int UINT;
+typedef UInt32 UINT32;
+#ifndef __UBOOT__
+typedef INT32 LONG;   // LONG, ULONG and DWORD must be 32-bit for _WIN32 compatibility
+#endif
+typedef UINT32 ULONG;
+
+#undef DWORD
+typedef UINT32 DWORD;
+
+#define VOID void
+
+#define HRESULT LONG
+
+typedef void *LPVOID;
+// typedef void VOID;
+// typedef ULONG_PTR DWORD_PTR, *PDWORD_PTR;
+// gcc / clang on Unix  : sizeof(long==sizeof(void*) in 32 or 64 bits)
+typedef          long  INT_PTR;
+typedef unsigned long  UINT_PTR;
+typedef          long  LONG_PTR;
+typedef unsigned long  DWORD_PTR;
+
+typedef size_t SIZE_T;
+
+#endif //  _WIN32
+
+
+#define MY_HRES_ERROR__INTERNAL_ERROR  ((HRESULT)0x8007054FL)
+
+
 #ifdef _SZ_NO_INT_64
 
 /* define _SZ_NO_INT_64, if your compiler doesn't support 64-bit integers.
@@ -128,25 +270,37 @@ typedef int BoolInt;
 #define MY_CDECL __cdecl
 #define MY_FAST_CALL __fastcall
 
-#else
+#else //  _MSC_VER
 
+#if (defined(__GNUC__) && (__GNUC__ >= 4)) \
+    || (defined(__clang__) && (__clang_major__ >= 4)) \
+    || defined(__INTEL_COMPILER) \
+    || defined(__xlC__)
+#define MY_NO_INLINE __attribute__((noinline))
+// #define MY_FORCE_INLINE __attribute__((always_inline)) inline
+#else
 #define MY_NO_INLINE
+#endif
+
 #define MY_FORCE_INLINE
-#define MY_CDECL
-#define MY_FAST_CALL
 
-/* inline keyword : for C++ / C99 */
 
-/* GCC, clang: */
-/*
-#if defined (__GNUC__) && (__GNUC__ >= 4)
-#define MY_FORCE_INLINE __attribute__((always_inline))
-#define MY_NO_INLINE __attribute__((noinline))
-#endif
-*/
+#define MY_CDECL
 
+#if  defined(_M_IX86) \
+  || defined(__i386__)
+// #define MY_FAST_CALL __attribute__((fastcall))
+// #define MY_FAST_CALL __attribute__((cdecl))
+#define MY_FAST_CALL
+#elif defined(MY_CPU_AMD64)
+// #define MY_FAST_CALL __attribute__((ms_abi))
+#define MY_FAST_CALL
+#else
+#define MY_FAST_CALL
 #endif
 
+#endif //  _MSC_VER
+
 
 /* The following interfaces use first parameter as pointer to structure */
 
@@ -335,12 +489,11 @@ struct ISzAlloc
     GCC 4.8.1 : classes with non-public variable members"
 */
 
-#define MY_container_of(ptr, type, m) ((type *)((char *)(1 ? (ptr) : &((type *)0)->m) - MY_offsetof(type, m)))
-
+#define MY_container_of(ptr, type, m) ((type *)(void *)((char *)(void *)(1 ? (ptr) : &((type *)0)->m) - MY_offsetof(type, m)))
 
 #endif
 
-#define CONTAINER_FROM_VTBL_SIMPLE(ptr, type, m) ((type *)(ptr))
+#define CONTAINER_FROM_VTBL_SIMPLE(ptr, type, m) ((type *)(void *)(ptr))
 
 /*
 #define CONTAINER_FROM_VTBL(ptr, type, m) CONTAINER_FROM_VTBL_SIMPLE(ptr, type, m)
@@ -353,6 +506,7 @@ struct ISzAlloc
 */
 
 
+#define MY_memset_0_ARRAY(a) memset((a), 0, sizeof(a))
 
 #ifdef _WIN32
 
diff --git a/lib/lzma/Compiler.h b/lib/lzma/Compiler.h
index 0cc409d8a864..a9816fa5ad01 100644
--- a/lib/lzma/Compiler.h
+++ b/lib/lzma/Compiler.h
@@ -1,9 +1,13 @@
 /* Compiler.h
-2017-04-03 : Igor Pavlov : Public domain */
+2021-01-05 : Igor Pavlov : Public domain */
 
 #ifndef __7Z_COMPILER_H
 #define __7Z_COMPILER_H
 
+  #ifdef __clang__
+    #pragma clang diagnostic ignored "-Wunused-private-field"
+  #endif
+
 #ifdef _MSC_VER
 
   #ifdef UNDER_CE
@@ -25,6 +29,12 @@
     #pragma warning(disable : 4786) // identifier was truncated to '255' characters in the debug information
   #endif
 
+  #ifdef __clang__
+    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
+    #pragma clang diagnostic ignored "-Wmicrosoft-exception-spec"
+    // #pragma clang diagnostic ignored "-Wreserved-id-macro"
+  #endif
+
 #endif
 
 #define UNUSED_VAR(x) (void)x;
diff --git a/lib/lzma/LzmaDec.c b/lib/lzma/LzmaDec.c
index 3319c7cf4938..a27f3c3b42a3 100644
--- a/lib/lzma/LzmaDec.c
+++ b/lib/lzma/LzmaDec.c
@@ -1,5 +1,5 @@
 /* LzmaDec.c -- LZMA Decoder
-2018-07-04 : Igor Pavlov : Public domain */
+2021-04-01 : Igor Pavlov : Public domain */
 
 #include "Precomp.h"
 
@@ -15,10 +15,12 @@
 
 #define kNumBitModelTotalBits 11
 #define kBitModelTotal (1 << kNumBitModelTotalBits)
-#define kNumMoveBits 5
 
 #define RC_INIT_SIZE 5
 
+#ifndef _LZMA_DEC_OPT
+
+#define kNumMoveBits 5
 #define NORMALIZE if (range < kTopValue) { range <<= 8; code = (code << 8) | (*buf++); }
 
 #define IF_BIT_0(p) ttt = *(p); NORMALIZE; bound = (range >> kNumBitModelTotalBits) * (UInt32)ttt; if (code < bound)
@@ -64,9 +66,10 @@
   probLit = prob + (offs + bit + symbol); \
   GET_BIT2(probLit, symbol, offs ^= bit; , ;)
 
+#endif // _LZMA_DEC_OPT
 
 
-#define NORMALIZE_CHECK if (range < kTopValue) { if (buf >= bufLimit) return DUMMY_ERROR; range <<= 8; code = (code << 8) | (*buf++); }
+#define NORMALIZE_CHECK if (range < kTopValue) { if (buf >= bufLimit) return DUMMY_INPUT_EOF; range <<= 8; code = (code << 8) | (*buf++); }
 
 #define IF_BIT_0_CHECK(p) ttt = *(p); NORMALIZE_CHECK; bound = (range >> kNumBitModelTotalBits) * (UInt32)ttt; if (code < bound)
 #define UPDATE_0_CHECK range = bound;
@@ -116,6 +119,9 @@
 #define kMatchMinLen 2
 #define kMatchSpecLenStart (kMatchMinLen + kLenNumLowSymbols * 2 + kLenNumHighSymbols)
 
+#define kMatchSpecLen_Error_Data (1 << 9)
+#define kMatchSpecLen_Error_Fail (kMatchSpecLen_Error_Data - 1)
+
 /* External ASM code needs same CLzmaProb array layout. So don't change it. */
 
 /* (probs_1664) is faster and better for code size at some platforms */
@@ -168,10 +174,12 @@
 
 /*
 p->remainLen : shows status of LZMA decoder:
-    < kMatchSpecLenStart : normal remain
-    = kMatchSpecLenStart : finished
-    = kMatchSpecLenStart + 1 : need init range coder
-    = kMatchSpecLenStart + 2 : need init range coder and state
+    < kMatchSpecLenStart  : the number of bytes to be copied with (p->rep0) offset
+    = kMatchSpecLenStart  : the LZMA stream was finished with end mark
+    = kMatchSpecLenStart + 1  : need init range coder
+    = kMatchSpecLenStart + 2  : need init range coder and state
+    = kMatchSpecLen_Error_Fail                : Internal Code Failure
+    = kMatchSpecLen_Error_Data + [0 ... 273]  : LZMA Data Error
 */
 
 /* ---------- LZMA_DECODE_REAL ---------- */
@@ -190,23 +198,31 @@ In:
   {
     LzmaDec_TryDummy() was called before to exclude LITERAL and MATCH-REP cases.
     So first symbol can be only MATCH-NON-REP. And if that MATCH-NON-REP symbol
-    is not END_OF_PAYALOAD_MARKER, then function returns error code.
+    is not END_OF_PAYALOAD_MARKER, then the function doesn't write any byte to dictionary,
+    the function returns SZ_OK, and the caller can use (p->remainLen) and (p->reps[0]) later.
   }
 
 Processing:
-  first LZMA symbol will be decoded in any case
-  All checks for limits are at the end of main loop,
-  It will decode new LZMA-symbols while (p->buf < bufLimit && dicPos < limit),
+  The first LZMA symbol will be decoded in any case.
+  All main checks for limits are at the end of main loop,
+  It decodes additional LZMA-symbols while (p->buf < bufLimit && dicPos < limit),
   RangeCoder is still without last normalization when (p->buf < bufLimit) is being checked.
+  But if (p->buf < bufLimit), the caller provided at least (LZMA_REQUIRED_INPUT_MAX + 1) bytes for
+  next iteration  before limit (bufLimit + LZMA_REQUIRED_INPUT_MAX),
+  that is enough for worst case LZMA symbol with one additional RangeCoder normalization for one bit.
+  So that function never reads bufLimit [LZMA_REQUIRED_INPUT_MAX] byte.
 
 Out:
   RangeCoder is normalized
   Result:
     SZ_OK - OK
-    SZ_ERROR_DATA - Error
-  p->remainLen:
-    < kMatchSpecLenStart : normal remain
-    = kMatchSpecLenStart : finished
+      p->remainLen:
+        < kMatchSpecLenStart : the number of bytes to be copied with (p->reps[0]) offset
+        = kMatchSpecLenStart : the LZMA stream was finished with end mark
+
+    SZ_ERROR_DATA - error, when the MATCH-Symbol refers out of dictionary
+      p->remainLen : undefined
+      p->reps[*]    : undefined
 */
 
 
@@ -322,11 +338,6 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
       else
       {
         UPDATE_1(prob);
-        /*
-        // that case was checked before with kBadRepCode
-        if (checkDicSize == 0 && processedPos == 0)
-          return SZ_ERROR_DATA;
-        */
         prob = probs + IsRepG0 + state;
         IF_BIT_0(prob)
         {
@@ -335,6 +346,13 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
           IF_BIT_0(prob)
           {
             UPDATE_0(prob);
+
+            // that case was checked before with kBadRepCode
+            // if (checkDicSize == 0 && processedPos == 0) { len = kMatchSpecLen_Error_Data + 1; break; }
+            // The caller doesn't allow (dicPos == limit) case here
+            // so we don't need the following check:
+            // if (dicPos == limit) { state = state < kNumLitStates ? 9 : 11; len = 1; break; }
+
             dic[dicPos] = dic[dicPos - rep0 + (dicPos < rep0 ? dicBufSize : 0)];
             dicPos++;
             processedPos++;
@@ -524,8 +542,10 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
         state = (state < kNumStates + kNumLitStates) ? kNumLitStates : kNumLitStates + 3;
         if (distance >= (checkDicSize == 0 ? processedPos: checkDicSize))
         {
-          p->dicPos = dicPos;
-          return SZ_ERROR_DATA;
+          len += kMatchSpecLen_Error_Data + kMatchMinLen;
+          // len = kMatchSpecLen_Error_Data;
+          // len += kMatchMinLen;
+          break;
         }
       }
 
@@ -538,8 +558,13 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
 
         if ((rem = limit - dicPos) == 0)
         {
-          p->dicPos = dicPos;
-          return SZ_ERROR_DATA;
+          /*
+          We stop decoding and return SZ_OK, and we can resume decoding later.
+          Any error conditions can be tested later in caller code.
+          For more strict mode we can stop decoding with error
+          // len += kMatchSpecLen_Error_Data;
+          */
+          break;
         }
 
         curLen = ((rem < len) ? (unsigned)rem : len);
@@ -580,7 +605,7 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
   p->buf = buf;
   p->range = range;
   p->code = code;
-  p->remainLen = (UInt32)len;
+  p->remainLen = (UInt32)len; // & (kMatchSpecLen_Error_Data - 1); // we can write real length for error matches too.
   p->dicPos = dicPos;
   p->processedPos = processedPos;
   p->reps[0] = rep0;
@@ -588,40 +613,61 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
   p->reps[2] = rep2;
   p->reps[3] = rep3;
   p->state = (UInt32)state;
-
+  if (len >= kMatchSpecLen_Error_Data)
+    return SZ_ERROR_DATA;
   return SZ_OK;
 }
 #endif
 
+
+
 static void MY_FAST_CALL LzmaDec_WriteRem(CLzmaDec *p, SizeT limit)
 {
-  if (p->remainLen != 0 && p->remainLen < kMatchSpecLenStart)
+  unsigned len = (unsigned)p->remainLen;
+  if (len == 0 /* || len >= kMatchSpecLenStart */)
+    return;
   {
-    Byte *dic = p->dic;
     SizeT dicPos = p->dicPos;
-    SizeT dicBufSize = p->dicBufSize;
-    unsigned len = (unsigned)p->remainLen;
-    SizeT rep0 = p->reps[0]; /* we use SizeT to avoid the BUG of VC14 for AMD64 */
-    SizeT rem = limit - dicPos;
-    if (rem < len)
-      len = (unsigned)(rem);
+    Byte *dic;
+    SizeT dicBufSize;
+    SizeT rep0;   /* we use SizeT to avoid the BUG of VC14 for AMD64 */
+    {
+      SizeT rem = limit - dicPos;
+      if (rem < len)
+      {
+        len = (unsigned)(rem);
+        if (len == 0)
+          return;
+      }
+    }
 
     if (p->checkDicSize == 0 && p->prop.dicSize - p->processedPos <= len)
       p->checkDicSize = p->prop.dicSize;
 
     p->processedPos += (UInt32)len;
     p->remainLen -= (UInt32)len;
-    while (len != 0)
+    dic = p->dic;
+    rep0 = p->reps[0];
+    dicBufSize = p->dicBufSize;
+    do
     {
-      len--;
       dic[dicPos] = dic[dicPos - rep0 + (dicPos < rep0 ? dicBufSize : 0)];
       dicPos++;
     }
+    while (--len);
     p->dicPos = dicPos;
   }
 }
 
 
+/*
+At staring of new stream we have one of the following symbols:
+  - Literal        - is allowed
+  - Non-Rep-Match  - is allowed only if it's end marker symbol
+  - Rep-Match      - is not allowed
+We use early check of (RangeCoder:Code) over kBadRepCode to simplify main decoding code
+*/
+
 #define kRange0 0xFFFFFFFF
 #define kBound0 ((kRange0 >> kNumBitModelTotalBits) << (kNumBitModelTotalBits - 1))
 #define kBadRepCode (kBound0 + (((kRange0 - kBound0) >> kNumBitModelTotalBits) << (kNumBitModelTotalBits - 1)))
@@ -629,69 +675,77 @@ static void MY_FAST_CALL LzmaDec_WriteRem(CLzmaDec *p, SizeT limit)
   #error Stop_Compiling_Bad_LZMA_Check
 #endif
 
-static int MY_FAST_CALL LzmaDec_DecodeReal2(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
-{
-  do
-  {
-    SizeT limit2 = limit;
-    if (p->checkDicSize == 0)
-    {
-      UInt32 rem = p->prop.dicSize - p->processedPos;
-      if (limit - p->dicPos > rem)
-        limit2 = p->dicPos + rem;
 
-      if (p->processedPos == 0)
-        if (p->code >= kBadRepCode)
-          return SZ_ERROR_DATA;
-    }
+/*
+LzmaDec_DecodeReal2():
+  It calls LZMA_DECODE_REAL() and it adjusts limit according (p->checkDicSize).
 
-    RINOK(LZMA_DECODE_REAL(p, limit2, bufLimit));
+We correct (p->checkDicSize) after LZMA_DECODE_REAL() and in LzmaDec_WriteRem(),
+and we support the following state of (p->checkDicSize):
+  if (total_processed < p->prop.dicSize) then
+  {
+    (total_processed == p->processedPos)
+    (p->checkDicSize == 0)
+  }
+  else
+    (p->checkDicSize == p->prop.dicSize)
+*/
 
+static int MY_FAST_CALL LzmaDec_DecodeReal2(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
+{
+  if (p->checkDicSize == 0)
+  {
+    UInt32 rem = p->prop.dicSize - p->processedPos;
+    if (limit - p->dicPos > rem)
+      limit = p->dicPos + rem;
+  }
+  {
+    int res = LZMA_DECODE_REAL(p, limit, bufLimit);
     if (p->checkDicSize == 0 && p->processedPos >= p->prop.dicSize)
       p->checkDicSize = p->prop.dicSize;
-
-    LzmaDec_WriteRem(p, limit);
+    return res;
   }
-  while (p->dicPos < limit && p->buf < bufLimit && p->remainLen < kMatchSpecLenStart);
-
-  return 0;
 }
 
+
+
 typedef enum
 {
-  DUMMY_ERROR, /* unexpected end of input stream */
+  DUMMY_INPUT_EOF, /* need more input data */
   DUMMY_LIT,
   DUMMY_MATCH,
   DUMMY_REP
 } ELzmaDummy;
 
-static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inSize)
+
+#define IS_DUMMY_END_MARKER_POSSIBLE(dummyRes) ((dummyRes) == DUMMY_MATCH)
+
+static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, const Byte **bufOut)
 {
   UInt32 range = p->range;
   UInt32 code = p->code;
-  const Byte *bufLimit = buf + inSize;
+  const Byte *bufLimit = *bufOut;
   const CLzmaProb *probs = GET_PROBS;
   unsigned state = (unsigned)p->state;
   ELzmaDummy res;
 
+  for (;;)
   {
     const CLzmaProb *prob;
     UInt32 bound;
     unsigned ttt;
-    unsigned posState = CALC_POS_STATE(p->processedPos, (1 << p->prop.pb) - 1);
+    unsigned posState = CALC_POS_STATE(p->processedPos, ((unsigned)1 << p->prop.pb) - 1);
 
     prob = probs + IsMatch + COMBINED_PS_STATE;
     IF_BIT_0_CHECK(prob)
     {
       UPDATE_0_CHECK
 
-      /* if (bufLimit - buf >= 7) return DUMMY_LIT; */
-
       prob = probs + Literal;
       if (p->checkDicSize != 0 || p->processedPos != 0)
         prob += ((UInt32)LZMA_LIT_SIZE *
-            ((((p->processedPos) & ((1 << (p->prop.lp)) - 1)) << p->prop.lc) +
-            (p->dic[(p->dicPos == 0 ? p->dicBufSize : p->dicPos) - 1] >> (8 - p->prop.lc))));
+            ((((p->processedPos) & (((unsigned)1 << (p->prop.lp)) - 1)) << p->prop.lc) +
+            ((unsigned)p->dic[(p->dicPos == 0 ? p->dicBufSize : p->dicPos) - 1] >> (8 - p->prop.lc))));
 
       if (state < kNumLitStates)
       {
@@ -743,8 +797,7 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
           IF_BIT_0_CHECK(prob)
           {
             UPDATE_0_CHECK;
-            NORMALIZE_CHECK;
-            return DUMMY_REP;
+            break;
           }
           else
           {
@@ -820,8 +873,6 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
         {
           unsigned numDirectBits = ((posSlot >> 1) - 1);
 
-          /* if (bufLimit - buf >= 8) return DUMMY_MATCH; */
-
           if (posSlot < kEndPosModelIndex)
           {
             prob = probs + SpecPos + ((2 | (posSlot & 1)) << numDirectBits);
@@ -852,12 +903,15 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
         }
       }
     }
+    break;
   }
   NORMALIZE_CHECK;
+
+  *bufOut = buf;
   return res;
 }
 
-
+void LzmaDec_InitDicAndState(CLzmaDec *p, BoolInt initDic, BoolInt initState);
 void LzmaDec_InitDicAndState(CLzmaDec *p, BoolInt initDic, BoolInt initState)
 {
   p->remainLen = kMatchSpecLenStart + 1;
@@ -880,16 +934,41 @@ void LzmaDec_Init(CLzmaDec *p)
 }
 
 
+/*
+LZMA supports optional end_marker.
+So the decoder can lookahead for one additional LZMA-Symbol to check end_marker.
+That additional LZMA-Symbol can require up to LZMA_REQUIRED_INPUT_MAX bytes in input stream.
+When the decoder reaches dicLimit, it looks (finishMode) parameter:
+  if (finishMode == LZMA_FINISH_ANY), the decoder doesn't lookahead
+  if (finishMode != LZMA_FINISH_ANY), the decoder lookahead, if end_marker is possible for current position
+
+When the decoder lookahead, and the lookahead symbol is not end_marker, we have two ways:
+  1) Strict mode (default) : the decoder returns SZ_ERROR_DATA.
+  2) The relaxed mode (alternative mode) : we could return SZ_OK, and the caller
+     must check (status) value. The caller can show the error,
+     if the end of stream is expected, and the (status) is noit
+     LZMA_STATUS_FINISHED_WITH_MARK or LZMA_STATUS_MAYBE_FINISHED_WITHOUT_MARK.
+*/
+
+
+#define RETURN__NOT_FINISHED__FOR_FINISH \
+  *status = LZMA_STATUS_NOT_FINISHED; \
+  return SZ_ERROR_DATA; // for strict mode
+  // return SZ_OK; // for relaxed mode
+
+
 SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *srcLen,
     ELzmaFinishMode finishMode, ELzmaStatus *status)
 {
   SizeT inSize = *srcLen;
   (*srcLen) = 0;
-
   *status = LZMA_STATUS_NOT_SPECIFIED;
 
   if (p->remainLen > kMatchSpecLenStart)
   {
+    if (p->remainLen > kMatchSpecLenStart + 2)
+      return p->remainLen == kMatchSpecLen_Error_Fail ? SZ_ERROR_FAIL : SZ_ERROR_DATA;
+
     for (; inSize > 0 && p->tempBufSize < RC_INIT_SIZE; (*srcLen)++, inSize--)
       p->tempBuf[p->tempBufSize++] = *src++;
     if (p->tempBufSize != 0 && p->tempBuf[0] != 0)
@@ -904,6 +983,12 @@ SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *sr
       | ((UInt32)p->tempBuf[2] << 16)
       | ((UInt32)p->tempBuf[3] << 8)
       | ((UInt32)p->tempBuf[4]);
+
+    if (p->checkDicSize == 0
+        && p->processedPos == 0
+        && p->code >= kBadRepCode)
+      return SZ_ERROR_DATA;
+
     p->range = 0xFFFFFFFF;
     p->tempBufSize = 0;
 
@@ -921,10 +1006,21 @@ SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *sr
     p->remainLen = 0;
   }
 
-  LzmaDec_WriteRem(p, dicLimit);
-
-  while (p->remainLen != kMatchSpecLenStart)
+  for (;;)
   {
+    if (p->remainLen == kMatchSpecLenStart)
+    {
+      if (p->code != 0)
+        return SZ_ERROR_DATA;
+      *status = LZMA_STATUS_FINISHED_WITH_MARK;
+      return SZ_OK;
+    }
+
+    LzmaDec_WriteRem(p, dicLimit);
+
+    {
+      // (p->remainLen == 0 || p->dicPos == dicLimit)
+
       int checkEndMarkNow = 0;
 
       if (p->dicPos >= dicLimit)
@@ -941,92 +1037,174 @@ SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *sr
         }
         if (p->remainLen != 0)
         {
-          *status = LZMA_STATUS_NOT_FINISHED;
-          return SZ_ERROR_DATA;
+          RETURN__NOT_FINISHED__FOR_FINISH;
         }
         checkEndMarkNow = 1;
       }
 
+      // (p->remainLen == 0)
+
       if (p->tempBufSize == 0)
       {
-        SizeT processed;
         const Byte *bufLimit;
+        int dummyProcessed = -1;
+
         if (inSize < LZMA_REQUIRED_INPUT_MAX || checkEndMarkNow)
         {
-          int dummyRes = LzmaDec_TryDummy(p, src, inSize);
-          if (dummyRes == DUMMY_ERROR)
+          const Byte *bufOut = src + inSize;
+
+          ELzmaDummy dummyRes = LzmaDec_TryDummy(p, src, &bufOut);
+
+          if (dummyRes == DUMMY_INPUT_EOF)
           {
-            memcpy(p->tempBuf, src, inSize);
-            p->tempBufSize = (unsigned)inSize;
+            size_t i;
+            if (inSize >= LZMA_REQUIRED_INPUT_MAX)
+              break;
             (*srcLen) += inSize;
+            p->tempBufSize = (unsigned)inSize;
+            for (i = 0; i < inSize; i++)
+              p->tempBuf[i] = src[i];
             *status = LZMA_STATUS_NEEDS_MORE_INPUT;
             return SZ_OK;
           }
-          if (checkEndMarkNow && dummyRes != DUMMY_MATCH)
+
+          dummyProcessed = (int)(bufOut - src);
+          if ((unsigned)dummyProcessed > LZMA_REQUIRED_INPUT_MAX)
+            break;
+
+          if (checkEndMarkNow && !IS_DUMMY_END_MARKER_POSSIBLE(dummyRes))
           {
-            *status = LZMA_STATUS_NOT_FINISHED;
-            return SZ_ERROR_DATA;
+            unsigned i;
+            (*srcLen) += (unsigned)dummyProcessed;
+            p->tempBufSize = (unsigned)dummyProcessed;
+            for (i = 0; i < (unsigned)dummyProcessed; i++)
+              p->tempBuf[i] = src[i];
+            // p->remainLen = kMatchSpecLen_Error_Data;
+            RETURN__NOT_FINISHED__FOR_FINISH;
           }
+
           bufLimit = src;
+          // we will decode only one iteration
         }
         else
           bufLimit = src + inSize - LZMA_REQUIRED_INPUT_MAX;
+
         p->buf = src;
-        if (LzmaDec_DecodeReal2(p, dicLimit, bufLimit) != 0)
-          return SZ_ERROR_DATA;
-        processed = (SizeT)(p->buf - src);
-        (*srcLen) += processed;
-        src += processed;
-        inSize -= processed;
+
+        {
+          int res = LzmaDec_DecodeReal2(p, dicLimit, bufLimit);
+
+          SizeT processed = (SizeT)(p->buf - src);
+
+          if (dummyProcessed < 0)
+          {
+            if (processed > inSize)
+              break;
+          }
+          else if ((unsigned)dummyProcessed != processed)
+            break;
+
+          src += processed;
+          inSize -= processed;
+          (*srcLen) += processed;
+
+          if (res != SZ_OK)
+          {
+            p->remainLen = kMatchSpecLen_Error_Data;
+            return SZ_ERROR_DATA;
+          }
+        }
+        continue;
       }
-      else
+
       {
-        unsigned rem = p->tempBufSize, lookAhead = 0;
-        while (rem < LZMA_REQUIRED_INPUT_MAX && lookAhead < inSize)
-          p->tempBuf[rem++] = src[lookAhead++];
-        p->tempBufSize = rem;
+        // we have some data in (p->tempBuf)
+        // in strict mode: tempBufSize is not enough for one Symbol decoding.
+        // in relaxed mode: tempBufSize not larger than required for one Symbol decoding.
+
+        unsigned rem = p->tempBufSize;
+        unsigned ahead = 0;
+        int dummyProcessed = -1;
+
+        while (rem < LZMA_REQUIRED_INPUT_MAX && ahead < inSize)
+          p->tempBuf[rem++] = src[ahead++];
+
+        // ahead - the size of new data copied from (src) to (p->tempBuf)
+        // rem   - the size of temp buffer including new data from (src)
+
         if (rem < LZMA_REQUIRED_INPUT_MAX || checkEndMarkNow)
         {
-          int dummyRes = LzmaDec_TryDummy(p, p->tempBuf, (SizeT)rem);
-          if (dummyRes == DUMMY_ERROR)
+          const Byte *bufOut = p->tempBuf + rem;
+
+          ELzmaDummy dummyRes = LzmaDec_TryDummy(p, p->tempBuf, &bufOut);
+
+          if (dummyRes == DUMMY_INPUT_EOF)
           {
-            (*srcLen) += (SizeT)lookAhead;
+            if (rem >= LZMA_REQUIRED_INPUT_MAX)
+              break;
+            p->tempBufSize = rem;
+            (*srcLen) += (SizeT)ahead;
             *status = LZMA_STATUS_NEEDS_MORE_INPUT;
             return SZ_OK;
           }
-          if (checkEndMarkNow && dummyRes != DUMMY_MATCH)
+
+          dummyProcessed = (int)(bufOut - p->tempBuf);
+
+          if ((unsigned)dummyProcessed < p->tempBufSize)
+            break;
+
+          if (checkEndMarkNow && !IS_DUMMY_END_MARKER_POSSIBLE(dummyRes))
           {
-            *status = LZMA_STATUS_NOT_FINISHED;
-            return SZ_ERROR_DATA;
+            (*srcLen) += (unsigned)dummyProcessed - p->tempBufSize;
+            p->tempBufSize = (unsigned)dummyProcessed;
+            // p->remainLen = kMatchSpecLen_Error_Data;
+            RETURN__NOT_FINISHED__FOR_FINISH;
           }
         }
+
         p->buf = p->tempBuf;
-        if (LzmaDec_DecodeReal2(p, dicLimit, p->buf) != 0)
-          return SZ_ERROR_DATA;
 
         {
-          unsigned kkk = (unsigned)(p->buf - p->tempBuf);
-          if (rem < kkk)
-            return SZ_ERROR_FAIL; /* some internal error */
-          rem -= kkk;
-          if (lookAhead < rem)
-            return SZ_ERROR_FAIL; /* some internal error */
-          lookAhead -= rem;
+          // we decode one symbol from (p->tempBuf) here, so the (bufLimit) is equal to (p->buf)
+          int res = LzmaDec_DecodeReal2(p, dicLimit, p->buf);
+
+          SizeT processed = (SizeT)(p->buf - p->tempBuf);
+          rem = p->tempBufSize;
+
+          if (dummyProcessed < 0)
+          {
+            if (processed > LZMA_REQUIRED_INPUT_MAX)
+              break;
+            if (processed < rem)
+              break;
+          }
+          else if ((unsigned)dummyProcessed != processed)
+            break;
+
+          processed -= rem;
+
+          src += processed;
+          inSize -= processed;
+          (*srcLen) += processed;
+          p->tempBufSize = 0;
+
+          if (res != SZ_OK)
+          {
+            p->remainLen = kMatchSpecLen_Error_Data;
+            return SZ_ERROR_DATA;
+          }
         }
-        (*srcLen) += (SizeT)lookAhead;
-        src += lookAhead;
-        inSize -= (SizeT)lookAhead;
-        p->tempBufSize = 0;
       }
+    }
   }
 
-  if (p->code != 0)
-    return SZ_ERROR_DATA;
-  *status = LZMA_STATUS_FINISHED_WITH_MARK;
-  return SZ_OK;
+  /*  Some unexpected error: internal error of code, memory corruption or hardware failure */
+  p->remainLen = kMatchSpecLen_Error_Fail;
+  return SZ_ERROR_FAIL;
 }
 
 
+
 SRes LzmaDec_DecodeToBuf(CLzmaDec *p, Byte *dest, SizeT *destLen, const Byte *src, SizeT *srcLen, ELzmaFinishMode finishMode, ELzmaStatus *status)
 {
   SizeT outSize = *destLen;
diff --git a/lib/lzma/LzmaDec.h b/lib/lzma/LzmaDec.h
index f3702f5ce608..3ab4920037c1 100644
--- a/lib/lzma/LzmaDec.h
+++ b/lib/lzma/LzmaDec.h
@@ -1,5 +1,5 @@
 /* LzmaDec.h -- LZMA Decoder
-2018-04-21 : Igor Pavlov : Public domain */
+2020-03-19 : Igor Pavlov : Public domain */
 
 #ifndef __LZMA_DEC_H
 #define __LZMA_DEC_H
@@ -181,6 +181,7 @@ Returns:
       LZMA_STATUS_NEEDS_MORE_INPUT
       LZMA_STATUS_MAYBE_FINISHED_WITHOUT_MARK
   SZ_ERROR_DATA - Data error
+  SZ_ERROR_FAIL - Some unexpected error: internal error of code, memory corruption or hardware failure
 */
 
 SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit,
@@ -223,6 +224,7 @@ Returns:
   SZ_ERROR_MEM  - Memory allocation error
   SZ_ERROR_UNSUPPORTED - Unsupported properties
   SZ_ERROR_INPUT_EOF - It needs more bytes in input buffer (src).
+  SZ_ERROR_FAIL - Some unexpected error: internal error of code, memory corruption or hardware failure
 */
 
 SRes LzmaDecode(Byte *dest, SizeT *destLen, const Byte *src, SizeT *srcLen,
-- 
2.43.0

