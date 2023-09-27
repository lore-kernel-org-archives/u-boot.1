Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A510E7F14F
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 13:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72C7286E04;
	Wed, 27 Sep 2023 15:10:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VqttRNty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F9686E04; Wed, 27 Sep 2023 15:10:28 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89AAA86E0F
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 15:10:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RDAMh2075182;
 Wed, 27 Sep 2023 08:10:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695820222;
 bh=q1HWBEmN5E18zzFvr4n9FgYEfvAuFf4yI/adC4z6GMY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=VqttRNtyx7GB88+eKZjGrPOoewi9lDJB6VAhrhA/xQ3S4/Jjas3vS5x/qNdlkBs3c
 2nB1mR2c2b7rsIZA1bs/CzgpHhkiyU4jeifJyoQVISqllBbbfT1I85i1MvhDepz8HN
 yUawa3CmDAzko8ydVsJQf7+UJyDWMm75zBBSXrN0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RDAMwi008356
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 08:10:22 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 08:10:21 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 08:10:21 -0500
Received: from a0497641-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RD9uKe025731;
 Wed, 27 Sep 2023 08:10:17 -0500
From: Neha Malcom Francis <n-francis@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <reidt@ti.com>, <m-chawdhry@ti.com>, <afd@ti.com>,
 <sinthu.raja@ti.com>, <gadiyar@ti.com>, <a-nandan@ti.com>,
 <vaishnav.a@ti.com>, <n-francis@ti.com>, <b-kapoor@ti.com>,
 <bb@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v4 4/6] configs: j721e: Remove HBMC_AM654 config
Date: Wed, 27 Sep 2023 18:39:54 +0530
Message-ID: <20230927130956.910988-5-n-francis@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927130956.910988-1-n-francis@ti.com>
References: <20230927130956.910988-1-n-francis@ti.com>
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

Kernel commit d93036b47f35 ("arm64: dts: ti: k3-j721e-mcu_wakeup: Add
HyperBus node") was merged to kernel without its dependent patch [1].
Similar fix is needed in U-Boot, and hbmc currently breaks boot. Till
this gets fixed in U-Boot, disable the config by default so that the
hbmc probe that happens in board/ti/j721e/evm.c will not take place
and lead to boot failure.

[1] https://lore.kernel.org/all/20230424184810.29453-1-afd@ti.com/

Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 configs/j721e_evm_a72_defconfig | 1 -
 configs/j721e_evm_r5_defconfig  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
index 214fa8b2f3..beea948c4e 100644
--- a/configs/j721e_evm_a72_defconfig
+++ b/configs/j721e_evm_a72_defconfig
@@ -140,7 +140,6 @@ CONFIG_CFI_FLASH=y
 CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_FLASH_CFI_MTD=y
 CONFIG_SYS_FLASH_CFI=y
-CONFIG_HBMC_AM654=y
 CONFIG_SYS_MAX_FLASH_BANKS_DETECT=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_STMICRO=y
diff --git a/configs/j721e_evm_r5_defconfig b/configs/j721e_evm_r5_defconfig
index cf7bc872b5..d974be275f 100644
--- a/configs/j721e_evm_r5_defconfig
+++ b/configs/j721e_evm_r5_defconfig
@@ -127,7 +127,6 @@ CONFIG_CFI_FLASH=y
 CONFIG_SYS_FLASH_USE_BUFFER_WRITE=y
 CONFIG_FLASH_CFI_MTD=y
 CONFIG_SYS_FLASH_CFI=y
-CONFIG_HBMC_AM654=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPI_FLASH_STMICRO=y
-- 
2.34.1

