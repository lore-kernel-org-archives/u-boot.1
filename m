Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D605C02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 04:39:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBDA680821;
	Sat,  8 Feb 2025 05:39:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WQ7ET1bi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 524EC80820; Sat,  8 Feb 2025 05:39:47 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EF9A807FE
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 05:39:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5184dhTA3127016
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 7 Feb 2025 22:39:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738989583;
 bh=AJspFQE25ypdvKJZRGPdc/XGdyR1QKV0TX7cFoO6Ziw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=WQ7ET1big9H4x+Huhf7GbOPes3v+cHgxwT5AoBALdKfEhOJESjEqE71e/iPLYBFXa
 Fc7LniG1Lhl+GHnEoxYqRdF41I+pGGaKIw0HrqR5MXsZcWekQFqwoFjPY2qLfJquSD
 c2p5IWa9supidA7f7AemeQoTb86pxtYlMwWv5yhg=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5184dhHj078068;
 Fri, 7 Feb 2025 22:39:43 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 7
 Feb 2025 22:39:43 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 7 Feb 2025 22:39:42 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [172.24.227.92])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5184dcKn045742;
 Fri, 7 Feb 2025 22:39:41 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <afd@ti.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <a-dutta@ti.com>, <a-chavda@ti.com>,
 <u-kumar1@ti.com>
Subject: [PATCH 1/2] configs: am57xx_hs: Remove saved environments
Date: Sat, 8 Feb 2025 10:09:37 +0530
Message-ID: <20250208043938.52832-2-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250208043938.52832-1-a-dutta@ti.com>
References: <20250208043938.52832-1-a-dutta@ti.com>
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

Saved environments cause inconsistencies leading to conflicts
with the default environment that U-boot should update during
development. Remove the previously saved environment so that
the default environment is always loaded.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 configs/am57xx_hs_evm_defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/configs/am57xx_hs_evm_defconfig b/configs/am57xx_hs_evm_defconfig
index 5cacd7f9cc5..a406e899d42 100644
--- a/configs/am57xx_hs_evm_defconfig
+++ b/configs/am57xx_hs_evm_defconfig
@@ -13,7 +13,6 @@ CONFIG_TI_SECURE_EMIF_PROTECTED_REGION_SIZE=0x01c00000
 CONFIG_TARGET_AM57XX_EVM=y
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SPL=y
-CONFIG_ENV_OFFSET_REDUND=0x280000
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
 CONFIG_SPL_SPI=y
 CONFIG_ARMV7_LPAE=y
@@ -50,8 +49,7 @@ CONFIG_CMD_AVB=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_OF_LIST="am57xx-beagle-x15 am57xx-beagle-x15-revb1 am57xx-beagle-x15-revc am5729-beagleboneai am572x-idk am571x-idk am574x-idk"
-CONFIG_ENV_OVERWRITE=y
-CONFIG_ENV_IS_IN_MMC=y
+# CONFIG_ENV_IS_IN_FAT is not set
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_SYS_MMC_ENV_DEV=1
-- 
2.34.1

