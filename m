Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A83FDC3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 15:53:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 082F188BB4;
	Wed,  7 Aug 2024 17:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723046030;
	bh=8uxedCwO/81tjOD8aKAu0RSscFAi4dviwIr7RLcI6uY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R155V/1gTq9U8N9yIPJUDhGMHLKyBFgL6ysP95eozJA5zRN/bZU6KHstOVIZgCSsw
	 GrMv18rSEg9+D1dGNltFc0ahxaKtxTP2KMdyX6vIq9MjjmqwKSuOJtjvIsFjx4uwRS
	 D56rj5HV7+pgeZ02+fN/WzipTcaqcuW4JUlrcaHsv24xAgyzL0M98juVPm39iEk7zL
	 fewbejJOYFHpxLlttpNVcufOx5+NKiGUFRlJAdohVbmqv+BxiiNPg7nE1Y2W4kvUFD
	 qjJCm72ytnF7XGeNrCt0rKp3NvMR4yUphwQmCXOD005wfAMo1jlgJvZ98r/KKNMlsE
	 pdJ7aIDKfaadA==
Received: from localhost.localdomain (82-131-232-44.pool.digikabel.hu
 [82.131.232.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3085B88AD3;
 Wed,  7 Aug 2024 17:53:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723046028;
 bh=8uxedCwO/81tjOD8aKAu0RSscFAi4dviwIr7RLcI6uY=;
 h=From:To:Cc:Subject:Date:From;
 b=YzwRyB4kebU6HeOe1sJT3H9AUSo0C+uQZzLFTileP7N15KCtNh+ApRClzMstFBf0W
 cPAe+dAmjNkIuO4QxI+8wK5OSfsUyzgJTtHqQeWFCDYbYdF1uIqNDbtor0TgsnnLQZ
 viH2EX2w/kfzxq/fUUQTS6n4PTQseEQwV38byCcbgEw163V68FMQ+oO2E6NN00EQ16
 AYx/OUxNegx1CgBuTQW2axW6uNKbGWSCsYgwm/q88uNxPgOPbrxJimZLk1v63T8h+j
 zsjhPpvys8eyhSFtmMRDJ5RvIo+DwZgGz+yLTBaQ3Co14EA+M8T7SxA18/XiCFfGGR
 9mD739imEZ45Q==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Subject: [PATCH v2] driver: pwm: pwm-imx: fix probing on imx6
Date: Wed,  7 Aug 2024 17:53:43 +0200
Message-Id: <20240807155343.122377-1-hs@denx.de>
X-Mailer: git-send-email 2.20.1
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

Signed-off-by: Heiko Schocher <hs@denx.de>
---

Changes in v2:
use CONFIG_IS_ENABLED instead of IS_ENABLED
as Anatolij suggested.

 drivers/pwm/pwm-imx.c | 56 ++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-imx.c b/drivers/pwm/pwm-imx.c
index 8fbb40cc276..e69684b2167 100644
--- a/drivers/pwm/pwm-imx.c
+++ b/drivers/pwm/pwm-imx.c
@@ -160,7 +160,11 @@ int pwm_dm_imx_get_parms(struct imx_pwm_priv *priv, int period_ns,
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
@@ -227,43 +231,45 @@ static int imx_pwm_set_enable(struct udevice *dev, uint channel, bool enable)
 
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
-	}
-
-	ret = clk_enable(&priv->ipg_clk);
-	if (ret) {
-		printf("Failed to enable ipg_clk\n");
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
 	return 0;
 }
 
-- 
2.20.1

