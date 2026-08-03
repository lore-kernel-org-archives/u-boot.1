Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A14FC55182
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 23:21:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6ADF080B96;
	Mon,  3 Aug 2026 23:21:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OAsqkz8ehbQr; Mon,  3 Aug 2026 23:21:42 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A69B80C0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785799302;
	bh=7Wd5NCySKoobTikmzGg/etnVFiNUKnpfE/mWhJ9AWzI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ikbViLK4dpENf9pTg75sU03UC+4eDhhd5455NcziaBD0sIKW2yRHCsuD4YXgxOM06
	 hSrIVkAQBh27Ibc62tKJo1fSWceK12r+jjjTwshMw/F/ZoYXR4b/DGBTJsNjX2l/MV
	 IduGJBXYD9vaEchNvio9hdl37W88rSJ7AwI/UmVQma+wtMn8/YrXeSuXwJmWNFvhLa
	 7N6UaC4xnpA066DU5tk6zy9eKNnAiVzb51Af6K9PwbifIseBq4y20HRxXh3K/rdj6t
	 tmsLnGi0xgX7V9GwFVof4F4x+vX+qt55Doc7ItlSzFSVGy4wirc2mdAlK7C3FWhWOp
	 8qqtFO1tGVIXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A69B80C0C;
	Mon,  3 Aug 2026 23:21:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BC5322CE
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2428400DA
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GDgz68aNzE2P for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 23:21:38 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22a; helo=mail-oi1-x22a.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A9F8C400B4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A9F8C400B4
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A9F8C400B4
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 23:21:38 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-4a475409044so1230799b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 03 Aug 2026 16:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785799297; x=1786404097;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Wd5NCySKoobTikmzGg/etnVFiNUKnpfE/mWhJ9AWzI=;
 b=hfwLdvj7dqbecgH15Zt6x7uOkjYhnGrX9mpiNlDZEs5uzk1NJNnBGha/T/YgIEdDGv
 vLCbMbi8zw3hzev3sB80/1Qb8SfuvHRCwPnRxIwmdbIfKXkxX2PE67Ut/peXsd6RwA3T
 Ngz89oQN/c3oSVDcvdrJoWLVhm0aHiDukMog6werb6wtQKJRfzM02zTXHTS7wA9NOZaY
 6yL3cUNMTITzEeLVopDx3bUQYf/IIj4EKvRUNxI+SypdrZq8A6xL91g9Nx2aFm83GBYS
 SLjt8O89taz7gq3T+xP2Sdou0Lk8E2nh4kRrYME2aX8KmmCVkN+WjvYadD5QV3RWLqmy
 TMZg==
X-Gm-Message-State: AOJu0Yx3tU8z7j1EN/rH6BaWodW2NEgfKr6kB+2Esv0DcUT+nmREIkCr
 PGLQu4iHKzasyfySJY+IwBQqet1WtvlS4rk739K/tJuDGfxwgBiCWGnRIwFjiAThSNA=
X-Gm-Gg: AR+sD103+OLF/4O/gloEt8540U+A0eu3TR9ho0fZWnPOjKoW/bK4+f6e7zzdkpq2qXU
 nU39cQG+W8fjI6pMwJeSflzIXS0PeCTsf01Yys+c8u7JJjbCNEFDjcLkEjFeopTfgWGlwDN2WeO
 DQc9rL1FwR+wIwAzWU6OOJBtBEKNNsXs79Du3MDtY4tuMWLLejqU05pgnClX72EiLD592drP0a1
 vI0/yFI6wnE2/fPgnwBejSGRAdENkYHC03TfjO6Rktstwx6oAVNdZLzeF+ySA/tJ6+PuIZNmUy6
 /PYETykFjA2dF/QdyFvTsEuGN960ub60X575PSarFAWnt79peU+jamRb6+9/Hfdz+g0VaLQH5K3
 wJVV2dgo8NsXZZKOXKNaZwJKvWdeqyVznkUHkbu9ibLxxK/NxuXwMZrEmvYJNtTdy5KvMy738s+
 W5JP8FBfWBGeN+FgRDeW/TGPui1oHP3J0G1l+ZTEYToNuZzSSu6K+M2KQ6FSOKnuupFOYGbYtN1
 Q==
X-Received: by 2002:a05:6808:1817:b0:4a4:1dd8:5e35 with SMTP id
 5614622812f47-4af5e081e89mr20017637b6e.8.1785799297559; 
 Mon, 03 Aug 2026 16:21:37 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b8f7:1f5e:7c:a7d1])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-458f60df63fsm9440852fac.6.2026.08.03.16.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 16:21:37 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 03 Aug 2026 18:20:44 -0500
Subject: [PATCH 5/6] arm: dts: mediatek: add Genio 360 EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-mtk-genio-360-bringup-v1-5-606ee60755b5@baylibre.com>
References: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
In-Reply-To: <20260803-mtk-genio-360-bringup-v1-0-606ee60755b5@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10416;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=qX2xBleEr8Q0pi7L/AgDxpQ0NzfZV5LNFe+0WI6TMRI=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqcSJrUQj/FJSOE6aK736HLzXqLC1O36hqOqDX1
 VUrRUqIGeCJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanEiaxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ATHoH+gMJNLZFQQu1yk2JlYGKmk/TzaxYEzdum78400g
 NoJNekv3mf39eWpY+UKBeMoGdxVbRl6wRgyLkMhMS2Ty1pu2JHtLGEfwwGjH2Kw0YO/c0a/cmk1
 F4fQtDKZ4mQChqU9BEntQmxzTkJgFWE0FsSnjs3DCfRWusOPiR2imBzXh8aHgApnvHtU6tz1Srt
 ijm64n5GtVMJ91bQiMsyNcbeL1TZVfDRj0m7aE+8vEhX0iJ5NhqDTgbIlj6NbGQMGF/P4BFVr9W
 lE3PAaVXIFku0fVBVyp2vb+E+FvyvkK8q6VtAu62vjeMmd0miNukqxC7X0p9GK1Z8r7GgFoLF9t
 hYdw=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785799297; x=1786404097;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7Wd5NCySKoobTikmzGg/etnVFiNUKnpfE/mWhJ9AWzI=;
 b=XdcrC7q6o/IwZW6OMfZl0ZndBizAtVxoxGMW5HLquMP7PanaiN1OVlN4WST+Ki2H5O
 45hGzPBS+l4KASy6lEHDK6aJsSVOrfb9Ejo8r4UwArL92srH3mr1ac+lF2sCILUggXOi
 /qF19tP3aiGEKNV0s5jPr5i8/J08gkWU5bf11e1RRp2RXjqCH/ezcqNRqxV0atix+4EP
 UDquC0qvH7FFa66QiFvVzUYOvBPEsn8ludi5OORatr0KheXDgHyvvtD5hQcJBLWqONQi
 VfpQkJbRJljMtKMDGxpB0d034STuOnIIMj6m5zeCajtXrQrjW9kll9a5Z6y3BFgb4XHs
 rgpg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=XdcrC7q6
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Macpaul Lin <macpaul.lin@mediatek.com>

Add a devicetree for the MediaTek Genio 360 Evaluation Kit board.

Upstreaming of this board has not even started yet, so we will have to
carry a downstream version of this for some time.

Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/Makefile                         |   1 +
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi | 405 ++++++++++++++++++++++++++
 arch/arm/dts/mt8366-genio-360-evk.dts         |  14 +
 3 files changed, 420 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index dada5f9eba2..b7d4baedfa0 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1089,6 +1089,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7988-rfb.dtb \
 	mt7988-sd-rfb.dtb \
 	mt8183-pumpkin.dtb \
+	mt8366-genio-360-evk.dtb \
 	mt8371-genio-520-evk.dtb \
 	mt8371-genio-520-evk-ufs.dtb \
 	mt8391-genio-720-evk.dtb \
diff --git a/arch/arm/dts/mt8366-genio-360-evk-common.dtsi b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
new file mode 100644
index 00000000000..13055e4740c
--- /dev/null
+++ b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+#include "mt8366.dtsi"
+
+/ {
+	memory@40000000 {
+		/* 4GB */
+		reg = <0 0x40000000 0x1 0x00000000>;
+	};
+
+	firmware: firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci: psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 2 MiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_reserved: secmon@54600000 {
+			no-map;
+			reg = <0 0x54600000 0x0 0x200000>;
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
+			reg = <0 0x43200000 0 0x00c00000>;
+		};
+
+		dsi_reserved: dsi@60000000 {
+			reg = <0 0x60000000 0 0x02000000>;
+			no-map;
+		};
+	};
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	reg_1p8v: regulator-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-1.8V";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	usb_p0_vbus: regulator-usb-p0 {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_p0_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio 53 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb_p1_vbus: regulator-usb-p1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_p1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&gpio 55 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&spi4 {
+	status = "okay";
+	pinctrl-0 = <&spi4_pins>;
+	pinctrl-names = "default";
+	enhance_timing;
+	dma_ext;
+	ipm_design;
+	tick_dly = <0>;
+	sample_sel = <0>;
+	spi-max-frequency = <10000000>;
+};
+
+&i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+};
+
+&i2c1 {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+};
+
+&i2c2 {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+};
+
+&i2c3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+};
+
+&i2c4 {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4_pins>;
+};
+
+&i2c5 {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c5_pins>;
+};
+
+&i2c6 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c6_pins>;
+};
+
+&i2c7 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c7_pins>;
+};
+
+&i2c8 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c8_pins>;
+};
+
+&i2c9 {
+	status = "disabled";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c9_pins>;
+};
+
+&pio {
+	usb0_default_pins: usb0-default-pins {
+		pins-vbus-valid {
+			pinmux = <PINMUX_GPIO54__FUNC_VBUSVALID>;
+		};
+	};
+
+	spi4_pins: spi4-pins {
+		pins-spi-bus {
+			pinmux = <PINMUX_GPIO32__FUNC_SPIM4_B_CSB>,
+				 <PINMUX_GPIO33__FUNC_SPIM4_B_CLK>,
+				 <PINMUX_GPIO34__FUNC_SPIM4_B_MO>,
+				 <PINMUX_GPIO35__FUNC_SPIM4_B_MI>;
+			drive-strength = <MTK_DRIVE_6mA>;
+		};
+	};
+
+	i2c0_pins: i2c0-default {
+		pins-bus {
+			pinmux = <PINMUX_GPIO98__FUNC_SCL0>,
+				 <PINMUX_GPIO99__FUNC_SDA0>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c1_pins: i2c1-default {
+		pins-bus {
+			pinmux = <PINMUX_GPIO100__FUNC_SCL1>,
+				 <PINMUX_GPIO101__FUNC_SDA1>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c2_pins: i2c2-default {
+		pins-bus {
+			pinmux = <PINMUX_GPIO102__FUNC_SCL2>,
+				 <PINMUX_GPIO103__FUNC_SDA2>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c3_pins: i2c3-default {
+		pins-bus {
+			pinmux = <PINMUX_GPIO104__FUNC_SCL3>,
+				 <PINMUX_GPIO105__FUNC_SDA3>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c4_pins: i2c4-default {
+		pins-bus {
+			pinmux = <PINMUX_GPIO106__FUNC_SCL4>,
+				 <PINMUX_GPIO107__FUNC_SDA4>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c5_pins: i2c5-default {
+		pins-bus {
+			pinmux = <PINMUX_GPIO108__FUNC_SCL5>,
+				 <PINMUX_GPIO109__FUNC_SDA5>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c6_pins: i2c6-default {
+		pins-bus {
+			pinmux = <PINMUX_GPIO110__FUNC_SCL6>,
+				 <PINMUX_GPIO111__FUNC_SDA6>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c7_pins: i2c7-default {
+		pins-bus {
+			pinmux = <PINMUX_GPIO112__FUNC_SCL7>,
+				 <PINMUX_GPIO113__FUNC_SDA7>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c8_pins: i2c8-default {
+		pins-bus {
+			pinmux = <PINMUX_GPIO114__FUNC_SCL8>,
+				 <PINMUX_GPIO115__FUNC_SDA8>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c9_pins: i2c9-default {
+		pins-bus {
+			pinmux = <PINMUX_GPIO117__FUNC_SCL9>,
+				 <PINMUX_GPIO116__FUNC_SDA9>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	eth_default: eth-default {
+		txd-pins {
+			pinmux = <PINMUX_GPIO12__FUNC_GBE_TXD3>,
+				 <PINMUX_GPIO13__FUNC_GBE_TXD2>,
+				 <PINMUX_GPIO14__FUNC_GBE_TXD1>,
+				 <PINMUX_GPIO15__FUNC_GBE_TXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		cc-pins {
+			pinmux = <PINMUX_GPIO20__FUNC_GBE_TXC>,
+				 <PINMUX_GPIO23__FUNC_GBE_TXEN>,
+				 <PINMUX_GPIO22__FUNC_GBE_RXDV>,
+				 <PINMUX_GPIO21__FUNC_GBE_RXC>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		rxd-pins {
+			pinmux = <PINMUX_GPIO16__FUNC_GBE_RXD3>,
+				 <PINMUX_GPIO17__FUNC_GBE_RXD2>,
+				 <PINMUX_GPIO18__FUNC_GBE_RXD1>,
+				 <PINMUX_GPIO19__FUNC_GBE_RXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		mdio-pins {
+			pinmux = <PINMUX_GPIO24__FUNC_GBE_MDC>,
+				 <PINMUX_GPIO25__FUNC_GBE_MDIO>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			input-enable;
+		};
+
+		power-pins {
+			pinmux = <PINMUX_GPIO27__FUNC_GPIO27>,
+				 <PINMUX_GPIO26__FUNC_GPIO26>;
+			output-high;
+		};
+	};
+
+	eth_sleep: eth-sleep {
+		txd-pins {
+			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>,
+				 <PINMUX_GPIO13__FUNC_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_GPIO14>,
+				 <PINMUX_GPIO15__FUNC_GPIO15>;
+		};
+
+		cc-pins {
+			pinmux = <PINMUX_GPIO20__FUNC_GPIO20>,
+				 <PINMUX_GPIO23__FUNC_GPIO23>,
+				 <PINMUX_GPIO22__FUNC_GPIO22>,
+				 <PINMUX_GPIO21__FUNC_GPIO21>;
+		};
+
+		rxd-pins {
+			pinmux = <PINMUX_GPIO16__FUNC_GPIO16>,
+				 <PINMUX_GPIO17__FUNC_GPIO17>,
+				 <PINMUX_GPIO18__FUNC_GPIO18>,
+				 <PINMUX_GPIO19__FUNC_GPIO19>;
+		};
+
+		mdio-pins {
+			pinmux = <PINMUX_GPIO24__FUNC_GPIO24>,
+				 <PINMUX_GPIO25__FUNC_GPIO25>;
+			input-disable;
+			bias-disable;
+		};
+	};
+};
+
+&usb {
+	status = "okay";
+};
+
+&ssusb {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_default_pins>;
+	maximum-speed = "high-speed";
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
+&u3phy0 {
+	status = "okay";
+};
+
+&xhci1 {
+	vbus-supply = <&usb_p1_vbus>;
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&mmc0 {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	hs400-ds-delay = <0x10100>;
+	cap-mmc-hw-reset;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	non-removable;
+	status = "okay";
+};
+
+&eth {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&phy>;
+	snps,reset = <&pio 28 0>;
+	snps,reset-delays-us = <0 10000 10000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&eth_default>;
+	pinctrl-1 = <&eth_sleep>;
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		phy: phy@0 {
+			compatible = "ethernet-phy-idc0ff.0421";
+			reg = <0>;
+		};
+	};
+};
diff --git a/arch/arm/dts/mt8366-genio-360-evk.dts b/arch/arm/dts/mt8366-genio-360-evk.dts
new file mode 100644
index 00000000000..1bf94e9512c
--- /dev/null
+++ b/arch/arm/dts/mt8366-genio-360-evk.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+/dts-v1/;
+
+#include "mt8366-genio-360-evk-common.dtsi"
+
+/ {
+	model = "MediaTek Genio-360 EVK";
+	compatible = "mediatek,genio-360-evk", "mediatek,mt8366";
+};

-- 
2.43.0

