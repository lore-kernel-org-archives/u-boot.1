Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61183C2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:29:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD420884F1;
	Thu, 27 Jun 2024 10:29:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2482D88370; Thu, 27 Jun 2024 10:29:35 +0200 (CEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 494F6880A5
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4W8sDr6XWGz9vDw;
 Thu, 27 Jun 2024 10:29:32 +0200 (CEST)
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WLuOYJwWNfme; Thu, 27 Jun 2024 10:29:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4W8s8G4JShz9vDl;
 Thu, 27 Jun 2024 10:25:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FFE58B776;
 Thu, 27 Jun 2024 10:25:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 1VMo5KaRfV4U; Thu, 27 Jun 2024 10:25:34 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.179])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4D64A8B763;
 Thu, 27 Jun 2024 10:25:34 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michal Simek <michal.simek@amd.com>,
	Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH] zlib: Fix big performance regression
Date: Thu, 27 Jun 2024 10:25:21 +0200
Message-ID: <9756b956da953de2c32278a81f711cf3ac281bad.1719476684.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
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

Commit 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
brings a big performance regression in inflate_fast(), which leads
to watchdog timer reset on powerpc 8xx.

It looks like that commit does more than what it describe, it
especially removed an important optimisation that was doing copies
using halfwords instead of bytes. That unexpected change multiplied
by almost 4 the time spent in inflate_fast() and increased by 40%
the overall time needed to uncompress linux kernel image.

So partially revert that commit but keep post incrementation as it
is the initial purpose of said commit.

Fixes: 340fdf1303dc ("zlib: Port fix for CVE-2016-9841 to U-Boot")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/zlib/inffast.c | 51 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
index 5e2a65ad4d..c4b1d12258 100644
--- a/lib/zlib/inffast.c
+++ b/lib/zlib/inffast.c
@@ -236,18 +236,47 @@ unsigned start;         /* inflate()'s starting value for strm->avail_out */
                     }
                 }
                 else {
+		    unsigned short *sout;
+		    unsigned long loops;
+
                     from = out - dist;          /* copy direct from output */
-                    do {                        /* minimum length is three */
-                        *out++ = *from++;
-                        *out++ = *from++;
-                        *out++ = *from++;
-                        len -= 3;
-                    } while (len > 2);
-                    if (len) {
-                        *out++ = *from++;
-                        if (len > 1)
-                            *out++ = *from++;
-                    }
+                    /* minimum length is three */
+		    /* Align out addr */
+		    if (!((long)(out - 1) & 1)) {
+			*out++ = *from++;
+			len--;
+		    }
+		    sout = (unsigned short *)out;
+		    if (dist > 2 ) {
+			unsigned short *sfrom;
+
+			sfrom = (unsigned short *)from;
+			loops = len >> 1;
+			do
+			    *sout++ = get_unaligned(++sfrom);
+			while (--loops);
+			out = (unsigned char *)sout;
+			from = (unsigned char *)sfrom;
+		    } else { /* dist == 1 or dist == 2 */
+			unsigned short pat16;
+
+			pat16 = *(sout-2);
+			if (dist == 1)
+#if defined(__BIG_ENDIAN)
+			    pat16 = (pat16 & 0xff) | ((pat16 & 0xff ) << 8);
+#elif defined(__LITTLE_ENDIAN)
+			    pat16 = (pat16 & 0xff00) | ((pat16 & 0xff00 ) >> 8);
+#else
+#error __BIG_ENDIAN nor __LITTLE_ENDIAN is defined
+#endif
+			loops = len >> 1;
+			do
+			    *sout++ = pat16;
+			while (--loops);
+			out = (unsigned char *)sout;
+		    }
+		    if (len & 1)
+			*out++ = *from++;
                 }
             }
             else if ((op & 64) == 0) {          /* 2nd level distance code */
-- 
2.44.0

