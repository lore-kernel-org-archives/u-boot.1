Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143D0C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:08:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95EB587831;
	Tue, 19 Dec 2023 17:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rlyFbLmN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3574877A1; Tue, 19 Dec 2023 17:05:06 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5B3877A1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d190044c5so27663675e9.2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001885; x=1703606685; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/cdl95tQMd/7XAB/Xe3FjnhkUFOuQP4h42xqr1tnWBI=;
 b=rlyFbLmNe0FqGUZ6Bn4eSlrGjtaJIDNAtLh9b/L7QtVxdaoW3q1G4HYnyu7CjIExvm
 c4oBo55brt0JUIaBB2T9zX8/7RolBCeDnS+5qAb2Qbglh0QxbqzDnuvPEsxshgGsfpHt
 MHqbyWmnEimDjbExhwXjha5EKfTg/Q2cmpg/ZEJfUn71d2Cv/08s9JiY6cPtOnYaz4g5
 xJkf5eY+M3k97r9MqTILpH8P92aFHLT6pw2DPPNx9EBkREtJwEs05CyD07moCy2fmddo
 ifVIHPFP+82zQHShu+bMetp29gSWYtBR6k9oxJchDHkHyIznmE0z0J+wkHAxLRYiWtXA
 2J/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001885; x=1703606685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/cdl95tQMd/7XAB/Xe3FjnhkUFOuQP4h42xqr1tnWBI=;
 b=bi8QS3Uw4yHpU3LRao0R8O2svrAtb1EXE0gsyBSm+SMGpTgVveodld5ecSed9ZclL4
 JYOneAJp1n7qv2QIXwbCs20T08nLj0ZI7zOzWo083m/g+apntL7Xi5cMQxqCxTSWaR16
 kN8hYSNZah9sEzztSNLaPvIlYb1oOYJrukZKnOE0IkKnw0RC+IRgFDqpj7BwwPwfz+PC
 uKYiQM5hd90HcRwA7vlS7HNuUGuzcVvPM96gW1cSPyx6XOjtXpDIoIqIVSGCWWZhHo+6
 aGE9AHECfITkOkFjiyYjlYX4G5su9HKbD67w2qZjBm0SfJoHUrUOZU9RMaVTrgy7Zg95
 jNpQ==
X-Gm-Message-State: AOJu0YwzluW4hXrp9z0LQfH4ropxGL5UYQzai4g8It0T5XKxCytACXw8
 /MfzaA1jblUjv7F7LUdLp9fBWQ==
X-Google-Smtp-Source: AGHT+IFd9jTcRbSs9GCRUt5mAYCfctbiD5wK3PPGXzjatopM3/D1OVLJry/8A9zmZYQyxOK+/UgSQw==
X-Received: by 2002:a05:600c:4509:b0:40c:2518:687c with SMTP id
 t9-20020a05600c450900b0040c2518687cmr9454717wmo.61.1703001885489; 
 Tue, 19 Dec 2023 08:04:45 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:44 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:23 +0000
Subject: [PATCH v2 22/32] dt-bindings: import headers for MSM8916
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-22-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=19326;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dh9BidyJ9I+WnskgzzJ+usgVKK9njXO+yNUaZ8OYOLs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/cwflGoebWdJcgnvWs6uE5b8J2Vb6unsqbr6q5fJO
 h+4kXelo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEzk9hOGv9Izy8yff6095+It
 nlp2//UsU4WCJofSPVXTXliWHJD8ksTIsKk31k1pucyeRayuahkLbghvaUk2r3SYceXByfOccft
 crgIA
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

Import the dt-bindings headers in preparation for switching to upstream
DTS for MSM8916.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/dt-bindings/arm/coresight-cti-dt.h      |  37 +++++
 include/dt-bindings/clock/qcom,rpmcc.h          | 174 ++++++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,msm8916.h | 100 ++++++++++++++
 include/dt-bindings/pinctrl/qcom,pmic-mpp.h     | 106 +++++++++++++++
 include/dt-bindings/reset/qcom,gcc-msm8916.h    | 100 ++++++++++++++
 include/dt-bindings/sound/apq8016-lpass.h       |   9 ++
 include/dt-bindings/sound/qcom,lpass.h          |  46 +++++++
 7 files changed, 572 insertions(+)

diff --git a/include/dt-bindings/arm/coresight-cti-dt.h b/include/dt-bindings/arm/coresight-cti-dt.h
new file mode 100644
index 000000000000..61e7bdf8ea6e
--- /dev/null
+++ b/include/dt-bindings/arm/coresight-cti-dt.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for the defined trigger signal
+ * types on CoreSight CTI.
+ */
+
+#ifndef _DT_BINDINGS_ARM_CORESIGHT_CTI_DT_H
+#define _DT_BINDINGS_ARM_CORESIGHT_CTI_DT_H
+
+#define GEN_IO		0
+#define GEN_INTREQ	1
+#define GEN_INTACK	2
+#define GEN_HALTREQ	3
+#define GEN_RESTARTREQ	4
+#define PE_EDBGREQ	5
+#define PE_DBGRESTART	6
+#define PE_CTIIRQ	7
+#define PE_PMUIRQ	8
+#define PE_DBGTRIGGER	9
+#define ETM_EXTOUT	10
+#define ETM_EXTIN	11
+#define SNK_FULL	12
+#define SNK_ACQCOMP	13
+#define SNK_FLUSHCOMP	14
+#define SNK_FLUSHIN	15
+#define SNK_TRIGIN	16
+#define STM_ASYNCOUT	17
+#define STM_TOUT_SPTE	18
+#define STM_TOUT_SW	19
+#define STM_TOUT_HETE	20
+#define STM_HWEVENT	21
+#define ELA_TSTART	22
+#define ELA_TSTOP	23
+#define ELA_DBGREQ	24
+#define CTI_TRIG_MAX	25
+
+#endif /*_DT_BINDINGS_ARM_CORESIGHT_CTI_DT_H */
diff --git a/include/dt-bindings/clock/qcom,rpmcc.h b/include/dt-bindings/clock/qcom,rpmcc.h
new file mode 100644
index 000000000000..46309c9953b2
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,rpmcc.h
@@ -0,0 +1,174 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2015 Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_MSM_RPMCC_H
+#define _DT_BINDINGS_CLK_MSM_RPMCC_H
+
+/* RPM clocks */
+#define RPM_PXO_CLK				0
+#define RPM_PXO_A_CLK				1
+#define RPM_CXO_CLK				2
+#define RPM_CXO_A_CLK				3
+#define RPM_APPS_FABRIC_CLK			4
+#define RPM_APPS_FABRIC_A_CLK			5
+#define RPM_CFPB_CLK				6
+#define RPM_CFPB_A_CLK				7
+#define RPM_QDSS_CLK				8
+#define RPM_QDSS_A_CLK				9
+#define RPM_DAYTONA_FABRIC_CLK			10
+#define RPM_DAYTONA_FABRIC_A_CLK		11
+#define RPM_EBI1_CLK				12
+#define RPM_EBI1_A_CLK				13
+#define RPM_MM_FABRIC_CLK			14
+#define RPM_MM_FABRIC_A_CLK			15
+#define RPM_MMFPB_CLK				16
+#define RPM_MMFPB_A_CLK				17
+#define RPM_SYS_FABRIC_CLK			18
+#define RPM_SYS_FABRIC_A_CLK			19
+#define RPM_SFPB_CLK				20
+#define RPM_SFPB_A_CLK				21
+#define RPM_SMI_CLK				22
+#define RPM_SMI_A_CLK				23
+#define RPM_PLL4_CLK				24
+#define RPM_XO_D0				25
+#define RPM_XO_D1				26
+#define RPM_XO_A0				27
+#define RPM_XO_A1				28
+#define RPM_XO_A2				29
+#define RPM_NSS_FABRIC_0_CLK			30
+#define RPM_NSS_FABRIC_0_A_CLK			31
+#define RPM_NSS_FABRIC_1_CLK			32
+#define RPM_NSS_FABRIC_1_A_CLK			33
+
+/* SMD RPM clocks */
+#define RPM_SMD_XO_CLK_SRC				0
+#define RPM_SMD_XO_A_CLK_SRC			1
+#define RPM_SMD_PCNOC_CLK				2
+#define RPM_SMD_PCNOC_A_CLK				3
+#define RPM_SMD_SNOC_CLK				4
+#define RPM_SMD_SNOC_A_CLK				5
+#define RPM_SMD_BIMC_CLK				6
+#define RPM_SMD_BIMC_A_CLK				7
+#define RPM_SMD_QDSS_CLK				8
+#define RPM_SMD_QDSS_A_CLK				9
+#define RPM_SMD_BB_CLK1				10
+#define RPM_SMD_BB_CLK1_A				11
+#define RPM_SMD_BB_CLK2				12
+#define RPM_SMD_BB_CLK2_A				13
+#define RPM_SMD_RF_CLK1				14
+#define RPM_SMD_RF_CLK1_A				15
+#define RPM_SMD_RF_CLK2				16
+#define RPM_SMD_RF_CLK2_A				17
+#define RPM_SMD_BB_CLK1_PIN				18
+#define RPM_SMD_BB_CLK1_A_PIN			19
+#define RPM_SMD_BB_CLK2_PIN				20
+#define RPM_SMD_BB_CLK2_A_PIN			21
+#define RPM_SMD_RF_CLK1_PIN				22
+#define RPM_SMD_RF_CLK1_A_PIN			23
+#define RPM_SMD_RF_CLK2_PIN				24
+#define RPM_SMD_RF_CLK2_A_PIN			25
+#define RPM_SMD_PNOC_CLK			26
+#define RPM_SMD_PNOC_A_CLK			27
+#define RPM_SMD_CNOC_CLK			28
+#define RPM_SMD_CNOC_A_CLK			29
+#define RPM_SMD_MMSSNOC_AHB_CLK			30
+#define RPM_SMD_MMSSNOC_AHB_A_CLK		31
+#define RPM_SMD_GFX3D_CLK_SRC			32
+#define RPM_SMD_GFX3D_A_CLK_SRC			33
+#define RPM_SMD_OCMEMGX_CLK			34
+#define RPM_SMD_OCMEMGX_A_CLK			35
+#define RPM_SMD_CXO_D0				36
+#define RPM_SMD_CXO_D0_A			37
+#define RPM_SMD_CXO_D1				38
+#define RPM_SMD_CXO_D1_A			39
+#define RPM_SMD_CXO_A0				40
+#define RPM_SMD_CXO_A0_A			41
+#define RPM_SMD_CXO_A1				42
+#define RPM_SMD_CXO_A1_A			43
+#define RPM_SMD_CXO_A2				44
+#define RPM_SMD_CXO_A2_A			45
+#define RPM_SMD_DIV_CLK1			46
+#define RPM_SMD_DIV_A_CLK1			47
+#define RPM_SMD_DIV_CLK2			48
+#define RPM_SMD_DIV_A_CLK2			49
+#define RPM_SMD_DIFF_CLK			50
+#define RPM_SMD_DIFF_A_CLK			51
+#define RPM_SMD_CXO_D0_PIN			52
+#define RPM_SMD_CXO_D0_A_PIN			53
+#define RPM_SMD_CXO_D1_PIN			54
+#define RPM_SMD_CXO_D1_A_PIN			55
+#define RPM_SMD_CXO_A0_PIN			56
+#define RPM_SMD_CXO_A0_A_PIN			57
+#define RPM_SMD_CXO_A1_PIN			58
+#define RPM_SMD_CXO_A1_A_PIN			59
+#define RPM_SMD_CXO_A2_PIN			60
+#define RPM_SMD_CXO_A2_A_PIN			61
+#define RPM_SMD_AGGR1_NOC_CLK			62
+#define RPM_SMD_AGGR1_NOC_A_CLK			63
+#define RPM_SMD_AGGR2_NOC_CLK			64
+#define RPM_SMD_AGGR2_NOC_A_CLK			65
+#define RPM_SMD_MMAXI_CLK			66
+#define RPM_SMD_MMAXI_A_CLK			67
+#define RPM_SMD_IPA_CLK				68
+#define RPM_SMD_IPA_A_CLK			69
+#define RPM_SMD_CE1_CLK				70
+#define RPM_SMD_CE1_A_CLK			71
+#define RPM_SMD_DIV_CLK3			72
+#define RPM_SMD_DIV_A_CLK3			73
+#define RPM_SMD_LN_BB_CLK			74
+#define RPM_SMD_LN_BB_A_CLK			75
+#define RPM_SMD_BIMC_GPU_CLK			76
+#define RPM_SMD_BIMC_GPU_A_CLK			77
+#define RPM_SMD_QPIC_CLK			78
+#define RPM_SMD_QPIC_CLK_A			79
+#define RPM_SMD_LN_BB_CLK1			80
+#define RPM_SMD_LN_BB_CLK1_A			81
+#define RPM_SMD_LN_BB_CLK2			82
+#define RPM_SMD_LN_BB_CLK2_A			83
+#define RPM_SMD_LN_BB_CLK3_PIN			84
+#define RPM_SMD_LN_BB_CLK3_A_PIN		85
+#define RPM_SMD_RF_CLK3				86
+#define RPM_SMD_RF_CLK3_A			87
+#define RPM_SMD_RF_CLK3_PIN			88
+#define RPM_SMD_RF_CLK3_A_PIN			89
+#define RPM_SMD_MMSSNOC_AXI_CLK			90
+#define RPM_SMD_MMSSNOC_AXI_CLK_A		91
+#define RPM_SMD_CNOC_PERIPH_CLK			92
+#define RPM_SMD_CNOC_PERIPH_A_CLK		93
+#define RPM_SMD_LN_BB_CLK3			94
+#define RPM_SMD_LN_BB_CLK3_A			95
+#define RPM_SMD_LN_BB_CLK1_PIN			96
+#define RPM_SMD_LN_BB_CLK1_A_PIN		97
+#define RPM_SMD_LN_BB_CLK2_PIN			98
+#define RPM_SMD_LN_BB_CLK2_A_PIN		99
+#define RPM_SMD_SYSMMNOC_CLK			100
+#define RPM_SMD_SYSMMNOC_A_CLK			101
+#define RPM_SMD_CE2_CLK				102
+#define RPM_SMD_CE2_A_CLK			103
+#define RPM_SMD_CE3_CLK				104
+#define RPM_SMD_CE3_A_CLK			105
+#define RPM_SMD_QUP_CLK				106
+#define RPM_SMD_QUP_A_CLK			107
+#define RPM_SMD_MMRT_CLK			108
+#define RPM_SMD_MMRT_A_CLK			109
+#define RPM_SMD_MMNRT_CLK			110
+#define RPM_SMD_MMNRT_A_CLK			111
+#define RPM_SMD_SNOC_PERIPH_CLK			112
+#define RPM_SMD_SNOC_PERIPH_A_CLK		113
+#define RPM_SMD_SNOC_LPASS_CLK			114
+#define RPM_SMD_SNOC_LPASS_A_CLK		115
+#define RPM_SMD_HWKM_CLK			116
+#define RPM_SMD_HWKM_A_CLK			117
+#define RPM_SMD_PKA_CLK				118
+#define RPM_SMD_PKA_A_CLK			119
+#define RPM_SMD_CPUSS_GNOC_CLK			120
+#define RPM_SMD_CPUSS_GNOC_A_CLK		121
+#define RPM_SMD_MSS_CFG_AHB_CLK		122
+#define RPM_SMD_MSS_CFG_AHB_A_CLK		123
+#define RPM_SMD_BIMC_FREQ_LOG			124
+#define RPM_SMD_LN_BB_CLK_PIN			125
+#define RPM_SMD_LN_BB_A_CLK_PIN			126
+
+#endif
diff --git a/include/dt-bindings/interconnect/qcom,msm8916.h b/include/dt-bindings/interconnect/qcom,msm8916.h
new file mode 100644
index 000000000000..359a75feb198
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,msm8916.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Qualcomm interconnect IDs
+ *
+ * Copyright (c) 2019, Linaro Ltd.
+ * Author: Georgi Djakov <georgi.djakov@linaro.org>
+ */
+
+#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_MSM8916_H
+#define __DT_BINDINGS_INTERCONNECT_QCOM_MSM8916_H
+
+#define BIMC_SNOC_SLV			0
+#define MASTER_JPEG			1
+#define MASTER_MDP_PORT0		2
+#define MASTER_QDSS_BAM			3
+#define MASTER_QDSS_ETR			4
+#define MASTER_SNOC_CFG			5
+#define MASTER_VFE			6
+#define MASTER_VIDEO_P0			7
+#define SNOC_MM_INT_0			8
+#define SNOC_MM_INT_1			9
+#define SNOC_MM_INT_2			10
+#define SNOC_MM_INT_BIMC		11
+#define PCNOC_SNOC_SLV			12
+#define SLAVE_APSS			13
+#define SLAVE_CATS_128			14
+#define SLAVE_OCMEM_64			15
+#define SLAVE_IMEM			16
+#define SLAVE_QDSS_STM			17
+#define SLAVE_SRVC_SNOC			18
+#define SNOC_BIMC_0_MAS			19
+#define SNOC_BIMC_1_MAS			20
+#define SNOC_INT_0			21
+#define SNOC_INT_1			22
+#define SNOC_INT_BIMC			23
+#define SNOC_PCNOC_MAS			24
+#define SNOC_QDSS_INT			25
+
+#define BIMC_SNOC_MAS			0
+#define MASTER_AMPSS_M0			1
+#define MASTER_GRAPHICS_3D		2
+#define MASTER_TCU0			3
+#define MASTER_TCU1			4
+#define SLAVE_AMPSS_L2			5
+#define SLAVE_EBI_CH0			6
+#define SNOC_BIMC_0_SLV			7
+#define SNOC_BIMC_1_SLV			8
+
+#define MASTER_BLSP_1			0
+#define MASTER_DEHR			1
+#define MASTER_LPASS			2
+#define MASTER_CRYPTO_CORE0		3
+#define MASTER_SDCC_1			4
+#define MASTER_SDCC_2			5
+#define MASTER_SPDM			6
+#define MASTER_USB_HS			7
+#define PCNOC_INT_0			8
+#define PCNOC_INT_1			9
+#define PCNOC_MAS_0			10
+#define PCNOC_MAS_1			11
+#define PCNOC_SLV_0			12
+#define PCNOC_SLV_1			13
+#define PCNOC_SLV_2			14
+#define PCNOC_SLV_3			15
+#define PCNOC_SLV_4			16
+#define PCNOC_SLV_8			17
+#define PCNOC_SLV_9			18
+#define PCNOC_SNOC_MAS			19
+#define SLAVE_BIMC_CFG			20
+#define SLAVE_BLSP_1			21
+#define SLAVE_BOOT_ROM			22
+#define SLAVE_CAMERA_CFG		23
+#define SLAVE_CLK_CTL			24
+#define SLAVE_CRYPTO_0_CFG		25
+#define SLAVE_DEHR_CFG			26
+#define SLAVE_DISPLAY_CFG		27
+#define SLAVE_GRAPHICS_3D_CFG		28
+#define SLAVE_IMEM_CFG			29
+#define SLAVE_LPASS			30
+#define SLAVE_MPM			31
+#define SLAVE_MSG_RAM			32
+#define SLAVE_MSS			33
+#define SLAVE_PDM			34
+#define SLAVE_PMIC_ARB			35
+#define SLAVE_PCNOC_CFG			36
+#define SLAVE_PRNG			37
+#define SLAVE_QDSS_CFG			38
+#define SLAVE_RBCPR_CFG			39
+#define SLAVE_SDCC_1			40
+#define SLAVE_SDCC_2			41
+#define SLAVE_SECURITY			42
+#define SLAVE_SNOC_CFG			43
+#define SLAVE_SPDM			44
+#define SLAVE_TCSR			45
+#define SLAVE_TLMM			46
+#define SLAVE_USB_HS			47
+#define SLAVE_VENUS_CFG			48
+#define SNOC_PCNOC_SLV			49
+
+#endif
diff --git a/include/dt-bindings/pinctrl/qcom,pmic-mpp.h b/include/dt-bindings/pinctrl/qcom,pmic-mpp.h
new file mode 100644
index 000000000000..32e66ee7e830
--- /dev/null
+++ b/include/dt-bindings/pinctrl/qcom,pmic-mpp.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This header provides constants for the Qualcomm PMIC's
+ * Multi-Purpose Pin binding.
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_QCOM_PMIC_MPP_H
+#define _DT_BINDINGS_PINCTRL_QCOM_PMIC_MPP_H
+
+/* power-source */
+
+/* Digital Input/Output: level [PM8058] */
+#define PM8058_MPP_VPH			0
+#define PM8058_MPP_S3			1
+#define PM8058_MPP_L2			2
+#define PM8058_MPP_L3			3
+
+/* Digital Input/Output: level [PM8901] */
+#define PM8901_MPP_MSMIO		0
+#define PM8901_MPP_DIG			1
+#define PM8901_MPP_L5			2
+#define PM8901_MPP_S4			3
+#define PM8901_MPP_VPH			4
+
+/* Digital Input/Output: level [PM8921] */
+#define PM8921_MPP_S4			1
+#define PM8921_MPP_L15			3
+#define PM8921_MPP_L17			4
+#define PM8921_MPP_VPH			7
+
+/* Digital Input/Output: level [PM8821] */
+#define PM8821_MPP_1P8			0
+#define PM8821_MPP_VPH			7
+
+/* Digital Input/Output: level [PM8018] */
+#define PM8018_MPP_L4			0
+#define PM8018_MPP_L14			1
+#define PM8018_MPP_S3			2
+#define PM8018_MPP_L6			3
+#define PM8018_MPP_L2			4
+#define PM8018_MPP_L5			5
+#define PM8018_MPP_VPH			7
+
+/* Digital Input/Output: level [PM8038] */
+#define PM8038_MPP_L20			0
+#define PM8038_MPP_L11			1
+#define PM8038_MPP_L5			2
+#define PM8038_MPP_L15			3
+#define PM8038_MPP_L17			4
+#define PM8038_MPP_VPH			7
+
+#define PM8841_MPP_VPH			0
+#define PM8841_MPP_S3			2
+
+#define PM8916_MPP_VPH			0
+#define PM8916_MPP_L2			2
+#define PM8916_MPP_L5			3
+
+#define PM8941_MPP_VPH			0
+#define PM8941_MPP_L1			1
+#define PM8941_MPP_S3			2
+#define PM8941_MPP_L6			3
+
+#define PMA8084_MPP_VPH			0
+#define PMA8084_MPP_L1			1
+#define PMA8084_MPP_S4			2
+#define PMA8084_MPP_L6			3
+
+#define PM8994_MPP_VPH			0
+/* Only supported for MPP_05-MPP_08 */
+#define PM8994_MPP_L19			1
+#define PM8994_MPP_S4			2
+#define PM8994_MPP_L12			3
+
+/*
+ * Analog Input - Set the source for analog input.
+ * To be used with "qcom,amux-route" property
+ */
+#define PMIC_MPP_AMUX_ROUTE_CH5		0
+#define PMIC_MPP_AMUX_ROUTE_CH6		1
+#define PMIC_MPP_AMUX_ROUTE_CH7		2
+#define PMIC_MPP_AMUX_ROUTE_CH8		3
+#define PMIC_MPP_AMUX_ROUTE_ABUS1	4
+#define PMIC_MPP_AMUX_ROUTE_ABUS2	5
+#define PMIC_MPP_AMUX_ROUTE_ABUS3	6
+#define PMIC_MPP_AMUX_ROUTE_ABUS4	7
+
+/* Analog Output: level */
+#define PMIC_MPP_AOUT_LVL_1V25		0
+#define PMIC_MPP_AOUT_LVL_1V25_2	1
+#define PMIC_MPP_AOUT_LVL_0V625		2
+#define PMIC_MPP_AOUT_LVL_0V3125	3
+#define PMIC_MPP_AOUT_LVL_MPP		4
+#define PMIC_MPP_AOUT_LVL_ABUS1		5
+#define PMIC_MPP_AOUT_LVL_ABUS2		6
+#define PMIC_MPP_AOUT_LVL_ABUS3		7
+
+/* To be used with "function" */
+#define PMIC_MPP_FUNC_NORMAL		"normal"
+#define PMIC_MPP_FUNC_PAIRED		"paired"
+#define PMIC_MPP_FUNC_DTEST1		"dtest1"
+#define PMIC_MPP_FUNC_DTEST2		"dtest2"
+#define PMIC_MPP_FUNC_DTEST3		"dtest3"
+#define PMIC_MPP_FUNC_DTEST4		"dtest4"
+
+#endif
diff --git a/include/dt-bindings/reset/qcom,gcc-msm8916.h b/include/dt-bindings/reset/qcom,gcc-msm8916.h
new file mode 100644
index 000000000000..1f9be10872df
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,gcc-msm8916.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2015 Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_RESET_MSM_GCC_8916_H
+#define _DT_BINDINGS_RESET_MSM_GCC_8916_H
+
+#define GCC_BLSP1_BCR			0
+#define GCC_BLSP1_QUP1_BCR		1
+#define GCC_BLSP1_UART1_BCR		2
+#define GCC_BLSP1_QUP2_BCR		3
+#define GCC_BLSP1_UART2_BCR		4
+#define GCC_BLSP1_QUP3_BCR		5
+#define GCC_BLSP1_QUP4_BCR		6
+#define GCC_BLSP1_QUP5_BCR		7
+#define GCC_BLSP1_QUP6_BCR		8
+#define GCC_IMEM_BCR			9
+#define GCC_SMMU_BCR			10
+#define GCC_APSS_TCU_BCR		11
+#define GCC_SMMU_XPU_BCR		12
+#define GCC_PCNOC_TBU_BCR		13
+#define GCC_PRNG_BCR			14
+#define GCC_BOOT_ROM_BCR		15
+#define GCC_CRYPTO_BCR			16
+#define GCC_SEC_CTRL_BCR		17
+#define GCC_AUDIO_CORE_BCR		18
+#define GCC_ULT_AUDIO_BCR		19
+#define GCC_DEHR_BCR			20
+#define GCC_SYSTEM_NOC_BCR		21
+#define GCC_PCNOC_BCR			22
+#define GCC_TCSR_BCR			23
+#define GCC_QDSS_BCR			24
+#define GCC_DCD_BCR			25
+#define GCC_MSG_RAM_BCR			26
+#define GCC_MPM_BCR			27
+#define GCC_SPMI_BCR			28
+#define GCC_SPDM_BCR			29
+#define GCC_MM_SPDM_BCR			30
+#define GCC_BIMC_BCR			31
+#define GCC_RBCPR_BCR			32
+#define GCC_TLMM_BCR			33
+#define GCC_USB_HS_BCR			34
+#define GCC_USB2A_PHY_BCR		35
+#define GCC_SDCC1_BCR			36
+#define GCC_SDCC2_BCR			37
+#define GCC_PDM_BCR			38
+#define GCC_SNOC_BUS_TIMEOUT0_BCR	39
+#define GCC_PCNOC_BUS_TIMEOUT0_BCR	40
+#define GCC_PCNOC_BUS_TIMEOUT1_BCR	41
+#define GCC_PCNOC_BUS_TIMEOUT2_BCR	42
+#define GCC_PCNOC_BUS_TIMEOUT3_BCR	43
+#define GCC_PCNOC_BUS_TIMEOUT4_BCR	44
+#define GCC_PCNOC_BUS_TIMEOUT5_BCR	45
+#define GCC_PCNOC_BUS_TIMEOUT6_BCR	46
+#define GCC_PCNOC_BUS_TIMEOUT7_BCR	47
+#define GCC_PCNOC_BUS_TIMEOUT8_BCR	48
+#define GCC_PCNOC_BUS_TIMEOUT9_BCR	49
+#define GCC_MMSS_BCR			50
+#define GCC_VENUS0_BCR			51
+#define GCC_MDSS_BCR			52
+#define GCC_CAMSS_PHY0_BCR		53
+#define GCC_CAMSS_CSI0_BCR		54
+#define GCC_CAMSS_CSI0PHY_BCR		55
+#define GCC_CAMSS_CSI0RDI_BCR		56
+#define GCC_CAMSS_CSI0PIX_BCR		57
+#define GCC_CAMSS_PHY1_BCR		58
+#define GCC_CAMSS_CSI1_BCR		59
+#define GCC_CAMSS_CSI1PHY_BCR		60
+#define GCC_CAMSS_CSI1RDI_BCR		61
+#define GCC_CAMSS_CSI1PIX_BCR		62
+#define GCC_CAMSS_ISPIF_BCR		63
+#define GCC_CAMSS_CCI_BCR		64
+#define GCC_CAMSS_MCLK0_BCR		65
+#define GCC_CAMSS_MCLK1_BCR		66
+#define GCC_CAMSS_GP0_BCR		67
+#define GCC_CAMSS_GP1_BCR		68
+#define GCC_CAMSS_TOP_BCR		69
+#define GCC_CAMSS_MICRO_BCR		70
+#define GCC_CAMSS_JPEG_BCR		71
+#define GCC_CAMSS_VFE_BCR		72
+#define GCC_CAMSS_CSI_VFE0_BCR		73
+#define GCC_OXILI_BCR			74
+#define GCC_GMEM_BCR			75
+#define GCC_CAMSS_AHB_BCR		76
+#define GCC_MDP_TBU_BCR			77
+#define GCC_GFX_TBU_BCR			78
+#define GCC_GFX_TCU_BCR			79
+#define GCC_MSS_TBU_AXI_BCR		80
+#define GCC_MSS_TBU_GSS_AXI_BCR		81
+#define GCC_MSS_TBU_Q6_AXI_BCR		82
+#define GCC_GTCU_AHB_BCR		83
+#define GCC_SMMU_CFG_BCR		84
+#define GCC_VFE_TBU_BCR			85
+#define GCC_VENUS_TBU_BCR		86
+#define GCC_JPEG_TBU_BCR		87
+#define GCC_PRONTO_TBU_BCR		88
+#define GCC_SMMU_CATS_BCR		89
+
+#endif
diff --git a/include/dt-bindings/sound/apq8016-lpass.h b/include/dt-bindings/sound/apq8016-lpass.h
new file mode 100644
index 000000000000..dc605c4bc224
--- /dev/null
+++ b/include/dt-bindings/sound/apq8016-lpass.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_APQ8016_LPASS_H
+#define __DT_APQ8016_LPASS_H
+
+#include <dt-bindings/sound/qcom,lpass.h>
+
+/* NOTE: Use qcom,lpass.h to define any AIF ID's for LPASS */
+
+#endif /* __DT_APQ8016_LPASS_H */
diff --git a/include/dt-bindings/sound/qcom,lpass.h b/include/dt-bindings/sound/qcom,lpass.h
new file mode 100644
index 000000000000..a9404c3b8884
--- /dev/null
+++ b/include/dt-bindings/sound/qcom,lpass.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __DT_QCOM_LPASS_H
+#define __DT_QCOM_LPASS_H
+
+#define MI2S_PRIMARY	0
+#define MI2S_SECONDARY	1
+#define MI2S_TERTIARY	2
+#define MI2S_QUATERNARY	3
+#define MI2S_QUINARY	4
+
+#define LPASS_DP_RX	5
+
+#define LPASS_CDC_DMA_RX0 6
+#define LPASS_CDC_DMA_RX1 7
+#define LPASS_CDC_DMA_RX2 8
+#define LPASS_CDC_DMA_RX3 9
+#define LPASS_CDC_DMA_RX4 10
+#define LPASS_CDC_DMA_RX5 11
+#define LPASS_CDC_DMA_RX6 12
+#define LPASS_CDC_DMA_RX7 13
+#define LPASS_CDC_DMA_RX8 14
+#define LPASS_CDC_DMA_RX9 15
+
+#define LPASS_CDC_DMA_TX0 16
+#define LPASS_CDC_DMA_TX1 17
+#define LPASS_CDC_DMA_TX2 18
+#define LPASS_CDC_DMA_TX3 19
+#define LPASS_CDC_DMA_TX4 20
+#define LPASS_CDC_DMA_TX5 21
+#define LPASS_CDC_DMA_TX6 22
+#define LPASS_CDC_DMA_TX7 23
+#define LPASS_CDC_DMA_TX8 24
+
+#define LPASS_CDC_DMA_VA_TX0 25
+#define LPASS_CDC_DMA_VA_TX1 26
+#define LPASS_CDC_DMA_VA_TX2 27
+#define LPASS_CDC_DMA_VA_TX3 28
+#define LPASS_CDC_DMA_VA_TX4 29
+#define LPASS_CDC_DMA_VA_TX5 30
+#define LPASS_CDC_DMA_VA_TX6 31
+#define LPASS_CDC_DMA_VA_TX7 32
+#define LPASS_CDC_DMA_VA_TX8 33
+
+#define LPASS_MCLK0	0
+
+#endif /* __DT_QCOM_LPASS_H */

-- 
2.42.1

