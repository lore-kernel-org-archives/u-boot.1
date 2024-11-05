Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0D4D3E773
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 21:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7792D891D2;
	Tue,  5 Nov 2024 22:52:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="QKkjqunX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 305C388E43; Tue,  5 Nov 2024 22:52:35 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B55AB88E43
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 22:52:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dc50=SB=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1730843548; bh=O0G6HOZX//hM+c9KSwa2eKVvH0IbvqUhALa8YapkRrg=;
 b=QKkjqunX1LgqWn656qXZO3zsu51+niRi7Rt1A8l//1Oiwf2CziZoNnRVBwa6MIBJ9h9UWA/lJ
 w6P9Ne5yM4UEZZcUhiCVpzEUkTaHenkmZrBJwo31/kaKjb/97q53tKeqH2uWMuS5txSLrr60wCZ
 MumlAWdR4dUayykzRw1vRVCtAFK6uG67cGXISa01TihjQgfeF65ZxGk4po8x8hawZFFe5pdz/mW
 691lkOBp1U9rkQhsib+3ErS20c17nCDPbow7u0+SdgXunfv1TI3ir3uo3+80uL9qI9Pc6njzEWC
 6PKGiQFF2SW9ZrGETijA6lpkntXKaNVmzBuXRsm6KH1Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 04/11] rockchip: rk3288-miqi: Use TPL with common bss and
 stack addresses
Date: Tue,  5 Nov 2024 21:51:40 +0000
Message-ID: <20241105215202.1491441-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241105215202.1491441-1-jonas@kwiboo.se>
References: <20241105215202.1491441-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 672a939b059db14dd83d7b0e
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

Migrate to use TPL, common bss, stack and malloc heap size and addresses
to unify memory use in TPL, SPL and pre-reloc.

ENV_OFFSET is using the default value of 0x3f8000 and is also dropped.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3288/Kconfig |  2 ++
 configs/miqi-rk3288_defconfig         | 15 ++-------------
 2 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3288/Kconfig b/arch/arm/mach-rockchip/rk3288/Kconfig
index 672d634f7fb5..ff16d258b4f5 100644
--- a/arch/arm/mach-rockchip/rk3288/Kconfig
+++ b/arch/arm/mach-rockchip/rk3288/Kconfig
@@ -86,6 +86,8 @@ config TARGET_FIREFLY_RK3288
 config TARGET_MIQI_RK3288
 	bool "MiQi-RK3288"
 	select BOARD_LATE_INIT
+	select ROCKCHIP_COMMON_STACK_ADDR
+	select TPL
 	help
 	  MiQi-RK3288 is a RK3288-based development board with 4 USB 2.0
 	  ports, HDMI, micro-SD card, 16 GB eMMC and Gigabit Ethernet. It
diff --git a/configs/miqi-rk3288_defconfig b/configs/miqi-rk3288_defconfig
index 764b4351e94c..2bb8bf2ac060 100644
--- a/configs/miqi-rk3288_defconfig
+++ b/configs/miqi-rk3288_defconfig
@@ -1,24 +1,15 @@
 CONFIG_ARM=y
 CONFIG_SPL_SKIP_LOWLEVEL_INIT_ONLY=y
+CONFIG_TPL_SKIP_LOWLEVEL_INIT_ONLY=y
 CONFIG_SYS_ARCH_TIMER=y
 CONFIG_ARCH_ROCKCHIP=y
-CONFIG_TEXT_BASE=0x00000000
+CONFIG_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
-CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3288-miqi"
-CONFIG_SPL_TEXT_BASE=0xff704000
 CONFIG_DM_RESET=y
-CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
-CONFIG_SPL_ROCKCHIP_BACK_TO_BROM=y
 CONFIG_TARGET_MIQI_RK3288=y
-CONFIG_SPL_STACK_R_ADDR=0x80000
-CONFIG_SPL_STACK=0xff718000
-CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_DEBUG_UART_BASE=0xff690000
@@ -31,8 +22,6 @@ CONFIG_MISC_INIT_R=y
 CONFIG_SILENT_CONSOLE=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_PAD_TO=0x7f8000
-CONFIG_SPL_NO_BSS_LIMIT=y
-# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
-- 
2.46.2

