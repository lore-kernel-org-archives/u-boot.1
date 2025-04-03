Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A1DBC36014
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 21:56:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66EF882385;
	Thu,  3 Apr 2025 23:55:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="newvU+ii";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75D6682845; Thu,  3 Apr 2025 23:55:46 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C49682724
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 23:55:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 533LtfD3128970
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Apr 2025 16:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743717341;
 bh=t2dqz7lMD1W6hhFeZ45hCZZlj8G6hKXCh2i00pUb2pQ=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=newvU+iipBBPtPJQMvzOsQ+BTpH9y0V3AOb/SL8EKZzQC2eUh6yneDj9jRsmq9mPx
 VR9Xvckwr0ER4TaPbt24tTWNGRc8HqfH8TPtHYd/C5piUtwT2I3eyfIrQA0IJkGlxC
 ilwVa/F9kV/Lq6omYmHw5yLKSB8523OswN4sUYlc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 533Ltfhu004503
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 3 Apr 2025 16:55:41 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Apr 2025 16:55:40 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Apr 2025 16:55:40 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 533Lte9b111260;
 Thu, 3 Apr 2025 16:55:40 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v6 3/4] configs: migrate falcon configs to SPL_HAS_BOOTx
Date: Fri, 4 Apr 2025 03:24:36 +0530
Message-ID: <20250403215522.1284502-3-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250403215522.1284502-1-anshuld@ti.com>
References: <20250403215522.1284502-1-anshuld@ti.com>
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

Replace usage of CMD_BOOTx in falcon mode configs with the newly added
SPL_HAS_BOOTx.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 configs/display5_defconfig         | 2 +-
 configs/display5_factory_defconfig | 2 +-
 configs/gwventana_emmc_defconfig   | 2 +-
 configs/gwventana_nand_defconfig   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/configs/display5_defconfig b/configs/display5_defconfig
index 765920bd5d1..c3012f1dce6 100644
--- a/configs/display5_defconfig
+++ b/configs/display5_defconfig
@@ -56,7 +56,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="display5 > "
 CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
+CONFIG_SPL_HAS_BOOTZ=y
 # CONFIG_CMD_ELF is not set
 CONFIG_CMD_SPL=y
 CONFIG_CMD_ASKENV=y
diff --git a/configs/display5_factory_defconfig b/configs/display5_factory_defconfig
index 4007c8900ce..b9137969a15 100644
--- a/configs/display5_factory_defconfig
+++ b/configs/display5_factory_defconfig
@@ -51,7 +51,7 @@ CONFIG_SYS_SPI_U_BOOT_OFFS=0x20000
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="display5 factory > "
 CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
+CONFIG_SPL_HAS_BOOTZ=y
 # CONFIG_CMD_ELF is not set
 CONFIG_CMD_SPL=y
 CONFIG_CMD_ASKENV=y
diff --git a/configs/gwventana_emmc_defconfig b/configs/gwventana_emmc_defconfig
index 95d5b1172ff..e7bf0ecfab8 100644
--- a/configs/gwventana_emmc_defconfig
+++ b/configs/gwventana_emmc_defconfig
@@ -59,7 +59,7 @@ CONFIG_SPL_POWER=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="Ventana > "
 CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
+CONFIG_SPL_HAS_BOOTZ=y
 CONFIG_CMD_SPL_WRITE_SIZE=0x20000
 CONFIG_CMD_UNZIP=y
 CONFIG_CMD_GPIO=y
diff --git a/configs/gwventana_nand_defconfig b/configs/gwventana_nand_defconfig
index 1d8af5ce103..30462953263 100644
--- a/configs/gwventana_nand_defconfig
+++ b/configs/gwventana_nand_defconfig
@@ -61,7 +61,7 @@ CONFIG_SPL_POWER=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="Ventana > "
 CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_BOOTZ=y
+CONFIG_SPL_HAS_BOOTZ=y
 CONFIG_CMD_SPL_NAND_OFS=0x1100000
 CONFIG_CMD_SPL_WRITE_SIZE=0x20000
 CONFIG_CMD_UNZIP=y
-- 
2.49.0

