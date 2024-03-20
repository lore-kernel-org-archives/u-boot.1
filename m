Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D43C54E58
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:57:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E96B88047;
	Wed, 20 Mar 2024 15:57:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SvgRUjLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4947880B5; Wed, 20 Mar 2024 15:57:14 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1CFB879A0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4146d750dcdso3904705e9.1
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710946632; x=1711551432; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mo0ALmgvoc8lowUNrftdRsvBcE1gffK1FRbzStvKZ08=;
 b=SvgRUjLdd0sNL4L9lpEZH4TxEgLLPJI/8U5bvxEjmRn3i5pre7B6HW52Wxhqq0lfGy
 K4mjqo+AOI6JVFnt1L/EukYmxSCEzdU9Q1tz5rO6+rmtx+tJFBFZsKOn1nXaR9mSnLAU
 vp1I4+B/8SGBJjFEMmbFkJhKC9DFUkBbxXgkW8kIlR9asmbf6L335PIf6GWH6STjUL/X
 zfcYW4aOk1s8rhZI1tYZ6fR0Cxqa7Bu0Ry+3/OVYW+8o1yoyF//5Hn3ZwUHgtIJ2PLaF
 AN68RGChMrUFZWy9O7A+fCrOBkP+7ELv5aT4725TDk3T6AgsELXzyRRUnjm98+DF04nq
 qEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710946632; x=1711551432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mo0ALmgvoc8lowUNrftdRsvBcE1gffK1FRbzStvKZ08=;
 b=VKonztXlFjJLdVg36Q8eCm5Y28dwM5J6dndZ71ooGsPjqUkpIOvjXFMHpM6Pg/Yhyn
 l3pWiWSIO14igKwQfxzoZyJV/V6bYPYptOVQAREtvE35wericxUqgmZK5N8G1T9OL2Zo
 en4KNm4zUtNuQ1w/NSd6ujatEJ40KALec5D+WbUSWynu9D+ODBfECs+PaOenaUhcF1zd
 Wrab5Ri4pQ0UlyvV6kwRMvWETnt+wkaDjI4czPJt1cc5Ed5hk/c5ps8dJvvJ9vdr/bmJ
 OXAtXsWTLGVhnxkOoYBjg7xF/ok5Xas3t00s2yjwii9n46LTz3Ex+l9he4Um/NDqbe3i
 +i1Q==
X-Gm-Message-State: AOJu0Yzcjm3I4YL7b0hazA7ZXpCthZY5r9upgdNjjAwZrZt9HofYXIGr
 fOE2QdOlDfWmNjbtHa7Wtu3sto2gKofpAG1tT91zydEqDFPmoqm5nyo11G2lrGs=
X-Google-Smtp-Source: AGHT+IHRfaQ8sRlkCiaUH07XJ5mfV0GwXgMZ3alW1g/0FRAx035z00CBAlTwvSTSFk1vpov3FwIl1w==
X-Received: by 2002:a05:600c:1d27:b0:414:6332:fa2a with SMTP id
 l39-20020a05600c1d2700b004146332fa2amr61045wms.9.1710946632315; 
 Wed, 20 Mar 2024 07:57:12 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bi16-20020a05600c3d9000b0041468f79fd5sm2461268wmb.16.2024.03.20.07.57.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:57:11 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:57:06 +0000
Subject: [PATCH v4 03/14] phy: qcom: Add SNPS femto v2 USB HS phy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-livetree-v4-3-d867ab1f06c2@linaro.org>
References: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
In-Reply-To: <20240320-b4-qcom-livetree-v4-0-d867ab1f06c2@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7983;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=34UAv7iWNOYroM3MyV5D/iMSNHtmM9D4OUsIKfbdI0s=;
 b=kA0DAAgReTBFn7kwMhcByyZiAGX6+UGg86KwcgfB0ppdhPeQ0Wv5YRfcFQsjP7M+122F2p3Pg
 Yh1BAARCAAdFiEEF8imOYKt0z8ot6DQeTBFn7kwMhcFAmX6+UEACgkQeTBFn7kwMhcwjwD+LVyy
 wr8WutOntAVUbWsIzRI4+PT9Xkq5YsjuHaZefEMA/2GqBNQoYxvX6s0C15MHpafMMnDkd2KgjJT
 NUR80EbXH
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
[code cleanup, align symbol names with Linux, switch to clk/reset_bulk APIs]
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/phy/qcom/Kconfig                  |   8 ++
 drivers/phy/qcom/Makefile                 |   1 +
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 207 ++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 361dfb6e1126..b9fe608c2798 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -18,8 +18,16 @@ config PHY_QCOM_QUSB2
 	help
 	  Enable this to support the Super-Speed USB transceiver on various
 	  Qualcomm chipsets.
 
+config PHY_QCOM_USB_SNPS_FEMTO_V2
+	tristate "Qualcomm SNPS FEMTO USB HS PHY v2"
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
index f6af985666a4..5f4db4a53788 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
+obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_USB_HS_28NM) += phy-qcom-usb-hs-28nm.o
 obj-$(CONFIG_PHY_QCOM_USB_SS) += phy-qcom-usb-ss.o
diff --git a/drivers/phy/qcom/phy-qcom-snps-femto-v2.c b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
new file mode 100644
index 000000000000..eda80b96b0a9
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
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
+#define USB2_PHY_USB_PHY_CFG0 (0x94)
+#define UTMI_PHY_DATAPATH_CTRL_OVERRIDE_EN BIT(0)
+#define UTMI_PHY_CMN_CTRL_OVERRIDE_EN BIT(1)
+
+#define USB2_PHY_USB_PHY_REFCLK_CTRL (0xa0)
+#define REFCLK_SEL_MASK GENMASK(1, 0)
+#define REFCLK_SEL_DEFAULT (0x2 << 0)
+
+struct qcom_snps_hsphy {
+	void __iomem *base;
+	struct clk_bulk clks;
+	struct reset_ctl_bulk resets;
+};
+
+static inline void qcom_snps_hsphy_write_mask(void __iomem *base, u32 offset,
+					      u32 mask, u32 val)
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
+static int qcom_snps_hsphy_usb_init(struct phy *phy)
+{
+	struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_CFG0,
+				   UTMI_PHY_CMN_CTRL_OVERRIDE_EN,
+				   UTMI_PHY_CMN_CTRL_OVERRIDE_EN);
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL5, POR,
+				   POR);
+	qcom_snps_hsphy_write_mask(
+		priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0, FSEL_MASK, 0);
+	qcom_snps_hsphy_write_mask(priv->base,
+				   USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
+				   PLLBTUNE, PLLBTUNE);
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_REFCLK_CTRL,
+				   REFCLK_SEL_DEFAULT, REFCLK_SEL_MASK);
+	qcom_snps_hsphy_write_mask(priv->base,
+				   USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON1,
+				   VBUSVLDEXTSEL0, VBUSVLDEXTSEL0);
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL1,
+				   VBUSVLDEXT0, VBUSVLDEXT0);
+
+	qcom_snps_hsphy_write_mask(priv->base,
+				   USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON2,
+				   VREGBYPASS, VREGBYPASS);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
+				   USB2_SUSPEND_N_SEL | USB2_SUSPEND_N,
+				   USB2_SUSPEND_N_SEL | USB2_SUSPEND_N);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL0,
+				   SLEEPM, SLEEPM);
+
+	qcom_snps_hsphy_write_mask(
+		priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0, SIDDQ, 0);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_UTMI_CTRL5, POR,
+				   0);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_HS_PHY_CTRL2,
+				   USB2_SUSPEND_N_SEL, 0);
+
+	qcom_snps_hsphy_write_mask(priv->base, USB2_PHY_USB_PHY_CFG0,
+				   UTMI_PHY_CMN_CTRL_OVERRIDE_EN, 0);
+
+	return 0;
+}
+
+static int qcom_snps_hsphy_power_on(struct phy *phy)
+{
+	struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
+	int ret;
+
+	clk_enable_bulk(&priv->clks);
+
+	ret = reset_deassert_bulk(&priv->resets);
+	if (ret)
+		return ret;
+
+	ret = qcom_snps_hsphy_usb_init(phy);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int qcom_snps_hsphy_power_off(struct phy *phy)
+{
+	struct qcom_snps_hsphy *priv = dev_get_priv(phy->dev);
+
+	reset_assert_bulk(&priv->resets);
+	clk_disable_bulk(&priv->clks);
+
+	return 0;
+}
+
+static int qcom_snps_hsphy_phy_probe(struct udevice *dev)
+{
+	struct qcom_snps_hsphy *priv = dev_get_priv(dev);
+	int ret;
+
+	priv->base = dev_read_addr_ptr(dev);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	ret = clk_get_bulk(dev, &priv->clks);
+	if (ret < 0 && ret != -ENOENT) {
+		printf("%s: Failed to get clocks %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = reset_get_bulk(dev, &priv->resets);
+	if (ret < 0) {
+		printf("failed to get resets, ret = %d\n", ret);
+		return ret;
+	}
+
+	clk_enable_bulk(&priv->clks);
+	reset_deassert_bulk(&priv->resets);
+
+	return 0;
+}
+
+static struct phy_ops qcom_snps_hsphy_phy_ops = {
+	.power_on = qcom_snps_hsphy_power_on,
+	.power_off = qcom_snps_hsphy_power_off,
+};
+
+static const struct udevice_id qcom_snps_hsphy_phy_ids[] = {
+	{ .compatible = "qcom,sm8150-usb-hs-phy" },
+	{ .compatible = "qcom,usb-snps-hs-5nm-phy" },
+	{ .compatible = "qcom,usb-snps-hs-7nm-phy" },
+	{ .compatible = "qcom,usb-snps-femto-v2-phy" },
+	{}
+};
+
+U_BOOT_DRIVER(qcom_usb_qcom_snps_hsphy) = {
+	.name = "qcom-snps-hsphy",
+	.id = UCLASS_PHY,
+	.of_match = qcom_snps_hsphy_phy_ids,
+	.ops = &qcom_snps_hsphy_phy_ops,
+	.probe = qcom_snps_hsphy_phy_probe,
+	.priv_auto = sizeof(struct qcom_snps_hsphy),
+};

-- 
2.44.0

