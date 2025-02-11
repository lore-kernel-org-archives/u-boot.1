Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D398C0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 10:30:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA226800B3;
	Tue, 11 Feb 2025 11:29:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2845080BA6; Tue, 11 Feb 2025 11:29:58 +0100 (CET)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [185.125.25.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EDFC803CC
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 11:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ysd426Bypz1Gk;
 Tue, 11 Feb 2025 11:29:54 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Ysd420mKTzF4m; Tue, 11 Feb 2025 11:29:54 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 11 Feb 2025 11:29:43 +0100
Subject: [PATCH 2/3] rockchip: rk3288: do not generate u-boot.rom anymore
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-2-0d77f95b6239@cherry.de>
References: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
In-Reply-To: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-0-0d77f95b6239@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, Jonas Karlman <jonas@kwiboo.se>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This was only used on RK3288 Chromebooks and the EVB.

If it follows the same pattern as for RK3399 Chromebooks where their
maintainer (Simon) agreed[1] to removal of u-boot.rom on the basis that
the generic u-boot-rockchip-spi.bin is now enough, let's do the same for
RK3288 and remove the last Rockchip users of u-boot.rom (and HAS_ROM
symbol).

At the same time, remove HAS_ROM symbol from the RK3288 Chromebooks and
EVB configs since they were used only for that.

SYS_SPI_U_BOOT_OFFS offset in rockchip-u-boot.dtsi for the u-boot-img
node of simple-bin-spi binman image matches the one used in u-boot.rom
except for the EVB.
The EVB doesn't have ROCKCHIP_SPI_IMAGE symbol enabled, so HAS_ROM had
no effect anyway. Even if it had, this would not have been enough
considering that SPL_SPI_LOAD symbol is not set, so U-Boot proper could
not be loaded from SPI even if SPL/TPL does.

[1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rk3288-u-boot.dtsi       | 24 ------------------------
 arch/arm/mach-rockchip/rk3288/Kconfig |  5 -----
 2 files changed, 29 deletions(-)

diff --git a/arch/arm/dts/rk3288-u-boot.dtsi b/arch/arm/dts/rk3288-u-boot.dtsi
index 2205caabc51ec4535bef3ab950d7ff5b421d8016..bb0078588fe819118eb0592e002e1708da7ce806 100644
--- a/arch/arm/dts/rk3288-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-u-boot.dtsi
@@ -46,30 +46,6 @@
 	};
 };
 
-#if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
-&binman {
-	rom {
-		filename = "u-boot.rom";
-		size = <0x400000>;
-		pad-byte = <0xff>;
-
-		mkimage {
-			args = "-n rk3288 -T rkspi";
-			u-boot-spl {
-			};
-		};
-		u-boot-img {
-			offset = <0x20000>;
-		};
-		u-boot {
-			offset = <0x300000>;
-		};
-		fdtmap {
-		};
-	};
-};
-#endif
-
 &bus_intmem {
 	ddr_sram: ddr-sram@1000 {
 		compatible = "rockchip,rk3288-ddr-sram";
diff --git a/arch/arm/mach-rockchip/rk3288/Kconfig b/arch/arm/mach-rockchip/rk3288/Kconfig
index e563bf455e6803809c7d7612bb3aa85372034292..128ee362f8a8af69861030df7b63cf0e5a368956 100644
--- a/arch/arm/mach-rockchip/rk3288/Kconfig
+++ b/arch/arm/mach-rockchip/rk3288/Kconfig
@@ -5,7 +5,6 @@ choice
 
 config TARGET_CHROMEBOOK_JERRY
 	bool "Google/Rockchip Veyron-Jerry Chromebook"
-	select HAS_ROM
 	select BOARD_LATE_INIT
 	select ROCKCHIP_SPI_IMAGE
 	help
@@ -16,7 +15,6 @@ config TARGET_CHROMEBOOK_JERRY
 
 config TARGET_CHROMEBIT_MICKEY
 	bool "Google/Rockchip Veyron-Mickey Chromebit"
-	select HAS_ROM
 	select BOARD_LATE_INIT
 	select ROCKCHIP_SPI_IMAGE
 	help
@@ -28,7 +26,6 @@ config TARGET_CHROMEBIT_MICKEY
 
 config TARGET_CHROMEBOOK_MINNIE
 	bool "Google/Rockchip Veyron-Minnie Chromebook"
-	select HAS_ROM
 	select BOARD_LATE_INIT
 	select ROCKCHIP_SPI_IMAGE
 	help
@@ -41,7 +38,6 @@ config TARGET_CHROMEBOOK_MINNIE
 
 config TARGET_CHROMEBOOK_SPEEDY
 	bool "Google/Rockchip Veyron-Speedy Chromebook"
-	select HAS_ROM
 	select BOARD_LATE_INIT
 	select ROCKCHIP_SPI_IMAGE
 	help
@@ -54,7 +50,6 @@ config TARGET_CHROMEBOOK_SPEEDY
 
 config TARGET_EVB_RK3288
 	bool "Evb-RK3288"
-	select HAS_ROM
 	select BOARD_LATE_INIT
 	select TPL
 	help

-- 
2.48.1

