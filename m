Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43245C54E58
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CADCD88049;
	Fri, 15 Mar 2024 16:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v9SwqGjC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28DCE87FC6; Fri, 15 Mar 2024 16:10:38 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D2758800C
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-33ec8aac149so1001579f8f.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515432; x=1711120232; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sdiEpf6P3cJK8B14F5lPuyDvhsCbEe61z94agzm99HE=;
 b=v9SwqGjCYEdUkmW4snbOOYVI9sqaSlIEGEsurkAnIxI0e8KTB4ICpvHXjXRLn68VFM
 80t7oOGx4e04TKOxP1AOZABCsNqhqKtUEVdbQvQTe2fuwqwCFSErmKfjxcBCdBg0dm7k
 6YVlH1a5N0+SrSv4FitNfb3FcAMtw9OdlX+vKbVmFvbrHRJuqREGlHw4D9dxd3n+JTxf
 cX4JX4723k5Guu/kvt6fkeeERAW7FTL8avr7OiQnIPNqNSSP6FIRvdqWssXjwdkEwRGc
 NNAgheaJ9DZr3IIHyS9S5hyGbVjoVbfEMR17jZXzGI0Vii9KCQ9EFwCcr22KsLx88yZp
 m0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515432; x=1711120232;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdiEpf6P3cJK8B14F5lPuyDvhsCbEe61z94agzm99HE=;
 b=amiSR078O3D2MLYXTcJWhPM+lcTMrLsXm2l7bIY4fkoCfpygufVVHLjx/2FEQc0kIm
 QYqioiF6IHMpkmLmU/xrclaJLHBcEtjXt69ykPi5s0GHdu7p1kKIfpV6sY47AHwT4dkN
 cEZncw6vGrjkx4oDoh8vlTtbZ8bHM7SYdZ4B0DZa7If2mLWm63L1qYZt2gOElXxw5OEq
 sMmR02dF1q2hreyYjXBtJfBeTYai7VuHYKQnnUfAKd0Jaz3PVOBeQdBm3c+yjTrRGNVU
 ONR2RIuUj6/kmbg4Enm5TGJJcepxlNXXpbIpwahrHTSqPFv+s6H6gOdu58kz1d1D6m3y
 usbQ==
X-Gm-Message-State: AOJu0Yym+UbS8hAR6jwb1oug3lIRM0svmZ5Of3sBzDmpSkFlGJuCqMKw
 zSbZJjYnpwfCDKgUumDrICAToEm4UPTcBLzxtqXrn18d5+V1A2S0H+JobUwOUR5SK8Vu8zayXsA
 L
X-Google-Smtp-Source: AGHT+IEScowHgmQnv755nG187VXfTQRUJ+wAqQPXWT6bOostrSR7zLdqVGpaRXVKT4WN2JRtxUWvzw==
X-Received: by 2002:a5d:4010:0:b0:33e:cc1e:399 with SMTP id
 n16-20020a5d4010000000b0033ecc1e0399mr3008558wrp.43.1710515432044; 
 Fri, 15 Mar 2024 08:10:32 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d4006000000b0033e699fc6b4sm3398141wrp.69.2024.03.15.08.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:10:31 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:10:12 +0000
Subject: [PATCH v2 03/14] phy: qcom: Add USB HS 7nm PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-livetree-v2-3-ab635774b2dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9717;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=lACQTcB5MJXV/66mdlBTnkZRF31mWOf1jhSDruKEz1w=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvKY//OdVuMdg4Z1dCVUXm3vUBcTOEBAuXK9Z3LKk7m
 9h/m2VmRykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZiI30KG/z6fff0nLnddI7LL
 Zu9Rr4eFyS6HlxTMPeYZM3fzom1P7s9l+Cu2cc3/Own1bu+fPFJ0EmpTuuYocjMlRNpN83+Hy6N
 WP2sA
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

Some Qualcomm SoCs newer than SDM845 feature a so-called "7nm phy"
driver, notable the SM8250 SoC which will gain U-Boot support in
upcoming patches.

Introduce a driver based on the Linux driver.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
[code cleanup, switch to clk/reset_bulk APIs]
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/phy/qcom/Kconfig               |   8 +
 drivers/phy/qcom/Makefile              |   1 +
 drivers/phy/qcom/phy-qcom-usb-hs-7nm.c | 295 +++++++++++++++++++++++++++++++++
 3 files changed, 304 insertions(+)

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 361dfb6e1126..3fc59dc65650 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -18,8 +18,16 @@ config PHY_QCOM_QUSB2
 	help
 	  Enable this to support the Super-Speed USB transceiver on various
 	  Qualcomm chipsets.
 
+config PHY_QCOM_USB_HS_7NM
+	tristate "Qualcomm 7nm High-Speed PHY"
+	depends on PHY && ARCH_SNAPDRAGON
+	help
+	  Enable this to support the Qualcomm Synopsys DesignWare Core 7nm
+	  High-Speed PHY driver. This driver supports the Hi-Speed PHY which
+	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
+
 config PHY_QCOM_USB_HS_28NM
 	tristate "Qualcomm 28nm High-Speed PHY"
 	depends on PHY && ARCH_SNAPDRAGON
 	help
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index f6af985666a4..39219ecd24aa 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
+obj-$(CONFIG_PHY_QCOM_USB_HS_7NM) += phy-qcom-usb-hs-7nm.o
 obj-$(CONFIG_PHY_QCOM_USB_HS_28NM) += phy-qcom-usb-hs-28nm.o
 obj-$(CONFIG_PHY_QCOM_USB_SS) += phy-qcom-usb-ss.o
diff --git a/drivers/phy/qcom/phy-qcom-usb-hs-7nm.c b/drivers/phy/qcom/phy-qcom-usb-hs-7nm.c
new file mode 100644
index 000000000000..65128b45937b
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-usb-hs-7nm.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023 Bhupesh Sharma <bhupesh.sharma@linaro.org>
+ *
+ * Based on Linux driver
+ */
+
+#include <clk.h>
+#include <clk-uclass.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <generic-phy.h>
+#include <malloc.h>
+#include <reset.h>
+
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+
+#define USB2_PHY_USB_PHY_UTMI_CTRL0 (0x3c)
+#define SLEEPM BIT(0)
+#define OPMODE_MASK GENMASK(4, 3)
+#define OPMODE_NORMAL (0x00)
+#define OPMODE_NONDRIVING BIT(3)
+#define TERMSEL BIT(5)
+
+#define USB2_PHY_USB_PHY_UTMI_CTRL1 (0x40)
+#define XCVRSEL BIT(0)
+
+#define USB2_PHY_USB_PHY_UTMI_CTRL5 (0x50)
+#define POR BIT(1)
+
+#define USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0 (0x54)
+#define SIDDQ BIT(2)
+#define RETENABLEN BIT(3)
+#define FSEL_MASK GENMASK(6, 4)
+#define FSEL_DEFAULT (0x3 << 4)
+
+#define USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1 (0x58)
+#define VBUSVLDEXTSEL0 BIT(4)
+#define PLLBTUNE BIT(5)
+
+#define USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2 (0x5c)
+#define VREGBYPASS BIT(0)
+
+#define USB2_PHY_USB_PHY_HS_PHY_CTRL1 (0x60)
+#define VBUSVLDEXT0 BIT(0)
+
+#define USB2_PHY_USB_PHY_HS_PHY_CTRL2 (0x64)
+#define USB2_AUTO_RESUME BIT(0)
+#define USB2_SUSPEND_N BIT(2)
+#define USB2_SUSPEND_N_SEL BIT(3)
+
+#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X0 (0x6c)
+#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X1 (0x70)
+#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X2 (0x74)
+#define USB2_PHY_USB_PHY_HS_PHY_OVERRIDE_X3 (0x78)
+#define PARAM_OVRD_MASK 0xFF
+
+#define USB2_PHY_USB_PHY_CFG0 (0x94)
+#define UTMI_PHY_DATAPATH_CTRL_OVERRIDE_EN BIT(0)
+#define UTMI_PHY_CMN_CTRL_OVERRIDE_EN BIT(1)
+
+#define USB2_PHY_USB_PHY_REFCLK_CTRL (0xa0)
+#define REFCLK_SEL_MASK GENMASK(1, 0)
+#define REFCLK_SEL_DEFAULT (0x2 << 0)
+
+#define HS_DISCONNECT_MASK GENMASK(2, 0)
+#define SQUELCH_DETECTOR_MASK GENMASK(7, 5)
+
+#define HS_AMPLITUDE_MASK GENMASK(3, 0)
+#define PREEMPHASIS_DURATION_MASK BIT(5)
+#define PREEMPHASIS_AMPLITUDE_MASK GENMASK(7, 6)
+
+#define HS_RISE_FALL_MASK GENMASK(1, 0)
+#define HS_CROSSOVER_VOLTAGE_MASK GENMASK(3, 2)
+#define HS_OUTPUT_IMPEDANCE_MASK GENMASK(5, 4)
+
+#define LS_FS_OUTPUT_IMPEDANCE_MASK GENMASK(3, 0)
+
+#define SNPS_HS_NUM_VREGS ARRAY_SIZE(hs_7nm_vreg_names)
+
+struct override_param {
+	s32 value;
+	u8 reg_val;
+};
+
+struct override_param_map {
+	const char *prop_name;
+	const struct override_param *param_table;
+	u8 table_size;
+	u8 reg_offset;
+	u8 param_mask;
+};
+
+struct phy_override_seq {
+	bool need_update;
+	u8 offset;
+	u8 value;
+	u8 mask;
+};
+
+#define NUM_HSPHY_TUNING_PARAMS (9)
+
+/* struct hs_7nm_phy_cfg - per-PHY initialization config */
+struct hs_7nm_phy_cfg {
+	/* resets to be requested */
+	struct reset_ctl *resets;
+	int num_resets;
+
+	struct override_param_map *map_cfg;
+	struct phy_override_seq update_seq_cfg[NUM_HSPHY_TUNING_PARAMS];
+};
+
+/**
+ * struct hs_7nm_phy_priv - snps hs phy attributes
+ */
+struct hs_7nm_phy_priv {
+	void __iomem *base;
+
+	/* clocks to be requested */
+	struct clk_bulk clks;
+
+	/* resets to be requested */
+	struct reset_ctl_bulk resets;
+
+	struct hs_7nm_phy_cfg *cfg;
+};
+
+static inline void hs_7nm_write_mask(void __iomem *base, u32 offset, u32 mask,
+				     u32 val)
+{
+	u32 reg;
+
+	reg = readl_relaxed(base + offset);
+
+	reg &= ~mask;
+	reg |= val & mask;
+	writel_relaxed(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl_relaxed(base + offset);
+}
+
+static int hs_7nm_usb_init(struct phy *phy)
+{
+	struct hs_7nm_phy_priv *hs_7nm = dev_get_priv(phy->dev);
+
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_CFG0,
+			  UTMI_PHY_CMN_CTRL_OVERRIDE_EN,
+			  UTMI_PHY_CMN_CTRL_OVERRIDE_EN);
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_UTMI_CTRL5, POR, POR);
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0,
+			  FSEL_MASK, 0);
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
+			  PLLBTUNE, PLLBTUNE);
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_REFCLK_CTRL,
+			  REFCLK_SEL_DEFAULT, REFCLK_SEL_MASK);
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
+			  VBUSVLDEXTSEL0, VBUSVLDEXTSEL0);
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL1,
+			  VBUSVLDEXT0, VBUSVLDEXT0);
+
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2,
+			  VREGBYPASS, VREGBYPASS);
+
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
+			  USB2_SUSPEND_N_SEL | USB2_SUSPEND_N,
+			  USB2_SUSPEND_N_SEL | USB2_SUSPEND_N);
+
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_UTMI_CTRL0, SLEEPM,
+			  SLEEPM);
+
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0,
+			  SIDDQ, 0);
+
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_UTMI_CTRL5, POR, 0);
+
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
+			  USB2_SUSPEND_N_SEL, 0);
+
+	hs_7nm_write_mask(hs_7nm->base, USB2_PHY_USB_PHY_CFG0,
+			  UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 0);
+
+	return 0;
+}
+
+static int hs_7nm_phy_power_on(struct phy *phy)
+{
+	struct hs_7nm_phy_priv *hs_7nm = dev_get_priv(phy->dev);
+	int ret;
+
+	clk_enable_bulk(&hs_7nm->clks);
+
+	ret = reset_deassert_bulk(&hs_7nm->resets);
+	if (ret)
+		return ret;
+
+	ret = hs_7nm_usb_init(phy);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int hs_7nm_phy_power_off(struct phy *phy)
+{
+	struct hs_7nm_phy_priv *hs_7nm = dev_get_priv(phy->dev);
+
+	reset_assert_bulk(&hs_7nm->resets);
+	clk_disable_bulk(&hs_7nm->clks);
+
+	return 0;
+}
+
+static int hs_7nm_phy_clk_init(struct udevice *dev,
+			       struct hs_7nm_phy_priv *hs_7nm)
+{
+	int ret;
+
+	ret = clk_get_bulk(dev, &hs_7nm->clks);
+	/* We may have no clocks */
+	if (ret == -ENOENT) {
+		debug("%s: no clocks\n", __func__);
+		return 0;
+	}
+	if (ret < 0) {
+		printf("%s: Failed to get clocks %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hs_7nm_phy_probe(struct udevice *dev)
+{
+	struct hs_7nm_phy_priv *hs_7nm = dev_get_priv(dev);
+	int ret;
+
+	hs_7nm->base = (void __iomem *)dev_read_addr(dev);
+	if (IS_ERR(hs_7nm->base))
+		return PTR_ERR(hs_7nm->base);
+
+	hs_7nm->cfg = (struct hs_7nm_phy_cfg *)dev_get_driver_data(dev);
+
+	ret = hs_7nm_phy_clk_init(dev, hs_7nm);
+	if (ret) {
+		printf("%s: hs_7nm_phy_clk_init %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = reset_get_bulk(dev, &hs_7nm->resets);
+	if (ret < 0) {
+		printf("failed to get resets, ret = %d\n", ret);
+		return ret;
+	}
+
+	clk_enable_bulk(&hs_7nm->clks);
+	reset_deassert_bulk(&hs_7nm->resets);
+
+	return 0;
+}
+
+static struct phy_ops hs_7nm_phy_ops = {
+	.power_on = hs_7nm_phy_power_on,
+	.power_off = hs_7nm_phy_power_off,
+};
+
+static const struct udevice_id hs_7nm_phy_ids[] = {
+	{
+		.compatible = "qcom,sm8150-usb-hs-phy",
+	},
+	{
+		.compatible = "qcom,usb-snps-hs-5nm-phy",
+	},
+	{
+		.compatible = "qcom,usb-snps-hs-7nm-phy",
+	},
+	{
+		.compatible = "qcom,usb-snps-femto-v2-phy",
+	},
+	{}
+};
+
+U_BOOT_DRIVER(qcom_usb_hs_7nm) = {
+	.name = "qcom-usb-hs-7nm",
+	.id = UCLASS_PHY,
+	.of_match = hs_7nm_phy_ids,
+	.ops = &hs_7nm_phy_ops,
+	.probe = hs_7nm_phy_probe,
+	.priv_auto = sizeof(struct hs_7nm_phy_priv),
+};

-- 
2.44.0

