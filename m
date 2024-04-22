Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DA1C4345F
	for <u-boot@archiver.kernel.org>; Mon, 22 Apr 2024 16:42:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A9BE884A1;
	Mon, 22 Apr 2024 18:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E6C3888A5; Mon, 22 Apr 2024 18:41:59 +0200 (CEST)
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [84.16.66.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DD4A88493
 for <u-boot@lists.denx.de>; Mon, 22 Apr 2024 18:41:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VNWHS1YSQzb1V;
 Mon, 22 Apr 2024 18:41:56 +0200 (CEST)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4VNWHR1dQBzlry; Mon, 22 Apr 2024 18:41:55 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 0/2] rockchip: add support for Theobroma Systems
 SOM-RK3588-Q7 Tiger module
Date: Mon, 22 Apr 2024 18:41:40 +0200
Message-Id: <20240422-tiger-v1-0-8816b070d748@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAESTJmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0ML3ZLM9NQi3RRDU2NDYwOLZMtEAyWg2oKi1LTMCrA50bG1tQCS8q1
 gVwAAAA==
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Klaus Goger <klaus.goger@theobroma-systems.com>, 
 Heiko Stuebner <heiko.stuebner@cherry.de>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de, 
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
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

The RK3588-Q7 SoM is a Qseven-compatible (70mm x 70mm, MXM-230
connector) system-on-module from Theobroma Systems, featuring the
Rockchip RK3588.

It provides the following feature set:
 * up to 16GB LPDDR4x
 * on-module eMMC
 * SD card (on a baseboard) via edge connector
 * Gigabit Ethernet with on-module GbE PHY
 * HDMI/eDP
 * MIPI-DSI
 * 4x MIPI-CSI (3x on FPC connectors, 1x over Q7)
 * HDMI input over FPC connector
 * CAN
 * USB
   - 1x USB 3.0 dual-role (direct connection)
   - 2x USB 3.0 host + 1x USB 2.0 host
 * PCIe
   - 1x PCIe 2.1 Gen3, 4 lanes
   - 2xSATA / 2x PCIe 2.1 Gen1, 2 lanes
 * on-module ATtiny816 companion controller, implementing:
   - low-power RTC functionality (ISL1208 emulation)
   - fan controller (AMC6821 emulation)
  * on-module Secure Element with Global Platform 2.2.1 compliant
    JavaCard environment

The support is added for Tiger on Haikou devkit, similarly to RK3399
Puma and PX30 Ringneck.

The DTS and DTSI are taken from upstream Linux kernel v6.9-rc4.

Because Tiger doesn't use the same mux for the debug console as all
other RK3588 devices currently supported in U-Boot, an additional patch
is required to be able to interact with the device properly.

This has a light dependency on
https://lore.kernel.org/u-boot/20240415-rk35xx-dram-atags-v3-0-5bc5475b3c0d@theobroma-systems.com/
(the Tiger defconfig can be updated to remove the dependency if required)

Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
Quentin Schulz (2):
      rockchip: rk3588: add support for UART2 M1 and M2 in SPL
      rockchip: add support for Theobroma Systems SOM-RK3588-Q7 Tiger module

 arch/arm/dts/Makefile                              |   1 +
 arch/arm/dts/rk3588-tiger-haikou-u-boot.dtsi       |  54 ++
 arch/arm/dts/rk3588-tiger-haikou.dts               | 266 ++++++++
 arch/arm/dts/rk3588-tiger.dtsi                     | 690 +++++++++++++++++++++
 arch/arm/mach-rockchip/rk3588/Kconfig              |  41 ++
 arch/arm/mach-rockchip/rk3588/rk3588.c             |  36 ++
 board/theobroma-systems/tiger_rk3588/Kconfig       |  16 +
 board/theobroma-systems/tiger_rk3588/MAINTAINERS   |  13 +
 board/theobroma-systems/tiger_rk3588/Makefile      |  10 +
 .../theobroma-systems/tiger_rk3588/tiger_rk3588.c  |  53 ++
 configs/tiger-rk3588_defconfig                     | 114 ++++
 doc/board/rockchip/rockchip.rst                    |   1 +
 doc/board/theobroma-systems/index.rst              |   1 +
 doc/board/theobroma-systems/tiger_rk3588.rst       | 102 +++
 include/configs/tiger_rk3588.h                     |  15 +
 15 files changed, 1413 insertions(+)
---
base-commit: 5fb840ed8339cae3915ea1528a4bfa3e587540e6
change-id: 20240418-tiger-d1531308c9a0

Best regards,
-- 
Quentin Schulz <quentin.schulz@theobroma-systems.com>

