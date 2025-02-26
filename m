Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB67C19776
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:45:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2010F80F12;
	Wed, 26 Feb 2025 07:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="DP0ZNdOQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5950480977; Wed, 26 Feb 2025 07:45:41 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81BEA80977
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMWshd007454;
 Wed, 26 Feb 2025 06:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=E6caHaMYedK+qOsnrns4q0
 aAlitkLDJS2l5RzfzUK34=; b=DP0ZNdOQSSotnhUt1bcVZMwSrxSX7gecgDp/Fw
 O0Fwr99vFfmDHWvnQjPEflVeITdr2o9dxANqoUAXNa+Oxtyqb0IOknEDf76GTjri
 cWNezBh+vqSl/IFvAW5hO0bGgTbA5G3i1Fcvtb+Q8b4EcGfER9EBENx+J4r6Q/NH
 kd7j13AU+9ps4u6Hb125warmCGqBW2YLHkkmTvYq0DTMB4awWoI7upiO3MikIsz0
 87u8CgXAQqrBcCFu1mkpDaV+gxSyvWN4BH/8bJZOQLaTJbkXDu1iHz1AsXHrt9+o
 j3JdxIHvI67ZT1BmpmRdMLYexmOTvjmQJV+uBR+HXR+TANIQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451prms0d8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 06:45:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51Q6jLVC001835
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 06:45:21 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Feb 2025 22:45:16 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <lehmanju@devpi.de>,
 <Volodymyr_Babchuk@epam.com>, <sjg@chromium.org>,
 <marek.vasut+renesas@mailbox.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v6 0/7] Add initial support for IPQ9574 based boards
Date: Wed, 26 Feb 2025 12:14:58 +0530
Message-ID: <20250226064505.1178054-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: UtQ3QGnBy_8F2NBs7YJbZiN2jr_p1aLa
X-Proofpoint-ORIG-GUID: UtQ3QGnBy_8F2NBs7YJbZiN2jr_p1aLa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 mlxlogscore=999
 phishscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502260052
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

v6: Use qcom_gate_clk_en(priv, clk->id) instead of switch case for
    each clock individually

v5: Remove special_pins_start assignment in pinctrl-ipq9574.c

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
 drivers/clk/qcom/clock-ipq9574.c        |  94 ++++++++++
 drivers/clk/qcom/clock-qcom.h           |   1 +
 drivers/mmc/msm_sdhci.c                 |  10 ++
 drivers/pinctrl/qcom/Kconfig            |   7 +
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-apq8016.c  |   4 +-
 drivers/pinctrl/qcom/pinctrl-apq8096.c  |   4 +-
 drivers/pinctrl/qcom/pinctrl-ipq4019.c  |   3 +-
 drivers/pinctrl/qcom/pinctrl-ipq9574.c  | 226 ++++++++++++++++++++++++
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
 25 files changed, 536 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
 create mode 100644 configs/qcom_ipq9574_mmc_defconfig
 create mode 100644 doc/board/qualcomm/rdp.rst
 create mode 100644 drivers/clk/qcom/clock-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c


base-commit: dc0ee458f1afae4cb5c8a7b2c875bb24ffdf71ca
-- 
2.34.1

