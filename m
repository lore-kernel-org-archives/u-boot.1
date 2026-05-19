Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE54CD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 22:40:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 781B4847F6;
	Tue, 19 May 2026 00:38:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="JZRl+ofc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C99B8846A4; Tue, 19 May 2026 00:33:01 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42B4B8465A
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=guodong@riscstar.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-3698e34a567so2323636a91.2
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1779143578; x=1779748378;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9Aa5nYudhEiGWYwCt48oeT5zf6h1xTOeR9/B01w+eTQ=;
 b=JZRl+ofc0PtshAWatvFoFmkQxoAhwJ32RZJ4dE2uO9XBQloGsYr1aMXTyN5KlZM4Vg
 sQjZ0TQFvYl+PfEmIU6ajCWKI6f1jw0s45WN+kI08Fi14hhFE/haiddivwc6YjsOF1BM
 yFbhE4FXfF4gQ6afDEwJL7RAhs0L9MHvGN47U7VJ3IXRZtgvEc6g0ecU1DD+9t01xmIh
 LwyNV8puadv0IVeyHyGmGB+dGmEY3ARb1476KEcNy1Kb+LZsXjE2J1DuOAtqGCbQGT74
 VQCpv82i2ZqrwxRYAkWVTKFvRLMOHDbHD2WkQ2Ggv/bG5EQ8lAgS/9Iu/noTbNfvn2DN
 8irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779143578; x=1779748378;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9Aa5nYudhEiGWYwCt48oeT5zf6h1xTOeR9/B01w+eTQ=;
 b=ogcU7M6+OF83M3kYxRA3mvMpSorjeucmf4ahlniHw6jqYUgNB76pluoQEkogrQjkJ0
 qbr7Cu34iQYuFOIs5v3RzjgvnfATIlwMlWI+fhm0V4VvZEKKwQn+txvU/0XiwS5KVsx0
 h/7U1EPOnujwO368ICNGo+0PALDrvHX4w7IOUuVr5aYTVGasvyQ/Py/GpOS9ANVqH7wi
 QSu1A9iGJYl9UV3oUEp8QqrijLNNp69pgju6G6ArLaEILay52NOXWBC1s7opriN1JNcY
 nvZjUYK7MeCh3+eEf19DnXeRncd8ZxWR7FlvkGeh+702B9zjrkEQmyQTpEcFHwyrC4Xc
 eTxw==
X-Gm-Message-State: AOJu0YwnQDQRQ62wyGylM19wX8jqf9N8AQ2IU93VqoIsWxeHqQ5tmA9h
 SHakZ4uxcw+xnLJOAxiEwAqUnhNmd10s3PujGbO2Mc7kvRJkYzakEScCuFuzdCMmsZ8=
X-Gm-Gg: Acq92OG8X4XVPvMfPAMYgW0HpvAVBHHewMO9uUvXMc5tKKB8Bp8icianG+iYH3G+71a
 U3WnR6fyRPEiHtBhFzjGY+3GZh0sIAwKKP5gIc2ZQTM54s96QBEmq7q+s8Fkt/y9NiwrhhIvW6n
 4WOw+Sntg5aiypF00aYj8RyeAm5210LcFFCwpi4SeH0K319OUvuj1kICBHiDCTmZf87lBj3S0l+
 6cGQELcpQ3eFA+kcCO1NXCloYMWVmNvYLtYvu3W3/aLFOflThn92jw7ca3oVRxp9d6Xrho/oilr
 oVfYj78+L0yW1vr7uh51QMss9qfxJhmlevLameSdi3cpCZsL6+lpT/w15HRyF0OYIX2e4uNnxNC
 nvmI/QJAfQauPUc/CbPzdQOwVpAvHHzltPrRmWQUTSkGUFs3Jpi4dj4wpZOixn7Aoh2DS6+rtfO
 ojGSr4N2eV3GexkP30LSQX70ilJMvFImLdmlOc8OETpZw=
X-Received: by 2002:a17:90a:38a6:b0:368:c2b1:ec9e with SMTP id
 98e67ed59e1d1-36951cac956mr11108248a91.22.1779143577676; 
 Mon, 18 May 2026 15:32:57 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::4072])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm206379265ad.8.2026.05.18.15.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 15:32:57 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Tue, 19 May 2026 06:26:31 -0400
Subject: [PATCH v4 13/14] board: k1: enable pmic in spl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-b4-k1-spl-bring-up-v4-13-3915a2a904c1@riscstar.com>
References: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
In-Reply-To: <20260519-b4-k1-spl-bring-up-v4-0-3915a2a904c1@riscstar.com>
To: u-boot@lists.denx.de, Kongyang Liu <seashell11234455@gmail.com>, 
 Yixun Lan <dlan@gentoo.org>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Yao Zi <me@ziyao.cc>, 
 Junhui Liu <junhui.liu@pigmoral.tech>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Finley Xiao <finley.xiao@rock-chips.com>, Rick Chen <rick@andestech.com>, 
 Conor Dooley <conor.dooley@microchip.com>, u-boot-spacemit@groups.io, 
 Vincent Legoll <legoll@online.fr>, Huan Zhou <pericycle.cc@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, 
 Randolph Sheng-Kai Lin <randolph@andestech.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Henrik Grimler <henrik@grimler.se>, 
 Kory Maincent <kory.maincent@bootlin.com>, Anshul Dalal <anshuld@ti.com>, 
 Bo-Chen Chen <rex-bc.chen@mediatek.com>, 
 Justin Klaassen <justin@tidylabs.net>, Guodong Xu <guodong.xu@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Guodong Xu <guodong@riscstar.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Tue, 19 May 2026 00:38:07 +0200
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

---
v4:
- DT: drop forked pmic@41; overlay keeps bootph + regulator-name
  overrides for regulator_get_by_platname().
- Overlay: explicit `resets = <&syscon_apbc RESET_TWSI8>` on &i2c8.
- set_vdd_mmc(): program 1.8 V before enable.
- defconfig: SPL_DM_REGULATOR (not SPL_DM_PMIC).
- Drop duplicate <cpu_func.h>.
- MAINTAINERS: fix Huan Zhou email typo (@@ -> @, Fixes: tag included).
---
 arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi | 32 ++++++++++++
 board/spacemit/k1/MAINTAINERS             |  7 ++-
 board/spacemit/k1/spl.c                   | 84 +++++++++++++++++++++++++++----
 configs/spacemit_k1_defconfig             |  6 +++
 4 files changed, 117 insertions(+), 12 deletions(-)

diff --git a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
index 1a6240a9725..b0224dc7827 100644
--- a/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
+++ b/arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi
@@ -74,6 +74,38 @@
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
2.43.0

