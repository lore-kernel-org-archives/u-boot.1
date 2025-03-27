Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A896C36013
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 21:21:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A3F806FC;
	Thu, 27 Mar 2025 22:21:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4369805C8; Thu, 27 Mar 2025 22:21:36 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id A8C18805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 22:21:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 111571762;
 Thu, 27 Mar 2025 14:21:38 -0700 (PDT)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com
 [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FF123F63F;
 Thu, 27 Mar 2025 14:21:32 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH] sunxi: h616: defconfigs: enable eMMC
Date: Thu, 27 Mar 2025 21:21:02 +0000
Message-ID: <20250327212102.26893-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.3
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

Now that eMMC is working properly on H616 devices, it became apparent
that some boards were missing the right defconfig bits to enable eMMC
access.

Add the eMMC device number to the Tanix TX1 and the X96 Mate defconfig,
also the eMMC boot option to the TX1. Oddly enough the X96 Mate had
just this bit already.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 configs/tanix_tx1_defconfig | 2 ++
 configs/x96_mate_defconfig  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/configs/tanix_tx1_defconfig b/configs/tanix_tx1_defconfig
index 28cf9513c30..00e34dc5ad9 100644
--- a/configs/tanix_tx1_defconfig
+++ b/configs/tanix_tx1_defconfig
@@ -14,11 +14,13 @@ CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_LPDDR3=y
 CONFIG_R_I2C_ENABLE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
 CONFIG_SYS_I2C_SPEED=400000
+CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_AXP313_POWER=y
 CONFIG_AXP_DCDC3_VOLT=1200
 CONFIG_USB_EHCI_HCD=y
diff --git a/configs/x96_mate_defconfig b/configs/x96_mate_defconfig
index bd9b611d6f5..c0628370df9 100644
--- a/configs/x96_mate_defconfig
+++ b/configs/x96_mate_defconfig
@@ -11,6 +11,7 @@ CONFIG_DRAM_SUNXI_TPR11=0xffffdddd
 CONFIG_DRAM_SUNXI_TPR12=0xfedf7557
 CONFIG_MACH_SUN50I_H616=y
 CONFIG_SUNXI_DRAM_H616_DDR3_1333=y
+CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_R_I2C_ENABLE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
-- 
2.46.3

