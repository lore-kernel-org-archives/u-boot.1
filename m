Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6807CCD6E79
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 12:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EBA984951;
	Fri,  5 Jun 2026 14:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6i0c98G";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D1nwAuUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE04848A1; Fri,  5 Jun 2026 11:48:30 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 285768486D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 11:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=oss.qualcomm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=badhrinath.s@oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6558jvPn3603708
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 09:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=f5+JopMSwB9
 7XMQvWbStp8jcceNL6olkVzUd2Pybu2Q=; b=C6i0c98GqcZ4N8jwE1jrBmYEC9X
 jcZv58iUtbMbHp/ziD8IT23bzWbhUZCG5+qTmJsYWnDDexksv5JOgN8UT+eDZJGE
 Kj6vsWL8vHaSNpUE5VEBsmDhUpIvUiLKGVOm0Hxi8MpRAbgEFXKFTiTmQpfaU5UY
 A8H/jOhIER5l+RdQpFu+8qqL7L9dUSg7PVNLqpqKByT8TMQvklT5sbjl33Axo+eX
 vxeTfmKGmY4CfyfNfxRuHr8/kGC8cXZfxGDr43L95/tdrZfX4fE1f3u060WB9THE
 dwnLs1mlLHlujcuuMECZXOdcgmfAlt9ktjlKv/2KW1/VDlGXDk+nqJ9SNhA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekmhf9rrk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 09:48:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36bbcd40642so1365381a91.0
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 02:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780652905; x=1781257705; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f5+JopMSwB97XMQvWbStp8jcceNL6olkVzUd2Pybu2Q=;
 b=D1nwAuUuJvzo+ZNe5J6y+pVb/bmsmcmNsMDXmE1dSUoZMuGduLZ29eC0SqQiW589iJ
 Ucar7H73uyu0Q3SMAigZSnWyy3/cUMO9FsrMmkWo30l1DtscPzzsZJ/PfbLfrPwtnD3S
 UQoHTInn6jVTxZ7D+HsHcoPBRD145bG91vz9qMGdSUIPiAbhAOPUIk9Ovlp0sY/PJto3
 6Y0WeDpTHq9JVv38MXFSQrfU3rCvFRHm0se17GMrKeWX/+zvFq6m2zi4WQqpM/e+deY0
 b7f+tOjKiFtod0Ci1fb5ENHg6PZNYJQQnB0eVPDFG8cree9ftGX/SGTcAWtq7sk8WPCp
 FfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780652905; x=1781257705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f5+JopMSwB97XMQvWbStp8jcceNL6olkVzUd2Pybu2Q=;
 b=CFJRGlRvvu9Xg4lbzCBCMSRj6qV3nwkMz73dvGBF+AvrVchP+gQh6tOoiped8i5loo
 ZWrT3t+PFjWLpa9lD7Pv+h3iMOP+aesbDSp+CPBn9SnJW6E4OAgr0f9746m+PTlJkmUV
 Qs2kCpnAwzakYKsFnEuydSRoCQ3rHYbGj6XQ6i0TuFz2NYhrwN67s2MJB86VP/oUMDlx
 9vBC4NUwJ9Ix7Gl6LiKgklnQH9wPJnG55eNX1oBO0Z9xCym7+jWD2JqfUM5XEc0OqMhp
 SXSDZVRrrJPJIcRvFgJDT4Xhb9UDOnlLqLFOafVwyQoQsl6nrRmtchJkoKbFTSTE1DBG
 cwdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4EQOZlFtvOwWJu3dKblTouIY47YzYMbb+31fZlhZc5jyV3TYt3bpamBRVYqXzk/ViuPCgunM=@lists.denx.de
X-Gm-Message-State: AOJu0YyERHktak2wImU4HOE3/CtU/X+6AGusRYcWjub3GgEVJbbo+XA9
 tbbRB1VB5CRc7/SJ1h+HTIvROXQ+lZ9v75P5RCNWCYQ9zLO7FpMAtMlEwqJwrze5A9jF6Hzclwc
 mIyfokxNBqxzpO8mHWJMeywhdz/g3GQL8tJFXc0yNIq9bLU0/d5qRnF8H
X-Gm-Gg: Acq92OH91AGICIVHQ9cAZoUqyoDILCj9LpwAisuIz3mdi9Ka1Of2hsj2FAgRljlnasx
 A239YuJaI8mhzB90VGkcG12nLucW307hyaFQVIT3nsq7w6rpFEBQ6LhJs4ZwiXCnj8WgdN3RATN
 qdV76/vryQ7LelbrSJ3UI0QcSS9lDdV4+VVKxKID8fWgFc5+PsANezZjJkq/hGXolYfz2sIp8j8
 AnGNJtnhNReZ5eh20WriPXjiNNXojR1CL5ax+dYBvLrxEfk4O5kfs3Vq04lQcUIXcFodPSU31ld
 vACjbZJD2Fml6RQAjg8oFu2N2Vbuy762XBtKvhfpNIn5Zi2UZOKx5UUrpg0bRuHLDioziwlBfiK
 qiBh8MGCBlDmAc2hdUm7fE8UweuM/Da0a7U2rIlnKylgpjZuiC/Lv335lB/4YFofgnaQ6mNPk1L
 vwdamuw/XuIcC/MEI7KUErDFDPnFBUWneES9pnu3euG3PzUU0KwCT8
X-Received: by 2002:a17:90b:5145:b0:36d:81b3:61a1 with SMTP id
 98e67ed59e1d1-370eed0b63bmr3103218a91.7.1780652905373; 
 Fri, 05 Jun 2026 02:48:25 -0700 (PDT)
X-Received: by 2002:a17:90b:5145:b0:36d:81b3:61a1 with SMTP id
 98e67ed59e1d1-370eed0b63bmr3103186a91.7.1780652904835; 
 Fri, 05 Jun 2026 02:48:24 -0700 (PDT)
Received: from hu-badhrina-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36f70a285a1sm6208237a91.9.2026.06.05.02.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:48:24 -0700 (PDT)
From: Badhrinath S <badhrinath.s@oss.qualcomm.com>
To: trini@konsulko.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@kernel.org, lukma@denx.de, badhrinath.s@oss.qualcomm.com,
 marek.vasut+renesas@mailbox.org, quic_varada@quicinc.com,
 michal.simek@amd.com, luca.weiss@fairphone.com, adrian@mainlining.org,
 balaji.selvanathan@oss.qualcomm.com, danila@jiaxyga.com,
 aswin.murugan@oss.qualcomm.com, david.wronek@mainlining.org,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH 2/4] pinctrl: qcom: Add ipq9650 pinctrl driver
Date: Fri,  5 Jun 2026 15:17:59 +0530
Message-Id: <20260605094801.4130128-3-badhrinath.s@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com>
References: <20260605094801.4130128-1-badhrinath.s@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5NCBTYWx0ZWRfXzGRhjfDrrBCg
 o/8H2QQ9MuKFYscPAznIysy5/wfvt6UCfZU+h556y2LM+QWx/MqPWXtcOPYl38X4k8XIQvPqeON
 AZgSXjD170XXohQc9Fd//yPg5UB8KiuNOrZiA1Ix2H+FXYnoEHWOnUG4ZLGXtlz9RBYPTRAfyG3
 uvXKAwq2r/dhx/dZlpKHBa9RbJzDTxlAMKqRBdOgxiFgwTsFLZAt4RWG+LvmTChuKsJDboBTj3x
 xeq0IoZDONCpr8HwoFzkvyShJ/coJZyMau/dMXFV1EcLrkzalWEJdoeVzgkYXN8taA13ackN5I4
 HB+o0Su3PZ5O4/OGcdea7/89nVQybmlEXp7T1MXVrKmMtJvEYokrvh4a5vh9R3Dg66Vp+cWO00u
 KU8r46mPwVnwy44jGNmZ3jUvpXr0wKe4UfvFlX3CEBJmSsXlpQ7N3c7AOE3q1+50lQqrPMKx+Eb
 gGSIRo/TvM9CDUCbewQ==
X-Proofpoint-ORIG-GUID: 23sINN21qQbpIFvBuwf5aA6mOyMSV4CR
X-Authority-Analysis: v=2.4 cv=dfmwG3Xe c=1 sm=1 tr=0 ts=6a229b6a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=sqB9GGOAUEJllpBDIggA:9 a=O8hF6Hzn-FEA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 23sINN21qQbpIFvBuwf5aA6mOyMSV4CR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050094
X-Mailman-Approved-At: Fri, 05 Jun 2026 14:27:55 +0200
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

Add pinctrl driver for TLMM block found in the Qualcomm IPQ9650 SoC.

This driver supports 54 GPIO pins with various pin functions including
UART, SPI, I2C, SDCC, PCIe, and other peripherals.

Signed-off-by: Badhrinath S <badhrinath.s@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/Kconfig           |   8 +
 drivers/pinctrl/qcom/Makefile          |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9650.c | 430 +++++++++++++++++++++++++
 3 files changed, 439 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9650.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 11e6763b5f3e..2c0e40807f0f 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -54,6 +54,14 @@ config PINCTRL_QCOM_IPQ9574
 	  Say Y here to enable support for pinctrl on the IPQ9574 SoC,
 	  as well as the associated GPIO driver.
 
+config PINCTRL_QCOM_IPQ9650
+	bool "Qualcomm IPQ9650 Pinctrl"
+	default y if PINCTRL_QCOM_GENERIC
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the IPQ9650 SoC,
+	  as well as the associated GPIO driver.
+
 config PINCTRL_QCOM_MILOS
 	bool "Qualcomm Milos Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 4096c1aa4919..17c88885f8de 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PINCTRL_QCOM_APQ8016) += pinctrl-apq8016.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ4019) += pinctrl-ipq4019.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ5424) += pinctrl-ipq5424.o
 obj-$(CONFIG_PINCTRL_QCOM_IPQ9574) += pinctrl-ipq9574.o
+obj-$(CONFIG_PINCTRL_QCOM_IPQ9650) += pinctrl-ipq9650.o
 obj-$(CONFIG_PINCTRL_QCOM_APQ8096) += pinctrl-apq8096.o
 obj-$(CONFIG_PINCTRL_QCOM_MILOS) += pinctrl-milos.o
 obj-$(CONFIG_PINCTRL_QCOM_QCM2290) += pinctrl-qcm2290.o
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq9650.c b/drivers/pinctrl/qcom/pinctrl-ipq9650.c
new file mode 100644
index 000000000000..04e3713e9824
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-ipq9650.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <dm.h>
+
+#include "pinctrl-qcom.h"
+
+#define MAX_PIN_NAME_LEN 32
+static char pin_name[MAX_PIN_NAME_LEN] __section(".data");
+
+enum ipq9650_functions {
+	msm_mux_gpio,
+	msm_mux_atest_char_start,
+	msm_mux_atest_char_status0,
+	msm_mux_atest_char_status1,
+	msm_mux_atest_char_status2,
+	msm_mux_atest_char_status3,
+	msm_mux_atest_tic_en,
+	msm_mux_audio_pri0,
+	msm_mux_audio_pri1,
+	msm_mux_audio_pri_d0,
+	msm_mux_audio_pri_d1,
+	msm_mux_audio_pri_fsync,
+	msm_mux_audio_pri_pclk,
+	msm_mux_audio_sec0,
+	msm_mux_audio_sec1,
+	msm_mux_audio_sec_d0,
+	msm_mux_audio_sec_d1,
+	msm_mux_audio_sec_fsync,
+	msm_mux_audio_sec_pclk,
+	msm_mux_core_voltage_0,
+	msm_mux_core_voltage_1,
+	msm_mux_core_voltage_2,
+	msm_mux_core_voltage_3,
+	msm_mux_core_voltage_4,
+	msm_mux_cri_rng0,
+	msm_mux_cri_rng1,
+	msm_mux_cri_rng2,
+	msm_mux_dbg_out_clk,
+	msm_mux_gcc_plltest_bypassnl,
+	msm_mux_gcc_plltest_resetn,
+	msm_mux_gcc_tlmm,
+	msm_mux_mdc_mst,
+	msm_mux_mdc_slv0,
+	msm_mux_mdc_slv1,
+	msm_mux_mdio_mst,
+	msm_mux_mdio_slv,
+	msm_mux_mdio_slv0,
+	msm_mux_mdio_slv1,
+	msm_mux_pcie0_clk_req_n,
+	msm_mux_pcie0_wake,
+	msm_mux_pcie1_clk_req_n,
+	msm_mux_pcie1_wake,
+	msm_mux_pcie2_clk_req_n,
+	msm_mux_pcie2_wake,
+	msm_mux_pcie3_clk_req_n,
+	msm_mux_pcie3_wake,
+	msm_mux_pcie4_clk_req_n,
+	msm_mux_pcie4_wake,
+	msm_mux_pll_bist_sync,
+	msm_mux_pll_test,
+	msm_mux_pwm_out00,
+	msm_mux_pwm_out01,
+	msm_mux_pwm_out02,
+	msm_mux_pwm_out10,
+	msm_mux_pwm_out11,
+	msm_mux_pwm_out12,
+	msm_mux_pwm_out20,
+	msm_mux_pwm_out21,
+	msm_mux_pwm_out22,
+	msm_mux_pwm_out30,
+	msm_mux_pwm_out31,
+	msm_mux_pwm_out32,
+	msm_mux_pwm_out40,
+	msm_mux_pwm_out41,
+	msm_mux_pwm_out42,
+	msm_mux_pwm_out50,
+	msm_mux_pwm_out51,
+	msm_mux_qdss_cti_trig_in_a0,
+	msm_mux_qdss_cti_trig_in_a1,
+	msm_mux_qdss_cti_trig_in_b0,
+	msm_mux_qdss_cti_trig_in_b1,
+	msm_mux_qdss_cti_trig_out_a0,
+	msm_mux_qdss_cti_trig_out_a1,
+	msm_mux_qdss_cti_trig_out_b0,
+	msm_mux_qdss_cti_trig_out_b1,
+	msm_mux_qdss_traceclk_a,
+	msm_mux_qdss_tracectl_a,
+	msm_mux_qdss_tracedata_a,
+	msm_mux_qspi_data,
+	msm_mux_qspi_clk,
+	msm_mux_qspi_cs,
+	msm_mux_qup_se0_l0,
+	msm_mux_qup_se0_l1,
+	msm_mux_qup_se0_l2,
+	msm_mux_qup_se0_l3,
+	msm_mux_qup_se0_l4,
+	msm_mux_qup_se0_l5,
+	msm_mux_qup_se1_l0,
+	msm_mux_qup_se1_l1,
+	msm_mux_qup_se1_l2,
+	msm_mux_qup_se1_l3,
+	msm_mux_qup_se1_l4,
+	msm_mux_qup_se1_l5,
+	msm_mux_qup_se2_l0,
+	msm_mux_qup_se2_l1,
+	msm_mux_qup_se2_l2,
+	msm_mux_qup_se2_l3,
+	msm_mux_qup_se3_l0,
+	msm_mux_qup_se3_l1,
+	msm_mux_qup_se3_l2,
+	msm_mux_qup_se3_l3,
+	msm_mux_qup_se4_l0,
+	msm_mux_qup_se4_l1,
+	msm_mux_qup_se4_l2,
+	msm_mux_qup_se4_l3,
+	msm_mux_qup_se4_l4,
+	msm_mux_qup_se4_l5,
+	msm_mux_qup_se5_l0,
+	msm_mux_qup_se5_l1,
+	msm_mux_qup_se5_l2,
+	msm_mux_qup_se5_l3,
+	msm_mux_qup_se5_l4,
+	msm_mux_qup_se5_l5,
+	msm_mux_qup_se6,
+	msm_mux_qup_se6_l0,
+	msm_mux_qup_se6_l1,
+	msm_mux_qup_se6_l2,
+	msm_mux_qup_se6_l3,
+	msm_mux_qup_se7_l0,
+	msm_mux_qup_se7_l1,
+	msm_mux_qup_se7_l2,
+	msm_mux_qup_se7_l3,
+	msm_mux_resout,
+	msm_mux_rx_los00,
+	msm_mux_rx_los01,
+	msm_mux_rx_los02,
+	msm_mux_rx_los10,
+	msm_mux_rx_los11,
+	msm_mux_rx_los20,
+	msm_mux_rx_los21,
+	msm_mux_sdc_clk,
+	msm_mux_sdc_cmd,
+	msm_mux_sdc_data,
+	msm_mux_tsens_max,
+	msm_mux_tsn,
+
+	msm_mux_NA,
+};
+
+#define MSM_PIN_FUNCTION(fname)				\
+	[msm_mux_##fname] = {#fname, msm_mux_##fname}
+
+static const struct pinctrl_function msm_pinctrl_functions[] = {
+	MSM_PIN_FUNCTION(gpio),
+	MSM_PIN_FUNCTION(atest_char_start),
+	MSM_PIN_FUNCTION(atest_char_status0),
+	MSM_PIN_FUNCTION(atest_char_status1),
+	MSM_PIN_FUNCTION(atest_char_status2),
+	MSM_PIN_FUNCTION(atest_char_status3),
+	MSM_PIN_FUNCTION(atest_tic_en),
+	MSM_PIN_FUNCTION(audio_pri0),
+	MSM_PIN_FUNCTION(audio_pri1),
+	MSM_PIN_FUNCTION(audio_pri_d0),
+	MSM_PIN_FUNCTION(audio_pri_d1),
+	MSM_PIN_FUNCTION(audio_pri_fsync),
+	MSM_PIN_FUNCTION(audio_pri_pclk),
+	MSM_PIN_FUNCTION(audio_sec0),
+	MSM_PIN_FUNCTION(audio_sec1),
+	MSM_PIN_FUNCTION(audio_sec_d0),
+	MSM_PIN_FUNCTION(audio_sec_d1),
+	MSM_PIN_FUNCTION(audio_sec_fsync),
+	MSM_PIN_FUNCTION(audio_sec_pclk),
+	MSM_PIN_FUNCTION(core_voltage_0),
+	MSM_PIN_FUNCTION(core_voltage_1),
+	MSM_PIN_FUNCTION(core_voltage_2),
+	MSM_PIN_FUNCTION(core_voltage_3),
+	MSM_PIN_FUNCTION(core_voltage_4),
+	MSM_PIN_FUNCTION(cri_rng0),
+	MSM_PIN_FUNCTION(cri_rng1),
+	MSM_PIN_FUNCTION(cri_rng2),
+	MSM_PIN_FUNCTION(dbg_out_clk),
+	MSM_PIN_FUNCTION(gcc_plltest_bypassnl),
+	MSM_PIN_FUNCTION(gcc_plltest_resetn),
+	MSM_PIN_FUNCTION(gcc_tlmm),
+	MSM_PIN_FUNCTION(mdc_mst),
+	MSM_PIN_FUNCTION(mdc_slv0),
+	MSM_PIN_FUNCTION(mdc_slv1),
+	MSM_PIN_FUNCTION(mdio_mst),
+	MSM_PIN_FUNCTION(mdio_slv),
+	MSM_PIN_FUNCTION(mdio_slv0),
+	MSM_PIN_FUNCTION(mdio_slv1),
+	MSM_PIN_FUNCTION(pcie0_clk_req_n),
+	MSM_PIN_FUNCTION(pcie0_wake),
+	MSM_PIN_FUNCTION(pcie1_clk_req_n),
+	MSM_PIN_FUNCTION(pcie1_wake),
+	MSM_PIN_FUNCTION(pcie2_clk_req_n),
+	MSM_PIN_FUNCTION(pcie2_wake),
+	MSM_PIN_FUNCTION(pcie3_clk_req_n),
+	MSM_PIN_FUNCTION(pcie3_wake),
+	MSM_PIN_FUNCTION(pcie4_clk_req_n),
+	MSM_PIN_FUNCTION(pcie4_wake),
+	MSM_PIN_FUNCTION(pll_bist_sync),
+	MSM_PIN_FUNCTION(pll_test),
+	MSM_PIN_FUNCTION(pwm_out00),
+	MSM_PIN_FUNCTION(pwm_out01),
+	MSM_PIN_FUNCTION(pwm_out02),
+	MSM_PIN_FUNCTION(pwm_out10),
+	MSM_PIN_FUNCTION(pwm_out11),
+	MSM_PIN_FUNCTION(pwm_out12),
+	MSM_PIN_FUNCTION(pwm_out20),
+	MSM_PIN_FUNCTION(pwm_out21),
+	MSM_PIN_FUNCTION(pwm_out22),
+	MSM_PIN_FUNCTION(pwm_out30),
+	MSM_PIN_FUNCTION(pwm_out31),
+	MSM_PIN_FUNCTION(pwm_out32),
+	MSM_PIN_FUNCTION(pwm_out40),
+	MSM_PIN_FUNCTION(pwm_out41),
+	MSM_PIN_FUNCTION(pwm_out42),
+	MSM_PIN_FUNCTION(pwm_out50),
+	MSM_PIN_FUNCTION(pwm_out51),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_in_b1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_a1),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b0),
+	MSM_PIN_FUNCTION(qdss_cti_trig_out_b1),
+	MSM_PIN_FUNCTION(qdss_traceclk_a),
+	MSM_PIN_FUNCTION(qdss_tracectl_a),
+	MSM_PIN_FUNCTION(qdss_tracedata_a),
+	MSM_PIN_FUNCTION(qspi_data),
+	MSM_PIN_FUNCTION(qspi_clk),
+	MSM_PIN_FUNCTION(qspi_cs),
+	MSM_PIN_FUNCTION(qup_se0_l0),
+	MSM_PIN_FUNCTION(qup_se0_l1),
+	MSM_PIN_FUNCTION(qup_se0_l2),
+	MSM_PIN_FUNCTION(qup_se0_l3),
+	MSM_PIN_FUNCTION(qup_se0_l4),
+	MSM_PIN_FUNCTION(qup_se0_l5),
+	MSM_PIN_FUNCTION(qup_se1_l0),
+	MSM_PIN_FUNCTION(qup_se1_l1),
+	MSM_PIN_FUNCTION(qup_se1_l2),
+	MSM_PIN_FUNCTION(qup_se1_l3),
+	MSM_PIN_FUNCTION(qup_se1_l4),
+	MSM_PIN_FUNCTION(qup_se1_l5),
+	MSM_PIN_FUNCTION(qup_se2_l0),
+	MSM_PIN_FUNCTION(qup_se2_l1),
+	MSM_PIN_FUNCTION(qup_se2_l2),
+	MSM_PIN_FUNCTION(qup_se2_l3),
+	MSM_PIN_FUNCTION(qup_se3_l0),
+	MSM_PIN_FUNCTION(qup_se3_l1),
+	MSM_PIN_FUNCTION(qup_se3_l2),
+	MSM_PIN_FUNCTION(qup_se3_l3),
+	MSM_PIN_FUNCTION(qup_se4_l0),
+	MSM_PIN_FUNCTION(qup_se4_l1),
+	MSM_PIN_FUNCTION(qup_se4_l2),
+	MSM_PIN_FUNCTION(qup_se4_l3),
+	MSM_PIN_FUNCTION(qup_se4_l4),
+	MSM_PIN_FUNCTION(qup_se4_l5),
+	MSM_PIN_FUNCTION(qup_se5_l0),
+	MSM_PIN_FUNCTION(qup_se5_l1),
+	MSM_PIN_FUNCTION(qup_se5_l2),
+	MSM_PIN_FUNCTION(qup_se5_l3),
+	MSM_PIN_FUNCTION(qup_se5_l4),
+	MSM_PIN_FUNCTION(qup_se5_l5),
+	MSM_PIN_FUNCTION(qup_se6),
+	MSM_PIN_FUNCTION(qup_se6_l0),
+	MSM_PIN_FUNCTION(qup_se6_l1),
+	MSM_PIN_FUNCTION(qup_se6_l2),
+	MSM_PIN_FUNCTION(qup_se6_l3),
+	MSM_PIN_FUNCTION(qup_se7_l0),
+	MSM_PIN_FUNCTION(qup_se7_l1),
+	MSM_PIN_FUNCTION(qup_se7_l2),
+	MSM_PIN_FUNCTION(qup_se7_l3),
+	MSM_PIN_FUNCTION(resout),
+	MSM_PIN_FUNCTION(rx_los00),
+	MSM_PIN_FUNCTION(rx_los01),
+	MSM_PIN_FUNCTION(rx_los02),
+	MSM_PIN_FUNCTION(rx_los10),
+	MSM_PIN_FUNCTION(rx_los11),
+	MSM_PIN_FUNCTION(rx_los20),
+	MSM_PIN_FUNCTION(rx_los21),
+	MSM_PIN_FUNCTION(sdc_clk),
+	MSM_PIN_FUNCTION(sdc_cmd),
+	MSM_PIN_FUNCTION(sdc_data),
+	MSM_PIN_FUNCTION(tsens_max),
+	MSM_PIN_FUNCTION(tsn),
+
+};
+
+typedef unsigned int msm_pin_function[10];
+
+#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9) \
+	[id] = {        msm_mux_gpio, /* gpio mode */	\
+			msm_mux_##f1,			\
+			msm_mux_##f2,			\
+			msm_mux_##f3,			\
+			msm_mux_##f4,			\
+			msm_mux_##f5,			\
+			msm_mux_##f6,			\
+			msm_mux_##f7,			\
+			msm_mux_##f8,			\
+			msm_mux_##f9,			\
+	}
+
+static const msm_pin_function ipq9650_pin_functions[] = {
+	PINGROUP(0, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(1, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(2, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(3, sdc_data, qspi_data, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(4, sdc_cmd, qspi_cs, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(5, sdc_clk, qspi_clk, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(6, qup_se0_l2, pwm_out51, NA, cri_rng0, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(7, qup_se0_l3, pwm_out41, NA, cri_rng1, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(8, qup_se0_l0, pwm_out31, NA, cri_rng2, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(9, qup_se0_l1, pwm_out21, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(10, qup_se1_l1, pwm_out11, NA, NA, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(11, qup_se1_l0, pwm_out01, NA, NA, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(12, qup_se1_l3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA, NA),
+	PINGROUP(13, qup_se1_l2, NA, qdss_tracedata_a, NA, NA, NA, NA, NA, NA),
+	PINGROUP(14, qup_se4_l1, mdc_slv1, tsens_max, NA, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(15, qup_se4_l0, mdio_slv1, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(16, core_voltage_0, qup_se3_l1, pwm_out02, NA, NA, NA, NA, NA, NA),
+	PINGROUP(17, core_voltage_1, qup_se3_l0, pwm_out12, NA, NA, NA, NA, NA, NA),
+	PINGROUP(18, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(19, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(20, mdc_slv0, qup_se3_l3, NA, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(21, mdio_slv0, qup_se3_l2, atest_char_start, NA, qdss_tracedata_a, NA, NA, NA, NA),
+	PINGROUP(22, mdc_mst, atest_char_status2, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(23, mdio_mst, atest_char_status3, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(24, pcie0_clk_req_n, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(25, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(26, pcie0_wake, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(27, pcie1_clk_req_n, qup_se2_l3, qup_se1_l4,
+		 NA, qdss_cti_trig_out_a1, NA, NA, NA, NA),
+	PINGROUP(28, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(29, pcie1_wake, qup_se2_l2, qup_se1_l5, NA, qdss_cti_trig_in_a1, NA, NA, NA, NA),
+	PINGROUP(30, pcie4_clk_req_n, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(31, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(32, pcie4_wake, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(33, core_voltage_2, qup_se2_l1, gcc_plltest_bypassnl,
+		 pwm_out22, atest_char_status0, NA, NA, NA, NA),
+	PINGROUP(34, core_voltage_3, qup_se2_l0, gcc_tlmm, pwm_out32, NA, NA, NA, NA, NA),
+	PINGROUP(35, core_voltage_4, gcc_plltest_resetn, pwm_out42,
+		 atest_char_status1, NA, NA, NA, NA, NA),
+	PINGROUP(36, audio_pri_d0, qup_se7_l2, qdss_tracedata_a, NA, NA, NA, NA, NA, NA),
+	PINGROUP(37, audio_pri_d1, qup_se7_l3, audio_sec0,
+		 audio_sec0, rx_los21, qdss_tracedata_a, NA, NA, NA),
+	PINGROUP(38, audio_pri_fsync, qup_se7_l0, rx_los11, qdss_tracedata_a, NA, NA, NA, NA, NA),
+	PINGROUP(39, audio_pri_pclk, qup_se7_l1, audio_sec1,
+		 audio_sec1, pll_test, rx_los01, NA, qdss_tracedata_a, NA),
+	PINGROUP(40, pcie3_clk_req_n, qup_se5_l4, qup_se4_l4,
+		 NA, qdss_cti_trig_out_b0, NA, NA, NA, NA),
+	PINGROUP(41, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(42, pcie3_wake, qup_se5_l5, qup_se4_l5,
+		 NA, qdss_cti_trig_in_b0, NA, NA, NA, NA),
+	PINGROUP(43, qup_se4_l3, qup_se6, pwm_out50, NA, qdss_cti_trig_in_b1, NA, NA, NA, NA),
+	PINGROUP(44, qup_se4_l2, qup_se6, pwm_out40, NA, qdss_cti_trig_out_b1, NA, NA, NA, NA),
+	PINGROUP(45, qup_se5_l2, rx_los20, audio_sec_fsync,
+		 pwm_out30, NA, qdss_traceclk_a, NA, NA, NA),
+	PINGROUP(46, qup_se5_l3, rx_los10, audio_sec_pclk,
+		 mdio_slv, pwm_out20, dbg_out_clk, qdss_tracectl_a, NA, NA),
+	PINGROUP(47, qup_se5_l0, rx_los00, audio_sec_d1,
+		 mdio_slv, pll_bist_sync, pwm_out10, NA, NA, NA),
+	PINGROUP(48, qup_se5_l1, audio_sec_d0, pwm_out00, NA, NA, NA, NA, NA, NA),
+	PINGROUP(49, resout, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(50, tsn, rx_los02, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(51, pcie2_clk_req_n, qup_se6_l0, qup_se0_l4,
+		 audio_pri1, audio_pri1, qdss_cti_trig_out_a0, NA, NA, NA),
+	PINGROUP(52, NA, NA, NA, NA, NA, NA, NA, NA, NA),
+	PINGROUP(53, pcie2_wake, qup_se6_l1, qup_se0_l5,
+		 audio_pri0, audio_pri0, qdss_cti_trig_in_a0, NA, atest_tic_en, NA),
+};
+
+static const char *ipq9650_get_function_name(struct udevice *dev,
+					     unsigned int selector)
+{
+	return msm_pinctrl_functions[selector].name;
+}
+
+static const char *ipq9650_get_pin_name(struct udevice *dev,
+					unsigned int selector)
+{
+	snprintf(pin_name, MAX_PIN_NAME_LEN, "gpio%u", selector);
+	return pin_name;
+}
+
+static int ipq9650_get_function_mux(unsigned int pin, unsigned int selector)
+{
+	unsigned int i;
+	const msm_pin_function *func = ipq9650_pin_functions + pin;
+
+	for (i = 0; i < 10; i++)
+		if ((*func)[i] == selector)
+			return i;
+
+	debug("Can't find requested function for pin:selector %u:%u\n",
+	      pin, selector);
+
+	return -EINVAL;
+}
+
+static const struct msm_pinctrl_data ipq9650_data = {
+	.pin_data = {
+		.pin_count = 54,
+		.special_pins_start = 54,
+	},
+	.functions_count = ARRAY_SIZE(msm_pinctrl_functions),
+	.get_function_name = ipq9650_get_function_name,
+	.get_function_mux = ipq9650_get_function_mux,
+	.get_pin_name = ipq9650_get_pin_name,
+};
+
+static const struct udevice_id msm_pinctrl_ids[] = {
+	{ .compatible = "qcom,ipq9650-tlmm", .data = (ulong)&ipq9650_data },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_DRIVER(pinctrl_ipq9650) = {
+	.name		= "pinctrl_ipq9650",
+	.id		= UCLASS_NOP,
+	.of_match	= msm_pinctrl_ids,
+	.ops		= &msm_pinctrl_ops,
+	.bind		= msm_pinctrl_bind,
+	.flags = DM_FLAG_PRE_RELOC,
+};
-- 
2.34.1

