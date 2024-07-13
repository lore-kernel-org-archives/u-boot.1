Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607E6C3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 13:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB68C888C8;
	Sat, 13 Jul 2024 15:21:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="JmTctJ0W";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OZi0t8zk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67638888C8; Sat, 13 Jul 2024 15:21:44 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 631B4888CC
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 15:21:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4WLpyX13FMz9sZF;
 Sat, 13 Jul 2024 15:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dLAcrNDFOXbv+JQpNxuj6YMeZyAVOcIXeOapavA3G4=;
 b=JmTctJ0WJnSqKt2Ne23BvVRDUkFUXu5h8JwIlUiqbbs5/4O+vy8iDnExLFrEr7vt8AnOsU
 jQTZzMj1cTsbggSffii4D2OzL/R6h42kONEJoG6iXr2b1LAivCNhhPJGC1vACsdjIQ2gCr
 AmrOPkqDnd6vNGTwmUIcxIpHJaveJzJwzyhZxJhFdw3exvpwM65pA2cf2z23HeS5kqhSmz
 8bVFu1MRwCj5qISTv+yqFmlEJtbXDAWcY15hdb+jtw4GXc/jAg9FlwLXFnxb44YklGLZOu
 tAUrUk2mxqOZbVGEnYODwCUAD+hLjg1PZf/EGYDYr1GSOzOBaZgafU/itvltyQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1720876898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dLAcrNDFOXbv+JQpNxuj6YMeZyAVOcIXeOapavA3G4=;
 b=OZi0t8zkEEXCITkh65+M6s1WyuBYmQctLR3mDMhZJCcKfZQfOnUFcTSVQSTQdjYgZZpk8S
 r63He/CEIPvM8DRnXfeIF+LiVYqCn7W2v9lWBi6eUbui/QRREIWDedlYbMUXvVnb+mqtHd
 EQJa1qTITjtPNqxUgBuX7oggFrV8e2N0d7qCUXIUYZJwVVi/itX6m54nr1P98LoPfNY8Td
 VkYDE3xgPWGkeyXBgPIiXSVnPxeovcz/sUCy1uqkr25sbOnWRW+2AgiOm2i4KlmowHl78J
 5m/KEAdwGgdvD6S5DI8uMH2nwhwad29Ui7u3hbYyz5DaKAae4RkCrwYqvs6wcg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 31/45] lib: Remove duplicate newlines
Date: Sat, 13 Jul 2024 15:19:22 +0200
Message-ID: <20240713132021.57650-31-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
References: <20240713132021.57650-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fb2582d89a037cd0179
X-MBO-RS-META: mpppguxagcphbujssc48xm9y13p9667w
X-Rspamd-Queue-Id: 4WLpyX13FMz9sZF
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

Drop all duplicate newlines. No functional change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 lib/blake2/blake2b.c                          |  4 --
 lib/bzip2/bzlib.c                             | 41 -------------------
 lib/bzip2/bzlib_blocksort.c                   | 12 ------
 lib/bzip2/bzlib_compress.c                    | 15 -------
 lib/bzip2/bzlib_crctable.c                    |  2 -
 lib/bzip2/bzlib_decompress.c                  |  6 ---
 lib/bzip2/bzlib_huffman.c                     |  5 ---
 lib/bzip2/bzlib_private.h                     | 17 --------
 lib/bzip2/bzlib_randtable.c                   |  3 --
 lib/circbuf.c                                 |  1 -
 lib/crc7.c                                    |  1 -
 lib/crypt/crypt-sha256.c                      |  1 -
 lib/crypt/crypt-sha512.c                      |  1 -
 lib/dhry/dhry.h                               |  2 -
 lib/dhry/dhry_1.c                             |  6 ---
 lib/dhry/dhry_2.c                             |  5 ---
 lib/efi_loader/efi_capsule.c                  |  1 -
 lib/efi_loader/efi_console.c                  |  1 -
 lib/efi_loader/efi_image_loader.c             |  2 -
 lib/efi_loader/efi_variable.c                 |  1 -
 lib/efi_selftest/efi_selftest_controllers.c   |  1 -
 lib/efi_selftest/efi_selftest_ecpt.c          |  1 -
 lib/efi_selftest/efi_selftest_load_file.c     |  1 -
 lib/fdtdec.c                                  |  1 -
 lib/fwu_updates/fwu.c                         |  1 -
 lib/hashtable.c                               |  4 --
 lib/libavb/avb_sha.h                          |  1 -
 lib/lz4.c                                     |  1 -
 lib/lzma/LzmaDec.c                            |  3 --
 lib/lzma/LzmaDec.h                            |  6 ---
 lib/lzma/Types.h                              |  2 -
 lib/lzo/lzo1x_decompress.c                    |  1 -
 lib/md5.c                                     |  1 -
 lib/string.c                                  |  1 -
 lib/zlib/deflate.c                            |  2 -
 lib/zlib/deflate.h                            |  2 -
 lib/zlib/trees.c                              |  2 -
 lib/zlib/zutil.h                              |  1 -
 lib/zstd/common/bitstream.h                   |  9 ----
 lib/zstd/common/compiler.h                    |  4 --
 lib/zstd/common/cpu.h                         |  1 -
 lib/zstd/common/debug.c                       |  1 -
 lib/zstd/common/debug.h                       |  7 ----
 lib/zstd/common/entropy_common.c              |  4 --
 lib/zstd/common/error_private.h               |  7 ----
 lib/zstd/common/fse.h                         | 24 -----------
 lib/zstd/common/fse_decompress.c              | 12 ------
 lib/zstd/common/huf.h                         | 10 -----
 lib/zstd/common/portability_macros.h          |  1 -
 lib/zstd/common/zstd_common.c                 |  6 ---
 lib/zstd/common/zstd_internal.h               |  9 ----
 lib/zstd/decompress/huf_decompress.c          | 17 --------
 lib/zstd/decompress/zstd_ddict.c              |  7 ----
 lib/zstd/decompress/zstd_ddict.h              |  4 --
 lib/zstd/decompress/zstd_decompress.c         | 26 ------------
 lib/zstd/decompress/zstd_decompress_block.c   | 18 --------
 lib/zstd/decompress/zstd_decompress_block.h   |  4 --
 .../decompress/zstd_decompress_internal.h     |  6 ---
 58 files changed, 336 deletions(-)

diff --git a/lib/blake2/blake2b.c b/lib/blake2/blake2b.c
index 686138ef24b..9cd6232aa54 100644
--- a/lib/blake2/blake2b.c
+++ b/lib/blake2/blake2b.c
@@ -51,7 +51,6 @@ static const uint8_t blake2b_sigma[12][16] =
   { 14, 10,  4,  8,  9, 15, 13,  6,  1, 12,  0,  2, 11,  7,  5,  3 }
 };
 
-
 static void blake2b_set_lastnode( blake2b_state *S )
 {
   S->f[1] = (uint64_t)-1;
@@ -100,8 +99,6 @@ int blake2b_init_param( blake2b_state *S, const blake2b_param *P )
   return 0;
 }
 
-
-
 int blake2b_init( blake2b_state *S, size_t outlen )
 {
   blake2b_param P[1];
@@ -123,7 +120,6 @@ int blake2b_init( blake2b_state *S, size_t outlen )
   return blake2b_init_param( S, P );
 }
 
-
 int blake2b_init_key( blake2b_state *S, size_t outlen, const void *key, size_t keylen )
 {
   blake2b_param P[1];
diff --git a/lib/bzip2/bzlib.c b/lib/bzip2/bzlib.c
index f7318b7886e..39a480e25f9 100644
--- a/lib/bzip2/bzlib.c
+++ b/lib/bzip2/bzlib.c
@@ -87,7 +87,6 @@
 /*--- Compression stuff                           ---*/
 /*---------------------------------------------------*/
 
-
 /*---------------------------------------------------*/
 #ifndef BZ_NO_STDIO
 void BZ2_bz__AssertH__fail ( int errcode )
@@ -137,7 +136,6 @@ void BZ2_bz__AssertH__fail ( int errcode )
 }
 #endif
 
-
 /*---------------------------------------------------*/
 static
 int bz_config_ok ( void )
@@ -148,7 +146,6 @@ int bz_config_ok ( void )
    return 1;
 }
 
-
 /*---------------------------------------------------*/
 static
 void* default_bzalloc ( void* opaque, Int32 items, Int32 size )
@@ -177,7 +174,6 @@ void prepare_new_block ( EState* s )
    s->blockNo++;
 }
 
-
 /*---------------------------------------------------*/
 static
 void init_RL ( EState* s )
@@ -186,7 +182,6 @@ void init_RL ( EState* s )
    s->state_in_len = 0;
 }
 
-
 static
 Bool isempty_RL ( EState* s )
 {
@@ -261,7 +256,6 @@ int BZ_API(BZ2_bzCompressInit)
    return BZ_OK;
 }
 
-
 /*---------------------------------------------------*/
 static
 void add_pair_to_block ( EState* s )
@@ -297,7 +291,6 @@ void add_pair_to_block ( EState* s )
    }
 }
 
-
 /*---------------------------------------------------*/
 static
 void flush_RL ( EState* s )
@@ -306,7 +299,6 @@ void flush_RL ( EState* s )
    init_RL ( s );
 }
 
-
 /*---------------------------------------------------*/
 #define ADD_CHAR_TO_BLOCK(zs,zchh0)               \
 {                                                 \
@@ -334,7 +326,6 @@ void flush_RL ( EState* s )
    }                                              \
 }
 
-
 /*---------------------------------------------------*/
 static
 Bool copy_input_until_stop ( EState* s )
@@ -379,7 +370,6 @@ Bool copy_input_until_stop ( EState* s )
    return progress_in;
 }
 
-
 /*---------------------------------------------------*/
 static
 Bool copy_output_until_stop ( EState* s )
@@ -406,7 +396,6 @@ Bool copy_output_until_stop ( EState* s )
    return progress_out;
 }
 
-
 /*---------------------------------------------------*/
 static
 Bool handle_compress ( bz_stream* strm )
@@ -453,7 +442,6 @@ Bool handle_compress ( bz_stream* strm )
    return progress_in || progress_out;
 }
 
-
 /*---------------------------------------------------*/
 int BZ_API(BZ2_bzCompress) ( bz_stream *strm, int action )
 {
@@ -514,7 +502,6 @@ int BZ_API(BZ2_bzCompress) ( bz_stream *strm, int action )
    return BZ_OK; /*--not reached--*/
 }
 
-
 /*---------------------------------------------------*/
 int BZ_API(BZ2_bzCompressEnd)  ( bz_stream *strm )
 {
@@ -578,7 +565,6 @@ int BZ_API(BZ2_bzDecompressInit)
    return BZ_OK;
 }
 
-
 /*---------------------------------------------------*/
 static
 void unRLE_obuf_to_output_FAST ( DState* s )
@@ -604,7 +590,6 @@ void unRLE_obuf_to_output_FAST ( DState* s )
 	 /* can a new run be started? */
 	 if (s->nblock_used == s->save_nblock+1) return;
 
-
 	 s->state_out_len = 1;
 	 s->state_out_ch = s->k0;
 	 BZ_GET_FAST(k1); BZ_RAND_UPD_MASK;
@@ -720,7 +705,6 @@ void unRLE_obuf_to_output_FAST ( DState* s )
    }
 }
 
-
 /*---------------------------------------------------*/
 __inline__ Int32 BZ2_indexIntoF ( Int32 indx, Int32 *cftab )
 {
@@ -735,7 +719,6 @@ __inline__ Int32 BZ2_indexIntoF ( Int32 indx, Int32 *cftab )
    return nb;
 }
 
-
 /*---------------------------------------------------*/
 static
 void unRLE_obuf_to_output_SMALL ( DState* s )
@@ -761,7 +744,6 @@ void unRLE_obuf_to_output_SMALL ( DState* s )
 	 /* can a new run be started? */
 	 if (s->nblock_used == s->save_nblock+1) return;
 
-
 	 s->state_out_len = 1;
 	 s->state_out_ch = s->k0;
 	 BZ_GET_SMALL(k1); BZ_RAND_UPD_MASK;
@@ -831,7 +813,6 @@ void unRLE_obuf_to_output_SMALL ( DState* s )
    }
 }
 
-
 /*---------------------------------------------------*/
 int BZ_API(BZ2_bzDecompress) ( bz_stream *strm )
 {
@@ -886,7 +867,6 @@ int BZ_API(BZ2_bzDecompress) ( bz_stream *strm )
    return 0;  /*NOTREACHED*/
 }
 
-
 /*---------------------------------------------------*/
 int BZ_API(BZ2_bzDecompressEnd)  ( bz_stream *strm )
 {
@@ -906,7 +886,6 @@ int BZ_API(BZ2_bzDecompressEnd)  ( bz_stream *strm )
    return BZ_OK;
 }
 
-
 #ifndef BZ_NO_STDIO
 /*---------------------------------------------------*/
 /*--- File I/O stuff                              ---*/
@@ -930,7 +909,6 @@ typedef
    }
    bzFile;
 
-
 /*---------------------------------------------*/
 static Bool myfeof ( FILE* f )
 {
@@ -940,7 +918,6 @@ static Bool myfeof ( FILE* f )
    return False;
 }
 
-
 /*---------------------------------------------------*/
 BZFILE* BZ_API(BZ2_bzWriteOpen)
 		    ( int*  bzerror,
@@ -987,7 +964,6 @@ BZFILE* BZ_API(BZ2_bzWriteOpen)
    return bzf;
 }
 
-
 /*---------------------------------------------------*/
 void BZ_API(BZ2_bzWrite)
 	     ( int*    bzerror,
@@ -1032,7 +1008,6 @@ void BZ_API(BZ2_bzWrite)
    }
 }
 
-
 /*---------------------------------------------------*/
 void BZ_API(BZ2_bzWriteClose)
 		  ( int*          bzerror,
@@ -1045,7 +1020,6 @@ void BZ_API(BZ2_bzWriteClose)
 			nbytes_in, NULL, nbytes_out, NULL );
 }
 
-
 void BZ_API(BZ2_bzWriteClose64)
 		  ( int*          bzerror,
 		    BZFILE*       b,
@@ -1110,7 +1084,6 @@ void BZ_API(BZ2_bzWriteClose64)
    free ( bzf );
 }
 
-
 /*---------------------------------------------------*/
 BZFILE* BZ_API(BZ2_bzReadOpen)
 		   ( int*  bzerror,
@@ -1166,7 +1139,6 @@ BZFILE* BZ_API(BZ2_bzReadOpen)
    return bzf;
 }
 
-
 /*---------------------------------------------------*/
 void BZ_API(BZ2_bzReadClose) ( int *bzerror, BZFILE *b )
 {
@@ -1184,7 +1156,6 @@ void BZ_API(BZ2_bzReadClose) ( int *bzerror, BZFILE *b )
    free ( bzf );
 }
 
-
 /*---------------------------------------------------*/
 int BZ_API(BZ2_bzRead)
 	   ( int*    bzerror,
@@ -1244,7 +1215,6 @@ int BZ_API(BZ2_bzRead)
    return 0; /*not reached*/
 }
 
-
 /*---------------------------------------------------*/
 void BZ_API(BZ2_bzReadGetUnused)
 		     ( int*    bzerror,
@@ -1266,7 +1236,6 @@ void BZ_API(BZ2_bzReadGetUnused)
 }
 #endif
 
-
 /*---------------------------------------------------*/
 /*--- Misc convenience stuff                      ---*/
 /*---------------------------------------------------*/
@@ -1372,7 +1341,6 @@ int BZ_API(BZ2_bzBuffToBuffDecompress)
    return ret;
 }
 
-
 /*---------------------------------------------------*/
 /*--
    Code contributed by Yoshioka Tsuneo
@@ -1394,7 +1362,6 @@ const char * BZ_API(BZ2_bzlibVersion)(void)
    return BZ_VERSION;
 }
 
-
 #ifndef BZ_NO_STDIO
 /*---------------------------------------------------*/
 
@@ -1476,7 +1443,6 @@ BZFILE * bzopen_or_bzdopen
    return bzfp;
 }
 
-
 /*---------------------------------------------------*/
 /*--
    open file for read or write.
@@ -1490,7 +1456,6 @@ BZFILE * BZ_API(BZ2_bzopen)
    return bzopen_or_bzdopen(path,-1,mode,/*bzopen*/0);
 }
 
-
 /*---------------------------------------------------*/
 BZFILE * BZ_API(BZ2_bzdopen)
 	       ( int fd,
@@ -1499,7 +1464,6 @@ BZFILE * BZ_API(BZ2_bzdopen)
    return bzopen_or_bzdopen(NULL,fd,mode,/*bzdopen*/1);
 }
 
-
 /*---------------------------------------------------*/
 int BZ_API(BZ2_bzread) (BZFILE* b, void* buf, int len )
 {
@@ -1513,7 +1477,6 @@ int BZ_API(BZ2_bzread) (BZFILE* b, void* buf, int len )
    }
 }
 
-
 /*---------------------------------------------------*/
 int BZ_API(BZ2_bzwrite) (BZFILE* b, void* buf, int len )
 {
@@ -1527,7 +1490,6 @@ int BZ_API(BZ2_bzwrite) (BZFILE* b, void* buf, int len )
    }
 }
 
-
 /*---------------------------------------------------*/
 int BZ_API(BZ2_bzflush) (BZFILE *b)
 {
@@ -1535,7 +1497,6 @@ int BZ_API(BZ2_bzflush) (BZFILE *b)
    return 0;
 }
 
-
 /*---------------------------------------------------*/
 void BZ_API(BZ2_bzclose) (BZFILE* b)
 {
@@ -1556,7 +1517,6 @@ void BZ_API(BZ2_bzclose) (BZFILE* b)
    }
 }
 
-
 /*---------------------------------------------------*/
 /*--
    return last error code
@@ -1580,7 +1540,6 @@ static char *bzerrorstrings[] = {
       ,"???"   /* for future */
 };
 
-
 const char * BZ_API(BZ2_bzerror) (BZFILE *b, int *errnum)
 {
    int err = ((bzFile *)b)->lastErr;
diff --git a/lib/bzip2/bzlib_blocksort.c b/lib/bzip2/bzlib_blocksort.c
index 36cf8436592..2408ee90c18 100644
--- a/lib/bzip2/bzlib_blocksort.c
+++ b/lib/bzip2/bzlib_blocksort.c
@@ -99,7 +99,6 @@ void fallbackSimpleSort ( UInt32* fmap,
    }
 }
 
-
 /*---------------------------------------------*/
 #define fswap(zz1, zz2) \
    { Int32 zztmp = zz1; zz1 = zz2; zz2 = zztmp; }
@@ -115,7 +114,6 @@ void fallbackSimpleSort ( UInt32* fmap,
    }                                  \
 }
 
-
 #define fmin(a,b) ((a) < (b)) ? (a) : (b)
 
 #define fpush(lz,hz) { stackLo[sp] = lz; \
@@ -129,7 +127,6 @@ void fallbackSimpleSort ( UInt32* fmap,
 #define FALLBACK_QSORT_SMALL_THRESH 10
 #define FALLBACK_QSORT_STACK_SIZE   100
 
-
 static
 void fallbackQSort3 ( UInt32* fmap, 
                       UInt32* eclass,
@@ -228,7 +225,6 @@ void fallbackQSort3 ( UInt32* fmap,
 #undef FALLBACK_QSORT_SMALL_THRESH
 #undef FALLBACK_QSORT_STACK_SIZE
 
-
 /*---------------------------------------------*/
 /* Pre:
       nblock > 0
@@ -375,7 +371,6 @@ void fallbackSort ( UInt32* fmap,
 #undef      WORD_BH
 #undef UNALIGNED_BH
 
-
 /*---------------------------------------------*/
 /*--- The main, O(N^2 log(N)) sorting       ---*/
 /*--- algorithm.  Faster for "normal"       ---*/
@@ -509,7 +504,6 @@ Bool mainGtU ( UInt32  i1,
    return False;
 }
 
-
 /*---------------------------------------------*/
 /*--
    Knuth's increments seem to work better
@@ -595,7 +589,6 @@ void mainSimpleSort ( UInt32* ptr,
    }
 }
 
-
 /*---------------------------------------------*/
 /*--
    The following is an implementation of
@@ -644,7 +637,6 @@ UChar mmed3 ( UChar a, UChar b, UChar c )
                          hz = stackHi[sp]; \
                          dz = stackD [sp]; }
 
-
 #define mnextsize(az) (nextHi[az]-nextLo[az])
 
 #define mnextswap(az,bz)                                        \
@@ -653,7 +645,6 @@ UChar mmed3 ( UChar a, UChar b, UChar c )
      tz = nextHi[az]; nextHi[az] = nextHi[bz]; nextHi[bz] = tz; \
      tz = nextD [az]; nextD [az] = nextD [bz]; nextD [bz] = tz; }
 
-
 #define MAIN_QSORT_SMALL_THRESH 20
 #define MAIN_QSORT_DEPTH_THRESH (BZ_N_RADIX + BZ_N_QSORT)
 #define MAIN_QSORT_STACK_SIZE 100
@@ -768,7 +759,6 @@ void mainQSort3 ( UInt32* ptr,
 #undef MAIN_QSORT_DEPTH_THRESH
 #undef MAIN_QSORT_STACK_SIZE
 
-
 /*---------------------------------------------*/
 /* Pre:
       nblock > N_OVERSHOOT
@@ -1055,7 +1045,6 @@ void mainSort ( UInt32* ptr,
 #undef SETMASK
 #undef CLEARMASK
 
-
 /*---------------------------------------------*/
 /* Pre:
       nblock > 0
@@ -1129,7 +1118,6 @@ void BZ2_blockSort ( EState* s )
    AssertH( s->origPtr != -1, 1003 );
 }
 
-
 /*-------------------------------------------------------------*/
 /*--- end                                       blocksort.c ---*/
 /*-------------------------------------------------------------*/
diff --git a/lib/bzip2/bzlib_compress.c b/lib/bzip2/bzlib_compress.c
index 68d948b427a..d9400ca758c 100644
--- a/lib/bzip2/bzlib_compress.c
+++ b/lib/bzip2/bzlib_compress.c
@@ -80,7 +80,6 @@ void BZ2_bsInitWrite ( EState* s )
    s->bsBuff = 0;
 }
 
-
 /*---------------------------------------------------*/
 static
 void bsFinishWrite ( EState* s )
@@ -93,7 +92,6 @@ void bsFinishWrite ( EState* s )
    }
 }
 
-
 /*---------------------------------------------------*/
 #define bsNEEDW(nz)                           \
 {                                             \
@@ -106,7 +104,6 @@ void bsFinishWrite ( EState* s )
    }                                          \
 }
 
-
 /*---------------------------------------------------*/
 static
 __inline__
@@ -117,7 +114,6 @@ void bsW ( EState* s, Int32 n, UInt32 v )
    s->bsLive += n;
 }
 
-
 /*---------------------------------------------------*/
 static
 void bsPutUInt32 ( EState* s, UInt32 u )
@@ -128,7 +124,6 @@ void bsPutUInt32 ( EState* s, UInt32 u )
    bsW ( s, 8,  u        & 0xffL );
 }
 
-
 /*---------------------------------------------------*/
 static
 void bsPutUChar ( EState* s, UChar c )
@@ -136,7 +131,6 @@ void bsPutUChar ( EState* s, UChar c )
    bsW( s, 8, (UInt32)c );
 }
 
-
 /*---------------------------------------------------*/
 /*--- The back end proper                         ---*/
 /*---------------------------------------------------*/
@@ -154,7 +148,6 @@ void makeMaps_e ( EState* s )
       }
 }
 
-
 /*---------------------------------------------------*/
 static
 void generateMTFValues ( EState* s )
@@ -270,7 +263,6 @@ void generateMTFValues ( EState* s )
    s->nMTF = wr;
 }
 
-
 /*---------------------------------------------------*/
 #define BZ_LESSER_ICOST  0
 #define BZ_GREATER_ICOST 15
@@ -293,7 +285,6 @@ void sendMTFValues ( EState* s )
    Made global to keep stack frame size small.
    --*/
 
-
    UInt16 cost[BZ_N_GROUPS];
    Int32  fave[BZ_N_GROUPS];
 
@@ -492,13 +483,11 @@ void sendMTFValues ( EState* s )
                                  alphaSize, 17 /*20*/ );
    }
 
-
    AssertH( nGroups < 8, 3002 );
    AssertH( nSelectors < 32768 &&
             nSelectors <= (2 + (900000 / BZ_G_SIZE)),
             3003 );
 
-
    /*--- Compute MTF values for the selectors. ---*/
    {
       UChar pos[BZ_N_GROUPS], ll_i, tmp2, tmp;
@@ -628,7 +617,6 @@ void sendMTFValues ( EState* s )
          }
       }
 
-
       gs = ge+1;
       selCtr++;
    }
@@ -638,7 +626,6 @@ void sendMTFValues ( EState* s )
       VPrintf1( "codes %d\n", s->numZ-nBytes );
 }
 
-
 /*---------------------------------------------------*/
 void BZ2_compressBlock ( EState* s, Bool is_last_block )
 {
@@ -693,7 +680,6 @@ void BZ2_compressBlock ( EState* s, Bool is_last_block )
       sendMTFValues ( s );
    }
 
-
    /*-- If this is the last block, add the stream trailer. --*/
    if (is_last_block) {
 
@@ -707,7 +693,6 @@ void BZ2_compressBlock ( EState* s, Bool is_last_block )
    }
 }
 
-
 /*-------------------------------------------------------------*/
 /*--- end                                        compress.c ---*/
 /*-------------------------------------------------------------*/
diff --git a/lib/bzip2/bzlib_crctable.c b/lib/bzip2/bzlib_crctable.c
index 325b96643ef..2da2d655007 100644
--- a/lib/bzip2/bzlib_crctable.c
+++ b/lib/bzip2/bzlib_crctable.c
@@ -59,7 +59,6 @@
   For more information on these sources, see the manual.
 --*/
 
-
 #include "bzlib_private.h"
 
 /*--
@@ -139,7 +138,6 @@ UInt32 BZ2_crc32Table[256] = {
    0xbcb4666dL, 0xb8757bdaL, 0xb5365d03L, 0xb1f740b4L
 };
 
-
 /*-------------------------------------------------------------*/
 /*--- end                                        crctable.c ---*/
 /*-------------------------------------------------------------*/
diff --git a/lib/bzip2/bzlib_decompress.c b/lib/bzip2/bzlib_decompress.c
index e56ab6674b0..53695c13bfc 100644
--- a/lib/bzip2/bzlib_decompress.c
+++ b/lib/bzip2/bzlib_decompress.c
@@ -60,10 +60,8 @@
   For more information on these sources, see the manual.
 --*/
 
-
 #include "bzlib_private.h"
 
-
 /*---------------------------------------------------*/
 static
 void makeMaps_d ( DState* s )
@@ -77,7 +75,6 @@ void makeMaps_d ( DState* s )
       }
 }
 
-
 /*---------------------------------------------------*/
 #define RETURN(rrr)                               \
    { retVal = rrr; goto save_state_and_return; };
@@ -143,7 +140,6 @@ void makeMaps_d ( DState* s )
    lval = gPerm[zvec - gBase[zn]];                \
 }
 
-
 /*---------------------------------------------------*/
 Int32 BZ2_decompress ( DState* s )
 {
@@ -605,7 +601,6 @@ Int32 BZ2_decompress ( DState* s )
 
       RETURN(BZ_OK);
 
-
     endhdr_2:
 
       GET_UCHAR(BZ_X_ENDHDR_2, uc);
@@ -667,7 +662,6 @@ Int32 BZ2_decompress ( DState* s )
    return retVal;
 }
 
-
 /*-------------------------------------------------------------*/
 /*--- end                                      decompress.c ---*/
 /*-------------------------------------------------------------*/
diff --git a/lib/bzip2/bzlib_huffman.c b/lib/bzip2/bzlib_huffman.c
index 801b8ec39a0..904783d7cb1 100644
--- a/lib/bzip2/bzlib_huffman.c
+++ b/lib/bzip2/bzlib_huffman.c
@@ -59,7 +59,6 @@
   For more information on these sources, see the manual.
 --*/
 
-
 #include "bzlib_private.h"
 
 /*---------------------------------------------------*/
@@ -99,7 +98,6 @@
    heap[zz] = tmp;                                    \
 }
 
-
 /*---------------------------------------------------*/
 void BZ2_hbMakeCodeLengths ( UChar *len,
 			     Int32 *freq,
@@ -171,7 +169,6 @@ void BZ2_hbMakeCodeLengths ( UChar *len,
    }
 }
 
-
 /*---------------------------------------------------*/
 void BZ2_hbAssignCodes ( Int32 *code,
 			 UChar *length,
@@ -189,7 +186,6 @@ void BZ2_hbAssignCodes ( Int32 *code,
    }
 }
 
-
 /*---------------------------------------------------*/
 void BZ2_hbCreateDecodeTables ( Int32 *limit,
 				Int32 *base,
@@ -223,7 +219,6 @@ void BZ2_hbCreateDecodeTables ( Int32 *limit,
       base[i] = ((limit[i-1] + 1) << 1) - base[i];
 }
 
-
 /*-------------------------------------------------------------*/
 /*--- end                                         huffman.c ---*/
 /*-------------------------------------------------------------*/
diff --git a/lib/bzip2/bzlib_private.h b/lib/bzip2/bzlib_private.h
index 87d8f945258..b69eadc96a1 100644
--- a/lib/bzip2/bzlib_private.h
+++ b/lib/bzip2/bzlib_private.h
@@ -62,7 +62,6 @@
   For more information on these sources, see the manual.
 --*/
 
-
 #ifndef _BZLIB_PRIVATE_H
 #define _BZLIB_PRIVATE_H
 
@@ -76,7 +75,6 @@
 #include <string.h>
 #endif
 
-
 /*-- General stuff. --*/
 
 #define BZ_VERSION  "1.0.2, 30-Dec-2001"
@@ -135,11 +133,9 @@ extern void bz_internal_error ( int errcode );
 #define VPrintf5(zf,za1,za2,za3,za4,za5) /* */
 #endif
 
-
 #define BZALLOC(nnn) (strm->bzalloc)(strm->opaque,(nnn),1)
 #define BZFREE(ppp)  (strm->bzfree)(strm->opaque,(ppp))
 
-
 /*-- Header bytes. --*/
 
 #define BZ_HDR_B 0x42   /* 'B' */
@@ -161,7 +157,6 @@ extern void bz_internal_error ( int errcode );
 
 #define BZ_MAX_SELECTORS (2 + (900000 / BZ_G_SIZE))
 
-
 /*-- Stuff for randomising repetitive blocks. --*/
 
 extern Int32 BZ2_rNums[512];
@@ -184,7 +179,6 @@ extern Int32 BZ2_rNums[512];
    }                                           \
    s->rNToGo--;
 
-
 /*-- Stuff for doing CRCs. --*/
 
 extern UInt32 BZ2_crc32Table[256];
@@ -206,7 +200,6 @@ extern UInt32 BZ2_crc32Table[256];
 			   ((UChar)cha)];      \
 }
 
-
 /*-- States and modes for compression. --*/
 
 #define BZ_M_IDLE      1
@@ -222,7 +215,6 @@ extern UInt32 BZ2_crc32Table[256];
 #define BZ_N_SHELL 18
 #define BZ_N_OVERSHOOT (BZ_N_RADIX + BZ_N_QSORT + BZ_N_SHELL + 2)
 
-
 /*-- Structure holding all the compression-side stuff. --*/
 
 typedef
@@ -297,7 +289,6 @@ typedef
    }
    EState;
 
-
 /*-- externs for compression. --*/
 
 extern void
@@ -315,7 +306,6 @@ BZ2_hbAssignCodes ( Int32*, UChar*, Int32, Int32, Int32 );
 extern void
 BZ2_hbMakeCodeLengths ( UChar*, Int32*, Int32, Int32 );
 
-
 /*-- states for decompression. --*/
 
 #define BZ_X_IDLE        1
@@ -363,13 +353,11 @@ BZ2_hbMakeCodeLengths ( UChar*, Int32*, Int32, Int32 );
 #define BZ_X_CCRC_3      49
 #define BZ_X_CCRC_4      50
 
-
 /*-- Constants for the fast MTF decoder. --*/
 
 #define MTFA_SIZE 4096
 #define MTFL_SIZE 16
 
-
 /*-- Structure holding all the decompression-side stuff. --*/
 
 typedef
@@ -465,7 +453,6 @@ typedef
    }
    DState;
 
-
 /*-- Macros for decompression. --*/
 
 #define BZ_GET_FAST(cccc)                     \
@@ -499,7 +486,6 @@ typedef
       cccc = BZ2_indexIntoF ( s->tPos, s->cftab );    \
       s->tPos = GET_LL(s->tPos);
 
-
 /*-- externs for decompression. --*/
 
 extern Int32
@@ -512,10 +498,8 @@ extern void
 BZ2_hbCreateDecodeTables ( Int32*, Int32*, Int32*, UChar*,
 			   Int32,  Int32, Int32 );
 
-
 #endif
 
-
 /*-- BZ_NO_STDIO seems to make NULL disappear on some platforms. --*/
 
 #ifdef BZ_NO_STDIO
@@ -524,7 +508,6 @@ BZ2_hbCreateDecodeTables ( Int32*, Int32*, Int32*, UChar*,
 #endif
 #endif
 
-
 /*-------------------------------------------------------------*/
 /*--- end                                   bzlib_private.h ---*/
 /*-------------------------------------------------------------*/
diff --git a/lib/bzip2/bzlib_randtable.c b/lib/bzip2/bzlib_randtable.c
index c3dc7e41817..b2969266fc2 100644
--- a/lib/bzip2/bzlib_randtable.c
+++ b/lib/bzip2/bzlib_randtable.c
@@ -59,10 +59,8 @@
   For more information on these sources, see the manual.
 --*/
 
-
 #include "bzlib_private.h"
 
-
 /*---------------------------------------------*/
 Int32 BZ2_rNums[512] = {
    619, 720, 127, 481, 931, 816, 813, 233, 566, 247,
@@ -119,7 +117,6 @@ Int32 BZ2_rNums[512] = {
    936, 638
 };
 
-
 /*-------------------------------------------------------------*/
 /*--- end                                       randtable.c ---*/
 /*-------------------------------------------------------------*/
diff --git a/lib/circbuf.c b/lib/circbuf.c
index 2e161ae8d8b..461c240f788 100644
--- a/lib/circbuf.c
+++ b/lib/circbuf.c
@@ -9,7 +9,6 @@
 
 #include <circbuf.h>
 
-
 int buf_init (circbuf_t * buf, unsigned int size)
 {
 	assert (buf != NULL);
diff --git a/lib/crc7.c b/lib/crc7.c
index e635c9c2d67..938e258febe 100644
--- a/lib/crc7.c
+++ b/lib/crc7.c
@@ -8,7 +8,6 @@
 #include <linux/types.h>
 #include <linux/crc7.h>
 
-
 /* Table for CRC-7 (polynomial x^7 + x^3 + 1) */
 const u8 crc7_syndrome_table[256] = {
 	0x00, 0x09, 0x12, 0x1b, 0x24, 0x2d, 0x36, 0x3f,
diff --git a/lib/crypt/crypt-sha256.c b/lib/crypt/crypt-sha256.c
index 335c8880d81..824e24e190b 100644
--- a/lib/crypt/crypt-sha256.c
+++ b/lib/crypt/crypt-sha256.c
@@ -72,7 +72,6 @@ struct sha256_buffer
 static_assert (sizeof (struct sha256_buffer) <= ALG_SPECIFIC_SIZE,
                "ALG_SPECIFIC_SIZE is too small for SHA256");
 
-
 /* Use this instead of including errno.h */
 static int errno;
 
diff --git a/lib/crypt/crypt-sha512.c b/lib/crypt/crypt-sha512.c
index 8c8e6dd3dea..24d1345a223 100644
--- a/lib/crypt/crypt-sha512.c
+++ b/lib/crypt/crypt-sha512.c
@@ -72,7 +72,6 @@ struct sha512_buffer
 static_assert (sizeof (struct sha512_buffer) <= ALG_SPECIFIC_SIZE,
                "ALG_SPECIFIC_SIZE is too small for SHA512");
 
-
 /* Use this instead of including errno.h */
 static int errno;
 
diff --git a/lib/dhry/dhry.h b/lib/dhry/dhry.h
index 892c9ed73b8..bd95540eeb2 100644
--- a/lib/dhry/dhry.h
+++ b/lib/dhry/dhry.h
@@ -365,7 +365,6 @@
  ***************************************************************************
  */
 
-
 /* Compiler and system dependent definitions: */
 
 #ifndef TIME
@@ -432,7 +431,6 @@ typedef struct record
           } variant;
       } Rec_Type, *Rec_Pointer;
 
-
 /*
  * dhry() - run dhrystone for a given number of iterations
  *
diff --git a/lib/dhry/dhry_1.c b/lib/dhry/dhry_1.c
index 252cd14a656..275a89942ea 100644
--- a/lib/dhry/dhry_1.c
+++ b/lib/dhry/dhry_1.c
@@ -102,7 +102,6 @@ void Proc_3 (Rec_Pointer *Ptr_Ref_Par);
 void Proc_4 (void);
 void Proc_5 (void);
 
-
 extern Boolean Func_2(Str_30, Str_30);
 extern void Proc_6(Enumeration, Enumeration *);
 extern void Proc_7(One_Fifty, One_Fifty, One_Fifty *);
@@ -323,7 +322,6 @@ void dhry(int Number_Of_Runs)
 #endif /* SELF_TIMED */
 }
 
-
 void Proc_1 (REG Rec_Pointer Ptr_Val_Par)
     /* executed once */
 {
@@ -354,7 +352,6 @@ void Proc_1 (REG Rec_Pointer Ptr_Val_Par)
     structassign (*Ptr_Val_Par, *Ptr_Val_Par->Ptr_Comp);
 } /* Proc_1 */
 
-
 void Proc_2 (One_Fifty   *Int_Par_Ref)
     /* executed once */
     /* *Int_Par_Ref == 1, becomes 4 */
@@ -376,7 +373,6 @@ void Proc_2 (One_Fifty   *Int_Par_Ref)
   while (Enum_Loc != Ident_1); /* true */
 } /* Proc_2 */
 
-
 void Proc_3 (Rec_Pointer *Ptr_Ref_Par)
     /* executed once */
     /* Ptr_Ref_Par becomes Ptr_Glob */
@@ -387,7 +383,6 @@ void Proc_3 (Rec_Pointer *Ptr_Ref_Par)
   Proc_7 (10, Int_Glob, &Ptr_Glob->variant.var_1.Int_Comp);
 } /* Proc_3 */
 
-
 void Proc_4 (void) /* without parameters */
     /* executed once */
 {
@@ -406,7 +401,6 @@ void Proc_5 (void) /* without parameters */
   Bool_Glob = false;
 } /* Proc_5 */
 
-
         /* Procedure for the assignment of structures,          */
         /* if the C compiler doesn't support this feature       */
 #ifdef  NOSTRUCTASSIGN
diff --git a/lib/dhry/dhry_2.c b/lib/dhry/dhry_2.c
index a74197d884d..8f18f4ed423 100644
--- a/lib/dhry/dhry_2.c
+++ b/lib/dhry/dhry_2.c
@@ -106,7 +106,6 @@ One_Fifty      *Int_Par_Ref;
   *Int_Par_Ref = Int_2_Par_Val + Int_Loc;
 } /* Proc_7 */
 
-
 void Proc_8 (Arr_1_Par_Ref, Arr_2_Par_Ref, Int_1_Par_Val, Int_2_Par_Val)
 /*********************************************************************/
     /* executed once      */
@@ -131,7 +130,6 @@ int             Int_2_Par_Val;
   Int_Glob = 5;
 } /* Proc_8 */
 
-
 Enumeration Func_1 (Capital_Letter Ch_1_Par_Val, Capital_Letter Ch_2_Par_Val)
 /*************************************************/
     /* executed three times                                         */
@@ -154,8 +152,6 @@ Enumeration Func_1 (Capital_Letter Ch_1_Par_Val, Capital_Letter Ch_2_Par_Val)
    }
 } /* Func_1 */
 
-
-
 Boolean Func_2 (Str_1_Par_Ref, Str_2_Par_Ref)
 /*************************************************/
     /* executed once */
@@ -198,7 +194,6 @@ Str_30  Str_2_Par_Ref;
   } /* if Ch_Loc */
 } /* Func_2 */
 
-
 Boolean Func_3 (Enum_Par_Val)
 /***************************/
     /* executed once        */
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 0937800e588..635088f25a1 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -572,7 +572,6 @@ static efi_status_t efi_capsule_update_firmware(
 			return EFI_INVALID_PARAMETER;
 		}
 
-
 		/* Obtain the update_index from the platform */
 		status = fwu_plat_get_update_index(&update_index);
 		if (status < 0) {
diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
index 03dece51aea..c944c10b216 100644
--- a/lib/efi_loader/efi_console.c
+++ b/lib/efi_loader/efi_console.c
@@ -1176,7 +1176,6 @@ out:
 	return EFI_EXIT(ret);
 }
 
-
 /**
  * efi_cin_reset() - drain the input buffer
  *
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index 45dc5b6b244..0ddf69a0918 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -738,7 +738,6 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
 		log_debug("Message digest doesn't match\n");
 	}
 
-
 	/* last resort try the image sha256 hash in db */
 	if (!ret && efi_signature_lookup_digest(regs, db, false))
 		ret = true;
@@ -761,7 +760,6 @@ static bool efi_image_authenticate(void *efi, size_t efi_size)
 }
 #endif /* CONFIG_EFI_SECURE_BOOT */
 
-
 /**
  * efi_check_pe() - check if a memory buffer contains a PE-COFF image
  *
diff --git a/lib/efi_loader/efi_variable.c b/lib/efi_loader/efi_variable.c
index 09651d4675b..e888c52efe3 100644
--- a/lib/efi_loader/efi_variable.c
+++ b/lib/efi_loader/efi_variable.c
@@ -604,6 +604,5 @@ efi_status_t efi_init_variables(void)
 			log_err("Invalid EFI variable seed\n");
 	}
 
-
 	return efi_init_secure_state();
 }
diff --git a/lib/efi_selftest/efi_selftest_controllers.c b/lib/efi_selftest/efi_selftest_controllers.c
index 02f19574f83..9f23117449c 100644
--- a/lib/efi_selftest/efi_selftest_controllers.c
+++ b/lib/efi_selftest/efi_selftest_controllers.c
@@ -447,7 +447,6 @@ static int execute(void)
 		return EFI_ST_FAILURE;
 	}
 
-
 	return EFI_ST_SUCCESS;
 }
 
diff --git a/lib/efi_selftest/efi_selftest_ecpt.c b/lib/efi_selftest/efi_selftest_ecpt.c
index 09c5e96c5e1..47316598e61 100644
--- a/lib/efi_selftest/efi_selftest_ecpt.c
+++ b/lib/efi_selftest/efi_selftest_ecpt.c
@@ -68,7 +68,6 @@ static int execute(void)
 	return EFI_ST_SUCCESS;
 }
 
-
 EFI_UNIT_TEST(ecpt) = {
 	.name = "conformance profile table",
 	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
diff --git a/lib/efi_selftest/efi_selftest_load_file.c b/lib/efi_selftest/efi_selftest_load_file.c
index 14df7611727..4e77a7cbac2 100644
--- a/lib/efi_selftest/efi_selftest_load_file.c
+++ b/lib/efi_selftest/efi_selftest_load_file.c
@@ -233,7 +233,6 @@ static efi_status_t EFIAPI load_file(struct efi_load_file_protocol *this,
 	return EFI_SUCCESS;
 }
 
-
 /*
  * load_file2() - LoadFile() service of a EFI_LOAD_FILE2_PROTOCOL
  *
diff --git a/lib/fdtdec.c b/lib/fdtdec.c
index b2c59ab3818..5b3b26df968 100644
--- a/lib/fdtdec.c
+++ b/lib/fdtdec.c
@@ -1182,7 +1182,6 @@ static int uncompress_blob(const void *src, ulong sz_src, void **dstp)
 	if (!gzip && !lzo)
 		return -EBADMSG;
 
-
 	if (CONFIG_IS_ENABLED(MULTI_DTB_FIT_DYN_ALLOC)) {
 		dst = malloc(sz_out);
 		if (!dst) {
diff --git a/lib/fwu_updates/fwu.c b/lib/fwu_updates/fwu.c
index 5dfea2a4d8d..c7fc8987beb 100644
--- a/lib/fwu_updates/fwu.c
+++ b/lib/fwu_updates/fwu.c
@@ -278,7 +278,6 @@ int fwu_get_mdata(struct fwu_mdata *mdata)
 	if (!err)
 		goto ret_mdata;
 
-
 	/* else read, verify and, if needed, fix mdata */
 	for (int i = 0; i < 2; i++) {
 		parts_ok[i] = false;
diff --git a/lib/hashtable.c b/lib/hashtable.c
index a0060f6a0d6..9613adc5540 100644
--- a/lib/hashtable.c
+++ b/lib/hashtable.c
@@ -58,7 +58,6 @@ struct env_entry_node {
 	struct env_entry entry;
 };
 
-
 static void _hdelete(const char *key, struct hsearch_data *htab,
 		     struct env_entry *ep, int idx);
 
@@ -127,7 +126,6 @@ int hcreate_r(size_t nel, struct hsearch_data *htab)
 	return 1;
 }
 
-
 /*
  * hdestroy()
  */
@@ -428,7 +426,6 @@ int hsearch_r(struct env_entry item, enum env_action action,
 	return 0;
 }
 
-
 /*
  * hdelete()
  */
@@ -718,7 +715,6 @@ ssize_t hexport_r(struct hsearch_data *htab, const char sep, int flag,
 }
 #endif
 
-
 /*
  * himport()
  */
diff --git a/lib/libavb/avb_sha.h b/lib/libavb/avb_sha.h
index f5d02e09f22..fdd92fbe22d 100644
--- a/lib/libavb/avb_sha.h
+++ b/lib/libavb/avb_sha.h
@@ -24,7 +24,6 @@ extern "C" {
 /* Block size in bytes of a SHA-256 digest. */
 #define AVB_SHA256_BLOCK_SIZE 64
 
-
 /* Block size in bytes of a SHA-512 digest. */
 #define AVB_SHA512_BLOCK_SIZE 128
 
diff --git a/lib/lz4.c b/lib/lz4.c
index d365dc727cf..63955a0b178 100644
--- a/lib/lz4.c
+++ b/lib/lz4.c
@@ -71,7 +71,6 @@ static void LZ4_wildCopy(void* dstPtr, const void* srcPtr, void* dstEnd)
     do { LZ4_copy8(d,s); d+=8; s+=8; } while (d<e);
 }
 
-
 /**************************************
 *  Common Constants
 **************************************/
diff --git a/lib/lzma/LzmaDec.c b/lib/lzma/LzmaDec.c
index 1da3f0a14a7..954380af52a 100644
--- a/lib/lzma/LzmaDec.c
+++ b/lib/lzma/LzmaDec.c
@@ -58,7 +58,6 @@
 #define TREE_DECODE_CHECK(probs, limit, i) \
   { i = 1; do { GET_BIT_CHECK(probs + i, i) } while (i < limit); i -= limit; }
 
-
 #define kNumPosBitsMax 4
 #define kNumPosStatesMax (1 << kNumPosBitsMax)
 
@@ -76,7 +75,6 @@
 #define LenHigh (LenMid + (kNumPosStatesMax << kLenNumMidBits))
 #define kNumLenProbs (LenHigh + kLenNumHighSymbols)
 
-
 #define kNumStates 12
 #define kNumLitStates 7
 
@@ -689,7 +687,6 @@ static ELzmaDummy LzmaDec_TryDummy(const CLzmaDec *p, const Byte *buf, SizeT inS
   return res;
 }
 
-
 static void LzmaDec_InitRc(CLzmaDec *p, const Byte *data)
 {
   p->code = ((UInt32)data[1] << 24) | ((UInt32)data[2] << 16) | ((UInt32)data[3] << 8) | ((UInt32)data[4]);
diff --git a/lib/lzma/LzmaDec.h b/lib/lzma/LzmaDec.h
index 63aa505e8ca..14b247b802b 100644
--- a/lib/lzma/LzmaDec.h
+++ b/lib/lzma/LzmaDec.h
@@ -16,7 +16,6 @@
 #define CLzmaProb UInt16
 #endif
 
-
 /* ---------- LZMA Properties ---------- */
 
 #define LZMA_PROPS_SIZE 5
@@ -35,7 +34,6 @@ Returns:
 
 SRes LzmaProps_Decode(CLzmaProps *p, const Byte *data, unsigned size);
 
-
 /* ---------- LZMA Decoder state ---------- */
 
 /* LZMA_REQUIRED_INPUT_MAX = number of required input bytes for worst case.
@@ -104,7 +102,6 @@ typedef enum
 
 /* ELzmaStatus is used only as output value for function call */
 
-
 /* ---------- Interfaces ---------- */
 
 /* There are 3 levels of interfaces:
@@ -114,7 +111,6 @@ typedef enum
    You can select any of these interfaces, but don't mix functions from different
    groups for same object. */
 
-
 /* There are two variants to allocate state for Dictionary Interface:
      1) LzmaDec_Allocate / LzmaDec_Free
      2) LzmaDec_AllocateProbs / LzmaDec_FreeProbs
@@ -177,7 +173,6 @@ Returns:
 SRes LzmaDec_DecodeToDic(CLzmaDec *p, SizeT dicLimit,
     const Byte *src, SizeT *srcLen, ELzmaFinishMode finishMode, ELzmaStatus *status);
 
-
 /* ---------- Buffer Interface ---------- */
 
 /* It's zlib-like interface.
@@ -194,7 +189,6 @@ finishMode:
 SRes LzmaDec_DecodeToBuf(CLzmaDec *p, Byte *dest, SizeT *destLen,
     const Byte *src, SizeT *srcLen, ELzmaFinishMode finishMode, ELzmaStatus *status);
 
-
 /* ---------- One Call Interface ---------- */
 
 /* LzmaDecode
diff --git a/lib/lzma/Types.h b/lib/lzma/Types.h
index 04f894a8ca9..6f7e735c1f6 100644
--- a/lib/lzma/Types.h
+++ b/lib/lzma/Types.h
@@ -84,7 +84,6 @@ typedef int Bool;
 #define True 1
 #define False 0
 
-
 #ifdef _MSC_VER
 
 #if _MSC_VER >= 1300
@@ -103,7 +102,6 @@ typedef int Bool;
 
 #endif
 
-
 /* The following interfaces use first parameter as pointer to structure */
 
 typedef struct
diff --git a/lib/lzo/lzo1x_decompress.c b/lib/lzo/lzo1x_decompress.c
index 5d70fa41337..03027e5dc3b 100644
--- a/lib/lzo/lzo1x_decompress.c
+++ b/lib/lzo/lzo1x_decompress.c
@@ -31,7 +31,6 @@ static const unsigned char lzop_magic[] = {
 
 #define HEADER_HAS_FILTER	0x00000800L
 
-
 bool lzop_is_valid_header(const unsigned char *src)
 {
 	int i;
diff --git a/lib/md5.c b/lib/md5.c
index 34343cf8e23..584463d55ca 100644
--- a/lib/md5.c
+++ b/lib/md5.c
@@ -276,7 +276,6 @@ md5 (unsigned char *input, int len, unsigned char output[16])
 	MD5Final(output, &context);
 }
 
-
 /*
  * Calculate and store in 'output' the MD5 digest of 'len' bytes at 'input'.
  * 'output' must have enough space to hold 16 bytes. If 'chunk' Trigger the
diff --git a/lib/string.c b/lib/string.c
index f2c61471288..feae9519f2f 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -22,7 +22,6 @@
 #include <linux/ctype.h>
 #include <malloc.h>
 
-
 /**
  * strncasecmp - Case insensitive, length-limited string comparison
  * @s1: One string
diff --git a/lib/zlib/deflate.c b/lib/zlib/deflate.c
index 7e1ed4f9b20..af7542cc9a8 100644
--- a/lib/zlib/deflate.c
+++ b/lib/zlib/deflate.c
@@ -164,7 +164,6 @@ struct static_tree_desc_s {int dummy;}; /* for buggy compilers */
  */
 #define UPDATE_HASH(s,h,c) (h = (((h)<<s->hash_shift) ^ (c)) & s->hash_mask)
 
-
 /* ===========================================================================
  * Insert string str in the dictionary and set match_head to the previous head
  * of the hash chain (the most recent string with same hash key). Return
@@ -966,7 +965,6 @@ int ZEXPORT deflateCopy (dest, source)
     deflate_state *ds;
     deflate_state *ss;
 
-
     if (source == Z_NULL || dest == Z_NULL || source->state == Z_NULL) {
         return Z_STREAM_ERROR;
     }
diff --git a/lib/zlib/deflate.h b/lib/zlib/deflate.h
index 4c53b94af0b..b4a4634ec78 100644
--- a/lib/zlib/deflate.h
+++ b/lib/zlib/deflate.h
@@ -57,7 +57,6 @@
 #define FINISH_STATE 666
 /* Stream status */
 
-
 /* Data structure describing a single value and its code string. */
 typedef struct ct_data_s {
     union {
@@ -269,7 +268,6 @@ typedef struct internal_state {
  */
 #define put_byte(s, c) {s->pending_buf[s->pending++] = (c);}
 
-
 #define MIN_LOOKAHEAD (MAX_MATCH+MIN_MATCH+1)
 /* Minimum amount of lookahead, except at the end of the input file.
  * See deflate.c for comments about the MIN_MATCH+1.
diff --git a/lib/zlib/trees.c b/lib/zlib/trees.c
index e040617686a..569d44351e5 100644
--- a/lib/zlib/trees.c
+++ b/lib/zlib/trees.c
@@ -231,7 +231,6 @@ local void send_bits(s, value, length)
 }
 #endif /* DEBUG */
 
-
 /* the arguments must not have side effects */
 
 /* ===========================================================================
@@ -431,7 +430,6 @@ local void init_block(s)
 #define SMALLEST 1
 /* Index within the heap array of least frequent node in the Huffman tree */
 
-
 /* ===========================================================================
  * Remove the smallest element from the heap and recreate the heap with
  * one less element. Updates heap and heap_len.
diff --git a/lib/zlib/zutil.h b/lib/zlib/zutil.h
index e63bf68653f..c0c04196a02 100644
--- a/lib/zlib/zutil.h
+++ b/lib/zlib/zutil.h
@@ -114,7 +114,6 @@ extern const char * const z_errmsg[10]; /* indexed by 2-zlib_error */
 #  define Tracecv(c,x)
 #endif
 
-
 voidpf zcalloc OF((voidpf opaque, unsigned items, unsigned size));
 void   zcfree  OF((voidpf opaque, voidpf ptr, unsigned size));
 
diff --git a/lib/zstd/common/bitstream.h b/lib/zstd/common/bitstream.h
index feef3a1b1d6..ee36de1cd1a 100644
--- a/lib/zstd/common/bitstream.h
+++ b/lib/zstd/common/bitstream.h
@@ -28,7 +28,6 @@
 #include "debug.h"          /* assert(), DEBUGLOG(), RAWLOG() */
 #include "error_private.h"  /* error codes and messages */
 
-
 /*=========================================
 *  Target specific
 =========================================*/
@@ -37,7 +36,6 @@
 #define STREAM_ACCUMULATOR_MIN_64  57
 #define STREAM_ACCUMULATOR_MIN    ((U32)(MEM_32bits() ? STREAM_ACCUMULATOR_MIN_32 : STREAM_ACCUMULATOR_MIN_64))
 
-
 /*-******************************************
 *  bitStream encoding API (write forward)
 ********************************************/
@@ -75,7 +73,6 @@ MEM_STATIC size_t BIT_closeCStream(BIT_CStream_t* bitC);
 *  If data couldn't fit into `dstBuffer`, it will return a 0 ( == not storable)
 */
 
-
 /*-********************************************
 *  bitStream decoding API (read backward)
 **********************************************/
@@ -98,7 +95,6 @@ MEM_STATIC size_t   BIT_readBits(BIT_DStream_t* bitD, unsigned nbBits);
 MEM_STATIC BIT_DStream_status BIT_reloadDStream(BIT_DStream_t* bitD);
 MEM_STATIC unsigned BIT_endOfDStream(const BIT_DStream_t* bitD);
 
-
 /* Start by invoking BIT_initDStream().
 *  A chunk of the bitStream is then stored into a local register.
 *  Local register size is 64-bits on 64-bits systems, 32-bits on 32-bits systems (size_t).
@@ -109,7 +105,6 @@ MEM_STATIC unsigned BIT_endOfDStream(const BIT_DStream_t* bitD);
 *  Checking if DStream has reached its end can be performed with BIT_endOfDStream().
 */
 
-
 /*-****************************************
 *  unsafe API
 ******************************************/
@@ -122,8 +117,6 @@ MEM_STATIC void BIT_flushBitsFast(BIT_CStream_t* bitC);
 MEM_STATIC size_t BIT_readBitsFast(BIT_DStream_t* bitD, unsigned nbBits);
 /* faster, but works only if nbBits >= 1 */
 
-
-
 /*-**************************************************************
 *  Internal functions
 ****************************************************************/
@@ -245,7 +238,6 @@ MEM_STATIC size_t BIT_closeCStream(BIT_CStream_t* bitC)
     return (bitC->ptr - bitC->startPtr) + (bitC->bitPos > 0);
 }
 
-
 /*-********************************************************
 *  bitStream decoding
 **********************************************************/
@@ -442,5 +434,4 @@ MEM_STATIC unsigned BIT_endOfDStream(const BIT_DStream_t* DStream)
     return ((DStream->ptr == DStream->start) && (DStream->bitsConsumed == sizeof(DStream->bitContainer)*8));
 }
 
-
 #endif /* BITSTREAM_H_MODULE */
diff --git a/lib/zstd/common/compiler.h b/lib/zstd/common/compiler.h
index c42d39faf9b..a7345658602 100644
--- a/lib/zstd/common/compiler.h
+++ b/lib/zstd/common/compiler.h
@@ -70,7 +70,6 @@
 /* force no inlining */
 #define FORCE_NOINLINE static __attribute__((__noinline__))
 
-
 /* target attribute */
 #define TARGET_ATTRIBUTE(target) __attribute__((__target__(target)))
 
@@ -135,7 +134,6 @@
 
 /*Like DYNAMIC_BMI2 but for compile time determination of BMI2 support*/
 
-
 /* compile time determination of SIMD support */
 
 /* C-language Attributes are added in C23. */
@@ -179,6 +177,4 @@
 *  Sanitizer
 *****************************************************************/
 
-
-
 #endif /* ZSTD_COMPILER_H */
diff --git a/lib/zstd/common/cpu.h b/lib/zstd/common/cpu.h
index 0db7b42407e..becf832a95a 100644
--- a/lib/zstd/common/cpu.h
+++ b/lib/zstd/common/cpu.h
@@ -18,7 +18,6 @@
 
 #include "mem.h"
 
-
 typedef struct {
     U32 f1c;
     U32 f1d;
diff --git a/lib/zstd/common/debug.c b/lib/zstd/common/debug.c
index bb863c9ea61..49254cc6722 100644
--- a/lib/zstd/common/debug.c
+++ b/lib/zstd/common/debug.c
@@ -12,7 +12,6 @@
  * You may select, at your option, one of the above-listed licenses.
 ****************************************************************** */
 
-
 /*
  * This module only hosts one global variable
  * which can be used to dynamically influence the verbosity of traces,
diff --git a/lib/zstd/common/debug.h b/lib/zstd/common/debug.h
index 7f43dd3c063..ad6e60d609e 100644
--- a/lib/zstd/common/debug.h
+++ b/lib/zstd/common/debug.h
@@ -12,7 +12,6 @@
  * You may select, at your option, one of the above-listed licenses.
 ****************************************************************** */
 
-
 /*
  * The purpose of this header is to enable debug functions.
  * They regroup assert(), DEBUGLOG() and RAWLOG() for run-time,
@@ -32,14 +31,11 @@
 #ifndef DEBUG_H_12987983217
 #define DEBUG_H_12987983217
 
-
-
 /* static assert is triggered at compile time, leaving no runtime artefact.
  * static assert only works with compile-time constants.
  * Also, this variant can only be used inside a function. */
 #define DEBUG_STATIC_ASSERT(c) (void)sizeof(char[(c) ? 1 : -1])
 
-
 /* DEBUGLEVEL is expected to be defined externally,
  * typically through compiler command line.
  * Value must be a number. */
@@ -47,7 +43,6 @@
 #  define DEBUGLEVEL 0
 #endif
 
-
 /* recommended values for DEBUGLEVEL :
  * 0 : release mode, no debug, all run-time checks disabled
  * 1 : enables assert() only, no display
@@ -87,6 +82,4 @@ extern int g_debuglevel; /* the variable is only declared,
 #  define DEBUGLOG(l, ...)    {}    /* disabled */
 #endif
 
-
-
 #endif /* DEBUG_H_12987983217 */
diff --git a/lib/zstd/common/entropy_common.c b/lib/zstd/common/entropy_common.c
index fef67056f05..0f421839ed4 100644
--- a/lib/zstd/common/entropy_common.c
+++ b/lib/zstd/common/entropy_common.c
@@ -22,11 +22,9 @@
 #define HUF_STATIC_LINKING_ONLY  /* HUF_TABLELOG_ABSOLUTEMAX */
 #include "huf.h"
 
-
 /*===   Version   ===*/
 unsigned FSE_versionNumber(void) { return FSE_VERSION_NUMBER; }
 
-
 /*===   Error Management   ===*/
 unsigned FSE_isError(size_t code) { return ERR_isError(code); }
 const char* FSE_getErrorName(size_t code) { return ERR_getErrorName(code); }
@@ -34,7 +32,6 @@ const char* FSE_getErrorName(size_t code) { return ERR_getErrorName(code); }
 unsigned HUF_isError(size_t code) { return ERR_isError(code); }
 const char* HUF_getErrorName(size_t code) { return ERR_getErrorName(code); }
 
-
 /*-**************************************************************
 *  FSE NCount encoding-decoding
 ****************************************************************/
@@ -240,7 +237,6 @@ size_t FSE_readNCount(
     return FSE_readNCount_bmi2(normalizedCounter, maxSVPtr, tableLogPtr, headerBuffer, hbSize, /* bmi2 */ 0);
 }
 
-
 /*! HUF_readStats() :
     Read compact Huffman tree, saved by HUF_writeCTable().
     `huffWeight` is destination buffer.
diff --git a/lib/zstd/common/error_private.h b/lib/zstd/common/error_private.h
index ca5101e542f..886d2757df4 100644
--- a/lib/zstd/common/error_private.h
+++ b/lib/zstd/common/error_private.h
@@ -13,8 +13,6 @@
 #ifndef ERROR_H_MODULE
 #define ERROR_H_MODULE
 
-
-
 /* ****************************************
 *  Dependencies
 ******************************************/
@@ -23,20 +21,17 @@
 #include "debug.h"
 #include "zstd_deps.h"       /* size_t */
 
-
 /* ****************************************
 *  Compiler-specific
 ******************************************/
 #define ERR_STATIC static __attribute__((unused))
 
-
 /*-****************************************
 *  Customization (error_public.h)
 ******************************************/
 typedef ZSTD_ErrorCode ERR_enum;
 #define PREFIX(name) ZSTD_error_##name
 
-
 /*-****************************************
 *  Error codes handling
 ******************************************/
@@ -52,7 +47,6 @@ ERR_STATIC ERR_enum ERR_getErrorCode(size_t code) { if (!ERR_isError(code)) retu
 #define CHECK_V_F(e, f) size_t const e = f; if (ERR_isError(e)) return e
 #define CHECK_F(f)   { CHECK_V_F(_var_err__, f); }
 
-
 /*-****************************************
 *  Error Strings
 ******************************************/
@@ -141,5 +135,4 @@ void _force_has_format_string(const char *format, ...) {
     } \
   } while(0);
 
-
 #endif /* ERROR_H_MODULE */
diff --git a/lib/zstd/common/fse.h b/lib/zstd/common/fse.h
index 4507043b228..78b3ff14b93 100644
--- a/lib/zstd/common/fse.h
+++ b/lib/zstd/common/fse.h
@@ -12,17 +12,14 @@
  * You may select, at your option, one of the above-listed licenses.
 ****************************************************************** */
 
-
 #ifndef FSE_H
 #define FSE_H
 
-
 /*-*****************************************
 *  Dependencies
 ******************************************/
 #include "zstd_deps.h"    /* size_t, ptrdiff_t */
 
-
 /*-*****************************************
 *  FSE_PUBLIC_API : control library symbols visibility
 ******************************************/
@@ -49,7 +46,6 @@
 #define FSE_VERSION_NUMBER  (FSE_VERSION_MAJOR *100*100 + FSE_VERSION_MINOR *100 + FSE_VERSION_RELEASE)
 FSE_PUBLIC_API unsigned FSE_versionNumber(void);   /*< library version number; to be used when checking dll version */
 
-
 /*-****************************************
 *  FSE simple functions
 ******************************************/
@@ -77,7 +73,6 @@ FSE_PUBLIC_API size_t FSE_compress(void* dst, size_t dstCapacity,
 FSE_PUBLIC_API size_t FSE_decompress(void* dst,  size_t dstCapacity,
                                const void* cSrc, size_t cSrcSize);
 
-
 /*-*****************************************
 *  Tool functions
 ******************************************/
@@ -87,7 +82,6 @@ FSE_PUBLIC_API size_t FSE_compressBound(size_t size);       /* maximum compresse
 FSE_PUBLIC_API unsigned    FSE_isError(size_t code);        /* tells if a return value is an error code */
 FSE_PUBLIC_API const char* FSE_getErrorName(size_t code);   /* provides error code string (useful for debugging) */
 
-
 /*-*****************************************
 *  FSE advanced functions
 ******************************************/
@@ -101,7 +95,6 @@ FSE_PUBLIC_API const char* FSE_getErrorName(size_t code);   /* provides error co
 */
 FSE_PUBLIC_API size_t FSE_compress2 (void* dst, size_t dstSize, const void* src, size_t srcSize, unsigned maxSymbolValue, unsigned tableLog);
 
-
 /*-*****************************************
 *  FSE detailed API
 ******************************************/
@@ -219,7 +212,6 @@ If it returns '0', compressed data could not fit into 'dst'.
 If there is an error, the function will return an ErrorCode (which can be tested using FSE_isError()).
 */
 
-
 /* *** DECOMPRESSION *** */
 
 /*! FSE_readNCount():
@@ -292,7 +284,6 @@ If there is an error, the function will return an error code, which can be teste
 /* *** Dependency *** */
 #include "bitstream.h"
 
-
 /* *****************************************
 *  Static allocation
 *******************************************/
@@ -309,7 +300,6 @@ If there is an error, the function will return an error code, which can be teste
 #define FSE_CTABLE_SIZE(maxTableLog, maxSymbolValue)   (FSE_CTABLE_SIZE_U32(maxTableLog, maxSymbolValue) * sizeof(FSE_CTable))
 #define FSE_DTABLE_SIZE(maxTableLog)                   (FSE_DTABLE_SIZE_U32(maxTableLog) * sizeof(FSE_DTable))
 
-
 /* *****************************************
  *  FSE advanced API
  ***************************************** */
@@ -397,7 +387,6 @@ FSE_CTable    ct;         // Provided by FSE_buildCTable()
 BIT_CStream_t bitStream;  // bitStream tracking structure
 FSE_CState_t  state;      // State tracking structure (can have several)
 
-
 The first thing to do is to init bitStream and state.
     size_t errorCode = BIT_initCStream(&bitStream, dstBuffer, maxDstSize);
     FSE_initCState(&state, ct);
@@ -427,7 +416,6 @@ If there is an error, it returns an errorCode (which can be tested using FSE_isE
     size_t size = BIT_closeCStream(&bitStream);
 */
 
-
 /* *****************************************
 *  FSE symbol decompression API
 *******************************************/
@@ -436,7 +424,6 @@ typedef struct {
     const void* table;   /* precise table may vary, depending on U16 */
 } FSE_DState_t;
 
-
 static void     FSE_initDState(FSE_DState_t* DStatePtr, BIT_DStream_t* bitD, const FSE_DTable* dt);
 
 static unsigned char FSE_decodeSymbol(FSE_DState_t* DStatePtr, BIT_DStream_t* bitD);
@@ -492,14 +479,12 @@ Check also the states. There might be some symbols left there, if some high prob
     FSE_endOfDState(&DState);
 */
 
-
 /* *****************************************
 *  FSE unsafe API
 *******************************************/
 static unsigned char FSE_decodeSymbolFast(FSE_DState_t* DStatePtr, BIT_DStream_t* bitD);
 /* faster, but works only if nbBits is always >= 1 (otherwise, result will be corrupted) */
 
-
 /* *****************************************
 *  Implementation of inlined functions
 *******************************************/
@@ -519,7 +504,6 @@ MEM_STATIC void FSE_initCState(FSE_CState_t* statePtr, const FSE_CTable* ct)
     statePtr->stateLog = tableLog;
 }
 
-
 /*! FSE_initCState2() :
 *   Same as FSE_initCState(), but the first symbol to include (which will be the last to be read)
 *   uses the smallest state value possible, saving the cost of this symbol */
@@ -549,7 +533,6 @@ MEM_STATIC void FSE_flushCState(BIT_CStream_t* bitC, const FSE_CState_t* statePt
     BIT_flushBits(bitC);
 }
 
-
 /* FSE_getMaxNbBits() :
  * Approximate maximum cost of a symbol, in bits.
  * Fractional get rounded up (i.e : a symbol with a normalized frequency of 3 gives the same result as a frequency of 2)
@@ -582,7 +565,6 @@ MEM_STATIC U32 FSE_bitCost(const void* symbolTTPtr, U32 tableLog, U32 symbolValu
     }
 }
 
-
 /* ======    Decompression    ====== */
 
 typedef struct {
@@ -649,8 +631,6 @@ MEM_STATIC unsigned FSE_endOfDState(const FSE_DState_t* DStatePtr)
     return DStatePtr->state == 0;
 }
 
-
-
 #ifndef FSE_COMMONDEFS_ONLY
 
 /* **************************************************************
@@ -685,10 +665,8 @@ MEM_STATIC unsigned FSE_endOfDState(const FSE_DState_t* DStatePtr)
 #define FSE_FUNCTION_EXTENSION
 #define FSE_DECODE_TYPE FSE_decode_t
 
-
 #endif   /* !FSE_COMMONDEFS_ONLY */
 
-
 /* ***************************************************************
 *  Constants
 *****************************************************************/
@@ -705,7 +683,5 @@ MEM_STATIC unsigned FSE_endOfDState(const FSE_DState_t* DStatePtr)
 
 #define FSE_TABLESTEP(tableSize) (((tableSize)>>1) + ((tableSize)>>3) + 3)
 
-
 #endif /* FSE_STATIC_LINKING_ONLY */
 
-
diff --git a/lib/zstd/common/fse_decompress.c b/lib/zstd/common/fse_decompress.c
index a0d06095be8..5aa75db413a 100644
--- a/lib/zstd/common/fse_decompress.c
+++ b/lib/zstd/common/fse_decompress.c
@@ -12,7 +12,6 @@
  * You may select, at your option, one of the above-listed licenses.
 ****************************************************************** */
 
-
 /* **************************************************************
 *  Includes
 ****************************************************************/
@@ -25,14 +24,12 @@
 #define ZSTD_DEPS_NEED_MALLOC
 #include "zstd_deps.h"
 
-
 /* **************************************************************
 *  Error Management
 ****************************************************************/
 #define FSE_isError ERR_isError
 #define FSE_STATIC_ASSERT(c) DEBUG_STATIC_ASSERT(c)   /* use only *after* variable declarations */
 
-
 /* **************************************************************
 *  Templates
 ****************************************************************/
@@ -55,7 +52,6 @@
 #define FSE_FUNCTION_NAME(X,Y) FSE_CAT(X,Y)
 #define FSE_TYPE_NAME(X,Y) FSE_CAT(X,Y)
 
-
 /* Function templates */
 FSE_DTable* FSE_createDTable (unsigned tableLog)
 {
@@ -178,7 +174,6 @@ size_t FSE_buildDTable_wksp(FSE_DTable* dt, const short* normalizedCounter, unsi
     return FSE_buildDTable_internal(dt, normalizedCounter, maxSymbolValue, tableLog, workSpace, wkspSize);
 }
 
-
 #ifndef FSE_COMMONDEFS_ONLY
 
 /*-*******************************************************
@@ -201,7 +196,6 @@ size_t FSE_buildDTable_rle (FSE_DTable* dt, BYTE symbolValue)
     return 0;
 }
 
-
 size_t FSE_buildDTable_raw (FSE_DTable* dt, unsigned nbBits)
 {
     void* ptr = dt;
@@ -290,7 +284,6 @@ FORCE_INLINE_TEMPLATE size_t FSE_decompress_usingDTable_generic(
     return op-ostart;
 }
 
-
 size_t FSE_decompress_usingDTable(void* dst, size_t originalSize,
                             const void* cSrc, size_t cSrcSize,
                             const FSE_DTable* dt)
@@ -304,7 +297,6 @@ size_t FSE_decompress_usingDTable(void* dst, size_t originalSize,
     return FSE_decompress_usingDTable_generic(dst, originalSize, cSrc, cSrcSize, dt, 0);
 }
 
-
 size_t FSE_decompress_wksp(void* dst, size_t dstCapacity, const void* cSrc, size_t cSrcSize, unsigned maxLog, void* workSpace, size_t wkspSize)
 {
     return FSE_decompress_wksp_bmi2(dst, dstCapacity, cSrc, cSrcSize, maxLog, workSpace, wkspSize, /* bmi2 */ 0);
@@ -315,7 +307,6 @@ typedef struct {
     FSE_DTable dtable[1]; /* Dynamically sized */
 } FSE_DecompressWksp;
 
-
 FORCE_INLINE_TEMPLATE size_t FSE_decompress_wksp_body(
         void* dst, size_t dstCapacity,
         const void* cSrc, size_t cSrcSize,
@@ -382,9 +373,6 @@ size_t FSE_decompress_wksp_bmi2(void* dst, size_t dstCapacity, const void* cSrc,
     return FSE_decompress_wksp_body_default(dst, dstCapacity, cSrc, cSrcSize, maxLog, workSpace, wkspSize);
 }
 
-
 typedef FSE_DTable DTable_max_t[FSE_DTABLE_SIZE_U32(FSE_MAX_TABLELOG)];
 
-
-
 #endif   /* FSE_COMMONDEFS_ONLY */
diff --git a/lib/zstd/common/huf.h b/lib/zstd/common/huf.h
index 5042ff87030..b2678b8153e 100644
--- a/lib/zstd/common/huf.h
+++ b/lib/zstd/common/huf.h
@@ -12,14 +12,12 @@
  * You may select, at your option, one of the above-listed licenses.
 ****************************************************************** */
 
-
 #ifndef HUF_H_298734234
 #define HUF_H_298734234
 
 /* *** Dependencies *** */
 #include "zstd_deps.h"    /* size_t */
 
-
 /* *** library symbols visibility *** */
 /* Note : when linking with -fvisibility=hidden on gcc, or by default on Visual,
  *        HUF symbols remain "private" (internal symbols for library only).
@@ -34,7 +32,6 @@
 #  define HUF_PUBLIC_API
 #endif
 
-
 /* ========================== */
 /* ***  simple functions  *** */
 /* ========================== */
@@ -64,7 +61,6 @@ HUF_PUBLIC_API size_t HUF_compress(void* dst, size_t dstCapacity,
 HUF_PUBLIC_API size_t HUF_decompress(void* dst,  size_t originalSize,
                                const void* cSrc, size_t cSrcSize);
 
-
 /* ***   Tool functions *** */
 #define HUF_BLOCKSIZE_MAX (128 * 1024)                  /*< maximum input size for a single block compressed with HUF_compress */
 HUF_PUBLIC_API size_t HUF_compressBound(size_t size);   /*< maximum compressed size (worst case) */
@@ -73,7 +69,6 @@ HUF_PUBLIC_API size_t HUF_compressBound(size_t size);   /*< maximum compressed s
 HUF_PUBLIC_API unsigned    HUF_isError(size_t code);       /*< tells if a return value is an error code */
 HUF_PUBLIC_API const char* HUF_getErrorName(size_t code);  /*< provides error code string (useful for debugging) */
 
-
 /* ***   Advanced function   *** */
 
 /* HUF_compress2() :
@@ -111,7 +106,6 @@ HUF_PUBLIC_API size_t HUF_compress4X_wksp (void* dst, size_t dstCapacity,
 #define FSE_STATIC_LINKING_ONLY
 #include "fse.h"
 
-
 /* *** Constants *** */
 #define HUF_TABLELOG_MAX      12      /* max runtime value of tableLog (due to static allocation); can be modified up to HUF_TABLELOG_ABSOLUTEMAX */
 #define HUF_TABLELOG_DEFAULT  11      /* default tableLog value when none specified */
@@ -122,7 +116,6 @@ HUF_PUBLIC_API size_t HUF_compress4X_wksp (void* dst, size_t dstCapacity,
 #  error "HUF_TABLELOG_MAX is too large !"
 #endif
 
-
 /* ****************************************
 *  Static allocation
 ******************************************/
@@ -147,7 +140,6 @@ typedef U32 HUF_DTable;
 #define HUF_CREATE_STATIC_DTABLEX2(DTable, maxTableLog) \
         HUF_DTable DTable[HUF_DTABLE_SIZE(maxTableLog)] = { ((U32)(maxTableLog) * 0x01000001) }
 
-
 /* ****************************************
 *  Advanced decompression functions
 ******************************************/
@@ -166,7 +158,6 @@ size_t HUF_decompress4X2_DCtx(HUF_DTable* dctx, void* dst, size_t dstSize, const
 size_t HUF_decompress4X2_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dstSize, const void* cSrc, size_t cSrcSize, void* workSpace, size_t wkspSize);   /*< double-symbols decoder */
 #endif
 
-
 /* ****************************************
  *  HUF detailed API
  * ****************************************/
@@ -293,7 +284,6 @@ size_t HUF_decompress4X1_usingDTable(void* dst, size_t maxDstSize, const void* c
 size_t HUF_decompress4X2_usingDTable(void* dst, size_t maxDstSize, const void* cSrc, size_t cSrcSize, const HUF_DTable* DTable);
 #endif
 
-
 /* ====================== */
 /* single stream variants */
 /* ====================== */
diff --git a/lib/zstd/common/portability_macros.h b/lib/zstd/common/portability_macros.h
index 0e3b2c0a527..b1cb945f275 100644
--- a/lib/zstd/common/portability_macros.h
+++ b/lib/zstd/common/portability_macros.h
@@ -20,7 +20,6 @@
  *
  */
 
-
 /* compat. with non-clang compilers */
 #ifndef __has_attribute
   #define __has_attribute(x) 0
diff --git a/lib/zstd/common/zstd_common.c b/lib/zstd/common/zstd_common.c
index 3d7e35b309b..17df097dcd5 100644
--- a/lib/zstd/common/zstd_common.c
+++ b/lib/zstd/common/zstd_common.c
@@ -8,8 +8,6 @@
  * You may select, at your option, one of the above-listed licenses.
  */
 
-
-
 /*-*************************************
 *  Dependencies
 ***************************************/
@@ -18,7 +16,6 @@
 #include "error_private.h"
 #include "zstd_internal.h"
 
-
 /*-****************************************
 *  Version
 ******************************************/
@@ -26,7 +23,6 @@ unsigned ZSTD_versionNumber(void) { return ZSTD_VERSION_NUMBER; }
 
 const char* ZSTD_versionString(void) { return ZSTD_VERSION_STRING; }
 
-
 /*-****************************************
 *  ZSTD Error Management
 ******************************************/
@@ -48,8 +44,6 @@ ZSTD_ErrorCode ZSTD_getErrorCode(size_t code) { return ERR_getErrorCode(code); }
  *  provides error code string from enum */
 const char* ZSTD_getErrorString(ZSTD_ErrorCode code) { return ERR_getErrorString(code); }
 
-
-
 /*=**************************************************************
 *  Custom allocator
 ****************************************************************/
diff --git a/lib/zstd/common/zstd_internal.h b/lib/zstd/common/zstd_internal.h
index 93305d9b41b..c575c1fe8f4 100644
--- a/lib/zstd/common/zstd_internal.h
+++ b/lib/zstd/common/zstd_internal.h
@@ -33,14 +33,12 @@
 #include <linux/xxhash.h>                /* XXH_reset, update, digest */
 #define ZSTD_TRACE 0
 
-
 /* ---- static assert (debug) --- */
 #define ZSTD_STATIC_ASSERT(c) DEBUG_STATIC_ASSERT(c)
 #define ZSTD_isError ERR_isError   /* for inlining */
 #define FSE_isError  ERR_isError
 #define HUF_isError  ERR_isError
 
-
 /*-*************************************
 *  shared macros
 ***************************************/
@@ -50,7 +48,6 @@
 #define MAX(a,b) ((a)>(b) ? (a) : (b))
 #define BOUNDED(min,val,max) (MAX(min,MIN(val,max)))
 
-
 /*-*************************************
 *  Common constants
 ***************************************/
@@ -155,7 +152,6 @@ static UNUSED_ATTR const S16 OF_defaultNorm[DefaultMaxOff+1] = {
 #define OF_DEFAULTNORMLOG 5  /* for static allocation */
 static UNUSED_ATTR const U32 OF_defaultNormLog = OF_DEFAULTNORMLOG;
 
-
 /*-*******************************************
 *  Shared functions to include for inlining
 *********************************************/
@@ -269,7 +265,6 @@ typedef enum {
     ZSTD_bm_stable = 1     /* ZSTD_inBuffer/ZSTD_outBuffer is stable */
 } ZSTD_bufferMode_e;
 
-
 /*-*******************************************
 *  Private declarations
 *********************************************/
@@ -349,7 +344,6 @@ void* ZSTD_customMalloc(size_t size, ZSTD_customMem customMem);
 void* ZSTD_customCalloc(size_t size, ZSTD_customMem customMem);
 void ZSTD_customFree(void* ptr, ZSTD_customMem customMem);
 
-
 MEM_STATIC U32 ZSTD_highbit32(U32 val)   /* compress, dictBuilder, decodeCorpus */
 {
     assert(val != 0);
@@ -404,14 +398,12 @@ MEM_STATIC unsigned ZSTD_countTrailingZeros(size_t val)
     }
 }
 
-
 /* ZSTD_invalidateRepCodes() :
  * ensures next compression will not use repcodes from previous block.
  * Note : only works with regular variant;
  *        do not use with extDict variant ! */
 void ZSTD_invalidateRepCodes(ZSTD_CCtx* cctx);   /* zstdmt, adaptive_compression (shouldn't get this definition from here) */
 
-
 typedef struct {
     blockType_e blockType;
     U32 lastBlock;
@@ -439,5 +431,4 @@ MEM_STATIC int ZSTD_cpuSupportsBmi2(void)
     return ZSTD_cpuid_bmi1(cpuid) && ZSTD_cpuid_bmi2(cpuid);
 }
 
-
 #endif   /* ZSTD_CCOMMON_H_MODULE */
diff --git a/lib/zstd/decompress/huf_decompress.c b/lib/zstd/decompress/huf_decompress.c
index 89b269a641c..e2d473ad4e8 100644
--- a/lib/zstd/decompress/huf_decompress.c
+++ b/lib/zstd/decompress/huf_decompress.c
@@ -69,14 +69,12 @@
 ****************************************************************/
 #define HUF_isError ERR_isError
 
-
 /* **************************************************************
 *  Byte alignment for workSpace management
 ****************************************************************/
 #define HUF_ALIGN(x, a)         HUF_ALIGN_MASK((x), (a) - 1)
 #define HUF_ALIGN_MASK(x, mask) (((x) + (mask)) & ~(mask))
 
-
 /* **************************************************************
 *  BMI2 Variant Wrappers
 ****************************************************************/
@@ -121,7 +119,6 @@
 
 #endif
 
-
 /*-***************************/
 /*  generic DTableDesc       */
 /*-***************************/
@@ -268,7 +265,6 @@ static size_t HUF_initRemainingDStream(BIT_DStream_t* bit, HUF_DecompressAsmArgs
 }
 #endif
 
-
 #ifndef HUF_FORCE_DECOMPRESS_X2
 
 /*-***************************/
@@ -329,7 +325,6 @@ typedef struct {
         BYTE huffWeight[HUF_SYMBOLVALUE_MAX + 1];
 } HUF_ReadDTableX1_Workspace;
 
-
 size_t HUF_readDTableX1_wksp(HUF_DTable* DTable, const void* src, size_t srcSize, void* workSpace, size_t wkspSize)
 {
     return HUF_readDTableX1_wksp_bmi2(DTable, src, srcSize, workSpace, wkspSize, /* bmi2 */ 0);
@@ -353,7 +348,6 @@ size_t HUF_readDTableX1_wksp_bmi2(HUF_DTable* DTable, const void* src, size_t sr
     iSize = HUF_readStats_wksp(wksp->huffWeight, HUF_SYMBOLVALUE_MAX + 1, wksp->rankVal, &nbSymbols, &tableLog, src, srcSize, wksp->statsWksp, sizeof(wksp->statsWksp), bmi2);
     if (HUF_isError(iSize)) return iSize;
 
-
     /* Table header */
     {   DTableDesc dtd = HUF_getDTableDesc(DTable);
         U32 const maxTableLog = dtd.maxTableLog + 1;
@@ -745,7 +739,6 @@ static size_t HUF_decompress4X1_usingDTable_internal(void* dst, size_t dstSize,
 #endif
 }
 
-
 size_t HUF_decompress1X1_usingDTable(
           void* dst,  size_t dstSize,
     const void* cSrc, size_t cSrcSize,
@@ -770,7 +763,6 @@ size_t HUF_decompress1X1_DCtx_wksp(HUF_DTable* DCtx, void* dst, size_t dstSize,
     return HUF_decompress1X1_usingDTable_internal(dst, dstSize, ip, cSrcSize, DCtx, /* bmi2 */ 0);
 }
 
-
 size_t HUF_decompress4X1_usingDTable(
           void* dst,  size_t dstSize,
     const void* cSrc, size_t cSrcSize,
@@ -802,10 +794,8 @@ size_t HUF_decompress4X1_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dstSize,
     return HUF_decompress4X1_DCtx_wksp_bmi2(dctx, dst, dstSize, cSrc, cSrcSize, workSpace, wkspSize, 0);
 }
 
-
 #endif /* HUF_FORCE_DECOMPRESS_X2 */
 
-
 #ifndef HUF_FORCE_DECOMPRESS_X1
 
 /* *************************/
@@ -1130,7 +1120,6 @@ size_t HUF_readDTableX2_wksp_bmi2(HUF_DTable* DTable,
     return iSize;
 }
 
-
 FORCE_INLINE_TEMPLATE U32
 HUF_decodeSymbolX2(void* op, BIT_DStream_t* DStream, const HUF_DEltX2* dt, const U32 dtLog)
 {
@@ -1477,7 +1466,6 @@ size_t HUF_decompress1X2_DCtx_wksp(HUF_DTable* DCtx, void* dst, size_t dstSize,
     return HUF_decompress1X2_usingDTable_internal(dst, dstSize, ip, cSrcSize, DCtx, /* bmi2 */ 0);
 }
 
-
 size_t HUF_decompress4X2_usingDTable(
           void* dst,  size_t dstSize,
     const void* cSrc, size_t cSrcSize,
@@ -1510,10 +1498,8 @@ size_t HUF_decompress4X2_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dstSize,
     return HUF_decompress4X2_DCtx_wksp_bmi2(dctx, dst, dstSize, cSrc, cSrcSize, workSpace, wkspSize, /* bmi2 */ 0);
 }
 
-
 #endif /* HUF_FORCE_DECOMPRESS_X1 */
 
-
 /* ***********************************/
 /* Universal decompression selectors */
 /* ***********************************/
@@ -1556,7 +1542,6 @@ size_t HUF_decompress4X_usingDTable(void* dst, size_t maxDstSize,
 #endif
 }
 
-
 #if !defined(HUF_FORCE_DECOMPRESS_X1) && !defined(HUF_FORCE_DECOMPRESS_X2)
 typedef struct { U32 tableTime; U32 decode256Time; } algo_time_t;
 static const algo_time_t algoTime[16 /* Quantization */][2 /* single, double */] =
@@ -1610,7 +1595,6 @@ U32 HUF_selectDecoder (size_t dstSize, size_t cSrcSize)
 #endif
 }
 
-
 size_t HUF_decompress4X_hufOnly_wksp(HUF_DTable* dctx, void* dst,
                                      size_t dstSize, const void* cSrc,
                                      size_t cSrcSize, void* workSpace,
@@ -1667,7 +1651,6 @@ size_t HUF_decompress1X_DCtx_wksp(HUF_DTable* dctx, void* dst, size_t dstSize,
     }
 }
 
-
 size_t HUF_decompress1X_usingDTable_bmi2(void* dst, size_t maxDstSize, const void* cSrc, size_t cSrcSize, const HUF_DTable* DTable, int bmi2)
 {
     DTableDesc const dtd = HUF_getDTableDesc(DTable);
diff --git a/lib/zstd/decompress/zstd_ddict.c b/lib/zstd/decompress/zstd_ddict.c
index dbbc7919de5..db6aa722966 100644
--- a/lib/zstd/decompress/zstd_ddict.c
+++ b/lib/zstd/decompress/zstd_ddict.c
@@ -24,9 +24,6 @@
 #include "zstd_decompress_internal.h"
 #include "zstd_ddict.h"
 
-
-
-
 /*-*******************************************************
 *  Types
 *********************************************************/
@@ -82,7 +79,6 @@ void ZSTD_copyDDictParameters(ZSTD_DCtx* dctx, const ZSTD_DDict* ddict)
     }
 }
 
-
 static size_t
 ZSTD_loadEntropy_intoDDict(ZSTD_DDict* ddict,
                            ZSTD_dictContentType_e dictContentType)
@@ -113,7 +109,6 @@ ZSTD_loadEntropy_intoDDict(ZSTD_DDict* ddict,
     return 0;
 }
 
-
 static size_t ZSTD_initDDict_internal(ZSTD_DDict* ddict,
                                       const void* dict, size_t dictSize,
                                       ZSTD_dictLoadMethod_e dictLoadMethod,
@@ -180,7 +175,6 @@ ZSTD_DDict* ZSTD_createDDict_byReference(const void* dictBuffer, size_t dictSize
     return ZSTD_createDDict_advanced(dictBuffer, dictSize, ZSTD_dlm_byRef, ZSTD_dct_auto, allocator);
 }
 
-
 const ZSTD_DDict* ZSTD_initStaticDDict(
                                 void* sBuffer, size_t sBufferSize,
                                 const void* dict, size_t dictSize,
@@ -205,7 +199,6 @@ const ZSTD_DDict* ZSTD_initStaticDDict(
     return ddict;
 }
 
-
 size_t ZSTD_freeDDict(ZSTD_DDict* ddict)
 {
     if (ddict==NULL) return 0;   /* support free on NULL */
diff --git a/lib/zstd/decompress/zstd_ddict.h b/lib/zstd/decompress/zstd_ddict.h
index 8c1a79d666f..2ad60da2c4f 100644
--- a/lib/zstd/decompress/zstd_ddict.h
+++ b/lib/zstd/decompress/zstd_ddict.h
@@ -8,7 +8,6 @@
  * You may select, at your option, one of the above-listed licenses.
  */
 
-
 #ifndef ZSTD_DDICT_H
 #define ZSTD_DDICT_H
 
@@ -18,7 +17,6 @@
 #include "../common/zstd_deps.h"   /* size_t */
 #include <linux/zstd.h>     /* ZSTD_DDict, and several public functions */
 
-
 /*-*******************************************************
  *  Interface
  *********************************************************/
@@ -39,6 +37,4 @@ size_t ZSTD_DDict_dictSize(const ZSTD_DDict* ddict);
 
 void ZSTD_copyDDictParameters(ZSTD_DCtx* dctx, const ZSTD_DDict* ddict);
 
-
-
 #endif /* ZSTD_DDICT_H */
diff --git a/lib/zstd/decompress/zstd_decompress.c b/lib/zstd/decompress/zstd_decompress.c
index b9b935a9f5c..6537824629c 100644
--- a/lib/zstd/decompress/zstd_decompress.c
+++ b/lib/zstd/decompress/zstd_decompress.c
@@ -8,7 +8,6 @@
  * You may select, at your option, one of the above-listed licenses.
  */
 
-
 /* ***************************************************************
 *  Tuning parameters
 *****************************************************************/
@@ -48,7 +47,6 @@
 #  define ZSTD_NO_FORWARD_PROGRESS_MAX 16
 #endif
 
-
 /*-*******************************************************
 *  Dependencies
 *********************************************************/
@@ -64,9 +62,6 @@
 #include "zstd_ddict.h"  /* ZSTD_DDictDictContent */
 #include "zstd_decompress_block.h"   /* ZSTD_decompressBlock_internal */
 
-
-
-
 /* ***********************************
  * Multiple DDicts Hashset internals *
  *************************************/
@@ -220,7 +215,6 @@ size_t ZSTD_sizeof_DCtx (const ZSTD_DCtx* dctx)
 
 size_t ZSTD_estimateDCtxSize(void) { return sizeof(ZSTD_DCtx); }
 
-
 static size_t ZSTD_startingInputLength(ZSTD_format_e format)
 {
     size_t const startingInputLength = ZSTD_FRAMEHEADERSIZE_PREFIX(format);
@@ -353,7 +347,6 @@ static void ZSTD_DCtx_selectFrameDDict(ZSTD_DCtx* dctx) {
     }
 }
 
-
 /*-*************************************************************
  *   Frame header decoding
  ***************************************************************/
@@ -415,7 +408,6 @@ size_t ZSTD_frameHeaderSize(const void* src, size_t srcSize)
     return ZSTD_frameHeaderSize_internal(src, srcSize, ZSTD_f_zstd1);
 }
 
-
 /* ZSTD_getFrameHeader_advanced() :
  *  decode Frame Header, or require larger `srcSize`.
  *  note : only works for formats ZSTD_f_zstd1 and ZSTD_f_zstd1_magicless
@@ -639,7 +631,6 @@ unsigned long long ZSTD_getDecompressedSize(const void* src, size_t srcSize)
     return (ret >= ZSTD_CONTENTSIZE_ERROR) ? 0 : ret;
 }
 
-
 /* ZSTD_decodeFrameHeader() :
  * `headerSize` must be the size provided by ZSTD_frameHeaderSize().
  * If multiple DDict references are enabled, also will choose the correct DDict to use.
@@ -681,7 +672,6 @@ static ZSTD_frameSizeInfo ZSTD_findFrameSizeInfo(const void* src, size_t srcSize
     ZSTD_frameSizeInfo frameSizeInfo;
     ZSTD_memset(&frameSizeInfo, 0, sizeof(ZSTD_frameSizeInfo));
 
-
     if ((srcSize >= ZSTD_SKIPPABLEHEADERSIZE)
         && (MEM_readLE32(src) & ZSTD_MAGIC_SKIPPABLE_MASK) == ZSTD_MAGIC_SKIPPABLE_START) {
         frameSizeInfo.compressedSize = readSkippableFrameSize(src, srcSize);
@@ -773,7 +763,6 @@ unsigned long long ZSTD_decompressBound(const void* src, size_t srcSize)
     return bound;
 }
 
-
 /*-*************************************************************
  *   Frame decoding
  ***************************************************************/
@@ -788,7 +777,6 @@ size_t ZSTD_insertBlock(ZSTD_DCtx* dctx, const void* blockStart, size_t blockSiz
     return blockSize;
 }
 
-
 static size_t ZSTD_copyRawBlock(void* dst, size_t dstCapacity,
                           const void* src, size_t srcSize)
 {
@@ -823,7 +811,6 @@ static void ZSTD_DCtx_trace_end(ZSTD_DCtx const* dctx, U64 uncompressedSize, U64
     (void)streaming;
 }
 
-
 /*! ZSTD_decompressFrame() :
  * @dctx must be properly initialized
  *  will update *srcPtr and *srcSizePtr,
@@ -935,7 +922,6 @@ static size_t ZSTD_decompressMultiFrame(ZSTD_DCtx* dctx,
 
     while (srcSize >= ZSTD_startingInputLength(dctx->format)) {
 
-
         {   U32 const magicNumber = MEM_readLE32(src);
             DEBUGLOG(4, "reading magic number %08X (expecting %08X)",
                         (unsigned)magicNumber, ZSTD_MAGICNUMBER);
@@ -994,7 +980,6 @@ size_t ZSTD_decompress_usingDict(ZSTD_DCtx* dctx,
     return ZSTD_decompressMultiFrame(dctx, dst, dstCapacity, src, srcSize, dict, dictSize, NULL);
 }
 
-
 static ZSTD_DDict const* ZSTD_getDDict(ZSTD_DCtx* dctx)
 {
     switch (dctx->dictUses) {
@@ -1017,7 +1002,6 @@ size_t ZSTD_decompressDCtx(ZSTD_DCtx* dctx, void* dst, size_t dstCapacity, const
     return ZSTD_decompress_usingDDict(dctx, dst, dstCapacity, src, srcSize, ZSTD_getDDict(dctx));
 }
 
-
 size_t ZSTD_decompress(void* dst, size_t dstCapacity, const void* src, size_t srcSize)
 {
 #if defined(ZSTD_HEAPMODE) && (ZSTD_HEAPMODE>=1)
@@ -1034,7 +1018,6 @@ size_t ZSTD_decompress(void* dst, size_t dstCapacity, const void* src, size_t sr
 #endif
 }
 
-
 /*-**************************************
 *   Advanced Streaming Decompression API
 *   Bufferless and synchronous
@@ -1247,7 +1230,6 @@ size_t ZSTD_decompressContinue(ZSTD_DCtx* dctx, void* dst, size_t dstCapacity, c
     }
 }
 
-
 static size_t ZSTD_refDictContent(ZSTD_DCtx* dctx, const void* dict, size_t dictSize)
 {
     dctx->dictEnd = dctx->previousDstEnd;
@@ -1407,7 +1389,6 @@ size_t ZSTD_decompressBegin_usingDict(ZSTD_DCtx* dctx, const void* dict, size_t
     return 0;
 }
 
-
 /* ======   ZSTD_DDict   ====== */
 
 size_t ZSTD_decompressBegin_usingDDict(ZSTD_DCtx* dctx, const ZSTD_DDict* ddict)
@@ -1461,7 +1442,6 @@ unsigned ZSTD_getDictID_fromFrame(const void* src, size_t srcSize)
     return zfp.dictID;
 }
 
-
 /*! ZSTD_decompress_usingDDict() :
 *   Decompression using a pre-digested Dictionary
 *   Use dictionary without significant overhead. */
@@ -1476,7 +1456,6 @@ size_t ZSTD_decompress_usingDDict(ZSTD_DCtx* dctx,
                                      ddict);
 }
 
-
 /*=====================================
 *   Streaming decompression
 *====================================*/
@@ -1502,7 +1481,6 @@ size_t ZSTD_freeDStream(ZSTD_DStream* zds)
     return ZSTD_freeDCtx(zds);
 }
 
-
 /* ***  Initialization  *** */
 
 size_t ZSTD_DStreamInSize(void)  { return ZSTD_BLOCKSIZE_MAX + ZSTD_blockHeaderSize; }
@@ -1546,7 +1524,6 @@ size_t ZSTD_DCtx_refPrefix(ZSTD_DCtx* dctx, const void* prefix, size_t prefixSiz
     return ZSTD_DCtx_refPrefix_advanced(dctx, prefix, prefixSize, ZSTD_dct_rawContent);
 }
 
-
 /* ZSTD_initDStream_usingDict() :
  * return : expected size, aka ZSTD_startingInputLength().
  * this function cannot fail */
@@ -1584,7 +1561,6 @@ size_t ZSTD_resetDStream(ZSTD_DStream* dctx)
     return ZSTD_startingInputLength(dctx->format);
 }
 
-
 size_t ZSTD_DCtx_refDDict(ZSTD_DCtx* dctx, const ZSTD_DDict* ddict)
 {
     RETURN_ERROR_IF(dctx->streamStage != zdss_init, stage_wrong, "");
@@ -1745,7 +1721,6 @@ size_t ZSTD_DCtx_reset(ZSTD_DCtx* dctx, ZSTD_ResetDirective reset)
     return 0;
 }
 
-
 size_t ZSTD_sizeof_DStream(const ZSTD_DStream* dctx)
 {
     return ZSTD_sizeof_DCtx(dctx);
@@ -1783,7 +1758,6 @@ size_t ZSTD_estimateDStreamSize_fromFrame(const void* src, size_t srcSize)
     return ZSTD_estimateDStreamSize((size_t)zfh.windowSize);
 }
 
-
 /* *****   Decompression   ***** */
 
 static int ZSTD_DCtx_isOverflow(ZSTD_DStream* zds, size_t const neededInBuffSize, size_t const neededOutBuffSize)
diff --git a/lib/zstd/decompress/zstd_decompress_block.c b/lib/zstd/decompress/zstd_decompress_block.c
index c1913b8e7c8..6e46a1bc524 100644
--- a/lib/zstd/decompress/zstd_decompress_block.c
+++ b/lib/zstd/decompress/zstd_decompress_block.c
@@ -40,13 +40,11 @@
 #error "Cannot force the use of the short and the long ZSTD_decompressSequences variants!"
 #endif
 
-
 /*_*******************************************************
 *  Memory operations
 **********************************************************/
 static void ZSTD_copy4(void* dst, const void* src) { ZSTD_memcpy(dst, src, 4); }
 
-
 /*-*************************************************************
  *   Block decoding
  ***************************************************************/
@@ -379,7 +377,6 @@ static const ZSTD_seqSymbol OF_defaultDTable[(1<<OF_DEFAULTNORMLOG)+1] = {
     {  0, 25,  5,33554429},  {  0, 24,  5,16777213},
 };   /* OF_defaultDTable */
 
-
 /* Default FSE distribution table for Match Lengths */
 static const ZSTD_seqSymbol ML_defaultDTable[(1<<ML_DEFAULTNORMLOG)+1] = {
     {  1,  1,  1, ML_DEFAULTNORMLOG},  /* header : fastMode, tableLog */
@@ -418,7 +415,6 @@ static const ZSTD_seqSymbol ML_defaultDTable[(1<<ML_DEFAULTNORMLOG)+1] = {
     {  0, 11,  6, 2051},  {  0, 10,  6, 1027},
 };   /* ML_defaultDTable */
 
-
 static void ZSTD_buildSeqTable_rle(ZSTD_seqSymbol* dt, U32 baseValue, U8 nbAddBits)
 {
     void* ptr = dt;
@@ -435,7 +431,6 @@ static void ZSTD_buildSeqTable_rle(ZSTD_seqSymbol* dt, U32 baseValue, U8 nbAddBi
     cell->baseValue = baseValue;
 }
 
-
 /* ZSTD_buildFSETable() :
  * generate FSE decoding table for one symbol (ll, ml or off)
  * cannot fail if input is valid =>
@@ -454,7 +449,6 @@ void ZSTD_buildFSETable_body(ZSTD_seqSymbol* dt,
     BYTE* spread = (BYTE*)(symbolNext + MaxSeq + 1);
     U32 highThreshold = tableSize - 1;
 
-
     /* Sanity Checks */
     assert(maxSymbolValue <= MaxSeq);
     assert(tableLog <= MaxFSELog);
@@ -598,7 +592,6 @@ void ZSTD_buildFSETable(ZSTD_seqSymbol* dt,
             baseValue, nbAdditionalBits, tableLog, wksp, wkspSize);
 }
 
-
 /*! ZSTD_buildSeqTable() :
  * @return : nb bytes read from src,
  *           or an error code if it fails */
@@ -729,7 +722,6 @@ size_t ZSTD_decodeSeqHeaders(ZSTD_DCtx* dctx, int* nbSeqPtr,
     return ip-istart;
 }
 
-
 typedef struct {
     size_t litLength;
     size_t matchLength;
@@ -915,7 +907,6 @@ size_t ZSTD_execSequenceEndSplitLitBuffer(BYTE* op,
     const BYTE* const iLitEnd = *litPtr + sequence.litLength;
     const BYTE* match = oLitEnd - sequence.offset;
 
-
     /* bounds checks : careful of address space overflow in 32-bit mode */
     RETURN_ERROR_IF(sequenceLength > (size_t)(oend - op), dstSize_tooSmall, "last match must fit within dstBuffer");
     RETURN_ERROR_IF(sequence.litLength > (size_t)(litLimit - *litPtr), corruption_detected, "try to read beyond literal buffer");
@@ -1133,7 +1124,6 @@ size_t ZSTD_execSequenceSplitLitBuffer(BYTE* op,
     return sequenceLength;
 }
 
-
 static void
 ZSTD_initFseState(ZSTD_fseState* DStatePtr, BIT_DStream_t* bitD, const ZSTD_seqSymbol* dt)
 {
@@ -1316,7 +1306,6 @@ MEM_STATIC void ZSTD_assertValidSequence(
 
 #ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG
 
-
 FORCE_INLINE_TEMPLATE size_t
 DONT_VECTORIZE
 ZSTD_decompressSequences_bodySplitLitBuffer( ZSTD_DCtx* dctx,
@@ -1841,8 +1830,6 @@ ZSTD_decompressSequencesLong_default(ZSTD_DCtx* dctx,
 }
 #endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT */
 
-
-
 #if DYNAMIC_BMI2
 
 #ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG
@@ -1920,7 +1907,6 @@ ZSTD_decompressSequencesSplitLitBuffer(ZSTD_DCtx* dctx, void* dst, size_t maxDst
 }
 #endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG */
 
-
 #ifndef ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT
 /* ZSTD_decompressSequencesLong() :
  * decompression function triggered when a minimum share of offsets is considered "long",
@@ -1944,8 +1930,6 @@ ZSTD_decompressSequencesLong(ZSTD_DCtx* dctx,
 }
 #endif /* ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT */
 
-
-
 #if !defined(ZSTD_FORCE_DECOMPRESS_SEQUENCES_SHORT) && \
     !defined(ZSTD_FORCE_DECOMPRESS_SEQUENCES_LONG)
 /* ZSTD_getLongOffsetsShare() :
@@ -2048,7 +2032,6 @@ ZSTD_decompressBlock_internal(ZSTD_DCtx* dctx,
     }
 }
 
-
 void ZSTD_checkContinuity(ZSTD_DCtx* dctx, const void* dst, size_t dstSize)
 {
     if (dst != dctx->previousDstEnd && dstSize > 0) {   /* not contiguous */
@@ -2059,7 +2042,6 @@ void ZSTD_checkContinuity(ZSTD_DCtx* dctx, const void* dst, size_t dstSize)
     }
 }
 
-
 size_t ZSTD_decompressBlock(ZSTD_DCtx* dctx,
                             void* dst, size_t dstCapacity,
                       const void* src, size_t srcSize)
diff --git a/lib/zstd/decompress/zstd_decompress_block.h b/lib/zstd/decompress/zstd_decompress_block.h
index 3d2d57a5d25..b8e912c6fd8 100644
--- a/lib/zstd/decompress/zstd_decompress_block.h
+++ b/lib/zstd/decompress/zstd_decompress_block.h
@@ -8,7 +8,6 @@
  * You may select, at your option, one of the above-listed licenses.
  */
 
-
 #ifndef ZSTD_DEC_BLOCK_H
 #define ZSTD_DEC_BLOCK_H
 
@@ -20,7 +19,6 @@
 #include "../common/zstd_internal.h"  /* blockProperties_t, and some public functions */
 #include "zstd_decompress_internal.h"  /* ZSTD_seqSymbol */
 
-
 /* ===   Prototypes   === */
 
 /* note: prototypes already published within `zstd.h` :
@@ -32,7 +30,6 @@
  * ZSTD_decodeSeqHeaders()
  */
 
-
  /* Streaming state is used to inform allocation of the literal buffer */
 typedef enum {
     not_streaming = 0,
@@ -64,5 +61,4 @@ void ZSTD_buildFSETable(ZSTD_seqSymbol* dt,
                    unsigned tableLog, void* wksp, size_t wkspSize,
                    int bmi2);
 
-
 #endif /* ZSTD_DEC_BLOCK_H */
diff --git a/lib/zstd/decompress/zstd_decompress_internal.h b/lib/zstd/decompress/zstd_decompress_internal.h
index 98102edb6a8..e165cbe9f59 100644
--- a/lib/zstd/decompress/zstd_decompress_internal.h
+++ b/lib/zstd/decompress/zstd_decompress_internal.h
@@ -8,22 +8,18 @@
  * You may select, at your option, one of the above-listed licenses.
  */
 
-
 /* zstd_decompress_internal:
  * objects and definitions shared within lib/decompress modules */
 
  #ifndef ZSTD_DECOMPRESS_INTERNAL_H
  #define ZSTD_DECOMPRESS_INTERNAL_H
 
-
 /*-*******************************************************
  *  Dependencies
  *********************************************************/
 #include "../common/mem.h"             /* BYTE, U16, U32 */
 #include "../common/zstd_internal.h"   /* constants : MaxLL, MaxML, MaxOff, LLFSELog, etc. */
 
-
-
 /*-*******************************************************
  *  Constants
  *********************************************************/
@@ -55,7 +51,6 @@ static UNUSED_ATTR const U32 ML_base[MaxML+1] = {
                     67, 83, 99, 0x83, 0x103, 0x203, 0x403, 0x803,
                     0x1003, 0x2003, 0x4003, 0x8003, 0x10003 };
 
-
 /*-*******************************************************
  *  Decompression types
  *********************************************************/
@@ -224,5 +219,4 @@ size_t ZSTD_loadDEntropy(ZSTD_entropyDTables_t* entropy,
  *  This function cannot fail. */
 void ZSTD_checkContinuity(ZSTD_DCtx* dctx, const void* dst, size_t dstSize);
 
-
 #endif /* ZSTD_DECOMPRESS_INTERNAL_H */
-- 
2.43.0

