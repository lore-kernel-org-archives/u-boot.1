Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5322C52D7B
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 12:10:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6757A88967;
	Wed, 14 Aug 2024 14:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723637434;
	bh=rDwSTL/hj+UiJLsRsBnvqQQuJW/X8Lfhry/vdPSSNj8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=x2ya5Drmt/kC5cEIH366o9b75uOQEOwHPIpvrCZws9qMCeLA4RxCe2yJ/BKqhpXdp
	 zbeAZYv2yidpk22hWOsD13icAUmxebNBlPAXac3zWbVVZohw33zcgLT3APd2D7e0H4
	 +QqisALC5gylLcwNbVjGY6T4NS0XjWa9ZlcBna4auD9hAGPuyliSbAyFtrO37PVaEm
	 mHxJe7tQb9Rqvk1miol/rLrbILfEWClOCDNmgndpt8PaK6MP9+1WhyycKjAe4aJcjJ
	 y4VC6jsb74tPMupW6HVn/VUz80jNgZGNmmGWJwkGMguRR1hMD6xwnemsTP4Ni86IFt
	 nZjkHhnrwTpFg==
Received: from mail-internal.denx.de (p578adb1c.dip0.t-ipconnect.de
 [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: noc@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0EA3A885FA
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 14:10:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723637433;
 bh=rDwSTL/hj+UiJLsRsBnvqQQuJW/X8Lfhry/vdPSSNj8=;
 h=From:To:Cc:Subject:Date:From;
 b=nC/u9qyWjyWUZHTIt6Woa9keXFNEVrdT8Fp9GpisKrP2/LVv5AW0eRYx07WKPAFAh
 MSuWZGc/D63oZpaB4M3NKs2zxqOfIcRbW0x8YR7G6hnJRC5AL5by/zm1VoBEq3FPGB
 jdK9cLDbURirTi+9kKZ6OuyIawQxlIr+V7p5xa17M1+wkePr803GprG4WQ44+SW5LT
 Xvd3LDfnK5OTL3ZVmOzRl5DmDgMaHI4CQpoU+UcDBoJeiMC6PmD9cAmY5AJb0Si5TP
 abY5/7jqxt9xeFtZVeRjas89l5WTbhwrj2YD3eFX1j+wJYSNQvUB89KUtC3A8KfeBd
 jaTVee6+SYxfA==
Received: from pollux.denx.de (pollux [192.168.1.1])
 by mail-internal.denx.de (Postfix) with ESMTPS id 4EB3A180A94;
 Wed, 14 Aug 2024 14:10:29 +0200 (CEST)
Received: by pollux.denx.de (Postfix, from userid 515)
 id 202431A008B; Wed, 14 Aug 2024 14:10:29 +0200 (CEST)
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Subject: [PATCH v3] driver: pwm: pwm-imx: fix probing on imx6
Date: Wed, 14 Aug 2024 14:10:27 +0200
Message-Id: <20240814121027.3477977-1-hs@denx.de>
X-Mailer: git-send-email 2.37.3
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

U-Boot 2024.07 drops on aristainetos2 board the following
warning:

	Failed to enable per_clk

and bootlogo is not seen on LVDS display.

This patch uses old behaviour for systems without clock framework
if CONFIG_CLK is not enabled.

Fixes: bfc778cb93a3 ("driver: pwm: pwm-imx: get and enable per/ipg clock using dm")
Fixes: 4eea76574062 ("pwm: imx: Remove unused references to CONFIG_IMX6_PWM_PER_CLK")

Signed-off-by: Heiko Schocher <hs@denx.de>
---

Changes in v3:
add a default value for CFG_IMX6_PWM_PER_CLK
as Fabio suggested
add Fixes line for commit 4eea76574062

azure build:
https://dev.azure.com/hs0298/hs/_build/results?buildId=123&view=results

Changes in v2:
use CONFIG_IS_ENABLED instead of IS_ENABLED
as Anatolij suggested.

 drivers/pwm/pwm-imx.c | 60 +++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 320ea7c423..d285730694 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -14,6 +14,10 @@
 #include <asm/io.h>
 #include <clk.h>
 
+#if !defined(CFG_IMX6_PWM_PER_CLK)
+#define CFG_IMX6_PWM_PER_CLK	66000000
+#endif
+
 int pwm_config_internal(struct pwm_regs *pwm, unsigned long period_cycles,
 			unsigned long duty_cycles, unsigned long prescale)
 {
@@ -159,7 +163,11 @@ int pwm_dm_imx_get_parms(struct imx_pwm_priv *priv, int period_ns,
 {
 	unsigned long long c;
 
-	c = clk_get_rate(&priv->per_clk);
+	if (CONFIG_IS_ENABLED(CLK))
+		c = clk_get_rate(&priv->per_clk);
+	else
+		c = CFG_IMX6_PWM_PER_CLK;
+
 	c = c * period_ns;
 	do_div(c, 1000000000);
 	*period_c = c;
@@ -226,43 +234,45 @@ static int imx_pwm_set_enable(struct udevice *dev, uint channel, bool enable)
 
 static int imx_pwm_of_to_plat(struct udevice *dev)
 {
-	int ret;
+	int __maybe_unused ret;
 	struct imx_pwm_priv *priv = dev_get_priv(dev);
 
 	priv->regs = dev_read_addr_ptr(dev);
 
-	ret = clk_get_by_name(dev, "per", &priv->per_clk);
-	if (ret) {
-		printf("Failed to get per_clk\n");
-		return ret;
-	}
-
-	ret = clk_get_by_name(dev, "ipg", &priv->ipg_clk);
-	if (ret) {
-		printf("Failed to get ipg_clk\n");
-		return ret;
+	if (CONFIG_IS_ENABLED(CLK)) {
+		ret = clk_get_by_name(dev, "per", &priv->per_clk);
+		if (ret) {
+			printf("Failed to get per_clk\n");
+			return ret;
+		}
+
+		ret = clk_get_by_name(dev, "ipg", &priv->ipg_clk);
+		if (ret) {
+			printf("Failed to get ipg_clk\n");
+			return ret;
+		}
 	}
-
 	return 0;
 }
 
 static int imx_pwm_probe(struct udevice *dev)
 {
-	int ret;
+	int __maybe_unused ret;
 	struct imx_pwm_priv *priv = dev_get_priv(dev);
 
-	ret = clk_enable(&priv->per_clk);
-	if (ret) {
-		printf("Failed to enable per_clk\n");
-		return ret;
+	if (CONFIG_IS_ENABLED(CLK)) {
+		ret = clk_enable(&priv->per_clk);
+		if (ret) {
+			printf("Failed to enable per_clk\n");
+			return ret;
+		}
+
+		ret = clk_enable(&priv->ipg_clk);
+		if (ret) {
+			printf("Failed to enable ipg_clk\n");
+			return ret;
+		}
 	}
-
-	ret = clk_enable(&priv->ipg_clk);
-	if (ret) {
-		printf("Failed to enable ipg_clk\n");
-		return ret;
-	}
-
 	return 0;
 }
 
-- 
2.37.3

