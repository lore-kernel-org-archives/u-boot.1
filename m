Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F52C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 22:58:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9328588C72;
	Sat,  3 Aug 2024 00:57:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="EJDKfJB+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C0C88C7E; Sat,  3 Aug 2024 00:57:40 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B9DC88C79
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 00:57:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722639450; bh=eyA1FXago9QmRwcxhfr7KhwC9orBRDnI63jPHr1Luds=;
 b=EJDKfJB+S0ksLRrJxz4VF9TdGMcxkHbNl0zIKlNXRV4MEN8pLIhpaNgFE9WO6x20p++o9VUdA
 xOMKGG24Zl73upSeTF4l81/0JefMUU6/GwX/GMq21yXkVaqk1AXlJ3cvFFWhDbPuXftPWogBOd2
 0K7pGKo+KCw2/o0+pkRsoYmsgWiubJs7jpt4crVyuqlGSQv1Pl8kyF2SxQ7yj2yv4mdugiW1Jtw
 4FRlwmkWs/wmFq5bpC8YF8IhZTv47TqDFq+HOVn+UZ/5BFbH0WRXlEyOXXeJ4Xq2DYNSUfTeCHy
 WbtevCv0JpdPlQa/bCtq4pHry6Y2lJF11SOapYxQphiA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 07/10] gpio: rockchip: Use pinctrl pin offset to
 get_gpio_mux()
Date: Fri,  2 Aug 2024 22:56:49 +0000
Message-ID: <20240802225705.2640999-8-jonas@kwiboo.se>
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
 167.172.40.54
X-ForwardEmail-ID: 66ad645916ac7a56c917aeed
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

Use the pinctrl pin offset to get_gpio_mux() to remove the bank num
dependency and instead only use the bank num to assign a bank name.

Most Rockchip SoCs use all 32 pins of each gpio controller, meaning the
pinctrl pin offset typically is aligned to 32.

However, for gpio0 on RK3288 only 24 pins are used meaning the pinctrl
pin offset start at pin 24 for gpio1. Use DIV_ROUND_UP to get the 32 pin
aligned bank num.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tag
---
 drivers/gpio/rk_gpio.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
index abece6409ae0..5972f7f8612d 100644
--- a/drivers/gpio/rk_gpio.c
+++ b/drivers/gpio/rk_gpio.c
@@ -34,7 +34,7 @@ enum {
 struct rockchip_gpio_priv {
 	void __iomem *regs;
 	struct udevice *pinctrl;
-	int bank;
+	int pfc_offset;
 	char name[2];
 	u32 version;
 };
@@ -108,7 +108,8 @@ static int rockchip_gpio_get_function(struct udevice *dev, unsigned offset)
 	int ret;
 
 	if (CONFIG_IS_ENABLED(PINCTRL)) {
-		ret = pinctrl_get_gpio_mux(priv->pinctrl, priv->bank, offset);
+		ret = pinctrl_get_gpio_mux(priv->pinctrl, -1,
+					   priv->pfc_offset + offset);
 		if (ret < 0)
 			return ret;
 		else if (ret != RK_FUNC_GPIO)
@@ -177,7 +178,7 @@ static int rockchip_gpio_probe(struct udevice *dev)
 	struct rockchip_gpio_priv *priv = dev_get_priv(dev);
 	struct ofnode_phandle_args args;
 	char *end;
-	int ret;
+	int bank, ret;
 
 	priv->regs = dev_read_addr_ptr(dev);
 
@@ -190,7 +191,8 @@ static int rockchip_gpio_probe(struct udevice *dev)
 					     0, &args);
 	if (!ret) {
 		uc_priv->gpio_count = args.args[2];
-		priv->bank = args.args[1] / ROCKCHIP_GPIOS_PER_BANK;
+		bank = DIV_ROUND_UP(args.args[1], ROCKCHIP_GPIOS_PER_BANK);
+		priv->pfc_offset = args.args[1];
 
 		if (CONFIG_IS_ENABLED(PINCTRL)) {
 			ret = uclass_get_device_by_ofnode(UCLASS_PINCTRL,
@@ -201,11 +203,12 @@ static int rockchip_gpio_probe(struct udevice *dev)
 		}
 	} else if (ret == -ENOENT || !CONFIG_IS_ENABLED(PINCTRL)) {
 		uc_priv->gpio_count = ROCKCHIP_GPIOS_PER_BANK;
-		ret = dev_read_alias_seq(dev, &priv->bank);
+		ret = dev_read_alias_seq(dev, &bank);
 		if (ret) {
 			end = strrchr(dev->name, '@');
-			priv->bank = trailing_strtoln(dev->name, end);
+			bank = trailing_strtoln(dev->name, end);
 		}
+		priv->pfc_offset = bank * ROCKCHIP_GPIOS_PER_BANK;
 
 		if (CONFIG_IS_ENABLED(PINCTRL)) {
 			ret = uclass_first_device_err(UCLASS_PINCTRL,
@@ -217,7 +220,7 @@ static int rockchip_gpio_probe(struct udevice *dev)
 		return ret;
 	}
 
-	priv->name[0] = 'A' + priv->bank;
+	priv->name[0] = 'A' + bank;
 	uc_priv->bank_name = priv->name;
 
 	priv->version = readl(priv->regs + VER_ID_V2);
-- 
2.45.2

