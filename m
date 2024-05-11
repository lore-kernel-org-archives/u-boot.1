Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7646FC04FFE
	for <u-boot@archiver.kernel.org>; Sat, 11 May 2024 11:29:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DFAA882AF;
	Sat, 11 May 2024 13:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rvzuutwl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F60987FA7; Sat, 11 May 2024 13:28:51 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BCB887FF2
 for <u-boot@lists.denx.de>; Sat, 11 May 2024 13:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=6c02=MO=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1715426914; bh=wBaCnOFIh05Yiz0k8KACJ3xH7Pqa2j9nCgoQPWyOQc8=;
 b=rvzuutwlSeil/VkHqnb3W3LQNIyT8LjIxGM+Qlo8NumtNy9YXklPNH7EcOYWCG65HKZh+pfwD
 fiP3amzPWrcOI/asseZkp+f8KAYnvfSvUkRTnQi75Ao5EKUFoMQj8b/90GP1MsVoKvkpjk7pvrN
 k6S4GX7cbKt/DGwQbf3L3CJ/1h1a/lUpyU57OTA2BzOXrydkbZQWPbwtgVqgHB6DctuOPR2isTw
 +hLJQmlHYayffJkcJonxXPNc9+wiz6jyoKO32xtxg2z5h0fS49f70+DZICeGQTLlpPXAivCwroh
 1SOixjEFD7NNWcxBfnlZeQ+BGDWHvqvPwVtZqOhzGPgA==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 1/4] pinctrl: rockchip: Add gpio_request_enable() ops
Date: Sat, 11 May 2024 11:28:12 +0000
Message-ID: <20240511112821.1156519-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240511112821.1156519-1-jonas@kwiboo.se>
References: <20240511112821.1156519-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 663f565eacd5e90e057dfc40
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

Some boards use pinctrl to set a non-gpio pinmux on a pin that is later
requested to be used for gpio output.

Add a pin_to_bank() helper and implement gpio_request_enable() ops so
that the gpio request() ops can be implemented and a gpio requested pin
automatically is pinmuxed for gpio use, similar to Linux kernel.

Reset ctrl->nr_pins to 0 so that pin_to_bank() can locate a bank after
the second probe in U-Boot proper.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
The pin_to_bank() helper will also be used in a follow up series adding
support for the pinmux status cmd.
---
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 8ef089994f46..a423abcafb23 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -150,6 +150,23 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 	return ((val >> bit) & mask);
 }
 
+static struct rockchip_pin_bank *rockchip_pin_to_bank(struct udevice *dev,
+						      unsigned int pin)
+{
+	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
+	struct rockchip_pin_ctrl *ctrl = priv->ctrl;
+	struct rockchip_pin_bank *bank = ctrl->pin_banks;
+	int i;
+
+	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
+		if (pin >= bank->pin_base &&
+		    pin < bank->pin_base + bank->nr_pins)
+			return bank;
+	}
+
+	return NULL;
+}
+
 static int rockchip_pinctrl_get_gpio_mux(struct udevice *dev, int banknum,
 					 int index)
 {	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
@@ -250,6 +267,18 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
 	return 0;
 }
 
+static int rockchip_pinctrl_gpio_request_enable(struct udevice *dev,
+						unsigned int selector)
+{
+	struct rockchip_pin_bank *bank;
+
+	bank = rockchip_pin_to_bank(dev, selector);
+	if (!bank)
+		return -EINVAL;
+
+	return rockchip_set_mux(bank, selector - bank->pin_base, RK_FUNC_GPIO);
+}
+
 static int rockchip_perpin_drv_list[DRV_TYPE_MAX][8] = {
 	{ 2, 4, 8, 12, -1, -1, -1, -1 },
 	{ 3, 6, 9, 12, -1, -1, -1, -1 },
@@ -497,6 +526,7 @@ static int rockchip_pinctrl_set_state(struct udevice *dev,
 const struct pinctrl_ops rockchip_pinctrl_ops = {
 	.set_state			= rockchip_pinctrl_set_state,
 	.get_gpio_mux			= rockchip_pinctrl_get_gpio_mux,
+	.gpio_request_enable		= rockchip_pinctrl_gpio_request_enable,
 };
 
 /* retrieve the soc specific data */
@@ -513,6 +543,7 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(struct udevice *d
 	drv_pmu_offs = ctrl->pmu_drv_offset;
 	drv_grf_offs = ctrl->grf_drv_offset;
 	bank = ctrl->pin_banks;
+	ctrl->nr_pins = 0;
 
 	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
 		int bank_pins = 0;
-- 
2.43.2

