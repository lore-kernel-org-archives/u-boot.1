Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09631C47DDF
	for <u-boot@archiver.kernel.org>; Fri, 26 Jan 2024 12:25:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28E4887C3F;
	Fri, 26 Jan 2024 13:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="H6wE2ld1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 283A3879A2; Fri, 26 Jan 2024 10:26:16 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A5886784
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 10:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=piotr.wojtaszczyk@timesys.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a34b468154fso13439166b.1
 for <u-boot@lists.denx.de>; Fri, 26 Jan 2024 01:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1706261173; x=1706865973;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3lHITaxpwd7fKXH7IiwiS3Alv6/xbZxawqyZpoVw1I=;
 b=H6wE2ld1oYlgY437CQlAeBTJOwjPeqOHp8lyYC55YmYAVRe+Pf0ezk/YDy9PNPTqqy
 ydE3hxWaUBiyU3OD8oUVCZRKb17lAroUqSWgsyNj3tID1c2iagQgzPEnq75cXGglbAWg
 zUWdECAGY9yCKEvhbp6DvQkjUgvAOdhPVZqYzD5rf2+10iJ2YmY2AZLDlEe2eX19GVGD
 573zFdmicM9hq1NLK2bD663+VhtH8i8L7FZEGi7bwCo9SezhC3hLTvyXR6Z8/LJi+P/s
 2fFms0yvmSn0SZOq6Kwj/7NHGyVh25zbG9B4HdaKzHBxqo7R9QyXTBh5+UyY1MRWFe9/
 IjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706261173; x=1706865973;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3lHITaxpwd7fKXH7IiwiS3Alv6/xbZxawqyZpoVw1I=;
 b=Tk08WI9KdBnnzzccdmOB8ZhTWoOmlb6kGpUzwYusUnhwMqN3USAnwanb2rPJ73+6LW
 m86ex0V99tbnT6wRHxQyrEuBHImHEflSe8X0EnAgMaDGJaoXQOcFGtaDOzutyGYQzKcZ
 3eqMK7jn8dBPHsw+M/go/sxIpWPaMJ2fSWQsatC/wpiSAI2I7CTkLJOMQloyKq3wSgtM
 6C98zmLhfsTAGPUZp+u0hNBiZatX/lJNuCls/gVm05y+6iyqUE3CsFzh7AhHzMH+Jsue
 itBo4NZfI42AJAcUzg/Z3I8JmchQpdmUYaupl/2SaZiZMZmNwmpg+wo1TUxdeKpLA++n
 WT3g==
X-Gm-Message-State: AOJu0YzrbHYSMdzMoZeoOfYWgjqlxzxnf5Xg1eMoISR9qmos4+1ALrWI
 kMQpF9NE8WthewjTNmyFT9td5fosiaED32RjhTIOrhf4gkG/3Qr6cMkmSxDazBpyXAkZUJ6JPcC
 f+UI=
X-Google-Smtp-Source: AGHT+IG+ucExO8bHpyUq2ml5roYhZ7cF5PqQ1VmKqkFb2ko1iVxYseO6xo5Y1NxCNtFbHn1Umsv+qg==
X-Received: by 2002:a17:906:e0c9:b0:a34:97d1:48f0 with SMTP id
 gl9-20020a170906e0c900b00a3497d148f0mr397668ejb.76.1706261173520; 
 Fri, 26 Jan 2024 01:26:13 -0800 (PST)
Received: from localhost.localdomain ([91.216.213.152])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a1709064f1800b00a349a5f9f77sm416208eju.47.2024.01.26.01.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 01:26:13 -0800 (PST)
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
To: u-boot@lists.denx.de
Cc: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/5] lpc32xx: Make XTAL OSC freq configurable,
 add UART input clock selection
Date: Fri, 26 Jan 2024 10:25:31 +0100
Message-Id: <20240126092533.20709-4-piotr.wojtaszczyk@timesys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240126092533.20709-1-piotr.wojtaszczyk@timesys.com>
References: <20240126092533.20709-1-piotr.wojtaszczyk@timesys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jan 2024 13:24:57 +0100
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

Allow to configure external XTAL OSC or external clock frequency.
Add source clock selection for UART, selecting HCLK may be needed for
higher clock resolution for specific XTAL OSC and baud rate combinations.
HSUART is always driven by PERIPH_CLK.

Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
---

 arch/arm/include/asm/arch-lpc32xx/clk.h    |  3 +-
 arch/arm/include/asm/arch-lpc32xx/config.h |  2 +-
 arch/arm/mach-lpc32xx/Kconfig              | 23 +++++++++++++
 arch/arm/mach-lpc32xx/clk.c                |  8 +++--
 arch/arm/mach-lpc32xx/devices.c            | 38 +++++++++++++++++-----
 5 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/arch-lpc32xx/clk.h b/arch/arm/include/asm/arch-lpc32xx/clk.h
index 5ab48a9d3c..75dce06104 100644
--- a/arch/arm/include/asm/arch-lpc32xx/clk.h
+++ b/arch/arm/include/asm/arch-lpc32xx/clk.h
@@ -8,8 +8,7 @@
 
 #include <asm/types.h>
 
-#define OSC_CLK_FREQUENCY	13000000
-#define RTC_CLK_FREQUENCY	32768
+#define LPC32XX_RTC_CLK_FREQUENCY	32768
 
 /* Clocking and Power Control Registers */
 struct clk_pm_regs {
diff --git a/arch/arm/include/asm/arch-lpc32xx/config.h b/arch/arm/include/asm/arch-lpc32xx/config.h
index 41160384a4..836e29bd96 100644
--- a/arch/arm/include/asm/arch-lpc32xx/config.h
+++ b/arch/arm/include/asm/arch-lpc32xx/config.h
@@ -12,7 +12,7 @@
 /* Basic CPU architecture */
 
 #if !defined(CFG_SYS_NS16550_CLK)
-#define CFG_SYS_NS16550_CLK		13000000
+#define CFG_SYS_NS16550_CLK		get_serial_clock()
 #endif
 
 #define CFG_SYS_BAUDRATE_TABLE	\
diff --git a/arch/arm/mach-lpc32xx/Kconfig b/arch/arm/mach-lpc32xx/Kconfig
index 185bda41c2..6b54ec6220 100644
--- a/arch/arm/mach-lpc32xx/Kconfig
+++ b/arch/arm/mach-lpc32xx/Kconfig
@@ -17,6 +17,29 @@ config TARGET_EA_LPC3250DEVKITV2
 
 endchoice
 
+choice
+	prompt "LPC32xx clock source for standard UARTs"
+	help
+		Select clock source for standard UART baudrate divider.
+
+config LPC32XX_UART_PERIPH_CLK
+	bool "PERIPH as clock source"
+	help
+		Slower than HCLK, less resolution, lower power consumption.
+
+config LPC32XX_UART_HCLK_CLK
+	bool "HCLK as clock source"
+	help
+		Faster than PERIPH, better resolution, higher power consumption.
+
+endchoice
+
+config LPC32XX_OSC_CLK_FREQUENCY
+	int "LPC32xx external XTAL OSC or clock source frequency"
+	default 13000000
+	help
+		LPC32xx external XTAL OSC or clock source frequency.
+
 source "board/timll/devkit3250/Kconfig"
 source "board/work-microwave/work_92105/Kconfig"
 source "board/ea/ea-lpc3250devkitv2/Kconfig"
diff --git a/arch/arm/mach-lpc32xx/clk.c b/arch/arm/mach-lpc32xx/clk.c
index cb2344d79f..f327e0e876 100644
--- a/arch/arm/mach-lpc32xx/clk.c
+++ b/arch/arm/mach-lpc32xx/clk.c
@@ -15,9 +15,9 @@ static struct clk_pm_regs *clk = (struct clk_pm_regs *)CLK_PM_BASE;
 unsigned int get_sys_clk_rate(void)
 {
 	if (readl(&clk->sysclk_ctrl) & CLK_SYSCLK_PLL397)
-		return RTC_CLK_FREQUENCY * 397;
+		return LPC32XX_RTC_CLK_FREQUENCY * 397;
 	else
-		return OSC_CLK_FREQUENCY;
+		return CONFIG_LPC32XX_OSC_CLK_FREQUENCY;
 }
 
 unsigned int get_hclk_pll_rate(void)
@@ -134,5 +134,9 @@ unsigned int get_sdram_clk_rate(void)
 
 int get_serial_clock(void)
 {
+#if IS_ENABLED(CONFIG_LPC32XX_UART_HCLK_CLK)
+	return get_hclk_clk_rate();
+#else
 	return get_periph_clk_rate();
+#endif
 }
diff --git a/arch/arm/mach-lpc32xx/devices.c b/arch/arm/mach-lpc32xx/devices.c
index 6a67a3591a..27061b6212 100644
--- a/arch/arm/mach-lpc32xx/devices.c
+++ b/arch/arm/mach-lpc32xx/devices.c
@@ -6,6 +6,7 @@
 #include <common.h>
 #include <dm.h>
 #include <ns16550.h>
+#include <clock_legacy.h>
 
 #include <asm/arch/clk.h>
 #include <asm/arch/uart.h>
@@ -16,6 +17,13 @@ static struct clk_pm_regs    *clk  = (struct clk_pm_regs *)CLK_PM_BASE;
 static struct uart_ctrl_regs *ctrl = (struct uart_ctrl_regs *)UART_CTRL_BASE;
 static struct mux_regs *mux = (struct mux_regs *)MUX_BASE;
 
+#define LPC32XX_USB_RATE 1000000
+#define LPC32XX_USB_DIV ((CONFIG_LPC32XX_OSC_CLK_FREQUENCY/LPC32XX_USB_RATE)-1)
+
+#if !CONFIG_IS_ENABLED(OF_CONTROL)
+static struct ns16550_plat lpc32xx_uart[4];
+#endif
+
 void lpc32xx_uart_init(unsigned int uart_id)
 {
 	if (uart_id < 1 || uart_id > 7)
@@ -36,20 +44,30 @@ void lpc32xx_uart_init(unsigned int uart_id)
 			UART_CLKMODE_AUTO(uart_id));
 
 	/* Bypass pre-divider of UART clock */
+#if IS_ENABLED(CONFIG_LPC32XX_UART_HCLK_CLK)
+	/* Use HCLK as input for baudrate divider */
+	writel(CLK_UART_HCLK | CLK_UART_X_DIV(1) | CLK_UART_Y_DIV(1),
+	       &clk->u3clk + (uart_id - 3));
+#else
+	/* Use PERIPH as input for baudrate divider */
 	writel(CLK_UART_X_DIV(1) | CLK_UART_Y_DIV(1),
 	       &clk->u3clk + (uart_id - 3));
+#endif
+
+#if !CONFIG_IS_ENABLED(OF_CONTROL)
+	int i;
+	for (i = 0; i < ARRAY_SIZE(lpc32xx_uart); i++) {
+		lpc32xx_uart[i].clock = get_serial_clock();
+	}
+#endif
 }
 
 #if !CONFIG_IS_ENABLED(OF_CONTROL)
-static const struct ns16550_plat lpc32xx_uart[] = {
-	{ .base = UART3_BASE, .reg_shift = 2,
-	  .clock = CFG_SYS_NS16550_CLK, .fcr = UART_FCR_DEFVAL, },
-	{ .base = UART4_BASE, .reg_shift = 2,
-	  .clock = CFG_SYS_NS16550_CLK, .fcr = UART_FCR_DEFVAL, },
-	{ .base = UART5_BASE, .reg_shift = 2,
-	  .clock = CFG_SYS_NS16550_CLK, .fcr = UART_FCR_DEFVAL, },
-	{ .base = UART6_BASE, .reg_shift = 2,
-	  .clock = CFG_SYS_NS16550_CLK, .fcr = UART_FCR_DEFVAL, },
+static struct ns16550_plat lpc32xx_uart[] = {
+	{ .base = UART3_BASE, .reg_shift = 2, .fcr = UART_FCR_DEFVAL, },
+	{ .base = UART4_BASE, .reg_shift = 2, .fcr = UART_FCR_DEFVAL, },
+	{ .base = UART5_BASE, .reg_shift = 2, .fcr = UART_FCR_DEFVAL, },
+	{ .base = UART6_BASE, .reg_shift = 2, .fcr = UART_FCR_DEFVAL, },
 };
 
 U_BOOT_DRVINFOS(lpc32xx_uarts) = {
@@ -94,6 +112,8 @@ void lpc32xx_usb_init(void)
 {
 	/* Do not route the UART 5 Tx/Rx pins to the USB D+ and USB D- pins. */
 	clrbits_le32(&ctrl->ctrl, UART_CTRL_UART5_USB_MODE);
+
+	writel(LPC32XX_USB_DIV, &clk->usbdiv_ctrl);
 }
 
 void lpc32xx_i2c_init(unsigned int devnum)
-- 
2.25.1

