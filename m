Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596FEC369A4
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 14:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57F5D82D2E;
	Tue,  8 Apr 2025 16:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Tio/nvPs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBFC782E38; Tue,  8 Apr 2025 16:14:53 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB31682E0A
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 16:14:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 538EEnve1232964
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 09:14:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744121689;
 bh=GOgkoIeLyUw6NfdOdCK1RHYpkYHIM8RGTGOn+fASOs0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Tio/nvPsxjf+7FFiC+EXIkuy9uJq6/YOdFSwKtHLANx0DnehJNoyDp3/2bJnWbiO+
 xYVYmCcO/MJObPXUwjgG4ieOsCPy2ASsvFKl7zTPh8C7g+Lt+HMRz82AMXkEgleyXC
 JBAYiyiRc02u+7snUBtFI7q9uqOyhf4dtsb54EhQ=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 538EEn9m087549
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Apr 2025 09:14:49 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Apr 2025 09:14:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Apr 2025 09:14:48 -0500
Received: from localhost (dhcp-172-24-227-250.dhcp.ti.com [172.24.227.250])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 538EEm9p010365;
 Tue, 8 Apr 2025 09:14:48 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>
Subject: [PATCH v7 2/4] configs: disable SPL_BOOTZ to preserve spl size
Date: Tue, 8 Apr 2025 19:44:31 +0530
Message-ID: <20250408141436.712387-2-anshuld@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408141436.712387-1-anshuld@ti.com>
References: <20250408141436.712387-1-anshuld@ti.com>
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
explicitly enabled. This changes now as SPL_BOOTZ is default y which
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
index 38282e6ea92..cbd5a788c64 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -128,3 +128,4 @@ CONFIG_DM_SPI=y
 CONFIG_MXS_SPI=y
 CONFIG_SPL_CRC8=y
 # CONFIG_SPL_OF_LIBFDT is not set
+CONFIG_SPL_BOOTZ=n
diff --git a/configs/imx6qdl_icore_mipi_defconfig b/configs/imx6qdl_icore_mipi_defconfig
index cf4c2d9c6f1..6d556c5fab7 100644
--- a/configs/imx6qdl_icore_mipi_defconfig
+++ b/configs/imx6qdl_icore_mipi_defconfig
@@ -74,3 +74,4 @@ CONFIG_PINCTRL_IMX6=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
+CONFIG_SPL_BOOTZ=n
diff --git a/configs/imx6qdl_icore_mmc_defconfig b/configs/imx6qdl_icore_mmc_defconfig
index fb0787d1beb..f5a1ad0dde7 100644
--- a/configs/imx6qdl_icore_mmc_defconfig
+++ b/configs/imx6qdl_icore_mmc_defconfig
@@ -101,3 +101,4 @@ CONFIG_SPLASH_SCREEN=y
 CONFIG_SPLASH_SCREEN_ALIGN=y
 CONFIG_BMP_16BPP=y
 CONFIG_IMX_WATCHDOG=y
+CONFIG_SPL_BOOTZ=n
diff --git a/configs/imx6qdl_icore_rqs_defconfig b/configs/imx6qdl_icore_rqs_defconfig
index 49feb1af830..e12757545e6 100644
--- a/configs/imx6qdl_icore_rqs_defconfig
+++ b/configs/imx6qdl_icore_rqs_defconfig
@@ -71,3 +71,4 @@ CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
 CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
+CONFIG_SPL_BOOTZ=n
-- 
2.49.0

