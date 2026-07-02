Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5ADC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:17:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A36784832;
	Thu,  2 Jul 2026 19:17:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="VPzoQHbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 000C6848BF; Thu,  2 Jul 2026 19:17:52 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8591584409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 19:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8808BB00565;
 Thu,  2 Jul 2026 19:17:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783012667;
 bh=nmkM5rZXGxdlvvGZlainGFEApADeTinVn9+blD6Dx3g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VPzoQHbxwTXfzeW1F4NiWQO3ThI2gQ0EernAs9Jx4+A2YcXBWxMEsT8tgxbaAobPk
 MwXfgZMt95lNmfdp7rFPaVwGo3swlQEHKmO98G2NUUhYidfVMuspvEwtucXQuq/nmy
 deVVhiEbPnQdom1AfrltU2NYBXCAv3DScHZeohxlb+hkf95Fxh/bDmOHySgR5IoNeF
 h28s1K7AXr9IJaHZ5twr4+juLr+rsXo5Zee1ii3+jXh+yhIaw7vAXj0ZQS0MpH07eD
 ReyNa69NKouJLXR/pFHHMcaL1Xb5wc+UFixyA3VvcFb/wRSEn1EO8gHEKqYlwW6GGo
 U4m4FMMft8hBA==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Alexey Charkov <alchark@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Brian Sune <briansune@gmail.com>, David Lechner <dlechner@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heiko Schocher <hs@nabladev.com>, Heiko Stuebner <heiko@sntech.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 1/7] pmbus: add PMBus 1.x framework, CLI, and binding
Date: Thu,  2 Jul 2026 19:15:45 +0200
Message-ID: <20260702171618.1773206-2-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702171618.1773206-1-vjardin@free.fr>
References: <20260702171618.1773206-1-vjardin@free.fr>
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

Add U-Boot's PMBus 1.x layer: the decoder/transport library, the
pmbus CLI command and a generic DT binding.

The subsequent commits provide the UCLASS_REGULATOR adapter and per-chip
drivers.

U-Boot's PMBus support is not a hwmon clone of Linux's
drivers/hwmon/pmbus/. Linux owns the runtime side (polling, sysfs,
alert IRQs, fan loops). U-Boot owns the boot-time side in order to,

 - identify the PMBus regulators a board carries: MFR_ID/
   MFR_MODEL/MFR_REVISION + sanity checks.
 - print telemetry (VIN/VOUT/IIN/IOUT/POUT/TEMP) so an
   operator can confirm rail voltages and faults before the kernel
 - decode any chip alerts (STATUS_VOUT/STATUS_IOUT/STATUS_INPUT/
   STATUS_TEMPERATURE/STATUS_CML) so a boot log shows why the
   previous boot failed or the board had been power cycled because
   of an outage (typically over temperature or under current).

Out of scope by design: no periodic polling, no sysfs, no fan-speed
control loop, no PMBUS_VIRT_* sensor virtualisation, no caching.
If a use case needs any of those, the answer should be "wait until
Linux comes up". It shall remain a thin layer.

The constants and structural shape (command codes, status bit names,
sensor-class enum, format enum, struct pmbus_driver_info) are
mirrored from Linux drivers/hwmon/pmbus/pmbus.h verbatim. The
decoders/encoders are reimplemented from the PMBus 1.3
specification because the surrounding hwmon context (struct
pmbus_data, sysfs caching, hwmon publication) does not apply.

The main benefits:

  - One framework + CLI for any board carrying PMBus regulators:
    no per-board PMBus implementation required anymore.
  - Boards call pmbus_print_telemetry() / pmbus_print_status_word()
    directly from boot init for a snapshot, sharing all decode +
    format-dispatch with the CLI.
  - Linux-compatible constants and DT binding so porting an existing
    drivers/hwmon/pmbus/ chip is mechanical.
  - Boot-time AVS/VID rail trim reuses the same decoders and
    encoders as the CLI and the regulator path: no duplicate math.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 MAINTAINERS                                   |   9 +
 cmd/Kconfig                                   |  14 +
 cmd/Makefile                                  |   1 +
 cmd/pmbus.c                                   | 816 +++++++++++++++++
 doc/develop/index.rst                         |   1 +
 doc/develop/pmbus.rst                         | 636 +++++++++++++
 doc/device-tree-bindings/regulator/pmbus.yaml |  65 ++
 include/pmbus.h                               | 629 +++++++++++++
 lib/Kconfig                                   |  16 +
 lib/Makefile                                  |   1 +
 lib/pmbus.c                                   | 859 ++++++++++++++++++
 11 files changed, 3047 insertions(+)
 create mode 100644 cmd/pmbus.c
 create mode 100644 doc/develop/pmbus.rst
 create mode 100644 doc/device-tree-bindings/regulator/pmbus.yaml
 create mode 100644 include/pmbus.h
 create mode 100644 lib/pmbus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 571af196465..01553aee45a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1580,6 +1580,15 @@ S:	Maintained
 F:	cmd/pci_mps.c
 F:	test/cmd/pci_mps.c
 
+PMBUS
+M:	Vincent Jardin <vjardin@free.fr>
+S:	Maintained
+F:	cmd/pmbus.c
+F:	doc/develop/pmbus.rst
+F:	doc/device-tree-bindings/regulator/pmbus.yaml
+F:	include/pmbus.h
+F:	lib/pmbus.c
+
 POWER
 M:	Jaehoon Chung <jh80.chung@samsung.com>
 M:	Peng Fan <peng.fan@nxp.com>
diff --git a/cmd/Kconfig b/cmd/Kconfig
index c71c6824a19..63f783ac0b9 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -2715,6 +2715,20 @@ config CMD_PMIC
 	  - pmic write address - write byte to register at address
 	  The only one change for this command is 'dev' subcommand.
 
+config CMD_PMBUS
+	bool "pmbus device interrogation and control command"
+	depends on PMBUS
+	help
+	  Enable the pmbus U-Boot CLI command. Provides identification,
+	  decoded telemetry, STATUS_* decoding, raw register read/write,
+	  CLEAR_FAULTS, and VOUT_COMMAND set/get against any PMBus 1.x
+	  compliant device selectable via 'pmbus dev <bus>:<addr>'.
+
+	  Per chip drivers and board files publish vendor extensions in
+	  the 'pmbus <vendor> ...' namespace.
+
+	  See doc/develop/pmbus.rst for the full usage reference.
+
 config CMD_REGULATOR
 	bool "Enable Driver Model REGULATOR command"
 	depends on DM_REGULATOR
diff --git a/cmd/Makefile b/cmd/Makefile
index bbbdfcc4ded..ce772e5555b 100644
--- a/cmd/Makefile
+++ b/cmd/Makefile
@@ -228,6 +228,7 @@ obj-$(CONFIG_CMD_AXI) += axi.o
 obj-$(CONFIG_CMD_PVBLOCK) += pvblock.o
 
 # Power
+obj-$(CONFIG_CMD_PMBUS) += pmbus.o
 obj-$(CONFIG_CMD_PMIC) += pmic.o
 obj-$(CONFIG_CMD_REGULATOR) += regulator.o
 
diff --git a/cmd/pmbus.c b/cmd/pmbus.c
new file mode 100644
index 00000000000..5ddaf3665fc
--- /dev/null
+++ b/cmd/pmbus.c
@@ -0,0 +1,816 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ *
+ * pmbus U-Boot CLI command.
+ *
+ * Generic command surface over the PMBus 1.x framework defined in
+ * <pmbus.h> + lib/pmbus.c.
+ *
+ * See doc/develop/pmbus.rst for the full usage reference.
+ */
+
+#include <command.h>
+#include <dm.h>
+#include <i2c.h>
+#include <log.h>
+#include <pmbus.h>
+#include <vsprintf.h>
+#include <linux/ctype.h>
+#include <power/regulator.h>
+
+static int parse_bus_addr(const char *s, int *bus_seq, u8 *addr)
+{
+	char busbuf[8];
+	const char *colon;
+	unsigned long b, a;
+	size_t buslen;
+
+	colon = strchr(s, ':');
+	if (!colon)
+		return -EINVAL;
+	buslen = colon - s;
+	if (buslen == 0 || buslen >= sizeof(busbuf))
+		return -EINVAL;
+	memcpy(busbuf, s, buslen);
+	busbuf[buslen] = '\0';
+	if (strict_strtoul(busbuf, 0, &b))
+		return -EINVAL;
+	if (strict_strtoul(colon + 1, 0, &a) || a > 0x7f)
+		return -EINVAL;
+	*bus_seq = (int)b;
+	*addr = (u8)a;
+	return 0;
+}
+
+static const struct {
+	const char *name;
+	u8 reg;
+} pmbus_reg_syms[] = {
+	{ "PAGE",            PMBUS_PAGE },
+	{ "OPERATION",       PMBUS_OPERATION },
+	{ "ON_OFF_CONFIG",   PMBUS_ON_OFF_CONFIG },
+	{ "CLEAR_FAULTS",    PMBUS_CLEAR_FAULTS },
+	{ "WRITE_PROTECT",   PMBUS_WRITE_PROTECT },
+	{ "CAPABILITY",      PMBUS_CAPABILITY },
+	{ "VOUT_MODE",       PMBUS_VOUT_MODE },
+	{ "VOUT_COMMAND",    PMBUS_VOUT_COMMAND },
+	{ "VOUT_TRIM",       PMBUS_VOUT_TRIM },
+	{ "VOUT_MAX",        PMBUS_VOUT_MAX },
+	{ "VOUT_SCALE_LOOP", PMBUS_VOUT_SCALE_LOOP },
+	{ "STATUS_BYTE",     PMBUS_STATUS_BYTE },
+	{ "STATUS_WORD",     PMBUS_STATUS_WORD },
+	{ "STATUS_VOUT",     PMBUS_STATUS_VOUT },
+	{ "STATUS_IOUT",     PMBUS_STATUS_IOUT },
+	{ "STATUS_INPUT",    PMBUS_STATUS_INPUT },
+	{ "STATUS_TEMP",     PMBUS_STATUS_TEMPERATURE },
+	{ "STATUS_CML",      PMBUS_STATUS_CML },
+	{ "READ_VIN",        PMBUS_READ_VIN },
+	{ "READ_IIN",        PMBUS_READ_IIN },
+	{ "READ_VOUT",       PMBUS_READ_VOUT },
+	{ "READ_IOUT",       PMBUS_READ_IOUT },
+	{ "READ_TEMP1",      PMBUS_READ_TEMPERATURE_1 },
+	{ "READ_TEMP2",      PMBUS_READ_TEMPERATURE_2 },
+	{ "READ_TEMP3",      PMBUS_READ_TEMPERATURE_3 },
+	{ "READ_DUTY",       PMBUS_READ_DUTY_CYCLE },
+	{ "READ_FREQ",       PMBUS_READ_FREQUENCY },
+	{ "READ_POUT",       PMBUS_READ_POUT },
+	{ "READ_PIN",        PMBUS_READ_PIN },
+	{ "REVISION",        PMBUS_REVISION },
+	{ "MFR_ID",          PMBUS_MFR_ID },
+	{ "MFR_MODEL",       PMBUS_MFR_MODEL },
+	{ "MFR_REVISION",    PMBUS_MFR_REVISION },
+};
+
+static int parse_reg(const char *s, u8 *reg)
+{
+	unsigned long v;
+	unsigned int i;
+
+	if (isdigit((unsigned char)s[0])) {
+		if (strict_strtoul(s, 0, &v) || v > 0xff)
+			return -EINVAL;
+		*reg = (u8)v;
+		return 0;
+	}
+	for (i = 0; i < ARRAY_SIZE(pmbus_reg_syms); i++) {
+		if (!strcasecmp(s, pmbus_reg_syms[i].name)) {
+			*reg = pmbus_reg_syms[i].reg;
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static const char *pmbus_reg_name(u8 reg)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(pmbus_reg_syms); i++)
+		if (pmbus_reg_syms[i].reg == reg)
+			return pmbus_reg_syms[i].name;
+	return "?";
+}
+
+static int require_active(struct udevice **chip,
+			  const struct pmbus_active_dev **act)
+{
+	*act = pmbus_active();
+	if (!*act) {
+		printf("pmbus: no active device. Use 'pmbus dev <bus>:<addr>' first.\n");
+		return CMD_RET_FAILURE;
+	}
+	if (pmbus_active_get_i2c(chip)) {
+		printf("pmbus: cannot reach i2c%d:0x%02x\n",
+		       (*act)->bus_seq, (*act)->addr);
+		return CMD_RET_FAILURE;
+	}
+	return CMD_RET_SUCCESS;
+}
+
+static void print_micro(s64 micro, const char *unit)
+{
+	s64 abs_milli;
+
+	abs_milli = (micro < 0 ? -micro : micro) / 1000LL;
+	printf("%lld.%03lld%s",
+	       (long long)(micro / 1000000LL),
+	       (long long)(abs_milli % 1000LL), unit);
+}
+
+static void print_active(const struct pmbus_active_dev *act)
+{
+	printf("pmbus: active i2c%d:0x%02x", act->bus_seq, act->addr);
+	if (act->name[0])
+		printf("  rail=\"%s\"", act->name);
+	printf("  MFR_ID=\"%s\"  MODEL=\"%s\"  vendor=%s%s\n",
+	       act->mfr_id[0] ? act->mfr_id : "?",
+	       act->mfr_model[0] ? act->mfr_model : "?",
+	       act->vendor[0] ? act->vendor : "(generic)",
+	       act->info ? "" : "  [no driver_info]");
+}
+
+static int do_dev(struct cmd_tbl *cmdtp, int flag, int argc,
+		  char *const argv[])
+{
+	const struct pmbus_active_dev *act;
+	int bus_seq, ret;
+	u8 addr;
+
+	if (argc < 2) {
+		act = pmbus_active();
+		if (!act) {
+			printf("pmbus: no active device\n");
+			return CMD_RET_SUCCESS;
+		}
+		print_active(act);
+		return CMD_RET_SUCCESS;
+	}
+
+	if (parse_bus_addr(argv[1], &bus_seq, &addr) < 0) {
+		ret = pmbus_resolve_by_name(argv[1], &bus_seq, &addr);
+		if (ret) {
+			printf("pmbus: '%s' is neither <bus>:<addr> nor a known regulator-name (%d)\n",
+			       argv[1], ret);
+			return CMD_RET_FAILURE;
+		}
+	}
+	ret = pmbus_set_active(bus_seq, addr);
+	if (ret) {
+		printf("pmbus: cannot select i2c%d:0x%02x (%d)\n",
+		       bus_seq, addr, ret);
+		return CMD_RET_FAILURE;
+	}
+	act = pmbus_active();
+	if (act)
+		print_active(act);
+	return CMD_RET_SUCCESS;
+}
+
+static int do_list(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	struct udevice *dev;
+	struct uclass *uc;
+	int ret, n = 0;
+
+	if (!IS_ENABLED(CONFIG_DM_REGULATOR)) {
+		printf("pmbus: CONFIG_DM_REGULATOR not enabled in this build. Use 'pmbus dev <bus>:<addr>'.\n");
+		return CMD_RET_SUCCESS;
+	}
+
+	ret = uclass_get(UCLASS_REGULATOR, &uc);
+	if (ret) {
+		printf("pmbus: UCLASS_REGULATOR not available\n");
+		return CMD_RET_SUCCESS;
+	}
+	uclass_foreach_dev(dev, uc) {
+		struct dm_regulator_uclass_plat *up = dev_get_uclass_plat(dev);
+		struct udevice *parent = dev_get_parent(dev);
+		const char *rname = (up && up->name) ? up->name : "";
+		const char *drv = (dev->driver && dev->driver->name)
+				   ? dev->driver->name : "?";
+		int bus_seq = -1;
+		int addr = -1;
+
+		if (parent && device_get_uclass_id(parent) == UCLASS_I2C) {
+			bus_seq = dev_seq(parent);
+			addr = dev_read_addr(dev);
+		}
+
+		if (n == 0)
+			printf("UCLASS_REGULATOR devices (no PMBus filter):\n");
+		if (bus_seq >= 0 && addr >= 0) {
+			printf("  i2c%d:0x%02x  rail=\"%s\"  node=%s  driver=%s\n",
+			       bus_seq, addr, rname, dev->name, drv);
+		} else {
+			printf("  (non-I2C)   rail=\"%s\"  node=%s  driver=%s\n",
+			       rname, dev->name, drv);
+		}
+		n++;
+	}
+	if (!n)
+		printf("pmbus: no UCLASS_REGULATOR devices bound. Use 'pmbus dev <bus>:<addr>' to select a chip directly.\n");
+	return CMD_RET_SUCCESS;
+}
+
+static int do_info(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	static const char * const cls_names[PSC_NUM_CLASSES] = {
+		"VOLTAGE_IN", "VOLTAGE_OUT", "CURRENT_IN", "CURRENT_OUT",
+		"POWER", "TEMPERATURE",
+	};
+	static const char * const fmt_names[] = {
+		"LINEAR", "IEEE754", "DIRECT", "VID",
+	};
+	const struct pmbus_active_dev *act;
+	struct udevice *chip;
+	int rc, c, rrev;
+	u8 rev = 0;
+
+	rc = require_active(&chip, &act);
+	if (rc)
+		return rc;
+
+	rrev = pmbus_read_byte(chip, PMBUS_REVISION, &rev);
+
+	printf("pmbus device i2c%d:0x%02x\n", act->bus_seq, act->addr);
+	if (act->name[0])
+		printf("  regulator-name: \"%s\"\n", act->name);
+	printf("  MFR_ID        : \"%s\"\n", act->mfr_id[0] ? act->mfr_id : "?");
+	printf("  MFR_MODEL     : \"%s\"\n", act->mfr_model[0] ? act->mfr_model : "?");
+
+	/*
+	 * MFR_REVISION may encodes the revision as a non printable byte
+	 * (BCD nibbles, packed major / minor, etc.). Show both the
+	 * printable form and the raw bytes the chip returned.
+	 */
+	{
+		u8 raw[PMBUS_MFR_STRING_MAX];
+		int len, i;
+
+		if (dm_i2c_read(chip, PMBUS_MFR_REVISION, raw, 1) ||
+		    raw[0] < 1 || raw[0] > sizeof(raw) - 1 ||
+		    dm_i2c_read(chip, PMBUS_MFR_REVISION, raw, raw[0] + 1)) {
+			printf("  MFR_REVISION  : \"%s\"\n",
+			       act->mfr_revision[0] ? act->mfr_revision : "?");
+		} else {
+			len = raw[0];
+			printf("  MFR_REVISION  : \"%s\"  raw=0x",
+			       act->mfr_revision[0] ? act->mfr_revision : "?");
+			for (i = 1; i <= len; i++)
+				printf("%02x", raw[i]);
+			printf("\n");
+		}
+	}
+
+	if (rrev)
+		printf("  PMBUS_REVISION: <read failed (%d)>\n", rrev);
+	else
+		printf("  PMBUS_REVISION: 0x%02x (%s)\n", rev,
+		       rev == PMBUS_REV_13 ? "PMBus 1.3" :
+		       rev == PMBUS_REV_12 ? "PMBus 1.2" :
+		       rev == PMBUS_REV_11 ? "PMBus 1.1" :
+		       rev == PMBUS_REV_10 ? "PMBus 1.0" : "unknown");
+	printf("  vendor        : %s\n", act->vendor[0] ? act->vendor : "(none)");
+
+	if (!act->info) {
+		printf("  driver_info   : not registered (decoders fall back to LINEAR16 / LINEAR11)\n");
+		return CMD_RET_SUCCESS;
+	}
+	printf("  driver_info   : pages=%d\n", act->info->pages);
+	for (c = 0; c < PSC_NUM_CLASSES; c++) {
+		printf("    [%-12s] format=%s",
+		       cls_names[c], fmt_names[act->info->format[c]]);
+		if (act->info->format[c] == pmbus_fmt_direct)
+			printf(", m=%d, b=%d, R=%d",
+			       act->info->m[c], act->info->b[c], act->info->R[c]);
+		printf("\n");
+	}
+	return CMD_RET_SUCCESS;
+}
+
+static int do_telemetry(struct cmd_tbl *cmdtp, int flag, int argc,
+			char *const argv[])
+{
+	const struct pmbus_active_dev *act;
+	struct udevice *chip;
+	int rc;
+
+	rc = require_active(&chip, &act);
+	if (rc)
+		return rc;
+
+	printf("pmbus telemetry @ i2c%d:0x%02x\n", act->bus_seq, act->addr);
+	pmbus_print_telemetry(chip);
+	return CMD_RET_SUCCESS;
+}
+
+static int do_status(struct cmd_tbl *cmdtp, int flag, int argc,
+		     char *const argv[])
+{
+	const struct pmbus_active_dev *act;
+	struct udevice *chip;
+	u16 word = 0;
+	u8 b;
+	int rc;
+
+	rc = require_active(&chip, &act);
+	if (rc)
+		return rc;
+
+	if (pmbus_read_word(chip, PMBUS_STATUS_WORD, &word)) {
+		printf("pmbus: STATUS_WORD read failed\n");
+		return CMD_RET_FAILURE;
+	}
+
+	const struct pmbus_status_override *ovr =
+		act->info ? act->info->status_overrides : NULL;
+
+	printf("pmbus status @ i2c%d:0x%02x\n", act->bus_seq, act->addr);
+	printf("  STATUS_WORD    (79h) = 0x%04x  [", word);
+	pmbus_print_status_bits(PMBUS_STATUS_WORD, word,
+				pmbus_status_word_bits, ovr);
+	printf("]\n");
+
+	if (pmbus_read_byte(chip, PMBUS_STATUS_VOUT, &b) == 0) {
+		printf("  STATUS_VOUT    (7Ah) = 0x%02x  [", b);
+		pmbus_print_status_bits(PMBUS_STATUS_VOUT, b,
+					pmbus_status_vout_bits, ovr);
+		printf("]\n");
+	}
+	if (pmbus_read_byte(chip, PMBUS_STATUS_IOUT, &b) == 0) {
+		printf("  STATUS_IOUT    (7Bh) = 0x%02x  [", b);
+		pmbus_print_status_bits(PMBUS_STATUS_IOUT, b,
+					pmbus_status_iout_bits, ovr);
+		printf("]\n");
+	}
+	if (pmbus_read_byte(chip, PMBUS_STATUS_INPUT, &b) == 0) {
+		printf("  STATUS_INPUT   (7Ch) = 0x%02x  [", b);
+		pmbus_print_status_bits(PMBUS_STATUS_INPUT, b,
+					pmbus_status_input_bits, ovr);
+		printf("]\n");
+	}
+	if (pmbus_read_byte(chip, PMBUS_STATUS_TEMPERATURE, &b) == 0) {
+		printf("  STATUS_TEMP    (7Dh) = 0x%02x  [", b);
+		pmbus_print_status_bits(PMBUS_STATUS_TEMPERATURE, b,
+					pmbus_status_temp_bits, ovr);
+		printf("]\n");
+	}
+	if (pmbus_read_byte(chip, PMBUS_STATUS_CML, &b) == 0) {
+		printf("  STATUS_CML     (7Eh) = 0x%02x  [", b);
+		pmbus_print_status_bits(PMBUS_STATUS_CML, b,
+					pmbus_status_cml_bits, ovr);
+		printf("]\n");
+	}
+
+	return CMD_RET_SUCCESS;
+}
+
+static int do_dump(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	const struct pmbus_active_dev *act;
+	struct udevice *chip;
+	unsigned int i;
+	int rc;
+
+	rc = require_active(&chip, &act);
+	if (rc)
+		return rc;
+
+	printf("pmbus dump @ i2c%d:0x%02x (registers known to <pmbus.h>)\n",
+	       act->bus_seq, act->addr);
+	for (i = 0; i < ARRAY_SIZE(pmbus_reg_syms); i++) {
+		u8 reg = pmbus_reg_syms[i].reg;
+		u8 b = 0;
+		u16 w = 0;
+
+		switch (reg) {
+		case PMBUS_PAGE:
+		case PMBUS_OPERATION:
+		case PMBUS_ON_OFF_CONFIG:
+		case PMBUS_WRITE_PROTECT:
+		case PMBUS_CAPABILITY:
+		case PMBUS_VOUT_MODE:
+		case PMBUS_STATUS_BYTE:
+		case PMBUS_STATUS_VOUT:
+		case PMBUS_STATUS_IOUT:
+		case PMBUS_STATUS_INPUT:
+		case PMBUS_STATUS_TEMPERATURE:
+		case PMBUS_STATUS_CML:
+		case PMBUS_REVISION:
+			if (pmbus_read_byte(chip, reg, &b) == 0)
+				printf("  %02xh  %-15s b=0x%02x\n",
+				       reg, pmbus_reg_syms[i].name, b);
+			break;
+		case PMBUS_MFR_ID:
+		case PMBUS_MFR_MODEL:
+		case PMBUS_MFR_REVISION: {
+			char s[PMBUS_MFR_STRING_MAX];
+
+			if (pmbus_read_string(chip, reg, s, sizeof(s),
+					      act->info ? false : false) >= 0)
+				printf("  %02xh  %-15s s=\"%s\"\n",
+				       reg, pmbus_reg_syms[i].name, s);
+			break;
+		}
+		default:
+			if (pmbus_read_word(chip, reg, &w) == 0)
+				printf("  %02xh  %-15s w=0x%04x\n",
+				       reg, pmbus_reg_syms[i].name, w);
+			break;
+		}
+	}
+	return CMD_RET_SUCCESS;
+}
+
+static int do_read(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	const struct pmbus_active_dev *act;
+	struct udevice *chip;
+	const char *fmt = "b";
+	u8 reg, b;
+	u16 w;
+	char s[PMBUS_MFR_STRING_MAX];
+	int rc, ret;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+	rc = require_active(&chip, &act);
+	if (rc)
+		return rc;
+	if (parse_reg(argv[1], &reg) < 0) {
+		printf("pmbus: invalid register '%s'\n", argv[1]);
+		return CMD_RET_USAGE;
+	}
+	if (argc >= 3)
+		fmt = argv[2];
+
+	if (!strcmp(fmt, "b")) {
+		ret = pmbus_read_byte(chip, reg, &b);
+		if (ret) {
+			printf("pmbus: read byte 0x%02x failed (%d)\n", reg, ret);
+			return CMD_RET_FAILURE;
+		}
+		printf("  %02xh  %-15s b=0x%02x\n", reg, pmbus_reg_name(reg), b);
+	} else if (!strcmp(fmt, "w")) {
+		ret = pmbus_read_word(chip, reg, &w);
+		if (ret) {
+			printf("pmbus: read word 0x%02x failed (%d)\n", reg, ret);
+			return CMD_RET_FAILURE;
+		}
+		printf("  %02xh  %-15s w=0x%04x\n", reg, pmbus_reg_name(reg), w);
+	} else if (!strcmp(fmt, "s")) {
+		ret = pmbus_read_string(chip, reg, s, sizeof(s), false);
+		if (ret < 0) {
+			printf("pmbus: read string 0x%02x failed (%d)\n", reg, ret);
+			return CMD_RET_FAILURE;
+		}
+		printf("  %02xh  %-15s s=\"%s\"\n", reg, pmbus_reg_name(reg), s);
+	} else {
+		printf("pmbus: unknown format '%s' (expected b, w, or s)\n", fmt);
+		return CMD_RET_USAGE;
+	}
+	return CMD_RET_SUCCESS;
+}
+
+static int do_write(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[])
+{
+	const struct pmbus_active_dev *act;
+	struct udevice *chip;
+	const char *fmt = "b";
+	unsigned long val;
+	u8 reg, b;
+	u8 buf[2];
+	int rc, ret;
+
+	if (argc < 3)
+		return CMD_RET_USAGE;
+	rc = require_active(&chip, &act);
+	if (rc)
+		return rc;
+	if (parse_reg(argv[1], &reg) < 0) {
+		printf("pmbus: invalid register '%s'\n", argv[1]);
+		return CMD_RET_USAGE;
+	}
+	if (strict_strtoul(argv[2], 0, &val)) {
+		printf("pmbus: invalid value '%s'\n", argv[2]);
+		return CMD_RET_USAGE;
+	}
+	if (argc >= 4)
+		fmt = argv[3];
+
+	if (!strcmp(fmt, "b")) {
+		if (val > 0xff) {
+			printf("pmbus: byte value out of range\n");
+			return CMD_RET_USAGE;
+		}
+		b = (u8)val;
+		ret = dm_i2c_write(chip, reg, &b, 1);
+	} else if (!strcmp(fmt, "w")) {
+		if (val > 0xffff) {
+			printf("pmbus: word value out of range\n");
+			return CMD_RET_USAGE;
+		}
+		buf[0] = (u8)(val & 0xff);
+		buf[1] = (u8)((val >> 8) & 0xff);
+		ret = dm_i2c_write(chip, reg, buf, 2);
+	} else {
+		printf("pmbus: unknown format '%s' (expected b or w)\n", fmt);
+		return CMD_RET_USAGE;
+	}
+	if (ret) {
+		printf("pmbus: write 0x%02x failed (%d)\n", reg, ret);
+		return CMD_RET_FAILURE;
+	}
+	printf("pmbus: wrote 0x%lx to %02xh (%s)\n", val, reg, pmbus_reg_name(reg));
+	return CMD_RET_SUCCESS;
+}
+
+static int do_clear(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[])
+{
+	const struct pmbus_active_dev *act;
+	struct udevice *chip;
+	int rc, ret;
+
+	if (argc >= 2 && strcmp(argv[1], "faults") != 0) {
+		printf("pmbus: unknown clear subcommand '%s' (expected 'faults')\n",
+		       argv[1]);
+		return CMD_RET_USAGE;
+	}
+	rc = require_active(&chip, &act);
+	if (rc)
+		return rc;
+	ret = pmbus_clear_faults(chip);
+	if (ret) {
+		printf("pmbus: CLEAR_FAULTS (03h) failed (%d)\n", ret);
+		return CMD_RET_FAILURE;
+	}
+	printf("pmbus: CLEAR_FAULTS (03h) issued (RAM sticky STATUS_* cleared)\n");
+	return CMD_RET_SUCCESS;
+}
+
+static int do_vout(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	const struct pmbus_active_dev *act;
+	struct udevice *chip;
+	u8 vout_mode = 0;
+	u16 raw;
+	s64 uv;
+	int rc, ret;
+
+	rc = require_active(&chip, &act);
+	if (rc)
+		return rc;
+
+	if (pmbus_read_byte(chip, PMBUS_VOUT_MODE, &vout_mode)) {
+		printf("pmbus: VOUT_MODE read failed\n");
+		return CMD_RET_FAILURE;
+	}
+
+	if (argc < 2) {
+		if (pmbus_read_word(chip, PMBUS_READ_VOUT, &raw)) {
+			printf("pmbus: READ_VOUT failed\n");
+			return CMD_RET_FAILURE;
+		}
+		if (act->info)
+			uv = pmbus_reg2data(act->info, PSC_VOLTAGE_OUT, raw, vout_mode);
+		else
+			uv = pmbus_reg2data_linear16(raw, vout_mode);
+		printf("pmbus VOUT @ i2c%d:0x%02x  raw=0x%04x  ",
+		       act->bus_seq, act->addr, raw);
+		print_micro(uv, "V");
+		printf("\n");
+		return CMD_RET_SUCCESS;
+	}
+
+	{
+		unsigned long target_uv;
+		const char *fmt_name;
+		u8 buf[2];
+
+		if (strict_strtoul(argv[1], 0, &target_uv)) {
+			printf("pmbus: invalid microvolt value '%s'\n", argv[1]);
+			return CMD_RET_USAGE;
+		}
+
+		switch (vout_mode & PB_VOUT_MODE_MODE_MASK) {
+		case PB_VOUT_MODE_LINEAR:
+			raw = pmbus_data2reg_linear16((s64)target_uv, vout_mode);
+			fmt_name = "LINEAR16";
+			break;
+		case PB_VOUT_MODE_DIRECT:
+			if (!act->info ||
+			    act->info->format[PSC_VOLTAGE_OUT] != pmbus_fmt_direct) {
+				printf("pmbus: VOUT_MODE selects DIRECT but the active driver_info has no DIRECT coefficients for VOLTAGE_OUT\n");
+				return CMD_RET_FAILURE;
+			}
+			raw = pmbus_data2reg_direct((s64)target_uv,
+						    act->info->m[PSC_VOLTAGE_OUT],
+						    act->info->b[PSC_VOLTAGE_OUT],
+						    act->info->R[PSC_VOLTAGE_OUT]);
+			fmt_name = "DIRECT";
+			break;
+		default:
+			printf("pmbus: VOUT_MODE 0x%02x selects an encoder not yet implemented (VID / IEEE754)\n",
+			       vout_mode);
+			return CMD_RET_FAILURE;
+		}
+
+		buf[0] = raw & 0xff;
+		buf[1] = (raw >> 8) & 0xff;
+		ret = dm_i2c_write(chip, PMBUS_VOUT_COMMAND, buf, 2);
+		if (ret) {
+			printf("pmbus: VOUT_COMMAND write failed (%d)\n", ret);
+			return CMD_RET_FAILURE;
+		}
+		printf("pmbus: VOUT_COMMAND <- 0x%04x (%s, target %lu uV)\n",
+		       raw, fmt_name, target_uv);
+	}
+	return CMD_RET_SUCCESS;
+}
+
+static int pmbus_scan_one_bus(struct udevice *bus, int bus_seq)
+{
+	int hits = 0;
+	int addr;
+
+	for (addr = 0x08; addr <= 0x77; addr++) {
+		struct udevice *chip;
+		u8 b;
+
+		if (i2c_get_chip(bus, addr, 1, &chip))
+			continue;
+		/* MFR_ID block read: 1st byte is the length of the string. */
+		if (dm_i2c_read(chip, PMBUS_MFR_ID, &b, 1))
+			continue;
+		if (b >= 1 && b <= PMBUS_MFR_STRING_MAX - 1) {
+			char s[PMBUS_MFR_STRING_MAX] = "";
+
+			pmbus_read_string(chip, PMBUS_MFR_ID, s, sizeof(s), false);
+			if (!s[0])
+				pmbus_read_string(chip, PMBUS_MFR_ID, s, sizeof(s), true);
+			printf("  i2c%d:0x%02x  MFR_ID=\"%s\"\n",
+			       bus_seq, addr, s[0] ? s : "(unprintable)");
+			hits++;
+		}
+	}
+	return hits;
+}
+
+static int do_scan(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	int total = 0;
+
+	if (argc >= 2) {
+		struct udevice *bus;
+		unsigned long val;
+		int bus_seq;
+
+		if (strict_strtoul(argv[1], 0, &val)) {
+			printf("pmbus: invalid bus seq '%s'\n", argv[1]);
+			return CMD_RET_USAGE;
+		}
+		bus_seq = (int)val;
+		if (uclass_get_device_by_seq(UCLASS_I2C, bus_seq, &bus)) {
+			printf("pmbus: i2c%d not available\n", bus_seq);
+			return CMD_RET_FAILURE;
+		}
+		printf("pmbus scan i2c%d:\n", bus_seq);
+		total = pmbus_scan_one_bus(bus, bus_seq);
+	} else {
+		struct uclass *uc;
+		struct udevice *bus;
+
+		if (uclass_get(UCLASS_I2C, &uc))
+			return CMD_RET_FAILURE;
+		uclass_foreach_dev(bus, uc) {
+			int seq = dev_seq(bus);
+
+			if (seq < 0)
+				continue;
+			printf("pmbus scan i2c%d:\n", seq);
+			total += pmbus_scan_one_bus(bus, seq);
+		}
+	}
+	if (!total)
+		printf("pmbus: no PMBus responders found\n");
+	return CMD_RET_SUCCESS;
+}
+
+static int do_help(struct cmd_tbl *cmdtp, int flag, int argc,
+		   char *const argv[])
+{
+	unsigned int i, n = pmbus_vendor_count();
+
+	if (n == 0) {
+		printf("pmbus: no vendor extensions registered.\n");
+		printf("       Vendor handlers are registered by per chip drivers at\n");
+		printf("       probe time; trigger a probe via 'pmbus dev <name>' or a\n");
+		printf("       board hook (boot snapshot) and re run 'pmbus help'.\n");
+		return CMD_RET_SUCCESS;
+	}
+
+	printf("Registered pmbus vendor extensions (%u):\n\n", n);
+	for (i = 0; i < n; i++) {
+		const struct pmbus_vendor_op *op = pmbus_vendor_at(i);
+
+		if (!op)
+			continue;
+		printf("[vendor: %s]\n", op->vendor);
+		if (op->help)
+			printf("%s", op->help);
+		printf("\n");
+	}
+	return CMD_RET_SUCCESS;
+}
+
+static struct cmd_tbl pmbus_subcmd[] = {
+	U_BOOT_CMD_MKENT(dev,       2, 1, do_dev,       "", ""),
+	U_BOOT_CMD_MKENT(list,      1, 1, do_list,      "", ""),
+	U_BOOT_CMD_MKENT(info,      1, 1, do_info,      "", ""),
+	U_BOOT_CMD_MKENT(telemetry, 1, 1, do_telemetry, "", ""),
+	U_BOOT_CMD_MKENT(status,    1, 1, do_status,    "", ""),
+	U_BOOT_CMD_MKENT(dump,      1, 1, do_dump,      "", ""),
+	U_BOOT_CMD_MKENT(read,      3, 1, do_read,      "", ""),
+	U_BOOT_CMD_MKENT(write,     4, 1, do_write,     "", ""),
+	U_BOOT_CMD_MKENT(clear,     2, 1, do_clear,     "", ""),
+	U_BOOT_CMD_MKENT(vout,      2, 1, do_vout,      "", ""),
+	U_BOOT_CMD_MKENT(scan,      2, 1, do_scan,      "", ""),
+	U_BOOT_CMD_MKENT(help,      1, 1, do_help,      "", ""),
+};
+
+static int do_pmbus(struct cmd_tbl *cmdtp, int flag, int argc,
+		    char *const argv[])
+{
+	const struct pmbus_vendor_op *vop;
+	struct cmd_tbl *cmd;
+
+	if (argc < 2)
+		return CMD_RET_USAGE;
+
+	argc--;
+	argv++;
+
+	cmd = find_cmd_tbl(argv[0], pmbus_subcmd, ARRAY_SIZE(pmbus_subcmd));
+	if (cmd) {
+		if (argc > cmd->maxargs)
+			return CMD_RET_USAGE;
+		return cmd->cmd(cmdtp, flag, argc, argv);
+	}
+
+	/* Vendor namespace dispatch */
+	vop = pmbus_lookup_vendor(argv[0]);
+	if (vop)
+		return vop->handler(cmdtp, flag, argc, argv);
+
+	printf("pmbus: unknown subcommand '%s'\n", argv[0]);
+	return CMD_RET_USAGE;
+}
+
+U_BOOT_CMD(pmbus, CONFIG_SYS_MAXARGS, 1, do_pmbus,
+	   "PMBus 1.x device interrogation and control",
+	   "list                     - list UCLASS_REGULATOR devices (DM bound)\n"
+	   "pmbus dev [<bus>:<addr>|<name>] - show / select active PMBus device\n"
+	   "pmbus info                     - identification banner + driver_info\n"
+	   "pmbus telemetry                - decoded VIN, VOUT, IIN, IOUT, TEMP\n"
+	   "pmbus status                   - decode every STATUS_* register\n"
+	   "pmbus dump                     - hex dump of every standard register\n"
+	   "pmbus read <reg> [b|w|s]       - raw read (b=byte, w=word, s=string)\n"
+	   "pmbus write <reg> <val> [b|w]  - raw write\n"
+	   "pmbus clear [faults]           - issue CLEAR_FAULTS (03h)\n"
+	   "pmbus vout [<uV>]              - read / set VOUT_COMMAND (microvolts)\n"
+	   "pmbus scan [<bus>]             - PMBus aware probe of one or all I2C buses\n"
+	   "pmbus help                     - list registered vendor extensions\n"
+	   "\n"
+	   "Vendor extensions (pmbus <vendor> ...) are registered by per chip\n"
+	   "drivers at probe time. Run 'pmbus help' after a chip is probed to\n"
+	   "see the available subcommands.\n"
+);
diff --git a/doc/develop/index.rst b/doc/develop/index.rst
index 3c044e67927..2ce67b7bfe2 100644
--- a/doc/develop/index.rst
+++ b/doc/develop/index.rst
@@ -50,6 +50,7 @@ Implementation
    logging
    makefiles
    menus
+   pmbus
    printf
    smbios
    spl
diff --git a/doc/develop/pmbus.rst b/doc/develop/pmbus.rst
new file mode 100644
index 00000000000..270c1118ce2
--- /dev/null
+++ b/doc/develop/pmbus.rst
@@ -0,0 +1,636 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+PMBus support in U-Boot
+=======================
+
+This document describes U-Boot's PMBus 1.x support: what it is for,
+how it is structured, and how to add support for a new PMBus chipn
+either from scratch from a chip datasheet or by porting an existing
+Linux ``drivers/hwmon/pmbus/`` driver.
+
+.. contents::
+   :local:
+   :depth: 2
+
+Intent and scope
+----------------
+
+U-Boot's PMBus layer is not a hardware monitoring (hwmon) clone of
+the Linux kernel's ``drivers/hwmon/pmbus/`` subsystem. Linux owns the
+runtime side: continuous polling, sysfs publication, alert IRQ
+handling, fan control loops. U-Boot owns the boot time side. Concretely
+the U-Boot PMBus support exists to:
+
+* Identify the PMBus regulator(s) a board carries at boot:
+  ``MFR_ID``, ``MFR_MODEL``, ``MFR_REVISION`` reads, plus a quick
+  ``STATUS_WORD`` sanity check.
+* Print telemetry so an operator can confirm rail voltages, input
+  current, and temperature before handing off to the kernel. One shot
+  reads, on demand, via the ``pmbus`` and ``regulator`` U-Boot
+  commands (``pmbus dev <name>; pmbus telemetry``,
+  ``regulator dev <name>; regulator value``).
+* Decode chip alerts when a rail trips an over/under voltage,
+  over current, or thermal threshold; so a boot log shows why the
+  previous boot failed, before the kernel even comes up.
+* Optionally trim a critical rail (typically the SoC core) before
+  the kernel takes over; "set the voltage prior to a kernel boot
+  to better protect the board". This is the existing
+  ``board/nxp/common/vid.c`` AVS path and any future per board
+  speed binning trim.
+
+Out of scope, by design:
+
+* No periodic polling. No worker thread. No background updates.
+* No sysfs / procfs / userspace surface. U-Boot has none.
+* No fan speed control loop. The kernel runs that.
+* No long tail of virtual sensor registers (``PMBUS_VIRT_*``).
+* No sensor caching / update timestamps.
+
+If you find yourself wanting any of those, the answer is "wait until
+Linux comes up". Keep U-Boot's PMBus surface minimal.
+
+Architecture overview
+---------------------
+
+The framework is split into four layers (layer 3 comes in two
+flavours, 3a and 3b),
+
+::
+
+    +----------------------------------------+
+    |     Layer 1: include/pmbus.h           |
+    |     Standard PMBus 1.x command codes,  |
+    |     numeric format enum, sensor class  |
+    |     enum, struct pmbus_driver_info,    |
+    |     decoder + transport prototypes,    |
+    |     STATUS_WORD bit names.             |
+    +----------------------------------------+
+    |     Layer 2: lib/pmbus.c               |
+    |     Format decoders (LINEAR11/LINEAR16/|
+    |     DIRECT) and encoder (LINEAR16),    |
+    |     two stage SMBus block read helper, |
+    |     STATUS_*-bit print tables, generic |
+    |     dispatcher pmbus_reg2data().       |
+    +----------------------------------------+
+    |     Layer 3a: drivers/power/regulator/ |
+    |               <chip>.c                 |
+    |     UCLASS_REGULATOR per chip drivers  |
+    |    ; one struct pmbus_driver_info    |
+    |     plus regulator set_value/get_value |
+    |     ops. Optional: per chip identify() |
+    |     hook to refine format from the     |
+    |     chip's own VOUT_MODE.              |
+    +----------------------------------------+
+    |     Layer 3b: drivers/power/regulator/ |
+    |               pmbus_generic.c          |
+    |     Catch all driver matching          |
+    |     compatible = "pmbus".              |
+    |     Auto detects format via VOUT_MODE  |
+    |     and PMBUS_QUERY where supported.   |
+    |     Use for compliant chips with no    |
+    |     per chip driver yet; ship        |
+    |     telemetry today, write a per chip  |
+    |     driver later only if quirks demand |
+    |     it.                                |
+    +----------------------------------------+
+    |     Layer 4: board/<vendor>/<board>/   |
+    |              <chip>_diag.c             |
+    |     Diagnostic commands only:          |
+    |       <chip>_info / <chip>_raw         |
+    |     Reads via regulator_get_value()    |
+    |     and lib/pmbus.c helpers. LINEAR /  |
+    |     DIRECT math NOT here.              |
+    +----------------------------------------+
+
+Generic vs. board specific separation rule. Layer 1, 2, and 3
+files are tree level and platform agnostic. Their comments may
+reference only:
+
+* the PMBus 1.x specification, and
+* chip manufacturer datasheets.
+
+Never a specific board, SoC, or product. Board-specific quirks
+(a particular bus number, a particular slave address, a particular
+PCB feedback divider, board local design notes) live exclusively in
+``board/<vendor>/<board>/`` files.
+
+CLI commands
+------------
+
+The framework publishes one top level command, ``pmbus``, plus a
+vendor namespace dispatcher so per chip code can register chip
+specific extensions without touching the framework.
+
+Active device model
+~~~~~~~~~~~~~~~~~~~
+
+``pmbus`` mirrors the ``regulator`` command: select an active device
+once, then operate on it across subcommands. The active device is
+selected by I2C bus and 7 bit address::
+
+    => pmbus dev 0:0x10
+    pmbus: active i2c0:0x10  MFR_ID="MPS"  MFR_MODEL="MPQ8785"  vendor=mps
+
+The framework probes ``MFR_ID`` (in both natural and reverse byte
+orders) at selection time, looks the result up in the chip match
+registry populated by per chip code via ``pmbus_register_chip()``,
+and caches the matched ``pmbus_driver_info``. All subsequent
+subcommands consume that cached metadata.
+
+Standard subcommands
+~~~~~~~~~~~~~~~~~~~~
+
+::
+
+    pmbus list                       list UCLASS_REGULATOR devices (DM bound)
+    pmbus dev [<bus>:<addr>]         show / select active PMBus device
+    pmbus info                       identification banner + driver_info
+    pmbus telemetry                  decoded VIN, VOUT, IIN, IOUT, TEMP
+    pmbus status                     decode every STATUS_* register
+    pmbus dump                       hex dump of every standard register
+    pmbus read <reg> [b|w|s]         raw read (b=byte, w=word, s=string)
+    pmbus write <reg> <val> [b|w]    raw write
+    pmbus clear [faults]             issue CLEAR_FAULTS (03h)
+    pmbus vout [<uV>]                read or set VOUT_COMMAND (microvolts)
+    pmbus scan [<bus>]               PMBus aware probe of one or all I2C buses
+
+The ``<reg>`` argument accepts either a hexadecimal address
+(``0x88``) or a symbolic name (``READ_VIN``, ``VOUT_MODE``,
+``MFR_ID``). Format selectors after the register select the SMBus
+transaction width: ``b`` for byte, ``w`` for 16 bit little endian
+word, ``s`` for the SMBus block read used by string registers.
+
+Decoded telemetry honours the active device's ``pmbus_driver_info``;
+when no chip match has been registered, VOUT falls back to LINEAR16
+driven by ``VOUT_MODE`` and the other sensors fall back to LINEAR11.
+
+Vendor namespace
+~~~~~~~~~~~~~~~~
+
+Per chip drivers and board files publish chip specific subcommands
+in the ``pmbus <vendor> ...`` namespace by calling
+``pmbus_register_vendor_handler()`` at init time. The framework
+dispatches ``pmbus mps last``, ``pmbus mps clear last``, and
+``pmbus mps clear force`` to the MPS handler when the active
+device matches the ``mps`` vendor. Additional vendor handlers for
+``lltc``, ``renesas``, etc. land alongside the per chip drivers
+that need them.
+
+Relationship to ``vdd_override`` / ``vdd_read``
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The NXP Layerscape ``vdd_override <mV>`` and ``vdd_read`` commands
+remain available in their original form for compatibility with
+existing AVS production scripts. The new ``pmbus vout`` and
+``pmbus vout <uV>`` subcommands cover the read and single shot
+write paths against the same chips, but do not implement
+``vdd_override``'s full sequence (board drop compensation, fuse
+target derivation, multi step convergence loop, atomic
+``PAGE_PLUS_WRITE`` block transaction, ``WRITE_PROTECT`` dance).
+For interactive bring up ``pmbus vout`` is sufficient; for
+production AVS, ``vdd_override`` stays canonical.
+
+Lifecycle: from board boot to Linux handoff
+-------------------------------------------
+
+The PMBus framework spans the entire U-Boot lifecycle. This section
+walks the boot timeline phase by phase, showing when each piece
+comes online and how the regulator uclass and the ``pmbus`` CLI
+converge on the same chip.
+
+Timeline overview
+~~~~~~~~~~~~~~~~~
+
+::
+
+    Phase 0  chip power on              chip ramps to NVM default VOUT
+    Phase 1  boot ROM / SPL / TF-A      PMBus typically untouched
+    Phase 2  U-Boot relocation, DM init regulators bound, not probed
+    Phase 3  first regulator probe      chip driver runs, framework lights up
+    Phase 4  board hooks / boot scripts snapshot, AVS trim, gating
+    Phase 5  Linux handoff              DT passed, chip state preserved
+    Phase 6  Linux runtime              kernel pmbus driver takes over
+
+Phase 0: chip power on
+~~~~~~~~~~~~~~~~~~~~~~
+
+When the regulator chip receives its input voltage, it ramps its
+output to the VOUT default programmed into its NVM at factory
+provisioning. PMBus is silent: no software runs anywhere on the
+SoC yet.
+
+Phase 1: pre U-Boot stages
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Boot ROMs, secondary boot loaders (SPL, ARM TF-A BL2 / BL31)
+typically do not touch PMBus. They focus on PLLs, DDR PHY init,
+and bringing up enough hardware to load the next stage. Some
+platforms have a pre U-Boot AVS path in board specific TF-A
+code that writes ``VOUT_COMMAND`` from a fuse derived target;
+that path is independent of the U-Boot framework described here.
+
+Phase 2: U-Boot relocation and DM init
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+After relocation, U-Boot binds device tree nodes to drivers but
+does not probe them. UCLASS_REGULATOR devices for PMBus chips
+are bound (driver and DT match resolved) but the ``.probe``
+callback has not run yet.
+
+Framework state at this point:
+
+* chip match registry: empty
+* vendor handler registry: empty
+* active device: none
+* regulator uclass: devices bound, none probed
+
+Phase 3: lazy regulator probe
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The first caller into the regulator uclass for a given chip
+triggers the chip driver's ``.probe``. Typical first callers:
+
+* a board ``EVENT_SPY`` at ``EVT_LAST_STAGE_INIT`` (boot snapshot)
+* a U-Boot script: ``regulator dev <name>; regulator value``
+* the ``pmbus dev <name>`` CLI command (resolves to the regulator)
+* another DT consumer with a ``regulator-supplies`` reference
+
+The probe chain looks like this::
+
+    <chip>_probe(dev)
+        pmbus_regulator_probe_common(dev, &<chip>_info, page)
+            dev_read_addr(dev)               -> reg = <addr>
+            i2c_get_chip(dev->parent, addr)  -> I2C chip handle
+            priv->i2c_dev = handle
+            priv->info    = &<chip>_info
+            priv->page    = page
+            (page > 0)  write PMBUS_PAGE
+        <chip>_identify_vout(priv->i2c_dev)        [optional]
+            read VOUT_MODE; refine info->format[PSC_VOLTAGE_OUT]
+        pmbus_regulator_apply_voltage_scale(dev, fb_div)  [optional]
+            write PMBUS_VOUT_SCALE_LOOP if DT property set
+        pmbus_register_chip(&<chip>_match)              [idempotent]
+        pmbus_register_vendor_handler(&<chip>_op)       [idempotent]
+
+Once probed, three independent surfaces are functional against
+the same chip:
+
+* the regulator uclass API (``regulator_get_value``,
+  ``regulator_set_value``, ``regulator_get_enable``,
+  ``regulator_set_enable``)
+* the ``pmbus`` CLI (chip is reachable by name through
+  ``pmbus_resolve_by_name()``, by raw ``<bus>:<addr>`` through
+  ``pmbus_set_active()``)
+* the chip's vendor extension subcommands (``pmbus <vendor> ...``)
+
+Phase 4: board hooks and boot scripts
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Boards hook the boot flow at well known points to drive board
+specific PMBus behaviour. The framework prescribes none of these;
+they are conventions:
+
+* boot time rail snapshot. An ``EVENT_SPY`` at
+  ``EVT_LAST_STAGE_INIT`` reads telemetry through the regulator
+  uclass and prints a one shot summary to the console. Useful
+  for operator visibility on serial during bring up.
+
+* pre kernel rail trim (AVS). A board hook in
+  ``board_late_init`` or a custom event spy reads a fuse derived
+  target voltage and calls ``regulator_set_value_force()`` to
+  trim the SoC core rail before kernel handoff.
+
+* Linux handoff gate. A bootcmd reads the rail voltage
+  through the regulator command and refuses to boot Linux if
+  the rail is outside the expected range.
+
+Phase 5: Linux handoff
+~~~~~~~~~~~~~~~~~~~~~~
+
+When U-Boot transfers control to Linux, it passes the device
+tree (potentially patched). The DT compatible strings for PMBus
+regulators must match those in the upstream kernel binding so
+the kernel's ``drivers/hwmon/pmbus/<chip>.c`` picks them up.
+Property names are shared with the kernel binding
+(``regulator-name``, ``regulator-min-microvolt``,
+``mps,vout-fb-divider-ratio-permille``, etc.); see "DT alignment
+with Linux" below.
+
+The chip itself is left in the state U-Boot wrote it to. If
+U-Boot trimmed VOUT, the chip stays at the trimmed voltage
+through handoff. ``CLEAR_FAULTS`` state is preserved unless an
+operator explicitly issued one.
+
+Phase 6: Linux runtime
+~~~~~~~~~~~~~~~~~~~~~~
+
+Linux's ``drivers/hwmon/pmbus/pmbus_core.c`` probes the chip,
+exposes telemetry under ``/sys/class/hwmon``, and takes over
+runtime voltage management through its regulator subsystem.
+The hwmon framework polls periodically; U-Boot does not.
+
+Operation paths through the regulator uclass
+--------------------------------------------
+
+After the first probe completes, calls into the regulator uclass
+for a PMBus chip flow through the shared helper.
+
+Read VOUT::
+
+    regulator_get_value(dev)
+       -> dm_regulator_ops->get_value
+       -> pmbus_regulator_get_value(dev)
+          pmbus_regulator_select_page(priv)
+          pmbus_read_byte(priv->i2c_dev, VOUT_MODE, &mode)
+          pmbus_read_word(priv->i2c_dev, READ_VOUT, &raw)
+          pmbus_reg2data(priv->info, PSC_VOLTAGE_OUT, raw, mode)
+              -> reg2data_linear16  (mode = 0)
+              -> reg2data_direct    (chip configured for DIRECT)
+          return engineering value (microvolts)
+
+Write VOUT::
+
+    regulator_set_value(dev, uV)
+       -> dm_regulator_ops->set_value
+       -> pmbus_regulator_set_value(dev, uV)
+          pmbus_regulator_select_page(priv)
+          pmbus_read_byte(VOUT_MODE)
+          check (mode == LINEAR)         [LINEAR16 only today]
+          raw = pmbus_data2reg_linear16(uV, mode)
+          dm_i2c_write(VOUT_COMMAND, raw)
+
+Read / write enable bit::
+
+    regulator_get_enable(dev)
+       -> pmbus_regulator_get_enable(dev)
+          pmbus_read_byte(OPERATION) & PB_OPERATION_ON
+
+    regulator_set_enable(dev, on)
+       -> pmbus_regulator_set_enable(dev, on)
+          read OPERATION, set or clear PB_OPERATION_ON, write back
+
+Bus traffic per call:
+
+* ``get_value``  : 1 byte read (VOUT_MODE) + 1 word read (READ_VOUT)
+  + 1 byte write (PAGE) when ``page > 0``
+* ``set_value``  : 1 byte read (VOUT_MODE) + 1 word write (VOUT_COMMAND)
+  + 1 byte write (PAGE) when ``page > 0``
+* ``get_enable`` : 1 byte read (OPERATION)
+* ``set_enable`` : 1 byte read (OPERATION) + 1 byte write (OPERATION)
+
+Common board hook patterns
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Boot time rail snapshot::
+
+    static int my_board_pmbus_snapshot(void)
+    {
+        struct udevice *reg;
+
+        if (regulator_get_by_platname("MY_RAIL", &reg))
+            return 0;
+        printf("MY_RAIL: VOUT = %d uV, enabled = %d\n",
+               regulator_get_value(reg),
+               regulator_get_enable(reg));
+        return 0;
+    }
+    EVENT_SPY_SIMPLE(EVT_LAST_STAGE_INIT, my_board_pmbus_snapshot);
+
+The first call to ``regulator_get_value()`` triggers the chip
+driver's ``.probe``, which seeds the chip match and vendor
+extension registries. Subsequent ``pmbus`` CLI commands work
+without further setup.
+
+Pre kernel rail trim (AVS)::
+
+    int board_late_init(void)
+    {
+        struct udevice *reg;
+        int target_uV = compute_avs_target();
+
+        if (regulator_get_by_platname("VDD_CORE", &reg))
+            return 0;
+        return regulator_set_value_force(reg, target_uV);
+    }
+
+Use ``regulator_set_value_force()`` when the target may sit
+outside the DT declared ``regulator-min-microvolt`` /
+``regulator-max-microvolt`` range; force bypasses the bounds
+check.
+
+Adding a new PMBus chip from scratch
+------------------------------------
+
+Use this path when the chip has no Linux driver yet, or when you want
+to validate the U-Boot port against the datasheet alone.
+
+1. Confirm PMBus 1.x compliance level. Locate in the chip
+   datasheet:
+
+     which PMBus standard command codes the chip implements
+     (``READ_VIN``, ``READ_VOUT``, ``STATUS_WORD``, ``MFR_ID`` ...),
+     which numeric format(s) it uses for VOUT (LINEAR16 with the
+     exponent in ``VOUT_MODE``, DIRECT with chip specific m/b/R, or
+     VID with one of the documented VRM tables),
+     which numeric format it uses for VIN, IIN, IOUT, TEMPERATURE
+     (most commonly LINEAR11; some MPS / MPS derivative chips use
+     DIRECT instead),
+     how many output rails it exposes (single page parts vs.
+     multi rail PMBus pages).
+
+2. Declare a ``struct pmbus_driver_info``. Wire each sensor
+   class to one ``enum pmbus_data_format``, plus the m/b/R triple if
+   the format is DIRECT::
+
+      static struct pmbus_driver_info chipname_info = {
+          .pages = 1,
+          .format[PSC_VOLTAGE_IN]  = pmbus_fmt_direct,
+          .format[PSC_VOLTAGE_OUT] = pmbus_fmt_linear,
+          .format[PSC_CURRENT_OUT] = pmbus_fmt_direct,
+          .format[PSC_TEMPERATURE] = pmbus_fmt_direct,
+          .m[PSC_VOLTAGE_IN]  = 4,  .R[PSC_VOLTAGE_IN]  = 1,
+          .m[PSC_CURRENT_OUT] = 16, .R[PSC_CURRENT_OUT] = 0,
+          .m[PSC_TEMPERATURE] = 1,  .R[PSC_TEMPERATURE] = 0,
+      };
+
+3. Bind to a DT compatible. Use the lowercase ``vendor,chip``
+   tuple Linux uses (see "DT alignment with Linux" below). Add the
+   driver under ``drivers/power/regulator/`` matching the existing
+   skeleton (``fan53555.c``, ``pca9450.c``).
+
+4. Add a YAML schema under
+   ``doc/device-tree-bindings/regulator/<vendor>,<chip>.yaml``.
+   Mirror the upstream Linux binding when it exists; cross reference
+   the kernel YAML in the schema description.
+
+5. Smoke test. With the chip wired up in DT::
+
+      => regulator dev <name>
+      => regulator value
+      => regulator info
+
+   Numbers should match the bench measurement to within the chip's
+   advertised LSB.
+
+Porting an existing Linux PMBus driver to U-Boot
+------------------------------------------------
+
+When the chip already has a ``linux/drivers/hwmon/pmbus/<chip>.c``,
+that driver is the authoritative reference for format, coefficients,
+and quirks. Take what carries; leave what does not.
+
+What carries verbatim
+~~~~~~~~~~~~~~~~~~~~~
+
+* Numeric formats (``format[PSC_*]``).
+* DIRECT coefficients (``m[]``, ``b[]``, ``R[]``).
+* Per page count and per page functionality bits (``pages``,
+  ``func[]``).
+* VOUT_MODE driven per chip identify hook (e.g. MPQ8785's
+  switch between LINEAR16 and VID coerced DIRECT m=64 R=1).
+* Vendor register addresses for chip specific quirks (fault
+  history, scale-loop, page mapping).
+
+What does not carry
+~~~~~~~~~~~~~~~~~~~~~~~
+
+* ``hwmon_device_register()`` and the attribute groups it consumes.
+* ``struct pmbus_data`` / ``update_lock`` / ``last_updated``
+  U-Boot has no caching layer.
+* ALERT# IRQ wiring; U-Boot is single threaded boot code.
+* Fan control hooks (``read_fan_*``, ``set_pwm_*``).
+* Virtual register handling (``PMBUS_VIRT_READ_VIN_*`` etc.); those
+  are entirely a hwmon publication aid.
+* ``module_i2c_driver(...)`` and ``MODULE_*`` macros; U-Boot uses
+  ``U_BOOT_DRIVER(...)``.
+
+Worked example: porting MPQ8785
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Linux's ``drivers/hwmon/pmbus/mpq8785.c`` is 193 LOC; the U-Boot
+equivalent is ~150 LOC.
+
+The ``mpq8785_info`` struct transcribes verbatim::
+
+    .pages = 1,
+    .format[PSC_VOLTAGE_IN]  = direct,  .m[PSC_VOLTAGE_IN]  = 4,  .R[PSC_VOLTAGE_IN]  = 1,
+    .format[PSC_CURRENT_OUT] = direct,  .m[PSC_CURRENT_OUT] = 16, .R[PSC_CURRENT_OUT] = 0,
+    .format[PSC_TEMPERATURE] = direct,  .m[PSC_TEMPERATURE] = 1,  .R[PSC_TEMPERATURE] = 0,
+
+The VOUT format is decided at probe time from VOUT_MODE bits[7:5] :
+mode 0 means LINEAR16, mode 1 or 2 means DIRECT m=64 R=1 (the chip's
+"VID" mode is coerced to DIRECT by the driver). Translate Linux's
+``mpq8785_identify()`` 1:1.
+
+The per chip quirks that carry over:
+
+* MPS NVM string byte order: chip stores ``S P M`` for the human
+  string ``MPS``. ``pmbus_read_string()`` accepts a ``reverse_bytes``
+  flag for this case.
+* ``mps,vout-fb-divider-ratio-permille`` DT property maps to
+  ``VOUT_SCALE_LOOP`` write at probe time.
+
+The quirks that do not carry over:
+
+* The ``PMBUS_VIRT_*`` virtual sensor wiring. Drop entirely.
+* The ``hwmon_chip_info`` attribute group registration.
+* The ``MODULE_AUTHOR`` / ``MODULE_LICENSE`` declarations.
+
+Using the generic ``compatible = "pmbus"`` driver
+-------------------------------------------------
+
+When a board carries a PMBus chip without a per chip U-Boot driver,
+the catch all ``drivers/power/regulator/pmbus_generic.c`` (Layer 3b)
+binds against ``compatible = "pmbus"``. It auto detects format via
+``VOUT_MODE`` and ``PMBUS_QUERY`` (where the chip supports it) and
+provides telemetry + voltage set/get against the standard PMBus 1.x
+subset.
+
+Decision tree:
+
+1. Try the generic driver first. Add the regulator node to the
+   board DT with ``compatible = "pmbus"`` plus the standard
+   regulator properties. Boot, run ``regulator value``, compare
+   against bench measurement.
+2. Switch to a per chip driver only when the generic one is
+   wrong: telemetry shows wrong values (chip uses DIRECT with
+   non default coefficients), an alert can't be decoded (chip has
+   vendor specific status bits), AVS is needed (the boot path has
+   to actively trim VOUT before kernel handoff), or the chip has an
+   ADDR-pin auto promotion / VID coercion / vendor register quirk.
+
+DT alignment with Linux
+-----------------------
+
+The same ``.dts`` file should work under both U-Boot (BL33) and Linux
+post handoff. To make that possible:
+
+* Reuse the upstream Linux compatible for every PMBus chip. Look
+  in ``linux/Documentation/devicetree/bindings/hwmon/pmbus/`` and
+  ``linux/Documentation/devicetree/bindings/regulator/``. The
+  ``<vendor>,<chip>`` tuple from the kernel binding goes into U-Boot's
+  ``of_match_table`` unchanged.
+* Reuse Linux property names verbatim: ``regulator-name``,
+  ``regulator-min-microvolt``, ``regulator-max-microvolt``,
+  ``regulator-boot-on``, ``regulator-always-on``,
+  ``mps,vout-fb-divider-ratio-permille``, etc.
+* Mirror the Linux YAML schema as
+  ``doc/device-tree-bindings/regulator/<vendor>,<chip>.yaml``. The
+  U-Boot schema can be a strict subset (drop hwmon only properties
+  that have no U-Boot effect), and should cite the kernel YAML as the
+  canonical source.
+
+Multi rail/multi page chips (e.g. ISL68137 with seven outputs)
+declare each rail as a child regulator node with ``reg = <page>``;
+each child binds as a UCLASS_REGULATOR with that PMBus PAGE setting
+applied at every read/write.
+
+Common pitfalls
+---------------
+
+These have all bitten contributors during nbxv3 bring up; record them
+here so the next port doesn't repeat them.
+
+* VOUT_MODE/DIRECT format confusion. Most generic PMBus call
+  sites assume LINEAR16. Several MPS chips report VOUT in DIRECT
+  format with chip specific m/b/R after a single VOUT_MODE read,
+  the same chip read at the same address produces different
+  numbers depending on the format the driver applies. Always read
+  ``VOUT_MODE`` at probe time and switch the decoder accordingly.
+  Linux's per chip ``identify()`` callbacks document the exact
+  rules; copy them rather than guessing.
+* SMBus block read protocol. Some I2C controllers strict check
+  block read transactions: the master must read the length byte
+  first, then reissue the read for the payload. Over reading a
+  fixed length and ignoring the length byte works on lenient
+  controllers but errors on strict ones. ``pmbus_read_string()``
+  does the two stage read; use it.
+* I2C bus number stability. ``uclass_get_device_by_seq()``
+  uses the DT alias index (``i2c0`` -> ``UCLASS_I2C`` seq 0) when
+  aliases are declared, otherwise falls back to probe order which
+  varies with which controllers are enabled in the defconfig.
+  Always declare DT aliases for I2C buses you reference by index.
+* ADDR-pin auto addressessing. Some chips (notably MPS parts) decode
+  their PMBus 7-bit address from an external resistor divider on
+  ADDR_VBOOT. The "default" address in the datasheet is the
+  factory fused slot; a board with a different divider or a die
+  with a different revision can land in another window. If the
+  driver hardcodes the default and the board side scan finds the
+  chip in another window, auto promote the working address rather
+  than failing the probe.
+* MFR string byte order. Most PMBus chips return ``MFR_ID``
+  characters in human order. Some MPS personalities reverse them.
+  Pass ``reverse_bytes=true`` to ``pmbus_read_string()`` for those;
+  spec compliant chips pass false.
+
+References
+----------
+
+* Linux PMBus core: ``linux/drivers/hwmon/pmbus/pmbus_core.c``,
+  decoder reference; ignore the hwmon publication and caching layers.
+* Linux PMBus header: ``linux/drivers/hwmon/pmbus/pmbus.h``; API
+  surface reference; many constants and the ``struct
+  pmbus_driver_info`` shape are mirrored verbatim into U-Boot's
+  ``include/pmbus.h``.
+* Linux DT bindings:
+  ``linux/Documentation/devicetree/bindings/hwmon/pmbus/``.
diff --git a/doc/device-tree-bindings/regulator/pmbus.yaml b/doc/device-tree-bindings/regulator/pmbus.yaml
new file mode 100644
index 00000000000..bcdf9c42f94
--- /dev/null
+++ b/doc/device-tree-bindings/regulator/pmbus.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/pmbus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic PMBus 1.x compatible voltage regulator (U-Boot subset)
+
+maintainers:
+  - Vincent Jardin <vjardin@free.fr>
+
+description: |
+  Catch all binding for any PMBus 1.x compliant voltage regulator that
+  does not yet have a per chip U-Boot driver under
+  drivers/power/regulator/. The matching driver auto detects the
+  numeric format from VOUT_MODE (and from PMBUS_QUERY where the chip
+  supports it) and provides telemetry plus voltage set / get against
+  the standard PMBus command codes (PMBUS_VOUT_MODE, PMBUS_VOUT_COMMAND,
+  PMBUS_READ_VOUT, ...).
+
+  This U-Boot subset mirrors the upstream Linux kernel pattern used
+  by linux/drivers/hwmon/pmbus/pmbus.c (the generic probe driver
+  matched against compatible "pmbus"). Property names and semantics
+  follow the standard regulator binding so the same .dts works under
+  both U-Boot (BL33) and Linux post handoff. Properties that only
+  affect the kernel hwmon publication are accepted and ignored.
+
+  Use this binding to ship telemetry today on a new board carrying a
+  compliant chip; promote to a per chip driver only when chip
+  specific quirks (vendor registers, VID coercion, ADDR pin auto
+  promotion, non standard m / b / R coefficients) need handling.
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    const: pmbus
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@5e {
+            compatible = "pmbus";
+            reg = <0x5e>;
+            regulator-name = "VDD_CORE";
+            regulator-min-microvolt = < 600000>;
+            regulator-max-microvolt = <1100000>;
+            regulator-boot-on;
+            regulator-always-on;
+        };
+    };
+...
diff --git a/include/pmbus.h b/include/pmbus.h
new file mode 100644
index 00000000000..969108e5b53
--- /dev/null
+++ b/include/pmbus.h
@@ -0,0 +1,629 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ *
+ * PMBus 1.x command codes, numeric format decoders, and driver_info
+ * scaffolding for U-Boot.
+ *
+ * Intents
+ *
+ * U-Boot's PMBus support is not a hwmon clone. It shall be used to:
+ *   1. identify PMBus regulators a board carries at boot,
+ *   2. print telemetry so an operator can confirm rail voltages and
+ *      fault status before handing off to the kernel,
+ *   3. decode chip alerts when a rail trips an over/under voltage,
+ *      over current, or thermal threshold,
+ *   4. optionally trim a critical rail before kernel boot, to better
+ *      protect the board.
+ *
+ * No periodic polling, no /sys, no userspace surface, no fan control
+ * loops. Linux owns those. See doc/develop/pmbus.rst for the full
+ * porting guide and policy notes.
+ *
+ * Linux relationship
+ *
+ * Constants (command codes, status bit names, sensor class enum,
+ * format enum) are mirrored verbatim from
+ *   linux/drivers/hwmon/pmbus/pmbus.h
+ * with attribution; this is standardised data and copying it avoids
+ * accidental drift. Decoders (LINEAR11/16, DIRECT, VID, IEEE754) are
+ * reimplemented from the PMBus 1.x spec rather than copied. The
+ * surrounding kernel context (struct pmbus_data, hwmon caching,
+ * sysfs publication) does not apply to U-Boot.
+ *
+ * Tree level files (this header, lib/pmbus.c, future per chip drivers
+ * under drivers/power/regulator/) must stay platform agnostic. They
+ * may reference only the PMBus 1.x specification and chip datasheets,
+ * never a specific board, SoC, or product. Board specific quirks
+ * live under board/<vendor>/<board>/.
+ */
+
+#ifndef _PMBUS_H_
+#define _PMBUS_H_
+
+#include <linux/types.h>
+
+struct udevice;
+struct pmbus_driver_info;
+struct pmbus_status_override;
+
+/*
+ * PMBus 1.3 standard command codes (Part II).
+ *
+ * Subset relevant to U-Boot's needs:
+ * - configuration (PAGE, OPERATION, VOUT_*),
+ * - telemetry (READ_VIN, READ_IOUT, READ_TEMPERATURE_1, ...),
+ * - status (STATUS_WORD, STATUS_VOUT, ...),
+ * - identification (MFR_ID, MFR_MODEL, MFR_REVISION).
+ * Chip specific extensions (for example MPS PROTECTION_LAST 0xFB) shall be in
+ * the per chip driver file.
+ */
+#define PMBUS_PAGE			0x00
+#define PMBUS_OPERATION			0x01
+#define PMBUS_ON_OFF_CONFIG		0x02
+#define PMBUS_CLEAR_FAULTS		0x03
+#define PMBUS_PHASE			0x04
+
+#define PMBUS_WRITE_PROTECT		0x10
+
+#define PMBUS_CAPABILITY		0x19
+#define PMBUS_QUERY			0x1a
+#define PMBUS_SMBALERT_MASK		0x1b
+#define PMBUS_VOUT_MODE			0x20
+#define PMBUS_VOUT_COMMAND		0x21
+#define PMBUS_VOUT_TRIM			0x22
+#define PMBUS_VOUT_CAL_OFFSET		0x23
+#define PMBUS_VOUT_MAX			0x24
+#define PMBUS_VOUT_MARGIN_HIGH		0x25
+#define PMBUS_VOUT_MARGIN_LOW		0x26
+#define PMBUS_VOUT_TRANSITION_RATE	0x27
+#define PMBUS_VOUT_DROOP		0x28
+#define PMBUS_VOUT_SCALE_LOOP		0x29
+#define PMBUS_VOUT_SCALE_MONITOR	0x2a
+
+#define PMBUS_COEFFICIENTS		0x30
+#define PMBUS_POUT_MAX			0x31
+
+#define PMBUS_STATUS_BYTE		0x78
+#define PMBUS_STATUS_WORD		0x79
+#define PMBUS_STATUS_VOUT		0x7a
+#define PMBUS_STATUS_IOUT		0x7b
+#define PMBUS_STATUS_INPUT		0x7c
+#define PMBUS_STATUS_TEMPERATURE	0x7d
+#define PMBUS_STATUS_CML		0x7e
+#define PMBUS_STATUS_OTHER		0x7f
+#define PMBUS_STATUS_MFR_SPECIFIC	0x80
+
+#define PMBUS_READ_VIN			0x88
+#define PMBUS_READ_IIN			0x89
+#define PMBUS_READ_VCAP			0x8a
+#define PMBUS_READ_VOUT			0x8b
+#define PMBUS_READ_IOUT			0x8c
+#define PMBUS_READ_TEMPERATURE_1	0x8d
+#define PMBUS_READ_TEMPERATURE_2	0x8e
+#define PMBUS_READ_TEMPERATURE_3	0x8f
+#define PMBUS_READ_DUTY_CYCLE		0x94
+#define PMBUS_READ_FREQUENCY		0x95
+#define PMBUS_READ_POUT			0x96
+#define PMBUS_READ_PIN			0x97
+
+#define PMBUS_REVISION			0x98
+#define PMBUS_MFR_ID			0x99
+#define PMBUS_MFR_MODEL			0x9a
+#define PMBUS_MFR_REVISION		0x9b
+#define PMBUS_MFR_LOCATION		0x9c
+#define PMBUS_MFR_DATE			0x9d
+#define PMBUS_MFR_SERIAL		0x9e
+
+#define PMBUS_IC_DEVICE_ID		0xad
+#define PMBUS_IC_DEVICE_REV		0xae
+
+/* VOUT_MODE upper bits: numeric format selector (Part II sec 8.3). */
+#define PB_VOUT_MODE_MODE_MASK		0xe0
+#define PB_VOUT_MODE_PARAM_MASK		0x1f
+#define PB_VOUT_MODE_LINEAR		0x00
+#define PB_VOUT_MODE_VID		0x20
+#define PB_VOUT_MODE_DIRECT		0x40
+#define PB_VOUT_MODE_IEEE754		0x60
+
+/* STATUS_WORD lower byte (= STATUS_BYTE), Part II sec 10.1.1. */
+#define PB_STATUS_NONE_ABOVE		BIT(0)
+#define PB_STATUS_CML			BIT(1)
+#define PB_STATUS_TEMPERATURE		BIT(2)
+#define PB_STATUS_VIN_UV		BIT(3)
+#define PB_STATUS_IOUT_OC		BIT(4)
+#define PB_STATUS_VOUT_OV		BIT(5)
+#define PB_STATUS_OFF			BIT(6)
+#define PB_STATUS_BUSY			BIT(7)
+
+/* STATUS_WORD upper byte. */
+#define PB_STATUS_UNKNOWN		BIT(8)
+#define PB_STATUS_OTHER			BIT(9)
+#define PB_STATUS_FANS			BIT(10)
+#define PB_STATUS_POWER_GOOD_N		BIT(11)
+#define PB_STATUS_WORD_MFR		BIT(12)
+#define PB_STATUS_INPUT			BIT(13)
+#define PB_STATUS_IOUT_POUT		BIT(14)
+#define PB_STATUS_VOUT			BIT(15)
+
+/* STATUS_VOUT (PMBus 1.3.1 Part II sec 17.3, Table 17). */
+#define PB_VOLTAGE_VOUT_MAX_MIN_WARN	BIT(3)
+#define PB_VOLTAGE_UV_FAULT		BIT(4)
+#define PB_VOLTAGE_UV_WARNING		BIT(5)
+#define PB_VOLTAGE_OV_WARNING		BIT(6)
+#define PB_VOLTAGE_OV_FAULT		BIT(7)
+
+/* STATUS_IOUT (Part II sec 10.6). */
+#define PB_POUT_OP_WARNING		BIT(0)
+#define PB_POUT_OP_FAULT		BIT(1)
+#define PB_POWER_LIMITING		BIT(2)
+#define PB_CURRENT_SHARE_FAULT		BIT(3)
+#define PB_IOUT_UC_FAULT		BIT(4)
+#define PB_IOUT_OC_WARNING		BIT(5)
+#define PB_IOUT_OC_LV_FAULT		BIT(6)
+#define PB_IOUT_OC_FAULT		BIT(7)
+
+/* STATUS_INPUT (Part II sec 10.7). */
+#define PB_PIN_OP_WARNING		BIT(0)
+#define PB_IIN_OC_WARNING		BIT(1)
+#define PB_IIN_OC_FAULT			BIT(2)
+
+/* STATUS_TEMPERATURE (Part II sec 10.8). */
+#define PB_TEMP_UT_FAULT		BIT(4)
+#define PB_TEMP_UT_WARNING		BIT(5)
+#define PB_TEMP_OT_WARNING		BIT(6)
+#define PB_TEMP_OT_FAULT		BIT(7)
+
+/* STATUS_CML (Part II sec 10.9). */
+#define PB_CML_FAULT_OTHER_MEM_LOGIC	BIT(0)
+#define PB_CML_FAULT_OTHER_COMM		BIT(1)
+#define PB_CML_FAULT_PROCESSOR		BIT(3)
+#define PB_CML_FAULT_MEMORY		BIT(4)
+#define PB_CML_FAULT_PACKET_ERROR	BIT(5)
+#define PB_CML_FAULT_INVALID_DATA	BIT(6)
+#define PB_CML_FAULT_INVALID_COMMAND	BIT(7)
+
+/*
+ * OPERATION (01h) command bits per PMBus 1.3 Part II sec 9.1. Bit[7]
+ * is the master rail enable; the lower bits select margin high/low
+ * and turn off behaviour (subset surfaced for the regulator helper).
+ */
+#define PB_OPERATION_ON			BIT(7)
+
+/*
+ * LINEAR11 numeric format (PMBus 1.3 Part II sec 7): 16 bit register
+ * with a signed 11 bit mantissa in bits[10:0] and a signed 5 bit
+ * exponent in bits[15:11]. Engineering value = mantissa * 2^exponent.
+ */
+#define PB_LINEAR11_MANT_MASK		0x07ff
+#define PB_LINEAR11_MANT_BITS		11
+#define PB_LINEAR11_EXP_SHIFT		11
+#define PB_LINEAR11_EXP_MASK		0x1f
+#define PB_LINEAR11_EXP_BITS		5
+
+/*
+ * Cache buffer sizes for the active device singleton + MFR_* block
+ * reads. PMBus block reads return up to 32 bytes per the SMBus spec;
+ * 16 covers every MFR string seen in practice on regulator class
+ * chips and keeps the singleton compact.
+ */
+#define PMBUS_MFR_STRING_MAX		16
+#define PMBUS_VENDOR_NAME_MAX		8
+#define PMBUS_REGULATOR_NAME_MAX	24
+
+/* PMBus revision identifiers reported by PMBUS_REVISION (98h). */
+#define PMBUS_REV_10			0x00	/* PMBus 1.0 */
+#define PMBUS_REV_11			0x11	/* PMBus 1.1 */
+#define PMBUS_REV_12			0x22	/* PMBus 1.2 */
+#define PMBUS_REV_13			0x33	/* PMBus 1.3 */
+
+/*
+ * Numeric formats and sensor classes.
+ *
+ * Mirrors linux/drivers/hwmon/pmbus/pmbus.h enum pmbus_data_format
+ * and enum pmbus_sensor_classes. A chip's pmbus_driver_info wires
+ * each sensor class to one format and (for DIRECT) to its m/b/R
+ * coefficients.
+ */
+enum pmbus_data_format {
+	pmbus_fmt_linear = 0,
+	pmbus_fmt_ieee754,
+	pmbus_fmt_direct,
+	pmbus_fmt_vid,
+};
+
+enum pmbus_sensor_classes {
+	PSC_VOLTAGE_IN = 0,
+	PSC_VOLTAGE_OUT,
+	PSC_CURRENT_IN,
+	PSC_CURRENT_OUT,
+	PSC_POWER,
+	PSC_TEMPERATURE,
+	PSC_NUM_CLASSES
+};
+
+/*
+ * Per chip identification record. Each per chip driver declares one
+ * of these and points the framework at it. Subset of the kernel
+ * struct pmbus_driver_info: U-Boot has no per page caches, no fan
+ * accessors, no virtual registers, no async sysfs publication.
+ *
+ *   pages         number of PAGE distinct rails the chip exposes
+ *                 (1 for single rail parts).
+ *   format[]      numeric format per sensor class.
+ *   m/b/R[]       DIRECT format coefficients per sensor class. See
+ *                 pmbus_reg2data_direct() below for the formula.
+ *                 Unused for non DIRECT classes.
+ *   read_byte_data, read_word_data
+ *                 optional per chip register translators. Return the
+ *                 standard register value on success, ENODATA to fall
+ *                 through to the generic transport, any other negative
+ *                 errno on bus error.
+ *   identify      optional probe time hook to discover format and
+ *                 page count from the chip itself (for example, the
+ *                 MPQ8785 VOUT_MODE switch between LINEAR and DIRECT).
+ */
+struct pmbus_driver_info {
+	int pages;
+	enum pmbus_data_format format[PSC_NUM_CLASSES];
+	int m[PSC_NUM_CLASSES];
+	int b[PSC_NUM_CLASSES];
+	int R[PSC_NUM_CLASSES];
+
+	int (*read_byte_data)(struct udevice *dev, int page, int reg);
+	int (*read_word_data)(struct udevice *dev, int page, int reg);
+	int (*identify)(struct udevice *dev, struct pmbus_driver_info *info);
+
+	/*
+	 * Optional sparse table of chip specific STATUS_* bit name
+	 * substitutions. Terminated by an entry with .name = NULL
+	 * (matching the convention used by struct udevice_id and
+	 * other U-Boot driver tables). NULL pointer means the chip
+	 * uses only PMBus 1.x standard names. See struct
+	 * pmbus_status_override and pmbus_print_status_bits().
+	 */
+	const struct pmbus_status_override *status_overrides;
+
+	/*
+	 * Bitmask (BIT(enum pmbus_sensor_classes)) of the sensor classes
+	 * this chip actually implements. When non-zero, pmbus_print_telemetry
+	 * prints exactly these classes -- mirroring the kernel's per chip
+	 * sensor set -- and skips the rest. This is how an MPS buck that
+	 * ACKs READ_POUT / READ_IIN with an uncalibrated value still hides
+	 * POWER / CURRENT_IN (the kernel's mpq8646 driver exposes neither).
+	 * Zero means "not declared": the telemetry printer falls back to a
+	 * live pmbus_word_command_supported() probe per class, which is what
+	 * the generic driver (compatible = "pmbus") relies on.
+	 */
+	u8 classes_present;
+};
+
+/*
+ * Decoder helpers (raw register, returns engineering value in micro
+ * units).
+ *
+ * All return signed micro units (uV, uA, udegC), 64 bit to avoid
+ * overflow on large mantissa times exponent products. The caller
+ * divides by 1000 for milli units, or by 1_000_000 for the integer
+ * engineering value.
+ */
+
+/*
+ * LINEAR11. Bits[15:11] = signed 5 bit exponent Y, bits[10:0] =
+ * signed 11 bit mantissa N. Engineering value = N * 2^Y.
+ *
+ * Used by most PMBus chips for VIN, IIN, IOUT, TEMP. Some MPS
+ * parts deviate (they report DIRECT format with chip specific m/b/R
+ * coefficients); check the chip datasheet against PMBUS_VOUT_MODE
+ * and the Linux per chip driver if porting.
+ */
+s64 pmbus_reg2data_linear11(u16 raw);
+
+/*
+ * LINEAR16. 16 bit unsigned mantissa multiplied by 2^Y, where Y is
+ * the signed 5 bit exponent supplied via VOUT_MODE bits[4:0]. The
+ * caller must read VOUT_MODE (cmd 0x20) and pass it in vout_mode.
+ * Only the mode_mask bits[7:5] = 0 selector is the LINEAR16 path.
+ *
+ * Used for READ_VOUT (8Bh) on chips whose VOUT_MODE selects Linear.
+ * Returns 0 if VOUT_MODE indicates a non Linear mode; the caller
+ * is then expected to dispatch to pmbus_reg2data_direct() with the
+ * appropriate per chip m/b/R, or to pmbus_reg2data_vid() / _ieee754()
+ * if the chip uses those formats.
+ */
+s64 pmbus_reg2data_linear16(u16 raw, u8 vout_mode);
+
+/*
+ * DIRECT. PMBus 1.3 Part II sec 8.4. The chip stores a signed 16 bit
+ * value X; the engineering value Y is one over m, multiplied by the
+ * quantity (X scaled by ten to the power minus R, then offset by
+ * minus b), with chip specific (m, b, R) coefficients.
+ *
+ * In symbolic form: Y = (1/m) * (X * 10**(-R) - b). The negative
+ * exponent and trailing subtraction are math operators in the
+ * formula, not punctuation in the prose.
+ *
+ * Returns micro units. Implementation order matches the Linux
+ * reference (multiply before subtract, scale R then divide by m) to
+ * minimise quantisation drift. m == 0 returns 0.
+ */
+s64 pmbus_reg2data_direct(s16 raw, int m, int b, int R);
+
+/*
+ * Encoder: engineering value (micro units) to LINEAR16 raw register
+ * value. Used by pre kernel rail trim code (see board/nxp/common/vid.c)
+ * to write VOUT_COMMAND from a target voltage. The exponent is
+ * recovered from VOUT_MODE.
+ *
+ * Returns 0 if VOUT_MODE indicates a non Linear format; the caller
+ * must then dispatch to pmbus_data2reg_direct() (DIRECT format) or
+ * the VID / IEEE754 encoders (when those land) per the chip's actual
+ * VOUT_MODE selector.
+ */
+u16 pmbus_data2reg_linear16(s64 micro, u8 vout_mode);
+
+/*
+ * Encoder: engineering value (micro units) to DIRECT raw register
+ * value. Inverse of pmbus_reg2data_direct():
+ *
+ *   X = (m * Y + b) * 10^R
+ *
+ * with chip specific (m, b, R) coefficients (typically taken from
+ * the chip's pmbus_driver_info[PSC_VOLTAGE_OUT]). m == 0 returns 0.
+ *
+ * The result is saturated to the s16 range mandated by the PMBus
+ * 1.3 Part II sec 8.4 DIRECT encoding; out of range targets return
+ * 0x7fff or 0x8000 rather than wrapping.
+ */
+u16 pmbus_data2reg_direct(s64 micro, int m, int b, int R);
+
+/*
+ * Dispatcher: pick the right reg2data_* helper based on the chip's
+ * pmbus_driver_info[class]. vout_mode is consulted only for
+ * VOLTAGE_OUT in linear format. For DIRECT, m/b/R are taken from
+ * info. For VID and IEEE754 the dispatcher returns 0 (formats
+ * not yet wired up; add when a consumer lands).
+ */
+s64 pmbus_reg2data(const struct pmbus_driver_info *info,
+		   enum pmbus_sensor_classes class,
+		   u16 raw, u8 vout_mode);
+
+/*
+ * Transport helpers.
+ *
+ * Thin wrappers over the U-Boot DM I2C primitives that handle PMBus
+ * framing details (little endian word layout, two stage block read,
+ * CLEAR_FAULTS pseudo command without payload).
+ */
+
+/* Read a byte register. */
+int pmbus_read_byte(struct udevice *dev, u8 cmd, u8 *val);
+
+/* Read a 16 bit register, little endian on the wire. */
+int pmbus_read_word(struct udevice *dev, u8 cmd, u16 *val);
+
+/* Write a byte register. */
+int pmbus_write_byte(struct udevice *dev, u8 cmd, u8 val);
+
+/* Write a 16 bit register, little endian on the wire. */
+int pmbus_write_word(struct udevice *dev, u8 cmd, u16 val);
+
+/*
+ * Block read of a vendor string register (MFR_ID, MFR_MODEL,
+ * MFR_REVISION). The first wire byte is the payload length; the
+ * helper does the second read for the payload itself, so even strict
+ * I2C controllers (which forbid over read on block transactions)
+ * work. Output is null terminated and printable only (non printable
+ * bytes are substituted with '.').
+ *
+ * reverse_bytes: some MPS NVM personalities store ASCII strings
+ * LSB first (chip returns "SPM" for the human string "MPS"); pass
+ * true to reverse on copy. Spec compliant chips pass false.
+ *
+ * Returns string length on success or a negative errno on bus error
+ * or invalid length byte. outsz must be at least 2.
+ */
+int pmbus_read_string(struct udevice *dev, u8 cmd, char *out, int outsz,
+		      bool reverse_bytes);
+
+/* Issue a CLEAR_FAULTS (03h) write. Clears RAM sticky STATUS_*. */
+int pmbus_clear_faults(struct udevice *dev);
+
+/*
+ * Capability probe: is a word sized command implemented by the chip?
+ *
+ * Primary signal is the bus NAK -- compliant parts do not ACK a
+ * command they do not implement, so the word read fails. Secondary
+ * signal is a clean -> dirty transition of STATUS_CML[INVALID_COMMAND]
+ * across the read (a chip that ACKs but does not implement the
+ * register raises it). Non destructive: never issues CLEAR_FAULTS, so
+ * sticky fault history survives for a subsequent pmbus status; a
+ * pre existing CML fault disables the secondary signal so it cannot
+ * produce a false "unsupported".
+ *
+ * Returns true if the command appears supported, false otherwise.
+ */
+bool pmbus_word_command_supported(struct udevice *dev, u8 reg);
+
+/*
+ * High level snapshot printers shared by the pmbus CLI and board
+ * boot time diagnostics. Both operate on the current pmbus_active()
+ * device (select it first via pmbus_set_active()); chip is the I2C
+ * handle from pmbus_active_get_i2c() / the CLI's require_active().
+ *
+ * pmbus_print_telemetry: decodes VIN / VOUT / IIN / IOUT / POUT / TEMP
+ * through the active device's pmbus_driver_info (LINEAR / DIRECT / VID
+ * per VOUT_MODE and per class format), skipping commands the chip does
+ * not implement (pmbus_word_command_supported). Falls back to
+ * LINEAR16 / LINEAR11 when no driver_info is cached. Caller prints the
+ * header line.
+ *
+ * pmbus_print_status_word: reads + decodes STATUS_WORD with the active
+ * device's chip specific status_overrides, if any.
+ */
+void pmbus_print_telemetry(struct udevice *chip);
+void pmbus_print_status_word(struct udevice *chip);
+
+/*
+ * Status bit name decoding.
+ *
+ * Sparse mask to name table. pmbus_print_bits() emits only the bits
+ * that are SET in v, joined by |; if no bit is set, prints
+ * clean. Bits not in the table are silently ignored (RESERVED bits
+ * or chip specific bits handled by a separate per chip table).
+ */
+struct pmbus_bit {
+	u16 mask;
+	const char *name;
+};
+
+void pmbus_print_bits(u16 v, const struct pmbus_bit *tab);
+
+/*
+ * Per chip override entry. When a chip reuses a PMBus standard
+ * STATUS bit for a documented chip specific signal (for example MPS
+ * uses STATUS_WORD bit[12] = MFR_SPECIFIC as NVM_SUMMARY, bit[8] =
+ * UNKNOWN as WATCH_DOG, bit[0] = NONE_ABOVE as DRMOS_FAULT), the
+ * per chip driver supplies a sparse table of (reg, mask, name)
+ * triples and pmbus_print_status_bits() substitutes the chip name
+ * for the standard one when the bit is set.
+ *
+ * reg is one of PMBUS_STATUS_WORD / VOUT / IOUT / INPUT /
+ * TEMPERATURE / CML, so the same table can carry overrides for
+ * every status register on the chip in one place. Tables that omit
+ * a (reg, mask) leave the standard name in place.
+ *
+ * Override entries whose mask is NOT in the standard table are
+ * still printed (the chip can extend coverage beyond PMBus 1.x for
+ * vendor specific bits in standard registers).
+ *
+ * Tables are NULL terminated: the last entry has .name = NULL.
+ * Following the same convention U-Boot uses for struct udevice_id
+ * and other driver tables avoids the explicit-count foot-gun.
+ */
+struct pmbus_status_override {
+	u8 reg;
+	u16 mask;
+	const char *name;
+};
+
+/*
+ * Print the bit names of a STATUS_* register value. For each bit
+ * set in v, prefer a chip override matching (reg, mask) over the
+ * standard std table entry; if neither matches, the bit is
+ * silently skipped (RESERVED). If no bit is set at all, prints
+ * clean. Pass ovr = NULL to disable the override path.
+ */
+void pmbus_print_status_bits(u8 reg, u16 v,
+			     const struct pmbus_bit *std,
+			     const struct pmbus_status_override *ovr);
+
+/*
+ * Built in PMBus 1.3 standard bit tables (use these from per chip
+ * drivers and board diagnostics; vendor extensions go in chip local
+ * tables that the per chip driver passes alongside these).
+ */
+/*
+ * All tables below are NULL terminated (last entry has .name = NULL),
+ * so callers walk with for (t = tab; t && t->name; t++) and the
+ * helpers above need no count argument.
+ */
+extern const struct pmbus_bit pmbus_status_word_bits[];
+extern const struct pmbus_bit pmbus_status_vout_bits[];
+extern const struct pmbus_bit pmbus_status_iout_bits[];
+extern const struct pmbus_bit pmbus_status_input_bits[];
+extern const struct pmbus_bit pmbus_status_temp_bits[];
+extern const struct pmbus_bit pmbus_status_cml_bits[];
+
+/*
+ * Active device tracking for the pmbus U-Boot CLI.
+ *
+ * The framework keeps one active PMBus device. It is selected by
+ * pmbus dev <bus>:<addr> (raw I2C tuple) and remembered across
+ * subcommands so subsequent invocations of pmbus telemetry,
+ * pmbus status, pmbus dump, etc. operate on the same chip
+ * without re-typing the address.
+ *
+ * pmbus_set_active() probes the chip's MFR_ID at the given address,
+ * looks the result up in the chip-match registry (populated by
+ * per chip drivers via pmbus_register_chip()), and caches the
+ * resulting struct pmbus_driver_info. Subcommands consult
+ * pmbus_active() to find the cached metadata.
+ */
+struct pmbus_active_dev {
+	bool valid;
+	int bus_seq;
+	u8 addr;
+	char vendor[PMBUS_VENDOR_NAME_MAX];
+	char name[PMBUS_REGULATOR_NAME_MAX];	/* DT regulator-name when bound; "" otherwise */
+	char mfr_id[PMBUS_MFR_STRING_MAX];
+	char mfr_model[PMBUS_MFR_STRING_MAX];
+	char mfr_revision[PMBUS_MFR_STRING_MAX];
+	const struct pmbus_driver_info *info;
+};
+
+const struct pmbus_active_dev *pmbus_active(void);
+int pmbus_active_get_i2c(struct udevice **i2c_dev);
+int pmbus_set_active(int bus_seq, u8 addr);
+void pmbus_clear_active(void);
+
+/*
+ * Per chip driver / board file registers a chip match so the
+ * framework can associate an MFR_ID prefix (read at probe time)
+ * with a vendor namespace ("mps", "lltc", "renesas", ...) and a
+ * pmbus_driver_info pointer. The first matching entry wins.
+ *
+ * mfr_id_reverse flags MPS style chips that store the MFR_ID
+ * string LSB first (chip returns "SPM" for the human string
+ * "MPS"); the framework reads the string in both orderings and
+ * matches against the prefix in the natural reading.
+ */
+struct pmbus_chip_match {
+	const char *mfr_id;
+	bool mfr_id_reverse;
+	const char *vendor;
+	const struct pmbus_driver_info *info;
+};
+
+int pmbus_register_chip(const struct pmbus_chip_match *match);
+
+/*
+ * Resolve a regulator-name (DT regulator-name property) to its
+ * (bus, addr) tuple by walking UCLASS_REGULATOR. Used by the
+ * pmbus dev <name> CLI alias so a chip bound through DT can be
+ * selected by its human readable rail name (e.g. "+0V8_VDD")
+ * instead of the i2c bus / address pair. Returns 0 on success
+ * (out parameters populated and the regulator probed), or a
+ * negative errno if no match is found or the bus / address cannot
+ * be derived. Available only when CONFIG_DM_REGULATOR is set.
+ */
+int pmbus_resolve_by_name(const char *name, int *bus_seq, u8 *addr);
+
+/*
+ * Vendor extension dispatcher.
+ *
+ * When the user types pmbus <vendor> <args...>, the framework
+ * looks up the registered handler for <vendor> and calls it with
+ * the argv tail (argv[0] = "<vendor>"). The handler operates on
+ * pmbus_active(), or returns CMD_RET_USAGE if the active device is
+ * not from this vendor.
+ *
+ * Per chip drivers register their vendor handler at init time. The
+ * MPS extension publishes pmbus mps last, pmbus mps clear last,
+ * and pmbus mps clear force.
+ */
+typedef int (*pmbus_vendor_handler_t)(struct cmd_tbl *cmdtp, int flag,
+				      int argc, char *const argv[]);
+
+struct pmbus_vendor_op {
+	const char *vendor;
+	pmbus_vendor_handler_t handler;
+	const char *help;
+};
+
+int pmbus_register_vendor_handler(const struct pmbus_vendor_op *op);
+const struct pmbus_vendor_op *pmbus_lookup_vendor(const char *vendor);
+unsigned int pmbus_vendor_count(void);
+const struct pmbus_vendor_op *pmbus_vendor_at(unsigned int i);
+
+#endif /* _PMBUS_H_ */
diff --git a/lib/Kconfig b/lib/Kconfig
index 9e0f0ad7d06..24e55ade4d3 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -283,6 +283,22 @@ config PANIC_HANG
 	  development since you can try to debug the conditions that lead to
 	  the situation.
 
+config PMBUS
+	bool "PMBus 1.x decoder and transport helpers"
+	depends on DM_I2C
+	help
+	  Enable include/pmbus.h and lib/pmbus.c: standard PMBus 1.x
+	  command codes, LINEAR11, LINEAR16, and DIRECT numeric format
+	  decoders, the two stage SMBus block read helper used for
+	  MFR_ID, MFR_MODEL, and MFR_REVISION reads, and the table
+	  driven STATUS_* bit print helper.
+
+	  This is the substrate for any pre kernel PMBus consumer in
+	  U-Boot (board/nxp/common/vid.c rail trim, board local telemetry
+	  diagnostics, future per chip regulator drivers under
+	  drivers/power/regulator/). It is not a hwmon clone. See
+	  doc/develop/pmbus.rst for the policy notes.
+
 config REGEX
 	bool "Enable regular expression support"
 	default y if NET_LEGACY
diff --git a/lib/Makefile b/lib/Makefile
index d0ffabc2b47..222378a8531 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -53,6 +53,7 @@ obj-y += rc4.o
 obj-$(CONFIG_RBTREE)	+= rbtree.o
 obj-$(CONFIG_BITREVERSE) += bitrev.o
 obj-y += list_sort.o
+obj-$(CONFIG_PMBUS) += pmbus.o
 endif
 
 obj-$(CONFIG_$(PHASE_)TPM) += tpm-common.o
diff --git a/lib/pmbus.c b/lib/pmbus.c
new file mode 100644
index 00000000000..d49576ad3bd
--- /dev/null
+++ b/lib/pmbus.c
@@ -0,0 +1,859 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile, Vincent Jardin
+ *
+ * PMBus 1.x decoders, transport helpers, and standard status bit
+ * tables for U-Boot. See include/pmbus.h for the API surface and
+ * doc/develop/pmbus.rst for the porting guide.
+ *
+ * Decoder math is implemented from the PMBus 1.3 specification:
+ *   1. Part I  (transport): see
+ *      doc/PMBus/PMBus_Specification_Rev_1_3_1_Part_I_20150313.{pdf,txt}
+ *   2. Part II (commands):  see
+ *      doc/PMBus/PMBus_Specification_Rev_1_3_1_Part_II_20150313.{pdf,txt}
+ *
+ * Reference Linux implementation: linux/drivers/hwmon/pmbus/pmbus_core.c
+ * (the kernel side `struct pmbus_data` caching and hwmon publication
+ * layers do not apply; only the arithmetic carries over).
+ *
+ * No code in this file may reference a specific board, SoC, or
+ * product. Per chip quirks (MPS DIRECT format LSBs, vendor registers,
+ * VID coercion, ADDR_VBOOT auto promotion, and the like) belong in
+ * per chip drivers under drivers/power/regulator/ or in board local
+ * files under board/<vendor>/<board>/.
+ */
+
+#include <ctype.h>
+#include <dm.h>
+#include <i2c.h>
+#include <log.h>
+#include <pmbus.h>
+#include <limits.h>
+#include <linux/bitops.h>
+#include <power/regulator.h>
+
+static int pmbus_sign_extend(unsigned int v, unsigned int width)
+{
+	unsigned int mask = (1U << width) - 1U;
+	unsigned int sign = 1U << (width - 1U);
+
+	v &= mask;
+	if (v & sign)
+		v |= ~mask;
+	return (int)v;
+}
+
+s64 pmbus_reg2data_linear11(u16 raw)
+{
+	int mantissa = pmbus_sign_extend(raw & PB_LINEAR11_MANT_MASK,
+					 PB_LINEAR11_MANT_BITS);
+	int exponent = pmbus_sign_extend((raw >> PB_LINEAR11_EXP_SHIFT) &
+					 PB_LINEAR11_EXP_MASK,
+					 PB_LINEAR11_EXP_BITS);
+	s64 micro;
+
+	/* Engineering value = mantissa * 2^exponent, scaled to micro units. */
+	micro = (s64)mantissa * 1000000LL;
+	if (exponent >= 0)
+		micro <<= exponent;
+	else
+		micro >>= -exponent;
+	return micro;
+}
+
+s64 pmbus_reg2data_linear16(u16 raw, u8 vout_mode)
+{
+	int exponent;
+	s64 micro;
+
+	/*
+	 * VOUT_MODE bits[7:5] = mode; bits[4:0] = parameter. Linear mode
+	 * (000) treats bits[4:0] as the signed 5-bit exponent. For other
+	 * modes the caller must dispatch elsewhere.
+	 */
+	if ((vout_mode & PB_VOUT_MODE_MODE_MASK) != PB_VOUT_MODE_LINEAR)
+		return 0;
+
+	exponent = pmbus_sign_extend(vout_mode & PB_VOUT_MODE_PARAM_MASK, 5);
+
+	/* Mantissa is unsigned 16-bit; scale to micro units. */
+	micro = (s64)raw * 1000000LL;
+	if (exponent >= 0)
+		micro <<= exponent;
+	else
+		micro >>= -exponent;
+	return micro;
+}
+
+s64 pmbus_reg2data_direct(s16 raw, int m, int b, int R)
+{
+	s64 acc;
+
+	if (m == 0)
+		return 0;
+
+	/*
+	 * PMBus Part II sec 8.4:  Y = (1/m) * (X * 10^-R - b)
+	 *
+	 * Pre scale acc to micro units so the final integer division by
+	 * m absorbs the rounding loss into the least significant micro
+	 * digit rather than into a coarser place.
+	 */
+	acc = (s64)raw * 1000000LL;
+
+	/* Apply 10^-R: positive R means divide; negative R means multiply. */
+	while (R > 0) {
+		acc /= 10;
+		R--;
+	}
+	while (R < 0) {
+		acc *= 10;
+		R++;
+	}
+
+	/* Subtract the offset b, also in micro units. */
+	acc -= (s64)b * 1000000LL;
+
+	/* Final: divide by m. */
+	acc /= m;
+	return acc;
+}
+
+u16 pmbus_data2reg_linear16(s64 micro, u8 vout_mode)
+{
+	int exponent;
+	s64 raw;
+
+	if ((vout_mode & PB_VOUT_MODE_MODE_MASK) != PB_VOUT_MODE_LINEAR)
+		return 0;
+
+	exponent = pmbus_sign_extend(vout_mode & PB_VOUT_MODE_PARAM_MASK, 5);
+
+	/* raw = micro / (2^exponent * 10^6). */
+	raw = micro;
+	if (exponent >= 0)
+		raw >>= exponent;
+	else
+		raw <<= -exponent;
+	raw /= 1000000LL;
+
+	if (raw < 0)
+		raw = 0;
+	if (raw > U16_MAX)
+		raw = U16_MAX;
+	return (u16)raw;
+}
+
+u16 pmbus_data2reg_direct(s64 micro, int m, int b, int R)
+{
+	s64 acc;
+
+	if (m == 0)
+		return 0;
+
+	/*
+	 * Inverse of pmbus_reg2data_direct():  X = (m * Y + b) * 10^R.
+	 * Work in micro units throughout: acc = m * Y_micro + b * 10^6,
+	 * then scale by 10^R, finally divide by 10^6 to get the raw
+	 * chip count. Order chosen to match the decoder's quantisation
+	 * pattern so a round trip (data2reg then reg2data) returns the
+	 * input within +/- one LSB.
+	 */
+	acc = (s64)m * micro + (s64)b * 1000000LL;
+
+	while (R > 0) {
+		acc *= 10;
+		R--;
+	}
+	while (R < 0) {
+		acc /= 10;
+		R++;
+	}
+
+	acc /= 1000000LL;
+
+	/* PMBus 1.3 Part II sec 8.4 mandates a signed 16 bit raw value. */
+	if (acc > S16_MAX)
+		acc = S16_MAX;
+	if (acc < S16_MIN)
+		acc = S16_MIN;
+	return (u16)(s16)acc;
+}
+
+s64 pmbus_reg2data(const struct pmbus_driver_info *info,
+		   enum pmbus_sensor_classes class,
+		   u16 raw, u8 vout_mode)
+{
+	if (!info || class >= PSC_NUM_CLASSES)
+		return 0;
+
+	switch (info->format[class]) {
+	case pmbus_fmt_linear:
+		if (class == PSC_VOLTAGE_OUT)
+			return pmbus_reg2data_linear16(raw, vout_mode);
+		return pmbus_reg2data_linear11(raw);
+
+	case pmbus_fmt_direct:
+		return pmbus_reg2data_direct((s16)raw,
+					     info->m[class],
+					     info->b[class],
+					     info->R[class]);
+
+	case pmbus_fmt_vid:
+	case pmbus_fmt_ieee754:
+		/*
+		 * Not yet wired up. Add when a consumer lands. VID needs
+		 * the per page vrm_version table from the kernel's
+		 * pmbus_reg2data_vid(); IEEE754 needs the half precision
+		 * decoder from pmbus_reg2data_ieee754().
+		 */
+		return 0;
+	}
+
+	return 0;
+}
+
+int pmbus_read_byte(struct udevice *dev, u8 cmd, u8 *val)
+{
+	return dm_i2c_read(dev, cmd, val, 1);
+}
+
+int pmbus_read_word(struct udevice *dev, u8 cmd, u16 *val)
+{
+	u8 raw[2];
+	int ret;
+
+	ret = dm_i2c_read(dev, cmd, raw, 2);
+	if (ret)
+		return ret;
+	*val = (u16)raw[0] | ((u16)raw[1] << 8);
+	return 0;
+}
+
+int pmbus_write_byte(struct udevice *dev, u8 cmd, u8 val)
+{
+	return dm_i2c_write(dev, cmd, &val, 1);
+}
+
+int pmbus_write_word(struct udevice *dev, u8 cmd, u16 val)
+{
+	u8 raw[2];
+
+	raw[0] = (u8)(val & 0xff);	/* PMBus words are little-endian */
+	raw[1] = (u8)(val >> 8);
+	return dm_i2c_write(dev, cmd, raw, 2);
+}
+
+int pmbus_read_string(struct udevice *dev, u8 cmd, char *out, int outsz,
+		      bool reverse_bytes)
+{
+	u8 raw[PMBUS_MFR_STRING_MAX];
+	int ret, len, i;
+
+	if (outsz < 2)
+		return -EINVAL;
+
+	/* Stage 1: read the length byte. */
+	ret = dm_i2c_read(dev, cmd, raw, 1);
+	if (ret)
+		return ret;
+
+	len = raw[0];
+	if (len <= 0 || len > (int)sizeof(raw))
+		return -EBADMSG;
+	if (len > outsz - 1)
+		len = outsz - 1;
+
+	/* Stage 2: reread length + payload (some controllers mandate this). */
+	ret = dm_i2c_read(dev, cmd, raw, len + 1);
+	if (ret)
+		return ret;
+
+	if (reverse_bytes) {
+		for (i = 0; i < len; i++) {
+			u8 b = raw[len - i];
+
+			out[i] = isprint(b) ? (char)b : '.';
+		}
+	} else {
+		for (i = 0; i < len; i++) {
+			u8 b = raw[i + 1];
+
+			out[i] = isprint(b) ? (char)b : '.';
+		}
+	}
+	out[len] = '\0';
+	return len;
+}
+
+int pmbus_clear_faults(struct udevice *dev)
+{
+	return dm_i2c_write(dev, PMBUS_CLEAR_FAULTS, NULL, 0);
+}
+
+void pmbus_print_bits(u16 v, const struct pmbus_bit *tab)
+{
+	const struct pmbus_bit *t;
+	int first = 1;
+
+	if (v == 0) {
+		printf("clean");
+		return;
+	}
+	for (t = tab; t && t->name; t++) {
+		if (v & t->mask) {
+			printf("%s%s", first ? "" : "|", t->name);
+			first = 0;
+		}
+	}
+}
+
+void pmbus_print_status_bits(u8 reg, u16 v,
+			     const struct pmbus_bit *std,
+			     const struct pmbus_status_override *ovr)
+{
+	const struct pmbus_bit *s;
+	const struct pmbus_status_override *o;
+	int first = 1;
+
+	if (v == 0) {
+		printf("clean");
+		return;
+	}
+
+	/*
+	 * Pass 1: walk the standard table in declared order so the
+	 * printout retains the conventional bit-15-first ordering. For
+	 * each set bit, prefer a chip override matching (reg, mask).
+	 */
+	for (s = std; s && s->name; s++) {
+		const char *name;
+
+		if (!(v & s->mask))
+			continue;
+		name = s->name;
+		for (o = ovr; o && o->name; o++) {
+			if (o->reg == reg && o->mask == s->mask) {
+				name = o->name;
+				break;
+			}
+		}
+		printf("%s%s", first ? "" : "|", name);
+		first = 0;
+	}
+
+	/*
+	 * Pass 2: print overrides whose mask is not in the standard
+	 * table at all (chip-specific bit at a position the spec
+	 * leaves RESERVED). These would otherwise be swallowed.
+	 */
+	for (o = ovr; o && o->name; o++) {
+		bool in_std = false;
+
+		if (o->reg != reg)
+			continue;
+		if (!(v & o->mask))
+			continue;
+		for (s = std; s && s->name; s++) {
+			if (s->mask == o->mask) {
+				in_std = true;
+				break;
+			}
+		}
+		if (in_std)
+			continue;
+		printf("%s%s", first ? "" : "|", o->name);
+		first = 0;
+	}
+}
+
+/*
+ * Standard PMBus 1.3 status bit tables. Per-chip drivers may publish
+ * their own tables for vendor extended bits (e.g. NVM summary bits,
+ * DR MOS faults) but the standard layout below is the safe baseline.
+ *
+ * All tables are NULL terminated (`name = NULL` sentinel), matching
+ * the convention used elsewhere in U-Boot for driver tables.
+ */
+const struct pmbus_bit pmbus_status_word_bits[] = {
+	{ PB_STATUS_VOUT,        "VOUT" },
+	{ PB_STATUS_IOUT_POUT,   "IOUT_POUT" },
+	{ PB_STATUS_INPUT,       "INPUT" },
+	{ PB_STATUS_WORD_MFR,    "MFR" },
+	{ PB_STATUS_POWER_GOOD_N, "PG#" },
+	{ PB_STATUS_FANS,        "FANS" },
+	{ PB_STATUS_OTHER,       "OTHER" },
+	{ PB_STATUS_UNKNOWN,     "UNKNOWN" },
+	{ PB_STATUS_BUSY,        "BUSY" },
+	{ PB_STATUS_OFF,         "OFF" },
+	{ PB_STATUS_VOUT_OV,     "VOUT_OV" },
+	{ PB_STATUS_IOUT_OC,     "IOUT_OC" },
+	{ PB_STATUS_VIN_UV,      "VIN_UV" },
+	{ PB_STATUS_TEMPERATURE, "TEMP" },
+	{ PB_STATUS_CML,         "CML" },
+	{ PB_STATUS_NONE_ABOVE,  "NONE_ABOVE" },
+	{ /* sentinel */ }
+};
+
+const struct pmbus_bit pmbus_status_vout_bits[] = {
+	{ PB_VOLTAGE_OV_FAULT,         "VOUT_OV_FAULT" },
+	{ PB_VOLTAGE_OV_WARNING,       "VOUT_OV_WARN" },
+	{ PB_VOLTAGE_UV_WARNING,       "VOUT_UV_WARN" },
+	{ PB_VOLTAGE_UV_FAULT,         "VOUT_UV_FAULT" },
+	{ PB_VOLTAGE_VOUT_MAX_MIN_WARN, "VOUT_MAX_MIN_WARN" },
+	{ /* sentinel */ }
+};
+
+const struct pmbus_bit pmbus_status_iout_bits[] = {
+	{ PB_IOUT_OC_FAULT,    "IOUT_OC_FAULT" },
+	{ PB_IOUT_OC_LV_FAULT, "IOUT_OC_LV_FAULT" },
+	{ PB_IOUT_OC_WARNING,  "IOUT_OC_WARN" },
+	{ PB_IOUT_UC_FAULT,    "IOUT_UC_FAULT" },
+	{ PB_CURRENT_SHARE_FAULT, "ISHARE_FAULT" },
+	{ PB_POWER_LIMITING,   "POWER_LIMITING" },
+	{ PB_POUT_OP_FAULT,    "POUT_OP_FAULT" },
+	{ PB_POUT_OP_WARNING,  "POUT_OP_WARN" },
+	{ /* sentinel */ }
+};
+
+const struct pmbus_bit pmbus_status_input_bits[] = {
+	{ PB_IIN_OC_FAULT,     "IIN_OC_FAULT" },
+	{ PB_IIN_OC_WARNING,   "IIN_OC_WARN" },
+	{ PB_PIN_OP_WARNING,   "PIN_OP_WARN" },
+	{ /* sentinel */ }
+};
+
+const struct pmbus_bit pmbus_status_temp_bits[] = {
+	{ PB_TEMP_OT_FAULT,    "OT_FAULT" },
+	{ PB_TEMP_OT_WARNING,  "OT_WARN" },
+	{ PB_TEMP_UT_WARNING,  "UT_WARN" },
+	{ PB_TEMP_UT_FAULT,    "UT_FAULT" },
+	{ /* sentinel */ }
+};
+
+const struct pmbus_bit pmbus_status_cml_bits[] = {
+	{ PB_CML_FAULT_INVALID_COMMAND, "INVALID_CMD" },
+	{ PB_CML_FAULT_INVALID_DATA,    "INVALID_DATA" },
+	{ PB_CML_FAULT_PACKET_ERROR,    "PEC" },
+	{ PB_CML_FAULT_MEMORY,          "MEM" },
+	{ PB_CML_FAULT_PROCESSOR,       "PROC" },
+	{ PB_CML_FAULT_OTHER_COMM,      "OTHER_COMM" },
+	{ PB_CML_FAULT_OTHER_MEM_LOGIC, "OTHER_MEM_LOGIC" },
+	{ /* sentinel */ }
+};
+
+/*
+ * Active device tracking + chip / vendor registries (consumed by the
+ * `pmbus` U-Boot CLI command in cmd/pmbus.c).
+ */
+
+#define PMBUS_MAX_CHIP_MATCHES		8
+#define PMBUS_MAX_VENDOR_HANDLERS	4
+
+static struct pmbus_active_dev pmbus_active_state;
+static const struct pmbus_chip_match *pmbus_chip_table[PMBUS_MAX_CHIP_MATCHES];
+static unsigned int pmbus_chip_table_n;
+static const struct pmbus_vendor_op *pmbus_vendor_table[PMBUS_MAX_VENDOR_HANDLERS];
+static unsigned int pmbus_vendor_table_n;
+
+const struct pmbus_active_dev *pmbus_active(void)
+{
+	return pmbus_active_state.valid ? &pmbus_active_state : NULL;
+}
+
+void pmbus_clear_active(void)
+{
+	memset(&pmbus_active_state, 0, sizeof(pmbus_active_state));
+}
+
+int pmbus_active_get_i2c(struct udevice **i2c_dev)
+{
+	struct udevice *bus;
+	int ret;
+
+	if (!pmbus_active_state.valid)
+		return -ENODEV;
+	ret = uclass_get_device_by_seq(UCLASS_I2C, pmbus_active_state.bus_seq, &bus);
+	if (ret)
+		return ret;
+	return i2c_get_chip(bus, pmbus_active_state.addr, 1, i2c_dev);
+}
+
+/* engineering value in micro units -> "I.FFF<unit>" (3 fractional digits) */
+static void pmbus_emit_micro(s64 micro, const char *unit)
+{
+	s64 abs_milli = (micro < 0 ? -micro : micro) / 1000LL;
+
+	printf("%lld.%03lld%s", (long long)(micro / 1000000LL),
+	       (long long)(abs_milli % 1000LL), unit);
+}
+
+struct pmbus_telem_entry {
+	u8 reg;
+	const char *label;
+	enum pmbus_sensor_classes class;
+	const char *unit;
+};
+
+/*
+ * Telemetry register set, in print order. POUT is included so PSU
+ * class parts report input/output power; chips that do not implement
+ * a given command are skipped via pmbus_word_command_supported().
+ */
+static const struct pmbus_telem_entry pmbus_telem_table[] = {
+	{ PMBUS_READ_VIN,           "VIN ", PSC_VOLTAGE_IN,  "V" },
+	{ PMBUS_READ_VOUT,          "VOUT", PSC_VOLTAGE_OUT, "V" },
+	{ PMBUS_READ_IIN,           "IIN ", PSC_CURRENT_IN,  "A" },
+	{ PMBUS_READ_IOUT,          "IOUT", PSC_CURRENT_OUT, "A" },
+	{ PMBUS_READ_POUT,          "POUT", PSC_POWER,       "W" },
+	{ PMBUS_READ_TEMPERATURE_1, "TEMP", PSC_TEMPERATURE, "C" },
+};
+
+bool pmbus_word_command_supported(struct udevice *dev, u8 reg)
+{
+	u8 cml_before = 0, cml_after = 0;
+	bool have_cml;
+	u16 w;
+
+	have_cml = !pmbus_read_byte(dev, PMBUS_STATUS_CML, &cml_before);
+
+	if (pmbus_read_word(dev, reg, &w))
+		return false;	/* NAK: unsupported command not ACKed */
+
+	if (have_cml && !(cml_before & PB_CML_FAULT_INVALID_COMMAND) &&
+	    !pmbus_read_byte(dev, PMBUS_STATUS_CML, &cml_after) &&
+	    (cml_after & PB_CML_FAULT_INVALID_COMMAND))
+		return false;	/* ACKed but chip raised INVALID_COMMAND */
+
+	return true;
+}
+
+/* Telemetry of the currently selected page. */
+static void pmbus_print_telemetry_page(struct udevice *chip,
+				       const struct pmbus_active_dev *act)
+{
+	u8 vout_mode = 0;
+	unsigned int i;
+
+	/*
+	 * On a read failure vout_mode stays 0 (LINEAR, exponent 0). That is
+	 * a silent mis-scale of every VOLTAGE_OUT reading, so make the
+	 * fallback visible rather than printing a wrong voltage as if good.
+	 */
+	if (pmbus_read_byte(chip, PMBUS_VOUT_MODE, &vout_mode))
+		printf("  (VOUT_MODE read failed; VOUT decode assumes LINEAR exp 0)\n");
+
+	for (i = 0; i < ARRAY_SIZE(pmbus_telem_table); i++) {
+		const struct pmbus_telem_entry *e = &pmbus_telem_table[i];
+		u16 raw = 0;
+
+		/*
+		 * Class gating. A chip driver that declares classes_present
+		 * lists exactly the sensors it implements (kernel-style
+		 * per-chip sensor set), so unlisted classes are skipped
+		 * silently -- this is what hides the MPS buck's uncalibrated
+		 * POUT / IIN. A generic / undeclared device instead gets a
+		 * live capability probe per class.
+		 */
+		if (act->info && act->info->classes_present) {
+			if (!(act->info->classes_present & BIT(e->class)))
+				continue;
+		} else if (!pmbus_word_command_supported(chip, e->reg)) {
+			printf("  %s : (not supported)\n", e->label);
+			continue;
+		}
+
+		if (pmbus_read_word(chip, e->reg, &raw)) {
+			printf("  %s : (read failed)\n", e->label);
+			continue;
+		}
+
+		printf("  %s : raw=0x%04x  ", e->label, raw);
+		if (act->info) {
+			u16 dec = raw;
+
+			/*
+			 * Some DIRECT format parts (e.g. MPS) report
+			 * temperature as 1 degC/LSB in the low byte only;
+			 * mask there. LINEAR temperatures use all 16 bits
+			 * and must NOT be masked.
+			 */
+			if (e->class == PSC_TEMPERATURE &&
+			    act->info->format[PSC_TEMPERATURE] == pmbus_fmt_direct)
+				dec = raw & 0x00ff;
+
+			pmbus_emit_micro(pmbus_reg2data(act->info, e->class,
+							dec, vout_mode),
+					 e->unit);
+		} else if (e->class == PSC_VOLTAGE_OUT) {
+			pmbus_emit_micro(pmbus_reg2data_linear16(raw, vout_mode),
+					 e->unit);
+		} else {
+			pmbus_emit_micro(pmbus_reg2data_linear11(raw), e->unit);
+			printf(" (LINEAR11 fallback)");
+		}
+		printf("\n");
+	}
+}
+
+void pmbus_print_telemetry(struct udevice *chip)
+{
+	const struct pmbus_active_dev *act = pmbus_active();
+	int npages, p;
+	u8 zero = 0;
+
+	if (!act)
+		return;
+
+	/*
+	 * Multi-rail parts (PSU bricks) expose one rail per PMBUS_PAGE.
+	 * Chip drivers set pmbus_driver_info.pages; the generic driver
+	 * takes it from the DT `pmbus,num-pages` (default 1). We always
+	 * write PMBUS_PAGE before reading a page -- including page 0 --
+	 * because a device may power up selected on a different page, which
+	 * is what made the 48V PSU read all-zeros before. Only valid pages
+	 * (0..npages-1) are ever written, so we never induce the
+	 * out-of-range-PAGE STATUS_CML fault and the device's sticky fault
+	 * log is left untouched (no CLEAR_FAULTS, no scrubbing).
+	 */
+	npages = (act->info && act->info->pages > 0) ? act->info->pages : 1;
+
+	for (p = 0; p < npages; p++) {
+		u8 pg = (u8)p;
+
+		if (dm_i2c_write(chip, PMBUS_PAGE, &pg, 1)) {
+			printf("  [page %d] PAGE select failed\n", p);
+			continue;
+		}
+		if (npages > 1)
+			printf("  [page %d]\n", p);
+		pmbus_print_telemetry_page(chip, act);
+	}
+
+	if (npages > 1)
+		dm_i2c_write(chip, PMBUS_PAGE, &zero, 1);	/* leave on page 0 */
+}
+
+void pmbus_print_status_word(struct udevice *chip)
+{
+	const struct pmbus_active_dev *act = pmbus_active();
+	const struct pmbus_status_override *ovr =
+		(act && act->info) ? act->info->status_overrides : NULL;
+	u16 word = 0;
+
+	if (pmbus_read_word(chip, PMBUS_STATUS_WORD, &word)) {
+		printf("  STATUS_WORD    (79h) = (read failed)\n");
+		return;
+	}
+	printf("  STATUS_WORD    (79h) = 0x%04x  [", word);
+	pmbus_print_status_bits(PMBUS_STATUS_WORD, word,
+				pmbus_status_word_bits, ovr);
+	printf("]\n");
+}
+
+static const struct pmbus_chip_match *pmbus_match_mfr(const char *id)
+{
+	unsigned int i;
+
+	if (!id || !id[0])
+		return NULL;
+	for (i = 0; i < pmbus_chip_table_n; i++) {
+		const struct pmbus_chip_match *m = pmbus_chip_table[i];
+		size_t plen = strlen(m->mfr_id);
+
+		if (strlen(id) >= plen && !strncmp(id, m->mfr_id, plen))
+			return m;
+	}
+	return NULL;
+}
+
+/*
+ * Walk UCLASS_REGULATOR looking for a regulator whose I2C parent
+ * bus seq + DT reg address match the requested (bus_seq, addr).
+ * Returns the regulator-name (uclass plat .name) on hit, or NULL if
+ * no UCLASS_REGULATOR device matches (chip not bound through DT, or
+ * CONFIG_DM_REGULATOR disabled).
+ */
+static const char *pmbus_lookup_regname(int bus_seq, u8 addr)
+{
+	struct uclass *uc;
+	struct udevice *r;
+
+	if (!IS_ENABLED(CONFIG_DM_REGULATOR))
+		return NULL;
+
+	if (uclass_get(UCLASS_REGULATOR, &uc))
+		return NULL;
+	uclass_foreach_dev(r, uc) {
+		struct dm_regulator_uclass_plat *up;
+		struct udevice *parent = dev_get_parent(r);
+		int ra;
+
+		if (!parent || device_get_uclass_id(parent) != UCLASS_I2C)
+			continue;
+		if (dev_seq(parent) != bus_seq)
+			continue;
+		ra = dev_read_addr(r);
+		if (ra < 0 || (u8)ra != addr)
+			continue;
+		up = dev_get_uclass_plat(r);
+		if (up && up->name)
+			return up->name;
+		return r->name;
+	}
+	return NULL;
+}
+
+int pmbus_set_active(int bus_seq, u8 addr)
+{
+	const struct pmbus_chip_match *match = NULL;
+	struct udevice *bus, *chip;
+	char id_fwd[PMBUS_MFR_STRING_MAX] = "";
+	char id_rev[PMBUS_MFR_STRING_MAX] = "";
+	const char *rname;
+	int ret;
+
+	pmbus_clear_active();
+
+	ret = uclass_get_device_by_seq(UCLASS_I2C, bus_seq, &bus);
+	if (ret)
+		return ret;
+	ret = i2c_get_chip(bus, addr, 1, &chip);
+	if (ret)
+		return ret;
+
+	pmbus_active_state.bus_seq = bus_seq;
+	pmbus_active_state.addr = addr;
+
+	/*
+	 * Probe MFR_ID in both byte orders. Spec compliant chips return
+	 * "MPS" / "TI" / etc. in the natural reading (forward); MPS NVM
+	 * personalities store the string LSB first and need the reverse
+	 * read. Chip table entries declare which one is canonical for
+	 * the chip family they describe.
+	 */
+	if (pmbus_read_string(chip, PMBUS_MFR_ID, id_fwd, sizeof(id_fwd), false) < 0)
+		id_fwd[0] = '\0';
+	if (pmbus_read_string(chip, PMBUS_MFR_ID, id_rev, sizeof(id_rev), true) < 0)
+		id_rev[0] = '\0';
+
+	match = pmbus_match_mfr(id_fwd);
+	if (match && !match->mfr_id_reverse) {
+		strlcpy(pmbus_active_state.mfr_id, id_fwd,
+			sizeof(pmbus_active_state.mfr_id));
+	} else {
+		match = pmbus_match_mfr(id_rev);
+		if (match && match->mfr_id_reverse) {
+			strlcpy(pmbus_active_state.mfr_id, id_rev,
+				sizeof(pmbus_active_state.mfr_id));
+		} else {
+			/* No registered match; cache the forward read as best effort. */
+			strlcpy(pmbus_active_state.mfr_id,
+				id_fwd[0] ? id_fwd : id_rev,
+				sizeof(pmbus_active_state.mfr_id));
+		}
+	}
+
+	if (match) {
+		pmbus_active_state.info = match->info;
+		if (match->vendor)
+			strlcpy(pmbus_active_state.vendor, match->vendor,
+				sizeof(pmbus_active_state.vendor));
+	}
+
+	/*
+	 * MFR_MODEL / MFR_REVISION are best effort. Use the same byte
+	 * order the matched chip declared; if nothing matched, use the
+	 * forward order.
+	 */
+	{
+		bool reverse = match && match->mfr_id_reverse;
+
+		pmbus_read_string(chip, PMBUS_MFR_MODEL,
+				  pmbus_active_state.mfr_model,
+				  sizeof(pmbus_active_state.mfr_model), reverse);
+		pmbus_read_string(chip, PMBUS_MFR_REVISION,
+				  pmbus_active_state.mfr_revision,
+				  sizeof(pmbus_active_state.mfr_revision), reverse);
+	}
+
+	rname = pmbus_lookup_regname(bus_seq, addr);
+	if (rname)
+		strlcpy(pmbus_active_state.name, rname,
+			sizeof(pmbus_active_state.name));
+
+	pmbus_active_state.valid = true;
+	return 0;
+}
+
+int pmbus_register_chip(const struct pmbus_chip_match *match)
+{
+	if (!match || !match->mfr_id)
+		return -EINVAL;
+	if (pmbus_chip_table_n >= PMBUS_MAX_CHIP_MATCHES)
+		return -ENOSPC;
+	pmbus_chip_table[pmbus_chip_table_n++] = match;
+	return 0;
+}
+
+int pmbus_register_vendor_handler(const struct pmbus_vendor_op *op)
+{
+	if (!op || !op->vendor || !op->handler)
+		return -EINVAL;
+	if (pmbus_vendor_table_n >= PMBUS_MAX_VENDOR_HANDLERS)
+		return -ENOSPC;
+	pmbus_vendor_table[pmbus_vendor_table_n++] = op;
+	return 0;
+}
+
+const struct pmbus_vendor_op *pmbus_lookup_vendor(const char *vendor)
+{
+	unsigned int i;
+
+	if (!vendor)
+		return NULL;
+	for (i = 0; i < pmbus_vendor_table_n; i++)
+		if (!strcmp(pmbus_vendor_table[i]->vendor, vendor))
+			return pmbus_vendor_table[i];
+	return NULL;
+}
+
+unsigned int pmbus_vendor_count(void)
+{
+	return pmbus_vendor_table_n;
+}
+
+const struct pmbus_vendor_op *pmbus_vendor_at(unsigned int i)
+{
+	return i < pmbus_vendor_table_n ? pmbus_vendor_table[i] : NULL;
+}
+
+int pmbus_resolve_by_name(const char *name, int *bus_seq, u8 *addr)
+{
+	struct udevice *reg;
+	struct udevice *parent;
+	int ret;
+	int a;
+
+	if (!IS_ENABLED(CONFIG_DM_REGULATOR))
+		return -ENOSYS;
+
+	if (!name || !bus_seq || !addr)
+		return -EINVAL;
+
+	ret = regulator_get_by_platname(name, &reg);
+	if (ret)
+		return ret;
+
+	parent = dev_get_parent(reg);
+	if (!parent || device_get_uclass_id(parent) != UCLASS_I2C)
+		return -ENODEV;
+
+	a = dev_read_addr(reg);
+	if (a < 0 || a > 0x7f)
+		return -EINVAL;
+
+	*bus_seq = dev_seq(parent);
+	*addr = (u8)a;
+	return 0;
+}
-- 
2.43.0

