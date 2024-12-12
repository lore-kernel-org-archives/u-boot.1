Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19966E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 23:59:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 640EF80245;
	Fri, 13 Dec 2024 00:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lFxFHula";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20A2F801ED; Fri, 13 Dec 2024 00:58:41 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 905B8802C2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 00:58:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734047915; bh=GBrRO4QAj4qJg0nWFta7I2qyeJmEuTOZ5T9MghUrCvE=;
 b=lFxFHulabXFZuOn1hWjYna36MIbC7y0dTUtZh5X7jLgzpXYJ6zTkZiUHXYcU+VmHis9m7yGXv
 36kq7MZMFtesqm+B0p2oJwAcrMfu+aF658bCwgxVvrGBTVuSf9rcd3Zx36fNmRlFjw7g0i6sTHo
 6A1w/xW540LoLaDtPclE+dnicjN+GffjYabyqFXLNRZqLhIgYdY0Gh48LQTOMYSv7wmlzALoEqq
 XvvF3xT57kdA/tgxkyrKY52T4PRkuhwvSaNTza+eAi1/3bwsHnPuVPVyIEnA9eP1bjJ0l4rByt6
 T5cSY/wywaKegO+JE4W9MBASG2qkiBCWEnm88nFCBtsQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 12/12] rockchip: rk3399: Drop unneeded bob and kevin board
 specific code
Date: Thu, 12 Dec 2024 23:57:19 +0000
Message-ID: <20241212235735.164272-13-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212235735.164272-1-jonas@kwiboo.se>
References: <20241212235735.164272-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b78a9a511ed8f0b3fe391
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

The IO-domain driver will configure io_vsel and always-on/boot-on
regulators will be enabled based on the board device tree now that
required nodes and Kconfig options is enabled for SPL.

Remove the bob and kevin board specific code from the common rk3399.c,
the IO-domain and regulator driver provide similar functionality.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/mach-rockchip/rk3399/rk3399.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index ba89079b1e73..1ce43c6f0d40 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -7,7 +7,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <spl_gpio.h>
 #include <syscon.h>
 #include <asm/armv8/mmu.h>
 #include <asm/arch-rockchip/bootrom.h>
@@ -16,6 +15,7 @@
 #include <asm/arch-rockchip/gpio.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
 #include <asm/arch-rockchip/hardware.h>
+#include <asm/gpio.h>
 #include <linux/bitops.h>
 #include <linux/printk.h>
 #include <power/regulator.h>
@@ -133,27 +133,6 @@ void board_debug_uart_init(void)
 		     GRF_GPIO3B7_SEL_MASK,
 		     GRF_UART3_SOUT << GRF_GPIO3B7_SEL_SHIFT);
 #else
-	struct rk3399_pmugrf_regs * const pmugrf = (void *)PMUGRF_BASE;
-	struct rockchip_gpio_regs * const gpio = (void *)GPIO0_BASE;
-
-	if (IS_ENABLED(CONFIG_SPL_BUILD) &&
-	    (IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_BOB) ||
-	     IS_ENABLED(CONFIG_TARGET_CHROMEBOOK_KEVIN))) {
-		rk_setreg(&grf->io_vsel, 1 << 0);
-
-		/*
-		 * Let's enable these power rails here, we are already running
-		 * the SPI-Flash-based code.
-		 */
-		spl_gpio_output(gpio, GPIO(BANK_B, 2), 1);  /* PP1500_EN */
-		spl_gpio_set_pull(&pmugrf->gpio0_p, GPIO(BANK_B, 2),
-				  GPIO_PULL_NORMAL);
-
-		spl_gpio_output(gpio, GPIO(BANK_B, 4), 1);  /* PP3000_EN */
-		spl_gpio_set_pull(&pmugrf->gpio0_p, GPIO(BANK_B, 4),
-				  GPIO_PULL_NORMAL);
-	}
-
 	/* Enable early UART2 channel C on the RK3399 */
 	rk_clrsetreg(&grf->gpio4c_iomux,
 		     GRF_GPIO4C3_SEL_MASK,
-- 
2.47.1

