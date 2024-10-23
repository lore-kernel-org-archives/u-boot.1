Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA82BCF5386
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 13:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 814D2892F9;
	Wed, 23 Oct 2024 15:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="x+IZaWtt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12A5B892CB; Wed, 23 Oct 2024 15:02:35 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64EBF88DEF
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 15:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=a-limaye@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49ND2PAo029434;
 Wed, 23 Oct 2024 08:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729688545;
 bh=NIgjTpppFHZL5f++aYBFf2X9Cop6kStzDDACscThPPg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=x+IZaWttfOhxLkbMebGdXPadRVlmgFZJbO0ZXrR6oTrICbWumA/0t77KOtV8Pb9cm
 SQueh3Il9mKmqVzkWH80nX0ULeDo9aq/CV0rKF1xEyner7x8xptvnZdVQfHQmTy4KS
 11XmMekBREAj4kX/uIHyJ31+AufIEA4yjojF2zys=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49ND2Pq7111439;
 Wed, 23 Oct 2024 08:02:25 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Oct 2024 08:02:25 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Oct 2024 08:02:25 -0500
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49ND2BQ4037622;
 Wed, 23 Oct 2024 08:02:23 -0500
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v2 5/5] configs: j7200_evm_r5_defconfig: Define K3_OPP_LOW
Date: Wed, 23 Oct 2024 18:27:13 +0530
Message-ID: <20241023130033.1826413-6-a-limaye@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241023130033.1826413-1-a-limaye@ti.com>
References: <20241023130033.1826413-1-a-limaye@ti.com>
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

From: Reid Tonking <reidt@ti.com>

Adds the default config for K3_OPP_LOW in J7200

Signed-off-by: Reid Tonking <reidt@ti.com>
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---
 arch/arm/mach-k3/Kconfig       | 6 ++++++
 configs/j7200_evm_r5_defconfig | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index f3f42b39213..a095d8a29ae 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -103,6 +103,12 @@ config SYS_K3_BOOT_CORE_ID
 	int
 	default 16
 
+config K3_OPP_LOW
+	bool "Enable OPP_LOW on supported TI K3 SoCs"
+	help
+	  Enabling this will allow Socs with the proper efuse to run at a lower
+	  MPU core voltage and adjust frequency according to SoC trm
+
 config K3_EARLY_CONS
 	bool "Activate to allow for an early console during SPL"
 	depends on SPL
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index 1db92512dc2..bf6f3c6136d 100644
--- a/configs/j7200_evm_r5_defconfig
+++ b/configs/j7200_evm_r5_defconfig
@@ -102,6 +102,7 @@ CONFIG_K3_SEC_PROXY=y
 CONFIG_FS_LOADER=y
 CONFIG_SPL_FS_LOADER=y
 CONFIG_K3_AVS0=y
+# CONFIG_K3_OPP_LOW is not set
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
-- 
2.34.1

