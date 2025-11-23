Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77DBCFD313
	for <u-boot@archiver.kernel.org>; Sun, 23 Nov 2025 23:00:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 249A083BF1;
	Sun, 23 Nov 2025 23:58:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VLNGIjcY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3528E83B7E; Sun, 23 Nov 2025 23:58:46 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4669583CB8
 for <u-boot@lists.denx.de>; Sun, 23 Nov 2025 23:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E6E3444979; 
 Sun, 23 Nov 2025 22:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1763938690;
 bh=JcboA0CKaBajgrHjSPcoheYjXmk4BaKMDjkqDOJ2NhE=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=VLNGIjcYwXFTMopjpFHITmPpKBRzCrkS1PWDXZpxHrNe9aDGUGol111ljJYfVBBiO
 JsRw5tuHZRWMYYojpaztwt0RL7qRzZgFe1w7x3UccEJ5RkGqIE46QFuXgZO3f4+A9u
 ay0r7g4yheWEroWKeF6vMYBCTQSSbg1M616zm/MBGfCZjskVhbCSgl9aTiW8oTlmU1
 R8C6lHJCzkaQurvSBwJRShNzT80TykoalKhujfyhhKSiuuW+thKRcVazbtfQrMLjeQ
 3HEMr5FMXhVNGhJGhS5Z70XUHZNPF0mv5s43bS+jYJI5qFmJ1ltjPttyWyuJO5TDu7
 7ET09L2yS/FD21EiaQ+SG/pKyskqqw132mqDyXsjHL70upN0xya7l7nni0knlRjkOg
 3Z4FiO44cxEVYZFXwPMW+qX+0+QueDEV3UMk5MJ6eNEJGM/dhIp97EgEsaKbGRbiFj
 CvwCViu6Gk9d15cCwLskAN6kGL5GPf3qTH/cmSQpxS664VUCa1qFCBsonaXiepIRjg
 82R9E4kJ379EWQorp1bXto17ZKPI7y6+n3+daOOqVp12CEhdIxsJ4BtEDB8CFld7n5
 An59kKS7nzv3cL7IqI07F2nbi3dLxwpEIQX5n8oLCrBaR2gyQ+30JSbiI4Dp6s47wc
 dhmsz4PArxZx5+AERSOSVR10=
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
Subject: [PATCH 14/19] test: consider endianness in print_display_buffer
Date: Sun, 23 Nov 2025 23:57:06 +0100
Message-ID: <20251123225711.227016-15-heinrich.schuchardt@canonical.com>
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

Hexdumps for types other then byte look different in dependence of the
endianness.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/common/print.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/test/common/print.c b/test/common/print.c
index 23109188317..27fdb444d0d 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -202,21 +202,36 @@ static int print_display_buffer(struct unit_test_state *uts)
 
 	/* 16-bit */
 	print_buffer(0, buf, 2, 9, 0);
+#ifdef __BIG_ENDIAN
+	ut_assert_nextline("00000000: 0011 2233 4455 6677 8899 aabb ccdd eeff  ..\"3DUfw........");
+	ut_assert_nextline("00000010: 1000                                     ..");
+#else
 	ut_assert_nextline("00000000: 1100 3322 5544 7766 9988 bbaa ddcc ffee  ..\"3DUfw........");
 	ut_assert_nextline("00000010: 0010                                     ..");
+#endif
 	ut_assert_console_end();
 
 	/* 32-bit */
 	print_buffer(0, buf, 4, 5, 0);
+#ifdef __BIG_ENDIAN
+	ut_assert_nextline("00000000: 00112233 44556677 8899aabb ccddeeff  ..\"3DUfw........");
+	ut_assert_nextline("00000010: 10000000                             ....");
+#else
 	ut_assert_nextline("00000000: 33221100 77665544 bbaa9988 ffeeddcc  ..\"3DUfw........");
 	ut_assert_nextline("00000010: 00000010                             ....");
+#endif
 	ut_assert_console_end();
 
 	/* 64-bit */
 	if (MEM_SUPPORT_64BIT_DATA) {
 		print_buffer(0, buf, 8, 3, 0);
+#ifdef __BIG_ENDIAN
+		ut_assert_nextline("00000000: 0011223344556677 8899aabbccddeeff  ..\"3DUfw........");
+		ut_assert_nextline("00000010: 1000000000000000                   ........");
+#else
 		ut_assert_nextline("00000000: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........");
 		ut_assert_nextline("00000010: 0000000000000010                   ........");
+#endif
 		ut_assert_console_end();
 	}
 
@@ -313,29 +328,53 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 
 	/* 16-bit */
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 2, buf, 0x12, true);
+#ifdef __BIG_ENDIAN
+	ut_assert_nextline("%0*lx: 0011 2233 4455 6677 8899 aabb ccdd eeff  ..\"3DUfw........",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
+	ut_assert_nextline("%0*lx: 1000                                     ..",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   addr + 0x10UL);
+#else
 	ut_assert_nextline("%0*lx: 1100 3322 5544 7766 9988 bbaa ddcc ffee  ..\"3DUfw........",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
 	ut_assert_nextline("%0*lx: 0010                                     ..",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
 			   addr + 0x10UL);
+#endif
 	ut_assert_console_end();
 
 	/* 32-bit */
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 4, buf, 0x14, true);
+#ifdef __BIG_ENDIAN
+	ut_assert_nextline("%0*lx: 00112233 44556677 8899aabb ccddeeff  ..\"3DUfw........",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
+	ut_assert_nextline("%0*lx: 10000000                             ....",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   addr + 0x10UL);
+#else
 	ut_assert_nextline("%0*lx: 33221100 77665544 bbaa9988 ffeeddcc  ..\"3DUfw........",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
 	ut_assert_nextline("%0*lx: 00000010                             ....",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
 			   addr + 0x10UL);
+#endif
 	ut_assert_console_end();
 
 	/* 64-bit */
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 16, 8, buf, 0x18, true);
+#ifdef __BIG_ENDIAN
+	ut_assert_nextline("%0*lx: 0011223344556677 8899aabbccddeeff  ..\"3DUfw........",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
+	ut_assert_nextline("%0*lx: 1000000000000000                   ........",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   addr + 0x10UL);
+#else
 	ut_assert_nextline("%0*lx: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
 	ut_assert_nextline("%0*lx: 0000000000000010                   ........",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
 			   addr + 0x10UL);
+#endif
 	ut_assert_console_end();
 
 	/* ASCII */
-- 
2.51.0

