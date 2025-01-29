Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CB5C02190
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 12:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B9981F4D;
	Wed, 29 Jan 2025 13:42:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2C4781FC8; Wed, 29 Jan 2025 13:42:41 +0100 (CET)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [83.166.143.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A40C81F7B
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 13:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YjhdB1Zr2ztmH;
 Wed, 29 Jan 2025 13:42:38 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Yjhd93GndzRdb; Wed, 29 Jan 2025 13:42:37 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Jan 2025 13:42:28 +0100
Subject: [PATCH 09/14] pinctrl: rockchip: constify rockchip_pin_ctrl for RK3288
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-rockchip-pinctrl-const-v1-9-450ccdadfa7e@cherry.de>
References: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
In-Reply-To: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
To: Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@edgeble.ai>, 
 u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

There's no need to modify private data from the controller, so let's
make that struct const.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/pinctrl/rockchip/pinctrl-rk3288.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3288.c b/drivers/pinctrl/rockchip/pinctrl-rk3288.c
index 3870c1b7a341f998cc0b3cfcaa3a0acbdd0daa39..d3ad1f70e5d60929fafff533c41bd66d1afb3401 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3288.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3288.c
@@ -212,7 +212,7 @@ static struct rockchip_pin_bank rk3288_pin_banks[] = {
 	PIN_BANK(8, 16, "gpio8"),
 };
 
-static struct rockchip_pin_ctrl rk3288_pin_ctrl = {
+static const struct rockchip_pin_ctrl rk3288_pin_ctrl = {
 	.pin_banks		= rk3288_pin_banks,
 	.nr_banks		= ARRAY_SIZE(rk3288_pin_banks),
 	.grf_mux_offset		= 0x0,

-- 
2.48.1

