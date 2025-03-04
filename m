Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B09BC021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 11:03:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8084681875;
	Tue,  4 Mar 2025 12:02:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="RGhtiPod";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2AA781878; Tue,  4 Mar 2025 12:02:12 +0100 (CET)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A7F381870
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 12:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524AtFPp027319;
 Tue, 4 Mar 2025 11:01:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rl03y2PKKsSO5E2CJsuC1rhZCQNrt50viLL9heUFHN0=; b=RGhtiPodzsLCMhpl
 d8vf8g1dVMDk6v96V68KiYsdtm0r4xhDPjOiogilxkjBv43DeRIRRdQOqJoHelHF
 U42fe4zpq/VhN70OS1c6SSTdunjZFDCt20dZfFNeHMjk08jMLUA+J9gSyAkGetfV
 gFDhqIyA41dh/ZfrZzUhb46jasl6FM0bBp/HZyLc/bIsRkJW9PPVkSWfZl6+63xG
 ey8eoLBEklvSnjmM0Ny9NHEzwNOH6pRVWvGz/ZhmicORv9TfPkGkVt1fAqG1rApx
 8TFCBHIdJ652ImGY4P5dum+G1ppDaVZnPIxcT+UTEEI04CuFAO1/RmCjGaBXXfth
 9kRZmQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6uhk31-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 04 Mar 2025 11:01:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 524B1o4B010142
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 4 Mar 2025 11:01:50 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Mar 2025 03:01:45 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <trini@konsulko.com>, <caleb.connolly@linaro.org>,
 <neil.armstrong@linaro.org>, <sumit.garg@linaro.org>, <lukma@denx.de>,
 <seanga2@gmail.com>, <quic_varada@quicinc.com>,
 <Volodymyr_Babchuk@epam.com>, <lehmanju@devpi.de>, <sjg@chromium.org>,
 <robert.marko@sartura.hr>, <dmitry.baryshkov@linaro.org>,
 <andersson@kernel.org>, <u-boot@lists.denx.de>, <u-boot-qcom@groups.io>
Subject: [PATCH v1 6/6] configs: add qcom_ipq5424_mmc_defconfig
Date: Tue, 4 Mar 2025 16:31:05 +0530
Message-ID: <20250304110105.2762124-7-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250304110105.2762124-1-quic_varada@quicinc.com>
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: QHmVRLOLqjXgnPvHc4Tu2OngWCI3wmUL
X-Authority-Analysis: v=2.4 cv=H40hw/Yi c=1 sm=1 tr=0 ts=67c6dd9f cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=JL97sF1pZO4nul8P6yIA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: QHmVRLOLqjXgnPvHc4Tu2OngWCI3wmUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=753
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
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

Introduce a defconfig for the Qualcomm IPQ5424 SoC based RDPs.
Presently supports eMMC.

Per the flash memory layout, U-Boot size cannot exceed 756KB. With this
defconfig, u-boot.mbn size is ~480KB.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
 configs/qcom_ipq5424_mmc_defconfig | 83 ++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 configs/qcom_ipq5424_mmc_defconfig

diff --git a/configs/qcom_ipq5424_mmc_defconfig b/configs/qcom_ipq5424_mmc_defconfig
new file mode 100644
index 0000000000..0dd46680b0
--- /dev/null
+++ b/configs/qcom_ipq5424_mmc_defconfig
@@ -0,0 +1,83 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_NR_DRAM_BANKS=24
+CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq5424-rdp466"
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
+CONFIG_CLK_QCOM_IPQ5424=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_SCSI=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
+CONFIG_MSM_GPIO=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_IPQ5424=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_MMC_HS200_SUPPORT=y
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
+CONFIG_DEBUG_UART_BASE=0x1a84000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
+CONFIG_TEXT_BASE=0x8a380000
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

