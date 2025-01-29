Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4ADC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 12:42:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D4F281EEF;
	Wed, 29 Jan 2025 13:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6427E81DD3; Wed, 29 Jan 2025 13:42:35 +0100 (CET)
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::42ae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC59180ECD
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 13:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yjhd432GWz37h;
 Wed, 29 Jan 2025 13:42:32 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Yjhd34ScvzSl6; Wed, 29 Jan 2025 13:42:31 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Jan 2025 13:42:21 +0100
Subject: [PATCH 02/14] pinctrl: rockchip: remove unused nr_pins controller
 member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-rockchip-pinctrl-const-v1-2-450ccdadfa7e@cherry.de>
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

Each controller has an nr_pins member that is set either through the
rockchip_pin_ctrl struct or from the core (or both).

This is an issue because on RK3568, RK3588 and RV1126, the struct is
const, this means it shouldn't be modified at all. This will trigger a
CPU abort once we enforce the read-only at the MMU level in a few
releases, therefore let's remove this useless (and broken, and soon
breaking) code.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/pinctrl/rockchip/pinctrl-rk3568.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3588.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 1 -
 drivers/pinctrl/rockchip/pinctrl-rockchip.h      | 1 -
 drivers/pinctrl/rockchip/pinctrl-rv1126.c        | 1 -
 5 files changed, 5 deletions(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3568.c b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
index 5deedc648a41950461b6a468e4852fa0a5384207..c8a91b8bb6e925e0f2e7d6cd09f8a06a58be60dd 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3568.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3568.c
@@ -345,7 +345,6 @@ static struct rockchip_pin_bank rk3568_pin_banks[] = {
 static const struct rockchip_pin_ctrl rk3568_pin_ctrl = {
 	.pin_banks		= rk3568_pin_banks,
 	.nr_banks		= ARRAY_SIZE(rk3568_pin_banks),
-	.nr_pins		= 160,
 	.grf_mux_offset		= 0x0,
 	.pmu_mux_offset		= 0x0,
 	.iomux_routes		= rk3568_mux_route_data,
diff --git a/drivers/pinctrl/rockchip/pinctrl-rk3588.c b/drivers/pinctrl/rockchip/pinctrl-rk3588.c
index 98ababc7c90700c4b27359fc3625519f20437306..fd8e617b9108c7314b8fdd4bbe1dfae71f1b6449 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rk3588.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rk3588.c
@@ -324,7 +324,6 @@ static struct rockchip_pin_bank rk3588_pin_banks[] = {
 static const struct rockchip_pin_ctrl rk3588_pin_ctrl = {
 	.pin_banks		= rk3588_pin_banks,
 	.nr_banks		= ARRAY_SIZE(rk3588_pin_banks),
-	.nr_pins		= 160,
 	.set_mux		= rk3588_set_mux,
 	.set_pull		= rk3588_set_pull,
 	.set_drive		= rk3588_set_drive,
diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index 7369fe12b961290742f6ba24fb32b768531f56f9..b87aed709d62d1e85d0d199c2d6c92aeaec67487 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -543,7 +543,6 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(struct udevice *d
 		int bank_pins = 0;
 
 		bank->priv = priv;
-		ctrl->nr_pins += bank->nr_pins;
 
 		/* calculate iomux and drv offsets */
 		for (j = 0; j < 4; j++) {
diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip.h b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
index ebd008eede24af32c123634a57f50c0294e76842..2910bbb570d8736487b8cb6c9f87f3e164858b5b 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip.h
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
@@ -498,7 +498,6 @@ struct rockchip_mux_route_data {
 struct rockchip_pin_ctrl {
 	struct rockchip_pin_bank	*pin_banks;
 	u32				nr_banks;
-	u32				nr_pins;
 	int				grf_mux_offset;
 	int				pmu_mux_offset;
 	int				grf_drv_offset;
diff --git a/drivers/pinctrl/rockchip/pinctrl-rv1126.c b/drivers/pinctrl/rockchip/pinctrl-rv1126.c
index efa2408b204b421ad1c5a36b039d8c07c5b7237e..3878a5420dcc98f591e4eefadd78a2fe98b61c7e 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rv1126.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rv1126.c
@@ -381,7 +381,6 @@ static struct rockchip_pin_bank rv1126_pin_banks[] = {
 static const struct rockchip_pin_ctrl rv1126_pin_ctrl = {
 	.pin_banks		= rv1126_pin_banks,
 	.nr_banks		= ARRAY_SIZE(rv1126_pin_banks),
-	.nr_pins		= 130,
 	.grf_mux_offset		= 0x10004, /* mux offset from GPIO0_D0 */
 	.pmu_mux_offset		= 0x0,
 	.iomux_routes		= rv1126_mux_route_data,

-- 
2.48.1

