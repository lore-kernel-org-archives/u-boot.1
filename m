Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAEFD44D51
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 11:30:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A090389159;
	Wed,  6 Nov 2024 12:29:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E23F891E1; Wed,  6 Nov 2024 12:29:54 +0100 (CET)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::8fab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69ECC89159
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 12:29:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xk3000hrMzC4r;
 Wed,  6 Nov 2024 12:29:52 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Xk2zz0sHCzJVH; Wed,  6 Nov 2024 12:29:51 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 06 Nov 2024 12:29:42 +0100
Subject: [PATCH next v2 2/4] rockchip: rk3399: merge CRU check within
 rk3399_force_power_on_reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-rk3399-sysreset-gpio-tpl-v2-2-22aa82189eb6@cherry.de>
References: <20241106-rk3399-sysreset-gpio-tpl-v2-0-22aa82189eb6@cherry.de>
In-Reply-To: <20241106-rk3399-sysreset-gpio-tpl-v2-0-22aa82189eb6@cherry.de>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Klaus Goger <klaus.goger@cherry.de>
Cc: u-boot@lists.denx.de, Paul Kocialkowski <paulk@sys-base.io>, 
 Paul Kocialkowski <contact@paulk.fr>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
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

To prepare to support forcing power on reset from TPL which would have
the exact same logic, just in an earlier stage, let's merge the CRU
check that triggers the power on reset with the rest of the logic.

Reviewed-by: Paul Kocialkowski <paulk@sys-base.io>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/rk3399/rk3399.c | 43 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index edccb2a3980d0e3921aa4073b67aea6a00f18b8d..7b6a822ed04b8151a5da147056dbf73ffdafd149 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -172,9 +172,29 @@ void board_debug_uart_init(void)
 #if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
 static void rk3399_force_power_on_reset(void)
 {
+	const struct rockchip_cru *cru = rockchip_get_cru();
 	ofnode node;
 	struct gpio_desc sysreset_gpio;
 
+	/*
+	 * The RK3399 resets only 'almost all logic' (see also in the
+	 * TRM "3.9.4 Global software reset"), when issuing a software
+	 * reset. This may cause issues during boot-up for some
+	 * configurations of the application software stack.
+	 *
+	 * To work around this, we test whether the last reset reason
+	 * was a power-on reset and (if not) issue an overtemp-reset to
+	 * reset the entire module.
+	 *
+	 * While this was previously fixed by modifying the various
+	 * places that could generate a software reset (e.g. U-Boot's
+	 * sysreset driver, the ATF or Linux), we now have it here to
+	 * ensure that we no longer have to track this through the
+	 * various components.
+	 */
+	if (cru->glb_rst_st == 0)
+		return;
+
 	if (!IS_ENABLED(CONFIG_SPL_GPIO)) {
 		debug("%s: trying to force a power-on reset but no GPIO "
 		      "support in SPL!\n", __func__);
@@ -206,27 +226,6 @@ void spl_board_init(void)
 {
 	led_setup();
 
-	if (IS_ENABLED(CONFIG_SPL_GPIO)) {
-		struct rockchip_cru *cru = rockchip_get_cru();
-
-		/*
-		 * The RK3399 resets only 'almost all logic' (see also in the
-		 * TRM "3.9.4 Global software reset"), when issuing a software
-		 * reset. This may cause issues during boot-up for some
-		 * configurations of the application software stack.
-		 *
-		 * To work around this, we test whether the last reset reason
-		 * was a power-on reset and (if not) issue an overtemp-reset to
-		 * reset the entire module.
-		 *
-		 * While this was previously fixed by modifying the various
-		 * places that could generate a software reset (e.g. U-Boot's
-		 * sysreset driver, the ATF or Linux), we now have it here to
-		 * ensure that we no longer have to track this through the
-		 * various components.
-		 */
-		if (cru->glb_rst_st != 0)
-			rk3399_force_power_on_reset();
-	}
+	rk3399_force_power_on_reset();
 }
 #endif

-- 
2.47.0

