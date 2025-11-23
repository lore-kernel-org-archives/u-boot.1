Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B09CFD315
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 01:19:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71D7183B96;
	Sun, 23 Nov 2025 02:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="C7uDAApW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D69483B7E; Sun, 23 Nov 2025 02:19:33 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3425883B8C
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 02:19:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4637D42491; 
 Sun, 23 Nov 2025 01:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763860769;
 bh=0NBEI4AeEYX/wspg29CbeTToyJiWqvESkrDdtZX1Xtk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=C7uDAApWtKnCOMSoJgsJ6BF26oBhDyfd2Rs17MY3Pk2N21u3VjkmLuZsk5KXXFWhb
 JJep+KhnRPzWQu1DQSvoDkF2XviJO4I0eYFWTxJ1oQpCE3C8n8OjoHMUvWn6dXhq3O
 OIeXTBlEKYwECAIzU27BGKv+nYPF0w1xPWOBQSobcH3i2bFemxzHMIXf4MPW2rMl9U
 1BBPBW2MLTR7ZXbXNYTCLdQbml4PdIXOpHckMkSmJXNBrdrja6JZqOzmT8EQIP83JR
 Q2Hf5AKniLlCeBr1k1e2Rms60gMpxvY+LCWRFD8yYPzEUHpsONa5eLpOJ0dXsJKFLP
 +U3Jq9jG6kXVi4V18pXEoedXpb8nSWVvxu+S9nBf2zXsRJY+fqrAzeMB4fCQdCrSdg
 M4lCvJzfJXav9b8LRs1dGJDfRG4dVA+J5b7M7fpRivVtdi+0Fubh1s0Dpu9+AyZUJW
 McIy9rVajFgjdiiPJPL6XB4OCCCVCRjqsicQ4Lhz2WwHDj3vSFLjNZvSBpmc5yg0Sk
 cf5TayaHqZADmRhQ6IMq0gf8YWaorHhwD79QHByekz1RNtNokvoRc+9L/oNlCUEoda
 /hUu2bsNUCULnOFUGiQ1vOTMtbkTR8AYFI6qDBgm5l9jRISVy50DB9mji8B1CTNszI
 SQVFFbkZaC9E5t/zAhUM27t8=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Cc: Fabio Estevam <festevam@gmail.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/3] test: print_display_buffer must consider 64bit support
Date: Sun, 23 Nov 2025 02:18:59 +0100
Message-ID: <20251123011900.91233-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123011900.91233-1-heinrich.schuchardt@canonical.com>
References: <20251123011900.91233-1-heinrich.schuchardt@canonical.com>
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

