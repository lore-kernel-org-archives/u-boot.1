Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3803C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:01:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 921A787EEC;
	Mon, 26 Feb 2024 13:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Fr6rqtwZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C5AE87EAC; Mon, 26 Feb 2024 11:09:18 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6798587A80
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:09:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41Q8HtUa017704; Mon, 26 Feb 2024 10:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=qcppdkim1; bh=80pG86c
 uLtRjBOg63s+7tvv/VDzECKrgFe5in7XftXU=; b=Fr6rqtwZzGHlB5kSf5sD3S3
 lBDhpmZt3FzZS6ximwL+Dg2Bhbzip6NoLay2EtRBE2ZldkTemSrYv7DpNTJj5Uv7
 Bq4i7GRM0WLJhpjPodMgt8iKEypGBoJq8rciqVLv7JB986vZBeEH1iyodYnSu2g9
 T5IPj/ypJ7DY/LFd7Kyp/33PbkVrTco0KinQT2LgUjznaMrCHz0tbZq27yQyi+FE
 ZPtxQQdeOPXOx9UrKggX5i2tJIULLVF1/5mkg+8A/XJKHUI7GA/pOs7oyGAqQ3sU
 uRYxvzoLclANaikzyjExIkaRN39lEoWgL62jl+2x/CGiZIGW2cswKMQAVi/cdNw=
 =
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxq0j89-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:08:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QA8siF007495
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:08:54 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 02:08:47 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <u-boot@lists.denx.de>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, FUKAUMI Naoki <naoki@radxa.com>, Hai Pham
 <hai.pham.ud@renesas.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marex@denx.de>, Mathieu Othacehe <othacehe@gnu.org>, Michal Simek
 <michal.simek@amd.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, "Sean Anderson" <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tianling Shen
 <cnsztl@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 00/10] Add initial support for IPQ9574 based boards
Date: Mon, 26 Feb 2024 15:37:57 +0530
Message-ID: <20240226100807.1095607-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: FPy5Jm-jXGPGGrZ9Lk9gwOaMl6oM555R
X-Proofpoint-GUID: FPy5Jm-jXGPGGrZ9Lk9gwOaMl6oM555R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1011
 malwarescore=0 mlxlogscore=980 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260076
X-Mailman-Approved-At: Mon, 26 Feb 2024 13:01:24 +0100
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

	SoC	: QTI IPQ9574
	RAM	: 2GB DDR4
	Flash	: eMMC 8GB
	WiFi	: 1 x 2.4GHz, 1 x 5GHz, 1 x 6GHz

New to both patman and posting to U-Boot. Please let
me know if something is not correct, will try to
rectify to the best of my abilities.

Thanks
Varada


Varadarajan Narayanan (10):
  mach-snapdragon: Add support for IPQ9574
  mach-snapdragon: ipq9574: Add SMEM defines needed for IPQ9574
  clk/qcom: Add support for clock registers in IPQ9574
  clk/qcom: Include IPQ9574
  mach-snapdragon: Update gd->ram_size in msm_fixup_memory
  pinctrl: qcom: Add support for 'pull-down'
  pinctrl: qcom: Include IPQ9574
  mmc: msm_sdhci: Handle different vendor cap register offsets
  mmc: msm_sdhci: Reset clocks before reconfiguration
  board: qualcomm: Add support for IPQ9574 RDP433

 arch/arm/dts/Makefile                         |    2 +
 arch/arm/dts/ipq9574-default.dts              |  167 +++
 arch/arm/dts/ipq9574-rdp433-mht-phy.dts       |  208 +++
 arch/arm/dts/ipq9574.dtsi                     |  771 ++++++++++
 arch/arm/mach-snapdragon/Kconfig              |   15 +
 arch/arm/mach-snapdragon/Makefile             |    1 +
 arch/arm/mach-snapdragon/dram.c               |   10 +-
 .../include/mach/sysmap-ipq9574.h             |  252 ++++
 arch/arm/mach-snapdragon/init_ipq9574.c       |   81 +
 board/qualcomm/ipq9574/Kconfig                |   15 +
 board/qualcomm/ipq9574/Makefile               |    4 +
 board/qualcomm/ipq9574/board_init.c           |  326 ++++
 board/qualcomm/ipq9574/ipq9574.c              |  170 +++
 board/qualcomm/ipq9574/ipq9574.h              |   75 +
 board/qualcomm/ipq9574/u-boot-x32.lds         |  250 ++++
 board/qualcomm/ipq9574/u-boot-x64.lds         |  188 +++
 configs/ipq9574_mmc_defconfig                 |  118 ++
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/clock-ipq9574.c              | 1320 +++++++++++++++++
 drivers/clk/qcom/clock-qcom.c                 |   32 +
 drivers/clk/qcom/clock-qcom.h                 |    8 +
 drivers/mmc/msm_sdhci.c                       |   21 +-
 drivers/pinctrl/qcom/Kconfig                  |    7 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-ipq9574.c        |   77 +
 drivers/pinctrl/qcom/pinctrl-qcom.c           |    2 +
 include/configs/ipq9574.h                     |  111 ++
 include/dt-bindings/clock/gcc-ipq9574.h       |  156 ++
 include/dt-bindings/net/qti-ipqsoc.h          |   20 +
 include/dt-bindings/pinctrl/pinctrl-ipqsoc.h  |   19 +
 include/dt-bindings/reset/ipq9574-reset.h     |   54 +
 include/smem.h                                |   78 +
 33 files changed, 4563 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/dts/ipq9574-default.dts
 create mode 100644 arch/arm/dts/ipq9574-rdp433-mht-phy.dts
 create mode 100644 arch/arm/dts/ipq9574.dtsi
 create mode 100644 arch/arm/mach-snapdragon/include/mach/sysmap-ipq9574.h
 create mode 100644 arch/arm/mach-snapdragon/init_ipq9574.c
 create mode 100644 board/qualcomm/ipq9574/Kconfig
 create mode 100644 board/qualcomm/ipq9574/Makefile
 create mode 100644 board/qualcomm/ipq9574/board_init.c
 create mode 100644 board/qualcomm/ipq9574/ipq9574.c
 create mode 100644 board/qualcomm/ipq9574/ipq9574.h
 create mode 100644 board/qualcomm/ipq9574/u-boot-x32.lds
 create mode 100644 board/qualcomm/ipq9574/u-boot-x64.lds
 create mode 100644 configs/ipq9574_mmc_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c
 create mode 100644 include/configs/ipq9574.h
 create mode 100644 include/dt-bindings/clock/gcc-ipq9574.h
 create mode 100644 include/dt-bindings/net/qti-ipqsoc.h
 create mode 100644 include/dt-bindings/pinctrl/pinctrl-ipqsoc.h
 create mode 100644 include/dt-bindings/reset/ipq9574-reset.h

-- 
2.34.1

