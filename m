Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF314C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 17:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BBE584975;
	Thu,  2 Jul 2026 19:18:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="Lsn4T/wG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EE2A84979; Thu,  2 Jul 2026 19:18:58 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC96784409
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 19:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id AEA5FB00563;
 Thu,  2 Jul 2026 19:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783012735;
 bh=HRO99CFf41szt42w+gTp7rBUu4TNPznRjY7iRuI5M3o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Lsn4T/wGldCFKOUjch/J1FFhXA5p/QaQPXNP2jFYv+P7Xnpq0lfMah2YGEkgNQ7k4
 bKu0x9wIXGu3gLFVP2Pa/hCEpSGNLJHwmGnZQe3wVeG6Fpk+idDSJrAnX+fgjkjWx0
 0XyRPKIZCk1iK9QwavZ8tY3mNbG9w+lVAsx5JxiRpo8AgoA7Caje3TX5FhGuWSJp4V
 s15XYBt3tQphp5danlBaYDsmXdv2hB/r7LXz0/TPWpzZ1YntUYeow2eoDHztgAqx3C
 68wRC3lxwmXmPYg+is7V9dHrMUY29R6gBZUxmM2WBW2XKT9XfHOAm4izMXu5Q6v/Lf
 brysjuTOfCENQ==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Vincent Jardin <vjardin@free.fr>, Alice Guo <alice.guo@nxp.com>,
 Fabio Estevam <festevam@gmail.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Peng Fan <peng.fan@nxp.com>,
 Philip Molloy <philip.molloy@analog.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@riscstar.com>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v1 4/7] board: nxp: vid: introduce PMBus framework support
Date: Thu,  2 Jul 2026 19:15:48 +0200
Message-ID: <20260702171618.1773206-5-vjardin@free.fr>
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

Wire board/nxp/common/vid.c into the <pmbus.h> framework so the legacy
NXP AVS path stops carrying its own duplicate copy of the PMBus
protocol and instead consumes the shared constants, decoders, and
transport helpers.

vid.c is the legacy NXP AVS/pre-kernel voltage-trim path for lx2160 CPUs.
It does PMBus to whichever core-rail voltage monitor the board carries:
LTC3882 or ISL68233 are selected with
CONFIG_VOL_MONITOR_LTC3882_*/CONFIG_VOL_MONITOR_ISL68233_*.

Before this change the file kept its own local PMBUS_CMD_* command-code
defines, its own inline LINEAR16 mantissa/exponent math, and called
into I2C through the I2C_READ/I2C_WRITE NXP wrappers in
board/nxp/common/i2c_common.{c,h} which is a parallel implementation of
exactly what <pmbus.h> + lib/pmbus.c provides.

The intent is to make vid.c an consumer of the new PMBus.

Compatibility with the former support:

  - CLI unchanged: vdd_override and vdd_read keep their existing
    semantics, return codes, and diagnostic output.

  - I2C transport unchanged on the wire: the framework's pmbus_*
    helpers call dm_i2c_read/dm_i2c_write: the same DM I2C
    backing that vid.c's former I2C_READ/I2C_WRITE macros already
    routed through on DM_I2C.

  - Numeric decode is bit-equivalent: pmbus_reg2data_linear16() and
    pmbus_data2reg_linear16() implement the PMBus 1.3 Part II
    mantissa/exponent.

Signed-off-by: Vincent Jardin <vjardin@free.fr>
---

 MAINTAINERS                                   |   2 +
 arch/Kconfig.nxp                              |   4 +
 board/nxp/common/vid.c                        | 104 +++++++++--------
 board/nxp/common/vid.h                        |  15 ++-
 .../regulator/lltc,ltc3882.yaml               |  91 +++++++++++++++
 .../regulator/renesas,isl68233.yaml           | 105 ++++++++++++++++++
 6 files changed, 266 insertions(+), 55 deletions(-)
 create mode 100644 doc/device-tree-bindings/regulator/lltc,ltc3882.yaml
 create mode 100644 doc/device-tree-bindings/regulator/renesas,isl68233.yaml

diff --git a/MAINTAINERS b/MAINTAINERS
index e22f1ff6641..94c342036d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1585,8 +1585,10 @@ M:	Vincent Jardin <vjardin@free.fr>
 S:	Maintained
 F:	cmd/pmbus.c
 F:	doc/develop/pmbus.rst
+F:	doc/device-tree-bindings/regulator/lltc,ltc3882.yaml
 F:	doc/device-tree-bindings/regulator/mps,mpq8785.yaml
 F:	doc/device-tree-bindings/regulator/pmbus.yaml
+F:	doc/device-tree-bindings/regulator/renesas,isl68233.yaml
 F:	drivers/power/regulator/mpq8785.c
 F:	drivers/power/regulator/pmbus_generic.c
 F:	drivers/power/regulator/pmbus_helper.c
diff --git a/arch/Kconfig.nxp b/arch/Kconfig.nxp
index ef9087d0197..152692e3230 100644
--- a/arch/Kconfig.nxp
+++ b/arch/Kconfig.nxp
@@ -242,24 +242,28 @@ config VOL_MONITOR_IR36021_SET
 
 config VOL_MONITOR_LTC3882_READ
 	bool "Enable the LTC3882 voltage monitor read"
+	select PMBUS
 	help
 	 This option enables LTC3882 voltage monitor read
 	 functionality. It is used by the common VID driver.
 
 config VOL_MONITOR_LTC3882_SET
 	bool "Enable the LTC3882 voltage monitor set"
+	select PMBUS
 	help
 	 This option enables LTC3882 voltage monitor set
 	 functionality. It is used by the common VID driver.
 
 config VOL_MONITOR_ISL68233_READ
 	bool "Enable the ISL68233 voltage monitor read"
+	select PMBUS
 	help
 	 This option enables ISL68233 voltage monitor read
 	 functionality. It is used by the common VID driver.
 
 config VOL_MONITOR_ISL68233_SET
 	bool "Enable the ISL68233 voltage monitor set"
+	select PMBUS
 	help
 	 This option enables ISL68233 voltage monitor set
 	 functionality. It is used by the common VID driver.
diff --git a/board/nxp/common/vid.c b/board/nxp/common/vid.c
index 84cb43fad56..a91d6c9381a 100644
--- a/board/nxp/common/vid.c
+++ b/board/nxp/common/vid.c
@@ -11,6 +11,7 @@
 #include <i2c.h>
 #include <irq_func.h>
 #include <log.h>
+#include <pmbus.h>
 #include <vsprintf.h>
 #include <asm/io.h>
 #ifdef CONFIG_FSL_LSCH2
@@ -260,45 +261,38 @@ static int read_voltage_from_IR(int i2caddress)
  */
 #define VOUT_WARNING "VID: VOUT_MODE exponent has resolution worse than 1 V!\n"
 
-/* Checks the PMBus voltage monitor for the format used for voltage values */
-static int get_pmbus_multiplier(DEVICE_HANDLE_T dev)
+/*
+ * Read VOUT_MODE for downstream LINEAR16 decode/encode through the
+ * tree level <pmbus.h> helpers (pmbus_reg2data_linear16,
+ * pmbus_data2reg_linear16). Returns the raw VOUT_MODE byte on
+ * success, or 0 on bus error. Emits VOUT_WARNING on Linear mode
+ * chips with a non negative exponent (resolution >= 1 V is unusable
+ * for sub volt SoC rails) and an informational note on the
+ * unsupported VID format.
+ */
+static u8 vid_read_vout_mode(DEVICE_HANDLE_T dev)
 {
-	u8 mode;
-	int exponent, multiplier, ret;
+	u8 mode = 0;
+	int ret;
 
-	ret = I2C_READ(dev, PMBUS_CMD_VOUT_MODE, &mode, sizeof(mode));
+	ret = pmbus_read_byte(dev, PMBUS_VOUT_MODE, &mode);
 	if (ret) {
 		printf("VID: unable to determine voltage multiplier\n");
-		return 1;
+		return 0;
 	}
 
-	/* Upper 3 bits is mode, lower 5 bits is exponent */
-	exponent = (int)mode & 0x1F;
-	mode >>= 5;
-	switch (mode) {
-	case 0:
-		/* Linear, 5 bit twos component exponent */
-		if (exponent & 0x10) {
-			multiplier = 1 << (16 - (exponent & 0xF));
-		} else {
-			/* If exponent is >= 0, then resolution is 1 V! */
+	switch (mode & PB_VOUT_MODE_MODE_MASK) {
+	case PB_VOUT_MODE_LINEAR:
+		if (!(mode & 0x10))
 			printf(VOUT_WARNING);
-			multiplier = 1;
-		}
 		break;
-	case 1:
-		/* VID code identifier */
+	case PB_VOUT_MODE_VID:
 		printf("VID: custom VID codes are not supported\n");
-		multiplier = MV_PER_V;
 		break;
 	default:
-		/* Direct, in mV */
-		multiplier = MV_PER_V;
 		break;
 	}
-
-	debug("VID: calculated multiplier is %d\n", multiplier);
-	return multiplier;
+	return mode;
 }
 #endif
 
@@ -306,8 +300,8 @@ static int get_pmbus_multiplier(DEVICE_HANDLE_T dev)
 	defined(CONFIG_VOL_MONITOR_LTC3882_READ)
 static int read_voltage_from_pmbus(int i2caddress)
 {
-	int ret, multiplier, vout;
-	u8 channel = PWM_CHANNEL0;
+	int ret, vout;
+	u8 channel = PWM_CHANNEL0, vout_mode;
 	u16 vcode;
 	DEVICE_HANDLE_T dev;
 
@@ -317,25 +311,31 @@ static int read_voltage_from_pmbus(int i2caddress)
 		return ret;
 
 	/* Select the right page */
-	ret = I2C_WRITE(dev, PMBUS_CMD_PAGE, &channel, sizeof(channel));
+	ret = pmbus_write_byte(dev, PMBUS_PAGE, channel);
 	if (ret) {
 		printf("VID: failed to select VDD page %d\n", channel);
 		return ret;
 	}
 
-	/* VOUT is little endian */
-	ret = I2C_READ(dev, PMBUS_CMD_READ_VOUT, (void *)&vcode, sizeof(vcode));
+	ret = pmbus_read_word(dev, PMBUS_READ_VOUT, &vcode);
 	if (ret) {
 		printf("VID: failed to read core voltage\n");
 		return ret;
 	}
 
-	/* Scale down to the real mV */
-	multiplier = get_pmbus_multiplier(dev);
-	vout = (int)vcode;
-	/* Multiplier 1000 (direct mode) requires no change to convert */
-	if (multiplier != MV_PER_V)
-		vout = DIV_ROUND_UP(vout * MV_PER_V, multiplier);
+	/*
+	 * Decode LINEAR16 via the tree level helper from <pmbus.h>. For
+	 * non Linear VOUT_MODE settings the helper returns 0; fall back
+	 * to the historic mV pass through so existing LSCH boards keep.
+	 */
+	vout_mode = vid_read_vout_mode(dev);
+	if ((vout_mode & PB_VOUT_MODE_MODE_MASK) == PB_VOUT_MODE_LINEAR) {
+		s64 uv = pmbus_reg2data_linear16(vcode, vout_mode);
+
+		vout = (int)((uv + 500) / 1000);	/* round to mV */
+	} else {
+		vout = (int)vcode;
+	}
 	return vout - board_vdd_drop_compensation();
 }
 #endif
@@ -463,11 +463,13 @@ static int set_voltage_to_IR(int i2caddress, int vdd)
 static int set_voltage_to_pmbus(int i2caddress, int vdd)
 {
 	int ret, vdd_last, vdd_target = vdd;
-	int count = MAX_LOOP_WAIT_NEW_VOL, temp = 0, multiplier;
+	int count = MAX_LOOP_WAIT_NEW_VOL, temp = 0;
+	u8 vout_mode;
+	u16 raw;
 	unsigned char value;
 
 	/* The data to be sent with the PMBus command PAGE_PLUS_WRITE */
-	u8 buffer[5] = { 0x04, PWM_CHANNEL0, PMBUS_CMD_VOUT_COMMAND, 0, 0 };
+	u8 buffer[5] = { 0x04, PWM_CHANNEL0, PMBUS_VOUT_COMMAND, 0, 0 };
 	DEVICE_HANDLE_T dev;
 
 	/* Open device handle */
@@ -475,24 +477,28 @@ static int set_voltage_to_pmbus(int i2caddress, int vdd)
 	if (ret)
 		return ret;
 
-	/* Scale up to the proper value for the VOUT command, little endian */
-	multiplier = get_pmbus_multiplier(dev);
+	/*
+	 * Encode target mV as LINEAR16 raw via the tree level helper
+	 * from <pmbus.h>. For non Linear VOUT_MODE settings the helper
+	 * returns 0; fall back to the historic mV pass through.
+	 */
 	vdd += board_vdd_drop_compensation();
-	if (multiplier != MV_PER_V)
-		vdd = DIV_ROUND_UP(vdd * multiplier, MV_PER_V);
-	buffer[3] = vdd & 0xFF;
-	buffer[4] = (vdd & 0xFF00) >> 8;
+	vout_mode = vid_read_vout_mode(dev);
+	if ((vout_mode & PB_VOUT_MODE_MODE_MASK) == PB_VOUT_MODE_LINEAR)
+		raw = pmbus_data2reg_linear16((s64)vdd * 1000LL, vout_mode);
+	else
+		raw = (u16)vdd;
+	buffer[3] = raw & 0xFF;
+	buffer[4] = (raw & 0xFF00) >> 8;
 
 	/* Check write protect state */
-	ret = I2C_READ(dev, PMBUS_CMD_WRITE_PROTECT, (void *)&value,
-		       sizeof(value));
+	ret = pmbus_read_byte(dev, PMBUS_WRITE_PROTECT, &value);
 	if (ret)
 		goto exit;
 
 	if (value != EN_WRITE_ALL_CMD) {
 		value = EN_WRITE_ALL_CMD;
-		ret = I2C_WRITE(dev, PMBUS_CMD_WRITE_PROTECT,
-				(void *)&value, sizeof(value));
+		ret = pmbus_write_byte(dev, PMBUS_WRITE_PROTECT, value);
 		if (ret)
 			goto exit;
 	}
diff --git a/board/nxp/common/vid.h b/board/nxp/common/vid.h
index b34c080b4ba..72c1c089aa1 100644
--- a/board/nxp/common/vid.h
+++ b/board/nxp/common/vid.h
@@ -22,8 +22,9 @@
 #define IR_VDD_STEP_UP			5
 
 /* LTC3882 */
-#define PMBUS_CMD_WRITE_PROTECT         0x10
 /*
+ * PMBUS_WRITE_PROTECT (10h) provided by <pmbus.h>
+ *
  * WRITE_PROTECT command supported values
  * 0x80: Disable all writes except WRITE_PROTECT, PAGE,
  *       STORE_USER_ALL and MFR_EE_UNLOCK commands.
@@ -51,12 +52,14 @@
 #define VDD_MV_MAX			925
 #endif
 
-/* PM Bus commands code for LTC3882*/
+/*
+ * PM Bus commands code for LTC3882. PMBUS_PAGE / PMBUS_READ_VOUT /
+ * PMBUS_VOUT_MODE / PMBUS_VOUT_COMMAND are provided by <pmbus.h>.
+ * PMBUS_CMD_PAGE_PLUS_WRITE (05h) is the LTC3882 SMBus block write
+ * transaction not in <pmbus.h>'s standard subset, so keep its
+ * definition here.
+ */
 #define PWM_CHANNEL0                    0x0
-#define PMBUS_CMD_PAGE                  0x0
-#define PMBUS_CMD_READ_VOUT             0x8B
-#define PMBUS_CMD_VOUT_MODE			0x20
-#define PMBUS_CMD_VOUT_COMMAND          0x21
 #define PMBUS_CMD_PAGE_PLUS_WRITE       0x05
 
 #if defined(CONFIG_TARGET_LX2160AQDS) || defined(CONFIG_TARGET_LX2162AQDS) || \
diff --git a/doc/device-tree-bindings/regulator/lltc,ltc3882.yaml b/doc/device-tree-bindings/regulator/lltc,ltc3882.yaml
new file mode 100644
index 00000000000..7ed49d04a87
--- /dev/null
+++ b/doc/device-tree-bindings/regulator/lltc,ltc3882.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/lltc,ltc3882.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linear Technology LTC3882 dual output PMBus DC/DC controller (U-Boot subset)
+
+maintainers:
+  - Vincent Jardin <vjardin@free.fr>
+
+description: |
+  Dual output PolyPhase synchronous step down DC/DC controller with
+  digital power system management over PMBus.
+
+  This U-Boot subset mirrors the upstream Linux kernel binding at
+  linux/Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml
+  (which covers the whole Linear / ADI pmbus family including the
+  LTC3882). Compatible strings, property names, and semantics are
+  identical so the same .dts file works under both U-Boot (BL33) and
+  Linux post handoff. Properties that only drive the kernel hwmon
+  publication are accepted and ignored by the U-Boot driver.
+
+  VOUT is reported in PMBus LINEAR16 format with the exponent
+  supplied by VOUT_MODE bits[4:0]. VIN, IIN, IOUT, and TEMPERATURE
+  use LINEAR11 (signed 5 bit exponent, signed 11 bit mantissa).
+
+  On NXP Layerscape boards (LX2160A class), the legacy AVS code in
+  board/nxp/common/vid.c speaks PMBus to the LTC3882 to read VOUT
+  and to write VOUT_COMMAND for pre kernel core voltage trim. That
+  path uses the legacy non DM I2C transport (fsl_i2c) and so does
+  not bind through this DT node today; the binding is published for
+  schema validation, for future U-Boot driver model migration, and
+  for matching the upstream Linux .dts.
+
+properties:
+  compatible:
+    enum:
+      - lltc,ltc3882
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    description: |
+      Container for the two output rails the LTC3882 exposes
+      (vout0 and vout1). Each child node is a regulator described
+      by the standard regulator binding; child names indicate which
+      PMBus PAGE the rail maps to (vout0 = page 0, vout1 = page 1).
+
+    patternProperties:
+      "^vout[01]$":
+        $ref: /schemas/regulator/regulator.yaml#
+        type: object
+        unevaluatedProperties: false
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@5e {
+            compatible = "lltc,ltc3882";
+            reg = <0x5e>;
+
+            regulators {
+                vout0 {
+                    regulator-name = "VDD_CORE";
+                    regulator-min-microvolt = < 775000>;
+                    regulator-max-microvolt = < 925000>;
+                    regulator-boot-on;
+                };
+                vout1 {
+                    regulator-name = "VDD_PLAT";
+                    regulator-min-microvolt = < 850000>;
+                    regulator-max-microvolt = <1000000>;
+                };
+            };
+        };
+    };
+...
diff --git a/doc/device-tree-bindings/regulator/renesas,isl68233.yaml b/doc/device-tree-bindings/regulator/renesas,isl68233.yaml
new file mode 100644
index 00000000000..41f18381942
--- /dev/null
+++ b/doc/device-tree-bindings/regulator/renesas,isl68233.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/renesas,isl68233.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas ISL68233 digital multiphase voltage regulator with PMBus (U-Boot subset)
+
+maintainers:
+  - Vincent Jardin <vjardin@free.fr>
+
+description: |
+  Renesas (formerly Intersil) digital multiphase voltage regulator
+  with PMBus.
+
+  This U-Boot subset mirrors the upstream Linux kernel binding at
+  linux/Documentation/devicetree/bindings/hwmon/pmbus/isil,isl68137.yaml,
+  which covers the whole Intersil / Renesas ISL family including the
+  ISL68233. Compatible strings, property names, and semantics are
+  identical so the same .dts file works under both U-Boot (BL33) and
+  Linux post handoff. Properties that only drive the kernel hwmon
+  publication are accepted and ignored by the U-Boot driver.
+
+  VOUT is reported in PMBus LINEAR16 format with the exponent
+  supplied by VOUT_MODE bits[4:0]. VIN, IIN, IOUT, and TEMPERATURE
+  use LINEAR11 (signed 5 bit exponent, signed 11 bit mantissa). The
+  ISL68233 exposes multiple output rails through PMBus PAGE
+  switching; per channel sub nodes follow the upstream pattern.
+
+  On NXP Layerscape boards, the legacy AVS code in
+  board/nxp/common/vid.c speaks PMBus to the ISL68233 to read VOUT
+  and to write VOUT_COMMAND for pre kernel core voltage trim. That
+  path uses the legacy non DM I2C transport (fsl_i2c) and so does
+  not bind through this DT node today; the binding is published for
+  schema validation, for future U-Boot driver model migration, and
+  for matching the upstream Linux .dts.
+
+properties:
+  compatible:
+    enum:
+      - renesas,isl68233
+
+  reg:
+    maxItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+patternProperties:
+  "^channel@([0-3])$":
+    type: object
+    description:
+      Container for properties specific to a particular channel (rail).
+
+    properties:
+      reg:
+        description: The channel (rail) index.
+        items:
+          minimum: 0
+          maximum: 3
+
+      vout-voltage-divider:
+        description: |
+          Resistances of a voltage divider placed between Vout and
+          the voltage sense (Vsense) pin for the given channel. Two
+          numbers <Rout Rtotal> which yields an adjusted Vout as
+          Vout_adj = Vout * Rtotal / Rout, given the original Vout
+          as reported by the Vsense pin.
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        minItems: 2
+        maxItems: 2
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        regulator@60 {
+            compatible = "renesas,isl68233";
+            reg = <0x60>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            channel@0 {
+                reg = <0>;
+                vout-voltage-divider = <1000 2000>;
+            };
+        };
+    };
+...
-- 
2.43.0

