Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2DFE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 05:09:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A3D80690;
	Fri, 10 Jan 2025 06:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="SW8n5FIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C94280658; Fri, 10 Jan 2025 06:09:04 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B20280613
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 06:09:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50A3cb38004501;
 Fri, 10 Jan 2025 05:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hBi0XybIM2EFUOLEFBO3d9oVRvV8z423wtPxdQNjMbw=; b=SW8n5FIok48kMcBk
 Bj+hqpQJGtPD9N5vJ5yllTsmFeEKFb90b1vIY2L3VTPYGPxEhS3tenxzCrvfHE0H
 1OZ+8jFdjQPm7ucT7LJ8deKjRn/0dH3a4XHGT5z7To9dwr7crm8EN1JAMavhzQA4
 RxIToMjx8hLBdY1nEjvPnfsfwoghG5iZ4pnvU7IteSB1N6wykJ1gQtEuNaBKUtOF
 y1tks/yycySl74AMFpxS4F5XAraMHGVozov3FiysjpH4s2ljNDT3eEVoMbkE55he
 uNTE7XJrvISYNqYaqPqY8zSc7FA/Q0kjZTYxqB25NJM3F9tZHviSMipc3RuY2Qmr
 62CcdQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442uteg50f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 05:08:47 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A58k6n003231
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 05:08:46 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 21:08:41 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>, <sjg@chromium.org>,
 <ilias.apalodimas@linaro.org>, <Volodymyr_Babchuk@epam.com>,
 <lehmanju@devpi.de>, <bhupesh.linux@gmail.com>,
 <konradybcio@kernel.org>, <quic_tengfan@quicinc.com>,
 <andersson@kernel.org>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v3 2/6] dts: qcs9100-ride-r3-u-boot: add override dtsi
Date: Fri, 10 Jan 2025 10:38:13 +0530
Message-ID: <20250110050817.3819282-3-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: i5NTk0ckePF5LykNV3qvWCtLU5aROoq9
X-Proofpoint-ORIG-GUID: i5NTk0ckePF5LykNV3qvWCtLU5aROoq9
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

Add initial support for the QCS9100 (derived from SA8775p) Ride platforms.
Define memory layout statically.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Add one more range to memory definition
    Fix couple of uppercase hex digits
    Drop arch/arm/dts/sa8775p-*.dtsi and use qcs9100 files
---
 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi

diff --git a/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi b/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
new file mode 100644
index 0000000000..5905dfad18
--- /dev/null
+++ b/arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/ {
+	/* Will be removed when bootloader updates later */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x3ee00000>,
+		      <0x0 0xc0000000 0x0 0x04d00000>,
+		      <0xd 0x00000000 0x2 0x54100000>,
+		      <0xa 0x80000000 0x1 0x52d00000>,
+		      <0x9 0x00000000 0x1 0x80000000>,
+		      <0x1 0x00000000 0x2 0xf7500000>,
+		      <0x0 0xd0000000 0x0 0x00100000>,
+		      <0x0 0xd3500000 0x0 0x07c00000>,
+		      <0x0 0xdb300000 0x0 0x24d00000>;
+	};
+};
-- 
2.34.1

