Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BB9CD1292
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 18:17:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 482BC8810D;
	Mon,  8 Apr 2024 20:16:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="LLE/apal";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9830D88103; Mon,  8 Apr 2024 20:16:00 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9983388118
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 20:15:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=0d79=LO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1712600124; bh=Dut9AR5iwNneSlyPAIskY/2HLjjymzucxfOHkybsmbY=;
 b=LLE/apalxe5aoVVezBv/RSccIRkVXvT8JUR2OmtkiYsfI6rAymysSbQgFj+7Nr+js42jaVFQB
 6Br+3yC8zn4iohYtEqXebobBCAtVcEa+nWvE+JJ6Weu9o80+NnpSD5dKbavBzi05/YG89uEd0YX
 +ESepQq6VRDbuHbvSp5iFCQQBddUZZUm4jq7bQnXWd5AmplytkboES+nNXtQxX4WfdwG32r8p4l
 0AoGzVw7kWtBDbbalJKvpBtPqpfnpf2AcyVWK994BwqPnEBn8IuO/36fzJsnwSoqRSH657ob5h1
 JlakAN5G0lMSVqm6d1nctWzbbLDFw6X8kbzedZODW0IA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Andy Yan <andy.yan@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Akash Gajjar <gajjar04akash@gmail.com>, u-boot@lists.denx.de, Jonas
 Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 14/14] rockchip: rk3308: Move cru and grf include files to
 arch-rockchip
Date: Mon,  8 Apr 2024 18:14:11 +0000
Message-ID: <20240408181429.3676856-15-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240408181429.3676856-1-jonas@kwiboo.se>
References: <20240408181429.3676856-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6614343b45fff4c2aa5b4afb
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

Move cru_rk3308.h and grf_rk3308.h to arch-rockchip to match path used
for all other Rockchip SoCs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch
---
 .../arm/include/asm/{arch-rk3308 => arch-rockchip}/cru_rk3308.h | 0
 .../arm/include/asm/{arch-rk3308 => arch-rockchip}/grf_rk3308.h | 0
 arch/arm/mach-rockchip/rk3308/clk_rk3308.c                      | 2 +-
 arch/arm/mach-rockchip/rk3308/rk3308.c                          | 2 +-
 board/firefly/firefly-rk3308/roc_cc_rk3308.c                    | 2 +-
 drivers/clk/rockchip/clk_rk3308.c                               | 2 +-
 drivers/net/gmac_rockchip.c                                     | 2 +-
 drivers/ram/rockchip/sdram_rk3308.c                             | 2 +-
 8 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/arm/include/asm/{arch-rk3308 => arch-rockchip}/cru_rk3308.h (100%)
 rename arch/arm/include/asm/{arch-rk3308 => arch-rockchip}/grf_rk3308.h (100%)

diff --git a/arch/arm/include/asm/arch-rk3308/cru_rk3308.h b/arch/arm/include/asm/arch-rockchip/cru_rk3308.h
similarity index 100%
rename from arch/arm/include/asm/arch-rk3308/cru_rk3308.h
rename to arch/arm/include/asm/arch-rockchip/cru_rk3308.h
diff --git a/arch/arm/include/asm/arch-rk3308/grf_rk3308.h b/arch/arm/include/asm/arch-rockchip/grf_rk3308.h
similarity index 100%
rename from arch/arm/include/asm/arch-rk3308/grf_rk3308.h
rename to arch/arm/include/asm/arch-rockchip/grf_rk3308.h
diff --git a/arch/arm/mach-rockchip/rk3308/clk_rk3308.c b/arch/arm/mach-rockchip/rk3308/clk_rk3308.c
index ccda53380c6f..201bf661f9bb 100644
--- a/arch/arm/mach-rockchip/rk3308/clk_rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/clk_rk3308.c
@@ -7,7 +7,7 @@
 #include <dm.h>
 #include <syscon.h>
 #include <asm/arch-rockchip/clock.h>
-#include <asm/arch/cru_rk3308.h>
+#include <asm/arch-rockchip/cru_rk3308.h>
 #include <linux/err.h>
 
 int rockchip_get_clk(struct udevice **devp)
diff --git a/arch/arm/mach-rockchip/rk3308/rk3308.c b/arch/arm/mach-rockchip/rk3308/rk3308.c
index b3ffabc5449a..a0915c72bfa0 100644
--- a/arch/arm/mach-rockchip/rk3308/rk3308.c
+++ b/arch/arm/mach-rockchip/rk3308/rk3308.c
@@ -5,8 +5,8 @@
 #include <common.h>
 #include <init.h>
 #include <malloc.h>
-#include <asm/arch/grf_rk3308.h>
 #include <asm/arch-rockchip/bootrom.h>
+#include <asm/arch-rockchip/grf_rk3308.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <asm/gpio.h>
 #include <debug_uart.h>
diff --git a/board/firefly/firefly-rk3308/roc_cc_rk3308.c b/board/firefly/firefly-rk3308/roc_cc_rk3308.c
index 99a52a77116a..af00250e118d 100644
--- a/board/firefly/firefly-rk3308/roc_cc_rk3308.c
+++ b/board/firefly/firefly-rk3308/roc_cc_rk3308.c
@@ -5,7 +5,7 @@
 
 #include <common.h>
 #include <adc.h>
-#include <asm/arch/grf_rk3308.h>
+#include <asm/arch-rockchip/grf_rk3308.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/bitops.h>
 
diff --git a/drivers/clk/rockchip/clk_rk3308.c b/drivers/clk/rockchip/clk_rk3308.c
index c46b58e31626..861648321d40 100644
--- a/drivers/clk/rockchip/clk_rk3308.c
+++ b/drivers/clk/rockchip/clk_rk3308.c
@@ -12,8 +12,8 @@
 #include <malloc.h>
 #include <syscon.h>
 #include <asm/global_data.h>
-#include <asm/arch/cru_rk3308.h>
 #include <asm/arch-rockchip/clock.h>
+#include <asm/arch-rockchip/cru_rk3308.h>
 #include <asm/arch-rockchip/hardware.h>
 #include <dm/device-internal.h>
 #include <dm/lists.h>
diff --git a/drivers/net/gmac_rockchip.c b/drivers/net/gmac_rockchip.c
index 33fc36da5077..51f835adabc3 100644
--- a/drivers/net/gmac_rockchip.c
+++ b/drivers/net/gmac_rockchip.c
@@ -19,7 +19,7 @@
 #include <asm/arch-rockchip/grf_px30.h>
 #include <asm/arch-rockchip/grf_rk322x.h>
 #include <asm/arch-rockchip/grf_rk3288.h>
-#include <asm/arch-rk3308/grf_rk3308.h>
+#include <asm/arch-rockchip/grf_rk3308.h>
 #include <asm/arch-rockchip/grf_rk3328.h>
 #include <asm/arch-rockchip/grf_rk3368.h>
 #include <asm/arch-rockchip/grf_rk3399.h>
diff --git a/drivers/ram/rockchip/sdram_rk3308.c b/drivers/ram/rockchip/sdram_rk3308.c
index 10828e80822a..264366291cf8 100644
--- a/drivers/ram/rockchip/sdram_rk3308.c
+++ b/drivers/ram/rockchip/sdram_rk3308.c
@@ -7,8 +7,8 @@
 #include <dm.h>
 #include <ram.h>
 #include <syscon.h>
-#include <asm/arch/grf_rk3308.h>
 #include <asm/arch-rockchip/clock.h>
+#include <asm/arch-rockchip/grf_rk3308.h>
 #include <asm/arch-rockchip/sdram.h>
 
 struct dram_info {
-- 
2.43.2

