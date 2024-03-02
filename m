Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B262FC5478C
	for <u-boot@archiver.kernel.org>; Sat,  2 Mar 2024 19:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E32B987EAD;
	Sat,  2 Mar 2024 20:17:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZYKW0siN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE3B87EAD; Sat,  2 Mar 2024 20:17:39 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68AE087D9C
 for <u-boot@lists.denx.de>; Sat,  2 Mar 2024 20:17:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=8beb=KJ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1709407029; bh=atE9kTrR/gDxTONw59JzUQehsQ94LBy4UcKeBrl6fBI=;
 b=ZYKW0siN0oR+WZZ2IlParPcP3lI63WMK1VhO/Jyuo5NFUcCFPV9I13aU/7RDc/aHdygA7gij9
 RBu1qQsEOTfD9HGdeYBGMy6O84atdlHMZVGk8Q8ZtW6N1r258B5dDVOYLZvzqBElZl51DXiuVdo
 fJGCkOzWYiXtTBrpWradQcY0tKhQITtHdDYwISoNrhc+2wFASNkC5p+LrGOCYnM3fu0m/DC6A8a
 H9GoEnhdnmTNq3st+IEEmT7FPHcTzQ1QpqAPRYEZDrM9DCJ7q4oFk3UEN2JpaX0la8r5kEn1rdA
 qMp4dWnqugdWe0s09NgV8brjJd7fcSZy07vIgUg1ISVA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Akash Gajjar <gajjar04akash@gmail.com>
Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>, Christopher
 Obbard <chris.obbard@collabora.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH v3 2/6] rockchip: Use common bss and stack addresses on RK3308
Date: Sat,  2 Mar 2024 19:16:12 +0000
Message-ID: <20240302191629.322562-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302191629.322562-1-jonas@kwiboo.se>
References: <20240302191629.322562-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 65e37b31aae288b7577bf283
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

Currently the following memory layout is typically used on RK3308:
[    0, 256K) - SPL binary
[ 256K,   2M) - TF-A / reserved
[   -X,   4M) - SPL pre-reloc stack (SPL_STACK)
[  -8K,   4M)   - pre-reloc malloc heap (SPL_SYS_MALLOC_F_LEN)
[   4M,  +8K) - SPL bss (SPL_BSS_START_ADDR, SPL_BSS_MAX_SIZE)
[   6M,   +X) - U-Boot proper binary (TEXT_BASE)
[   -X,   8M) - U-Boot proper pre-reloc stack (CUSTOM_SYS_INIT_SP_ADDR)
[  -8K,   8M)   - pre-reloc malloc heap (SYS_MALLOC_F_LEN)
[   -X,  12M) - SPL reloc stack (SPL_STACK_R_ADDR)
[  11M,  12M)   - reloc malloc heap (SPL_STACK_R_MALLOC_SIMPLE_LEN)

SPL can safely load U-Boot proper + FDT to [6M, 8M-8K) with this layout.

Migrate to use common bss, stack and malloc heap size and addresses to
remove this size limitation and extend the malloc heap size being used.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 Kconfig                               |  2 +-
 arch/arm/mach-rockchip/rk3308/Kconfig |  7 +++++--
 configs/evb-rk3308_defconfig          | 13 -------------
 configs/roc-cc-rk3308_defconfig       | 13 -------------
 configs/rock-pi-s-rk3308_defconfig    | 13 -------------
 5 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/Kconfig b/Kconfig
index 5710934000f6..75f9563ce6c6 100644
--- a/Kconfig
+++ b/Kconfig
@@ -265,7 +265,7 @@ config SYS_MALLOC_F_LEN
 	hex "Size of malloc() pool before relocation"
 	depends on SYS_MALLOC_F
 	default 0x400 if M68K || PPC || ROCKCHIP_PX30 || ROCKCHIP_RK3036 || \
-			 ROCKCHIP_RK3308 || ROCKCHIP_RV1108
+			 ROCKCHIP_RV1108
 	default 0x600 if ARCH_ZYNQMP_R5 || ARCH_ZYNQMP
 	default 0x800 if ARCH_ZYNQ || ROCKCHIP_RK3128 || ROCKCHIP_RK3188 || \
 			 ROCKCHIP_RK322X || X86
diff --git a/arch/arm/mach-rockchip/rk3308/Kconfig b/arch/arm/mach-rockchip/rk3308/Kconfig
index 194353e4cd9a..749e9995d91f 100644
--- a/arch/arm/mach-rockchip/rk3308/Kconfig
+++ b/arch/arm/mach-rockchip/rk3308/Kconfig
@@ -17,8 +17,11 @@ config ROCKCHIP_STIMER_BASE
 config SYS_SOC
 	default "rk3308"
 
-config SYS_MALLOC_F_LEN
-	default 0x400
+config ROCKCHIP_COMMON_STACK_ADDR
+	default y
+
+config TEXT_BASE
+	default 0x00600000
 
 config SPL_SERIAL
 	default y
diff --git a/configs/evb-rk3308_defconfig b/configs/evb-rk3308_defconfig
index 2729060d6e91..d57b2f6b8e55 100644
--- a/configs/evb-rk3308_defconfig
+++ b/configs/evb-rk3308_defconfig
@@ -2,19 +2,11 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00600000
-CONFIG_SYS_MALLOC_F_LEN=0x2000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_DEFAULT_DEVICE_TREE="rk3308-evb"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_EVB_RK3308=y
-CONFIG_SPL_STACK_R_ADDR=0xc00000
-CONFIG_SPL_STACK=0x400000
 CONFIG_DEBUG_UART_BASE=0xFF0C0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0xc00800
@@ -28,11 +20,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_PAD_TO=0x7f8000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
-CONFIG_SPL_BSS_MAX_SIZE=0x2000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_STACK_R=y
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_ELF is not set
diff --git a/configs/roc-cc-rk3308_defconfig b/configs/roc-cc-rk3308_defconfig
index 7502da5b1e7a..5e8f51ec01e3 100644
--- a/configs/roc-cc-rk3308_defconfig
+++ b/configs/roc-cc-rk3308_defconfig
@@ -2,19 +2,11 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00600000
-CONFIG_SYS_MALLOC_F_LEN=0x2000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_DEFAULT_DEVICE_TREE="rk3308-roc-cc"
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_ROC_RK3308_CC=y
-CONFIG_SPL_STACK_R_ADDR=0xc00000
-CONFIG_SPL_STACK=0x400000
 CONFIG_DEBUG_UART_BASE=0xFF0C0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 CONFIG_SYS_LOAD_ADDR=0xc00800
@@ -28,11 +20,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_PAD_TO=0x7f8000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
-CONFIG_SPL_BSS_MAX_SIZE=0x2000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_STACK_R=y
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_ELF is not set
diff --git a/configs/rock-pi-s-rk3308_defconfig b/configs/rock-pi-s-rk3308_defconfig
index 9908a4b4f457..1e9cd2c0fc7e 100644
--- a/configs/rock-pi-s-rk3308_defconfig
+++ b/configs/rock-pi-s-rk3308_defconfig
@@ -2,20 +2,12 @@ CONFIG_ARM=y
 CONFIG_SKIP_LOWLEVEL_INIT=y
 CONFIG_COUNTER_FREQUENCY=24000000
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00600000
-CONFIG_SYS_MALLOC_F_LEN=0x2000
-CONFIG_SPL_LIBCOMMON_SUPPORT=y
-CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x800000
 CONFIG_DEFAULT_DEVICE_TREE="rk3308-rock-pi-s"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_DM_RESET=y
 CONFIG_ROCKCHIP_RK3308=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_TARGET_EVB_RK3308=y
-CONFIG_SPL_STACK_R_ADDR=0xc00000
-CONFIG_SPL_STACK=0x400000
 CONFIG_DEBUG_UART_BASE=0xFF0A0000
 CONFIG_DEBUG_UART_CLOCK=24000000
 # CONFIG_DEBUG_UART_BOARD_INIT is not set
@@ -29,11 +21,6 @@ CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_SPL_MAX_SIZE=0x20000
 CONFIG_SPL_PAD_TO=0x7f8000
-CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
-CONFIG_SPL_BSS_START_ADDR=0x400000
-CONFIG_SPL_BSS_MAX_SIZE=0x2000
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-CONFIG_SPL_STACK_R=y
 # CONFIG_CMD_BDI is not set
 # CONFIG_CMD_CONSOLE is not set
 # CONFIG_CMD_ELF is not set
-- 
2.43.0

