Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECABCD3429
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 17:49:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 938AC83D9C;
	Wed, 12 Nov 2025 18:48:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CA5583D39; Wed, 12 Nov 2025 18:48:50 +0100 (CET)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:7:10::42ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F07D683CF2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 18:48:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4d69qz53fwz7gp;
 Wed, 12 Nov 2025 18:48:47 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4d69qy6BNNzr2F; Wed, 12 Nov 2025 18:48:46 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 12 Nov 2025 18:48:12 +0100
Subject: [PATCH 07/11] arm: dts: rockchip: rk3399-puma: remove u-boot,boot-led
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-led-old-dt-v1-7-2892d49517db@cherry.de>
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

There's no code to make use of it.

Further more, the HW default state of that LED is on and migrating this
to the LED_BOOT implem brings no benefit as it'll stay on if U-Boot
reaches its main-loop. Blinking the LED_BOOT also doesn't help because
it doesn't blink for long enough to be noticeable before it's kept on.

This is by design, c.f.
https://source.denx.de/u-boot/u-boot/-/blob/v2025.10/include/led.h#L32-34

If we want this LED to be doing something different, it'll need to be
handled by a board file anyway.

Considering it hasn't worked in many years, let's just remove it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
index 55895d0dd19..76e091be232 100644
--- a/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
+++ b/arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi
@@ -17,7 +17,6 @@
 		u-boot,spl-payload-offset = <0x80000>; /* @ 512KB */
 		u-boot,mmc-env-offset = <0x5000>;      /* @  20KB */
 		u-boot,efi-partition-entries-offset = <0x200000>; /* 2MB */
-		u-boot,boot-led = "module_led";
 		sysreset-gpio = <&gpio1 RK_PA6 GPIO_ACTIVE_HIGH>;
 	};
 

-- 
2.51.1

