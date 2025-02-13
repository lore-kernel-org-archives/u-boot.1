Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54625C021A4
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 17:34:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80F8D80EBD;
	Thu, 13 Feb 2025 18:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=ludwig.nussel@siemens.com header.b="CdfY6j/q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0001280ECB; Thu, 13 Feb 2025 17:21:38 +0100 (CET)
Received: from mta-64-228.siemens.flowmailer.net
 (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0D2380C96
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 17:21:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id
 20250213162135c501959621a02fd57a for <u-boot@lists.denx.de>;
 Thu, 13 Feb 2025 17:21:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=ludwig.nussel@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=CXMvDhv0UkmsAuk004LQOplu3vdS0b+2P6wRHrnm2pY=;
 b=CdfY6j/q+ESy7AkWZ7yyUXS/96JU6P/c+OurFrcpP6Y3iggRHpvVaV8jgNsHBei2En9mqo
 xFBE9ykxOO6dy38eoVeIB0kCot6ZOJwImcitNhCpuvneH180UBenRtw0AyMfbBfRp5jp/H+K
 UKM7IMEuMxFQk6v+umMcBGKnOdDaVrI3biLjsreKWhnAX0ASj7+xSRU1RTnnTyES+WICsAE5
 5lHQCv+sMOZDd55QwDaoG0OgTYbbqbSsdyPwKOFXvYPA2uoM7aK7peI6vjwYrQ1/HEYcEDfH
 krpxBah14DUFbKgTHhfIjeyCyV/Kip5Pmux3vxDJJDjiQgTsb61eiizw==;
From: Ludwig Nussel <ludwig.nussel@siemens.com>
To: u-boot@lists.denx.de
Cc: Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: [PATCH] imx: fix imx8mm_evk config
Date: Thu, 13 Feb 2025 17:21:23 +0100
Message-Id: <20250213162123.69159-1-ludwig.nussel@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328817:519-21489:flowmailer
X-Mailman-Approved-At: Thu, 13 Feb 2025 18:34:17 +0100
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

Commit 364ba68ed1a adjusted Kconfig for imx8mn_evk instead of
imx8mm_evk for bootstd. Therefore mm is actually left building
without bootstd by default.

Also the name of the dtb referenced mp instead of mm. IIUC
CONFIG_DEFAULT_FDT_FILE is meant to point to the path of the dtb
within the kernel install directory. Therefore adding freescale/ as
subdir too.

Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
---
 arch/arm/mach-imx/imx8m/Kconfig   | 2 ++
 configs/imx8mm_evk_defconfig      | 2 +-
 configs/imx8mm_evk_fspi_defconfig | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 0fe9c46e499..f8d0fd5de36 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -93,6 +93,8 @@ config TARGET_IMX8MM_EVK
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX8MM_ICORE_MX8MM
 	bool "Engicam i.Core MX8M Mini SOM"
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 659fc9ec039..0a7ceba68d3 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -25,7 +25,7 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
+CONFIG_DEFAULT_FDT_FILE="freescale/imx8mm-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index 4a8d4994b80..a06b47ac3ba 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -29,7 +29,7 @@ CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
 CONFIG_OF_SYSTEM_SETUP=y
-CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
+CONFIG_DEFAULT_FDT_FILE="freescale/imx8mm-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_LATE_INIT=y
-- 
2.34.1

