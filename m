Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7D1E7544F
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 12:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E758987228;
	Tue,  3 Oct 2023 14:12:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="X5krC3NM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52674871F1; Tue,  3 Oct 2023 13:28:57 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F79871FE
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 13:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 349B912000B;
 Tue,  3 Oct 2023 14:28:53 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 349B912000B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1696332533;
 bh=S+eRtZO9DQrwhKtLcc7qZcUIx8g5fJ8c+M+628vRRCo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=X5krC3NMLKtOhSSB3PBb4wDGFRkT10dbImaN4p3z6cwdcpYjRpuvxi0nJ9PwoqAVC
 JjVH/PPifDJKV4qRdxZRNjvYj1OsL+WVebUt9SGDMs1ZpFBXvDL7kxn5yZxFq26j9i
 AN1IIiTH5MFAPToIIly+FUYgNAPODpDbRwzbcfTjX4X4DpJeoF1YUU1x4EVRElUeUr
 AF6LaGWeaYNSnSxO5G507Qim86qo9uJrZLhC/W+7nyhIWtr49kIMOsNLlhI75+fmkV
 RGRVisL7hRmHxKW0O6MrHF5ne87I/XGlzxUcIxACw1sf2JQ4zHiNwJm/0CeGKfb78h
 hr/Xarie1lY3g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue,  3 Oct 2023 14:28:53 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 3 Oct 2023 14:28:52 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <lukma@denx.de>, <seanga2@gmail.com>, <marex@denx.de>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 2/8] reset: add support for Amlogic A1 family
Date: Tue, 3 Oct 2023 14:28:28 +0300
Message-ID: <20231003112838.41503-3-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003112838.41503-1-avromanov@salutedevices.com>
References: <20231003112838.41503-1-avromanov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180316 [Oct 03 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535
 da804c0ea8918f802fc60e7a20ba49783d957ba2,
 {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/10/03 10:12:00 #22029534
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Tue, 03 Oct 2023 14:12:00 +0200
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

This patch adds reset support for the Amlogic A1 family.
We add the structure meson_reset_drvdata, which in the future
will allow this driver to be used for other families by declaring
only the correct parameters reg_count and level_offset.

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/reset/reset-meson.c | 42 +++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 64bc696f13..9d0c8b354f 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -13,18 +13,26 @@
 #include <reset-uclass.h>
 #include <regmap.h>
 #include <linux/bitops.h>
+#include <linux/delay.h>
 
-#define REG_COUNT	8
 #define BITS_PER_REG	32
-#define LEVEL_OFFSET	0x7c
+
+struct meson_reset_drvdata {
+	unsigned int reg_count;
+	unsigned int level_offset;
+};
 
 struct meson_reset_priv {
 	struct regmap *regmap;
+	struct meson_reset_drvdata *drvdata;
 };
 
 static int meson_reset_request(struct reset_ctl *reset_ctl)
 {
-	if (reset_ctl->id > (REG_COUNT * BITS_PER_REG))
+	struct meson_reset_priv *priv = dev_get_priv(reset_ctl->dev);
+	struct meson_reset_drvdata *data = priv->drvdata;
+
+	if (reset_ctl->id > (data->reg_count * BITS_PER_REG))
 		return -EINVAL;
 
 	return 0;
@@ -33,9 +41,10 @@ static int meson_reset_request(struct reset_ctl *reset_ctl)
 static int meson_reset_level(struct reset_ctl *reset_ctl, bool assert)
 {
 	struct meson_reset_priv *priv = dev_get_priv(reset_ctl->dev);
+	struct meson_reset_drvdata *data = priv->drvdata;
 	uint bank = reset_ctl->id / BITS_PER_REG;
 	uint offset = reset_ctl->id % BITS_PER_REG;
-	uint reg_offset = LEVEL_OFFSET + (bank << 2);
+	uint reg_offset = data->level_offset + (bank << 2);
 	uint val;
 
 	regmap_read(priv->regmap, reg_offset, &val);
@@ -64,15 +73,36 @@ struct reset_ops meson_reset_ops = {
 	.rst_deassert = meson_reset_deassert,
 };
 
+static const struct meson_reset_drvdata meson_gxbb_data = {
+	.reg_count = 8,
+	.level_offset = 0x7c,
+};
+
+static const struct meson_reset_drvdata meson_a1_data = {
+	.reg_count = 3,
+	.level_offset = 0x40,
+};
+
 static const struct udevice_id meson_reset_ids[] = {
-	{ .compatible = "amlogic,meson-gxbb-reset" },
-	{ .compatible = "amlogic,meson-axg-reset" },
+	{
+		.compatible = "amlogic,meson-gxbb-reset",
+		.data = (ulong)&meson_gxbb_data,
+	},
+	{
+		.compatible = "amlogic,meson-axg-reset",
+		.data = (ulong)&meson_gxbb_data,
+	},
+	{
+		.compatible = "amlogic,meson-a1-reset",
+		.data = (ulong)&meson_a1_data,
+	},
 	{ }
 };
 
 static int meson_reset_probe(struct udevice *dev)
 {
 	struct meson_reset_priv *priv = dev_get_priv(dev);
+	priv->drvdata = (struct meson_reset_drvdata *)dev_get_driver_data(dev);
 
 	return regmap_init_mem(dev_ofnode(dev), &priv->regmap);
 }
-- 
2.25.1

