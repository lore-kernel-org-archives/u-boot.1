Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8148CC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:11:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDB8D82139;
	Thu, 24 Apr 2025 08:09:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="o3wf+MNg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0F6E8214A; Thu, 24 Apr 2025 08:09:20 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6BF280944
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:09:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6209a59483=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NGeS6G008990;
 Thu, 24 Apr 2025 08:09:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 pl95mkvqI6LJCoJTL1s2qQFcf3UpD6ml2Mij5jtHCfY=; b=o3wf+MNgG+EfGp8I
 SIwJ0OkaOOCjQtOKovzD0vSVmI9svukG47P224H37oECEefrP+Fc7KVTSIDFixQv
 NslKEfKjj6ox32lT2/+RLdIgiQZhUNCENTGZe1I0XbJhyWEV5IGGX0VAyzhHCOPZ
 sQhXyaH+1DL+ikuES2kXW+D/lHo7cWIb5X/jUxUE455iRwqswWrrhGirJa5pyXqv
 LQ1zg+MMHoHqmD+SHDGdUVW1rmU7niyiaHOREFanv6CPWsO+I9QdYk2Ah+QymfeO
 LNVzfVo/Y9hR2mXQe+yE+1CLm6Own6qyhgMAO3SAs8ZKd6oDhDQSamqSUEUBo+IJ
 41HXkQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jjxdvu7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 08:09:14 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 1F56140044;
 Thu, 24 Apr 2025 08:08:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6E907A46C82;
 Thu, 24 Apr 2025 08:07:39 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:07:39 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/21] configs: stm32mp25: add MMC support
Date: Thu, 24 Apr 2025 08:07:03 +0200
Message-ID: <20250424060723.2695014-2-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250424060723.2695014-1-patrice.chotard@foss.st.com>
References: <20250424060723.2695014-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-24_02,2025-04-22_01,2025-02-21_01
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

Enable MMC related flags support for stm32mp25

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 configs/stm32mp25_defconfig | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index 2f8d34d15ff..717724ff672 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -2,6 +2,7 @@ CONFIG_ARM=y
 CONFIG_ARCH_STM32MP=y
 CONFIG_SYS_MALLOC_F_LEN=0x400000
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x90000000
+CONFIG_ENV_OFFSET=0x900000
 CONFIG_DEFAULT_DEVICE_TREE="st/stm32mp257f-ev1"
 CONFIG_SYS_BOOTM_LEN=0x2000000
 CONFIG_SYS_LOAD_ADDR=0x84000000
@@ -10,9 +11,10 @@ CONFIG_DDR_CACHEABLE_SIZE=0x10000000
 CONFIG_TARGET_ST_STM32MP25X=y
 CONFIG_SYS_MEMTEST_START=0x84000000
 CONFIG_SYS_MEMTEST_END=0x88000000
+CONFIG_API=y
+CONFIG_SYS_MMC_MAX_DEVICE=3
 CONFIG_FIT=y
 CONFIG_BOOTDELAY=1
-CONFIG_LAST_STAGE_INIT=y
 CONFIG_SYS_PROMPT="STM32MP> "
 # CONFIG_CMD_BDI is not set
 CONFIG_CMD_BOOTZ=y
@@ -24,6 +26,7 @@ CONFIG_CMD_CLK=y
 CONFIG_CMD_FUSE=y
 CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADB is not set
+CONFIG_CMD_MMC=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_TIME=y
 CONFIG_CMD_RNG=y
@@ -31,12 +34,16 @@ CONFIG_CMD_TIMER=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_MMC_ENV_DEV=1
 CONFIG_NO_NET=y
 CONFIG_SYS_64BIT_LBA=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
-# CONFIG_MMC is not set
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_STM32_SDMMC2=y
 CONFIG_PINCONF=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-- 
2.25.1

