Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D60CC5B549
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 17:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E263C82B2F;
	Sun,  1 Jun 2025 19:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 642DF829F5; Sun,  1 Jun 2025 17:42:36 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 719D482103
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 17:42:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id CBE051F0004B
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 15:42:33 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 3FAC1AC32F0; Sun,  1 Jun 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 3B18DAC32E1;
 Sun,  1 Jun 2025 15:40:00 +0000 (UTC)
From: Paul Kocialkowski <contact@paulk.fr>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 linux-sunxi@lists.linux.dev, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 5/6] power: axp: Fixup default voltages for V3/S3
Date: Sun,  1 Jun 2025 17:39:42 +0200
Message-ID: <20250601153943.2690123-6-contact@paulk.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250601153943.2690123-1-contact@paulk.fr>
References: <20250601153943.2690123-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 01 Jun 2025 19:14:22 +0200
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

The default voltages used by V3/S3 boards differs from the usual AXP209
default that are used on older chips.

Correct the default voltages based on the Allwinner reference design
schematics, which match boards found in the wild such as the Pinecube.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 configs/pinecube_defconfig | 3 ---
 drivers/power/Kconfig      | 8 ++++++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
index 2741e7ed9079..8bd14ad90f6d 100644
--- a/configs/pinecube_defconfig
+++ b/configs/pinecube_defconfig
@@ -14,8 +14,5 @@ CONFIG_SYS_I2C_SPEED=400000
 CONFIG_MTD=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SUN8I_EMAC=y
-CONFIG_AXP209_POWER=y
-CONFIG_AXP_DCDC2_VOLT=1250
-CONFIG_AXP_DCDC3_VOLT=3300
 CONFIG_CONS_INDEX=3
 CONFIG_SPI=y
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 08369bf833e4..24b36be4c6cf 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -176,10 +176,11 @@ config AXP_DCDC2_VOLT
 	int "axp pmic dcdc2 voltage"
 	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER || AXP803_POWER
 	default 900 if AXP818_POWER
-	default 1400 if AXP152_POWER || AXP209_POWER
+	default 1400 if AXP152_POWER || (AXP209_POWER && !MACH_SUN8I_V3)
 	default 1000 if AXP313_POWER
 	default 1000 if AXP717_POWER
 	default 1000 if AXP803_POWER
+	default 1250 if MACH_SUN8I_V3
 	default 1200 if MACH_SUN6I
 	default 1100 if MACH_SUN8I
 	default 0 if MACH_SUN9I
@@ -192,6 +193,7 @@ config AXP_DCDC2_VOLT
 	On A80 boards dcdc2 powers the GPU and can be left off.
 	On A83T boards dcdc2 is used for VDD-CPUA(cluster 0) and should be 0.9V.
 	On R40 boards dcdc2 is VDD-CPU and should be 1.1V
+	On V3/S3 boards dcdc2 is VDD-CPU/VDD-SYS and should be 1.25V.
 	On boards using the AXP313 or AXP717 it's often VDD-CPU.
 
 config AXP_DCDC3_VOLT
@@ -199,9 +201,10 @@ config AXP_DCDC3_VOLT
 	depends on AXP152_POWER || AXP209_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP313_POWER || AXP717_POWER
 	default 900 if AXP809_POWER || AXP818_POWER
 	default 1500 if AXP152_POWER
-	default 1250 if AXP209_POWER
+	default 1250 if (AXP209_POWER && !MACH_SUN8I_V3)
 	default 1100 if AXP313_POWER
 	default 1100 if MACH_SUN8I_R40
+	default 3300 if MACH_SUN8I_V3
 	default 1200 if MACH_SUN6I || MACH_SUN8I
 	---help---
 	Set the voltage (mV) to program the axp pmic dcdc3 at, set to 0 to
@@ -213,6 +216,7 @@ config AXP_DCDC3_VOLT
 	On A80 boards dcdc3 is used for VDD-CPUA(cluster 0) and should be 0.9V.
 	On A83T boards dcdc3 is used for VDD-CPUB(cluster 1) and should be 0.9V.
 	On R40 boards dcdc3 is VDD-SYS and VDD-GPU and should be 1.1V.
+	On V3/S3 boards dcdc3 is VCC-IO and should be 3.3V.
 	On boards using the AXP313 or AXP717 it's often VDD-DRAM and should
 	be 1.1V for LPDDR4.
 
-- 
2.49.0

