Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6991DC02198
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 22:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0D9280805;
	Sat,  8 Feb 2025 23:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="RY6G8wph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9BD980834; Sat,  8 Feb 2025 23:49:57 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 647AC80805
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 23:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=660f=VA=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1739054994; bh=wzEUSmzMVoUHkdofqfseJ+qwDWH1KF21weWTbGGKSp8=;
 b=RY6G8wphRwes7y+7LXECn7io8uK74X7m0fLGd45cbX1+VskcJSKB2Vj//Qv7EA7tBggFmWd2T
 YC1DbsRG3x0LIPiX7WIOwLCVcQmZ30EUrdZ+2/04rR6NcRVvorRURF861qI0acOM3n+mv8h6nk+
 cZLNGSTCN3qPp4crv9oeO3N46vtLUR4g3yqBu0yosOj1jLgFHcAiPDBpwPKXSg0QWVcmuDzz42K
 ERVn3ZfKJPOojiOr5ga5g6e8E3RwJGv6oonqj7TaaXCdJqjeHc6GKU5oimi23ytFMaaTKpzMpRt
 mnC6/B9dZcMHshx2NN0VKecoITBW8oL3HOp0nOZTE5uw==
X-Forward-Email-ID: 67a7df90771e645baa15e2a6
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.73
X-Forward-Email-Version: 0.4.40
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 1/3] Revert "rockchip: rk3399: Drop unneeded bob and kevin
 board specific code"
Date: Sat,  8 Feb 2025 22:49:38 +0000
Message-ID: <20250208224945.2641933-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250208224945.2641933-1-jonas@kwiboo.se>
References: <20250208224945.2641933-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

These power rails must be on very early for the U-Boos SPL banner to be
show over debug UART.

This reverts commit af518a1dfe637cb4dc486d7a832585e4a48bc970.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3399/rk3399.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 1ce43c6f0d40..ba89079b1e73 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -7,6 +7,7 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
+#include <spl_gpio.h>
 #include <syscon.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
@@ -15,7 +16,6 @@
 #include <asm/arch-rockchip/gpio.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
-#include <asm/gpio.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <power/regulator.h>
@@ -133,6 +133,27 @@ void board_debug_uart_init(void)
 		     GRF_GPIO3B7_SEL_MASK,
 		     GRF_UART3_SOUT << GRF_GPIO3B7_SEL_SHIFT);
 #else
+	struct rk3399_pmugrf_regs * const pmugrf = (void *)PMUGRF_BASE;
+	struct rockchip_gpio_regs * const gpio = (void *)GPIO0_BASE;
+
+	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
+	    (IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_BOB) ||
+	     IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_KEVIN))) {
+		rk_setreg(&grf->io_vsel, 1 << 0);
+
+		/*
+		 * Let's enable these power rails here, we are already running
+		 * the SPI-Flash-based code.
+		 */
+		spl_gpio_output(gpio, GPIO(BANK_B, 2), 1);  /* PP1500_EN */
+		spl_gpio_set_pull(&pmugrf->gpio0_p, GPIO(BANK_B, 2),
+				  GPIO_PULL_NORMAL);
+
+		spl_gpio_output(gpio, GPIO(BANK_B, 4), 1);  /* PP3000_EN */
+		spl_gpio_set_pull(&pmugrf->gpio0_p, GPIO(BANK_B, 4),
+				  GPIO_PULL_NORMAL);
+	}
+
 	/* Enable early UART2 channel C on the RK3399 */
 	rk_clrsetreg(&grf->gpio4c_iomux,
 		     GRF_GPIO4C3_SEL_MASK,
-- 
2.48.1

