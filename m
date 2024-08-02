Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8B4C3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 22:58:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3616888C37;
	Sat,  3 Aug 2024 00:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="or4EgZc7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E14DB88C86; Sat,  3 Aug 2024 00:57:38 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0547C88C7E
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 00:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722639452; bh=y5eif5OxTIBnjKTdcgONKwVbpL3g+MP3dmVfBsVq/p0=;
 b=or4EgZc718XNWnFsPpo0b/pTF+bwW37JZBs7ZA8NowzMYnCAiNbm0pdmszf/s3c+KhCxnBzPl
 hyUnH84K2g+R3nKKQnI3ZPuvL9vidC4FIBlElAmPFmernzRKcx4UOxaWgwDVCS54dB/NcErKsuk
 HkcpvqN5hnCCkg/suwOo5SbccEATThi8J0sa/vqL9D0jciUMdXVJs8MVwqDhQ8j8kph0+jCrw6H
 MJkFxmDIaGe5GTaXquk4DSR770Re4+aPb+aBbSadv0/ZiAH8jCga0AJKK3mJjv1+sX8yn5+Cidi
 FKxZhACi/HIzPNDq4R8bVlRq9368cGcwvh8iCGuQqG/A==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 08/10] gpio: rockchip: Add request() ops
Date: Fri,  2 Aug 2024 22:56:50 +0000
Message-ID: <20240802225705.2640999-9-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802225705.2640999-1-jonas@kwiboo.se>
References: <20240802225705.2640999-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ad645c16ac7a56c917aeff
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

Add a request() ops that call pinctrl_gpio_request() when the required
gpio-ranges prop has been defined to signal pinctrl driver to use gpio
pinmux.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch from "rockchip: Add gpio request() ops" series
---
 drivers/gpio/rk_gpio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
index 5972f7f8612d..65811dbc78d6 100644
--- a/drivers/gpio/rk_gpio.c
+++ b/drivers/gpio/rk_gpio.c
@@ -126,6 +126,15 @@ static int rockchip_gpio_get_function(struct udevice *dev, unsigned offset)
 	return (data & mask) ? GPIOF_OUTPUT : GPIOF_INPUT;
 }
 
+static int rockchip_gpio_request(struct udevice *dev, unsigned offset,
+				 const char *label)
+{
+	if (CONFIG_IS_ENABLED(PINCTRL) && dev_read_bool(dev, "gpio-ranges"))
+		return pinctrl_gpio_request(dev, offset, label);
+
+	return 0;
+}
+
 /* Simple SPL interface to GPIOs */
 #ifdef CONFIG_SPL_BUILD
 
@@ -229,6 +238,7 @@ static int rockchip_gpio_probe(struct udevice *dev)
 }
 
 static const struct dm_gpio_ops gpio_rockchip_ops = {
+	.request		= rockchip_gpio_request,
 	.direction_input	= rockchip_gpio_direction_input,
 	.direction_output	= rockchip_gpio_direction_output,
 	.get_value		= rockchip_gpio_get_value,
-- 
2.45.2

