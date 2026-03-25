Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AD8109E527
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 22:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F270284120;
	Wed, 25 Mar 2026 23:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qrpY/exT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B77DA84101; Wed, 25 Mar 2026 23:33:31 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA31C83A41
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 23:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-8cfd44fa075so59949985a.0
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774478007; x=1775082807; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYB8khKZUmdGj5PlA/bT5Bn6AHKga9mwzPkxIWcaV9w=;
 b=qrpY/exToRPLmx5gmTs1LNS4CkDAR8Ng9xNLmBRG2vjyMUt6UNbyBMgFKT4MbKYY+0
 VTwkfLiNmYIGkzsc3MJYXL43L/PGW8SvC1MFteGcOuu0Qoms25WncRQqAkl49Uapsf/a
 yDP8c4790jIU0c27nDGjEOts3BL8mdEEHbMfobX/GEWti+g7e1V+0XUMI8M52Z9KBypI
 0Su8vMw0X7bgFkiqrgWhAwWAQ9m8B2gkQu1MvahoXD3D4f8UGoiOEBztBbtKLueM8BFe
 Ysi61n/8Zz9G4b2OO7H11aUWYdYAxUHLF2+xayu6PRIpV7VNQhCrbpjpQIMKBAxhtwHr
 Dh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774478007; x=1775082807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XYB8khKZUmdGj5PlA/bT5Bn6AHKga9mwzPkxIWcaV9w=;
 b=giDNKPcTMl2EVlpdbukqj2k4dPH8tZlSmCdVWm3iGnOGBIqxAGkpHowuWkYVlrXR08
 6elDNKwOlXyVw8TVsRCbttC5iuWCzuy/e/Lo7WwmFy3MA/847BIgsxs94MWHcOxZVzHR
 HsV8qRT5Qn8pKhNcG7iE43PKmX3T4Aa12Z0pAn5rTZGyEGoyJlWR4ns6XfP1DOBAwSUG
 8iUasd4uxfvyHA4fUB+RYkodqrVDJmG51S9+4FOi3+av85x5F3oOcYTnviNqYumsp2ir
 2hV+BQ5Jqvdqjkh+nsJQ3oKyWdAbdIu2o0X+xib3VPt5a75KOT5vskbpmNxDHyuo/pUa
 Xr3w==
X-Gm-Message-State: AOJu0YysmApToVd8YNkCwRvGfBEiL08btTMhhFGS8/edwwAIykb/w1og
 j/k1uGG59a7v/+Q5sTAWKYDiMVaOkplcZj0X8kM8eMbS8jR48d+o6vB13eD4ihj+
X-Gm-Gg: ATEYQzwwhlPLf+EL3Hr3MRd3upznr+DRkTciycbvEux7cyw9q30jZhWA9hDTnj4x3Kp
 1ShECNt7zJz6ruXe38aDqragjbnEFbCYKjBgD47msenzWl6KesJ2xneAI/rUij6IqQlJLHiQewV
 i/hReLXYhry6RCZsiRmoO/MQ+1zOWU43UZLnYf28GhT5Zf/tZPMI6w5slLNnvyyvD9kRqWpw1BZ
 LX1G6SiaaVkCKEIhz9omY2u+j2U3ImZ8kmYREM4Q0/K7+Jyk9Gh1vxWaUnzvsySGWJ5RfMP0aPF
 /7iqLUi6mxNWkyD4Z08VMny1M6WzDhlRhCO0NHkc9VZNzXpG1UrBVzRJ6jmzKDWepqbuybU7aaA
 gpsb8fy4CAuhBO8WP5OIcJnMijfM79QSA8SvljlxQJmC0OfL9b9Qc2JDcHOEO54xdvpIPGOumav
 cdk4N/EmivpdkfNZjwoHViMExzJuppWt4x4ojiJ3DnHK6hmG4A7Orn9BgznuGd9f1DeK24VUIN3
 zto31VYCwA=
X-Received: by 2002:a05:620a:199b:b0:8c9:f9c1:5ed with SMTP id
 af79cd13be357-8d00106dbd2mr750814685a.63.1774478007312; 
 Wed, 25 Mar 2026 15:33:27 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-124-85.cpe.distributel.net.
 [173.206.124.85]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d00e39fc17sm101540185a.5.2026.03.25.15.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 15:33:27 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong.xu@riscstar.com>
Subject: [PATCH v3 16/16] board: k1: enable pmic in spl
Date: Wed, 25 Mar 2026 18:32:32 -0400
Message-Id: <20260325223232.1553212-17-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260325223232.1553212-1-raymondmaoca@gmail.com>
References: <20260325223232.1553212-1-raymondmaoca@gmail.com>
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

From: Raymond Mao <raymond.mao@riscstar.com>

Add Spacemit P1 SoC support in SPL. And set the default voltage
for BUCKs and LDOs.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong.xu@riscstar.com>
---
Changes in v3:
- Remove CONFIG_SPL_PMIC_SPACEMIT_P1 and
  CONFIG_SPL_DM_REGULATOR_SPACEMIT_P1 from defconfig (Kconfig
  symbols no longer exist)
- Fix MAINTAINERS: use TAB instead of spaces before mailing list

 arch/riscv/dts/k1-spl.dts     | 128 +++++++++++++++++++++++++++++++---
 board/spacemit/k1/MAINTAINERS |   7 +-
 board/spacemit/k1/spl.c       |  82 +++++++++++++++++++---
 configs/spacemit_k1_defconfig |   7 ++
 4 files changed, 201 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
index e118767e6db..6f9407aada6 100644
--- a/arch/riscv/dts/k1-spl.dts
+++ b/arch/riscv/dts/k1-spl.dts
@@ -99,17 +99,6 @@
 		};
 	};
 
-	i2c@d401d800 {		/* i2c8 */
-		status = "okay";
-		bootph-pre-ram;
-		pmic@41 {
-			compatible = "pmic";
-			reg = <0x41>;
-			status = "okay";
-			bootph-pre-ram;
-		};
-	};
-
 	reset-controller@d4050000 {
 		status = "okay";
 		bootph-pre-ram;
@@ -120,3 +109,120 @@
 	status = "okay";
 	bootph-pre-ram;
 };
+
+&i2c8 {
+	status = "okay";
+	bootph-pre-ram;
+	pmic@41 {
+		compatible = "spacemit,p1";
+		reg = <0x41>;
+		status = "okay";
+		bootph-pre-ram;
+
+		regulators {
+			buck1 {
+				regulator-name = "vdd_core";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+				bootph-pre-ram;
+			};
+
+			buck2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck3_1v8: buck3 {
+				regulator-name = "vdd_1v8";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+				bootph-pre-ram;
+			};
+
+			buck4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			aldo1 {
+				regulator-name = "vdd_1v8_mmc";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				bootph-pre-ram;
+			};
+
+			aldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo7 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+		};
+	};
+};
diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index bd476c32719..408621ab819 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,11 @@
 BananaPi F3
 M:	Huan Zhou <pericycle.cc@@gmail.com>
+M:	Guodong Xu <guodong.xu@riscstar.com>
+L:	u-boot-spacemit@groups.io
 S:	Maintained
 F:	board/spacemit/k1/
-F:	configs/k1_defconfig
+F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
+F:	drivers/i2c/k1_i2c.c
+F:	drivers/power/pmic/pmic_spacemit_p1.c
+F:	drivers/power/regulator/spacemit_p1_regulator.c
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 95b61f5aa90..5af804f0409 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -10,11 +10,13 @@
 #include <clk-uclass.h>
 #include <cpu_func.h>
 #include <configs/k1.h>
+#include <cpu_func.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <i2c.h>
 #include <linux/delay.h>
 #include <log.h>
+#include <power/regulator.h>
 #include <spl.h>
 #include <tlv_eeprom.h>
 #include "tlv_codes.h"
@@ -146,6 +148,73 @@ void serial_early_init(void)
 		panic("Serial uclass init failed: %d\n", ret);
 }
 
+static void set_vdd_core(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = regulator_get_by_platname("vdd_core", &dev);
+	if (ret)
+		panic("Fail to detect vdd_core (%d)\n", ret);
+	ret = regulator_set_enable(dev, true);
+	if (ret)
+		log_warning("Fail to enable vdd_core (%d)\n", ret);
+	ret = regulator_get_value(dev);
+	if (ret < 0)
+		log_warning("Fail to read vdd_core (%d)\n", ret);
+	log_info("vdd_core, value:%d\n", ret);
+}
+
+static void set_vdd_1v8(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = regulator_get_by_platname("vdd_1v8", &dev);
+	if (ret)
+		panic("Fail to detect vdd_1v8 (%d)\n", ret);
+	ret = regulator_set_value(dev, 1800000);
+	if (ret)
+		log_warning("Fail to set vdd_1v8 as 1800000 (%d)\n", ret);
+	ret = regulator_set_enable(dev, true);
+	if (ret)
+		log_warning("Fail to enable vdd_1v8 (%d)\n", ret);
+	ret = regulator_get_value(dev);
+	if (ret < 0)
+		log_warning("Fail to read vdd_1v8 (%d)\n", ret);
+	log_info("vdd_1v8, value:%d\n", ret);
+}
+
+static void set_vdd_mmc(void)
+{
+	struct udevice *dev;
+	int ret;
+
+	ret = regulator_get_by_platname("vdd_1v8_mmc", &dev);
+	if (ret)
+		panic("Fail to detect vdd_1v8_mmc (%d)\n", ret);
+	ret = regulator_set_enable(dev, true);
+	if (ret)
+		log_warning("Fail to enable vdd_1v8_mmc (%d)\n", ret);
+	ret = regulator_get_value(dev);
+	if (ret < 0)
+		log_warning("Fail to read vdd_1v8_mmc (%d)\n", ret);
+	log_info("vdd_1v8_mmc, value:%d\n", ret);
+}
+
+void pmic_init(void)
+{
+	struct udevice *pmic_dev;
+	int ret;
+
+	ret = uclass_get_device(UCLASS_PMIC, 0, &pmic_dev);
+	if (ret)
+		panic("Fail to detect PMIC (%d)\n", ret);
+	set_vdd_core();
+	set_vdd_1v8();
+	set_vdd_mmc();
+}
+
 /* Set default value for DDR chips */
 static void ddr_cfg_init(struct ddr_cfg *cfg)
 {
@@ -263,6 +332,8 @@ void board_init_f(ulong dummy)
 		log_info("Fail to detect board:%d\n", ret);
 	else
 		log_info("Get board name:%s\n", (char *)i2c_buf);
+	pmic_init();
+
 	ddr_early_init();
 }
 
@@ -271,17 +342,6 @@ u32 spl_boot_device(void)
 	return BOOT_DEVICE_NOR;
 }
 
-void pmic_init(void)
-{
-	struct udevice *pmic_dev = NULL;
-	int ret;
-
-	ret = uclass_get_device(UCLASS_PMIC, 0, &pmic_dev);
-	if (ret)
-		panic("Fail to detect PMIC:%d\n", ret);
-}
-
 void spl_board_init(void)
 {
-	pmic_init();
 }
diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 5a96eded8bf..16754ea98d3 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -57,6 +57,10 @@ CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_CMD_TLV_EEPROM=y
 CONFIG_LOG=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_SPACEMIT_P1=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_SPACEMIT_P1=y
 CONFIG_SPL_REGMAP=y
 CONFIG_SPL_LIB_RATIONAL=y
 CONFIG_SPL_DM_RESET=y
@@ -67,3 +71,6 @@ CONFIG_SPL_MISC=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_SPL_CMD_TLV_EEPROM=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_DM_PMIC=y
+CONFIG_SPL_DM_REGULATOR=y
-- 
2.25.1

