Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 099EFD711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51374838FA;
	Fri, 19 Dec 2025 00:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZO8oMBJB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D505833C6; Fri, 19 Dec 2025 00:23:06 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC109835C6
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:23:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7c71cca8fc2so724412a34.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766100182; x=1766704982; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yH3e9mk8Hor0BHuIreJ8sQYoAcrdt3RVhCqwWecHgbA=;
 b=ZO8oMBJBCUMlTkmlDHHvcdM3KoxfSkx7WxS/5cPJlmZ+0MDNrUb8L7INyXEv2alwdD
 yftkMJOal/Kv+L4VfFhA4WmUKmSEL2Q6D8XCM52K5D7d36/3eBmk7Dh5nVxkVtfvZtsN
 86DqhMCkA1+YRhGJdcscT0YKJtYd2RcmcyraY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100182; x=1766704982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yH3e9mk8Hor0BHuIreJ8sQYoAcrdt3RVhCqwWecHgbA=;
 b=rduqxSHAnY8C8GCe2kyiRG0kDOSWW3fn8lyqEBndb3gXFkdZkbyu6jlo+U/Qq2bZWV
 m4qUvHvwLF1c2umvd6qlKskiQjT4tfYrHxJLkqS50Q2si04DBsjlAAin+NaE0p4ZTbS6
 dLmdQLSVWCdIQQuKyfIXBN5hNvXchsTiQzO1TtdmNhFdPzL+1S/HIeYI3G1cuAvVBGpE
 3njZJUXdIvTv7VxeaR/Es8gF42bjEQqjgXtRnFvom7nN7BwSeqnjLbTT45IxCTPGeVAf
 FUQBX0FEzLA0D0El9hUrr0r8aM8uUexC/Nxe7V199Wud0XQ9tqqbYvSw6i1ssuxmri7D
 PthA==
X-Gm-Message-State: AOJu0Yx4TUmSUu+zxzmV5YaYnijlYV3FOWaBgFzH9Fn0ViMYdvtovSeW
 NcIt1J+aIX0FL/pEzvLW7GW37YCSXaInPdv2aTVJRaI/zbeyJLAWlfw0WpwQqsya3jy2oYyl3gy
 lQncvjCA=
X-Gm-Gg: AY/fxX63/Sa7vW1c/dQklZ1aSHv3TPSRNrUCEtl8VFs4s4t+uh+c653jL5iwbBpE+jG
 ePNhJX0tf0yfFS8h+E2s9SiuVpTUIt+CMq7sniZj0uIVIQVBrrlzH9SAcQHKXEM56IgN+xY79va
 6MX68iZ8j7VoAw3B0CG+gCzLkKQm89my461JO45m3LsLxDwkTJXt3xnY7ZcGX26UAL8ch/iK+Bv
 EX0Ze/LY9NOD4hqGDfasGz5xsygHHNvhnoUHK1oLLnmeNWTcqT+Hmw79MzK9qXdgloeZBXgfhmG
 3t8DebxuzGqEqbAt/Jb8QXacQI7rm50W9h45eSig34s+jPnuMr+0IX9hfpJGNikJ06I2r0ONqG8
 p59PiceQ3bcV4LeHLrdrPSjnc2bvBJ7Zg7FClLNMgmLfwmr/ePhBugeTK7zNDv5Cd2+ywdme8j1
 r5so+fh0fbdSoQZBkuVxCYqc2uOllKJCJIfR7ijQO7bvzaRWM90edQ
X-Google-Smtp-Source: AGHT+IHDl/arH+n20iG4CD5pu3vyx8gcdKaMVA3Ygz4QD7QZB54oG8Vr9WWYbo8X75dJ4NBfYF8yUA==
X-Received: by 2002:a05:6808:250d:b0:455:8b5b:c763 with SMTP id
 5614622812f47-457b2201259mr653952b6e.67.1766100182322; 
 Thu, 18 Dec 2025 15:23:02 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3cc0928sm295333b6e.10.2025.12.18.15.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:23:01 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
Subject: [RFC PATCH 4/9] lzma: Update 9.22 -> 9.38
Date: Thu, 18 Dec 2025 17:10:16 -0600
Message-ID: <20251218232255.3934258-5-trini@konsulko.com>
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

Of note is that the license for this code is now found in the "7zC.txt"
file upstream, so include that.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/lzma/LzmaTypes.h        |   2 +-
 lib/lzma/7zC.txt                | 187 ++++++++++++++++++++++++++++++++
 lib/lzma/{Types.h => 7zTypes.h} |  14 ++-
 lib/lzma/Compiler.h             |  28 +++++
 lib/lzma/LzmaDec.c              |  48 ++++++--
 lib/lzma/LzmaDec.h              |   4 +-
 lib/lzma/Precomp.h              |  10 ++
 lib/lzma/license.txt            |   3 -
 8 files changed, 275 insertions(+), 21 deletions(-)
 create mode 100644 lib/lzma/7zC.txt
 rename lib/lzma/{Types.h => 7zTypes.h} (96%)
 create mode 100644 lib/lzma/Compiler.h
 create mode 100644 lib/lzma/Precomp.h
 delete mode 100644 lib/lzma/license.txt

diff --git a/include/lzma/LzmaTypes.h b/include/lzma/LzmaTypes.h
index 3670c3ff91e0..1bd39b40e8f3 100644
--- a/include/lzma/LzmaTypes.h
+++ b/include/lzma/LzmaTypes.h
@@ -14,6 +14,6 @@
  */
 #define Byte LZByte
 
-#include "../../lib/lzma/Types.h"
+#include "../../lib/lzma/7zTypes.h"
 
 #endif
diff --git a/lib/lzma/7zC.txt b/lib/lzma/7zC.txt
new file mode 100644
index 000000000000..10d3f4792f16
--- /dev/null
+++ b/lib/lzma/7zC.txt
@@ -0,0 +1,187 @@
+7z ANSI-C Decoder 9.35
+----------------------
+
+7z ANSI-C provides 7z/LZMA decoding.
+7z ANSI-C version is simplified version ported from C++ code.
+
+LZMA is default and general compression method of 7z format
+in 7-Zip compression program (www.7-zip.org). LZMA provides high
+compression ratio and very fast decompression.
+
+
+LICENSE
+-------
+
+7z ANSI-C Decoder is part of the LZMA SDK.
+LZMA SDK is written and placed in the public domain by Igor Pavlov.
+
+Files
+---------------------
+
+7zDecode.*   - Low level 7z decoding
+7zExtract.*  - High level 7z decoding
+7zHeader.*   - .7z format constants
+7zIn.*       - .7z archive opening
+7zItem.*     - .7z structures
+7zMain.c     - Test application
+
+
+How To Use
+----------
+
+You can create .7z archive with 7z.exe, 7za.exe or 7zr.exe:
+
+  7z.exe a archive.7z *.htm -r -mx -m0fb=255
+
+If you have big number of files in archive, and you need fast extracting,
+you can use partly-solid archives:
+
+  7za.exe a archive.7z *.htm -ms=512K -r -mx -m0fb=255 -m0d=512K
+
+In that example 7-Zip will use 512KB solid blocks. So it needs to decompress only
+512KB for extracting one file from such archive.
+
+
+Limitations of current version of 7z ANSI-C Decoder
+---------------------------------------------------
+
+ - It reads only "FileName", "Size", "LastWriteTime" and "CRC" information for each file in archive.
+ - It supports only LZMA and Copy (no compression) methods with BCJ or BCJ2 filters.
+ - It converts original UTF-16 Unicode file names to UTF-8 Unicode file names.
+
+These limitations will be fixed in future versions.
+
+
+Using 7z ANSI-C Decoder Test application:
+-----------------------------------------
+
+Usage: 7zDec <command> <archive_name>
+
+<Command>:
+  e: Extract files from archive
+  l: List contents of archive
+  t: Test integrity of archive
+
+Example:
+
+  7zDec l archive.7z
+
+lists contents of archive.7z
+
+  7zDec e archive.7z
+
+extracts files from archive.7z to current folder.
+
+
+How to use .7z Decoder
+----------------------
+
+Memory allocation
+~~~~~~~~~~~~~~~~~
+
+7z Decoder uses two memory pools:
+1) Temporary pool
+2) Main pool
+Such scheme can allow you to avoid fragmentation of allocated blocks.
+
+
+Steps for using 7z decoder
+--------------------------
+
+Use code at 7zMain.c as example.
+
+1) Declare variables:
+  inStream                 /* implements ILookInStream interface */
+  CSzArEx db;              /* 7z archive database structure */
+  ISzAlloc allocImp;       /* memory functions for main pool */
+  ISzAlloc allocTempImp;   /* memory functions for temporary pool */
+
+2) call CrcGenerateTable(); function to initialize CRC structures.
+
+3) call SzArEx_Init(&db); function to initialize db structures.
+
+4) call SzArEx_Open(&db, inStream, &allocMain, &allocTemp) to open archive
+
+This function opens archive "inStream" and reads headers to "db".
+All items in "db" will be allocated with "allocMain" functions.
+SzArEx_Open function allocates and frees temporary structures by "allocTemp" functions.
+
+5) List items or Extract items
+
+  Listing code:
+  ~~~~~~~~~~~~~
+
+    Use SzArEx_GetFileNameUtf16 function. Look example code in C\Util\7z\7zMain.c file.
+
+
+  Extracting code:
+  ~~~~~~~~~~~~~~~~
+
+  SZ_RESULT SzAr_Extract(
+    CArchiveDatabaseEx *db,
+    ILookInStream *inStream,
+    UInt32 fileIndex,         /* index of file */
+    UInt32 *blockIndex,       /* index of solid block */
+    Byte **outBuffer,         /* pointer to pointer to output buffer (allocated with allocMain) */
+    size_t *outBufferSize,    /* buffer size for output buffer */
+    size_t *offset,           /* offset of stream for required file in *outBuffer */
+    size_t *outSizeProcessed, /* size of file in *outBuffer */
+    ISzAlloc *allocMain,
+    ISzAlloc *allocTemp);
+
+  If you need to decompress more than one file, you can send these values from previous call:
+    blockIndex,
+    outBuffer,
+    outBufferSize,
+  You can consider "outBuffer" as cache of solid block. If your archive is solid,
+  it will increase decompression speed.
+
+  After decompressing you must free "outBuffer":
+  allocImp.Free(outBuffer);
+
+6) call SzArEx_Free(&db, allocImp.Free) to free allocated items in "db".
+
+
+
+
+Memory requirements for .7z decoding
+------------------------------------
+
+Memory usage for Archive opening:
+  - Temporary pool:
+     - Memory for uncompressed .7z headers
+     - some other temporary blocks
+  - Main pool:
+     - Memory for database:
+       Estimated size of one file structures in solid archive:
+         - Size (4 or 8 Bytes)
+         - CRC32 (4 bytes)
+         - LastWriteTime (8 bytes)
+         - Some file information (4 bytes)
+         - File Name (variable length) + pointer + allocation structures
+
+Memory usage for archive Decompressing:
+  - Temporary pool:
+     - Memory for LZMA decompressing structures
+  - Main pool:
+     - Memory for decompressed solid block
+     - Memory for temprorary buffers, if BCJ2 fileter is used. Usually these
+       temprorary buffers can be about 15% of solid block size.
+
+
+7z Decoder doesn't allocate memory for compressed blocks.
+Instead of this, you must allocate buffer with desired
+size before calling 7z Decoder. Use 7zMain.c as example.
+
+
+Defines
+-------
+
+_SZ_ALLOC_DEBUG   - define it if you want to debug alloc/free operations to stderr.
+
+
+---
+
+http://www.7-zip.org
+http://www.7-zip.org/sdk.html
+http://www.7-zip.org/support.html
diff --git a/lib/lzma/Types.h b/lib/lzma/7zTypes.h
similarity index 96%
rename from lib/lzma/Types.h
rename to lib/lzma/7zTypes.h
index 6f7e735c1f68..953db1afc49e 100644
--- a/lib/lzma/Types.h
+++ b/lib/lzma/7zTypes.h
@@ -1,15 +1,15 @@
-/* Types.h -- Basic types
-2010-10-09 : Igor Pavlov : Public domain */
+/* 7zTypes.h -- Basic types
+2013-11-12 : Igor Pavlov : Public domain */
 
 #ifndef __7Z_TYPES_H
 #define __7Z_TYPES_H
 
-#include <stddef.h>
-
 #ifdef _WIN32
-#include <windows.h>
+/* #include <windows.h> */
 #endif
 
+#include <stddef.h>
+
 #define SZ_OK 0
 
 #define SZ_ERROR_DATA 1
@@ -31,7 +31,8 @@
 typedef int SRes;
 
 #ifdef _WIN32
-typedef DWORD WRes;
+/* typedef DWORD WRes; */
+typedef unsigned WRes;
 #else
 typedef int WRes;
 #endif
@@ -97,6 +98,7 @@ typedef int Bool;
 
 #else
 
+#define MY_NO_INLINE
 #define MY_CDECL
 #define MY_FAST_CALL
 
diff --git a/lib/lzma/Compiler.h b/lib/lzma/Compiler.h
new file mode 100644
index 000000000000..6e964897e1ee
--- /dev/null
+++ b/lib/lzma/Compiler.h
@@ -0,0 +1,28 @@
+/* Compiler.h -- Compiler ypes
+2013-11-12 : Igor Pavlov : Public domain */
+
+#ifndef __7Z_COMPILER_H
+#define __7Z_COMPILER_H
+
+#ifdef _MSC_VER
+
+  #ifdef UNDER_CE
+    #define RPC_NO_WINDOWS_H
+    /* #pragma warning(disable : 4115) // '_RPC_ASYNC_STATE' : named type definition in parentheses */
+    #pragma warning(disable : 4201) // nonstandard extension used : nameless struct/union
+    #pragma warning(disable : 4214) // nonstandard extension used : bit field types other than int
+  #endif
+
+  #if _MSC_VER >= 1300
+    #pragma warning(disable : 4996) // This function or variable may be unsafe
+  #else
+    #pragma warning(disable : 4511) // copy constructor could not be generated
+    #pragma warning(disable : 4512) // assignment operator could not be generated
+    #pragma warning(disable : 4702) // unreachable code
+    #pragma warning(disable : 4710) // not inlined
+    #pragma warning(disable : 4786) // identifier was truncated to '255' characters in the debug information
+  #endif
+
+#endif
+
+#endif
diff --git a/lib/lzma/LzmaDec.c b/lib/lzma/LzmaDec.c
index c6ff8ef26758..53196e37076b 100644
--- a/lib/lzma/LzmaDec.c
+++ b/lib/lzma/LzmaDec.c
@@ -1,5 +1,7 @@
 /* LzmaDec.c -- LZMA Decoder
-2010-12-15 : Igor Pavlov : Public domain */
+2015-01-01 : Igor Pavlov : Public domain */
+
+#include "Precomp.h"
 
 #include <config.h>
 #include <watchdog.h>
@@ -46,6 +48,13 @@
   i -= 0x40; }
 #endif
 
+#define NORMAL_LITER_DEC GET_BIT(prob + symbol, symbol)
+#define MATCHED_LITER_DEC \
+  matchByte <<= 1; \
+  bit = (matchByte & offs); \
+  probLit = prob + offs + bit + symbol; \
+  GET_BIT2(probLit, symbol, offs &= ~bit, offs &= bit)
+
 #define NORMALIZE_CHECK if (range < kTopValue) { if (buf >= bufLimit) return DUMMY_ERROR; range <<= 8; code = (code << 8) | (*buf++); }
 
 #define IF_BIT_0_CHECK(p) ttt = *(p); NORMALIZE_CHECK; bound = (range >> kNumBitModelTotalBits) * ttt; if (code < bound)
@@ -175,26 +184,47 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
       {
         state -= (state < 4) ? state : 3;
         symbol = 1;
-
-        do { GET_BIT(prob + symbol, symbol) } while (symbol < 0x100);
+        #ifdef _LZMA_SIZE_OPT
+        do { NORMAL_LITER_DEC } while (symbol < 0x100);
+        #else
+        NORMAL_LITER_DEC
+        NORMAL_LITER_DEC
+        NORMAL_LITER_DEC
+        NORMAL_LITER_DEC
+        NORMAL_LITER_DEC
+        NORMAL_LITER_DEC
+        NORMAL_LITER_DEC
+        NORMAL_LITER_DEC
+        #endif
       }
       else
       {
-        unsigned matchByte = p->dic[(dicPos - rep0) + ((dicPos < rep0) ? dicBufSize : 0)];
+        unsigned matchByte = dic[(dicPos - rep0) + ((dicPos < rep0) ? dicBufSize : 0)];
         unsigned offs = 0x100;
         state -= (state < 10) ? 3 : 6;
         symbol = 1;
-
+        #ifdef _LZMA_SIZE_OPT
         do
         {
           unsigned bit;
           CLzmaProb *probLit;
-          matchByte <<= 1;
-          bit = (matchByte & offs);
-          probLit = prob + offs + bit + symbol;
-          GET_BIT2(probLit, symbol, offs &= ~bit, offs &= bit)
+          MATCHED_LITER_DEC
         }
         while (symbol < 0x100);
+        #else
+        {
+          unsigned bit;
+          CLzmaProb *probLit;
+          MATCHED_LITER_DEC
+          MATCHED_LITER_DEC
+          MATCHED_LITER_DEC
+          MATCHED_LITER_DEC
+          MATCHED_LITER_DEC
+          MATCHED_LITER_DEC
+          MATCHED_LITER_DEC
+          MATCHED_LITER_DEC
+        }
+        #endif
       }
       dic[dicPos++] = (Byte)symbol;
       processedPos++;
diff --git a/lib/lzma/LzmaDec.h b/lib/lzma/LzmaDec.h
index 14b247b802bf..1e266991fd08 100644
--- a/lib/lzma/LzmaDec.h
+++ b/lib/lzma/LzmaDec.h
@@ -1,10 +1,10 @@
 /* LzmaDec.h -- LZMA Decoder
-2009-02-07 : Igor Pavlov : Public domain */
+2013-01-18 : Igor Pavlov : Public domain */
 
 #ifndef __LZMA_DEC_H
 #define __LZMA_DEC_H
 
-#include "Types.h"
+#include "7zTypes.h"
 
 /* #define _LZMA_PROB32 */
 /* _LZMA_PROB32 can increase the speed on some CPUs,
diff --git a/lib/lzma/Precomp.h b/lib/lzma/Precomp.h
new file mode 100644
index 000000000000..e8ff8b40e81a
--- /dev/null
+++ b/lib/lzma/Precomp.h
@@ -0,0 +1,10 @@
+/* Precomp.h -- StdAfx
+2013-11-12 : Igor Pavlov : Public domain */
+
+#ifndef __7Z_PRECOMP_H
+#define __7Z_PRECOMP_H
+
+#include "Compiler.h"
+/* #include "7zTypes.h" */
+
+#endif
diff --git a/lib/lzma/license.txt b/lib/lzma/license.txt
deleted file mode 100644
index 48b9820c4081..000000000000
--- a/lib/lzma/license.txt
+++ /dev/null
@@ -1,3 +0,0 @@
-               License
-
-LZMA SDK is placed in the public domain.
-- 
2.43.0

