Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25434C021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 06:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE3F080F96;
	Tue, 25 Feb 2025 07:53:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="KdFkeml2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CE6180F92; Tue, 25 Feb 2025 07:53:53 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84DE380F3F
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 07:53:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P0RjQV028975;
 Tue, 25 Feb 2025 06:53:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ehTPasRDwbGuGkpJsb4WeEAXh4pIJO/tNyxoIAUsVIg=; b=KdFkeml2biNpIyus
 NdNqii6yEbTEV5RH7sbI8JHsVW17+eD9tmq3hPk1jFw+M9YgeYoohyXsyYKqChKX
 IkIIcFzgposKVW8xJWpbRNhL7FIzkwxf62F8JsmNUdTANKehfvHjwp1LI8/xUy3M
 ZHEWXZ1cEIIewfGgYnGJ3wjhpwU4vH0BgvzMsD0q3YxyisEyGTkFOwex4Qbb3nMm
 Qn2YZH7QNQr2OfPw1oFIAXdWsL9o2WkcklLbqwF2qG/NXFdZoNgqtCsf0YmcYjMs
 7kpRyLGzTLtl1UvwwI8jBmPwnxZAURDThOmufRtJTHS/cxmiSs3O7vrrcv6z5g0k
 WPPKYQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7rjypwm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 06:53:31 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51P6rUkJ021419
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Feb 2025 06:53:31 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 24 Feb 2025 22:53:25 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <lehmanju@devpi.de>,
 <Volodymyr_Babchuk@epam.com>, <sjg@chromium.org>,
 <pbrobinson@gmail.com>, <marek.vasut+renesas@mailbox.org>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v5 2/7] dts: ipq9574-rdp433-u-boot: add override dtsi
Date: Tue, 25 Feb 2025 12:22:58 +0530
Message-ID: <20250225065303.342174-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225065303.342174-1-quic_varada@quicinc.com>
References: <20250225065303.342174-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: e1KOwicUAbkkBqQO4KF8mwsvaQjD4igF
X-Proofpoint-ORIG-GUID: e1KOwicUAbkkBqQO4KF8mwsvaQjD4igF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250044
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

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Add 'Reviewed-by: Caleb Connolly'
v3: Fix comments and give additional details
    No code change

v2: Use upstream and override DT instead of own DT
---
 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi

diff --git a/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi b/arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
new file mode 100644
index 00000000000..390e2338d65
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

