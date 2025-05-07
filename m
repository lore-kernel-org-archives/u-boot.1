Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C197C3ABBC
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 00:54:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF56E8212F;
	Wed,  7 May 2025 02:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68CC4820EB; Wed,  7 May 2025 02:53:54 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 965F682102
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 02:53:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 292362F;
 Tue,  6 May 2025 17:53:41 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 315EC3F673;
 Tue,  6 May 2025 17:53:50 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
	u-boot@lists.denx.de
Cc: Sunil Mohan Adapa <sunil@medhas.org>,
 Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/2] sunxi: A64: enable AXP drivers
Date: Wed,  7 May 2025 01:53:25 +0100
Message-ID: <20250507005325.15612-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
In-Reply-To: <20250507005325.15612-1-andre.przywara@arm.com>
References: <20250507005325.15612-1-andre.przywara@arm.com>
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

So far the 64-bit SoCs were relying on Trusted-Firmware to do the PMIC
setup, which was quite static: enabling most rails, regardless of
whether they are needed or not.

We have a fully DM compliant AXP regulator driver for a while, so that
U-Boot proper can do its own PMIC setup, based on the actual need
(typically for USB, Ethernet, HDMI).

Enable that driver by default for all A64 boards, along with the RSB
driver.

The goal is to allow dropping the ill-fated regulator setup code from
TF-A, so that this can become smaller, and we only enable rails that are
really needed.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/Kconfig            | 1 +
 arch/arm/mach-sunxi/Kconfig | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fedfdb21457..6b59ff5be32 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1190,6 +1190,7 @@ config ARCH_SUNXI
 	select DM_SPI_FLASH if SPI && MTD
 	select DM_KEYBOARD
 	select DM_SERIAL
+	select DM_PMIC
 	select MMU_PGPROT if ARM64
 	select OF_BOARD_SETUP
 	select OF_CONTROL
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index fce817c9d40..c3718126cec 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -435,6 +435,9 @@ config MACH_SUN50I
 	select FIT
 	select SPL_LOAD_FIT if SPL
 	select SUNXI_A64_TIMER_ERRATUM
+	imply SYS_I2C_SUN8I_RSB
+	imply REGULATOR_AXP
+	imply PMIC_AXP
 
 config MACH_SUN50I_H5
 	bool "sun50i (Allwinner H5)"
-- 
2.46.3

