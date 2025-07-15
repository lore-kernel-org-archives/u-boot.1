Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EC9C83F1D
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 10:16:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C60C83082;
	Tue, 15 Jul 2025 12:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="NOxq0O2p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CAF082F14; Tue, 15 Jul 2025 12:16:14 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BBDC82F6F
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 12:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F63gB3028095;
 Tue, 15 Jul 2025 10:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RxU5EPjw/QpT8AuhlTH2NffMAqvELFgmXutm8F7NJzQ=; b=NOxq0O2pFSb1Hb7Y
 gWmvn8V51e92WG9UkfQfh3ZsFXaA5QqjkwdF4ZlnwO2UXk/vtQiTEgP3TnLgK22K
 8yzXrufls1Q3AewKAIAv2XuxvjAoF25DVXVuFqw9j1nhEtFXoR0zmRWplklO5pe3
 twO0EG8cSA/vJuNawAeYwxnm2xxf0UXG1G7XeSTF7C8nNo6IPQurI/Ejv+ttfkms
 gV6QtlzW6p7bGSlylIowyrmkcfb/S8FbSd+SXKZObEtdSGCV5rngMQPur0LVZoH1
 nx7RIByeNmVEX+9Ik+iFvO9p4oPCWZVlKtetBlkJCh0ygDGs8zSblzCCR3ALOdf/
 7tbPPw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5drjknd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 10:16:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56FAG0j3032002
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 10:16:00 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 03:15:57 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <marek.vasut+renesas@mailbox.org>, <bhupesh.linux@gmail.com>,
 <alexeymin@postmarketos.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
Subject: [PATCH v1 2/6] phy: Add IPQ9574 support to Qualcomm QUSB2 phy
Date: Tue, 15 Jul 2025 15:45:34 +0530
Message-ID: <20250715101538.4072985-3-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 5TI_N95mf3kR3_vXteLl_Ca6DlQAK5af
X-Authority-Analysis: v=2.4 cv=D4xHKuRj c=1 sm=1 tr=0 ts=68762a61 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=pu-n0UOZ9_MS58F_REYA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5TI_N95mf3kR3_vXteLl_Ca6DlQAK5af
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5MyBTYWx0ZWRfX5dMTTDXzsnPc
 mdLMx8sVph+8P9cjC7uBihW8NZCELOFl+MwZijgZv2AGV5K7rtrTNpls/aTtPhWLTFFrU/VFEGd
 ryegMxSsUZtc9GxcxnuJbI6x6VDIm0XTzOh+ivsMKXkfCGr8GhwqFqaHJbgCQ0cKQJcrUPm5whi
 5kG8P/P85e/aAklNOK0EegIGreu+oD2ZF5IoW2haGTQ4WImAe0b1KePz1xtBPiM3spGsPrBdGGc
 /2Wu3b2byL2rLBqXW29ntcOREZdQJlpV2PHSJahxbs282y7MwFAwRd3v6aND3GQX66w5tJI+73y
 x26EYQIS2Y3abBeGD3TclIV9VV+qbRFGd3YD7SUfCVnLZGkiHT9uJgxinCzs6BB5H/6Tt+WO/IB
 Hhdi0xUFUKzV+PLY2L9du2L0MYsBxHCd6zl4U6mhu6OqJOzQxtOITruqRG7vIufVBv0RMycc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
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

Imported from Linux driver.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 drivers/phy/qcom/phy-qcom-qusb2.c | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/phy/qcom/phy-qcom-qusb2.c b/drivers/phy/qcom/phy-qcom-qusb2.c
index d98f6108e69..df82f2a99da 100644
--- a/drivers/phy/qcom/phy-qcom-qusb2.c
+++ b/drivers/phy/qcom/phy-qcom-qusb2.c
@@ -152,6 +152,22 @@ enum qusb2phy_reg_layout {
 		.offset = o, .val = v, .in_layout = 1, \
 	}
 
+static const struct qusb2_phy_init_tbl ipq6018_init_tbl[] = {
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL, 0x14),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xF8),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0xB3),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE3, 0x83),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE4, 0xC0),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TUNE, 0x30),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL1, 0x79),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_USER_CTL2, 0x21),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE5, 0x00),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
+	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TEST2, 0x14),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_TEST, 0x80),
+	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_AUTOPGM_CTL1, 0x9F),
+};
+
 static const struct qusb2_phy_init_tbl sm6115_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE1, 0xf8),
 	QUSB2_PHY_INIT_CFG_L(QUSB2PHY_PORT_TUNE2, 0x53),
@@ -168,6 +184,19 @@ static const struct qusb2_phy_init_tbl sm6115_init_tbl[] = {
 	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_PWR_CTRL, 0x00),
 };
 
+static const unsigned int ipq6018_regs_layout[] = {
+	[QUSB2PHY_PLL_STATUS]		= 0x38,
+	[QUSB2PHY_PORT_TUNE1]		= 0x80,
+	[QUSB2PHY_PORT_TUNE2]		= 0x84,
+	[QUSB2PHY_PORT_TUNE3]		= 0x88,
+	[QUSB2PHY_PORT_TUNE4]		= 0x8C,
+	[QUSB2PHY_PORT_TUNE5]		= 0x90,
+	[QUSB2PHY_PORT_TEST1]		= 0x98,
+	[QUSB2PHY_PORT_TEST2]		= 0x9C,
+	[QUSB2PHY_PORT_POWERDOWN]	= 0xB4,
+	[QUSB2PHY_INTR_CTRL]		= 0xBC,
+};
+
 static const unsigned int sm6115_regs_layout[] = {
 	[QUSB2PHY_PLL_STATUS] = 0x38,	  [QUSB2PHY_PORT_TUNE1] = 0x80,
 	[QUSB2PHY_PORT_TUNE2] = 0x84,	  [QUSB2PHY_PORT_TUNE3] = 0x88,
@@ -224,6 +253,17 @@ static const unsigned int qusb2_v2_regs_layout[] = {
 	[QUSB2PHY_INTR_CTRL] = 0x230,
 };
 
+static const struct qusb2_phy_cfg ipq6018_phy_cfg = {
+	.tbl            = ipq6018_init_tbl,
+	.tbl_num        = ARRAY_SIZE(ipq6018_init_tbl),
+	.regs           = ipq6018_regs_layout,
+
+	.disable_ctrl   = POWER_DOWN,
+	.mask_core_ready = PLL_LOCKED,
+	/* autoresume not used */
+	.autoresume_en   = BIT(0),
+};
+
 static const struct qusb2_phy_cfg sm6115_phy_cfg = {
 	.tbl = sm6115_init_tbl,
 	.tbl_num = ARRAY_SIZE(sm6115_init_tbl),
@@ -455,6 +495,8 @@ static const struct udevice_id qusb2phy_ids[] = {
 	  .data = (ulong)&sm6115_phy_cfg },
 	{ .compatible = "qcom,sdm660-qusb2-phy",
 	  .data = (ulong)&sdm660_phy_cfg },
+	{ .compatible = "qcom,ipq9574-qusb2-phy",
+	  .data = (ulong)&ipq6018_phy_cfg },
 	{ .compatible = "qcom,sm6115-qusb2-phy",
 	  .data = (ulong)&sm6115_phy_cfg },
 	{ .compatible = "qcom,qusb2-v2-phy", .data = (ulong)&qusb2_v2_phy_cfg },
-- 
2.34.1

