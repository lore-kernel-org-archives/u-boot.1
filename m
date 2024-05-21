Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959EBC25B78
	for <u-boot@archiver.kernel.org>; Tue, 21 May 2024 17:40:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CD198839C;
	Tue, 21 May 2024 19:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0ADC883A7; Tue, 21 May 2024 19:40:11 +0200 (CEST)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [185.125.25.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0F6988373
 for <u-boot@lists.denx.de>; Tue, 21 May 2024 19:40:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VkMCF39Yrz8m6;
 Tue, 21 May 2024 19:40:09 +0200 (CEST)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VkMCD4pXjz6DH; Tue, 21 May 2024 19:40:08 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 21 May 2024 19:39:54 +0200
Subject: [PATCH 01/10] rockchip: px30: default TPL_SYS_MALLOC_F_LEN to
 0x600 on PX30 Kconfig level
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-px30-2024-07-rc-v1-1-62109c84d44f@cherry.de>
References: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
In-Reply-To: <20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: jonas@kwiboo.se, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.13.0
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

This is the kind of setting that typically doesn't need to be changed
between boards based on the same SoC, so let's make it the default in
PX30 Kconfig so we don't have to care about it in the defconfig if we
don't want to.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/px30/Kconfig           | 3 +++
 configs/evb-px30_defconfig                    | 1 -
 configs/firefly-px30_defconfig                | 1 -
 configs/odroid-go2_defconfig                  | 1 -
 configs/px30-core-ctouch2-of10-px30_defconfig | 1 -
 configs/px30-core-ctouch2-px30_defconfig      | 1 -
 configs/px30-core-edimm2.2-px30_defconfig     | 1 -
 configs/ringneck-px30_defconfig               | 1 -
 8 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-rockchip/px30/Kconfig b/arch/arm/mach-rockchip/px30/Kconfig
index 23f8f430c4a..e39472604c3 100644
--- a/arch/arm/mach-rockchip/px30/Kconfig
+++ b/arch/arm/mach-rockchip/px30/Kconfig
@@ -83,6 +83,9 @@ config TPL_TEXT_BASE
 config TPL_STACK
 	default 0xff0e4fff
 
+config TPL_SYS_MALLOC_F_LEN
+	default 0x600
+
 config DEBUG_UART_CHANNEL
 	int "Mux channel to use for debug UART2/UART3"
 	depends on DEBUG_UART_BOARD_INIT
diff --git a/configs/evb-px30_defconfig b/configs/evb-px30_defconfig
index 07c56a45ec0..73a3c6120e0 100644
--- a/configs/evb-px30_defconfig
+++ b/configs/evb-px30_defconfig
@@ -16,7 +16,6 @@ CONFIG_ROCKCHIP_PX30=y
 CONFIG_TARGET_EVB_PX30=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_SPL_STACK=0x400000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/firefly-px30_defconfig b/configs/firefly-px30_defconfig
index e5377dcdf3d..0a14b393667 100644
--- a/configs/firefly-px30_defconfig
+++ b/configs/firefly-px30_defconfig
@@ -17,7 +17,6 @@ CONFIG_TARGET_EVB_PX30=y
 CONFIG_DEBUG_UART_CHANNEL=1
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_SPL_STACK=0x400000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/odroid-go2_defconfig b/configs/odroid-go2_defconfig
index 99d7149a44c..3c1abb83ed9 100644
--- a/configs/odroid-go2_defconfig
+++ b/configs/odroid-go2_defconfig
@@ -19,7 +19,6 @@ CONFIG_TARGET_ODROID_GO2=y
 CONFIG_DEBUG_UART_CHANNEL=1
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_SPL_STACK=0x400000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/px30-core-ctouch2-of10-px30_defconfig b/configs/px30-core-ctouch2-of10-px30_defconfig
index a2801ec7796..87a39e115df 100644
--- a/configs/px30-core-ctouch2-of10-px30_defconfig
+++ b/configs/px30-core-ctouch2-of10-px30_defconfig
@@ -17,7 +17,6 @@ CONFIG_TARGET_PX30_CORE=y
 CONFIG_DEBUG_UART_CHANNEL=1
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_SPL_STACK=0x400000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/px30-core-ctouch2-px30_defconfig b/configs/px30-core-ctouch2-px30_defconfig
index cc33e275742..7162c117beb 100644
--- a/configs/px30-core-ctouch2-px30_defconfig
+++ b/configs/px30-core-ctouch2-px30_defconfig
@@ -17,7 +17,6 @@ CONFIG_TARGET_PX30_CORE=y
 CONFIG_DEBUG_UART_CHANNEL=1
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_SPL_STACK=0x400000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/px30-core-edimm2.2-px30_defconfig b/configs/px30-core-edimm2.2-px30_defconfig
index 99e1b2fc7ae..1182f60358f 100644
--- a/configs/px30-core-edimm2.2-px30_defconfig
+++ b/configs/px30-core-edimm2.2-px30_defconfig
@@ -17,7 +17,6 @@ CONFIG_TARGET_PX30_CORE=y
 CONFIG_DEBUG_UART_CHANNEL=1
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_SPL_STACK=0x400000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defconfig
index 67a44eda684..0df1b8a59ac 100644
--- a/configs/ringneck-px30_defconfig
+++ b/configs/ringneck-px30_defconfig
@@ -17,7 +17,6 @@ CONFIG_ROCKCHIP_PX30=y
 CONFIG_TARGET_RINGNECK_PX30=y
 CONFIG_TPL_LIBGENERIC_SUPPORT=y
 CONFIG_SPL_DRIVERS_MISC=y
-CONFIG_TPL_SYS_MALLOC_F_LEN=0x600
 CONFIG_SPL_STACK_R_ADDR=0x600000
 CONFIG_SPL_STACK=0x400000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y

-- 
2.45.1

