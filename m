Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA15E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 22:10:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE83180209;
	Thu, 12 Dec 2024 23:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VfSVVXKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 615EC801A0; Thu, 12 Dec 2024 23:10:20 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7E7B801DA
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 23:10:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=e29f=TG=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1734041415; bh=Tjwis2tu5frGmjIxtLW1ovZUsN9+MDUV+U5KLWPj6NU=;
 b=VfSVVXKemupwt1ryo1EfSAoiNqx2p3DmRfe1SAXpI0tDbk0XXg1T/nlP6ACQlI31THd7qCp8F
 CnQv0lfrwVyqKk5i7RXks3uBzJh4WhMtRdhF7Qhms0OJnKQhu5XrCJ05Tm14Q+OhxZc/iyL7XON
 0i9u9qeca1uOhvgoVYd3Kbj4SfllmZS0fteWyl58Ab7dhAfSzXxxc3q6hsOJpy5kF9Xhuaku7N9
 /wM5SaExpNElnxi3aAv78E5+Cbf8kaQUxBC8sgSB3XvdQSqxbbDNEbUXP7oPC8CUrqEPGEfYgAX
 6980UjPtd6VNHAC8X++iB/IoKVoOUuCk2UUkrHypoPzA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 01/11] rockchip: rk3288-firefly: Drop unused SPL_LED related
 code
Date: Thu, 12 Dec 2024 22:09:34 +0000
Message-ID: <20241212221000.94501-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212221000.94501-1-jonas@kwiboo.se>
References: <20241212221000.94501-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 675b5f43a511ed8f0b3fc7e7
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

The firefly-rk3288_defconfig build target does not enable the SPL_LED
Kconfig option.

Drop the unused SPL_LED related code and replace it with a default-state
prop to ensure the LED driver enable the LED at U-Boot proper phase.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 arch/arm/dts/rk3288-firefly-u-boot.dtsi       | 17 +------
 arch/arm/mach-rockchip/rk3288/Kconfig         |  1 -
 board/firefly/firefly-rk3288/Makefile         |  7 ---
 board/firefly/firefly-rk3288/firefly-rk3288.c | 46 -------------------
 4 files changed, 1 insertion(+), 70 deletions(-)
 delete mode 100644 board/firefly/firefly-rk3288/Makefile
 delete mode 100644 board/firefly/firefly-rk3288/firefly-rk3288.c

diff --git a/arch/arm/dts/rk3288-firefly-u-boot.dtsi b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
index 644198a4a2fb..30b471900b30 100644
--- a/arch/arm/dts/rk3288-firefly-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-firefly-u-boot.dtsi
@@ -6,20 +6,9 @@
 #include "rk3288-u-boot.dtsi"
 
 / {
-	config {
-		bootph-all;
-		u-boot,boot-led = "firefly:green:power";
-	};
-
 	leds {
-		bootph-all;
-
-		work {
-			bootph-all;
-		};
-
 		power {
-			bootph-all;
+			default-state = "on";
 		};
 	};
 };
@@ -56,10 +45,6 @@
 	bootph-all;
 };
 
-&gpio8 {
-	bootph-all;
-};
-
 &pcfg_pull_up_drv_12ma {
 	bootph-pre-ram;
 };
diff --git a/arch/arm/mach-rockchip/rk3288/Kconfig b/arch/arm/mach-rockchip/rk3288/Kconfig
index ff16d258b4f5..9cc97bacc41d 100644
--- a/arch/arm/mach-rockchip/rk3288/Kconfig
+++ b/arch/arm/mach-rockchip/rk3288/Kconfig
@@ -75,7 +75,6 @@ config TARGET_FENNEC_RK3288
 config TARGET_FIREFLY_RK3288
 	bool "Firefly-RK3288"
 	select BOARD_LATE_INIT
-	select SPL_BOARD_INIT if SPL
 	select TPL
 	help
 	  Firefly is a RK3288-based development board with 2 USB ports,
diff --git a/board/firefly/firefly-rk3288/Makefile b/board/firefly/firefly-rk3288/Makefile
deleted file mode 100644
index 671684597d23..000000000000
--- a/board/firefly/firefly-rk3288/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# (C) Copyright 2015 Google, Inc
-#
-# SPDX-License-Identifier:     GPL-2.0+
-#
-
-obj-y	+= firefly-rk3288.o
diff --git a/board/firefly/firefly-rk3288/firefly-rk3288.c b/board/firefly/firefly-rk3288/firefly-rk3288.c
deleted file mode 100644
index c65ce5890e52..000000000000
--- a/board/firefly/firefly-rk3288/firefly-rk3288.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * (C) Copyright 2015 Google, Inc
- */
-
-#include <hang.h>
-#include <led.h>
-#include <log.h>
-#include <asm/global_data.h>
-#include <dm/ofnode.h>
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
2.47.1

