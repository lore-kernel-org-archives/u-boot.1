Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C09FC36014
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 21:55:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21112827C7;
	Thu,  3 Apr 2025 23:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="al1xmFBL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE2E58272A; Thu,  3 Apr 2025 23:55:44 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 680E88249D
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 23:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 533Ltdoi3795577
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 3 Apr 2025 16:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1743717339;
 bh=hvbXPuAAwP4WswF7REbIwJeXDBQNa+e+QlgU6ltVb3A=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=al1xmFBLYQEenjr0WvUVZMnWSUFB+0Uo0bfAi3moGKywlKXSyfJO+QBEyRo3mMSGU
 kidRspiRrEGzVrIf/8e03TLUyUorbdJYF6aZlgcjTRB7q7pbQMCoqFXifOZUlXyquQ
 tiLd93/3A2QVmCraXjqRVxdBVEhRw2/5dQ3vmtYk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 533Ltdit084055
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 3 Apr 2025 16:55:39 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 3
 Apr 2025 16:55:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 3 Apr 2025 16:55:39 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 533LtcD4111246;
 Thu, 3 Apr 2025 16:55:39 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v6 2/4] configs: disable SPL_HAS_BOOTZ to preserve spl size
Date: Fri, 4 Apr 2025 03:24:35 +0530
Message-ID: <20250403215522.1284502-2-anshuld@ti.com>
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

In the existing behaviour, CMD_BOOTZ is not enabled by default which
means zimage.o is not compiled in the SPL in falcon mode unless
explicitly enabled. This changes now as SPL_HAS_BOOTZ is default y which
leads to larger SPL size with zimage.o being present.

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
index 38282e6ea92..216b9f0fe78 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -128,3 +128,4 @@ CONFIG_DM_SPI=y
 CONFIG_MXS_SPI=y
 CONFIG_SPL_CRC8=y
 # CONFIG_SPL_OF_LIBFDT is not set
+CONFIG_SPL_HAS_BOOTZ=n
diff --git a/configs/imx6qdl_icore_mipi_defconfig b/configs/imx6qdl_icore_mipi_defconfig
index cf4c2d9c6f1..65cded5bff3 100644
--- a/configs/imx6qdl_icore_mipi_defconfig
+++ b/configs/imx6qdl_icore_mipi_defconfig
@@ -74,3 +74,4 @@ CONFIG_PINCTRL_IMX6=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
+CONFIG_SPL_HAS_BOOTZ=n
diff --git a/configs/imx6qdl_icore_mmc_defconfig b/configs/imx6qdl_icore_mmc_defconfig
index fb0787d1beb..0ce3de92079 100644
--- a/configs/imx6qdl_icore_mmc_defconfig
+++ b/configs/imx6qdl_icore_mmc_defconfig
@@ -101,3 +101,4 @@ CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_SPL_HAS_BOOTZ=n
diff --git a/configs/imx6qdl_icore_rqs_defconfig b/configs/imx6qdl_icore_rqs_defconfig
index 49feb1af830..d0967096379 100644
--- a/configs/imx6qdl_icore_rqs_defconfig
+++ b/configs/imx6qdl_icore_rqs_defconfig
@@ -71,3 +71,4 @@ CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SPL_HAS_BOOTZ=n
-- 
2.49.0

