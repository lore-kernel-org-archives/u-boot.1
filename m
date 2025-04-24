Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8C1C369D5
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC36D81F4D;
	Thu, 24 Apr 2025 08:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Khge8Kum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81AF080BA8; Thu, 24 Apr 2025 08:08:43 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FBD7810EB
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:08:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6209a59483=patrice.chotard@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53O65nX3005857;
 Thu, 24 Apr 2025 08:08:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 lkqRxPV3ciFLo6BZsBi5AQHV2WRSCKcVoWsTAEFR6JQ=; b=Khge8KumLHwHK/tr
 SkR4OdIGtTVEMsr2vH7/UrnyMyxEksW56Imt0Bk5KD8WSshjfLoghe/TDmOR/keY
 7QN8jXM1OQ+k1KZzHzRsclaHr5MfD6Ngr5UCny5994cwDAhwJ+xiZkrIus5rJjFQ
 Eop6+mwjubEEAOFZNHWje2z2gC1R3E8s4V9JofLZqQoldyQlkP1pFzwpazkJ67Eb
 qHqNz5Htp3zCJRP4PZBQe43tGaCkijbv36LS2Hz2aL899zYQwAX9aZVB5/GCjIkp
 Wce81/UoU2HUKrGS8uW2Ct7UYwqSTiRKprXQ3B23eQvvnoKfFirB5lYMVadCvQt3
 ZgzQZQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jk3e1y2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Apr 2025 08:08:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D76B74004C;
 Thu, 24 Apr 2025 08:08:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 28818A4C08E;
 Thu, 24 Apr 2025 08:07:48 +0200 (CEST)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:07:47 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/21] board: st: stm32mp2: change bootcmd for ST boards
Date: Thu, 24 Apr 2025 08:07:12 +0200
Message-ID: <20250424060723.2695014-11-patrice.chotard@foss.st.com>
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

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

For nor0 boot for the STMicroelectronics boards, the bootfs
is found in SD-Card = mmc0 for nor0 boot.

Introduce a new file configuration file stm32mp25_st_common.h
to manage this specific behavior for the STMicroelectronics
boards; change the boot order for nor0 boot and don't use
the default DISTRO order define in BOOT_TARGET_DEVICES:
mmc1, ubifs, mmc0, mmc2.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Patrice CHOTARD <patrice.chotard@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

 board/st/stm32mp2/Kconfig             |  2 +-
 board/st/stm32mp2/MAINTAINERS         |  1 +
 include/configs/stm32mp25_st_common.h | 51 +++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 1 deletion(-)
 create mode 100644 include/configs/stm32mp25_st_common.h

diff --git a/board/st/stm32mp2/Kconfig b/board/st/stm32mp2/Kconfig
index 89039f068a2..f91e25f1f9a 100644
--- a/board/st/stm32mp2/Kconfig
+++ b/board/st/stm32mp2/Kconfig
@@ -7,7 +7,7 @@ config SYS_VENDOR
 	default "st"
 
 config SYS_CONFIG_NAME
-	default "stm32mp25_common"
+	default "stm32mp25_st_common"
 
 source "board/st/common/Kconfig"
 endif
diff --git a/board/st/stm32mp2/MAINTAINERS b/board/st/stm32mp2/MAINTAINERS
index e6bea910f92..8f624811f99 100644
--- a/board/st/stm32mp2/MAINTAINERS
+++ b/board/st/stm32mp2/MAINTAINERS
@@ -7,3 +7,4 @@ F:	arch/arm/dts/stm32mp25*
 F:	board/st/stm32mp2/
 F:	configs/stm32mp25_defconfig
 F:	include/configs/stm32mp25_common.h
+F:	include/configs/stm32mp25_st_common.h
diff --git a/include/configs/stm32mp25_st_common.h b/include/configs/stm32mp25_st_common.h
new file mode 100644
index 00000000000..ab5a4a91644
--- /dev/null
+++ b/include/configs/stm32mp25_st_common.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*
+ * Copyright (C) 2022, STMicroelectronics - All Rights Reserved
+ *
+ * Configuration settings for the STMicroelectonics STM32MP25x boards
+ */
+
+#ifndef __CONFIG_STM32MP25_ST_COMMON_H__
+#define __CONFIG_STM32MP25_ST_COMMON_H__
+
+#define STM32MP_BOARD_EXTRA_ENV \
+	"usb_pgood_delay=2000\0" \
+	"console=ttySTM0\0"
+
+#include <configs/stm32mp25_common.h>
+
+#ifdef CFG_EXTRA_ENV_SETTINGS
+/*
+ * default bootcmd for stm32mp25 STMicroelectronics boards:
+ * for serial/usb: execute the stm32prog command
+ * for mmc boot (eMMC, SD card), distro boot on the same mmc device
+ * for nand or spi-nand boot, distro boot with ubifs on UBI partition or
+ * sdcard
+ * for nor boot, distro boot on SD card = mmc0 ONLY !
+ */
+#define ST_STM32MP25_BOOTCMD "bootcmd_stm32mp=" \
+	"echo \"Boot over ${boot_device}${boot_instance}!\";" \
+	"if test ${boot_device} = serial || test ${boot_device} = usb;" \
+	"then stm32prog ${boot_device} ${boot_instance}; " \
+	"else " \
+		"run env_check;" \
+		"if test ${boot_device} = mmc;" \
+		"then env set boot_targets \"mmc${boot_instance}\"; fi;" \
+		"if test ${boot_device} = nand ||" \
+		  " test ${boot_device} = spi-nand ;" \
+		"then env set boot_targets ubifs0 mmc0; fi;" \
+		"if test ${boot_device} = nor;" \
+		"then env set boot_targets mmc0; fi;" \
+		"run distro_bootcmd;" \
+	"fi;\0"
+
+#undef CFG_EXTRA_ENV_SETTINGS
+#define CFG_EXTRA_ENV_SETTINGS \
+	STM32MP_MEM_LAYOUT \
+	ST_STM32MP25_BOOTCMD \
+	BOOTENV \
+	STM32MP_EXTRA \
+	STM32MP_BOARD_EXTRA_ENV
+
+#endif
+#endif
-- 
2.25.1

