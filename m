Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51201C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 17:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFAC483923;
	Tue,  5 Aug 2025 19:52:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA6F88392E; Tue,  5 Aug 2025 19:52:37 +0200 (CEST)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC07E83885
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 19:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paulk@sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id A93E31F00036
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 17:52:30 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 3B09BB011F4; Tue,  5 Aug 2025 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [192.168.1.64])
 by laika.paulk.fr (Postfix) with ESMTP id 2D864B011EE;
 Tue,  5 Aug 2025 17:48:30 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 Icenowy Zheng <icenowy@aosc.xyz>, Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH v2 08/11] sunxi: pinecube: Enable EMAC and network support
Date: Tue,  5 Aug 2025 19:48:24 +0200
Message-ID: <20250805174827.3696191-9-paulk@sys-base.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250805174827.3696191-1-paulk@sys-base.io>
References: <20250805174827.3696191-1-paulk@sys-base.io>
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

From: Paul Kocialkowski <contact@paulk.fr>

The pinecube has an ethernet connector which uses the EMAC and internal
PHY of the chip. Enable it in the config.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 configs/pinecube_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/pinecube_defconfig b/configs/pinecube_defconfig
index 2b2fb88c4933..b4aaca346653 100644
--- a/configs/pinecube_defconfig
+++ b/configs/pinecube_defconfig
@@ -7,13 +7,13 @@ CONFIG_DRAM_CLK=504
 CONFIG_DRAM_ODT_EN=y
 CONFIG_I2C0_ENABLE=y
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
 CONFIG_CONS_INDEX=3
 CONFIG_SPI=y
-- 
2.49.0

