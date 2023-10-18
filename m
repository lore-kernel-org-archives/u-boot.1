Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246C2CDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 15:50:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6313486FDB;
	Wed, 18 Oct 2023 17:50:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C24686FBA; Wed, 18 Oct 2023 17:50:24 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 15DCB86FBE
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 17:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A2E541007;
 Wed, 18 Oct 2023 08:51:02 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.101.43])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 335DE3F64C;
 Wed, 18 Oct 2023 08:50:20 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 SASANO Takayoshi <uaa@mx5.nisiq.net>,
 Mikhail Kalashnikov <iuncuim@gmail.com>,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 1/3] sunxi: board: simplify early PMIC setup conditions
Date: Wed, 18 Oct 2023 16:50:12 +0100
Message-Id: <20231018155014.383566-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018155014.383566-1-andre.przywara@arm.com>
References: <20231018155014.383566-1-andre.przywara@arm.com>
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

So far we have a convoluted #ifdef mesh that guards the early AXP PMIC
setup in board.c. That combination of &&, || and negations is very hard
to read, maintain and especially to extend.

Fortunately we have those same conditions already modelled in the
Kconfig file, so they are actually redundant. On top of that the real
reason we have those preprocessor guards in the first place is about the
symbols that are *conditionally* defined: without #ifdefs the build
would break because of them being undefined for many boards.

To simplify this, just change the guards to actually look at the symbols
needed, so CONFIG_AXP_xxx_VOLT instead of CONFIG_AXPyyy_POWER.
This drastically improves the readability of this code, and makes adding
PMIC support a pure Kconfig matter.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 board/sunxi/board.c   | 32 ++++++++++++++------------------
 drivers/power/Kconfig |  2 +-
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index ebaa9431984..65d79a02c25 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -597,50 +597,46 @@ void sunxi_board_init(void)
 		}
 	}
 
-#if defined CONFIG_AXP221_POWER || defined CONFIG_AXP809_POWER || \
-	defined CONFIG_AXP818_POWER
+#ifdef CONFIG_AXP_DCDC1_VOLT
 	power_failed |= axp_set_dcdc1(CONFIG_AXP_DCDC1_VOLT);
+	power_failed |= axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
 #endif
-#if !defined(CONFIG_AXP305_POWER)
+#ifdef CONFIG_AXP_DCDC2_VOLT
 	power_failed |= axp_set_dcdc2(CONFIG_AXP_DCDC2_VOLT);
 	power_failed |= axp_set_dcdc3(CONFIG_AXP_DCDC3_VOLT);
 #endif
-#if !defined(CONFIG_AXP209_POWER) && !defined(CONFIG_AXP818_POWER)
+#ifdef CONFIG_AXP_DCDC4_VOLT
 	power_failed |= axp_set_dcdc4(CONFIG_AXP_DCDC4_VOLT);
 #endif
-#if defined CONFIG_AXP221_POWER || defined CONFIG_AXP809_POWER || \
-	defined CONFIG_AXP818_POWER
-	power_failed |= axp_set_dcdc5(CONFIG_AXP_DCDC5_VOLT);
-#endif
 
-#if defined CONFIG_AXP221_POWER || defined CONFIG_AXP809_POWER || \
-	defined CONFIG_AXP818_POWER
+#ifdef CONFIG_AXP_ALDO1_VOLT
 	power_failed |= axp_set_aldo1(CONFIG_AXP_ALDO1_VOLT);
 #endif
-#if !defined(CONFIG_AXP305_POWER)
+#ifdef CONFIG_AXP_ALDO2_VOLT
 	power_failed |= axp_set_aldo2(CONFIG_AXP_ALDO2_VOLT);
 #endif
-#if !defined(CONFIG_AXP152_POWER) && !defined(CONFIG_AXP305_POWER)
+#ifdef CONFIG_AXP_ALDO3_VOLT
 	power_failed |= axp_set_aldo3(CONFIG_AXP_ALDO3_VOLT);
 #endif
-#ifdef CONFIG_AXP209_POWER
+#ifdef CONFIG_AXP_ALDO4_VOLT
 	power_failed |= axp_set_aldo4(CONFIG_AXP_ALDO4_VOLT);
 #endif
 
-#if defined(CONFIG_AXP221_POWER) || defined(CONFIG_AXP809_POWER) || \
-	defined(CONFIG_AXP818_POWER)
+#ifdef CONFIG_AXP_DLDO1_VOLT
 	power_failed |= axp_set_dldo(1, CONFIG_AXP_DLDO1_VOLT);
 	power_failed |= axp_set_dldo(2, CONFIG_AXP_DLDO2_VOLT);
-#if !defined CONFIG_AXP809_POWER
+#endif
+#ifdef CONFIG_AXP_DLDO3_VOLT
 	power_failed |= axp_set_dldo(3, CONFIG_AXP_DLDO3_VOLT);
 	power_failed |= axp_set_dldo(4, CONFIG_AXP_DLDO4_VOLT);
 #endif
+#ifdef CONFIG_AXP_ELDO1_VOLT
 	power_failed |= axp_set_eldo(1, CONFIG_AXP_ELDO1_VOLT);
 	power_failed |= axp_set_eldo(2, CONFIG_AXP_ELDO2_VOLT);
 	power_failed |= axp_set_eldo(3, CONFIG_AXP_ELDO3_VOLT);
 #endif
 
-#ifdef CONFIG_AXP818_POWER
+#ifdef CONFIG_AXP_FLDO1_VOLT
 	power_failed |= axp_set_fldo(1, CONFIG_AXP_FLDO1_VOLT);
 	power_failed |= axp_set_fldo(2, CONFIG_AXP_FLDO2_VOLT);
 	power_failed |= axp_set_fldo(3, CONFIG_AXP_FLDO3_VOLT);
@@ -649,7 +645,7 @@ void sunxi_board_init(void)
 #if defined CONFIG_AXP809_POWER || defined CONFIG_AXP818_POWER
 	power_failed |= axp_set_sw(IS_ENABLED(CONFIG_AXP_SW_ON));
 #endif
-#endif
+#endif	/* CONFIG_AXPxxx_POWER */
 	printf("DRAM:");
 	gd->ram_size = sunxi_dram_init();
 	printf(" %d MiB\n", (int)(gd->ram_size >> 20));
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 7f3b990d231..83cb31c937a 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -180,7 +180,7 @@ config AXP_DCDC3_VOLT
 
 config AXP_DCDC4_VOLT
 	int "axp pmic dcdc4 voltage"
-	depends on AXP152_POWER || AXP221_POWER || AXP809_POWER || AXP818_POWER || AXP305_POWER
+	depends on AXP152_POWER || AXP221_POWER || AXP809_POWER || AXP305_POWER
 	default 1250 if AXP152_POWER
 	default 1200 if MACH_SUN6I
 	default 0 if MACH_SUN8I
-- 
2.25.1

