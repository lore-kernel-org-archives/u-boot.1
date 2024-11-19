Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79213D60D03
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 00:37:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A75EA894AC;
	Tue, 19 Nov 2024 01:36:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="MtVPrOhc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71F80894BB; Tue, 19 Nov 2024 01:36:45 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A4D3894B4
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 01:36:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-limaye@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ0afZg053177;
 Mon, 18 Nov 2024 18:36:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1731976601;
 bh=o4ClvjNC8kKHRN/GXXkR3kAfZoEZR4I6+bvxgOtBRGI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=MtVPrOhc3sUIG6J23KxwoAi49GwgIN8takTKXtHKBInW6hCKlG6BgolFyg6Ycbs3Q
 c7sf2htqMV1muMIuaS+nxSzGlbNYrw4+APvxhZLe3rIVa+zPcRuPioTrMfRTyBKF3z
 xwYjFj7qPvCNFB3hKH34EZhvDUrvH/5040A6nlIU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4AJ0aful031168
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 18 Nov 2024 18:36:41 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Nov 2024 18:36:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Nov 2024 18:36:41 -0600
Received: from PSDKL-Workstation0.dhcp.ti.com (psdkl-workstation0.dhcp.ti.com
 [172.24.227.91])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4AJ0aPMY114132;
 Mon, 18 Nov 2024 18:36:39 -0600
From: Aniket Limaye <a-limaye@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <u-kumar1@ti.com>, <reidt@ti.com>, <m-chawdhry@ti.com>, <nm@ti.com>,
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>
Subject: [PATCH v4 5/5] configs: j7200_evm_r5_defconfig: Define K3_OPP_LOW
Date: Tue, 19 Nov 2024 06:02:59 +0530
Message-ID: <20241119003617.1871183-6-a-limaye@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119003617.1871183-1-a-limaye@ti.com>
References: <20241119003617.1871183-1-a-limaye@ti.com>
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

Define new CONFIG_K3_OPP_LOW under arm/mach-k3/r5/Kconfig and add
default value to j7200_evm_r5_defconfig

Signed-off-by: Reid Tonking <reidt@ti.com>
Signed-off-by: Aniket Limaye <a-limaye@ti.com>
---

v4:
- Move Config definition to arch/arm/mach-k3/r5/Kconfig
- Link to v3: https://lore.kernel.org/u-boot/20241116071615.839623-6-a-limaye@ti.com/

v3:
- Add Kconfig dependency on K3_AVS0
- Update commit msg to make it more clear
- Link to v2: https://lore.kernel.org/u-boot/20241023130033.1826413-6-a-limaye@ti.com/
---
 arch/arm/mach-k3/r5/Kconfig    | 7 +++++++
 configs/j7200_evm_r5_defconfig | 1 +
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-k3/r5/Kconfig b/arch/arm/mach-k3/r5/Kconfig
index 878087fbf56..12335880e10 100644
--- a/arch/arm/mach-k3/r5/Kconfig
+++ b/arch/arm/mach-k3/r5/Kconfig
@@ -1,6 +1,13 @@
 config K3_LOAD_SYSFW
 	bool
 
+config K3_OPP_LOW
+	depends on ARCH_K3 && K3_AVS0
+	bool "Enable OPP_LOW on supported TI K3 SoCs"
+	help
+	  Enabling this will allow Socs with the proper efuse to run at a lower
+	  MPU core voltage and adjust frequency according to SoC TRM
+
 config K3_QOS
 	bool "Enable Quality of Service (QoS) Settings for TI K3 SoCs"
 	default y if SOC_K3_AM62A7
diff --git a/configs/j7200_evm_r5_defconfig b/configs/j7200_evm_r5_defconfig
index f036a6fd46b..217759e5d1b 100644
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
2.47.0

