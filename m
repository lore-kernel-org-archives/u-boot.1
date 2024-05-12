Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92DAC25B5F
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 12:18:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1DEA88345;
	Sun, 12 May 2024 14:17:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="iSXS1Lm2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8F5688087; Sun, 12 May 2024 14:17:46 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D3ED88272
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 14:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bf9f=MQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1715516220; bh=W+dcisoxnCvbAMomMycQ/fyjh6tWLUzJUtd2hdn/djI=;
 b=iSXS1Lm2su+LTO0D7gt9E47SIU6KU5ntHlw7QkYgXGOwpu6HVbBjuecTgFBXBc6lf3d8SwQFt
 oGVnLIQscPaFQ86eoJYAGnAmDcFxkMIyBWzNtzlMlkOLMtsPEvBSmm/UWLOW9DLUz1L6Z17wbjp
 hAcrjzY/6Exo4dxLay6wkPNd8RXKtiWPvGpqmXmkA9mxkIvuaiRmEcnRVubWAxnK+prHXNMhZ62
 gZcFWgdxoLsOvzyJ5srM1wBS851O45hC0g00EIYymvyFQkxiFllCUuHzEOMsndiBrqzSEwNZuD6
 fiVI9rhjzlc7JAtdtCTYAJNXJ7kIcDC98v9SXJnTHHig==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>, Mark
 Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 2/9] pinctrl: rockchip: rv1126: Fix support for
 IOMUX_L_SOURCE_PMU flag
Date: Sun, 12 May 2024 12:16:15 +0000
Message-ID: <20240512121633.1632597-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240512121633.1632597-1-jonas@kwiboo.se>
References: <20240512121633.1632597-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 167.172.40.54
X-ForwardEmail-ID: 6640b3301cfb9f69e9a4effa
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

GPIO0_C0-C4 iomux is set using PMUGRF_GPIO0C_IOMUX_L reg on RV1126. This
is indicated using the IOMUX_L_SOURCE_PMU flag. Fix reading current mux
by fully adopting the IOMUX_L_SOURCE_PMU related code in Linux kernel.

Based on Linux commit fd4ea48688c6 ("pinctrl: rockchip: Add RV1126
pinctrl support").

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index b6e2ab474d0f..973e6a4f6db9 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -132,8 +132,12 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY)
 		return RK_FUNC_GPIO;
 
-	regmap = (bank->iomux[iomux_num].type & IOMUX_SOURCE_PMU)
-				? priv->regmap_pmu : priv->regmap_base;
+	if (bank->iomux[iomux_num].type & IOMUX_SOURCE_PMU)
+		regmap = priv->regmap_pmu;
+	else if (bank->iomux[iomux_num].type & IOMUX_L_SOURCE_PMU)
+		regmap = (pin % 8 < 4) ? priv->regmap_pmu : priv->regmap_base;
+	else
+		regmap = priv->regmap_base;
 
 	/* get basic quadrupel of mux registers and the correct reg inside */
 	mux_type = bank->iomux[iomux_num].type;
@@ -563,12 +567,14 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(struct udevice *d
 
 			/* preset iomux offset value, set new start value */
 			if (iom->offset >= 0) {
-				if (iom->type & IOMUX_SOURCE_PMU)
+				if ((iom->type & IOMUX_SOURCE_PMU) ||
+				    (iom->type & IOMUX_L_SOURCE_PMU))
 					pmu_offs = iom->offset;
 				else
 					grf_offs = iom->offset;
 			} else { /* set current iomux offset */
-				iom->offset = (iom->type & IOMUX_SOURCE_PMU) ?
+				iom->offset = ((iom->type & IOMUX_SOURCE_PMU) ||
+					       (iom->type & IOMUX_L_SOURCE_PMU)) ?
 							pmu_offs : grf_offs;
 			}
 
-- 
2.43.2

