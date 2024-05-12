Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9136C25B5F
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 12:18:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 64BBD882CF;
	Sun, 12 May 2024 14:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="lgiiScfl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB720882AB; Sun, 12 May 2024 14:17:44 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D991088001
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 14:17:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bf9f=MQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1715516227; bh=YQO6291lzx9kSK/Uqt9Hu0CjvmF/Iw1by0DIQYIfHnY=;
 b=lgiiScfl7gc3+bZaEVwMQ4WddGqPtA+wwFsTdKOY0Tc9/VX5j03tJvd6SpJhuadfMp+8WbCxD
 IT2T3eE33Qm3lKZE5jAOEwHj/HST/s2aD/WJfG7lhcjAgaDgahpSAA4SDbq+ud4QvmOzdhGFFRK
 flEce65C3gyTtG3r3w+quSs7KGDmDNyYYr58x81dejQBp0Uk8IRcRg8v01416ZB4qyHzlcUxrs9
 iMNW4W80K/71glDpCK6NY1riLizYSVurHjIHmVdannr7ecmiJpUss4dWguNooVm8RSWzBldSfPr
 mieZXAUsmSxi0XgRRI0T+JbMUOW2c83H3/YC3lNQVLKg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>, Mark
 Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 5/9] pinctrl: rockchip: Update get_gpio_mux() ops
Date: Sun, 12 May 2024 12:16:18 +0000
Message-ID: <20240512121633.1632597-6-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6640b33c1cfb9f69e9a4f036
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

Add a way to get_gpio_mux() based on the pinctrl pin offset, use -1 as
banknum to use the pinctrl pin offset mode instead of bank pin offset.

This mode will be used by the gpio driver to ensure a pin used by gpio
request() and get_function() ops always refer to the same pinctrl pin.

Also add verify_config() of banknum and index to avoid an out of range
access of the pin_banks array, i.e. with gpio6 on rk3066a.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
The pin_to_mux() helper will be used in the get_pin_muxing() ops added
in a later patch to support the pinmux status cmd.
---
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index b7c08c23311f..1a8eec19d268 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -194,10 +194,30 @@ static struct rockchip_pin_bank *rockchip_pin_to_bank(struct udevice *dev,
 	return NULL;
 }
 
+static int rockchip_pin_to_mux(struct udevice *dev, unsigned int pin)
+{
+	struct rockchip_pin_bank *bank;
+
+	bank = rockchip_pin_to_bank(dev, pin);
+	if (!bank)
+		return -EINVAL;
+
+	return rockchip_get_mux(bank, pin - bank->pin_base);
+}
+
 static int rockchip_pinctrl_get_gpio_mux(struct udevice *dev, int banknum,
 					 int index)
-{	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
+{
+	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
 	struct rockchip_pin_ctrl *ctrl = priv->ctrl;
+	int ret;
+
+	if (banknum == -1)
+		return rockchip_pin_to_mux(dev, index);
+
+	ret = rockchip_verify_config(dev, banknum, index);
+	if (ret)
+		return ret;
 
 	return rockchip_get_mux(&ctrl->pin_banks[banknum], index);
 }
-- 
2.43.2

