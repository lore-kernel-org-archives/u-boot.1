Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7DFC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 17:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A5528388B;
	Tue,  5 Aug 2025 19:50:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B11E7838FD; Tue,  5 Aug 2025 19:50:45 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A20283885
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 19:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id BC5721F0004B
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:50:41 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id D4744B011F7; Tue,  5 Aug 2025 17:50:40 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 62D30B011EA;
 Tue,  5 Aug 2025 17:48:29 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 04/11] power: axp: Add default voltages for V3/S3
Date: Tue,  5 Aug 2025 19:48:20 +0200
Message-ID: <20250805174827.3696191-5-paulk@sys-base.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805174827.3696191-1-paulk@sys-base.io>
References: <20250805174827.3696191-1-paulk@sys-base.io>
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

From: Paul Kocialkowski <contact@paulk.fr>

The default voltages used by V3/S3 boards differs from the usual AXP209
default that are used on older chips.

Correct the default voltages based on the Allwinner reference design
schematics, which match boards found in the wild such as the Pinecube.
Update the affected config.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 configs/pinecube_defconfig | 2 --
 drivers/power/Kconfig      | 8 ++++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
index 7c68fff2ea22..ac3e7fbb4317 100644
--- a/configs/pinecube_defconfig
+++ b/configs/pinecube_defconfig
@@ -15,7 +15,5 @@ CONFIG_SYS_I2C_SPEED=400000
 CONFIG_MTD=y
 CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_AXP209_POWER=y
-CONFIG_AXP_DCDC2_VOLT=1250
-CONFIG_AXP_DCDC3_VOLT=3300
 CONFIG_CONS_INDEX=3
 CONFIG_SPI=y
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index cdb3d712389c..fd143ec5ad75 100644
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

