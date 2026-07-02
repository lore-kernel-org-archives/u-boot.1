Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9DEC43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:19:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AE8584975;
	Thu,  2 Jul 2026 19:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="g0Znnw9b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6FFA78497A; Thu,  2 Jul 2026 19:19:48 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 521A984409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 19:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 5847BB0053E;
 Thu,  2 Jul 2026 19:19:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783012786;
 bh=SluVySn7hyA9pNnmYYGzty0mFXYnXwG99Ga99G9fgrU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=g0Znnw9bpsO5o77nwFXwMvqet3+2pmwQsZJKzUO/dA1SKh+hSrAU4JK2iy7AkAVC8
 mR2uED24u6r+IP6+oJrlnCnLLPfHKtrl3FZKM6Jx0ZDd7yXzDIPJ05JeZBkUQfhsVi
 r+i9PBEjmPwiQwlCUORZFyxtFQClIFmrHETvtVW0ndDFynX0m2nHgPRRMFWCK9NszU
 c7TPadioJ777262OyqeI5sJMhQV4xlHhfvQQYMSQPWCb0iY7nPS9XrytCENUUDGbUw
 qLxwhoEszxohZEu/2Wz6FgcvkwZNZ+K+fmS6WrB/AV3Zy3MQkO/l0UL46hQ22X7ZrX
 ezm1E1P03Is3Q==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Anshul Dalal <anshuld@ti.com>,
 Bo-Chen Chen <rex-bc.chen@mediatek.com>,
 David Lechner <dlechner@baylibre.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Julien Masson <jmasson@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@riscstar.com>,
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 6/7] test: dm: pmbus: add a sandbox PMBus chip emulator
Date: Thu,  2 Jul 2026 19:15:50 +0200
Message-ID: <20260702171618.1773206-7-vjardin@free.fr>
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

Add a UCLASS_I2C_EMUL driver that emulates a PMBus 1.x compliant chip
behind the sandbox I2C bus, plus the test.dts wiring and sandbox
defconfig that bind it to the generic PMBus regulator
(compatible = "pmbus"). This design is a stub only: it lets the
follow-up dm unit test drive lib/pmbus.c, the generic regulator and
the pmbus CLI command with no real hardware.

The emulator models a flat per-command 16-bit register file and the
three identification block strings (MFR_ID / MFR_MODEL /
MFR_REVISION). READ_IIN and READ_POUT are deliberately left
unimplemented (the chip NAKs them) so the telemetry printer's
"(not supported)" path is exercised, mirroring a real buck that only
calibrates a subset of the sensor classes.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 MAINTAINERS                             |   1 +
 arch/sandbox/dts/test.dts               |  10 ++
 configs/sandbox_defconfig               |   6 +
 drivers/power/regulator/Kconfig         |  10 ++
 drivers/power/regulator/Makefile        |   1 +
 drivers/power/regulator/sandbox_pmbus.c | 160 ++++++++++++++++++++++++
 6 files changed, 188 insertions(+)
 create mode 100644 drivers/power/regulator/sandbox_pmbus.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 258c0d9bc18..bdfb660a743 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1593,6 +1593,7 @@ F:	drivers/power/regulator/mpq8785.c
 F:	drivers/power/regulator/pmbus_generic.c
 F:	drivers/power/regulator/pmbus_helper.c
 F:	drivers/power/regulator/pmbus_helper.h
+F:	drivers/power/regulator/sandbox_pmbus.c
 F:	drivers/thermal/pmbus_thermal.c
 F:	include/pmbus.h
 F:	lib/pmbus.c
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 0887de4333b..5032eecceea 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1027,6 +1027,9 @@
 			emul1: emull {
 				compatible = "sandbox,i2c-rtc-emul";
 			};
+			emul_pmbus: emul-pmbus {
+				compatible = "sandbox,i2c-pmbus";
+			};
 		};
 
 		sandbox_pmic: sandbox_pmic@40 {
@@ -1038,6 +1041,13 @@
 			reg = <0x41>;
 			sandbox,emul = <&emul_pmic1>;
 		};
+
+		pmbus@70 {
+			reg = <0x70>;
+			compatible = "pmbus";
+			regulator-name = "sandbox-pmbus-vout";
+			sandbox,emul = <&emul_pmbus>;
+		};
 	};
 
 	i3c0 {
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index ba800f7d19d..de90a2b39e5 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -392,3 +392,9 @@ CONFIG_UTHREAD=y
 CONFIG_UNIT_TEST=y
 CONFIG_UT_TIME=y
 CONFIG_UT_DM=y
+CONFIG_PMBUS=y
+CONFIG_CMD_PMBUS=y
+CONFIG_DM_REGULATOR_PMBUS_HELPER=y
+CONFIG_DM_REGULATOR_PMBUS_GENERIC=y
+CONFIG_SANDBOX_PMBUS=y
+CONFIG_PMBUS_THERMAL=y
diff --git a/drivers/power/regulator/Kconfig b/drivers/power/regulator/Kconfig
index 67c9e1fb377..143911eeb17 100644
--- a/drivers/power/regulator/Kconfig
+++ b/drivers/power/regulator/Kconfig
@@ -590,3 +590,13 @@ config DM_REGULATOR_MPQ8785
 	  digital multiphase voltage regulators with PMBus. Supports
 	  MPM3695, MPM3695-25, MPM82504, and MPQ8785. Adapted from the
 	  Linux drivers/hwmon/pmbus/mpq8785.c reference.
+
+config SANDBOX_PMBUS
+	bool "Sandbox PMBus 1.x chip emulator"
+	depends on SANDBOX && PMBUS && DM_I2C
+	help
+	  Emulate a PMBus 1.x compliant chip behind a sandbox I2C bus so
+	  the PMBus framework (lib/pmbus.c), the generic regulator
+	  (DM_REGULATOR_PMBUS_GENERIC) and the pmbus CLI command can be
+	  exercised by the dm unit tests with no real hardware. Only
+	  useful for testing; say N on real boards.
diff --git a/drivers/power/regulator/Makefile b/drivers/power/regulator/Makefile
index aa3faf2f34f..b8599ea7fd9 100644
--- a/drivers/power/regulator/Makefile
+++ b/drivers/power/regulator/Makefile
@@ -52,3 +52,4 @@ obj-$(CONFIG_DM_REGULATOR_MT6359) += mt6359_regulator.o
 obj-$(CONFIG_DM_REGULATOR_PMBUS_HELPER)  += pmbus_helper.o
 obj-$(CONFIG_DM_REGULATOR_PMBUS_GENERIC) += pmbus_generic.o
 obj-$(CONFIG_DM_REGULATOR_MPQ8785)       += mpq8785.o
+obj-$(CONFIG_SANDBOX_PMBUS)              += sandbox_pmbus.o
diff --git a/drivers/power/regulator/sandbox_pmbus.c b/drivers/power/regulator/sandbox_pmbus.c
new file mode 100644
index 00000000000..2900d0a6d83
--- /dev/null
+++ b/drivers/power/regulator/sandbox_pmbus.c
@@ -0,0 +1,160 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 Free Mobile - Vincent Jardin
+ *
+ * Sandbox PMBus 1.x chip stub (UCLASS_I2C_EMUL).
+ *
+ * Stub a DT i2c node so the PMBus framework, the generic pmbus
+ * regulator and the pmbus CLI command can be tested.
+ * The model is a flat per-command 16 bit
+ * register file combined with some fixed identification strings.
+ */
+
+#include <dm.h>
+#include <i2c.h>
+#include <pmbus.h>
+#include <linux/ctype.h>
+
+#define PMBUS_EMUL_NREG		256
+
+struct sandbox_pmbus_priv {
+	u16 reg[PMBUS_EMUL_NREG];
+	bool supported[PMBUS_EMUL_NREG];
+};
+
+/* Identification strings reported in the natural (forward) byte order. */
+static const char *pmbus_emul_string(u8 cmd)
+{
+	switch (cmd) {
+	case PMBUS_MFR_ID:
+		return "SANDBOX";
+	case PMBUS_MFR_MODEL:
+		return "PMBUS-EMUL";
+	case PMBUS_MFR_REVISION:
+		return "1.0";
+	default:
+		return NULL;
+	}
+}
+
+static int sandbox_pmbus_read(struct sandbox_pmbus_priv *priv, u8 cmd,
+			      u8 *buf, int len)
+{
+	const char *str = pmbus_emul_string(cmd);
+	int i;
+
+	if (str) {
+		int slen = strlen(str);
+
+		/* Block payload: [length][bytes...]. */
+		buf[0] = (u8)slen;
+		for (i = 1; i < len; i++)
+			buf[i] = (i - 1 < slen) ? (u8)str[i - 1] : 0;
+		return 0;
+	}
+
+	if (!priv->supported[cmd])
+		return -EREMOTEIO; /* chip NAKs an unimplemented command */
+
+	for (i = 0; i < len; i++)
+		buf[i] = (u8)(priv->reg[cmd] >> (8 * i));
+	return 0;
+}
+
+static int sandbox_pmbus_write(struct sandbox_pmbus_priv *priv, u8 cmd,
+			       const u8 *buf, int len)
+{
+	if (len == 0)
+		return 0; /* send-byte (eg CLEAR_FAULTS): just ACK */
+	if (!priv->supported[cmd])
+		return -EREMOTEIO;
+	if (len == 1)
+		priv->reg[cmd] = buf[0];
+	else
+		priv->reg[cmd] = (u16)buf[0] | ((u16)buf[1] << 8);
+	return 0;
+}
+
+static int sandbox_pmbus_xfer(struct udevice *emul, struct i2c_msg *msg,
+			      int nmsgs)
+{
+	struct sandbox_pmbus_priv *priv = dev_get_priv(emul);
+	u8 cmd;
+
+	if (nmsgs == 0)
+		return 0;
+	/* A PMBus transaction always opens with the command-code write. */
+	if (msg[0].flags & I2C_M_RD)
+		return -EIO;
+	if (msg[0].len == 0)
+		return 0; /* address-only probe */
+	cmd = msg[0].buf[0];
+
+	if (nmsgs >= 2 && (msg[1].flags & I2C_M_RD))
+		return sandbox_pmbus_read(priv, cmd, msg[1].buf, msg[1].len);
+
+	return sandbox_pmbus_write(priv, cmd, msg[0].buf + 1, msg[0].len - 1);
+}
+
+static void sandbox_pmbus_support(struct sandbox_pmbus_priv *priv, u8 cmd,
+				  u16 val)
+{
+	priv->supported[cmd] = true;
+	priv->reg[cmd] = val;
+}
+
+static int sandbox_pmbus_probe(struct udevice *emul)
+{
+	struct sandbox_pmbus_priv *priv = dev_get_priv(emul);
+
+	/* Configuration / identification. */
+	sandbox_pmbus_support(priv, PMBUS_PAGE, 0);
+	sandbox_pmbus_support(priv, PMBUS_OPERATION, PB_OPERATION_ON);
+	sandbox_pmbus_support(priv, PMBUS_ON_OFF_CONFIG, 0);
+	sandbox_pmbus_support(priv, PMBUS_WRITE_PROTECT, 0);
+	sandbox_pmbus_support(priv, PMBUS_CAPABILITY, 0xb0);
+	sandbox_pmbus_support(priv, PMBUS_VOUT_MODE, 0x18); /* LINEAR 2^-8 */
+	sandbox_pmbus_support(priv, PMBUS_VOUT_COMMAND, 0x0200);
+	sandbox_pmbus_support(priv, PMBUS_VOUT_TRIM, 0);
+	sandbox_pmbus_support(priv, PMBUS_VOUT_MAX, 0x0400);
+	sandbox_pmbus_support(priv, PMBUS_VOUT_SCALE_LOOP, 0);
+	sandbox_pmbus_support(priv, PMBUS_REVISION, PMBUS_REV_13);
+
+	/* Status registers, all clean. */
+	sandbox_pmbus_support(priv, PMBUS_STATUS_BYTE, 0);
+	sandbox_pmbus_support(priv, PMBUS_STATUS_WORD, 0);
+	sandbox_pmbus_support(priv, PMBUS_STATUS_VOUT, 0);
+	sandbox_pmbus_support(priv, PMBUS_STATUS_IOUT, 0);
+	sandbox_pmbus_support(priv, PMBUS_STATUS_INPUT, 0);
+	sandbox_pmbus_support(priv, PMBUS_STATUS_TEMPERATURE, 0);
+	sandbox_pmbus_support(priv, PMBUS_STATUS_CML, 0);
+
+	/*
+	 * Telemetry the emulated chip implements. READ_IIN and READ_POUT
+	 * are intentionally absent so callers see the unsupported path.
+	 */
+	sandbox_pmbus_support(priv, PMBUS_READ_VIN, 0x0abc);
+	sandbox_pmbus_support(priv, PMBUS_READ_VOUT, 0x0200);
+	sandbox_pmbus_support(priv, PMBUS_READ_IOUT, 0x0123);
+	sandbox_pmbus_support(priv, PMBUS_READ_TEMPERATURE_1, 0x0019);
+
+	return 0;
+}
+
+static struct dm_i2c_ops sandbox_pmbus_emul_ops = {
+	.xfer = sandbox_pmbus_xfer,
+};
+
+static const struct udevice_id sandbox_pmbus_ids[] = {
+	{ .compatible = "sandbox,i2c-pmbus" },
+	{ }
+};
+
+U_BOOT_DRIVER(sandbox_pmbus_emul) = {
+	.name		= "sandbox_pmbus_emul",
+	.id		= UCLASS_I2C_EMUL,
+	.of_match	= sandbox_pmbus_ids,
+	.probe		= sandbox_pmbus_probe,
+	.priv_auto	= sizeof(struct sandbox_pmbus_priv),
+	.ops		= &sandbox_pmbus_emul_ops,
+};
-- 
2.43.0

