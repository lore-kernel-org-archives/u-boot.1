Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFA5C43458
	for <u-boot@archiver.kernel.org>; Sun, 28 Jun 2026 10:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2809684866;
	Sun, 28 Jun 2026 12:25:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="0YXLi9+b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CAE484105; Sun, 28 Jun 2026 12:25:44 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD0984869
 for <u-boot@lists.denx.de>; Sun, 28 Jun 2026 12:25:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=9abc=EY=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1782642338; bh=mw9SpilXo2sEFMQi6sn0RSAFmQo1E2eOnuZkbQ/0kLk=;
 b=0YXLi9+bzOg1ATOZdWoms3Tc9D2o0sp5yDYwXUk4aq2hy3fqXRoSqPplJYi0c7EDC9t10G8mr
 r07ShYW+65b4I6aG+utwOMrEGbf/OZCK15qq3OW+t/WpTPOEAsO39H75YK5VrYQ32R/19RlsM1E
 TvmJww4XbRCk0GjBGYVH/H4Nc5BLyC8Zlix/HmqsM+HFcWYkyErzfLUekzg8tgh8uxcb1uulhhE
 RPi6DR9rHfnlQD42PRDspw+YRc4C+QBU8XxG4RUSBFz+voSh9T7Kk6VQZskjN/GcFngaIsyA9Uy
 nDwuKSwjp05Rm4kmizmMhhB9LydQuk/Rruo/mVh5wFgw==
X-Forward-Email-ID: 6a40f6a07915ab77658c86f4
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 2.9.1
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/4] test: dm: regulator: Add regulator_set_value_clamp() tests
Date: Sun, 28 Jun 2026 10:25:24 +0000
Message-ID: <20260628102527.1247889-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628102527.1247889-1-jonas@kwiboo.se>
References: <20260628102527.1247889-1-jonas@kwiboo.se>
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

Add a sandbox LDO3 with a configurable 1.8V to 3.3V range and use it
to test regulator_set_value_clamp().

Test in-range requests, clamping against the regulator limits, invalid
ranges outside the regulator limits and a min value higher than max.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/sandbox/dts/sandbox_pmic.dtsi |  6 +++++
 doc/usage/cmd/dm.rst               |  3 ++-
 drivers/power/regulator/sandbox.c  | 11 +++++----
 include/power/sandbox_pmic.h       | 15 ++++++++++--
 test/dm/regulator.c                | 38 ++++++++++++++++++++++++++++++
 5 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/arch/sandbox/dts/sandbox_pmic.dtsi b/arch/sandbox/dts/sandbox_pmic.dtsi
index ff2cb42844cc..d90ab0408278 100644
--- a/arch/sandbox/dts/sandbox_pmic.dtsi
+++ b/arch/sandbox/dts/sandbox_pmic.dtsi
@@ -47,6 +47,12 @@
 		regulator-min-microvolt = <1500000>;
 		regulator-max-microvolt = <1500000>;
 	};
+
+	ldo3 {
+		regulator-name = "SUPPLY_1.8_3.3V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+	};
 };
 
 &mc34708 {
diff --git a/doc/usage/cmd/dm.rst b/doc/usage/cmd/dm.rst
index 196b22d13764..ac1c437bd9c2 100644
--- a/doc/usage/cmd/dm.rst
+++ b/doc/usage/cmd/dm.rst
@@ -409,7 +409,8 @@ This example shows the abridged sandbox output::
     regulator     1  [   ]   sandbox_buck          |   |   |-- buck2
     regulator     2  [   ]   sandbox_ldo           |   |   |-- ldo1
     regulator     3  [   ]   sandbox_ldo           |   |   |-- ldo2
-    regulator     4  [   ]   sandbox_buck          |   |   `-- no_match_by_nodename
+    regulator     4  [   ]   sandbox_buck          |   |   |-- no_match_by_nodename
+    regulator     5  [   ]   sandbox_ldo           |   |   `-- ldo3
     pmic          1  [   ]   mc34708_pmic          |   `-- pmic@41
     bootcount     0  [ + ]   bootcount-rtc         |-- bootcount@0
     bootcount     1  [   ]   bootcount-i2c-eeprom  |-- bootcount
diff --git a/drivers/power/regulator/sandbox.c b/drivers/power/regulator/sandbox.c
index 80a68f5a30d5..813ee301e73b 100644
--- a/drivers/power/regulator/sandbox.c
+++ b/drivers/power/regulator/sandbox.c
@@ -56,10 +56,11 @@ static struct dm_regulator_mode sandbox_buck_modes[] = {
 	MODE(BUCK_OM_PWM, OM2REG(BUCK_OM_PWM), "PWM"),
 };
 
-/* LDO: 1,2 - voltage range */
+/* LDO: 1,2,3 - voltage range */
 static struct output_range ldo_voltage_range[] = {
 	RANGE(OUT_LDO1_UV_MIN, OUT_LDO1_UV_MAX, OUT_LDO1_UV_STEP),
 	RANGE(OUT_LDO2_UV_MIN, OUT_LDO2_UV_MAX, OUT_LDO2_UV_STEP),
+	RANGE(OUT_LDO3_UV_MIN, OUT_LDO3_UV_MAX, OUT_LDO3_UV_STEP),
 };
 
 /* LDO: 1 - current range */
@@ -288,8 +289,8 @@ static int ldo_set_voltage(struct udevice *dev, int uV)
 
 static int ldo_get_current(struct udevice *dev)
 {
-	/* LDO2 - unsupported */
-	if (dev->driver_data == 2)
+	/* LDO: 2,3 - unsupported */
+	if (dev->driver_data >= 2)
 		return -ENOSYS;
 
 	return out_get_value(dev, SANDBOX_LDO_COUNT, OUT_REG_UA,
@@ -298,8 +299,8 @@ static int ldo_get_current(struct udevice *dev)
 
 static int ldo_set_current(struct udevice *dev, int uA)
 {
-	/* LDO2 - unsupported */
-	if (dev->driver_data == 2)
+	/* LDO: 2,3 - unsupported */
+	if (dev->driver_data >= 2)
 		return -ENOSYS;
 
 	return out_set_value(dev, SANDBOX_LDO_COUNT, OUT_REG_UA,
diff --git a/include/power/sandbox_pmic.h b/include/power/sandbox_pmic.h
index 1dbd15b52354..50ef39b45e9b 100644
--- a/include/power/sandbox_pmic.h
+++ b/include/power/sandbox_pmic.h
@@ -13,10 +13,10 @@
 #define SANDBOX_OF_BUCK_PREFIX		"buck"
 
 #define SANDBOX_BUCK_COUNT	3
-#define SANDBOX_LDO_COUNT	2
+#define SANDBOX_LDO_COUNT	3
 /*
  * Sandbox PMIC registers:
- * We have only 12 significant registers, but we alloc 16 for padding.
+ * We have only 15 significant registers, but we alloc 16 for padding.
  */
 enum {
 	SANDBOX_PMIC_REG_BUCK1_UV = 0,
@@ -36,6 +36,10 @@ enum {
 	SANDBOX_PMIC_REG_LDO2_UA,
 	SANDBOX_PMIC_REG_LDO2_OM,
 
+	SANDBOX_PMIC_REG_LDO3_UV,
+	SANDBOX_PMIC_REG_LDO3_UA,
+	SANDBOX_PMIC_REG_LDO3_OM,
+
 	SANDBOX_PMIC_REG_COUNT = 16,
 };
 
@@ -94,6 +98,11 @@ enum {
 #define OUT_LDO2_UV_MAX		3950000
 #define OUT_LDO2_UV_STEP	50000
 
+/* LDO3 Voltage: min: 0.75V, step: 50mV, max 3.95V */
+#define OUT_LDO3_UV_MIN		750000
+#define OUT_LDO3_UV_MAX		3950000
+#define OUT_LDO3_UV_STEP	50000
+
 /* register <-> value conversion */
 #define REG2VAL(min, step, reg)		((min) + ((step) * (reg)))
 #define VAL2REG(min, step, val)		(((val) - (min)) / (step))
@@ -116,6 +125,8 @@ enum {
 #define SANDBOX_LDO1_PLATNAME	"VDD_EMMC_1.8V"
 #define SANDBOX_LDO2_DEVNAME	"ldo2"
 #define SANDBOX_LDO2_PLATNAME	"VDD_LCD_3.3V"
+#define SANDBOX_LDO3_DEVNAME	"ldo3"
+#define SANDBOX_LDO3_PLATNAME	"SUPPLY_1.8_3.3V"
 
 /*
  * Expected regulators setup after call of:
diff --git a/test/dm/regulator.c b/test/dm/regulator.c
index 449748ad52f2..51007d4079db 100644
--- a/test/dm/regulator.c
+++ b/test/dm/regulator.c
@@ -28,6 +28,7 @@ enum {
 	BUCK3,
 	LDO1,
 	LDO2,
+	LDO3,
 	OUTPUT_COUNT,
 };
 
@@ -44,6 +45,7 @@ static const char *regulator_names[OUTPUT_COUNT][OUTPUT_NAME_COUNT] = {
 	{ SANDBOX_BUCK3_DEVNAME, SANDBOX_BUCK3_PLATNAME },
 	{ SANDBOX_LDO1_DEVNAME, SANDBOX_LDO1_PLATNAME},
 	{ SANDBOX_LDO2_DEVNAME, SANDBOX_LDO2_PLATNAME},
+	{ SANDBOX_LDO3_DEVNAME, SANDBOX_LDO3_PLATNAME},
 };
 
 /* Test regulator get method */
@@ -118,6 +120,42 @@ static int dm_test_power_regulator_set_get_voltage(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_power_regulator_set_get_voltage, UTF_SCAN_FDT);
 
+/* Test regulator set Voltage clamp method */
+static int dm_test_power_regulator_set_value_clamp(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	const char *platname;
+
+	/* LDO3 have 'min' 1.8V and 'max' 3.3V */
+	platname = regulator_names[LDO3][PLATNAME];
+	ut_assertok(regulator_get_by_platname(platname, &dev));
+
+	/* 'target' in 'min'/'max' range - should not clamp voltage */
+	ut_assertok(regulator_set_value_clamp(dev, 1700000, 1800000, 1950000));
+	ut_asserteq(1800000, regulator_get_value(dev));
+	ut_assertok(regulator_set_value_clamp(dev, 2700000, 3300000, 3600000));
+	ut_asserteq(3300000, regulator_get_value(dev));
+
+	/* 'target' out of 'min'/'max' range - should clamp voltage */
+	ut_assertok(regulator_set_value_clamp(dev, 1700000, 1700000, 1950000));
+	ut_asserteq(1800000, regulator_get_value(dev));
+	ut_assertok(regulator_set_value_clamp(dev, 2700000, 3400000, 3600000));
+	ut_asserteq(3300000, regulator_get_value(dev));
+
+	/* 'min'/'max' out of range - should return -EINVAL */
+	ut_asserteq(-EINVAL,
+		    regulator_set_value_clamp(dev, 1200000, 1500000, 1700000));
+	ut_asserteq(-EINVAL,
+		    regulator_set_value_clamp(dev, 3500000, 4000000, 5000000));
+
+	/* 'min' higher than 'max' - should return -EINVAL */
+	ut_asserteq(-EINVAL,
+		    regulator_set_value_clamp(dev, 3100000, 3000000, 2900000));
+
+	return 0;
+}
+DM_TEST(dm_test_power_regulator_set_value_clamp, UTF_SCAN_FDT);
+
 /* Test regulator set and get Current method */
 static int dm_test_power_regulator_set_get_current(struct unit_test_state *uts)
 {
-- 
2.54.0

