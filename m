Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A07E1CCFA13
	for <u-boot@archiver.kernel.org>; Sun,  9 Nov 2025 10:11:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA10D83F15;
	Sun,  9 Nov 2025 11:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="JvpRKJ08";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85CC083F32; Sun,  9 Nov 2025 11:10:41 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88D6E83F1F
 for <u-boot@lists.denx.de>; Sun,  9 Nov 2025 11:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03 (dynamic-046-114-110-120.46.114.pool.telefonica.de
 [46.114.110.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CD6EE409F0; 
 Sun,  9 Nov 2025 10:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1762683031;
 bh=SMJ83y7JEYPU8zElhT/+wbq9+Pth48PcezxtAkbMT4U=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=JvpRKJ08+gvpS7W20g9EszWAtjH4ndc6OmfHyKK/HfWp8TbDBW4/fihRSdAqTll0l
 WT3p23jjIN9vDK3sQJP3fPRPh3FDmcSWGDvazFGTrHTN/968hGqPFJhstM0vXW7SNf
 ITKK1anlWstlohFC4Srd2iI1aQqxqNV78EnRq0wJWJ0exYAHR1PQtKYxxnV303wG0t
 FtWpKynKMLufrGidTXIkuR5ujIqEpNaX9DkgL5boP9ZQj+rb1iYnyTMj94pIJD9F1H
 phYU3DQ5J89THY7H0SziohoaISA6hyGu78wIzcy5+o/ij5vw+eFhi5Rux1UF0p580X
 /988SE8aLnnRYFcIIYjrJwhs9kIq2cSk8LI9qFAdMaUy61RUNt2ag9AhM7wWFNdrFt
 yHrSuN4/lT+96N6ZnCSlIDDwgHVdkZdR1n0g1zbY65KEIA5ib/9nGbg1grUh9jJXbN
 RM2nqxym0Mhl/c1ZkdN+PgnmHTXZF887QEXJ5Iau+j6o7iAx5qAtUSOUoH1GNz9Edn
 f0hsdruSK+3g6nvodc1P+oZh1CNxU6Yu3ERjxvx3+Lf2Og+haMvtQb2nMJTs6OaDrf
 oHThL09H9C4mF6hAgW088g+WOrUvfdAqo61TyD6NYpu17FRRuYbQn2rDRqetzGJoXf
 mITGQhFsitXd2kghIV/YWXXI=
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
Subject: [PATCH 5/9] test: common/print: do not use fixed buffer addresses
Date: Sun,  9 Nov 2025 11:10:06 +0100
Message-ID: <20251109101010.306268-6-heinrich.schuchardt@canonical.com>
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
memory locations. Use calloc() instead to allocate buffers.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 test/common/print.c | 76 ++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 36 deletions(-)

diff --git a/test/common/print.c b/test/common/print.c
index 76ee851fe6a..2ac7eeed2c1 100644
--- a/test/common/print.c
+++ b/test/common/print.c
@@ -168,12 +168,8 @@ static int print_display_buffer(struct unit_test_state *uts)
 	u8 *buf;
 	int i;
 
-	/* This test requires writable memory at zero */
-	if (IS_ENABLED(CONFIG_X86))
-		return -EAGAIN;
-
-	buf = map_sysmem(0, BUF_SIZE);
-	memset(buf, '\0', BUF_SIZE);
+	buf = calloc(1, BUF_SIZE);
+	ut_assertnonnull(buf);
 	for (i = 0; i < 0x11; i++)
 		buf[i] = i * 0x11;
 
@@ -232,7 +228,7 @@ static int print_display_buffer(struct unit_test_state *uts)
 	ut_assert_nextline("00000000: 00 1f 20 21 7e 7f 80 81 ff 99                    .. !~.....");
 	ut_assert_console_end();
 
-	unmap_sysmem(buf);
+	free(buf);
 
 	return 0;
 }
@@ -244,13 +240,14 @@ static int print_hexdump_line(struct unit_test_state *uts)
 	u8 *buf;
 	int i;
 
-	buf = map_sysmem(0, BUF_SIZE);
-	memset(buf, '\0', BUF_SIZE);
+	buf = calloc(1, BUF_SIZE);
+	ut_assertnonnull(buf);
 	for (i = 0; i < 0x11; i++)
 		buf[i] = i * 0x11;
 
 	/* Check buffer size calculations */
-	linebuf = map_sysmem(0x400, BUF_SIZE);
+	linebuf = calloc(1, BUF_SIZE);
+	ut_assertnonnull(buf);
 	memset(linebuf, '\xff', BUF_SIZE);
 	ut_asserteq(-ENOSPC, hexdump_line(0, buf, 1, 0x10, 0, linebuf, 75));
 	ut_asserteq(0xff, linebuf[0]);
@@ -258,7 +255,8 @@ static int print_hexdump_line(struct unit_test_state *uts)
 	ut_asserteq('\0', linebuf[75]);
 	ut_asserteq(0xff, linebuf[76]);
 
-	unmap_sysmem(buf);
+	free(linebuf);
+	free(buf);
 
 	return 0;
 }
@@ -269,69 +267,74 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	u8 *buf;
 	int i;
 
-	/* This test requires writable memory at zero */
-	if (IS_ENABLED(CONFIG_X86))
-		return -EAGAIN;
-
-	buf = map_sysmem(0, BUF_SIZE);
-	memset(buf, '\0', BUF_SIZE);
+	buf = calloc(1, BUF_SIZE);
+	ut_assertnonnull(buf);
 	for (i = 0; i < 0x11; i++)
 		buf[i] = i * 0x11;
 
 	/* bytes */
 	print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
 	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf);
 	ut_assert_nextline("%0*lx: 10 00                                            ..",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf + 0x10UL);
 	ut_assert_console_end();
 
 	/* line length */
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 8, 1, buf, 0x12, true);
 	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77  ..\"3DUfw",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf);
 	ut_assert_nextline("%0*lx: 88 99 aa bb cc dd ee ff  ........",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x8UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf + 0x8UL);
 	ut_assert_nextline("%0*lx: 10 00                    ..",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf + 0x10UL);
 	ut_assert_console_end();
-	unmap_sysmem(buf);
 
 	/* long line */
 	buf[0x41] = 0x41;
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0x40, 1, buf, 0x42, true);
 	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..\"3DUfw........................................................",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf);
 	ut_assert_nextline("%0*lx: 00 41                                                                                                                                                                                            .A",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x40UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf + 0x40UL);
 	ut_assert_console_end();
 
 	/* 16-bit */
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 2, buf, 0x12, true);
 	ut_assert_nextline("%0*lx: 1100 3322 5544 7766 9988 bbaa ddcc ffee  ..\"3DUfw........",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf);
 	ut_assert_nextline("%0*lx: 0010                                     ..",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf + 0x10UL);
 	ut_assert_console_end();
-	unmap_sysmem(buf);
 
 	/* 32-bit */
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 4, buf, 0x14, true);
 	ut_assert_nextline("%0*lx: 33221100 77665544 bbaa9988 ffeeddcc  ..\"3DUfw........",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf);
 	ut_assert_nextline("%0*lx: 00000010                             ....",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf + 0x10UL);
 	ut_assert_console_end();
-	unmap_sysmem(buf);
 
 	/* 64-bit */
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 16, 8, buf, 0x18, true);
 	ut_assert_nextline("%0*lx: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf);
 	ut_assert_nextline("%0*lx: 0000000000000010                   ........",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf + 0x10UL);
 	ut_assert_console_end();
-	unmap_sysmem(buf);
 
 	/* ASCII */
 	buf[1] = 31;
@@ -342,9 +345,10 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	buf[8] = 255;
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 1, buf, 10, true);
 	ut_assert_nextline("%0*lx: 00 1f 20 21 7e 7f 80 81 ff 99                    .. !~.....",
-			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8,
+			   (uintptr_t)buf);
 	ut_assert_console_end();
-	unmap_sysmem(buf);
+	free(buf);
 
 	return 0;
 }
-- 
2.51.0

