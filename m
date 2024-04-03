Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D079CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:08:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4614788387;
	Wed,  3 Apr 2024 14:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j7j7aknG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E300588238; Wed,  3 Apr 2024 14:07:54 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C387988238
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a4715991c32so815377866b.1
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712146072; x=1712750872; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+o3PpMc4oPrjWdLdX8pAaY+amZFo64S0kQetGnJX5jI=;
 b=j7j7aknGZelmtA/B8PmmAO0uMvWRhmcyFUCy76tVTR8g2JXC9uCUn3lR9JC0gvgMqc
 TrmqExOZm8NEY0gIxoGskoRMwTbUDpVdV5+ntWYwJlq4WpJuXlKoxv5AQ2fybPIcsTfQ
 2njXfp3MMjTXIYehsrIQnJN1LjyIf+CEYDfcQD1b33u9PCxLylHdDJryqr4AD4k9OYol
 zsxnhh9ck7o7Pg2keB3IlhE3TOdw3nYPJEMAPpQ2V4fsQkIei79EQ5AWUc1JWqeoaSpY
 XSNjTJoDZ1C/zbYzz7/eV9kcKB8rYF4YcpB67uzwF04rniUtDcaPpPxhLBpK9e6js95s
 aiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712146072; x=1712750872;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+o3PpMc4oPrjWdLdX8pAaY+amZFo64S0kQetGnJX5jI=;
 b=CC/wg5RsQYbxlwjW1D0EZeHoEedovTWoLNVrpBbcJrSRYFyuExzC7lc/CrFFAX08ux
 j7EDY+Zo9qqF3lhx/loYKAG3GYh2BTo/HfCT4bnRxOZDKUhcBe8g620YzUhYyk0PMYvi
 /YmNwokUB+W/MI2OTG12n6kPQbr+Xqtzyi3eE+6UrW9G1O9UFaZ8MVgjMJa+yumqfoDS
 CdKl8jkafSZYc9DT7pxkpzvTgf36PALXpL9cGzDLo2grvbBGmaIp99lTkjHvZifUb8Ag
 AOdkTTUtWPhcr+/tPwCuPjuUCQ0b4p1Da6veGYnf6kWSFUiWUtmLmpGDjVOFXO/cIkKI
 T62w==
X-Gm-Message-State: AOJu0Yy77932ZF6KfPP2vl8n63fAVSjCGQo6fnLkRBYbrHxQIAeW2KFT
 NEbfvNeDpSiNJCWzdqr2gamtxalY/0nGPhSdjakR3UNwsVd/hb7RIrgp9VpxWAY=
X-Google-Smtp-Source: AGHT+IF3yzq0/VCWTBbY58qHJ/Q4wj5f9+lettpZy+QgHyluI+ucCezxgPNS4jcTtqLUB4uK/9THHA==
X-Received: by 2002:a17:906:c109:b0:a4e:3b78:ed1f with SMTP id
 do9-20020a170906c10900b00a4e3b78ed1fmr11326289ejc.47.1712146072359; 
 Wed, 03 Apr 2024 05:07:52 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 lr20-20020a170906fb9400b00a46a04d7dc4sm7654674ejb.61.2024.04.03.05.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:07:51 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 03 Apr 2024 14:07:38 +0200
Subject: [PATCH v6 03/16] phy: qcom: Add SNPS femto v2 USB HS phy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-b4-qcom-livetree-v6-3-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=8526;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=oOL/DRfxrv8Q9P4HeVQuAVE7WGDbbN6Fr8CRIXm0LIY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmDUaQL1GrMz+gf3ATcnAOOurAGuBnQkWYYIMvr
 V4s1GwpqV+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZg1GkAAKCRAFgzErGV9k
 tk75EACBf++fM19tSb9HvnNGBUNkL+NE7THb5oArslQQI3ynP6rxMifSuZydRbPNiL3V/fDKytT
 BV/tH49A79MJVz9itF0HsBmax/r8LbR0kavFyVan8JJVz8rJLZxMBs4iI/npnsnWsp8ud7pgCxz
 ITJThCewVdyOYIVeMssaHkmvtX9SPDBUyd5hnzOVj5QX5y+NlPh9uSHUyZxlgOMMOgAyDf2bvUU
 eQQCxyNsDHr9xX4IZM6dujvi25PGAPtZy0XRdrtRv7FAgMZ5g/W65h6ExLuFmhkrDXvW4Cn2Pby
 NJ2CCew1PV4v44QAtGdZerzuiAgq8yE7vqg+QvDXKbKNdsV91fTf3MIV72Dl7EGpxpZeP6j3nJM
 Gk2rnbZjYUQnqk1/BfIQ1XOBGlUlKyUKXzKRg97/Ysv85VxeihQASqWFRJwOtx3USCgVU1HG4iN
 cql6FegqVe3l34lwMXT2qQNqCKZkVWL8Orl4R9qf+ppB6r+y8N/101t0g/AR0snBb6XjU38i5Ol
 Kgj1E/XthktQXXYx+gtNh8t0IdCvY6KW9bVhx7BSppW8LDcgaICuL3rKlQ+MVdReWXM7+MMz1Gk
 XYZpH5cJABznQn3pnbMp6p/WIa2B1dKT0tfhY4LWU7Imvx5959AhJawlxFO7N0V39/5uSBZvskb
 CB+fuq/oDlrLTSQ==
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
Acked-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/phy/qcom/Kconfig                  |   8 ++
 drivers/phy/qcom/Makefile                 |   1 +
 drivers/phy/qcom/phy-qcom-snps-femto-v2.c | 216 ++++++++++++++++++++++++++++++
 3 files changed, 225 insertions(+)

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
index 000000000000..a1675b664e46
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-snps-femto-v2.c
@@ -0,0 +1,216 @@
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
+/*
+ * We should just be able to use clrsetbits_le32() here, but this results
+ * in crashes on some boards. This is suspected to be because of some bus
+ * arbitration quirks with the PHY (i.e. it takes several bus clock cycles
+ * for the write to actually go through). The readl_relaxed() at the end will
+ * block until the write is completed (and all registers updated), and thus
+ * ensure that we don't access the PHY registers when they're in an
+ * undetermined state.
+ */
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
+	qcom_snps_hsphy_write_mask(priv->base,
+				   USB2_PHY_USB_PHY_HS_PHY_CTRL_COMMON0, FSEL_MASK, 0);
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

