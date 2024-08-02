Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C137EC3DA7F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 22:57:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A32F788C56;
	Sat,  3 Aug 2024 00:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="rrWgAtUK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59F3288C5C; Sat,  3 Aug 2024 00:57:29 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A58488C6D
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 00:57:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722639442; bh=yVhQCCd1ltmMk/XqeJw78tajZpL3Hlxav12JlaLlrhA=;
 b=rrWgAtUKCJ4B7vKuJaZ4Jbv11er6gT1vaxT7qjrDBvjuiSX7M+6j+H6l8955oPFValBBLjBEx
 mth1bwpgztsL04RRtYIoNIuW0/1xAdkDU4EVPe7thTnkiqbCRYs+jyvnW+AfO+OzvCldsm8LjNR
 8KmRdc4hl9CfyZyd0cmP7BDufk7/ssgoKQGQQmQHJV8F8dupAGoM8/YQVaZCBAj5i8OcKyNC3x7
 IEB834uLDr4Vo05JYIYhxIC1HoFRz6ifLIvrEhLcFmq1pYzevOrX8q56oG8CKQoeDsKCzQyKHf0
 QAooUdPEi1k5ZPkerGghvDFQXjivRpmGmr5nHxHkzQkg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 04/10] pinctrl: rockchip: Add pinmux status related ops
Date: Fri,  2 Aug 2024 22:56:46 +0000
Message-ID: <20240802225705.2640999-5-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66ad645116ac7a56c917aeb7
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
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
v2: Collect r-b tag
---
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 50 ++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 8ede74da40c9..345e0abdf5d1 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -126,7 +126,7 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 
 	if (bank->iomux[iomux_num].type & IOMUX_UNROUTED) {
 		debug("pin %d is unrouted\n", pin);
-		return -EINVAL;
+		return -ENOENT;
 	}
 
 	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY)
@@ -193,6 +193,32 @@ static struct rockchip_pin_bank *rockchip_pin_to_bank(struct udevice *dev,
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
@@ -221,6 +247,25 @@ static int rockchip_pinctrl_get_gpio_mux(struct udevice *dev, int banknum,
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
@@ -558,8 +603,11 @@ static int rockchip_pinctrl_set_state(struct udevice *dev,
 }
 
 const struct pinctrl_ops rockchip_pinctrl_ops = {
+	.get_pins_count			= rockchip_pinctrl_get_pins_count,
+	.get_pin_name			= rockchip_pinctrl_get_pin_name,
 	.set_state			= rockchip_pinctrl_set_state,
 	.get_gpio_mux			= rockchip_pinctrl_get_gpio_mux,
+	.get_pin_muxing			= rockchip_pinctrl_get_pin_muxing,
 };
 
 /* retrieve the soc specific data */
-- 
2.45.2

