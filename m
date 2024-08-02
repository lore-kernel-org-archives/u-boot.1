Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF365C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 22:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB82788C71;
	Sat,  3 Aug 2024 00:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="mkYMUndS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C935588C6F; Sat,  3 Aug 2024 00:57:34 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D610A88C04
 for <u-boot@lists.denx.de>; Sat,  3 Aug 2024 00:57:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=5651=PC=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1722639445; bh=kY5SnPr3b/s4p/5MEwgE2B+8MI40+nQRNyQw1NT29O0=;
 b=mkYMUndSv9tv6PFtZJCfw0vaz5y+lm+yKq9f6UKwlKm2hd+0w5auVgW8jq17XYQV7h2/lalaB
 d5PtGC+z0mqyNVKC94U8iw3MkMDGMxKaXeDIABRpqpRW4MQaZRLnRd85uNm9Tp/fpeT6aPdkcjX
 ZT1rckd33QBloiWIojEStYBacet0gEFFmNOPz2IVUAImRFVKx6dVCM+C0SQytvv24ie8+i9/qAJ
 zdUNIHsp91gGiBOP6ix0HmVWOAXESnVXeUpoourB6jDN6Z6dhMIxF1sY+ca3N2NLPl3dxvLfHS/
 QI3UL0CCpxtaUCWF6X+lnOiwC7JcEMKqatBJDI6ZZYzg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 05/10] pinctrl: rockchip: Add gpio_request_enable() ops
Date: Fri,  2 Aug 2024 22:56:47 +0000
Message-ID: <20240802225705.2640999-6-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66ad645416ac7a56c917aec9
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

Implement gpio_request_enable() ops so that the gpio request() ops can
be implemented and a gpio requested pin automatically is pinmuxed for
gpio use, similar to Linux kernel.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: New patch from "rockchip: Add gpio request() ops" series
---
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 345e0abdf5d1..e164af0d8f61 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -358,6 +358,18 @@ static int rockchip_set_mux(struct rockchip_pin_bank *bank, int pin, int mux)
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
@@ -608,6 +620,7 @@ const struct pinctrl_ops rockchip_pinctrl_ops = {
 	.set_state			= rockchip_pinctrl_set_state,
 	.get_gpio_mux			= rockchip_pinctrl_get_gpio_mux,
 	.get_pin_muxing			= rockchip_pinctrl_get_pin_muxing,
+	.gpio_request_enable		= rockchip_pinctrl_gpio_request_enable,
 };
 
 /* retrieve the soc specific data */
-- 
2.45.2

