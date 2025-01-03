Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48672E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 05:14:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D802580374;
	Fri,  3 Jan 2025 06:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="U3tU2Mzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D7C4800D7; Fri,  3 Jan 2025 06:14:41 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AC2E80196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 06:14:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5030w2GE029307;
 Fri, 3 Jan 2025 05:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RUVDmXEraZP2j3GHS0JoYsJlySgdMxqL01vTcDQmdLc=; b=U3tU2MzbP5wtd8wI
 0f7aZEEWrwfNHGQ1tgJHt6kiyk4hfL9E+e33ZGItO7QyHcHKWn6wrEbDeby5DO9V
 oxJMnm7D3ppjEQXvst8GOJsYFIKpTWAwJ76cniCEvy+IWPlkzjvwHCMIpR34deQn
 FQjpmwXXWe0IoqN3y7BJ0aSKn6gUm2W7t8dWaFH+EXZUspXIWU3tofnaiKm3/mgx
 M3PTJm8cE+zELjF1EXaFnkPljMu7vnvrP3tO4XtMdwhpGYzX4s+69t+3QBBlGso+
 GpMbKYcgLltxtps6lpN9OqOVJFcdaHWu5Maxhb6evBOyF5T+qat3jgf+Ui9QKhWe
 +bAKTg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43x24artqr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 05:14:26 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5035EP5l015739
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 3 Jan 2025 05:14:25 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 Jan 2025 21:14:21 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>,
 <bhupesh.linux@gmail.com>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v1 1/5] dts: sa8775p-ride-r3-u-boot: add override dtsi
Date: Fri, 3 Jan 2025 10:44:00 +0530
Message-ID: <20250103051404.1965469-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103051404.1965469-1-quic_varada@quicinc.com>
References: <20250103051404.1965469-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: J8AoZKxFe0gKHmpeTcKnurUn1oedo-MC
X-Proofpoint-ORIG-GUID: J8AoZKxFe0gKHmpeTcKnurUn1oedo-MC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 mlxlogscore=964 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030042
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
 arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi | 22 ++++++++++++++++++++++
 arch/arm/dts/sa8775p-ride-u-boot.dtsi    | 11 +++++++++++
 2 files changed, 33 insertions(+)
 create mode 100644 arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
 create mode 100644 arch/arm/dts/sa8775p-ride-u-boot.dtsi

diff --git a/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
new file mode 100644
index 0000000000..7d01d5f6a1
--- /dev/null
+++ b/arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/ {
+	model = "Qualcomm QCS9100 Ride Rev3";
+	compatible = "qcom,qcs9100-ride-r3", "qcom,qcs9100", "qcom,sa8775p";
+
+	/* Will be removed when bootloader updates later */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x3ee00000>,
+		      <0x0 0xc0000000 0x0 0x04d00000>,
+		      <0xD 0x00000000 0x2 0x54100000>,
+		      <0xA 0x80000000 0x1 0x52d00000>,
+		      <0x9 0x00000000 0x1 0x80000000>,
+		      <0x1 0x00000000 0x2 0xf7500000>,
+		      <0x0 0xd0000000 0x0 0x00100000>,
+		      <0x0 0xd3500000 0x0 0x07c00000>;
+	};
+};
diff --git a/arch/arm/dts/sa8775p-ride-u-boot.dtsi b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
new file mode 100644
index 0000000000..979462dfec
--- /dev/null
+++ b/arch/arm/dts/sa8775p-ride-u-boot.dtsi
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+/dts-v1/;
+
+#include "sa8775p-ride.dts"
+/ {
+	model = "Qualcomm QCS9100 Ride";
+	compatible = "qcom,qcs9100-ride", "qcom,qcs9100", "qcom,sa8775p";
+};
-- 
2.34.1

