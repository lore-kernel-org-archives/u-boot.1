Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066A1E743C8
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 21:58:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F3BC86EC1;
	Thu, 28 Sep 2023 23:56:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 885D486EAD; Thu, 28 Sep 2023 23:56:33 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 58DF886EB5
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 23:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19A3D1007;
 Thu, 28 Sep 2023 14:57:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 32A613F59C;
 Thu, 28 Sep 2023 14:56:29 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Samuel Holland <samuel@sholland.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Icenowy Zheng <uwu@icenowy.me>,
 Maxim Kiselev <bigunclemax@gmail.com>, Sam Edwards <cfsworks@gmail.com>,
 Okhunjon Sobirjonov <okhunjon72@gmail.com>, linux-sunxi@lists.linux.dev,
 andre.przywara@arm.com, andre.przywara@foss.arm.com
Subject: [PATCH v2 15/22] Kconfig: sunxi: prepare for using drivers/ram/sunxi
Date: Thu, 28 Sep 2023 22:54:48 +0100
Message-Id: <20230928215455.28094-16-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20230928215455.28094-1-andre.przywara@arm.com>
References: <20230928215455.28094-1-andre.przywara@arm.com>
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

At the moment all Allwinner DRAM initialisation routines are stored in
arch/arm/mach-sunxi, even though those "drivers" are just a giant
collection of writel's, without any architectural dependency.

The R528/T113-s SoC (with ARM cores) and the D1/D1s Soc (with RISC-V
cores) share the same die, so should share the same DRAM init routines as
well.

To prepare for this, add a new sunxi directory inside drivers/ram, and
add some stub entries to prepare for the addition of the share DRAM code
for those SoCs.

The RISC-V D1(s) SoCs will probably use SPL_DM, so make this entry
depend on that already.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/ram/Kconfig       |  3 ++-
 drivers/ram/sunxi/Kconfig | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 drivers/ram/sunxi/Kconfig

diff --git a/drivers/ram/Kconfig b/drivers/ram/Kconfig
index bf999645774..5b07e920301 100644
--- a/drivers/ram/Kconfig
+++ b/drivers/ram/Kconfig
@@ -109,8 +109,9 @@ config IMXRT_SDRAM
 
 source "drivers/ram/aspeed/Kconfig"
 source "drivers/ram/cadence/Kconfig"
+source "drivers/ram/octeon/Kconfig"
 source "drivers/ram/rockchip/Kconfig"
 source "drivers/ram/sifive/Kconfig"
 source "drivers/ram/stm32mp1/Kconfig"
-source "drivers/ram/octeon/Kconfig"
 source "drivers/ram/starfive/Kconfig"
+source "drivers/ram/sunxi/Kconfig"
diff --git a/drivers/ram/sunxi/Kconfig b/drivers/ram/sunxi/Kconfig
new file mode 100644
index 00000000000..261d7f57409
--- /dev/null
+++ b/drivers/ram/sunxi/Kconfig
@@ -0,0 +1,14 @@
+config DRAM_SUN20I_D1
+	bool "DM DRAM driver support for Allwinner D1"
+	depends on RAM && ARCH_SUNXI
+	default y
+	help
+	  This enables support for DRAM drivers using the driver model
+	  for Allwinner SoCs.
+
+config DRAM_SUN8I_R528
+	bool "DRAM driver support for Allwinner R528/T113s"
+	depends on ARCH_SUNXI
+	default y if MACH_SUN8I_R528
+	help
+	  Select this DRAM controller driver for the R528/T113s SoCs.
-- 
2.35.8

