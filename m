Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F20AD711CD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:23:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E12C83106;
	Fri, 19 Dec 2025 00:23:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ktdlr6Yn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 964DE8392C; Fri, 19 Dec 2025 00:23:08 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 048CF836A3
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:23:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so1034907a34.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766100184; x=1766704984; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+8li59yVfYwSBb25j49kCoJqxVHZdoLmZpYXhIdMLZE=;
 b=ktdlr6YnW3pUvXd0Akf/36+eEpFW1b4W+XJ0bVVd0koNkUzo8rbxiXYJh3RaZUgJhm
 pYYlgmohIHoHDi8J/9TApghMe5UXmPhaO/ypnyi6dhDVYP6bwZNFUzbRHFgoeXuzdr8W
 zQ7upakOlvO3xdLudgQc5qjUoQG2u2Ba/ntgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100184; x=1766704984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+8li59yVfYwSBb25j49kCoJqxVHZdoLmZpYXhIdMLZE=;
 b=lT1qvpeNbs5KmzOBfjHtv89g7BmvtZ+n68S4WVHzIg+8hEl63nB/pZhFMDENfPsYGw
 BuZ5lhJhLM0Q9ooGQjK43ajqPD9AdUnsaBrcLeqo6p6ISwH3O5pnf+7iqxfgqwGp5hCk
 8tBLlnxU2vDw7YN1lFSUv3r8sy/yEZ7/DjkIZyY2chIsy0daaUqfz60BneuIGEhuKcLt
 4hEyArzVkheyRdmNOV8zEPs4NHj6IMZI+VxfUnPsjJ2s80SID24GkMINOsMAMFrYhHJR
 +Gn5kVIFazO95krP0DkcQaPSp5CjzXBTLIQqmzkuC39CepFAV3XGwH0U5uuVjLW4PPPy
 7bXA==
X-Gm-Message-State: AOJu0YzDI5/mwzZVHtodSbsEjQ3mQPxDqfTkrefiJTSCbvbubyUtzYRo
 WtAXGvoeoVUm2BkY8cmauUuMAjrG/WmHnkf18PoLUqBMTPfd+ZPaC3wULJBQG0jtNiPoHNVVpwN
 7+oaUnkk=
X-Gm-Gg: AY/fxX7Zvfp+NKAhqzISevFnVKBC5TZdyoil2s7i7A8MTSgvOjB+Gac7i82kVoFipRZ
 a9AZiCqA5wTUoX4IQoUwaDMQFY/ByfryyqpVX1gL7DNOztPstyao3NTUCcyGRoKEXn3gDwnnqQ5
 eiqgp/bHMVNU+7dkX+6/MUmXbmEysMJ7kZzX7gopx4NFbkpPsU8+H6prb670qq/pUSwc1zf1zJ9
 qr9dQPNdZK8kjaJplwM3boUCqcmeNdRQQ3h6Mls0l4H+uGrl+ln/OgT3or7XzSc/UFEM8b8esZE
 a84jPeCXiR/DvgzPYqHIDG5dfKsDBStHGtYucMjEid0wKmTxfDv1VTh5lCcHzRPrdX9nIHA2Xj7
 xd9kDmGNtb5vXfyCm+yvqbWRlLIt4nJbEemL9jDyfkaWn6p7NpJpwCXd8mZlhZTPBgfiSVmXOL+
 STVHQbit7rcfpn96qe0ForOvOG1L5F0ZrdulSZThBMHUj7Ii4bnwC8
X-Google-Smtp-Source: AGHT+IHJaqoeomc19ChC8D7V4rMOak2IyOZ9SKc8QEu3SuVdBEiwtEY510pyChnDK+8jPpUBsayHxg==
X-Received: by 2002:a05:6808:1247:b0:450:c5b6:b7cd with SMTP id
 5614622812f47-457b1ee8773mr662859b6e.27.1766100183275; 
 Thu, 18 Dec 2025 15:23:03 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3cc0928sm295333b6e.10.2025.12.18.15.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:23:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
Subject: [RFC PATCH 5/9] lzma: Update 9.38 -> 18.06
Date: Thu, 18 Dec 2025 17:10:17 -0600
Message-ID: <20251218232255.3934258-6-trini@konsulko.com>
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
 lib/lzma/7zTypes.h   | 249 +++++++++++++++----
 lib/lzma/Compiler.h  |   9 +-
 lib/lzma/LzmaDec.c   | 571 +++++++++++++++++++++++++++----------------
 lib/lzma/LzmaDec.h   |  57 +++--
 lib/lzma/LzmaTools.c |   4 +-
 5 files changed, 605 insertions(+), 285 deletions(-)

diff --git a/lib/lzma/7zTypes.h b/lib/lzma/7zTypes.h
index 953db1afc49e..65b3af63c751 100644
--- a/lib/lzma/7zTypes.h
+++ b/lib/lzma/7zTypes.h
@@ -1,5 +1,5 @@
 /* 7zTypes.h -- Basic types
-2013-11-12 : Igor Pavlov : Public domain */
+2018-08-04 : Igor Pavlov : Public domain */
 
 #ifndef __7Z_TYPES_H
 #define __7Z_TYPES_H
@@ -10,6 +10,18 @@
 
 #include <stddef.h>
 
+#ifndef EXTERN_C_BEGIN
+#ifdef __cplusplus
+#define EXTERN_C_BEGIN extern "C" {
+#define EXTERN_C_END }
+#else
+#define EXTERN_C_BEGIN
+#define EXTERN_C_END
+#endif
+#endif
+
+EXTERN_C_BEGIN
+
 #define SZ_OK 0
 
 #define SZ_ERROR_DATA 1
@@ -30,13 +42,23 @@
 
 typedef int SRes;
 
+
 #ifdef _WIN32
+
 /* typedef DWORD WRes; */
 typedef unsigned WRes;
+#define MY_SRes_HRESULT_FROM_WRes(x) HRESULT_FROM_WIN32(x)
+
 #else
+
 typedef int WRes;
+#define MY__FACILITY_WIN32 7
+#define MY__FACILITY__WRes MY__FACILITY_WIN32
+#define MY_SRes_HRESULT_FROM_WRes(x) ((HRESULT)(x) <= 0 ? ((HRESULT)(x)) : ((HRESULT) (((x) & 0x0000FFFF) | (MY__FACILITY__WRes << 16) | 0x80000000)))
+
 #endif
 
+
 #ifndef RINOK
 #define RINOK(x) { int __result__ = (x); if (__result__ != 0) return __result__; }
 #endif
@@ -81,10 +103,18 @@ typedef UInt32 SizeT;
 typedef size_t SizeT;
 #endif
 
-typedef int Bool;
+typedef int BoolInt;
+/* typedef BoolInt Bool; */
 #define True 1
 #define False 0
 
+
+#ifdef _WIN32
+#define MY_STD_CALL __stdcall
+#else
+#define MY_STD_CALL
+#endif
+
 #ifdef _MSC_VER
 
 #if _MSC_VER >= 1300
@@ -93,47 +123,72 @@ typedef int Bool;
 #define MY_NO_INLINE
 #endif
 
+#define MY_FORCE_INLINE __forceinline
+
 #define MY_CDECL __cdecl
 #define MY_FAST_CALL __fastcall
 
 #else
 
 #define MY_NO_INLINE
+#define MY_FORCE_INLINE
 #define MY_CDECL
 #define MY_FAST_CALL
 
+/* inline keyword : for C++ / C99 */
+
+/* GCC, clang: */
+/*
+#if defined (__GNUC__) && (__GNUC__ >= 4)
+#define MY_FORCE_INLINE __attribute__((always_inline))
+#define MY_NO_INLINE __attribute__((noinline))
+#endif
+*/
+
 #endif
 
+
 /* The following interfaces use first parameter as pointer to structure */
 
-typedef struct
+typedef struct IByteIn IByteIn;
+struct IByteIn
 {
-  Byte (*Read)(void *p); /* reads one byte, returns 0 in case of EOF or error */
-} IByteIn;
+  Byte (*Read)(const IByteIn *p); /* reads one byte, returns 0 in case of EOF or error */
+};
+#define IByteIn_Read(p) (p)->Read(p)
 
-typedef struct
+
+typedef struct IByteOut IByteOut;
+struct IByteOut
 {
-  void (*Write)(void *p, Byte b);
-} IByteOut;
+  void (*Write)(const IByteOut *p, Byte b);
+};
+#define IByteOut_Write(p, b) (p)->Write(p, b)
 
-typedef struct
+
+typedef struct ISeqInStream ISeqInStream;
+struct ISeqInStream
 {
-  SRes (*Read)(void *p, void *buf, size_t *size);
+  SRes (*Read)(const ISeqInStream *p, void *buf, size_t *size);
     /* if (input(*size) != 0 && output(*size) == 0) means end_of_stream.
        (output(*size) < input(*size)) is allowed */
-} ISeqInStream;
+};
+#define ISeqInStream_Read(p, buf, size) (p)->Read(p, buf, size)
 
 /* it can return SZ_ERROR_INPUT_EOF */
-SRes SeqInStream_Read(ISeqInStream *stream, void *buf, size_t size);
-SRes SeqInStream_Read2(ISeqInStream *stream, void *buf, size_t size, SRes errorType);
-SRes SeqInStream_ReadByte(ISeqInStream *stream, Byte *buf);
+SRes SeqInStream_Read(const ISeqInStream *stream, void *buf, size_t size);
+SRes SeqInStream_Read2(const ISeqInStream *stream, void *buf, size_t size, SRes errorType);
+SRes SeqInStream_ReadByte(const ISeqInStream *stream, Byte *buf);
 
-typedef struct
+
+typedef struct ISeqOutStream ISeqOutStream;
+struct ISeqOutStream
 {
-  size_t (*Write)(void *p, const void *buf, size_t size);
+  size_t (*Write)(const ISeqOutStream *p, const void *buf, size_t size);
     /* Returns: result - the number of actually written bytes.
        (result < size) means error */
-} ISeqOutStream;
+};
+#define ISeqOutStream_Write(p, buf, size) (p)->Write(p, buf, size)
 
 typedef enum
 {
@@ -142,78 +197,162 @@ typedef enum
   SZ_SEEK_END = 2
 } ESzSeek;
 
-typedef struct
+
+typedef struct ISeekInStream ISeekInStream;
+struct ISeekInStream
 {
-  SRes (*Read)(void *p, void *buf, size_t *size);  /* same as ISeqInStream::Read */
-  SRes (*Seek)(void *p, Int64 *pos, ESzSeek origin);
-} ISeekInStream;
+  SRes (*Read)(const ISeekInStream *p, void *buf, size_t *size);  /* same as ISeqInStream::Read */
+  SRes (*Seek)(const ISeekInStream *p, Int64 *pos, ESzSeek origin);
+};
+#define ISeekInStream_Read(p, buf, size)   (p)->Read(p, buf, size)
+#define ISeekInStream_Seek(p, pos, origin) (p)->Seek(p, pos, origin)
 
-typedef struct
+
+typedef struct ILookInStream ILookInStream;
+struct ILookInStream
 {
-  SRes (*Look)(void *p, const void **buf, size_t *size);
+  SRes (*Look)(const ILookInStream *p, const void **buf, size_t *size);
     /* if (input(*size) != 0 && output(*size) == 0) means end_of_stream.
        (output(*size) > input(*size)) is not allowed
        (output(*size) < input(*size)) is allowed */
-  SRes (*Skip)(void *p, size_t offset);
+  SRes (*Skip)(const ILookInStream *p, size_t offset);
     /* offset must be <= output(*size) of Look */
 
-  SRes (*Read)(void *p, void *buf, size_t *size);
+  SRes (*Read)(const ILookInStream *p, void *buf, size_t *size);
     /* reads directly (without buffer). It's same as ISeqInStream::Read */
-  SRes (*Seek)(void *p, Int64 *pos, ESzSeek origin);
-} ILookInStream;
+  SRes (*Seek)(const ILookInStream *p, Int64 *pos, ESzSeek origin);
+};
+
+#define ILookInStream_Look(p, buf, size)   (p)->Look(p, buf, size)
+#define ILookInStream_Skip(p, offset)      (p)->Skip(p, offset)
+#define ILookInStream_Read(p, buf, size)   (p)->Read(p, buf, size)
+#define ILookInStream_Seek(p, pos, origin) (p)->Seek(p, pos, origin)
+
 
-SRes LookInStream_LookRead(ILookInStream *stream, void *buf, size_t *size);
-SRes LookInStream_SeekTo(ILookInStream *stream, UInt64 offset);
+SRes LookInStream_LookRead(const ILookInStream *stream, void *buf, size_t *size);
+SRes LookInStream_SeekTo(const ILookInStream *stream, UInt64 offset);
 
 /* reads via ILookInStream::Read */
-SRes LookInStream_Read2(ILookInStream *stream, void *buf, size_t size, SRes errorType);
-SRes LookInStream_Read(ILookInStream *stream, void *buf, size_t size);
+SRes LookInStream_Read2(const ILookInStream *stream, void *buf, size_t size, SRes errorType);
+SRes LookInStream_Read(const ILookInStream *stream, void *buf, size_t size);
+
 
-#define LookToRead_BUF_SIZE (1 << 14)
 
 typedef struct
 {
-  ILookInStream s;
-  ISeekInStream *realStream;
+  ILookInStream vt;
+  const ISeekInStream *realStream;
+ 
   size_t pos;
-  size_t size;
-  Byte buf[LookToRead_BUF_SIZE];
-} CLookToRead;
+  size_t size; /* it's data size */
+  
+  /* the following variables must be set outside */
+  Byte *buf;
+  size_t bufSize;
+} CLookToRead2;
+
+void LookToRead2_CreateVTable(CLookToRead2 *p, int lookahead);
+
+#define LookToRead2_Init(p) { (p)->pos = (p)->size = 0; }
 
-void LookToRead_CreateVTable(CLookToRead *p, int lookahead);
-void LookToRead_Init(CLookToRead *p);
 
 typedef struct
 {
-  ISeqInStream s;
-  ILookInStream *realStream;
+  ISeqInStream vt;
+  const ILookInStream *realStream;
 } CSecToLook;
 
 void SecToLook_CreateVTable(CSecToLook *p);
 
+
+
 typedef struct
 {
-  ISeqInStream s;
-  ILookInStream *realStream;
+  ISeqInStream vt;
+  const ILookInStream *realStream;
 } CSecToRead;
 
 void SecToRead_CreateVTable(CSecToRead *p);
 
-typedef struct
+
+typedef struct ICompressProgress ICompressProgress;
+
+struct ICompressProgress
 {
-  SRes (*Progress)(void *p, UInt64 inSize, UInt64 outSize);
+  SRes (*Progress)(const ICompressProgress *p, UInt64 inSize, UInt64 outSize);
     /* Returns: result. (result != SZ_OK) means break.
        Value (UInt64)(Int64)-1 for size means unknown value. */
-} ICompressProgress;
+};
+#define ICompressProgress_Progress(p, inSize, outSize) (p)->Progress(p, inSize, outSize)
 
-typedef struct
+
+
+typedef struct ISzAlloc ISzAlloc;
+typedef const ISzAlloc * ISzAllocPtr;
+
+struct ISzAlloc
 {
-  void *(*Alloc)(void *p, size_t size);
-  void (*Free)(void *p, void *address); /* address can be 0 */
-} ISzAlloc;
+  void *(*Alloc)(ISzAllocPtr p, size_t size);
+  void (*Free)(ISzAllocPtr p, void *address); /* address can be 0 */
+};
+
+#define ISzAlloc_Alloc(p, size) (p)->Alloc(p, size)
+#define ISzAlloc_Free(p, a) (p)->Free(p, a)
+
+/* deprecated */
+#define IAlloc_Alloc(p, size) ISzAlloc_Alloc(p, size)
+#define IAlloc_Free(p, a) ISzAlloc_Free(p, a)
+
+
+
+
+
+#ifndef MY_offsetof
+  #ifdef offsetof
+    #define MY_offsetof(type, m) offsetof(type, m)
+    /*
+    #define MY_offsetof(type, m) FIELD_OFFSET(type, m)
+    */
+  #else
+    #define MY_offsetof(type, m) ((size_t)&(((type *)0)->m))
+  #endif
+#endif
+
+
+
+#ifndef MY_container_of
+
+/*
+#define MY_container_of(ptr, type, m) container_of(ptr, type, m)
+#define MY_container_of(ptr, type, m) CONTAINING_RECORD(ptr, type, m)
+#define MY_container_of(ptr, type, m) ((type *)((char *)(ptr) - offsetof(type, m)))
+#define MY_container_of(ptr, type, m) (&((type *)0)->m == (ptr), ((type *)(((char *)(ptr)) - MY_offsetof(type, m))))
+*/
+
+/*
+  GCC shows warning: "perhaps the 'offsetof' macro was used incorrectly"
+    GCC 3.4.4 : classes with constructor
+    GCC 4.8.1 : classes with non-public variable members"
+*/
+
+#define MY_container_of(ptr, type, m) ((type *)((char *)(1 ? (ptr) : &((type *)0)->m) - MY_offsetof(type, m)))
+
+
+#endif
+
+#define CONTAINER_FROM_VTBL_SIMPLE(ptr, type, m) ((type *)(ptr))
+
+/*
+#define CONTAINER_FROM_VTBL(ptr, type, m) CONTAINER_FROM_VTBL_SIMPLE(ptr, type, m)
+*/
+#define CONTAINER_FROM_VTBL(ptr, type, m) MY_container_of(ptr, type, m)
+
+#define CONTAINER_FROM_VTBL_CLS(ptr, type, m) CONTAINER_FROM_VTBL_SIMPLE(ptr, type, m)
+/*
+#define CONTAINER_FROM_VTBL_CLS(ptr, type, m) CONTAINER_FROM_VTBL(ptr, type, m)
+*/
+
 
-#define IAlloc_Alloc(p, size) (p)->Alloc((p), size)
-#define IAlloc_Free(p, a) (p)->Free((p), a)
 
 #ifdef _WIN32
 
@@ -225,10 +364,12 @@ typedef struct
 #else
 
 #define CHAR_PATH_SEPARATOR '/'
-#define WCHAR_PATH_SEPARATOR u'/'
+#define WCHAR_PATH_SEPARATOR L'/'
 #define STRING_PATH_SEPARATOR "/"
-#define WSTRING_PATH_SEPARATOR u"/"
+#define WSTRING_PATH_SEPARATOR L"/"
 
 #endif
 
+EXTERN_C_END
+
 #endif
diff --git a/lib/lzma/Compiler.h b/lib/lzma/Compiler.h
index 6e964897e1ee..0cc409d8a864 100644
--- a/lib/lzma/Compiler.h
+++ b/lib/lzma/Compiler.h
@@ -1,5 +1,5 @@
-/* Compiler.h -- Compiler ypes
-2013-11-12 : Igor Pavlov : Public domain */
+/* Compiler.h
+2017-04-03 : Igor Pavlov : Public domain */
 
 #ifndef __7Z_COMPILER_H
 #define __7Z_COMPILER_H
@@ -18,11 +18,16 @@
   #else
     #pragma warning(disable : 4511) // copy constructor could not be generated
     #pragma warning(disable : 4512) // assignment operator could not be generated
+    #pragma warning(disable : 4514) // unreferenced inline function has been removed
     #pragma warning(disable : 4702) // unreachable code
     #pragma warning(disable : 4710) // not inlined
+    #pragma warning(disable : 4714) // function marked as __forceinline not inlined
     #pragma warning(disable : 4786) // identifier was truncated to '255' characters in the debug information
   #endif
 
 #endif
 
+#define UNUSED_VAR(x) (void)x;
+/* #define UNUSED_VAR(x) x=x; */
+
 #endif
diff --git a/lib/lzma/LzmaDec.c b/lib/lzma/LzmaDec.c
index 53196e37076b..3319c7cf4938 100644
--- a/lib/lzma/LzmaDec.c
+++ b/lib/lzma/LzmaDec.c
@@ -1,13 +1,14 @@
 /* LzmaDec.c -- LZMA Decoder
-2015-01-01 : Igor Pavlov : Public domain */
+2018-07-04 : Igor Pavlov : Public domain */
 
 #include "Precomp.h"
 
 #include <config.h>
 #include <watchdog.h>
-#include "LzmaDec.h"
 
 #include <linux/string.h>
+/* #include "CpuArch.h" */
+#include "LzmaDec.h"
 
 #define kNumTopBits 24
 #define kTopValue ((UInt32)1 << kNumTopBits)
@@ -20,15 +21,22 @@
 
 #define NORMALIZE if (range < kTopValue) { range <<= 8; code = (code << 8) | (*buf++); }
 
-#define IF_BIT_0(p) ttt = *(p); NORMALIZE; bound = (range >> kNumBitModelTotalBits) * ttt; if (code < bound)
+#define IF_BIT_0(p) ttt = *(p); NORMALIZE; bound = (range >> kNumBitModelTotalBits) * (UInt32)ttt; if (code < bound)
 #define UPDATE_0(p) range = bound; *(p) = (CLzmaProb)(ttt + ((kBitModelTotal - ttt) >> kNumMoveBits));
 #define UPDATE_1(p) range -= bound; code -= bound; *(p) = (CLzmaProb)(ttt - (ttt >> kNumMoveBits));
 #define GET_BIT2(p, i, A0, A1) IF_BIT_0(p) \
   { UPDATE_0(p); i = (i + i); A0; } else \
   { UPDATE_1(p); i = (i + i) + 1; A1; }
-#define GET_BIT(p, i) GET_BIT2(p, i, ; , ;)
 
-#define TREE_GET_BIT(probs, i) { GET_BIT((probs + i), i); }
+#define TREE_GET_BIT(probs, i) { GET_BIT2(probs + i, i, ;, ;); }
+
+#define REV_BIT(p, i, A0, A1) IF_BIT_0(p + i) \
+  { UPDATE_0(p + i); A0; } else \
+  { UPDATE_1(p + i); A1; }
+#define REV_BIT_VAR(  p, i, m) REV_BIT(p, i, i += m; m += m, m += m; i += m; )
+#define REV_BIT_CONST(p, i, m) REV_BIT(p, i, i += m;       , i += m * 2; )
+#define REV_BIT_LAST( p, i, m) REV_BIT(p, i, i -= m        , ; )
+
 #define TREE_DECODE(probs, limit, i) \
   { i = 1; do { TREE_GET_BIT(probs, i); } while (i < limit); i -= limit; }
 
@@ -48,16 +56,19 @@
   i -= 0x40; }
 #endif
 
-#define NORMAL_LITER_DEC GET_BIT(prob + symbol, symbol)
+#define NORMAL_LITER_DEC TREE_GET_BIT(prob, symbol)
 #define MATCHED_LITER_DEC \
-  matchByte <<= 1; \
-  bit = (matchByte & offs); \
-  probLit = prob + offs + bit + symbol; \
-  GET_BIT2(probLit, symbol, offs &= ~bit, offs &= bit)
+  matchByte += matchByte; \
+  bit = offs; \
+  offs &= matchByte; \
+  probLit = prob + (offs + bit + symbol); \
+  GET_BIT2(probLit, symbol, offs ^= bit; , ;)
+
+
 
 #define NORMALIZE_CHECK if (range < kTopValue) { if (buf >= bufLimit) return DUMMY_ERROR; range <<= 8; code = (code << 8) | (*buf++); }
 
-#define IF_BIT_0_CHECK(p) ttt = *(p); NORMALIZE_CHECK; bound = (range >> kNumBitModelTotalBits) * ttt; if (code < bound)
+#define IF_BIT_0_CHECK(p) ttt = *(p); NORMALIZE_CHECK; bound = (range >> kNumBitModelTotalBits) * (UInt32)ttt; if (code < bound)
 #define UPDATE_0_CHECK range = bound;
 #define UPDATE_1_CHECK range -= bound; code -= bound;
 #define GET_BIT2_CHECK(p, i, A0, A1) IF_BIT_0_CHECK(p) \
@@ -67,24 +78,29 @@
 #define TREE_DECODE_CHECK(probs, limit, i) \
   { i = 1; do { GET_BIT_CHECK(probs + i, i) } while (i < limit); i -= limit; }
 
+
+#define REV_BIT_CHECK(p, i, m) IF_BIT_0_CHECK(p + i) \
+  { UPDATE_0_CHECK; i += m; m += m; } else \
+  { UPDATE_1_CHECK; m += m; i += m; }
+
+
 #define kNumPosBitsMax 4
 #define kNumPosStatesMax (1 << kNumPosBitsMax)
 
 #define kLenNumLowBits 3
 #define kLenNumLowSymbols (1 << kLenNumLowBits)
-#define kLenNumMidBits 3
-#define kLenNumMidSymbols (1 << kLenNumMidBits)
 #define kLenNumHighBits 8
 #define kLenNumHighSymbols (1 << kLenNumHighBits)
 
-#define LenChoice 0
-#define LenChoice2 (LenChoice + 1)
-#define LenLow (LenChoice2 + 1)
-#define LenMid (LenLow + (kNumPosStatesMax << kLenNumLowBits))
-#define LenHigh (LenMid + (kNumPosStatesMax << kLenNumMidBits))
+#define LenLow 0
+#define LenHigh (LenLow + 2 * (kNumPosStatesMax << kLenNumLowBits))
 #define kNumLenProbs (LenHigh + kLenNumHighSymbols)
 
+#define LenChoice LenLow
+#define LenChoice2 (LenLow + (1 << kLenNumLowBits))
+
 #define kNumStates 12
+#define kNumStates2 16
 #define kNumLitStates 7
 
 #define kStartPosModelIndex 4
@@ -98,54 +114,117 @@
 #define kAlignTableSize (1 << kNumAlignBits)
 
 #define kMatchMinLen 2
-#define kMatchSpecLenStart (kMatchMinLen + kLenNumLowSymbols + kLenNumMidSymbols + kLenNumHighSymbols)
+#define kMatchSpecLenStart (kMatchMinLen + kLenNumLowSymbols * 2 + kLenNumHighSymbols)
+
+/* External ASM code needs same CLzmaProb array layout. So don't change it. */
 
-#define IsMatch 0
-#define IsRep (IsMatch + (kNumStates << kNumPosBitsMax))
+/* (probs_1664) is faster and better for code size at some platforms */
+/*
+#ifdef MY_CPU_X86_OR_AMD64
+*/
+#define kStartOffset 1664
+#define GET_PROBS p->probs_1664
+/*
+#define GET_PROBS p->probs + kStartOffset
+#else
+#define kStartOffset 0
+#define GET_PROBS p->probs
+#endif
+*/
+
+#define SpecPos (-kStartOffset)
+#define IsRep0Long (SpecPos + kNumFullDistances)
+#define RepLenCoder (IsRep0Long + (kNumStates2 << kNumPosBitsMax))
+#define LenCoder (RepLenCoder + kNumLenProbs)
+#define IsMatch (LenCoder + kNumLenProbs)
+#define Align (IsMatch + (kNumStates2 << kNumPosBitsMax))
+#define IsRep (Align + kAlignTableSize)
 #define IsRepG0 (IsRep + kNumStates)
 #define IsRepG1 (IsRepG0 + kNumStates)
 #define IsRepG2 (IsRepG1 + kNumStates)
-#define IsRep0Long (IsRepG2 + kNumStates)
-#define PosSlot (IsRep0Long + (kNumStates << kNumPosBitsMax))
-#define SpecPos (PosSlot + (kNumLenToPosStates << kNumPosSlotBits))
-#define Align (SpecPos + kNumFullDistances - kEndPosModelIndex)
-#define LenCoder (Align + kAlignTableSize)
-#define RepLenCoder (LenCoder + kNumLenProbs)
-#define Literal (RepLenCoder + kNumLenProbs)
+#define PosSlot (IsRepG2 + kNumStates)
+#define Literal (PosSlot + (kNumLenToPosStates << kNumPosSlotBits))
+#define NUM_BASE_PROBS (Literal + kStartOffset)
 
-#define LZMA_BASE_SIZE 1846
-#define LZMA_LIT_SIZE 768
-
-#define LzmaProps_GetNumProbs(p) ((UInt32)LZMA_BASE_SIZE + (LZMA_LIT_SIZE << ((p)->lc + (p)->lp)))
+#if Align != 0 && kStartOffset != 0
+  #error Stop_Compiling_Bad_LZMA_kAlign
+#endif
 
-#if Literal != LZMA_BASE_SIZE
-StopCompilingDueBUG
+#if NUM_BASE_PROBS != 1984
+  #error Stop_Compiling_Bad_LZMA_PROBS
 #endif
 
+
+#define LZMA_LIT_SIZE 0x300
+
+#define LzmaProps_GetNumProbs(p) (NUM_BASE_PROBS + ((UInt32)LZMA_LIT_SIZE << ((p)->lc + (p)->lp)))
+
+
+#define CALC_POS_STATE(processedPos, pbMask) (((processedPos) & (pbMask)) << 4)
+#define COMBINED_PS_STATE (posState + state)
+#define GET_LEN_STATE (posState)
+
 #define LZMA_DIC_MIN (1 << 12)
 
-/* First LZMA-symbol is always decoded.
-And it decodes new LZMA-symbols while (buf < bufLimit), but "buf" is without last normalization
+/*
+p->remainLen : shows status of LZMA decoder:
+    < kMatchSpecLenStart : normal remain
+    = kMatchSpecLenStart : finished
+    = kMatchSpecLenStart + 1 : need init range coder
+    = kMatchSpecLenStart + 2 : need init range coder and state
+*/
+
+/* ---------- LZMA_DECODE_REAL ---------- */
+/*
+LzmaDec_DecodeReal_3() can be implemented in external ASM file.
+3 - is the code compatibility version of that function for check at link time.
+*/
+
+#define LZMA_DECODE_REAL LzmaDec_DecodeReal_3
+
+/*
+LZMA_DECODE_REAL()
+In:
+  RangeCoder is normalized
+  if (p->dicPos == limit)
+  {
+    LzmaDec_TryDummy() was called before to exclude LITERAL and MATCH-REP cases.
+    So first symbol can be only MATCH-NON-REP. And if that MATCH-NON-REP symbol
+    is not END_OF_PAYALOAD_MARKER, then function returns error code.
+  }
+
+Processing:
+  first LZMA symbol will be decoded in any case
+  All checks for limits are at the end of main loop,
+  It will decode new LZMA-symbols while (p->buf < bufLimit && dicPos < limit),
+  RangeCoder is still without last normalization when (p->buf < bufLimit) is being checked.
+
 Out:
+  RangeCoder is normalized
   Result:
     SZ_OK - OK
     SZ_ERROR_DATA - Error
   p->remainLen:
     < kMatchSpecLenStart : normal remain
     = kMatchSpecLenStart : finished
-    = kMatchSpecLenStart + 1 : Flush marker
-    = kMatchSpecLenStart + 2 : State Init Marker
 */
 
-static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
-{
-  CLzmaProb *probs = p->probs;
 
-  unsigned state = p->state;
+#ifdef _LZMA_DEC_OPT
+
+int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit);
+
+#else
+
+static
+int MY_FAST_CALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
+{
+  CLzmaProb *probs = GET_PROBS;
+  unsigned state = (unsigned)p->state;
   UInt32 rep0 = p->reps[0], rep1 = p->reps[1], rep2 = p->reps[2], rep3 = p->reps[3];
   unsigned pbMask = ((unsigned)1 << (p->prop.pb)) - 1;
-  unsigned lpMask = ((unsigned)1 << (p->prop.lp)) - 1;
   unsigned lc = p->prop.lc;
+  unsigned lpMask = ((unsigned)0x100 << p->prop.lp) - ((unsigned)0x100 >> lc);
 
   Byte *dic = p->dic;
   SizeT dicBufSize = p->dicBufSize;
@@ -165,20 +244,20 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
     CLzmaProb *prob;
     UInt32 bound;
     unsigned ttt;
-    unsigned posState = processedPos & pbMask;
+    unsigned posState = CALC_POS_STATE(processedPos, pbMask);
 
     if (!(loop++ & 1023))
 	    schedule();
 
-    prob = probs + IsMatch + (state << kNumPosBitsMax) + posState;
+    prob = probs + IsMatch + COMBINED_PS_STATE;
     IF_BIT_0(prob)
     {
       unsigned symbol;
       UPDATE_0(prob);
       prob = probs + Literal;
-      if (checkDicSize != 0 || processedPos != 0)
-        prob += (LZMA_LIT_SIZE * (((processedPos & lpMask) << lc) +
-        (dic[(dicPos == 0 ? dicBufSize : dicPos) - 1] >> (8 - lc))));
+      if (processedPos != 0 || checkDicSize != 0)
+        prob += (UInt32)3 * ((((processedPos << 8) + dic[(dicPos == 0 ? dicBufSize : dicPos) - 1]) & lpMask) << lc);
+      processedPos++;
 
       if (state < kNumLitStates)
       {
@@ -199,7 +278,7 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
       }
       else
       {
-        unsigned matchByte = dic[(dicPos - rep0) + ((dicPos < rep0) ? dicBufSize : 0)];
+        unsigned matchByte = dic[dicPos - rep0 + (dicPos < rep0 ? dicBufSize : 0)];
         unsigned offs = 0x100;
         state -= (state < 10) ? 3 : 6;
         symbol = 1;
@@ -226,11 +305,11 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
         }
         #endif
       }
+
       dic[dicPos++] = (Byte)symbol;
-      processedPos++;
       continue;
     }
-    else
+
     {
       UPDATE_1(prob);
       prob = probs + IsRep + state;
@@ -243,17 +322,20 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
       else
       {
         UPDATE_1(prob);
+        /*
+        // that case was checked before with kBadRepCode
         if (checkDicSize == 0 && processedPos == 0)
           return SZ_ERROR_DATA;
+        */
         prob = probs + IsRepG0 + state;
         IF_BIT_0(prob)
         {
           UPDATE_0(prob);
-          prob = probs + IsRep0Long + (state << kNumPosBitsMax) + posState;
+          prob = probs + IsRep0Long + COMBINED_PS_STATE;
           IF_BIT_0(prob)
           {
             UPDATE_0(prob);
-            dic[dicPos] = dic[(dicPos - rep0) + ((dicPos < rep0) ? dicBufSize : 0)];
+            dic[dicPos] = dic[dicPos - rep0 + (dicPos < rep0 ? dicBufSize : 0)];
             dicPos++;
             processedPos++;
             state = state < kNumLitStates ? 9 : 11;
@@ -294,15 +376,17 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
         state = state < kNumLitStates ? 8 : 11;
         prob = probs + RepLenCoder;
       }
+
+      #ifdef _LZMA_SIZE_OPT
       {
-        unsigned limit, offset;
+        unsigned lim, offset;
         CLzmaProb *probLen = prob + LenChoice;
         IF_BIT_0(probLen)
         {
           UPDATE_0(probLen);
-          probLen = prob + LenLow + (posState << kLenNumLowBits);
+          probLen = prob + LenLow + GET_LEN_STATE;
           offset = 0;
-          limit = (1 << kLenNumLowBits);
+          lim = (1 << kLenNumLowBits);
         }
         else
         {
@@ -311,21 +395,57 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
           IF_BIT_0(probLen)
           {
             UPDATE_0(probLen);
-            probLen = prob + LenMid + (posState << kLenNumMidBits);
+            probLen = prob + LenLow + GET_LEN_STATE + (1 << kLenNumLowBits);
             offset = kLenNumLowSymbols;
-            limit = (1 << kLenNumMidBits);
+            lim = (1 << kLenNumLowBits);
           }
           else
           {
             UPDATE_1(probLen);
             probLen = prob + LenHigh;
-            offset = kLenNumLowSymbols + kLenNumMidSymbols;
-            limit = (1 << kLenNumHighBits);
+            offset = kLenNumLowSymbols * 2;
+            lim = (1 << kLenNumHighBits);
           }
         }
-        TREE_DECODE(probLen, limit, len);
+        TREE_DECODE(probLen, lim, len);
         len += offset;
       }
+      #else
+      {
+        CLzmaProb *probLen = prob + LenChoice;
+        IF_BIT_0(probLen)
+        {
+          UPDATE_0(probLen);
+          probLen = prob + LenLow + GET_LEN_STATE;
+          len = 1;
+          TREE_GET_BIT(probLen, len);
+          TREE_GET_BIT(probLen, len);
+          TREE_GET_BIT(probLen, len);
+          len -= 8;
+        }
+        else
+        {
+          UPDATE_1(probLen);
+          probLen = prob + LenChoice2;
+          IF_BIT_0(probLen)
+          {
+            UPDATE_0(probLen);
+            probLen = prob + LenLow + GET_LEN_STATE + (1 << kLenNumLowBits);
+            len = 1;
+            TREE_GET_BIT(probLen, len);
+            TREE_GET_BIT(probLen, len);
+            TREE_GET_BIT(probLen, len);
+          }
+          else
+          {
+            UPDATE_1(probLen);
+            probLen = prob + LenHigh;
+            TREE_DECODE(probLen, (1 << kLenNumHighBits), len);
+            len += kLenNumLowSymbols * 2;
+          }
+        }
+      }
+      #endif
 
       if (state >= kNumStates)
       {
@@ -336,28 +456,26 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
         if (distance >= kStartPosModelIndex)
         {
           unsigned posSlot = (unsigned)distance;
-          int numDirectBits = (int)(((distance >> 1) - 1));
+          unsigned numDirectBits = (unsigned)(((distance >> 1) - 1));
           distance = (2 | (distance & 1));
           if (posSlot < kEndPosModelIndex)
           {
             distance <<= numDirectBits;
-            prob = probs + SpecPos + distance - posSlot - 1;
+            prob = probs + SpecPos;
             {
-              UInt32 mask = 1;
-              unsigned i = 1;
-
+              UInt32 m = 1;
+              distance++;
               do
               {
-                GET_BIT2(prob + i, i, ; , distance |= mask);
-                mask <<= 1;
+                REV_BIT_VAR(prob, distance, m);
               }
-              while (--numDirectBits != 0);
+              while (--numDirectBits);
+              distance -= m;
             }
           }
           else
           {
             numDirectBits -= kNumAlignBits;
-
             do
             {
               NORMALIZE
@@ -379,64 +497,69 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
               }
               */
             }
-            while (--numDirectBits != 0);
+            while (--numDirectBits);
             prob = probs + Align;
             distance <<= kNumAlignBits;
             {
               unsigned i = 1;
-              GET_BIT2(prob + i, i, ; , distance |= 1);
-              GET_BIT2(prob + i, i, ; , distance |= 2);
-              GET_BIT2(prob + i, i, ; , distance |= 4);
-              GET_BIT2(prob + i, i, ; , distance |= 8);
+              REV_BIT_CONST(prob, i, 1);
+              REV_BIT_CONST(prob, i, 2);
+              REV_BIT_CONST(prob, i, 4);
+              REV_BIT_LAST (prob, i, 8);
+              distance |= i;
             }
             if (distance == (UInt32)0xFFFFFFFF)
             {
-              len += kMatchSpecLenStart;
+              len = kMatchSpecLenStart;
               state -= kNumStates;
               break;
             }
           }
         }
+
         rep3 = rep2;
         rep2 = rep1;
         rep1 = rep0;
         rep0 = distance + 1;
-        if (checkDicSize == 0)
+        state = (state < kNumStates + kNumLitStates) ? kNumLitStates : kNumLitStates + 3;
+        if (distance >= (checkDicSize == 0 ? processedPos: checkDicSize))
         {
-          if (distance >= processedPos)
-            return SZ_ERROR_DATA;
-        }
-        else if (distance >= checkDicSize)
+          p->dicPos = dicPos;
           return SZ_ERROR_DATA;
-        state = (state < kNumStates + kNumLitStates) ? kNumLitStates : kNumLitStates + 3;
+        }
       }
 
       len += kMatchMinLen;
 
-      if (limit == dicPos)
-        return SZ_ERROR_DATA;
       {
-        SizeT rem = limit - dicPos;
-        unsigned curLen = ((rem < len) ? (unsigned)rem : len);
-        SizeT pos = (dicPos - rep0) + ((dicPos < rep0) ? dicBufSize : 0);
+        SizeT rem;
+        unsigned curLen;
+        SizeT pos;
+
+        if ((rem = limit - dicPos) == 0)
+        {
+          p->dicPos = dicPos;
+          return SZ_ERROR_DATA;
+        }
 
-        processedPos += curLen;
+        curLen = ((rem < len) ? (unsigned)rem : len);
+        pos = dicPos - rep0 + (dicPos < rep0 ? dicBufSize : 0);
+
+        processedPos += (UInt32)curLen;
 
         len -= curLen;
-        if (pos + curLen <= dicBufSize)
+        if (curLen <= dicBufSize - pos)
         {
           Byte *dest = dic + dicPos;
           ptrdiff_t src = (ptrdiff_t)pos - (ptrdiff_t)dicPos;
           const Byte *lim = dest + curLen;
-          dicPos += curLen;
-
+          dicPos += (SizeT)curLen;
           do
             *(dest) = (Byte)*(dest + src);
           while (++dest != lim);
         }
         else
         {
-
           do
           {
             dic[dicPos++] = dic[pos];
@@ -453,20 +576,22 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
   schedule();
 
   NORMALIZE;
+
   p->buf = buf;
   p->range = range;
   p->code = code;
-  p->remainLen = len;
+  p->remainLen = (UInt32)len;
   p->dicPos = dicPos;
   p->processedPos = processedPos;
   p->reps[0] = rep0;
   p->reps[1] = rep1;
   p->reps[2] = rep2;
   p->reps[3] = rep3;
-  p->state = state;
+  p->state = (UInt32)state;
 
   return SZ_OK;
 }
+#endif
 
 static void MY_FAST_CALL LzmaDec_WriteRem(CLzmaDec *p, SizeT limit)
 {
@@ -475,26 +600,35 @@ static void MY_FAST_CALL LzmaDec_WriteRem(CLzmaDec *p, SizeT limit)
     Byte *dic = p->dic;
     SizeT dicPos = p->dicPos;
     SizeT dicBufSize = p->dicBufSize;
-    unsigned len = p->remainLen;
-    UInt32 rep0 = p->reps[0];
-    if (limit - dicPos < len)
-      len = (unsigned)(limit - dicPos);
+    unsigned len = (unsigned)p->remainLen;
+    SizeT rep0 = p->reps[0]; /* we use SizeT to avoid the BUG of VC14 for AMD64 */
+    SizeT rem = limit - dicPos;
+    if (rem < len)
+      len = (unsigned)(rem);
 
     if (p->checkDicSize == 0 && p->prop.dicSize - p->processedPos <= len)
       p->checkDicSize = p->prop.dicSize;
 
-    p->processedPos += len;
-    p->remainLen -= len;
+    p->processedPos += (UInt32)len;
+    p->remainLen -= (UInt32)len;
     while (len != 0)
     {
       len--;
-      dic[dicPos] = dic[(dicPos - rep0) + ((dicPos < rep0) ? dicBufSize : 0)];
+      dic[dicPos] = dic[dicPos - rep0 + (dicPos < rep0 ? dicBufSize : 0)];
       dicPos++;
     }
     p->dicPos = dicPos;
   }
 }
 
+
+#define kRange0 0xFFFFFFFF
+#define kBound0 ((kRange0 >> kNumBitModelTotalBits) << (kNumBitModelTotalBits - 1))
+#define kBadRepCode (kBound0 + (((kRange0 - kBound0) >> kNumBitModelTotalBits) << (kNumBitModelTotalBits - 1)))
+#if kBadRepCode != (0xC0000000 - 0x400)
+  #error Stop_Compiling_Bad_LZMA_Check
+#endif
+
 static int MY_FAST_CALL LzmaDec_DecodeReal2(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
 {
   do
@@ -505,18 +639,21 @@ static int MY_FAST_CALL LzmaDec_DecodeReal2(CLzmaDec *p, SizeT limit, const Byte
       UInt32 rem = p->prop.dicSize - p->processedPos;
       if (limit - p->dicPos > rem)
         limit2 = p->dicPos + rem;
+
+      if (p->processedPos == 0)
+        if (p->code >= kBadRepCode)
+          return SZ_ERROR_DATA;
     }
-    RINOK(LzmaDec_DecodeReal(p, limit2, bufLimit));
-    if (p->processedPos >= p->prop.dicSize)
+
+    RINOK(LZMA_DECODE_REAL(p, limit2, bufLimit));
+
+    if (p->checkDicSize == 0 && p->processedPos >= p->prop.dicSize)
       p->checkDicSize = p->prop.dicSize;
+
     LzmaDec_WriteRem(p, limit);
   }
   while (p->dicPos < limit && p->buf < bufLimit && p->remainLen < kMatchSpecLenStart);
 
-  if (p->remainLen > kMatchSpecLenStart)
-  {
-    p->remainLen = kMatchSpecLenStart;
-  }
   return 0;
 }
 
@@ -533,17 +670,17 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
   UInt32 range = p->range;
   UInt32 code = p->code;
   const Byte *bufLimit = buf + inSize;
-  CLzmaProb *probs = p->probs;
-  unsigned state = p->state;
+  const CLzmaProb *probs = GET_PROBS;
+  unsigned state = (unsigned)p->state;
   ELzmaDummy res;
 
   {
-    CLzmaProb *prob;
+    const CLzmaProb *prob;
     UInt32 bound;
     unsigned ttt;
-    unsigned posState = (p->processedPos) & ((1 << p->prop.pb) - 1);
+    unsigned posState = CALC_POS_STATE(p->processedPos, (1 << p->prop.pb) - 1);
 
-    prob = probs + IsMatch + (state << kNumPosBitsMax) + posState;
+    prob = probs + IsMatch + COMBINED_PS_STATE;
     IF_BIT_0_CHECK(prob)
     {
       UPDATE_0_CHECK
@@ -552,9 +689,9 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
 
       prob = probs + Literal;
       if (p->checkDicSize != 0 || p->processedPos != 0)
-        prob += (LZMA_LIT_SIZE *
-          ((((p->processedPos) & ((1 << (p->prop.lp)) - 1)) << p->prop.lc) +
-          (p->dic[(p->dicPos == 0 ? p->dicBufSize : p->dicPos) - 1] >> (8 - p->prop.lc))));
+        prob += ((UInt32)LZMA_LIT_SIZE *
+            ((((p->processedPos) & ((1 << (p->prop.lp)) - 1)) << p->prop.lc) +
+            (p->dic[(p->dicPos == 0 ? p->dicBufSize : p->dicPos) - 1] >> (8 - p->prop.lc))));
 
       if (state < kNumLitStates)
       {
@@ -564,17 +701,18 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
       else
       {
         unsigned matchByte = p->dic[p->dicPos - p->reps[0] +
-            ((p->dicPos < p->reps[0]) ? p->dicBufSize : 0)];
+            (p->dicPos < p->reps[0] ? p->dicBufSize : 0)];
         unsigned offs = 0x100;
         unsigned symbol = 1;
         do
         {
           unsigned bit;
-          CLzmaProb *probLit;
-          matchByte <<= 1;
-          bit = (matchByte & offs);
-          probLit = prob + offs + bit + symbol;
-          GET_BIT2_CHECK(probLit, symbol, offs &= ~bit, offs &= bit)
+          const CLzmaProb *probLit;
+          matchByte += matchByte;
+          bit = offs;
+          offs &= matchByte;
+          probLit = prob + (offs + bit + symbol);
+          GET_BIT2_CHECK(probLit, symbol, offs ^= bit; , ; )
         }
         while (symbol < 0x100);
       }
@@ -601,7 +739,7 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
         IF_BIT_0_CHECK(prob)
         {
           UPDATE_0_CHECK;
-          prob = probs + IsRep0Long + (state << kNumPosBitsMax) + posState;
+          prob = probs + IsRep0Long + COMBINED_PS_STATE;
           IF_BIT_0_CHECK(prob)
           {
             UPDATE_0_CHECK;
@@ -640,11 +778,11 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
       }
       {
         unsigned limit, offset;
-        CLzmaProb *probLen = prob + LenChoice;
+        const CLzmaProb *probLen = prob + LenChoice;
         IF_BIT_0_CHECK(probLen)
         {
           UPDATE_0_CHECK;
-          probLen = prob + LenLow + (posState << kLenNumLowBits);
+          probLen = prob + LenLow + GET_LEN_STATE;
           offset = 0;
           limit = 1 << kLenNumLowBits;
         }
@@ -655,15 +793,15 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
           IF_BIT_0_CHECK(probLen)
           {
             UPDATE_0_CHECK;
-            probLen = prob + LenMid + (posState << kLenNumMidBits);
+            probLen = prob + LenLow + GET_LEN_STATE + (1 << kLenNumLowBits);
             offset = kLenNumLowSymbols;
-            limit = 1 << kLenNumMidBits;
+            limit = 1 << kLenNumLowBits;
           }
           else
           {
             UPDATE_1_CHECK;
             probLen = prob + LenHigh;
-            offset = kLenNumLowSymbols + kLenNumMidSymbols;
+            offset = kLenNumLowSymbols * 2;
             limit = 1 << kLenNumHighBits;
           }
         }
@@ -675,18 +813,18 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
       {
         unsigned posSlot;
         prob = probs + PosSlot +
-            ((len < kNumLenToPosStates ? len : kNumLenToPosStates - 1) <<
+            ((len < kNumLenToPosStates - 1 ? len : kNumLenToPosStates - 1) <<
             kNumPosSlotBits);
         TREE_DECODE_CHECK(prob, 1 << kNumPosSlotBits, posSlot);
         if (posSlot >= kStartPosModelIndex)
         {
-          int numDirectBits = ((posSlot >> 1) - 1);
+          unsigned numDirectBits = ((posSlot >> 1) - 1);
 
           /* if (bufLimit - buf >= 8) return DUMMY_MATCH; */
 
           if (posSlot < kEndPosModelIndex)
           {
-            prob = probs + SpecPos + ((2 | (posSlot & 1)) << numDirectBits) - posSlot - 1;
+            prob = probs + SpecPos + ((2 | (posSlot & 1)) << numDirectBits);
           }
           else
           {
@@ -698,17 +836,18 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
               code -= range & (((code - range) >> 31) - 1);
               /* if (code >= range) code -= range; */
             }
-            while (--numDirectBits != 0);
+            while (--numDirectBits);
             prob = probs + Align;
             numDirectBits = kNumAlignBits;
           }
           {
             unsigned i = 1;
+            unsigned m = 1;
             do
             {
-              GET_BIT_CHECK(prob + i, i);
+              REV_BIT_CHECK(prob, i, m);
             }
-            while (--numDirectBits != 0);
+            while (--numDirectBits);
           }
         }
       }
@@ -718,27 +857,20 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
   return res;
 }
 
-static void LzmaDec_InitRc(CLzmaDec *p, const Byte *data)
-{
-  p->code = ((UInt32)data[1] << 24) | ((UInt32)data[2] << 16) | ((UInt32)data[3] << 8) | ((UInt32)data[4]);
-  p->range = 0xFFFFFFFF;
-  p->needFlush = 0;
-}
 
-void LzmaDec_InitDicAndState(CLzmaDec *p, Bool initDic, Bool initState)
+void LzmaDec_InitDicAndState(CLzmaDec *p, BoolInt initDic, BoolInt initState)
 {
-  p->needFlush = 1;
-  p->remainLen = 0;
+  p->remainLen = kMatchSpecLenStart + 1;
   p->tempBufSize = 0;
 
   if (initDic)
   {
     p->processedPos = 0;
     p->checkDicSize = 0;
-    p->needInitState = 1;
+    p->remainLen = kMatchSpecLenStart + 2;
   }
   if (initState)
-    p->needInitState = 1;
+    p->remainLen = kMatchSpecLenStart + 2;
 }
 
 void LzmaDec_Init(CLzmaDec *p)
@@ -747,48 +879,54 @@ void LzmaDec_Init(CLzmaDec *p)
   LzmaDec_InitDicAndState(p, True, True);
 }
 
-static void LzmaDec_InitStateReal(CLzmaDec *p)
-{
-  UInt32 numProbs = Literal + ((UInt32)LZMA_LIT_SIZE << (p->prop.lc + p->prop.lp));
-  UInt32 i;
-  CLzmaProb *probs = p->probs;
-  for (i = 0; i < numProbs; i++)
-    probs[i] = kBitModelTotal >> 1;
-  p->reps[0] = p->reps[1] = p->reps[2] = p->reps[3] = 1;
-  p->state = 0;
-  p->needInitState = 0;
-}
 
 SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *srcLen,
     ELzmaFinishMode finishMode, ELzmaStatus *status)
 {
   SizeT inSize = *srcLen;
   (*srcLen) = 0;
-  LzmaDec_WriteRem(p, dicLimit);
 
   *status = LZMA_STATUS_NOT_SPECIFIED;
 
-  while (p->remainLen != kMatchSpecLenStart)
+  if (p->remainLen > kMatchSpecLenStart)
   {
-      int checkEndMarkNow;
+    for (; inSize > 0 && p->tempBufSize < RC_INIT_SIZE; (*srcLen)++, inSize--)
+      p->tempBuf[p->tempBufSize++] = *src++;
+    if (p->tempBufSize != 0 && p->tempBuf[0] != 0)
+      return SZ_ERROR_DATA;
+    if (p->tempBufSize < RC_INIT_SIZE)
+    {
+      *status = LZMA_STATUS_NEEDS_MORE_INPUT;
+      return SZ_OK;
+    }
+    p->code =
+        ((UInt32)p->tempBuf[1] << 24)
+      | ((UInt32)p->tempBuf[2] << 16)
+      | ((UInt32)p->tempBuf[3] << 8)
+      | ((UInt32)p->tempBuf[4]);
+    p->range = 0xFFFFFFFF;
+    p->tempBufSize = 0;
+
+    if (p->remainLen > kMatchSpecLenStart + 1)
+    {
+      SizeT numProbs = LzmaProps_GetNumProbs(&p->prop);
+      SizeT i;
+      CLzmaProb *probs = p->probs;
+      for (i = 0; i < numProbs; i++)
+        probs[i] = kBitModelTotal >> 1;
+      p->reps[0] = p->reps[1] = p->reps[2] = p->reps[3] = 1;
+      p->state = 0;
+    }
 
-      if (p->needFlush != 0)
-      {
-        for (; inSize > 0 && p->tempBufSize < RC_INIT_SIZE; (*srcLen)++, inSize--)
-          p->tempBuf[p->tempBufSize++] = *src++;
-        if (p->tempBufSize < RC_INIT_SIZE)
-        {
-          *status = LZMA_STATUS_NEEDS_MORE_INPUT;
-          return SZ_OK;
-        }
-        if (p->tempBuf[0] != 0)
-          return SZ_ERROR_DATA;
+    p->remainLen = 0;
+  }
 
-        LzmaDec_InitRc(p, p->tempBuf);
-        p->tempBufSize = 0;
-      }
+  LzmaDec_WriteRem(p, dicLimit);
+
+  while (p->remainLen != kMatchSpecLenStart)
+  {
+      int checkEndMarkNow = 0;
 
-      checkEndMarkNow = 0;
       if (p->dicPos >= dicLimit)
       {
         if (p->remainLen == 0 && p->code == 0)
@@ -809,9 +947,6 @@ SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *sr
         checkEndMarkNow = 1;
       }
 
-      if (p->needInitState)
-        LzmaDec_InitStateReal(p);
-
       if (p->tempBufSize == 0)
       {
         SizeT processed;
@@ -852,10 +987,10 @@ SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *sr
         p->tempBufSize = rem;
         if (rem < LZMA_REQUIRED_INPUT_MAX || checkEndMarkNow)
         {
-          int dummyRes = LzmaDec_TryDummy(p, p->tempBuf, rem);
+          int dummyRes = LzmaDec_TryDummy(p, p->tempBuf, (SizeT)rem);
           if (dummyRes == DUMMY_ERROR)
           {
-            (*srcLen) += lookAhead;
+            (*srcLen) += (SizeT)lookAhead;
             *status = LZMA_STATUS_NEEDS_MORE_INPUT;
             return SZ_OK;
           }
@@ -868,18 +1003,30 @@ SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *sr
         p->buf = p->tempBuf;
         if (LzmaDec_DecodeReal2(p, dicLimit, p->buf) != 0)
           return SZ_ERROR_DATA;
-        lookAhead -= (rem - (unsigned)(p->buf - p->tempBuf));
-        (*srcLen) += lookAhead;
+
+        {
+          unsigned kkk = (unsigned)(p->buf - p->tempBuf);
+          if (rem < kkk)
+            return SZ_ERROR_FAIL; /* some internal error */
+          rem -= kkk;
+          if (lookAhead < rem)
+            return SZ_ERROR_FAIL; /* some internal error */
+          lookAhead -= rem;
+        }
+        (*srcLen) += (SizeT)lookAhead;
         src += lookAhead;
-        inSize -= lookAhead;
+        inSize -= (SizeT)lookAhead;
         p->tempBufSize = 0;
       }
   }
-  if (p->code == 0)
-    *status = LZMA_STATUS_FINISHED_WITH_MARK;
-  return (p->code == 0) ? SZ_OK : SZ_ERROR_DATA;
+
+  if (p->code != 0)
+    return SZ_ERROR_DATA;
+  *status = LZMA_STATUS_FINISHED_WITH_MARK;
+  return SZ_OK;
 }
 
+
 SRes LzmaDec_DecodeToBuf(CLzmaDec *p, Byte *dest, SizeT *destLen, const Byte *src, SizeT *srcLen, ELzmaFinishMode finishMode, ELzmaStatus *status)
 {
   SizeT outSize = *destLen;
@@ -920,19 +1067,19 @@ SRes LzmaDec_DecodeToBuf(CLzmaDec *p, Byte *dest, SizeT *destLen, const Byte *sr
   }
 }
 
-void LzmaDec_FreeProbs(CLzmaDec *p, ISzAlloc *alloc)
+void LzmaDec_FreeProbs(CLzmaDec *p, ISzAllocPtr alloc)
 {
-  alloc->Free(alloc, p->probs);
-  p->probs = 0;
+  ISzAlloc_Free(alloc, p->probs);
+  p->probs = NULL;
 }
 
-static void LzmaDec_FreeDict(CLzmaDec *p, ISzAlloc *alloc)
+static void LzmaDec_FreeDict(CLzmaDec *p, ISzAllocPtr alloc)
 {
-  alloc->Free(alloc, p->dic);
-  p->dic = 0;
+  ISzAlloc_Free(alloc, p->dic);
+  p->dic = NULL;
 }
 
-void LzmaDec_Free(CLzmaDec *p, ISzAlloc *alloc)
+void LzmaDec_Free(CLzmaDec *p, ISzAllocPtr alloc)
 {
   LzmaDec_FreeProbs(p, alloc);
   LzmaDec_FreeDict(p, alloc);
@@ -956,29 +1103,30 @@ SRes LzmaProps_Decode(CLzmaProps *p, const Byte *data, unsigned size)
   if (d >= (9 * 5 * 5))
     return SZ_ERROR_UNSUPPORTED;
 
-  p->lc = d % 9;
+  p->lc = (Byte)(d % 9);
   d /= 9;
-  p->pb = d / 5;
-  p->lp = d % 5;
+  p->pb = (Byte)(d / 5);
+  p->lp = (Byte)(d % 5);
 
   return SZ_OK;
 }
 
-static SRes LzmaDec_AllocateProbs2(CLzmaDec *p, const CLzmaProps *propNew, ISzAlloc *alloc)
+static SRes LzmaDec_AllocateProbs2(CLzmaDec *p, const CLzmaProps *propNew, ISzAllocPtr alloc)
 {
   UInt32 numProbs = LzmaProps_GetNumProbs(propNew);
-  if (p->probs == 0 || numProbs != p->numProbs)
+  if (!p->probs || numProbs != p->numProbs)
   {
     LzmaDec_FreeProbs(p, alloc);
-    p->probs = (CLzmaProb *)alloc->Alloc(alloc, numProbs * sizeof(CLzmaProb));
-    p->numProbs = numProbs;
-    if (p->probs == 0)
+    p->probs = (CLzmaProb *)ISzAlloc_Alloc(alloc, numProbs * sizeof(CLzmaProb));
+    if (!p->probs)
       return SZ_ERROR_MEM;
+    p->probs_1664 = p->probs + 1664;
+    p->numProbs = numProbs;
   }
   return SZ_OK;
 }
 
-SRes LzmaDec_AllocateProbs(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAlloc *alloc)
+SRes LzmaDec_AllocateProbs(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAllocPtr alloc)
 {
   CLzmaProps propNew;
   RINOK(LzmaProps_Decode(&propNew, props, propsSize));
@@ -987,18 +1135,28 @@ SRes LzmaDec_AllocateProbs(CLzmaDec *p, const Byte *props, unsigned propsSize, I
   return SZ_OK;
 }
 
-SRes LzmaDec_Allocate(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAlloc *alloc)
+SRes LzmaDec_Allocate(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAllocPtr alloc)
 {
   CLzmaProps propNew;
   SizeT dicBufSize;
   RINOK(LzmaProps_Decode(&propNew, props, propsSize));
   RINOK(LzmaDec_AllocateProbs2(p, &propNew, alloc));
-  dicBufSize = propNew.dicSize;
-  if (p->dic == 0 || dicBufSize != p->dicBufSize)
+
+  {
+    UInt32 dictSize = propNew.dicSize;
+    SizeT mask = ((UInt32)1 << 12) - 1;
+         if (dictSize >= ((UInt32)1 << 30)) mask = ((UInt32)1 << 22) - 1;
+    else if (dictSize >= ((UInt32)1 << 22)) mask = ((UInt32)1 << 20) - 1;;
+    dicBufSize = ((SizeT)dictSize + mask) & ~mask;
+    if (dicBufSize < dictSize)
+      dicBufSize = dictSize;
+  }
+
+  if (!p->dic || dicBufSize != p->dicBufSize)
   {
     LzmaDec_FreeDict(p, alloc);
-    p->dic = (Byte *)alloc->Alloc(alloc, dicBufSize);
-    if (p->dic == 0)
+    p->dic = (Byte *)ISzAlloc_Alloc(alloc, dicBufSize);
+    if (!p->dic)
     {
       LzmaDec_FreeProbs(p, alloc);
       return SZ_ERROR_MEM;
@@ -1011,7 +1169,7 @@ SRes LzmaDec_Allocate(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAll
 
 SRes LzmaDecode(Byte *dest, SizeT *destLen, const Byte *src, SizeT *srcLen,
     const Byte *propData, unsigned propSize, ELzmaFinishMode finishMode,
-    ELzmaStatus *status, ISzAlloc *alloc)
+    ELzmaStatus *status, ISzAllocPtr alloc)
 {
   CLzmaDec p;
   SRes res;
@@ -1028,7 +1186,6 @@ SRes LzmaDecode(Byte *dest, SizeT *destLen, const Byte *src, SizeT *srcLen,
   *srcLen = inSize;
   res = LzmaDec_DecodeToDic(&p, outSize, src, srcLen, finishMode, status);
   *destLen = p.dicPos;
-
   if (res == SZ_OK && *status == LZMA_STATUS_NEEDS_MORE_INPUT)
     res = SZ_ERROR_INPUT_EOF;
   LzmaDec_FreeProbs(&p, alloc);
diff --git a/lib/lzma/LzmaDec.h b/lib/lzma/LzmaDec.h
index 1e266991fd08..f3702f5ce608 100644
--- a/lib/lzma/LzmaDec.h
+++ b/lib/lzma/LzmaDec.h
@@ -1,20 +1,25 @@
 /* LzmaDec.h -- LZMA Decoder
-2013-01-18 : Igor Pavlov : Public domain */
+2018-04-21 : Igor Pavlov : Public domain */
 
 #ifndef __LZMA_DEC_H
 #define __LZMA_DEC_H
 
 #include "7zTypes.h"
 
+EXTERN_C_BEGIN
+
 /* #define _LZMA_PROB32 */
 /* _LZMA_PROB32 can increase the speed on some CPUs,
    but memory usage for CLzmaDec::probs will be doubled in that case */
 
+typedef
 #ifdef _LZMA_PROB32
-#define CLzmaProb UInt32
+  UInt32
 #else
-#define CLzmaProb UInt16
+  UInt16
 #endif
+  CLzmaProb;
+
 
 /* ---------- LZMA Properties ---------- */
 
@@ -22,7 +27,10 @@
 
 typedef struct _CLzmaProps
 {
-  unsigned lc, lp, pb;
+  Byte lc;
+  Byte lp;
+  Byte pb;
+  Byte _pad_;
   UInt32 dicSize;
 } CLzmaProps;
 
@@ -34,6 +42,7 @@ Returns:
 
 SRes LzmaProps_Decode(CLzmaProps *p, const Byte *data, unsigned size);
 
+
 /* ---------- LZMA Decoder state ---------- */
 
 /* LZMA_REQUIRED_INPUT_MAX = number of required input bytes for worst case.
@@ -43,32 +52,34 @@ SRes LzmaProps_Decode(CLzmaProps *p, const Byte *data, unsigned size);
 
 typedef struct
 {
+  /* Don't change this structure. ASM code can use it. */
   CLzmaProps prop;
   CLzmaProb *probs;
+  CLzmaProb *probs_1664;
   Byte *dic;
-  const Byte *buf;
-  UInt32 range, code;
-  SizeT dicPos;
   SizeT dicBufSize;
+  SizeT dicPos;
+  const Byte *buf;
+  UInt32 range;
+  UInt32 code;
   UInt32 processedPos;
   UInt32 checkDicSize;
-  unsigned state;
   UInt32 reps[4];
-  unsigned remainLen;
-  int needFlush;
-  int needInitState;
+  UInt32 state;
+  UInt32 remainLen;
+
   UInt32 numProbs;
   unsigned tempBufSize;
   Byte tempBuf[LZMA_REQUIRED_INPUT_MAX];
 } CLzmaDec;
 
-#define LzmaDec_Construct(p) { (p)->dic = 0; (p)->probs = 0; }
+#define LzmaDec_Construct(p) { (p)->dic = NULL; (p)->probs = NULL; }
 
 void LzmaDec_Init(CLzmaDec *p);
 
 /* There are two types of LZMA streams:
-     0) Stream with end mark. That end mark adds about 6 bytes to compressed size.
-     1) Stream without end mark. You must know exact uncompressed size to decompress such stream. */
+     - Stream with end mark. That end mark adds about 6 bytes to compressed size.
+     - Stream without end mark. You must know exact uncompressed size to decompress such stream. */
 
 typedef enum
 {
@@ -102,6 +113,7 @@ typedef enum
 
 /* ELzmaStatus is used only as output value for function call */
 
+
 /* ---------- Interfaces ---------- */
 
 /* There are 3 levels of interfaces:
@@ -111,6 +123,7 @@ typedef enum
    You can select any of these interfaces, but don't mix functions from different
    groups for same object. */
 
+
 /* There are two variants to allocate state for Dictionary Interface:
      1) LzmaDec_Allocate / LzmaDec_Free
      2) LzmaDec_AllocateProbs / LzmaDec_FreeProbs
@@ -123,11 +136,11 @@ LzmaDec_Allocate* can return:
   SZ_ERROR_UNSUPPORTED - Unsupported properties
 */
 
-SRes LzmaDec_AllocateProbs(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAlloc *alloc);
-void LzmaDec_FreeProbs(CLzmaDec *p, ISzAlloc *alloc);
+SRes LzmaDec_AllocateProbs(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAllocPtr alloc);
+void LzmaDec_FreeProbs(CLzmaDec *p, ISzAllocPtr alloc);
 
-SRes LzmaDec_Allocate(CLzmaDec *state, const Byte *prop, unsigned propsSize, ISzAlloc *alloc);
-void LzmaDec_Free(CLzmaDec *state, ISzAlloc *alloc);
+SRes LzmaDec_Allocate(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAllocPtr alloc);
+void LzmaDec_Free(CLzmaDec *p, ISzAllocPtr alloc);
 
 /* ---------- Dictionary Interface ---------- */
 
@@ -136,7 +149,7 @@ void LzmaDec_Free(CLzmaDec *state, ISzAlloc *alloc);
    You must work with CLzmaDec variables directly in this interface.
 
    STEPS:
-     LzmaDec_Constr()
+     LzmaDec_Construct()
      LzmaDec_Allocate()
      for (each new stream)
      {
@@ -173,6 +186,7 @@ Returns:
 SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit,
     const Byte *src, SizeT *srcLen, ELzmaFinishMode finishMode, ELzmaStatus *status);
 
+
 /* ---------- Buffer Interface ---------- */
 
 /* It's zlib-like interface.
@@ -189,6 +203,7 @@ finishMode:
 SRes LzmaDec_DecodeToBuf(CLzmaDec *p, Byte *dest, SizeT *destLen,
     const Byte *src, SizeT *srcLen, ELzmaFinishMode finishMode, ELzmaStatus *status);
 
+
 /* ---------- One Call Interface ---------- */
 
 /* LzmaDecode
@@ -212,6 +227,8 @@ Returns:
 
 SRes LzmaDecode(Byte *dest, SizeT *destLen, const Byte *src, SizeT *srcLen,
     const Byte *propData, unsigned propSize, ELzmaFinishMode finishMode,
-    ELzmaStatus *status, ISzAlloc *alloc);
+    ELzmaStatus *status, ISzAllocPtr alloc);
+
+EXTERN_C_END
 
 #endif
diff --git a/lib/lzma/LzmaTools.c b/lib/lzma/LzmaTools.c
index 400d606784ea..28c42d7293c8 100644
--- a/lib/lzma/LzmaTools.c
+++ b/lib/lzma/LzmaTools.c
@@ -33,8 +33,8 @@
 #include <linux/string.h>
 #include <malloc.h>
 
-static void *SzAlloc(void *p, size_t size) { return malloc(size); }
-static void SzFree(void *p, void *address) { free(address); }
+static void *SzAlloc(ISzAllocPtr p, size_t size) { return malloc(size); }
+static void SzFree(ISzAllocPtr p, void *address) { free(address); }
 
 int lzmaBuffToBuffDecompress(unsigned char *outStream, SizeT *uncompressedSize,
 			     const unsigned char *inStream, SizeT length)
-- 
2.43.0

