Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C425ACFD2F6
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 22:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF1183BF1;
	Sun, 23 Nov 2025 23:58:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bmr1MXbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0497D83C04; Sun, 23 Nov 2025 23:58:01 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B74D83BFE
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 2B75B40979; 
 Sun, 23 Nov 2025 22:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938674;
 bh=oQ4y6vsljhb52mERZhKSVQ4nFAu5/D8+erwJmz9NFnM=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=bmr1MXbUD6JHL3xelR0PG9iXIRI6FPFJvbw7LC4JuWuArtzyYwiF/aAsqlApNID8S
 BWN7nWDTNZvZX0oxg0zMiM8h55Ba0lSC/1E7ptraH+ZINNgW/90Pqq9Vue5/Yy02n1
 72fTrYgSIlxeVm7Mb1FDgr41kOFvrSmWC+ko5nN5QtStUftm2nrAuNzpVT4WG1cYQM
 5dTaaN3V2QsY9ae1nB2IMOk/YbhxLIKgFzFN6U6pWE28YWtXsKb8R1v6c61O6I6jdJ
 D1Lu1gg7MSxqfoatOJOYxF0tSBkxoTJkHG0VLH9o9Lav+T/GsnIcO+dQcyadbF3fYk
 TlxsqkQZRu6ifVSONMTndQrfNb2YO0vktS2B3D0FnHiEm9eW1Co1L8S6uhTmRalBJC
 kxrCao0Mw+BUOBqX81Kg/flp+8JFApd4jhr2iEOijFdlTvKL9Rpiy0Uilgkoh8WgP9
 +LPKmQuc90JTf97c1aC+mqFfc1ixm51QxnOwqNPpCShAhz1J87FKyGq9JydtlRI3Y2
 qitegcszzlc8Fp/nbaAICf+EqGgtOVAsoSz4K1/CAomxSEzQQcNdAguVe8Fck0yPfd
 DtBFA5Kxiru8OFkSmBUIvWHT/moiDuqKQKd64x4lq4LiAZHZnv6qb9irGzkgZ9dnuH
 ZulvkMI+hKP+GSm9m49jWBNY=
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
Subject: [[RESEND][PATCH 02/19] test: cmd/bdinfo: consider ARM architecture
 specific info
Date: Sun, 23 Nov 2025 23:56:54 +0100
Message-ID: <20251123225711.227016-3-heinrich.schuchardt@canonical.com>
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

On ARM the bdinfo command prints architecture specific information.
The test needs to accept these output lines.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/bdinfo.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 28d448a0866..9ffa0d3cdd5 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -224,6 +224,34 @@ static int bdinfo_test_all(struct unit_test_state *uts)
 	if (gd->arch.firmware_fdt_addr)
 		ut_check_console_linen(uts, "firmware fdt");
 #endif
+#ifdef CONFIG_ARM
+	ut_check_console_linen(uts, "arch_number");
+#ifdef CFG_SYS_MEM_RESERVE_SECURE
+	if (gd->arch.secure_ram & MEM_RESERVE_SECURE_SECURED)
+		ut_check_console_linen(uts, "Secure ram");
+#endif
+#ifdef CONFIG_RESV_RAM
+	if (gd->arch.resv_ram)
+		ut_check_console_linen(uts, "Reserved ram");
+#endif
+#if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+	ut_check_console_linen(uts, "TLB addr");
+#endif
+	ut_check_console_linen(uts, "irq_sp");
+	ut_check_console_linen(uts, "sp start");
+#ifdef CONFIG_CLOCKS
+	ut_check_console_linen(uts, "ARM frequency =");
+	ut_check_console_linen(uts, "DSP frequency =");
+	ut_check_console_linen(uts, "DDR frequency =");
+#endif
+#ifdef CONFIG_BOARD_TYPES
+	ut_check_console_linen(uts, "Board Type  =");
+#endif
+#if CONFIG_IS_ENABLED(SYS_MALLOC_F)
+	ut_check_console_linen(uts, "Early malloc usage:");
+#endif
+
+#endif /* CONFIG_ARM */
 
 	return 0;
 }
-- 
2.51.0

