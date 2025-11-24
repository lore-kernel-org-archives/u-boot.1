Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A66CFD313
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 15:55:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A8B983E60;
	Mon, 24 Nov 2025 16:55:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CsulbleQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OuMXjXda";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A2D083E76; Mon, 24 Nov 2025 16:55:41 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6133783B85
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 16:55:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AOFdnt13112066
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=94MFy+UigqE
 XjUX7/7ItIj0G+oBVlt6UPUzaop2aHtk=; b=CsulbleQ9W7DwDBkFrGe4Ijyvgq
 KesVLs8ElRJH1E/YwOqX2QftD8YIi15yFKfLMFoyHLWcywP3gknkMTOwyrr64fRO
 AAORevQKhyqn13/SnRJF0/b5uLGiX7OV/K8OY9daQXi2Ra5+PT9A0LWtk1wDmY7G
 I5ZwLaOZRsSCQSKaI0s8qM+15UCVph/gEMfFaoQ2jprVeYMuK+c1R+CD5KYuYf+d
 GXokzM2n07x8w6wmAfL2tr0ClKdppdCB/V4UG0/woq5wpViKDglIIKAiBNoVfR+8
 tzveZx8/lTdVmlASt/cbEBERSf1e9rARkOYxL1HEQY5CJ3vl0+DvPLz5Gpg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4amk10hegm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 15:55:36 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-7b952a966d7so8918486b3a.3
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 07:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763999736; x=1764604536; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=94MFy+UigqEXjUX7/7ItIj0G+oBVlt6UPUzaop2aHtk=;
 b=OuMXjXda0fP+vVVIlMQBC8eem7fBMuKPDJWTCUA/VEwqIBfj2J4fVtaYqTNw+yqklQ
 pwT5ES79hEaCJLxnh1pk0mUMIFR2ntD8kk01XcbhhX2u9kGNLfQ37cJBgXInMCOfRmnJ
 xPzSbtbvu64ZlLSYpkusoparm+oV1/1vYjHuqJVL2RWtWrGbRrkhZr7wUfLKt41Ry+8m
 iq0noXZG58C1Y6PV4fzILEpkvqaGOGZZaOGep0IV+HuM56Tsq5f7ghMGvO+gMzDlqpzC
 HNjEoHTh7QtdRA741U+BL/JvGR44J+WKRpIT9fgvI6n8hu+9y+hEEdinb/FZ7f39HkJr
 YvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763999736; x=1764604536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=94MFy+UigqEXjUX7/7ItIj0G+oBVlt6UPUzaop2aHtk=;
 b=f/R2l3wyZ28TP+ve06y8Yv0zNfESIFCV5pMiJo9p0VrXgFMC4Auk0e9RBwght3muU/
 46d7+qtic/ZB4Vnzzgz/2EkWNNO8xMtAGIGKPznOkXSV1jOxrDlujzyiqiugCMJYJj09
 5e8jnLqA7vSiVXq+rrkJR8/HMq0/q+zsbwwbnSM7ZMZWRMWHqELqmCizjY91ABm1h286
 c303yncoacoGqO4I1nm+99aSo/1ttNPp8k1q10Os7v3iqBtPzAcMe8vAsuJHZv+qAR+J
 S7yAMVrlpSS8YGGtyK4KEz0TpYots/G83w4RnK4abRbN08XMQTVnKLCK2g46+VYXJ3Nv
 kobQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUTW/Ly1pDFgGnIcuKP+xm8czApr7UTNnKM9BC1FDOGbH6mC+WZh4gR5zM18/q8iWxK1fhE04=@lists.denx.de
X-Gm-Message-State: AOJu0YzoBRA8Q9JO4oRPeH2MA4EXq3qQ6K2FrMzqWuI4SkXo+ovgZ/4p
 j0sipuZsBqsit9tSUvrIGBYM0Jam+ELlUKwZOspSEyPqoHZW7hWv1bhAsILO96DZ2Bgeyl0TgPt
 mfW41jCGyeGB3Vxs278Am0nW2tw/nvoIv727b9JgjeEGdr7771do7p5lC
X-Gm-Gg: ASbGncsDb1Fs3oFvT3qFZC55ENNOEO2PEQpDmIiC8cMhuJ9g7CNG+3AmoHZ5QGDB/x1
 h2PRWy2XDyXuws+35rOqUHHr/PN3NLNVCB4ZCx8dZlROTHerzRN+LdgP7VqY0aC4PopyJIT6P4S
 5q92NT6tZoXIagM0CrR2ezWsRCQhXTdrKNEnmYABExmtRs5DOIFBZHted+G+5MnMbhrGLh3F1cJ
 w1XBe2IFAgaxWxkgbQTj7JbH7g0UUq0YE5MQmKbuWfY9NO3hlKgHmwiy4T8OGz48jt07Xdd+y4o
 6dATJXh7WoebAfvNXNwF91c07aWCDopr7BxypCnzRcMWC9xjXGYz/aCl+1AITZ0017SysLlJGA9
 8CNFhmwAX+AmYIGUsDg9kN+49ghUkPGSl+1r2uEc+8mvBYsGGuZQoyOPZWYI7Is6g82duj9QcbF
 6MnikuPZ6Ejxuw9G5lbUmSKzW+Mt6QUKHxAIXeKQ==
X-Received: by 2002:a05:6a00:1251:b0:7ab:4fce:fa34 with SMTP id
 d2e1a72fcca58-7c58beb7667mr12844671b3a.1.1763999735179; 
 Mon, 24 Nov 2025 07:55:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF8Y7FzMNEeRcpFgl+Vn7bXxa4EphSIyVnH5xPqFvzB4HuRupr2Cfl5OYuVLm4J/405MXGrvg==
X-Received: by 2002:a05:6a00:1251:b0:7ab:4fce:fa34 with SMTP id
 d2e1a72fcca58-7c58beb7667mr12844622b3a.1.1763999734561; 
 Mon, 24 Nov 2025 07:55:34 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7c3f023fd82sm15254884b3a.42.2025.11.24.07.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 07:55:34 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 malysagreg@gmail.com, arturs.artamonovs@analog.com,
 utsav.agarwal@analog.com, vasileios.bimpikas@analog.com,
 ian.roberts@timesys.com, nathan.morrison@timesys.com, peng.fan@nxp.com,
 alif.zakuan.yuslaimi@altera.com, kory.maincent@bootlin.com,
 sjg@chromium.org, jerome.forissier@linaro.org, ziyao@disroot.org,
 stefan.roese@mailbox.org, mkorpershoek@kernel.org,
 balaji.selvanathan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v2 3/7] drivers: phy: qcom: Add QMP USB3-DP Combo PHY driver
Date: Mon, 24 Nov 2025 21:24:59 +0530
Message-Id: <20251124155503.2839766-4-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251124155503.2839766-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bhBzjyNPKYmvDMDXG1Dv2NLiG31wEkUa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI0MDEzOSBTYWx0ZWRfX2ECD7yzcXsYi
 RFjytHBi8keZkfx0gNF/bWURRmxVcZa79205+ZAehbLTdas8iw0za9b7IDLCQhqi4wE+uWG4G0J
 7NcRjVkpjT9XkMmUK/K4g5NVNroMDQIbdElyWpdBdo6zRFpJkH3A8SPA2tmaqKdQZJKdwKRVs+I
 yS0uNSSazINmUj9Hdd5XHKVgVgJqBxctaAWGSdyDAVytNaMqdsuD6LhcwWv2J9hzjzJranovZh6
 tbuQP336+azYuI27Pfro80yMcRbLixKYOacV2KkXF+OSCKxUtRID/TbubEwhY86fFS+4CXufhBL
 sQJKliF1EZii2jq9l9bxV5YvdX0BXbvJZ/r23zqp+HOxIjjIwNwkpVpxNjA9MxEro88zpoiPAvN
 OmTrOTLGsWl7/5amcVszWbPUyoAI8A==
X-Proofpoint-ORIG-GUID: bhBzjyNPKYmvDMDXG1Dv2NLiG31wEkUa
X-Authority-Analysis: v=2.4 cv=SP9PlevH c=1 sm=1 tr=0 ts=69247ff8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VVcqUrZN0lOw816XaWQA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-24_06,2025-11-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511240139
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

Add support for the Qualcomm QMP USB3-DP Combo PHY found on
SC7280 and QCM6490 platforms. This driver currently implements
USB3 super-speed functionality of the combo PHY.

The QMP Combo PHY is a dual-mode PHY
that can operate in either USB3 mode or DisplayPort mode. This
initial implementation focuses on USB3 mode to enable Super-Speed
USB support.

This is a port of the upstream Linux files to U-Boot:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/phy/qualcomm/phy-qcom-qmp-combo.c?id=3d25d46a255a83f94d7d4d4216f38aafc8e116b0

Enabled and tested the driver on Qualcomm RB3 Gen2 (QCS6490) board.

Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
---
v2:
- Added pipe clock disable in qmp_combo_power_off sequence
- Added all required clocks except pipe clock in qmp_combo_phy_clk_l
- All clocks except pipe clock are enabled and disabled seperate from pipe clock
- Added support for regulator power supplies
- Added a minimal xlate to only return the USB3 phy
---
 drivers/phy/qcom/Kconfig                   |   8 +
 drivers/phy/qcom/Makefile                  |   1 +
 drivers/phy/qcom/phy-qcom-qmp-combo.c      | 642 +++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-common.h     |  62 ++
 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h  |  18 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h |  34 ++
 drivers/phy/qcom/phy-qcom-qmp.h            |  17 +
 7 files changed, 782 insertions(+)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-combo.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 0dd69f7ffd0..49f830abf01 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -12,6 +12,14 @@ config PHY_QCOM_IPQ4019_USB
 	help
 	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
 
+config PHY_QCOM_QMP_COMBO
+	bool "Qualcomm QMP USB3-DP Combo PHY driver"
+	depends on PHY && ARCH_SNAPDRAGON
+	help
+	  Enable this to support the USB3-DP Combo QMP PHY on various Qualcomm
+	  chipsets. This driver supports the USB3 PHY functionality of the combo
+	  PHY (USB3 + DisplayPort). Currently only USB3 mode is supported.
+
 config PHY_QCOM_QMP_PCIE
 	tristate "Qualcomm QMP PCIe PHY driver"
 	depends on PHY && ARCH_SNAPDRAGON
diff --git a/drivers/phy/qcom/Makefile b/drivers/phy/qcom/Makefile
index 1c4e7d8d391..714013dc572 100644
--- a/drivers/phy/qcom/Makefile
+++ b/drivers/phy/qcom/Makefile
@@ -1,5 +1,6 @@
 obj-$(CONFIG_PHY_QCOM_IPQ4019_USB) += phy-qcom-ipq4019-usb.o
 obj-$(CONFIG_MSM8916_USB_PHY) += msm8916-usbh-phy.o
+obj-$(CONFIG_PHY_QCOM_QMP_COMBO) += phy-qcom-qmp-combo.o
 obj-$(CONFIG_PHY_QCOM_QMP_PCIE) += phy-qcom-qmp-pcie.o
 obj-$(CONFIG_PHY_QCOM_QMP_UFS) += phy-qcom-qmp-ufs.o
 obj-$(CONFIG_PHY_QCOM_QUSB2) += phy-qcom-qusb2.o
diff --git a/drivers/phy/qcom/phy-qcom-qmp-combo.c b/drivers/phy/qcom/phy-qcom-qmp-combo.c
new file mode 100644
index 00000000000..f5596aa5e50
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-combo.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <generic-phy.h>
+#include <reset.h>
+#include <power/regulator.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
+#include <linux/compat.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/err.h>
+
+#include "phy-qcom-qmp-common.h"
+
+#include "phy-qcom-qmp.h"
+#include "phy-qcom-qmp-pcs-misc-v3.h"
+#include "phy-qcom-qmp-pcs-usb-v4.h"
+#include "phy-qcom-qmp-dp-com-v3.h"
+
+/* QPHY_V3_DP_COM_RESET_OVRD_CTRL register bits */
+/* DP PHY soft reset */
+#define SW_DPPHY_RESET                          BIT(0)
+/* mux to select DP PHY reset control, 0:HW control, 1: software reset */
+#define SW_DPPHY_RESET_MUX                      BIT(1)
+/* USB3 PHY soft reset */
+#define SW_USB3PHY_RESET                        BIT(2)
+/* mux to select USB3 PHY reset control, 0:HW control, 1: software reset */
+#define SW_USB3PHY_RESET_MUX                    BIT(3)
+
+/* QPHY_V3_DP_COM_PHY_MODE_CTRL register bits */
+#define USB3_MODE                               BIT(0) /* enables USB3 mode */
+#define DP_MODE                                 BIT(1) /* enables DP mode */
+
+/* QPHY_V3_DP_COM_TYPEC_CTRL register bits */
+#define SW_PORTSELECT_MUX                       BIT(1)
+
+/* PHY slot identifiers for device tree phandle arguments */
+#define QMP_USB43DP_USB3_PHY    0
+#define QMP_USB43DP_DP_PHY      1
+
+#define PHY_INIT_COMPLETE_TIMEOUT		10000
+
+struct qmp_combo_offsets {
+	u16 com;
+	u16 txa;
+	u16 rxa;
+	u16 txb;
+	u16 rxb;
+	u16 usb3_serdes;
+	u16 usb3_pcs_misc;
+	u16 usb3_pcs;
+	u16 usb3_pcs_usb;
+};
+
+/*
+ * Initialisation tables
+ */
+
+static const struct qmp_combo_offsets qmp_combo_offsets_v3 = {
+	.com		= 0x0000,
+	.txa		= 0x1200,
+	.rxa		= 0x1400,
+	.txb		= 0x1600,
+	.rxb		= 0x1800,
+	.usb3_serdes	= 0x1000,
+	.usb3_pcs_misc	= 0x1a00,
+	.usb3_pcs	= 0x1c00,
+	.usb3_pcs_usb	= 0x1f00,
+};
+
+static const struct qmp_phy_init_tbl sm8150_usb3_serdes_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_EN_CENTER, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER1, 0x31),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_PER2, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE1_MODE1, 0xde),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SSC_STEP_SIZE2_MODE1, 0x07),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_BUF_ENABLE, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CMN_IPTRIM, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE0, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CP_CTRL_MODE1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE0, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_RCTRL_MODE1, 0x16),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE0, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_PLL_CCTRL_MODE1, 0x36),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_SYSCLK_EN_SEL, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP_EN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE0, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP1_MODE1, 0x34),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_LOCK_CMP2_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DEC_START_MODE1, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE0, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE0, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE0, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START1_MODE1, 0xab),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START2_MODE1, 0xea),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_DIV_FRAC_START3_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE0, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE1_MODE1, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_VCO_TUNE2_MODE1, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_HSCLK_SEL, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_CORECLK_DIV_MODE1, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xca),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xca),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_tx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_TX, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_RX, 0x60),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_LANE_MODE_1, 0xd5),
+	QMP_PHY_INIT_CFG(QSERDES_V4_TX_RCV_DETECT_LVL_2, 0x12),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_TX_PI_QEC_CTRL, 0x40, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_TX_PI_QEC_CTRL, 0x54, 2),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_rx_tbl[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_GAIN, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN, 0x2f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_HIGH, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_PI_CONTROLS, 0x99),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_THRESH2, 0x08),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN1, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_UCDR_SB2_GAIN2, 0x05),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL1, 0x54),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VGA_CAL_CNTRL2, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x77),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_CNTRL, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL, 0x0e),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_RX_RX_MODE_00_LOW, 0xff, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_RX_RX_MODE_00_LOW, 0x7f, 2),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_RX_RX_MODE_00_HIGH, 0x7f, 1),
+	QMP_PHY_INIT_CFG_LANE(QSERDES_V4_RX_RX_MODE_00_HIGH, 0xff, 2),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH2, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_00_HIGH4, 0x97),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_LOW, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH, 0xdc),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH2, 0x5c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH3, 0x7b),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_RX_MODE_01_HIGH4, 0xb4),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_EN_TIMER, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET, 0x38),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_AUX_DATA_TCOARSE_TFINE, 0xa0),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_DCC_CTRL1, 0x0c),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_GM_CAL, 0x1f),
+	QMP_PHY_INIT_CFG(QSERDES_V4_RX_VTH_CODE, 0x10),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_pcs_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG1, 0xd0),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG2, 0x07),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG3, 0x20),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_LOCK_DETECT_CONFIG6, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_REFGEN_REQ_CONFIG1, 0x21),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_RX_SIGDET_LVL, 0xa9),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_CDR_RESET_TIME, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG1, 0x88),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_ALIGN_DETECT_CONFIG2, 0x13),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_PCS_TX_RX_CONFIG, 0x0c),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG1, 0x4b),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_EQ_CONFIG5, 0x10),
+};
+
+static const struct qmp_phy_init_tbl sm8250_usb3_pcs_usb_tbl[] = {
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL, 0xf8),
+	QMP_PHY_INIT_CFG(QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2, 0x07),
+};
+
+struct qmp_phy_cfg {
+	const struct qmp_combo_offsets *offsets;
+	const struct qmp_phy_init_tbl *serdes_tbl;
+	int serdes_tbl_num;
+	const struct qmp_phy_init_tbl *tx_tbl;
+	int tx_tbl_num;
+	const struct qmp_phy_init_tbl *rx_tbl;
+	int rx_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_tbl;
+	int pcs_tbl_num;
+	const struct qmp_phy_init_tbl *pcs_usb_tbl;
+	int pcs_usb_tbl_num;
+	const char * const *vreg_list;
+	int num_vregs;
+	/* true, if PHY needs delay after POWER_DOWN */
+	bool has_pwrdn_delay;
+};
+
+/* list of clocks required by phy */
+static const char * const qmp_combo_phy_clk_l[] = {
+	"aux", "com_aux",
+};
+
+/* list of regulators */
+static const char * const qmp_phy_vreg_l[] = {
+	"vdda-phy",
+	"vdda-pll",
+};
+
+struct qmp_combo {
+	struct udevice *dev;
+	void __iomem *com;
+	void __iomem *serdes;
+	void __iomem *tx;
+	void __iomem *rx;
+	void __iomem *tx2;
+	void __iomem *rx2;
+	void __iomem *pcs;
+	void __iomem *pcs_usb;
+	void __iomem *pcs_misc;
+	struct clk *clks;
+	struct clk *pipe_clk;
+	int num_clks;
+	struct reset_ctl_bulk resets;
+	int num_resets;
+	struct udevice **vregs;
+	int num_vregs;
+	const struct qmp_phy_cfg *cfg;
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
+static int qmp_combo_com_exit(struct qmp_combo *qmp)
+{
+	int i;
+
+	for (i = 0; i < qmp->num_clks; i++)
+		clk_disable(&qmp->clks[i]);
+
+	reset_assert_bulk(&qmp->resets);
+
+	for (i = qmp->num_vregs - 1; i >= 0; i--)
+		regulator_set_enable(qmp->vregs[i], false);
+
+	return 0;
+}
+
+static int qmp_combo_com_init(struct qmp_combo *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *com = qmp->com;
+	void __iomem *pcs = qmp->pcs;
+	u32 val;
+	int ret, i;
+
+	ret = reset_assert_bulk(&qmp->resets);
+	if (ret) {
+		printf("Failed to assert resets: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_deassert_bulk(&qmp->resets);
+	if (ret) {
+		printf("Failed to deassert resets: %d\n", ret);
+		return ret;
+	}
+
+	for (i = 0; i < qmp->num_vregs; i++) {
+		ret = regulator_set_enable(qmp->vregs[i], true);
+		if (ret) {
+			dev_err(qmp->dev, "Failed to enable regulator %d: %d\n", i, ret);
+			while (--i >= 0)
+				regulator_set_enable(qmp->vregs[i], false);
+			reset_assert_bulk(&qmp->resets);
+			return ret;
+		}
+	}
+
+	for (i = 0; i < qmp->num_clks; i++) {
+		ret = clk_enable(&qmp->clks[i]);
+		if (ret) {
+			printf("Failed to enable clock %d: %d\n", i, ret);
+			while (--i >= 0)
+				clk_disable(&qmp->clks[i]);
+			for (i = qmp->num_vregs - 1; i >= 0; i--)
+				regulator_set_enable(qmp->vregs[i], false);
+			reset_assert_bulk(&qmp->resets);
+			return ret;
+		}
+	}
+
+	/* Common block register writes */
+	qphy_setbits(com, QPHY_V3_DP_COM_POWER_DOWN_CTRL, SW_PWRDN);
+	qphy_setbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
+		     SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
+		     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
+
+	val = SW_PORTSELECT_MUX;
+	writel(val, com + QPHY_V3_DP_COM_TYPEC_CTRL);
+
+	writel(USB3_MODE | DP_MODE, com + QPHY_V3_DP_COM_PHY_MODE_CTRL);
+
+	qphy_clrbits(com, QPHY_V3_DP_COM_RESET_OVRD_CTRL,
+		     SW_DPPHY_RESET_MUX | SW_DPPHY_RESET |
+		     SW_USB3PHY_RESET_MUX | SW_USB3PHY_RESET);
+
+	qphy_clrbits(com, QPHY_V3_DP_COM_SWI_CTRL, 0x03);
+
+	qphy_clrbits(com, QPHY_V3_DP_COM_SW_RESET, SW_RESET);
+
+	qphy_setbits(pcs, QPHY_V4_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
+
+	return 0;
+}
+
+static int qmp_combo_usb_power_on(struct qmp_combo *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *serdes = qmp->serdes;
+	void __iomem *tx = qmp->tx;
+	void __iomem *rx = qmp->rx;
+	void __iomem *tx2 = qmp->tx2;
+	void __iomem *rx2 = qmp->rx2;
+	void __iomem *pcs = qmp->pcs;
+	void __iomem *pcs_usb = qmp->pcs_usb;
+	u32 val;
+	int ret;
+
+	/* Serdes configuration */
+	qmp_configure(qmp->dev, serdes, cfg->serdes_tbl, cfg->serdes_tbl_num);
+
+	ret = clk_prepare_enable(qmp->pipe_clk);
+	if (ret) {
+		dev_err(qmp->dev, "pipe_clk enable failed err=%d\n", ret);
+		return ret;
+	}
+
+	/* Tx, Rx configurations */
+	qmp_configure_lane(qmp->dev, tx, cfg->tx_tbl, cfg->tx_tbl_num, 1);
+	qmp_configure_lane(qmp->dev, tx2, cfg->tx_tbl, cfg->tx_tbl_num, 2);
+
+	qmp_configure_lane(qmp->dev, rx, cfg->rx_tbl, cfg->rx_tbl_num, 1);
+	qmp_configure_lane(qmp->dev, rx2, cfg->rx_tbl, cfg->rx_tbl_num, 2);
+
+	/* PCS configuration */
+	qmp_configure(qmp->dev, pcs, cfg->pcs_tbl, cfg->pcs_tbl_num);
+
+	if (pcs_usb) {
+		qmp_configure(qmp->dev, pcs_usb,
+			      cfg->pcs_usb_tbl,
+			      cfg->pcs_usb_tbl_num);
+	}
+
+	if (cfg->has_pwrdn_delay)
+		udelay(20);
+
+	/* Pull PHY out of reset */
+	qphy_clrbits(pcs, QPHY_V4_PCS_SW_RESET, SW_RESET);
+
+	/* Start SerDes and Phy-Coding-Sublayer */
+	qphy_setbits(pcs, QPHY_V4_PCS_START_CONTROL,
+		     SERDES_START | PCS_START);
+
+	/* Wait for PHY initialization */
+	ret = readl_poll_timeout(pcs + QPHY_V4_PCS_PCS_STATUS1, val,
+				 !(val & PHYSTATUS), PHY_INIT_COMPLETE_TIMEOUT);
+
+	if (ret) {
+		printf("QMP USB3 PHY initialization timeout\n");
+		clk_disable(qmp->pipe_clk);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qmp_combo_power_on(struct phy *phy)
+{
+	struct qmp_combo *qmp = dev_get_priv(phy->dev);
+	int ret;
+
+	/* Initialize common block */
+	ret = qmp_combo_com_init(qmp);
+	if (ret)
+		return ret;
+
+	/* Initialize USB3-specific configuration */
+	ret = qmp_combo_usb_power_on(qmp);
+	if (ret) {
+		qmp_combo_com_exit(qmp);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int qmp_combo_power_off(struct phy *phy)
+{
+	struct qmp_combo *qmp = dev_get_priv(phy->dev);
+	void __iomem *com = qmp->com;
+
+	clk_disable(qmp->pipe_clk);
+
+	/* PHY reset */
+	qphy_setbits(qmp->pcs, QPHY_V4_PCS_SW_RESET, SW_RESET);
+
+	/* Stop SerDes and Phy-Coding-Sublayer */
+	qphy_clrbits(qmp->pcs, QPHY_V4_PCS_START_CONTROL,
+		     SERDES_START | PCS_START);
+
+	/* Put PHY into POWER DOWN state: active low */
+	qphy_clrbits(qmp->pcs, QPHY_V4_PCS_POWER_DOWN_CONTROL, SW_PWRDN);
+
+	/* Power down common block */
+	qphy_clrbits(com, QPHY_V3_DP_COM_POWER_DOWN_CTRL, SW_PWRDN);
+
+	return qmp_combo_com_exit(qmp);
+}
+
+static int qmp_combo_reset_init(struct qmp_combo *qmp)
+{
+	struct udevice *dev = qmp->dev;
+	int ret;
+
+	ret = reset_get_bulk(dev, &qmp->resets);
+	if (ret) {
+		printf("Failed to get resets: %d\n", ret);
+		return ret;
+	}
+
+	qmp->num_resets = qmp->resets.count;
+
+	return 0;
+}
+
+static int qmp_combo_clk_init(struct qmp_combo *qmp)
+{
+	struct udevice *dev = qmp->dev;
+	int num = ARRAY_SIZE(qmp_combo_phy_clk_l);
+	int i, ret;
+
+	qmp->clks = devm_kcalloc(dev, num, sizeof(*qmp->clks), GFP_KERNEL);
+	if (!qmp->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		ret = clk_get_by_name(dev, qmp_combo_phy_clk_l[i], &qmp->clks[i]);
+		if (ret) {
+			dev_err(dev, "failed to get %s clock: %d\n",
+				qmp_combo_phy_clk_l[i], ret);
+			return ret;
+		}
+	}
+
+	qmp->num_clks = num;
+	return 0;
+}
+
+static int qmp_combo_vreg_init(struct qmp_combo *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	struct udevice *dev = qmp->dev;
+	int num = cfg->num_vregs;
+	int i, ret;
+
+	if (!num)
+		return 0;
+
+	qmp->vregs = devm_kcalloc(dev, num, sizeof(*qmp->vregs), GFP_KERNEL);
+	if (!qmp->vregs)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++) {
+		ret = device_get_supply_regulator(dev, cfg->vreg_list[i],
+						  &qmp->vregs[i]);
+		if (ret) {
+			dev_dbg(dev, "regulator %s not found (optional)\n",
+				cfg->vreg_list[i]);
+			qmp->num_vregs = 0;
+			return 0;
+		}
+	}
+
+	qmp->num_vregs = num;
+	dev_dbg(dev, "found %d regulators\n", num);
+	return 0;
+}
+
+static int qmp_combo_parse_dt(struct qmp_combo *qmp)
+{
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	const struct qmp_combo_offsets *offs = cfg->offsets;
+	struct udevice *dev = qmp->dev;
+	void __iomem *base;
+	int ret;
+
+	if (!offs)
+		return -EINVAL;
+
+	base = (void __iomem *)dev_read_addr(dev);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	qmp->com = base + offs->com;
+	qmp->serdes = base + offs->usb3_serdes;
+	qmp->tx = base + offs->txa;
+	qmp->rx = base + offs->rxa;
+	qmp->tx2 = base + offs->txb;
+	qmp->rx2 = base + offs->rxb;
+	qmp->pcs = base + offs->usb3_pcs;
+	qmp->pcs_usb = base + offs->usb3_pcs_usb;
+	qmp->pcs_misc = base + offs->usb3_pcs_misc;
+
+	ret = qmp_combo_clk_init(qmp);
+	if (ret)
+		return ret;
+
+	qmp->pipe_clk = devm_clk_get(dev, "usb3_pipe");
+	if (IS_ERR(qmp->pipe_clk)) {
+		dev_err(dev, "failed to get pipe clock (%ld)\n",
+			PTR_ERR(qmp->pipe_clk));
+		return ret;
+	}
+
+	ret = qmp_combo_reset_init(qmp);
+	if (ret)
+		return ret;
+
+	ret = qmp_combo_vreg_init(qmp);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int qmp_combo_probe(struct udevice *dev)
+{
+	struct qmp_combo *qmp = dev_get_priv(dev);
+	int ret;
+
+	qmp->dev = dev;
+	qmp->cfg = (const struct qmp_phy_cfg *)dev_get_driver_data(dev);
+	if (!qmp->cfg) {
+		printf("Failed to get PHY configuration\n");
+		return -EINVAL;
+	}
+
+	ret = qmp_combo_parse_dt(qmp);
+
+	return ret;
+}
+
+static const struct qmp_phy_cfg sc7280_usb3dpphy_cfg = {
+	.offsets		= &qmp_combo_offsets_v3,
+	.serdes_tbl		= sm8150_usb3_serdes_tbl,
+	.serdes_tbl_num		= ARRAY_SIZE(sm8150_usb3_serdes_tbl),
+	.tx_tbl			= sm8250_usb3_tx_tbl,
+	.tx_tbl_num		= ARRAY_SIZE(sm8250_usb3_tx_tbl),
+	.rx_tbl			= sm8250_usb3_rx_tbl,
+	.rx_tbl_num		= ARRAY_SIZE(sm8250_usb3_rx_tbl),
+	.pcs_tbl		= sm8250_usb3_pcs_tbl,
+	.pcs_tbl_num		= ARRAY_SIZE(sm8250_usb3_pcs_tbl),
+	.pcs_usb_tbl		= sm8250_usb3_pcs_usb_tbl,
+	.pcs_usb_tbl_num	= ARRAY_SIZE(sm8250_usb3_pcs_usb_tbl),
+	.vreg_list		= qmp_phy_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
+
+	.has_pwrdn_delay	= true,
+};
+
+static int qmp_combo_xlate(struct phy *phy, struct ofnode_phandle_args *args)
+{
+	if (args->args_count != 1) {
+		debug("Invalid args_count: %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	/* We only support the USB3 phy at slot 0 */
+	if (args->args[0] == QMP_USB43DP_DP_PHY)
+		return -EINVAL;
+
+	phy->id = QMP_USB43DP_USB3_PHY;
+
+	return 0;
+}
+
+static struct phy_ops qmp_combo_ops = {
+	.init = qmp_combo_power_on,
+	.exit = qmp_combo_power_off,
+	.of_xlate = qmp_combo_xlate,
+};
+
+static const struct udevice_id qmp_combo_ids[] = {
+	{
+		.compatible = "qcom,sc7280-qmp-usb3-dp-phy",
+		.data = (ulong)&sc7280_usb3dpphy_cfg,
+	},
+	{ }
+};
+
+U_BOOT_DRIVER(qmp_combo) = {
+	.name = "qcom-qmp-usb3-dp-phy",
+	.id = UCLASS_PHY,
+	.of_match = qmp_combo_ids,
+	.ops = &qmp_combo_ops,
+	.probe = qmp_combo_probe,
+	.priv_auto = sizeof(struct qmp_combo),
+};
diff --git a/drivers/phy/qcom/phy-qcom-qmp-common.h b/drivers/phy/qcom/phy-qcom-qmp-common.h
new file mode 100644
index 00000000000..71356fb7dd0
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-common.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_COMMON_H_
+#define QCOM_PHY_QMP_COMMON_H_
+
+struct qmp_phy_init_tbl {
+	unsigned int offset;
+	unsigned int val;
+	char *name;
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
+		.name = #o,		\
+		.lane_mask = 0xff,	\
+	}
+
+#define QMP_PHY_INIT_CFG_LANE(o, v, l)	\
+	{				\
+		.offset = o,		\
+		.val = v,		\
+		.name = #o,		\
+		.lane_mask = l,		\
+	}
+
+static inline void qmp_configure_lane(struct udevice *dev, void __iomem *base,
+				      const struct qmp_phy_init_tbl tbl[],
+				      int num, u8 lane_mask)
+{
+	int i;
+	const struct qmp_phy_init_tbl *t = tbl;
+
+	if (!t)
+		return;
+
+	for (i = 0; i < num; i++, t++) {
+		if (!(t->lane_mask & lane_mask))
+			continue;
+
+		dev_dbg(dev, "Writing Reg: %s Offset: 0x%04x Val: 0x%02x\n",
+			t->name, t->offset, t->val);
+		writel(t->val, base + t->offset);
+	}
+}
+
+static inline void qmp_configure(struct udevice *dev, void __iomem *base,
+				 const struct qmp_phy_init_tbl tbl[], int num)
+{
+	qmp_configure_lane(dev, base, tbl, num, 0xff);
+}
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h b/drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
new file mode 100644
index 00000000000..396179ef38b
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_DP_COM_V3_H_
+#define QCOM_PHY_QMP_DP_COM_V3_H_
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
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
new file mode 100644
index 00000000000..d7fd4ac0fc5
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_USB_V4_H_
+#define QCOM_PHY_QMP_PCS_USB_V4_H_
+
+/* Only for QMP V4 PHY - USB3 PCS registers */
+#define QPHY_V4_PCS_USB3_POWER_STATE_CONFIG1		0x000
+#define QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_STATUS		0x004
+#define QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_CTRL		0x008
+#define QPHY_V4_PCS_USB3_AUTONOMOUS_MODE_CTRL2		0x00c
+#define QPHY_V4_PCS_USB3_LFPS_RXTERM_IRQ_SOURCE_STATUS	0x010
+#define QPHY_V4_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR		0x014
+#define QPHY_V4_PCS_USB3_LFPS_DET_HIGH_COUNT_VAL	0x018
+#define QPHY_V4_PCS_USB3_LFPS_TX_ECSTART		0x01c
+#define QPHY_V4_PCS_USB3_LFPS_PER_TIMER_VAL		0x020
+#define QPHY_V4_PCS_USB3_LFPS_TX_END_CNT_U3_START	0x024
+#define QPHY_V4_PCS_USB3_RXEQTRAINING_LOCK_TIME		0x028
+#define QPHY_V4_PCS_USB3_RXEQTRAINING_WAIT_TIME		0x02c
+#define QPHY_V4_PCS_USB3_RXEQTRAINING_CTLE_TIME		0x030
+#define QPHY_V4_PCS_USB3_RXEQTRAINING_WAIT_TIME_S2	0x034
+#define QPHY_V4_PCS_USB3_RXEQTRAINING_DFE_TIME_S2	0x038
+#define QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_L		0x03c
+#define QPHY_V4_PCS_USB3_RCVR_DTCT_DLY_U3_H		0x040
+#define QPHY_V4_PCS_USB3_ARCVR_DTCT_EN_PERIOD		0x044
+#define QPHY_V4_PCS_USB3_ARCVR_DTCT_CM_DLY		0x048
+#define QPHY_V4_PCS_USB3_TXONESZEROS_RUN_LENGTH		0x04c
+#define QPHY_V4_PCS_USB3_ALFPS_DEGLITCH_VAL		0x050
+#define QPHY_V4_PCS_USB3_SIGDET_STARTUP_TIMER_VAL	0x054
+#define QPHY_V4_PCS_USB3_TEST_CONTROL			0x058
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp.h b/drivers/phy/qcom/phy-qcom-qmp.h
index 99f4d447caf..06dac21ddc4 100644
--- a/drivers/phy/qcom/phy-qcom-qmp.h
+++ b/drivers/phy/qcom/phy-qcom-qmp.h
@@ -12,12 +12,17 @@
 #include "phy-qcom-qmp-qserdes-com-v3.h"
 #include "phy-qcom-qmp-qserdes-txrx-v3.h"
 
+#include "phy-qcom-qmp-qserdes-com-v4.h"
+#include "phy-qcom-qmp-qserdes-txrx-v4.h"
+
 #include "phy-qcom-qmp-qserdes-pll.h"
 
 #include "phy-qcom-qmp-pcs-v2.h"
 
 #include "phy-qcom-qmp-pcs-v3.h"
 
+#include "phy-qcom-qmp-pcs-v4.h"
+
 /* Only for QMP V3 & V4 PHY - DP COM registers */
 #define QPHY_V3_DP_COM_PHY_MODE_CTRL			0x00
 #define QPHY_V3_DP_COM_SW_RESET				0x04
@@ -112,4 +117,16 @@
 #define QSERDES_V6_DP_PHY_AUX_INTERRUPT_STATUS		0x0e0
 #define QSERDES_V6_DP_PHY_STATUS			0x0e4
 
+/* QPHY_SW_RESET bit */
+#define SW_RESET                                BIT(0)
+/* QPHY_POWER_DOWN_CONTROL */
+#define SW_PWRDN                                BIT(0)
+
+/* QPHY_START_CONTROL bits */
+#define SERDES_START                            BIT(0)
+#define PCS_START                               BIT(1)
+
+/* QPHY_PCS_STATUS bit */
+#define PHYSTATUS                               BIT(6)
+
 #endif
-- 
2.34.1

