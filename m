Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607CECCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 15:51:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FF7882E34;
	Mon, 27 Oct 2025 16:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D22836F0; Mon, 27 Oct 2025 16:51:36 +0100 (CET)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9985782A9E
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 16:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4cwJ0512sCz12YW;
 Mon, 27 Oct 2025 16:51:33 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4cwJ035vxzzLZp; Mon, 27 Oct 2025 16:51:31 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/3] rockchip: more templating for binman and switch SPI
 image to rksd by default
Date: Mon, 27 Oct 2025 16:51:21 +0100
Message-Id: <20251027-rockchip-more-template-v1-0-430672840303@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPmU/2gC/x3MQQqDMBBG4avIrB3QFKP0KsVFiH90aDVhIlIQ7
 25w+S3eOylDBZne1UmKQ7LEraCtK/KL22awTMVkGtO1jelZo//6RRKvUcE71vRzO3iwLnQvG3o
 MlkqcFEH+z/gzXtcNt4TARGgAAAA=
X-Change-ID: 20251027-rockchip-more-template-86af536f7e86
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
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

The images to flash on SPI and MMC boot media are very similar and
binman templating engine allows to override properties after inserting
the template, so let's do that to template the whole boot image instead
of simply the FIT.

While at it, swap the default format for the SPI image from rkspi to
rksd. This patch should no change any behavior, just that the new SoCs
are expected to use rksd if unspecified instead of rkspi which is
assumed required only on some SoCs (like RK3399) due to some BootROM
bug/quirk.

Finally, a small cleanup of rk3288-tinker-s including twice the same
file.

Note that I'm planning on adding support for image signature to
rockchip-u-boot.dtsi in the next few days/weeks, which is the reason why
I'm doing this now as I've had to duplicate the work for the inclusion
of the pubkey in the SPL for the SPI and MMC images for no real reason.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (3):
      rockchip: binman: template all of simple-bin
      rockchip: make rksd the default format for SPI images
      rockchip: rk3288-tinker-s: remove duplicate include

 arch/arm/dts/px30-u-boot.dtsi              |  12 ++
 arch/arm/dts/rk3036-u-boot.dtsi            |  13 ++
 arch/arm/dts/rk3066a-u-boot.dtsi           |  12 ++
 arch/arm/dts/rk3128-u-boot.dtsi            |  12 ++
 arch/arm/dts/rk3188-u-boot.dtsi            |  12 ++
 arch/arm/dts/rk322x-u-boot.dtsi            |  12 ++
 arch/arm/dts/rk3288-tinker-s-u-boot.dtsi   |   1 -
 arch/arm/dts/rk3288-u-boot.dtsi            |  12 ++
 arch/arm/dts/rk3308-u-boot.dtsi            |  12 ++
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi |  12 ++
 arch/arm/dts/rk3328-u-boot.dtsi            |   1 -
 arch/arm/dts/rk3368-u-boot.dtsi            |  12 ++
 arch/arm/dts/rk3399-u-boot.dtsi            |  12 ++
 arch/arm/dts/rk3528-u-boot.dtsi            |  12 ++
 arch/arm/dts/rk356x-u-boot.dtsi            |   1 -
 arch/arm/dts/rk3576-u-boot.dtsi            |  12 ++
 arch/arm/dts/rk3588s-u-boot.dtsi           |   1 -
 arch/arm/dts/rockchip-u-boot.dtsi          | 283 ++++++++++++++---------------
 arch/arm/dts/rv1108-u-boot.dtsi            |  12 ++
 arch/arm/dts/rv1126-u-boot.dtsi            |  12 ++
 20 files changed, 320 insertions(+), 148 deletions(-)
---
base-commit: 9094482ca7576877b2bfaa57c8e73cfeb536f8b9
change-id: 20251027-rockchip-more-template-86af536f7e86

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

