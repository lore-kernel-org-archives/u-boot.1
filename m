Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D40F483F5
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 20:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69C19838BB;
	Mon, 23 Mar 2026 21:18:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eOUpwKk8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AC7E84065; Mon, 23 Mar 2026 21:18:12 +0100 (CET)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 055FE8407B
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 21:18:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-4138136f02eso328910fac.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 13:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774297088; x=1774901888;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b7eXhMpmC3+Z2WZpuLfWtYYOcYsHefRb0E57yeCCx24=;
 b=eOUpwKk8bvPuSQKT+B0J9P5j/yTk0kofepJKuI7j1gYlOD2ILtRc0ON2mH7mIhD1RZ
 q4Q4HlXA37IxYVxvzzYy2gteteeTZesjz19dIhJVwaB6U8J4ayJ6mv7W2KLP1xwIpmw9
 wRCE6gXrq+ESIA300ymZ3JCgPtdaPiQVabeMb+k+ltx/5B6dIr9nJmQ8FUbgYnONiz0I
 2LEubf8CIf7wTarmvApCQWEussNJxxrxkYSqVfWn5c/irgyaphRX43xYYIkkOhxeToPH
 u26YY4RYIN+/mqj62Pz1rNkL3tBcJyisikIStqceeh39p0dCNlQtOjX8DAzWbC02wMIY
 qWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774297088; x=1774901888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=b7eXhMpmC3+Z2WZpuLfWtYYOcYsHefRb0E57yeCCx24=;
 b=InU9QuULiEeZayOSPAoFOBhFWl7GEY1gy9EQXbjh3JjHJvdcntRKlqohKmH7c6UtVF
 fJOJnmSCzXr6pgCC9bOeFiNBHrhXGprJwxE60bpV4+5isiJ8HPoHHMd7QmDYY1sc1rA9
 ZAg1jPGFpPYq9zvfI0+wLktqZBtgFBHy8tnpK/cHZbIxUS6+KneaT5eF/NECqWAxs6ss
 vo7hQFBJQnlmaBZiIS5xFdz8oMyLsXWLigBLgCaLHQONcEhIQ+pq2fCVX/xlwf+j3WC0
 7a524rz1ZO6SLo5ZphRlIRmbM8WKdPWYJxC+KjH0dhGzaq4fCLxLw5TX8GE6GktDGsc4
 oSfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9YRqHOVGAPA46p8ckhTdZefV2tPpask4GG7Asc5czieC4NXmV10mErecdNA3OanKz+dL3pnk=@lists.denx.de
X-Gm-Message-State: AOJu0YyWNYU87h+RWbWf/YYmo2v0ysbadpghRWL0/GxYAfEirfPX9bHX
 8oBzU0bXPXgkavD5tLqSIRbEC7lBUDaFa8k+h85+EPRNE3Q1oGo2uZJbteWuZT79aUs=
X-Gm-Gg: ATEYQzzIt6NBWSc+aweUQ1FQay/10D/KkaYoqFQY+NJuQzrxN/kxAF7rShfs8apd8Sr
 lfUCBNqjlSWuKmjwIqdff3ODEca4fLlYqK4pOrwLuUhbGuwg/kKg1VSUn3ekx62PoPKszArTXUT
 /G01ZsTgcpMohKnNGVFciiPcCKRhYe2y23DUKF1h/AyU2Jb62Jy3edHv9AMcYm7s411en70JUVu
 k1FB2UFCLMPNpxz00xUqze+cR9bomv1bG2H4/zn6uKs3louV2ZUD7b0ulIv1fOXwneBIsqZsSM7
 0mnhyxQhTHJe8GeKSBm66/nSYdOfobhnKcAKtm+D2+Zr7UxfQRtutup6cqRXZUH9HA5+r0cBq3e
 fUGRNEBUYakplsIGMVH3iquLqw9qL1lUPwHnUqi5+1jbPNNwjAc/MSSLcf2bRitttI4Jeif6tBQ
 +a/gbaRLXgL+Ri4yiuc0PBQg+Vq5k=
X-Received: by 2002:a05:6870:9d9b:b0:417:3db8:830e with SMTP id
 586e51a60fabf-41c1113d65bmr9005979fac.27.1774297087528; 
 Mon, 23 Mar 2026 13:18:07 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:964:f712:dbc7:4119])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c148a5ca4sm11077540fac.3.2026.03.23.13.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:18:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 23 Mar 2026 15:16:56 -0500
Subject: [PATCH v3 5/6] arm: dts: mediatek: Add MediaTek Genio 520/720 EVK DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-mtk-mt8391-initial-support-v3-5-19dd92f4543f@baylibre.com>
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
In-Reply-To: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lukasz Majewski <lukma@denx.de>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6310; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=nTQqNl7T1BpixyaKj5jkNe0U7zhQQnGB/umDa70EmYM=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpwZ/rnZMhVrcg59e0oRJYIhE+2c26TVNa3sZ+u
 oFTVoX0qcqJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacGf6xYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A5i4H/0Yf2lMSwgRIWNM/mNIJ49ijPbBu+h1Z2ZuXK4n
 efeUaUdVrL7wqO9fWntpBh51hXuiUQwKTg4gjfLwFOSufhsCAd7MngQagBxVYfRMk/bQwfG2xNf
 w0kA98cIQHnZCJ0QQPUryMRWccLOqHHXb/KqKYzKfFG0Hvzf4DZr42OIckNMTrf6iorYQ5ROYvO
 z1WWoiBaTzTuGhHSFJVjApGAIDVzJQPc5ohS0cvwF/xJgSy/hcSn62XGU1WbpZAe5xr+ii/9Ghn
 sPINj0E4nrRIF2Qczltnil/thal1jcEAKGSjpuzxGcHK+Ck3xJP9UO7TcL82qxYT9UsdDX4sCan
 IkIw=
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

These boards are virtually identical (other than some camera
capabilities) so share mostly the same devicetree.

Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/Makefile                 |   2 +
 arch/arm/dts/mt8371-genio-520-evk.dts |  11 +++
 arch/arm/dts/mt8371-genio-common.dtsi | 176 ++++++++++++++++++++++++++++++++++
 arch/arm/dts/mt8391-genio-720-evk.dts |  11 +++
 4 files changed, 200 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index d90e02ca4e5..4085d4c2de1 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1124,6 +1124,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
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

