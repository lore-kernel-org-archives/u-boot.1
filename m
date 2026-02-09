Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00BBE7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 18:39:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23F1D83D71;
	Mon,  9 Feb 2026 19:39:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GSZU4fu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA0BE83C61; Mon,  9 Feb 2026 19:24:09 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BD888388D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 19:24:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4042cd2a336so15098fac.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 10:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770661445; x=1771266245;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SGXAHtFuPyP6daF5PIuRWrAUBh2VDgD1BSTwFi5hLD0=;
 b=GSZU4fu1ZCdWmEmRoVbJV9PokO+wE5xNwGXSXZssfJZqMZV+VXe0xsO8Xb8kdzCG/9
 fmjgckdu4T0p4BcUUW4zPEZmkg0XEX2v2EvADuBSiKZmDiXxaxra2cZei251j/dJ9yeV
 4obQaJbhBLYyK41Q4/fX7i1hzo7gznylyisSUqiT0PiG2t/tmB0nawquwds9M+A4LHEX
 UkHiUUVrPxiYilReKXcVK4hp0szqdGQVLA+JCdOy5ebelG46fhMdxmpHarz1VJbmNOe2
 2EPBhrcJXo/3k2RoUezIJ9a6QSEPeX+4LVmRgeh4KM/WqL3sFcoWnHytmgfhmK+WtaKZ
 hY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770661445; x=1771266245;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SGXAHtFuPyP6daF5PIuRWrAUBh2VDgD1BSTwFi5hLD0=;
 b=SNMVc3yvh250h8skIbXv7MXb9PAAegEzumPlqlw+ulIbIbcUxePjQLBNU67eLxcdmc
 aFOgPX6dn5/HPWo9EiEhVi4/5gpT2hOy7U91VY1jCRrWNYLlX85jY7vUhNB8oZGu9Wml
 r5k2A1kiyFq4vAcyBNYibRZ2YASLailooZtebfXGfe4mYwDOlDkHxKcXuGd2O/dNU9RY
 Co5q23g6AHeTQlOwh7uhWfumge6hmIegwh8DJmb2oIGA8xhwJQVLojXKaw3a5GeOJid6
 tObGdNKfiZUQn508x2/kKEJdMeG04te3qNn0qBy+7V/T43UbKy+qVJAyQTnv3Qd3ihP9
 8Oyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBOYst8pURPWn28irUKzBnDM0IkR1byEfwYJZuRROFB7oohcPa/HxBtjR/vaTuMNz2TVHeuqQ=@lists.denx.de
X-Gm-Message-State: AOJu0YyuYNIe+25fT38kQ19MADNlysq6qdzLQAIoJQ6SjZW+IOJzye9G
 7hozLXf/9ij+7ixdB8Pu8GuI9n0gINSEkkhCR0C5sRu4mrnJGj/41xy6hjcWWELOJNI=
X-Gm-Gg: AZuq6aLOSXdeGmW86ZH+jS437MZnEXdMUZOg+ZucH3EKpQIX59khV0OL1tv9Ih3mwT1
 g3iGrIAbfXIRjpI7/I6JhQDHmqucWtXhN1L3Ntv9esZqtB9v+drPYUt5lngIubzOKcnjBSG4F7z
 J3cCxi47mMt7BUAwue5/N2h6Kga+BA1sX2zwKrodirdZJl+mf8SEI3mS4HjC2vnRutbo1/1oR+1
 GzMidmIFZhJMLjn6kWv299Yd1AhckdF+PRVKD5uajqyZq0bI/74uQfAzpA+DiNgUlZ/bC26NlDU
 lF4f2RCCW4Nez+EoS4pxbyucSgBtARd2LAjT1Oa1glfy2w+T5+g9M/q31i63qDIFgaG735j2izM
 +FUA+7qbEYGX+WT46VimWJOl6KruZ+QOTQfqMGpHNWEWoqUybhbyAivIThmIuAdfXHhIacu5gDE
 DWqtBSR92GhlA/z9hrJhJcd3ujHTI=
X-Received: by 2002:a05:6870:8648:b0:404:b83:89c7 with SMTP id
 586e51a60fabf-40a970302a4mr6319243fac.44.1770661445055; 
 Mon, 09 Feb 2026 10:24:05 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cee0:eb0c:b683:ad1d])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40a99359eb4sm7993335fac.9.2026.02.09.10.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 10:24:04 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 09 Feb 2026 12:23:17 -0600
Subject: [PATCH 3/4] arm: dts: mediatek: Add MediaTek Genio 720 EVK DTS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-mtk-mt8391-initial-support-v1-3-b23ab9d0b9bc@baylibre.com>
References: <20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com>
In-Reply-To: <20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3366; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=42creTXXPM3kB8OIsOwO9y0M95QHurGmzYQzBF++GqA=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpiiYxeGREYwTWXtJtV50ARmZZx5Q84fgdhqk3W
 W1jv8SLbCuJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaYomMRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AYIYH/RxAvVkEuDmwoH2gNloEgNl9X2YEnDoohGKC2/n
 EtBLZgvRtUKG+dx+fp8TmHEbM6V2OE5bzP8a6BDozVgL30sq+FVsKnCvec52V/vdfkFKkSrDOID
 WEdBowui2aGmB64+2zUNgrZUxokdPdxjD/OalX0/A81AudaPkhkMX/BhXvZtnm4jExLEAXv1iqa
 J/T2YxzdXErP53d+CyIgiC1ksscdXnfyK5waJ8Gk7o1Fw2gDE6UVnQ0mf22Xd7oYaCUEqb2kUV2
 VrrlWelnn0FBRHCchXPR4Reop0Ev4L6AwA/ljyXENesCiXNWkgqgdsDRnUZGC5VVNLIhJSo5jUL
 9THg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Mon, 09 Feb 2026 19:39:13 +0100
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

Add a basic .dts file for MediaTek Genio 720 EVK. This will suffice
until an upstream devicetree is available from Linux.

Signed-off-by: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/dts/Makefile                 |   1 +
 arch/arm/dts/mt8391-genio-720-evk.dts | 111 ++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index 82ad3035308..2210e5236a1 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1133,6 +1133,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt7988-rfb.dtb \
 	mt7988-sd-rfb.dtb \
 	mt8183-pumpkin.dtb \
+	mt8391-genio-720-evk.dtb \
 	mt8512-bm1-emmc.dtb \
 	mt8516-pumpkin.dtb \
 	mt8518-ap1-emmc.dtb
diff --git a/arch/arm/dts/mt8391-genio-720-evk.dts b/arch/arm/dts/mt8391-genio-720-evk.dts
new file mode 100644
index 00000000000..9fea0ec7c1d
--- /dev/null
+++ b/arch/arm/dts/mt8391-genio-720-evk.dts
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ * Author: Macpaul Lin <macpaul.lin@mediatek.com>
+ */
+
+/dts-v1/;
+
+#include "mt8189.dtsi"
+
+/ {
+	model = "MediaTek Genio-720 EVK";
+	compatible = "mediatek,mt8391-evk", "mediatek,mt8391", "mediatek,mt8189";
+
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
+&mmc0 {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	hs400-ds-delay = <0x1481b>;
+	cap-mmc-hw-reset;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_1p8v>;
+	non-removable;
+	status = "okay";
+};

-- 
2.43.0

