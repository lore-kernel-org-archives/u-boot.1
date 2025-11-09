Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674E5CD1297
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 10:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 108DE83F32;
	Sun,  9 Nov 2025 11:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="J3TiTV8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ED4483F15; Sun,  9 Nov 2025 11:10:42 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A3B783E8A
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 11:10:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-110-120.46.114.pool.telefonica.de
 [46.114.110.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2FD55409F1; 
 Sun,  9 Nov 2025 10:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762683032;
 bh=St9c5t5aXrQYmsuMz7DhcjMr5JwkSSZXNMLWjqZCEQY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=J3TiTV8rtdIm6UF/b50lxGD14yufZBBXVLyj1qEdIUCz3ONcYzOmG3hq7Tk9rBUiW
 JCNyrbE1aISeNcEDAxVWtVXtnXIPV2/6a70AuZl8N1CCGjpbR3HgcmZxk34VM83Hni
 t0B7D4ZVTXgTHOwo2JjmHyRg16xn8q4axRDzIJNZ2GER3YEB4i98jkHMt3asO9V0SJ
 /kjfvN4p4Yl6aeW5CUNS4EEWJX3lmUWtA+wTcXGDUyDVzNZUmb7omKn10bE25eEoIY
 69XFYfHdjNFB636DeTobsOb8yzl3/MXhR2Sz2UlafLiOETDiUD8HV2Vz//iPRTXohV
 rOcDV6FYeEnAGSB9ywIIAVZwx7ATeGBSHjxjvzPgHI0z7lcukGYbwL9DQDqVee8mQh
 wdKtQ/vPNqUiRwY40El7pQjLagQKQXKDpjs/r679p4nUClnJZD8Zu5Dv1kXdxR88Zm
 1dV3NGues+oceqfapopIU8Wnaj3z5uqF4cTH6vtxWoubf17ksG9pcAzT7ktGPsaRCU
 L76SvxCTIQVdsVpfPWLD7Qb2tbqx0qSXcURQ+XdY9LeL1YKXzCxI83nYgUcZJKWCum
 Ku1N5im3so1zoL1KgmO+eMY2jwrvQZB9K5npBwIuIqk/0lCxtTtX52xK16GDczZ8um
 aUVIXMTbus4sQIsMSYbpgekg=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Harrison Mutai <harrison.mutai@arm.com>, Peng Fan <peng.fan@nxp.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Rick Chen <rick@andestech.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 6/9] test: cmd/fdt: do not use fixed buffer addresses
Date: Sun,  9 Nov 2025 11:10:07 +0100
Message-ID: <20251109101010.306268-7-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
References: <20251109101010.306268-1-heinrich.schuchardt@canonical.com>
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

The location of memory depends on the board. Do not assume memory at fixed
memory locations. Use memalign() instead to allocate a buffer.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/cmd/fdt.c      |  8 ++++++--
 test/common/print.c | 37 ++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/test/cmd/fdt.c b/test/cmd/fdt.c
index b950123b6da..4c3c6308ab4 100644
--- a/test/cmd/fdt.c
+++ b/test/cmd/fdt.c
@@ -265,7 +265,7 @@ FDT_TEST(fdt_test_addr_resize, UTF_CONSOLE);
 static int fdt_test_move(struct unit_test_state *uts)
 {
 	char fdt[256];
-	ulong addr, newaddr = 0x10000;
+	ulong addr, newaddr;
 	const int size = sizeof(fdt);
 	uint32_t ts;
 	void *buf;
@@ -275,8 +275,10 @@ static int fdt_test_move(struct unit_test_state *uts)
 	ts = fdt_totalsize(fdt);
 
 	/* Moved target DT location */
-	buf = map_sysmem(newaddr, size);
+	buf = memalign(8, size);
+	ut_assertnonnull(buf);
 	memset(buf, 0, size);
+	newaddr = map_to_sysmem(buf);
 
 	/* Test moving the working FDT to a new location */
 	ut_assertok(run_commandf("fdt move %08lx %08lx %x", addr, newaddr, ts));
@@ -288,6 +290,8 @@ static int fdt_test_move(struct unit_test_state *uts)
 	ut_assert_nextline("Total of %d byte(s) were the same", ts);
 	ut_assert_console_end();
 
+	free(buf);
+
 	return 0;
 }
 FDT_TEST(fdt_test_move, UTF_CONSOLE);
diff --git a/test/common/print.c b/test/common/print.c
index 2ac7eeed2c1..f33476a36b4 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -266,74 +266,70 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 {
 	u8 *buf;
 	int i;
+	ulong addr;
 
 	buf = calloc(1, BUF_SIZE);
 	ut_assertnonnull(buf);
+	addr = map_to_sysmem(buf);
 	for (i = 0; i < 0x11; i++)
 		buf[i] = i * 0x11;
 
 	/* bytes */
 	print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
 	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
 	ut_assert_nextline("%0*lx: 10 00                                            ..",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf + 0x10UL);
+			   addr + 0x10UL);
 	ut_assert_console_end();
 
 	/* line length */
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 8, 1, buf, 0x12, true);
 	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77  ..\"3DUfw",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
 	ut_assert_nextline("%0*lx: 88 99 aa bb cc dd ee ff  ........",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf + 0x8UL);
+			   addr + 0x8UL);
 	ut_assert_nextline("%0*lx: 10 00                    ..",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf + 0x10UL);
+			   addr + 0x10UL);
 	ut_assert_console_end();
 
 	/* long line */
 	buf[0x41] = 0x41;
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0x40, 1, buf, 0x42, true);
 	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..\"3DUfw........................................................",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
 	ut_assert_nextline("%0*lx: 00 41                                                                                                                                                                                            .A",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf + 0x40UL);
+			   addr + 0x40UL);
 	ut_assert_console_end();
 
 	/* 16-bit */
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 2, buf, 0x12, true);
 	ut_assert_nextline("%0*lx: 1100 3322 5544 7766 9988 bbaa ddcc ffee  ..\"3DUfw........",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
 	ut_assert_nextline("%0*lx: 0010                                     ..",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf + 0x10UL);
+			   addr + 0x10UL);
 	ut_assert_console_end();
 
 	/* 32-bit */
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 4, buf, 0x14, true);
 	ut_assert_nextline("%0*lx: 33221100 77665544 bbaa9988 ffeeddcc  ..\"3DUfw........",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
 	ut_assert_nextline("%0*lx: 00000010                             ....",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf + 0x10UL);
+			   addr + 0x10UL);
 	ut_assert_console_end();
 
 	/* 64-bit */
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 16, 8, buf, 0x18, true);
 	ut_assert_nextline("%0*lx: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
 	ut_assert_nextline("%0*lx: 0000000000000010                   ........",
 			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf + 0x10UL);
+			   addr + 0x10UL);
 	ut_assert_console_end();
 
 	/* ASCII */
@@ -345,8 +341,7 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	buf[8] = 255;
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 1, buf, 10, true);
 	ut_assert_nextline("%0*lx: 00 1f 20 21 7e 7f 80 81 ff 99                    .. !~.....",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
-			   (uintptr_t)buf);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, addr);
 	ut_assert_console_end();
 	free(buf);
 
-- 
2.51.0

