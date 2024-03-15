Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D35C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:10:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9DC28800B;
	Fri, 15 Mar 2024 16:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m4zqtDZL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C8E8802B; Fri, 15 Mar 2024 16:10:35 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF8588001
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41400332525so6770565e9.0
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515431; x=1711120231; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g6mWag3Pi0kWshdhpN9Ua0MKGgBjEmDiXuTezGTIVCc=;
 b=m4zqtDZLvRztH+o8BjWqKYnyrvSdWe78xo0GzTU/L5XzSLFN2uRO0ZQK0QLx3fbccY
 4Uj7J8FHXPqv+vyfK0/sgWMTO7cnj0DCbeL6SgF81Z26mdYKl81POyAjCjdo3jWF/72I
 pVTS+fmu/zYmRnMa6U2OED/UeSw+22OgEhTh9kdJAzIHOOKAA3wpDz65FAkI3KgGdKwM
 Q4/Mma+/sJOSJgBenJzTUo2l/hxgpoAuBOc6mavgjno8/jXO3AoZ4ik3g2xNZK0ql7VG
 DIBO0PDZGN9lRtuEgBn8g+VHFoNMbLPji6ktgqU+0Z+UrEdCUUWGQQE8pgZCOJshT4o3
 jrng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515431; x=1711120231;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g6mWag3Pi0kWshdhpN9Ua0MKGgBjEmDiXuTezGTIVCc=;
 b=pkiDgjQBEI/3xUpr2/SaNiwlrgNxwswZ3G9jIadEuBmbiBSqArYgDozig+13Mzmz4d
 2LvAgIRI8x+9+HPDzcgmxuemIyBnSRfc/ou1ZyLAhPUXvS1S/TBe4srwrklg+R7Bh9BW
 kPsIXJmkX+zP8eCtKa8g25t5ry0tADizNq32kdZO5IcoAIrWRsyx7yRh0XsZr6UHeHng
 cozbdHmIAXpOp918ZMfPQlmLb2jyKRHEboRQzFsX6+/erbvkjdabdgvjTlaKzEeEb6i2
 RH+MFMZ+JvX2EcPBbPDO8tYjoOPkHkT0MioM1uGfk3pdBmUlHIpLwvj0BqkuaywIhmiv
 unxQ==
X-Gm-Message-State: AOJu0YxzrfhMw3MBcl8ZL9LDVRb4Z21QSBdZxbCeYaLuaR+n83ZOD77a
 5tnHt6araZJWb0bemfjqHKDoKrbLoJlUdtnhvm8Td6qEXdVnSGYXx6ek3sHHlq4IiRi5eU9OkIA
 q
X-Google-Smtp-Source: AGHT+IGFVtBiTf5+SAGXMa4YVWRUtlHvwivtx8HL324slXZnfyNXqYXcwPp4yPmkqCm4gW26kualvw==
X-Received: by 2002:adf:e253:0:b0:33e:d244:4870 with SMTP id
 bl19-20020adfe253000000b0033ed2444870mr1661183wrb.59.1710515431036; 
 Fri, 15 Mar 2024 08:10:31 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:30 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:11 +0000
Subject: [PATCH v2 02/14] phy: qcom: add Qualcomm QUSB2 USB PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-2-ab635774b2dc@linaro.org>
References: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
In-Reply-To: <20240315-b4-qcom-livetree-v2-0-ab635774b2dc@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14855;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=2N7jc6PfWuEQfGhtx0f5pYAPd9Ykl627THeMqJkhbUo=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKY/sSxhatXyfr8z9W1emdmJXWovwm5XdH3Z/jK+8t
 +XaaZf7HaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiX1sYGXYq7On6E9Yz74bt
 Id+/N4Ilnvw9fePFNnuHw6X67jvmnvjI8IeD/8Iq8eP1sxT0ApJm+VoUT7dOmrzvd5WG5fHfFyY
 2ZrcDAA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

From: Bhupesh Sharma <bhupesh.linux@gmail.com>

The Snapdragon 845 and several other Qualcomm SoCs feature this
USB high-speed phy. Add a driver for it based on the Linux driver, with
support for the SDM845, and the QCM2290 and SM6115 SoCs which will gain
support in U-Boot in future patches.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
[code cleanup, switch to clk_bulk]
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/phy/qcom/Kconfig          |   7 +
 drivers/phy/qcom/Makefile         |   1 +
 drivers/phy/qcom/phy-qcom-qusb2.c | 468 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 476 insertions(+)

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index f4ca174805a4..361dfb6e1126 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -11,8 +11,15 @@ config PHY_QCOM_IPQ4019_USB
 	depends on PHY && ARCH_IPQ40XX
 	help
 	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
 
+config PHY_QCOM_QUSB2
+	tristate "Qualcomm USB QUSB2 PHY driver"
+	depends on PHY && ARCH_SNAPDRAGON
+	help
+	  Enable this to support the Super-Speed USB transceiver on various
+	  Qualcomm chipsets.
+
 config PHY_QCOM_USB_HS_28NM
 	tristate "Qualcomm 28nm High-Speed PHY"
 	depends on PHY && ARCH_SNAPDRAGON
 	help
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index 2113f178c0c7..f6af985666a4 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
+obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_HS_28NM) += phy-qcom-usb-hs-28nm.o
 obj-$(CONFIG_PHY_QCOM_USB_SS) += phy-qcom-usb-ss.o
diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
new file mode 100644
index 000000000000..5b654403a181
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -0,0 +1,468 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Bhupesh Sharma <bhupesh.sharma@linaro.org>
+ *
+ * Based on Linux driver
+ */
+
+#include <dm.h>
+#include <generic-phy.h>
+#include <linux/bitops.h>
+#include <asm/io.h>
+#include <reset.h>
+#include <clk.h>
+#include <linux/delay.h>
+
+#include <dt-bindings/phy/phy-qcom-qusb2.h>
+
+#define QUSB2PHY_PLL 0x0
+#define QUSB2PHY_PLL_TEST 0x04
+#define CLK_REF_SEL BIT(7)
+
+#define QUSB2PHY_PLL_TUNE 0x08
+#define QUSB2PHY_PLL_USER_CTL1 0x0c
+#define QUSB2PHY_PLL_USER_CTL2 0x10
+#define QUSB2PHY_PLL_AUTOPGM_CTL1 0x1c
+#define QUSB2PHY_PLL_PWR_CTRL 0x18
+
+/* QUSB2PHY_PLL_STATUS register bits */
+#define PLL_LOCKED BIT(5)
+
+/* QUSB2PHY_PLL_COMMON_STATUS_ONE register bits */
+#define CORE_READY_STATUS BIT(0)
+
+/* QUSB2PHY_PORT_POWERDOWN register bits */
+#define CLAMP_N_EN BIT(5)
+#define FREEZIO_N BIT(1)
+#define POWER_DOWN BIT(0)
+
+/* QUSB2PHY_PWR_CTRL1 register bits */
+#define PWR_CTRL1_VREF_SUPPLY_TRIM BIT(5)
+#define PWR_CTRL1_CLAMP_N_EN BIT(1)
+
+#define QUSB2PHY_REFCLK_ENABLE BIT(0)
+
+#define PHY_CLK_SCHEME_SEL BIT(0)
+
+/* QUSB2PHY_INTR_CTRL register bits */
+#define DMSE_INTR_HIGH_SEL BIT(4)
+#define DPSE_INTR_HIGH_SEL BIT(3)
+#define CHG_DET_INTR_EN BIT(2)
+#define DMSE_INTR_EN BIT(1)
+#define DPSE_INTR_EN BIT(0)
+
+/* QUSB2PHY_PLL_CORE_INPUT_OVERRIDE register bits */
+#define CORE_PLL_EN_FROM_RESET BIT(4)
+#define CORE_RESET BIT(5)
+#define CORE_RESET_MUX BIT(6)
+
+/* QUSB2PHY_IMP_CTRL1 register bits */
+#define IMP_RES_OFFSET_MASK GENMASK(5, 0)
+#define IMP_RES_OFFSET_SHIFT 0x0
+
+/* QUSB2PHY_PLL_BIAS_CONTROL_2 register bits */
+#define BIAS_CTRL2_RES_OFFSET_MASK GENMASK(5, 0)
+#define BIAS_CTRL2_RES_OFFSET_SHIFT 0x0
+
+/* QUSB2PHY_CHG_CONTROL_2 register bits */
+#define CHG_CTRL2_OFFSET_MASK GENMASK(5, 4)
+#define CHG_CTRL2_OFFSET_SHIFT 0x4
+
+/* QUSB2PHY_PORT_TUNE1 register bits */
+#define HSTX_TRIM_MASK GENMASK(7, 4)
+#define HSTX_TRIM_SHIFT 0x4
+#define PREEMPH_WIDTH_HALF_BIT BIT(2)
+#define PREEMPHASIS_EN_MASK GENMASK(1, 0)
+#define PREEMPHASIS_EN_SHIFT 0x0
+
+/* QUSB2PHY_PORT_TUNE2 register bits */
+#define HSDISC_TRIM_MASK GENMASK(1, 0)
+#define HSDISC_TRIM_SHIFT 0x0
+
+#define QUSB2PHY_PLL_ANALOG_CONTROLS_TWO 0x04
+#define QUSB2PHY_PLL_CLOCK_INVERTERS 0x18c
+#define QUSB2PHY_PLL_CMODE 0x2c
+#define QUSB2PHY_PLL_LOCK_DELAY 0x184
+#define QUSB2PHY_PLL_DIGITAL_TIMERS_TWO 0xb4
+#define QUSB2PHY_PLL_BIAS_CONTROL_1 0x194
+#define QUSB2PHY_PLL_BIAS_CONTROL_2 0x198
+#define QUSB2PHY_PWR_CTRL2 0x214
+#define QUSB2PHY_IMP_CTRL1 0x220
+#define QUSB2PHY_IMP_CTRL2 0x224
+#define QUSB2PHY_CHG_CTRL2 0x23c
+
+struct qusb2_phy_init_tbl {
+	unsigned int offset;
+	unsigned int val;
+	/*
+	 * register part of layout ?
+	 * if yes, then offset gives index in the reg-layout
+	 */
+	int in_layout;
+};
+
+struct qusb2_phy_cfg {
+	const struct qusb2_phy_init_tbl *tbl;
+	/* number of entries in the table */
+	unsigned int tbl_num;
+	/* offset to PHY_CLK_SCHEME register in TCSR map */
+	unsigned int clk_scheme_offset;
+
+	/* array of registers with different offsets */
+	const unsigned int *regs;
+	unsigned int mask_core_ready;
+	unsigned int disable_ctrl;
+	unsigned int autoresume_en;
+
+	/* true if PHY has PLL_TEST register to select clk_scheme */
+	bool has_pll_test;
+
+	/* true if TUNE1 register must be updated by fused value, else TUNE2 */
+	bool update_tune1_with_efuse;
+
+	/* true if PHY has PLL_CORE_INPUT_OVERRIDE register to reset PLL */
+	bool has_pll_override;
+};
+
+/* set of registers with offsets different per-PHY */
+enum qusb2phy_reg_layout {
+	QUSB2PHY_PLL_CORE_INPUT_OVERRIDE,
+	QUSB2PHY_PLL_STATUS,
+	QUSB2PHY_PORT_TUNE1,
+	QUSB2PHY_PORT_TUNE2,
+	QUSB2PHY_PORT_TUNE3,
+	QUSB2PHY_PORT_TUNE4,
+	QUSB2PHY_PORT_TUNE5,
+	QUSB2PHY_PORT_TEST1,
+	QUSB2PHY_PORT_TEST2,
+	QUSB2PHY_PORT_POWERDOWN,
+	QUSB2PHY_INTR_CTRL,
+};
+
+#define QUSB2_PHY_INIT_CFG(o, v)       \
+	{                              \
+		.offset = o, .val = v, \
+	}
+
+#define QUSB2_PHY_INIT_CFG_L(o, v)                     \
+	{                                              \
+		.offset = o, .val = v, .in_layout = 1, \
+	}
+
+static const struct qusb2_phy_init_tbl sm6115_init_tbl[] = {
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x53),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0x81),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0x17),
+
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TUNE, 0x30),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL1, 0x79),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL2, 0x21),
+
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TEST2, 0x14),
+
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_AUTOPGM_CTL1, 0x9f),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
+};
+
+static const unsigned int sm6115_regs_layout[] = {
+	[QUSB2PHY_PLL_STATUS] = 0x38,	  [QUSB2PHY_PORT_TUNE1] = 0x80,
+	[QUSB2PHY_PORT_TUNE2] = 0x84,	  [QUSB2PHY_PORT_TUNE3] = 0x88,
+	[QUSB2PHY_PORT_TUNE4] = 0x8c,	  [QUSB2PHY_PORT_TUNE5] = 0x90,
+	[QUSB2PHY_PORT_TEST1] = 0xb8,	  [QUSB2PHY_PORT_TEST2] = 0x9c,
+	[QUSB2PHY_PORT_POWERDOWN] = 0xb4, [QUSB2PHY_INTR_CTRL] = 0xbc,
+};
+
+static const struct qusb2_phy_init_tbl qusb2_v2_init_tbl[] = {
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x03),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CMODE, 0x80),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_LOCK_DELAY, 0x0a),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_DIGITAL_TIMERS_TWO, 0x19),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_BIAS_CONTROL_1, 0x40),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_BIAS_CONTROL_2, 0x20),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PWR_CTRL2, 0x21),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_IMP_CTRL1, 0x0),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_IMP_CTRL2, 0x58),
+
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0x30),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x29),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0xca),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0x04),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE5, 0x03),
+
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_CHG_CTRL2, 0x0),
+};
+
+static const unsigned int qusb2_v2_regs_layout[] = {
+	[QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
+	[QUSB2PHY_PLL_STATUS] = 0x1a0,
+	[QUSB2PHY_PORT_TUNE1] = 0x240,
+	[QUSB2PHY_PORT_TUNE2] = 0x244,
+	[QUSB2PHY_PORT_TUNE3] = 0x248,
+	[QUSB2PHY_PORT_TUNE4] = 0x24c,
+	[QUSB2PHY_PORT_TUNE5] = 0x250,
+	[QUSB2PHY_PORT_TEST1] = 0x254,
+	[QUSB2PHY_PORT_TEST2] = 0x258,
+	[QUSB2PHY_PORT_POWERDOWN] = 0x210,
+	[QUSB2PHY_INTR_CTRL] = 0x230,
+};
+
+static const struct qusb2_phy_cfg sm6115_phy_cfg = {
+	.tbl = sm6115_init_tbl,
+	.tbl_num = ARRAY_SIZE(sm6115_init_tbl),
+	.regs = sm6115_regs_layout,
+
+	.has_pll_test = true,
+	.disable_ctrl = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
+	.mask_core_ready = PLL_LOCKED,
+	.autoresume_en = BIT(3),
+};
+
+static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
+	.tbl = qusb2_v2_init_tbl,
+	.tbl_num = ARRAY_SIZE(qusb2_v2_init_tbl),
+	.regs = qusb2_v2_regs_layout,
+
+	.disable_ctrl = (PWR_CTRL1_VREF_SUPPLY_TRIM | PWR_CTRL1_CLAMP_N_EN |
+			 POWER_DOWN),
+	.mask_core_ready = CORE_READY_STATUS,
+	.has_pll_override = true,
+	.autoresume_en = BIT(0),
+	.update_tune1_with_efuse = true,
+};
+
+/**
+ * struct qusb2_phy - structure holding qusb2 phy attributes
+ *
+ * @phy: generic phy
+ * @base: iomapped memory space for qubs2 phy
+ *
+ * @cfg_ahb_clk: AHB2PHY interface clock
+ * @phy_rst: phy reset control
+ *
+ * @cfg: phy config data
+ * @has_se_clk_scheme: indicate if PHY has single-ended ref clock scheme
+ */
+struct qusb2_phy {
+	struct phy *phy;
+	void __iomem *base;
+
+	struct clk cfg_ahb_clk;
+	struct reset_ctl phy_rst;
+
+	const struct qusb2_phy_cfg *cfg;
+	bool has_se_clk_scheme;
+};
+
+static inline void qusb2_write_mask(void __iomem *base, u32 offset, u32 val,
+				    u32 mask)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~mask;
+	reg |= val & mask;
+	writel(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl(base + offset);
+}
+
+static inline void qusb2_setbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg |= val;
+	writel(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl(base + offset);
+}
+
+static inline void qusb2_clrbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~val;
+	writel(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl(base + offset);
+}
+
+static inline void qusb2_phy_configure(void __iomem *base,
+				       const unsigned int *regs,
+				       const struct qusb2_phy_init_tbl tbl[],
+				       int num)
+{
+	int i;
+
+	for (i = 0; i < num; i++) {
+		if (tbl[i].in_layout)
+			writel(tbl[i].val, base + regs[tbl[i].offset]);
+		else
+			writel(tbl[i].val, base + tbl[i].offset);
+	}
+}
+
+static int qusb2phy_do_reset(struct qusb2_phy *qphy)
+{
+	int ret;
+
+	ret = reset_assert(&qphy->phy_rst);
+	if (ret)
+		return ret;
+
+	udelay(10);
+
+	ret = reset_deassert(&qphy->phy_rst);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int qusb2phy_power_on(struct phy *phy)
+{
+	struct qusb2_phy *qphy = dev_get_priv(phy->dev);
+	const struct qusb2_phy_cfg *cfg = qphy->cfg;
+	int ret;
+	u32 val;
+
+	ret = qusb2phy_do_reset(qphy);
+	if (ret)
+		return ret;
+
+	/* Disable the PHY */
+	qusb2_setbits(qphy->base, cfg->regs[QUSB2PHY_PORT_POWERDOWN],
+		      qphy->cfg->disable_ctrl);
+
+	if (cfg->has_pll_test) {
+		/* save reset value to override reference clock scheme later */
+		val = readl(qphy->base + QUSB2PHY_PLL_TEST);
+	}
+
+	qusb2_phy_configure(qphy->base, cfg->regs, cfg->tbl, cfg->tbl_num);
+
+	/* Enable the PHY */
+	qusb2_clrbits(qphy->base, cfg->regs[QUSB2PHY_PORT_POWERDOWN],
+		      POWER_DOWN);
+
+	/* Required to get phy pll lock successfully */
+	udelay(150);
+
+	if (cfg->has_pll_test) {
+		val |= CLK_REF_SEL;
+
+		writel(val, qphy->base + QUSB2PHY_PLL_TEST);
+
+		/* ensure above write is through */
+		readl(qphy->base + QUSB2PHY_PLL_TEST);
+	}
+
+	/* Required to get phy pll lock successfully */
+	udelay(100);
+
+	val = readb(qphy->base + cfg->regs[QUSB2PHY_PLL_STATUS]);
+	if (!(val & cfg->mask_core_ready)) {
+		pr_err("QUSB2PHY pll lock failed: status reg = %x\n", val);
+		ret = -EBUSY;
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qusb2phy_power_off(struct phy *phy)
+{
+	struct qusb2_phy *qphy = dev_get_priv(phy->dev);
+
+	/* Disable the PHY */
+	qusb2_setbits(qphy->base, qphy->cfg->regs[QUSB2PHY_PORT_POWERDOWN],
+		      qphy->cfg->disable_ctrl);
+
+	reset_assert(&qphy->phy_rst);
+
+	clk_disable(&qphy->cfg_ahb_clk);
+
+	return 0;
+}
+
+static int qusb2phy_clk_init(struct udevice *dev, struct qusb2_phy *qphy)
+{
+	int ret;
+
+	/* We ignore the ref clock as we currently lack a driver for rpmcc/rpmhcc where
+	 * it usually comes from - we assume it's always on.
+	 */
+	ret = clk_get_by_name(dev, "cfg_ahb", &qphy->cfg_ahb_clk);
+	if (ret == -ENOSYS || ret == -ENOENT)
+		return 0;
+	if (ret)
+		return ret;
+
+	ret = clk_enable(&qphy->cfg_ahb_clk);
+	if (ret) {
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qusb2phy_probe(struct udevice *dev)
+{
+	struct qusb2_phy *qphy = dev_get_priv(dev);
+	int ret;
+
+	qphy->base = (void __iomem *)dev_read_addr(dev);
+	if (IS_ERR(qphy->base))
+		return PTR_ERR(qphy->base);
+
+	ret = qusb2phy_clk_init(dev, qphy);
+	if (ret) {
+		printf("%s: Couldn't get clocks: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = reset_get_by_index(dev, 0, &qphy->phy_rst);
+	if (ret) {
+		printf("%s: Couldn't get resets: %d\n", __func__, ret);
+		return ret;
+	}
+
+	qphy->cfg = (const struct qusb2_phy_cfg *)dev_get_driver_data(dev);
+	if (!qphy->cfg) {
+		printf("%s: Couldn't get driver data\n", __func__);
+		return -EINVAL;
+	}
+
+	debug("%s success qusb phy cfg %p\n", __func__, qphy->cfg);
+	return 0;
+}
+
+static struct phy_ops qusb2phy_ops = {
+	.power_on = qusb2phy_power_on,
+	.power_off = qusb2phy_power_off,
+};
+
+static const struct udevice_id qusb2phy_ids[] = {
+	{ .compatible = "qcom,qusb2-phy" },
+	{ .compatible = "qcom,qcm2290-qusb2-phy",
+	  .data = (ulong)&sm6115_phy_cfg },
+	{ .compatible = "qcom,sm6115-qusb2-phy",
+	  .data = (ulong)&sm6115_phy_cfg },
+	{ .compatible = "qcom,qusb2-v2-phy", .data = (ulong)&qusb2_v2_phy_cfg },
+	{}
+};
+
+U_BOOT_DRIVER(qcom_qusb2_phy) = {
+	.name = "qcom-qusb2-phy",
+	.id = UCLASS_PHY,
+	.of_match = qusb2phy_ids,
+	.ops = &qusb2phy_ops,
+	.probe = qusb2phy_probe,
+	.priv_auto = sizeof(struct qusb2_phy),
+};

-- 
2.44.0

