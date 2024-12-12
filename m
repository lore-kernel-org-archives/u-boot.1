Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E77E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFF99801B0;
	Thu, 12 Dec 2024 23:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="MW5LZxuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 521258022F; Thu, 12 Dec 2024 23:10:30 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0AF980212
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734041425; bh=Qkuj9E/yr0I7yLEnz4lpQeZuA1D4A70PDnSNqA5tu6U=;
 b=MW5LZxuFePA44iSskfxxukJFwI5SqzSFbXlPXPCnMxgxlgM1bEhDeNCPxgdvafXnbu0XPbBUS
 i3UlI/knoxzUGhxSrDdo5pNIOoRpD90zoJvgVplD5S2r2Z9YQO2EPECuoLSch83ltVnQ9nnLWRc
 K5SJzX1znGdyX57mva9eiK5rnzCVgEXq3lNXOt9TdjhQ/jChRVJoz1HK1VU9JPc817g621ThMWm
 5bq5jflvhqQCFXQpJ/Gy3MAkXapt4L4LCP+xaW8svRAoM3zQj3l79x4vKH+BnVOgZjxkrzybVEq
 vtSmGem/xNp1ohEtduXjN/s3tehb6Tt/BpbXaOEDF1vA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 04/11] rockchip: rk3288-firefly: Use common bss and stack
 addresses
Date: Thu, 12 Dec 2024 22:09:37 +0000
Message-ID: <20241212221000.94501-5-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212221000.94501-1-jonas@kwiboo.se>
References: <20241212221000.94501-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b5f50a511ed8f0b3fc83e
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

ENV_OFFSET is using the default value of 0x3f8000 and is also dropped.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3288/Kconfig |  1 +
 configs/firefly-rk3288_defconfig      | 10 ----------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3288/Kconfig b/arch/arm/mach-rockchip/rk3288/Kconfig
index 9cc97bacc41d..e563bf455e68 100644
--- a/arch/arm/mach-rockchip/rk3288/Kconfig
+++ b/arch/arm/mach-rockchip/rk3288/Kconfig
@@ -75,6 +75,7 @@ config TARGET_FENNEC_RK3288
 config TARGET_FIREFLY_RK3288
 	bool "Firefly-RK3288"
 	select BOARD_LATE_INIT
+	select ROCKCHIP_COMMON_STACK_ADDR
 	select TPL
 	help
 	  Firefly is a RK3288-based development board with 2 USB ports,
diff --git a/configs/firefly-rk3288_defconfig b/configs/firefly-rk3288_defconfig
index eed0806b2321..87ed0c0d2aea 100644
--- a/configs/firefly-rk3288_defconfig
+++ b/configs/firefly-rk3288_defconfig
@@ -5,19 +5,11 @@ CONFIG_SYS_ARCH_TIMER=y
 CONFIG_ARCH_ROCKCHIP=y
 CONFIG_TEXT_BASE=0x01000000
 CONFIG_NR_DRAM_BANKS=1
-CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
-CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x100000
 CONFIG_SF_DEFAULT_SPEED=20000000
-CONFIG_ENV_OFFSET=0x3F8000
 CONFIG_DEFAULT_DEVICE_TREE="rk3288-firefly"
 CONFIG_DM_RESET=y
-CONFIG_SYS_MONITOR_LEN=614400
 CONFIG_ROCKCHIP_RK3288=y
 CONFIG_TARGET_FIREFLY_RK3288=y
-CONFIG_SPL_STACK_R_ADDR=0x80000
-CONFIG_SPL_STACK=0xff718000
-CONFIG_SPL_STACK_R=y
-CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x2000
 CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SYS_LOAD_ADDR=0x800800
 CONFIG_SPL_SIZE_LIMIT=0x40000
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
2.47.1

