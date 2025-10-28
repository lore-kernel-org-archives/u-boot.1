Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534BFCCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 16:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BFE8394A;
	Tue, 28 Oct 2025 17:57:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D34AB83935; Tue, 28 Oct 2025 17:57:50 +0100 (CET)
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch
 [45.157.188.13])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6DB883948
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 17:57:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cwxQ44t7jzFG4;
 Tue, 28 Oct 2025 17:57:48 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cwxQ40lqkzp4G; Tue, 28 Oct 2025 17:57:48 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 28 Oct 2025 17:57:34 +0100
Subject: [PATCH 1/4] rockchip: px30: use rockchip_stimer_init from
 spl_common.o for TPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-px30-rk3306-common-tpl-v1-1-251aba72de7c@cherry.de>
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

Instead of redefining what is essentially the same code in
secure_timer_init, let's simply use rockchip_stimer_init from
spl_common.o instead.

This increases the size of the TPL by 16B, due to the added check of
STIMER already being enabled. Experimentally, STIMER is not already
enabled when in TPL.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/Makefile         |  2 +-
 arch/arm/mach-rockchip/px30-board-tpl.c | 28 +++-------------------------
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-rockchip/Makefile b/arch/arm/mach-rockchip/Makefile
index ae15a9f8a2d..4c424091585 100644
--- a/arch/arm/mach-rockchip/Makefile
+++ b/arch/arm/mach-rockchip/Makefile
@@ -11,7 +11,7 @@ obj-spl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
 obj-spl-$(CONFIG_SPL_ROCKCHIP_COMMON_BOARD) += spl.o spl-boot-order.o spl_common.o
 obj-tpl-$(CONFIG_ROCKCHIP_BROM_HELPER) += bootrom.o
 obj-tpl-$(CONFIG_TPL_ROCKCHIP_COMMON_BOARD) += tpl.o spl_common.o
-obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o
+obj-tpl-$(CONFIG_ROCKCHIP_PX30) += px30-board-tpl.o spl_common.o
 
 obj-spl-$(CONFIG_ROCKCHIP_RK3036) += rk3036-board-spl.o
 
diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c b/arch/arm/mach-rockchip/px30-board-tpl.c
index f0b3c5f83f4..2a3dcdac845 100644
--- a/arch/arm/mach-rockchip/px30-board-tpl.c
+++ b/arch/arm/mach-rockchip/px30-board-tpl.c
@@ -4,32 +4,9 @@
  */
 
 #include <debug_uart.h>
-#include <dm.h>
-#include <init.h>
-#include <ram.h>
-#include <spl.h>
-#include <asm/io.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/sdram_px30.h>
-
-#define TIMER_LOAD_COUNT0	0x00
-#define TIMER_LOAD_COUNT1	0x04
-#define TIMER_CUR_VALUE0	0x08
-#define TIMER_CUR_VALUE1	0x0c
-#define TIMER_CONTROL_REG	0x10
-
-#define TIMER_EN	0x1
-#define	TIMER_FMODE	(0 << 1)
-#define	TIMER_RMODE	(1 << 1)
-
-void secure_timer_init(void)
-{
-	writel(0, CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
-	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + TIMER_LOAD_COUNT0);
-	writel(0xffffffff, CONFIG_ROCKCHIP_STIMER_BASE + TIMER_LOAD_COUNT1);
-	writel(TIMER_EN | TIMER_FMODE,
-	       CONFIG_ROCKCHIP_STIMER_BASE + TIMER_CONTROL_REG);
-}
+#include <asm/arch-rockchip/timer.h>
 
 void board_init_f(ulong dummy)
 {
@@ -50,7 +27,8 @@ void board_init_f(ulong dummy)
 #endif
 #endif
 
-	secure_timer_init();
+	rockchip_stimer_init();
+
 	ret = sdram_init();
 	if (ret)
 		printascii("sdram_init failed\n");

-- 
2.51.0

