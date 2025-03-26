Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955A1C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 12:12:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D7B68083E;
	Wed, 26 Mar 2025 13:12:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jBAEEcvd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E18581D4F; Wed, 26 Mar 2025 13:12:38 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 893858083E
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 13:12:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52QCCYLn2177162
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Mar 2025 07:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1742991154;
 bh=aryuIO4fGZLzkqmrJ6dT49jAZV8k5pTfi1dtCohJVhk=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=jBAEEcvdy8Zk5uu1wJjbPeiOoEB1H+KUUTJlq2T3a+q/xx8UuGfS0p0kStoJXt/Bo
 WpEFr9Gws9Evkt2Em/Hf1Hre5BWlyFRi/PRyaRqYTyihbE1DKYp4DNMhXpQJ0HgwPL
 AyDBZi3FKsDV3loXQqlF64Bk1mOLSQ/H4ZanO/mQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52QCCYXn023031
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 26 Mar 2025 07:12:34 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Mar 2025 07:12:33 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Mar 2025 07:12:33 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52QCCRgA127103;
 Wed, 26 Mar 2025 07:12:32 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <s-k6@ti.com>
Subject: [PATCH 2/3] configs: am62x: Add UBIFS support
Date: Wed, 26 Mar 2025 17:42:19 +0530
Message-ID: <20250326121220.1831975-3-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250326121220.1831975-1-s-k6@ti.com>
References: <20250326121220.1831975-1-s-k6@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Add UBIFS support on top of MTD devices by enabling the required
configs.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 configs/am62x_evm_a53_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
index d9596cb72242..130ff3924384 100644
--- a/configs/am62x_evm_a53_defconfig
+++ b/configs/am62x_evm_a53_defconfig
@@ -16,6 +16,7 @@ CONFIG_SPL_TEXT_BASE=0x80080000
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_SPL_MMC=y
+CONFIG_SPL_MTD=y
 CONFIG_SPL_SERIAL=y
 CONFIG_SPL_STACK_R_ADDR=0x82000000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
@@ -55,6 +56,9 @@ CONFIG_SPL_YMODEM_SUPPORT=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_MMC=y
+CONFIG_CMD_MTD=y
+CONFIG_CMD_MTDPARTS=y
+CONFIG_CMD_UBI=y
 CONFIG_CMD_EFIDEBUG=y
 CONFIG_MMC_SPEED_MODE_SET=y
 CONFIG_OF_CONTROL=y
@@ -97,6 +101,8 @@ CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_SPL_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_AM654=y
 CONFIG_MTD=y
+CONFIG_SPI_FLASH_MTD=y
+CONFIG_DM_MTD=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_SOFT_RESET=y
@@ -129,6 +135,7 @@ CONFIG_SOC_TI=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_CADENCE_QSPI=y
+CONFIG_ZSTD=y
 CONFIG_SYSRESET=y
 CONFIG_SPL_SYSRESET=y
 CONFIG_SYSRESET_TI_SCI=y
-- 
2.34.1

