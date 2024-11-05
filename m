Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC6FD2C122
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:37:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93E69891CD;
	Tue,  5 Nov 2024 16:37:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDB61891AF; Tue,  5 Nov 2024 16:37:00 +0100 (CET)
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::bc09])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D059A8900E
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:36:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XjXWZ3Z7hzbRQ;
 Tue,  5 Nov 2024 16:36:58 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4XjXWY5sZhzNyf; Tue,  5 Nov 2024 16:36:57 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 05 Nov 2024 16:36:35 +0100
Subject: [PATCH next 4/5] rockchip: rk3399: allow to handle sysreset-gpio
 in TPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-rk3399-sysreset-gpio-tpl-v1-4-12caff07a4e4@cherry.de>
References: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
In-Reply-To: <20241105-rk3399-sysreset-gpio-tpl-v1-0-12caff07a4e4@cherry.de>
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

If TPL_GPIO and TPL_PINCTRL_ROCKCHIP are enabled and a sysreset-gpio is
provided in the TPL Device Tree, this will trigger a system reset
similar to what's currently been done in SPL whenever the RK3399 "warm"
boots.

There are three reasons for moving this earlier:
- faster boot time as we don't need to reach SPL to be able to reset the
  system on a condition we know is already met in TPL,
- have less code to be impacted by the issue this system reset works
  around (that is, "unclean" SoC registers after a reboot),
- less confusion around the reason for restarting. Indeed when done from
  SPL, the following log can be observed:

"""
U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45)
Channel 0: DDR3, 666MHz
BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
Channel 1: DDR3, 666MHz
BW=32 Col=10 Bk=8 CS0 Row=16 CS=1 Die BW=16 Size=2048MB
256B stride
Trying to boot from BOOTROM
Returning to boot ROM...

U-Boot SPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45 +0100)
Trying to boot from MMC2

U-Boot TPL 2025.01-rc1-00165-gd79216ca9878-dirty (Nov 05 2024 - 15:31:45)
"""

possibly hinting at an issue within the SPL when loading the fitImage
from MMC2 instead of the normal course of events (a system reset).

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/rk3399/rk3399.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 7b6a822ed04b8151a5da147056dbf73ffdafd149..26fd04691699d81f5fecd282964c7b3aff999717 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -169,7 +169,7 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
 static void rk3399_force_power_on_reset(void)
 {
 	const struct rockchip_cru *cru = rockchip_get_cru();
@@ -195,9 +195,9 @@ static void rk3399_force_power_on_reset(void)
 	if (cru->glb_rst_st == 0)
 		return;
 
-	if (!IS_ENABLED(CONFIG_SPL_GPIO)) {
+	if (!CONFIG_IS_ENABLED(GPIO)) {
 		debug("%s: trying to force a power-on reset but no GPIO "
-		      "support in SPL!\n", __func__);
+		      "support in " PHASE_NAME "!\n", __func__);
 		return;
 	}
 
@@ -218,6 +218,7 @@ static void rk3399_force_power_on_reset(void)
 	dm_gpio_set_value(&sysreset_gpio, 1);
 }
 
+# if !defined(CONFIG_TPL_BUILD)
 void __weak led_setup(void)
 {
 }
@@ -228,4 +229,10 @@ void spl_board_init(void)
 
 	rk3399_force_power_on_reset();
 }
-#endif
+# else  // !defined(CONFIG_TPL_BUILD)
+void tpl_board_init(void)
+{
+	rk3399_force_power_on_reset();
+}
+# endif // !defined(CONFIG_TPL_BUILD)
+#endif // defined(CONFIG_XPL_BUILD)

-- 
2.47.0

