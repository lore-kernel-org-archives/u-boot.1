Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18921CD484E
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 21:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 244D58466E;
	Mon, 11 May 2026 23:38:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="i+fqgG3Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE85A84676; Mon, 11 May 2026 23:38:09 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E26B48466E
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 23:38:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E7DC2C3D;
 Mon, 11 May 2026 14:38:01 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 1239A3F85F; Mon, 11 May 2026 14:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778535486; bh=zKVZ1Uq5tRG9JVDHJ0m8JodzcEX9GicGfsuneK0h/tY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i+fqgG3ZuUAnpgRJZBJefTlBSOKOda8Q6y2/0/yWuwEAKupgTqO/QxLgXoBGBtJVn
 iPUnucU9jJHfCclspnAbjRaXdIiXL1ZE8OlS0WO9StR7IikRRA05l/d4/aXVZA6krG
 BL1WWbaokkRMkGJ8Sz7OgBQUrp7K6f+OoMU5Zm6U=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>, Paul Kocialkowski <contact@paulk.fr>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 4/5] sunxi: configs: Radxa Cubie A5E: enable SPI
Date: Mon, 11 May 2026 23:37:12 +0200
Message-ID: <20260511213713.15943-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20260511213713.15943-1-andre.przywara@arm.com>
References: <20260511213713.15943-1-andre.przywara@arm.com>
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

The Radxa Cubie A5E ships with SPI NOR flash, so enable the SPI and
flash drivers, also the SPL version, for SPI booting.

Sync the defconfig file with the version from savedefconfig on the way.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 configs/radxa-cubie-a5e_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/radxa-cubie-a5e_defconfig b/configs/radxa-cubie-a5e_defconfig
index 84bc4e3d4a9..2a66d0e0866 100644
--- a/configs/radxa-cubie-a5e_defconfig
+++ b/configs/radxa-cubie-a5e_defconfig
@@ -15,6 +15,7 @@ CONFIG_DRAM_SUNXI_TPR12=0x3533302f
 CONFIG_MACH_SUN55I_A523=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_R_I2C_ENABLE=y
+CONFIG_SPL_SPI_SUNXI=y
 CONFIG_SPL_SUNXI_LED_STATUS=y
 CONFIG_SPL_SUNXI_LED_STATUS_GPIO=356
 # CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH is not set
@@ -25,11 +26,14 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
 CONFIG_SYS_I2C_SPEED=400000
 CONFIG_SUPPORT_EMMC_BOOT=y
-CONFIG_PHY_REALTEK=y
+CONFIG_MTD=y
+CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SUN8I_EMAC=y
+CONFIG_PHY_REALTEK=y
 CONFIG_REGULATOR_AXP=y
 CONFIG_AXP717_POWER=y
 CONFIG_AXP_DCDC2_VOLT=920
 CONFIG_AXP_DCDC3_VOLT=1100
+CONFIG_SPI=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.46.4

