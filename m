Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BD1C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 10:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67F4D885D1;
	Tue,  9 Jul 2024 12:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D65488570; Tue,  9 Jul 2024 12:32:03 +0200 (CEST)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23A9C88602
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 12:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4WJHNZ6XJmz9sSg;
 Tue,  9 Jul 2024 12:31:58 +0200 (CEST)
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BO5ZAE7WICc8; Tue,  9 Jul 2024 12:31:58 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4WJHNV4xy3z9sSt;
 Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 99DDF8B773;
 Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id GP-75tI37jZe; Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.243])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 552A78B76D;
 Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michal Simek <michal.simek@amd.com>,
	Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH 5/6] zlib: Misc unrelated updates
Date: Tue,  9 Jul 2024 12:31:17 +0200
Message-ID: <68b6b941557aee8b62109772a2c09a56282bf4aa.1720521011.git.christophe.leroy@csgroup.eu>
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

This patch adds misc updates to better match zlib original code.

It is split out of a previous version of
patch ("zlib: Port fix for CVE-2016-9841 to U-Boot)
as those changes were unrelated.

Signed-off-by: Michal Simek <michal.simek@amd.com>
[chleroy: Split out of patch ("zlib: Port fix for CVE-2016-9841 to U-Boot)]
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/zlib/inffast.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
index 19236f1e23..b5a0adcce6 100644
--- a/lib/zlib/inffast.c
+++ b/lib/zlib/inffast.c
@@ -1,5 +1,5 @@
 /* inffast.c -- fast decoding
- * Copyright (C) 1995-2004 Mark Adler
+ * Copyright (C) 1995-2008, 2010, 2013 Mark Adler
  * For conditions of distribution and use, see copyright notice in zlib.h
  */
 
@@ -47,12 +47,13 @@
       requires strm->avail_out >= 258 for each loop to avoid checking for
       output space.
  */
-void inflate_fast(z_streamp strm, unsigned start)
-/* start: inflate()'s starting value for strm->avail_out */
+void ZLIB_INTERNAL inflate_fast(strm, start)
+z_streamp strm;
+unsigned start;         /* inflate()'s starting value for strm->avail_out */
 {
     struct inflate_state FAR *state;
-    unsigned char FAR *in;      /* local strm->next_in */
-    unsigned char FAR *last;    /* while in < last, enough input available */
+    z_const unsigned char FAR *in;      /* local strm->next_in */
+    z_const unsigned char FAR *last;    /* have enough input while in < last */
     unsigned char FAR *out;     /* local strm->next_out */
     unsigned char FAR *beg;     /* inflate()'s initial strm->next_out */
     unsigned char FAR *end;     /* while out < end, enough space available */
@@ -177,7 +178,8 @@ void inflate_fast(z_streamp strm, unsigned start)
                 if (dist > op) {                /* see if copy from window */
                     op = dist - op;             /* distance back in window */
                     if (op > whave) {
-                        strm->msg = (char *)"invalid distance too far back";
+                        strm->msg =
+                            (char *)"invalid distance too far back";
                         state->mode = BAD;
                         break;
                     }
-- 
2.44.0

