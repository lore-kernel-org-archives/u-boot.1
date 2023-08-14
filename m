Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4144C001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 21:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F136586986;
	Mon, 14 Aug 2023 23:55:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wcK+Duw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 421C186998; Mon, 14 Aug 2023 23:55:26 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A95EC86986
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 23:55:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1bdc243d62bso18060935ad.3
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692050122; x=1692654922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x0pl/pbEd2rv4f/papl0YRDCAzd6eO00Sl9gHl3jPco=;
 b=wcK+Duw+LtdBKeDjUjwAhI/h8Q3xn8pRymAZc2eq0muVdMV9K7tZPiwiQNHKf6EqVJ
 zPrunETnX9rhLWaRY29OpK5r6C5QnZAz3NDNGxB/wUgjAU7mOqnbwDq//p0ruJbfB6Ey
 nTYJX/H7HTCZ0jWagcZrNS9NoR7SYOnKfsLQbD1b8M6cQp+vzgP8C1miWNPygvvevvVG
 8JtnUAWCTtlj+CyesrrZELSi5bqtPoV9ka2gLEDD99UmHOGlmUX/gvcqPkhmtKNJ7H61
 gGpm4KK2smkD1niIxXOF42dx8u2LTLhsx3qa7vElGMGiH4U+0tHgw9AXWdmj6klgC2L8
 WI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692050122; x=1692654922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x0pl/pbEd2rv4f/papl0YRDCAzd6eO00Sl9gHl3jPco=;
 b=arynmveWRvL0Gl1I7npxSO4awy2xPOEaZGSQN9SJprS5V5hlRY3tkPv5S7YNU6tN8B
 u1HWt4T6CDmIP2KT3jWSjyLB4aiyqxQSIqkAuWgfzCljXEssj1/LP2SMr4B+2wHTq5V/
 J/+WR6zZmHCPI7AtN2bveClhXwzSgJU/H6Rc68jwPt2Qy5WOfJCctQdCk4nfmRQuc4J5
 4RTs9hKOnvPA3oZWW1jjrYC1GkkiwfOeXC9Tv7VR5YQRLr40bbhGsRiZgL+frhITiwUm
 OQ+pFiK+kd1ltmcECvuRdTHyj8SgXAX+dDfY8ZeNLPy5eFLzWy/aPbmSNa8Xt9WgbdAH
 oV0w==
X-Gm-Message-State: AOJu0YzvBefjcXUfSbQCgO/8WG6oKQKr6L5jVhhHq72bJAqp/gqVHTEO
 caDtig0La5wYvjfhyRxwKnlqxVX7rgAS2/4VbBw=
X-Google-Smtp-Source: AGHT+IFj/Gbw/cx3fMXCVNLGgZQwqIyM/9cifho9Zeyl8yyp5SCbAkET99MpjefwESle0lvg6ieBbw==
X-Received: by 2002:a17:902:8697:b0:1bb:8931:ee94 with SMTP id
 g23-20020a170902869700b001bb8931ee94mr7626638plo.67.1692050121589; 
 Mon, 14 Aug 2023 14:55:21 -0700 (PDT)
Received: from localhost.localdomain
 ([2401:4900:1f3b:3924:6581:8508:2ecb:b5dd])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a170903110400b001bba373919bsm9872075plh.261.2023.08.14.14.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 14:55:21 -0700 (PDT)
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, bhupesh.sharma@linaro.org,
 bhupesh.linux@gmail.com, marek.vasut+renesas@mailbox.org,
 sumit.garg@linaro.org, rfried.dev@gmail.com, patrice.chotard@foss.st.com,
 jbx6244@gmail.com, kever.yang@rock-chips.com, eugen.hristev@collabora.com
Subject: [PATCH 03/17] dt-bindings: clock: Import SM6115 and SM8250 related
 clock header files from Linux
Date: Tue, 15 Aug 2023 03:24:43 +0530
Message-Id: <20230814215457.4075025-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
References: <20230814215457.4075025-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Import SM6115 and SM8250 related clock header files from Linux,
which would be included in the Qualcomm QMP PHY driver.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 include/dt-bindings/clock/qcom,gcc-sm6115.h | 201 +++++++++++++++
 include/dt-bindings/clock/qcom,gcc-sm8250.h | 271 ++++++++++++++++++++
 2 files changed, 472 insertions(+)
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm6115.h
 create mode 100644 include/dt-bindings/clock/qcom,gcc-sm8250.h

diff --git a/include/dt-bindings/clock/qcom,gcc-sm6115.h b/include/dt-bindings/clock/qcom,gcc-sm6115.h
new file mode 100644
index 0000000000..b91a7b4604
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-sm6115.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2019-2021, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM6115_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SM6115_H
+
+/* GCC clocks */
+#define GPLL0							0
+#define GPLL0_OUT_AUX2						1
+#define GPLL0_OUT_MAIN						2
+#define GPLL10							3
+#define GPLL10_OUT_MAIN						4
+#define GPLL11							5
+#define GPLL11_OUT_MAIN						6
+#define GPLL3							7
+#define GPLL4							8
+#define GPLL4_OUT_MAIN						9
+#define GPLL6							10
+#define GPLL6_OUT_MAIN						11
+#define GPLL7							12
+#define GPLL7_OUT_MAIN						13
+#define GPLL8							14
+#define GPLL8_OUT_MAIN						15
+#define GPLL9							16
+#define GPLL9_OUT_MAIN						17
+#define GCC_CAMSS_CSI0PHYTIMER_CLK				18
+#define GCC_CAMSS_CSI0PHYTIMER_CLK_SRC				19
+#define GCC_CAMSS_CSI1PHYTIMER_CLK				20
+#define GCC_CAMSS_CSI1PHYTIMER_CLK_SRC				21
+#define GCC_CAMSS_CSI2PHYTIMER_CLK				22
+#define GCC_CAMSS_CSI2PHYTIMER_CLK_SRC				23
+#define GCC_CAMSS_MCLK0_CLK					24
+#define GCC_CAMSS_MCLK0_CLK_SRC					25
+#define GCC_CAMSS_MCLK1_CLK					26
+#define GCC_CAMSS_MCLK1_CLK_SRC					27
+#define GCC_CAMSS_MCLK2_CLK					28
+#define GCC_CAMSS_MCLK2_CLK_SRC					29
+#define GCC_CAMSS_MCLK3_CLK					30
+#define GCC_CAMSS_MCLK3_CLK_SRC					31
+#define GCC_CAMSS_NRT_AXI_CLK					32
+#define GCC_CAMSS_OPE_AHB_CLK					33
+#define GCC_CAMSS_OPE_AHB_CLK_SRC				34
+#define GCC_CAMSS_OPE_CLK					35
+#define GCC_CAMSS_OPE_CLK_SRC					36
+#define GCC_CAMSS_RT_AXI_CLK					37
+#define GCC_CAMSS_TFE_0_CLK					38
+#define GCC_CAMSS_TFE_0_CLK_SRC					39
+#define GCC_CAMSS_TFE_0_CPHY_RX_CLK				40
+#define GCC_CAMSS_TFE_0_CSID_CLK				41
+#define GCC_CAMSS_TFE_0_CSID_CLK_SRC				42
+#define GCC_CAMSS_TFE_1_CLK					43
+#define GCC_CAMSS_TFE_1_CLK_SRC					44
+#define GCC_CAMSS_TFE_1_CPHY_RX_CLK				45
+#define GCC_CAMSS_TFE_1_CSID_CLK				46
+#define GCC_CAMSS_TFE_1_CSID_CLK_SRC				47
+#define GCC_CAMSS_TFE_2_CLK					48
+#define GCC_CAMSS_TFE_2_CLK_SRC					49
+#define GCC_CAMSS_TFE_2_CPHY_RX_CLK				50
+#define GCC_CAMSS_TFE_2_CSID_CLK				51
+#define GCC_CAMSS_TFE_2_CSID_CLK_SRC				52
+#define GCC_CAMSS_TFE_CPHY_RX_CLK_SRC				53
+#define GCC_CAMSS_TOP_AHB_CLK					54
+#define GCC_CAMSS_TOP_AHB_CLK_SRC				55
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				56
+#define GCC_CPUSS_AHB_CLK					57
+#define GCC_CPUSS_GNOC_CLK					60
+#define GCC_DISP_AHB_CLK					61
+#define GCC_DISP_GPLL0_DIV_CLK_SRC				62
+#define GCC_DISP_HF_AXI_CLK					63
+#define GCC_DISP_THROTTLE_CORE_CLK				64
+#define GCC_DISP_XO_CLK						65
+#define GCC_GP1_CLK						66
+#define GCC_GP1_CLK_SRC						67
+#define GCC_GP2_CLK						68
+#define GCC_GP2_CLK_SRC						69
+#define GCC_GP3_CLK						70
+#define GCC_GP3_CLK_SRC						71
+#define GCC_GPU_CFG_AHB_CLK					72
+#define GCC_GPU_GPLL0_CLK_SRC					73
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				74
+#define GCC_GPU_IREF_CLK					75
+#define GCC_GPU_MEMNOC_GFX_CLK					76
+#define GCC_GPU_SNOC_DVM_GFX_CLK				77
+#define GCC_GPU_THROTTLE_CORE_CLK				78
+#define GCC_GPU_THROTTLE_XO_CLK					79
+#define GCC_PDM2_CLK						80
+#define GCC_PDM2_CLK_SRC					81
+#define GCC_PDM_AHB_CLK						82
+#define GCC_PDM_XO4_CLK						83
+#define GCC_PRNG_AHB_CLK					84
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK				85
+#define GCC_QMIP_CAMERA_RT_AHB_CLK				86
+#define GCC_QMIP_DISP_AHB_CLK					87
+#define GCC_QMIP_GPU_CFG_AHB_CLK				88
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				89
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK				90
+#define GCC_QUPV3_WRAP0_CORE_CLK				91
+#define GCC_QUPV3_WRAP0_S0_CLK					92
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC				93
+#define GCC_QUPV3_WRAP0_S1_CLK					94
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC				95
+#define GCC_QUPV3_WRAP0_S2_CLK					96
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC				97
+#define GCC_QUPV3_WRAP0_S3_CLK					98
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC				99
+#define GCC_QUPV3_WRAP0_S4_CLK					100
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC				101
+#define GCC_QUPV3_WRAP0_S5_CLK					102
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC				103
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK				104
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK				105
+#define GCC_SDCC1_AHB_CLK					106
+#define GCC_SDCC1_APPS_CLK					107
+#define GCC_SDCC1_APPS_CLK_SRC					108
+#define GCC_SDCC1_ICE_CORE_CLK					109
+#define GCC_SDCC1_ICE_CORE_CLK_SRC				110
+#define GCC_SDCC2_AHB_CLK					111
+#define GCC_SDCC2_APPS_CLK					112
+#define GCC_SDCC2_APPS_CLK_SRC					113
+#define GCC_SYS_NOC_CPUSS_AHB_CLK				114
+#define GCC_SYS_NOC_UFS_PHY_AXI_CLK				115
+#define GCC_SYS_NOC_USB3_PRIM_AXI_CLK				116
+#define GCC_UFS_PHY_AHB_CLK					117
+#define GCC_UFS_PHY_AXI_CLK					118
+#define GCC_UFS_PHY_AXI_CLK_SRC					119
+#define GCC_UFS_PHY_ICE_CORE_CLK				120
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				121
+#define GCC_UFS_PHY_PHY_AUX_CLK					122
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				123
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				124
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				125
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK				126
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				127
+#define GCC_USB30_PRIM_MASTER_CLK				128
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				129
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				130
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			131
+#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC		132
+#define GCC_USB30_PRIM_SLEEP_CLK				133
+#define GCC_USB3_PRIM_CLKREF_CLK				134
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				135
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				136
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				137
+#define GCC_VCODEC0_AXI_CLK					138
+#define GCC_VENUS_AHB_CLK					139
+#define GCC_VENUS_CTL_AXI_CLK					140
+#define GCC_VIDEO_AHB_CLK					141
+#define GCC_VIDEO_AXI0_CLK					142
+#define GCC_VIDEO_THROTTLE_CORE_CLK				143
+#define GCC_VIDEO_VCODEC0_SYS_CLK				144
+#define GCC_VIDEO_VENUS_CLK_SRC					145
+#define GCC_VIDEO_VENUS_CTL_CLK					146
+#define GCC_VIDEO_XO_CLK					147
+#define GCC_AHB2PHY_CSI_CLK					148
+#define GCC_AHB2PHY_USB_CLK					149
+#define GCC_BIMC_GPU_AXI_CLK					150
+#define GCC_BOOT_ROM_AHB_CLK					151
+#define GCC_CAM_THROTTLE_NRT_CLK				152
+#define GCC_CAM_THROTTLE_RT_CLK					153
+#define GCC_CAMERA_AHB_CLK					154
+#define GCC_CAMERA_XO_CLK					155
+#define GCC_CAMSS_AXI_CLK					156
+#define GCC_CAMSS_AXI_CLK_SRC					157
+#define GCC_CAMSS_CAMNOC_ATB_CLK				158
+#define GCC_CAMSS_CAMNOC_NTS_XO_CLK				159
+#define GCC_CAMSS_CCI_0_CLK					160
+#define GCC_CAMSS_CCI_CLK_SRC					161
+#define GCC_CAMSS_CPHY_0_CLK					162
+#define GCC_CAMSS_CPHY_1_CLK					163
+#define GCC_CAMSS_CPHY_2_CLK					164
+#define GCC_UFS_CLKREF_CLK					165
+#define GCC_DISP_GPLL0_CLK_SRC					166
+
+/* GCC resets */
+#define GCC_QUSB2PHY_PRIM_BCR					0
+#define GCC_QUSB2PHY_SEC_BCR					1
+#define GCC_SDCC1_BCR						2
+#define GCC_UFS_PHY_BCR						3
+#define GCC_USB30_PRIM_BCR					4
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				5
+#define GCC_VCODEC0_BCR						6
+#define GCC_VENUS_BCR						7
+#define GCC_VIDEO_INTERFACE_BCR					8
+#define GCC_USB3PHY_PHY_PRIM_SP0_BCR				9
+#define GCC_USB3_PHY_PRIM_SP0_BCR				10
+#define GCC_SDCC2_BCR						11
+
+/* Indexes for GDSCs */
+#define GCC_CAMSS_TOP_GDSC			0
+#define GCC_UFS_PHY_GDSC			1
+#define GCC_USB30_PRIM_GDSC			2
+#define GCC_VCODEC0_GDSC			3
+#define GCC_VENUS_GDSC				4
+#define HLOS1_VOTE_TURING_MMU_TBU1_GDSC		5
+#define HLOS1_VOTE_TURING_MMU_TBU0_GDSC		6
+#define HLOS1_VOTE_MM_SNOC_MMU_TBU_RT_GDSC	7
+#define HLOS1_VOTE_MM_SNOC_MMU_TBU_NRT_GDSC	8
+
+#endif
diff --git a/include/dt-bindings/clock/qcom,gcc-sm8250.h b/include/dt-bindings/clock/qcom,gcc-sm8250.h
new file mode 100644
index 0000000000..7b7abe327e
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,gcc-sm8250.h
@@ -0,0 +1,271 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM8250_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SM8250_H
+
+/* GCC clocks */
+#define GPLL0							0
+#define GPLL0_OUT_EVEN						1
+#define GPLL4							2
+#define GPLL9							3
+#define GCC_AGGRE_NOC_PCIE_TBU_CLK				4
+#define GCC_AGGRE_UFS_CARD_AXI_CLK				5
+#define GCC_AGGRE_UFS_PHY_AXI_CLK				6
+#define GCC_AGGRE_USB3_PRIM_AXI_CLK				7
+#define GCC_AGGRE_USB3_SEC_AXI_CLK				8
+#define GCC_BOOT_ROM_AHB_CLK					9
+#define GCC_CAMERA_AHB_CLK					10
+#define GCC_CAMERA_HF_AXI_CLK					11
+#define GCC_CAMERA_SF_AXI_CLK					12
+#define GCC_CAMERA_XO_CLK					13
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				14
+#define GCC_CFG_NOC_USB3_SEC_AXI_CLK				15
+#define GCC_CPUSS_AHB_CLK					16
+#define GCC_CPUSS_AHB_CLK_SRC					17
+#define GCC_CPUSS_AHB_POSTDIV_CLK_SRC				18
+#define GCC_CPUSS_DVM_BUS_CLK					19
+#define GCC_CPUSS_RBCPR_CLK					20
+#define GCC_DDRSS_GPU_AXI_CLK					21
+#define GCC_DDRSS_PCIE_SF_TBU_CLK				22
+#define GCC_DISP_AHB_CLK					23
+#define GCC_DISP_HF_AXI_CLK					24
+#define GCC_DISP_SF_AXI_CLK					25
+#define GCC_DISP_XO_CLK						26
+#define GCC_GP1_CLK						27
+#define GCC_GP1_CLK_SRC						28
+#define GCC_GP2_CLK						29
+#define GCC_GP2_CLK_SRC						30
+#define GCC_GP3_CLK						31
+#define GCC_GP3_CLK_SRC						32
+#define GCC_GPU_CFG_AHB_CLK					33
+#define GCC_GPU_GPLL0_CLK_SRC					34
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				35
+#define GCC_GPU_IREF_EN						36
+#define GCC_GPU_MEMNOC_GFX_CLK					37
+#define GCC_GPU_SNOC_DVM_GFX_CLK				38
+#define GCC_NPU_AXI_CLK						39
+#define GCC_NPU_BWMON_AXI_CLK					40
+#define GCC_NPU_BWMON_CFG_AHB_CLK				41
+#define GCC_NPU_CFG_AHB_CLK					42
+#define GCC_NPU_DMA_CLK						43
+#define GCC_NPU_GPLL0_CLK_SRC					44
+#define GCC_NPU_GPLL0_DIV_CLK_SRC				45
+#define GCC_PCIE0_PHY_REFGEN_CLK				46
+#define GCC_PCIE1_PHY_REFGEN_CLK				47
+#define GCC_PCIE2_PHY_REFGEN_CLK				48
+#define GCC_PCIE_0_AUX_CLK					49
+#define GCC_PCIE_0_AUX_CLK_SRC					50
+#define GCC_PCIE_0_CFG_AHB_CLK					51
+#define GCC_PCIE_0_MSTR_AXI_CLK					52
+#define GCC_PCIE_0_PIPE_CLK					53
+#define GCC_PCIE_0_SLV_AXI_CLK					54
+#define GCC_PCIE_0_SLV_Q2A_AXI_CLK				55
+#define GCC_PCIE_1_AUX_CLK					56
+#define GCC_PCIE_1_AUX_CLK_SRC					57
+#define GCC_PCIE_1_CFG_AHB_CLK					58
+#define GCC_PCIE_1_MSTR_AXI_CLK					59
+#define GCC_PCIE_1_PIPE_CLK					60
+#define GCC_PCIE_1_SLV_AXI_CLK					61
+#define GCC_PCIE_1_SLV_Q2A_AXI_CLK				62
+#define GCC_PCIE_2_AUX_CLK					63
+#define GCC_PCIE_2_AUX_CLK_SRC					64
+#define GCC_PCIE_2_CFG_AHB_CLK					65
+#define GCC_PCIE_2_MSTR_AXI_CLK					66
+#define GCC_PCIE_2_PIPE_CLK					67
+#define GCC_PCIE_2_SLV_AXI_CLK					68
+#define GCC_PCIE_2_SLV_Q2A_AXI_CLK				69
+#define GCC_PCIE_MDM_CLKREF_EN					70
+#define GCC_PCIE_PHY_AUX_CLK					71
+#define GCC_PCIE_PHY_REFGEN_CLK_SRC				72
+#define GCC_PCIE_WIFI_CLKREF_EN					73
+#define GCC_PCIE_WIGIG_CLKREF_EN				74
+#define GCC_PDM2_CLK						75
+#define GCC_PDM2_CLK_SRC					76
+#define GCC_PDM_AHB_CLK						77
+#define GCC_PDM_XO4_CLK						78
+#define GCC_PRNG_AHB_CLK					79
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK				80
+#define GCC_QMIP_CAMERA_RT_AHB_CLK				81
+#define GCC_QMIP_DISP_AHB_CLK					82
+#define GCC_QMIP_VIDEO_CVP_AHB_CLK				83
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				84
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK				85
+#define GCC_QUPV3_WRAP0_CORE_CLK				86
+#define GCC_QUPV3_WRAP0_S0_CLK					87
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC				88
+#define GCC_QUPV3_WRAP0_S1_CLK					89
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC				90
+#define GCC_QUPV3_WRAP0_S2_CLK					91
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC				92
+#define GCC_QUPV3_WRAP0_S3_CLK					93
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC				94
+#define GCC_QUPV3_WRAP0_S4_CLK					95
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC				96
+#define GCC_QUPV3_WRAP0_S5_CLK					97
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC				98
+#define GCC_QUPV3_WRAP0_S6_CLK					99
+#define GCC_QUPV3_WRAP0_S6_CLK_SRC				100
+#define GCC_QUPV3_WRAP0_S7_CLK					101
+#define GCC_QUPV3_WRAP0_S7_CLK_SRC				102
+#define GCC_QUPV3_WRAP1_CORE_2X_CLK				103
+#define GCC_QUPV3_WRAP1_CORE_CLK				104
+#define GCC_QUPV3_WRAP1_S0_CLK					105
+#define GCC_QUPV3_WRAP1_S0_CLK_SRC				106
+#define GCC_QUPV3_WRAP1_S1_CLK					107
+#define GCC_QUPV3_WRAP1_S1_CLK_SRC				108
+#define GCC_QUPV3_WRAP1_S2_CLK					109
+#define GCC_QUPV3_WRAP1_S2_CLK_SRC				110
+#define GCC_QUPV3_WRAP1_S3_CLK					111
+#define GCC_QUPV3_WRAP1_S3_CLK_SRC				112
+#define GCC_QUPV3_WRAP1_S4_CLK					113
+#define GCC_QUPV3_WRAP1_S4_CLK_SRC				114
+#define GCC_QUPV3_WRAP1_S5_CLK					115
+#define GCC_QUPV3_WRAP1_S5_CLK_SRC				116
+#define GCC_QUPV3_WRAP2_CORE_2X_CLK				117
+#define GCC_QUPV3_WRAP2_CORE_CLK				118
+#define GCC_QUPV3_WRAP2_S0_CLK					119
+#define GCC_QUPV3_WRAP2_S0_CLK_SRC				120
+#define GCC_QUPV3_WRAP2_S1_CLK					121
+#define GCC_QUPV3_WRAP2_S1_CLK_SRC				122
+#define GCC_QUPV3_WRAP2_S2_CLK					123
+#define GCC_QUPV3_WRAP2_S2_CLK_SRC				124
+#define GCC_QUPV3_WRAP2_S3_CLK					125
+#define GCC_QUPV3_WRAP2_S3_CLK_SRC				126
+#define GCC_QUPV3_WRAP2_S4_CLK					127
+#define GCC_QUPV3_WRAP2_S4_CLK_SRC				128
+#define GCC_QUPV3_WRAP2_S5_CLK					129
+#define GCC_QUPV3_WRAP2_S5_CLK_SRC				130
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK				131
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK				132
+#define GCC_QUPV3_WRAP_1_M_AHB_CLK				133
+#define GCC_QUPV3_WRAP_1_S_AHB_CLK				134
+#define GCC_QUPV3_WRAP_2_M_AHB_CLK				135
+#define GCC_QUPV3_WRAP_2_S_AHB_CLK				136
+#define GCC_SDCC2_AHB_CLK					137
+#define GCC_SDCC2_APPS_CLK					138
+#define GCC_SDCC2_APPS_CLK_SRC					139
+#define GCC_SDCC4_AHB_CLK					140
+#define GCC_SDCC4_APPS_CLK					141
+#define GCC_SDCC4_APPS_CLK_SRC					142
+#define GCC_SYS_NOC_CPUSS_AHB_CLK				143
+#define GCC_TSIF_AHB_CLK					144
+#define GCC_TSIF_INACTIVITY_TIMERS_CLK				145
+#define GCC_TSIF_REF_CLK					146
+#define GCC_TSIF_REF_CLK_SRC					147
+#define GCC_UFS_1X_CLKREF_EN					148
+#define GCC_UFS_CARD_AHB_CLK					149
+#define GCC_UFS_CARD_AXI_CLK					150
+#define GCC_UFS_CARD_AXI_CLK_SRC				151
+#define GCC_UFS_CARD_ICE_CORE_CLK				152
+#define GCC_UFS_CARD_ICE_CORE_CLK_SRC				153
+#define GCC_UFS_CARD_PHY_AUX_CLK				154
+#define GCC_UFS_CARD_PHY_AUX_CLK_SRC				155
+#define GCC_UFS_CARD_RX_SYMBOL_0_CLK				156
+#define GCC_UFS_CARD_RX_SYMBOL_1_CLK				157
+#define GCC_UFS_CARD_TX_SYMBOL_0_CLK				158
+#define GCC_UFS_CARD_UNIPRO_CORE_CLK				159
+#define GCC_UFS_CARD_UNIPRO_CORE_CLK_SRC			160
+#define GCC_UFS_PHY_AHB_CLK					161
+#define GCC_UFS_PHY_AXI_CLK					162
+#define GCC_UFS_PHY_AXI_CLK_SRC					163
+#define GCC_UFS_PHY_ICE_CORE_CLK				164
+#define GCC_UFS_PHY_ICE_CORE_CLK_SRC				165
+#define GCC_UFS_PHY_PHY_AUX_CLK					166
+#define GCC_UFS_PHY_PHY_AUX_CLK_SRC				167
+#define GCC_UFS_PHY_RX_SYMBOL_0_CLK				168
+#define GCC_UFS_PHY_RX_SYMBOL_1_CLK				169
+#define GCC_UFS_PHY_TX_SYMBOL_0_CLK				170
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK				171
+#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC				172
+#define GCC_USB30_PRIM_MASTER_CLK				173
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				174
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				175
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			176
+#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC		177
+#define GCC_USB30_PRIM_SLEEP_CLK				178
+#define GCC_USB30_SEC_MASTER_CLK				179
+#define GCC_USB30_SEC_MASTER_CLK_SRC				180
+#define GCC_USB30_SEC_MOCK_UTMI_CLK				181
+#define GCC_USB30_SEC_MOCK_UTMI_CLK_SRC				182
+#define GCC_USB30_SEC_MOCK_UTMI_POSTDIV_CLK_SRC			183
+#define GCC_USB30_SEC_SLEEP_CLK					184
+#define GCC_USB3_PRIM_PHY_AUX_CLK				185
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				186
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				187
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				188
+#define GCC_USB3_PRIM_PHY_PIPE_CLK_SRC				189
+#define GCC_USB3_SEC_CLKREF_EN					190
+#define GCC_USB3_SEC_PHY_AUX_CLK				191
+#define GCC_USB3_SEC_PHY_AUX_CLK_SRC				192
+#define GCC_USB3_SEC_PHY_COM_AUX_CLK				193
+#define GCC_USB3_SEC_PHY_PIPE_CLK				194
+#define GCC_USB3_SEC_PHY_PIPE_CLK_SRC				195
+#define GCC_VIDEO_AHB_CLK					196
+#define GCC_VIDEO_AXI0_CLK					197
+#define GCC_VIDEO_AXI1_CLK					198
+#define GCC_VIDEO_XO_CLK					199
+
+/* GCC resets */
+#define GCC_GPU_BCR						0
+#define GCC_MMSS_BCR						1
+#define GCC_NPU_BWMON_BCR					2
+#define GCC_NPU_BCR						3
+#define GCC_PCIE_0_BCR						4
+#define GCC_PCIE_0_LINK_DOWN_BCR				5
+#define GCC_PCIE_0_NOCSR_COM_PHY_BCR				6
+#define GCC_PCIE_0_PHY_BCR					7
+#define GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR			8
+#define GCC_PCIE_1_BCR						9
+#define GCC_PCIE_1_LINK_DOWN_BCR				10
+#define GCC_PCIE_1_NOCSR_COM_PHY_BCR				11
+#define GCC_PCIE_1_PHY_BCR					12
+#define GCC_PCIE_1_PHY_NOCSR_COM_PHY_BCR			13
+#define GCC_PCIE_2_BCR						14
+#define GCC_PCIE_2_LINK_DOWN_BCR				15
+#define GCC_PCIE_2_NOCSR_COM_PHY_BCR				16
+#define GCC_PCIE_2_PHY_BCR					17
+#define GCC_PCIE_2_PHY_NOCSR_COM_PHY_BCR			18
+#define GCC_PCIE_PHY_BCR					19
+#define GCC_PCIE_PHY_CFG_AHB_BCR				20
+#define GCC_PCIE_PHY_COM_BCR					21
+#define GCC_PDM_BCR						22
+#define GCC_PRNG_BCR						23
+#define GCC_QUPV3_WRAPPER_0_BCR					24
+#define GCC_QUPV3_WRAPPER_1_BCR					25
+#define GCC_QUPV3_WRAPPER_2_BCR					26
+#define GCC_QUSB2PHY_PRIM_BCR					27
+#define GCC_QUSB2PHY_SEC_BCR					28
+#define GCC_SDCC2_BCR						29
+#define GCC_SDCC4_BCR						30
+#define GCC_TSIF_BCR						31
+#define GCC_UFS_CARD_BCR					32
+#define GCC_UFS_PHY_BCR						33
+#define GCC_USB30_PRIM_BCR					34
+#define GCC_USB30_SEC_BCR					35
+#define GCC_USB3_DP_PHY_PRIM_BCR				36
+#define GCC_USB3_DP_PHY_SEC_BCR					37
+#define GCC_USB3_PHY_PRIM_BCR					38
+#define GCC_USB3_PHY_SEC_BCR					39
+#define GCC_USB3PHY_PHY_PRIM_BCR				40
+#define GCC_USB3PHY_PHY_SEC_BCR					41
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				42
+#define GCC_VIDEO_AXI0_CLK_ARES					43
+#define GCC_VIDEO_AXI1_CLK_ARES					44
+
+/* GCC power domains */
+#define PCIE_0_GDSC						0
+#define PCIE_1_GDSC						1
+#define PCIE_2_GDSC						2
+#define UFS_CARD_GDSC						3
+#define UFS_PHY_GDSC						4
+#define USB30_PRIM_GDSC						5
+#define USB30_SEC_GDSC						6
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF0_GDSC			7
+#define HLOS1_VOTE_MMNOC_MMU_TBU_HF1_GDSC			8
+#define HLOS1_VOTE_MMNOC_MMU_TBU_SF0_GDSC			9
+#define HLOS1_VOTE_MMNOC_MMU_TBU_SF1_GDSC			10
+
+#endif
-- 
2.38.1

