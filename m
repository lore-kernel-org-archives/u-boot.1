Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF88DD44D50
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 11:30:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F6CE891FD;
	Wed,  6 Nov 2024 12:29:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33532891E3; Wed,  6 Nov 2024 12:29:56 +0100 (CET)
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch
 [83.166.143.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419D0891D1
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 12:29:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xk3020CkKzKY0;
 Wed,  6 Nov 2024 12:29:54 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Xk3011CTpzK2r; Wed,  6 Nov 2024 12:29:53 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 06 Nov 2024 12:29:44 +0100
Subject: [PATCH next v2 4/4] rockchip: rk3399: move sysreset-gpio logic to TPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241106-rk3399-sysreset-gpio-tpl-v2-4-22aa82189eb6@cherry.de>
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

If TPL_GPIO and TPL_PINCTRL_ROCKCHIP are enabled and a sysreset-gpio is
provided in the TPL Device Tree, this will trigger a system reset
similar to what's currently been done in SPL whenever the RK3399 "warm"
boots. Because there's currently only one user of sysreset-gpio logic,
and TPL is enabled on that board, so let's migrate the logic and that
board to do it in TPL.

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
 arch/arm/mach-rockchip/rk3399/rk3399.c | 15 ++++++++++-----
 configs/puma-rk3399_defconfig          |  3 +++
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-rockchip/rk3399/rk3399.c b/arch/arm/mach-rockchip/rk3399/rk3399.c
index 7b6a822ed04b8151a5da147056dbf73ffdafd149..0c28241c603e343c5140322f2778678e95fa84fd 100644
--- a/arch/arm/mach-rockchip/rk3399/rk3399.c
+++ b/arch/arm/mach-rockchip/rk3399/rk3399.c
@@ -169,7 +169,8 @@ void board_debug_uart_init(void)
 }
 #endif
 
-#if defined(CONFIG_XPL_BUILD) && !defined(CONFIG_TPL_BUILD)
+#if defined(CONFIG_XPL_BUILD)
+#if defined(CONFIG_TPL_BUILD)
 static void rk3399_force_power_on_reset(void)
 {
 	const struct rockchip_cru *cru = rockchip_get_cru();
@@ -195,9 +196,9 @@ static void rk3399_force_power_on_reset(void)
 	if (cru->glb_rst_st == 0)
 		return;
 
-	if (!IS_ENABLED(CONFIG_SPL_GPIO)) {
+	if (!IS_ENABLED(CONFIG_TPL_GPIO)) {
 		debug("%s: trying to force a power-on reset but no GPIO "
-		      "support in SPL!\n", __func__);
+		      "support in TPL!\n", __func__);
 		return;
 	}
 
@@ -218,6 +219,11 @@ static void rk3399_force_power_on_reset(void)
 	dm_gpio_set_value(&sysreset_gpio, 1);
 }
 
+void tpl_board_init(void)
+{
+	rk3399_force_power_on_reset();
+}
+# else
 void __weak led_setup(void)
 {
 }
@@ -225,7 +231,6 @@ void __weak led_setup(void)
 void spl_board_init(void)
 {
 	led_setup();
-
-	rk3399_force_power_on_reset();
 }
 #endif
+#endif
diff --git a/configs/puma-rk3399_defconfig b/configs/puma-rk3399_defconfig
index 67c0ee72c925cdd49066980b0fde4131c86a99a8..7a180b1413036234d834773778f6c0f0a7e85380 100644
--- a/configs/puma-rk3399_defconfig
+++ b/configs/puma-rk3399_defconfig
@@ -30,6 +30,7 @@ CONFIG_SPL_I2C=y
 CONFIG_SPL_POWER=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_TPL=y
+CONFIG_TPL_GPIO=y
 # CONFIG_BOOTM_NETBSD is not set
 # CONFIG_BOOTM_PLAN9 is not set
 # CONFIG_BOOTM_RTEMS is not set
@@ -78,6 +79,8 @@ CONFIG_ETH_DESIGNWARE=y
 CONFIG_GMAC_ROCKCHIP=y
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
 CONFIG_PHY_ROCKCHIP_TYPEC=y
+CONFIG_TPL_PINCTRL=y
+CONFIG_TPL_PINCTRL_FULL=y
 CONFIG_DM_PMIC_FAN53555=y
 CONFIG_PMIC_RK8XX=y
 CONFIG_SPL_PMIC_RK8XX=y

-- 
2.47.0

