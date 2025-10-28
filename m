Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EB2CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:58:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1A7A83955;
	Tue, 28 Oct 2025 17:57:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D16483971; Tue, 28 Oct 2025 17:57:52 +0100 (CET)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch
 [84.16.66.169])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B0968394A
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:57:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cwxQ52GhMzDs8;
 Tue, 28 Oct 2025 17:57:49 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cwxQ44cP6zkYf; Tue, 28 Oct 2025 17:57:48 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 28 Oct 2025 17:57:35 +0100
Subject: [PATCH 2/4] rockchip: rk3036: use rockchip_stimer_init from
 spl_common.o
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-px30-rk3306-common-tpl-v1-2-251aba72de7c@cherry.de>
References: <20251028-px30-rk3306-common-tpl-v1-0-251aba72de7c@cherry.de>
In-Reply-To: <20251028-px30-rk3306-common-tpl-v1-0-251aba72de7c@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Paul Kocialkowski <paulk@sys-base.io>, Chen-Yu Tsai <wens@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

The only difference with the implementation in spl_common.c is that we
check whether the timer has already been enabled. Considering this is
running in SPL, the first stage on RK3036, I feel like it's guaranteed
to not be enabled by default. No public TRM though and I don't have
access to an RK3036 device so take this as a guess.

Size of SPL binary increases by 8B for evb-rk3036.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/Makefile           |  2 +-
 arch/arm/mach-rockchip/rk3036-board-spl.c | 21 +--------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index 4c424091585..06fb527b21a 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -13,7 +13,7 @@ obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
 obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
 obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o spl_common.o
 
-obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
+obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o spl_common.o
 
 ifeq ($(CONFIG_XPL_BUILD)$(CONFIG_TPL_BUILD),)
 
diff --git a/arch/arm/mach-rockchip/rk3036-board-spl.c b/arch/arm/mach-rockchip/rk3036-board-spl.c
index 64e100172fa..d69139278a8 100644
--- a/arch/arm/mach-rockchip/rk3036-board-spl.c
+++ b/arch/arm/mach-rockchip/rk3036-board-spl.c
@@ -5,28 +5,9 @@
 
 #include <debug_uart.h>
 #include <init.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/sdram_rk3036.h>
-
-#define TIMER_LOAD_COUNT_L	0x00
-#define TIMER_LOAD_COUNT_H	0x04
-#define TIMER_CONTROL_REG	0x10
-#define TIMER_EN	0x1
-#define	TIMER_FMODE	(0 << 1)
-#define	TIMER_RMODE	(1 << 1)
-
-void rockchip_stimer_init(void)
-{
-	asm volatile("mcr p15, 0, %0, c14, c0, 0"
-		     : : "r"(CONFIG_COUNTER_FREQUENCY));
-
-	writel(0, CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
-	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE);
-	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + 4);
-	writel(TIMER_EN | TIMER_FMODE, CONFIG_ROCKCHIP_STIMER_BASE +
-	       TIMER_CONTROL_REG);
-}
+#include <asm/arch-rockchip/timer.h>
 
 void board_init_f(ulong dummy)
 {

-- 
2.51.0

