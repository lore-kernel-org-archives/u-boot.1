Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD1AC5B549
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 17:14:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B964C82A59;
	Sun,  1 Jun 2025 19:14:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5C8B829F5; Sun,  1 Jun 2025 17:40:57 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0B582103
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 17:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id B86281F00047
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 15:40:54 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 35FD9AC329F; Sun,  1 Jun 2025 15:40:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 607A6AC32AD;
 Sun,  1 Jun 2025 15:39:59 +0000 (UTC)
From: Paul Kocialkowski <contact@paulk.fr>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 linux-sunxi@lists.linux.dev, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 1/6] sunxi: Kconfig: Fix default order for V3s DRAM clock
Date: Sun,  1 Jun 2025 17:39:38 +0200
Message-ID: <20250601153943.2690123-2-contact@paulk.fr>
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

The V3s (using co-packaged DRAM) runs at 360 MHz, which is specified in
the common platform Kconfig file. However the value for MACH_SUN8I will
be picked up instead due to ordering.

Re-order the defaults to have MACH_SUN8I_V3S before MACH_SUN8I and let
it select the correct default. Also update the LicheePi Zero Dock
defconfig to remove the value, which is now correctly selected.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/mach-sunxi/Kconfig     | 2 +-
 configs/LicheePi_Zero_defconfig | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 17179593913e..8b43fd176dc0 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -591,9 +591,9 @@ config DRAM_CLK
 	int "sunxi dram clock speed"
 	default 792 if MACH_SUN9I
 	default 648 if MACH_SUN8I_R40
-	default 312 if MACH_SUN6I || MACH_SUN8I
 	default 360 if MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || \
 		       MACH_SUN8I_V3S
+	default 312 if MACH_SUN6I || MACH_SUN8I
 	default 672 if MACH_SUN50I
 	default 744 if MACH_SUN50I_H6
 	default 720 if MACH_SUN50I_H616
diff --git a/configs/LicheePi_Zero_defconfig b/configs/LicheePi_Zero_defconfig
index c37c49ccbb16..b2cf0a018c7f 100644
--- a/configs/LicheePi_Zero_defconfig
+++ b/configs/LicheePi_Zero_defconfig
@@ -3,6 +3,5 @@ CONFIG_ARCH_SUNXI=y
 CONFIG_DEFAULT_DEVICE_TREE="sun8i-v3s-licheepi-zero"
 CONFIG_SPL=y
 CONFIG_MACH_SUN8I_V3S=y
-CONFIG_DRAM_CLK=360
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_NO_NET=y
-- 
2.49.0

