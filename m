Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A4EC5475B
	for <u-boot@archiver.kernel.org>; Wed,  6 Mar 2024 12:09:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0671887DE6;
	Wed,  6 Mar 2024 13:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fy8Dq4Xm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7564D87CBA; Wed,  6 Mar 2024 07:38:03 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F404D87D33
 for <u-boot@lists.denx.de>; Wed,  6 Mar 2024 07:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4266bwvU007286
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 00:37:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709707078;
 bh=yaqD8YV8/dZ1d+IOKmG6NKwHDSWTrFZoFCe4rzHqZ4o=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Fy8Dq4XmjZ6JKtzd8MDTEHVSj4J9ngAuabD24Op3HqVaKLTIn2IZ1Za8iiKRAHyUO
 7NsR4fW86ubrUsi/9Geih4mCFobu4pUBpJvp+bbDFaQHFgRpEP8QFc4yuCdqepoDnY
 DC4HLw1QK2taoeZqaCwmtSvMLYZnQxRsB/EfVD6Q=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4266bw9O038320
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <u-boot@lists.denx.de>; Wed, 6 Mar 2024 00:37:58 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Mar 2024 00:37:58 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Mar 2024 00:37:58 -0600
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [10.24.68.244])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4266bsdl012351;
 Wed, 6 Mar 2024 00:37:56 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>
CC: <u-kumar1@ti.com>, <vaishnav.a@ti.com>, <a-nandan@ti.com>, Aniket Limaye
 <a-limaye@ti.com>
Subject: [PATCH 1/4] configs: j7200_evm_*_defconfig: Enable OSPI configs
Date: Wed, 6 Mar 2024 12:07:46 +0530
Message-ID: <20240306063749.1411176-2-a-limaye@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240306063749.1411176-1-a-limaye@ti.com>
References: <20240306063749.1411176-1-a-limaye@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 06 Mar 2024 13:09:02 +0100
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

Add the necessary configs required for OSPI functionality.
Also update the ospi flash partition offsets as per the devicetree.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 configs/j7200_evm_a72_defconfig | 10 ++++++++--
 configs/j7200_evm_r5_defconfig  |  9 +++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 2863472794..9ded9b2707 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -10,6 +10,8 @@ CONFIG_SOC_K3_J721E=y
 CONFIG_TARGET_J7200_A72_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
+CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_SF_DEFAULT_MODE=0
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
@@ -61,7 +63,7 @@ CONFIG_SPL_RAM_DEVICE=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x300000
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_SYS_MAXARGS=64
 CONFIG_CMD_ASKENV=y
@@ -141,7 +143,11 @@ CONFIG_FLASH_CFI_MTD=y
 CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
 CONFIG_DM_SPI_FLASH=y
-CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_SFDP_SUPPORT=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_SPI_FLASH_MTD=y
 CONFIG_MULTIPLEXER=y
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index 05eea55cfe..de5aaaece8 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -10,6 +10,8 @@ CONFIG_K3_EARLY_CONS=y
 CONFIG_TARGET_J7200_R5_EVM=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x41cf5bfc
+CONFIG_SF_DEFAULT_SPEED=25000000
+CONFIG_SF_DEFAULT_MODE=0
 CONFIG_ENV_SIZE=0x20000
 CONFIG_DM_GPIO=y
 CONFIG_SPL_DM_SPI=y
@@ -60,7 +62,7 @@ CONFIG_SPL_REMOTEPROC=y
 # CONFIG_SPL_SPI_FLASH_TINY is not set
 CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
-CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x100000
 CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=64
@@ -117,7 +119,10 @@ CONFIG_SYS_FLASH_CFI=y
 CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
-CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_SOFT_RESET=y
+CONFIG_SPI_FLASH_SOFT_RESET_ON_BOOT=y
+CONFIG_SPI_FLASH_SPANSION=y
+CONFIG_SPI_FLASH_S28HX_T=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
 CONFIG_SPL_PINCTRL=y
-- 
2.34.1

