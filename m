Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928CCE7544F
	for <u-boot@archiver.kernel.org>; Tue,  3 Oct 2023 12:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E39186E42;
	Tue,  3 Oct 2023 14:12:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="dw8vVuAT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65C868707E; Tue,  3 Oct 2023 13:28:59 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EC4D8716D
 for <u-boot@lists.denx.de>; Tue,  3 Oct 2023 13:28:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id CB1D6100007;
 Tue,  3 Oct 2023 14:28:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CB1D6100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1696332534;
 bh=f6ZnH3Dtz73Vojy7+t1qCQ1MxL4DKJuwRa7GZWGCArE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=dw8vVuATW73tfHTKVQI6I44G4+U8HPxdEX1uX/HqFg7blptxsR7Y5worjl3HgMTuZ
 I2lifW/+L5MPuJb+iK52K51+auBDQJgmJ0hpZFphFwZxcLg4SV2gzPECOq11swV4u4
 kmY5jCTvSfBBZFQrKHgxl3xKkFiaGCnVZ+/h12PtvNj1m3ULIMzGr+LZ0EMNnwYQle
 fvMrVy/zd1aA3eKaggBs1W6mh+ScKbhNXX6GH+QsjaSB5rurBX7CM2a0Hvz1STw/TV
 OxATtMfD5FlIXn/W5v2jxvgp1cC5Kp0cHf5S4hxQpm8nEI674RxA3zQhvKqDqAoxhH
 40C+Uzqap4zng==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue,  3 Oct 2023 14:28:54 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 3 Oct 2023 14:28:54 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <narmstrong@baylibre.com>, <sjg@google.com>, 
 <lukma@denx.de>, <seanga2@gmail.com>, <marex@denx.de>
CC: <u-boot-amlogic@groups.io>, <u-boot@lists.denx.de>,
 <kernel@sberdevices.ru>, Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v2 4/8] phy: move clk enable/disable in init/exit
Date: Tue, 3 Oct 2023 14:28:30 +0300
Message-ID: <20231003112838.41503-5-avromanov@salutedevices.com>
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
 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 100.64.160.123:7.1.2; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 lore.kernel.org:7.1.1; p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;
 127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/10/03 10:24:00
X-KSMG-LinksScanning: Clean, bases: 2023/10/03 10:24:00
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

It is better to place clk_enable() in phy_meson_g12a_usb2_init()
and clk_disable() in phy_meson_g12a_usb2_exit().

For more detailed information, please see comments in the review of
a similar driver in the Linux Kernel:

https://lore.kernel.org/all/CAFBinCCEhobbyKHuKDWzTYCQWgNT1-e8=7hMhq1mvT6CuEOjGw@mail.gmail.com/

Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/meson-g12a-usb2.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/meson-g12a-usb2.c b/drivers/phy/meson-g12a-usb2.c
index 2e366b16ae..7b028784a0 100644
--- a/drivers/phy/meson-g12a-usb2.c
+++ b/drivers/phy/meson-g12a-usb2.c
@@ -160,6 +160,14 @@ static int phy_meson_g12a_usb2_init(struct phy *phy)
 	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
 	int ret;
 
+#if CONFIG_IS_ENABLED(CLK)
+	ret = clk_enable(&priv->clk);
+	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
+		pr_err("failed to enable PHY clock\n");
+		return ret;
+	}
+#endif
+
 	ret = reset_assert(&priv->reset);
 	udelay(1);
 	ret |= reset_deassert(&priv->reset);
@@ -252,6 +260,10 @@ static int phy_meson_g12a_usb2_exit(struct phy *phy)
 	struct phy_meson_g12a_usb2_priv *priv = dev_get_priv(dev);
 	int ret;
 
+#if CONFIG_IS_ENABLED(CLK)
+	clk_disable(&priv->clk);
+#endif
+
 	ret = reset_assert(&priv->reset);
 	if (ret)
 		return ret;
@@ -289,13 +301,6 @@ int meson_g12a_usb2_phy_probe(struct udevice *dev)
 	ret = clk_get_by_index(dev, 0, &priv->clk);
 	if (ret < 0)
 		return ret;
-
-	ret = clk_enable(&priv->clk);
-	if (ret && ret != -ENOSYS && ret != -ENOTSUPP) {
-		pr_err("failed to enable PHY clock\n");
-		clk_free(&priv->clk);
-		return ret;
-	}
 #endif
 
 	return 0;
-- 
2.25.1

