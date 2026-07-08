Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80D6C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 08:38:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA24080433;
	Wed,  8 Jul 2026 10:38:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SldjkJcR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE72F838D7; Wed,  8 Jul 2026 10:38:14 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFDEB80087
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 10:38:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bastien.curutchet@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 3C5DFC8F445;
 Wed,  8 Jul 2026 08:38:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 5E39860337;
 Wed,  8 Jul 2026 08:38:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5E84D11BC32D2; 
 Wed,  8 Jul 2026 10:38:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1783499891; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=a9opJ1AkN5+xz90BiSfXm/20Ka6hnDwimoy+bEWgcqA=;
 b=SldjkJcRvSIl+DXWzs8+l5JTXV0LJjLkEunCt7ykjcSbXUmBluN6Y0bT46O+rOAUnGiUkr
 q418japbWDVoxqxMDIm+QLAqCG6x3rcVg/WXnpQOnU2NIArFsITk763dGAYg0NQGvvif4Q
 9LzSWfTj05t1mFPh09sB2TYTGIMEFoApRLnazINEIJ8Z6PYjxFZwQnxS0tpwZDiAEC9kTI
 DCeybegWASA5sRBHKuhcWhBfU6Ws7lqVwX8nT4RBrNKBX2CLoNp8Ck3zhzq2cYsqu0YhA2
 vLrDcp8ZHUZ/fl61wTmEyae7QIVPAg/5uNsE9sHlrlPz2PmA+YyjjDnltyVx8w==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Wed, 08 Jul 2026 10:38:10 +0200
Subject: [PATCH] clk: ti: Use CPU ticks to count timeout
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-fix-beagle-v1-1-c9b5393e6d23@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwML3bTMCt2k1MT0nFRdM7NE42SLpMRkc1NTJaCGgqJUoCzYsOjY2lo
 AShp6mVwAAAA=
X-Change-ID: 20260708-fix-beagle-66a3c8bac755
To: u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
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

readl_relaxed_poll_timeout() relies on timers. On the beaglebone black,
the timer used by readl_relaxed_poll_timeout() depends on this clock
driver. So we have a sort of circular dependency [enable_clock ->
timer_init -> enable_clock -> timer_init]. It leads to a
division-per-zero during the second timer_init() and the beaglebone
fails to boot with following message:
| CPU  : AM335X-GP rev 2.1
| Model: TI AM335x BeagleBone Black
| DRAM:  512 MiB
| ### ERROR ### Please RESET the board ###

Replace readl_relaxed_poll_timeout() with a simple loop that uses CPU
ticks to countdown the timeout. This loop and the value of LDELAY are
inspired from what's done in arch/arm/mach-omap2/am33xx/clock.c
Also, arch/arm/mach-omap2/am33xx/clock.c doesn't return an error on
timeout, it only logs it, so let's stick with it.

Fixes: de2e3f00f2fa ("clk: ti: Remove AM33xx dependency")
Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/clk/ti/clk-ctrl.c | 53 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/ti/clk-ctrl.c b/drivers/clk/ti/clk-ctrl.c
index 08f7410edce..e3564277982 100644
--- a/drivers/clk/ti/clk-ctrl.c
+++ b/drivers/clk/ti/clk-ctrl.c
@@ -12,7 +12,7 @@
 #include <asm/io.h>
 #include <linux/iopoll.h>
 
-#define TRANSITION_TIMEOUT_US	10000
+#define LDELAY	1000000
 
 struct clk_ti_ctrl_offs {
 	fdt_addr_t start;
@@ -39,30 +39,59 @@ static int clk_ti_ctrl_check_offs(struct clk *clk, fdt_addr_t offs)
 
 #define IDLEST_DISABLED		(MODULE_CLKCTRL_IDLEST_DISABLED << MODULE_CLKCTRL_IDLEST_SHIFT)
 #define IDLEST_TRANSITION	(MODULE_CLKCTRL_IDLEST_TRANSITIONING << MODULE_CLKCTRL_IDLEST_SHIFT)
-static int clk_ti_ctrl_disable_clock_module(u32 addr)
+static inline void wait_for_clk_disable(u32 addr)
 {
-	int val;
+	u32 bound = LDELAY;
+	int val = 0;
+
+	while ((val & MODULE_CLKCTRL_IDLEST_MASK) != IDLEST_DISABLED) {
+		val = readl(addr);
+
+		if (--bound == 0) {
+			printf("Clock disable failed for 0x%x idlest 0x%x\n",
+			       addr, val);
+			return;
+		}
+	}
+}
 
+static int clk_ti_ctrl_disable_clock_module(u32 addr)
+{
 	clrsetbits_le32(addr, MODULE_CLKCTRL_MODULEMODE_MASK,
 			MODULE_CLKCTRL_MODULEMODE_SW_DISABLE <<
 			MODULE_CLKCTRL_MODULEMODE_SHIFT);
 
-	return readl_relaxed_poll_timeout(addr, val,
-					  (val & MODULE_CLKCTRL_IDLEST_MASK) == IDLEST_DISABLED,
-					  TRANSITION_TIMEOUT_US);
+	wait_for_clk_disable(addr);
+
+	return 0;
 }
 
-static int clk_ti_ctrl_enable_clock_module(u32 addr)
+static inline void wait_for_clk_enable(u32 addr)
 {
-	int val;
+	int val = IDLEST_DISABLED;
+	u32 bound = LDELAY;
 
+	while (((val & MODULE_CLKCTRL_IDLEST_MASK) == IDLEST_DISABLED) ||
+	       ((val & MODULE_CLKCTRL_IDLEST_MASK) == IDLEST_TRANSITION)) {
+		val = readl(addr);
+
+		if (--bound == 0) {
+			printf("Clock enable failed for 0x%x idlest 0x%x\n",
+			       addr, val);
+			return;
+		}
+	}
+}
+
+static int clk_ti_ctrl_enable_clock_module(u32 addr)
+{
 	clrsetbits_le32(addr, MODULE_CLKCTRL_MODULEMODE_MASK,
 			MODULE_CLKCTRL_MODULEMODE_SW_EXPLICIT_EN <<
 			MODULE_CLKCTRL_MODULEMODE_SHIFT);
-	return readl_relaxed_poll_timeout(addr, val,
-					  ((val & MODULE_CLKCTRL_IDLEST_MASK) != IDLEST_DISABLED) &&
-					  ((val & MODULE_CLKCTRL_IDLEST_MASK) != IDLEST_TRANSITION),
-					  TRANSITION_TIMEOUT_US);
+
+	wait_for_clk_enable(addr);
+
+	return 0;
 }
 
 static int clk_ti_ctrl_disable(struct clk *clk)

---
base-commit: ee5d46b45ec0c63f8f9dd1e816e0dac3452ccc3d
change-id: 20260708-fix-beagle-66a3c8bac755

Best regards,
-- 
Bastien Curutchet <bastien.curutchet@bootlin.com>

