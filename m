Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5EDC021A9
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 08:55:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07DC080F18;
	Tue, 18 Feb 2025 09:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="kzFWK7ZN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1697780F18; Tue, 18 Feb 2025 09:55:20 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB5B880BAE
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 09:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51HLj1sg017386;
 Tue, 18 Feb 2025 08:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bGrNkEncmVn+JovQxeURserO6bjA5X+z2+C+rN58jzk=; b=kzFWK7ZNF7mYB6vI
 OXSjMKtZzf54ubsYa9Ywxme2dDlpiU/e9kceyU2BFillSSzZm14VRYrVB7SQxIte
 OB2YsN2O0o2ghOCIl5uT1KJf1OAcFSoTR+552XkngRQyhJSDSUSVxn0f6BUWJIW5
 FR8nLqC9lUf1va0lftvv+MzeZW7hCHy/q9EyTrBFGfUG5Z0rGeyyCwH7fFSm9qFA
 lvWJ4gadnUQ3W1WN8/rnvtraAjRlwKEZEaVq7H+q85ynKjDgQGfExOH11bK6J+ng
 LUM55OuukeByZbpgXgUTeSFnUByeEMvEIvNu+G3suFPFUs4ZWgBy2sCPX7dd5PfP
 k43mTw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7sm7k4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Feb 2025 08:55:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51I8t0Ff007418
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Feb 2025 08:55:00 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Feb 2025 00:54:54 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <sjg@chromium.org>, <lehmanju@devpi.de>, <Volodymyr_Babchuk@epam.com>,
 <marek.vasut+renesas@mailbox.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v3 2/8] dts: ipq9574-rdp433-u-boot: add override dtsi
Date: Tue, 18 Feb 2025 14:24:24 +0530
Message-ID: <20250218085430.2422287-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218085430.2422287-1-quic_varada@quicinc.com>
References: <20250218085430.2422287-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: _jKB_PVtSWxeVro1OqpQ4_62QHOyzgJy
X-Proofpoint-ORIG-GUID: _jKB_PVtSWxeVro1OqpQ4_62QHOyzgJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502180068
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
v3: Fix comments and give additional details
    No code change

v2: Use upstream and override DT instead of own DT
---
 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi

diff --git a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
new file mode 100644
index 0000000000..390e2338d6
--- /dev/null
+++ b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+/ {
+	/* Will be removed when SMEM parsing is updated */
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0x0 0x40000000 0x0 0x40000000>,
+		      <0x0 0x4a500000 0x0 0x00100000>;
+	};
+};
+
+&sdhc_1 {
+	sdhci-caps-mask = <0x0 0x04000000>;
+	sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
+
+	/*
+	 * This reset is needed to clear out the settings done by
+	 * previous boot loader. Without this the SDHCI_RESET_ALL
+	 * reset done sdhci_init() times out.
+	 */
+	resets = <&gcc GCC_SDCC_BCR>;
+};
-- 
2.34.1

