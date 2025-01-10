Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B220E77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 05:09:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B145B801F5;
	Fri, 10 Jan 2025 06:08:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="JT5LISfI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7831C805E9; Fri, 10 Jan 2025 06:08:58 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 060CA800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 06:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509K29lG031509;
 Fri, 10 Jan 2025 05:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=yf7vThCApIvGKiXIyiaWFJ
 9ogLodV85novbJeBOr/Lk=; b=JT5LISfILSzOmtS0EtlOwDpBfXRyhEITUBkbhD
 /lIWrrXzFJ/JwmXArROAPnsnCEeE9Kj4JY1kuIVIaRdad8JMT2D2F4dLBGUZ81oU
 RDpeUuEpydLOucOD5d00uqimOokAkrKkp4OdUbmyWclqNndlhjKOiGHqEr9zwPwD
 Q6xN4bkDuWbLrqyX5TiYZ7+uh3r7xxCNKpOAa0RNzFjXbeomuIS11RHi6ch9U3EI
 QbecYP7gsgcZC+QgDKT7La31px7qBGodYukzbTI85K9BqWU24PZHOGRwYxyXbdZ9
 skSi4YmSvEYeHKkDS4NYkR4vU/H6xCVKZGxNV7wVEnZgjNPQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 442n4r10n4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 05:08:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50A58aCI002203
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Jan 2025 05:08:36 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 9 Jan 2025 21:08:31 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>, <sjg@chromium.org>,
 <ilias.apalodimas@linaro.org>, <Volodymyr_Babchuk@epam.com>,
 <lehmanju@devpi.de>, <bhupesh.linux@gmail.com>,
 <konradybcio@kernel.org>, <quic_tengfan@quicinc.com>,
 <andersson@kernel.org>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v3 0/6] Enable QCOM QCS9100 Ride platform support
Date: Fri, 10 Jan 2025 10:38:11 +0530
Message-ID: <20250110050817.3819282-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: ILF5XDYQEy0mYJbS4NTD1RykNJzGW_bE
X-Proofpoint-ORIG-GUID: ILF5XDYQEy0mYJbS4NTD1RykNJzGW_bE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=959 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501100040
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
v3: * Added reviewed-by to dts cherry pick patch
    * Removed duplicates from configs/qcs9100_defconfig
v2: * Added reviewed-by tags to some of the patches
    * Add separate patch to bring QCS9100 DT files from Linux
    * Dropped 'arch/arm/dts/sa8775p-*.dtsi' from first patch and
      use qcs9100 DT files instead
    * Added one more range to memory definition
    * Updated commit log to include linux version from where
      headers were taken

---
Tengfei Fan (1):
  arm64: dts: qcom: qcs9100: Add support for the QCS9100 Ride and Ride
    Rev3 boards

Varadarajan Narayanan (5):
  dts: qcs9100-ride-r3-u-boot: add override dtsi
  clk/qcom: add initial clock driver for qcs9100
  phy: qcom: Add SA8775 to QMP UFS PHY driver
  qcom_defconfig: enable SA8775P clock driver
  configs: add qcs9100_defconfig

 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi      |  20 ++
 configs/qcom_defconfig                        |   1 +
 configs/qcs9100_defconfig                     |  18 ++
 drivers/clk/qcom/Kconfig                      |   8 +
 drivers/clk/qcom/Makefile                     |   1 +
 drivers/clk/qcom/clock-sa8775p.c              | 142 +++++++++++
 .../phy/qcom/phy-qcom-qmp-qserdes-com-v5.h    | 124 ++++++++++
 .../phy/qcom/phy-qcom-qmp-qserdes-txrx-v5.h   | 231 ++++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp-ufs.c           | 171 +++++++++++++
 .../src/arm64/qcom/qcs9100-ride-r3.dts        |  11 +
 dts/upstream/src/arm64/qcom/qcs9100-ride.dts  |  11 +
 11 files changed, 738 insertions(+)
 create mode 100644 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
 create mode 100644 configs/qcs9100_defconfig
 create mode 100644 drivers/clk/qcom/clock-sa8775p.c
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v5.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v5.h
 create mode 100644 dts/upstream/src/arm64/qcom/qcs9100-ride-r3.dts
 create mode 100644 dts/upstream/src/arm64/qcom/qcs9100-ride.dts


base-commit: 38a371110308ebeb277e20531a7b698b7981bbfa
-- 
2.34.1

