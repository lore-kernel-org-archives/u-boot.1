Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DEDCD5BD1
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 22:56:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29954840ED;
	Wed,  3 Jun 2026 00:56:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kMY3jwsZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C4B684837; Wed,  3 Jun 2026 00:56:30 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 550C483EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 00:56:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+me.samcday.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 23B0E601F3;
 Tue,  2 Jun 2026 22:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2E0FC2BCB4;
 Tue,  2 Jun 2026 22:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1780440985;
 bh=1BzYFuOeoymWnlaWsGzDjCX9YW6cLE+7R2AefL4X81s=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=kMY3jwsZdtMIGWsd9VAEs3HiK/iO8zjXFJiFsbij4iwW9OK+fViXndP4NTgeSa1F8
 MMKr7Bi8jdsM8nFjid7OBchsNu86JyFsLyv43Q5Sz1IyHyFI1bz9c8C0NeGOCI62Je
 iJcxAi/qRlvlqhXZ1xeyn3/aBZk99Bas74Ec0gxlWhmdrvC4zUs2zFyW1LjLduTvLE
 L/qutHSClOqNWLm37pTUb5pNbg39ET/x9fo/bwcmiWTTulDGou5nmUwpGTCVm9zMFs
 k79QMtQkfvjCEs1VOwYs1riJaSOa4g7+yhCbIEXRGTkdzFMoMVNPO7ybA7xaTjtLWr
 J27T90InYSHFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id A78F8CD6E5D;
 Tue,  2 Jun 2026 22:56:25 +0000 (UTC)
From: Sam Day via B4 Relay <devnull+me.samcday.com@kernel.org>
Date: Wed, 03 Jun 2026 08:56:21 +1000
Subject: [PATCH] mach-snapdragon: formalize APQ8016 debug UART init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-apq8016-debug-uart-v1-1-1e46b2cd0fe6@samcday.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23MIqYdGvRAez1fbSQyuC8N+Tj
 gMz80LiKJygr16IfEuSbS2g6grcYtfAKHNh0KQNGdJo96MjZXDm6Qp42XgitY6cb1gVAUq4R/b
 y/NNhzPkDDHCsZWQAAAA=
X-Change-ID: 20260602-apq8016-debug-uart-07c0cf4e1060
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Dmitrii Sharshakov <d3dx12.xx@gmail.com>, 
 Brian Sune <briansune@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Daniel Palmer <daniel@0x0f.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Sam Day <me@samcday.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440984; l=5825;
 i=me@samcday.com; s=20240502; h=from:subject:message-id;
 bh=eOlqaNI5vfQ5kyzDO3QgLKmC5+z6GbvHUzd9+0eIS8A=;
 b=13LInEw1Rf9t6cB8MxZH0Lkr2QGXzsIYgwHiOFRp2Oi4lJehHQ4HE3XF9lwUeznfZGFeMJpXx
 0hGllIskD+9DhEbXAhmV+zH2PQezi7gNjl2nlAfJsC3kL0pXzsbx9gV
X-Developer-Key: i=me@samcday.com; a=ed25519;
 pk=bzyS0akxWMqr9+AXzgBRIp28KKpEOs+GjYMc2yf+aeU=
X-Endpoint-Received: by B4 Relay for me@samcday.com/20240502 with auth_id=595
X-Original-From: Sam Day <me@samcday.com>
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
Reply-To: me@samcday.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Sam Day <me@samcday.com>

The dragonboard410c (and likely other SB-off devices) can run U-Boot
early enough in the boot chain such that UART clock isn't started, and
pins aren't configured.

APQ8016 has two UART peripherals, each with its own clock and TLMM pins.

Two new debug-apq8016-uartN.config fragments are provided. Each
configures the appropriate UARTDM aperture. The newly introduced
DEBUG_UART_APQ8016 Kconfig symbol pulls in MSM debug UART, and enables a
board-level debug_uart_init function to start the right clock and mux
the right TX pin.

Signed-off-by: Sam Day <me@samcday.com>
---
 arch/arm/mach-snapdragon/Kconfig              |  9 +++++++
 arch/arm/mach-snapdragon/Makefile             |  1 +
 arch/arm/mach-snapdragon/debug-uart-apq8016.c | 37 +++++++++++++++++++++++++++
 board/qualcomm/debug-apq8016-uart1.config     |  4 +++
 board/qualcomm/debug-apq8016-uart2.config     |  4 +++
 drivers/serial/Kconfig                        |  1 +
 drivers/serial/serial_msm.c                   | 10 --------
 7 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index d3de8693b5a..43e6fd1bc42 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -1,5 +1,14 @@
 if ARCH_SNAPDRAGON
 
+config DEBUG_UART_APQ8016
+	bool "APQ8016 early debug initialization"
+	select CLK_QCOM_APQ8016
+	select CONFIG_DEBUG_UART_MSM
+	select DEBUG_UART_BOARD_INIT
+	help
+	  Ensures BLSP UART clocks+pins are setup. Useful when U-Boot is running from
+	  aboot (such as on the dragonboard410c).
+
 config SYS_SOC
 	default "snapdragon"
 
diff --git a/arch/arm/mach-snapdragon/Makefile b/arch/arm/mach-snapdragon/Makefile
index 343e825c6fd..824bb4d5daf 100644
--- a/arch/arm/mach-snapdragon/Makefile
+++ b/arch/arm/mach-snapdragon/Makefile
@@ -5,3 +5,4 @@
 obj-y += board.o
 obj-$(CONFIG_EFI_HAVE_CAPSULE_SUPPORT) += capsule_update.o
 obj-$(CONFIG_OF_LIVE) += of_fixup.o
+obj-$(CONFIG_DEBUG_UART_APQ8016) += debug-uart-apq8016.o
diff --git a/arch/arm/mach-snapdragon/debug-uart-apq8016.c b/arch/arm/mach-snapdragon/debug-uart-apq8016.c
new file mode 100644
index 00000000000..2de9d99bed5
--- /dev/null
+++ b/arch/arm/mach-snapdragon/debug-uart-apq8016.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * SoC-specific debug UART initialization (clocks/pins) lives here
+ */
+
+#include <asm/io.h>
+#include <dt-bindings/clock/qcom,gcc-msm8916.h>
+
+extern int apq8016_clk_init_uart(phys_addr_t gcc_base, unsigned long id);
+
+#define APQ8016_GCC_BASE		((phys_addr_t)0x01800000)
+
+#define APQ8016_TLMM_BASE		((phys_addr_t)0x01000000)
+#define APQ8016_TLMM_FUNC_BLSP_UART	(2 << 2)
+#define APQ8016_TLMM_DRV_8MA		(3 << 6)
+#define APQ8016_TLMM_GPIO_ENABLE	BIT(9)
+#define APQ8016_GPIO_CFG(gpio)		(APQ8016_TLMM_BASE + (phys_addr_t)(gpio) * 0x1000)
+#define APQ8016_DEBUG_UART_PINCFG	(APQ8016_TLMM_FUNC_BLSP_UART | \
+					 APQ8016_TLMM_DRV_8MA | \
+					 APQ8016_TLMM_GPIO_ENABLE)
+
+void board_debug_uart_init(void)
+{
+	/* infer BLSP clock and TX pin by the configured UART base */
+	switch (CONFIG_VAL(DEBUG_UART_BASE)) {
+	case 0x078af000:
+		apq8016_clk_init_uart(APQ8016_GCC_BASE,
+				      GCC_BLSP1_UART1_APPS_CLK);
+		writel(APQ8016_DEBUG_UART_PINCFG, APQ8016_GPIO_CFG(0));
+		break;
+	case 0x078b0000:
+		apq8016_clk_init_uart(APQ8016_GCC_BASE,
+				      GCC_BLSP1_UART2_APPS_CLK);
+		writel(APQ8016_DEBUG_UART_PINCFG, APQ8016_GPIO_CFG(4));
+		break;
+	}
+}
diff --git a/board/qualcomm/debug-apq8016-uart1.config b/board/qualcomm/debug-apq8016-uart1.config
new file mode 100644
index 00000000000..283fbf20ff8
--- /dev/null
+++ b/board/qualcomm/debug-apq8016-uart1.config
@@ -0,0 +1,4 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x078af000
+CONFIG_DEBUG_UART_APQ8016=y
diff --git a/board/qualcomm/debug-apq8016-uart2.config b/board/qualcomm/debug-apq8016-uart2.config
new file mode 100644
index 00000000000..61e56d4eb5a
--- /dev/null
+++ b/board/qualcomm/debug-apq8016-uart2.config
@@ -0,0 +1,4 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x078b0000
+CONFIG_DEBUG_UART_APQ8016=y
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 5f8b98f0704..698205aa035 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -565,6 +565,7 @@ config DEBUG_UART_CLOCK
 	default 100000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQMP
 	default 50000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQ
 	default 100000000 if DEBUG_UART_PL011 && (ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
+	default 7372800 if DEBUG_UART_APQ8016
 	help
 	  The UART input clock determines the speed of the internal UART
 	  circuitry. The baud rate is derived from this by dividing the input
diff --git a/drivers/serial/serial_msm.c b/drivers/serial/serial_msm.c
index 18d15b7b15b..e25cb71696f 100644
--- a/drivers/serial/serial_msm.c
+++ b/drivers/serial/serial_msm.c
@@ -235,18 +235,8 @@ static struct msm_serial_data init_serial_data = {
 
 #include <debug_uart.h>
 
-/* Uncomment to turn on UART clocks when debugging U-Boot as aboot on MSM8916 */
-//int apq8016_clk_init_uart(phys_addr_t gcc_base, unsigned long id);
-
 static inline void _debug_uart_init(void)
 {
-	/*
-	 * Uncomment to turn on UART clocks when debugging U-Boot as aboot
-	 * on MSM8916. Supported debug UART clock IDs:
-	 *   - db410c: GCC_BLSP1_UART2_APPS_CLK
-	 *   - HMIBSC: GCC_BLSP1_UART1_APPS_CLK
-	 */
-	//apq8016_clk_init_uart(0x1800000, <uart_clk_id>);
 	uart_dm_init(&init_serial_data);
 }
 

---
base-commit: f76fb6495b2df5163f4c88dc222acc934caffbfb
change-id: 20260602-apq8016-debug-uart-07c0cf4e1060

Best regards,
-- 
Sam Day <me@samcday.com>


