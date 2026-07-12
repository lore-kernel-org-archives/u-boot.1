Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18125C44501
	for <u-boot@archiver.kernel.org>; Sun, 12 Jul 2026 18:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A85B18490A;
	Sun, 12 Jul 2026 20:25:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="hRTFa1SY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC52F84A3C; Sun, 12 Jul 2026 20:25:42 +0200 (CEST)
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ACC1084852
 for <u-boot@lists.denx.de>; Sun, 12 Jul 2026 20:25:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=vjardin@free.fr
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id B7D7AB0054C;
 Sun, 12 Jul 2026 20:25:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783880740;
 bh=OZGFLDtH+tsGh/ZgiaAWNoPtlxA6ozOADbRYrAYAPeY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hRTFa1SYb1QZHJJp8e9ZQNlpYN4i3Ux9zfyno6Eaj0LLaVvooF8wdhWshuB/zFqJn
 l+HxbeJYuQRu68JspTCjUz62TP/VAfklka6gkavswDdWR+UfHD4aUoK0a766p1kLz3
 oToBnt8cZiJmUMV1osvyHqT/agN1G23sKdL1s+CQkeZHQET2+WBKDuNbWRpviSIz43
 Pv8QeIlHapnFZc8b8i8RKiwGnvctcCUHG40Klq9Rue2+ooGO65EWMm5ePRyDuN69hZ
 t0ZkRa5OphWZFq+f2uArknkbnIaRyc/cGlTMYC/M41QIhh9/qgAaEVyt43Pu1GoLPg
 Uu1iS+tz03E+g==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Vincent Jardin <vjardin@free.fr>, Alice Guo <alice.guo@nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Subject: [PATCH v5 4/7] board: nxp: vid: introduce PMBus framework support
Date: Sun, 12 Jul 2026 20:20:46 +0200
Message-ID: <20260712182054.2914942-5-vjardin@free.fr>
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

Changes in v5:
- board/nxp/ls1088a/ls1088a.c: convert to <pmbus.h>
  (Peng Fan)

Changes in v3:
- vid_read_vout_mode(): avoid confusions error vs mode.

 arch/Kconfig.nxp            |   4 ++
 board/nxp/common/vid.c      | 110 ++++++++++++++++++++----------------
 board/nxp/common/vid.h      |  15 +++--
 board/nxp/ls1088a/ls1088a.c |  11 ++--
 4 files changed, 80 insertions(+), 60 deletions(-)

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
index 84cb43fad56..70c3b3ecfd8 100644
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
+ * pmbus_data2reg_linear16). Stores the raw VOUT_MODE byte in *mode
+ * and returns 0 on success, or the negative bus error (a failed read
+ * must not be decoded: raw 0 aliases Linear mode with exponent 0).
+ * Emits VOUT_WARNING on Linear mode chips with a non negative
+ * exponent (resolution >= 1 V is unusable for sub volt SoC rails)
+ * and an informational note on the unsupported VID format.
+ */
+static int vid_read_vout_mode(DEVICE_HANDLE_T dev, u8 *mode)
 {
-	u8 mode;
-	int exponent, multiplier, ret;
+	int ret;
 
-	ret = I2C_READ(dev, PMBUS_CMD_VOUT_MODE, &mode, sizeof(mode));
+	ret = pmbus_read_byte(dev, PMBUS_VOUT_MODE, mode);
 	if (ret) {
 		printf("VID: unable to determine voltage multiplier\n");
-		return 1;
+		return ret;
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
+	switch (*mode & PB_VOUT_MODE_MODE_MASK) {
+	case PB_VOUT_MODE_LINEAR:
+		if (!(*mode & 0x10))
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
+	return 0;
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
 
@@ -317,25 +311,33 @@ static int read_voltage_from_pmbus(int i2caddress)
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
+	ret = vid_read_vout_mode(dev, &vout_mode);
+	if (ret)
+		return ret;
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
@@ -463,11 +465,13 @@ static int set_voltage_to_IR(int i2caddress, int vdd)
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
@@ -475,24 +479,32 @@ static int set_voltage_to_pmbus(int i2caddress, int vdd)
 	if (ret)
 		return ret;
 
-	/* Scale up to the proper value for the VOUT command, little endian */
-	multiplier = get_pmbus_multiplier(dev);
+	/*
+	 * Encode target mV as LINEAR16 raw via the tree level helper
+	 * from <pmbus.h>. For non Linear VOUT_MODE settings the helper
+	 * returns 0; fall back to the historic mV pass through. A failed
+	 * VOUT_MODE read aborts: never write a voltage code whose
+	 * encoding could not be determined.
+	 */
 	vdd += board_vdd_drop_compensation();
-	if (multiplier != MV_PER_V)
-		vdd = DIV_ROUND_UP(vdd * multiplier, MV_PER_V);
-	buffer[3] = vdd & 0xFF;
-	buffer[4] = (vdd & 0xFF00) >> 8;
+	ret = vid_read_vout_mode(dev, &vout_mode);
+	if (ret)
+		return ret;
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
diff --git a/board/nxp/ls1088a/ls1088a.c b/board/nxp/ls1088a/ls1088a.c
index 5783dd8a403..c395289d2c8 100644
--- a/board/nxp/ls1088a/ls1088a.c
+++ b/board/nxp/ls1088a/ls1088a.c
@@ -7,6 +7,7 @@
 #include <display_options.h>
 #include <env.h>
 #include <i2c.h>
+#include <pmbus.h>
 #include <init.h>
 #include <log.h>
 #include <malloc.h>
@@ -667,13 +668,13 @@ int get_serdes_volt(void)
 	/* Select the PAGE 0 using PMBus commands PAGE for VDD */
 #if !CONFIG_IS_ENABLED(DM_I2C)
 	ret = i2c_write(I2C_SVDD_MONITOR_ADDR,
-			PMBUS_CMD_PAGE, 1, &chan, 1);
+			PMBUS_PAGE, 1, &chan, 1);
 #else
 	struct udevice *dev;
 
 	ret = i2c_get_chip_for_busnum(0, I2C_SVDD_MONITOR_ADDR, 1, &dev);
 	if (!ret)
-		ret = dm_i2c_write(dev, PMBUS_CMD_PAGE,
+		ret = dm_i2c_write(dev, PMBUS_PAGE,
 				   &chan, 1);
 #endif
 
@@ -685,9 +686,9 @@ int get_serdes_volt(void)
 	/* Read the output voltage using PMBus command READ_VOUT */
 #if !CONFIG_IS_ENABLED(DM_I2C)
 	ret = i2c_read(I2C_SVDD_MONITOR_ADDR,
-		       PMBUS_CMD_READ_VOUT, 1, (void *)&vcode, 2);
+		       PMBUS_READ_VOUT, 1, (void *)&vcode, 2);
 #else
-	dm_i2c_read(dev, PMBUS_CMD_READ_VOUT, (void *)&vcode, 2);
+	dm_i2c_read(dev, PMBUS_READ_VOUT, (void *)&vcode, 2);
 #endif
 	if (ret) {
 		printf("VID: failed to read the voltage\n");
@@ -700,7 +701,7 @@ int get_serdes_volt(void)
 int set_serdes_volt(int svdd)
 {
 	int ret, vdd_last;
-	u8 buff[5] = {0x04, PWM_CHANNEL0, PMBUS_CMD_VOUT_COMMAND,
+	u8 buff[5] = {0x04, PWM_CHANNEL0, PMBUS_VOUT_COMMAND,
 			svdd & 0xFF, (svdd & 0xFF00) >> 8};
 
 	/* Write the desired voltage code to the SVDD regulator */
-- 
2.43.0

