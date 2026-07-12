Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B26CC43458
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 18:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC28F8490A;
	Sun, 12 Jul 2026 20:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="Q1VXcjfR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15CEC84A4A; Sun, 12 Jul 2026 20:29:07 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8D6384852
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 20:29:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 4E50FB0053E;
 Sun, 12 Jul 2026 20:28:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783880944;
 bh=PJqXfAYDj0Yq1RT4IyKOTMi8ruD96s8v7ub5QIqaR/o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q1VXcjfR5UxtlaJuZlKHP/rKR3jChpgLrdTRVVDPxh0uaPqKHmlHRYwaZBeNzqn5q
 VSN7k4Wk+iPNJKahgR/I+HQtCHHqrnT2BvIbwhcyyjr6QNXoQ2qzSW0pZpQjAoG5pN
 RjZUjMs8GLqX000A0GnEseNeceI9Dm7AfCDIFbiXuQaV/k7dbKoauOypX/sBTOnwAF
 hA7eOnk719rmDgsvAco5CvTT1ZdKrfrRanAmcvJ0LQvQycDun47OUQ0pap8WzL+SpF
 /6wsRfnXro2vtvXGUoGXfgATIbo3vvhQmXoPWiquylwiJfmQuAPxreAGy/KSaVfmWO
 D7j4Co+yeFOVA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v5 7/7] test: dm: pmbus: test pmbus command and framework
Date: Sun, 12 Jul 2026 20:20:49 +0200
Message-ID: <20260712182054.2914942-8-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260712182054.2914942-1-vjardin@free.fr>
References: <20260712182054.2914942-1-vjardin@free.fr>
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

Add dm unit tests that drive every pmbus subcommand handler against
the sandbox PMBus chip emulator:
  dev (select by bus:addr and by regulator-name), list, info,
  telemetry, status, dump, read, write, clear, vout, scan and help.

Tested using:

  ./u-boot -T -c "ut dm pmbus*"

Signed-off-by: Vincent Jardin <vjardin@free.fr>

Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v4)

Changes in v4:
- drop console_record_reset() (Simon Glass)
- drop "0x" prefixes from hex command arguments. It
  parses addr/reg/val as hex based on i2c convention (Simon Glass)

 MAINTAINERS      |   1 +
 test/dm/Makefile |   1 +
 test/dm/pmbus.c  | 242 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 244 insertions(+)
 create mode 100644 test/dm/pmbus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index edfa23b7bf9..410fef2bb1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1593,6 +1593,7 @@ F:	drivers/power/regulator/sandbox_pmbus.c
 F:	drivers/thermal/pmbus_thermal.c
 F:	include/pmbus.h
 F:	lib/pmbus.c
+F:	test/dm/pmbus.c
 
 POWER
 M:	Jaehoon Chung <jh80.chung@samsung.com>
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 0e3c63568dd..76aa1fff9ba 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_PINCONF) += pinmux.o
 endif
 obj-$(CONFIG_POWER_DOMAIN) += power-domain.o
 obj-$(CONFIG_ACPI_PMC) += pmc.o
+obj-$(CONFIG_CMD_PMBUS) += pmbus.o
 obj-$(CONFIG_DM_PMIC) += pmic.o
 obj-$(CONFIG_DM_PWM) += pwm.o
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += ffa.o
diff --git a/test/dm/pmbus.c b/test/dm/pmbus.c
new file mode 100644
index 00000000000..0184b201829
--- /dev/null
+++ b/test/dm/pmbus.c
@@ -0,0 +1,242 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Unit tests for the PMBus 1.x framework, the generic
+ * PMBus regulator and the pmbus CLI command.
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <pmbus.h>
+#include <dm/test.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* The line pmbus dev prints when a chip is selected */
+#define PMBUS_ACTIVE_LINE \
+	"pmbus: active i2c0:0x70  rail=\"sandbox-pmbus-vout\"  " \
+	"MFR_ID=\"SANDBOX\"  MODEL=\"PMBUS-EMUL\"  vendor=(generic)"
+
+/* The line pmbus list prints for the bound chip */
+#define PMBUS_LIST_LINE \
+	"  i2c0:0x70  rail=\"sandbox-pmbus-vout\"  node=pmbus@70  " \
+	"driver=pmbus_generic_regulator"
+
+/* Select the emulated chip and check the resulting banner line */
+static int pmbus_select(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("pmbus dev 0:70", 0));
+	ut_assert_nextline(PMBUS_ACTIVE_LINE);
+	return 0;
+}
+
+/* The chip is reachable via UCLASS_REGULATOR (compatible = "pmbus") */
+static int dm_test_pmbus_bind(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+
+	ut_assertok(uclass_get_device_by_name(UCLASS_REGULATOR, "pmbus@70",
+					      &dev));
+	ut_asserteq_str("pmbus_generic_regulator", dev->driver->name);
+	ut_asserteq(UCLASS_I2C, device_get_uclass_id(dev_get_parent(dev)));
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_bind, UTF_SCAN_FDT);
+
+/* pmbus dev by <bus>:<addr> and by regulator-name select the chip */
+static int dm_test_pmbus_dev(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("pmbus dev 0:70", 0));
+	ut_assert_nextline(PMBUS_ACTIVE_LINE);
+	ut_assert_console_end();
+
+	/* Selecting by DT regulator-name resolves to the same chip */
+	ut_assertok(run_command("pmbus dev sandbox-pmbus-vout", 0));
+	ut_assert_nextline(PMBUS_ACTIVE_LINE);
+	ut_assert_console_end();
+
+	/* pmbus dev with no argument reprints the active chip */
+	ut_assertok(run_command("pmbus dev", 0));
+	ut_assert_nextline(PMBUS_ACTIVE_LINE);
+	ut_assert_console_end();
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_dev, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* pmbus list enumerates the bound chip among the UCLASS_REGULATOR devices */
+static int dm_test_pmbus_list(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("pmbus list", 0));
+	ut_assert_skip_to_line(PMBUS_LIST_LINE);
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_list, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* pmbus info decodes identification + the detected driver_info */
+static int dm_test_pmbus_info(struct unit_test_state *uts)
+{
+	ut_assertok(pmbus_select(uts));
+
+	ut_assertok(run_command("pmbus info", 0));
+	ut_assert_nextline("pmbus device i2c0:0x70");
+	ut_assert_nextline("  regulator-name: \"sandbox-pmbus-vout\"");
+	ut_assert_nextline("  MFR_ID        : \"SANDBOX\"");
+	ut_assert_nextline("  MFR_MODEL     : \"PMBUS-EMUL\"");
+	ut_assert_nextline("  MFR_REVISION  : \"1.0\"  raw=0x312e30");
+	ut_assert_nextline("  PMBUS_REVISION: 0x33 (PMBus 1.3)");
+	ut_assert_nextline("  vendor        : (none)");
+	ut_assert_nextline("  driver_info   : pages=1");
+	ut_assert_nextline("    [VOLTAGE_IN  ] format=LINEAR");
+	ut_assert_nextline("    [VOLTAGE_OUT ] format=LINEAR");
+	ut_assert_nextline("    [CURRENT_IN  ] format=LINEAR");
+	ut_assert_nextline("    [CURRENT_OUT ] format=LINEAR");
+	ut_assert_nextline("    [POWER       ] format=LINEAR");
+	ut_assert_nextline("    [TEMPERATURE ] format=LINEAR");
+	ut_assert_console_end();
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_info, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/*
+ * pmbus telemetry decodes the implemented sensors and prints
+ * "(not supported)" for the commands the emulator NAKs (READ_IIN,
+ * READ_POUT). LINEAR11 is used for VIN/IOUT/TEMP, LINEAR16 (with the
+ * VOUT_MODE 2^-8 exponent) for VOUT.
+ */
+static int dm_test_pmbus_telemetry(struct unit_test_state *uts)
+{
+	ut_assertok(pmbus_select(uts));
+
+	ut_assertok(run_command("pmbus telemetry", 0));
+	ut_assert_nextline("pmbus telemetry @ i2c0:0x70");
+	ut_assert_nextline("  VIN  : raw=0x0abc  1400.000V");
+	ut_assert_nextline("  VOUT : raw=0x0200  2.000V");
+	ut_assert_nextline("  IIN  : (not supported)");
+	ut_assert_nextline("  IOUT : raw=0x0123  291.000A");
+	ut_assert_nextline("  POUT : (not supported)");
+	ut_assert_nextline("  TEMP : raw=0x0019  25.000C");
+	ut_assert_console_end();
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_telemetry, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* pmbus status decodes every STATUS_* register; the emulator is clean */
+static int dm_test_pmbus_status(struct unit_test_state *uts)
+{
+	ut_assertok(pmbus_select(uts));
+
+	ut_assertok(run_command("pmbus status", 0));
+	ut_assert_nextline("pmbus status @ i2c0:0x70");
+	ut_assert_nextline("  STATUS_WORD    (79h) = 0x0000  [clean]");
+	ut_assert_nextline("  STATUS_VOUT    (7Ah) = 0x00  [clean]");
+	ut_assert_nextline("  STATUS_IOUT    (7Bh) = 0x00  [clean]");
+	ut_assert_nextline("  STATUS_INPUT   (7Ch) = 0x00  [clean]");
+	ut_assert_nextline("  STATUS_TEMP    (7Dh) = 0x00  [clean]");
+	ut_assert_nextline("  STATUS_CML     (7Eh) = 0x00  [clean]");
+	ut_assert_console_end();
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_status, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* pmbus read/pmbus write raw register access (byte, word, string) */
+static int dm_test_pmbus_read_write(struct unit_test_state *uts)
+{
+	ut_assertok(pmbus_select(uts));
+
+	/* Symbolic and numeric register names both resolve */
+	ut_assertok(run_command("pmbus read VOUT_MODE", 0));
+	ut_assert_nextline("  20h  VOUT_MODE       b=0x18");
+	ut_assertok(run_command("pmbus read 8b w", 0));
+	ut_assert_nextline("  8bh  READ_VOUT       w=0x0200");
+	ut_assertok(run_command("pmbus read MFR_ID s", 0));
+	ut_assert_nextline("  99h  MFR_ID          s=\"SANDBOX\"");
+
+	/* A word write is observable on the next read-back */
+	ut_assertok(run_command("pmbus write VOUT_COMMAND 123 w", 0));
+	ut_assert_nextline("pmbus: wrote 0x123 to 21h (VOUT_COMMAND)");
+	ut_assertok(run_command("pmbus read VOUT_COMMAND w", 0));
+	ut_assert_nextline("  21h  VOUT_COMMAND    w=0x0123");
+	ut_assert_console_end();
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_read_write, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* pmbus vout reads back VOUT via the active driver_info decoder */
+static int dm_test_pmbus_vout(struct unit_test_state *uts)
+{
+	ut_assertok(pmbus_select(uts));
+
+	ut_assertok(run_command("pmbus vout", 0));
+	ut_assert_nextline("pmbus VOUT @ i2c0:0x70  raw=0x0200  2.000V");
+	ut_assert_console_end();
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_vout, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* pmbus dump walks every standard register; spot-check one line */
+static int dm_test_pmbus_dump(struct unit_test_state *uts)
+{
+	ut_assertok(pmbus_select(uts));
+
+	ut_assertok(run_command("pmbus dump", 0));
+	ut_assert_nextline("pmbus dump @ i2c0:0x70 (registers known to <pmbus.h>)");
+	ut_assert_skip_to_line("  20h  VOUT_MODE       b=0x18");
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_dump, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* pmbus clear [faults] issues CLEAR_FAULTS (03h) */
+static int dm_test_pmbus_clear(struct unit_test_state *uts)
+{
+	ut_assertok(pmbus_select(uts));
+
+	ut_assertok(run_command("pmbus clear faults", 0));
+	ut_assert_nextline("pmbus: CLEAR_FAULTS (03h) issued (RAM sticky STATUS_* cleared)");
+	ut_assert_console_end();
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_clear, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* pmbus scan finds the emulated chip by its MFR_ID block read */
+static int dm_test_pmbus_scan(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("pmbus scan 0", 0));
+	ut_assert_skip_to_line("  i2c0:0x70  MFR_ID=\"SANDBOX\"");
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_scan, UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* pmbus help lists vendor extensions; none are registered here */
+static int dm_test_pmbus_help(struct unit_test_state *uts)
+{
+	ut_assertok(run_command("pmbus help", 0));
+	ut_assert_nextline("pmbus: no vendor extensions registered.");
+	ut_assert_skip_to_line("       board hook (boot snapshot) and re run 'pmbus help'.");
+
+	return 0;
+}
+
+DM_TEST(dm_test_pmbus_help, UTF_SCAN_FDT | UTF_CONSOLE);
-- 
2.43.0

