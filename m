Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7E4C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 653A580FBA;
	Thu, 20 Feb 2025 22:59:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MTr2+nIo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF99D80077; Thu, 20 Feb 2025 22:59:07 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4164580F5F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 22:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bb8a=VM=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1740088738; bh=rpXcFtu7ew1IiwgsAiqLZaax8E2e8qK+hUQRCXJmS+g=;
 b=MTr2+nIo/AINXX1KxquPmXTl4DLQHHTYjcxTg7sdEiuOD5eW44mE/miBDdYE/JOCCYcTFZdEB
 AEjQtR+DBtfu+wkJyawY/kJVoj4gW4Dsh8Gvdp1JVk6HvnysY8CunrBWgAuY3RFlHh9lNm5IJFb
 SgBzLWRKtRkV27MvbulFOWroyt45Wkv/sADHlddF9Td5gre0jNorw1piY1zlmOHACBlQLPV7SAX
 29Wd/n7emP2ipgBbcFc7G4C55t1a6WokS/7iJAnyeN8/H288E9A44iJV9ynPIuHbRfw3nhMBKvs
 BNz3z2ijXATwMkIudg2BNEMWX4tBaq5hOS7ljru1e5ZQ==
X-Forward-Email-ID: 67b7a5a163718a8557eae13e
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
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
Subject: [PATCH v2 4/6] rockchip: Move imply ROCKCHIP_COMMON_STACK_ADDR under
 SoC Kconfig symbol
Date: Thu, 20 Feb 2025 21:56:58 +0000
Message-ID: <20250220215709.407413-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220215709.407413-1-jonas@kwiboo.se>
References: <20250220215709.407413-1-jonas@kwiboo.se>
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
v2: No change
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
index 6c68b3f6a83e..7d867173fa1d 100644
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
@@ -177,6 +178,7 @@ config ROCKCHIP_RK3308
 	imply OF_UPSTREAM
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_OTP
 	imply SPL_CLK
 	imply SPL_DM_SEQ_ALIAS
@@ -209,6 +211,7 @@ config ROCKCHIP_RK3328
 	imply OF_UPSTREAM
 	imply PRE_CONSOLE_BUFFER
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EFUSE
 	imply ROCKCHIP_SDRAM_COMMON
 	imply SPL_ROCKCHIP_COMMON_BOARD
@@ -287,6 +290,7 @@ config ROCKCHIP_RK3399
 	imply PRE_CONSOLE_BUFFER
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_EFUSE
 	imply ROCKCHIP_SDRAM_COMMON
 	imply SPL_DM_SEQ_ALIAS
@@ -336,6 +340,7 @@ config ROCKCHIP_RK3568
 	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
 	imply RNG_ROCKCHIP
 	imply ROCKCHIP_COMMON_BOARD
+	imply ROCKCHIP_COMMON_STACK_ADDR
 	imply ROCKCHIP_OTP
 	imply SPL_ATF_NO_PLATFORM_PARAM if SPL_ATF
 	imply SPL_MMC_HS200_SUPPORT if SPL_MMC && MMC_HS200_SUPPORT
@@ -369,6 +374,7 @@ config ROCKCHIP_RK3588
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

