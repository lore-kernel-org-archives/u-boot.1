Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110FCC5B549
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 17:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17A1682AAF;
	Sun,  1 Jun 2025 19:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA76A829F5; Sun,  1 Jun 2025 17:41:19 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E46A682103
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 17:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 42B841F0004B
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 15:41:17 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id ADE52AC32E7; Sun,  1 Jun 2025 15:41:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 919A9AC32C9;
 Sun,  1 Jun 2025 15:39:59 +0000 (UTC)
From: Paul Kocialkowski <contact@paulk.fr>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 linux-sunxi@lists.linux.dev, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 2/6] sunxi: Add support for the Lichee Pi Zero with Dock
Date: Sun,  1 Jun 2025 17:39:39 +0200
Message-ID: <20250601153943.2690123-3-contact@paulk.fr>
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

This adds a U-Boot config and device-tree build for the Lichee Pi Zero
with Dock. Compared to the Lichee Pi Zero, it has an ethernet port
(with internal PHY) so the EMAC driver and network support are enabled.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/dts/Makefile                | 3 ++-
 configs/LicheePi_Zero_Dock_defconfig | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 configs/LicheePi_Zero_Dock_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 32b698a7f411..be6867ceae0e 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -650,7 +650,8 @@ dtb-$(CONFIG_MACH_SUN8I_V3S) += \
 	sun8i-s3-elimo-initium.dtb \
 	sun8i-s3-pinecube.dtb \
 	sun8i-v3-sl631-imx179.dtb \
-	sun8i-v3s-licheepi-zero.dtb
+	sun8i-v3s-licheepi-zero.dtb \
+	sun8i-v3s-licheepi-zero-dock.dtb
 dtb-$(CONFIG_MACH_SUN8I_R528) += \
 	sun8i-t113s-mangopi-mq-r-t113.dtb
 dtb-$(CONFIG_MACH_SUN50I_H5) += \
diff --git a/configs/LicheePi_Zero_Dock_defconfig b/configs/LicheePi_Zero_Dock_defconfig
new file mode 100644
index 000000000000..ec172d98b65e
--- /dev/null
+++ b/configs/LicheePi_Zero_Dock_defconfig
@@ -0,0 +1,7 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun8i-v3s-licheepi-zero-dock"
+CONFIG_SPL=y
+CONFIG_MACH_SUN8I_V3S=y
+# CONFIG_HAS_ARMV7_SECURE_BASE is not set
+CONFIG_SUN8I_EMAC=y
-- 
2.49.0

