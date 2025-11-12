Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0583BCD3435
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 17:49:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B3783D5D;
	Wed, 12 Nov 2025 18:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 858DE83D39; Wed, 12 Nov 2025 18:48:46 +0100 (CET)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42af])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91CC683CB5
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 18:48:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch
 [10.7.10.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d69qw2J9xz8bl;
 Wed, 12 Nov 2025 18:48:44 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d69qv2cCHztgx; Wed, 12 Nov 2025 18:48:43 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Nov 2025 18:48:08 +0100
Subject: [PATCH 03/11] doc: cmd: document the led shell command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-led-old-dt-v1-3-2892d49517db@cherry.de>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
In-Reply-To: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
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

From: Quentin Schulz <quentin.schulz@cherry.de>

This adds documentation on how to use the led shell command.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/usage/cmd/led.rst | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/doc/usage/cmd/led.rst b/doc/usage/cmd/led.rst
new file mode 100644
index 00000000000..b5623895c7e
--- /dev/null
+++ b/doc/usage/cmd/led.rst
@@ -0,0 +1,95 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+.. index::
+   single: led (command)
+
+led command
+===========
+
+Synopsis
+--------
+
+::
+
+    led <led_label> <on|off|toggle>
+    led <led_label> blink <blink-freq in ms>
+    led <led_label>
+    led list
+
+led <led_label>
+---------------
+
+Get state of the LED whose label is the one passed as ``<led_label>`` argument.
+
+Provided ``<led_label>`` is *module_led*, the possible outputs for this command
+are::
+
+    LED 'module_led': off
+    LED 'module_led': on
+    LED 'module_led': blink
+
+led <led_label> on|off|toggle
+-----------------------------
+
+Turn on, off or toggle state of the LED whose label is the one passed as
+``<led_label>`` argument.
+
+led <led_label> blink <blink-freq in ms>
+----------------------------------------
+
+Make the LED whose label is the one passed as ``<led_label>`` argument blink at
+a frequency specified by the argument ``<blink-freq in ms>``.
+
+The frequency is parsed as a decimal number and its unit is milliseconds. The
+duty cycle is 50%. Example::
+
+    led blue blink 1000
+
+will make the *blue*-labeled LED blink with a state (on or off) kept for 500ms
+before switching to the other state (respectively off or on) for 500ms,
+looping endlessly.
+
+led list
+--------
+
+List all available LEDs by their label and provide their known state, which can
+be either *off*, *on* or *blink*.
+
+If a LED has not been probed yet, its state will be shown as *<inactive>* in the
+list.
+
+Examples
+--------
+
+::
+
+    => led list
+    module_led      on
+    sd_card_led     <inactive>
+    => led module_led
+    LED 'module_led': on
+    => led module_led off
+    => led module_led
+    LED 'module_led': off
+    => led module_led toggle
+    => led module_led
+    LED 'module_led': on
+    => led module_led toggle
+    => led module_led
+    LED 'module_led': off
+    => led module_led blink 1000
+    => led module_led
+    LED 'module_led': blink
+    => led sd_card_led
+    LED 'sd_card_led': off
+    => led list
+    module_led      blink
+    sd_card_led     off
+
+Configuration
+-------------
+
+The *led* commands are only available if ``CONFIG_CMD_LED=y``.
+
+The *led <led_label> blink* command is only available if ``CONFIG_CMD_LED=y``
+and either ``CONFIG_LED_BLINK=y`` or ``CONFIG_LED_SW_BLINK=y``.

-- 
2.51.1

