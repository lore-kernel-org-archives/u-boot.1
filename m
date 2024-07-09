Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E950C3DA41
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 10:32:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A8EA885D4;
	Tue,  9 Jul 2024 12:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC48885E4; Tue,  9 Jul 2024 12:31:59 +0200 (CEST)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64D08885CF
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 12:31:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4WJHNX1qmYz9sSp;
 Tue,  9 Jul 2024 12:31:56 +0200 (CEST)
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KkITP5_8RWwb; Tue,  9 Jul 2024 12:31:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4WJHNV0QpGz9sSr;
 Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 00B2E8B76D;
 Tue,  9 Jul 2024 12:31:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id xg36ZWcOiiRW; Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.243])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B09378B773;
 Tue,  9 Jul 2024 12:31:53 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michal Simek <michal.simek@amd.com>,
	Tom Rini <trini@konsulko.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	u-boot@lists.denx.de
Subject: [PATCH 3/6] zlib: Fix inflate_fast() when POSTINC macro is set
Date: Tue,  9 Jul 2024 12:31:15 +0200
Message-ID: <c4e65199113b4043d4185eb1bc24bdaf10f22696.1720521011.git.christophe.leroy@csgroup.eu>
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

inflate_fast() implements possibility to be build with
POSTINC set or unset. That POSTINC macro was introduced by
commit e89516f031db ("zlib: split up to match original source tree")
but forced to #undef in zlib.h.

However, in the meantime that commit removed UP_UNALIGNED() macro
introduced by commit cd514aeb996e ("zlib: Optimize decompression")
that was meant to implement proper behaviour depending on POSTINC.

In addition, commit cd514aeb996e ("zlib: Optimize decompression") has
a bug for when POSTINC is set in the following pointer arithmetic:

	pat16 = *(sout-2+2*OFF)

The intension is to remove 2 bytes when OFF is 0, but sout being a
short, this leads to removing 4 bytes instead of 2. The bug in not
visible when OFF is set to 1 which has always been the case until now.

In preparation for followup patch that will activate POSTINC, add back
UP_UNALIGNED() macro and fix the above pointer calculation.

Fixes: cd514aeb996e ("zlib: Optimize decompression")
Cc: Michal Simek <michal.simek@amd.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 lib/zlib/inffast.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/zlib/inffast.c b/lib/zlib/inffast.c
index bdaa6d0dc5..29ec72fce5 100644
--- a/lib/zlib/inffast.c
+++ b/lib/zlib/inffast.c
@@ -26,9 +26,11 @@
 #ifdef POSTINC
 #  define OFF 0
 #  define PUP(a) *(a)++
+#  define UP_UNALIGNED(a) get_unaligned((a)++)
 #else
 #  define OFF 1
 #  define PUP(a) *++(a)
+#  define UP_UNALIGNED(a) get_unaligned(++(a))
 #endif
 
 /*
@@ -270,14 +272,14 @@ void inflate_fast(z_streamp strm, unsigned start)
 			sfrom = (unsigned short *)(from - OFF);
 			loops = len >> 1;
 			do
-			    PUP(sout) = get_unaligned(++sfrom);
+			    PUP(sout) = UP_UNALIGNED(sfrom);
 			while (--loops);
 			out = (unsigned char *)sout + OFF;
 			from = (unsigned char *)sfrom + OFF;
 		    } else { /* dist == 1 or dist == 2 */
 			unsigned short pat16;
 
-			pat16 = *(sout-2+2*OFF);
+			pat16 = *(sout - 1 + OFF);
 			if (dist == 1)
 #if defined(__BIG_ENDIAN)
 			    pat16 = (pat16 & 0xff) | ((pat16 & 0xff ) << 8);
-- 
2.44.0

