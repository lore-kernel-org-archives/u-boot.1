Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A82109C057
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 19:27:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1FFD83F6D;
	Wed, 25 Mar 2026 20:27:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=netcube.li header.i=@netcube.li header.b="pgav1zYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 833DE83DA7; Wed, 25 Mar 2026 20:27:18 +0100 (CET)
Received: from mail.netcube.li (mail.netcube.li [173.249.15.149])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A6AC83F6D
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 20:27:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=netcube.li
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukas.schmid@netcube.li
dkim-signature: v=1; a=rsa-sha256; d=netcube.li; s=s1;
 c=relaxed/relaxed; q=dns/txt;
 h=From:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Transfer-Encoding:In-Reply-To:References;
 bh=awvay4tG8AC+stg+gBKcZ+sG8GMDRNd9qMTAaVuXGqc=;
 b=pgav1zYI7O1gOaOtZRb0Bh2S89Q8EA2cdrgXsVqPrM6Vb+rJJXLHdDEyBbBVmazCH+E+WKNuHuy33qZqQJuM8+UlVCTDjgV9d8liQvbo0LGmAHOa4Y+i3xPeEhXwGro8RMyiiWdLyu4LPTpJvWaHZwcgJqaiRItfZ6vkyEbYcfQ=
Received: from lukas-hpz440workstation.lan.sk100508.local
 (193-80-178-216.hdsl.highway.telekom.at [193.80.178.216])
 by mail.netcube.li with ESMTPA ; Wed, 25 Mar 2026 20:27:16 +0100
From: Lukas Schmid <lukas.schmid@netcube.li>
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Cc: Lukas Schmid <lukas.schmid@netcube.li>,
	u-boot@lists.denx.de
Subject: [PATCH 2/6] pinctrl: sunxi: add I2C3 mux for D1/T113-s3 (PG10/PG11)
Date: Wed, 25 Mar 2026 20:26:09 +0100
Message-ID: <20260325192628.750398-3-lukas.schmid@netcube.li>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325192628.750398-1-lukas.schmid@netcube.li>
References: <20260325192628.750398-1-lukas.schmid@netcube.li>
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

Boards based on the Allwinner D1/T113-s3, such as the
NetCube Systems Nagami, can expose a third I2C controller
on PG10/PG11. However, the sun20i_d1 pinctrl function table
lacked an entry for this mux.

Add the "i2c3" function with mux value 3 on PG10/PG11, allowing device
trees to enable the I2C3 controller.

Signed-off-by: Lukas Schmid <lukas.schmid@netcube.li>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index fd357ab0d4e..a8632aeaf8f 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -603,6 +603,7 @@ static const struct sunxi_pinctrl_function sun20i_d1_pinctrl_functions[] = {
 	{ "gpio_in",	0 },
 	{ "gpio_out",	1 },
 	{ "i2c0",	4 },	/* PB10-PB11 */
+	{ "i2c3",	3 },	/* PG10-PG11 */
 	{ "mmc0",	2 },	/* PF0-PF5 */
 	{ "mmc1",	2 },	/* PG0-PG5 */
 	{ "mmc2",	3 },	/* PC2-PC7 */
-- 
2.47.3

