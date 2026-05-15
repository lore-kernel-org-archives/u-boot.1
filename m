Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10882CD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 23:47:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5904A848A6;
	Sat, 16 May 2026 01:47:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="QI/pa8EE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640608488B; Sat, 16 May 2026 01:46:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id B62C38480B
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 01:46:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBF9635EA;
 Fri, 15 May 2026 16:46:48 -0700 (PDT)
Received: from ryzen.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id
 B4F4D3F85F; Fri, 15 May 2026 16:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778888814; bh=nLDTuVbhTgVT5ndWtc8btISM+g8RvdapSxasLBQYkLs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QI/pa8EEPBGbXhMnwkwgRoKGaFSunbKOLYVzxZp3Hh5RzkxHtaEneAcQiiiXx2Jqn
 xzQ7ggDZ2ru5xGtcgVvGw6lcBB2p8v0JX1Ekm23BNL79RifyBdsL2XOk1dNqATqxJE
 cbxChwSEgiJfhV1nS2B17Smarm+yFjmOT4I7h/Gg=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wens@kernel.org>, Paul Kocialkowski <contact@paulk.fr>,
 linux-sunxi@lists.linux.dev
Subject: [PATCH v2 5/5] sunxi: configs: OrangePi 4A: enable SPI
Date: Sat, 16 May 2026 01:46:01 +0200
Message-ID: <20260515234601.15431-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.46.4
In-Reply-To: <20260515234601.15431-1-andre.przywara@arm.com>
References: <20260515234601.15431-1-andre.przywara@arm.com>
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

The OrangePi 4A board ships with SPI NOR flash, so enable the SPI and
flash drivers, also the SPL version, for SPI booting.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 configs/orangepi_4a_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/orangepi_4a_defconfig b/configs/orangepi_4a_defconfig
index 6a44dd97959..2d36757ba11 100644
--- a/configs/orangepi_4a_defconfig
+++ b/configs/orangepi_4a_defconfig
@@ -16,6 +16,7 @@ CONFIG_DRAM_SUNXI_TPR12=0x3a373233
 CONFIG_MACH_SUN55I_A523=y
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_R_I2C_ENABLE=y
+CONFIG_SPL_SPI_SUNXI=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_SPL_I2C=y
 CONFIG_SPL_SYS_I2C_LEGACY=y
@@ -23,10 +24,13 @@ CONFIG_SYS_I2C_MVTWSI=y
 CONFIG_SYS_I2C_SLAVE=0x7f
 CONFIG_SYS_I2C_SPEED=400000
 CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MTD=y
+CONFIG_SPI_FLASH_XMC=y
 CONFIG_REGULATOR_AXP=y
 CONFIG_AXP717_POWER=y
 CONFIG_AXP_I2C_ADDRESS=0x35
 CONFIG_AXP_DCDC2_VOLT=920
 CONFIG_AXP_DCDC3_VOLT=1160
+CONFIG_SPI=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
-- 
2.46.4

