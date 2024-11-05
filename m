Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC11DD2B950
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 16:02:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86DFE891DD;
	Tue,  5 Nov 2024 17:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="ZhDYDBTO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E97D5891DE; Tue,  5 Nov 2024 17:01:42 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99ABF891DD
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 17:01:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730822490; bh=locM08Isb6Nio+/YwhwxoPq1ObwmZKSekOBx9bwgTrQ=;
 b=ZhDYDBTO8hiB0eiAXsbkEsF9pfudIcezqIKQmVQA6anZjXhSrbEqCUdEa+OTx+vAlplPb/L2u
 SmuXKQi8YUlO7c0ECb/luqeoWQP7NiMKMApKCO0IIHSbWTxruuUOhaTGpR0gO7n0dlWzOfqNCUv
 EW66DHs9PZV7FjvUTVxHWBhzb+PSCK7PsBm/cLZ9uzpv/mKvnhpp9luGndxOgmOkgIglSdprRID
 Qd6DS9lbVefj+ApD5KNWZagX+ELTrLi8C5ZOU8oMr+uJJ0JwSwGcotbXiB4Q/CbLyniyvw22o/x
 SXxtCSPBZ0yWjywpOdgdVeMKMV9yEcsyhAGDOvN1CO9w==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: u-boot@lists.denx.de
Subject: [PATCH 08/13] rockchip: rk3288-tinker: Use common bss and stack
 addresses
Date: Tue,  5 Nov 2024 16:00:31 +0000
Message-ID: <20241105160054.1373319-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105160054.1373319-1-jonas@kwiboo.se>
References: <20241105160054.1373319-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 672a415aff3e144e4725e13b
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

Migrate to use common bss, stack and malloc heap size and addresses to
unify memory use in TPL, SPL and pre-reloc.

Ensure SYS_MALLOC_F_LEN and TPL variant stay at 0x2000 and is unaffected
on other boards not changed to use common malloc heap size.

ENV_OFFSET is using the default value of 0x3f8000 and is also dropped.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Typical malloc() usage on one of my Tinker Board:

TPL malloc() before relocation used 0x834 bytes (2 KB)

SPL malloc() before relocation used 0x10a4 bytes (4 KB)
SPL malloc() used 0x140 bytes (0 KB)

Pre-reloc malloc() used 0xf20 bytes (3 KB)
---
 arch/arm/mach-rockchip/rk3288/Kconfig |  6 +++++-
 configs/tinker-rk3288_defconfig       | 10 ----------
 configs/tinker-s-rk3288_defconfig     | 10 ----------
 3 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3288/Kconfig b/arch/arm/mach-rockchip/rk3288/Kconfig
index 69a5614b449a..672d634f7fb5 100644
--- a/arch/arm/mach-rockchip/rk3288/Kconfig
+++ b/arch/arm/mach-rockchip/rk3288/Kconfig
@@ -132,6 +132,7 @@ config TARGET_ROCK2
 config TARGET_TINKER_RK3288
 	bool "Tinker-RK3288"
         select BOARD_LATE_INIT
+	select ROCKCHIP_COMMON_STACK_ADDR
 	select TPL
 	help
 	  Tinker is a RK3288-based development board with 2 USB ports, HDMI,
@@ -160,7 +161,7 @@ config SYS_SOC
 	default "rk3288"
 
 config SYS_MALLOC_F_LEN
-	default 0x2000
+	default 0x2000 if !SPL_SHARES_INIT_SP_ADDR
 
 config SPL_DRIVERS_MISC
 	default y
@@ -177,6 +178,9 @@ config SPL_SERIAL
 config TPL_STACK
         default 0xff718000
 
+config TPL_SYS_MALLOC_F_LEN
+	default 0x2000
+
 config TPL_TEXT_BASE
 	default 0xff704000
 
diff --git a/configs/tinker-rk3288_defconfig b/configs/tinker-rk3288_defconfig
index 0c2fd573b67b..0f3d47e1a4fc 100644
--- a/configs/tinker-rk3288_defconfig
+++ b/configs/tinker-rk3288_defconfig
@@ -5,19 +5,11 @@ CONFIG_SYS_ARCH_TIMER=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
-CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3288-tinker"
 CONFIG_DM_RESET=y
-CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_TINKER_RK3288=y
-CONFIG_SPL_STACK_R_ADDR=0x80000
-CONFIG_SPL_STACK=0xff718000
-CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SPL_SIZE_LIMIT=0x4b000
@@ -31,8 +23,6 @@ CONFIG_SILENT_CONSOLE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
-CONFIG_SPL_NO_BSS_LIMIT=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
diff --git a/configs/tinker-s-rk3288_defconfig b/configs/tinker-s-rk3288_defconfig
index 2269d04ee644..a013571b2575 100644
--- a/configs/tinker-s-rk3288_defconfig
+++ b/configs/tinker-s-rk3288_defconfig
@@ -4,20 +4,12 @@ CONFIG_TPL_SKIP_LOWLEVEL_INIT_ONLY=y
 CONFIG_SYS_ARCH_TIMER=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x01000000
-CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_DEFAULT_DEVICE_TREE="rk3288-tinker-s"
 CONFIG_DM_RESET=y
-CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_TINKER_RK3288=y
-CONFIG_SPL_STACK_R_ADDR=0x800000
-CONFIG_SPL_STACK=0xff718000
-CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x300000
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SPL_SIZE_LIMIT=0x4b000
@@ -31,8 +23,6 @@ CONFIG_SILENT_CONSOLE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_MISC_INIT_R=y
 CONFIG_SPL_PAD_TO=0x7f8000
-CONFIG_SPL_NO_BSS_LIMIT=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
-- 
2.46.2

