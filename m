Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10171C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 12:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25DE081DFA;
	Wed, 29 Jan 2025 13:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB748197D; Wed, 29 Jan 2025 13:42:34 +0100 (CET)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 047A48092B
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 13:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yjhd3427pz2tc;
 Wed, 29 Jan 2025 13:42:31 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Yjhd250brzT5d; Wed, 29 Jan 2025 13:42:30 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 29 Jan 2025 13:42:20 +0100
Subject: [PATCH 01/14] pinctrl: rockchip: remove unused base_pin bank
 member
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250129-rockchip-pinctrl-const-v1-1-450ccdadfa7e@cherry.de>
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

Each bank has a base_pin member that is only set in the core and never
used, so it can be removed.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 1 -
 drivers/pinctrl/rockchip/pinctrl-rockchip.h      | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
index d449d07d32e74d1dec1978b1405bec94887908a2..7369fe12b961290742f6ba24fb32b768531f56f9 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
@@ -543,7 +543,6 @@ static struct rockchip_pin_ctrl *rockchip_pinctrl_get_soc_data(struct udevice *d
 		int bank_pins = 0;
 
 		bank->priv = priv;
-		bank->pin_base = ctrl->nr_pins;
 		ctrl->nr_pins += bank->nr_pins;
 
 		/* calculate iomux and drv offsets */
diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip.h b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
index df7bc684d29fae4ec650d1e14fe88b35b03244ac..ebd008eede24af32c123634a57f50c0294e76842 100644
--- a/drivers/pinctrl/rockchip/pinctrl-rockchip.h
+++ b/drivers/pinctrl/rockchip/pinctrl-rockchip.h
@@ -262,7 +262,6 @@ struct rockchip_drv {
 
 /**
  * @priv: common pinctrl private basedata
- * @pin_base: first pin number
  * @nr_pins: number of pins in this bank
  * @name: name of the bank
  * @bank_num: number of the bank, to account for holes
@@ -274,7 +273,6 @@ struct rockchip_drv {
  */
 struct rockchip_pin_bank {
 	struct rockchip_pinctrl_priv	*priv;
-	u32				pin_base;
 	u8				nr_pins;
 	char				*name;
 	u8				bank_num;

-- 
2.48.1

