Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9CBEC3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 19:38:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D4428644E;
	Wed, 23 Aug 2023 21:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="f/HfYCup";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CI67sMN6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F90686439; Wed, 23 Aug 2023 21:38:24 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9D67086439
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 21:38:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4RWGjB2lJ4z9sqG;
 Wed, 23 Aug 2023 21:38:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692819502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=psiXO7EqT9HjvnTQWGvKP7D640LYca0XDXNvfL5vkpU=;
 b=f/HfYCupx1ZKsQcG9hRZ57cdLEXmvrRgfo3n+Cy6+qEiHuL40DGtlRvTYfO8/0xir3bN7W
 kRL5VytuPQ/H8IsurWURx5Ya5DYr3g4uKTJ3Z64wrau5fwOovDVgFFP9r2OErX8e5i/Lk/
 mlaj0Ne5UzPwqMxBoYwK+nbuaUc98BCKCgRfp2fMsf371TUfybmF0CXGCXBtPapb4r4Xcf
 tBc6YgqqbNlhBinyJf7hr5ch9qw8jJb2851tFe8lEO1aHqzc3hE09xtc+ULXa6UC8VZhch
 myaSGx4jYtJhcmhEBIdsoR/fROILB0+vs3UuU24l+T8ejcA1yChstV1RQbKZuQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1692819500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=psiXO7EqT9HjvnTQWGvKP7D640LYca0XDXNvfL5vkpU=;
 b=CI67sMN6o3iquo1xXvdrtejNKuGvFGT2OhaD54xIq9fokdCFm9lCe8Rcvoh7GPTKrxR3Xj
 ZSAtsJ5vC93QPG6ny8jiSH4xztUP0GejdiC5Mo6QtVruQ8u01a7CQH+kf3Os0UTbT0mHey
 436UxhOllA0vMzyw4joC3nz4tugmaHt0YagNVOdW+4guO89aVVjGEko0eiWR13oQM2g+fN
 j6rG1DGc+2C+WpuElB//c0fS1FF+E+ErEblhjxh98JJvzb2v6b7jJPfOkYDtA5t/wejdD0
 NmTD2taNXeROUXMUbQWKK9On8UC4xvTJgI8My3ZXM2ERUcK6MFe2siemxHKcrA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mario Six <mario.six@gdsys.cc>, Simon Glass <sjg@chromium.org>
Subject: [PATCH] test: print: Fix hexdump test on 64bit systems
Date: Wed, 23 Aug 2023 21:38:15 +0200
Message-Id: <20230823193815.64213-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: ou4mwwxnmkcfoypz8mpiyinphzbienx8
X-MBO-RS-ID: 1f9dd1e020a3b1ca63a
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
 test/print_ut.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/test/print_ut.c b/test/print_ut.c
index 47a6ce57840..0a994a05cf6 100644
--- a/test/print_ut.c
+++ b/test/print_ut.c
@@ -283,16 +283,16 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	/* bytes */
 	console_record_reset();
 	print_hex_dump_bytes("", DUMP_PREFIX_ADDRESS, buf, 0x12);
-	ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........");
-	ut_assert_nextline("00000010: 10 00                                            ..");
+	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff  ..\"3DUfw........", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+	ut_assert_nextline("%0*lx: 10 00                                            ..", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
 	ut_assert_console_end();
 
 	/* line length */
 	console_record_reset();
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 8, 1, buf, 0x12, true);
-	ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77  ..\"3DUfw");
-	ut_assert_nextline("00000008: 88 99 aa bb cc dd ee ff  ........");
-	ut_assert_nextline("00000010: 10 00                    ..");
+	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77  ..\"3DUfw", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+	ut_assert_nextline("%0*lx: 88 99 aa bb cc dd ee ff  ........", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x8UL);
+	ut_assert_nextline("%0*lx: 10 00                    ..", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
 
@@ -300,31 +300,31 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 	console_record_reset();
 	buf[0x41] = 0x41;
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0x40, 1, buf, 0x42, true);
-	ut_assert_nextline("00000000: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..\"3DUfw........................................................");
-	ut_assert_nextline("00000040: 00 41                                                                                                                                                                                            .A");
+	ut_assert_nextline("%0*lx: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee ff 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ..\"3DUfw........................................................", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+	ut_assert_nextline("%0*lx: 00 41                                                                                                                                                                                            .A", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x40UL);
 	ut_assert_console_end();
 
 	/* 16-bit */
 	console_record_reset();
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 2, buf, 0x12, true);
-	ut_assert_nextline("00000000: 1100 3322 5544 7766 9988 bbaa ddcc ffee  ..\"3DUfw........");
-	ut_assert_nextline("00000010: 0010                                     ..");
+	ut_assert_nextline("%0*lx: 1100 3322 5544 7766 9988 bbaa ddcc ffee  ..\"3DUfw........", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+	ut_assert_nextline("%0*lx: 0010                                     ..", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
 
 	/* 32-bit */
 	console_record_reset();
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 4, buf, 0x14, true);
-	ut_assert_nextline("00000000: 33221100 77665544 bbaa9988 ffeeddcc  ..\"3DUfw........");
-	ut_assert_nextline("00000010: 00000010                             ....");
+	ut_assert_nextline("%0*lx: 33221100 77665544 bbaa9988 ffeeddcc  ..\"3DUfw........", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+	ut_assert_nextline("%0*lx: 00000010                             ....", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
 
 	/* 64-bit */
 	console_record_reset();
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 16, 8, buf, 0x18, true);
-	ut_assert_nextline("00000000: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........");
-	ut_assert_nextline("00000010: 0000000000000010                   ........");
+	ut_assert_nextline("%0*lx: 7766554433221100 ffeeddccbbaa9988  ..\"3DUfw........", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
+	ut_assert_nextline("%0*lx: 0000000000000010                   ........", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x10UL);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
 
@@ -337,7 +337,7 @@ static int print_do_hex_dump(struct unit_test_state *uts)
 		buf[4 + i] = 126 + i;
 	buf[8] = 255;
 	print_hex_dump("", DUMP_PREFIX_ADDRESS, 0, 1, buf, 10, true);
-	ut_assert_nextline("00000000: 00 1f 20 21 7e 7f 80 81 ff 99                    .. !~.....");
+	ut_assert_nextline("%0*lx: 00 1f 20 21 7e 7f 80 81 ff 99                    .. !~.....", IS_ENABLED(CONFIG_PHYS_64BIT) ? 16 : 8, 0x0UL);
 	ut_assert_console_end();
 	unmap_sysmem(buf);
 
-- 
2.40.1

