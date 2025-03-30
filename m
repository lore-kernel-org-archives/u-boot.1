Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149B7C36011
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 09:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A5C81F54;
	Sun, 30 Mar 2025 11:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LmRqlbg4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4B4E8206E; Sun, 30 Mar 2025 11:45:44 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2569D81FC8
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 11:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so483203866b.3
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 02:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743327937; x=1743932737; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aGYOfsYlAL66VzcO0V7t5yBedhUR9qyQzNaphZTbPFk=;
 b=LmRqlbg4aoZSCVKt1fswImlrqKkktprgsDsCP2P4uneBZENXWGmaezhOvEs8Vve3pD
 C0aeLLyaetU6SODwEE1d2WPeEKisY1esAwoBh/QjXEf1Uw/1zZNgKbku5CVkTcDCERZI
 JhWzgnbLHn1tsW8zZWTqW1J9X7FE12d5G5Iz/r5LcutrTtZiazePSSJ8SWjXgclA9rl9
 /13AMsGdCK/6bZjlpE6OE4JKZeaX01F/WopfD8I0YCQVUFzgxHMrMdpKMxxPAIPsFvz9
 h6cRRSW6Yy3BRLDf2PTM4rDXhzsRH/Ov62ItkxCLJLgnR/w/q1qHMMDmJbLMcGqrfUod
 NFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743327937; x=1743932737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aGYOfsYlAL66VzcO0V7t5yBedhUR9qyQzNaphZTbPFk=;
 b=Bbv8Tz10rPu8ftlT1J5Xekdnfm1+LDyVgGeZQxbZi4C+E3JFB9vRbz4SyXMqlpqLlN
 UkZGHry+TiI5bFT7VpfFwml0y+9b2bow7Nvqun2XO/9dLfR49y/csbEOMqYHz6mc9UDr
 NCGL516it20jOs6nDfvDyru8dImlqzsMMdCBqF78TQxkZSO+1OLBcjzqz0uzaAnlQ2kI
 KsHZe3Dlf8wDO5I2x8uzBdrdx2eYzpfN584XXcM7mXOOJTrNihniyhyVmGLcPovjWJRd
 CvVCHUxVRqwVzGfMJOubaDpsNF9Yye/4ScVc83r00xaAt0JLdaUIhs4nuyLT7clPuhwO
 6w9g==
X-Gm-Message-State: AOJu0YyE0a5yngCXQsT+yfehBhrrOrqOKw++m4xqWUtChjXIxClG8PE6
 AK6CQTsL4SJ2MTNoir34biiVdIbz6X/AQrbe+x3G/42m5QyCV5d4
X-Gm-Gg: ASbGncs4Hpl9kknNmM9xBkCp6KjHoO32m044XIm5A5fvjYt4neI5TG6cP+kbuBOI7/i
 AXKVIsdoXV4Cri4Y1PXpAxSFk8v/fAt3gCRxIzmDGU88RZ94690DoTkqc/5EIbLBjiLRBh3JWE+
 miYiP6tQlBbsqq/STMrwHd7Lclmq0PubeRxIrPfEZp1H0aJL6WjIlAmj1bOztZ2jRS1iM4pPsZz
 x/Q1ClOS6opShrw/IlGSOKMbyxa8gQeI/coiBHPienEqNBup8M4y/ZVno6OyvDVj0oDOfSfxIJg
 kal1gpz48kD3vzLIMeEAQKafZcvwzefXvwZn
X-Google-Smtp-Source: AGHT+IFYpjWmRbdRxraV9P42QEU+6u8/2hWX5UVAD6gw6py0nyAiSNwwqq0BczI2hrJ9r069hFlfOg==
X-Received: by 2002:a17:907:7296:b0:ac3:17b6:737 with SMTP id
 a640c23a62f3a-ac738baca82mr421020966b.45.1743327937325; 
 Sun, 30 Mar 2025 02:45:37 -0700 (PDT)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac71927b175sm463235866b.61.2025.03.30.02.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 02:45:37 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Thierry Reding <treding@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Anatolij Gustschin <agust@denx.de>,
 Sumit Garg <sumit.garg@kernel.org>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Fabio Estevam <festevam@denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Peter Geis <pgwipeout@gmail.com>, Simon Glass <sjg@chromium.org>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Anton Bambura <jenneron@protonmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/6] video: backlight: add TI LM3532 led controller
Date: Sun, 30 Mar 2025 12:45:11 +0300
Message-ID: <20250330094515.11359-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330094515.11359-1-clamor95@gmail.com>
References: <20250330094515.11359-1-clamor95@gmail.com>
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

The LM3532 is a 500-kHz fixed frequency asynchronous boost converter which
provides the power for 3 high-voltage, low-side current sinks. The device
is programmable over an I2C-compatible interface and has independent
current control for all three channels.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/Kconfig            |   9 +
 drivers/video/Makefile           |   1 +
 drivers/video/lm3532_backlight.c | 380 +++++++++++++++++++++++++++++++
 3 files changed, 390 insertions(+)
 create mode 100644 drivers/video/lm3532_backlight.c

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6c323be3e32..73353944971 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -738,6 +738,15 @@ config ATMEL_HLCD
 	help
 	   HLCDC supports video output to an attached LCD panel.
 
+config BACKLIGHT_LM3532
+	bool "Backlight Driver for LM3532"
+	depends on BACKLIGHT
+	select DM_I2C
+	help
+	  Say Y to enable the backlight driver for National Semiconductor / TI
+	  LM3532 Lighting Power chip. Only backlight functions is supported as
+	  for now. Supported backlight level range is from 1 to 255.
+
 config BACKLIGHT_LM3533
 	bool "Backlight Driver for LM3533"
 	depends on BACKLIGHT
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index f6b980c9a47..49e42f34653 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_$(PHASE_)BMP) += bmp.o
 
 endif
 
+obj-$(CONFIG_BACKLIGHT_LM3532) += lm3532_backlight.o
 obj-$(CONFIG_BACKLIGHT_LM3533) += lm3533_backlight.o
 obj-$(CONFIG_BACKLIGHT_LP855x) += lp855x_backlight.o
 obj-${CONFIG_EXYNOS_FB} += exynos/
diff --git a/drivers/video/lm3532_backlight.c b/drivers/video/lm3532_backlight.c
new file mode 100644
index 00000000000..81b3b910196
--- /dev/null
+++ b/drivers/video/lm3532_backlight.c
@@ -0,0 +1,380 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * TI LM3532 LED driver
+ *
+ * Copyright (c) 2019 Texas Instruments Incorporated
+ * Copyright (c) 2025 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#define LOG_CATEGORY UCLASS_PANEL_BACKLIGHT
+
+#include <backlight.h>
+#include <dm.h>
+#include <dm/ofnode.h>
+#include <i2c.h>
+#include <log.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <asm/gpio.h>
+#include <power/regulator.h>
+
+#define LM3532_BL_MODE_MANUAL		0x00
+#define LM3532_BL_MODE_ALS		0x01
+
+#define LM3532_REG_OUTPUT_CFG		0x10
+#define LM3532_REG_STARTSHUT_RAMP	0x11
+#define LM3532_REG_RT_RAMP		0x12
+#define LM3532_REG_PWM_A_CFG		0x13
+#define LM3532_REG_PWM_B_CFG		0x14
+#define LM3532_REG_PWM_C_CFG		0x15
+#define LM3532_REG_ZONE_CFG_A		0x16
+#define LM3532_REG_CTRL_A_FS_CURR	0x17
+#define LM3532_REG_ZONE_CFG_B		0x18
+#define LM3532_REG_CTRL_B_FS_CURR	0x19
+#define LM3532_REG_ZONE_CFG_C		0x1a
+#define LM3532_REG_CTRL_C_FS_CURR	0x1b
+#define LM3532_REG_ENABLE		0x1d
+#define LM3532_ALS_CONFIG		0x23
+#define LM3532_REG_ZN_0_HI		0x60
+#define LM3532_REG_ZN_0_LO		0x61
+#define LM3532_REG_ZN_1_HI		0x62
+#define LM3532_REG_ZN_1_LO		0x63
+#define LM3532_REG_ZN_2_HI		0x64
+#define LM3532_REG_ZN_2_LO		0x65
+#define LM3532_REG_ZN_3_HI		0x66
+#define LM3532_REG_ZN_3_LO		0x67
+#define LM3532_REG_ZONE_TRGT_A		0x70
+#define LM3532_REG_ZONE_TRGT_B		0x75
+#define LM3532_REG_ZONE_TRGT_C		0x7a
+#define LM3532_REG_MAX			0x7e
+
+/* Control Enable */
+#define LM3532_CTRL_A_ENABLE		BIT(0)
+#define LM3532_CTRL_B_ENABLE		BIT(1)
+#define LM3532_CTRL_C_ENABLE		BIT(2)
+
+/* PWM Zone Control */
+#define LM3532_PWM_ZONE_MASK		0x7c
+#define LM3532_PWM_ZONE_0_EN		BIT(2)
+#define LM3532_PWM_ZONE_1_EN		BIT(3)
+#define LM3532_PWM_ZONE_2_EN		BIT(4)
+#define LM3532_PWM_ZONE_3_EN		BIT(5)
+#define LM3532_PWM_ZONE_4_EN		BIT(6)
+
+/* Brightness Configuration */
+#define LM3532_I2C_CTRL			BIT(0)
+#define LM3532_ALS_CTRL			0
+#define LM3532_LINEAR_MAP		BIT(1)
+#define LM3532_ZONE_MASK		(BIT(2) | BIT(3) | BIT(4))
+#define LM3532_ZONE_0			0
+#define LM3532_ZONE_1			BIT(2)
+#define LM3532_ZONE_2			BIT(3)
+#define LM3532_ZONE_3			(BIT(2) | BIT(3))
+#define LM3532_ZONE_4			BIT(4)
+
+#define LM3532_ENABLE_ALS		BIT(3)
+#define LM3532_ALS_SEL_SHIFT		6
+
+/* Zone Boundary Register */
+#define LM3532_ALS_WINDOW_mV		2000
+#define LM3532_ALS_ZB_MAX		4
+#define LM3532_ALS_OFFSET_mV		2
+
+#define LM3532_CONTROL_A		0
+#define LM3532_CONTROL_B		1
+#define LM3532_CONTROL_C		2
+#define LM3532_MAX_CONTROL_BANKS	3
+#define LM3532_MAX_LED_STRINGS		3
+
+#define LM3532_OUTPUT_CFG_MASK		0x3
+#define LM3532_BRT_VAL_ADJUST		8
+#define LM3532_RAMP_DOWN_SHIFT		3
+
+#define LM3532_NUM_RAMP_VALS		8
+#define LM3532_NUM_AVG_VALS		8
+#define LM3532_NUM_IMP_VALS		32
+
+#define LM3532_FS_CURR_MIN		5000
+#define LM3532_FS_CURR_MAX		29800
+#define LM3532_FS_CURR_STEP		800
+
+struct lm3532_bank_data {
+	int control_bank;
+	int mode;
+	int ctrl_brt_pointer;
+	int num_leds;
+	int full_scale_current;
+	u32 present:1;
+	u32 led_strings[LM3532_MAX_CONTROL_BANKS];
+};
+
+struct lm3532_backlight_priv {
+	struct gpio_desc enable_gpio;
+	struct udevice *regulator;
+
+	u32 runtime_ramp_up;
+	u32 runtime_ramp_down;
+
+	struct lm3532_bank_data bank[LM3532_MAX_CONTROL_BANKS];
+};
+
+/* This device does not like i2c md so use this instead */
+static void __maybe_unused dump_i2c(struct udevice *dev)
+{
+	int i, c;
+
+	for (i = 0; i < 0x10; i++) {
+		printf("00%02x: %02x", i * 0x10, dm_i2c_reg_read(dev, i * 0x10));
+		for (c = 1; c < 0xf; c++)
+			printf(" %02x", dm_i2c_reg_read(dev, i * 0x10 + c));
+		printf(" %02x\n", dm_i2c_reg_read(dev, i * 0x10 + 0xf));
+	}
+}
+
+static int lm3532_backlight_enable(struct udevice *dev)
+{
+	struct lm3532_backlight_priv *priv = dev_get_priv(dev);
+	int ret, i;
+
+	for (i = 0; i < LM3532_MAX_CONTROL_BANKS; i++) {
+		if (priv->bank[i].present) {
+			u32 ctrl_en_val = BIT(priv->bank[i].control_bank);
+
+			ret = dm_i2c_reg_clrset(dev, LM3532_REG_ENABLE,
+						ctrl_en_val, ctrl_en_val);
+			if (ret) {
+				log_debug("%s: failed to set ctrl: %d\n",
+					  __func__, ret);
+				return ret;
+			}
+		}
+	}
+
+	regulator_set_enable_if_allowed(priv->regulator, 1);
+
+	return 0;
+}
+
+static int lm3532_backlight_set_brightness(struct udevice *dev, int percent)
+{
+	struct lm3532_backlight_priv *priv = dev_get_priv(dev);
+	struct lm3532_bank_data *bank;
+	int ret, i;
+
+	for (i = 0; i < LM3532_MAX_CONTROL_BANKS; i++) {
+		if (priv->bank[i].present) {
+			bank = &priv->bank[i];
+			u32 brightness_reg = LM3532_REG_ZONE_TRGT_A +
+					     bank->control_bank * 5 +
+					     (bank->ctrl_brt_pointer >> 2);
+
+			ret = dm_i2c_reg_write(dev, brightness_reg, percent);
+			if (ret) {
+				log_debug("%s: failed to set brightness: %d\n",
+					  __func__, ret);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static const int ramp_table[LM3532_NUM_RAMP_VALS] = { 8, 1024, 2048, 4096, 8192,
+						     16384, 32768, 65536 };
+static int lm3532_get_ramp_index(int ramp_time)
+{
+	int i;
+
+	if (ramp_time <= ramp_table[0])
+		return 0;
+
+	if (ramp_time > ramp_table[LM3532_NUM_RAMP_VALS - 1])
+		return LM3532_NUM_RAMP_VALS - 1;
+
+	for (i = 1; i < LM3532_NUM_RAMP_VALS; i++) {
+		if (ramp_time == ramp_table[i])
+			return i;
+
+		/* Find an approximate index by looking up the table */
+		if (ramp_time > ramp_table[i - 1] &&
+		    ramp_time < ramp_table[i]) {
+			if (ramp_time - ramp_table[i - 1] < ramp_table[i] - ramp_time)
+				return i - 1;
+			else
+				return i;
+		}
+	}
+
+	return 0;
+}
+
+static int lm3532_backlight_of_to_plat(struct udevice *dev)
+{
+	struct lm3532_backlight_priv *priv = dev_get_priv(dev);
+	u32 ramp_time, reg;
+	ofnode child;
+	int ret;
+
+	ret = gpio_request_by_name(dev, "enable-gpios", 0,
+				   &priv->enable_gpio, GPIOD_IS_OUT);
+	if (ret) {
+		log_debug("%s: could not decode enable-gpios (%d)\n", __func__, ret);
+		return ret;
+	}
+
+	ret = device_get_supply_regulator(dev, "vin-supply", &priv->regulator);
+	if (ret) {
+		log_debug("%s: vin regulator not defined: %d\n", __func__, ret);
+		if (ret != -ENOENT)
+			return log_ret(ret);
+	}
+
+	ramp_time = dev_read_u32_default(dev, "ramp-up-us", 0);
+	priv->runtime_ramp_up = lm3532_get_ramp_index(ramp_time);
+
+	ramp_time = dev_read_u32_default(dev, "ramp-down-us", 0);
+	priv->runtime_ramp_down = lm3532_get_ramp_index(ramp_time);
+
+	/* Backlight is one of children but has no dedicated driver */
+	ofnode_for_each_subnode(child, dev_ofnode(dev)) {
+		ret = ofnode_read_u32(child, "reg", &reg);
+		if (ret || reg > LM3532_CONTROL_C) {
+			log_debug("%s: control bank invalid %d\n", __func__, reg);
+			continue;
+		}
+
+		struct lm3532_bank_data *bank = &priv->bank[reg];
+
+		bank->control_bank = reg;
+		bank->present = 1;
+		bank->mode = ofnode_read_u32_default(child, "ti,led-mode",
+						     LM3532_BL_MODE_MANUAL);
+		bank->mode = LM3532_BL_MODE_ALS ? LM3532_ALS_CTRL : LM3532_I2C_CTRL;
+
+		if (ofnode_read_bool(child, "ti,linear-mapping-mode"))
+			bank->mode |= LM3532_LINEAR_MAP;
+
+		bank->num_leds = ofnode_read_size(child, "led-sources");
+		bank->num_leds /= sizeof(u32);
+		if (bank->num_leds > LM3532_MAX_LED_STRINGS) {
+			log_debug("%s: too many LED string defined %d\n",
+				  __func__, bank->num_leds);
+			continue;
+		}
+
+		ret = ofnode_read_u32_array(child, "led-sources",
+					    bank->led_strings,
+					    bank->num_leds);
+		if (ret) {
+			log_debug("%s: led-sources property missing %d\n",
+				  __func__, ret);
+			continue;
+		}
+
+		ret = ofnode_read_u32(child, "led-max-microamp",
+				      &bank->full_scale_current);
+		if (ret)
+			log_debug("%s: failed getting led-max-microamp %d\n",
+				  __func__, ret);
+		else
+			bank->full_scale_current = min(bank->full_scale_current,
+						       LM3532_FS_CURR_MAX);
+	}
+
+	return 0;
+}
+
+static int lm3532_backlight_init_registers(struct udevice *dev,
+					   struct lm3532_bank_data *bank)
+{
+	struct lm3532_backlight_priv *priv = dev_get_priv(dev);
+	u32 brightness_config_val, runtime_ramp_val;
+	u32 output_cfg_val = 0, output_cfg_shift = 0, output_cfg_mask = 0;
+	int fs_current_reg, fs_current_val;
+	int ret, i;
+
+	if (!bank->present)
+		return 0;
+
+	u32 brightness_config_reg = LM3532_REG_ZONE_CFG_A + bank->control_bank * 2;
+	/*
+	 * This could be hard coded to the default value but the control
+	 * brightness register may have changed during boot.
+	 */
+	ret = dm_i2c_reg_read(dev, brightness_config_reg);
+	if (ret < 0)
+		return ret;
+
+	bank->ctrl_brt_pointer = ret & ~LM3532_ZONE_MASK;
+	brightness_config_val = bank->ctrl_brt_pointer | bank->mode;
+
+	ret = dm_i2c_reg_write(dev, brightness_config_reg, brightness_config_val);
+	if (ret)
+		return ret;
+
+	if (bank->full_scale_current) {
+		fs_current_reg = LM3532_REG_CTRL_A_FS_CURR + bank->control_bank * 2;
+		fs_current_val = (bank->full_scale_current - LM3532_FS_CURR_MIN) /
+				 LM3532_FS_CURR_STEP;
+
+		ret = dm_i2c_reg_write(dev, fs_current_reg, fs_current_val);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < bank->num_leds; i++) {
+		output_cfg_shift = bank->led_strings[i] * 2;
+		output_cfg_val |= (bank->control_bank << output_cfg_shift);
+		output_cfg_mask |= LM3532_OUTPUT_CFG_MASK << output_cfg_shift;
+	}
+
+	ret = dm_i2c_reg_clrset(dev, LM3532_REG_OUTPUT_CFG, output_cfg_mask,
+				output_cfg_val);
+	if (ret)
+		return ret;
+
+	runtime_ramp_val = priv->runtime_ramp_up |
+			 (priv->runtime_ramp_down << LM3532_RAMP_DOWN_SHIFT);
+
+	return dm_i2c_reg_write(dev, LM3532_REG_RT_RAMP, runtime_ramp_val);
+}
+
+static int lm3532_backlight_probe(struct udevice *dev)
+{
+	struct lm3532_backlight_priv *priv = dev_get_priv(dev);
+	int ret, i;
+
+	if (device_get_uclass_id(dev->parent) != UCLASS_I2C)
+		return -EPROTONOSUPPORT;
+
+	dm_gpio_set_value(&priv->enable_gpio, 1);
+
+	for (i = 0; i < LM3532_MAX_CONTROL_BANKS; i++) {
+		ret = lm3532_backlight_init_registers(dev, &priv->bank[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct backlight_ops lm3532_backlight_ops = {
+	.enable = lm3532_backlight_enable,
+	.set_brightness = lm3532_backlight_set_brightness,
+};
+
+static const struct udevice_id lm3532_backlight_ids[] = {
+	{ .compatible = "ti,lm3532" },
+	{ }
+};
+
+U_BOOT_DRIVER(lm3532_backlight) = {
+	.name		= "lm3532_backlight",
+	.id		= UCLASS_PANEL_BACKLIGHT,
+	.of_match	= lm3532_backlight_ids,
+	.of_to_plat	= lm3532_backlight_of_to_plat,
+	.probe		= lm3532_backlight_probe,
+	.ops		= &lm3532_backlight_ops,
+	.priv_auto	= sizeof(struct lm3532_backlight_priv),
+};
-- 
2.43.0

