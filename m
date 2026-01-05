Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859B2C79FBC
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 19:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A41A83D62;
	Mon,  5 Jan 2026 20:49:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="xpSTjG99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 889C483E21; Mon,  5 Jan 2026 20:49:31 +0100 (CET)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B433839A8
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 20:49:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
 bh=KMZOdB6AbMmUl0BFlqUPfbjlsR8xHZ8AavHOTjMaFjs=; b=xpSTjG99UPI6SS9RLZkqVUvdKz
 vIcXS5Jl98R7LjnCcpCF2QDQZsUOj81sLk3ApBt8iICDOKGR84H7tqfu7+MXpuCxb/zh9gCUl5TqS
 wGYCFmqwYFRfim9Hn7OVfm8Rj2wx01QfCc/W5TbFQWg24NlyEKScpw/Jwfxk6c3yOqaSH7NswQi1i
 Kge+kp4BZPt0a28MCwfJPm4U8iKZG9UrVa/C9zLFRDDI3SEK//XF3hyn3OeItjew4dhzCVIKxA++O
 UP7zcARAbzjHy8D7y+Hcw00+/olXvm36k3cOSZUFR41pfVjrdbLnxoOtsniUCIzrOBPKMJCQjP6jg
 c7L1nDlA==;
Received: from i53875bd9.versanet.de ([83.135.91.217] helo=phil..)
 by gloria.sntech.de with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <heiko@sntech.de>)
 id 1vcqYA-001AcR-Ui; Mon, 05 Jan 2026 20:47:35 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: sjg@chromium.org,
	philipp.tomsich@vrull.eu,
	kever.yang@rock-chips.com
Cc: heiko@sntech.de,
	trini@konsulko.com,
	u-boot@lists.denx.de
Subject: [PATCH 11/12] rockchip: board: qnap-ts433: Rename the board code to
 not be TS433 specific
Date: Mon,  5 Jan 2026 20:47:22 +0100
Message-ID: <20260105194723.2928608-12-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260105194723.2928608-1-heiko@sntech.de>
References: <20260105194723.2928608-1-heiko@sntech.de>
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

We can do support at least 2 devices now, so rename the code-side to a
TSx33 form to not read as specific to the TS433 anymore.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-rockchip/rk3568/Kconfig           | 17 +++++++++--------
 .../qnap/{ts433_rk3568 => tsx33_rk356x}/Kconfig |  6 +++---
 .../{ts433_rk3568 => tsx33_rk356x}/MAINTAINERS  |  6 +++---
 .../{ts433_rk3568 => tsx33_rk356x}/Makefile     |  0
 .../qnap/{ts433_rk3568 => tsx33_rk356x}/board.c |  0
 configs/qnap-ts433-rk3568_defconfig             |  2 +-
 .../configs/{ts433_rk3568.h => tsx33_rk356x.h}  |  0
 7 files changed, 16 insertions(+), 15 deletions(-)
 rename board/qnap/{ts433_rk3568 => tsx33_rk356x}/Kconfig (52%)
 rename board/qnap/{ts433_rk3568 => tsx33_rk356x}/MAINTAINERS (68%)
 rename board/qnap/{ts433_rk3568 => tsx33_rk356x}/Makefile (100%)
 rename board/qnap/{ts433_rk3568 => tsx33_rk356x}/board.c (100%)
 rename include/configs/{ts433_rk3568.h => tsx33_rk356x.h} (100%)

diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
index 16e14ee4fa7..725c008795d 100644
--- a/arch/arm/mach-rockchip/rk3568/Kconfig
+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
@@ -31,18 +31,19 @@ config TARGET_POWKIDDY_X55_RK3566
 	help
 	  Powkiddy X55 handheld gaming console with an RK3566 SoC.
 
-config TARGET_QNAP_TS433_RK3568
-	bool "QNAP-TS433"
+config TARGET_QNAP_TSX33_RK356X
+	bool "QNAP-TSx33"
 	help
-	  Qnap TS433 4-bay NAS with a RK3568 SoC.
+	  Qnap TSx33 1-to-4-bay NAS with a RK3566/RK3568 SoC.
 
 	  It provides the following featureset:
-	   * 4GB LPDDR4
+	   * 2-4GB LPDDR4
 	   * 4GB eMMC
-	   * 2 SATA ports connected to two RK3568's SATA controllers
-	   * 2 SATA ports connected to a JMicron JMB58x AHCI SATA controller
+	   * 1-2 SATA ports connected to two RK3568's SATA controllers
+	   * On TS433 2 SATA ports connected to a JMicron JMB58x AHCI SATA
+	     controller
 	   * 1 1G network controller
-	   * 1 2.5G Realtek RTL8125 network controller
+	   * On TS433 1 2.5G Realtek RTL8125 network controller
 
 config TARGET_QUARTZ64_RK3566
 	bool "Pine64 Quartz64"
@@ -76,7 +77,7 @@ source "board/hardkernel/odroid_m1/Kconfig"
 source "board/hardkernel/odroid_m1s/Kconfig"
 source "board/pine64/quartz64_rk3566/Kconfig"
 source "board/powkiddy/x55/Kconfig"
-source "board/qnap/ts433_rk3568/Kconfig"
+source "board/qnap/tsx33_rk356x/Kconfig"
 source "board/radxa/zero3-rk3566/Kconfig"
 source "board/xunlong/orangepi-3b-rk3566/Kconfig"
 
diff --git a/board/qnap/ts433_rk3568/Kconfig b/board/qnap/tsx33_rk356x/Kconfig
similarity index 52%
rename from board/qnap/ts433_rk3568/Kconfig
rename to board/qnap/tsx33_rk356x/Kconfig
index c5f9db849f2..2f64b9be062 100644
--- a/board/qnap/ts433_rk3568/Kconfig
+++ b/board/qnap/tsx33_rk356x/Kconfig
@@ -1,12 +1,12 @@
-if TARGET_QNAP_TS433_RK3568
+if TARGET_QNAP_TSX33_RK356X
 
 config SYS_BOARD
-	default "ts433_rk3568"
+	default "tsx33_rk356x"
 
 config SYS_VENDOR
 	default "qnap"
 
 config SYS_CONFIG_NAME
-	default "ts433_rk3568"
+	default "tsx33_rk356x"
 
 endif
diff --git a/board/qnap/ts433_rk3568/MAINTAINERS b/board/qnap/tsx33_rk356x/MAINTAINERS
similarity index 68%
rename from board/qnap/ts433_rk3568/MAINTAINERS
rename to board/qnap/tsx33_rk356x/MAINTAINERS
index 02ce7ff383c..b91274c7b43 100644
--- a/board/qnap/ts433_rk3568/MAINTAINERS
+++ b/board/qnap/tsx33_rk356x/MAINTAINERS
@@ -1,8 +1,8 @@
-QNAP-TS433
+QNAP-TSX33
 M:	Heiko Stuebner <heiko@sntech.de>
 S:	Maintained
-F:	board/qnap/ts433_rk3568/
+F:	board/qnap/tsx33_rk356x/
 F:	doc/board/qnap/
-F:	include/configs/qnap_ts433.h
+F:	include/configs/qnap_tsx33.h
 F:	configs/qnap-ts433-rk3568_defconfig
 F:	arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi
diff --git a/board/qnap/ts433_rk3568/Makefile b/board/qnap/tsx33_rk356x/Makefile
similarity index 100%
rename from board/qnap/ts433_rk3568/Makefile
rename to board/qnap/tsx33_rk356x/Makefile
diff --git a/board/qnap/ts433_rk3568/board.c b/board/qnap/tsx33_rk356x/board.c
similarity index 100%
rename from board/qnap/ts433_rk3568/board.c
rename to board/qnap/tsx33_rk356x/board.c
diff --git a/configs/qnap-ts433-rk3568_defconfig b/configs/qnap-ts433-rk3568_defconfig
index dfb240ed70f..475488534cd 100644
--- a/configs/qnap-ts433-rk3568_defconfig
+++ b/configs/qnap-ts433-rk3568_defconfig
@@ -6,7 +6,7 @@ CONFIG_ARCH_ROCKCHIP=y
 CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-qnap-ts433"
 CONFIG_ROCKCHIP_RK3568=y
 CONFIG_SPL_SERIAL=y
-CONFIG_TARGET_QNAP_TS433_RK3568=y
+CONFIG_TARGET_QNAP_TSX33_RK356X=y
 CONFIG_SYS_LOAD_ADDR=0xc00800
 CONFIG_DEBUG_UART_BASE=0xFE660000
 CONFIG_DEBUG_UART_CLOCK=24000000
diff --git a/include/configs/ts433_rk3568.h b/include/configs/tsx33_rk356x.h
similarity index 100%
rename from include/configs/ts433_rk3568.h
rename to include/configs/tsx33_rk356x.h
-- 
2.47.2

