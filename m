Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D6BC25B74
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 09:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B94638864A;
	Fri, 24 May 2024 11:23:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 516FE88545; Fri, 24 May 2024 11:23:58 +0200 (CEST)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::bc0e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8FB4884BE
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 11:23:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Vm03H2n6nzs5L;
 Fri, 24 May 2024 11:23:55 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4Vm03D51t1zwmp; Fri, 24 May 2024 11:23:52 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH next v2 0/8] rockchip: px30: migrate to common bss and
 stack addresses and OF_UPSTREAM
Date: Fri, 24 May 2024 11:23:25 +0200
Message-Id: <20240524-px30-of_upstream-v2-0-fdc7887097a2@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI1cUGYC/x3MQQqAIBBA0avErBPMiqyrRITpVLPIRC2E6O5Jy
 7f4/4GAnjDAUDzg8aZAp80QZQF6V3ZDRiYbBBcNb7lkLtWcnet8uRA9qoNVcjGLQtnpXkLOnMe
 V0r8cwWKKML3vB+2PjLdoAAAA
To: Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
 Heiko Stuebner <heiko.stuebner@theobroma-systems.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Suniel Mahesh <sunil@amarulasolutions.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Heiko Stuebner <heiko@sntech.de>
X-Mailer: b4 0.13.0
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

Following up on migrating PX30 Ringneck to the new common bss and stack
addresses as done in
https://lore.kernel.org/u-boot/20240523-px30-2024-07-rc-v2-0-e46782d5520c@cherry.de/T/#t
let's migrate all other px30 boards to this new memory layout so that it
aligns with other Rockchip SoCs (TPL excluded).

This also migrates all (but firefly-px30) PX30-based boards to use
OF_UPSTREAM. firefly-px30 doesn't have an upstream kernel device tree so
it is left untouched.
All but Odroid-Go2 were straightforward to migrate.

While at it, also fix a few issues related to UART on the PX30 Mini EVB
I could test.

This was boot tested on PX30 Ringneck and PX30 Mini EVB, U-Boot CLI and
Linux kernel userspace are reached.

This is based on next + https://lore.kernel.org/u-boot/20240523-px30-2024-07-rc-v2-0-e46782d5520c@cherry.de/T/#t

To: Kever Yang <kever.yang@rock-chips.com>
To: Tom Rini <trini@konsulko.com>
To: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
To: Jagan Teki <jagan@amarulasolutions.com>
To: Suniel Mahesh <sunil@amarulasolutions.com>
To: Simon Glass <sjg@chromium.org>
To: Philipp Tomsich <philipp.tomsich@vrull.eu>
To: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: u-boot@lists.denx.de
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>

Changes in v2:
- remove px30-base and ringneck patches, they were sent for master
- migrate boards to OF_UPSTREAM
- Link to v1: https://lore.kernel.org/r/20240521-px30-2024-07-rc-v1-0-62109c84d44f@cherry.de

independently: https://lore.kernel.org/u-boot/20240523-px30-2024-07-rc-v2-0-e46782d5520c@cherry.de/T/#t
---
Quentin Schulz (8):
      rockchip: evb-px30: Use common bss and stack addresses
      rockchip: firefly-px30: Use common bss and stack addresses
      rockchip: odroid-go2: Use common bss and stack addresses
      rockchip: px30-core-*: Use common bss and stack addresses
      rockchip: px30: make UART pinmux accessible to TPL/SPL DTB
      rockchip: evb-px30: do not remove pinctrl nodes from SPL DTB
      rockchip: evb-px30: make UART5 the debug UART
      rockchip: px30/rk3326: migrate to OF_UPSTREAM

 arch/arm/dts/Makefile                              |   8 -
 arch/arm/dts/px30-engicam-common.dtsi              | 129 -----
 arch/arm/dts/px30-engicam-ctouch2.dtsi             |  30 -
 arch/arm/dts/px30-engicam-edimm2.2.dtsi            |  66 ---
 .../dts/px30-engicam-px30-core-ctouch2-of10.dts    |  77 ---
 arch/arm/dts/px30-engicam-px30-core-ctouch2.dts    |  22 -
 arch/arm/dts/px30-engicam-px30-core-edimm2.2.dts   |  43 --
 arch/arm/dts/px30-engicam-px30-core.dtsi           | 241 --------
 arch/arm/dts/px30-evb.dts                          | 634 --------------------
 arch/arm/dts/px30-ringneck-haikou.dts              | 232 --------
 arch/arm/dts/px30-ringneck.dtsi                    | 382 ------------
 arch/arm/dts/px30-u-boot.dtsi                      |  16 +
 arch/arm/dts/rk3326-odroid-go2-u-boot.dtsi         |  15 +
 arch/arm/dts/rk3326-odroid-go2.dts                 | 642 ---------------------
 arch/arm/mach-rockchip/Kconfig                     |   1 +
 configs/evb-px30_defconfig                         |  24 +-
 configs/firefly-px30_defconfig                     |  19 +-
 configs/odroid-go2_defconfig                       |  20 +-
 configs/px30-core-ctouch2-of10-px30_defconfig      |  20 +-
 configs/px30-core-ctouch2-px30_defconfig           |  20 +-
 configs/px30-core-edimm2.2-px30_defconfig          |  20 +-
 configs/ringneck-px30_defconfig                    |   2 +-
 22 files changed, 59 insertions(+), 2604 deletions(-)
---
base-commit: 5e9aa577480ffbb6d3d0af6b972f227e087eef49
change-id: 20240508-px30-of_upstream-18bdbae87c98

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

