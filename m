Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDA4E77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 05:26:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 252D5800D0;
	Thu,  9 Jan 2025 06:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="QeIjXMjw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B20B48001F; Thu,  9 Jan 2025 06:26:31 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FDCE80609
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 06:26:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508Jt2jH013190;
 Thu, 9 Jan 2025 05:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ptiUsGJHzFTQaHrD2UjIFnawAwZiMPD36Ii+wGlFEUA=; b=QeIjXMjwe2kBWWNx
 5Dnt3PwssVQmHDQH9IPqP1ZgZAeVwNdk71lC703iOzhbyeyLG+mq/lwEqgqwaCuJ
 4wQqaTwI+rA4Qh2/HKafb0/o4wBEsFG4Qa7G/6eZ+5FuYyo6GdlThs9XWnllULpF
 uiGWyctKpBpD4diXPc+lEQ8ImPW7H3tjzaOoW2eJxxGjE2tuRmF6FY/oHY23N/L4
 8av15jrAmcJse14OTN0hYIRadEPxBPMjCEfTY8I3TwTKhHQyaOhs7LxrSxTpKhlT
 l/Q45r8lVm3HdRpxcI/7I9C2h4uxZYRaMf/nX/wwMEF7vs/CEgsgVS+Xbq+z6eKT
 OwlOAg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 441yxbs3ee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 09 Jan 2025 05:26:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5095Q8H2029597
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 9 Jan 2025 05:26:08 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 8 Jan 2025 21:26:03 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>,
 <bhupesh.linux@gmail.com>, <andersson@kernel.org>,
 <quic_tengfan@quicinc.com>, <konradybcio@kernel.org>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v2 1/6] arm64: dts: qcom: qcs9100: Add support for the QCS9100
 Ride and Ride Rev3 boards
Date: Thu, 9 Jan 2025 10:55:40 +0530
Message-ID: <20250109052545.2921502-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250109052545.2921502-1-quic_varada@quicinc.com>
References: <20250109052545.2921502-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 6gaAC3hS4qbL6aCo7ZdG-2BguvhkrG5l
X-Proofpoint-ORIG-GUID: 6gaAC3hS4qbL6aCo7ZdG-2BguvhkrG5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 mlxscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090042
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

From: Tengfei Fan <quic_tengfan@quicinc.com>

Add device tree support for the QCS9100 Ride and Ride Rev3 boards. The
QCS9100 is a variant of the SA8775p, and they are fully compatible with
each other. The QCS9100 Ride/Ride Rev3 board is essentially the same as
the SA8775p Ride/Ride Rev3 board, with the QCS9100 SoC mounted instead
of the SA8775p.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Link: https://lore.kernel.org/r/20240911-add_qcs9100_support-v2-4-e43a71ceb017@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

[ upstream commit: 7dcc1dfaa3d1cd3aafed2beb7086ed34fdb22303 ]

(cherry picked from commit db6231faa8ef46e5ff5d5ece0c930a07c6358562)
---
 dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts | 11 +++++++++++
 dts/upstream/src/arm64/qcom/qcs9100-ride.dts    | 11 +++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts
 create mode 100644 dts/upstream/src/arm64/qcom/qcs9100-ride.dts

diff --git a/dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts b/dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts
new file mode 100644
index 00000000000..759d1ec694b
--- /dev/null
+++ b/dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+/dts-v1/;
+
+#include "sa8775p-ride-r3.dts"
+/ {
+	model = "Qualcomm QCS9100 Ride Rev3";
+	compatible = "qcom,qcs9100-ride-r3", "qcom,qcs9100", "qcom,sa8775p";
+};
diff --git a/dts/upstream/src/arm64/qcom/qcs9100-ride.dts b/dts/upstream/src/arm64/qcom/qcs9100-ride.dts
new file mode 100644
index 00000000000..979462dfec3
--- /dev/null
+++ b/dts/upstream/src/arm64/qcom/qcs9100-ride.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
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

