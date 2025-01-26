Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE6AC0218F
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 23:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C35DB80F96;
	Mon, 27 Jan 2025 00:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lVrmeH1X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1ED3180FFD; Mon, 27 Jan 2025 00:49:00 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A2C580FF1
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 00:48:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=ca7d=UT=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1737935335; bh=CJgiry0ubqpMh1uAAAu3UsxH/EbM5he5Rwy5XhbWPgU=;
 b=lVrmeH1XcdYFFLh1FnuI98Pa94RApIImN4GCTc9En21y/Wr0JpLcifc+4aGdwPeru78TVgSaw
 YU/r8qpjgDnFNoEBuMxwRkOBGD1XWyELyxG5ZYoN6lEzzxTBsExP+qVPd3/Ete8/pwY9EZ3AEEh
 vBLJoWaofHsuMJgmBK16ADN/YDRw0O8Tkl3JNRfp7MeB6QgZkomv1aJH7QZFPVChv1ZUT4bfuO/
 LtkzqOWBrmBDSMFcxe9UpOUDLZP4lHBhCuosdmxOBJ5xskMQ8iKUl/m4yU6tMrF3NJkyVCiGhYE
 dzVikb4XbAsQKzqbwPYostUT2EViJALrmnFgWCmo1vxw==
X-Forward-Email-ID: 6796c9e54079df9fc6c0dd61
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Alex Bee <knaerzche@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/5] rockchip: Move imply ROCKCHIP_COMMON_STACK_ADDR under SoC
 Kconfig symbol
Date: Sun, 26 Jan 2025 23:48:28 +0000
Message-ID: <20250126234838.561065-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250126234838.561065-1-jonas@kwiboo.se>
References: <20250126234838.561065-1-jonas@kwiboo.se>
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

The ROCKCHIP_COMMON_STACK_ADDR Kconfig option was originally enabled
in the SoC specific Kconfig files to ease during the initial migration
to use common stack addresses.

All boards for the affected SoCs have been migrated to use common stack
addresses. Migrate to use an imply under the SoC symbol instead of
re-define the symbol in each SoC specific Kconfig file.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/Kconfig        | 6 ++++++
 arch/arm/mach-rockchip/px30/Kconfig   | 3 ---
 arch/arm/mach-rockchip/rk3308/Kconfig | 3 ---
 arch/arm/mach-rockchip/rk3328/Kconfig | 3 ---
 arch/arm/mach-rockchip/rk3399/Kconfig | 3 ---
 arch/arm/mach-rockchip/rk3568/Kconfig | 3 ---
 arch/arm/mach-rockchip/rk3588/Kconfig | 3 ---
 7 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index da20d3233fe3..a71988485825 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -15,6 +15,7 @@ config ROCKCHIP_PX30
 	select TPL_SERIAL
 	select DEBUG_UART_BOARD_INIT
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply TPL_LIBGENERIC_SUPPORT
 	imply ARMV8_CRYPTO
@@ -176,6 +177,7 @@ config ROCKCHIP_RK3308
 	imply OF_UPSTREAM
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_OTP
 	imply SPL_CLK
 	imply SPL_DM_SEQ_ALIAS
@@ -208,6 +210,7 @@ config ROCKCHIP_RK3328
 	imply OF_UPSTREAM
 	imply PRE_CONSOLE_BUFFER
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EFUSE
 	imply ROCKCHIP_SDRAM_COMMON
 	imply SPL_ROCKCHIP_COMMON_BOARD
@@ -286,6 +289,7 @@ config ROCKCHIP_RK3399
 	imply PRE_CONSOLE_BUFFER
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EFUSE
 	imply ROCKCHIP_SDRAM_COMMON
 	imply SPL_DM_SEQ_ALIAS
@@ -335,6 +339,7 @@ config ROCKCHIP_RK3568
 	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_OTP
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
 	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
@@ -368,6 +373,7 @@ config ROCKCHIP_RK3588
 	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_OTP
 	imply SCMI_FIRMWARE
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
index dcf9eb8144b8..2b57b1668942 100644
--- a/arch/arm/mach-rockchip/px30/Kconfig
+++ b/arch/arm/mach-rockchip/px30/Kconfig
@@ -68,9 +68,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "px30"
 
-config ROCKCHIP_COMMON_STACK_ADDR
-	default y
-
 config SYS_MALLOC_F_LEN
 	default 0x400 if !SPL_SHARES_INIT_SP_ADDR
 
diff --git a/arch/arm/mach-rockchip/rk3308/Kconfig b/arch/arm/mach-rockchip/rk3308/Kconfig
index fac966207a92..06572d545f6e 100644
--- a/arch/arm/mach-rockchip/rk3308/Kconfig
+++ b/arch/arm/mach-rockchip/rk3308/Kconfig
@@ -17,9 +17,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3308"
 
-config ROCKCHIP_COMMON_STACK_ADDR
-	default y
-
 config TEXT_BASE
 	default 0x00600000
 
diff --git a/arch/arm/mach-rockchip/rk3328/Kconfig b/arch/arm/mach-rockchip/rk3328/Kconfig
index 70770da5fdf2..ec1dae8d413a 100644
--- a/arch/arm/mach-rockchip/rk3328/Kconfig
+++ b/arch/arm/mach-rockchip/rk3328/Kconfig
@@ -21,9 +21,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3328"
 
-config ROCKCHIP_COMMON_STACK_ADDR
-	default y
-
 config TPL_LDSCRIPT
 	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
 
diff --git a/arch/arm/mach-rockchip/rk3399/Kconfig b/arch/arm/mach-rockchip/rk3399/Kconfig
index 500cfcd87afd..b2430207ee9d 100644
--- a/arch/arm/mach-rockchip/rk3399/Kconfig
+++ b/arch/arm/mach-rockchip/rk3399/Kconfig
@@ -143,9 +143,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3399"
 
-config ROCKCHIP_COMMON_STACK_ADDR
-	default y
-
 config TPL_LDSCRIPT
 	default "arch/arm/mach-rockchip/u-boot-tpl-v8.lds"
 
diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
index ce327ed6f9e0..c589fd586993 100644
--- a/arch/arm/mach-rockchip/rk3568/Kconfig
+++ b/arch/arm/mach-rockchip/rk3568/Kconfig
@@ -71,9 +71,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3568"
 
-config ROCKCHIP_COMMON_STACK_ADDR
-	default y
-
 config TEXT_BASE
 	default 0x00a00000
 
diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index 155b8f00ca2c..efd192068ad1 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -420,9 +420,6 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3588"
 
-config ROCKCHIP_COMMON_STACK_ADDR
-	default y
-
 config TEXT_BASE
 	default 0x00a00000
 
-- 
2.48.1

