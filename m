Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B18BC3ABBE
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 00:54:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CC978210A;
	Wed,  7 May 2025 02:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD7EB81F66; Wed,  7 May 2025 02:53:52 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 7F0C781FAB
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 02:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0AE1E339;
 Tue,  6 May 2025 17:53:40 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13EFC3F673;
 Tue,  6 May 2025 17:53:48 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Sunil Mohan Adapa <sunil@medhas.org>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/2] sunxi: A64: enable DRIVEVBUS support for respective boards
Date: Wed,  7 May 2025 01:53:24 +0100
Message-ID: <20250507005325.15612-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250507005325.15612-1-andre.przywara@arm.com>
References: <20250507005325.15612-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The X-Powers AXP PMICs contain a special pin that can be used to drive
USB VBUS power, which requires a special AXP (sub-)driver.

Enable that for the 64-bit boards that use this pin, so that they can
enable VBUS power on their own, without relying on the help of TF-A.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 configs/a64-olinuxino-emmc_defconfig | 1 +
 configs/a64-olinuxino_defconfig      | 1 +
 configs/amarula_a64_relic_defconfig  | 1 +
 configs/bananapi_m64_defconfig       | 1 +
 configs/orangepi_win_defconfig       | 1 +
 configs/pinetab_defconfig            | 1 +
 6 files changed, 6 insertions(+)

diff --git a/configs/a64-olinuxino-emmc_defconfig b/configs/a64-olinuxino-emmc_defconfig
index a5989fab1c6..93f9e2eac28 100644
--- a/configs/a64-olinuxino-emmc_defconfig
+++ b/configs/a64-olinuxino-emmc_defconfig
@@ -7,5 +7,6 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SUN8I_EMAC=y
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/configs/a64-olinuxino_defconfig b/configs/a64-olinuxino_defconfig
index 0b469c25d0d..0b64b8370b4 100644
--- a/configs/a64-olinuxino_defconfig
+++ b/configs/a64-olinuxino_defconfig
@@ -6,5 +6,6 @@ CONFIG_MACH_SUN50I=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/configs/amarula_a64_relic_defconfig b/configs/amarula_a64_relic_defconfig
index 292af6e372e..8ea23ee4936 100644
--- a/configs/amarula_a64_relic_defconfig
+++ b/configs/amarula_a64_relic_defconfig
@@ -6,6 +6,7 @@ CONFIG_MACH_SUN50I=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_VIDEO_DE2 is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_MUSB_GADGET=y
diff --git a/configs/bananapi_m64_defconfig b/configs/bananapi_m64_defconfig
index d957071cb13..9d23739ffe5 100644
--- a/configs/bananapi_m64_defconfig
+++ b/configs/bananapi_m64_defconfig
@@ -7,6 +7,7 @@ CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SUN8I_EMAC=y
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_MUSB_GADGET=y
diff --git a/configs/orangepi_win_defconfig b/configs/orangepi_win_defconfig
index 4ce36cbab34..30c42366d1c 100644
--- a/configs/orangepi_win_defconfig
+++ b/configs/orangepi_win_defconfig
@@ -9,6 +9,7 @@ CONFIG_MTD=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_PHY_REALTEK=y
 CONFIG_SUN8I_EMAC=y
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
 CONFIG_SPI=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/configs/pinetab_defconfig b/configs/pinetab_defconfig
index 0cc24146b39..696357a222c 100644
--- a/configs/pinetab_defconfig
+++ b/configs/pinetab_defconfig
@@ -8,3 +8,4 @@ CONFIG_DRAM_CLK=552
 CONFIG_DRAM_ZQ=3881949
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_REGULATOR_AXP_DRIVEVBUS=y
-- 
2.46.3

