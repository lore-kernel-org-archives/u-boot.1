Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F62E7C6FA
	for <u-boot@archiver.kernel.org>; Sat, 31 Jan 2026 23:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D12C83E13;
	Sun,  1 Feb 2026 00:39:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="IaSd80v7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A10A083B55; Sun,  1 Feb 2026 00:39:34 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C8F783DCB
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 00:39:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=19be=AF=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1769902770; bh=obX3Ga6vS9AL6CNuliVzOg5yTbKB5DAzQtlYu8i5aOM=;
 b=IaSd80v71TkzP8nF9Z/cLS510y89lExYpf0h0yQejADaAt9BpigJ5cUlOSRioONnmtj/D4I+l
 PvOffZ+oDdlnbBACCz52mQCxGLI6wuHWdMgVCJCS5YFHW/oeLWA830fYa0vO1aM7Mv/bbNEGbzy
 3MZHnODu4oCTl29TDnIRYwRytrTu49wpCVa0gX2rq4BBPCD40w7DGuF9jUCrd8f+qY9Qx+h464H
 VdnCO1N5CcWcSv71fN4q3E+3/1TwQHQ5sgiPt6dcF3E0CCoOoG9GdShWXJFCvJiheWqzKoXeSOK
 zfVn7lEd5dGvNl0/rp4NmL7p6GF0KFznwONetvLVqKng==
X-Forward-Email-ID: 697e92b0de426c19931e05d3
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.5.4
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Aaron Griffith <aargri@gmail.com>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v2 07/12] pinctrl: rockchip: Use
 syscon_regmap_lookup_by_phandle()
Date: Sat, 31 Jan 2026 23:38:18 +0000
Message-ID: <20260131233843.3419737-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131233843.3419737-1-jonas@kwiboo.se>
References: <20260131233843.3419737-1-jonas@kwiboo.se>
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

Use syscon_regmap_lookup_by_phandle() to simplify the code.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
v2: No change
---
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 39 ++++++-------------
 1 file changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 4de67aba1c34..273e356e7c02 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -10,6 +10,7 @@
 #include <syscon.h>
 #include <fdtdec.h>
 #include <linux/bitops.h>
+#include <linux/err.h>
 #include <linux/libfdt.h>
 
 #include "pinctrl-rockchip.h"
@@ -641,37 +642,21 @@ int rockchip_pinctrl_probe(struct udevice *dev)
 {
 	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
 	struct rockchip_pin_ctrl *ctrl;
-	struct udevice *syscon;
-	struct regmap *regmap;
-	int ret = 0;
 
-	/* get rockchip grf syscon phandle */
-	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "rockchip,grf",
-					   &syscon);
-	if (ret) {
-		debug("unable to find rockchip,grf syscon device (%d)\n", ret);
-		return ret;
+	priv->regmap_base =
+			syscon_regmap_lookup_by_phandle(dev, "rockchip,grf");
+	if (IS_ERR(priv->regmap_base)) {
+		debug("unable to find rockchip,grf regmap\n");
+		return PTR_ERR(priv->regmap_base);
 	}
 
-	/* get grf-reg base address */
-	regmap = syscon_get_regmap(syscon);
-	if (!regmap) {
-		debug("unable to find rockchip grf regmap\n");
-		return -ENODEV;
-	}
-	priv->regmap_base = regmap;
-
-	/* option: get pmu-reg base address */
-	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "rockchip,pmu",
-					   &syscon);
-	if (!ret) {
-		/* get pmugrf-reg base address */
-		regmap = syscon_get_regmap(syscon);
-		if (!regmap) {
-			debug("unable to find rockchip pmu regmap\n");
-			return -ENODEV;
+	if (dev_read_bool(dev, "rockchip,pmu")) {
+		priv->regmap_pmu =
+			syscon_regmap_lookup_by_phandle(dev, "rockchip,pmu");
+		if (IS_ERR(priv->regmap_pmu)) {
+			debug("unable to find rockchip,pmu regmap\n");
+			return PTR_ERR(priv->regmap_pmu);
 		}
-		priv->regmap_pmu = regmap;
 	}
 
 	ctrl = rockchip_pinctrl_get_soc_data(dev);
-- 
2.52.0

