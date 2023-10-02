Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F14E748FE
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 17:35:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A02871B3;
	Mon,  2 Oct 2023 19:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="kZ2/iKjD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2433086DFE; Mon,  2 Oct 2023 18:59:17 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB64F870AD
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 18:59:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 8CB64100003;
 Mon,  2 Oct 2023 19:59:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 8CB64100003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1696265950;
 bh=A0DfJv78BZAlR6ZTJr8rUFQ8KTu5C2NvgdRnuUn79fo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=kZ2/iKjDo9bUU3o23dvAvb6Lpcv1CAw5dkihoNNBvkt+VW0pNsyurF/5GUD8ZEebK
 5EOys2ivnfCl15KjkIsqOPmoz+qeUYHtLsFjulAIuwrkjt85pgiwdfNWnUin2Z8p3Z
 Os4z8r8RpO6GaCFZSpM3tZfkT+jN63NDhBUh1TgmqSnFJve6dEuEJiBNorEXXBoFpY
 4CQ3mmlFGBfWfrBSaOQqE9nuusC2iyoMoHTVfisc3+1egMJww0TtT7EAE6SVx2KFYf
 F7Kz0y2v+kAQQ4AVu8JlJY8FmvPbMYaXlT/ec0IsDP4CDEX6o9v0ZaDMB+arwYKNcd
 cTvT03oOAnlXw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  2 Oct 2023 19:59:10 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 2 Oct 2023 19:59:10 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <lukma@denx.de>, <seanga2@gmail.com>, <marex@denx.de>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v1 7/8] dwc3: add support for Amlogic A1 family
Date: Mon, 2 Oct 2023 19:58:51 +0300
Message-ID: <20231002165857.19512-8-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231002165857.19512-1-avromanov@salutedevices.com>
References: <20231002165857.19512-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180290 [Oct 02 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535
 da804c0ea8918f802fc60e7a20ba49783d957ba2,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 127.0.0.199:7.1.2; salutedevices.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s,
 ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/02 12:04:00 #22024008
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 02 Oct 2023 19:34:08 +0200
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

Now the driver supports also A1 phy layer.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 73 ++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index 90418ddc1d..550e6682a2 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -28,6 +28,7 @@
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/compat.h>
+#include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
 
 /* USB2 Ports Control Registers */
 
@@ -102,10 +103,22 @@ enum {
 	PHY_COUNT,
 };
 
-static const char *phy_names[PHY_COUNT] = {
+static const char *const dwc3_meson_g12a_phy_names[] = {
 	"usb2-phy0", "usb2-phy1", "usb3-phy0",
 };
 
+static const char *const dwc3_meson_a1_phy_names[] = {
+	"usb2-phy0", "usb2-phy1"
+};
+
+struct dwc3_meson_g12a;
+
+struct dwc3_meson_g12a_drvdata {
+	const char *const *phy_names;
+	unsigned int phy_cnt;
+	int (*clk_init)(struct dwc3_meson_g12a *priv);
+};
+
 struct dwc3_meson_g12a {
 	struct udevice		*dev;
 	struct regmap           *regmap;
@@ -119,6 +132,7 @@ struct dwc3_meson_g12a {
 #if CONFIG_IS_ENABLED(DM_REGULATOR)
 	struct udevice		*vbus_supply;
 #endif
+	struct dwc3_meson_g12a_drvdata *drvdata;
 };
 
 #define U2P_REG_SIZE						0x20
@@ -293,10 +307,11 @@ int dwc3_meson_g12a_force_mode(struct udevice *dev, enum usb_dr_mode mode)
 
 static int dwc3_meson_g12a_get_phys(struct dwc3_meson_g12a *priv)
 {
+	struct dwc3_meson_g12a_drvdata *data = priv->drvdata;
 	int i, ret;
 
-	for (i = 0 ; i < PHY_COUNT ; ++i) {
-		ret = generic_phy_get_by_name(priv->dev, phy_names[i],
+	for (i = 0 ; i < data->phy_cnt; ++i) {
+		ret = generic_phy_get_by_name(priv->dev, data->phy_names[i],
 					      &priv->phys[i]);
 		if (ret == -ENOENT || ret == -ENODATA)
 			continue;
@@ -354,18 +369,36 @@ static int dwc3_meson_g12a_clk_init(struct dwc3_meson_g12a *priv)
 	return 0;
 }
 
+static int dwc3_meson_a1_clk_init(struct dwc3_meson_g12a *priv)
+{
+	int ret;
+
+	ret = clk_get_by_name(priv->dev, "usb_bus", &priv->clk);
+	if (ret)
+		return ret;
+
+	ret = clk_enable(&priv->clk);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int dwc3_meson_g12a_probe(struct udevice *dev)
 {
 	struct dwc3_meson_g12a *priv = dev_get_plat(dev);
+	struct dwc3_meson_g12a_drvdata *data =
+		(struct dwc3_meson_g12a_drvdata *)dev_get_driver_data(dev);
 	int ret, i;
 
+	priv->drvdata = data;
 	priv->dev = dev;
 
 	ret = regmap_init_mem(dev_ofnode(dev), &priv->regmap);
 	if (ret)
 		return ret;
 
-	ret = dwc3_meson_g12a_clk_init(priv);
+	ret = data->clk_init(priv);
 	if (ret)
 		return ret;
 
@@ -398,7 +431,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
-	for (i = 0 ; i < PHY_COUNT ; ++i) {
+	for (i = 0 ; i < data->phy_cnt; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
 
@@ -407,7 +440,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 			goto err_phy_init;
 	}
 
-	for (i = 0; i < PHY_COUNT; ++i) {
+	for (i = 0; i < data->phy_cnt; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
 
@@ -419,7 +452,7 @@ static int dwc3_meson_g12a_probe(struct udevice *dev)
 	return 0;
 
 err_phy_init:
-	for (i = 0 ; i < PHY_COUNT ; ++i) {
+	for (i = 0 ; i < data->phy_cnt ; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
 
@@ -432,20 +465,21 @@ err_phy_init:
 static int dwc3_meson_g12a_remove(struct udevice *dev)
 {
 	struct dwc3_meson_g12a *priv = dev_get_plat(dev);
+	struct dwc3_meson_g12a_drvdata *data = priv->drvdata;
 	int i;
 
 	reset_release_all(&priv->reset, 1);
 
 	clk_release_all(&priv->clk, 1);
 
-	for (i = 0; i < PHY_COUNT; ++i) {
+	for (i = 0; i < data->phy_cnt; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
 
 		 generic_phy_power_off(&priv->phys[i]);
 	}
 
-	for (i = 0 ; i < PHY_COUNT ; ++i) {
+	for (i = 0 ; i < data->phy_cnt; ++i) {
 		if (!priv->phys[i].dev)
 			continue;
 
@@ -455,8 +489,27 @@ static int dwc3_meson_g12a_remove(struct udevice *dev)
 	return dm_scan_fdt_dev(dev);
 }
 
+static const struct dwc3_meson_g12a_drvdata meson_g12a_drvdata = {
+	.phy_names = dwc3_meson_g12a_phy_names,
+	.phy_cnt = ARRAY_SIZE(dwc3_meson_g12a_phy_names),
+	.clk_init = dwc3_meson_g12a_clk_init,
+};
+
+static const struct dwc3_meson_g12a_drvdata meson_a1_drvdata = {
+	.phy_names = dwc3_meson_a1_phy_names,
+	.phy_cnt = ARRAY_SIZE(dwc3_meson_a1_phy_names),
+	.clk_init = dwc3_meson_a1_clk_init,
+};
+
 static const struct udevice_id dwc3_meson_g12a_ids[] = {
-	{ .compatible = "amlogic,meson-g12a-usb-ctrl" },
+	{
+		.compatible = "amlogic,meson-g12a-usb-ctrl",
+		.data = (ulong)&meson_g12a_drvdata,
+	},
+	{
+		.compatible = "amlogic,meson-a1-usb-ctrl",
+		.data = (ulong)&meson_a1_drvdata,
+	},
 	{ }
 };
 
-- 
2.25.1

