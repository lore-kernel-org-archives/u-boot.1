Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C49C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 10:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A21CD830A0;
	Tue, 15 Jul 2025 12:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="Lcv3r+On";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB1F82F14; Tue, 15 Jul 2025 12:16:19 +0200 (CEST)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF4F1830A0
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 12:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F8kH6q026550;
 Tue, 15 Jul 2025 10:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g2OXNTEFy+pD0btfC4ytRDAuM2wD3NKQfYf96V1XoPQ=; b=Lcv3r+Onrp8c0dj3
 Uf2JYc9f/n0CQDbUKxI2aVDtzrvWkUEUtw8xESkYrqtTFTtE6vmIILvMHGT82M9i
 cgBH6bnlocUhCIkswReNjA7PthO7hotUZHAUjRJDs0RLBC//TxlmkFxGnktKCv9Z
 8bBR9xmQOk2rk1jqkkpjytorkGPQcaFj95RwhLcyTFPEtXlQX1aC5p8IZSGWvXiz
 yNCGpS4Q95wCyPnFT/KISwODWUgN/s/syJh5of1RJmwyKAEvROVKQnzSND0uItZw
 xfSpum7dMiojs2C03/j0Z/lW9ZPxMbqOyH92kjgX87ShPCNnQteRZSZPEn/lDRUG
 NgaeAw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wkrugb7u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 10:16:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56FAG93F032208
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Jul 2025 10:16:09 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 15 Jul 2025 03:16:05 -0700
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@kernel.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <marek.vasut+renesas@mailbox.org>, <bhupesh.linux@gmail.com>,
 <alexeymin@postmarketos.org>, <u-boot@lists.denx.de>,
 <u-boot-qcom@groups.io>
Subject: [PATCH v1 4/6] configs: ipq9574: Enable fastboot support
Date: Tue, 15 Jul 2025 15:45:36 +0530
Message-ID: <20250715101538.4072985-5-quic_varada@quicinc.com>
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
X-Proofpoint-GUID: VXWSkCnzDsCibU0arNZTkI4tOyfu1FEV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA5MyBTYWx0ZWRfXxtKiQ3bbeSvg
 jg9f5z2wra6tO8CNo7y/X4hAcINB1AZQlEnZV6B2hdNUZN/HabL1LPG8jlk382phlxt5CLhStbF
 V/LhNANg7RswxjmOFQUZ9B0Z64igbhxC48d8yhPWBkg5qMUespRasBctPlM2reJ1ajUJr33nyy5
 xz6v5UzlL3k9xglieMGb85Z0rdpKM8cEUOC2vlPGXAA4VfAXe93WyH/jYG37/XmUJiiG3uLjtlA
 lkpnZXvJqX1wQG+gXQY1Xgha09FzCUv5HwvviSFiDp21guIYWKFquEM30lMIWdp5nIhqnqUoOPq
 00eKzgnQ0l25CX0NPSjOt5I63aQfA7sFdYfjP3Wt8oLslRUi+BvNOsNoZf6BtMFO/ME14zmX4bQ
 l4hVs8SNfuvTkE+3tiGxKy5H0EbYTYDvXo55NCpxVOaomTYLY+dyqDvKkwawz7H3sJoTgheo
X-Authority-Analysis: v=2.4 cv=WqUrMcfv c=1 sm=1 tr=0 ts=68762a69 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=6zSr0Cm5jUOs9Rz06jIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: VXWSkCnzDsCibU0arNZTkI4tOyfu1FEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=820 bulkscore=0
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

Enable relevant configs like USB PHY, gadget, fastboot,
fastboot MMC support etc. to enable fastboot flashing
of IPQ9574 based boards.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 configs/qcom_ipq9574_mmc_defconfig | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index 720220dc98a..22fd39bbdc9 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -43,7 +43,7 @@ CONFIG_DWC_ETH_QOS=y
 CONFIG_DWC_ETH_QOS_QCOM=y
 CONFIG_RGMII=y
 CONFIG_PHY=y
-CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QMP_USB=y
 CONFIG_PHY_QCOM_QUSB2=y
 CONFIG_PINCTRL=y
 CONFIG_PINCONF=y
@@ -52,3 +52,23 @@ CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_MSM_SERIAL=y
 CONFIG_MSM_GENI_SERIAL=y
 CONFIG_SOC_QCOM=y
+CONFIG_USB=y
+CONFIG_USB_GADGET=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_CMD_USB=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GADGET=y
+CONFIG_MISC=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT=y
+CONFIG_CMD_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=y
+CONFIG_FASTBOOT_BUF_SIZE=y
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_USB_GADGET_VENDOR_NUM=0x18d1
+CONFIG_USB_GADGET_PRODUCT_NUM=0xd00d
+CONFIG_FASTBOOT_BUF_ADDR=0x50000000
+CONFIG_FASTBOOT_BUF_SIZE=0x4000000
-- 
2.34.1

