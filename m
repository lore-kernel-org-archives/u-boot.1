Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFA8C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 00:18:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB87A88CEE;
	Wed, 24 Apr 2024 02:18:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 347EE88CFA; Wed, 24 Apr 2024 02:18:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A6E7F88CEC
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 02:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE3B71042;
 Tue, 23 Apr 2024 17:18:56 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FE2D3F7BD;
 Tue, 23 Apr 2024 17:18:28 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-sunxi@lists.linux.dev,
 Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: [PATCH 2/4] sunxi: a64: Add Remix Mini PC support
Date: Wed, 24 Apr 2024 01:18:06 +0100
Message-Id: <20240424001808.14388-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20240424001808.14388-1-andre.przywara@arm.com>
References: <20240424001808.14388-1-andre.przywara@arm.com>
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

The Remix Mini PC is a "mini computer" using the Allwinner H64 SoC,
which appears to be just a relabelled A64. It was launched in 2015 by
the now defunct company Jide, and shipped with a desktop optimised
version of Android. Its appearance and feature set is close to a
typical TV box.

The devicetree file has been imported from the Linux tree already, so
just add a defconfig and enable the DTB build in the Makefile. The SoC
has the "secure boot" fuse burnt, so we need to generate a TOC0 image
instead of the standard Allwinner eGON image format for the SPL.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/dts/Makefile           |  3 ++-
 configs/remix-mini-pc_defconfig | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 configs/remix-mini-pc_defconfig

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index b1c9c6222e5..127345975ef 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -801,7 +801,8 @@ dtb-$(CONFIG_MACH_SUN50I) += \
 	sun50i-a64-pinephone-1.2.dtb \
 	sun50i-a64-pinetab.dtb \
 	sun50i-a64-sopine-baseboard.dtb \
-	sun50i-a64-teres-i.dtb
+	sun50i-a64-teres-i.dtb \
+	sun50i-h64-remix-mini-pc.dtb
 dtb-$(CONFIG_MACH_SUN9I) += \
 	sun9i-a80-optimus.dtb \
 	sun9i-a80-cubieboard4.dtb \
diff --git a/configs/remix-mini-pc_defconfig b/configs/remix-mini-pc_defconfig
new file mode 100644
index 00000000000..fa427a027f8
--- /dev/null
+++ b/configs/remix-mini-pc_defconfig
@@ -0,0 +1,14 @@
+CONFIG_ARM=y
+CONFIG_ARCH_SUNXI=y
+CONFIG_DEFAULT_DEVICE_TREE="sun50i-h64-remix-mini-pc"
+CONFIG_SPL=y
+CONFIG_MACH_SUN50I=y
+CONFIG_DRAM_CLK=672
+CONFIG_DRAM_ZQ=4013533
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
+CONFIG_SPL_IMAGE_TYPE_SUNXI_TOC0=y
+# CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_CMD_POWEROFF=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
-- 
2.35.8

