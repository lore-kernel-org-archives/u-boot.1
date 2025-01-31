Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD4FC0218D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jan 2025 10:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA90682163;
	Fri, 31 Jan 2025 11:31:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id C81788219C; Fri, 31 Jan 2025 11:31:46 +0100 (CET)
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch
 [84.16.66.170])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AFF182131
 for <u-boot@lists.denx.de>; Fri, 31 Jan 2025 11:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YksdC71XVzpd8;
 Fri, 31 Jan 2025 11:31:43 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4YksdB56qpz6g2; Fri, 31 Jan 2025 11:31:42 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH v2 00/13] pinctrl: rockchip: fix editing const struct +
 constify rockchip_pin_ctrl
Date: Fri, 31 Jan 2025 11:31:28 +0100
Message-Id: <20250131-rockchip-pinctrl-const-v2-0-59bf93968ce7@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIGmnGcC/4WNQQrCMBBFryKzdiSJLVpX3kO6CJOpGZSkTEqxl
 N7d2Au4fA/++ysUVuECt8MKyrMUyamCOx6Aok9PRgmVwRnXGus61EwvijLiKIkmfSPlVCYcGuv
 Oxna+vTZQx6PyIJ89/OgrRylT1mX/me3P/k3OFg02rSEKPgz+wneKrLqcAkO/bdsX1RVwvrwAA
 AA=
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

This also means we should be able to constify the private data of the
controller device for all Rockchip devices, instead of having those only
for RK356x, RK3588 and RV1126. With the constify done on top of Ilias
patch series[1], my PX30 Ringneck, RK3399 Puma and RK3588 Tiger all
reach U-Boot CLI. No further testing (like booting into Linux userspace)
was done.

[1] https://lore.kernel.org/u-boot/20250130072100.27297-1-ilias.apalodimas@linaro.org/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Changes in v2:
- remove removal of bank's pin_base because Jonas said he'll need it for
  a new version of https://lore.kernel.org/u-boot/20240802225705.2640999-1-jonas@kwiboo.se/
- fix pin_base computing by init'ing the controller nr_pins to 0,
- make controller nr_pins local to the probe function instead of keeping
  it in rockchip_pin_ctrl struct,
- Link to v1: https://lore.kernel.org/r/20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de

---
Quentin Schulz (13):
      pinctrl: rockchip: fix bank's pin_base computing
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
 drivers/pinctrl/rockchip/pinctrl-rockchip-core.c | 5 +++--
 drivers/pinctrl/rockchip/pinctrl-rockchip.h      | 1 -
 drivers/pinctrl/rockchip/pinctrl-rv1108.c        | 2 +-
 drivers/pinctrl/rockchip/pinctrl-rv1126.c        | 1 -
 17 files changed, 15 insertions(+), 18 deletions(-)
---
base-commit: 021baf7b08cceb58bb850859dba1614424e16a83
change-id: 20250129-rockchip-pinctrl-const-f4123019a584

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

