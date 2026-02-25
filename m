Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C7EF357C5
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 07:02:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 459448366F;
	Wed, 25 Feb 2026 08:02:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fAFUio0G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C56BA83DCB; Wed, 25 Feb 2026 08:02:28 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA6F082A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:02:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT03.fritz.box (ip-005-147-080-091.um06.pools.vodafone-ip.de
 [5.147.80.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 283D73FC45; 
 Wed, 25 Feb 2026 07:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1772002946;
 bh=rf77atkwg82ubF6PBF+S89ySVYYepR5k2RAIhItnZ68=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=fAFUio0Go36go6++QRkezZVQeCDrCcfDUfg0YGc2nuWISBs/0VClkG/Ng27jJ5PYS
 Lpx30PQtWm5yLKX0iKtY039Jhafqqoorf77uXQ9lt9OxhtkzS3pFmJ0eRFasTZC1Xj
 IV7LRW4IQapU1PIF21clWFZbDJu8mvpL0/LU2cE00fQs/y0QdtCMk8z29rBZn7tstP
 e/DGKVQtJgUMHIGfbzASIkLfMM/QGDgG417Av+epWyNol2mZvtwzhOQD0Fa1tBAzg5
 rwJmVNrCKV0JWz4MrfWco4Bx5gQ3WvDrosfPc+3NUrhIv3qobgYOYZOUrkrijipDNO
 3wWhn2JJzecPOWHhDiXNYem0+3tAlWtX48TcPKEcRFmK2T8n6ZiRkw9D1RNXmp10xL
 peaHaVIpI1lejOgnOcZZGRtJjvl6GDXRrojX7kcPLbKs4iHZXUR3V655d2Na5586EC
 aeDJN4f4Isv6jdppeK8s7T4YX1K0VLr09l90Hu82rIcTTPDb8DMepdhTlmFEqIp2Dj
 llt4wkmQVJc0LwCS2O5Xv0O2+BTdGgeN/nePjTUJIAxtz8FLouzlZoE8Ookt4Wkme+
 Wo4BLpxeebf2DOUbdaIcxyDVVG8f9+q+yubPjueGpNb5E+EAt4Ep4+ioLGXowk/Y1G
 O6BkI273PQUBbQb2MpMvkoJU=
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simeon Marijon <simeon.marijon@foss.st.com>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Lionel Debieve <lionel.debieve@foss.st.com>,
 Cheick Traore <cheick.traore@foss.st.com>,
 uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 1/1] arm/mach-stm32: don't select non-existent STM32_RESET
Date: Wed, 25 Feb 2026 08:02:24 +0100
Message-ID: <20260225070224.49099-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.51.0
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

Symbol CONFIG_STM32_RESET does not exist.
Don't select it.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/arm/mach-stm32/Kconfig   | 3 ---
 arch/arm/mach-stm32mp/Kconfig | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index de9d8547e61..1c6de559142 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -10,7 +10,6 @@ config STM32F4
 	select PINCTRL_STM32
 	select RAM
 	select STM32_RCC
-	select STM32_RESET
 	select STM32_SDRAM
 	select STM32_SERIAL
 	select STM32_TIMER
@@ -27,7 +26,6 @@ config STM32F7
 	select PINCTRL_STM32
 	select RAM
 	select STM32_RCC
-	select STM32_RESET
 	select STM32_SDRAM
 	select STM32_SERIAL
 	select STM32_TIMER
@@ -47,7 +45,6 @@ config STM32H7
 	select RAM
 	select REGMAP
 	select STM32_RCC
-	select STM32_RESET
 	select STM32_SDRAM
 	select STM32_SERIAL
 	select STM32_TIMER
diff --git a/arch/arm/mach-stm32mp/Kconfig b/arch/arm/mach-stm32mp/Kconfig
index 2716844b259..8ade36e4fbb 100644
--- a/arch/arm/mach-stm32mp/Kconfig
+++ b/arch/arm/mach-stm32mp/Kconfig
@@ -50,7 +50,6 @@ config STM32MP13X
 	select OF_BOARD_SETUP
 	select PINCTRL_STM32
 	select STM32_RCC
-	select STM32_RESET
 	select STM32_SERIAL
 	select SUPPORT_SPL if !TFABOOT
 	select SYS_ARCH_TIMER
@@ -72,7 +71,6 @@ config STM32MP15X
 	select OF_BOARD_SETUP
 	select PINCTRL_STM32
 	select STM32_RCC
-	select STM32_RESET
 	select STM32_SERIAL
 	select SUPPORT_SPL
 	select SYS_ARCH_TIMER
@@ -91,7 +89,6 @@ config STM32MP23X
 	select OF_BOARD
 	select PINCTRL_STM32
 	select STM32_RCC
-	select STM32_RESET
 	select STM32_SERIAL
 	select STM32MP_TAMP_NVMEM
 	select SYS_ARCH_TIMER
@@ -117,7 +114,6 @@ config STM32MP25X
 	select OF_BOARD
 	select PINCTRL_STM32
 	select STM32_RCC
-	select STM32_RESET
 	select STM32_SERIAL
 	select SYS_ARCH_TIMER
 	select TFABOOT
-- 
2.51.0

