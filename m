Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4220ECF34D5
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 15:26:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0A598400F;
	Wed, 19 Nov 2025 16:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jDxwTEjg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P5+zGZZn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 086C983FFF; Wed, 19 Nov 2025 16:26:00 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA40083FF5
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 16:25:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=balaji.selvanathan@oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AJA3AuJ1791813
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LYLFyv6aUxX
 jvkKZnvwKBUAukLObh1XwQ0jbCyk52ew=; b=jDxwTEjgWTUvateHmrm3ChqFYSB
 pnJmsn2hrf5/B1qbgjN5KUMd0+hMRinx2Cq6//9hEWdnpGZkJgweZLfF1bfqthcA
 9cAiQ+z1bRPIHPJkXhFWgcsvaLyJRO4aA45m+r13F2vdjewXT87tKDOFuAb4ZNns
 L8UtuGuM0sKa1GWpBeFkjIR8mvWVC4blKgkHuzHAcw6Nta+bocpV9bAtsFaMCnZl
 VanjD4iA9fHKx6VjS2sq9wh9KJX/BxITMV9tmJBjSQt5RnHHRbw6ISJ0KYTvc9TW
 Ag5MD1493ZUJrzJrz5ubmXMNehYbfzKnoUSmDVsQ1Gl5PHX7k3z5kSTPLhw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ahbt6rurp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 15:25:55 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3436d81a532so14870287a91.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 07:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763565954; x=1764170754; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LYLFyv6aUxXjvkKZnvwKBUAukLObh1XwQ0jbCyk52ew=;
 b=P5+zGZZnZ1pXwWTttHJyQfX6vn+lg9wnPP+YilD/RWXHLZUIBJHzKTkYAGkjEYsql5
 3oEtF3jin5wv/tGRe9hluqRW3rdWByglzT8glIkx0/vOCxtNCl0jsmfN3KF6r+qGV5MK
 x5r5w8L7sgSCFcqg4sUXz5J5x2DxTY9FLaJTNHR8+oatveUJue6SF/6MvltBIDlgMI73
 jPd3+wZw1o8Tb+5ADJHMYwflJdC6R0Pc50b6ITHH6E4W7N4kUPBdk2hmnI5Ez9ofVEm7
 Bm1oOx/avEVVQPhA7fB+uS7vBt18Q0Qs2Y+NV6yb30Umeo/+jX+XaIHm5OVeRmrZWxaP
 THNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763565954; x=1764170754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LYLFyv6aUxXjvkKZnvwKBUAukLObh1XwQ0jbCyk52ew=;
 b=m2uuYnvt4ogx81AtHeM7RZY9skTZELAnJPgBjhL2MyT8RkKCF9kIADVeWKaatYMN2b
 FXG/TsDLOgLpdFc72+rw7LAlG6+kyeIC2HzazMcrPImMLAAxMZa8veaFjxdzapBIx5b6
 O7Gta+VJxESKexqmGgW8hrLHPOVbieByYYLcD90IwAlwkzKtWPrl05g+ZGiIBMHaM0qr
 RDR6rstHQZcPoZ0hs34bXw+ZJYXIoCiIudQ9EOuWOAzvqkVcqtdq4vQ9I6RmbdrjDxeL
 DFY8i5jYLkAQ9rIIdRldGJ3nIepN22yZsAVAuxqnsOQLOyMXbt54Vm7twFcAxPwVp1RK
 E8Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRI10diXY9M54bE8ynPHqeWkCrchfdwQgMK91qH+uRdaMuth1xkE5Lu+N3bkFd3uZqM7uvZkM=@lists.denx.de
X-Gm-Message-State: AOJu0YwHPBDWAL/W6zWjb65uTYj3sT7vpDugopboGiVYoOwG97VxwMvI
 5YQY8o/IJaJmFthH+3ZqtAF3Tf0NCUZ7vrImmgAgcstc4+NqCFQ0Z5bUlOOHbdxcZsJPVKP9BUS
 uq8ZLUDdC6Zz/qXZDxXLUO0IMGYKYIQFEe2c1xpHgqp3C5B+N4SotUgS7
X-Gm-Gg: ASbGnct9tYSF/lWpE6FT4hRh7ch8UqLrvRETfowb4o210/BOVDgxRwFt+OIY0gzIzfC
 qTLyB0RqV+tj1KcegZUur0ZMSRtuGmfleWofpQc1rZcxIuldFyu47Y2agkapwbunS6Hvfz3gCPE
 HQy/66vPH820QnqSvAYd3p93fgFy5pI+W0Hxn+O7aqKg+AeOrV3ElU3bRZpu7inr175VcMb7TCN
 YDOPG/ieqcTAofJGeSUoOPwc+CTqkXinYR4TxmnUyrglv/UUVkiQ51i6tsVPsD6jXeFmGZ82e69
 EOe27dawTHXsU972fNskqSoKORZldDtqOzbQyqQvg5isNgPUMjqPfA4FEMcwaaZPGhbbxH6X00E
 RZoHXHl9qL/bn5oxwgHI6qqTkS4DO+XDVKgYbJtfR+cjHJEo5t5dfZskEJN2iisKoVq7lVaV7xk
 B0sDA/qB030M49qqMMi0Nr1IgCUn7WW99p3epfPw==
X-Received: by 2002:a17:90b:50c7:b0:340:a961:80c9 with SMTP id
 98e67ed59e1d1-345bd41360cmr2950870a91.30.1763565953505; 
 Wed, 19 Nov 2025 07:25:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl0dIu6ozAe7hOK/0ctO1h7VevCWoNMrtzIb2MrlC5aQwtXdUqsYmJk2H9tBGkjwuwa+ZesQ==
X-Received: by 2002:a17:90b:50c7:b0:340:a961:80c9 with SMTP id
 98e67ed59e1d1-345bd41360cmr2950835a91.30.1763565952738; 
 Wed, 19 Nov 2025 07:25:52 -0800 (PST)
Received: from hu-bselvana-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-345bbfc8eefsm3083157a91.4.2025.11.19.07.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 07:25:52 -0800 (PST)
From: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
To: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, lukma@denx.de, seanga2@gmail.com, marex@denx.de,
 balaji.selvanathan@oss.qualcomm.com, ilias.apalodimas@linaro.org,
 rui.silva@linaro.org, luca.weiss@fairphone.com,
 quic_varada@quicinc.com, mkorpershoek@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
Subject: [PATCH v1 3/6] drivers: phy: qcom: Add QMP USB3-DP Combo PHY driver
Date: Wed, 19 Nov 2025 20:55:27 +0530
Message-Id: <20251119152530.4175628-4-balaji.selvanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
References: <20251119152530.4175628-1-balaji.selvanathan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UbE6JwpisDajjnpYi2ZwboYVK92HuY-4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDEyMyBTYWx0ZWRfX5PdH2I7sbEX+
 hTQ9mSTU5+jW+9pMGFRDpe8RKO4ts0ES/hpks79aPESplFwAFweR/KbnDwmB7ynpLsllgssL6mv
 f5i1ZNpWK+2ctG0DD7u+59g6YFvRYrAWTmew7nhPluTPIuOqSvZziVgNcCFZ9w5oEJThVqxIaP3
 0yBeE6e5Ud85gFtWG2vOkbKZ4mT/vHhLpnPMgAkIg4GfB63BOmMHElTgxwKG61+6N5tR0z/6AKu
 JQtIFLow7SY33OVVmsQAQpbEflXCuRk44UPitInLt4CukUmoFN9Ta3zHlbXbjulvy9MZv2drSru
 X+2K1VtIQbMIr+FxEElD6687s9spTXpfbga2R0Fcm0qjqLfssdIozM4q4IZ5oAdSFu/fk7EJ+jw
 Zq8OkROoZ6Dv4j7bg/2F5Rovs2qeOg==
X-Proofpoint-ORIG-GUID: UbE6JwpisDajjnpYi2ZwboYVK92HuY-4
X-Authority-Analysis: v=2.4 cv=PJICOPqC c=1 sm=1 tr=0 ts=691de183 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=a9RGm9Zt6Bzv1ONbwigA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511190123
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
 drivers/phy/qcom/Kconfig                   |   8 +
 drivers/phy/qcom/Makefile                  |   1 +
 drivers/phy/qcom/phy-qcom-qmp-combo.c      | 503 +++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-common.h     |  62 +++
 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h  |  18 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h |  34 ++
 drivers/phy/qcom/phy-qcom-qmp.h            |  17 +
 7 files changed, 643 insertions(+)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-combo.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-dp-com-v3.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h

diff --git a/drivers/phy/qcom/Kconfig b/drivers/phy/qcom/Kconfig
index 0dd69f7ffd0..4be18628b4d 100644
--- a/drivers/phy/qcom/Kconfig
+++ b/drivers/phy/qcom/Kconfig
@@ -12,6 +12,14 @@ config PHY_QCOM_IPQ4019_USB
 	help
 	  Support for the USB PHY-s on Qualcomm IPQ40xx SoC-s.
 
+config PHY_QCOM_QMP_COMBO
+	tristate "Qualcomm QMP USB3-DP Combo PHY driver"
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
index 00000000000..74d67b0b96b
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-combo.c
@@ -0,0 +1,503 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <generic-phy.h>
+#include <reset.h>
+#include <asm/io.h>
+#include <linux/bitops.h>
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
+	/* true, if PHY needs delay after POWER_DOWN */
+	bool has_pwrdn_delay;
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
+	struct clk_bulk clks;
+	struct clk *pipe_clk;
+	int num_clks;
+	struct reset_ctl_bulk resets;
+	int num_resets;
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
+static int qmp_combo_power_on(struct phy *phy)
+{
+	struct qmp_combo *qmp = dev_get_priv(phy->dev);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	void __iomem *serdes = qmp->serdes;
+	void __iomem *tx = qmp->tx;
+	void __iomem *rx = qmp->rx;
+	void __iomem *tx2 = qmp->tx2;
+	void __iomem *rx2 = qmp->rx2;
+	void __iomem *pcs = qmp->pcs;
+	void __iomem *pcs_usb = qmp->pcs_usb;
+	void __iomem *com = qmp->com;
+	u32 val;
+	int ret;
+
+	/* Assert and then deassert resets */
+	ret = reset_assert_bulk(&qmp->resets);
+	if (ret) {
+		printf("Failed to assert resets: %d\n", ret);
+		return ret;
+	}
+	ret = reset_deassert_bulk(&qmp->resets);
+	if (ret) {
+		printf("Failed to deassert resets: %d\n", ret);
+		return ret;
+	}
+
+	/* Enable clocks */
+	ret = clk_enable_bulk(&qmp->clks);
+	if (ret) {
+		printf("Failed to enable clocks: %d\n", ret);
+		reset_assert_bulk(&qmp->resets); /* Assert resets on error */
+		return ret;
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
+	/* Serdes configuration */
+	qmp_configure(qmp->dev, serdes, qmp->cfg->serdes_tbl, qmp->cfg->serdes_tbl_num);
+
+	ret = clk_prepare_enable(qmp->pipe_clk);
+	if (ret) {
+		dev_err(phy->dev, "pipe_clk enable failed err=%d\n", ret);
+		return ret;
+	}
+
+	/* Tx, Rx configurations */
+	qmp_configure_lane(qmp->dev, tx, qmp->cfg->tx_tbl, qmp->cfg->tx_tbl_num, 1);
+	qmp_configure_lane(qmp->dev, tx2, qmp->cfg->tx_tbl, qmp->cfg->tx_tbl_num, 2);
+
+	qmp_configure_lane(qmp->dev, rx, qmp->cfg->rx_tbl, qmp->cfg->rx_tbl_num, 1);
+	qmp_configure_lane(qmp->dev, rx2, qmp->cfg->rx_tbl, qmp->cfg->rx_tbl_num, 2);
+
+	/* PCS configuration */
+	qmp_configure(qmp->dev, pcs, qmp->cfg->pcs_tbl, qmp->cfg->pcs_tbl_num);
+
+	if (pcs_usb) {
+		qmp_configure(qmp->dev, pcs_usb,
+			      qmp->cfg->pcs_usb_tbl,
+			      qmp->cfg->pcs_usb_tbl_num);
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
+		clk_disable_bulk(&qmp->clks);
+		reset_assert_bulk(&qmp->resets);
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
+	/* Disable clocks */
+	clk_disable_bulk(&qmp->clks);
+
+	/* Assert resets */
+	reset_assert_bulk(&qmp->resets);
+
+	return 0;
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
+	int ret;
+
+	ret = clk_get_bulk(dev, &qmp->clks);
+
+	if (!ret)
+		qmp->num_clks = qmp->clks.count;
+
+	return ret;
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
+	qmp->pcs_misc = base + offs->usb3_pcs_misc; /* Assign pcs_misc */
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
+	return 0;
+}
+
+static int qmp_combo_probe(struct udevice *dev)
+{
+	struct qmp_combo *qmp = dev_get_priv(dev);
+	int ret;
+
+	qmp->dev = dev;
+	/* Get configuration from device match data */
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
+
+	.has_pwrdn_delay	= true,
+};
+
+static struct phy_ops qmp_combo_ops = {
+	.init = qmp_combo_power_on,
+	.exit = qmp_combo_power_off,
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

