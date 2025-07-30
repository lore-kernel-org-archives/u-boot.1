Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C41C87FC9
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 11:11:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E89783102;
	Wed, 30 Jul 2025 13:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C23A8311B; Wed, 30 Jul 2025 13:11:11 +0200 (CEST)
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::1909])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD6E681E06
 for <u-boot@lists.denx.de>; Wed, 30 Jul 2025 13:11:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4bsTzb2Vd0zY4w;
 Wed, 30 Jul 2025 13:11:07 +0200 (CEST)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4bsTzZ0x18zxZk; Wed, 30 Jul 2025 13:11:06 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/6] rockchip: puma-rk3399: anticipate breakage with v6.16 DT
Date: Wed, 30 Jul 2025 13:10:16 +0200
Message-Id: <20250730-puma-usb-cypress-v1-0-b1c203c733f9@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJj9iWgC/02OQW7DIBBFr2LNukgwQAy+ShVZA4xrFrYTiKNUU
 e4eknTR5fvSf3p3qFwyVxi6OxS+5pq3tYH66iDOtP6wyKkxoEQrey3FaV9I7DWI+HsqXKvAhN7
 2Eo1BA+3W1inf3srv44cLn/dmvnxGCFRZxG1Z8mXoLLmUkGV0xiltg43+QBN6ReQP3HuK0aPmC
 P+Lhu7dY9C+UsZtDRuVNM57GP+yxvmmBTqtvNOT4sTD1cDx8XgCOI7dfPEAAAA=
X-Change-ID: 20250730-puma-usb-cypress-2d2957024424
To: Klaus Goger <klaus.goger@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Benjamin Bara <benjamin.bara@skidata.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 "Rob Herring (Arm)" <robh@kernel.org>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, stable@vger.kernel.org, 
 Heiko Stuebner <heiko@sntech.de>
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

Due to updates to the Device Tree (migrating to onboard USB hub nodes
instead of (badly) hacking things with a gpio regulator that doesn't
actually work properly), we now need to enable the onboard USB hub
driver in U-Boot.

This anticipates upcoming breakage when 6.16 DT will be merged into
U-Boot's dts/upstream.

The series can be applied as is before v6.16 DT is merged or only the
defconfig changes after 6.16 DT has been merged.

The last two patches are simply to avoid probing devices that aren't
actually routed on RK3399 Puma, which is nice to have but doesn't fix
anything.

Note that this depends on the following series:
https://lore.kernel.org/u-boot/20250722-usb_onboard_hub_cypress_hx3-v4-0-91c3ee958c0e@thaumatec.com/

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Lukasz Czechowski (2):
      dt-bindings: usb: cypress,hx3: Add support for all variants
      arm64: dts: rockchip: fix internal USB hub instability on RK3399 Puma

Quentin Schulz (4):
      configs: puma-rk3399: enable onboard USB hub support
      dt-bindings: usb: usb-device: relax compatible pattern to a contains
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma
      arm64: dts: rockchip: disable unrouted USB controllers and PHY on RK3399 Puma with Haikou

 configs/puma-rk3399_defconfig                      |  1 +
 dts/upstream/Bindings/usb/cypress,hx3.yaml         | 19 +++++++--
 dts/upstream/Bindings/usb/usb-device.yaml          |  3 +-
 .../src/arm64/rockchip/rk3399-puma-haikou.dts      |  8 ----
 dts/upstream/src/arm64/rockchip/rk3399-puma.dtsi   | 48 +++++++++++-----------
 5 files changed, 43 insertions(+), 36 deletions(-)
---
base-commit: 5a8dd2e0c848135b5c96af291aa96e79acc923ec
change-id: 20250730-puma-usb-cypress-2d2957024424
prerequisite-change-id: 20250425-usb_onboard_hub_cypress_hx3-2831983f1ede:v4
prerequisite-patch-id: 515a13b22600d40716e9c36d16b084086ce7d474
prerequisite-patch-id: 9f8a11bd6c66e976c51dc0f0bc3292183f9403f3
prerequisite-patch-id: 45ef5b9422333db5fcd23d95b6570b320635c49b
prerequisite-patch-id: 19092f1c3db746292401b8513807439c87ea9589
prerequisite-patch-id: fced7578d40069c5fe83d97aa42476015cf9cbda

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

