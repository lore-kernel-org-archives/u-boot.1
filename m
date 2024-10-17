Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384C2D3C530
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 20:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BFE3890DF;
	Thu, 17 Oct 2024 22:01:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="VVq+qhjP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C47C890CA; Thu, 17 Oct 2024 22:01:22 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD20B890BC
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 22:01:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=a54c=RO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1729195273; bh=N/AAMJD/rfKYf4x+NYmrCcfKX/i1FTbj9wFkA7D24ZE=;
 b=VVq+qhjPlgXGqbEsOOQhMe3G/rSOdMWacURCKKdnghOviszgQMACHyqTWs0cfcpLV+2Tp/7Dc
 RzkqE0NinivFnAdnDxU9cPpK7eDQMct81TOZ6ufphmZd9ZsouUgH2qOIAjtCj2JwsRloTnqBUnk
 9W68bN5BatSbzT+KUAdHAM4qDOaatts/IMkYSKQTyWut38KZq5E1vZTvUKhEJbY2NGXjnpQuInL
 tTI5Z1x53gVxbTIP7oAqplqnGGJmzYY3NYyZkZoWl11rAIc8R8y1q+eYcUbk3lPRdDn4BMq+tLA
 A85h5fJU1IoYANrpuxGjFMFFRBUtrnwPXI578KP5OXNg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, John Clark <inindev@gmail.com>,
 Tom Rini <trini@konsulko.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 7/8] adc: rockchip-saradc: Use vdd-microvolts prop as fallback
Date: Thu, 17 Oct 2024 20:00:26 +0000
Message-ID: <20241017200039.1235524-8-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017200039.1235524-1-jonas@kwiboo.se>
References: <20241017200039.1235524-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 67116d056385e073f5ab141f
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

Change to use vdd-microvolts prop value as voltage reference when the
supply regulator is missing or when DM_REGULATOR=n is used.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/adc/rockchip-saradc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/adc/rockchip-saradc.c b/drivers/adc/rockchip-saradc.c
index f6832ab30731..7cf9735f60d0 100644
--- a/drivers/adc/rockchip-saradc.c
+++ b/drivers/adc/rockchip-saradc.c
@@ -241,7 +241,7 @@ int rockchip_saradc_probe(struct udevice *dev)
 {
 	struct adc_uclass_plat *uc_pdata = dev_get_uclass_plat(dev);
 	struct rockchip_saradc_priv *priv = dev_get_priv(dev);
-	struct udevice *vref;
+	struct udevice *vref = NULL;
 	struct clk clk;
 	int vref_uv;
 	int ret;
@@ -259,7 +259,7 @@ int rockchip_saradc_probe(struct udevice *dev)
 	priv->active_channel = -1;
 
 	ret = device_get_supply_regulator(dev, "vref-supply", &vref);
-	if (ret) {
+	if (ret && uc_pdata->vdd_microvolts <= 0) {
 		printf("can't get vref-supply: %d\n", ret);
 		return ret;
 	}
@@ -267,7 +267,10 @@ int rockchip_saradc_probe(struct udevice *dev)
 	if (priv->reset)
 		rockchip_saradc_reset_controller(priv->reset);
 
-	vref_uv = regulator_get_value(vref);
+	if (vref)
+		vref_uv = regulator_get_value(vref);
+	else
+		vref_uv = uc_pdata->vdd_microvolts;
 	if (vref_uv < 0) {
 		printf("can't get vref-supply value: %d\n", vref_uv);
 		return vref_uv;
-- 
2.46.2

