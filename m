Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5E8C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 14:47:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80CBA82A39;
	Mon,  5 May 2025 16:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F3BF8212B; Mon,  5 May 2025 16:47:34 +0200 (CEST)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B952D829CD
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 16:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zrkrz2yRPzfmC;
 Mon,  5 May 2025 16:47:31 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Zrkry3k5mz5SM; Mon,  5 May 2025 16:47:30 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 05 May 2025 16:47:18 +0200
Subject: [PATCH v3 1/2] rockchip: rk3399: do not generate u-boot.rom
 anymore
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-has_rom-u-boot-rockchip-spi-bin-v3-1-75f23b3bd8d3@cherry.de>
References: <20250505-has_rom-u-boot-rockchip-spi-bin-v3-0-75f23b3bd8d3@cherry.de>
In-Reply-To: <20250505-has_rom-u-boot-rockchip-spi-bin-v3-0-75f23b3bd8d3@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

This was only used on RK3399 Gru Chromebooks and their maintainer
(Simon) agreed[1] to its removal on the basis that the generic
u-boot-rockchip-spi.bin is now enough, so let's do that.

At the same time, remove HAS_ROM symbol from the Gru Chromebooks config
since they were used only for that.

Make sure u-boot-rockchip-spi.bin has the same size of u-boot.rom for
Chromebooks as that seems to be important.

[1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com/

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Tested-by: Simon Glass <sjg@chromium.org>  # chromebook-kevin
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rk3399-gru-u-boot.dtsi   |  4 +++-
 arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
 arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
 3 files changed, 3 insertions(+), 38 deletions(-)

diff --git a/arch/arm/dts/rk3399-gru-u-boot.dtsi b/arch/arm/dts/rk3399-gru-u-boot.dtsi
index 5517176aa4a0bcc11aa292e76be7c4d894a034f7..dfc7be4c621e712cc665e889b9c54d192924827a 100644
--- a/arch/arm/dts/rk3399-gru-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-gru-u-boot.dtsi
@@ -15,11 +15,13 @@
 	};
 };
 
+#if defined(CONFIG_ROCKCHIP_SPI_IMAGE)
 &binman {
-	rom {
+	simple-bin-spi {
 		size = <0x800000>;
 	};
 };
+#endif
 
 &cros_ec {
 	ec-interrupt = <&gpio0 RK_PA1 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/dts/rk3399-u-boot.dtsi b/arch/arm/dts/rk3399-u-boot.dtsi
index 70f35b6c197a8bedf2fc09ec66d2aac8e615aa75..587eef9504eccc7a1ea365b5f8aed24756692dcb 100644
--- a/arch/arm/dts/rk3399-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-u-boot.dtsi
@@ -29,41 +29,6 @@
 	};
 };
 
-#if defined(CONFIG_ROCKCHIP_SPI_IMAGE) && defined(CONFIG_HAS_ROM)
-&binman {
-	multiple-images;
-	rom {
-		filename = "u-boot.rom";
-		size = <0x400000>;
-		pad-byte = <0xff>;
-
-		mkimage {
-			args = "-n rk3399 -T rkspi";
-			multiple-data-files;
-#ifdef CONFIG_ROCKCHIP_EXTERNAL_TPL
-			rockchip-tpl {
-			};
-#elif defined(CONFIG_TPL)
-			u-boot-tpl {
-			};
-#endif
-			u-boot-spl {
-			};
-		};
-		fit {
-			type = "blob";
-			filename = "u-boot.itb";
-			offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
-		};
-		u-boot {
-			offset = <0x300000>;
-		};
-		fdtmap {
-		};
-	};
-};
-#endif /* CONFIG_ROCKCHIP_SPI_IMAGE && CONFIG_HAS_ROM */
-
 &cru {
 	bootph-all;
 };
diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index b2430207ee9d0130b5a0c303a41a7375c7db26fa..5c21b08a5ae226ad545f8492f21ac16fb2fda98d 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -5,7 +5,6 @@ choice
 
 config TARGET_CHROMEBOOK_BOB
 	bool "Asus Flip C101PA Chromebook (RK3399)"
-	select HAS_ROM
 	select ROCKCHIP_SPI_IMAGE
 	help
 	  Bob is a small RK3299-based device similar in apperance to Minnie.
@@ -16,7 +15,6 @@ config TARGET_CHROMEBOOK_BOB
 
 config TARGET_CHROMEBOOK_KEVIN
 	bool "Samsung Chromebook Plus (RK3399)"
-	select HAS_ROM
 	select ROCKCHIP_SPI_IMAGE
 	help
 	  Kevin is a RK3399-based convertible chromebook. It has two USB 3.0

-- 
2.49.0

