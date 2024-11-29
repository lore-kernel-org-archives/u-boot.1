Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545A5D6EC04
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 12:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 329598943E;
	Fri, 29 Nov 2024 13:45:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FKgWNqww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6218B8921B; Fri, 29 Nov 2024 12:32:34 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 285BC891AB
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 12:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBWHRQ083575;
 Fri, 29 Nov 2024 05:32:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732879937;
 bh=//Zx1RfHK6xbLGgvOHKxijgJTAyUS4BF34JRueMkqEQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FKgWNqwwFwvK3M3BJx6Xo9sjtjQ5VWbJ0I9tSbOJ8HLqGTCBMVwKveag9m/Iym5jg
 w3SxgYoqLz+881J5VzcmCfbNfAfEg5ErYfZfTtLchp4AYhTuZSIP+tl0yWOvhxQswD
 D7KQwjoUR+c6yJjcAmzYDLj8lptn+VAzTawuxXNY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBWHel040889;
 Fri, 29 Nov 2024 05:32:17 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Nov 2024 05:32:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Nov 2024 05:32:17 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBVabU106135;
 Fri, 29 Nov 2024 05:32:12 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <a-dutta@ti.com>, <sjg@chromium.org>,
 <marex@denx.de>, <jonas@kwiboo.se>, <kever.yang@rock-chips.com>,
 <william.zhang@broadcom.com>, <a-limaye@ti.com>, <u-kumar1@ti.com>,
 <vaishnav.a@ti.com>, <sumit.garg@linaro.org>,
 <quentin.schulz@cherry.de>, <p-mantena@ti.com>,
 <ilias.apalodimas@linaro.org>, <afd@ti.com>, <nm@ti.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 7/8] configs: j7200_evm_*_defconfig: Add configs for
 Hyperflash boot
Date: Fri, 29 Nov 2024 17:01:35 +0530
Message-ID: <20241129113136.383277-8-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129113136.383277-1-a-dutta@ti.com>
References: <20241129113136.383277-1-a-dutta@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Fri, 29 Nov 2024 13:45:54 +0100
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

From: Vaishnav Achath <vaishnav.a@ti.com>

Kernel commit dbb124cf6888 ("configs: j7200: Remove HBMC_AM654
config") removed the HBMC_AM654 config because hbmc was broken
in u-boot. Hence, add the missing configs necessary to re-enable
Hyperflash boot.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 configs/j7200_evm_a72_defconfig | 4 +++-
 configs/j7200_evm_r5_defconfig  | 4 ++++
 configs/j721e_evm_r5_defconfig  | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index eb6203f2b4..d6b44967fe 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -137,11 +137,13 @@ CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
+CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_CFI_FLASH=y
 CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_FLASH_CFI_MTD=y
 CONFIG_SYS_FLASH_CFI=y
+CONFIG_HBMC_AM654=y
 CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
@@ -152,7 +154,7 @@ CONFIG_SPI_FLASH_S28HX_T=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_MULTIPLEXER=y
-CONFIG_MUX_MMIO=y
+CONFIG_SPL_MUX_MMIO=y
 CONFIG_PHY_TI_DP83869=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index f036a6fd46..57a8ffce05 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -110,11 +110,13 @@ CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
 CONFIG_DM_MTD=y
 CONFIG_MTD_NOR_FLASH=y
+CONFIG_SYS_FLASH_CFI_WIDTH_16BIT=y
 CONFIG_FLASH_SHOW_PROGRESS=0
 CONFIG_CFI_FLASH=y
 CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_FLASH_CFI_MTD=y
 CONFIG_SYS_FLASH_CFI=y
+CONFIG_HBMC_AM654=y
 CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
@@ -122,6 +124,8 @@ CONFIG_SPI_FLASH_SOFT_RESET=y
 CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
 CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_S28HX_T=y
+CONFIG_MULTIPLEXER=y
+CONFIG_SPL_MUX_MMIO=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
 CONFIG_SPL_PINCTRL=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index a593fed50a..9d767d7cda 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -137,7 +137,7 @@ CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
 CONFIG_MULTIPLEXER=y
-CONFIG_MUX_MMIO=y
+CONFIG_SPL_MUX_MMIO=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
 CONFIG_SPL_PINCTRL=y
-- 
2.34.1

