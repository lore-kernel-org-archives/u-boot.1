Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78555ECE582
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 09:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB6DF88F80;
	Tue, 10 Sep 2024 11:12:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jGLozS1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69AA488F73; Tue, 10 Sep 2024 11:12:13 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E827C88F69
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-374c8cef906so3564411f8f.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725959524; x=1726564324; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fu51RvPNEOPN5pWnA/2+rLoXKi8WqC35cJZstNSdetc=;
 b=jGLozS1vyEKjeKJCStxYZfCKluEh1fJUSdBTU/AtNmjyQWQM1Z7Jgl635PiMX8isGF
 TJJCxTwwh9U3GfTkKR5T3wrlWH0k0/9xikZOePDyWFYsqUa+77O+6BpooXLUPtZru8t8
 JuJUaBHcjuK0t3hR09H4IMFZBlAwHJ5epy359Y497DKJvv/VgNPmQyTI5qhwgVQ+AtN9
 6viM1JVS+DF1qFJBlTdPGaeUXFrmJ6d8EL6Je3lOCvQfyMPYUszEvTFUyTnyjnFLpusU
 53PH0UxClGO/050nP+tfSYFGpyw2Ccbe27GXIoxXUDT8ERP7lYwsO4R9Rjcj5jwBZrka
 1lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725959524; x=1726564324;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fu51RvPNEOPN5pWnA/2+rLoXKi8WqC35cJZstNSdetc=;
 b=W/jOYYwRmITbUQl7QyejuG/hYE9pT83VpJCuIwd7zOmwqHAhVUwSAVI59//0GMDo7H
 VQ7McS1Xp2hSM59lOrgfyAl6XWWgdHF+GNSMsCEEI1LKt7nKevt9OgXvWaoeEG/+v2r5
 pMSAjTbdPU0WOIDp3Ul8Sh1X6YJwVTas5tf8W0K1ivDmfH6LMVLLCSSv2JYl1zLOJfm8
 ch0vd43kTOCO62WcSsXnVo6dg8VM5daRuS992HZcoMvGEGYAbOQd0udSS1PnUsw3Xrz1
 3/rjOlcaQhZG4r4JaoQDbOSCcztcI33coHfPXatcxcdZq5wF/9Szg5Wkgvwe/OWI/rdt
 siKA==
X-Gm-Message-State: AOJu0YxPx2xHILEEC3x72Lz92Od851AI6huHv8/mi9XSJbQ9APmQ8HB2
 ZFuY/b14Hcu7y+06Qsk3QmV/YrHJIa32dUalVLj8eX0sVyuKbyOfjIQCR04J5WgNMNfHP+u5vqt
 j
X-Google-Smtp-Source: AGHT+IGk/XmhcV83iwiSHxHA+qLaPoQ10w5TnLTGKdWYMe26/Jh+/FLdlktjKYkminwiDnQ3wfUfEA==
X-Received: by 2002:adf:ce05:0:b0:374:c142:80e7 with SMTP id
 ffacd0b85a97d-378895c5462mr9455480f8f.1.1725959523500; 
 Tue, 10 Sep 2024 02:12:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649733sm8294798f8f.8.2024.09.10.02.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 02:12:03 -0700 (PDT)
From: neil.armstrong@linaro.org
Date: Tue, 10 Sep 2024 11:11:57 +0200
Subject: [PATCH 1/2] phy: qcom: Import QMP phy related header files from Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-topic-ufs-qcom-phy-v1-1-21ff4b87b962@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=75245;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Kb5N/AR5IFvNBwA2pEegTsAiXfFLb+GCQo/OvoFdtTo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBm4A1gTCqrlJQizv09B43BmFIohxhINzRkJ6yz+ENT
 Xnfddy6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZuANYAAKCRB33NvayMhJ0foMEA
 CZs/XQkP7ygM0/vV5EBTWZsrKcXPejUI8u8aGVN11R1RxAqLp/30PsVml3nhOSu/BxNYrfFxyj09gL
 NDjfoALS+Srmbe42HodeDM4Ktyh5AIc2h8otVxBy5hu8KwhN68TV5l3/NohEN1ROSsR/etCpZ63H3E
 3nm5rZvoaMWwFWjRb04fmcqz9T2AcsMXwBQbZXq4wJXUkPct2NQyNLiiIiu8RucHdBkfzopgFFCr0Q
 aQHzzS1RNm8/mnKzZ045X+shjIcBtDKO0SWqhldGahjTE7w0pnosR2nnjSJwx2YsxCsTukMxH3cDaR
 jK4WZMZA7v+J8KMUqmUkn3bMAvnOZ1Ok9IKuq/Mh+UZ6n9TMN/AywHiTHBn4b/9BvJeFSOq+jIO2dr
 ZM41g/TrQSfuTUafZk32MZMS+rwIv3/GxxHoogqnuSo0vBJwvmxJuODT3r2VJIvX8xhozc+RCD3Oqf
 3i4yidWbM9fXW5UpCmC5SsKSgCab+7+NV1XW6ckpOi7AwwhITcaZBgHlCnFxymcu2PWE6aC4M2cNUY
 2Q5I4qoSwx/mBzYjORu1nFz22jGW7oF2ZUQcLwNc1Ugtb9W/vdpZFfPaPVWeYk5roK1xDBJ2iEuAD2
 riUeMsoFufqAmMoHxgLseHhm7+n0zEovwOuoB/gn/u55XxLq0C4Ag6AcBJLw==
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

Import Qualcomm QMP phy related header files from Linux v6.11-rc7,
limit to headers needed to setup QMP v2 to v6 UFS PHYs.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v2.h         |  25 +++
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v3.h         |  21 ++
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v4.h         |  31 +++
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v5.h         |  32 +++
 drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v6.h         |  38 ++++
 drivers/phy/qcom/phy-qcom-qmp-pcs-v2.h             |  43 ++++
 drivers/phy/qcom/phy-qcom-qmp-pcs-v3.h             | 145 +++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-pcs-v4.h             | 135 ++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v3.h     | 111 ++++++++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v4.h     | 123 +++++++++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h     |  89 ++++++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h        | 140 +++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-pll.h        |  69 ++++++
 .../phy/qcom/phy-qcom-qmp-qserdes-txrx-ufs-v6.h    |  52 +++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v3.h    |  68 ++++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4.h    | 233 +++++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx.h       | 205 ++++++++++++++++++
 17 files changed, 1560 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v2.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v2.h
new file mode 100644
index 00000000000..a0803a8783d
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v2.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_UFS_V2_H_
+#define QCOM_PHY_QMP_PCS_UFS_V2_H_
+
+#define QPHY_V2_PCS_UFS_PHY_START			0x000
+#define QPHY_V2_PCS_UFS_POWER_DOWN_CONTROL		0x004
+
+#define QPHY_V2_PCS_UFS_TX_LARGE_AMP_DRV_LVL		0x034
+#define QPHY_V2_PCS_UFS_TX_LARGE_AMP_POST_EMP_LVL	0x038
+#define QPHY_V2_PCS_UFS_TX_SMALL_AMP_DRV_LVL		0x03c
+#define QPHY_V2_PCS_UFS_TX_SMALL_AMP_POST_EMP_LVL	0x040
+
+#define QPHY_V2_PCS_UFS_RX_MIN_STALL_NOCONFIG_TIME_CAP	0x0cc
+#define QPHY_V2_PCS_UFS_RX_SYM_RESYNC_CTRL			0x13c
+#define QPHY_V2_PCS_UFS_RX_MIN_HIBERN8_TIME			0x140
+#define QPHY_V2_PCS_UFS_RX_SIGDET_CTRL2			0x148
+#define QPHY_V2_PCS_UFS_RX_PWM_GEAR_BAND			0x154
+
+#define QPHY_V2_PCS_UFS_READY_STATUS			0x168
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v3.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v3.h
new file mode 100644
index 00000000000..adea13c3a9e
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v3.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_UFS_V3_H_
+#define QCOM_PHY_QMP_PCS_UFS_V3_H_
+
+#define QPHY_V3_PCS_UFS_PHY_START			0x000
+#define QPHY_V3_PCS_UFS_POWER_DOWN_CONTROL		0x004
+#define QPHY_V3_PCS_UFS_TX_LARGE_AMP_DRV_LVL		0x02c
+#define QPHY_V3_PCS_UFS_TX_SMALL_AMP_DRV_LVL		0x034
+#define QPHY_V3_PCS_UFS_RX_SYM_RESYNC_CTRL		0x134
+#define QPHY_V3_PCS_UFS_RX_MIN_HIBERN8_TIME		0x138
+#define QPHY_V3_PCS_UFS_RX_SIGDET_CTRL1			0x13c
+#define QPHY_V3_PCS_UFS_RX_SIGDET_CTRL2			0x140
+#define QPHY_V3_PCS_UFS_READY_STATUS			0x160
+#define QPHY_V3_PCS_UFS_TX_MID_TERM_CTRL1		0x1bc
+#define QPHY_V3_PCS_UFS_MULTI_LANE_CTRL1		0x1c4
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v4.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v4.h
new file mode 100644
index 00000000000..a1c7d3d1715
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v4.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_UFS_V4_H_
+#define QCOM_PHY_QMP_PCS_UFS_V4_H_
+
+/* Only for QMP V4 PHY - UFS PCS registers */
+#define QPHY_V4_PCS_UFS_PHY_START			0x000
+#define QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL		0x004
+#define QPHY_V4_PCS_UFS_SW_RESET			0x008
+#define QPHY_V4_PCS_UFS_TIMER_20US_CORECLK_STEPS_MSB	0x00c
+#define QPHY_V4_PCS_UFS_TIMER_20US_CORECLK_STEPS_LSB	0x010
+#define QPHY_V4_PCS_UFS_PLL_CNTL			0x02c
+#define QPHY_V4_PCS_UFS_TX_LARGE_AMP_DRV_LVL		0x030
+#define QPHY_V4_PCS_UFS_TX_SMALL_AMP_DRV_LVL		0x038
+#define QPHY_V4_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
+#define QPHY_V4_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
+#define QPHY_V4_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0b4
+#define QPHY_V4_PCS_UFS_DEBUG_BUS_CLKSEL		0x124
+#define QPHY_V4_PCS_UFS_LINECFG_DISABLE			0x148
+#define QPHY_V4_PCS_UFS_RX_MIN_HIBERN8_TIME		0x150
+#define QPHY_V4_PCS_UFS_RX_SIGDET_CTRL2			0x158
+#define QPHY_V4_PCS_UFS_TX_PWM_GEAR_BAND		0x160
+#define QPHY_V4_PCS_UFS_TX_HS_GEAR_BAND			0x168
+#define QPHY_V4_PCS_UFS_READY_STATUS			0x180
+#define QPHY_V4_PCS_UFS_TX_MID_TERM_CTRL1		0x1d8
+#define QPHY_V4_PCS_UFS_MULTI_LANE_CTRL1		0x1e0
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v5.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v5.h
new file mode 100644
index 00000000000..07959964fcf
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v5.h
@@ -0,0 +1,32 @@
+/* Only for QMP V5 PHY - UFS PCS registers */
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_UFS_V5_H_
+#define QCOM_PHY_QMP_PCS_UFS_V5_H_
+
+/* Only for QMP V5 PHY - UFS PCS registers */
+#define QPHY_V5_PCS_UFS_PHY_START			0x000
+#define QPHY_V5_PCS_UFS_POWER_DOWN_CONTROL		0x004
+#define QPHY_V5_PCS_UFS_SW_RESET			0x008
+#define QPHY_V5_PCS_UFS_TIMER_20US_CORECLK_STEPS_MSB	0x00c
+#define QPHY_V5_PCS_UFS_TIMER_20US_CORECLK_STEPS_LSB	0x010
+#define QPHY_V5_PCS_UFS_PLL_CNTL			0x02c
+#define QPHY_V5_PCS_UFS_TX_LARGE_AMP_DRV_LVL		0x030
+#define QPHY_V5_PCS_UFS_TX_SMALL_AMP_DRV_LVL		0x038
+#define QPHY_V5_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
+#define QPHY_V5_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
+#define QPHY_V5_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0b4
+#define QPHY_V5_PCS_UFS_DEBUG_BUS_CLKSEL		0x124
+#define QPHY_V5_PCS_UFS_RX_MIN_HIBERN8_TIME		0x150
+#define QPHY_V5_PCS_UFS_RX_SIGDET_CTRL1			0x154
+#define QPHY_V5_PCS_UFS_RX_SIGDET_CTRL2			0x158
+#define QPHY_V5_PCS_UFS_TX_PWM_GEAR_BAND		0x160
+#define QPHY_V5_PCS_UFS_TX_HS_GEAR_BAND			0x168
+#define QPHY_V5_PCS_UFS_READY_STATUS			0x180
+#define QPHY_V5_PCS_UFS_TX_MID_TERM_CTRL1		0x1d8
+#define QPHY_V5_PCS_UFS_MULTI_LANE_CTRL1		0x1e0
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v6.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v6.h
new file mode 100644
index 00000000000..f19f9892ed7
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-ufs-v6.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_UFS_V6_H_
+#define QCOM_PHY_QMP_PCS_UFS_V6_H_
+
+/* Only for QMP V6 PHY - UFS PCS registers */
+#define QPHY_V6_PCS_UFS_PHY_START			0x000
+#define QPHY_V6_PCS_UFS_POWER_DOWN_CONTROL		0x004
+#define QPHY_V6_PCS_UFS_SW_RESET			0x008
+#define QPHY_V6_PCS_UFS_TIMER_20US_CORECLK_STEPS_MSB	0x00c
+#define QPHY_V6_PCS_UFS_TIMER_20US_CORECLK_STEPS_LSB	0x010
+#define QPHY_V6_PCS_UFS_PCS_CTRL1			0x020
+#define QPHY_V6_PCS_UFS_PLL_CNTL			0x02c
+#define QPHY_V6_PCS_UFS_TX_LARGE_AMP_DRV_LVL		0x030
+#define QPHY_V6_PCS_UFS_TX_SMALL_AMP_DRV_LVL		0x038
+#define QPHY_V6_PCS_UFS_BIST_FIXED_PAT_CTRL		0x060
+#define QPHY_V6_PCS_UFS_TX_HSGEAR_CAPABILITY		0x074
+#define QPHY_V6_PCS_UFS_RX_HSGEAR_CAPABILITY		0x0bc
+#define QPHY_V6_PCS_UFS_RX_HS_G5_SYNC_LENGTH_CAPABILITY	0x12c
+#define QPHY_V6_PCS_UFS_DEBUG_BUS_CLKSEL		0x158
+#define QPHY_V6_PCS_UFS_LINECFG_DISABLE			0x17c
+#define QPHY_V6_PCS_UFS_RX_MIN_HIBERN8_TIME		0x184
+#define QPHY_V6_PCS_UFS_RX_SIGDET_CTRL2			0x18c
+#define QPHY_V6_PCS_UFS_TX_PWM_GEAR_BAND		0x178
+#define QPHY_V6_PCS_UFS_TX_HS_GEAR_BAND			0x174
+#define QPHY_V6_PCS_UFS_READY_STATUS			0x1a8
+#define QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1		0x1f4
+#define QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1		0x1fc
+#define QPHY_V6_PCS_UFS_RX_HSG5_SYNC_WAIT_TIME		0x220
+#define QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S4		0x240
+#define QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S5		0x244
+#define QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S6		0x248
+#define QPHY_V6_PCS_UFS_TX_POST_EMP_LVL_S7		0x24c
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-v2.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-v2.h
new file mode 100644
index 00000000000..bf36399d005
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-v2.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V2_H_
+#define QCOM_PHY_QMP_PCS_V2_H_
+
+/* Only for QMP V2 PHY - PCS registers */
+#define QPHY_V2_PCS_SW_RESET				0x000
+#define QPHY_V2_PCS_POWER_DOWN_CONTROL			0x004
+#define QPHY_V2_PCS_START_CONTROL			0x008
+#define QPHY_V2_PCS_TXDEEMPH_M6DB_V0			0x024
+#define QPHY_V2_PCS_TXDEEMPH_M3P5DB_V0			0x028
+#define QPHY_V2_PCS_ENDPOINT_REFCLK_DRIVE		0x054
+#define QPHY_V2_PCS_RX_IDLE_DTCT_CNTRL			0x058
+#define QPHY_V2_PCS_POWER_STATE_CONFIG1			0x060
+#define QPHY_V2_PCS_POWER_STATE_CONFIG2			0x064
+#define QPHY_V2_PCS_POWER_STATE_CONFIG4			0x06c
+#define QPHY_V2_PCS_LOCK_DETECT_CONFIG1			0x080
+#define QPHY_V2_PCS_LOCK_DETECT_CONFIG2			0x084
+#define QPHY_V2_PCS_LOCK_DETECT_CONFIG3			0x088
+#define QPHY_V2_PCS_PWRUP_RESET_DLY_TIME_AUXCLK		0x0a0
+#define QPHY_V2_PCS_LP_WAKEUP_DLY_TIME_AUXCLK		0x0a4
+#define QPHY_V2_PCS_PLL_LOCK_CHK_DLY_TIME		0x0a8
+#define QPHY_V2_PCS_FLL_CNTRL1				0x0c0
+#define QPHY_V2_PCS_FLL_CNTRL2				0x0c4
+#define QPHY_V2_PCS_FLL_CNT_VAL_L			0x0c8
+#define QPHY_V2_PCS_FLL_CNT_VAL_H_TOL			0x0cc
+#define QPHY_V2_PCS_FLL_MAN_CODE			0x0d0
+#define QPHY_V2_PCS_AUTONOMOUS_MODE_CTRL		0x0d4
+#define QPHY_V2_PCS_LFPS_RXTERM_IRQ_CLEAR		0x0d8
+#define QPHY_V2_PCS_LFPS_RXTERM_IRQ_STATUS		0x178
+#define QPHY_V2_PCS_USB_PCS_STATUS			0x17c /* USB */
+#define QPHY_V2_PCS_PLL_LOCK_CHK_DLY_TIME_AUXCLK_LSB	0x1a8
+#define QPHY_V2_PCS_OSC_DTCT_ACTIONS			0x1ac
+#define QPHY_V2_PCS_RX_SIGDET_LVL			0x1d8
+#define QPHY_V2_PCS_L1SS_WAKEUP_DLY_TIME_AUXCLK_LSB	0x1dc
+#define QPHY_V2_PCS_L1SS_WAKEUP_DLY_TIME_AUXCLK_MSB	0x1e0
+
+#define QPHY_V2_PCS_PCI_PCS_STATUS			0x174 /* PCI */
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-v3.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-v3.h
new file mode 100644
index 00000000000..10dbbb00620
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-v3.h
@@ -0,0 +1,145 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V3_H_
+#define QCOM_PHY_QMP_PCS_V3_H_
+
+/* Only for QMP V3 PHY - PCS registers */
+#define QPHY_V3_PCS_SW_RESET				0x000
+#define QPHY_V3_PCS_POWER_DOWN_CONTROL			0x004
+#define QPHY_V3_PCS_START_CONTROL			0x008
+#define QPHY_V3_PCS_TXMGN_V0				0x00c
+#define QPHY_V3_PCS_TXMGN_V1				0x010
+#define QPHY_V3_PCS_TXMGN_V2				0x014
+#define QPHY_V3_PCS_TXMGN_V3				0x018
+#define QPHY_V3_PCS_TXMGN_V4				0x01c
+#define QPHY_V3_PCS_TXMGN_LS				0x020
+#define QPHY_V3_PCS_TXDEEMPH_M6DB_V0			0x024
+#define QPHY_V3_PCS_TXDEEMPH_M3P5DB_V0			0x028
+#define QPHY_V3_PCS_TXDEEMPH_M6DB_V1			0x02c
+#define QPHY_V3_PCS_TXDEEMPH_M3P5DB_V1			0x030
+#define QPHY_V3_PCS_TXDEEMPH_M6DB_V2			0x034
+#define QPHY_V3_PCS_TXDEEMPH_M3P5DB_V2			0x038
+#define QPHY_V3_PCS_TXDEEMPH_M6DB_V3			0x03c
+#define QPHY_V3_PCS_TXDEEMPH_M3P5DB_V3			0x040
+#define QPHY_V3_PCS_TXDEEMPH_M6DB_V4			0x044
+#define QPHY_V3_PCS_TXDEEMPH_M3P5DB_V4			0x048
+#define QPHY_V3_PCS_TXDEEMPH_M6DB_LS			0x04c
+#define QPHY_V3_PCS_TXDEEMPH_M3P5DB_LS			0x050
+#define QPHY_V3_PCS_ENDPOINT_REFCLK_DRIVE		0x054
+#define QPHY_V3_PCS_RX_IDLE_DTCT_CNTRL			0x058
+#define QPHY_V3_PCS_RATE_SLEW_CNTRL			0x05c
+#define QPHY_V3_PCS_POWER_STATE_CONFIG1			0x060
+#define QPHY_V3_PCS_POWER_STATE_CONFIG2			0x064
+#define QPHY_V3_PCS_POWER_STATE_CONFIG3			0x068
+#define QPHY_V3_PCS_POWER_STATE_CONFIG4			0x06c
+#define QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_L		0x070
+#define QPHY_V3_PCS_RCVR_DTCT_DLY_P1U2_H		0x074
+#define QPHY_V3_PCS_RCVR_DTCT_DLY_U3_L			0x078
+#define QPHY_V3_PCS_RCVR_DTCT_DLY_U3_H			0x07c
+#define QPHY_V3_PCS_LOCK_DETECT_CONFIG1			0x080
+#define QPHY_V3_PCS_LOCK_DETECT_CONFIG2			0x084
+#define QPHY_V3_PCS_LOCK_DETECT_CONFIG3			0x088
+#define QPHY_V3_PCS_TSYNC_RSYNC_TIME			0x08c
+#define QPHY_V3_PCS_SIGDET_LOW_2_IDLE_TIME		0x090
+#define QPHY_V3_PCS_BEACON_2_IDLE_TIME_L		0x094
+#define QPHY_V3_PCS_BEACON_2_IDLE_TIME_H		0x098
+#define QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_SYSCLK		0x09c
+#define QPHY_V3_PCS_PWRUP_RESET_DLY_TIME_AUXCLK		0x0a0
+#define QPHY_V3_PCS_LP_WAKEUP_DLY_TIME_AUXCLK		0x0a4
+#define QPHY_V3_PCS_PLL_LOCK_CHK_DLY_TIME		0x0a8
+#define QPHY_V3_PCS_LFPS_DET_HIGH_COUNT_VAL		0x0ac
+#define QPHY_V3_PCS_LFPS_TX_ECSTART_EQTLOCK		0x0b0
+#define QPHY_V3_PCS_LFPS_TX_END_CNT_P2U3_START		0x0b4
+#define QPHY_V3_PCS_RXEQTRAINING_WAIT_TIME		0x0b8
+#define QPHY_V3_PCS_RXEQTRAINING_RUN_TIME		0x0bc
+#define QPHY_V3_PCS_TXONESZEROS_RUN_LENGTH		0x0c0
+#define QPHY_V3_PCS_FLL_CNTRL1				0x0c4
+#define QPHY_V3_PCS_FLL_CNTRL2				0x0c8
+#define QPHY_V3_PCS_FLL_CNT_VAL_L			0x0cc
+#define QPHY_V3_PCS_FLL_CNT_VAL_H_TOL			0x0d0
+#define QPHY_V3_PCS_FLL_MAN_CODE			0x0d4
+#define QPHY_V3_PCS_AUTONOMOUS_MODE_CTRL		0x0d8
+#define QPHY_V3_PCS_LFPS_RXTERM_IRQ_CLEAR		0x0dc
+#define QPHY_V3_PCS_ARCVR_DTCT_EN_PERIOD		0x0e0
+#define QPHY_V3_PCS_ARCVR_DTCT_CM_DLY			0x0e4
+#define QPHY_V3_PCS_ALFPS_DEGLITCH_VAL			0x0e8
+#define QPHY_V3_PCS_INSIG_SW_CTRL1			0x0ec
+#define QPHY_V3_PCS_INSIG_SW_CTRL2			0x0f0
+#define QPHY_V3_PCS_INSIG_SW_CTRL3			0x0f4
+#define QPHY_V3_PCS_INSIG_MX_CTRL1			0x0f8
+#define QPHY_V3_PCS_INSIG_MX_CTRL2			0x0fc
+#define QPHY_V3_PCS_INSIG_MX_CTRL3			0x100
+#define QPHY_V3_PCS_OUTSIG_SW_CTRL1			0x104
+#define QPHY_V3_PCS_OUTSIG_MX_CTRL1			0x108
+#define QPHY_V3_PCS_CLK_DEBUG_BYPASS_CTRL		0x10c
+#define QPHY_V3_PCS_TEST_CONTROL			0x110
+#define QPHY_V3_PCS_TEST_CONTROL2			0x114
+#define QPHY_V3_PCS_TEST_CONTROL3			0x118
+#define QPHY_V3_PCS_TEST_CONTROL4			0x11c
+#define QPHY_V3_PCS_TEST_CONTROL5			0x120
+#define QPHY_V3_PCS_TEST_CONTROL6			0x124
+#define QPHY_V3_PCS_TEST_CONTROL7			0x128
+#define QPHY_V3_PCS_COM_RESET_CONTROL			0x12c
+#define QPHY_V3_PCS_BIST_CTRL				0x130
+#define QPHY_V3_PCS_PRBS_POLY0				0x134
+#define QPHY_V3_PCS_PRBS_POLY1				0x138
+#define QPHY_V3_PCS_PRBS_SEED0				0x13c
+#define QPHY_V3_PCS_PRBS_SEED1				0x140
+#define QPHY_V3_PCS_FIXED_PAT_CTRL			0x144
+#define QPHY_V3_PCS_FIXED_PAT0				0x148
+#define QPHY_V3_PCS_FIXED_PAT1				0x14c
+#define QPHY_V3_PCS_FIXED_PAT2				0x150
+#define QPHY_V3_PCS_FIXED_PAT3				0x154
+#define QPHY_V3_PCS_COM_CLK_SWITCH_CTRL			0x158
+#define QPHY_V3_PCS_ELECIDLE_DLY_SEL			0x15c
+#define QPHY_V3_PCS_SPARE1				0x160
+#define QPHY_V3_PCS_BIST_CHK_ERR_CNT_L_STATUS		0x164
+#define QPHY_V3_PCS_BIST_CHK_ERR_CNT_H_STATUS		0x168
+#define QPHY_V3_PCS_BIST_CHK_STATUS			0x16c
+#define QPHY_V3_PCS_LFPS_RXTERM_IRQ_SOURCE_STATUS	0x170
+#define QPHY_V3_PCS_PCS_STATUS				0x174
+#define QPHY_V3_PCS_PCS_STATUS2				0x178
+#define QPHY_V3_PCS_PCS_STATUS3				0x17c
+#define QPHY_V3_PCS_COM_RESET_STATUS			0x180
+#define QPHY_V3_PCS_OSC_DTCT_STATUS			0x184
+#define QPHY_V3_PCS_REVISION_ID0			0x188
+#define QPHY_V3_PCS_REVISION_ID1			0x18c
+#define QPHY_V3_PCS_REVISION_ID2			0x190
+#define QPHY_V3_PCS_REVISION_ID3			0x194
+#define QPHY_V3_PCS_DEBUG_BUS_0_STATUS			0x198
+#define QPHY_V3_PCS_DEBUG_BUS_1_STATUS			0x19c
+#define QPHY_V3_PCS_DEBUG_BUS_2_STATUS			0x1a0
+#define QPHY_V3_PCS_DEBUG_BUS_3_STATUS			0x1a4
+#define QPHY_V3_PCS_LP_WAKEUP_DLY_TIME_AUXCLK_MSB	0x1a8
+#define QPHY_V3_PCS_OSC_DTCT_ACTIONS			0x1ac
+#define QPHY_V3_PCS_SIGDET_CNTRL			0x1b0
+#define QPHY_V3_PCS_IDAC_CAL_CNTRL			0x1b4
+#define QPHY_V3_PCS_CMN_ACK_OUT_SEL			0x1b8
+#define QPHY_V3_PCS_PLL_LOCK_CHK_DLY_TIME_SYSCLK	0x1bc
+#define QPHY_V3_PCS_AUTONOMOUS_MODE_STATUS		0x1c0
+#define QPHY_V3_PCS_ENDPOINT_REFCLK_CNTRL		0x1c4
+#define QPHY_V3_PCS_EPCLK_PRE_PLL_LOCK_DLY_SYSCLK	0x1c8
+#define QPHY_V3_PCS_EPCLK_PRE_PLL_LOCK_DLY_AUXCLK	0x1cc
+#define QPHY_V3_PCS_EPCLK_DLY_COUNT_VAL_L		0x1d0
+#define QPHY_V3_PCS_EPCLK_DLY_COUNT_VAL_H		0x1d4
+#define QPHY_V3_PCS_RX_SIGDET_LVL			0x1d8
+#define QPHY_V3_PCS_L1SS_WAKEUP_DLY_TIME_AUXCLK_LSB	0x1dc
+#define QPHY_V3_PCS_L1SS_WAKEUP_DLY_TIME_AUXCLK_MSB	0x1e0
+#define QPHY_V3_PCS_AUTONOMOUS_MODE_CTRL2		0x1e4
+#define QPHY_V3_PCS_RXTERMINATION_DLY_SEL		0x1e8
+#define QPHY_V3_PCS_LFPS_PER_TIMER_VAL			0x1ec
+#define QPHY_V3_PCS_SIGDET_STARTUP_TIMER_VAL		0x1f0
+#define QPHY_V3_PCS_LOCK_DETECT_CONFIG4			0x1f4
+#define QPHY_V3_PCS_RX_SIGDET_DTCT_CNTRL		0x1f8
+#define QPHY_V3_PCS_PCS_STATUS4				0x1fc
+#define QPHY_V3_PCS_PCS_STATUS4_CLEAR			0x200
+#define QPHY_V3_PCS_DEC_ERROR_COUNT_STATUS		0x204
+#define QPHY_V3_PCS_COMMA_POS_STATUS			0x208
+#define QPHY_V3_PCS_REFGEN_REQ_CONFIG1			0x20c
+#define QPHY_V3_PCS_REFGEN_REQ_CONFIG2			0x210
+#define QPHY_V3_PCS_REFGEN_REQ_CONFIG3			0x214
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-pcs-v4.h b/drivers/phy/qcom/phy-qcom-qmp-pcs-v4.h
new file mode 100644
index 00000000000..a2c1eba2b69
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-pcs-v4.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_PCS_V4_H_
+#define QCOM_PHY_QMP_PCS_V4_H_
+
+/* Only for QMP V4 PHY - USB/PCIe PCS registers */
+#define QPHY_V4_PCS_SW_RESET				0x000
+#define QPHY_V4_PCS_REVISION_ID0			0x004
+#define QPHY_V4_PCS_REVISION_ID1			0x008
+#define QPHY_V4_PCS_REVISION_ID2			0x00c
+#define QPHY_V4_PCS_REVISION_ID3			0x010
+#define QPHY_V4_PCS_PCS_STATUS1				0x014
+#define QPHY_V4_PCS_PCS_STATUS2				0x018
+#define QPHY_V4_PCS_PCS_STATUS3				0x01c
+#define QPHY_V4_PCS_PCS_STATUS4				0x020
+#define QPHY_V4_PCS_PCS_STATUS5				0x024
+#define QPHY_V4_PCS_PCS_STATUS6				0x028
+#define QPHY_V4_PCS_PCS_STATUS7				0x02c
+#define QPHY_V4_PCS_DEBUG_BUS_0_STATUS			0x030
+#define QPHY_V4_PCS_DEBUG_BUS_1_STATUS			0x034
+#define QPHY_V4_PCS_DEBUG_BUS_2_STATUS			0x038
+#define QPHY_V4_PCS_DEBUG_BUS_3_STATUS			0x03c
+#define QPHY_V4_PCS_POWER_DOWN_CONTROL			0x040
+#define QPHY_V4_PCS_START_CONTROL			0x044
+#define QPHY_V4_PCS_INSIG_SW_CTRL1			0x048
+#define QPHY_V4_PCS_INSIG_SW_CTRL2			0x04c
+#define QPHY_V4_PCS_INSIG_SW_CTRL3			0x050
+#define QPHY_V4_PCS_INSIG_SW_CTRL4			0x054
+#define QPHY_V4_PCS_INSIG_SW_CTRL5			0x058
+#define QPHY_V4_PCS_INSIG_SW_CTRL6			0x05c
+#define QPHY_V4_PCS_INSIG_SW_CTRL7			0x060
+#define QPHY_V4_PCS_INSIG_SW_CTRL8			0x064
+#define QPHY_V4_PCS_INSIG_MX_CTRL1			0x068
+#define QPHY_V4_PCS_INSIG_MX_CTRL2			0x06c
+#define QPHY_V4_PCS_INSIG_MX_CTRL3			0x070
+#define QPHY_V4_PCS_INSIG_MX_CTRL4			0x074
+#define QPHY_V4_PCS_INSIG_MX_CTRL5			0x078
+#define QPHY_V4_PCS_INSIG_MX_CTRL7			0x07c
+#define QPHY_V4_PCS_INSIG_MX_CTRL8			0x080
+#define QPHY_V4_PCS_OUTSIG_SW_CTRL1			0x084
+#define QPHY_V4_PCS_OUTSIG_MX_CTRL1			0x088
+#define QPHY_V4_PCS_CLAMP_ENABLE			0x08c
+#define QPHY_V4_PCS_POWER_STATE_CONFIG1			0x090
+#define QPHY_V4_PCS_POWER_STATE_CONFIG2			0x094
+#define QPHY_V4_PCS_FLL_CNTRL1				0x098
+#define QPHY_V4_PCS_FLL_CNTRL2				0x09c
+#define QPHY_V4_PCS_FLL_CNT_VAL_L			0x0a0
+#define QPHY_V4_PCS_FLL_CNT_VAL_H_TOL			0x0a4
+#define QPHY_V4_PCS_FLL_MAN_CODE			0x0a8
+#define QPHY_V4_PCS_TEST_CONTROL1			0x0ac
+#define QPHY_V4_PCS_TEST_CONTROL2			0x0b0
+#define QPHY_V4_PCS_TEST_CONTROL3			0x0b4
+#define QPHY_V4_PCS_TEST_CONTROL4			0x0b8
+#define QPHY_V4_PCS_TEST_CONTROL5			0x0bc
+#define QPHY_V4_PCS_TEST_CONTROL6			0x0c0
+#define QPHY_V4_PCS_LOCK_DETECT_CONFIG1			0x0c4
+#define QPHY_V4_PCS_LOCK_DETECT_CONFIG2			0x0c8
+#define QPHY_V4_PCS_LOCK_DETECT_CONFIG3			0x0cc
+#define QPHY_V4_PCS_LOCK_DETECT_CONFIG4			0x0d0
+#define QPHY_V4_PCS_LOCK_DETECT_CONFIG5			0x0d4
+#define QPHY_V4_PCS_LOCK_DETECT_CONFIG6			0x0d8
+#define QPHY_V4_PCS_REFGEN_REQ_CONFIG1			0x0dc
+#define QPHY_V4_PCS_REFGEN_REQ_CONFIG2			0x0e0
+#define QPHY_V4_PCS_REFGEN_REQ_CONFIG3			0x0e4
+#define QPHY_V4_PCS_BIST_CTRL				0x0e8
+#define QPHY_V4_PCS_PRBS_POLY0				0x0ec
+#define QPHY_V4_PCS_PRBS_POLY1				0x0f0
+#define QPHY_V4_PCS_FIXED_PAT0				0x0f4
+#define QPHY_V4_PCS_FIXED_PAT1				0x0f8
+#define QPHY_V4_PCS_FIXED_PAT2				0x0fc
+#define QPHY_V4_PCS_FIXED_PAT3				0x100
+#define QPHY_V4_PCS_FIXED_PAT4				0x104
+#define QPHY_V4_PCS_FIXED_PAT5				0x108
+#define QPHY_V4_PCS_FIXED_PAT6				0x10c
+#define QPHY_V4_PCS_FIXED_PAT7				0x110
+#define QPHY_V4_PCS_FIXED_PAT8				0x114
+#define QPHY_V4_PCS_FIXED_PAT9				0x118
+#define QPHY_V4_PCS_FIXED_PAT10				0x11c
+#define QPHY_V4_PCS_FIXED_PAT11				0x120
+#define QPHY_V4_PCS_FIXED_PAT12				0x124
+#define QPHY_V4_PCS_FIXED_PAT13				0x128
+#define QPHY_V4_PCS_FIXED_PAT14				0x12c
+#define QPHY_V4_PCS_FIXED_PAT15				0x130
+#define QPHY_V4_PCS_TXMGN_CONFIG			0x134
+#define QPHY_V4_PCS_G12S1_TXMGN_V0			0x138
+#define QPHY_V4_PCS_G12S1_TXMGN_V1			0x13c
+#define QPHY_V4_PCS_G12S1_TXMGN_V2			0x140
+#define QPHY_V4_PCS_G12S1_TXMGN_V3			0x144
+#define QPHY_V4_PCS_G12S1_TXMGN_V4			0x148
+#define QPHY_V4_PCS_G12S1_TXMGN_V0_RS			0x14c
+#define QPHY_V4_PCS_G12S1_TXMGN_V1_RS			0x150
+#define QPHY_V4_PCS_G12S1_TXMGN_V2_RS			0x154
+#define QPHY_V4_PCS_G12S1_TXMGN_V3_RS			0x158
+#define QPHY_V4_PCS_G12S1_TXMGN_V4_RS			0x15c
+#define QPHY_V4_PCS_G3S2_TXMGN_MAIN			0x160
+#define QPHY_V4_PCS_G3S2_TXMGN_MAIN_RS			0x164
+#define QPHY_V4_PCS_G12S1_TXDEEMPH_M6DB			0x168
+#define QPHY_V4_PCS_G12S1_TXDEEMPH_M3P5DB		0x16c
+#define QPHY_V4_PCS_G3S2_PRE_GAIN			0x170
+#define QPHY_V4_PCS_G3S2_POST_GAIN			0x174
+#define QPHY_V4_PCS_G3S2_PRE_POST_OFFSET		0x178
+#define QPHY_V4_PCS_G3S2_PRE_GAIN_RS			0x17c
+#define QPHY_V4_PCS_G3S2_POST_GAIN_RS			0x180
+#define QPHY_V4_PCS_G3S2_PRE_POST_OFFSET_RS		0x184
+#define QPHY_V4_PCS_RX_SIGDET_LVL			0x188
+#define QPHY_V4_PCS_RX_SIGDET_DTCT_CNTRL		0x18c
+#define QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_L		0x190
+#define QPHY_V4_PCS_RCVR_DTCT_DLY_P1U2_H		0x194
+#define QPHY_V4_PCS_RATE_SLEW_CNTRL1			0x198
+#define QPHY_V4_PCS_RATE_SLEW_CNTRL2			0x19c
+#define QPHY_V4_PCS_PWRUP_RESET_DLY_TIME_AUXCLK		0x1a0
+#define QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_L	0x1a4
+#define QPHY_V4_PCS_P2U3_WAKEUP_DLY_TIME_AUXCLK_H	0x1a8
+#define QPHY_V4_PCS_TSYNC_RSYNC_TIME			0x1ac
+#define QPHY_V4_PCS_CDR_RESET_TIME			0x1b0
+#define QPHY_V4_PCS_TSYNC_DLY_TIME			0x1b4
+#define QPHY_V4_PCS_ELECIDLE_DLY_SEL			0x1b8
+#define QPHY_V4_PCS_CMN_ACK_OUT_SEL			0x1bc
+#define QPHY_V4_PCS_ALIGN_DETECT_CONFIG1		0x1c0
+#define QPHY_V4_PCS_ALIGN_DETECT_CONFIG2		0x1c4
+#define QPHY_V4_PCS_ALIGN_DETECT_CONFIG3		0x1c8
+#define QPHY_V4_PCS_ALIGN_DETECT_CONFIG4		0x1cc
+#define QPHY_V4_PCS_PCS_TX_RX_CONFIG			0x1d0
+#define QPHY_V4_PCS_RX_IDLE_DTCT_CNTRL			0x1d4
+#define QPHY_V4_PCS_RX_DCC_CAL_CONFIG			0x1d8
+#define QPHY_V4_PCS_EQ_CONFIG1				0x1dc
+#define QPHY_V4_PCS_EQ_CONFIG2				0x1e0
+#define QPHY_V4_PCS_EQ_CONFIG3				0x1e4
+#define QPHY_V4_PCS_EQ_CONFIG4				0x1e8
+#define QPHY_V4_PCS_EQ_CONFIG5				0x1ec
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v3.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v3.h
new file mode 100644
index 00000000000..c0bd54e0e7b
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v3.h
@@ -0,0 +1,111 @@
+
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_V3_H_
+#define QCOM_PHY_QMP_QSERDES_COM_V3_H_
+
+/* Only for QMP V3 PHY - QSERDES COM registers */
+#define QSERDES_V3_COM_ATB_SEL1				0x000
+#define QSERDES_V3_COM_ATB_SEL2				0x004
+#define QSERDES_V3_COM_FREQ_UPDATE			0x008
+#define QSERDES_V3_COM_BG_TIMER				0x00c
+#define QSERDES_V3_COM_SSC_EN_CENTER			0x010
+#define QSERDES_V3_COM_SSC_ADJ_PER1			0x014
+#define QSERDES_V3_COM_SSC_ADJ_PER2			0x018
+#define QSERDES_V3_COM_SSC_PER1				0x01c
+#define QSERDES_V3_COM_SSC_PER2				0x020
+#define QSERDES_V3_COM_SSC_STEP_SIZE1			0x024
+#define QSERDES_V3_COM_SSC_STEP_SIZE2			0x028
+#define QSERDES_V3_COM_POST_DIV				0x02c
+#define QSERDES_V3_COM_POST_DIV_MUX			0x030
+#define QSERDES_V3_COM_BIAS_EN_CLKBUFLR_EN		0x034
+#define QSERDES_V3_COM_CLK_ENABLE1			0x038
+#define QSERDES_V3_COM_SYS_CLK_CTRL			0x03c
+#define QSERDES_V3_COM_SYSCLK_BUF_ENABLE		0x040
+#define QSERDES_V3_COM_PLL_EN				0x044
+#define QSERDES_V3_COM_PLL_IVCO				0x048
+#define QSERDES_V3_COM_CMN_IETRIM			0x04c
+#define QSERDES_V3_COM_CMN_IPTRIM			0x050
+#define QSERDES_V3_COM_EP_CLOCK_DETECT_CTR		0x054
+#define QSERDES_V3_COM_SYSCLK_DET_COMP_STATUS		0x058
+#define QSERDES_V3_COM_CLK_EP_DIV			0x05c
+#define QSERDES_V3_COM_CP_CTRL_MODE0			0x060
+#define QSERDES_V3_COM_CP_CTRL_MODE1			0x064
+#define QSERDES_V3_COM_PLL_RCTRL_MODE0			0x068
+#define QSERDES_V3_COM_PLL_RCTRL_MODE1			0x06c
+#define QSERDES_V3_COM_PLL_CCTRL_MODE0			0x070
+#define QSERDES_V3_COM_PLL_CCTRL_MODE1			0x074
+#define QSERDES_V3_COM_PLL_CNTRL			0x078
+#define QSERDES_V3_COM_BIAS_EN_CTRL_BY_PSM		0x07c
+#define QSERDES_V3_COM_SYSCLK_EN_SEL			0x080
+#define QSERDES_V3_COM_CML_SYSCLK_SEL			0x084
+#define QSERDES_V3_COM_RESETSM_CNTRL			0x088
+#define QSERDES_V3_COM_RESETSM_CNTRL2			0x08c
+#define QSERDES_V3_COM_LOCK_CMP_EN			0x090
+#define QSERDES_V3_COM_LOCK_CMP_CFG			0x094
+#define QSERDES_V3_COM_LOCK_CMP1_MODE0			0x098
+#define QSERDES_V3_COM_LOCK_CMP2_MODE0			0x09c
+#define QSERDES_V3_COM_LOCK_CMP3_MODE0			0x0a0
+#define QSERDES_V3_COM_LOCK_CMP1_MODE1			0x0a4
+#define QSERDES_V3_COM_LOCK_CMP2_MODE1			0x0a8
+#define QSERDES_V3_COM_LOCK_CMP3_MODE1			0x0ac
+#define QSERDES_V3_COM_DEC_START_MODE0			0x0b0
+#define QSERDES_V3_COM_DEC_START_MODE1			0x0b4
+#define QSERDES_V3_COM_DIV_FRAC_START1_MODE0		0x0b8
+#define QSERDES_V3_COM_DIV_FRAC_START2_MODE0		0x0bc
+#define QSERDES_V3_COM_DIV_FRAC_START3_MODE0		0x0c0
+#define QSERDES_V3_COM_DIV_FRAC_START1_MODE1		0x0c4
+#define QSERDES_V3_COM_DIV_FRAC_START2_MODE1		0x0c8
+#define QSERDES_V3_COM_DIV_FRAC_START3_MODE1		0x0cc
+#define QSERDES_V3_COM_INTEGLOOP_INITVAL		0x0d0
+#define QSERDES_V3_COM_INTEGLOOP_EN			0x0d4
+#define QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE0		0x0d8
+#define QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE0		0x0dc
+#define QSERDES_V3_COM_INTEGLOOP_GAIN0_MODE1		0x0e0
+#define QSERDES_V3_COM_INTEGLOOP_GAIN1_MODE1		0x0e4
+#define QSERDES_V3_COM_VCOCAL_DEADMAN_CTRL		0x0e8
+#define QSERDES_V3_COM_VCO_TUNE_CTRL			0x0ec
+#define QSERDES_V3_COM_VCO_TUNE_MAP			0x0f0
+#define QSERDES_V3_COM_VCO_TUNE1_MODE0			0x0f4
+#define QSERDES_V3_COM_VCO_TUNE2_MODE0			0x0f8
+#define QSERDES_V3_COM_VCO_TUNE1_MODE1			0x0fc
+#define QSERDES_V3_COM_VCO_TUNE2_MODE1			0x100
+#define QSERDES_V3_COM_VCO_TUNE_INITVAL1		0x104
+#define QSERDES_V3_COM_VCO_TUNE_INITVAL2		0x108
+#define QSERDES_V3_COM_VCO_TUNE_MINVAL1			0x10c
+#define QSERDES_V3_COM_VCO_TUNE_MINVAL2			0x110
+#define QSERDES_V3_COM_VCO_TUNE_MAXVAL1			0x114
+#define QSERDES_V3_COM_VCO_TUNE_MAXVAL2			0x118
+#define QSERDES_V3_COM_VCO_TUNE_TIMER1			0x11c
+#define QSERDES_V3_COM_VCO_TUNE_TIMER2			0x120
+#define QSERDES_V3_COM_CMN_STATUS			0x124
+#define QSERDES_V3_COM_RESET_SM_STATUS			0x128
+#define QSERDES_V3_COM_RESTRIM_CODE_STATUS		0x12c
+#define QSERDES_V3_COM_PLLCAL_CODE1_STATUS		0x130
+#define QSERDES_V3_COM_PLLCAL_CODE2_STATUS		0x134
+#define QSERDES_V3_COM_CLK_SELECT			0x138
+#define QSERDES_V3_COM_HSCLK_SEL			0x13c
+#define QSERDES_V3_COM_INTEGLOOP_BINCODE_STATUS		0x140
+#define QSERDES_V3_COM_PLL_ANALOG			0x144
+#define QSERDES_V3_COM_CORECLK_DIV_MODE0		0x148
+#define QSERDES_V3_COM_CORECLK_DIV_MODE1		0x14c
+#define QSERDES_V3_COM_SW_RESET				0x150
+#define QSERDES_V3_COM_CORE_CLK_EN			0x154
+#define QSERDES_V3_COM_C_READY_STATUS			0x158
+#define QSERDES_V3_COM_CMN_CONFIG			0x15c
+#define QSERDES_V3_COM_CMN_RATE_OVERRIDE		0x160
+#define QSERDES_V3_COM_SVS_MODE_CLK_SEL			0x164
+#define QSERDES_V3_COM_DEBUG_BUS0			0x168
+#define QSERDES_V3_COM_DEBUG_BUS1			0x16c
+#define QSERDES_V3_COM_DEBUG_BUS2			0x170
+#define QSERDES_V3_COM_DEBUG_BUS3			0x174
+#define QSERDES_V3_COM_DEBUG_BUS_SEL			0x178
+#define QSERDES_V3_COM_CMN_MISC1			0x17c
+#define QSERDES_V3_COM_CMN_MISC2			0x180
+#define QSERDES_V3_COM_CMN_MODE				0x184
+#define QSERDES_V3_COM_CMN_VREG_SEL			0x188
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v4.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v4.h
new file mode 100644
index 00000000000..b0e3298d990
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v4.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_V4_H_
+#define QCOM_PHY_QMP_QSERDES_COM_V4_H_
+
+/* Only for QMP V4 PHY - QSERDES COM registers */
+#define QSERDES_V4_COM_ATB_SEL1				0x000
+#define QSERDES_V4_COM_ATB_SEL2				0x004
+#define QSERDES_V4_COM_FREQ_UPDATE			0x008
+#define QSERDES_V4_COM_BG_TIMER				0x00c
+#define QSERDES_V4_COM_SSC_EN_CENTER			0x010
+#define QSERDES_V4_COM_SSC_ADJ_PER1			0x014
+#define QSERDES_V4_COM_SSC_ADJ_PER2			0x018
+#define QSERDES_V4_COM_SSC_PER1				0x01c
+#define QSERDES_V4_COM_SSC_PER2				0x020
+#define QSERDES_V4_COM_SSC_STEP_SIZE1_MODE0		0x024
+#define QSERDES_V4_COM_SSC_STEP_SIZE2_MODE0		0x028
+#define QSERDES_V4_COM_SSC_STEP_SIZE3_MODE0		0x02c
+#define QSERDES_V4_COM_SSC_STEP_SIZE1_MODE1		0x030
+#define QSERDES_V4_COM_SSC_STEP_SIZE2_MODE1		0x034
+#define QSERDES_V4_COM_SSC_STEP_SIZE3_MODE1		0x038
+#define QSERDES_V4_COM_POST_DIV				0x03c
+#define QSERDES_V4_COM_POST_DIV_MUX			0x040
+#define QSERDES_V4_COM_BIAS_EN_CLKBUFLR_EN		0x044
+#define QSERDES_V4_COM_CLK_ENABLE1			0x048
+#define QSERDES_V4_COM_SYS_CLK_CTRL			0x04c
+#define QSERDES_V4_COM_SYSCLK_BUF_ENABLE		0x050
+#define QSERDES_V4_COM_PLL_EN				0x054
+#define QSERDES_V4_COM_PLL_IVCO				0x058
+#define QSERDES_V4_COM_CMN_IETRIM			0x05c
+#define QSERDES_V4_COM_CMN_IPTRIM			0x060
+#define QSERDES_V4_COM_EP_CLOCK_DETECT_CTRL		0x064
+#define QSERDES_V4_COM_SYSCLK_DET_COMP_STATUS		0x068
+#define QSERDES_V4_COM_CLK_EP_DIV_MODE0			0x06c
+#define QSERDES_V4_COM_CLK_EP_DIV_MODE1			0x070
+#define QSERDES_V4_COM_CP_CTRL_MODE0			0x074
+#define QSERDES_V4_COM_CP_CTRL_MODE1			0x078
+#define QSERDES_V4_COM_PLL_RCTRL_MODE0			0x07c
+#define QSERDES_V4_COM_PLL_RCTRL_MODE1			0x080
+#define QSERDES_V4_COM_PLL_CCTRL_MODE0			0x084
+#define QSERDES_V4_COM_PLL_CCTRL_MODE1			0x088
+#define QSERDES_V4_COM_PLL_CNTRL			0x08c
+#define QSERDES_V4_COM_BIAS_EN_CTRL_BY_PSM		0x090
+#define QSERDES_V4_COM_SYSCLK_EN_SEL			0x094
+#define QSERDES_V4_COM_CML_SYSCLK_SEL			0x098
+#define QSERDES_V4_COM_RESETSM_CNTRL			0x09c
+#define QSERDES_V4_COM_RESETSM_CNTRL2			0x0a0
+#define QSERDES_V4_COM_LOCK_CMP_EN			0x0a4
+#define QSERDES_V4_COM_LOCK_CMP_CFG			0x0a8
+#define QSERDES_V4_COM_LOCK_CMP1_MODE0			0x0ac
+#define QSERDES_V4_COM_LOCK_CMP2_MODE0			0x0b0
+#define QSERDES_V4_COM_LOCK_CMP1_MODE1			0x0b4
+#define QSERDES_V4_COM_LOCK_CMP2_MODE1			0x0b8
+#define QSERDES_V4_COM_DEC_START_MODE0			0x0bc
+#define QSERDES_V4_COM_DEC_START_MSB_MODE0		0x0c0
+#define QSERDES_V4_COM_DEC_START_MODE1			0x0c4
+#define QSERDES_V4_COM_DEC_START_MSB_MODE1		0x0c8
+#define QSERDES_V4_COM_DIV_FRAC_START1_MODE0		0x0cc
+#define QSERDES_V4_COM_DIV_FRAC_START2_MODE0		0x0d0
+#define QSERDES_V4_COM_DIV_FRAC_START3_MODE0		0x0d4
+#define QSERDES_V4_COM_DIV_FRAC_START1_MODE1		0x0d8
+#define QSERDES_V4_COM_DIV_FRAC_START2_MODE1		0x0dc
+#define QSERDES_V4_COM_DIV_FRAC_START3_MODE1		0x0e0
+#define QSERDES_V4_COM_INTEGLOOP_INITVAL		0x0e4
+#define QSERDES_V4_COM_INTEGLOOP_EN			0x0e8
+#define QSERDES_V4_COM_INTEGLOOP_GAIN0_MODE0		0x0ec
+#define QSERDES_V4_COM_INTEGLOOP_GAIN1_MODE0		0x0f0
+#define QSERDES_V4_COM_INTEGLOOP_GAIN0_MODE1		0x0f4
+#define QSERDES_V4_COM_INTEGLOOP_GAIN1_MODE1		0x0f8
+#define QSERDES_V4_COM_INTEGLOOP_P_PATH_GAIN0		0x0fc
+#define QSERDES_V4_COM_INTEGLOOP_P_PATH_GAIN1		0x100
+#define QSERDES_V4_COM_VCOCAL_DEADMAN_CTRL		0x104
+#define QSERDES_V4_COM_VCO_TUNE_CTRL			0x108
+#define QSERDES_V4_COM_VCO_TUNE_MAP			0x10c
+#define QSERDES_V4_COM_VCO_TUNE1_MODE0			0x110
+#define QSERDES_V4_COM_VCO_TUNE2_MODE0			0x114
+#define QSERDES_V4_COM_VCO_TUNE1_MODE1			0x118
+#define QSERDES_V4_COM_VCO_TUNE2_MODE1			0x11c
+#define QSERDES_V4_COM_VCO_TUNE_INITVAL1		0x120
+#define QSERDES_V4_COM_VCO_TUNE_INITVAL2		0x124
+#define QSERDES_V4_COM_VCO_TUNE_MINVAL1			0x128
+#define QSERDES_V4_COM_VCO_TUNE_MINVAL2			0x12c
+#define QSERDES_V4_COM_VCO_TUNE_MAXVAL1			0x130
+#define QSERDES_V4_COM_VCO_TUNE_MAXVAL2			0x134
+#define QSERDES_V4_COM_VCO_TUNE_TIMER1			0x138
+#define QSERDES_V4_COM_VCO_TUNE_TIMER2			0x13c
+#define QSERDES_V4_COM_CMN_STATUS			0x140
+#define QSERDES_V4_COM_RESET_SM_STATUS			0x144
+#define QSERDES_V4_COM_RESTRIM_CODE_STATUS		0x148
+#define QSERDES_V4_COM_PLLCAL_CODE1_STATUS		0x14c
+#define QSERDES_V4_COM_PLLCAL_CODE2_STATUS		0x150
+#define QSERDES_V4_COM_CLK_SELECT			0x154
+#define QSERDES_V4_COM_HSCLK_SEL			0x158
+#define QSERDES_V4_COM_HSCLK_HS_SWITCH_SEL		0x15c
+#define QSERDES_V4_COM_INTEGLOOP_BINCODE_STATUS		0x160
+#define QSERDES_V4_COM_PLL_ANALOG			0x164
+#define QSERDES_V4_COM_CORECLK_DIV_MODE0		0x168
+#define QSERDES_V4_COM_CORECLK_DIV_MODE1		0x16c
+#define QSERDES_V4_COM_SW_RESET				0x170
+#define QSERDES_V4_COM_CORE_CLK_EN			0x174
+#define QSERDES_V4_COM_C_READY_STATUS			0x178
+#define QSERDES_V4_COM_CMN_CONFIG			0x17c
+#define QSERDES_V4_COM_CMN_RATE_OVERRIDE		0x180
+#define QSERDES_V4_COM_SVS_MODE_CLK_SEL			0x184
+#define QSERDES_V4_COM_DEBUG_BUS0			0x188
+#define QSERDES_V4_COM_DEBUG_BUS1			0x18c
+#define QSERDES_V4_COM_DEBUG_BUS2			0x190
+#define QSERDES_V4_COM_DEBUG_BUS3			0x194
+#define QSERDES_V4_COM_DEBUG_BUS_SEL			0x198
+#define QSERDES_V4_COM_CMN_MISC1			0x19c
+#define QSERDES_V4_COM_CMN_MISC2			0x1a0
+#define QSERDES_V4_COM_CMN_MODE				0x1a4
+#define QSERDES_V4_COM_VCO_DC_LEVEL_CTRL		0x1a8
+#define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x1ac
+#define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x1b0
+#define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE1_MODE1	0x1b4
+#define QSERDES_V4_COM_BIN_VCOCAL_CMP_CODE2_MODE1	0x1b8
+#define QSERDES_V4_COM_BIN_VCOCAL_HSCLK_SEL		0x1bc
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h
new file mode 100644
index 00000000000..328c6c0b0b0
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v6.h
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_V6_H_
+#define QCOM_PHY_QMP_QSERDES_COM_V6_H_
+
+/* Only for QMP V6 PHY - QSERDES COM registers */
+
+#define QSERDES_V6_COM_SSC_STEP_SIZE1_MODE1			0x00
+#define QSERDES_V6_COM_SSC_STEP_SIZE2_MODE1			0x04
+#define QSERDES_V6_COM_CP_CTRL_MODE1				0x10
+#define QSERDES_V6_COM_PLL_RCTRL_MODE1				0x14
+#define QSERDES_V6_COM_PLL_CCTRL_MODE1				0x18
+#define QSERDES_V6_COM_CORECLK_DIV_MODE1			0x1c
+#define QSERDES_V6_COM_LOCK_CMP1_MODE1				0x20
+#define QSERDES_V6_COM_LOCK_CMP2_MODE1				0x24
+#define QSERDES_V6_COM_DEC_START_MODE1				0x28
+#define QSERDES_V6_COM_DEC_START_MSB_MODE1			0x2c
+#define QSERDES_V6_COM_DIV_FRAC_START1_MODE1			0x30
+#define QSERDES_V6_COM_DIV_FRAC_START2_MODE1			0x34
+#define QSERDES_V6_COM_DIV_FRAC_START3_MODE1			0x38
+#define QSERDES_V6_COM_HSCLK_SEL_1				0x3c
+#define QSERDES_V6_COM_INTEGLOOP_GAIN0_MODE1			0x40
+#define QSERDES_V6_COM_INTEGLOOP_GAIN1_MODE1			0x44
+#define QSERDES_V6_COM_VCO_TUNE1_MODE1				0x48
+#define QSERDES_V6_COM_VCO_TUNE2_MODE1				0x4c
+#define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE1		0x50
+#define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE1		0x54
+#define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE1_MODE0		0x58
+#define QSERDES_V6_COM_BIN_VCOCAL_CMP_CODE2_MODE0		0x5c
+#define QSERDES_V6_COM_SSC_STEP_SIZE1_MODE0			0x60
+#define QSERDES_V6_COM_SSC_STEP_SIZE2_MODE0			0x64
+#define QSERDES_V6_COM_CP_CTRL_MODE0				0x70
+#define QSERDES_V6_COM_PLL_RCTRL_MODE0				0x74
+#define QSERDES_V6_COM_PLL_CCTRL_MODE0				0x78
+#define QSERDES_V6_COM_PLL_CORE_CLK_DIV_MODE0			0x7c
+#define QSERDES_V6_COM_LOCK_CMP1_MODE0				0x80
+#define QSERDES_V6_COM_LOCK_CMP2_MODE0				0x84
+#define QSERDES_V6_COM_DEC_START_MODE0				0x88
+#define QSERDES_V6_COM_DEC_START_MSB_MODE0			0x8c
+#define QSERDES_V6_COM_DIV_FRAC_START1_MODE0			0x90
+#define QSERDES_V6_COM_DIV_FRAC_START2_MODE0			0x94
+#define QSERDES_V6_COM_DIV_FRAC_START3_MODE0			0x98
+#define QSERDES_V6_COM_HSCLK_HS_SWITCH_SEL_1			0x9c
+#define QSERDES_V6_COM_INTEGLOOP_GAIN0_MODE0			0xa0
+#define QSERDES_V6_COM_INTEGLOOP_GAIN1_MODE0			0xa4
+#define QSERDES_V6_COM_VCO_TUNE1_MODE0				0xa8
+#define QSERDES_V6_COM_VCO_TUNE2_MODE0				0xac
+#define QSERDES_V6_COM_BG_TIMER					0xbc
+#define QSERDES_V6_COM_SSC_EN_CENTER				0xc0
+#define QSERDES_V6_COM_SSC_ADJ_PER1				0xc4
+#define QSERDES_V6_COM_SSC_PER1					0xcc
+#define QSERDES_V6_COM_SSC_PER2					0xd0
+#define QSERDES_V6_COM_PLL_POST_DIV_MUX				0xd8
+#define QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN			0xdc
+#define QSERDES_V6_COM_CLK_ENABLE1				0xe0
+#define QSERDES_V6_COM_SYS_CLK_CTRL				0xe4
+#define QSERDES_V6_COM_SYSCLK_BUF_ENABLE			0xe8
+#define QSERDES_V6_COM_PLL_IVCO					0xf4
+#define QSERDES_V6_COM_PLL_IVCO_MODE1				0xf8
+#define QSERDES_V6_COM_CMN_IETRIM				0xfc
+#define QSERDES_V6_COM_CMN_IPTRIM				0x100
+#define QSERDES_V6_COM_SYSCLK_EN_SEL				0x110
+#define QSERDES_V6_COM_RESETSM_CNTRL				0x118
+#define QSERDES_V6_COM_LOCK_CMP_EN				0x120
+#define QSERDES_V6_COM_LOCK_CMP_CFG				0x124
+#define QSERDES_V6_COM_VCO_TUNE_CTRL				0x13c
+#define QSERDES_V6_COM_VCO_TUNE_MAP				0x140
+#define QSERDES_V6_COM_VCO_TUNE_INITVAL2			0x148
+#define QSERDES_V6_COM_VCO_TUNE_MAXVAL2				0x158
+#define QSERDES_V6_COM_CLK_SELECT				0x164
+#define QSERDES_V6_COM_CORE_CLK_EN				0x170
+#define QSERDES_V6_COM_CMN_CONFIG_1				0x174
+#define QSERDES_V6_COM_SVS_MODE_CLK_SEL				0x17c
+#define QSERDES_V6_COM_CMN_MISC_1				0x184
+#define QSERDES_V6_COM_CMN_MODE					0x188
+#define QSERDES_V6_COM_PLL_VCO_DC_LEVEL_CTRL			0x198
+#define QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_1			0x1a4
+#define QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_2			0x1a8
+#define QSERDES_V6_COM_AUTO_GAIN_ADJ_CTRL_3			0x1ac
+#define QSERDES_V6_COM_ADDITIONAL_MISC				0x1b4
+#define QSERDES_V6_COM_ADDITIONAL_MISC_2			0x1b8
+#define QSERDES_V6_COM_ADDITIONAL_MISC_3			0x1bc
+#define QSERDES_V6_COM_CMN_STATUS				0x1d0
+#define QSERDES_V6_COM_C_READY_STATUS				0x1f8
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h
new file mode 100644
index 00000000000..7fa5363feeb
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com.h
@@ -0,0 +1,140 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_H_
+#define QCOM_PHY_QMP_QSERDES_COM_H_
+
+/* Only for QMP V2 PHY - QSERDES COM registers */
+#define QSERDES_COM_ATB_SEL1				0x000
+#define QSERDES_COM_ATB_SEL2				0x004
+#define QSERDES_COM_FREQ_UPDATE				0x008
+#define QSERDES_COM_BG_TIMER				0x00c
+#define QSERDES_COM_SSC_EN_CENTER			0x010
+#define QSERDES_COM_SSC_ADJ_PER1			0x014
+#define QSERDES_COM_SSC_ADJ_PER2			0x018
+#define QSERDES_COM_SSC_PER1				0x01c
+#define QSERDES_COM_SSC_PER2				0x020
+#define QSERDES_COM_SSC_STEP_SIZE1			0x024
+#define QSERDES_COM_SSC_STEP_SIZE2			0x028
+#define QSERDES_COM_POST_DIV				0x02c
+#define QSERDES_COM_POST_DIV_MUX			0x030
+#define QSERDES_COM_BIAS_EN_CLKBUFLR_EN			0x034
+#define QSERDES_COM_CLK_ENABLE1				0x038
+#define QSERDES_COM_SYS_CLK_CTRL			0x03c
+#define QSERDES_COM_SYSCLK_BUF_ENABLE			0x040
+#define QSERDES_COM_PLL_EN				0x044
+#define QSERDES_COM_PLL_IVCO				0x048
+#define QSERDES_COM_LOCK_CMP1_MODE0			0x04c
+#define QSERDES_COM_LOCK_CMP2_MODE0			0x050
+#define QSERDES_COM_LOCK_CMP3_MODE0			0x054
+#define QSERDES_COM_LOCK_CMP1_MODE1			0x058
+#define QSERDES_COM_LOCK_CMP2_MODE1			0x05c
+#define QSERDES_COM_LOCK_CMP3_MODE1			0x060
+#define QSERDES_COM_LOCK_CMP1_MODE2			0x064
+#define QSERDES_COM_CMN_RSVD0				0x064
+#define QSERDES_COM_LOCK_CMP2_MODE2			0x068
+#define QSERDES_COM_EP_CLOCK_DETECT_CTRL		0x068
+#define QSERDES_COM_LOCK_CMP3_MODE2			0x06c
+#define QSERDES_COM_SYSCLK_DET_COMP_STATUS		0x06c
+#define QSERDES_COM_BG_TRIM				0x070
+#define QSERDES_COM_CLK_EP_DIV				0x074
+#define QSERDES_COM_CP_CTRL_MODE0			0x078
+#define QSERDES_COM_CP_CTRL_MODE1			0x07c
+#define QSERDES_COM_CP_CTRL_MODE2			0x080
+#define QSERDES_COM_CMN_RSVD1				0x080
+#define QSERDES_COM_PLL_RCTRL_MODE0			0x084
+#define QSERDES_COM_PLL_RCTRL_MODE1			0x088
+#define QSERDES_COM_PLL_RCTRL_MODE2			0x08c
+#define QSERDES_COM_CMN_RSVD2				0x08c
+#define QSERDES_COM_PLL_CCTRL_MODE0			0x090
+#define QSERDES_COM_PLL_CCTRL_MODE1			0x094
+#define QSERDES_COM_PLL_CCTRL_MODE2			0x098
+#define QSERDES_COM_CMN_RSVD3				0x098
+#define QSERDES_COM_PLL_CNTRL				0x09c
+#define QSERDES_COM_PHASE_SEL_CTRL			0x0a0
+#define QSERDES_COM_PHASE_SEL_DC			0x0a4
+#define QSERDES_COM_CORE_CLK_IN_SYNC_SEL		0x0a8
+#define QSERDES_COM_BIAS_EN_CTRL_BY_PSM			0x0a8
+#define QSERDES_COM_SYSCLK_EN_SEL			0x0ac
+#define QSERDES_COM_CML_SYSCLK_SEL			0x0b0
+#define QSERDES_COM_RESETSM_CNTRL			0x0b4
+#define QSERDES_COM_RESETSM_CNTRL2			0x0b8
+#define QSERDES_COM_RESTRIM_CTRL			0x0bc
+#define QSERDES_COM_RESTRIM_CTRL2			0x0c0
+#define QSERDES_COM_RESCODE_DIV_NUM			0x0c4
+#define QSERDES_COM_LOCK_CMP_EN				0x0c8
+#define QSERDES_COM_LOCK_CMP_CFG			0x0cc
+#define QSERDES_COM_DEC_START_MODE0			0x0d0
+#define QSERDES_COM_DEC_START_MODE1			0x0d4
+#define QSERDES_COM_DEC_START_MODE2			0x0d8
+#define QSERDES_COM_VCOCAL_DEADMAN_CTRL			0x0d8
+#define QSERDES_COM_DIV_FRAC_START1_MODE0		0x0dc
+#define QSERDES_COM_DIV_FRAC_START2_MODE0		0x0e0
+#define QSERDES_COM_DIV_FRAC_START3_MODE0		0x0e4
+#define QSERDES_COM_DIV_FRAC_START1_MODE1		0x0e8
+#define QSERDES_COM_DIV_FRAC_START2_MODE1		0x0ec
+#define QSERDES_COM_DIV_FRAC_START3_MODE1		0x0f0
+#define QSERDES_COM_DIV_FRAC_START1_MODE2		0x0f4
+#define QSERDES_COM_VCO_TUNE_MINVAL1			0x0f4
+#define QSERDES_COM_DIV_FRAC_START2_MODE2		0x0f8
+#define QSERDES_COM_VCO_TUNE_MINVAL2			0x0f8
+#define QSERDES_COM_DIV_FRAC_START3_MODE2		0x0fc
+#define QSERDES_COM_CMN_RSVD4				0x0fc
+#define QSERDES_COM_INTEGLOOP_INITVAL			0x100
+#define QSERDES_COM_INTEGLOOP_EN			0x104
+#define QSERDES_COM_INTEGLOOP_GAIN0_MODE0		0x108
+#define QSERDES_COM_INTEGLOOP_GAIN1_MODE0		0x10c
+#define QSERDES_COM_INTEGLOOP_GAIN0_MODE1		0x110
+#define QSERDES_COM_INTEGLOOP_GAIN1_MODE1		0x114
+#define QSERDES_COM_INTEGLOOP_GAIN0_MODE2		0x118
+#define QSERDES_COM_VCO_TUNE_MAXVAL1			0x118
+#define QSERDES_COM_INTEGLOOP_GAIN1_MODE2		0x11c
+#define QSERDES_COM_VCO_TUNE_MAXVAL2			0x11c
+#define QSERDES_COM_RES_TRIM_CONTROL2			0x120
+#define QSERDES_COM_VCO_TUNE_CTRL			0x124
+#define QSERDES_COM_VCO_TUNE_MAP			0x128
+#define QSERDES_COM_VCO_TUNE1_MODE0			0x12c
+#define QSERDES_COM_VCO_TUNE2_MODE0			0x130
+#define QSERDES_COM_VCO_TUNE1_MODE1			0x134
+#define QSERDES_COM_VCO_TUNE2_MODE1			0x138
+#define QSERDES_COM_VCO_TUNE1_MODE2			0x13c
+#define QSERDES_COM_VCO_TUNE_INITVAL1			0x13c
+#define QSERDES_COM_VCO_TUNE2_MODE2			0x140
+#define QSERDES_COM_VCO_TUNE_INITVAL2			0x140
+#define QSERDES_COM_VCO_TUNE_TIMER1			0x144
+#define QSERDES_COM_VCO_TUNE_TIMER2			0x148
+#define QSERDES_COM_SAR					0x14c
+#define QSERDES_COM_SAR_CLK				0x150
+#define QSERDES_COM_SAR_CODE_OUT_STATUS			0x154
+#define QSERDES_COM_SAR_CODE_READY_STATUS		0x158
+#define QSERDES_COM_CMN_STATUS				0x15c
+#define QSERDES_COM_RESET_SM_STATUS			0x160
+#define QSERDES_COM_RESTRIM_CODE_STATUS			0x164
+#define QSERDES_COM_PLLCAL_CODE1_STATUS			0x168
+#define QSERDES_COM_PLLCAL_CODE2_STATUS			0x16c
+#define QSERDES_COM_BG_CTRL				0x170
+#define QSERDES_COM_CLK_SELECT				0x174
+#define QSERDES_COM_HSCLK_SEL				0x178
+#define QSERDES_COM_INTEGLOOP_BINCODE_STATUS		0x17c
+#define QSERDES_COM_PLL_ANALOG				0x180
+#define QSERDES_COM_CORECLK_DIV				0x184
+#define QSERDES_COM_SW_RESET				0x188
+#define QSERDES_COM_CORE_CLK_EN				0x18c
+#define QSERDES_COM_C_READY_STATUS			0x190
+#define QSERDES_COM_CMN_CONFIG				0x194
+#define QSERDES_COM_CMN_RATE_OVERRIDE			0x198
+#define QSERDES_COM_SVS_MODE_CLK_SEL			0x19c
+#define QSERDES_COM_DEBUG_BUS0				0x1a0
+#define QSERDES_COM_DEBUG_BUS1				0x1a4
+#define QSERDES_COM_DEBUG_BUS2				0x1a8
+#define QSERDES_COM_DEBUG_BUS3				0x1ac
+#define QSERDES_COM_DEBUG_BUS_SEL			0x1b0
+#define QSERDES_COM_CMN_MISC1				0x1b4
+#define QSERDES_COM_CMN_MISC2				0x1b8
+#define QSERDES_COM_CORECLK_DIV_MODE1			0x1bc
+#define QSERDES_COM_CORECLK_DIV_MODE2			0x1c0
+#define QSERDES_COM_CMN_RSVD5				0x1c4
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-pll.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-pll.h
new file mode 100644
index 00000000000..231e59364e3
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-pll.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_PLL_H_
+#define QCOM_PHY_QMP_QSERDES_PLL_H_
+
+/* QMP V2 PHY for PCIE gen3 ports - QSERDES PLL registers */
+#define QSERDES_PLL_BG_TIMER				0x00c
+#define QSERDES_PLL_SSC_EN_CENTER			0x010
+#define QSERDES_PLL_SSC_ADJ_PER1			0x014
+#define QSERDES_PLL_SSC_ADJ_PER2			0x018
+#define QSERDES_PLL_SSC_PER1				0x01c
+#define QSERDES_PLL_SSC_PER2				0x020
+#define QSERDES_PLL_SSC_STEP_SIZE1_MODE0		0x024
+#define QSERDES_PLL_SSC_STEP_SIZE2_MODE0		0x028
+#define QSERDES_PLL_SSC_STEP_SIZE1_MODE1		0x02c
+#define QSERDES_PLL_SSC_STEP_SIZE2_MODE1		0x030
+#define QSERDES_PLL_BIAS_EN_CLKBUFLR_EN			0x03c
+#define QSERDES_PLL_CLK_ENABLE1				0x040
+#define QSERDES_PLL_SYS_CLK_CTRL			0x044
+#define QSERDES_PLL_SYSCLK_BUF_ENABLE			0x048
+#define QSERDES_PLL_PLL_IVCO				0x050
+#define QSERDES_PLL_LOCK_CMP1_MODE0			0x054
+#define QSERDES_PLL_LOCK_CMP2_MODE0			0x058
+#define QSERDES_PLL_LOCK_CMP1_MODE1			0x060
+#define QSERDES_PLL_LOCK_CMP2_MODE1			0x064
+#define QSERDES_PLL_BG_TRIM				0x074
+#define QSERDES_PLL_CLK_EP_DIV_MODE0			0x078
+#define QSERDES_PLL_CLK_EP_DIV_MODE1			0x07c
+#define QSERDES_PLL_CP_CTRL_MODE0			0x080
+#define QSERDES_PLL_CP_CTRL_MODE1			0x084
+#define QSERDES_PLL_PLL_RCTRL_MODE0			0x088
+#define QSERDES_PLL_PLL_RCTRL_MODE1			0x08c
+#define QSERDES_PLL_PLL_CCTRL_MODE0			0x090
+#define QSERDES_PLL_PLL_CCTRL_MODE1			0x094
+#define QSERDES_PLL_BIAS_EN_CTRL_BY_PSM			0x0a4
+#define QSERDES_PLL_SYSCLK_EN_SEL			0x0a8
+#define QSERDES_PLL_RESETSM_CNTRL			0x0b0
+#define QSERDES_PLL_LOCK_CMP_EN				0x0c4
+#define QSERDES_PLL_DEC_START_MODE0			0x0cc
+#define QSERDES_PLL_DEC_START_MODE1			0x0d0
+#define QSERDES_PLL_DIV_FRAC_START1_MODE0		0x0d8
+#define QSERDES_PLL_DIV_FRAC_START2_MODE0		0x0dc
+#define QSERDES_PLL_DIV_FRAC_START3_MODE0		0x0e0
+#define QSERDES_PLL_DIV_FRAC_START1_MODE1		0x0e4
+#define QSERDES_PLL_DIV_FRAC_START2_MODE1		0x0e8
+#define QSERDES_PLL_DIV_FRAC_START3_MODE1		0x0ec
+#define QSERDES_PLL_INTEGLOOP_GAIN0_MODE0		0x100
+#define QSERDES_PLL_INTEGLOOP_GAIN1_MODE0		0x104
+#define QSERDES_PLL_INTEGLOOP_GAIN0_MODE1		0x108
+#define QSERDES_PLL_INTEGLOOP_GAIN1_MODE1		0x10c
+#define QSERDES_PLL_VCO_TUNE_MAP			0x120
+#define QSERDES_PLL_VCO_TUNE1_MODE0			0x124
+#define QSERDES_PLL_VCO_TUNE2_MODE0			0x128
+#define QSERDES_PLL_VCO_TUNE1_MODE1			0x12c
+#define QSERDES_PLL_VCO_TUNE2_MODE1			0x130
+#define QSERDES_PLL_VCO_TUNE_TIMER1			0x13c
+#define QSERDES_PLL_VCO_TUNE_TIMER2			0x140
+#define QSERDES_PLL_CLK_SELECT				0x16c
+#define QSERDES_PLL_HSCLK_SEL				0x170
+#define QSERDES_PLL_CORECLK_DIV				0x17c
+#define QSERDES_PLL_CORE_CLK_EN				0x184
+#define QSERDES_PLL_CMN_CONFIG				0x18c
+#define QSERDES_PLL_SVS_MODE_CLK_SEL			0x194
+#define QSERDES_PLL_CORECLK_DIV_MODE1			0x1b4
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
new file mode 100644
index 00000000000..d17a5235796
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_UFS_V6_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_UFS_V6_H_
+
+#define QSERDES_UFS_V6_TX_RES_CODE_LANE_TX			0x28
+#define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX			0x2c
+#define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX		0x30
+#define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX		0x34
+#define QSERDES_UFS_V6_TX_LANE_MODE_1				0x7c
+#define QSERDES_UFS_V6_TX_FR_DCC_CTRL				0x108
+
+#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE2		0x08
+#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_FO_GAIN_RATE4		0x10
+#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_SO_GAIN_RATE4		0x24
+#define QSERDES_UFS_V6_RX_UCDR_SO_SATURATION			0x28
+#define QSERDES_UFS_V6_RX_UCDR_FASTLOCK_COUNT_HIGH_RATE4	0x54
+#define QSERDES_UFS_V6_RX_UCDR_PI_CTRL1				0x58
+#define QSERDES_UFS_V6_RX_RX_TERM_BW_CTRL0			0xc4
+#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2			0xd4
+#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4			0xdc
+#define QSERDES_UFS_V6_RX_UCDR_SO_GAIN_RATE4			0xf0
+#define QSERDES_UFS_V6_RX_UCDR_PI_CONTROLS			0xf4
+#define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL			0x178
+#define QSERDES_UFS_V6_RX_RX_EQU_ADAPTOR_CNTRL4			0x1ac
+#define QSERDES_UFS_V6_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x1bc
+#define QSERDES_UFS_V6_RX_INTERFACE_MODE			0x1e0
+#define QSERDES_UFS_V6_RX_OFFSET_ADAPTOR_CNTRL3			0x1c4
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0			0x208
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1			0x20c
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B2			0x210
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3			0x214
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B4			0x218
+#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6			0x220
+#define QSERDES_UFS_V6_RX_MODE_RATE2_B3				0x238
+#define QSERDES_UFS_V6_RX_MODE_RATE2_B6				0x244
+#define QSERDES_UFS_V6_RX_MODE_RATE3_B3				0x25c
+#define QSERDES_UFS_V6_RX_MODE_RATE3_B4				0x260
+#define QSERDES_UFS_V6_RX_MODE_RATE3_B5				0x264
+#define QSERDES_UFS_V6_RX_MODE_RATE3_B8				0x270
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B0				0x274
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B1				0x278
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B2				0x27c
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B3				0x280
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B4				0x284
+#define QSERDES_UFS_V6_RX_MODE_RATE4_B6				0x28c
+#define QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL			0x2f8
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v3.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v3.h
new file mode 100644
index 00000000000..161e6df30ea
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v3.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V3_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V3_H_
+
+/* Only for QMP V3 PHY - TX registers */
+#define QSERDES_V3_TX_BIST_MODE_LANENO			0x000
+#define QSERDES_V3_TX_CLKBUF_ENABLE			0x008
+#define QSERDES_V3_TX_TX_EMP_POST1_LVL			0x00c
+#define QSERDES_V3_TX_TX_DRV_LVL			0x01c
+#define QSERDES_V3_TX_RESET_TSYNC_EN			0x024
+#define QSERDES_V3_TX_PRE_STALL_LDO_BOOST_EN		0x028
+#define QSERDES_V3_TX_TX_BAND				0x02c
+#define QSERDES_V3_TX_SLEW_CNTL				0x030
+#define QSERDES_V3_TX_INTERFACE_SELECT			0x034
+#define QSERDES_V3_TX_RES_CODE_LANE_TX			0x03c
+#define QSERDES_V3_TX_RES_CODE_LANE_RX			0x040
+#define QSERDES_V3_TX_RES_CODE_LANE_OFFSET_TX		0x044
+#define QSERDES_V3_TX_RES_CODE_LANE_OFFSET_RX		0x048
+#define QSERDES_V3_TX_DEBUG_BUS_SEL			0x058
+#define QSERDES_V3_TX_TRANSCEIVER_BIAS_EN		0x05c
+#define QSERDES_V3_TX_HIGHZ_DRVR_EN			0x060
+#define QSERDES_V3_TX_TX_POL_INV			0x064
+#define QSERDES_V3_TX_PARRATE_REC_DETECT_IDLE_EN	0x068
+#define QSERDES_V3_TX_LANE_MODE_1			0x08c
+#define QSERDES_V3_TX_LANE_MODE_2			0x090
+#define QSERDES_V3_TX_LANE_MODE_3			0x094
+#define QSERDES_V3_TX_RCV_DETECT_LVL_2			0x0a4
+#define QSERDES_V3_TX_TRAN_DRVR_EMP_EN			0x0c0
+#define QSERDES_V3_TX_TX_INTERFACE_MODE			0x0c4
+#define QSERDES_V3_TX_VMODE_CTRL1			0x0f0
+
+/* Only for QMP V3 PHY - RX registers */
+#define QSERDES_V3_RX_UCDR_FO_GAIN			0x008
+#define QSERDES_V3_RX_UCDR_SO_GAIN_HALF			0x00c
+#define QSERDES_V3_RX_UCDR_SO_GAIN			0x014
+#define QSERDES_V3_RX_UCDR_SVS_SO_GAIN_HALF		0x024
+#define QSERDES_V3_RX_UCDR_SVS_SO_GAIN_QUARTER		0x028
+#define QSERDES_V3_RX_UCDR_SVS_SO_GAIN			0x02c
+#define QSERDES_V3_RX_UCDR_FASTLOCK_FO_GAIN		0x030
+#define QSERDES_V3_RX_UCDR_SO_SATURATION_AND_ENABLE	0x034
+#define QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_LOW		0x03c
+#define QSERDES_V3_RX_UCDR_FASTLOCK_COUNT_HIGH		0x040
+#define QSERDES_V3_RX_UCDR_PI_CONTROLS			0x044
+#define QSERDES_V3_RX_RX_TERM_BW			0x07c
+#define QSERDES_V3_RX_VGA_CAL_CNTRL1			0x0bc
+#define QSERDES_V3_RX_VGA_CAL_CNTRL2			0x0c0
+#define QSERDES_V3_RX_RX_EQ_GAIN2_LSB			0x0c8
+#define QSERDES_V3_RX_RX_EQ_GAIN2_MSB			0x0cc
+#define QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL1		0x0d0
+#define QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL2		0x0d4
+#define QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL3		0x0d8
+#define QSERDES_V3_RX_RX_EQU_ADAPTOR_CNTRL4		0x0dc
+#define QSERDES_V3_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1	0x0f8
+#define QSERDES_V3_RX_RX_OFFSET_ADAPTOR_CNTRL2		0x0fc
+#define QSERDES_V3_RX_SIGDET_ENABLES			0x100
+#define QSERDES_V3_RX_SIGDET_CNTRL			0x104
+#define QSERDES_V3_RX_SIGDET_LVL			0x108
+#define QSERDES_V3_RX_SIGDET_DEGLITCH_CNTRL		0x10c
+#define QSERDES_V3_RX_RX_BAND				0x110
+#define QSERDES_V3_RX_RX_INTERFACE_MODE			0x11c
+#define QSERDES_V3_RX_RX_MODE_00			0x164
+#define QSERDES_V3_RX_RX_MODE_01			0x168
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4.h
new file mode 100644
index 00000000000..6ee3bec9ac4
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v4.h
@@ -0,0 +1,233 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V4_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V4_H_
+
+/* Only for QMP V4 PHY - TX registers */
+#define QSERDES_V4_TX_BIST_MODE_LANENO			0x000
+#define QSERDES_V4_TX_BIST_INVERT			0x004
+#define QSERDES_V4_TX_CLKBUF_ENABLE			0x008
+#define QSERDES_V4_TX_TX_EMP_POST1_LVL			0x00c
+#define QSERDES_V4_TX_TX_IDLE_LVL_LARGE_AMP		0x010
+#define QSERDES_V4_TX_TX_DRV_LVL			0x014
+#define QSERDES_V4_TX_TX_DRV_LVL_OFFSET			0x018
+#define QSERDES_V4_TX_RESET_TSYNC_EN			0x01c
+#define QSERDES_V4_TX_PRE_STALL_LDO_BOOST_EN		0x020
+#define QSERDES_V4_TX_TX_BAND				0x024
+#define QSERDES_V4_TX_SLEW_CNTL				0x028
+#define QSERDES_V4_TX_INTERFACE_SELECT			0x02c
+#define QSERDES_V4_TX_LPB_EN				0x030
+#define QSERDES_V4_TX_RES_CODE_LANE_TX			0x034
+#define QSERDES_V4_TX_RES_CODE_LANE_RX			0x038
+#define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_TX		0x03c
+#define QSERDES_V4_TX_RES_CODE_LANE_OFFSET_RX		0x040
+#define QSERDES_V4_TX_PERL_LENGTH1			0x044
+#define QSERDES_V4_TX_PERL_LENGTH2			0x048
+#define QSERDES_V4_TX_SERDES_BYP_EN_OUT			0x04c
+#define QSERDES_V4_TX_DEBUG_BUS_SEL			0x050
+#define QSERDES_V4_TX_TRANSCEIVER_BIAS_EN		0x054
+#define QSERDES_V4_TX_HIGHZ_DRVR_EN			0x058
+#define QSERDES_V4_TX_TX_POL_INV			0x05c
+#define QSERDES_V4_TX_PARRATE_REC_DETECT_IDLE_EN	0x060
+#define QSERDES_V4_TX_BIST_PATTERN1			0x064
+#define QSERDES_V4_TX_BIST_PATTERN2			0x068
+#define QSERDES_V4_TX_BIST_PATTERN3			0x06c
+#define QSERDES_V4_TX_BIST_PATTERN4			0x070
+#define QSERDES_V4_TX_BIST_PATTERN5			0x074
+#define QSERDES_V4_TX_BIST_PATTERN6			0x078
+#define QSERDES_V4_TX_BIST_PATTERN7			0x07c
+#define QSERDES_V4_TX_BIST_PATTERN8			0x080
+#define QSERDES_V4_TX_LANE_MODE_1			0x084
+#define QSERDES_V4_TX_LANE_MODE_2			0x088
+#define QSERDES_V4_TX_LANE_MODE_3			0x08c
+#define QSERDES_V4_TX_ATB_SEL1				0x090
+#define QSERDES_V4_TX_ATB_SEL2				0x094
+#define QSERDES_V4_TX_RCV_DETECT_LVL			0x098
+#define QSERDES_V4_TX_RCV_DETECT_LVL_2			0x09c
+#define QSERDES_V4_TX_PRBS_SEED1			0x0a0
+#define QSERDES_V4_TX_PRBS_SEED2			0x0a4
+#define QSERDES_V4_TX_PRBS_SEED3			0x0a8
+#define QSERDES_V4_TX_PRBS_SEED4			0x0ac
+#define QSERDES_V4_TX_RESET_GEN				0x0b0
+#define QSERDES_V4_TX_RESET_GEN_MUXES			0x0b4
+#define QSERDES_V4_TX_TRAN_DRVR_EMP_EN			0x0b8
+#define QSERDES_V4_TX_TX_INTERFACE_MODE			0x0bc
+#define QSERDES_V4_TX_PWM_CTRL				0x0c0
+#define QSERDES_V4_TX_PWM_ENCODED_OR_DATA		0x0c4
+#define QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND2		0x0c8
+#define QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND2		0x0cc
+#define QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND2		0x0d0
+#define QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND2		0x0d4
+#define QSERDES_V4_TX_PWM_GEAR_1_DIVIDER_BAND0_1	0x0d8
+#define QSERDES_V4_TX_PWM_GEAR_2_DIVIDER_BAND0_1	0x0dc
+#define QSERDES_V4_TX_PWM_GEAR_3_DIVIDER_BAND0_1	0x0e0
+#define QSERDES_V4_TX_PWM_GEAR_4_DIVIDER_BAND0_1	0x0e4
+#define QSERDES_V4_TX_VMODE_CTRL1			0x0e8
+#define QSERDES_V4_TX_ALOG_OBSV_BUS_CTRL_1		0x0ec
+#define QSERDES_V4_TX_BIST_STATUS			0x0f0
+#define QSERDES_V4_TX_BIST_ERROR_COUNT1			0x0f4
+#define QSERDES_V4_TX_BIST_ERROR_COUNT2			0x0f8
+#define QSERDES_V4_TX_ALOG_OBSV_BUS_STATUS_1		0x0fc
+#define QSERDES_V4_TX_LANE_DIG_CONFIG			0x100
+#define QSERDES_V4_TX_PI_QEC_CTRL			0x104
+#define QSERDES_V4_TX_PRE_EMPH				0x108
+#define QSERDES_V4_TX_SW_RESET				0x10c
+#define QSERDES_V4_TX_DCC_OFFSET			0x110
+#define QSERDES_V4_TX_DIG_BKUP_CTRL			0x114
+#define QSERDES_V4_TX_DEBUG_BUS0			0x118
+#define QSERDES_V4_TX_DEBUG_BUS1			0x11c
+#define QSERDES_V4_TX_DEBUG_BUS2			0x120
+#define QSERDES_V4_TX_DEBUG_BUS3			0x124
+#define QSERDES_V4_TX_READ_EQCODE			0x128
+#define QSERDES_V4_TX_READ_OFFSETCODE			0x12c
+#define QSERDES_V4_TX_IA_ERROR_COUNTER_LOW		0x130
+#define QSERDES_V4_TX_IA_ERROR_COUNTER_HIGH		0x134
+#define QSERDES_V4_TX_VGA_READ_CODE			0x138
+#define QSERDES_V4_TX_VTH_READ_CODE			0x13c
+#define QSERDES_V4_TX_DFE_TAP1_READ_CODE		0x140
+#define QSERDES_V4_TX_DFE_TAP2_READ_CODE		0x144
+#define QSERDES_V4_TX_IDAC_STATUS_I			0x148
+#define QSERDES_V4_TX_IDAC_STATUS_IBAR			0x14c
+#define QSERDES_V4_TX_IDAC_STATUS_Q			0x150
+#define QSERDES_V4_TX_IDAC_STATUS_QBAR			0x154
+#define QSERDES_V4_TX_IDAC_STATUS_A			0x158
+#define QSERDES_V4_TX_IDAC_STATUS_ABAR			0x15c
+#define QSERDES_V4_TX_IDAC_STATUS_SM_ON			0x160
+#define QSERDES_V4_TX_IDAC_STATUS_CAL_DONE		0x164
+#define QSERDES_V4_TX_IDAC_STATUS_SIGNERROR		0x168
+#define QSERDES_V4_TX_DCC_CAL_STATUS			0x16c
+
+/* Only for QMP V4 PHY - RX registers */
+#define QSERDES_V4_RX_UCDR_FO_GAIN_HALF			0x000
+#define QSERDES_V4_RX_UCDR_FO_GAIN_QUARTER		0x004
+#define QSERDES_V4_RX_UCDR_FO_GAIN			0x008
+#define QSERDES_V4_RX_UCDR_SO_GAIN_HALF			0x00c
+#define QSERDES_V4_RX_UCDR_SO_GAIN_QUARTER		0x010
+#define QSERDES_V4_RX_UCDR_SO_GAIN			0x014
+#define QSERDES_V4_RX_UCDR_SVS_FO_GAIN_HALF		0x018
+#define QSERDES_V4_RX_UCDR_SVS_FO_GAIN_QUARTER		0x01c
+#define QSERDES_V4_RX_UCDR_SVS_FO_GAIN			0x020
+#define QSERDES_V4_RX_UCDR_SVS_SO_GAIN_HALF		0x024
+#define QSERDES_V4_RX_UCDR_SVS_SO_GAIN_QUARTER		0x028
+#define QSERDES_V4_RX_UCDR_SVS_SO_GAIN			0x02c
+#define QSERDES_V4_RX_UCDR_FASTLOCK_FO_GAIN		0x030
+#define QSERDES_V4_RX_UCDR_SO_SATURATION_AND_ENABLE	0x034
+#define QSERDES_V4_RX_UCDR_FO_TO_SO_DELAY		0x038
+#define QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_LOW		0x03c
+#define QSERDES_V4_RX_UCDR_FASTLOCK_COUNT_HIGH		0x040
+#define QSERDES_V4_RX_UCDR_PI_CONTROLS			0x044
+#define QSERDES_V4_RX_UCDR_PI_CTRL2			0x048
+#define QSERDES_V4_RX_UCDR_SB2_THRESH1			0x04c
+#define QSERDES_V4_RX_UCDR_SB2_THRESH2			0x050
+#define QSERDES_V4_RX_UCDR_SB2_GAIN1			0x054
+#define QSERDES_V4_RX_UCDR_SB2_GAIN2			0x058
+#define QSERDES_V4_RX_AUX_CONTROL			0x05c
+#define QSERDES_V4_RX_AUX_DATA_TCOARSE_TFINE		0x060
+#define QSERDES_V4_RX_RCLK_AUXDATA_SEL			0x064
+#define QSERDES_V4_RX_AC_JTAG_ENABLE			0x068
+#define QSERDES_V4_RX_AC_JTAG_INITP			0x06c
+#define QSERDES_V4_RX_AC_JTAG_INITN			0x070
+#define QSERDES_V4_RX_AC_JTAG_LVL			0x074
+#define QSERDES_V4_RX_AC_JTAG_MODE			0x078
+#define QSERDES_V4_RX_AC_JTAG_RESET			0x07c
+#define QSERDES_V4_RX_RX_TERM_BW			0x080
+#define QSERDES_V4_RX_RX_RCVR_IQ_EN			0x084
+#define QSERDES_V4_RX_RX_IDAC_I_DC_OFFSETS		0x088
+#define QSERDES_V4_RX_RX_IDAC_IBAR_DC_OFFSETS		0x08c
+#define QSERDES_V4_RX_RX_IDAC_Q_DC_OFFSETS		0x090
+#define QSERDES_V4_RX_RX_IDAC_QBAR_DC_OFFSETS		0x094
+#define QSERDES_V4_RX_RX_IDAC_A_DC_OFFSETS		0x098
+#define QSERDES_V4_RX_RX_IDAC_ABAR_DC_OFFSETS		0x09c
+#define QSERDES_V4_RX_RX_IDAC_EN			0x0a0
+#define QSERDES_V4_RX_RX_IDAC_ENABLES			0x0a4
+#define QSERDES_V4_RX_RX_IDAC_SIGN			0x0a8
+#define QSERDES_V4_RX_RX_HIGHZ_HIGHRATE			0x0ac
+#define QSERDES_V4_RX_RX_TERM_AC_BYPASS_DC_COUPLE_OFFSET 0x0b0
+#define QSERDES_V4_RX_DFE_1				0x0b4
+#define QSERDES_V4_RX_DFE_2				0x0b8
+#define QSERDES_V4_RX_DFE_3				0x0bc
+#define QSERDES_V4_RX_DFE_4				0x0c0
+#define QSERDES_V4_RX_TX_ADAPT_PRE_THRESH1		0x0c4
+#define QSERDES_V4_RX_TX_ADAPT_PRE_THRESH2		0x0c8
+#define QSERDES_V4_RX_TX_ADAPT_POST_THRESH		0x0cc
+#define QSERDES_V4_RX_TX_ADAPT_MAIN_THRESH		0x0d0
+#define QSERDES_V4_RX_VGA_CAL_CNTRL1			0x0d4
+#define QSERDES_V4_RX_VGA_CAL_CNTRL2			0x0d8
+#define QSERDES_V4_RX_GM_CAL				0x0dc
+#define QSERDES_V4_RX_RX_VGA_GAIN2_LSB			0x0e0
+#define QSERDES_V4_RX_RX_VGA_GAIN2_MSB			0x0e4
+#define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL1		0x0e8
+#define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL2		0x0ec
+#define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL3		0x0f0
+#define QSERDES_V4_RX_RX_EQU_ADAPTOR_CNTRL4		0x0f4
+#define QSERDES_V4_RX_RX_IDAC_TSETTLE_LOW		0x0f8
+#define QSERDES_V4_RX_RX_IDAC_TSETTLE_HIGH		0x0fc
+#define QSERDES_V4_RX_RX_IDAC_MEASURE_TIME		0x100
+#define QSERDES_V4_RX_RX_IDAC_ACCUMULATOR		0x104
+#define QSERDES_V4_RX_RX_EQ_OFFSET_LSB			0x108
+#define QSERDES_V4_RX_RX_EQ_OFFSET_MSB			0x10c
+#define QSERDES_V4_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1	0x110
+#define QSERDES_V4_RX_RX_OFFSET_ADAPTOR_CNTRL2		0x114
+#define QSERDES_V4_RX_SIGDET_ENABLES			0x118
+#define QSERDES_V4_RX_SIGDET_CNTRL			0x11c
+#define QSERDES_V4_RX_SIGDET_LVL			0x120
+#define QSERDES_V4_RX_SIGDET_DEGLITCH_CNTRL		0x124
+#define QSERDES_V4_RX_RX_BAND				0x128
+#define QSERDES_V4_RX_CDR_FREEZE_UP_DN			0x12c
+#define QSERDES_V4_RX_CDR_RESET_OVERRIDE		0x130
+#define QSERDES_V4_RX_RX_INTERFACE_MODE			0x134
+#define QSERDES_V4_RX_JITTER_GEN_MODE			0x138
+#define QSERDES_V4_RX_SJ_AMP1				0x13c
+#define QSERDES_V4_RX_SJ_AMP2				0x140
+#define QSERDES_V4_RX_SJ_PER1				0x144
+#define QSERDES_V4_RX_SJ_PER2				0x148
+#define QSERDES_V4_RX_PPM_OFFSET1			0x14c
+#define QSERDES_V4_RX_PPM_OFFSET2			0x150
+#define QSERDES_V4_RX_SIGN_PPM_PERIOD1			0x154
+#define QSERDES_V4_RX_SIGN_PPM_PERIOD2			0x158
+#define QSERDES_V4_RX_RX_PWM_ENABLE_AND_DATA		0x15c
+#define QSERDES_V4_RX_RX_PWM_GEAR1_TIMEOUT_COUNT	0x160
+#define QSERDES_V4_RX_RX_PWM_GEAR2_TIMEOUT_COUNT	0x164
+#define QSERDES_V4_RX_RX_PWM_GEAR3_TIMEOUT_COUNT	0x168
+#define QSERDES_V4_RX_RX_PWM_GEAR4_TIMEOUT_COUNT	0x16c
+#define QSERDES_V4_RX_RX_MODE_00_LOW			0x170
+#define QSERDES_V4_RX_RX_MODE_00_HIGH			0x174
+#define QSERDES_V4_RX_RX_MODE_00_HIGH2			0x178
+#define QSERDES_V4_RX_RX_MODE_00_HIGH3			0x17c
+#define QSERDES_V4_RX_RX_MODE_00_HIGH4			0x180
+#define QSERDES_V4_RX_RX_MODE_01_LOW			0x184
+#define QSERDES_V4_RX_RX_MODE_01_HIGH			0x188
+#define QSERDES_V4_RX_RX_MODE_01_HIGH2			0x18c
+#define QSERDES_V4_RX_RX_MODE_01_HIGH3			0x190
+#define QSERDES_V4_RX_RX_MODE_01_HIGH4			0x194
+#define QSERDES_V4_RX_RX_MODE_10_LOW			0x198
+#define QSERDES_V4_RX_RX_MODE_10_HIGH			0x19c
+#define QSERDES_V4_RX_RX_MODE_10_HIGH2			0x1a0
+#define QSERDES_V4_RX_RX_MODE_10_HIGH3			0x1a4
+#define QSERDES_V4_RX_RX_MODE_10_HIGH4			0x1a8
+#define QSERDES_V4_RX_PHPRE_CTRL			0x1ac
+#define QSERDES_V4_RX_PHPRE_INITVAL			0x1b0
+#define QSERDES_V4_RX_DFE_EN_TIMER			0x1b4
+#define QSERDES_V4_RX_DFE_CTLE_POST_CAL_OFFSET		0x1b8
+#define QSERDES_V4_RX_DCC_CTRL1				0x1bc
+#define QSERDES_V4_RX_DCC_CTRL2				0x1c0
+#define QSERDES_V4_RX_VTH_CODE				0x1c4
+#define QSERDES_V4_RX_VTH_MIN_THRESH			0x1c8
+#define QSERDES_V4_RX_VTH_MAX_THRESH			0x1cc
+#define QSERDES_V4_RX_ALOG_OBSV_BUS_CTRL_1		0x1d0
+#define QSERDES_V4_RX_PI_CTRL1				0x1d4
+#define QSERDES_V4_RX_PI_CTRL2				0x1d8
+#define QSERDES_V4_RX_PI_QUAD				0x1dc
+#define QSERDES_V4_RX_IDATA1				0x1e0
+#define QSERDES_V4_RX_IDATA2				0x1e4
+#define QSERDES_V4_RX_AUX_DATA1				0x1e8
+#define QSERDES_V4_RX_AUX_DATA2				0x1ec
+#define QSERDES_V4_RX_AC_JTAG_OUTP			0x1f0
+#define QSERDES_V4_RX_AC_JTAG_OUTN			0x1f4
+#define QSERDES_V4_RX_RX_SIGDET				0x1f8
+#define QSERDES_V4_RX_ALOG_OBSV_BUS_STATUS_1		0x1fc
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx.h
new file mode 100644
index 00000000000..d20694513eb
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx.h
@@ -0,0 +1,205 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_H_
+
+/* Only for QMP V2 PHY - TX registers */
+#define QSERDES_TX_BIST_MODE_LANENO			0x000
+#define QSERDES_TX_BIST_INVERT				0x004
+#define QSERDES_TX_CLKBUF_ENABLE			0x008
+#define QSERDES_TX_CMN_CONTROL_ONE			0x00c
+#define QSERDES_TX_CMN_CONTROL_TWO			0x010
+#define QSERDES_TX_CMN_CONTROL_THREE			0x014
+#define QSERDES_TX_TX_EMP_POST1_LVL			0x018
+#define QSERDES_TX_TX_POST2_EMPH			0x01c
+#define QSERDES_TX_TX_BOOST_LVL_UP_DN			0x020
+#define QSERDES_TX_HP_PD_ENABLES			0x024
+#define QSERDES_TX_TX_IDLE_LVL_LARGE_AMP		0x028
+#define QSERDES_TX_TX_DRV_LVL				0x02c
+#define QSERDES_TX_TX_DRV_LVL_OFFSET			0x030
+#define QSERDES_TX_RESET_TSYNC_EN			0x034
+#define QSERDES_TX_PRE_STALL_LDO_BOOST_EN		0x038
+#define QSERDES_TX_TX_BAND				0x03c
+#define QSERDES_TX_SLEW_CNTL				0x040
+#define QSERDES_TX_INTERFACE_SELECT			0x044
+#define QSERDES_TX_LPB_EN				0x048
+#define QSERDES_TX_RES_CODE_LANE_TX			0x04c
+#define QSERDES_TX_RES_CODE_LANE_RX			0x050
+#define QSERDES_TX_RES_CODE_LANE_OFFSET			0x054
+#define QSERDES_TX_PERL_LENGTH1				0x058
+#define QSERDES_TX_PERL_LENGTH2				0x05c
+#define QSERDES_TX_SERDES_BYP_EN_OUT			0x060
+#define QSERDES_TX_DEBUG_BUS_SEL			0x064
+#define QSERDES_TX_HIGHZ_TRANSCEIVEREN_BIAS_DRVR_EN	0x068
+#define QSERDES_TX_TX_POL_INV				0x06c
+#define QSERDES_TX_PARRATE_REC_DETECT_IDLE_EN		0x070
+#define QSERDES_TX_BIST_PATTERN1			0x074
+#define QSERDES_TX_BIST_PATTERN2			0x078
+#define QSERDES_TX_BIST_PATTERN3			0x07c
+#define QSERDES_TX_BIST_PATTERN4			0x080
+#define QSERDES_TX_BIST_PATTERN5			0x084
+#define QSERDES_TX_BIST_PATTERN6			0x088
+#define QSERDES_TX_BIST_PATTERN7			0x08c
+#define QSERDES_TX_BIST_PATTERN8			0x090
+#define QSERDES_TX_LANE_MODE				0x094
+#define QSERDES_TX_IDAC_CAL_LANE_MODE			0x098
+#define QSERDES_TX_IDAC_CAL_LANE_MODE_CONFIGURATION	0x09c
+#define QSERDES_TX_ATB_SEL1				0x0a0
+#define QSERDES_TX_ATB_SEL2				0x0a4
+#define QSERDES_TX_RCV_DETECT_LVL			0x0a8
+#define QSERDES_TX_RCV_DETECT_LVL_2			0x0ac
+#define QSERDES_TX_PRBS_SEED1				0x0b0
+#define QSERDES_TX_PRBS_SEED2				0x0b4
+#define QSERDES_TX_PRBS_SEED3				0x0b8
+#define QSERDES_TX_PRBS_SEED4				0x0bc
+#define QSERDES_TX_RESET_GEN				0x0c0
+#define QSERDES_TX_RESET_GEN_MUXES			0x0c4
+#define QSERDES_TX_TRAN_DRVR_EMP_EN			0x0c8
+#define QSERDES_TX_TX_INTERFACE_MODE			0x0cc
+#define QSERDES_TX_PWM_CTRL				0x0d0
+#define QSERDES_TX_PWM_ENCODED_OR_DATA			0x0d4
+#define QSERDES_TX_PWM_GEAR_1_DIVIDER_BAND2		0x0d8
+#define QSERDES_TX_PWM_GEAR_2_DIVIDER_BAND2		0x0dc
+#define QSERDES_TX_PWM_GEAR_3_DIVIDER_BAND2		0x0e0
+#define QSERDES_TX_PWM_GEAR_4_DIVIDER_BAND2		0x0e4
+#define QSERDES_TX_PWM_GEAR_1_DIVIDER_BAND0_1		0x0e8
+#define QSERDES_TX_PWM_GEAR_2_DIVIDER_BAND0_1		0x0ec
+#define QSERDES_TX_PWM_GEAR_3_DIVIDER_BAND0_1		0x0f0
+#define QSERDES_TX_PWM_GEAR_4_DIVIDER_BAND0_1		0x0f4
+#define QSERDES_TX_VMODE_CTRL1				0x0f8
+#define QSERDES_TX_VMODE_CTRL2				0x0fc
+#define QSERDES_TX_TX_ALOG_INTF_OBSV_CNTL		0x100
+#define QSERDES_TX_BIST_STATUS				0x104
+#define QSERDES_TX_BIST_ERROR_COUNT1			0x108
+#define QSERDES_TX_BIST_ERROR_COUNT2			0x10c
+#define QSERDES_TX_TX_ALOG_INTF_OBSV			0x110
+
+/* Only for QMP V2 PHY - RX registers */
+#define QSERDES_RX_UCDR_FO_GAIN_HALF			0x000
+#define QSERDES_RX_UCDR_FO_GAIN_QUARTER			0x004
+#define QSERDES_RX_UCDR_FO_GAIN_EIGHTH			0x008
+#define QSERDES_RX_UCDR_FO_GAIN				0x00c
+#define QSERDES_RX_UCDR_SO_GAIN_HALF			0x010
+#define QSERDES_RX_UCDR_SO_GAIN_QUARTER			0x014
+#define QSERDES_RX_UCDR_SO_GAIN_EIGHTH			0x018
+#define QSERDES_RX_UCDR_SO_GAIN				0x01c
+#define QSERDES_RX_UCDR_SVS_FO_GAIN_HALF		0x020
+#define QSERDES_RX_UCDR_SVS_FO_GAIN_QUARTER		0x024
+#define QSERDES_RX_UCDR_SVS_FO_GAIN_EIGHTH		0x028
+#define QSERDES_RX_UCDR_SVS_FO_GAIN			0x02c
+#define QSERDES_RX_UCDR_SVS_SO_GAIN_HALF		0x030
+#define QSERDES_RX_UCDR_SVS_SO_GAIN_QUARTER		0x034
+#define QSERDES_RX_UCDR_SVS_SO_GAIN_EIGHTH		0x038
+#define QSERDES_RX_UCDR_SVS_SO_GAIN			0x03c
+#define QSERDES_RX_UCDR_FASTLOCK_FO_GAIN		0x040
+#define QSERDES_RX_UCDR_FD_GAIN				0x044
+#define QSERDES_RX_UCDR_SO_SATURATION_AND_ENABLE	0x048
+#define QSERDES_RX_UCDR_FO_TO_SO_DELAY			0x04c
+#define QSERDES_RX_UCDR_FASTLOCK_COUNT_LOW		0x050
+#define QSERDES_RX_UCDR_FASTLOCK_COUNT_HIGH		0x054
+#define QSERDES_RX_UCDR_MODULATE			0x058
+#define QSERDES_RX_UCDR_PI_CONTROLS			0x05c
+#define QSERDES_RX_RBIST_CONTROL			0x060
+#define QSERDES_RX_AUX_CONTROL				0x064
+#define QSERDES_RX_AUX_DATA_TCOARSE			0x068
+#define QSERDES_RX_AUX_DATA_TFINE_LSB			0x06c
+#define QSERDES_RX_AUX_DATA_TFINE_MSB			0x070
+#define QSERDES_RX_RCLK_AUXDATA_SEL			0x074
+#define QSERDES_RX_AC_JTAG_ENABLE			0x078
+#define QSERDES_RX_AC_JTAG_INITP			0x07c
+#define QSERDES_RX_AC_JTAG_INITN			0x080
+#define QSERDES_RX_AC_JTAG_LVL				0x084
+#define QSERDES_RX_AC_JTAG_MODE				0x088
+#define QSERDES_RX_AC_JTAG_RESET			0x08c
+#define QSERDES_RX_RX_TERM_BW				0x090
+#define QSERDES_RX_RX_RCVR_IQ_EN			0x094
+#define QSERDES_RX_RX_IDAC_I_DC_OFFSETS			0x098
+#define QSERDES_RX_RX_IDAC_IBAR_DC_OFFSETS		0x09c
+#define QSERDES_RX_RX_IDAC_Q_DC_OFFSETS			0x0a0
+#define QSERDES_RX_RX_IDAC_QBAR_DC_OFFSETS		0x0a4
+#define QSERDES_RX_RX_IDAC_A_DC_OFFSETS			0x0a8
+#define QSERDES_RX_RX_IDAC_ABAR_DC_OFFSETS		0x0ac
+#define QSERDES_RX_RX_IDAC_EN				0x0b0
+#define QSERDES_RX_RX_IDAC_ENABLES			0x0b4
+#define QSERDES_RX_RX_IDAC_SIGN				0x0b8
+#define QSERDES_RX_RX_HIGHZ_HIGHRATE			0x0bc
+#define QSERDES_RX_RX_TERM_AC_BYPASS_DC_COUPLE_OFFSET	0x0c0
+#define QSERDES_RX_RX_EQ_GAIN1_LSB			0x0c4
+#define QSERDES_RX_RX_EQ_GAIN1_MSB			0x0c8
+#define QSERDES_RX_RX_EQ_GAIN2_LSB			0x0cc
+#define QSERDES_RX_RX_EQ_GAIN2_MSB			0x0d0
+#define QSERDES_RX_RX_EQU_ADAPTOR_CNTRL1		0x0d4
+#define QSERDES_RX_RX_EQU_ADAPTOR_CNTRL2		0x0d8
+#define QSERDES_RX_RX_EQU_ADAPTOR_CNTRL3		0x0dc
+#define QSERDES_RX_RX_EQU_ADAPTOR_CNTRL4		0x0e0
+#define QSERDES_RX_RX_IDAC_CAL_CONFIGURATION		0x0e4
+#define QSERDES_RX_RX_IDAC_TSETTLE_LOW			0x0e8
+#define QSERDES_RX_RX_IDAC_TSETTLE_HIGH			0x0ec
+#define QSERDES_RX_RX_IDAC_ENDSAMP_LOW			0x0f0
+#define QSERDES_RX_RX_IDAC_ENDSAMP_HIGH			0x0f4
+#define QSERDES_RX_RX_IDAC_MIDPOINT_LOW			0x0f8
+#define QSERDES_RX_RX_IDAC_MIDPOINT_HIGH		0x0fc
+#define QSERDES_RX_RX_EQ_OFFSET_LSB			0x100
+#define QSERDES_RX_RX_EQ_OFFSET_MSB			0x104
+#define QSERDES_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1		0x108
+#define QSERDES_RX_RX_OFFSET_ADAPTOR_CNTRL2		0x10c
+#define QSERDES_RX_SIGDET_ENABLES			0x110
+#define QSERDES_RX_SIGDET_CNTRL				0x114
+#define QSERDES_RX_SIGDET_LVL				0x118
+#define QSERDES_RX_SIGDET_DEGLITCH_CNTRL		0x11c
+#define QSERDES_RX_RX_BAND				0x120
+#define QSERDES_RX_CDR_FREEZE_UP_DN			0x124
+#define QSERDES_RX_CDR_RESET_OVERRIDE			0x128
+#define QSERDES_RX_RX_INTERFACE_MODE			0x12c
+#define QSERDES_RX_JITTER_GEN_MODE			0x130
+#define QSERDES_RX_BUJ_AMP				0x134
+#define QSERDES_RX_SJ_AMP1				0x138
+#define QSERDES_RX_SJ_AMP2				0x13c
+#define QSERDES_RX_SJ_PER1				0x140
+#define QSERDES_RX_SJ_PER2				0x144
+#define QSERDES_RX_BUJ_STEP_FREQ1			0x148
+#define QSERDES_RX_BUJ_STEP_FREQ2			0x14c
+#define QSERDES_RX_PPM_OFFSET1				0x150
+#define QSERDES_RX_PPM_OFFSET2				0x154
+#define QSERDES_RX_SIGN_PPM_PERIOD1			0x158
+#define QSERDES_RX_SIGN_PPM_PERIOD2			0x15c
+#define QSERDES_RX_SSC_CTRL				0x160
+#define QSERDES_RX_SSC_COUNT1				0x164
+#define QSERDES_RX_SSC_COUNT2				0x168
+#define QSERDES_RX_RX_ALOG_INTF_OBSV_CNTL		0x16c
+#define QSERDES_RX_RX_PWM_ENABLE_AND_DATA		0x170
+#define QSERDES_RX_RX_PWM_GEAR1_TIMEOUT_COUNT		0x174
+#define QSERDES_RX_RX_PWM_GEAR2_TIMEOUT_COUNT		0x178
+#define QSERDES_RX_RX_PWM_GEAR3_TIMEOUT_COUNT		0x17c
+#define QSERDES_RX_RX_PWM_GEAR4_TIMEOUT_COUNT		0x180
+#define QSERDES_RX_PI_CTRL1				0x184
+#define QSERDES_RX_PI_CTRL2				0x188
+#define QSERDES_RX_PI_QUAD				0x18c
+#define QSERDES_RX_IDATA1				0x190
+#define QSERDES_RX_IDATA2				0x194
+#define QSERDES_RX_AUX_DATA1				0x198
+#define QSERDES_RX_AUX_DATA2				0x19c
+#define QSERDES_RX_AC_JTAG_OUTP				0x1a0
+#define QSERDES_RX_AC_JTAG_OUTN				0x1a4
+#define QSERDES_RX_RX_SIGDET				0x1a8
+#define QSERDES_RX_RX_VDCOFF				0x1ac
+#define QSERDES_RX_IDAC_CAL_ON				0x1b0
+#define QSERDES_RX_IDAC_STATUS_I			0x1b4
+#define QSERDES_RX_IDAC_STATUS_IBAR			0x1b8
+#define QSERDES_RX_IDAC_STATUS_Q			0x1bc
+#define QSERDES_RX_IDAC_STATUS_QBAR			0x1c0
+#define QSERDES_RX_IDAC_STATUS_A			0x1c4
+#define QSERDES_RX_IDAC_STATUS_ABAR			0x1c8
+#define QSERDES_RX_CALST_STATUS_I			0x1cc
+#define QSERDES_RX_CALST_STATUS_Q			0x1d0
+#define QSERDES_RX_CALST_STATUS_A			0x1d4
+#define QSERDES_RX_RX_ALOG_INTF_OBSV			0x1d8
+#define QSERDES_RX_READ_EQCODE				0x1dc
+#define QSERDES_RX_READ_OFFSETCODE			0x1e0
+#define QSERDES_RX_IA_ERROR_COUNTER_LOW			0x1e4
+#define QSERDES_RX_IA_ERROR_COUNTER_HIGH		0x1e8
+
+#endif

-- 
2.34.1

