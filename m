Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690D7FF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 09:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 913F884852;
	Wed, 29 Apr 2026 11:28:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="hJ+CsmpG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BA0484836; Wed, 29 Apr 2026 11:28:49 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 92CF484832
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75D8732F8;
 Wed, 29 Apr 2026 02:28:37 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.154])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97F1A3F62B;
 Wed, 29 Apr 2026 02:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777454922; bh=071RWP6ewF/63GW+GWmNI5WIc7T0DIrwuRMH/3HtaE0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hJ+CsmpGsXeZ3H3OHog+uDguPJ2PLRieXqxfy8ALSiPCKEGTUasXjcTU/qdz8/wN5
 sQKQcILCxprnzzSdGEBQRfKQeJj6hsjsHVrZOeGgv2bre3qRgoAMG7/KMOCTNfQTXv
 kuEF+n8EH0+QPENZCH7axGv9Cm61D1WWvrtxGbvc=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 3/3] sunxi: configs: enable power LEDs on 64-bit boards
Date: Wed, 29 Apr 2026 11:28:28 +0200
Message-ID: <20260429092828.3076719-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429092828.3076719-1-andre.przywara@arm.com>
References: <20260429092828.3076719-1-andre.przywara@arm.com>
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

We recently gained a simple way to enable a power LED very early in the
SPL boot, through simple Kconfig variables.

Add those symbols to those boards' defconfigs where the DT indicates a
default-on power LED. The number used is <port bank> * 32 + <pin no>,
an active low setup means CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH must be
undefined.

This will light up the power LED very early in the (SPL) boot phase on
those 64-bit boards.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 configs/anbernic_rg35xx_h700_defconfig | 2 ++
 configs/bananapi_m64_defconfig         | 2 ++
 configs/beelink_gs1_defconfig          | 2 ++
 configs/liontron-h-a133l_defconfig     | 3 +++
 configs/nanopi_neo2_defconfig          | 2 ++
 configs/nanopi_neo_plus2_defconfig     | 2 ++
 configs/orangepi_3_defconfig           | 2 ++
 configs/orangepi_lite2_defconfig       | 2 ++
 configs/orangepi_pc2_defconfig         | 2 ++
 configs/orangepi_prime_defconfig       | 2 ++
 configs/orangepi_zero2_defconfig       | 2 ++
 configs/orangepi_zero_plus2_defconfig  | 2 ++
 configs/orangepi_zero_plus_defconfig   | 2 ++
 configs/radxa-cubie-a5e_defconfig      | 3 +++
 configs/tanix_tx1_defconfig            | 2 ++
 15 files changed, 32 insertions(+)

diff --git a/configs/anbernic_rg35xx_h700_defconfig b/configs/anbernic_rg35xx_h700_defconfig
index 2fa57cbecce..2abea94e979 100644
--- a/configs/anbernic_rg35xx_h700_defconfig
+++ b/configs/anbernic_rg35xx_h700_defconfig
@@ -16,6 +16,8 @@ CONFIG_DRAM_SUNXI_PHY_ADDR_MAP_1=y
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_LPDDR4=y
 CONFIG_R_I2C_ENABLE=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=268
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MVTWSI=y
diff --git a/configs/bananapi_m64_defconfig b/configs/bananapi_m64_defconfig
index d957071cb13..3d1f5d27e5d 100644
--- a/configs/bananapi_m64_defconfig
+++ b/configs/bananapi_m64_defconfig
@@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE="sun50i-a64-bananapi-m64"
 CONFIG_SPL=y
 CONFIG_MACH_SUN50I=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=120
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_SUN8I_EMAC=y
diff --git a/configs/beelink_gs1_defconfig b/configs/beelink_gs1_defconfig
index de46d205453..ebac032915f 100644
--- a/configs/beelink_gs1_defconfig
+++ b/configs/beelink_gs1_defconfig
@@ -5,6 +5,8 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN50I_H6=y
 CONFIG_SUNXI_DRAM_H6_LPDDR3=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=356
 # CONFIG_PSCI_RESET is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_LED=y
diff --git a/configs/liontron-h-a133l_defconfig b/configs/liontron-h-a133l_defconfig
index 831d5b56e3a..836e8d12ff0 100644
--- a/configs/liontron-h-a133l_defconfig
+++ b/configs/liontron-h-a133l_defconfig
@@ -23,6 +23,9 @@ CONFIG_MACH_SUN50I_A133=y
 CONFIG_SUNXI_DRAM_A133_LPDDR4=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_R_I2C_ENABLE=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=240
+# CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
diff --git a/configs/nanopi_neo2_defconfig b/configs/nanopi_neo2_defconfig
index 6704a24a880..63fa6bac9ba 100644
--- a/configs/nanopi_neo2_defconfig
+++ b/configs/nanopi_neo2_defconfig
@@ -6,6 +6,8 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN50I_H5=y
 CONFIG_DRAM_ZQ=3881977
 # CONFIG_DRAM_ODT_EN is not set
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/nanopi_neo_plus2_defconfig b/configs/nanopi_neo_plus2_defconfig
index e80e32a63d4..9d1b783476d 100644
--- a/configs/nanopi_neo_plus2_defconfig
+++ b/configs/nanopi_neo_plus2_defconfig
@@ -7,6 +7,8 @@ CONFIG_MACH_SUN50I_H5=y
 CONFIG_DRAM_ZQ=3881977
 # CONFIG_DRAM_ODT_EN is not set
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/orangepi_3_defconfig b/configs/orangepi_3_defconfig
index 125137bc321..409fa705a06 100644
--- a/configs/orangepi_3_defconfig
+++ b/configs/orangepi_3_defconfig
@@ -6,6 +6,8 @@ CONFIG_MACH_SUN50I_H6=y
 CONFIG_SUNXI_DRAM_H6_LPDDR3=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_BLUETOOTH_DT_DEVICE_FIXUP="brcm,bcm4345c5"
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=356
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_PHY_SUN50I_USB3=y
 CONFIG_USB_XHCI_HCD=y
diff --git a/configs/orangepi_lite2_defconfig b/configs/orangepi_lite2_defconfig
index 577f7436c15..5d72d34eb9d 100644
--- a/configs/orangepi_lite2_defconfig
+++ b/configs/orangepi_lite2_defconfig
@@ -4,6 +4,8 @@ CONFIG_DEFAULT_DEVICE_TREE="sun50i-h6-orangepi-lite2"
 CONFIG_SPL=y
 CONFIG_MACH_SUN50I_H6=y
 CONFIG_SUNXI_DRAM_H6_LPDDR3=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=356
 # CONFIG_PSCI_RESET is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/orangepi_pc2_defconfig b/configs/orangepi_pc2_defconfig
index d856a25814b..464b34f4ec0 100644
--- a/configs/orangepi_pc2_defconfig
+++ b/configs/orangepi_pc2_defconfig
@@ -6,6 +6,8 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN50I_H5=y
 CONFIG_DRAM_ZQ=3881977
 CONFIG_SPL_SPI_SUNXI=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
diff --git a/configs/orangepi_prime_defconfig b/configs/orangepi_prime_defconfig
index e93154cc0e9..e5e9009378c 100644
--- a/configs/orangepi_prime_defconfig
+++ b/configs/orangepi_prime_defconfig
@@ -6,6 +6,8 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN50I_H5=y
 CONFIG_DRAM_ZQ=3881977
 # CONFIG_DRAM_ODT_EN is not set
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/orangepi_zero2_defconfig b/configs/orangepi_zero2_defconfig
index 831bfe66e25..b387b4795ad 100644
--- a/configs/orangepi_zero2_defconfig
+++ b/configs/orangepi_zero2_defconfig
@@ -10,6 +10,8 @@ CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
 CONFIG_R_I2C_ENABLE=y
 CONFIG_SPL_SPI_SUNXI=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=76
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
diff --git a/configs/orangepi_zero_plus2_defconfig b/configs/orangepi_zero_plus2_defconfig
index c4d9800975c..9758ffd385e 100644
--- a/configs/orangepi_zero_plus2_defconfig
+++ b/configs/orangepi_zero_plus2_defconfig
@@ -7,6 +7,8 @@ CONFIG_MACH_SUN50I_H5=y
 CONFIG_DRAM_ZQ=3881977
 # CONFIG_DRAM_ODT_EN is not set
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/orangepi_zero_plus_defconfig b/configs/orangepi_zero_plus_defconfig
index 4b6491dc846..bb159428a14 100644
--- a/configs/orangepi_zero_plus_defconfig
+++ b/configs/orangepi_zero_plus_defconfig
@@ -6,6 +6,8 @@ CONFIG_SPL=y
 CONFIG_MACH_SUN50I_H5=y
 CONFIG_DRAM_ZQ=3881977
 # CONFIG_DRAM_ODT_EN is not set
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=362
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SUN8I_EMAC=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/radxa-cubie-a5e_defconfig b/configs/radxa-cubie-a5e_defconfig
index 9d204ef5548..84bc4e3d4a9 100644
--- a/configs/radxa-cubie-a5e_defconfig
+++ b/configs/radxa-cubie-a5e_defconfig
@@ -15,6 +15,9 @@ CONFIG_DRAM_SUNXI_TPR12=0x3533302f
 CONFIG_MACH_SUN55I_A523=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_R_I2C_ENABLE=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=356
+# CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH is not set
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
diff --git a/configs/tanix_tx1_defconfig b/configs/tanix_tx1_defconfig
index 1bd167ce0f6..03b18701859 100644
--- a/configs/tanix_tx1_defconfig
+++ b/configs/tanix_tx1_defconfig
@@ -14,6 +14,8 @@ CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_LPDDR3=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_R_I2C_ENABLE=y
+CONFIG_SPL_SUNXI_LED_STATUS=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=231
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
-- 
2.43.0

