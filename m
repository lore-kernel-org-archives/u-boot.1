Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D5BFF8864
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 09:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA1F884715;
	Wed, 29 Apr 2026 11:28:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="hnMWm+S+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1C9C84840; Wed, 29 Apr 2026 11:28:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 415E384847
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 11:28:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B7562A68;
 Wed, 29 Apr 2026 02:28:34 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.154])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E5983F62B;
 Wed, 29 Apr 2026 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777454919; bh=RSXuzQ4mLtHUsBQXZ1AIixpv5FpaRIoOOXa3iB3UXw8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hnMWm+S+jKzniqpFloHnoR+loXjv4D21xRAnxk3wiwtEJGjtg3M4bLba+KfjZzMCp
 9uOTSYSGOl5x5Ongzb4BtKcMHKO0wxJIq1zSV1I3USOZsYEyHY5tjjyykFANdGU1ff
 fp73QGr/LuKSNghtm8GugsUrkXjFxcqZxkJvPdrw=
From: Andre Przywara <andre.przywara@arm.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Paul Kocialkowski <paulk@sys-base.io>, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 1/3] sunxi: spl: fix SPL_SUNXI_LED active low configuration
Date: Wed, 29 Apr 2026 11:28:26 +0200
Message-ID: <20260429092828.3076719-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429092828.3076719-1-andre.przywara@arm.com>
References: <20260429092828.3076719-1-andre.przywara@arm.com>
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

The newly introduced Allwinner SPL LED "framework" defined a
SPL_SUNXI_LED_STATUS_STATE Kconfig symbol, that was supposed to denote
the active-low vs. active-high polarity of the LED. However this is
a bool symbol, so it will simply vanish if not defined, and we cannot use
it directly inside a C statement.

Filter the symbol through the IS_ENABLED() macro, which will return 0 if
the symbol is not defined, which is the intended value here.

Since the STATUS_STATE name is a bit confusing, rename it to ACTIVE_HIGH
on the way, because that is its real meaning. Also the LED_STATUS_BIT
name for the GPIO number is similarly a remnant of the old status LED
code, so rename it to LED_STATUS_GPIO as well.

This fixes configuring LEDs with active-low polarity.

Fixes: 256557dd9aae ("sunxi: remove usage of legacy LED API")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/Kconfig | 10 ++++++----
 board/sunxi/board.c         |  4 ++--
 configs/pinephone_defconfig |  3 +--
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index 89f0e77bcdb..07d7ea2b7ad 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1245,15 +1245,17 @@ config SPL_SUNXI_LED_STATUS
 
 if SPL_SUNXI_LED_STATUS
 
-config SPL_SUNXI_LED_STATUS_BIT
+config SPL_SUNXI_LED_STATUS_GPIO
 	int "GPIO number for GPIO status LED"
 	help
 	  GPIO number for the GPIO controlling the GPIO status LED in SPL.
 
-config SPL_SUNXI_LED_STATUS_STATE
-	bool "GPIO status LED initial state is on"
+config SPL_SUNXI_LED_STATUS_ACTIVE_HIGH
+	bool "GPIO status LED is active high"
+	default y
 	help
-	  Whether the initial state of the status LED in SPL must be on or off.
+	  Whether the GPIO of the status LED must be set high or low to turn
+	  the LED on.
 
 endif # SPL_SUNXI_LED_STATUS
 
diff --git a/board/sunxi/board.c b/board/sunxi/board.c
index d7722d1858a..3d1afec7c66 100644
--- a/board/sunxi/board.c
+++ b/board/sunxi/board.c
@@ -563,8 +563,8 @@ static void sunxi_spl_store_dram_size(phys_addr_t dram_size)
 static void status_led_init(void)
 {
 #if CONFIG_IS_ENABLED(SUNXI_LED_STATUS)
-	unsigned int state = CONFIG_SPL_SUNXI_LED_STATUS_STATE;
-	unsigned int gpio = CONFIG_SPL_SUNXI_LED_STATUS_BIT;
+	unsigned int state = IS_ENABLED(CONFIG_SPL_SUNXI_LED_STATUS_ACTIVE_HIGH);
+	unsigned int gpio = CONFIG_SPL_SUNXI_LED_STATUS_GPIO;
 
 	gpio_request(gpio, "gpio_led");
 	gpio_direction_output(gpio, state);
diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
index ed7dbc1852b..3a4f4ec51cf 100644
--- a/configs/pinephone_defconfig
+++ b/configs/pinephone_defconfig
@@ -9,8 +9,7 @@ CONFIG_DRAM_ZQ=3881949
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_PINEPHONE_DT_SELECTION=y
 CONFIG_SPL_SUNXI_LED_STATUS=y
-CONFIG_SPL_SUNXI_LED_STATUS_BIT=114
-CONFIG_SPL_SUNXI_LED_STATUS_STATE=y
+CONFIG_SPL_SUNXI_LED_STATUS_GPIO=114
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_CMD_PSTORE=y
 CONFIG_CMD_PSTORE_MEM_ADDR=0x61000000
-- 
2.43.0

