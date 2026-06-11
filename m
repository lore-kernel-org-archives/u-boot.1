Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B0DCD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A976848D1;
	Thu, 11 Jun 2026 16:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dfau2Tgh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B40B848C5; Thu, 11 Jun 2026 16:18:49 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F68783FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:18:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-517b1f2c668so53855481cf.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781187525; x=1781792325; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Y7swhknmyb97pDb4I4R6YRkqLN14mzqlalOfxJjOQI=;
 b=dfau2TghzFsxmItDGSIAY9k5MM8oynnZVO/iQ0tMsbQHAr3hF7wl6Gbj8oyI3qv9CN
 rlCZ3vOGsHTw3+0w+tKUczAreUtbr5xCy9sOvnPjF4W/DIOz2J9lw7BEkuo1CNTzy6xN
 EuBGW8Ghy3YjSb286ME6nUsxSR/WrcXAcCJOQKheJXgwJubMgFrj1ivt306cHpm10kyp
 +VXzrrjNpOE6/q/UlAA078tN+hLUuC2OgHDGUJIA09d+Gu8KrmRUYdF8XI1+k4y8+lcd
 R2lx+DArNqLdzyzynq4aTS5/z7tWVs0muum39H1ZmNFPNQuT8RO4u5L3WAqfCUYrYTNA
 Mm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781187525; x=1781792325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Y7swhknmyb97pDb4I4R6YRkqLN14mzqlalOfxJjOQI=;
 b=BDf8U+7R3DwaCZ8iUz64hmorvcaC8yxPiFd9fyA/JYDwFRAU72pew5/jJejUjnCge+
 qO8+Xa5O8c1sn1/56o9SOrkbZ4MoY0ioxrgiqGfn1srcW48ElSq4qwnKQoUMW5cxvWgL
 MrXVZyVn6/iZIcFIlYtrfof/TEJrHHniCUp4Qa+3Kuw939UUPyOuLUWoyHhapMZK14JO
 JMSjA/yvtv4qIB/L8NW4wd+S4qB2mJKYafq8TVIOfZMTkvdHHPu3KstrVEPaLCzi0CCA
 30S2PBWxHJoWB5uW8SxVTrD/qCY780tAt641CgCel7kF74KTWLNLvhtc6JibGV2D6bp7
 NByA==
X-Gm-Message-State: AOJu0YzFKg/uX3FNS2exexac3oGCQGwb0yJ0N0q8MzH/bsLTxOiHAWih
 C6Lw9RKncGQoKnJy7yJriocX9oU9SSGslZxZicLVIUfI+t+ASX5YzQ5SvzF4GI6t
X-Gm-Gg: Acq92OEzwLPEdNJc5gk9X92Y3CRtQVAQeU1EsIYrUml/zwUxrdrg4zR6KCXlqFwmxbv
 4WEYmWAudTRKDVYx/0jBImJ+f/5rufWAs0185SDQDNo2sXeQYRQK2O+3q31WI7TGzkvEaPEXYM9
 zwgeldFef6MyFHgQxD0yktqCmEpR5bB8rSURzlpScgLaT+hTpNYRfYSIrfxrRoOLojBbuzKhCGW
 GEwj0vdij3XQyDLtbqo1Ln24iT+hYFNiL9Cn2tvF3SbAV3a5d/H0JnixBGYvtb325IeWJBztmPP
 vtAR9vtmcSxaL0eJskvkAuCC38UPx8NUVO0QZMn6I4WC4K6fHcS/Fb80KGiQI3YfjtezQT/pTk+
 /8jqHIwgy+MphMG9xYNDT8kyVT1r+cb+iFUGiZi57+LXqsx98X975ZzVpC/fxQ7sEUVB97VcYWH
 C5Fsq7WOwdHbIX7T7TAnqggAH2UXj3xkwfQpUOQgNIq8d/WHRmbP9Ol3qqMAOEgvMxlc5w59Bsr
 TRG6adPA6Lao0BdYd0=
X-Received: by 2002:a05:622a:1355:b0:516:ea2d:7c5a with SMTP id
 d75a77b69052e-517ee20574dmr46032461cf.41.1781187524911; 
 Thu, 11 Jun 2026 07:18:44 -0700 (PDT)
Received: from ubuntu.localdomain (23-91-246-209.cpe.distributel.net.
 [23.91.246.209]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-517ef67bb92sm18536031cf.27.2026.06.11.07.18.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 07:18:44 -0700 (PDT)
From: Raymond Mao <raymondmaoca@gmail.com>
To: u-boot@lists.denx.de
Cc: uboot@riscstar.com, u-boot-spacemit@groups.io, raymond.mao@riscstar.com,
 rick@andestech.com, ycliang@andestech.com, trini@konsulko.com,
 lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org,
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org,
 quentin.schulz@cherry.de, samuel@sholland.org, raymondmaoca@gmail.com,
 Guodong Xu <guodong@riscstar.com>
Subject: [PATCH v3 7/9] pinctrl: add pinctrl driver for Spacemit K1 SoC
Date: Thu, 11 Jun 2026 10:18:09 -0400
Message-Id: <20260611141811.68904-8-raymondmaoca@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260611141811.68904-1-raymondmaoca@gmail.com>
References: <20260611141811.68904-1-raymondmaoca@gmail.com>
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

Add pinctrl driver for Spacemit K1 SoC.

Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
Signed-off-by: Guodong Xu <guodong@riscstar.com>

---
Changes in v2:
- No change.
Changes in v3:
- Fix CONFIG_$(PHASE_)PINCTRL_SPACEMIT_K1 to CONFIG_PINCTRL_SPACEMIT_K1.
  Do not enable pinctrl driver in SPL stage.

 drivers/pinctrl/Kconfig               |   1 +
 drivers/pinctrl/Makefile              |   1 +
 drivers/pinctrl/spacemit/Kconfig      |   9 +
 drivers/pinctrl/spacemit/Makefile     |   2 +
 drivers/pinctrl/spacemit/pinctrl-k1.c | 546 ++++++++++++++++++++++++++
 5 files changed, 559 insertions(+)
 create mode 100644 drivers/pinctrl/spacemit/Kconfig
 create mode 100644 drivers/pinctrl/spacemit/Makefile
 create mode 100644 drivers/pinctrl/spacemit/pinctrl-k1.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 578edbf8168..a3abe0ea04d 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -419,6 +419,7 @@ source "drivers/pinctrl/nxp/Kconfig"
 source "drivers/pinctrl/qcom/Kconfig"
 source "drivers/pinctrl/renesas/Kconfig"
 source "drivers/pinctrl/rockchip/Kconfig"
+source "drivers/pinctrl/spacemit/Kconfig"
 source "drivers/pinctrl/sunxi/Kconfig"
 source "drivers/pinctrl/tegra/Kconfig"
 source "drivers/pinctrl/uniphier/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index 29fb9b484d0..78ec9844ef3 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_PINCTRL_SCMI)	+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_SINGLE)	+= pinctrl-single.o
 obj-$(CONFIG_PINCTRL_STI)	+= pinctrl-sti.o
 obj-$(CONFIG_PINCTRL_STM32)	+= pinctrl_stm32.o
+obj-$(CONFIG_PINCTRL_SPACEMIT_K1) += spacemit/
 obj-$(CONFIG_$(PHASE_)PINCTRL_SX150X) += pinctrl-sx150x.o
 obj-$(CONFIG_$(PHASE_)PINCTRL_STMFX)	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_TH1520)	+= pinctrl-th1520.o
diff --git a/drivers/pinctrl/spacemit/Kconfig b/drivers/pinctrl/spacemit/Kconfig
new file mode 100644
index 00000000000..6aab89e160c
--- /dev/null
+++ b/drivers/pinctrl/spacemit/Kconfig
@@ -0,0 +1,9 @@
+config PINCTRL_SPACEMIT_K1
+	bool "Spacemit K1 SoC pinctrl driver"
+	depends on PINCTRL_GENERIC && DM
+	help
+	  Supports pin multiplexing control on Spacemit K1 SoCs.
+
+	  The driver is controlled by a device tree node which contains both
+	  the GPIO definitions and pin control functions for each available
+	  multiplex function.
diff --git a/drivers/pinctrl/spacemit/Makefile b/drivers/pinctrl/spacemit/Makefile
new file mode 100644
index 00000000000..0dc43c72cb1
--- /dev/null
+++ b/drivers/pinctrl/spacemit/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y += pinctrl-k1.o
diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
new file mode 100644
index 00000000000..3ebc397213b
--- /dev/null
+++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
@@ -0,0 +1,546 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024 Yixun Lan <dlan@gentoo.org>
+ * Copyright (c) 2025-2026 RISCstar Ltd.
+ */
+
+#include <clk.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/pinctrl.h>
+#include <dm/read.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/io.h>
+
+/*
+ * +---------+----------+-----------+--------+--------+----------+--------+
+ * |   pull  |   drive  | schmitter |  slew  |  edge  |  strong  |   mux  |
+ * | up/down | strength |  trigger  |  rate  | detect |   pull   |  mode  |
+ * +---------+----------+-----------+--------+--------+----------+--------+
+ *   3 bits     3 bits     2 bits     1 bit    3 bits     1 bit    3 bits
+ */
+
+#define PAD_MUX			GENMASK(2, 0)
+#define PAD_STRONG_PULL		BIT(3)
+#define PAD_EDGE_RISE		BIT(4)
+#define PAD_EDGE_FALL		BIT(5)
+#define PAD_EDGE_CLEAR		BIT(6)
+#define PAD_SLEW_RATE		GENMASK(12, 11)
+#define PAD_SLEW_RATE_EN	BIT(7)
+#define PAD_SCHMITT		GENMASK(9, 8)
+#define PAD_DRIVE		GENMASK(12, 10)
+#define PAD_PULLDOWN		BIT(13)
+#define PAD_PULLUP		BIT(14)
+#define PAD_PULL_EN		BIT(15)
+
+#define PIN_POWER_STATE_1V8		1800
+#define PIN_POWER_STATE_3V3		3300
+
+enum spacemit_pin_io_type {
+	IO_TYPE_NONE = 0,
+	IO_TYPE_1V8,
+	IO_TYPE_3V3,
+	IO_TYPE_EXTERNAL,
+};
+
+struct spacemit_pin_io {
+	unsigned int	pin : 12;	// 0~4095
+	unsigned int	io_type : 4;	// 0~15
+	unsigned int	ds : 8;		// 0~255
+	unsigned int	reserved : 8;
+};
+
+struct spacemit_pinctrl_data {
+	struct spacemit_pin_io *io_pins;
+	int nr_io_pins;
+
+	void __iomem * (*pin_to_reg)(struct udevice *dev, unsigned int pin);
+	int (*get_gpio_mux)(struct udevice *dev, unsigned int pin);
+	int (*get_pins)(struct udevice *dev);
+	int (*get_functions)(struct udevice *dev);
+	int (*get_io_type)(struct udevice *dev, unsigned int pin);
+};
+
+struct spacemit_pinctrl_priv {
+	void __iomem		*regs;
+	struct spacemit_pin_io	*io_pins;
+	int			nr_io_pins;
+};
+
+struct spacemit_pin_mux_config {
+	const struct spacemit_pin	*pin;
+	u32				config;
+};
+
+struct spacemit_pin_drv_strength {
+	unsigned int	val : 8;
+	unsigned int	ma : 16;
+	unsigned int	reserved : 8;
+};
+
+static char pin_name[PINNAME_SIZE];
+
+/* External: IO voltage via external source, can be 1.8V or 3.3V */
+static struct spacemit_pin_io k1_io_pins[] = {
+	{ 47, IO_TYPE_EXTERNAL, 0, },
+	{ 48, IO_TYPE_EXTERNAL, 0, },
+	{ 49, IO_TYPE_EXTERNAL, 0, },
+	{ 50, IO_TYPE_EXTERNAL, 0, },
+	{ 51, IO_TYPE_EXTERNAL, 0, },
+	{ 52, IO_TYPE_EXTERNAL, 0, },
+	{ 75, IO_TYPE_EXTERNAL, 0, },
+	{ 76, IO_TYPE_EXTERNAL, 0, },
+	{ 77, IO_TYPE_EXTERNAL, 0, },
+	{ 78, IO_TYPE_EXTERNAL, 0, },
+	{ 79, IO_TYPE_EXTERNAL, 0, },
+	{ 80, IO_TYPE_EXTERNAL, 0, },
+	{ 98, IO_TYPE_EXTERNAL, 0, },
+	{ 99, IO_TYPE_EXTERNAL, 0, },
+	{ 100, IO_TYPE_EXTERNAL, 0, },
+	{ 101, IO_TYPE_EXTERNAL, 0, },
+	{ 102, IO_TYPE_EXTERNAL, 0, },
+	{ 103, IO_TYPE_EXTERNAL, 0, },
+	{ 104, IO_TYPE_EXTERNAL, 0, },
+	{ 105, IO_TYPE_EXTERNAL, 0, },
+	{ 106, IO_TYPE_EXTERNAL, 0, },
+	{ 107, IO_TYPE_EXTERNAL, 0, },
+	{ 108, IO_TYPE_EXTERNAL, 0, },
+	{ 109, IO_TYPE_EXTERNAL, 0, },
+};
+
+static inline int k1_get_pins(struct udevice *dev)
+{
+	return 128;
+}
+
+static inline int k1_get_functions(struct udevice *dev)
+{
+	return 7;
+}
+
+// The pin number equals to the gpio number.
+static void __iomem *k1_pin_to_reg(struct udevice *dev, unsigned int pin)
+{
+	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
+	unsigned int offset = 1;
+
+	if (pin < 86) {
+		offset += pin;
+	} else if (pin < 93) {
+		offset += pin + 36;
+	} else if (pin < 98) {
+		offset += pin + 23;
+	} else if (pin == 98) {		// QSPI_DAT3
+		offset += 92;
+	} else if (pin == 99) {		// QSPI_DAT2
+		offset += 91;
+	} else if (pin == 100) {	// QSPI_DAT1
+		offset += 90;
+	} else if (pin == 101) {	// QSPI_DAT0
+		offset += 89;
+	} else if (pin == 102) {	// QSPI_CLK
+		offset += 94;
+	} else if (pin == 103) {	// QSPI_CS1
+		offset += 93;
+	} else if (pin < 111) {
+		offset += pin + 5;
+	} else if (pin < 128) {
+		offset += pin + 19;
+	} else {
+		dev_err(dev, "Invalid pin (%u)\n", pin);
+		return NULL;
+	}
+	return priv->regs + (offset << 2);
+}
+
+static int k1_get_gpio_mux(struct udevice *dev, unsigned int selector)
+{
+	u32 mux = 0;
+
+	if (selector < 70) {
+		mux = 0;
+	} else if (selector < 74) {
+		mux = 1;
+	} else if (selector < 93) {
+		mux = 0;
+	} else if (selector < 104) {
+		mux = 1;
+	} else if (selector < 110) {
+		mux = 4;
+	} else if (selector < 128) {
+		mux = 0;
+	} else {
+		dev_err(dev, "Invalid pin (%u)\n", selector);
+		return -EINVAL;
+	}
+	return mux;
+}
+
+static int k1_get_io_type(struct udevice *dev, unsigned int selector)
+{
+	if (selector < 47)
+		return IO_TYPE_1V8;
+	else if (selector < 53)
+		return IO_TYPE_EXTERNAL;
+	else if (selector < 75)
+		return IO_TYPE_1V8;
+	else if (selector < 81)
+		return IO_TYPE_EXTERNAL;
+	else if (selector < 98)
+		return IO_TYPE_1V8;
+	else if (selector < 110)
+		return IO_TYPE_EXTERNAL;
+	else if (selector < 128)
+		return IO_TYPE_1V8;
+	return -EINVAL;
+}
+
+/* use IO high level output current as the table */
+static struct spacemit_pin_drv_strength spacemit_ds_1v8_tbl[4] = {
+	{ 0, 11 },
+	{ 2, 21 },
+	{ 4, 32 },
+	{ 6, 42 },
+};
+
+static struct spacemit_pin_drv_strength spacemit_ds_3v3_tbl[8] = {
+	{ 0,  7 },
+	{ 2, 10 },
+	{ 4, 13 },
+	{ 6, 16 },
+	{ 1, 19 },
+	{ 3, 23 },
+	{ 5, 26 },
+	{ 7, 29 },
+};
+
+static inline u8 spacemit_get_ds_value(struct spacemit_pin_drv_strength *tbl,
+				       u32 num, u32 ma)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		if (ma <= tbl[i].ma)
+			return tbl[i].val;
+
+	return tbl[num - 1].val;
+}
+
+static inline u32 spacemit_get_ds_ma(struct spacemit_pin_drv_strength *tbl,
+				     u32 num, u32 val)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		if (val == tbl[i].val)
+			return tbl[i].ma;
+
+	return 0;
+}
+
+static inline u8 spacemit_get_drive_strength(enum spacemit_pin_io_type type,
+					     u32 ma)
+{
+	switch (type) {
+	case IO_TYPE_1V8:
+		return spacemit_get_ds_value(spacemit_ds_1v8_tbl,
+					     ARRAY_SIZE(spacemit_ds_1v8_tbl),
+					     ma);
+	case IO_TYPE_3V3:
+		return spacemit_get_ds_value(spacemit_ds_3v3_tbl,
+					     ARRAY_SIZE(spacemit_ds_3v3_tbl),
+					     ma);
+	default:
+		return 0;
+	}
+}
+
+static inline u32 spacemit_get_drive_strength_ma(enum spacemit_pin_io_type type,
+						 u32 value)
+{
+	switch (type) {
+	case IO_TYPE_1V8:
+		return spacemit_get_ds_ma(spacemit_ds_1v8_tbl,
+					  ARRAY_SIZE(spacemit_ds_1v8_tbl),
+					  value & 0x6);
+	case IO_TYPE_3V3:
+		return spacemit_get_ds_ma(spacemit_ds_3v3_tbl,
+					  ARRAY_SIZE(spacemit_ds_3v3_tbl),
+					  value);
+	default:
+		return 0;
+	}
+}
+
+static inline u16 spacemit_dt_get_pin(u32 value)
+{
+	return value >> 16;
+}
+
+static inline u16 spacemit_dt_get_pin_mux(u32 value)
+{
+	return value & GENMASK(15, 0);
+}
+
+static int spacemit_get_pins_count(struct udevice *dev)
+{
+	struct spacemit_pinctrl_data *data;
+
+	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
+	if (!data || !data->get_pins)
+		return -EINVAL;
+	return data->get_pins(dev);
+}
+
+static const char *spacemit_get_pin_name(struct udevice *dev,
+					 unsigned int selector)
+{
+	struct spacemit_pinctrl_data *data;
+	unsigned int npins;
+
+	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
+	if (!data || !data->get_pins)
+		return NULL;
+	npins = data->get_pins(dev);
+
+	if (selector >= npins)
+		snprintf(pin_name, PINNAME_SIZE, "Error");
+	else
+		snprintf(pin_name, PINNAME_SIZE, "PIN%u", selector);
+
+	return pin_name;
+}
+
+static int spacemit_get_functions_count(struct udevice *dev)
+{
+	struct spacemit_pinctrl_data *data;
+
+	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
+	if (!data || !data->get_functions)
+		return -EINVAL;
+	return data->get_functions(dev);
+}
+
+static int spacemit_get_pin_muxing(struct udevice *dev, unsigned int pin,
+				   char *buf, int size)
+{
+	struct spacemit_pinctrl_data *data;
+	void __iomem *addr;
+	u32 mux, val;
+
+	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
+	if (!data || !data->pin_to_reg)
+		return -EINVAL;
+
+	addr = data->pin_to_reg(dev, pin);
+	if (!addr)
+		return -EINVAL;
+
+	val = readl(addr);
+	mux = val & PAD_MUX;
+	snprintf(buf, size, "[%p] 0x%08x MUX%d", addr, val, mux);
+	return 0;
+}
+
+static int spacemit_pinctrl_request_gpio(struct udevice *dev,
+					 unsigned int selector)
+{
+	struct spacemit_pinctrl_data *data;
+	void __iomem *addr;
+	int mux;
+
+	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
+	if (!data || !data->pin_to_reg || !data->get_gpio_mux)
+		return -EINVAL;
+	addr = data->pin_to_reg(dev, selector);
+	mux = data->get_gpio_mux(dev, selector);
+	if (mux < 0) {
+		dev_err(dev, "Invalid pin (%d)\n", selector);
+		return -EINVAL;
+	}
+	clrsetbits_le32(addr, PAD_MUX, mux & PAD_MUX);
+	return 0;
+}
+
+static int spacemit_pinctrl_free_gpio(struct udevice *dev,
+				      unsigned int selector)
+{
+	return 0;
+}
+
+static int spacemit_pinmux_set(struct udevice *dev, unsigned int pin,
+			       unsigned int mux)
+{
+	struct spacemit_pinctrl_data *data;
+	void __iomem *addr;
+
+	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
+	if (!data || !data->pin_to_reg)
+		return -EINVAL;
+	addr = data->pin_to_reg(dev, pin);
+	clrsetbits_le32(addr, PAD_MUX, mux & PAD_MUX);
+	return 0;
+}
+
+static int spacemit_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
+{
+	u32 pin, mux;
+
+	pin = spacemit_dt_get_pin(pinmux_group);
+	mux = spacemit_dt_get_pin_mux(pinmux_group);
+	return spacemit_pinmux_set(dev, pin, mux);
+}
+
+static const struct pinconf_param spacemit_pinconf_params[] = {
+	{ "bias-disable",	PIN_CONFIG_BIAS_DISABLE,	0 },
+	{ "bias-pull-down",	PIN_CONFIG_BIAS_PULL_DOWN,	1 },
+	{ "bias-pull-up",	PIN_CONFIG_BIAS_PULL_UP,	1 },
+	{ "drive-strength",	PIN_CONFIG_DRIVE_STRENGTH,	U32_MAX },
+	{ "power-source",	PIN_CONFIG_POWER_SOURCE,	U32_MAX },
+};
+
+static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
+				unsigned int param, unsigned int argument)
+{
+	struct spacemit_pinctrl_data *data;
+	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
+	void __iomem *addr;
+	u32 mask = 0;
+	unsigned int io_type;
+	u8 ds;
+	bool found;
+	int i;
+
+	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
+	if (!data || !data->pin_to_reg)
+		return -EINVAL;
+	addr = data->pin_to_reg(dev, pin_selector);
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		clrbits_le32(addr, PAD_PULLUP | PAD_PULLDOWN | PAD_PULL_EN);
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
+		clrsetbits_le32(addr, mask, PAD_PULLDOWN | PAD_PULL_EN);
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		mask = PAD_PULLDOWN | PAD_PULLUP | PAD_PULL_EN;
+		clrsetbits_le32(addr, mask, PAD_PULLUP | PAD_PULL_EN);
+		break;
+	case PIN_CONFIG_DRIVE_STRENGTH:
+		io_type = IO_TYPE_1V8;
+		for (i = 0; i < priv->nr_io_pins; i++) {
+			if (priv->io_pins[i].pin != pin_selector)
+				continue;
+			io_type = priv->io_pins[i].io_type;
+			break;
+		}
+		ds = spacemit_get_drive_strength(io_type, argument);
+		clrsetbits_le32(addr, PAD_DRIVE, ds);
+		break;
+	case PIN_CONFIG_POWER_SOURCE:
+		for (i = 0, found = false; i < priv->nr_io_pins; i++) {
+			if (priv->io_pins[i].pin != pin_selector)
+				continue;
+			if (argument == PIN_POWER_STATE_3V3) {
+				priv->io_pins[i].io_type = IO_TYPE_3V3;
+				found = true;
+			} else if (argument == PIN_POWER_STATE_1V8) {
+				priv->io_pins[i].io_type = IO_TYPE_1V8;
+				found = true;
+			}
+			break;
+		}
+		if (!found && argument != PIN_POWER_STATE_1V8) {
+			dev_err(dev, "Invalid power source (%d)\n", argument);
+			return -EINVAL;
+		}
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int spacemit_pinctrl_probe(struct udevice *dev)
+{
+	struct spacemit_pinctrl_data *data;
+	struct spacemit_pinctrl_priv *priv;
+	struct clk_bulk clks;
+	size_t size;
+	int ret;
+
+	data = (struct spacemit_pinctrl_data *)dev_get_driver_data(dev);
+	priv = dev_get_priv(dev);
+	priv->regs = dev_read_addr_ptr(dev);
+	if (!priv->regs) {
+		dev_err(dev, "Fail to get base address\n");
+		return -EINVAL;
+	}
+	priv->nr_io_pins = data->nr_io_pins;
+	size = priv->nr_io_pins * sizeof(struct spacemit_pin_io);
+	priv->io_pins = (struct spacemit_pin_io *)memdup(data->io_pins, size);
+	if (!priv->io_pins) {
+		dev_err(dev, "Fail to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	ret = clk_get_bulk(dev, &clks);
+	if (ret) {
+		dev_err(dev, "Fail to get bulk clks\n");
+		goto out_get_clk;
+	}
+	ret = clk_enable_bulk(&clks);
+	if (ret) {
+		dev_err(dev, "Fail to enable bulk clks\n");
+		goto out_clks;
+	}
+	return 0;
+out_clks:
+	clk_release_bulk(&clks);
+out_get_clk:
+	free(priv->io_pins);
+	return ret;
+}
+
+static const struct spacemit_pinctrl_data k1_pinctrl_data = {
+	.io_pins	= k1_io_pins,
+	.nr_io_pins	= ARRAY_SIZE(k1_io_pins),
+	.pin_to_reg	= k1_pin_to_reg,
+	.get_gpio_mux	= k1_get_gpio_mux,
+	.get_pins	= k1_get_pins,
+	.get_functions	= k1_get_functions,
+	.get_io_type	= k1_get_io_type,
+};
+
+static const struct udevice_id spacemit_pinctrl_ids[] = {
+	{
+		.compatible = "spacemit,k1-pinctrl",
+		.data = (uintptr_t)&k1_pinctrl_data,
+	}, { /* sentinel */ }
+};
+
+static const struct pinctrl_ops spacemit_pinctrl_ops = {
+	.get_pins_count		= spacemit_get_pins_count,
+	.get_pin_name		= spacemit_get_pin_name,
+	.get_functions_count	= spacemit_get_functions_count,
+	.get_pin_muxing		= spacemit_get_pin_muxing,
+	.set_state		= pinctrl_generic_set_state,
+	.gpio_request_enable	= spacemit_pinctrl_request_gpio,
+	.gpio_disable_free	= spacemit_pinctrl_free_gpio,
+	.pinmux_set		= spacemit_pinmux_set,
+	.pinmux_property_set	= spacemit_pinmux_property_set,
+	.pinconf_num_params	= ARRAY_SIZE(spacemit_pinconf_params),
+	.pinconf_params		= spacemit_pinconf_params,
+	.pinconf_set		= spacemit_pinconf_set,
+};
+
+U_BOOT_DRIVER(spacemit_pinctrl) = {
+	.name		= "spacemit_pinctrl",
+	.id		= UCLASS_PINCTRL,
+	.of_match	= spacemit_pinctrl_ids,
+	.ops		= &spacemit_pinctrl_ops,
+	.priv_auto	= sizeof(struct spacemit_pinctrl_priv),
+	.probe		= spacemit_pinctrl_probe,
+};
-- 
2.25.1

