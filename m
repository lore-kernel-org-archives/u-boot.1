Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0CEEA812C
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 15:18:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A1F483CF3;
	Tue, 10 Feb 2026 16:16:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AVcA4rNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8ADD583E16; Tue, 10 Feb 2026 16:15:59 +0100 (CET)
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com
 [IPv6:2607:f8b0:4864:20::929])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A56B83CEE
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 16:15:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x929.google.com with SMTP id
 a1e0cc1a2514c-94acf9ce1b7so528047241.2
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 07:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770736556; x=1771341356; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2UNmiAf2JP+s+D7u3QVsHNAfTQgKxDBOeDawGxECJTU=;
 b=AVcA4rNyGafsHP8o5LLKC7arpGHy2gD4zul71fmtwhKTl3qJuC52UhAEkhapNwFmhm
 D4pbv4eQ1NsFZunA/eGHiOG7f2hmZ+S6YagC93kCUxEWo/eEfDQovbBvi24Ey2UCZ2GF
 6ghtjdoer7cNmgfQXH7VB6aNwcMzVjGoSN7Tc2KebnNEtDLB3GIcZPpb5WSzubJIm2Xp
 A0s7ym9MLrEQLlkrakc1mhDXa4wpIkSniYlvI7SBFxsL5hqQtc7o14ymHvcPhDpVeD/N
 TR2RCfzytbxv7VEYMfoH68ljOCgHSsDQxpIrOvnCk0HuBVVQ0rOeeFtMU719C0dQZlQq
 jFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770736556; x=1771341356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2UNmiAf2JP+s+D7u3QVsHNAfTQgKxDBOeDawGxECJTU=;
 b=H4Dt1li2xsITZnnmhlfpTV28VT3HiSUu5V+BjTmGNG+1MtpMZRBC2cmiaWGwg/1C5U
 eHGOmrVth5jEDOjJfyYVAtXR0MGZ+4Ti+C02jCzBZlZpBcwcArz/KXEK6J1bdHou5qQz
 Lk+G6zN0IMqWJ5UPxWgswf9VFG9seVWZXJl+o3aScSi1T1cSpoaljZMzOrn8E8Jl2W5F
 EU++QzYe9LDNvRzXI1PO4jjQHL2jbxIc9qAqjAXtV7Ra550nfGsTM8uHhaeQnRHlBxkW
 UxvYtJ/O5zvXXJxpZIYaKep+J9weIGGl0eGRvEBWXwIHr5UJltiEdxolf/ee7f1XM7W+
 wF+w==
X-Gm-Message-State: AOJu0YwgGZsN5fvTtjiYRVrU6vnoWXAUBBc++/uwv8eQi6LaiiQECAMv
 fb+6NH9+0a6ynY5LYP+KqLHzW3YRQ0wU/OHJdQyGvIJ7Kj5+9ISmVNX0Kwy9uA==
X-Gm-Gg: AZuq6aI6gHNLFoZ7Ikps4KMDWB2/Ezxo2JEQFXKecKDdx30VLQBqUohdAPfsXPQhPsE
 GX9UATbprZRnNjss3ncwPIx5/tsfm763tshrQ+/yR5xaiXdne++jT/M9oojd9nHgOHGExutU8/O
 Y5g9SIoVVGbJRv/9EvO9xCBOqueAZuK1KMKu8PYvaetKCP8zeb3nCE1gqPJG7MB1hAW1el0cgLa
 5S95nM/AH4MN6pE+X/kJ23XeVgvjA9dyfwXGQ84R6GJha3TTO4phH/V0oSdC+iO26hK8Ywb03zu
 eEEDgrXbA8LenY1pDLPDP+tzHexqJgEOmUYnlw8t6iGoQ+M+EQD1RZy9GQQ8aCTfgpzuI8cvCIn
 VyKijDOllGDFtYezedOHKvUBL9dmsk54xGxIt/LY8KlzUgb7a2TgKLKqLCD4u204DBAArI6vYs4
 lK0CXSOYG9Q3qYaJFRV0rQRT3p3VmcDwgHn8Wuyl9PQ2JtSA1HcmdbaBdioQRaXcHTM9O4Nb0os
 Nvy+E5sh+A=
X-Received: by 2002:a05:6122:4f98:b0:563:66ec:8fdd with SMTP id
 71dfb90a1353d-56705feb566mr4245769e0c.16.1770736555510; 
 Tue, 10 Feb 2026 07:15:55 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8953c057751sm101019286d6.43.2026.02.10.07.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 07:15:54 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong.xu@riscstar.com>
Subject: [PATCH v2 16/16] board: k1: enable pmic in spl
Date: Tue, 10 Feb 2026 10:14:59 -0500
Message-Id: <20260210151459.2348758-17-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260210151459.2348758-1-raymondmaoca@gmail.com>
References: <20260210151459.2348758-1-raymondmaoca@gmail.com>
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
 arch/riscv/dts/k1-spl.dts     | 128 +++++++++++++++++++++++++++++++---
 board/spacemit/k1/MAINTAINERS |   7 +-
 board/spacemit/k1/spl.c       |  82 +++++++++++++++++++---
 configs/spacemit_k1_defconfig |   9 +++
 4 files changed, 203 insertions(+), 23 deletions(-)

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
index bd476c32719..f550745afea 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,11 @@
 BananaPi F3
 M:	Huan Zhou <pericycle.cc@@gmail.com>
+M:	Guodong Xu <guodong.xu@riscstar.com>
+L:      u-boot-spacemit@groups.io
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
index 65e8143a0bd..33efd204e3a 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -65,3 +65,12 @@ CONFIG_SPL_I2C_EEPROM=y
 CONFIG_CMD_TLV_EEPROM=y
 CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_LOG=y
+CONFIG_SPL_POWER=y
+CONFIG_DM_PMIC=y
+CONFIG_SPL_DM_PMIC=y
+CONFIG_PMIC_SPACEMIT_P1=y
+CONFIG_SPL_PMIC_SPACEMIT_P1=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_SPACEMIT_P1=y
+CONFIG_SPL_DM_REGULATOR_SPACEMIT_P1=y
-- 
2.25.1

