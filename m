Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739C1C48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 12:03:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2182087F16;
	Mon, 26 Feb 2024 13:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="dMHZq1Jb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D87287D6F; Mon, 26 Feb 2024 11:09:37 +0100 (CET)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA6F87CED
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 11:09:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quic_varada@quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 41Q83OgE012004; Mon, 26 Feb 2024 10:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=
 qcppdkim1; bh=I2tQI0d16z6MfUbnyHYoWJRs7fsedHxWNXXBbWsIj7k=; b=dM
 HZq1JbuLcSDbKdJ39gQgYgkg23GCs97mZKKvG6+W3ul7tye6dIVpWeQ5nUhtiUib
 uPj+2KjG9GzzhpHXzqaQ434jdy9ciiqjk5igTn5SB/e/iU3YDUI/3/4fUwqv78c6
 nqfDfxTfqHl8r7xTXsuGf2GE/rn8Qke881aG+y+CwaSujav/D6UsZBMHLFMWCjx/
 2UjVcFFv7VCz1Atj3lP1w+QVls9g2HCttvvl4IQMkuWaHJ9nGjMZVuiiOD9quCQO
 Ls76JDL1hIa0cwE3K4kKOmpbkxbc37vf5H/Ra4qEwXyexmmus/4e/cJoKGscnKch
 AGAurE67oJljN6SrOHkg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxmgjew-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com
 [10.46.141.250])
 by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41QA9Q9t017413
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Feb 2024 10:09:26 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 26 Feb 2024 02:09:23 -0800
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: <u-boot@lists.denx.de>
CC: Varadarajan Narayanan <quic_varada@quicinc.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Michal Simek <michal.simek@amd.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>,
 Simon Glass <sjg@chromium.org>, "Sumit Garg" <sumit.garg@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/10] board: qualcomm: Add support for IPQ9574 RDP433
Date: Mon, 26 Feb 2024 15:38:07 +0530
Message-ID: <20240226100807.1095607-11-quic_varada@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226100807.1095607-1-quic_varada@quicinc.com>
References: <20240226100807.1095607-1-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: aZmaT7hRwF5YB2lwtx8CvwrqTcDIQCS6
X-Proofpoint-ORIG-GUID: aZmaT7hRwF5YB2lwtx8CvwrqTcDIQCS6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_07,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=885 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402260076
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

Provide the defconfig and include IPQ9574/RDP433 into the build
framework.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---

 arch/arm/mach-snapdragon/Kconfig  |  15 ++++
 arch/arm/mach-snapdragon/Makefile |   1 +
 configs/ipq9574_mmc_defconfig     | 118 ++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)
 create mode 100644 configs/ipq9574_mmc_defconfig

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index ad66710819..a4552028c1 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -90,6 +90,20 @@ config TARGET_QCS404EVB
 	  - 1GiB RAM
 	  - 8GiB eMMC, uSD slot
 
+config TARGET_IPQ9574
+	bool "QTI IPQ9574 SOC"
+	select OF_BOARD_SETUP
+	select CLK_QCOM_IPQ9574
+	select PINCTRL_QCOM_IPQ9574
+	help
+	  Support for IPQ95xx SoC.
+	  - Board Open Platform Specifications.
+	  - Quad Cores A73, max@2.2G, L1@32KB L2@512KB
+	  - DDR3L/DDR4
+	  - QSPI NAND / NOR / eMMC
+	  - USB 3.0/I2C/UART/PCIe Gen3 2Lane
+	  - 1G/2.5G/10G Ethernet Ports
+
 endchoice
 
 source "board/qualcomm/dragonboard410c/Kconfig"
@@ -97,5 +111,6 @@ source "board/qualcomm/dragonboard820c/Kconfig"
 source "board/qualcomm/dragonboard845c/Kconfig"
 source "board/samsung/starqltechn/Kconfig"
 source "board/qualcomm/qcs404-evb/Kconfig"
+source "board/qualcomm/ipq9574/Kconfig"
 
 endif
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 3a3a297c17..a9af8d9ee0 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -4,6 +4,7 @@
 
 obj-$(CONFIG_SDM845) += sysmap-sdm845.o
 obj-$(CONFIG_SDM845) += init_sdm845.o
+obj-$(CONFIG_TARGET_IPQ9574) += init_ipq9574.o
 obj-$(CONFIG_TARGET_DRAGONBOARD820C) += sysmap-apq8096.o
 obj-$(CONFIG_TARGET_DRAGONBOARD410C) += sysmap-apq8016.o
 obj-y += misc.o
diff --git a/configs/ipq9574_mmc_defconfig b/configs/ipq9574_mmc_defconfig
new file mode 100644
index 0000000000..0001bd8eae
--- /dev/null
+++ b/configs/ipq9574_mmc_defconfig
@@ -0,0 +1,118 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_ARCH_64BIT_SUPPORT=y
+# CONFIG_ARM64_SUPPORT_AARCH32 is not set
+CONFIG_ARM_SMCCC=y
+CONFIG_HAS_VBAR=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_IPQ9574=y
+CONFIG_TARGET_IPQ9574=y
+CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_SYS_MALLOC_F=y
+CONFIG_SYS_LOAD_ADDR=0x50000000
+CONFIG_TEXT_BASE=0x4A240000
+CONFIG_SMEM_BASE_ADDR=0x4AA00000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_SMEM=y
+CONFIG_SYS_MALLOC_LEN=0x180000
+CONFIG_DM_SERIAL=y
+CONFIG_DEFAULT_DEVICE_TREE="ipq9574-rdp433-mht-phy"
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EXPERT=y
+CONFIG_SYS_MALLOC_CLEAR_ON_INIT=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_LIBFDT=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+# CONFIG_BOOTSTD_BOOTCOMMAND is not set
+# CONFIG_PSCI_RESET is not set
+CONFIG_FIRMWARE=y
+CONFIG_DM=y
+CONFIG_OF_CONTROL=y
+CONFIG_FIT_SIGNATURE=n
+CONFIG_TOOLS_LIBCRYPTO=y
+CONFIG_TOOLS_FIT_RSASSA_PSS=n
+CONFIG_TOOLS_FIT_SIGNATURE=n
+CONFIG_TOOLS_SHA1=n
+CONFIG_TOOLS_SHA256=n
+CONFIG_TOOLS_SHA384=n
+CONFIG_TOOLS_SHA512=n
+CONFIG_SYS_EXTRA_OPTIONS=""
+CONFIG_SYS_PROMPT="IPQ9574# "
+# CONFIG_USE_PREBOOT is not set
+CONFIG_BOOTDELAY=5
+CONFIG_USE_BOOTARGS=y
+CONFIG_USE_BOOTCOMMAND=y
+CONFIG_BOOTCOMMAND=""
+CONFIG_BOOTARGS="console=ttyMSM0,115200n8"
+# CONFIG_BOOTSTD is not set
+CONFIG_HUSH_PARSER=y
+CONFIG_SYS_MAXARGS=64
+CONFIG_OF_BOARD_FIXUP=y
+CONFIG_STACKPROTECTOR=y
+CONFIG_MSM_SMEM=y
+CONFIG_SYS_CUSTOM_LDSCRIPT=y
+CONFIG_SYS_LDSCRIPT="board/qualcomm/ipq9574/u-boot-x64.lds"
+CONFIG_OF_LIST="ipq9574-rdp433-mht-phy"
+CONFIG_DTB_RESELECT=y
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_MULTI_DTB_FIT_LZO=y
+CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
+CONFIG_MULTI_DTB_FIT_USER_DEF_ADDR=0x4A400000
+CONFIG_MULTI_DTB_FIT_UNCOMPRESS_SZ=0x100000
+# CONFIG_CMD_BOOTI is not set
+CONFIG_ENV_OVERWRITE=y
+CONFIG_CLK=y
+CONFIG_CLK_QCOM=y
+CONFIG_CLK_IPQ9574=y
+# CONFIG_OF_EMBED is not set
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_QCOM=y
+CONFIG_PINCTRL_QCOM_IPQ9574=y
+CONFIG_IPQ_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_GPIO=y
+# CONFIG_CONFIG_GPIO_EXTRA_HEADER is not set
+CONFIG_DM_GPIO=y
+CONFIG_MMC_SDHCI_MSM=y
+# CONFIG_EFI_LOADER is not set
+# CONFIG_MMC_HS200_SUPPORT is not set
+CONFIG_EFI_PARTITION=y
+CONFIG_EFI_PARTITION_ENTRIES_NUMBERS=64
+CONFIG_MSM_GPIO=y
+CONFIG_PINCONF=y
+# CONFIG_CMD_GPIO is not set
+CONFIG_MSM_SERIAL=y
+CONFIG_STACK_SIZE=0x80000
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_DM_RESET=y
+CONFIG_RAM_NUM_PART_ENTRIES=32
+CONFIG_RAM_PART_NAME_LENGTH=16
+CONFIG_RESET_QCOM=y
+CONFIG_NUM_ALT_PARTITION=16
+CONFIG_BOARD_TYPES=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_IPQ_USB=y
+CONFIG_IPQ_SPI_NOR=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_MMC_ENV_PART=0
+CONFIG_ENV_SIZE=0x40000
+CONFIG_ENV_RANGE=0x40000
+CONFIG_ENV_OFFSET=0
+CONFIG_SF_DEFAULT_BUS=0
+CONFIG_SF_DEFAULT_CS=0
+CONFIG_SF_DEFAULT_MODE=0x0
+CONFIG_SF_DEFAULT_SPEED=50000000
+CONFIG_SYS_RX_ETH_BUFFER=128
+CONFIG_ETH_MAX_MAC=6
+CONFIG_ETH_MAX_UNIPHY=3
+CONFIG_TFTP_BLOCKSIZE=1280
+# CONFIG_CMD_FLASH is not set
+CONFIG_CMD_MMC=y
+CONFIG_IPQ_FDT_FIXUP=y
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x4a077e60
-- 
2.34.1

