Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2F3D6EC05
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 12:46:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EFFC89436;
	Fri, 29 Nov 2024 13:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l2nsXPBs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C76F891AB; Fri, 29 Nov 2024 12:32:23 +0100 (CET)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22DAC89392
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 12:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4ATBW7ZB1308202
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Nov 2024 05:32:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1732879927;
 bh=frOr+fW3tfO/FlwXbSmi4m4ATFfvy2eQ6XPzv9FMubI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=l2nsXPBsNwBL7ctgcwhpiCMc3WP35Rhu+T99f9b1KKesOKSjI3Cqmz+kY+f3Vx+Cs
 4RVtcvsxuQ/DCIkjOY2bZiCcybYohd6jtXTltgwYTVL/zTUfxiOf2QGc8yxJ6Z/2Sm
 MuOc+aozSLkG63HV2YQeLe80ib694UA/eeguW54E=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4ATBW7MF029777
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 29 Nov 2024 05:32:07 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 29
 Nov 2024 05:32:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 29 Nov 2024 05:32:07 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4ATBVabS106135;
 Fri, 29 Nov 2024 05:32:02 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <a-dutta@ti.com>, <sjg@chromium.org>,
 <marex@denx.de>, <jonas@kwiboo.se>, <kever.yang@rock-chips.com>,
 <william.zhang@broadcom.com>, <a-limaye@ti.com>, <u-kumar1@ti.com>,
 <vaishnav.a@ti.com>, <sumit.garg@linaro.org>,
 <quentin.schulz@cherry.de>, <p-mantena@ti.com>,
 <ilias.apalodimas@linaro.org>, <afd@ti.com>, <nm@ti.com>,
 <avromanov@salutedevices.com>, <michael@amarulasolutions.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH 5/8] configs: j721e_evm_*_defconfig: Add configs for
 Hyperflash boot
Date: Fri, 29 Nov 2024 17:01:33 +0530
Message-ID: <20241129113136.383277-6-a-dutta@ti.com>
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

Kernel commit 5b2671594b80 ("configs: j721e: Remove HBMC_AM654
config") removed the HBMC_AM654 config because hbmc was broken
in u-boot. Hence, add the missing configs necessary to re-enable
Hyperflash boot.

Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 configs/j721e_evm_a72_defconfig | 4 +++-
 configs/j721e_evm_r5_defconfig  | 4 ++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index bd55634924..d742ae6934 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -140,11 +140,13 @@ CONFIG_MMC_SDHCI_AM654=y
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
@@ -157,7 +159,7 @@ CONFIG_SPI_FLASH_MT35XU=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_MULTIPLEXER=y
-CONFIG_MUX_MMIO=y
+CONFIG_SPL_MUX_MMIO=y
 CONFIG_PHY_TI_DP83867=y
 CONFIG_PHY_FIXED=y
 CONFIG_TI_AM65_CPSW_NUSS=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index 00546aea27..a593fed50a 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -121,11 +121,13 @@ CONFIG_MMC_SDHCI_AM654=y
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
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
@@ -134,6 +136,8 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_MULTIPLEXER=y
+CONFIG_MUX_MMIO=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
 CONFIG_SPL_PINCTRL=y
-- 
2.34.1

