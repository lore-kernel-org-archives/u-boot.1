Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51315C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 10:16:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90CC182F6F;
	Tue, 15 Jul 2025 12:16:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="UBSfx9bm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3386382FCA; Tue, 15 Jul 2025 12:16:12 +0200 (CEST)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 266E4801BE
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 12:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F79Adf013389;
 Tue, 15 Jul 2025 10:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=SwZDS6YOcWhBc9segIo/nj
 wtGhcabAboWoLAVg5MI8I=; b=UBSfx9bm8uetWq6E0oiKZO4NwG8SZlKuizxJxr
 Q5zgKRoPgZJRWwFfuvWceFyJEuANPJ9wontfhEvIOkpKKlMwSUj0sbrxiiZ3Pb+A
 Z1z6OHTNtTUQh5xH0gkQY2RjIWB9wc+bd9jEfnbRiWjqlUiTWfVrU//pUVtoywmV
 vrhwot8MinCeB6VwhHw5UWnzThopt3GYC9sbXFIMRbpRrO+qSqR3gIdpZvuiBB6a
 AvDjyYR7TfczKEJGR80PekYX8nDiBvVIngpsrmH8V9QyZM9684DWc/PG8fESXTMc
 aHWyomxZuXstB7HVDaed2/+BTFC9RxUVMSzgeFKUcoS7+P2Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxayuj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 10:15:54 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56FAFr0D022929
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 10:15:53 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 03:15:49 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <marek.vasut+renesas@mailbox.org>, <bhupesh.linux@gmail.com>,
 <alexeymin@postmarketos.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
Subject: [PATCH v1 0/6] Enable fastboot support for IPQ9574 based boards
Date: Tue, 15 Jul 2025 15:45:32 +0530
Message-ID: <20250715101538.4072985-1-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: 8dd2wpCnzFwIxLLasZKh7CSBsiuXozl6
X-Proofpoint-ORIG-GUID: 8dd2wpCnzFwIxLLasZKh7CSBsiuXozl6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5MyBTYWx0ZWRfX8zxnzsXPegYM
 sq5jztRVWeNVau0VyAPWe8aCvkQTTdgDzviHkb5ltMuSuYxSWAaqHgp0+6g3cf1InEZWxtmiXNZ
 w5VtTE+vgcDSn6SovOdwmS3mO5zvv54MLnzfaMTMFlCavOvlSdqbYlm5MSaS++ziUhoVUh3BOr3
 lyqOWtuiTJfkkqkJhPevUH4TjMILC4HhBpt+5Z0OpXwtlsCO2Cd7T2/P2kYHD1+PICvj6MkrkJK
 4hQQWWjtZ4q291QmnjHJ33AYtq3/jtEHCyjmyAy8VMYnUfaWuC27bM8NkKKgYIL8WFC2tLMv34f
 Jt/E55JIHlK7s9LzaT0PQe36n7lNNMh7WJKavhmO/thH0xPLelsZjEb4NMBrlhD6m5R+7rZxoy0
 4jFI0ee0EA+9DEliC0Q/heJPyB2dQuq5SaJEnYn3J4eKV4/PfHRYzwOAePS+umWz08mGavR3
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=68762a5a cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=dPqUMevFqatbuXeUEX0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=684
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150093
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

This series enables MMC based fastboot flashing for IPQ9574 boards.
For this the following are added/enabled
	* USB2 & USB3 phys support
	* USB Gadget support, Fastboot-MMC related configs
	* Flashing related documentation

Varadarajan Narayanan (6):
  clk/qcom: Add USB related clocks for IPQ9574
  phy: Add IPQ9574 support to Qualcomm QUSB2 phy
  phy: qcom: Add QMP USB PHY driver
  configs: ipq9574: Enable fastboot support
  dts: ipq9574-rdp433-u-boot: Enable USB device mode and MMC
  doc: board/qualcomm: Update RDP flashing instructions

 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi       |    6 +
 configs/qcom_ipq9574_mmc_defconfig            |   22 +-
 doc/board/qualcomm/rdp.rst                    |   14 +
 drivers/clk/qcom/clock-ipq9574.c              |   28 +
 drivers/phy/qcom/Kconfig                      |    8 +
 drivers/phy/qcom/Makefile                     |    1 +
 drivers/phy/qcom/phy-qcom-qmp-common.h        |   62 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h   |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h    |   34 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h    |   36 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h    |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h    |   17 +
 drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h        |   32 +
 .../phy/qcom/phy-qcom-qmp-qserdes-com-v7.h    |   87 +
 .../phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h   |   78 +
 drivers/phy/qcom/phy-qcom-qmp-usb.c           | 2114 +++++++++++++++++
 drivers/phy/qcom/phy-qcom-qmp.h               |   15 +
 drivers/phy/qcom/phy-qcom-qusb2.c             |   42 +
 18 files changed, 2629 insertions(+), 1 deletion(-)
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-common.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-misc-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v4.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v5.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v6.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-usb-v7.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-pcs-v7.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-com-v7.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-qserdes-txrx-v7.h
 create mode 100644 drivers/phy/qcom/phy-qcom-qmp-usb.c


base-commit: cd79a2839b01571b6f2915c219f71c05e3c97482
-- 
2.34.1

