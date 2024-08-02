Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A5FC3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 22:58:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03F3988C63;
	Sat,  3 Aug 2024 00:57:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JS/HVTEx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8520188C04; Sat,  3 Aug 2024 00:57:29 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E24888C57
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 00:57:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722639440; bh=oguyFWflTa+oS4eqvecFHxt4HthZ9ur1qiVUkKQeFHo=;
 b=JS/HVTExntLkAVMuTnzDbnPlwiSGVnc8y77RNlGmKzpE/v89ClPhdecbpVEkhuSqXD6oUyP39
 hM0xpKmBnKLBe+FkTqFfjy0SgyYgG5dYKDQf04o2jsl3t/o+bodj8v6mI45OxdkN7FAEIQ6WwQp
 PjOkmIWtLpGI6vs3rbZfOcUtjLVGaNal5Jci9VKAFmY+QDVxtwT+AHrVfBHKcDDbgOJSYEjz3xG
 +SxV6ja8QqqlNdlUuFGf633orlJS65PAd6UszD9bcjLzustyzM5QD/oRUUOrGrViNhY2o7OH3AS
 N6wTjhGVLNtmHO6RfKQwpiRow3+untEX1coLOApEqeSA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 03/10] pinctrl: rockchip: Update get_gpio_mux() ops
Date: Fri,  2 Aug 2024 22:56:45 +0000
Message-ID: <20240802225705.2640999-4-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66ad644e16ac7a56c917ae9f
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tag

The pin_to_mux() helper will also be used in the get_pin_muxing() ops
added in next patch to support the pinmux status cmd.
---
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 894ff74aee98..8ede74da40c9 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -193,10 +193,30 @@ static struct rockchip_pin_bank *rockchip_pin_to_bank(struct udevice *dev,
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
2.45.2

