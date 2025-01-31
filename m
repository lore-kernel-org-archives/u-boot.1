Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9497CC0218F
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 10:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF96682824;
	Fri, 31 Jan 2025 11:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBDA782161; Fri, 31 Jan 2025 11:31:48 +0100 (CET)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch
 [83.166.143.168])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7C6982163
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 11:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YksdF4TlGznr4;
 Fri, 31 Jan 2025 11:31:45 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4YksdF0Y7nz7Xk; Fri, 31 Jan 2025 11:31:45 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Fri, 31 Jan 2025 11:31:31 +0100
Subject: [PATCH v2 03/13] pinctrl: rockchip: constify rockchip_pin_ctrl for
 RK3036
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-rockchip-pinctrl-const-v2-3-59bf93968ce7@cherry.de>
References: <20250131-rockchip-pinctrl-const-v2-0-59bf93968ce7@cherry.de>
In-Reply-To: <20250131-rockchip-pinctrl-const-v2-0-59bf93968ce7@cherry.de>
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
 drivers/pinctrl/rockchip/pinctrl-rk3036.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3036.c b/drivers/pinctrl/rockchip/pinctrl-rk3036.c
index b14386ccd937d2fcced72b6c9be6f7809194d3c1..8d0c0e0b6552a28e10758eff178e56e1dd0f865e 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3036.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3036.c
@@ -80,7 +80,7 @@ static struct rockchip_pin_bank rk3036_pin_banks[] = {
 	PIN_BANK(2, 32, "gpio2"),
 };
 
-static struct rockchip_pin_ctrl rk3036_pin_ctrl = {
+static const struct rockchip_pin_ctrl rk3036_pin_ctrl = {
 	.pin_banks		= rk3036_pin_banks,
 	.nr_banks		= ARRAY_SIZE(rk3036_pin_banks),
 	.grf_mux_offset		= 0xa8,

-- 
2.48.1

