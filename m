Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463DBC83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 10:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3C3082FCA;
	Tue, 15 Jul 2025 12:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="TRe+8gwW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BCD7801BE; Tue, 15 Jul 2025 12:16:14 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 062CC82F14
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 12:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F8krO8027645;
 Tue, 15 Jul 2025 10:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lETQKozsOhomxeo3QCqP7SMnuuFi6JpoOVlfnDded9o=; b=TRe+8gwWtLhb0qD1
 tN4t7ceW37YCkZZS3ujyL8ccZJO16deUZ8pttC/lN6iXBMP1ag91Tf/hSRkxG33q
 DwPmzAFs9rpiLTs3KIqnF4JQU5LuTTDPXG+jlCgPYIbBa4FPxfgDGPetMqxGNnQ8
 m30AUWEbvDnjRfe88Y6xFHxUUNYMqTLq7yznD1v5nPATlqfG/fWZ2RtRu9UAC/IO
 2qMdAb3S+ccWatNoY82IFzaXENdamW5ssNae14GLa6ajTsJQZV4PATtlv6VGP5Gz
 9En0uCCwMmFIOcaFOtsgilYRtQd9OJ4FGNG99FiFq0HoezQob5S04N86ipWN/fEI
 FuFMnQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wkrugb78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 10:15:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56FAFvA3013838
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 10:15:57 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 03:15:53 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <marek.vasut+renesas@mailbox.org>, <bhupesh.linux@gmail.com>,
 <alexeymin@postmarketos.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
Subject: [PATCH v1 1/6] clk/qcom: Add USB related clocks for IPQ9574
Date: Tue, 15 Jul 2025 15:45:33 +0530
Message-ID: <20250715101538.4072985-2-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715101538.4072985-1-quic_varada@quicinc.com>
References: <20250715101538.4072985-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: iPQFoO9uIKxpvs4NvYpPhH8WW9Aer6pN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5MyBTYWx0ZWRfX9SakSIegeM4C
 qaaboQw3ofjdHrPwxXNsmXxzw4I70VmykLPrim45o1jhpm/LC4oFxfWuL+sxkXNRpLLfM8BHdz7
 KKHXD8OblotxL3WO1yCMO5Mq4DqU6sbdzPOGOc0F9JZZKQpHwgghovz49dIEuyGJexp6XM1blb/
 ocOxQ2QIdqA7Ct4FqctOH8hwuufz6t96P4C4cajUtOftPfj8P58rDz8cLCKovHKyOQ4Vnt47HMo
 Dvnj8CLfDXm46uCvixzp2W5TxopBt1XDtldvzfodLHZ2WKhtFYspB8Em/2eaoAKrHC1PLBaXbtF
 UybTmNg8kGiUcHniXecYs0QfHi/MVjpHgCYiaPxoBcOi2ATdLi++HlRjUYQw2r+0kc3O7ldL2Cm
 l1u409+wZ2Tq0JraqcuaV7LoeagVKIZbRMRTOwLw3EpgwoaXniPvIDeZ/2nbH40a+S1uRC5G
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=68762a5d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=fbqHkSEcfmD6VvpdCmIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: iPQFoO9uIKxpvs4NvYpPhH8WW9Aer6pN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507150093
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

Add the USB controller and phy related clocks.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/clk/qcom/clock-ipq9574.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/qcom/clock-ipq9574.c b/drivers/clk/qcom/clock-ipq9574.c
index b0af4036059..1f5146b29a1 100644
--- a/drivers/clk/qcom/clock-ipq9574.c
+++ b/drivers/clk/qcom/clock-ipq9574.c
@@ -25,6 +25,9 @@
 #define GCC_SDCC1_AHB_CBCR			0x33034
 #define GCC_SDCC1_APPS_CMD_RCGR			0x33004
 #define GCC_SDCC1_ICE_CORE_CBCR			0x33030
+#define GCC_USB0_MASTER_CMD_RCGR		0x2c004
+#define GCC_USB0_MOCK_UTMI_CMD_RCGR		0x2c02c
+#define GCC_USB0_AUX_CMD_RCGR			0x2C018
 
 static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
 {
@@ -39,6 +42,17 @@ static ulong ipq9574_set_rate(struct clk *clk, ulong rate)
 		clk_rcg_set_rate_mnd(priv->base, GCC_SDCC1_APPS_CMD_RCGR,
 				     11, 0, 0, CFG_CLK_SRC_GPLL2, 16);
 		return rate;
+	case GCC_USB0_MASTER_CLK:
+		clk_rcg_set_rate(priv->base, GCC_USB0_MASTER_CMD_RCGR,
+				 4, CFG_CLK_SRC_GPLL0);
+		return rate;
+	case GCC_USB0_MOCK_UTMI_CLK:
+		clk_rcg_set_rate_mnd(priv->base, GCC_USB0_MOCK_UTMI_CMD_RCGR,
+				     0, 0, 0, CFG_CLK_SRC_CXO, 8);
+		return rate;
+	case GCC_USB0_AUX_CLK:
+		clk_rcg_set_rate_mnd(priv->base, GCC_USB0_AUX_CMD_RCGR, 0, 0, 0,
+				     CFG_CLK_SRC_CXO, 8);
 	default:
 		return -EINVAL;
 	}
@@ -50,6 +64,14 @@ static const struct gate_clk ipq9574_clks[] = {
 	GATE_CLK(GCC_SDCC1_AHB_CLK,		0x33034, 0x00000001),
 	GATE_CLK(GCC_SDCC1_APPS_CLK,		0x3302C, 0x00000001),
 	GATE_CLK(GCC_SDCC1_ICE_CORE_CLK,	0x33030, 0x00000001),
+	GATE_CLK(GCC_SNOC_USB_CLK,		0x2e058, 0x00000001),
+	GATE_CLK(GCC_USB0_MASTER_CLK,		0x2c044, 0x00000001),
+	GATE_CLK(GCC_ANOC_USB_AXI_CLK,		0x2e084, 0x00000001),
+	GATE_CLK(GCC_USB0_SLEEP_CLK,		0x2c058, 0x00000001),
+	GATE_CLK(GCC_USB0_MOCK_UTMI_CLK,	0x2c04c, 0x00000001),
+	GATE_CLK(GCC_USB0_PHY_CFG_AHB_CLK,	0x2c05c, 0x00000001),
+	GATE_CLK(GCC_USB0_AUX_CLK,		0x2c048, 0x00000001),
+	GATE_CLK(GCC_USB0_PIPE_CLK,		0x2c054, 0x00000001),
 };
 
 static int ipq9574_enable(struct clk *clk)
@@ -67,6 +89,10 @@ static int ipq9574_enable(struct clk *clk)
 }
 
 static const struct qcom_reset_map ipq9574_gcc_resets[] = {
+	[GCC_USB_BCR] = { 0x2c000 },
+	[GCC_QUSB2_0_PHY_BCR] = { 0x2c068 },
+	[GCC_USB0_PHY_BCR] = {0x2c06c, 0},
+	[GCC_USB3PHY_0_PHY_BCR] = {0x2c070, 0},
 	[GCC_SDCC_BCR] = { 0x33000 },
 };
 
@@ -75,6 +101,8 @@ static struct msm_clk_data ipq9574_gcc_data = {
 	.num_resets = ARRAY_SIZE(ipq9574_gcc_resets),
 	.enable = ipq9574_enable,
 	.set_rate = ipq9574_set_rate,
+	.clks = ipq9574_clks,
+	.num_clks = ARRAY_SIZE(ipq9574_clks),
 };
 
 static const struct udevice_id gcc_ipq9574_of_match[] = {
-- 
2.34.1

