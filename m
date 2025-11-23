Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BC1CFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 23:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9843483C08;
	Sun, 23 Nov 2025 23:58:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="MA+cx7Qq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2056783CCF; Sun, 23 Nov 2025 23:58:53 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478A083B7E
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 9EA264497C; 
 Sun, 23 Nov 2025 22:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938695;
 bh=+PKaeZJxyGG1mTnXwMvz4SjlxZVlQPpVlu2jLzvgobM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=MA+cx7Qqp7GXt5zBZa4CxS0NmmfEbVytKqv2UPQ/dnF4yfV4zlSbgBreeTaskke9i
 fFDHULkSQ1Lf1ePH14Ma3U8Lx8P7SkFT3t6Tjou9pSwJMiRfwQVR/OIU6GJn3t27CQ
 H1jBL7iwoiS+9NDEVNIbMdjS9a5JtWVMg6eZOUgQmh9mV+rmfD1N30TuIT2Lx1YbW8
 h9uTlj3N4cZ+l3Blihk66ezfAefcmVlFfPv1J0DjL8/tTLMPV0iaxfEThK1Ehy1P00
 6GNJpAIWCLsBBftA4ne70TfQU0mhAURv0gbcmj8u2GG2gjqbXKe9sZe627YGvGHwVU
 mmMkfl82bizKi2aAC9C8MgmGCngrOvgRA6jyg/Iqr6NnLXgM4NAH0eBkULxOVtbPSI
 G92Tv/49DcLhDo72sIR3A7XySNbMRwiSHrsCqIWjQ3EySlLf2wwjPCIwJ2zQXD4WqB
 L6sRDuGt+9jAeiF73pYZELj79b9as1AIq2IDMcBi4wXcgjnVA8LtE7g8u30jh2YWVZ
 ilTGTSpjIjeWPgHGkOYntD5t5yNPkzo5dKaOlJLXGA3xsPLXmvxOfLssstWWa99ZUI
 vhHcY14bYZ5dw046pPdX4KwPFaczR1Z8yDR7iZzHgnUZP/yNaYw+xhhnUjbESP9CDn
 n5byxUbjFmEAUGoQ9snLmSHQ=
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
Subject: [PATCH 16/19] test: relax cread_test time constraint
Date: Sun, 23 Nov 2025 23:57:08 +0100
Message-ID: <20251123225711.227016-17-heinrich.schuchardt@canonical.com>
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

The ppce500 is not as fine grained as expected.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/common/cread.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/test/common/cread.c b/test/common/cread.c
index 4926c216803..5afc7397212 100644
--- a/test/common/cread.c
+++ b/test/common/cread.c
@@ -90,13 +90,14 @@ static int cread_test(struct unit_test_state *uts)
 	ut_asserteq(5, cli_readline_into_buffer("-> ", buf, 1));
 	ut_asserteq_str("abcXx", buf);
 
-	/* check timeout, should be between 1000 and 1050ms */
+	/* check timeout, should be between 900 and 1100ms */
 	start = get_timer(0);
 	*buf = '\0';
 	ut_asserteq(-2, cli_readline_into_buffer("-> ", buf, 1));
-	duration = get_timer(start) - 1000;
-	ut_assert(duration >= 0);
-	ut_assert(duration < 50);
+	printf("get_timer(start): %ld", get_timer(start));
+	duration = get_timer(start);
+	ut_assert(duration >= 900);
+	ut_assert(duration < 1100);
 
 	return 0;
 }
-- 
2.51.0

