Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC55C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 01:01:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6DA68789F;
	Mon,  4 Dec 2023 02:01:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED79487076; Mon,  4 Dec 2023 02:01:25 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9D10A878E5
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 02:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 351451691;
 Sun,  3 Dec 2023 17:02:04 -0800 (PST)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B2813F6C4;
 Sun,  3 Dec 2023 17:01:15 -0800 (PST)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Vignesh R <vigneshr@ti.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
 Bob McChesney <bob@electricworry.net>,
 Stephen Graf <stephen.graf@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/3] sunxi: H616: remove default AXP305 selection
Date: Mon,  4 Dec 2023 00:59:53 +0000
Message-Id: <20231204005954.13201-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20231204005954.13201-1-andre.przywara@arm.com>
References: <20231204005954.13201-1-andre.przywara@arm.com>
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

The original H616 devices released about three years ago were typically
paired with an X-Powers AXP305 PMIC. Newer devices uses the smaller
AXP313, and there seem to be far more systems with this PMIC around now.

Remove the default AXP305 selection for the H616 SoC from the Kconfig,
and move the PMIC selection into the board defconfig files instead.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 configs/orangepi_zero2_defconfig | 1 +
 configs/x96_mate_defconfig       | 1 +
 drivers/power/Kconfig            | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/orangepi_zero2_defconfig b/configs/orangepi_zero2_defconfig
index 50009e823cb..98aed846f1f 100644
--- a/configs/orangepi_zero2_defconfig
+++ b/configs/orangepi_zero2_defconfig
@@ -20,6 +20,7 @@ CONFIG_SYS_I2C_SPEED=400000
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_PHY_REALTEK=y
 CONFIG_SUN8I_EMAC=y
+CONFIG_AXP305_POWER=y
 CONFIG_SPI=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/configs/x96_mate_defconfig b/configs/x96_mate_defconfig
index 318951e19c2..e805e0952b3 100644
--- a/configs/x96_mate_defconfig
+++ b/configs/x96_mate_defconfig
@@ -18,6 +18,7 @@ CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
 CONFIG_SYS_I2C_SPEED=400000
+CONFIG_AXP305_POWER=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 2395720c99c..33b8bc1214d 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -56,7 +56,6 @@ choice
 	depends on ARCH_SUNXI
 	default AXP209_POWER if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
 	default AXP221_POWER if MACH_SUN6I || MACH_SUN8I_A23 || MACH_SUN8I_A33 || MACH_SUN8I_R40
-	default AXP305_POWER if MACH_SUN50I_H616
 	default AXP818_POWER if MACH_SUN8I_A83T
 	default SUNXI_NO_PMIC if MACH_SUNXI_H3_H5 || MACH_SUN50I || MACH_SUN8I_V3S
 
-- 
2.35.8

