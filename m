Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A1A606A32D
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UZKw4/Bs;
	dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org header.i=@freemyipod.org header.a=rsa-sha256 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=o+YKNxPm;
	dkim=pass (1024-bit key, unprotected) header.d=amazonses.com header.i=@amazonses.com header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh header.b=VhPNGrRz
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C035D6075B;
	Sat, 14 Nov 2026 16:22:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mbaa3_-LfiIC; Sat, 14 Nov 2026 16:22:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3219660770
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794673319;
	b=PiIrmGPcxmlaM4OTckufNZ3Bbact+dNovrJxL7eZbHrJ1I9zxSX72C+LUnSwi/lN4gj0
	 9tMwbptHx/KC7lypSjJvp4MN7O+ftk9B6kUVP3H2CUr0cheElqhIZwYwlPh0kWPjJQfJ8
	 IaF9YXO7FJEJjHPSgo94xixgwrEbNSIF8f5OkKjB/f79lqva2RdfhEFbWiFDXg3iv/D2x
	 pJjPu7lNsoTqwtyGq1gHMp6cuRjm2YQo7P7BPfCwpVxoFcNwcAQdxhdDZ8e1eqqdF1MnM
	 XQM8hkFmGl6waL3mpsEfvMcMiyNudcz0mEwHlc46XjhGLPaDXWaMQ/JqOb7+pFn6N1w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794673319;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-ID:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 Feedback-ID:X-SES-Outgoing:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=OUlZN9kcyhVyQlJ37gsfdeYx72w8qm6LZL/hvAbnbew=;
	b=nObwl/JkMLrCqw4hOyZMdssMGs11FpyII7ukT6l1XUj7hAwjR2yatjhZXcB1kJ+Vj+Ap
	 ezKESC8ZKrMj9a8lWTaALKVcnxwtdQSOUuDGyF+cnM29B4DBVl97uMUCcvgcVa1aQeNr8
	 Sx20rvkZNMEAlI8AS20c+KuAqnRrWEZN7dU/RuK5SGQkuJLe/OoUNN9AR3qSpjcY27COu
	 iaCZouq7iJ48KgOs2STBMCDjwwuQZ7/9FXV4FGUhjB074VQTPdrq+CpRrSKS9cV1FL1Xf
	 tTRYM3LbeYwmj5X0qzcVfWhB8snMm3K2QSxhOawLpzqWcKJiCDF+dQ2Y8OcdykMh/vA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794673319;
	bh=OUlZN9kcyhVyQlJ37gsfdeYx72w8qm6LZL/hvAbnbew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UZKw4/BsVEzTecPJWavHsVHwXqlCznPm4q/ujQJJHeKG7mipIH1MiVlQrErFjChRQ
	 wKTR+OITA/8r8+kAu1Sb4d6dFCcrog+NOMrlSpDLo0L2T06HPJk6cmye/ySLgloP9U
	 ACYnKdQ23g5SMAdxGNJDox0k9pfkc9qfZuz//p+wNOyBub5EVsKbmmnHjJYUrfPTPD
	 Ve/kIsM6etReA2J4sRrtpQZt0MfGWUhYy4gmKhUQuRdUzIjeH7Rdwc0bnN/G2hq5g9
	 3f3/N+nmgA7HD22ISghL06GLOMaQVECk+VEaD7W2fy7mZu/WMoay6Dz8ygKgq78e9e
	 gCQVpHoRFk4dQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3219660770;
	Sat, 14 Nov 2026 16:21:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 889A92E5
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6EF77400BE
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nTcYNIaPWRnW for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 16:21:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1CA2540063
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=69.169.224.8
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=69.169.224.8;
 helo=b224-8.smtp-out.eu-central-1.amazonses.com;
 envelope-from=010701a1dadd705d-fe87a8a4-8874-4292-ba82-58fb7c9458ae-000000@ses.freemyipod.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none)
 header.from=freemyipod.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=freemyipod.org
 header.i=@freemyipod.org header.a=rsa-sha256
 header.s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz header.b=o+YKNxPm; 
 dkim=pass (1024-bit key,
 unprotected) header.d=amazonses.com header.i=@amazonses.com
 header.a=rsa-sha256 header.s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh
 header.b=VhPNGrRz
Received: from b224-8.smtp-out.eu-central-1.amazonses.com
 (b224-8.smtp-out.eu-central-1.amazonses.com [69.169.224.8])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1CA2540063
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=ylszqdgnz5tbs3ezxze3kdgo24hbgpsz; d=freemyipod.org; t=1794673307;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc;
 bh=Gf3Fv4f5PlownI2+2zfoWuGLR27GJ7Sn42rYKCNhaxg=;
 b=o+YKNxPmvkiiSDSSx4ajemkWUFe7XBolDPGMjLQoJW8QXfiJSxitVBaTL2bxqjz1
 rvhQoROaTC6nKtVWhHclUjInuXbRJkvuWJlm03dK+AL3i9G2O7jCrcvfx4EBTTLD9eL
 axJ4ece+My2VQpsbIAZ9bz8NTnPjyIvCS8VDvTrYa5ZozuMQBAdkZE69axaCN5mkiga
 hL4M146qb2siYr6r44L7J6QYXuKRcoeHgvp8gNRinNftkcv1WfWIOFdiFVFbYWIg7cE
 tGPvzx4hzsjfZrYN83PjveQQpTsvpBt00QgYJHQWY/Lzs+wjoOfpcdF3X1lhT7nEP8f
 q+vsU5ztIA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
 s=qftdzk2dqsatjnlrq4r5brjbihpfcrsh; d=amazonses.com; t=1794673307;
 h=From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:Feedback-ID;
 bh=Gf3Fv4f5PlownI2+2zfoWuGLR27GJ7Sn42rYKCNhaxg=;
 b=VhPNGrRzPDiqiX9MMi8I5yO+CRDeXo9qpJJSL7gzH2Ml3vthhFKcSnpli+pxTxuT
 AztfsZoXeVqpkcYnJ+xAoN3C+mwig0gPZVwtbolTqJiqXonXYZNTeU9IG88xO0gthOH
 JwVwtjQRlDPZjpePKD6cYXHj551pySyUjCZ4EzK8=
From: Vencislav Atanasov <user890104@freemyipod.org>
Date: Sat, 14 Nov 2026 16:21:47 +0000
Subject: [PATCH v3 06/13] serial: Add support for S5L87xx to serial_s5p
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <010701a1dadd705d-fe87a8a4-8874-4292-ba82-58fb7c9458ae-000000@eu-central-1.amazonses.com>
References: <20261114-s5l87xx-v2-v3-0-083bd20d8ded@freemyipod.org>
In-Reply-To: <20261114-s5l87xx-v2-v3-0-083bd20d8ded@freemyipod.org>
To: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>
Cc: Vencislav Atanasov <user890104@freemyipod.org>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michael Srba <Michael.Srba@seznam.cz>, Johan Jonker <jbx6244@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marex@nabladev.com>, Michal Simek <michal.simek@amd.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Honbo He <hehongbo918@gmail.com>, Samuel Holland <samuel@sholland.org>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Stefan Roese <stefan.roese@mailbox.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794673300; l=6507;
 i=user890104@freemyipod.org; s=20261004; h=from:subject:message-id;
 bh=Gf3Fv4f5PlownI2+2zfoWuGLR27GJ7Sn42rYKCNhaxg=;
 b=5cJV7NCho0OvNUG37+IBIdvP9sjy00QVQEsK9ZH3mGtf1x5hVcaK3PYYaPWSi9AUzOd3qCNu8
 ObYnwrIcLvvDWuREmMVkTXytDif1me7iball0aoBvnbUh0Qx8O6tpHm
X-Developer-Key: i=user890104@freemyipod.org; a=ed25519;
 pk=klj5EgxMkX+YF0tPboUEB9kwBfthBgHWLhDOkwnmUus=
Feedback-ID: ::1.eu-central-1.GZFSN+SpSZlcZgoCjFtpLsnhzRcxifcxl4uaxXIRIUo=:AmazonSES
X-SES-Outgoing: 2026.11.14-69.169.224.8
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The S5L87xx UART peripheral does not support UDIVSLOT, also it needs
the NCLK bit to be set (clock source selection).

Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>
---
 MAINTAINERS                              |  5 ++++
 arch/arm/include/asm/arch-s5l87xx/uart.h | 29 +++++++++++++++++++
 drivers/serial/Kconfig                   |  4 +--
 drivers/serial/serial_s5p.c              | 49 +++++++++++++++++++++-----------
 4 files changed, 69 insertions(+), 18 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 95b1f3b5ab3..da8e413dd35 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -600,6 +600,11 @@ F:	drivers/clk/exynos/clk-exynos850.c
 F:	drivers/phy/phy-exynos-usbdrd.c
 F:	drivers/pinctrl/exynos/pinctrl-exynos850.c
 
+ARM SAMSUNG S5L87XX SOC
+M:	Vencislav Atanasov <user890104@freemyipod.org>
+S:	Maintained
+F:	arch/arm/include/asm/arch-s5l87*
+
 ARM SAMSUNG SOC DRIVERS
 M:	Sam Protsenko <semen.protsenko@linaro.org>
 S:	Maintained
diff --git a/arch/arm/include/asm/arch-s5l87xx/uart.h b/arch/arm/include/asm/arch-s5l87xx/uart.h
new file mode 100644
index 00000000000..61b7cf43890
--- /dev/null
+++ b/arch/arm/include/asm/arch-s5l87xx/uart.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * (C) Copyright 2009 Samsung Electronics
+ * Minkyu Kang <mk7.kang@samsung.com>
+ * Heungjun Kim <riverful.kim@samsung.com>
+ */
+
+#ifndef __ASM_ARCH_S5L87XX_UART_H_
+#define __ASM_ARCH_S5L87XX_UART_H_
+
+#ifndef __ASSEMBLY__
+
+struct s5p_uart {
+	unsigned int	ulcon;
+	unsigned int	ucon;
+	unsigned int	ufcon;
+	unsigned int	umcon;
+	unsigned int	utrstat;
+	unsigned int	uerstat;
+	unsigned int	ufstat;
+	unsigned int	umstat;
+	unsigned int	utxh;
+	unsigned int	urxh;
+	unsigned int	ubrdiv;
+};
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* __ASM_ARCH_S5L87XX_UART_H_ */
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index bcb0c865437..fa1959b2c30 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -321,7 +321,7 @@ config DEBUG_SBI_CONSOLE
 
 config DEBUG_UART_S5P
 	bool "Samsung S5P"
-	depends on ARCH_APPLE || ARCH_EXYNOS || ARCH_S5PC1XX
+	depends on ARCH_APPLE || ARCH_EXYNOS || ARCH_S5PC1XX || ARCH_S5L87XX
 	help
 	  Select this to enable a debug UART using the serial_s5p driver. You
 	  will need to provide parameters to make this work. The driver will
@@ -905,7 +905,7 @@ config ROCKCHIP_SERIAL
 
 config S5P_SERIAL
 	bool "Support for Samsung S5P UART"
-	depends on ARCH_APPLE || ARCH_EXYNOS || ARCH_S5PC1XX
+	depends on ARCH_APPLE || ARCH_EXYNOS || ARCH_S5PC1XX || ARCH_S5L87XX
 	default y
 	help
 	  Select this to enable Samsung S5P UART support.
diff --git a/drivers/serial/serial_s5p.c b/drivers/serial/serial_s5p.c
index d46a88610ab..eec0fa0a10f 100644
--- a/drivers/serial/serial_s5p.c
+++ b/drivers/serial/serial_s5p.c
@@ -13,10 +13,14 @@
 #include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <asm/io.h>
-#if !IS_ENABLED(CONFIG_ARCH_APPLE)
+#if !IS_ENABLED(CONFIG_ARCH_APPLE) && !IS_ENABLED(CONFIG_ARCH_S5L87XX)
 #include <asm/arch/clk.h>
 #endif
+#if IS_ENABLED(CONFIG_ARCH_S5L87XX)
+#include <asm/arch-s5l87xx/uart.h>
+#else
 #include <asm/arch/uart.h>
+#endif
 #include <serial.h>
 #include <clk.h>
 
@@ -40,6 +44,7 @@ enum {
 #define S5L_TX_FIFO_COUNT_SHIFT	4
 #define S5L_TX_FIFO_COUNT_MASK	(0xf << S5L_TX_FIFO_COUNT_SHIFT)
 #define S5L_TX_FIFO_FULL	BIT(9)
+#define S5L_CLK_NCLK		BIT(10)
 
 #define S5P_RX_FIFO_COUNT_SHIFT	0
 #define S5P_RX_FIFO_COUNT_MASK	(0xff << S5P_RX_FIFO_COUNT_SHIFT)
@@ -61,6 +66,7 @@ struct s5p_serial_plat {
 	u32 tx_fifo_full;
 };
 
+#if !IS_ENABLED(CONFIG_ARCH_S5L87XX)
 /*
  * The coefficient, used to calculate the baudrate on S5P UARTs is
  * calculated as
@@ -86,6 +92,7 @@ static const int udivslot[] = {
 	0xdfdf,
 	0xffdf,
 };
+#endif
 
 static void __maybe_unused s5p_serial_init(struct s5p_uart *uart)
 {
@@ -98,6 +105,14 @@ static void __maybe_unused s5p_serial_init(struct s5p_uart *uart)
 	/* No interrupts, no DMA, pure polling */
 	writel(UCON_RX_IRQ_OR_POLLING | UCON_TX_IRQ_OR_POLLING |
 	       UCON_RX_ERR_IRQ_EN | UCON_TX_IRQ_LEVEL, &uart->ucon);
+
+	if (IS_ENABLED(CONFIG_ARCH_S5L87XX)) {
+		u32 val;
+
+		val = readl(&uart->ucon);
+		val |= S5L_CLK_NCLK;
+		writel(val, &uart->ucon);
+	}
 }
 
 static void __maybe_unused s5p_serial_baud(struct s5p_uart *uart, u8 reg_width,
@@ -109,12 +124,14 @@ static void __maybe_unused s5p_serial_baud(struct s5p_uart *uart, u8 reg_width,
 
 	writel(val / 16 - 1, &uart->ubrdiv);
 
+#if !IS_ENABLED(CONFIG_ARCH_S5L87XX)
 	if (s5p_uart_divslot())
 		writew(udivslot[val % 16], &uart->rest.slot);
 	else if (reg_width == 4)
 		writel(val % 16, &uart->rest.value);
 	else
 		writeb(val % 16, &uart->rest.value);
+#endif
 }
 
 #ifndef CONFIG_XPL_BUILD
@@ -124,7 +141,8 @@ int s5p_serial_setbrg(struct udevice *dev, int baudrate)
 	struct s5p_uart *const uart = plat->reg;
 	u32 uclk;
 
-#if IS_ENABLED(CONFIG_CLK_EXYNOS) || IS_ENABLED(CONFIG_ARCH_APPLE)
+#if IS_ENABLED(CONFIG_CLK_EXYNOS) || IS_ENABLED(CONFIG_ARCH_APPLE) || \
+	IS_ENABLED(CONFIG_ARCH_S5L87XX)
 	struct clk clk;
 	int ret;
 
@@ -286,26 +304,25 @@ static inline void _debug_uart_init(void)
 	struct s5p_uart *uart = (struct s5p_uart *)CONFIG_VAL(DEBUG_UART_BASE);
 
 	s5p_serial_init(uart);
-#if IS_ENABLED(CONFIG_ARCH_APPLE)
-	s5p_serial_baud(uart, 4, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
-#else
-	s5p_serial_baud(uart, 1, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
-#endif
+	if (IS_ENABLED(CONFIG_ARCH_APPLE) || IS_ENABLED(CONFIG_ARCH_S5L87XX))
+		s5p_serial_baud(uart, 4, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
+	else
+		s5p_serial_baud(uart, 1, CONFIG_DEBUG_UART_CLOCK, CONFIG_BAUDRATE);
 }
 
 static inline void _debug_uart_putc(int ch)
 {
 	struct s5p_uart *uart = (struct s5p_uart *)CONFIG_VAL(DEBUG_UART_BASE);
 
-#if IS_ENABLED(CONFIG_ARCH_APPLE)
-	while (readl(&uart->ufstat) & S5L_TX_FIFO_FULL)
-		;
-	writel(ch, &uart->utxh);
-#else
-	while (readl(&uart->ufstat) & S5P_TX_FIFO_FULL)
-		;
-	writeb(ch, &uart->utxh);
-#endif
+	if (IS_ENABLED(CONFIG_ARCH_APPLE) || IS_ENABLED(CONFIG_ARCH_S5L87XX)) {
+		while (readl(&uart->ufstat) & S5L_TX_FIFO_FULL)
+			;
+		writel(ch, &uart->utxh);
+	} else {
+		while (readl(&uart->ufstat) & S5P_TX_FIFO_FULL)
+			;
+		writeb(ch, &uart->utxh);
+	}
 }
 
 DEBUG_UART_FUNCS

-- 
Git-157)

