Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6559AC021AD
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 07:40:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF066801DE;
	Thu, 20 Feb 2025 08:40:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="TfDSP/9D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4864780C98; Thu, 20 Feb 2025 08:40:13 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 614A2801CF
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 08:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K6sLfr014899;
 Thu, 20 Feb 2025 07:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ztekpKzrZvhnrVQ9J1Ite/
 oLUhv5GY03xXJ2ZQnl3RI=; b=TfDSP/9D+1dUYaKNoSwIk7C+d2ZNv0x8i01CIN
 uP/owrrTBZHt3Zc0+L46hkKVHjkWJxaDL3hbDyoPUNoWjKVomwGjwnLaka7EsC8R
 hyYF6JL+lOMloaT6TmCtMk+hhUoWs9/MmU6G4V4yvHLqVSZrtFxqEjIynskX6Iek
 8TLYu+fHtQPmocUyQoXeqzCooJCHtf80jwiY209xiLrrNqWcviY6xUQKSbgNQK3U
 ptQ9QplJKb5w7UuBMKE07cbDWPSsrvykakGwANX3tVrpc2VeFsh8D++PPiXydKY2
 WAtn1U5Z7OtoXH8FtTV+/Ckeha9UVpFcNQ2RHMm+oTgsxePA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy158hw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 07:39:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51K7ds1J030754
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 20 Feb 2025 07:39:54 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Feb 2025 23:39:49 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <Volodymyr_Babchuk@epam.com>,
 <sjg@chromium.org>, <lehmanju@devpi.de>, <pbrobinson@gmail.com>,
 <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
Subject: [PATCH v4 0/8] Add initial support for IPQ9574 based boards
Date: Thu, 20 Feb 2025 13:09:30 +0530
Message-ID: <20250220073937.133687-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: Dlfrvezy6HRVi_4nzLK97A6nS9nMfDZp
X-Proofpoint-ORIG-GUID: Dlfrvezy6HRVi_4nzLK97A6nS9nMfDZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=968 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502200053
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
for the QTI IPQ9574 SoC and RDP433 board.

	SoC	: Qualcomm IPQ9574
	RAM	: 2GB DDR4
	Flash	: eMMC 8GB
	WiFi	: 1 x 2.4GHz, 1 x 5GHz, 1 x 6GHz

Thanks
Varada

v4: * Squash up the missed patch w.r.t. documentation
    * Drop the changes to qcom_defconfig
    * Dont include qcom_defconfig in qcom_ipq9574_mmc_defconfig and make
      it self contained

v3: * Add documentation regarding RDP
    * Add changes to handle get_function_mux failure

v2: Have tried to address the issues raised in v1
    * Use the upstream kernel dts itself
    * Dropped linker script changes
    * Break up the patches in clock, pinctrl and defconfig subsets
    * Dropped ipq9574 specific files and use existing mach-snapdragon
      infrastructure itself
    * Dropped SMEM related changes. Will have them in a separate
      series
    * Use reset_get_by_index instead of reset_get_by_name

v1: https://lore.kernel.org/u-boot/20240226100807.1095607-1-quic_varada@quicinc.com/
Varadarajan Narayanan (7):
  doc: board/qualcomm: document RDP building/flashing
  dts: ipq9574-rdp433-u-boot: add override dtsi
  clk/qcom: add initial clock driver for ipq9574
  pinctrl: qcom: Handle get_function_mux failure
  pinctrl: qcom: Add ipq9574 pinctrl driver
  mmc: msm_sdhci: Reset clocks before reconfiguration
  configs: add qcom_ipq9574_mmc_defconfig

 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi |  25 +++
 configs/qcom_ipq9574_mmc_defconfig      |  83 +++++++++
 doc/board/qualcomm/rdp.rst              |  55 ++++++
 drivers/clk/qcom/Kconfig                |   8 +
 drivers/clk/qcom/Makefile               |   1 +
 drivers/clk/qcom/clock-ipq9574.c        | 109 ++++++++++++
 drivers/clk/qcom/clock-qcom.h           |   1 +
 drivers/mmc/msm_sdhci.c                 |  10 ++
 drivers/pinctrl/qcom/Kconfig            |   7 +
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-apq8016.c  |   4 +-
 drivers/pinctrl/qcom/pinctrl-apq8096.c  |   4 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c  |   3 +-
 drivers/pinctrl/qcom/pinctrl-ipq9574.c  | 227 ++++++++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-qcm2290.c  |   2 +-
 drivers/pinctrl/qcom/pinctrl-qcom.c     |   5 +-
 drivers/pinctrl/qcom/pinctrl-qcom.h     |   3 +-
 drivers/pinctrl/qcom/pinctrl-qcs404.c   |   4 +-
 drivers/pinctrl/qcom/pinctrl-sdm845.c   |   4 +-
 drivers/pinctrl/qcom/pinctrl-sm6115.c   |   2 +-
 drivers/pinctrl/qcom/pinctrl-sm8150.c   |   4 +-
 drivers/pinctrl/qcom/pinctrl-sm8250.c   |   2 +-
 drivers/pinctrl/qcom/pinctrl-sm8550.c   |   4 +-
 drivers/pinctrl/qcom/pinctrl-sm8650.c   |   4 +-
 drivers/pinctrl/qcom/pinctrl-x1e80100.c |   4 +-
 25 files changed, 552 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
 create mode 100644 configs/qcom_ipq9574_mmc_defconfig
 create mode 100644 doc/board/qualcomm/rdp.rst
 create mode 100644 drivers/clk/qcom/clock-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c


base-commit: 7a45cb4ffeff034304789954bb222ddd7d02104a
-- 
2.34.1

