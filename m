Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D9F2C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 06:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF1B811C1;
	Wed,  5 Mar 2025 07:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="gogcrhaH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA0BD811B3; Wed,  5 Mar 2025 07:08:05 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F47280BAA
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 07:07:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=1521d03f8=Manikandan.M@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1741154876; x=1772690876;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wLdKqSA6nHgJuwN/qaCa8SH2IyACIgMubEP5eLFv/UY=;
 b=gogcrhaH5dz5Hw5l+WGCeV5pR7DaMAsCmfSNSuiM/6Qfp7+bOrEZvYDO
 uwEB+18Hj4DrW6sn3Ecw18Xx82B3BViH38jJFblWFtXGcqIpY1DKvb1PL
 +jptHkS0JxJCBmEb3E+AOlaytUUWQZzEJLj+ATZApD9PZXSDyzWEfkpaS
 QCulnw76Fq2YvVCgWS+QVLU62XrPRXq2CQDKP0fqno7DShRE6kWNmtL4Y
 hic5CWgmQ3G+kPzvQCVoWiYIvs0BhxQy6iv2Q31w8ZVaJv4gU11d5oMGM
 8mBroSTNTPFQcrtS68C/GN0YAGc3srP+arS86elysJ8HLoc7aD6EyNiJS g==;
X-CSE-ConnectionGUID: UP94/1wCTEGIusP3vsBh2w==
X-CSE-MsgGUID: EK48GXIGSgSsTu8vOmpoIw==
X-IronPort-AV: E=Sophos;i="6.14,222,1736838000"; d="scan'208";a="205973254"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 04 Mar 2025 23:07:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Mar 2025 23:07:33 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 4 Mar 2025 23:07:25 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: Eugen Hristev <eugen.hristev@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 <seanga2@gmail.com>, <sumit.garg@linaro.org>, <kever.yang@rock-chips.com>, 
 <marek.vasut+renesas@mailbox.org>, <jonas@kwiboo.se>, <festevam@denx.de>, 
 <Oliver.Gaskell@analog.com>, <aford173@gmail.com>, <prasad.kummari@amd.com>,
 <caleb.connolly@linaro.org>, <andre.przywara@arm.com>,
 <neil.armstrong@linaro.org>, <mibodhi@gmail.com>,
 <nicolas.ferre@microchip.com>, <mihai.sain@microchip.com>,
 <sjg@chromium.org>, <u-boot@lists.denx.de>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 1/8] dt-bindings: clock: rename at91.h to at91-pmc-status.h
Date: Wed, 5 Mar 2025 11:37:04 +0530
Message-ID: <20250305060711.1127301-2-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305060711.1127301-1-manikandan.m@microchip.com>
References: <20250305060711.1127301-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Rename the include at91.h to at91-pmc-status.h to avoid conflicts with
the upstream bindings that has the same file and update the
relevant legacy SoC Device Trees to reflect this change.
This is useful while compiling the DT and driver of the new SoC files with
OF_UPSTREAM enabled.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 MAINTAINERS                                             | 2 +-
 arch/arm/dts/at91-sama7g5ek-u-boot.dtsi                 | 2 +-
 arch/arm/dts/at91sam9260.dtsi                           | 2 +-
 arch/arm/dts/at91sam9261.dtsi                           | 2 +-
 arch/arm/dts/at91sam9263.dtsi                           | 2 +-
 arch/arm/dts/at91sam9g45.dtsi                           | 2 +-
 arch/arm/dts/at91sam9n12.dtsi                           | 2 +-
 arch/arm/dts/at91sam9rl.dtsi                            | 2 +-
 arch/arm/dts/at91sam9x5.dtsi                            | 2 +-
 arch/arm/dts/sama5d3.dtsi                               | 2 +-
 arch/arm/dts/sama5d3_mci2.dtsi                          | 2 +-
 arch/arm/dts/sama5d3_tcb1.dtsi                          | 2 +-
 arch/arm/dts/sama5d3_uart.dtsi                          | 2 +-
 arch/arm/dts/sama5d4.dtsi                               | 2 +-
 include/dt-bindings/clock/{at91.h => at91-pmc-status.h} | 0
 15 files changed, 14 insertions(+), 14 deletions(-)
 rename include/dt-bindings/clock/{at91.h => at91-pmc-status.h} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 10f7f1fd180..d50841a4a41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -464,7 +464,7 @@ F:	drivers/memory/atmel-ebi.c
 F:	drivers/misc/microchip_flexcom.c
 F:	drivers/timer/atmel_tcb_timer.c
 F:	include/dt-bindings/clk/at91.h
-F:	include/dt-bindings/clock/at91.h
+F:	include/dt-bindings/clock/at91-pmc-status.h
 F:	include/dt-bindings/dma/at91.h
 F:	include/dt-bindings/mfd/at91-usart.h
 F:	include/dt-bindings/mfd/atmel-flexcom.h
diff --git a/arch/arm/dts/at91-sama7g5ek-u-boot.dtsi b/arch/arm/dts/at91-sama7g5ek-u-boot.dtsi
index 8b2e990de72..6e5ca0fb4ce 100644
--- a/arch/arm/dts/at91-sama7g5ek-u-boot.dtsi
+++ b/arch/arm/dts/at91-sama7g5ek-u-boot.dtsi
@@ -12,7 +12,7 @@
 
 #include "sama7g5-pinfunc.h"
 #include <dt-bindings/reset/sama7g5-reset.h>
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 
 / {
 	chosen {
diff --git a/arch/arm/dts/at91sam9260.dtsi b/arch/arm/dts/at91sam9260.dtsi
index 8d496205523..4ccfe2b9e4b 100644
--- a/arch/arm/dts/at91sam9260.dtsi
+++ b/arch/arm/dts/at91sam9260.dtsi
@@ -12,7 +12,7 @@
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 
 / {
 	model = "Atmel AT91SAM9260 family SoC";
diff --git a/arch/arm/dts/at91sam9261.dtsi b/arch/arm/dts/at91sam9261.dtsi
index 65e0e4f0de0..0c7485bff98 100644
--- a/arch/arm/dts/at91sam9261.dtsi
+++ b/arch/arm/dts/at91sam9261.dtsi
@@ -10,7 +10,7 @@
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 
 / {
 	model = "Atmel AT91SAM9261 family SoC";
diff --git a/arch/arm/dts/at91sam9263.dtsi b/arch/arm/dts/at91sam9263.dtsi
index 55b79667564..e5d1cc04f5c 100644
--- a/arch/arm/dts/at91sam9263.dtsi
+++ b/arch/arm/dts/at91sam9263.dtsi
@@ -10,7 +10,7 @@
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 
 / {
 	model = "Atmel AT91SAM9263 family SoC";
diff --git a/arch/arm/dts/at91sam9g45.dtsi b/arch/arm/dts/at91sam9g45.dtsi
index 63a061354e4..5c79f33f48d 100644
--- a/arch/arm/dts/at91sam9g45.dtsi
+++ b/arch/arm/dts/at91sam9g45.dtsi
@@ -14,7 +14,7 @@
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 
 / {
 	model = "Atmel AT91SAM9G45 family SoC";
diff --git a/arch/arm/dts/at91sam9n12.dtsi b/arch/arm/dts/at91sam9n12.dtsi
index 84089837013..5034db0b617 100644
--- a/arch/arm/dts/at91sam9n12.dtsi
+++ b/arch/arm/dts/at91sam9n12.dtsi
@@ -12,7 +12,7 @@
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 
 / {
 	model = "Atmel AT91SAM9N12 SoC";
diff --git a/arch/arm/dts/at91sam9rl.dtsi b/arch/arm/dts/at91sam9rl.dtsi
index 3b99de21058..8fa8067709c 100644
--- a/arch/arm/dts/at91sam9rl.dtsi
+++ b/arch/arm/dts/at91sam9rl.dtsi
@@ -8,7 +8,7 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/pinctrl/at91.h>
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/pwm/pwm.h>
diff --git a/arch/arm/dts/at91sam9x5.dtsi b/arch/arm/dts/at91sam9x5.dtsi
index 4c6d8b9bb65..1922c5f03e0 100644
--- a/arch/arm/dts/at91sam9x5.dtsi
+++ b/arch/arm/dts/at91sam9x5.dtsi
@@ -14,7 +14,7 @@
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 
 / {
 	model = "Atmel AT91SAM9x5 family SoC";
diff --git a/arch/arm/dts/sama5d3.dtsi b/arch/arm/dts/sama5d3.dtsi
index 10d6e74586d..bb9290fba57 100644
--- a/arch/arm/dts/sama5d3.dtsi
+++ b/arch/arm/dts/sama5d3.dtsi
@@ -13,7 +13,7 @@
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 
 / {
 	model = "Atmel SAMA5D3 family SoC";
diff --git a/arch/arm/dts/sama5d3_mci2.dtsi b/arch/arm/dts/sama5d3_mci2.dtsi
index 2d289ed7be8..05753edeb0f 100644
--- a/arch/arm/dts/sama5d3_mci2.dtsi
+++ b/arch/arm/dts/sama5d3_mci2.dtsi
@@ -9,7 +9,7 @@
 
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 
 / {
 	ahb {
diff --git a/arch/arm/dts/sama5d3_tcb1.dtsi b/arch/arm/dts/sama5d3_tcb1.dtsi
index 5be60b4f8b1..0d96fe77723 100644
--- a/arch/arm/dts/sama5d3_tcb1.dtsi
+++ b/arch/arm/dts/sama5d3_tcb1.dtsi
@@ -9,7 +9,7 @@
 
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 
 / {
 	aliases {
diff --git a/arch/arm/dts/sama5d3_uart.dtsi b/arch/arm/dts/sama5d3_uart.dtsi
index 6a547fdadcc..10f36eb3ac2 100644
--- a/arch/arm/dts/sama5d3_uart.dtsi
+++ b/arch/arm/dts/sama5d3_uart.dtsi
@@ -9,7 +9,7 @@
 
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 
 / {
 	aliases {
diff --git a/arch/arm/dts/sama5d4.dtsi b/arch/arm/dts/sama5d4.dtsi
index 482cf03e61b..af5e9bd6dba 100644
--- a/arch/arm/dts/sama5d4.dtsi
+++ b/arch/arm/dts/sama5d4.dtsi
@@ -44,7 +44,7 @@
  */
 
 #include "skeleton.dtsi"
-#include <dt-bindings/clock/at91.h>
+#include <dt-bindings/clock/at91-pmc-status.h>
 #include <dt-bindings/dma/at91.h>
 #include <dt-bindings/pinctrl/at91.h>
 #include <dt-bindings/interrupt-controller/irq.h>
diff --git a/include/dt-bindings/clock/at91.h b/include/dt-bindings/clock/at91-pmc-status.h
similarity index 100%
rename from include/dt-bindings/clock/at91.h
rename to include/dt-bindings/clock/at91-pmc-status.h
-- 
2.25.1

