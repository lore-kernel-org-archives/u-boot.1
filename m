Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA516C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 10:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEC7688579;
	Tue,  9 Jul 2024 12:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97621885D4; Tue,  9 Jul 2024 12:31:57 +0200 (CEST)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE1E28857D
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 12:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4WJHNV0p8Qz9sSs;
 Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m9GlJbQTiZB3; Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4WJHNT3fglz9sSg;
 Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 6D5C58B773;
 Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id OLPVEaUqQf2T; Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.243])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 210B28B775;
 Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michal Simek <michal.simek@amd.com>,
	Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH 1/6] zlib: Rename this variable to here (current decoding
 table entry)
Date: Tue,  9 Jul 2024 12:31:13 +0200
Message-ID: <e1c1b4f22a6182c4dc719937c67eeefaf92d2d46.1720521011.git.christophe.leroy@csgroup.eu>
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
zlib commit 639be997883d ("zlib 1.2.3.3") It is preparation for followup
patch.

Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/zlib/inffast.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
index e3c7f3b892..d61cf0e72a 100644
--- a/lib/zlib/inffast.c
+++ b/lib/zlib/inffast.c
@@ -88,7 +88,7 @@ void inflate_fast(z_streamp strm, unsigned start)
     code const FAR *dcode;      /* local strm->distcode */
     unsigned lmask;             /* mask for first level of length codes */
     unsigned dmask;             /* mask for first level of distance codes */
-    code this;                  /* retrieved table entry */
+    code here;                  /* retrieved table entry */
     unsigned op;                /* code bits, operation, extra bits, or */
                                 /*  window position, window bytes to copy */
     unsigned len;               /* match length, unused bytes */
@@ -133,20 +133,20 @@ void inflate_fast(z_streamp strm, unsigned start)
             hold += (unsigned long)(PUP(in)) << bits;
             bits += 8;
         }
-        this = lcode[hold & lmask];
+        here = lcode[hold & lmask];
       dolen:
-        op = (unsigned)(this.bits);
+        op = (unsigned)(here.bits);
         hold >>= op;
         bits -= op;
-        op = (unsigned)(this.op);
+        op = (unsigned)(here.op);
         if (op == 0) {                          /* literal */
-            Tracevv((stderr, this.val >= 0x20 && this.val < 0x7f ?
+            Tracevv((stderr, here.val >= 0x20 && here.val < 0x7f ?
                     "inflate:         literal '%c'\n" :
-                    "inflate:         literal 0x%02x\n", this.val));
-            PUP(out) = (unsigned char)(this.val);
+                    "inflate:         literal 0x%02x\n", here.val));
+            PUP(out) = (unsigned char)(here.val);
         }
         else if (op & 16) {                     /* length base */
-            len = (unsigned)(this.val);
+            len = (unsigned)(here.val);
             op &= 15;                           /* number of extra bits */
             if (op) {
                 if (bits < op) {
@@ -164,14 +164,14 @@ void inflate_fast(z_streamp strm, unsigned start)
                 hold += (unsigned long)(PUP(in)) << bits;
                 bits += 8;
             }
-            this = dcode[hold & dmask];
+            here = dcode[hold & dmask];
           dodist:
-            op = (unsigned)(this.bits);
+            op = (unsigned)(here.bits);
             hold >>= op;
             bits -= op;
-            op = (unsigned)(this.op);
+            op = (unsigned)(here.op);
             if (op & 16) {                      /* distance base */
-                dist = (unsigned)(this.val);
+                dist = (unsigned)(here.val);
                 op &= 15;                       /* number of extra bits */
                 if (bits < op) {
                     hold += (unsigned long)(PUP(in)) << bits;
@@ -297,7 +297,7 @@ void inflate_fast(z_streamp strm, unsigned start)
                 }
             }
             else if ((op & 64) == 0) {          /* 2nd level distance code */
-                this = dcode[this.val + (hold & ((1U << op) - 1))];
+                here = dcode[here.val + (hold & ((1U << op) - 1))];
                 goto dodist;
             }
             else {
@@ -307,7 +307,7 @@ void inflate_fast(z_streamp strm, unsigned start)
             }
         }
         else if ((op & 64) == 0) {              /* 2nd level length code */
-            this = lcode[this.val + (hold & ((1U << op) - 1))];
+            here = lcode[here.val + (hold & ((1U << op) - 1))];
             goto dolen;
         }
         else if (op & 32) {                     /* end-of-block */
-- 
2.44.0

