Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC99C9832F
	for <u-boot@archiver.kernel.org>; Sun, 18 Jan 2026 13:49:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4359883A7A;
	Sun, 18 Jan 2026 14:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J8RPY7eG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 91E1C833C6; Sat, 17 Jan 2026 20:13:30 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56E2082BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 20:13:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-502a98c66f7so13009041cf.1
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 11:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768677207; x=1769282007; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZlnKt+IbfWPbWHyDD8AVsWRkwjCtFS4ACuG0J2k9x1A=;
 b=J8RPY7eGyx4dhjroduZ6vzwGR6w0MWiZ7kf2BhV4vt1WBQftEyIwxv33VoSxW7dm0b
 //QTEh+f6cY5cBhllmQeDWEUFhTH1W/sLTPG3JapPdGuK+BCD30cTppZzXB7xI41r2Cj
 65SjF83J5SAdZ8XuU7JtGPW9tPMW4qSIZosvbxP2G9Jd6VaL0Jt4fGbSkefQ8GqIKWQi
 U7okR4wGGgsJVreL7GvK2ypUNuzP4GwXgky/KQ8veVM5rHHPFcEzH9OM5jRVMDIeGzcu
 HX+zkDBg2mO4V8pUizORIsxGKaeUCXhUGlcDHbAaqfYpQs/jFXihjRJETQrDNs2LX3e7
 x80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768677207; x=1769282007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZlnKt+IbfWPbWHyDD8AVsWRkwjCtFS4ACuG0J2k9x1A=;
 b=XIO/tQsDyr3HPkDAZ3ZDr4qIjPbk88pHdJuqCIYA43fdHqevg5dklJDOBRkTOCTElT
 t818hyfkyGU9pL8/gGT+22bbEhIEK9BOGp/XyQyjK+vam8ZIs82Fdg3Fw1UjYHV2DZBu
 4L9NyYGRW+Sj20qnUrZ6XlgT1nLh1x8NpbrW7BzuCGWJJqUZh0AOjk5+tLwPynD20mZo
 JH/TKa8I/mNHF2nE11vz3CulOQrXzamlcbmGQJc3oG7aAFslwL69/GmTp65CzC49trZ6
 PqDPHn960QX7tWps0+3jpwba098AuVo8awfBrt39gdZnRjLvlzEwsd8llMa8DR71CcIm
 eT0g==
X-Gm-Message-State: AOJu0YzQ0agsKRTXCyq/6nqlvoV8TqgCH6+npQDkAVr4AF24g14CHGMd
 K68rz8UhC1729Ziq+YAKKN5qmvUEbHh0MmyOQRj28h3emwoMHqF5+Sxv/Ar4Kg==
X-Gm-Gg: AY/fxX7Hf6m/a9+hvdwf1LhnPr03766Bg6tAO9Nw98kmcSkMDwF5JkAv+aTwQdYdXcB
 qozSb6UGIMqxljxy4xwLOxI6aOPvStZoIhLO5fm2olRumJxM8E9ESYj8SMlmZNBOAiXGTkC71KF
 XJFWfndJWKUoTbNQdSuXDs+icevvbVc2HOxDGsiTNlk/7wqlhbqRLsaq0F54QdaUZs7mevFAmT/
 7/Gh+OMVXXAF0GhoP2Xfhjb30EtCrlUtcFyLJ/0ubcfLGPf7lYZPxyDRMxxGd1184Ndw1T9p9hK
 v5waHGXLCtrB6F+dAowi096wkmkDui+24NebBJ97QHBr19ki14o6ibiaiCwpyxA4UwIR6JTfOf6
 NBi7bPHFXIdif+ZPkyrRTFgp/Gl4N4OHZhEb4hXKAFz7BRf5DJocqc7zaOHkfk0A45Lk8+FBjkF
 teFA+BFbfGED6oRAYHDoQZ7cYxHrKhO6N1gHpd3jza9ksUIkQJPoM2VPWhTptE4D40nMuZ96w=
X-Received: by 2002:a05:622a:15d1:b0:4f1:b93e:8d60 with SMTP id
 d75a77b69052e-502a1694921mr90954191cf.33.1768677206826; 
 Sat, 17 Jan 2026 11:13:26 -0800 (PST)
Received: from ubuntu.localdomain (174-138-202-16.cpe.distributel.net.
 [174.138.202.16]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-502a1ef9347sm44340261cf.25.2026.01.17.11.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 11:13:26 -0800 (PST)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, Raymond Mao <raymond.mao@riscstar.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Heiko Schocher <hs@nabladev.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Yao Zi <me@ziyao.cc>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Conor Dooley <conor.dooley@microchip.com>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Michal Simek <michal.simek@amd.com>,
 Eric Schikschneit <eric.schikschneit@novatechautomation.com>,
 Randolph Sheng-Kai Lin <randolph@andestech.com>,
 Yixun Lan <dlan@gentoo.org>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Aniket Limaye <a-limaye@ti.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Henrik Grimler <henrik@grimler.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Justin Klaassen <justin@tidylabs.net>,
 Samuel Holland <samuel@sholland.org>,
 Rui Miguel Silva <rui.silva@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Elaine Zhang <zhangqing@rock-chips.com>,
 Joseph Chen <chenjh@rock-chips.com>
Subject: [PATCH 17/17] board: k1: enable pmic in spl
Date: Sat, 17 Jan 2026 14:01:51 -0500
Message-Id: <20260117190231.977686-18-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117190231.977686-1-raymondmaoca@gmail.com>
References: <20260117190231.977686-1-raymondmaoca@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Jan 2026 14:47:30 +0100
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
---
 arch/riscv/dts/k1-spl.dts | 128 ++++++++++++++++++++++++++++++++++----
 board/spacemit/k1/spl.c   |  83 ++++++++++++++++++++----
 configs/k1_defconfig      |   9 +++
 3 files changed, 198 insertions(+), 22 deletions(-)

diff --git a/arch/riscv/dts/k1-spl.dts b/arch/riscv/dts/k1-spl.dts
index f8b280fa96f..6dedca20f51 100644
--- a/arch/riscv/dts/k1-spl.dts
+++ b/arch/riscv/dts/k1-spl.dts
@@ -110,17 +110,6 @@
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
@@ -131,3 +120,120 @@
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
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index 54bad9000fe..c08d168fd52 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -8,6 +8,7 @@
 #include <clk-uclass.h>
 #include <cpu_func.h>
 #include <configs/k1.h>
+#include <cpu_func.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 #include <dt-bindings/pinctrl/k1-pinctrl.h>
@@ -15,8 +16,10 @@
 #include <i2c.h>
 #include <linux/delay.h>
 #include <log.h>
+#include <power/regulator.h>
 #include <spl.h>
 #include <tlv_eeprom.h>
+#include "tlv_codes.h"
 
 #define I2C_PIN_CONFIG(x)       ((x) | EDGE_NONE | PULL_UP | PAD_1V8_DS2)
 #define I2C_BUF_SIZE		64
@@ -117,6 +120,73 @@ void serial_early_init(void)
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
 /* Load DDR training firmware */
 int init_ddr_firmware(void)
 {
@@ -167,6 +237,8 @@ void board_init_f(ulong dummy)
 		log_info("Fail to detect board:%d\n", ret);
 	else
 		log_info("Get board name:%s\n", (char *)i2c_buf);
+	pmic_init();
+
 	ddr_early_init();
 }
 
@@ -175,17 +247,6 @@ u32 spl_boot_device(void)
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
diff --git a/configs/k1_defconfig b/configs/k1_defconfig
index 0d5c3932797..49a2dbca4f0 100644
--- a/configs/k1_defconfig
+++ b/configs/k1_defconfig
@@ -66,3 +66,12 @@ CONFIG_SPL_I2C_EEPROM=y
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

