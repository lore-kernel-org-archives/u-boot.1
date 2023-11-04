Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B88C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 07:23:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 358E587087;
	Sat,  4 Nov 2023 08:23:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Fd7f2SLq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A87E886FE4; Sat,  4 Nov 2023 08:22:30 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 939D286F07
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 08:22:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A47LsSn031810;
 Sat, 4 Nov 2023 02:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699082514;
 bh=dtJtfyY2Z8BfzQJnI2NcF6kgaIPEkIflLiv+OVqzr1A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Fd7f2SLqXrNZ/bIyUha/K6Xy65S2EZUgS/kXQU2OhO7pIUOqWKMQmzQeUTjWTi9r0
 EsyMHQc9PXyS5P16ZwyG8f3WNXyF+/kP2oZ/eYmMuXX/kCNHWXTR9pAgFCsfb/t51M
 advHsgCuhz/MNLpHlWBhCVwW2xPfdCFZfxZovA1s=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A47LsBn001180
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 02:21:54 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 02:21:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 02:21:54 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A47LsHL065279;
 Sat, 4 Nov 2023 02:21:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH V2 10/12] configs: j7200: Remove HBMC_AM654 config
Date: Sat, 4 Nov 2023 02:21:48 -0500
Message-ID: <20231104072150.3339-11-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104072150.3339-1-nm@ti.com>
References: <20231104072150.3339-1-nm@ti.com>
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

Kernel commit 1b77265626a4 ("arm64: dts: ti: k3-j7200-mcu-wakeup: Add
HyperBus node") was merged to kernel without its dependent patch [1].
Similar fix is needed in U-Boot, and hbmc currently breaks boot. Till
this gets fixed in U-Boot, disable the config by default so that the
hbmc probe that happens in board/ti/j721e/evm.c will not take place
and lead to boot failure.

This is similar to the approach in commit 5b2671594b80 ("configs:
j721e: Remove HBMC_AM654 config"), introduced to j7200 evm platform.

[1] https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 configs/j7200_evm_a72_defconfig | 1 -
 configs/j7200_evm_r5_defconfig  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index cb4a141675da..889358afc316 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -138,7 +138,6 @@ CONFIG_CFI_FLASH=y
 CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_FLASH_CFI_MTD=y
 CONFIG_SYS_FLASH_CFI=y
-CONFIG_HBMC_AM654=y
 CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index d25dd8134b63..6452c60345fd 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -114,7 +114,6 @@ CONFIG_CFI_FLASH=y
 CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_FLASH_CFI_MTD=y
 CONFIG_SYS_FLASH_CFI=y
-CONFIG_HBMC_AM654=y
 CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
-- 
2.37.2

