Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278C8C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 11:01:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7FF281671;
	Tue,  4 Mar 2025 12:01:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="ldTp9uKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0757816A4; Tue,  4 Mar 2025 12:01:55 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04105814BD
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 12:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524AZB4m010211;
 Tue, 4 Mar 2025 11:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=HmuArDwOedc/ZVahaY2fnT
 9Z1xX41Wj2EkFy032DA8o=; b=ldTp9uKEZNt3Fncq+k8rVyPmxyIesnT63PoYgQ
 LTJcZTcIc90Y3K8Wa3jxVwaEdq1OF4rDz8P1OBAtEqBpZYnOG23GY0yAZZ72AH+q
 LyPZ580v6j4QLaoxYk5L69565D73F8kHwYu9ZBztOFFykH7nrmyJskpqjk2s6GM2
 aB1dhFIUxgPgwKlPytVo9VpS7sjIlOEmVGwkiEb5b2HXDcR61WBbaqZ8RJmZdn3K
 o2m+BR0XiCG+DAcV62fqQoOLL/rDNf0A0N9Fos59ElODsUHNLCeuZFecRdynn6yl
 vhLnJvrImHRiBK5fQ2d6bgevLTrnoDvcGZrOFRVyFNmCbhpQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6whkm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 11:01:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 524B1Le0009382
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 4 Mar 2025 11:01:21 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Mar 2025 03:01:17 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>, <sjg@chromium.org>,
 <robert.marko@sartura.hr>, <dmitry.baryshkov@linaro.org>,
 <andersson@kernel.org>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v1 0/6] Add initial support for IPQ5424 based boards
Date: Tue, 4 Mar 2025 16:30:59 +0530
Message-ID: <20250304110105.2762124-1-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Authority-Analysis: v=2.4 cv=EZcyQOmC c=1 sm=1 tr=0 ts=67c6dd83 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=gWGa7_hJN5l6p4kpcFEA:9
X-Proofpoint-GUID: XI4d02GxuUl258o4LuylOH1h0k9qFDrX
X-Proofpoint-ORIG-GUID: XI4d02GxuUl258o4LuylOH1h0k9qFDrX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=963 suspectscore=0 bulkscore=0
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

These patches introduce the initial support code needed
for the QTI IPQ5424 SoC and RDP466 board.

Please see [1] for SoC related details

Thanks
Varada

1 - https://docs.qualcomm.com/bundle/publicresource/87-82994-1_REV_B_Qualcomm_Networking_Pro_A7_Elite_Platform_Product_Brief.pdf

Varadarajan Narayanan (6):
  arm64: dts: qcom: ipq5424: Add USB controller and phy nodes
  dts: ipq5424-rdp466-u-boot: add override dtsi
  doc: board/qualcomm: Update RDP signing instructions
  clk/qcom: add initial clock driver for ipq5424
  pinctrl: qcom: Add ipq5424 pinctrl driver
  configs: add qcom_ipq5424_mmc_defconfig

 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi       |  37 ++
 configs/qcom_ipq5424_mmc_defconfig            |  83 +++
 doc/board/qualcomm/rdp.rst                    |  15 +-
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-ipq5424.c              |  96 ++++
 drivers/clk/qcom/clock-qcom.h                 |   1 +
 drivers/pinctrl/qcom/Kconfig                  |   7 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq5424.c        | 322 +++++++++++
 .../src/arm64/qcom/ipq5424-rdp466.dts         | 169 ++++++
 dts/upstream/src/arm64/qcom/ipq5424.dtsi      | 507 ++++++++++++++++++
 12 files changed, 1241 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
 create mode 100644 configs/qcom_ipq5424_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq5424.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5424.c
 create mode 100644 dts/upstream/src/arm64/qcom/ipq5424-rdp466.dts
 create mode 100644 dts/upstream/src/arm64/qcom/ipq5424.dtsi


base-commit: cf6354ab23bfc3337b1087d243e6be4af48abe84
prerequisite-patch-id: f03d5ac6df1b3dd80a7f869a71989d584b0e32a5
prerequisite-patch-id: f73e900ee3b01363b50870517eca030ee8324659
prerequisite-patch-id: e73f86b2ae4c78c5b4fdb20ad15bbf05abd0320b
prerequisite-patch-id: c671f3196f2397922c0f4b06806b4372ac60055d
prerequisite-patch-id: 36f4133fb7451b536170f58b7519476351d4abae
prerequisite-patch-id: ce26065654575ff2e49d6571225a52d194125c56
prerequisite-patch-id: a8021af0c43a9a114a1e6e3dd43f3e665b3c3028
-- 
2.34.1

