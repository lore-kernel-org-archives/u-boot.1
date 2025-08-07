Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AD7C87FCF
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 08:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0218447C;
	Thu,  7 Aug 2025 10:26:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ilx6w0H4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 80D9883AD5; Thu,  7 Aug 2025 09:47:31 +0200 (CEST)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 983DB83A43
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 09:47:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cn.liweihao@gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-313bb9b2f5bso939557a91.3
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754552846; x=1755157646; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/y9YzCDj8fEg5/ySF+6Wve9cbidoSsQT0eNASs0N6M=;
 b=ilx6w0H4FbAuoaWGU9onkqopLEnD3uZoEAoDeKjkVedjho8wBd7a8I+jU5C2ub4u9u
 Av+OSit27yi/RMX1pdi4PEs3OlOQToNYTFyIWw4ZMHZF8pT1LnbLdhP+npqOq6+BJPGp
 y+zVH870RmB+cM73yFWtFBoJ2p9Sv/3uS47q0Ofp2H/kUsmfgLD3RL2lhhvNfrx7wM0i
 Bje6BqUJKqz+3UuvfZ5xSC6YYIb10quXCxchpCcl1yp4+90Qdh45eH25X43cA0lt9di4
 ufEmnJwecLXTnk5kwlEFqZBJ0ohNxtBRSS7C9qT+m0cgBR7w3Lw8zwfISQbGpcGZ2tk7
 5JBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754552846; x=1755157646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/y9YzCDj8fEg5/ySF+6Wve9cbidoSsQT0eNASs0N6M=;
 b=QmamGUvVrr+lQOWt/bYgn3PlhEvd8eCEgSk8QO1mJ0C3e4c8sQ96Z62UthhtATAqq0
 mY0lcQqo/neajzt7aTb2nd2gKHpfKoZXoYmoDApmS+pG4LckSRQXta/xin6Ol06rV6rO
 +V61jGtcZ0DT0bd4Hfix3BnogOISARYTXnz+gApl/gxVaiOvlSlbU4VoNV4QGna5R7m+
 ogqlHZ8HzLfiOywNoFD6YXXq5IJpEX5KXRb4uVEKI/+K6vlDtdP84342+u4csPwzVrEZ
 X1JEE+VkAtdko3i4zltafCySy0K91cPVWFe6RwiGPhkn/S3/UBhOm3Z66MuFR33myF4h
 lhxw==
X-Gm-Message-State: AOJu0YxkLBFEwtuZvwV7cS5e/9fWwxG7A5+aPOwyiYz38q1m/wGzhUDb
 dwSENsqVcEBycbWGrYluPEYoHy7T8N2sB052wE+Z2MNgrQOva/amD3pg9bI5o8rp
X-Gm-Gg: ASbGncsaUnKmwYpMjcAQFzHt5Exw8hPCCkpjHyCX51hOUaXiMfJ32YNJnic1onv/+BN
 uIAegr6qseuZQMvWbsHj+nQxAQ42EJC6YZf9fwJXwdKNTNTasgS8ljz+EuKk/za+5o1RY52Bhm6
 8Kt7Eg0ZUelyPf0ZsbMOgHLX6nXQlXHfBaxpBq3gsf9BSRUOc+NtJAGw+Kx2S+vRKIyrRS1/k0U
 IvdY3Tu7ITHIx2xg6ipk8vDwfoET9+/onf6cJjdjimVosM9cSAm6pkuWRF1Vj7ernEB7htWpKM3
 3rno2xlC++Msit7MkH5/nlhcdtAlzDf4bktPF8/YgsU1irq04s5Ltmb1gsjjC/T03EmOkeIVxSo
 27R9b1CuUFqLekTd5OsA4/b+FWOXJJU9ur15p
X-Google-Smtp-Source: AGHT+IGdhPIXb2xcF0W5zRKKmKwCgleBcXbUDQSSo7Sg365qOrKZd6hKzi2KsUVhLJF8JHP1DQdptQ==
X-Received: by 2002:a17:90b:3b8a:b0:31e:f3b7:49d2 with SMTP id
 98e67ed59e1d1-32166b2e937mr9557512a91.0.1754552845661; 
 Thu, 07 Aug 2025 00:47:25 -0700 (PDT)
Received: from localhost.localdomain ([218.90.41.167])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-320f4909b8bsm16809202a91.16.2025.08.07.00.47.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 00:47:25 -0700 (PDT)
From: WeiHao Li <cn.liweihao@gmail.com>
To: u-boot@lists.denx.de
Cc: antonio.borneo@foss.st.com, mk7.kang@samsung.com,
 gregkh@linuxfoundation.org, semen.protsenko@linaro.org,
 mikhail.kshevetskiy@iopsys.eu, bb@ti.com, justin.swartz@risingedge.co.za,
 lukasz.czechowski@thaumatec.com, robh@kernel.org, tharvey@gateworks.com,
 clement.legoffic@foss.st.com, marek.vasut@mailbox.org,
 dinesh.maniyam@altera.com, patrice.chotard@foss.st.com, festevam@gmail.com,
 jerome.forissier@linaro.org, quentin.schulz@cherry.de,
 andrew.goodbody@linaro.org, sumit.garg@kernel.org, ag.dev.uboot@gmail.com,
 rfried.dev@gmail.com, joe.hershberger@ni.com, jh80.chung@samsung.com,
 peng.fan@nxp.com, seanga2@gmail.com, lukma@denx.de,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org,
 trini@konsulko.com, WeiHao Li <cn.liweihao@gmail.com>,
 WeiHao Li <ieiao@outlook.com>
Subject: [PATCH 10/10] board: rockchip: add rk3368 ymd8_mb support
Date: Thu,  7 Aug 2025 15:44:18 +0800
Message-Id: <20250807074419.336752-11-cn.liweihao@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250807074419.336752-1-cn.liweihao@gmail.com>
References: <20250807074419.336752-1-cn.liweihao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Aug 2025 10:26:22 +0200
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

Signed-off-by: WeiHao Li <ieiao@outlook.com>
---
 arch/arm/dts/Makefile                   |   1 +
 arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi |  44 ++++
 arch/arm/dts/rk3368-ymd8-mb.dts         | 326 ++++++++++++++++++++++++
 arch/arm/dts/rk3368.dtsi                | 258 +++++++++++++++++++
 arch/arm/mach-rockchip/rk3368/Kconfig   |   6 +
 board/rockchip/ymd8_mb/Kconfig          |  12 +
 board/rockchip/ymd8_mb/MAINTAINERS      |   6 +
 board/rockchip/ymd8_mb/Makefile         |   7 +
 board/rockchip/ymd8_mb/README           |   1 +
 board/rockchip/ymd8_mb/ymd8_mb_rk3368.c |  19 ++
 configs/ymd8-mb_defconfig               |  72 ++++++
 include/configs/ymd8_mb.h               |  11 +
 12 files changed, 763 insertions(+)
 create mode 100644 arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3368-ymd8-mb.dts
 create mode 100644 board/rockchip/ymd8_mb/Kconfig
 create mode 100644 board/rockchip/ymd8_mb/MAINTAINERS
 create mode 100644 board/rockchip/ymd8_mb/Makefile
 create mode 100644 board/rockchip/ymd8_mb/README
 create mode 100644 board/rockchip/ymd8_mb/ymd8_mb_rk3368.c
 create mode 100644 configs/ymd8-mb_defconfig
 create mode 100644 include/configs/ymd8_mb.h

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 0dc7e190eb..1dfd1c5236 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -73,6 +73,7 @@ dtb-$(CONFIG_ROCKCHIP_RK3368) += \
 	rk3368-sheep.dtb \
 	rk3368-geekbox.dtb \
 	rk3368-px5-evb.dtb \
+	rk3368-ymd8-mb.dtb
 
 dtb-$(CONFIG_ARCH_S5P4418) += \
 	s5p4418-nanopi2.dtb
diff --git a/arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi b/arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi
new file mode 100644
index 0000000000..925264e620
--- /dev/null
+++ b/arch/arm/dts/rk3368-ymd8-mb-u-boot.dtsi
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+ OR X11
+/*
+ * (C) Copyright 2017 Theobroma Systems Design und Consulting GmbH
+ */
+
+#include "rk3368-u-boot.dtsi"
+
+&pinctrl {
+	bootph-all;
+};
+
+&service_msch {
+	bootph-all;
+};
+
+&dmc {
+	bootph-all;
+	status = "okay";
+};
+
+&pmugrf {
+	bootph-all;
+};
+
+&cru {
+	bootph-all;
+};
+
+&grf {
+	bootph-all;
+};
+
+&uart2 {
+	bootph-all;
+	clock-frequency = <24000000>;
+};
+
+&pwm1 {
+	bootph-all;
+};
+
+&vop {
+	bootph-all;
+};
diff --git a/arch/arm/dts/rk3368-ymd8-mb.dts b/arch/arm/dts/rk3368-ymd8-mb.dts
new file mode 100644
index 0000000000..661390b9d5
--- /dev/null
+++ b/arch/arm/dts/rk3368-ymd8-mb.dts
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2025 Weihao Li
+ */
+
+/dts-v1/;
+#include "rk3368.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "YMD8_MB";
+	compatible = "rockchip,YMD8_MB", "rockchip,rk3368";
+
+	aliases {
+		mmc0 = &emmc;
+	};
+
+	chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x40000000>;
+	};
+
+	keys: gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwr_key>;
+
+		power {
+			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_LOW>;
+			label = "GPIO Power";
+			linux,code = <KEY_POWER>;
+			wakeup-source;
+		};
+	};
+
+	vcc_sys: vcc-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sys";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		power-supply = <&vcc_sys>;
+		enable-gpios = <&gpio0 RK_PD1 GPIO_ACTIVE_HIGH>;
+		brightness-levels = <
+			  0   1   2   3   4   5   6   7
+			  8   9  10  11  12  13  14  15
+			 16  17  18  19  20  21  22  23
+			 24  25  26  27  28  29  30  31
+			 32  33  34  35  36  37  38  39
+			 40  41  42  43  44  45  46  47
+			 48  49  50  51  52  53  54  55
+			 56  57  58  59  60  61  62  63
+			 64  65  66  67  68  69  70  71
+			 72  73  74  75  76  77  78  79
+			 80  81  82  83  84  85  86  87
+			 88  89  90  91  92  93  94  95
+			 96  97  98  99 100 101 102 103
+			104 105 106 107 108 109 110 111
+			112 113 114 115 116 117 118 119
+			120 121 122 123 124 125 126 127
+			128 129 130 131 132 133 134 135
+			136 137 138 139 140 141 142 143
+			144 145 146 147 148 149 150 151
+			152 153 154 155 156 157 158 159
+			160 161 162 163 164 165 166 167
+			168 169 170 171 172 173 174 175
+			176 177 178 179 180 181 182 183
+			184 185 186 187 188 189 190 191
+			192 193 194 195 196 197 198 199
+			200 201 202 203 204 205 206 207
+			208 209 210 211 212 213 214 215
+			216 217 218 219 220 221 222 223
+			224 225 226 227 228 229 230 231
+			232 233 234 235 236 237 238 239
+			240 241 242 243 244 245 246 247
+			248 249 250 251 252 253 254 255>;
+		default-brightness-level = <50>;
+		pwms = <&pwm1 0 25000 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pwm1_pin>;
+		status = "okay";
+	};
+
+	panel: panel {
+		compatible = "unknown,rm72014";
+		power-supply = <&vcc_io>;
+		backlight = <&backlight>;
+		reset-gpios = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
+		status = "okay";
+
+		port {
+			panel_dsi_in: endpoint {
+				remote-endpoint = <&dsi_out_panel>;
+			};
+		};
+	};
+};
+
+&emmc {
+	status = "okay";
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	clock-frequency = <150000000>;
+	mmc-hs200-1_8v;
+	no-sdio;
+	no-sd;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk>, <&emmc_cmd>, <&emmc_bus8>;
+	vmmc-supply = <&vcc_io>;
+	vqmmc-supply = <&vcc18_flash>;
+};
+
+&i2c0 {
+	status = "okay";
+
+	rk808: pmic@1b {
+		compatible = "rockchip,rk808";
+		reg = <0x1b>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int>, <&pmic_sleep>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA1 IRQ_TYPE_LEVEL_LOW>;
+		rockchip,system-power-controller;
+		vcc1-supply = <&vcc_sys>;
+		vcc2-supply = <&vcc_sys>;
+		vcc3-supply = <&vcc_sys>;
+		vcc4-supply = <&vcc_sys>;
+		vcc6-supply = <&vcc_sys>;
+		vcc7-supply = <&vcc_sys>;
+		vcc8-supply = <&vcc_io>;
+		vcc9-supply = <&vcc_sys>;
+		vcc10-supply = <&vcc_sys>;
+		vcc11-supply = <&vcc_sys>;
+		vcc12-supply = <&vcc_io>;
+		clock-output-names = "xin32k", "rk808-clkout2";
+		#clock-cells = <1>;
+
+		regulators {
+			vdd_cpu: DCDC_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1500000>;
+				regulator-name = "vdd_cpu";
+			};
+
+			vdd_log: DCDC_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "vdd_log";
+			};
+
+			vcc_ddr: DCDC_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-name = "vcc_ddr";
+			};
+
+			vcc_io: DCDC_REG4 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcc_io";
+			};
+
+			vcc18_flash: LDO_REG1 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc18_flash";
+			};
+
+			vcc33_lcd: LDO_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vcca_33";
+			};
+
+			vdd_10: LDO_REG3 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "vdd_10";
+			};
+
+			vcca_18: LDO_REG4 {
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcca_18";
+			};
+
+			vccio_sd: LDO_REG5 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-name = "vccio_sd";
+			};
+
+			vdd10_lcd: LDO_REG6 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1000000>;
+				regulator-name = "vdd10_lcd";
+			};
+
+			vcc_18: LDO_REG7 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc_18";
+			};
+
+			vcc18_lcd: LDO_REG8 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-name = "vcc18_lcd";
+			};
+
+			vcc_sd: SWITCH_REG1 {
+				regulator-name = "vcc_sd";
+			};
+
+			vcc_lan: SWITCH_REG2 {
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-name = "vcc_lan";
+			};
+		};
+	};
+};
+
+&pinctrl {
+	keys {
+		pwr_key: pwr-key {
+			rockchip,pins = <0 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_sleep: pmic-sleep {
+			rockchip,pins = <0 RK_PA0 2 &pcfg_pull_none>;
+		};
+
+		pmic_int: pmic-int {
+			rockchip,pins = <0 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&tsadc {
+	status = "okay";
+	rockchip,hw-tshut-mode = <0>; /* CRU */
+	rockchip,hw-tshut-polarity = <1>; /* high */
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+};
+
+&wdt {
+	status = "okay";
+};
+
+&pwm1 {
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vop {
+	status = "okay";
+};
+
+&mipi_dsi {
+	status = "okay";
+
+	ports {
+		mipi_out: port@1 {
+			reg = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			dsi_out_panel: endpoint {
+				remote-endpoint = <&panel_dsi_in>;
+			};
+		};
+	};
+};
+
+&video_phy {
+	status = "okay";
+};
diff --git a/arch/arm/dts/rk3368.dtsi b/arch/arm/dts/rk3368.dtsi
index 4c64fbefb4..77ff551681 100644
--- a/arch/arm/dts/rk3368.dtsi
+++ b/arch/arm/dts/rk3368.dtsi
@@ -650,6 +650,62 @@
 			compatible = "rockchip,rk3368-io-voltage-domain";
 			status = "disabled";
 		};
+
+		lvds: lvds {
+			compatible = "rockchip,rk3368-lvds";
+			phys = <&video_phy>;
+			phy-names = "phy";
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				lvds_in: port {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					lvds_in_vop: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&vop_out_lvds>;
+					};
+				};
+			};
+		};
+
+		rgb: rgb {
+			compatible = "rockchip,rk3368-rgb";
+			phys = <&video_phy>;
+			phy-names = "phy";
+			pinctrl-names = "default";
+			pinctrl-0 = <&lcdc_rgb_pins>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				rgb_in: port {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					rgb_in_vop: endpoint@0 {
+						reg = <0>;
+						remote-endpoint = <&vop_out_rgb>;
+					};
+				};
+			};
+		};
+
+		edp_phy: edp-phy {
+			compatible = "rockchip,rk3368-dp-phy";
+			clocks = <&cru SCLK_EDP_24M>;
+			clock-names = "24m";
+			resets = <&cru SRST_EDP_24M>;
+			reset-names = "edp_24m";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
 	};
 
 	wdt: watchdog@ff800000 {
@@ -740,6 +796,167 @@
 		status = "disabled";
 	};
 
+	vop: vop@ff930000 {
+		compatible = "rockchip,rk3368-vop";
+		rockchip,grf = <&grf>;
+		reg = <0x0 0xff930000 0x0 0x2fc>, <0x0 0xff931000 0x0 0x400>;
+		reg-names = "regs", "gamma_lut";
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_VOP>, <&cru DCLK_VOP>, <&cru HCLK_VOP>;
+		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
+		assigned-clocks = <&cru ACLK_VOP>, <&cru HCLK_VOP>;
+		assigned-clock-rates = <400000000>, <200000000>;
+		resets = <&cru SRST_LCDC0_AXI>, <&cru SRST_LCDC0_AHB>, <&cru SRST_LCDC0_DCLK>;
+		reset-names = "axi", "ahb", "dclk";
+		iommus = <&vop_mmu>;
+		status = "disabled";
+
+		vop_out: port {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			vop_out_dsi: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&dsi_in_vop>;
+			};
+
+			vop_out_edp: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&edp_in_vop>;
+			};
+
+			vop_out_hdmi: endpoint@2 {
+				reg = <2>;
+				remote-endpoint = <&hdmi_in_vop>;
+			};
+
+			vop_out_lvds: endpoint@3 {
+				reg = <3>;
+				remote-endpoint = <&lvds_in_vop>;
+			};
+
+			vop_out_rgb: endpoint@4 {
+				reg = <4>;
+				remote-endpoint = <&rgb_in_vop>;
+			};
+		};
+	};
+
+	display_subsystem: display-subsystem {
+		compatible = "rockchip,display-subsystem";
+		ports = <&vop_out>;
+		status = "disabled";
+	};
+
+	mipi_dsi: mipi-dsi@ff960000 {
+		compatible = "rockchip,rk3368-mipi-dsi", "snps,dw-mipi-dsi";
+		reg = <0x0 0xff960000 0x0 0x4000>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_MIPI_DSI0>;
+		clock-names = "pclk";
+		resets = <&cru SRST_MIPIDSI0>;
+		reset-names = "apb";
+		phys = <&video_phy>;
+		phy-names = "dphy";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			mipi_in: port@0 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				dsi_in_vop: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&vop_out_dsi>;
+				};
+			};
+
+			mipi_out: port@1 {
+				reg = <1>;
+			};
+
+		};
+	};
+
+	video_phy: video-phy@ff968000 {
+		compatible = "rockchip,rk3368-dsi-dphy";
+		reg = <0x0 0xff968000 0x0 0x4000>,
+		      <0x0 0xff960000 0x0 0x4000>;
+		clocks = <&cru SCLK_MIPIDSI_24M>, <&cru PCLK_DPHYTX0>,
+			 <&cru PCLK_MIPI_DSI0>;
+		clock-names = "ref", "pclk", "pclk_host";
+		#clock-cells = <0>;
+		resets = <&cru SRST_MIPIDPHYTX>;
+		reset-names = "apb";
+		#phy-cells = <0>;
+		status = "disabled";
+	};
+
+	edp: edp@ff970000 {
+		compatible = "rockchip,rk3368-edp";
+		reg = <0x0 0xff970000 0x0 0x8000>;
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru SCLK_EDP>, <&cru PCLK_EDP_CTRL>;
+		clock-names = "dp", "pclk";
+		resets = <&cru SRST_EDP>;
+		reset-names = "dp";
+		rockchip,grf = <&grf>;
+		phys = <&edp_phy>;
+		phy-names = "dp";
+		pinctrl-names = "default";
+		pinctrl-0 = <&edp_hpd>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			edp_in: port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				edp_in_vop: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&vop_out_edp>;
+				};
+			};
+		};
+	};
+
+	hdmi: hdmi@ff980000 {
+		compatible = "rockchip,rk3368-dw-hdmi";
+		reg = <0x0 0xff980000 0x0 0x20000>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru PCLK_HDMI_CTRL>, <&cru SCLK_HDMI_HDCP>, <&cru SCLK_HDMI_CEC>;
+		clock-names = "iahb", "isfr", "cec";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_i2c_xfer>, <&hdmi_cec>;
+		resets = <&cru SRST_HDMI>;
+		reset-names = "hdmi";
+		rockchip,grf = <&grf>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			hdmi_in: port {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				hdmi_in_vop: endpoint@0 {
+					reg = <0>;
+					remote-endpoint = <&vop_out_hdmi>;
+				};
+			};
+		};
+	};
+
 	hevc_mmu: iommu@ff9a0440 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff9a0440 0x0 0x40>,
@@ -1214,5 +1431,46 @@
 				rockchip,pins = <0 RK_PD1 3 &pcfg_pull_none>;
 			};
 		};
+
+		lcdc {
+			lcdc_rgb_pins: lcdc-rgb-pins {
+				rockchip,pins =
+					<0 14 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D10 */
+					<0 15 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D11 */
+					<0 16 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D12 */
+					<0 17 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D13 */
+					<0 18 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D14 */
+					<0 19 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D15 */
+					<0 20 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D16 */
+					<0 21 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D17 */
+					<0 22 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D18 */
+					<0 23 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D19 */
+					<0 24 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D20 */
+					<0 25 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D21 */
+					<0 26 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D22 */
+					<0 27 RK_FUNC_1 &pcfg_pull_none>,  /* LCDC_D23 */
+					<0 31 RK_FUNC_1 &pcfg_pull_none>,  /* DCLK */
+					<0 30 RK_FUNC_1 &pcfg_pull_none>,  /* DEN */
+					<0 28 RK_FUNC_1 &pcfg_pull_none>,  /* HSYNC */
+					<0 29 RK_FUNC_1 &pcfg_pull_none>;  /* VSYNC */
+			};
+		};
+
+		edp {
+			edp_hpd: edp-hpd {
+				rockchip,pins = <2 23 RK_FUNC_2 &pcfg_pull_none>;
+			};
+		};
+
+		hdmi {
+			hdmi_cec: hdmi-cec {
+				rockchip,pins = <3 23 RK_FUNC_1 &pcfg_pull_none>;
+			};
+
+			hdmi_i2c_xfer: hdmi-i2c-xfer {
+				rockchip,pins = <3 26 RK_FUNC_1 &pcfg_pull_none>,
+						<3 27 RK_FUNC_1 &pcfg_pull_none>;
+			};
+		};
 	};
 };
diff --git a/arch/arm/mach-rockchip/rk3368/Kconfig b/arch/arm/mach-rockchip/rk3368/Kconfig
index a7be30bbd8..1d05a6784f 100644
--- a/arch/arm/mach-rockchip/rk3368/Kconfig
+++ b/arch/arm/mach-rockchip/rk3368/Kconfig
@@ -21,6 +21,11 @@ config TARGET_EVB_PX5
          HDMI video input/output interface, audio codec ES8396,
          WIFI/BT (on RTL8723BS), Gsensor BMA250E and light&proximity
          sensor STK3410.
+
+config TARGET_YMD8_MB
+	select BOARD_EARLY_INIT_R
+	bool "YMD8_MB board"
+
 endchoice
 
 config ROCKCHIP_BOOT_MODE_REG
@@ -44,6 +49,7 @@ config SPL_LIBGENERIC_SUPPORT
 source "board/rockchip/sheep_rk3368/Kconfig"
 source "board/geekbuying/geekbox/Kconfig"
 source "board/rockchip/evb_px5/Kconfig"
+source "board/rockchip/ymd8_mb/Kconfig"
 
 config SPL_STACK_R_ADDR
 	default 0x04000000
diff --git a/board/rockchip/ymd8_mb/Kconfig b/board/rockchip/ymd8_mb/Kconfig
new file mode 100644
index 0000000000..346c6f4bea
--- /dev/null
+++ b/board/rockchip/ymd8_mb/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_YMD8_MB
+
+config SYS_BOARD
+	default "ymd8_mb"
+
+config SYS_VENDOR
+	default "rockchip"
+
+config SYS_CONFIG_NAME
+	default "ymd8_mb"
+
+endif
diff --git a/board/rockchip/ymd8_mb/MAINTAINERS b/board/rockchip/ymd8_mb/MAINTAINERS
new file mode 100644
index 0000000000..a5156b8be3
--- /dev/null
+++ b/board/rockchip/ymd8_mb/MAINTAINERS
@@ -0,0 +1,6 @@
+RK3368 YMD8_MB Board
+M:	Weihao Li <cn.liweihao@gmail.com>
+S:	Maintained
+F:	board/rockchip/ymd8_mb_rk3368/
+F:	include/configs/ymd8_mb.h
+F:	configs/ymd8-mb_defconfig
diff --git a/board/rockchip/ymd8_mb/Makefile b/board/rockchip/ymd8_mb/Makefile
new file mode 100644
index 0000000000..a3a34edb43
--- /dev/null
+++ b/board/rockchip/ymd8_mb/Makefile
@@ -0,0 +1,7 @@
+#
+# (C) Copyright 2016 Rockchip Electronics Co., Ltd
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y	+= ymd8_mb_rk3368.o
diff --git a/board/rockchip/ymd8_mb/README b/board/rockchip/ymd8_mb/README
new file mode 100644
index 0000000000..de980f2f23
--- /dev/null
+++ b/board/rockchip/ymd8_mb/README
@@ -0,0 +1 @@
+see board/rockchip/sheep_rk3368/README
diff --git a/board/rockchip/ymd8_mb/ymd8_mb_rk3368.c b/board/rockchip/ymd8_mb/ymd8_mb_rk3368.c
new file mode 100644
index 0000000000..96d4e04e95
--- /dev/null
+++ b/board/rockchip/ymd8_mb/ymd8_mb_rk3368.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Authors: Weihao Li <cn.liweihao@gmail.com>
+ */
+
+#include <init.h>
+#include <syscon.h>
+#include <asm/global_data.h>
+#include <asm/arch-rockchip/hardware.h>
+#include <asm/arch-rockchip/clock.h>
+#include <asm/arch-rockchip/grf_rk3368.h>
+#include <asm/arch-rockchip/cru_rk3368.h>
+
+int board_early_init_r(void)
+{
+	struct rk3368_cru *cru = rockchip_get_cru();
+	rk_clrsetreg(&cru->clksel_con[43], GMAC_PLL_MASK, GMAC_PLL_SELECT_CODEC);
+	return 0;
+}
diff --git a/configs/ymd8-mb_defconfig b/configs/ymd8-mb_defconfig
new file mode 100644
index 0000000000..f9a2b371ec
--- /dev/null
+++ b/configs/ymd8-mb_defconfig
@@ -0,0 +1,72 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=24000000
+CONFIG_ARCH_ROCKCHIP=y
+CONFIG_TEXT_BASE=0x00200000
+CONFIG_SYS_MALLOC_F_LEN=0x1000
+CONFIG_NR_DRAM_BANKS=1
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
+CONFIG_ENV_SIZE=0x1f000
+CONFIG_DEFAULT_DEVICE_TREE="rk3368-ymd8-mb"
+CONFIG_DM_RESET=y
+CONFIG_ROCKCHIP_RK3368=y
+CONFIG_TARGET_YMD8_MB=y
+CONFIG_SYS_LOAD_ADDR=0x800800
+CONFIG_DEBUG_UART_BASE=0xFF690000
+CONFIG_DEBUG_UART_CLOCK=24000000
+CONFIG_DEBUG_UART=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_DEFAULT_FDT_FILE="rockchip/rk3368-ymd8-mb.dtb"
+# CONFIG_CONSOLE_MUX is not set
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_DISPLAY_BOARDINFO_LATE=y
+# CONFIG_CYCLIC is not set
+CONFIG_LAST_STAGE_INIT=y
+CONFIG_CMD_PWM=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_BMP=y
+# CONFIG_CMD_CLS is not set
+CONFIG_CMD_REGULATOR=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_CLK=y
+CONFIG_ROCKCHIP_GPIO=y
+CONFIG_SYS_I2C_ROCKCHIP=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_ROCKCHIP=y
+CONFIG_PHY_TI_GENERIC=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_ETH_DESIGNWARE=y
+CONFIG_RMII=y
+CONFIG_GMAC_ROCKCHIP=y
+CONFIG_PHY_ROCKCHIP_INNO_DSIDPHY=y
+CONFIG_PINCTRL=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RK8XX=y
+CONFIG_REGULATOR_PWM=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_REGULATOR_RK8XX=y
+CONFIG_PWM_ROCKCHIP=y
+CONFIG_RAM=y
+CONFIG_DEBUG_UART_SHIFT=2
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SYSRESET=y
+CONFIG_VIDEO=y
+# CONFIG_VIDEO_DAMAGE is not set
+CONFIG_BACKLIGHT_GPIO=y
+# CONFIG_SIMPLE_PANEL is not set
+CONFIG_VIDEO_LCD_RM72014=y
+CONFIG_DISPLAY=y
+CONFIG_VIDEO_ROCKCHIP=y
+CONFIG_VIDEO_ROCKCHIP_MAX_XRES=1280
+CONFIG_VIDEO_ROCKCHIP_MAX_YRES=1920
+CONFIG_DISPLAY_ROCKCHIP_MIPI=y
+CONFIG_DISPLAY_ROCKCHIP_DW_MIPI=y
+CONFIG_VIDEO_BRIDGE=y
+# CONFIG_FAT_WRITE is not set
+CONFIG_ERRNO_STR=y
diff --git a/include/configs/ymd8_mb.h b/include/configs/ymd8_mb.h
new file mode 100644
index 0000000000..ff0ceb4e5f
--- /dev/null
+++ b/include/configs/ymd8_mb.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2017 Rockchip Electronics Co., Ltd
+ */
+
+#ifndef __CONFIGS_YMD8_MB_H
+#define __CONFIGS_YMD8_MB_H
+
+#include <configs/rk3368_common.h>
+
+#endif
-- 
2.39.5

