Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB52EEA7951
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 01:42:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E56838FA;
	Thu,  5 Feb 2026 02:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="XSV5v70n";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uxAjXFJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA00683AAD; Thu,  5 Feb 2026 02:42:10 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77A648341A
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 02:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f60MN1R3gz9tqJ;
 Thu,  5 Feb 2026 02:42:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770255728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpIbVq6GMzv5CurTvERYyDUzP2Tzm2rMAbvnMLpOKvo=;
 b=XSV5v70nMVypfg2BQG8yUyKje8B3AV+PTiB3l2M3+zh33aOkrJq6+A+xvuDadiTmPWTUSS
 zPfTATy6x13la0LWtC3SxnyeE3Hnsqu0JPHnJRerGo8AUbzQQfWwYxMMP3V3GZhVTH8MlJ
 5QmzEU3KlF72ICB0Q3IWTNTecPyCGGfMXmj2HISAyPn+sR3WA2jufWpzgKqE6b0zGrmQFF
 27lq41cusVL7Dh2r8L2oIkoQQzymqnXqZBUGafIvctp9T+RaB2+6pBe71w2u7LQJvaxOhx
 O0BurtQeyimcYuGSyJekdTZUsAAjIh0Do6nyWUhfB1bs/qgdZfbaF8/SulrWEQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770255726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rpIbVq6GMzv5CurTvERYyDUzP2Tzm2rMAbvnMLpOKvo=;
 b=uxAjXFJYhJGlqgNnLpXMuLos532GjtIlpd2HMcxxC54JMH57cRwhNJktizo8Jbm5CUq7Bw
 JZW5zstzof//0+vxpFAE7TRcOjhyKa9Vmef6P9T+QZAP1sUQfgkzC7dZQkauzjLLkGBOgO
 4Nmr9tkituSyP0RA5z1R7ZLAcuYL1nmqLTIRuFyNmiefGhqDG/y86JgIGu4XIY6YlVqQhq
 Q48A4tjan+D1ZeqNd1o/qKrRoeMMYdxpVaMYGvAPBamtVxJz2cO4O8JAO8eg/2nLwlH/Pq
 ZmKQeV/L0ITS/2zGhzmhhGUeFlaaFFVMg9lUWUE4/9TCLXgInGFcUQYy4UqPXA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Alexander Graf <agraf@csgraf.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH v3 2/2] test: cmd: Add test for zip/unzip/gzwrite commands
Date: Thu,  5 Feb 2026 02:40:45 +0100
Message-ID: <20260205014153.218621-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260205014153.218621-1-marek.vasut+renesas@mailbox.org>
References: <20260205014153.218621-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 7d4efe6417fac744e6d
X-MBO-RS-META: h4tyzt8yg56pz95sz8jeqekq7eekhxat
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
Tested-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
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
V3: - Add RB/TB from Mattijs
    - Call getrandom() directly instead of CMD_RANDOM random command
    - Use ut_asserteq_mem() instead of cmp.b
    - Use run_commandf() instead of setting env vars
    - Move blk_get_device_by_str() into gzwrite test branch
---
 arch/sandbox/dts/test.dts |   7 +++
 common/Kconfig            |   2 +-
 test/cmd/Makefile         |   3 +
 test/cmd/unzip.c          | 124 ++++++++++++++++++++++++++++++++++++++
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
index 2476068aee6..8c9f112782d 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -45,3 +45,6 @@ endif
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
 endif
 obj-$(CONFIG_CMD_SPAWN) += spawn.o
+ifdef CONFIG_CMD_ZIP
+obj-$(CONFIG_CMD_UNZIP) += unzip.o
+endif
diff --git a/test/cmd/unzip.c b/test/cmd/unzip.c
new file mode 100644
index 00000000000..b67c5ba1956
--- /dev/null
+++ b/test/cmd/unzip.c
@@ -0,0 +1,124 @@
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
+/* sys/random.h is not accessible */
+extern ssize_t getrandom(void *buf, size_t size, unsigned int flags);
+
+static const ssize_t sizes[] = { 32, SZ_1K, SZ_4K, SZ_1M, SZ_16M, SZ_1M - 1, SZ_1M + 1, 6758401 };
+
+static int do_test_cmd_zip_unzip(struct unit_test_state *uts, ssize_t size,
+				 const bool gzwrite)
+{
+	unsigned long loadaddr = env_get_ulong("loadaddr", 16, 0);
+	unsigned long encaddr = loadaddr + size + 0x10000;
+	unsigned long decaddr = encaddr + size + 0x10000;
+	unsigned char *loadmap = map_sysmem(loadaddr, size);
+	unsigned char *decmap = map_sysmem(decaddr, size);
+	unsigned char *encmap = map_sysmem(encaddr, size);
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
+
+	ut_assert(getrandom(loadmap, size, 0) == size);
+	ut_assert(getrandom(decmap, size, 0) == size);
+	ut_assert(getrandom(encmap, size, 0) == size);
+
+	/* Compress data in $loadaddr into $encaddr */
+	ut_assertok(run_commandf("zip $loadaddr %zx %zx", size, encaddr));
+	console_record_readline(uts->actual_str, sizeof(uts->actual_str));
+	ut_assert(strstr(uts->actual_str, "Compressed size: "));
+
+	if (gzwrite) {
+		unsigned int sectsize = DIV_ROUND_UP(size, 512);
+		u32 crc = crc32(0, loadmap, size);
+		struct blk_desc *mmc_dev_desc;
+
+		ut_assertok(run_commandf("gzwrite mmc 9 %zx $filesize", encaddr));
+		ut_assert_skip_to_line("\t%zu bytes, crc 0x%08x", size, crc);
+
+		ut_asserteq(9, blk_get_device_by_str("mmc", "9", &mmc_dev_desc));
+		ut_assertok(run_commandf("mmc dev 9"));
+		ut_assert_nextline("switch to partitions #0, OK");
+		ut_assert_nextline("mmc9 is current device");
+
+		ut_assertok(run_commandf("mmc read %zx 0 %x", decaddr, sectsize));
+		ut_assert_nextline("MMC read: dev # 9, block # 0, count %u ... %u blocks read: OK",
+				   sectsize, sectsize);
+	} else {
+		/* Decompress data in $encaddr into $decaddr */
+		ut_assertok(run_commandf("unzip %zx %zx $filesize", encaddr, decaddr));
+		ut_assert_nextline("Uncompressed size: %zu = 0x%zX", size, size);
+	}
+
+	/* Input data and compressed-decompressed data */
+	ut_asserteq_mem(loadmap, decmap, size);
+
+	ut_assert_console_end();
+
+	unmap_sysmem(loadmap);
+	unmap_sysmem(decmap);
+	unmap_sysmem(encmap);
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

