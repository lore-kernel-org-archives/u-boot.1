Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3E3D711CD
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 23:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E94E838A0;
	Fri, 19 Dec 2025 00:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kG47Umpk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 295CC836AC; Fri, 19 Dec 2025 00:23:06 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BAA1833C6
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 00:23:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-450c6f5ff81so671218b6e.0
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 15:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766100181; x=1766704981; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gKd+ikeUjQhwL5iZ7pYhe45vyUbxzmXtsZNPB5COuKo=;
 b=kG47UmpkPQkYBuQXOdUQihCQUqHv5MqyW5lWAZjyaaqYNFiD7i/5tFOZiMKnEm58mB
 iKAIquN4bW/njbyyEmZHIqwVBjcM34efeKoYkui0YDZ60V6juI00XI24bIMwNHp0BrXh
 cxwVJTE7nf3JvTKgRnZ3z8nIC7doY1pEuwxY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766100181; x=1766704981;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gKd+ikeUjQhwL5iZ7pYhe45vyUbxzmXtsZNPB5COuKo=;
 b=eN0mxwaQIxk8tHmUqz/4yaklLIfOMWRXbuzDIDnQoPh2zySUukksDtVJ1DReMjpl22
 J62UF55TbL7D8w1Tx8F/y0U4xCCE0qAHwzG1zdchmXUJ1r62uAKq2f3oA50EbfylOU/2
 LV+lA2WPGjOnVbMtR10EJKJEZAZBB48F6yKHvId3nFIGgBOBWm9R1QJMIvekHIGbLBWZ
 migZMBLctYCaBrJ7r7B9VQ2sN8Mf5FaYLZgFTy2O5Crjr32edAE9SI6FE1pLYH6OOGZj
 tvk6/H9prX170+LzQ0tghO6L+TSyZveIUOzGbySagoITEScq5YwU2RWSCq9Oebnd82Y6
 bdtw==
X-Gm-Message-State: AOJu0Yy7kGKdaWV9s32eEYivQ5wkNRPWKmnfGq1rrMVI06Bg2Dn0kww8
 M1KlX2TGblFhYvXJiFF+llgzZ1abDzdlk/JOL4XS9o6KOmYA/VVE19OIj8Gj4slCUxxgil/xQI/
 ynIjgrLE=
X-Gm-Gg: AY/fxX5ab6A3iyH8/M+CgJS8GreFUYcg9JpHONRgTpvPklHThtlg/fBIL1hekOu7cxi
 YSUuwIHq2TKiWh9TuNP+kK/UkGfxFA4k2QEBQ1vaAFcvMaCcHK/CUlAeLPMPwgWCLJWTQ3zkYCE
 0Km8rDKiH0lCXScuImoOiSFdnulHRgbKxJesExiuk7bfFKWJaYY/7V6tf1OgFGrDXJn8+TxqYR0
 IYKOdAFlPaOHKDLaEvha5H2nSfgihlbZI6MydmyQ+IEs+XYUHPYC67kNjMjFaFw8xRAyh+qxdL6
 SoHa8zCcfACzZ53Ob4a/Yx4+cpOQm2J36kGUmPiKpiQaFx8BaIOsojMGmjZV5G5PytdO89kw+Wg
 Q8qxezG7SMgMB3KHo0SWMc3Vm2fDc5ONszxa3Z7m4yu7XS5zGi7HsrQ63VUcPpyHY8vOJ1hZeXz
 Uv9p3rmWV9qdpe3bc3oOkW3244VoQBxarQBq7lUZVAwjfRsZktOf0M
X-Google-Smtp-Source: AGHT+IFImAur6yhU94BJbV6+7BqSfaCAqkHMlpRnPIp2cNFlphyz+iW6dRvlfvo5eQOm8/HZlDpxmw==
X-Received: by 2002:a05:6808:4fc6:b0:455:7c6a:5f74 with SMTP id
 5614622812f47-457b214c17amr685442b6e.12.1766100180680; 
 Thu, 18 Dec 2025 15:23:00 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-457b3cc0928sm295333b6e.10.2025.12.18.15.23.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 15:23:00 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Darek <x64x6a@gmail.com>
Subject: [RFC PATCH 2/9] lzma: Remove extra files and explain where our
 library comes from
Date: Thu, 18 Dec 2025 17:10:14 -0600
Message-ID: <20251218232255.3934258-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218232255.3934258-1-trini@konsulko.com>
References: <20251218232255.3934258-1-trini@konsulko.com>
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

The original import of the LZMA SDK included a script to update the
library. This is no longer possible, due to important local changes, so
remove it. We also remove a number of extra text files that should be
unchanged from upstream, but provide no direct value to the project.
Instead, have the help text for LZMA note that this comes from the LZMA
SDK.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 lib/Kconfig                |   5 +-
 lib/lzma/README.txt        |  28 --
 lib/lzma/history.txt       | 271 -----------------
 lib/lzma/import_lzmasdk.sh |  36 ---
 lib/lzma/lzma.txt          | 598 -------------------------------------
 5 files changed, 3 insertions(+), 935 deletions(-)
 delete mode 100644 lib/lzma/README.txt
 delete mode 100644 lib/lzma/history.txt
 delete mode 100644 lib/lzma/import_lzmasdk.sh
 delete mode 100644 lib/lzma/lzma.txt

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

