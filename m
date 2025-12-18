Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34ACCD711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E636C83971;
	Fri, 19 Dec 2025 00:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qQvfkBmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA53483106; Fri, 19 Dec 2025 00:23:11 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFDB483710
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7c6e815310aso886343a34.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766100186; x=1766704986; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zRG15/W9yTFWr9lS/HK1LKao4suPeIwdY3gEU9/tIi4=;
 b=qQvfkBmYufwrGE7jC6cmg+uIy35SXYdCSJKEStZEt2AAyqKLHNaOAstVhBG+QolWZG
 x99MGWkSmDAkCXDk7L2at2xVbIS5H1WEXASanFBN8tnC9A96zTAZl++BchsVIjiR4Nfk
 kBzkm/czQCSPPDcA2pRuWYQf/IU9pTdC1mIsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100186; x=1766704986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zRG15/W9yTFWr9lS/HK1LKao4suPeIwdY3gEU9/tIi4=;
 b=hWQRqYD9BpnwWoAr76DGp5N6snIN27AcoRgAVVyLzayVU+gkq9wDVKeeUopxRqiXY1
 fo9PuDc6W+BRgL30SNajwe3/st1leGNP/U+pyLDZW79Zks6EiKdzvjnRODwCCEGwPvrZ
 rITnlVMelqWn+ivF3HIjS83PGNeCfM+C1VVRE0pa4hRXyQbUQrRx6ldJ7UBF4Fv2KEcg
 Hftw+xoqN9fDqbOTmbXLRU2LyAV3NzbIoxhhuNQTk+F7pZbMEgVF7O0sV6wu4xWQaEd4
 l0uABsR132/l6FS3+michijbU9XvuXXWzgPTAx5t2makcGt+RM60NxI1Oju8ju8iPJyn
 /8tQ==
X-Gm-Message-State: AOJu0Yyz1ULc/1Cg8gvdIL2b0nPBa+1Lt6XTz1W8kH2eo//wRueKlQ53
 xTbSScNrepcM9ZwejhjVM7s1lhGI/2Fe7WPdo3oUMXHW2r8CqBCtcOeFcmpKV2aJd2UayKnUmjO
 ED16plbU=
X-Gm-Gg: AY/fxX7XqYjn6vmCTvjdPnJcuJERqgzHRxp/7CggDjt8kDknXZkvdaEi+irjyEF9xZJ
 6qbNfNdrsE1XgDvwc+DX2GzZ69Iem1ZsibIsKhQR1DHra7pBwlcaiscAasFm6UeZKDhDCNQ6sr3
 ogt/tbxgCodfNDygJHLPYKKGDT5lGlvEbFHpZTxOPAwvfCDUe3UOYFjB2jMHbsfX5ZY0Fy8AZIA
 TPJtvc0sEAJ3oF11Rihbq4DXMmR58UBZ9JdQk1JH6az5P8OzN0LDYLVpmu9WgsOIeIpwMHhsF6W
 bsdEvRMMXlLJt6NhqhtBNNXVn219gEzs1NIaOzGhVcu+r5qQPJ9I9PDW3qXQNXPxYe+1Iplo4ua
 mFtN8OcWjNtdfOc1V8sKUlZV7Fn2GkNY6wBa8ZIaXAh7kkrtEE5QSDeYQ/om8HFSqbs6lfgnKZe
 SrkjQFsq1OwotWYJasfifXlDl08JAkwFvFrUr1bd0WlT9r2iFCrk6W
X-Google-Smtp-Source: AGHT+IH3Xk4nkJOZwxal3fmyy7TpNilPZKYAKswXcQB78D1RI4itJifjvjaRax02a9WuPEH+Rp0TMA==
X-Received: by 2002:a05:6808:4fd1:b0:44e:2f1b:e4b0 with SMTP id
 5614622812f47-457b21ceeb3mr536838b6e.51.1766100186323; 
 Thu, 18 Dec 2025 15:23:06 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3cc0928sm295333b6e.10.2025.12.18.15.23.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:23:05 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
Subject: [RFC PATCH 8/9] lzma: Restore spacing fixes
Date: Thu, 18 Dec 2025 17:10:20 -0600
Message-ID: <20251218232255.3934258-9-trini@konsulko.com>
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

This once again removes all trailing blanks and extra empty new lines to
bring the code closer to our normal coding style.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/lzma/7zTypes.h  | 36 ++----------------------------------
 lib/lzma/Compiler.h |  8 +-------
 lib/lzma/LzmaDec.c  | 18 ------------------
 lib/lzma/LzmaDec.h  |  6 ------
 lib/lzma/Precomp.h  |  2 --
 5 files changed, 3 insertions(+), 67 deletions(-)

diff --git a/lib/lzma/7zTypes.h b/lib/lzma/7zTypes.h
index 9a605468643b..18c804cf3b29 100644
--- a/lib/lzma/7zTypes.h
+++ b/lib/lzma/7zTypes.h
@@ -44,7 +44,6 @@ EXTERN_C_BEGIN
 
 typedef int SRes;
 
-
 #ifdef _MSC_VER
   #if _MSC_VER > 1200
     #define MY_ALIGN(n) __declspec(align(n))
@@ -60,7 +59,6 @@ typedef int SRes;
   #define MY_ALIGN(n) __attribute__ ((aligned(n)))
 #endif
 
-
 #ifdef _WIN32
 
 /* typedef DWORD WRes; */
@@ -165,7 +163,6 @@ typedef unsigned long UINT_PTR;
 
 #endif
 
-
 #ifndef RINOK
 #define RINOK(x) { const int _result_ = (x); if (_result_ != 0) return _result_; }
 #endif
@@ -186,7 +183,6 @@ typedef int Int32;
 typedef unsigned int UInt32;
 #endif
 
-
 #ifndef _WIN32
 
 typedef int INT;
@@ -218,10 +214,8 @@ typedef size_t SIZE_T;
 
 #endif //  _WIN32
 
-
 #define MY_HRES_ERROR_INTERNAL_ERROR  ((HRESULT)0x8007054FL)
 
-
 #ifdef Z7_DECL_Int64_AS_long
 
 typedef long Int64;
@@ -248,7 +242,6 @@ typedef unsigned long long int UInt64;
 
 #define UINT64_CONST(n) n
 
-
 #ifdef Z7_DECL_SizeT_AS_unsigned_int
 typedef unsigned int SizeT;
 #else
@@ -269,7 +262,6 @@ typedef int BoolInt;
 #define True 1
 #define False 0
 
-
 #ifdef _WIN32
 #define Z7_STDCALL __stdcall
 #else
@@ -318,7 +310,6 @@ typedef int BoolInt;
 
 #endif //  _MSC_VER
 
-
 /* The following interfaces use first parameter as pointer to structure */
 
 // #define Z7_C_IFACE_CONST_QUAL
@@ -330,21 +321,18 @@ typedef int BoolInt;
   typedef struct a ## _ a; \
   struct a ## _
 
-
 Z7_C_IFACE_DECL (IByteIn)
 {
   Byte (*Read)(IByteInPtr p); /* reads one byte, returns 0 in case of EOF or error */
 };
 #define IByteIn_Read(p) (p)->Read(p)
 
-
 Z7_C_IFACE_DECL (IByteOut)
 {
   void (*Write)(IByteOutPtr p, Byte b);
 };
 #define IByteOut_Write(p, b) (p)->Write(p, b)
 
-
 Z7_C_IFACE_DECL (ISeqInStream)
 {
   SRes (*Read)(ISeqInStreamPtr p, void *buf, size_t *size);
@@ -360,7 +348,6 @@ SRes SeqInStream_ReadMax(ISeqInStreamPtr stream, void *buf, size_t *processedSiz
 // SRes SeqInStream_Read2(ISeqInStreamPtr stream, void *buf, size_t size, SRes errorType);
 SRes SeqInStream_ReadByte(ISeqInStreamPtr stream, Byte *buf);
 
-
 Z7_C_IFACE_DECL (ISeqOutStream)
 {
   size_t (*Write)(ISeqOutStreamPtr p, const void *buf, size_t size);
@@ -376,7 +363,6 @@ typedef enum
   SZ_SEEK_END = 2
 } ESzSeek;
 
-
 Z7_C_IFACE_DECL (ISeekInStream)
 {
   SRes (*Read)(ISeekInStreamPtr p, void *buf, size_t *size);  /* same as ISeqInStream::Read */
@@ -385,7 +371,6 @@ Z7_C_IFACE_DECL (ISeekInStream)
 #define ISeekInStream_Read(p, buf, size)   (p)->Read(p, buf, size)
 #define ISeekInStream_Seek(p, pos, origin) (p)->Seek(p, pos, origin)
 
-
 Z7_C_IFACE_DECL (ILookInStream)
 {
   SRes (*Look)(ILookInStreamPtr p, const void **buf, size_t *size);
@@ -404,7 +389,6 @@ Z7_C_IFACE_DECL (ILookInStream)
 #define ILookInStream_Read(p, buf, size)   (p)->Read(p, buf, size)
 #define ILookInStream_Seek(p, pos, origin) (p)->Seek(p, pos, origin)
 
-
 SRes LookInStream_LookRead(ILookInStreamPtr stream, void *buf, size_t *size);
 SRes LookInStream_SeekTo(ILookInStreamPtr stream, UInt64 offset);
 
@@ -412,15 +396,14 @@ SRes LookInStream_SeekTo(ILookInStreamPtr stream, UInt64 offset);
 SRes LookInStream_Read2(ILookInStreamPtr stream, void *buf, size_t size, SRes errorType);
 SRes LookInStream_Read(ILookInStreamPtr stream, void *buf, size_t size);
 
-
 typedef struct
 {
   ILookInStream vt;
   ISeekInStreamPtr realStream;
- 
+
   size_t pos;
   size_t size; /* it's data size */
-  
+
   /* the following variables must be set outside */
   Byte *buf;
   size_t bufSize;
@@ -430,7 +413,6 @@ void LookToRead2_CreateVTable(CLookToRead2 *p, int lookahead);
 
 #define LookToRead2_INIT(p) { (p)->pos = (p)->size = 0; }
 
-
 typedef struct
 {
   ISeqInStream vt;
@@ -439,8 +421,6 @@ typedef struct
 
 void SecToLook_CreateVTable(CSecToLook *p);
 
-
-
 typedef struct
 {
   ISeqInStream vt;
@@ -449,7 +429,6 @@ typedef struct
 
 void SecToRead_CreateVTable(CSecToRead *p);
 
-
 Z7_C_IFACE_DECL (ICompressProgress)
 {
   SRes (*Progress)(ICompressProgressPtr p, UInt64 inSize, UInt64 outSize);
@@ -459,8 +438,6 @@ Z7_C_IFACE_DECL (ICompressProgress)
 
 #define ICompressProgress_Progress(p, inSize, outSize) (p)->Progress(p, inSize, outSize)
 
-
-
 typedef struct ISzAlloc ISzAlloc;
 typedef const ISzAlloc * ISzAllocPtr;
 
@@ -477,10 +454,6 @@ struct ISzAlloc
 #define IAlloc_Alloc(p, size) ISzAlloc_Alloc(p, size)
 #define IAlloc_Free(p, a) ISzAlloc_Free(p, a)
 
-
-
-
-
 #ifndef MY_offsetof
   #ifdef offsetof
     #define MY_offsetof(type, m) offsetof(type, m)
@@ -492,8 +465,6 @@ struct ISzAlloc
   #endif
 #endif
 
-
-
 #ifndef Z7_container_of
 
 /*
@@ -556,18 +527,15 @@ struct ISzAlloc
 #define Z7_CONTAINER_FROM_VTBL_TO_DECL_VAR_pp_vt_p(type) \
   Z7_CONTAINER_FROM_VTBL_TO_DECL_VAR(pp, type, vt, p)
 
-
 // #define ZIP7_DECLARE_HANDLE(name)  typedef void *name;
 #define Z7_DECLARE_HANDLE(name)  struct name##_dummy{int unused;}; typedef struct name##_dummy *name;
 
-
 #define Z7_memset_0_ARRAY(a)  memset((a), 0, sizeof(a))
 
 #ifndef Z7_ARRAY_SIZE
 #define Z7_ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
 #endif
 
-
 #ifdef _WIN32
 
 #define CHAR_PATH_SEPARATOR '\\'
diff --git a/lib/lzma/Compiler.h b/lib/lzma/Compiler.h
index b266b277bdb3..ee9afcee4dfd 100644
--- a/lib/lzma/Compiler.h
+++ b/lib/lzma/Compiler.h
@@ -100,7 +100,6 @@ typedef void (*Z7_void_Function)(void);
 #endif
 #endif
 
-
 #ifdef _MSC_VER
 
   #ifdef UNDER_CE
@@ -122,7 +121,7 @@ typedef void (*Z7_void_Function)(void);
 // winnt.h: 'Int64ShllMod32'
 #pragma warning(disable : 4514) // unreferenced inline function has been removed
 #endif
-    
+
 #if _MSC_VER < 1300
 // #pragma warning(disable : 4702) // unreachable code
 // Bra.c : -O1:
@@ -163,7 +162,6 @@ typedef void (*Z7_void_Function)(void);
 #endif // _MSC_VER > 1200
 #endif // _MSC_VER
 
-
 #if defined(__clang__) && (__clang_major__ >= 4)
   #define Z7_PRAGMA_OPT_DISABLE_LOOP_UNROLL_VECTORIZE \
     _Pragma("clang loop unroll(disable)") \
@@ -191,8 +189,6 @@ typedef void (*Z7_void_Function)(void);
   #define Z7_PRAGMA_OPTIMIZE_DEFAULT
 #endif
 
-
-
 #if defined(MY_CPU_X86_OR_AMD64) && ( \
        defined(__clang__) && (__clang_major__ >= 4) \
     || defined(__GNUC__) && (__GNUC__ >= 5))
@@ -205,7 +201,6 @@ typedef void (*Z7_void_Function)(void);
   Z7_ATTRIB_NO_VECTORIZE \
   Z7_ATTRIB_NO_SSE
 
-
 #if defined(__clang__) && (__clang_major__ >= 8) \
   || defined(__GNUC__) && (__GNUC__ >= 1000) \
   /* || defined(_MSC_VER) && (_MSC_VER >= 1920) */
@@ -220,7 +215,6 @@ typedef void (*Z7_void_Function)(void);
   // #define Z7_likely
 #endif
 
-
 #if (defined(Z7_CLANG_VERSION) && (Z7_CLANG_VERSION >= 30600))
 
 #if (Z7_CLANG_VERSION < 130000)
diff --git a/lib/lzma/LzmaDec.c b/lib/lzma/LzmaDec.c
index da2ec5336279..9cbe36af7182 100644
--- a/lib/lzma/LzmaDec.c
+++ b/lib/lzma/LzmaDec.c
@@ -68,7 +68,6 @@
 
 #endif // Z7_LZMA_DEC_OPT
 
-
 #define NORMALIZE_CHECK if (range < kTopValue) { if (buf >= bufLimit) return DUMMY_INPUT_EOF; range <<= 8; code = (code << 8) | (*buf++); }
 
 #define IF_BIT_0_CHECK(p) ttt = *(p); NORMALIZE_CHECK bound = (range >> kNumBitModelTotalBits) * (UInt32)ttt; if (code < bound)
@@ -81,12 +80,10 @@
 #define TREE_DECODE_CHECK(probs, limit, i) \
   { i = 1; do { GET_BIT_CHECK(probs + i, i) } while (i < limit); i -= limit; }
 
-
 #define REV_BIT_CHECK(p, i, m) IF_BIT_0_CHECK(p + i) \
   { UPDATE_0_CHECK  i += m; m += m; } else \
   { UPDATE_1_CHECK  m += m; i += m; }
 
-
 #define kNumPosBitsMax 4
 #define kNumPosStatesMax (1 << kNumPosBitsMax)
 
@@ -160,12 +157,10 @@
   #error Stop_Compiling_Bad_LZMA_PROBS
 #endif
 
-
 #define LZMA_LIT_SIZE 0x300
 
 #define LzmaProps_GetNumProbs(p) (NUM_BASE_PROBS + ((UInt32)LZMA_LIT_SIZE << ((p)->lc + (p)->lp)))
 
-
 #define CALC_POS_STATE(processedPos, pbMask) (((processedPos) & (pbMask)) << 4)
 #define COMBINED_PS_STATE (posState + state)
 #define GET_LEN_STATE (posState)
@@ -225,7 +220,6 @@ Out:
       p->reps[*]    : undefined
 */
 
-
 #ifdef Z7_LZMA_DEC_OPT
 
 int Z7_FASTCALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit);
@@ -619,8 +613,6 @@ int Z7_FASTCALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
 }
 #endif
 
-
-
 static void Z7_FASTCALL LzmaDec_WriteRem(CLzmaDec *p, SizeT limit)
 {
   unsigned len = (unsigned)p->remainLen;
@@ -659,7 +651,6 @@ static void Z7_FASTCALL LzmaDec_WriteRem(CLzmaDec *p, SizeT limit)
   }
 }
 
-
 /*
 At staring of new stream we have one of the following symbols:
   - Literal        - is allowed
@@ -675,7 +666,6 @@ We use early check of (RangeCoder:Code) over kBadRepCode to simplify main decodi
   #error Stop_Compiling_Bad_LZMA_Check
 #endif
 
-
 /*
 LzmaDec_DecodeReal2():
   It calls LZMA_DECODE_REAL() and it adjusts limit according (p->checkDicSize).
@@ -707,8 +697,6 @@ static int Z7_FASTCALL LzmaDec_DecodeReal2(CLzmaDec *p, SizeT limit, const Byte
   }
 }
 
-
-
 typedef enum
 {
   DUMMY_INPUT_EOF, /* need more input data */
@@ -717,7 +705,6 @@ typedef enum
   DUMMY_REP
 } ELzmaDummy;
 
-
 #define IS_DUMMY_END_MARKER_POSSIBLE(dummyRes) ((dummyRes) == DUMMY_MATCH)
 
 static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, const Byte **bufOut)
@@ -933,7 +920,6 @@ void LzmaDec_Init(CLzmaDec *p)
   LzmaDec_InitDicAndState(p, True, True);
 }
 
-
 /*
 LZMA supports optional end_marker.
 So the decoder can lookahead for one additional LZMA-Symbol to check end_marker.
@@ -950,13 +936,11 @@ When the decoder lookahead, and the lookahead symbol is not end_marker, we have
      LZMA_STATUS_FINISHED_WITH_MARK or LZMA_STATUS_MAYBE_FINISHED_WITHOUT_MARK.
 */
 
-
 #define RETURN_NOT_FINISHED_FOR_FINISH \
   *status = LZMA_STATUS_NOT_FINISHED; \
   return SZ_ERROR_DATA; // for strict mode
   // return SZ_OK; // for relaxed mode
 
-
 SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *srcLen,
     ELzmaFinishMode finishMode, ELzmaStatus *status)
 {
@@ -1203,8 +1187,6 @@ SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *sr
   return SZ_ERROR_FAIL;
 }
 
-
-
 SRes LzmaDec_DecodeToBuf(CLzmaDec *p, Byte *dest, SizeT *destLen, const Byte *src, SizeT *srcLen, ELzmaFinishMode finishMode, ELzmaStatus *status)
 {
   SizeT outSize = *destLen;
diff --git a/lib/lzma/LzmaDec.h b/lib/lzma/LzmaDec.h
index c4fec841b016..9e0ef3ef5835 100644
--- a/lib/lzma/LzmaDec.h
+++ b/lib/lzma/LzmaDec.h
@@ -20,7 +20,6 @@ typedef
 #endif
   CLzmaProb;
 
-
 /* ---------- LZMA Properties ---------- */
 
 #define LZMA_PROPS_SIZE 5
@@ -42,7 +41,6 @@ Returns:
 
 SRes LzmaProps_Decode(CLzmaProps *p, const Byte *data, unsigned size);
 
-
 /* ---------- LZMA Decoder state ---------- */
 
 /* LZMA_REQUIRED_INPUT_MAX = number of required input bytes for worst case.
@@ -114,7 +112,6 @@ typedef enum
 
 /* ELzmaStatus is used only as output value for function call */
 
-
 /* ---------- Interfaces ---------- */
 
 /* There are 3 levels of interfaces:
@@ -124,7 +121,6 @@ typedef enum
    You can select any of these interfaces, but don't mix functions from different
    groups for same object. */
 
-
 /* There are two variants to allocate state for Dictionary Interface:
      1) LzmaDec_Allocate / LzmaDec_Free
      2) LzmaDec_AllocateProbs / LzmaDec_FreeProbs
@@ -188,7 +184,6 @@ Returns:
 SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit,
     const Byte *src, SizeT *srcLen, ELzmaFinishMode finishMode, ELzmaStatus *status);
 
-
 /* ---------- Buffer Interface ---------- */
 
 /* It's zlib-like interface.
@@ -205,7 +200,6 @@ finishMode:
 SRes LzmaDec_DecodeToBuf(CLzmaDec *p, Byte *dest, SizeT *destLen,
     const Byte *src, SizeT *srcLen, ELzmaFinishMode finishMode, ELzmaStatus *status);
 
-
 /* ---------- One Call Interface ---------- */
 
 /* LzmaDecode
diff --git a/lib/lzma/Precomp.h b/lib/lzma/Precomp.h
index 7747fdd74c64..38f3d1eb6fdb 100644
--- a/lib/lzma/Precomp.h
+++ b/lib/lzma/Precomp.h
@@ -84,7 +84,6 @@
   #endif
 #endif // Z7_WIN32_WINNT_MIN
 
-
 #ifndef Z7_DO_NOT_DEFINE_WIN32_WINNT
 #ifdef _WIN32_WINNT
   // #error Stop_Compiling_Bad_WIN32_WINNT
@@ -101,7 +100,6 @@ Z7_DIAGNOSTIC_IGNORE_END_RESERVED_MACRO_IDENTIFIER
 #endif
 #endif // Z7_DO_NOT_DEFINE_WIN32_WINNT
 
-
 #ifndef _MBCS
 #ifndef Z7_NO_UNICODE
 // UNICODE and _UNICODE are used by <windows.h> and by 7-zip code.
-- 
2.43.0

