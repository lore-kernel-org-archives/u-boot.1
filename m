Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B59D11194
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 22:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6120888EE1;
	Sun,  3 Nov 2024 23:48:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="vteV5WTg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB7188F12; Sun,  3 Nov 2024 23:48:16 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08CC688936
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 23:48:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-238.46.114.pool.telefonica.de
 [46.114.105.238])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2AE773F190; 
 Sun,  3 Nov 2024 22:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730674094;
 bh=7C3A4dCabPbg9CZ+R+WHXYCMeMEvlniDh8aduErJG6g=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=vteV5WTgqfZ5MeQ3xt+x02y06BWIN9pnBb7Xb086L80tjyEKuqiCFttjn5Z7LBdWX
 a4kQ/2+D63c1QioOykIVP9Uf7EcH7LOyN8AvuN+3DxJlvbeUY6MRoQl0jQniuQTOze
 nZO4vzk+SXkAO5lGM9rM0H+7EI8uFBgZYAI6qvkvyTjvbfngRaHKnHqG6/IkSdXOQh
 mevlPED3tqyHVxf8xdJFEX8J6r1bnHveewKeZ5ia/AHGXpIicOeOeJrRn4nWYZq2eP
 Uem76c6DMsk/bOg8B8Z3gTN+gpMQ2gbxAnby980L+Ea+xrCt0YeWjrBLeHTfjX/INR
 m8Lxid2wP5dsA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Alexander Gendin <agendin@matrox.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] test: use %zd for size_t in mbr_test_run()
Date: Sun,  3 Nov 2024 23:48:11 +0100
Message-ID: <20241103224812.195778-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
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

For printing size_t we must use %zd and not %ld to avoid
a -Wformat error on 32-bit systems.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/mbr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index 16a8bc39e7e..d137378a3be 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -257,8 +257,8 @@ static int mbr_test_run(struct unit_test_state *uts)
 		strlen(mbr_parts_p3) +
 		max(strlen(mbr_parts_p4), strlen(mbr_parts_p5)) +
 		strlen(mbr_parts_tail);
-	ut_assertf(sizeof(mbr_parts_buf) >= mbr_parts_max, "Buffer avail: %ld; buffer req: %ld\n",
-		sizeof(mbr_parts_buf), mbr_parts_max);
+	ut_assertf(sizeof(mbr_parts_buf) >= mbr_parts_max, "Buffer avail: %zd; buffer req: %ld\n",
+		   sizeof(mbr_parts_buf), mbr_parts_max);
 
 	mbr_wbuf = map_sysmem(mbr_wa, BLKSZ);
 	ebr_wbuf = map_sysmem(ebr_wa, BLKSZ);
-- 
2.45.2

