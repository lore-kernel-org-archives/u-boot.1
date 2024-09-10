Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFF6ECE564
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BC7388F77;
	Tue, 10 Sep 2024 11:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y1Lht24i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38D6388F73; Tue, 10 Sep 2024 11:12:13 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4061888F5A
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:12:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42cb1e623d1so5218105e9.0
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725959525; x=1726564325; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nidXXNGcQjymbt+GEmcB/Fl8okx6qd74QfPAUzf4y6s=;
 b=y1Lht24iprTT8+VfyohQ+A3qx0mbZ/+AsObznFH/d8+JNMwbyMgHRCCFtNgd2W0dg4
 2YjgpKuIoVTcG2CWDRAL/tCQ4g4v0qpzW/q8sVeDTkPn19ib/4cciURFHaJQ0rs7Dp2r
 O7o+UrO7bfGdhCKy1eMYGBD22iXZddX1wUsV2c27JNmiW4xoXnbNY5sL3evukDDdzyM8
 +7fSG7W+Z3dGn46NQ0zceOsF5a87zMXoT2XXN42blhycU5i352a6gZi3qZb03ZCrsTOG
 AllKsT8thIasKPmXoHjfl4XCoN16tCjXDauyM16oEggrz3jsU7VXlSRAgftfxlSTRX4/
 EiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725959525; x=1726564325;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nidXXNGcQjymbt+GEmcB/Fl8okx6qd74QfPAUzf4y6s=;
 b=dAPSEnGdmluRhOIHu3T31VBgcxMu2cLAyi8zDeWZuoIHmB9uMJbA2Kb+Q27yf1+Fme
 oztI1V0axUWROk2tov6Q0IUyUoCqWZ6KtuK9SgMfJ6RqKUWRcb2lYVhw6Zvfone/dGCB
 8LSNN8ExoJq+s39I+6lLrEwDVAX4FsQqabTS5H2fWBRVGl4wUj6LND0DzIteYYk/R/r+
 we7Hv2ky7yAxcLKqpvlyz6wbxJ9quRZIPpfqy5EH1R6chjc0tYQVTen2B+Oa0t2/qrBs
 Qo8VwYu6dne20v+WiyXBRysdABYaHppr+UoOSayCTzM2kedl/fDbXhZ4fwYtwOnmowGg
 dLDg==
X-Gm-Message-State: AOJu0Yx2A20J2IvKSZ1y47idFVSF0dVe7IvYXhqZphYA7azWQr0/uL4v
 n7Osp0UB/t/JTaFul9nsc/NC1SqiKBI6GTVBA+JOehw+58H9k7/TDp9cj7OmYRFPPIOQEUAz3ND
 O
X-Google-Smtp-Source: AGHT+IEkI+rIAuWFcYCroO8V3y80uvQwaDTSHmswIJ2xS6hK+/dDbuLtxLtcYJIiJCmqNGkbnZwx6g==
X-Received: by 2002:a5d:6608:0:b0:371:a60e:a821 with SMTP id
 ffacd0b85a97d-37889682bdbmr7995621f8f.38.1725959524748; 
 Tue, 10 Sep 2024 02:12:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649733sm8294798f8f.8.2024.09.10.02.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:12:04 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 10 Sep 2024 11:11:58 +0200
Subject: [PATCH 2/2] phy: qcom: Add QMP UFS PHY driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-qcom-phy-v1-2-21ff4b87b962@linaro.org>
References: <20240910-topic-ufs-qcom-phy-v1-0-21ff4b87b962@linaro.org>
In-Reply-To: <20240910-topic-ufs-qcom-phy-v1-0-21ff4b87b962@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=44859;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Wljsmsa0Vx1UejP2W2vFdn69V/wOwm/aBtpTcKuRfb4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A1htvX2YLqkAfAoa/GyuY71GN9Yi5bGP9QfvA92
 3/dNKuyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuANYQAKCRB33NvayMhJ0XVjD/
 9ldRjpag95Ne6p0WPwImEaD3NLM1F4le+bUlu4zMNDwo+5TstmpObJ2BrDXvyYL15lLk/27oFjZE8m
 KWeSMlE/1mb8cpdQfP/Os5JKeufh2QC0Oc8nHF5JDEx651bc0Jx0p2J0mchLADdFOqOGBehXF+u42j
 Tu5vx+i2fh7qSgDbHUthuvNkAECZlK0D1Q89fUlR+uze5sRSTIaMPedquaxJl5iNKyhLVn/Gs7JHbv
 thcnyjnr0YNlZpJC4kbkcPIaeZsC+k77XN1/0RM8wQ+iVPv0wvJH14J+ftC7/le3OewCxd4ONUbMp0
 EktT3IYMZ2IRs1nsOyckf/BT/CrjYsmxVTAEG3nAFVH6ja4Uo1YLYhM6/8RpuHG2pEwhP/D4Djzieu
 wgnFMsN4Ty5iOAyXh5XOsRFfJwLdvDMBJa69hbBoG+9vhEzpfzEOG+Ov9jmWACtcEF55ff1SqgFLfu
 Ns/Z3xRewSo5pHa+LtxzCMdnz+5a1l94PMck9XpBPJFz4lmMU7LTwEeDUAReD5a3jkIVHV320LHe4p
 0FFBjQwCnlC21uf7SvKhCN84IZrgCJtypxgDzS4tbdvHk140CWQMH+HmV4fYW8pOQvAdMC8yA1UZ2O
 Z/MxnPx7r5CCFVDqsT0+LtwoFY7dqYDxDh3B/IqLZgvQaGMhk78uSMYVKnUQ==
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

From: Bhupesh Sharma <bhupesh.linux@gmail.com>

Add Qualcomm QMP UFS PHY driver which is available on the following
Snapdragon SoCs - SDM845, SM8250, SM8550 and SM8650 SoCs.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qcom/Kconfig            |    6 +
 drivers/phy/qcom/Makefile           |    1 +
 drivers/phy/qcom/phy-qcom-qmp-ufs.c | 1116 +++++++++++++++++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp.h     |  115 ++++
 4 files changed, 1238 insertions(+)

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 3aae1813352..5c77203d606 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -12,6 +12,12 @@ config PHY_QCOM_IPQ4019_USB
 	help
 	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
 
+config PHY_QCOM_QMP_UFS
+	tristate "Qualcomm QMP UFS PHY driver"
+	depends on PHY && ARCH_SNAPDRAGON
+	help
+	  Enable this to support the UFS QMP PHY on various Qualcomm chipsets.
+
 config PHY_QCOM_QUSB2
 	tristate "Qualcomm USB QUSB2 PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index a5153061dfb..dc3ed492696 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
+obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
 obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2) += phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2) += phy-qcom-snps-eusb2.o
diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
new file mode 100644
index 00000000000..8908a34df54
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -0,0 +1,1116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2023-2024 Linaro Limited
+ * Authors:
+ * - Bhupesh Sharma <bhupesh.sharma@linaro.org>
+ * - Neil Armstrong <neil.armstrong@linaro.org>
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
+#include <linux/ioport.h>
+
+#include "phy-qcom-qmp.h"
+#include "phy-qcom-qmp-pcs-ufs-v2.h"
+#include "phy-qcom-qmp-pcs-ufs-v3.h"
+#include "phy-qcom-qmp-pcs-ufs-v4.h"
+#include "phy-qcom-qmp-pcs-ufs-v5.h"
+#include "phy-qcom-qmp-pcs-ufs-v6.h"
+
+#include "phy-qcom-qmp-qserdes-com-v4.h"
+#include "phy-qcom-qmp-qserdes-com-v6.h"
+#include "phy-qcom-qmp-qserdes-txrx-v4.h"
+#include "phy-qcom-qmp-qserdes-txrx-ufs-v6.h"
+
+/* QPHY_SW_RESET bit */
+#define SW_RESET				BIT(0)
+/* QPHY_POWER_DOWN_CONTROL */
+#define SW_PWRDN				BIT(0)
+/* QPHY_START_CONTROL bits */
+#define SERDES_START				BIT(0)
+#define PCS_START				BIT(1)
+/* QPHY_PCS_READY_STATUS bit */
+#define PCS_READY				BIT(0)
+
+#define PHY_INIT_COMPLETE_TIMEOUT		(200 * 10000)
+
+struct qmp_ufs_init_tbl {
+	unsigned int offset;
+	unsigned int val;
+	/*
+	 * mask of lanes for which this register is written
+	 * for cases when second lane needs different values
+	 */
+	u8 lane_mask;
+};
+
+#define QMP_PHY_INIT_CFG(o, v)		\
+	{				\
+		.offset = o,		\
+		.val = v,		\
+		.lane_mask = 0xff,	\
+	}
+
+#define QMP_PHY_INIT_CFG_LANE(o, v, l)	\
+	{				\
+		.offset = o,		\
+		.val = v,		\
+		.lane_mask = l,		\
+	}
+
+/* set of registers with offsets different per-PHY */
+enum qphy_reg_layout {
+	/* PCS registers */
+	QPHY_SW_RESET,
+	QPHY_START_CTRL,
+	QPHY_PCS_READY_STATUS,
+	QPHY_PCS_POWER_DOWN_CONTROL,
+	/* Keep last to ensure regs_layout arrays are properly initialized */
+	QPHY_LAYOUT_SIZE
+};
+
+static const unsigned int ufsphy_v2_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_START_CTRL]		= QPHY_V2_PCS_UFS_PHY_START,
+	[QPHY_PCS_READY_STATUS]		= QPHY_V2_PCS_UFS_READY_STATUS,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V2_PCS_UFS_POWER_DOWN_CONTROL,
+};
+
+static const unsigned int ufsphy_v3_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_START_CTRL]		= QPHY_V3_PCS_UFS_PHY_START,
+	[QPHY_PCS_READY_STATUS]		= QPHY_V3_PCS_UFS_READY_STATUS,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V3_PCS_UFS_POWER_DOWN_CONTROL,
+};
+
+static const unsigned int ufsphy_v4_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_START_CTRL]		= QPHY_V4_PCS_UFS_PHY_START,
+	[QPHY_PCS_READY_STATUS]		= QPHY_V4_PCS_UFS_READY_STATUS,
+	[QPHY_SW_RESET]			= QPHY_V4_PCS_UFS_SW_RESET,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL,
+};
+
+static const unsigned int ufsphy_v6_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_START_CTRL]		= QPHY_V6_PCS_UFS_PHY_START,
+	[QPHY_PCS_READY_STATUS]		= QPHY_V6_PCS_UFS_READY_STATUS,
+	[QPHY_SW_RESET]			= QPHY_V6_PCS_UFS_SW_RESET,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_PCS_UFS_POWER_DOWN_CONTROL,
+};
+
+static const struct qmp_ufs_init_tbl sdm845_ufsphy_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYS_CLK_CTRL, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_BG_TIMER, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_IVCO, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CMN_CONFIG, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SYSCLK_EN_SEL, 0xd5),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_RESETSM_CNTRL, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CLK_SELECT, 0x30),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_HSCLK_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_CTRL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CORE_CLK_EN, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_SVS_MODE_CLK_SEL, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_INITVAL1, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE0, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE0, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE0, 0xda),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE0, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE0, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_DEC_START_MODE1, 0x98),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE1, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE1_MODE1, 0xc1),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE2_MODE1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP1_MODE1, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_LOCK_CMP2_MODE1, 0x0f),
+};
+
+static const struct qmp_ufs_init_tbl sdm845_ufsphy_hs_b_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_COM_VCO_TUNE_MAP, 0x44),
+};
+
+static const struct qmp_ufs_init_tbl sdm845_ufsphy_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_LANE_MODE_1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX, 0x07),
+};
+
+static const struct qmp_ufs_init_tbl sdm845_ufsphy_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_LVL, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_CNTRL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_INTERFACE_MODE, 0x40),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN, 0x0b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_TERM_BW, 0x5b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SVS_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_PI_CONTROLS, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V3_RX_RX_MODE_00, 0x59),
+};
+
+static const struct qmp_ufs_init_tbl sdm845_ufsphy_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL2, 0x6e),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SYM_RESYNC_CTRL, 0x03),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_SIGDET_CTRL1, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_RX_MIN_HIBERN8_TIME, 0x9a),
+	QMP_PHY_INIT_CFG(QPHY_V3_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
+};
+
+static const struct qmp_ufs_init_tbl sm8150_ufsphy_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0xd9),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_HS_SWITCH_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE0, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xac),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE1, 0x98),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE1, 0x32),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE1, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xdd),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x23),
+};
+
+static const struct qmp_ufs_init_tbl sm8150_ufsphy_hs_b_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x06),
+};
+
+static const struct qmp_ufs_init_tbl sm8150_ufsphy_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_TRAN_DRVR_EMP_EN, 0x0c),
+};
+
+static const struct qmp_ufs_init_tbl sm8150_ufsphy_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_LVL, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_BAND, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x4b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0xf1),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xf6),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x3d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xe0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb1),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_LOW, 0xe0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH2, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_10_HIGH4, 0xb1),
+};
+
+static const struct qmp_ufs_init_tbl sm8150_ufsphy_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2, 0x6d),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_DEBUG_BUS_CLKSEL, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_RX_MIN_HIBERN8_TIME, 0xff),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
+};
+
+static const struct qmp_ufs_init_tbl sm8150_ufsphy_hs_g4_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x10),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_UFS_BIST_FIXED_PAT_CTRL, 0x0a),
+};
+
+static const struct qmp_ufs_init_tbl sm8250_ufsphy_hs_g4_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xe5),
+};
+
+static const struct qmp_ufs_init_tbl sm8250_ufsphy_hs_g4_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CTRL2, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FO_GAIN, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_TERM_BW, 0x6f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_MEASURE_TIME, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_LOW, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x2c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0x3c),
+};
+
+static const struct qmp_ufs_init_tbl sm8550_ufsphy_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0xd9),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),
+};
+
+static const struct qmp_ufs_init_tbl sm8550_ufsphy_hs_b_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x44),
+};
+
+static const struct qmp_ufs_init_tbl sm8550_ufsphy_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_FR_DCC_CTRL, 0x4c),
+};
+
+static const struct qmp_ufs_init_tbl sm8550_ufsphy_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x0e),
+
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xc2),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xc2),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6, 0x60),
+
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B3, 0x9e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B6, 0x60),
+
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B3, 0x9e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B4, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B5, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
+
+};
+
+static const struct qmp_ufs_init_tbl sm8550_ufsphy_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x69),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x2b),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY, 0x4f),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME, 0x9e),
+};
+
+static const struct qmp_ufs_init_tbl sm8650_ufsphy_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_SYSCLK_EN_SEL, 0xd9),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_CONFIG_1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_SEL_1, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP_EN, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_IVCO_MODE1, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IETRIM, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CMN_IPTRIM, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_MAP, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE0, 0x41),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE0, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE0, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_DEC_START_MODE1, 0x4c),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_RCTRL_MODE1, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_PLL_CCTRL_MODE1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP1_MODE1, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V6_COM_LOCK_CMP2_MODE1, 0x07),
+};
+
+static const struct qmp_ufs_init_tbl sm8650_ufsphy_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_LANE_MODE_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX, 0x0e),
+};
+
+static const struct qmp_ufs_init_tbl sm8650_ufsphy_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4, 0x1c),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL, 0x3e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0, 0xce),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1, 0xce),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B2, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B4, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B3, 0x9e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE2_B6, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B3, 0x9e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B4, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B5, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE3_B8, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B0, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B1, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B2, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B3, 0xb9),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_MODE_RATE4_B4, 0x4f),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_SO_SATURATION, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_UCDR_PI_CTRL1, 0x94),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_RX_TERM_BW_CTRL0, 0xfa),
+	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL, 0x30),
+};
+
+static const struct qmp_ufs_init_tbl sm8650_ufsphy_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PCS_CTRL1, 0xc1),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0f),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2, 0x68),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S4, 0x0e),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S5, 0x12),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S6, 0x15),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S7, 0x19),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x04),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_PLL_CNTL, 0x33),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY, 0x05),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY, 0x05),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY, 0x4d),
+	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME, 0x9e),
+};
+
+struct qmp_ufs_offsets {
+	u16 serdes;
+	u16 pcs;
+	u16 tx;
+	u16 rx;
+	/* for PHYs with >= 2 lanes */
+	u16 tx2;
+	u16 rx2;
+};
+
+struct qmp_ufs_cfg_tbls {
+	/* Init sequence for PHY blocks - serdes, tx, rx, pcs */
+	const struct qmp_ufs_init_tbl *serdes;
+	int serdes_num;
+	const struct qmp_ufs_init_tbl *tx;
+	int tx_num;
+	const struct qmp_ufs_init_tbl *rx;
+	int rx_num;
+	const struct qmp_ufs_init_tbl *pcs;
+	int pcs_num;
+};
+
+/* struct qmp_ufs_cfg - per-PHY initialization config */
+struct qmp_ufs_cfg {
+	int lanes;
+
+	const struct qmp_ufs_offsets *offsets;
+
+	/* Main init sequence for PHY blocks - serdes, tx, rx, pcs */
+	const struct qmp_ufs_cfg_tbls tbls;
+	/* Additional sequence for HS Series B */
+	const struct qmp_ufs_cfg_tbls tbls_hs_b;
+	/* Additional sequence for HS G4 */
+	const struct qmp_ufs_cfg_tbls tbls_hs_g4;
+
+	/* clock ids to be requested */
+	const char * const *clk_list;
+	int num_clks;
+	/* regulators to be requested */
+	const char * const *vreg_list;
+	int num_vregs;
+	/* resets to be requested */
+	const char * const *reset_list;
+	int num_resets;
+
+	/* array of registers with different offsets */
+	const unsigned int *regs;
+
+	/* true, if PCS block has no separate SW_RESET register */
+	bool no_pcs_sw_reset;
+};
+
+struct qmp_ufs_priv {
+	struct phy *phy;
+
+	void __iomem *serdes;
+	void __iomem *pcs;
+	void __iomem *pcs_misc;
+	void __iomem *tx;
+	void __iomem *rx;
+	void __iomem *tx2;
+	void __iomem *rx2;
+
+	struct clk *clks;
+	unsigned int clk_count;
+
+	struct reset_ctl *resets;
+	unsigned int reset_count;
+
+	const struct qmp_ufs_cfg *cfg;
+
+	struct udevice *dev;
+
+	u32 mode;
+	u32 submode;
+};
+
+static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg |= val;
+	writel(reg, base + offset);
+
+	/* ensure that above write is through */
+	readl(base + offset);
+}
+
+static inline void qphy_clrbits(void __iomem *base, u32 offset, u32 val)
+{
+	u32 reg;
+
+	reg = readl(base + offset);
+	reg &= ~val;
+	writel(reg, base + offset);
+
+	/* ensure that above write is through */
+	readl(base + offset);
+}
+
+/* list of clocks required by phy */
+static const char * const sdm845_ufs_phy_clk_l[] = {
+	"ref", "ref_aux",
+};
+
+/* list of regulators */
+static const char * const qmp_ufs_vreg_l[] = {
+	"vdda-phy", "vdda-pll",
+};
+
+/* list of resets */
+static const char * const qmp_ufs_reset_l[] = {
+	"ufsphy",
+};
+
+static const struct qmp_ufs_offsets qmp_ufs_offsets = {
+	.serdes		= 0,
+	.pcs		= 0xc00,
+	.tx		= 0x400,
+	.rx		= 0x600,
+	.tx2		= 0x800,
+	.rx2		= 0xa00,
+};
+
+static const struct qmp_ufs_offsets qmp_ufs_offsets_v6 = {
+	.serdes		= 0,
+	.pcs		= 0x0400,
+	.tx		= 0x1000,
+	.rx		= 0x1200,
+	.tx2		= 0x1800,
+	.rx2		= 0x1a00,
+};
+
+static const struct qmp_ufs_cfg sdm845_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.offsets		= &qmp_ufs_offsets,
+
+	.tbls = {
+		.serdes		= sdm845_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_serdes),
+		.tx		= sdm845_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sdm845_ufsphy_tx),
+		.rx		= sdm845_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sdm845_ufsphy_rx),
+		.pcs		= sdm845_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sdm845_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes		= sdm845_ufsphy_hs_b_serdes,
+		.serdes_num	= ARRAY_SIZE(sdm845_ufsphy_hs_b_serdes),
+	},
+	.clk_list		= sdm845_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
+	.vreg_list		= qmp_ufs_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_ufs_vreg_l),
+	.regs			= ufsphy_v3_regs_layout,
+
+	.no_pcs_sw_reset	= true,
+};
+
+static const struct qmp_ufs_cfg sm8250_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.offsets		= &qmp_ufs_offsets,
+
+	.tbls = {
+		.serdes		= sm8150_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_serdes),
+		.tx		= sm8150_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8150_ufsphy_tx),
+		.rx		= sm8150_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8150_ufsphy_rx),
+		.pcs		= sm8150_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes		= sm8150_ufsphy_hs_b_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8150_ufsphy_hs_b_serdes),
+	},
+	.tbls_hs_g4 = {
+		.tx		= sm8250_ufsphy_hs_g4_tx,
+		.tx_num		= ARRAY_SIZE(sm8250_ufsphy_hs_g4_tx),
+		.rx		= sm8250_ufsphy_hs_g4_rx,
+		.rx_num		= ARRAY_SIZE(sm8250_ufsphy_hs_g4_rx),
+		.pcs		= sm8150_ufsphy_hs_g4_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8150_ufsphy_hs_g4_pcs),
+	},
+	.clk_list		= sdm845_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
+	.vreg_list		= qmp_ufs_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_ufs_vreg_l),
+	.reset_list		= qmp_ufs_reset_l,
+	.num_resets		= ARRAY_SIZE(qmp_ufs_reset_l),
+	.regs			= ufsphy_v4_regs_layout,
+
+	.no_pcs_sw_reset	= false,
+};
+
+static const struct qmp_ufs_cfg sm8550_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.offsets		= &qmp_ufs_offsets_v6,
+
+	.tbls = {
+		.serdes		= sm8550_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_serdes),
+		.tx		= sm8550_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8550_ufsphy_tx),
+		.rx		= sm8550_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8550_ufsphy_rx),
+		.pcs		= sm8550_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8550_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes		= sm8550_ufsphy_hs_b_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8550_ufsphy_hs_b_serdes),
+	},
+	.clk_list		= sdm845_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
+	.vreg_list		= qmp_ufs_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_ufs_vreg_l),
+	.regs			= ufsphy_v6_regs_layout,
+
+	.no_pcs_sw_reset	= false,
+};
+
+static const struct qmp_ufs_cfg sm8650_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.offsets		= &qmp_ufs_offsets_v6,
+
+	.tbls = {
+		.serdes		= sm8650_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8650_ufsphy_serdes),
+		.tx		= sm8650_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8650_ufsphy_tx),
+		.rx		= sm8650_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8650_ufsphy_rx),
+		.pcs		= sm8650_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8650_ufsphy_pcs),
+	},
+	.clk_list		= sdm845_ufs_phy_clk_l,
+	.num_clks		= ARRAY_SIZE(sdm845_ufs_phy_clk_l),
+	.vreg_list		= qmp_ufs_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_ufs_vreg_l),
+	.regs			= ufsphy_v6_regs_layout,
+
+	.no_pcs_sw_reset	= false,
+};
+
+static void qmp_ufs_configure_lane(void __iomem *base,
+					const struct qmp_ufs_init_tbl tbl[],
+					int num,
+					u8 lane_mask)
+{
+	int i;
+	const struct qmp_ufs_init_tbl *t = tbl;
+
+	if (!t)
+		return;
+
+	for (i = 0; i < num; i++, t++) {
+		if (!(t->lane_mask & lane_mask))
+			continue;
+
+		writel(t->val, base + t->offset);
+	}
+}
+
+static void qmp_ufs_configure(void __iomem *base,
+				   const struct qmp_ufs_init_tbl tbl[],
+				   int num)
+{
+	qmp_ufs_configure_lane(base, tbl, num, 0xff);
+}
+
+static void qmp_ufs_serdes_init(struct qmp_ufs_priv *qmp, const struct qmp_ufs_cfg_tbls *tbls)
+{
+	void __iomem *serdes = qmp->serdes;
+
+	qmp_ufs_configure(serdes, tbls->serdes, tbls->serdes_num);
+}
+
+static void qmp_ufs_lanes_init(struct qmp_ufs_priv *qmp, const struct qmp_ufs_cfg_tbls *tbls)
+{
+	const struct qmp_ufs_cfg *cfg = qmp->cfg;
+	void __iomem *tx = qmp->tx;
+	void __iomem *rx = qmp->rx;
+
+	qmp_ufs_configure_lane(tx, tbls->tx, tbls->tx_num, 1);
+	qmp_ufs_configure_lane(rx, tbls->rx, tbls->rx_num, 1);
+
+	if (cfg->lanes >= 2) {
+		qmp_ufs_configure_lane(qmp->tx2, tbls->tx, tbls->tx_num, 2);
+		qmp_ufs_configure_lane(qmp->rx2, tbls->rx, tbls->rx_num, 2);
+	}
+}
+
+static void qmp_ufs_pcs_init(struct qmp_ufs_priv *qmp, const struct qmp_ufs_cfg_tbls *tbls)
+{
+	void __iomem *pcs = qmp->pcs;
+
+	qmp_ufs_configure(pcs, tbls->pcs, tbls->pcs_num);
+}
+
+static void qmp_ufs_init_registers(struct qmp_ufs_priv *qmp, const struct qmp_ufs_cfg *cfg)
+{
+	/* We support 'PHY_MODE_UFS_HS_B' mode & 'UFS_HS_G3' submode for now. */
+	qmp_ufs_serdes_init(qmp, &cfg->tbls);
+	qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_b);
+	qmp_ufs_serdes_init(qmp, &cfg->tbls_hs_g4);
+	qmp_ufs_lanes_init(qmp, &cfg->tbls);
+	qmp_ufs_pcs_init(qmp, &cfg->tbls);
+}
+
+static int qmp_ufs_do_reset(struct qmp_ufs_priv *qmp)
+{
+	int i, ret;
+
+	for (i = 0; i < qmp->reset_count; i++) {
+		ret = reset_assert(&qmp->resets[i]);
+		if (ret)
+			return ret;
+	}
+
+	udelay(10);
+
+	for (i = 0; i < qmp->reset_count; i++) {
+		ret = reset_deassert(&qmp->resets[i]);
+		if (ret)
+			return ret;
+	}
+
+	udelay(50);
+
+	return 0;
+}
+
+static int qmp_ufs_power_on(struct phy *phy)
+{
+	struct qmp_ufs_priv *qmp = dev_get_priv(phy->dev);
+	const struct qmp_ufs_cfg *cfg = qmp->cfg;
+	void __iomem *pcs = qmp->pcs;
+	void __iomem *status;
+	unsigned int val;
+	int ret;
+
+	/* Power down PHY */
+	qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL], SW_PWRDN);
+
+	qmp_ufs_init_registers(qmp, cfg);
+
+	if (cfg->no_pcs_sw_reset) {
+		ret = qmp_ufs_do_reset(qmp);
+		if (ret) {
+			dev_err(phy->dev, "qmp reset failed\n");
+			return ret;
+		}
+	}
+
+	/* Pull PHY out of reset state */
+	if (!cfg->no_pcs_sw_reset)
+		qphy_clrbits(pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
+
+	/* start SerDes */
+	qphy_setbits(pcs, cfg->regs[QPHY_START_CTRL], SERDES_START);
+
+	status = pcs + cfg->regs[QPHY_PCS_READY_STATUS];
+	ret = readl_poll_timeout(status, val, (val & PCS_READY), PHY_INIT_COMPLETE_TIMEOUT);
+	if (ret) {
+		dev_err(phy->dev, "phy initialization timed-out\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qmp_ufs_power_off(struct phy *phy)
+{
+	struct qmp_ufs_priv *qmp = dev_get_priv(phy->dev);
+	const struct qmp_ufs_cfg *cfg = qmp->cfg;
+
+	/* PHY reset */
+	qphy_setbits(qmp->pcs, cfg->regs[QPHY_SW_RESET], SW_RESET);
+
+	/* stop SerDes and Phy-Coding-Sublayer */
+	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_START_CTRL],
+			SERDES_START | PCS_START);
+
+	/* Put PHY into POWER DOWN state: active low */
+	qphy_clrbits(qmp->pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
+			SW_PWRDN);
+
+	clk_release_all(qmp->clks, qmp->clk_count);
+
+	return 0;
+}
+
+static int qmp_ufs_vreg_init(struct udevice *dev, struct qmp_ufs_priv *qmp)
+{
+	/* TOFIX: Add regulator support, but they should be voted at boot time already */
+
+	return 0;
+}
+
+static int qmp_ufs_reset_init(struct udevice *dev, struct qmp_ufs_priv *qmp)
+{
+	const struct qmp_ufs_cfg *cfg = qmp->cfg;
+	int num = cfg->num_resets;
+	int i, ret;
+
+	qmp->reset_count = 0;
+	qmp->resets = devm_kcalloc(dev, num, sizeof(*qmp->resets), GFP_KERNEL);
+	if (!qmp->resets)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		ret = reset_get_by_index(dev, i, &qmp->resets[i]);
+		if (ret < 0) {
+			dev_err(dev, "failed to get reset %d\n", i);
+			goto reset_get_err;
+		}
+
+		++qmp->reset_count;
+	}
+
+	return 0;
+
+reset_get_err:
+	ret = reset_release_all(qmp->resets, qmp->reset_count);
+	if (ret)
+		dev_warn(dev, "failed to disable all resets\n");
+
+	return ret;
+}
+
+static int qmp_ufs_clk_init(struct udevice *dev, struct qmp_ufs_priv *qmp)
+{
+	const struct qmp_ufs_cfg *cfg = qmp->cfg;
+	int num = cfg->num_clks;
+	int i, ret;
+
+	qmp->clk_count = 0;
+	qmp->clks = devm_kcalloc(dev, num, sizeof(*qmp->clks), GFP_KERNEL);
+	if (!qmp->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		ret = clk_get_by_index(dev, i, &qmp->clks[i]);
+		if (ret < 0)
+			goto clk_get_err;
+
+		ret = clk_enable(&qmp->clks[i]);
+		if (ret && ret != -ENOSYS) {
+			dev_err(dev, "failed to enable clock %d\n", i);
+			goto clk_get_err;
+		}
+
+		++qmp->clk_count;
+	}
+
+	return 0;
+
+clk_get_err:
+	ret = clk_release_all(qmp->clks, qmp->clk_count);
+	if (ret)
+		dev_warn(dev, "failed to disable all clocks\n");
+
+	return ret;
+}
+
+static int qmp_ufs_probe_generic_child(struct udevice *dev,
+				       ofnode child)
+{
+	struct qmp_ufs_priv *qmp = dev_get_priv(dev);
+	const struct qmp_ufs_cfg *cfg = qmp->cfg;
+	struct resource res;
+	int ret;
+
+	/*
+	 * Get memory resources for the PHY:
+	 * Resources are indexed as: tx -> 0; rx -> 1; pcs -> 2.
+	 * For dual lane PHYs: tx2 -> 3, rx2 -> 4, pcs_misc (optional) -> 5
+	 * For single lane PHYs: pcs_misc (optional) -> 3.
+	 */
+	ret = ofnode_read_resource(child, 0, &res);
+	if (ret) {
+		dev_err(dev, "can't get reg property of child %s\n",
+			ofnode_get_name(child));
+		return ret;
+	}
+
+	qmp->tx = (void __iomem *)res.start;
+
+	ret = ofnode_read_resource(child, 1, &res);
+	if (ret) {
+		dev_err(dev, "can't get reg property of child %s\n",
+			ofnode_get_name(child));
+		return ret;
+	}
+
+	qmp->rx = (void __iomem *)res.start;
+
+	ret = ofnode_read_resource(child, 2, &res);
+	if (ret) {
+		dev_err(dev, "can't get reg property of child %s\n",
+			ofnode_get_name(child));
+		return ret;
+	}
+
+	qmp->pcs = (void __iomem *)res.start;
+
+	if (cfg->lanes >= 2) {
+		ret = ofnode_read_resource(child, 3, &res);
+		if (ret) {
+			dev_err(dev, "can't get reg property of child %s\n",
+				ofnode_get_name(child));
+			return ret;
+		}
+
+		qmp->tx2 = (void __iomem *)res.start;
+
+		ret = ofnode_read_resource(child, 4, &res);
+		if (ret) {
+			dev_err(dev, "can't get reg property of child %s\n",
+				ofnode_get_name(child));
+			return ret;
+		}
+
+		qmp->rx2 = (void __iomem *)res.start;
+
+		ret = ofnode_read_resource(child, 5, &res);
+		if (ret)
+			qmp->pcs_misc = NULL;
+	} else {
+		ret = ofnode_read_resource(child, 3, &res);
+		if (ret)
+			qmp->pcs_misc = NULL;
+	}
+
+	return 0;
+}
+
+static int qmp_ufs_probe_dt_children(struct udevice *dev)
+{
+	int ret;
+	ofnode child;
+
+	ofnode_for_each_subnode(child, dev_ofnode(dev)) {
+		ret = qmp_ufs_probe_generic_child(dev, child);
+		if (ret) {
+			dev_err(dev, "Cannot parse child %s:%d\n",
+				ofnode_get_name(child), ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int qmp_ufs_probe(struct udevice *dev)
+{
+	struct qmp_ufs_priv *qmp = dev_get_priv(dev);
+	int ret;
+
+	qmp->serdes = (void __iomem *)dev_read_addr(dev);
+	if (IS_ERR(qmp->serdes))
+		return PTR_ERR(qmp->serdes);
+
+	qmp->cfg = (const struct qmp_ufs_cfg *)dev_get_driver_data(dev);
+	if (!qmp->cfg)
+		return -EINVAL;
+
+	ret = qmp_ufs_clk_init(dev, qmp);
+	if (ret) {
+		dev_err(dev, "failed to get UFS clks\n");
+		return ret;
+	}
+
+	ret = qmp_ufs_vreg_init(dev, qmp);
+	if (ret) {
+		dev_err(dev, "failed to get UFS voltage regulators\n");
+		return ret;
+	}
+
+	if (qmp->cfg->no_pcs_sw_reset) {
+		ret = qmp_ufs_reset_init(dev, qmp);
+		if (ret) {
+			dev_err(dev, "failed to get UFS resets\n");
+			return ret;
+		}
+	}
+
+	qmp->dev = dev;
+
+	if (ofnode_get_child_count(dev_ofnode(dev))) {
+		ret = qmp_ufs_probe_dt_children(dev);
+		if (ret) {
+			dev_err(dev, "failed to get UFS dt regs\n");
+			return ret;
+		}
+	} else {
+		const struct qmp_ufs_offsets *offs = qmp->cfg->offsets;
+		struct resource res;
+
+		if (!qmp->cfg->offsets) {
+			dev_err(dev, "missing UFS offsets\n");
+			return -EINVAL;
+		}
+
+		ret = ofnode_read_resource(dev_ofnode(dev), 0, &res);
+		if (ret) {
+			dev_err(dev, "can't get reg property\n");
+			return ret;
+		}
+
+		qmp->serdes = (void __iomem *)res.start + offs->serdes;
+		qmp->pcs = (void __iomem *)res.start + offs->pcs;
+		qmp->tx = (void __iomem *)res.start + offs->tx;
+		qmp->rx = (void __iomem *)res.start + offs->rx;
+
+		if (qmp->cfg->lanes >= 2) {
+			qmp->tx2 = (void __iomem *)res.start + offs->tx2;
+			qmp->rx2 = (void __iomem *)res.start + offs->rx2;
+		}
+	}
+
+	return 0;
+}
+
+static struct phy_ops qmp_ufs_ops = {
+	.power_on = qmp_ufs_power_on,
+	.power_off = qmp_ufs_power_off,
+};
+
+static const struct udevice_id qmp_ufs_ids[] = {
+	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
+	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
+	{ .compatible = "qcom,sm8550-qmp-ufs-phy", .data = (ulong)&sm8550_ufsphy_cfg },
+	{ .compatible = "qcom,sm8650-qmp-ufs-phy", .data = (ulong)&sm8650_ufsphy_cfg },
+	{ }
+};
+
+U_BOOT_DRIVER(qcom_qmp_ufs) = {
+	.name		= "qcom-qmp-ufs",
+	.id		= UCLASS_PHY,
+	.of_match	= qmp_ufs_ids,
+	.ops		= &qmp_ufs_ops,
+	.probe		= qmp_ufs_probe,
+	.priv_auto	= sizeof(struct qmp_ufs_priv),
+};
diff --git a/drivers/phy/qcom/phy-qcom-qmp.h b/drivers/phy/qcom/phy-qcom-qmp.h
new file mode 100644
index 00000000000..99f4d447caf
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_H_
+#define QCOM_PHY_QMP_H_
+
+#include "phy-qcom-qmp-qserdes-com.h"
+#include "phy-qcom-qmp-qserdes-txrx.h"
+
+#include "phy-qcom-qmp-qserdes-com-v3.h"
+#include "phy-qcom-qmp-qserdes-txrx-v3.h"
+
+#include "phy-qcom-qmp-qserdes-pll.h"
+
+#include "phy-qcom-qmp-pcs-v2.h"
+
+#include "phy-qcom-qmp-pcs-v3.h"
+
+/* Only for QMP V3 & V4 PHY - DP COM registers */
+#define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
+#define QPHY_V3_DP_COM_SW_RESET				0x04
+#define QPHY_V3_DP_COM_POWER_DOWN_CTRL			0x08
+#define QPHY_V3_DP_COM_SWI_CTRL				0x0c
+#define QPHY_V3_DP_COM_TYPEC_CTRL			0x10
+#define QPHY_V3_DP_COM_TYPEC_PWRDN_CTRL			0x14
+#define QPHY_V3_DP_COM_RESET_OVRD_CTRL			0x1c
+
+/* QSERDES V3 COM bits */
+# define QSERDES_V3_COM_BIAS_EN				0x0001
+# define QSERDES_V3_COM_BIAS_EN_MUX			0x0002
+# define QSERDES_V3_COM_CLKBUF_R_EN			0x0004
+# define QSERDES_V3_COM_CLKBUF_L_EN			0x0008
+# define QSERDES_V3_COM_EN_SYSCLK_TX_SEL		0x0010
+# define QSERDES_V3_COM_CLKBUF_RX_DRIVE_L		0x0020
+# define QSERDES_V3_COM_CLKBUF_RX_DRIVE_R		0x0040
+
+/* QSERDES V3 TX bits */
+# define DP_PHY_TXn_TX_EMP_POST1_LVL_MASK		0x001f
+# define DP_PHY_TXn_TX_EMP_POST1_LVL_MUX_EN		0x0020
+# define DP_PHY_TXn_TX_DRV_LVL_MASK			0x001f
+# define DP_PHY_TXn_TX_DRV_LVL_MUX_EN			0x0020
+
+/* QMP PHY - DP PHY registers */
+#define QSERDES_DP_PHY_REVISION_ID0			0x000
+#define QSERDES_DP_PHY_REVISION_ID1			0x004
+#define QSERDES_DP_PHY_REVISION_ID2			0x008
+#define QSERDES_DP_PHY_REVISION_ID3			0x00c
+#define QSERDES_DP_PHY_CFG				0x010
+#define QSERDES_DP_PHY_PD_CTL				0x018
+# define DP_PHY_PD_CTL_PWRDN				0x001
+# define DP_PHY_PD_CTL_PSR_PWRDN			0x002
+# define DP_PHY_PD_CTL_AUX_PWRDN			0x004
+# define DP_PHY_PD_CTL_LANE_0_1_PWRDN			0x008
+# define DP_PHY_PD_CTL_LANE_2_3_PWRDN			0x010
+# define DP_PHY_PD_CTL_PLL_PWRDN			0x020
+# define DP_PHY_PD_CTL_DP_CLAMP_EN			0x040
+#define QSERDES_DP_PHY_MODE				0x01c
+#define QSERDES_DP_PHY_AUX_CFG0				0x020
+#define QSERDES_DP_PHY_AUX_CFG1				0x024
+#define QSERDES_DP_PHY_AUX_CFG2				0x028
+#define QSERDES_DP_PHY_AUX_CFG3				0x02c
+#define QSERDES_DP_PHY_AUX_CFG4				0x030
+#define QSERDES_DP_PHY_AUX_CFG5				0x034
+#define QSERDES_DP_PHY_AUX_CFG6				0x038
+#define QSERDES_DP_PHY_AUX_CFG7				0x03c
+#define QSERDES_DP_PHY_AUX_CFG8				0x040
+#define QSERDES_DP_PHY_AUX_CFG9				0x044
+
+/* Only for QMP V3 PHY - DP PHY registers */
+#define QSERDES_V3_DP_PHY_AUX_INTERRUPT_MASK		0x048
+# define PHY_AUX_STOP_ERR_MASK				0x01
+# define PHY_AUX_DEC_ERR_MASK				0x02
+# define PHY_AUX_SYNC_ERR_MASK				0x04
+# define PHY_AUX_ALIGN_ERR_MASK				0x08
+# define PHY_AUX_REQ_ERR_MASK				0x10
+
+#define QSERDES_V3_DP_PHY_AUX_INTERRUPT_CLEAR		0x04c
+#define QSERDES_V3_DP_PHY_AUX_BIST_CFG			0x050
+
+#define QSERDES_V3_DP_PHY_VCO_DIV			0x064
+#define QSERDES_V3_DP_PHY_TX0_TX1_LANE_CTL		0x06c
+#define QSERDES_V3_DP_PHY_TX2_TX3_LANE_CTL		0x088
+
+#define QSERDES_V3_DP_PHY_SPARE0			0x0ac
+#define DP_PHY_SPARE0_MASK				0x0f
+#define DP_PHY_SPARE0_ORIENTATION_INFO_SHIFT		0x04(0x0004)
+
+#define QSERDES_V3_DP_PHY_STATUS			0x0c0
+
+/* Only for QMP V4 PHY - DP PHY registers */
+#define QSERDES_V4_DP_PHY_CFG_1				0x014
+#define QSERDES_V4_DP_PHY_AUX_INTERRUPT_MASK		0x054
+#define QSERDES_V4_DP_PHY_AUX_INTERRUPT_CLEAR		0x058
+#define QSERDES_V4_DP_PHY_VCO_DIV			0x070
+#define QSERDES_V4_DP_PHY_TX0_TX1_LANE_CTL		0x078
+#define QSERDES_V4_DP_PHY_TX2_TX3_LANE_CTL		0x09c
+#define QSERDES_V4_DP_PHY_SPARE0			0x0c8
+#define QSERDES_V4_DP_PHY_AUX_INTERRUPT_STATUS		0x0d8
+#define QSERDES_V4_DP_PHY_STATUS			0x0dc
+
+/* Only for QMP V4 PHY - PCS_MISC registers */
+#define QPHY_V4_PCS_MISC_TYPEC_CTRL			0x00
+#define QPHY_V4_PCS_MISC_TYPEC_PWRDN_CTRL		0x04
+#define QPHY_V4_PCS_MISC_PCS_MISC_CONFIG1		0x08
+#define QPHY_V4_PCS_MISC_CLAMP_ENABLE			0x0c
+#define QPHY_V4_PCS_MISC_TYPEC_STATUS			0x10
+#define QPHY_V4_PCS_MISC_PLACEHOLDER_STATUS		0x14
+
+/* Only for QMP V6 PHY - DP PHY registers */
+#define QSERDES_V6_DP_PHY_AUX_INTERRUPT_STATUS		0x0e0
+#define QSERDES_V6_DP_PHY_STATUS			0x0e4
+
+#endif

-- 
2.34.1

