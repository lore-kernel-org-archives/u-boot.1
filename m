Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE45E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 05:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F9280196;
	Fri,  3 Jan 2025 06:14:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="gerdR4rA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 318838031D; Fri,  3 Jan 2025 06:14:41 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 994B0800D7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 06:14:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 502G1M3s001685;
 Fri, 3 Jan 2025 05:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=zic/jrPh9rFZKCGxTPLzSA
 kuVv5Dwc42cOgp6iGwSVA=; b=gerdR4rAswpo1c8+7eon4hh2G2yZ46ayEvHGMv
 a6HYz/kCJwtpnYkbBucf7fA8W78MwpAsH2VtYGqDSv/+Bq0sbhbUST/R2RLqmqvG
 nFMN2/tii79489GatUJnwKu8hKp1tWPk2yPpUpgG+ZIoShT+nAczR2Hq33Zd7Fjl
 P7C3lANk0T2z09ryc0VGcacO8lPmMFNQY065Ur88t9vq6loLebjFj0ipFjFnlAAr
 vqpgQ+BfKVLFV6YITOdk3suU4mByPB/iKLWG1oWneyBBk46z3x50cCQs72sNXM2f
 wD59qBrOU5dud5GVUiAAiMO8RmhKiI2npYOLQcd13v/lZ/ww==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43wrefj444-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 03 Jan 2025 05:14:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5035ELMN015693
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 3 Jan 2025 05:14:21 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 2 Jan 2025 21:14:16 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>,
 <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>,
 <bhupesh.linux@gmail.com>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v1 0/5] Enable QCOM QCS9100 Ride platform support
Date: Fri, 3 Jan 2025 10:43:59 +0530
Message-ID: <20250103051404.1965469-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: zD_QlwMP3oNY3a5H6YdubefwV_i_qgXK
X-Proofpoint-ORIG-GUID: zD_QlwMP3oNY3a5H6YdubefwV_i_qgXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 phishscore=0
 mlxlogscore=935 bulkscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The following patch series enables support for QCOM QCS9100 based
Ride platform. The QCS9100 SoC is a derivative of SA8775p and hence
this series makes use of the SA8775p related code to enable the
QCS9100 based Ride platform support.

Use 'make qcs9100_defconfig' to generate '.config'.

---
Varadarajan Narayanan (5):
  dts: sa8775p-ride-r3-u-boot: add override dtsi
  clk/qcom: add initial clock driver for qcs9100
  phy: qcom: Add SA8775 to QMP UFS PHY driver
  qcom_defconfig: enable SA8775P clock driver
  configs: add qcs9100_defconfig

 arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi      |  22 ++
 arch/arm/dts/sa8775p-ride-u-boot.dtsi         |  11 +
 configs/qcom_defconfig                        |   1 +
 configs/qcs9100_defconfig                     |  24 ++
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-sa8775p.c              | 142 +++++++++++
 .../phy/qcom/phy-qcom-qmp-qserdes-com-v5.h    | 124 ++++++++++
 .../phy/qcom/phy-qcom-qmp-qserdes-txrx-v5.h   | 231 ++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           | 170 +++++++++++++
 10 files changed, 734 insertions(+)
 create mode 100644 arch/arm/dts/sa8775p-ride-r3-u-boot.dtsi
 create mode 100644 arch/arm/dts/sa8775p-ride-u-boot.dtsi
 create mode 100644 configs/qcs9100_defconfig
 create mode 100644 drivers/clk/qcom/clock-sa8775p.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v5.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5.h


base-commit: e7713a78829250b925d6377ee26c7b0745727feb
-- 
2.34.1

