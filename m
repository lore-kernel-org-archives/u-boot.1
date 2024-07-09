Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE15C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 10:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47432885EE;
	Tue,  9 Jul 2024 12:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 876DF88579; Tue,  9 Jul 2024 12:31:58 +0200 (CEST)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D18D884FF
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 12:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4WJHNW1rGMz9sSy;
 Tue,  9 Jul 2024 12:31:55 +0200 (CEST)
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y08i7YrA65VF; Tue,  9 Jul 2024 12:31:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4WJHNT5xz5z9sSq;
 Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BB14A8B775;
 Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Y7lHNf01YfyT; Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.243])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 65F6E8B76D;
 Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michal Simek <michal.simek@amd.com>,
	Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH 2/6] zlib: Rename write variable to wnext (window write index)
Date: Tue,  9 Jul 2024 12:31:14 +0200
Message-ID: <04f54af493cb3232bdfcb2c15910e4312627d730.1720521011.git.christophe.leroy@csgroup.eu>
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

There is no particular patch/description which described the reason for
this change but it was done as the part of zlib 1.2.3.5 release done by
zlib commit d004b047838a ("zlib 1.2.3.5"). It is preparation for followup
patch.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/zlib/inffast.c | 20 ++++++++++----------
 lib/zlib/inflate.c | 22 +++++++++++-----------
 lib/zlib/inflate.h |  2 +-
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
index d61cf0e72a..bdaa6d0dc5 100644
--- a/lib/zlib/inffast.c
+++ b/lib/zlib/inffast.c
@@ -80,7 +80,7 @@ void inflate_fast(z_streamp strm, unsigned start)
 #endif
     unsigned wsize;             /* window size or zero if not using window */
     unsigned whave;             /* valid bytes in the window */
-    unsigned write;             /* window write index */
+    unsigned wnext;             /* window write index */
     unsigned char FAR *window;  /* allocated sliding window, if wsize != 0 */
     unsigned long hold;         /* local strm->hold */
     unsigned bits;              /* local strm->bits */
@@ -115,7 +115,7 @@ void inflate_fast(z_streamp strm, unsigned start)
 #endif
     wsize = state->wsize;
     whave = state->whave;
-    write = state->write;
+    wnext = state->wnext;
     window = state->window;
     hold = state->hold;
     bits = state->bits;
@@ -201,7 +201,7 @@ void inflate_fast(z_streamp strm, unsigned start)
                         break;
                     }
                     from = window - OFF;
-                    if (write == 0) {           /* very common case */
+                    if (wnext == 0) {           /* very common case */
                         from += wsize - op;
                         if (op < len) {         /* some from window */
                             len -= op;
@@ -211,17 +211,17 @@ void inflate_fast(z_streamp strm, unsigned start)
                             from = out - dist;  /* rest from output */
                         }
                     }
-                    else if (write < op) {      /* wrap around window */
-                        from += wsize + write - op;
-                        op -= write;
+                    else if (wnext < op) {      /* wrap around window */
+                        from += wsize + wnext - op;
+                        op -= wnext;
                         if (op < len) {         /* some from end of window */
                             len -= op;
                             do {
                                 PUP(out) = PUP(from);
                             } while (--op);
                             from = window - OFF;
-                            if (write < len) {  /* some from start of window */
-                                op = write;
+                            if (wnext < len) {  /* some from start of window */
+                                op = wnext;
                                 len -= op;
                                 do {
                                     PUP(out) = PUP(from);
@@ -231,7 +231,7 @@ void inflate_fast(z_streamp strm, unsigned start)
                         }
                     }
                     else {                      /* contiguous in window */
-                        from += write - op;
+                        from += wnext - op;
                         if (op < len) {         /* some from window */
                             len -= op;
                             do {
@@ -343,7 +343,7 @@ void inflate_fast(z_streamp strm, unsigned start)
    inflate_fast() speedups that turned out slower (on a PowerPC G3 750CXe):
    - Using bit fields for code structure
    - Different op definition to avoid & for extra bits (do & for table bits)
-   - Three separate decoding do-loops for direct, window, and write == 0
+   - Three separate decoding do-loops for direct, window, and wnext == 0
    - Special case for distance > 1 copies to do overlapped load and store copy
    - Explicit branch predictions (based on measured branch probabilities)
    - Deferring match copy and interspersed it with decoding subsequent codes
diff --git a/lib/zlib/inflate.c b/lib/zlib/inflate.c
index 8f767b7b9d..79c9e991aa 100644
--- a/lib/zlib/inflate.c
+++ b/lib/zlib/inflate.c
@@ -21,7 +21,7 @@ int ZEXPORT inflateReset(z_streamp strm)
     state->head = Z_NULL;
     state->wsize = 0;
     state->whave = 0;
-    state->write = 0;
+    state->wnext = 0;
     state->hold = 0;
     state->bits = 0;
     state->lencode = state->distcode = state->next = state->codes;
@@ -115,7 +115,7 @@ local int updatewindow(z_streamp strm, unsigned out)
     /* if window not in use yet, initialize */
     if (state->wsize == 0) {
         state->wsize = 1U << state->wbits;
-        state->write = 0;
+        state->wnext = 0;
         state->whave = 0;
     }
 
@@ -123,22 +123,22 @@ local int updatewindow(z_streamp strm, unsigned out)
     copy = out - strm->avail_out;
     if (copy >= state->wsize) {
         zmemcpy(state->window, strm->next_out - state->wsize, state->wsize);
-        state->write = 0;
+        state->wnext = 0;
         state->whave = state->wsize;
     }
     else {
-        dist = state->wsize - state->write;
+        dist = state->wsize - state->wnext;
         if (dist > copy) dist = copy;
-        zmemcpy(state->window + state->write, strm->next_out - copy, dist);
+        zmemcpy(state->window + state->wnext, strm->next_out - copy, dist);
         copy -= dist;
         if (copy) {
             zmemcpy(state->window, strm->next_out - copy, copy);
-            state->write = copy;
+            state->wnext = copy;
             state->whave = state->wsize;
         }
         else {
-            state->write += dist;
-            if (state->write == state->wsize) state->write = 0;
+            state->wnext += dist;
+            if (state->wnext == state->wsize) state->wnext = 0;
             if (state->whave < state->wsize) state->whave += dist;
         }
     }
@@ -823,12 +823,12 @@ int ZEXPORT inflate(z_streamp strm, int flush)
             copy = out - left;
             if (state->offset > copy) {         /* copy from window */
                 copy = state->offset - copy;
-                if (copy > state->write) {
-                    copy -= state->write;
+                if (copy > state->wnext) {
+                    copy -= state->wnext;
                     from = state->window + (state->wsize - copy);
                 }
                 else
-                    from = state->window + (state->write - copy);
+                    from = state->window + (state->wnext - copy);
                 if (copy > state->length) copy = state->length;
             }
             else {                              /* copy from output */
diff --git a/lib/zlib/inflate.h b/lib/zlib/inflate.h
index 07bd3e78a7..2657d611cd 100644
--- a/lib/zlib/inflate.h
+++ b/lib/zlib/inflate.h
@@ -88,7 +88,7 @@ struct inflate_state {
     unsigned wbits;             /* log base 2 of requested window size */
     unsigned wsize;             /* window size or zero if not using window */
     unsigned whave;             /* valid bytes in the window */
-    unsigned write;             /* window write index */
+    unsigned wnext;             /* window write index */
     unsigned char FAR *window;  /* allocated sliding window, if needed */
         /* bit accumulator */
     unsigned long hold;         /* input bit accumulator */
-- 
2.44.0

