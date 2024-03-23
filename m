Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F4DCC54E58
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EFC688011;
	Sat, 23 Mar 2024 19:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dCwpveAO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E034787DC7; Sat, 23 Mar 2024 19:07:39 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B63D87E6A
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:07:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id D6FFACE03F6;
 Sat, 23 Mar 2024 18:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EADC433F1;
 Sat, 23 Mar 2024 18:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711217250;
 bh=yhyi60S65KcKdsDaXxdcljJ82pqC8wEHEGn54IC79QQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dCwpveAOeGCusCLCNLxUdOb2aEr3CUU5y46xJdO6Quf+FCdMAA9N6bag2YZfauLXI
 E3CenXpn42v9nNv/muxN9SYxYKYb87W6JFJ7Bovj/rQfBmdDxOgHlo0vgAtpFsf3Ya
 JezdGhD8HtrTVWKbCIMwov8ROWj6Yo6z2d/2W7MtXAbwirkhHqzom77qmnuQ+33ibS
 UjpoFjzwx6GSUJxRiguOHkEXp8jw97a/JcMfGuFaXHMDxcuT8wZklKm9Atnv6V2Mzg
 HUoUsvlkriwsYxQHs62UCzcy97/bpmDjP25GhcQLfbA8N+RpQFMnjiB5cZ3PVvC4Xl
 ygwC3B2izJDXQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v2 11/18] arm: mvebu: system-controller: Add
 support for SYSRESET
Date: Sat, 23 Mar 2024 19:07:04 +0100
Message-ID: <20240323180711.5498-12-kabel@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240323180711.5498-1-kabel@kernel.org>
References: <20240323180711.5498-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add driver model support for sysreset via mvebu system controller. This is
currently only available for U-Boot proper.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm/mach-mvebu/Kconfig             | 18 +++++-
 arch/arm/mach-mvebu/Makefile            |  2 +-
 arch/arm/mach-mvebu/cpu.c               |  2 +
 arch/arm/mach-mvebu/system-controller.c | 74 +++++++++++++++++++++++--
 4 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 623432a60e..f15d3cc5ed 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -19,6 +19,7 @@ config ARMADA_32BIT
 	select SPL_SYS_NO_VECTOR_TABLE if SPL
 	select ARCH_VERY_EARLY_INIT
 	select ARMADA_32BIT_SYSCON_RESET if DM_RESET && PCI_MVEBU
+	select ARMADA_32BIT_SYSCON_SYSRESET if SYSRESET
 
 # ARMv7 SoCs...
 config ARMADA_375
@@ -457,16 +458,29 @@ config SF_DEFAULT_MODE
 	default 0x0
 	depends on MVEBU_SPL_BOOT_DEVICE_SPI
 
+config ARMADA_32BIT_SYSCON
+	bool
+	depends on ARMADA_32BIT
+	select REGMAP
+	select SYSCON
+
 config ARMADA_32BIT_SYSCON_RESET
 	bool "Support Armada XP/375/38x/39x reset controller"
 	depends on ARMADA_32BIT
 	depends on DM_RESET
-	select REGMAP
-	select SYSCON
+	select ARMADA_32BIT_SYSCON
 	help
 	  Build support for Armada XP/375/38x/39x reset controller. This is
 	  needed for PCIe support.
 
+config ARMADA_32BIT_SYSCON_SYSRESET
+	bool "Support Armada XP/375/38x/39x sysreset via driver model"
+	depends on ARMADA_32BIT
+	depends on SYSRESET
+	select ARMADA_32BIT_SYSCON
+	help
+	  Build support for Armada XP/375/38x/39x system reset via driver model.
+
 source "board/solidrun/clearfog/Kconfig"
 source "board/kobol/helios4/Kconfig"
 
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index d44ca3a0df..329c2e4915 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_ARMADA_38X) += ../../../drivers/ddr/marvell/a38x/xor.o
 obj-$(CONFIG_ARMADA_XP) += ../../../drivers/ddr/marvell/axp/xor.o
 obj-$(CONFIG_ARMADA_MSYS) += ../../../drivers/ddr/marvell/axp/xor.o
 
-obj-$(CONFIG_ARMADA_32BIT_SYSCON_RESET) += system-controller.o
+obj-$(CONFIG_ARMADA_32BIT_SYSCON) += system-controller.o
 
 ifdef CONFIG_ARMADA_38X
 obj-$(CONFIG_MVEBU_EFUSE) += efuse.o
diff --git a/arch/arm/mach-mvebu/cpu.c b/arch/arm/mach-mvebu/cpu.c
index 8e0de93538..7c62a5dbb6 100644
--- a/arch/arm/mach-mvebu/cpu.c
+++ b/arch/arm/mach-mvebu/cpu.c
@@ -52,6 +52,7 @@ void lowlevel_init(void)
 	 */
 }
 
+#if defined(CONFIG_SPL_BUILD) || !defined(CONFIG_ARMADA_32BIT_SYSCON_SYSRESET)
 void reset_cpu(void)
 {
 	struct mvebu_system_registers *reg =
@@ -62,6 +63,7 @@ void reset_cpu(void)
 	while (1)
 		;
 }
+#endif
 
 u32 get_boot_device(void)
 {
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index c5c05922f2..b5f8afb96d 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -10,11 +10,24 @@
 #include <regmap.h>
 #include <reset-uclass.h>
 #include <syscon.h>
+#include <sysreset.h>
 #include <asm/io.h>
 
-#define MVEBU_SOC_CONTROL_1_REG 0x4
+#define MVEBU_SOC_CONTROL_1_REG		0x4
 
-#define MVEBU_PCIE_ID 0
+#if defined(CONFIG_ARMADA_375)
+# define MVEBU_RSTOUTN_MASK_REG		0x54
+# define MVEBU_SYS_SOFT_RST_REG		0x58
+#else
+# define MVEBU_RSTOUTN_MASK_REG		0x60
+# define MVEBU_SYS_SOFT_RST_REG		0x64
+#endif
+
+#define MVEBU_GLOBAL_SOFT_RST_BIT	BIT(0)
+
+#define MVEBU_PCIE_ID			0
+
+#if IS_ENABLED(CONFIG_ARMADA_32BIT_SYSCON_RESET)
 
 static int mvebu_reset_of_xlate(struct reset_ctl *rst,
 				struct ofnode_phandle_args *args)
@@ -90,11 +103,64 @@ U_BOOT_DRIVER(mvebu_reset) = {
 	.ops = &mvebu_reset_ops,
 };
 
+#endif /* IS_ENABLED(CONFIG_ARMADA_32BIT_SYSCON_RESET) */
+
+#if IS_ENABLED(CONFIG_ARMADA_32BIT_SYSCON_SYSRESET)
+
+static int mvebu_sysreset_request(struct udevice *dev, enum sysreset_t type)
+{
+	struct regmap *regmap = syscon_get_regmap(dev->parent);
+	uint bit;
+
+	if (type != SYSRESET_COLD)
+		return -EPROTONOSUPPORT;
+
+	bit = MVEBU_GLOBAL_SOFT_RST_BIT;
+
+	regmap_update_bits(regmap, MVEBU_RSTOUTN_MASK_REG, bit, bit);
+	regmap_update_bits(regmap, MVEBU_SYS_SOFT_RST_REG, bit, bit);
+
+	while (1)
+		;
+
+	return 0;
+}
+
+static struct sysreset_ops mvebu_sysreset_ops = {
+	.request = mvebu_sysreset_request,
+};
+
+U_BOOT_DRIVER(mvebu_sysreset) = {
+	.name = "mvebu-sysreset",
+	.id = UCLASS_SYSRESET,
+	.ops = &mvebu_sysreset_ops,
+};
+
+#endif /* IS_ENABLED(CONFIG_ARMADA_32BIT_SYSCON_SYSRESET) */
+
 static int mvebu_syscon_bind(struct udevice *dev)
 {
+	int ret = 0;
+
 	/* bind also mvebu-reset, with the same ofnode */
-	return device_bind_driver_to_node(dev, "mvebu-reset", "mvebu-reset",
-					  dev_ofnode(dev), NULL);
+	if (IS_ENABLED(CONFIG_ARMADA_32BIT_SYSCON_RESET)) {
+		ret = device_bind_driver_to_node(dev, "mvebu-reset",
+						 "mvebu-reset", dev_ofnode(dev),
+						 NULL);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* bind also mvebu-sysreset, with the same ofnode */
+	if (IS_ENABLED(CONFIG_ARMADA_32BIT_SYSCON_SYSRESET)) {
+		ret = device_bind_driver_to_node(dev, "mvebu-sysreset",
+						 "mvebu-sysreset",
+						 dev_ofnode(dev), NULL);
+		if (ret < 0)
+			return ret;
+	}
+
+	return ret;
 }
 
 static const struct udevice_id mvebu_syscon_of_match[] = {
-- 
2.43.2

