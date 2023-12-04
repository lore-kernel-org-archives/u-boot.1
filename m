Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F91C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 10:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 439D2878D6;
	Mon,  4 Dec 2023 11:49:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bQ/B3bho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81114878D6; Mon,  4 Dec 2023 11:49:07 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D9E87929
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 11:49:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jmasson@baylibre.com
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3332ad5b3e3so2900729f8f.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 02:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701686939; x=1702291739;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:references:date
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xQfhGMdN62/ntuSpFkSM4cUiTbgum9b9gx/FLaF7bLc=;
 b=bQ/B3bhoTUgyKeD9ybfGoXsqUytARmRk/moep6GkTM6FAmylcg0cJ9AF2y7SasqQMW
 jzEq/6dK8iYRwVQo1cPlqY6zdD1q0teV8U4wAaJnyOMoJUfrFuW1eMEiuZ28PaIK+Dz1
 uZzDgHXBTifQa8iTJgc/heVlOuJtKw99pGp1qv7TwkM8itG0f/rfITIatYzIIml1V2gd
 uiWGZx9wk1V9NZpTqksX+zai2y0Jf1HrZugcxs+HIyBr4JaV1pzbibm5Bhq4lshexKMz
 uFSMfLSpzzUHJsr6w3LOxEzgx18g1UO8Km4FSOcPkV0tGuK+ACTiaI+77rWauL0h1dgJ
 Pbaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701686939; x=1702291739;
 h=content-transfer-encoding:mime-version:message-id:references:date
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQfhGMdN62/ntuSpFkSM4cUiTbgum9b9gx/FLaF7bLc=;
 b=B1YOppruSRxt87/VS7oJqPLSvdl6+fvHmJ7xRZ7kA1LZUypcs0pgSFks9Mh+gfNG1S
 RbRzTPHJjYirg2rApsgNWZqQx4BaoctP7jgVCNo7aGT3CT0PtMYH62BcvDokA8+RyQtM
 CIf/orTJsNMrSq/kX7VBkcLwhQZtlUyM3PDN1pO1njYIeio1UI9xkiH65zU8ru2raqqa
 t4x1goZCkqWWZyKT9iWAeMom9+JcDERTqMj49fgP1ZKOuRXpaaLVaM4UqCf31xor02af
 ZkY2XTf7hCO0ntiVebL22EPAVW4tU87vLicoTgkKPnKUQxqADo0/K823zrV4h16UDNqZ
 KVbQ==
X-Gm-Message-State: AOJu0Yyxde3ig0WEy3g6Q5F002ifhrdlmp7Eb/Q3ssPPXSSvcefvocNJ
 o5c5YaE/Y9I6e5Z/+WQbqKhd/6wOQ9ahfqYr8sUxDQ==
X-Google-Smtp-Source: AGHT+IGF8Le+YTWZmQcrxaB29l0OtOWAeOYrt3/hGhouSPPUt9ghv8MTihRjUYhY2zSM5mW5qjlNrg==
X-Received: by 2002:adf:dd90:0:b0:333:2fd2:51e5 with SMTP id
 x16-20020adfdd90000000b003332fd251e5mr2976205wrl.94.1701686939549; 
 Mon, 04 Dec 2023 02:48:59 -0800 (PST)
Received: from localhost ([2a04:cec2:b:6009:c298:6724:4971:1296])
 by smtp.gmail.com with ESMTPSA id
 dm11-20020a0560000bcb00b0033334625bdbsm7823063wrb.13.2023.12.04.02.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 02:48:59 -0800 (PST)
From: Julien Masson <jmasson@baylibre.com>
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Chunfeng
 Yun <chunfeng.yun@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Sean Anderson <seanga2@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Vitor Sato Eschholz
 <vsatoes@baylibre.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 6/6] board: mediatek: add MT8365 EVK board support
In-Reply-To: <87plzm450u.fsf@baylibre.com>
Date: Mon,  4 Dec 2023 11:48:58 +0100
References: <87plzm450u.fsf@baylibre.com>
Message-ID: <87h6ky450l.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

This adds support for the MT8365 EVK board with the following
features enabled/tested: Boot, UART, Watchdog and MMC.

Signed-off-by: Julien Masson <jmasson@baylibre.com>
---
 arch/arm/dts/mt6357.dtsi               | 282 +++++++++++++++++
 arch/arm/dts/mt8365-evk.dts            | 418 +++++++++++++++++++++++++
 board/mediatek/mt8365_evk/MAINTAINERS  |   6 +
 board/mediatek/mt8365_evk/Makefile     |   3 +
 board/mediatek/mt8365_evk/mt8365_evk.c |  33 ++
 configs/mt8365_evk_defconfig           |  19 ++
 6 files changed, 761 insertions(+)
 create mode 100644 arch/arm/dts/mt6357.dtsi
 create mode 100644 arch/arm/dts/mt8365-evk.dts
 create mode 100644 board/mediatek/mt8365_evk/MAINTAINERS
 create mode 100644 board/mediatek/mt8365_evk/Makefile
 create mode 100644 board/mediatek/mt8365_evk/mt8365_evk.c
 create mode 100644 configs/mt8365_evk_defconfig

diff --git a/arch/arm/dts/mt6357.dtsi b/arch/arm/dts/mt6357.dtsi
new file mode 100644
index 0000000000..3330a03c2f
--- /dev/null
+++ b/arch/arm/dts/mt6357.dtsi
@@ -0,0 +1,282 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Copyright (c) 2023 BayLibre Inc.
+ */
+
+#include <dt-bindings/input/input.h>
+
+&pwrap {
+	mt6357_pmic: pmic {
+		compatible =3D "mediatek,mt6357";
+
+		regulators {
+			mt6357_vproc_reg: buck-vproc {
+				regulator-name =3D "vproc";
+				regulator-min-microvolt =3D <518750>;
+				regulator-max-microvolt =3D <1312500>;
+				regulator-ramp-delay =3D <6250>;
+				regulator-enable-ramp-delay =3D <220>;
+				regulator-always-on;
+			};
+
+			mt6357_vcore_reg: buck-vcore {
+				regulator-name =3D "vcore";
+				regulator-min-microvolt =3D <518750>;
+				regulator-max-microvolt =3D <1312500>;
+				regulator-ramp-delay =3D <6250>;
+				regulator-enable-ramp-delay =3D <220>;
+				regulator-always-on;
+			};
+
+			mt6357_vmodem_reg: buck-vmodem {
+				regulator-name =3D "vmodem";
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <1193750>;
+				regulator-ramp-delay =3D <6250>;
+				regulator-enable-ramp-delay =3D <220>;
+			};
+
+			mt6357_vs1_reg: buck-vs1 {
+				regulator-name =3D "vs1";
+				regulator-min-microvolt =3D <1200000>;
+				regulator-max-microvolt =3D <2200000>;
+				regulator-ramp-delay =3D <12500>;
+				regulator-enable-ramp-delay =3D <220>;
+				regulator-always-on;
+			};
+
+			mt6357_vpa_reg: buck-vpa {
+				regulator-name =3D "vpa";
+				regulator-min-microvolt =3D <500000>;
+				regulator-max-microvolt =3D <3650000>;
+				regulator-ramp-delay =3D <50000>;
+				regulator-enable-ramp-delay =3D <220>;
+			};
+
+			mt6357_vfe28_reg: ldo-vfe28 {
+				compatible =3D "regulator-fixed";
+				regulator-name =3D "vfe28";
+				regulator-min-microvolt =3D <2800000>;
+				regulator-max-microvolt =3D <2800000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vxo22_reg: ldo-vxo22 {
+				regulator-name =3D "vxo22";
+				regulator-min-microvolt =3D <2200000>;
+				regulator-max-microvolt =3D <2400000>;
+				regulator-enable-ramp-delay =3D <110>;
+			};
+
+			mt6357_vrf18_reg: ldo-vrf18 {
+				compatible =3D "regulator-fixed";
+				regulator-name =3D "vrf18";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-enable-ramp-delay =3D <110>;
+			};
+
+			mt6357_vrf12_reg: ldo-vrf12 {
+				compatible =3D "regulator-fixed";
+				regulator-name =3D "vrf12";
+				regulator-min-microvolt =3D <1200000>;
+				regulator-max-microvolt =3D <1200000>;
+				regulator-enable-ramp-delay =3D <110>;
+			};
+
+			mt6357_vefuse_reg: ldo-vefuse {
+				regulator-name =3D "vefuse";
+				regulator-min-microvolt =3D <1200000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vcn33_bt_reg: ldo-vcn33-bt {
+				regulator-name =3D "vcn33-bt";
+				regulator-min-microvolt =3D <3300000>;
+				regulator-max-microvolt =3D <3500000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vcn33_wifi_reg: ldo-vcn33-wifi {
+				regulator-name =3D "vcn33-wifi";
+				regulator-min-microvolt =3D <3300000>;
+				regulator-max-microvolt =3D <3500000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vcn28_reg: ldo-vcn28 {
+				compatible =3D "regulator-fixed";
+				regulator-name =3D "vcn28";
+				regulator-min-microvolt =3D <2800000>;
+				regulator-max-microvolt =3D <2800000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vcn18_reg: ldo-vcn18 {
+				compatible =3D "regulator-fixed";
+				regulator-name =3D "vcn18";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vcama_reg: ldo-vcama {
+				regulator-name =3D "vcama";
+				regulator-min-microvolt =3D <2500000>;
+				regulator-max-microvolt =3D <2800000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vcamd_reg: ldo-vcamd {
+				regulator-name =3D "vcamd";
+				regulator-min-microvolt =3D <1000000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vcamio_reg: ldo-vcamio18 {
+				compatible =3D "regulator-fixed";
+				regulator-name =3D "vcamio";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vldo28_reg: ldo-vldo28 {
+				regulator-name =3D "vldo28";
+				regulator-min-microvolt =3D <2800000>;
+				regulator-max-microvolt =3D <3000000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vsram_others_reg: ldo-vsram-others {
+				regulator-name =3D "vsram-others";
+				regulator-min-microvolt =3D <518750>;
+				regulator-max-microvolt =3D <1312500>;
+				regulator-ramp-delay =3D <6250>;
+				regulator-enable-ramp-delay =3D <110>;
+				regulator-always-on;
+			};
+
+			mt6357_vsram_proc_reg: ldo-vsram-proc {
+				regulator-name =3D "vsram-proc";
+				regulator-min-microvolt =3D <518750>;
+				regulator-max-microvolt =3D <1312500>;
+				regulator-ramp-delay =3D <6250>;
+				regulator-enable-ramp-delay =3D <110>;
+				regulator-always-on;
+			};
+
+			mt6357_vaux18_reg: ldo-vaux18 {
+				compatible =3D "regulator-fixed";
+				regulator-name =3D "vaux18";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vaud28_reg: ldo-vaud28 {
+				compatible =3D "regulator-fixed";
+				regulator-name =3D "vaud28";
+				regulator-min-microvolt =3D <2800000>;
+				regulator-max-microvolt =3D <2800000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vio28_reg: ldo-vio28 {
+				compatible =3D "regulator-fixed";
+				regulator-name =3D "vio28";
+				regulator-min-microvolt =3D <2800000>;
+				regulator-max-microvolt =3D <2800000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vio18_reg: ldo-vio18 {
+				compatible =3D "regulator-fixed";
+				regulator-name =3D "vio18";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <1800000>;
+				regulator-enable-ramp-delay =3D <264>;
+				regulator-always-on;
+			};
+
+			mt6357_vdram_reg: ldo-vdram {
+				regulator-name =3D "vdram";
+				regulator-min-microvolt =3D <1100000>;
+				regulator-max-microvolt =3D <1200000>;
+				regulator-enable-ramp-delay =3D <3300>;
+			};
+
+			mt6357_vmc_reg: ldo-vmc {
+				regulator-name =3D "vmc";
+				regulator-min-microvolt =3D <1800000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-enable-ramp-delay =3D <44>;
+			};
+
+			mt6357_vmch_reg: ldo-vmch {
+				regulator-name =3D "vmch";
+				regulator-min-microvolt =3D <2900000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-enable-ramp-delay =3D <44>;
+			};
+
+			mt6357_vemc_reg: ldo-vemc {
+				regulator-name =3D "vemc";
+				regulator-min-microvolt =3D <2900000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-enable-ramp-delay =3D <44>;
+				regulator-always-on;
+			};
+
+			mt6357_vsim1_reg: ldo-vsim1 {
+				regulator-name =3D "vsim1";
+				regulator-min-microvolt =3D <1700000>;
+				regulator-max-microvolt =3D <3100000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vsim2_reg: ldo-vsim2 {
+				regulator-name =3D "vsim2";
+				regulator-min-microvolt =3D <1700000>;
+				regulator-max-microvolt =3D <3100000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+
+			mt6357_vibr_reg: ldo-vibr {
+				regulator-name =3D "vibr";
+				regulator-min-microvolt =3D <1200000>;
+				regulator-max-microvolt =3D <3300000>;
+				regulator-enable-ramp-delay =3D <44>;
+			};
+
+			mt6357_vusb33_reg: ldo-vusb33 {
+				regulator-name =3D "vusb33";
+				regulator-min-microvolt =3D <3000000>;
+				regulator-max-microvolt =3D <3100000>;
+				regulator-enable-ramp-delay =3D <264>;
+			};
+		};
+
+		rtc {
+			compatible =3D "mediatek,mt6357-rtc";
+		};
+
+		keys {
+			compatible =3D "mediatek,mt6357-keys";
+
+			key-power {
+				linux,keycodes =3D <KEY_POWER>;
+				wakeup-source;
+			};
+
+			key-home {
+				linux,keycodes =3D <KEY_HOME>;
+				wakeup-source;
+			};
+
+		};
+	};
+};
diff --git a/arch/arm/dts/mt8365-evk.dts b/arch/arm/dts/mt8365-evk.dts
new file mode 100644
index 0000000000..50cbaefa1a
--- /dev/null
+++ b/arch/arm/dts/mt8365-evk.dts
@@ -0,0 +1,418 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021-2022 BayLibre, SAS.
+ * Authors:
+ * Fabien Parent <fparent@baylibre.com>
+ * Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/mt8365-pinfunc.h>
+#include "mt8365.dtsi"
+#include "mt6357.dtsi"
+
+/ {
+	model =3D "MediaTek MT8365 Open Platform EVK";
+	compatible =3D "mediatek,mt8365-evk", "mediatek,mt8365";
+
+	aliases {
+		serial0 =3D &uart0;
+	};
+
+	chosen {
+		stdout-path =3D "serial0:921600n8";
+	};
+
+	firmware {
+		optee {
+			compatible =3D "linaro,optee-tz";
+			method =3D "smc";
+		};
+	};
+
+	gpio-keys {
+		compatible =3D "gpio-keys";
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&gpio_keys>;
+
+		key-volume-up {
+			gpios =3D <&pio 24 GPIO_ACTIVE_LOW>;
+			label =3D "volume_up";
+			linux,code =3D <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval =3D <15>;
+		};
+	};
+
+	memory@40000000 {
+		device_type =3D "memory";
+		reg =3D <0 0x40000000 0 0xc0000000>;
+	};
+
+	usb_otg_vbus: regulator-0 {
+		compatible =3D "regulator-fixed";
+		regulator-name =3D "otg_vbus";
+		regulator-min-microvolt =3D <5000000>;
+		regulator-max-microvolt =3D <5000000>;
+		gpio =3D <&pio 16 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	reserved-memory {
+		#address-cells =3D <2>;
+		#size-cells =3D <2>;
+		ranges;
+
+		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_reserved: secmon@43000000 {
+			no-map;
+			reg =3D <0 0x43000000 0 0x30000>;
+		};
+
+		/* 12 MiB reserved for OP-TEE (BL32)
+		 * +-----------------------+ 0x43e0_0000
+		 * |      SHMEM 2MiB       |
+		 * +-----------------------+ 0x43c0_0000
+		 * |        | TA_RAM  8MiB |
+		 * + TZDRAM +--------------+ 0x4340_0000
+		 * |        | TEE_RAM 2MiB |
+		 * +-----------------------+ 0x4320_0000
+		 */
+		optee_reserved: optee@43200000 {
+			no-map;
+			reg =3D <0 0x43200000 0 0x00c00000>;
+		};
+	};
+};
+
+&cpu0 {
+	proc-supply =3D <&mt6357_vproc_reg>;
+	sram-supply =3D <&mt6357_vsram_proc_reg>;
+};
+
+&cpu1 {
+	proc-supply =3D <&mt6357_vproc_reg>;
+	sram-supply =3D <&mt6357_vsram_proc_reg>;
+};
+
+&cpu2 {
+	proc-supply =3D <&mt6357_vproc_reg>;
+	sram-supply =3D <&mt6357_vsram_proc_reg>;
+};
+
+&cpu3 {
+	proc-supply =3D <&mt6357_vproc_reg>;
+	sram-supply =3D <&mt6357_vsram_proc_reg>;
+};
+
+&ethernet {
+	pinctrl-0 =3D <&ethernet_pins>;
+	pinctrl-names =3D "default";
+	phy-handle =3D <&eth_phy>;
+	phy-mode =3D "rmii";
+	/*
+	 * Ethernet and HDMI (DSI0) are sharing pins.
+	 * Only one can be enabled at a time and require the physical switch
+	 * SW2101 to be set on LAN position
+	 * mt6357_vibr_reg and mt6357_vsim2_reg are needed to supply ethernet
+	 */
+	status =3D "disabled";
+
+	mdio {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		eth_phy: ethernet-phy@0 {
+			reg =3D <0>;
+		};
+	};
+};
+
+&i2c0 {
+	clock-frequency =3D <100000>;
+	pinctrl-0 =3D <&i2c0_pins>;
+	pinctrl-names =3D "default";
+	status =3D "okay";
+};
+
+&mmc0 {
+	assigned-clock-parents =3D <&topckgen CLK_TOP_MSDCPLL>;
+	assigned-clocks =3D <&topckgen CLK_TOP_MSDC50_0_SEL>;
+	bus-width =3D <8>;
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	hs400-ds-delay =3D <0x12012>;
+	max-frequency =3D <200000000>;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	no-sd;
+	no-sdio;
+	non-removable;
+	pinctrl-0 =3D <&mmc0_default_pins>;
+	pinctrl-1 =3D <&mmc0_uhs_pins>;
+	pinctrl-names =3D "default", "state_uhs";
+	vmmc-supply =3D <&mt6357_vemc_reg>;
+	vqmmc-supply =3D <&mt6357_vio18_reg>;
+	status =3D "okay";
+};
+
+&mmc1 {
+	bus-width =3D <4>;
+	cap-sd-highspeed;
+	cd-gpios =3D <&pio 76 GPIO_ACTIVE_LOW>;
+	max-frequency =3D <200000000>;
+	pinctrl-0 =3D <&mmc1_default_pins>;
+	pinctrl-1 =3D <&mmc1_uhs_pins>;
+	pinctrl-names =3D "default", "state_uhs";
+	sd-uhs-sdr104;
+	sd-uhs-sdr50;
+	vmmc-supply =3D <&mt6357_vmch_reg>;
+	vqmmc-supply =3D <&mt6357_vmc_reg>;
+	status =3D "okay";
+};
+
+&mt6357_pmic {
+	interrupts-extended =3D <&pio 145 IRQ_TYPE_LEVEL_HIGH>;
+	interrupt-controller;
+	#interrupt-cells =3D <2>;
+};
+
+&pio {
+	ethernet_pins: ethernet-pins {
+		phy_reset_pins {
+			pinmux =3D <MT8365_PIN_133_TDM_TX_DATA1__FUNC_GPIO133>;
+		};
+
+		rmii_pins {
+			pinmux =3D <MT8365_PIN_0_GPIO0__FUNC_EXT_TXD0>,
+				 <MT8365_PIN_1_GPIO1__FUNC_EXT_TXD1>,
+				 <MT8365_PIN_2_GPIO2__FUNC_EXT_TXD2>,
+				 <MT8365_PIN_3_GPIO3__FUNC_EXT_TXD3>,
+				 <MT8365_PIN_4_GPIO4__FUNC_EXT_TXC>,
+				 <MT8365_PIN_5_GPIO5__FUNC_EXT_RXER>,
+				 <MT8365_PIN_6_GPIO6__FUNC_EXT_RXC>,
+				 <MT8365_PIN_7_GPIO7__FUNC_EXT_RXDV>,
+				 <MT8365_PIN_8_GPIO8__FUNC_EXT_RXD0>,
+				 <MT8365_PIN_9_GPIO9__FUNC_EXT_RXD1>,
+				 <MT8365_PIN_10_GPIO10__FUNC_EXT_RXD2>,
+				 <MT8365_PIN_11_GPIO11__FUNC_EXT_RXD3>,
+				 <MT8365_PIN_12_GPIO12__FUNC_EXT_TXEN>,
+				 <MT8365_PIN_13_GPIO13__FUNC_EXT_COL>,
+				 <MT8365_PIN_14_GPIO14__FUNC_EXT_MDIO>,
+				 <MT8365_PIN_15_GPIO15__FUNC_EXT_MDC>;
+		};
+	};
+
+	gpio_keys: gpio-keys-pins {
+		pins {
+			pinmux =3D <MT8365_PIN_24_KPCOL0__FUNC_KPCOL0>;
+			bias-pull-up;
+			input-enable;
+		};
+	};
+
+	i2c0_pins: i2c0-pins {
+		pins {
+			pinmux =3D <MT8365_PIN_57_SDA0__FUNC_SDA0_0>,
+				 <MT8365_PIN_58_SCL0__FUNC_SCL0_0>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_default_pins: mmc0-default-pins {
+		clk-pins {
+			pinmux =3D <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			bias-pull-down;
+		};
+
+		cmd-dat-pins {
+			pinmux =3D <MT8365_PIN_103_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				 <MT8365_PIN_102_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				 <MT8365_PIN_101_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				 <MT8365_PIN_100_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				 <MT8365_PIN_96_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				 <MT8365_PIN_95_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				 <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				 <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				 <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		rst-pins {
+			pinmux =3D <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_uhs_pins: mmc0-uhs-pins {
+		clk-pins {
+			pinmux =3D <MT8365_PIN_99_MSDC0_CLK__FUNC_MSDC0_CLK>;
+			drive-strength =3D <MTK_DRIVE_10mA>;
+			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		cmd-dat-pins {
+			pinmux =3D <MT8365_PIN_103_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
+				 <MT8365_PIN_102_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
+				 <MT8365_PIN_101_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
+				 <MT8365_PIN_100_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
+				 <MT8365_PIN_96_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
+				 <MT8365_PIN_95_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
+				 <MT8365_PIN_94_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
+				 <MT8365_PIN_93_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
+				 <MT8365_PIN_98_MSDC0_CMD__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength =3D <MTK_DRIVE_10mA>;
+			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		ds-pins {
+			pinmux =3D <MT8365_PIN_104_MSDC0_DSL__FUNC_MSDC0_DSL>;
+			drive-strength =3D <MTK_DRIVE_10mA>;
+			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		rst-pins {
+			pinmux =3D <MT8365_PIN_97_MSDC0_RSTB__FUNC_MSDC0_RSTB>;
+			drive-strength =3D <MTK_DRIVE_10mA>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_default_pins: mmc1-default-pins {
+		cd-pins {
+			pinmux =3D <MT8365_PIN_76_CMDAT8__FUNC_GPIO76>;
+			bias-pull-up;
+		};
+
+		clk-pins {
+			pinmux =3D <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		cmd-dat-pins {
+			pinmux =3D <MT8365_PIN_89_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+				 <MT8365_PIN_90_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+				 <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
+				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
+			input-enable;
+			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_uhs_pins: mmc1-uhs-pins {
+		clk-pins {
+			pinmux =3D <MT8365_PIN_88_MSDC1_CLK__FUNC_MSDC1_CLK>;
+			drive-strength =3D <MTK_DRIVE_8mA>;
+			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		cmd-dat-pins {
+			pinmux =3D <MT8365_PIN_89_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
+				 <MT8365_PIN_90_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
+				 <MT8365_PIN_91_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
+				 <MT8365_PIN_92_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
+				 <MT8365_PIN_87_MSDC1_CMD__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength =3D <MTK_DRIVE_6mA>;
+			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins {
+			pinmux =3D <MT8365_PIN_35_URXD0__FUNC_URXD0>,
+				 <MT8365_PIN_36_UTXD0__FUNC_UTXD0>;
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		pins {
+			pinmux =3D <MT8365_PIN_37_URXD1__FUNC_URXD1>,
+				 <MT8365_PIN_38_UTXD1__FUNC_UTXD1>;
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		pins {
+			pinmux =3D <MT8365_PIN_39_URXD2__FUNC_URXD2>,
+				 <MT8365_PIN_40_UTXD2__FUNC_UTXD2>;
+		};
+	};
+
+	usb_pins: usb-pins {
+		id-pins {
+			pinmux =3D <MT8365_PIN_17_GPIO17__FUNC_GPIO17>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		usb0-vbus-pins {
+			pinmux =3D <MT8365_PIN_16_GPIO16__FUNC_USB_DRVVBUS>;
+			output-high;
+		};
+
+		usb1-vbus-pins {
+			pinmux =3D <MT8365_PIN_18_GPIO18__FUNC_GPIO18>;
+			output-high;
+		};
+	};
+
+	pwm_pins: pwm-pins {
+		pins {
+			pinmux =3D <MT8365_PIN_19_DISP_PWM__FUNC_PWM_A>,
+				 <MT8365_PIN_116_I2S_BCK__FUNC_PWM_C>;
+		};
+	};
+};
+
+&pwm {
+	pinctrl-0 =3D <&pwm_pins>;
+	pinctrl-names =3D "default";
+	status =3D "okay";
+};
+
+&ssusb {
+	dr_mode =3D "otg";
+	maximum-speed =3D "high-speed";
+	pinctrl-0 =3D <&usb_pins>;
+	pinctrl-names =3D "default";
+	usb-role-switch;
+	vusb33-supply =3D <&mt6357_vusb33_reg>;
+	status =3D "okay";
+
+	connector {
+		compatible =3D "gpio-usb-b-connector", "usb-b-connector";
+		id-gpios =3D <&pio 17 GPIO_ACTIVE_HIGH>;
+		type =3D "micro";
+		vbus-supply =3D <&usb_otg_vbus>;
+	};
+};
+
+&usb_host {
+	vusb33-supply =3D <&mt6357_vusb33_reg>;
+	status =3D "okay";
+};
+
+&uart0 {
+	pinctrl-0 =3D <&uart0_pins>;
+	pinctrl-names =3D "default";
+	status =3D "okay";
+};
+
+&uart1 {
+	pinctrl-0 =3D <&uart1_pins>;
+	pinctrl-names =3D "default";
+	status =3D "okay";
+};
+
+&uart2 {
+	pinctrl-0 =3D <&uart2_pins>;
+	pinctrl-names =3D "default";
+	status =3D "okay";
+};
diff --git a/board/mediatek/mt8365_evk/MAINTAINERS b/board/mediatek/mt8365_=
evk/MAINTAINERS
new file mode 100644
index 0000000000..bb28ae8df7
--- /dev/null
+++ b/board/mediatek/mt8365_evk/MAINTAINERS
@@ -0,0 +1,6 @@
+MT8365 EVK
+M:	Julien Masson <jmasson@baylibre.com>
+S:	Maintained
+F:	arch/arm/dts/mt8365-evk.dts
+F:	board/mediatek/mt8365_evk/
+F:	configs/mt8365_evk_defconfig
diff --git a/board/mediatek/mt8365_evk/Makefile b/board/mediatek/mt8365_evk=
/Makefile
new file mode 100644
index 0000000000..90fc92b28c
--- /dev/null
+++ b/board/mediatek/mt8365_evk/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier:	GPL-2.0
+
+obj-y +=3D mt8365_evk.o
diff --git a/board/mediatek/mt8365_evk/mt8365_evk.c b/board/mediatek/mt8365=
_evk/mt8365_evk.c
new file mode 100644
index 0000000000..723a50fec0
--- /dev/null
+++ b/board/mediatek/mt8365_evk/mt8365_evk.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 BayLibre SAS
+ * Author: Julien Masson <jmasson@baylibre.com>
+ */
+
+#include <asm/armv8/mmu.h>
+
+int board_init(void)
+{
+	return 0;
+}
+
+static struct mm_region mt8365_evk_mem_map[] =3D {
+	{
+		/* DDR */
+		.virt =3D 0x40000000UL,
+		.phys =3D 0x40000000UL,
+		.size =3D 0xc0000000UL,
+		.attrs =3D PTE_BLOCK_MEMTYPE(MT_NORMAL) | PTE_BLOCK_OUTER_SHARE,
+	}, {
+		.virt =3D 0x00000000UL,
+		.phys =3D 0x00000000UL,
+		.size =3D 0x20000000UL,
+		.attrs =3D PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	}, {
+		0,
+	}
+};
+
+struct mm_region *mem_map =3D mt8365_evk_mem_map;
diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
new file mode 100644
index 0000000000..94b1f025fc
--- /dev/null
+++ b/configs/mt8365_evk_defconfig
@@ -0,0 +1,19 @@
+CONFIG_ARM=3Dy
+CONFIG_SYS_BOARD=3D"mt8365_evk"
+CONFIG_COUNTER_FREQUENCY=3D13000000
+CONFIG_POSITION_INDEPENDENT=3Dy
+CONFIG_ARCH_MEDIATEK=3Dy
+CONFIG_TEXT_BASE=3D0x4c000000
+CONFIG_NR_DRAM_BANKS=3D1
+CONFIG_DEFAULT_DEVICE_TREE=3D"mt8365-evk"
+CONFIG_TARGET_MT8365=3Dy
+CONFIG_IDENT_STRING=3D" mt8365-evk"
+CONFIG_SYS_LOAD_ADDR=3D0x4c000000
+CONFIG_DEFAULT_FDT_FILE=3D"mt8365-evk"
+CONFIG_CLK=3Dy
+CONFIG_MMC_MTK=3Dy
+CONFIG_BAUDRATE=3D921600
+CONFIG_DM_SERIAL=3Dy
+CONFIG_MTK_SERIAL=3Dy
+CONFIG_WDT=3Dy
+CONFIG_WDT_MTK=3Dy
--=20
2.43.0

