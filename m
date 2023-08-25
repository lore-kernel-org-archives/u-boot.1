Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95181C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 08:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF12C86A28;
	Fri, 25 Aug 2023 10:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="SpQ6wRg6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="impK+KnM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09CF586A4B; Fri, 25 Aug 2023 10:20:10 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A47F986A15
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 10:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RXCYd6Z9rz9t4g;
 Fri, 25 Aug 2023 10:20:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692951605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tFaELeJEA2P+VrHDpATE1GaF66O8r4zL0G7toW0XJk4=;
 b=SpQ6wRg6K7GU5m+v1c3aZDCuEcSy3peMBZfEJWkGI4UOdrplY8tYhPWC0yJOI5Lx5zUGV3
 roieExdOJivxvtOP5uT703yr5GQmq8911Oi/wGkbey1DmaDoPLyDumXg5dwnG5/hnunapj
 38nlsE3jvDq+4yytFm49z1Ds53/iMmjEII/MBc4ZXgGyntV1EeQd28ugDgSy7+1J72r7jx
 jlfubzIegymA3a45owjOWykrt1uDz2HErRId8qEu89sm0ZhsfPCvUSL1xZtSindvt10Frl
 ymjKSTIMEzaVTnUVt96m37O+u2KlCwzUKSEFCb99Kvg2m2gXqTLZBRO/DXKAXw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692951603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=tFaELeJEA2P+VrHDpATE1GaF66O8r4zL0G7toW0XJk4=;
 b=impK+KnMUXAxrEOxnthw73702UR3Rwz16hpFLKp660iajrPAsCeM2ItQR623EFXuftvRM0
 4sbi3PE7/pk70iEfoNJ4O5HO0A2VTjGht5ABFTuAxZljbkyDKpeVdrImPcWVwdAGNiEiHA
 1Te9ivxr3SakLtRQyBcFCwbsn7eJEHkNE3ZHKCEgqEWGtbTIPWbP+hYeHbSinHQTiY0/he
 bZnsV7qkFvsurzFmobEeYn8GtJLVC0FfhGC1N0xfGtxXiXOAAwzkxvx2OtiNa2ZIRvw7iE
 vy0KzDWY4ixgyNRD2LAgefYw3TXjp5T3/if+z/sIXOYQRCehvz+wEWb+oP3Xwg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2] test: print: Fix hexdump test on 64bit systems
Date: Fri, 25 Aug 2023 10:19:40 +0200
Message-Id: <20230825081940.5866-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 9mcbxmcyfojznwjs7e7okt13pzngswax
X-MBO-RS-ID: dca0f5571a06b97b051
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

Use the following regex to make this test compatible with
both 32bit and 64bit systems. The trick is to use %0*lx
format string for the address prefix in the test.

"
s@\(ut_assert_nextline("\)0\+\([^:]\+\)\(:.*"\)\();\)@\1%0*lx\3, IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x\2UL\4
"

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Simon Glass <sjg@chromium.org>
---
V2: Break line before IS_ENABLED
---
 test/print_ut.c | 42 ++++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/test/print_ut.c b/test/print_ut.c
index 47a6ce57840..b26f6281b01 100644
--- a/test/print_ut.c
+++ b/test/print_ut.c
@@ -283,16 +283,21 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	/* bytes */
 	console_record_reset();
 	print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
-	ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........");
-	ut_assert_nextline("00000010: 10 00                                            ..");
+	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+	ut_assert_nextline("%0*lx: 10 00                                            ..",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
 	ut_assert_console_end();
 
 	/* line length */
 	console_record_reset();
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 8, 1, buf, 0x12, true);
-	ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77  ..\"3DUfw");
-	ut_assert_nextline("00000008: 88 99 aa bb cc dd ee ff  ........");
-	ut_assert_nextline("00000010: 10 00                    ..");
+	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77  ..\"3DUfw",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+	ut_assert_nextline("%0*lx: 88 99 aa bb cc dd ee ff  ........",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x8UL);
+	ut_assert_nextline("%0*lx: 10 00                    ..",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
 
@@ -300,31 +305,39 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	console_record_reset();
 	buf[0x41] = 0x41;
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0x40, 1, buf, 0x42, true);
-	ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..\"3DUfw........................................................");
-	ut_assert_nextline("00000040: 00 41                                                                                                                                                                                            .A");
+	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..\"3DUfw........................................................",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+	ut_assert_nextline("%0*lx: 00 41                                                                                                                                                                                            .A",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x40UL);
 	ut_assert_console_end();
 
 	/* 16-bit */
 	console_record_reset();
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 2, buf, 0x12, true);
-	ut_assert_nextline("00000000: 1100 3322 5544 7766 9988 bbaa ddcc ffee  ..\"3DUfw........");
-	ut_assert_nextline("00000010: 0010                                     ..");
+	ut_assert_nextline("%0*lx: 1100 3322 5544 7766 9988 bbaa ddcc ffee  ..\"3DUfw........",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+	ut_assert_nextline("%0*lx: 0010                                     ..",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
 
 	/* 32-bit */
 	console_record_reset();
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 4, buf, 0x14, true);
-	ut_assert_nextline("00000000: 33221100 77665544 bbaa9988 ffeeddcc  ..\"3DUfw........");
-	ut_assert_nextline("00000010: 00000010                             ....");
+	ut_assert_nextline("%0*lx: 33221100 77665544 bbaa9988 ffeeddcc  ..\"3DUfw........",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+	ut_assert_nextline("%0*lx: 00000010                             ....",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
 
 	/* 64-bit */
 	console_record_reset();
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 16, 8, buf, 0x18, true);
-	ut_assert_nextline("00000000: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........");
-	ut_assert_nextline("00000010: 0000000000000010                   ........");
+	ut_assert_nextline("%0*lx: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+	ut_assert_nextline("%0*lx: 0000000000000010                   ........",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
 
@@ -337,7 +350,8 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 		buf[4 + i] = 126 + i;
 	buf[8] = 255;
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 1, buf, 10, true);
-	ut_assert_nextline("00000000: 00 1f 20 21 7e 7f 80 81 ff 99                    .. !~.....");
+	ut_assert_nextline("%0*lx: 00 1f 20 21 7e 7f 80 81 ff 99                    .. !~.....",
+			   IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
 
-- 
2.40.1

