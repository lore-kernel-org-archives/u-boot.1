Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FFECD3435
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 17:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F1E83D0D;
	Wed, 12 Nov 2025 18:48:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 251CB83D0B; Wed, 12 Nov 2025 18:48:44 +0100 (CET)
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch
 [83.166.143.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C738283C62
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 18:48:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d69qs42Msz8Gc;
 Wed, 12 Nov 2025 18:48:41 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d69qq4f7JzsYj; Wed, 12 Nov 2025 18:48:39 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Subject: [PATCH 00/11] led: remove u-boot,boot-led and u-boot,error-led +
 add cmd doc
Date: Wed, 12 Nov 2025 18:48:05 +0100
Message-Id: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0Mj3ZzUFN38nBTdlBLdlGQjEzMD05SUZAsLJaCGgqLUtMwKsGHRsbW
 1AIVnCjNcAAAA
X-Change-ID: 20251112-led-old-dt-dc24605ddc88
To: Ziping Chen <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Klaus Goger <klaus.goger@cherry.de>, 
 Eugen Hristev <eugen.hristev@linaro.org>, 
 Durai Manickam KR <durai.manickamkr@microchip.com>, 
 Stefan Roese <sr@denx.de>, Zixun LI <admin@hifiphile.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, 
 Yegor Yefremov <yegorslists@googlemail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Alexander Dahl <ada@thorsis.com>
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

u-boot,boot-led and u-boot,error-led aren't actually handled by some
generic code but rather by board or architecture specific code. They
also aren't properties that are part of the official dt-binding so they
cannot be upstreamed. For u-boot,boot-led, there's actually a proper
replacement which is /options/u-boot/boot-led[1] (+ CONFIG_LED_BOOT=y).

For Rockchip boards, either nothing (for RK3066, PX30 and RK3399) was
using that property or (for RK3188) the code handling it was guarded by
symbols that were not enabled in the defconfig. For those, the property
and guarded code are removed.

For the Sam9x60 Curiosity, it seems that even though the LED is
controlled whenever CONFIG_LED is enabled, it isn't enabled by default
in the defconfig (but the code was added without modifying the
defconfig, explicitly leaving a choice to the user). I decided to keep
that feature by simply migrating it to the new API, though I cannot test
it as I do not own the device.

The STM32 boards will be migrated in the near future once their upstream
(kernel) Device Trees gain the new way to specify this (via
/options/u-boot/boot-led). I'll let Patrice handle this, see
https://lore.kernel.org/u-boot/94ed1988-13e8-4fe3-bdff-ba2c9973c556@foss.st.com/
and
https://lore.kernel.org/u-boot/2a3aa43a-ce19-41e1-ab56-556629ce5cf9@foss.st.com/

After this, only one user of u-boot,boot-led will be left, based on
STM32: board/dhelectronics/dh_stm32mp1/board.c. @Patrice, maybe that's
something you want to have a look at as well, this seems to be some
evaluation kit?

The only users of u-boot,error-led are STM32 boards, so I'll leave this
to Patrice as well, I do not know what's the way to go for that one.

In any case, I would like to not encourage people to use out-of-spec DT
properties when there is another option (u-boot,boot-led), so I remove
the properties from the dt-binding document from U-Boot.

The help text for the blink subcommand of the led command was misleading
so this is now fixed.

This also moves the content of doc/README.LED into the doc/api/led.rst,
while clearly stating one shouldn't be using this anymore.

This also gets rid of dt-binding that we already have in dts/upstream.

Finally, this adds documentation for the led shell command.

[1] https://github.com/devicetree-org/dt-schema/blob/v2025.08/dtschema/schemas/options/u-boot.yaml#L113-L116

Reported-by: Yegor Yefremov <yegorslists@googlemail.com>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
Quentin Schulz (11):
      cmd: led: fix help text for blink subcommand
      doc: move legacy API documented in README.LED to doc/api/led.rst
      doc: cmd: document the led shell command
      doc: dt-bindings: remove duplicates with dts/upstream
      arm: dts: rockchip: rk3188-radxarock: remove unused u-boot,boot-led
      rockchip: rk3188: remove setup_led from xPL
      arm: dts: rockchip: rk3399-puma: remove u-boot,boot-led
      arm: dts: rockchip: px30-ringneck: remove u-boot,boot-led
      arm: dts: rockchip: rk3066a-mk808: remove unused u-boot,boot-led
      sam9x60-curiosity: migrate Boot LED setup to use /options/u-boot/boot-led
      doc: remove u-boot,boot-led and u-boot,error-led from "binding"

 arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi   |   9 +-
 arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi     |   1 -
 arch/arm/dts/rk3066a-mk808-u-boot.dtsi            |   6 -
 arch/arm/dts/rk3188-radxarock-u-boot.dtsi         |   5 -
 arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi       |   1 -
 arch/arm/mach-rockchip/Kconfig                    |   1 -
 arch/arm/mach-rockchip/rk3188/rk3188.c            |  36 ------
 board/atmel/sam9x60_curiosity/sam9x60_curiosity.c |  16 +--
 cmd/led.c                                         |  11 +-
 doc/README.LED                                    |  77 ------------
 doc/api/led.rst                                   |  89 +++++++++++++-
 doc/device-tree-bindings/config.txt               |   5 -
 doc/device-tree-bindings/leds/leds-bcm6328.txt    | 106 ----------------
 doc/device-tree-bindings/leds/leds-bcm6358.txt    | 141 ----------------------
 doc/device-tree-bindings/leds/leds-gpio.txt       |  52 --------
 doc/device-tree-bindings/leds/leds-lp5562.txt     |  63 ----------
 doc/usage/cmd/led.rst                             |  95 +++++++++++++++
 17 files changed, 194 insertions(+), 520 deletions(-)
---
base-commit: caa740df9cae5ddc74b18b88a4fea43e27b2fdf6
change-id: 20251112-led-old-dt-dc24605ddc88

Best regards,
-- 
Quentin Schulz <quentin.schulz@cherry.de>

