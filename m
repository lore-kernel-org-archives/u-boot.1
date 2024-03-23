Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C789C54E67
	for <u-boot@archiver.kernel.org>; Sat, 23 Mar 2024 18:09:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3F5F87DCC;
	Sat, 23 Mar 2024 19:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B9Fqcsli";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E08DA87F95; Sat, 23 Mar 2024 19:07:37 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D627887D8D
 for <u-boot@lists.denx.de>; Sat, 23 Mar 2024 19:07:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EDC6960202;
 Sat, 23 Mar 2024 18:07:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E85C433C7;
 Sat, 23 Mar 2024 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1711217247;
 bh=UReIk5emMGdhse7VHBJb6hfMfxvXXsPnxwNSSfVo1DA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B9FqcslilHZhaQkk4u4CzLWslrFvpiQ0kJpjBdHl1a07DgRyLpykJV7T0cmb2IZJb
 wnOr//1mfXuriR5mtacmKORh5zqjsSMEovUdrTyE64T7m5GuJE7QqBk0WEacPhbhk+
 Yx/iG3PxzIC6c4Qe/T13m+18VxDAt1cPbmlNqdf7zJ6MKVFCTiL8Q0f/Licm4wkPgA
 1f7OuYFM3EWN6Va0Juk6IVQOruqmJIOyhvtZYjBAiLuG4EGCJWNis+GE1+WgipIE2r
 QnB4gvHDlVASM3ens/NZlR3Nm65DyZtV2iZs3gqDe1OGyi7qVvbw+n0xhAZunk1wqv
 m3JWSjObqMGtQ==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-mvebu v2 09/18] arm: mvebu: system-controller: Rework
 to use UCLASS_SYSCON
Date: Sat, 23 Mar 2024 19:07:02 +0100
Message-ID: <20240323180711.5498-10-kabel@kernel.org>
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

The system-controller driver for 32-bit Armada is currently registered
as UCLASS_RESET, since it only provides enabling/disabling PCIe ports.

Rework it as UCLASS_SYSCON and bind mvebu-reset as a child device.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm/mach-mvebu/Kconfig             | 11 ++++
 arch/arm/mach-mvebu/Makefile            |  2 +-
 arch/arm/mach-mvebu/system-controller.c | 76 ++++++++++++++-----------
 3 files changed, 54 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 2058c95ca2..62a2bc5958 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -18,6 +18,7 @@ config ARMADA_32BIT
 	select TOOLS_KWBIMAGE if SPL
 	select SPL_SYS_NO_VECTOR_TABLE if SPL
 	select ARCH_VERY_EARLY_INIT
+	select ARMADA_32BIT_SYSCON_RESET if DM_RESET
 
 # ARMv7 SoCs...
 config ARMADA_375
@@ -456,6 +457,16 @@ config SF_DEFAULT_MODE
 	default 0x0
 	depends on MVEBU_SPL_BOOT_DEVICE_SPI
 
+config ARMADA_32BIT_SYSCON_RESET
+	bool "Support Armada XP/375/38x/39x reset controller"
+	depends on ARMADA_32BIT
+	depends on DM_RESET
+	select REGMAP
+	select SYSCON
+	help
+	  Build support for Armada XP/375/38x/39x reset controller. This is
+	  needed for PCIe support.
+
 source "board/solidrun/clearfog/Kconfig"
 source "board/kobol/helios4/Kconfig"
 
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index ef790d97fe..d44ca3a0df 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_ARMADA_38X) += ../../../drivers/ddr/marvell/a38x/xor.o
 obj-$(CONFIG_ARMADA_XP) += ../../../drivers/ddr/marvell/axp/xor.o
 obj-$(CONFIG_ARMADA_MSYS) += ../../../drivers/ddr/marvell/axp/xor.o
 
-obj-$(CONFIG_DM_RESET) += system-controller.o
+obj-$(CONFIG_ARMADA_32BIT_SYSCON_RESET) += system-controller.o
 
 ifdef CONFIG_ARMADA_38X
 obj-$(CONFIG_MVEBU_EFUSE) += efuse.o
diff --git a/arch/arm/mach-mvebu/system-controller.c b/arch/arm/mach-mvebu/system-controller.c
index 7cdde11cbd..c5c05922f2 100644
--- a/arch/arm/mach-mvebu/system-controller.c
+++ b/arch/arm/mach-mvebu/system-controller.c
@@ -1,19 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0+
-// (C) 2021 Pali Rohár <pali@kernel.org>
+/*
+ * Copyright (C) 2021 Pali Rohár <pali@kernel.org>
+ * Copyright (C) 2024 Marek Behún <kabel@kernel.org>
+ */
 
 #include <common.h>
 #include <dm.h>
+#include <dm/lists.h>
+#include <regmap.h>
 #include <reset-uclass.h>
+#include <syscon.h>
 #include <asm/io.h>
 
 #define MVEBU_SOC_CONTROL_1_REG 0x4
 
 #define MVEBU_PCIE_ID 0
 
-struct mvebu_reset_data {
-	void *base;
-};
-
 static int mvebu_reset_of_xlate(struct reset_ctl *rst,
 				struct ofnode_phandle_args *args)
 {
@@ -46,46 +48,33 @@ static int mvebu_reset_free(struct reset_ctl *rst)
 
 static int mvebu_reset_assert(struct reset_ctl *rst)
 {
-	struct mvebu_reset_data *data = dev_get_priv(rst->dev);
+	struct regmap *regmap = syscon_get_regmap(rst->dev->parent);
 
-	clrbits_32(data->base + MVEBU_SOC_CONTROL_1_REG, BIT(rst->data));
-	return 0;
+	return regmap_update_bits(regmap, MVEBU_SOC_CONTROL_1_REG,
+				  BIT(rst->data), 0);
 }
 
 static int mvebu_reset_deassert(struct reset_ctl *rst)
 {
-	struct mvebu_reset_data *data = dev_get_priv(rst->dev);
+	struct regmap *regmap = syscon_get_regmap(rst->dev->parent);
 
-	setbits_32(data->base + MVEBU_SOC_CONTROL_1_REG, BIT(rst->data));
-	return 0;
+	return regmap_update_bits(regmap, MVEBU_SOC_CONTROL_1_REG,
+				  BIT(rst->data), BIT(rst->data));
 }
 
 static int mvebu_reset_status(struct reset_ctl *rst)
 {
-	struct mvebu_reset_data *data = dev_get_priv(rst->dev);
+	struct regmap *regmap = syscon_get_regmap(rst->dev->parent);
+	uint val;
+	int ret;
 
-	return !(readl(data->base + MVEBU_SOC_CONTROL_1_REG) & BIT(rst->data));
-}
-
-static int mvebu_reset_of_to_plat(struct udevice *dev)
-{
-	struct mvebu_reset_data *data = dev_get_priv(dev);
+	ret = regmap_read(regmap, MVEBU_SOC_CONTROL_1_REG, &val);
+	if (ret < 0)
+		return ret;
 
-	data->base = dev_read_addr_ptr(dev);
-	if (!data->base)
-		return -EINVAL;
-
-	return 0;
+	return !(val & BIT(rst->data));
 }
 
-static const struct udevice_id mvebu_reset_of_match[] = {
-	{ .compatible = "marvell,armada-370-xp-system-controller" },
-	{ .compatible = "marvell,armada-375-system-controller" },
-	{ .compatible = "marvell,armada-380-system-controller" },
-	{ .compatible = "marvell,armada-390-system-controller" },
-	{ },
-};
-
 static const struct reset_ops mvebu_reset_ops = {
 	.of_xlate = mvebu_reset_of_xlate,
 	.request = mvebu_reset_request,
@@ -98,8 +87,27 @@ static const struct reset_ops mvebu_reset_ops = {
 U_BOOT_DRIVER(mvebu_reset) = {
 	.name = "mvebu-reset",
 	.id = UCLASS_RESET,
-	.of_match = mvebu_reset_of_match,
-	.of_to_plat = mvebu_reset_of_to_plat,
-	.priv_auto = sizeof(struct mvebu_reset_data),
 	.ops = &mvebu_reset_ops,
 };
+
+static int mvebu_syscon_bind(struct udevice *dev)
+{
+	/* bind also mvebu-reset, with the same ofnode */
+	return device_bind_driver_to_node(dev, "mvebu-reset", "mvebu-reset",
+					  dev_ofnode(dev), NULL);
+}
+
+static const struct udevice_id mvebu_syscon_of_match[] = {
+	{ .compatible = "marvell,armada-370-xp-system-controller" },
+	{ .compatible = "marvell,armada-375-system-controller" },
+	{ .compatible = "marvell,armada-380-system-controller" },
+	{ .compatible = "marvell,armada-390-system-controller" },
+	{ },
+};
+
+U_BOOT_DRIVER(mvebu_syscon) = {
+	.name = "mvebu-system-controller",
+	.id = UCLASS_SYSCON,
+	.of_match = mvebu_syscon_of_match,
+	.bind = mvebu_syscon_bind,
+};
-- 
2.43.2

