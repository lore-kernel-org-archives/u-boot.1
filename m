Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35093C0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 05:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 205D580A55;
	Tue, 11 Feb 2025 06:34:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD8E7800B3; Tue, 11 Feb 2025 06:34:38 +0100 (CET)
Received: from mail.naobsd.org (sakura.naobsd.org [160.16.200.221])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9D05805D7
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 06:34:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=naoki@radxa.com
Received: from secure.fukaumi.org ([10.0.0.2])
 by mail.naobsd.org (8.14.4/8.14.4/Debian-4.1ubuntu1.1) with ESMTP id
 51B5Xk4g024751; Tue, 11 Feb 2025 14:33:52 +0900
From: FUKAUMI Naoki <naoki@radxa.com>
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 jagan@amarulasolutions.com, dsimic@manjaro.org, pbrobinson@gmail.com,
 liujianfeng1994@gmail.com, paulk@sys-base.io, ricardo@pardini.net,
 heiko@sntech.de, macromorgan@hotmail.com, michal.simek@amd.com,
 seb-dev@mail.de, christopher.obbard@linaro.org,
 ilias.apalodimas@linaro.org, marex@denx.de, mkorpershoek@baylibre.com,
 xypron.glpk@gmx.de, jerome.forissier@linaro.org,
 FUKAUMI Naoki <naoki@radxa.com>
Subject: [PATCH 1/7] rockchip: Change memory location of FIT and U-Boot proper
Date: Tue, 11 Feb 2025 05:33:34 +0000
Message-ID: <20250211053340.92919-2-naoki@radxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250211053340.92919-1-naoki@radxa.com>
References: <20250211053340.92919-1-naoki@radxa.com>
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

Place U-Boot at 8MiB in order to place FIT at 2MiB.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
---
 arch/arm/mach-rockchip/Kconfig        | 6 +++---
 arch/arm/mach-rockchip/rk3308/Kconfig | 3 ---
 arch/arm/mach-rockchip/rk3568/Kconfig | 3 ---
 arch/arm/mach-rockchip/rk3588/Kconfig | 3 ---
 arch/arm/mach-rockchip/rv1126/Kconfig | 3 ---
 boot/Kconfig                          | 3 +++
 6 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index cf8f987569f..bc31b43d630 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -665,9 +665,9 @@ config TPL_SYS_MALLOC_F_LEN
 	default 0x4000 if CUSTOM_SYS_INIT_SP_ADDR = 0x03f00000
 
 config TEXT_BASE
-	default 0x60200000 if SPL_TEXT_BASE = 0x60000000
-	default 0x40200000 if SPL_TEXT_BASE = 0x40000000
-	default 0x00200000 if SPL_TEXT_BASE = 0x00000000
+	default 0x60800000 if SPL_TEXT_BASE = 0x60000000
+	default 0x40800000 if SPL_TEXT_BASE = 0x40000000
+	default 0x00800000 if SPL_TEXT_BASE = 0x00000000
 
 config SPL_TEXT_BASE
 	default 0x60000000 if ROCKCHIP_RK3036 || ROCKCHIP_RK3066 || \
diff --git a/arch/arm/mach-rockchip/rk3308/Kconfig b/arch/arm/mach-rockchip/rk3308/Kconfig
index 06572d545f6..b8d25c52542 100644
--- a/arch/arm/mach-rockchip/rk3308/Kconfig
+++ b/arch/arm/mach-rockchip/rk3308/Kconfig
@@ -17,9 +17,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3308"
 
-config TEXT_BASE
-	default 0x00600000
-
 source "board/rockchip/evb_rk3308/Kconfig"
 source "board/firefly/firefly-rk3308/Kconfig"
 
diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
index c589fd58699..a271782fac5 100644
--- a/arch/arm/mach-rockchip/rk3568/Kconfig
+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
@@ -71,9 +71,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3568"
 
-config TEXT_BASE
-	default 0x00a00000
-
 source "board/rockchip/evb_rk3568/Kconfig"
 source "board/anbernic/rgxx3_rk3566/Kconfig"
 source "board/hardkernel/odroid_m1/Kconfig"
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index efd192068ad..1c6a85d0739 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -420,9 +420,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3588"
 
-config TEXT_BASE
-	default 0x00a00000
-
 source "board/armsom/sige7-rk3588/Kconfig"
 source "board/coolpi/genbook_cm5_rk3588/Kconfig"
 source "board/edgeble/neural-compute-module-6/Kconfig"
diff --git a/arch/arm/mach-rockchip/rv1126/Kconfig b/arch/arm/mach-rockchip/rv1126/Kconfig
index 330b7df2312..27ed756870d 100644
--- a/arch/arm/mach-rockchip/rv1126/Kconfig
+++ b/arch/arm/mach-rockchip/rv1126/Kconfig
@@ -61,9 +61,6 @@ config TPL_TEXT_BASE
 config SYS_MALLOC_F_LEN
 	default 0x2000
 
-config TEXT_BASE
-	default 0x600000
-
 source "board/edgeble/neural-compute-module-2/Kconfig"
 source "board/itead/sonoff-ihost/Kconfig"
 
diff --git a/boot/Kconfig b/boot/Kconfig
index 20935a269c6..26a71fc8d3b 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -246,6 +246,9 @@ config SPL_LOAD_FIT_ADDRESS
 	hex "load address of fit image"
 	depends on SPL_LOAD_FIT
 	default 0x44000000 if ARCH_IMX8M
+	default 0x60200000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x60000000
+	default 0x40200000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x40000000
+	default 0x00200000 if ARCH_ROCKCHIP && SPL_TEXT_BASE = 0x00000000
 	default 0x0
 	help
 	  Specify the load address of the fit image that will be loaded
-- 
2.43.0

