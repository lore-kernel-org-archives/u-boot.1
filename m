Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CD0CFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 23:00:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EAA883CBD;
	Sun, 23 Nov 2025 23:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="E3mk4dWl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F3BB83B7E; Sun, 23 Nov 2025 23:58:50 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66B3A83CB8
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 1EFA94497A; 
 Sun, 23 Nov 2025 22:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938692;
 bh=V7Ke1EIgRzV2RtnN8ktp27I63eN26vqO8xzGDo6VFWo=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=E3mk4dWlDRdVrOCz3x0Hkg5Z9pp0oJ8f8/l1StmRfk5DjpdHvBxQlgK25geKFePOP
 4NyTLmamgl9sNtC+MorQ4d4/ExTQn8QtnDs5A50vMgqvHnEP2lyENeaTlXbPs0idt4
 n7uonAIBOdrB9//lQEKTqR6kDP8OY/+JMgjSiL7/lPuteZU3jmX4iYrqtux2/NZIAy
 mUBwTsiLEFF0PzzK3ASPYrTCSGaLpQaMvNZ2Q5JK/gIyGBxFL5Z4qlViuFPCDmUjqb
 se9XUAUJHyAJ6WN3gejCJOC4bJFU9Tt4sanXHf0mDDTyORXUUnp7lV21O0cTDye/Y7
 15a4SKWuDIt16waBjRYeM4MLDA5Cz1EMAhGd7GZNs/kD1nJL0cjGxut886leS3ieSH
 Qv9cNulHZ2WBCHxTPnFz/atRg2DcSkepaXDZCECEZgOATwub/TxWq1ez5AkyMXaul/
 fAvwaT0BHYeVuOO7fceQ3OG2HjFu3dr39mHptOnzNXh95suTvnemmMmi9gEBT09dRH
 pLHdfgePI4Sv4ukwDkAEPNMOBoLM041YBZJpg6Dz12ATkCty3jXyifvn9KPHIT6EDq
 tSYOjYjibskWR63WhiH/jkLbWTIMHTH/EIZrfBdvxHeG3ITzQUXNhsxPXLecIKW+cv
 /VCRUIG1cIMEIFtx42upMDZM=
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
Subject: [PATCH 15/19] test: fix cmt/msr test
Date: Sun, 23 Nov 2025 23:57:07 +0100
Message-ID: <20251123225711.227016-16-heinrich.schuchardt@canonical.com>
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

The original value of the first variable msr (0x200) is not controlled by
U-Boot. Don't make any assumption.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/msr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/cmd/msr.c b/test/cmd/msr.c
index e9a152ee5bf..7512c83338a 100644
--- a/test/cmd/msr.c
+++ b/test/cmd/msr.c
@@ -12,14 +12,14 @@
 static int cmd_test_msr(struct unit_test_state *uts)
 {
 	ut_assertok(run_commandf("msr read 200"));
-	ut_assert_nextline("00000000 ffe00006");
+	ut_assert_nextlinen("0000");
 	ut_assert_console_end();
 
 	/* change the first variable msr and see it reflected in the mtrr cmd */
 	ut_assertok(run_commandf("mtrr"));
 	ut_assert_nextline("CPU 65537:");
 	ut_assert_nextlinen("Reg");
-	ut_assert_nextlinen("0   Y     Back         00000000ffe00000");
+	ut_assert_nextlinen("0   Y     Back");
 	ut_assertok(console_record_reset_enable());
 
 	/* change the type from 6 to 5 */
-- 
2.51.0

