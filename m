Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96159C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 11:02:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CE3F81761;
	Tue,  4 Mar 2025 12:01:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="FehXMtNg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0DB58171B; Tue,  4 Mar 2025 12:01:57 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E008881668
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 12:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249dp9p009558;
 Tue, 4 Mar 2025 11:01:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jiiGTbEMQFJol1saFv7TkY992WIK4mkfKAjMJYJtF3k=; b=FehXMtNg47brAgeo
 byPDbBh2+9CkpA+cFeLidyKAqUIh8IG2001sAFDHTP6SDc44gY836Nsxkux3u339
 FQ1Ls5gSvrV0T+s2OZ6gGYHm7qrs7+ys+UzpxBMtb/ubojJ0Pgs3J55snrmY8M09
 OGLiQ6NSfTNdHTINf2d1m52wmBPiZr8JlLljY8Gn6+qV/rDheo9veBRtjrUs0747
 zaKGTLZKZFHD6Ne+aqwKEOUvqDhhFlK3Dbh+/CwHaA2C1Mibx/jvJzZHS6VfVr3w
 bapbdCcFvTVAD3LW8TaynQZ7dv4pKGug8cHX5Q7MAko1XOJBEaNAAYgBs/O0r1zb
 q2fskg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6whkmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 11:01:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 524B1VCh009718
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 4 Mar 2025 11:01:31 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Mar 2025 03:01:26 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>, <sjg@chromium.org>,
 <robert.marko@sartura.hr>, <dmitry.baryshkov@linaro.org>,
 <andersson@kernel.org>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v1 2/6] dts: ipq5424-rdp466-u-boot: add override dtsi
Date: Tue, 4 Mar 2025 16:31:01 +0530
Message-ID: <20250304110105.2762124-3-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304110105.2762124-1-quic_varada@quicinc.com>
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=EZcyQOmC c=1 sm=1 tr=0 ts=67c6dd8c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=m6fOrmujMtd2gMnK7EkA:9
 a=RVmHIydaz68A:10
 a=I1ZxD-czmY_n22Qsbli9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: MZhkue_mXdbcXrqgKZ0PmOwgU9cz3M3H
X-Proofpoint-ORIG-GUID: MZhkue_mXdbcXrqgKZ0PmOwgU9cz3M3H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040093
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

Add initial support for the IPQ5424 MMC based RDP platforms.
Define memory layout statically.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi | 37 +++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi

diff --git a/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
new file mode 100644
index 0000000000..9e4af4d9f7
--- /dev/null
+++ b/arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IPQ5424 RDP466 board device tree source
+ *
+ * Copyright (c) 2025 The Linux Foundation. All rights reserved.
+ */
+
+/ {
+	/* Will be removed when SMEM parsing is updated */
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x20000000>;
+	};
+
+};
+
+	&sdhc {
+		sdhci-caps-mask = <0x0 0x04000000>;
+		sdhci-caps = <0x0 0x04000000>;	/* SDHCI_CAN_VDD_180 */
+		mmc-ddr-1_8v;
+		mmc-hs200-1_8v;
+		max-frequency = <192000000>;
+		bus-width = <4>;
+		pinctrl-0 = <&sdc_default_state>;
+		pinctrl-names = "default";
+		non-removable;
+
+		/*
+		 * This reset is needed to clear out the settings done by
+		 * previous boot loader. Without this the SDHCI_RESET_ALL
+		 * reset done sdhci_init() times out.
+		 */
+		resets = <&gcc GCC_SDCC_BCR>;
+
+		status = "okay";
+	};
+
-- 
2.34.1

