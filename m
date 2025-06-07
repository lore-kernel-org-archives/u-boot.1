Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E74C5B543
	for <u-boot@archiver.kernel.org>; Sat,  7 Jun 2025 09:38:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C30782AFC;
	Sat,  7 Jun 2025 11:37:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z6EQM1TM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F8AC82BAA; Sat,  7 Jun 2025 11:37:45 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3286C82AA7
 for <u-boot@lists.denx.de>; Sat,  7 Jun 2025 11:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-adb5cb6d8f1so451456366b.3
 for <u-boot@lists.denx.de>; Sat, 07 Jun 2025 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1749289062; x=1749893862;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6rS7UWa700GAPh//bF3XK1aI5ctzfMLdfNA0NjnTUw=;
 b=Z6EQM1TMiedu4IyA4s7uoDbCtrFa15ZtFtCKx2Q6dFfgZ6/y908KPfu8/o1bOo08XK
 YBdKGQhQp2znYs4g921QzZGe3s6popCSTduxNoCp3fB+I037uRFuuCFP5jfuiIOrRWp5
 oCE/RgsFqPmoejmFAE1YiNzrmIXSgG4/a7P68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749289062; x=1749893862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W6rS7UWa700GAPh//bF3XK1aI5ctzfMLdfNA0NjnTUw=;
 b=MB6M1Rmq9BQSpqxcsEHVaye8NgsL0+ktIFZ0PS3uL7TdoHyxqpH3Ev03u6pO243E64
 9mhWBbOxrDPXV9OKVQnB7VI2CGk/Bevz/b8j7DYm/LfuyMq6OsLaPgig7lMYgq/cbTnl
 x1cLNufvh/RSe3gcaEZkkQNROQD+xVgAbb/HH5v21hN9dQ8LllR3pR4uRluofRl3V5J8
 oynPQzdwyK0L/lbZlOWRWgD7helbKSNLtso7YN8xNBC7iFwsVxOLtFgCxtKJ7QiY6tjI
 NkAJ8/F7Bp8UtszVHx8Bwh7DrWzdDFrseKCkuRVryic3Q+nQiEmzuBtbn58201KICOk0
 TEKQ==
X-Gm-Message-State: AOJu0YzYovgKRU6h2mMcdqZxWlGjTHy7KMQKwhxzwn9Bf3O1kJTgrz2+
 GjOm5At6Xo9QFu9vINZycjmLpJKRkooZEANrZZSBLraLV8kbGxrueyKP6a+mcIzjet7uY+IwIPc
 NUwCp
X-Gm-Gg: ASbGncvwWgoj9FY+z1IuEN5bz4aGJfi2ZM2P2hntUJur84J+qeN57JbI4qTr9YVlHGv
 AtoJQmtFp80nOPeaIkJwiw17xq9AOHVQq+9GLJpyRXlH+5Rzgm+n/xfY5iyw824VAzwILFVS6mx
 O+Jbnuhk/HFs+xwgg61MOyK50QYfGGH8D+VfjxdgogpD2iCatYK4dceg5EPbF4+6Y+hNB0/qDBS
 hnFdgGfItMHYe3msStghuvCRmTymTEDtwO8A3Bl6C3IXELm9e6+BQamz71T4EkRZmdG07RZ3cGF
 e20AWztEHdS59EMzh0ygkmBsbUTggVuDSYiBMLRj/0nRbdHCHBccCnwOb0gedRUJ1r8rP++PeST
 SfNqd7Bjf27Oq7LDibW2I7ZtJFmOFnpWzGHMitgMBJFYK2M4Pp2VI2wn7KA7n3h3lAaN09XQ8Wr
 6HXNrWb2JQ54iMNcO7juSACqI=
X-Google-Smtp-Source: AGHT+IHKjcOEIFC2KqlB5t2Pr1+hi53vbbs6zAOup2OXPfqIHD5LBIetf9Zkm1pzcdTUZwodaQ6DIw==
X-Received: by 2002:a17:907:7249:b0:ad8:8621:924f with SMTP id
 a640c23a62f3a-ade1abc5d45mr495562666b.56.1749289062442; 
 Sat, 07 Jun 2025 02:37:42 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it
 (host-87-5-95-99.retail.telecomitalia.it. [87.5.95.99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc38cffsm246524966b.124.2025.06.07.02.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Jun 2025 02:37:42 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 7/9] ARM: dts: stm32: support STM32h747i-disco board
Date: Sat,  7 Jun 2025 11:37:15 +0200
Message-ID: <20250607093730.2249536-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
References: <20250607093730.2249536-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The board includes an STM32H747XI SoC with the following resources:
 - 2 Mbytes Flash
 - 1 Mbyte SRAM
 - LCD-TFT controller
 - MIPI-DSI interface
 - FD-CAN
 - USB 2.0 high-speed/full-speed
 - Ethernet MAC
 - camera interface

Detailed information can be found at:
https://www.st.com/en/evaluation-tools/stm32h747i-disco.html

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Link: https://lore.kernel.org/r/20250427074404.3278732-9-dario.binacchi@amarulasolutions.com
Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>

[ backport upstream commit: 49ba8fc6eab63165639ffbb9f976222d39739cab ]

---

 dts/upstream/src/arm/st/stm32h747i-disco.dts | 136 +++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100644 dts/upstream/src/arm/st/stm32h747i-disco.dts

diff --git a/dts/upstream/src/arm/st/stm32h747i-disco.dts b/dts/upstream/src/arm/st/stm32h747i-disco.dts
new file mode 100644
index 000000000000..99f0255dae8e
--- /dev/null
+++ b/dts/upstream/src/arm/st/stm32h747i-disco.dts
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Amarula Solutions, Dario Binacchi <dario.binacchi@amarulasolutions.com>
+ */
+
+/dts-v1/;
+#include "stm32h743.dtsi"
+#include "stm32h7-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "STMicroelectronics STM32H747i-Discovery board";
+	compatible = "st,stm32h747i-disco", "st,stm32h747";
+
+	chosen {
+		bootargs = "root=/dev/ram";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@d0000000 {
+		device_type = "memory";
+		reg = <0xd0000000 0x2000000>;
+	};
+
+	aliases {
+		serial0 = &usart1;
+		serial1 = &uart8;
+	};
+
+	v3v3: regulator-v3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "v3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-green {
+			gpios = <&gpioi 12 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+		led-orange {
+			gpios = <&gpioi 13 GPIO_ACTIVE_LOW>;
+		};
+		led-red {
+			gpios = <&gpioi 14 GPIO_ACTIVE_LOW>;
+		};
+		led-blue {
+			gpios = <&gpioi 15 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+		button-0 {
+			label = "User";
+			linux,code = <KEY_WAKEUP>;
+			gpios = <&gpioc 13 GPIO_ACTIVE_HIGH>;
+		};
+		button-1 {
+			label = "JoySel";
+			linux,code = <KEY_ENTER>;
+			gpios = <&gpiok 2 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+		};
+		button-2 {
+			label = "JoyDown";
+			linux,code = <KEY_DOWN>;
+			gpios = <&gpiok 3 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+		};
+		button-3 {
+			label = "JoyUp";
+			linux,code = <KEY_UP>;
+			gpios = <&gpiok 6 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+		};
+		button-4 {
+			label = "JoyLeft";
+			linux,code = <KEY_LEFT>;
+			gpios = <&gpiok 4 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+		};
+		button-5 {
+			label = "JoyRight";
+			linux,code = <KEY_RIGHT>;
+			gpios = <&gpiok 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+		};
+	};
+};
+
+&clk_hse {
+	clock-frequency = <25000000>;
+};
+
+&mac {
+	status = "disabled";
+	pinctrl-0 = <&ethernet_rmii>;
+	pinctrl-names = "default";
+	phy-mode = "rmii";
+	phy-handle = <&phy0>;
+
+	mdio0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+	};
+};
+
+&sdmmc1 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc1_b4_pins_a>;
+	pinctrl-1 = <&sdmmc1_b4_od_pins_a>;
+	pinctrl-2 = <&sdmmc1_b4_sleep_pins_a>;
+	cd-gpios = <&gpioi 8 GPIO_ACTIVE_LOW>;
+	broken-cd;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3>;
+	status = "okay";
+};
+
+&usart1 {
+	pinctrl-0 = <&usart1_pins_b>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&uart8 {
+	pinctrl-0 = <&uart8_pins_a>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
2.43.0

