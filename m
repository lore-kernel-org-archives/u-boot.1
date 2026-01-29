Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B51BD73EA9
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 23:57:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 313C184166;
	Fri, 30 Jan 2026 00:57:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="U0q0emhR";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dK1Ow28F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CC4884144; Fri, 30 Jan 2026 00:57:06 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 986C984158
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 00:57:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f2GJv2Kbcz9tgv;
 Fri, 30 Jan 2026 00:57:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769731023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=De/SiMJl1Bi2IlZziBiEaUfsmjLkP2LmAaBmyrsC/5Y=;
 b=U0q0emhR2pLCF4bF/seiNV3o4Hgfi2BUocUXGtDt3Zbs1YztEVLVHoRpI/euplaV7TDod4
 dkAM9qMinUIUbqx0VHZtklKwMEUMGL8UCYiuegCEhwTacsdgkFmREF/CFy3noIADw4k95F
 nf2pcAxh6f37gT/VlimBlhn5fZGn07NfxNFV53oS1Gw9wIRfGXky5HitNQFEa7WI49Q1Ng
 aEU9ySOByw5zHf+yRo3zxVzN0TfSeCcbApt+Kb40qb0hIYNhBafNoahJ3diwSZahUdRsUt
 xS2lVmxz7UfLCp1Wy70sS3bfIz/HCBqf7Bl1mFqGFeEgcmZOfYkPJKPZlS9Eyw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769731021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=De/SiMJl1Bi2IlZziBiEaUfsmjLkP2LmAaBmyrsC/5Y=;
 b=dK1Ow28FAkMOpUQiX3FefX387UYm0doCqG8esjUL52U8CV7wGwdg6ymSdwdcuNGU7YCQQ+
 EdMml1raKBLW/yX9zTysDbHO9ETyoQX93DcLjJUv7OB9tH9ke/ijVfNWJC5K2hIpYgoMXQ
 BXTVDAcdsa60yrr1Yu4JXNax4BauoovZXmLFJDF6pcNP3tA9F3dH43dl97qrtHn7q1lAdP
 qYXR4sIgUyyhCTRBFmJec2SgZInf8jaE27zg7OQmI3UI567DPVLqhxKbau15z/JplhB4kK
 zyIb40eobQlNA29MyqB6Q/RFGFyn6dGp312Ui98VHR5IhcuuZPp79aGB7uELkw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH v2 2/2] test: cmd: Add test for zip/unzip/gzwrite commands
Date: Fri, 30 Jan 2026 00:55:53 +0100
Message-ID: <20260129235647.660906-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260129235647.660906-1-marek.vasut+renesas@mailbox.org>
References: <20260129235647.660906-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1bdc42daa1000ed286a
X-MBO-RS-META: dysgo36fdsjq4wpx113xcfwp1nq8mj16
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

Add simple test for zip/unzip/gzwrite commands. The test works as
follows. First, create three buffers with a bit of space between
each of them, fill them with random data, then compress data in
buffer 1 into buffer 2, decompress data in buffer 2 either directly
into buffer 3 or into MMC 1 and then read them back into buffer 3,
and finally compare buffer 1 and buffer 3, they have to be identical.

The buffers are filled with random data to detect out of bounds writes.
Test for various sizes, both small and large and unaligned.

The test uses ut_assert_skip_to_line() to skip over gzwrite progress
bar. Since the progress bar updates fill up the console record buffer,
increase the size of it to compensate.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexander Graf <agraf@csgraf.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jerome Forissier <jerome@forissier.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Cc: u-boot@lists.denx.de
---
V2: Use ut_assert_skip_to_line() to skip over the progress bar.
    Since that fills up the console record buffer, increase the
    size of it to compensate.
---
 arch/sandbox/dts/test.dts |   7 +++
 common/Kconfig            |   2 +-
 test/cmd/Makefile         |   4 ++
 test/cmd/unzip.c          | 123 ++++++++++++++++++++++++++++++++++++++
 test/py/tests/test_ut.py  |   6 ++
 5 files changed, 141 insertions(+), 1 deletion(-)
 create mode 100644 test/cmd/unzip.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index b7402d7042a..762c1d9bbe2 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1272,6 +1272,13 @@
 		filename = "mmc8.img";
 	};
 
+	/* This is used for zip/unzip/gzwrite tests. */
+	mmc9 {
+		status = "disabled";
+		compatible = "sandbox,mmc";
+		filename = "mmc9.img";
+	};
+
 	pch {
 		compatible = "sandbox,pch";
 	};
diff --git a/common/Kconfig b/common/Kconfig
index 47d17f4e7c6..63448bdc13b 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -26,7 +26,7 @@ config CONSOLE_RECORD_INIT_F
 config CONSOLE_RECORD_OUT_SIZE
 	hex "Output buffer size"
 	depends on CONSOLE_RECORD
-	default 0x6000
+	default 0x20000
 	help
 	  Set the size of the console recording output buffer. When this fills
 	  up, no more data will be recorded until some is removed. The buffer
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 2476068aee6..273009a034f 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -45,3 +45,7 @@ endif
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
 endif
 obj-$(CONFIG_CMD_SPAWN) += spawn.o
+
+ifdef CONFIG_CMD_ZIP
+obj-$(CONFIG_CMD_UNZIP) += unzip.o
+endif
diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
new file mode 100644
index 00000000000..dc4a9c93745
--- /dev/null
+++ b/test/cmd/unzip.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Tests for zip/unzip/gzwrite commands
+ *
+ * Copyright 2026, Marek Vasut <marek.vasut+renesas@mailbox.org>
+ */
+
+#include <command.h>
+#include <env.h>
+#include <dm.h>
+#include <dm/lists.h>
+#include <dm/test.h>
+#include <linux/sizes.h>
+#include <mapmem.h>
+#include <part.h>
+#include <test/cmd.h>
+#include <test/test.h>
+#include <test/ut.h>
+#include <u-boot/crc.h>
+
+static const int sizes[] = { 32, SZ_1K, SZ_4K, SZ_1M, SZ_16M, SZ_1M - 1, SZ_1M + 1, 6758401 };
+
+static int do_test_cmd_zip_unzip(struct unit_test_state *uts, const int size,
+				 const bool gzwrite)
+{
+	env_set_hex("size", size);
+
+	/*
+	 * Prepare three buffers, $loadadd, $encaddr, $decaddr, and
+	 * fill them all with random data. Add slight space between
+	 * the compressed buffer 'encaddr' and uncompressed buffer
+	 * 'decaddr', because the compressed data with gzip header
+	 * might be longer than uncompressed source data 'loadaddr',
+	 * and if the uncompressed data buffer 'decaddr' followed
+	 * 'encaddr', the decompression could corrupt end of 'encaddr'
+	 * buffer.
+	 */
+	ut_assertok(run_command("setexpr encaddr $loadaddr + $size", 0));
+	ut_assertok(run_command("setexpr encaddr $encaddr + 0x10000", 0));
+
+	ut_assertok(run_command("setexpr decaddr $encaddr + $size", 0));
+	ut_assertok(run_command("setexpr decaddr $decaddr + 0x10000", 0));
+
+	ut_assertok(run_command("random $loadaddr $size", 0));
+	ut_assert_nextline("%d bytes filled with random data", size);
+	ut_assertok(run_command("random $encaddr $size", 0));
+	ut_assert_nextline("%d bytes filled with random data", size);
+	ut_assertok(run_command("random $decaddr $size", 0));
+	ut_assert_nextline("%d bytes filled with random data", size);
+
+	/* Compress data in $loadaddr into $encaddr */
+	ut_assertok(run_command("zip $loadaddr $size $encaddr", 0));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_assert(strstr(uts->actual_str, "Compressed size: "));
+
+	if (gzwrite) {
+		unsigned int sectsize = DIV_ROUND_UP(size, 512);
+		unsigned char *db = map_sysmem(env_get_ulong("loadaddr", 16, 0), size);
+		u32 crc = crc32(0, db, size);
+
+		ut_assertok(run_command("gzwrite mmc 9 $encaddr $filesize", 0));
+		ut_assert_skip_to_line("\t%u bytes, crc 0x%08x", size, crc);
+
+		env_set_hex("sectsize", sectsize);
+		ut_assertok(run_command("mmc read $decaddr 0 $sectsize", 0));
+		ut_assert_nextline("MMC read: dev # 9, block # 0, count %u ... %u blocks read: OK",
+				   sectsize, sectsize);
+	} else {
+		/* Decompress data in $encaddr into $decaddr */
+		ut_assertok(run_command("unzip $encaddr $decaddr $filesize", 0));
+		ut_assert_nextline("Uncompressed size: %u = 0x%X", size, size);
+	}
+
+	/* Input data and compressed-decompressed data */
+	ut_assertok(run_command("cmp.b $loadaddr $decaddr $size", 0));
+	ut_assert_nextline("Total of %u byte(s) were the same", size);
+
+	ut_assert_console_end();
+
+	return 0;
+}
+
+static int dm_test_cmd_zip_unzip(struct unit_test_state *uts)
+{
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		ret = do_test_cmd_zip_unzip(uts, sizes[i], false);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+DM_TEST(dm_test_cmd_zip_unzip, UTF_CONSOLE);
+
+static int dm_test_cmd_zip_gzwrite(struct unit_test_state *uts)
+{
+	struct blk_desc *mmc_dev_desc;
+	struct udevice *dev;
+	ofnode root, node;
+	int i, ret;
+
+	/* Enable the mmc9 node for this test */
+	root = oftree_root(oftree_default());
+	node = ofnode_find_subnode(root, "mmc9");
+	ut_assert(ofnode_valid(node));
+	ut_assertok(lists_bind_fdt(gd->dm_root, node, &dev, NULL, false));
+
+	ut_asserteq(9, blk_get_device_by_str("mmc", "9", &mmc_dev_desc));
+	ut_assertok(run_commandf("mmc dev 9"));
+	ut_assert_nextline("switch to partitions #0, OK");
+	ut_assert_nextline("mmc9 is current device");
+
+	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
+		ret = do_test_cmd_zip_unzip(uts, sizes[i], true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+DM_TEST(dm_test_cmd_zip_gzwrite, UTF_CONSOLE);
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 6d535b5206d..b7166d59943 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -522,6 +522,12 @@ def test_ut_dm_init(ubman):
     with open(fn, 'wb') as fh:
         fh.write(data)
 
+    mmc_dev = 9
+    fn = os.path.join(ubman.config.source_dir, f'mmc{mmc_dev}.img')
+    data = b'\x00' * (32 * 1024 * 1024)
+    with open(fn, 'wb') as fh:
+        fh.write(data)
+
 
 def setup_efi_image(ubman):
     """Create a 20MB disk image with an EFI app on it"""
-- 
2.51.0

