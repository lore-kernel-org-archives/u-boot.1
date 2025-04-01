Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC60C36018
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 09:48:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0991681FEE;
	Tue,  1 Apr 2025 11:47:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q+k2qIzt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A348205A; Tue,  1 Apr 2025 11:47:53 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D66E81FC8
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 11:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43948f77f1aso37391675e9.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 02:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743500870; x=1744105670; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q2IDZ61TZf5EQZyBBcQIX4pmNql2K2cSpbXbC75vqIc=;
 b=Q+k2qIztxqsSzINiQSkUQOPBtTtLWYstsjDTH/YgvB6+ftbR8rN4ZN7kBGigEbauay
 7Wqkn2u/kRrV44niy7GJAOsSoua8ng8e3Os42QXh3zCptxjFyV4p6j7w399U3cstKwM+
 0Yqv0vZSoSQfJx6Ax44EavIpEgujq/UUyZgMKi6a0+7fVyFWcg2ClZ+AijVjBxnzOiS7
 gquqVwQwNZLbhGGHe6Zqt9LXwyku59sYa4ezA293MoM5UGgQboeGaBG4rfQAQ8D8speG
 48wuu9HMj5B9+x7xl+Jd1kyoH1JHgbBldh7tOBeazgZyN2KUeo8k77Na8HBUt5altLsa
 VQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743500870; x=1744105670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q2IDZ61TZf5EQZyBBcQIX4pmNql2K2cSpbXbC75vqIc=;
 b=hXOCxeFH9dRyr9yqfB4dafdY3HPW02I0HTpR8rtHdpCVneyjejGn+YHHqtVRLIPHbZ
 io8qbk3XWMO0dZV3FqiGTSCTNuWMUMg2jV9XkKzVEpkbRUSQEE+Ywr2JlRL1YOa0gywK
 pvyK3l2rWnq8sdZjmfnjXt+iYjATB4Fiqhu3Poc+k8u/pzONcQAvqnKVEaWxWnBZ4ldY
 5RNcNsTq6Bk6iLEJE29Mck1hmqGojXoneE0tp5scPregKczsv6MsY1PHnDuCpSd89hcb
 4ATt2GMHkMwpAceY4v7R5WaVpNlYvjdtPxYJLlnrc21WETRYphqXlnNCIwz7lNrelCq9
 CO2Q==
X-Gm-Message-State: AOJu0Yy3wC5e5Lzji3RDQcqf69B8A00yv9PvkQl8Q3Gno1BpU+RRT9Ub
 y5Vo/HPR+sfNIFtPzYBN8OjKDvX4lD6f037WSe2DP2SakS9urPs94K39hhNXfZwBrhNXY37jMM1
 K
X-Gm-Gg: ASbGncsmuria6FwHoOJoYswThVZFhsDAUPb+cseptf2f+X0apzgbKyWR4m+0Baew99V
 bB3fo1vABH6oUyqPNXTqYOxXNMNnHmj08PtbAqyXnJ7N/Pv2ytzDtoLZboI8mnrXGQIgHEzztGn
 K63sg1SWSqPyndQ08XHha6/v820KZBqKadLjomfZHm7jpEKsJksdoL9cg7kGEvUvlMLngHmHtsM
 p6cic50781CvPZHtcoQtmxapNBIj0JXkP1nWRUzml9StG2cnhQ2/JMspm0Vd7nNlbX9DgFgaWjN
 T7Mrbxel3Tw+iQmf76oFktyNOFNiHFHN6agAVZy6kAU+fBmHnrYUQh/7gySdSIrBpA==
X-Google-Smtp-Source: AGHT+IF+nqsA2TuVbNotrTTU9zDZjido3p6S0RZtwZ6IQUxDwv8HQsGxx04Df4JM2spHaFCiFvLvlg==
X-Received: by 2002:a05:6000:402a:b0:390:f9d0:5e4 with SMTP id
 ffacd0b85a97d-39c120de3f8mr8179913f8f.21.1743500870259; 
 Tue, 01 Apr 2025 02:47:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b6656a0sm13733581f8f.37.2025.04.01.02.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 02:47:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 01 Apr 2025 11:47:47 +0200
Subject: [PATCH RFC/RFT 1/2] gpio: qcom: add new driver for SPMI gpios
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-1-74077ef0b464@linaro.org>
References: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org>
In-Reply-To: <20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=32747;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qR0bwxQkDfW4fFQrTkGaq3tZPxT78WTkgVQ16b7p7PU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn67ZEOoy4a8k/oOGa0irHjjs7cKCvKu/qIJnqdEQY
 ha3pFhGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+u2RAAKCRB33NvayMhJ0TNFEA
 CklDGy6e/o9eA53BXRfvbbi7nX12PIqr2KFG9X60VrOYAfdYZ+cU9ON6E49CwxteA8PzvfCnlr5Zud
 w2jx+zeClBt0bdnCLQCO4ZUjledTpdaC7OIaU3ImsyLsC02eXR/SixdckiEm6e5uheOE0fJmDr8WPT
 vNwx886TxjvT2s+FtRCSFfEcZr4eDqZoSPh2OpLuCMGagSgR/M6hIzduZjav538jESHaYgN5op7FDB
 atNAk2hNDkkmjAGkD9aIY1rAED2xMwKIpGhA+5U6DW0RVIqPzXP9XfMNJmZBwuMuepg6YLTX7mEPqv
 KocT3MS0TilINHGCORibwCgXqyCDR/7ogTjHTbtGPg6WsieUkHLY0iU2CSs9A0b4E70cOhD5ySBwbh
 +efD9emJ98T87RJj4pRWOP7ByeMXPT5wP8hTxLob39iqXePrATOKah6qxCREvO544v4z5CMTAJ0WKV
 UlNiXLwYIwYbHEMI01U5zUbPB1RtITcLsyhnoxGIjIMjGERuSCJyZqSS6rNdhW7xe0s3AtW+QqhKog
 bvsAHMxHoThJ/f8G+E3a3T3JrtkKnKWpJclCCHjt7/xMGZc+ewTZVj5gk+S6GshP5miETbZpr15bvX
 LcPzeWRPkYiJuVGRPaC/AtgWvw1ca3xfnWGFvr8vAOhYfUK/n0/iREVIY8Iw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The current qcom_pmic_gpio driver is too limited and doesn't
support state tracking for all pins like the Linux driver.

Adding full pinconf support would require adding the state
and it's much simpler to restart from scratch with a new
driver based on the Linux one adapted to the U-Boot GPIO
and Pinctrl APIs.

For now only the PMICs I've been able to validate are
added in the compatible list but we should be able to
add the entire list from the Linux driver.

There's a few difference from the Linux driver:
- no IRQ support
- uses the U-Boot GPIO flags that maps very well
- uses the gpio-ranges to get the pins count
- no debugfs but prints the pin state via pinmux callback

It uses the same CONFIG entry as the old one, since
the ultimate goal is to migrate entirely on this new
driver once we verify it doesn't break the older
platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpio/Makefile         |    2 +-
 drivers/gpio/qcom_spmi_gpio.c | 1034 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1035 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index d426d3a2d7b1495a7b2b7bb743994282b0228a09..195e3e26913c81215e091aca10195b90ed43e861 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -65,7 +65,7 @@ obj-$(CONFIG_OCTEON_GPIO)	+= octeon_gpio.o
 obj-$(CONFIG_MVEBU_GPIO)	+= mvebu_gpio.o
 obj-$(CONFIG_MSM_GPIO)		+= msm_gpio.o
 obj-$(CONFIG_$(XPL_)PCF8575_GPIO)	+= pcf8575_gpio.o
-obj-$(CONFIG_$(PHASE_)QCOM_PMIC_GPIO)	+= qcom_pmic_gpio.o
+obj-$(CONFIG_$(PHASE_)QCOM_PMIC_GPIO)	+= qcom_pmic_gpio.o qcom_spmi_gpio.o
 obj-$(CONFIG_MT7620_GPIO)	+= mt7620_gpio.o
 obj-$(CONFIG_MT7621_GPIO)	+= mt7621_gpio.o
 obj-$(CONFIG_MSCC_SGPIO)	+= mscc_sgpio.o
diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
new file mode 100644
index 0000000000000000000000000000000000000000..2bb0f0d10c32ff55d3fd5c61b9bc2999878bfea6
--- /dev/null
+++ b/drivers/gpio/qcom_spmi_gpio.c
@@ -0,0 +1,1034 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Qualcomm generic pmic gpio driver
+ *
+ * Based on the original qcom_spmi_pmic_gpio driver from:
+ * Copyright (c) 2015 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>
+ *
+ * Updated from the Linux pinctrl-spmi-gpio driver from:
+ * Copyright (c) 2012-2014, 2016-2021 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <dm.h>
+#include <dm/device-internal.h>
+#include <dm/lists.h>
+#include <dm/pinctrl.h>
+#include <dm/device_compat.h>
+#include <log.h>
+#include <power/pmic.h>
+#include <spmi/spmi.h>
+#include <asm/io.h>
+#include <stdlib.h>
+#include <asm/gpio.h>
+#include <linux/bitops.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+#define PMIC_MAX_GPIOS				36
+
+#define PMIC_GPIO_ADDRESS_RANGE			0x100
+
+/* type and subtype registers base address offsets */
+#define PMIC_GPIO_REG_TYPE			0x4
+#define PMIC_GPIO_REG_SUBTYPE			0x5
+
+/* GPIO peripheral type and subtype out_values */
+#define PMIC_GPIO_TYPE				0x10
+#define PMIC_GPIO_SUBTYPE_GPIO_4CH		0x1
+#define PMIC_GPIO_SUBTYPE_GPIOC_4CH		0x5
+#define PMIC_GPIO_SUBTYPE_GPIO_8CH		0x9
+#define PMIC_GPIO_SUBTYPE_GPIOC_8CH		0xd
+#define PMIC_GPIO_SUBTYPE_GPIO_LV		0x10
+#define PMIC_GPIO_SUBTYPE_GPIO_MV		0x11
+#define PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2		0x12
+#define PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3		0x13
+
+#define PMIC_MPP_REG_RT_STS			0x10
+#define PMIC_MPP_REG_RT_STS_VAL_MASK		0x1
+
+/* control register base address offsets */
+#define PMIC_GPIO_REG_MODE_CTL			0x40
+#define PMIC_GPIO_REG_DIG_VIN_CTL		0x41
+#define PMIC_GPIO_REG_DIG_PULL_CTL		0x42
+#define PMIC_GPIO_REG_LV_MV_DIG_OUT_SOURCE_CTL	0x44
+	#define PMIC_GPIO_REG_DIG_IN_CTL		0x43
+#define PMIC_GPIO_REG_DIG_OUT_CTL		0x45
+#define PMIC_GPIO_REG_EN_CTL			0x46
+	#define PMIC_GPIO_REG_LV_MV_ANA_PASS_THRU_SEL	0x4A
+
+/* PMIC_GPIO_REG_MODE_CTL */
+#define PMIC_GPIO_REG_MODE_VALUE_SHIFT		0x1
+#define PMIC_GPIO_REG_MODE_FUNCTION_SHIFT	1
+#define PMIC_GPIO_REG_MODE_FUNCTION_MASK	0x7
+#define PMIC_GPIO_REG_MODE_DIR_SHIFT		4
+#define PMIC_GPIO_REG_MODE_DIR_MASK		0x7
+
+#define PMIC_GPIO_MODE_DIGITAL_INPUT		0
+#define PMIC_GPIO_MODE_DIGITAL_OUTPUT		1
+#define PMIC_GPIO_MODE_DIGITAL_INPUT_OUTPUT	2
+#define PMIC_GPIO_MODE_ANALOG_PASS_THRU		3
+#define PMIC_GPIO_REG_LV_MV_MODE_DIR_MASK	0x3
+
+/* PMIC_GPIO_REG_DIG_VIN_CTL */
+#define PMIC_GPIO_REG_VIN_SHIFT			0
+#define PMIC_GPIO_REG_VIN_MASK			0x7
+
+/* PMIC_GPIO_REG_DIG_PULL_CTL */
+#define PMIC_GPIO_REG_PULL_SHIFT		0
+#define PMIC_GPIO_REG_PULL_MASK			0x7
+
+#define PMIC_GPIO_PULL_DOWN			4
+#define PMIC_GPIO_PULL_DISABLE			5
+
+/* PMIC_GPIO_REG_LV_MV_DIG_OUT_SOURCE_CTL for LV/MV */
+#define PMIC_GPIO_LV_MV_OUTPUT_INVERT		0x80
+#define PMIC_GPIO_LV_MV_OUTPUT_INVERT_SHIFT	7
+#define PMIC_GPIO_LV_MV_OUTPUT_SOURCE_SEL_MASK	0xF
+
+/* PMIC_GPIO_REG_DIG_IN_CTL */
+#define PMIC_GPIO_LV_MV_DIG_IN_DTEST_EN		0x80
+#define PMIC_GPIO_LV_MV_DIG_IN_DTEST_SEL_MASK	0x7
+#define PMIC_GPIO_DIG_IN_DTEST_SEL_MASK		0xf
+
+/* PMIC_GPIO_REG_DIG_OUT_CTL */
+#define PMIC_GPIO_REG_OUT_STRENGTH_SHIFT	0
+#define PMIC_GPIO_REG_OUT_STRENGTH_MASK		0x3
+#define PMIC_GPIO_REG_OUT_TYPE_SHIFT		4
+#define PMIC_GPIO_REG_OUT_TYPE_MASK		0x3
+
+/*
+ * Output type - indicates pin should be configured as push-pull,
+ * open drain or open source.
+ */
+#define PMIC_GPIO_OUT_BUF_CMOS			0
+#define PMIC_GPIO_OUT_BUF_OPEN_DRAIN_NMOS	1
+#define PMIC_GPIO_OUT_BUF_OPEN_DRAIN_PMOS	2
+
+#define PMIC_GPIO_OUT_STRENGTH_LOW		1
+#define PMIC_GPIO_OUT_STRENGTH_HIGH		3
+
+/* PMIC_GPIO_REG_EN_CTL */
+#define PMIC_GPIO_REG_MASTER_EN_SHIFT		7
+
+#define PMIC_GPIO_PHYSICAL_OFFSET		1
+
+/* PMIC_GPIO_REG_LV_MV_ANA_PASS_THRU_SEL */
+#define PMIC_GPIO_LV_MV_ANA_MUX_SEL_MASK		0x3
+
+/* The index of each function in spmi_pmic_gpio_functions[] array */
+enum spmi_pmic_gpio_func_index {
+	PMIC_GPIO_FUNC_INDEX_NORMAL,
+	PMIC_GPIO_FUNC_INDEX_PAIRED,
+	PMIC_GPIO_FUNC_INDEX_FUNC1,
+	PMIC_GPIO_FUNC_INDEX_FUNC2,
+	PMIC_GPIO_FUNC_INDEX_FUNC3,
+	PMIC_GPIO_FUNC_INDEX_FUNC4,
+	PMIC_GPIO_FUNC_INDEX_DTEST1,
+	PMIC_GPIO_FUNC_INDEX_DTEST2,
+	PMIC_GPIO_FUNC_INDEX_DTEST3,
+	PMIC_GPIO_FUNC_INDEX_DTEST4,
+};
+
+static const char *const spmi_pmic_gpio_functions[] = {
+	[PMIC_GPIO_FUNC_INDEX_NORMAL]	= PMIC_GPIO_FUNC_NORMAL,
+	[PMIC_GPIO_FUNC_INDEX_PAIRED]	= PMIC_GPIO_FUNC_PAIRED,
+	[PMIC_GPIO_FUNC_INDEX_FUNC1]	= PMIC_GPIO_FUNC_FUNC1,
+	[PMIC_GPIO_FUNC_INDEX_FUNC2]	= PMIC_GPIO_FUNC_FUNC2,
+	[PMIC_GPIO_FUNC_INDEX_FUNC3]	= PMIC_GPIO_FUNC_FUNC3,
+	[PMIC_GPIO_FUNC_INDEX_FUNC4]	= PMIC_GPIO_FUNC_FUNC4,
+	[PMIC_GPIO_FUNC_INDEX_DTEST1]	= PMIC_GPIO_FUNC_DTEST1,
+	[PMIC_GPIO_FUNC_INDEX_DTEST2]	= PMIC_GPIO_FUNC_DTEST2,
+	[PMIC_GPIO_FUNC_INDEX_DTEST3]	= PMIC_GPIO_FUNC_DTEST3,
+	[PMIC_GPIO_FUNC_INDEX_DTEST4]	= PMIC_GPIO_FUNC_DTEST4,
+};
+
+/**
+ * struct spmi_pmic_gpio_pad - keep current GPIO settings
+ * @base: Address base in SPMI device.
+ * @is_enabled: Set to false when GPIO should be put in high Z state.
+ * @out_value: Cached pin output value
+ * @have_buffer: Set to true if GPIO output could be configured in push-pull,
+ *	open-drain or open-source mode.
+ * @output_enabled: Set to true if GPIO output logic is enabled.
+ * @input_enabled: Set to true if GPIO input buffer logic is enabled.
+ * @analog_pass: Set to true if GPIO is in analog-pass-through mode.
+ * @lv_mv_type: Set to true if GPIO subtype is GPIO_LV(0x10) or GPIO_MV(0x11).
+ * @num_sources: Number of power-sources supported by this GPIO.
+ * @power_source: Current power-source used.
+ * @buffer_type: Push-pull, open-drain or open-source.
+ * @pullup: Constant current which flow trough GPIO output buffer.
+ * @strength: No, Low, Medium, High
+ * @function: See spmi_pmic_gpio_functions[]
+ * @atest: the ATEST selection for GPIO analog-pass-through mode
+ * @dtest_buffer: the DTEST buffer selection for digital input mode.
+ */
+struct spmi_pmic_gpio_pad {
+	u16		base;
+	bool		is_enabled;
+	bool		out_value;
+	bool		have_buffer;
+	bool		output_enabled;
+	bool		input_enabled;
+	bool		analog_pass;
+	bool		lv_mv_type;
+	unsigned int	num_sources;
+	unsigned int	power_source;
+	unsigned int	buffer_type;
+	unsigned int	pullup;
+	unsigned int	strength;
+	unsigned int	function;
+	unsigned int	atest;
+	unsigned int	dtest_buffer;
+};
+
+struct qcom_spmi_pmic_gpio_data {
+	struct udevice *dev;
+	u32 pid; /* Peripheral ID on SPMI bus */
+	struct udevice *pmic; /* Reference to pmic device for read/write */
+	u32 pin_count;
+	struct spmi_pmic_gpio_pad *pads;
+};
+
+static int qcom_spmi_pmic_pinctrl_pinconf_set(struct udevice *dev, unsigned int selector,
+					      unsigned int param, unsigned int arg);
+
+static int spmi_pmic_gpio_read(struct qcom_spmi_pmic_gpio_data *plat,
+			       struct spmi_pmic_gpio_pad *pad,
+			       unsigned int addr)
+{
+	return pmic_reg_read(plat->pmic, pad->base + addr);
+}
+
+static int spmi_pmic_gpio_write(struct qcom_spmi_pmic_gpio_data *plat,
+				struct spmi_pmic_gpio_pad *pad,
+				unsigned int addr, unsigned int val)
+{
+	return pmic_reg_write(plat->pmic, pad->base + addr, val);
+}
+
+static void spmi_pmic_gpio_get_state(struct qcom_spmi_pmic_gpio_data *plat,
+				     struct spmi_pmic_gpio_pad *pad,
+				     char *buf, int size)
+{
+	int ret, val, function, cnt;
+
+	static const char *const biases[] = {
+		"pull-up 30uA", "pull-up 1.5uA", "pull-up 31.5uA",
+		"pull-up 1.5uA + 30uA boost", "pull-down 10uA", "no pull"
+	};
+	static const char *const buffer_types[] = {
+		"push-pull", "open-drain", "open-source"
+	};
+	static const char *const strengths[] = {
+		"no", "low", "medium", "high"
+	};
+
+	val = spmi_pmic_gpio_read(plat, pad, PMIC_GPIO_REG_EN_CTL);
+
+	if (val < 0 || !(val >> PMIC_GPIO_REG_MASTER_EN_SHIFT)) {
+		cnt = snprintf(buf, size, "disabled");
+	} else {
+		if (pad->input_enabled) {
+			ret = spmi_pmic_gpio_read(plat, pad, PMIC_MPP_REG_RT_STS);
+			if (ret < 0)
+				return;
+
+			ret &= PMIC_MPP_REG_RT_STS_VAL_MASK;
+			pad->out_value = ret;
+		}
+		/*
+		 * For the non-LV/MV subtypes only 2 special functions are
+		 * available, offsetting the dtest function values by 2.
+		 */
+		function = pad->function;
+		if (!pad->lv_mv_type &&
+		    pad->function >= PMIC_GPIO_FUNC_INDEX_FUNC3)
+			function += PMIC_GPIO_FUNC_INDEX_DTEST1 -
+				PMIC_GPIO_FUNC_INDEX_FUNC3;
+
+		if (pad->analog_pass)
+			cnt = snprintf(buf, size, "analog-pass");
+		else
+			cnt = snprintf(buf, size, "%-4s",
+				       pad->output_enabled ? "out" : "in");
+		buf += cnt;
+		size -= cnt;
+
+		snprintf(buf, size, " %-4s %-7s vin-%d %-27s %-10s %-7s atest-%d dtest-%d",
+			 pad->out_value ? "high" : "low",
+			 spmi_pmic_gpio_functions[function],
+			 pad->power_source,
+			 biases[pad->pullup],
+			 buffer_types[pad->buffer_type],
+			 strengths[pad->strength],
+			 pad->atest,
+			 pad->dtest_buffer);
+	}
+}
+
+static int qcom_spmi_pmic_gpio_set(struct qcom_spmi_pmic_gpio_data *plat,
+				   struct spmi_pmic_gpio_pad *pad)
+{
+	unsigned int val;
+	int ret;
+
+	val = pad->power_source << PMIC_GPIO_REG_VIN_SHIFT;
+
+	ret = spmi_pmic_gpio_write(plat, pad, PMIC_GPIO_REG_DIG_VIN_CTL, val);
+	if (ret < 0)
+		return ret;
+
+	val = pad->pullup << PMIC_GPIO_REG_PULL_SHIFT;
+
+	ret = spmi_pmic_gpio_write(plat, pad, PMIC_GPIO_REG_DIG_PULL_CTL, val);
+	if (ret < 0)
+		return ret;
+
+	val = pad->buffer_type << PMIC_GPIO_REG_OUT_TYPE_SHIFT;
+	val |= pad->strength << PMIC_GPIO_REG_OUT_STRENGTH_SHIFT;
+
+	ret = spmi_pmic_gpio_write(plat, pad, PMIC_GPIO_REG_DIG_OUT_CTL, val);
+	if (ret < 0)
+		return ret;
+
+	if (pad->dtest_buffer == 0) {
+		val = 0;
+	} else {
+		if (pad->lv_mv_type) {
+			val = pad->dtest_buffer - 1;
+			val |= PMIC_GPIO_LV_MV_DIG_IN_DTEST_EN;
+		} else {
+			val = BIT(pad->dtest_buffer - 1);
+		}
+	}
+	ret = spmi_pmic_gpio_write(plat, pad, PMIC_GPIO_REG_DIG_IN_CTL, val);
+	if (ret < 0)
+		return ret;
+
+	if (pad->analog_pass)
+		val = PMIC_GPIO_MODE_ANALOG_PASS_THRU;
+	else if (pad->output_enabled && pad->input_enabled)
+		val = PMIC_GPIO_MODE_DIGITAL_INPUT_OUTPUT;
+	else if (pad->output_enabled)
+		val = PMIC_GPIO_MODE_DIGITAL_OUTPUT;
+	else
+		val = PMIC_GPIO_MODE_DIGITAL_INPUT;
+
+	if (pad->lv_mv_type) {
+		ret = spmi_pmic_gpio_write(plat, pad,
+					   PMIC_GPIO_REG_MODE_CTL, val);
+		if (ret < 0)
+			return ret;
+
+		val = pad->atest - 1;
+		ret = spmi_pmic_gpio_write(plat, pad,
+					   PMIC_GPIO_REG_LV_MV_ANA_PASS_THRU_SEL,
+					   val);
+		if (ret < 0)
+			return ret;
+
+		val = pad->out_value
+			<< PMIC_GPIO_LV_MV_OUTPUT_INVERT_SHIFT;
+		val |= pad->function
+			& PMIC_GPIO_LV_MV_OUTPUT_SOURCE_SEL_MASK;
+		ret = spmi_pmic_gpio_write(plat, pad,
+					   PMIC_GPIO_REG_LV_MV_DIG_OUT_SOURCE_CTL,
+					   val);
+		if (ret < 0)
+			return ret;
+	} else {
+		val = val << PMIC_GPIO_REG_MODE_DIR_SHIFT;
+		val |= pad->function << PMIC_GPIO_REG_MODE_FUNCTION_SHIFT;
+		val |= pad->out_value & PMIC_GPIO_REG_MODE_VALUE_SHIFT;
+
+		ret = spmi_pmic_gpio_write(plat, pad, PMIC_GPIO_REG_MODE_CTL, val);
+		if (ret < 0)
+			return ret;
+	}
+
+	val = pad->is_enabled << PMIC_GPIO_REG_MASTER_EN_SHIFT;
+
+	ret = spmi_pmic_gpio_write(plat, pad, PMIC_GPIO_REG_EN_CTL, val);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int spmi_pmic_gpio_populate(struct qcom_spmi_pmic_gpio_data *plat,
+				   struct spmi_pmic_gpio_pad *pad)
+{
+	int type, subtype, val, dir;
+
+	type = spmi_pmic_gpio_read(plat, pad, PMIC_GPIO_REG_TYPE);
+	if (type < 0)
+		return type;
+
+	if (type != PMIC_GPIO_TYPE) {
+		dev_err(plat->dev, "incorrect block type 0x%x at 0x%x\n",
+			type, pad->base);
+		return -ENODEV;
+	}
+
+	subtype = spmi_pmic_gpio_read(plat, pad, PMIC_GPIO_REG_SUBTYPE);
+	if (subtype < 0)
+		return subtype;
+
+	switch (subtype) {
+	case PMIC_GPIO_SUBTYPE_GPIO_4CH:
+		pad->have_buffer = true;
+		fallthrough;
+	case PMIC_GPIO_SUBTYPE_GPIOC_4CH:
+		pad->num_sources = 4;
+		break;
+	case PMIC_GPIO_SUBTYPE_GPIO_8CH:
+		pad->have_buffer = true;
+		fallthrough;
+	case PMIC_GPIO_SUBTYPE_GPIOC_8CH:
+		pad->num_sources = 8;
+		break;
+	case PMIC_GPIO_SUBTYPE_GPIO_LV:
+		pad->num_sources = 1;
+		pad->have_buffer = true;
+		pad->lv_mv_type = true;
+		break;
+	case PMIC_GPIO_SUBTYPE_GPIO_MV:
+		pad->num_sources = 2;
+		pad->have_buffer = true;
+		pad->lv_mv_type = true;
+		break;
+	case PMIC_GPIO_SUBTYPE_GPIO_LV_VIN2:
+		pad->num_sources = 2;
+		pad->have_buffer = true;
+		pad->lv_mv_type = true;
+		break;
+	case PMIC_GPIO_SUBTYPE_GPIO_MV_VIN3:
+		pad->num_sources = 3;
+		pad->have_buffer = true;
+		pad->lv_mv_type = true;
+		break;
+	default:
+		dev_err(plat->dev, "unknown GPIO type 0x%x\n", subtype);
+		return -ENODEV;
+	}
+
+	if (pad->lv_mv_type) {
+		val = spmi_pmic_gpio_read(plat, pad,
+					  PMIC_GPIO_REG_LV_MV_DIG_OUT_SOURCE_CTL);
+		if (val < 0)
+			return val;
+
+		pad->out_value = !!(val & PMIC_GPIO_LV_MV_OUTPUT_INVERT);
+		pad->function = val & PMIC_GPIO_LV_MV_OUTPUT_SOURCE_SEL_MASK;
+
+		val = spmi_pmic_gpio_read(plat, pad, PMIC_GPIO_REG_MODE_CTL);
+		if (val < 0)
+			return val;
+
+		dir = val & PMIC_GPIO_REG_LV_MV_MODE_DIR_MASK;
+	} else {
+		val = spmi_pmic_gpio_read(plat, pad, PMIC_GPIO_REG_MODE_CTL);
+		if (val < 0)
+			return val;
+
+		pad->out_value = val & PMIC_GPIO_REG_MODE_VALUE_SHIFT;
+
+		dir = val >> PMIC_GPIO_REG_MODE_DIR_SHIFT;
+		dir &= PMIC_GPIO_REG_MODE_DIR_MASK;
+		pad->function = val >> PMIC_GPIO_REG_MODE_FUNCTION_SHIFT;
+		pad->function &= PMIC_GPIO_REG_MODE_FUNCTION_MASK;
+	}
+
+	switch (dir) {
+	case PMIC_GPIO_MODE_DIGITAL_INPUT:
+		pad->input_enabled = true;
+		pad->output_enabled = false;
+		break;
+	case PMIC_GPIO_MODE_DIGITAL_OUTPUT:
+		pad->input_enabled = false;
+		pad->output_enabled = true;
+		break;
+	case PMIC_GPIO_MODE_DIGITAL_INPUT_OUTPUT:
+		pad->input_enabled = true;
+		pad->output_enabled = true;
+		break;
+	case PMIC_GPIO_MODE_ANALOG_PASS_THRU:
+		if (!pad->lv_mv_type)
+			return -ENODEV;
+		pad->analog_pass = true;
+		break;
+	default:
+		dev_err(plat->dev, "unknown GPIO direction\n");
+		return -ENODEV;
+	}
+
+	val = spmi_pmic_gpio_read(plat, pad, PMIC_GPIO_REG_DIG_VIN_CTL);
+	if (val < 0)
+		return val;
+
+	pad->power_source = val >> PMIC_GPIO_REG_VIN_SHIFT;
+	pad->power_source &= PMIC_GPIO_REG_VIN_MASK;
+
+	val = spmi_pmic_gpio_read(plat, pad, PMIC_GPIO_REG_DIG_PULL_CTL);
+	if (val < 0)
+		return val;
+
+	pad->pullup = val >> PMIC_GPIO_REG_PULL_SHIFT;
+	pad->pullup &= PMIC_GPIO_REG_PULL_MASK;
+
+	val = spmi_pmic_gpio_read(plat, pad, PMIC_GPIO_REG_DIG_IN_CTL);
+	if (val < 0)
+		return val;
+
+	if (pad->lv_mv_type && (val & PMIC_GPIO_LV_MV_DIG_IN_DTEST_EN))
+		pad->dtest_buffer =
+			(val & PMIC_GPIO_LV_MV_DIG_IN_DTEST_SEL_MASK) + 1;
+	else if (!pad->lv_mv_type)
+		pad->dtest_buffer = ffs(val);
+	else
+		pad->dtest_buffer = 0;
+
+	val = spmi_pmic_gpio_read(plat, pad, PMIC_GPIO_REG_DIG_OUT_CTL);
+	if (val < 0)
+		return val;
+
+	pad->strength = val >> PMIC_GPIO_REG_OUT_STRENGTH_SHIFT;
+	pad->strength &= PMIC_GPIO_REG_OUT_STRENGTH_MASK;
+
+	pad->buffer_type = val >> PMIC_GPIO_REG_OUT_TYPE_SHIFT;
+	pad->buffer_type &= PMIC_GPIO_REG_OUT_TYPE_MASK;
+
+	if (pad->lv_mv_type) {
+		val = spmi_pmic_gpio_read(plat, pad,
+					  PMIC_GPIO_REG_LV_MV_ANA_PASS_THRU_SEL);
+		if (val < 0)
+			return val;
+
+		pad->atest = (val & PMIC_GPIO_LV_MV_ANA_MUX_SEL_MASK) + 1;
+	}
+
+	/* Pin could be disabled with PIN_CONFIG_BIAS_HIGH_IMPEDANCE */
+	pad->is_enabled = true;
+	return 0;
+}
+
+static int qcom_spmi_pmic_gpio_set_flags(struct udevice *dev, unsigned int offset, ulong flags)
+{
+	struct qcom_spmi_pmic_gpio_data *plat = dev_get_plat(dev);
+	struct spmi_pmic_gpio_pad *pad;
+
+	if (offset >= plat->pin_count)
+		return -EINVAL;
+
+	pad = &plat->pads[offset];
+
+	pad->input_enabled = flags & GPIOD_IS_IN;
+	pad->output_enabled = flags & GPIOD_IS_OUT;
+
+	if (pad->output_enabled) {
+		pad->out_value = flags & GPIOD_IS_OUT_ACTIVE;
+
+		if ((flags & GPIOD_OPEN_DRAIN) && pad->have_buffer)
+			pad->buffer_type = PMIC_GPIO_OUT_BUF_OPEN_DRAIN_NMOS;
+		else if ((flags & GPIOD_OPEN_SOURCE) && pad->have_buffer)
+			pad->buffer_type = PMIC_GPIO_OUT_BUF_OPEN_DRAIN_PMOS;
+		else
+			pad->buffer_type = PMIC_GPIO_OUT_BUF_CMOS;
+	}
+
+	if (flags & GPIOD_PULL_UP)
+		pad->pullup = PMIC_GPIO_PULL_UP_30;
+	else if (flags & GPIOD_PULL_DOWN)
+		pad->pullup = PMIC_GPIO_PULL_DOWN;
+
+	return qcom_spmi_pmic_gpio_set(plat, pad);
+}
+
+static int qcom_spmi_pmic_gpio_get_flags(struct udevice *dev, unsigned int offset,
+					 ulong *flagsp)
+{
+	struct qcom_spmi_pmic_gpio_data *plat = dev_get_plat(dev);
+	struct spmi_pmic_gpio_pad *pad;
+	ulong flags = 0;
+
+	if (offset >= plat->pin_count)
+		return -EINVAL;
+
+	pad = &plat->pads[offset];
+
+	if (pad->input_enabled)
+		flags |= GPIOD_IS_IN;
+
+	if (pad->output_enabled) {
+		flags |= GPIOD_IS_OUT;
+
+		if (pad->out_value)
+			flags |= GPIOD_IS_OUT_ACTIVE;
+
+		switch (pad->buffer_type) {
+		case PMIC_GPIO_OUT_BUF_OPEN_DRAIN_NMOS:
+			flags |= GPIOD_OPEN_DRAIN;
+			break;
+		case PMIC_GPIO_OUT_BUF_OPEN_DRAIN_PMOS:
+			flags |= GPIOD_OPEN_SOURCE;
+			break;
+		}
+	}
+
+	if (pad->pullup == PMIC_GPIO_PULL_DOWN)
+		flags |= GPIOD_PULL_DOWN;
+	else if (pad->pullup != PMIC_GPIO_PULL_DISABLE)
+		flags |= GPIOD_PULL_UP;
+
+	if (pad->analog_pass)
+		flags |= GPIOD_IS_AF;
+
+	*flagsp = flags;
+
+	return 0;
+}
+
+static int qcom_spmi_pmic_gpio_get_value(struct udevice *dev, unsigned int offset)
+{
+	struct qcom_spmi_pmic_gpio_data *plat = dev_get_plat(dev);
+	struct spmi_pmic_gpio_pad *pad;
+	int ret;
+
+	if (offset >= plat->pin_count)
+		return -EINVAL;
+
+	pad = &plat->pads[offset];
+
+	if (!pad->is_enabled)
+		return -EINVAL;
+
+	if (pad->input_enabled) {
+		ret = spmi_pmic_gpio_read(plat, pad, PMIC_MPP_REG_RT_STS);
+		if (ret < 0)
+			return ret;
+
+		pad->out_value = ret & PMIC_MPP_REG_RT_STS_VAL_MASK;
+	}
+
+	return !!pad->out_value;
+}
+
+static int qcom_spmi_pmic_gpio_get_function(struct udevice *dev, unsigned int offset)
+{
+	struct qcom_spmi_pmic_gpio_data *plat = dev_get_plat(dev);
+	struct spmi_pmic_gpio_pad *pad;
+	int val;
+
+	if (offset >= plat->pin_count)
+		return GPIOF_UNKNOWN;
+
+	pad = &plat->pads[offset];
+
+	val = spmi_pmic_gpio_read(plat, pad, PMIC_GPIO_REG_EN_CTL);
+	if (!(val >> PMIC_GPIO_REG_MASTER_EN_SHIFT))
+		return GPIOF_UNKNOWN;
+	else if (pad->analog_pass)
+		return GPIOF_FUNC;
+	else if (pad->output_enabled)
+		return GPIOF_OUTPUT;
+
+	return GPIOF_INPUT;
+}
+
+static int qcom_spmi_pmic_gpio_xlate(struct udevice *dev, struct gpio_desc *desc,
+				     struct ofnode_phandle_args *args)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+
+	if (args->args_count < 1)
+		return -EINVAL;
+
+	/* GPIOs in DT are 1-based */
+	desc->offset = args->args[0] - 1;
+	if (desc->offset >= uc_priv->gpio_count)
+		return -EINVAL;
+
+	if (args->args_count < 2)
+		return 0;
+
+	desc->flags = gpio_flags_xlate(args->args[1]);
+
+	return 0;
+}
+
+static const struct dm_gpio_ops qcom_spmi_pmic_gpio_ops = {
+	.set_flags		= qcom_spmi_pmic_gpio_set_flags,
+	.get_flags		= qcom_spmi_pmic_gpio_get_flags,
+	.get_value		= qcom_spmi_pmic_gpio_get_value,
+	.get_function		= qcom_spmi_pmic_gpio_get_function,
+	.xlate			= qcom_spmi_pmic_gpio_xlate,
+};
+
+static int qcom_spmi_pmic_gpio_bind(struct udevice *dev)
+{
+	struct qcom_spmi_pmic_gpio_data *plat = dev_get_plat(dev);
+	struct udevice *child;
+	struct driver *drv;
+	int ret;
+
+	drv = lists_driver_lookup_name("qcom_spmi_pmic_pinctrl");
+	if (!drv) {
+		log_warning("Cannot find driver '%s'\n", "qcom_spmi_pmic_pinctrl");
+		return -ENOENT;
+	}
+
+	/* Bind the GPIO driver as a child of the PMIC. */
+	ret = device_bind_with_driver_data(dev, drv,
+					   dev->name,
+					   0, dev_ofnode(dev), &child);
+	if (ret)
+		return log_msg_ret("bind", ret);
+
+	dev_set_plat(child, plat);
+
+	return 0;
+}
+
+static int qcom_spmi_pmic_gpio_probe(struct udevice *dev)
+{
+	struct gpio_dev_priv *uc_priv = dev_get_uclass_priv(dev);
+	struct qcom_spmi_pmic_gpio_data *plat = dev_get_plat(dev);
+	struct ofnode_phandle_args args;
+	int i, ret;
+	u64 pid;
+
+	plat->dev = dev;
+	plat->pmic = dev->parent;
+
+	pid = dev_read_addr(dev);
+	if (pid == FDT_ADDR_T_NONE)
+		return log_msg_ret("bad address", -EINVAL);
+
+	plat->pid = pid;
+
+	/*
+	 * Parse basic GPIO count specified via the gpio-ranges property
+	 * as specified in upstream devicetrees
+	 */
+	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev), "gpio-ranges",
+					     NULL, 3, 0, &args);
+	if (ret)
+		return log_msg_ret("gpio-ranges", ret);
+
+	plat->pin_count = min_t(u32, args.args[2], PMIC_MAX_GPIOS);
+
+	uc_priv->gpio_count = plat->pin_count;
+
+	uc_priv->bank_name = strchr(dev_read_string(dev, "compatible"), ',');
+	if (uc_priv->bank_name)
+		uc_priv->bank_name += 1; /* skip the , */
+	else
+		uc_priv->bank_name = dev->name;
+
+	plat->pads = calloc(plat->pin_count, sizeof(struct spmi_pmic_gpio_pad));
+	if (!plat->pads)
+		return -ENOMEM;
+
+	for (i = 0; i < plat->pin_count; ++i) {
+		struct spmi_pmic_gpio_pad *pad = &plat->pads[i];
+
+		pad->base = plat->pid + i * PMIC_GPIO_ADDRESS_RANGE;
+
+		ret = spmi_pmic_gpio_populate(plat, pad);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
+	{ .compatible = "qcom,pm8550b-gpio" },
+	{ .compatible = "qcom,pm8550ve-gpio" },
+	{ .compatible = "qcom,pm8550vs-gpio" },
+	{ .compatible = "qcom,pmk8550-gpio" },
+	{ .compatible = "qcom,pmr735d-gpio" },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_spmi_pmic_gpio) = {
+	.name	= "qcom_spmi_pmic_gpio",
+	.id	= UCLASS_GPIO,
+	.of_match = qcom_spmi_pmic_gpio_ids,
+	.bind	= qcom_spmi_pmic_gpio_bind,
+	.probe = qcom_spmi_pmic_gpio_probe,
+	.ops	= &qcom_spmi_pmic_gpio_ops,
+	.plat_auto = sizeof(struct qcom_spmi_pmic_gpio_data),
+	.flags = DM_FLAG_ALLOC_PDATA,
+};
+
+/* Qualcomm specific pin configurations */
+#define PMIC_GPIO_CONF_PULL_UP			(PIN_CONFIG_END + 1)
+#define PMIC_GPIO_CONF_STRENGTH			(PIN_CONFIG_END + 2)
+#define PMIC_GPIO_CONF_ATEST			(PIN_CONFIG_END + 3)
+#define PMIC_GPIO_CONF_ANALOG_PASS		(PIN_CONFIG_END + 4)
+#define PMIC_GPIO_CONF_DTEST_BUFFER		(PIN_CONFIG_END + 5)
+
+static const struct pinconf_param qcom_spmi_pmic_pinctrl_conf_params[] = {
+	{ "drive-push-pull", PIN_CONFIG_DRIVE_PUSH_PULL, 0 },
+	{ "drive-open-drain", PIN_CONFIG_DRIVE_OPEN_DRAIN, 0 },
+	{ "drive-open-source", PIN_CONFIG_DRIVE_OPEN_SOURCE, 0 },
+	{ "bias-disable", PIN_CONFIG_BIAS_DISABLE, 0 },
+	{ "bias-pull-up", PIN_CONFIG_BIAS_PULL_UP, PMIC_GPIO_PULL_UP_30 },
+	{ "bias-pull-down", PIN_CONFIG_BIAS_PULL_UP, 0 },
+	{ "bias-high-impedance", PIN_CONFIG_BIAS_HIGH_IMPEDANCE, 0 },
+	{ "power-source", PIN_CONFIG_POWER_SOURCE, 0 },
+	{ "input-disable", PIN_CONFIG_INPUT_ENABLE, 0 },
+	{ "input-enable", PIN_CONFIG_INPUT_ENABLE, 1 },
+	{ "output-disable", PIN_CONFIG_OUTPUT_ENABLE, 0 },
+	{ "output-enable", PIN_CONFIG_OUTPUT_ENABLE, 1 },
+	{ "output-high", PIN_CONFIG_OUTPUT, 1 },
+	{ "output-low", PIN_CONFIG_OUTPUT, 0 },
+	{ "qcom,pull-up-strength", PMIC_GPIO_CONF_PULL_UP, 0},
+	{ "qcom,drive-strength", PMIC_GPIO_CONF_STRENGTH, 0},
+	{ "qcom,atest",	PMIC_GPIO_CONF_ATEST, 0},
+	{ "qcom,analog-pass", PMIC_GPIO_CONF_ANALOG_PASS, 0},
+	{ "qcom,dtest-buffer", PMIC_GPIO_CONF_DTEST_BUFFER, 0},
+};
+
+static int qcom_spmi_pmic_pinctrl_get_pins_count(struct udevice *dev)
+{
+	struct qcom_spmi_pmic_gpio_data *plat = dev_get_plat(dev);
+
+	return plat->pin_count;
+}
+
+static const char *qcom_spmi_pmic_pinctrl_get_pin_name(struct udevice *dev,
+						       unsigned int selector)
+{
+	static char name[8];
+
+	/* DT indexes from 1 */
+	snprintf(name, sizeof(name), "gpio%u", selector + 1);
+
+	return name;
+}
+
+static int qcom_spmi_pmic_pinctrl_get_pin_muxing(struct udevice *dev,
+						 unsigned int selector,
+						 char *buf, int size)
+{
+	struct qcom_spmi_pmic_gpio_data *plat = dev_get_plat(dev);
+	struct spmi_pmic_gpio_pad *pad;
+
+	if (selector >= plat->pin_count)
+		return -EINVAL;
+
+	pad = &plat->pads[selector];
+
+	spmi_pmic_gpio_get_state(plat, pad, buf, size);
+
+	return 0;
+}
+
+static int qcom_spmi_pmic_pinctrl_pinconf_set(struct udevice *dev, unsigned int selector,
+					      unsigned int param, unsigned int arg)
+{
+	struct qcom_spmi_pmic_gpio_data *plat = dev_get_plat(dev);
+	struct spmi_pmic_gpio_pad *pad;
+
+	if (selector >= plat->pin_count)
+		return -EINVAL;
+
+	pad = &plat->pads[selector];
+	pad->is_enabled = true;
+
+	switch (param) {
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		pad->buffer_type = PMIC_GPIO_OUT_BUF_CMOS;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if (!pad->have_buffer)
+			return -EINVAL;
+		pad->buffer_type = PMIC_GPIO_OUT_BUF_OPEN_DRAIN_NMOS;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
+		if (!pad->have_buffer)
+			return -EINVAL;
+		pad->buffer_type = PMIC_GPIO_OUT_BUF_OPEN_DRAIN_PMOS;
+		break;
+	case PIN_CONFIG_BIAS_DISABLE:
+		pad->pullup = PMIC_GPIO_PULL_DISABLE;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		pad->pullup = PMIC_GPIO_PULL_UP_30;
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if (arg)
+			pad->pullup = PMIC_GPIO_PULL_DOWN;
+		else
+			pad->pullup = PMIC_GPIO_PULL_DISABLE;
+		break;
+	case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+		pad->is_enabled = false;
+		break;
+	case PIN_CONFIG_POWER_SOURCE:
+		if (arg >= pad->num_sources)
+			return -EINVAL;
+		pad->power_source = arg;
+		break;
+	case PIN_CONFIG_INPUT_ENABLE:
+		pad->input_enabled = arg ? true : false;
+		break;
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		pad->output_enabled = arg ? true : false;
+		break;
+	case PIN_CONFIG_OUTPUT:
+		pad->output_enabled = true;
+		pad->out_value = arg;
+		break;
+	case PMIC_GPIO_CONF_PULL_UP:
+		if (arg > PMIC_GPIO_PULL_UP_1P5_30)
+			return -EINVAL;
+		pad->pullup = arg;
+		break;
+	case PMIC_GPIO_CONF_STRENGTH:
+		if (arg > PMIC_GPIO_STRENGTH_LOW)
+			return -EINVAL;
+		switch (arg) {
+		case PMIC_GPIO_STRENGTH_HIGH:
+			pad->strength = PMIC_GPIO_OUT_STRENGTH_HIGH;
+			break;
+		case PMIC_GPIO_STRENGTH_LOW:
+			pad->strength = PMIC_GPIO_OUT_STRENGTH_LOW;
+			break;
+		default:
+			pad->strength = arg;
+			break;
+		}
+		break;
+	case PMIC_GPIO_CONF_ATEST:
+		if (!pad->lv_mv_type || arg > 4)
+			return -EINVAL;
+		pad->atest = arg;
+		break;
+	case PMIC_GPIO_CONF_ANALOG_PASS:
+		if (!pad->lv_mv_type)
+			return -EINVAL;
+		pad->analog_pass = true;
+		break;
+	case PMIC_GPIO_CONF_DTEST_BUFFER:
+		if (arg > 4)
+			return -EINVAL;
+		pad->dtest_buffer = arg;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return qcom_spmi_pmic_gpio_set(plat, pad);
+}
+
+static const char *qcom_spmi_pmic_pinctrl_get_function_name(struct udevice *dev,
+							    unsigned int selector)
+{
+	if (selector >= ARRAY_SIZE(spmi_pmic_gpio_functions))
+		return NULL;
+
+	return spmi_pmic_gpio_functions[selector];
+}
+
+static int qcom_spmi_pmic_pinctrl_get_functions_count(struct udevice *dev)
+{
+	return ARRAY_SIZE(spmi_pmic_gpio_functions);
+}
+
+static int qcom_spmi_pmic_pinctrl_pinmux_set_mux(struct udevice *dev, unsigned int selector,
+						 unsigned int function)
+{
+	struct qcom_spmi_pmic_gpio_data *plat = dev_get_plat(dev);
+	struct spmi_pmic_gpio_pad *pad;
+	unsigned int val;
+	int ret;
+
+	if (selector >= plat->pin_count)
+		return -EINVAL;
+
+	pad = &plat->pads[selector];
+
+	/*
+	 * Non-LV/MV subtypes only support 2 special functions,
+	 * offsetting the dtestx function values by 2
+	 */
+	if (!pad->lv_mv_type) {
+		if (function == PMIC_GPIO_FUNC_INDEX_FUNC3 ||
+		    function == PMIC_GPIO_FUNC_INDEX_FUNC4) {
+			pr_err("LV/MV subtype doesn't have func3/func4\n");
+			return -EINVAL;
+		}
+		if (function >= PMIC_GPIO_FUNC_INDEX_DTEST1)
+			function -= (PMIC_GPIO_FUNC_INDEX_DTEST1 -
+					PMIC_GPIO_FUNC_INDEX_FUNC3);
+	}
+
+	pad->function = function;
+
+	if (pad->analog_pass)
+		val = PMIC_GPIO_MODE_ANALOG_PASS_THRU;
+	else if (pad->output_enabled && pad->input_enabled)
+		val = PMIC_GPIO_MODE_DIGITAL_INPUT_OUTPUT;
+	else if (pad->output_enabled)
+		val = PMIC_GPIO_MODE_DIGITAL_OUTPUT;
+	else
+		val = PMIC_GPIO_MODE_DIGITAL_INPUT;
+
+	if (pad->lv_mv_type) {
+		ret = spmi_pmic_gpio_write(plat, pad,
+					   PMIC_GPIO_REG_MODE_CTL, val);
+		if (ret < 0)
+			return ret;
+
+		val = pad->atest - 1;
+		ret = spmi_pmic_gpio_write(plat, pad,
+					   PMIC_GPIO_REG_LV_MV_ANA_PASS_THRU_SEL,
+					   val);
+		if (ret < 0)
+			return ret;
+
+		val = pad->out_value
+			<< PMIC_GPIO_LV_MV_OUTPUT_INVERT_SHIFT;
+		val |= pad->function
+			& PMIC_GPIO_LV_MV_OUTPUT_SOURCE_SEL_MASK;
+		ret = spmi_pmic_gpio_write(plat, pad,
+					   PMIC_GPIO_REG_LV_MV_DIG_OUT_SOURCE_CTL,
+					   val);
+		if (ret < 0)
+			return ret;
+	} else {
+		val = val << PMIC_GPIO_REG_MODE_DIR_SHIFT;
+		val |= pad->function << PMIC_GPIO_REG_MODE_FUNCTION_SHIFT;
+		val |= pad->out_value & PMIC_GPIO_REG_MODE_VALUE_SHIFT;
+
+		ret = spmi_pmic_gpio_write(plat, pad, PMIC_GPIO_REG_MODE_CTL, val);
+		if (ret < 0)
+			return ret;
+	}
+
+	val = pad->is_enabled << PMIC_GPIO_REG_MASTER_EN_SHIFT;
+
+	return spmi_pmic_gpio_write(plat, pad, PMIC_GPIO_REG_EN_CTL, val);
+}
+
+struct pinctrl_ops qcom_spmi_pmic_pinctrl_ops = {
+	.get_pins_count = qcom_spmi_pmic_pinctrl_get_pins_count,
+	.get_pin_name = qcom_spmi_pmic_pinctrl_get_pin_name,
+	.set_state = pinctrl_generic_set_state,
+	.pinconf_num_params = ARRAY_SIZE(qcom_spmi_pmic_pinctrl_conf_params),
+	.pinconf_params = qcom_spmi_pmic_pinctrl_conf_params,
+	.pinconf_set = qcom_spmi_pmic_pinctrl_pinconf_set,
+	.get_function_name = qcom_spmi_pmic_pinctrl_get_function_name,
+	.get_functions_count = qcom_spmi_pmic_pinctrl_get_functions_count,
+	.pinmux_set = qcom_spmi_pmic_pinctrl_pinmux_set_mux,
+	.get_pin_muxing = qcom_spmi_pmic_pinctrl_get_pin_muxing,
+};
+
+U_BOOT_DRIVER(qcom_spmi_pmic_pinctrl) = {
+	.name	= "qcom_spmi_pmic_pinctrl",
+	.id	= UCLASS_PINCTRL,
+	.ops	= &qcom_spmi_pmic_pinctrl_ops,
+};

-- 
2.34.1

