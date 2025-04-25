Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397E7C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 13:19:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1636582893;
	Fri, 25 Apr 2025 15:17:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="hxHvhItv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5DC082918; Fri, 25 Apr 2025 15:17:19 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B03C282824
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 15:17:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=6210cfe02c=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P7eWTd009005;
 Fri, 25 Apr 2025 15:17:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=selector1; bh=
 MKlDNWCBqNQ55uS3vegcb858uoZ7COebEjJ/G835okM=; b=hxHvhItvCCpMVXn7
 PC3P6NH06nldzOVo7HFfk9WQ2vlld68Dy5lYLoN+0IX5QGnAe4Zd2sTfdE2ogBPt
 SO2x18OWDPMk3v0csIa0GiPAB4gFtWfGRewr47kZhXFjGnDWgBaVScOshJM2GXsR
 wBbhcJRsRY79czwI/0Iumsn47a2Sxil7EoXWPrQasGvu6TFsbzJQDOw1ActFzbbL
 2Kvup8EtIXLLcIqSbn05jETfr1VqeDZMnXDctSEvpit8+X2JOfFlMPHG1/5F5UHu
 4T3ONzmuVmVnGm2I7t/odQqQonpcDR2gbXFcZ3p7S/XnKHBaLT/aAClZ3P2mtGG4
 x8V89g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jjxm8kt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Apr 2025 15:17:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 80E7740064;
 Fri, 25 Apr 2025 15:16:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 66E1A90BF54;
 Fri, 25 Apr 2025 15:15:44 +0200 (CEST)
Received: from localhost (10.252.18.92) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 15:15:44 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
To: <u-boot@lists.denx.de>
CC: Patrice CHOTARD <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, U-Boot STM32
 <uboot-stm32@st-md-mailman.stormreply.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Jerome Forissier
 <jerome.forissier@linaro.org>, Simon Glass <sjg@chromium.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/22] board: st: stm32mp2: add user button support
Date: Fri, 25 Apr 2025 15:15:19 +0200
Message-ID: <20250425131533.392747-9-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250425131533.392747-1-patrice.chotard@foss.st.com>
References: <20250425131533.392747-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.252.18.92]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
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

Handle user button 2 to force boot with STM32CubeProgrammer.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---

(no changes since v1)

 board/st/stm32mp2/stm32mp2.c | 26 ++++++++++++++++++++++++++
 configs/stm32mp25_defconfig  |  4 +++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/board/st/stm32mp2/stm32mp2.c b/board/st/stm32mp2/stm32mp2.c
index 576a958c783..6e4f19b1664 100644
--- a/board/st/stm32mp2/stm32mp2.c
+++ b/board/st/stm32mp2/stm32mp2.c
@@ -5,6 +5,7 @@
 
 #define LOG_CATEGORY LOGC_BOARD
 
+#include <button.h>
 #include <config.h>
 #include <env_internal.h>
 #include <fdt_support.h>
@@ -13,10 +14,12 @@
 #include <misc.h>
 #include <mmc.h>
 #include <asm/global_data.h>
+#include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <dm/device.h>
 #include <dm/ofnode.h>
 #include <dm/uclass.h>
+#include <linux/delay.h>
 
 /*
  * Get a global data pointer
@@ -90,10 +93,33 @@ static int setup_led(enum led_state_t cmd)
 	return ret;
 }
 
+static void check_user_button(void)
+{
+	struct udevice *button;
+	int i;
+
+	if (!IS_ENABLED(CONFIG_CMD_STM32PROG) || !IS_ENABLED(CONFIG_BUTTON))
+		return;
+
+	if (button_get_by_label("User-2", &button))
+		return;
+
+	for (i = 0; i < 21; ++i) {
+		if (button_get_state(button) != BUTTON_ON)
+			return;
+		if (i < 20)
+			mdelay(50);
+	}
+
+	log_notice("entering download mode...\n");
+	clrsetbits_le32(TAMP_BOOT_CONTEXT, TAMP_BOOT_FORCED_MASK, BOOT_STM32PROG);
+}
+
 /* board dependent setup after realloc */
 int board_init(void)
 {
 	setup_led(LEDST_ON);
+	check_user_button();
 
 	return 0;
 }
diff --git a/configs/stm32mp25_defconfig b/configs/stm32mp25_defconfig
index 3d6665335f5..3f765346904 100644
--- a/configs/stm32mp25_defconfig
+++ b/configs/stm32mp25_defconfig
@@ -39,12 +39,14 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_MMC_ENV_DEV=-1
 CONFIG_NO_NET=y
 CONFIG_SYS_64BIT_LBA=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_GPIO=y
 CONFIG_GPIO_HOG=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_STM32F7=y
-CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_LED=y
 CONFIG_LED_GPIO=y
+CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_STM32_SDMMC2=y
 CONFIG_MTD=y
 CONFIG_USE_SYS_MAX_FLASH_BANKS=y
-- 
2.25.1

