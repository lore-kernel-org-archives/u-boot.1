Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59471D711CD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:24:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58F43838A5;
	Fri, 19 Dec 2025 00:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L/9nVjmm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96A72835C6; Fri, 19 Dec 2025 00:23:10 +0100 (CET)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1B25833C6
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7c7533dbd87so992548a34.2
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766100185; x=1766704985; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kyhkY1hbhc2rO50MI8iWtRHg4jjyo+4khwnwoMfeh78=;
 b=L/9nVjmmQ9MC7ELmM1OMO/McoPxF4SSGpjut8PvhKOM+FBXm8dQGDGYaAn5lErZJfI
 ggWlRirnCV1FmiXCPksjX3vPQU58g54PoAom0QnSoNbgfgVN/RU42OadRzm2vhmymrA8
 n5zWt6QuC7NVj+CCTkDsuQL+2ETN4jlAVutig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100185; x=1766704985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kyhkY1hbhc2rO50MI8iWtRHg4jjyo+4khwnwoMfeh78=;
 b=Q+Td7IPqm2mgFyUxV1sFRQ0IYQq9oYTMId/Ob2TShF0IvED/Z9Wsc9lprFeIGhFOpZ
 SGRfx5FjeoiiW9fu+uIbZqrxJIJsWjUBf1BUgcOmcjt3te5fRIfX6UoXXKsabKj02PAv
 dpxLY33iYWGowr79nfq66lEJkmkqmobkJ8spDU2K+yugXt9LbTAxagweZvSjCJN8SfBO
 WD6cZ7TlFLR/gMoD6CENIszLYNuF2DMZGuTQQxWOzuq6JF6OjMkdvPt4e4p7YiFgQYzE
 ECGvk9vQDw1rrz79Hn2CDGHcDAjmfhSa9sZLta4MGCTEyzYxuiqD6vHJJuEI6hiL+5bm
 RgwA==
X-Gm-Message-State: AOJu0YyCvycRXPZH6Yk4QCzhfpUajadOrRw8K36vXYnIDbsPIZIoYrll
 K8JPy7l4e0JZMdHoAfOZrtyHOH0MKPRfvx6r7U5qnPup9CieaGI7d2m7TfuyuKBRDOOPP8IfHEa
 CNaPxANU=
X-Gm-Gg: AY/fxX7AVmylqbik95MZ+VSjV+Oc2n2ZFhgb55agzFejb7SSg5IPI75N7c4qSe5kOxd
 jlHNrorFzyy+6a4Tgd+SUl+c2GhpB3/Vqwr7c9oFOAc12NgA83l2gyGs4fIEueJjm1iaQ2548a5
 bSphdW6XK8kxc2qvN2QuJSZPlRAfPNOvKtJ1lL57/3VtXkQI7BR2QHKBYVTp4kg0OfZZ4s8XQl1
 RBM2moHVHokFewC/0XEZWttz9z2/OERoFMeaxKA4MX3pB0pN1keJAoPSukwpbo+V9cEI6mqqax6
 Qqf0LFsLNNYlj8a1SlmiD5kwQQF7HPd5mPB0PRiZXCIAa8OyEi2gzpBgh/fsHZ2HQVt3VFU49kN
 DbZWBbraPNZIKfWtYDYoJo4QDDHkzpkgVuEkHyqXI0ZFSSkLyEMM+yCTw9fssoGwTBED9YPfYOj
 bN8Ks0qcHlaymEuFPtFbyLH2j90WsVimWD5Ci93HIIR2gxVgSDdvAFzNY35LUORH4=
X-Google-Smtp-Source: AGHT+IFsD8jeKwj61hMCqcurrupPsGGR06ZqyYhx/p8VBowr1sZdcn5tJD0cJ3x1+2b9CHOPYJcDTQ==
X-Received: by 2002:a05:6808:219a:b0:450:d1ba:151a with SMTP id
 5614622812f47-457b1e54a38mr710047b6e.13.1766100185105; 
 Thu, 18 Dec 2025 15:23:05 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3cc0928sm295333b6e.10.2025.12.18.15.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:23:04 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
Subject: [RFC PATCH 7/9] lzma: Update 21.07 -> 25.01
Date: Thu, 18 Dec 2025 17:10:19 -0600
Message-ID: <20251218232255.3934258-8-trini@konsulko.com>
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

These are only upstream changes and nothing local.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/lzma/7zTypes.h  | 270 ++++++++++++++++++++++++++++----------------
 lib/lzma/Compiler.h | 247 ++++++++++++++++++++++++++++++++++++----
 lib/lzma/LzmaDec.c  | 190 +++++++++++++++----------------
 lib/lzma/LzmaDec.h  |  17 +--
 lib/lzma/Makefile   |   4 +-
 lib/lzma/Precomp.h  | 127 ++++++++++++++++++++-
 6 files changed, 626 insertions(+), 229 deletions(-)

diff --git a/lib/lzma/7zTypes.h b/lib/lzma/7zTypes.h
index 0b1fbb637793..9a605468643b 100644
--- a/lib/lzma/7zTypes.h
+++ b/lib/lzma/7zTypes.h
@@ -1,8 +1,8 @@
 /* 7zTypes.h -- Basic types
-2021-12-25 : Igor Pavlov : Public domain */
+2024-01-24 : Igor Pavlov : Public domain */
 
-#ifndef __7Z_TYPES_H
-#define __7Z_TYPES_H
+#ifndef ZIP7_7Z_TYPES_H
+#define ZIP7_7Z_TYPES_H
 
 #ifdef _WIN32
 /* #include <windows.h> */
@@ -52,6 +52,11 @@ typedef int SRes;
     #define MY_ALIGN(n)
   #endif
 #else
+  /*
+  // C11/C++11:
+  #include <stdalign.h>
+  #define MY_ALIGN(n) alignas(n)
+  */
   #define MY_ALIGN(n) __attribute__ ((aligned(n)))
 #endif
 
@@ -62,7 +67,7 @@ typedef int SRes;
 typedef unsigned WRes;
 #define MY_SRes_HRESULT_FROM_WRes(x) HRESULT_FROM_WIN32(x)
 
-// #define MY_HRES_ERROR__INTERNAL_ERROR  MY_SRes_HRESULT_FROM_WRes(ERROR_INTERNAL_ERROR)
+// #define MY_HRES_ERROR_INTERNAL_ERROR  MY_SRes_HRESULT_FROM_WRes(ERROR_INTERNAL_ERROR)
 
 #else // _WIN32
 
@@ -70,13 +75,13 @@ typedef unsigned WRes;
 typedef int WRes;
 
 // (FACILITY_ERRNO = 0x800) is 7zip's FACILITY constant to represent (errno) errors in HRESULT
-#define MY__FACILITY_ERRNO  0x800
-#define MY__FACILITY_WIN32  7
-#define MY__FACILITY__WRes  MY__FACILITY_ERRNO
+#define MY_FACILITY_ERRNO  0x800
+#define MY_FACILITY_WIN32  7
+#define MY_FACILITY_WRes  MY_FACILITY_ERRNO
 
 #define MY_HRESULT_FROM_errno_CONST_ERROR(x) ((HRESULT)( \
           ( (HRESULT)(x) & 0x0000FFFF) \
-          | (MY__FACILITY__WRes << 16)  \
+          | (MY_FACILITY_WRes << 16)  \
           | (HRESULT)0x80000000 ))
 
 #define MY_SRes_HRESULT_FROM_WRes(x) \
@@ -120,17 +125,17 @@ typedef int WRes;
 #define ERROR_INVALID_REPARSE_DATA  ((HRESULT)0x80071128L)
 #define ERROR_REPARSE_TAG_INVALID   ((HRESULT)0x80071129L)
 
-// if (MY__FACILITY__WRes != FACILITY_WIN32),
+// if (MY_FACILITY_WRes != FACILITY_WIN32),
 // we use FACILITY_WIN32 for COM errors:
 #define E_OUTOFMEMORY               ((HRESULT)0x8007000EL)
 #define E_INVALIDARG                ((HRESULT)0x80070057L)
-#define MY__E_ERROR_NEGATIVE_SEEK   ((HRESULT)0x80070083L)
+#define MY_E_ERROR_NEGATIVE_SEEK    ((HRESULT)0x80070083L)
 
 /*
 // we can use FACILITY_ERRNO for some COM errors, that have errno equivalents:
 #define E_OUTOFMEMORY             MY_HRESULT_FROM_errno_CONST_ERROR(ENOMEM)
 #define E_INVALIDARG              MY_HRESULT_FROM_errno_CONST_ERROR(EINVAL)
-#define MY__E_ERROR_NEGATIVE_SEEK MY_HRESULT_FROM_errno_CONST_ERROR(EINVAL)
+#define MY_E_ERROR_NEGATIVE_SEEK  MY_HRESULT_FROM_errno_CONST_ERROR(EINVAL)
 */
 
 // gcc / clang : (sizeof(long) == sizeof(void*)) in 32/64 bits
@@ -162,18 +167,18 @@ typedef unsigned long UINT_PTR;
 
 
 #ifndef RINOK
-#define RINOK(x) { int __result__ = (x); if (__result__ != 0) return __result__; }
+#define RINOK(x) { const int _result_ = (x); if (_result_ != 0) return _result_; }
 #endif
 
 #ifndef RINOK_WRes
-#define RINOK_WRes(x) { WRes __result__ = (x); if (__result__ != 0) return __result__; }
+#define RINOK_WRes(x) { const WRes _result_ = (x); if (_result_ != 0) return _result_; }
 #endif
 
 typedef unsigned char Byte;
 typedef short Int16;
 typedef unsigned short UInt16;
 
-#ifdef _LZMA_UINT32_IS_ULONG
+#ifdef Z7_DECL_Int32_AS_long
 typedef long Int32;
 typedef unsigned long UInt32;
 #else
@@ -214,37 +219,51 @@ typedef size_t SIZE_T;
 #endif //  _WIN32
 
 
-#define MY_HRES_ERROR__INTERNAL_ERROR  ((HRESULT)0x8007054FL)
+#define MY_HRES_ERROR_INTERNAL_ERROR  ((HRESULT)0x8007054FL)
 
 
-#ifdef _SZ_NO_INT_64
-
-/* define _SZ_NO_INT_64, if your compiler doesn't support 64-bit integers.
-   NOTES: Some code will work incorrectly in that case! */
+#ifdef Z7_DECL_Int64_AS_long
 
 typedef long Int64;
 typedef unsigned long UInt64;
 
 #else
 
-#if defined(_MSC_VER) || defined(__BORLANDC__)
+#if (defined(_MSC_VER) || defined(__BORLANDC__)) && !defined(__clang__)
 typedef __int64 Int64;
 typedef unsigned __int64 UInt64;
-#define UINT64_CONST(n) n
+#else
+#if defined(__clang__) || defined(__GNUC__)
+#include <stdint.h>
+typedef int64_t Int64;
+typedef uint64_t UInt64;
 #else
 typedef long long int Int64;
 typedef unsigned long long int UInt64;
-#define UINT64_CONST(n) n ## ULL
+// #define UINT64_CONST(n) n ## ULL
+#endif
 #endif
 
 #endif
 
-#ifdef _LZMA_NO_SYSTEM_SIZE_T
-typedef UInt32 SizeT;
+#define UINT64_CONST(n) n
+
+
+#ifdef Z7_DECL_SizeT_AS_unsigned_int
+typedef unsigned int SizeT;
 #else
 typedef size_t SizeT;
 #endif
 
+/*
+#if (defined(_MSC_VER) && _MSC_VER <= 1200)
+typedef size_t MY_uintptr_t;
+#else
+#include <stdint.h>
+typedef uintptr_t MY_uintptr_t;
+#endif
+*/
+
 typedef int BoolInt;
 /* typedef BoolInt Bool; */
 #define True 1
@@ -252,23 +271,23 @@ typedef int BoolInt;
 
 
 #ifdef _WIN32
-#define MY_STD_CALL __stdcall
+#define Z7_STDCALL __stdcall
 #else
-#define MY_STD_CALL
+#define Z7_STDCALL
 #endif
 
 #ifdef _MSC_VER
 
 #if _MSC_VER >= 1300
-#define MY_NO_INLINE __declspec(noinline)
+#define Z7_NO_INLINE __declspec(noinline)
 #else
-#define MY_NO_INLINE
+#define Z7_NO_INLINE
 #endif
 
-#define MY_FORCE_INLINE __forceinline
+#define Z7_FORCE_INLINE __forceinline
 
-#define MY_CDECL __cdecl
-#define MY_FAST_CALL __fastcall
+#define Z7_CDECL      __cdecl
+#define Z7_FASTCALL  __fastcall
 
 #else //  _MSC_VER
 
@@ -276,27 +295,25 @@ typedef int BoolInt;
     || (defined(__clang__) && (__clang_major__ >= 4)) \
     || defined(__INTEL_COMPILER) \
     || defined(__xlC__)
-#define MY_NO_INLINE __attribute__((noinline))
-// #define MY_FORCE_INLINE __attribute__((always_inline)) inline
+#define Z7_NO_INLINE      __attribute__((noinline))
+#define Z7_FORCE_INLINE   __attribute__((always_inline)) inline
 #else
-#define MY_NO_INLINE
+#define Z7_NO_INLINE
+#define Z7_FORCE_INLINE
 #endif
 
-#define MY_FORCE_INLINE
-
-
-#define MY_CDECL
+#define Z7_CDECL
 
 #if  defined(_M_IX86) \
   || defined(__i386__)
-// #define MY_FAST_CALL __attribute__((fastcall))
-// #define MY_FAST_CALL __attribute__((cdecl))
-#define MY_FAST_CALL
+// #define Z7_FASTCALL __attribute__((fastcall))
+// #define Z7_FASTCALL __attribute__((cdecl))
+#define Z7_FASTCALL
 #elif defined(MY_CPU_AMD64)
-// #define MY_FAST_CALL __attribute__((ms_abi))
-#define MY_FAST_CALL
+// #define Z7_FASTCALL __attribute__((ms_abi))
+#define Z7_FASTCALL
 #else
-#define MY_FAST_CALL
+#define Z7_FASTCALL
 #endif
 
 #endif //  _MSC_VER
@@ -304,41 +321,49 @@ typedef int BoolInt;
 
 /* The following interfaces use first parameter as pointer to structure */
 
-typedef struct IByteIn IByteIn;
-struct IByteIn
+// #define Z7_C_IFACE_CONST_QUAL
+#define Z7_C_IFACE_CONST_QUAL const
+
+#define Z7_C_IFACE_DECL(a) \
+  struct a ## _; \
+  typedef Z7_C_IFACE_CONST_QUAL struct a ## _ * a ## Ptr; \
+  typedef struct a ## _ a; \
+  struct a ## _
+
+
+Z7_C_IFACE_DECL (IByteIn)
 {
-  Byte (*Read)(const IByteIn *p); /* reads one byte, returns 0 in case of EOF or error */
+  Byte (*Read)(IByteInPtr p); /* reads one byte, returns 0 in case of EOF or error */
 };
 #define IByteIn_Read(p) (p)->Read(p)
 
 
-typedef struct IByteOut IByteOut;
-struct IByteOut
+Z7_C_IFACE_DECL (IByteOut)
 {
-  void (*Write)(const IByteOut *p, Byte b);
+  void (*Write)(IByteOutPtr p, Byte b);
 };
 #define IByteOut_Write(p, b) (p)->Write(p, b)
 
 
-typedef struct ISeqInStream ISeqInStream;
-struct ISeqInStream
+Z7_C_IFACE_DECL (ISeqInStream)
 {
-  SRes (*Read)(const ISeqInStream *p, void *buf, size_t *size);
+  SRes (*Read)(ISeqInStreamPtr p, void *buf, size_t *size);
     /* if (input(*size) != 0 && output(*size) == 0) means end_of_stream.
        (output(*size) < input(*size)) is allowed */
 };
 #define ISeqInStream_Read(p, buf, size) (p)->Read(p, buf, size)
 
+/* try to read as much as avail in stream and limited by (*processedSize) */
+SRes SeqInStream_ReadMax(ISeqInStreamPtr stream, void *buf, size_t *processedSize);
 /* it can return SZ_ERROR_INPUT_EOF */
-SRes SeqInStream_Read(const ISeqInStream *stream, void *buf, size_t size);
-SRes SeqInStream_Read2(const ISeqInStream *stream, void *buf, size_t size, SRes errorType);
-SRes SeqInStream_ReadByte(const ISeqInStream *stream, Byte *buf);
+// SRes SeqInStream_Read(ISeqInStreamPtr stream, void *buf, size_t size);
+// SRes SeqInStream_Read2(ISeqInStreamPtr stream, void *buf, size_t size, SRes errorType);
+SRes SeqInStream_ReadByte(ISeqInStreamPtr stream, Byte *buf);
 
 
-typedef struct ISeqOutStream ISeqOutStream;
-struct ISeqOutStream
+Z7_C_IFACE_DECL (ISeqOutStream)
 {
-  size_t (*Write)(const ISeqOutStream *p, const void *buf, size_t size);
+  size_t (*Write)(ISeqOutStreamPtr p, const void *buf, size_t size);
     /* Returns: result - the number of actually written bytes.
        (result < size) means error */
 };
@@ -352,29 +377,26 @@ typedef enum
 } ESzSeek;
 
 
-typedef struct ISeekInStream ISeekInStream;
-struct ISeekInStream
+Z7_C_IFACE_DECL (ISeekInStream)
 {
-  SRes (*Read)(const ISeekInStream *p, void *buf, size_t *size);  /* same as ISeqInStream::Read */
-  SRes (*Seek)(const ISeekInStream *p, Int64 *pos, ESzSeek origin);
+  SRes (*Read)(ISeekInStreamPtr p, void *buf, size_t *size);  /* same as ISeqInStream::Read */
+  SRes (*Seek)(ISeekInStreamPtr p, Int64 *pos, ESzSeek origin);
 };
 #define ISeekInStream_Read(p, buf, size)   (p)->Read(p, buf, size)
 #define ISeekInStream_Seek(p, pos, origin) (p)->Seek(p, pos, origin)
 
 
-typedef struct ILookInStream ILookInStream;
-struct ILookInStream
+Z7_C_IFACE_DECL (ILookInStream)
 {
-  SRes (*Look)(const ILookInStream *p, const void **buf, size_t *size);
+  SRes (*Look)(ILookInStreamPtr p, const void **buf, size_t *size);
     /* if (input(*size) != 0 && output(*size) == 0) means end_of_stream.
        (output(*size) > input(*size)) is not allowed
        (output(*size) < input(*size)) is allowed */
-  SRes (*Skip)(const ILookInStream *p, size_t offset);
+  SRes (*Skip)(ILookInStreamPtr p, size_t offset);
     /* offset must be <= output(*size) of Look */
-
-  SRes (*Read)(const ILookInStream *p, void *buf, size_t *size);
+  SRes (*Read)(ILookInStreamPtr p, void *buf, size_t *size);
     /* reads directly (without buffer). It's same as ISeqInStream::Read */
-  SRes (*Seek)(const ILookInStream *p, Int64 *pos, ESzSeek origin);
+  SRes (*Seek)(ILookInStreamPtr p, Int64 *pos, ESzSeek origin);
 };
 
 #define ILookInStream_Look(p, buf, size)   (p)->Look(p, buf, size)
@@ -383,19 +405,18 @@ struct ILookInStream
 #define ILookInStream_Seek(p, pos, origin) (p)->Seek(p, pos, origin)
 
 
-SRes LookInStream_LookRead(const ILookInStream *stream, void *buf, size_t *size);
-SRes LookInStream_SeekTo(const ILookInStream *stream, UInt64 offset);
+SRes LookInStream_LookRead(ILookInStreamPtr stream, void *buf, size_t *size);
+SRes LookInStream_SeekTo(ILookInStreamPtr stream, UInt64 offset);
 
 /* reads via ILookInStream::Read */
-SRes LookInStream_Read2(const ILookInStream *stream, void *buf, size_t size, SRes errorType);
-SRes LookInStream_Read(const ILookInStream *stream, void *buf, size_t size);
-
+SRes LookInStream_Read2(ILookInStreamPtr stream, void *buf, size_t size, SRes errorType);
+SRes LookInStream_Read(ILookInStreamPtr stream, void *buf, size_t size);
 
 
 typedef struct
 {
   ILookInStream vt;
-  const ISeekInStream *realStream;
+  ISeekInStreamPtr realStream;
  
   size_t pos;
   size_t size; /* it's data size */
@@ -407,13 +428,13 @@ typedef struct
 
 void LookToRead2_CreateVTable(CLookToRead2 *p, int lookahead);
 
-#define LookToRead2_Init(p) { (p)->pos = (p)->size = 0; }
+#define LookToRead2_INIT(p) { (p)->pos = (p)->size = 0; }
 
 
 typedef struct
 {
   ISeqInStream vt;
-  const ILookInStream *realStream;
+  ILookInStreamPtr realStream;
 } CSecToLook;
 
 void SecToLook_CreateVTable(CSecToLook *p);
@@ -423,20 +444,19 @@ void SecToLook_CreateVTable(CSecToLook *p);
 typedef struct
 {
   ISeqInStream vt;
-  const ILookInStream *realStream;
+  ILookInStreamPtr realStream;
 } CSecToRead;
 
 void SecToRead_CreateVTable(CSecToRead *p);
 
 
-typedef struct ICompressProgress ICompressProgress;
-
-struct ICompressProgress
+Z7_C_IFACE_DECL (ICompressProgress)
 {
-  SRes (*Progress)(const ICompressProgress *p, UInt64 inSize, UInt64 outSize);
+  SRes (*Progress)(ICompressProgressPtr p, UInt64 inSize, UInt64 outSize);
     /* Returns: result. (result != SZ_OK) means break.
        Value (UInt64)(Int64)-1 for size means unknown value. */
 };
+
 #define ICompressProgress_Progress(p, inSize, outSize) (p)->Progress(p, inSize, outSize)
 
 
@@ -474,13 +494,13 @@ struct ISzAlloc
 
 
 
-#ifndef MY_container_of
+#ifndef Z7_container_of
 
 /*
-#define MY_container_of(ptr, type, m) container_of(ptr, type, m)
-#define MY_container_of(ptr, type, m) CONTAINING_RECORD(ptr, type, m)
-#define MY_container_of(ptr, type, m) ((type *)((char *)(ptr) - offsetof(type, m)))
-#define MY_container_of(ptr, type, m) (&((type *)0)->m == (ptr), ((type *)(((char *)(ptr)) - MY_offsetof(type, m))))
+#define Z7_container_of(ptr, type, m) container_of(ptr, type, m)
+#define Z7_container_of(ptr, type, m) CONTAINING_RECORD(ptr, type, m)
+#define Z7_container_of(ptr, type, m) ((type *)((char *)(ptr) - offsetof(type, m)))
+#define Z7_container_of(ptr, type, m) (&((type *)0)->m == (ptr), ((type *)(((char *)(ptr)) - MY_offsetof(type, m))))
 */
 
 /*
@@ -489,24 +509,64 @@ struct ISzAlloc
     GCC 4.8.1 : classes with non-public variable members"
 */
 
-#define MY_container_of(ptr, type, m) ((type *)(void *)((char *)(void *)(1 ? (ptr) : &((type *)0)->m) - MY_offsetof(type, m)))
+#define Z7_container_of(ptr, type, m) \
+  ((type *)(void *)((char *)(void *) \
+  (1 ? (ptr) : &((type *)NULL)->m) - MY_offsetof(type, m)))
 
-#endif
-
-#define CONTAINER_FROM_VTBL_SIMPLE(ptr, type, m) ((type *)(void *)(ptr))
+#define Z7_container_of_CONST(ptr, type, m) \
+  ((const type *)(const void *)((const char *)(const void *) \
+  (1 ? (ptr) : &((type *)NULL)->m) - MY_offsetof(type, m)))
 
 /*
-#define CONTAINER_FROM_VTBL(ptr, type, m) CONTAINER_FROM_VTBL_SIMPLE(ptr, type, m)
+#define Z7_container_of_NON_CONST_FROM_CONST(ptr, type, m) \
+  ((type *)(void *)(const void *)((const char *)(const void *) \
+  (1 ? (ptr) : &((type *)NULL)->m) - MY_offsetof(type, m)))
 */
-#define CONTAINER_FROM_VTBL(ptr, type, m) MY_container_of(ptr, type, m)
 
-#define CONTAINER_FROM_VTBL_CLS(ptr, type, m) CONTAINER_FROM_VTBL_SIMPLE(ptr, type, m)
+#endif
+
+#define Z7_CONTAINER_FROM_VTBL_SIMPLE(ptr, type, m) ((type *)(void *)(ptr))
+
+// #define Z7_CONTAINER_FROM_VTBL(ptr, type, m) Z7_CONTAINER_FROM_VTBL_SIMPLE(ptr, type, m)
+#define Z7_CONTAINER_FROM_VTBL(ptr, type, m) Z7_container_of(ptr, type, m)
+// #define Z7_CONTAINER_FROM_VTBL(ptr, type, m) Z7_container_of_NON_CONST_FROM_CONST(ptr, type, m)
+
+#define Z7_CONTAINER_FROM_VTBL_CONST(ptr, type, m) Z7_container_of_CONST(ptr, type, m)
+
+#define Z7_CONTAINER_FROM_VTBL_CLS(ptr, type, m) Z7_CONTAINER_FROM_VTBL_SIMPLE(ptr, type, m)
 /*
-#define CONTAINER_FROM_VTBL_CLS(ptr, type, m) CONTAINER_FROM_VTBL(ptr, type, m)
+#define Z7_CONTAINER_FROM_VTBL_CLS(ptr, type, m) Z7_CONTAINER_FROM_VTBL(ptr, type, m)
 */
+#if defined (__clang__) || defined(__GNUC__)
+#define Z7_DIAGNOSTIC_IGNORE_BEGIN_CAST_QUAL \
+  _Pragma("GCC diagnostic push") \
+  _Pragma("GCC diagnostic ignored \"-Wcast-qual\"")
+#define Z7_DIAGNOSTIC_IGNORE_END_CAST_QUAL \
+  _Pragma("GCC diagnostic pop")
+#else
+#define Z7_DIAGNOSTIC_IGNORE_BEGIN_CAST_QUAL
+#define Z7_DIAGNOSTIC_IGNORE_END_CAST_QUAL
+#endif
+
+#define Z7_CONTAINER_FROM_VTBL_TO_DECL_VAR(ptr, type, m, p) \
+  Z7_DIAGNOSTIC_IGNORE_BEGIN_CAST_QUAL \
+  type *p = Z7_CONTAINER_FROM_VTBL(ptr, type, m); \
+  Z7_DIAGNOSTIC_IGNORE_END_CAST_QUAL
+
+#define Z7_CONTAINER_FROM_VTBL_TO_DECL_VAR_pp_vt_p(type) \
+  Z7_CONTAINER_FROM_VTBL_TO_DECL_VAR(pp, type, vt, p)
+
 
+// #define ZIP7_DECLARE_HANDLE(name)  typedef void *name;
+#define Z7_DECLARE_HANDLE(name)  struct name##_dummy{int unused;}; typedef struct name##_dummy *name;
+
+
+#define Z7_memset_0_ARRAY(a)  memset((a), 0, sizeof(a))
+
+#ifndef Z7_ARRAY_SIZE
+#define Z7_ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
+#endif
 
-#define MY_memset_0_ARRAY(a) memset((a), 0, sizeof(a))
 
 #ifdef _WIN32
 
@@ -524,6 +584,22 @@ struct ISzAlloc
 
 #endif
 
+#define k_PropVar_TimePrec_0        0
+#define k_PropVar_TimePrec_Unix     1
+#define k_PropVar_TimePrec_DOS      2
+#define k_PropVar_TimePrec_HighPrec 3
+#define k_PropVar_TimePrec_Base     16
+#define k_PropVar_TimePrec_100ns (k_PropVar_TimePrec_Base + 7)
+#define k_PropVar_TimePrec_1ns   (k_PropVar_TimePrec_Base + 9)
+
 EXTERN_C_END
 
 #endif
+
+/*
+#ifndef Z7_ST
+#ifdef _7ZIP_ST
+#define Z7_ST
+#endif
+#endif
+*/
diff --git a/lib/lzma/Compiler.h b/lib/lzma/Compiler.h
index a9816fa5ad01..b266b277bdb3 100644
--- a/lib/lzma/Compiler.h
+++ b/lib/lzma/Compiler.h
@@ -1,12 +1,105 @@
-/* Compiler.h
-2021-01-05 : Igor Pavlov : Public domain */
+/* Compiler.h : Compiler specific defines and pragmas
+: Igor Pavlov : Public domain */
 
-#ifndef __7Z_COMPILER_H
-#define __7Z_COMPILER_H
+#ifndef ZIP7_INC_COMPILER_H
+#define ZIP7_INC_COMPILER_H
 
-  #ifdef __clang__
-    #pragma clang diagnostic ignored "-Wunused-private-field"
+#if defined(__clang__)
+# define Z7_CLANG_VERSION  (__clang_major__ * 10000 + __clang_minor__ * 100 + __clang_patchlevel__)
+#endif
+#if defined(__clang__) && defined(__apple_build_version__)
+# define Z7_APPLE_CLANG_VERSION   Z7_CLANG_VERSION
+#elif defined(__clang__)
+# define Z7_LLVM_CLANG_VERSION    Z7_CLANG_VERSION
+#elif defined(__GNUC__)
+# define Z7_GCC_VERSION (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__)
+#endif
+
+#ifdef _MSC_VER
+#if !defined(__clang__) && !defined(__GNUC__)
+#define Z7_MSC_VER_ORIGINAL _MSC_VER
+#endif
+#endif
+
+#if defined(__MINGW32__) || defined(__MINGW64__)
+#define Z7_MINGW
+#endif
+
+#if defined(__LCC__) && (defined(__MCST__) || defined(__e2k__))
+#define Z7_MCST_LCC
+#define Z7_MCST_LCC_VERSION (__LCC__ * 100 + __LCC_MINOR__)
+#endif
+
+/*
+#if defined(__AVX2__) \
+    || defined(Z7_GCC_VERSION) && (Z7_GCC_VERSION >= 40900) \
+    || defined(Z7_APPLE_CLANG_VERSION) && (Z7_APPLE_CLANG_VERSION >= 40600) \
+    || defined(Z7_LLVM_CLANG_VERSION) && (Z7_LLVM_CLANG_VERSION >= 30100) \
+    || defined(Z7_MSC_VER_ORIGINAL) && (Z7_MSC_VER_ORIGINAL >= 1800) \
+    || defined(__INTEL_COMPILER) && (__INTEL_COMPILER >= 1400)
+    #define Z7_COMPILER_AVX2_SUPPORTED
   #endif
+#endif
+*/
+
+// #pragma GCC diagnostic ignored "-Wunknown-pragmas"
+
+#ifdef __clang__
+// padding size of '' with 4 bytes to alignment boundary
+#pragma GCC diagnostic ignored "-Wpadded"
+
+#if defined(Z7_LLVM_CLANG_VERSION) && (__clang_major__ == 13) \
+  && defined(__FreeBSD__)
+// freebsd:
+#pragma GCC diagnostic ignored "-Wexcess-padding"
+#endif
+
+#if __clang_major__ >= 16
+#pragma GCC diagnostic ignored "-Wunsafe-buffer-usage"
+#endif
+
+#if __clang_major__ == 13
+#if defined(__SIZEOF_POINTER__) && (__SIZEOF_POINTER__ == 16)
+// cheri
+#pragma GCC diagnostic ignored "-Wcapability-to-integer-cast"
+#endif
+#endif
+
+#if __clang_major__ == 13
+  // for <arm_neon.h>
+  #pragma GCC diagnostic ignored "-Wreserved-identifier"
+#endif
+
+#endif // __clang__
+
+#if defined(_WIN32) && defined(__clang__) && __clang_major__ >= 16
+// #pragma GCC diagnostic ignored "-Wcast-function-type-strict"
+#define Z7_DIAGNOSTIC_IGNORE_CAST_FUNCTION \
+  _Pragma("GCC diagnostic ignored \"-Wcast-function-type-strict\"")
+#else
+#define Z7_DIAGNOSTIC_IGNORE_CAST_FUNCTION
+#endif
+
+typedef void (*Z7_void_Function)(void);
+#if defined(__clang__) || defined(__GNUC__)
+#define Z7_CAST_FUNC_C  (Z7_void_Function)
+#elif defined(_MSC_VER) && _MSC_VER > 1920
+#define Z7_CAST_FUNC_C  (void *)
+// #pragma warning(disable : 4191) // 'type cast': unsafe conversion from 'FARPROC' to 'void (__cdecl *)()'
+#else
+#define Z7_CAST_FUNC_C
+#endif
+/*
+#if (defined(__GNUC__) && (__GNUC__ >= 8)) || defined(__clang__)
+  // #pragma GCC diagnostic ignored "-Wcast-function-type"
+#endif
+*/
+#ifdef __GNUC__
+#if defined(Z7_GCC_VERSION) && (Z7_GCC_VERSION >= 40000) && (Z7_GCC_VERSION < 70000)
+#pragma GCC diagnostic ignored "-Wstrict-aliasing"
+#endif
+#endif
+
 
 #ifdef _MSC_VER
 
@@ -17,24 +110,134 @@
     #pragma warning(disable : 4214) // nonstandard extension used : bit field types other than int
   #endif
 
-  #if _MSC_VER >= 1300
-    #pragma warning(disable : 4996) // This function or variable may be unsafe
-  #else
-    #pragma warning(disable : 4511) // copy constructor could not be generated
-    #pragma warning(disable : 4512) // assignment operator could not be generated
-    #pragma warning(disable : 4514) // unreferenced inline function has been removed
-    #pragma warning(disable : 4702) // unreachable code
-    #pragma warning(disable : 4710) // not inlined
-    #pragma warning(disable : 4714) // function marked as __forceinline not inlined
-    #pragma warning(disable : 4786) // identifier was truncated to '255' characters in the debug information
-  #endif
+#if defined(_MSC_VER) && _MSC_VER >= 1800
+#pragma warning(disable : 4464) // relative include path contains '..'
+#endif
 
-  #ifdef __clang__
-    #pragma clang diagnostic ignored "-Wdeprecated-declarations"
-    #pragma clang diagnostic ignored "-Wmicrosoft-exception-spec"
-    // #pragma clang diagnostic ignored "-Wreserved-id-macro"
-  #endif
+// == 1200 : -O1 : for __forceinline
+// >= 1900 : -O1 : for printf
+#pragma warning(disable : 4710) // function not inlined
+
+#if _MSC_VER < 1900
+// winnt.h: 'Int64ShllMod32'
+#pragma warning(disable : 4514) // unreferenced inline function has been removed
+#endif
+    
+#if _MSC_VER < 1300
+// #pragma warning(disable : 4702) // unreachable code
+// Bra.c : -O1:
+#pragma warning(disable : 4714) // function marked as __forceinline not inlined
+#endif
+
+/*
+#if _MSC_VER > 1400 && _MSC_VER <= 1900
+// strcat: This function or variable may be unsafe
+// sysinfoapi.h: kit10: GetVersion was declared deprecated
+#pragma warning(disable : 4996)
+#endif
+*/
+
+#if _MSC_VER > 1200
+// -Wall warnings
+
+#pragma warning(disable : 4711) // function selected for automatic inline expansion
+#pragma warning(disable : 4820) // '2' bytes padding added after data member
+
+#if _MSC_VER >= 1400 && _MSC_VER < 1920
+// 1400: string.h: _DBG_MEMCPY_INLINE_
+// 1600 - 191x : smmintrin.h __cplusplus'
+// is not defined as a preprocessor macro, replacing with '0' for '#if/#elif'
+#pragma warning(disable : 4668)
+
+// 1400 - 1600 : WinDef.h : 'FARPROC' :
+// 1900 - 191x : immintrin.h: _readfsbase_u32
+// no function prototype given : converting '()' to '(void)'
+#pragma warning(disable : 4255)
+#endif
+
+#if _MSC_VER >= 1914
+// Compiler will insert Spectre mitigation for memory load if /Qspectre switch specified
+#pragma warning(disable : 5045)
+#endif
+
+#endif // _MSC_VER > 1200
+#endif // _MSC_VER
+
+
+#if defined(__clang__) && (__clang_major__ >= 4)
+  #define Z7_PRAGMA_OPT_DISABLE_LOOP_UNROLL_VECTORIZE \
+    _Pragma("clang loop unroll(disable)") \
+    _Pragma("clang loop vectorize(disable)")
+  #define Z7_ATTRIB_NO_VECTORIZE
+#elif defined(__GNUC__) && (__GNUC__ >= 5) \
+    && (!defined(Z7_MCST_LCC_VERSION) || (Z7_MCST_LCC_VERSION >= 12610))
+  #define Z7_ATTRIB_NO_VECTORIZE __attribute__((optimize("no-tree-vectorize")))
+  // __attribute__((optimize("no-unroll-loops")));
+  #define Z7_PRAGMA_OPT_DISABLE_LOOP_UNROLL_VECTORIZE
+#elif defined(_MSC_VER) && (_MSC_VER >= 1920)
+  #define Z7_PRAGMA_OPT_DISABLE_LOOP_UNROLL_VECTORIZE \
+    _Pragma("loop( no_vector )")
+  #define Z7_ATTRIB_NO_VECTORIZE
+#else
+  #define Z7_PRAGMA_OPT_DISABLE_LOOP_UNROLL_VECTORIZE
+  #define Z7_ATTRIB_NO_VECTORIZE
+#endif
+
+#if defined(Z7_MSC_VER_ORIGINAL) && (Z7_MSC_VER_ORIGINAL >= 1920)
+  #define Z7_PRAGMA_OPTIMIZE_FOR_CODE_SIZE _Pragma("optimize ( \"s\", on )")
+  #define Z7_PRAGMA_OPTIMIZE_DEFAULT       _Pragma("optimize ( \"\", on )")
+#else
+  #define Z7_PRAGMA_OPTIMIZE_FOR_CODE_SIZE
+  #define Z7_PRAGMA_OPTIMIZE_DEFAULT
+#endif
+
+
+
+#if defined(MY_CPU_X86_OR_AMD64) && ( \
+       defined(__clang__) && (__clang_major__ >= 4) \
+    || defined(__GNUC__) && (__GNUC__ >= 5))
+  #define Z7_ATTRIB_NO_SSE  __attribute__((__target__("no-sse")))
+#else
+  #define Z7_ATTRIB_NO_SSE
+#endif
+
+#define Z7_ATTRIB_NO_VECTOR \
+  Z7_ATTRIB_NO_VECTORIZE \
+  Z7_ATTRIB_NO_SSE
+
+
+#if defined(__clang__) && (__clang_major__ >= 8) \
+  || defined(__GNUC__) && (__GNUC__ >= 1000) \
+  /* || defined(_MSC_VER) && (_MSC_VER >= 1920) */
+  // GCC is not good for __builtin_expect()
+  #define Z7_LIKELY(x)   (__builtin_expect((x), 1))
+  #define Z7_UNLIKELY(x) (__builtin_expect((x), 0))
+  // #define Z7_unlikely [[unlikely]]
+  // #define Z7_likely [[likely]]
+#else
+  #define Z7_LIKELY(x)   (x)
+  #define Z7_UNLIKELY(x) (x)
+  // #define Z7_likely
+#endif
+
+
+#if (defined(Z7_CLANG_VERSION) && (Z7_CLANG_VERSION >= 30600))
+
+#if (Z7_CLANG_VERSION < 130000)
+#define Z7_DIAGNOSTIC_IGNORE_BEGIN_RESERVED_MACRO_IDENTIFIER \
+  _Pragma("GCC diagnostic push") \
+  _Pragma("GCC diagnostic ignored \"-Wreserved-id-macro\"")
+#else
+#define Z7_DIAGNOSTIC_IGNORE_BEGIN_RESERVED_MACRO_IDENTIFIER \
+  _Pragma("GCC diagnostic push") \
+  _Pragma("GCC diagnostic ignored \"-Wreserved-macro-identifier\"")
+#endif
 
+#define Z7_DIAGNOSTIC_IGNORE_END_RESERVED_MACRO_IDENTIFIER \
+  _Pragma("GCC diagnostic pop")
+#else
+#define Z7_DIAGNOSTIC_IGNORE_BEGIN_RESERVED_MACRO_IDENTIFIER
+#define Z7_DIAGNOSTIC_IGNORE_END_RESERVED_MACRO_IDENTIFIER
 #endif
 
 #define UNUSED_VAR(x) (void)x;
diff --git a/lib/lzma/LzmaDec.c b/lib/lzma/LzmaDec.c
index a27f3c3b42a3..da2ec5336279 100644
--- a/lib/lzma/LzmaDec.c
+++ b/lib/lzma/LzmaDec.c
@@ -1,5 +1,5 @@
 /* LzmaDec.c -- LZMA Decoder
-2021-04-01 : Igor Pavlov : Public domain */
+2023-04-07 : Igor Pavlov : Public domain */
 
 #include "Precomp.h"
 
@@ -10,15 +10,15 @@
 /* #include "CpuArch.h" */
 #include "LzmaDec.h"
 
-#define kNumTopBits 24
-#define kTopValue ((UInt32)1 << kNumTopBits)
+// #define kNumTopBits 24
+#define kTopValue ((UInt32)1 << 24)
 
 #define kNumBitModelTotalBits 11
 #define kBitModelTotal (1 << kNumBitModelTotalBits)
 
 #define RC_INIT_SIZE 5
 
-#ifndef _LZMA_DEC_OPT
+#ifndef Z7_LZMA_DEC_OPT
 
 #define kNumMoveBits 5
 #define NORMALIZE if (range < kTopValue) { range <<= 8; code = (code << 8) | (*buf++); }
@@ -27,14 +27,14 @@
 #define UPDATE_0(p) range = bound; *(p) = (CLzmaProb)(ttt + ((kBitModelTotal - ttt) >> kNumMoveBits));
 #define UPDATE_1(p) range -= bound; code -= bound; *(p) = (CLzmaProb)(ttt - (ttt >> kNumMoveBits));
 #define GET_BIT2(p, i, A0, A1) IF_BIT_0(p) \
-  { UPDATE_0(p); i = (i + i); A0; } else \
-  { UPDATE_1(p); i = (i + i) + 1; A1; }
+  { UPDATE_0(p)  i = (i + i); A0; } else \
+  { UPDATE_1(p)  i = (i + i) + 1; A1; }
 
 #define TREE_GET_BIT(probs, i) { GET_BIT2(probs + i, i, ;, ;); }
 
 #define REV_BIT(p, i, A0, A1) IF_BIT_0(p + i) \
-  { UPDATE_0(p + i); A0; } else \
-  { UPDATE_1(p + i); A1; }
+  { UPDATE_0(p + i)  A0; } else \
+  { UPDATE_1(p + i)  A1; }
 #define REV_BIT_VAR(  p, i, m) REV_BIT(p, i, i += m; m += m, m += m; i += m; )
 #define REV_BIT_CONST(p, i, m) REV_BIT(p, i, i += m;       , i += m * 2; )
 #define REV_BIT_LAST( p, i, m) REV_BIT(p, i, i -= m        , ; )
@@ -42,19 +42,19 @@
 #define TREE_DECODE(probs, limit, i) \
   { i = 1; do { TREE_GET_BIT(probs, i); } while (i < limit); i -= limit; }
 
-/* #define _LZMA_SIZE_OPT */
+/* #define Z7_LZMA_SIZE_OPT */
 
-#ifdef _LZMA_SIZE_OPT
+#ifdef Z7_LZMA_SIZE_OPT
 #define TREE_6_DECODE(probs, i) TREE_DECODE(probs, (1 << 6), i)
 #else
 #define TREE_6_DECODE(probs, i) \
   { i = 1; \
-  TREE_GET_BIT(probs, i); \
-  TREE_GET_BIT(probs, i); \
-  TREE_GET_BIT(probs, i); \
-  TREE_GET_BIT(probs, i); \
-  TREE_GET_BIT(probs, i); \
-  TREE_GET_BIT(probs, i); \
+  TREE_GET_BIT(probs, i) \
+  TREE_GET_BIT(probs, i) \
+  TREE_GET_BIT(probs, i) \
+  TREE_GET_BIT(probs, i) \
+  TREE_GET_BIT(probs, i) \
+  TREE_GET_BIT(probs, i) \
   i -= 0x40; }
 #endif
 
@@ -66,25 +66,25 @@
   probLit = prob + (offs + bit + symbol); \
   GET_BIT2(probLit, symbol, offs ^= bit; , ;)
 
-#endif // _LZMA_DEC_OPT
+#endif // Z7_LZMA_DEC_OPT
 
 
 #define NORMALIZE_CHECK if (range < kTopValue) { if (buf >= bufLimit) return DUMMY_INPUT_EOF; range <<= 8; code = (code << 8) | (*buf++); }
 
-#define IF_BIT_0_CHECK(p) ttt = *(p); NORMALIZE_CHECK; bound = (range >> kNumBitModelTotalBits) * (UInt32)ttt; if (code < bound)
+#define IF_BIT_0_CHECK(p) ttt = *(p); NORMALIZE_CHECK bound = (range >> kNumBitModelTotalBits) * (UInt32)ttt; if (code < bound)
 #define UPDATE_0_CHECK range = bound;
 #define UPDATE_1_CHECK range -= bound; code -= bound;
 #define GET_BIT2_CHECK(p, i, A0, A1) IF_BIT_0_CHECK(p) \
-  { UPDATE_0_CHECK; i = (i + i); A0; } else \
-  { UPDATE_1_CHECK; i = (i + i) + 1; A1; }
+  { UPDATE_0_CHECK  i = (i + i); A0; } else \
+  { UPDATE_1_CHECK  i = (i + i) + 1; A1; }
 #define GET_BIT_CHECK(p, i) GET_BIT2_CHECK(p, i, ; , ;)
 #define TREE_DECODE_CHECK(probs, limit, i) \
   { i = 1; do { GET_BIT_CHECK(probs + i, i) } while (i < limit); i -= limit; }
 
 
 #define REV_BIT_CHECK(p, i, m) IF_BIT_0_CHECK(p + i) \
-  { UPDATE_0_CHECK; i += m; m += m; } else \
-  { UPDATE_1_CHECK; m += m; i += m; }
+  { UPDATE_0_CHECK  i += m; m += m; } else \
+  { UPDATE_1_CHECK  m += m; i += m; }
 
 
 #define kNumPosBitsMax 4
@@ -226,14 +226,14 @@ Out:
 */
 
 
-#ifdef _LZMA_DEC_OPT
+#ifdef Z7_LZMA_DEC_OPT
 
-int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit);
+int Z7_FASTCALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit);
 
 #else
 
 static
-int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
+int Z7_FASTCALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
 {
   CLzmaProb *probs = GET_PROBS;
   unsigned state = (unsigned)p->state;
@@ -269,7 +269,7 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
     IF_BIT_0(prob)
     {
       unsigned symbol;
-      UPDATE_0(prob);
+      UPDATE_0(prob)
       prob = probs + Literal;
       if (processedPos != 0 || checkDicSize != 0)
         prob += (UInt32)3 * ((((processedPos << 8) + dic[(dicPos == 0 ? dicBufSize : dicPos) - 1]) & lpMask) << lc);
@@ -279,7 +279,7 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
       {
         state -= (state < 4) ? state : 3;
         symbol = 1;
-        #ifdef _LZMA_SIZE_OPT
+        #ifdef Z7_LZMA_SIZE_OPT
         do { NORMAL_LITER_DEC } while (symbol < 0x100);
         #else
         NORMAL_LITER_DEC
@@ -298,7 +298,7 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
         unsigned offs = 0x100;
         state -= (state < 10) ? 3 : 6;
         symbol = 1;
-        #ifdef _LZMA_SIZE_OPT
+        #ifdef Z7_LZMA_SIZE_OPT
         do
         {
           unsigned bit;
@@ -327,25 +327,25 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
     }
 
     {
-      UPDATE_1(prob);
+      UPDATE_1(prob)
       prob = probs + IsRep + state;
       IF_BIT_0(prob)
       {
-        UPDATE_0(prob);
+        UPDATE_0(prob)
         state += kNumStates;
         prob = probs + LenCoder;
       }
       else
       {
-        UPDATE_1(prob);
+        UPDATE_1(prob)
         prob = probs + IsRepG0 + state;
         IF_BIT_0(prob)
         {
-          UPDATE_0(prob);
+          UPDATE_0(prob)
           prob = probs + IsRep0Long + COMBINED_PS_STATE;
           IF_BIT_0(prob)
           {
-            UPDATE_0(prob);
+            UPDATE_0(prob)
 
             // that case was checked before with kBadRepCode
             // if (checkDicSize == 0 && processedPos == 0) { len = kMatchSpecLen_Error_Data + 1; break; }
@@ -359,30 +359,30 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
             state = state < kNumLitStates ? 9 : 11;
             continue;
           }
-          UPDATE_1(prob);
+          UPDATE_1(prob)
         }
         else
         {
           UInt32 distance;
-          UPDATE_1(prob);
+          UPDATE_1(prob)
           prob = probs + IsRepG1 + state;
           IF_BIT_0(prob)
           {
-            UPDATE_0(prob);
+            UPDATE_0(prob)
             distance = rep1;
           }
           else
           {
-            UPDATE_1(prob);
+            UPDATE_1(prob)
             prob = probs + IsRepG2 + state;
             IF_BIT_0(prob)
             {
-              UPDATE_0(prob);
+              UPDATE_0(prob)
               distance = rep2;
             }
             else
             {
-              UPDATE_1(prob);
+              UPDATE_1(prob)
               distance = rep3;
               rep3 = rep2;
             }
@@ -395,37 +395,37 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
         prob = probs + RepLenCoder;
       }
 
-      #ifdef _LZMA_SIZE_OPT
+      #ifdef Z7_LZMA_SIZE_OPT
       {
         unsigned lim, offset;
         CLzmaProb *probLen = prob + LenChoice;
         IF_BIT_0(probLen)
         {
-          UPDATE_0(probLen);
+          UPDATE_0(probLen)
           probLen = prob + LenLow + GET_LEN_STATE;
           offset = 0;
           lim = (1 << kLenNumLowBits);
         }
         else
         {
-          UPDATE_1(probLen);
+          UPDATE_1(probLen)
           probLen = prob + LenChoice2;
           IF_BIT_0(probLen)
           {
-            UPDATE_0(probLen);
+            UPDATE_0(probLen)
             probLen = prob + LenLow + GET_LEN_STATE + (1 << kLenNumLowBits);
             offset = kLenNumLowSymbols;
             lim = (1 << kLenNumLowBits);
           }
           else
           {
-            UPDATE_1(probLen);
+            UPDATE_1(probLen)
             probLen = prob + LenHigh;
             offset = kLenNumLowSymbols * 2;
             lim = (1 << kLenNumHighBits);
           }
         }
-        TREE_DECODE(probLen, lim, len);
+        TREE_DECODE(probLen, lim, len)
         len += offset;
       }
       #else
@@ -433,32 +433,32 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
         CLzmaProb *probLen = prob + LenChoice;
         IF_BIT_0(probLen)
         {
-          UPDATE_0(probLen);
+          UPDATE_0(probLen)
           probLen = prob + LenLow + GET_LEN_STATE;
           len = 1;
-          TREE_GET_BIT(probLen, len);
-          TREE_GET_BIT(probLen, len);
-          TREE_GET_BIT(probLen, len);
+          TREE_GET_BIT(probLen, len)
+          TREE_GET_BIT(probLen, len)
+          TREE_GET_BIT(probLen, len)
           len -= 8;
         }
         else
         {
-          UPDATE_1(probLen);
+          UPDATE_1(probLen)
           probLen = prob + LenChoice2;
           IF_BIT_0(probLen)
           {
-            UPDATE_0(probLen);
+            UPDATE_0(probLen)
             probLen = prob + LenLow + GET_LEN_STATE + (1 << kLenNumLowBits);
             len = 1;
-            TREE_GET_BIT(probLen, len);
-            TREE_GET_BIT(probLen, len);
-            TREE_GET_BIT(probLen, len);
+            TREE_GET_BIT(probLen, len)
+            TREE_GET_BIT(probLen, len)
+            TREE_GET_BIT(probLen, len)
           }
           else
           {
-            UPDATE_1(probLen);
+            UPDATE_1(probLen)
             probLen = prob + LenHigh;
-            TREE_DECODE(probLen, (1 << kLenNumHighBits), len);
+            TREE_DECODE(probLen, (1 << kLenNumHighBits), len)
             len += kLenNumLowSymbols * 2;
           }
         }
@@ -470,7 +470,7 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
         UInt32 distance;
         prob = probs + PosSlot +
             ((len < kNumLenToPosStates ? len : kNumLenToPosStates - 1) << kNumPosSlotBits);
-        TREE_6_DECODE(prob, distance);
+        TREE_6_DECODE(prob, distance)
         if (distance >= kStartPosModelIndex)
         {
           unsigned posSlot = (unsigned)distance;
@@ -485,7 +485,7 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
               distance++;
               do
               {
-                REV_BIT_VAR(prob, distance, m);
+                REV_BIT_VAR(prob, distance, m)
               }
               while (--numDirectBits);
               distance -= m;
@@ -520,10 +520,10 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
             distance <<= kNumAlignBits;
             {
               unsigned i = 1;
-              REV_BIT_CONST(prob, i, 1);
-              REV_BIT_CONST(prob, i, 2);
-              REV_BIT_CONST(prob, i, 4);
-              REV_BIT_LAST (prob, i, 8);
+              REV_BIT_CONST(prob, i, 1)
+              REV_BIT_CONST(prob, i, 2)
+              REV_BIT_CONST(prob, i, 4)
+              REV_BIT_LAST (prob, i, 8)
               distance |= i;
             }
             if (distance == (UInt32)0xFFFFFFFF)
@@ -600,7 +600,7 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
 
   schedule();
 
-  NORMALIZE;
+  NORMALIZE
 
   p->buf = buf;
   p->range = range;
@@ -621,7 +621,7 @@ int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit
 
 
 
-static void MY_FAST_CALL LzmaDec_WriteRem(CLzmaDec *p, SizeT limit)
+static void Z7_FASTCALL LzmaDec_WriteRem(CLzmaDec *p, SizeT limit)
 {
   unsigned len = (unsigned)p->remainLen;
   if (len == 0 /* || len >= kMatchSpecLenStart */)
@@ -691,7 +691,7 @@ and we support the following state of (p->checkDicSize):
     (p->checkDicSize == p->prop.dicSize)
 */
 
-static int MY_FAST_CALL LzmaDec_DecodeReal2(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
+static int Z7_FASTCALL LzmaDec_DecodeReal2(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
 {
   if (p->checkDicSize == 0)
   {
@@ -775,54 +775,54 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, const Byt
     else
     {
       unsigned len;
-      UPDATE_1_CHECK;
+      UPDATE_1_CHECK
 
       prob = probs + IsRep + state;
       IF_BIT_0_CHECK(prob)
       {
-        UPDATE_0_CHECK;
+        UPDATE_0_CHECK
         state = 0;
         prob = probs + LenCoder;
         res = DUMMY_MATCH;
       }
       else
       {
-        UPDATE_1_CHECK;
+        UPDATE_1_CHECK
         res = DUMMY_REP;
         prob = probs + IsRepG0 + state;
         IF_BIT_0_CHECK(prob)
         {
-          UPDATE_0_CHECK;
+          UPDATE_0_CHECK
           prob = probs + IsRep0Long + COMBINED_PS_STATE;
           IF_BIT_0_CHECK(prob)
           {
-            UPDATE_0_CHECK;
+            UPDATE_0_CHECK
             break;
           }
           else
           {
-            UPDATE_1_CHECK;
+            UPDATE_1_CHECK
           }
         }
         else
         {
-          UPDATE_1_CHECK;
+          UPDATE_1_CHECK
           prob = probs + IsRepG1 + state;
           IF_BIT_0_CHECK(prob)
           {
-            UPDATE_0_CHECK;
+            UPDATE_0_CHECK
           }
           else
           {
-            UPDATE_1_CHECK;
+            UPDATE_1_CHECK
             prob = probs + IsRepG2 + state;
             IF_BIT_0_CHECK(prob)
             {
-              UPDATE_0_CHECK;
+              UPDATE_0_CHECK
             }
             else
             {
-              UPDATE_1_CHECK;
+              UPDATE_1_CHECK
             }
           }
         }
@@ -834,31 +834,31 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, const Byt
         const CLzmaProb *probLen = prob + LenChoice;
         IF_BIT_0_CHECK(probLen)
         {
-          UPDATE_0_CHECK;
+          UPDATE_0_CHECK
           probLen = prob + LenLow + GET_LEN_STATE;
           offset = 0;
           limit = 1 << kLenNumLowBits;
         }
         else
         {
-          UPDATE_1_CHECK;
+          UPDATE_1_CHECK
           probLen = prob + LenChoice2;
           IF_BIT_0_CHECK(probLen)
           {
-            UPDATE_0_CHECK;
+            UPDATE_0_CHECK
             probLen = prob + LenLow + GET_LEN_STATE + (1 << kLenNumLowBits);
             offset = kLenNumLowSymbols;
             limit = 1 << kLenNumLowBits;
           }
           else
           {
-            UPDATE_1_CHECK;
+            UPDATE_1_CHECK
             probLen = prob + LenHigh;
             offset = kLenNumLowSymbols * 2;
             limit = 1 << kLenNumHighBits;
           }
         }
-        TREE_DECODE_CHECK(probLen, limit, len);
+        TREE_DECODE_CHECK(probLen, limit, len)
         len += offset;
       }
 
@@ -868,7 +868,7 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, const Byt
         prob = probs + PosSlot +
             ((len < kNumLenToPosStates - 1 ? len : kNumLenToPosStates - 1) <<
             kNumPosSlotBits);
-        TREE_DECODE_CHECK(prob, 1 << kNumPosSlotBits, posSlot);
+        TREE_DECODE_CHECK(prob, 1 << kNumPosSlotBits, posSlot)
         if (posSlot >= kStartPosModelIndex)
         {
           unsigned numDirectBits = ((posSlot >> 1) - 1);
@@ -896,7 +896,7 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, const Byt
             unsigned m = 1;
             do
             {
-              REV_BIT_CHECK(prob, i, m);
+              REV_BIT_CHECK(prob, i, m)
             }
             while (--numDirectBits);
           }
@@ -905,7 +905,7 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, const Byt
     }
     break;
   }
-  NORMALIZE_CHECK;
+  NORMALIZE_CHECK
 
   *bufOut = buf;
   return res;
@@ -951,7 +951,7 @@ When the decoder lookahead, and the lookahead symbol is not end_marker, we have
 */
 
 
-#define RETURN__NOT_FINISHED__FOR_FINISH \
+#define RETURN_NOT_FINISHED_FOR_FINISH \
   *status = LZMA_STATUS_NOT_FINISHED; \
   return SZ_ERROR_DATA; // for strict mode
   // return SZ_OK; // for relaxed mode
@@ -1037,7 +1037,7 @@ SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *sr
         }
         if (p->remainLen != 0)
         {
-          RETURN__NOT_FINISHED__FOR_FINISH;
+          RETURN_NOT_FINISHED_FOR_FINISH
         }
         checkEndMarkNow = 1;
       }
@@ -1080,7 +1080,7 @@ SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *sr
             for (i = 0; i < (unsigned)dummyProcessed; i++)
               p->tempBuf[i] = src[i];
             // p->remainLen = kMatchSpecLen_Error_Data;
-            RETURN__NOT_FINISHED__FOR_FINISH;
+            RETURN_NOT_FINISHED_FOR_FINISH
           }
 
           bufLimit = src;
@@ -1158,7 +1158,7 @@ SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *sr
             (*srcLen) += (unsigned)dummyProcessed - p->tempBufSize;
             p->tempBufSize = (unsigned)dummyProcessed;
             // p->remainLen = kMatchSpecLen_Error_Data;
-            RETURN__NOT_FINISHED__FOR_FINISH;
+            RETURN_NOT_FINISHED_FOR_FINISH
           }
         }
 
@@ -1307,8 +1307,8 @@ static SRes LzmaDec_AllocateProbs2(CLzmaDec *p, const CLzmaProps *propNew, ISzAl
 SRes LzmaDec_AllocateProbs(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAllocPtr alloc)
 {
   CLzmaProps propNew;
-  RINOK(LzmaProps_Decode(&propNew, props, propsSize));
-  RINOK(LzmaDec_AllocateProbs2(p, &propNew, alloc));
+  RINOK(LzmaProps_Decode(&propNew, props, propsSize))
+  RINOK(LzmaDec_AllocateProbs2(p, &propNew, alloc))
   p->prop = propNew;
   return SZ_OK;
 }
@@ -1317,14 +1317,14 @@ SRes LzmaDec_Allocate(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAll
 {
   CLzmaProps propNew;
   SizeT dicBufSize;
-  RINOK(LzmaProps_Decode(&propNew, props, propsSize));
-  RINOK(LzmaDec_AllocateProbs2(p, &propNew, alloc));
+  RINOK(LzmaProps_Decode(&propNew, props, propsSize))
+  RINOK(LzmaDec_AllocateProbs2(p, &propNew, alloc))
 
   {
     UInt32 dictSize = propNew.dicSize;
     SizeT mask = ((UInt32)1 << 12) - 1;
          if (dictSize >= ((UInt32)1 << 30)) mask = ((UInt32)1 << 22) - 1;
-    else if (dictSize >= ((UInt32)1 << 22)) mask = ((UInt32)1 << 20) - 1;;
+    else if (dictSize >= ((UInt32)1 << 22)) mask = ((UInt32)1 << 20) - 1;
     dicBufSize = ((SizeT)dictSize + mask) & ~mask;
     if (dicBufSize < dictSize)
       dicBufSize = dictSize;
@@ -1356,8 +1356,8 @@ SRes LzmaDecode(Byte *dest, SizeT *destLen, const Byte *src, SizeT *srcLen,
   *status = LZMA_STATUS_NOT_SPECIFIED;
   if (inSize < RC_INIT_SIZE)
     return SZ_ERROR_INPUT_EOF;
-  LzmaDec_Construct(&p);
-  RINOK(LzmaDec_AllocateProbs(&p, propData, propSize, alloc));
+  LzmaDec_CONSTRUCT(&p)
+  RINOK(LzmaDec_AllocateProbs(&p, propData, propSize, alloc))
   p.dic = dest;
   p.dicBufSize = outSize;
   LzmaDec_Init(&p);
diff --git a/lib/lzma/LzmaDec.h b/lib/lzma/LzmaDec.h
index 3ab4920037c1..c4fec841b016 100644
--- a/lib/lzma/LzmaDec.h
+++ b/lib/lzma/LzmaDec.h
@@ -1,19 +1,19 @@
 /* LzmaDec.h -- LZMA Decoder
-2020-03-19 : Igor Pavlov : Public domain */
+2023-04-02 : Igor Pavlov : Public domain */
 
-#ifndef __LZMA_DEC_H
-#define __LZMA_DEC_H
+#ifndef ZIP7_INC_LZMA_DEC_H
+#define ZIP7_INC_LZMA_DEC_H
 
 #include "7zTypes.h"
 
 EXTERN_C_BEGIN
 
-/* #define _LZMA_PROB32 */
-/* _LZMA_PROB32 can increase the speed on some CPUs,
+/* #define Z7_LZMA_PROB32 */
+/* Z7_LZMA_PROB32 can increase the speed on some CPUs,
    but memory usage for CLzmaDec::probs will be doubled in that case */
 
 typedef
-#ifdef _LZMA_PROB32
+#ifdef Z7_LZMA_PROB32
   UInt32
 #else
   UInt16
@@ -25,7 +25,7 @@ typedef
 
 #define LZMA_PROPS_SIZE 5
 
-typedef struct _CLzmaProps
+typedef struct
 {
   Byte lc;
   Byte lp;
@@ -73,7 +73,8 @@ typedef struct
   Byte tempBuf[LZMA_REQUIRED_INPUT_MAX];
 } CLzmaDec;
 
-#define LzmaDec_Construct(p) { (p)->dic = NULL; (p)->probs = NULL; }
+#define LzmaDec_CONSTRUCT(p) { (p)->dic = NULL; (p)->probs = NULL; }
+#define LzmaDec_Construct(p) LzmaDec_CONSTRUCT(p)
 
 void LzmaDec_Init(CLzmaDec *p);
 
diff --git a/lib/lzma/Makefile b/lib/lzma/Makefile
index b8ad570ab1c2..09380074b3df 100644
--- a/lib/lzma/Makefile
+++ b/lib/lzma/Makefile
@@ -6,7 +6,7 @@
 # (C) Copyright 2003-2006
 # Wolfgang Denk, DENX Software Engineering, wd@denx.de.
 
-ccflags-y += -D_LZMA_PROB32
-ccflags-$(CONFIG_$(PHASE_)LZMA_SIZE_OPTIMIZATION) += -D_LZMA_SIZE_OPT
+ccflags-y += -DZ7_LZMA_PROB32
+ccflags-$(CONFIG_$(PHASE_)LZMA_SIZE_OPTIMIZATION) += -DZ7_LZMA_SIZE_OPT
 
 obj-y += LzmaDec.o LzmaTools.o
diff --git a/lib/lzma/Precomp.h b/lib/lzma/Precomp.h
index e8ff8b40e81a..7747fdd74c64 100644
--- a/lib/lzma/Precomp.h
+++ b/lib/lzma/Precomp.h
@@ -1,10 +1,127 @@
-/* Precomp.h -- StdAfx
-2013-11-12 : Igor Pavlov : Public domain */
+/* Precomp.h -- precompilation file
+2024-01-25 : Igor Pavlov : Public domain */
 
-#ifndef __7Z_PRECOMP_H
-#define __7Z_PRECOMP_H
+#ifndef ZIP7_INC_PRECOMP_H
+#define ZIP7_INC_PRECOMP_H
+
+/*
+  this file must be included before another *.h files and before <windows.h>.
+  this file is included from the following files:
+    C\*.c
+    C\Util\*\Precomp.h   <-  C\Util\*\*.c
+    CPP\Common\Common.h  <-  *\StdAfx.h    <-  *\*.cpp
+
+  this file can set the following macros:
+    Z7_LARGE_PAGES 1
+    Z7_LONG_PATH 1
+    Z7_WIN32_WINNT_MIN  0x0500 (or higher) : we require at least win2000+ for 7-Zip
+    _WIN32_WINNT        0x0500 (or higher)
+    WINVER  _WIN32_WINNT
+    UNICODE 1
+    _UNICODE 1
+*/
 
 #include "Compiler.h"
-/* #include "7zTypes.h" */
+
+#ifdef _MSC_VER
+// #pragma warning(disable : 4206) // nonstandard extension used : translation unit is empty
+#if _MSC_VER >= 1912
+// #pragma warning(disable : 5039) // pointer or reference to potentially throwing function passed to 'extern "C"' function under - EHc.Undefined behavior may occur if this function throws an exception.
+#endif
+#endif
+
+/*
+// for debug:
+#define UNICODE 1
+#define _UNICODE 1
+#define  _WIN32_WINNT  0x0500  // win2000
+#ifndef WINVER
+  #define WINVER  _WIN32_WINNT
+#endif
+*/
+
+#ifdef _WIN32
+/*
+  this "Precomp.h" file must be included before <windows.h>,
+  if we want to define _WIN32_WINNT before <windows.h>.
+*/
+
+#ifndef Z7_LARGE_PAGES
+#ifndef Z7_NO_LARGE_PAGES
+#define Z7_LARGE_PAGES 1
+#endif
+#endif
+
+#ifndef Z7_LONG_PATH
+#ifndef Z7_NO_LONG_PATH
+#define Z7_LONG_PATH 1
+#endif
+#endif
+
+#ifndef Z7_DEVICE_FILE
+#ifndef Z7_NO_DEVICE_FILE
+// #define Z7_DEVICE_FILE 1
+#endif
+#endif
+
+// we don't change macros if included after <windows.h>
+#ifndef _WINDOWS_
+
+#ifndef Z7_WIN32_WINNT_MIN
+  #if defined(_M_ARM64) || defined(__aarch64__)
+    // #define Z7_WIN32_WINNT_MIN  0x0a00  // win10
+    #define Z7_WIN32_WINNT_MIN  0x0600  // vista
+  #elif defined(_M_ARM) && defined(_M_ARMT) && defined(_M_ARM_NT)
+    // #define Z7_WIN32_WINNT_MIN  0x0602  // win8
+    #define Z7_WIN32_WINNT_MIN  0x0600  // vista
+  #elif defined(_M_X64) || defined(_M_AMD64) || defined(__x86_64__) || defined(_M_IA64)
+    #define Z7_WIN32_WINNT_MIN  0x0503  // win2003
+  // #elif defined(_M_IX86) || defined(__i386__)
+  //   #define Z7_WIN32_WINNT_MIN  0x0500  // win2000
+  #else // x86 and another(old) systems
+    #define Z7_WIN32_WINNT_MIN  0x0500  // win2000
+    // #define Z7_WIN32_WINNT_MIN  0x0502  // win2003 // for debug
+  #endif
+#endif // Z7_WIN32_WINNT_MIN
+
+
+#ifndef Z7_DO_NOT_DEFINE_WIN32_WINNT
+#ifdef _WIN32_WINNT
+  // #error Stop_Compiling_Bad_WIN32_WINNT
+#else
+  #ifndef Z7_NO_DEFINE_WIN32_WINNT
+Z7_DIAGNOSTIC_IGNORE_BEGIN_RESERVED_MACRO_IDENTIFIER
+    #define _WIN32_WINNT  Z7_WIN32_WINNT_MIN
+Z7_DIAGNOSTIC_IGNORE_END_RESERVED_MACRO_IDENTIFIER
+  #endif
+#endif // _WIN32_WINNT
+
+#ifndef WINVER
+  #define WINVER  _WIN32_WINNT
+#endif
+#endif // Z7_DO_NOT_DEFINE_WIN32_WINNT
+
+
+#ifndef _MBCS
+#ifndef Z7_NO_UNICODE
+// UNICODE and _UNICODE are used by <windows.h> and by 7-zip code.
+
+#ifndef UNICODE
+#define UNICODE 1
+#endif
+
+#ifndef _UNICODE
+Z7_DIAGNOSTIC_IGNORE_BEGIN_RESERVED_MACRO_IDENTIFIER
+#define _UNICODE 1
+Z7_DIAGNOSTIC_IGNORE_END_RESERVED_MACRO_IDENTIFIER
+#endif
+
+#endif // Z7_NO_UNICODE
+#endif // _MBCS
+#endif // _WINDOWS_
+
+// #include "7zWindows.h"
+
+#endif // _WIN32
 
 #endif
-- 
2.43.0

