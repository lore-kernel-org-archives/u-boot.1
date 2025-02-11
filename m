Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76394C0219D
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 10:30:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AFF780AE5;
	Tue, 11 Feb 2025 11:29:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E8C780842; Tue, 11 Feb 2025 11:29:56 +0100 (CET)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch
 [185.125.25.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61A34800CF
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 11:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Ysd420R01zNs;
 Tue, 11 Feb 2025 11:29:54 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Ysd411Ks6zBVs; Tue, 11 Feb 2025 11:29:53 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 11 Feb 2025 11:29:42 +0100
Subject: [PATCH 1/3] rockchip: rk3399: do not generate u-boot.rom anymore
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250211-has_rom-u-boot-rockchip-spi-bin-v1-1-0d77f95b6239@cherry.de>
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

This was only used on RK3399 Gru Chromebooks and their maintainer
(Simon) agreed[1] to its removal on the basis that the generic
u-boot-rockchip-spi.bin is now enough, so let's do that.

At the same time, remove HAS_ROM symbol from the Gru Chromebooks config
since they were used only for that.

[1] https://lore.kernel.org/u-boot/CAFLszTh-SewFod8dEOF3+e-wCE1qFF0CyxxR8CbQwy3BRW3k6w@mail.gmail.com/
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rk3399-u-boot.dtsi       | 35 -----------------------------------
 arch/arm/mach-rockchip/rk3399/Kconfig |  2 --
 2 files changed, 37 deletions(-)

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
index 500cfcd87afd23782bb64d231e337330e12497da..bdfd79458f56d2dfca31462db7a9023dabb156e8 100644
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
2.48.1

