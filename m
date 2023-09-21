Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888F0E7D0A1
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 17:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 478A286784;
	Thu, 21 Sep 2023 19:18:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="0thHyBx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F6A786B70; Thu, 21 Sep 2023 19:06:54 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D09B864D4
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 19:06:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Durai.ManickamKR@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1695316013; x=1726852013;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VvYnIy6hholK0Kb98DhHGHAbqqdHwF3kxhiza4DZ1X8=;
 b=0thHyBx6jxMhXXhHAZY6Mstv4HI+OLaBv4FS2UBhcpUeRFFYMQzgtI76
 PAP16qYS0vMQyru3jA8npKL1Puzw6u0EhB0ZLxoXJQ/j2uz03yva+vjNi
 FhdzmL6r3Kf8K/8QAuR0oIz6ghBGaQOq9u2mTjZGLaCfpb7EEbp6D0gjN
 vpbUws3WYvcw9479vw4yzEqNS6XGzjJFdo/SuubVhlsEfKiGUiOuBrv6R
 +/R5MHvVUOljZJEhTnkWFcDDcRGmeGdXjScDEfv23Id/QEJCuqdFzjexk
 uztmPtSShkiURiIyfJL833zgf4tEFKb6B5HvbwcIoyTGa/qAEUNCsrqSz Q==;
X-CSE-ConnectionGUID: cU1AIYy8TkeLIR+AFzD2vA==
X-CSE-MsgGUID: J3GePMxHStyztmbZ5WUQRQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,166,1694761200"; d="scan'208";a="236462380"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 21 Sep 2023 10:06:50 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 21 Sep 2023 10:06:49 -0700
Received: from che-lt-i66125lx.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 21 Sep 2023 10:06:46 -0700
From: Durai Manickam KR <durai.manickamkr@microchip.com>
To: <u-boot@lists.denx.de>
CC: <durai.manickamkr@microchip.com>, <hari.prasathge@microchip.com>,
 <varshini.rajendran@microchip.com>, <cristian.birsan@microchip.com>,
 <nicolas.ferre@microchip.com>, <balamanikandan.gunasundar@microchip.com>
Subject: [PATCH 1/4] configs: at91: sam9x60_curiosity: update
 sam9x60_curiosity_mmc_defconfig
Date: Thu, 21 Sep 2023 22:36:28 +0530
Message-ID: <20230921170631.45752-2-durai.manickamkr@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921170631.45752-1-durai.manickamkr@microchip.com>
References: <20230921170631.45752-1-durai.manickamkr@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 21 Sep 2023 19:18:38 +0200
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

- Enable Device model supported NAND driver configs in SDMMC defconfig.
- Enable SYSRESET for Atmel/Microchip's platforms.

Signed-off-by: Durai Manickam KR <durai.manickamkr@microchip.com>
---
 configs/sam9x60_curiosity_mmc_defconfig | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/configs/sam9x60_curiosity_mmc_defconfig b/configs/sam9x60_curiosity_mmc_defconfig
index 10937d67d7..279c4c1f4b 100644
--- a/configs/sam9x60_curiosity_mmc_defconfig
+++ b/configs/sam9x60_curiosity_mmc_defconfig
@@ -38,6 +38,8 @@ CONFIG_CMD_DM=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_NAND=y
+CONFIG_CMD_NAND_TRIMFFS=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
 CONFIG_BOOTP_BOOTFILESIZE=y
@@ -50,6 +52,9 @@ CONFIG_OF_CONTROL=y
 CONFIG_ENV_IS_IN_FAT=y
 CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_AT91=y
@@ -60,10 +65,17 @@ CONFIG_CPU=y
 CONFIG_AT91_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_AT91=y
+CONFIG_ATMEL_EBI=y
+CONFIG_MFD_ATMEL_SMC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_MICROCHIP_FLEXCOM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ATMEL=y
+CONFIG_MTD=y
+CONFIG_DM_MTD=y
+CONFIG_MTD_RAW_NAND=y
+CONFIG_DM_NAND_ATMEL=y
+CONFIG_SYS_NAND_ONFI_DETECTION=y
 CONFIG_PHY_MICREL=y
 CONFIG_MACB=y
 CONFIG_PINCTRL=y
@@ -71,6 +83,8 @@ CONFIG_PINCTRL_AT91=y
 CONFIG_DM_SERIAL=y
 CONFIG_DEBUG_UART_ANNOUNCE=y
 CONFIG_ATMEL_USART=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_AT91=y
 CONFIG_TIMER=y
 CONFIG_MCHP_PIT64B_TIMER=y
 CONFIG_W1=y
-- 
2.25.1

