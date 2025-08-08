Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9D9C87FD3
	for <u-boot@archiver.kernel.org>; Fri,  8 Aug 2025 15:13:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4D3846E5;
	Fri,  8 Aug 2025 17:13:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="KV8zoFpX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B5084761; Fri,  8 Aug 2025 17:13:34 +0200 (CEST)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D50B4846D5
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 17:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=03156c240e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578FAQ5B018527;
 Fri, 8 Aug 2025 17:13:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 csDJJ0s40Qf5s6mLR4VP7M2R6mlKXgeI9c4ftX7v/Ec=; b=KV8zoFpXGKg1vQBq
 cewzr29d9CyUCCbdwE8AltGrgPTx1uE4QIe/zkJQKMWnN+R5tHgcksKzznnqtkIl
 oyJLC6O4pVpreSttndrpCiAe4WynMBbpG0m2nEC3azErto8ele5H0kFsTsrwfCzk
 kBZz/eYN6a94MWOoSNfZF9izzepsZXZaVshqLWWhtvg5Kx8H8ktSiW38u2g3uizm
 BFl8iEVUcB1QojLW9iTmpmbtAeMZg8z8KwctRYGF2Ghgg0VqioS2v+COFUfcVwzg
 Ly8hECcsCh1AD5Zi9CmA37c0STkFZu6lAUSDP1IsWwgS5AZ4YAH2/NZjpSAAlmB/
 Q3napQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48c7md0wh0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 08 Aug 2025 17:13:30 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9675F40048;
 Fri,  8 Aug 2025 17:12:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D0440714A3F;
 Fri,  8 Aug 2025 17:12:07 +0200 (CEST)
Received: from localhost (10.252.12.105) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Aug
 2025 17:12:07 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Cheick Traore
 <cheick.traore@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] configs: stm32mp25: Enable configs flags related to SPI
 flashes.
Date: Fri, 8 Aug 2025 17:11:53 +0200
Message-ID: <20250808151154.472860-5-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250808151154.472860-1-patrice.chotard@foss.st.com>
References: <20250808151154.472860-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.12.105]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_04,2025-08-06_01,2025-03-28_01
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

Enable configs flags related to SPI flashes.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 configs/stm32mp25_defconfig | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index 14619ffd96c..c8d8f14f843 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -33,6 +33,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_PWM=y
 # CONFIG_CMD_LOADB is not set
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
@@ -59,11 +60,22 @@ CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_STM32_OMM=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_STM32_SDMMC2=y
 CONFIG_MTD=y
+CONFIG_DM_MTD=y
 CONFIG_USE_SYS_MAX_FLASH_BANKS=y
-CONFIG_SPI_FLASH=y
+CONFIG_MTD_SPI_NAND=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_MACRONIX=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
+CONFIG_SPI_FLASH_MTD=y
 CONFIG_PINCONF=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
@@ -75,6 +87,7 @@ CONFIG_DM_RNG=y
 CONFIG_SERIAL_RX_BUFFER=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
+CONFIG_STM32_OSPI=y
 # CONFIG_OPTEE_TA_AVB is not set
 CONFIG_WDT=y
 CONFIG_WDT_STM32MP=y
-- 
2.25.1

