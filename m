Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEF9D711CC
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DA4F836A3;
	Fri, 19 Dec 2025 00:37:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FE0WQCVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D38C68397D; Fri, 19 Dec 2025 00:37:09 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C3A5800AB
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:37:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7c6cc366884so534282a34.1
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766101020; x=1766705820; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6BZrZW2HDE7yfMmWMEbphgbrKUTagUsIEmkMbF/4Ry4=;
 b=FE0WQCVoX5K6hxY+GAILUVhudRnXJF4dW79+tYr6QC+47nRv7tTeUNVnA71Hd3X9c4
 FAq2H6nDjA9KiQiOTZ76TcpTDFHho9THkQakTBAfBWy37ohrL2zwPbwfHFIcxu0xqLvK
 /mUr3zU6dOyvc2YlFi3ndvpDpyZdHJI71LSIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766101020; x=1766705820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6BZrZW2HDE7yfMmWMEbphgbrKUTagUsIEmkMbF/4Ry4=;
 b=nf9QhPfv+DQ4/snqmAsSrQqm8xgx51cO0+GEsBC/4Gx7dcbDagFbTVrcwzhGc69Z57
 PN68VN0tKREBUBg69v8VIDDOIAsaLAL+rvcloOxuErFoIja/jCr3uYNKXKwDEnbyFprW
 icbeR1tCON/a3t8Yf2RrOv2YCzcyzrnEshU2La+cFtPh1fkzT9B4TlfvW2jDDDZlUvIA
 BNHrLxfLk96hE+LLGgl0GnACGHDapsGZ1DVJhQaz9zshwvcHW9ei4fo6cWdPYDjDE/vx
 2d0CA6BchcWIt+0uhPaOuW2p/FJnEm6Ys6uMLhYFtbFFaKH95qRenBx0JpE5VWg8XtJD
 0JUQ==
X-Gm-Message-State: AOJu0Yxlb6ody7WxUWdHeYYr0Lih5ag1opP2MgxaGOWC0Ton3LQdjT7Z
 ioNOaz8I6WhJkmmN4bp26rzM+hDVTRKIzqbH7SvwaODDb6NExDeLnjcVN/5wmWmObBgOm1tabmg
 E0VAAxAs=
X-Gm-Gg: AY/fxX7DR5OjaSXOnfkHHpS0brcahb+aqpTrt98y0WicpPeTimLdtdRqrPVvu/8Gzbo
 gizxok4uaQNVs73aMSfFl7SfRd8mPqljq1lI/QrlWUnGLux8TPjndc3q5UV6e8KSjiu13xOnGx2
 v6DbD8PjwSydDLvFxGJppezxHDDdUlN5nhISD9YbVs49vfx4Uu6D6nTzJR2GuoIztKHkVRtbIS2
 PEP7BQDMwnB2Cf+vol/0yENvW00/Cpamqdtn1iPwqW++TfHQcCAXd7kDNHI953eExGfhfD6MGc8
 FOrv7vwpClxj+tDpM44F6mUoCbsVtXcv+wzb+wl7Puq8fgoAbN7Lb7KY352bz/qVKxHV42eN2Nc
 emk8tdunkFjztAsEnEVBxvgsvrfO64nacw/X5DFFHNeEpa3zARzyT0fNDS/votEDyPJ0+2C0MQy
 91O1ATMbB5yZmXqTbq6MYtPHKoXZguHf6G3I0T4FE6tQxT0aa4D3BF
X-Google-Smtp-Source: AGHT+IHQkiRNAVQ5td6OIrdvysDwGg1NhdB4FdFgqvianUbWLlasF80NBMMGWVFWhu5Jc8UewPdmSA==
X-Received: by 2002:a05:6830:4407:b0:7c7:b28:227c with SMTP id
 46e09a7af769-7cc6689c6c3mr514498a34.4.1766101019229; 
 Thu, 18 Dec 2025 15:36:59 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaab5ccb9sm449605fac.10.2025.12.18.15.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:36:58 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
Subject: [PATCHv1 2/3] lzma: Update LZMA SDK code from 9.20 to 25.01
Date: Thu, 18 Dec 2025 17:30:57 -0600
Message-ID: <20251218233654.3938385-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218233654.3938385-1-trini@konsulko.com>
References: <20251218232255.3934258-1-trini@konsulko.com>
 <20251218233654.3938385-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently, we have a copy of the LZMA SDK code, version 9.20, with small
updates. The original import of the LZMA SDK included a script to update the
library. This is no longer possible, due to important local changes, so
remove it. We also remove a number of extra text files that should be
unchanged from upstream, but provide no direct value to the project.
Instead, have the help text for LZMA note that this comes from the LZMA
SDK.

Next, we move our code up to the current release, 25.01. There are a
number of new header files, and some performance improvements made to
the code, at the cost of between 2 to 3 kilobytes in binary size. As
there is now a Kconfig option to disable this and retain similar speed
to what we have currently, the default option is to make this trade-off.
Our changes to the code around calling schedule() to avoid the watchdog
being triggered are kept. We add __UBOOT__ guards in two places to
prevent conflict with our own usage of these words on MIPS.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 include/lzma/LzmaTypes.h   |    2 +-
 lib/Kconfig                |    5 +-
 lib/lzma/7zC.txt           |  187 +++++++
 lib/lzma/7zTypes.h         |  573 ++++++++++++++++++++
 lib/lzma/Compiler.h        |  240 +++++++++
 lib/lzma/LzmaDec.c         | 1022 ++++++++++++++++++++++++------------
 lib/lzma/LzmaDec.h         |   68 ++-
 lib/lzma/LzmaTools.c       |    4 +-
 lib/lzma/Makefile          |    4 +-
 lib/lzma/Precomp.h         |  125 +++++
 lib/lzma/README.txt        |   28 -
 lib/lzma/Types.h           |  232 --------
 lib/lzma/history.txt       |  271 ----------
 lib/lzma/import_lzmasdk.sh |   36 --
 lib/lzma/license.txt       |    3 -
 lib/lzma/lzma.txt          |  598 ---------------------
 16 files changed, 1856 insertions(+), 1542 deletions(-)
 create mode 100644 lib/lzma/7zC.txt
 create mode 100644 lib/lzma/7zTypes.h
 create mode 100644 lib/lzma/Compiler.h
 create mode 100644 lib/lzma/Precomp.h
 delete mode 100644 lib/lzma/README.txt
 delete mode 100644 lib/lzma/Types.h
 delete mode 100644 lib/lzma/history.txt
 delete mode 100644 lib/lzma/import_lzmasdk.sh
 delete mode 100644 lib/lzma/license.txt
 delete mode 100644 lib/lzma/lzma.txt

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
diff --git a/lib/Kconfig b/lib/Kconfig
index 96032eaddf95..931d5206936a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -835,8 +835,9 @@ config LZMA
 	help
 	  This enables support for LZMA (Lempel-Ziv-Markov chain algorithm),
 	  a dictionary compression algorithm that provides a high compression
-	  ratio and fairly fast decompression speed. See also
-	  CONFIG_CMD_LZMADEC which provides a decode command.
+	  ratio and fairly fast decompression speed. Our implementation comes
+	  from the LZMA SDK. See also CONFIG_CMD_LZMADEC which provides a
+	  decode command.
 
 config LZMA_SIZE_OPTIMIZATION
 	bool "Optimize the LZMA algorithm for smaller binary size"
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
diff --git a/lib/lzma/7zTypes.h b/lib/lzma/7zTypes.h
new file mode 100644
index 000000000000..18c804cf3b29
--- /dev/null
+++ b/lib/lzma/7zTypes.h
@@ -0,0 +1,573 @@
+/* 7zTypes.h -- Basic types
+2024-01-24 : Igor Pavlov : Public domain */
+
+#ifndef ZIP7_7Z_TYPES_H
+#define ZIP7_7Z_TYPES_H
+
+#ifdef _WIN32
+/* #include <windows.h> */
+#else
+#include <errno.h>
+#endif
+
+#include <stddef.h>
+
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
+#define SZ_OK 0
+
+#define SZ_ERROR_DATA 1
+#define SZ_ERROR_MEM 2
+#define SZ_ERROR_CRC 3
+#define SZ_ERROR_UNSUPPORTED 4
+#define SZ_ERROR_PARAM 5
+#define SZ_ERROR_INPUT_EOF 6
+#define SZ_ERROR_OUTPUT_EOF 7
+#define SZ_ERROR_READ 8
+#define SZ_ERROR_WRITE 9
+#define SZ_ERROR_PROGRESS 10
+#define SZ_ERROR_FAIL 11
+#define SZ_ERROR_THREAD 12
+
+#define SZ_ERROR_ARCHIVE 16
+#define SZ_ERROR_NO_ARCHIVE 17
+
+typedef int SRes;
+
+#ifdef _MSC_VER
+  #if _MSC_VER > 1200
+    #define MY_ALIGN(n) __declspec(align(n))
+  #else
+    #define MY_ALIGN(n)
+  #endif
+#else
+  /*
+  // C11/C++11:
+  #include <stdalign.h>
+  #define MY_ALIGN(n) alignas(n)
+  */
+  #define MY_ALIGN(n) __attribute__ ((aligned(n)))
+#endif
+
+#ifdef _WIN32
+
+/* typedef DWORD WRes; */
+typedef unsigned WRes;
+#define MY_SRes_HRESULT_FROM_WRes(x) HRESULT_FROM_WIN32(x)
+
+// #define MY_HRES_ERROR_INTERNAL_ERROR  MY_SRes_HRESULT_FROM_WRes(ERROR_INTERNAL_ERROR)
+
+#else // _WIN32
+
+// #define ENV_HAVE_LSTAT
+typedef int WRes;
+
+// (FACILITY_ERRNO = 0x800) is 7zip's FACILITY constant to represent (errno) errors in HRESULT
+#define MY_FACILITY_ERRNO  0x800
+#define MY_FACILITY_WIN32  7
+#define MY_FACILITY_WRes  MY_FACILITY_ERRNO
+
+#define MY_HRESULT_FROM_errno_CONST_ERROR(x) ((HRESULT)( \
+          ( (HRESULT)(x) & 0x0000FFFF) \
+          | (MY_FACILITY_WRes << 16)  \
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
+// if (MY_FACILITY_WRes != FACILITY_WIN32),
+// we use FACILITY_WIN32 for COM errors:
+#define E_OUTOFMEMORY               ((HRESULT)0x8007000EL)
+#define E_INVALIDARG                ((HRESULT)0x80070057L)
+#define MY_E_ERROR_NEGATIVE_SEEK    ((HRESULT)0x80070083L)
+
+/*
+// we can use FACILITY_ERRNO for some COM errors, that have errno equivalents:
+#define E_OUTOFMEMORY             MY_HRESULT_FROM_errno_CONST_ERROR(ENOMEM)
+#define E_INVALIDARG              MY_HRESULT_FROM_errno_CONST_ERROR(EINVAL)
+#define MY_E_ERROR_NEGATIVE_SEEK  MY_HRESULT_FROM_errno_CONST_ERROR(EINVAL)
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
+
+#endif
+
+#ifndef RINOK
+#define RINOK(x) { const int _result_ = (x); if (_result_ != 0) return _result_; }
+#endif
+
+#ifndef RINOK_WRes
+#define RINOK_WRes(x) { const WRes _result_ = (x); if (_result_ != 0) return _result_; }
+#endif
+
+typedef unsigned char Byte;
+typedef short Int16;
+typedef unsigned short UInt16;
+
+#ifdef Z7_DECL_Int32_AS_long
+typedef long Int32;
+typedef unsigned long UInt32;
+#else
+typedef int Int32;
+typedef unsigned int UInt32;
+#endif
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
+#define MY_HRES_ERROR_INTERNAL_ERROR  ((HRESULT)0x8007054FL)
+
+#ifdef Z7_DECL_Int64_AS_long
+
+typedef long Int64;
+typedef unsigned long UInt64;
+
+#else
+
+#if (defined(_MSC_VER) || defined(__BORLANDC__)) && !defined(__clang__)
+typedef __int64 Int64;
+typedef unsigned __int64 UInt64;
+#else
+#if defined(__clang__) || defined(__GNUC__)
+#include <stdint.h>
+typedef int64_t Int64;
+typedef uint64_t UInt64;
+#else
+typedef long long int Int64;
+typedef unsigned long long int UInt64;
+// #define UINT64_CONST(n) n ## ULL
+#endif
+#endif
+
+#endif
+
+#define UINT64_CONST(n) n
+
+#ifdef Z7_DECL_SizeT_AS_unsigned_int
+typedef unsigned int SizeT;
+#else
+typedef size_t SizeT;
+#endif
+
+/*
+#if (defined(_MSC_VER) && _MSC_VER <= 1200)
+typedef size_t MY_uintptr_t;
+#else
+#include <stdint.h>
+typedef uintptr_t MY_uintptr_t;
+#endif
+*/
+
+typedef int BoolInt;
+/* typedef BoolInt Bool; */
+#define True 1
+#define False 0
+
+#ifdef _WIN32
+#define Z7_STDCALL __stdcall
+#else
+#define Z7_STDCALL
+#endif
+
+#ifdef _MSC_VER
+
+#if _MSC_VER >= 1300
+#define Z7_NO_INLINE __declspec(noinline)
+#else
+#define Z7_NO_INLINE
+#endif
+
+#define Z7_FORCE_INLINE __forceinline
+
+#define Z7_CDECL      __cdecl
+#define Z7_FASTCALL  __fastcall
+
+#else //  _MSC_VER
+
+#if (defined(__GNUC__) && (__GNUC__ >= 4)) \
+    || (defined(__clang__) && (__clang_major__ >= 4)) \
+    || defined(__INTEL_COMPILER) \
+    || defined(__xlC__)
+#define Z7_NO_INLINE      __attribute__((noinline))
+#define Z7_FORCE_INLINE   __attribute__((always_inline)) inline
+#else
+#define Z7_NO_INLINE
+#define Z7_FORCE_INLINE
+#endif
+
+#define Z7_CDECL
+
+#if  defined(_M_IX86) \
+  || defined(__i386__)
+// #define Z7_FASTCALL __attribute__((fastcall))
+// #define Z7_FASTCALL __attribute__((cdecl))
+#define Z7_FASTCALL
+#elif defined(MY_CPU_AMD64)
+// #define Z7_FASTCALL __attribute__((ms_abi))
+#define Z7_FASTCALL
+#else
+#define Z7_FASTCALL
+#endif
+
+#endif //  _MSC_VER
+
+/* The following interfaces use first parameter as pointer to structure */
+
+// #define Z7_C_IFACE_CONST_QUAL
+#define Z7_C_IFACE_CONST_QUAL const
+
+#define Z7_C_IFACE_DECL(a) \
+  struct a ## _; \
+  typedef Z7_C_IFACE_CONST_QUAL struct a ## _ * a ## Ptr; \
+  typedef struct a ## _ a; \
+  struct a ## _
+
+Z7_C_IFACE_DECL (IByteIn)
+{
+  Byte (*Read)(IByteInPtr p); /* reads one byte, returns 0 in case of EOF or error */
+};
+#define IByteIn_Read(p) (p)->Read(p)
+
+Z7_C_IFACE_DECL (IByteOut)
+{
+  void (*Write)(IByteOutPtr p, Byte b);
+};
+#define IByteOut_Write(p, b) (p)->Write(p, b)
+
+Z7_C_IFACE_DECL (ISeqInStream)
+{
+  SRes (*Read)(ISeqInStreamPtr p, void *buf, size_t *size);
+    /* if (input(*size) != 0 && output(*size) == 0) means end_of_stream.
+       (output(*size) < input(*size)) is allowed */
+};
+#define ISeqInStream_Read(p, buf, size) (p)->Read(p, buf, size)
+
+/* try to read as much as avail in stream and limited by (*processedSize) */
+SRes SeqInStream_ReadMax(ISeqInStreamPtr stream, void *buf, size_t *processedSize);
+/* it can return SZ_ERROR_INPUT_EOF */
+// SRes SeqInStream_Read(ISeqInStreamPtr stream, void *buf, size_t size);
+// SRes SeqInStream_Read2(ISeqInStreamPtr stream, void *buf, size_t size, SRes errorType);
+SRes SeqInStream_ReadByte(ISeqInStreamPtr stream, Byte *buf);
+
+Z7_C_IFACE_DECL (ISeqOutStream)
+{
+  size_t (*Write)(ISeqOutStreamPtr p, const void *buf, size_t size);
+    /* Returns: result - the number of actually written bytes.
+       (result < size) means error */
+};
+#define ISeqOutStream_Write(p, buf, size) (p)->Write(p, buf, size)
+
+typedef enum
+{
+  SZ_SEEK_SET = 0,
+  SZ_SEEK_CUR = 1,
+  SZ_SEEK_END = 2
+} ESzSeek;
+
+Z7_C_IFACE_DECL (ISeekInStream)
+{
+  SRes (*Read)(ISeekInStreamPtr p, void *buf, size_t *size);  /* same as ISeqInStream::Read */
+  SRes (*Seek)(ISeekInStreamPtr p, Int64 *pos, ESzSeek origin);
+};
+#define ISeekInStream_Read(p, buf, size)   (p)->Read(p, buf, size)
+#define ISeekInStream_Seek(p, pos, origin) (p)->Seek(p, pos, origin)
+
+Z7_C_IFACE_DECL (ILookInStream)
+{
+  SRes (*Look)(ILookInStreamPtr p, const void **buf, size_t *size);
+    /* if (input(*size) != 0 && output(*size) == 0) means end_of_stream.
+       (output(*size) > input(*size)) is not allowed
+       (output(*size) < input(*size)) is allowed */
+  SRes (*Skip)(ILookInStreamPtr p, size_t offset);
+    /* offset must be <= output(*size) of Look */
+  SRes (*Read)(ILookInStreamPtr p, void *buf, size_t *size);
+    /* reads directly (without buffer). It's same as ISeqInStream::Read */
+  SRes (*Seek)(ILookInStreamPtr p, Int64 *pos, ESzSeek origin);
+};
+
+#define ILookInStream_Look(p, buf, size)   (p)->Look(p, buf, size)
+#define ILookInStream_Skip(p, offset)      (p)->Skip(p, offset)
+#define ILookInStream_Read(p, buf, size)   (p)->Read(p, buf, size)
+#define ILookInStream_Seek(p, pos, origin) (p)->Seek(p, pos, origin)
+
+SRes LookInStream_LookRead(ILookInStreamPtr stream, void *buf, size_t *size);
+SRes LookInStream_SeekTo(ILookInStreamPtr stream, UInt64 offset);
+
+/* reads via ILookInStream::Read */
+SRes LookInStream_Read2(ILookInStreamPtr stream, void *buf, size_t size, SRes errorType);
+SRes LookInStream_Read(ILookInStreamPtr stream, void *buf, size_t size);
+
+typedef struct
+{
+  ILookInStream vt;
+  ISeekInStreamPtr realStream;
+
+  size_t pos;
+  size_t size; /* it's data size */
+
+  /* the following variables must be set outside */
+  Byte *buf;
+  size_t bufSize;
+} CLookToRead2;
+
+void LookToRead2_CreateVTable(CLookToRead2 *p, int lookahead);
+
+#define LookToRead2_INIT(p) { (p)->pos = (p)->size = 0; }
+
+typedef struct
+{
+  ISeqInStream vt;
+  ILookInStreamPtr realStream;
+} CSecToLook;
+
+void SecToLook_CreateVTable(CSecToLook *p);
+
+typedef struct
+{
+  ISeqInStream vt;
+  ILookInStreamPtr realStream;
+} CSecToRead;
+
+void SecToRead_CreateVTable(CSecToRead *p);
+
+Z7_C_IFACE_DECL (ICompressProgress)
+{
+  SRes (*Progress)(ICompressProgressPtr p, UInt64 inSize, UInt64 outSize);
+    /* Returns: result. (result != SZ_OK) means break.
+       Value (UInt64)(Int64)-1 for size means unknown value. */
+};
+
+#define ICompressProgress_Progress(p, inSize, outSize) (p)->Progress(p, inSize, outSize)
+
+typedef struct ISzAlloc ISzAlloc;
+typedef const ISzAlloc * ISzAllocPtr;
+
+struct ISzAlloc
+{
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
+#ifndef Z7_container_of
+
+/*
+#define Z7_container_of(ptr, type, m) container_of(ptr, type, m)
+#define Z7_container_of(ptr, type, m) CONTAINING_RECORD(ptr, type, m)
+#define Z7_container_of(ptr, type, m) ((type *)((char *)(ptr) - offsetof(type, m)))
+#define Z7_container_of(ptr, type, m) (&((type *)0)->m == (ptr), ((type *)(((char *)(ptr)) - MY_offsetof(type, m))))
+*/
+
+/*
+  GCC shows warning: "perhaps the 'offsetof' macro was used incorrectly"
+    GCC 3.4.4 : classes with constructor
+    GCC 4.8.1 : classes with non-public variable members"
+*/
+
+#define Z7_container_of(ptr, type, m) \
+  ((type *)(void *)((char *)(void *) \
+  (1 ? (ptr) : &((type *)NULL)->m) - MY_offsetof(type, m)))
+
+#define Z7_container_of_CONST(ptr, type, m) \
+  ((const type *)(const void *)((const char *)(const void *) \
+  (1 ? (ptr) : &((type *)NULL)->m) - MY_offsetof(type, m)))
+
+/*
+#define Z7_container_of_NON_CONST_FROM_CONST(ptr, type, m) \
+  ((type *)(void *)(const void *)((const char *)(const void *) \
+  (1 ? (ptr) : &((type *)NULL)->m) - MY_offsetof(type, m)))
+*/
+
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
+/*
+#define Z7_CONTAINER_FROM_VTBL_CLS(ptr, type, m) Z7_CONTAINER_FROM_VTBL(ptr, type, m)
+*/
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
+#define Z7_memset_0_ARRAY(a)  memset((a), 0, sizeof(a))
+
+#ifndef Z7_ARRAY_SIZE
+#define Z7_ARRAY_SIZE(a) (sizeof(a) / sizeof((a)[0]))
+#endif
+
+#ifdef _WIN32
+
+#define CHAR_PATH_SEPARATOR '\\'
+#define WCHAR_PATH_SEPARATOR L'\\'
+#define STRING_PATH_SEPARATOR "\\"
+#define WSTRING_PATH_SEPARATOR L"\\"
+
+#else
+
+#define CHAR_PATH_SEPARATOR '/'
+#define WCHAR_PATH_SEPARATOR L'/'
+#define STRING_PATH_SEPARATOR "/"
+#define WSTRING_PATH_SEPARATOR L"/"
+
+#endif
+
+#define k_PropVar_TimePrec_0        0
+#define k_PropVar_TimePrec_Unix     1
+#define k_PropVar_TimePrec_DOS      2
+#define k_PropVar_TimePrec_HighPrec 3
+#define k_PropVar_TimePrec_Base     16
+#define k_PropVar_TimePrec_100ns (k_PropVar_TimePrec_Base + 7)
+#define k_PropVar_TimePrec_1ns   (k_PropVar_TimePrec_Base + 9)
+
+EXTERN_C_END
+
+#endif
+
+/*
+#ifndef Z7_ST
+#ifdef _7ZIP_ST
+#define Z7_ST
+#endif
+#endif
+*/
diff --git a/lib/lzma/Compiler.h b/lib/lzma/Compiler.h
new file mode 100644
index 000000000000..ee9afcee4dfd
--- /dev/null
+++ b/lib/lzma/Compiler.h
@@ -0,0 +1,240 @@
+/* Compiler.h : Compiler specific defines and pragmas
+: Igor Pavlov : Public domain */
+
+#ifndef ZIP7_INC_COMPILER_H
+#define ZIP7_INC_COMPILER_H
+
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
+  #endif
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
+#ifdef _MSC_VER
+
+  #ifdef UNDER_CE
+    #define RPC_NO_WINDOWS_H
+    /* #pragma warning(disable : 4115) // '_RPC_ASYNC_STATE' : named type definition in parentheses */
+    #pragma warning(disable : 4201) // nonstandard extension used : nameless struct/union
+    #pragma warning(disable : 4214) // nonstandard extension used : bit field types other than int
+  #endif
+
+#if defined(_MSC_VER) && _MSC_VER >= 1800
+#pragma warning(disable : 4464) // relative include path contains '..'
+#endif
+
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
+
+#define Z7_DIAGNOSTIC_IGNORE_END_RESERVED_MACRO_IDENTIFIER \
+  _Pragma("GCC diagnostic pop")
+#else
+#define Z7_DIAGNOSTIC_IGNORE_BEGIN_RESERVED_MACRO_IDENTIFIER
+#define Z7_DIAGNOSTIC_IGNORE_END_RESERVED_MACRO_IDENTIFIER
+#endif
+
+#define UNUSED_VAR(x) (void)x;
+/* #define UNUSED_VAR(x) x=x; */
+
+#endif
diff --git a/lib/lzma/LzmaDec.c b/lib/lzma/LzmaDec.c
index 954380af52ab..9cbe36af7182 100644
--- a/lib/lzma/LzmaDec.c
+++ b/lib/lzma/LzmaDec.c
@@ -1,81 +1,106 @@
 /* LzmaDec.c -- LZMA Decoder
-2009-09-20 : Igor Pavlov : Public domain */
+2023-04-07 : Igor Pavlov : Public domain */
+
+#include "Precomp.h"
 
 #include <config.h>
 #include <watchdog.h>
-#include "LzmaDec.h"
 
 #include <linux/string.h>
+/* #include "CpuArch.h" */
+#include "LzmaDec.h"
 
-#define kNumTopBits 24
-#define kTopValue ((UInt32)1 << kNumTopBits)
+// #define kNumTopBits 24
+#define kTopValue ((UInt32)1 << 24)
 
 #define kNumBitModelTotalBits 11
 #define kBitModelTotal (1 << kNumBitModelTotalBits)
-#define kNumMoveBits 5
 
 #define RC_INIT_SIZE 5
 
+#ifndef Z7_LZMA_DEC_OPT
+
+#define kNumMoveBits 5
 #define NORMALIZE if (range < kTopValue) { range <<= 8; code = (code << 8) | (*buf++); }
 
-#define IF_BIT_0(p) ttt = *(p); NORMALIZE; bound = (range >> kNumBitModelTotalBits) * ttt; if (code < bound)
+#define IF_BIT_0(p) ttt = *(p); NORMALIZE; bound = (range >> kNumBitModelTotalBits) * (UInt32)ttt; if (code < bound)
 #define UPDATE_0(p) range = bound; *(p) = (CLzmaProb)(ttt + ((kBitModelTotal - ttt) >> kNumMoveBits));
 #define UPDATE_1(p) range -= bound; code -= bound; *(p) = (CLzmaProb)(ttt - (ttt >> kNumMoveBits));
 #define GET_BIT2(p, i, A0, A1) IF_BIT_0(p) \
-  { UPDATE_0(p); i = (i + i); A0; } else \
-  { UPDATE_1(p); i = (i + i) + 1; A1; }
-#define GET_BIT(p, i) GET_BIT2(p, i, ; , ;)
+  { UPDATE_0(p)  i = (i + i); A0; } else \
+  { UPDATE_1(p)  i = (i + i) + 1; A1; }
+
+#define TREE_GET_BIT(probs, i) { GET_BIT2(probs + i, i, ;, ;); }
+
+#define REV_BIT(p, i, A0, A1) IF_BIT_0(p + i) \
+  { UPDATE_0(p + i)  A0; } else \
+  { UPDATE_1(p + i)  A1; }
+#define REV_BIT_VAR(  p, i, m) REV_BIT(p, i, i += m; m += m, m += m; i += m; )
+#define REV_BIT_CONST(p, i, m) REV_BIT(p, i, i += m;       , i += m * 2; )
+#define REV_BIT_LAST( p, i, m) REV_BIT(p, i, i -= m        , ; )
 
-#define TREE_GET_BIT(probs, i) { GET_BIT((probs + i), i); }
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
 
-#define NORMALIZE_CHECK if (range < kTopValue) { if (buf >= bufLimit) return DUMMY_ERROR; range <<= 8; code = (code << 8) | (*buf++); }
+#define NORMAL_LITER_DEC TREE_GET_BIT(prob, symbol)
+#define MATCHED_LITER_DEC \
+  matchByte += matchByte; \
+  bit = offs; \
+  offs &= matchByte; \
+  probLit = prob + (offs + bit + symbol); \
+  GET_BIT2(probLit, symbol, offs ^= bit; , ;)
+
+#endif // Z7_LZMA_DEC_OPT
 
-#define IF_BIT_0_CHECK(p) ttt = *(p); NORMALIZE_CHECK; bound = (range >> kNumBitModelTotalBits) * ttt; if (code < bound)
+#define NORMALIZE_CHECK if (range < kTopValue) { if (buf >= bufLimit) return DUMMY_INPUT_EOF; range <<= 8; code = (code << 8) | (*buf++); }
+
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
 
+#define REV_BIT_CHECK(p, i, m) IF_BIT_0_CHECK(p + i) \
+  { UPDATE_0_CHECK  i += m; m += m; } else \
+  { UPDATE_1_CHECK  m += m; i += m; }
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
@@ -89,54 +114,127 @@
 #define kAlignTableSize (1 << kNumAlignBits)
 
 #define kMatchMinLen 2
-#define kMatchSpecLenStart (kMatchMinLen + kLenNumLowSymbols + kLenNumMidSymbols + kLenNumHighSymbols)
+#define kMatchSpecLenStart (kMatchMinLen + kLenNumLowSymbols * 2 + kLenNumHighSymbols)
+
+#define kMatchSpecLen_Error_Data (1 << 9)
+#define kMatchSpecLen_Error_Fail (kMatchSpecLen_Error_Data - 1)
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
-
-#define LZMA_BASE_SIZE 1846
-#define LZMA_LIT_SIZE 768
+#define PosSlot (IsRepG2 + kNumStates)
+#define Literal (PosSlot + (kNumLenToPosStates << kNumPosSlotBits))
+#define NUM_BASE_PROBS (Literal + kStartOffset)
 
-#define LzmaProps_GetNumProbs(p) ((UInt32)LZMA_BASE_SIZE + (LZMA_LIT_SIZE << ((p)->lc + (p)->lp)))
+#if Align != 0 && kStartOffset != 0
+  #error Stop_Compiling_Bad_LZMA_kAlign
+#endif
 
-#if Literal != LZMA_BASE_SIZE
-StopCompilingDueBUG
+#if NUM_BASE_PROBS != 1984
+  #error Stop_Compiling_Bad_LZMA_PROBS
 #endif
 
+#define LZMA_LIT_SIZE 0x300
+
+#define LzmaProps_GetNumProbs(p) (NUM_BASE_PROBS + ((UInt32)LZMA_LIT_SIZE << ((p)->lc + (p)->lp)))
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
+    < kMatchSpecLenStart  : the number of bytes to be copied with (p->rep0) offset
+    = kMatchSpecLenStart  : the LZMA stream was finished with end mark
+    = kMatchSpecLenStart + 1  : need init range coder
+    = kMatchSpecLenStart + 2  : need init range coder and state
+    = kMatchSpecLen_Error_Fail                : Internal Code Failure
+    = kMatchSpecLen_Error_Data + [0 ... 273]  : LZMA Data Error
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
+    is not END_OF_PAYALOAD_MARKER, then the function doesn't write any byte to dictionary,
+    the function returns SZ_OK, and the caller can use (p->remainLen) and (p->reps[0]) later.
+  }
+
+Processing:
+  The first LZMA symbol will be decoded in any case.
+  All main checks for limits are at the end of main loop,
+  It decodes additional LZMA-symbols while (p->buf < bufLimit && dicPos < limit),
+  RangeCoder is still without last normalization when (p->buf < bufLimit) is being checked.
+  But if (p->buf < bufLimit), the caller provided at least (LZMA_REQUIRED_INPUT_MAX + 1) bytes for
+  next iteration  before limit (bufLimit + LZMA_REQUIRED_INPUT_MAX),
+  that is enough for worst case LZMA symbol with one additional RangeCoder normalization for one bit.
+  So that function never reads bufLimit [LZMA_REQUIRED_INPUT_MAX] byte.
+
 Out:
+  RangeCoder is normalized
   Result:
     SZ_OK - OK
-    SZ_ERROR_DATA - Error
-  p->remainLen:
-    < kMatchSpecLenStart : normal remain
-    = kMatchSpecLenStart : finished
-    = kMatchSpecLenStart + 1 : Flush marker
-    = kMatchSpecLenStart + 2 : State Init Marker
+      p->remainLen:
+        < kMatchSpecLenStart : the number of bytes to be copied with (p->reps[0]) offset
+        = kMatchSpecLenStart : the LZMA stream was finished with end mark
+
+    SZ_ERROR_DATA - error, when the MATCH-Symbol refers out of dictionary
+      p->remainLen : undefined
+      p->reps[*]    : undefined
 */
 
-static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
-{
-  CLzmaProb *probs = p->probs;
+#ifdef Z7_LZMA_DEC_OPT
 
-  unsigned state = p->state;
+int Z7_FASTCALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit);
+
+#else
+
+static
+int Z7_FASTCALL LZMA_DECODE_REAL(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
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
@@ -156,103 +254,129 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
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
-      UPDATE_0(prob);
+      UPDATE_0(prob)
       prob = probs + Literal;
-      if (checkDicSize != 0 || processedPos != 0)
-        prob += (LZMA_LIT_SIZE * (((processedPos & lpMask) << lc) +
-        (dic[(dicPos == 0 ? dicBufSize : dicPos) - 1] >> (8 - lc))));
+      if (processedPos != 0 || checkDicSize != 0)
+        prob += (UInt32)3 * ((((processedPos << 8) + dic[(dicPos == 0 ? dicBufSize : dicPos) - 1]) & lpMask) << lc);
+      processedPos++;
 
       if (state < kNumLitStates)
       {
         state -= (state < 4) ? state : 3;
         symbol = 1;
-
-        do { GET_BIT(prob + symbol, symbol) } while (symbol < 0x100);
+        #ifdef Z7_LZMA_SIZE_OPT
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
+        unsigned matchByte = dic[dicPos - rep0 + (dicPos < rep0 ? dicBufSize : 0)];
         unsigned offs = 0x100;
         state -= (state < 10) ? 3 : 6;
         symbol = 1;
-
+        #ifdef Z7_LZMA_SIZE_OPT
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
+
       dic[dicPos++] = (Byte)symbol;
-      processedPos++;
       continue;
     }
-    else
+
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
-        if (checkDicSize == 0 && processedPos == 0)
-          return SZ_ERROR_DATA;
+        UPDATE_1(prob)
         prob = probs + IsRepG0 + state;
         IF_BIT_0(prob)
         {
-          UPDATE_0(prob);
-          prob = probs + IsRep0Long + (state << kNumPosBitsMax) + posState;
+          UPDATE_0(prob)
+          prob = probs + IsRep0Long + COMBINED_PS_STATE;
           IF_BIT_0(prob)
           {
-            UPDATE_0(prob);
-            dic[dicPos] = dic[(dicPos - rep0) + ((dicPos < rep0) ? dicBufSize : 0)];
+            UPDATE_0(prob)
+
+            // that case was checked before with kBadRepCode
+            // if (checkDicSize == 0 && processedPos == 0) { len = kMatchSpecLen_Error_Data + 1; break; }
+            // The caller doesn't allow (dicPos == limit) case here
+            // so we don't need the following check:
+            // if (dicPos == limit) { state = state < kNumLitStates ? 9 : 11; len = 1; break; }
+
+            dic[dicPos] = dic[dicPos - rep0 + (dicPos < rep0 ? dicBufSize : 0)];
             dicPos++;
             processedPos++;
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
@@ -264,70 +388,106 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
         state = state < kNumLitStates ? 8 : 11;
         prob = probs + RepLenCoder;
       }
+
+      #ifdef Z7_LZMA_SIZE_OPT
       {
-        unsigned limit, offset;
+        unsigned lim, offset;
         CLzmaProb *probLen = prob + LenChoice;
         IF_BIT_0(probLen)
         {
-          UPDATE_0(probLen);
-          probLen = prob + LenLow + (posState << kLenNumLowBits);
+          UPDATE_0(probLen)
+          probLen = prob + LenLow + GET_LEN_STATE;
           offset = 0;
-          limit = (1 << kLenNumLowBits);
+          lim = (1 << kLenNumLowBits);
         }
         else
         {
-          UPDATE_1(probLen);
+          UPDATE_1(probLen)
           probLen = prob + LenChoice2;
           IF_BIT_0(probLen)
           {
-            UPDATE_0(probLen);
-            probLen = prob + LenMid + (posState << kLenNumMidBits);
+            UPDATE_0(probLen)
+            probLen = prob + LenLow + GET_LEN_STATE + (1 << kLenNumLowBits);
             offset = kLenNumLowSymbols;
-            limit = (1 << kLenNumMidBits);
+            lim = (1 << kLenNumLowBits);
           }
           else
           {
-            UPDATE_1(probLen);
+            UPDATE_1(probLen)
             probLen = prob + LenHigh;
-            offset = kLenNumLowSymbols + kLenNumMidSymbols;
-            limit = (1 << kLenNumHighBits);
+            offset = kLenNumLowSymbols * 2;
+            lim = (1 << kLenNumHighBits);
           }
         }
-        TREE_DECODE(probLen, limit, len);
+        TREE_DECODE(probLen, lim, len)
         len += offset;
       }
+      #else
+      {
+        CLzmaProb *probLen = prob + LenChoice;
+        IF_BIT_0(probLen)
+        {
+          UPDATE_0(probLen)
+          probLen = prob + LenLow + GET_LEN_STATE;
+          len = 1;
+          TREE_GET_BIT(probLen, len)
+          TREE_GET_BIT(probLen, len)
+          TREE_GET_BIT(probLen, len)
+          len -= 8;
+        }
+        else
+        {
+          UPDATE_1(probLen)
+          probLen = prob + LenChoice2;
+          IF_BIT_0(probLen)
+          {
+            UPDATE_0(probLen)
+            probLen = prob + LenLow + GET_LEN_STATE + (1 << kLenNumLowBits);
+            len = 1;
+            TREE_GET_BIT(probLen, len)
+            TREE_GET_BIT(probLen, len)
+            TREE_GET_BIT(probLen, len)
+          }
+          else
+          {
+            UPDATE_1(probLen)
+            probLen = prob + LenHigh;
+            TREE_DECODE(probLen, (1 << kLenNumHighBits), len)
+            len += kLenNumLowSymbols * 2;
+          }
+        }
+      }
+      #endif
 
       if (state >= kNumStates)
       {
         UInt32 distance;
         prob = probs + PosSlot +
             ((len < kNumLenToPosStates ? len : kNumLenToPosStates - 1) << kNumPosSlotBits);
-        TREE_6_DECODE(prob, distance);
+        TREE_6_DECODE(prob, distance)
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
+                REV_BIT_VAR(prob, distance, m)
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
@@ -349,64 +509,76 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
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
+              REV_BIT_CONST(prob, i, 1)
+              REV_BIT_CONST(prob, i, 2)
+              REV_BIT_CONST(prob, i, 4)
+              REV_BIT_LAST (prob, i, 8)
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
+          len += kMatchSpecLen_Error_Data + kMatchMinLen;
+          // len = kMatchSpecLen_Error_Data;
+          // len += kMatchMinLen;
+          break;
         }
-        else if (distance >= checkDicSize)
-          return SZ_ERROR_DATA;
-        state = (state < kNumStates + kNumLitStates) ? kNumLitStates : kNumLitStates + 3;
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
 
-        processedPos += curLen;
+        if ((rem = limit - dicPos) == 0)
+        {
+          /*
+          We stop decoding and return SZ_OK, and we can resume decoding later.
+          Any error conditions can be tested later in caller code.
+          For more strict mode we can stop decoding with error
+          // len += kMatchSpecLen_Error_Data;
+          */
+          break;
+        }
+
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
@@ -422,108 +594,145 @@ static int MY_FAST_CALL LzmaDec_DecodeReal(CLzmaDec *p, SizeT limit, const Byte
 
   schedule();
 
-  NORMALIZE;
+  NORMALIZE
+
   p->buf = buf;
   p->range = range;
   p->code = code;
-  p->remainLen = len;
+  p->remainLen = (UInt32)len; // & (kMatchSpecLen_Error_Data - 1); // we can write real length for error matches too.
   p->dicPos = dicPos;
   p->processedPos = processedPos;
   p->reps[0] = rep0;
   p->reps[1] = rep1;
   p->reps[2] = rep2;
   p->reps[3] = rep3;
-  p->state = state;
-
+  p->state = (UInt32)state;
+  if (len >= kMatchSpecLen_Error_Data)
+    return SZ_ERROR_DATA;
   return SZ_OK;
 }
+#endif
 
-static void MY_FAST_CALL LzmaDec_WriteRem(CLzmaDec *p, SizeT limit)
+static void Z7_FASTCALL LzmaDec_WriteRem(CLzmaDec *p, SizeT limit)
 {
-  if (p->remainLen != 0 && p->remainLen < kMatchSpecLenStart)
+  unsigned len = (unsigned)p->remainLen;
+  if (len == 0 /* || len >= kMatchSpecLenStart */)
+    return;
   {
-    Byte *dic = p->dic;
     SizeT dicPos = p->dicPos;
-    SizeT dicBufSize = p->dicBufSize;
-    unsigned len = p->remainLen;
-    UInt32 rep0 = p->reps[0];
-    if (limit - dicPos < len)
-      len = (unsigned)(limit - dicPos);
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
 
-    p->processedPos += len;
-    p->remainLen -= len;
-    while (len-- != 0)
+    p->processedPos += (UInt32)len;
+    p->remainLen -= (UInt32)len;
+    dic = p->dic;
+    rep0 = p->reps[0];
+    dicBufSize = p->dicBufSize;
+    do
     {
-      dic[dicPos] = dic[(dicPos - rep0) + ((dicPos < rep0) ? dicBufSize : 0)];
+      dic[dicPos] = dic[dicPos - rep0 + (dicPos < rep0 ? dicBufSize : 0)];
       dicPos++;
     }
+    while (--len);
     p->dicPos = dicPos;
   }
 }
 
-static int MY_FAST_CALL LzmaDec_DecodeReal2(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
-{
-  do
+/*
+At staring of new stream we have one of the following symbols:
+  - Literal        - is allowed
+  - Non-Rep-Match  - is allowed only if it's end marker symbol
+  - Rep-Match      - is not allowed
+We use early check of (RangeCoder:Code) over kBadRepCode to simplify main decoding code
+*/
+
+#define kRange0 0xFFFFFFFF
+#define kBound0 ((kRange0 >> kNumBitModelTotalBits) << (kNumBitModelTotalBits - 1))
+#define kBadRepCode (kBound0 + (((kRange0 - kBound0) >> kNumBitModelTotalBits) << (kNumBitModelTotalBits - 1)))
+#if kBadRepCode != (0xC0000000 - 0x400)
+  #error Stop_Compiling_Bad_LZMA_Check
+#endif
+
+/*
+LzmaDec_DecodeReal2():
+  It calls LZMA_DECODE_REAL() and it adjusts limit according (p->checkDicSize).
+
+We correct (p->checkDicSize) after LZMA_DECODE_REAL() and in LzmaDec_WriteRem(),
+and we support the following state of (p->checkDicSize):
+  if (total_processed < p->prop.dicSize) then
   {
-    SizeT limit2 = limit;
-    if (p->checkDicSize == 0)
-    {
-      UInt32 rem = p->prop.dicSize - p->processedPos;
-      if (limit - p->dicPos > rem)
-        limit2 = p->dicPos + rem;
-    }
-    RINOK(LzmaDec_DecodeReal(p, limit2, bufLimit));
-    if (p->processedPos >= p->prop.dicSize)
-      p->checkDicSize = p->prop.dicSize;
-    LzmaDec_WriteRem(p, limit);
+    (total_processed == p->processedPos)
+    (p->checkDicSize == 0)
   }
-  while (p->dicPos < limit && p->buf < bufLimit && p->remainLen < kMatchSpecLenStart);
+  else
+    (p->checkDicSize == p->prop.dicSize)
+*/
 
-  if (p->remainLen > kMatchSpecLenStart)
+static int Z7_FASTCALL LzmaDec_DecodeReal2(CLzmaDec *p, SizeT limit, const Byte *bufLimit)
+{
+  if (p->checkDicSize == 0)
   {
-    p->remainLen = kMatchSpecLenStart;
+    UInt32 rem = p->prop.dicSize - p->processedPos;
+    if (limit - p->dicPos > rem)
+      limit = p->dicPos + rem;
+  }
+  {
+    int res = LZMA_DECODE_REAL(p, limit, bufLimit);
+    if (p->checkDicSize == 0 && p->processedPos >= p->prop.dicSize)
+      p->checkDicSize = p->prop.dicSize;
+    return res;
   }
-  return 0;
 }
 
 typedef enum
 {
-  DUMMY_ERROR, /* unexpected end of input stream */
+  DUMMY_INPUT_EOF, /* need more input data */
   DUMMY_LIT,
   DUMMY_MATCH,
   DUMMY_REP
 } ELzmaDummy;
 
-static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inSize)
+#define IS_DUMMY_END_MARKER_POSSIBLE(dummyRes) ((dummyRes) == DUMMY_MATCH)
+
+static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, const Byte **bufOut)
 {
   UInt32 range = p->range;
   UInt32 code = p->code;
-  const Byte *bufLimit = buf + inSize;
-  CLzmaProb *probs = p->probs;
-  unsigned state = p->state;
+  const Byte *bufLimit = *bufOut;
+  const CLzmaProb *probs = GET_PROBS;
+  unsigned state = (unsigned)p->state;
   ELzmaDummy res;
 
+  for (;;)
   {
-    CLzmaProb *prob;
+    const CLzmaProb *prob;
     UInt32 bound;
     unsigned ttt;
-    unsigned posState = (p->processedPos) & ((1 << p->prop.pb) - 1);
+    unsigned posState = CALC_POS_STATE(p->processedPos, ((unsigned)1 << p->prop.pb) - 1);
 
-    prob = probs + IsMatch + (state << kNumPosBitsMax) + posState;
+    prob = probs + IsMatch + COMBINED_PS_STATE;
     IF_BIT_0_CHECK(prob)
     {
       UPDATE_0_CHECK
 
-      /* if (bufLimit - buf >= 7) return DUMMY_LIT; */
-
       prob = probs + Literal;
       if (p->checkDicSize != 0 || p->processedPos != 0)
-        prob += (LZMA_LIT_SIZE *
-          ((((p->processedPos) & ((1 << (p->prop.lp)) - 1)) << p->prop.lc) +
-          (p->dic[(p->dicPos == 0 ? p->dicBufSize : p->dicPos) - 1] >> (8 - p->prop.lc))));
+        prob += ((UInt32)LZMA_LIT_SIZE *
+            ((((p->processedPos) & (((unsigned)1 << (p->prop.lp)) - 1)) << p->prop.lc) +
+            ((unsigned)p->dic[(p->dicPos == 0 ? p->dicBufSize : p->dicPos) - 1] >> (8 - p->prop.lc))));
 
       if (state < kNumLitStates)
       {
@@ -533,17 +742,18 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
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
@@ -552,55 +762,54 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
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
-          prob = probs + IsRep0Long + (state << kNumPosBitsMax) + posState;
+          UPDATE_0_CHECK
+          prob = probs + IsRep0Long + COMBINED_PS_STATE;
           IF_BIT_0_CHECK(prob)
           {
-            UPDATE_0_CHECK;
-            NORMALIZE_CHECK;
-            return DUMMY_REP;
+            UPDATE_0_CHECK
+            break;
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
@@ -609,34 +818,34 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
       }
       {
         unsigned limit, offset;
-        CLzmaProb *probLen = prob + LenChoice;
+        const CLzmaProb *probLen = prob + LenChoice;
         IF_BIT_0_CHECK(probLen)
         {
-          UPDATE_0_CHECK;
-          probLen = prob + LenLow + (posState << kLenNumLowBits);
+          UPDATE_0_CHECK
+          probLen = prob + LenLow + GET_LEN_STATE;
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
-            probLen = prob + LenMid + (posState << kLenNumMidBits);
+            UPDATE_0_CHECK
+            probLen = prob + LenLow + GET_LEN_STATE + (1 << kLenNumLowBits);
             offset = kLenNumLowSymbols;
-            limit = 1 << kLenNumMidBits;
+            limit = 1 << kLenNumLowBits;
           }
           else
           {
-            UPDATE_1_CHECK;
+            UPDATE_1_CHECK
             probLen = prob + LenHigh;
-            offset = kLenNumLowSymbols + kLenNumMidSymbols;
+            offset = kLenNumLowSymbols * 2;
             limit = 1 << kLenNumHighBits;
           }
         }
-        TREE_DECODE_CHECK(probLen, limit, len);
+        TREE_DECODE_CHECK(probLen, limit, len)
         len += offset;
       }
 
@@ -644,18 +853,16 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
       {
         unsigned posSlot;
         prob = probs + PosSlot +
-            ((len < kNumLenToPosStates ? len : kNumLenToPosStates - 1) <<
+            ((len < kNumLenToPosStates - 1 ? len : kNumLenToPosStates - 1) <<
             kNumPosSlotBits);
-        TREE_DECODE_CHECK(prob, 1 << kNumPosSlotBits, posSlot);
+        TREE_DECODE_CHECK(prob, 1 << kNumPosSlotBits, posSlot)
         if (posSlot >= kStartPosModelIndex)
         {
-          int numDirectBits = ((posSlot >> 1) - 1);
-
-          /* if (bufLimit - buf >= 8) return DUMMY_MATCH; */
+          unsigned numDirectBits = ((posSlot >> 1) - 1);
 
           if (posSlot < kEndPosModelIndex)
           {
-            prob = probs + SpecPos + ((2 | (posSlot & 1)) << numDirectBits) - posSlot - 1;
+            prob = probs + SpecPos + ((2 | (posSlot & 1)) << numDirectBits);
           }
           else
           {
@@ -667,47 +874,44 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
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
+              REV_BIT_CHECK(prob, i, m)
             }
-            while (--numDirectBits != 0);
+            while (--numDirectBits);
           }
         }
       }
     }
+    break;
   }
-  NORMALIZE_CHECK;
-  return res;
-}
+  NORMALIZE_CHECK
 
-static void LzmaDec_InitRc(CLzmaDec *p, const Byte *data)
-{
-  p->code = ((UInt32)data[1] << 24) | ((UInt32)data[2] << 16) | ((UInt32)data[3] << 8) | ((UInt32)data[4]);
-  p->range = 0xFFFFFFFF;
-  p->needFlush = 0;
+  *bufOut = buf;
+  return res;
 }
 
-void LzmaDec_InitDicAndState(CLzmaDec *p, Bool initDic, Bool initState)
+void LzmaDec_InitDicAndState(CLzmaDec *p, BoolInt initDic, BoolInt initState);
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
@@ -716,48 +920,93 @@ void LzmaDec_Init(CLzmaDec *p)
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
+#define RETURN_NOT_FINISHED_FOR_FINISH \
+  *status = LZMA_STATUS_NOT_FINISHED; \
+  return SZ_ERROR_DATA; // for strict mode
+  // return SZ_OK; // for relaxed mode
 
 SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *srcLen,
     ELzmaFinishMode finishMode, ELzmaStatus *status)
 {
   SizeT inSize = *srcLen;
   (*srcLen) = 0;
-  LzmaDec_WriteRem(p, dicLimit);
-
   *status = LZMA_STATUS_NOT_SPECIFIED;
 
-  while (p->remainLen != kMatchSpecLenStart)
+  if (p->remainLen > kMatchSpecLenStart)
   {
-      int checkEndMarkNow;
+    if (p->remainLen > kMatchSpecLenStart + 2)
+      return p->remainLen == kMatchSpecLen_Error_Fail ? SZ_ERROR_FAIL : SZ_ERROR_DATA;
+
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
+    if (p->checkDicSize == 0
+        && p->processedPos == 0
+        && p->code >= kBadRepCode)
+      return SZ_ERROR_DATA;
 
-        LzmaDec_InitRc(p, p->tempBuf);
-        p->tempBufSize = 0;
-      }
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
+
+    p->remainLen = 0;
+  }
+
+  for (;;)
+  {
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
+      int checkEndMarkNow = 0;
 
-      checkEndMarkNow = 0;
       if (p->dicPos >= dicLimit)
       {
         if (p->remainLen == 0 && p->code == 0)
@@ -772,81 +1021,170 @@ SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit, const Byte *src, SizeT *sr
         }
         if (p->remainLen != 0)
         {
-          *status = LZMA_STATUS_NOT_FINISHED;
-          return SZ_ERROR_DATA;
+          RETURN_NOT_FINISHED_FOR_FINISH
         }
         checkEndMarkNow = 1;
       }
 
-      if (p->needInitState)
-        LzmaDec_InitStateReal(p);
+      // (p->remainLen == 0)
 
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
+            RETURN_NOT_FINISHED_FOR_FINISH
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
-          int dummyRes = LzmaDec_TryDummy(p, p->tempBuf, rem);
-          if (dummyRes == DUMMY_ERROR)
+          const Byte *bufOut = p->tempBuf + rem;
+
+          ELzmaDummy dummyRes = LzmaDec_TryDummy(p, p->tempBuf, &bufOut);
+
+          if (dummyRes == DUMMY_INPUT_EOF)
           {
-            (*srcLen) += lookAhead;
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
+            RETURN_NOT_FINISHED_FOR_FINISH
           }
         }
+
         p->buf = p->tempBuf;
-        if (LzmaDec_DecodeReal2(p, dicLimit, p->buf) != 0)
-          return SZ_ERROR_DATA;
-        lookAhead -= (rem - (unsigned)(p->buf - p->tempBuf));
-        (*srcLen) += lookAhead;
-        src += lookAhead;
-        inSize -= lookAhead;
-        p->tempBufSize = 0;
+
+        {
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
+        }
       }
+    }
   }
-  if (p->code == 0)
-    *status = LZMA_STATUS_FINISHED_WITH_MARK;
-  return (p->code == 0) ? SZ_OK : SZ_ERROR_DATA;
+
+  /*  Some unexpected error: internal error of code, memory corruption or hardware failure */
+  p->remainLen = kMatchSpecLen_Error_Fail;
+  return SZ_ERROR_FAIL;
 }
 
 SRes LzmaDec_DecodeToBuf(CLzmaDec *p, Byte *dest, SizeT *destLen, const Byte *src, SizeT *srcLen, ELzmaFinishMode finishMode, ELzmaStatus *status)
@@ -889,19 +1227,19 @@ SRes LzmaDec_DecodeToBuf(CLzmaDec *p, Byte *dest, SizeT *destLen, const Byte *sr
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
@@ -925,49 +1263,60 @@ SRes LzmaProps_Decode(CLzmaProps *p, const Byte *data, unsigned size)
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
-  RINOK(LzmaProps_Decode(&propNew, props, propsSize));
-  RINOK(LzmaDec_AllocateProbs2(p, &propNew, alloc));
+  RINOK(LzmaProps_Decode(&propNew, props, propsSize))
+  RINOK(LzmaDec_AllocateProbs2(p, &propNew, alloc))
   p->prop = propNew;
   return SZ_OK;
 }
 
-SRes LzmaDec_Allocate(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAlloc *alloc)
+SRes LzmaDec_Allocate(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAllocPtr alloc)
 {
   CLzmaProps propNew;
   SizeT dicBufSize;
-  RINOK(LzmaProps_Decode(&propNew, props, propsSize));
-  RINOK(LzmaDec_AllocateProbs2(p, &propNew, alloc));
-  dicBufSize = propNew.dicSize;
-  if (p->dic == 0 || dicBufSize != p->dicBufSize)
+  RINOK(LzmaProps_Decode(&propNew, props, propsSize))
+  RINOK(LzmaDec_AllocateProbs2(p, &propNew, alloc))
+
+  {
+    UInt32 dictSize = propNew.dicSize;
+    SizeT mask = ((UInt32)1 << 12) - 1;
+         if (dictSize >= ((UInt32)1 << 30)) mask = ((UInt32)1 << 22) - 1;
+    else if (dictSize >= ((UInt32)1 << 22)) mask = ((UInt32)1 << 20) - 1;
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
@@ -980,32 +1329,25 @@ SRes LzmaDec_Allocate(CLzmaDec *p, const Byte *props, unsigned propsSize, ISzAll
 
 SRes LzmaDecode(Byte *dest, SizeT *destLen, const Byte *src, SizeT *srcLen,
     const Byte *propData, unsigned propSize, ELzmaFinishMode finishMode,
-    ELzmaStatus *status, ISzAlloc *alloc)
+    ELzmaStatus *status, ISzAllocPtr alloc)
 {
   CLzmaDec p;
   SRes res;
-  SizeT inSize = *srcLen;
-  SizeT outSize = *destLen;
-  *srcLen = *destLen = 0;
+  SizeT outSize = *destLen, inSize = *srcLen;
+  *destLen = *srcLen = 0;
+  *status = LZMA_STATUS_NOT_SPECIFIED;
   if (inSize < RC_INIT_SIZE)
     return SZ_ERROR_INPUT_EOF;
-
-  LzmaDec_Construct(&p);
-  res = LzmaDec_AllocateProbs(&p, propData, propSize, alloc);
-  if (res != 0)
-    return res;
+  LzmaDec_CONSTRUCT(&p)
+  RINOK(LzmaDec_AllocateProbs(&p, propData, propSize, alloc))
   p.dic = dest;
   p.dicBufSize = outSize;
-
   LzmaDec_Init(&p);
-
   *srcLen = inSize;
   res = LzmaDec_DecodeToDic(&p, outSize, src, srcLen, finishMode, status);
-
+  *destLen = p.dicPos;
   if (res == SZ_OK && *status == LZMA_STATUS_NEEDS_MORE_INPUT)
     res = SZ_ERROR_INPUT_EOF;
-
-  (*destLen) = p.dicPos;
   LzmaDec_FreeProbs(&p, alloc);
   return res;
 }
diff --git a/lib/lzma/LzmaDec.h b/lib/lzma/LzmaDec.h
index 14b247b802bf..9e0ef3ef5835 100644
--- a/lib/lzma/LzmaDec.h
+++ b/lib/lzma/LzmaDec.h
@@ -1,28 +1,35 @@
 /* LzmaDec.h -- LZMA Decoder
-2009-02-07 : Igor Pavlov : Public domain */
+2023-04-02 : Igor Pavlov : Public domain */
 
-#ifndef __LZMA_DEC_H
-#define __LZMA_DEC_H
+#ifndef ZIP7_INC_LZMA_DEC_H
+#define ZIP7_INC_LZMA_DEC_H
 
-#include "Types.h"
+#include "7zTypes.h"
 
-/* #define _LZMA_PROB32 */
-/* _LZMA_PROB32 can increase the speed on some CPUs,
+EXTERN_C_BEGIN
+
+/* #define Z7_LZMA_PROB32 */
+/* Z7_LZMA_PROB32 can increase the speed on some CPUs,
    but memory usage for CLzmaDec::probs will be doubled in that case */
 
-#ifdef _LZMA_PROB32
-#define CLzmaProb UInt32
+typedef
+#ifdef Z7_LZMA_PROB32
+  UInt32
 #else
-#define CLzmaProb UInt16
+  UInt16
 #endif
+  CLzmaProb;
 
 /* ---------- LZMA Properties ---------- */
 
 #define LZMA_PROPS_SIZE 5
 
-typedef struct _CLzmaProps
+typedef struct
 {
-  unsigned lc, lp, pb;
+  Byte lc;
+  Byte lp;
+  Byte pb;
+  Byte _pad_;
   UInt32 dicSize;
 } CLzmaProps;
 
@@ -43,32 +50,35 @@ SRes LzmaProps_Decode(CLzmaProps *p, const Byte *data, unsigned size);
 
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
+#define LzmaDec_CONSTRUCT(p) { (p)->dic = NULL; (p)->probs = NULL; }
+#define LzmaDec_Construct(p) LzmaDec_CONSTRUCT(p)
 
 void LzmaDec_Init(CLzmaDec *p);
 
 /* There are two types of LZMA streams:
-     0) Stream with end mark. That end mark adds about 6 bytes to compressed size.
-     1) Stream without end mark. You must know exact uncompressed size to decompress such stream. */
+     - Stream with end mark. That end mark adds about 6 bytes to compressed size.
+     - Stream without end mark. You must know exact uncompressed size to decompress such stream. */
 
 typedef enum
 {
@@ -123,11 +133,11 @@ LzmaDec_Allocate* can return:
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
 
@@ -136,7 +146,7 @@ void LzmaDec_Free(CLzmaDec *state, ISzAlloc *alloc);
    You must work with CLzmaDec variables directly in this interface.
 
    STEPS:
-     LzmaDec_Constr()
+     LzmaDec_Construct()
      LzmaDec_Allocate()
      for (each new stream)
      {
@@ -168,6 +178,7 @@ Returns:
       LZMA_STATUS_NEEDS_MORE_INPUT
       LZMA_STATUS_MAYBE_FINISHED_WITHOUT_MARK
   SZ_ERROR_DATA - Data error
+  SZ_ERROR_FAIL - Some unexpected error: internal error of code, memory corruption or hardware failure
 */
 
 SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit,
@@ -208,10 +219,13 @@ Returns:
   SZ_ERROR_MEM  - Memory allocation error
   SZ_ERROR_UNSUPPORTED - Unsupported properties
   SZ_ERROR_INPUT_EOF - It needs more bytes in input buffer (src).
+  SZ_ERROR_FAIL - Some unexpected error: internal error of code, memory corruption or hardware failure
 */
 
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
new file mode 100644
index 000000000000..38f3d1eb6fdb
--- /dev/null
+++ b/lib/lzma/Precomp.h
@@ -0,0 +1,125 @@
+/* Precomp.h -- precompilation file
+2024-01-25 : Igor Pavlov : Public domain */
+
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
+
+#include "Compiler.h"
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
+
+#endif
diff --git a/lib/lzma/README.txt b/lib/lzma/README.txt
deleted file mode 100644
index 23a9be282734..000000000000
--- a/lib/lzma/README.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-The lib_lzma functionality was written by Igor Pavlov.
-The original source cames from the LZMA SDK web page:
-
-URL: 		http://www.7-zip.org/sdk.html
-Author:         Igor Pavlov
-
-The import is made using the import_lzmasdk.sh script that:
-
-* untars the lzmaXYY.tar.bz2 file (from the download web page)
-* copies the files LzmaDec.h, Types.h, LzmaDec.c, history.txt,
-  and lzma.txt from source archive into the lib_lzma directory (pwd).
-
-Example:
-
- . import_lzmasdk.sh ~/lzma465.tar.bz2
-
-Notice: The files from lzma sdk are _not modified_ by this script!
-
-The files LzmaTools.{c,h} are provided to export the lzmaBuffToBuffDecompress()
-function that wraps the complex LzmaDecode() function from the LZMA SDK. The
-do_bootm() function uses the lzmaBuffToBuffDecopress() function to expand the
-compressed image.
-
-The directory U-BOOT/include/lzma contains stubs files that permit to use the
-library directly from U-BOOT code without touching the original LZMA SDK's
-files.
-
-Luigi 'Comio' Mantellini <luigi.mantellini@idf-hit.com>
diff --git a/lib/lzma/Types.h b/lib/lzma/Types.h
deleted file mode 100644
index 6f7e735c1f68..000000000000
--- a/lib/lzma/Types.h
+++ /dev/null
@@ -1,232 +0,0 @@
-/* Types.h -- Basic types
-2010-10-09 : Igor Pavlov : Public domain */
-
-#ifndef __7Z_TYPES_H
-#define __7Z_TYPES_H
-
-#include <stddef.h>
-
-#ifdef _WIN32
-#include <windows.h>
-#endif
-
-#define SZ_OK 0
-
-#define SZ_ERROR_DATA 1
-#define SZ_ERROR_MEM 2
-#define SZ_ERROR_CRC 3
-#define SZ_ERROR_UNSUPPORTED 4
-#define SZ_ERROR_PARAM 5
-#define SZ_ERROR_INPUT_EOF 6
-#define SZ_ERROR_OUTPUT_EOF 7
-#define SZ_ERROR_READ 8
-#define SZ_ERROR_WRITE 9
-#define SZ_ERROR_PROGRESS 10
-#define SZ_ERROR_FAIL 11
-#define SZ_ERROR_THREAD 12
-
-#define SZ_ERROR_ARCHIVE 16
-#define SZ_ERROR_NO_ARCHIVE 17
-
-typedef int SRes;
-
-#ifdef _WIN32
-typedef DWORD WRes;
-#else
-typedef int WRes;
-#endif
-
-#ifndef RINOK
-#define RINOK(x) { int __result__ = (x); if (__result__ != 0) return __result__; }
-#endif
-
-typedef unsigned char Byte;
-typedef short Int16;
-typedef unsigned short UInt16;
-
-#ifdef _LZMA_UINT32_IS_ULONG
-typedef long Int32;
-typedef unsigned long UInt32;
-#else
-typedef int Int32;
-typedef unsigned int UInt32;
-#endif
-
-#ifdef _SZ_NO_INT_64
-
-/* define _SZ_NO_INT_64, if your compiler doesn't support 64-bit integers.
-   NOTES: Some code will work incorrectly in that case! */
-
-typedef long Int64;
-typedef unsigned long UInt64;
-
-#else
-
-#if defined(_MSC_VER) || defined(__BORLANDC__)
-typedef __int64 Int64;
-typedef unsigned __int64 UInt64;
-#define UINT64_CONST(n) n
-#else
-typedef long long int Int64;
-typedef unsigned long long int UInt64;
-#define UINT64_CONST(n) n ## ULL
-#endif
-
-#endif
-
-#ifdef _LZMA_NO_SYSTEM_SIZE_T
-typedef UInt32 SizeT;
-#else
-typedef size_t SizeT;
-#endif
-
-typedef int Bool;
-#define True 1
-#define False 0
-
-#ifdef _MSC_VER
-
-#if _MSC_VER >= 1300
-#define MY_NO_INLINE __declspec(noinline)
-#else
-#define MY_NO_INLINE
-#endif
-
-#define MY_CDECL __cdecl
-#define MY_FAST_CALL __fastcall
-
-#else
-
-#define MY_CDECL
-#define MY_FAST_CALL
-
-#endif
-
-/* The following interfaces use first parameter as pointer to structure */
-
-typedef struct
-{
-  Byte (*Read)(void *p); /* reads one byte, returns 0 in case of EOF or error */
-} IByteIn;
-
-typedef struct
-{
-  void (*Write)(void *p, Byte b);
-} IByteOut;
-
-typedef struct
-{
-  SRes (*Read)(void *p, void *buf, size_t *size);
-    /* if (input(*size) != 0 && output(*size) == 0) means end_of_stream.
-       (output(*size) < input(*size)) is allowed */
-} ISeqInStream;
-
-/* it can return SZ_ERROR_INPUT_EOF */
-SRes SeqInStream_Read(ISeqInStream *stream, void *buf, size_t size);
-SRes SeqInStream_Read2(ISeqInStream *stream, void *buf, size_t size, SRes errorType);
-SRes SeqInStream_ReadByte(ISeqInStream *stream, Byte *buf);
-
-typedef struct
-{
-  size_t (*Write)(void *p, const void *buf, size_t size);
-    /* Returns: result - the number of actually written bytes.
-       (result < size) means error */
-} ISeqOutStream;
-
-typedef enum
-{
-  SZ_SEEK_SET = 0,
-  SZ_SEEK_CUR = 1,
-  SZ_SEEK_END = 2
-} ESzSeek;
-
-typedef struct
-{
-  SRes (*Read)(void *p, void *buf, size_t *size);  /* same as ISeqInStream::Read */
-  SRes (*Seek)(void *p, Int64 *pos, ESzSeek origin);
-} ISeekInStream;
-
-typedef struct
-{
-  SRes (*Look)(void *p, const void **buf, size_t *size);
-    /* if (input(*size) != 0 && output(*size) == 0) means end_of_stream.
-       (output(*size) > input(*size)) is not allowed
-       (output(*size) < input(*size)) is allowed */
-  SRes (*Skip)(void *p, size_t offset);
-    /* offset must be <= output(*size) of Look */
-
-  SRes (*Read)(void *p, void *buf, size_t *size);
-    /* reads directly (without buffer). It's same as ISeqInStream::Read */
-  SRes (*Seek)(void *p, Int64 *pos, ESzSeek origin);
-} ILookInStream;
-
-SRes LookInStream_LookRead(ILookInStream *stream, void *buf, size_t *size);
-SRes LookInStream_SeekTo(ILookInStream *stream, UInt64 offset);
-
-/* reads via ILookInStream::Read */
-SRes LookInStream_Read2(ILookInStream *stream, void *buf, size_t size, SRes errorType);
-SRes LookInStream_Read(ILookInStream *stream, void *buf, size_t size);
-
-#define LookToRead_BUF_SIZE (1 << 14)
-
-typedef struct
-{
-  ILookInStream s;
-  ISeekInStream *realStream;
-  size_t pos;
-  size_t size;
-  Byte buf[LookToRead_BUF_SIZE];
-} CLookToRead;
-
-void LookToRead_CreateVTable(CLookToRead *p, int lookahead);
-void LookToRead_Init(CLookToRead *p);
-
-typedef struct
-{
-  ISeqInStream s;
-  ILookInStream *realStream;
-} CSecToLook;
-
-void SecToLook_CreateVTable(CSecToLook *p);
-
-typedef struct
-{
-  ISeqInStream s;
-  ILookInStream *realStream;
-} CSecToRead;
-
-void SecToRead_CreateVTable(CSecToRead *p);
-
-typedef struct
-{
-  SRes (*Progress)(void *p, UInt64 inSize, UInt64 outSize);
-    /* Returns: result. (result != SZ_OK) means break.
-       Value (UInt64)(Int64)-1 for size means unknown value. */
-} ICompressProgress;
-
-typedef struct
-{
-  void *(*Alloc)(void *p, size_t size);
-  void (*Free)(void *p, void *address); /* address can be 0 */
-} ISzAlloc;
-
-#define IAlloc_Alloc(p, size) (p)->Alloc((p), size)
-#define IAlloc_Free(p, a) (p)->Free((p), a)
-
-#ifdef _WIN32
-
-#define CHAR_PATH_SEPARATOR '\\'
-#define WCHAR_PATH_SEPARATOR L'\\'
-#define STRING_PATH_SEPARATOR "\\"
-#define WSTRING_PATH_SEPARATOR L"\\"
-
-#else
-
-#define CHAR_PATH_SEPARATOR '/'
-#define WCHAR_PATH_SEPARATOR u'/'
-#define STRING_PATH_SEPARATOR "/"
-#define WSTRING_PATH_SEPARATOR u"/"
-
-#endif
-
-#endif
diff --git a/lib/lzma/history.txt b/lib/lzma/history.txt
deleted file mode 100644
index 443511bdd49c..000000000000
--- a/lib/lzma/history.txt
+++ /dev/null
@@ -1,271 +0,0 @@
-HISTORY of the LZMA SDK
------------------------
-
-9.18 beta      2010-11-02
--------------------------
-- New small SFX module for installers (SfxSetup).
-
-
-9.12 beta      2010-03-24
--------------------------
-- The BUG in LZMA SDK 9.* was fixed: LZMA2 codec didn't work,
-  if more than 10 threads were used (or more than 20 threads in some modes).
-
-
-9.11 beta      2010-03-15
--------------------------
-- PPMd compression method support
-
-
-9.09           2009-12-12
--------------------------
-- The bug was fixed:
-   Utf16_To_Utf8 funstions in UTFConvert.cpp and 7zMain.c
-   incorrectly converted surrogate characters (the code >= 0x10000) to UTF-8.
-- Some bugs were fixed
-
-
-9.06           2009-08-17
--------------------------
-- Some changes in ANSI-C 7z Decoder interfaces.
-
-
-9.04           2009-05-30
--------------------------
-- LZMA2 compression method support
-- xz format support
-
-
-4.65           2009-02-03
--------------------------
-- Some minor fixes
-
-
-4.63           2008-12-31
--------------------------
-- Some minor fixes
-
-
-4.61 beta      2008-11-23
--------------------------
-- The bug in ANSI-C LZMA Decoder was fixed:
-    If encoded stream was corrupted, decoder could access memory
-    outside of allocated range.
-- Some changes in ANSI-C 7z Decoder interfaces.
-- LZMA SDK is placed in the public domain.
-
-
-4.60 beta      2008-08-19
--------------------------
-- Some minor fixes.
-
-
-4.59 beta      2008-08-13
--------------------------
-- The bug was fixed:
-    LZMA Encoder in fast compression mode could access memory outside of
-    allocated range in some rare cases.
-
-
-4.58 beta      2008-05-05
--------------------------
-- ANSI-C LZMA Decoder was rewritten for speed optimizations.
-- ANSI-C LZMA Encoder was included to LZMA SDK.
-- C++ LZMA code now is just wrapper over ANSI-C code.
-
-
-4.57           2007-12-12
--------------------------
-- Speed optimizations in Ñ++ LZMA Decoder.
-- Small changes for more compatibility with some C/C++ compilers.
-
-
-4.49 beta      2007-07-05
--------------------------
-- .7z ANSI-C Decoder:
-     - now it supports BCJ and BCJ2 filters
-     - now it supports files larger than 4 GB.
-     - now it supports "Last Write Time" field for files.
-- C++ code for .7z archives compressing/decompressing from 7-zip
-  was included to LZMA SDK.
-
-
-4.43           2006-06-04
--------------------------
-- Small changes for more compatibility with some C/C++ compilers.
-
-
-4.42           2006-05-15
--------------------------
-- Small changes in .h files in ANSI-C version.
-
-
-4.39 beta      2006-04-14
--------------------------
-- The bug in versions 4.33b:4.38b was fixed:
-  C++ version of LZMA encoder could not correctly compress
-  files larger than 2 GB with HC4 match finder (-mfhc4).
-
-
-4.37 beta      2005-04-06
--------------------------
-- Fixes in C++ code: code could no be compiled if _NO_EXCEPTIONS was defined.
-
-
-4.35 beta      2005-03-02
--------------------------
-- The bug was fixed in C++ version of LZMA Decoder:
-    If encoded stream was corrupted, decoder could access memory
-    outside of allocated range.
-
-
-4.34 beta      2006-02-27
--------------------------
-- Compressing speed and memory requirements for compressing were increased
-- LZMA now can use only these match finders: HC4, BT2, BT3, BT4
-
-
-4.32           2005-12-09
--------------------------
-- Java version of LZMA SDK was included
-
-
-4.30           2005-11-20
--------------------------
-- Compression ratio was improved in -a2 mode
-- Speed optimizations for compressing in -a2 mode
-- -fb switch now supports values up to 273
-- The bug in 7z_C (7zIn.c) was fixed:
-  It used Alloc/Free functions from different memory pools.
-  So if program used two memory pools, it worked incorrectly.
-- 7z_C: .7z format supporting was improved
-- LZMA# SDK (C#.NET version) was included
-
-
-4.27 (Updated) 2005-09-21
--------------------------
-- Some GUIDs/interfaces in C++ were changed.
- IStream.h:
-   ISequentialInStream::Read now works as old ReadPart
-   ISequentialOutStream::Write now works as old WritePart
-
-
-4.27           2005-08-07
--------------------------
-- The bug in LzmaDecodeSize.c was fixed:
-   if _LZMA_IN_CB and _LZMA_OUT_READ were defined,
-   decompressing worked incorrectly.
-
-
-4.26           2005-08-05
--------------------------
-- Fixes in 7z_C code and LzmaTest.c:
-  previous versions could work incorrectly,
-  if malloc(0) returns 0
-
-
-4.23           2005-06-29
--------------------------
-- Small fixes in C++ code
-
-
-4.22           2005-06-10
--------------------------
-- Small fixes
-
-
-4.21           2005-06-08
--------------------------
-- Interfaces for ANSI-C LZMA Decoder (LzmaDecode.c) were changed
-- New additional version of ANSI-C LZMA Decoder with zlib-like interface:
-    - LzmaStateDecode.h
-    - LzmaStateDecode.c
-    - LzmaStateTest.c
-- ANSI-C LZMA Decoder now can decompress files larger than 4 GB
-
-
-4.17           2005-04-18
--------------------------
-- New example for RAM->RAM compressing/decompressing:
-  LZMA + BCJ (filter for x86 code):
-    - LzmaRam.h
-    - LzmaRam.cpp
-    - LzmaRamDecode.h
-    - LzmaRamDecode.c
-    - -f86 switch for lzma.exe
-
-
-4.16           2005-03-29
--------------------------
-- The bug was fixed in LzmaDecode.c (ANSI-C LZMA Decoder):
-   If _LZMA_OUT_READ was defined, and if encoded stream was corrupted,
-   decoder could access memory outside of allocated range.
-- Speed optimization of ANSI-C LZMA Decoder (now it's about 20% faster).
-  Old version of LZMA Decoder now is in file LzmaDecodeSize.c.
-  LzmaDecodeSize.c can provide slightly smaller code than LzmaDecode.c
-- Small speed optimization in LZMA C++ code
-- filter for SPARC's code was added
-- Simplified version of .7z ANSI-C Decoder was included
-
-
-4.06           2004-09-05
--------------------------
-- The bug in v4.05 was fixed:
-    LZMA-Encoder didn't release output stream in some cases.
-
-
-4.05           2004-08-25
--------------------------
-- Source code of filters for x86, IA-64, ARM, ARM-Thumb
-  and PowerPC code was included to SDK
-- Some internal minor changes
-
-
-4.04           2004-07-28
--------------------------
-- More compatibility with some C++ compilers
-
-
-4.03           2004-06-18
--------------------------
-- "Benchmark" command was added. It measures compressing
-  and decompressing speed and shows rating values.
-  Also it checks hardware errors.
-
-
-4.02           2004-06-10
--------------------------
-- C++ LZMA Encoder/Decoder code now is more portable
-  and it can be compiled by GCC on Linux.
-
-
-4.01           2004-02-15
--------------------------
-- Some detection of data corruption was enabled.
-    LzmaDecode.c / RangeDecoderReadByte
-    .....
-    {
-      rd->ExtraBytes = 1;
-      return 0xFF;
-    }
-
-
-4.00           2004-02-13
--------------------------
-- Original version of LZMA SDK
-
-
-
-HISTORY of the LZMA
--------------------
-  2001-2008:  Improvements to LZMA compressing/decompressing code,
-              keeping compatibility with original LZMA format
-  1996-2001:  Development of LZMA compression format
-
-  Some milestones:
-
-  2001-08-30: LZMA compression was added to 7-Zip
-  1999-01-02: First version of 7-Zip was released
-
-
-End of document
diff --git a/lib/lzma/import_lzmasdk.sh b/lib/lzma/import_lzmasdk.sh
deleted file mode 100644
index 1e0f6863aab7..000000000000
--- a/lib/lzma/import_lzmasdk.sh
+++ /dev/null
@@ -1,36 +0,0 @@
-#!/bin/sh
-
-usage() {
-	echo "Usage: $0 lzmaVERSION.tar.bz2" >&2
-	echo >&2
-	exit 1
-}
-
-if [ "$1" = "" ] ; then
-	 usage
-fi
-
-if [ ! -f $1 ] ; then
-	echo "$1 doesn't exist!" >&2
-	exit 1
-fi
-
-BASENAME=`basename $1 .tar.bz2`
-TMPDIR=/tmp/tmp_lib_$BASENAME
-FILES="C/LzmaDec.h
-      C/Types.h
-      C/LzmaDec.c
-      history.txt
-      lzma.txt"
-
-mkdir -p $TMPDIR
-echo "Untar $1 -> $TMPDIR"
-tar -jxf $1 -C $TMPDIR
-
-for i in $FILES; do
-	echo Copying  $TMPDIR/$i \-\> `basename $i`
-	cp $TMPDIR/$i .
-	chmod -x `basename $i`
-done
-
-echo "done!"
diff --git a/lib/lzma/license.txt b/lib/lzma/license.txt
deleted file mode 100644
index 48b9820c4081..000000000000
--- a/lib/lzma/license.txt
+++ /dev/null
@@ -1,3 +0,0 @@
-               License
-
-LZMA SDK is placed in the public domain.
diff --git a/lib/lzma/lzma.txt b/lib/lzma/lzma.txt
deleted file mode 100644
index 144cd9aee2ec..000000000000
--- a/lib/lzma/lzma.txt
+++ /dev/null
@@ -1,598 +0,0 @@
-LZMA SDK 9.20
--------------
-
-LZMA SDK provides the documentation, samples, header files, libraries,
-and tools you need to develop applications that use LZMA compression.
-
-LZMA is default and general compression method of 7z format
-in 7-Zip compression program (www.7-zip.org). LZMA provides high
-compression ratio and very fast decompression.
-
-LZMA is an improved version of famous LZ77 compression algorithm.
-It was improved in way of maximum increasing of compression ratio,
-keeping high decompression speed and low memory requirements for
-decompressing.
-
-
-
-LICENSE
--------
-
-LZMA SDK is written and placed in the public domain by Igor Pavlov.
-
-Some code in LZMA SDK is based on public domain code from another developers:
-  1) PPMd var.H (2001): Dmitry Shkarin
-  2) SHA-256: Wei Dai (Crypto++ library)
-
-
-LZMA SDK Contents
------------------
-
-LZMA SDK includes:
-
-  - ANSI-C/C++/C#/Java source code for LZMA compressing and decompressing
-  - Compiled file->file LZMA compressing/decompressing program for Windows system
-
-
-UNIX/Linux version
-------------------
-To compile C++ version of file->file LZMA encoding, go to directory
-CPP/7zip/Bundles/LzmaCon
-and call make to recompile it:
-  make -f makefile.gcc clean all
-
-In some UNIX/Linux versions you must compile LZMA with static libraries.
-To compile with static libraries, you can use
-LIB = -lm -static
-
-
-Files
----------------------
-lzma.txt     - LZMA SDK description (this file)
-7zFormat.txt - 7z Format description
-7zC.txt      - 7z ANSI-C Decoder description
-methods.txt  - Compression method IDs for .7z
-lzma.exe     - Compiled file->file LZMA encoder/decoder for Windows
-7zr.exe      - 7-Zip with 7z/lzma/xz support.
-history.txt  - history of the LZMA SDK
-
-
-Source code structure
----------------------
-
-C/  - C files
-        7zCrc*.*   - CRC code
-        Alloc.*    - Memory allocation functions
-        Bra*.*     - Filters for x86, IA-64, ARM, ARM-Thumb, PowerPC and SPARC code
-        LzFind.*   - Match finder for LZ (LZMA) encoders
-        LzFindMt.* - Match finder for LZ (LZMA) encoders for multithreading encoding
-        LzHash.h   - Additional file for LZ match finder
-        LzmaDec.*  - LZMA decoding
-        LzmaEnc.*  - LZMA encoding
-        LzmaLib.*  - LZMA Library for DLL calling
-        Types.h    - Basic types for another .c files
-        Threads.*  - The code for multithreading.
-
-    LzmaLib  - LZMA Library (.DLL for Windows)
-
-    LzmaUtil - LZMA Utility (file->file LZMA encoder/decoder).
-
-    Archive - files related to archiving
-      7z     - 7z ANSI-C Decoder
-
-CPP/ -- CPP files
-
-  Common  - common files for C++ projects
-  Windows - common files for Windows related code
-
-  7zip    - files related to 7-Zip Project
-
-    Common   - common files for 7-Zip
-
-    Compress - files related to compression/decompression
-
-    Archive - files related to archiving
-
-      Common   - common files for archive handling
-      7z       - 7z C++ Encoder/Decoder
-
-    Bundles    - Modules that are bundles of other modules
-
-      Alone7z           - 7zr.exe: Standalone version of 7z.exe that supports only 7z/LZMA/BCJ/BCJ2
-      LzmaCon           - lzma.exe: LZMA compression/decompression
-      Format7zR         - 7zr.dll: Reduced version of 7za.dll: extracting/compressing to 7z/LZMA/BCJ/BCJ2
-      Format7zExtractR  - 7zxr.dll: Reduced version of 7zxa.dll: extracting from 7z/LZMA/BCJ/BCJ2.
-
-    UI        - User Interface files
-
-      Client7z - Test application for 7za.dll,  7zr.dll, 7zxr.dll
-      Common   - Common UI files
-      Console  - Code for console archiver
-
-
-
-CS/ - C# files
-  7zip
-    Common   - some common files for 7-Zip
-    Compress - files related to compression/decompression
-      LZ     - files related to LZ (Lempel-Ziv) compression algorithm
-      LZMA         - LZMA compression/decompression
-      LzmaAlone    - file->file LZMA compression/decompression
-      RangeCoder   - Range Coder (special code of compression/decompression)
-
-Java/  - Java files
-  SevenZip
-    Compression    - files related to compression/decompression
-      LZ           - files related to LZ (Lempel-Ziv) compression algorithm
-      LZMA         - LZMA compression/decompression
-      RangeCoder   - Range Coder (special code of compression/decompression)
-
-
-C/C++ source code of LZMA SDK is part of 7-Zip project.
-7-Zip source code can be downloaded from 7-Zip's SourceForge page:
-
-  http://sourceforge.net/projects/sevenzip/
-
-
-
-LZMA features
--------------
-  - Variable dictionary size (up to 1 GB)
-  - Estimated compressing speed: about 2 MB/s on 2 GHz CPU
-  - Estimated decompressing speed:
-      - 20-30 MB/s on 2 GHz Core 2 or AMD Athlon 64
-      - 1-2 MB/s on 200 MHz ARM, MIPS, PowerPC or other simple RISC
-  - Small memory requirements for decompressing (16 KB + DictionarySize)
-  - Small code size for decompressing: 5-8 KB
-
-LZMA decoder uses only integer operations and can be
-implemented in any modern 32-bit CPU (or on 16-bit CPU with some conditions).
-
-Some critical operations that affect the speed of LZMA decompression:
-  1) 32*16 bit integer multiply
-  2) Misspredicted branches (penalty mostly depends from pipeline length)
-  3) 32-bit shift and arithmetic operations
-
-The speed of LZMA decompressing mostly depends from CPU speed.
-Memory speed has no big meaning. But if your CPU has small data cache,
-overall weight of memory speed will slightly increase.
-
-
-How To Use
-----------
-
-Using LZMA encoder/decoder executable
---------------------------------------
-
-Usage:  LZMA <e|d> inputFile outputFile [<switches>...]
-
-  e: encode file
-
-  d: decode file
-
-  b: Benchmark. There are two tests: compressing and decompressing
-     with LZMA method. Benchmark shows rating in MIPS (million
-     instructions per second). Rating value is calculated from
-     measured speed and it is normalized with Intel's Core 2 results.
-     Also Benchmark checks possible hardware errors (RAM
-     errors in most cases). Benchmark uses these settings:
-     (-a1, -d21, -fb32, -mfbt4). You can change only -d parameter.
-     Also you can change the number of iterations. Example for 30 iterations:
-       LZMA b 30
-     Default number of iterations is 10.
-
-<Switches>
-
-
-  -a{N}:  set compression mode 0 = fast, 1 = normal
-          default: 1 (normal)
-
-  d{N}:   Sets Dictionary size - [0, 30], default: 23 (8MB)
-          The maximum value for dictionary size is 1 GB = 2^30 bytes.
-          Dictionary size is calculated as DictionarySize = 2^N bytes.
-          For decompressing file compressed by LZMA method with dictionary
-          size D = 2^N you need about D bytes of memory (RAM).
-
-  -fb{N}: set number of fast bytes - [5, 273], default: 128
-          Usually big number gives a little bit better compression ratio
-          and slower compression process.
-
-  -lc{N}: set number of literal context bits - [0, 8], default: 3
-          Sometimes lc=4 gives gain for big files.
-
-  -lp{N}: set number of literal pos bits - [0, 4], default: 0
-          lp switch is intended for periodical data when period is
-          equal 2^N. For example, for 32-bit (4 bytes)
-          periodical data you can use lp=2. Often it's better to set lc0,
-          if you change lp switch.
-
-  -pb{N}: set number of pos bits - [0, 4], default: 2
-          pb switch is intended for periodical data
-          when period is equal 2^N.
-
-  -mf{MF_ID}: set Match Finder. Default: bt4.
-              Algorithms from hc* group doesn't provide good compression
-              ratio, but they often works pretty fast in combination with
-              fast mode (-a0).
-
-              Memory requirements depend from dictionary size
-              (parameter "d" in table below).
-
-               MF_ID     Memory                   Description
-
-                bt2    d *  9.5 + 4MB  Binary Tree with 2 bytes hashing.
-                bt3    d * 11.5 + 4MB  Binary Tree with 3 bytes hashing.
-                bt4    d * 11.5 + 4MB  Binary Tree with 4 bytes hashing.
-                hc4    d *  7.5 + 4MB  Hash Chain with 4 bytes hashing.
-
-  -eos:   write End Of Stream marker. By default LZMA doesn't write
-          eos marker, since LZMA decoder knows uncompressed size
-          stored in .lzma file header.
-
-  -si:    Read data from stdin (it will write End Of Stream marker).
-  -so:    Write data to stdout
-
-
-Examples:
-
-1) LZMA e file.bin file.lzma -d16 -lc0
-
-compresses file.bin to file.lzma with 64 KB dictionary (2^16=64K)
-and 0 literal context bits. -lc0 allows to reduce memory requirements
-for decompression.
-
-
-2) LZMA e file.bin file.lzma -lc0 -lp2
-
-compresses file.bin to file.lzma with settings suitable
-for 32-bit periodical data (for example, ARM or MIPS code).
-
-3) LZMA d file.lzma file.bin
-
-decompresses file.lzma to file.bin.
-
-
-Compression ratio hints
------------------------
-
-Recommendations
----------------
-
-To increase the compression ratio for LZMA compressing it's desirable
-to have aligned data (if it's possible) and also it's desirable to locate
-data in such order, where code is grouped in one place and data is
-grouped in other place (it's better than such mixing: code, data, code,
-data, ...).
-
-
-Filters
--------
-You can increase the compression ratio for some data types, using
-special filters before compressing. For example, it's possible to
-increase the compression ratio on 5-10% for code for those CPU ISAs:
-x86, IA-64, ARM, ARM-Thumb, PowerPC, SPARC.
-
-You can find C source code of such filters in C/Bra*.* files
-
-You can check the compression ratio gain of these filters with such
-7-Zip commands (example for ARM code):
-No filter:
-  7z a a1.7z a.bin -m0=lzma
-
-With filter for little-endian ARM code:
-  7z a a2.7z a.bin -m0=arm -m1=lzma
-
-It works in such manner:
-Compressing    = Filter_encoding + LZMA_encoding
-Decompressing  = LZMA_decoding + Filter_decoding
-
-Compressing and decompressing speed of such filters is very high,
-so it will not increase decompressing time too much.
-Moreover, it reduces decompression time for LZMA_decoding,
-since compression ratio with filtering is higher.
-
-These filters convert CALL (calling procedure) instructions
-from relative offsets to absolute addresses, so such data becomes more
-compressible.
-
-For some ISAs (for example, for MIPS) it's impossible to get gain from such filter.
-
-
-LZMA compressed file format
----------------------------
-Offset Size Description
-  0     1   Special LZMA properties (lc,lp, pb in encoded form)
-  1     4   Dictionary size (little endian)
-  5     8   Uncompressed size (little endian). -1 means unknown size
- 13         Compressed data
-
-
-ANSI-C LZMA Decoder
-~~~~~~~~~~~~~~~~~~~
-
-Please note that interfaces for ANSI-C code were changed in LZMA SDK 4.58.
-If you want to use old interfaces you can download previous version of LZMA SDK
-from sourceforge.net site.
-
-To use ANSI-C LZMA Decoder you need the following files:
-1) LzmaDec.h + LzmaDec.c + Types.h
-LzmaUtil/LzmaUtil.c is example application that uses these files.
-
-
-Memory requirements for LZMA decoding
--------------------------------------
-
-Stack usage of LZMA decoding function for local variables is not
-larger than 200-400 bytes.
-
-LZMA Decoder uses dictionary buffer and internal state structure.
-Internal state structure consumes
-  state_size = (4 + (1.5 << (lc + lp))) KB
-by default (lc=3, lp=0), state_size = 16 KB.
-
-
-How To decompress data
-----------------------
-
-LZMA Decoder (ANSI-C version) now supports 2 interfaces:
-1) Single-call Decompressing
-2) Multi-call State Decompressing (zlib-like interface)
-
-You must use external allocator:
-Example:
-void *SzAlloc(void *p, size_t size) { p = p; return malloc(size); }
-void SzFree(void *p, void *address) { p = p; free(address); }
-ISzAlloc alloc = { SzAlloc, SzFree };
-
-You can use p = p; operator to disable compiler warnings.
-
-
-Single-call Decompressing
--------------------------
-When to use: RAM->RAM decompressing
-Compile files: LzmaDec.h + LzmaDec.c + Types.h
-Compile defines: no defines
-Memory Requirements:
-  - Input buffer: compressed size
-  - Output buffer: uncompressed size
-  - LZMA Internal Structures: state_size (16 KB for default settings)
-
-Interface:
-  int LzmaDecode(Byte *dest, SizeT *destLen, const Byte *src, SizeT *srcLen,
-      const Byte *propData, unsigned propSize, ELzmaFinishMode finishMode,
-      ELzmaStatus *status, ISzAlloc *alloc);
-  In:
-    dest     - output data
-    destLen  - output data size
-    src      - input data
-    srcLen   - input data size
-    propData - LZMA properties  (5 bytes)
-    propSize - size of propData buffer (5 bytes)
-    finishMode - It has meaning only if the decoding reaches output limit (*destLen).
-         LZMA_FINISH_ANY - Decode just destLen bytes.
-         LZMA_FINISH_END - Stream must be finished after (*destLen).
-                           You can use LZMA_FINISH_END, when you know that
-                           current output buffer covers last bytes of stream.
-    alloc    - Memory allocator.
-
-  Out:
-    destLen  - processed output size
-    srcLen   - processed input size
-
-  Output:
-    SZ_OK
-      status:
-        LZMA_STATUS_FINISHED_WITH_MARK
-        LZMA_STATUS_NOT_FINISHED
-        LZMA_STATUS_MAYBE_FINISHED_WITHOUT_MARK
-    SZ_ERROR_DATA - Data error
-    SZ_ERROR_MEM  - Memory allocation error
-    SZ_ERROR_UNSUPPORTED - Unsupported properties
-    SZ_ERROR_INPUT_EOF - It needs more bytes in input buffer (src).
-
-  If LZMA decoder sees end_marker before reaching output limit, it returns OK result,
-  and output value of destLen will be less than output buffer size limit.
-
-  You can use multiple checks to test data integrity after full decompression:
-    1) Check Result and "status" variable.
-    2) Check that output(destLen) = uncompressedSize, if you know real uncompressedSize.
-    3) Check that output(srcLen) = compressedSize, if you know real compressedSize.
-       You must use correct finish mode in that case. */
-
-
-Multi-call State Decompressing (zlib-like interface)
-----------------------------------------------------
-
-When to use: file->file decompressing
-Compile files: LzmaDec.h + LzmaDec.c + Types.h
-
-Memory Requirements:
- - Buffer for input stream: any size (for example, 16 KB)
- - Buffer for output stream: any size (for example, 16 KB)
- - LZMA Internal Structures: state_size (16 KB for default settings)
- - LZMA dictionary (dictionary size is encoded in LZMA properties header)
-
-1) read LZMA properties (5 bytes) and uncompressed size (8 bytes, little-endian) to header:
-   unsigned char header[LZMA_PROPS_SIZE + 8];
-   ReadFile(inFile, header, sizeof(header)
-
-2) Allocate CLzmaDec structures (state + dictionary) using LZMA properties
-
-  CLzmaDec state;
-  LzmaDec_Constr(&state);
-  res = LzmaDec_Allocate(&state, header, LZMA_PROPS_SIZE, &g_Alloc);
-  if (res != SZ_OK)
-    return res;
-
-3) Init LzmaDec structure before any new LZMA stream. And call LzmaDec_DecodeToBuf in loop
-
-  LzmaDec_Init(&state);
-  for (;;)
-  {
-    ...
-    int res = LzmaDec_DecodeToBuf(CLzmaDec *p, Byte *dest, SizeT *destLen,
-        const Byte *src, SizeT *srcLen, ELzmaFinishMode finishMode);
-    ...
-  }
-
-
-4) Free all allocated structures
-  LzmaDec_Free(&state, &g_Alloc);
-
-For full code example, look at C/LzmaUtil/LzmaUtil.c code.
-
-
-How To compress data
---------------------
-
-Compile files: LzmaEnc.h + LzmaEnc.c + Types.h +
-LzFind.c + LzFind.h + LzFindMt.c + LzFindMt.h + LzHash.h
-
-Memory Requirements:
-  - (dictSize * 11.5 + 6 MB) + state_size
-
-Lzma Encoder can use two memory allocators:
-1) alloc - for small arrays.
-2) allocBig - for big arrays.
-
-For example, you can use Large RAM Pages (2 MB) in allocBig allocator for
-better compression speed. Note that Windows has bad implementation for
-Large RAM Pages.
-It's OK to use same allocator for alloc and allocBig.
-
-
-Single-call Compression with callbacks
---------------------------------------
-
-Check C/LzmaUtil/LzmaUtil.c as example,
-
-When to use: file->file decompressing
-
-1) you must implement callback structures for interfaces:
-ISeqInStream
-ISeqOutStream
-ICompressProgress
-ISzAlloc
-
-static void *SzAlloc(void *p, size_t size) { p = p; return MyAlloc(size); }
-static void SzFree(void *p, void *address) {  p = p; MyFree(address); }
-static ISzAlloc g_Alloc = { SzAlloc, SzFree };
-
-  CFileSeqInStream inStream;
-  CFileSeqOutStream outStream;
-
-  inStream.funcTable.Read = MyRead;
-  inStream.file = inFile;
-  outStream.funcTable.Write = MyWrite;
-  outStream.file = outFile;
-
-
-2) Create CLzmaEncHandle object;
-
-  CLzmaEncHandle enc;
-
-  enc = LzmaEnc_Create(&g_Alloc);
-  if (enc == 0)
-    return SZ_ERROR_MEM;
-
-
-3) initialize CLzmaEncProps properties;
-
-  LzmaEncProps_Init(&props);
-
-  Then you can change some properties in that structure.
-
-4) Send LZMA properties to LZMA Encoder
-
-  res = LzmaEnc_SetProps(enc, &props);
-
-5) Write encoded properties to header
-
-    Byte header[LZMA_PROPS_SIZE + 8];
-    size_t headerSize = LZMA_PROPS_SIZE;
-    UInt64 fileSize;
-    int i;
-
-    res = LzmaEnc_WriteProperties(enc, header, &headerSize);
-    fileSize = MyGetFileLength(inFile);
-    for (i = 0; i < 8; i++)
-      header[headerSize++] = (Byte)(fileSize >> (8 * i));
-    MyWriteFileAndCheck(outFile, header, headerSize)
-
-6) Call encoding function:
-      res = LzmaEnc_Encode(enc, &outStream.funcTable, &inStream.funcTable,
-        NULL, &g_Alloc, &g_Alloc);
-
-7) Destroy LZMA Encoder Object
-  LzmaEnc_Destroy(enc, &g_Alloc, &g_Alloc);
-
-
-If callback function return some error code, LzmaEnc_Encode also returns that code
-or it can return the code like SZ_ERROR_READ, SZ_ERROR_WRITE or SZ_ERROR_PROGRESS.
-
-
-Single-call RAM->RAM Compression
---------------------------------
-
-Single-call RAM->RAM Compression is similar to Compression with callbacks,
-but you provide pointers to buffers instead of pointers to stream callbacks:
-
-HRes LzmaEncode(Byte *dest, SizeT *destLen, const Byte *src, SizeT srcLen,
-    CLzmaEncProps *props, Byte *propsEncoded, SizeT *propsSize, int writeEndMark,
-    ICompressProgress *progress, ISzAlloc *alloc, ISzAlloc *allocBig);
-
-Return code:
-  SZ_OK               - OK
-  SZ_ERROR_MEM        - Memory allocation error
-  SZ_ERROR_PARAM      - Incorrect paramater
-  SZ_ERROR_OUTPUT_EOF - output buffer overflow
-  SZ_ERROR_THREAD     - errors in multithreading functions (only for Mt version)
-
-
-
-Defines
--------
-
-_LZMA_SIZE_OPT - Enable some optimizations in LZMA Decoder to get smaller executable code.
-
-_LZMA_PROB32   - It can increase the speed on some 32-bit CPUs, but memory usage for
-                 some structures will be doubled in that case.
-
-_LZMA_UINT32_IS_ULONG  - Define it if int is 16-bit on your compiler and long is 32-bit.
-
-_LZMA_NO_SYSTEM_SIZE_T  - Define it if you don't want to use size_t type.
-
-
-_7ZIP_PPMD_SUPPPORT - Define it if you don't want to support PPMD method in AMSI-C .7z decoder.
-
-
-C++ LZMA Encoder/Decoder
-~~~~~~~~~~~~~~~~~~~~~~~~
-C++ LZMA code use COM-like interfaces. So if you want to use it,
-you can study basics of COM/OLE.
-C++ LZMA code is just wrapper over ANSI-C code.
-
-
-C++ Notes
-~~~~~~~~~~~~~~~~~~~~~~~~
-If you use some C++ code folders in 7-Zip (for example, C++ code for .7z handling),
-you must check that you correctly work with "new" operator.
-7-Zip can be compiled with MSVC 6.0 that doesn't throw "exception" from "new" operator.
-So 7-Zip uses "CPP\Common\NewHandler.cpp" that redefines "new" operator:
-operator new(size_t size)
-{
-  void *p = ::malloc(size);
-  if (p == 0)
-    throw CNewException();
-  return p;
-}
-If you use MSCV that throws exception for "new" operator, you can compile without
-"NewHandler.cpp". So standard exception will be used. Actually some code of
-7-Zip catches any exception in internal code and converts it to HRESULT code.
-So you don't need to catch CNewException, if you call COM interfaces of 7-Zip.
-
----
-
-http://www.7-zip.org
-http://www.7-zip.org/sdk.html
-http://www.7-zip.org/support.html
-- 
2.43.0

