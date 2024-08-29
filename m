Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72F7C7EE3A
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 08:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A99288B86;
	Thu, 29 Aug 2024 10:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LNRpKpZA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3D0988B37; Thu, 29 Aug 2024 10:08:58 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2AC388B47
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 10:08:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 026DBAE4D5E;
 Thu, 29 Aug 2024 08:08:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18501C4CEC3;
 Thu, 29 Aug 2024 08:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724918935;
 bh=BMyXYWGlXK0EEP1N7wIA63qlDWCS2I35zMf0NKwSiwE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=LNRpKpZAUFCdWaiBJN5gY+CX5k2rDJnMFs/GB7+Rl8RE0voKAEpM+k5oyKl3n4zNL
 wkAnpZCU4QEltuRh12cKy0V0U1FSqjxt7dE/TOknFwEV9AKhpf+mKw8JZDYMaM7+B7
 6tdfqwKI1XF6AhK4aKZGxSDJjabRi8bRhJ1hYY+UxgZ2Suh+TNpHF/ecE88Wlv3mWj
 lQ/wvg8gzcvnIyBIdrrd3QnPPHieiSGyCz4b9un38+nachxaMu9TgP3UzWdNi5yJUU
 CLl2vHZ+mAcBrEOxhhjAiabQSb1OPITMfEbdjuoTaRG2AAJ9oJDGMw8RxEJsVffIke
 dZegBtFZWZswA==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: Stefan Roese <sr@denx.de>
Cc: u-boot@lists.denx.de,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH u-boot-marvell 2/3] arm: mvebu: turris_omnia: Use the
 i2c_eeprom misc driver for EEPROM reading in U-Boot proper
Date: Thu, 29 Aug 2024 10:08:48 +0200
Message-ID: <20240829080849.20276-3-kabel@kernel.org>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240829080849.20276-1-kabel@kernel.org>
References: <20240829080849.20276-1-kabel@kernel.org>
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

Use the i2c_eeprom miscellaneous driver for reading Turris Omnia EEPROM
in U-Boot proper. Keep using dm_i2c_read() in SPL build, since adding
the i2c_eeprom driver to SPL build increases the image by 1.5 KiB.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 arch/arm/mach-mvebu/Kconfig              | 1 +
 board/CZ.NIC/turris_omnia/turris_omnia.c | 9 +++++++--
 configs/turris_omnia_defconfig           | 1 -
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 4a8328760eb..c1a1a333e6c 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -149,6 +149,7 @@ config TARGET_TURRIS_OMNIA
 	select SPL_SYS_MALLOC_SIMPLE
 	select SYS_I2C_MVTWSI
 	select ATSHA204A
+	select I2C_EEPROM
 	select ARMADA_38X_SUPPORT_OLD_DDR3_TRAINING
 
 config TARGET_TURRIS_MOX
diff --git a/board/CZ.NIC/turris_omnia/turris_omnia.c b/board/CZ.NIC/turris_omnia/turris_omnia.c
index 392df53a6d8..46f20f05c05 100644
--- a/board/CZ.NIC/turris_omnia/turris_omnia.c
+++ b/board/CZ.NIC/turris_omnia/turris_omnia.c
@@ -23,6 +23,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <fdt_support.h>
 #include <hexdump.h>
+#include <i2c_eeprom.h>
 #include <time.h>
 #include <turris-omnia-mcu-interface.h>
 #include <linux/bitops.h>
@@ -473,9 +474,13 @@ static bool omnia_read_eeprom(struct omnia_eeprom *oep)
 	if (!eeprom)
 		return false;
 
-	ret = dm_i2c_read(eeprom, 0, (void *)oep, sizeof(*oep));
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		ret = dm_i2c_read(eeprom, 0, (void *)oep, sizeof(*oep));
+	else
+		ret = i2c_eeprom_read(eeprom, 0, (void *)oep, sizeof(*oep));
+
 	if (ret) {
-		printf("dm_i2c_read failed: %i, cannot read EEPROM\n", ret);
+		printf("cannot read EEPROM: %d\n", ret);
 		return false;
 	}
 
diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index c8756a3a788..93f0bc53f9e 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -92,7 +92,6 @@ CONFIG_SPL_OF_TRANSLATE=y
 CONFIG_AHCI_PCI=y
 CONFIG_AHCI_MVEBU=y
 CONFIG_DM_PCA953X=y
-CONFIG_I2C_EEPROM=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_MV=y
 CONFIG_DM_MTD=y
-- 
2.44.2

