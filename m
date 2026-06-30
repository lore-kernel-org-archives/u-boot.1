Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6E3C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 01:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0857184AFD;
	Tue, 30 Jun 2026 03:20:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="dm4OiPbG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5059584B02; Tue, 30 Jun 2026 03:20:38 +0200 (CEST)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com
 [IPv6:2607:f8b0:4864:20::122f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDC7884A6D
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 03:20:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-139b5e604b9so4615940c88.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 18:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782782434; x=1783387234;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+kJ1a6sV8rz91sWZoSyr+GUCjfQ3+f+RpDMAwiaWkOA=;
 b=dm4OiPbG3cBx+yHaCUvEQBGbgFY1uENUHNphil4smdRz7W+CY+1pMmhFUs2e6uFF1T
 ZzTP65JJC5WMsz+xOZFjjqJCSKA0duWDg5kt/kfN2f+QWBIG4WMXthxFrc/2S0iwKNd5
 rC/bBDTiIw2+ejrS6jI+zOY5CEzEZ9WK+hkjZzPDLR9WhIbu63nLT2hl5x7J0ZSWG7lw
 PGuqqnYYyEsWEdh9dTDQWgNtiIDH94qLUbUNZV7CxdMcvB/fdyoILsnOOfGPTWPOVwuN
 QcojuDnfwQ4BL3GiwLH9WlSLY4Nt1ZycspvH5JmPNrUDGFvDI1S0yho4yx3iLX6n2hWO
 7GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782782434; x=1783387234;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+kJ1a6sV8rz91sWZoSyr+GUCjfQ3+f+RpDMAwiaWkOA=;
 b=PAQuCdL3QUfhtlECaAoPJLi+DF3y5fIRMLofB1KmRYTgV0H9u5KeJEMbtmZs0rA7mF
 UZFowTQvkm/R1LNwLeQXQbfuK5+oWPXeuj4NQyX5zo5kl6DT5hNhr1hVcwduefgP6lM1
 MDopJa1ZxHQWGhw+TWloOM0535VLtq+c9FJ3JiXr3CZYxn2RirEbF24J9Y0oguvF2DEF
 Bb+E+AQmlofOqndIov/W6R8RcqgHLWZyfGmRmPM6LOt5y2eObIkg0IplY55RiUMYH8GH
 6d+odkic5QdMbYY3KrePfvsBmwhKHh67UX0bA9PZcjmM4YkadRebCB91PRS/JCYTigMb
 09Dg==
X-Gm-Message-State: AOJu0Yw9RHVs6uLHTDO8wW0Oy8ab7M02xZDOq9GpaX/I22XX4E3GCH/u
 7a8kBwdkErE4kftOzg7U5wYBSKqH1J7IXC/RhFe9rQb2JUeNvVLm8hDzMzNnah1Vbpk=
X-Gm-Gg: AfdE7cnYmsmMQQWqsgStwBzuMosJhFkt72EAXs+pMj3y4Dfk44vNwBS7mi2tfARPCoM
 jLYlFT7fCwZoqgZwA6+VATubhcGnS5phCDjFMvpYtbyO2EAamp8S9+oeH9UzaF0cyvB8FcMIG1g
 pjRph2RIcxsNNgMMu2H/PDahyiIdaEHQmR9ap/5gFYLyG2S3knid15513icgYzbH0igGmR46+NC
 Z6+dYd3k9S+Y6l2PKJDZX0iF68kA0SO8Odt9vOUmA/mzSI1H8+dTNi+bum8Lx4rHa9G2YMTA81o
 qBA0n9tYLC9/JgPF8xbCGt4BTbJRd09l7XREyt82jeu5AhC6zDhpbXs9MiJVsBYUocAGHaNeRQN
 zwNKGOsj6gT4jS8Af1aLsXqRlAY01YeM2iAE4P5s9v130cu1NL1gnNbdlLTEkBvMwRikDDZjBre
 zI4nwALUlXyvBteH2Pn4If9DVnhb8kvgclV4KLe/NHoYg67/nj61KP2Ewsw5l35nVrEW3sqRwtB
 XY01AwkXJ7QwV5WZnFf8nzpHHjPu7FZBhQdj3ALfcjO+0bRevYwbKiDcoZ3SMH3
X-Received: by 2002:a05:7022:672a:b0:138:2c88:b3d6 with SMTP id
 a92af1059eb24-13b2a173399mr1044953c88.18.1782782434246; 
 Mon, 29 Jun 2026 18:20:34 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2a9b425asm2806974c88.0.2026.06.29.18.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 18:20:33 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Tue, 30 Jun 2026 09:19:14 +0800
Subject: [PATCH v5 13/14] board: k1: enable pmic in spl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-m1-v1-13-83f13347b3ba@riscstar.com>
References: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
In-Reply-To: <20260630-m1-v1-0-83f13347b3ba@riscstar.com>
To: u-boot@lists.denx.de, u-boot-spacemit@groups.io, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Tom Rini <trini@konsulko.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Yao Zi <me@ziyao.cc>, 
 Peng Fan <peng.fan@nxp.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Henrik Grimler <henrik@grimler.se>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Eric Chung <eric.chung@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Guodong Xu <guodong@riscstar.com>, 
 Songsong Zhang <sszhang@vsit.ai>
X-Mailer: b4 0.15.2
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

Also update MAINTAINERS: add Guodong Xu as co-maintainer, list the
u-boot-spacemit mailing list, register the new K1 driver files (i2c,
PMIC, regulator), and fix a pre-existing '@@' typo in Huan Zhou's
email.

Fixes: 1cd239f44438 ("riscv: spacemit: bananapi_f3: initial support added")
Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>
Tested-by: Songsong Zhang <sszhang@vsit.ai>
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 32 ++++++++++++
 board/spacemit/k1/MAINTAINERS             |  7 ++-
 board/spacemit/k1/spl.c                   | 84 +++++++++++++++++++++++++++----
 configs/spacemit_k1_defconfig             |  6 +++
 4 files changed, 117 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index b97bea7fd32..7f9443d6951 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -57,6 +57,38 @@
 	};
 };
 
+/*
+ * The kernel pmic@41 nodes use the standard regulator-* properties only;
+ * U-Boot's regulator framework looks up suppliers by `regulator-name`.
+ * Carry the U-Boot-specific names (vdd_core / vdd_1v8 / vdd_1v8_mmc) here
+ * so SPL can program the bucks that DDR training depends on.
+ */
+&i2c8 {
+	bootph-pre-ram;
+	resets = <&syscon_apbc RESET_TWSI8>;
+
+	pmic@41 {
+		bootph-pre-ram;
+
+		regulators {
+			buck1 {
+				regulator-name = "vdd_core";
+				bootph-pre-ram;
+			};
+
+			buck3 {
+				regulator-name = "vdd_1v8";
+				bootph-pre-ram;
+			};
+
+			aldo1 {
+				regulator-name = "vdd_1v8_mmc";
+				bootph-pre-ram;
+			};
+		};
+	};
+};
+
 &binman {
 	u-boot-spl-ddr {
 		type = "section";
diff --git a/board/spacemit/k1/MAINTAINERS b/board/spacemit/k1/MAINTAINERS
index b256cbe7978..8976c575dff 100644
--- a/board/spacemit/k1/MAINTAINERS
+++ b/board/spacemit/k1/MAINTAINERS
@@ -1,6 +1,11 @@
 BananaPi F3
-M:	Huan Zhou <pericycle.cc@@gmail.com>
+M:	Huan Zhou <pericycle.cc@gmail.com>
+M:	Guodong Xu <guodong.xu@riscstar.com>
+L:	u-boot-spacemit@groups.io
 S:	Maintained
 F:	board/spacemit/k1/
 F:	configs/spacemit_k1_defconfig
 F:	doc/board/spacemit/bananapi-f3.rst
+F:	drivers/i2c/k1_i2c.c
+F:	drivers/power/pmic/pmic_spacemit_p1.c
+F:	drivers/power/regulator/spacemit_p1_regulator.c
diff --git a/board/spacemit/k1/spl.c b/board/spacemit/k1/spl.c
index bab4fac3a13..2afabc72a3f 100644
--- a/board/spacemit/k1/spl.c
+++ b/board/spacemit/k1/spl.c
@@ -15,6 +15,7 @@
 #include <i2c.h>
 #include <linux/delay.h>
 #include <log.h>
+#include <power/regulator.h>
 #include <spl.h>
 #include <tlv_eeprom.h>
 #include "tlv_codes.h"
@@ -136,6 +137,76 @@ void serial_early_init(void)
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
+	ret = regulator_set_value(dev, 1800000);
+	if (ret)
+		log_warning("Fail to set vdd_1v8_mmc as 1800000 (%d)\n", ret);
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
@@ -257,6 +328,8 @@ void board_init_f(ulong dummy)
 		log_info("Fail to detect board:%d\n", ret);
 	else
 		log_info("Get board name:%s\n", (char *)i2c_buf);
+	pmic_init();
+
 	ddr_early_init();
 }
 
@@ -265,17 +338,6 @@ u32 spl_boot_device(void)
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
index ce0314686ab..e71c079bef2 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -33,6 +33,7 @@ CONFIG_SPL_MAX_SIZE=0x33000
 CONFIG_SPL_HAVE_INIT_STACK=y
 CONFIG_SPL_I2C=y
 CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_POWER=y
 CONFIG_HUSH_PARSER=y
 CONFIG_CMD_TLV_EEPROM=y
 CONFIG_SPL_CMD_TLV_EEPROM=y
@@ -51,6 +52,11 @@ CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_SPACEMIT_P1=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_SPACEMIT_P1=y
 CONFIG_DEBUG_UART_NS16550=y
 CONFIG_DEBUG_UART_SHIFT=2
 CONFIG_DEBUG_UART_ANNOUNCE=y

-- 
2.51.0

