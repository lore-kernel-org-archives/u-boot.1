Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10335C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 06:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6981A80F7B;
	Wed, 26 Feb 2025 07:46:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="SyHfDiSz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B200A80F12; Wed, 26 Feb 2025 07:46:16 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7058C80F7B
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 07:46:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PMclVV000855;
 Wed, 26 Feb 2025 06:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Amm3pACV/w8G+Gw2iuJVIuDfXRgYcI620M+RecgNYgw=; b=SyHfDiSz2wGDP8Bx
 VF/7ovXLHr2rhIttE0GFWrUp56wEDGl76jXjNtKnrCbvb3+RSSB7nN69H0TLSfsX
 Ljey4DK+zf9MG0OxfchVPi7NsEN8OTqpRLbRDqwMP3DgtvwKECH3IZhw0vg7hgkb
 xEQeowbQ87uFaLEjITvgBpIn7dKhzDs2zZQbW8w2PtAybVHfFFG/AlTsexrhCnrd
 xJX3apMRv4dNLGuTE5+uIdQESLvPwhqRdmVGVQjtwUcHC+FOFcoGijU8/0lD0rT0
 5gwpCqERJ1TIGC73EXj7oB9QRmEjXffzwvOLj2aA1fO0z8vUsdDbbtD/SiFHjnbw
 82Q4ZA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 451pu99093-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 06:46:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51Q6jxJV004490
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2025 06:45:59 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 25 Feb 2025 22:45:54 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <peng.fan@nxp.com>, <jh80.chung@samsung.com>,
 <robert.marko@sartura.hr>, <luka.perkov@sartura.hr>,
 <quic_varada@quicinc.com>, <lehmanju@devpi.de>,
 <Volodymyr_Babchuk@epam.com>, <sjg@chromium.org>,
 <marek.vasut+renesas@mailbox.org>, <pbrobinson@gmail.com>,
 <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v6 7/7] configs: add qcom_ipq9574_mmc_defconfig
Date: Wed, 26 Feb 2025 12:15:05 +0530
Message-ID: <20250226064505.1178054-8-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250226064505.1178054-1-quic_varada@quicinc.com>
References: <20250226064505.1178054-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: XBPUsWwcMQA4TY5MhfO5_4hnodmL9m0G
X-Proofpoint-ORIG-GUID: XBPUsWwcMQA4TY5MhfO5_4hnodmL9m0G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=737 malwarescore=0 suspectscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260051
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

Introduce a defconfig for the Qualcomm IPQ9574 SoC based RDPs.
Presently supports eMMC.

Per the flash memory layout, U-Boot size cannot exceed 756KB. With this
defconfig, u-boot.mbn size is ~480KB.

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v5: Add 'Reviewed-by: Sumit Garg'

v4: Don't include qcom_defconfig
    Update commit message to include details about size restrictions
    Drop 'Reviewed-by: Caleb Connolly' as the file has changed considerably

v3: Removed unnecessary comment
---
 configs/qcom_ipq9574_mmc_defconfig | 83 ++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 configs/qcom_ipq9574_mmc_defconfig

diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
new file mode 100644
index 0000000000..9bc1e1c70b
--- /dev/null
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -0,0 +1,83 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_NR_DRAM_BANKS=24
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9574-rdp433"
+CONFIG_SYS_LOAD_ADDR=0x50000000
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+# CONFIG_EFI_LOADER is not set
+# CONFIG_EFI_BINARY_EXEC is not set
+# CONFIG_EFI_VARIABLE_FILE_STORE is not set
+# CONFIG_PXE_UTILS is not set
+# CONFIG_BOOTSTD is not set
+# CONFIG_BOOTMETH_VBE is not set
+CONFIG_BOOTDELAY=2
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_SYS_CBSIZE=512
+CONFIG_LOG_MAX_LEVEL=9
+CONFIG_LOG_DEFAULT_LEVEL=4
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_PART=y
+CONFIG_OF_LIVE=y
+CONFIG_USE_DEFAULT_ENV_FILE=y
+CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
+CONFIG_CLK=y
+CONFIG_CLK_QCOM_IPQ9574=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_SCSI=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
+CONFIG_MSM_GPIO=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_IPQ9574=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_DM_MDIO=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_DWC_ETH_QOS=y
+CONFIG_DWC_ETH_QOS_QCOM=y
+CONFIG_RGMII=y
+CONFIG_PHY=y
+CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_SCSI=y
+CONFIG_MSM_SERIAL=y
+CONFIG_MSM_GENI_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x78b1000
+CONFIG_DEBUG_UART_MSM=y
+CONFIG_DEBUG_UART_CLOCK=1843200
+CONFIG_TEXT_BASE=0x4A240000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_BOOTSTD_FULL=y
+CONFIG_SYS_CBSIZE=1024
+CONFIG_SYS_PBSIZE=1024
+CONFIG_OF_LIVE=y
+CONFIG_MSM_SERIAL=y
+CONFIG_DM_EVENT=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_PARTITIONS=y
+CONFIG_PARTITION_UUIDS=y
+CONFIG_MTD=y
+CONFIG_MTD_PARTS=y
+CONFIG_HUSH_PARSER=y
+CONFIG_PARTITIONS=y
+CONFIG_EFI_PARTITION=y
+# CONFIG_I2C is not set
+# CONFIG_INPUT is not set
+# CONFIG_SCSI is not set
+# CONFIG_SPMI is not set
-- 
2.34.1

