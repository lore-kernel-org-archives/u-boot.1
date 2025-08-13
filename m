Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EA7CA0EE0
	for <u-boot@archiver.kernel.org>; Wed, 13 Aug 2025 14:08:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D088983641;
	Wed, 13 Aug 2025 16:07:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 432E183623; Wed, 13 Aug 2025 16:07:55 +0200 (CEST)
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [84.16.66.174])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF822835FE
 for <u-boot@lists.denx.de>; Wed, 13 Aug 2025 16:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4c29F450R1ztyD;
 Wed, 13 Aug 2025 16:07:52 +0200 (CEST)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4c29F35nrfzD3h; Wed, 13 Aug 2025 16:07:51 +0200 (CEST)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Wed, 13 Aug 2025 16:07:39 +0200
Subject: [PATCH v2 1/5] dt-bindings: mfd: rk806: Allow to customize PMIC
 reset mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-rk8xx-rst-fun-v2-1-a2223e17cb2c@cherry.de>
References: <20250813-rk8xx-rst-fun-v2-0-a2223e17cb2c@cherry.de>
In-Reply-To: <20250813-rk8xx-rst-fun-v2-0-a2223e17cb2c@cherry.de>
To: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: u-boot@lists.denx.de, Quentin Schulz <quentin.schulz@cherry.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 "Rob Herring (Arm)" <robh@kernel.org>, Lee Jones <lee@kernel.org>
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

The RK806 PMIC allows to configure its reset/restart behavior whenever
the PMIC is reset either programmatically or via some external pins
(e.g. PWRCTRL or RESETB).

The following modes exist:
 - 0; restart PMU,
 - 1; reset all power off reset registers and force state to switch to
   ACTIVE mode,
 - 2; same as mode 1 and also pull RESETB pin down for 5ms,

For example, some hardware may require a full restart (mode 0) in order
to function properly as regulators are shortly interrupted in this mode.

This is the case for RK3588 Jaguar and RK3588 Tiger which have a
companion microcontroller running on an independent power supply and
monitoring the PMIC power rail to know the state of the main system.
When it detects a restart, it resets its own IPs exposed to the main
system as if to simulate its own reset. Failing to perform this fake
reset of the microcontroller may break things (e.g. watchdog not
automatically disabled, buzzer still running until manually disabled,
leftover configuration from previous main system state, etc...).

Some other systems may be depending on the power rails to not be
interrupted even for a small amount of time[1].

This allows to specify how the PMIC should perform on the hardware level
and may differ between hardware designs, so a DT property seems
warranted. I unfortunately do not see how this could be made generic
enough to make it a non-vendor property.

[1] https://lore.kernel.org/linux-rockchip/2577051.irdbgypaU6@workhorse/

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
Link: https://lore.kernel.org/r/20250627-rk8xx-rst-fun-v4-1-ce05d041b45f@cherry.de
Signed-off-by: Lee Jones <lee@kernel.org>

[ upstream commit: 404005d1083997daec7236620b9ba14bccdce449 ]

(cherry picked from commit 8ee72356e9844265334fd344bc05139d1f615c4d)
---
 dts/upstream/Bindings/mfd/rockchip,rk806.yaml | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/dts/upstream/Bindings/mfd/rockchip,rk806.yaml b/dts/upstream/Bindings/mfd/rockchip,rk806.yaml
index 3c2b06629b75ea94f90712470bf14ed7fc16d68d..eb5bca31948ef0d39c46025d0cca65b8b4105a50 100644
--- a/dts/upstream/Bindings/mfd/rockchip,rk806.yaml
+++ b/dts/upstream/Bindings/mfd/rockchip,rk806.yaml
@@ -31,6 +31,27 @@ properties:
 
   system-power-controller: true
 
+  rockchip,reset-mode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2]
+    description:
+      Mode to use when a reset of the PMIC is triggered.
+
+      The reset can be triggered either programmatically, via one of
+      the PWRCTRL pins (provided additional configuration) or
+      asserting RESETB pin low.
+
+      The following modes are supported
+
+      - 0; restart PMU,
+      - 1; reset all power off reset registers and force state to
+        switch to ACTIVE mode,
+      - 2; same as mode 1 and also pull RESETB pin down for 5ms,
+
+      For example, some hardware may require a full restart (mode 0)
+      in order to function properly as regulators are shortly
+      interrupted in this mode.
+
   vcc1-supply:
     description:
       The input supply for dcdc-reg1.

-- 
2.50.1

