Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9430ACD3429
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 17:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50EB583D7A;
	Wed, 12 Nov 2025 18:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53CD683D7A; Wed, 12 Nov 2025 18:48:49 +0100 (CET)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::190b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263F783C62
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 18:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d69qy6HD3z6Yh;
 Wed, 12 Nov 2025 18:48:46 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d69qx6hzjzrqm; Wed, 12 Nov 2025 18:48:45 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Nov 2025 18:48:11 +0100
Subject: [PATCH 06/11] rockchip: rk3188: remove setup_led from xPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-led-old-dt-v1-6-2892d49517db@cherry.de>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
In-Reply-To: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
To: Ziping Chen <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Klaus Goger <klaus.goger@cherry.de>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Durai Manickam KR <durai.manickamkr@microchip.com>, 
 Stefan Roese <sr@denx.de>, Zixun LI <admin@hifiphile.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

There's not a single device making use of that code and it anyway
shouldn't be using the old deprecated u-boot,boot-led /config property
anymore but rather boot-led from /options/u-boot[1] Device Tree node.

Because spl_board_init() is only present to call this now removed
function, we can remove it as well as SPL_BOARD_INIT which is the symbol
guarding calls to spl_board_init() (which is now also removed).

[1] https://github.com/devicetree-org/dt-schema/blob/v2025.08/dtschema/schemas/options/u-boot.yaml#L113-L116
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/Kconfig         |  1 -
 arch/arm/mach-rockchip/rk3188/rk3188.c | 36 ----------------------------------
 2 files changed, 37 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 342933ca509..f78eaf52c2a 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -76,7 +76,6 @@ config ROCKCHIP_RK3128
 config ROCKCHIP_RK3188
 	bool "Support Rockchip RK3188"
 	select CPU_V7A
-	select SPL_BOARD_INIT if SPL
 	select SUPPORT_SPL
 	select SPL
 	select SPL_CLK
diff --git a/arch/arm/mach-rockchip/rk3188/rk3188.c b/arch/arm/mach-rockchip/rk3188/rk3188.c
index 7cce1112fbd..8aed46f0b3b 100644
--- a/arch/arm/mach-rockchip/rk3188/rk3188.c
+++ b/arch/arm/mach-rockchip/rk3188/rk3188.c
@@ -105,39 +105,3 @@ int rk_board_late_init(void)
 
 	return rk3188_board_late_init();
 }
-
-#ifdef CONFIG_XPL_BUILD
-static int setup_led(void)
-{
-#ifdef CONFIG_SPL_LED
-	struct udevice *dev;
-	char *led_name;
-	int ret;
-
-	led_name = ofnode_conf_read_str("u-boot,boot-led");
-	if (!led_name)
-		return 0;
-	ret = led_get_by_label(led_name, &dev);
-	if (ret) {
-		debug("%s: get=%d\n", __func__, ret);
-		return ret;
-	}
-	ret = led_set_state(dev, LEDST_ON);
-	if (ret)
-		return ret;
-#endif
-
-	return 0;
-}
-
-void spl_board_init(void)
-{
-	int ret;
-
-	ret = setup_led();
-	if (ret) {
-		debug("LED ret=%d\n", ret);
-		hang();
-	}
-}
-#endif

-- 
2.51.1

