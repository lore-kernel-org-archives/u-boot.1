Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CBFC0218A
	for <u-boot@archiver.kernel.org>; Thu, 30 Jan 2025 05:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AD2280AE2;
	Thu, 30 Jan 2025 06:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="ZUWM93Mn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CAE780AE4; Thu, 30 Jan 2025 06:38:31 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE5F280ADF
 for <u-boot@lists.denx.de>; Thu, 30 Jan 2025 06:38:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50U5Ojj7021651;
 Thu, 30 Jan 2025 05:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=1I1VCMCkHYCycXZtBfqS3r
 CebqbaIFS7Vh9QvLfKh9U=; b=ZUWM93Mn8BREYH60hH8HOru4HYBCM9CpTAN7i6
 KNQWGbtPxKMuo0DGuD3h4KKOLbCgjGsPYne7dt2A85FmD0NecedysHvtvQBLmr/e
 2r7F6HvqL+oeAqnS07xFiVAd+daFn6n7oYCuqy5TssDuGSVAhnUlSlRcjWzSbtQk
 pLLPYYEwekL+mWAGrSVm8ooqCMTV4v5FXdp/wYfnjgmv+235G6Em8nF+eTLwH3we
 f2DJeLq7HHR9XpK6z7q9vVfdl+A/mHgBQX+1/k5u1bhTL99QIQw5ZBoBGjaM21F9
 Jqfy+RRQmDmSMgdXRvjuDZt3BtlbjAfPOmrL8LcH9MFiyOYw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44g38kg0s8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 05:38:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U5cBfa006942
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Jan 2025 05:38:11 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 21:38:06 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <quic_varada@quicinc.com>, <ilias.apalodimas@linaro.org>,
 <sjg@chromium.org>, <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>,
 <pbrobinson@gmail.com>, <marek.vasut+renesas@mailbox.org>,
 <robert.marko@sartura.hr>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v2 0/6] Add initial support for IPQ9574 based boards
Date: Thu, 30 Jan 2025 11:07:45 +0530
Message-ID: <20250130053751.3148614-1-quic_varada@quicinc.com>
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
X-Proofpoint-ORIG-GUID: t7l2ZYdqOk3s3vjYjVKBPD6kSN0u5GX4
X-Proofpoint-GUID: t7l2ZYdqOk3s3vjYjVKBPD6kSN0u5GX4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1011 mlxlogscore=961
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300041
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
Varadarajan Narayanan (6):
  dts: ipq9574-rdp433-u-boot: add override dtsi
  clk/qcom: add initial clock driver for ipq9574
  pinctrl: qcom: Add ipq9574 pinctrl driver
  mmc: msm_sdhci: Reset clocks before reconfiguration
  qcom_defconfig: enable ipq9574 clock & pinctrl driver
  configs: add ipq9574_defconfig

 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi |  19 ++
 configs/ipq9574_defconfig               | 111 ++++++++++++
 configs/qcom_defconfig                  |   2 +
 drivers/clk/qcom/Kconfig                |   8 +
 drivers/clk/qcom/Makefile               |   1 +
 drivers/clk/qcom/clock-ipq9574.c        | 100 +++++++++++
 drivers/clk/qcom/clock-qcom.h           |   1 +
 drivers/mmc/msm_sdhci.c                 |  10 ++
 drivers/pinctrl/qcom/Kconfig            |   7 +
 drivers/pinctrl/qcom/Makefile           |   1 +
 drivers/pinctrl/qcom/pinctrl-ipq9574.c  | 226 ++++++++++++++++++++++++
 11 files changed, 486 insertions(+)
 create mode 100644 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi
 create mode 100644 configs/ipq9574_defconfig
 create mode 100644 drivers/clk/qcom/clock-ipq9574.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq9574.c


base-commit: a2b489b170f8382f746202c36616eaf2bc38fe86
-- 
2.34.1

