Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F6BC10F1A
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 12:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7E2C88341;
	Sun, 12 May 2024 14:17:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hAn/gdoK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B3C88272; Sun, 12 May 2024 14:17:47 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 856E0882E9
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 14:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bf9f=MQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1715516239; bh=iU/e9dcHPGEtPCe8ijr5MnJGQFk3Ey+FnyYyFNJLuXE=;
 b=hAn/gdoKvNYImqQ/Qae8pNFDuo8kCXVZlpxg/Q7jDn8apJj5YIrljjkGK+1MqrKfQIvRgCPFK
 uCK+cGSImwAKCql9mrkSeszNhd1OHksSoSQYFwln4MivGV8otZTDJLGnu0OXJn9txkOR13EmXDX
 fv/vec834LObm+YcFAwz6rmq0yvwi5clliTOXisDZ87taja3OSkukuW4yS5KZB2jE/Vgaxz9JVL
 0DzR615fylPCv+KydDIW6NCHngfIFFelqYXUsm/PNFOhsHTNOGCVRJAOZGnfOUExT7gr4HPOyT1
 C8WGXDM4/wJr74bpJ4ocNjzbbMEvOXHg/zei4mfbvWSA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>, Mark
 Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 8/9] pinctrl: rockchip: Add pinmux status related ops
Date: Sun, 12 May 2024 12:16:21 +0000
Message-ID: <20240512121633.1632597-9-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6640b3491cfb9f69e9a4f08e
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

Add get_pins_count(), get_pin_name() and get_pin_muxing() ops to support
the pinmux status cmd.

  => pinmux dev pinctrl
  dev: pinctrl
  => pinmux status
  GPIO0_A0  : gpio
  GPIO0_A1  : func-1
  GPIO0_A2  : gpio
  GPIO0_A3  : gpio
  GPIO0_A4  : func-1
  GPIO0_A5  : gpio
  GPIO0_A6  : gpio
  GPIO0_A7  : func-1
  GPIO0_B0  : gpio
  GPIO0_B1  : func-1
  GPIO0_B2  : func-1
  GPIO0_B3  : gpio
  [...]

The change to use ENOENT for unrouted pins also help hide a "Error -22"
message for unrouted pins using the gpio status -a cmd.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 50 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 1a8eec19d268..fa24de37b443 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -127,7 +127,7 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 
 	if (bank->iomux[iomux_num].type & IOMUX_UNROUTED) {
 		debug("pin %d is unrouted\n", pin);
-		return -EINVAL;
+		return -ENOENT;
 	}
 
 	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY)
@@ -194,6 +194,32 @@ static struct rockchip_pin_bank *rockchip_pin_to_bank(struct udevice *dev,
 	return NULL;
 }
 
+static int rockchip_pinctrl_get_pins_count(struct udevice *dev)
+{
+	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
+	struct rockchip_pin_ctrl *ctrl = priv->ctrl;
+
+	return ctrl->nr_pins;
+}
+
+static const char *rockchip_pinctrl_get_pin_name(struct udevice *dev,
+						 unsigned int selector)
+{
+	static char name[PINNAME_SIZE];
+	struct rockchip_pin_bank *bank;
+	unsigned int index;
+
+	bank = rockchip_pin_to_bank(dev, selector);
+	if (!bank)
+		return NULL;
+
+	index = selector - bank->pin_base;
+	snprintf(name, sizeof(name), "GPIO%u_%c%u",
+		 bank->bank_num, 'A' + (index / 8), index % 8);
+
+	return name;
+}
+
 static int rockchip_pin_to_mux(struct udevice *dev, unsigned int pin)
 {
 	struct rockchip_pin_bank *bank;
@@ -222,6 +248,25 @@ static int rockchip_pinctrl_get_gpio_mux(struct udevice *dev, int banknum,
 	return rockchip_get_mux(&ctrl->pin_banks[banknum], index);
 }
 
+static int rockchip_pinctrl_get_pin_muxing(struct udevice *dev,
+					   unsigned int selector,
+					   char *buf, int size)
+{
+	int mux;
+
+	mux = rockchip_pin_to_mux(dev, selector);
+	if (mux == -ENOENT)
+		strlcpy(buf, "unrouted", size);
+	else if (mux < 0)
+		return mux;
+	else if (mux)
+		snprintf(buf, size, "func-%d", mux);
+	else
+		strlcpy(buf, "gpio", size);
+
+	return 0;
+}
+
 static int rockchip_verify_mux(struct rockchip_pin_bank *bank,
 			       int pin, int mux)
 {
@@ -571,8 +616,11 @@ static int rockchip_pinctrl_set_state(struct udevice *dev,
 }
 
 const struct pinctrl_ops rockchip_pinctrl_ops = {
+	.get_pins_count			= rockchip_pinctrl_get_pins_count,
+	.get_pin_name			= rockchip_pinctrl_get_pin_name,
 	.set_state			= rockchip_pinctrl_set_state,
 	.get_gpio_mux			= rockchip_pinctrl_get_gpio_mux,
+	.get_pin_muxing			= rockchip_pinctrl_get_pin_muxing,
 	.gpio_request_enable		= rockchip_pinctrl_gpio_request_enable,
 };
 
-- 
2.43.2

