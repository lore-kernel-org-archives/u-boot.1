Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D2CCD1296
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:36:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A9288848A;
	Fri,  5 Apr 2024 10:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O2Q0divp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C949F884D5; Fri,  5 Apr 2024 10:36:05 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E32B6884CE
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:36:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6ecee5c08e6so1559595b3a.3
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712306161; x=1712910961; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wbd+4+vzLqyYdVx5elQ+F+rLnlUDfcLuUuWCsNuEOTw=;
 b=O2Q0divp7H3EIL/3JmD0qjp+BFgg/DUVFJcJahmnbZazFFnPn8RFpQPxo4x/zth1/A
 yeEF8QVPYcPZ/qmCfu/HbPst5JBWRhZal7if4wdf9V+NmNF3t5Np9X/c5AItFC06OviY
 YST2BVP+wNS8aQJs4VAmMtpatFw6BOqjCHvoAG6ecD0BEGq2rr8nC9MEPBWLaQsOroU5
 kZ2gFhCJqG32xBfVeZVTR436bls9YbdW4qo1me+yZEt7IRgFCaWky3hvcLr7t0bPhVM1
 IskdYx0+2Ia3gf1seqrhDvQYCCzwgI8LIhvtp79EAdb/WNQgQigPuNawgkRcybW6gapd
 P2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712306161; x=1712910961;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbd+4+vzLqyYdVx5elQ+F+rLnlUDfcLuUuWCsNuEOTw=;
 b=gEDegH0tyw8Zl6JafXIFjH+lWZhRyVVxgng6VxYd8VeOgZsxCjyZW0Vh2Awdg7ZfZq
 vHPMVb7JepHL8vn1ECjaKi3K2MwcSER4LI7hFOL5i3vWNsL10p0cLM6EPrRUsP1rWHpJ
 2xst7JFRVzLwy4Uv3WzQlM/4BH557XQyTuLUse9/Sa5ApwtCBFQRxnqby3wq7wIRiD+D
 O8LmKgD5xIdixgxh/hRYRPDOPjQuSSAW5D8oataHpSLQsV57il6JXqVz6ojXkBe4LuvW
 lm4z4xn1iFSrsIMERrkgGVepN5RF+aeLc3HHojfESOCHJPYhofF9hsFmj3gnfa5H5RyX
 Gh1A==
X-Gm-Message-State: AOJu0YxRfxYR4YQ8cdn3qKvPUSnx2PRBlnynBzALgj635u0pRPcNMx7N
 2SjOTCIR/j8/0h1Sa7NbiuqHDZGbDjqCo+aMQBWXpQ81XCtvjhdgNmQyXwv9WKA=
X-Google-Smtp-Source: AGHT+IFh17io0tDYq005Cw1DG3tl33EUeRpEqCBy16/STwvL4FpNbR6200k5K+YyjDtVrp6xZvLohQ==
X-Received: by 2002:a05:6a21:7794:b0:1a7:1b6e:4da with SMTP id
 bd20-20020a056a21779400b001a71b6e04damr873277pzc.27.1712306161153; 
 Fri, 05 Apr 2024 01:36:01 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 b12-20020a170902650c00b001e27e52a7e4sm1006572plk.285.2024.04.05.01.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:36:00 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Apr 2024 10:35:48 +0200
Subject: [PATCH 1/2] phy: qcom: add Synopsys eUSB2 PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240405-topic-sm8x50-usb-phy-v1-1-8a8604bf818f@linaro.org>
References: <20240405-topic-sm8x50-usb-phy-v1-0-8a8604bf818f@linaro.org>
In-Reply-To: <20240405-topic-sm8x50-usb-phy-v1-0-8a8604bf818f@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=13606;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fsi1edW9v875tRgBlvMZrXErsat7dNJJ9PpKPAqec7E=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7fpGLpi/DPpH18MrZxgenqcqZVnWI8DLgxjddea
 12IM3HOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+36QAKCRB33NvayMhJ0dT2D/
 0SH9h4IMqfo8oqiLtRjGAOjOZfCUqF11ZMLXXwZfLgTjqMg36UlOFbeBEGwDL3KhECaaWky/su0eyc
 PBhrnCJ/mrSVM2qmDDaro9Gpb8gShz6klcgSYx0WAu9qTrpDen+CtB4uQjd7Qe027p8P6ViIqArs5A
 4p7TRNSyILkQW2b027bIO9LqMcaocFOd9ny46L8XecX0u1PS3KeizzD6ryJ/vylLPJ0yXvgz6ictL9
 h8c8hVyj8ACzuU1K255KsbJgZS7M5lJqyMFfDN8C+H/EX2lozlg4/ib9gx1mzvw4XT5CGPurWqfwGZ
 2kGH4duhlQPdqai82fAtqxCAVJi9PSAazwHfCpM+AWklPLvLaFgGdPRsDputB/jQrGtd4k69Kz5NXv
 Cv02M/ICcM7tE8ypLAYJ4d+E0wsCSbfnrZY3WXNo1CGX7swmHiFBI/SN6oLDYQEZyb7miVyZ2rnsPJ
 +SMnu8TBjT8CFnLddsyCcf1QFFylRfYX/c9QBZeMFK0Nrm8UvZQyJ0eA62IvLwhDwGwWfFMetK0c8C
 k4cOp/6kLFDtjih8a59f5dU9tOmKpXX9b/kZtLT72GVFDqjnelHobYZEVuY82dAw4Yt8DQyp5iO4EV
 liGCKFZGTKNR7UE7tvbFYZVNAxGHhaIxP51SrCRpMTlPRqVptpplCx2ip3CA==
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

Add a driver for the new Synopsys eUSB2 PHY found in the SM8550
and SM8650 SoCs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qcom/Kconfig               |   8 +
 drivers/phy/qcom/Makefile              |   1 +
 drivers/phy/qcom/phy-qcom-snps-eusb2.c | 365 +++++++++++++++++++++++++++++++++
 3 files changed, 374 insertions(+)

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index b9fe608c279..3aae1813352 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -27,6 +27,14 @@ config PHY_QCOM_USB_SNPS_FEMTO_V2
 	  High-Speed PHY driver. This driver supports the Hi-Speed PHY which
 	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
 
+config PHY_QCOM_SNPS_EUSB2
+	tristate "Qualcomm Synopsys eUSB2 High-Speed PHY"
+	depends on PHY && ARCH_SNAPDRAGON
+	help
+	  Enable this to support the Qualcomm Synopsys DesignWare eUSB2
+	  High-Speed PHY driver. This driver supports the Hi-Speed PHY which
+	  is usually paired with Synopsys DWC3 USB IPs on MSM SOCs.
+
 config PHY_QCOM_USB_HS_28NM
 	tristate "Qualcomm 28nm High-Speed PHY"
 	depends on PHY && ARCH_SNAPDRAGON
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index 5f4db4a5378..a5153061dfb 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -2,5 +2,6 @@ obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
 obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
+obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_HS_28NM) += phy-qcom-usb-hs-28nm.o
 obj-$(CONFIG_PHY_QCOM_USB_SS) += phy-qcom-usb-ss.o
diff --git a/drivers/phy/qcom/phy-qcom-snps-eusb2.c b/drivers/phy/qcom/phy-qcom-snps-eusb2.c
new file mode 100644
index 00000000000..853b88458b7
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-snps-eusb2.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023-2024, Linaro Limited
+ *
+ * Based on the Linux phy-qcom-snps-eusb2.c driver
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
+#include <linux/bitfield.h>
+#include <linux/clk-provider.h>
+#include <linux/delay.h>
+
+#define USB_PHY_UTMI_CTRL0		(0x3c)
+#define SLEEPM				BIT(0)
+#define OPMODE_MASK			GENMASK(4, 3)
+#define OPMODE_NONDRIVING		BIT(3)
+
+#define USB_PHY_UTMI_CTRL5		(0x50)
+#define POR				BIT(1)
+
+#define USB_PHY_HS_PHY_CTRL_COMMON0	(0x54)
+#define PHY_ENABLE			BIT(0)
+#define SIDDQ_SEL			BIT(1)
+#define SIDDQ				BIT(2)
+#define RETENABLEN			BIT(3)
+#define FSEL_MASK			GENMASK(6, 4)
+#define FSEL_19_2_MHZ_VAL		(0x0)
+#define FSEL_38_4_MHZ_VAL		(0x4)
+
+#define USB_PHY_CFG_CTRL_1		(0x58)
+#define PHY_CFG_PLL_CPBIAS_CNTRL_MASK	GENMASK(7, 1)
+
+#define USB_PHY_CFG_CTRL_2		(0x5c)
+#define PHY_CFG_PLL_FB_DIV_7_0_MASK	GENMASK(7, 0)
+#define DIV_7_0_19_2_MHZ_VAL		(0x90)
+#define DIV_7_0_38_4_MHZ_VAL		(0xc8)
+
+#define USB_PHY_CFG_CTRL_3		(0x60)
+#define PHY_CFG_PLL_FB_DIV_11_8_MASK	GENMASK(3, 0)
+#define DIV_11_8_19_2_MHZ_VAL		(0x1)
+#define DIV_11_8_38_4_MHZ_VAL		(0x0)
+
+#define PHY_CFG_PLL_REF_DIV		GENMASK(7, 4)
+#define PLL_REF_DIV_VAL			(0x0)
+
+#define USB_PHY_HS_PHY_CTRL2		(0x64)
+#define VBUSVLDEXT0			BIT(0)
+#define USB2_SUSPEND_N			BIT(2)
+#define USB2_SUSPEND_N_SEL		BIT(3)
+#define VBUS_DET_EXT_SEL		BIT(4)
+
+#define USB_PHY_CFG_CTRL_4		(0x68)
+#define PHY_CFG_PLL_GMP_CNTRL_MASK	GENMASK(1, 0)
+#define PHY_CFG_PLL_INT_CNTRL_MASK	GENMASK(7, 2)
+
+#define USB_PHY_CFG_CTRL_5		(0x6c)
+#define PHY_CFG_PLL_PROP_CNTRL_MASK	GENMASK(4, 0)
+#define PHY_CFG_PLL_VREF_TUNE_MASK	GENMASK(7, 6)
+
+#define USB_PHY_CFG_CTRL_6		(0x70)
+#define PHY_CFG_PLL_VCO_CNTRL_MASK	GENMASK(2, 0)
+
+#define USB_PHY_CFG_CTRL_7		(0x74)
+
+#define USB_PHY_CFG_CTRL_8		(0x78)
+#define PHY_CFG_TX_FSLS_VREF_TUNE_MASK	GENMASK(1, 0)
+#define PHY_CFG_TX_FSLS_VREG_BYPASS	BIT(2)
+#define PHY_CFG_TX_HS_VREF_TUNE_MASK	GENMASK(5, 3)
+#define PHY_CFG_TX_HS_XV_TUNE_MASK	GENMASK(7, 6)
+
+#define USB_PHY_CFG_CTRL_9		(0x7c)
+#define PHY_CFG_TX_PREEMP_TUNE_MASK	GENMASK(2, 0)
+#define PHY_CFG_TX_RES_TUNE_MASK	GENMASK(4, 3)
+#define PHY_CFG_TX_RISE_TUNE_MASK	GENMASK(6, 5)
+#define PHY_CFG_RCAL_BYPASS		BIT(7)
+
+#define USB_PHY_CFG_CTRL_10		(0x80)
+
+#define USB_PHY_CFG0			(0x94)
+#define DATAPATH_CTRL_OVERRIDE_EN	BIT(0)
+#define CMN_CTRL_OVERRIDE_EN		BIT(1)
+
+#define UTMI_PHY_CMN_CTRL0		(0x98)
+#define TESTBURNIN			BIT(6)
+
+#define USB_PHY_FSEL_SEL		(0xb8)
+#define FSEL_SEL			BIT(0)
+
+#define USB_PHY_APB_ACCESS_CMD		(0x130)
+#define RW_ACCESS			BIT(0)
+#define APB_START_CMD			BIT(1)
+#define APB_LOGIC_RESET			BIT(2)
+
+#define USB_PHY_APB_ACCESS_STATUS	(0x134)
+#define ACCESS_DONE			BIT(0)
+#define TIMED_OUT			BIT(1)
+#define ACCESS_ERROR			BIT(2)
+#define ACCESS_IN_PROGRESS		BIT(3)
+
+#define USB_PHY_APB_ADDRESS		(0x138)
+#define APB_REG_ADDR_MASK		GENMASK(7, 0)
+
+#define USB_PHY_APB_WRDATA_LSB		(0x13c)
+#define APB_REG_WRDATA_7_0_MASK		GENMASK(3, 0)
+
+#define USB_PHY_APB_WRDATA_MSB		(0x140)
+#define APB_REG_WRDATA_15_8_MASK	GENMASK(7, 4)
+
+#define USB_PHY_APB_RDDATA_LSB		(0x144)
+#define APB_REG_RDDATA_7_0_MASK		GENMASK(3, 0)
+
+#define USB_PHY_APB_RDDATA_MSB		(0x148)
+#define APB_REG_RDDATA_15_8_MASK	GENMASK(7, 4)
+
+struct qcom_snps_eusb2_phy_priv {
+	void __iomem *base;
+	struct clk *ref_clk;
+	struct reset_ctl_bulk resets;
+};
+
+static void qcom_snps_eusb2_hsphy_write_mask(void __iomem *base, u32 offset,
+					     u32 mask, u32 val)
+{
+	u32 reg;
+
+	reg = readl_relaxed(base + offset);
+	reg &= ~mask;
+	reg |= val & mask;
+	writel_relaxed(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl_relaxed(base + offset);
+}
+
+static void qcom_eusb2_default_parameters(struct qcom_snps_eusb2_phy_priv *qcom_snps_eusb2)
+{
+	/* default parameters: tx pre-emphasis */
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_9,
+					 PHY_CFG_TX_PREEMP_TUNE_MASK,
+					 FIELD_PREP(PHY_CFG_TX_PREEMP_TUNE_MASK, 0));
+
+	/* tx rise/fall time */
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_9,
+					 PHY_CFG_TX_RISE_TUNE_MASK,
+					 FIELD_PREP(PHY_CFG_TX_RISE_TUNE_MASK, 0x2));
+
+	/* source impedance adjustment */
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_9,
+					 PHY_CFG_TX_RES_TUNE_MASK,
+					 FIELD_PREP(PHY_CFG_TX_RES_TUNE_MASK, 0x1));
+
+	/* dc voltage level adjustement */
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_8,
+					 PHY_CFG_TX_HS_VREF_TUNE_MASK,
+					 FIELD_PREP(PHY_CFG_TX_HS_VREF_TUNE_MASK, 0x3));
+
+	/* transmitter HS crossover adjustement */
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_8,
+					 PHY_CFG_TX_HS_XV_TUNE_MASK,
+					 FIELD_PREP(PHY_CFG_TX_HS_XV_TUNE_MASK, 0x0));
+}
+
+static int qcom_eusb2_ref_clk_init(struct qcom_snps_eusb2_phy_priv *qcom_snps_eusb2)
+{
+	unsigned long ref_clk_freq = clk_get_rate(qcom_snps_eusb2->ref_clk);
+
+	switch (ref_clk_freq) {
+	case 19200000:
+		qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL_COMMON0,
+						 FSEL_MASK,
+						 FIELD_PREP(FSEL_MASK, FSEL_19_2_MHZ_VAL));
+
+		qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_2,
+						 PHY_CFG_PLL_FB_DIV_7_0_MASK,
+						 DIV_7_0_19_2_MHZ_VAL);
+
+		qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_3,
+						 PHY_CFG_PLL_FB_DIV_11_8_MASK,
+						 DIV_11_8_19_2_MHZ_VAL);
+		break;
+
+	case 38400000:
+		qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL_COMMON0,
+						 FSEL_MASK,
+						 FIELD_PREP(FSEL_MASK, FSEL_38_4_MHZ_VAL));
+
+		qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_2,
+						 PHY_CFG_PLL_FB_DIV_7_0_MASK,
+						 DIV_7_0_38_4_MHZ_VAL);
+
+		qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_3,
+						 PHY_CFG_PLL_FB_DIV_11_8_MASK,
+						 DIV_11_8_38_4_MHZ_VAL);
+		break;
+
+	default:
+		printf("%s: unsupported ref_clk_freq:%lu\n", __func__, ref_clk_freq);
+		return -EINVAL;
+	}
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_3,
+					 PHY_CFG_PLL_REF_DIV, PLL_REF_DIV_VAL);
+
+	return 0;
+}
+
+static int qcom_snps_eusb2_usb_init(struct phy *phy)
+{
+	struct qcom_snps_eusb2_phy_priv *qcom_snps_eusb2 = dev_get_priv(phy->dev);
+	int ret;
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG0,
+					 CMN_CTRL_OVERRIDE_EN, CMN_CTRL_OVERRIDE_EN);
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_UTMI_CTRL5, POR, POR);
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL_COMMON0,
+					 PHY_ENABLE | RETENABLEN, PHY_ENABLE | RETENABLEN);
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_APB_ACCESS_CMD,
+					 APB_LOGIC_RESET, APB_LOGIC_RESET);
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, UTMI_PHY_CMN_CTRL0, TESTBURNIN, 0);
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_FSEL_SEL,
+					 FSEL_SEL, FSEL_SEL);
+
+	/* update ref_clk related registers */
+	ret = qcom_eusb2_ref_clk_init(qcom_snps_eusb2);
+	if (ret)
+		return ret;
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_1,
+					 PHY_CFG_PLL_CPBIAS_CNTRL_MASK,
+					 FIELD_PREP(PHY_CFG_PLL_CPBIAS_CNTRL_MASK, 0x1));
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_4,
+					 PHY_CFG_PLL_INT_CNTRL_MASK,
+					 FIELD_PREP(PHY_CFG_PLL_INT_CNTRL_MASK, 0x8));
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_4,
+					 PHY_CFG_PLL_GMP_CNTRL_MASK,
+					 FIELD_PREP(PHY_CFG_PLL_GMP_CNTRL_MASK, 0x1));
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_5,
+					 PHY_CFG_PLL_PROP_CNTRL_MASK,
+					 FIELD_PREP(PHY_CFG_PLL_PROP_CNTRL_MASK, 0x10));
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_6,
+					 PHY_CFG_PLL_VCO_CNTRL_MASK,
+					 FIELD_PREP(PHY_CFG_PLL_VCO_CNTRL_MASK, 0x0));
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_CFG_CTRL_5,
+					 PHY_CFG_PLL_VREF_TUNE_MASK,
+					 FIELD_PREP(PHY_CFG_PLL_VREF_TUNE_MASK, 0x1));
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL2,
+					 VBUS_DET_EXT_SEL, VBUS_DET_EXT_SEL);
+
+	/* set default parameters */
+	qcom_eusb2_default_parameters(qcom_snps_eusb2);
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL2,
+					 USB2_SUSPEND_N_SEL | USB2_SUSPEND_N,
+					 USB2_SUSPEND_N_SEL | USB2_SUSPEND_N);
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_UTMI_CTRL0, SLEEPM, SLEEPM);
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL_COMMON0,
+					 SIDDQ_SEL, SIDDQ_SEL);
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL_COMMON0,
+					 SIDDQ, 0);
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_UTMI_CTRL5, POR, 0);
+
+	qcom_snps_eusb2_hsphy_write_mask(qcom_snps_eusb2->base, USB_PHY_HS_PHY_CTRL2,
+					 USB2_SUSPEND_N_SEL, 0);
+
+	return 0;
+}
+
+static int qcom_snps_eusb2_phy_power_on(struct phy *phy)
+{
+	struct qcom_snps_eusb2_phy_priv *qcom_snps_eusb2 = dev_get_priv(phy->dev);
+	int ret;
+
+	/* TODO Repeater */
+
+	clk_prepare_enable(qcom_snps_eusb2->ref_clk);
+
+	ret = reset_deassert_bulk(&qcom_snps_eusb2->resets);
+	if (ret)
+		return ret;
+
+	ret = qcom_snps_eusb2_usb_init(phy);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int qcom_snps_eusb2_phy_power_off(struct phy *phy)
+{
+	struct qcom_snps_eusb2_phy_priv *qcom_snps_eusb2 = dev_get_priv(phy->dev);
+
+	reset_assert_bulk(&qcom_snps_eusb2->resets);
+	clk_disable_unprepare(qcom_snps_eusb2->ref_clk);
+
+	return 0;
+}
+
+static int qcom_snps_eusb2_phy_probe(struct udevice *dev)
+{
+	struct qcom_snps_eusb2_phy_priv *qcom_snps_eusb2 = dev_get_priv(dev);
+	int ret;
+
+	qcom_snps_eusb2->base = (void __iomem *)dev_read_addr(dev);
+	if (IS_ERR(qcom_snps_eusb2->base))
+		return PTR_ERR(qcom_snps_eusb2->base);
+
+	qcom_snps_eusb2->ref_clk = devm_clk_get(dev, "ref");
+	if (IS_ERR(qcom_snps_eusb2->ref_clk)) {
+		printf("%s: failed to get ref clk %d\n", __func__, ret);
+		return PTR_ERR(qcom_snps_eusb2->ref_clk);
+	}
+
+	ret = reset_get_bulk(dev, &qcom_snps_eusb2->resets);
+	if (ret < 0) {
+		printf("failed to get resets, ret = %d\n", ret);
+		return ret;
+
+	return 0;
+}
+
+static struct phy_ops qcom_snps_eusb2_phy_ops = {
+	.power_on = qcom_snps_eusb2_phy_power_on,
+	.power_off = qcom_snps_eusb2_phy_power_off,
+};
+
+static const struct udevice_id qcom_snps_eusb2_phy_ids[] = {
+	{
+		.compatible = "qcom,sm8550-snps-eusb2-phy",
+	},
+	{}
+};
+
+U_BOOT_DRIVER(qcom_usb_qcom_snps_eusb2) = {
+	.name = "qcom-snps-eusb2-hsphy",
+	.id = UCLASS_PHY,
+	.of_match = qcom_snps_eusb2_phy_ids,
+	.ops = &qcom_snps_eusb2_phy_ops,
+	.probe = qcom_snps_eusb2_phy_probe,
+	.priv_auto = sizeof(struct qcom_snps_eusb2_phy_priv),
+};

-- 
2.34.1

