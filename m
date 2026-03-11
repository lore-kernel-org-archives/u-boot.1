Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26876FD88D5
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 00:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1210B83FA4;
	Wed, 11 Mar 2026 01:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pvoYtxg7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BAEA84020; Wed, 11 Mar 2026 01:17:51 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9819084006
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 01:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d7412cfb9eso2443272a34.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773188267; x=1773793067;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d8uS5+mqLPGJdOOS3Fnic3Web1MykVYbO3ieYsplQnQ=;
 b=pvoYtxg7YaKzWlmNgipbrXf5Ozy/itu70kIvA/1MzfWtE5aGrP8i6xzy8EshIhYAZn
 KI6aYwBj3xieOgZKAF63zcDiSqSu1yzz4imk43YmNwAl+JOs5G4moV3gvzvsXi/4UaAl
 14opw/ttbpNpdvwe2MYQkR0pCzDqDqft4A15o8UAB95tXfa1XQ7dEKLV5gmrEuYt9e24
 8MLfHiCifln9H+HIRuiSRmykIaqNs+KU2OFQrQhU1EH+5Ah7GtYCA0xZrU0M/P9F/uWZ
 NSumKQPBGsI24/YhS4hVx7FrW1+IlNclOnXpzrS4GmazvOvjtDnh5JBsI6kCQDd4bKAG
 jA6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773188267; x=1773793067;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d8uS5+mqLPGJdOOS3Fnic3Web1MykVYbO3ieYsplQnQ=;
 b=PKOSccfcLTRaS3PoR2QYTPVJBP4/MF56FG2AwOcynKzFkVNj9GoAye0MigZIdD8/AA
 jNxD6r43aJqvwPL9bzvyfkqUK8R2gpA6XvQCJQZ0EqMLXAANjNw+kgmyfrA/nbnJ0/dJ
 hIQGE3b9w/SExIisEEOG1fnSzb2F252TEoimZ3MIT5BcWZ3WbEyianUsPXCmMLRdybb0
 vWDs8oQK/UvYD6KPYhqkObwFQJNGB4fKD+iqlL7tpzns/RQQ2xzIrtAEDbMa+psp5AYl
 cNgCK2Kyj8vGZpwCyioAuigP4Vknw/yGpV+hhS13ssP7TE45rF8a+JJ+VYppSbS6JnwF
 1PHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXXArXy5qLyhvrnESCu9cBPdieI+mxfnW5zIgPfe5ehPosmO+Ti2mO4q+JfZ0t66qXnvMHlPQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzBdvR+FpWDuFFJIIK4geqhgCGKnelJNfXn4muO6cAhYqxSfcLL
 mzkFXxNJj2s7gbuutrxlNSIAPDKgQkakY4EsPc0j9SRIKPVIBR+gIzbZcX/pSoU28z0=
X-Gm-Gg: ATEYQzwfX1xTZStgrZw7A7iICbs/rg0oQvyWVfrWAgaI7AmKzctOMxeGeYWCLN2jlWd
 EkohPo9Y+vpCwJzzQSnKIWMbZbAr4K1N1VrlL54dZHtsvtReLrgwxWX87z2u/gJ/Q2cI2RSMIN7
 k7iVr6Zmo2HocOLlH4J5FjxMDTuv2TeTdhoxy9gi4ys834AbhIBqatSRI0AJpfwSdrWSkBnT7JT
 OMrc1hJ2755hggnf+wGkYuCPZx+ZkoQ9nNpRriaqquNFcXs1uwlFvufyWbwIRZcT7XbAIFQJDjO
 tZNJ2Vio14b56HUYqDjxGWYfIjkt6m8zFdpWnu7mIraUbpfjzW/l9eGzUT8PE8k1GOYU1PhJDzc
 yrkHmENGWse7GdsomzqJDNH9aOerr9YHBNETFH8RA3cr4T/Mmakg+cv4Renylzxdb7eo0QzwEk4
 SD0rJNTep0pdJ6dXaAPjCX08uIAWQdlPvbmbNroew=
X-Received: by 2002:a05:6830:4423:b0:7cf:db0f:c824 with SMTP id
 46e09a7af769-7d76a8f7b6amr646036a34.32.1773188267320; 
 Tue, 10 Mar 2026 17:17:47 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:82ac:f3fe:2e5f:ec03])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae6a361sm466304a34.20.2026.03.10.17.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 17:17:46 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 10 Mar 2026 19:16:54 -0500
Subject: [PATCH v2 5/6] arm: dts: mediatek: Add MediaTek Genio 520/720 EVK DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-mtk-mt8391-initial-support-v2-5-1dc862d58532@baylibre.com>
References: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
In-Reply-To: <20260310-mtk-mt8391-initial-support-v2-0-1dc862d58532@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6308; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=rhZBXNdteODHNaZjsYLHFcW1Moo8duERbGfBz2Rvaao=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpsLSY9p6ymMJ2cEjnXZ8tagzfzvGJZ7PbH9SKo
 O5B34w1xS+JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabC0mBYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/Ah6EIAIb96mLNo83QqWbQn1ba2MxsC23MCbnCjjQ5JL5
 j2O9whXWwSU18c3rG72HlbSZRD1XU8TItqScxuqoxkaS44zT3/1wPr9CgiWLITEwe5xCqjbQr7z
 qKpiODYlci11aGk+ZlV7F3k/nnAfb8isId2VEIOpyeMh6Y6vx2EEY9I3HRA5gvu/ixTD+D8xRvf
 DYkdVDM0bK8avk4VBj8iPRuc3tZRbQsZT2Pr7wbtrVY5NuPJh1HtPIcuH03afJFFlfmRAnttYaV
 zikSk15oF5Vjz+CIO0FlyQk+D19pVKRKowWGuu6XgZponWtzWmcy1jGw6LKildp/9a9z9ybLrbm
 GedM=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

From: Chris-QJ Chen <chris-qj.chen@mediatek.com>

Add a basic .dts file for MediaTek Genio 520/720 EVKs. This will suffice
until an upstream devicetree is available from Linux.

These boards a virtually identical (other than some camera capabilities)
so share mostly the same devicetree.

Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/Makefile                 |   2 +
 arch/arm/dts/mt8371-genio-520-evk.dts |  11 +++
 arch/arm/dts/mt8371-genio-common.dtsi | 176 ++++++++++++++++++++++++++++++++++
 arch/arm/dts/mt8391-genio-720-evk.dts |  11 +++
 4 files changed, 200 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 264b13b6f5d..bd0f0fd7018 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1135,6 +1135,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7988-rfb.dtb \
 	mt7988-sd-rfb.dtb \
 	mt8183-pumpkin.dtb \
+	mt8371-genio-520-evk.dtb \
+	mt8391-genio-720-evk.dtb \
 	mt8512-bm1-emmc.dtb \
 	mt8516-pumpkin.dtb \
 	mt8518-ap1-emmc.dtb
diff --git a/arch/arm/dts/mt8371-genio-520-evk.dts b/arch/arm/dts/mt8371-genio-520-evk.dts
new file mode 100644
index 00000000000..1ed325eb587
--- /dev/null
+++ b/arch/arm/dts/mt8371-genio-520-evk.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+
+#include "mt8189.dtsi"
+#include "mt8371-genio-common.dtsi"
+
+/ {
+	model = "MediaTek Genio-520 EVK";
+	compatible = "mediatek,mt8371-evk", "mediatek,mt8371", "mediatek,mt8189";
+};
diff --git a/arch/arm/dts/mt8371-genio-common.dtsi b/arch/arm/dts/mt8371-genio-common.dtsi
new file mode 100644
index 00000000000..c6aa22b7d10
--- /dev/null
+++ b/arch/arm/dts/mt8371-genio-common.dtsi
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+#include "mt8189.dtsi"
+#include "mt8189-pinfunc.h"
+#include "mt6359.dtsi"
+
+/ {
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+
+		psci {
+			compatible = "arm,psci-1.0";
+			method = "smc";
+		};
+	};
+
+	memory@40000000 {
+		/* 8GB */
+		device_type = "memory";
+		reg = <0 0x40000000 0x2 0x00000000>;
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
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-0 = <&uart0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
+&mmc0 {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	hs400-ds-delay = <0x1481b>;
+	cap-mmc-hw-reset;
+	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
+	non-removable;
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_default_pins>;
+	pinctrl-1 = <&mmc0_uhs_pins>;
+	status = "okay";
+};
+
+&mt6359_vufs_ldo_reg {
+	regulator-always-on;
+};
+
+&pio {
+	mmc0_default_pins: mmc0-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
+			drive-strength = <6>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO166__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
+			drive-strength = <6>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
+		};
+	};
+
+	mmc0_uhs_pins: mmc0-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO162__FUNC_MSDC0_CLK>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO166__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO165__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO164__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO163__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO159__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO158__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO157__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO156__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO161__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <8>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO167__FUNC_MSDC0_DSL>;
+			drive-strength = <8>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO160__FUNC_MSDC0_RSTB>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_00>;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO31__FUNC_UTXD0>,
+				 <PINMUX_GPIO32__FUNC_URXD0>;
+			bias-pull-up;
+		};
+	};
+};
+
+&pmic {
+	interrupts-extended = <&pio 194 IRQ_TYPE_LEVEL_HIGH>;
+};
diff --git a/arch/arm/dts/mt8391-genio-720-evk.dts b/arch/arm/dts/mt8391-genio-720-evk.dts
new file mode 100644
index 00000000000..c8e57433ce6
--- /dev/null
+++ b/arch/arm/dts/mt8391-genio-720-evk.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/dts-v1/;
+
+#include "mt8189.dtsi"
+#include "mt8371-genio-common.dtsi"
+
+/ {
+	model = "MediaTek Genio-720 EVK";
+	compatible = "mediatek,mt8391-evk", "mediatek,mt8391", "mediatek,mt8189";
+};

-- 
2.43.0

