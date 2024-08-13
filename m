Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77265C52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 06:12:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DFBE889C9;
	Tue, 13 Aug 2024 08:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="TVguG9ce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2C69889CD; Tue, 13 Aug 2024 08:11:13 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0648897F
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 08:11:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47D6B9h8097524;
 Tue, 13 Aug 2024 01:11:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1723529469;
 bh=2Ei82HyJDmAB7OBzjBgu64DRzrK0whkVTUmMjxGA0u4=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=TVguG9ceWjxAJec8nABZShS8xgK7gIcT0+/s+3AVOe8Tr4+Z/in6+9+syALf2TjpD
 NhiqU/bPAKpi1PdESO6+z5YvIUp5XdRSEupUjwcgsRn2a5ZT0OEdc1p1ECd06GZULN
 aQRL2JdUjF/g6xWcSq8PGmH7l3ZjofKsK9y1GjbU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47D6B9DF040015
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 13 Aug 2024 01:11:09 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 13
 Aug 2024 01:11:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 13 Aug 2024 01:11:09 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47D6AgHn016562;
 Tue, 13 Aug 2024 01:11:06 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Date: Tue, 13 Aug 2024 11:40:47 +0530
Subject: [PATCH v3 7/7] configs: j721s2_evm_r5_defconfig: Add AVS Configs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240813-b4-upstream-j721s2-avs-v3-7-5115d93cdeb2@ti.com>
References: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
In-Reply-To: <20240813-b4-upstream-j721s2-avs-v3-0-5115d93cdeb2@ti.com>
To: Jaehoon Chung <jh80.chung@samsung.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Keerthy J
 <j-keerthy@ti.com>, Udit Kumar <u-kumar1@ti.com>, Aniket Limaye
 <a-limaye@ti.com>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723529443; l=1498;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=pywyIIWKpc0ZXiHMJ4RFnrwXqhCNjnCx6KJnnHfbOxY=;
 b=WTw8kEPuHFFrZxKTKbkm3/UA51sJCgzZu9xMoc0MX+BsRmAJvkmJxUB6Upfp1tvDZX1aeUkYK
 1MRnkQOQCsZCNYUulSVhTgcEKG2VomWapV7JNHXSyMiqv7s50oNR/b3
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
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

Add AVS and PMIC regulator configs

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
index 6404b1cc3037..288379797432 100644
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

