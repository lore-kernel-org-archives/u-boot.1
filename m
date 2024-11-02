Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD9DE6780F
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 20:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE5F989030;
	Sat,  2 Nov 2024 21:45:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Lfdz/FJy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DC14890B1; Sat,  2 Nov 2024 21:45:34 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D68228901D
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 21:45:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=4e10=R6=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1730580324;
 bh=g+M1tdoRND9xifYJsibdO5aUvTqTE6wMXyWNF+2VxRQ=;
 b=Lfdz/FJyvwKGo64N65qYDfBxvD9+ZmqgXR8OMiq4rjGQM2NsLe4obIzMGdTSOiIObrz7+gtOp
 YwU2qmVYeHFM3aqq5O1MSO2uzT9RS4K+dUX7XephTFAEguV/gmMZ32jNlCFO7FUGOaJ5wRP2UxR
 tAF0Z+q76uDhSJ2F6t5+FTCrcVhqPh8RCJ9opBLePZjtNuPg97K4OL8AV9c/GKO60+0hTu7fsku
 PkgPt6jAjGPIX8AtDhd++0UHyumPO+v1lv3ZAyjtifI146Ywo0laC5Xt4urSY4RhTRci5JHgoZL
 19nGFCC01rK1AOGw47lZ8QyfAUaFD5+ZyZGVuJt0wphw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Jonas Karlman <jonas@kwiboo.se>,
	u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3308: Drop unused rk_board_init()
Date: Sat,  2 Nov 2024 20:45:13 +0000
Message-ID: <20241102204516.3633375-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 67268f62922720f2eae90345
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

Nothing is calling the function rk_board_init() and the io-domain driver
can handle the functions intended purpose based on information from DT.

Cleanup by removing the unused rk_board_init() function and re-sort
included headers.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3308/rk3308.c | 69 +-------------------------
 1 file changed, 1 insertion(+), 68 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
index 03d97e1d7460..6916f1a24441 100644
--- a/arch/arm/mach-rockchip/rk3308/rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
@@ -3,15 +3,12 @@
  *Copyright (c) 2018 Rockchip Electronics Co., Ltd
  */
 #include <init.h>
-#include <malloc.h>
+#include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
 #include <asm/arch-rockchip/grf_rk3308.h>
 #include <asm/arch-rockchip/hardware.h>
-#include <asm/gpio.h>
-#include <debug_uart.h>
 #include <linux/bitops.h>
 
-#include <asm/armv8/mmu.h>
 static struct mm_region rk3308_mem_map[] = {
 	{
 		.virt = 0x0UL,
@@ -38,22 +35,6 @@ struct mm_region *mem_map = rk3308_mem_map;
 #define SGRF_BASE	0xff2b0000
 
 enum {
-	GPIO1C7_SHIFT		= 8,
-	GPIO1C7_MASK		= GENMASK(11, 8),
-	GPIO1C7_GPIO		= 0,
-	GPIO1C7_UART1_RTSN,
-	GPIO1C7_UART2_TX_M0,
-	GPIO1C7_SPI2_MOSI,
-	GPIO1C7_JTAG_TMS,
-
-	GPIO1C6_SHIFT		= 4,
-	GPIO1C6_MASK		= GENMASK(7, 4),
-	GPIO1C6_GPIO		= 0,
-	GPIO1C6_UART1_CTSN,
-	GPIO1C6_UART2_RX_M0,
-	GPIO1C6_SPI2_MISO,
-	GPIO1C6_JTAG_TCLK,
-
 	GPIO4D3_SHIFT           = 6,
 	GPIO4D3_MASK            = GENMASK(7, 6),
 	GPIO4D3_GPIO            = 0,
@@ -116,60 +97,12 @@ enum {
 	GPIO2A2_SEL_SRC_CTRL_SEL_PLUS	= 1,
 };
 
-enum {
-	IOVSEL3_CTRL_SHIFT	= 8,
-	IOVSEL3_CTRL_MASK	= BIT(8),
-	VCCIO3_SEL_BY_GPIO	= 0,
-	VCCIO3_SEL_BY_IOVSEL3,
-
-	IOVSEL3_SHIFT		= 3,
-	IOVSEL3_MASK		= BIT(3),
-	VCCIO3_3V3		= 0,
-	VCCIO3_1V8,
-};
-
-/*
- * The voltage of VCCIO3(which is the voltage domain of emmc/flash/sfc
- * interface) can indicated by GPIO0_A4 or io_vsel3. The SOC defaults
- * use GPIO0_A4 to indicate power supply voltage for VCCIO3 by hardware,
- * then we can switch to io_vsel3 after system power on, and release GPIO0_A4
- * for other usage.
- */
-
-#define GPIO0_A4	4
-
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff490000",
 	[BROM_BOOTSOURCE_SPINOR] = "/spi@ff4c0000/flash@0",
 	[BROM_BOOTSOURCE_SD] = "/mmc@ff480000",
 };
 
-int rk_board_init(void)
-{
-	static struct rk3308_grf * const grf = (void *)GRF_BASE;
-	u32 val;
-	int ret;
-
-	ret = gpio_request(GPIO0_A4, "gpio0_a4");
-	if (ret < 0) {
-		printf("request for gpio0_a4 failed:%d\n", ret);
-		return 0;
-	}
-
-	gpio_direction_input(GPIO0_A4);
-
-	if (gpio_get_value(GPIO0_A4))
-		val = VCCIO3_SEL_BY_IOVSEL3 << IOVSEL3_CTRL_SHIFT |
-		      VCCIO3_1V8 << IOVSEL3_SHIFT;
-	else
-		val = VCCIO3_SEL_BY_IOVSEL3 << IOVSEL3_CTRL_SHIFT |
-		      VCCIO3_3V3 << IOVSEL3_SHIFT;
-	rk_clrsetreg(&grf->soc_con0, IOVSEL3_CTRL_MASK | IOVSEL3_MASK, val);
-
-	gpio_free(GPIO0_A4);
-	return 0;
-}
-
 #ifdef CONFIG_DEBUG_UART_BOARD_INIT
 __weak void board_debug_uart_init(void)
 {
-- 
2.46.2

