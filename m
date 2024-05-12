Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BACC10F1A
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 12:18:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12840883AD;
	Sun, 12 May 2024 14:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="R4gXQxK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA4A58820E; Sun, 12 May 2024 14:17:46 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1115D880B5
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 14:17:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bf9f=MQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1715516230; bh=eGeeAjtxsRjaL8KciG8aRWBqK3E0erA0swrRmUKdokQ=;
 b=R4gXQxK622y4zlkAvFl+Bg7mT3E5vJlFe5Izy5GE9NJ6gB/Ok/WgWjlpdhGDcfEAOtGMciPAZ
 av93lXQ3sX5SVSxN6PfW8NTn4Tj0PASVDkPvv1aCphixu89/6lZIfYkkmQhJ59BHDiGHA+gQry4
 IdOo/pOSRSlru74j6rHAiqOHP79joMN3Un74y1o7aWmmxh0ef0z/KEVDlIBFjXlfSkIDpxW2vou
 SSeztwe6y4eP2F3QoxZQT73/9TOB2F/+HWsbTCY9smWaX4tog+Y2J+w8b2ixEO+Uatse9kzerB0
 nwp+JHVxrArboIopA+ySYLiJHF4+jvZ2dvHmbxALABcg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>, Mark
 Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 7/9] gpio: rockchip: Use pinctrl pin offset to get_gpio_mux()
Date: Sun, 12 May 2024 12:16:20 +0000
Message-ID: <20240512121633.1632597-8-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6640b3441cfb9f69e9a4f070
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
---
 drivers/gpio/rk_gpio.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/rk_gpio.c b/drivers/gpio/rk_gpio.c
index 8f8f21acc2f5..a3691ad25b78 100644
--- a/drivers/gpio/rk_gpio.c
+++ b/drivers/gpio/rk_gpio.c
@@ -35,7 +35,7 @@ enum {
 struct rockchip_gpio_priv {
 	void __iomem *regs;
 	struct udevice *pinctrl;
-	int bank;
+	int pfc_offset;
 	char name[2];
 	u32 version;
 };
@@ -109,7 +109,8 @@ static int rockchip_gpio_get_function(struct udevice *dev, unsigned offset)
 	int ret;
 
 	if (CONFIG_IS_ENABLED(PINCTRL)) {
-		ret = pinctrl_get_gpio_mux(priv->pinctrl, priv->bank, offset);
+		ret = pinctrl_get_gpio_mux(priv->pinctrl, -1,
+					   priv->pfc_offset + offset);
 		if (ret < 0)
 			return ret;
 		else if (ret != RK_FUNC_GPIO)
@@ -187,7 +188,7 @@ static int rockchip_gpio_probe(struct udevice *dev)
 	struct rockchip_gpio_priv *priv = dev_get_priv(dev);
 	struct ofnode_phandle_args args;
 	char *end;
-	int ret;
+	int bank, ret;
 
 	priv->regs = dev_read_addr_ptr(dev);
 
@@ -200,7 +201,8 @@ static int rockchip_gpio_probe(struct udevice *dev)
 					     0, &args);
 	if (!ret) {
 		uc_priv->gpio_count = args.args[2];
-		priv->bank = args.args[1] / ROCKCHIP_GPIOS_PER_BANK;
+		bank = DIV_ROUND_UP(args.args[1], ROCKCHIP_GPIOS_PER_BANK);
+		priv->pfc_offset = args.args[1];
 
 		if (CONFIG_IS_ENABLED(PINCTRL)) {
 			ret = uclass_get_device_by_ofnode(UCLASS_PINCTRL,
@@ -211,11 +213,12 @@ static int rockchip_gpio_probe(struct udevice *dev)
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
@@ -227,7 +230,7 @@ static int rockchip_gpio_probe(struct udevice *dev)
 		return ret;
 	}
 
-	priv->name[0] = 'A' + priv->bank;
+	priv->name[0] = 'A' + bank;
 	uc_priv->bank_name = priv->name;
 
 	priv->version = readl(priv->regs + VER_ID_V2);
-- 
2.43.2

