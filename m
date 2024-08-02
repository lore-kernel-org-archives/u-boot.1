Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F74C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 22:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E37588BFF;
	Sat,  3 Aug 2024 00:57:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="JaQxwQ/O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B242D88BF5; Sat,  3 Aug 2024 00:57:23 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A19288BF5
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 00:57:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722639437; bh=SWTLCgE982SKoxCFjxYhFEajUtPMhsIptuBdl5mFecA=;
 b=JaQxwQ/OeBv3h90Gefu0IJpIngpks29ijQocptklNdzpRZ8fsXxTJJ3kvueo4Jf7CHRmt6ZVG
 3PMLTBpwHWbsl6UlebIasFmMtrbKf0l5yL/+Tb/Jl+AL1Zj+FqMOAT/OpkmIW1OlRvYGfzITrP5
 JbNRjWpEx46a1mw8KrKYlTQQEZVNYQXYOj93zw+yQnh5OvYp3WxjEr/hC2TvTS5LTUs4cUIYRgf
 szlvIbv61yhlP2+HdbyqaceTad7cYm++FD557szbgUqasSpo2Hny2tk6DHQ0vLGiEFuQGA93RCb
 /RUFp+CQT/qkQwoO5wSb8sBR0ZM56lyx+KOHEzZ6YCrw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 02/10] pinctrl: rockchip: Add a pin_to_bank() helper
Date: Fri,  2 Aug 2024 22:56:44 +0000
Message-ID: <20240802225705.2640999-3-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66ad644b16ac7a56c917ae8d
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

Add a pin_to_bank() helper that can locate a pin bank based on the pin
offset, to be used in get_gpio_mux() and gpio_request_enable() ops.

Reset ctrl->nr_pins to 0 so that pin_to_bank() can locate a bank after
the second probe in U-Boot proper.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch split from "pinctrl: rockchip: Add gpio_request_enable()
    ops" of "rockchip: Add gpio request() ops" series
---
 .../pinctrl/rockchip/pinctrl-rockchip-core.c   | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index f6af22501c36..894ff74aee98 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -176,6 +176,23 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
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
@@ -539,6 +556,7 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(struct udevice *d
 	drv_pmu_offs = ctrl->pmu_drv_offset;
 	drv_grf_offs = ctrl->grf_drv_offset;
 	bank = ctrl->pin_banks;
+	ctrl->nr_pins = 0;
 
 	for (i = 0; i < ctrl->nr_banks; ++i, ++bank) {
 		int bank_pins = 0;
-- 
2.45.2

