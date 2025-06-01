Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CB0BC54FB3
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 17:15:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FD9582B0E;
	Sun,  1 Jun 2025 19:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F2A8829F5; Sun,  1 Jun 2025 17:42:14 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DFDC82103
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 17:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=paulk.fr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=contact@paulk.fr
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id A32E11F00047
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 15:42:11 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 18ECAAC32E7; Sun,  1 Jun 2025 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 04BB0AC32DF;
 Sun,  1 Jun 2025 15:39:59 +0000 (UTC)
From: Paul Kocialkowski <contact@paulk.fr>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Icenowy Zheng <icenowy@aosc.xyz>,
 linux-sunxi@lists.linux.dev, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 4/6] sunxi: pinecube: Enable EMAC and network support
Date: Sun,  1 Jun 2025 17:39:41 +0200
Message-ID: <20250601153943.2690123-5-contact@paulk.fr>
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

The pinecube has an ethernet connector which uses the EMAC and internal
PHY of the chip. Enable it in the config.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 configs/pinecube_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
index ea40d227bd53..2741e7ed9079 100644
--- a/configs/pinecube_defconfig
+++ b/configs/pinecube_defconfig
@@ -7,13 +7,13 @@ CONFIG_DRAM_CLK=504
 CONFIG_DRAM_ODT_EN=y
 # CONFIG_HAS_ARMV7_SECURE_BASE is not set
 CONFIG_SPL_I2C=y
-CONFIG_NO_NET=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
 CONFIG_SYS_I2C_SPEED=400000
 CONFIG_MTD=y
 CONFIG_SPI_FLASH_WINBOND=y
+CONFIG_SUN8I_EMAC=y
 CONFIG_AXP209_POWER=y
 CONFIG_AXP_DCDC2_VOLT=1250
 CONFIG_AXP_DCDC3_VOLT=3300
-- 
2.49.0

