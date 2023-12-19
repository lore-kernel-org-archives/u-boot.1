Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C335C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0B76878BF;
	Tue, 19 Dec 2023 17:05:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L0y1YmVh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CCF08779D; Tue, 19 Dec 2023 17:05:03 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D70DF8779D
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c6a71e88cso59589635e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001882; x=1703606682; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kkcn0Bjy5EN+Yv43eLR0uyvY7gPgJHNz2H4BCYNKqo4=;
 b=L0y1YmVh6UcTvziQ8mgm1NSOUFe8NXN4jsUD6DcmkBukOaBsCzMUqiGjbQQq+/BMSm
 pgO9GQybCxBn1dh+m4boPJ1OUbwl4zIAfgitKOCU5whK9Sl6RxIJAklJXDz3w/jiBw/0
 xtRC5hdwZl98BgsFY58erGJQtu7c8rK7RRb2hJvcZRAIND2SHabjnhCTfMhUmz7P/eJW
 h0eH76VyMfJoL9tzjUQzk48CWI1vs68dGOnbvo1S9jomVdIRIgif3H4Qo+xK41iVR/ac
 Ar2VSVoNU5G5o46/2QBiIgLq1VEIWzwOBN5PkAXpghtgK1hxXNEvDRXg+AyIdWijN16b
 EZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001882; x=1703606682;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kkcn0Bjy5EN+Yv43eLR0uyvY7gPgJHNz2H4BCYNKqo4=;
 b=nshRbmaM08prjUFL83NBRmLD+t4xQD/+v+PPHkAaPn5ftCu0lqvOEs/5qoRHZXEBlf
 kvZCPlVbxj1fnu/ktxQ8OuuRUf7EBA9wu1eoQFZB7Z4ab5qOgQF/eIYjJlMVXs+ACU44
 xb3WLC2FFEnxjqoCqzx3gaPJX3CxTS7zLSm7p++WoSYPHnaPQVoZ2uUaLzAQUv/AKzdP
 QPVEvB+SXmn6BBE1vtXuMlMBFo/3d+ISbk1rke8Q/18DdeeaGUErNqfx8Ofdy0/BKCTZ
 0+v1Jq4oxK4ZOCJJuldpGZshg6GAFA5/ZXhkLEv455t0HSOKcELY+3JHw99kfPdWFCN4
 cedg==
X-Gm-Message-State: AOJu0YwqXsurvTKqJmBEIuIMxSQRWoU+VtTKUqA9pM+cwCQPI21I1K2F
 gsa3Xr+Uaq3R5ejLBHSpLDbwyg==
X-Google-Smtp-Source: AGHT+IH1IkPjHPqOQsQIDcBIliEzm6yJSlyEKPg2VQ8WtNJcIFSG7ba+k+w7hmrLC6hciq+aukANfw==
X-Received: by 2002:a05:600c:3107:b0:40b:5e21:dd26 with SMTP id
 g7-20020a05600c310700b0040b5e21dd26mr10089646wmo.84.1703001882011; 
 Tue, 19 Dec 2023 08:04:42 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:41 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:20 +0000
Subject: [PATCH v2 19/32] dt-bindings: import headers for SDM845
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-19-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=64467;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=GSjeHsZx9y3XAa9WO5E8K7r0jBwwmmFSortexaoZJOE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/cw3Xpx6eGjz0QO3Xh68c+CN48HvpyerdTcvXrPgX
 KMBx46FVztKWRgEORhkxRRZxE8ss2xae9leY/uCCzBzWJlAhjBwcQrARPp8GP6Xpwpw7sk8f2Ph
 5MyaOSYHzTuWxT5q5M/7fDYwkWe5hX4Yw/+4zGz7678Fv4p+PO3EpdDtZX06VI91b5qiXhubJv/
 NAysB
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

Import the DT bindings headers that are used by SDM845 from Linux 6.7-rc3

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/dt-bindings/clock/qcom,camcc-sdm845.h      | 116 ++++++
 include/dt-bindings/clock/qcom,dispcc-sdm845.h     |  56 +++
 include/dt-bindings/clock/qcom,gpucc-sdm845.h      |  24 ++
 include/dt-bindings/clock/qcom,lpass-sdm845.h      |  15 +
 include/dt-bindings/clock/qcom,rpmh.h              |  37 ++
 include/dt-bindings/clock/qcom,videocc-sdm845.h    |  35 ++
 include/dt-bindings/dma/qcom-gpi.h                 |  11 +
 include/dt-bindings/firmware/qcom,scm.h            |  18 +
 include/dt-bindings/iio/qcom,spmi-vadc.h           | 300 +++++++++++++++
 include/dt-bindings/interconnect/qcom,osm-l3.h     |  15 +
 include/dt-bindings/interconnect/qcom,sdm845.h     | 150 ++++++++
 include/dt-bindings/phy/phy-qcom-qmp.h             |  20 +
 include/dt-bindings/phy/phy-qcom-qusb2.h           |  37 ++
 include/dt-bindings/pinctrl/qcom,pmic-gpio.h       | 164 ++++++++
 include/dt-bindings/power/qcom-rpmpd.h             | 412 +++++++++++++++++++++
 include/dt-bindings/qcom,q6asm.h                   |  26 ++
 .../dt-bindings/regulator/qcom,rpmh-regulator.h    |  36 ++
 include/dt-bindings/reset/qcom,sdm845-aoss.h       |  17 +
 include/dt-bindings/reset/qcom,sdm845-pdc.h        |  22 ++
 include/dt-bindings/soc/qcom,apr.h                 |  28 ++
 include/dt-bindings/soc/qcom,rpmh-rsc.h            |  14 +
 include/dt-bindings/sound/qcom,q6afe.h             |   9 +
 include/dt-bindings/sound/qcom,q6asm.h             |  26 ++
 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h | 234 ++++++++++++
 24 files changed, 1822 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,camcc-sdm845.h b/include/dt-bindings/clock/qcom,camcc-sdm845.h
new file mode 100644
index 000000000000..4f7a2d2320bf
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,camcc-sdm845.h
@@ -0,0 +1,116 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_CAM_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_CAM_CC_SDM845_H
+
+/* CAM_CC clock registers */
+#define CAM_CC_BPS_AHB_CLK				0
+#define CAM_CC_BPS_AREG_CLK				1
+#define CAM_CC_BPS_AXI_CLK				2
+#define CAM_CC_BPS_CLK					3
+#define CAM_CC_BPS_CLK_SRC				4
+#define CAM_CC_CAMNOC_ATB_CLK				5
+#define CAM_CC_CAMNOC_AXI_CLK				6
+#define CAM_CC_CCI_CLK					7
+#define CAM_CC_CCI_CLK_SRC				8
+#define CAM_CC_CPAS_AHB_CLK				9
+#define CAM_CC_CPHY_RX_CLK_SRC				10
+#define CAM_CC_CSI0PHYTIMER_CLK				11
+#define CAM_CC_CSI0PHYTIMER_CLK_SRC			12
+#define CAM_CC_CSI1PHYTIMER_CLK				13
+#define CAM_CC_CSI1PHYTIMER_CLK_SRC			14
+#define CAM_CC_CSI2PHYTIMER_CLK				15
+#define CAM_CC_CSI2PHYTIMER_CLK_SRC			16
+#define CAM_CC_CSI3PHYTIMER_CLK				17
+#define CAM_CC_CSI3PHYTIMER_CLK_SRC			18
+#define CAM_CC_CSIPHY0_CLK				19
+#define CAM_CC_CSIPHY1_CLK				20
+#define CAM_CC_CSIPHY2_CLK				21
+#define CAM_CC_CSIPHY3_CLK				22
+#define CAM_CC_FAST_AHB_CLK_SRC				23
+#define CAM_CC_FD_CORE_CLK				24
+#define CAM_CC_FD_CORE_CLK_SRC				25
+#define CAM_CC_FD_CORE_UAR_CLK				26
+#define CAM_CC_ICP_APB_CLK				27
+#define CAM_CC_ICP_ATB_CLK				28
+#define CAM_CC_ICP_CLK					29
+#define CAM_CC_ICP_CLK_SRC				30
+#define CAM_CC_ICP_CTI_CLK				31
+#define CAM_CC_ICP_TS_CLK				32
+#define CAM_CC_IFE_0_AXI_CLK				33
+#define CAM_CC_IFE_0_CLK				34
+#define CAM_CC_IFE_0_CLK_SRC				35
+#define CAM_CC_IFE_0_CPHY_RX_CLK			36
+#define CAM_CC_IFE_0_CSID_CLK				37
+#define CAM_CC_IFE_0_CSID_CLK_SRC			38
+#define CAM_CC_IFE_0_DSP_CLK				39
+#define CAM_CC_IFE_1_AXI_CLK				40
+#define CAM_CC_IFE_1_CLK				41
+#define CAM_CC_IFE_1_CLK_SRC				42
+#define CAM_CC_IFE_1_CPHY_RX_CLK			43
+#define CAM_CC_IFE_1_CSID_CLK				44
+#define CAM_CC_IFE_1_CSID_CLK_SRC			45
+#define CAM_CC_IFE_1_DSP_CLK				46
+#define CAM_CC_IFE_LITE_CLK				47
+#define CAM_CC_IFE_LITE_CLK_SRC				48
+#define CAM_CC_IFE_LITE_CPHY_RX_CLK			49
+#define CAM_CC_IFE_LITE_CSID_CLK			50
+#define CAM_CC_IFE_LITE_CSID_CLK_SRC			51
+#define CAM_CC_IPE_0_AHB_CLK				52
+#define CAM_CC_IPE_0_AREG_CLK				53
+#define CAM_CC_IPE_0_AXI_CLK				54
+#define CAM_CC_IPE_0_CLK				55
+#define CAM_CC_IPE_0_CLK_SRC				56
+#define CAM_CC_IPE_1_AHB_CLK				57
+#define CAM_CC_IPE_1_AREG_CLK				58
+#define CAM_CC_IPE_1_AXI_CLK				59
+#define CAM_CC_IPE_1_CLK				60
+#define CAM_CC_IPE_1_CLK_SRC				61
+#define CAM_CC_JPEG_CLK					62
+#define CAM_CC_JPEG_CLK_SRC				63
+#define CAM_CC_LRME_CLK					64
+#define CAM_CC_LRME_CLK_SRC				65
+#define CAM_CC_MCLK0_CLK				66
+#define CAM_CC_MCLK0_CLK_SRC				67
+#define CAM_CC_MCLK1_CLK				68
+#define CAM_CC_MCLK1_CLK_SRC				69
+#define CAM_CC_MCLK2_CLK				70
+#define CAM_CC_MCLK2_CLK_SRC				71
+#define CAM_CC_MCLK3_CLK				72
+#define CAM_CC_MCLK3_CLK_SRC				73
+#define CAM_CC_PLL0					74
+#define CAM_CC_PLL0_OUT_EVEN				75
+#define CAM_CC_PLL1					76
+#define CAM_CC_PLL1_OUT_EVEN				77
+#define CAM_CC_PLL2					78
+#define CAM_CC_PLL2_OUT_EVEN				79
+#define CAM_CC_PLL3					80
+#define CAM_CC_PLL3_OUT_EVEN				81
+#define CAM_CC_SLOW_AHB_CLK_SRC				82
+#define CAM_CC_SOC_AHB_CLK				83
+#define CAM_CC_SYS_TMR_CLK				84
+
+/* CAM_CC Resets */
+#define TITAN_CAM_CC_CCI_BCR				0
+#define TITAN_CAM_CC_CPAS_BCR				1
+#define TITAN_CAM_CC_CSI0PHY_BCR			2
+#define TITAN_CAM_CC_CSI1PHY_BCR			3
+#define TITAN_CAM_CC_CSI2PHY_BCR			4
+#define TITAN_CAM_CC_MCLK0_BCR				5
+#define TITAN_CAM_CC_MCLK1_BCR				6
+#define TITAN_CAM_CC_MCLK2_BCR				7
+#define TITAN_CAM_CC_MCLK3_BCR				8
+#define TITAN_CAM_CC_TITAN_TOP_BCR			9
+
+/* CAM_CC GDSCRs */
+#define BPS_GDSC					0
+#define IPE_0_GDSC					1
+#define IPE_1_GDSC					2
+#define IFE_0_GDSC					3
+#define IFE_1_GDSC					4
+#define TITAN_TOP_GDSC					5
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,dispcc-sdm845.h b/include/dt-bindings/clock/qcom,dispcc-sdm845.h
new file mode 100644
index 000000000000..4016fd1d5b46
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,dispcc-sdm845.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018-2019, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_DISP_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_DISP_CC_SDM845_H
+
+/* DISP_CC clock registers */
+#define DISP_CC_MDSS_AHB_CLK					0
+#define DISP_CC_MDSS_AXI_CLK					1
+#define DISP_CC_MDSS_BYTE0_CLK					2
+#define DISP_CC_MDSS_BYTE0_CLK_SRC				3
+#define DISP_CC_MDSS_BYTE0_INTF_CLK				4
+#define DISP_CC_MDSS_BYTE1_CLK					5
+#define DISP_CC_MDSS_BYTE1_CLK_SRC				6
+#define DISP_CC_MDSS_BYTE1_INTF_CLK				7
+#define DISP_CC_MDSS_ESC0_CLK					8
+#define DISP_CC_MDSS_ESC0_CLK_SRC				9
+#define DISP_CC_MDSS_ESC1_CLK					10
+#define DISP_CC_MDSS_ESC1_CLK_SRC				11
+#define DISP_CC_MDSS_MDP_CLK					12
+#define DISP_CC_MDSS_MDP_CLK_SRC				13
+#define DISP_CC_MDSS_MDP_LUT_CLK				14
+#define DISP_CC_MDSS_PCLK0_CLK					15
+#define DISP_CC_MDSS_PCLK0_CLK_SRC				16
+#define DISP_CC_MDSS_PCLK1_CLK					17
+#define DISP_CC_MDSS_PCLK1_CLK_SRC				18
+#define DISP_CC_MDSS_ROT_CLK					19
+#define DISP_CC_MDSS_ROT_CLK_SRC				20
+#define DISP_CC_MDSS_RSCC_AHB_CLK				21
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK				22
+#define DISP_CC_MDSS_VSYNC_CLK					23
+#define DISP_CC_MDSS_VSYNC_CLK_SRC				24
+#define DISP_CC_PLL0						25
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				26
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC				27
+#define DISP_CC_MDSS_DP_AUX_CLK					28
+#define DISP_CC_MDSS_DP_AUX_CLK_SRC				29
+#define DISP_CC_MDSS_DP_CRYPTO_CLK				30
+#define DISP_CC_MDSS_DP_CRYPTO_CLK_SRC				31
+#define DISP_CC_MDSS_DP_LINK_CLK				32
+#define DISP_CC_MDSS_DP_LINK_CLK_SRC				33
+#define DISP_CC_MDSS_DP_LINK_INTF_CLK				34
+#define DISP_CC_MDSS_DP_PIXEL1_CLK				35
+#define DISP_CC_MDSS_DP_PIXEL1_CLK_SRC				36
+#define DISP_CC_MDSS_DP_PIXEL_CLK				37
+#define DISP_CC_MDSS_DP_PIXEL_CLK_SRC				38
+
+/* DISP_CC Reset */
+#define DISP_CC_MDSS_RSCC_BCR					0
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC						0
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,gpucc-sdm845.h b/include/dt-bindings/clock/qcom,gpucc-sdm845.h
new file mode 100644
index 000000000000..9690d901b50a
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gpucc-sdm845.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_GPU_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_GPU_CC_SDM845_H
+
+/* GPU_CC clock registers */
+#define GPU_CC_CX_GMU_CLK			0
+#define GPU_CC_CXO_CLK				1
+#define GPU_CC_GMU_CLK_SRC			2
+#define GPU_CC_PLL1				3
+
+/* GPU_CC Resets */
+#define GPUCC_GPU_CC_CX_BCR			0
+#define GPUCC_GPU_CC_GMU_BCR			1
+#define GPUCC_GPU_CC_XO_BCR			2
+
+/* GPU_CC GDSCRs */
+#define GPU_CX_GDSC				0
+#define GPU_GX_GDSC				1
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,lpass-sdm845.h b/include/dt-bindings/clock/qcom,lpass-sdm845.h
new file mode 100644
index 000000000000..659050846f61
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,lpass-sdm845.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_LPASS_SDM845_H
+
+#define LPASS_Q6SS_AHBM_AON_CLK				0
+#define LPASS_Q6SS_AHBS_AON_CLK				1
+#define LPASS_QDSP6SS_XO_CLK				2
+#define LPASS_QDSP6SS_SLEEP_CLK				3
+#define LPASS_QDSP6SS_CORE_CLK				4
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,rpmh.h b/include/dt-bindings/clock/qcom,rpmh.h
new file mode 100644
index 000000000000..0a7d1be0d124
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,rpmh.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, 2020, The Linux Foundation. All rights reserved. */
+
+
+#ifndef _DT_BINDINGS_CLK_MSM_RPMH_H
+#define _DT_BINDINGS_CLK_MSM_RPMH_H
+
+/* RPMh controlled clocks */
+#define RPMH_CXO_CLK				0
+#define RPMH_CXO_CLK_A				1
+#define RPMH_LN_BB_CLK2				2
+#define RPMH_LN_BB_CLK2_A			3
+#define RPMH_LN_BB_CLK3				4
+#define RPMH_LN_BB_CLK3_A			5
+#define RPMH_RF_CLK1				6
+#define RPMH_RF_CLK1_A				7
+#define RPMH_RF_CLK2				8
+#define RPMH_RF_CLK2_A				9
+#define RPMH_RF_CLK3				10
+#define RPMH_RF_CLK3_A				11
+#define RPMH_IPA_CLK				12
+#define RPMH_LN_BB_CLK1				13
+#define RPMH_LN_BB_CLK1_A			14
+#define RPMH_CE_CLK				15
+#define RPMH_QPIC_CLK				16
+#define RPMH_DIV_CLK1				17
+#define RPMH_DIV_CLK1_A				18
+#define RPMH_RF_CLK4				19
+#define RPMH_RF_CLK4_A				20
+#define RPMH_RF_CLK5				21
+#define RPMH_RF_CLK5_A				22
+#define RPMH_PKA_CLK				23
+#define RPMH_HWKM_CLK				24
+#define RPMH_QLINK_CLK				25
+#define RPMH_QLINK_CLK_A			26
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,videocc-sdm845.h b/include/dt-bindings/clock/qcom,videocc-sdm845.h
new file mode 100644
index 000000000000..1b868165e8ce
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,videocc-sdm845.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_SDM_VIDEO_CC_SDM845_H
+#define _DT_BINDINGS_CLK_SDM_VIDEO_CC_SDM845_H
+
+/* VIDEO_CC clock registers */
+#define VIDEO_CC_APB_CLK		0
+#define VIDEO_CC_AT_CLK			1
+#define VIDEO_CC_QDSS_TRIG_CLK		2
+#define VIDEO_CC_QDSS_TSCTR_DIV8_CLK	3
+#define VIDEO_CC_VCODEC0_AXI_CLK	4
+#define VIDEO_CC_VCODEC0_CORE_CLK	5
+#define VIDEO_CC_VCODEC1_AXI_CLK	6
+#define VIDEO_CC_VCODEC1_CORE_CLK	7
+#define VIDEO_CC_VENUS_AHB_CLK		8
+#define VIDEO_CC_VENUS_CLK_SRC		9
+#define VIDEO_CC_VENUS_CTL_AXI_CLK	10
+#define VIDEO_CC_VENUS_CTL_CORE_CLK	11
+#define VIDEO_PLL0			12
+
+/* VIDEO_CC Resets */
+#define VIDEO_CC_VENUS_BCR		0
+#define VIDEO_CC_VCODEC0_BCR		1
+#define VIDEO_CC_VCODEC1_BCR		2
+#define VIDEO_CC_INTERFACE_BCR		3
+
+/* VIDEO_CC GDSCRs */
+#define VENUS_GDSC			0
+#define VCODEC0_GDSC			1
+#define VCODEC1_GDSC			2
+
+#endif
diff --git a/include/dt-bindings/dma/qcom-gpi.h b/include/dt-bindings/dma/qcom-gpi.h
new file mode 100644
index 000000000000..ebda2a37f52a
--- /dev/null
+++ b/include/dt-bindings/dma/qcom-gpi.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/* Copyright (c) 2020, Linaro Ltd.  */
+
+#ifndef __DT_BINDINGS_DMA_QCOM_GPI_H__
+#define __DT_BINDINGS_DMA_QCOM_GPI_H__
+
+#define QCOM_GPI_SPI		1
+#define QCOM_GPI_UART		2
+#define QCOM_GPI_I2C		3
+
+#endif /* __DT_BINDINGS_DMA_QCOM_GPI_H__ */
diff --git a/include/dt-bindings/firmware/qcom,scm.h b/include/dt-bindings/firmware/qcom,scm.h
new file mode 100644
index 000000000000..d1dc09e72923
--- /dev/null
+++ b/include/dt-bindings/firmware/qcom,scm.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+/*
+ * Copyright (c) 2010-2015, 2018-2019 The Linux Foundation. All rights reserved.
+ * Copyright (C) 2015 Linaro Ltd.
+ */
+
+#ifndef _DT_BINDINGS_FIRMWARE_QCOM_SCM_H
+#define _DT_BINDINGS_FIRMWARE_QCOM_SCM_H
+
+#define QCOM_SCM_VMID_HLOS		0x3
+#define QCOM_SCM_VMID_SSC_Q6		0x5
+#define QCOM_SCM_VMID_ADSP_Q6		0x6
+#define QCOM_SCM_VMID_MSS_MSA		0xF
+#define QCOM_SCM_VMID_WLAN		0x18
+#define QCOM_SCM_VMID_WLAN_CE		0x19
+#define QCOM_SCM_VMID_NAV		0x2B
+
+#endif
diff --git a/include/dt-bindings/iio/qcom,spmi-vadc.h b/include/dt-bindings/iio/qcom,spmi-vadc.h
new file mode 100644
index 000000000000..08adfe25964c
--- /dev/null
+++ b/include/dt-bindings/iio/qcom,spmi-vadc.h
@@ -0,0 +1,300 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_H
+
+/* Voltage ADC channels */
+#define VADC_USBIN				0x00
+#define VADC_DCIN				0x01
+#define VADC_VCHG_SNS				0x02
+#define VADC_SPARE1_03				0x03
+#define VADC_USB_ID_MV				0x04
+#define VADC_VCOIN				0x05
+#define VADC_VBAT_SNS				0x06
+#define VADC_VSYS				0x07
+#define VADC_DIE_TEMP				0x08
+#define VADC_REF_625MV				0x09
+#define VADC_REF_1250MV				0x0a
+#define VADC_CHG_TEMP				0x0b
+#define VADC_SPARE1				0x0c
+#define VADC_SPARE2				0x0d
+#define VADC_GND_REF				0x0e
+#define VADC_VDD_VADC				0x0f
+
+#define VADC_P_MUX1_1_1				0x10
+#define VADC_P_MUX2_1_1				0x11
+#define VADC_P_MUX3_1_1				0x12
+#define VADC_P_MUX4_1_1				0x13
+#define VADC_P_MUX5_1_1				0x14
+#define VADC_P_MUX6_1_1				0x15
+#define VADC_P_MUX7_1_1				0x16
+#define VADC_P_MUX8_1_1				0x17
+#define VADC_P_MUX9_1_1				0x18
+#define VADC_P_MUX10_1_1			0x19
+#define VADC_P_MUX11_1_1			0x1a
+#define VADC_P_MUX12_1_1			0x1b
+#define VADC_P_MUX13_1_1			0x1c
+#define VADC_P_MUX14_1_1			0x1d
+#define VADC_P_MUX15_1_1			0x1e
+#define VADC_P_MUX16_1_1			0x1f
+
+#define VADC_P_MUX1_1_3				0x20
+#define VADC_P_MUX2_1_3				0x21
+#define VADC_P_MUX3_1_3				0x22
+#define VADC_P_MUX4_1_3				0x23
+#define VADC_P_MUX5_1_3				0x24
+#define VADC_P_MUX6_1_3				0x25
+#define VADC_P_MUX7_1_3				0x26
+#define VADC_P_MUX8_1_3				0x27
+#define VADC_P_MUX9_1_3				0x28
+#define VADC_P_MUX10_1_3			0x29
+#define VADC_P_MUX11_1_3			0x2a
+#define VADC_P_MUX12_1_3			0x2b
+#define VADC_P_MUX13_1_3			0x2c
+#define VADC_P_MUX14_1_3			0x2d
+#define VADC_P_MUX15_1_3			0x2e
+#define VADC_P_MUX16_1_3			0x2f
+
+#define VADC_LR_MUX1_BAT_THERM			0x30
+#define VADC_LR_MUX2_BAT_ID			0x31
+#define VADC_LR_MUX3_XO_THERM			0x32
+#define VADC_LR_MUX4_AMUX_THM1			0x33
+#define VADC_LR_MUX5_AMUX_THM2			0x34
+#define VADC_LR_MUX6_AMUX_THM3			0x35
+#define VADC_LR_MUX7_HW_ID			0x36
+#define VADC_LR_MUX8_AMUX_THM4			0x37
+#define VADC_LR_MUX9_AMUX_THM5			0x38
+#define VADC_LR_MUX10_USB_ID			0x39
+#define VADC_AMUX_PU1				0x3a
+#define VADC_AMUX_PU2				0x3b
+#define VADC_LR_MUX3_BUF_XO_THERM		0x3c
+
+#define VADC_LR_MUX1_PU1_BAT_THERM		0x70
+#define VADC_LR_MUX2_PU1_BAT_ID			0x71
+#define VADC_LR_MUX3_PU1_XO_THERM		0x72
+#define VADC_LR_MUX4_PU1_AMUX_THM1		0x73
+#define VADC_LR_MUX5_PU1_AMUX_THM2		0x74
+#define VADC_LR_MUX6_PU1_AMUX_THM3		0x75
+#define VADC_LR_MUX7_PU1_AMUX_HW_ID		0x76
+#define VADC_LR_MUX8_PU1_AMUX_THM4		0x77
+#define VADC_LR_MUX9_PU1_AMUX_THM5		0x78
+#define VADC_LR_MUX10_PU1_AMUX_USB_ID		0x79
+#define VADC_LR_MUX3_BUF_PU1_XO_THERM		0x7c
+
+#define VADC_LR_MUX1_PU2_BAT_THERM		0xb0
+#define VADC_LR_MUX2_PU2_BAT_ID			0xb1
+#define VADC_LR_MUX3_PU2_XO_THERM		0xb2
+#define VADC_LR_MUX4_PU2_AMUX_THM1		0xb3
+#define VADC_LR_MUX5_PU2_AMUX_THM2		0xb4
+#define VADC_LR_MUX6_PU2_AMUX_THM3		0xb5
+#define VADC_LR_MUX7_PU2_AMUX_HW_ID		0xb6
+#define VADC_LR_MUX8_PU2_AMUX_THM4		0xb7
+#define VADC_LR_MUX9_PU2_AMUX_THM5		0xb8
+#define VADC_LR_MUX10_PU2_AMUX_USB_ID		0xb9
+#define VADC_LR_MUX3_BUF_PU2_XO_THERM		0xbc
+
+#define VADC_LR_MUX1_PU1_PU2_BAT_THERM		0xf0
+#define VADC_LR_MUX2_PU1_PU2_BAT_ID		0xf1
+#define VADC_LR_MUX3_PU1_PU2_XO_THERM		0xf2
+#define VADC_LR_MUX4_PU1_PU2_AMUX_THM1		0xf3
+#define VADC_LR_MUX5_PU1_PU2_AMUX_THM2		0xf4
+#define VADC_LR_MUX6_PU1_PU2_AMUX_THM3		0xf5
+#define VADC_LR_MUX7_PU1_PU2_AMUX_HW_ID		0xf6
+#define VADC_LR_MUX8_PU1_PU2_AMUX_THM4		0xf7
+#define VADC_LR_MUX9_PU1_PU2_AMUX_THM5		0xf8
+#define VADC_LR_MUX10_PU1_PU2_AMUX_USB_ID	0xf9
+#define VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM	0xfc
+
+/* ADC channels for SPMI PMIC5 */
+
+#define ADC5_REF_GND				0x00
+#define ADC5_1P25VREF				0x01
+#define ADC5_VREF_VADC				0x02
+#define ADC5_VREF_VADC5_DIV_3			0x82
+#define ADC5_VPH_PWR				0x83
+#define ADC5_VBAT_SNS				0x84
+#define ADC5_VCOIN				0x85
+#define ADC5_DIE_TEMP				0x06
+#define ADC5_USB_IN_I				0x07
+#define ADC5_USB_IN_V_16			0x08
+#define ADC5_CHG_TEMP				0x09
+#define ADC5_BAT_THERM				0x0a
+#define ADC5_BAT_ID				0x0b
+#define ADC5_XO_THERM				0x0c
+#define ADC5_AMUX_THM1				0x0d
+#define ADC5_AMUX_THM2				0x0e
+#define ADC5_AMUX_THM3				0x0f
+#define ADC5_AMUX_THM4				0x10
+#define ADC5_AMUX_THM5				0x11
+#define ADC5_GPIO1				0x12
+#define ADC5_GPIO2				0x13
+#define ADC5_GPIO3				0x14
+#define ADC5_GPIO4				0x15
+#define ADC5_GPIO5				0x16
+#define ADC5_GPIO6				0x17
+#define ADC5_GPIO7				0x18
+#define ADC5_SBUx				0x99
+#define ADC5_MID_CHG_DIV6			0x1e
+#define ADC5_OFF				0xff
+
+/* 30k pull-up1 */
+#define ADC5_BAT_THERM_30K_PU			0x2a
+#define ADC5_BAT_ID_30K_PU			0x2b
+#define ADC5_XO_THERM_30K_PU			0x2c
+#define ADC5_AMUX_THM1_30K_PU			0x2d
+#define ADC5_AMUX_THM2_30K_PU			0x2e
+#define ADC5_AMUX_THM3_30K_PU			0x2f
+#define ADC5_AMUX_THM4_30K_PU			0x30
+#define ADC5_AMUX_THM5_30K_PU			0x31
+#define ADC5_GPIO1_30K_PU			0x32
+#define ADC5_GPIO2_30K_PU			0x33
+#define ADC5_GPIO3_30K_PU			0x34
+#define ADC5_GPIO4_30K_PU			0x35
+#define ADC5_GPIO5_30K_PU			0x36
+#define ADC5_GPIO6_30K_PU			0x37
+#define ADC5_GPIO7_30K_PU			0x38
+#define ADC5_SBUx_30K_PU			0x39
+
+/* 100k pull-up2 */
+#define ADC5_BAT_THERM_100K_PU			0x4a
+#define ADC5_BAT_ID_100K_PU			0x4b
+#define ADC5_XO_THERM_100K_PU			0x4c
+#define ADC5_AMUX_THM1_100K_PU			0x4d
+#define ADC5_AMUX_THM2_100K_PU			0x4e
+#define ADC5_AMUX_THM3_100K_PU			0x4f
+#define ADC5_AMUX_THM4_100K_PU			0x50
+#define ADC5_AMUX_THM5_100K_PU			0x51
+#define ADC5_GPIO1_100K_PU			0x52
+#define ADC5_GPIO2_100K_PU			0x53
+#define ADC5_GPIO3_100K_PU			0x54
+#define ADC5_GPIO4_100K_PU			0x55
+#define ADC5_GPIO5_100K_PU			0x56
+#define ADC5_GPIO6_100K_PU			0x57
+#define ADC5_GPIO7_100K_PU			0x58
+#define ADC5_SBUx_100K_PU			0x59
+
+/* 400k pull-up3 */
+#define ADC5_BAT_THERM_400K_PU			0x6a
+#define ADC5_BAT_ID_400K_PU			0x6b
+#define ADC5_XO_THERM_400K_PU			0x6c
+#define ADC5_AMUX_THM1_400K_PU			0x6d
+#define ADC5_AMUX_THM2_400K_PU			0x6e
+#define ADC5_AMUX_THM3_400K_PU			0x6f
+#define ADC5_AMUX_THM4_400K_PU			0x70
+#define ADC5_AMUX_THM5_400K_PU			0x71
+#define ADC5_GPIO1_400K_PU			0x72
+#define ADC5_GPIO2_400K_PU			0x73
+#define ADC5_GPIO3_400K_PU			0x74
+#define ADC5_GPIO4_400K_PU			0x75
+#define ADC5_GPIO5_400K_PU			0x76
+#define ADC5_GPIO6_400K_PU			0x77
+#define ADC5_GPIO7_400K_PU			0x78
+#define ADC5_SBUx_400K_PU			0x79
+
+/* 1/3 Divider */
+#define ADC5_GPIO1_DIV3				0x92
+#define ADC5_GPIO2_DIV3				0x93
+#define ADC5_GPIO3_DIV3				0x94
+#define ADC5_GPIO4_DIV3				0x95
+#define ADC5_GPIO5_DIV3				0x96
+#define ADC5_GPIO6_DIV3				0x97
+#define ADC5_GPIO7_DIV3				0x98
+#define ADC5_SBUx_DIV3				0x99
+
+/* Current and combined current/voltage channels */
+#define ADC5_INT_EXT_ISENSE			0xa1
+#define ADC5_PARALLEL_ISENSE			0xa5
+#define ADC5_CUR_REPLICA_VDS			0xa7
+#define ADC5_CUR_SENS_BATFET_VDS_OFFSET		0xa9
+#define ADC5_CUR_SENS_REPLICA_VDS_OFFSET	0xab
+#define ADC5_EXT_SENS_OFFSET			0xad
+
+#define ADC5_INT_EXT_ISENSE_VBAT_VDATA		0xb0
+#define ADC5_INT_EXT_ISENSE_VBAT_IDATA		0xb1
+#define ADC5_EXT_ISENSE_VBAT_VDATA		0xb2
+#define ADC5_EXT_ISENSE_VBAT_IDATA		0xb3
+#define ADC5_PARALLEL_ISENSE_VBAT_VDATA		0xb4
+#define ADC5_PARALLEL_ISENSE_VBAT_IDATA		0xb5
+
+#define ADC5_MAX_CHANNEL			0xc0
+
+/* ADC channels for ADC for PMIC7 */
+
+#define ADC7_REF_GND				0x00
+#define ADC7_1P25VREF				0x01
+#define ADC7_VREF_VADC				0x02
+#define ADC7_DIE_TEMP				0x03
+
+#define ADC7_AMUX_THM1				0x04
+#define ADC7_AMUX_THM2				0x05
+#define ADC7_AMUX_THM3				0x06
+#define ADC7_AMUX_THM4				0x07
+#define ADC7_AMUX_THM5				0x08
+#define ADC7_AMUX_THM6				0x09
+#define ADC7_GPIO1				0x0a
+#define ADC7_GPIO2				0x0b
+#define ADC7_GPIO3				0x0c
+#define ADC7_GPIO4				0x0d
+
+#define ADC7_CHG_TEMP				0x10
+#define ADC7_USB_IN_V_16			0x11
+#define ADC7_VDC_16				0x12
+#define ADC7_CC1_ID				0x13
+#define ADC7_VREF_BAT_THERM			0x15
+#define ADC7_IIN_FB				0x17
+
+/* 30k pull-up1 */
+#define ADC7_AMUX_THM1_30K_PU			0x24
+#define ADC7_AMUX_THM2_30K_PU			0x25
+#define ADC7_AMUX_THM3_30K_PU			0x26
+#define ADC7_AMUX_THM4_30K_PU			0x27
+#define ADC7_AMUX_THM5_30K_PU			0x28
+#define ADC7_AMUX_THM6_30K_PU			0x29
+#define ADC7_GPIO1_30K_PU			0x2a
+#define ADC7_GPIO2_30K_PU			0x2b
+#define ADC7_GPIO3_30K_PU			0x2c
+#define ADC7_GPIO4_30K_PU			0x2d
+#define ADC7_CC1_ID_30K_PU			0x33
+
+/* 100k pull-up2 */
+#define ADC7_AMUX_THM1_100K_PU			0x44
+#define ADC7_AMUX_THM2_100K_PU			0x45
+#define ADC7_AMUX_THM3_100K_PU			0x46
+#define ADC7_AMUX_THM4_100K_PU			0x47
+#define ADC7_AMUX_THM5_100K_PU			0x48
+#define ADC7_AMUX_THM6_100K_PU			0x49
+#define ADC7_GPIO1_100K_PU			0x4a
+#define ADC7_GPIO2_100K_PU			0x4b
+#define ADC7_GPIO3_100K_PU			0x4c
+#define ADC7_GPIO4_100K_PU			0x4d
+#define ADC7_CC1_ID_100K_PU			0x53
+
+/* 400k pull-up3 */
+#define ADC7_AMUX_THM1_400K_PU			0x64
+#define ADC7_AMUX_THM2_400K_PU			0x65
+#define ADC7_AMUX_THM3_400K_PU			0x66
+#define ADC7_AMUX_THM4_400K_PU			0x67
+#define ADC7_AMUX_THM5_400K_PU			0x68
+#define ADC7_AMUX_THM6_400K_PU			0x69
+#define ADC7_GPIO1_400K_PU			0x6a
+#define ADC7_GPIO2_400K_PU			0x6b
+#define ADC7_GPIO3_400K_PU			0x6c
+#define ADC7_GPIO4_400K_PU			0x6d
+#define ADC7_CC1_ID_400K_PU			0x73
+
+/* 1/3 Divider */
+#define ADC7_GPIO1_DIV3				0x8a
+#define ADC7_GPIO2_DIV3				0x8b
+#define ADC7_GPIO3_DIV3				0x8c
+#define ADC7_GPIO4_DIV3				0x8d
+
+#define ADC7_VPH_PWR				0x8e
+#define ADC7_VBAT_SNS				0x8f
+
+#define ADC7_SBUx				0x94
+#define ADC7_VBAT_2S_MID			0x96
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_H */
diff --git a/include/dt-bindings/interconnect/qcom,osm-l3.h b/include/dt-bindings/interconnect/qcom,osm-l3.h
new file mode 100644
index 000000000000..61ef649ae565
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,osm-l3.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_OSM_L3_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_OSM_L3_H
+
+#define MASTER_OSM_L3_APPS	0
+#define SLAVE_OSM_L3		1
+
+#define MASTER_EPSS_L3_APPS	0
+#define SLAVE_EPSS_L3_SHARED	1
+
+#endif
diff --git a/include/dt-bindings/interconnect/qcom,sdm845.h b/include/dt-bindings/interconnect/qcom,sdm845.h
new file mode 100644
index 000000000000..67b500e24915
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,sdm845.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm SDM845 interconnect IDs
+ *
+ * Copyright (c) 2018, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_SDM845_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_SDM845_H
+
+#define MASTER_A1NOC_CFG		0
+#define MASTER_TSIF			1
+#define MASTER_SDCC_2			2
+#define MASTER_SDCC_4			3
+#define MASTER_UFS_CARD			4
+#define MASTER_UFS_MEM			5
+#define MASTER_PCIE_0			6
+#define SLAVE_A1NOC_SNOC		7
+#define SLAVE_SERVICE_A1NOC		8
+#define SLAVE_ANOC_PCIE_A1NOC_SNOC	9
+#define MASTER_QUP_1			10
+
+#define MASTER_A2NOC_CFG		0
+#define MASTER_QDSS_BAM			1
+#define MASTER_CNOC_A2NOC		2
+#define MASTER_CRYPTO			3
+#define MASTER_IPA			4
+#define MASTER_PCIE_1			5
+#define MASTER_QDSS_ETR			6
+#define MASTER_USB3_0			7
+#define MASTER_USB3_1			8
+#define SLAVE_A2NOC_SNOC		9
+#define SLAVE_ANOC_PCIE_SNOC		10
+#define SLAVE_SERVICE_A2NOC		11
+#define MASTER_QUP_2			12
+
+#define MASTER_SPDM			0
+#define MASTER_TIC			1
+#define MASTER_SNOC_CNOC		2
+#define MASTER_QDSS_DAP			3
+#define SLAVE_A1NOC_CFG			4
+#define SLAVE_A2NOC_CFG			5
+#define SLAVE_AOP			6
+#define SLAVE_AOSS			7
+#define SLAVE_CAMERA_CFG		8
+#define SLAVE_CLK_CTL			9
+#define SLAVE_CDSP_CFG			10
+#define SLAVE_RBCPR_CX_CFG		11
+#define SLAVE_CRYPTO_0_CFG		12
+#define SLAVE_DCC_CFG			13
+#define SLAVE_CNOC_DDRSS		14
+#define SLAVE_DISPLAY_CFG		15
+#define SLAVE_GLM			16
+#define SLAVE_GFX3D_CFG			17
+#define SLAVE_IMEM_CFG			18
+#define SLAVE_IPA_CFG			19
+#define SLAVE_CNOC_MNOC_CFG		20
+#define SLAVE_PCIE_0_CFG		21
+#define SLAVE_PCIE_1_CFG		22
+#define SLAVE_PDM			23
+#define SLAVE_SOUTH_PHY_CFG		24
+#define SLAVE_PIMEM_CFG			25
+#define SLAVE_PRNG			26
+#define SLAVE_QDSS_CFG			27
+#define SLAVE_BLSP_2			28
+#define SLAVE_BLSP_1			29
+#define SLAVE_SDCC_2			30
+#define SLAVE_SDCC_4			31
+#define SLAVE_SNOC_CFG			32
+#define SLAVE_SPDM_WRAPPER		33
+#define SLAVE_SPSS_CFG			34
+#define SLAVE_TCSR			35
+#define SLAVE_TLMM_NORTH		36
+#define SLAVE_TLMM_SOUTH		37
+#define SLAVE_TSIF			38
+#define SLAVE_UFS_CARD_CFG		39
+#define SLAVE_UFS_MEM_CFG		40
+#define SLAVE_USB3_0			41
+#define SLAVE_USB3_1			42
+#define SLAVE_VENUS_CFG			43
+#define SLAVE_VSENSE_CTRL_CFG		44
+#define SLAVE_CNOC_A2NOC		45
+#define SLAVE_SERVICE_CNOC		46
+
+#define MASTER_CNOC_DC_NOC		0
+#define SLAVE_LLCC_CFG			1
+#define SLAVE_MEM_NOC_CFG		2
+
+#define MASTER_APPSS_PROC		0
+#define MASTER_GNOC_CFG			1
+#define SLAVE_GNOC_SNOC			2
+#define SLAVE_GNOC_MEM_NOC		3
+#define SLAVE_SERVICE_GNOC		4
+
+#define MASTER_TCU_0			0
+#define MASTER_MEM_NOC_CFG		1
+#define MASTER_GNOC_MEM_NOC		2
+#define MASTER_MNOC_HF_MEM_NOC		3
+#define MASTER_MNOC_SF_MEM_NOC		4
+#define MASTER_SNOC_GC_MEM_NOC		5
+#define MASTER_SNOC_SF_MEM_NOC		6
+#define MASTER_GFX3D			7
+#define SLAVE_MSS_PROC_MS_MPU_CFG	8
+#define SLAVE_MEM_NOC_GNOC		9
+#define SLAVE_LLCC			10
+#define SLAVE_MEM_NOC_SNOC		11
+#define SLAVE_SERVICE_MEM_NOC		12
+#define MASTER_LLCC			13
+#define SLAVE_EBI1			14
+
+#define MASTER_CNOC_MNOC_CFG		0
+#define MASTER_CAMNOC_HF0		1
+#define MASTER_CAMNOC_HF1		2
+#define MASTER_CAMNOC_SF		3
+#define MASTER_MDP0			4
+#define MASTER_MDP1			5
+#define MASTER_ROTATOR			6
+#define MASTER_VIDEO_P0			7
+#define MASTER_VIDEO_P1			8
+#define MASTER_VIDEO_PROC		9
+#define SLAVE_MNOC_SF_MEM_NOC		10
+#define SLAVE_MNOC_HF_MEM_NOC		11
+#define SLAVE_SERVICE_MNOC		12
+#define MASTER_CAMNOC_HF0_UNCOMP	13
+#define MASTER_CAMNOC_HF1_UNCOMP	14
+#define MASTER_CAMNOC_SF_UNCOMP		15
+#define SLAVE_CAMNOC_UNCOMP		16
+
+#define MASTER_SNOC_CFG			0
+#define MASTER_A1NOC_SNOC		1
+#define MASTER_A2NOC_SNOC		2
+#define MASTER_GNOC_SNOC		3
+#define MASTER_MEM_NOC_SNOC		4
+#define MASTER_ANOC_PCIE_SNOC		5
+#define MASTER_PIMEM			6
+#define MASTER_GIC			7
+#define SLAVE_APPSS			8
+#define SLAVE_SNOC_CNOC			9
+#define SLAVE_SNOC_MEM_NOC_GC		10
+#define SLAVE_SNOC_MEM_NOC_SF		11
+#define SLAVE_IMEM			12
+#define SLAVE_PCIE_0			13
+#define SLAVE_PCIE_1			14
+#define SLAVE_PIMEM			15
+#define SLAVE_SERVICE_SNOC		16
+#define SLAVE_QDSS_STM			17
+#define SLAVE_TCU			18
+
+#endif
diff --git a/include/dt-bindings/phy/phy-qcom-qmp.h b/include/dt-bindings/phy/phy-qcom-qmp.h
new file mode 100644
index 000000000000..4edec4c5b224
--- /dev/null
+++ b/include/dt-bindings/phy/phy-qcom-qmp.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
+/*
+ * Qualcomm QMP PHY constants
+ *
+ * Copyright (C) 2022 Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_PHY_QMP
+#define _DT_BINDINGS_PHY_QMP
+
+/* QMP USB4-USB3-DP clocks */
+#define QMP_USB43DP_USB3_PIPE_CLK	0
+#define QMP_USB43DP_DP_LINK_CLK		1
+#define QMP_USB43DP_DP_VCO_DIV_CLK	2
+
+/* QMP USB4-USB3-DP PHYs */
+#define QMP_USB43DP_USB3_PHY		0
+#define QMP_USB43DP_DP_PHY		1
+
+#endif /* _DT_BINDINGS_PHY_QMP */
diff --git a/include/dt-bindings/phy/phy-qcom-qusb2.h b/include/dt-bindings/phy/phy-qcom-qusb2.h
new file mode 100644
index 000000000000..5c5e4d800cac
--- /dev/null
+++ b/include/dt-bindings/phy/phy-qcom-qusb2.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_PHY_QUSB2_H_
+#define _DT_BINDINGS_QCOM_PHY_QUSB2_H_
+
+/* PHY HSTX TRIM bit values (24mA to 15mA) */
+#define QUSB2_V2_HSTX_TRIM_24_0_MA		0x0
+#define QUSB2_V2_HSTX_TRIM_23_4_MA		0x1
+#define QUSB2_V2_HSTX_TRIM_22_8_MA		0x2
+#define QUSB2_V2_HSTX_TRIM_22_2_MA		0x3
+#define QUSB2_V2_HSTX_TRIM_21_6_MA		0x4
+#define QUSB2_V2_HSTX_TRIM_21_0_MA		0x5
+#define QUSB2_V2_HSTX_TRIM_20_4_MA		0x6
+#define QUSB2_V2_HSTX_TRIM_19_8_MA		0x7
+#define QUSB2_V2_HSTX_TRIM_19_2_MA		0x8
+#define QUSB2_V2_HSTX_TRIM_18_6_MA		0x9
+#define QUSB2_V2_HSTX_TRIM_18_0_MA		0xa
+#define QUSB2_V2_HSTX_TRIM_17_4_MA		0xb
+#define QUSB2_V2_HSTX_TRIM_16_8_MA		0xc
+#define QUSB2_V2_HSTX_TRIM_16_2_MA		0xd
+#define QUSB2_V2_HSTX_TRIM_15_6_MA		0xe
+#define QUSB2_V2_HSTX_TRIM_15_0_MA		0xf
+
+/* PHY PREEMPHASIS bit values */
+#define QUSB2_V2_PREEMPHASIS_NONE		0
+#define QUSB2_V2_PREEMPHASIS_5_PERCENT		1
+#define QUSB2_V2_PREEMPHASIS_10_PERCENT		2
+#define QUSB2_V2_PREEMPHASIS_15_PERCENT		3
+
+/* PHY PREEMPHASIS-WIDTH bit values */
+#define QUSB2_V2_PREEMPHASIS_WIDTH_FULL_BIT	0
+#define QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT	1
+
+#endif
diff --git a/include/dt-bindings/pinctrl/qcom,pmic-gpio.h b/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
new file mode 100644
index 000000000000..e5df5ce45a0f
--- /dev/null
+++ b/include/dt-bindings/pinctrl/qcom,pmic-gpio.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for the Qualcomm PMIC GPIO binding.
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_QCOM_PMIC_GPIO_H
+#define _DT_BINDINGS_PINCTRL_QCOM_PMIC_GPIO_H
+
+#define PMIC_GPIO_PULL_UP_30		0
+#define PMIC_GPIO_PULL_UP_1P5		1
+#define PMIC_GPIO_PULL_UP_31P5		2
+#define PMIC_GPIO_PULL_UP_1P5_30	3
+
+#define PMIC_GPIO_STRENGTH_NO		0
+#define PMIC_GPIO_STRENGTH_HIGH		1
+#define PMIC_GPIO_STRENGTH_MED		2
+#define PMIC_GPIO_STRENGTH_LOW		3
+
+/*
+ * Note: PM8018 GPIO3 and GPIO4 are supporting
+ * only S3 and L2 options (1.8V)
+ */
+#define PM8018_GPIO_L6			0
+#define PM8018_GPIO_L5			1
+#define PM8018_GPIO_S3			2
+#define PM8018_GPIO_L14			3
+#define PM8018_GPIO_L2			4
+#define PM8018_GPIO_L4			5
+#define PM8018_GPIO_VDD			6
+
+/*
+ * Note: PM8038 GPIO7 and GPIO8 are supporting
+ * only L11 and L4 options (1.8V)
+ */
+#define PM8038_GPIO_VPH			0
+#define PM8038_GPIO_BB			1
+#define PM8038_GPIO_L11			2
+#define PM8038_GPIO_L15			3
+#define PM8038_GPIO_L4			4
+#define PM8038_GPIO_L3			5
+#define PM8038_GPIO_L17			6
+
+#define PM8058_GPIO_VPH			0
+#define PM8058_GPIO_BB			1
+#define PM8058_GPIO_S3			2
+#define PM8058_GPIO_L3			3
+#define PM8058_GPIO_L7			4
+#define PM8058_GPIO_L6			5
+#define PM8058_GPIO_L5			6
+#define PM8058_GPIO_L2			7
+
+/*
+ * Note: PM8916 GPIO1 and GPIO2 are supporting
+ * only L2(1.15V) and L5(1.8V) options
+ */
+#define PM8916_GPIO_VPH			0
+#define PM8916_GPIO_L2			2
+#define PM8916_GPIO_L5			3
+
+#define PM8917_GPIO_VPH			0
+#define PM8917_GPIO_S4			2
+#define PM8917_GPIO_L15			3
+#define PM8917_GPIO_L4			4
+#define PM8917_GPIO_L3			5
+#define PM8917_GPIO_L17			6
+
+#define PM8921_GPIO_VPH			0
+#define PM8921_GPIO_BB			1
+#define PM8921_GPIO_S4			2
+#define PM8921_GPIO_L15			3
+#define PM8921_GPIO_L4			4
+#define PM8921_GPIO_L3			5
+#define PM8921_GPIO_L17			6
+
+/*
+ * Note: PM8941 gpios from 15 to 18 are supporting
+ * only S3 and L6 options (1.8V)
+ */
+#define PM8941_GPIO_VPH			0
+#define PM8941_GPIO_L1			1
+#define PM8941_GPIO_S3			2
+#define PM8941_GPIO_L6			3
+
+/*
+ * Note: PMA8084 gpios from 15 to 18 are supporting
+ * only S4 and L6 options (1.8V)
+ */
+#define PMA8084_GPIO_VPH		0
+#define PMA8084_GPIO_L1			1
+#define PMA8084_GPIO_S4			2
+#define PMA8084_GPIO_L6			3
+
+#define PM8994_GPIO_VPH			0
+#define PM8994_GPIO_S4			2
+#define PM8994_GPIO_L12			3
+
+/* To be used with "function" */
+#define PMIC_GPIO_FUNC_NORMAL		"normal"
+#define PMIC_GPIO_FUNC_PAIRED		"paired"
+#define PMIC_GPIO_FUNC_FUNC1		"func1"
+#define PMIC_GPIO_FUNC_FUNC2		"func2"
+#define PMIC_GPIO_FUNC_FUNC3		"func3"
+#define PMIC_GPIO_FUNC_FUNC4		"func4"
+#define PMIC_GPIO_FUNC_DTEST1		"dtest1"
+#define PMIC_GPIO_FUNC_DTEST2		"dtest2"
+#define PMIC_GPIO_FUNC_DTEST3		"dtest3"
+#define PMIC_GPIO_FUNC_DTEST4		"dtest4"
+
+#define PM8038_GPIO1_2_LPG_DRV		PMIC_GPIO_FUNC_FUNC1
+#define PM8038_GPIO3_5V_BOOST_EN	PMIC_GPIO_FUNC_FUNC1
+#define PM8038_GPIO4_SSBI_ALT_CLK	PMIC_GPIO_FUNC_FUNC1
+#define PM8038_GPIO5_6_EXT_REG_EN	PMIC_GPIO_FUNC_FUNC1
+#define PM8038_GPIO10_11_EXT_REG_EN	PMIC_GPIO_FUNC_FUNC1
+#define PM8038_GPIO6_7_CLK		PMIC_GPIO_FUNC_FUNC1
+#define PM8038_GPIO9_BAT_ALRM_OUT	PMIC_GPIO_FUNC_FUNC1
+#define PM8038_GPIO6_12_KYPD_DRV	PMIC_GPIO_FUNC_FUNC2
+
+#define PM8058_GPIO7_8_MP3_CLK		PMIC_GPIO_FUNC_FUNC1
+#define PM8058_GPIO7_8_BCLK_19P2MHZ	PMIC_GPIO_FUNC_FUNC2
+#define PM8058_GPIO9_26_KYPD_DRV	PMIC_GPIO_FUNC_FUNC1
+#define PM8058_GPIO21_23_UART_TX	PMIC_GPIO_FUNC_FUNC2
+#define PM8058_GPIO24_26_LPG_DRV	PMIC_GPIO_FUNC_FUNC2
+#define PM8058_GPIO33_BCLK_19P2MHZ	PMIC_GPIO_FUNC_FUNC1
+#define PM8058_GPIO34_35_MP3_CLK	PMIC_GPIO_FUNC_FUNC1
+#define PM8058_GPIO36_BCLK_19P2MHZ	PMIC_GPIO_FUNC_FUNC1
+#define PM8058_GPIO37_UPL_OUT		PMIC_GPIO_FUNC_FUNC1
+#define PM8058_GPIO37_UART_M_RX		PMIC_GPIO_FUNC_FUNC2
+#define PM8058_GPIO38_XO_SLEEP_CLK	PMIC_GPIO_FUNC_FUNC1
+#define PM8058_GPIO38_39_CLK_32KHZ	PMIC_GPIO_FUNC_FUNC2
+#define PM8058_GPIO39_MP3_CLK		PMIC_GPIO_FUNC_FUNC1
+#define PM8058_GPIO40_EXT_BB_EN		PMIC_GPIO_FUNC_FUNC1
+
+#define PM8916_GPIO1_BAT_ALRM_OUT	PMIC_GPIO_FUNC_FUNC1
+#define PM8916_GPIO1_KEYP_DRV		PMIC_GPIO_FUNC_FUNC2
+#define PM8916_GPIO2_DIV_CLK		PMIC_GPIO_FUNC_FUNC1
+#define PM8916_GPIO2_SLEEP_CLK		PMIC_GPIO_FUNC_FUNC2
+#define PM8916_GPIO3_KEYP_DRV		PMIC_GPIO_FUNC_FUNC1
+#define PM8916_GPIO4_KEYP_DRV		PMIC_GPIO_FUNC_FUNC2
+
+#define PM8917_GPIO9_18_KEYP_DRV	PMIC_GPIO_FUNC_FUNC1
+#define PM8917_GPIO20_BAT_ALRM_OUT	PMIC_GPIO_FUNC_FUNC1
+#define PM8917_GPIO21_23_UART_TX	PMIC_GPIO_FUNC_FUNC2
+#define PM8917_GPIO25_26_EXT_REG_EN	PMIC_GPIO_FUNC_FUNC1
+#define PM8917_GPIO37_38_XO_SLEEP_CLK	PMIC_GPIO_FUNC_FUNC1
+#define PM8917_GPIO37_38_MP3_CLK	PMIC_GPIO_FUNC_FUNC2
+
+#define PM8941_GPIO9_14_KYPD_DRV	PMIC_GPIO_FUNC_FUNC1
+#define PM8941_GPIO15_18_DIV_CLK	PMIC_GPIO_FUNC_FUNC1
+#define PM8941_GPIO15_18_SLEEP_CLK	PMIC_GPIO_FUNC_FUNC2
+#define PM8941_GPIO23_26_KYPD_DRV	PMIC_GPIO_FUNC_FUNC1
+#define PM8941_GPIO23_26_LPG_DRV_HI	PMIC_GPIO_FUNC_FUNC2
+#define PM8941_GPIO31_BAT_ALRM_OUT	PMIC_GPIO_FUNC_FUNC1
+#define PM8941_GPIO33_36_LPG_DRV_3D	PMIC_GPIO_FUNC_FUNC1
+#define PM8941_GPIO33_36_LPG_DRV_HI	PMIC_GPIO_FUNC_FUNC2
+
+#define PMA8084_GPIO4_5_LPG_DRV		PMIC_GPIO_FUNC_FUNC1
+#define PMA8084_GPIO7_10_LPG_DRV	PMIC_GPIO_FUNC_FUNC1
+#define PMA8084_GPIO5_14_KEYP_DRV	PMIC_GPIO_FUNC_FUNC2
+#define PMA8084_GPIO19_21_KEYP_DRV	PMIC_GPIO_FUNC_FUNC2
+#define PMA8084_GPIO15_18_DIV_CLK	PMIC_GPIO_FUNC_FUNC1
+#define PMA8084_GPIO15_18_SLEEP_CLK	PMIC_GPIO_FUNC_FUNC2
+#define PMA8084_GPIO22_BAT_ALRM_OUT	PMIC_GPIO_FUNC_FUNC1
+
+#endif
diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
new file mode 100644
index 000000000000..7f4e2983a4c5
--- /dev/null
+++ b/include/dt-bindings/power/qcom-rpmpd.h
@@ -0,0 +1,412 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+#ifndef _DT_BINDINGS_POWER_QCOM_RPMPD_H
+#define _DT_BINDINGS_POWER_QCOM_RPMPD_H
+
+/* SA8775P Power Domain Indexes */
+#define SA8775P_CX	0
+#define SA8775P_CX_AO	1
+#define SA8775P_DDR	2
+#define SA8775P_EBI	3
+#define SA8775P_GFX	4
+#define SA8775P_LCX	5
+#define SA8775P_LMX	6
+#define SA8775P_MMCX	7
+#define SA8775P_MMCX_AO	8
+#define SA8775P_MSS	9
+#define SA8775P_MX	10
+#define SA8775P_MX_AO	11
+#define SA8775P_MXC	12
+#define SA8775P_MXC_AO	13
+#define SA8775P_NSP0	14
+#define SA8775P_NSP1	15
+#define SA8775P_XO	16
+
+/* SDM670 Power Domain Indexes */
+#define SDM670_MX	0
+#define SDM670_MX_AO	1
+#define SDM670_CX	2
+#define SDM670_CX_AO	3
+#define SDM670_LMX	4
+#define SDM670_LCX	5
+#define SDM670_GFX	6
+#define SDM670_MSS	7
+
+/* SDM845 Power Domain Indexes */
+#define SDM845_EBI	0
+#define SDM845_MX	1
+#define SDM845_MX_AO	2
+#define SDM845_CX	3
+#define SDM845_CX_AO	4
+#define SDM845_LMX	5
+#define SDM845_LCX	6
+#define SDM845_GFX	7
+#define SDM845_MSS	8
+
+/* SDX55 Power Domain Indexes */
+#define SDX55_MSS	0
+#define SDX55_MX	1
+#define SDX55_CX	2
+
+/* SDX65 Power Domain Indexes */
+#define SDX65_MSS	0
+#define SDX65_MX	1
+#define SDX65_MX_AO	2
+#define SDX65_CX	3
+#define SDX65_CX_AO	4
+#define SDX65_MXC	5
+
+/* SM6350 Power Domain Indexes */
+#define SM6350_CX	0
+#define SM6350_GFX	1
+#define SM6350_LCX	2
+#define SM6350_LMX	3
+#define SM6350_MSS	4
+#define SM6350_MX	5
+
+/* SM6350 Power Domain Indexes */
+#define SM6375_VDDCX		0
+#define SM6375_VDDCX_AO	1
+#define SM6375_VDDCX_VFL	2
+#define SM6375_VDDMX		3
+#define SM6375_VDDMX_AO	4
+#define SM6375_VDDMX_VFL	5
+#define SM6375_VDDGX		6
+#define SM6375_VDDGX_AO	7
+#define SM6375_VDD_LPI_CX	8
+#define SM6375_VDD_LPI_MX	9
+
+/* SM8150 Power Domain Indexes */
+#define SM8150_MSS	0
+#define SM8150_EBI	1
+#define SM8150_LMX	2
+#define SM8150_LCX	3
+#define SM8150_GFX	4
+#define SM8150_MX	5
+#define SM8150_MX_AO	6
+#define SM8150_CX	7
+#define SM8150_CX_AO	8
+#define SM8150_MMCX	9
+#define SM8150_MMCX_AO	10
+
+/* SA8155P is a special case, kept for backwards compatibility */
+#define SA8155P_CX	SM8150_CX
+#define SA8155P_CX_AO	SM8150_CX_AO
+#define SA8155P_EBI	SM8150_EBI
+#define SA8155P_GFX	SM8150_GFX
+#define SA8155P_MSS	SM8150_MSS
+#define SA8155P_MX	SM8150_MX
+#define SA8155P_MX_AO	SM8150_MX_AO
+
+/* SM8250 Power Domain Indexes */
+#define SM8250_CX	0
+#define SM8250_CX_AO	1
+#define SM8250_EBI	2
+#define SM8250_GFX	3
+#define SM8250_LCX	4
+#define SM8250_LMX	5
+#define SM8250_MMCX	6
+#define SM8250_MMCX_AO	7
+#define SM8250_MX	8
+#define SM8250_MX_AO	9
+
+/* SM8350 Power Domain Indexes */
+#define SM8350_CX	0
+#define SM8350_CX_AO	1
+#define SM8350_EBI	2
+#define SM8350_GFX	3
+#define SM8350_LCX	4
+#define SM8350_LMX	5
+#define SM8350_MMCX	6
+#define SM8350_MMCX_AO	7
+#define SM8350_MX	8
+#define SM8350_MX_AO	9
+#define SM8350_MXC	10
+#define SM8350_MXC_AO	11
+#define SM8350_MSS	12
+
+/* SM8450 Power Domain Indexes */
+#define SM8450_CX	0
+#define SM8450_CX_AO	1
+#define SM8450_EBI	2
+#define SM8450_GFX	3
+#define SM8450_LCX	4
+#define SM8450_LMX	5
+#define SM8450_MMCX	6
+#define SM8450_MMCX_AO	7
+#define SM8450_MX	8
+#define SM8450_MX_AO	9
+#define SM8450_MXC	10
+#define SM8450_MXC_AO	11
+#define SM8450_MSS	12
+
+/* SM8550 Power Domain Indexes */
+#define SM8550_CX	0
+#define SM8550_CX_AO	1
+#define SM8550_EBI	2
+#define SM8550_GFX	3
+#define SM8550_LCX	4
+#define SM8550_LMX	5
+#define SM8550_MMCX	6
+#define SM8550_MMCX_AO	7
+#define SM8550_MX	8
+#define SM8550_MX_AO	9
+#define SM8550_MXC	10
+#define SM8550_MXC_AO	11
+#define SM8550_MSS	12
+#define SM8550_NSP	13
+
+/* QDU1000/QRU1000 Power Domain Indexes */
+#define QDU1000_EBI	0
+#define QDU1000_MSS	1
+#define QDU1000_CX	2
+#define QDU1000_MX	3
+
+/* SC7180 Power Domain Indexes */
+#define SC7180_CX	0
+#define SC7180_CX_AO	1
+#define SC7180_GFX	2
+#define SC7180_MX	3
+#define SC7180_MX_AO	4
+#define SC7180_LMX	5
+#define SC7180_LCX	6
+#define SC7180_MSS	7
+
+/* SC7280 Power Domain Indexes */
+#define SC7280_CX	0
+#define SC7280_CX_AO	1
+#define SC7280_EBI	2
+#define SC7280_GFX	3
+#define SC7280_MX	4
+#define SC7280_MX_AO	5
+#define SC7280_LMX	6
+#define SC7280_LCX	7
+#define SC7280_MSS	8
+
+/* SC8180X Power Domain Indexes */
+#define SC8180X_CX	0
+#define SC8180X_CX_AO	1
+#define SC8180X_EBI	2
+#define SC8180X_GFX	3
+#define SC8180X_LCX	4
+#define SC8180X_LMX	5
+#define SC8180X_MMCX	6
+#define SC8180X_MMCX_AO	7
+#define SC8180X_MSS	8
+#define SC8180X_MX	9
+#define SC8180X_MX_AO	10
+
+/* SC8280XP Power Domain Indexes */
+#define SC8280XP_CX		0
+#define SC8280XP_CX_AO		1
+#define SC8280XP_DDR		2
+#define SC8280XP_EBI		3
+#define SC8280XP_GFX		4
+#define SC8280XP_LCX		5
+#define SC8280XP_LMX		6
+#define SC8280XP_MMCX		7
+#define SC8280XP_MMCX_AO	8
+#define SC8280XP_MSS		9
+#define SC8280XP_MX		10
+#define SC8280XP_MXC		12
+#define SC8280XP_MX_AO		11
+#define SC8280XP_NSP		13
+#define SC8280XP_QPHY		14
+#define SC8280XP_XO		15
+
+/* SDM845 Power Domain performance levels */
+#define RPMH_REGULATOR_LEVEL_RETENTION		16
+#define RPMH_REGULATOR_LEVEL_MIN_SVS		48
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D2		52
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D1		56
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_D0		60
+#define RPMH_REGULATOR_LEVEL_LOW_SVS		64
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_P1		72
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L1		80
+#define RPMH_REGULATOR_LEVEL_LOW_SVS_L2		96
+#define RPMH_REGULATOR_LEVEL_SVS		128
+#define RPMH_REGULATOR_LEVEL_SVS_L0		144
+#define RPMH_REGULATOR_LEVEL_SVS_L1		192
+#define RPMH_REGULATOR_LEVEL_SVS_L2		224
+#define RPMH_REGULATOR_LEVEL_NOM		256
+#define RPMH_REGULATOR_LEVEL_NOM_L0		288
+#define RPMH_REGULATOR_LEVEL_NOM_L1		320
+#define RPMH_REGULATOR_LEVEL_NOM_L2		336
+#define RPMH_REGULATOR_LEVEL_TURBO		384
+#define RPMH_REGULATOR_LEVEL_TURBO_L0		400
+#define RPMH_REGULATOR_LEVEL_TURBO_L1		416
+#define RPMH_REGULATOR_LEVEL_TURBO_L2		432
+#define RPMH_REGULATOR_LEVEL_TURBO_L3		448
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO 	464
+#define RPMH_REGULATOR_LEVEL_SUPER_TURBO_NO_CPR	480
+
+/* MDM9607 Power Domains */
+#define MDM9607_VDDCX		0
+#define MDM9607_VDDCX_AO	1
+#define MDM9607_VDDCX_VFL	2
+#define MDM9607_VDDMX		3
+#define MDM9607_VDDMX_AO	4
+#define MDM9607_VDDMX_VFL	5
+
+/* MSM8226 Power Domain Indexes */
+#define MSM8226_VDDCX		0
+#define MSM8226_VDDCX_AO	1
+#define MSM8226_VDDCX_VFC	2
+
+/* MSM8939 Power Domains */
+#define MSM8939_VDDMDCX		0
+#define MSM8939_VDDMDCX_AO	1
+#define MSM8939_VDDMDCX_VFC	2
+#define MSM8939_VDDCX		3
+#define MSM8939_VDDCX_AO	4
+#define MSM8939_VDDCX_VFC	5
+#define MSM8939_VDDMX		6
+#define MSM8939_VDDMX_AO	7
+
+/* MSM8916 Power Domain Indexes */
+#define MSM8916_VDDCX		0
+#define MSM8916_VDDCX_AO	1
+#define MSM8916_VDDCX_VFC	2
+#define MSM8916_VDDMX		3
+#define MSM8916_VDDMX_AO	4
+
+/* MSM8909 Power Domain Indexes */
+#define MSM8909_VDDCX		MSM8916_VDDCX
+#define MSM8909_VDDCX_AO	MSM8916_VDDCX_AO
+#define MSM8909_VDDCX_VFC	MSM8916_VDDCX_VFC
+#define MSM8909_VDDMX		MSM8916_VDDMX
+#define MSM8909_VDDMX_AO	MSM8916_VDDMX_AO
+
+/* MSM8917 Power Domain Indexes */
+#define MSM8917_VDDCX		0
+#define MSM8917_VDDCX_AO	1
+#define MSM8917_VDDCX_VFL	2
+#define MSM8917_VDDMX		3
+#define MSM8917_VDDMX_AO	4
+
+/* MSM8937 Power Domain Indexes */
+#define MSM8937_VDDCX		MSM8917_VDDCX
+#define MSM8937_VDDCX_AO	MSM8917_VDDCX_AO
+#define MSM8937_VDDCX_VFL	MSM8917_VDDCX_VFL
+#define MSM8937_VDDMX		MSM8917_VDDMX
+#define MSM8937_VDDMX_AO	MSM8917_VDDMX_AO
+
+/* QM215 Power Domain Indexes */
+#define QM215_VDDCX		MSM8917_VDDCX
+#define QM215_VDDCX_AO		MSM8917_VDDCX_AO
+#define QM215_VDDCX_VFL		MSM8917_VDDCX_VFL
+#define QM215_VDDMX		MSM8917_VDDMX
+#define QM215_VDDMX_AO		MSM8917_VDDMX_AO
+
+/* MSM8953 Power Domain Indexes */
+#define MSM8953_VDDMD		0
+#define MSM8953_VDDMD_AO	1
+#define MSM8953_VDDCX		2
+#define MSM8953_VDDCX_AO	3
+#define MSM8953_VDDCX_VFL	4
+#define MSM8953_VDDMX		5
+#define MSM8953_VDDMX_AO	6
+
+/* MSM8976 Power Domain Indexes */
+#define MSM8976_VDDCX		0
+#define MSM8976_VDDCX_AO	1
+#define MSM8976_VDDCX_VFL	2
+#define MSM8976_VDDMX		3
+#define MSM8976_VDDMX_AO	4
+#define MSM8976_VDDMX_VFL	5
+
+/* MSM8994 Power Domain Indexes */
+#define MSM8994_VDDCX		0
+#define MSM8994_VDDCX_AO	1
+#define MSM8994_VDDCX_VFC	2
+#define MSM8994_VDDMX		3
+#define MSM8994_VDDMX_AO	4
+#define MSM8994_VDDGFX		5
+#define MSM8994_VDDGFX_VFC	6
+
+/* MSM8996 Power Domain Indexes */
+#define MSM8996_VDDCX		0
+#define MSM8996_VDDCX_AO	1
+#define MSM8996_VDDCX_VFC	2
+#define MSM8996_VDDMX		3
+#define MSM8996_VDDMX_AO	4
+#define MSM8996_VDDSSCX		5
+#define MSM8996_VDDSSCX_VFC	6
+
+/* MSM8998 Power Domain Indexes */
+#define MSM8998_VDDCX		0
+#define MSM8998_VDDCX_AO	1
+#define MSM8998_VDDCX_VFL	2
+#define MSM8998_VDDMX		3
+#define MSM8998_VDDMX_AO	4
+#define MSM8998_VDDMX_VFL	5
+#define MSM8998_SSCCX		6
+#define MSM8998_SSCCX_VFL	7
+#define MSM8998_SSCMX		8
+#define MSM8998_SSCMX_VFL	9
+
+/* QCS404 Power Domains */
+#define QCS404_VDDMX		0
+#define QCS404_VDDMX_AO		1
+#define QCS404_VDDMX_VFL	2
+#define QCS404_LPICX		3
+#define QCS404_LPICX_VFL	4
+#define QCS404_LPIMX		5
+#define QCS404_LPIMX_VFL	6
+
+/* SDM660 Power Domains */
+#define SDM660_VDDCX		0
+#define SDM660_VDDCX_AO		1
+#define SDM660_VDDCX_VFL	2
+#define SDM660_VDDMX		3
+#define SDM660_VDDMX_AO		4
+#define SDM660_VDDMX_VFL	5
+#define SDM660_SSCCX		6
+#define SDM660_SSCCX_VFL	7
+#define SDM660_SSCMX		8
+#define SDM660_SSCMX_VFL	9
+
+/* SM6115 Power Domains */
+#define SM6115_VDDCX		0
+#define SM6115_VDDCX_AO		1
+#define SM6115_VDDCX_VFL	2
+#define SM6115_VDDMX		3
+#define SM6115_VDDMX_AO		4
+#define SM6115_VDDMX_VFL	5
+#define SM6115_VDD_LPI_CX	6
+#define SM6115_VDD_LPI_MX	7
+
+/* SM6125 Power Domains */
+#define SM6125_VDDCX		0
+#define SM6125_VDDCX_AO		1
+#define SM6125_VDDCX_VFL	2
+#define SM6125_VDDMX		3
+#define SM6125_VDDMX_AO		4
+#define SM6125_VDDMX_VFL	5
+
+/* QCM2290 Power Domains */
+#define QCM2290_VDDCX		0
+#define QCM2290_VDDCX_AO	1
+#define QCM2290_VDDCX_VFL	2
+#define QCM2290_VDDMX		3
+#define QCM2290_VDDMX_AO	4
+#define QCM2290_VDDMX_VFL	5
+#define QCM2290_VDD_LPI_CX	6
+#define QCM2290_VDD_LPI_MX	7
+
+/* RPM SMD Power Domain performance levels */
+#define RPM_SMD_LEVEL_RETENTION       16
+#define RPM_SMD_LEVEL_RETENTION_PLUS  32
+#define RPM_SMD_LEVEL_MIN_SVS         48
+#define RPM_SMD_LEVEL_LOW_SVS         64
+#define RPM_SMD_LEVEL_SVS             128
+#define RPM_SMD_LEVEL_SVS_PLUS        192
+#define RPM_SMD_LEVEL_NOM             256
+#define RPM_SMD_LEVEL_NOM_PLUS        320
+#define RPM_SMD_LEVEL_TURBO           384
+#define RPM_SMD_LEVEL_TURBO_NO_CPR    416
+#define RPM_SMD_LEVEL_TURBO_HIGH      448
+#define RPM_SMD_LEVEL_BINNING         512
+
+#endif
diff --git a/include/dt-bindings/qcom,q6asm.h b/include/dt-bindings/qcom,q6asm.h
new file mode 100644
index 000000000000..f59d74f14395
--- /dev/null
+++ b/include/dt-bindings/qcom,q6asm.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_Q6_ASM_H__
+#define __DT_BINDINGS_Q6_ASM_H__
+
+#define	MSM_FRONTEND_DAI_MULTIMEDIA1	0
+#define	MSM_FRONTEND_DAI_MULTIMEDIA2	1
+#define	MSM_FRONTEND_DAI_MULTIMEDIA3	2
+#define	MSM_FRONTEND_DAI_MULTIMEDIA4	3
+#define	MSM_FRONTEND_DAI_MULTIMEDIA5	4
+#define	MSM_FRONTEND_DAI_MULTIMEDIA6	5
+#define	MSM_FRONTEND_DAI_MULTIMEDIA7	6
+#define	MSM_FRONTEND_DAI_MULTIMEDIA8	7
+#define	MSM_FRONTEND_DAI_MULTIMEDIA9	8
+#define	MSM_FRONTEND_DAI_MULTIMEDIA10	9
+#define	MSM_FRONTEND_DAI_MULTIMEDIA11	10
+#define	MSM_FRONTEND_DAI_MULTIMEDIA12	11
+#define	MSM_FRONTEND_DAI_MULTIMEDIA13	12
+#define	MSM_FRONTEND_DAI_MULTIMEDIA14	13
+#define	MSM_FRONTEND_DAI_MULTIMEDIA15	14
+#define	MSM_FRONTEND_DAI_MULTIMEDIA16	15
+
+#define Q6ASM_DAI_TX_RX	0
+#define Q6ASM_DAI_TX	1
+#define Q6ASM_DAI_RX	2
+
+#endif /* __DT_BINDINGS_Q6_ASM_H__ */
diff --git a/include/dt-bindings/regulator/qcom,rpmh-regulator.h b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
new file mode 100644
index 000000000000..86713dcf9e02
--- /dev/null
+++ b/include/dt-bindings/regulator/qcom,rpmh-regulator.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+
+#ifndef __QCOM_RPMH_REGULATOR_H
+#define __QCOM_RPMH_REGULATOR_H
+
+/*
+ * These mode constants may be used to specify modes for various RPMh regulator
+ * device tree properties (e.g. regulator-initial-mode).  Each type of regulator
+ * supports a subset of the possible modes.
+ *
+ * %RPMH_REGULATOR_MODE_RET:	Retention mode in which only an extremely small
+ *				load current is allowed.  This mode is supported
+ *				by LDO and SMPS type regulators.
+ * %RPMH_REGULATOR_MODE_LPM:	Low power mode in which a small load current is
+ *				allowed.  This mode corresponds to PFM for SMPS
+ *				and BOB type regulators.  This mode is supported
+ *				by LDO, HFSMPS, BOB, and PMIC4 FTSMPS type
+ *				regulators.
+ * %RPMH_REGULATOR_MODE_AUTO:	Auto mode in which the regulator hardware
+ *				automatically switches between LPM and HPM based
+ *				upon the real-time load current.  This mode is
+ *				supported by HFSMPS, BOB, and PMIC4 FTSMPS type
+ *				regulators.
+ * %RPMH_REGULATOR_MODE_HPM:	High power mode in which the full rated current
+ *				of the regulator is allowed.  This mode
+ *				corresponds to PWM for SMPS and BOB type
+ *				regulators.  This mode is supported by all types
+ *				of regulators.
+ */
+#define RPMH_REGULATOR_MODE_RET		0
+#define RPMH_REGULATOR_MODE_LPM		1
+#define RPMH_REGULATOR_MODE_AUTO	2
+#define RPMH_REGULATOR_MODE_HPM		3
+
+#endif
diff --git a/include/dt-bindings/reset/qcom,sdm845-aoss.h b/include/dt-bindings/reset/qcom,sdm845-aoss.h
new file mode 100644
index 000000000000..476c5fc873b6
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,sdm845-aoss.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_AOSS_SDM_845_H
+#define _DT_BINDINGS_RESET_AOSS_SDM_845_H
+
+#define AOSS_CC_MSS_RESTART	0
+#define AOSS_CC_CAMSS_RESTART	1
+#define AOSS_CC_VENUS_RESTART	2
+#define AOSS_CC_GPU_RESTART	3
+#define AOSS_CC_DISPSS_RESTART	4
+#define AOSS_CC_WCSS_RESTART	5
+#define AOSS_CC_LPASS_RESTART	6
+
+#endif
diff --git a/include/dt-bindings/reset/qcom,sdm845-pdc.h b/include/dt-bindings/reset/qcom,sdm845-pdc.h
new file mode 100644
index 000000000000..03a0c0eb8147
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,sdm845-pdc.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_RESET_PDC_SDM_845_H
+#define _DT_BINDINGS_RESET_PDC_SDM_845_H
+
+#define PDC_APPS_SYNC_RESET	0
+#define PDC_SP_SYNC_RESET	1
+#define PDC_AUDIO_SYNC_RESET	2
+#define PDC_SENSORS_SYNC_RESET	3
+#define PDC_AOP_SYNC_RESET	4
+#define PDC_DEBUG_SYNC_RESET	5
+#define PDC_GPU_SYNC_RESET	6
+#define PDC_DISPLAY_SYNC_RESET	7
+#define PDC_COMPUTE_SYNC_RESET	8
+#define PDC_MODEM_SYNC_RESET	9
+#define PDC_WLAN_RF_SYNC_RESET	10
+#define PDC_WPSS_SYNC_RESET	11
+
+#endif
diff --git a/include/dt-bindings/soc/qcom,apr.h b/include/dt-bindings/soc/qcom,apr.h
new file mode 100644
index 000000000000..006362400c0f
--- /dev/null
+++ b/include/dt-bindings/soc/qcom,apr.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_QCOM_APR_H
+#define __DT_BINDINGS_QCOM_APR_H
+
+/* Domain IDs */
+#define APR_DOMAIN_SIM		0x1
+#define APR_DOMAIN_PC		0x2
+#define APR_DOMAIN_MODEM	0x3
+#define APR_DOMAIN_ADSP		0x4
+#define APR_DOMAIN_APPS		0x5
+#define APR_DOMAIN_MAX		0x6
+
+/* ADSP service IDs */
+#define APR_SVC_ADSP_CORE	0x3
+#define APR_SVC_AFE		0x4
+#define APR_SVC_VSM		0x5
+#define APR_SVC_VPM		0x6
+#define APR_SVC_ASM		0x7
+#define APR_SVC_ADM		0x8
+#define APR_SVC_ADSP_MVM	0x09
+#define APR_SVC_ADSP_CVS	0x0A
+#define APR_SVC_ADSP_CVP	0x0B
+#define APR_SVC_USM		0x0C
+#define APR_SVC_LSM		0x0D
+#define APR_SVC_VIDC		0x16
+#define APR_SVC_MAX		0x17
+
+#endif /* __DT_BINDINGS_QCOM_APR_H */
diff --git a/include/dt-bindings/soc/qcom,rpmh-rsc.h b/include/dt-bindings/soc/qcom,rpmh-rsc.h
new file mode 100644
index 000000000000..868f998ea998
--- /dev/null
+++ b/include/dt-bindings/soc/qcom,rpmh-rsc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef __DT_QCOM_RPMH_RSC_H__
+#define __DT_QCOM_RPMH_RSC_H__
+
+#define SLEEP_TCS	0
+#define WAKE_TCS	1
+#define ACTIVE_TCS	2
+#define CONTROL_TCS	3
+
+#endif /* __DT_QCOM_RPMH_RSC_H__ */
diff --git a/include/dt-bindings/sound/qcom,q6afe.h b/include/dt-bindings/sound/qcom,q6afe.h
new file mode 100644
index 000000000000..9d5d89cfabcf
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6afe.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_Q6_AFE_H__
+#define __DT_BINDINGS_Q6_AFE_H__
+
+/* This file exists due to backward compatibility reasons, Please do not DELETE! */
+
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
+
+#endif /* __DT_BINDINGS_Q6_AFE_H__ */
diff --git a/include/dt-bindings/sound/qcom,q6asm.h b/include/dt-bindings/sound/qcom,q6asm.h
new file mode 100644
index 000000000000..f59d74f14395
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6asm.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_Q6_ASM_H__
+#define __DT_BINDINGS_Q6_ASM_H__
+
+#define	MSM_FRONTEND_DAI_MULTIMEDIA1	0
+#define	MSM_FRONTEND_DAI_MULTIMEDIA2	1
+#define	MSM_FRONTEND_DAI_MULTIMEDIA3	2
+#define	MSM_FRONTEND_DAI_MULTIMEDIA4	3
+#define	MSM_FRONTEND_DAI_MULTIMEDIA5	4
+#define	MSM_FRONTEND_DAI_MULTIMEDIA6	5
+#define	MSM_FRONTEND_DAI_MULTIMEDIA7	6
+#define	MSM_FRONTEND_DAI_MULTIMEDIA8	7
+#define	MSM_FRONTEND_DAI_MULTIMEDIA9	8
+#define	MSM_FRONTEND_DAI_MULTIMEDIA10	9
+#define	MSM_FRONTEND_DAI_MULTIMEDIA11	10
+#define	MSM_FRONTEND_DAI_MULTIMEDIA12	11
+#define	MSM_FRONTEND_DAI_MULTIMEDIA13	12
+#define	MSM_FRONTEND_DAI_MULTIMEDIA14	13
+#define	MSM_FRONTEND_DAI_MULTIMEDIA15	14
+#define	MSM_FRONTEND_DAI_MULTIMEDIA16	15
+
+#define Q6ASM_DAI_TX_RX	0
+#define Q6ASM_DAI_TX	1
+#define Q6ASM_DAI_RX	2
+
+#endif /* __DT_BINDINGS_Q6_ASM_H__ */
diff --git a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
new file mode 100644
index 000000000000..39f203256c4f
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
@@ -0,0 +1,234 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_BINDINGS_Q6_AUDIO_PORTS_H__
+#define __DT_BINDINGS_Q6_AUDIO_PORTS_H__
+
+/* LPASS Audio virtual ports IDs */
+#define HDMI_RX		1
+#define SLIMBUS_0_RX    2
+#define SLIMBUS_0_TX    3
+#define SLIMBUS_1_RX    4
+#define SLIMBUS_1_TX    5
+#define SLIMBUS_2_RX    6
+#define SLIMBUS_2_TX    7
+#define SLIMBUS_3_RX    8
+#define SLIMBUS_3_TX    9
+#define SLIMBUS_4_RX    10
+#define SLIMBUS_4_TX    11
+#define SLIMBUS_5_RX    12
+#define SLIMBUS_5_TX    13
+#define SLIMBUS_6_RX    14
+#define SLIMBUS_6_TX    15
+#define PRIMARY_MI2S_RX		16
+#define PRIMARY_MI2S_TX		17
+#define SECONDARY_MI2S_RX	18
+#define SECONDARY_MI2S_TX	19
+#define TERTIARY_MI2S_RX	20
+#define TERTIARY_MI2S_TX	21
+#define QUATERNARY_MI2S_RX	22
+#define QUATERNARY_MI2S_TX	23
+#define PRIMARY_TDM_RX_0	24
+#define PRIMARY_TDM_TX_0	25
+#define PRIMARY_TDM_RX_1	26
+#define PRIMARY_TDM_TX_1	27
+#define PRIMARY_TDM_RX_2	28
+#define PRIMARY_TDM_TX_2	29
+#define PRIMARY_TDM_RX_3	30
+#define PRIMARY_TDM_TX_3	31
+#define PRIMARY_TDM_RX_4	32
+#define PRIMARY_TDM_TX_4	33
+#define PRIMARY_TDM_RX_5	34
+#define PRIMARY_TDM_TX_5	35
+#define PRIMARY_TDM_RX_6	36
+#define PRIMARY_TDM_TX_6	37
+#define PRIMARY_TDM_RX_7	38
+#define PRIMARY_TDM_TX_7	39
+#define SECONDARY_TDM_RX_0	40
+#define SECONDARY_TDM_TX_0	41
+#define SECONDARY_TDM_RX_1	42
+#define SECONDARY_TDM_TX_1	43
+#define SECONDARY_TDM_RX_2	44
+#define SECONDARY_TDM_TX_2	45
+#define SECONDARY_TDM_RX_3	46
+#define SECONDARY_TDM_TX_3	47
+#define SECONDARY_TDM_RX_4	48
+#define SECONDARY_TDM_TX_4	49
+#define SECONDARY_TDM_RX_5	50
+#define SECONDARY_TDM_TX_5	51
+#define SECONDARY_TDM_RX_6	52
+#define SECONDARY_TDM_TX_6	53
+#define SECONDARY_TDM_RX_7	54
+#define SECONDARY_TDM_TX_7	55
+#define TERTIARY_TDM_RX_0	56
+#define TERTIARY_TDM_TX_0	57
+#define TERTIARY_TDM_RX_1	58
+#define TERTIARY_TDM_TX_1	59
+#define TERTIARY_TDM_RX_2	60
+#define TERTIARY_TDM_TX_2	61
+#define TERTIARY_TDM_RX_3	62
+#define TERTIARY_TDM_TX_3	63
+#define TERTIARY_TDM_RX_4	64
+#define TERTIARY_TDM_TX_4	65
+#define TERTIARY_TDM_RX_5	66
+#define TERTIARY_TDM_TX_5	67
+#define TERTIARY_TDM_RX_6	68
+#define TERTIARY_TDM_TX_6	69
+#define TERTIARY_TDM_RX_7	70
+#define TERTIARY_TDM_TX_7	71
+#define QUATERNARY_TDM_RX_0	72
+#define QUATERNARY_TDM_TX_0	73
+#define QUATERNARY_TDM_RX_1	74
+#define QUATERNARY_TDM_TX_1	75
+#define QUATERNARY_TDM_RX_2	76
+#define QUATERNARY_TDM_TX_2	77
+#define QUATERNARY_TDM_RX_3	78
+#define QUATERNARY_TDM_TX_3	79
+#define QUATERNARY_TDM_RX_4	80
+#define QUATERNARY_TDM_TX_4	81
+#define QUATERNARY_TDM_RX_5	82
+#define QUATERNARY_TDM_TX_5	83
+#define QUATERNARY_TDM_RX_6	84
+#define QUATERNARY_TDM_TX_6	85
+#define QUATERNARY_TDM_RX_7	86
+#define QUATERNARY_TDM_TX_7	87
+#define QUINARY_TDM_RX_0	88
+#define QUINARY_TDM_TX_0	89
+#define QUINARY_TDM_RX_1	90
+#define QUINARY_TDM_TX_1	91
+#define QUINARY_TDM_RX_2	92
+#define QUINARY_TDM_TX_2	93
+#define QUINARY_TDM_RX_3	94
+#define QUINARY_TDM_TX_3	95
+#define QUINARY_TDM_RX_4	96
+#define QUINARY_TDM_TX_4	97
+#define QUINARY_TDM_RX_5	98
+#define QUINARY_TDM_TX_5	99
+#define QUINARY_TDM_RX_6	100
+#define QUINARY_TDM_TX_6	101
+#define QUINARY_TDM_RX_7	102
+#define QUINARY_TDM_TX_7	103
+#define DISPLAY_PORT_RX		104
+#define WSA_CODEC_DMA_RX_0	105
+#define WSA_CODEC_DMA_TX_0	106
+#define WSA_CODEC_DMA_RX_1	107
+#define WSA_CODEC_DMA_TX_1	108
+#define WSA_CODEC_DMA_TX_2	109
+#define VA_CODEC_DMA_TX_0	110
+#define VA_CODEC_DMA_TX_1	111
+#define VA_CODEC_DMA_TX_2	112
+#define RX_CODEC_DMA_RX_0	113
+#define TX_CODEC_DMA_TX_0	114
+#define RX_CODEC_DMA_RX_1	115
+#define TX_CODEC_DMA_TX_1	116
+#define RX_CODEC_DMA_RX_2	117
+#define TX_CODEC_DMA_TX_2	118
+#define RX_CODEC_DMA_RX_3	119
+#define TX_CODEC_DMA_TX_3	120
+#define RX_CODEC_DMA_RX_4	121
+#define TX_CODEC_DMA_TX_4	122
+#define RX_CODEC_DMA_RX_5	123
+#define TX_CODEC_DMA_TX_5	124
+#define RX_CODEC_DMA_RX_6	125
+#define RX_CODEC_DMA_RX_7	126
+#define QUINARY_MI2S_RX		127
+#define QUINARY_MI2S_TX		128
+#define DISPLAY_PORT_RX_0	DISPLAY_PORT_RX
+#define DISPLAY_PORT_RX_1	129
+#define DISPLAY_PORT_RX_2	130
+#define DISPLAY_PORT_RX_3	131
+#define DISPLAY_PORT_RX_4	132
+#define DISPLAY_PORT_RX_5	133
+#define DISPLAY_PORT_RX_6	134
+#define DISPLAY_PORT_RX_7	135
+
+#define LPASS_CLK_ID_PRI_MI2S_IBIT	1
+#define LPASS_CLK_ID_PRI_MI2S_EBIT	2
+#define LPASS_CLK_ID_SEC_MI2S_IBIT	3
+#define LPASS_CLK_ID_SEC_MI2S_EBIT	4
+#define LPASS_CLK_ID_TER_MI2S_IBIT	5
+#define LPASS_CLK_ID_TER_MI2S_EBIT	6
+#define LPASS_CLK_ID_QUAD_MI2S_IBIT	7
+#define LPASS_CLK_ID_QUAD_MI2S_EBIT	8
+#define LPASS_CLK_ID_SPEAKER_I2S_IBIT	9
+#define LPASS_CLK_ID_SPEAKER_I2S_EBIT	10
+#define LPASS_CLK_ID_SPEAKER_I2S_OSR	11
+#define LPASS_CLK_ID_QUI_MI2S_IBIT	12
+#define LPASS_CLK_ID_QUI_MI2S_EBIT	13
+#define LPASS_CLK_ID_SEN_MI2S_IBIT	14
+#define LPASS_CLK_ID_SEN_MI2S_EBIT	15
+#define LPASS_CLK_ID_INT0_MI2S_IBIT	16
+#define LPASS_CLK_ID_INT1_MI2S_IBIT	17
+#define LPASS_CLK_ID_INT2_MI2S_IBIT	18
+#define LPASS_CLK_ID_INT3_MI2S_IBIT	19
+#define LPASS_CLK_ID_INT4_MI2S_IBIT	20
+#define LPASS_CLK_ID_INT5_MI2S_IBIT	21
+#define LPASS_CLK_ID_INT6_MI2S_IBIT	22
+#define LPASS_CLK_ID_QUI_MI2S_OSR	23
+#define LPASS_CLK_ID_PRI_PCM_IBIT	24
+#define LPASS_CLK_ID_PRI_PCM_EBIT	25
+#define LPASS_CLK_ID_SEC_PCM_IBIT	26
+#define LPASS_CLK_ID_SEC_PCM_EBIT	27
+#define LPASS_CLK_ID_TER_PCM_IBIT	28
+#define LPASS_CLK_ID_TER_PCM_EBIT	29
+#define LPASS_CLK_ID_QUAD_PCM_IBIT	30
+#define LPASS_CLK_ID_QUAD_PCM_EBIT	31
+#define LPASS_CLK_ID_QUIN_PCM_IBIT	32
+#define LPASS_CLK_ID_QUIN_PCM_EBIT	33
+#define LPASS_CLK_ID_QUI_PCM_OSR	34
+#define LPASS_CLK_ID_PRI_TDM_IBIT	35
+#define LPASS_CLK_ID_PRI_TDM_EBIT	36
+#define LPASS_CLK_ID_SEC_TDM_IBIT	37
+#define LPASS_CLK_ID_SEC_TDM_EBIT	38
+#define LPASS_CLK_ID_TER_TDM_IBIT	39
+#define LPASS_CLK_ID_TER_TDM_EBIT	40
+#define LPASS_CLK_ID_QUAD_TDM_IBIT	41
+#define LPASS_CLK_ID_QUAD_TDM_EBIT	42
+#define LPASS_CLK_ID_QUIN_TDM_IBIT	43
+#define LPASS_CLK_ID_QUIN_TDM_EBIT	44
+#define LPASS_CLK_ID_QUIN_TDM_OSR	45
+#define LPASS_CLK_ID_MCLK_1		46
+#define LPASS_CLK_ID_MCLK_2		47
+#define LPASS_CLK_ID_MCLK_3		48
+#define LPASS_CLK_ID_MCLK_4		49
+#define LPASS_CLK_ID_INTERNAL_DIGITAL_CODEC_CORE	50
+#define LPASS_CLK_ID_INT_MCLK_0		51
+#define LPASS_CLK_ID_INT_MCLK_1		52
+#define LPASS_CLK_ID_MCLK_5		53
+#define LPASS_CLK_ID_WSA_CORE_MCLK	54
+#define LPASS_CLK_ID_WSA_CORE_NPL_MCLK	55
+#define LPASS_CLK_ID_VA_CORE_MCLK	56
+#define LPASS_CLK_ID_TX_CORE_MCLK	57
+#define LPASS_CLK_ID_TX_CORE_NPL_MCLK	58
+#define LPASS_CLK_ID_RX_CORE_MCLK	59
+#define LPASS_CLK_ID_RX_CORE_NPL_MCLK	60
+#define LPASS_CLK_ID_VA_CORE_2X_MCLK	61
+/* Clock ID for MCLK for WSA2 core */
+#define LPASS_CLK_ID_WSA2_CORE_MCLK	62
+/* Clock ID for NPL MCLK for WSA2 core */
+#define LPASS_CLK_ID_WSA2_CORE_2X_MCLK	63
+/* Clock ID for RX Core TX MCLK */
+#define LPASS_CLK_ID_RX_CORE_TX_MCLK	64
+/* Clock ID for RX CORE TX 2X MCLK */
+#define LPASS_CLK_ID_RX_CORE_TX_2X_MCLK	65
+/* Clock ID for WSA core TX MCLK */
+#define LPASS_CLK_ID_WSA_CORE_TX_MCLK	66
+/* Clock ID for WSA core TX 2X MCLK */
+#define LPASS_CLK_ID_WSA_CORE_TX_2X_MCLK	67
+/* Clock ID for WSA2 core TX MCLK */
+#define LPASS_CLK_ID_WSA2_CORE_TX_MCLK	68
+/* Clock ID for WSA2 core TX 2X MCLK */
+#define LPASS_CLK_ID_WSA2_CORE_TX_2X_MCLK	69
+/* Clock ID for RX CORE MCLK2 2X  MCLK */
+#define LPASS_CLK_ID_RX_CORE_MCLK2_2X_MCLK	70
+
+#define LPASS_HW_AVTIMER_VOTE		101
+#define LPASS_HW_MACRO_VOTE		102
+#define LPASS_HW_DCODEC_VOTE		103
+
+#define Q6AFE_MAX_CLK_ID			104
+
+#define LPASS_CLK_ATTRIBUTE_INVALID		0x0
+#define LPASS_CLK_ATTRIBUTE_COUPLE_NO		0x1
+#define LPASS_CLK_ATTRIBUTE_COUPLE_DIVIDEND	0x2
+#define LPASS_CLK_ATTRIBUTE_COUPLE_DIVISOR	0x3
+
+#endif /* __DT_BINDINGS_Q6_AUDIO_PORTS_H__ */

-- 
2.42.1

