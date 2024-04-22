Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7195BC4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 16:42:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF5788889D;
	Mon, 22 Apr 2024 18:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D52F888A7; Mon, 22 Apr 2024 18:42:01 +0200 (CEST)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [45.157.188.14])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18DBC88854
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 18:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VNWHS5rz1z1Dl;
 Mon, 22 Apr 2024 18:41:56 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VNWHS1S7SzlTh; Mon, 22 Apr 2024 18:41:56 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Mon, 22 Apr 2024 18:41:41 +0200
Subject: [PATCH 1/2] rockchip: rk3588: add support for UART2 M1 and M2 in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240422-tiger-v1-1-8816b070d748@theobroma-systems.com>
References: <20240422-tiger-v1-0-8816b070d748@theobroma-systems.com>
In-Reply-To: <20240422-tiger-v1-0-8816b070d748@theobroma-systems.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

UART2 controller is the controller in the reference design for debug
console. The default mux is M0 in that reference design. Until now, all
boards seemed to be using UART2M0 but RK3588 Tiger for example will be
using UART2M2 instead.

Therefore, let's add support for UART2M1 and M2 as possible muxes for
the UART2 controller used as debug console. UART2M1 support was not
tested.

The default value is M0 to match the one used currently by all devices
and the reference design.

Cc: Quentin Schulz <foss+uboot@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 arch/arm/mach-rockchip/rk3588/Kconfig  | 10 ++++++++++
 arch/arm/mach-rockchip/rk3588/rk3588.c | 36 ++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3588/Kconfig b/arch/arm/mach-rockchip/rk3588/Kconfig
index d7e4af31f24..cacdb0459c9 100644
--- a/arch/arm/mach-rockchip/rk3588/Kconfig
+++ b/arch/arm/mach-rockchip/rk3588/Kconfig
@@ -221,6 +221,16 @@ config ROCKCHIP_COMMON_STACK_ADDR
 config TEXT_BASE
 	default 0x00a00000
 
+config DEBUG_UART_CHANNEL
+	int "Mux channel to use for debug UART2"
+	depends on DEBUG_UART_BOARD_INIT
+	default 0
+	range 0 2
+	help
+	  UART2 can use three different set of pins to route the output.
+	  For using the UART for early debugging the route to use needs
+	  to be declared (0, 1 or 2).
+
 source board/edgeble/neural-compute-module-6/Kconfig
 source board/friendlyelec/nanopc-t6-rk3588/Kconfig
 source board/pine64/quartzpro64-rk3588/Kconfig
diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
index eb65dafe3a2..e330ad6a697 100644
--- a/arch/arm/mach-rockchip/rk3588/rk3588.c
+++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
@@ -94,9 +94,32 @@ enum {
 	GPIO0B6_UART2_RX_M0	= 10,
 };
 
+/* GPIO3B_IOMUX_SEL_L */
+enum {
+	GPIO3B1_SHIFT		= 4,
+	GPIO3B1_MASK		= GENMASK(7, 4),
+	GPIO3B1_UART2_TX_M2	= 10,
+
+	GPIO3B2_SHIFT		= 8,
+	GPIO3B2_MASK		= GENMASK(11, 8),
+	GPIO3B2_UART2_RX_M2	= 10,
+};
+
+/* GPIO4D_IOMUX_SEL_L */
+enum {
+	GPIO4D0_SHIFT		= 0,
+	GPIO4D0_MASK		= GENMASK(3, 0),
+	GPIO4D0_UART2_TX_M1	= 10,
+
+	GPIO4D1_SHIFT		= 4,
+	GPIO4D1_MASK		= GENMASK(7, 4),
+	GPIO4D1_UART2_RX_M1	= 10,
+};
+
 void board_debug_uart_init(void)
 {
 	__maybe_unused static struct rk3588_bus_ioc * const bus_ioc = (void *)BUS_IOC_BASE;
+#if (CONFIG_DEBUG_UART_CHANNEL == 0)
 	static struct rk3588_pmu2_ioc * const pmu2_ioc = (void *)PMU2_IOC_BASE;
 
 	/* Refer to BUS_IOC */
@@ -110,6 +133,19 @@ void board_debug_uart_init(void)
 		     GPIO0B6_MASK | GPIO0B5_MASK,
 		     GPIO0B6_UART2_RX_M0 << GPIO0B6_SHIFT |
 		     GPIO0B5_UART2_TX_M0 << GPIO0B5_SHIFT);
+#elif (CONFIG_DEBUG_UART_CHANNEL == 1)
+	/* UART2_M1 Switch iomux */
+	rk_clrsetreg(&bus_ioc->gpio4d_iomux_sel_l,
+		     GPIO4D0_MASK | GPIO4D1_MASK,
+		     GPIO4D0_UART2_TX_M1 << GPIO4D0_UART2_TX_M1 |
+		     GPIO4D1_UART2_RX_M1 << GPIO4D1_SHIFT);
+#else
+	/* UART2_M2 Switch iomux */
+	rk_clrsetreg(&bus_ioc->gpio3b_iomux_sel_l,
+		     GPIO3B1_MASK | GPIO3B2_MASK,
+		     GPIO3B1_UART2_TX_M2 << GPIO3B1_SHIFT |
+		     GPIO3B2_UART2_RX_M2 << GPIO3B2_SHIFT);
+#endif /* CONFIG_DEBUG_UART_CHANNEL */
 }
 
 #ifdef CONFIG_SPL_BUILD

-- 
2.44.0

