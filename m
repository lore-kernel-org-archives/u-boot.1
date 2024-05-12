Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66D7C25B5F
	for <u-boot@archiver.kernel.org>; Sun, 12 May 2024 12:17:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01C54882AB;
	Sun, 12 May 2024 14:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="cIbMcGBx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDAE788299; Sun, 12 May 2024 14:17:43 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AF0087F33
 for <u-boot@lists.denx.de>; Sun, 12 May 2024 14:17:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=bf9f=MQ=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1715516227; bh=b3Q1s4bmKuHZgO9N3E9IGkC2kNikyveCH+Ez0/chLmE=;
 b=cIbMcGBxRyNENf7q5zjHWWlS/RgVD5Ah4GTYaRd/0D8XZdVySoiaDki4bayymCxMjp2AalWRt
 +Fwybbkv1MCZ3JLLql3UjKSb5fa0pwK1/LnweOWn0gtf/msvPoi+3B0lDjvhmTMidFeEHks7CGN
 9FjbZ5mqVFBMveU2zxaUOXa+VkX9TFQOWvFJ63XQfYAR/MBvzoeQ/WnWh3ilLlbfuPdRcV7GU9q
 2GR1bKLq6CWZdXGBiNDkgMtErkN7AtQkD8vBvPmh0cFUKcFEnaxoU5d7w3LCArd74ZJS+xzEaax
 IkMi9bOdd5RZAOaT3+W8pYQ6FDZZj/wIAr3wzYdmGoDg==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>
Cc: Johan Jonker <jbx6244@gmail.com>, Alex Bee <knaerzche@gmail.com>, Mark
 Kettenis <mark.kettenis@xs4all.nl>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
Subject: [PATCH 3/9] pinctrl: rockchip: rk3588: Fix support for
 rockchip_get_mux()
Date: Sun, 12 May 2024 12:16:16 +0000
Message-ID: <20240512121633.1632597-4-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 6640b3341cfb9f69e9a4f00c
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

GPIO IOMUX control is located at PMU2_IOC or BUS_IOC offset on RK3588.

Based on Linux commit fdc33eba11c5 ("pinctrl/rockchip: add rk3588
support").

Compared to the Linux commit, this include a fix so that the iomux of
GPIO0_B4-D7 is reported correctly.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
The fix to report correct iomux for GPIO0_B4-D7 will be sent to Linux.
---
 .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 24 ++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 973e6a4f6db9..efc2070d32d9 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -14,10 +14,10 @@
 #include <linux/libfdt.h>
 
 #include "pinctrl-rockchip.h"
+#include <dt-bindings/pinctrl/rockchip.h>
 
 #define MAX_ROCKCHIP_PINS_ENTRIES	30
 #define MAX_ROCKCHIP_GPIO_PER_BANK      32
-#define RK_FUNC_GPIO                    0
 
 static int rockchip_verify_config(struct udevice *dev, u32 bank, u32 pin)
 {
@@ -147,6 +147,28 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
 	if (bank->recalced_mask & BIT(pin))
 		rockchip_get_recalced_mux(bank, pin, &reg, &bit, &mask);
 
+	if (IS_ENABLED(CONFIG_ROCKCHIP_RK3588)) {
+		if (bank->bank_num == 0) {
+			if (pin >= RK_PB4 && pin <= RK_PD7) {
+				u32 reg0 = 0;
+
+				reg0 = reg + 0x4000 - 0xC; /* PMU2_IOC_BASE */
+				ret = regmap_read(regmap, reg0, &val);
+				if (ret)
+					return ret;
+
+				ret = ((val >> bit) & mask);
+				if (ret != 8)
+					return ret;
+
+				reg = reg + 0x8000; /* BUS_IOC_BASE */
+				regmap = priv->regmap_base;
+			}
+		} else if (bank->bank_num > 0) {
+			reg += 0x8000; /* BUS_IOC_BASE */
+		}
+	}
+
 	ret = regmap_read(regmap, reg, &val);
 	if (ret)
 		return ret;
-- 
2.43.2

