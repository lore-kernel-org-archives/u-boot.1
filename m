Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9BE8CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 06:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5163F8465A;
	Tue, 19 May 2026 08:46:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Pi72HELk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67B0F846B0; Tue, 19 May 2026 08:46:05 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6EE0C84119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 08:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 2D701C2B9EA;
 Tue, 19 May 2026 06:46:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 10E46606E9;
 Tue, 19 May 2026 06:46:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 44C5711AF849A; 
 Tue, 19 May 2026 08:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1779173161; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=XXVxYBXWaJ+6SHfyeTSsCWy+ZeIfi1E6mYvD9lLPRU4=;
 b=Pi72HELktdvDrKba0VTHKeqanhllGA3uneN8vAmVCUom1ZseRsXVbIyVuPPi1nND5mQTsL
 zi+NYey/LIpQy3u6d42DEzPJw0xMFyEd9TSFq498OISrXvMd/ZMgqIaRVo4AVAmwTpyY72
 9iPZMsd7+hn0AD8AncWjev/gd4CEupPP8wN7FDg2pGElJuE1ykQXZGpI8IBgK7pLvkV7fS
 iswQtm0zudiEnCJwnD4vbJD4cTxzA5XkbfENbMLb/+AcIComujx47DuAvGxQLgIAY2ilIo
 CwUahgOYL0JrsAbHf6LjCxR56y5etKXgPOM0WMAE6qj5SboBfYMjcDb2h3q/oQ==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Tue, 19 May 2026 08:45:40 +0200
Subject: [PATCH 3/6] clk: ti: Remove AM33xx dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-omap4-support-v1-3-b4a2a7435775@bootlin.com>
References: <20260519-omap4-support-v1-0-b4a2a7435775@bootlin.com>
In-Reply-To: <20260519-omap4-support-v1-0-b4a2a7435775@bootlin.com>
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Daniel Palmer <daniel@thingy.jp>, Andrew Davis <afd@ti.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Charkov <alchark@gmail.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
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

The clock controller driven by this driver exists on other OMAP platforms
than the AM33xx. Yet, it uses functions provided by
arch/arm/mach-omap2/am33xx/clock.c making it unusable by other OMAPs.

Replace am33xx-specific do_{enable/disable}_clocks() with new static
functions implemented locally.
Replace the am33xx-specific clock header with the one shared by all OMAP
platforms.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/clk/ti/clk-ctrl.c | 48 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/ti/clk-ctrl.c b/drivers/clk/ti/clk-ctrl.c
index c5c97dc35c4..08f7410edce 100644
--- a/drivers/clk/ti/clk-ctrl.c
+++ b/drivers/clk/ti/clk-ctrl.c
@@ -8,7 +8,11 @@
 #include <dm.h>
 #include <dm/device_compat.h>
 #include <clk-uclass.h>
-#include <asm/arch-am33xx/clock.h>
+#include <asm/ti-common/omap_clock.h>
+#include <asm/io.h>
+#include <linux/iopoll.h>
+
+#define TRANSITION_TIMEOUT_US	10000
 
 struct clk_ti_ctrl_offs {
 	fdt_addr_t start;
@@ -33,10 +37,37 @@ static int clk_ti_ctrl_check_offs(struct clk *clk, fdt_addr_t offs)
 	return -EFAULT;
 }
 
+#define IDLEST_DISABLED		(MODULE_CLKCTRL_IDLEST_DISABLED << MODULE_CLKCTRL_IDLEST_SHIFT)
+#define IDLEST_TRANSITION	(MODULE_CLKCTRL_IDLEST_TRANSITIONING << MODULE_CLKCTRL_IDLEST_SHIFT)
+static int clk_ti_ctrl_disable_clock_module(u32 addr)
+{
+	int val;
+
+	clrsetbits_le32(addr, MODULE_CLKCTRL_MODULEMODE_MASK,
+			MODULE_CLKCTRL_MODULEMODE_SW_DISABLE <<
+			MODULE_CLKCTRL_MODULEMODE_SHIFT);
+
+	return readl_relaxed_poll_timeout(addr, val,
+					  (val & MODULE_CLKCTRL_IDLEST_MASK) == IDLEST_DISABLED,
+					  TRANSITION_TIMEOUT_US);
+}
+
+static int clk_ti_ctrl_enable_clock_module(u32 addr)
+{
+	int val;
+
+	clrsetbits_le32(addr, MODULE_CLKCTRL_MODULEMODE_MASK,
+			MODULE_CLKCTRL_MODULEMODE_SW_EXPLICIT_EN <<
+			MODULE_CLKCTRL_MODULEMODE_SHIFT);
+	return readl_relaxed_poll_timeout(addr, val,
+					  ((val & MODULE_CLKCTRL_IDLEST_MASK) != IDLEST_DISABLED) &&
+					  ((val & MODULE_CLKCTRL_IDLEST_MASK) != IDLEST_TRANSITION),
+					  TRANSITION_TIMEOUT_US);
+}
+
 static int clk_ti_ctrl_disable(struct clk *clk)
 {
 	struct clk_ti_ctrl_priv *priv = dev_get_priv(clk->dev);
-	u32 *clk_modules[2] = { };
 	fdt_addr_t offs;
 	int err;
 
@@ -47,16 +78,13 @@ static int clk_ti_ctrl_disable(struct clk *clk)
 		return err;
 	}
 
-	clk_modules[0] = (u32 *)(offs);
-	dev_dbg(clk->dev, "disable module @ %p\n", clk_modules[0]);
-	do_disable_clocks(NULL, clk_modules, 1);
-	return 0;
+	dev_dbg(clk->dev, "disable module @ %x\n", offs);
+	return clk_ti_ctrl_disable_clock_module(offs);
 }
 
 static int clk_ti_ctrl_enable(struct clk *clk)
 {
 	struct clk_ti_ctrl_priv *priv = dev_get_priv(clk->dev);
-	u32 *clk_modules[2] = { };
 	fdt_addr_t offs;
 	int err;
 
@@ -67,10 +95,8 @@ static int clk_ti_ctrl_enable(struct clk *clk)
 		return err;
 	}
 
-	clk_modules[0] = (u32 *)(offs);
-	dev_dbg(clk->dev, "enable module @ %p\n", clk_modules[0]);
-	do_enable_clocks(NULL, clk_modules, 1);
-	return 0;
+	dev_dbg(clk->dev, "enable module @ %x\n", offs);
+	return clk_ti_ctrl_enable_clock_module(offs);
 }
 
 static ulong clk_ti_ctrl_get_rate(struct clk *clk)

-- 
2.54.0

