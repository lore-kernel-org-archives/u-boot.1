Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB252C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 17:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB11A80F68;
	Thu, 20 Feb 2025 18:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H3ZOcIvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F05280FAC; Thu, 20 Feb 2025 18:07:01 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2408080F68
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 18:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5452efeb87aso1205494e87.3
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 09:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740071218; x=1740676018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hUys0XUJWjyUnQvzZ1JeCdLeqkF2lB4EjxDY4GgGnfw=;
 b=H3ZOcIvJgNnKEg9ECjd+SXSkbeZDrHCBCB1GFb5z4Aw9btaLcXlo4Q+JQhAPYh3NCT
 QcVd7stERtdtRiR22dxj6oiimivr5bjIEZPKbuCgvPbY6cos9MaeYO5lTSt6OBhrHrAm
 NCrT9GsYxYgf2M0siN+oMopaekdjW1xrLcBaOU+muaRfr60uFonDBWcW4R3VffZSLId7
 RpWfqH3DzOMDMKJV1J/8mg4kOsE1eu1iFsCI1QZtcfjnAPnMst4jrpkime03ny9PjPi+
 KV88HmHTMOKxsC7MHFhQq/0ViC21EULF8jR7At8b0elvsMl1HC3T8kYh2H9eCyouN5V+
 Vofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740071218; x=1740676018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUys0XUJWjyUnQvzZ1JeCdLeqkF2lB4EjxDY4GgGnfw=;
 b=OgxNx+Kr35j6jHY8XYgZQ/PsBNX6q4zW/s5jqW3cffwej5WFYm2zEB5mlfHRiwhGc9
 fHOoRkN+d/te55mIJ5n0eMdttYjQEVPa6hSYL/hJQVAlL7NtNv6NZlMpQkCDffXGKxWS
 ouLlS2dnGcOU/BzF10vIQikFuBHHcnffNqspRUOc7uuNrPogY2W3cBpopQCzky3rZ2Lu
 2Tofz8k5pYAl+yNfhU/kxD42qoEdMef/w3+77WHLOfXGAjvM7DKQ+4g+KvXvy+ul3sB8
 raKfBJMsz4kcPdQo7spqhNCbdKJO/9iK0gzvqBmtBT9ll1t4WyQjxtutITg9GOMd5QJR
 x7Fg==
X-Gm-Message-State: AOJu0YzYyyEXB8eW3EMdR+L/n31vVz3UOcwEaFs2EHXpD8IebHP2Cktq
 ALITL9cREL6SlxW6rWaAZLTlO1c4z8FEuRSw3h3u6YGDoUGRmr3L
X-Gm-Gg: ASbGncuUnFaGqNnI1AsasfVca57rlxhUvmNOIXkk/azfsLobRVybjOwhVUrrPIJ+ZFD
 ad4RWpXSBRWY72xiaFfaSR2JHXA/Gm2XSdp13hIaKp4uihOF0RFM/7voFHnhwc33NHF6qgHCOtl
 7eSHQ0RqTehOAEhInsd9ohbtjGufEul74sSP3/ZbaCi0OIveFmnOhkLan5Ccq7Ppuk8fJPhqaAA
 phtk7ySrXDAH+cqM9kJAVaT/ZV9+I4glvQdBsVlv2XqbUST0UdHok7VEvuw8Ix7aJ6spY1cPuuP
 813kRuI=
X-Google-Smtp-Source: AGHT+IFAWONDua5jPltmSLMzQCdNGSKhDpNYHQgemiWOtKKGO7xSed4r/PqEJzfAK4415ekt9NOvUQ==
X-Received: by 2002:a05:6512:3052:b0:542:9757:d5df with SMTP id
 2adb3069b0e04-5462eee68d1mr3116763e87.21.1740071218077; 
 Thu, 20 Feb 2025 09:06:58 -0800 (PST)
Received: from xeon.. ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-547df6106f6sm81828e87.204.2025.02.20.09.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 09:06:57 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Heiko Schocher <hs@denx.de>, Guillaume La Roque <glaroque@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 3/3] test: dm: add video bridge tests
Date: Thu, 20 Feb 2025 19:06:29 +0200
Message-ID: <20250220170629.228485-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220170629.228485-1-clamor95@gmail.com>
References: <20250220170629.228485-1-clamor95@gmail.com>
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

Add tests for video bridge ops.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/sandbox/dts/test.dts | 46 +++++++++++++++++++++++++++
 configs/sandbox_defconfig |  2 ++
 test/dm/Makefile          |  1 +
 test/dm/video_bridge.c    | 67 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 116 insertions(+)
 create mode 100644 test/dm/video_bridge.c

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 80291958533..52e9ddbf50f 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1047,6 +1047,31 @@
 		};
 	};
 
+	lvds-encoder {
+		compatible = "lvds-encoder";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				bridge_input: endpoint {
+					/* link to output */
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				bridge_output: endpoint {
+					remote-endpoint = <&panel_input>;
+				};
+			};
+		};
+	};
+
 	wdt-gpio-toggle {
 		gpios = <&gpio_a 8 0>;
 		compatible = "linux,wdt-gpio";
@@ -1402,6 +1427,27 @@
 	panel {
 		compatible = "simple-panel";
 		backlight = <&backlight 0 100>;
+
+		display-timings {
+			timing@0 {
+				/* 1280x800@60Hz */
+				clock-frequency = <68000000>;
+				hactive = <1280>;
+				hfront-porch = <48>;
+				hback-porch = <18>;
+				hsync-len = <30>;
+				vactive = <800>;
+				vfront-porch = <3>;
+				vback-porch = <12>;
+				vsync-len = <5>;
+			};
+		};
+
+		port {
+			panel_input: endpoint {
+				remote-endpoint = <&bridge_output>;
+			};
+		};
 	};
 
 	scsi {
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 7b35ad8a88f..396c58c5658 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -328,6 +328,8 @@ CONFIG_USB_ETH_CDC=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_FONT_SUN12X22=y
 CONFIG_VIDEO_COPY=y
+CONFIG_VIDEO_BRIDGE=y
+CONFIG_VIDEO_BRIDGE_LVDS_CODEC=y
 CONFIG_CONSOLE_ROTATION=y
 CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_TRUETYPE_CANTORAONE=y
diff --git a/test/dm/Makefile b/test/dm/Makefile
index e44f3d89e77..3afcc26ca57 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -63,6 +63,7 @@ obj-$(CONFIG_SOUND) += i2s.o
 obj-$(CONFIG_CLK_K210_SET_RATE) += k210_pll.o
 obj-$(CONFIG_IOMMU) += iommu.o
 obj-$(CONFIG_LED) += led.o
+obj-$(CONFIG_VIDEO_BRIDGE_LVDS_CODEC) += video_bridge.o
 obj-$(CONFIG_DM_MAILBOX) += mailbox.o
 obj-$(CONFIG_DM_MDIO) += mdio.o
 obj-$(CONFIG_DM_MDIO_MUX) += mdio_mux.o
diff --git a/test/dm/video_bridge.c b/test/dm/video_bridge.c
new file mode 100644
index 00000000000..f55a333c0b8
--- /dev/null
+++ b/test/dm/video_bridge.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Test for video bridge uclass
+ *
+ * Copyright (c) 2025 Svyatoslav Ryhel <clamor95@gmail.com>
+ */
+
+#include <backlight.h>
+#include <dm.h>
+#include <panel.h>
+#include <video.h>
+#include <video_bridge.h>
+#include <asm/gpio.h>
+#include <asm/test.h>
+#include <dm/test.h>
+#include <power/regulator.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/* Basic test of the video uclass, test is based on driven panel */
+static int dm_test_video_bridge(struct unit_test_state *uts)
+{
+	struct udevice *dev, *pwm, *gpio, *reg;
+	uint period_ns, duty_ns;
+	bool enable, polarity;
+	struct display_timing timing;
+
+	ut_assertok(uclass_first_device_err(UCLASS_VIDEO_BRIDGE, &dev));
+	ut_assertok(uclass_get_device_by_name(UCLASS_PWM, "pwm", &pwm));
+	ut_assertok(uclass_get_device(UCLASS_GPIO, 1, &gpio));
+	ut_assertok(regulator_get_by_platname("VDD_EMMC_1.8V", &reg));
+	ut_assertok(sandbox_pwm_get_config(pwm, 0, &period_ns, &duty_ns,
+					   &enable, &polarity));
+	ut_asserteq(false, enable);
+	ut_asserteq(true, regulator_get_enable(reg));
+
+	/* bridge calls panel_enable_backlight() of panel */
+	ut_assertok(video_bridge_attach(dev));
+	ut_assertok(sandbox_pwm_get_config(pwm, 0, &period_ns, &duty_ns,
+					   &enable, &polarity));
+	ut_asserteq(1000, period_ns);
+	ut_asserteq(170 * 1000 / 255, duty_ns);
+	ut_asserteq(true, enable);
+	ut_asserteq(false, polarity);
+	ut_asserteq(1, sandbox_gpio_get_value(gpio, 1));
+	ut_asserteq(true, regulator_get_enable(reg));
+
+	/* bridge calls panel_set_backlight() of panel */
+	ut_assertok(video_bridge_set_backlight(dev, BACKLIGHT_DEFAULT));
+	ut_assertok(sandbox_pwm_get_config(pwm, 0, &period_ns, &duty_ns,
+					   &enable, &polarity));
+	ut_asserteq(true, enable);
+	ut_asserteq(170 * 1000 / 255, duty_ns);
+
+	/* bridge should be active */
+	ut_assertok(video_bridge_set_active(dev, true));
+
+	/* bridge is internal and has no hotplug gpio */
+	ut_asserteq(-ENOENT, video_bridge_check_attached(dev));
+
+	/* check passing timings and EDID */
+	ut_assertok(video_bridge_get_display_timing(dev, &timing));
+	ut_assertok(video_bridge_read_edid(dev, NULL, 0));
+
+	return 0;
+}
+DM_TEST(dm_test_video_bridge, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.43.0

