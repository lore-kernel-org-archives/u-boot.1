Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B748EF06EC
	for <u-boot@archiver.kernel.org>; Sun,  8 Feb 2026 21:26:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8E8B83BF4;
	Sun,  8 Feb 2026 22:26:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g/QChBLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2ABE383BF4; Sun,  8 Feb 2026 22:26:40 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1236E805D7
 for <u-boot@lists.denx.de>; Sun,  8 Feb 2026 22:26:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-793fdbb8d3aso36402887b3.3
 for <u-boot@lists.denx.de>; Sun, 08 Feb 2026 13:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770585996; x=1771190796; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGywroDs2QcVkUsX/SIP5KCFlglLDk42vSkjk6pChJI=;
 b=g/QChBLEtkYmJIZygM4++KcfC4EjWjJF7Yas1fcOmY3yp4tWQEJ62pKptuTF3b/v91
 Kq8Piu6e4ALGOHkoFK201jfNxp0eLkGtJ/oghlnHa1Rt66C8qmJ1Tb/9/5BO+2/SJK+t
 OJRf+23//IvdjZO6gbMHaoL9ax/2lcYQuXRDjfwnKDJGVnLzAH1TqbgSH/eGpf6etwiV
 ncNneB5gSWHgNHlEMQYzUj9HSY63RvOAD3VZPo3fvsB7pK6w1JzkNYUmHffRho2ZjM5s
 KrH2u4ym2wtEbG+iW8fdLjowJicG8rts/oOMzav5VhxtQaKpNI1PKOAikm9x+PXM0zLx
 9ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770585996; x=1771190796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wGywroDs2QcVkUsX/SIP5KCFlglLDk42vSkjk6pChJI=;
 b=SNWsAupbGnDZo70FSBrmqFdqeQNFrnG0k3G70IGoXrhP4shuTRR+vrute6bsKPh3Rm
 VMhKoXAFnhctthyEZb9Kcwt70fyNOEDZDIsHtNkU6bPrxFkrxvZyA+03XgoKhkFoQf8T
 oEmjA8gTag5KHPk95AQj+Dsvi/OCoNadvWeLC6dZXYJL2MxyEMZMf6AlFTMs4t7VEZTM
 +IraX+IVdzUFWfOWBZoqkB314cLIGQgUQtin7N6Sn8+a3eLuS+6Q6InikAJ6Y+Bb7I3Q
 20GHR6YKd5yDfpKHGjfBpdxWbpLSN03X+uKhrR1ah5fDnwTsJgN4wnNiaDpElAJauPfh
 pTuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3LBQCWK6b025rT/suVlAseQhkY+pECY+WYGKT6VHZgJhiCKEkk6mWn1UzOUkYKJCFixLEu1c=@lists.denx.de
X-Gm-Message-State: AOJu0YxihNVJshsH3P915NYlTnbBPwGDIscZRTTaljm3o30CjnP5j63J
 +XRksz/303VJ4DLV9HD8CqRW/Yem/zjiygwAcFk9eUdWqcQt4wUr9MoY
X-Gm-Gg: AZuq6aLBatC1Cou+efncmtWiIdG+u7XKIV8NwFirBNT0T44ExfU/zJFu3ZTbgwD03Q3
 UOAKl+7PVRlCT9679pybyXkCFMbBx2bQzN7BfQGi4Jq0xLfkDOFNwrQ4TdGj8OAq4aD5iUlwVau
 eVPHikH6n9pjYdczIHOrR5jDvHF9oCKM1gceCC6YFIqqpM+HP+yUuYuH5Hv94sGQ6QEwzFoYfU2
 zNj9BZLJ8YTel5+q5GXVHueLUmLw7wuPH7Fcm7bKP89vx9F1N3sE58SYaezKD5x7K01pCwDcTj3
 2oLb6JIDKpdr6p+E0YDdKaVAIkG6e2BqwFTCCn+ZW9SNDsLjPWYrfTi7vs9oijU9N2K1HXoRUSO
 eXFruseihrHnhdQuVYyhhRDeWUfVdSr4KdwOVa6pYtpDUf+kOV0fCiywUaYSfMwhiKrH0cfS/PX
 H3e1BUcKclYbj1jliU8y4oM2XM
X-Received: by 2002:a05:690c:399:b0:795:f0c:3d12 with SMTP id
 00721157ae682-7952ab92c5fmr98307907b3.65.1770585995417; 
 Sun, 08 Feb 2026 13:26:35 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:5d9f:efd7:6c6a:abf8])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7952a085999sm75229377b3.25.2026.02.08.13.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Feb 2026 13:26:34 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: kever.yang@rock-chips.com
Cc: trini@konsulko.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
Subject: [PATCH v2 1/7] ARM: dts: Add RV1103B Omega4 support
Date: Sun,  8 Feb 2026 18:26:18 -0300
Message-Id: <20260208212624.3413494-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260208212624.3413494-1-festevam@gmail.com>
References: <20260208212624.3413494-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@nabladev.com>

Add the necessary devicetrees to support the RV1103B Omega4 board.

The RV1103B is a Rockchip SoC that is still not supported in Linux
mainline.

The initial RV1103B support has already been submitted to Linux kernel
and it is under review.

Once the Linux RV1103 devicetrees are upstreamed, the OF_UPSTREAM mechanism
can be enabled.

Signed-off-by: Fabio Estevam <festevam@nabladev.com>
---
Changes since v1:
- Used the devicetrees submitted to upstream Linux.

 arch/arm/dts/rv1103b-omega4-u-boot.dtsi       |  10 +
 arch/arm/dts/rv1103b-omega4.dts               | 105 +++
 arch/arm/dts/rv1103b-pinctrl.dtsi             | 831 ++++++++++++++++++
 arch/arm/dts/rv1103b-u-boot.dtsi              |   4 +
 arch/arm/dts/rv1103b.dtsi                     | 266 ++++++
 .../dt-bindings/clock/rockchip,rv1103b-cru.h  | 220 +++++
 6 files changed, 1436 insertions(+)
 create mode 100644 arch/arm/dts/rv1103b-omega4-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103b-omega4.dts
 create mode 100644 arch/arm/dts/rv1103b-pinctrl.dtsi
 create mode 100644 arch/arm/dts/rv1103b-u-boot.dtsi
 create mode 100644 arch/arm/dts/rv1103b.dtsi
 create mode 100644 include/dt-bindings/clock/rockchip,rv1103b-cru.h

diff --git a/arch/arm/dts/rv1103b-omega4-u-boot.dtsi b/arch/arm/dts/rv1103b-omega4-u-boot.dtsi
new file mode 100644
index 000000000000..c7616de1715c
--- /dev/null
+++ b/arch/arm/dts/rv1103b-omega4-u-boot.dtsi
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
+// (C) Copyright 2024 Rockchip Electronics Co., Ltd
+
+#include "rockchip-u-boot.dtsi"
+
+/ {
+	chosen {
+		u-boot,spl-boot-order = &spi_nand;
+	};
+};
diff --git a/arch/arm/dts/rv1103b-omega4.dts b/arch/arm/dts/rv1103b-omega4.dts
new file mode 100644
index 000000000000..3d58954d5e4a
--- /dev/null
+++ b/arch/arm/dts/rv1103b-omega4.dts
@@ -0,0 +1,105 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2022 Rockchip Electronics Co., Ltd.
+ * Copyright (c) 2025 plan44.ch/luz
+ * Copyright (c) 2025 Onion Corporation
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include "rv1103b.dtsi"
+
+/ {
+	model = "Onion RV1103 Omega4 Board";
+	compatible = "onion,rv1103b-omega4", "rockchip,rv1103b";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-0	{
+			pinctrl-names = "default";
+			pinctrl-0 = <&led_pin>;
+			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_BLUE>;
+			label = "sys";
+			default-state = "on";
+		};
+	};
+};
+
+&fspi0 {
+	status = "okay";
+
+	spi_nand: flash@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		bootph-pre-ram;
+		bootph-some-ram;
+		spi-max-frequency = <75000000>;
+		spi-rx-bus-width = <4>;
+		spi-tx-bus-width = <1>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "env";
+				reg = <0x00000000 0x00040000>;
+			};
+
+			partition@40000 {
+				label = "idblock";
+				reg = <0x00040000 0x00100000>;
+				read-only;
+			};
+
+			partition@140000 {
+				label = "uboot";
+				reg = <0x00140000 0x00100000>;
+				read-only;
+			};
+
+			partition@240000 {
+				label = "boot";
+				reg = <0x00240000 0x00800000>;
+			};
+
+			partition@a40000 {
+				label = "ubi";
+				reg = <0x00a40000 0x0f5c0000>;
+			};
+		};
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0m0_xfer_pins>;
+	bootph-all;
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
+
+&pinctrl {
+	leds {
+		led_pin: led-pin {
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
diff --git a/arch/arm/dts/rv1103b-pinctrl.dtsi b/arch/arm/dts/rv1103b-pinctrl.dtsi
new file mode 100644
index 000000000000..bc4d8fcdfaf7
--- /dev/null
+++ b/arch/arm/dts/rv1103b-pinctrl.dtsi
@@ -0,0 +1,831 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
+ */
+
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <arm64/rockchip/rockchip-pinconf.dtsi>
+
+/*
+ * This file is auto generated by pin2dts tool, please keep these code
+ * by adding changes at end of this file.
+ */
+&pinctrl {
+	cam_clk0 {
+		cam_clk0_pins: cam-clk0-pins {
+			rockchip,pins =
+				/* cam_clk0_out */
+				<1 RK_PB5 1 &pcfg_pull_none>;
+		};
+	};
+
+	cam_clk1 {
+		cam_clk1_pins: cam-clk1-pins {
+			rockchip,pins =
+				/* cam_clk1_out */
+				<1 RK_PB6 1 &pcfg_pull_none>;
+		};
+	};
+
+	cam_spi {
+		cam_spi_bus4_pins: cam-spi-bus4-pins {
+			rockchip,pins =
+				/* cam_spi_d0 */
+				<0 RK_PB5 4 &pcfg_pull_up_drv_level_2>,
+				/* cam_spi_d1 */
+				<0 RK_PB2 4 &pcfg_pull_up_drv_level_2>,
+				/* cam_spi_d2 */
+				<0 RK_PB1 4 &pcfg_pull_up_drv_level_2>,
+				/* cam_spi_d3 */
+				<0 RK_PB0 4 &pcfg_pull_up_drv_level_2>;
+		};
+		cam_spi_clk_pins: cam-spi-clk-pins {
+			rockchip,pins =
+				/* cam_spi_clk */
+				<0 RK_PB4 4 &pcfg_pull_none>;
+		};
+		cam_spi_cs0n_pins: cam-spi-cs0n-pins {
+			rockchip,pins =
+				/* cam_spi_cs0n */
+				<0 RK_PB3 4 &pcfg_pull_none>;
+		};
+	};
+
+	clk {
+		clk_32k_pins: clk-32k-pins {
+			rockchip,pins =
+				/* clk_32k */
+				<0 RK_PA0 2 &pcfg_pull_none>;
+		};
+	};
+
+	clk_24m {
+		clk_24m_out_pins: clk-24m-out-pins {
+			rockchip,pins =
+				/* clk_24m_out */
+				<0 RK_PA0 3 &pcfg_pull_none>;
+		};
+	};
+
+	cpu {
+		cpu_pins: cpu-pins {
+			rockchip,pins =
+				/* cpu_avs */
+				<0 RK_PA1 2 &pcfg_pull_none>;
+		};
+	};
+
+	emmc {
+		emmc_bus4_pins: emmc-bus4-pins {
+			rockchip,pins =
+				/* emmc_d0 */
+				<1 RK_PA1 1 &pcfg_pull_up_drv_level_2>,
+				/* emmc_d1 */
+				<1 RK_PA2 1 &pcfg_pull_up_drv_level_2>,
+				/* emmc_d2 */
+				<1 RK_PA3 1 &pcfg_pull_up_drv_level_2>,
+				/* emmc_d3 */
+				<1 RK_PA0 1 &pcfg_pull_up_drv_level_2>;
+		};
+		emmc_clk_pins: emmc-clk-pins {
+			rockchip,pins =
+				/* emmc_clk */
+				<1 RK_PA4 1 &pcfg_pull_up_drv_level_2>;
+		};
+		emmc_cmd_pins: emmc-cmd-pins {
+			rockchip,pins =
+				/* emmc_cmd */
+				<1 RK_PA5 1 &pcfg_pull_up_drv_level_2>;
+		};
+	};
+
+	emmc_testclk {
+		emmc_testclk_clk_pins: emmc-testclk-clk-pins {
+			rockchip,pins =
+				/* emmc_testclk_out */
+				<1 RK_PA7 3 &pcfg_pull_up_drv_level_2>;
+		};
+	};
+
+	emmc_testdata {
+		emmc_testdata_out_pins: emmc-testdata-out-pins {
+			rockchip,pins =
+				/* emmc_testdata_out */
+				<1 RK_PB0 3 &pcfg_pull_none>;
+		};
+	};
+
+	eth_led {
+		eth_led_dpx_pins: eth-led-dpx-pins {
+			rockchip,pins =
+				/* eth_led_dpx */
+				<2 RK_PA4 6 &pcfg_pull_none>;
+		};
+		eth_led_link_pins: eth-led-link-pins {
+			rockchip,pins =
+				/* eth_led_link */
+				<2 RK_PA6 6 &pcfg_pull_none>;
+		};
+		eth_led_spd_pins: eth-led-spd-pins {
+			rockchip,pins =
+				/* eth_led_spd */
+				<2 RK_PA7 6 &pcfg_pull_none>;
+		};
+	};
+
+	flash_trig {
+		flash_trig_pins: flash-trig-pins {
+			rockchip,pins =
+				/* flash_trig_out */
+				<2 RK_PB0 6 &pcfg_pull_none>;
+		};
+	};
+
+	fspi {
+		fspi_bus4_pins: fspi-bus4-pins {
+			rockchip,pins =
+				/* fspi_d0 */
+				<1 RK_PA1 2 &pcfg_pull_none>,
+				/* fspi_d1 */
+				<1 RK_PA2 2 &pcfg_pull_none>,
+				/* fspi_d2 */
+				<1 RK_PA3 2 &pcfg_pull_none>,
+				/* fspi_d3 */
+				<1 RK_PA0 2 &pcfg_pull_none>;
+		};
+		fspi_cs0_pins: fspi-cs0-pins {
+			rockchip,pins =
+				/* fspi_cs0n */
+				<1 RK_PA5 2 &pcfg_pull_up>;
+		};
+		fspi_clk_pins: fspi-clk-pins {
+			rockchip,pins =
+				/* fspi_clk */
+				<1 RK_PA4 2 &pcfg_pull_none>;
+		};
+	};
+
+	fspi_testclk {
+		fspi_testclk_out_pins: fspi-testclk-out-pins {
+			rockchip,pins =
+				/* fspi_testclk_out */
+				<1 RK_PA7 5 &pcfg_pull_none>;
+		};
+	};
+
+	fspi_testdata {
+		fspi_testdata_out_pins: fspi-testdata-out-pins {
+			rockchip,pins =
+				/* fspi_testdata_out */
+				<1 RK_PB0 5 &pcfg_pull_none>;
+		};
+	};
+
+	i2c0 {
+		i2c0m0_xfer_pins: i2c0m0-xfer-pins {
+			rockchip,pins =
+				/* i2c0_scl_m0 */
+				<0 RK_PA5 3 &pcfg_pull_none_smt>,
+				/* i2c0_sda_m0 */
+				<0 RK_PA6 3 &pcfg_pull_none_smt>;
+		};
+		i2c0m1_xfer_pins: i2c0m1-xfer-pins {
+			rockchip,pins =
+				/* i2c0_scl_m1 */
+				<1 RK_PB4 5 &pcfg_pull_none_smt>,
+				/* i2c0_sda_m1 */
+				<1 RK_PB3 5 &pcfg_pull_none_smt>;
+		};
+		i2c0m2_xfer_pins: i2c0m2-xfer-pins {
+			rockchip,pins =
+				/* i2c0_scl_m2 */
+				<1 RK_PB5 2 &pcfg_pull_none_smt>,
+				/* i2c0_sda_m2 */
+				<1 RK_PB6 2 &pcfg_pull_none_smt>;
+		};
+	};
+
+	i2c1 {
+		i2c1m0_xfer_pins: i2c1m0-xfer-pins {
+			rockchip,pins =
+				/* i2c1_scl_m0 */
+				<0 RK_PB0 1 &pcfg_pull_none_smt>,
+				/* i2c1_sda_m0 */
+				<0 RK_PB1 1 &pcfg_pull_none_smt>;
+		};
+		i2c1m1_xfer_pins: i2c1m1-xfer-pins {
+			rockchip,pins =
+				/* i2c1_scl_m1 */
+				<2 RK_PA4 4 &pcfg_pull_none_smt>,
+				/* i2c1_sda_m1 */
+				<2 RK_PA5 4 &pcfg_pull_none_smt>;
+		};
+	};
+
+	i2c2 {
+		i2c2m0_xfer_pins: i2c2m0-xfer-pins {
+			rockchip,pins =
+				/* i2c2_scl_m0 */
+				<0 RK_PB2 1 &pcfg_pull_none_smt>,
+				/* i2c2_sda_m0 */
+				<0 RK_PB3 1 &pcfg_pull_none_smt>;
+		};
+		i2c2m1_xfer_pins: i2c2m1-xfer-pins {
+			rockchip,pins =
+				/* i2c2_scl_m1 */
+				<2 RK_PA6 4 &pcfg_pull_none_smt>,
+				/* i2c2_sda_m1 */
+				<2 RK_PA7 4 &pcfg_pull_none_smt>;
+		};
+	};
+
+	i2c3 {
+		i2c3m0_xfer_pins: i2c3m0-xfer-pins {
+			rockchip,pins =
+				/* i2c3_scl_m0 */
+				<0 RK_PB4 1 &pcfg_pull_none_smt>,
+				/* i2c3_sda_m0 */
+				<0 RK_PB5 1 &pcfg_pull_none_smt>;
+		};
+		i2c3m1_xfer_pins: i2c3m1-xfer-pins {
+			rockchip,pins =
+				/* i2c3_scl_m1 */
+				<2 RK_PB3 4 &pcfg_pull_none_smt>,
+				/* i2c3_sda_m1 */
+				<2 RK_PB2 4 &pcfg_pull_none_smt>;
+		};
+	};
+
+	i2c4 {
+		i2c4m0_xfer_pins: i2c4m0-xfer-pins {
+			rockchip,pins =
+				/* i2c4_scl_m0 */
+				<2 RK_PB0 4 &pcfg_pull_none_smt>,
+				/* i2c4_sda_m0 */
+				<2 RK_PB1 4 &pcfg_pull_none_smt>;
+		};
+		i2c4m1_xfer_pins: i2c4m1-xfer-pins {
+			rockchip,pins =
+				/* i2c4_scl_m1 */
+				<1 RK_PB7 2 &pcfg_pull_none_smt>,
+				/* i2c4_sda_m1 */
+				<1 RK_PC0 2 &pcfg_pull_none_smt>;
+		};
+	};
+
+	jtag {
+		jtagm0_pins: jtagm0-pins {
+			rockchip,pins =
+				/* jtag_tck_m0 */
+				<0 RK_PA5 5 &pcfg_pull_none>,
+				/* jtag_tms_m0 */
+				<0 RK_PA6 5 &pcfg_pull_none>;
+		};
+		jtagm1_pins: jtagm1-pins {
+			rockchip,pins =
+				/* jtag_tck_m1 */
+				<0 RK_PB4 3 &pcfg_pull_none>,
+				/* jtag_tms_m1 */
+				<0 RK_PB5 3 &pcfg_pull_none>;
+		};
+		jtagm2_pins: jtagm2-pins {
+			rockchip,pins =
+				/* jtag_tck_m2 */
+				<1 RK_PB4 3 &pcfg_pull_none>,
+				/* jtag_tms_m2 */
+				<1 RK_PB3 3 &pcfg_pull_none>;
+		};
+	};
+
+	pmu_debug_test {
+		pmu_debug_test_pins: pmu-debug-test-pins {
+			rockchip,pins =
+				/* pmu_debug_test_out */
+				<0 RK_PB1 5 &pcfg_pull_none>;
+		};
+	};
+
+	prelight_trig {
+		prelight_trig_pins: prelight-trig-pins {
+			rockchip,pins =
+				/* prelight_trig_out */
+				<2 RK_PB1 6 &pcfg_pull_none>;
+		};
+	};
+
+	psram_spi {
+		psram_spi_bus4_pins: psram-spi-bus4-pins {
+			rockchip,pins =
+				/* psram_spi_d0 */
+				<0 RK_PA2 4 &pcfg_pull_none>,
+				/* psram_spi_d1 */
+				<0 RK_PA1 4 &pcfg_pull_none>,
+				/* psram_spi_d2 */
+				<0 RK_PA5 4 &pcfg_pull_none>,
+				/* psram_spi_d3 */
+				<0 RK_PA6 4 &pcfg_pull_none>;
+		};
+		psram_spi_clk_pins: psram-spi-clk-pins {
+			rockchip,pins =
+				/* psram_spi_clk */
+				<0 RK_PA0 4 &pcfg_pull_none>;
+		};
+		psram_spi_cs0n_pins: psram-spi-cs0n-pins {
+			rockchip,pins =
+				/* psram_spi_cs0n */
+				<0 RK_PA4 4 &pcfg_pull_none>;
+		};
+	};
+
+	pwm0 {
+		pwm0m0_ch0_pins: pwm0m0-ch0-pins {
+			rockchip,pins =
+				/* pwm0m0_ch0 */
+				<0 RK_PA1 1 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm0m0_ch1_pins: pwm0m0-ch1-pins {
+			rockchip,pins =
+				/* pwm0m0_ch1 */
+				<0 RK_PA5 2 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm0m0_ch2_pins: pwm0m0-ch2-pins {
+			rockchip,pins =
+				/* pwm0m0_ch2 */
+				<0 RK_PA6 2 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm0m0_ch3_pins: pwm0m0-ch3-pins {
+			rockchip,pins =
+				/* pwm0m0_ch3 */
+				<0 RK_PA2 1 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm0m1_ch0_pins: pwm0m1-ch0-pins {
+			rockchip,pins =
+				/* pwm0m1_ch0 */
+				<2 RK_PA0 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm0m1_ch1_pins: pwm0m1-ch1-pins {
+			rockchip,pins =
+				/* pwm0m1_ch1 */
+				<2 RK_PA1 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm0m1_ch2_pins: pwm0m1-ch2-pins {
+			rockchip,pins =
+				/* pwm0m1_ch2 */
+				<2 RK_PA2 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm0m1_ch3_pins: pwm0m1-ch3-pins {
+			rockchip,pins =
+				/* pwm0m1_ch3 */
+				<2 RK_PB0 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm0m2_ch1_pins: pwm0m2-ch1-pins {
+			rockchip,pins =
+				/* pwm0m2_ch1 */
+				<1 RK_PB7 1 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm0m2_ch2_pins: pwm0m2-ch2-pins {
+			rockchip,pins =
+				/* pwm0m2_ch2 */
+				<1 RK_PC0 1 &pcfg_pull_none_drv_level_0>;
+		};
+	};
+
+	pwm1 {
+		pwm1m0_ch0_pins: pwm1m0-ch0-pins {
+			rockchip,pins =
+				/* pwm1m0_ch0 */
+				<0 RK_PB0 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm1m0_ch1_pins: pwm1m0-ch1-pins {
+			rockchip,pins =
+				/* pwm1m0_ch1 */
+				<0 RK_PB1 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm1m0_ch2_pins: pwm1m0-ch2-pins {
+			rockchip,pins =
+				/* pwm1m0_ch2 */
+				<0 RK_PB2 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm1m0_ch3_pins: pwm1m0-ch3-pins {
+			rockchip,pins =
+				/* pwm1m0_ch3 */
+				<0 RK_PB3 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm1m1_ch0_pins: pwm1m1-ch0-pins {
+			rockchip,pins =
+				/* pwm1m1_ch0 */
+				<2 RK_PA3 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm1m1_ch1_pins: pwm1m1-ch1-pins {
+			rockchip,pins =
+				/* pwm1m1_ch1 */
+				<2 RK_PA4 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm1m1_ch2_pins: pwm1m1-ch2-pins {
+			rockchip,pins =
+				/* pwm1m1_ch2 */
+				<2 RK_PA5 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm1m1_ch3_pins: pwm1m1-ch3-pins {
+			rockchip,pins =
+				/* pwm1m1_ch3 */
+				<2 RK_PB1 3 &pcfg_pull_none_drv_level_0>;
+		};
+	};
+
+	pwm2 {
+		pwm2m0_ch0_pins: pwm2m0-ch0-pins {
+			rockchip,pins =
+				/* pwm2m0_ch0 */
+				<1 RK_PB0 4 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm2m0_ch1_pins: pwm2m0-ch1-pins {
+			rockchip,pins =
+				/* pwm2m0_ch1 */
+				<1 RK_PA7 4 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm2m0_ch2_pins: pwm2m0-ch2-pins {
+			rockchip,pins =
+				/* pwm2m0_ch2 */
+				<1 RK_PB4 4 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm2m0_ch3_pins: pwm2m0-ch3-pins {
+			rockchip,pins =
+				/* pwm2m0_ch3 */
+				<1 RK_PB3 4 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm2m1_ch0_pins: pwm2m1-ch0-pins {
+			rockchip,pins =
+				/* pwm2m1_ch0 */
+				<2 RK_PA6 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm2m1_ch1_pins: pwm2m1-ch1-pins {
+			rockchip,pins =
+				/* pwm2m1_ch1 */
+				<2 RK_PA7 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm2m1_ch2_pins: pwm2m1-ch2-pins {
+			rockchip,pins =
+				/* pwm2m1_ch2 */
+				<2 RK_PB2 3 &pcfg_pull_none_drv_level_0>;
+		};
+		pwm2m1_ch3_pins: pwm2m1-ch3-pins {
+			rockchip,pins =
+				/* pwm2m1_ch3 */
+				<2 RK_PB3 3 &pcfg_pull_none_drv_level_0>;
+		};
+	};
+
+	pwr {
+		pwr_pins: pwr-pins {
+			rockchip,pins =
+				/* pwr_ctrl0 */
+				<0 RK_PA3 1 &pcfg_pull_none>,
+				/* pwr_ctrl1 */
+				<0 RK_PA4 1 &pcfg_pull_none>;
+		};
+	};
+
+	rtc_32k {
+		rtc_32k_pins: rtc-32k-pins {
+			rockchip,pins =
+				/* rtc_32k_out */
+				<0 RK_PA0 1 &pcfg_pull_none>;
+		};
+	};
+
+	sai {
+		sai_pins: sai-pins {
+			rockchip,pins =
+				/* sai_lrck */
+				<2 RK_PB1 5 &pcfg_pull_none>,
+				/* sai_mclk */
+				<2 RK_PB0 5 &pcfg_pull_none>,
+				/* sai_sclk */
+				<2 RK_PA7 5 &pcfg_pull_none>,
+				/* sai_sdi */
+				<2 RK_PA6 5 &pcfg_pull_none>,
+				/* sai_sdo */
+				<2 RK_PB2 5 &pcfg_pull_none>;
+		};
+	};
+
+	sdmmc0 {
+		sdmmc0_bus4_pins: sdmmc0-bus4-pins {
+			rockchip,pins =
+				/* sdmmc0_d0 */
+				<1 RK_PB0 1 &pcfg_pull_up_drv_level_2>,
+				/* sdmmc0_d1 */
+				<1 RK_PA7 1 &pcfg_pull_up_drv_level_2>,
+				/* sdmmc0_d2 */
+				<1 RK_PB4 1 &pcfg_pull_up_drv_level_2>,
+				/* sdmmc0_d3 */
+				<1 RK_PB3 1 &pcfg_pull_up_drv_level_2>;
+		};
+		sdmmc0_clk_pins: sdmmc0-clk-pins {
+			rockchip,pins =
+				/* sdmmc0_clk */
+				<1 RK_PB1 1 &pcfg_pull_up_drv_level_2>;
+		};
+		sdmmc0_cmd_pins: sdmmc0-cmd-pins {
+			rockchip,pins =
+				/* sdmmc0_cmd */
+				<1 RK_PB2 1 &pcfg_pull_up_drv_level_2>;
+		};
+		sdmmc0_det_pins: sdmmc0-det-pins {
+			rockchip,pins =
+				/* sdmmc0_det */
+				<1 RK_PA6 1 &pcfg_pull_up>;
+		};
+	};
+
+	sdmmc1 {
+		sdmmc1_bus4_pins: sdmmc1-bus4-pins {
+			rockchip,pins =
+				/* sdmmc1_d0 */
+				<2 RK_PA1 1 &pcfg_pull_up_drv_level_2>,
+				/* sdmmc1_d1 */
+				<2 RK_PA0 1 &pcfg_pull_up_drv_level_2>,
+				/* sdmmc1_d2 */
+				<2 RK_PA5 1 &pcfg_pull_up_drv_level_2>,
+				/* sdmmc1_d3 */
+				<2 RK_PA4 1 &pcfg_pull_up_drv_level_2>;
+		};
+		sdmmc1_clk_pins: sdmmc1-clk-pins {
+			rockchip,pins =
+				/* sdmmc1_clk */
+				<2 RK_PA2 1 &pcfg_pull_up_drv_level_2>;
+		};
+		sdmmc1_cmd_pins: sdmmc1-cmd-pins {
+			rockchip,pins =
+				/* sdmmc1_cmd */
+				<2 RK_PA3 1 &pcfg_pull_up_drv_level_2>;
+		};
+	};
+
+	sdmmc0_testclk {
+		sdmmc0_testclk_clk_pins: sdmmc0-testclk-clk-pins {
+			rockchip,pins =
+				/* sdmmc0_testclk_out */
+				<1 RK_PA0 3 &pcfg_pull_up_drv_level_2>;
+		};
+	};
+
+	sdmmc0_testdata {
+		sdmmc0_testdata_out_pins: sdmmc0-testdata-out-pins {
+			rockchip,pins =
+				/* sdmmc0_testdata_out */
+				<1 RK_PA3 3 &pcfg_pull_none>;
+		};
+	};
+
+	sdmmc1_testclk {
+		sdmmc1_testclk_clk_pins: sdmmc1-testclk-clk-pins {
+			rockchip,pins =
+				/* sdmmc1_testclk_out */
+				<2 RK_PA6 7 &pcfg_pull_up_drv_level_2>;
+		};
+	};
+
+	sdmmc1_testdata {
+		sdmmc1_testdata_out_pins: sdmmc1-testdata-out-pins {
+			rockchip,pins =
+				/* sdmmc1_testdata_out */
+				<2 RK_PA7 7 &pcfg_pull_none>;
+		};
+	};
+
+	spi0 {
+		spi0m0_clk_pins: spi0m0-clk-pins {
+			rockchip,pins =
+				/* spi0_clk_m0 */
+				<2 RK_PB0 2 &pcfg_pull_none>,
+				/* spi0_miso_m0 */
+				<2 RK_PB3 2 &pcfg_pull_none>,
+				/* spi0_mosi_m0 */
+				<2 RK_PB1 2 &pcfg_pull_none>;
+		};
+		spi0m0_cs0_pins: spi0m0-cs0-pins {
+			rockchip,pins =
+				/* spi0_cs0n_m0 */
+				<2 RK_PB2 2 &pcfg_pull_none>;
+		};
+		spi0m0_cs1_pins: spi0m0-cs1-pins {
+			rockchip,pins =
+				/* spi0_cs1n_m0 */
+				<2 RK_PA7 2 &pcfg_pull_none>;
+		};
+		spi0m1_clk_pins: spi0m1-clk-pins {
+			rockchip,pins =
+				/* spi0_clk_m1 */
+				<2 RK_PA2 5 &pcfg_pull_none>,
+				/* spi0_miso_m1 */
+				<2 RK_PA4 5 &pcfg_pull_none>,
+				/* spi0_mosi_m1 */
+				<2 RK_PA1 5 &pcfg_pull_none>;
+		};
+		spi0m1_cs0_pins: spi0m1-cs0-pins {
+			rockchip,pins =
+				/* spi0_cs0n_m1 */
+				<2 RK_PA3 5 &pcfg_pull_none>;
+		};
+		spi0m1_cs1_pins: spi0m1-cs1-pins {
+			rockchip,pins =
+				/* spi0_cs1n_m1 */
+				<2 RK_PA0 5 &pcfg_pull_none>;
+		};
+	};
+
+	uart0 {
+		uart0m0_xfer_pins: uart0m0-xfer-pins {
+			rockchip,pins =
+				/* uart0_rx_m0 */
+				<0 RK_PA6 1 &pcfg_pull_up>,
+				/* uart0_tx_m0 */
+				<0 RK_PA5 1 &pcfg_pull_up>;
+		};
+		uart0m1_xfer_pins: uart0m1-xfer-pins {
+			rockchip,pins =
+				/* uart0_rx_m1 */
+				<0 RK_PB5 2 &pcfg_pull_up>,
+				/* uart0_tx_m1 */
+				<0 RK_PB4 2 &pcfg_pull_up>;
+		};
+		uart0m2_xfer_pins: uart0m2-xfer-pins {
+			rockchip,pins =
+				/* uart0_rx_m2 */
+				<1 RK_PB3 2 &pcfg_pull_up>,
+				/* uart0_tx_m2 */
+				<1 RK_PB4 2 &pcfg_pull_up>;
+		};
+	};
+
+	uart1 {
+		uart1m0_xfer_pins: uart1m0-xfer-pins {
+			rockchip,pins =
+				/* uart1_rx_m0 */
+				<0 RK_PB2 2 &pcfg_pull_up>,
+				/* uart1_tx_m0 */
+				<0 RK_PB3 2 &pcfg_pull_up>;
+		};
+		uart1m0_ctsn_pins: uart1m0-ctsn-pins {
+			rockchip,pins =
+				/* uart1m0_ctsn */
+				<0 RK_PB5 5 &pcfg_pull_none>;
+		};
+		uart1m0_rtsn_pins: uart1m0-rtsn-pins {
+			rockchip,pins =
+				/* uart1m0_rtsn */
+				<0 RK_PB4 5 &pcfg_pull_none>;
+		};
+		uart1m1_xfer_pins: uart1m1-xfer-pins {
+			rockchip,pins =
+				/* uart1_rx_m1 */
+				<1 RK_PA7 2 &pcfg_pull_up>,
+				/* uart1_tx_m1 */
+				<1 RK_PB0 2 &pcfg_pull_up>;
+		};
+		uart1m1_ctsn_pins: uart1m1-ctsn-pins {
+			rockchip,pins =
+				/* uart1m1_ctsn */
+				<1 RK_PB2 2 &pcfg_pull_none>;
+		};
+		uart1m1_rtsn_pins: uart1m1-rtsn-pins {
+			rockchip,pins =
+				/* uart1m1_rtsn */
+				<1 RK_PB1 2 &pcfg_pull_none>;
+		};
+		uart1m2_xfer_pins: uart1m2-xfer-pins {
+			rockchip,pins =
+				/* uart1_rx_m2 */
+				<2 RK_PA7 1 &pcfg_pull_up>,
+				/* uart1_tx_m2 */
+				<2 RK_PA6 1 &pcfg_pull_up>;
+		};
+		uart1m2_ctsn_pins: uart1m2-ctsn-pins {
+			rockchip,pins =
+				/* uart1m2_ctsn */
+				<2 RK_PA5 2 &pcfg_pull_none>;
+		};
+		uart1m2_rtsn_pins: uart1m2-rtsn-pins {
+			rockchip,pins =
+				/* uart1m2_rtsn */
+				<2 RK_PA4 2 &pcfg_pull_none>;
+		};
+		uart1m3_xfer_pins: uart1m3-xfer-pins {
+			rockchip,pins =
+				/* uart1_rx_m3 */
+				<2 RK_PA3 2 &pcfg_pull_up>,
+				/* uart1_tx_m3 */
+				<2 RK_PA2 2 &pcfg_pull_up>;
+		};
+		uart1m3_ctsn_pins: uart1m3-ctsn-pins {
+			rockchip,pins =
+				/* uart1m3_ctsn */
+				<2 RK_PA1 2 &pcfg_pull_none>;
+		};
+		uart1m3_rtsn_pins: uart1m3-rtsn-pins {
+			rockchip,pins =
+				/* uart1m3_rtsn */
+				<2 RK_PA0 2 &pcfg_pull_none>;
+		};
+	};
+
+	uart2 {
+		uart2m0_xfer_pins: uart2m0-xfer-pins {
+			rockchip,pins =
+				/* uart2_rx_m0 */
+				<0 RK_PB1 2 &pcfg_pull_up>,
+				/* uart2_tx_m0 */
+				<0 RK_PB0 2 &pcfg_pull_up>;
+		};
+		uart2m0_ctsn_pins: uart2m0-ctsn-pins {
+			rockchip,pins =
+				/* uart2m0_ctsn */
+				<0 RK_PB3 5 &pcfg_pull_none>;
+		};
+		uart2m0_rtsn_pins: uart2m0-rtsn-pins {
+			rockchip,pins =
+				/* uart2m0_rtsn */
+				<0 RK_PB2 5 &pcfg_pull_none>;
+		};
+		uart2m1_xfer_pins: uart2m1-xfer-pins {
+			rockchip,pins =
+				/* uart2_rx_m1 */
+				<2 RK_PB1 1 &pcfg_pull_up>,
+				/* uart2_tx_m1 */
+				<2 RK_PB0 1 &pcfg_pull_up>;
+		};
+		uart2m1_ctsn_pins: uart2m1-ctsn-pins {
+			rockchip,pins =
+				/* uart2m1_ctsn */
+				<2 RK_PB3 1 &pcfg_pull_none>;
+		};
+		uart2m1_rtsn_pins: uart2m1-rtsn-pins {
+			rockchip,pins =
+				/* uart2m1_rtsn */
+				<2 RK_PB2 1 &pcfg_pull_none>;
+		};
+		uart2m2_xfer_pins: uart2m2-xfer-pins {
+			rockchip,pins =
+				/* uart2_rx_m2 */
+				<1 RK_PB6 3 &pcfg_pull_up>,
+				/* uart2_tx_m2 */
+				<1 RK_PB5 3 &pcfg_pull_up>;
+		};
+		uart2m2_ctsn_pins: uart2m2-ctsn-pins {
+			rockchip,pins =
+				/* uart2m2_ctsn */
+				<1 RK_PC0 3 &pcfg_pull_none>;
+		};
+		uart2m2_rtsn_pins: uart2m2-rtsn-pins {
+			rockchip,pins =
+				/* uart2m2_rtsn */
+				<1 RK_PB7 3 &pcfg_pull_none>;
+		};
+	};
+};
+
+&pinctrl {
+	sdmmc0 {
+		sdmmc0_clk_idle_pins: sdmmc0-clk-idle-pins {
+			rockchip,pins =
+				/* sdmmc0_clk */
+				<1 RK_PB1 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+		sdmmc0_cmd_idle_pins: sdmmc0-cmd-idle-pins {
+			rockchip,pins =
+				/* sdmmc0_cmd */
+				<1 RK_PB2 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+		sdmmc0_bus1_pins: sdmmc0-bus1-pins {
+			rockchip,pins =
+				/* sdmmc0_d0 */
+				<1 RK_PB0 1 &pcfg_pull_up_drv_level_2>;
+		};
+		sdmmc0_bus1_idle_pins: sdmmc0-bus1-idle-pins {
+			rockchip,pins =
+				/* sdmmc0_d0 */
+				<1 RK_PB0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+		sdmmc0_bus4_idle_pins: sdmmc0-bus4-idle-pins {
+			rockchip,pins =
+				/* sdmmc0_d0 */
+				<1 RK_PB0 RK_FUNC_GPIO &pcfg_pull_down>,
+				/* sdmmc0_d1 */
+				<1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_down>,
+				/* sdmmc0_d2 */
+				<1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_down>,
+				/* sdmmc0_d3 */
+				<1 RK_PB3 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	sdmmc1 {
+		sdmmc1_bus1_pins: sdmmc1-bus1-pins {
+			rockchip,pins =
+				/* sdmmc1_d0 */
+				<2 RK_PA1 1 &pcfg_pull_up_drv_level_2>;
+		};
+	};
+};
diff --git a/arch/arm/dts/rv1103b-u-boot.dtsi b/arch/arm/dts/rv1103b-u-boot.dtsi
new file mode 100644
index 000000000000..3b77dd31152f
--- /dev/null
+++ b/arch/arm/dts/rv1103b-u-boot.dtsi
@@ -0,0 +1,4 @@
+// SPDX-License-Identifier:     GPL-2.0+
+// (C) Copyright 2024 Rockchip Electronics Co., Ltd
+
+#include "rockchip-u-boot.dtsi"
diff --git a/arch/arm/dts/rv1103b.dtsi b/arch/arm/dts/rv1103b.dtsi
new file mode 100644
index 000000000000..5c850aa56de7
--- /dev/null
+++ b/arch/arm/dts/rv1103b.dtsi
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co., Ltd.
+ */
+
+#include <dt-bindings/clock/rockchip,rv1103b-cru.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	compatible = "rockchip,rv1103b";
+
+	interrupt-parent = <&gic>;
+
+	arm-pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>;
+	};
+
+	xin32k: oscillator-32k {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+		#clock-cells = <0>;
+	};
+
+	xin24m: oscillator-24m {
+		compatible = "fixed-clock";
+		clock-frequency = <24000000>;
+		clock-output-names = "xin24m";
+		#clock-cells = <0>;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a7";
+			reg = <0x0>;
+			clocks = <&cru ARMCLK>;
+		};
+	};
+
+	timer {
+		compatible = "arm,armv7-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+		clock-frequency = <24000000>;
+	};
+
+	cru: clock-controller@20000000 {
+		compatible = "rockchip,rv1103b-cru";
+		reg = <0x20000000 0x81000>;
+		#clock-cells = <1>;
+		#reset-cells = <1>;
+		bootph-all;
+		assigned-clocks = <&cru PLL_GPLL>, <&cru CLK_GPLL_DIV12>;
+		assigned-clock-rates = <1188000000>, <100000000>;
+	};
+
+	/*
+	 * Merge all GRF, each independent GRF offset is shown as bellow:
+	 * VEPU_GRF:		0x20100000
+	 * NPU_GRF:		0x20110000
+	 * VI_GRF:		0x20120000
+	 * CPU_GRF:		0x20130000
+	 * DDR_GRF:		0x20140000
+	 * SYS_GRF:		0x20150000
+	 * PMU_GRF:		0x20160000
+	 */
+	grf: syscon@20100000 {
+		compatible = "rockchip,rv1103b-grf", "syscon", "simple-mfd";
+		reg = <0x20100000 0x61000>;
+
+		reboot_mode: reboot-mode {
+			compatible = "syscon-reboot-mode";
+			offset = <0x60200>;
+		};
+	};
+
+	ioc: syscon@20170000 {
+		compatible = "rockchip,rv1103b-ioc", "syscon";
+		reg = <0x20170000 0x60000>;
+	};
+
+	gic: interrupt-controller@20411000 {
+		compatible = "arm,gic-400";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+
+		reg = <0x20411000 0x1000>,
+		      <0x20412000 0x2000>,
+		      <0x20414000 0x2000>,
+		      <0x20416000 0x2000>;
+		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
+	uart0: serial@20540000 {
+		compatible = "rockchip,rv1103b-uart", "snps,dw-apb-uart";
+		reg = <0x20540000 0x100>;
+		interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clock-frequency = <24000000>;
+		clocks = <&cru SCLK_UART0>, <&cru PCLK_UART0>;
+		clock-names = "baudclk", "apb_pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart0m0_xfer_pins>;
+		status = "disabled";
+	};
+
+	sdmmc1: mmc@20650000 {
+		compatible = "rockchip,rv1103b-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x20650000 0x4000>;
+		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_SDMMC1>, <&cru CCLK_SDMMC1>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x100>;
+		max-frequency = <150000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&sdmmc1_clk_pins &sdmmc1_cmd_pins &sdmmc1_bus4_pins>;
+		status = "disabled";
+	};
+
+	uart1: serial@20870000 {
+		compatible = "rockchip,rv1103b-uart", "snps,dw-apb-uart";
+		reg = <0x20870000 0x100>;
+		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clock-frequency = <24000000>;
+		clocks = <&cru SCLK_UART1>, <&cru PCLK_UART1>;
+		clock-names = "baudclk", "apb_pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart1m0_xfer_pins>;
+		status = "disabled";
+	};
+
+	uart2: serial@20880000 {
+		compatible = "rockchip,rv1103b-uart", "snps,dw-apb-uart";
+		reg = <0x20880000 0x100>;
+		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		clock-frequency = <24000000>;
+		clocks = <&cru SCLK_UART2>, <&cru PCLK_UART2>;
+		clock-names = "baudclk", "apb_pclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&uart2m0_xfer_pins>;
+		status = "disabled";
+	};
+
+	wdt: watchdog@208d0000 {
+		compatible = "snps,dw-wdt";
+		reg = <0x208d0000 0x100>;
+		clocks = <&cru TCLK_WDT_NS>, <&cru PCLK_WDT_NS>;
+		clock-names = "tclk", "pclk";
+		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	sdmmc0: mmc@20d20000 {
+		compatible = "rockchip,rv1103b-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x20d20000 0x4000>;
+		interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_SDMMC0>, <&cru CCLK_SDMMC0>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x100>;
+		max-frequency = <150000000>;
+		pinctrl-names = "normal", "idle";
+		pinctrl-0 = <&sdmmc0_det_pins
+			     &sdmmc0_clk_pins
+			     &sdmmc0_cmd_pins
+			     &sdmmc0_bus4_pins>;
+		pinctrl-1 = <&sdmmc0_det_pins
+			     &sdmmc0_clk_idle_pins
+			     &sdmmc0_cmd_idle_pins
+			     &sdmmc0_bus4_idle_pins>;
+		status = "disabled";
+	};
+
+	emmc: mmc@20d30000 {
+		compatible = "rockchip,rv1103b-dw-mshc", "rockchip,rk3288-dw-mshc";
+		reg = <0x20d30000 0x4000>;
+		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_EMMC>, <&cru CCLK_EMMC>;
+		clock-names = "biu", "ciu";
+		fifo-depth = <0x100>;
+		max-frequency = <150000000>;
+		status = "disabled";
+	};
+
+	fspi0: spi@20d40000 {
+		compatible = "rockchip,sfc";
+		reg = <0x20d40000 0x4000>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_SFC_2X>, <&cru HCLK_SFC>;
+		clock-names = "clk_sfc", "hclk_sfc";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	system_sram: sram@210f6000 {
+		compatible = "mmio-sram";
+		reg = <0x210f6000 0x8000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0x210f6000 0x8000>;
+	};
+
+	pinctrl: pinctrl {
+		compatible = "rockchip,rv1103b-pinctrl";
+		rockchip,grf = <&ioc>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		gpio0: gpio@20520000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x20520000 0x200>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_PMU_GPIO0>, <&cru DBCLK_PMU_GPIO0>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 0 32>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio1: gpio@20d80000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x20d80000 0x200>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO1>, <&cru DBCLK_GPIO1>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 32 32>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpio2: gpio@20840000 {
+			compatible = "rockchip,gpio-bank";
+			reg = <0x20840000 0x200>;
+			interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cru PCLK_GPIO2>, <&cru DBCLK_GPIO2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pinctrl 0 64 32>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
+
+#include "rv1103b-pinctrl.dtsi"
diff --git a/include/dt-bindings/clock/rockchip,rv1103b-cru.h b/include/dt-bindings/clock/rockchip,rv1103b-cru.h
new file mode 100644
index 000000000000..35afdee7e961
--- /dev/null
+++ b/include/dt-bindings/clock/rockchip,rv1103b-cru.h
@@ -0,0 +1,220 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
+/*
+ * Copyright (c) 2024 Rockchip Electronics Co. Ltd.
+ * Author: Elaine Zhang <zhangqing@rock-chips.com>
+ */
+
+#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RV1103B_H
+#define _DT_BINDINGS_CLK_ROCKCHIP_RV1103B_H
+
+#define PLL_GPLL		0
+#define ARMCLK			1
+#define PLL_DPLL		2
+#define XIN_OSC0_HALF		3
+#define CLK_GPLL_DIV24		4
+#define CLK_GPLL_DIV12		5
+#define CLK_GPLL_DIV6		6
+#define CLK_GPLL_DIV4		7
+#define CLK_GPLL_DIV3		8
+#define CLK_GPLL_DIV2P5		9
+#define CLK_GPLL_DIV2		10
+#define CLK_UART0_SRC		11
+#define CLK_UART1_SRC		12
+#define CLK_UART2_SRC		13
+#define CLK_UART0_FRAC		14
+#define CLK_UART1_FRAC		15
+#define CLK_UART2_FRAC		16
+#define CLK_SAI_SRC		17
+#define CLK_SAI_FRAC		18
+#define LSCLK_NPU_SRC		19
+#define CLK_NPU_SRC		20
+#define ACLK_VEPU_SRC		21
+#define CLK_VEPU_SRC		22
+#define ACLK_VI_SRC		23
+#define CLK_ISP_SRC		24
+#define DCLK_VICAP		25
+#define CCLK_EMMC		26
+#define CCLK_SDMMC0		27
+#define SCLK_SFC_2X		28
+#define LSCLK_PERI_SRC		29
+#define ACLK_PERI_SRC		30
+#define HCLK_HPMCU		31
+#define SCLK_UART0		32
+#define SCLK_UART1		33
+#define SCLK_UART2		34
+#define CLK_I2C_PMU		35
+#define CLK_I2C_PERI		36
+#define CLK_SPI0		37
+#define CLK_PWM0_SRC		38
+#define CLK_PWM1		39
+#define CLK_PWM2		40
+#define DCLK_DECOM_SRC		41
+#define CCLK_SDMMC1		42
+#define CLK_CORE_CRYPTO		43
+#define CLK_PKA_CRYPTO		44
+#define CLK_CORE_RGA		45
+#define MCLK_SAI_SRC		46
+#define CLK_FREQ_PWM0_SRC	47
+#define CLK_COUNTER_PWM0_SRC	48
+#define PCLK_TOP_ROOT		49
+#define CLK_REF_MIPI0		50
+#define CLK_MIPI0_OUT2IO	51
+#define CLK_REF_MIPI1		52
+#define CLK_MIPI1_OUT2IO	53
+#define MCLK_SAI_OUT2IO		54
+#define ACLK_NPU_ROOT		55
+#define HCLK_RKNN		56
+#define ACLK_RKNN		57
+#define LSCLK_VEPU_ROOT		58
+#define HCLK_VEPU		59
+#define ACLK_VEPU		60
+#define CLK_CORE_VEPU		61
+#define PCLK_IOC_VCCIO3		62
+#define PCLK_ACODEC		63
+#define PCLK_USBPHY		64
+#define LSCLK_VI_100M		65
+#define LSCLK_VI_ROOT		66
+#define HCLK_ISP		67
+#define ACLK_ISP		68
+#define CLK_CORE_ISP		69
+#define ACLK_VICAP		70
+#define HCLK_VICAP		71
+#define ISP0CLK_VICAP		72
+#define PCLK_CSI2HOST0		73
+#define PCLK_CSI2HOST1		74
+#define HCLK_EMMC		75
+#define HCLK_SFC		76
+#define HCLK_SFC_XIP		77
+#define HCLK_SDMMC0		78
+#define PCLK_CSIPHY		79
+#define PCLK_GPIO1		80
+#define DBCLK_GPIO1		81
+#define PCLK_IOC_VCCIO47	82
+#define LSCLK_DDR_ROOT		83
+#define CLK_TIMER_DDRMON	84
+#define LSCLK_PMU_ROOT		85
+#define PCLK_PMU		86
+#define XIN_RC_DIV		87
+#define CLK_32K			88
+#define PCLK_PMU_GPIO0		89
+#define DBCLK_PMU_GPIO0		90
+#define CLK_DDR_FAIL_SAFE	91
+#define PCLK_PMU_HP_TIMER	92
+#define CLK_PMU_32K_HP_TIMER	93
+#define PCLK_PWM0		94
+#define CLK_PWM0		95
+#define CLK_OSC_PWM0		96
+#define CLK_RC_PWM0		97
+#define CLK_FREQ_PWM0		98
+#define CLK_COUNTER_PWM0	99
+#define PCLK_I2C0		100
+#define CLK_I2C0		101
+#define PCLK_UART0		102
+#define PCLK_IOC_PMUIO0		103
+#define CLK_REFOUT		104
+#define CLK_PREROLL		105
+#define CLK_PREROLL_32K		106
+#define CLK_LPMCU_PMU		107
+#define PCLK_SPI2AHB		108
+#define HCLK_SPI2AHB		109
+#define SCLK_SPI2AHB		110
+#define PCLK_WDT_LPMCU		111
+#define TCLK_WDT_LPMCU		112
+#define HCLK_SFC_PMU1		113
+#define HCLK_SFC_XIP_PMU1	114
+#define SCLK_SFC_2X_PMU1	115
+#define CLK_LPMCU		116
+#define CLK_LPMCU_RTC		117
+#define PCLK_LPMCU_MAILBOX	118
+#define PCLK_IOC_PMUIO1		119
+#define PCLK_CRU_PMU1		120
+#define PCLK_PERI_ROOT		121
+#define PCLK_RTC_ROOT		122
+#define CLK_TIMER_ROOT		123
+#define PCLK_TIMER		124
+#define CLK_TIMER0		125
+#define CLK_TIMER1		126
+#define CLK_TIMER2		127
+#define CLK_TIMER3		128
+#define CLK_TIMER4		129
+#define CLK_TIMER5		130
+#define PCLK_STIMER		131
+#define CLK_STIMER0		132
+#define CLK_STIMER1		133
+#define PCLK_WDT_NS		134
+#define TCLK_WDT_NS		135
+#define PCLK_WDT_S		136
+#define TCLK_WDT_S		137
+#define PCLK_WDT_HPMCU		138
+#define TCLK_WDT_HPMCU		139
+#define PCLK_I2C1		140
+#define CLK_I2C1		141
+#define PCLK_I2C2		142
+#define CLK_I2C2		143
+#define PCLK_I2C3		144
+#define CLK_I2C3		145
+#define PCLK_I2C4		146
+#define CLK_I2C4		147
+#define PCLK_SPI0		148
+#define PCLK_PWM1		149
+#define CLK_OSC_PWM1		150
+#define PCLK_PWM2		151
+#define CLK_OSC_PWM2		152
+#define PCLK_UART2		153
+#define PCLK_UART1		154
+#define ACLK_RKDMA		155
+#define PCLK_TSADC		156
+#define CLK_TSADC		157
+#define CLK_TSADC_TSEN		158
+#define PCLK_SARADC		159
+#define CLK_SARADC		160
+#define PCLK_GPIO2		161
+#define DBCLK_GPIO2		162
+#define PCLK_IOC_VCCIO6		163
+#define ACLK_USBOTG		164
+#define CLK_REF_USBOTG		165
+#define HCLK_SDMMC1		166
+#define HCLK_SAI		167
+#define MCLK_SAI		168
+#define ACLK_CRYPTO		169
+#define HCLK_CRYPTO		170
+#define HCLK_RK_RNG_NS		171
+#define HCLK_RK_RNG_S		172
+#define PCLK_OTPC_NS		173
+#define CLK_OTPC_ROOT_NS	174
+#define CLK_SBPI_OTPC_NS	175
+#define CLK_USER_OTPC_NS	176
+#define PCLK_OTPC_S		177
+#define CLK_OTPC_ROOT_S		178
+#define CLK_SBPI_OTPC_S		179
+#define CLK_USER_OTPC_S		180
+#define CLK_OTPC_ARB		181
+#define PCLK_OTP_MASK		182
+#define HCLK_RGA		183
+#define ACLK_RGA		184
+#define ACLK_MAC		185
+#define PCLK_MAC		186
+#define CLK_MACPHY		187
+#define ACLK_SPINLOCK		188
+#define HCLK_CACHE		189
+#define PCLK_HPMCU_MAILBOX	190
+#define PCLK_HPMCU_INTMUX	191
+#define CLK_HPMCU		192
+#define CLK_HPMCU_RTC		193
+#define DCLK_DECOM		194
+#define ACLK_DECOM		195
+#define PCLK_DECOM		196
+#define ACLK_SYS_SRAM		197
+#define PCLK_DMA2DDR		198
+#define ACLK_DMA2DDR		199
+#define PCLK_DCF		200
+#define ACLK_DCF		201
+#define MCLK_ACODEC_TX		202
+#define SCLK_UART0_SRC		203
+#define SCLK_UART1_SRC		204
+#define SCLK_UART2_SRC		205
+#define XIN_RC_SRC		206
+#define CLK_UTMI_USBOTG		207
+#define CLK_REF_USBPHY		208
+
+#endif // _DT_BINDINGS_CLK_ROCKCHIP_RV1103B_H
-- 
2.34.1

