Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C148EC25B5F
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 12:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A40B880B5;
	Sun, 12 May 2024 14:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="D24R0QUe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B87E88001; Sun, 12 May 2024 14:17:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A905F882A3
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 14:17:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bf9f=MQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1715516230; bh=RRfTbOK6yhM0JCULgfJjK7G8WfTzGpSC4UL/yTIvXH0=;
 b=D24R0QUedpjM8xkW+04io6igJ2AbwrGfD6MlljymPsxS4vehHXv4XrS8oSaGIsWogzQ/oFeSP
 WMDXyrUaI2mo9mqoiTipzkIyPp/EAXkqu2upnod6gzyRjmSoGJMDJcGsz5kdN6mNiC8zH+8IPcy
 yjp1dtKpm4Gnqy9kdzrXDdmE0PcwwcZr2sa0CGIlSr6G6ZhKREDcSd1BzYs84N0w6FwrdYycpr1
 Hdk22Xct0bmpPcOwigLuNC96FKT5CLDBfew0r9jKG52Ka6lsrNkVnSsBhnTKIppzb4AMPTgBp5N
 WehgRrfkjFgt90noBWuUHhWLY10bXOMv2OcjsD56MM3Q==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>, Mark
 Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 6/9] gpio: rockchip: Get pinctrl device from gpio-ranges prop
Date: Sun, 12 May 2024 12:16:19 +0000
Message-ID: <20240512121633.1632597-7-jonas@kwiboo.se>
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
 149.28.215.223
X-ForwardEmail-ID: 6640b3401cfb9f69e9a4f054
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

Get pinctrl device from gpio-ranges phandle when the property exists,
fallback to get the first pinctrl device.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpio/rk_gpio.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
index 956894501633..8f8f21acc2f5 100644
--- a/drivers/gpio/rk_gpio.c
+++ b/drivers/gpio/rk_gpio.c
@@ -191,12 +191,6 @@ static int rockchip_gpio_probe(struct udevice *dev)
 
 	priv->regs = dev_read_addr_ptr(dev);
 
-	if (CONFIG_IS_ENABLED(PINCTRL)) {
-		ret = uclass_first_device_err(UCLASS_PINCTRL, &priv->pinctrl);
-		if (ret)
-			return ret;
-	}
-
 	/*
 	 * If "gpio-ranges" is present in the devicetree use it to parse
 	 * the GPIO bank ID, otherwise use the legacy method.
@@ -204,16 +198,33 @@ static int rockchip_gpio_probe(struct udevice *dev)
 	ret = ofnode_parse_phandle_with_args(dev_ofnode(dev),
 					     "gpio-ranges", NULL, 3,
 					     0, &args);
-	if (!ret || ret != -ENOENT) {
+	if (!ret) {
 		uc_priv->gpio_count = args.args[2];
 		priv->bank = args.args[1] / ROCKCHIP_GPIOS_PER_BANK;
-	} else {
+
+		if (CONFIG_IS_ENABLED(PINCTRL)) {
+			ret = uclass_get_device_by_ofnode(UCLASS_PINCTRL,
+							  args.node,
+							  &priv->pinctrl);
+			if (ret)
+				return ret;
+		}
+	} else if (ret == -ENOENT || !CONFIG_IS_ENABLED(PINCTRL)) {
 		uc_priv->gpio_count = ROCKCHIP_GPIOS_PER_BANK;
 		ret = dev_read_alias_seq(dev, &priv->bank);
 		if (ret) {
 			end = strrchr(dev->name, '@');
 			priv->bank = trailing_strtoln(dev->name, end);
 		}
+
+		if (CONFIG_IS_ENABLED(PINCTRL)) {
+			ret = uclass_first_device_err(UCLASS_PINCTRL,
+						      &priv->pinctrl);
+			if (ret)
+				return ret;
+		}
+	} else {
+		return ret;
 	}
 
 	priv->name[0] = 'A' + priv->bank;
-- 
2.43.2

