Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6564CA0EED
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 08:20:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F2C83290;
	Thu, 28 Aug 2025 10:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E19BD8323A; Thu, 28 Aug 2025 10:20:12 +0200 (CEST)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D610831BB
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 10:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=primoz.fiser@norik.com
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:46304
 helo=localhost.localdomain)
 by cpanel.siel.si with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96.2)
 (envelope-from <primoz.fiser@norik.com>) id 1urXrc-001DXj-2L;
 Thu, 28 Aug 2025 10:20:08 +0200
From: Primoz Fiser <primoz.fiser@norik.com>
To: Mathieu Othacehe <m.othacehe@gmail.com>,
 Christoph Stoidner <c.stoidner@phytec.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	upstream@lists.phytec.de
Subject: [PATCH 2/2] board: phytec: phycore-imx93: Use CONFIG_PHYTEC_EEPROM_BUS
Date: Thu, 28 Aug 2025 10:20:08 +0200
Message-Id: <20250828082008.2978900-2-primoz.fiser@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828082008.2978900-1-primoz.fiser@norik.com>
References: <20250828082008.2978900-1-primoz.fiser@norik.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id:
 primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

Switch to use CONFIG_PHYTEC_EEPROM_BUS instead of the hard coded value
of 2 for the EEPROM I2C bus for both SPL and U-Boot proper. Possible
since commit 88a1816a9b4e ("board: phytec: common: Add PHYTEC_EEPROM_BUS
to Kconfig").

Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
---
 board/phytec/phycore_imx93/phycore-imx93.c | 2 +-
 board/phytec/phycore_imx93/spl.c           | 2 +-
 configs/imx93-phycore_defconfig            | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx93/phycore-imx93.c b/board/phytec/phycore_imx93/phycore-imx93.c
index fab66caf2a1c..c6a4e923b074 100644
--- a/board/phytec/phycore_imx93/phycore-imx93.c
+++ b/board/phytec/phycore_imx93/phycore-imx93.c
@@ -20,7 +20,7 @@ DECLARE_GLOBAL_DATA_PTR;
 
 int board_init(void)
 {
-	int ret = phytec_eeprom_data_setup(NULL, 2, EEPROM_ADDR);
+	int ret = phytec_eeprom_data_setup(NULL, CONFIG_PHYTEC_EEPROM_BUS, EEPROM_ADDR);
 
 	if (ret)
 		printf("%s: EEPROM data init failed\n", __func__);
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index beaa536c6007..7feee4bcf6fa 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -52,7 +52,7 @@ void spl_dram_init(void)
 	int ret;
 	enum phytec_imx93_ddr_eeprom_code ddr_opt = PHYTEC_IMX93_DDR_INVALID;
 
-	ret = phytec_eeprom_data_setup(NULL, 2, EEPROM_ADDR);
+	ret = phytec_eeprom_data_setup(NULL, CONFIG_PHYTEC_EEPROM_BUS, EEPROM_ADDR);
 	if (ret && !IS_ENABLED(CONFIG_PHYCORE_IMX93_RAM_TYPE_FIX))
 		goto out;
 
diff --git a/configs/imx93-phycore_defconfig b/configs/imx93-phycore_defconfig
index 53cd28dfcba6..0acdfd2bf53c 100644
--- a/configs/imx93-phycore_defconfig
+++ b/configs/imx93-phycore_defconfig
@@ -7,6 +7,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_PHYTEC_SOM_DETECTION=y
+CONFIG_PHYTEC_EEPROM_BUS=2
 CONFIG_ENV_SOURCE_FILE="phycore_imx93"
 CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x700000
-- 
2.34.1

