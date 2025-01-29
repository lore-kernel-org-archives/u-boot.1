Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B31EAC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 12:42:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D666881875;
	Wed, 29 Jan 2025 13:42:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5797881727; Wed, 29 Jan 2025 13:42:33 +0100 (CET)
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch
 [83.166.143.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFDED8081A
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 13:42:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yjhd242TGz3mJ;
 Wed, 29 Jan 2025 13:42:30 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Yjhd116MfzT3B; Wed, 29 Jan 2025 13:42:29 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 00/14] pinctrl: rockchip: fix editing const struct +
 constify rockchip_pin_ctrl
Date: Wed, 29 Jan 2025 13:42:19 +0100
Message-Id: <20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACsimmcC/x3MMQqAMAxA0atIZgNtVVCvIg4SowalLamIIN7d4
 viG/x9IrMIJ+uIB5UuSBJ9hywJom/zKKHM2OOMaY12HGminTSJG8XTqgRR8OnGprauM7aamrSH
 HUXmR+x8P4/t+LOqmNmgAAAA=
X-Change-ID: 20250129-rockchip-pinctrl-const-f4123019a584
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

While testing some WIP work done by Ilias Apalodimas on guaranteeing
read-only memory areas truly are handled as read-only[1], my RK3588
Tiger couldn't reach U-Boot CLI anymore because of the pinctrl driver
modifying a const struct rockchip_pin_ctrl, triggering a CPU abort.

Instead of going the lazy way and unconstify it, let's fix the actual
issue in play.

The member modified in the const is only ever used for setting a member
from another struct (not const that one). However this other member is
never read! Therefore we can simply afford to remove it which means the
sole reader of the member in the const is now gone, thus making it
possible to remove the member from the const struct as well.

This also means we should be able to constify the private data of the
controller device for all Rockchip devices, instead of having those only
for RK356x, RK3588 and RV1126. With the constify done on top of Ilias
branch[1], my PX30 Ringneck, RK3399 Puma and RK3588 Tiger all reach
U-Boot CLI. No further test (like booting into Linux userspace) was
done.

[1] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/tree/fix_memory_permissions

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (14):
      pinctrl: rockchip: remove unused base_pin bank member
      pinctrl: rockchip: remove unused nr_pins controller member
      pinctrl: rockchip: constify rockchip_pin_ctrl for PX30
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3036
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3066
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3128
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3188
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3228
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3288
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3308
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3328
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3368
      pinctrl: rockchip: constify rockchip_pin_ctrl for RK3399
      pinctrl: rockchip: constify rockchip_pin_ctrl for RV1108

 drivers/pinctrl/rockchip/pinctrl-px30.c          | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3036.c        | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3066.c        | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3128.c        | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3188.c        | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rk322x.c        | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3288.c        | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3308.c        | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3328.c        | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3368.c        | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3399.c        | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rk3568.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rk3588.c        | 1 -
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 2 --
 drivers/pinctrl/rockchip/pinctrl-rockchip.h      | 3 ---
 drivers/pinctrl/rockchip/pinctrl-rv1108.c        | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rv1126.c        | 1 -
 17 files changed, 12 insertions(+), 20 deletions(-)
---
base-commit: a2b489b170f8382f746202c36616eaf2bc38fe86
change-id: 20250129-rockchip-pinctrl-const-f4123019a584

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

