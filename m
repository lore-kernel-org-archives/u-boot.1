Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B148CCD1BF
	for <u-boot@archiver.kernel.org>; Sat, 25 Oct 2025 09:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6C93838E7;
	Sat, 25 Oct 2025 11:08:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OQFjoB8y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 266FE838C8; Sat, 25 Oct 2025 11:08:52 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F1AB83893
 for <u-boot@lists.denx.de>; Sat, 25 Oct 2025 11:08:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59P98lVu917045;
 Sat, 25 Oct 2025 04:08:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1761383327;
 bh=cNQlGNEevZUcB/KZbLooCbgPiQUNwr7wkar8SCA48qQ=;
 h=From:Date:Subject:References:In-Reply-To:To:CC;
 b=OQFjoB8yU9gsmGvwj+q8uZkGotPlkyPgfHG/R1OenoHM1Atg7Ice92BVMED3wwaOL
 DOv7/J/PE2YgBf4XPlyZREs09vBl8E2wZnYk3ABWKgnmZTM4FkAP7gH8wJ6wTk0Ywx
 TdHu6W4AKkyBQBDxkdci/dZGseXF9/Ttac8N9vPI=
Received: from DFLE200.ent.ti.com (dfle200.ent.ti.com [10.64.6.58])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59P98l1H4052407
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 25 Oct 2025 04:08:47 -0500
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 25 Oct
 2025 04:08:47 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sat, 25 Oct 2025 04:08:47 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59P98kjI1687162;
 Sat, 25 Oct 2025 04:08:47 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Sat, 25 Oct 2025 14:38:38 +0530
Subject: [PATCH v9 2/2] configs: disable SPL_BOOTZ to preserve spl size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251025-fix_cmd_bootx-v9-2-dccf0aa0587f@ti.com>
References: <20251025-fix_cmd_bootx-v9-0-dccf0aa0587f@ti.com>
In-Reply-To: <20251025-fix_cmd_bootx-v9-0-dccf0aa0587f@ti.com>
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Vignesh R
 <vigneshr@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761383322; l=2279;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=rSSNOO3KFbX+0Bt33Nev9vWpM8Aq1WoXM18P723haPA=;
 b=IoF7Me477RIIZin9EedMb1z5uKe7FiAN49GZu6ezcJT6fXrubngWh5mk1PnEiMRn7VIOa5+L0
 0E8Szj4nRksAlAsMsR7uUJTQpu5m6SiOxCCUdtQA40ZKUwc9zR9fBYw
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
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

In the existing behaviour, CMD_BOOTZ is not enabled by default which
means zimage.o is not compiled in the SPL in falcon mode unless
explicitly enabled. This changes now as SPL_BOOTZ is default y for
falcon users which leads to larger SPL size with zimage.o being present.

This patch modifies the defconfigs that used falcon mode but don't
require zimage support.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 configs/imx28_xea_defconfig          | 1 +
 configs/imx6qdl_icore_mipi_defconfig | 1 +
 configs/imx6qdl_icore_mmc_defconfig  | 1 +
 configs/imx6qdl_icore_rqs_defconfig  | 1 +
 4 files changed, 4 insertions(+)

diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 8715893bbcc0ad565ffc923ab5cc980e0f5bf0b3..0bb2e4472500b7ee1d31d29b35e78b82e912f4d2 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -132,3 +132,4 @@ CONFIG_DM_SPI=y
 CONFIG_MXS_SPI=y
 CONFIG_SPL_CRC8=y
 # CONFIG_SPL_OF_LIBFDT is not set
+# CONFIG_SPL_BOOTZ is not set
diff --git a/configs/imx6qdl_icore_mipi_defconfig b/configs/imx6qdl_icore_mipi_defconfig
index c322fd3eff14058c2d3d3cb8cb64103554114e1c..cc05ecf587f56bfe82ac7706b630653fcbd13458 100644
--- a/configs/imx6qdl_icore_mipi_defconfig
+++ b/configs/imx6qdl_icore_mipi_defconfig
@@ -74,3 +74,4 @@ CONFIG_PINCTRL_IMX6=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
+# CONFIG_SPL_BOOTZ is not set
diff --git a/configs/imx6qdl_icore_mmc_defconfig b/configs/imx6qdl_icore_mmc_defconfig
index 0b82fbecbee373371e87bff5baac2d0de75bed09..169903266cd5c7420ae9bab4045e1fe0b56fac6c 100644
--- a/configs/imx6qdl_icore_mmc_defconfig
+++ b/configs/imx6qdl_icore_mmc_defconfig
@@ -102,3 +102,4 @@ CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
 CONFIG_IMX_WATCHDOG=y
+# CONFIG_SPL_BOOTZ is not set
diff --git a/configs/imx6qdl_icore_rqs_defconfig b/configs/imx6qdl_icore_rqs_defconfig
index 8520f90c867aee27894baeac6994576589fe2c5f..34d834ec8e1556612c7e692a540eababaa84230f 100644
--- a/configs/imx6qdl_icore_rqs_defconfig
+++ b/configs/imx6qdl_icore_rqs_defconfig
@@ -71,3 +71,4 @@ CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+# CONFIG_SPL_BOOTZ is not set

-- 
2.51.0

