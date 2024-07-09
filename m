Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3500C3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 10:32:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E5FD885E7;
	Tue,  9 Jul 2024 12:32:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 892138860B; Tue,  9 Jul 2024 12:32:01 +0200 (CEST)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2664F8859A
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 12:31:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4WJHNY1NT6z9sSq;
 Tue,  9 Jul 2024 12:31:57 +0200 (CEST)
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Aq9Z6svQcrbd; Tue,  9 Jul 2024 12:31:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4WJHNV3F54z9sSg;
 Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6021C8B773;
 Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id b0Bh7kLB1Avk; Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.243])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 038E98B775;
 Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michal Simek <michal.simek@amd.com>,
	Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH 4/6] zlib: Port fix for CVE-2016-9841 to U-Boot
Date: Tue,  9 Jul 2024 12:31:16 +0200
Message-ID: <978908b53bec97ae81e537bf0dd036f06c953a1a.1720521011.git.christophe.leroy@csgroup.eu>
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

The patch corresponds to zlib commit at
https://github.com/madler/zlib/commit/9aaec95e82117c1cb0f9624264c3618fc380cecb
which declares that it is fixing CVE-2016-9841.
Here is c&p description from zlib:
"Use post-increment only in inffast.c.

An old inffast.c optimization turns out to not be optimal anymore
with modern compilers, and furthermore was not compliant with the
C standard, for which decrementing a pointer before its allocated
memory is undefined. Per the recommendation of a security audit of
the zlib code by Trail of Bits and TrustInSoft, in support of the
Mozilla Foundation, this "optimization" was removed, in order to
avoid the possibility of undefined behavior."

Origin patch also updates the code when
INFLATE_ALLOW_INVALID_DISTANCE_TOOFAR_ARRR is present but this code is not
the part of U-Boot hence it is ignored.
Also do not deal with state->sane variable which requires other changes
which are also not the part of zlib.

Commit 92faa8b10918 ("zlib: handle overflow while calculating available
stream input size") is kept in inffast.c too not to break described case.

Commit cd514aeb996e ("zlib: Optimize decompression") is also kept,
otherwise linux kernel decompression is 40% longer on powerpc 8xx
platform and it leads to watchdog resets.

Signed-off-by: Michal Simek <michal.simek@amd.com>
[chleroy: Restore optimisation from commit cd514aeb996e ("zlib: Optimize decompression") and fix zlib.h]
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/zlib/inffast.c | 89 ++++++++++++++++++----------------------------
 lib/zlib/zlib.h    |  1 -
 2 files changed, 34 insertions(+), 56 deletions(-)

diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
index 29ec72fce5..19236f1e23 100644
--- a/lib/zlib/inffast.c
+++ b/lib/zlib/inffast.c
@@ -12,27 +12,6 @@
 
 #ifndef ASMINF
 
-/* Allow machine dependent optimization for post-increment or pre-increment.
-   Based on testing to date,
-   Pre-increment preferred for:
-   - PowerPC G3 (Adler)
-   - MIPS R5000 (Randers-Pehrson)
-   Post-increment preferred for:
-   - none
-   No measurable difference:
-   - Pentium III (Anderson)
-   - M68060 (Nikl)
- */
-#ifdef POSTINC
-#  define OFF 0
-#  define PUP(a) *(a)++
-#  define UP_UNALIGNED(a) get_unaligned((a)++)
-#else
-#  define OFF 1
-#  define PUP(a) *++(a)
-#  define UP_UNALIGNED(a) get_unaligned(++(a))
-#endif
-
 /*
    Decode literal, length, and distance codes and write out the resulting
    literal and match bytes until either not enough input or output is
@@ -99,7 +78,7 @@ void inflate_fast(z_streamp strm, unsigned start)
 
     /* copy state to local variables */
     state = (struct inflate_state FAR *)strm->state;
-    in = strm->next_in - OFF;
+    in = strm->next_in;
     last = in + (strm->avail_in - 5);
     if (in > last && strm->avail_in > 5) {
         /*
@@ -109,7 +88,7 @@ void inflate_fast(z_streamp strm, unsigned start)
 	strm->avail_in = 0xffffffff - (uintptr_t)in;
         last = in + (strm->avail_in - 5);
     }
-    out = strm->next_out - OFF;
+    out = strm->next_out;
     beg = out - (start - strm->avail_out);
     end = out + (strm->avail_out - 257);
 #ifdef INFLATE_STRICT
@@ -130,9 +109,9 @@ void inflate_fast(z_streamp strm, unsigned start)
        input data or output space */
     do {
         if (bits < 15) {
-            hold += (unsigned long)(PUP(in)) << bits;
+            hold += (unsigned long)(*in++) << bits;
             bits += 8;
-            hold += (unsigned long)(PUP(in)) << bits;
+            hold += (unsigned long)(*in++) << bits;
             bits += 8;
         }
         here = lcode[hold & lmask];
@@ -145,14 +124,14 @@ void inflate_fast(z_streamp strm, unsigned start)
             Tracevv((stderr, here.val >= 0x20 && here.val < 0x7f ?
                     "inflate:         literal '%c'\n" :
                     "inflate:         literal 0x%02x\n", here.val));
-            PUP(out) = (unsigned char)(here.val);
+            *out++ = (unsigned char)(here.val);
         }
         else if (op & 16) {                     /* length base */
             len = (unsigned)(here.val);
             op &= 15;                           /* number of extra bits */
             if (op) {
                 if (bits < op) {
-                    hold += (unsigned long)(PUP(in)) << bits;
+                    hold += (unsigned long)(*in++) << bits;
                     bits += 8;
                 }
                 len += (unsigned)hold & ((1U << op) - 1);
@@ -161,9 +140,9 @@ void inflate_fast(z_streamp strm, unsigned start)
             }
             Tracevv((stderr, "inflate:         length %u\n", len));
             if (bits < 15) {
-                hold += (unsigned long)(PUP(in)) << bits;
+                hold += (unsigned long)(*in++) << bits;
                 bits += 8;
-                hold += (unsigned long)(PUP(in)) << bits;
+                hold += (unsigned long)(*in++) << bits;
                 bits += 8;
             }
             here = dcode[hold & dmask];
@@ -176,10 +155,10 @@ void inflate_fast(z_streamp strm, unsigned start)
                 dist = (unsigned)(here.val);
                 op &= 15;                       /* number of extra bits */
                 if (bits < op) {
-                    hold += (unsigned long)(PUP(in)) << bits;
+                    hold += (unsigned long)(*in++) << bits;
                     bits += 8;
                     if (bits < op) {
-                        hold += (unsigned long)(PUP(in)) << bits;
+                        hold += (unsigned long)(*in++) << bits;
                         bits += 8;
                     }
                 }
@@ -202,13 +181,13 @@ void inflate_fast(z_streamp strm, unsigned start)
                         state->mode = BAD;
                         break;
                     }
-                    from = window - OFF;
+                    from = window;
                     if (wnext == 0) {           /* very common case */
                         from += wsize - op;
                         if (op < len) {         /* some from window */
                             len -= op;
                             do {
-                                PUP(out) = PUP(from);
+                                *out++ = *from++;
                             } while (--op);
                             from = out - dist;  /* rest from output */
                         }
@@ -219,14 +198,14 @@ void inflate_fast(z_streamp strm, unsigned start)
                         if (op < len) {         /* some from end of window */
                             len -= op;
                             do {
-                                PUP(out) = PUP(from);
+                                *out++ = *from++;
                             } while (--op);
-                            from = window - OFF;
+                            from = window;
                             if (wnext < len) {  /* some from start of window */
                                 op = wnext;
                                 len -= op;
                                 do {
-                                    PUP(out) = PUP(from);
+                                    *out++ = *from++;
                                 } while (--op);
                                 from = out - dist;      /* rest from output */
                             }
@@ -237,21 +216,21 @@ void inflate_fast(z_streamp strm, unsigned start)
                         if (op < len) {         /* some from window */
                             len -= op;
                             do {
-                                PUP(out) = PUP(from);
+                                *out++ = *from++;
                             } while (--op);
                             from = out - dist;  /* rest from output */
                         }
                     }
                     while (len > 2) {
-                        PUP(out) = PUP(from);
-                        PUP(out) = PUP(from);
-                        PUP(out) = PUP(from);
+                        *out++ = *from++;
+                        *out++ = *from++;
+                        *out++ = *from++;
                         len -= 3;
                     }
                     if (len) {
-                        PUP(out) = PUP(from);
+                        *out++ = *from++;
                         if (len > 1)
-                            PUP(out) = PUP(from);
+                            *out++ = *from++;
                     }
                 }
                 else {
@@ -261,25 +240,25 @@ void inflate_fast(z_streamp strm, unsigned start)
                     from = out - dist;          /* copy direct from output */
                     /* minimum length is three */
 		    /* Align out addr */
-		    if (!((long)(out - 1 + OFF) & 1)) {
-			PUP(out) = PUP(from);
+		    if (!((long)(out - 1) & 1)) {
+			*out++ = *from++;
 			len--;
 		    }
-		    sout = (unsigned short *)(out - OFF);
+		    sout = (unsigned short *)out;
 		    if (dist > 2 ) {
 			unsigned short *sfrom;
 
-			sfrom = (unsigned short *)(from - OFF);
+			sfrom = (unsigned short *)from;
 			loops = len >> 1;
 			do
-			    PUP(sout) = UP_UNALIGNED(sfrom);
+			    *sout++ = get_unaligned(sfrom++);
 			while (--loops);
-			out = (unsigned char *)sout + OFF;
-			from = (unsigned char *)sfrom + OFF;
+			out = (unsigned char *)sout;
+			from = (unsigned char *)sfrom;
 		    } else { /* dist == 1 or dist == 2 */
 			unsigned short pat16;
 
-			pat16 = *(sout - 1 + OFF);
+			pat16 = *(sout - 1);
 			if (dist == 1)
 #if defined(__BIG_ENDIAN)
 			    pat16 = (pat16 & 0xff) | ((pat16 & 0xff ) << 8);
@@ -290,12 +269,12 @@ void inflate_fast(z_streamp strm, unsigned start)
 #endif
 			loops = len >> 1;
 			do
-			    PUP(sout) = pat16;
+			    *sout++ = pat16;
 			while (--loops);
-			out = (unsigned char *)sout + OFF;
+			out = (unsigned char *)sout;
 		    }
 		    if (len & 1)
-			PUP(out) = PUP(from);
+			*out++ = *from++;
                 }
             }
             else if ((op & 64) == 0) {          /* 2nd level distance code */
@@ -331,8 +310,8 @@ void inflate_fast(z_streamp strm, unsigned start)
     hold &= (1U << bits) - 1;
 
     /* update state and return */
-    strm->next_in = in + OFF;
-    strm->next_out = out + OFF;
+    strm->next_in = in;
+    strm->next_out = out;
     strm->avail_in = (unsigned)(in < last ? 5 + (last - in) : 5 - (in - last));
     strm->avail_out = (unsigned)(out < end ?
                                  257 + (end - out) : 257 - (out - end));
diff --git a/lib/zlib/zlib.h b/lib/zlib/zlib.h
index 560e7be97d..f9b2f69ac0 100644
--- a/lib/zlib/zlib.h
+++ b/lib/zlib/zlib.h
@@ -10,7 +10,6 @@
 /* avoid conflicts */
 #undef OFF
 #undef ASMINF
-#undef POSTINC
 #undef NO_GZIP
 #define GUNZIP
 #undef STDC
-- 
2.44.0

