Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48824E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 05:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C1F7806D4;
	Fri, 10 Jan 2025 06:09:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="fXMhQmfg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78C76806C6; Fri, 10 Jan 2025 06:09:15 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D62E80619
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 06:09:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A3bt9p002805;
 Fri, 10 Jan 2025 05:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9OzNKmP5M3EEpxGgcalokd3pw141pJRt9X4bk+oFHgE=; b=fXMhQmfgN0MrJUx/
 C8oSrLW4FW5YiNMDgEzHsKQGw9XKeSrWGC4anqcsEwFBs308r9zfWSbHll4iWQPf
 wmuriCoxYvNNudjVI04p9ZJeJsHhDxNzXiRRFsqjurCZrBShA0aP+RfzMfjt27l3
 5tcj2rZpb0x5g5EwkjGJHzH0mqWEJdRCZ5UBQWoXFvCrCkzLhaWfZgUEoOq0b7sL
 xouUvwH8yFLLVuI/LGiNG6AX+whVVlktz7h0R8KIbMo5KUxCmZ6dy9+eRyML2RFj
 ZbKKARLEzu/mQDDn64pnHThJU2eJdDGRbtVARWESJNKr6UVIl8Ree+Hi1bpXvSg5
 ArUWxg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442uteg50v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 05:08:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A58v1P009093
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 05:08:57 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 21:08:51 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>, <sjg@chromium.org>,
 <ilias.apalodimas@linaro.org>, <Volodymyr_Babchuk@epam.com>,
 <lehmanju@devpi.de>, <bhupesh.linux@gmail.com>,
 <konradybcio@kernel.org>, <quic_tengfan@quicinc.com>,
 <andersson@kernel.org>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v3 4/6] phy: qcom: Add SA8775 to QMP UFS PHY driver
Date: Fri, 10 Jan 2025 10:38:15 +0530
Message-ID: <20250110050817.3819282-5-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250110050817.3819282-1-quic_varada@quicinc.com>
References: <20250110050817.3819282-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 81loY4G_df5QYNylynLtCc2QOvqhVs1s
X-Proofpoint-ORIG-GUID: 81loY4G_df5QYNylynLtCc2QOvqhVs1s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100039
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

Copy PHY tables over from Linux to support SA8775.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tag/?h=v6.13-rc6

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Added 'Reviewed-by: Neil Armstrong' and 'Caleb Connolly'
    Added Linux version info
---
 .../phy/qcom/phy-qcom-qmp-qserdes-com-v5.h    | 124 ++++++++++
 .../phy/qcom/phy-qcom-qmp-qserdes-txrx-v5.h   | 231 ++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           | 171 +++++++++++++
 3 files changed, 526 insertions(+)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v5.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5.h

diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v5.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v5.h
new file mode 100644
index 0000000000..c8afdf7bc1
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v5.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_COM_V5_H_
+#define QCOM_PHY_QMP_QSERDES_COM_V5_H_
+
+/* Only for QMP V5 PHY - QSERDES COM registers */
+#define QSERDES_V5_COM_ATB_SEL1				0x000
+#define QSERDES_V5_COM_ATB_SEL2				0x004
+#define QSERDES_V5_COM_FREQ_UPDATE			0x008
+#define QSERDES_V5_COM_BG_TIMER				0x00c
+#define QSERDES_V5_COM_SSC_EN_CENTER			0x010
+#define QSERDES_V5_COM_SSC_ADJ_PER1			0x014
+#define QSERDES_V5_COM_SSC_ADJ_PER2			0x018
+#define QSERDES_V5_COM_SSC_PER1				0x01c
+#define QSERDES_V5_COM_SSC_PER2				0x020
+#define QSERDES_V5_COM_SSC_STEP_SIZE1_MODE0		0x024
+#define QSERDES_V5_COM_SSC_STEP_SIZE2_MODE0		0x028
+#define QSERDES_V5_COM_SSC_STEP_SIZE3_MODE0		0x02c
+#define QSERDES_V5_COM_SSC_STEP_SIZE1_MODE1		0x030
+#define QSERDES_V5_COM_SSC_STEP_SIZE2_MODE1		0x034
+#define QSERDES_V5_COM_SSC_STEP_SIZE3_MODE1		0x038
+#define QSERDES_V5_COM_POST_DIV				0x03c
+#define QSERDES_V5_COM_POST_DIV_MUX			0x040
+#define QSERDES_V5_COM_BIAS_EN_CLKBUFLR_EN		0x044
+#define QSERDES_V5_COM_CLK_ENABLE1			0x048
+#define QSERDES_V5_COM_SYS_CLK_CTRL			0x04c
+#define QSERDES_V5_COM_SYSCLK_BUF_ENABLE		0x050
+#define QSERDES_V5_COM_PLL_EN				0x054
+#define QSERDES_V5_COM_PLL_IVCO				0x058
+#define QSERDES_V5_COM_CMN_IETRIM			0x05c
+#define QSERDES_V5_COM_CMN_IPTRIM			0x060
+#define QSERDES_V5_COM_EP_CLOCK_DETECT_CTRL		0x064
+#define QSERDES_V5_COM_SYSCLK_DET_COMP_STATUS		0x068
+#define QSERDES_V5_COM_CLK_EP_DIV_MODE0			0x06c
+#define QSERDES_V5_COM_CLK_EP_DIV_MODE1			0x070
+#define QSERDES_V5_COM_CP_CTRL_MODE0			0x074
+#define QSERDES_V5_COM_CP_CTRL_MODE1			0x078
+#define QSERDES_V5_COM_PLL_RCTRL_MODE0			0x07c
+#define QSERDES_V5_COM_PLL_RCTRL_MODE1			0x080
+#define QSERDES_V5_COM_PLL_CCTRL_MODE0			0x084
+#define QSERDES_V5_COM_PLL_CCTRL_MODE1			0x088
+#define QSERDES_V5_COM_PLL_CNTRL			0x08c
+#define QSERDES_V5_COM_BIAS_EN_CTRL_BY_PSM		0x090
+#define QSERDES_V5_COM_SYSCLK_EN_SEL			0x094
+#define QSERDES_V5_COM_CML_SYSCLK_SEL			0x098
+#define QSERDES_V5_COM_RESETSM_CNTRL			0x09c
+#define QSERDES_V5_COM_RESETSM_CNTRL2			0x0a0
+#define QSERDES_V5_COM_LOCK_CMP_EN			0x0a4
+#define QSERDES_V5_COM_LOCK_CMP_CFG			0x0a8
+#define QSERDES_V5_COM_LOCK_CMP1_MODE0			0x0ac
+#define QSERDES_V5_COM_LOCK_CMP2_MODE0			0x0b0
+#define QSERDES_V5_COM_LOCK_CMP1_MODE1			0x0b4
+#define QSERDES_V5_COM_LOCK_CMP2_MODE1			0x0b8
+#define QSERDES_V5_COM_DEC_START_MODE0			0x0bc
+#define QSERDES_V5_COM_DEC_START_MSB_MODE0		0x0c0
+#define QSERDES_V5_COM_DEC_START_MODE1			0x0c4
+#define QSERDES_V5_COM_DEC_START_MSB_MODE1		0x0c8
+#define QSERDES_V5_COM_DIV_FRAC_START1_MODE0		0x0cc
+#define QSERDES_V5_COM_DIV_FRAC_START2_MODE0		0x0d0
+#define QSERDES_V5_COM_DIV_FRAC_START3_MODE0		0x0d4
+#define QSERDES_V5_COM_DIV_FRAC_START1_MODE1		0x0d8
+#define QSERDES_V5_COM_DIV_FRAC_START2_MODE1		0x0dc
+#define QSERDES_V5_COM_DIV_FRAC_START3_MODE1		0x0e0
+#define QSERDES_V5_COM_INTEGLOOP_INITVAL		0x0e4
+#define QSERDES_V5_COM_INTEGLOOP_EN			0x0e8
+#define QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE0		0x0ec
+#define QSERDES_V5_COM_INTEGLOOP_GAIN1_MODE0		0x0f0
+#define QSERDES_V5_COM_INTEGLOOP_GAIN0_MODE1		0x0f4
+#define QSERDES_V5_COM_INTEGLOOP_GAIN1_MODE1		0x0f8
+#define QSERDES_V5_COM_INTEGLOOP_P_PATH_GAIN0		0x0fc
+#define QSERDES_V5_COM_INTEGLOOP_P_PATH_GAIN1		0x100
+#define QSERDES_V5_COM_VCOCAL_DEADMAN_CTRL		0x104
+#define QSERDES_V5_COM_VCO_TUNE_CTRL			0x108
+#define QSERDES_V5_COM_VCO_TUNE_MAP			0x10c
+#define QSERDES_V5_COM_VCO_TUNE1_MODE0			0x110
+#define QSERDES_V5_COM_VCO_TUNE2_MODE0			0x114
+#define QSERDES_V5_COM_VCO_TUNE1_MODE1			0x118
+#define QSERDES_V5_COM_VCO_TUNE2_MODE1			0x11c
+#define QSERDES_V5_COM_VCO_TUNE_INITVAL1		0x120
+#define QSERDES_V5_COM_VCO_TUNE_INITVAL2		0x124
+#define QSERDES_V5_COM_VCO_TUNE_MINVAL1			0x128
+#define QSERDES_V5_COM_VCO_TUNE_MINVAL2			0x12c
+#define QSERDES_V5_COM_VCO_TUNE_MAXVAL1			0x130
+#define QSERDES_V5_COM_VCO_TUNE_MAXVAL2			0x134
+#define QSERDES_V5_COM_VCO_TUNE_TIMER1			0x138
+#define QSERDES_V5_COM_VCO_TUNE_TIMER2			0x13c
+#define QSERDES_V5_COM_CMN_STATUS			0x140
+#define QSERDES_V5_COM_RESET_SM_STATUS			0x144
+#define QSERDES_V5_COM_RESTRIM_CODE_STATUS		0x148
+#define QSERDES_V5_COM_PLLCAL_CODE1_STATUS		0x14c
+#define QSERDES_V5_COM_PLLCAL_CODE2_STATUS		0x150
+#define QSERDES_V5_COM_CLK_SELECT			0x154
+#define QSERDES_V5_COM_HSCLK_SEL			0x158
+#define QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL		0x15c
+#define QSERDES_V5_COM_INTEGLOOP_BINCODE_STATUS		0x160
+#define QSERDES_V5_COM_PLL_ANALOG			0x164
+#define QSERDES_V5_COM_CORECLK_DIV_MODE0		0x168
+#define QSERDES_V5_COM_CORECLK_DIV_MODE1		0x16c
+#define QSERDES_V5_COM_SW_RESET				0x170
+#define QSERDES_V5_COM_CORE_CLK_EN			0x174
+#define QSERDES_V5_COM_C_READY_STATUS			0x178
+#define QSERDES_V5_COM_CMN_CONFIG			0x17c
+#define QSERDES_V5_COM_CMN_RATE_OVERRIDE		0x180
+#define QSERDES_V5_COM_SVS_MODE_CLK_SEL			0x184
+#define QSERDES_V5_COM_DEBUG_BUS0			0x188
+#define QSERDES_V5_COM_DEBUG_BUS1			0x18c
+#define QSERDES_V5_COM_DEBUG_BUS2			0x190
+#define QSERDES_V5_COM_DEBUG_BUS3			0x194
+#define QSERDES_V5_COM_DEBUG_BUS_SEL			0x198
+#define QSERDES_V5_COM_CMN_MISC1			0x19c
+#define QSERDES_V5_COM_CMN_MODE				0x1a0
+#define QSERDES_V5_COM_CMN_MODE_CONTD			0x1a4
+#define QSERDES_V5_COM_VCO_DC_LEVEL_CTRL		0x1a8
+#define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x1ac
+#define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x1b0
+#define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE1	0x1b4
+#define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE1	0x1b8
+#define QSERDES_V5_COM_BIN_VCOCAL_HSCLK_SEL		0x1bc
+#define QSERDES_V5_COM_RESERVED_1			0x1c0
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5.h b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5.h
new file mode 100644
index 0000000000..fe8f3e330d
--- /dev/null
+++ b/drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5.h
@@ -0,0 +1,231 @@
+
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2017, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef QCOM_PHY_QMP_QSERDES_TXRX_V5_H_
+#define QCOM_PHY_QMP_QSERDES_TXRX_V5_H_
+
+/* Only for QMP V5 PHY - TX registers */
+#define QSERDES_V5_TX_BIST_MODE_LANENO			0x000
+#define QSERDES_V5_TX_BIST_INVERT			0x004
+#define QSERDES_V5_TX_CLKBUF_ENABLE			0x008
+#define QSERDES_V5_TX_TX_EMP_POST1_LVL			0x00c
+#define QSERDES_V5_TX_TX_IDLE_LVL_LARGE_AMP		0x010
+#define QSERDES_V5_TX_TX_DRV_LVL			0x014
+#define QSERDES_V5_TX_TX_DRV_LVL_OFFSET			0x018
+#define QSERDES_V5_TX_RESET_TSYNC_EN			0x01c
+#define QSERDES_V5_TX_PRE_STALL_LDO_BOOST_EN		0x020
+#define QSERDES_V5_TX_TX_BAND				0x024
+#define QSERDES_V5_TX_SLEW_CNTL				0x028
+#define QSERDES_V5_TX_INTERFACE_SELECT			0x02c
+#define QSERDES_V5_TX_LPB_EN				0x030
+#define QSERDES_V5_TX_RES_CODE_LANE_TX			0x034
+#define QSERDES_V5_TX_RES_CODE_LANE_RX			0x038
+#define QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX		0x03c
+#define QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX		0x040
+#define QSERDES_V5_TX_PERL_LENGTH1			0x044
+#define QSERDES_V5_TX_PERL_LENGTH2			0x048
+#define QSERDES_V5_TX_SERDES_BYP_EN_OUT			0x04c
+#define QSERDES_V5_TX_DEBUG_BUS_SEL			0x050
+#define QSERDES_V5_TX_TRANSCEIVER_BIAS_EN		0x054
+#define QSERDES_V5_TX_HIGHZ_DRVR_EN			0x058
+#define QSERDES_V5_TX_TX_POL_INV			0x05c
+#define QSERDES_V5_TX_PARRATE_REC_DETECT_IDLE_EN	0x060
+#define QSERDES_V5_TX_BIST_PATTERN1			0x064
+#define QSERDES_V5_TX_BIST_PATTERN2			0x068
+#define QSERDES_V5_TX_BIST_PATTERN3			0x06c
+#define QSERDES_V5_TX_BIST_PATTERN4			0x070
+#define QSERDES_V5_TX_BIST_PATTERN5			0x074
+#define QSERDES_V5_TX_BIST_PATTERN6			0x078
+#define QSERDES_V5_TX_BIST_PATTERN7			0x07c
+#define QSERDES_V5_TX_BIST_PATTERN8			0x080
+#define QSERDES_V5_TX_LANE_MODE_1			0x084
+#define QSERDES_V5_TX_LANE_MODE_2			0x088
+#define QSERDES_V5_TX_LANE_MODE_3			0x08c
+#define QSERDES_V5_TX_LANE_MODE_4			0x090
+#define QSERDES_V5_TX_LANE_MODE_5			0x094
+#define QSERDES_V5_TX_ATB_SEL1				0x098
+#define QSERDES_V5_TX_ATB_SEL2				0x09c
+#define QSERDES_V5_TX_RCV_DETECT_LVL			0x0a0
+#define QSERDES_V5_TX_RCV_DETECT_LVL_2			0x0a4
+#define QSERDES_V5_TX_PRBS_SEED1			0x0a8
+#define QSERDES_V5_TX_PRBS_SEED2			0x0ac
+#define QSERDES_V5_TX_PRBS_SEED3			0x0b0
+#define QSERDES_V5_TX_PRBS_SEED4			0x0b4
+#define QSERDES_V5_TX_RESET_GEN				0x0b8
+#define QSERDES_V5_TX_RESET_GEN_MUXES			0x0bc
+#define QSERDES_V5_TX_TRAN_DRVR_EMP_EN			0x0c0
+#define QSERDES_V5_TX_TX_INTERFACE_MODE			0x0c4
+#define QSERDES_V5_TX_VMODE_CTRL1			0x0c8
+#define QSERDES_V5_TX_ALOG_OBSV_BUS_CTRL_1		0x0cc
+#define QSERDES_V5_TX_BIST_STATUS			0x0d0
+#define QSERDES_V5_TX_BIST_ERROR_COUNT1			0x0d4
+#define QSERDES_V5_TX_BIST_ERROR_COUNT2			0x0d8
+#define QSERDES_V5_TX_ALOG_OBSV_BUS_STATUS_1		0x0dc
+#define QSERDES_V5_TX_LANE_DIG_CONFIG			0x0e0
+#define QSERDES_V5_TX_PI_QEC_CTRL			0x0e4
+#define QSERDES_V5_TX_PRE_EMPH				0x0e8
+#define QSERDES_V5_TX_SW_RESET				0x0ec
+#define QSERDES_V5_TX_DCC_OFFSET			0x0f0
+#define QSERDES_V5_TX_DCC_CMUX_POSTCAL_OFFSET		0x0f4
+#define QSERDES_V5_TX_DCC_CMUX_CAL_CTRL1		0x0f8
+#define QSERDES_V5_TX_DCC_CMUX_CAL_CTRL2		0x0fc
+#define QSERDES_V5_TX_DIG_BKUP_CTRL			0x100
+#define QSERDES_V5_TX_DEBUG_BUS0			0x104
+#define QSERDES_V5_TX_DEBUG_BUS1			0x108
+#define QSERDES_V5_TX_DEBUG_BUS2			0x10c
+#define QSERDES_V5_TX_DEBUG_BUS3			0x110
+#define QSERDES_V5_TX_READ_EQCODE			0x114
+#define QSERDES_V5_TX_READ_OFFSETCODE			0x118
+#define QSERDES_V5_TX_IA_ERROR_COUNTER_LOW		0x11c
+#define QSERDES_V5_TX_IA_ERROR_COUNTER_HIGH		0x120
+#define QSERDES_V5_TX_VGA_READ_CODE			0x124
+#define QSERDES_V5_TX_VTH_READ_CODE			0x128
+#define QSERDES_V5_TX_DFE_TAP1_READ_CODE		0x12c
+#define QSERDES_V5_TX_DFE_TAP2_READ_CODE		0x130
+#define QSERDES_V5_TX_IDAC_STATUS_I			0x134
+#define QSERDES_V5_TX_IDAC_STATUS_IBAR			0x138
+#define QSERDES_V5_TX_IDAC_STATUS_Q			0x13c
+#define QSERDES_V5_TX_IDAC_STATUS_QBAR			0x140
+#define QSERDES_V5_TX_IDAC_STATUS_A			0x144
+#define QSERDES_V5_TX_IDAC_STATUS_ABAR			0x148
+#define QSERDES_V5_TX_IDAC_STATUS_SM_ON			0x14c
+#define QSERDES_V5_TX_IDAC_STATUS_CAL_DONE		0x150
+#define QSERDES_V5_TX_IDAC_STATUS_SIGNERROR		0x154
+#define QSERDES_V5_TX_DCC_CAL_STATUS			0x158
+#define QSERDES_V5_TX_DCC_READ_CODE_STATUS		0x15c
+
+/* Only for QMP V5 PHY - RX registers */
+#define QSERDES_V5_RX_UCDR_FO_GAIN_HALF			0x000
+#define QSERDES_V5_RX_UCDR_FO_GAIN_QUARTER		0x004
+#define QSERDES_V5_RX_UCDR_FO_GAIN			0x008
+#define QSERDES_V5_RX_UCDR_SO_GAIN_HALF			0x00c
+#define QSERDES_V5_RX_UCDR_SO_GAIN_QUARTER		0x010
+#define QSERDES_V5_RX_UCDR_SO_GAIN			0x014
+#define QSERDES_V5_RX_UCDR_SVS_FO_GAIN_HALF		0x018
+#define QSERDES_V5_RX_UCDR_SVS_FO_GAIN_QUARTER		0x01c
+#define QSERDES_V5_RX_UCDR_SVS_FO_GAIN			0x020
+#define QSERDES_V5_RX_UCDR_SVS_SO_GAIN_HALF		0x024
+#define QSERDES_V5_RX_UCDR_SVS_SO_GAIN_QUARTER		0x028
+#define QSERDES_V5_RX_UCDR_SVS_SO_GAIN			0x02c
+#define QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN		0x030
+#define QSERDES_V5_RX_UCDR_SO_SATURATION_AND_ENABLE	0x034
+#define QSERDES_V5_RX_UCDR_FO_TO_SO_DELAY		0x038
+#define QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW		0x03c
+#define QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_HIGH		0x040
+#define QSERDES_V5_RX_UCDR_PI_CONTROLS			0x044
+#define QSERDES_V5_RX_UCDR_PI_CTRL2			0x048
+#define QSERDES_V5_RX_UCDR_SB2_THRESH1			0x04c
+#define QSERDES_V5_RX_UCDR_SB2_THRESH2			0x050
+#define QSERDES_V5_RX_UCDR_SB2_GAIN1			0x054
+#define QSERDES_V5_RX_UCDR_SB2_GAIN2			0x058
+#define QSERDES_V5_RX_AUX_CONTROL			0x05c
+#define QSERDES_V5_RX_AUX_DATA_TCOARSE_TFINE		0x060
+#define QSERDES_V5_RX_RCLK_AUXDATA_SEL			0x064
+#define QSERDES_V5_RX_AC_JTAG_ENABLE			0x068
+#define QSERDES_V5_RX_AC_JTAG_INITP			0x06c
+#define QSERDES_V5_RX_AC_JTAG_INITN			0x070
+#define QSERDES_V5_RX_AC_JTAG_LVL			0x074
+#define QSERDES_V5_RX_AC_JTAG_MODE			0x078
+#define QSERDES_V5_RX_AC_JTAG_RESET			0x07c
+#define QSERDES_V5_RX_RX_TERM_BW			0x080
+#define QSERDES_V5_RX_RX_RCVR_IQ_EN			0x084
+#define QSERDES_V5_RX_RX_IDAC_I_DC_OFFSETS		0x088
+#define QSERDES_V5_RX_RX_IDAC_IBAR_DC_OFFSETS		0x08c
+#define QSERDES_V5_RX_RX_IDAC_Q_DC_OFFSETS		0x090
+#define QSERDES_V5_RX_RX_IDAC_QBAR_DC_OFFSETS		0x094
+#define QSERDES_V5_RX_RX_IDAC_A_DC_OFFSETS		0x098
+#define QSERDES_V5_RX_RX_IDAC_ABAR_DC_OFFSETS		0x09c
+#define QSERDES_V5_RX_RX_IDAC_EN			0x0a0
+#define QSERDES_V5_RX_RX_IDAC_ENABLES			0x0a4
+#define QSERDES_V5_RX_RX_IDAC_SIGN			0x0a8
+#define QSERDES_V5_RX_RX_HIGHZ_HIGHRATE			0x0ac
+#define QSERDES_V5_RX_RX_TERM_AC_BYPASS_DC_COUPLE_OFFSET 0x0b0
+#define QSERDES_V5_RX_DFE_1				0x0b4
+#define QSERDES_V5_RX_DFE_2				0x0b8
+#define QSERDES_V5_RX_DFE_3				0x0bc
+#define QSERDES_V5_RX_DFE_4				0x0c0
+#define QSERDES_V5_RX_TX_ADAPT_PRE_THRESH1		0x0c4
+#define QSERDES_V5_RX_TX_ADAPT_PRE_THRESH2		0x0c8
+#define QSERDES_V5_RX_TX_ADAPT_POST_THRESH		0x0cc
+#define QSERDES_V5_RX_TX_ADAPT_MAIN_THRESH		0x0d0
+#define QSERDES_V5_RX_VGA_CAL_CNTRL1			0x0d4
+#define QSERDES_V5_RX_VGA_CAL_CNTRL2			0x0d8
+#define QSERDES_V5_RX_GM_CAL				0x0dc
+#define QSERDES_V5_RX_RX_VGA_GAIN2_LSB			0x0e0
+#define QSERDES_V5_RX_RX_VGA_GAIN2_MSB			0x0e4
+#define QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL1		0x0e8
+#define QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2		0x0ec
+#define QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL3		0x0f0
+#define QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4		0x0f4
+#define QSERDES_V5_RX_RX_IDAC_TSETTLE_LOW		0x0f8
+#define QSERDES_V5_RX_RX_IDAC_TSETTLE_HIGH		0x0fc
+#define QSERDES_V5_RX_RX_IDAC_MEASURE_TIME		0x100
+#define QSERDES_V5_RX_RX_IDAC_ACCUMULATOR		0x104
+#define QSERDES_V5_RX_RX_EQ_OFFSET_LSB			0x108
+#define QSERDES_V5_RX_RX_EQ_OFFSET_MSB			0x10c
+#define QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1	0x110
+#define QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2		0x114
+#define QSERDES_V5_RX_SIGDET_ENABLES			0x118
+#define QSERDES_V5_RX_SIGDET_CNTRL			0x11c
+#define QSERDES_V5_RX_SIGDET_LVL			0x120
+#define QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL		0x124
+#define QSERDES_V5_RX_RX_BAND				0x128
+#define QSERDES_V5_RX_CDR_FREEZE_UP_DN			0x12c
+#define QSERDES_V5_RX_CDR_RESET_OVERRIDE		0x130
+#define QSERDES_V5_RX_RX_INTERFACE_MODE			0x134
+#define QSERDES_V5_RX_JITTER_GEN_MODE			0x138
+#define QSERDES_V5_RX_SJ_AMP1				0x13c
+#define QSERDES_V5_RX_SJ_AMP2				0x140
+#define QSERDES_V5_RX_SJ_PER1				0x144
+#define QSERDES_V5_RX_SJ_PER2				0x148
+#define QSERDES_V5_RX_PPM_OFFSET1			0x14c
+#define QSERDES_V5_RX_PPM_OFFSET2			0x150
+#define QSERDES_V5_RX_SIGN_PPM_PERIOD1			0x154
+#define QSERDES_V5_RX_SIGN_PPM_PERIOD2			0x158
+#define QSERDES_V5_RX_RX_MODE_00_LOW			0x15c
+#define QSERDES_V5_RX_RX_MODE_00_HIGH			0x160
+#define QSERDES_V5_RX_RX_MODE_00_HIGH2			0x164
+#define QSERDES_V5_RX_RX_MODE_00_HIGH3			0x168
+#define QSERDES_V5_RX_RX_MODE_00_HIGH4			0x16c
+#define QSERDES_V5_RX_RX_MODE_01_LOW			0x170
+#define QSERDES_V5_RX_RX_MODE_01_HIGH			0x174
+#define QSERDES_V5_RX_RX_MODE_01_HIGH2			0x178
+#define QSERDES_V5_RX_RX_MODE_01_HIGH3			0x17c
+#define QSERDES_V5_RX_RX_MODE_01_HIGH4			0x180
+#define QSERDES_V5_RX_RX_MODE_10_LOW			0x184
+#define QSERDES_V5_RX_RX_MODE_10_HIGH			0x188
+#define QSERDES_V5_RX_RX_MODE_10_HIGH2			0x18c
+#define QSERDES_V5_RX_RX_MODE_10_HIGH3			0x190
+#define QSERDES_V5_RX_RX_MODE_10_HIGH4			0x194
+#define QSERDES_V5_RX_PHPRE_CTRL			0x198
+#define QSERDES_V5_RX_PHPRE_INITVAL			0x19c
+#define QSERDES_V5_RX_DFE_EN_TIMER			0x1a0
+#define QSERDES_V5_RX_DFE_CTLE_POST_CAL_OFFSET		0x1a4
+#define QSERDES_V5_RX_DCC_CTRL1				0x1a8
+#define QSERDES_V5_RX_DCC_CTRL2				0x1ac
+#define QSERDES_V5_RX_VTH_CODE				0x1b0
+#define QSERDES_V5_RX_VTH_MIN_THRESH			0x1b4
+#define QSERDES_V5_RX_VTH_MAX_THRESH			0x1b8
+#define QSERDES_V5_RX_ALOG_OBSV_BUS_CTRL_1		0x1bc
+#define QSERDES_V5_RX_PI_CTRL1				0x1c0
+#define QSERDES_V5_RX_PI_CTRL2				0x1c4
+#define QSERDES_V5_RX_PI_QUAD				0x1c8
+#define QSERDES_V5_RX_IDATA1				0x1cc
+#define QSERDES_V5_RX_IDATA2				0x1d0
+#define QSERDES_V5_RX_AUX_DATA1				0x1d4
+#define QSERDES_V5_RX_AUX_DATA2				0x1d8
+#define QSERDES_V5_RX_AC_JTAG_OUTP			0x1dc
+#define QSERDES_V5_RX_AC_JTAG_OUTN			0x1e0
+#define QSERDES_V5_RX_RX_SIGDET				0x1e4
+#define QSERDES_V5_RX_ALOG_OBSV_BUS_STATUS_1		0x1e8
+
+/* Only for QMP V5 UFS ? */
+#define QSERDES_V5_TX_PWM_GEAR_1_DIVIDER_BAND0_1	0x178
+#define QSERDES_V5_TX_PWM_GEAR_2_DIVIDER_BAND0_1	0x17c
+#define QSERDES_V5_TX_PWM_GEAR_3_DIVIDER_BAND0_1	0x180
+#define QSERDES_V5_TX_PWM_GEAR_4_DIVIDER_BAND0_1	0x184
+
+#endif
diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
index 5c90d60e7d..449b976777 100644
--- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
+++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
@@ -33,8 +33,10 @@
 #include "phy-qcom-qmp-pcs-ufs-v6.h"
 
 #include "phy-qcom-qmp-qserdes-com-v4.h"
+#include "phy-qcom-qmp-qserdes-com-v5.h"
 #include "phy-qcom-qmp-qserdes-com-v6.h"
 #include "phy-qcom-qmp-qserdes-txrx-v4.h"
+#include "phy-qcom-qmp-qserdes-txrx-v5.h"
 #include "phy-qcom-qmp-qserdes-txrx-ufs-v6.h"
 
 /* QPHY_SW_RESET bit */
@@ -97,6 +99,13 @@ static const unsigned int ufsphy_v4_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V4_PCS_UFS_POWER_DOWN_CONTROL,
 };
 
+static const unsigned int ufsphy_v5_regs_layout[QPHY_LAYOUT_SIZE] = {
+	[QPHY_START_CTRL]		= QPHY_V5_PCS_UFS_PHY_START,
+	[QPHY_PCS_READY_STATUS]		= QPHY_V5_PCS_UFS_READY_STATUS,
+	[QPHY_SW_RESET]			= QPHY_V5_PCS_UFS_SW_RESET,
+	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V5_PCS_UFS_POWER_DOWN_CONTROL,
+};
+
 static const unsigned int ufsphy_v6_regs_layout[QPHY_LAYOUT_SIZE] = {
 	[QPHY_START_CTRL]		= QPHY_V6_PCS_UFS_PHY_START,
 	[QPHY_PCS_READY_STATUS]		= QPHY_V6_PCS_UFS_READY_STATUS,
@@ -458,6 +467,128 @@ static const struct qmp_ufs_init_tbl sm8650_ufsphy_rx[] = {
 	QMP_PHY_INIT_CFG(QSERDES_UFS_V6_RX_DLL0_FTUNE_CTRL, 0x30),
 };
 
+static const struct qmp_ufs_init_tbl sm8350_ufsphy_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_SYSCLK_EN_SEL, 0xd9),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_SEL, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_HSCLK_HS_SWITCH_SEL, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP_EN, 0x42),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x02),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_IVCO, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_INITVAL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_HSCLK_SEL, 0x11),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE0, 0x82),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE0, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE0, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE0, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE0, 0xff),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE0, 0x19),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE0, 0xac),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE0, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_DEC_START_MODE1, 0x98),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_CP_CTRL_MODE1, 0x14),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_RCTRL_MODE1, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_PLL_CCTRL_MODE1, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP1_MODE1, 0x65),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_LOCK_CMP2_MODE1, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE1, 0xdd),
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE1, 0x23),
+};
+
+static const struct qmp_ufs_init_tbl sm8350_ufsphy_hs_b_serdes[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_COM_VCO_TUNE_MAP, 0x06),
+};
+
+static const struct qmp_ufs_init_tbl sm8350_ufsphy_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_1_DIVIDER_BAND0_1, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_2_DIVIDER_BAND0_1, 0x03),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_3_DIVIDER_BAND0_1, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_PWM_GEAR_4_DIVIDER_BAND0_1, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xf5),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_3, 0x3f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_TX, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_RES_CODE_LANE_OFFSET_RX, 0x09),
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_TRAN_DRVR_EMP_EN, 0x0c),
+};
+
+static const struct qmp_ufs_init_tbl sm8350_ufsphy_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_LVL, 0x24),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_CNTRL, 0x0f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_SIGDET_DEGLITCH_CNTRL, 0x1e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_BAND, 0x18),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_FO_GAIN, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_SATURATION_AND_ENABLE, 0x5a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CONTROLS, 0xf1),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FASTLOCK_COUNT_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CTRL2, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_FO_GAIN, 0x0e),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_SO_GAIN, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_TERM_BW, 0x1b),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL1, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x06),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL3, 0x04),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x1a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQ_OFFSET_ADAPTOR_CNTRL1, 0x17),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_OFFSET_ADAPTOR_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_IDAC_MEASURE_TIME, 0x10),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_IDAC_TSETTLE_LOW, 0xc0),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_IDAC_TSETTLE_HIGH, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0x3c),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0xe0),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0xb7),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_10_LOW, 0xe0),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_10_HIGH, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_10_HIGH2, 0xc8),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_10_HIGH3, 0x3b),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_10_HIGH4, 0xb7),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_DCC_CTRL1, 0x0c),
+};
+
+static const struct qmp_ufs_init_tbl sm8350_ufsphy_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_RX_SIGDET_CTRL2, 0x6d),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_LARGE_AMP_DRV_LVL, 0x0a),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_SMALL_AMP_DRV_LVL, 0x02),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_DEBUG_BUS_CLKSEL, 0x1f),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_RX_MIN_HIBERN8_TIME, 0xff),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_RX_SIGDET_CTRL1, 0x0e),
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
+};
+
+static const struct qmp_ufs_init_tbl sm8350_ufsphy_g4_tx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_TX_LANE_MODE_1, 0xe5),
+};
+
+static const struct qmp_ufs_init_tbl sm8350_ufsphy_g4_rx[] = {
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_UCDR_PI_CTRL2, 0x81),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_TERM_BW, 0x6f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL2, 0x00),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL3, 0x4a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_EQU_ADAPTOR_CNTRL4, 0x0a),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_IDAC_MEASURE_TIME, 0x20),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_IDAC_TSETTLE_LOW, 0x80),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_IDAC_TSETTLE_HIGH, 0x01),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_LOW, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH, 0xbf),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH2, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH3, 0x7f),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_00_HIGH4, 0x2d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_LOW, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH, 0x6d),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH2, 0xed),
+	QMP_PHY_INIT_CFG(QSERDES_V5_RX_RX_MODE_01_HIGH4, 0x3c),
+};
+
+static const struct qmp_ufs_init_tbl sm8350_ufsphy_g4_pcs[] = {
+	QMP_PHY_INIT_CFG(QPHY_V5_PCS_UFS_BIST_FIXED_PAT_CTRL, 0x0a),
+};
+
 static const struct qmp_ufs_init_tbl sm8650_ufsphy_pcs[] = {
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_MULTI_LANE_CTRL1, 0x02),
 	QMP_PHY_INIT_CFG(QPHY_V6_PCS_UFS_TX_MID_TERM_CTRL1, 0x43),
@@ -690,6 +821,11 @@ static const char * const sdm845_ufs_phy_clk_l[] = {
 	"ref", "ref_aux",
 };
 
+/* the primary usb3 phy on sm8250 doesn't have a ref clock */
+static const char * const sm8450_ufs_phy_clk_l[] = {
+	"qref", "ref", "ref_aux",
+};
+
 /* list of regulators */
 static const char * const qmp_ufs_vreg_l[] = {
 	"vdda-phy", "vdda-pll",
@@ -909,6 +1045,40 @@ static const struct qmp_ufs_cfg sc7280_ufsphy_cfg = {
 	.regs			= ufsphy_v4_regs_layout,
 };
 
+static const struct qmp_ufs_cfg sa8775p_ufsphy_cfg = {
+	.lanes			= 2,
+
+	.offsets		= &qmp_ufs_offsets,
+
+	.tbls = {
+		.serdes		= sm8350_ufsphy_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_serdes),
+		.tx		= sm8350_ufsphy_tx,
+		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_tx),
+		.rx		= sm8350_ufsphy_rx,
+		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_rx),
+		.pcs		= sm8350_ufsphy_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_pcs),
+	},
+	.tbls_hs_b = {
+		.serdes		= sm8350_ufsphy_hs_b_serdes,
+		.serdes_num	= ARRAY_SIZE(sm8350_ufsphy_hs_b_serdes),
+	},
+	.tbls_hs_g4 = {
+		.tx		= sm8350_ufsphy_g4_tx,
+		.tx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_tx),
+		.rx		= sm8350_ufsphy_g4_rx,
+		.rx_num		= ARRAY_SIZE(sm8350_ufsphy_g4_rx),
+		.pcs		= sm8350_ufsphy_g4_pcs,
+		.pcs_num	= ARRAY_SIZE(sm8350_ufsphy_g4_pcs),
+	},
+	.clk_list               = sm8450_ufs_phy_clk_l,
+	.num_clks               = ARRAY_SIZE(sm8450_ufs_phy_clk_l),
+	.vreg_list		= qmp_ufs_vreg_l,
+	.num_vregs		= ARRAY_SIZE(qmp_ufs_vreg_l),
+	.regs			= ufsphy_v5_regs_layout,
+};
+
 static void qmp_ufs_configure_lane(void __iomem *base,
 					const struct qmp_ufs_init_tbl tbl[],
 					int num,
@@ -1295,6 +1465,7 @@ static struct phy_ops qmp_ufs_ops = {
 };
 
 static const struct udevice_id qmp_ufs_ids[] = {
+	{ .compatible = "qcom,sa8775p-qmp-ufs-phy", .data = (ulong)&sa8775p_ufsphy_cfg, },
 	{ .compatible = "qcom,sdm845-qmp-ufs-phy", .data = (ulong)&sdm845_ufsphy_cfg },
 	{ .compatible = "qcom,sm8150-qmp-ufs-phy", .data = (ulong)&sm8150_ufsphy_cfg },
 	{ .compatible = "qcom,sm8250-qmp-ufs-phy", .data = (ulong)&sm8250_ufsphy_cfg },
-- 
2.34.1

