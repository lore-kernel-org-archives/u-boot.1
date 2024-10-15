Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B8DCFC287
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 10:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9A0891B3;
	Tue, 15 Oct 2024 12:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="p1N10L4/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CE6889181; Tue, 15 Oct 2024 12:52:54 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07FA3890F2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 12:52:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqn8Q050606;
 Tue, 15 Oct 2024 05:52:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1728989569;
 bh=yWASetu0LicvkPFLHQdgDPIfFB63t9OI0Dceq2IhCLU=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=p1N10L4/y+KXTFPo0w5+A1vkifjqCJ/99eQYGgz2BJ+fogtLFcBC0yBTg43xWgEnS
 +aeGmL6tNvVp1to1+iXDCS+ye8YSeOLCvmIZ3FpjR/OZuAxXcr+D0bmlvLjLx6SeRX
 eLAHnYGjBRBl7ZxXRHMAR1SXw92kLEjFHaDsBRQo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqnMf082726;
 Tue, 15 Oct 2024 05:52:49 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Oct 2024 05:52:49 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Oct 2024 05:52:49 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FAqJbl044559;
 Tue, 15 Oct 2024 05:52:45 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 15 Oct 2024 16:22:23 +0530
Subject: [PATCH v5 7/7] configs: j721s2_evm_r5_defconfig: Add AVS Configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241015-b4-upstream-j721s2-avs-v5-7-5c8087387dc5@ti.com>
References: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
In-Reply-To: <20241015-b4-upstream-j721s2-avs-v5-0-5c8087387dc5@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Simon Glass <sjg@chromium.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728989539; l=1611;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=ucKLPjt8eS1zfc/KfQzJej5lSCxi3npNj6qv9s9/VsU=;
 b=oI+jpISZ5gevUgux0WIj86mue96F4fD1Wgfwu/0kQodC0Pve6kRf1r5lXjxwXI8mdISj3BdtT
 0twtCdSOegDDWFDi8Ljph8D8wL7dav5d6ZOXyOjyMLZH4PsD/EdXXRX
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Add AVS and PMIC regulator configs

Also, disable it explicitly in am68_sk_r5_defconfig as it includes
j721s2_evm_r5_defconfig for re-usability.

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
 configs/am68_sk_r5_defconfig    | 4 ++++
 configs/j721s2_evm_r5_defconfig | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/configs/am68_sk_r5_defconfig b/configs/am68_sk_r5_defconfig
index e9b6882c1f68..f4800ef1b8ac 100644
--- a/configs/am68_sk_r5_defconfig
+++ b/configs/am68_sk_r5_defconfig
@@ -5,6 +5,10 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_J721S2=y
 CONFIG_TARGET_J721S2_R5_EVM=y
 
+CONFIG_K3_AVS0=n
+CONFIG_DM_REGULATOR_TPS65941=n
+CONFIG_PMIC_TPS65941=n
+
 CONFIG_DEFAULT_DEVICE_TREE="k3-am68-sk-r5-base-board"
 CONFIG_SPL_OF_LIST="k3-am68-sk-r5-base-board"
 CONFIG_OF_LIST="k3-am68-sk-r5-base-board"
diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
index b6adb6a77d7e..ad7653c8f99b 100644
--- a/configs/j721s2_evm_r5_defconfig
+++ b/configs/j721s2_evm_r5_defconfig
@@ -112,6 +112,7 @@ CONFIG_DM_MAILBOX=y
 CONFIG_K3_SEC_PROXY=y
 CONFIG_FS_LOADER=y
 CONFIG_SPL_FS_LOADER=y
+CONFIG_K3_AVS0=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SPL_MMC_HS400_SUPPORT=y
 CONFIG_MMC_SDHCI=y
@@ -141,6 +142,11 @@ CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_SINGLE=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_TI_POWER_DOMAIN=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_TPS65941=y
+CONFIG_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_TPS65941=y
 CONFIG_K3_SYSTEM_CONTROLLER=y
 CONFIG_REMOTEPROC_TI_K3_ARM64=y
 CONFIG_RESET_TI_SCI=y

-- 
2.46.0

