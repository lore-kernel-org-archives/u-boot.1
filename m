Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614CFCFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D51583C08;
	Sun, 23 Nov 2025 23:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eTL4Z7wN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BE7283C14; Sun, 23 Nov 2025 23:58:09 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C6D883B7E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4866F409BB; 
 Sun, 23 Nov 2025 22:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938675;
 bh=0NBEI4AeEYX/wspg29CbeTToyJiWqvESkrDdtZX1Xtk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=eTL4Z7wNnrPZ5e+X2hy3DvAp1RAFYsKT+i0BeSYwa2D9MocYq/gnhFNW/iGX0HDLN
 DnT9z+ghks7iZV9MsqX5lfLYVHyc7spPBifCD1FkW2/J1VDEDnBtx4bA1mERxvGfYE
 ZpGZnRfHEb6Abirl3tX5RKiMm6hLR5RDHIgdKU+WpCDORryMjDrbIjPxJ8AOuuVy0r
 grnNmJ4malViJGD4WkX04D5iLPGap7+IS99AXZppO1rmBPRGEWZSNJ5p2en9v4uVPd
 dDX+D1nSAueJ3zkJgfRxlv9RrwZFcpILxv62rWHwmuELk3B5Vqenckx32gEJ5TlZQn
 TizAXxDFlMLMK2xv/uGWh1BZvBdYGEW+TjsaNR5WQk2H+gAW16nz6rw2AiHp/BknPB
 IGuBf9ipkoyVVJR3/SlpBjAkF+PmjIaFkgsqTqzjN/UEuLMzl1uu/0OAjwXnduxfvn
 pDX46z+9Gu/5sRhYCclOsajIqe1huMzsQpB4su/puPVy6lfbn1Uwr8C1ohWDOH9WYJ
 oTyWOVX0l3pTbDOKoFgyhNEEKFKulJDk7FuFp3nAJAkAjn7j1IfrTdHYLNePBYugyH
 VoP/eZsx+VD3Gc8Dxwfsy1SnOU7ZQCfNOqKSHaN1jBwizQOLtFtaG3BbL+IqWUeI5K
 vvaSl3X9uWWDbrHaaqt6iwLs=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Paul Burton <paulburton@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heiko Schocher <hs@nabladev.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Richard Weinberger <richard@nod.at>,
 Guillaume La Roque <glaroque@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [RESEND][PATCH 03/19] test: print_display_buffer must consider 64bit
 support
Date: Sun, 23 Nov 2025 23:56:55 +0100
Message-ID: <20251123225711.227016-4-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
References: <20251123225711.227016-1-heinrich.schuchardt@canonical.com>
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

Function print_buffer() does not support printing u64 on 32bit systems.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/common/print.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/test/common/print.c b/test/common/print.c
index f33476a36b4..a8feb07971d 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -4,6 +4,7 @@
  */
 
 #include <command.h>
+#include <compiler.h>
 #include <efi_api.h>
 #include <display_options.h>
 #include <log.h>
@@ -212,10 +213,12 @@ static int print_display_buffer(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* 64-bit */
-	print_buffer(0, buf, 8, 3, 0);
-	ut_assert_nextline("00000000: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........");
-	ut_assert_nextline("00000010: 0000000000000010                   ........");
-	ut_assert_console_end();
+	if (MEM_SUPPORT_64BIT_DATA) {
+		print_buffer(0, buf, 8, 3, 0);
+		ut_assert_nextline("00000000: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........");
+		ut_assert_nextline("00000010: 0000000000000010                   ........");
+		ut_assert_console_end();
+	}
 
 	/* ASCII */
 	buf[1] = 31;
-- 
2.51.0

