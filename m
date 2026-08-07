Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9087CC5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 16:13:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 59A5581368;
	Fri,  7 Aug 2026 16:13:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p7QjqxBXeYWX; Fri,  7 Aug 2026 16:13:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 218038136F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786119218;
	bh=av5fAPgPaRGANUeoGVkmVjHcp95aiZjsj89RpNJLBFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RZ2KRBBc6AYHuXPD+TNnXukxPF4R13AOkCQz0JjC7yYOaWI/qnrG1VzTCq42xXoB8
	 DdCuGguYk0aOnnh08GQhfR2h2orQkkZAJ2mbaOoadfWzfiUeuPN/HJv6zZezFwvD6A
	 l+iyQGjPWRnF50cpKoj3xKHKL04GMP0Gi9vVpB6hgv206N1B4Vgm4pdNGIhGZDQFef
	 jOBCwyaHwrfPFH6xy0kZGdd/zv1fl6tvuPixcSwvwmGXUTReys1vaqo0VYRIZDuVz2
	 IsA79r1iD5f9UkKNY1AMK3NxGqKk/0dzLZSmHyfrQc6l1wHnhPmmG+NRLWmvYsa1qA
	 0+ribIH3kiZXQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 218038136F;
	Fri,  7 Aug 2026 16:13:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8DEF8D3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FF70607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MRjskmip1k9N for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 16:13:33 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::333; helo=mail-ot1-x333.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2E150607E6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2E150607E6
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2E150607E6
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 16:13:33 +0000 (UTC)
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-7ec3b429a3aso2545463a34.1
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 09:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786119212; x=1786724012;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=av5fAPgPaRGANUeoGVkmVjHcp95aiZjsj89RpNJLBFA=;
 b=neLLpt5TnezbaJ4VqIQtCk9BjIaXAn1BwXhu9k6uTBQBra+RgFJNwUHPIvGzdn+aya
 9C3X1GD66kMe1c99vjcLK8bg/FUOVP5SZyH+9azf2HWFumSZLWVM3039Y9yAGTwmZGuK
 CIN9slqr+nquGXOwea3eWf7EPVkgThqj/DhnxhsrH4ulCs+x3LZJc3otAcA29v89y8If
 bhgdS1TL1x1RHYoCyzSEVBt+rMklaehOOXrH98QYXMRWm4vSuLVsE1pGW1Xr2Cq9sRru
 nDZViSEBjy+IoNAdq6KRBNylDo4FDrEEC4T/JTfMXmS36ljeznP2swctfe8u6RPGC8dV
 xFAg==
X-Gm-Message-State: AOJu0YzNc833hN2Edw3kMO52k98Yp6pCHyHRuudTVU1HTLfMJaovAsYn
 oBJtTDc4BEsErkQVfey/9mdSIN5HZbfmQqjh1ng/M7GkTTMV62NLDbvabtz3SzGrxq0=
X-Gm-Gg: AR+sD10KXifTJLnz/D9P0tTTs2hID4KruM31sbQdxd+KJsoofXBw9JSbpD9uR/ovNIh
 CbKracfedtL77wwsKa/ZXSoOYvogA6wtU/hNBGAoeNEkaf/MKL1iRUk1kKubbIaU45ptZwEUhHi
 etPdW2CViHjWM6WohGNlW3iLtMxRQs5nJS/F4NTxNYBMpQuOIjfwGIlqoJSNvhoCYF+Khtr4aIn
 YzuehcfioPRisFuNgmWbxHujM1ovcz26tKQqTZNsnZ6pVtw60CxfOv6UjOA8tU0/9cVjct9Qsj/
 X47KH7kEnN/z45FCfdQFRDCA6Y6cy339H9vwSOyXAC2He1d9eTktfrr0GZ+QZ6msGsE4GPwnk4X
 9oSOr0pAHRNJYtKl634/qt+hXNIFLyuaVJcI+ttU1kPqzRZ2OEOdb41fBp7h0QhpaFuKtzDJJl5
 YaBDXesVmn3Rp0gicpHH1ho5/CEP2VXrplxltrPc3J8HtqUxsORZgVTjRHCJX6ReV3
X-Received: by 2002:a05:6830:3913:b0:7e6:d0ad:5254 with SMTP id
 46e09a7af769-7f1e5d8da15mr17669350a34.8.1786119212011; 
 Fri, 07 Aug 2026 09:13:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b7b9678sm1537878a34.21.2026.08.07.09.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 09:13:31 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Aug 2026 11:12:53 -0500
Subject: [PATCH v2 3/4] arm: dts: mediatek: add Genio 360 EVK
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-mtk-genio-360-bringup-v2-3-7c3830297d97@baylibre.com>
References: <20260807-mtk-genio-360-bringup-v2-0-7c3830297d97@baylibre.com>
In-Reply-To: <20260807-mtk-genio-360-bringup-v2-0-7c3830297d97@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=14225;
 i=dlechner@baylibre.com; h=from:subject:message-id;
 bh=n6C8MMvty47YgPVL1XWWq2IYvMbloQ/bQ1gmpKnIgMc=;
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdgQbQPFxToEpts3kAEFfqg7jCvjpomft5E3fG
 PboqXVuRHSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYEGxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ApPgH/jZ3/zr40k9RK7SzmTCetKPhauhFERPLnK9Z71F
 iynijWkRPGGpVM9cvTccKBIUCnsevqfdDkfyEWNB0YC9Vt3a2m1yjXK8LbilV201Zu0nnCAIf9B
 N81VID91gYI2rFgRzpHsxm7JN18dlOX+IjTsQ5RG/ZV7yXEHlDQi9eoi7YjTbpMcswXO963vyqT
 +QnRBbcRZEsALcXQ4ppv3L6xPETpFWSX0aLw8tYok0PYM1a+oL1GTMJa0j1squjD+rJYdL33DyK
 wIpr8htaMza6Ap+8Px2VrZkjU/dKImC0QZVRIJYDSWav6N9HbUKnpGoalbWtt8QNMoj8R8ajtE0
 oH7Q=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786119212; x=1786724012;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=av5fAPgPaRGANUeoGVkmVjHcp95aiZjsj89RpNJLBFA=;
 b=i23algI92hdg+mUtzeqGdNt/4HgLxM8At3UXt3pnNLDrAIaGcr07rO5+DfhU2OhVjq
 pKDxBiBarS4iaauQxZIJZSoz1JqwhkPJsT/VX2pwbErukdKykq49ThiFab5vT4UFSmX6
 iSpu1b/XUbAL7ZYME5Gq65aKw1wOYzpSFU/U8yz4NaRhYnCNYp8zEQF4qRHT2Xniy5FA
 LKOFAdpVhA1ixAj5ZT2OsqRMmw2WU3OWzKtwvPupbV9BK/Xy+BpPRGEuHT2m7RlrBTK+
 gWUk9njkMpbyD/tk0jSQZOq1lnK0Xu6rmmPJBDDw46PtEnQUU5DiIxL8wTYi8y67lyKC
 IIKQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=i23algI9
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
 arch/arm/dts/mt8366-genio-360-evk-common.dtsi | 564 ++++++++++++++++++++++++++
 arch/arm/dts/mt8366-genio-360-evk.dts         |  14 +
 3 files changed, 579 insertions(+)

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
index 00000000000..b73d337ed64
--- /dev/null
+++ b/arch/arm/dts/mt8366-genio-360-evk-common.dtsi
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+#include "mt8366.dtsi"
+#include "mt6366.dtsi"
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
+	usb_p0_vbus: regulator-usb-p0-vbus {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 53 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	usb_p1_vbus: regulator-usb-p1-vbus {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&pio 55 GPIO_ACTIVE_HIGH>;
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
+&snor {
+	pinctrl-names = "default";
+	pinctrl-0 = <&snor_pins>;
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
+&pio {
+	mmc0_pins_default: mmc0-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO127__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO128__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO129__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO130__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO131__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO132__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO133__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO124__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO125__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_pins_uhs: mmc0-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO123__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO127__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO128__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO129__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO130__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO131__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO132__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO133__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO124__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO125__FUNC_MSDC0_RSTB>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_default: mmc1-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO134__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO136__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO137__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO138__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO139__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO135__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO2__FUNC_GPIO2>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_pins_uhs: mmc1-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO134__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO136__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO137__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO138__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO139__FUNC_MSDC1_DAT3>,
+				 <PINMUX_GPIO135__FUNC_MSDC1_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO2__FUNC_GPIO2>;
+			bias-pull-up;
+		};
+	};
+
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
+	snor_pins: snor-pins {
+		pins0 {
+			pinmux = <PINMUX_GPIO57__FUNC_SPINOR_CK>,
+				 <PINMUX_GPIO59__FUNC_SPINOR_IO0>,
+				 <PINMUX_GPIO60__FUNC_SPINOR_IO1>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down;
+		};
+
+		pins-cs {
+			pinmux = <PINMUX_GPIO58__FUNC_SPINOR_CS>,
+				 <PINMUX_GPIO61__FUNC_SPINOR_IO2>,
+				 <PINMUX_GPIO62__FUNC_SPINOR_IO3>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up;
+		};
+	};
+
+	i2c0_pins: i2c0-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO98__FUNC_SCL0>,
+				 <PINMUX_GPIO99__FUNC_SDA0>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c1_pins: i2c1-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO100__FUNC_SCL1>,
+				 <PINMUX_GPIO101__FUNC_SDA1>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c2_pins: i2c2-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO102__FUNC_SCL2>,
+				 <PINMUX_GPIO103__FUNC_SDA2>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c3_pins: i2c3-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO104__FUNC_SCL3>,
+				 <PINMUX_GPIO105__FUNC_SDA3>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c4_pins: i2c4-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO106__FUNC_SCL4>,
+				 <PINMUX_GPIO107__FUNC_SDA4>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c5_pins: i2c5-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO108__FUNC_SCL5>,
+				 <PINMUX_GPIO109__FUNC_SDA5>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c6_pins: i2c6-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO110__FUNC_SCL6>,
+				 <PINMUX_GPIO111__FUNC_SDA6>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c7_pins: i2c7-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO112__FUNC_SCL7>,
+				 <PINMUX_GPIO113__FUNC_SDA7>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c8_pins: i2c8-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO114__FUNC_SCL8>,
+				 <PINMUX_GPIO115__FUNC_SDA8>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	i2c9_pins: i2c9-default-pins {
+		pins-bus {
+			pinmux = <PINMUX_GPIO117__FUNC_SCL9>,
+				 <PINMUX_GPIO116__FUNC_SDA9>;
+			bias-pull-up = <MTK_PULL_SET_RSEL_111>;
+		};
+	};
+
+	eth_default: eth-default-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO12__FUNC_GBE_TXD3>,
+				 <PINMUX_GPIO13__FUNC_GBE_TXD2>,
+				 <PINMUX_GPIO14__FUNC_GBE_TXD1>,
+				 <PINMUX_GPIO15__FUNC_GBE_TXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-cc {
+			pinmux = <PINMUX_GPIO20__FUNC_GBE_TXC>,
+				 <PINMUX_GPIO23__FUNC_GBE_TXEN>,
+				 <PINMUX_GPIO22__FUNC_GBE_RXDV>,
+				 <PINMUX_GPIO21__FUNC_GBE_RXC>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO16__FUNC_GBE_RXD3>,
+				 <PINMUX_GPIO17__FUNC_GBE_RXD2>,
+				 <PINMUX_GPIO18__FUNC_GBE_RXD1>,
+				 <PINMUX_GPIO19__FUNC_GBE_RXD0>;
+			drive-strength = <MTK_DRIVE_8mA>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO24__FUNC_GBE_MDC>,
+				 <PINMUX_GPIO25__FUNC_GBE_MDIO>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			input-enable;
+		};
+
+		pins-power {
+			pinmux = <PINMUX_GPIO27__FUNC_GPIO27>,
+				 <PINMUX_GPIO26__FUNC_GPIO26>;
+			output-high;
+		};
+	};
+
+	eth_sleep: eth-sleep-pins {
+		pins-txd {
+			pinmux = <PINMUX_GPIO12__FUNC_GPIO12>,
+				 <PINMUX_GPIO13__FUNC_GPIO13>,
+				 <PINMUX_GPIO14__FUNC_GPIO14>,
+				 <PINMUX_GPIO15__FUNC_GPIO15>;
+		};
+
+		pins-cc {
+			pinmux = <PINMUX_GPIO20__FUNC_GPIO20>,
+				 <PINMUX_GPIO23__FUNC_GPIO23>,
+				 <PINMUX_GPIO22__FUNC_GPIO22>,
+				 <PINMUX_GPIO21__FUNC_GPIO21>;
+		};
+
+		pins-rxd {
+			pinmux = <PINMUX_GPIO16__FUNC_GPIO16>,
+				 <PINMUX_GPIO17__FUNC_GPIO17>,
+				 <PINMUX_GPIO18__FUNC_GPIO18>,
+				 <PINMUX_GPIO19__FUNC_GPIO19>;
+		};
+
+		pins-mdio {
+			pinmux = <PINMUX_GPIO24__FUNC_GPIO24>,
+				 <PINMUX_GPIO25__FUNC_GPIO25>;
+			input-disable;
+			bias-disable;
+		};
+	};
+};
+
+&ssusb {
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_default_pins>;
+	role-switch-default-mode = "peripheral";
+	wakeup-source;
+	status = "okay";
+};
+
+&usb_host0 {
+	status = "okay";
+};
+
+&usb_host1 {
+	vbus-supply = <&usb_p1_vbus>;
+	wakeup-source;
+	status = "okay";
+};
+
+&usb_host2 {
+	status = "okay";
+};
+
+&u3phy0 {
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&u2phy2 {
+	status = "okay";
+};
+
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	supports-cqe;
+	mmc-hs400-enhanced-strobe;
+	hs400-ds-delay = <0x10100>;
+	cap-mmc-hw-reset;
+	vmmc-supply = <&mt6366_vemc_reg>;
+	vqmmc-supply = <&mt6366_vio18_reg>;
+	no-sdio;
+	no-sd;
+	non-removable;
+};
+
+&mmc1 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_pins_default>;
+	pinctrl-1 = <&mmc1_pins_uhs>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	cd-gpios = <&pio 94 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&mt6366_vmch_reg>;
+	vqmmc-supply = <&mt6366_vmc_reg>;
+	no-sdio;
+	no-mmc;
+};
+
+&eth {
+	phy-mode = "rgmii-rxid";
+	phy-handle = <&phy>;
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

