Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21E0C3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 10:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C433888614;
	Tue,  9 Jul 2024 12:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90771885E4; Tue,  9 Jul 2024 12:32:05 +0200 (CEST)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26AA18864A
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 12:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4WJHNb11hwz9sSr;
 Tue,  9 Jul 2024 12:31:59 +0200 (CEST)
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u87wvLZJJTrr; Tue,  9 Jul 2024 12:31:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4WJHNW0TfHz9sSv;
 Tue,  9 Jul 2024 12:31:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id F3DCD8B76D;
 Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QCfinmcLX7ra; Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.243])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D1DE8B775;
 Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michal Simek <michal.simek@amd.com>,
	Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH 6/6] zlib: Remove incorrect ZLIB_VERSION
Date: Tue,  9 Jul 2024 12:31:18 +0200
Message-ID: <6a0ce97c47cf30d0d166d9f4bdc1ef8c622d231e.1720521011.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1720521011.git.christophe.leroy@csgroup.eu>
References: <cover.1720521011.git.christophe.leroy@csgroup.eu>
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

From: Michal Simek <michal.simek@amd.com>

Get rid of zlib version which is not correct because of U-Boot related
changes and various CVE backports.

The change in inspired by Linux kernel commit 4f3865fb57a0 ("[PATCH]
zlib_inflate: Upgrade library code to a recent version") which described
ZLIB_VERSION removal as

"This patch also removes ZLIB_VERSION as it no longer has a correct value.
We don't need version checks anyway as the kernel's module handling will
take care of that for us.  This removal is also more in keeping with the
zlib author's wishes (http://www.zlib.net/zlib_faq.html#faq24) and I've
added something to the zlib.h header to note its a modified version."

Author describes wish to follow this guidance at
https://www.zlib.net/zlib_faq.html#faq24:
"The license says that altered source versions must be "plainly marked". So
what exactly do I need to do to meet that requirement?

You need to change the ZLIB_VERSION and ZLIB_VERNUM #defines in zlib.h. In
particular, the final version number needs to be changed to f, and an
identification string should be appended to ZLIB_VERSION. Version numbers
x.x.x.f are reserved for modifications to zlib by others than the zlib
maintainers. For example, if the version of the base zlib you are altering
is 1.2.3.4, then in zlib.h you should change ZLIB_VERNUM to 0x123f, and
ZLIB_VERSION to something like 1.2.3.f-zachary-mods-v3. You can also update
the version strings in deflate.c and inftrees.c."

But U-Boot is not exact version that's why following the same style which
has been used by Linux kernel where ZLIB_VERSION is completely removed.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 include/u-boot/zlib.h | 16 ++++++----------
 lib/gzip.c            |  2 +-
 lib/zlib/deflate.c    | 13 +++----------
 lib/zlib/inflate.c    |  9 +++------
 lib/zlib/zutil.c      |  1 -
 5 files changed, 13 insertions(+), 28 deletions(-)

diff --git a/include/u-boot/zlib.h b/include/u-boot/zlib.h
index a33cc8780d..ee19f46095 100644
--- a/include/u-boot/zlib.h
+++ b/include/u-boot/zlib.h
@@ -49,9 +49,6 @@
 extern "C" {
 #endif
 
-#define ZLIB_VERSION "1.2.3"
-#define ZLIB_VERNUM 0x1230
-
 /* #include "zconf.h" */        /* included directly here */
 /* zconf.h -- configuration of the zlib compression library
  * Copyright (C) 1995-2005 Jean-loup Gailly.
@@ -484,7 +481,6 @@ typedef gz_header FAR *gz_headerp;
 #define Z_DATA_ERROR   (-3)
 #define Z_MEM_ERROR    (-4)
 #define Z_BUF_ERROR    (-5)
-#define Z_VERSION_ERROR (-6)
 /* Return codes for the compression/decompression functions. Negative
  * values are errors, positive values are used for special but normal events.
  */
@@ -523,11 +519,11 @@ typedef gz_header FAR *gz_headerp;
 
 ZEXTERN int ZEXPORT deflate OF((z_streamp strm, int flush));
 ZEXTERN int ZEXPORT deflateInit_ OF((z_streamp strm, int level,
-			const char *version, int stream_size));
+			int stream_size));
 ZEXTERN int ZEXPORT deflateEnd OF((z_streamp strm));
 ZEXTERN int ZEXPORT deflateInit2_ OF((z_streamp strm, int  level, int  method,
 			int windowBits, int memLevel,
-			int strategy, const char *version,
+			int strategy,
 			int stream_size));
 ZEXTERN int ZEXPORT deflateReset OF((z_streamp strm));
 ZEXTERN int ZEXPORT deflateSetDictionary OF((z_streamp strm,
@@ -553,7 +549,7 @@ ZEXTERN int ZEXPORT deflateCopy OF((z_streamp dest,
 
 
 ZEXTERN int ZEXPORT inflateInit_ OF((z_streamp strm,
-			const char *version, int stream_size));
+			int stream_size));
 ZEXTERN int ZEXPORT inflate OF((z_streamp strm, int flush));
 /*
     inflate decompresses as much data as possible, and stops when the input
@@ -743,11 +739,11 @@ ZEXTERN int ZEXPORT uncompress2 OF((Bytef *dest, uLongf *destLen,
 */
 
 ZEXTERN int ZEXPORT inflateInit2_ OF((z_streamp strm, int  windowBits,
-                                      const char *version, int stream_size));
+                                      int stream_size));
 #define inflateInit(strm) \
-	inflateInit_((strm), ZLIB_VERSION, sizeof(z_stream))
+	inflateInit_((strm), sizeof(z_stream))
 #define inflateInit2(strm, windowBits) \
-	inflateInit2_((strm), (windowBits), ZLIB_VERSION, sizeof(z_stream))
+	inflateInit2_((strm), (windowBits), sizeof(z_stream))
 
 #if !defined(ZUTIL_H) && !defined(NO_DUMMY_DECL)
 	struct internal_state {int dummy;}; /* hack for buggy compilers */
diff --git a/lib/gzip.c b/lib/gzip.c
index 5d9c19598d..a9a3df524d 100644
--- a/lib/gzip.c
+++ b/lib/gzip.c
@@ -67,7 +67,7 @@ int zzip(void *dst, unsigned long *lenp, unsigned char *src,
 
 	r = deflateInit2_(&s, Z_BEST_SPEED, Z_DEFLATED,	window,
 			DEF_MEM_LEVEL, Z_DEFAULT_STRATEGY,
-			ZLIB_VERSION, sizeof(z_stream));
+			sizeof(z_stream));
 	if (r != Z_OK) {
 		printf ("Error: deflateInit2_() returned %d\n", r);
 		return -1;
diff --git a/lib/zlib/deflate.c b/lib/zlib/deflate.c
index 4549f4dc12..7e1ed4f9b2 100644
--- a/lib/zlib/deflate.c
+++ b/lib/zlib/deflate.c
@@ -196,37 +196,30 @@ struct static_tree_desc_s {int dummy;}; /* for buggy compilers */
     zmemzero((Bytef *)s->head, (unsigned)(s->hash_size-1)*sizeof(*s->head));
 
 /* ========================================================================= */
-int ZEXPORT deflateInit_(strm, level, version, stream_size)
+int ZEXPORT deflateInit_(strm, level, stream_size)
     z_streamp strm;
     int level;
-    const char *version;
     int stream_size;
 {
     return deflateInit2_(strm, level, Z_DEFLATED, MAX_WBITS, DEF_MEM_LEVEL,
-                         Z_DEFAULT_STRATEGY, version, stream_size);
+                         Z_DEFAULT_STRATEGY, stream_size);
     /* To do: ignore strm->next_in if we use it as window */
 }
 
 /* ========================================================================= */
 int ZEXPORT deflateInit2_(strm, level, method, windowBits, memLevel, strategy,
-                  version, stream_size)
+                  stream_size)
     z_streamp strm;
     int  level;
     int  method;
     int  windowBits;
     int  memLevel;
     int  strategy;
-    const char *version;
     int stream_size;
 {
     deflate_state *s;
     int wrap = 1;
-    static const char my_version[] = ZLIB_VERSION;
 
-    if (version == Z_NULL || version[0] != my_version[0] ||
-        stream_size != sizeof(z_stream)) {
-        return Z_VERSION_ERROR;
-    }
     if (strm == Z_NULL) return Z_STREAM_ERROR;
 
     strm->msg = Z_NULL;
diff --git a/lib/zlib/inflate.c b/lib/zlib/inflate.c
index 79c9e991aa..f7e81fc8b2 100644
--- a/lib/zlib/inflate.c
+++ b/lib/zlib/inflate.c
@@ -30,14 +30,11 @@ int ZEXPORT inflateReset(z_streamp strm)
     return Z_OK;
 }
 
-int ZEXPORT inflateInit2_(z_streamp strm, int windowBits, const char *version,
+int ZEXPORT inflateInit2_(z_streamp strm, int windowBits,
 			  int stream_size)
 {
     struct inflate_state FAR *state;
 
-    if (version == Z_NULL || version[0] != ZLIB_VERSION[0] ||
-        stream_size != (int)(sizeof(z_stream)))
-        return Z_VERSION_ERROR;
     if (strm == Z_NULL) return Z_STREAM_ERROR;
     strm->msg = Z_NULL;                 /* in case we return an error */
     if (strm->zalloc == (alloc_func)0) {
@@ -70,9 +67,9 @@ int ZEXPORT inflateInit2_(z_streamp strm, int windowBits, const char *version,
     return inflateReset(strm);
 }
 
-int ZEXPORT inflateInit_(z_streamp strm, const char *version, int stream_size)
+int ZEXPORT inflateInit_(z_streamp strm, int stream_size)
 {
-    return inflateInit2_(strm, DEF_WBITS, version, stream_size);
+    return inflateInit2_(strm, DEF_WBITS, stream_size);
 }
 
 local void fixedtables(struct inflate_state FAR *state)
diff --git a/lib/zlib/zutil.c b/lib/zlib/zutil.c
index 609aac55ce..ec21b458fc 100644
--- a/lib/zlib/zutil.c
+++ b/lib/zlib/zutil.c
@@ -21,7 +21,6 @@ const char * const z_errmsg[10] = {
 "data error",          /* Z_DATA_ERROR    (-3) */
 "insufficient memory", /* Z_MEM_ERROR     (-4) */
 "buffer error",        /* Z_BUF_ERROR     (-5) */
-"incompatible version",/* Z_VERSION_ERROR (-6) */
 ""};
 
 #ifdef DEBUG
-- 
2.44.0

