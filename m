Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7998C0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 05:38:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 776AE80C85;
	Thu, 30 Jan 2025 06:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="oWGmNhnH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E864380ADF; Thu, 30 Jan 2025 06:38:38 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9499E817C4
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 06:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TIlZuG000800;
 Thu, 30 Jan 2025 05:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vKv2tHZXPRxqaFyPT0PxIbPjLMXC4OTQKxc8YJ24yHo=; b=oWGmNhnH8VBYDDjS
 g+5NYEvVMoahQPvV/5vYEmyltIGUh5KzZUZ5YozaxsDO+TnAEkYYJ9N6SjDE1R7W
 Xo8JcpS6cjkkO+9MMKak7RattG/0pJh2IPJH1WMGS1Wq2zOY1j7EFPxCsVhpvtAi
 kq5E8HJiCebKTvL7I3/LYcRL+FyqeeEQ+Y2S9Puqd4u8XhijWXwgwHdxX0U9jM62
 MlOC8qBfMc7gvpJTJs1tDPyrf/xQD06VLI4dfPHvT9X6fxja1me0wOd4JvWMpQdj
 nhHo/t13vApMAx3gCWjJ8FBSoFE68vymgEZBqoywmjMNxwGdkPTVIuKpcgOse3qi
 O616EQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fswys5br-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 05:38:17 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U5cHM4027820
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 05:38:17 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 21:38:11 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <sjg@chromium.org>, <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>,
 <pbrobinson@gmail.com>, <marek.vasut+renesas@mailbox.org>,
 <robert.marko@sartura.hr>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v2 1/6] dts: ipq9574-rdp433-u-boot: add override dtsi
Date: Thu, 30 Jan 2025 11:07:46 +0530
Message-ID: <20250130053751.3148614-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130053751.3148614-1-quic_varada@quicinc.com>
References: <20250130053751.3148614-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: Azu1MyrQvgXZWeEEwnFw2r2cXWjSpZQn
X-Proofpoint-GUID: Azu1MyrQvgXZWeEEwnFw2r2cXWjSpZQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300041
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

Add initial support for the IPQ9574 MMC based RDP platforms.
Define memory layout statically.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v2: Use upstream and override DT instead of own DT
---
 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi

diff --git a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
new file mode 100644
index 0000000000..71832d350b
--- /dev/null
+++ b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/ {
+	/* Will be removed when bootloader updates later */
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x0 0x40000000>,
+		      <0x0 0x4a500000 0x0 0x00100000>;
+	};
+};
+
+&sdhc_1 {
+	sdhci-caps-mask = <0x0 0x04000000>;
+	sdhci-caps = <0x0 0x04000000>;
+	resets = <&gcc GCC_SDCC_BCR>;
+};
-- 
2.34.1

