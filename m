Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BFBC52D71
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 15:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C983F88A8A;
	Wed,  7 Aug 2024 17:27:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="pFOFpk09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79C64889EF; Wed,  7 Aug 2024 17:27:06 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F23188A8A
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 17:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 477FR1WE109861;
 Wed, 7 Aug 2024 10:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723044421;
 bh=1mXO2tJQ5NYMosDuOyWCb0XvYioaDbNF0UTfSvzLp30=;
 h=From:To:CC:Subject:Date;
 b=pFOFpk09VENjDTArEPCSPXlPMFjjYIn4Ujz2Dw14ortiyM8R7HU/ok3o0XxbpDQRo
 6+szjgpWkDHgF39jjsEiilQGAtg1UXY5qvQnv3EU34cU37+tjI2jcl5JFGQ/Im07m8
 xzBLrshxDRSt9qt4cUJvaLojUp/9eQp0ieB9wx+Y=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 477FR11j055580
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 7 Aug 2024 10:27:01 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Aug 2024 10:27:00 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Aug 2024 10:27:00 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 477FR0LB090040;
 Wed, 7 Aug 2024 10:27:00 -0500
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH] defconfig: Add a config for AM335x High Security EVM with SPI
 Boot support
Date: Wed, 7 Aug 2024 10:26:59 -0500
Message-ID: <20240807152659.313103-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Add a new defconfig file for the AM335x High Security EVM. This config
is specific for the case of SPI booting.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 configs/am335x_hs_evm_spi_defconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 configs/am335x_hs_evm_spi_defconfig

diff --git a/configs/am335x_hs_evm_spi_defconfig b/configs/am335x_hs_evm_spi_defconfig
new file mode 100644
index 00000000000..df009844def
--- /dev/null
+++ b/configs/am335x_hs_evm_spi_defconfig
@@ -0,0 +1,26 @@
+#include <configs/am335x_hs_evm_defconfig>
+
+CONFIG_ARM=y
+CONFIG_ARCH_OMAP2PLUS=y
+
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI_SUPPORT=y
+
+CONFIG_SPI_BOOT=y
+
+CONFIG_SPL_MTD_SUPPORT=y
+
+CONFIG_CMD_MMC=y
+CONFIG_CMD_SF=y
+CONFIG_CMD_SPI=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_USB=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
+# CONFIG_CMD_SETEXPR is not set
+CONFIG_CMD_EXT4_WRITE=y
+
+CONFIG_BLK=n
+
+CONFIG_USE_TINY_PRINTF=y
+CONFIG_SPL_OF_LIBFDT=y
-- 
2.39.2

